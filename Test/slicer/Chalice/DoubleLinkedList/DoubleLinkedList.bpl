
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
var SecMask: MaskType where IsGoodMask(SecMask);
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

function IsGoodState(PartialHeapType) returns (bool);
function combine(PartialHeapType, PartialHeapType) returns (PartialHeapType);
function heapFragment<T>(T) returns (PartialHeapType);
type PartialHeapType;
const emptyPartialHeap: PartialHeapType;

axiom (forall a: PartialHeapType, b: PartialHeapType :: {IsGoodState(combine(a, b))} IsGoodState(combine(a, b)) <==> IsGoodState(a) && IsGoodState(b));
axiom IsGoodState(emptyPartialHeap);

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
function Acquire$SecMask(int) returns (MaskType);
function Acquire$Credits(int) returns (CreditsType);
axiom NonPredicateField(held);

function LastSeen$Heap(Mu, int) returns (HeapType);
function LastSeen$Mask(Mu, int) returns (MaskType);
function LastSeen$SecMask(Mu, int) returns (MaskType);
function LastSeen$Credits(Mu, int) returns (CreditsType);

const unique rdheld: Field bool;
axiom NonPredicateField(rdheld);
function wf(h: HeapType, m: MaskType, sm: MaskType) returns (bool);

function IsGoodInhaleState(ih: HeapType, h: HeapType,
                           m: MaskType, sm: MaskType) returns (bool)
{
  (forall<T> o: ref, f: Field T :: { ih[o, f] }  CanRead(m, sm, o, f) ==> ih[o, f] == h[o, f]) &&
  (forall o: ref :: { ih[o, held] }  (0<ih[o, held]) == (0<h[o, held])) &&
  (forall o: ref :: { ih[o, rdheld] }  ih[o, rdheld] == h[o, rdheld]) &&
  (forall o: ref :: { h[o, held] }  (0<h[o, held]) ==> ih[o, mu] == h[o, mu]) &&
  (forall o: ref :: { h[o, rdheld] }  h[o, rdheld] ==> ih[o, mu] == h[o, mu])
}
function IsGoodExhaleState(eh: HeapType, h: HeapType,
                           m: MaskType, sm: MaskType) returns (bool)
{
  (forall<T> o: ref, f: Field T :: { eh[o, f] }  CanRead(m, sm, o, f) ==> eh[o, f] == h[o, f]) &&
  (forall o: ref :: { eh[o, held] }  (0<eh[o, held]) == (0<h[o, held])) &&
  (forall o: ref :: { eh[o, rdheld] }  eh[o, rdheld] == h[o, rdheld]) &&
  (forall o: ref :: { h[o, held] }  (0<h[o, held]) ==> eh[o, mu] == h[o, mu]) &&
  (forall o: ref :: { h[o, rdheld] }  h[o, rdheld] ==> eh[o, mu] == h[o, mu]) &&
  (forall o: ref :: { h[o, forkK] } { eh[o, forkK] } h[o, forkK] == eh[o, forkK]) &&
  (forall o: ref :: { h[o, held] } { eh[o, held] } h[o, held] == eh[o, held]) &&
  (forall o: ref, f: Field int :: { eh[o, f], PredicateField(f) } PredicateField(f) ==> h[o, f] <= eh[o, f])
}

// ---------------------------------------------------------------
// -- Permissions ------------------------------------------------
// ---------------------------------------------------------------

function {:expand false} CanRead<T>(m: MaskType, sm: MaskType, obj: ref, f: Field T) returns (bool)
{
  0 <  m[obj,f][perm$R] || 0 <  m[obj,f][perm$N] ||
  0 < sm[obj,f][perm$R] || 0 < sm[obj,f][perm$N]
}
function {:expand false} CanReadForSure<T>(m: MaskType, obj: ref, f: Field T) returns (bool)
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

axiom (forall h: HeapType, m, sm: MaskType, o: ref, q: ref :: {wf(h, m, sm), h[o, mu], h[q, mu]} wf(h, m, sm) && o!=q && (0 < h[o, held] || h[o, rdheld]) && (0 < h[q, held] || h[q, rdheld]) ==> h[o, mu] != h[q, mu]);

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
function Call$SecMask(int) returns (MaskType);
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

// the connection between mod and /
axiom (forall x:int, y:int :: {x mod y} {x div y}  x mod y == x - x div y * y);

// sign of denominator determines sign of remainder
axiom (forall x:int, y:int :: {x mod y}  0 < y  ==>  0 <= x mod y  &&  x mod y < y);
axiom (forall x:int, y:int :: {x mod y}  y < 0  ==>  y < x mod y  &&  x mod y <= 0);

// the following axiom has some unfortunate matching, but it does state a property about mod that
// is sometime useful
axiom (forall a: int, b: int, d: int :: { a mod d, b mod d } 2 <= d && a mod d == b mod d && a < b  ==>  a + d <= b);

// ---------------------------------------------------------------
// -- Strings ----------------------------------------------------
// ---------------------------------------------------------------

type string = int;

// ---------------------------------------------------------------
// -- End of prelude ---------------------------------------------
// ---------------------------------------------------------------

const unique Node#t: TypeName;
const unique module#default: ModuleName;
procedure Node$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == Node#t)) returns ()
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var methodK#_9: int;
  var h0#_0: HeapType;
  var m0#_1: MaskType;
  var sm0#_2: MaskType;
  var c0#_3: CreditsType;
  var h1#_4: HeapType;
  var m1#_5: MaskType;
  var sm1#_6: MaskType;
  var c1#_7: CreditsType;
  var lk#_8: ref;
  var exhaleMask#_11: MaskType;
  var exhaleHeap#_10: HeapType;
  assume (0 < methodK#_9) && ((1000 * methodK#_9) < Fractions(1));
  assume wf(h0#_0, m0#_1, sm0#_2);
  assume wf(h1#_4, m1#_5, sm1#_6);
  m1#_5 := ZeroMask;
  sm1#_6 := ZeroMask;
  c1#_7 := ZeroCredits;
  havoc h1#_4;
  // inhale (monitor invariant)
  assume this != null;
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume (h1#_4[this, Node.prev] == null) || (dtype(h1#_4[this, Node.prev]) == Node#t);
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  m1#_5[this, Node.prev] := m1#_5[this, Node.prev][perm$R := m1#_5[this, Node.prev][perm$R] + (Fractions(50) - 0)];
  m1#_5[this, Node.prev] := m1#_5[this, Node.prev][perm$N := m1#_5[this, Node.prev][perm$N] + (0 - 1)];
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume IsGoodMask(m1#_5);
  assume IsGoodState(heapFragment(h1#_4[this, Node.prev]));
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume this != null;
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume (h1#_4[this, Node.next] == null) || (dtype(h1#_4[this, Node.next]) == Node#t);
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  m1#_5[this, Node.next] := m1#_5[this, Node.next][perm$R := m1#_5[this, Node.next][perm$R] + (Fractions(50) - 0)];
  m1#_5[this, Node.next] := m1#_5[this, Node.next][perm$N := m1#_5[this, Node.next][perm$N] + (0 - 1)];
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume IsGoodMask(m1#_5);
  assume IsGoodState(heapFragment(h1#_4[this, Node.next]));
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume this != null;
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume true;
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  m1#_5[this, mu] := m1#_5[this, mu][perm$R := m1#_5[this, mu][perm$R] + (Fractions(50) - 0)];
  m1#_5[this, mu] := m1#_5[this, mu][perm$N := m1#_5[this, mu][perm$N] + (0 - 1)];
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume IsGoodMask(m1#_5);
  assume IsGoodState(heapFragment(h1#_4[this, mu]));
  assume wf(h1#_4, m1#_5, sm1#_6);
  assume wf(h1#_4, m1#_5, sm1#_6);
  if (h1#_4[this, Node.next] == null) {
    assume this != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[this, Node.prev] == null) || (dtype(h1#_4[this, Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[this, Node.prev] := m1#_5[this, Node.prev][perm$R := m1#_5[this, Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[this, Node.prev]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume this != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[this, Node.next] == null) || (dtype(h1#_4[this, Node.next]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[this, Node.next] := m1#_5[this, Node.next][perm$R := m1#_5[this, Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[this, Node.next]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume this != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume true;
    assume Fractions(25) > 0;
    m1#_5[this, mu] := m1#_5[this, mu][perm$R := m1#_5[this, mu][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[this, mu]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
  }
  if (!(h1#_4[this, Node.next] == null)) {
    assume h1#_4[this, Node.next] != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[h1#_4[this, Node.next], Node.next] == null) || (dtype(h1#_4[h1#_4[this, Node.next], Node.next]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[h1#_4[this, Node.next], Node.next] := m1#_5[h1#_4[this, Node.next], Node.next][perm$R := m1#_5[h1#_4[this, Node.next], Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[h1#_4[this, Node.next], Node.next]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume h1#_4[this, Node.next] != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[h1#_4[this, Node.next], Node.prev] == null) || (dtype(h1#_4[h1#_4[this, Node.next], Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[h1#_4[this, Node.next], Node.prev] := m1#_5[h1#_4[this, Node.next], Node.prev][perm$R := m1#_5[h1#_4[this, Node.next], Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[h1#_4[this, Node.next], Node.prev]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume h1#_4[this, Node.next] != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume true;
    assume Fractions(25) > 0;
    m1#_5[h1#_4[this, Node.next], mu] := m1#_5[h1#_4[this, Node.next], mu][perm$R := m1#_5[h1#_4[this, Node.next], mu][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[h1#_4[this, Node.next], mu]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
  }
  if (h1#_4[this, Node.prev] == null) {
    assume this != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[this, Node.prev] == null) || (dtype(h1#_4[this, Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[this, Node.prev] := m1#_5[this, Node.prev][perm$R := m1#_5[this, Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[this, Node.prev]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume this != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[this, Node.next] == null) || (dtype(h1#_4[this, Node.next]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[this, Node.next] := m1#_5[this, Node.next][perm$R := m1#_5[this, Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[this, Node.next]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume this != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume true;
    assume Fractions(25) > 0;
    m1#_5[this, mu] := m1#_5[this, mu][perm$R := m1#_5[this, mu][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[this, mu]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
  }
  if (!(h1#_4[this, Node.prev] == null)) {
    assume h1#_4[this, Node.prev] != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[h1#_4[this, Node.prev], Node.next] == null) || (dtype(h1#_4[h1#_4[this, Node.prev], Node.next]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[h1#_4[this, Node.prev], Node.next] := m1#_5[h1#_4[this, Node.prev], Node.next][perm$R := m1#_5[h1#_4[this, Node.prev], Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[h1#_4[this, Node.prev], Node.next]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume h1#_4[this, Node.prev] != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume (h1#_4[h1#_4[this, Node.prev], Node.prev] == null) || (dtype(h1#_4[h1#_4[this, Node.prev], Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    m1#_5[h1#_4[this, Node.prev], Node.prev] := m1#_5[h1#_4[this, Node.prev], Node.prev][perm$R := m1#_5[h1#_4[this, Node.prev], Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[h1#_4[this, Node.prev], Node.prev]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume h1#_4[this, Node.prev] != null;
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume true;
    assume Fractions(25) > 0;
    m1#_5[h1#_4[this, Node.prev], mu] := m1#_5[h1#_4[this, Node.prev], mu][perm$R := m1#_5[h1#_4[this, Node.prev], mu][perm$R] + Fractions(25)];
    assume IsGoodMask(m1#_5);
    assume IsGoodState(heapFragment(h1#_4[h1#_4[this, Node.prev], mu]));
    assume wf(h1#_4, m1#_5, sm1#_6);
    assume wf(h1#_4, m1#_5, sm1#_6);
  }
  if (!(h1#_4[this, Node.next] == null)) {
    assume !(h1#_4[h1#_4[this, Node.next], Node.prev] == null);
    assume h1#_4[h1#_4[this, Node.next], Node.prev] == this;
  }
  if (!(h1#_4[this, Node.prev] == null)) {
    assume !(h1#_4[h1#_4[this, Node.prev], Node.next] == null);
    assume h1#_4[h1#_4[this, Node.prev], Node.next] == this;
  }
  if (!(h1#_4[this, Node.next] == null)) {
    assume MuBelow(h1#_4[this, mu], h1#_4[h1#_4[this, Node.next], mu]);
  }
  if (!(h1#_4[this, Node.prev] == null)) {
    assume MuBelow(h1#_4[h1#_4[this, Node.prev], mu], h1#_4[this, mu]);
  }
  assume IsGoodMask(m1#_5);
  assume wf(h1#_4, m1#_5, sm1#_6);
  // end inhale
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  // inhale (monitor invariant)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  Mask[this, Node.prev] := Mask[this, Node.prev][perm$R := Mask[this, Node.prev][perm$R] + (Fractions(50) - 0)];
  Mask[this, Node.prev] := Mask[this, Node.prev][perm$N := Mask[this, Node.prev][perm$N] + (0 - 1)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  Mask[this, Node.next] := Mask[this, Node.next][perm$R := Mask[this, Node.next][perm$R] + (Fractions(50) - 0)];
  Mask[this, Node.next] := Mask[this, Node.next][perm$N := Mask[this, Node.next][perm$N] + (0 - 1)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  Mask[this, mu] := Mask[this, mu][perm$R := Mask[this, mu][perm$R] + (Fractions(50) - 0)];
  Mask[this, mu] := Mask[this, mu][perm$N := Mask[this, mu][perm$N] + (0 - 1)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  7.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  7.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (Heap[this, Node.next] == null) {
    assume this != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[this, Node.prev] := Mask[this, Node.prev][perm$R := Mask[this, Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume this != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[this, Node.next] := Mask[this, Node.next][perm$R := Mask[this, Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume this != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[this, mu] := Mask[this, mu][perm$R := Mask[this, mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  assert {:msg "  8.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  8.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  8.35: Receiver might be null."} true ==> (this != null);
    assert {:msg "  8.35: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.next] == null) || (dtype(Heap[Heap[this, Node.next], Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[this, Node.next], Node.next] := Mask[Heap[this, Node.next], Node.next][perm$R := Mask[Heap[this, Node.next], Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  8.57: Receiver might be null."} true ==> (this != null);
    assert {:msg "  8.57: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.prev] == null) || (dtype(Heap[Heap[this, Node.next], Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[this, Node.next], Node.prev] := Mask[Heap[this, Node.next], Node.prev][perm$R := Mask[Heap[this, Node.next], Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  8.79: Receiver might be null."} true ==> (this != null);
    assert {:msg "  8.79: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[Heap[this, Node.next], mu] := Mask[Heap[this, Node.next], mu][perm$R := Mask[Heap[this, Node.next], mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  assert {:msg "  9.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  9.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (Heap[this, Node.prev] == null) {
    assume this != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[this, Node.prev] := Mask[this, Node.prev][perm$R := Mask[this, Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume this != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[this, Node.next] := Mask[this, Node.next][perm$R := Mask[this, Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume this != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[this, mu] := Mask[this, mu][perm$R := Mask[this, mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  assert {:msg "  10.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  10.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  10.35: Receiver might be null."} true ==> (this != null);
    assert {:msg "  10.35: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.next] == null) || (dtype(Heap[Heap[this, Node.prev], Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[this, Node.prev], Node.next] := Mask[Heap[this, Node.prev], Node.next][perm$R := Mask[Heap[this, Node.prev], Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  10.57: Receiver might be null."} true ==> (this != null);
    assert {:msg "  10.57: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[this, Node.prev], Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[this, Node.prev], Node.prev] := Mask[Heap[this, Node.prev], Node.prev][perm$R := Mask[Heap[this, Node.prev], Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  10.79: Receiver might be null."} true ==> (this != null);
    assert {:msg "  10.79: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[Heap[this, Node.prev], mu] := Mask[Heap[this, Node.prev], mu][perm$R := Mask[Heap[this, Node.prev], mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  assert {:msg "  11.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  11.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  11.31: Receiver might be null."} true ==> (this != null);
    assert {:msg "  11.31: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  11.31: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
    assert {:msg "  11.31: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.next], Node.prev);
    assume !(Heap[Heap[this, Node.next], Node.prev] == null);
    assert {:msg "  11.52: Receiver might be null."} true ==> (this != null);
    assert {:msg "  11.52: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  11.52: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
    assert {:msg "  11.52: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.next], Node.prev);
    assume Heap[Heap[this, Node.next], Node.prev] == this;
  }
  assert {:msg "  12.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  12.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  12.31: Receiver might be null."} true ==> (this != null);
    assert {:msg "  12.31: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  12.31: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
    assert {:msg "  12.31: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.prev], Node.next);
    assume !(Heap[Heap[this, Node.prev], Node.next] == null);
    assert {:msg "  12.52: Receiver might be null."} true ==> (this != null);
    assert {:msg "  12.52: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  12.52: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
    assert {:msg "  12.52: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.prev], Node.next);
    assume Heap[Heap[this, Node.prev], Node.next] == this;
  }
  assert {:msg "  13.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  13.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  13.30: Receiver might be null."} true ==> (this != null);
    assert {:msg "  13.30: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, mu);
    assert {:msg "  13.41: Receiver might be null."} true ==> (this != null);
    assert {:msg "  13.41: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  13.41: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
    assert {:msg "  13.41: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.next], mu);
    assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
  }
  assert {:msg "  14.15: Receiver might be null."} true ==> (this != null);
  assert {:msg "  14.15: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  14.30: Receiver might be null."} true ==> (this != null);
    assert {:msg "  14.30: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  14.30: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
    assert {:msg "  14.30: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.prev], mu);
    assert {:msg "  14.41: Receiver might be null."} true ==> (this != null);
    assert {:msg "  14.41: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, mu);
    assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // Line #1: class Node {  
  assert {:msg "  1.1: SMOKE-TEST-50. (Monitor invariant is equivalent to false.)"}{:subsumption 0} !(1 == 1);
  // begin exhale (invariant reflexive?)
  exhaleMask#_11 := Mask;
  havoc exhaleHeap#_10;
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  11.5: Monitor invariant might not be reflexive. The expression at 11.31 might not evaluate to true."} !(Heap[Heap[this, Node.next], Node.prev] == null);
    assert {:msg "  11.5: Monitor invariant might not be reflexive. The expression at 11.52 might not evaluate to true."} Heap[Heap[this, Node.next], Node.prev] == this;
  }
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  12.5: Monitor invariant might not be reflexive. The expression at 12.31 might not evaluate to true."} !(Heap[Heap[this, Node.prev], Node.next] == null);
    assert {:msg "  12.5: Monitor invariant might not be reflexive. The expression at 12.52 might not evaluate to true."} Heap[Heap[this, Node.prev], Node.next] == this;
  }
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  13.5: Monitor invariant might not be reflexive. The expression at 13.30 might not evaluate to true."} MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
  }
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  14.5: Monitor invariant might not be reflexive. The expression at 14.30 might not evaluate to true."} MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
  }
  assert {:msg "  6.5: Monitor invariant might not be reflexive. The permission at 6.15 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  assert {:msg "  6.5: Monitor invariant might not be reflexive. Insufficient permission at 6.15 for Node.prev."} ((Fractions(50) - 0) <= exhaleMask#_11[this, Node.prev][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_11[this, Node.prev][perm$R]) ==> ((0 - 1) <= exhaleMask#_11[this, Node.prev][perm$N]));
  exhaleMask#_11[this, Node.prev] := exhaleMask#_11[this, Node.prev][perm$N := exhaleMask#_11[this, Node.prev][perm$N] - (0 - 1)];
  exhaleMask#_11[this, Node.prev] := exhaleMask#_11[this, Node.prev][perm$R := exhaleMask#_11[this, Node.prev][perm$R] - (Fractions(50) - 0)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(exhaleMask#_11);
  assume wf(Heap, exhaleMask#_11, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  6.5: Monitor invariant might not be reflexive. The permission at 6.38 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  assert {:msg "  6.5: Monitor invariant might not be reflexive. Insufficient permission at 6.38 for Node.next."} ((Fractions(50) - 0) <= exhaleMask#_11[this, Node.next][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_11[this, Node.next][perm$R]) ==> ((0 - 1) <= exhaleMask#_11[this, Node.next][perm$N]));
  exhaleMask#_11[this, Node.next] := exhaleMask#_11[this, Node.next][perm$N := exhaleMask#_11[this, Node.next][perm$N] - (0 - 1)];
  exhaleMask#_11[this, Node.next] := exhaleMask#_11[this, Node.next][perm$R := exhaleMask#_11[this, Node.next][perm$R] - (Fractions(50) - 0)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(exhaleMask#_11);
  assume wf(Heap, exhaleMask#_11, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  6.5: Monitor invariant might not be reflexive. The permission at 6.61 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  assert {:msg "  6.5: Monitor invariant might not be reflexive. Insufficient permission at 6.61 for mu."} ((Fractions(50) - 0) <= exhaleMask#_11[this, mu][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_11[this, mu][perm$R]) ==> ((0 - 1) <= exhaleMask#_11[this, mu][perm$N]));
  exhaleMask#_11[this, mu] := exhaleMask#_11[this, mu][perm$N := exhaleMask#_11[this, mu][perm$N] - (0 - 1)];
  exhaleMask#_11[this, mu] := exhaleMask#_11[this, mu][perm$R := exhaleMask#_11[this, mu][perm$R] - (Fractions(50) - 0)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(exhaleMask#_11);
  assume wf(Heap, exhaleMask#_11, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (Heap[this, Node.next] == null) {
    assert {:msg "  7.5: Monitor invariant might not be reflexive. The permission at 7.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  7.5: Monitor invariant might not be reflexive. Insufficient fraction at 7.31 for Node.prev."} (Fractions(25) <= exhaleMask#_11[this, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11[this, Node.prev][perm$R]) ==> (0 <= exhaleMask#_11[this, Node.prev][perm$N]));
    exhaleMask#_11[this, Node.prev] := exhaleMask#_11[this, Node.prev][perm$R := exhaleMask#_11[this, Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  7.5: Monitor invariant might not be reflexive. The permission at 7.48 might not be positive."} Fractions(25) > 0;
    assert {:msg "  7.5: Monitor invariant might not be reflexive. Insufficient fraction at 7.48 for Node.next."} (Fractions(25) <= exhaleMask#_11[this, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11[this, Node.next][perm$R]) ==> (0 <= exhaleMask#_11[this, Node.next][perm$N]));
    exhaleMask#_11[this, Node.next] := exhaleMask#_11[this, Node.next][perm$R := exhaleMask#_11[this, Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  7.5: Monitor invariant might not be reflexive. The permission at 7.65 might not be positive."} Fractions(25) > 0;
    assert {:msg "  7.5: Monitor invariant might not be reflexive. Insufficient fraction at 7.65 for mu."} (Fractions(25) <= exhaleMask#_11[this, mu][perm$R]) && ((Fractions(25) == exhaleMask#_11[this, mu][perm$R]) ==> (0 <= exhaleMask#_11[this, mu][perm$N]));
    exhaleMask#_11[this, mu] := exhaleMask#_11[this, mu][perm$R := exhaleMask#_11[this, mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  8.5: Monitor invariant might not be reflexive. The permission at 8.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  8.5: Monitor invariant might not be reflexive. Insufficient fraction at 8.31 for Node.next."} (Fractions(25) <= exhaleMask#_11[Heap[this, Node.next], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11[Heap[this, Node.next], Node.next][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, Node.next], Node.next][perm$N]));
    exhaleMask#_11[Heap[this, Node.next], Node.next] := exhaleMask#_11[Heap[this, Node.next], Node.next][perm$R := exhaleMask#_11[Heap[this, Node.next], Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  8.5: Monitor invariant might not be reflexive. The permission at 8.53 might not be positive."} Fractions(25) > 0;
    assert {:msg "  8.5: Monitor invariant might not be reflexive. Insufficient fraction at 8.53 for Node.prev."} (Fractions(25) <= exhaleMask#_11[Heap[this, Node.next], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11[Heap[this, Node.next], Node.prev][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, Node.next], Node.prev][perm$N]));
    exhaleMask#_11[Heap[this, Node.next], Node.prev] := exhaleMask#_11[Heap[this, Node.next], Node.prev][perm$R := exhaleMask#_11[Heap[this, Node.next], Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  8.5: Monitor invariant might not be reflexive. The permission at 8.75 might not be positive."} Fractions(25) > 0;
    assert {:msg "  8.5: Monitor invariant might not be reflexive. Insufficient fraction at 8.75 for mu."} (Fractions(25) <= exhaleMask#_11[Heap[this, Node.next], mu][perm$R]) && ((Fractions(25) == exhaleMask#_11[Heap[this, Node.next], mu][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, Node.next], mu][perm$N]));
    exhaleMask#_11[Heap[this, Node.next], mu] := exhaleMask#_11[Heap[this, Node.next], mu][perm$R := exhaleMask#_11[Heap[this, Node.next], mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (Heap[this, Node.prev] == null) {
    assert {:msg "  9.5: Monitor invariant might not be reflexive. The permission at 9.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  9.5: Monitor invariant might not be reflexive. Insufficient fraction at 9.31 for Node.prev."} (Fractions(25) <= exhaleMask#_11[this, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11[this, Node.prev][perm$R]) ==> (0 <= exhaleMask#_11[this, Node.prev][perm$N]));
    exhaleMask#_11[this, Node.prev] := exhaleMask#_11[this, Node.prev][perm$R := exhaleMask#_11[this, Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  9.5: Monitor invariant might not be reflexive. The permission at 9.48 might not be positive."} Fractions(25) > 0;
    assert {:msg "  9.5: Monitor invariant might not be reflexive. Insufficient fraction at 9.48 for Node.next."} (Fractions(25) <= exhaleMask#_11[this, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11[this, Node.next][perm$R]) ==> (0 <= exhaleMask#_11[this, Node.next][perm$N]));
    exhaleMask#_11[this, Node.next] := exhaleMask#_11[this, Node.next][perm$R := exhaleMask#_11[this, Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  9.5: Monitor invariant might not be reflexive. The permission at 9.65 might not be positive."} Fractions(25) > 0;
    assert {:msg "  9.5: Monitor invariant might not be reflexive. Insufficient fraction at 9.65 for mu."} (Fractions(25) <= exhaleMask#_11[this, mu][perm$R]) && ((Fractions(25) == exhaleMask#_11[this, mu][perm$R]) ==> (0 <= exhaleMask#_11[this, mu][perm$N]));
    exhaleMask#_11[this, mu] := exhaleMask#_11[this, mu][perm$R := exhaleMask#_11[this, mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  10.5: Monitor invariant might not be reflexive. The permission at 10.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  10.5: Monitor invariant might not be reflexive. Insufficient fraction at 10.31 for Node.next."} (Fractions(25) <= exhaleMask#_11[Heap[this, Node.prev], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11[Heap[this, Node.prev], Node.next][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, Node.prev], Node.next][perm$N]));
    exhaleMask#_11[Heap[this, Node.prev], Node.next] := exhaleMask#_11[Heap[this, Node.prev], Node.next][perm$R := exhaleMask#_11[Heap[this, Node.prev], Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  10.5: Monitor invariant might not be reflexive. The permission at 10.53 might not be positive."} Fractions(25) > 0;
    assert {:msg "  10.5: Monitor invariant might not be reflexive. Insufficient fraction at 10.53 for Node.prev."} (Fractions(25) <= exhaleMask#_11[Heap[this, Node.prev], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11[Heap[this, Node.prev], Node.prev][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, Node.prev], Node.prev][perm$N]));
    exhaleMask#_11[Heap[this, Node.prev], Node.prev] := exhaleMask#_11[Heap[this, Node.prev], Node.prev][perm$R := exhaleMask#_11[Heap[this, Node.prev], Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  10.5: Monitor invariant might not be reflexive. The permission at 10.75 might not be positive."} Fractions(25) > 0;
    assert {:msg "  10.5: Monitor invariant might not be reflexive. Insufficient fraction at 10.75 for mu."} (Fractions(25) <= exhaleMask#_11[Heap[this, Node.prev], mu][perm$R]) && ((Fractions(25) == exhaleMask#_11[Heap[this, Node.prev], mu][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, Node.prev], mu][perm$N]));
    exhaleMask#_11[Heap[this, Node.prev], mu] := exhaleMask#_11[Heap[this, Node.prev], mu][perm$R := exhaleMask#_11[Heap[this, Node.prev], mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_11);
    assume wf(Heap, exhaleMask#_11, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_11;
  assume IsGoodExhaleState(exhaleHeap#_10, Heap, Mask, SecMask);
  Heap := exhaleHeap#_10;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  assert {:msg "  1.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique Node.next: Field (ref);
axiom NonPredicateField(Node.next);
const unique Node.prev: Field (ref);
axiom NonPredicateField(Node.prev);
const unique Node.inv: Field (int);
axiom PredicateField(Node.inv);
function #Node.inv#trigger(this: ref) returns ($myresult: bool);
procedure Node.inv$checkDefinedness(this: ref where (this == null) || (dtype(this) == Node#t)) returns ()
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var predicateK#_27: int;
  var predRec#_28: ref;
  var predFlag#_30: bool;
  var predVer#_29: int;
  var unfoldingK#_36: int;
  var predFlag#_35: bool;
  var unfoldingHeap#_31: HeapType;
  var unfoldingMask#_32: MaskType;
  var unfoldingSecMask#_33: MaskType;
  var unfoldingCredits#_34: CreditsType;
  var oldVers#_46: int;
  var newVers#_47: int;
  var predRec#_48: ref;
  var predFlag#_50: bool;
  var predVer#_49: int;
  var predRec#_63: ref;
  var predFlag#_65: bool;
  var predVer#_64: int;
  var unfoldingK#_71: int;
  var predFlag#_70: bool;
  var unfoldingHeap#_66: HeapType;
  var unfoldingMask#_67: MaskType;
  var unfoldingSecMask#_68: MaskType;
  var unfoldingCredits#_69: CreditsType;
  var oldVers#_81: int;
  var newVers#_82: int;
  var predRec#_83: ref;
  var predFlag#_85: bool;
  var predVer#_84: int;
  assume (0 < predicateK#_27) && ((1000 * predicateK#_27) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.prev] := Mask[this, Node.prev][perm$N := Mask[this, Node.prev][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.next] := Mask[this, Node.next][perm$N := Mask[this, Node.next][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume 1 > 0;
  Mask[this, mu] := Mask[this, mu][perm$N := Mask[this, mu][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  18.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  18.10: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  18.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  18.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  18.25: Receiver might be null."} Heap[this, Node.prev] != null;
    assert {:msg "  18.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  18.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, Node.prev], Node.invLeft] := Mask[Heap[this, Node.prev], Node.invLeft][perm$R := Mask[Heap[this, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.invLeft]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    predRec#_28 := Heap[this, Node.prev];
    predFlag#_30 := true;
    assume #Node.invLeft#trigger(Heap[this, Node.prev]);
    predVer#_29 := Heap[Heap[this, Node.prev], Node.invLeft];
    // unfolding
    assume (0 < unfoldingK#_36) && ((1000 * unfoldingK#_36) < Fractions(1));
    predFlag#_35 := true;
    assert {:msg "  18.51: Receiver might be null."} true ==> (this != null);
    assert {:msg "  18.51: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  18.51: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
    unfoldingHeap#_31 := Heap;
    unfoldingMask#_32 := Mask;
    unfoldingSecMask#_33 := SecMask;
    unfoldingCredits#_34 := Credits;
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    // begin exhale (unfolding)
    assert {:msg "  18.41: Unfolding might fail. The permission at 18.51 might not be positive."} Fractions(100) > 0;
    assert {:msg "  18.41: Unfolding might fail. Insufficient fraction at 18.51 for Node.invLeft."} (Fractions(100) <= unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.invLeft][perm$R]) ==> (0 <= unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.invLeft][perm$N]));
    unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.invLeft] := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.invLeft][perm$R := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_31[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], mu], unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], mu]);
      }
      unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.prev] := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.prev][perm$N := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      if (unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.prev] := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.next] := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.next][perm$N := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      if (unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.next][perm$N] < 0) {
        unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.next] := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], mu] := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], mu][perm$N := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      if (unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], mu][perm$N] < 0) {
        unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], mu] := unfoldingSecMask#_33[unfoldingHeap#_31[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      if (!(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev] == null)) {
        unfoldingSecMask#_33[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_33[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_33[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_33[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          unfoldingSecMask#_33[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_33[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      }
      assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
      // end exhale
    }
    if (!CanRead(unfoldingMask#_32, unfoldingSecMask#_33, unfoldingHeap#_31[this, Node.prev], Node.invLeft)) {
      oldVers#_46 := unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.invLeft];
      havoc newVers#_47;
      unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.invLeft] := newVers#_47;
      assume oldVers#_46 < unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.invLeft];
    }
    assume IsGoodMask(unfoldingMask#_32);
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume IsGoodMask(unfoldingMask#_32);
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    // end exhale
    // inhale (unfolding)
    assume unfoldingHeap#_31[this, Node.prev] != null;
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume (unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev] == null) || (dtype(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.prev] := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.prev][perm$N := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume IsGoodMask(unfoldingMask#_32);
    assume IsGoodState(heapFragment(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev]));
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume unfoldingHeap#_31[this, Node.prev] != null;
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume (unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.next] == null) || (dtype(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.next] := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.next][perm$N := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume IsGoodMask(unfoldingMask#_32);
    assume IsGoodState(heapFragment(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.next]));
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume unfoldingHeap#_31[this, Node.prev] != null;
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume true;
    assume 1 > 0;
    unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], mu] := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], mu][perm$N := unfoldingMask#_32[unfoldingHeap#_31[this, Node.prev], mu][perm$N] + 1];
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume IsGoodMask(unfoldingMask#_32);
    assume IsGoodState(heapFragment(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], mu]));
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    if (!(unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev] == null)) {
      assume unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume Fractions(100) > 0;
      unfoldingMask#_32[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft] := unfoldingMask#_32[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingMask#_32[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_32);
      assume IsGoodState(heapFragment(unfoldingHeap#_31[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], Node.invLeft]));
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      predRec#_48 := Heap[Heap[this, Node.prev], Node.prev];
      predFlag#_50 := true;
      assume #Node.invLeft#trigger(Heap[Heap[this, Node.prev], Node.prev]);
      predVer#_49 := unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft];
      if (false) {
        // begin exhale (update SecMask)
        if (!(unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(unfoldingHeap#_31[unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu], unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], mu]);
        }
        unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        if (unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
          unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        if (unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
          unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := 0];
        }
        assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        if (unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] < 0) {
          unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_33[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := 0];
        }
        assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        if (!(unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          unfoldingSecMask#_33[unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_33[unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_33[unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_33[unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            unfoldingSecMask#_33[unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_33[unfoldingHeap#_31[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
          assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        }
        assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
        // end exhale
      }
      assume predRec#_48 != null;
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume (unfoldingHeap#_31[predRec#_48, Node.prev] == null) || (dtype(unfoldingHeap#_31[predRec#_48, Node.prev]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_33[predRec#_48, Node.prev] := unfoldingSecMask#_33[predRec#_48, Node.prev][perm$N := unfoldingSecMask#_33[predRec#_48, Node.prev][perm$N] + 1];
      assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
      assume IsGoodMask(unfoldingMask#_32);
      assume IsGoodState(heapFragment(unfoldingHeap#_31[predRec#_48, Node.prev]));
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume predRec#_48 != null;
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume (unfoldingHeap#_31[predRec#_48, Node.next] == null) || (dtype(unfoldingHeap#_31[predRec#_48, Node.next]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_33[predRec#_48, Node.next] := unfoldingSecMask#_33[predRec#_48, Node.next][perm$N := unfoldingSecMask#_33[predRec#_48, Node.next][perm$N] + 1];
      assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
      assume IsGoodMask(unfoldingMask#_32);
      assume IsGoodState(heapFragment(unfoldingHeap#_31[predRec#_48, Node.next]));
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume predRec#_48 != null;
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume true;
      assume 1 > 0;
      unfoldingSecMask#_33[predRec#_48, mu] := unfoldingSecMask#_33[predRec#_48, mu][perm$N := unfoldingSecMask#_33[predRec#_48, mu][perm$N] + 1];
      assume wf(unfoldingHeap#_31, unfoldingSecMask#_33, unfoldingSecMask#_33);
      assume IsGoodMask(unfoldingMask#_32);
      assume IsGoodState(heapFragment(unfoldingHeap#_31[predRec#_48, mu]));
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      if (!(unfoldingHeap#_31[predRec#_48, Node.prev] == null)) {
        assume unfoldingHeap#_31[predRec#_48, Node.prev] != null;
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        assume Fractions(100) > 0;
        unfoldingSecMask#_33[unfoldingHeap#_31[predRec#_48, Node.prev], Node.invLeft] := unfoldingSecMask#_33[unfoldingHeap#_31[predRec#_48, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_33[unfoldingHeap#_31[predRec#_48, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_32);
        assume IsGoodState(heapFragment(unfoldingHeap#_31[unfoldingHeap#_31[predRec#_48, Node.prev], Node.invLeft]));
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
        assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
      }
      assume MuBelow(unfoldingHeap#_31[unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], Node.prev], mu], unfoldingHeap#_31[unfoldingHeap#_31[this, Node.prev], mu]);
    }
    assume IsGoodMask(unfoldingMask#_32);
    assume wf(unfoldingHeap#_31, unfoldingMask#_32, unfoldingSecMask#_33);
    // end inhale
    if (false) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(Heap[Heap[Heap[this, Node.prev], Node.prev], mu], Heap[Heap[this, Node.prev], mu]);
      }
      SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := SecMask[Heap[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := SecMask[Heap[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := SecMask[Heap[this, Node.prev], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[this, Node.prev], Node.prev]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := SecMask[Heap[this, Node.prev], Node.prev][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.next] == null) || (dtype(Heap[Heap[this, Node.prev], Node.next]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := SecMask[Heap[this, Node.prev], Node.next][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := SecMask[Heap[this, Node.prev], mu][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
      assume Heap[Heap[this, Node.prev], Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assert {:msg "  18.67: Receiver might be null."} true ==> (this != null);
    assert {:msg "  18.67: Location might not be readable."} true ==> CanRead(unfoldingMask#_32, unfoldingSecMask#_33, this, Node.prev);
    assert {:msg "  18.67: Receiver might be null."} true ==> (unfoldingHeap#_31[this, Node.prev] != null);
    assert {:msg "  18.67: Location might not be readable."} true ==> CanRead(unfoldingMask#_32, unfoldingSecMask#_33, unfoldingHeap#_31[this, Node.prev], mu);
    assert {:msg "  18.78: Receiver might be null."} true ==> (this != null);
    assert {:msg "  18.78: Location might not be readable."} true ==> CanRead(unfoldingMask#_32, unfoldingSecMask#_33, this, mu);
    assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
  }
  assert {:msg "  19.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  19.10: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  19.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  19.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  19.25: Receiver might be null."} Heap[this, Node.next] != null;
    assert {:msg "  19.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  19.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, Node.next], Node.invRight] := Mask[Heap[this, Node.next], Node.invRight][perm$R := Mask[Heap[this, Node.next], Node.invRight][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.invRight]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    predRec#_63 := Heap[this, Node.next];
    predFlag#_65 := true;
    assume #Node.invRight#trigger(Heap[this, Node.next]);
    predVer#_64 := Heap[Heap[this, Node.next], Node.invRight];
    // unfolding
    assume (0 < unfoldingK#_71) && ((1000 * unfoldingK#_71) < Fractions(1));
    predFlag#_70 := true;
    assert {:msg "  19.52: Receiver might be null."} true ==> (this != null);
    assert {:msg "  19.52: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  19.52: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
    unfoldingHeap#_66 := Heap;
    unfoldingMask#_67 := Mask;
    unfoldingSecMask#_68 := SecMask;
    unfoldingCredits#_69 := Credits;
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    // begin exhale (unfolding)
    assert {:msg "  19.42: Unfolding might fail. The permission at 19.52 might not be positive."} Fractions(100) > 0;
    assert {:msg "  19.42: Unfolding might fail. Insufficient fraction at 19.52 for Node.invRight."} (Fractions(100) <= unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.invRight][perm$R]) && ((Fractions(100) == unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.invRight][perm$R]) ==> (0 <= unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.invRight][perm$N]));
    unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.invRight] := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.invRight][perm$R := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], mu], unfoldingHeap#_66[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], mu]);
      }
      unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.prev] := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.prev][perm$N := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      if (unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.prev] := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.next] := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.next][perm$N := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      if (unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.next][perm$N] < 0) {
        unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.next] := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], mu] := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], mu][perm$N := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      if (unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], mu][perm$N] < 0) {
        unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], mu] := unfoldingSecMask#_68[unfoldingHeap#_66[this, Node.next], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      if (!(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next] == null)) {
        unfoldingSecMask#_68[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_68[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight][perm$R := unfoldingSecMask#_68[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_68[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          unfoldingSecMask#_68[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_68[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      }
      assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
      // end exhale
    }
    if (!CanRead(unfoldingMask#_67, unfoldingSecMask#_68, unfoldingHeap#_66[this, Node.next], Node.invRight)) {
      oldVers#_81 := unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.invRight];
      havoc newVers#_82;
      unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.invRight] := newVers#_82;
      assume oldVers#_81 < unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.invRight];
    }
    assume IsGoodMask(unfoldingMask#_67);
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume IsGoodMask(unfoldingMask#_67);
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    // end exhale
    // inhale (unfolding)
    assume unfoldingHeap#_66[this, Node.next] != null;
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume (unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.prev] == null) || (dtype(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.prev] := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.prev][perm$N := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume IsGoodMask(unfoldingMask#_67);
    assume IsGoodState(heapFragment(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.prev]));
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume unfoldingHeap#_66[this, Node.next] != null;
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume (unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next] == null) || (dtype(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.next] := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.next][perm$N := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume IsGoodMask(unfoldingMask#_67);
    assume IsGoodState(heapFragment(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next]));
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume unfoldingHeap#_66[this, Node.next] != null;
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume true;
    assume 1 > 0;
    unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], mu] := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], mu][perm$N := unfoldingMask#_67[unfoldingHeap#_66[this, Node.next], mu][perm$N] + 1];
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume IsGoodMask(unfoldingMask#_67);
    assume IsGoodState(heapFragment(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], mu]));
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    if (!(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next] == null)) {
      assume unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next] != null;
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume Fractions(100) > 0;
      unfoldingMask#_67[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight] := unfoldingMask#_67[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight][perm$R := unfoldingMask#_67[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_67);
      assume IsGoodState(heapFragment(unfoldingHeap#_66[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], Node.invRight]));
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      predRec#_83 := Heap[Heap[this, Node.next], Node.next];
      predFlag#_85 := true;
      assume #Node.invRight#trigger(Heap[Heap[this, Node.next], Node.next]);
      predVer#_84 := unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.invRight];
      if (false) {
        // begin exhale (update SecMask)
        if (!(unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
          assume MuBelow(unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], mu], unfoldingHeap#_66[unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next], mu]);
        }
        unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.prev] := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] - 1];
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        if (unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] < 0) {
          unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.prev] := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := 0];
        }
        assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.next] := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] - 1];
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        if (unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] < 0) {
          unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.next] := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := 0];
        }
        assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], mu] := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], mu][perm$N := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], mu][perm$N] - 1];
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        if (unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], mu][perm$N] < 0) {
          unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], mu] := unfoldingSecMask#_68[Heap[Heap[this, Node.next], Node.next], mu][perm$N := 0];
        }
        assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        if (!(unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          unfoldingSecMask#_68[unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := unfoldingSecMask#_68[unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := unfoldingSecMask#_68[unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_68[unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
            unfoldingSecMask#_68[unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := unfoldingSecMask#_68[unfoldingHeap#_66[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
          }
          assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
          assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        }
        assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
        // end exhale
      }
      assume predRec#_83 != null;
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume (unfoldingHeap#_66[predRec#_83, Node.prev] == null) || (dtype(unfoldingHeap#_66[predRec#_83, Node.prev]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_68[predRec#_83, Node.prev] := unfoldingSecMask#_68[predRec#_83, Node.prev][perm$N := unfoldingSecMask#_68[predRec#_83, Node.prev][perm$N] + 1];
      assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
      assume IsGoodMask(unfoldingMask#_67);
      assume IsGoodState(heapFragment(unfoldingHeap#_66[predRec#_83, Node.prev]));
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume predRec#_83 != null;
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume (unfoldingHeap#_66[predRec#_83, Node.next] == null) || (dtype(unfoldingHeap#_66[predRec#_83, Node.next]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_68[predRec#_83, Node.next] := unfoldingSecMask#_68[predRec#_83, Node.next][perm$N := unfoldingSecMask#_68[predRec#_83, Node.next][perm$N] + 1];
      assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
      assume IsGoodMask(unfoldingMask#_67);
      assume IsGoodState(heapFragment(unfoldingHeap#_66[predRec#_83, Node.next]));
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume predRec#_83 != null;
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume true;
      assume 1 > 0;
      unfoldingSecMask#_68[predRec#_83, mu] := unfoldingSecMask#_68[predRec#_83, mu][perm$N := unfoldingSecMask#_68[predRec#_83, mu][perm$N] + 1];
      assume wf(unfoldingHeap#_66, unfoldingSecMask#_68, unfoldingSecMask#_68);
      assume IsGoodMask(unfoldingMask#_67);
      assume IsGoodState(heapFragment(unfoldingHeap#_66[predRec#_83, mu]));
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      if (!(unfoldingHeap#_66[predRec#_83, Node.next] == null)) {
        assume unfoldingHeap#_66[predRec#_83, Node.next] != null;
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        assume Fractions(100) > 0;
        unfoldingSecMask#_68[unfoldingHeap#_66[predRec#_83, Node.next], Node.invRight] := unfoldingSecMask#_68[unfoldingHeap#_66[predRec#_83, Node.next], Node.invRight][perm$R := unfoldingSecMask#_68[unfoldingHeap#_66[predRec#_83, Node.next], Node.invRight][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_67);
        assume IsGoodState(heapFragment(unfoldingHeap#_66[unfoldingHeap#_66[predRec#_83, Node.next], Node.invRight]));
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
        assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
      }
      assume MuBelow(unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], mu], unfoldingHeap#_66[unfoldingHeap#_66[unfoldingHeap#_66[this, Node.next], Node.next], mu]);
    }
    assume IsGoodMask(unfoldingMask#_67);
    assume wf(unfoldingHeap#_66, unfoldingMask#_67, unfoldingSecMask#_68);
    // end inhale
    if (false) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(Heap[Heap[this, Node.next], mu], Heap[Heap[Heap[this, Node.next], Node.next], mu]);
      }
      SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := SecMask[Heap[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := SecMask[Heap[this, Node.next], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := SecMask[Heap[this, Node.next], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.prev] == null) || (dtype(Heap[Heap[this, Node.next], Node.prev]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := SecMask[Heap[this, Node.next], Node.prev][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.next] == null) || (dtype(Heap[Heap[this, Node.next], Node.next]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := SecMask[Heap[this, Node.next], Node.next][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := SecMask[Heap[this, Node.next], mu][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
      assume Heap[Heap[this, Node.next], Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assert {:msg "  19.69: Receiver might be null."} true ==> (this != null);
    assert {:msg "  19.69: Location might not be readable."} true ==> CanRead(unfoldingMask#_67, unfoldingSecMask#_68, this, mu);
    assert {:msg "  19.80: Receiver might be null."} true ==> (this != null);
    assert {:msg "  19.80: Location might not be readable."} true ==> CanRead(unfoldingMask#_67, unfoldingSecMask#_68, this, Node.next);
    assert {:msg "  19.80: Receiver might be null."} true ==> (unfoldingHeap#_66[this, Node.next] != null);
    assert {:msg "  19.80: Location might not be readable."} true ==> CanRead(unfoldingMask#_67, unfoldingSecMask#_68, unfoldingHeap#_66[this, Node.next], mu);
    assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // Line #16:     predicate inv {  
  assert {:msg "  16.5: SMOKE-TEST-51. (Predicate Node.inv is equivalent to false.)"}{:subsumption 0} !(1 == 1);
}
const unique Node.invLeft: Field (int);
axiom PredicateField(Node.invLeft);
function #Node.invLeft#trigger(this: ref) returns ($myresult: bool);
procedure Node.invLeft$checkDefinedness(this: ref where (this == null) || (dtype(this) == Node#t)) returns ()
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var predicateK#_98: int;
  var predRec#_99: ref;
  var predFlag#_101: bool;
  var predVer#_100: int;
  var unfoldingK#_107: int;
  var predFlag#_106: bool;
  var unfoldingHeap#_102: HeapType;
  var unfoldingMask#_103: MaskType;
  var unfoldingSecMask#_104: MaskType;
  var unfoldingCredits#_105: CreditsType;
  var oldVers#_117: int;
  var newVers#_118: int;
  var predRec#_119: ref;
  var predFlag#_121: bool;
  var predVer#_120: int;
  assume (0 < predicateK#_98) && ((1000 * predicateK#_98) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.prev] := Mask[this, Node.prev][perm$N := Mask[this, Node.prev][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.next] := Mask[this, Node.next][perm$N := Mask[this, Node.next][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume 1 > 0;
  Mask[this, mu] := Mask[this, mu][perm$N := Mask[this, mu][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  23.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  23.10: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  23.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  23.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  23.25: Receiver might be null."} Heap[this, Node.prev] != null;
    assert {:msg "  23.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  23.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, Node.prev], Node.invLeft] := Mask[Heap[this, Node.prev], Node.invLeft][perm$R := Mask[Heap[this, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.invLeft]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    predRec#_99 := Heap[this, Node.prev];
    predFlag#_101 := true;
    assume #Node.invLeft#trigger(Heap[this, Node.prev]);
    predVer#_100 := Heap[Heap[this, Node.prev], Node.invLeft];
    // unfolding
    assume (0 < unfoldingK#_107) && ((1000 * unfoldingK#_107) < Fractions(1));
    predFlag#_106 := true;
    assert {:msg "  23.51: Receiver might be null."} true ==> (this != null);
    assert {:msg "  23.51: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  23.51: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
    unfoldingHeap#_102 := Heap;
    unfoldingMask#_103 := Mask;
    unfoldingSecMask#_104 := SecMask;
    unfoldingCredits#_105 := Credits;
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    // begin exhale (unfolding)
    assert {:msg "  23.41: Unfolding might fail. The permission at 23.51 might not be positive."} Fractions(100) > 0;
    assert {:msg "  23.41: Unfolding might fail. Insufficient fraction at 23.51 for Node.invLeft."} (Fractions(100) <= unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.invLeft][perm$R]) ==> (0 <= unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.invLeft][perm$N]));
    unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.invLeft] := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.invLeft][perm$R := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_102[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], mu], unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], mu]);
      }
      unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.prev] := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.prev][perm$N := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      if (unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.prev] := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.next] := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.next][perm$N := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      if (unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.next][perm$N] < 0) {
        unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.next] := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], mu] := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], mu][perm$N := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      if (unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], mu][perm$N] < 0) {
        unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], mu] := unfoldingSecMask#_104[unfoldingHeap#_102[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      if (!(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev] == null)) {
        unfoldingSecMask#_104[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_104[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_104[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_104[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          unfoldingSecMask#_104[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_104[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      }
      assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
      // end exhale
    }
    if (!CanRead(unfoldingMask#_103, unfoldingSecMask#_104, unfoldingHeap#_102[this, Node.prev], Node.invLeft)) {
      oldVers#_117 := unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.invLeft];
      havoc newVers#_118;
      unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.invLeft] := newVers#_118;
      assume oldVers#_117 < unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.invLeft];
    }
    assume IsGoodMask(unfoldingMask#_103);
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume IsGoodMask(unfoldingMask#_103);
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    // end exhale
    // inhale (unfolding)
    assume unfoldingHeap#_102[this, Node.prev] != null;
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume (unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev] == null) || (dtype(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.prev] := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.prev][perm$N := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume IsGoodMask(unfoldingMask#_103);
    assume IsGoodState(heapFragment(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev]));
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume unfoldingHeap#_102[this, Node.prev] != null;
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume (unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.next] == null) || (dtype(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.next] := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.next][perm$N := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume IsGoodMask(unfoldingMask#_103);
    assume IsGoodState(heapFragment(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.next]));
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume unfoldingHeap#_102[this, Node.prev] != null;
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume true;
    assume 1 > 0;
    unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], mu] := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], mu][perm$N := unfoldingMask#_103[unfoldingHeap#_102[this, Node.prev], mu][perm$N] + 1];
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume IsGoodMask(unfoldingMask#_103);
    assume IsGoodState(heapFragment(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], mu]));
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    if (!(unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev] == null)) {
      assume unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume Fractions(100) > 0;
      unfoldingMask#_103[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft] := unfoldingMask#_103[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingMask#_103[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_103);
      assume IsGoodState(heapFragment(unfoldingHeap#_102[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], Node.invLeft]));
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      predRec#_119 := Heap[Heap[this, Node.prev], Node.prev];
      predFlag#_121 := true;
      assume #Node.invLeft#trigger(Heap[Heap[this, Node.prev], Node.prev]);
      predVer#_120 := unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft];
      if (false) {
        // begin exhale (update SecMask)
        if (!(unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(unfoldingHeap#_102[unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu], unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], mu]);
        }
        unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        if (unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
          unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        if (unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
          unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := 0];
        }
        assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        if (unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] < 0) {
          unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_104[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := 0];
        }
        assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        if (!(unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          unfoldingSecMask#_104[unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_104[unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_104[unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_104[unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            unfoldingSecMask#_104[unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_104[unfoldingHeap#_102[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
          assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        }
        assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
        // end exhale
      }
      assume predRec#_119 != null;
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume (unfoldingHeap#_102[predRec#_119, Node.prev] == null) || (dtype(unfoldingHeap#_102[predRec#_119, Node.prev]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_104[predRec#_119, Node.prev] := unfoldingSecMask#_104[predRec#_119, Node.prev][perm$N := unfoldingSecMask#_104[predRec#_119, Node.prev][perm$N] + 1];
      assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
      assume IsGoodMask(unfoldingMask#_103);
      assume IsGoodState(heapFragment(unfoldingHeap#_102[predRec#_119, Node.prev]));
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume predRec#_119 != null;
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume (unfoldingHeap#_102[predRec#_119, Node.next] == null) || (dtype(unfoldingHeap#_102[predRec#_119, Node.next]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_104[predRec#_119, Node.next] := unfoldingSecMask#_104[predRec#_119, Node.next][perm$N := unfoldingSecMask#_104[predRec#_119, Node.next][perm$N] + 1];
      assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
      assume IsGoodMask(unfoldingMask#_103);
      assume IsGoodState(heapFragment(unfoldingHeap#_102[predRec#_119, Node.next]));
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume predRec#_119 != null;
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume true;
      assume 1 > 0;
      unfoldingSecMask#_104[predRec#_119, mu] := unfoldingSecMask#_104[predRec#_119, mu][perm$N := unfoldingSecMask#_104[predRec#_119, mu][perm$N] + 1];
      assume wf(unfoldingHeap#_102, unfoldingSecMask#_104, unfoldingSecMask#_104);
      assume IsGoodMask(unfoldingMask#_103);
      assume IsGoodState(heapFragment(unfoldingHeap#_102[predRec#_119, mu]));
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      if (!(unfoldingHeap#_102[predRec#_119, Node.prev] == null)) {
        assume unfoldingHeap#_102[predRec#_119, Node.prev] != null;
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        assume Fractions(100) > 0;
        unfoldingSecMask#_104[unfoldingHeap#_102[predRec#_119, Node.prev], Node.invLeft] := unfoldingSecMask#_104[unfoldingHeap#_102[predRec#_119, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_104[unfoldingHeap#_102[predRec#_119, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_103);
        assume IsGoodState(heapFragment(unfoldingHeap#_102[unfoldingHeap#_102[predRec#_119, Node.prev], Node.invLeft]));
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
        assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
      }
      assume MuBelow(unfoldingHeap#_102[unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], Node.prev], mu], unfoldingHeap#_102[unfoldingHeap#_102[this, Node.prev], mu]);
    }
    assume IsGoodMask(unfoldingMask#_103);
    assume wf(unfoldingHeap#_102, unfoldingMask#_103, unfoldingSecMask#_104);
    // end inhale
    if (false) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(Heap[Heap[Heap[this, Node.prev], Node.prev], mu], Heap[Heap[this, Node.prev], mu]);
      }
      SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := SecMask[Heap[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := SecMask[Heap[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := SecMask[Heap[this, Node.prev], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[this, Node.prev], Node.prev]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := SecMask[Heap[this, Node.prev], Node.prev][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.next] == null) || (dtype(Heap[Heap[this, Node.prev], Node.next]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := SecMask[Heap[this, Node.prev], Node.next][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := SecMask[Heap[this, Node.prev], mu][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
      assume Heap[Heap[this, Node.prev], Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assert {:msg "  23.67: Receiver might be null."} true ==> (this != null);
    assert {:msg "  23.67: Location might not be readable."} true ==> CanRead(unfoldingMask#_103, unfoldingSecMask#_104, this, Node.prev);
    assert {:msg "  23.67: Receiver might be null."} true ==> (unfoldingHeap#_102[this, Node.prev] != null);
    assert {:msg "  23.67: Location might not be readable."} true ==> CanRead(unfoldingMask#_103, unfoldingSecMask#_104, unfoldingHeap#_102[this, Node.prev], mu);
    assert {:msg "  23.78: Receiver might be null."} true ==> (this != null);
    assert {:msg "  23.78: Location might not be readable."} true ==> CanRead(unfoldingMask#_103, unfoldingSecMask#_104, this, mu);
    assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // Line #21:     predicate invLeft {  
  assert {:msg "  21.5: SMOKE-TEST-52. (Predicate Node.invLeft is equivalent to false.)"}{:subsumption 0} !(1 == 1);
}
const unique Node.invRight: Field (int);
axiom PredicateField(Node.invRight);
function #Node.invRight#trigger(this: ref) returns ($myresult: bool);
procedure Node.invRight$checkDefinedness(this: ref where (this == null) || (dtype(this) == Node#t)) returns ()
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var predicateK#_134: int;
  var predRec#_135: ref;
  var predFlag#_137: bool;
  var predVer#_136: int;
  var unfoldingK#_143: int;
  var predFlag#_142: bool;
  var unfoldingHeap#_138: HeapType;
  var unfoldingMask#_139: MaskType;
  var unfoldingSecMask#_140: MaskType;
  var unfoldingCredits#_141: CreditsType;
  var oldVers#_153: int;
  var newVers#_154: int;
  var predRec#_155: ref;
  var predFlag#_157: bool;
  var predVer#_156: int;
  assume (0 < predicateK#_134) && ((1000 * predicateK#_134) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.prev] := Mask[this, Node.prev][perm$N := Mask[this, Node.prev][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.next] := Mask[this, Node.next][perm$N := Mask[this, Node.next][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume 1 > 0;
  Mask[this, mu] := Mask[this, mu][perm$N := Mask[this, mu][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  27.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  27.10: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  27.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  27.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  27.25: Receiver might be null."} Heap[this, Node.next] != null;
    assert {:msg "  27.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  27.25: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, Node.next], Node.invRight] := Mask[Heap[this, Node.next], Node.invRight][perm$R := Mask[Heap[this, Node.next], Node.invRight][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.invRight]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    predRec#_135 := Heap[this, Node.next];
    predFlag#_137 := true;
    assume #Node.invRight#trigger(Heap[this, Node.next]);
    predVer#_136 := Heap[Heap[this, Node.next], Node.invRight];
    // unfolding
    assume (0 < unfoldingK#_143) && ((1000 * unfoldingK#_143) < Fractions(1));
    predFlag#_142 := true;
    assert {:msg "  27.52: Receiver might be null."} true ==> (this != null);
    assert {:msg "  27.52: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  27.52: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
    unfoldingHeap#_138 := Heap;
    unfoldingMask#_139 := Mask;
    unfoldingSecMask#_140 := SecMask;
    unfoldingCredits#_141 := Credits;
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    // begin exhale (unfolding)
    assert {:msg "  27.42: Unfolding might fail. The permission at 27.52 might not be positive."} Fractions(100) > 0;
    assert {:msg "  27.42: Unfolding might fail. Insufficient fraction at 27.52 for Node.invRight."} (Fractions(100) <= unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.invRight][perm$R]) && ((Fractions(100) == unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.invRight][perm$R]) ==> (0 <= unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.invRight][perm$N]));
    unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.invRight] := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.invRight][perm$R := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], mu], unfoldingHeap#_138[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], mu]);
      }
      unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.prev] := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.prev][perm$N := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      if (unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.prev] := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.next] := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.next][perm$N := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      if (unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.next][perm$N] < 0) {
        unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.next] := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], mu] := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], mu][perm$N := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      if (unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], mu][perm$N] < 0) {
        unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], mu] := unfoldingSecMask#_140[unfoldingHeap#_138[this, Node.next], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      if (!(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next] == null)) {
        unfoldingSecMask#_140[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_140[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight][perm$R := unfoldingSecMask#_140[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_140[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          unfoldingSecMask#_140[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_140[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      }
      assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
      // end exhale
    }
    if (!CanRead(unfoldingMask#_139, unfoldingSecMask#_140, unfoldingHeap#_138[this, Node.next], Node.invRight)) {
      oldVers#_153 := unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.invRight];
      havoc newVers#_154;
      unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.invRight] := newVers#_154;
      assume oldVers#_153 < unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.invRight];
    }
    assume IsGoodMask(unfoldingMask#_139);
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume IsGoodMask(unfoldingMask#_139);
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    // end exhale
    // inhale (unfolding)
    assume unfoldingHeap#_138[this, Node.next] != null;
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume (unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.prev] == null) || (dtype(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.prev] := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.prev][perm$N := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume IsGoodMask(unfoldingMask#_139);
    assume IsGoodState(heapFragment(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.prev]));
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume unfoldingHeap#_138[this, Node.next] != null;
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume (unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next] == null) || (dtype(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.next] := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.next][perm$N := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume IsGoodMask(unfoldingMask#_139);
    assume IsGoodState(heapFragment(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next]));
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume unfoldingHeap#_138[this, Node.next] != null;
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume true;
    assume 1 > 0;
    unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], mu] := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], mu][perm$N := unfoldingMask#_139[unfoldingHeap#_138[this, Node.next], mu][perm$N] + 1];
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume IsGoodMask(unfoldingMask#_139);
    assume IsGoodState(heapFragment(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], mu]));
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    if (!(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next] == null)) {
      assume unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next] != null;
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume Fractions(100) > 0;
      unfoldingMask#_139[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight] := unfoldingMask#_139[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight][perm$R := unfoldingMask#_139[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_139);
      assume IsGoodState(heapFragment(unfoldingHeap#_138[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], Node.invRight]));
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      predRec#_155 := Heap[Heap[this, Node.next], Node.next];
      predFlag#_157 := true;
      assume #Node.invRight#trigger(Heap[Heap[this, Node.next], Node.next]);
      predVer#_156 := unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.invRight];
      if (false) {
        // begin exhale (update SecMask)
        if (!(unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
          assume MuBelow(unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], mu], unfoldingHeap#_138[unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next], mu]);
        }
        unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.prev] := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] - 1];
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        if (unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] < 0) {
          unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.prev] := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := 0];
        }
        assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.next] := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] - 1];
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        if (unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] < 0) {
          unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.next] := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := 0];
        }
        assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], mu] := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], mu][perm$N := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], mu][perm$N] - 1];
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        if (unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], mu][perm$N] < 0) {
          unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], mu] := unfoldingSecMask#_140[Heap[Heap[this, Node.next], Node.next], mu][perm$N := 0];
        }
        assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        if (!(unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          unfoldingSecMask#_140[unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := unfoldingSecMask#_140[unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := unfoldingSecMask#_140[unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_140[unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
            unfoldingSecMask#_140[unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := unfoldingSecMask#_140[unfoldingHeap#_138[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
          }
          assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
          assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        }
        assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
        // end exhale
      }
      assume predRec#_155 != null;
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume (unfoldingHeap#_138[predRec#_155, Node.prev] == null) || (dtype(unfoldingHeap#_138[predRec#_155, Node.prev]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_140[predRec#_155, Node.prev] := unfoldingSecMask#_140[predRec#_155, Node.prev][perm$N := unfoldingSecMask#_140[predRec#_155, Node.prev][perm$N] + 1];
      assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
      assume IsGoodMask(unfoldingMask#_139);
      assume IsGoodState(heapFragment(unfoldingHeap#_138[predRec#_155, Node.prev]));
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume predRec#_155 != null;
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume (unfoldingHeap#_138[predRec#_155, Node.next] == null) || (dtype(unfoldingHeap#_138[predRec#_155, Node.next]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_140[predRec#_155, Node.next] := unfoldingSecMask#_140[predRec#_155, Node.next][perm$N := unfoldingSecMask#_140[predRec#_155, Node.next][perm$N] + 1];
      assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
      assume IsGoodMask(unfoldingMask#_139);
      assume IsGoodState(heapFragment(unfoldingHeap#_138[predRec#_155, Node.next]));
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume predRec#_155 != null;
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume true;
      assume 1 > 0;
      unfoldingSecMask#_140[predRec#_155, mu] := unfoldingSecMask#_140[predRec#_155, mu][perm$N := unfoldingSecMask#_140[predRec#_155, mu][perm$N] + 1];
      assume wf(unfoldingHeap#_138, unfoldingSecMask#_140, unfoldingSecMask#_140);
      assume IsGoodMask(unfoldingMask#_139);
      assume IsGoodState(heapFragment(unfoldingHeap#_138[predRec#_155, mu]));
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      if (!(unfoldingHeap#_138[predRec#_155, Node.next] == null)) {
        assume unfoldingHeap#_138[predRec#_155, Node.next] != null;
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        assume Fractions(100) > 0;
        unfoldingSecMask#_140[unfoldingHeap#_138[predRec#_155, Node.next], Node.invRight] := unfoldingSecMask#_140[unfoldingHeap#_138[predRec#_155, Node.next], Node.invRight][perm$R := unfoldingSecMask#_140[unfoldingHeap#_138[predRec#_155, Node.next], Node.invRight][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_139);
        assume IsGoodState(heapFragment(unfoldingHeap#_138[unfoldingHeap#_138[predRec#_155, Node.next], Node.invRight]));
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
        assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
      }
      assume MuBelow(unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], mu], unfoldingHeap#_138[unfoldingHeap#_138[unfoldingHeap#_138[this, Node.next], Node.next], mu]);
    }
    assume IsGoodMask(unfoldingMask#_139);
    assume wf(unfoldingHeap#_138, unfoldingMask#_139, unfoldingSecMask#_140);
    // end inhale
    if (false) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(Heap[Heap[this, Node.next], mu], Heap[Heap[Heap[this, Node.next], Node.next], mu]);
      }
      SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := SecMask[Heap[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := SecMask[Heap[this, Node.next], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := SecMask[Heap[this, Node.next], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.prev] == null) || (dtype(Heap[Heap[this, Node.next], Node.prev]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := SecMask[Heap[this, Node.next], Node.prev][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.next] == null) || (dtype(Heap[Heap[this, Node.next], Node.next]) == Node#t);
    assume 1 > 0;
    SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := SecMask[Heap[this, Node.next], Node.next][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := SecMask[Heap[this, Node.next], mu][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
      assume Heap[Heap[this, Node.next], Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assert {:msg "  27.69: Receiver might be null."} true ==> (this != null);
    assert {:msg "  27.69: Location might not be readable."} true ==> CanRead(unfoldingMask#_139, unfoldingSecMask#_140, this, mu);
    assert {:msg "  27.80: Receiver might be null."} true ==> (this != null);
    assert {:msg "  27.80: Location might not be readable."} true ==> CanRead(unfoldingMask#_139, unfoldingSecMask#_140, this, Node.next);
    assert {:msg "  27.80: Receiver might be null."} true ==> (unfoldingHeap#_138[this, Node.next] != null);
    assert {:msg "  27.80: Location might not be readable."} true ==> CanRead(unfoldingMask#_139, unfoldingSecMask#_140, unfoldingHeap#_138[this, Node.next], mu);
    assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // Line #25:     predicate invRight {  
  assert {:msg "  25.5: SMOKE-TEST-53. (Predicate Node.invRight is equivalent to false.)"}{:subsumption 0} !(1 == 1);
}
procedure Node.delete$checkDefinedness(this: ref where (this == null) || (dtype(this) == Node#t)) returns (newList#0: ref where (newList#0 == null) || (dtype(newList#0) == Node#t))
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var methodK#_170: int;
  var predRec#_171: ref;
  var predFlag#_173: bool;
  var predVer#_172: int;
  var unfoldingK#_179: int;
  var predFlag#_178: bool;
  var unfoldingHeap#_174: HeapType;
  var unfoldingMask#_175: MaskType;
  var unfoldingSecMask#_176: MaskType;
  var unfoldingCredits#_177: CreditsType;
  var oldVers#_190: int;
  var newVers#_191: int;
  var predRec#_192: ref;
  var predFlag#_194: bool;
  var predVer#_193: int;
  var predRec#_201: ref;
  var predFlag#_203: bool;
  var predVer#_202: int;
  var unfoldingK#_222: int;
  var predFlag#_221: bool;
  var unfoldingHeap#_217: HeapType;
  var unfoldingMask#_218: MaskType;
  var unfoldingSecMask#_219: MaskType;
  var unfoldingCredits#_220: CreditsType;
  var oldVers#_232: int;
  var newVers#_233: int;
  var predRec#_234: ref;
  var predFlag#_236: bool;
  var predVer#_235: int;
  var unfoldingK#_254: int;
  var predFlag#_253: bool;
  var unfoldingHeap#_249: HeapType;
  var unfoldingMask#_250: MaskType;
  var unfoldingSecMask#_251: MaskType;
  var unfoldingCredits#_252: CreditsType;
  var oldVers#_264: int;
  var newVers#_265: int;
  var predRec#_266: ref;
  var predFlag#_268: bool;
  var predVer#_267: int;
  var unfoldingK#_289: int;
  var predFlag#_288: bool;
  var unfoldingHeap#_284: HeapType;
  var unfoldingMask#_285: MaskType;
  var unfoldingSecMask#_286: MaskType;
  var unfoldingCredits#_287: CreditsType;
  var oldVers#_300: int;
  var newVers#_301: int;
  var predRec#_302: ref;
  var predFlag#_304: bool;
  var predVer#_303: int;
  var predRec#_311: ref;
  var predFlag#_313: bool;
  var predVer#_312: int;
  assume (0 < methodK#_170) && ((1000 * methodK#_170) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  assert {:msg "  31.18: Receiver might be null."} this != null;
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this, Node.inv] := Mask[this, Node.inv][perm$R := Mask[this, Node.inv][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.inv]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  predRec#_171 := this;
  predFlag#_173 := true;
  assume #Node.inv#trigger(this);
  predVer#_172 := Heap[this, Node.inv];
  // unfolding
  assume (0 < unfoldingK#_179) && ((1000 * unfoldingK#_179) < Fractions(1));
  predFlag#_178 := true;
  assert {:msg "  32.28: Receiver might be null."} true ==> (this != null);
  unfoldingHeap#_174 := Heap;
  unfoldingMask#_175 := Mask;
  unfoldingSecMask#_176 := SecMask;
  unfoldingCredits#_177 := Credits;
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  // begin exhale (unfolding)
  assert {:msg "  32.18: Unfolding might fail. The permission at 32.28 might not be positive."} Fractions(100) > 0;
  assert {:msg "  32.18: Unfolding might fail. Insufficient fraction at 32.28 for Node.inv."} (Fractions(100) <= unfoldingMask#_175[this, Node.inv][perm$R]) && ((Fractions(100) == unfoldingMask#_175[this, Node.inv][perm$R]) ==> (0 <= unfoldingMask#_175[this, Node.inv][perm$N]));
  unfoldingMask#_175[this, Node.inv] := unfoldingMask#_175[this, Node.inv][perm$R := unfoldingMask#_175[this, Node.inv][perm$R] - Fractions(100)];
  if (false) {
    // begin exhale (update SecMask)
    if (!(unfoldingHeap#_174[this, Node.prev] == null)) {
      //  assert <undefined position>:  The expression at 18.41 might not evaluate to true.
      assume MuBelow(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], mu], unfoldingHeap#_174[this, mu]);
    }
    if (!(unfoldingHeap#_174[this, Node.next] == null)) {
      //  assert <undefined position>:  The expression at 19.42 might not evaluate to true.
      assume MuBelow(unfoldingHeap#_174[this, mu], unfoldingHeap#_174[unfoldingHeap#_174[this, Node.next], mu]);
    }
    unfoldingSecMask#_176[this, Node.prev] := unfoldingSecMask#_176[this, Node.prev][perm$N := unfoldingSecMask#_176[this, Node.prev][perm$N] - 1];
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    if (unfoldingSecMask#_176[this, Node.prev][perm$N] < 0) {
      unfoldingSecMask#_176[this, Node.prev] := unfoldingSecMask#_176[this, Node.prev][perm$N := 0];
    }
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    unfoldingSecMask#_176[this, Node.next] := unfoldingSecMask#_176[this, Node.next][perm$N := unfoldingSecMask#_176[this, Node.next][perm$N] - 1];
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    if (unfoldingSecMask#_176[this, Node.next][perm$N] < 0) {
      unfoldingSecMask#_176[this, Node.next] := unfoldingSecMask#_176[this, Node.next][perm$N := 0];
    }
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    unfoldingSecMask#_176[this, mu] := unfoldingSecMask#_176[this, mu][perm$N := unfoldingSecMask#_176[this, mu][perm$N] - 1];
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    if (unfoldingSecMask#_176[this, mu][perm$N] < 0) {
      unfoldingSecMask#_176[this, mu] := unfoldingSecMask#_176[this, mu][perm$N := 0];
    }
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    if (!(unfoldingHeap#_174[this, Node.prev] == null)) {
      unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if (unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.invLeft][perm$R] < 0) {
        unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.invLeft][perm$R := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    }
    if (!(unfoldingHeap#_174[this, Node.next] == null)) {
      unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.next], Node.invRight] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.next], Node.invRight][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
      if (unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.next], Node.invRight][perm$R] < 0) {
        unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.next], Node.invRight] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.next], Node.invRight][perm$R := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    }
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    // end exhale
  }
  if (!CanRead(unfoldingMask#_175, unfoldingSecMask#_176, this, Node.inv)) {
    oldVers#_190 := unfoldingHeap#_174[this, Node.inv];
    havoc newVers#_191;
    unfoldingHeap#_174[this, Node.inv] := newVers#_191;
    assume oldVers#_190 < unfoldingHeap#_174[this, Node.inv];
  }
  assume IsGoodMask(unfoldingMask#_175);
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume IsGoodMask(unfoldingMask#_175);
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  // end exhale
  // inhale (unfolding)
  assume this != null;
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume (unfoldingHeap#_174[this, Node.prev] == null) || (dtype(unfoldingHeap#_174[this, Node.prev]) == Node#t);
  assume 1 > 0;
  unfoldingMask#_175[this, Node.prev] := unfoldingMask#_175[this, Node.prev][perm$N := unfoldingMask#_175[this, Node.prev][perm$N] + 1];
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume IsGoodMask(unfoldingMask#_175);
  assume IsGoodState(heapFragment(unfoldingHeap#_174[this, Node.prev]));
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume this != null;
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume (unfoldingHeap#_174[this, Node.next] == null) || (dtype(unfoldingHeap#_174[this, Node.next]) == Node#t);
  assume 1 > 0;
  unfoldingMask#_175[this, Node.next] := unfoldingMask#_175[this, Node.next][perm$N := unfoldingMask#_175[this, Node.next][perm$N] + 1];
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume IsGoodMask(unfoldingMask#_175);
  assume IsGoodState(heapFragment(unfoldingHeap#_174[this, Node.next]));
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume this != null;
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume true;
  assume 1 > 0;
  unfoldingMask#_175[this, mu] := unfoldingMask#_175[this, mu][perm$N := unfoldingMask#_175[this, mu][perm$N] + 1];
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume IsGoodMask(unfoldingMask#_175);
  assume IsGoodState(heapFragment(unfoldingHeap#_174[this, mu]));
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  if (!(unfoldingHeap#_174[this, Node.prev] == null)) {
    assume unfoldingHeap#_174[this, Node.prev] != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume Fractions(100) > 0;
    unfoldingMask#_175[unfoldingHeap#_174[this, Node.prev], Node.invLeft] := unfoldingMask#_175[unfoldingHeap#_174[this, Node.prev], Node.invLeft][perm$R := unfoldingMask#_175[unfoldingHeap#_174[this, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.invLeft]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    predRec#_192 := Heap[this, Node.prev];
    predFlag#_194 := true;
    assume #Node.invLeft#trigger(Heap[this, Node.prev]);
    predVer#_193 := unfoldingHeap#_174[Heap[this, Node.prev], Node.invLeft];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_174[Heap[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_174[unfoldingHeap#_174[Heap[this, Node.prev], Node.prev], mu], unfoldingHeap#_174[Heap[this, Node.prev], mu]);
      }
      unfoldingSecMask#_176[Heap[this, Node.prev], Node.prev] := unfoldingSecMask#_176[Heap[this, Node.prev], Node.prev][perm$N := unfoldingSecMask#_176[Heap[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[Heap[this, Node.prev], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_176[Heap[this, Node.prev], Node.prev] := unfoldingSecMask#_176[Heap[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      unfoldingSecMask#_176[Heap[this, Node.prev], Node.next] := unfoldingSecMask#_176[Heap[this, Node.prev], Node.next][perm$N := unfoldingSecMask#_176[Heap[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[Heap[this, Node.prev], Node.next][perm$N] < 0) {
        unfoldingSecMask#_176[Heap[this, Node.prev], Node.next] := unfoldingSecMask#_176[Heap[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      unfoldingSecMask#_176[Heap[this, Node.prev], mu] := unfoldingSecMask#_176[Heap[this, Node.prev], mu][perm$N := unfoldingSecMask#_176[Heap[this, Node.prev], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[Heap[this, Node.prev], mu][perm$N] < 0) {
        unfoldingSecMask#_176[Heap[this, Node.prev], mu] := unfoldingSecMask#_176[Heap[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (!(unfoldingHeap#_174[Heap[this, Node.prev], Node.prev] == null)) {
        unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
        assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      // end exhale
    }
    assume predRec#_192 != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume (unfoldingHeap#_174[predRec#_192, Node.prev] == null) || (dtype(unfoldingHeap#_174[predRec#_192, Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_176[predRec#_192, Node.prev] := unfoldingSecMask#_176[predRec#_192, Node.prev][perm$N := unfoldingSecMask#_176[predRec#_192, Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[predRec#_192, Node.prev]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume predRec#_192 != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume (unfoldingHeap#_174[predRec#_192, Node.next] == null) || (dtype(unfoldingHeap#_174[predRec#_192, Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_176[predRec#_192, Node.next] := unfoldingSecMask#_176[predRec#_192, Node.next][perm$N := unfoldingSecMask#_176[predRec#_192, Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[predRec#_192, Node.next]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume predRec#_192 != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume true;
    assume 1 > 0;
    unfoldingSecMask#_176[predRec#_192, mu] := unfoldingSecMask#_176[predRec#_192, mu][perm$N := unfoldingSecMask#_176[predRec#_192, mu][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[predRec#_192, mu]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    if (!(unfoldingHeap#_174[predRec#_192, Node.prev] == null)) {
      assume unfoldingHeap#_174[predRec#_192, Node.prev] != null;
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      assume Fractions(100) > 0;
      unfoldingSecMask#_176[unfoldingHeap#_174[predRec#_192, Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[predRec#_192, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[predRec#_192, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_175);
      assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[predRec#_192, Node.prev], Node.invLeft]));
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    }
    assume MuBelow(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], mu], unfoldingHeap#_174[this, mu]);
  }
  if (!(unfoldingHeap#_174[this, Node.next] == null)) {
    assume unfoldingHeap#_174[this, Node.next] != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume Fractions(100) > 0;
    unfoldingMask#_175[unfoldingHeap#_174[this, Node.next], Node.invRight] := unfoldingMask#_175[unfoldingHeap#_174[this, Node.next], Node.invRight][perm$R := unfoldingMask#_175[unfoldingHeap#_174[this, Node.next], Node.invRight][perm$R] + Fractions(100)];
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.next], Node.invRight]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    predRec#_201 := Heap[this, Node.next];
    predFlag#_203 := true;
    assume #Node.invRight#trigger(Heap[this, Node.next]);
    predVer#_202 := unfoldingHeap#_174[Heap[this, Node.next], Node.invRight];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_174[Heap[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_174[Heap[this, Node.next], mu], unfoldingHeap#_174[unfoldingHeap#_174[Heap[this, Node.next], Node.next], mu]);
      }
      unfoldingSecMask#_176[Heap[this, Node.next], Node.prev] := unfoldingSecMask#_176[Heap[this, Node.next], Node.prev][perm$N := unfoldingSecMask#_176[Heap[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[Heap[this, Node.next], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_176[Heap[this, Node.next], Node.prev] := unfoldingSecMask#_176[Heap[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      unfoldingSecMask#_176[Heap[this, Node.next], Node.next] := unfoldingSecMask#_176[Heap[this, Node.next], Node.next][perm$N := unfoldingSecMask#_176[Heap[this, Node.next], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[Heap[this, Node.next], Node.next][perm$N] < 0) {
        unfoldingSecMask#_176[Heap[this, Node.next], Node.next] := unfoldingSecMask#_176[Heap[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      unfoldingSecMask#_176[Heap[this, Node.next], mu] := unfoldingSecMask#_176[Heap[this, Node.next], mu][perm$N := unfoldingSecMask#_176[Heap[this, Node.next], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[Heap[this, Node.next], mu][perm$N] < 0) {
        unfoldingSecMask#_176[Heap[this, Node.next], mu] := unfoldingSecMask#_176[Heap[this, Node.next], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (!(unfoldingHeap#_174[Heap[this, Node.next], Node.next] == null)) {
        unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.next], Node.next], Node.invRight][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_176[unfoldingHeap#_174[Heap[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
        assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      // end exhale
    }
    assume predRec#_201 != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume (unfoldingHeap#_174[predRec#_201, Node.prev] == null) || (dtype(unfoldingHeap#_174[predRec#_201, Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_176[predRec#_201, Node.prev] := unfoldingSecMask#_176[predRec#_201, Node.prev][perm$N := unfoldingSecMask#_176[predRec#_201, Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[predRec#_201, Node.prev]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume predRec#_201 != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume (unfoldingHeap#_174[predRec#_201, Node.next] == null) || (dtype(unfoldingHeap#_174[predRec#_201, Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_176[predRec#_201, Node.next] := unfoldingSecMask#_176[predRec#_201, Node.next][perm$N := unfoldingSecMask#_176[predRec#_201, Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[predRec#_201, Node.next]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume predRec#_201 != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume true;
    assume 1 > 0;
    unfoldingSecMask#_176[predRec#_201, mu] := unfoldingSecMask#_176[predRec#_201, mu][perm$N := unfoldingSecMask#_176[predRec#_201, mu][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[predRec#_201, mu]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    if (!(unfoldingHeap#_174[predRec#_201, Node.next] == null)) {
      assume unfoldingHeap#_174[predRec#_201, Node.next] != null;
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      assume Fractions(100) > 0;
      unfoldingSecMask#_176[unfoldingHeap#_174[predRec#_201, Node.next], Node.invRight] := unfoldingSecMask#_176[unfoldingHeap#_174[predRec#_201, Node.next], Node.invRight][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[predRec#_201, Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_175);
      assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[predRec#_201, Node.next], Node.invRight]));
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    }
    assume MuBelow(unfoldingHeap#_174[this, mu], unfoldingHeap#_174[unfoldingHeap#_174[this, Node.next], mu]);
  }
  assume IsGoodMask(unfoldingMask#_175);
  assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
  // end inhale
  if (false) {
    // begin exhale (update SecMask)
    if (!(Heap[this, Node.prev] == null)) {
      //  assert <undefined position>:  The expression at 18.41 might not evaluate to true.
      assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
    }
    if (!(Heap[this, Node.next] == null)) {
      //  assert <undefined position>:  The expression at 19.42 might not evaluate to true.
      assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
    }
    SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := SecMask[this, Node.prev][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.prev][perm$N] < 0) {
      SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := SecMask[this, Node.next][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.next][perm$N] < 0) {
      SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, mu] := SecMask[this, mu][perm$N := SecMask[this, mu][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, mu][perm$N] < 0) {
      SecMask[this, mu] := SecMask[this, mu][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[this, Node.prev] == null)) {
      SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] < 0) {
        SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, Node.next] == null)) {
      SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := SecMask[Heap[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.next], Node.invRight][perm$R] < 0) {
        SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
  assume 1 > 0;
  SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := SecMask[this, Node.prev][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
  assume 1 > 0;
  SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := SecMask[this, Node.next][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume 1 > 0;
  SecMask[this, mu] := SecMask[this, mu][perm$N := SecMask[this, mu][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this, Node.prev] == null)) {
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.invLeft]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, Node.next] == null)) {
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := SecMask[Heap[this, Node.next], Node.invRight][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.invRight]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  assert {:msg "  33.22: Receiver might be null."} true ==> (this != null);
  assert {:msg "  33.22: Location might not be readable."} true ==> CanRead(unfoldingMask#_175, unfoldingSecMask#_176, this, Node.prev);
  if (!(unfoldingHeap#_174[this, Node.prev] == null)) {
    // unfolding
    assume (0 < unfoldingK#_222) && ((1000 * unfoldingK#_222) < Fractions(1));
    predFlag#_221 := true;
    assert {:msg "  34.31: Receiver might be null."} true ==> (this != null);
    assert {:msg "  34.31: Location might not be readable."} true ==> CanRead(unfoldingMask#_175, unfoldingSecMask#_176, this, Node.prev);
    assert {:msg "  34.31: Receiver might be null."} true ==> (unfoldingHeap#_174[this, Node.prev] != null);
    unfoldingHeap#_217 := unfoldingHeap#_174;
    unfoldingMask#_218 := unfoldingMask#_175;
    unfoldingSecMask#_219 := unfoldingSecMask#_176;
    unfoldingCredits#_220 := unfoldingCredits#_177;
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    // begin exhale (unfolding)
    assert {:msg "  34.21: Unfolding might fail. The permission at 34.31 might not be positive."} Fractions(100) > 0;
    assert {:msg "  34.21: Unfolding might fail. Insufficient fraction at 34.31 for Node.invLeft."} (Fractions(100) <= unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.invLeft][perm$R]) ==> (0 <= unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.invLeft][perm$N]));
    unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.invLeft] := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.invLeft][perm$R := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu], unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], mu]);
      }
      unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.prev] := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.prev][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      if (unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.prev] := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.next] := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.next][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      if (unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.next][perm$N] < 0) {
        unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.next] := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], mu] := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], mu][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      if (unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], mu][perm$N] < 0) {
        unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], mu] := unfoldingSecMask#_219[unfoldingHeap#_217[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      if (!(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] == null)) {
        unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      }
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      // end exhale
    }
    if (!CanRead(unfoldingMask#_218, unfoldingSecMask#_219, unfoldingHeap#_217[this, Node.prev], Node.invLeft)) {
      oldVers#_232 := unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.invLeft];
      havoc newVers#_233;
      unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.invLeft] := newVers#_233;
      assume oldVers#_232 < unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.invLeft];
    }
    assume IsGoodMask(unfoldingMask#_218);
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume IsGoodMask(unfoldingMask#_218);
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    // end exhale
    // inhale (unfolding)
    assume unfoldingHeap#_217[this, Node.prev] != null;
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume (unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] == null) || (dtype(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.prev] := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.prev][perm$N := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume IsGoodMask(unfoldingMask#_218);
    assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev]));
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume unfoldingHeap#_217[this, Node.prev] != null;
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume (unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.next] == null) || (dtype(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.next] := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.next][perm$N := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume IsGoodMask(unfoldingMask#_218);
    assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.next]));
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume unfoldingHeap#_217[this, Node.prev] != null;
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume true;
    assume 1 > 0;
    unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], mu] := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], mu][perm$N := unfoldingMask#_218[unfoldingHeap#_217[this, Node.prev], mu][perm$N] + 1];
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume IsGoodMask(unfoldingMask#_218);
    assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], mu]));
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    if (!(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] == null)) {
      assume unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume Fractions(100) > 0;
      unfoldingMask#_218[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft] := unfoldingMask#_218[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingMask#_218[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_218);
      assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.invLeft]));
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      predRec#_234 := Heap[Heap[this, Node.prev], Node.prev];
      predFlag#_236 := true;
      assume #Node.invLeft#trigger(Heap[Heap[this, Node.prev], Node.prev]);
      predVer#_235 := unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft];
      if (false) {
        // begin exhale (update SecMask)
        if (!(unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(unfoldingHeap#_217[unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu], unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], mu]);
        }
        unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
          unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
          unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := 0];
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] < 0) {
          unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_219[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := 0];
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (!(unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          unfoldingSecMask#_219[unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_219[unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_219[unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            unfoldingSecMask#_219[unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
          assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        // end exhale
      }
      assume predRec#_234 != null;
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume (unfoldingHeap#_217[predRec#_234, Node.prev] == null) || (dtype(unfoldingHeap#_217[predRec#_234, Node.prev]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_219[predRec#_234, Node.prev] := unfoldingSecMask#_219[predRec#_234, Node.prev][perm$N := unfoldingSecMask#_219[predRec#_234, Node.prev][perm$N] + 1];
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume IsGoodMask(unfoldingMask#_218);
      assume IsGoodState(heapFragment(unfoldingHeap#_217[predRec#_234, Node.prev]));
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume predRec#_234 != null;
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume (unfoldingHeap#_217[predRec#_234, Node.next] == null) || (dtype(unfoldingHeap#_217[predRec#_234, Node.next]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_219[predRec#_234, Node.next] := unfoldingSecMask#_219[predRec#_234, Node.next][perm$N := unfoldingSecMask#_219[predRec#_234, Node.next][perm$N] + 1];
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume IsGoodMask(unfoldingMask#_218);
      assume IsGoodState(heapFragment(unfoldingHeap#_217[predRec#_234, Node.next]));
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume predRec#_234 != null;
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume true;
      assume 1 > 0;
      unfoldingSecMask#_219[predRec#_234, mu] := unfoldingSecMask#_219[predRec#_234, mu][perm$N := unfoldingSecMask#_219[predRec#_234, mu][perm$N] + 1];
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume IsGoodMask(unfoldingMask#_218);
      assume IsGoodState(heapFragment(unfoldingHeap#_217[predRec#_234, mu]));
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      if (!(unfoldingHeap#_217[predRec#_234, Node.prev] == null)) {
        assume unfoldingHeap#_217[predRec#_234, Node.prev] != null;
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        assume Fractions(100) > 0;
        unfoldingSecMask#_219[unfoldingHeap#_217[predRec#_234, Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[predRec#_234, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_219[unfoldingHeap#_217[predRec#_234, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_218);
        assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[predRec#_234, Node.prev], Node.invLeft]));
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      }
      assume MuBelow(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu], unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], mu]);
    }
    assume IsGoodMask(unfoldingMask#_218);
    assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
    // end inhale
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_174[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], mu], unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], mu]);
      }
      unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev][perm$N := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next][perm$N := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next][perm$N] < 0) {
        unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu][perm$N := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu][perm$N] < 0) {
        unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      if (!(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev] == null)) {
        unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
        assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      }
      assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
      // end exhale
    }
    assume unfoldingHeap#_174[this, Node.prev] != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume (unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev] == null) || (dtype(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev][perm$N := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume unfoldingHeap#_174[this, Node.prev] != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume (unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.next] == null) || (dtype(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next][perm$N := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.next]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume unfoldingHeap#_174[this, Node.prev] != null;
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume true;
    assume 1 > 0;
    unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu] := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu][perm$N := unfoldingSecMask#_176[unfoldingHeap#_174[this, Node.prev], mu][perm$N] + 1];
    assume wf(unfoldingHeap#_174, unfoldingSecMask#_176, unfoldingSecMask#_176);
    assume IsGoodMask(unfoldingMask#_175);
    assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], mu]));
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    if (!(unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev] == null)) {
      assume unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      assume Fractions(100) > 0;
      unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_176[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_175);
      assume IsGoodState(heapFragment(unfoldingHeap#_174[unfoldingHeap#_174[unfoldingHeap#_174[this, Node.prev], Node.prev], Node.invLeft]));
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
      assume wf(unfoldingHeap#_174, unfoldingMask#_175, unfoldingSecMask#_176);
    }
    assert {:msg "  35.25: Receiver might be null."} true ==> (this != null);
    assert {:msg "  35.25: Location might not be readable."} true ==> CanRead(unfoldingMask#_218, unfoldingSecMask#_219, this, Node.prev);
    assert {:msg "  35.25: Receiver might be null."} true ==> (unfoldingHeap#_217[this, Node.prev] != null);
    assert {:msg "  35.25: Location might not be readable."} true ==> CanRead(unfoldingMask#_218, unfoldingSecMask#_219, unfoldingHeap#_217[this, Node.prev], Node.prev);
    if (!(unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] == null)) {
      // unfolding
      assume (0 < unfoldingK#_254) && ((1000 * unfoldingK#_254) < Fractions(1));
      predFlag#_253 := true;
      assert {:msg "  36.35: Receiver might be null."} true ==> (this != null);
      assert {:msg "  36.35: Location might not be readable."} true ==> CanRead(unfoldingMask#_218, unfoldingSecMask#_219, this, Node.prev);
      assert {:msg "  36.35: Receiver might be null."} true ==> (unfoldingHeap#_217[this, Node.prev] != null);
      assert {:msg "  36.35: Location might not be readable."} true ==> CanRead(unfoldingMask#_218, unfoldingSecMask#_219, unfoldingHeap#_217[this, Node.prev], Node.prev);
      assert {:msg "  36.35: Receiver might be null."} true ==> (unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] != null);
      unfoldingHeap#_249 := unfoldingHeap#_217;
      unfoldingMask#_250 := unfoldingMask#_218;
      unfoldingSecMask#_251 := unfoldingSecMask#_219;
      unfoldingCredits#_252 := unfoldingCredits#_220;
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      // begin exhale (unfolding)
      assert {:msg "  36.25: Unfolding might fail. The permission at 36.35 might not be positive."} Fractions(100) > 0;
      assert {:msg "  36.25: Unfolding might fail. Insufficient fraction at 36.35 for Node.invLeft."} (Fractions(100) <= unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft][perm$R]) ==> (0 <= unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft][perm$N]));
      unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft] := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if (false) {
        // begin exhale (update SecMask)
        if (!(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], mu], unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu]);
        }
        unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev][perm$N := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        if (unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
          unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next][perm$N := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        if (unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
          unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next][perm$N := 0];
        }
        assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu][perm$N := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        if (unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu][perm$N] < 0) {
          unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu][perm$N := 0];
        }
        assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        if (!(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] == null)) {
          unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_251[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        }
        assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
        // end exhale
      }
      if (!CanRead(unfoldingMask#_250, unfoldingSecMask#_251, unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft)) {
        oldVers#_264 := unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft];
        havoc newVers#_265;
        unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft] := newVers#_265;
        assume oldVers#_264 < unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.invLeft];
      }
      assume IsGoodMask(unfoldingMask#_250);
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume IsGoodMask(unfoldingMask#_250);
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      // end exhale
      // inhale (unfolding)
      assume unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume (unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] == null) || (dtype(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev]) == Node#t);
      assume 1 > 0;
      unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev][perm$N := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev][perm$N] + 1];
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume IsGoodMask(unfoldingMask#_250);
      assume IsGoodState(heapFragment(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev]));
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume (unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next] == null) || (dtype(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next]) == Node#t);
      assume 1 > 0;
      unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next] := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next][perm$N := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next][perm$N] + 1];
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume IsGoodMask(unfoldingMask#_250);
      assume IsGoodState(heapFragment(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.next]));
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume true;
      assume 1 > 0;
      unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu] := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu][perm$N := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu][perm$N] + 1];
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume IsGoodMask(unfoldingMask#_250);
      assume IsGoodState(heapFragment(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu]));
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      if (!(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] == null)) {
        assume unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev] != null;
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume Fractions(100) > 0;
        unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingMask#_250[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_250);
        assume IsGoodState(heapFragment(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], Node.invLeft]));
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        predRec#_266 := Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
        predFlag#_268 := true;
        assume #Node.invLeft#trigger(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]);
        predVer#_267 := unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft];
        if (false) {
          // begin exhale (update SecMask)
          if (!(unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
            //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
            assume MuBelow(unfoldingHeap#_249[unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu], unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu]);
          }
          unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          if (unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
            unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
          }
          assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next] := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          if (unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
            unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next] := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
          }
          assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu] := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          if (unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
            unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu] := unfoldingSecMask#_251[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
          }
          assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          if (!(unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
            unfoldingSecMask#_251[unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_251[unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_251[unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
            if (unfoldingSecMask#_251[unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
              unfoldingSecMask#_251[unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_251[unfoldingHeap#_249[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
            }
            assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
            assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          }
          assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
          // end exhale
        }
        assume predRec#_266 != null;
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume (unfoldingHeap#_249[predRec#_266, Node.prev] == null) || (dtype(unfoldingHeap#_249[predRec#_266, Node.prev]) == Node#t);
        assume 1 > 0;
        unfoldingSecMask#_251[predRec#_266, Node.prev] := unfoldingSecMask#_251[predRec#_266, Node.prev][perm$N := unfoldingSecMask#_251[predRec#_266, Node.prev][perm$N] + 1];
        assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
        assume IsGoodMask(unfoldingMask#_250);
        assume IsGoodState(heapFragment(unfoldingHeap#_249[predRec#_266, Node.prev]));
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume predRec#_266 != null;
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume (unfoldingHeap#_249[predRec#_266, Node.next] == null) || (dtype(unfoldingHeap#_249[predRec#_266, Node.next]) == Node#t);
        assume 1 > 0;
        unfoldingSecMask#_251[predRec#_266, Node.next] := unfoldingSecMask#_251[predRec#_266, Node.next][perm$N := unfoldingSecMask#_251[predRec#_266, Node.next][perm$N] + 1];
        assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
        assume IsGoodMask(unfoldingMask#_250);
        assume IsGoodState(heapFragment(unfoldingHeap#_249[predRec#_266, Node.next]));
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume predRec#_266 != null;
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume true;
        assume 1 > 0;
        unfoldingSecMask#_251[predRec#_266, mu] := unfoldingSecMask#_251[predRec#_266, mu][perm$N := unfoldingSecMask#_251[predRec#_266, mu][perm$N] + 1];
        assume wf(unfoldingHeap#_249, unfoldingSecMask#_251, unfoldingSecMask#_251);
        assume IsGoodMask(unfoldingMask#_250);
        assume IsGoodState(heapFragment(unfoldingHeap#_249[predRec#_266, mu]));
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        if (!(unfoldingHeap#_249[predRec#_266, Node.prev] == null)) {
          assume unfoldingHeap#_249[predRec#_266, Node.prev] != null;
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          assume Fractions(100) > 0;
          unfoldingSecMask#_251[unfoldingHeap#_249[predRec#_266, Node.prev], Node.invLeft] := unfoldingSecMask#_251[unfoldingHeap#_249[predRec#_266, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_251[unfoldingHeap#_249[predRec#_266, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
          assume IsGoodMask(unfoldingMask#_250);
          assume IsGoodState(heapFragment(unfoldingHeap#_249[unfoldingHeap#_249[predRec#_266, Node.prev], Node.invLeft]));
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
          assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
        }
        assume MuBelow(unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], Node.prev], mu], unfoldingHeap#_249[unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu]);
      }
      assume IsGoodMask(unfoldingMask#_250);
      assume wf(unfoldingHeap#_249, unfoldingMask#_250, unfoldingSecMask#_251);
      // end inhale
      if (false) {
        // begin exhale (update SecMask)
        if (!(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], mu], unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu]);
        }
        unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
          unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
          unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next][perm$N := 0];
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu][perm$N] < 0) {
          unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu][perm$N := 0];
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        if (!(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] == null)) {
          unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
          assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        }
        assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
        // end exhale
      }
      assume unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume (unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] == null) || (dtype(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev][perm$N] + 1];
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume IsGoodMask(unfoldingMask#_218);
      assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev]));
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume (unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next] == null) || (dtype(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next]) == Node#t);
      assume 1 > 0;
      unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next][perm$N] + 1];
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume IsGoodMask(unfoldingMask#_218);
      assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.next]));
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev] != null;
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume true;
      assume 1 > 0;
      unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu][perm$N := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu][perm$N] + 1];
      assume wf(unfoldingHeap#_217, unfoldingSecMask#_219, unfoldingSecMask#_219);
      assume IsGoodMask(unfoldingMask#_218);
      assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], mu]));
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      if (!(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] == null)) {
        assume unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev] != null;
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        assume Fractions(100) > 0;
        unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_219[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_218);
        assume IsGoodState(heapFragment(unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[unfoldingHeap#_217[this, Node.prev], Node.prev], Node.prev], Node.invLeft]));
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
        assume wf(unfoldingHeap#_217, unfoldingMask#_218, unfoldingSecMask#_219);
      }
      assert {:msg "  37.38: Receiver might be null."} true ==> (this != null);
      assert {:msg "  37.38: Location might not be readable."} true ==> CanRead(unfoldingMask#_250, unfoldingSecMask#_251, this, Node.prev);
      assert {:msg "  37.38: Receiver might be null."} true ==> (unfoldingHeap#_249[this, Node.prev] != null);
      assert {:msg "  37.38: Location might not be readable."} true ==> CanRead(unfoldingMask#_250, unfoldingSecMask#_251, unfoldingHeap#_249[this, Node.prev], Node.prev);
      assert {:msg "  37.38: Receiver might be null."} true ==> (unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev] != null);
      assert {:msg "  37.38: Location might not be readable."} true ==> CanRead(unfoldingMask#_250, unfoldingSecMask#_251, unfoldingHeap#_249[unfoldingHeap#_249[this, Node.prev], Node.prev], mu);
    } else {
      assert {:msg "  38.38: Receiver might be null."} true ==> (this != null);
      assert {:msg "  38.38: Location might not be readable."} true ==> CanRead(unfoldingMask#_218, unfoldingSecMask#_219, this, Node.prev);
      assert {:msg "  38.38: Receiver might be null."} true ==> (unfoldingHeap#_217[this, Node.prev] != null);
      assert {:msg "  38.38: Location might not be readable."} true ==> CanRead(unfoldingMask#_218, unfoldingSecMask#_219, unfoldingHeap#_217[this, Node.prev], mu);
    }
  } else {
    assert {:msg "  39.34: Receiver might be null."} true ==> (this != null);
    assert {:msg "  39.34: Location might not be readable."} true ==> CanRead(unfoldingMask#_175, unfoldingSecMask#_176, this, mu);
  }
  assume ite(!(Heap[this, Node.prev] == null), ite(!(Heap[Heap[this, Node.prev], Node.prev] == null), (forall o#_281: ref :: (((0 < Heap[o#_281, held]) || Heap[o#_281, rdheld]) || (Credits[o#_281] < 0)) ==> MuBelow(Heap[o#_281, mu], Heap[Heap[Heap[this, Node.prev], Node.prev], mu])), (forall o#_282: ref :: (((0 < Heap[o#_282, held]) || Heap[o#_282, rdheld]) || (Credits[o#_282] < 0)) ==> MuBelow(Heap[o#_282, mu], Heap[Heap[this, Node.prev], mu]))), (forall o#_283: ref :: (((0 < Heap[o#_283, held]) || Heap[o#_283, rdheld]) || (Credits[o#_283] < 0)) ==> MuBelow(Heap[o#_283, mu], Heap[this, mu])));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume SecMask == old(SecMask);
  assume Credits == old(Credits);
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  // inhale (postcondition)
  assert {:msg "  40.17: Receiver might be null."} this != null;
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this, Node.inv] := Mask[this, Node.inv][perm$R := Mask[this, Node.inv][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.inv]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(newList#0 == null)) {
    assert {:msg "  41.36: Receiver might be null."} newList#0 != null;
    assume newList#0 != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[newList#0, Node.inv] := Mask[newList#0, Node.inv][perm$R := Mask[newList#0, Node.inv][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[newList#0, Node.inv]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  // unfolding
  assume (0 < unfoldingK#_289) && ((1000 * unfoldingK#_289) < Fractions(1));
  predFlag#_288 := true;
  assert {:msg "  42.31: Receiver might be null."} true ==> (this != null);
  unfoldingHeap#_284 := old(Heap);
  unfoldingMask#_285 := old(Mask);
  unfoldingSecMask#_286 := old(SecMask);
  unfoldingCredits#_287 := old(Credits);
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  // begin exhale (unfolding)
  assert {:msg "  42.21: Unfolding might fail. The permission at 42.31 might not be positive."} Fractions(100) > 0;
  assert {:msg "  42.21: Unfolding might fail. Insufficient fraction at 42.31 for Node.inv."} (Fractions(100) <= unfoldingMask#_285[this, Node.inv][perm$R]) && ((Fractions(100) == unfoldingMask#_285[this, Node.inv][perm$R]) ==> (0 <= unfoldingMask#_285[this, Node.inv][perm$N]));
  unfoldingMask#_285[this, Node.inv] := unfoldingMask#_285[this, Node.inv][perm$R := unfoldingMask#_285[this, Node.inv][perm$R] - Fractions(100)];
  if ((false || ((predVer#_172 == unfoldingHeap#_284[this, Node.inv]) && (predRec#_171 == this) && true && predFlag#_173)) || ((Heap[this, Node.inv] == unfoldingHeap#_284[this, Node.inv]) && (this == this) && true && predFlag#_178)) {
    if ((Heap[this, Node.inv] == unfoldingHeap#_284[this, Node.inv]) && (this == this) && true && predFlag#_178) {
    } else {
    }
    // begin exhale (update SecMask)
    if (!(unfoldingHeap#_284[this, Node.prev] == null)) {
      //  assert <undefined position>:  The expression at 18.41 might not evaluate to true.
      assume MuBelow(unfoldingHeap#_284[unfoldingHeap#_284[this, Node.prev], mu], unfoldingHeap#_284[this, mu]);
    }
    if (!(unfoldingHeap#_284[this, Node.next] == null)) {
      //  assert <undefined position>:  The expression at 19.42 might not evaluate to true.
      assume MuBelow(unfoldingHeap#_284[this, mu], unfoldingHeap#_284[unfoldingHeap#_284[this, Node.next], mu]);
    }
    unfoldingSecMask#_286[this, Node.prev] := unfoldingSecMask#_286[this, Node.prev][perm$N := unfoldingSecMask#_286[this, Node.prev][perm$N] - 1];
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    if (unfoldingSecMask#_286[this, Node.prev][perm$N] < 0) {
      unfoldingSecMask#_286[this, Node.prev] := unfoldingSecMask#_286[this, Node.prev][perm$N := 0];
    }
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    unfoldingSecMask#_286[this, Node.next] := unfoldingSecMask#_286[this, Node.next][perm$N := unfoldingSecMask#_286[this, Node.next][perm$N] - 1];
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    if (unfoldingSecMask#_286[this, Node.next][perm$N] < 0) {
      unfoldingSecMask#_286[this, Node.next] := unfoldingSecMask#_286[this, Node.next][perm$N := 0];
    }
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    unfoldingSecMask#_286[this, mu] := unfoldingSecMask#_286[this, mu][perm$N := unfoldingSecMask#_286[this, mu][perm$N] - 1];
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    if (unfoldingSecMask#_286[this, mu][perm$N] < 0) {
      unfoldingSecMask#_286[this, mu] := unfoldingSecMask#_286[this, mu][perm$N := 0];
    }
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    if (!(unfoldingHeap#_284[this, Node.prev] == null)) {
      unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.prev], Node.invLeft] := unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if (unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.prev], Node.invLeft][perm$R] < 0) {
        unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.prev], Node.invLeft] := unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.prev], Node.invLeft][perm$R := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    }
    if (!(unfoldingHeap#_284[this, Node.next] == null)) {
      unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.next], Node.invRight] := unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.next], Node.invRight][perm$R := unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
      if (unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.next], Node.invRight][perm$R] < 0) {
        unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.next], Node.invRight] := unfoldingSecMask#_286[unfoldingHeap#_284[this, Node.next], Node.invRight][perm$R := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    }
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    // end exhale
  }
  if (!CanRead(unfoldingMask#_285, unfoldingSecMask#_286, this, Node.inv)) {
    oldVers#_300 := unfoldingHeap#_284[this, Node.inv];
    havoc newVers#_301;
    unfoldingHeap#_284[this, Node.inv] := newVers#_301;
    assume oldVers#_300 < unfoldingHeap#_284[this, Node.inv];
  }
  assume IsGoodMask(unfoldingMask#_285);
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume IsGoodMask(unfoldingMask#_285);
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  // end exhale
  // inhale (unfolding)
  assume this != null;
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume (unfoldingHeap#_284[this, Node.prev] == null) || (dtype(unfoldingHeap#_284[this, Node.prev]) == Node#t);
  assume 1 > 0;
  unfoldingMask#_285[this, Node.prev] := unfoldingMask#_285[this, Node.prev][perm$N := unfoldingMask#_285[this, Node.prev][perm$N] + 1];
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume IsGoodMask(unfoldingMask#_285);
  assume IsGoodState(heapFragment(unfoldingHeap#_284[this, Node.prev]));
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume this != null;
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume (unfoldingHeap#_284[this, Node.next] == null) || (dtype(unfoldingHeap#_284[this, Node.next]) == Node#t);
  assume 1 > 0;
  unfoldingMask#_285[this, Node.next] := unfoldingMask#_285[this, Node.next][perm$N := unfoldingMask#_285[this, Node.next][perm$N] + 1];
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume IsGoodMask(unfoldingMask#_285);
  assume IsGoodState(heapFragment(unfoldingHeap#_284[this, Node.next]));
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume this != null;
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume true;
  assume 1 > 0;
  unfoldingMask#_285[this, mu] := unfoldingMask#_285[this, mu][perm$N := unfoldingMask#_285[this, mu][perm$N] + 1];
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume IsGoodMask(unfoldingMask#_285);
  assume IsGoodState(heapFragment(unfoldingHeap#_284[this, mu]));
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  if (!(unfoldingHeap#_284[this, Node.prev] == null)) {
    assume unfoldingHeap#_284[this, Node.prev] != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume Fractions(100) > 0;
    unfoldingMask#_285[unfoldingHeap#_284[this, Node.prev], Node.invLeft] := unfoldingMask#_285[unfoldingHeap#_284[this, Node.prev], Node.invLeft][perm$R := unfoldingMask#_285[unfoldingHeap#_284[this, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[unfoldingHeap#_284[this, Node.prev], Node.invLeft]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    predRec#_302 := Heap[this, Node.prev];
    predFlag#_304 := true;
    assume #Node.invLeft#trigger(Heap[this, Node.prev]);
    predVer#_303 := unfoldingHeap#_284[Heap[this, Node.prev], Node.invLeft];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_284[Heap[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_284[unfoldingHeap#_284[Heap[this, Node.prev], Node.prev], mu], unfoldingHeap#_284[Heap[this, Node.prev], mu]);
      }
      unfoldingSecMask#_286[Heap[this, Node.prev], Node.prev] := unfoldingSecMask#_286[Heap[this, Node.prev], Node.prev][perm$N := unfoldingSecMask#_286[Heap[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (unfoldingSecMask#_286[Heap[this, Node.prev], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_286[Heap[this, Node.prev], Node.prev] := unfoldingSecMask#_286[Heap[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      unfoldingSecMask#_286[Heap[this, Node.prev], Node.next] := unfoldingSecMask#_286[Heap[this, Node.prev], Node.next][perm$N := unfoldingSecMask#_286[Heap[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (unfoldingSecMask#_286[Heap[this, Node.prev], Node.next][perm$N] < 0) {
        unfoldingSecMask#_286[Heap[this, Node.prev], Node.next] := unfoldingSecMask#_286[Heap[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      unfoldingSecMask#_286[Heap[this, Node.prev], mu] := unfoldingSecMask#_286[Heap[this, Node.prev], mu][perm$N := unfoldingSecMask#_286[Heap[this, Node.prev], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (unfoldingSecMask#_286[Heap[this, Node.prev], mu][perm$N] < 0) {
        unfoldingSecMask#_286[Heap[this, Node.prev], mu] := unfoldingSecMask#_286[Heap[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (!(unfoldingHeap#_284[Heap[this, Node.prev], Node.prev] == null)) {
        unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.prev], Node.prev], Node.invLeft] := unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
        assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      // end exhale
    }
    assume predRec#_302 != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume (unfoldingHeap#_284[predRec#_302, Node.prev] == null) || (dtype(unfoldingHeap#_284[predRec#_302, Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_286[predRec#_302, Node.prev] := unfoldingSecMask#_286[predRec#_302, Node.prev][perm$N := unfoldingSecMask#_286[predRec#_302, Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[predRec#_302, Node.prev]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume predRec#_302 != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume (unfoldingHeap#_284[predRec#_302, Node.next] == null) || (dtype(unfoldingHeap#_284[predRec#_302, Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_286[predRec#_302, Node.next] := unfoldingSecMask#_286[predRec#_302, Node.next][perm$N := unfoldingSecMask#_286[predRec#_302, Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[predRec#_302, Node.next]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume predRec#_302 != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume true;
    assume 1 > 0;
    unfoldingSecMask#_286[predRec#_302, mu] := unfoldingSecMask#_286[predRec#_302, mu][perm$N := unfoldingSecMask#_286[predRec#_302, mu][perm$N] + 1];
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[predRec#_302, mu]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    if (!(unfoldingHeap#_284[predRec#_302, Node.prev] == null)) {
      assume unfoldingHeap#_284[predRec#_302, Node.prev] != null;
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      assume Fractions(100) > 0;
      unfoldingSecMask#_286[unfoldingHeap#_284[predRec#_302, Node.prev], Node.invLeft] := unfoldingSecMask#_286[unfoldingHeap#_284[predRec#_302, Node.prev], Node.invLeft][perm$R := unfoldingSecMask#_286[unfoldingHeap#_284[predRec#_302, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_285);
      assume IsGoodState(heapFragment(unfoldingHeap#_284[unfoldingHeap#_284[predRec#_302, Node.prev], Node.invLeft]));
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    }
    assume MuBelow(unfoldingHeap#_284[unfoldingHeap#_284[this, Node.prev], mu], unfoldingHeap#_284[this, mu]);
  }
  if (!(unfoldingHeap#_284[this, Node.next] == null)) {
    assume unfoldingHeap#_284[this, Node.next] != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume Fractions(100) > 0;
    unfoldingMask#_285[unfoldingHeap#_284[this, Node.next], Node.invRight] := unfoldingMask#_285[unfoldingHeap#_284[this, Node.next], Node.invRight][perm$R := unfoldingMask#_285[unfoldingHeap#_284[this, Node.next], Node.invRight][perm$R] + Fractions(100)];
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[unfoldingHeap#_284[this, Node.next], Node.invRight]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    predRec#_311 := Heap[this, Node.next];
    predFlag#_313 := true;
    assume #Node.invRight#trigger(Heap[this, Node.next]);
    predVer#_312 := unfoldingHeap#_284[Heap[this, Node.next], Node.invRight];
    if (false) {
      // begin exhale (update SecMask)
      if (!(unfoldingHeap#_284[Heap[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(unfoldingHeap#_284[Heap[this, Node.next], mu], unfoldingHeap#_284[unfoldingHeap#_284[Heap[this, Node.next], Node.next], mu]);
      }
      unfoldingSecMask#_286[Heap[this, Node.next], Node.prev] := unfoldingSecMask#_286[Heap[this, Node.next], Node.prev][perm$N := unfoldingSecMask#_286[Heap[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (unfoldingSecMask#_286[Heap[this, Node.next], Node.prev][perm$N] < 0) {
        unfoldingSecMask#_286[Heap[this, Node.next], Node.prev] := unfoldingSecMask#_286[Heap[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      unfoldingSecMask#_286[Heap[this, Node.next], Node.next] := unfoldingSecMask#_286[Heap[this, Node.next], Node.next][perm$N := unfoldingSecMask#_286[Heap[this, Node.next], Node.next][perm$N] - 1];
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (unfoldingSecMask#_286[Heap[this, Node.next], Node.next][perm$N] < 0) {
        unfoldingSecMask#_286[Heap[this, Node.next], Node.next] := unfoldingSecMask#_286[Heap[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      unfoldingSecMask#_286[Heap[this, Node.next], mu] := unfoldingSecMask#_286[Heap[this, Node.next], mu][perm$N := unfoldingSecMask#_286[Heap[this, Node.next], mu][perm$N] - 1];
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (unfoldingSecMask#_286[Heap[this, Node.next], mu][perm$N] < 0) {
        unfoldingSecMask#_286[Heap[this, Node.next], mu] := unfoldingSecMask#_286[Heap[this, Node.next], mu][perm$N := 0];
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      if (!(unfoldingHeap#_284[Heap[this, Node.next], Node.next] == null)) {
        unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.next], Node.next], Node.invRight][perm$R := unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.next], Node.next], Node.invRight] := unfoldingSecMask#_286[unfoldingHeap#_284[Heap[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
        assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      }
      assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
      // end exhale
    }
    assume predRec#_311 != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume (unfoldingHeap#_284[predRec#_311, Node.prev] == null) || (dtype(unfoldingHeap#_284[predRec#_311, Node.prev]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_286[predRec#_311, Node.prev] := unfoldingSecMask#_286[predRec#_311, Node.prev][perm$N := unfoldingSecMask#_286[predRec#_311, Node.prev][perm$N] + 1];
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[predRec#_311, Node.prev]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume predRec#_311 != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume (unfoldingHeap#_284[predRec#_311, Node.next] == null) || (dtype(unfoldingHeap#_284[predRec#_311, Node.next]) == Node#t);
    assume 1 > 0;
    unfoldingSecMask#_286[predRec#_311, Node.next] := unfoldingSecMask#_286[predRec#_311, Node.next][perm$N := unfoldingSecMask#_286[predRec#_311, Node.next][perm$N] + 1];
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[predRec#_311, Node.next]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume predRec#_311 != null;
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume true;
    assume 1 > 0;
    unfoldingSecMask#_286[predRec#_311, mu] := unfoldingSecMask#_286[predRec#_311, mu][perm$N := unfoldingSecMask#_286[predRec#_311, mu][perm$N] + 1];
    assume wf(unfoldingHeap#_284, unfoldingSecMask#_286, unfoldingSecMask#_286);
    assume IsGoodMask(unfoldingMask#_285);
    assume IsGoodState(heapFragment(unfoldingHeap#_284[predRec#_311, mu]));
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    if (!(unfoldingHeap#_284[predRec#_311, Node.next] == null)) {
      assume unfoldingHeap#_284[predRec#_311, Node.next] != null;
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      assume Fractions(100) > 0;
      unfoldingSecMask#_286[unfoldingHeap#_284[predRec#_311, Node.next], Node.invRight] := unfoldingSecMask#_286[unfoldingHeap#_284[predRec#_311, Node.next], Node.invRight][perm$R := unfoldingSecMask#_286[unfoldingHeap#_284[predRec#_311, Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(unfoldingMask#_285);
      assume IsGoodState(heapFragment(unfoldingHeap#_284[unfoldingHeap#_284[predRec#_311, Node.next], Node.invRight]));
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
      assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
    }
    assume MuBelow(unfoldingHeap#_284[this, mu], unfoldingHeap#_284[unfoldingHeap#_284[this, Node.next], mu]);
  }
  assume IsGoodMask(unfoldingMask#_285);
  assume wf(unfoldingHeap#_284, unfoldingMask#_285, unfoldingSecMask#_286);
  // end inhale
  assert {:msg "  42.38: Receiver might be null."} true ==> (this != null);
  assert {:msg "  42.38: Location might not be readable."} true ==> CanRead(unfoldingMask#_285, unfoldingSecMask#_286, this, Node.next);
  assume old(Heap)[this, Node.next] == newList#0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
}
procedure Node.delete(this: ref where (this == null) || (dtype(this) == Node#t)) returns (newList#0: ref where (newList#0 == null) || (dtype(newList#0) == Node#t))
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var methodK#_170: int;
  var predRec#_320: ref;
  var predFlag#_322: bool;
  var predVer#_321: int;
  var unfoldK#_333: int;
  var oldVers#_344: int;
  var newVers#_345: int;
  var predRec#_346: ref;
  var predFlag#_348: bool;
  var predVer#_347: int;
  var predRec#_355: ref;
  var predFlag#_357: bool;
  var predVer#_356: int;
  var cond#_364: bool;
  var unfoldK#_365: int;
  var oldVers#_375: int;
  var newVers#_376: int;
  var predRec#_377: ref;
  var predFlag#_379: bool;
  var predVer#_378: int;
  var cond#_386: bool;
  var unfoldK#_387: int;
  var oldVers#_397: int;
  var newVers#_398: int;
  var predRec#_399: ref;
  var predFlag#_401: bool;
  var predVer#_400: int;
  var cond#_408: bool;
  var unfoldK#_409: int;
  var oldVers#_419: int;
  var newVers#_420: int;
  var predRec#_421: ref;
  var predFlag#_423: bool;
  var predVer#_422: int;
  var cond#_430: bool;
  var unfoldK#_431: int;
  var oldVers#_441: int;
  var newVers#_442: int;
  var predRec#_443: ref;
  var predFlag#_445: bool;
  var predVer#_444: int;
  var cond#_452: bool;
  var cond#_453: bool;
  var lastSeenMu#_456: Mu;
  var lastSeenHeld#_455: int;
  var lastAcquire#_454: int;
  var sh#5: ref;
  var lastSeenMu#_460: Mu;
  var lastSeenHeld#_459: int;
  var lastAcquire#_458: int;
  var sh#6: ref;
  var lastSeenMu#_464: Mu;
  var lastSeenHeld#_463: int;
  var lastAcquire#_462: int;
  var sh#7: ref;
  var cond#_466: bool;
  var lastSeenMu#_469: Mu;
  var lastSeenHeld#_468: int;
  var lastAcquire#_467: int;
  var sh#8: ref;
  var cond#_471: bool;
  var lastSeenMu#_474: Mu;
  var lastSeenHeld#_473: int;
  var lastAcquire#_472: int;
  var sh#9: ref;
  var oldPrev#2: ref where (oldPrev#2 == null) || (dtype(oldPrev#2) == Node#t);
  var oldNext#4: ref where (oldNext#4 == null) || (dtype(oldNext#4) == Node#t);
  var cond#_476: bool;
  var cond#_477: bool;
  var preReleaseHeap#_480: HeapType;
  var preReleaseMask#_481: MaskType;
  var preReleaseSecMask#_482: MaskType;
  var preReleaseCredits#_483: CreditsType;
  var sh#10: ref;
  var exhaleMask#_485: MaskType;
  var exhaleHeap#_484: HeapType;
  var held#_478: int;
  var cond#_501: bool;
  var cond#_502: bool;
  var preReleaseHeap#_505: HeapType;
  var preReleaseMask#_506: MaskType;
  var preReleaseSecMask#_507: MaskType;
  var preReleaseCredits#_508: CreditsType;
  var sh#11: ref;
  var exhaleMask#_510: MaskType;
  var exhaleHeap#_509: HeapType;
  var held#_503: int;
  var preReleaseHeap#_528: HeapType;
  var preReleaseMask#_529: MaskType;
  var preReleaseSecMask#_530: MaskType;
  var preReleaseCredits#_531: CreditsType;
  var sh#12: ref;
  var exhaleMask#_533: MaskType;
  var exhaleHeap#_532: HeapType;
  var held#_526: int;
  var cond#_549: bool;
  var preReleaseHeap#_552: HeapType;
  var preReleaseMask#_553: MaskType;
  var preReleaseSecMask#_554: MaskType;
  var preReleaseCredits#_555: CreditsType;
  var sh#13: ref;
  var exhaleMask#_557: MaskType;
  var exhaleHeap#_556: HeapType;
  var held#_550: int;
  var cond#_573: bool;
  var preReleaseHeap#_576: HeapType;
  var preReleaseMask#_577: MaskType;
  var preReleaseSecMask#_578: MaskType;
  var preReleaseCredits#_579: CreditsType;
  var sh#14: ref;
  var exhaleMask#_581: MaskType;
  var exhaleHeap#_580: HeapType;
  var held#_574: int;
  var foldK#_600: int;
  var exhaleMask#_602: MaskType;
  var exhaleHeap#_601: HeapType;
  var predRec#_597: ref;
  var predVer#_598: int;
  var predFlag#_599: bool;
  var cond#_608: bool;
  var cond#_609: bool;
  var foldK#_613: int;
  var exhaleMask#_615: MaskType;
  var exhaleHeap#_614: HeapType;
  var predRec#_610: ref;
  var predVer#_611: int;
  var predFlag#_612: bool;
  var cond#_620: bool;
  var cond#_621: bool;
  var foldK#_625: int;
  var exhaleMask#_627: MaskType;
  var exhaleHeap#_626: HeapType;
  var predRec#_622: ref;
  var predVer#_623: int;
  var predFlag#_624: bool;
  var foldK#_635: int;
  var exhaleMask#_637: MaskType;
  var exhaleHeap#_636: HeapType;
  var predRec#_632: ref;
  var predVer#_633: int;
  var predFlag#_634: bool;
  var foldK#_645: int;
  var exhaleMask#_647: MaskType;
  var exhaleHeap#_646: HeapType;
  var predRec#_642: ref;
  var predVer#_643: int;
  var predFlag#_644: bool;
  var exhaleMask#_654: MaskType;
  var exhaleHeap#_653: HeapType;
  assume (0 < methodK#_170) && ((1000 * methodK#_170) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this, Node.inv] := Mask[this, Node.inv][perm$R := Mask[this, Node.inv][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.inv]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  predRec#_320 := this;
  predFlag#_322 := true;
  assume #Node.inv#trigger(this);
  predVer#_321 := Heap[this, Node.inv];
  if (false) {
    // begin exhale (update SecMask)
    if (!(Heap[this, Node.prev] == null)) {
      //  assert <undefined position>:  The expression at 18.41 might not evaluate to true.
      assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
    }
    if (!(Heap[this, Node.next] == null)) {
      //  assert <undefined position>:  The expression at 19.42 might not evaluate to true.
      assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
    }
    SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := SecMask[this, Node.prev][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.prev][perm$N] < 0) {
      SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := SecMask[this, Node.next][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.next][perm$N] < 0) {
      SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, mu] := SecMask[this, mu][perm$N := SecMask[this, mu][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, mu][perm$N] < 0) {
      SecMask[this, mu] := SecMask[this, mu][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[this, Node.prev] == null)) {
      SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] < 0) {
        SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, Node.next] == null)) {
      SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := SecMask[Heap[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.next], Node.invRight][perm$R] < 0) {
        SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  assume predRec#_320 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[predRec#_320, Node.prev] == null) || (dtype(Heap[predRec#_320, Node.prev]) == Node#t);
  assume 1 > 0;
  SecMask[predRec#_320, Node.prev] := SecMask[predRec#_320, Node.prev][perm$N := SecMask[predRec#_320, Node.prev][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_320, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_320 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[predRec#_320, Node.next] == null) || (dtype(Heap[predRec#_320, Node.next]) == Node#t);
  assume 1 > 0;
  SecMask[predRec#_320, Node.next] := SecMask[predRec#_320, Node.next][perm$N := SecMask[predRec#_320, Node.next][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_320, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_320 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume 1 > 0;
  SecMask[predRec#_320, mu] := SecMask[predRec#_320, mu][perm$N := SecMask[predRec#_320, mu][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_320, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[predRec#_320, Node.prev] == null)) {
    assume Heap[predRec#_320, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[predRec#_320, Node.prev], Node.invLeft] := SecMask[Heap[predRec#_320, Node.prev], Node.invLeft][perm$R := SecMask[Heap[predRec#_320, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_320, Node.prev], Node.invLeft]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_320, Node.next] == null)) {
    assume Heap[predRec#_320, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[predRec#_320, Node.next], Node.invRight] := SecMask[Heap[predRec#_320, Node.next], Node.invRight][perm$R := SecMask[Heap[predRec#_320, Node.next], Node.invRight][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_320, Node.next], Node.invRight]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  assume ite(!(Heap[this, Node.prev] == null), ite(!(Heap[Heap[this, Node.prev], Node.prev] == null), (forall o#_330: ref :: (((0 < Heap[o#_330, held]) || Heap[o#_330, rdheld]) || (Credits[o#_330] < 0)) ==> MuBelow(Heap[o#_330, mu], Heap[Heap[Heap[this, Node.prev], Node.prev], mu])), (forall o#_331: ref :: (((0 < Heap[o#_331, held]) || Heap[o#_331, rdheld]) || (Credits[o#_331] < 0)) ==> MuBelow(Heap[o#_331, mu], Heap[Heap[this, Node.prev], mu]))), (forall o#_332: ref :: (((0 < Heap[o#_332, held]) || Heap[o#_332, rdheld]) || (Credits[o#_332] < 0)) ==> MuBelow(Heap[o#_332, mu], Heap[this, mu])));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume SecMask == old(SecMask);
  assume Credits == old(Credits);
  // Line #30:     method delete() returns (newList:Node)  
  assert {:msg "  30.5: SMOKE-TEST-1. (Precondition of method delete is equivalent to false.)"}{:subsumption 0} !(1 == 1);
  // Line #44:         unfold inv  
  // unfold
  assume #Node.inv#trigger(this);
  assume (0 < unfoldK#_333) && (unfoldK#_333 < Fractions(1)) && ((1000 * unfoldK#_333) < methodK#_170);
  assert {:msg "  44.9: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  assert {:msg "  44.9: unfold might fail because the predicate Node.inv does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  44.9: unfold might fail because the predicate Node.inv does not hold. Insufficient fraction at <undefined position> for Node.inv."} (Fractions(100) <= Mask[this, Node.inv][perm$R]) && ((Fractions(100) == Mask[this, Node.inv][perm$R]) ==> (0 <= Mask[this, Node.inv][perm$N]));
  Mask[this, Node.inv] := Mask[this, Node.inv][perm$R := Mask[this, Node.inv][perm$R] - Fractions(100)];
  if (false || ((predVer#_321 == Heap[this, Node.inv]) && (predRec#_320 == this) && true && predFlag#_322)) {
    // begin exhale (update SecMask)
    if (!(Heap[this, Node.prev] == null)) {
      //  assert <undefined position>:  The expression at 18.41 might not evaluate to true.
      assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
    }
    if (!(Heap[this, Node.next] == null)) {
      //  assert <undefined position>:  The expression at 19.42 might not evaluate to true.
      assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
    }
    SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := SecMask[this, Node.prev][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.prev][perm$N] < 0) {
      SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := SecMask[this, Node.next][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.next][perm$N] < 0) {
      SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, mu] := SecMask[this, mu][perm$N := SecMask[this, mu][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, mu][perm$N] < 0) {
      SecMask[this, mu] := SecMask[this, mu][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[this, Node.prev] == null)) {
      SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] < 0) {
        SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, Node.next] == null)) {
      SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := SecMask[Heap[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.next], Node.invRight][perm$R] < 0) {
        SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(Mask, SecMask, this, Node.inv)) {
    oldVers#_344 := Heap[this, Node.inv];
    havoc newVers#_345;
    Heap[this, Node.inv] := newVers#_345;
    assume oldVers#_344 < Heap[this, Node.inv];
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (unfold)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.prev] == null) || (dtype(Heap[this, Node.prev]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.prev] := Mask[this, Node.prev][perm$N := Mask[this, Node.prev][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, Node.next] == null) || (dtype(Heap[this, Node.next]) == Node#t);
  assume 1 > 0;
  Mask[this, Node.next] := Mask[this, Node.next][perm$N := Mask[this, Node.next][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume 1 > 0;
  Mask[this, mu] := Mask[this, mu][perm$N := Mask[this, mu][perm$N] + 1];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this, Node.prev] == null)) {
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, Node.prev], Node.invLeft] := Mask[Heap[this, Node.prev], Node.invLeft][perm$R := Mask[Heap[this, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.invLeft]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    predRec#_346 := Heap[this, Node.prev];
    predFlag#_348 := true;
    assume #Node.invLeft#trigger(Heap[this, Node.prev]);
    predVer#_347 := Heap[Heap[this, Node.prev], Node.invLeft];
    if (false) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(Heap[Heap[Heap[this, Node.prev], Node.prev], mu], Heap[Heap[this, Node.prev], mu]);
      }
      SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := SecMask[Heap[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := SecMask[Heap[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := SecMask[Heap[this, Node.prev], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    assume predRec#_346 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[predRec#_346, Node.prev] == null) || (dtype(Heap[predRec#_346, Node.prev]) == Node#t);
    assume 1 > 0;
    SecMask[predRec#_346, Node.prev] := SecMask[predRec#_346, Node.prev][perm$N := SecMask[predRec#_346, Node.prev][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[predRec#_346, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume predRec#_346 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[predRec#_346, Node.next] == null) || (dtype(Heap[predRec#_346, Node.next]) == Node#t);
    assume 1 > 0;
    SecMask[predRec#_346, Node.next] := SecMask[predRec#_346, Node.next][perm$N := SecMask[predRec#_346, Node.next][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[predRec#_346, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume predRec#_346 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    SecMask[predRec#_346, mu] := SecMask[predRec#_346, mu][perm$N := SecMask[predRec#_346, mu][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[predRec#_346, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[predRec#_346, Node.prev] == null)) {
      assume Heap[predRec#_346, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      SecMask[Heap[predRec#_346, Node.prev], Node.invLeft] := SecMask[Heap[predRec#_346, Node.prev], Node.invLeft][perm$R := SecMask[Heap[predRec#_346, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[predRec#_346, Node.prev], Node.invLeft]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
  }
  if (!(Heap[this, Node.next] == null)) {
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, Node.next], Node.invRight] := Mask[Heap[this, Node.next], Node.invRight][perm$R := Mask[Heap[this, Node.next], Node.invRight][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.invRight]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    predRec#_355 := Heap[this, Node.next];
    predFlag#_357 := true;
    assume #Node.invRight#trigger(Heap[this, Node.next]);
    predVer#_356 := Heap[Heap[this, Node.next], Node.invRight];
    if (false) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(Heap[Heap[this, Node.next], mu], Heap[Heap[Heap[this, Node.next], Node.next], mu]);
      }
      SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := SecMask[Heap[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := SecMask[Heap[this, Node.next], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := SecMask[Heap[this, Node.next], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    assume predRec#_355 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[predRec#_355, Node.prev] == null) || (dtype(Heap[predRec#_355, Node.prev]) == Node#t);
    assume 1 > 0;
    SecMask[predRec#_355, Node.prev] := SecMask[predRec#_355, Node.prev][perm$N := SecMask[predRec#_355, Node.prev][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[predRec#_355, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume predRec#_355 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[predRec#_355, Node.next] == null) || (dtype(Heap[predRec#_355, Node.next]) == Node#t);
    assume 1 > 0;
    SecMask[predRec#_355, Node.next] := SecMask[predRec#_355, Node.next][perm$N := SecMask[predRec#_355, Node.next][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[predRec#_355, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume predRec#_355 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    SecMask[predRec#_355, mu] := SecMask[predRec#_355, mu][perm$N := SecMask[predRec#_355, mu][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[predRec#_355, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[predRec#_355, Node.next] == null)) {
      assume Heap[predRec#_355, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      SecMask[Heap[predRec#_355, Node.next], Node.invRight] := SecMask[Heap[predRec#_355, Node.next], Node.invRight][perm$R := SecMask[Heap[predRec#_355, Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[predRec#_355, Node.next], Node.invRight]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // Line #44:         unfold inv  
  assert {:msg "  44.9: SMOKE-TEST-2. (The statements after the unfold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #45:         if (prev != null) {  
  // if
  cond#_364 := !(Heap[this, Node.prev] == null);
  assert {:msg "  45.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  45.13: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (cond#_364) {
    // Line #0: <undefined position>
    // Line #45:         if (prev != null) {  
    assert {:msg "  45.9: SMOKE-TEST-3. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #46:             unfold prev.invLeft;  
    // unfold
    assume #Node.invLeft#trigger(Heap[this, Node.prev]);
    assume (0 < unfoldK#_365) && (unfoldK#_365 < Fractions(1)) && ((1000 * unfoldK#_365) < methodK#_170);
    assert {:msg "  46.20: Receiver might be null."} true ==> (this != null);
    assert {:msg "  46.20: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  46.13: The target of the fold statement might be null."} Heap[this, Node.prev] != null;
    // begin exhale (unfold)
    assert {:msg "  46.13: unfold might fail because the predicate Node.invLeft does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
    assert {:msg "  46.13: unfold might fail because the predicate Node.invLeft does not hold. Insufficient fraction at <undefined position> for Node.invLeft."} (Fractions(100) <= Mask[Heap[this, Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == Mask[Heap[this, Node.prev], Node.invLeft][perm$R]) ==> (0 <= Mask[Heap[this, Node.prev], Node.invLeft][perm$N]));
    Mask[Heap[this, Node.prev], Node.invLeft] := Mask[Heap[this, Node.prev], Node.invLeft][perm$R := Mask[Heap[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
    if (false || ((predVer#_347 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_346 == Heap[this, Node.prev]) && true && predFlag#_348)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
        assume MuBelow(Heap[Heap[Heap[this, Node.prev], Node.prev], mu], Heap[Heap[this, Node.prev], mu]);
      }
      SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := SecMask[Heap[this, Node.prev], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := SecMask[Heap[this, Node.prev], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := SecMask[Heap[this, Node.prev], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.prev], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(Mask, SecMask, Heap[this, Node.prev], Node.invLeft)) {
      oldVers#_375 := Heap[Heap[this, Node.prev], Node.invLeft];
      havoc newVers#_376;
      Heap[Heap[this, Node.prev], Node.invLeft] := newVers#_376;
      assume oldVers#_375 < Heap[Heap[this, Node.prev], Node.invLeft];
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end exhale
    // inhale (unfold)
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[this, Node.prev], Node.prev]) == Node#t);
    assume 1 > 0;
    Mask[Heap[this, Node.prev], Node.prev] := Mask[Heap[this, Node.prev], Node.prev][perm$N := Mask[Heap[this, Node.prev], Node.prev][perm$N] + 1];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.prev], Node.next] == null) || (dtype(Heap[Heap[this, Node.prev], Node.next]) == Node#t);
    assume 1 > 0;
    Mask[Heap[this, Node.prev], Node.next] := Mask[Heap[this, Node.prev], Node.next][perm$N := Mask[Heap[this, Node.prev], Node.next][perm$N] + 1];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    Mask[Heap[this, Node.prev], mu] := Mask[Heap[this, Node.prev], mu][perm$N := Mask[Heap[this, Node.prev], mu][perm$N] + 1];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.prev], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
      assume Heap[Heap[this, Node.prev], Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      predRec#_377 := Heap[Heap[this, Node.prev], Node.prev];
      predFlag#_379 := true;
      assume #Node.invLeft#trigger(Heap[Heap[this, Node.prev], Node.prev]);
      predVer#_378 := Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft];
      if (false || ((predVer#_347 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[this, Node.prev], Node.prev]) && true && predFlag#_348)) {
        // begin exhale (update SecMask)
        if (!(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[this, Node.prev], Node.prev], mu]);
        }
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume wf(Heap, SecMask, SecMask);
        // end exhale
      }
      assume predRec#_377 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[predRec#_377, Node.prev] == null) || (dtype(Heap[predRec#_377, Node.prev]) == Node#t);
      assume 1 > 0;
      SecMask[predRec#_377, Node.prev] := SecMask[predRec#_377, Node.prev][perm$N := SecMask[predRec#_377, Node.prev][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[predRec#_377, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume predRec#_377 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[predRec#_377, Node.next] == null) || (dtype(Heap[predRec#_377, Node.next]) == Node#t);
      assume 1 > 0;
      SecMask[predRec#_377, Node.next] := SecMask[predRec#_377, Node.next][perm$N := SecMask[predRec#_377, Node.next][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[predRec#_377, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume predRec#_377 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume 1 > 0;
      SecMask[predRec#_377, mu] := SecMask[predRec#_377, mu][perm$N := SecMask[predRec#_377, mu][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[predRec#_377, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[predRec#_377, Node.prev] == null)) {
        assume Heap[predRec#_377, Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        SecMask[Heap[predRec#_377, Node.prev], Node.invLeft] := SecMask[Heap[predRec#_377, Node.prev], Node.invLeft][perm$R := SecMask[Heap[predRec#_377, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[predRec#_377, Node.prev], Node.invLeft]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume MuBelow(Heap[Heap[Heap[this, Node.prev], Node.prev], mu], Heap[Heap[this, Node.prev], mu]);
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end inhale
    // Line #46:             unfold prev.invLeft;  
    assert {:msg "  46.13: SMOKE-TEST-4. (The statements after the unfold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #47:             if(prev.prev != null) { unfold prev.prev.invLeft }  
    // if
    cond#_386 := !(Heap[Heap[this, Node.prev], Node.prev] == null);
    assert {:msg "  47.16: Receiver might be null."} true ==> (this != null);
    assert {:msg "  47.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  47.16: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
    assert {:msg "  47.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.prev], Node.prev);
    if (cond#_386) {
      // Line #0: <undefined position>
      // Line #47:             if(prev.prev != null) { unfold prev.prev.invLeft }  
      assert {:msg "  47.13: SMOKE-TEST-5. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #47:             if(prev.prev != null) { unfold prev.prev.invLeft }  
      // unfold
      assume #Node.invLeft#trigger(Heap[Heap[this, Node.prev], Node.prev]);
      assume (0 < unfoldK#_387) && (unfoldK#_387 < Fractions(1)) && ((1000 * unfoldK#_387) < methodK#_170);
      assert {:msg "  47.44: Receiver might be null."} true ==> (this != null);
      assert {:msg "  47.44: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
      assert {:msg "  47.44: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
      assert {:msg "  47.44: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.prev], Node.prev);
      assert {:msg "  47.37: The target of the fold statement might be null."} Heap[Heap[this, Node.prev], Node.prev] != null;
      // begin exhale (unfold)
      assert {:msg "  47.37: unfold might fail because the predicate Node.invLeft does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
      assert {:msg "  47.37: unfold might fail because the predicate Node.invLeft does not hold. Insufficient fraction at <undefined position> for Node.invLeft."} (Fractions(100) <= Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R]) ==> (0 <= Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$N]));
      Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if ((false || ((predVer#_378 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[this, Node.prev], Node.prev]) && true && predFlag#_348)) {
        if ((predVer#_347 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[this, Node.prev], Node.prev]) && true && predFlag#_348) {
        } else {
        }
        // begin exhale (update SecMask)
        if (!(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[this, Node.prev], Node.prev], mu]);
        }
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
          SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume wf(Heap, SecMask, SecMask);
        // end exhale
      }
      if (!CanRead(Mask, SecMask, Heap[Heap[this, Node.prev], Node.prev], Node.invLeft)) {
        oldVers#_397 := Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft];
        havoc newVers#_398;
        Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := newVers#_398;
        assume oldVers#_397 < Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft];
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      // inhale (unfold)
      assume Heap[Heap[this, Node.prev], Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null) || (dtype(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) == Node#t);
      assume 1 > 0;
      Mask[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] + 1];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[Heap[this, Node.prev], Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[Heap[this, Node.prev], Node.prev], Node.next] == null) || (dtype(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.next]) == Node#t);
      assume 1 > 0;
      Mask[Heap[Heap[this, Node.prev], Node.prev], Node.next] := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := Mask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] + 1];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[Heap[this, Node.prev], Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume 1 > 0;
      Mask[Heap[Heap[this, Node.prev], Node.prev], mu] := Mask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := Mask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] + 1];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.prev], Node.prev], mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
        assume Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := Mask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := Mask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        predRec#_399 := Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
        predFlag#_401 := true;
        assume #Node.invLeft#trigger(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]);
        predVer#_400 := Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft];
        if ((false || ((predVer#_378 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
          if ((predVer#_347 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
          } else {
          }
          // begin exhale (update SecMask)
          if (!(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
            //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
            assume MuBelow(Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu]);
          }
          SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
            SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
            if (SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
              SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          assume wf(Heap, SecMask, SecMask);
          // end exhale
        }
        assume predRec#_399 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[predRec#_399, Node.prev] == null) || (dtype(Heap[predRec#_399, Node.prev]) == Node#t);
        assume 1 > 0;
        SecMask[predRec#_399, Node.prev] := SecMask[predRec#_399, Node.prev][perm$N := SecMask[predRec#_399, Node.prev][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[predRec#_399, Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume predRec#_399 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[predRec#_399, Node.next] == null) || (dtype(Heap[predRec#_399, Node.next]) == Node#t);
        assume 1 > 0;
        SecMask[predRec#_399, Node.next] := SecMask[predRec#_399, Node.next][perm$N := SecMask[predRec#_399, Node.next][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[predRec#_399, Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume predRec#_399 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume 1 > 0;
        SecMask[predRec#_399, mu] := SecMask[predRec#_399, mu][perm$N := SecMask[predRec#_399, mu][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[predRec#_399, mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[predRec#_399, Node.prev] == null)) {
          assume Heap[predRec#_399, Node.prev] != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          SecMask[Heap[predRec#_399, Node.prev], Node.invLeft] := SecMask[Heap[predRec#_399, Node.prev], Node.invLeft][perm$R := SecMask[Heap[predRec#_399, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[predRec#_399, Node.prev], Node.invLeft]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume MuBelow(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[this, Node.prev], Node.prev], mu]);
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      // Line #47:             if(prev.prev != null) { unfold prev.prev.invLeft }  
      assert {:msg "  47.37: SMOKE-TEST-6. (The statements after the unfold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
  }
  // Line #49:         if (next != null) {  
  // if
  cond#_408 := !(Heap[this, Node.next] == null);
  assert {:msg "  49.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  49.13: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (cond#_408) {
    // Line #0: <undefined position>
    // Line #49:         if (next != null) {  
    assert {:msg "  49.9: SMOKE-TEST-7. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #50:             unfold next.invRight;  
    // unfold
    assume #Node.invRight#trigger(Heap[this, Node.next]);
    assume (0 < unfoldK#_409) && (unfoldK#_409 < Fractions(1)) && ((1000 * unfoldK#_409) < methodK#_170);
    assert {:msg "  50.20: Receiver might be null."} true ==> (this != null);
    assert {:msg "  50.20: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  50.13: The target of the fold statement might be null."} Heap[this, Node.next] != null;
    // begin exhale (unfold)
    assert {:msg "  50.13: unfold might fail because the predicate Node.invRight does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
    assert {:msg "  50.13: unfold might fail because the predicate Node.invRight does not hold. Insufficient fraction at <undefined position> for Node.invRight."} (Fractions(100) <= Mask[Heap[this, Node.next], Node.invRight][perm$R]) && ((Fractions(100) == Mask[Heap[this, Node.next], Node.invRight][perm$R]) ==> (0 <= Mask[Heap[this, Node.next], Node.invRight][perm$N]));
    Mask[Heap[this, Node.next], Node.invRight] := Mask[Heap[this, Node.next], Node.invRight][perm$R := Mask[Heap[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
    if (false || ((predVer#_356 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_355 == Heap[this, Node.next]) && true && predFlag#_357)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
        assume MuBelow(Heap[Heap[this, Node.next], mu], Heap[Heap[Heap[this, Node.next], Node.next], mu]);
      }
      SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := SecMask[Heap[this, Node.next], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.prev][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := SecMask[Heap[this, Node.next], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], Node.next][perm$N] < 0) {
        SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := SecMask[Heap[this, Node.next], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[Heap[this, Node.next], mu][perm$N] < 0) {
        SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(Mask, SecMask, Heap[this, Node.next], Node.invRight)) {
      oldVers#_419 := Heap[Heap[this, Node.next], Node.invRight];
      havoc newVers#_420;
      Heap[Heap[this, Node.next], Node.invRight] := newVers#_420;
      assume oldVers#_419 < Heap[Heap[this, Node.next], Node.invRight];
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end exhale
    // inhale (unfold)
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.prev] == null) || (dtype(Heap[Heap[this, Node.next], Node.prev]) == Node#t);
    assume 1 > 0;
    Mask[Heap[this, Node.next], Node.prev] := Mask[Heap[this, Node.next], Node.prev][perm$N := Mask[Heap[this, Node.next], Node.prev][perm$N] + 1];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[this, Node.next], Node.next] == null) || (dtype(Heap[Heap[this, Node.next], Node.next]) == Node#t);
    assume 1 > 0;
    Mask[Heap[this, Node.next], Node.next] := Mask[Heap[this, Node.next], Node.next][perm$N := Mask[Heap[this, Node.next], Node.next][perm$N] + 1];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume 1 > 0;
    Mask[Heap[this, Node.next], mu] := Mask[Heap[this, Node.next], mu][perm$N := Mask[Heap[this, Node.next], mu][perm$N] + 1];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, Node.next], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
      assume Heap[Heap[this, Node.next], Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      predRec#_421 := Heap[Heap[this, Node.next], Node.next];
      predFlag#_423 := true;
      assume #Node.invRight#trigger(Heap[Heap[this, Node.next], Node.next]);
      predVer#_422 := Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight];
      if (false || ((predVer#_356 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[this, Node.next], Node.next]) && true && predFlag#_357)) {
        // begin exhale (update SecMask)
        if (!(Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
          assume MuBelow(Heap[Heap[Heap[this, Node.next], Node.next], mu], Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu]);
        }
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.next], Node.next], mu] := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], mu] := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
          if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume wf(Heap, SecMask, SecMask);
        // end exhale
      }
      assume predRec#_421 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[predRec#_421, Node.prev] == null) || (dtype(Heap[predRec#_421, Node.prev]) == Node#t);
      assume 1 > 0;
      SecMask[predRec#_421, Node.prev] := SecMask[predRec#_421, Node.prev][perm$N := SecMask[predRec#_421, Node.prev][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[predRec#_421, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume predRec#_421 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[predRec#_421, Node.next] == null) || (dtype(Heap[predRec#_421, Node.next]) == Node#t);
      assume 1 > 0;
      SecMask[predRec#_421, Node.next] := SecMask[predRec#_421, Node.next][perm$N := SecMask[predRec#_421, Node.next][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[predRec#_421, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume predRec#_421 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume 1 > 0;
      SecMask[predRec#_421, mu] := SecMask[predRec#_421, mu][perm$N := SecMask[predRec#_421, mu][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[predRec#_421, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[predRec#_421, Node.next] == null)) {
        assume Heap[predRec#_421, Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        SecMask[Heap[predRec#_421, Node.next], Node.invRight] := SecMask[Heap[predRec#_421, Node.next], Node.invRight][perm$R := SecMask[Heap[predRec#_421, Node.next], Node.invRight][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[predRec#_421, Node.next], Node.invRight]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume MuBelow(Heap[Heap[this, Node.next], mu], Heap[Heap[Heap[this, Node.next], Node.next], mu]);
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end inhale
    // Line #50:             unfold next.invRight;  
    assert {:msg "  50.13: SMOKE-TEST-8. (The statements after the unfold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #51:             if(next.next != null) { unfold next.next.invRight }  
    // if
    cond#_430 := !(Heap[Heap[this, Node.next], Node.next] == null);
    assert {:msg "  51.16: Receiver might be null."} true ==> (this != null);
    assert {:msg "  51.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  51.16: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
    assert {:msg "  51.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.next], Node.next);
    if (cond#_430) {
      // Line #0: <undefined position>
      // Line #51:             if(next.next != null) { unfold next.next.invRight }  
      assert {:msg "  51.13: SMOKE-TEST-9. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #51:             if(next.next != null) { unfold next.next.invRight }  
      // unfold
      assume #Node.invRight#trigger(Heap[Heap[this, Node.next], Node.next]);
      assume (0 < unfoldK#_431) && (unfoldK#_431 < Fractions(1)) && ((1000 * unfoldK#_431) < methodK#_170);
      assert {:msg "  51.44: Receiver might be null."} true ==> (this != null);
      assert {:msg "  51.44: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
      assert {:msg "  51.44: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
      assert {:msg "  51.44: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.next], Node.next);
      assert {:msg "  51.37: The target of the fold statement might be null."} Heap[Heap[this, Node.next], Node.next] != null;
      // begin exhale (unfold)
      assert {:msg "  51.37: unfold might fail because the predicate Node.invRight does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
      assert {:msg "  51.37: unfold might fail because the predicate Node.invRight does not hold. Insufficient fraction at <undefined position> for Node.invRight."} (Fractions(100) <= Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R]) && ((Fractions(100) == Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R]) ==> (0 <= Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$N]));
      Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := Mask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
      if ((false || ((predVer#_422 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[this, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[this, Node.next], Node.next]) && true && predFlag#_357)) {
        if ((predVer#_356 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[this, Node.next], Node.next]) && true && predFlag#_357) {
        } else {
        }
        // begin exhale (update SecMask)
        if (!(Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
          assume MuBelow(Heap[Heap[Heap[this, Node.next], Node.next], mu], Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu]);
        }
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[Heap[this, Node.next], Node.next], mu] := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N] < 0) {
          SecMask[Heap[Heap[this, Node.next], Node.next], mu] := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
          SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
          if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume wf(Heap, SecMask, SecMask);
        // end exhale
      }
      if (!CanRead(Mask, SecMask, Heap[Heap[this, Node.next], Node.next], Node.invRight)) {
        oldVers#_441 := Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight];
        havoc newVers#_442;
        Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight] := newVers#_442;
        assume oldVers#_441 < Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight];
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      // inhale (unfold)
      assume Heap[Heap[this, Node.next], Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[Heap[this, Node.next], Node.next], Node.prev] == null) || (dtype(Heap[Heap[Heap[this, Node.next], Node.next], Node.prev]) == Node#t);
      assume 1 > 0;
      Mask[Heap[Heap[this, Node.next], Node.next], Node.prev] := Mask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := Mask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] + 1];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.next], Node.next], Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[Heap[this, Node.next], Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null) || (dtype(Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) == Node#t);
      assume 1 > 0;
      Mask[Heap[Heap[this, Node.next], Node.next], Node.next] := Mask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := Mask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] + 1];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.next], Node.next], Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[Heap[this, Node.next], Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume 1 > 0;
      Mask[Heap[Heap[this, Node.next], Node.next], mu] := Mask[Heap[Heap[this, Node.next], Node.next], mu][perm$N := Mask[Heap[Heap[this, Node.next], Node.next], mu][perm$N] + 1];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[Heap[this, Node.next], Node.next], mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
        assume Heap[Heap[Heap[this, Node.next], Node.next], Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := Mask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := Mask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        predRec#_443 := Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
        predFlag#_445 := true;
        assume #Node.invRight#trigger(Heap[Heap[Heap[this, Node.next], Node.next], Node.next]);
        predVer#_444 := Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight];
        if ((false || ((predVer#_422 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
          if ((predVer#_356 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && predFlag#_357) {
          } else {
          }
          // begin exhale (update SecMask)
          if (!(Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] == null)) {
            //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
            assume MuBelow(Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu]);
          }
          SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N] < 0) {
            SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] == null)) {
            SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
            if (SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
              SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          assume wf(Heap, SecMask, SecMask);
          // end exhale
        }
        assume predRec#_443 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[predRec#_443, Node.prev] == null) || (dtype(Heap[predRec#_443, Node.prev]) == Node#t);
        assume 1 > 0;
        SecMask[predRec#_443, Node.prev] := SecMask[predRec#_443, Node.prev][perm$N := SecMask[predRec#_443, Node.prev][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[predRec#_443, Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume predRec#_443 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[predRec#_443, Node.next] == null) || (dtype(Heap[predRec#_443, Node.next]) == Node#t);
        assume 1 > 0;
        SecMask[predRec#_443, Node.next] := SecMask[predRec#_443, Node.next][perm$N := SecMask[predRec#_443, Node.next][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[predRec#_443, Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume predRec#_443 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume 1 > 0;
        SecMask[predRec#_443, mu] := SecMask[predRec#_443, mu][perm$N := SecMask[predRec#_443, mu][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[predRec#_443, mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[predRec#_443, Node.next] == null)) {
          assume Heap[predRec#_443, Node.next] != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          SecMask[Heap[predRec#_443, Node.next], Node.invRight] := SecMask[Heap[predRec#_443, Node.next], Node.invRight][perm$R := SecMask[Heap[predRec#_443, Node.next], Node.invRight][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[predRec#_443, Node.next], Node.invRight]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume MuBelow(Heap[Heap[Heap[this, Node.next], Node.next], mu], Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu]);
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      // Line #51:             if(next.next != null) { unfold next.next.invRight }  
      assert {:msg "  51.37: SMOKE-TEST-10. (The statements after the unfold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
  }
  // Line #53:         if (prev != null) {  
  // if
  cond#_452 := !(Heap[this, Node.prev] == null);
  assert {:msg "  53.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  53.13: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (cond#_452) {
    // Line #0: <undefined position>
    // Line #53:         if (prev != null) {  
    assert {:msg "  53.9: SMOKE-TEST-11. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #54:             if (prev.prev != null) { acquire prev.prev; }  
    // if
    cond#_453 := !(Heap[Heap[this, Node.prev], Node.prev] == null);
    assert {:msg "  54.17: Receiver might be null."} true ==> (this != null);
    assert {:msg "  54.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  54.17: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
    assert {:msg "  54.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.prev], Node.prev);
    if (cond#_453) {
      // Line #0: <undefined position>
      // Line #54:             if (prev.prev != null) { acquire prev.prev; }  
      assert {:msg "  54.13: SMOKE-TEST-12. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #54:             if (prev.prev != null) { acquire prev.prev; }  
      // acquire
      assert {:msg "  54.46: Receiver might be null."} true ==> (this != null);
      assert {:msg "  54.46: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
      assert {:msg "  54.46: Receiver might be null."} true ==> (Heap[this, Node.prev] != null);
      assert {:msg "  54.46: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.prev], Node.prev);
      assert {:msg "  54.38: The target of the acquire statement might be null."} Heap[Heap[this, Node.prev], Node.prev] != null;
      assert {:msg "  54.38: The mu field of the target of the acquire statement might not be readable."} CanRead(Mask, SecMask, Heap[Heap[this, Node.prev], Node.prev], mu);
      assert {:msg "  54.38: The mu field of the target of the acquire statement might not be above waitlevel."} (forall o#_457: ref :: (((0 < Heap[o#_457, held]) || Heap[o#_457, rdheld]) || (Credits[o#_457] < 0)) ==> MuBelow(Heap[o#_457, mu], Heap[Heap[Heap[this, Node.prev], Node.prev], mu]));
      assume Heap[Heap[Heap[this, Node.prev], Node.prev], mu] != $LockBottom;
      lastSeenMu#_456 := Heap[Heap[Heap[this, Node.prev], Node.prev], mu];
      havoc lastSeenHeld#_455;
      lastSeenHeld#_455 := Heap[Heap[Heap[this, Node.prev], Node.prev], held];
      assume (!(0 < Heap[Heap[Heap[this, Node.prev], Node.prev], held])) && (!Heap[Heap[Heap[this, Node.prev], Node.prev], rdheld]);
      havoc lastAcquire#_454;
      assume 0 < lastAcquire#_454;
      Heap[Heap[Heap[this, Node.prev], Node.prev], held] := lastAcquire#_454;
      sh#5 := Heap[Heap[this, Node.prev], Node.prev];
      // inhale (monitor invariant)
      assume sh#5 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#5, Node.prev] == null) || (dtype(Heap[sh#5, Node.prev]) == Node#t);
      assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      Mask[sh#5, Node.prev] := Mask[sh#5, Node.prev][perm$R := Mask[sh#5, Node.prev][perm$R] + (Fractions(50) - 0)];
      Mask[sh#5, Node.prev] := Mask[sh#5, Node.prev][perm$N := Mask[sh#5, Node.prev][perm$N] + (0 - 1)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#5, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#5 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#5, Node.next] == null) || (dtype(Heap[sh#5, Node.next]) == Node#t);
      assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      Mask[sh#5, Node.next] := Mask[sh#5, Node.next][perm$R := Mask[sh#5, Node.next][perm$R] + (Fractions(50) - 0)];
      Mask[sh#5, Node.next] := Mask[sh#5, Node.next][perm$N := Mask[sh#5, Node.next][perm$N] + (0 - 1)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#5, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#5 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      Mask[sh#5, mu] := Mask[sh#5, mu][perm$R := Mask[sh#5, mu][perm$R] + (Fractions(50) - 0)];
      Mask[sh#5, mu] := Mask[sh#5, mu][perm$N := Mask[sh#5, mu][perm$N] + (0 - 1)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#5, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (Heap[sh#5, Node.next] == null) {
        assume sh#5 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#5, Node.prev] == null) || (dtype(Heap[sh#5, Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#5, Node.prev] := Mask[sh#5, Node.prev][perm$R := Mask[sh#5, Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#5, Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#5 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#5, Node.next] == null) || (dtype(Heap[sh#5, Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#5, Node.next] := Mask[sh#5, Node.next][perm$R := Mask[sh#5, Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#5, Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#5 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[sh#5, mu] := Mask[sh#5, mu][perm$R := Mask[sh#5, mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#5, mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#5, Node.next] == null)) {
        assume Heap[sh#5, Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#5, Node.next], Node.next] == null) || (dtype(Heap[Heap[sh#5, Node.next], Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#5, Node.next], Node.next] := Mask[Heap[sh#5, Node.next], Node.next][perm$R := Mask[Heap[sh#5, Node.next], Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#5, Node.next], Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#5, Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#5, Node.next], Node.prev] == null) || (dtype(Heap[Heap[sh#5, Node.next], Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#5, Node.next], Node.prev] := Mask[Heap[sh#5, Node.next], Node.prev][perm$R := Mask[Heap[sh#5, Node.next], Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#5, Node.next], Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#5, Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[Heap[sh#5, Node.next], mu] := Mask[Heap[sh#5, Node.next], mu][perm$R := Mask[Heap[sh#5, Node.next], mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#5, Node.next], mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (Heap[sh#5, Node.prev] == null) {
        assume sh#5 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#5, Node.prev] == null) || (dtype(Heap[sh#5, Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#5, Node.prev] := Mask[sh#5, Node.prev][perm$R := Mask[sh#5, Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#5, Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#5 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#5, Node.next] == null) || (dtype(Heap[sh#5, Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#5, Node.next] := Mask[sh#5, Node.next][perm$R := Mask[sh#5, Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#5, Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#5 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[sh#5, mu] := Mask[sh#5, mu][perm$R := Mask[sh#5, mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#5, mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#5, Node.prev] == null)) {
        assume Heap[sh#5, Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#5, Node.prev], Node.next] == null) || (dtype(Heap[Heap[sh#5, Node.prev], Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#5, Node.prev], Node.next] := Mask[Heap[sh#5, Node.prev], Node.next][perm$R := Mask[Heap[sh#5, Node.prev], Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#5, Node.prev], Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#5, Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#5, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[sh#5, Node.prev], Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#5, Node.prev], Node.prev] := Mask[Heap[sh#5, Node.prev], Node.prev][perm$R := Mask[Heap[sh#5, Node.prev], Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#5, Node.prev], Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#5, Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[Heap[sh#5, Node.prev], mu] := Mask[Heap[sh#5, Node.prev], mu][perm$R := Mask[Heap[sh#5, Node.prev], mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#5, Node.prev], mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#5, Node.next] == null)) {
        assume !(Heap[Heap[sh#5, Node.next], Node.prev] == null);
        assume Heap[Heap[sh#5, Node.next], Node.prev] == sh#5;
      }
      if (!(Heap[sh#5, Node.prev] == null)) {
        assume !(Heap[Heap[sh#5, Node.prev], Node.next] == null);
        assume Heap[Heap[sh#5, Node.prev], Node.next] == sh#5;
      }
      if (!(Heap[sh#5, Node.next] == null)) {
        assume MuBelow(Heap[sh#5, mu], Heap[Heap[sh#5, Node.next], mu]);
      }
      if (!(Heap[sh#5, Node.prev] == null)) {
        assume MuBelow(Heap[Heap[sh#5, Node.prev], mu], Heap[sh#5, mu]);
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      assume Acquire$Heap(lastAcquire#_454) == Heap;
      assume Acquire$Mask(lastAcquire#_454) == Mask;
      assume Acquire$SecMask(lastAcquire#_454) == SecMask;
      assume Acquire$Credits(lastAcquire#_454) == Credits;
      // Line #54:             if (prev.prev != null) { acquire prev.prev; }  
      assert {:msg "  54.38: SMOKE-TEST-13. (The statements after the acquire statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
    // Line #55:             acquire prev;  
    // acquire
    assert {:msg "  55.21: Receiver might be null."} true ==> (this != null);
    assert {:msg "  55.21: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  55.13: The target of the acquire statement might be null."} Heap[this, Node.prev] != null;
    assert {:msg "  55.13: The mu field of the target of the acquire statement might not be readable."} CanRead(Mask, SecMask, Heap[this, Node.prev], mu);
    assert {:msg "  55.13: The mu field of the target of the acquire statement might not be above waitlevel."} (forall o#_461: ref :: (((0 < Heap[o#_461, held]) || Heap[o#_461, rdheld]) || (Credits[o#_461] < 0)) ==> MuBelow(Heap[o#_461, mu], Heap[Heap[this, Node.prev], mu]));
    assume Heap[Heap[this, Node.prev], mu] != $LockBottom;
    lastSeenMu#_460 := Heap[Heap[this, Node.prev], mu];
    havoc lastSeenHeld#_459;
    lastSeenHeld#_459 := Heap[Heap[this, Node.prev], held];
    assume (!(0 < Heap[Heap[this, Node.prev], held])) && (!Heap[Heap[this, Node.prev], rdheld]);
    havoc lastAcquire#_458;
    assume 0 < lastAcquire#_458;
    Heap[Heap[this, Node.prev], held] := lastAcquire#_458;
    sh#6 := Heap[this, Node.prev];
    // inhale (monitor invariant)
    assume sh#6 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#6, Node.prev] == null) || (dtype(Heap[sh#6, Node.prev]) == Node#t);
    assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    Mask[sh#6, Node.prev] := Mask[sh#6, Node.prev][perm$R := Mask[sh#6, Node.prev][perm$R] + (Fractions(50) - 0)];
    Mask[sh#6, Node.prev] := Mask[sh#6, Node.prev][perm$N := Mask[sh#6, Node.prev][perm$N] + (0 - 1)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#6, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#6 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#6, Node.next] == null) || (dtype(Heap[sh#6, Node.next]) == Node#t);
    assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    Mask[sh#6, Node.next] := Mask[sh#6, Node.next][perm$R := Mask[sh#6, Node.next][perm$R] + (Fractions(50) - 0)];
    Mask[sh#6, Node.next] := Mask[sh#6, Node.next][perm$N := Mask[sh#6, Node.next][perm$N] + (0 - 1)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#6, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#6 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    Mask[sh#6, mu] := Mask[sh#6, mu][perm$R := Mask[sh#6, mu][perm$R] + (Fractions(50) - 0)];
    Mask[sh#6, mu] := Mask[sh#6, mu][perm$N := Mask[sh#6, mu][perm$N] + (0 - 1)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#6, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (Heap[sh#6, Node.next] == null) {
      assume sh#6 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#6, Node.prev] == null) || (dtype(Heap[sh#6, Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#6, Node.prev] := Mask[sh#6, Node.prev][perm$R := Mask[sh#6, Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#6, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#6 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#6, Node.next] == null) || (dtype(Heap[sh#6, Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#6, Node.next] := Mask[sh#6, Node.next][perm$R := Mask[sh#6, Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#6, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#6 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[sh#6, mu] := Mask[sh#6, mu][perm$R := Mask[sh#6, mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#6, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#6, Node.next] == null)) {
      assume Heap[sh#6, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#6, Node.next], Node.next] == null) || (dtype(Heap[Heap[sh#6, Node.next], Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#6, Node.next], Node.next] := Mask[Heap[sh#6, Node.next], Node.next][perm$R := Mask[Heap[sh#6, Node.next], Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#6, Node.next], Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#6, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#6, Node.next], Node.prev] == null) || (dtype(Heap[Heap[sh#6, Node.next], Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#6, Node.next], Node.prev] := Mask[Heap[sh#6, Node.next], Node.prev][perm$R := Mask[Heap[sh#6, Node.next], Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#6, Node.next], Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#6, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[Heap[sh#6, Node.next], mu] := Mask[Heap[sh#6, Node.next], mu][perm$R := Mask[Heap[sh#6, Node.next], mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#6, Node.next], mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (Heap[sh#6, Node.prev] == null) {
      assume sh#6 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#6, Node.prev] == null) || (dtype(Heap[sh#6, Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#6, Node.prev] := Mask[sh#6, Node.prev][perm$R := Mask[sh#6, Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#6, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#6 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#6, Node.next] == null) || (dtype(Heap[sh#6, Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#6, Node.next] := Mask[sh#6, Node.next][perm$R := Mask[sh#6, Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#6, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#6 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[sh#6, mu] := Mask[sh#6, mu][perm$R := Mask[sh#6, mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#6, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#6, Node.prev] == null)) {
      assume Heap[sh#6, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#6, Node.prev], Node.next] == null) || (dtype(Heap[Heap[sh#6, Node.prev], Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#6, Node.prev], Node.next] := Mask[Heap[sh#6, Node.prev], Node.next][perm$R := Mask[Heap[sh#6, Node.prev], Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#6, Node.prev], Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#6, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#6, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[sh#6, Node.prev], Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#6, Node.prev], Node.prev] := Mask[Heap[sh#6, Node.prev], Node.prev][perm$R := Mask[Heap[sh#6, Node.prev], Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#6, Node.prev], Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#6, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[Heap[sh#6, Node.prev], mu] := Mask[Heap[sh#6, Node.prev], mu][perm$R := Mask[Heap[sh#6, Node.prev], mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#6, Node.prev], mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#6, Node.next] == null)) {
      assume !(Heap[Heap[sh#6, Node.next], Node.prev] == null);
      assume Heap[Heap[sh#6, Node.next], Node.prev] == sh#6;
    }
    if (!(Heap[sh#6, Node.prev] == null)) {
      assume !(Heap[Heap[sh#6, Node.prev], Node.next] == null);
      assume Heap[Heap[sh#6, Node.prev], Node.next] == sh#6;
    }
    if (!(Heap[sh#6, Node.next] == null)) {
      assume MuBelow(Heap[sh#6, mu], Heap[Heap[sh#6, Node.next], mu]);
    }
    if (!(Heap[sh#6, Node.prev] == null)) {
      assume MuBelow(Heap[Heap[sh#6, Node.prev], mu], Heap[sh#6, mu]);
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end inhale
    assume Acquire$Heap(lastAcquire#_458) == Heap;
    assume Acquire$Mask(lastAcquire#_458) == Mask;
    assume Acquire$SecMask(lastAcquire#_458) == SecMask;
    assume Acquire$Credits(lastAcquire#_458) == Credits;
    // Line #55:             acquire prev;  
    assert {:msg "  55.13: SMOKE-TEST-14. (The statements after the acquire statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  }
  // Line #57:         acquire this;  
  // acquire
  assert {:msg "  57.9: The target of the acquire statement might be null."} this != null;
  assert {:msg "  57.9: The mu field of the target of the acquire statement might not be readable."} CanRead(Mask, SecMask, this, mu);
  assert {:msg "  57.9: The mu field of the target of the acquire statement might not be above waitlevel."} (forall o#_465: ref :: (((0 < Heap[o#_465, held]) || Heap[o#_465, rdheld]) || (Credits[o#_465] < 0)) ==> MuBelow(Heap[o#_465, mu], Heap[this, mu]));
  assume Heap[this, mu] != $LockBottom;
  lastSeenMu#_464 := Heap[this, mu];
  havoc lastSeenHeld#_463;
  lastSeenHeld#_463 := Heap[this, held];
  assume (!(0 < Heap[this, held])) && (!Heap[this, rdheld]);
  havoc lastAcquire#_462;
  assume 0 < lastAcquire#_462;
  Heap[this, held] := lastAcquire#_462;
  sh#7 := this;
  // inhale (monitor invariant)
  assume sh#7 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[sh#7, Node.prev] == null) || (dtype(Heap[sh#7, Node.prev]) == Node#t);
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  Mask[sh#7, Node.prev] := Mask[sh#7, Node.prev][perm$R := Mask[sh#7, Node.prev][perm$R] + (Fractions(50) - 0)];
  Mask[sh#7, Node.prev] := Mask[sh#7, Node.prev][perm$N := Mask[sh#7, Node.prev][perm$N] + (0 - 1)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[sh#7, Node.prev]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume sh#7 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[sh#7, Node.next] == null) || (dtype(Heap[sh#7, Node.next]) == Node#t);
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  Mask[sh#7, Node.next] := Mask[sh#7, Node.next][perm$R := Mask[sh#7, Node.next][perm$R] + (Fractions(50) - 0)];
  Mask[sh#7, Node.next] := Mask[sh#7, Node.next][perm$N := Mask[sh#7, Node.next][perm$N] + (0 - 1)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[sh#7, Node.next]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume sh#7 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  Mask[sh#7, mu] := Mask[sh#7, mu][perm$R := Mask[sh#7, mu][perm$R] + (Fractions(50) - 0)];
  Mask[sh#7, mu] := Mask[sh#7, mu][perm$N := Mask[sh#7, mu][perm$N] + (0 - 1)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[sh#7, mu]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (Heap[sh#7, Node.next] == null) {
    assume sh#7 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#7, Node.prev] == null) || (dtype(Heap[sh#7, Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[sh#7, Node.prev] := Mask[sh#7, Node.prev][perm$R := Mask[sh#7, Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#7, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#7 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#7, Node.next] == null) || (dtype(Heap[sh#7, Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[sh#7, Node.next] := Mask[sh#7, Node.next][perm$R := Mask[sh#7, Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#7, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#7 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[sh#7, mu] := Mask[sh#7, mu][perm$R := Mask[sh#7, mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#7, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[sh#7, Node.next] == null)) {
    assume Heap[sh#7, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[sh#7, Node.next], Node.next] == null) || (dtype(Heap[Heap[sh#7, Node.next], Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[sh#7, Node.next], Node.next] := Mask[Heap[sh#7, Node.next], Node.next][perm$R := Mask[Heap[sh#7, Node.next], Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[sh#7, Node.next], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[sh#7, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[sh#7, Node.next], Node.prev] == null) || (dtype(Heap[Heap[sh#7, Node.next], Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[sh#7, Node.next], Node.prev] := Mask[Heap[sh#7, Node.next], Node.prev][perm$R := Mask[Heap[sh#7, Node.next], Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[sh#7, Node.next], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[sh#7, Node.next] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[Heap[sh#7, Node.next], mu] := Mask[Heap[sh#7, Node.next], mu][perm$R := Mask[Heap[sh#7, Node.next], mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[sh#7, Node.next], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (Heap[sh#7, Node.prev] == null) {
    assume sh#7 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#7, Node.prev] == null) || (dtype(Heap[sh#7, Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[sh#7, Node.prev] := Mask[sh#7, Node.prev][perm$R := Mask[sh#7, Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#7, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#7 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#7, Node.next] == null) || (dtype(Heap[sh#7, Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[sh#7, Node.next] := Mask[sh#7, Node.next][perm$R := Mask[sh#7, Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#7, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#7 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[sh#7, mu] := Mask[sh#7, mu][perm$R := Mask[sh#7, mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#7, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[sh#7, Node.prev] == null)) {
    assume Heap[sh#7, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[sh#7, Node.prev], Node.next] == null) || (dtype(Heap[Heap[sh#7, Node.prev], Node.next]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[sh#7, Node.prev], Node.next] := Mask[Heap[sh#7, Node.prev], Node.next][perm$R := Mask[Heap[sh#7, Node.prev], Node.next][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[sh#7, Node.prev], Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[sh#7, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[Heap[sh#7, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[sh#7, Node.prev], Node.prev]) == Node#t);
    assume Fractions(25) > 0;
    Mask[Heap[sh#7, Node.prev], Node.prev] := Mask[Heap[sh#7, Node.prev], Node.prev][perm$R := Mask[Heap[sh#7, Node.prev], Node.prev][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[sh#7, Node.prev], Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[sh#7, Node.prev] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(25) > 0;
    Mask[Heap[sh#7, Node.prev], mu] := Mask[Heap[sh#7, Node.prev], mu][perm$R := Mask[Heap[sh#7, Node.prev], mu][perm$R] + Fractions(25)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[sh#7, Node.prev], mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[sh#7, Node.next] == null)) {
    assume !(Heap[Heap[sh#7, Node.next], Node.prev] == null);
    assume Heap[Heap[sh#7, Node.next], Node.prev] == sh#7;
  }
  if (!(Heap[sh#7, Node.prev] == null)) {
    assume !(Heap[Heap[sh#7, Node.prev], Node.next] == null);
    assume Heap[Heap[sh#7, Node.prev], Node.next] == sh#7;
  }
  if (!(Heap[sh#7, Node.next] == null)) {
    assume MuBelow(Heap[sh#7, mu], Heap[Heap[sh#7, Node.next], mu]);
  }
  if (!(Heap[sh#7, Node.prev] == null)) {
    assume MuBelow(Heap[Heap[sh#7, Node.prev], mu], Heap[sh#7, mu]);
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  assume Acquire$Heap(lastAcquire#_462) == Heap;
  assume Acquire$Mask(lastAcquire#_462) == Mask;
  assume Acquire$SecMask(lastAcquire#_462) == SecMask;
  assume Acquire$Credits(lastAcquire#_462) == Credits;
  // Line #57:         acquire this;  
  assert {:msg "  57.9: SMOKE-TEST-15. (The statements after the acquire statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #58:         if (next != null) {  
  // if
  cond#_466 := !(Heap[this, Node.next] == null);
  assert {:msg "  58.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  58.13: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (cond#_466) {
    // Line #0: <undefined position>
    // Line #58:         if (next != null) {  
    assert {:msg "  58.9: SMOKE-TEST-16. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #59:             acquire next;  
    // acquire
    assert {:msg "  59.21: Receiver might be null."} true ==> (this != null);
    assert {:msg "  59.21: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  59.13: The target of the acquire statement might be null."} Heap[this, Node.next] != null;
    assert {:msg "  59.13: The mu field of the target of the acquire statement might not be readable."} CanRead(Mask, SecMask, Heap[this, Node.next], mu);
    assert {:msg "  59.13: The mu field of the target of the acquire statement might not be above waitlevel."} (forall o#_470: ref :: (((0 < Heap[o#_470, held]) || Heap[o#_470, rdheld]) || (Credits[o#_470] < 0)) ==> MuBelow(Heap[o#_470, mu], Heap[Heap[this, Node.next], mu]));
    assume Heap[Heap[this, Node.next], mu] != $LockBottom;
    lastSeenMu#_469 := Heap[Heap[this, Node.next], mu];
    havoc lastSeenHeld#_468;
    lastSeenHeld#_468 := Heap[Heap[this, Node.next], held];
    assume (!(0 < Heap[Heap[this, Node.next], held])) && (!Heap[Heap[this, Node.next], rdheld]);
    havoc lastAcquire#_467;
    assume 0 < lastAcquire#_467;
    Heap[Heap[this, Node.next], held] := lastAcquire#_467;
    sh#8 := Heap[this, Node.next];
    // inhale (monitor invariant)
    assume sh#8 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#8, Node.prev] == null) || (dtype(Heap[sh#8, Node.prev]) == Node#t);
    assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    Mask[sh#8, Node.prev] := Mask[sh#8, Node.prev][perm$R := Mask[sh#8, Node.prev][perm$R] + (Fractions(50) - 0)];
    Mask[sh#8, Node.prev] := Mask[sh#8, Node.prev][perm$N := Mask[sh#8, Node.prev][perm$N] + (0 - 1)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#8, Node.prev]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#8 != null;
    assume wf(Heap, Mask, SecMask);
    assume (Heap[sh#8, Node.next] == null) || (dtype(Heap[sh#8, Node.next]) == Node#t);
    assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    Mask[sh#8, Node.next] := Mask[sh#8, Node.next][perm$R := Mask[sh#8, Node.next][perm$R] + (Fractions(50) - 0)];
    Mask[sh#8, Node.next] := Mask[sh#8, Node.next][perm$N := Mask[sh#8, Node.next][perm$N] + (0 - 1)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#8, Node.next]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume sh#8 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    Mask[sh#8, mu] := Mask[sh#8, mu][perm$R := Mask[sh#8, mu][perm$R] + (Fractions(50) - 0)];
    Mask[sh#8, mu] := Mask[sh#8, mu][perm$N := Mask[sh#8, mu][perm$N] + (0 - 1)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[sh#8, mu]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (Heap[sh#8, Node.next] == null) {
      assume sh#8 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#8, Node.prev] == null) || (dtype(Heap[sh#8, Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#8, Node.prev] := Mask[sh#8, Node.prev][perm$R := Mask[sh#8, Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#8, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#8 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#8, Node.next] == null) || (dtype(Heap[sh#8, Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#8, Node.next] := Mask[sh#8, Node.next][perm$R := Mask[sh#8, Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#8, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#8 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[sh#8, mu] := Mask[sh#8, mu][perm$R := Mask[sh#8, mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#8, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#8, Node.next] == null)) {
      assume Heap[sh#8, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#8, Node.next], Node.next] == null) || (dtype(Heap[Heap[sh#8, Node.next], Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#8, Node.next], Node.next] := Mask[Heap[sh#8, Node.next], Node.next][perm$R := Mask[Heap[sh#8, Node.next], Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#8, Node.next], Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#8, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#8, Node.next], Node.prev] == null) || (dtype(Heap[Heap[sh#8, Node.next], Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#8, Node.next], Node.prev] := Mask[Heap[sh#8, Node.next], Node.prev][perm$R := Mask[Heap[sh#8, Node.next], Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#8, Node.next], Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#8, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[Heap[sh#8, Node.next], mu] := Mask[Heap[sh#8, Node.next], mu][perm$R := Mask[Heap[sh#8, Node.next], mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#8, Node.next], mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (Heap[sh#8, Node.prev] == null) {
      assume sh#8 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#8, Node.prev] == null) || (dtype(Heap[sh#8, Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#8, Node.prev] := Mask[sh#8, Node.prev][perm$R := Mask[sh#8, Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#8, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#8 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#8, Node.next] == null) || (dtype(Heap[sh#8, Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[sh#8, Node.next] := Mask[sh#8, Node.next][perm$R := Mask[sh#8, Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#8, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#8 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[sh#8, mu] := Mask[sh#8, mu][perm$R := Mask[sh#8, mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#8, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#8, Node.prev] == null)) {
      assume Heap[sh#8, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#8, Node.prev], Node.next] == null) || (dtype(Heap[Heap[sh#8, Node.prev], Node.next]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#8, Node.prev], Node.next] := Mask[Heap[sh#8, Node.prev], Node.next][perm$R := Mask[Heap[sh#8, Node.prev], Node.next][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#8, Node.prev], Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#8, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[Heap[sh#8, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[sh#8, Node.prev], Node.prev]) == Node#t);
      assume Fractions(25) > 0;
      Mask[Heap[sh#8, Node.prev], Node.prev] := Mask[Heap[sh#8, Node.prev], Node.prev][perm$R := Mask[Heap[sh#8, Node.prev], Node.prev][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#8, Node.prev], Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Heap[sh#8, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(25) > 0;
      Mask[Heap[sh#8, Node.prev], mu] := Mask[Heap[sh#8, Node.prev], mu][perm$R := Mask[Heap[sh#8, Node.prev], mu][perm$R] + Fractions(25)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[sh#8, Node.prev], mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#8, Node.next] == null)) {
      assume !(Heap[Heap[sh#8, Node.next], Node.prev] == null);
      assume Heap[Heap[sh#8, Node.next], Node.prev] == sh#8;
    }
    if (!(Heap[sh#8, Node.prev] == null)) {
      assume !(Heap[Heap[sh#8, Node.prev], Node.next] == null);
      assume Heap[Heap[sh#8, Node.prev], Node.next] == sh#8;
    }
    if (!(Heap[sh#8, Node.next] == null)) {
      assume MuBelow(Heap[sh#8, mu], Heap[Heap[sh#8, Node.next], mu]);
    }
    if (!(Heap[sh#8, Node.prev] == null)) {
      assume MuBelow(Heap[Heap[sh#8, Node.prev], mu], Heap[sh#8, mu]);
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end inhale
    assume Acquire$Heap(lastAcquire#_467) == Heap;
    assume Acquire$Mask(lastAcquire#_467) == Mask;
    assume Acquire$SecMask(lastAcquire#_467) == SecMask;
    assume Acquire$Credits(lastAcquire#_467) == Credits;
    // Line #59:             acquire next;  
    assert {:msg "  59.13: SMOKE-TEST-17. (The statements after the acquire statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #60:             if(next.next != null) { acquire next.next; }  
    // if
    cond#_471 := !(Heap[Heap[this, Node.next], Node.next] == null);
    assert {:msg "  60.16: Receiver might be null."} true ==> (this != null);
    assert {:msg "  60.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  60.16: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
    assert {:msg "  60.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.next], Node.next);
    if (cond#_471) {
      // Line #0: <undefined position>
      // Line #60:             if(next.next != null) { acquire next.next; }  
      assert {:msg "  60.13: SMOKE-TEST-18. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #60:             if(next.next != null) { acquire next.next; }  
      // acquire
      assert {:msg "  60.45: Receiver might be null."} true ==> (this != null);
      assert {:msg "  60.45: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
      assert {:msg "  60.45: Receiver might be null."} true ==> (Heap[this, Node.next] != null);
      assert {:msg "  60.45: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, Node.next], Node.next);
      assert {:msg "  60.37: The target of the acquire statement might be null."} Heap[Heap[this, Node.next], Node.next] != null;
      assert {:msg "  60.37: The mu field of the target of the acquire statement might not be readable."} CanRead(Mask, SecMask, Heap[Heap[this, Node.next], Node.next], mu);
      assert {:msg "  60.37: The mu field of the target of the acquire statement might not be above waitlevel."} (forall o#_475: ref :: (((0 < Heap[o#_475, held]) || Heap[o#_475, rdheld]) || (Credits[o#_475] < 0)) ==> MuBelow(Heap[o#_475, mu], Heap[Heap[Heap[this, Node.next], Node.next], mu]));
      assume Heap[Heap[Heap[this, Node.next], Node.next], mu] != $LockBottom;
      lastSeenMu#_474 := Heap[Heap[Heap[this, Node.next], Node.next], mu];
      havoc lastSeenHeld#_473;
      lastSeenHeld#_473 := Heap[Heap[Heap[this, Node.next], Node.next], held];
      assume (!(0 < Heap[Heap[Heap[this, Node.next], Node.next], held])) && (!Heap[Heap[Heap[this, Node.next], Node.next], rdheld]);
      havoc lastAcquire#_472;
      assume 0 < lastAcquire#_472;
      Heap[Heap[Heap[this, Node.next], Node.next], held] := lastAcquire#_472;
      sh#9 := Heap[Heap[this, Node.next], Node.next];
      // inhale (monitor invariant)
      assume sh#9 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#9, Node.prev] == null) || (dtype(Heap[sh#9, Node.prev]) == Node#t);
      assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      Mask[sh#9, Node.prev] := Mask[sh#9, Node.prev][perm$R := Mask[sh#9, Node.prev][perm$R] + (Fractions(50) - 0)];
      Mask[sh#9, Node.prev] := Mask[sh#9, Node.prev][perm$N := Mask[sh#9, Node.prev][perm$N] + (0 - 1)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#9, Node.prev]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#9 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[sh#9, Node.next] == null) || (dtype(Heap[sh#9, Node.next]) == Node#t);
      assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      Mask[sh#9, Node.next] := Mask[sh#9, Node.next][perm$R := Mask[sh#9, Node.next][perm$R] + (Fractions(50) - 0)];
      Mask[sh#9, Node.next] := Mask[sh#9, Node.next][perm$N := Mask[sh#9, Node.next][perm$N] + (0 - 1)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#9, Node.next]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume sh#9 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      Mask[sh#9, mu] := Mask[sh#9, mu][perm$R := Mask[sh#9, mu][perm$R] + (Fractions(50) - 0)];
      Mask[sh#9, mu] := Mask[sh#9, mu][perm$N := Mask[sh#9, mu][perm$N] + (0 - 1)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[sh#9, mu]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (Heap[sh#9, Node.next] == null) {
        assume sh#9 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#9, Node.prev] == null) || (dtype(Heap[sh#9, Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#9, Node.prev] := Mask[sh#9, Node.prev][perm$R := Mask[sh#9, Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#9, Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#9 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#9, Node.next] == null) || (dtype(Heap[sh#9, Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#9, Node.next] := Mask[sh#9, Node.next][perm$R := Mask[sh#9, Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#9, Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#9 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[sh#9, mu] := Mask[sh#9, mu][perm$R := Mask[sh#9, mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#9, mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#9, Node.next] == null)) {
        assume Heap[sh#9, Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#9, Node.next], Node.next] == null) || (dtype(Heap[Heap[sh#9, Node.next], Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#9, Node.next], Node.next] := Mask[Heap[sh#9, Node.next], Node.next][perm$R := Mask[Heap[sh#9, Node.next], Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#9, Node.next], Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#9, Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#9, Node.next], Node.prev] == null) || (dtype(Heap[Heap[sh#9, Node.next], Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#9, Node.next], Node.prev] := Mask[Heap[sh#9, Node.next], Node.prev][perm$R := Mask[Heap[sh#9, Node.next], Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#9, Node.next], Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#9, Node.next] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[Heap[sh#9, Node.next], mu] := Mask[Heap[sh#9, Node.next], mu][perm$R := Mask[Heap[sh#9, Node.next], mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#9, Node.next], mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (Heap[sh#9, Node.prev] == null) {
        assume sh#9 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#9, Node.prev] == null) || (dtype(Heap[sh#9, Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#9, Node.prev] := Mask[sh#9, Node.prev][perm$R := Mask[sh#9, Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#9, Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#9 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[sh#9, Node.next] == null) || (dtype(Heap[sh#9, Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[sh#9, Node.next] := Mask[sh#9, Node.next][perm$R := Mask[sh#9, Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#9, Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume sh#9 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[sh#9, mu] := Mask[sh#9, mu][perm$R := Mask[sh#9, mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[sh#9, mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#9, Node.prev] == null)) {
        assume Heap[sh#9, Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#9, Node.prev], Node.next] == null) || (dtype(Heap[Heap[sh#9, Node.prev], Node.next]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#9, Node.prev], Node.next] := Mask[Heap[sh#9, Node.prev], Node.next][perm$R := Mask[Heap[sh#9, Node.prev], Node.next][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#9, Node.prev], Node.next]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#9, Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[Heap[sh#9, Node.prev], Node.prev] == null) || (dtype(Heap[Heap[sh#9, Node.prev], Node.prev]) == Node#t);
        assume Fractions(25) > 0;
        Mask[Heap[sh#9, Node.prev], Node.prev] := Mask[Heap[sh#9, Node.prev], Node.prev][perm$R := Mask[Heap[sh#9, Node.prev], Node.prev][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#9, Node.prev], Node.prev]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[sh#9, Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(25) > 0;
        Mask[Heap[sh#9, Node.prev], mu] := Mask[Heap[sh#9, Node.prev], mu][perm$R := Mask[Heap[sh#9, Node.prev], mu][perm$R] + Fractions(25)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[sh#9, Node.prev], mu]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#9, Node.next] == null)) {
        assume !(Heap[Heap[sh#9, Node.next], Node.prev] == null);
        assume Heap[Heap[sh#9, Node.next], Node.prev] == sh#9;
      }
      if (!(Heap[sh#9, Node.prev] == null)) {
        assume !(Heap[Heap[sh#9, Node.prev], Node.next] == null);
        assume Heap[Heap[sh#9, Node.prev], Node.next] == sh#9;
      }
      if (!(Heap[sh#9, Node.next] == null)) {
        assume MuBelow(Heap[sh#9, mu], Heap[Heap[sh#9, Node.next], mu]);
      }
      if (!(Heap[sh#9, Node.prev] == null)) {
        assume MuBelow(Heap[Heap[sh#9, Node.prev], mu], Heap[sh#9, mu]);
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      assume Acquire$Heap(lastAcquire#_472) == Heap;
      assume Acquire$Mask(lastAcquire#_472) == Mask;
      assume Acquire$SecMask(lastAcquire#_472) == SecMask;
      assume Acquire$Credits(lastAcquire#_472) == Credits;
      // Line #60:             if(next.next != null) { acquire next.next; }  
      assert {:msg "  60.37: SMOKE-TEST-19. (The statements after the acquire statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
  }
  // Line #63:         var oldPrev: Node;  
  // local var oldPrev
  // Line #63:         var oldPrev: Node;  
  assert {:msg "  63.9: SMOKE-TEST-20. (The statements after the local variable statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #64:         var oldNext: Node;  
  // local var oldNext
  // Line #64:         var oldNext: Node;  
  assert {:msg "  64.9: SMOKE-TEST-21. (The statements after the local variable statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #65:         oldPrev := prev;  
  // assigment to oldPrev
  assert {:msg "  65.20: Receiver might be null."} true ==> (this != null);
  assert {:msg "  65.20: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  oldPrev#2 := Heap[this, Node.prev];
  // Line #65:         oldPrev := prev;  
  assert {:msg "  65.9: SMOKE-TEST-22. (The statements after the assign statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #66:         oldNext := next;  
  // assigment to oldNext
  assert {:msg "  66.20: Receiver might be null."} true ==> (this != null);
  assert {:msg "  66.20: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  oldNext#4 := Heap[this, Node.next];
  // Line #66:         oldNext := next;  
  assert {:msg "  66.9: SMOKE-TEST-23. (The statements after the assign statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #67:         if (prev != null) { prev.next := this.next; }  
  // if
  cond#_476 := !(Heap[this, Node.prev] == null);
  assert {:msg "  67.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  67.13: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
  if (cond#_476) {
    // Line #0: <undefined position>
    // Line #67:         if (prev != null) { prev.next := this.next; }  
    assert {:msg "  67.9: SMOKE-TEST-24. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #67:         if (prev != null) { prev.next := this.next; }  
    assert {:msg "  67.29: Receiver might be null."} true ==> (this != null);
    assert {:msg "  67.29: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    assert {:msg "  67.42: Receiver might be null."} true ==> (this != null);
    assert {:msg "  67.42: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    // update field next
    assert {:msg "  67.29: Location might not be writable"} CanWrite(Mask, Heap[this, Node.prev], Node.next);
    Heap[Heap[this, Node.prev], Node.next] := Heap[this, Node.next];
    assume wf(Heap, Mask, SecMask);
    // Line #67:         if (prev != null) { prev.next := this.next; }  
    assert {:msg "  67.29: SMOKE-TEST-25. (The statements after the field update statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  }
  // Line #68:         if (next != null) { next.prev := this.prev; }  
  // if
  cond#_477 := !(Heap[this, Node.next] == null);
  assert {:msg "  68.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  68.13: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
  if (cond#_477) {
    // Line #0: <undefined position>
    // Line #68:         if (next != null) { next.prev := this.prev; }  
    assert {:msg "  68.9: SMOKE-TEST-26. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #68:         if (next != null) { next.prev := this.prev; }  
    assert {:msg "  68.29: Receiver might be null."} true ==> (this != null);
    assert {:msg "  68.29: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.next);
    assert {:msg "  68.42: Receiver might be null."} true ==> (this != null);
    assert {:msg "  68.42: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, Node.prev);
    // update field prev
    assert {:msg "  68.29: Location might not be writable"} CanWrite(Mask, Heap[this, Node.next], Node.prev);
    Heap[Heap[this, Node.next], Node.prev] := Heap[this, Node.prev];
    assume wf(Heap, Mask, SecMask);
    // Line #68:         if (next != null) { next.prev := this.prev; }  
    assert {:msg "  68.29: SMOKE-TEST-27. (The statements after the field update statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  }
  // Line #69:         this.next := null;  
  // update field next
  assert {:msg "  69.9: Location might not be writable"} CanWrite(Mask, this, Node.next);
  Heap[this, Node.next] := null;
  assume wf(Heap, Mask, SecMask);
  // Line #69:         this.next := null;  
  assert {:msg "  69.9: SMOKE-TEST-28. (The statements after the field update statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #70:         this.prev := null;  
  // update field prev
  assert {:msg "  70.9: Location might not be writable"} CanWrite(Mask, this, Node.prev);
  Heap[this, Node.prev] := null;
  assume wf(Heap, Mask, SecMask);
  // Line #70:         this.prev := null;  
  assert {:msg "  70.9: SMOKE-TEST-29. (The statements after the field update statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #71:         newList := oldNext;  
  // assigment to newList
  newList#0 := oldNext#4;
  // Line #71:         newList := oldNext;  
  assert {:msg "  71.9: SMOKE-TEST-30. (The statements after the assign statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #73:         release this;  
  // release
  assert {:msg "  73.9: The target of the release statement might be null."} this != null;
  preReleaseHeap#_480 := Heap;
  preReleaseMask#_481 := Mask;
  preReleaseSecMask#_482 := SecMask;
  preReleaseCredits#_483 := Credits;
  assert {:msg "  73.9: The target of the release statement might not be locked by the current thread."} 0 < Heap[this, held];
  assert {:msg "  73.9: Release might fail because the current thread might hold the read lock."} !Heap[this, rdheld];
  sh#10 := this;
  // begin exhale (monitor invariant)
  exhaleMask#_485 := Mask;
  havoc exhaleHeap#_484;
  if (!(Heap[sh#10, Node.next] == null)) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The expression at 11.31 might not evaluate to true."} !(Heap[Heap[sh#10, Node.next], Node.prev] == null);
    assert {:msg "  73.9: Monitor invariant might hot hold. The expression at 11.52 might not evaluate to true."} Heap[Heap[sh#10, Node.next], Node.prev] == sh#10;
  }
  if (!(Heap[sh#10, Node.prev] == null)) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The expression at 12.31 might not evaluate to true."} !(Heap[Heap[sh#10, Node.prev], Node.next] == null);
    assert {:msg "  73.9: Monitor invariant might hot hold. The expression at 12.52 might not evaluate to true."} Heap[Heap[sh#10, Node.prev], Node.next] == sh#10;
  }
  if (!(Heap[sh#10, Node.next] == null)) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The expression at 13.30 might not evaluate to true."} MuBelow(Heap[sh#10, mu], Heap[Heap[sh#10, Node.next], mu]);
  }
  if (!(Heap[sh#10, Node.prev] == null)) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The expression at 14.30 might not evaluate to true."} MuBelow(Heap[Heap[sh#10, Node.prev], mu], Heap[sh#10, mu]);
  }
  assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 6.15 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient permission at 6.15 for Node.prev."} ((Fractions(50) - 0) <= exhaleMask#_485[sh#10, Node.prev][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_485[sh#10, Node.prev][perm$R]) ==> ((0 - 1) <= exhaleMask#_485[sh#10, Node.prev][perm$N]));
  exhaleMask#_485[sh#10, Node.prev] := exhaleMask#_485[sh#10, Node.prev][perm$N := exhaleMask#_485[sh#10, Node.prev][perm$N] - (0 - 1)];
  exhaleMask#_485[sh#10, Node.prev] := exhaleMask#_485[sh#10, Node.prev][perm$R := exhaleMask#_485[sh#10, Node.prev][perm$R] - (Fractions(50) - 0)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(exhaleMask#_485);
  assume wf(Heap, exhaleMask#_485, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 6.38 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient permission at 6.38 for Node.next."} ((Fractions(50) - 0) <= exhaleMask#_485[sh#10, Node.next][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_485[sh#10, Node.next][perm$R]) ==> ((0 - 1) <= exhaleMask#_485[sh#10, Node.next][perm$N]));
  exhaleMask#_485[sh#10, Node.next] := exhaleMask#_485[sh#10, Node.next][perm$N := exhaleMask#_485[sh#10, Node.next][perm$N] - (0 - 1)];
  exhaleMask#_485[sh#10, Node.next] := exhaleMask#_485[sh#10, Node.next][perm$R := exhaleMask#_485[sh#10, Node.next][perm$R] - (Fractions(50) - 0)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(exhaleMask#_485);
  assume wf(Heap, exhaleMask#_485, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 6.61 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
  assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient permission at 6.61 for mu."} ((Fractions(50) - 0) <= exhaleMask#_485[sh#10, mu][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_485[sh#10, mu][perm$R]) ==> ((0 - 1) <= exhaleMask#_485[sh#10, mu][perm$N]));
  exhaleMask#_485[sh#10, mu] := exhaleMask#_485[sh#10, mu][perm$N := exhaleMask#_485[sh#10, mu][perm$N] - (0 - 1)];
  exhaleMask#_485[sh#10, mu] := exhaleMask#_485[sh#10, mu][perm$R := exhaleMask#_485[sh#10, mu][perm$R] - (Fractions(50) - 0)];
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(exhaleMask#_485);
  assume wf(Heap, exhaleMask#_485, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (Heap[sh#10, Node.next] == null) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 7.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 7.31 for Node.prev."} (Fractions(25) <= exhaleMask#_485[sh#10, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_485[sh#10, Node.prev][perm$R]) ==> (0 <= exhaleMask#_485[sh#10, Node.prev][perm$N]));
    exhaleMask#_485[sh#10, Node.prev] := exhaleMask#_485[sh#10, Node.prev][perm$R := exhaleMask#_485[sh#10, Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 7.48 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 7.48 for Node.next."} (Fractions(25) <= exhaleMask#_485[sh#10, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_485[sh#10, Node.next][perm$R]) ==> (0 <= exhaleMask#_485[sh#10, Node.next][perm$N]));
    exhaleMask#_485[sh#10, Node.next] := exhaleMask#_485[sh#10, Node.next][perm$R := exhaleMask#_485[sh#10, Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 7.65 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 7.65 for mu."} (Fractions(25) <= exhaleMask#_485[sh#10, mu][perm$R]) && ((Fractions(25) == exhaleMask#_485[sh#10, mu][perm$R]) ==> (0 <= exhaleMask#_485[sh#10, mu][perm$N]));
    exhaleMask#_485[sh#10, mu] := exhaleMask#_485[sh#10, mu][perm$R := exhaleMask#_485[sh#10, mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[sh#10, Node.next] == null)) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 8.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 8.31 for Node.next."} (Fractions(25) <= exhaleMask#_485[Heap[sh#10, Node.next], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_485[Heap[sh#10, Node.next], Node.next][perm$R]) ==> (0 <= exhaleMask#_485[Heap[sh#10, Node.next], Node.next][perm$N]));
    exhaleMask#_485[Heap[sh#10, Node.next], Node.next] := exhaleMask#_485[Heap[sh#10, Node.next], Node.next][perm$R := exhaleMask#_485[Heap[sh#10, Node.next], Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 8.53 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 8.53 for Node.prev."} (Fractions(25) <= exhaleMask#_485[Heap[sh#10, Node.next], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_485[Heap[sh#10, Node.next], Node.prev][perm$R]) ==> (0 <= exhaleMask#_485[Heap[sh#10, Node.next], Node.prev][perm$N]));
    exhaleMask#_485[Heap[sh#10, Node.next], Node.prev] := exhaleMask#_485[Heap[sh#10, Node.next], Node.prev][perm$R := exhaleMask#_485[Heap[sh#10, Node.next], Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 8.75 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 8.75 for mu."} (Fractions(25) <= exhaleMask#_485[Heap[sh#10, Node.next], mu][perm$R]) && ((Fractions(25) == exhaleMask#_485[Heap[sh#10, Node.next], mu][perm$R]) ==> (0 <= exhaleMask#_485[Heap[sh#10, Node.next], mu][perm$N]));
    exhaleMask#_485[Heap[sh#10, Node.next], mu] := exhaleMask#_485[Heap[sh#10, Node.next], mu][perm$R := exhaleMask#_485[Heap[sh#10, Node.next], mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (Heap[sh#10, Node.prev] == null) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 9.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 9.31 for Node.prev."} (Fractions(25) <= exhaleMask#_485[sh#10, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_485[sh#10, Node.prev][perm$R]) ==> (0 <= exhaleMask#_485[sh#10, Node.prev][perm$N]));
    exhaleMask#_485[sh#10, Node.prev] := exhaleMask#_485[sh#10, Node.prev][perm$R := exhaleMask#_485[sh#10, Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 9.48 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 9.48 for Node.next."} (Fractions(25) <= exhaleMask#_485[sh#10, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_485[sh#10, Node.next][perm$R]) ==> (0 <= exhaleMask#_485[sh#10, Node.next][perm$N]));
    exhaleMask#_485[sh#10, Node.next] := exhaleMask#_485[sh#10, Node.next][perm$R := exhaleMask#_485[sh#10, Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 9.65 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 9.65 for mu."} (Fractions(25) <= exhaleMask#_485[sh#10, mu][perm$R]) && ((Fractions(25) == exhaleMask#_485[sh#10, mu][perm$R]) ==> (0 <= exhaleMask#_485[sh#10, mu][perm$N]));
    exhaleMask#_485[sh#10, mu] := exhaleMask#_485[sh#10, mu][perm$R := exhaleMask#_485[sh#10, mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[sh#10, Node.prev] == null)) {
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 10.31 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 10.31 for Node.next."} (Fractions(25) <= exhaleMask#_485[Heap[sh#10, Node.prev], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_485[Heap[sh#10, Node.prev], Node.next][perm$R]) ==> (0 <= exhaleMask#_485[Heap[sh#10, Node.prev], Node.next][perm$N]));
    exhaleMask#_485[Heap[sh#10, Node.prev], Node.next] := exhaleMask#_485[Heap[sh#10, Node.prev], Node.next][perm$R := exhaleMask#_485[Heap[sh#10, Node.prev], Node.next][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 10.53 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 10.53 for Node.prev."} (Fractions(25) <= exhaleMask#_485[Heap[sh#10, Node.prev], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_485[Heap[sh#10, Node.prev], Node.prev][perm$R]) ==> (0 <= exhaleMask#_485[Heap[sh#10, Node.prev], Node.prev][perm$N]));
    exhaleMask#_485[Heap[sh#10, Node.prev], Node.prev] := exhaleMask#_485[Heap[sh#10, Node.prev], Node.prev][perm$R := exhaleMask#_485[Heap[sh#10, Node.prev], Node.prev][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  73.9: Monitor invariant might hot hold. The permission at 10.75 might not be positive."} Fractions(25) > 0;
    assert {:msg "  73.9: Monitor invariant might hot hold. Insufficient fraction at 10.75 for mu."} (Fractions(25) <= exhaleMask#_485[Heap[sh#10, Node.prev], mu][perm$R]) && ((Fractions(25) == exhaleMask#_485[Heap[sh#10, Node.prev], mu][perm$R]) ==> (0 <= exhaleMask#_485[Heap[sh#10, Node.prev], mu][perm$N]));
    exhaleMask#_485[Heap[sh#10, Node.prev], mu] := exhaleMask#_485[Heap[sh#10, Node.prev], mu][perm$R := exhaleMask#_485[Heap[sh#10, Node.prev], mu][perm$R] - Fractions(25)];
    assume IsGoodMask(exhaleMask#_485);
    assume wf(Heap, exhaleMask#_485, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_485;
  assume IsGoodExhaleState(exhaleHeap#_484, Heap, Mask, SecMask);
  Heap := exhaleHeap#_484;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  havoc held#_478;
  assume held#_478 <= 0;
  Heap[this, held] := held#_478;
  assume LastSeen$Heap(Heap[this, mu], held#_478) == preReleaseHeap#_480;
  assume LastSeen$Mask(Heap[this, mu], held#_478) == preReleaseMask#_481;
  assume LastSeen$SecMask(Heap[this, mu], held#_478) == preReleaseSecMask#_482;
  assume LastSeen$Credits(Heap[this, mu], held#_478) == preReleaseCredits#_483;
  // Line #73:         release this;  
  assert {:msg "  73.9: SMOKE-TEST-31. (The statements after the release statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #74:         if (oldNext != null) {  
  // if
  cond#_501 := !(oldNext#4 == null);
  if (cond#_501) {
    // Line #0: <undefined position>
    // Line #74:         if (oldNext != null) {  
    assert {:msg "  74.9: SMOKE-TEST-32. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #75:             if(oldNext.next != null) { release oldNext.next; }  
    // if
    cond#_502 := !(Heap[oldNext#4, Node.next] == null);
    assert {:msg "  75.16: Receiver might be null."} true ==> (oldNext#4 != null);
    assert {:msg "  75.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, oldNext#4, Node.next);
    if (cond#_502) {
      // Line #0: <undefined position>
      // Line #75:             if(oldNext.next != null) { release oldNext.next; }  
      assert {:msg "  75.13: SMOKE-TEST-33. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #75:             if(oldNext.next != null) { release oldNext.next; }  
      // release
      assert {:msg "  75.48: Receiver might be null."} true ==> (oldNext#4 != null);
      assert {:msg "  75.48: Location might not be readable."} true ==> CanRead(Mask, SecMask, oldNext#4, Node.next);
      assert {:msg "  75.40: The target of the release statement might be null."} Heap[oldNext#4, Node.next] != null;
      preReleaseHeap#_505 := Heap;
      preReleaseMask#_506 := Mask;
      preReleaseSecMask#_507 := SecMask;
      preReleaseCredits#_508 := Credits;
      assert {:msg "  75.40: The target of the release statement might not be locked by the current thread."} 0 < Heap[Heap[oldNext#4, Node.next], held];
      assert {:msg "  75.40: Release might fail because the current thread might hold the read lock."} !Heap[Heap[oldNext#4, Node.next], rdheld];
      sh#11 := Heap[oldNext#4, Node.next];
      // begin exhale (monitor invariant)
      exhaleMask#_510 := Mask;
      havoc exhaleHeap#_509;
      if (!(Heap[sh#11, Node.next] == null)) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The expression at 11.31 might not evaluate to true."} !(Heap[Heap[sh#11, Node.next], Node.prev] == null);
        assert {:msg "  75.40: Monitor invariant might hot hold. The expression at 11.52 might not evaluate to true."} Heap[Heap[sh#11, Node.next], Node.prev] == sh#11;
      }
      if (!(Heap[sh#11, Node.prev] == null)) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The expression at 12.31 might not evaluate to true."} !(Heap[Heap[sh#11, Node.prev], Node.next] == null);
        assert {:msg "  75.40: Monitor invariant might hot hold. The expression at 12.52 might not evaluate to true."} Heap[Heap[sh#11, Node.prev], Node.next] == sh#11;
      }
      if (!(Heap[sh#11, Node.next] == null)) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The expression at 13.30 might not evaluate to true."} MuBelow(Heap[sh#11, mu], Heap[Heap[sh#11, Node.next], mu]);
      }
      if (!(Heap[sh#11, Node.prev] == null)) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The expression at 14.30 might not evaluate to true."} MuBelow(Heap[Heap[sh#11, Node.prev], mu], Heap[sh#11, mu]);
      }
      assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 6.15 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient permission at 6.15 for Node.prev."} ((Fractions(50) - 0) <= exhaleMask#_510[sh#11, Node.prev][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_510[sh#11, Node.prev][perm$R]) ==> ((0 - 1) <= exhaleMask#_510[sh#11, Node.prev][perm$N]));
      exhaleMask#_510[sh#11, Node.prev] := exhaleMask#_510[sh#11, Node.prev][perm$N := exhaleMask#_510[sh#11, Node.prev][perm$N] - (0 - 1)];
      exhaleMask#_510[sh#11, Node.prev] := exhaleMask#_510[sh#11, Node.prev][perm$R := exhaleMask#_510[sh#11, Node.prev][perm$R] - (Fractions(50) - 0)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(exhaleMask#_510);
      assume wf(Heap, exhaleMask#_510, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 6.38 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient permission at 6.38 for Node.next."} ((Fractions(50) - 0) <= exhaleMask#_510[sh#11, Node.next][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_510[sh#11, Node.next][perm$R]) ==> ((0 - 1) <= exhaleMask#_510[sh#11, Node.next][perm$N]));
      exhaleMask#_510[sh#11, Node.next] := exhaleMask#_510[sh#11, Node.next][perm$N := exhaleMask#_510[sh#11, Node.next][perm$N] - (0 - 1)];
      exhaleMask#_510[sh#11, Node.next] := exhaleMask#_510[sh#11, Node.next][perm$R := exhaleMask#_510[sh#11, Node.next][perm$R] - (Fractions(50) - 0)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(exhaleMask#_510);
      assume wf(Heap, exhaleMask#_510, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 6.61 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient permission at 6.61 for mu."} ((Fractions(50) - 0) <= exhaleMask#_510[sh#11, mu][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_510[sh#11, mu][perm$R]) ==> ((0 - 1) <= exhaleMask#_510[sh#11, mu][perm$N]));
      exhaleMask#_510[sh#11, mu] := exhaleMask#_510[sh#11, mu][perm$N := exhaleMask#_510[sh#11, mu][perm$N] - (0 - 1)];
      exhaleMask#_510[sh#11, mu] := exhaleMask#_510[sh#11, mu][perm$R := exhaleMask#_510[sh#11, mu][perm$R] - (Fractions(50) - 0)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(exhaleMask#_510);
      assume wf(Heap, exhaleMask#_510, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (Heap[sh#11, Node.next] == null) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 7.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 7.31 for Node.prev."} (Fractions(25) <= exhaleMask#_510[sh#11, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_510[sh#11, Node.prev][perm$R]) ==> (0 <= exhaleMask#_510[sh#11, Node.prev][perm$N]));
        exhaleMask#_510[sh#11, Node.prev] := exhaleMask#_510[sh#11, Node.prev][perm$R := exhaleMask#_510[sh#11, Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 7.48 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 7.48 for Node.next."} (Fractions(25) <= exhaleMask#_510[sh#11, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_510[sh#11, Node.next][perm$R]) ==> (0 <= exhaleMask#_510[sh#11, Node.next][perm$N]));
        exhaleMask#_510[sh#11, Node.next] := exhaleMask#_510[sh#11, Node.next][perm$R := exhaleMask#_510[sh#11, Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 7.65 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 7.65 for mu."} (Fractions(25) <= exhaleMask#_510[sh#11, mu][perm$R]) && ((Fractions(25) == exhaleMask#_510[sh#11, mu][perm$R]) ==> (0 <= exhaleMask#_510[sh#11, mu][perm$N]));
        exhaleMask#_510[sh#11, mu] := exhaleMask#_510[sh#11, mu][perm$R := exhaleMask#_510[sh#11, mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#11, Node.next] == null)) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 8.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 8.31 for Node.next."} (Fractions(25) <= exhaleMask#_510[Heap[sh#11, Node.next], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_510[Heap[sh#11, Node.next], Node.next][perm$R]) ==> (0 <= exhaleMask#_510[Heap[sh#11, Node.next], Node.next][perm$N]));
        exhaleMask#_510[Heap[sh#11, Node.next], Node.next] := exhaleMask#_510[Heap[sh#11, Node.next], Node.next][perm$R := exhaleMask#_510[Heap[sh#11, Node.next], Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 8.53 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 8.53 for Node.prev."} (Fractions(25) <= exhaleMask#_510[Heap[sh#11, Node.next], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_510[Heap[sh#11, Node.next], Node.prev][perm$R]) ==> (0 <= exhaleMask#_510[Heap[sh#11, Node.next], Node.prev][perm$N]));
        exhaleMask#_510[Heap[sh#11, Node.next], Node.prev] := exhaleMask#_510[Heap[sh#11, Node.next], Node.prev][perm$R := exhaleMask#_510[Heap[sh#11, Node.next], Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 8.75 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 8.75 for mu."} (Fractions(25) <= exhaleMask#_510[Heap[sh#11, Node.next], mu][perm$R]) && ((Fractions(25) == exhaleMask#_510[Heap[sh#11, Node.next], mu][perm$R]) ==> (0 <= exhaleMask#_510[Heap[sh#11, Node.next], mu][perm$N]));
        exhaleMask#_510[Heap[sh#11, Node.next], mu] := exhaleMask#_510[Heap[sh#11, Node.next], mu][perm$R := exhaleMask#_510[Heap[sh#11, Node.next], mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (Heap[sh#11, Node.prev] == null) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 9.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 9.31 for Node.prev."} (Fractions(25) <= exhaleMask#_510[sh#11, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_510[sh#11, Node.prev][perm$R]) ==> (0 <= exhaleMask#_510[sh#11, Node.prev][perm$N]));
        exhaleMask#_510[sh#11, Node.prev] := exhaleMask#_510[sh#11, Node.prev][perm$R := exhaleMask#_510[sh#11, Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 9.48 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 9.48 for Node.next."} (Fractions(25) <= exhaleMask#_510[sh#11, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_510[sh#11, Node.next][perm$R]) ==> (0 <= exhaleMask#_510[sh#11, Node.next][perm$N]));
        exhaleMask#_510[sh#11, Node.next] := exhaleMask#_510[sh#11, Node.next][perm$R := exhaleMask#_510[sh#11, Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 9.65 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 9.65 for mu."} (Fractions(25) <= exhaleMask#_510[sh#11, mu][perm$R]) && ((Fractions(25) == exhaleMask#_510[sh#11, mu][perm$R]) ==> (0 <= exhaleMask#_510[sh#11, mu][perm$N]));
        exhaleMask#_510[sh#11, mu] := exhaleMask#_510[sh#11, mu][perm$R := exhaleMask#_510[sh#11, mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#11, Node.prev] == null)) {
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 10.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 10.31 for Node.next."} (Fractions(25) <= exhaleMask#_510[Heap[sh#11, Node.prev], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_510[Heap[sh#11, Node.prev], Node.next][perm$R]) ==> (0 <= exhaleMask#_510[Heap[sh#11, Node.prev], Node.next][perm$N]));
        exhaleMask#_510[Heap[sh#11, Node.prev], Node.next] := exhaleMask#_510[Heap[sh#11, Node.prev], Node.next][perm$R := exhaleMask#_510[Heap[sh#11, Node.prev], Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 10.53 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 10.53 for Node.prev."} (Fractions(25) <= exhaleMask#_510[Heap[sh#11, Node.prev], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_510[Heap[sh#11, Node.prev], Node.prev][perm$R]) ==> (0 <= exhaleMask#_510[Heap[sh#11, Node.prev], Node.prev][perm$N]));
        exhaleMask#_510[Heap[sh#11, Node.prev], Node.prev] := exhaleMask#_510[Heap[sh#11, Node.prev], Node.prev][perm$R := exhaleMask#_510[Heap[sh#11, Node.prev], Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  75.40: Monitor invariant might hot hold. The permission at 10.75 might not be positive."} Fractions(25) > 0;
        assert {:msg "  75.40: Monitor invariant might hot hold. Insufficient fraction at 10.75 for mu."} (Fractions(25) <= exhaleMask#_510[Heap[sh#11, Node.prev], mu][perm$R]) && ((Fractions(25) == exhaleMask#_510[Heap[sh#11, Node.prev], mu][perm$R]) ==> (0 <= exhaleMask#_510[Heap[sh#11, Node.prev], mu][perm$N]));
        exhaleMask#_510[Heap[sh#11, Node.prev], mu] := exhaleMask#_510[Heap[sh#11, Node.prev], mu][perm$R := exhaleMask#_510[Heap[sh#11, Node.prev], mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_510);
        assume wf(Heap, exhaleMask#_510, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      Mask := exhaleMask#_510;
      assume IsGoodExhaleState(exhaleHeap#_509, Heap, Mask, SecMask);
      Heap := exhaleHeap#_509;
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      havoc held#_503;
      assume held#_503 <= 0;
      Heap[Heap[oldNext#4, Node.next], held] := held#_503;
      assume LastSeen$Heap(Heap[Heap[oldNext#4, Node.next], mu], held#_503) == preReleaseHeap#_505;
      assume LastSeen$Mask(Heap[Heap[oldNext#4, Node.next], mu], held#_503) == preReleaseMask#_506;
      assume LastSeen$SecMask(Heap[Heap[oldNext#4, Node.next], mu], held#_503) == preReleaseSecMask#_507;
      assume LastSeen$Credits(Heap[Heap[oldNext#4, Node.next], mu], held#_503) == preReleaseCredits#_508;
      // Line #75:             if(oldNext.next != null) { release oldNext.next; }  
      assert {:msg "  75.40: SMOKE-TEST-34. (The statements after the release statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
    // Line #76:             release oldNext;  
    // release
    assert {:msg "  76.13: The target of the release statement might be null."} oldNext#4 != null;
    preReleaseHeap#_528 := Heap;
    preReleaseMask#_529 := Mask;
    preReleaseSecMask#_530 := SecMask;
    preReleaseCredits#_531 := Credits;
    assert {:msg "  76.13: The target of the release statement might not be locked by the current thread."} 0 < Heap[oldNext#4, held];
    assert {:msg "  76.13: Release might fail because the current thread might hold the read lock."} !Heap[oldNext#4, rdheld];
    sh#12 := oldNext#4;
    // begin exhale (monitor invariant)
    exhaleMask#_533 := Mask;
    havoc exhaleHeap#_532;
    if (!(Heap[sh#12, Node.next] == null)) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The expression at 11.31 might not evaluate to true."} !(Heap[Heap[sh#12, Node.next], Node.prev] == null);
      assert {:msg "  76.13: Monitor invariant might hot hold. The expression at 11.52 might not evaluate to true."} Heap[Heap[sh#12, Node.next], Node.prev] == sh#12;
    }
    if (!(Heap[sh#12, Node.prev] == null)) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The expression at 12.31 might not evaluate to true."} !(Heap[Heap[sh#12, Node.prev], Node.next] == null);
      assert {:msg "  76.13: Monitor invariant might hot hold. The expression at 12.52 might not evaluate to true."} Heap[Heap[sh#12, Node.prev], Node.next] == sh#12;
    }
    if (!(Heap[sh#12, Node.next] == null)) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The expression at 13.30 might not evaluate to true."} MuBelow(Heap[sh#12, mu], Heap[Heap[sh#12, Node.next], mu]);
    }
    if (!(Heap[sh#12, Node.prev] == null)) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The expression at 14.30 might not evaluate to true."} MuBelow(Heap[Heap[sh#12, Node.prev], mu], Heap[sh#12, mu]);
    }
    assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 6.15 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient permission at 6.15 for Node.prev."} ((Fractions(50) - 0) <= exhaleMask#_533[sh#12, Node.prev][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_533[sh#12, Node.prev][perm$R]) ==> ((0 - 1) <= exhaleMask#_533[sh#12, Node.prev][perm$N]));
    exhaleMask#_533[sh#12, Node.prev] := exhaleMask#_533[sh#12, Node.prev][perm$N := exhaleMask#_533[sh#12, Node.prev][perm$N] - (0 - 1)];
    exhaleMask#_533[sh#12, Node.prev] := exhaleMask#_533[sh#12, Node.prev][perm$R := exhaleMask#_533[sh#12, Node.prev][perm$R] - (Fractions(50) - 0)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(exhaleMask#_533);
    assume wf(Heap, exhaleMask#_533, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 6.38 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient permission at 6.38 for Node.next."} ((Fractions(50) - 0) <= exhaleMask#_533[sh#12, Node.next][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_533[sh#12, Node.next][perm$R]) ==> ((0 - 1) <= exhaleMask#_533[sh#12, Node.next][perm$N]));
    exhaleMask#_533[sh#12, Node.next] := exhaleMask#_533[sh#12, Node.next][perm$N := exhaleMask#_533[sh#12, Node.next][perm$N] - (0 - 1)];
    exhaleMask#_533[sh#12, Node.next] := exhaleMask#_533[sh#12, Node.next][perm$R := exhaleMask#_533[sh#12, Node.next][perm$R] - (Fractions(50) - 0)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(exhaleMask#_533);
    assume wf(Heap, exhaleMask#_533, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 6.61 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient permission at 6.61 for mu."} ((Fractions(50) - 0) <= exhaleMask#_533[sh#12, mu][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_533[sh#12, mu][perm$R]) ==> ((0 - 1) <= exhaleMask#_533[sh#12, mu][perm$N]));
    exhaleMask#_533[sh#12, mu] := exhaleMask#_533[sh#12, mu][perm$N := exhaleMask#_533[sh#12, mu][perm$N] - (0 - 1)];
    exhaleMask#_533[sh#12, mu] := exhaleMask#_533[sh#12, mu][perm$R := exhaleMask#_533[sh#12, mu][perm$R] - (Fractions(50) - 0)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(exhaleMask#_533);
    assume wf(Heap, exhaleMask#_533, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (Heap[sh#12, Node.next] == null) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 7.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 7.31 for Node.prev."} (Fractions(25) <= exhaleMask#_533[sh#12, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_533[sh#12, Node.prev][perm$R]) ==> (0 <= exhaleMask#_533[sh#12, Node.prev][perm$N]));
      exhaleMask#_533[sh#12, Node.prev] := exhaleMask#_533[sh#12, Node.prev][perm$R := exhaleMask#_533[sh#12, Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 7.48 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 7.48 for Node.next."} (Fractions(25) <= exhaleMask#_533[sh#12, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_533[sh#12, Node.next][perm$R]) ==> (0 <= exhaleMask#_533[sh#12, Node.next][perm$N]));
      exhaleMask#_533[sh#12, Node.next] := exhaleMask#_533[sh#12, Node.next][perm$R := exhaleMask#_533[sh#12, Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 7.65 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 7.65 for mu."} (Fractions(25) <= exhaleMask#_533[sh#12, mu][perm$R]) && ((Fractions(25) == exhaleMask#_533[sh#12, mu][perm$R]) ==> (0 <= exhaleMask#_533[sh#12, mu][perm$N]));
      exhaleMask#_533[sh#12, mu] := exhaleMask#_533[sh#12, mu][perm$R := exhaleMask#_533[sh#12, mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#12, Node.next] == null)) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 8.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 8.31 for Node.next."} (Fractions(25) <= exhaleMask#_533[Heap[sh#12, Node.next], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_533[Heap[sh#12, Node.next], Node.next][perm$R]) ==> (0 <= exhaleMask#_533[Heap[sh#12, Node.next], Node.next][perm$N]));
      exhaleMask#_533[Heap[sh#12, Node.next], Node.next] := exhaleMask#_533[Heap[sh#12, Node.next], Node.next][perm$R := exhaleMask#_533[Heap[sh#12, Node.next], Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 8.53 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 8.53 for Node.prev."} (Fractions(25) <= exhaleMask#_533[Heap[sh#12, Node.next], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_533[Heap[sh#12, Node.next], Node.prev][perm$R]) ==> (0 <= exhaleMask#_533[Heap[sh#12, Node.next], Node.prev][perm$N]));
      exhaleMask#_533[Heap[sh#12, Node.next], Node.prev] := exhaleMask#_533[Heap[sh#12, Node.next], Node.prev][perm$R := exhaleMask#_533[Heap[sh#12, Node.next], Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 8.75 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 8.75 for mu."} (Fractions(25) <= exhaleMask#_533[Heap[sh#12, Node.next], mu][perm$R]) && ((Fractions(25) == exhaleMask#_533[Heap[sh#12, Node.next], mu][perm$R]) ==> (0 <= exhaleMask#_533[Heap[sh#12, Node.next], mu][perm$N]));
      exhaleMask#_533[Heap[sh#12, Node.next], mu] := exhaleMask#_533[Heap[sh#12, Node.next], mu][perm$R := exhaleMask#_533[Heap[sh#12, Node.next], mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (Heap[sh#12, Node.prev] == null) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 9.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 9.31 for Node.prev."} (Fractions(25) <= exhaleMask#_533[sh#12, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_533[sh#12, Node.prev][perm$R]) ==> (0 <= exhaleMask#_533[sh#12, Node.prev][perm$N]));
      exhaleMask#_533[sh#12, Node.prev] := exhaleMask#_533[sh#12, Node.prev][perm$R := exhaleMask#_533[sh#12, Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 9.48 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 9.48 for Node.next."} (Fractions(25) <= exhaleMask#_533[sh#12, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_533[sh#12, Node.next][perm$R]) ==> (0 <= exhaleMask#_533[sh#12, Node.next][perm$N]));
      exhaleMask#_533[sh#12, Node.next] := exhaleMask#_533[sh#12, Node.next][perm$R := exhaleMask#_533[sh#12, Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 9.65 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 9.65 for mu."} (Fractions(25) <= exhaleMask#_533[sh#12, mu][perm$R]) && ((Fractions(25) == exhaleMask#_533[sh#12, mu][perm$R]) ==> (0 <= exhaleMask#_533[sh#12, mu][perm$N]));
      exhaleMask#_533[sh#12, mu] := exhaleMask#_533[sh#12, mu][perm$R := exhaleMask#_533[sh#12, mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#12, Node.prev] == null)) {
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 10.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 10.31 for Node.next."} (Fractions(25) <= exhaleMask#_533[Heap[sh#12, Node.prev], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_533[Heap[sh#12, Node.prev], Node.next][perm$R]) ==> (0 <= exhaleMask#_533[Heap[sh#12, Node.prev], Node.next][perm$N]));
      exhaleMask#_533[Heap[sh#12, Node.prev], Node.next] := exhaleMask#_533[Heap[sh#12, Node.prev], Node.next][perm$R := exhaleMask#_533[Heap[sh#12, Node.prev], Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 10.53 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 10.53 for Node.prev."} (Fractions(25) <= exhaleMask#_533[Heap[sh#12, Node.prev], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_533[Heap[sh#12, Node.prev], Node.prev][perm$R]) ==> (0 <= exhaleMask#_533[Heap[sh#12, Node.prev], Node.prev][perm$N]));
      exhaleMask#_533[Heap[sh#12, Node.prev], Node.prev] := exhaleMask#_533[Heap[sh#12, Node.prev], Node.prev][perm$R := exhaleMask#_533[Heap[sh#12, Node.prev], Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  76.13: Monitor invariant might hot hold. The permission at 10.75 might not be positive."} Fractions(25) > 0;
      assert {:msg "  76.13: Monitor invariant might hot hold. Insufficient fraction at 10.75 for mu."} (Fractions(25) <= exhaleMask#_533[Heap[sh#12, Node.prev], mu][perm$R]) && ((Fractions(25) == exhaleMask#_533[Heap[sh#12, Node.prev], mu][perm$R]) ==> (0 <= exhaleMask#_533[Heap[sh#12, Node.prev], mu][perm$N]));
      exhaleMask#_533[Heap[sh#12, Node.prev], mu] := exhaleMask#_533[Heap[sh#12, Node.prev], mu][perm$R := exhaleMask#_533[Heap[sh#12, Node.prev], mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_533);
      assume wf(Heap, exhaleMask#_533, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    Mask := exhaleMask#_533;
    assume IsGoodExhaleState(exhaleHeap#_532, Heap, Mask, SecMask);
    Heap := exhaleHeap#_532;
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end exhale
    havoc held#_526;
    assume held#_526 <= 0;
    Heap[oldNext#4, held] := held#_526;
    assume LastSeen$Heap(Heap[oldNext#4, mu], held#_526) == preReleaseHeap#_528;
    assume LastSeen$Mask(Heap[oldNext#4, mu], held#_526) == preReleaseMask#_529;
    assume LastSeen$SecMask(Heap[oldNext#4, mu], held#_526) == preReleaseSecMask#_530;
    assume LastSeen$Credits(Heap[oldNext#4, mu], held#_526) == preReleaseCredits#_531;
    // Line #76:             release oldNext;  
    assert {:msg "  76.13: SMOKE-TEST-35. (The statements after the release statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  }
  // Line #78:         if (oldPrev != null) {  
  // if
  cond#_549 := !(oldPrev#2 == null);
  if (cond#_549) {
    // Line #0: <undefined position>
    // Line #78:         if (oldPrev != null) {  
    assert {:msg "  78.9: SMOKE-TEST-36. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #79:             release oldPrev;  
    // release
    assert {:msg "  79.13: The target of the release statement might be null."} oldPrev#2 != null;
    preReleaseHeap#_552 := Heap;
    preReleaseMask#_553 := Mask;
    preReleaseSecMask#_554 := SecMask;
    preReleaseCredits#_555 := Credits;
    assert {:msg "  79.13: The target of the release statement might not be locked by the current thread."} 0 < Heap[oldPrev#2, held];
    assert {:msg "  79.13: Release might fail because the current thread might hold the read lock."} !Heap[oldPrev#2, rdheld];
    sh#13 := oldPrev#2;
    // begin exhale (monitor invariant)
    exhaleMask#_557 := Mask;
    havoc exhaleHeap#_556;
    if (!(Heap[sh#13, Node.next] == null)) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The expression at 11.31 might not evaluate to true."} !(Heap[Heap[sh#13, Node.next], Node.prev] == null);
      assert {:msg "  79.13: Monitor invariant might hot hold. The expression at 11.52 might not evaluate to true."} Heap[Heap[sh#13, Node.next], Node.prev] == sh#13;
    }
    if (!(Heap[sh#13, Node.prev] == null)) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The expression at 12.31 might not evaluate to true."} !(Heap[Heap[sh#13, Node.prev], Node.next] == null);
      assert {:msg "  79.13: Monitor invariant might hot hold. The expression at 12.52 might not evaluate to true."} Heap[Heap[sh#13, Node.prev], Node.next] == sh#13;
    }
    if (!(Heap[sh#13, Node.next] == null)) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The expression at 13.30 might not evaluate to true."} MuBelow(Heap[sh#13, mu], Heap[Heap[sh#13, Node.next], mu]);
    }
    if (!(Heap[sh#13, Node.prev] == null)) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The expression at 14.30 might not evaluate to true."} MuBelow(Heap[Heap[sh#13, Node.prev], mu], Heap[sh#13, mu]);
    }
    assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 6.15 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient permission at 6.15 for Node.prev."} ((Fractions(50) - 0) <= exhaleMask#_557[sh#13, Node.prev][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_557[sh#13, Node.prev][perm$R]) ==> ((0 - 1) <= exhaleMask#_557[sh#13, Node.prev][perm$N]));
    exhaleMask#_557[sh#13, Node.prev] := exhaleMask#_557[sh#13, Node.prev][perm$N := exhaleMask#_557[sh#13, Node.prev][perm$N] - (0 - 1)];
    exhaleMask#_557[sh#13, Node.prev] := exhaleMask#_557[sh#13, Node.prev][perm$R := exhaleMask#_557[sh#13, Node.prev][perm$R] - (Fractions(50) - 0)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(exhaleMask#_557);
    assume wf(Heap, exhaleMask#_557, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 6.38 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient permission at 6.38 for Node.next."} ((Fractions(50) - 0) <= exhaleMask#_557[sh#13, Node.next][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_557[sh#13, Node.next][perm$R]) ==> ((0 - 1) <= exhaleMask#_557[sh#13, Node.next][perm$N]));
    exhaleMask#_557[sh#13, Node.next] := exhaleMask#_557[sh#13, Node.next][perm$N := exhaleMask#_557[sh#13, Node.next][perm$N] - (0 - 1)];
    exhaleMask#_557[sh#13, Node.next] := exhaleMask#_557[sh#13, Node.next][perm$R := exhaleMask#_557[sh#13, Node.next][perm$R] - (Fractions(50) - 0)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(exhaleMask#_557);
    assume wf(Heap, exhaleMask#_557, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 6.61 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
    assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient permission at 6.61 for mu."} ((Fractions(50) - 0) <= exhaleMask#_557[sh#13, mu][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_557[sh#13, mu][perm$R]) ==> ((0 - 1) <= exhaleMask#_557[sh#13, mu][perm$N]));
    exhaleMask#_557[sh#13, mu] := exhaleMask#_557[sh#13, mu][perm$N := exhaleMask#_557[sh#13, mu][perm$N] - (0 - 1)];
    exhaleMask#_557[sh#13, mu] := exhaleMask#_557[sh#13, mu][perm$R := exhaleMask#_557[sh#13, mu][perm$R] - (Fractions(50) - 0)];
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(exhaleMask#_557);
    assume wf(Heap, exhaleMask#_557, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (Heap[sh#13, Node.next] == null) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 7.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 7.31 for Node.prev."} (Fractions(25) <= exhaleMask#_557[sh#13, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_557[sh#13, Node.prev][perm$R]) ==> (0 <= exhaleMask#_557[sh#13, Node.prev][perm$N]));
      exhaleMask#_557[sh#13, Node.prev] := exhaleMask#_557[sh#13, Node.prev][perm$R := exhaleMask#_557[sh#13, Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 7.48 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 7.48 for Node.next."} (Fractions(25) <= exhaleMask#_557[sh#13, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_557[sh#13, Node.next][perm$R]) ==> (0 <= exhaleMask#_557[sh#13, Node.next][perm$N]));
      exhaleMask#_557[sh#13, Node.next] := exhaleMask#_557[sh#13, Node.next][perm$R := exhaleMask#_557[sh#13, Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 7.65 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 7.65 for mu."} (Fractions(25) <= exhaleMask#_557[sh#13, mu][perm$R]) && ((Fractions(25) == exhaleMask#_557[sh#13, mu][perm$R]) ==> (0 <= exhaleMask#_557[sh#13, mu][perm$N]));
      exhaleMask#_557[sh#13, mu] := exhaleMask#_557[sh#13, mu][perm$R := exhaleMask#_557[sh#13, mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#13, Node.next] == null)) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 8.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 8.31 for Node.next."} (Fractions(25) <= exhaleMask#_557[Heap[sh#13, Node.next], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_557[Heap[sh#13, Node.next], Node.next][perm$R]) ==> (0 <= exhaleMask#_557[Heap[sh#13, Node.next], Node.next][perm$N]));
      exhaleMask#_557[Heap[sh#13, Node.next], Node.next] := exhaleMask#_557[Heap[sh#13, Node.next], Node.next][perm$R := exhaleMask#_557[Heap[sh#13, Node.next], Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 8.53 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 8.53 for Node.prev."} (Fractions(25) <= exhaleMask#_557[Heap[sh#13, Node.next], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_557[Heap[sh#13, Node.next], Node.prev][perm$R]) ==> (0 <= exhaleMask#_557[Heap[sh#13, Node.next], Node.prev][perm$N]));
      exhaleMask#_557[Heap[sh#13, Node.next], Node.prev] := exhaleMask#_557[Heap[sh#13, Node.next], Node.prev][perm$R := exhaleMask#_557[Heap[sh#13, Node.next], Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 8.75 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 8.75 for mu."} (Fractions(25) <= exhaleMask#_557[Heap[sh#13, Node.next], mu][perm$R]) && ((Fractions(25) == exhaleMask#_557[Heap[sh#13, Node.next], mu][perm$R]) ==> (0 <= exhaleMask#_557[Heap[sh#13, Node.next], mu][perm$N]));
      exhaleMask#_557[Heap[sh#13, Node.next], mu] := exhaleMask#_557[Heap[sh#13, Node.next], mu][perm$R := exhaleMask#_557[Heap[sh#13, Node.next], mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (Heap[sh#13, Node.prev] == null) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 9.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 9.31 for Node.prev."} (Fractions(25) <= exhaleMask#_557[sh#13, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_557[sh#13, Node.prev][perm$R]) ==> (0 <= exhaleMask#_557[sh#13, Node.prev][perm$N]));
      exhaleMask#_557[sh#13, Node.prev] := exhaleMask#_557[sh#13, Node.prev][perm$R := exhaleMask#_557[sh#13, Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 9.48 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 9.48 for Node.next."} (Fractions(25) <= exhaleMask#_557[sh#13, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_557[sh#13, Node.next][perm$R]) ==> (0 <= exhaleMask#_557[sh#13, Node.next][perm$N]));
      exhaleMask#_557[sh#13, Node.next] := exhaleMask#_557[sh#13, Node.next][perm$R := exhaleMask#_557[sh#13, Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 9.65 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 9.65 for mu."} (Fractions(25) <= exhaleMask#_557[sh#13, mu][perm$R]) && ((Fractions(25) == exhaleMask#_557[sh#13, mu][perm$R]) ==> (0 <= exhaleMask#_557[sh#13, mu][perm$N]));
      exhaleMask#_557[sh#13, mu] := exhaleMask#_557[sh#13, mu][perm$R := exhaleMask#_557[sh#13, mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[sh#13, Node.prev] == null)) {
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 10.31 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 10.31 for Node.next."} (Fractions(25) <= exhaleMask#_557[Heap[sh#13, Node.prev], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_557[Heap[sh#13, Node.prev], Node.next][perm$R]) ==> (0 <= exhaleMask#_557[Heap[sh#13, Node.prev], Node.next][perm$N]));
      exhaleMask#_557[Heap[sh#13, Node.prev], Node.next] := exhaleMask#_557[Heap[sh#13, Node.prev], Node.next][perm$R := exhaleMask#_557[Heap[sh#13, Node.prev], Node.next][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 10.53 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 10.53 for Node.prev."} (Fractions(25) <= exhaleMask#_557[Heap[sh#13, Node.prev], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_557[Heap[sh#13, Node.prev], Node.prev][perm$R]) ==> (0 <= exhaleMask#_557[Heap[sh#13, Node.prev], Node.prev][perm$N]));
      exhaleMask#_557[Heap[sh#13, Node.prev], Node.prev] := exhaleMask#_557[Heap[sh#13, Node.prev], Node.prev][perm$R := exhaleMask#_557[Heap[sh#13, Node.prev], Node.prev][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  79.13: Monitor invariant might hot hold. The permission at 10.75 might not be positive."} Fractions(25) > 0;
      assert {:msg "  79.13: Monitor invariant might hot hold. Insufficient fraction at 10.75 for mu."} (Fractions(25) <= exhaleMask#_557[Heap[sh#13, Node.prev], mu][perm$R]) && ((Fractions(25) == exhaleMask#_557[Heap[sh#13, Node.prev], mu][perm$R]) ==> (0 <= exhaleMask#_557[Heap[sh#13, Node.prev], mu][perm$N]));
      exhaleMask#_557[Heap[sh#13, Node.prev], mu] := exhaleMask#_557[Heap[sh#13, Node.prev], mu][perm$R := exhaleMask#_557[Heap[sh#13, Node.prev], mu][perm$R] - Fractions(25)];
      assume IsGoodMask(exhaleMask#_557);
      assume wf(Heap, exhaleMask#_557, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    Mask := exhaleMask#_557;
    assume IsGoodExhaleState(exhaleHeap#_556, Heap, Mask, SecMask);
    Heap := exhaleHeap#_556;
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end exhale
    havoc held#_550;
    assume held#_550 <= 0;
    Heap[oldPrev#2, held] := held#_550;
    assume LastSeen$Heap(Heap[oldPrev#2, mu], held#_550) == preReleaseHeap#_552;
    assume LastSeen$Mask(Heap[oldPrev#2, mu], held#_550) == preReleaseMask#_553;
    assume LastSeen$SecMask(Heap[oldPrev#2, mu], held#_550) == preReleaseSecMask#_554;
    assume LastSeen$Credits(Heap[oldPrev#2, mu], held#_550) == preReleaseCredits#_555;
    // Line #79:             release oldPrev;  
    assert {:msg "  79.13: SMOKE-TEST-37. (The statements after the release statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #80:             if(oldPrev.prev != null) { release oldPrev.prev; }  
    // if
    cond#_573 := !(Heap[oldPrev#2, Node.prev] == null);
    assert {:msg "  80.16: Receiver might be null."} true ==> (oldPrev#2 != null);
    assert {:msg "  80.16: Location might not be readable."} true ==> CanRead(Mask, SecMask, oldPrev#2, Node.prev);
    if (cond#_573) {
      // Line #0: <undefined position>
      // Line #80:             if(oldPrev.prev != null) { release oldPrev.prev; }  
      assert {:msg "  80.13: SMOKE-TEST-38. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #80:             if(oldPrev.prev != null) { release oldPrev.prev; }  
      // release
      assert {:msg "  80.48: Receiver might be null."} true ==> (oldPrev#2 != null);
      assert {:msg "  80.48: Location might not be readable."} true ==> CanRead(Mask, SecMask, oldPrev#2, Node.prev);
      assert {:msg "  80.40: The target of the release statement might be null."} Heap[oldPrev#2, Node.prev] != null;
      preReleaseHeap#_576 := Heap;
      preReleaseMask#_577 := Mask;
      preReleaseSecMask#_578 := SecMask;
      preReleaseCredits#_579 := Credits;
      assert {:msg "  80.40: The target of the release statement might not be locked by the current thread."} 0 < Heap[Heap[oldPrev#2, Node.prev], held];
      assert {:msg "  80.40: Release might fail because the current thread might hold the read lock."} !Heap[Heap[oldPrev#2, Node.prev], rdheld];
      sh#14 := Heap[oldPrev#2, Node.prev];
      // begin exhale (monitor invariant)
      exhaleMask#_581 := Mask;
      havoc exhaleHeap#_580;
      if (!(Heap[sh#14, Node.next] == null)) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The expression at 11.31 might not evaluate to true."} !(Heap[Heap[sh#14, Node.next], Node.prev] == null);
        assert {:msg "  80.40: Monitor invariant might hot hold. The expression at 11.52 might not evaluate to true."} Heap[Heap[sh#14, Node.next], Node.prev] == sh#14;
      }
      if (!(Heap[sh#14, Node.prev] == null)) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The expression at 12.31 might not evaluate to true."} !(Heap[Heap[sh#14, Node.prev], Node.next] == null);
        assert {:msg "  80.40: Monitor invariant might hot hold. The expression at 12.52 might not evaluate to true."} Heap[Heap[sh#14, Node.prev], Node.next] == sh#14;
      }
      if (!(Heap[sh#14, Node.next] == null)) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The expression at 13.30 might not evaluate to true."} MuBelow(Heap[sh#14, mu], Heap[Heap[sh#14, Node.next], mu]);
      }
      if (!(Heap[sh#14, Node.prev] == null)) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The expression at 14.30 might not evaluate to true."} MuBelow(Heap[Heap[sh#14, Node.prev], mu], Heap[sh#14, mu]);
      }
      assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 6.15 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient permission at 6.15 for Node.prev."} ((Fractions(50) - 0) <= exhaleMask#_581[sh#14, Node.prev][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_581[sh#14, Node.prev][perm$R]) ==> ((0 - 1) <= exhaleMask#_581[sh#14, Node.prev][perm$N]));
      exhaleMask#_581[sh#14, Node.prev] := exhaleMask#_581[sh#14, Node.prev][perm$N := exhaleMask#_581[sh#14, Node.prev][perm$N] - (0 - 1)];
      exhaleMask#_581[sh#14, Node.prev] := exhaleMask#_581[sh#14, Node.prev][perm$R := exhaleMask#_581[sh#14, Node.prev][perm$R] - (Fractions(50) - 0)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(exhaleMask#_581);
      assume wf(Heap, exhaleMask#_581, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 6.38 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient permission at 6.38 for Node.next."} ((Fractions(50) - 0) <= exhaleMask#_581[sh#14, Node.next][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_581[sh#14, Node.next][perm$R]) ==> ((0 - 1) <= exhaleMask#_581[sh#14, Node.next][perm$N]));
      exhaleMask#_581[sh#14, Node.next] := exhaleMask#_581[sh#14, Node.next][perm$N := exhaleMask#_581[sh#14, Node.next][perm$N] - (0 - 1)];
      exhaleMask#_581[sh#14, Node.next] := exhaleMask#_581[sh#14, Node.next][perm$R := exhaleMask#_581[sh#14, Node.next][perm$R] - (Fractions(50) - 0)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(exhaleMask#_581);
      assume wf(Heap, exhaleMask#_581, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 6.61 might not be positive."} ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
      assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient permission at 6.61 for mu."} ((Fractions(50) - 0) <= exhaleMask#_581[sh#14, mu][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_581[sh#14, mu][perm$R]) ==> ((0 - 1) <= exhaleMask#_581[sh#14, mu][perm$N]));
      exhaleMask#_581[sh#14, mu] := exhaleMask#_581[sh#14, mu][perm$N := exhaleMask#_581[sh#14, mu][perm$N] - (0 - 1)];
      exhaleMask#_581[sh#14, mu] := exhaleMask#_581[sh#14, mu][perm$R := exhaleMask#_581[sh#14, mu][perm$R] - (Fractions(50) - 0)];
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(exhaleMask#_581);
      assume wf(Heap, exhaleMask#_581, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (Heap[sh#14, Node.next] == null) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 7.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 7.31 for Node.prev."} (Fractions(25) <= exhaleMask#_581[sh#14, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_581[sh#14, Node.prev][perm$R]) ==> (0 <= exhaleMask#_581[sh#14, Node.prev][perm$N]));
        exhaleMask#_581[sh#14, Node.prev] := exhaleMask#_581[sh#14, Node.prev][perm$R := exhaleMask#_581[sh#14, Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 7.48 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 7.48 for Node.next."} (Fractions(25) <= exhaleMask#_581[sh#14, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_581[sh#14, Node.next][perm$R]) ==> (0 <= exhaleMask#_581[sh#14, Node.next][perm$N]));
        exhaleMask#_581[sh#14, Node.next] := exhaleMask#_581[sh#14, Node.next][perm$R := exhaleMask#_581[sh#14, Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 7.65 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 7.65 for mu."} (Fractions(25) <= exhaleMask#_581[sh#14, mu][perm$R]) && ((Fractions(25) == exhaleMask#_581[sh#14, mu][perm$R]) ==> (0 <= exhaleMask#_581[sh#14, mu][perm$N]));
        exhaleMask#_581[sh#14, mu] := exhaleMask#_581[sh#14, mu][perm$R := exhaleMask#_581[sh#14, mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#14, Node.next] == null)) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 8.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 8.31 for Node.next."} (Fractions(25) <= exhaleMask#_581[Heap[sh#14, Node.next], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_581[Heap[sh#14, Node.next], Node.next][perm$R]) ==> (0 <= exhaleMask#_581[Heap[sh#14, Node.next], Node.next][perm$N]));
        exhaleMask#_581[Heap[sh#14, Node.next], Node.next] := exhaleMask#_581[Heap[sh#14, Node.next], Node.next][perm$R := exhaleMask#_581[Heap[sh#14, Node.next], Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 8.53 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 8.53 for Node.prev."} (Fractions(25) <= exhaleMask#_581[Heap[sh#14, Node.next], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_581[Heap[sh#14, Node.next], Node.prev][perm$R]) ==> (0 <= exhaleMask#_581[Heap[sh#14, Node.next], Node.prev][perm$N]));
        exhaleMask#_581[Heap[sh#14, Node.next], Node.prev] := exhaleMask#_581[Heap[sh#14, Node.next], Node.prev][perm$R := exhaleMask#_581[Heap[sh#14, Node.next], Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 8.75 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 8.75 for mu."} (Fractions(25) <= exhaleMask#_581[Heap[sh#14, Node.next], mu][perm$R]) && ((Fractions(25) == exhaleMask#_581[Heap[sh#14, Node.next], mu][perm$R]) ==> (0 <= exhaleMask#_581[Heap[sh#14, Node.next], mu][perm$N]));
        exhaleMask#_581[Heap[sh#14, Node.next], mu] := exhaleMask#_581[Heap[sh#14, Node.next], mu][perm$R := exhaleMask#_581[Heap[sh#14, Node.next], mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (Heap[sh#14, Node.prev] == null) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 9.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 9.31 for Node.prev."} (Fractions(25) <= exhaleMask#_581[sh#14, Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_581[sh#14, Node.prev][perm$R]) ==> (0 <= exhaleMask#_581[sh#14, Node.prev][perm$N]));
        exhaleMask#_581[sh#14, Node.prev] := exhaleMask#_581[sh#14, Node.prev][perm$R := exhaleMask#_581[sh#14, Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 9.48 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 9.48 for Node.next."} (Fractions(25) <= exhaleMask#_581[sh#14, Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_581[sh#14, Node.next][perm$R]) ==> (0 <= exhaleMask#_581[sh#14, Node.next][perm$N]));
        exhaleMask#_581[sh#14, Node.next] := exhaleMask#_581[sh#14, Node.next][perm$R := exhaleMask#_581[sh#14, Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 9.65 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 9.65 for mu."} (Fractions(25) <= exhaleMask#_581[sh#14, mu][perm$R]) && ((Fractions(25) == exhaleMask#_581[sh#14, mu][perm$R]) ==> (0 <= exhaleMask#_581[sh#14, mu][perm$N]));
        exhaleMask#_581[sh#14, mu] := exhaleMask#_581[sh#14, mu][perm$R := exhaleMask#_581[sh#14, mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[sh#14, Node.prev] == null)) {
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 10.31 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 10.31 for Node.next."} (Fractions(25) <= exhaleMask#_581[Heap[sh#14, Node.prev], Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_581[Heap[sh#14, Node.prev], Node.next][perm$R]) ==> (0 <= exhaleMask#_581[Heap[sh#14, Node.prev], Node.next][perm$N]));
        exhaleMask#_581[Heap[sh#14, Node.prev], Node.next] := exhaleMask#_581[Heap[sh#14, Node.prev], Node.next][perm$R := exhaleMask#_581[Heap[sh#14, Node.prev], Node.next][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 10.53 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 10.53 for Node.prev."} (Fractions(25) <= exhaleMask#_581[Heap[sh#14, Node.prev], Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_581[Heap[sh#14, Node.prev], Node.prev][perm$R]) ==> (0 <= exhaleMask#_581[Heap[sh#14, Node.prev], Node.prev][perm$N]));
        exhaleMask#_581[Heap[sh#14, Node.prev], Node.prev] := exhaleMask#_581[Heap[sh#14, Node.prev], Node.prev][perm$R := exhaleMask#_581[Heap[sh#14, Node.prev], Node.prev][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  80.40: Monitor invariant might hot hold. The permission at 10.75 might not be positive."} Fractions(25) > 0;
        assert {:msg "  80.40: Monitor invariant might hot hold. Insufficient fraction at 10.75 for mu."} (Fractions(25) <= exhaleMask#_581[Heap[sh#14, Node.prev], mu][perm$R]) && ((Fractions(25) == exhaleMask#_581[Heap[sh#14, Node.prev], mu][perm$R]) ==> (0 <= exhaleMask#_581[Heap[sh#14, Node.prev], mu][perm$N]));
        exhaleMask#_581[Heap[sh#14, Node.prev], mu] := exhaleMask#_581[Heap[sh#14, Node.prev], mu][perm$R := exhaleMask#_581[Heap[sh#14, Node.prev], mu][perm$R] - Fractions(25)];
        assume IsGoodMask(exhaleMask#_581);
        assume wf(Heap, exhaleMask#_581, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      Mask := exhaleMask#_581;
      assume IsGoodExhaleState(exhaleHeap#_580, Heap, Mask, SecMask);
      Heap := exhaleHeap#_580;
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      havoc held#_574;
      assume held#_574 <= 0;
      Heap[Heap[oldPrev#2, Node.prev], held] := held#_574;
      assume LastSeen$Heap(Heap[Heap[oldPrev#2, Node.prev], mu], held#_574) == preReleaseHeap#_576;
      assume LastSeen$Mask(Heap[Heap[oldPrev#2, Node.prev], mu], held#_574) == preReleaseMask#_577;
      assume LastSeen$SecMask(Heap[Heap[oldPrev#2, Node.prev], mu], held#_574) == preReleaseSecMask#_578;
      assume LastSeen$Credits(Heap[Heap[oldPrev#2, Node.prev], mu], held#_574) == preReleaseCredits#_579;
      // Line #80:             if(oldPrev.prev != null) { release oldPrev.prev; }  
      assert {:msg "  80.40: SMOKE-TEST-39. (The statements after the release statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
  }
  // Line #82:         fold inv;  
  // fold
  assume #Node.inv#trigger(this);
  assume (0 < foldK#_600) && ((1000 * foldK#_600) < Fractions(1)) && ((1000 * foldK#_600) < methodK#_170);
  assert {:msg "  82.9: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_602 := Mask;
  havoc exhaleHeap#_601;
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. The expression at 18.41 might not evaluate to true."} MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
  }
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. The expression at 19.42 might not evaluate to true."} MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
  }
  assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. The permission at 17.9 might not be positive."} 1 > 0;
  assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. Insufficient epsilons at 17.9  for Node.prev."} (exhaleMask#_602[this, Node.prev][perm$R] == 0) ==> (1 <= exhaleMask#_602[this, Node.prev][perm$N]);
  exhaleMask#_602[this, Node.prev] := exhaleMask#_602[this, Node.prev][perm$N := exhaleMask#_602[this, Node.prev][perm$N] - 1];
  assume wf(Heap, Mask, SecMask);
  assume 1 > 0;
  SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := SecMask[this, Node.prev][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(exhaleMask#_602);
  assume wf(Heap, exhaleMask#_602, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. The permission at 17.29 might not be positive."} 1 > 0;
  assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. Insufficient epsilons at 17.29  for Node.next."} (exhaleMask#_602[this, Node.next][perm$R] == 0) ==> (1 <= exhaleMask#_602[this, Node.next][perm$N]);
  exhaleMask#_602[this, Node.next] := exhaleMask#_602[this, Node.next][perm$N := exhaleMask#_602[this, Node.next][perm$N] - 1];
  assume wf(Heap, Mask, SecMask);
  assume 1 > 0;
  SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := SecMask[this, Node.next][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(exhaleMask#_602);
  assume wf(Heap, exhaleMask#_602, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. The permission at 17.49 might not be positive."} 1 > 0;
  assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. Insufficient epsilons at 17.49  for mu."} (exhaleMask#_602[this, mu][perm$R] == 0) ==> (1 <= exhaleMask#_602[this, mu][perm$N]);
  exhaleMask#_602[this, mu] := exhaleMask#_602[this, mu][perm$N := exhaleMask#_602[this, mu][perm$N] - 1];
  assume wf(Heap, Mask, SecMask);
  assume 1 > 0;
  SecMask[this, mu] := SecMask[this, mu][perm$N := SecMask[this, mu][perm$N] + 1];
  assume wf(Heap, SecMask, SecMask);
  assume IsGoodMask(exhaleMask#_602);
  assume wf(Heap, exhaleMask#_602, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this, Node.prev] == null)) {
    assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. The permission at 18.25 might not be positive."} Fractions(100) > 0;
    assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. Insufficient fraction at 18.25 for Node.invLeft."} (Fractions(100) <= exhaleMask#_602[Heap[this, Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == exhaleMask#_602[Heap[this, Node.prev], Node.invLeft][perm$R]) ==> (0 <= exhaleMask#_602[Heap[this, Node.prev], Node.invLeft][perm$N]));
    exhaleMask#_602[Heap[this, Node.prev], Node.invLeft] := exhaleMask#_602[Heap[this, Node.prev], Node.invLeft][perm$R := exhaleMask#_602[Heap[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
    assume Fractions(100) > 0;
    SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
    if (!CanRead(exhaleMask#_602, SecMask, Heap[this, Node.prev], Node.invLeft)) {
      assume Heap[Heap[this, Node.prev], Node.invLeft] < exhaleHeap#_601[Heap[this, Node.prev], Node.invLeft];
    }
    assume IsGoodMask(exhaleMask#_602);
    assume wf(Heap, exhaleMask#_602, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, Node.next] == null)) {
    assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. The permission at 19.25 might not be positive."} Fractions(100) > 0;
    assert {:msg "  82.9: Fold might fail because the definition of Node.inv does not hold. Insufficient fraction at 19.25 for Node.invRight."} (Fractions(100) <= exhaleMask#_602[Heap[this, Node.next], Node.invRight][perm$R]) && ((Fractions(100) == exhaleMask#_602[Heap[this, Node.next], Node.invRight][perm$R]) ==> (0 <= exhaleMask#_602[Heap[this, Node.next], Node.invRight][perm$N]));
    exhaleMask#_602[Heap[this, Node.next], Node.invRight] := exhaleMask#_602[Heap[this, Node.next], Node.invRight][perm$R := exhaleMask#_602[Heap[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
    assume Fractions(100) > 0;
    SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := SecMask[Heap[this, Node.next], Node.invRight][perm$R] + Fractions(100)];
    if (!CanRead(exhaleMask#_602, SecMask, Heap[this, Node.next], Node.invRight)) {
      assume Heap[Heap[this, Node.next], Node.invRight] < exhaleHeap#_601[Heap[this, Node.next], Node.invRight];
    }
    assume IsGoodMask(exhaleMask#_602);
    assume wf(Heap, exhaleMask#_602, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_602;
  assume IsGoodExhaleState(exhaleHeap#_601, Heap, Mask, SecMask);
  Heap := exhaleHeap#_601;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (fold)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this, Node.inv] := Mask[this, Node.inv][perm$R := Mask[this, Node.inv][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, Node.inv]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  predRec#_597 := this;
  predVer#_598 := Heap[this, Node.inv];
  predFlag#_599 := true;
  assume wf(Heap, Mask, SecMask);
  // Line #82:         fold inv;  
  assert {:msg "  82.9: SMOKE-TEST-40. (The statements after the fold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  // Line #83:         if (newList != null) {  
  // if
  cond#_608 := !(newList#0 == null);
  if (cond#_608) {
    // Line #0: <undefined position>
    // Line #83:         if (newList != null) {  
    assert {:msg "  83.9: SMOKE-TEST-41. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
    // Line #84:             if (newList.next != null) { fold newList.next.invRight; }  
    // if
    cond#_609 := !(Heap[newList#0, Node.next] == null);
    assert {:msg "  84.17: Receiver might be null."} true ==> (newList#0 != null);
    assert {:msg "  84.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, newList#0, Node.next);
    if (cond#_609) {
      // Line #0: <undefined position>
      // Line #84:             if (newList.next != null) { fold newList.next.invRight; }  
      assert {:msg "  84.13: SMOKE-TEST-42. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #84:             if (newList.next != null) { fold newList.next.invRight; }  
      // fold
      assume #Node.invRight#trigger(Heap[newList#0, Node.next]);
      assume (0 < foldK#_613) && ((1000 * foldK#_613) < Fractions(1)) && ((1000 * foldK#_613) < methodK#_170);
      assert {:msg "  84.46: Receiver might be null."} true ==> (newList#0 != null);
      assert {:msg "  84.46: Location might not be readable."} true ==> CanRead(Mask, SecMask, newList#0, Node.next);
      assert {:msg "  84.41: The target of the fold statement might be null."} Heap[newList#0, Node.next] != null;
      // begin exhale (fold)
      exhaleMask#_615 := Mask;
      havoc exhaleHeap#_614;
      if (!(Heap[Heap[newList#0, Node.next], Node.next] == null)) {
        assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. The expression at 27.42 might not evaluate to true."} MuBelow(Heap[Heap[newList#0, Node.next], mu], Heap[Heap[Heap[newList#0, Node.next], Node.next], mu]);
      }
      assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. The permission at 26.9 might not be positive."} 1 > 0;
      assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. Insufficient epsilons at 26.9  for Node.prev."} (exhaleMask#_615[Heap[newList#0, Node.next], Node.prev][perm$R] == 0) ==> (1 <= exhaleMask#_615[Heap[newList#0, Node.next], Node.prev][perm$N]);
      exhaleMask#_615[Heap[newList#0, Node.next], Node.prev] := exhaleMask#_615[Heap[newList#0, Node.next], Node.prev][perm$N := exhaleMask#_615[Heap[newList#0, Node.next], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      assume 1 > 0;
      SecMask[Heap[newList#0, Node.next], Node.prev] := SecMask[Heap[newList#0, Node.next], Node.prev][perm$N := SecMask[Heap[newList#0, Node.next], Node.prev][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(exhaleMask#_615);
      assume wf(Heap, exhaleMask#_615, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. The permission at 26.29 might not be positive."} 1 > 0;
      assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. Insufficient epsilons at 26.29  for Node.next."} (exhaleMask#_615[Heap[newList#0, Node.next], Node.next][perm$R] == 0) ==> (1 <= exhaleMask#_615[Heap[newList#0, Node.next], Node.next][perm$N]);
      exhaleMask#_615[Heap[newList#0, Node.next], Node.next] := exhaleMask#_615[Heap[newList#0, Node.next], Node.next][perm$N := exhaleMask#_615[Heap[newList#0, Node.next], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      assume 1 > 0;
      SecMask[Heap[newList#0, Node.next], Node.next] := SecMask[Heap[newList#0, Node.next], Node.next][perm$N := SecMask[Heap[newList#0, Node.next], Node.next][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(exhaleMask#_615);
      assume wf(Heap, exhaleMask#_615, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. The permission at 26.49 might not be positive."} 1 > 0;
      assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. Insufficient epsilons at 26.49  for mu."} (exhaleMask#_615[Heap[newList#0, Node.next], mu][perm$R] == 0) ==> (1 <= exhaleMask#_615[Heap[newList#0, Node.next], mu][perm$N]);
      exhaleMask#_615[Heap[newList#0, Node.next], mu] := exhaleMask#_615[Heap[newList#0, Node.next], mu][perm$N := exhaleMask#_615[Heap[newList#0, Node.next], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      assume 1 > 0;
      SecMask[Heap[newList#0, Node.next], mu] := SecMask[Heap[newList#0, Node.next], mu][perm$N := SecMask[Heap[newList#0, Node.next], mu][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(exhaleMask#_615);
      assume wf(Heap, exhaleMask#_615, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[newList#0, Node.next], Node.next] == null)) {
        assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. The permission at 27.25 might not be positive."} Fractions(100) > 0;
        assert {:msg "  84.41: Fold might fail because the definition of Node.invRight does not hold. Insufficient fraction at 27.25 for Node.invRight."} (Fractions(100) <= exhaleMask#_615[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R]) && ((Fractions(100) == exhaleMask#_615[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R]) ==> (0 <= exhaleMask#_615[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$N]));
        exhaleMask#_615[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight] := exhaleMask#_615[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R := exhaleMask#_615[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
        assume Fractions(100) > 0;
        SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R] + Fractions(100)];
        if (!CanRead(exhaleMask#_615, SecMask, Heap[Heap[newList#0, Node.next], Node.next], Node.invRight)) {
          assume Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight] < exhaleHeap#_614[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight];
        }
        assume IsGoodMask(exhaleMask#_615);
        assume wf(Heap, exhaleMask#_615, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      Mask := exhaleMask#_615;
      assume IsGoodExhaleState(exhaleHeap#_614, Heap, Mask, SecMask);
      Heap := exhaleHeap#_614;
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      // inhale (fold)
      assume Heap[newList#0, Node.next] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      Mask[Heap[newList#0, Node.next], Node.invRight] := Mask[Heap[newList#0, Node.next], Node.invRight][perm$R := Mask[Heap[newList#0, Node.next], Node.invRight][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[newList#0, Node.next], Node.invRight]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      predRec#_610 := Heap[newList#0, Node.next];
      predVer#_611 := Heap[Heap[newList#0, Node.next], Node.invRight];
      predFlag#_612 := true;
      assume wf(Heap, Mask, SecMask);
      // Line #84:             if (newList.next != null) { fold newList.next.invRight; }  
      assert {:msg "  84.41: SMOKE-TEST-43. (The statements after the fold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
    // Line #85:             if (newList.prev != null) {  
    // if
    cond#_620 := !(Heap[newList#0, Node.prev] == null);
    assert {:msg "  85.17: Receiver might be null."} true ==> (newList#0 != null);
    assert {:msg "  85.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, newList#0, Node.prev);
    if (cond#_620) {
      // Line #0: <undefined position>
      // Line #85:             if (newList.prev != null) {  
      assert {:msg "  85.13: SMOKE-TEST-44. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
      // Line #86:                 if (newList.prev.prev != null) { fold newList.prev.prev.invLeft }  
      // if
      cond#_621 := !(Heap[Heap[newList#0, Node.prev], Node.prev] == null);
      assert {:msg "  86.21: Receiver might be null."} true ==> (newList#0 != null);
      assert {:msg "  86.21: Location might not be readable."} true ==> CanRead(Mask, SecMask, newList#0, Node.prev);
      assert {:msg "  86.21: Receiver might be null."} true ==> (Heap[newList#0, Node.prev] != null);
      assert {:msg "  86.21: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[newList#0, Node.prev], Node.prev);
      if (cond#_621) {
        // Line #0: <undefined position>
        // Line #86:                 if (newList.prev.prev != null) { fold newList.prev.prev.invLeft }  
        assert {:msg "  86.17: SMOKE-TEST-45. (The begging of the if-branch is unreachable.)"}{:subsumption 0} !(1 == 1);
        // Line #86:                 if (newList.prev.prev != null) { fold newList.prev.prev.invLeft }  
        // fold
        assume #Node.invLeft#trigger(Heap[Heap[newList#0, Node.prev], Node.prev]);
        assume (0 < foldK#_625) && ((1000 * foldK#_625) < Fractions(1)) && ((1000 * foldK#_625) < methodK#_170);
        assert {:msg "  86.55: Receiver might be null."} true ==> (newList#0 != null);
        assert {:msg "  86.55: Location might not be readable."} true ==> CanRead(Mask, SecMask, newList#0, Node.prev);
        assert {:msg "  86.55: Receiver might be null."} true ==> (Heap[newList#0, Node.prev] != null);
        assert {:msg "  86.55: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[newList#0, Node.prev], Node.prev);
        assert {:msg "  86.50: The target of the fold statement might be null."} Heap[Heap[newList#0, Node.prev], Node.prev] != null;
        // begin exhale (fold)
        exhaleMask#_627 := Mask;
        havoc exhaleHeap#_626;
        if (!(Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] == null)) {
          assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. The expression at 23.41 might not evaluate to true."} MuBelow(Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[newList#0, Node.prev], Node.prev], mu]);
        }
        assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. The permission at 22.9 might not be positive."} 1 > 0;
        assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. Insufficient epsilons at 22.9  for Node.prev."} (exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$R] == 0) ==> (1 <= exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N]);
        exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] := exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N := exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        assume 1 > 0;
        SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(exhaleMask#_627);
        assume wf(Heap, exhaleMask#_627, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. The permission at 22.29 might not be positive."} 1 > 0;
        assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. Insufficient epsilons at 22.29  for Node.next."} (exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$R] == 0) ==> (1 <= exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N]);
        exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next] := exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N := exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        assume 1 > 0;
        SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(exhaleMask#_627);
        assume wf(Heap, exhaleMask#_627, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. The permission at 22.49 might not be positive."} 1 > 0;
        assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. Insufficient epsilons at 22.49  for mu."} (exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$R] == 0) ==> (1 <= exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N]);
        exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], mu] := exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N := exhaleMask#_627[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        assume 1 > 0;
        SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N] + 1];
        assume wf(Heap, SecMask, SecMask);
        assume IsGoodMask(exhaleMask#_627);
        assume wf(Heap, exhaleMask#_627, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] == null)) {
          assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. The permission at 23.25 might not be positive."} Fractions(100) > 0;
          assert {:msg "  86.50: Fold might fail because the definition of Node.invLeft does not hold. Insufficient fraction at 23.25 for Node.invLeft."} (Fractions(100) <= exhaleMask#_627[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == exhaleMask#_627[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R]) ==> (0 <= exhaleMask#_627[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$N]));
          exhaleMask#_627[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft] := exhaleMask#_627[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := exhaleMask#_627[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          assume Fractions(100) > 0;
          SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
          if (!CanRead(exhaleMask#_627, SecMask, Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft)) {
            assume Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft] < exhaleHeap#_626[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft];
          }
          assume IsGoodMask(exhaleMask#_627);
          assume wf(Heap, exhaleMask#_627, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        Mask := exhaleMask#_627;
        assume IsGoodExhaleState(exhaleHeap#_626, Heap, Mask, SecMask);
        Heap := exhaleHeap#_626;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        // inhale (fold)
        assume Heap[Heap[newList#0, Node.prev], Node.prev] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft] := Mask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R := Mask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
        predRec#_622 := Heap[Heap[newList#0, Node.prev], Node.prev];
        predVer#_623 := Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft];
        predFlag#_624 := true;
        assume wf(Heap, Mask, SecMask);
        // Line #86:                 if (newList.prev.prev != null) { fold newList.prev.prev.invLeft }  
        assert {:msg "  86.50: SMOKE-TEST-46. (The statements after the fold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
      }
      // Line #87:                 fold newList.prev.invLeft  
      // fold
      assume #Node.invLeft#trigger(Heap[newList#0, Node.prev]);
      assume (0 < foldK#_635) && ((1000 * foldK#_635) < Fractions(1)) && ((1000 * foldK#_635) < methodK#_170);
      assert {:msg "  87.22: Receiver might be null."} true ==> (newList#0 != null);
      assert {:msg "  87.22: Location might not be readable."} true ==> CanRead(Mask, SecMask, newList#0, Node.prev);
      assert {:msg "  87.17: The target of the fold statement might be null."} Heap[newList#0, Node.prev] != null;
      // begin exhale (fold)
      exhaleMask#_637 := Mask;
      havoc exhaleHeap#_636;
      if (!(Heap[Heap[newList#0, Node.prev], Node.prev] == null)) {
        assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. The expression at 23.41 might not evaluate to true."} MuBelow(Heap[Heap[Heap[newList#0, Node.prev], Node.prev], mu], Heap[Heap[newList#0, Node.prev], mu]);
      }
      assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. The permission at 22.9 might not be positive."} 1 > 0;
      assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. Insufficient epsilons at 22.9  for Node.prev."} (exhaleMask#_637[Heap[newList#0, Node.prev], Node.prev][perm$R] == 0) ==> (1 <= exhaleMask#_637[Heap[newList#0, Node.prev], Node.prev][perm$N]);
      exhaleMask#_637[Heap[newList#0, Node.prev], Node.prev] := exhaleMask#_637[Heap[newList#0, Node.prev], Node.prev][perm$N := exhaleMask#_637[Heap[newList#0, Node.prev], Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      assume 1 > 0;
      SecMask[Heap[newList#0, Node.prev], Node.prev] := SecMask[Heap[newList#0, Node.prev], Node.prev][perm$N := SecMask[Heap[newList#0, Node.prev], Node.prev][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(exhaleMask#_637);
      assume wf(Heap, exhaleMask#_637, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. The permission at 22.29 might not be positive."} 1 > 0;
      assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. Insufficient epsilons at 22.29  for Node.next."} (exhaleMask#_637[Heap[newList#0, Node.prev], Node.next][perm$R] == 0) ==> (1 <= exhaleMask#_637[Heap[newList#0, Node.prev], Node.next][perm$N]);
      exhaleMask#_637[Heap[newList#0, Node.prev], Node.next] := exhaleMask#_637[Heap[newList#0, Node.prev], Node.next][perm$N := exhaleMask#_637[Heap[newList#0, Node.prev], Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      assume 1 > 0;
      SecMask[Heap[newList#0, Node.prev], Node.next] := SecMask[Heap[newList#0, Node.prev], Node.next][perm$N := SecMask[Heap[newList#0, Node.prev], Node.next][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(exhaleMask#_637);
      assume wf(Heap, exhaleMask#_637, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. The permission at 22.49 might not be positive."} 1 > 0;
      assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. Insufficient epsilons at 22.49  for mu."} (exhaleMask#_637[Heap[newList#0, Node.prev], mu][perm$R] == 0) ==> (1 <= exhaleMask#_637[Heap[newList#0, Node.prev], mu][perm$N]);
      exhaleMask#_637[Heap[newList#0, Node.prev], mu] := exhaleMask#_637[Heap[newList#0, Node.prev], mu][perm$N := exhaleMask#_637[Heap[newList#0, Node.prev], mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      assume 1 > 0;
      SecMask[Heap[newList#0, Node.prev], mu] := SecMask[Heap[newList#0, Node.prev], mu][perm$N := SecMask[Heap[newList#0, Node.prev], mu][perm$N] + 1];
      assume wf(Heap, SecMask, SecMask);
      assume IsGoodMask(exhaleMask#_637);
      assume wf(Heap, exhaleMask#_637, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[newList#0, Node.prev], Node.prev] == null)) {
        assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. The permission at 23.25 might not be positive."} Fractions(100) > 0;
        assert {:msg "  87.17: Fold might fail because the definition of Node.invLeft does not hold. Insufficient fraction at 23.25 for Node.invLeft."} (Fractions(100) <= exhaleMask#_637[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == exhaleMask#_637[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R]) ==> (0 <= exhaleMask#_637[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$N]));
        exhaleMask#_637[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft] := exhaleMask#_637[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R := exhaleMask#_637[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        assume Fractions(100) > 0;
        SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R] + Fractions(100)];
        if (!CanRead(exhaleMask#_637, SecMask, Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft)) {
          assume Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft] < exhaleHeap#_636[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft];
        }
        assume IsGoodMask(exhaleMask#_637);
        assume wf(Heap, exhaleMask#_637, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      Mask := exhaleMask#_637;
      assume IsGoodExhaleState(exhaleHeap#_636, Heap, Mask, SecMask);
      Heap := exhaleHeap#_636;
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      // inhale (fold)
      assume Heap[newList#0, Node.prev] != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      Mask[Heap[newList#0, Node.prev], Node.invLeft] := Mask[Heap[newList#0, Node.prev], Node.invLeft][perm$R := Mask[Heap[newList#0, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[Heap[newList#0, Node.prev], Node.invLeft]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      predRec#_632 := Heap[newList#0, Node.prev];
      predVer#_633 := Heap[Heap[newList#0, Node.prev], Node.invLeft];
      predFlag#_634 := true;
      assume wf(Heap, Mask, SecMask);
      // Line #87:                 fold newList.prev.invLeft  
      assert {:msg "  87.17: SMOKE-TEST-47. (The statements after the fold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
    }
    // Line #89:             fold newList.inv  
    // fold
    assume #Node.inv#trigger(newList#0);
    assume (0 < foldK#_645) && ((1000 * foldK#_645) < Fractions(1)) && ((1000 * foldK#_645) < methodK#_170);
    assert {:msg "  89.13: The target of the fold statement might be null."} newList#0 != null;
    // begin exhale (fold)
    exhaleMask#_647 := Mask;
    havoc exhaleHeap#_646;
    if (!(Heap[newList#0, Node.prev] == null)) {
      assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. The expression at 18.41 might not evaluate to true."} MuBelow(Heap[Heap[newList#0, Node.prev], mu], Heap[newList#0, mu]);
    }
    if (!(Heap[newList#0, Node.next] == null)) {
      assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. The expression at 19.42 might not evaluate to true."} MuBelow(Heap[newList#0, mu], Heap[Heap[newList#0, Node.next], mu]);
    }
    assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. The permission at 17.9 might not be positive."} 1 > 0;
    assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. Insufficient epsilons at 17.9  for Node.prev."} (exhaleMask#_647[newList#0, Node.prev][perm$R] == 0) ==> (1 <= exhaleMask#_647[newList#0, Node.prev][perm$N]);
    exhaleMask#_647[newList#0, Node.prev] := exhaleMask#_647[newList#0, Node.prev][perm$N := exhaleMask#_647[newList#0, Node.prev][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    assume 1 > 0;
    SecMask[newList#0, Node.prev] := SecMask[newList#0, Node.prev][perm$N := SecMask[newList#0, Node.prev][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(exhaleMask#_647);
    assume wf(Heap, exhaleMask#_647, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. The permission at 17.29 might not be positive."} 1 > 0;
    assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. Insufficient epsilons at 17.29  for Node.next."} (exhaleMask#_647[newList#0, Node.next][perm$R] == 0) ==> (1 <= exhaleMask#_647[newList#0, Node.next][perm$N]);
    exhaleMask#_647[newList#0, Node.next] := exhaleMask#_647[newList#0, Node.next][perm$N := exhaleMask#_647[newList#0, Node.next][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    assume 1 > 0;
    SecMask[newList#0, Node.next] := SecMask[newList#0, Node.next][perm$N := SecMask[newList#0, Node.next][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(exhaleMask#_647);
    assume wf(Heap, exhaleMask#_647, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. The permission at 17.49 might not be positive."} 1 > 0;
    assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. Insufficient epsilons at 17.49  for mu."} (exhaleMask#_647[newList#0, mu][perm$R] == 0) ==> (1 <= exhaleMask#_647[newList#0, mu][perm$N]);
    exhaleMask#_647[newList#0, mu] := exhaleMask#_647[newList#0, mu][perm$N := exhaleMask#_647[newList#0, mu][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    assume 1 > 0;
    SecMask[newList#0, mu] := SecMask[newList#0, mu][perm$N := SecMask[newList#0, mu][perm$N] + 1];
    assume wf(Heap, SecMask, SecMask);
    assume IsGoodMask(exhaleMask#_647);
    assume wf(Heap, exhaleMask#_647, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[newList#0, Node.prev] == null)) {
      assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. The permission at 18.25 might not be positive."} Fractions(100) > 0;
      assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. Insufficient fraction at 18.25 for Node.invLeft."} (Fractions(100) <= exhaleMask#_647[Heap[newList#0, Node.prev], Node.invLeft][perm$R]) && ((Fractions(100) == exhaleMask#_647[Heap[newList#0, Node.prev], Node.invLeft][perm$R]) ==> (0 <= exhaleMask#_647[Heap[newList#0, Node.prev], Node.invLeft][perm$N]));
      exhaleMask#_647[Heap[newList#0, Node.prev], Node.invLeft] := exhaleMask#_647[Heap[newList#0, Node.prev], Node.invLeft][perm$R := exhaleMask#_647[Heap[newList#0, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      assume Fractions(100) > 0;
      SecMask[Heap[newList#0, Node.prev], Node.invLeft] := SecMask[Heap[newList#0, Node.prev], Node.invLeft][perm$R := SecMask[Heap[newList#0, Node.prev], Node.invLeft][perm$R] + Fractions(100)];
      if (!CanRead(exhaleMask#_647, SecMask, Heap[newList#0, Node.prev], Node.invLeft)) {
        assume Heap[Heap[newList#0, Node.prev], Node.invLeft] < exhaleHeap#_646[Heap[newList#0, Node.prev], Node.invLeft];
      }
      assume IsGoodMask(exhaleMask#_647);
      assume wf(Heap, exhaleMask#_647, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[newList#0, Node.next] == null)) {
      assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. The permission at 19.25 might not be positive."} Fractions(100) > 0;
      assert {:msg "  89.13: Fold might fail because the definition of Node.inv does not hold. Insufficient fraction at 19.25 for Node.invRight."} (Fractions(100) <= exhaleMask#_647[Heap[newList#0, Node.next], Node.invRight][perm$R]) && ((Fractions(100) == exhaleMask#_647[Heap[newList#0, Node.next], Node.invRight][perm$R]) ==> (0 <= exhaleMask#_647[Heap[newList#0, Node.next], Node.invRight][perm$N]));
      exhaleMask#_647[Heap[newList#0, Node.next], Node.invRight] := exhaleMask#_647[Heap[newList#0, Node.next], Node.invRight][perm$R := exhaleMask#_647[Heap[newList#0, Node.next], Node.invRight][perm$R] - Fractions(100)];
      assume Fractions(100) > 0;
      SecMask[Heap[newList#0, Node.next], Node.invRight] := SecMask[Heap[newList#0, Node.next], Node.invRight][perm$R := SecMask[Heap[newList#0, Node.next], Node.invRight][perm$R] + Fractions(100)];
      if (!CanRead(exhaleMask#_647, SecMask, Heap[newList#0, Node.next], Node.invRight)) {
        assume Heap[Heap[newList#0, Node.next], Node.invRight] < exhaleHeap#_646[Heap[newList#0, Node.next], Node.invRight];
      }
      assume IsGoodMask(exhaleMask#_647);
      assume wf(Heap, exhaleMask#_647, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    Mask := exhaleMask#_647;
    assume IsGoodExhaleState(exhaleHeap#_646, Heap, Mask, SecMask);
    Heap := exhaleHeap#_646;
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end exhale
    // inhale (fold)
    assume newList#0 != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[newList#0, Node.inv] := Mask[newList#0, Node.inv][perm$R := Mask[newList#0, Node.inv][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[newList#0, Node.inv]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end inhale
    predRec#_642 := newList#0;
    predVer#_643 := Heap[newList#0, Node.inv];
    predFlag#_644 := true;
    assume wf(Heap, Mask, SecMask);
    // Line #89:             fold newList.inv  
    assert {:msg "  89.13: SMOKE-TEST-48. (The statements after the fold statement are unreachable.)"}{:subsumption 0} !(1 == 1);
  }
  // Line #30:     method delete() returns (newList:Node)  
  assert {:msg "  30.5: SMOKE-TEST-49. (The end of method delete is unreachable.)"}{:subsumption 0} !(1 == 1);
  // begin exhale (postcondition)
  exhaleMask#_654 := Mask;
  havoc exhaleHeap#_653;
  assert {:msg "  30.5: The postcondition at 42.17 might not hold. The expression at 42.17 might not evaluate to true."} old(Heap)[this, Node.next] == newList#0;
  assert {:msg "  30.5: The postcondition at 40.17 might not hold. The permission at 40.17 might not be positive."} Fractions(100) > 0;
  assert {:msg "  30.5: The postcondition at 40.17 might not hold. Insufficient fraction at 40.17 for Node.inv."} (Fractions(100) <= exhaleMask#_654[this, Node.inv][perm$R]) && ((Fractions(100) == exhaleMask#_654[this, Node.inv][perm$R]) ==> (0 <= exhaleMask#_654[this, Node.inv][perm$N]));
  exhaleMask#_654[this, Node.inv] := exhaleMask#_654[this, Node.inv][perm$R := exhaleMask#_654[this, Node.inv][perm$R] - Fractions(100)];
  if (((false || ((predVer#_643 == Heap[this, Node.inv]) && (predRec#_642 == this) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_644)) || ((predVer#_598 == Heap[this, Node.inv]) && (predRec#_597 == this) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_476 && cond#_430 && cond#_452 && predFlag#_599)) || ((predVer#_321 == Heap[this, Node.inv]) && (predRec#_320 == this) && true && predFlag#_322)) {
    if ((predVer#_321 == Heap[this, Node.inv]) && (predRec#_320 == this) && true && predFlag#_322) {
    } else {
      if ((predVer#_598 == Heap[this, Node.inv]) && (predRec#_597 == this) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_476 && cond#_430 && cond#_452 && predFlag#_599) {
      } else {
      }
    }
    // begin exhale (update SecMask)
    if (!(Heap[this, Node.prev] == null)) {
      //  assert <undefined position>:  The expression at 18.41 might not evaluate to true.
      assume MuBelow(Heap[Heap[this, Node.prev], mu], Heap[this, mu]);
    }
    if (!(Heap[this, Node.next] == null)) {
      //  assert <undefined position>:  The expression at 19.42 might not evaluate to true.
      assume MuBelow(Heap[this, mu], Heap[Heap[this, Node.next], mu]);
    }
    SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := SecMask[this, Node.prev][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.prev][perm$N] < 0) {
      SecMask[this, Node.prev] := SecMask[this, Node.prev][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := SecMask[this, Node.next][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, Node.next][perm$N] < 0) {
      SecMask[this, Node.next] := SecMask[this, Node.next][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, mu] := SecMask[this, mu][perm$N := SecMask[this, mu][perm$N] - 1];
    assume wf(Heap, Mask, SecMask);
    if (SecMask[this, mu][perm$N] < 0) {
      SecMask[this, mu] := SecMask[this, mu][perm$N := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[this, Node.prev] == null)) {
      SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.prev], Node.invLeft][perm$R] < 0) {
        SecMask[Heap[this, Node.prev], Node.invLeft] := SecMask[Heap[this, Node.prev], Node.invLeft][perm$R := 0];
      }
      if (((((false || ((predVer#_633 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_632 == Heap[this, Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_622 == Heap[this, Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_399 == Heap[this, Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_377 == Heap[this, Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_346 == Heap[this, Node.prev]) && true && predFlag#_348)) {
        if ((predVer#_347 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_346 == Heap[this, Node.prev]) && true && predFlag#_348) {
        } else {
          if ((predVer#_378 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_377 == Heap[this, Node.prev]) && true && cond#_364 && predFlag#_379) {
          } else {
            if ((predVer#_400 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_399 == Heap[this, Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
            } else {
              if ((predVer#_623 == Heap[Heap[this, Node.prev], Node.invLeft]) && (predRec#_622 == Heap[this, Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
              } else {
              }
            }
          }
        }
        // begin exhale (update SecMask)
        if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
          assume MuBelow(Heap[Heap[Heap[this, Node.prev], Node.prev], mu], Heap[Heap[this, Node.prev], mu]);
        }
        SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := SecMask[Heap[this, Node.prev], Node.prev][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[this, Node.prev], Node.prev][perm$N] < 0) {
          SecMask[Heap[this, Node.prev], Node.prev] := SecMask[Heap[this, Node.prev], Node.prev][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := SecMask[Heap[this, Node.prev], Node.next][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[this, Node.prev], Node.next][perm$N] < 0) {
          SecMask[Heap[this, Node.prev], Node.next] := SecMask[Heap[this, Node.prev], Node.next][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := SecMask[Heap[this, Node.prev], mu][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[this, Node.prev], mu][perm$N] < 0) {
          SecMask[Heap[this, Node.prev], mu] := SecMask[Heap[this, Node.prev], mu][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[Heap[this, Node.prev], Node.prev] == null)) {
          SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
          if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
            SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
          }
          assume Heap[Heap[this, Node.prev], Node.prev] != Heap[this, Node.prev];
          if (((((false || ((predVer#_633 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[this, Node.prev], Node.prev]) && true && predFlag#_348)) {
            if ((predVer#_347 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[this, Node.prev], Node.prev]) && true && predFlag#_348) {
            } else {
              if ((predVer#_378 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
              } else {
                if ((predVer#_400 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                } else {
                  if ((predVer#_623 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[this, Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                  } else {
                  }
                }
              }
            }
            // begin exhale (update SecMask)
            if (!(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
              //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
              assume MuBelow(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[this, Node.prev], Node.prev], mu]);
            }
            SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] - 1];
            assume wf(Heap, Mask, SecMask);
            if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
              SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.prev][perm$N := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
            SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] - 1];
            assume wf(Heap, Mask, SecMask);
            if (SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N] < 0) {
              SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[this, Node.prev], Node.prev], Node.next][perm$N := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
            SecMask[Heap[Heap[this, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] - 1];
            assume wf(Heap, Mask, SecMask);
            if (SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N] < 0) {
              SecMask[Heap[Heap[this, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[this, Node.prev], Node.prev], mu][perm$N := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
            if (!(Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] == null)) {
              SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
              if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
              }
              assume Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
              assume Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
              if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                if ((predVer#_347 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                } else {
                  if ((predVer#_378 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                  } else {
                    if ((predVer#_400 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                    } else {
                      if ((predVer#_623 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                      } else {
                      }
                    }
                  }
                }
                // begin exhale (update SecMask)
                if (!(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                  //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                  assume MuBelow(Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu]);
                }
                SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                assume wf(Heap, Mask, SecMask);
                if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                  SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
                SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                assume wf(Heap, Mask, SecMask);
                if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                  SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
                SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                assume wf(Heap, Mask, SecMask);
                if (SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                  SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
                if (!(Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                  SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                  if (SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                    SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                  }
                  assume Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                  assume Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                  assume Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                  if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                    if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                    } else {
                      if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                      } else {
                        if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                        } else {
                          if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                          } else {
                          }
                        }
                      }
                    }
                    // begin exhale (update SecMask)
                    if (!(Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                      //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                      assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                    }
                    SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                    assume wf(Heap, Mask, SecMask);
                    if (SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                    SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                    assume wf(Heap, Mask, SecMask);
                    if (SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                    SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                    assume wf(Heap, Mask, SecMask);
                    if (SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                    if (!(Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                      SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                      if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                      }
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev];
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                      if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                        if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                        } else {
                          if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                          } else {
                            if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                            } else {
                              if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                              } else {
                              }
                            }
                          }
                        }
                        // begin exhale (update SecMask)
                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                          assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                        }
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                        assume wf(Heap, Mask, SecMask);
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                        assume wf(Heap, Mask, SecMask);
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                        assume wf(Heap, Mask, SecMask);
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                          }
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                          if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                            if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                            } else {
                              if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                              } else {
                                if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                } else {
                                  if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                  } else {
                                  }
                                }
                              }
                            }
                            // begin exhale (update SecMask)
                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                              //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                              assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                            }
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                            assume wf(Heap, Mask, SecMask);
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                            assume wf(Heap, Mask, SecMask);
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                            assume wf(Heap, Mask, SecMask);
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                              }
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                              if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                } else {
                                  if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                  } else {
                                    if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                    } else {
                                      if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                      } else {
                                      }
                                    }
                                  }
                                }
                                // begin exhale (update SecMask)
                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                  //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                  assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                }
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                assume wf(Heap, Mask, SecMask);
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                assume wf(Heap, Mask, SecMask);
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                assume wf(Heap, Mask, SecMask);
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                  }
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                                  if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                    if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                    } else {
                                      if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                      } else {
                                        if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                        } else {
                                          if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                          } else {
                                          }
                                        }
                                      }
                                    }
                                    // begin exhale (update SecMask)
                                    if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                      //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                      assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                    }
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                    assume wf(Heap, Mask, SecMask);
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                    assume wf(Heap, Mask, SecMask);
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                    assume wf(Heap, Mask, SecMask);
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                    if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                      }
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                                      if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                        if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                        } else {
                                          if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                          } else {
                                            if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                            } else {
                                              if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                              } else {
                                              }
                                            }
                                          }
                                        }
                                        // begin exhale (update SecMask)
                                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                          //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                          assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                        }
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                        assume wf(Heap, Mask, SecMask);
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                        assume wf(Heap, Mask, SecMask);
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                        assume wf(Heap, Mask, SecMask);
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                          }
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                                          if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                            if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                            } else {
                                              if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                              } else {
                                                if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                                } else {
                                                  if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                                  } else {
                                                  }
                                                }
                                              }
                                            }
                                            // begin exhale (update SecMask)
                                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                              //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                              assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                            }
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                            assume wf(Heap, Mask, SecMask);
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                            assume wf(Heap, Mask, SecMask);
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                            assume wf(Heap, Mask, SecMask);
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                              }
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[this, Node.prev], Node.prev];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[this, Node.prev];
                                              if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                                if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                                } else {
                                                  if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                                  } else {
                                                    if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                                    } else {
                                                      if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                                      } else {
                                                      }
                                                    }
                                                  }
                                                }
                                                // begin exhale (update SecMask)
                                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                                  //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                                  assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                                }
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                                assume wf(Heap, Mask, SecMask);
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                                assume wf(Heap, Mask, SecMask);
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                                assume wf(Heap, Mask, SecMask);
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                // end exhale
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            // end exhale
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        // end exhale
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    // end exhale
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                }
                                assume wf(Heap, SecMask, SecMask);
                                // end exhale
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                            }
                            assume wf(Heap, SecMask, SecMask);
                            // end exhale
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                        }
                        assume wf(Heap, SecMask, SecMask);
                        // end exhale
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                    }
                    assume wf(Heap, SecMask, SecMask);
                    // end exhale
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                }
                assume wf(Heap, SecMask, SecMask);
                // end exhale
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
            }
            assume wf(Heap, SecMask, SecMask);
            // end exhale
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume wf(Heap, SecMask, SecMask);
        // end exhale
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, Node.next] == null)) {
      SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := SecMask[Heap[this, Node.next], Node.invRight][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, Node.next], Node.invRight][perm$R] < 0) {
        SecMask[Heap[this, Node.next], Node.invRight] := SecMask[Heap[this, Node.next], Node.invRight][perm$R := 0];
      }
      if ((((false || ((predVer#_611 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_610 == Heap[this, Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_443 == Heap[this, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_421 == Heap[this, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_355 == Heap[this, Node.next]) && true && predFlag#_357)) {
        if ((predVer#_356 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_355 == Heap[this, Node.next]) && true && predFlag#_357) {
        } else {
          if ((predVer#_422 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_421 == Heap[this, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
          } else {
            if ((predVer#_444 == Heap[Heap[this, Node.next], Node.invRight]) && (predRec#_443 == Heap[this, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
            } else {
            }
          }
        }
        // begin exhale (update SecMask)
        if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
          //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
          assume MuBelow(Heap[Heap[this, Node.next], mu], Heap[Heap[Heap[this, Node.next], Node.next], mu]);
        }
        SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := SecMask[Heap[this, Node.next], Node.prev][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[this, Node.next], Node.prev][perm$N] < 0) {
          SecMask[Heap[this, Node.next], Node.prev] := SecMask[Heap[this, Node.next], Node.prev][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := SecMask[Heap[this, Node.next], Node.next][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[this, Node.next], Node.next][perm$N] < 0) {
          SecMask[Heap[this, Node.next], Node.next] := SecMask[Heap[this, Node.next], Node.next][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := SecMask[Heap[this, Node.next], mu][perm$N] - 1];
        assume wf(Heap, Mask, SecMask);
        if (SecMask[Heap[this, Node.next], mu][perm$N] < 0) {
          SecMask[Heap[this, Node.next], mu] := SecMask[Heap[this, Node.next], mu][perm$N := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[Heap[this, Node.next], Node.next] == null)) {
          SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
          if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R] < 0) {
            SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.invRight][perm$R := 0];
          }
          assume Heap[Heap[this, Node.next], Node.next] != Heap[this, Node.next];
          if ((((false || ((predVer#_611 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[this, Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[this, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[this, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[this, Node.next], Node.next]) && true && predFlag#_357)) {
            if ((predVer#_356 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[this, Node.next], Node.next]) && true && predFlag#_357) {
            } else {
              if ((predVer#_422 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[this, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
              } else {
                if ((predVer#_444 == Heap[Heap[Heap[this, Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[this, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                } else {
                }
              }
            }
            // begin exhale (update SecMask)
            if (!(Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
              //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
              assume MuBelow(Heap[Heap[Heap[this, Node.next], Node.next], mu], Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu]);
            }
            SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] - 1];
            assume wf(Heap, Mask, SecMask);
            if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N] < 0) {
              SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.prev][perm$N := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
            SecMask[Heap[Heap[this, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] - 1];
            assume wf(Heap, Mask, SecMask);
            if (SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N] < 0) {
              SecMask[Heap[Heap[this, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[this, Node.next], Node.next], Node.next][perm$N := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
            SecMask[Heap[Heap[this, Node.next], Node.next], mu] := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N] - 1];
            assume wf(Heap, Mask, SecMask);
            if (SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N] < 0) {
              SecMask[Heap[Heap[this, Node.next], Node.next], mu] := SecMask[Heap[Heap[this, Node.next], Node.next], mu][perm$N := 0];
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
            if (!(Heap[Heap[Heap[this, Node.next], Node.next], Node.next] == null)) {
              SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
              if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
              }
              assume Heap[Heap[Heap[this, Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
              assume Heap[Heap[Heap[this, Node.next], Node.next], Node.next] != Heap[this, Node.next];
              if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                if ((predVer#_356 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                } else {
                  if ((predVer#_422 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                  } else {
                    if ((predVer#_444 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[this, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                    } else {
                    }
                  }
                }
                // begin exhale (update SecMask)
                if (!(Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] == null)) {
                  //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                  assume MuBelow(Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu]);
                }
                SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                assume wf(Heap, Mask, SecMask);
                if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                  SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
                SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                assume wf(Heap, Mask, SecMask);
                if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                  SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
                SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N] - 1];
                assume wf(Heap, Mask, SecMask);
                if (SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                  SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], mu][perm$N := 0];
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
                if (!(Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] == null)) {
                  SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                  if (SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                    SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                  }
                  assume Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                  assume Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                  assume Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                  if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                    if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                    } else {
                      if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                      } else {
                        if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                        } else {
                        }
                      }
                    }
                    // begin exhale (update SecMask)
                    if (!(Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                      //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                      assume MuBelow(Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                    }
                    SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                    assume wf(Heap, Mask, SecMask);
                    if (SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                    SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                    assume wf(Heap, Mask, SecMask);
                    if (SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                    SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                    assume wf(Heap, Mask, SecMask);
                    if (SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                    if (!(Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                      SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                      if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                      }
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next];
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                      assume Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                      if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                        if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                        } else {
                          if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                          } else {
                            if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                            } else {
                            }
                          }
                        }
                        // begin exhale (update SecMask)
                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                          //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                          assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                        }
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                        assume wf(Heap, Mask, SecMask);
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                        assume wf(Heap, Mask, SecMask);
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                        SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                        assume wf(Heap, Mask, SecMask);
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                          }
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                          assume Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                          if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                            if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                            } else {
                              if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                              } else {
                                if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                } else {
                                }
                              }
                            }
                            // begin exhale (update SecMask)
                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                              //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                              assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                            }
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                            assume wf(Heap, Mask, SecMask);
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                            assume wf(Heap, Mask, SecMask);
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                            assume wf(Heap, Mask, SecMask);
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                              }
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                              if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                } else {
                                  if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                  } else {
                                    if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                    } else {
                                    }
                                  }
                                }
                                // begin exhale (update SecMask)
                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                  //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                  assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                }
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                assume wf(Heap, Mask, SecMask);
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                assume wf(Heap, Mask, SecMask);
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                assume wf(Heap, Mask, SecMask);
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                  }
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                                  assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                                  if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                    if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                    } else {
                                      if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                      } else {
                                        if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                        } else {
                                        }
                                      }
                                    }
                                    // begin exhale (update SecMask)
                                    if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                      //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                      assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                    }
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                    assume wf(Heap, Mask, SecMask);
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                    assume wf(Heap, Mask, SecMask);
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                    assume wf(Heap, Mask, SecMask);
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                    if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                      }
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                                      assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                                      if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                        if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                        } else {
                                          if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                          } else {
                                            if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                            } else {
                                            }
                                          }
                                        }
                                        // begin exhale (update SecMask)
                                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                          //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                          assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                        }
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                        assume wf(Heap, Mask, SecMask);
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                        assume wf(Heap, Mask, SecMask);
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                        assume wf(Heap, Mask, SecMask);
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                        if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                          }
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                                          assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                                          if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                            if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                            } else {
                                              if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                              } else {
                                                if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                                } else {
                                                }
                                              }
                                            }
                                            // begin exhale (update SecMask)
                                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                              //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                              assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                            }
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                            assume wf(Heap, Mask, SecMask);
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                            assume wf(Heap, Mask, SecMask);
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                            assume wf(Heap, Mask, SecMask);
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                            if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                              }
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[this, Node.next], Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[this, Node.next], Node.next];
                                              assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[this, Node.next];
                                              if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                                if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                                } else {
                                                  if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                                  } else {
                                                    if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                                    } else {
                                                    }
                                                  }
                                                }
                                                // begin exhale (update SecMask)
                                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                                  //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                                  assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                                }
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                                assume wf(Heap, Mask, SecMask);
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                                assume wf(Heap, Mask, SecMask);
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                                assume wf(Heap, Mask, SecMask);
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                                if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[this, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                // end exhale
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            // end exhale
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        // end exhale
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    // end exhale
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                }
                                assume wf(Heap, SecMask, SecMask);
                                // end exhale
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                            }
                            assume wf(Heap, SecMask, SecMask);
                            // end exhale
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                        }
                        assume wf(Heap, SecMask, SecMask);
                        // end exhale
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                    }
                    assume wf(Heap, SecMask, SecMask);
                    // end exhale
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                }
                assume wf(Heap, SecMask, SecMask);
                // end exhale
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
            }
            assume wf(Heap, SecMask, SecMask);
            // end exhale
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume wf(Heap, SecMask, SecMask);
        // end exhale
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(exhaleMask#_654, SecMask, this, Node.inv)) {
    assume Heap[this, Node.inv] < exhaleHeap#_653[this, Node.inv];
  }
  assume IsGoodMask(exhaleMask#_654);
  assume wf(Heap, exhaleMask#_654, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(newList#0 == null)) {
    assert {:msg "  30.5: The postcondition at 41.18 might not hold. The permission at 41.36 might not be positive."} Fractions(100) > 0;
    assert {:msg "  30.5: The postcondition at 41.18 might not hold. Insufficient fraction at 41.36 for Node.inv."} (Fractions(100) <= exhaleMask#_654[newList#0, Node.inv][perm$R]) && ((Fractions(100) == exhaleMask#_654[newList#0, Node.inv][perm$R]) ==> (0 <= exhaleMask#_654[newList#0, Node.inv][perm$N]));
    exhaleMask#_654[newList#0, Node.inv] := exhaleMask#_654[newList#0, Node.inv][perm$R := exhaleMask#_654[newList#0, Node.inv][perm$R] - Fractions(100)];
    if (((false || ((predVer#_643 == Heap[newList#0, Node.inv]) && (predRec#_642 == newList#0) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_644)) || ((predVer#_598 == Heap[newList#0, Node.inv]) && (predRec#_597 == newList#0) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_476 && cond#_430 && cond#_452 && predFlag#_599)) || ((predVer#_321 == Heap[newList#0, Node.inv]) && (predRec#_320 == newList#0) && true && predFlag#_322)) {
      if ((predVer#_321 == Heap[newList#0, Node.inv]) && (predRec#_320 == newList#0) && true && predFlag#_322) {
      } else {
        if ((predVer#_598 == Heap[newList#0, Node.inv]) && (predRec#_597 == newList#0) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_476 && cond#_430 && cond#_452 && predFlag#_599) {
        } else {
        }
      }
      // begin exhale (update SecMask)
      if (!(Heap[newList#0, Node.prev] == null)) {
        //  assert <undefined position>:  The expression at 18.41 might not evaluate to true.
        assume MuBelow(Heap[Heap[newList#0, Node.prev], mu], Heap[newList#0, mu]);
      }
      if (!(Heap[newList#0, Node.next] == null)) {
        //  assert <undefined position>:  The expression at 19.42 might not evaluate to true.
        assume MuBelow(Heap[newList#0, mu], Heap[Heap[newList#0, Node.next], mu]);
      }
      SecMask[newList#0, Node.prev] := SecMask[newList#0, Node.prev][perm$N := SecMask[newList#0, Node.prev][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[newList#0, Node.prev][perm$N] < 0) {
        SecMask[newList#0, Node.prev] := SecMask[newList#0, Node.prev][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[newList#0, Node.next] := SecMask[newList#0, Node.next][perm$N := SecMask[newList#0, Node.next][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[newList#0, Node.next][perm$N] < 0) {
        SecMask[newList#0, Node.next] := SecMask[newList#0, Node.next][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[newList#0, mu] := SecMask[newList#0, mu][perm$N := SecMask[newList#0, mu][perm$N] - 1];
      assume wf(Heap, Mask, SecMask);
      if (SecMask[newList#0, mu][perm$N] < 0) {
        SecMask[newList#0, mu] := SecMask[newList#0, mu][perm$N := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[newList#0, Node.prev] == null)) {
        SecMask[Heap[newList#0, Node.prev], Node.invLeft] := SecMask[Heap[newList#0, Node.prev], Node.invLeft][perm$R := SecMask[Heap[newList#0, Node.prev], Node.invLeft][perm$R] - Fractions(100)];
        if (SecMask[Heap[newList#0, Node.prev], Node.invLeft][perm$R] < 0) {
          SecMask[Heap[newList#0, Node.prev], Node.invLeft] := SecMask[Heap[newList#0, Node.prev], Node.invLeft][perm$R := 0];
        }
        if (((((false || ((predVer#_633 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_632 == Heap[newList#0, Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_622 == Heap[newList#0, Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_399 == Heap[newList#0, Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_377 == Heap[newList#0, Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_346 == Heap[newList#0, Node.prev]) && true && predFlag#_348)) {
          if ((predVer#_347 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_346 == Heap[newList#0, Node.prev]) && true && predFlag#_348) {
          } else {
            if ((predVer#_378 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_377 == Heap[newList#0, Node.prev]) && true && cond#_364 && predFlag#_379) {
            } else {
              if ((predVer#_400 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_399 == Heap[newList#0, Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
              } else {
                if ((predVer#_623 == Heap[Heap[newList#0, Node.prev], Node.invLeft]) && (predRec#_622 == Heap[newList#0, Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                } else {
                }
              }
            }
          }
          // begin exhale (update SecMask)
          if (!(Heap[Heap[newList#0, Node.prev], Node.prev] == null)) {
            //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
            assume MuBelow(Heap[Heap[Heap[newList#0, Node.prev], Node.prev], mu], Heap[Heap[newList#0, Node.prev], mu]);
          }
          SecMask[Heap[newList#0, Node.prev], Node.prev] := SecMask[Heap[newList#0, Node.prev], Node.prev][perm$N := SecMask[Heap[newList#0, Node.prev], Node.prev][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[newList#0, Node.prev], Node.prev][perm$N] < 0) {
            SecMask[Heap[newList#0, Node.prev], Node.prev] := SecMask[Heap[newList#0, Node.prev], Node.prev][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[newList#0, Node.prev], Node.next] := SecMask[Heap[newList#0, Node.prev], Node.next][perm$N := SecMask[Heap[newList#0, Node.prev], Node.next][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[newList#0, Node.prev], Node.next][perm$N] < 0) {
            SecMask[Heap[newList#0, Node.prev], Node.next] := SecMask[Heap[newList#0, Node.prev], Node.next][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[newList#0, Node.prev], mu] := SecMask[Heap[newList#0, Node.prev], mu][perm$N := SecMask[Heap[newList#0, Node.prev], mu][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[newList#0, Node.prev], mu][perm$N] < 0) {
            SecMask[Heap[newList#0, Node.prev], mu] := SecMask[Heap[newList#0, Node.prev], mu][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[Heap[newList#0, Node.prev], Node.prev] == null)) {
            SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
            if (SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
              SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft][perm$R := 0];
            }
            assume Heap[Heap[newList#0, Node.prev], Node.prev] != Heap[newList#0, Node.prev];
            if (((((false || ((predVer#_633 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && predFlag#_348)) {
              if ((predVer#_347 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && predFlag#_348) {
              } else {
                if ((predVer#_378 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                } else {
                  if ((predVer#_400 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                  } else {
                    if ((predVer#_623 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[newList#0, Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                    } else {
                    }
                  }
                }
              }
              // begin exhale (update SecMask)
              if (!(Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] == null)) {
                //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                assume MuBelow(Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[newList#0, Node.prev], Node.prev], mu]);
              }
              SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N] - 1];
              assume wf(Heap, Mask, SecMask);
              if (SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev][perm$N := 0];
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
              SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N] - 1];
              assume wf(Heap, Mask, SecMask);
              if (SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N] < 0) {
                SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], Node.next][perm$N := 0];
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
              SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N] - 1];
              assume wf(Heap, Mask, SecMask);
              if (SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N] < 0) {
                SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu] := SecMask[Heap[Heap[newList#0, Node.prev], Node.prev], mu][perm$N := 0];
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
              if (!(Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] == null)) {
                SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                if (SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                  SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                }
                assume Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                assume Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                  if ((predVer#_347 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                  } else {
                    if ((predVer#_378 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                    } else {
                      if ((predVer#_400 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                      } else {
                        if ((predVer#_623 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                        } else {
                        }
                      }
                    }
                  }
                  // begin exhale (update SecMask)
                  if (!(Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                    //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                    assume MuBelow(Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu]);
                  }
                  SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                  assume wf(Heap, Mask, SecMask);
                  if (SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                    SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                  SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                  assume wf(Heap, Mask, SecMask);
                  if (SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                    SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                  SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                  assume wf(Heap, Mask, SecMask);
                  if (SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                    SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                  if (!(Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                    SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                    if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                    }
                    assume Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                    assume Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                    assume Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                    if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                      if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                      } else {
                        if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                        } else {
                          if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                          } else {
                            if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                            } else {
                            }
                          }
                        }
                      }
                      // begin exhale (update SecMask)
                      if (!(Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                        assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                      }
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                      assume wf(Heap, Mask, SecMask);
                      if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                      assume wf(Heap, Mask, SecMask);
                      if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                      assume wf(Heap, Mask, SecMask);
                      if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                      if (!(Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                        SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                        }
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev];
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                        if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                          if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                          } else {
                            if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                            } else {
                              if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                              } else {
                                if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                } else {
                                }
                              }
                            }
                          }
                          // begin exhale (update SecMask)
                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                            //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                            assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                          }
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                          assume wf(Heap, Mask, SecMask);
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                          assume wf(Heap, Mask, SecMask);
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                          assume wf(Heap, Mask, SecMask);
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                            }
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                            if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                              if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                              } else {
                                if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                } else {
                                  if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                  } else {
                                    if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                    } else {
                                    }
                                  }
                                }
                              }
                              // begin exhale (update SecMask)
                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                              }
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                              assume wf(Heap, Mask, SecMask);
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                              assume wf(Heap, Mask, SecMask);
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                              assume wf(Heap, Mask, SecMask);
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                }
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                                if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                  if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                  } else {
                                    if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                    } else {
                                      if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                      } else {
                                        if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                        } else {
                                        }
                                      }
                                    }
                                  }
                                  // begin exhale (update SecMask)
                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                    //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                    assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                  }
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                  assume wf(Heap, Mask, SecMask);
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                  assume wf(Heap, Mask, SecMask);
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                  assume wf(Heap, Mask, SecMask);
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                    }
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                                    if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                      if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                      } else {
                                        if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                        } else {
                                          if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                          } else {
                                            if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                            } else {
                                            }
                                          }
                                        }
                                      }
                                      // begin exhale (update SecMask)
                                      if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                        //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                        assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                      }
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                      assume wf(Heap, Mask, SecMask);
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                      assume wf(Heap, Mask, SecMask);
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                      assume wf(Heap, Mask, SecMask);
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                      if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                        }
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                                        if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                          if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                          } else {
                                            if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                            } else {
                                              if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                              } else {
                                                if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                                } else {
                                                }
                                              }
                                            }
                                          }
                                          // begin exhale (update SecMask)
                                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                            //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                            assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                          }
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                          assume wf(Heap, Mask, SecMask);
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                          assume wf(Heap, Mask, SecMask);
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                          assume wf(Heap, Mask, SecMask);
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                            }
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                                            if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                              if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                              } else {
                                                if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                                } else {
                                                  if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                                  } else {
                                                    if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                                    } else {
                                                    }
                                                  }
                                                }
                                              }
                                              // begin exhale (update SecMask)
                                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                                //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                                assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                              }
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                              assume wf(Heap, Mask, SecMask);
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                              assume wf(Heap, Mask, SecMask);
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                              assume wf(Heap, Mask, SecMask);
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                                }
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[Heap[newList#0, Node.prev], Node.prev];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] != Heap[newList#0, Node.prev];
                                                if (((((false || ((predVer#_633 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_632 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_634)) || ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624)) || ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401)) || ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379)) || ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348)) {
                                                  if ((predVer#_347 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_346 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && predFlag#_348) {
                                                  } else {
                                                    if ((predVer#_378 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_377 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && predFlag#_379) {
                                                    } else {
                                                      if ((predVer#_400 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_399 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_386 && predFlag#_401) {
                                                      } else {
                                                        if ((predVer#_623 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft]) && (predRec#_622 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_620 && cond#_573 && cond#_501 && cond#_621 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_624) {
                                                        } else {
                                                        }
                                                      }
                                                    }
                                                  }
                                                  // begin exhale (update SecMask)
                                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                                    //  assert <undefined position>:  The expression at 23.41 might not evaluate to true.
                                                    assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu]);
                                                  }
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] - 1];
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev][perm$N := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] - 1];
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.next][perm$N := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] - 1];
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], mu][perm$N := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev] == null)) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] - Fractions(100)];
                                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R] < 0) {
                                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.prev], Node.invLeft][perm$R := 0];
                                                    }
                                                    assume wf(Heap, SecMask, SecMask);
                                                    assume wf(Heap, Mask, SecMask);
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  // end exhale
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              // end exhale
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          // end exhale
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      // end exhale
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  // end exhale
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                              }
                              assume wf(Heap, SecMask, SecMask);
                              // end exhale
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                          }
                          assume wf(Heap, SecMask, SecMask);
                          // end exhale
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                      }
                      assume wf(Heap, SecMask, SecMask);
                      // end exhale
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                  }
                  assume wf(Heap, SecMask, SecMask);
                  // end exhale
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
              }
              assume wf(Heap, SecMask, SecMask);
              // end exhale
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          assume wf(Heap, SecMask, SecMask);
          // end exhale
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[newList#0, Node.next] == null)) {
        SecMask[Heap[newList#0, Node.next], Node.invRight] := SecMask[Heap[newList#0, Node.next], Node.invRight][perm$R := SecMask[Heap[newList#0, Node.next], Node.invRight][perm$R] - Fractions(100)];
        if (SecMask[Heap[newList#0, Node.next], Node.invRight][perm$R] < 0) {
          SecMask[Heap[newList#0, Node.next], Node.invRight] := SecMask[Heap[newList#0, Node.next], Node.invRight][perm$R := 0];
        }
        if ((((false || ((predVer#_611 == Heap[Heap[newList#0, Node.next], Node.invRight]) && (predRec#_610 == Heap[newList#0, Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[newList#0, Node.next], Node.invRight]) && (predRec#_443 == Heap[newList#0, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[newList#0, Node.next], Node.invRight]) && (predRec#_421 == Heap[newList#0, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[newList#0, Node.next], Node.invRight]) && (predRec#_355 == Heap[newList#0, Node.next]) && true && predFlag#_357)) {
          if ((predVer#_356 == Heap[Heap[newList#0, Node.next], Node.invRight]) && (predRec#_355 == Heap[newList#0, Node.next]) && true && predFlag#_357) {
          } else {
            if ((predVer#_422 == Heap[Heap[newList#0, Node.next], Node.invRight]) && (predRec#_421 == Heap[newList#0, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
            } else {
              if ((predVer#_444 == Heap[Heap[newList#0, Node.next], Node.invRight]) && (predRec#_443 == Heap[newList#0, Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
              } else {
              }
            }
          }
          // begin exhale (update SecMask)
          if (!(Heap[Heap[newList#0, Node.next], Node.next] == null)) {
            //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
            assume MuBelow(Heap[Heap[newList#0, Node.next], mu], Heap[Heap[Heap[newList#0, Node.next], Node.next], mu]);
          }
          SecMask[Heap[newList#0, Node.next], Node.prev] := SecMask[Heap[newList#0, Node.next], Node.prev][perm$N := SecMask[Heap[newList#0, Node.next], Node.prev][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[newList#0, Node.next], Node.prev][perm$N] < 0) {
            SecMask[Heap[newList#0, Node.next], Node.prev] := SecMask[Heap[newList#0, Node.next], Node.prev][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[newList#0, Node.next], Node.next] := SecMask[Heap[newList#0, Node.next], Node.next][perm$N := SecMask[Heap[newList#0, Node.next], Node.next][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[newList#0, Node.next], Node.next][perm$N] < 0) {
            SecMask[Heap[newList#0, Node.next], Node.next] := SecMask[Heap[newList#0, Node.next], Node.next][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          SecMask[Heap[newList#0, Node.next], mu] := SecMask[Heap[newList#0, Node.next], mu][perm$N := SecMask[Heap[newList#0, Node.next], mu][perm$N] - 1];
          assume wf(Heap, Mask, SecMask);
          if (SecMask[Heap[newList#0, Node.next], mu][perm$N] < 0) {
            SecMask[Heap[newList#0, Node.next], mu] := SecMask[Heap[newList#0, Node.next], mu][perm$N := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[Heap[newList#0, Node.next], Node.next] == null)) {
            SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
            if (SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R] < 0) {
              SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight][perm$R := 0];
            }
            assume Heap[Heap[newList#0, Node.next], Node.next] != Heap[newList#0, Node.next];
            if ((((false || ((predVer#_611 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[newList#0, Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[newList#0, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[newList#0, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[newList#0, Node.next], Node.next]) && true && predFlag#_357)) {
              if ((predVer#_356 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[newList#0, Node.next], Node.next]) && true && predFlag#_357) {
              } else {
                if ((predVer#_422 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[newList#0, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                } else {
                  if ((predVer#_444 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[newList#0, Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                  } else {
                  }
                }
              }
              // begin exhale (update SecMask)
              if (!(Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next] == null)) {
                //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                assume MuBelow(Heap[Heap[Heap[newList#0, Node.next], Node.next], mu], Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu]);
              }
              SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.prev][perm$N] - 1];
              assume wf(Heap, Mask, SecMask);
              if (SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.prev][perm$N] < 0) {
                SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.prev][perm$N := 0];
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
              SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.next][perm$N] - 1];
              assume wf(Heap, Mask, SecMask);
              if (SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.next][perm$N] < 0) {
                SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.next] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], Node.next][perm$N := 0];
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
              SecMask[Heap[Heap[newList#0, Node.next], Node.next], mu] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[newList#0, Node.next], Node.next], mu][perm$N] - 1];
              assume wf(Heap, Mask, SecMask);
              if (SecMask[Heap[Heap[newList#0, Node.next], Node.next], mu][perm$N] < 0) {
                SecMask[Heap[Heap[newList#0, Node.next], Node.next], mu] := SecMask[Heap[Heap[newList#0, Node.next], Node.next], mu][perm$N := 0];
              }
              assume wf(Heap, SecMask, SecMask);
              assume wf(Heap, Mask, SecMask);
              if (!(Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next] == null)) {
                SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                if (SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                  SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                }
                assume Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                assume Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                  if ((predVer#_356 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                  } else {
                    if ((predVer#_422 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                    } else {
                      if ((predVer#_444 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                      } else {
                      }
                    }
                  }
                  // begin exhale (update SecMask)
                  if (!(Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next] == null)) {
                    //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                    assume MuBelow(Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu]);
                  }
                  SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                  assume wf(Heap, Mask, SecMask);
                  if (SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                    SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                  SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                  assume wf(Heap, Mask, SecMask);
                  if (SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                    SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                  SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu][perm$N] - 1];
                  assume wf(Heap, Mask, SecMask);
                  if (SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                    SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], mu][perm$N := 0];
                  }
                  assume wf(Heap, SecMask, SecMask);
                  assume wf(Heap, Mask, SecMask);
                  if (!(Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next] == null)) {
                    SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                    if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                    }
                    assume Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                    assume Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                    assume Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                    if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                      if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                      } else {
                        if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                        } else {
                          if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                          } else {
                          }
                        }
                      }
                      // begin exhale (update SecMask)
                      if (!(Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                        assume MuBelow(Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                      }
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                      assume wf(Heap, Mask, SecMask);
                      if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                      assume wf(Heap, Mask, SecMask);
                      if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                      SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                      assume wf(Heap, Mask, SecMask);
                      if (SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                        SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                      }
                      assume wf(Heap, SecMask, SecMask);
                      assume wf(Heap, Mask, SecMask);
                      if (!(Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                        SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                        if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                        }
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next];
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                        assume Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                        if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                          if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                          } else {
                            if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                            } else {
                              if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                              } else {
                              }
                            }
                          }
                          // begin exhale (update SecMask)
                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                            //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                            assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                          }
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                          assume wf(Heap, Mask, SecMask);
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                          assume wf(Heap, Mask, SecMask);
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                          SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                          assume wf(Heap, Mask, SecMask);
                          if (SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                          }
                          assume wf(Heap, SecMask, SecMask);
                          assume wf(Heap, Mask, SecMask);
                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                            }
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                            assume Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                            if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                              if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                              } else {
                                if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                } else {
                                  if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                  } else {
                                  }
                                }
                              }
                              // begin exhale (update SecMask)
                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                              }
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                              assume wf(Heap, Mask, SecMask);
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                              assume wf(Heap, Mask, SecMask);
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                              assume wf(Heap, Mask, SecMask);
                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                              }
                              assume wf(Heap, SecMask, SecMask);
                              assume wf(Heap, Mask, SecMask);
                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                }
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                                if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                  if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                  } else {
                                    if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                    } else {
                                      if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                      } else {
                                      }
                                    }
                                  }
                                  // begin exhale (update SecMask)
                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                    //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                    assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                  }
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                  assume wf(Heap, Mask, SecMask);
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                  assume wf(Heap, Mask, SecMask);
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                  assume wf(Heap, Mask, SecMask);
                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  assume wf(Heap, Mask, SecMask);
                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                    }
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                                    assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                                    if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                      if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                      } else {
                                        if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                        } else {
                                          if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                          } else {
                                          }
                                        }
                                      }
                                      // begin exhale (update SecMask)
                                      if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                        //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                        assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                      }
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                      assume wf(Heap, Mask, SecMask);
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                      assume wf(Heap, Mask, SecMask);
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                      assume wf(Heap, Mask, SecMask);
                                      if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      assume wf(Heap, Mask, SecMask);
                                      if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                        SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                        if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                        }
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                                        assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                                        if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                          if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                          } else {
                                            if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                            } else {
                                              if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                              } else {
                                              }
                                            }
                                          }
                                          // begin exhale (update SecMask)
                                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                            //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                            assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                          }
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                          assume wf(Heap, Mask, SecMask);
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                          assume wf(Heap, Mask, SecMask);
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                          SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                          assume wf(Heap, Mask, SecMask);
                                          if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          assume wf(Heap, Mask, SecMask);
                                          if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                            SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                            if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                            }
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                                            assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                                            if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                              if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                              } else {
                                                if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                                } else {
                                                  if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                                  } else {
                                                  }
                                                }
                                              }
                                              // begin exhale (update SecMask)
                                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                                //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                                assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                              }
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                              assume wf(Heap, Mask, SecMask);
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                              assume wf(Heap, Mask, SecMask);
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                              SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                              assume wf(Heap, Mask, SecMask);
                                              if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              assume wf(Heap, Mask, SecMask);
                                              if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                                SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                                if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                                }
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[Heap[newList#0, Node.next], Node.next];
                                                assume Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] != Heap[newList#0, Node.next];
                                                if ((((false || ((predVer#_611 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_610 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_502 && cond#_471 && cond#_549 && cond#_408 && cond#_386 && cond#_573 && cond#_501 && cond#_466 && cond#_477 && cond#_453 && cond#_608 && cond#_476 && cond#_430 && cond#_609 && cond#_452 && predFlag#_612)) || ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445)) || ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423)) || ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357)) {
                                                  if ((predVer#_356 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_355 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && predFlag#_357) {
                                                  } else {
                                                    if ((predVer#_422 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_421 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && predFlag#_423) {
                                                    } else {
                                                      if ((predVer#_444 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight]) && (predRec#_443 == Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next]) && true && cond#_364 && cond#_386 && cond#_408 && cond#_430 && predFlag#_445) {
                                                      } else {
                                                      }
                                                    }
                                                  }
                                                  // begin exhale (update SecMask)
                                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                                    //  assert <undefined position>:  The expression at 27.42 might not evaluate to true.
                                                    assume MuBelow(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu], Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu]);
                                                  }
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] - 1];
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.prev][perm$N := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] - 1];
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next][perm$N := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                  SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] - 1];
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N] < 0) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], mu][perm$N := 0];
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  assume wf(Heap, Mask, SecMask);
                                                  if (!(Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next] == null)) {
                                                    SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] - Fractions(100)];
                                                    if (SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R] < 0) {
                                                      SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight] := SecMask[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[Heap[newList#0, Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.next], Node.invRight][perm$R := 0];
                                                    }
                                                    assume wf(Heap, SecMask, SecMask);
                                                    assume wf(Heap, Mask, SecMask);
                                                  }
                                                  assume wf(Heap, SecMask, SecMask);
                                                  // end exhale
                                                }
                                                assume wf(Heap, SecMask, SecMask);
                                                assume wf(Heap, Mask, SecMask);
                                              }
                                              assume wf(Heap, SecMask, SecMask);
                                              // end exhale
                                            }
                                            assume wf(Heap, SecMask, SecMask);
                                            assume wf(Heap, Mask, SecMask);
                                          }
                                          assume wf(Heap, SecMask, SecMask);
                                          // end exhale
                                        }
                                        assume wf(Heap, SecMask, SecMask);
                                        assume wf(Heap, Mask, SecMask);
                                      }
                                      assume wf(Heap, SecMask, SecMask);
                                      // end exhale
                                    }
                                    assume wf(Heap, SecMask, SecMask);
                                    assume wf(Heap, Mask, SecMask);
                                  }
                                  assume wf(Heap, SecMask, SecMask);
                                  // end exhale
                                }
                                assume wf(Heap, SecMask, SecMask);
                                assume wf(Heap, Mask, SecMask);
                              }
                              assume wf(Heap, SecMask, SecMask);
                              // end exhale
                            }
                            assume wf(Heap, SecMask, SecMask);
                            assume wf(Heap, Mask, SecMask);
                          }
                          assume wf(Heap, SecMask, SecMask);
                          // end exhale
                        }
                        assume wf(Heap, SecMask, SecMask);
                        assume wf(Heap, Mask, SecMask);
                      }
                      assume wf(Heap, SecMask, SecMask);
                      // end exhale
                    }
                    assume wf(Heap, SecMask, SecMask);
                    assume wf(Heap, Mask, SecMask);
                  }
                  assume wf(Heap, SecMask, SecMask);
                  // end exhale
                }
                assume wf(Heap, SecMask, SecMask);
                assume wf(Heap, Mask, SecMask);
              }
              assume wf(Heap, SecMask, SecMask);
              // end exhale
            }
            assume wf(Heap, SecMask, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          assume wf(Heap, SecMask, SecMask);
          // end exhale
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_654, SecMask, newList#0, Node.inv)) {
      assume Heap[newList#0, Node.inv] < exhaleHeap#_653[newList#0, Node.inv];
    }
    assume IsGoodMask(exhaleMask#_654);
    assume wf(Heap, exhaleMask#_654, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_654;
  assume IsGoodExhaleState(exhaleHeap#_653, Heap, Mask, SecMask);
  Heap := exhaleHeap#_653;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  assert {:msg "  30.5: Method might lock/unlock more than allowed."} (forall lk#_935: ref :: {Heap[lk#_935, held]} {Heap[lk#_935, rdheld]} (((0 < Heap[lk#_935, held]) == (0 < old(Heap)[lk#_935, held])) && (Heap[lk#_935, rdheld] == old(Heap)[lk#_935, rdheld])) || false);
  assert {:msg "  30.5: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
