
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

axiom (forall<T> x, y: T ::
  { Seq#Contains(Seq#Singleton(x),y) }
    Seq#Contains(Seq#Singleton(x),y) <==> x==y);

// ---------------------------------------------------------------
// -- End of prelude ---------------------------------------------
// ---------------------------------------------------------------

const unique SortedTree#t: TypeName;
const unique module#default: ModuleName;
procedure SortedTree$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTree#t)) returns ()
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
  assert {:msg "  3.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique SortedTree.root: Field (ref);
axiom NonPredicateField(SortedTree.root);
const unique SortedTree.keys: Field (Seq (int));
axiom NonPredicateField(SortedTree.keys);
const unique SortedTree.numClones: Field (int);
axiom NonPredicateField(SortedTree.numClones);
const unique SortedTree.valid: Field (HeapType);
axiom PredicateField(SortedTree.valid);
procedure SortedTree.valid$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTree#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var predicateK#_8: int;
  var inhaleHeap#_9: HeapType;
  assume (0 < predicateK#_8) && ((1000 * predicateK#_8) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_9;
  assume IsGoodInhaleState(inhaleHeap#_9, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.root] := inhaleHeap#_9[this, SortedTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTree.root] == null) || (dtype(Heap[this, SortedTree.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTree.root] := Mask[this, SortedTree.root][perm$R := Mask[this, SortedTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_9[this, SortedTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_9, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_9[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_9[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_9, Mask);
  assume this != null;
  Heap[this, SortedTree.numClones] := inhaleHeap#_9[this, SortedTree.numClones];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.numClones] := Mask[this, SortedTree.numClones][perm$R := Mask[this, SortedTree.numClones][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_9[this, SortedTree.numClones]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_9, Mask);
  assert {:msg "  15.6: Receiver might be null."} true ==> (this != null);
  assert {:msg "  15.6: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.numClones);
  assume Heap[this, SortedTree.numClones] >= 0;
  assert {:msg "  16.6: Receiver might be null."} true ==> (this != null);
  assert {:msg "  16.6: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.numClones);
  assume Heap[this, SortedTree.numClones] < 50;
  assert {:msg "  17.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  17.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  17.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  17.26: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
    assert {:msg "  17.42: Receiver might be null."} true ==> (this != null);
    assert {:msg "  17.42: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.numClones);
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.valid] := inhaleHeap#_9[Heap[this, SortedTree.root], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_9[Heap[this, SortedTree.root], SortedTreeNode.valid] == Heap;
    assume (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.valid] := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] + (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_9[Heap[this, SortedTree.root], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_9, Mask);
  } else {
  }
  assert {:msg "  18.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  18.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  18.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  18.26: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
    assert {:msg "  18.39: Receiver might be null."} true ==> (this != null);
    assert {:msg "  18.39: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.numClones);
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.keys] := inhaleHeap#_9[Heap[this, SortedTree.root], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.keys] := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] + Fractions(50 - Heap[this, SortedTree.numClones])];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_9[Heap[this, SortedTree.root], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_9, Mask);
  } else {
  }
  assert {:msg "  19.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  19.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  19.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  19.22: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.keys);
    assert {:msg "  19.30: Receiver might be null."} true ==> (this != null);
    assert {:msg "  19.30: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
    assert {:msg "  19.30: Receiver might be null."} true ==> (Heap[this, SortedTree.root] != null);
    assert {:msg "  19.30: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTree.root], SortedTreeNode.keys);
    assume Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
  } else {
  }
  assert {:msg "  20.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  20.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
  if (Heap[this, SortedTree.root] == null) {
    assert {:msg "  20.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  20.22: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.keys);
    assume Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTree.init$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTree#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_10: int;
  var inhaleHeap#_11: HeapType;
  var inhaleHeap#_12: HeapType;
  assume (0 < methodK#_10) && ((1000 * methodK#_10) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_11;
  assume IsGoodInhaleState(inhaleHeap#_11, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.root] := inhaleHeap#_11[this, SortedTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTree.root] == null) || (dtype(Heap[this, SortedTree.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTree.root] := Mask[this, SortedTree.root][perm$R := Mask[this, SortedTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_11[this, SortedTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_11, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_11[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_11[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_11, Mask);
  assume this != null;
  Heap[this, SortedTree.numClones] := inhaleHeap#_11[this, SortedTree.numClones];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.numClones] := Mask[this, SortedTree.numClones][perm$R := Mask[this, SortedTree.numClones][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_11[this, SortedTree.numClones]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_11, Mask);
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
  havoc inhaleHeap#_12;
  assume IsGoodInhaleState(inhaleHeap#_12, Heap, Mask);
  assert {:msg "  29.11: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_12[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_12[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_12[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_12, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_12[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_12[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_12, Mask);
  assert {:msg "  31.11: Receiver might be null."} true ==> (this != null);
  assert {:msg "  31.11: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.keys);
  assume Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTree.init(this: ref where (this == null) || (dtype(this) == SortedTree#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_10: int;
  var inhaleHeap#_13: HeapType;
  var foldK#_14: int;
  var exhaleMask#_15: MaskType;
  var inhaleHeap#_21: HeapType;
  var exhaleMask#_22: MaskType;
  assume (0 < methodK#_10) && ((1000 * methodK#_10) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_13;
  assume IsGoodInhaleState(inhaleHeap#_13, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.root] := inhaleHeap#_13[this, SortedTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTree.root] == null) || (dtype(Heap[this, SortedTree.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTree.root] := Mask[this, SortedTree.root][perm$R := Mask[this, SortedTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_13[this, SortedTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_13, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_13[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_13[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_13, Mask);
  assume this != null;
  Heap[this, SortedTree.numClones] := inhaleHeap#_13[this, SortedTree.numClones];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.numClones] := Mask[this, SortedTree.numClones][perm$R := Mask[this, SortedTree.numClones][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_13[this, SortedTree.numClones]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_13, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // update field root
  assert {:msg "  33.3: Location might not be writable"} CanWrite(Mask, this, SortedTree.root);
  Heap[this, SortedTree.root] := null;
  assume wf(Heap, Mask);
  // update field keys
  assert {:msg "  34.3: Location might not be writable"} CanWrite(Mask, this, SortedTree.keys);
  Heap[this, SortedTree.keys] := Seq#Empty();
  assume wf(Heap, Mask);
  // update field numClones
  assert {:msg "  35.3: Location might not be writable"} CanWrite(Mask, this, SortedTree.numClones);
  Heap[this, SortedTree.numClones] := 0;
  assume wf(Heap, Mask);
  // fold
  assume (0 < foldK#_14) && ((1000 * foldK#_14) < Fractions(1)) && ((1000 * foldK#_14) < methodK#_10);
  assert {:msg "  36.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_15 := Mask;
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true."} Heap[this, SortedTree.numClones] >= 0;
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true."} Heap[this, SortedTree.numClones] < 50;
  if (!(Heap[this, SortedTree.root] == null)) {
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
  } else {
  }
  if (Heap[this, SortedTree.root] == null) {
    assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  } else {
  }
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root."} (Fractions(100) <= exhaleMask#_15[this, SortedTree.root][perm$R]) && ((Fractions(100) == exhaleMask#_15[this, SortedTree.root][perm$R]) ==> (0 <= exhaleMask#_15[this, SortedTree.root][perm$N]));
  exhaleMask#_15[this, SortedTree.root] := exhaleMask#_15[this, SortedTree.root][perm$R := exhaleMask#_15[this, SortedTree.root][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_15);
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive."} Fractions(50) > 0;
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys."} (Fractions(50) <= exhaleMask#_15[this, SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_15[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_15[this, SortedTree.keys][perm$N]));
  exhaleMask#_15[this, SortedTree.keys] := exhaleMask#_15[this, SortedTree.keys][perm$R := exhaleMask#_15[this, SortedTree.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_15);
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones."} (Fractions(100) <= exhaleMask#_15[this, SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_15[this, SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_15[this, SortedTree.numClones][perm$N]));
  exhaleMask#_15[this, SortedTree.numClones] := exhaleMask#_15[this, SortedTree.numClones][perm$R := exhaleMask#_15[this, SortedTree.numClones][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_15);
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive."} (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
    assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid."} ((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) <= exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) == exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$N]));
    exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.valid] := exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_15);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive."} Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
    assert {:msg "  36.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys."} (Fractions(50 - Heap[this, SortedTree.numClones]) <= exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap[this, SortedTree.numClones]) == exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$N]));
    exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.keys] := exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := exhaleMask#_15[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] - Fractions(50 - Heap[this, SortedTree.numClones])];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_15);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
  } else {
  }
  if (Heap[this, SortedTree.root] == null) {
  } else {
  }
  Mask := exhaleMask#_15;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_21;
  assume IsGoodInhaleState(inhaleHeap#_21, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_21[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_21[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_21[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_21, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, SortedTree.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_22 := Mask;
  assert {:msg "  24.2: The postcondition at 31.11 might not hold. The expression at 31.11 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  assert {:msg "  24.2: The postcondition at 29.11 might not hold. The permission at 29.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  24.2: The postcondition at 29.11 might not hold. Insufficient fraction at 29.11 for SortedTree.valid."} (Fractions(100) <= exhaleMask#_22[this, SortedTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_22[this, SortedTree.valid][perm$R]) ==> (0 <= exhaleMask#_22[this, SortedTree.valid][perm$N]));
  exhaleMask#_22[this, SortedTree.valid] := exhaleMask#_22[this, SortedTree.valid][perm$R := exhaleMask#_22[this, SortedTree.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_22);
  assert {:msg "  24.2: The postcondition at 30.11 might not hold. The permission at 30.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  24.2: The postcondition at 30.11 might not hold. Insufficient fraction at 30.11 for SortedTree.keys."} (Fractions(50) <= exhaleMask#_22[this, SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_22[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_22[this, SortedTree.keys][perm$N]));
  exhaleMask#_22[this, SortedTree.keys] := exhaleMask#_22[this, SortedTree.keys][perm$R := exhaleMask#_22[this, SortedTree.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_22);
  Mask := exhaleMask#_22;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  24.2: Method might lock/unlock more than allowed."} (forall lk#_25: ref :: {Heap[lk#_25, held]} {Heap[lk#_25, rdheld]} (((0 < Heap[lk#_25, held]) == (0 < old(Heap)[lk#_25, held])) && (Heap[lk#_25, rdheld] == old(Heap)[lk#_25, rdheld])) || false);
  assert {:msg "  24.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure SortedTree.getSnapshot$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTree#t)) returns (r#0: ref where (r#0 == null) || (dtype(r#0) == SortedTreeSnapshot#t))
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_26: int;
  var inhaleHeap#_27: HeapType;
  var inhaleHeap#_28: HeapType;
  assume (0 < methodK#_26) && ((1000 * methodK#_26) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_27;
  assume IsGoodInhaleState(inhaleHeap#_27, Heap, Mask);
  assert {:msg "  41.12: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_27[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_27[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_27[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_27, Mask);
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
  havoc inhaleHeap#_28;
  assume IsGoodInhaleState(inhaleHeap#_28, Heap, Mask);
  assert {:msg "  42.11: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_28[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_28[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_28[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_28, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTree.getSnapshot(this: ref where (this == null) || (dtype(this) == SortedTree#t)) returns (r#0: ref where (r#0 == null) || (dtype(r#0) == SortedTreeSnapshot#t))
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_26: int;
  var inhaleHeap#_29: HeapType;
  var unfoldK#_30: int;
  var exhaleMask#_31: MaskType;
  var inhaleHeap#_33: HeapType;
  var nw#_34: ref;
  var methodCallK#_38: int;
  var this#34: ref where (this#34 == null) || (dtype(this#34) == SortedTreeSnapshot#t);
  var treeRoot#35: ref where (treeRoot#35 == null) || (dtype(treeRoot#35) == SortedTreeNode#t);
  var callHeap#_35: HeapType;
  var callMask#_36: MaskType;
  var callCredits#_37: CreditsType;
  var exhaleMask#_39: MaskType;
  var isHeld#_44: int;
  var isRdHeld#_45: bool;
  var inhaleHeap#_46: HeapType;
  var foldK#_47: int;
  var exhaleMask#_48: MaskType;
  var inhaleHeap#_54: HeapType;
  var exhaleMask#_55: MaskType;
  assume (0 < methodK#_26) && ((1000 * methodK#_26) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_29;
  assume IsGoodInhaleState(inhaleHeap#_29, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_29[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_29[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_29[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_29, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assume (0 < unfoldK#_30) && (unfoldK#_30 < Fractions(1)) && ((1000 * unfoldK#_30) < methodK#_26);
  assert {:msg "  44.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_31 := Mask;
  assert {:msg "  44.3: unfold might fail because the predicate SortedTree.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  44.3: unfold might fail because the predicate SortedTree.valid does not hold. Insufficient fraction at <undefined position> for SortedTree.valid."} (Fractions(100) <= exhaleMask#_31[this, SortedTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_31[this, SortedTree.valid][perm$R]) ==> (0 <= exhaleMask#_31[this, SortedTree.valid][perm$N]));
  exhaleMask#_31[this, SortedTree.valid] := exhaleMask#_31[this, SortedTree.valid][perm$R := exhaleMask#_31[this, SortedTree.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_31);
  Mask := exhaleMask#_31;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_33 := Heap[this, SortedTree.valid];
  assume IsGoodInhaleState(inhaleHeap#_33, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.root] := inhaleHeap#_33[this, SortedTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTree.root] == null) || (dtype(Heap[this, SortedTree.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTree.root] := Mask[this, SortedTree.root][perm$R := Mask[this, SortedTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_33[this, SortedTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_33, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_33[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_33[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_33, Mask);
  assume this != null;
  Heap[this, SortedTree.numClones] := inhaleHeap#_33[this, SortedTree.numClones];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.numClones] := Mask[this, SortedTree.numClones][perm$R := Mask[this, SortedTree.numClones][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_33[this, SortedTree.numClones]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_33, Mask);
  assume Heap[this, SortedTree.numClones] >= 0;
  assume Heap[this, SortedTree.numClones] < 50;
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.valid] := inhaleHeap#_33[Heap[this, SortedTree.root], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_33[Heap[this, SortedTree.root], SortedTreeNode.valid] == Heap;
    assume (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.valid] := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] + (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_33[Heap[this, SortedTree.root], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_33, Mask);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.keys] := inhaleHeap#_33[Heap[this, SortedTree.root], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.keys] := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] + Fractions(50 - Heap[this, SortedTree.numClones])];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_33[Heap[this, SortedTree.root], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_33, Mask);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
  } else {
  }
  if (Heap[this, SortedTree.root] == null) {
    assume Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // if
  assert {:msg "  45.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  45.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.numClones);
  if (Heap[this, SortedTree.numClones] < 49) {
    // assigment to r
    // new
    havoc nw#_34;
    assume (nw#_34 != null) && (dtype(nw#_34) == SortedTreeSnapshot#t);
    assume (forall<T#_0> f: Field (T#_0) :: (Mask[nw#_34, f][perm$R] == 0) && (Mask[nw#_34, f][perm$N] == 0));
    assume Heap[nw#_34, mu] == $LockBottom;
    assume Heap[nw#_34, held] <= 0;
    assume Heap[nw#_34, rdheld] == false;
    Mask[nw#_34, SortedTreeSnapshot.root] := Mask[nw#_34, SortedTreeSnapshot.root][perm$R := Mask[nw#_34, SortedTreeSnapshot.root][perm$R] + Fractions(100)];
    Mask[nw#_34, SortedTreeSnapshot.keys] := Mask[nw#_34, SortedTreeSnapshot.keys][perm$R := Mask[nw#_34, SortedTreeSnapshot.keys][perm$R] + Fractions(100)];
    Mask[nw#_34, mu] := Mask[nw#_34, mu][perm$R := Mask[nw#_34, mu][perm$R] + Fractions(100)];
    r#0 := nw#_34;
    assume (0 < methodCallK#_38) && ((1000 * methodCallK#_38) < Fractions(1)) && ((1000 * methodCallK#_38) < methodK#_26);
    // call init
    callHeap#_35 := Heap;
    callMask#_36 := Mask;
    callCredits#_37 := Credits;
    assert {:msg "  47.4: The target of the method call might be null."} r#0 != null;
    assert {:msg "  47.16: Receiver might be null."} true ==> (this != null);
    assert {:msg "  47.16: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
    this#34 := r#0;
    treeRoot#35 := Heap[this, SortedTree.root];
    // begin exhale (precondition)
    exhaleMask#_39 := Mask;
    if (!(treeRoot#35 == null)) {
    } else {
    }
    if (!(treeRoot#35 == null)) {
    } else {
    }
    assert {:msg "  47.4: The precondition at 125.12 might not hold. The permission at 125.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  47.4: The precondition at 125.12 might not hold. Insufficient fraction at 125.12 for SortedTreeSnapshot.root."} (Fractions(100) <= exhaleMask#_39[this#34, SortedTreeSnapshot.root][perm$R]) && ((Fractions(100) == exhaleMask#_39[this#34, SortedTreeSnapshot.root][perm$R]) ==> (0 <= exhaleMask#_39[this#34, SortedTreeSnapshot.root][perm$N]));
    exhaleMask#_39[this#34, SortedTreeSnapshot.root] := exhaleMask#_39[this#34, SortedTreeSnapshot.root][perm$R := exhaleMask#_39[this#34, SortedTreeSnapshot.root][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_39);
    assert {:msg "  47.4: The precondition at 126.12 might not hold. The permission at 126.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  47.4: The precondition at 126.12 might not hold. Insufficient fraction at 126.12 for SortedTreeSnapshot.keys."} (Fractions(100) <= exhaleMask#_39[this#34, SortedTreeSnapshot.keys][perm$R]) && ((Fractions(100) == exhaleMask#_39[this#34, SortedTreeSnapshot.keys][perm$R]) ==> (0 <= exhaleMask#_39[this#34, SortedTreeSnapshot.keys][perm$N]));
    exhaleMask#_39[this#34, SortedTreeSnapshot.keys] := exhaleMask#_39[this#34, SortedTreeSnapshot.keys][perm$R := exhaleMask#_39[this#34, SortedTreeSnapshot.keys][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_39);
    if (!(treeRoot#35 == null)) {
      assert {:msg "  47.4: The precondition at 128.12 might not hold. The permission at 128.31 might not be positive."} Fractions(1) > 0;
      assert {:msg "  47.4: The precondition at 128.12 might not hold. Insufficient fraction at 128.31 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_39[treeRoot#35, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_39[treeRoot#35, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_39[treeRoot#35, SortedTreeNode.valid][perm$N]));
      exhaleMask#_39[treeRoot#35, SortedTreeNode.valid] := exhaleMask#_39[treeRoot#35, SortedTreeNode.valid][perm$R := exhaleMask#_39[treeRoot#35, SortedTreeNode.valid][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_39);
    } else {
    }
    if (!(treeRoot#35 == null)) {
      assert {:msg "  47.4: The precondition at 129.12 might not hold. The permission at 129.31 might not be positive."} Fractions(1) > 0;
      assert {:msg "  47.4: The precondition at 129.12 might not hold. Insufficient fraction at 129.31 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_39[treeRoot#35, SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_39[treeRoot#35, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_39[treeRoot#35, SortedTreeNode.keys][perm$N]));
      exhaleMask#_39[treeRoot#35, SortedTreeNode.keys] := exhaleMask#_39[treeRoot#35, SortedTreeNode.keys][perm$R := exhaleMask#_39[treeRoot#35, SortedTreeNode.keys][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_39);
    } else {
    }
    Mask := exhaleMask#_39;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (postcondition)
    havoc inhaleHeap#_46;
    assume IsGoodInhaleState(inhaleHeap#_46, Heap, Mask);
    assume this#34 != null;
    Heap[this#34, SortedTreeSnapshot.valid] := inhaleHeap#_46[this#34, SortedTreeSnapshot.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_46[this#34, SortedTreeSnapshot.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this#34, SortedTreeSnapshot.valid] := Mask[this#34, SortedTreeSnapshot.valid][perm$R := Mask[this#34, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_46[this#34, SortedTreeSnapshot.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_46, Mask);
    assume this#34 != null;
    Heap[this#34, SortedTreeSnapshot.keys] := inhaleHeap#_46[this#34, SortedTreeSnapshot.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50) > 0;
    Mask[this#34, SortedTreeSnapshot.keys] := Mask[this#34, SortedTreeSnapshot.keys][perm$R := Mask[this#34, SortedTreeSnapshot.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_46[this#34, SortedTreeSnapshot.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_46, Mask);
    if (!(treeRoot#35 == null)) {
      assume Seq#Equal(Heap[this#34, SortedTreeSnapshot.keys], callHeap#_35[treeRoot#35, SortedTreeNode.keys]);
    } else {
    }
    if (treeRoot#35 == null) {
      assume Seq#Equal(Heap[this#34, SortedTreeSnapshot.keys], Seq#Empty());
    } else {
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    // update field numClones
    assert {:msg "  48.4: Location might not be writable"} CanWrite(Mask, this, SortedTree.numClones);
    assert {:msg "  48.17: Receiver might be null."} true ==> (this != null);
    assert {:msg "  48.17: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.numClones);
    Heap[this, SortedTree.numClones] := Heap[this, SortedTree.numClones] + 1;
    assume wf(Heap, Mask);
    // fold
    assume (0 < foldK#_47) && ((1000 * foldK#_47) < Fractions(1)) && ((1000 * foldK#_47) < methodK#_26);
    assert {:msg "  49.4: The target of the fold statement might be null."} this != null;
    // begin exhale (fold)
    exhaleMask#_48 := Mask;
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true."} Heap[this, SortedTree.numClones] >= 0;
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true."} Heap[this, SortedTree.numClones] < 50;
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
    } else {
    }
    if (Heap[this, SortedTree.root] == null) {
      assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
    } else {
    }
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root."} (Fractions(100) <= exhaleMask#_48[this, SortedTree.root][perm$R]) && ((Fractions(100) == exhaleMask#_48[this, SortedTree.root][perm$R]) ==> (0 <= exhaleMask#_48[this, SortedTree.root][perm$N]));
    exhaleMask#_48[this, SortedTree.root] := exhaleMask#_48[this, SortedTree.root][perm$R := exhaleMask#_48[this, SortedTree.root][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_48);
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive."} Fractions(50) > 0;
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys."} (Fractions(50) <= exhaleMask#_48[this, SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_48[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_48[this, SortedTree.keys][perm$N]));
    exhaleMask#_48[this, SortedTree.keys] := exhaleMask#_48[this, SortedTree.keys][perm$R := exhaleMask#_48[this, SortedTree.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_48);
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones."} (Fractions(100) <= exhaleMask#_48[this, SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_48[this, SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_48[this, SortedTree.numClones][perm$N]));
    exhaleMask#_48[this, SortedTree.numClones] := exhaleMask#_48[this, SortedTree.numClones][perm$R := exhaleMask#_48[this, SortedTree.numClones][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_48);
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive."} (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
      assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid."} ((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) <= exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) == exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$N]));
      exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.valid] := exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_48);
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive."} Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
      assert {:msg "  49.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys."} (Fractions(50 - Heap[this, SortedTree.numClones]) <= exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap[this, SortedTree.numClones]) == exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$N]));
      exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.keys] := exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := exhaleMask#_48[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] - Fractions(50 - Heap[this, SortedTree.numClones])];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_48);
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (Heap[this, SortedTree.root] == null) {
    } else {
    }
    Mask := exhaleMask#_48;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_54;
    assume IsGoodInhaleState(inhaleHeap#_54, Heap, Mask);
    assume this != null;
    Heap[this, SortedTree.valid] := inhaleHeap#_54[this, SortedTree.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_54[this, SortedTree.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_54[this, SortedTree.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_54, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[this, SortedTree.valid] := Heap;
    assume wf(Heap, Mask);
  } else {
    // assume
    assume false;
  }
  // begin exhale (postcondition)
  exhaleMask#_55 := Mask;
  assert {:msg "  40.2: The postcondition at 42.11 might not hold. The permission at 42.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  40.2: The postcondition at 42.11 might not hold. Insufficient fraction at 42.11 for SortedTree.valid."} (Fractions(100) <= exhaleMask#_55[this, SortedTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_55[this, SortedTree.valid][perm$R]) ==> (0 <= exhaleMask#_55[this, SortedTree.valid][perm$N]));
  exhaleMask#_55[this, SortedTree.valid] := exhaleMask#_55[this, SortedTree.valid][perm$R := exhaleMask#_55[this, SortedTree.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_55);
  Mask := exhaleMask#_55;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  40.2: Method might lock/unlock more than allowed."} (forall lk#_57: ref :: {Heap[lk#_57, held]} {Heap[lk#_57, rdheld]} (((0 < Heap[lk#_57, held]) == (0 < old(Heap)[lk#_57, held])) && (Heap[lk#_57, rdheld] == old(Heap)[lk#_57, rdheld])) || false);
  assert {:msg "  40.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure SortedTree.insert$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTree#t), k#1: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_58: int;
  var inhaleHeap#_59: HeapType;
  var inhaleHeap#_60: HeapType;
  var j#25#37: int where true;
  var j#26#39: int where true;
  assume (0 < methodK#_58) && ((1000 * methodK#_58) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_59;
  assume IsGoodInhaleState(inhaleHeap#_59, Heap, Mask);
  assert {:msg "  58.12: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_59[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_59[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_59[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_59, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_59[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_59[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_59, Mask);
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
  havoc inhaleHeap#_60;
  assume IsGoodInhaleState(inhaleHeap#_60, Heap, Mask);
  assert {:msg "  61.11: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_60[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_60[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_60[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_60, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_60[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_60[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_60, Mask);
  assert {:msg "  64.16: Receiver might be null."} true ==> (this != null);
  assert {:msg "  64.16: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.keys);
  assume Seq#Contains(Heap[this, SortedTree.keys], k#1);
  assert {:msg "  65.11: Receiver might be null."} true && (0 <= j#25#37) ==> (this != null);
  assert {:msg "  65.11: Location might not be readable."} true && (0 <= j#25#37) ==> CanRead(old(Mask), this, SortedTree.keys);
  assert {:msg "  65.11: Receiver might be null."} true && (0 <= j#25#37) && (j#25#37 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> (this != null);
  assert {:msg "  65.11: Location might not be readable."} true && (0 <= j#25#37) && (j#25#37 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> CanRead(old(Mask), this, SortedTree.keys);
  assert {:msg "  65.36: Sequence index might be negative."} true && (0 <= j#25#37) && (j#25#37 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> (0 <= j#25#37);
  assert {:msg "  65.36: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= j#25#37) && (j#25#37 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> (j#25#37 < Seq#Length(old(Heap)[this, SortedTree.keys]));
  assert {:msg "  65.41: Receiver might be null."} true && (0 <= j#25#37) && (j#25#37 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> (this != null);
  assert {:msg "  65.41: Location might not be readable."} true && (0 <= j#25#37) && (j#25#37 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> CanRead(Mask, this, SortedTree.keys);
  assume (forall j#25#36: int :: (0 <= j#25#36) && (j#25#36 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> Seq#Contains(Heap[this, SortedTree.keys], Seq#Index(old(Heap)[this, SortedTree.keys], j#25#36)));
  assert {:msg "  66.11: Receiver might be null."} true && (0 <= j#26#39) ==> (this != null);
  assert {:msg "  66.11: Location might not be readable."} true && (0 <= j#26#39) ==> CanRead(Mask, this, SortedTree.keys);
  assert {:msg "  66.11: Receiver might be null."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) ==> (this != null);
  assert {:msg "  66.11: Location might not be readable."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) ==> CanRead(Mask, this, SortedTree.keys);
  assert {:msg "  66.33: Sequence index might be negative."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) ==> (0 <= j#26#39);
  assert {:msg "  66.33: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) ==> (j#26#39 < Seq#Length(Heap[this, SortedTree.keys]));
  assert {:msg "  66.42: Receiver might be null."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) ==> (this != null);
  assert {:msg "  66.42: Location might not be readable."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) ==> CanRead(old(Mask), this, SortedTree.keys);
  assert {:msg "  66.11: Receiver might be null."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) && (!Seq#Contains(old(Heap)[this, SortedTree.keys], Seq#Index(Heap[this, SortedTree.keys], j#26#39))) ==> (this != null);
  assert {:msg "  66.11: Location might not be readable."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) && (!Seq#Contains(old(Heap)[this, SortedTree.keys], Seq#Index(Heap[this, SortedTree.keys], j#26#39))) ==> CanRead(Mask, this, SortedTree.keys);
  assert {:msg "  66.33: Sequence index might be negative."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) && (!Seq#Contains(old(Heap)[this, SortedTree.keys], Seq#Index(Heap[this, SortedTree.keys], j#26#39))) ==> (0 <= j#26#39);
  assert {:msg "  66.33: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= j#26#39) && (j#26#39 < Seq#Length(Heap[this, SortedTree.keys])) && (!Seq#Contains(old(Heap)[this, SortedTree.keys], Seq#Index(Heap[this, SortedTree.keys], j#26#39))) ==> (j#26#39 < Seq#Length(Heap[this, SortedTree.keys]));
  assume (forall j#26#38: int :: (0 <= j#26#38) && (j#26#38 < Seq#Length(Heap[this, SortedTree.keys])) ==> (Seq#Contains(old(Heap)[this, SortedTree.keys], Seq#Index(Heap[this, SortedTree.keys], j#26#38)) || (Seq#Index(Heap[this, SortedTree.keys], j#26#38) == k#1)));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTree.insert(this: ref where (this == null) || (dtype(this) == SortedTree#t), k#1: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_58: int;
  var inhaleHeap#_61: HeapType;
  var unfoldK#_62: int;
  var exhaleMask#_63: MaskType;
  var inhaleHeap#_65: HeapType;
  var n#3: ref where (n#3 == null) || (dtype(n#3) == SortedTreeNode#t);
  var nw#_66: ref;
  var methodCallK#_70: int;
  var this#40: ref where (this#40 == null) || (dtype(this#40) == SortedTreeNode#t);
  var k#41: int where true;
  var callHeap#_67: HeapType;
  var callMask#_68: MaskType;
  var callCredits#_69: CreditsType;
  var exhaleMask#_71: MaskType;
  var isHeld#_77: int;
  var isRdHeld#_78: bool;
  var inhaleHeap#_79: HeapType;
  var r#5: ref where (r#5 == null) || (dtype(r#5) == SortedTreeNode#t);
  var r#20: ref where (r#5 == null) || (dtype(r#5) == SortedTreeNode#t);
  var methodCallK#_83: int;
  var this#42: ref where (this#42 == null) || (dtype(this#42) == SortedTreeNode#t);
  var k#43: int where true;
  var hasClones#44: bool where true;
  var r#45: ref where (r#45 == null) || (dtype(r#45) == SortedTreeNode#t);
  var callHeap#_80: HeapType;
  var callMask#_81: MaskType;
  var callCredits#_82: CreditsType;
  var exhaleMask#_84: MaskType;
  var isHeld#_91: int;
  var isRdHeld#_92: bool;
  var inhaleHeap#_93: HeapType;
  var foldK#_94: int;
  var exhaleMask#_95: MaskType;
  var inhaleHeap#_101: HeapType;
  var exhaleMask#_102: MaskType;
  assume (0 < methodK#_58) && ((1000 * methodK#_58) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_61;
  assume IsGoodInhaleState(inhaleHeap#_61, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_61[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_61[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_61[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_61, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_61[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_61[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_61, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assume (0 < unfoldK#_62) && (unfoldK#_62 < Fractions(1)) && ((1000 * unfoldK#_62) < methodK#_58);
  assert {:msg "  68.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_63 := Mask;
  assert {:msg "  68.3: unfold might fail because the predicate SortedTree.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  68.3: unfold might fail because the predicate SortedTree.valid does not hold. Insufficient fraction at <undefined position> for SortedTree.valid."} (Fractions(100) <= exhaleMask#_63[this, SortedTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_63[this, SortedTree.valid][perm$R]) ==> (0 <= exhaleMask#_63[this, SortedTree.valid][perm$N]));
  exhaleMask#_63[this, SortedTree.valid] := exhaleMask#_63[this, SortedTree.valid][perm$R := exhaleMask#_63[this, SortedTree.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_63);
  Mask := exhaleMask#_63;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_65 := Heap[this, SortedTree.valid];
  assume IsGoodInhaleState(inhaleHeap#_65, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.root] := inhaleHeap#_65[this, SortedTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTree.root] == null) || (dtype(Heap[this, SortedTree.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTree.root] := Mask[this, SortedTree.root][perm$R := Mask[this, SortedTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_65[this, SortedTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_65, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_65[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_65[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_65, Mask);
  assume this != null;
  Heap[this, SortedTree.numClones] := inhaleHeap#_65[this, SortedTree.numClones];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.numClones] := Mask[this, SortedTree.numClones][perm$R := Mask[this, SortedTree.numClones][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_65[this, SortedTree.numClones]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_65, Mask);
  assume Heap[this, SortedTree.numClones] >= 0;
  assume Heap[this, SortedTree.numClones] < 50;
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.valid] := inhaleHeap#_65[Heap[this, SortedTree.root], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_65[Heap[this, SortedTree.root], SortedTreeNode.valid] == Heap;
    assume (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.valid] := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] + (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_65[Heap[this, SortedTree.root], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_65, Mask);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.keys] := inhaleHeap#_65[Heap[this, SortedTree.root], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.keys] := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] + Fractions(50 - Heap[this, SortedTree.numClones])];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_65[Heap[this, SortedTree.root], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_65, Mask);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
  } else {
  }
  if (Heap[this, SortedTree.root] == null) {
    assume Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // if
  assert {:msg "  69.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  69.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
  if (Heap[this, SortedTree.root] == null) {
    // local var n
    // assigment to n
    // new
    havoc nw#_66;
    assume (nw#_66 != null) && (dtype(nw#_66) == SortedTreeNode#t);
    assume (forall<T#_1> f: Field (T#_1) :: (Mask[nw#_66, f][perm$R] == 0) && (Mask[nw#_66, f][perm$N] == 0));
    assume Heap[nw#_66, mu] == $LockBottom;
    assume Heap[nw#_66, held] <= 0;
    assume Heap[nw#_66, rdheld] == false;
    Mask[nw#_66, SortedTreeNode.key] := Mask[nw#_66, SortedTreeNode.key][perm$R := Mask[nw#_66, SortedTreeNode.key][perm$R] + Fractions(100)];
    Mask[nw#_66, SortedTreeNode.left] := Mask[nw#_66, SortedTreeNode.left][perm$R := Mask[nw#_66, SortedTreeNode.left][perm$R] + Fractions(100)];
    Mask[nw#_66, SortedTreeNode.right] := Mask[nw#_66, SortedTreeNode.right][perm$R := Mask[nw#_66, SortedTreeNode.right][perm$R] + Fractions(100)];
    Mask[nw#_66, SortedTreeNode.keys] := Mask[nw#_66, SortedTreeNode.keys][perm$R := Mask[nw#_66, SortedTreeNode.keys][perm$R] + Fractions(100)];
    Mask[nw#_66, SortedTreeNode.shared] := Mask[nw#_66, SortedTreeNode.shared][perm$R := Mask[nw#_66, SortedTreeNode.shared][perm$R] + Fractions(100)];
    Mask[nw#_66, mu] := Mask[nw#_66, mu][perm$R := Mask[nw#_66, mu][perm$R] + Fractions(100)];
    n#3 := nw#_66;
    assume (0 < methodCallK#_70) && ((1000 * methodCallK#_70) < Fractions(1)) && ((1000 * methodCallK#_70) < methodK#_58);
    // call init
    callHeap#_67 := Heap;
    callMask#_68 := Mask;
    callCredits#_69 := Credits;
    assert {:msg "  71.4: The target of the method call might be null."} n#3 != null;
    this#40 := n#3;
    k#41 := k#1;
    // begin exhale (precondition)
    exhaleMask#_71 := Mask;
    assert {:msg "  71.4: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  71.4: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_71[this#40, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_71[this#40, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_71[this#40, SortedTreeNode.key][perm$N]));
    exhaleMask#_71[this#40, SortedTreeNode.key] := exhaleMask#_71[this#40, SortedTreeNode.key][perm$R := exhaleMask#_71[this#40, SortedTreeNode.key][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_71);
    assert {:msg "  71.4: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  71.4: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_71[this#40, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_71[this#40, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_71[this#40, SortedTreeNode.left][perm$N]));
    exhaleMask#_71[this#40, SortedTreeNode.left] := exhaleMask#_71[this#40, SortedTreeNode.left][perm$R := exhaleMask#_71[this#40, SortedTreeNode.left][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_71);
    assert {:msg "  71.4: The precondition at 258.12 might not hold. The permission at 258.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  71.4: The precondition at 258.12 might not hold. Insufficient fraction at 258.12 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_71[this#40, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_71[this#40, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_71[this#40, SortedTreeNode.right][perm$N]));
    exhaleMask#_71[this#40, SortedTreeNode.right] := exhaleMask#_71[this#40, SortedTreeNode.right][perm$R := exhaleMask#_71[this#40, SortedTreeNode.right][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_71);
    assert {:msg "  71.4: The precondition at 260.12 might not hold. The permission at 260.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  71.4: The precondition at 260.12 might not hold. Insufficient fraction at 260.12 for SortedTreeNode.keys."} (Fractions(100) <= exhaleMask#_71[this#40, SortedTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_71[this#40, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_71[this#40, SortedTreeNode.keys][perm$N]));
    exhaleMask#_71[this#40, SortedTreeNode.keys] := exhaleMask#_71[this#40, SortedTreeNode.keys][perm$R := exhaleMask#_71[this#40, SortedTreeNode.keys][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_71);
    assert {:msg "  71.4: The precondition at 261.12 might not hold. The permission at 261.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  71.4: The precondition at 261.12 might not hold. Insufficient fraction at 261.12 for SortedTreeNode.shared."} (Fractions(100) <= exhaleMask#_71[this#40, SortedTreeNode.shared][perm$R]) && ((Fractions(100) == exhaleMask#_71[this#40, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_71[this#40, SortedTreeNode.shared][perm$N]));
    exhaleMask#_71[this#40, SortedTreeNode.shared] := exhaleMask#_71[this#40, SortedTreeNode.shared][perm$R := exhaleMask#_71[this#40, SortedTreeNode.shared][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_71);
    Mask := exhaleMask#_71;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (postcondition)
    havoc inhaleHeap#_79;
    assume IsGoodInhaleState(inhaleHeap#_79, Heap, Mask);
    assume this#40 != null;
    Heap[this#40, SortedTreeNode.valid] := inhaleHeap#_79[this#40, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_79[this#40, SortedTreeNode.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this#40, SortedTreeNode.valid] := Mask[this#40, SortedTreeNode.valid][perm$R := Mask[this#40, SortedTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_79[this#40, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_79, Mask);
    assume this#40 != null;
    Heap[this#40, SortedTreeNode.keys] := inhaleHeap#_79[this#40, SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50) > 0;
    Mask[this#40, SortedTreeNode.keys] := Mask[this#40, SortedTreeNode.keys][perm$R := Mask[this#40, SortedTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_79[this#40, SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_79, Mask);
    assume this#40 != null;
    Heap[this#40, SortedTreeNode.shared] := inhaleHeap#_79[this#40, SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50) > 0;
    Mask[this#40, SortedTreeNode.shared] := Mask[this#40, SortedTreeNode.shared][perm$R := Mask[this#40, SortedTreeNode.shared][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_79[this#40, SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_79, Mask);
    assume !Heap[this#40, SortedTreeNode.shared];
    assume Seq#Equal(Heap[this#40, SortedTreeNode.keys], Seq#Singleton(k#41));
    assume Seq#Contains(Heap[this#40, SortedTreeNode.keys], k#41);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    // update field root
    assert {:msg "  72.4: Location might not be writable"} CanWrite(Mask, this, SortedTree.root);
    Heap[this, SortedTree.root] := n#3;
    assume wf(Heap, Mask);
  } else {
    // local var r
    assume (0 < methodCallK#_83) && ((1000 * methodCallK#_83) < Fractions(1)) && ((1000 * methodCallK#_83) < methodK#_58);
    // call insert
    callHeap#_80 := Heap;
    callMask#_81 := Mask;
    callCredits#_82 := Credits;
    assert {:msg "  75.14: Receiver might be null."} true ==> (this != null);
    assert {:msg "  75.14: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
    assert {:msg "  75.4: The target of the method call might be null."} Heap[this, SortedTree.root] != null;
    assert {:msg "  75.28: Receiver might be null."} true ==> (this != null);
    assert {:msg "  75.28: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.numClones);
    this#42 := Heap[this, SortedTree.root];
    k#43 := k#1;
    hasClones#44 := Heap[this, SortedTree.numClones] > 0;
    // begin exhale (precondition)
    exhaleMask#_84 := Mask;
    if (!hasClones#44) {
    } else {
    }
    if (hasClones#44) {
    } else {
    }
    assert {:msg "  75.4: The precondition at 329.12 might not hold. The expression at 329.12 might not evaluate to true."} hasClones#44 == Heap[this#42, SortedTreeNode.shared];
    if (!hasClones#44) {
    } else {
    }
    if (hasClones#44) {
    } else {
    }
    if (!hasClones#44) {
      assert {:msg "  75.4: The precondition at 325.12 might not hold. The permission at 325.27 might not be positive."} Fractions(100) > 0;
      assert {:msg "  75.4: The precondition at 325.12 might not hold. Insufficient fraction at 325.27 for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84[this#42, SortedTreeNode.valid][perm$N]));
      exhaleMask#_84[this#42, SortedTreeNode.valid] := exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R := exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R] - Fractions(100)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_84);
    } else {
    }
    if (hasClones#44) {
      assert {:msg "  75.4: The precondition at 326.12 might not hold. The permission at 326.26 might not be positive."} Fractions(1) > 0;
      assert {:msg "  75.4: The precondition at 326.12 might not hold. Insufficient fraction at 326.26 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84[this#42, SortedTreeNode.valid][perm$N]));
      exhaleMask#_84[this#42, SortedTreeNode.valid] := exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R := exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_84);
    } else {
    }
    assert {:msg "  75.4: The precondition at 327.12 might not hold. The permission at 327.12 might not be positive."} Fractions(50 - ite(hasClones#44, 49, 0)) > 0;
    assert {:msg "  75.4: The precondition at 327.12 might not hold. Insufficient fraction at 327.12 for SortedTreeNode.valid."} (Fractions(50 - ite(hasClones#44, 49, 0)) <= exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R]) && ((Fractions(50 - ite(hasClones#44, 49, 0)) == exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84[this#42, SortedTreeNode.valid][perm$N]));
    exhaleMask#_84[this#42, SortedTreeNode.valid] := exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R := exhaleMask#_84[this#42, SortedTreeNode.valid][perm$R] - Fractions(50 - ite(hasClones#44, 49, 0))];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_84);
    assert {:msg "  75.4: The precondition at 328.12 might not hold. The permission at 328.12 might not be positive."} Fractions(50 - ite(hasClones#44, 49, 0)) > 0;
    assert {:msg "  75.4: The precondition at 328.12 might not hold. Insufficient fraction at 328.12 for SortedTreeNode.keys."} (Fractions(50 - ite(hasClones#44, 49, 0)) <= exhaleMask#_84[this#42, SortedTreeNode.keys][perm$R]) && ((Fractions(50 - ite(hasClones#44, 49, 0)) == exhaleMask#_84[this#42, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_84[this#42, SortedTreeNode.keys][perm$N]));
    exhaleMask#_84[this#42, SortedTreeNode.keys] := exhaleMask#_84[this#42, SortedTreeNode.keys][perm$R := exhaleMask#_84[this#42, SortedTreeNode.keys][perm$R] - Fractions(50 - ite(hasClones#44, 49, 0))];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_84);
    if (!hasClones#44) {
      assert {:msg "  75.4: The precondition at 332.12 might not hold. The permission at 332.27 might not be positive."} Fractions(100) > 0;
      assert {:msg "  75.4: The precondition at 332.12 might not hold. Insufficient fraction at 332.27 for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84[r#20, SortedTreeNode.valid][perm$N]));
      exhaleMask#_84[r#20, SortedTreeNode.valid] := exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R] - Fractions(100)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_84);
    } else {
    }
    if (hasClones#44) {
      assert {:msg "  75.4: The precondition at 333.12 might not hold. The permission at 333.26 might not be positive."} Fractions(1) > 0;
      assert {:msg "  75.4: The precondition at 333.12 might not hold. Insufficient fraction at 333.26 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84[r#20, SortedTreeNode.valid][perm$N]));
      exhaleMask#_84[r#20, SortedTreeNode.valid] := exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_84[r#20, SortedTreeNode.valid][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_84);
    } else {
    }
    Mask := exhaleMask#_84;
    assume wf(Heap, Mask);
    // end exhale
    havoc r#45;
    // inhale (postcondition)
    havoc inhaleHeap#_93;
    assume IsGoodInhaleState(inhaleHeap#_93, Heap, Mask);
    assume !(r#45 == null);
    assume r#45 != null;
    Heap[r#45, SortedTreeNode.keys] := inhaleHeap#_93[r#45, SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50 - ite(hasClones#44, 49, 0)) > 0;
    Mask[r#45, SortedTreeNode.keys] := Mask[r#45, SortedTreeNode.keys][perm$R := Mask[r#45, SortedTreeNode.keys][perm$R] + Fractions(50 - ite(hasClones#44, 49, 0))];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_93[r#45, SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_93, Mask);
    assume Seq#Contains(Heap[r#45, SortedTreeNode.keys], k#43);
    assume (forall i#32#46: int :: (0 <= i#32#46) && (i#32#46 < Seq#Length(callHeap#_80[this#42, SortedTreeNode.keys])) ==> Seq#Contains(Heap[r#45, SortedTreeNode.keys], Seq#Index(callHeap#_80[this#42, SortedTreeNode.keys], i#32#46)));
    assume (forall i#33#47: int :: (0 <= i#33#47) && (i#33#47 < Seq#Length(Heap[r#45, SortedTreeNode.keys])) ==> (Seq#Contains(callHeap#_80[this#42, SortedTreeNode.keys], Seq#Index(Heap[r#45, SortedTreeNode.keys], i#33#47)) || (Seq#Index(Heap[r#45, SortedTreeNode.keys], i#33#47) == k#43)));
    if (Seq#Contains(callHeap#_80[this#42, SortedTreeNode.keys], k#43)) {
      assume Seq#Equal(Heap[r#45, SortedTreeNode.keys], callHeap#_80[this#42, SortedTreeNode.keys]);
    } else {
    }
    if (!Seq#Contains(callHeap#_80[this#42, SortedTreeNode.keys], k#43)) {
      assume Seq#Length(Heap[r#45, SortedTreeNode.keys]) == (Seq#Length(callHeap#_80[this#42, SortedTreeNode.keys]) + 1);
    } else {
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    r#5 := r#45;
    // update field root
    assert {:msg "  76.4: Location might not be writable"} CanWrite(Mask, this, SortedTree.root);
    Heap[this, SortedTree.root] := r#5;
    assume wf(Heap, Mask);
  }
  // update field keys
  assert {:msg "  78.3: Location might not be writable"} CanWrite(Mask, this, SortedTree.keys);
  assert {:msg "  78.11: Receiver might be null."} true ==> (this != null);
  assert {:msg "  78.11: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
  assert {:msg "  78.11: Receiver might be null."} true ==> (Heap[this, SortedTree.root] != null);
  assert {:msg "  78.11: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTree.root], SortedTreeNode.keys);
  Heap[this, SortedTree.keys] := Heap[Heap[this, SortedTree.root], SortedTreeNode.keys];
  assume wf(Heap, Mask);
  // fold
  assume (0 < foldK#_94) && ((1000 * foldK#_94) < Fractions(1)) && ((1000 * foldK#_94) < methodK#_58);
  assert {:msg "  79.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_95 := Mask;
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true."} Heap[this, SortedTree.numClones] >= 0;
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true."} Heap[this, SortedTree.numClones] < 50;
  if (!(Heap[this, SortedTree.root] == null)) {
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
  } else {
  }
  if (Heap[this, SortedTree.root] == null) {
    assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  } else {
  }
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root."} (Fractions(100) <= exhaleMask#_95[this, SortedTree.root][perm$R]) && ((Fractions(100) == exhaleMask#_95[this, SortedTree.root][perm$R]) ==> (0 <= exhaleMask#_95[this, SortedTree.root][perm$N]));
  exhaleMask#_95[this, SortedTree.root] := exhaleMask#_95[this, SortedTree.root][perm$R := exhaleMask#_95[this, SortedTree.root][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_95);
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive."} Fractions(50) > 0;
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys."} (Fractions(50) <= exhaleMask#_95[this, SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_95[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_95[this, SortedTree.keys][perm$N]));
  exhaleMask#_95[this, SortedTree.keys] := exhaleMask#_95[this, SortedTree.keys][perm$R := exhaleMask#_95[this, SortedTree.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_95);
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones."} (Fractions(100) <= exhaleMask#_95[this, SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_95[this, SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_95[this, SortedTree.numClones][perm$N]));
  exhaleMask#_95[this, SortedTree.numClones] := exhaleMask#_95[this, SortedTree.numClones][perm$R := exhaleMask#_95[this, SortedTree.numClones][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_95);
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive."} (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
    assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid."} ((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) <= exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) == exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$N]));
    exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.valid] := exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_95);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive."} Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
    assert {:msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys."} (Fractions(50 - Heap[this, SortedTree.numClones]) <= exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap[this, SortedTree.numClones]) == exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$N]));
    exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.keys] := exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := exhaleMask#_95[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] - Fractions(50 - Heap[this, SortedTree.numClones])];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_95);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
  } else {
  }
  if (Heap[this, SortedTree.root] == null) {
  } else {
  }
  Mask := exhaleMask#_95;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_101;
  assume IsGoodInhaleState(inhaleHeap#_101, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_101[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_101[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_101[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_101, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, SortedTree.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_102 := Mask;
  assert {:msg "  57.2: The postcondition at 64.11 might not hold. The expression at 64.11 might not evaluate to true."} Seq#Contains(Heap[this, SortedTree.keys], k#1);
  assert {:msg "  57.2: The postcondition at 65.11 might not hold. The expression at 65.11 might not evaluate to true."} (forall j#25#48: int :: (0 <= j#25#48) && (j#25#48 < Seq#Length(old(Heap)[this, SortedTree.keys])) ==> Seq#Contains(Heap[this, SortedTree.keys], Seq#Index(old(Heap)[this, SortedTree.keys], j#25#48)));
  assert {:msg "  57.2: The postcondition at 66.11 might not hold. The expression at 66.11 might not evaluate to true."} (forall j#26#49: int :: (0 <= j#26#49) && (j#26#49 < Seq#Length(Heap[this, SortedTree.keys])) ==> (Seq#Contains(old(Heap)[this, SortedTree.keys], Seq#Index(Heap[this, SortedTree.keys], j#26#49)) || (Seq#Index(Heap[this, SortedTree.keys], j#26#49) == k#1)));
  assert {:msg "  57.2: The postcondition at 61.11 might not hold. The permission at 61.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  57.2: The postcondition at 61.11 might not hold. Insufficient fraction at 61.11 for SortedTree.valid."} (Fractions(100) <= exhaleMask#_102[this, SortedTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_102[this, SortedTree.valid][perm$R]) ==> (0 <= exhaleMask#_102[this, SortedTree.valid][perm$N]));
  exhaleMask#_102[this, SortedTree.valid] := exhaleMask#_102[this, SortedTree.valid][perm$R := exhaleMask#_102[this, SortedTree.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_102);
  assert {:msg "  57.2: The postcondition at 62.11 might not hold. The permission at 62.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  57.2: The postcondition at 62.11 might not hold. Insufficient fraction at 62.11 for SortedTree.keys."} (Fractions(50) <= exhaleMask#_102[this, SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_102[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_102[this, SortedTree.keys][perm$N]));
  exhaleMask#_102[this, SortedTree.keys] := exhaleMask#_102[this, SortedTree.keys][perm$R := exhaleMask#_102[this, SortedTree.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_102);
  Mask := exhaleMask#_102;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  57.2: Method might lock/unlock more than allowed."} (forall lk#_105: ref :: {Heap[lk#_105, held]} {Heap[lk#_105, rdheld]} (((0 < Heap[lk#_105, held]) == (0 < old(Heap)[lk#_105, held])) && (Heap[lk#_105, rdheld] == old(Heap)[lk#_105, rdheld])) || false);
  assert {:msg "  57.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure SortedTree.has$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTree#t), k#6: int where true) returns (b#7: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_106: int;
  var inhaleHeap#_107: HeapType;
  var inhaleHeap#_108: HeapType;
  assume (0 < methodK#_106) && ((1000 * methodK#_106) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_107;
  assume IsGoodInhaleState(inhaleHeap#_107, Heap, Mask);
  assert {:msg "  85.12: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_107[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_107[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_107[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_107, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_107[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume methodK#_106 > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + methodK#_106];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_107[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_107, Mask);
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
  havoc inhaleHeap#_108;
  assume IsGoodInhaleState(inhaleHeap#_108, Heap, Mask);
  assert {:msg "  88.11: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_108[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_108[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_108[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_108, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_108[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume methodK#_106 > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + methodK#_106];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_108[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_108, Mask);
  assert {:msg "  90.22: Receiver might be null."} true ==> (this != null);
  assert {:msg "  90.22: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.keys);
  assume b#7 == Seq#Contains(Heap[this, SortedTree.keys], k#6);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTree.has(this: ref where (this == null) || (dtype(this) == SortedTree#t), k#6: int where true) returns (b#7: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_106: int;
  var inhaleHeap#_109: HeapType;
  var unfoldK#_110: int;
  var exhaleMask#_111: MaskType;
  var inhaleHeap#_113: HeapType;
  var foldK#_114: int;
  var exhaleMask#_115: MaskType;
  var inhaleHeap#_121: HeapType;
  var bb#9: bool where true;
  var methodCallK#_125: int;
  var this#52: ref where (this#52 == null) || (dtype(this#52) == SortedTreeNode#t);
  var k#53: int where true;
  var b#54: bool where true;
  var callHeap#_122: HeapType;
  var callMask#_123: MaskType;
  var callCredits#_124: CreditsType;
  var exhaleMask#_126: MaskType;
  var isHeld#_129: int;
  var isRdHeld#_130: bool;
  var inhaleHeap#_131: HeapType;
  var foldK#_132: int;
  var exhaleMask#_133: MaskType;
  var inhaleHeap#_139: HeapType;
  var exhaleMask#_140: MaskType;
  assume (0 < methodK#_106) && ((1000 * methodK#_106) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_109;
  assume IsGoodInhaleState(inhaleHeap#_109, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.valid] := inhaleHeap#_109[this, SortedTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_109[this, SortedTree.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_109[this, SortedTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_109, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_109[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume methodK#_106 > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + methodK#_106];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_109[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_109, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assume (0 < unfoldK#_110) && (unfoldK#_110 < Fractions(1)) && ((1000 * unfoldK#_110) < methodK#_106);
  assert {:msg "  92.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_111 := Mask;
  assert {:msg "  92.3: unfold might fail because the predicate SortedTree.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  92.3: unfold might fail because the predicate SortedTree.valid does not hold. Insufficient fraction at <undefined position> for SortedTree.valid."} (Fractions(100) <= exhaleMask#_111[this, SortedTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_111[this, SortedTree.valid][perm$R]) ==> (0 <= exhaleMask#_111[this, SortedTree.valid][perm$N]));
  exhaleMask#_111[this, SortedTree.valid] := exhaleMask#_111[this, SortedTree.valid][perm$R := exhaleMask#_111[this, SortedTree.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_111);
  Mask := exhaleMask#_111;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_113 := Heap[this, SortedTree.valid];
  assume IsGoodInhaleState(inhaleHeap#_113, Heap, Mask);
  assume this != null;
  Heap[this, SortedTree.root] := inhaleHeap#_113[this, SortedTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTree.root] == null) || (dtype(Heap[this, SortedTree.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTree.root] := Mask[this, SortedTree.root][perm$R := Mask[this, SortedTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_113[this, SortedTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_113, Mask);
  assume this != null;
  Heap[this, SortedTree.keys] := inhaleHeap#_113[this, SortedTree.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTree.keys] := Mask[this, SortedTree.keys][perm$R := Mask[this, SortedTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_113[this, SortedTree.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_113, Mask);
  assume this != null;
  Heap[this, SortedTree.numClones] := inhaleHeap#_113[this, SortedTree.numClones];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTree.numClones] := Mask[this, SortedTree.numClones][perm$R := Mask[this, SortedTree.numClones][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_113[this, SortedTree.numClones]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_113, Mask);
  assume Heap[this, SortedTree.numClones] >= 0;
  assume Heap[this, SortedTree.numClones] < 50;
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.valid] := inhaleHeap#_113[Heap[this, SortedTree.root], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_113[Heap[this, SortedTree.root], SortedTreeNode.valid] == Heap;
    assume (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.valid] := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] + (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_113[Heap[this, SortedTree.root], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_113, Mask);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Heap[this, SortedTree.root] != null;
    Heap[Heap[this, SortedTree.root], SortedTreeNode.keys] := inhaleHeap#_113[Heap[this, SortedTree.root], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
    Mask[Heap[this, SortedTree.root], SortedTreeNode.keys] := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] + Fractions(50 - Heap[this, SortedTree.numClones])];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_113[Heap[this, SortedTree.root], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_113, Mask);
  } else {
  }
  if (!(Heap[this, SortedTree.root] == null)) {
    assume Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
  } else {
  }
  if (Heap[this, SortedTree.root] == null) {
    assume Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // if
  assert {:msg "  93.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  93.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
  if (Heap[this, SortedTree.root] == null) {
    // assigment to b
    b#7 := false;
    // fold
    assume (0 < foldK#_114) && ((1000 * foldK#_114) < Fractions(1)) && ((1000 * foldK#_114) < methodK#_106);
    assert {:msg "  95.4: The target of the fold statement might be null."} this != null;
    // begin exhale (fold)
    exhaleMask#_115 := Mask;
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true."} Heap[this, SortedTree.numClones] >= 0;
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true."} Heap[this, SortedTree.numClones] < 50;
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
    } else {
    }
    if (Heap[this, SortedTree.root] == null) {
      assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
    } else {
    }
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root."} (Fractions(100) <= exhaleMask#_115[this, SortedTree.root][perm$R]) && ((Fractions(100) == exhaleMask#_115[this, SortedTree.root][perm$R]) ==> (0 <= exhaleMask#_115[this, SortedTree.root][perm$N]));
    exhaleMask#_115[this, SortedTree.root] := exhaleMask#_115[this, SortedTree.root][perm$R := exhaleMask#_115[this, SortedTree.root][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_115);
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive."} Fractions(50) > 0;
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys."} (Fractions(50) <= exhaleMask#_115[this, SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_115[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_115[this, SortedTree.keys][perm$N]));
    exhaleMask#_115[this, SortedTree.keys] := exhaleMask#_115[this, SortedTree.keys][perm$R := exhaleMask#_115[this, SortedTree.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_115);
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones."} (Fractions(100) <= exhaleMask#_115[this, SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_115[this, SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_115[this, SortedTree.numClones][perm$N]));
    exhaleMask#_115[this, SortedTree.numClones] := exhaleMask#_115[this, SortedTree.numClones][perm$R := exhaleMask#_115[this, SortedTree.numClones][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_115);
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive."} (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
      assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid."} ((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) <= exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) == exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$N]));
      exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.valid] := exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_115);
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive."} Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
      assert {:msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys."} (Fractions(50 - Heap[this, SortedTree.numClones]) <= exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap[this, SortedTree.numClones]) == exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$N]));
      exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.keys] := exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := exhaleMask#_115[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] - Fractions(50 - Heap[this, SortedTree.numClones])];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_115);
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (Heap[this, SortedTree.root] == null) {
    } else {
    }
    Mask := exhaleMask#_115;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_121;
    assume IsGoodInhaleState(inhaleHeap#_121, Heap, Mask);
    assume this != null;
    Heap[this, SortedTree.valid] := inhaleHeap#_121[this, SortedTree.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_121[this, SortedTree.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_121[this, SortedTree.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_121, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[this, SortedTree.valid] := Heap;
    assume wf(Heap, Mask);
  } else {
    // local var bb
    assume (0 < methodCallK#_125) && ((1000 * methodCallK#_125) < Fractions(1)) && ((1000 * methodCallK#_125) < methodK#_106);
    // call has
    callHeap#_122 := Heap;
    callMask#_123 := Mask;
    callCredits#_124 := Credits;
    assert {:msg "  98.14: Receiver might be null."} true ==> (this != null);
    assert {:msg "  98.14: Location might not be readable."} true ==> CanRead(Mask, this, SortedTree.root);
    assert {:msg "  98.4: The target of the method call might be null."} Heap[this, SortedTree.root] != null;
    this#52 := Heap[this, SortedTree.root];
    k#53 := k#6;
    // begin exhale (precondition)
    exhaleMask#_126 := Mask;
    assert {:msg "  98.4: The precondition at 284.12 might not hold. The permission at 284.12 might not be positive."} Fractions(1) > 0;
    assert {:msg "  98.4: The precondition at 284.12 might not hold. Insufficient fraction at 284.12 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_126[this#52, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_126[this#52, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_126[this#52, SortedTreeNode.valid][perm$N]));
    exhaleMask#_126[this#52, SortedTreeNode.valid] := exhaleMask#_126[this#52, SortedTreeNode.valid][perm$R := exhaleMask#_126[this#52, SortedTreeNode.valid][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_126);
    assert {:msg "  98.4: The precondition at 285.12 might not hold. The permission at 285.12 might not be positive."} Fractions(1) > 0;
    assert {:msg "  98.4: The precondition at 285.12 might not hold. Insufficient fraction at 285.12 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_126[this#52, SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_126[this#52, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_126[this#52, SortedTreeNode.keys][perm$N]));
    exhaleMask#_126[this#52, SortedTreeNode.keys] := exhaleMask#_126[this#52, SortedTreeNode.keys][perm$R := exhaleMask#_126[this#52, SortedTreeNode.keys][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_126);
    Mask := exhaleMask#_126;
    assume wf(Heap, Mask);
    // end exhale
    havoc b#54;
    // inhale (postcondition)
    havoc inhaleHeap#_131;
    assume IsGoodInhaleState(inhaleHeap#_131, Heap, Mask);
    assume this#52 != null;
    Heap[this#52, SortedTreeNode.valid] := inhaleHeap#_131[this#52, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_131[this#52, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[this#52, SortedTreeNode.valid] := Mask[this#52, SortedTreeNode.valid][perm$R := Mask[this#52, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_131[this#52, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_131, Mask);
    assume this#52 != null;
    Heap[this#52, SortedTreeNode.keys] := inhaleHeap#_131[this#52, SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[this#52, SortedTreeNode.keys] := Mask[this#52, SortedTreeNode.keys][perm$R := Mask[this#52, SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_131[this#52, SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_131, Mask);
    assume b#54 == Seq#Contains(Heap[this#52, SortedTreeNode.keys], k#53);
    assume Seq#Equal(Heap[this#52, SortedTreeNode.keys], callHeap#_122[this#52, SortedTreeNode.keys]);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    bb#9 := b#54;
    // assigment to b
    b#7 := bb#9;
    // fold
    assume (0 < foldK#_132) && ((1000 * foldK#_132) < Fractions(1)) && ((1000 * foldK#_132) < methodK#_106);
    assert {:msg "  100.4: The target of the fold statement might be null."} this != null;
    // begin exhale (fold)
    exhaleMask#_133 := Mask;
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true."} Heap[this, SortedTree.numClones] >= 0;
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true."} Heap[this, SortedTree.numClones] < 50;
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Heap[Heap[this, SortedTree.root], SortedTreeNode.keys]);
    } else {
    }
    if (Heap[this, SortedTree.root] == null) {
      assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTree.keys], Seq#Empty());
    } else {
    }
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root."} (Fractions(100) <= exhaleMask#_133[this, SortedTree.root][perm$R]) && ((Fractions(100) == exhaleMask#_133[this, SortedTree.root][perm$R]) ==> (0 <= exhaleMask#_133[this, SortedTree.root][perm$N]));
    exhaleMask#_133[this, SortedTree.root] := exhaleMask#_133[this, SortedTree.root][perm$R := exhaleMask#_133[this, SortedTree.root][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_133);
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive."} Fractions(50) > 0;
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys."} (Fractions(50) <= exhaleMask#_133[this, SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_133[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_133[this, SortedTree.keys][perm$N]));
    exhaleMask#_133[this, SortedTree.keys] := exhaleMask#_133[this, SortedTree.keys][perm$R := exhaleMask#_133[this, SortedTree.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_133);
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones."} (Fractions(100) <= exhaleMask#_133[this, SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_133[this, SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_133[this, SortedTree.numClones][perm$N]));
    exhaleMask#_133[this, SortedTree.numClones] := exhaleMask#_133[this, SortedTree.numClones][perm$R := exhaleMask#_133[this, SortedTree.numClones][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_133);
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive."} (Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) > 0;
      assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid."} ((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) <= exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap[this, SortedTree.numClones])) == exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$N]));
      exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.valid] := exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R := exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap[this, SortedTree.numClones]))];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_133);
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
      assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive."} Fractions(50 - Heap[this, SortedTree.numClones]) > 0;
      assert {:msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys."} (Fractions(50 - Heap[this, SortedTree.numClones]) <= exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap[this, SortedTree.numClones]) == exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$N]));
      exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.keys] := exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R := exhaleMask#_133[Heap[this, SortedTree.root], SortedTreeNode.keys][perm$R] - Fractions(50 - Heap[this, SortedTree.numClones])];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_133);
    } else {
    }
    if (!(Heap[this, SortedTree.root] == null)) {
    } else {
    }
    if (Heap[this, SortedTree.root] == null) {
    } else {
    }
    Mask := exhaleMask#_133;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_139;
    assume IsGoodInhaleState(inhaleHeap#_139, Heap, Mask);
    assume this != null;
    Heap[this, SortedTree.valid] := inhaleHeap#_139[this, SortedTree.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_139[this, SortedTree.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this, SortedTree.valid] := Mask[this, SortedTree.valid][perm$R := Mask[this, SortedTree.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_139[this, SortedTree.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_139, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[this, SortedTree.valid] := Heap;
    assume wf(Heap, Mask);
  }
  // begin exhale (postcondition)
  exhaleMask#_140 := Mask;
  assert {:msg "  84.2: The postcondition at 90.11 might not hold. The expression at 90.11 might not evaluate to true."} b#7 == Seq#Contains(Heap[this, SortedTree.keys], k#6);
  assert {:msg "  84.2: The postcondition at 88.11 might not hold. The permission at 88.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  84.2: The postcondition at 88.11 might not hold. Insufficient fraction at 88.11 for SortedTree.valid."} (Fractions(100) <= exhaleMask#_140[this, SortedTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_140[this, SortedTree.valid][perm$R]) ==> (0 <= exhaleMask#_140[this, SortedTree.valid][perm$N]));
  exhaleMask#_140[this, SortedTree.valid] := exhaleMask#_140[this, SortedTree.valid][perm$R := exhaleMask#_140[this, SortedTree.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_140);
  assert {:msg "  84.2: The postcondition at 89.11 might not hold. The permission at 89.11 might not be positive."} methodK#_106 > 0;
  assert {:msg "  84.2: The postcondition at 89.11 might not hold. Insufficient fraction at 89.11 for SortedTree.keys."} (methodK#_106 <= exhaleMask#_140[this, SortedTree.keys][perm$R]) && ((methodK#_106 == exhaleMask#_140[this, SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_140[this, SortedTree.keys][perm$N]));
  exhaleMask#_140[this, SortedTree.keys] := exhaleMask#_140[this, SortedTree.keys][perm$R := exhaleMask#_140[this, SortedTree.keys][perm$R] - methodK#_106];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_140);
  Mask := exhaleMask#_140;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  84.2: Method might lock/unlock more than allowed."} (forall lk#_143: ref :: {Heap[lk#_143, held]} {Heap[lk#_143, rdheld]} (((0 < Heap[lk#_143, held]) == (0 < old(Heap)[lk#_143, held])) && (Heap[lk#_143, rdheld] == old(Heap)[lk#_143, rdheld])) || false);
  assert {:msg "  84.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique SortedTreeSnapshot#t: TypeName;
procedure SortedTreeSnapshot$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeSnapshot#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_151: int;
  var h0#_144: HeapType;
  var m0#_145: MaskType;
  var c0#_146: CreditsType;
  var h1#_147: HeapType;
  var m1#_148: MaskType;
  var c1#_149: CreditsType;
  var lk#_150: ref;
  assume (0 < methodK#_151) && ((1000 * methodK#_151) < Fractions(1));
  assume wf(h0#_144, m0#_145);
  assume wf(h1#_147, m1#_148);
  m1#_148 := ZeroMask;
  c1#_149 := ZeroCredits;
  Mask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  assert {:msg "  108.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique SortedTreeSnapshot.root: Field (ref);
axiom NonPredicateField(SortedTreeSnapshot.root);
const unique SortedTreeSnapshot.keys: Field (Seq (int));
axiom NonPredicateField(SortedTreeSnapshot.keys);
const unique SortedTreeSnapshot.valid: Field (HeapType);
axiom PredicateField(SortedTreeSnapshot.valid);
procedure SortedTreeSnapshot.valid$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeSnapshot#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var predicateK#_152: int;
  var inhaleHeap#_153: HeapType;
  assume (0 < predicateK#_152) && ((1000 * predicateK#_152) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_153;
  assume IsGoodInhaleState(inhaleHeap#_153, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.root] := inhaleHeap#_153[this, SortedTreeSnapshot.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeSnapshot.root] == null) || (dtype(Heap[this, SortedTreeSnapshot.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.root] := Mask[this, SortedTreeSnapshot.root][perm$R := Mask[this, SortedTreeSnapshot.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_153[this, SortedTreeSnapshot.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_153, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_153[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_153[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_153, Mask);
  assert {:msg "  117.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  117.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assert {:msg "  117.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  117.26: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
    assume Heap[this, SortedTreeSnapshot.root] != null;
    Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] := inhaleHeap#_153[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_153[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_153[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_153, Mask);
  } else {
  }
  assert {:msg "  118.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  118.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assert {:msg "  118.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  118.26: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
    assume Heap[this, SortedTreeSnapshot.root] != null;
    Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys] := inhaleHeap#_153[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_153[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_153, Mask);
  } else {
  }
  assert {:msg "  119.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  119.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assert {:msg "  119.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  119.22: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.keys);
    assert {:msg "  119.30: Receiver might be null."} true ==> (this != null);
    assert {:msg "  119.30: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
    assert {:msg "  119.30: Receiver might be null."} true ==> (Heap[this, SortedTreeSnapshot.root] != null);
    assert {:msg "  119.30: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys);
    assume Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys]);
  } else {
  }
  assert {:msg "  120.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  120.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
  if (Heap[this, SortedTreeSnapshot.root] == null) {
    assert {:msg "  120.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  120.22: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.keys);
    assume Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Seq#Empty());
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTreeSnapshot.init$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeSnapshot#t), treeRoot#10: ref where (treeRoot#10 == null) || (dtype(treeRoot#10) == SortedTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_154: int;
  var inhaleHeap#_155: HeapType;
  var inhaleHeap#_156: HeapType;
  assume (0 < methodK#_154) && ((1000 * methodK#_154) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_155;
  assume IsGoodInhaleState(inhaleHeap#_155, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.root] := inhaleHeap#_155[this, SortedTreeSnapshot.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeSnapshot.root] == null) || (dtype(Heap[this, SortedTreeSnapshot.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.root] := Mask[this, SortedTreeSnapshot.root][perm$R := Mask[this, SortedTreeSnapshot.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_155[this, SortedTreeSnapshot.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_155, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_155[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_155[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_155, Mask);
  if (!(treeRoot#10 == null)) {
    assume treeRoot#10 != null;
    Heap[treeRoot#10, SortedTreeNode.valid] := inhaleHeap#_155[treeRoot#10, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_155[treeRoot#10, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[treeRoot#10, SortedTreeNode.valid] := Mask[treeRoot#10, SortedTreeNode.valid][perm$R := Mask[treeRoot#10, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_155[treeRoot#10, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_155, Mask);
  } else {
  }
  if (!(treeRoot#10 == null)) {
    assume treeRoot#10 != null;
    Heap[treeRoot#10, SortedTreeNode.keys] := inhaleHeap#_155[treeRoot#10, SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[treeRoot#10, SortedTreeNode.keys] := Mask[treeRoot#10, SortedTreeNode.keys][perm$R := Mask[treeRoot#10, SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_155[treeRoot#10, SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_155, Mask);
  } else {
  }
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
  havoc inhaleHeap#_156;
  assume IsGoodInhaleState(inhaleHeap#_156, Heap, Mask);
  assert {:msg "  131.11: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTreeSnapshot.valid] := inhaleHeap#_156[this, SortedTreeSnapshot.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_156[this, SortedTreeSnapshot.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.valid] := Mask[this, SortedTreeSnapshot.valid][perm$R := Mask[this, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_156[this, SortedTreeSnapshot.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_156, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_156[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_156[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_156, Mask);
  if (!(treeRoot#10 == null)) {
    assert {:msg "  134.30: Receiver might be null."} true ==> (this != null);
    assert {:msg "  134.30: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.keys);
    assert {:msg "  134.42: Receiver might be null."} true ==> (treeRoot#10 != null);
    assert {:msg "  134.42: Location might not be readable."} true ==> CanRead(old(Mask), treeRoot#10, SortedTreeNode.keys);
    assume Seq#Equal(Heap[this, SortedTreeSnapshot.keys], old(Heap)[treeRoot#10, SortedTreeNode.keys]);
  } else {
  }
  if (treeRoot#10 == null) {
    assert {:msg "  135.30: Receiver might be null."} true ==> (this != null);
    assert {:msg "  135.30: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.keys);
    assume Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Seq#Empty());
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTreeSnapshot.init(this: ref where (this == null) || (dtype(this) == SortedTreeSnapshot#t), treeRoot#10: ref where (treeRoot#10 == null) || (dtype(treeRoot#10) == SortedTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_154: int;
  var inhaleHeap#_157: HeapType;
  var foldK#_158: int;
  var exhaleMask#_159: MaskType;
  var inhaleHeap#_164: HeapType;
  var foldK#_165: int;
  var exhaleMask#_166: MaskType;
  var inhaleHeap#_171: HeapType;
  var exhaleMask#_172: MaskType;
  assume (0 < methodK#_154) && ((1000 * methodK#_154) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_157;
  assume IsGoodInhaleState(inhaleHeap#_157, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.root] := inhaleHeap#_157[this, SortedTreeSnapshot.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeSnapshot.root] == null) || (dtype(Heap[this, SortedTreeSnapshot.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.root] := Mask[this, SortedTreeSnapshot.root][perm$R := Mask[this, SortedTreeSnapshot.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_157[this, SortedTreeSnapshot.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_157, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_157[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_157[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_157, Mask);
  if (!(treeRoot#10 == null)) {
    assume treeRoot#10 != null;
    Heap[treeRoot#10, SortedTreeNode.valid] := inhaleHeap#_157[treeRoot#10, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_157[treeRoot#10, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[treeRoot#10, SortedTreeNode.valid] := Mask[treeRoot#10, SortedTreeNode.valid][perm$R := Mask[treeRoot#10, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_157[treeRoot#10, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_157, Mask);
  } else {
  }
  if (!(treeRoot#10 == null)) {
    assume treeRoot#10 != null;
    Heap[treeRoot#10, SortedTreeNode.keys] := inhaleHeap#_157[treeRoot#10, SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[treeRoot#10, SortedTreeNode.keys] := Mask[treeRoot#10, SortedTreeNode.keys][perm$R := Mask[treeRoot#10, SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_157[treeRoot#10, SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_157, Mask);
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // update field root
  assert {:msg "  138.3: Location might not be writable"} CanWrite(Mask, this, SortedTreeSnapshot.root);
  Heap[this, SortedTreeSnapshot.root] := treeRoot#10;
  assume wf(Heap, Mask);
  // if
  assert {:msg "  139.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  139.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    // update field keys
    assert {:msg "  140.4: Location might not be writable"} CanWrite(Mask, this, SortedTreeSnapshot.keys);
    assert {:msg "  140.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  140.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
    assert {:msg "  140.12: Receiver might be null."} true ==> (Heap[this, SortedTreeSnapshot.root] != null);
    assert {:msg "  140.12: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys);
    Heap[this, SortedTreeSnapshot.keys] := Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    // fold
    assume (0 < foldK#_158) && ((1000 * foldK#_158) < Fractions(1)) && ((1000 * foldK#_158) < methodK#_154);
    assert {:msg "  141.4: The target of the fold statement might be null."} this != null;
    // begin exhale (fold)
    exhaleMask#_159 := Mask;
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
      assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The expression at 119.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys]);
    } else {
    }
    if (Heap[this, SortedTreeSnapshot.root] == null) {
      assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The expression at 120.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Seq#Empty());
    } else {
    }
    assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 115.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 115.6 for SortedTreeSnapshot.root."} (Fractions(100) <= exhaleMask#_159[this, SortedTreeSnapshot.root][perm$R]) && ((Fractions(100) == exhaleMask#_159[this, SortedTreeSnapshot.root][perm$R]) ==> (0 <= exhaleMask#_159[this, SortedTreeSnapshot.root][perm$N]));
    exhaleMask#_159[this, SortedTreeSnapshot.root] := exhaleMask#_159[this, SortedTreeSnapshot.root][perm$R := exhaleMask#_159[this, SortedTreeSnapshot.root][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_159);
    assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 116.6 might not be positive."} Fractions(50) > 0;
    assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 116.6 for SortedTreeSnapshot.keys."} (Fractions(50) <= exhaleMask#_159[this, SortedTreeSnapshot.keys][perm$R]) && ((Fractions(50) == exhaleMask#_159[this, SortedTreeSnapshot.keys][perm$R]) ==> (0 <= exhaleMask#_159[this, SortedTreeSnapshot.keys][perm$N]));
    exhaleMask#_159[this, SortedTreeSnapshot.keys] := exhaleMask#_159[this, SortedTreeSnapshot.keys][perm$R := exhaleMask#_159[this, SortedTreeSnapshot.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_159);
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
      assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 117.22 might not be positive."} Fractions(1) > 0;
      assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 117.22 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$N]));
      exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] := exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R := exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_159);
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
      assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 118.22 might not be positive."} Fractions(1) > 0;
      assert {:msg "  141.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 118.22 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$N]));
      exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys] := exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R := exhaleMask#_159[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_159);
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    } else {
    }
    if (Heap[this, SortedTreeSnapshot.root] == null) {
    } else {
    }
    Mask := exhaleMask#_159;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_164;
    assume IsGoodInhaleState(inhaleHeap#_164, Heap, Mask);
    assume this != null;
    Heap[this, SortedTreeSnapshot.valid] := inhaleHeap#_164[this, SortedTreeSnapshot.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_164[this, SortedTreeSnapshot.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this, SortedTreeSnapshot.valid] := Mask[this, SortedTreeSnapshot.valid][perm$R := Mask[this, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_164[this, SortedTreeSnapshot.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_164, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[this, SortedTreeSnapshot.valid] := Heap;
    assume wf(Heap, Mask);
  } else {
    // update field keys
    assert {:msg "  143.4: Location might not be writable"} CanWrite(Mask, this, SortedTreeSnapshot.keys);
    Heap[this, SortedTreeSnapshot.keys] := Seq#Empty();
    assume wf(Heap, Mask);
    // fold
    assume (0 < foldK#_165) && ((1000 * foldK#_165) < Fractions(1)) && ((1000 * foldK#_165) < methodK#_154);
    assert {:msg "  144.4: The target of the fold statement might be null."} this != null;
    // begin exhale (fold)
    exhaleMask#_166 := Mask;
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
      assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The expression at 119.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys]);
    } else {
    }
    if (Heap[this, SortedTreeSnapshot.root] == null) {
      assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The expression at 120.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Seq#Empty());
    } else {
    }
    assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 115.6 might not be positive."} Fractions(100) > 0;
    assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 115.6 for SortedTreeSnapshot.root."} (Fractions(100) <= exhaleMask#_166[this, SortedTreeSnapshot.root][perm$R]) && ((Fractions(100) == exhaleMask#_166[this, SortedTreeSnapshot.root][perm$R]) ==> (0 <= exhaleMask#_166[this, SortedTreeSnapshot.root][perm$N]));
    exhaleMask#_166[this, SortedTreeSnapshot.root] := exhaleMask#_166[this, SortedTreeSnapshot.root][perm$R := exhaleMask#_166[this, SortedTreeSnapshot.root][perm$R] - Fractions(100)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_166);
    assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 116.6 might not be positive."} Fractions(50) > 0;
    assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 116.6 for SortedTreeSnapshot.keys."} (Fractions(50) <= exhaleMask#_166[this, SortedTreeSnapshot.keys][perm$R]) && ((Fractions(50) == exhaleMask#_166[this, SortedTreeSnapshot.keys][perm$R]) ==> (0 <= exhaleMask#_166[this, SortedTreeSnapshot.keys][perm$N]));
    exhaleMask#_166[this, SortedTreeSnapshot.keys] := exhaleMask#_166[this, SortedTreeSnapshot.keys][perm$R := exhaleMask#_166[this, SortedTreeSnapshot.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_166);
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
      assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 117.22 might not be positive."} Fractions(1) > 0;
      assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 117.22 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$N]));
      exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] := exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R := exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_166);
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
      assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 118.22 might not be positive."} Fractions(1) > 0;
      assert {:msg "  144.4: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 118.22 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$N]));
      exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys] := exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R := exhaleMask#_166[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R] - Fractions(1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_166);
    } else {
    }
    if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    } else {
    }
    if (Heap[this, SortedTreeSnapshot.root] == null) {
    } else {
    }
    Mask := exhaleMask#_166;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_171;
    assume IsGoodInhaleState(inhaleHeap#_171, Heap, Mask);
    assume this != null;
    Heap[this, SortedTreeSnapshot.valid] := inhaleHeap#_171[this, SortedTreeSnapshot.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_171[this, SortedTreeSnapshot.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this, SortedTreeSnapshot.valid] := Mask[this, SortedTreeSnapshot.valid][perm$R := Mask[this, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_171[this, SortedTreeSnapshot.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_171, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[this, SortedTreeSnapshot.valid] := Heap;
    assume wf(Heap, Mask);
  }
  // begin exhale (postcondition)
  exhaleMask#_172 := Mask;
  if (!(treeRoot#10 == null)) {
    assert {:msg "  124.2: The postcondition at 134.11 might not hold. The expression at 134.30 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], old(Heap)[treeRoot#10, SortedTreeNode.keys]);
  } else {
  }
  if (treeRoot#10 == null) {
    assert {:msg "  124.2: The postcondition at 135.11 might not hold. The expression at 135.30 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Seq#Empty());
  } else {
  }
  assert {:msg "  124.2: The postcondition at 131.11 might not hold. The permission at 131.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  124.2: The postcondition at 131.11 might not hold. Insufficient fraction at 131.11 for SortedTreeSnapshot.valid."} (Fractions(100) <= exhaleMask#_172[this, SortedTreeSnapshot.valid][perm$R]) && ((Fractions(100) == exhaleMask#_172[this, SortedTreeSnapshot.valid][perm$R]) ==> (0 <= exhaleMask#_172[this, SortedTreeSnapshot.valid][perm$N]));
  exhaleMask#_172[this, SortedTreeSnapshot.valid] := exhaleMask#_172[this, SortedTreeSnapshot.valid][perm$R := exhaleMask#_172[this, SortedTreeSnapshot.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_172);
  assert {:msg "  124.2: The postcondition at 132.11 might not hold. The permission at 132.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  124.2: The postcondition at 132.11 might not hold. Insufficient fraction at 132.11 for SortedTreeSnapshot.keys."} (Fractions(50) <= exhaleMask#_172[this, SortedTreeSnapshot.keys][perm$R]) && ((Fractions(50) == exhaleMask#_172[this, SortedTreeSnapshot.keys][perm$R]) ==> (0 <= exhaleMask#_172[this, SortedTreeSnapshot.keys][perm$N]));
  exhaleMask#_172[this, SortedTreeSnapshot.keys] := exhaleMask#_172[this, SortedTreeSnapshot.keys][perm$R := exhaleMask#_172[this, SortedTreeSnapshot.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_172);
  if (!(treeRoot#10 == null)) {
  } else {
  }
  if (treeRoot#10 == null) {
  } else {
  }
  Mask := exhaleMask#_172;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  124.2: Method might lock/unlock more than allowed."} (forall lk#_175: ref :: {Heap[lk#_175, held]} {Heap[lk#_175, rdheld]} (((0 < Heap[lk#_175, held]) == (0 < old(Heap)[lk#_175, held])) && (Heap[lk#_175, rdheld] == old(Heap)[lk#_175, rdheld])) || false);
  assert {:msg "  124.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure SortedTreeSnapshot.has$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeSnapshot#t), k#11: int where true) returns (b#12: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_176: int;
  var inhaleHeap#_177: HeapType;
  var inhaleHeap#_178: HeapType;
  assume (0 < methodK#_176) && ((1000 * methodK#_176) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_177;
  assume IsGoodInhaleState(inhaleHeap#_177, Heap, Mask);
  assert {:msg "  151.12: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTreeSnapshot.valid] := inhaleHeap#_177[this, SortedTreeSnapshot.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_177[this, SortedTreeSnapshot.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.valid] := Mask[this, SortedTreeSnapshot.valid][perm$R := Mask[this, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_177[this, SortedTreeSnapshot.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_177, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_177[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_177[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_177, Mask);
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
  havoc inhaleHeap#_178;
  assume IsGoodInhaleState(inhaleHeap#_178, Heap, Mask);
  assert {:msg "  154.11: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTreeSnapshot.valid] := inhaleHeap#_178[this, SortedTreeSnapshot.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_178[this, SortedTreeSnapshot.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.valid] := Mask[this, SortedTreeSnapshot.valid][perm$R := Mask[this, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_178[this, SortedTreeSnapshot.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_178, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_178[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_178[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_178, Mask);
  assert {:msg "  156.22: Receiver might be null."} true ==> (this != null);
  assert {:msg "  156.22: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.keys);
  assume b#12 == Seq#Contains(Heap[this, SortedTreeSnapshot.keys], k#11);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTreeSnapshot.has(this: ref where (this == null) || (dtype(this) == SortedTreeSnapshot#t), k#11: int where true) returns (b#12: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_176: int;
  var inhaleHeap#_179: HeapType;
  var unfoldK#_180: int;
  var exhaleMask#_181: MaskType;
  var inhaleHeap#_183: HeapType;
  var bb#14: bool where true;
  var methodCallK#_187: int;
  var this#55: ref where (this#55 == null) || (dtype(this#55) == SortedTreeNode#t);
  var k#56: int where true;
  var b#57: bool where true;
  var callHeap#_184: HeapType;
  var callMask#_185: MaskType;
  var callCredits#_186: CreditsType;
  var exhaleMask#_188: MaskType;
  var isHeld#_191: int;
  var isRdHeld#_192: bool;
  var inhaleHeap#_193: HeapType;
  var foldK#_194: int;
  var exhaleMask#_195: MaskType;
  var inhaleHeap#_200: HeapType;
  var exhaleMask#_201: MaskType;
  assume (0 < methodK#_176) && ((1000 * methodK#_176) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_179;
  assume IsGoodInhaleState(inhaleHeap#_179, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.valid] := inhaleHeap#_179[this, SortedTreeSnapshot.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_179[this, SortedTreeSnapshot.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.valid] := Mask[this, SortedTreeSnapshot.valid][perm$R := Mask[this, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_179[this, SortedTreeSnapshot.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_179, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_179[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_179[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_179, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assume (0 < unfoldK#_180) && (unfoldK#_180 < Fractions(1)) && ((1000 * unfoldK#_180) < methodK#_176);
  assert {:msg "  158.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_181 := Mask;
  assert {:msg "  158.3: unfold might fail because the predicate SortedTreeSnapshot.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  158.3: unfold might fail because the predicate SortedTreeSnapshot.valid does not hold. Insufficient fraction at <undefined position> for SortedTreeSnapshot.valid."} (Fractions(100) <= exhaleMask#_181[this, SortedTreeSnapshot.valid][perm$R]) && ((Fractions(100) == exhaleMask#_181[this, SortedTreeSnapshot.valid][perm$R]) ==> (0 <= exhaleMask#_181[this, SortedTreeSnapshot.valid][perm$N]));
  exhaleMask#_181[this, SortedTreeSnapshot.valid] := exhaleMask#_181[this, SortedTreeSnapshot.valid][perm$R := exhaleMask#_181[this, SortedTreeSnapshot.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_181);
  Mask := exhaleMask#_181;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_183 := Heap[this, SortedTreeSnapshot.valid];
  assume IsGoodInhaleState(inhaleHeap#_183, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.root] := inhaleHeap#_183[this, SortedTreeSnapshot.root];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeSnapshot.root] == null) || (dtype(Heap[this, SortedTreeSnapshot.root]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.root] := Mask[this, SortedTreeSnapshot.root][perm$R := Mask[this, SortedTreeSnapshot.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_183[this, SortedTreeSnapshot.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_183, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.keys] := inhaleHeap#_183[this, SortedTreeSnapshot.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTreeSnapshot.keys] := Mask[this, SortedTreeSnapshot.keys][perm$R := Mask[this, SortedTreeSnapshot.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_183[this, SortedTreeSnapshot.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_183, Mask);
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assume Heap[this, SortedTreeSnapshot.root] != null;
    Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] := inhaleHeap#_183[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_183[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_183[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_183, Mask);
  } else {
  }
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assume Heap[this, SortedTreeSnapshot.root] != null;
    Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys] := inhaleHeap#_183[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_183[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_183, Mask);
  } else {
  }
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assume Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys]);
  } else {
  }
  if (Heap[this, SortedTreeSnapshot.root] == null) {
    assume Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Seq#Empty());
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // if
  assert {:msg "  159.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  159.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
  if (Heap[this, SortedTreeSnapshot.root] == null) {
    // assigment to b
    b#12 := false;
  } else {
    // local var bb
    assume (0 < methodCallK#_187) && ((1000 * methodCallK#_187) < Fractions(1)) && ((1000 * methodCallK#_187) < methodK#_176);
    // call has
    callHeap#_184 := Heap;
    callMask#_185 := Mask;
    callCredits#_186 := Credits;
    assert {:msg "  163.14: Receiver might be null."} true ==> (this != null);
    assert {:msg "  163.14: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeSnapshot.root);
    assert {:msg "  163.4: The target of the method call might be null."} Heap[this, SortedTreeSnapshot.root] != null;
    this#55 := Heap[this, SortedTreeSnapshot.root];
    k#56 := k#11;
    // begin exhale (precondition)
    exhaleMask#_188 := Mask;
    assert {:msg "  163.4: The precondition at 284.12 might not hold. The permission at 284.12 might not be positive."} Fractions(1) > 0;
    assert {:msg "  163.4: The precondition at 284.12 might not hold. Insufficient fraction at 284.12 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_188[this#55, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_188[this#55, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_188[this#55, SortedTreeNode.valid][perm$N]));
    exhaleMask#_188[this#55, SortedTreeNode.valid] := exhaleMask#_188[this#55, SortedTreeNode.valid][perm$R := exhaleMask#_188[this#55, SortedTreeNode.valid][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_188);
    assert {:msg "  163.4: The precondition at 285.12 might not hold. The permission at 285.12 might not be positive."} Fractions(1) > 0;
    assert {:msg "  163.4: The precondition at 285.12 might not hold. Insufficient fraction at 285.12 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_188[this#55, SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_188[this#55, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_188[this#55, SortedTreeNode.keys][perm$N]));
    exhaleMask#_188[this#55, SortedTreeNode.keys] := exhaleMask#_188[this#55, SortedTreeNode.keys][perm$R := exhaleMask#_188[this#55, SortedTreeNode.keys][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_188);
    Mask := exhaleMask#_188;
    assume wf(Heap, Mask);
    // end exhale
    havoc b#57;
    // inhale (postcondition)
    havoc inhaleHeap#_193;
    assume IsGoodInhaleState(inhaleHeap#_193, Heap, Mask);
    assume this#55 != null;
    Heap[this#55, SortedTreeNode.valid] := inhaleHeap#_193[this#55, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_193[this#55, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[this#55, SortedTreeNode.valid] := Mask[this#55, SortedTreeNode.valid][perm$R := Mask[this#55, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_193[this#55, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_193, Mask);
    assume this#55 != null;
    Heap[this#55, SortedTreeNode.keys] := inhaleHeap#_193[this#55, SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[this#55, SortedTreeNode.keys] := Mask[this#55, SortedTreeNode.keys][perm$R := Mask[this#55, SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_193[this#55, SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_193, Mask);
    assume b#57 == Seq#Contains(Heap[this#55, SortedTreeNode.keys], k#56);
    assume Seq#Equal(Heap[this#55, SortedTreeNode.keys], callHeap#_184[this#55, SortedTreeNode.keys]);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    bb#14 := b#57;
    // assigment to b
    b#12 := bb#14;
  }
  // fold
  assume (0 < foldK#_194) && ((1000 * foldK#_194) < Fractions(1)) && ((1000 * foldK#_194) < methodK#_176);
  assert {:msg "  166.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_195 := Mask;
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
  } else {
  }
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
  } else {
  }
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The expression at 119.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Heap[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys]);
  } else {
  }
  if (Heap[this, SortedTreeSnapshot.root] == null) {
    assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The expression at 120.22 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeSnapshot.keys], Seq#Empty());
  } else {
  }
  assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 115.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 115.6 for SortedTreeSnapshot.root."} (Fractions(100) <= exhaleMask#_195[this, SortedTreeSnapshot.root][perm$R]) && ((Fractions(100) == exhaleMask#_195[this, SortedTreeSnapshot.root][perm$R]) ==> (0 <= exhaleMask#_195[this, SortedTreeSnapshot.root][perm$N]));
  exhaleMask#_195[this, SortedTreeSnapshot.root] := exhaleMask#_195[this, SortedTreeSnapshot.root][perm$R := exhaleMask#_195[this, SortedTreeSnapshot.root][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_195);
  assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 116.6 might not be positive."} Fractions(50) > 0;
  assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 116.6 for SortedTreeSnapshot.keys."} (Fractions(50) <= exhaleMask#_195[this, SortedTreeSnapshot.keys][perm$R]) && ((Fractions(50) == exhaleMask#_195[this, SortedTreeSnapshot.keys][perm$R]) ==> (0 <= exhaleMask#_195[this, SortedTreeSnapshot.keys][perm$N]));
  exhaleMask#_195[this, SortedTreeSnapshot.keys] := exhaleMask#_195[this, SortedTreeSnapshot.keys][perm$R := exhaleMask#_195[this, SortedTreeSnapshot.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_195);
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 117.22 might not be positive."} Fractions(1) > 0;
    assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 117.22 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$N]));
    exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid] := exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R := exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.valid][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_195);
  } else {
  }
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
    assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. The permission at 118.22 might not be positive."} Fractions(1) > 0;
    assert {:msg "  166.3: Fold might fail because the definition of SortedTreeSnapshot.valid does not hold. Insufficient fraction at 118.22 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$N]));
    exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys] := exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R := exhaleMask#_195[Heap[this, SortedTreeSnapshot.root], SortedTreeNode.keys][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_195);
  } else {
  }
  if (!(Heap[this, SortedTreeSnapshot.root] == null)) {
  } else {
  }
  if (Heap[this, SortedTreeSnapshot.root] == null) {
  } else {
  }
  Mask := exhaleMask#_195;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_200;
  assume IsGoodInhaleState(inhaleHeap#_200, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeSnapshot.valid] := inhaleHeap#_200[this, SortedTreeSnapshot.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_200[this, SortedTreeSnapshot.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeSnapshot.valid] := Mask[this, SortedTreeSnapshot.valid][perm$R := Mask[this, SortedTreeSnapshot.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_200[this, SortedTreeSnapshot.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_200, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, SortedTreeSnapshot.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_201 := Mask;
  assert {:msg "  150.2: The postcondition at 156.11 might not hold. The expression at 156.11 might not evaluate to true."} b#12 == Seq#Contains(Heap[this, SortedTreeSnapshot.keys], k#11);
  assert {:msg "  150.2: The postcondition at 154.11 might not hold. The permission at 154.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  150.2: The postcondition at 154.11 might not hold. Insufficient fraction at 154.11 for SortedTreeSnapshot.valid."} (Fractions(100) <= exhaleMask#_201[this, SortedTreeSnapshot.valid][perm$R]) && ((Fractions(100) == exhaleMask#_201[this, SortedTreeSnapshot.valid][perm$R]) ==> (0 <= exhaleMask#_201[this, SortedTreeSnapshot.valid][perm$N]));
  exhaleMask#_201[this, SortedTreeSnapshot.valid] := exhaleMask#_201[this, SortedTreeSnapshot.valid][perm$R := exhaleMask#_201[this, SortedTreeSnapshot.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_201);
  assert {:msg "  150.2: The postcondition at 155.11 might not hold. The permission at 155.11 might not be positive."} Fractions(1) > 0;
  assert {:msg "  150.2: The postcondition at 155.11 might not hold. Insufficient fraction at 155.11 for SortedTreeSnapshot.keys."} (Fractions(1) <= exhaleMask#_201[this, SortedTreeSnapshot.keys][perm$R]) && ((Fractions(1) == exhaleMask#_201[this, SortedTreeSnapshot.keys][perm$R]) ==> (0 <= exhaleMask#_201[this, SortedTreeSnapshot.keys][perm$N]));
  exhaleMask#_201[this, SortedTreeSnapshot.keys] := exhaleMask#_201[this, SortedTreeSnapshot.keys][perm$R := exhaleMask#_201[this, SortedTreeSnapshot.keys][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_201);
  Mask := exhaleMask#_201;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  150.2: Method might lock/unlock more than allowed."} (forall lk#_204: ref :: {Heap[lk#_204, held]} {Heap[lk#_204, rdheld]} (((0 < Heap[lk#_204, held]) == (0 < old(Heap)[lk#_204, held])) && (Heap[lk#_204, rdheld] == old(Heap)[lk#_204, rdheld])) || false);
  assert {:msg "  150.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique SortedTreeNode#t: TypeName;
procedure SortedTreeNode$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_212: int;
  var h0#_205: HeapType;
  var m0#_206: MaskType;
  var c0#_207: CreditsType;
  var h1#_208: HeapType;
  var m1#_209: MaskType;
  var c1#_210: CreditsType;
  var lk#_211: ref;
  assume (0 < methodK#_212) && ((1000 * methodK#_212) < Fractions(1));
  assume wf(h0#_205, m0#_206);
  assume wf(h1#_208, m1#_209);
  m1#_209 := ZeroMask;
  c1#_210 := ZeroCredits;
  Mask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  assert {:msg "  172.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique SortedTreeNode.key: Field (int);
axiom NonPredicateField(SortedTreeNode.key);
const unique SortedTreeNode.left: Field (ref);
axiom NonPredicateField(SortedTreeNode.left);
const unique SortedTreeNode.right: Field (ref);
axiom NonPredicateField(SortedTreeNode.right);
const unique SortedTreeNode.keys: Field (Seq (int));
axiom NonPredicateField(SortedTreeNode.keys);
const unique SortedTreeNode.shared: Field (bool);
axiom NonPredicateField(SortedTreeNode.shared);
const unique SortedTreeNode.valid: Field (HeapType);
axiom PredicateField(SortedTreeNode.valid);
procedure SortedTreeNode.valid$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var predicateK#_213: int;
  var inhaleHeap#_214: HeapType;
  var lk#27#60: int where true;
  var rk#28#61: int where true;
  var kk#62: int where true;
  assume (0 < predicateK#_213) && ((1000 * predicateK#_213) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_214;
  assume IsGoodInhaleState(inhaleHeap#_214, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.key] := inhaleHeap#_214[this, SortedTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.key] := Mask[this, SortedTreeNode.key][perm$R := Mask[this, SortedTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_214[this, SortedTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_214, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.left] := inhaleHeap#_214[this, SortedTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.left] == null) || (dtype(Heap[this, SortedTreeNode.left]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.left] := Mask[this, SortedTreeNode.left][perm$R := Mask[this, SortedTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_214[this, SortedTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_214, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.right] := inhaleHeap#_214[this, SortedTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.right] == null) || (dtype(Heap[this, SortedTreeNode.right]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.right] := Mask[this, SortedTreeNode.right][perm$R := Mask[this, SortedTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_214[this, SortedTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_214, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_214[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_214[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_214, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.shared] := inhaleHeap#_214[this, SortedTreeNode.shared];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTreeNode.shared] := Mask[this, SortedTreeNode.shared][perm$R := Mask[this, SortedTreeNode.shared][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_214[this, SortedTreeNode.shared]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_214, Mask);
  assert {:msg "  192.5: Receiver might be null."} true ==> (this != null);
  assert {:msg "  192.5: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
  assert {:msg "  192.19: Receiver might be null."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> (this != null);
  assert {:msg "  192.19: Location might not be readable."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> CanRead(Mask, this, SortedTreeNode.shared);
  if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  195.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  195.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  196.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  196.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  197.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  197.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  198.8: Receiver might be null."} true ==> (this != null);
    assert {:msg "  198.8: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assert {:msg "  198.8: Receiver might be null."} true ==> (Heap[this, SortedTreeNode.left] != null);
    assert {:msg "  198.8: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeNode.left], SortedTreeNode.shared);
    assume Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  assert {:msg "  203.5: Receiver might be null."} true ==> (this != null);
  assert {:msg "  203.5: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
  assert {:msg "  203.20: Receiver might be null."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> (this != null);
  assert {:msg "  203.20: Location might not be readable."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> CanRead(Mask, this, SortedTreeNode.shared);
  if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  206.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  206.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
    assume Fractions(50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  207.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  207.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  208.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  208.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  209.9: Receiver might be null."} true ==> (this != null);
    assert {:msg "  209.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assert {:msg "  209.9: Receiver might be null."} true ==> (Heap[this, SortedTreeNode.left] != null);
    assert {:msg "  209.9: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeNode.left], SortedTreeNode.shared);
    assume !Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  assert {:msg "  213.4: Receiver might be null."} true ==> (this != null);
  assert {:msg "  213.4: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
  if (!(Heap[this, SortedTreeNode.left] == null)) {
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= lk#27#60) ==> (this != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= lk#27#60) ==> CanRead(Mask, this, SortedTreeNode.left);
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= lk#27#60) ==> (Heap[this, SortedTreeNode.left] != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= lk#27#60) ==> CanRead(Mask, Heap[this, SortedTreeNode.left], SortedTreeNode.keys);
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (this != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask, this, SortedTreeNode.left);
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.left] != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask, Heap[this, SortedTreeNode.left], SortedTreeNode.keys);
    assert {:msg "  215.32: Sequence index might be negative."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (0 <= lk#27#60);
    assert {:msg "  215.32: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]));
    assert {:msg "  215.37: Receiver might be null."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (this != null);
    assert {:msg "  215.37: Location might not be readable."} true && (0 <= lk#27#60) && (lk#27#60 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask, this, SortedTreeNode.key);
    assume (forall lk#27#58: int :: (0 <= lk#27#58) && (lk#27#58 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], lk#27#58) < Heap[this, SortedTreeNode.key]));
  } else {
  }
  assert {:msg "  219.5: Receiver might be null."} true ==> (this != null);
  assert {:msg "  219.5: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
  assert {:msg "  219.20: Receiver might be null."} true && (!(Heap[this, SortedTreeNode.right] == null)) ==> (this != null);
  assert {:msg "  219.20: Location might not be readable."} true && (!(Heap[this, SortedTreeNode.right] == null)) ==> CanRead(Mask, this, SortedTreeNode.shared);
  if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  222.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  222.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  223.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  223.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  224.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  224.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  225.8: Receiver might be null."} true ==> (this != null);
    assert {:msg "  225.8: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assert {:msg "  225.8: Receiver might be null."} true ==> (Heap[this, SortedTreeNode.right] != null);
    assert {:msg "  225.8: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeNode.right], SortedTreeNode.shared);
    assume Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  assert {:msg "  230.5: Receiver might be null."} true ==> (this != null);
  assert {:msg "  230.5: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
  assert {:msg "  230.21: Receiver might be null."} true && (!(Heap[this, SortedTreeNode.right] == null)) ==> (this != null);
  assert {:msg "  230.21: Location might not be readable."} true && (!(Heap[this, SortedTreeNode.right] == null)) ==> CanRead(Mask, this, SortedTreeNode.shared);
  if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  233.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  233.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
    assume Fractions(50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  234.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  234.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  235.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  235.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_214[Heap[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_214, Mask);
    assert {:msg "  236.9: Receiver might be null."} true ==> (this != null);
    assert {:msg "  236.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assert {:msg "  236.9: Receiver might be null."} true ==> (Heap[this, SortedTreeNode.right] != null);
    assert {:msg "  236.9: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeNode.right], SortedTreeNode.shared);
    assume !Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  assert {:msg "  240.4: Receiver might be null."} true ==> (this != null);
  assert {:msg "  240.4: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
  if (!(Heap[this, SortedTreeNode.right] == null)) {
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= rk#28#61) ==> (this != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= rk#28#61) ==> CanRead(Mask, this, SortedTreeNode.right);
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= rk#28#61) ==> (Heap[this, SortedTreeNode.right] != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= rk#28#61) ==> CanRead(Mask, Heap[this, SortedTreeNode.right], SortedTreeNode.keys);
    assert {:msg "  242.33: Receiver might be null."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (this != null);
    assert {:msg "  242.33: Location might not be readable."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> CanRead(Mask, this, SortedTreeNode.key);
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (this != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> CanRead(Mask, this, SortedTreeNode.right);
    assert {:msg "  184.6: Receiver might be null."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.right] != null);
    assert {:msg "  184.6: Location might not be readable."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> CanRead(Mask, Heap[this, SortedTreeNode.right], SortedTreeNode.keys);
    assert {:msg "  242.39: Sequence index might be negative."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (0 <= rk#28#61);
    assert {:msg "  242.39: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= rk#28#61) && (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (rk#28#61 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys]));
    assume (forall rk#28#59: int :: (0 <= rk#28#59) && (rk#28#59 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.key] < Seq#Index(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], rk#28#59)));
  } else {
  }
  assert {:msg "  245.6: Receiver might be null."} true ==> (this != null);
  assert {:msg "  245.6: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.keys);
  assert {:msg "  245.25: Receiver might be null."} true ==> (this != null);
  assert {:msg "  245.25: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
  if (Heap[this, SortedTreeNode.left] == null) {
  } else {
    assert {:msg "  245.49: Receiver might be null."} true ==> (this != null);
    assert {:msg "  245.49: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
    assert {:msg "  245.49: Receiver might be null."} true ==> (Heap[this, SortedTreeNode.left] != null);
    assert {:msg "  245.49: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeNode.left], SortedTreeNode.keys);
  }
  assert {:msg "  245.65: Receiver might be null."} true ==> (this != null);
  assert {:msg "  245.65: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
  assert {:msg "  245.75: Receiver might be null."} true ==> (this != null);
  assert {:msg "  245.75: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
  if (Heap[this, SortedTreeNode.right] == null) {
  } else {
    assert {:msg "  245.100: Receiver might be null."} true ==> (this != null);
    assert {:msg "  245.100: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
    assert {:msg "  245.100: Receiver might be null."} true ==> (Heap[this, SortedTreeNode.right] != null);
    assert {:msg "  245.100: Location might not be readable."} true ==> CanRead(Mask, Heap[this, SortedTreeNode.right], SortedTreeNode.keys);
  }
  assume Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[this, SortedTreeNode.key])), ite(Heap[this, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])));
  assert {:msg "  246.6: Receiver might be null."} true ==> (this != null);
  assert {:msg "  246.6: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
  assert {:msg "  246.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  246.13: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.keys);
  assume Seq#Contains(Heap[this, SortedTreeNode.keys], Heap[this, SortedTreeNode.key]);
  assert {:msg "  248.13: Receiver might be null."} true ==> (this != null);
  assert {:msg "  248.13: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.keys);
  assert {:msg "  250.9: Receiver might be null."} true ==> (this != null);
  assert {:msg "  250.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
  assert {:msg "  250.30: Receiver might be null."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> (this != null);
  assert {:msg "  250.30: Location might not be readable."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> CanRead(Mask, this, SortedTreeNode.left);
  assert {:msg "  250.30: Receiver might be null."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> (Heap[this, SortedTreeNode.left] != null);
  assert {:msg "  250.30: Location might not be readable."} true && (!(Heap[this, SortedTreeNode.left] == null)) ==> CanRead(Mask, Heap[this, SortedTreeNode.left], SortedTreeNode.keys);
  assert {:msg "  250.48: Receiver might be null."} true && (!((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62))) ==> (this != null);
  assert {:msg "  250.48: Location might not be readable."} true && (!((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62))) ==> CanRead(Mask, this, SortedTreeNode.right);
  assert {:msg "  250.69: Receiver might be null."} true && (!((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62))) && (!(Heap[this, SortedTreeNode.right] == null)) ==> (this != null);
  assert {:msg "  250.69: Location might not be readable."} true && (!((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62))) && (!(Heap[this, SortedTreeNode.right] == null)) ==> CanRead(Mask, this, SortedTreeNode.right);
  assert {:msg "  250.69: Receiver might be null."} true && (!((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62))) && (!(Heap[this, SortedTreeNode.right] == null)) ==> (Heap[this, SortedTreeNode.right] != null);
  assert {:msg "  250.69: Location might not be readable."} true && (!((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62))) && (!(Heap[this, SortedTreeNode.right] == null)) ==> CanRead(Mask, Heap[this, SortedTreeNode.right], SortedTreeNode.keys);
  assert {:msg "  250.91: Receiver might be null."} true && (!(((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#62)))) ==> (this != null);
  assert {:msg "  250.91: Location might not be readable."} true && (!(((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#62)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#62)))) ==> CanRead(Mask, this, SortedTreeNode.key);
  assume (forall kk#29: int :: Seq#Contains(Heap[this, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[this, SortedTreeNode.key])));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTreeNode.init$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t), k#15: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_215: int;
  var inhaleHeap#_216: HeapType;
  var inhaleHeap#_217: HeapType;
  assume (0 < methodK#_215) && ((1000 * methodK#_215) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_216;
  assume IsGoodInhaleState(inhaleHeap#_216, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.key] := inhaleHeap#_216[this, SortedTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.key] := Mask[this, SortedTreeNode.key][perm$R := Mask[this, SortedTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_216[this, SortedTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_216, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.left] := inhaleHeap#_216[this, SortedTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.left] == null) || (dtype(Heap[this, SortedTreeNode.left]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.left] := Mask[this, SortedTreeNode.left][perm$R := Mask[this, SortedTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_216[this, SortedTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_216, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.right] := inhaleHeap#_216[this, SortedTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.right] == null) || (dtype(Heap[this, SortedTreeNode.right]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.right] := Mask[this, SortedTreeNode.right][perm$R := Mask[this, SortedTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_216[this, SortedTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_216, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_216[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_216[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_216, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.shared] := inhaleHeap#_216[this, SortedTreeNode.shared];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.shared] := Mask[this, SortedTreeNode.shared][perm$R := Mask[this, SortedTreeNode.shared][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_216[this, SortedTreeNode.shared]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_216, Mask);
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
  havoc inhaleHeap#_217;
  assume IsGoodInhaleState(inhaleHeap#_217, Heap, Mask);
  assert {:msg "  263.11: Receiver might be null."} this != null;
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_217[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_217[this, SortedTreeNode.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_217[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_217, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_217[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_217[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_217, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.shared] := inhaleHeap#_217[this, SortedTreeNode.shared];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, SortedTreeNode.shared] := Mask[this, SortedTreeNode.shared][perm$R := Mask[this, SortedTreeNode.shared][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_217[this, SortedTreeNode.shared]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_217, Mask);
  assert {:msg "  266.12: Receiver might be null."} true ==> (this != null);
  assert {:msg "  266.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.shared);
  assume !Heap[this, SortedTreeNode.shared];
  assert {:msg "  268.11: Receiver might be null."} true ==> (this != null);
  assert {:msg "  268.11: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.keys);
  assume Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Singleton(k#15));
  assert {:msg "  270.16: Receiver might be null."} true ==> (this != null);
  assert {:msg "  270.16: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.keys);
  assume Seq#Contains(Heap[this, SortedTreeNode.keys], k#15);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTreeNode.init(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t), k#15: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_215: int;
  var inhaleHeap#_218: HeapType;
  var Heap#_222: HeapType;
  var Mask#_223: MaskType;
  var Credits#_224: CreditsType;
  var exhaleMask#_225: MaskType;
  var foldK#_226: int;
  var exhaleMask#_227: MaskType;
  var inhaleHeap#_245: HeapType;
  var exhaleMask#_246: MaskType;
  assume (0 < methodK#_215) && ((1000 * methodK#_215) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_218;
  assume IsGoodInhaleState(inhaleHeap#_218, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.key] := inhaleHeap#_218[this, SortedTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.key] := Mask[this, SortedTreeNode.key][perm$R := Mask[this, SortedTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_218[this, SortedTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_218, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.left] := inhaleHeap#_218[this, SortedTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.left] == null) || (dtype(Heap[this, SortedTreeNode.left]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.left] := Mask[this, SortedTreeNode.left][perm$R := Mask[this, SortedTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_218[this, SortedTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_218, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.right] := inhaleHeap#_218[this, SortedTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.right] == null) || (dtype(Heap[this, SortedTreeNode.right]) == SortedTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.right] := Mask[this, SortedTreeNode.right][perm$R := Mask[this, SortedTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_218[this, SortedTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_218, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_218[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_218[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_218, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.shared] := inhaleHeap#_218[this, SortedTreeNode.shared];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.shared] := Mask[this, SortedTreeNode.shared][perm$R := Mask[this, SortedTreeNode.shared][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_218[this, SortedTreeNode.shared]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_218, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // update field left
  assert {:msg "  272.3: Location might not be writable"} CanWrite(Mask, this, SortedTreeNode.left);
  Heap[this, SortedTreeNode.left] := null;
  assume wf(Heap, Mask);
  // update field right
  assert {:msg "  273.3: Location might not be writable"} CanWrite(Mask, this, SortedTreeNode.right);
  Heap[this, SortedTreeNode.right] := null;
  assume wf(Heap, Mask);
  // update field key
  assert {:msg "  274.3: Location might not be writable"} CanWrite(Mask, this, SortedTreeNode.key);
  Heap[this, SortedTreeNode.key] := k#15;
  assume wf(Heap, Mask);
  // update field shared
  assert {:msg "  275.3: Location might not be writable"} CanWrite(Mask, this, SortedTreeNode.shared);
  Heap[this, SortedTreeNode.shared] := false;
  assume wf(Heap, Mask);
  // assert
  Heap#_222 := Heap;
  Mask#_223 := Mask;
  Credits#_224 := Credits;
  // begin exhale (assert)
  exhaleMask#_225 := Mask#_223;
  assert {:msg "  277.10: Sequence index might be negative."} true ==> (0 <= 0);
  assert {:msg "  277.10: Sequence index might be larger than or equal to the length of the sequence."} true ==> (0 < Seq#Length(Seq#Singleton(k#15)));
  assert {:msg "  277.3: Assertion might not hold. The expression at 277.10 might not evaluate to true."} Seq#Index(Seq#Singleton(k#15), 0) == k#15;
  Mask#_223 := exhaleMask#_225;
  assume wf(Heap#_222, Mask#_223);
  // end exhale
  // update field keys
  assert {:msg "  278.3: Location might not be writable"} CanWrite(Mask, this, SortedTreeNode.keys);
  Heap[this, SortedTreeNode.keys] := Seq#Singleton(k#15);
  assume wf(Heap, Mask);
  // fold
  assume (0 < foldK#_226) && ((1000 * foldK#_226) < Fractions(1)) && ((1000 * foldK#_226) < methodK#_215);
  assert {:msg "  279.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_227 := Mask;
  if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 198.8 might not evaluate to true."} Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 209.8 might not evaluate to true."} !Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.left] == null)) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 215.6 might not evaluate to true."} (forall lk#27#63: int :: (0 <= lk#27#63) && (lk#27#63 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], lk#27#63) < Heap[this, SortedTreeNode.key]));
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 225.8 might not evaluate to true."} Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 236.8 might not evaluate to true."} !Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.right] == null)) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 242.6 might not evaluate to true."} (forall rk#28#64: int :: (0 <= rk#28#64) && (rk#28#64 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.key] < Seq#Index(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], rk#28#64)));
  } else {
  }
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 245.6 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[this, SortedTreeNode.key])), ite(Heap[this, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])));
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 246.6 might not evaluate to true."} Seq#Contains(Heap[this, SortedTreeNode.keys], Heap[this, SortedTreeNode.key]);
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 247.7 might not evaluate to true."} (forall kk#29: int :: Seq#Contains(Heap[this, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[this, SortedTreeNode.key])));
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 184.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 184.6 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_227[this, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_227[this, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_227[this, SortedTreeNode.key][perm$N]));
  exhaleMask#_227[this, SortedTreeNode.key] := exhaleMask#_227[this, SortedTreeNode.key][perm$R := exhaleMask#_227[this, SortedTreeNode.key][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_227);
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 185.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 185.6 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_227[this, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_227[this, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_227[this, SortedTreeNode.left][perm$N]));
  exhaleMask#_227[this, SortedTreeNode.left] := exhaleMask#_227[this, SortedTreeNode.left][perm$R := exhaleMask#_227[this, SortedTreeNode.left][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_227);
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 186.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 186.6 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_227[this, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_227[this, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_227[this, SortedTreeNode.right][perm$N]));
  exhaleMask#_227[this, SortedTreeNode.right] := exhaleMask#_227[this, SortedTreeNode.right][perm$R := exhaleMask#_227[this, SortedTreeNode.right][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_227);
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 188.6 might not be positive."} Fractions(50) > 0;
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 188.6 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_227[this, SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_227[this, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_227[this, SortedTreeNode.keys][perm$N]));
  exhaleMask#_227[this, SortedTreeNode.keys] := exhaleMask#_227[this, SortedTreeNode.keys][perm$R := exhaleMask#_227[this, SortedTreeNode.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_227);
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 189.6 might not be positive."} Fractions(50) > 0;
  assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 189.6 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_227[this, SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_227[this, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_227[this, SortedTreeNode.shared][perm$N]));
  exhaleMask#_227[this, SortedTreeNode.shared] := exhaleMask#_227[this, SortedTreeNode.shared][perm$R := exhaleMask#_227[this, SortedTreeNode.shared][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_227);
  if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 195.8 might not be positive."} Fractions(1) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 195.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 196.8 might not be positive."} Fractions(1) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 196.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 197.8 might not be positive."} Fractions(1) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 197.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 206.8 might not be positive."} Fractions(50) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 206.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 207.8 might not be positive."} Fractions(50) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 207.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 208.8 might not be positive."} Fractions(50) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 208.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
  } else {
  }
  if (!(Heap[this, SortedTreeNode.left] == null)) {
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 222.8 might not be positive."} Fractions(1) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 222.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 223.8 might not be positive."} Fractions(1) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 223.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 224.8 might not be positive."} Fractions(1) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 224.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 233.8 might not be positive."} Fractions(50) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 233.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 234.8 might not be positive."} Fractions(50) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 234.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 235.8 might not be positive."} Fractions(50) > 0;
    assert {:msg "  279.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 235.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
    exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_227[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_227);
  } else {
  }
  if (!(Heap[this, SortedTreeNode.right] == null)) {
  } else {
  }
  Mask := exhaleMask#_227;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_245;
  assume IsGoodInhaleState(inhaleHeap#_245, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_245[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_245[this, SortedTreeNode.valid] == Heap;
  assume Fractions(100) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_245[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_245, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, SortedTreeNode.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_246 := Mask;
  assert {:msg "  255.2: The postcondition at 266.11 might not hold. The expression at 266.11 might not evaluate to true."} !Heap[this, SortedTreeNode.shared];
  assert {:msg "  255.2: The postcondition at 268.11 might not hold. The expression at 268.11 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Singleton(k#15));
  assert {:msg "  255.2: The postcondition at 270.11 might not hold. The expression at 270.11 might not evaluate to true."} Seq#Contains(Heap[this, SortedTreeNode.keys], k#15);
  assert {:msg "  255.2: The postcondition at 263.11 might not hold. The permission at 263.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  255.2: The postcondition at 263.11 might not hold. Insufficient fraction at 263.11 for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_246[this, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_246[this, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_246[this, SortedTreeNode.valid][perm$N]));
  exhaleMask#_246[this, SortedTreeNode.valid] := exhaleMask#_246[this, SortedTreeNode.valid][perm$R := exhaleMask#_246[this, SortedTreeNode.valid][perm$R] - Fractions(100)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_246);
  assert {:msg "  255.2: The postcondition at 264.11 might not hold. The permission at 264.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  255.2: The postcondition at 264.11 might not hold. Insufficient fraction at 264.11 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_246[this, SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_246[this, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_246[this, SortedTreeNode.keys][perm$N]));
  exhaleMask#_246[this, SortedTreeNode.keys] := exhaleMask#_246[this, SortedTreeNode.keys][perm$R := exhaleMask#_246[this, SortedTreeNode.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_246);
  assert {:msg "  255.2: The postcondition at 265.11 might not hold. The permission at 265.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  255.2: The postcondition at 265.11 might not hold. Insufficient fraction at 265.11 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_246[this, SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_246[this, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_246[this, SortedTreeNode.shared][perm$N]));
  exhaleMask#_246[this, SortedTreeNode.shared] := exhaleMask#_246[this, SortedTreeNode.shared][perm$R := exhaleMask#_246[this, SortedTreeNode.shared][perm$R] - Fractions(50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_246);
  Mask := exhaleMask#_246;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  255.2: Method might lock/unlock more than allowed."} (forall lk#_250: ref :: {Heap[lk#_250, held]} {Heap[lk#_250, rdheld]} (((0 < Heap[lk#_250, held]) == (0 < old(Heap)[lk#_250, held])) && (Heap[lk#_250, rdheld] == old(Heap)[lk#_250, rdheld])) || false);
  assert {:msg "  255.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure SortedTreeNode.has$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t), k#16: int where true) returns (b#17: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_251: int;
  var inhaleHeap#_252: HeapType;
  var inhaleHeap#_253: HeapType;
  assume (0 < methodK#_251) && ((1000 * methodK#_251) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_252;
  assume IsGoodInhaleState(inhaleHeap#_252, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_252[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_252[this, SortedTreeNode.valid] == Heap;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_252[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_252, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_252[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_252[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_252, Mask);
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
  havoc inhaleHeap#_253;
  assume IsGoodInhaleState(inhaleHeap#_253, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_253[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_253[this, SortedTreeNode.valid] == Heap;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_253[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_253, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_253[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_253[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_253, Mask);
  assert {:msg "  289.22: Receiver might be null."} true ==> (this != null);
  assert {:msg "  289.22: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.keys);
  assume b#17 == Seq#Contains(Heap[this, SortedTreeNode.keys], k#16);
  assert {:msg "  290.11: Receiver might be null."} true ==> (this != null);
  assert {:msg "  290.11: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.keys);
  assert {:msg "  290.23: Receiver might be null."} true ==> (this != null);
  assert {:msg "  290.23: Location might not be readable."} true ==> CanRead(old(Mask), this, SortedTreeNode.keys);
  assume Seq#Equal(Heap[this, SortedTreeNode.keys], old(Heap)[this, SortedTreeNode.keys]);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTreeNode.has(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t), k#16: int where true) returns (b#17: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_251: int;
  var inhaleHeap#_254: HeapType;
  var unfoldK#_255: int;
  var exhaleMask#_256: MaskType;
  var inhaleHeap#_258: HeapType;
  var methodCallK#_262: int;
  var this#69: ref where (this#69 == null) || (dtype(this#69) == SortedTreeNode#t);
  var k#70: int where true;
  var b#71: bool where true;
  var callHeap#_259: HeapType;
  var callMask#_260: MaskType;
  var callCredits#_261: CreditsType;
  var exhaleMask#_263: MaskType;
  var isHeld#_266: int;
  var isRdHeld#_267: bool;
  var inhaleHeap#_268: HeapType;
  var Heap#_272: HeapType;
  var Mask#_273: MaskType;
  var Credits#_274: CreditsType;
  var exhaleMask#_275: MaskType;
  var lk#30#73: int where true;
  var methodCallK#_279: int;
  var this#75: ref where (this#75 == null) || (dtype(this#75) == SortedTreeNode#t);
  var k#76: int where true;
  var b#77: bool where true;
  var callHeap#_276: HeapType;
  var callMask#_277: MaskType;
  var callCredits#_278: CreditsType;
  var exhaleMask#_280: MaskType;
  var isHeld#_283: int;
  var isRdHeld#_284: bool;
  var inhaleHeap#_285: HeapType;
  var Heap#_289: HeapType;
  var Mask#_290: MaskType;
  var Credits#_291: CreditsType;
  var exhaleMask#_292: MaskType;
  var lk#31#79: int where true;
  var foldK#_293: int;
  var exhaleMask#_294: MaskType;
  var inhaleHeap#_312: HeapType;
  var exhaleMask#_313: MaskType;
  assume (0 < methodK#_251) && ((1000 * methodK#_251) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_254;
  assume IsGoodInhaleState(inhaleHeap#_254, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_254[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_254[this, SortedTreeNode.valid] == Heap;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_254[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_254, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_254[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_254[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_254, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assume (0 < unfoldK#_255) && (unfoldK#_255 < Fractions(1)) && ((1000 * unfoldK#_255) < methodK#_251);
  assert {:msg "  292.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_256 := Mask;
  assert {:msg "  292.3: unfold might fail because the predicate SortedTreeNode.valid does not hold. The permission at 292.10 might not be positive."} Fractions(1) > 0;
  assert {:msg "  292.3: unfold might fail because the predicate SortedTreeNode.valid does not hold. Insufficient fraction at 292.10 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_256[this, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_256[this, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_256[this, SortedTreeNode.valid][perm$N]));
  exhaleMask#_256[this, SortedTreeNode.valid] := exhaleMask#_256[this, SortedTreeNode.valid][perm$R := exhaleMask#_256[this, SortedTreeNode.valid][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_256);
  Mask := exhaleMask#_256;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_258 := Heap[this, SortedTreeNode.valid];
  assume IsGoodInhaleState(inhaleHeap#_258, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.key] := inhaleHeap#_258[this, SortedTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.key] := Mask[this, SortedTreeNode.key][perm$R := Mask[this, SortedTreeNode.key][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_258[this, SortedTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_258, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.left] := inhaleHeap#_258[this, SortedTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.left] == null) || (dtype(Heap[this, SortedTreeNode.left]) == SortedTreeNode#t);
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.left] := Mask[this, SortedTreeNode.left][perm$R := Mask[this, SortedTreeNode.left][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_258[this, SortedTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_258, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.right] := inhaleHeap#_258[this, SortedTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.right] == null) || (dtype(Heap[this, SortedTreeNode.right]) == SortedTreeNode#t);
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.right] := Mask[this, SortedTreeNode.right][perm$R := Mask[this, SortedTreeNode.right][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_258[this, SortedTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_258, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_258[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1 * 50) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_258[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_258, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.shared] := inhaleHeap#_258[this, SortedTreeNode.shared];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1 * 50) > 0;
  Mask[this, SortedTreeNode.shared] := Mask[this, SortedTreeNode.shared][perm$R := Mask[this, SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_258[this, SortedTreeNode.shared]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_258, Mask);
  if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume !Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.left] == null)) {
    assume (forall lk#27#67: int :: (0 <= lk#27#67) && (lk#27#67 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], lk#27#67) < Heap[this, SortedTreeNode.key]));
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_258[Heap[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_258, Mask);
    assume !Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.right] == null)) {
    assume (forall rk#28#68: int :: (0 <= rk#28#68) && (rk#28#68 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.key] < Seq#Index(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], rk#28#68)));
  } else {
  }
  assume Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[this, SortedTreeNode.key])), ite(Heap[this, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])));
  assume Seq#Contains(Heap[this, SortedTreeNode.keys], Heap[this, SortedTreeNode.key]);
  assume (forall kk#29: int :: Seq#Contains(Heap[this, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[this, SortedTreeNode.key])));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // if
  assert {:msg "  294.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  294.10: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
  if (k#16 == Heap[this, SortedTreeNode.key]) {
    // assigment to b
    b#17 := true;
  } else {
    // if
    assert {:msg "  301.12: Receiver might be null."} true ==> (this != null);
    assert {:msg "  301.12: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
    if (k#16 < Heap[this, SortedTreeNode.key]) {
      // if
      assert {:msg "  302.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  302.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
      if (!(Heap[this, SortedTreeNode.left] == null)) {
        assume (0 < methodCallK#_262) && ((1000 * methodCallK#_262) < Fractions(1)) && ((1000 * methodCallK#_262) < methodK#_251);
        // call has
        callHeap#_259 := Heap;
        callMask#_260 := Mask;
        callCredits#_261 := Credits;
        assert {:msg "  303.16: Receiver might be null."} true ==> (this != null);
        assert {:msg "  303.16: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
        assert {:msg "  303.6: The target of the method call might be null."} Heap[this, SortedTreeNode.left] != null;
        this#69 := Heap[this, SortedTreeNode.left];
        k#70 := k#16;
        // begin exhale (precondition)
        exhaleMask#_263 := Mask;
        assert {:msg "  303.6: The precondition at 284.12 might not hold. The permission at 284.12 might not be positive."} Fractions(1) > 0;
        assert {:msg "  303.6: The precondition at 284.12 might not hold. Insufficient fraction at 284.12 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_263[this#69, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_263[this#69, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_263[this#69, SortedTreeNode.valid][perm$N]));
        exhaleMask#_263[this#69, SortedTreeNode.valid] := exhaleMask#_263[this#69, SortedTreeNode.valid][perm$R := exhaleMask#_263[this#69, SortedTreeNode.valid][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_263);
        assert {:msg "  303.6: The precondition at 285.12 might not hold. The permission at 285.12 might not be positive."} Fractions(1) > 0;
        assert {:msg "  303.6: The precondition at 285.12 might not hold. Insufficient fraction at 285.12 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_263[this#69, SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_263[this#69, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_263[this#69, SortedTreeNode.keys][perm$N]));
        exhaleMask#_263[this#69, SortedTreeNode.keys] := exhaleMask#_263[this#69, SortedTreeNode.keys][perm$R := exhaleMask#_263[this#69, SortedTreeNode.keys][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_263);
        Mask := exhaleMask#_263;
        assume wf(Heap, Mask);
        // end exhale
        havoc b#71;
        // inhale (postcondition)
        havoc inhaleHeap#_268;
        assume IsGoodInhaleState(inhaleHeap#_268, Heap, Mask);
        assume this#69 != null;
        Heap[this#69, SortedTreeNode.valid] := inhaleHeap#_268[this#69, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_268[this#69, SortedTreeNode.valid] == Heap;
        assume Fractions(1) > 0;
        Mask[this#69, SortedTreeNode.valid] := Mask[this#69, SortedTreeNode.valid][perm$R := Mask[this#69, SortedTreeNode.valid][perm$R] + Fractions(1)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_268[this#69, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_268, Mask);
        assume this#69 != null;
        Heap[this#69, SortedTreeNode.keys] := inhaleHeap#_268[this#69, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(1) > 0;
        Mask[this#69, SortedTreeNode.keys] := Mask[this#69, SortedTreeNode.keys][perm$R := Mask[this#69, SortedTreeNode.keys][perm$R] + Fractions(1)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_268[this#69, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_268, Mask);
        assume b#71 == Seq#Contains(Heap[this#69, SortedTreeNode.keys], k#70);
        assume Seq#Equal(Heap[this#69, SortedTreeNode.keys], callHeap#_259[this#69, SortedTreeNode.keys]);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        b#17 := b#71;
      } else {
        // assigment to b
        b#17 := false;
      }
      // assert
      Heap#_272 := Heap;
      Mask#_273 := Mask;
      Credits#_274 := Credits;
      // begin exhale (assert)
      exhaleMask#_275 := Mask#_273;
      assert {:msg "  307.13: Receiver might be null."} true ==> (this != null);
      assert {:msg "  307.13: Location might not be readable."} true ==> CanRead(Mask#_273, this, SortedTreeNode.left);
      if (!(Heap#_272[this, SortedTreeNode.left] == null)) {
        assert {:msg "  307.13: Receiver might be null."} true && (0 <= lk#30#73) ==> (this != null);
        assert {:msg "  307.13: Location might not be readable."} true && (0 <= lk#30#73) ==> CanRead(Mask#_273, this, SortedTreeNode.left);
        assert {:msg "  307.13: Receiver might be null."} true && (0 <= lk#30#73) ==> (Heap#_272[this, SortedTreeNode.left] != null);
        assert {:msg "  307.13: Location might not be readable."} true && (0 <= lk#30#73) ==> CanRead(Mask#_273, Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys);
        assert {:msg "  307.13: Receiver might be null."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (this != null);
        assert {:msg "  307.13: Location might not be readable."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask#_273, this, SortedTreeNode.left);
        assert {:msg "  307.13: Receiver might be null."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Heap#_272[this, SortedTreeNode.left] != null);
        assert {:msg "  307.13: Location might not be readable."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask#_273, Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys);
        assert {:msg "  307.54: Sequence index might be negative."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (0 <= lk#30#73);
        assert {:msg "  307.54: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys]));
        assert {:msg "  307.59: Receiver might be null."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (this != null);
        assert {:msg "  307.59: Location might not be readable."} true && (0 <= lk#30#73) && (lk#30#73 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask#_273, this, SortedTreeNode.key);
        assert {:msg "  307.5: Assertion might not hold. The expression at 307.28 might not evaluate to true."} (forall lk#30#72: int :: (0 <= lk#30#72) && (lk#30#72 < Seq#Length(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap#_272[Heap#_272[this, SortedTreeNode.left], SortedTreeNode.keys], lk#30#72) < Heap#_272[this, SortedTreeNode.key]));
      } else {
      }
      if (!(Heap#_272[this, SortedTreeNode.left] == null)) {
      } else {
      }
      Mask#_273 := exhaleMask#_275;
      assume wf(Heap#_272, Mask#_273);
      // end exhale
    } else {
      // if
      assert {:msg "  309.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  309.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
      if (!(Heap[this, SortedTreeNode.right] == null)) {
        assume (0 < methodCallK#_279) && ((1000 * methodCallK#_279) < Fractions(1)) && ((1000 * methodCallK#_279) < methodK#_251);
        // call has
        callHeap#_276 := Heap;
        callMask#_277 := Mask;
        callCredits#_278 := Credits;
        assert {:msg "  310.16: Receiver might be null."} true ==> (this != null);
        assert {:msg "  310.16: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
        assert {:msg "  310.6: The target of the method call might be null."} Heap[this, SortedTreeNode.right] != null;
        this#75 := Heap[this, SortedTreeNode.right];
        k#76 := k#16;
        // begin exhale (precondition)
        exhaleMask#_280 := Mask;
        assert {:msg "  310.6: The precondition at 284.12 might not hold. The permission at 284.12 might not be positive."} Fractions(1) > 0;
        assert {:msg "  310.6: The precondition at 284.12 might not hold. Insufficient fraction at 284.12 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_280[this#75, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_280[this#75, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_280[this#75, SortedTreeNode.valid][perm$N]));
        exhaleMask#_280[this#75, SortedTreeNode.valid] := exhaleMask#_280[this#75, SortedTreeNode.valid][perm$R := exhaleMask#_280[this#75, SortedTreeNode.valid][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_280);
        assert {:msg "  310.6: The precondition at 285.12 might not hold. The permission at 285.12 might not be positive."} Fractions(1) > 0;
        assert {:msg "  310.6: The precondition at 285.12 might not hold. Insufficient fraction at 285.12 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_280[this#75, SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_280[this#75, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_280[this#75, SortedTreeNode.keys][perm$N]));
        exhaleMask#_280[this#75, SortedTreeNode.keys] := exhaleMask#_280[this#75, SortedTreeNode.keys][perm$R := exhaleMask#_280[this#75, SortedTreeNode.keys][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_280);
        Mask := exhaleMask#_280;
        assume wf(Heap, Mask);
        // end exhale
        havoc b#77;
        // inhale (postcondition)
        havoc inhaleHeap#_285;
        assume IsGoodInhaleState(inhaleHeap#_285, Heap, Mask);
        assume this#75 != null;
        Heap[this#75, SortedTreeNode.valid] := inhaleHeap#_285[this#75, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_285[this#75, SortedTreeNode.valid] == Heap;
        assume Fractions(1) > 0;
        Mask[this#75, SortedTreeNode.valid] := Mask[this#75, SortedTreeNode.valid][perm$R := Mask[this#75, SortedTreeNode.valid][perm$R] + Fractions(1)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_285[this#75, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_285, Mask);
        assume this#75 != null;
        Heap[this#75, SortedTreeNode.keys] := inhaleHeap#_285[this#75, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(1) > 0;
        Mask[this#75, SortedTreeNode.keys] := Mask[this#75, SortedTreeNode.keys][perm$R := Mask[this#75, SortedTreeNode.keys][perm$R] + Fractions(1)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_285[this#75, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_285, Mask);
        assume b#77 == Seq#Contains(Heap[this#75, SortedTreeNode.keys], k#76);
        assume Seq#Equal(Heap[this#75, SortedTreeNode.keys], callHeap#_276[this#75, SortedTreeNode.keys]);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        b#17 := b#77;
      } else {
        // assigment to b
        b#17 := false;
      }
      // assert
      Heap#_289 := Heap;
      Mask#_290 := Mask;
      Credits#_291 := Credits;
      // begin exhale (assert)
      exhaleMask#_292 := Mask#_290;
      assert {:msg "  314.13: Receiver might be null."} true ==> (this != null);
      assert {:msg "  314.13: Location might not be readable."} true ==> CanRead(Mask#_290, this, SortedTreeNode.left);
      if (!(Heap#_289[this, SortedTreeNode.left] == null)) {
        assert {:msg "  314.13: Receiver might be null."} true && (0 <= lk#31#79) ==> (this != null);
        assert {:msg "  314.13: Location might not be readable."} true && (0 <= lk#31#79) ==> CanRead(Mask#_290, this, SortedTreeNode.left);
        assert {:msg "  314.13: Receiver might be null."} true && (0 <= lk#31#79) ==> (Heap#_289[this, SortedTreeNode.left] != null);
        assert {:msg "  314.13: Location might not be readable."} true && (0 <= lk#31#79) ==> CanRead(Mask#_290, Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys);
        assert {:msg "  314.13: Receiver might be null."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (this != null);
        assert {:msg "  314.13: Location might not be readable."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask#_290, this, SortedTreeNode.left);
        assert {:msg "  314.13: Receiver might be null."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Heap#_289[this, SortedTreeNode.left] != null);
        assert {:msg "  314.13: Location might not be readable."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask#_290, Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys);
        assert {:msg "  314.54: Sequence index might be negative."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (0 <= lk#31#79);
        assert {:msg "  314.54: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys]));
        assert {:msg "  314.59: Receiver might be null."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (this != null);
        assert {:msg "  314.59: Location might not be readable."} true && (0 <= lk#31#79) && (lk#31#79 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> CanRead(Mask#_290, this, SortedTreeNode.key);
        assert {:msg "  314.5: Assertion might not hold. The expression at 314.28 might not evaluate to true."} (forall lk#31#78: int :: (0 <= lk#31#78) && (lk#31#78 < Seq#Length(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap#_289[Heap#_289[this, SortedTreeNode.left], SortedTreeNode.keys], lk#31#78) < Heap#_289[this, SortedTreeNode.key]));
      } else {
      }
      if (!(Heap#_289[this, SortedTreeNode.left] == null)) {
      } else {
      }
      Mask#_290 := exhaleMask#_292;
      assume wf(Heap#_289, Mask#_290);
      // end exhale
    }
  }
  // fold
  assume (0 < foldK#_293) && ((1000 * foldK#_293) < Fractions(1)) && ((1000 * foldK#_293) < methodK#_251);
  assert {:msg "  318.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_294 := Mask;
  if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 198.8 might not evaluate to true."} Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 209.8 might not evaluate to true."} !Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.left] == null)) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 215.6 might not evaluate to true."} (forall lk#27#81: int :: (0 <= lk#27#81) && (lk#27#81 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], lk#27#81) < Heap[this, SortedTreeNode.key]));
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 225.8 might not evaluate to true."} Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 236.8 might not evaluate to true."} !Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.right] == null)) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 242.6 might not evaluate to true."} (forall rk#28#82: int :: (0 <= rk#28#82) && (rk#28#82 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.key] < Seq#Index(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], rk#28#82)));
  } else {
  }
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 245.6 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[this, SortedTreeNode.key])), ite(Heap[this, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])));
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 246.6 might not evaluate to true."} Seq#Contains(Heap[this, SortedTreeNode.keys], Heap[this, SortedTreeNode.key]);
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 247.7 might not evaluate to true."} (forall kk#29: int :: Seq#Contains(Heap[this, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[this, SortedTreeNode.key])));
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 184.6 might not be positive."} Fractions(1) > 0;
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 184.6 for SortedTreeNode.key."} (Fractions(1) <= exhaleMask#_294[this, SortedTreeNode.key][perm$R]) && ((Fractions(1) == exhaleMask#_294[this, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_294[this, SortedTreeNode.key][perm$N]));
  exhaleMask#_294[this, SortedTreeNode.key] := exhaleMask#_294[this, SortedTreeNode.key][perm$R := exhaleMask#_294[this, SortedTreeNode.key][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_294);
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 185.6 might not be positive."} Fractions(1) > 0;
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 185.6 for SortedTreeNode.left."} (Fractions(1) <= exhaleMask#_294[this, SortedTreeNode.left][perm$R]) && ((Fractions(1) == exhaleMask#_294[this, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_294[this, SortedTreeNode.left][perm$N]));
  exhaleMask#_294[this, SortedTreeNode.left] := exhaleMask#_294[this, SortedTreeNode.left][perm$R := exhaleMask#_294[this, SortedTreeNode.left][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_294);
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 186.6 might not be positive."} Fractions(1) > 0;
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 186.6 for SortedTreeNode.right."} (Fractions(1) <= exhaleMask#_294[this, SortedTreeNode.right][perm$R]) && ((Fractions(1) == exhaleMask#_294[this, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_294[this, SortedTreeNode.right][perm$N]));
  exhaleMask#_294[this, SortedTreeNode.right] := exhaleMask#_294[this, SortedTreeNode.right][perm$R := exhaleMask#_294[this, SortedTreeNode.right][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_294);
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 188.6 might not be positive."} Fractions(1 * 50) > 0;
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 188.6 for SortedTreeNode.keys."} (Fractions(1 * 50) <= exhaleMask#_294[this, SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[this, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_294[this, SortedTreeNode.keys][perm$N]));
  exhaleMask#_294[this, SortedTreeNode.keys] := exhaleMask#_294[this, SortedTreeNode.keys][perm$R := exhaleMask#_294[this, SortedTreeNode.keys][perm$R] - Fractions(1 * 50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_294);
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 189.6 might not be positive."} Fractions(1 * 50) > 0;
  assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 189.6 for SortedTreeNode.shared."} (Fractions(1 * 50) <= exhaleMask#_294[this, SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[this, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_294[this, SortedTreeNode.shared][perm$N]));
  exhaleMask#_294[this, SortedTreeNode.shared] := exhaleMask#_294[this, SortedTreeNode.shared][perm$R := exhaleMask#_294[this, SortedTreeNode.shared][perm$R] - Fractions(1 * 50)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_294);
  if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 195.8 might not be positive."} Fractions(1 * 1) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 195.8 for SortedTreeNode.valid."} (Fractions(1 * 1) <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 196.8 might not be positive."} Fractions(1 * 1) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 196.8 for SortedTreeNode.shared."} (Fractions(1 * 1) <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 197.8 might not be positive."} Fractions(1 * 1) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 197.8 for SortedTreeNode.keys."} (Fractions(1 * 1) <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 206.8 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 206.8 for SortedTreeNode.valid."} (Fractions(1 * 50) <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 207.8 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 207.8 for SortedTreeNode.shared."} (Fractions(1 * 50) <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 208.8 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 208.8 for SortedTreeNode.keys."} (Fractions(1 * 50) <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
  } else {
  }
  if (!(Heap[this, SortedTreeNode.left] == null)) {
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 222.8 might not be positive."} Fractions(1 * 1) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 222.8 for SortedTreeNode.valid."} (Fractions(1 * 1) <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 223.8 might not be positive."} Fractions(1 * 1) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 223.8 for SortedTreeNode.shared."} (Fractions(1 * 1) <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 224.8 might not be positive."} Fractions(1 * 1) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 224.8 for SortedTreeNode.keys."} (Fractions(1 * 1) <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 233.8 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 233.8 for SortedTreeNode.valid."} (Fractions(1 * 50) <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 234.8 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 234.8 for SortedTreeNode.shared."} (Fractions(1 * 50) <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 235.8 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  318.3: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 235.8 for SortedTreeNode.keys."} (Fractions(1 * 50) <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
    exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_294[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_294);
  } else {
  }
  if (!(Heap[this, SortedTreeNode.right] == null)) {
  } else {
  }
  Mask := exhaleMask#_294;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_312;
  assume IsGoodInhaleState(inhaleHeap#_312, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_312[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_312[this, SortedTreeNode.valid] == Heap;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_312[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_312, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, SortedTreeNode.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_313 := Mask;
  assert {:msg "  283.2: The postcondition at 289.11 might not hold. The expression at 289.11 might not evaluate to true."} b#17 == Seq#Contains(Heap[this, SortedTreeNode.keys], k#16);
  assert {:msg "  283.2: The postcondition at 290.11 might not hold. The expression at 290.11 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeNode.keys], old(Heap)[this, SortedTreeNode.keys]);
  assert {:msg "  283.2: The postcondition at 287.11 might not hold. The permission at 287.11 might not be positive."} Fractions(1) > 0;
  assert {:msg "  283.2: The postcondition at 287.11 might not hold. Insufficient fraction at 287.11 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_313[this, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_313[this, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_313[this, SortedTreeNode.valid][perm$N]));
  exhaleMask#_313[this, SortedTreeNode.valid] := exhaleMask#_313[this, SortedTreeNode.valid][perm$R := exhaleMask#_313[this, SortedTreeNode.valid][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_313);
  assert {:msg "  283.2: The postcondition at 288.11 might not hold. The permission at 288.11 might not be positive."} Fractions(1) > 0;
  assert {:msg "  283.2: The postcondition at 288.11 might not hold. Insufficient fraction at 288.11 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_313[this, SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_313[this, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_313[this, SortedTreeNode.keys][perm$N]));
  exhaleMask#_313[this, SortedTreeNode.keys] := exhaleMask#_313[this, SortedTreeNode.keys][perm$R := exhaleMask#_313[this, SortedTreeNode.keys][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_313);
  Mask := exhaleMask#_313;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  283.2: Method might lock/unlock more than allowed."} (forall lk#_316: ref :: {Heap[lk#_316, held]} {Heap[lk#_316, rdheld]} (((0 < Heap[lk#_316, held]) == (0 < old(Heap)[lk#_316, held])) && (Heap[lk#_316, rdheld] == old(Heap)[lk#_316, rdheld])) || false);
  assert {:msg "  283.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure SortedTreeNode.insert$checkDefinedness(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t), k#18: int where true, hasClones#19: bool where true) returns (r#20: ref where (r#20 == null) || (dtype(r#20) == SortedTreeNode#t))
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_317: int;
  var inhaleHeap#_318: HeapType;
  var unfoldingK#_325: int;
  var Heap#_322: HeapType;
  var Mask#_323: MaskType;
  var Credits#_324: CreditsType;
  var exhaleMask#_326: MaskType;
  var inhaleHeap#_328: HeapType;
  var inhaleHeap#_329: HeapType;
  var i#32#88: int where true;
  var i#33#90: int where true;
  assume (0 < methodK#_317) && ((1000 * methodK#_317) < Fractions(1));
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_318;
  assume IsGoodInhaleState(inhaleHeap#_318, Heap, Mask);
  if (!hasClones#19) {
    assume this != null;
    Heap[this, SortedTreeNode.valid] := inhaleHeap#_318[this, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_318[this, SortedTreeNode.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_318[this, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_318, Mask);
  } else {
  }
  if (hasClones#19) {
    assume this != null;
    Heap[this, SortedTreeNode.valid] := inhaleHeap#_318[this, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_318[this, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_318[this, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_318, Mask);
  } else {
  }
  if (hasClones#19) {
  } else {
  }
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_318[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_318[this, SortedTreeNode.valid] == Heap;
  assume Fractions(50 - ite(hasClones#19, 49, 0)) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(50 - ite(hasClones#19, 49, 0))];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_318[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_318, Mask);
  if (hasClones#19) {
  } else {
  }
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_318[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50 - ite(hasClones#19, 49, 0)) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(50 - ite(hasClones#19, 49, 0))];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_318[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_318, Mask);
  // unfolding
  assume (0 < unfoldingK#_325) && ((1000 * unfoldingK#_325) < Fractions(1));
  assert {:msg "  <undefined position>: Receiver might be null."} true ==> (this != null);
  Heap#_322 := Heap;
  Mask#_323 := Mask;
  Credits#_324 := Credits;
  // begin exhale (unfolding)
  exhaleMask#_326 := Mask#_323;
  assert {:msg "  329.12: Unfolding might fail. The permission at 329.22 might not be positive."} Fractions(1) > 0;
  assert {:msg "  329.12: Unfolding might fail. Insufficient fraction at 329.22 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_326[this, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_326[this, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_326[this, SortedTreeNode.valid][perm$N]));
  exhaleMask#_326[this, SortedTreeNode.valid] := exhaleMask#_326[this, SortedTreeNode.valid][perm$R := exhaleMask#_326[this, SortedTreeNode.valid][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask#_323);
  assume wf(Heap#_322, Mask#_323);
  assume wf(Heap#_322, exhaleMask#_326);
  Mask#_323 := exhaleMask#_326;
  assume wf(Heap#_322, Mask#_323);
  // end exhale
  // inhale (unfolding)
  inhaleHeap#_328 := Heap[this, SortedTreeNode.valid];
  assume IsGoodInhaleState(inhaleHeap#_328, Heap#_322, Mask#_323);
  assume this != null;
  Heap#_322[this, SortedTreeNode.key] := inhaleHeap#_328[this, SortedTreeNode.key];
  assume wf(Heap#_322, Mask#_323);
  assume true;
  assume Fractions(1) > 0;
  Mask#_323[this, SortedTreeNode.key] := Mask#_323[this, SortedTreeNode.key][perm$R := Mask#_323[this, SortedTreeNode.key][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask#_323);
  assume IsGoodState(inhaleHeap#_328[this, SortedTreeNode.key]);
  assume wf(Heap#_322, Mask#_323);
  assume wf(inhaleHeap#_328, Mask#_323);
  assume this != null;
  Heap#_322[this, SortedTreeNode.left] := inhaleHeap#_328[this, SortedTreeNode.left];
  assume wf(Heap#_322, Mask#_323);
  assume (Heap#_322[this, SortedTreeNode.left] == null) || (dtype(Heap#_322[this, SortedTreeNode.left]) == SortedTreeNode#t);
  assume Fractions(1) > 0;
  Mask#_323[this, SortedTreeNode.left] := Mask#_323[this, SortedTreeNode.left][perm$R := Mask#_323[this, SortedTreeNode.left][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask#_323);
  assume IsGoodState(inhaleHeap#_328[this, SortedTreeNode.left]);
  assume wf(Heap#_322, Mask#_323);
  assume wf(inhaleHeap#_328, Mask#_323);
  assume this != null;
  Heap#_322[this, SortedTreeNode.right] := inhaleHeap#_328[this, SortedTreeNode.right];
  assume wf(Heap#_322, Mask#_323);
  assume (Heap#_322[this, SortedTreeNode.right] == null) || (dtype(Heap#_322[this, SortedTreeNode.right]) == SortedTreeNode#t);
  assume Fractions(1) > 0;
  Mask#_323[this, SortedTreeNode.right] := Mask#_323[this, SortedTreeNode.right][perm$R := Mask#_323[this, SortedTreeNode.right][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask#_323);
  assume IsGoodState(inhaleHeap#_328[this, SortedTreeNode.right]);
  assume wf(Heap#_322, Mask#_323);
  assume wf(inhaleHeap#_328, Mask#_323);
  assume this != null;
  Heap#_322[this, SortedTreeNode.keys] := inhaleHeap#_328[this, SortedTreeNode.keys];
  assume wf(Heap#_322, Mask#_323);
  assume true;
  assume Fractions(1 * 50) > 0;
  Mask#_323[this, SortedTreeNode.keys] := Mask#_323[this, SortedTreeNode.keys][perm$R := Mask#_323[this, SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
  assume IsGoodMask(Mask#_323);
  assume IsGoodState(inhaleHeap#_328[this, SortedTreeNode.keys]);
  assume wf(Heap#_322, Mask#_323);
  assume wf(inhaleHeap#_328, Mask#_323);
  assume this != null;
  Heap#_322[this, SortedTreeNode.shared] := inhaleHeap#_328[this, SortedTreeNode.shared];
  assume wf(Heap#_322, Mask#_323);
  assume true;
  assume Fractions(1 * 50) > 0;
  Mask#_323[this, SortedTreeNode.shared] := Mask#_323[this, SortedTreeNode.shared][perm$R := Mask#_323[this, SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
  assume IsGoodMask(Mask#_323);
  assume IsGoodState(inhaleHeap#_328[this, SortedTreeNode.shared]);
  assume wf(Heap#_322, Mask#_323);
  assume wf(inhaleHeap#_328, Mask#_323);
  if ((!(Heap#_322[this, SortedTreeNode.left] == null)) && Heap#_322[this, SortedTreeNode.shared]) {
    assume Heap#_322[this, SortedTreeNode.left] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap#_322, Mask#_323);
    assume inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap#_322;
    assume Fractions(1 * 1) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.left] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.left] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap#_322[this, SortedTreeNode.left] == null)) && (!Heap#_322[this, SortedTreeNode.shared])) {
    assume Heap#_322[this, SortedTreeNode.left] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap#_322, Mask#_323);
    assume inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap#_322;
    assume Fractions(1 * 50) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.left] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.left] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume !Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap#_322[this, SortedTreeNode.left] == null)) {
    assume (forall lk#27#85: int :: (0 <= lk#27#85) && (lk#27#85 < Seq#Length(Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys], lk#27#85) < Heap#_322[this, SortedTreeNode.key]));
  } else {
  }
  if ((!(Heap#_322[this, SortedTreeNode.right] == null)) && Heap#_322[this, SortedTreeNode.shared]) {
    assume Heap#_322[this, SortedTreeNode.right] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap#_322, Mask#_323);
    assume inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap#_322;
    assume Fractions(1 * 1) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.right] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.right] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap#_322[this, SortedTreeNode.right] == null)) && (!Heap#_322[this, SortedTreeNode.shared])) {
    assume Heap#_322[this, SortedTreeNode.right] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap#_322, Mask#_323);
    assume inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap#_322;
    assume Fractions(1 * 50) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.right] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume Heap#_322[this, SortedTreeNode.right] != null;
    Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap#_322, Mask#_323);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask#_323[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask#_323);
    assume IsGoodState(inhaleHeap#_328[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap#_322, Mask#_323);
    assume wf(inhaleHeap#_328, Mask#_323);
    assume !Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap#_322[this, SortedTreeNode.right] == null)) {
    assume (forall rk#28#86: int :: (0 <= rk#28#86) && (rk#28#86 < Seq#Length(Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap#_322[this, SortedTreeNode.key] < Seq#Index(Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys], rk#28#86)));
  } else {
  }
  assume Seq#Equal(Heap#_322[this, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap#_322[this, SortedTreeNode.left] == null, Seq#Empty(), Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap#_322[this, SortedTreeNode.key])), ite(Heap#_322[this, SortedTreeNode.right] == null, Seq#Empty(), Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys])));
  assume Seq#Contains(Heap#_322[this, SortedTreeNode.keys], Heap#_322[this, SortedTreeNode.key]);
  assume (forall kk#29: int :: Seq#Contains(Heap#_322[this, SortedTreeNode.keys], kk#29) <==> ((((!(Heap#_322[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap#_322[Heap#_322[this, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap#_322[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap#_322[Heap#_322[this, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap#_322[this, SortedTreeNode.key])));
  assume IsGoodMask(Mask#_323);
  assume wf(Heap#_322, Mask#_323);
  // end inhale
  assert {:msg "  329.51: Receiver might be null."} true ==> (this != null);
  assert {:msg "  329.51: Location might not be readable."} true ==> CanRead(Mask#_323, this, SortedTreeNode.shared);
  assume hasClones#19 == Heap[this, SortedTreeNode.shared];
  if (!hasClones#19) {
    assume r#20 != null;
    Heap[r#20, SortedTreeNode.valid] := inhaleHeap#_318[r#20, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_318[r#20, SortedTreeNode.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[r#20, SortedTreeNode.valid] := Mask[r#20, SortedTreeNode.valid][perm$R := Mask[r#20, SortedTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_318[r#20, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_318, Mask);
  } else {
  }
  if (hasClones#19) {
    assume r#20 != null;
    Heap[r#20, SortedTreeNode.valid] := inhaleHeap#_318[r#20, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_318[r#20, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[r#20, SortedTreeNode.valid] := Mask[r#20, SortedTreeNode.valid][perm$R := Mask[r#20, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_318[r#20, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_318, Mask);
  } else {
  }
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
  havoc inhaleHeap#_329;
  assume IsGoodInhaleState(inhaleHeap#_329, Heap, Mask);
  assume !(r#20 == null);
  if (hasClones#19) {
  } else {
  }
  assume r#20 != null;
  Heap[r#20, SortedTreeNode.keys] := inhaleHeap#_329[r#20, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50 - ite(hasClones#19, 49, 0)) > 0;
  Mask[r#20, SortedTreeNode.keys] := Mask[r#20, SortedTreeNode.keys][perm$R := Mask[r#20, SortedTreeNode.keys][perm$R] + Fractions(50 - ite(hasClones#19, 49, 0))];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_329[r#20, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_329, Mask);
  assert {:msg "  336.16: Receiver might be null."} true ==> (r#20 != null);
  assert {:msg "  336.16: Location might not be readable."} true ==> CanRead(Mask, r#20, SortedTreeNode.keys);
  assume Seq#Contains(Heap[r#20, SortedTreeNode.keys], k#18);
  assert {:msg "  337.11: Receiver might be null."} true && (0 <= i#32#88) ==> (this != null);
  assert {:msg "  337.11: Location might not be readable."} true && (0 <= i#32#88) ==> CanRead(old(Mask), this, SortedTreeNode.keys);
  assert {:msg "  337.11: Receiver might be null."} true && (0 <= i#32#88) && (i#32#88 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> (this != null);
  assert {:msg "  337.11: Location might not be readable."} true && (0 <= i#32#88) && (i#32#88 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> CanRead(old(Mask), this, SortedTreeNode.keys);
  assert {:msg "  337.36: Sequence index might be negative."} true && (0 <= i#32#88) && (i#32#88 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> (0 <= i#32#88);
  assert {:msg "  337.36: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= i#32#88) && (i#32#88 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> (i#32#88 < Seq#Length(old(Heap)[this, SortedTreeNode.keys]));
  assert {:msg "  337.41: Receiver might be null."} true && (0 <= i#32#88) && (i#32#88 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> (r#20 != null);
  assert {:msg "  337.41: Location might not be readable."} true && (0 <= i#32#88) && (i#32#88 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> CanRead(Mask, r#20, SortedTreeNode.keys);
  assume (forall i#32#87: int :: (0 <= i#32#87) && (i#32#87 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> Seq#Contains(Heap[r#20, SortedTreeNode.keys], Seq#Index(old(Heap)[this, SortedTreeNode.keys], i#32#87)));
  assert {:msg "  338.11: Receiver might be null."} true && (0 <= i#33#90) ==> (r#20 != null);
  assert {:msg "  338.11: Location might not be readable."} true && (0 <= i#33#90) ==> CanRead(Mask, r#20, SortedTreeNode.keys);
  assert {:msg "  338.11: Receiver might be null."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> (r#20 != null);
  assert {:msg "  338.11: Location might not be readable."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> CanRead(Mask, r#20, SortedTreeNode.keys);
  assert {:msg "  338.35: Sequence index might be negative."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> (0 <= i#33#90);
  assert {:msg "  338.35: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys]));
  assert {:msg "  338.44: Receiver might be null."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> (this != null);
  assert {:msg "  338.44: Location might not be readable."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> CanRead(old(Mask), this, SortedTreeNode.keys);
  assert {:msg "  338.11: Receiver might be null."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) && (!Seq#Contains(old(Heap)[this, SortedTreeNode.keys], Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#90))) ==> (r#20 != null);
  assert {:msg "  338.11: Location might not be readable."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) && (!Seq#Contains(old(Heap)[this, SortedTreeNode.keys], Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#90))) ==> CanRead(Mask, r#20, SortedTreeNode.keys);
  assert {:msg "  338.35: Sequence index might be negative."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) && (!Seq#Contains(old(Heap)[this, SortedTreeNode.keys], Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#90))) ==> (0 <= i#33#90);
  assert {:msg "  338.35: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= i#33#90) && (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) && (!Seq#Contains(old(Heap)[this, SortedTreeNode.keys], Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#90))) ==> (i#33#90 < Seq#Length(Heap[r#20, SortedTreeNode.keys]));
  assume (forall i#33#89: int :: (0 <= i#33#89) && (i#33#89 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> (Seq#Contains(old(Heap)[this, SortedTreeNode.keys], Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#89)) || (Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#89) == k#18)));
  assert {:msg "  339.20: Receiver might be null."} true ==> (this != null);
  assert {:msg "  339.20: Location might not be readable."} true ==> CanRead(old(Mask), this, SortedTreeNode.keys);
  if (Seq#Contains(old(Heap)[this, SortedTreeNode.keys], k#18)) {
    assert {:msg "  339.30: Receiver might be null."} true ==> (r#20 != null);
    assert {:msg "  339.30: Location might not be readable."} true ==> CanRead(Mask, r#20, SortedTreeNode.keys);
    assert {:msg "  339.42: Receiver might be null."} true ==> (this != null);
    assert {:msg "  339.42: Location might not be readable."} true ==> CanRead(old(Mask), this, SortedTreeNode.keys);
    assume Seq#Equal(Heap[r#20, SortedTreeNode.keys], old(Heap)[this, SortedTreeNode.keys]);
  } else {
  }
  assert {:msg "  340.22: Receiver might be null."} true ==> (this != null);
  assert {:msg "  340.22: Location might not be readable."} true ==> CanRead(old(Mask), this, SortedTreeNode.keys);
  if (!Seq#Contains(old(Heap)[this, SortedTreeNode.keys], k#18)) {
    assert {:msg "  340.34: Receiver might be null."} true ==> (r#20 != null);
    assert {:msg "  340.34: Location might not be readable."} true ==> CanRead(Mask, r#20, SortedTreeNode.keys);
    assert {:msg "  340.50: Receiver might be null."} true ==> (this != null);
    assert {:msg "  340.50: Location might not be readable."} true ==> CanRead(old(Mask), this, SortedTreeNode.keys);
    assume Seq#Length(Heap[r#20, SortedTreeNode.keys]) == (Seq#Length(old(Heap)[this, SortedTreeNode.keys]) + 1);
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure SortedTreeNode.insert(this: ref where (this == null) || (dtype(this) == SortedTreeNode#t), k#18: int where true, hasClones#19: bool where true) returns (r#20: ref where (r#20 == null) || (dtype(r#20) == SortedTreeNode#t))
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var methodK#_317: int;
  var inhaleHeap#_330: HeapType;
  var unfoldK#_331: int;
  var exhaleMask#_332: MaskType;
  var inhaleHeap#_334: HeapType;
  var Heap#_338: HeapType;
  var Mask#_339: MaskType;
  var Credits#_340: CreditsType;
  var exhaleMask#_341: MaskType;
  var foldK#_342: int;
  var exhaleMask#_343: MaskType;
  var inhaleHeap#_361: HeapType;
  var nl#22: ref where (nl#22 == null) || (dtype(nl#22) == SortedTreeNode#t);
  var nw#_362: ref;
  var methodCallK#_366: int;
  var this#97: ref where (this#97 == null) || (dtype(this#97) == SortedTreeNode#t);
  var k#98: int where true;
  var callHeap#_363: HeapType;
  var callMask#_364: MaskType;
  var callCredits#_365: CreditsType;
  var exhaleMask#_367: MaskType;
  var isHeld#_373: int;
  var isRdHeld#_374: bool;
  var inhaleHeap#_375: HeapType;
  var methodCallK#_379: int;
  var this#99: ref where (this#99 == null) || (dtype(this#99) == SortedTreeNode#t);
  var k#100: int where true;
  var hasClones#101: bool where true;
  var r#102: ref where (r#102 == null) || (dtype(r#102) == SortedTreeNode#t);
  var callHeap#_376: HeapType;
  var callMask#_377: MaskType;
  var callCredits#_378: CreditsType;
  var exhaleMask#_380: MaskType;
  var isHeld#_387: int;
  var isRdHeld#_388: bool;
  var inhaleHeap#_389: HeapType;
  var nw#_390: ref;
  var methodCallK#_394: int;
  var this#105: ref where (this#105 == null) || (dtype(this#105) == SortedTreeNode#t);
  var k#106: int where true;
  var callHeap#_391: HeapType;
  var callMask#_392: MaskType;
  var callCredits#_393: CreditsType;
  var exhaleMask#_395: MaskType;
  var isHeld#_401: int;
  var isRdHeld#_402: bool;
  var inhaleHeap#_403: HeapType;
  var unfoldK#_404: int;
  var exhaleMask#_405: MaskType;
  var inhaleHeap#_407: HeapType;
  var foldK#_408: int;
  var exhaleMask#_409: MaskType;
  var inhaleHeap#_427: HeapType;
  var foldK#_428: int;
  var exhaleMask#_429: MaskType;
  var inhaleHeap#_447: HeapType;
  var nr#24: ref where (nr#24 == null) || (dtype(nr#24) == SortedTreeNode#t);
  var nw#_448: ref;
  var methodCallK#_452: int;
  var this#117: ref where (this#117 == null) || (dtype(this#117) == SortedTreeNode#t);
  var k#118: int where true;
  var callHeap#_449: HeapType;
  var callMask#_450: MaskType;
  var callCredits#_451: CreditsType;
  var exhaleMask#_453: MaskType;
  var isHeld#_459: int;
  var isRdHeld#_460: bool;
  var inhaleHeap#_461: HeapType;
  var methodCallK#_465: int;
  var this#119: ref where (this#119 == null) || (dtype(this#119) == SortedTreeNode#t);
  var k#120: int where true;
  var hasClones#121: bool where true;
  var r#122: ref where (r#122 == null) || (dtype(r#122) == SortedTreeNode#t);
  var callHeap#_462: HeapType;
  var callMask#_463: MaskType;
  var callCredits#_464: CreditsType;
  var exhaleMask#_466: MaskType;
  var isHeld#_473: int;
  var isRdHeld#_474: bool;
  var inhaleHeap#_475: HeapType;
  var nw#_476: ref;
  var methodCallK#_480: int;
  var this#125: ref where (this#125 == null) || (dtype(this#125) == SortedTreeNode#t);
  var k#126: int where true;
  var callHeap#_477: HeapType;
  var callMask#_478: MaskType;
  var callCredits#_479: CreditsType;
  var exhaleMask#_481: MaskType;
  var isHeld#_487: int;
  var isRdHeld#_488: bool;
  var inhaleHeap#_489: HeapType;
  var unfoldK#_490: int;
  var exhaleMask#_491: MaskType;
  var inhaleHeap#_493: HeapType;
  var foldK#_494: int;
  var exhaleMask#_495: MaskType;
  var inhaleHeap#_513: HeapType;
  var exhaleMask#_514: MaskType;
  assume (0 < methodK#_317) && ((1000 * methodK#_317) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_330;
  assume IsGoodInhaleState(inhaleHeap#_330, Heap, Mask);
  if (!hasClones#19) {
    assume this != null;
    Heap[this, SortedTreeNode.valid] := inhaleHeap#_330[this, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_330[this, SortedTreeNode.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_330[this, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_330, Mask);
  } else {
  }
  if (hasClones#19) {
    assume this != null;
    Heap[this, SortedTreeNode.valid] := inhaleHeap#_330[this, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_330[this, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_330[this, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_330, Mask);
  } else {
  }
  assume this != null;
  Heap[this, SortedTreeNode.valid] := inhaleHeap#_330[this, SortedTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_330[this, SortedTreeNode.valid] == Heap;
  assume Fractions(50 - ite(hasClones#19, 49, 0)) > 0;
  Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(50 - ite(hasClones#19, 49, 0))];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_330[this, SortedTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_330, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_330[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(50 - ite(hasClones#19, 49, 0)) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(50 - ite(hasClones#19, 49, 0))];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_330[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_330, Mask);
  assume hasClones#19 == Heap[this, SortedTreeNode.shared];
  if (!hasClones#19) {
    assume r#20 != null;
    Heap[r#20, SortedTreeNode.valid] := inhaleHeap#_330[r#20, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_330[r#20, SortedTreeNode.valid] == Heap;
    assume Fractions(100) > 0;
    Mask[r#20, SortedTreeNode.valid] := Mask[r#20, SortedTreeNode.valid][perm$R := Mask[r#20, SortedTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_330[r#20, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_330, Mask);
  } else {
  }
  if (hasClones#19) {
    assume r#20 != null;
    Heap[r#20, SortedTreeNode.valid] := inhaleHeap#_330[r#20, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_330[r#20, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[r#20, SortedTreeNode.valid] := Mask[r#20, SortedTreeNode.valid][perm$R := Mask[r#20, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_330[r#20, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_330, Mask);
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assume (0 < unfoldK#_331) && (unfoldK#_331 < Fractions(1)) && ((1000 * unfoldK#_331) < methodK#_317);
  assert {:msg "  343.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_332 := Mask;
  assert {:msg "  343.3: unfold might fail because the predicate SortedTreeNode.valid does not hold. The permission at 343.10 might not be positive."} Fractions(1) > 0;
  assert {:msg "  343.3: unfold might fail because the predicate SortedTreeNode.valid does not hold. Insufficient fraction at 343.10 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_332[this, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_332[this, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_332[this, SortedTreeNode.valid][perm$N]));
  exhaleMask#_332[this, SortedTreeNode.valid] := exhaleMask#_332[this, SortedTreeNode.valid][perm$R := exhaleMask#_332[this, SortedTreeNode.valid][perm$R] - Fractions(1)];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_332);
  Mask := exhaleMask#_332;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_334 := Heap[this, SortedTreeNode.valid];
  assume IsGoodInhaleState(inhaleHeap#_334, Heap, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.key] := inhaleHeap#_334[this, SortedTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.key] := Mask[this, SortedTreeNode.key][perm$R := Mask[this, SortedTreeNode.key][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, SortedTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.left] := inhaleHeap#_334[this, SortedTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.left] == null) || (dtype(Heap[this, SortedTreeNode.left]) == SortedTreeNode#t);
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.left] := Mask[this, SortedTreeNode.left][perm$R := Mask[this, SortedTreeNode.left][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, SortedTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.right] := inhaleHeap#_334[this, SortedTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, SortedTreeNode.right] == null) || (dtype(Heap[this, SortedTreeNode.right]) == SortedTreeNode#t);
  assume Fractions(1) > 0;
  Mask[this, SortedTreeNode.right] := Mask[this, SortedTreeNode.right][perm$R := Mask[this, SortedTreeNode.right][perm$R] + Fractions(1)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, SortedTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.keys] := inhaleHeap#_334[this, SortedTreeNode.keys];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1 * 50) > 0;
  Mask[this, SortedTreeNode.keys] := Mask[this, SortedTreeNode.keys][perm$R := Mask[this, SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, SortedTreeNode.keys]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  assume this != null;
  Heap[this, SortedTreeNode.shared] := inhaleHeap#_334[this, SortedTreeNode.shared];
  assume wf(Heap, Mask);
  assume true;
  assume Fractions(1 * 50) > 0;
  Mask[this, SortedTreeNode.shared] := Mask[this, SortedTreeNode.shared][perm$R := Mask[this, SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, SortedTreeNode.shared]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.left] != null;
    Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume !Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.left] == null)) {
    assume (forall lk#27#91: int :: (0 <= lk#27#91) && (lk#27#91 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], lk#27#91) < Heap[this, SortedTreeNode.key]));
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 1) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1 * 1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.shared]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume Heap[this, SortedTreeNode.right] != null;
    Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.keys];
    assume wf(Heap, Mask);
    assume true;
    assume Fractions(1 * 50) > 0;
    Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_334[Heap[this, SortedTreeNode.right], SortedTreeNode.keys]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_334, Mask);
    assume !Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
  } else {
  }
  if (!(Heap[this, SortedTreeNode.right] == null)) {
    assume (forall rk#28#92: int :: (0 <= rk#28#92) && (rk#28#92 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.key] < Seq#Index(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], rk#28#92)));
  } else {
  }
  assume Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[this, SortedTreeNode.key])), ite(Heap[this, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])));
  assume Seq#Contains(Heap[this, SortedTreeNode.keys], Heap[this, SortedTreeNode.key]);
  assume (forall kk#29: int :: Seq#Contains(Heap[this, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[this, SortedTreeNode.key])));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // if
  assert {:msg "  344.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  344.7: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
  if (Heap[this, SortedTreeNode.key] == k#18) {
    // assigment to r
    r#20 := this;
    // assert
    Heap#_338 := Heap;
    Mask#_339 := Mask;
    Credits#_340 := Credits;
    // begin exhale (assert)
    exhaleMask#_341 := Mask#_339;
    assert {:msg "  346.15: Receiver might be null."} true ==> (this != null);
    assert {:msg "  346.15: Location might not be readable."} true ==> CanRead(Mask#_339, this, SortedTreeNode.key);
    assert {:msg "  346.14: Sequence index might be negative."} true ==> (0 <= 0);
    assert {:msg "  346.14: Sequence index might be larger than or equal to the length of the sequence."} true ==> (0 < Seq#Length(Seq#Singleton(Heap#_338[this, SortedTreeNode.key])));
    assert {:msg "  346.4: Assertion might not hold. The expression at 346.11 might not evaluate to true."} k#18 == Seq#Index(Seq#Singleton(Heap#_338[this, SortedTreeNode.key]), 0);
    Mask#_339 := exhaleMask#_341;
    assume wf(Heap#_338, Mask#_339);
    // end exhale
    // fold
    assume (0 < foldK#_342) && ((1000 * foldK#_342) < Fractions(1)) && ((1000 * foldK#_342) < methodK#_317);
    assert {:msg "  347.4: The target of the fold statement might be null."} r#20 != null;
    // begin exhale (fold)
    exhaleMask#_343 := Mask;
    if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 198.8 might not evaluate to true."} Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
    } else {
    }
    if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 209.8 might not evaluate to true."} !Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
    } else {
    }
    if (!(Heap[r#20, SortedTreeNode.left] == null)) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 215.6 might not evaluate to true."} (forall lk#27#93: int :: (0 <= lk#27#93) && (lk#27#93 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], lk#27#93) < Heap[r#20, SortedTreeNode.key]));
    } else {
    }
    if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 225.8 might not evaluate to true."} Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
    } else {
    }
    if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 236.8 might not evaluate to true."} !Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
    } else {
    }
    if (!(Heap[r#20, SortedTreeNode.right] == null)) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 242.6 might not evaluate to true."} (forall rk#28#94: int :: (0 <= rk#28#94) && (rk#28#94 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[r#20, SortedTreeNode.key] < Seq#Index(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], rk#28#94)));
    } else {
    }
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 245.6 might not evaluate to true."} Seq#Equal(Heap[r#20, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#20, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[r#20, SortedTreeNode.key])), ite(Heap[r#20, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])));
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 246.6 might not evaluate to true."} Seq#Contains(Heap[r#20, SortedTreeNode.keys], Heap[r#20, SortedTreeNode.key]);
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 247.7 might not evaluate to true."} (forall kk#29: int :: Seq#Contains(Heap[r#20, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[r#20, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[r#20, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[r#20, SortedTreeNode.key])));
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 184.6 might not be positive."} Fractions(1) > 0;
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 184.6 for SortedTreeNode.key."} (Fractions(1) <= exhaleMask#_343[r#20, SortedTreeNode.key][perm$R]) && ((Fractions(1) == exhaleMask#_343[r#20, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_343[r#20, SortedTreeNode.key][perm$N]));
    exhaleMask#_343[r#20, SortedTreeNode.key] := exhaleMask#_343[r#20, SortedTreeNode.key][perm$R := exhaleMask#_343[r#20, SortedTreeNode.key][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_343);
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 185.6 might not be positive."} Fractions(1) > 0;
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 185.6 for SortedTreeNode.left."} (Fractions(1) <= exhaleMask#_343[r#20, SortedTreeNode.left][perm$R]) && ((Fractions(1) == exhaleMask#_343[r#20, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_343[r#20, SortedTreeNode.left][perm$N]));
    exhaleMask#_343[r#20, SortedTreeNode.left] := exhaleMask#_343[r#20, SortedTreeNode.left][perm$R := exhaleMask#_343[r#20, SortedTreeNode.left][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_343);
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 186.6 might not be positive."} Fractions(1) > 0;
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 186.6 for SortedTreeNode.right."} (Fractions(1) <= exhaleMask#_343[r#20, SortedTreeNode.right][perm$R]) && ((Fractions(1) == exhaleMask#_343[r#20, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_343[r#20, SortedTreeNode.right][perm$N]));
    exhaleMask#_343[r#20, SortedTreeNode.right] := exhaleMask#_343[r#20, SortedTreeNode.right][perm$R := exhaleMask#_343[r#20, SortedTreeNode.right][perm$R] - Fractions(1)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_343);
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 188.6 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 188.6 for SortedTreeNode.keys."} (Fractions(1 * 50) <= exhaleMask#_343[r#20, SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[r#20, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_343[r#20, SortedTreeNode.keys][perm$N]));
    exhaleMask#_343[r#20, SortedTreeNode.keys] := exhaleMask#_343[r#20, SortedTreeNode.keys][perm$R := exhaleMask#_343[r#20, SortedTreeNode.keys][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_343);
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 189.6 might not be positive."} Fractions(1 * 50) > 0;
    assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 189.6 for SortedTreeNode.shared."} (Fractions(1 * 50) <= exhaleMask#_343[r#20, SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[r#20, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_343[r#20, SortedTreeNode.shared][perm$N]));
    exhaleMask#_343[r#20, SortedTreeNode.shared] := exhaleMask#_343[r#20, SortedTreeNode.shared][perm$R := exhaleMask#_343[r#20, SortedTreeNode.shared][perm$R] - Fractions(1 * 50)];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_343);
    if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 195.8 might not be positive."} Fractions(1 * 1) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 195.8 for SortedTreeNode.valid."} (Fractions(1 * 1) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1 * 1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 196.8 might not be positive."} Fractions(1 * 1) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 196.8 for SortedTreeNode.shared."} (Fractions(1 * 1) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1 * 1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 197.8 might not be positive."} Fractions(1 * 1) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 197.8 for SortedTreeNode.keys."} (Fractions(1 * 1) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1 * 1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
    } else {
    }
    if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 206.8 might not be positive."} Fractions(1 * 50) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 206.8 for SortedTreeNode.valid."} (Fractions(1 * 50) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1 * 50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 207.8 might not be positive."} Fractions(1 * 50) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 207.8 for SortedTreeNode.shared."} (Fractions(1 * 50) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1 * 50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 208.8 might not be positive."} Fractions(1 * 50) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 208.8 for SortedTreeNode.keys."} (Fractions(1 * 50) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1 * 50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
    } else {
    }
    if (!(Heap[r#20, SortedTreeNode.left] == null)) {
    } else {
    }
    if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 222.8 might not be positive."} Fractions(1 * 1) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 222.8 for SortedTreeNode.valid."} (Fractions(1 * 1) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1 * 1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 223.8 might not be positive."} Fractions(1 * 1) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 223.8 for SortedTreeNode.shared."} (Fractions(1 * 1) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1 * 1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 224.8 might not be positive."} Fractions(1 * 1) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 224.8 for SortedTreeNode.keys."} (Fractions(1 * 1) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 1) == exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1 * 1)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
    } else {
    }
    if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 233.8 might not be positive."} Fractions(1 * 50) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 233.8 for SortedTreeNode.valid."} (Fractions(1 * 50) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1 * 50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 234.8 might not be positive."} Fractions(1 * 50) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 234.8 for SortedTreeNode.shared."} (Fractions(1 * 50) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1 * 50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 235.8 might not be positive."} Fractions(1 * 50) > 0;
      assert {:msg "  347.4: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 235.8 for SortedTreeNode.keys."} (Fractions(1 * 50) <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1 * 50) == exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
      exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_343[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1 * 50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_343);
    } else {
    }
    if (!(Heap[r#20, SortedTreeNode.right] == null)) {
    } else {
    }
    Mask := exhaleMask#_343;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_361;
    assume IsGoodInhaleState(inhaleHeap#_361, Heap, Mask);
    assume r#20 != null;
    Heap[r#20, SortedTreeNode.valid] := inhaleHeap#_361[r#20, SortedTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_361[r#20, SortedTreeNode.valid] == Heap;
    assume Fractions(1) > 0;
    Mask[r#20, SortedTreeNode.valid] := Mask[r#20, SortedTreeNode.valid][perm$R := Mask[r#20, SortedTreeNode.valid][perm$R] + Fractions(1)];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_361[r#20, SortedTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_361, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[r#20, SortedTreeNode.valid] := Heap;
    assume wf(Heap, Mask);
  } else {
    // if
    assert {:msg "  349.10: Receiver might be null."} true ==> (this != null);
    assert {:msg "  349.10: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
    if (k#18 < Heap[this, SortedTreeNode.key]) {
      // local var nl
      // if
      assert {:msg "  351.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  351.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
      if (Heap[this, SortedTreeNode.left] == null) {
        // assigment to nl
        // new
        havoc nw#_362;
        assume (nw#_362 != null) && (dtype(nw#_362) == SortedTreeNode#t);
        assume (forall<T#_2> f: Field (T#_2) :: (Mask[nw#_362, f][perm$R] == 0) && (Mask[nw#_362, f][perm$N] == 0));
        assume Heap[nw#_362, mu] == $LockBottom;
        assume Heap[nw#_362, held] <= 0;
        assume Heap[nw#_362, rdheld] == false;
        Mask[nw#_362, SortedTreeNode.key] := Mask[nw#_362, SortedTreeNode.key][perm$R := Mask[nw#_362, SortedTreeNode.key][perm$R] + Fractions(100)];
        Mask[nw#_362, SortedTreeNode.left] := Mask[nw#_362, SortedTreeNode.left][perm$R := Mask[nw#_362, SortedTreeNode.left][perm$R] + Fractions(100)];
        Mask[nw#_362, SortedTreeNode.right] := Mask[nw#_362, SortedTreeNode.right][perm$R := Mask[nw#_362, SortedTreeNode.right][perm$R] + Fractions(100)];
        Mask[nw#_362, SortedTreeNode.keys] := Mask[nw#_362, SortedTreeNode.keys][perm$R := Mask[nw#_362, SortedTreeNode.keys][perm$R] + Fractions(100)];
        Mask[nw#_362, SortedTreeNode.shared] := Mask[nw#_362, SortedTreeNode.shared][perm$R := Mask[nw#_362, SortedTreeNode.shared][perm$R] + Fractions(100)];
        Mask[nw#_362, mu] := Mask[nw#_362, mu][perm$R := Mask[nw#_362, mu][perm$R] + Fractions(100)];
        nl#22 := nw#_362;
        assume (0 < methodCallK#_366) && ((1000 * methodCallK#_366) < Fractions(1)) && ((1000 * methodCallK#_366) < methodK#_317);
        // call init
        callHeap#_363 := Heap;
        callMask#_364 := Mask;
        callCredits#_365 := Credits;
        assert {:msg "  353.6: The target of the method call might be null."} nl#22 != null;
        this#97 := nl#22;
        k#98 := k#18;
        // begin exhale (precondition)
        exhaleMask#_367 := Mask;
        assert {:msg "  353.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  353.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_367[this#97, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_367[this#97, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_367[this#97, SortedTreeNode.key][perm$N]));
        exhaleMask#_367[this#97, SortedTreeNode.key] := exhaleMask#_367[this#97, SortedTreeNode.key][perm$R := exhaleMask#_367[this#97, SortedTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_367);
        assert {:msg "  353.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  353.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_367[this#97, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_367[this#97, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_367[this#97, SortedTreeNode.left][perm$N]));
        exhaleMask#_367[this#97, SortedTreeNode.left] := exhaleMask#_367[this#97, SortedTreeNode.left][perm$R := exhaleMask#_367[this#97, SortedTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_367);
        assert {:msg "  353.6: The precondition at 258.12 might not hold. The permission at 258.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  353.6: The precondition at 258.12 might not hold. Insufficient fraction at 258.12 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_367[this#97, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_367[this#97, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_367[this#97, SortedTreeNode.right][perm$N]));
        exhaleMask#_367[this#97, SortedTreeNode.right] := exhaleMask#_367[this#97, SortedTreeNode.right][perm$R := exhaleMask#_367[this#97, SortedTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_367);
        assert {:msg "  353.6: The precondition at 260.12 might not hold. The permission at 260.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  353.6: The precondition at 260.12 might not hold. Insufficient fraction at 260.12 for SortedTreeNode.keys."} (Fractions(100) <= exhaleMask#_367[this#97, SortedTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_367[this#97, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_367[this#97, SortedTreeNode.keys][perm$N]));
        exhaleMask#_367[this#97, SortedTreeNode.keys] := exhaleMask#_367[this#97, SortedTreeNode.keys][perm$R := exhaleMask#_367[this#97, SortedTreeNode.keys][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_367);
        assert {:msg "  353.6: The precondition at 261.12 might not hold. The permission at 261.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  353.6: The precondition at 261.12 might not hold. Insufficient fraction at 261.12 for SortedTreeNode.shared."} (Fractions(100) <= exhaleMask#_367[this#97, SortedTreeNode.shared][perm$R]) && ((Fractions(100) == exhaleMask#_367[this#97, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_367[this#97, SortedTreeNode.shared][perm$N]));
        exhaleMask#_367[this#97, SortedTreeNode.shared] := exhaleMask#_367[this#97, SortedTreeNode.shared][perm$R := exhaleMask#_367[this#97, SortedTreeNode.shared][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_367);
        Mask := exhaleMask#_367;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (postcondition)
        havoc inhaleHeap#_375;
        assume IsGoodInhaleState(inhaleHeap#_375, Heap, Mask);
        assume this#97 != null;
        Heap[this#97, SortedTreeNode.valid] := inhaleHeap#_375[this#97, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_375[this#97, SortedTreeNode.valid] == Heap;
        assume Fractions(100) > 0;
        Mask[this#97, SortedTreeNode.valid] := Mask[this#97, SortedTreeNode.valid][perm$R := Mask[this#97, SortedTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_375[this#97, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_375, Mask);
        assume this#97 != null;
        Heap[this#97, SortedTreeNode.keys] := inhaleHeap#_375[this#97, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#97, SortedTreeNode.keys] := Mask[this#97, SortedTreeNode.keys][perm$R := Mask[this#97, SortedTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_375[this#97, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_375, Mask);
        assume this#97 != null;
        Heap[this#97, SortedTreeNode.shared] := inhaleHeap#_375[this#97, SortedTreeNode.shared];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#97, SortedTreeNode.shared] := Mask[this#97, SortedTreeNode.shared][perm$R := Mask[this#97, SortedTreeNode.shared][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_375[this#97, SortedTreeNode.shared]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_375, Mask);
        assume !Heap[this#97, SortedTreeNode.shared];
        assume Seq#Equal(Heap[this#97, SortedTreeNode.keys], Seq#Singleton(k#98));
        assume Seq#Contains(Heap[this#97, SortedTreeNode.keys], k#98);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
      } else {
        assume (0 < methodCallK#_379) && ((1000 * methodCallK#_379) < Fractions(1)) && ((1000 * methodCallK#_379) < methodK#_317);
        // call insert
        callHeap#_376 := Heap;
        callMask#_377 := Mask;
        callCredits#_378 := Credits;
        assert {:msg "  355.17: Receiver might be null."} true ==> (this != null);
        assert {:msg "  355.17: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
        assert {:msg "  355.6: The target of the method call might be null."} Heap[this, SortedTreeNode.left] != null;
        this#99 := Heap[this, SortedTreeNode.left];
        k#100 := k#18;
        hasClones#101 := hasClones#19;
        // begin exhale (precondition)
        exhaleMask#_380 := Mask;
        if (!hasClones#101) {
        } else {
        }
        if (hasClones#101) {
        } else {
        }
        assert {:msg "  355.6: The precondition at 329.12 might not hold. The expression at 329.12 might not evaluate to true."} hasClones#101 == Heap[this#99, SortedTreeNode.shared];
        if (!hasClones#101) {
        } else {
        }
        if (hasClones#101) {
        } else {
        }
        if (!hasClones#101) {
          assert {:msg "  355.6: The precondition at 325.12 might not hold. The permission at 325.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  355.6: The precondition at 325.12 might not hold. Insufficient fraction at 325.27 for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_380[this#99, SortedTreeNode.valid][perm$N]));
          exhaleMask#_380[this#99, SortedTreeNode.valid] := exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R := exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R] - Fractions(100)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_380);
        } else {
        }
        if (hasClones#101) {
          assert {:msg "  355.6: The precondition at 326.12 might not hold. The permission at 326.26 might not be positive."} Fractions(1) > 0;
          assert {:msg "  355.6: The precondition at 326.12 might not hold. Insufficient fraction at 326.26 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_380[this#99, SortedTreeNode.valid][perm$N]));
          exhaleMask#_380[this#99, SortedTreeNode.valid] := exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R := exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_380);
        } else {
        }
        assert {:msg "  355.6: The precondition at 327.12 might not hold. The permission at 327.12 might not be positive."} Fractions(50 - ite(hasClones#101, 49, 0)) > 0;
        assert {:msg "  355.6: The precondition at 327.12 might not hold. Insufficient fraction at 327.12 for SortedTreeNode.valid."} (Fractions(50 - ite(hasClones#101, 49, 0)) <= exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R]) && ((Fractions(50 - ite(hasClones#101, 49, 0)) == exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_380[this#99, SortedTreeNode.valid][perm$N]));
        exhaleMask#_380[this#99, SortedTreeNode.valid] := exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R := exhaleMask#_380[this#99, SortedTreeNode.valid][perm$R] - Fractions(50 - ite(hasClones#101, 49, 0))];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_380);
        assert {:msg "  355.6: The precondition at 328.12 might not hold. The permission at 328.12 might not be positive."} Fractions(50 - ite(hasClones#101, 49, 0)) > 0;
        assert {:msg "  355.6: The precondition at 328.12 might not hold. Insufficient fraction at 328.12 for SortedTreeNode.keys."} (Fractions(50 - ite(hasClones#101, 49, 0)) <= exhaleMask#_380[this#99, SortedTreeNode.keys][perm$R]) && ((Fractions(50 - ite(hasClones#101, 49, 0)) == exhaleMask#_380[this#99, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_380[this#99, SortedTreeNode.keys][perm$N]));
        exhaleMask#_380[this#99, SortedTreeNode.keys] := exhaleMask#_380[this#99, SortedTreeNode.keys][perm$R := exhaleMask#_380[this#99, SortedTreeNode.keys][perm$R] - Fractions(50 - ite(hasClones#101, 49, 0))];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_380);
        if (!hasClones#101) {
          assert {:msg "  355.6: The precondition at 332.12 might not hold. The permission at 332.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  355.6: The precondition at 332.12 might not hold. Insufficient fraction at 332.27 for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_380[r#20, SortedTreeNode.valid][perm$N]));
          exhaleMask#_380[r#20, SortedTreeNode.valid] := exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R] - Fractions(100)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_380);
        } else {
        }
        if (hasClones#101) {
          assert {:msg "  355.6: The precondition at 333.12 might not hold. The permission at 333.26 might not be positive."} Fractions(1) > 0;
          assert {:msg "  355.6: The precondition at 333.12 might not hold. Insufficient fraction at 333.26 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_380[r#20, SortedTreeNode.valid][perm$N]));
          exhaleMask#_380[r#20, SortedTreeNode.valid] := exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_380[r#20, SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_380);
        } else {
        }
        Mask := exhaleMask#_380;
        assume wf(Heap, Mask);
        // end exhale
        havoc r#102;
        // inhale (postcondition)
        havoc inhaleHeap#_389;
        assume IsGoodInhaleState(inhaleHeap#_389, Heap, Mask);
        assume !(r#102 == null);
        assume r#102 != null;
        Heap[r#102, SortedTreeNode.keys] := inhaleHeap#_389[r#102, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50 - ite(hasClones#101, 49, 0)) > 0;
        Mask[r#102, SortedTreeNode.keys] := Mask[r#102, SortedTreeNode.keys][perm$R := Mask[r#102, SortedTreeNode.keys][perm$R] + Fractions(50 - ite(hasClones#101, 49, 0))];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_389[r#102, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_389, Mask);
        assume Seq#Contains(Heap[r#102, SortedTreeNode.keys], k#100);
        assume (forall i#32#103: int :: (0 <= i#32#103) && (i#32#103 < Seq#Length(callHeap#_376[this#99, SortedTreeNode.keys])) ==> Seq#Contains(Heap[r#102, SortedTreeNode.keys], Seq#Index(callHeap#_376[this#99, SortedTreeNode.keys], i#32#103)));
        assume (forall i#33#104: int :: (0 <= i#33#104) && (i#33#104 < Seq#Length(Heap[r#102, SortedTreeNode.keys])) ==> (Seq#Contains(callHeap#_376[this#99, SortedTreeNode.keys], Seq#Index(Heap[r#102, SortedTreeNode.keys], i#33#104)) || (Seq#Index(Heap[r#102, SortedTreeNode.keys], i#33#104) == k#100)));
        if (Seq#Contains(callHeap#_376[this#99, SortedTreeNode.keys], k#100)) {
          assume Seq#Equal(Heap[r#102, SortedTreeNode.keys], callHeap#_376[this#99, SortedTreeNode.keys]);
        } else {
        }
        if (!Seq#Contains(callHeap#_376[this#99, SortedTreeNode.keys], k#100)) {
          assume Seq#Length(Heap[r#102, SortedTreeNode.keys]) == (Seq#Length(callHeap#_376[this#99, SortedTreeNode.keys]) + 1);
        } else {
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        nl#22 := r#102;
      }
      // if
      assert {:msg "  357.13: Receiver might be null."} true ==> (this != null);
      assert {:msg "  357.13: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
      if ((!(nl#22 == Heap[this, SortedTreeNode.left])) && hasClones#19) {
        // assigment to r
        // new
        havoc nw#_390;
        assume (nw#_390 != null) && (dtype(nw#_390) == SortedTreeNode#t);
        assume (forall<T#_3> f: Field (T#_3) :: (Mask[nw#_390, f][perm$R] == 0) && (Mask[nw#_390, f][perm$N] == 0));
        assume Heap[nw#_390, mu] == $LockBottom;
        assume Heap[nw#_390, held] <= 0;
        assume Heap[nw#_390, rdheld] == false;
        Mask[nw#_390, SortedTreeNode.key] := Mask[nw#_390, SortedTreeNode.key][perm$R := Mask[nw#_390, SortedTreeNode.key][perm$R] + Fractions(100)];
        Mask[nw#_390, SortedTreeNode.left] := Mask[nw#_390, SortedTreeNode.left][perm$R := Mask[nw#_390, SortedTreeNode.left][perm$R] + Fractions(100)];
        Mask[nw#_390, SortedTreeNode.right] := Mask[nw#_390, SortedTreeNode.right][perm$R := Mask[nw#_390, SortedTreeNode.right][perm$R] + Fractions(100)];
        Mask[nw#_390, SortedTreeNode.keys] := Mask[nw#_390, SortedTreeNode.keys][perm$R := Mask[nw#_390, SortedTreeNode.keys][perm$R] + Fractions(100)];
        Mask[nw#_390, SortedTreeNode.shared] := Mask[nw#_390, SortedTreeNode.shared][perm$R := Mask[nw#_390, SortedTreeNode.shared][perm$R] + Fractions(100)];
        Mask[nw#_390, mu] := Mask[nw#_390, mu][perm$R := Mask[nw#_390, mu][perm$R] + Fractions(100)];
        r#20 := nw#_390;
        assume (0 < methodCallK#_394) && ((1000 * methodCallK#_394) < Fractions(1)) && ((1000 * methodCallK#_394) < methodK#_317);
        // call init
        callHeap#_391 := Heap;
        callMask#_392 := Mask;
        callCredits#_393 := Credits;
        assert {:msg "  359.6: The target of the method call might be null."} r#20 != null;
        assert {:msg "  359.18: Receiver might be null."} true ==> (this != null);
        assert {:msg "  359.18: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
        this#105 := r#20;
        k#106 := Heap[this, SortedTreeNode.key];
        // begin exhale (precondition)
        exhaleMask#_395 := Mask;
        assert {:msg "  359.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  359.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_395[this#105, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_395[this#105, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_395[this#105, SortedTreeNode.key][perm$N]));
        exhaleMask#_395[this#105, SortedTreeNode.key] := exhaleMask#_395[this#105, SortedTreeNode.key][perm$R := exhaleMask#_395[this#105, SortedTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_395);
        assert {:msg "  359.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  359.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_395[this#105, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_395[this#105, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_395[this#105, SortedTreeNode.left][perm$N]));
        exhaleMask#_395[this#105, SortedTreeNode.left] := exhaleMask#_395[this#105, SortedTreeNode.left][perm$R := exhaleMask#_395[this#105, SortedTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_395);
        assert {:msg "  359.6: The precondition at 258.12 might not hold. The permission at 258.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  359.6: The precondition at 258.12 might not hold. Insufficient fraction at 258.12 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_395[this#105, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_395[this#105, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_395[this#105, SortedTreeNode.right][perm$N]));
        exhaleMask#_395[this#105, SortedTreeNode.right] := exhaleMask#_395[this#105, SortedTreeNode.right][perm$R := exhaleMask#_395[this#105, SortedTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_395);
        assert {:msg "  359.6: The precondition at 260.12 might not hold. The permission at 260.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  359.6: The precondition at 260.12 might not hold. Insufficient fraction at 260.12 for SortedTreeNode.keys."} (Fractions(100) <= exhaleMask#_395[this#105, SortedTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_395[this#105, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_395[this#105, SortedTreeNode.keys][perm$N]));
        exhaleMask#_395[this#105, SortedTreeNode.keys] := exhaleMask#_395[this#105, SortedTreeNode.keys][perm$R := exhaleMask#_395[this#105, SortedTreeNode.keys][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_395);
        assert {:msg "  359.6: The precondition at 261.12 might not hold. The permission at 261.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  359.6: The precondition at 261.12 might not hold. Insufficient fraction at 261.12 for SortedTreeNode.shared."} (Fractions(100) <= exhaleMask#_395[this#105, SortedTreeNode.shared][perm$R]) && ((Fractions(100) == exhaleMask#_395[this#105, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_395[this#105, SortedTreeNode.shared][perm$N]));
        exhaleMask#_395[this#105, SortedTreeNode.shared] := exhaleMask#_395[this#105, SortedTreeNode.shared][perm$R := exhaleMask#_395[this#105, SortedTreeNode.shared][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_395);
        Mask := exhaleMask#_395;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (postcondition)
        havoc inhaleHeap#_403;
        assume IsGoodInhaleState(inhaleHeap#_403, Heap, Mask);
        assume this#105 != null;
        Heap[this#105, SortedTreeNode.valid] := inhaleHeap#_403[this#105, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_403[this#105, SortedTreeNode.valid] == Heap;
        assume Fractions(100) > 0;
        Mask[this#105, SortedTreeNode.valid] := Mask[this#105, SortedTreeNode.valid][perm$R := Mask[this#105, SortedTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_403[this#105, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_403, Mask);
        assume this#105 != null;
        Heap[this#105, SortedTreeNode.keys] := inhaleHeap#_403[this#105, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#105, SortedTreeNode.keys] := Mask[this#105, SortedTreeNode.keys][perm$R := Mask[this#105, SortedTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_403[this#105, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_403, Mask);
        assume this#105 != null;
        Heap[this#105, SortedTreeNode.shared] := inhaleHeap#_403[this#105, SortedTreeNode.shared];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#105, SortedTreeNode.shared] := Mask[this#105, SortedTreeNode.shared][perm$R := Mask[this#105, SortedTreeNode.shared][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_403[this#105, SortedTreeNode.shared]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_403, Mask);
        assume !Heap[this#105, SortedTreeNode.shared];
        assume Seq#Equal(Heap[this#105, SortedTreeNode.keys], Seq#Singleton(k#106));
        assume Seq#Contains(Heap[this#105, SortedTreeNode.keys], k#106);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // unfold
        assume (0 < unfoldK#_404) && (unfoldK#_404 < Fractions(1)) && ((1000 * unfoldK#_404) < methodK#_317);
        assert {:msg "  360.6: The target of the fold statement might be null."} r#20 != null;
        // begin exhale (unfold)
        exhaleMask#_405 := Mask;
        assert {:msg "  360.6: unfold might fail because the predicate SortedTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
        assert {:msg "  360.6: unfold might fail because the predicate SortedTreeNode.valid does not hold. Insufficient fraction at <undefined position> for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_405[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_405[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_405[r#20, SortedTreeNode.valid][perm$N]));
        exhaleMask#_405[r#20, SortedTreeNode.valid] := exhaleMask#_405[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_405[r#20, SortedTreeNode.valid][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_405);
        Mask := exhaleMask#_405;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (unfold)
        inhaleHeap#_407 := Heap[r#20, SortedTreeNode.valid];
        assume IsGoodInhaleState(inhaleHeap#_407, Heap, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.key] := inhaleHeap#_407[r#20, SortedTreeNode.key];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(100) > 0;
        Mask[r#20, SortedTreeNode.key] := Mask[r#20, SortedTreeNode.key][perm$R := Mask[r#20, SortedTreeNode.key][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_407[r#20, SortedTreeNode.key]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_407, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.left] := inhaleHeap#_407[r#20, SortedTreeNode.left];
        assume wf(Heap, Mask);
        assume (Heap[r#20, SortedTreeNode.left] == null) || (dtype(Heap[r#20, SortedTreeNode.left]) == SortedTreeNode#t);
        assume Fractions(100) > 0;
        Mask[r#20, SortedTreeNode.left] := Mask[r#20, SortedTreeNode.left][perm$R := Mask[r#20, SortedTreeNode.left][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_407[r#20, SortedTreeNode.left]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_407, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.right] := inhaleHeap#_407[r#20, SortedTreeNode.right];
        assume wf(Heap, Mask);
        assume (Heap[r#20, SortedTreeNode.right] == null) || (dtype(Heap[r#20, SortedTreeNode.right]) == SortedTreeNode#t);
        assume Fractions(100) > 0;
        Mask[r#20, SortedTreeNode.right] := Mask[r#20, SortedTreeNode.right][perm$R := Mask[r#20, SortedTreeNode.right][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_407[r#20, SortedTreeNode.right]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_407, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.keys] := inhaleHeap#_407[r#20, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[r#20, SortedTreeNode.keys] := Mask[r#20, SortedTreeNode.keys][perm$R := Mask[r#20, SortedTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_407[r#20, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_407, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.shared] := inhaleHeap#_407[r#20, SortedTreeNode.shared];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[r#20, SortedTreeNode.shared] := Mask[r#20, SortedTreeNode.shared][perm$R := Mask[r#20, SortedTreeNode.shared][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_407[r#20, SortedTreeNode.shared]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_407, Mask);
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume !Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.left] == null)) {
          assume (forall lk#27#107: int :: (0 <= lk#27#107) && (lk#27#107 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], lk#27#107) < Heap[r#20, SortedTreeNode.key]));
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_407[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_407, Mask);
          assume !Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.right] == null)) {
          assume (forall rk#28#108: int :: (0 <= rk#28#108) && (rk#28#108 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[r#20, SortedTreeNode.key] < Seq#Index(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], rk#28#108)));
        } else {
        }
        assume Seq#Equal(Heap[r#20, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#20, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[r#20, SortedTreeNode.key])), ite(Heap[r#20, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])));
        assume Seq#Contains(Heap[r#20, SortedTreeNode.keys], Heap[r#20, SortedTreeNode.key]);
        assume (forall kk#29: int :: Seq#Contains(Heap[r#20, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[r#20, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[r#20, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[r#20, SortedTreeNode.key])));
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // update field left
        assert {:msg "  361.6: Location might not be writable"} CanWrite(Mask, r#20, SortedTreeNode.left);
        Heap[r#20, SortedTreeNode.left] := nl#22;
        assume wf(Heap, Mask);
        // update field right
        assert {:msg "  362.6: Location might not be writable"} CanWrite(Mask, r#20, SortedTreeNode.right);
        assert {:msg "  362.17: Receiver might be null."} true ==> (this != null);
        assert {:msg "  362.17: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
        Heap[r#20, SortedTreeNode.right] := Heap[this, SortedTreeNode.right];
        assume wf(Heap, Mask);
        // fold
        assume (0 < foldK#_408) && ((1000 * foldK#_408) < Fractions(1)) && ((1000 * foldK#_408) < methodK#_317);
        assert {:msg "  363.6: The target of the fold statement might be null."} r#20 != null;
        // begin exhale (fold)
        exhaleMask#_409 := Mask;
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 198.8 might not evaluate to true."} Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 209.8 might not evaluate to true."} !Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.left] == null)) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 215.6 might not evaluate to true."} (forall lk#27#109: int :: (0 <= lk#27#109) && (lk#27#109 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], lk#27#109) < Heap[r#20, SortedTreeNode.key]));
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 225.8 might not evaluate to true."} Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 236.8 might not evaluate to true."} !Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.right] == null)) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 242.6 might not evaluate to true."} (forall rk#28#110: int :: (0 <= rk#28#110) && (rk#28#110 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[r#20, SortedTreeNode.key] < Seq#Index(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], rk#28#110)));
        } else {
        }
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 245.6 might not evaluate to true."} Seq#Equal(Heap[r#20, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#20, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[r#20, SortedTreeNode.key])), ite(Heap[r#20, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])));
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 246.6 might not evaluate to true."} Seq#Contains(Heap[r#20, SortedTreeNode.keys], Heap[r#20, SortedTreeNode.key]);
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 247.7 might not evaluate to true."} (forall kk#29: int :: Seq#Contains(Heap[r#20, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[r#20, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[r#20, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[r#20, SortedTreeNode.key])));
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 184.6 might not be positive."} Fractions(100) > 0;
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 184.6 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_409[r#20, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_409[r#20, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_409[r#20, SortedTreeNode.key][perm$N]));
        exhaleMask#_409[r#20, SortedTreeNode.key] := exhaleMask#_409[r#20, SortedTreeNode.key][perm$R := exhaleMask#_409[r#20, SortedTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_409);
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 185.6 might not be positive."} Fractions(100) > 0;
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 185.6 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_409[r#20, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_409[r#20, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_409[r#20, SortedTreeNode.left][perm$N]));
        exhaleMask#_409[r#20, SortedTreeNode.left] := exhaleMask#_409[r#20, SortedTreeNode.left][perm$R := exhaleMask#_409[r#20, SortedTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_409);
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 186.6 might not be positive."} Fractions(100) > 0;
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 186.6 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_409[r#20, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_409[r#20, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_409[r#20, SortedTreeNode.right][perm$N]));
        exhaleMask#_409[r#20, SortedTreeNode.right] := exhaleMask#_409[r#20, SortedTreeNode.right][perm$R := exhaleMask#_409[r#20, SortedTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_409);
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 188.6 might not be positive."} Fractions(50) > 0;
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 188.6 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_409[r#20, SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_409[r#20, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_409[r#20, SortedTreeNode.keys][perm$N]));
        exhaleMask#_409[r#20, SortedTreeNode.keys] := exhaleMask#_409[r#20, SortedTreeNode.keys][perm$R := exhaleMask#_409[r#20, SortedTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_409);
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 189.6 might not be positive."} Fractions(50) > 0;
        assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 189.6 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_409[r#20, SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_409[r#20, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_409[r#20, SortedTreeNode.shared][perm$N]));
        exhaleMask#_409[r#20, SortedTreeNode.shared] := exhaleMask#_409[r#20, SortedTreeNode.shared][perm$R := exhaleMask#_409[r#20, SortedTreeNode.shared][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_409);
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 195.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 195.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 196.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 196.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 197.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 197.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 206.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 206.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 207.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 207.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 208.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 208.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.left] == null)) {
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 222.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 222.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 223.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 223.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 224.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 224.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 233.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 233.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 234.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 234.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 235.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  363.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 235.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
          exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_409[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_409);
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.right] == null)) {
        } else {
        }
        Mask := exhaleMask#_409;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (fold)
        havoc inhaleHeap#_427;
        assume IsGoodInhaleState(inhaleHeap#_427, Heap, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.valid] := inhaleHeap#_427[r#20, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_427[r#20, SortedTreeNode.valid] == Heap;
        assume Fractions(100) > 0;
        Mask[r#20, SortedTreeNode.valid] := Mask[r#20, SortedTreeNode.valid][perm$R := Mask[r#20, SortedTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_427[r#20, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_427, Mask);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        Heap[r#20, SortedTreeNode.valid] := Heap;
        assume wf(Heap, Mask);
      } else {
        // update field left
        assert {:msg "  365.6: Location might not be writable"} CanWrite(Mask, this, SortedTreeNode.left);
        Heap[this, SortedTreeNode.left] := nl#22;
        assume wf(Heap, Mask);
        // assigment to r
        r#20 := this;
        // fold
        assume (0 < foldK#_428) && ((1000 * foldK#_428) < Fractions(1)) && ((1000 * foldK#_428) < methodK#_317);
        assert {:msg "  367.6: The target of the fold statement might be null."} this != null;
        // begin exhale (fold)
        exhaleMask#_429 := Mask;
        if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 198.8 might not evaluate to true."} Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 209.8 might not evaluate to true."} !Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[this, SortedTreeNode.left] == null)) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 215.6 might not evaluate to true."} (forall lk#27#113: int :: (0 <= lk#27#113) && (lk#27#113 < Seq#Length(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], lk#27#113) < Heap[this, SortedTreeNode.key]));
        } else {
        }
        if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 225.8 might not evaluate to true."} Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 236.8 might not evaluate to true."} !Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[this, SortedTreeNode.right] == null)) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 242.6 might not evaluate to true."} (forall rk#28#114: int :: (0 <= rk#28#114) && (rk#28#114 < Seq#Length(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[this, SortedTreeNode.key] < Seq#Index(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], rk#28#114)));
        } else {
        }
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 245.6 might not evaluate to true."} Seq#Equal(Heap[this, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[this, SortedTreeNode.key])), ite(Heap[this, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys])));
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 246.6 might not evaluate to true."} Seq#Contains(Heap[this, SortedTreeNode.keys], Heap[this, SortedTreeNode.key]);
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 247.7 might not evaluate to true."} (forall kk#29: int :: Seq#Contains(Heap[this, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[this, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[this, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[this, SortedTreeNode.key])));
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 184.6 might not be positive."} Fractions(100) > 0;
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 184.6 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_429[this, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_429[this, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_429[this, SortedTreeNode.key][perm$N]));
        exhaleMask#_429[this, SortedTreeNode.key] := exhaleMask#_429[this, SortedTreeNode.key][perm$R := exhaleMask#_429[this, SortedTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_429);
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 185.6 might not be positive."} Fractions(100) > 0;
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 185.6 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_429[this, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_429[this, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_429[this, SortedTreeNode.left][perm$N]));
        exhaleMask#_429[this, SortedTreeNode.left] := exhaleMask#_429[this, SortedTreeNode.left][perm$R := exhaleMask#_429[this, SortedTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_429);
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 186.6 might not be positive."} Fractions(100) > 0;
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 186.6 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_429[this, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_429[this, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_429[this, SortedTreeNode.right][perm$N]));
        exhaleMask#_429[this, SortedTreeNode.right] := exhaleMask#_429[this, SortedTreeNode.right][perm$R := exhaleMask#_429[this, SortedTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_429);
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 188.6 might not be positive."} Fractions(50) > 0;
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 188.6 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_429[this, SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_429[this, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_429[this, SortedTreeNode.keys][perm$N]));
        exhaleMask#_429[this, SortedTreeNode.keys] := exhaleMask#_429[this, SortedTreeNode.keys][perm$R := exhaleMask#_429[this, SortedTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_429);
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 189.6 might not be positive."} Fractions(50) > 0;
        assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 189.6 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_429[this, SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_429[this, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_429[this, SortedTreeNode.shared][perm$N]));
        exhaleMask#_429[this, SortedTreeNode.shared] := exhaleMask#_429[this, SortedTreeNode.shared][perm$R := exhaleMask#_429[this, SortedTreeNode.shared][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_429);
        if ((!(Heap[this, SortedTreeNode.left] == null)) && Heap[this, SortedTreeNode.shared]) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 195.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 195.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 196.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 196.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 197.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 197.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
        } else {
        }
        if ((!(Heap[this, SortedTreeNode.left] == null)) && (!Heap[this, SortedTreeNode.shared])) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 206.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 206.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 207.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 207.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 208.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 208.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
        } else {
        }
        if (!(Heap[this, SortedTreeNode.left] == null)) {
        } else {
        }
        if ((!(Heap[this, SortedTreeNode.right] == null)) && Heap[this, SortedTreeNode.shared]) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 222.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 222.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 223.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 223.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 224.8 might not be positive."} Fractions(1) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 224.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
        } else {
        }
        if ((!(Heap[this, SortedTreeNode.right] == null)) && (!Heap[this, SortedTreeNode.shared])) {
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 233.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 233.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 234.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 234.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 235.8 might not be positive."} Fractions(50) > 0;
          assert {:msg "  367.6: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 235.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
          exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_429[Heap[this, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_429);
        } else {
        }
        if (!(Heap[this, SortedTreeNode.right] == null)) {
        } else {
        }
        Mask := exhaleMask#_429;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (fold)
        havoc inhaleHeap#_447;
        assume IsGoodInhaleState(inhaleHeap#_447, Heap, Mask);
        assume this != null;
        Heap[this, SortedTreeNode.valid] := inhaleHeap#_447[this, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_447[this, SortedTreeNode.valid] == Heap;
        assume Fractions(100) > 0;
        Mask[this, SortedTreeNode.valid] := Mask[this, SortedTreeNode.valid][perm$R := Mask[this, SortedTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_447[this, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_447, Mask);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        Heap[this, SortedTreeNode.valid] := Heap;
        assume wf(Heap, Mask);
      }
    } else {
      // assume
      assume false;
      // local var nr
      // if
      assert {:msg "  378.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  378.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
      if (Heap[this, SortedTreeNode.right] == null) {
        // assigment to nr
        // new
        havoc nw#_448;
        assume (nw#_448 != null) && (dtype(nw#_448) == SortedTreeNode#t);
        assume (forall<T#_4> f: Field (T#_4) :: (Mask[nw#_448, f][perm$R] == 0) && (Mask[nw#_448, f][perm$N] == 0));
        assume Heap[nw#_448, mu] == $LockBottom;
        assume Heap[nw#_448, held] <= 0;
        assume Heap[nw#_448, rdheld] == false;
        Mask[nw#_448, SortedTreeNode.key] := Mask[nw#_448, SortedTreeNode.key][perm$R := Mask[nw#_448, SortedTreeNode.key][perm$R] + Fractions(100)];
        Mask[nw#_448, SortedTreeNode.left] := Mask[nw#_448, SortedTreeNode.left][perm$R := Mask[nw#_448, SortedTreeNode.left][perm$R] + Fractions(100)];
        Mask[nw#_448, SortedTreeNode.right] := Mask[nw#_448, SortedTreeNode.right][perm$R := Mask[nw#_448, SortedTreeNode.right][perm$R] + Fractions(100)];
        Mask[nw#_448, SortedTreeNode.keys] := Mask[nw#_448, SortedTreeNode.keys][perm$R := Mask[nw#_448, SortedTreeNode.keys][perm$R] + Fractions(100)];
        Mask[nw#_448, SortedTreeNode.shared] := Mask[nw#_448, SortedTreeNode.shared][perm$R := Mask[nw#_448, SortedTreeNode.shared][perm$R] + Fractions(100)];
        Mask[nw#_448, mu] := Mask[nw#_448, mu][perm$R := Mask[nw#_448, mu][perm$R] + Fractions(100)];
        nr#24 := nw#_448;
        assume (0 < methodCallK#_452) && ((1000 * methodCallK#_452) < Fractions(1)) && ((1000 * methodCallK#_452) < methodK#_317);
        // call init
        callHeap#_449 := Heap;
        callMask#_450 := Mask;
        callCredits#_451 := Credits;
        assert {:msg "  380.6: The target of the method call might be null."} nr#24 != null;
        this#117 := nr#24;
        k#118 := k#18;
        // begin exhale (precondition)
        exhaleMask#_453 := Mask;
        assert {:msg "  380.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  380.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_453[this#117, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_453[this#117, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_453[this#117, SortedTreeNode.key][perm$N]));
        exhaleMask#_453[this#117, SortedTreeNode.key] := exhaleMask#_453[this#117, SortedTreeNode.key][perm$R := exhaleMask#_453[this#117, SortedTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_453);
        assert {:msg "  380.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  380.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_453[this#117, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_453[this#117, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_453[this#117, SortedTreeNode.left][perm$N]));
        exhaleMask#_453[this#117, SortedTreeNode.left] := exhaleMask#_453[this#117, SortedTreeNode.left][perm$R := exhaleMask#_453[this#117, SortedTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_453);
        assert {:msg "  380.6: The precondition at 258.12 might not hold. The permission at 258.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  380.6: The precondition at 258.12 might not hold. Insufficient fraction at 258.12 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_453[this#117, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_453[this#117, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_453[this#117, SortedTreeNode.right][perm$N]));
        exhaleMask#_453[this#117, SortedTreeNode.right] := exhaleMask#_453[this#117, SortedTreeNode.right][perm$R := exhaleMask#_453[this#117, SortedTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_453);
        assert {:msg "  380.6: The precondition at 260.12 might not hold. The permission at 260.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  380.6: The precondition at 260.12 might not hold. Insufficient fraction at 260.12 for SortedTreeNode.keys."} (Fractions(100) <= exhaleMask#_453[this#117, SortedTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_453[this#117, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_453[this#117, SortedTreeNode.keys][perm$N]));
        exhaleMask#_453[this#117, SortedTreeNode.keys] := exhaleMask#_453[this#117, SortedTreeNode.keys][perm$R := exhaleMask#_453[this#117, SortedTreeNode.keys][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_453);
        assert {:msg "  380.6: The precondition at 261.12 might not hold. The permission at 261.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  380.6: The precondition at 261.12 might not hold. Insufficient fraction at 261.12 for SortedTreeNode.shared."} (Fractions(100) <= exhaleMask#_453[this#117, SortedTreeNode.shared][perm$R]) && ((Fractions(100) == exhaleMask#_453[this#117, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_453[this#117, SortedTreeNode.shared][perm$N]));
        exhaleMask#_453[this#117, SortedTreeNode.shared] := exhaleMask#_453[this#117, SortedTreeNode.shared][perm$R := exhaleMask#_453[this#117, SortedTreeNode.shared][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_453);
        Mask := exhaleMask#_453;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (postcondition)
        havoc inhaleHeap#_461;
        assume IsGoodInhaleState(inhaleHeap#_461, Heap, Mask);
        assume this#117 != null;
        Heap[this#117, SortedTreeNode.valid] := inhaleHeap#_461[this#117, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_461[this#117, SortedTreeNode.valid] == Heap;
        assume Fractions(100) > 0;
        Mask[this#117, SortedTreeNode.valid] := Mask[this#117, SortedTreeNode.valid][perm$R := Mask[this#117, SortedTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_461[this#117, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_461, Mask);
        assume this#117 != null;
        Heap[this#117, SortedTreeNode.keys] := inhaleHeap#_461[this#117, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#117, SortedTreeNode.keys] := Mask[this#117, SortedTreeNode.keys][perm$R := Mask[this#117, SortedTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_461[this#117, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_461, Mask);
        assume this#117 != null;
        Heap[this#117, SortedTreeNode.shared] := inhaleHeap#_461[this#117, SortedTreeNode.shared];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#117, SortedTreeNode.shared] := Mask[this#117, SortedTreeNode.shared][perm$R := Mask[this#117, SortedTreeNode.shared][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_461[this#117, SortedTreeNode.shared]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_461, Mask);
        assume !Heap[this#117, SortedTreeNode.shared];
        assume Seq#Equal(Heap[this#117, SortedTreeNode.keys], Seq#Singleton(k#118));
        assume Seq#Contains(Heap[this#117, SortedTreeNode.keys], k#118);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
      } else {
        assume (0 < methodCallK#_465) && ((1000 * methodCallK#_465) < Fractions(1)) && ((1000 * methodCallK#_465) < methodK#_317);
        // call insert
        callHeap#_462 := Heap;
        callMask#_463 := Mask;
        callCredits#_464 := Credits;
        assert {:msg "  382.17: Receiver might be null."} true ==> (this != null);
        assert {:msg "  382.17: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
        assert {:msg "  382.6: The target of the method call might be null."} Heap[this, SortedTreeNode.right] != null;
        this#119 := Heap[this, SortedTreeNode.right];
        k#120 := k#18;
        hasClones#121 := hasClones#19;
        // begin exhale (precondition)
        exhaleMask#_466 := Mask;
        if (!hasClones#121) {
        } else {
        }
        if (hasClones#121) {
        } else {
        }
        assert {:msg "  382.6: The precondition at 329.12 might not hold. The expression at 329.12 might not evaluate to true."} hasClones#121 == Heap[this#119, SortedTreeNode.shared];
        if (!hasClones#121) {
        } else {
        }
        if (hasClones#121) {
        } else {
        }
        if (!hasClones#121) {
          assert {:msg "  382.6: The precondition at 325.12 might not hold. The permission at 325.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  382.6: The precondition at 325.12 might not hold. Insufficient fraction at 325.27 for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_466[this#119, SortedTreeNode.valid][perm$N]));
          exhaleMask#_466[this#119, SortedTreeNode.valid] := exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R := exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R] - Fractions(100)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_466);
        } else {
        }
        if (hasClones#121) {
          assert {:msg "  382.6: The precondition at 326.12 might not hold. The permission at 326.26 might not be positive."} Fractions(1) > 0;
          assert {:msg "  382.6: The precondition at 326.12 might not hold. Insufficient fraction at 326.26 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_466[this#119, SortedTreeNode.valid][perm$N]));
          exhaleMask#_466[this#119, SortedTreeNode.valid] := exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R := exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_466);
        } else {
        }
        assert {:msg "  382.6: The precondition at 327.12 might not hold. The permission at 327.12 might not be positive."} Fractions(50 - ite(hasClones#121, 49, 0)) > 0;
        assert {:msg "  382.6: The precondition at 327.12 might not hold. Insufficient fraction at 327.12 for SortedTreeNode.valid."} (Fractions(50 - ite(hasClones#121, 49, 0)) <= exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R]) && ((Fractions(50 - ite(hasClones#121, 49, 0)) == exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_466[this#119, SortedTreeNode.valid][perm$N]));
        exhaleMask#_466[this#119, SortedTreeNode.valid] := exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R := exhaleMask#_466[this#119, SortedTreeNode.valid][perm$R] - Fractions(50 - ite(hasClones#121, 49, 0))];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_466);
        assert {:msg "  382.6: The precondition at 328.12 might not hold. The permission at 328.12 might not be positive."} Fractions(50 - ite(hasClones#121, 49, 0)) > 0;
        assert {:msg "  382.6: The precondition at 328.12 might not hold. Insufficient fraction at 328.12 for SortedTreeNode.keys."} (Fractions(50 - ite(hasClones#121, 49, 0)) <= exhaleMask#_466[this#119, SortedTreeNode.keys][perm$R]) && ((Fractions(50 - ite(hasClones#121, 49, 0)) == exhaleMask#_466[this#119, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_466[this#119, SortedTreeNode.keys][perm$N]));
        exhaleMask#_466[this#119, SortedTreeNode.keys] := exhaleMask#_466[this#119, SortedTreeNode.keys][perm$R := exhaleMask#_466[this#119, SortedTreeNode.keys][perm$R] - Fractions(50 - ite(hasClones#121, 49, 0))];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_466);
        if (!hasClones#121) {
          assert {:msg "  382.6: The precondition at 332.12 might not hold. The permission at 332.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  382.6: The precondition at 332.12 might not hold. Insufficient fraction at 332.27 for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_466[r#20, SortedTreeNode.valid][perm$N]));
          exhaleMask#_466[r#20, SortedTreeNode.valid] := exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R] - Fractions(100)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_466);
        } else {
        }
        if (hasClones#121) {
          assert {:msg "  382.6: The precondition at 333.12 might not hold. The permission at 333.26 might not be positive."} Fractions(1) > 0;
          assert {:msg "  382.6: The precondition at 333.12 might not hold. Insufficient fraction at 333.26 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_466[r#20, SortedTreeNode.valid][perm$N]));
          exhaleMask#_466[r#20, SortedTreeNode.valid] := exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_466[r#20, SortedTreeNode.valid][perm$R] - Fractions(1)];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_466);
        } else {
        }
        Mask := exhaleMask#_466;
        assume wf(Heap, Mask);
        // end exhale
        havoc r#122;
        // inhale (postcondition)
        havoc inhaleHeap#_475;
        assume IsGoodInhaleState(inhaleHeap#_475, Heap, Mask);
        assume !(r#122 == null);
        assume r#122 != null;
        Heap[r#122, SortedTreeNode.keys] := inhaleHeap#_475[r#122, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50 - ite(hasClones#121, 49, 0)) > 0;
        Mask[r#122, SortedTreeNode.keys] := Mask[r#122, SortedTreeNode.keys][perm$R := Mask[r#122, SortedTreeNode.keys][perm$R] + Fractions(50 - ite(hasClones#121, 49, 0))];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_475[r#122, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_475, Mask);
        assume Seq#Contains(Heap[r#122, SortedTreeNode.keys], k#120);
        assume (forall i#32#123: int :: (0 <= i#32#123) && (i#32#123 < Seq#Length(callHeap#_462[this#119, SortedTreeNode.keys])) ==> Seq#Contains(Heap[r#122, SortedTreeNode.keys], Seq#Index(callHeap#_462[this#119, SortedTreeNode.keys], i#32#123)));
        assume (forall i#33#124: int :: (0 <= i#33#124) && (i#33#124 < Seq#Length(Heap[r#122, SortedTreeNode.keys])) ==> (Seq#Contains(callHeap#_462[this#119, SortedTreeNode.keys], Seq#Index(Heap[r#122, SortedTreeNode.keys], i#33#124)) || (Seq#Index(Heap[r#122, SortedTreeNode.keys], i#33#124) == k#120)));
        if (Seq#Contains(callHeap#_462[this#119, SortedTreeNode.keys], k#120)) {
          assume Seq#Equal(Heap[r#122, SortedTreeNode.keys], callHeap#_462[this#119, SortedTreeNode.keys]);
        } else {
        }
        if (!Seq#Contains(callHeap#_462[this#119, SortedTreeNode.keys], k#120)) {
          assume Seq#Length(Heap[r#122, SortedTreeNode.keys]) == (Seq#Length(callHeap#_462[this#119, SortedTreeNode.keys]) + 1);
        } else {
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        nr#24 := r#122;
      }
      // if
      assert {:msg "  384.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  384.9: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.right);
      if ((!(Heap[this, SortedTreeNode.right] == nr#24)) && hasClones#19) {
        // assigment to r
        // new
        havoc nw#_476;
        assume (nw#_476 != null) && (dtype(nw#_476) == SortedTreeNode#t);
        assume (forall<T#_5> f: Field (T#_5) :: (Mask[nw#_476, f][perm$R] == 0) && (Mask[nw#_476, f][perm$N] == 0));
        assume Heap[nw#_476, mu] == $LockBottom;
        assume Heap[nw#_476, held] <= 0;
        assume Heap[nw#_476, rdheld] == false;
        Mask[nw#_476, SortedTreeNode.key] := Mask[nw#_476, SortedTreeNode.key][perm$R := Mask[nw#_476, SortedTreeNode.key][perm$R] + Fractions(100)];
        Mask[nw#_476, SortedTreeNode.left] := Mask[nw#_476, SortedTreeNode.left][perm$R := Mask[nw#_476, SortedTreeNode.left][perm$R] + Fractions(100)];
        Mask[nw#_476, SortedTreeNode.right] := Mask[nw#_476, SortedTreeNode.right][perm$R := Mask[nw#_476, SortedTreeNode.right][perm$R] + Fractions(100)];
        Mask[nw#_476, SortedTreeNode.keys] := Mask[nw#_476, SortedTreeNode.keys][perm$R := Mask[nw#_476, SortedTreeNode.keys][perm$R] + Fractions(100)];
        Mask[nw#_476, SortedTreeNode.shared] := Mask[nw#_476, SortedTreeNode.shared][perm$R := Mask[nw#_476, SortedTreeNode.shared][perm$R] + Fractions(100)];
        Mask[nw#_476, mu] := Mask[nw#_476, mu][perm$R := Mask[nw#_476, mu][perm$R] + Fractions(100)];
        r#20 := nw#_476;
        assume (0 < methodCallK#_480) && ((1000 * methodCallK#_480) < Fractions(1)) && ((1000 * methodCallK#_480) < methodK#_317);
        // call init
        callHeap#_477 := Heap;
        callMask#_478 := Mask;
        callCredits#_479 := Credits;
        assert {:msg "  386.6: The target of the method call might be null."} r#20 != null;
        assert {:msg "  386.18: Receiver might be null."} true ==> (this != null);
        assert {:msg "  386.18: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.key);
        this#125 := r#20;
        k#126 := Heap[this, SortedTreeNode.key];
        // begin exhale (precondition)
        exhaleMask#_481 := Mask;
        assert {:msg "  386.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  386.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_481[this#125, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_481[this#125, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_481[this#125, SortedTreeNode.key][perm$N]));
        exhaleMask#_481[this#125, SortedTreeNode.key] := exhaleMask#_481[this#125, SortedTreeNode.key][perm$R := exhaleMask#_481[this#125, SortedTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_481);
        assert {:msg "  386.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  386.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_481[this#125, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_481[this#125, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_481[this#125, SortedTreeNode.left][perm$N]));
        exhaleMask#_481[this#125, SortedTreeNode.left] := exhaleMask#_481[this#125, SortedTreeNode.left][perm$R := exhaleMask#_481[this#125, SortedTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_481);
        assert {:msg "  386.6: The precondition at 258.12 might not hold. The permission at 258.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  386.6: The precondition at 258.12 might not hold. Insufficient fraction at 258.12 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_481[this#125, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_481[this#125, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_481[this#125, SortedTreeNode.right][perm$N]));
        exhaleMask#_481[this#125, SortedTreeNode.right] := exhaleMask#_481[this#125, SortedTreeNode.right][perm$R := exhaleMask#_481[this#125, SortedTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_481);
        assert {:msg "  386.6: The precondition at 260.12 might not hold. The permission at 260.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  386.6: The precondition at 260.12 might not hold. Insufficient fraction at 260.12 for SortedTreeNode.keys."} (Fractions(100) <= exhaleMask#_481[this#125, SortedTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_481[this#125, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_481[this#125, SortedTreeNode.keys][perm$N]));
        exhaleMask#_481[this#125, SortedTreeNode.keys] := exhaleMask#_481[this#125, SortedTreeNode.keys][perm$R := exhaleMask#_481[this#125, SortedTreeNode.keys][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_481);
        assert {:msg "  386.6: The precondition at 261.12 might not hold. The permission at 261.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  386.6: The precondition at 261.12 might not hold. Insufficient fraction at 261.12 for SortedTreeNode.shared."} (Fractions(100) <= exhaleMask#_481[this#125, SortedTreeNode.shared][perm$R]) && ((Fractions(100) == exhaleMask#_481[this#125, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_481[this#125, SortedTreeNode.shared][perm$N]));
        exhaleMask#_481[this#125, SortedTreeNode.shared] := exhaleMask#_481[this#125, SortedTreeNode.shared][perm$R := exhaleMask#_481[this#125, SortedTreeNode.shared][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_481);
        Mask := exhaleMask#_481;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (postcondition)
        havoc inhaleHeap#_489;
        assume IsGoodInhaleState(inhaleHeap#_489, Heap, Mask);
        assume this#125 != null;
        Heap[this#125, SortedTreeNode.valid] := inhaleHeap#_489[this#125, SortedTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_489[this#125, SortedTreeNode.valid] == Heap;
        assume Fractions(100) > 0;
        Mask[this#125, SortedTreeNode.valid] := Mask[this#125, SortedTreeNode.valid][perm$R := Mask[this#125, SortedTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_489[this#125, SortedTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_489, Mask);
        assume this#125 != null;
        Heap[this#125, SortedTreeNode.keys] := inhaleHeap#_489[this#125, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#125, SortedTreeNode.keys] := Mask[this#125, SortedTreeNode.keys][perm$R := Mask[this#125, SortedTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_489[this#125, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_489, Mask);
        assume this#125 != null;
        Heap[this#125, SortedTreeNode.shared] := inhaleHeap#_489[this#125, SortedTreeNode.shared];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#125, SortedTreeNode.shared] := Mask[this#125, SortedTreeNode.shared][perm$R := Mask[this#125, SortedTreeNode.shared][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_489[this#125, SortedTreeNode.shared]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_489, Mask);
        assume !Heap[this#125, SortedTreeNode.shared];
        assume Seq#Equal(Heap[this#125, SortedTreeNode.keys], Seq#Singleton(k#126));
        assume Seq#Contains(Heap[this#125, SortedTreeNode.keys], k#126);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // unfold
        assume (0 < unfoldK#_490) && (unfoldK#_490 < Fractions(1)) && ((1000 * unfoldK#_490) < methodK#_317);
        assert {:msg "  388.6: The target of the fold statement might be null."} r#20 != null;
        // begin exhale (unfold)
        exhaleMask#_491 := Mask;
        assert {:msg "  388.6: unfold might fail because the predicate SortedTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
        assert {:msg "  388.6: unfold might fail because the predicate SortedTreeNode.valid does not hold. Insufficient fraction at <undefined position> for SortedTreeNode.valid."} (Fractions(100) <= exhaleMask#_491[r#20, SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_491[r#20, SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_491[r#20, SortedTreeNode.valid][perm$N]));
        exhaleMask#_491[r#20, SortedTreeNode.valid] := exhaleMask#_491[r#20, SortedTreeNode.valid][perm$R := exhaleMask#_491[r#20, SortedTreeNode.valid][perm$R] - Fractions(100)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_491);
        Mask := exhaleMask#_491;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (unfold)
        inhaleHeap#_493 := Heap[r#20, SortedTreeNode.valid];
        assume IsGoodInhaleState(inhaleHeap#_493, Heap, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.key] := inhaleHeap#_493[r#20, SortedTreeNode.key];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(100) > 0;
        Mask[r#20, SortedTreeNode.key] := Mask[r#20, SortedTreeNode.key][perm$R := Mask[r#20, SortedTreeNode.key][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_493[r#20, SortedTreeNode.key]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_493, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.left] := inhaleHeap#_493[r#20, SortedTreeNode.left];
        assume wf(Heap, Mask);
        assume (Heap[r#20, SortedTreeNode.left] == null) || (dtype(Heap[r#20, SortedTreeNode.left]) == SortedTreeNode#t);
        assume Fractions(100) > 0;
        Mask[r#20, SortedTreeNode.left] := Mask[r#20, SortedTreeNode.left][perm$R := Mask[r#20, SortedTreeNode.left][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_493[r#20, SortedTreeNode.left]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_493, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.right] := inhaleHeap#_493[r#20, SortedTreeNode.right];
        assume wf(Heap, Mask);
        assume (Heap[r#20, SortedTreeNode.right] == null) || (dtype(Heap[r#20, SortedTreeNode.right]) == SortedTreeNode#t);
        assume Fractions(100) > 0;
        Mask[r#20, SortedTreeNode.right] := Mask[r#20, SortedTreeNode.right][perm$R := Mask[r#20, SortedTreeNode.right][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_493[r#20, SortedTreeNode.right]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_493, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.keys] := inhaleHeap#_493[r#20, SortedTreeNode.keys];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[r#20, SortedTreeNode.keys] := Mask[r#20, SortedTreeNode.keys][perm$R := Mask[r#20, SortedTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_493[r#20, SortedTreeNode.keys]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_493, Mask);
        assume r#20 != null;
        Heap[r#20, SortedTreeNode.shared] := inhaleHeap#_493[r#20, SortedTreeNode.shared];
        assume wf(Heap, Mask);
        assume true;
        assume Fractions(50) > 0;
        Mask[r#20, SortedTreeNode.shared] := Mask[r#20, SortedTreeNode.shared][perm$R := Mask[r#20, SortedTreeNode.shared][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_493[r#20, SortedTreeNode.shared]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_493, Mask);
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] == Heap;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.left] != null;
          Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume !Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.left] == null)) {
          assume (forall lk#27#127: int :: (0 <= lk#27#127) && (lk#27#127 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], lk#27#127) < Heap[r#20, SortedTreeNode.key]));
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(1) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(1)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] == Heap;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume Heap[r#20, SortedTreeNode.right] != null;
          Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys];
          assume wf(Heap, Mask);
          assume true;
          assume Fractions(50) > 0;
          Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := Mask[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_493[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_493, Mask);
          assume !Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
        } else {
        }
        if (!(Heap[r#20, SortedTreeNode.right] == null)) {
          assume (forall rk#28#128: int :: (0 <= rk#28#128) && (rk#28#128 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[r#20, SortedTreeNode.key] < Seq#Index(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], rk#28#128)));
        } else {
        }
        assume Seq#Equal(Heap[r#20, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#20, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[r#20, SortedTreeNode.key])), ite(Heap[r#20, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])));
        assume Seq#Contains(Heap[r#20, SortedTreeNode.keys], Heap[r#20, SortedTreeNode.key]);
        assume (forall kk#29: int :: Seq#Contains(Heap[r#20, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[r#20, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[r#20, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[r#20, SortedTreeNode.key])));
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // update field right
        assert {:msg "  389.6: Location might not be writable"} CanWrite(Mask, r#20, SortedTreeNode.right);
        Heap[r#20, SortedTreeNode.right] := nr#24;
        assume wf(Heap, Mask);
        // update field left
        assert {:msg "  390.6: Location might not be writable"} CanWrite(Mask, r#20, SortedTreeNode.left);
        assert {:msg "  390.17: Receiver might be null."} true ==> (this != null);
        assert {:msg "  390.17: Location might not be readable."} true ==> CanRead(Mask, this, SortedTreeNode.left);
        Heap[r#20, SortedTreeNode.left] := Heap[this, SortedTreeNode.left];
        assume wf(Heap, Mask);
      } else {
        // assigment to r
        r#20 := this;
        // update field right
        assert {:msg "  393.6: Location might not be writable"} CanWrite(Mask, this, SortedTreeNode.right);
        Heap[this, SortedTreeNode.right] := nr#24;
        assume wf(Heap, Mask);
      }
      // fold
      assume (0 < foldK#_494) && ((1000 * foldK#_494) < Fractions(1)) && ((1000 * foldK#_494) < methodK#_317);
      assert {:msg "  396.5: The target of the fold statement might be null."} r#20 != null;
      // begin exhale (fold)
      exhaleMask#_495 := Mask;
      if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 198.8 might not evaluate to true."} Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
      } else {
      }
      if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 209.8 might not evaluate to true."} !Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared];
      } else {
      }
      if (!(Heap[r#20, SortedTreeNode.left] == null)) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 215.6 might not evaluate to true."} (forall lk#27#129: int :: (0 <= lk#27#129) && (lk#27#129 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], lk#27#129) < Heap[r#20, SortedTreeNode.key]));
      } else {
      }
      if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 225.8 might not evaluate to true."} Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
      } else {
      }
      if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 236.8 might not evaluate to true."} !Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared];
      } else {
      }
      if (!(Heap[r#20, SortedTreeNode.right] == null)) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 242.6 might not evaluate to true."} (forall rk#28#130: int :: (0 <= rk#28#130) && (rk#28#130 < Seq#Length(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])) ==> (Heap[r#20, SortedTreeNode.key] < Seq#Index(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], rk#28#130)));
      } else {
      }
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 245.6 might not evaluate to true."} Seq#Equal(Heap[r#20, SortedTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#20, SortedTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys]), Seq#Singleton(Heap[r#20, SortedTreeNode.key])), ite(Heap[r#20, SortedTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys])));
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 246.6 might not evaluate to true."} Seq#Contains(Heap[r#20, SortedTreeNode.keys], Heap[r#20, SortedTreeNode.key]);
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The expression at 247.7 might not evaluate to true."} (forall kk#29: int :: Seq#Contains(Heap[r#20, SortedTreeNode.keys], kk#29) <==> ((((!(Heap[r#20, SortedTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys], kk#29)) || ((!(Heap[r#20, SortedTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys], kk#29))) || (kk#29 == Heap[r#20, SortedTreeNode.key])));
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 184.6 might not be positive."} Fractions(100) > 0;
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 184.6 for SortedTreeNode.key."} (Fractions(100) <= exhaleMask#_495[r#20, SortedTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_495[r#20, SortedTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_495[r#20, SortedTreeNode.key][perm$N]));
      exhaleMask#_495[r#20, SortedTreeNode.key] := exhaleMask#_495[r#20, SortedTreeNode.key][perm$R := exhaleMask#_495[r#20, SortedTreeNode.key][perm$R] - Fractions(100)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_495);
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 185.6 might not be positive."} Fractions(100) > 0;
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 185.6 for SortedTreeNode.left."} (Fractions(100) <= exhaleMask#_495[r#20, SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_495[r#20, SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_495[r#20, SortedTreeNode.left][perm$N]));
      exhaleMask#_495[r#20, SortedTreeNode.left] := exhaleMask#_495[r#20, SortedTreeNode.left][perm$R := exhaleMask#_495[r#20, SortedTreeNode.left][perm$R] - Fractions(100)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_495);
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 186.6 might not be positive."} Fractions(100) > 0;
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 186.6 for SortedTreeNode.right."} (Fractions(100) <= exhaleMask#_495[r#20, SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_495[r#20, SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_495[r#20, SortedTreeNode.right][perm$N]));
      exhaleMask#_495[r#20, SortedTreeNode.right] := exhaleMask#_495[r#20, SortedTreeNode.right][perm$R := exhaleMask#_495[r#20, SortedTreeNode.right][perm$R] - Fractions(100)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_495);
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 188.6 might not be positive."} Fractions(50) > 0;
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 188.6 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_495[r#20, SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_495[r#20, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_495[r#20, SortedTreeNode.keys][perm$N]));
      exhaleMask#_495[r#20, SortedTreeNode.keys] := exhaleMask#_495[r#20, SortedTreeNode.keys][perm$R := exhaleMask#_495[r#20, SortedTreeNode.keys][perm$R] - Fractions(50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_495);
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 189.6 might not be positive."} Fractions(50) > 0;
      assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 189.6 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_495[r#20, SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_495[r#20, SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_495[r#20, SortedTreeNode.shared][perm$N]));
      exhaleMask#_495[r#20, SortedTreeNode.shared] := exhaleMask#_495[r#20, SortedTreeNode.shared][perm$R := exhaleMask#_495[r#20, SortedTreeNode.shared][perm$R] - Fractions(50)];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_495);
      if ((!(Heap[r#20, SortedTreeNode.left] == null)) && Heap[r#20, SortedTreeNode.shared]) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 195.8 might not be positive."} Fractions(1) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 195.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 196.8 might not be positive."} Fractions(1) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 196.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 197.8 might not be positive."} Fractions(1) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 197.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
      } else {
      }
      if ((!(Heap[r#20, SortedTreeNode.left] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 206.8 might not be positive."} Fractions(50) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 206.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid] := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.valid][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 207.8 might not be positive."} Fractions(50) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 207.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared] := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.shared][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 208.8 might not be positive."} Fractions(50) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 208.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys] := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.left], SortedTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
      } else {
      }
      if (!(Heap[r#20, SortedTreeNode.left] == null)) {
      } else {
      }
      if ((!(Heap[r#20, SortedTreeNode.right] == null)) && Heap[r#20, SortedTreeNode.shared]) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 222.8 might not be positive."} Fractions(1) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 222.8 for SortedTreeNode.valid."} (Fractions(1) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 223.8 might not be positive."} Fractions(1) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 223.8 for SortedTreeNode.shared."} (Fractions(1) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(1) == exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 224.8 might not be positive."} Fractions(1) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 224.8 for SortedTreeNode.keys."} (Fractions(1) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(1)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
      } else {
      }
      if ((!(Heap[r#20, SortedTreeNode.right] == null)) && (!Heap[r#20, SortedTreeNode.shared])) {
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 233.8 might not be positive."} Fractions(50) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 233.8 for SortedTreeNode.valid."} (Fractions(50) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) && ((Fractions(50) == exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid] := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.valid][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 234.8 might not be positive."} Fractions(50) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 234.8 for SortedTreeNode.shared."} (Fractions(50) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) && ((Fractions(50) == exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared] := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.shared][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. The permission at 235.8 might not be positive."} Fractions(50) > 0;
        assert {:msg "  396.5: Fold might fail because the definition of SortedTreeNode.valid does not hold. Insufficient fraction at 235.8 for SortedTreeNode.keys."} (Fractions(50) <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$N]));
        exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys] := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R := exhaleMask#_495[Heap[r#20, SortedTreeNode.right], SortedTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_495);
      } else {
      }
      if (!(Heap[r#20, SortedTreeNode.right] == null)) {
      } else {
      }
      Mask := exhaleMask#_495;
      assume wf(Heap, Mask);
      // end exhale
      // inhale (fold)
      havoc inhaleHeap#_513;
      assume IsGoodInhaleState(inhaleHeap#_513, Heap, Mask);
      assume r#20 != null;
      Heap[r#20, SortedTreeNode.valid] := inhaleHeap#_513[r#20, SortedTreeNode.valid];
      assume wf(Heap, Mask);
      assume inhaleHeap#_513[r#20, SortedTreeNode.valid] == Heap;
      assume Fractions(100) > 0;
      Mask[r#20, SortedTreeNode.valid] := Mask[r#20, SortedTreeNode.valid][perm$R := Mask[r#20, SortedTreeNode.valid][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_513[r#20, SortedTreeNode.valid]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_513, Mask);
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      // end inhale
      Heap[r#20, SortedTreeNode.valid] := Heap;
      assume wf(Heap, Mask);
    }
  }
  // begin exhale (postcondition)
  exhaleMask#_514 := Mask;
  assert {:msg "  324.2: The postcondition at 331.11 might not hold. The expression at 331.11 might not evaluate to true."} !(r#20 == null);
  assert {:msg "  324.2: The postcondition at 336.11 might not hold. The expression at 336.11 might not evaluate to true."} Seq#Contains(Heap[r#20, SortedTreeNode.keys], k#18);
  assert {:msg "  324.2: The postcondition at 337.11 might not hold. The expression at 337.11 might not evaluate to true."} (forall i#32#133: int :: (0 <= i#32#133) && (i#32#133 < Seq#Length(old(Heap)[this, SortedTreeNode.keys])) ==> Seq#Contains(Heap[r#20, SortedTreeNode.keys], Seq#Index(old(Heap)[this, SortedTreeNode.keys], i#32#133)));
  assert {:msg "  324.2: The postcondition at 338.11 might not hold. The expression at 338.11 might not evaluate to true."} (forall i#33#134: int :: (0 <= i#33#134) && (i#33#134 < Seq#Length(Heap[r#20, SortedTreeNode.keys])) ==> (Seq#Contains(old(Heap)[this, SortedTreeNode.keys], Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#134)) || (Seq#Index(Heap[r#20, SortedTreeNode.keys], i#33#134) == k#18)));
  if (Seq#Contains(old(Heap)[this, SortedTreeNode.keys], k#18)) {
    assert {:msg "  324.2: The postcondition at 339.11 might not hold. The expression at 339.30 might not evaluate to true."} Seq#Equal(Heap[r#20, SortedTreeNode.keys], old(Heap)[this, SortedTreeNode.keys]);
  } else {
  }
  if (!Seq#Contains(old(Heap)[this, SortedTreeNode.keys], k#18)) {
    assert {:msg "  324.2: The postcondition at 340.11 might not hold. The expression at 340.33 might not evaluate to true."} Seq#Length(Heap[r#20, SortedTreeNode.keys]) == (Seq#Length(old(Heap)[this, SortedTreeNode.keys]) + 1);
  } else {
  }
  assert {:msg "  324.2: The postcondition at 334.11 might not hold. The permission at 334.11 might not be positive."} Fractions(50 - ite(hasClones#19, 49, 0)) > 0;
  assert {:msg "  324.2: The postcondition at 334.11 might not hold. Insufficient fraction at 334.11 for SortedTreeNode.keys."} (Fractions(50 - ite(hasClones#19, 49, 0)) <= exhaleMask#_514[r#20, SortedTreeNode.keys][perm$R]) && ((Fractions(50 - ite(hasClones#19, 49, 0)) == exhaleMask#_514[r#20, SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_514[r#20, SortedTreeNode.keys][perm$N]));
  exhaleMask#_514[r#20, SortedTreeNode.keys] := exhaleMask#_514[r#20, SortedTreeNode.keys][perm$R := exhaleMask#_514[r#20, SortedTreeNode.keys][perm$R] - Fractions(50 - ite(hasClones#19, 49, 0))];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_514);
  if (Seq#Contains(old(Heap)[this, SortedTreeNode.keys], k#18)) {
  } else {
  }
  if (!Seq#Contains(old(Heap)[this, SortedTreeNode.keys], k#18)) {
  } else {
  }
  Mask := exhaleMask#_514;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  324.2: Method might lock/unlock more than allowed."} (forall lk#_516: ref :: {Heap[lk#_516, held]} {Heap[lk#_516, rdheld]} (((0 < Heap[lk#_516, held]) == (0 < old(Heap)[lk#_516, held])) && (Heap[lk#_516, rdheld] == old(Heap)[lk#_516, rdheld])) || false);
  assert {:msg "  324.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
