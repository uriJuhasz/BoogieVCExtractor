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
const Permission$MinusInfinity: int;
axiom Permission$MinusInfinity < -10000;
const Permission$PlusInfinity: int;
axiom 10000 < Permission$PlusInfinity;
var Mask: MaskType where IsGoodMask(Mask);
const Permission$Zero: [PermissionComponent]int;
axiom Permission$Zero[perm$R] == 0 && Permission$Zero[perm$N] == 0;
const Permission$Full: [PermissionComponent]int;
axiom Permission$Full[perm$R] == 100 && Permission$Full[perm$N] == 0;
const ZeroMask: MaskType;
axiom (forall<T> o: ref, f: Field T, pc: PermissionComponent :: ZeroMask[o,f][pc] == 0);
axiom IsGoodMask(ZeroMask);
function {:expand false} CanRead<T>(m: MaskType, obj: ref, f: Field T) returns (bool)
{
  0 < m[obj,f][perm$R] || 0 < m[obj,f][perm$N]
}
function {:expand false} CanWrite<T>(m: MaskType, obj: ref, f: Field T) returns (bool)
{
  m[obj,f][perm$R] == 100 && m[obj,f][perm$N] == 0
}
function {:expand true} IsGoodMask(m: MaskType) returns (bool)
{
  (forall<T> o: ref, f: Field T ::
      0 <= m[o,f][perm$R] && 
      (NonPredicateField(f) ==> 
        (m[o,f][perm$R]<=100 &&
        (0 < m[o,f][perm$N] ==> m[o,f][perm$R] < 100))) &&
      (m[o,f][perm$N] < 0 ==> 0 < m[o,f][perm$R]))
}

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
// -- If then else -----------------------------------------------
// ---------------------------------------------------------------

function ite<T>(bool, T, T) returns (T);
axiom (forall<T> con: bool, a: T, b: T :: {ite(con, a, b)} con ==> ite(con, a, b) == a);
axiom (forall<T> con: bool, a: T, b: T :: {ite(con, a, b)} ! con ==> ite(con, a, b) == b);

// ---------------------------------------------------------------
// -- Axiomatization of sequences --------------------------------
// ---------------------------------------------------------------

type Seq T;

function Seq#Length<T>(Seq T) returns (int);
axiom (forall<T> s: Seq T :: { Seq#Length(s) } 0 <= Seq#Length(s));

function Seq#Empty<T>() returns (Seq T);
axiom (forall<T> :: Seq#Length(Seq#Empty(): Seq T) == 0);
axiom (forall<T> s: Seq T :: { Seq#Length(s) } Seq#Length(s) == 0 ==> s == Seq#Empty());

function Seq#Singleton<T>(T) returns (Seq T);
axiom (forall<T> t: T :: { Seq#Length(Seq#Singleton(t)) } Seq#Length(Seq#Singleton(t)) == 1);

function Seq#Build<T>(s: Seq T, index: int, val: T, newLength: int) returns (Seq T);
axiom (forall<T> s: Seq T, i: int, v: T, len: int :: { Seq#Length(Seq#Build(s,i,v,len)) }
  0 <= len ==> Seq#Length(Seq#Build(s,i,v,len)) == len);

function Seq#Append<T>(Seq T, Seq T) returns (Seq T);
axiom (forall<T> s0: Seq T, s1: Seq T :: { Seq#Length(Seq#Append(s0,s1)) }
  Seq#Length(Seq#Append(s0,s1)) == Seq#Length(s0) + Seq#Length(s1));

function Seq#Index<T>(Seq T, int) returns (T);
axiom (forall<T> t: T :: { Seq#Index(Seq#Singleton(t), 0) } Seq#Index(Seq#Singleton(t), 0) == t);
axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: { Seq#Index(Seq#Append(s0,s1), n) }
  (n < Seq#Length(s0) ==> Seq#Index(Seq#Append(s0,s1), n) == Seq#Index(s0, n)) &&
  (Seq#Length(s0) <= n ==> Seq#Index(Seq#Append(s0,s1), n) == Seq#Index(s1, n - Seq#Length(s0))));
axiom (forall<T> s: Seq T, i: int, v: T, len: int, n: int :: { Seq#Index(Seq#Build(s,i,v,len),n) }
  0 <= n && n < len ==>
    (i == n ==> Seq#Index(Seq#Build(s,i,v,len),n) == v) &&
    (i != n ==> Seq#Index(Seq#Build(s,i,v,len),n) == Seq#Index(s,n)));

function Seq#Contains<T>(Seq T, T) returns (bool);
axiom (forall<T> s: Seq T, x: T :: { Seq#Contains(s,x) }
  Seq#Contains(s,x) <==>
    (exists i: int :: { Seq#Index(s,i) } 0 <= i && i < Seq#Length(s) && Seq#Index(s,i) == x));
axiom (forall x: ref ::
  { Seq#Contains(Seq#Empty(), x) }
  !Seq#Contains(Seq#Empty(), x));
axiom (forall<T> s0: Seq T, s1: Seq T, x: T ::
  { Seq#Contains(Seq#Append(s0, s1), x) }
  Seq#Contains(Seq#Append(s0, s1), x) <==>
    Seq#Contains(s0, x) || Seq#Contains(s1, x));
axiom (forall<T> s: Seq T, i: int, v: T, len: int, x: T ::
  { Seq#Contains(Seq#Build(s, i, v, len), x) }
  Seq#Contains(Seq#Build(s, i, v, len), x) <==>
    (0 <= i && i < len && x == v)  ||  
    (exists j: int :: { Seq#Index(s,j) } 0 <= j && j < Seq#Length(s) && j < len && j!=i && Seq#Index(s,j) == x));
axiom (forall<T> s: Seq T, n: int, x: T ::
  { Seq#Contains(Seq#Take(s, n), x) }
  Seq#Contains(Seq#Take(s, n), x) <==>
    (exists i: int :: { Seq#Index(s, i) }
      0 <= i && i < n && i < Seq#Length(s) && Seq#Index(s, i) == x));
axiom (forall<T> s: Seq T, n: int, x: T ::
  { Seq#Contains(Seq#Drop(s, n), x) }
  Seq#Contains(Seq#Drop(s, n), x) <==>
    (exists i: int :: { Seq#Index(s, i) }
      0 <= n && n <= i && i < Seq#Length(s) && Seq#Index(s, i) == x));

function Seq#Equal<T>(Seq T, Seq T) returns (bool);
axiom (forall<T> s0: Seq T, s1: Seq T :: { Seq#Equal(s0,s1) }
  Seq#Equal(s0,s1) <==>
    Seq#Length(s0) == Seq#Length(s1) &&
    (forall j: int :: { Seq#Index(s0,j) } { Seq#Index(s1,j) }
        0 <= j && j < Seq#Length(s0) ==> Seq#Index(s0,j) == Seq#Index(s1,j)));
axiom(forall<T> a: Seq T, b: Seq T :: { Seq#Equal(a,b) }  // extensionality axiom for sequences
  Seq#Equal(a,b) ==> a == b);

function Seq#SameUntil<T>(Seq T, Seq T, int) returns (bool);
axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: { Seq#SameUntil(s0,s1,n) }
  Seq#SameUntil(s0,s1,n) <==>
    (forall j: int :: { Seq#Index(s0,j) } { Seq#Index(s1,j) }
        0 <= j && j < n ==> Seq#Index(s0,j) == Seq#Index(s1,j)));

function Seq#Take<T>(s: Seq T, howMany: int) returns (Seq T);
axiom (forall<T> s: Seq T, n: int :: { Seq#Length(Seq#Take(s,n)) }
  0 <= n ==>
    (n <= Seq#Length(s) ==> Seq#Length(Seq#Take(s,n)) == n) &&
    (Seq#Length(s) < n ==> Seq#Length(Seq#Take(s,n)) == Seq#Length(s)));
axiom (forall<T> s: Seq T, n: int, j: int :: { Seq#Index(Seq#Take(s,n), j) } {:weight 25}
  0 <= j && j < n && j < Seq#Length(s) ==>
    Seq#Index(Seq#Take(s,n), j) == Seq#Index(s, j));

function Seq#Drop<T>(s: Seq T, howMany: int) returns (Seq T);
axiom (forall<T> s: Seq T, n: int :: { Seq#Length(Seq#Drop(s,n)) }
  0 <= n ==>
    (n <= Seq#Length(s) ==> Seq#Length(Seq#Drop(s,n)) == Seq#Length(s) - n) &&
    (Seq#Length(s) < n ==> Seq#Length(Seq#Drop(s,n)) == 0));
axiom (forall<T> s: Seq T, n: int, j: int :: { Seq#Index(Seq#Drop(s,n), j) } {:weight 25}
  0 <= n && 0 <= j && j < Seq#Length(s)-n ==>
    Seq#Index(Seq#Drop(s,n), j) == Seq#Index(s, j+n));

axiom (forall<T> s, t: Seq T ::
  { Seq#Append(s, t) }
  Seq#Take(Seq#Append(s, t), Seq#Length(s)) == s &&
  Seq#Drop(Seq#Append(s, t), Seq#Length(s)) == t);

function Seq#Range(min: int, max: int) returns (Seq int);

axiom (forall min: int, max: int :: { Seq#Length(Seq#Range(min, max)) } (min < max ==> Seq#Length(Seq#Range(min, max)) == max-min) && (max <= min ==> Seq#Length(Seq#Range(min, max)) == 0));
axiom (forall min: int, max: int, j: int :: { Seq#Index(Seq#Range(min, max), j) } 0<=j && j<max-min ==> Seq#Index(Seq#Range(min, max), j) == min + j);

//urij

axiom (forall<T> x, y: T ::
  { Seq#Contains(Seq#Singleton(x),y) }
    Seq#Contains(Seq#Singleton(x),y) ==> x==y
);

axiom (forall<T> x: T ::
  { Seq#Contains(Seq#Singleton(x),x) }
    Seq#Contains(Seq#Singleton(x),x)
);

//-urij

// ---------------------------------------------------------------
// -- Permissions ------------------------------------------------
// ---------------------------------------------------------------

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

const unique joinable: Field int;
axiom NonPredicateField(joinable);
const unique token#t: TypeName;

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
// -- End of prelude ---------------------------------------------
// ---------------------------------------------------------------
const unique Cell#t: TypeName;
const unique module#default: ModuleName;
procedure Cell$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == Cell#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var h0#_0: HeapType;
  var m0#_1: MaskType;
  var c0#_2: CreditsType;
  var h1#_3: HeapType;
  var m1#_4: MaskType;
  var c1#_5: CreditsType;
  var lk#_6: ref;
  assume wf(h0#_0, m0#_1);
  assume wf(h1#_3, m1#_4);
  m1#_4 := ZeroMask;
  c1#_5 := ZeroCredits;
  Mask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  assert {:msg "  1.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique Cell.x: Field (int);
axiom NonPredicateField(Cell.x);
const unique Cell.valid: Field (HeapType);
axiom PredicateField(Cell.valid);
procedure Cell.valid$checkDefinedness(this: ref where (this == null) || (dtype(this) == Cell#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_7: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_7;
  assume IsGoodInhaleState(inhaleHeap#_7, Heap, Mask);
  assume this != null;
  Heap[this, Cell.x] := inhaleHeap#_7[this, Cell.x];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, Cell.x] := Mask[this, Cell.x][perm$R := Mask[this, Cell.x][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_7[this, Cell.x]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_7, Mask);
  assert {:msg "  5.23: Receiver might be null."} true ==> (this != null);
  assert {:msg "  5.23: Location might not be readable."} true ==> CanRead(Mask, this, Cell.x);
  assume 0 <= Heap[this, Cell.x];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
function #Cell.get(heap: HeapType, mask: MaskType, this: ref) returns ($myresult: int);
procedure Cell.get$checkDefinedness(this: ref where (this == null) || (dtype(this) == Cell#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_17: HeapType;
  var Heap#_11: HeapType;
  var Mask#_12: MaskType;
  var Credits#_13: CreditsType;
  var exhaleMask#_14: MaskType;
  var fraction#_15: int;
  var inhaleHeap#_16: HeapType;
  var result: int;
  var exhaleMask#_18: MaskType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_17;
  assume IsGoodInhaleState(inhaleHeap#_17, Heap, Mask);
  assume this != null;
  Heap[this, Cell.valid] := inhaleHeap#_17[this, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_17[this, Cell.valid] == Heap;
  Mask[this, Cell.valid] := Mask[this, Cell.valid][perm$R := Mask[this, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_17[this, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_17, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  assume CurrentModule == module#default;
  // unfolding
  assert {:msg "  12.15: Receiver might be null."} true ==> (this != null);
  Heap#_11 := Heap;
  Mask#_12 := Mask;
  Credits#_13 := Credits;
  // begin exhale (unfolding)
  exhaleMask#_14 := Mask#_12;
  fraction#_15 := 100;
  assert {:msg "  12.5: Unfolding might fail. Insufficient fraction at 12.15 for Cell.valid."} (fraction#_15 <= exhaleMask#_14[this, Cell.valid][perm$R]) && ((fraction#_15 == exhaleMask#_14[this, Cell.valid][perm$R]) ==> (0 <= exhaleMask#_14[this, Cell.valid][perm$N]));
  exhaleMask#_14[this, Cell.valid] := exhaleMask#_14[this, Cell.valid][perm$R := exhaleMask#_14[this, Cell.valid][perm$R] - fraction#_15];
  assume IsGoodMask(Mask#_12);
  assume wf(Heap#_11, Mask#_12);
  assume wf(Heap#_11, exhaleMask#_14);
  Mask#_12 := exhaleMask#_14;
  assume wf(Heap#_11, Mask#_12);
  // end exhale
  // inhale (unfolding)
  inhaleHeap#_16 := Heap[this, Cell.valid];
  assume IsGoodInhaleState(inhaleHeap#_16, Heap#_11, Mask#_12);
  assume this != null;
  Heap#_11[this, Cell.x] := inhaleHeap#_16[this, Cell.x];
  assume wf(Heap#_11, Mask#_12);
  assume true;
  Mask#_12[this, Cell.x] := Mask#_12[this, Cell.x][perm$R := Mask#_12[this, Cell.x][perm$R] + 100];
  assume IsGoodMask(Mask#_12);
  assume IsGoodState(inhaleHeap#_16[this, Cell.x]);
  assume wf(Heap#_11, Mask#_12);
  assume wf(inhaleHeap#_16, Mask#_12);
  assume 0 <= Heap#_11[this, Cell.x];
  assume IsGoodMask(Mask#_12);
  assume wf(Heap#_11, Mask#_12);
  // end inhale
  assert {:msg "  12.24: Receiver might be null."} true ==> (this != null);
  assert {:msg "  12.24: Location might not be readable."} true ==> CanRead(Mask#_12, this, Cell.x);
  result := Heap[this, Cell.x];
  // begin exhale (function postcondition)
  exhaleMask#_18 := Mask;
  assert {:msg "  8.3: Postcondition at 10.13 might not hold. The expression at 10.13 might not evaluate to true."} 0 <= result;
  Mask := exhaleMask#_18;
  assume wf(Heap, Mask);
  // end exhale
}
axiom (forall Heap: HeapType, Mask: MaskType, this: ref :: {#Cell.get(Heap, Mask, this)} wf(Heap, Mask) && (CurrentModule == module#default) ==> (#Cell.get(Heap, Mask, this) == Heap[this, Cell.x]));
function ##Cell.get(state: HeapType, this: ref) returns ($myresult: int);
axiom (forall Heap: HeapType, Mask: MaskType, this: ref :: {#Cell.get(Heap, Mask, this)} wf(Heap, Mask) && IsGoodState(combine(nostate, Heap[this, Cell.valid])) && CanAssumeFunctionDefs ==> (#Cell.get(Heap, Mask, this) == ##Cell.get(combine(nostate, Heap[this, Cell.valid]), this)));
axiom (forall Heap: HeapType, Mask: MaskType, this: ref :: {#Cell.get(Heap, Mask, this)} wf(Heap, Mask) && CanAssumeFunctionDefs ==> (0 <= #Cell.get(Heap, Mask, this)));
procedure Cell.set$checkDefinedness(this: ref where (this == null) || (dtype(this) == Cell#t), v#0: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_19: HeapType;
  var inhaleHeap#_20: HeapType;
  var Heap#_24: HeapType;
  var Mask#_25: MaskType;
  var Credits#_26: CreditsType;
  var exhaleMask#_27: MaskType;
  var fraction#_28: int;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_19;
  assume IsGoodInhaleState(inhaleHeap#_19, Heap, Mask);
  assume this != null;
  Heap[this, Cell.valid] := inhaleHeap#_19[this, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_19[this, Cell.valid] == Heap;
  Mask[this, Cell.valid] := Mask[this, Cell.valid][perm$R := Mask[this, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_19[this, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_19, Mask);
  assume 0 <= v#0;
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
  havoc inhaleHeap#_20;
  assume IsGoodInhaleState(inhaleHeap#_20, Heap, Mask);
  assume this != null;
  Heap[this, Cell.valid] := inhaleHeap#_20[this, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_20[this, Cell.valid] == Heap;
  Mask[this, Cell.valid] := Mask[this, Cell.valid][perm$R := Mask[this, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_20[this, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_20, Mask);
  assert {:msg "  17.22: Receiver might be null."} true ==> (this != null);
  // check precondition of call
  assume true;
  Heap#_24 := Heap;
  Mask#_25 := Mask;
  Credits#_26 := Credits;
  // begin exhale (function call)
  exhaleMask#_27 := Mask#_25;
  fraction#_28 := 100;
  assert {:msg "  17.22: Precondition at 9.14 might not hold. Insufficient fraction at 9.14 for Cell.valid."} (fraction#_28 <= exhaleMask#_27[this, Cell.valid][perm$R]) && ((fraction#_28 == exhaleMask#_27[this, Cell.valid][perm$R]) ==> (0 <= exhaleMask#_27[this, Cell.valid][perm$N]));
  exhaleMask#_27[this, Cell.valid] := exhaleMask#_27[this, Cell.valid][perm$R := exhaleMask#_27[this, Cell.valid][perm$R] - fraction#_28];
  assume IsGoodMask(Mask#_25);
  assume wf(Heap#_24, Mask#_25);
  assume wf(Heap#_24, exhaleMask#_27);
  Mask#_25 := exhaleMask#_27;
  assume wf(Heap#_24, Mask#_25);
  // end exhale
  assume #Cell.get(Heap, Mask, this) == v#0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure Cell.set(this: ref where (this == null) || (dtype(this) == Cell#t), v#0: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_29: HeapType;
  var exhaleMask#_30: MaskType;
  var fraction#_31: int;
  var inhaleHeap#_32: HeapType;
  var exhaleMask#_33: MaskType;
  var fraction#_34: int;
  var inhaleHeap#_35: HeapType;
  var exhaleMask#_36: MaskType;
  var fraction#_37: int;
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_29;
  assume IsGoodInhaleState(inhaleHeap#_29, Heap, Mask);
  assume this != null;
  Heap[this, Cell.valid] := inhaleHeap#_29[this, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_29[this, Cell.valid] == Heap;
  Mask[this, Cell.valid] := Mask[this, Cell.valid][perm$R := Mask[this, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_29[this, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_29, Mask);
  assume 0 <= v#0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assert {:msg "  19.5: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_30 := Mask;
  fraction#_31 := 100;
  assert {:msg "  19.5: unfold might fail because the predicate Cell.valid does not hold. Insufficient fraction at <undefined position> for Cell.valid."} (fraction#_31 <= exhaleMask#_30[this, Cell.valid][perm$R]) && ((fraction#_31 == exhaleMask#_30[this, Cell.valid][perm$R]) ==> (0 <= exhaleMask#_30[this, Cell.valid][perm$N]));
  exhaleMask#_30[this, Cell.valid] := exhaleMask#_30[this, Cell.valid][perm$R := exhaleMask#_30[this, Cell.valid][perm$R] - fraction#_31];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_30);
  Mask := exhaleMask#_30;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_32 := Heap[this, Cell.valid];
  assume IsGoodInhaleState(inhaleHeap#_32, Heap, Mask);
  assume this != null;
  Heap[this, Cell.x] := inhaleHeap#_32[this, Cell.x];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, Cell.x] := Mask[this, Cell.x][perm$R := Mask[this, Cell.x][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_32[this, Cell.x]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_32, Mask);
  assume 0 <= Heap[this, Cell.x];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // update field x
  assert {:msg "  20.5: Location might not be writable"} CanWrite(Mask, this, Cell.x);
  Heap[this, Cell.x] := v#0;
  assume wf(Heap, Mask);
  // fold
  assert {:msg "  21.5: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_33 := Mask;
  fraction#_34 := 100;
  assert {:msg "  21.5: Fold might fail because the definition of Cell.valid does not hold. Insufficient fraction at 5.5 for Cell.x."} (fraction#_34 <= exhaleMask#_33[this, Cell.x][perm$R]) && ((fraction#_34 == exhaleMask#_33[this, Cell.x][perm$R]) ==> (0 <= exhaleMask#_33[this, Cell.x][perm$N]));
  exhaleMask#_33[this, Cell.x] := exhaleMask#_33[this, Cell.x][perm$R := exhaleMask#_33[this, Cell.x][perm$R] - fraction#_34];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_33);
  assert {:msg "  21.5: Fold might fail because the definition of Cell.valid does not hold. The expression at 5.20 might not evaluate to true."} 0 <= Heap[this, Cell.x];
  Mask := exhaleMask#_33;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_35;
  assume IsGoodInhaleState(inhaleHeap#_35, Heap, Mask);
  assume this != null;
  Heap[this, Cell.valid] := inhaleHeap#_35[this, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_35[this, Cell.valid] == Heap;
  Mask[this, Cell.valid] := Mask[this, Cell.valid][perm$R := Mask[this, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_35[this, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_35, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, Cell.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_36 := Mask;
  fraction#_37 := 100;
  assert {:msg "  15.3: The postcondition at 17.13 might not hold. Insufficient fraction at 17.13 for Cell.valid."} (fraction#_37 <= exhaleMask#_36[this, Cell.valid][perm$R]) && ((fraction#_37 == exhaleMask#_36[this, Cell.valid][perm$R]) ==> (0 <= exhaleMask#_36[this, Cell.valid][perm$N]));
  exhaleMask#_36[this, Cell.valid] := exhaleMask#_36[this, Cell.valid][perm$R := exhaleMask#_36[this, Cell.valid][perm$R] - fraction#_37];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_36);
  assert {:msg "  15.3: The postcondition at 17.13 might not hold. The expression at 17.22 might not evaluate to true."} #Cell.get(Heap, Mask, this) == v#0;
  Mask := exhaleMask#_36;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  15.3: Method might lock/unlock more than allowed."} (forall lk#_38: ref :: {Heap[lk#_38, held]} {Heap[lk#_38, rdheld]} (((0 < Heap[lk#_38, held]) == (0 < old(Heap)[lk#_38, held])) && (Heap[lk#_38, rdheld] == old(Heap)[lk#_38, rdheld])) || false);
  assert {:msg "  15.3: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure Cell.test$checkDefinedness(this: ref where (this == null) || (dtype(this) == Cell#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_39: HeapType;
  var inhaleHeap#_40: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_39;
  assume IsGoodInhaleState(inhaleHeap#_39, Heap, Mask);
  assume this != null;
  Heap[this, Cell.valid] := inhaleHeap#_39[this, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_39[this, Cell.valid] == Heap;
  Mask[this, Cell.valid] := Mask[this, Cell.valid][perm$R := Mask[this, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_39[this, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_39, Mask);
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
  havoc inhaleHeap#_40;
  assume IsGoodInhaleState(inhaleHeap#_40, Heap, Mask);
  assume false;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure Cell.test(this: ref where (this == null) || (dtype(this) == Cell#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_41: HeapType;
  var this#1: ref where (this#1 == null) || (dtype(this#1) == Cell#t);
  var v#2: int where true;
  var callHeap#_42: HeapType;
  var callMask#_43: MaskType;
  var callCredits#_44: CreditsType;
  var exhaleMask#_45: MaskType;
  var fraction#_46: int;
  var isHeld#_47: int;
  var isRdHeld#_48: bool;
  var inhaleHeap#_49: HeapType;
  var this#3: ref where (this#3 == null) || (dtype(this#3) == Cell#t);
  var v#4: int where true;
  var callHeap#_50: HeapType;
  var callMask#_51: MaskType;
  var callCredits#_52: CreditsType;
  var exhaleMask#_53: MaskType;
  var fraction#_54: int;
  var isHeld#_55: int;
  var isRdHeld#_56: bool;
  var inhaleHeap#_57: HeapType;
  var exhaleMask#_58: MaskType;
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_41;
  assume IsGoodInhaleState(inhaleHeap#_41, Heap, Mask);
  assume this != null;
  Heap[this, Cell.valid] := inhaleHeap#_41[this, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_41[this, Cell.valid] == Heap;
  Mask[this, Cell.valid] := Mask[this, Cell.valid][perm$R := Mask[this, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_41[this, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_41, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // call set
  callHeap#_42 := Heap;
  callMask#_43 := Mask;
  callCredits#_44 := Credits;
  assert {:msg "  28.5: The target of the method call might be null."} this != null;
  this#1 := this;
  v#2 := 1;
  // begin exhale (precondition)
  exhaleMask#_45 := Mask;
  fraction#_46 := 100;
  assert {:msg "  28.5: The precondition at 16.14 might not hold. Insufficient fraction at 16.14 for Cell.valid."} (fraction#_46 <= exhaleMask#_45[this#1, Cell.valid][perm$R]) && ((fraction#_46 == exhaleMask#_45[this#1, Cell.valid][perm$R]) ==> (0 <= exhaleMask#_45[this#1, Cell.valid][perm$N]));
  exhaleMask#_45[this#1, Cell.valid] := exhaleMask#_45[this#1, Cell.valid][perm$R := exhaleMask#_45[this#1, Cell.valid][perm$R] - fraction#_46];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_45);
  assert {:msg "  28.5: The precondition at 16.14 might not hold. The expression at 16.23 might not evaluate to true."} 0 <= v#2;
  Mask := exhaleMask#_45;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (postcondition)
  havoc inhaleHeap#_49;
  assume IsGoodInhaleState(inhaleHeap#_49, Heap, Mask);
  assume this#1 != null;
  Heap[this#1, Cell.valid] := inhaleHeap#_49[this#1, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_49[this#1, Cell.valid] == Heap;
  Mask[this#1, Cell.valid] := Mask[this#1, Cell.valid][perm$R := Mask[this#1, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_49[this#1, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_49, Mask);
  assume #Cell.get(Heap, Mask, this#1) == v#2;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // call set
  callHeap#_50 := Heap;
  callMask#_51 := Mask;
  callCredits#_52 := Credits;
  assert {:msg "  29.5: The target of the method call might be null."} this != null;
  this#3 := this;
  v#4 := 2;
  // begin exhale (precondition)
  exhaleMask#_53 := Mask;
  fraction#_54 := 100;
  assert {:msg "  29.5: The precondition at 16.14 might not hold. Insufficient fraction at 16.14 for Cell.valid."} (fraction#_54 <= exhaleMask#_53[this#3, Cell.valid][perm$R]) && ((fraction#_54 == exhaleMask#_53[this#3, Cell.valid][perm$R]) ==> (0 <= exhaleMask#_53[this#3, Cell.valid][perm$N]));
  exhaleMask#_53[this#3, Cell.valid] := exhaleMask#_53[this#3, Cell.valid][perm$R := exhaleMask#_53[this#3, Cell.valid][perm$R] - fraction#_54];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_53);
  assert {:msg "  29.5: The precondition at 16.14 might not hold. The expression at 16.23 might not evaluate to true."} 0 <= v#4;
  Mask := exhaleMask#_53;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (postcondition)
  havoc inhaleHeap#_57;
  assume IsGoodInhaleState(inhaleHeap#_57, Heap, Mask);
  assume this#3 != null;
  Heap[this#3, Cell.valid] := inhaleHeap#_57[this#3, Cell.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_57[this#3, Cell.valid] == Heap;
  Mask[this#3, Cell.valid] := Mask[this#3, Cell.valid][perm$R := Mask[this#3, Cell.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_57[this#3, Cell.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_57, Mask);
  assume #Cell.get(Heap, Mask, this#3) == v#4;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // begin exhale (postcondition)
  exhaleMask#_58 := Mask;
  assert {:msg "  24.3: The postcondition at 26.13 might not hold. The expression at 26.13 might not evaluate to true."} false;
  Mask := exhaleMask#_58;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  24.3: Method might lock/unlock more than allowed."} (forall lk#_59: ref :: {Heap[lk#_59, held]} {Heap[lk#_59, rdheld]} (((0 < Heap[lk#_59, held]) == (0 < old(Heap)[lk#_59, held])) && (Heap[lk#_59, rdheld] == old(Heap)[lk#_59, rdheld])) || false);
  assert {:msg "  24.3: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
