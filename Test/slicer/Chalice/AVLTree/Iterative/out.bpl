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

// the connection between % and /
axiom (forall x:int, y:int :: {x % y} {x / y}  x % y == x - x / y * y);

// sign of denominator determines sign of remainder
axiom (forall x:int, y:int :: {x % y}  0 < y  ==>  0 <= x % y  &&  x % y < y);
axiom (forall x:int, y:int :: {x % y}  y < 0  ==>  y < x % y  &&  x % y <= 0);

// the following axiom has some unfortunate matching, but it does state a property about % that
// is sometime useful
axiom (forall a: int, b: int, d: int :: { a % d, b % d } 2 <= d && a % d == b % d && a < b  ==>  a + d <= b);

// ---------------------------------------------------------------
// -- End of prelude ---------------------------------------------
// ---------------------------------------------------------------
const unique AVLTree#t: TypeName;
const unique module#default: ModuleName;
procedure AVLTree$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTree#t)) returns ()
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
  assert {:msg "  3.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique AVLTree.root: Field (ref);
axiom NonPredicateField(AVLTree.root);
const unique AVLTree.valid: Field (HeapType);
axiom PredicateField(AVLTree.valid);
procedure AVLTree.valid$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTree#t)) returns ()
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
  assert {:msg "  10.15: Fraction might be negative."} 0 <= 100;
  assert {:msg "  10.15: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTree.root] := inhaleHeap#_7[this, AVLTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
  Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_7[this, AVLTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_7, Mask);
  assert {:msg "  12.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  12.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  12.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  12.22: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
    assume Heap[this, AVLTree.root] != null;
    Heap[Heap[this, AVLTree.root], AVLTreeNode.valid] := inhaleHeap#_7[Heap[this, AVLTree.root], AVLTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_7[Heap[this, AVLTree.root], AVLTreeNode.valid] == Heap;
    Mask[Heap[this, AVLTree.root], AVLTreeNode.valid] := Mask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_7[Heap[this, AVLTree.root], AVLTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_7, Mask);
  } else {
  }
  assert {:msg "  13.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  13.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  13.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  13.26: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
    assert {:msg "  13.38: Fraction might be negative."} 0 <= 100;
    assert {:msg "  13.38: Fraction might exceed 100."} 100 <= 100;
    assume Heap[this, AVLTree.root] != null;
    Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_7[Heap[this, AVLTree.root], AVLTreeNode.parent];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_7[Heap[this, AVLTree.root], AVLTreeNode.parent]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_7, Mask);
  } else {
  }
  assert {:msg "  14.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  14.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  14.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  14.22: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
    assert {:msg "  14.22: Receiver might be null."} true ==> (Heap[this, AVLTree.root] != null);
    assert {:msg "  14.22: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTree.root], AVLTreeNode.parent);
    assume Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null;
  } else {
  }
  assert {:msg "  15.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  15.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  15.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  15.26: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
    assert {:msg "  15.36: Fraction might be negative."} 0 <= 50;
    assert {:msg "  15.36: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTree.root] != null;
    Heap[Heap[this, AVLTree.root], AVLTreeNode.root] := inhaleHeap#_7[Heap[this, AVLTree.root], AVLTreeNode.root];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.root] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.root]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTree.root], AVLTreeNode.root] := Mask[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_7[Heap[this, AVLTree.root], AVLTreeNode.root]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_7, Mask);
  } else {
  }
  assert {:msg "  16.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  16.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  16.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  16.22: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
    assert {:msg "  16.22: Receiver might be null."} true ==> (Heap[this, AVLTree.root] != null);
    assert {:msg "  16.22: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTree.root], AVLTreeNode.root);
    assert {:msg "  16.33: Receiver might be null."} true ==> (this != null);
    assert {:msg "  16.33: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
    assume Heap[Heap[this, AVLTree.root], AVLTreeNode.root] == Heap[this, AVLTree.root];
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure AVLTree.init$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTree#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_8: HeapType;
  var inhaleHeap#_9: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_8;
  assume IsGoodInhaleState(inhaleHeap#_8, Heap, Mask);
  assert {:msg "  26.21: Fraction might be negative."} 0 <= 100;
  assert {:msg "  26.21: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTree.root] := inhaleHeap#_8[this, AVLTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
  Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_8[this, AVLTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_8, Mask);
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
  havoc inhaleHeap#_9;
  assume IsGoodInhaleState(inhaleHeap#_9, Heap, Mask);
  assume this != null;
  Heap[this, AVLTree.valid] := inhaleHeap#_9[this, AVLTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_9[this, AVLTree.valid] == Heap;
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_9[this, AVLTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_9, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure AVLTree.init(this: ref where (this == null) || (dtype(this) == AVLTree#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_10: HeapType;
  var exhaleMask#_11: MaskType;
  var fraction#_12: int;
  var fraction#_13: int;
  var fraction#_14: int;
  var fraction#_15: int;
  var inhaleHeap#_16: HeapType;
  var exhaleMask#_17: MaskType;
  var fraction#_18: int;
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_10;
  assume IsGoodInhaleState(inhaleHeap#_10, Heap, Mask);
  assume this != null;
  Heap[this, AVLTree.root] := inhaleHeap#_10[this, AVLTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
  Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_10[this, AVLTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_10, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // update field root
  assert {:msg "  32.3: Location might not be writable"} CanWrite(Mask, this, AVLTree.root);
  Heap[this, AVLTree.root] := null;
  assume wf(Heap, Mask);
  // fold
  assert {:msg "  34.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_11 := Mask;
  fraction#_12 := 100;
  assert {:msg "  34.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 10.6 for AVLTree.root."} (fraction#_12 <= exhaleMask#_11[this, AVLTree.root][perm$R]) && ((fraction#_12 == exhaleMask#_11[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_11[this, AVLTree.root][perm$N]));
  exhaleMask#_11[this, AVLTree.root] := exhaleMask#_11[this, AVLTree.root][perm$R := exhaleMask#_11[this, AVLTree.root][perm$R] - fraction#_12];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_11);
  if (!(Heap[this, AVLTree.root] == null)) {
    fraction#_13 := 100;
    assert {:msg "  34.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid."} (fraction#_13 <= exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) && ((fraction#_13 == exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$N]));
    exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.valid] := exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] - fraction#_13];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_11);
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    fraction#_14 := 100;
    assert {:msg "  34.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 13.22 for AVLTreeNode.parent."} (fraction#_14 <= exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) && ((fraction#_14 == exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$N]));
    exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.parent] := exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] - fraction#_14];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_11);
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  34.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 14.22 might not evaluate to true."} Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null;
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    fraction#_15 := 50;
    assert {:msg "  34.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 15.22 for AVLTreeNode.root."} (fraction#_15 <= exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R]) && ((fraction#_15 == exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.root][perm$N]));
    exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.root] := exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R := exhaleMask#_11[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R] - fraction#_15];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_11);
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  34.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true."} Heap[Heap[this, AVLTree.root], AVLTreeNode.root] == Heap[this, AVLTree.root];
  } else {
  }
  Mask := exhaleMask#_11;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_16;
  assume IsGoodInhaleState(inhaleHeap#_16, Heap, Mask);
  assume this != null;
  Heap[this, AVLTree.valid] := inhaleHeap#_16[this, AVLTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_16[this, AVLTree.valid] == Heap;
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_16[this, AVLTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_16, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, AVLTree.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_17 := Mask;
  fraction#_18 := 100;
  assert {:msg "  25.2: The postcondition at 29.11 might not hold. Insufficient fraction at 29.11 for AVLTree.valid."} (fraction#_18 <= exhaleMask#_17[this, AVLTree.valid][perm$R]) && ((fraction#_18 == exhaleMask#_17[this, AVLTree.valid][perm$R]) ==> (0 <= exhaleMask#_17[this, AVLTree.valid][perm$N]));
  exhaleMask#_17[this, AVLTree.valid] := exhaleMask#_17[this, AVLTree.valid][perm$R := exhaleMask#_17[this, AVLTree.valid][perm$R] - fraction#_18];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_17);
  Mask := exhaleMask#_17;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  25.2: Method might lock/unlock more than allowed."} (forall lk#_19: ref :: {Heap[lk#_19, held]} {Heap[lk#_19, rdheld]} (((0 < Heap[lk#_19, held]) == (0 < old(Heap)[lk#_19, held])) && (Heap[lk#_19, rdheld] == old(Heap)[lk#_19, rdheld])) || false);
  assert {:msg "  25.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure AVLTree.has$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTree#t), k#0: int where true) returns (b#1: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_20: HeapType;
  var inhaleHeap#_21: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_20;
  assume IsGoodInhaleState(inhaleHeap#_20, Heap, Mask);
  assume this != null;
  Heap[this, AVLTree.valid] := inhaleHeap#_20[this, AVLTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_20[this, AVLTree.valid] == Heap;
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_20[this, AVLTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_20, Mask);
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
  havoc inhaleHeap#_21;
  assume IsGoodInhaleState(inhaleHeap#_21, Heap, Mask);
  assume this != null;
  Heap[this, AVLTree.valid] := inhaleHeap#_21[this, AVLTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_21[this, AVLTree.valid] == Heap;
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_21[this, AVLTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_21, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure AVLTree.has(this: ref where (this == null) || (dtype(this) == AVLTree#t), k#0: int where true) returns (b#1: bool where true)
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_22: HeapType;
  var exhaleMask#_23: MaskType;
  var fraction#_24: int;
  var inhaleHeap#_25: HeapType;
  var exhaleMask#_26: MaskType;
  var fraction#_27: int;
  var fraction#_28: int;
  var fraction#_29: int;
  var fraction#_30: int;
  var inhaleHeap#_31: HeapType;
  var n#3: ref where (n#3 == null) || (dtype(n#3) == AVLTreeNode#t);
  var end#5: bool where true;
  var exhaleMask#_32: MaskType;
  var fraction#_33: int;
  var fraction#_34: int;
  var fraction#_35: int;
  var fraction#_36: int;
  var fraction#_37: int;
  var fraction#_38: int;
  var fraction#_39: int;
  var inhaleHeap#_40: HeapType;
  var whileHeap#_41: HeapType;
  var whileMask#_42: MaskType;
  var whileCredits#_43: CreditsType;
  var exhaleMask#_47: MaskType;
  var fraction#_48: int;
  var fraction#_49: int;
  var fraction#_50: int;
  var fraction#_51: int;
  var fraction#_52: int;
  var end#13: bool where true;
  var b#14: bool where true;
  var n#15: ref where (n#15 == null) || (dtype(n#15) == AVLTreeNode#t);
  var inhaleHeap#_54: HeapType;
  var Heap#_58: HeapType;
  var Mask#_59: MaskType;
  var Credits#_60: CreditsType;
  var exhaleMask#_61: MaskType;
  var fraction#_62: int;
  var inhaleHeap#_63: HeapType;
  var inhaleHeap#_64: HeapType;
  var iterStartHeap#_44: HeapType;
  var iterStartMask#_45: MaskType;
  var iterStartCredits#_46: CreditsType;
  var end#16: bool where true;
  var b#17: bool where true;
  var n#18: ref where (n#18 == null) || (dtype(n#18) == AVLTreeNode#t);
  var exhaleMask#_66: MaskType;
  var fraction#_67: int;
  var inhaleHeap#_68: HeapType;
  var exhaleMask#_69: MaskType;
  var fraction#_70: int;
  var inhaleHeap#_71: HeapType;
  var exhaleMask#_72: MaskType;
  var fraction#_73: int;
  var fraction#_74: int;
  var fraction#_75: int;
  var fraction#_76: int;
  var fraction#_77: int;
  var inhaleHeap#_78: HeapType;
  var exhaleMask#_79: MaskType;
  var fraction#_80: int;
  var fraction#_81: int;
  var fraction#_82: int;
  var inhaleHeap#_83: HeapType;
  var exhaleMask#_84: MaskType;
  var fraction#_85: int;
  var fraction#_86: int;
  var fraction#_87: int;
  var fraction#_88: int;
  var fraction#_89: int;
  var inhaleHeap#_90: HeapType;
  var exhaleMask#_91: MaskType;
  var fraction#_92: int;
  var fraction#_93: int;
  var fraction#_94: int;
  var inhaleHeap#_95: HeapType;
  var p#7: ref where (p#7 == null) || (dtype(p#7) == AVLTreeNode#t);
  var exhaleMask#_96: MaskType;
  var fraction#_97: int;
  var inhaleHeap#_98: HeapType;
  var exhaleMask#_99: MaskType;
  var fraction#_100: int;
  var fraction#_101: int;
  var fraction#_102: int;
  var inhaleHeap#_103: HeapType;
  var exhaleMask#_104: MaskType;
  var fraction#_105: int;
  var fraction#_106: int;
  var fraction#_107: int;
  var fraction#_108: int;
  var fraction#_109: int;
  var fraction#_110: int;
  var fraction#_111: int;
  var fraction#_112: int;
  var fraction#_113: int;
  var fraction#_114: int;
  var inhaleHeap#_115: HeapType;
  var Heap#_119: HeapType;
  var Mask#_120: MaskType;
  var Credits#_121: CreditsType;
  var exhaleMask#_122: MaskType;
  var Heap#_126: HeapType;
  var Mask#_127: MaskType;
  var Credits#_128: CreditsType;
  var exhaleMask#_129: MaskType;
  var exhaleMask#_130: MaskType;
  var fraction#_131: int;
  var fraction#_132: int;
  var fraction#_133: int;
  var fraction#_134: int;
  var fraction#_135: int;
  var fraction#_136: int;
  var fraction#_137: int;
  var inhaleHeap#_138: HeapType;
  var exhaleMask#_139: MaskType;
  var fraction#_140: int;
  var fraction#_141: int;
  var fraction#_142: int;
  var fraction#_143: int;
  var fraction#_144: int;
  var inhaleHeap#_145: HeapType;
  var exhaleMask#_146: MaskType;
  var fraction#_147: int;
  var fraction#_148: int;
  var fraction#_149: int;
  var inhaleHeap#_150: HeapType;
  var p#9: ref where (p#9 == null) || (dtype(p#9) == AVLTreeNode#t);
  var exhaleMask#_151: MaskType;
  var fraction#_152: int;
  var inhaleHeap#_153: HeapType;
  var exhaleMask#_154: MaskType;
  var fraction#_155: int;
  var fraction#_156: int;
  var fraction#_157: int;
  var inhaleHeap#_158: HeapType;
  var exhaleMask#_159: MaskType;
  var fraction#_160: int;
  var fraction#_161: int;
  var fraction#_162: int;
  var fraction#_163: int;
  var fraction#_164: int;
  var fraction#_165: int;
  var fraction#_166: int;
  var fraction#_167: int;
  var fraction#_168: int;
  var fraction#_169: int;
  var inhaleHeap#_170: HeapType;
  var exhaleMask#_171: MaskType;
  var fraction#_172: int;
  var fraction#_173: int;
  var fraction#_174: int;
  var fraction#_175: int;
  var fraction#_176: int;
  var fraction#_177: int;
  var fraction#_178: int;
  var inhaleHeap#_179: HeapType;
  var exhaleMask#_180: MaskType;
  var fraction#_181: int;
  var fraction#_182: int;
  var fraction#_183: int;
  var fraction#_184: int;
  var fraction#_185: int;
  var isHeld#_187: int;
  var isRdHeld#_188: bool;
  var inhaleHeap#_190: HeapType;
  var whileHeap#_191: HeapType;
  var whileMask#_192: MaskType;
  var whileCredits#_193: CreditsType;
  var exhaleMask#_197: MaskType;
  var fraction#_198: int;
  var fraction#_199: int;
  var fraction#_200: int;
  var fraction#_201: int;
  var fraction#_202: int;
  var end#19: bool where true;
  var n#20: ref where (n#20 == null) || (dtype(n#20) == AVLTreeNode#t);
  var inhaleHeap#_204: HeapType;
  var Heap#_208: HeapType;
  var Mask#_209: MaskType;
  var Credits#_210: CreditsType;
  var exhaleMask#_211: MaskType;
  var fraction#_212: int;
  var inhaleHeap#_213: HeapType;
  var Heap#_217: HeapType;
  var Mask#_218: MaskType;
  var Credits#_219: CreditsType;
  var exhaleMask#_220: MaskType;
  var fraction#_221: int;
  var inhaleHeap#_222: HeapType;
  var inhaleHeap#_223: HeapType;
  var iterStartHeap#_194: HeapType;
  var iterStartMask#_195: MaskType;
  var iterStartCredits#_196: CreditsType;
  var end#21: bool where true;
  var n#22: ref where (n#22 == null) || (dtype(n#22) == AVLTreeNode#t);
  var exhaleMask#_225: MaskType;
  var fraction#_226: int;
  var inhaleHeap#_227: HeapType;
  var p#11: ref where (p#11 == null) || (dtype(p#11) == AVLTreeNode#t);
  var exhaleMask#_228: MaskType;
  var fraction#_229: int;
  var fraction#_230: int;
  var fraction#_231: int;
  var fraction#_232: int;
  var fraction#_233: int;
  var fraction#_234: int;
  var fraction#_235: int;
  var inhaleHeap#_236: HeapType;
  var exhaleMask#_237: MaskType;
  var fraction#_238: int;
  var inhaleHeap#_239: HeapType;
  var exhaleMask#_240: MaskType;
  var fraction#_241: int;
  var inhaleHeap#_242: HeapType;
  var exhaleMask#_243: MaskType;
  var fraction#_244: int;
  var fraction#_245: int;
  var fraction#_246: int;
  var fraction#_247: int;
  var fraction#_248: int;
  var inhaleHeap#_249: HeapType;
  var exhaleMask#_250: MaskType;
  var fraction#_251: int;
  var inhaleHeap#_252: HeapType;
  var exhaleMask#_253: MaskType;
  var fraction#_254: int;
  var fraction#_255: int;
  var fraction#_256: int;
  var fraction#_257: int;
  var fraction#_258: int;
  var inhaleHeap#_259: HeapType;
  var exhaleMask#_260: MaskType;
  var fraction#_261: int;
  var fraction#_262: int;
  var fraction#_263: int;
  var fraction#_264: int;
  var fraction#_265: int;
  var inhaleHeap#_266: HeapType;
  var exhaleMask#_267: MaskType;
  var fraction#_268: int;
  var fraction#_269: int;
  var fraction#_270: int;
  var inhaleHeap#_271: HeapType;
  var exhaleMask#_272: MaskType;
  var fraction#_273: int;
  var fraction#_274: int;
  var fraction#_275: int;
  var fraction#_276: int;
  var fraction#_277: int;
  var isHeld#_279: int;
  var isRdHeld#_280: bool;
  var inhaleHeap#_282: HeapType;
  var Heap#_286: HeapType;
  var Mask#_287: MaskType;
  var Credits#_288: CreditsType;
  var exhaleMask#_289: MaskType;
  var Heap#_293: HeapType;
  var Mask#_294: MaskType;
  var Credits#_295: CreditsType;
  var exhaleMask#_296: MaskType;
  var fraction#_297: int;
  var inhaleHeap#_298: HeapType;
  var Heap#_302: HeapType;
  var Mask#_303: MaskType;
  var Credits#_304: CreditsType;
  var exhaleMask#_305: MaskType;
  var fraction#_306: int;
  var exhaleMask#_307: MaskType;
  var fraction#_308: int;
  var inhaleHeap#_309: HeapType;
  var Heap#_313: HeapType;
  var Mask#_314: MaskType;
  var Credits#_315: CreditsType;
  var exhaleMask#_316: MaskType;
  var fraction#_317: int;
  var exhaleMask#_318: MaskType;
  var fraction#_319: int;
  var fraction#_320: int;
  var fraction#_321: int;
  var fraction#_322: int;
  var inhaleHeap#_323: HeapType;
  var exhaleMask#_324: MaskType;
  var fraction#_325: int;
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_22;
  assume IsGoodInhaleState(inhaleHeap#_22, Heap, Mask);
  assume this != null;
  Heap[this, AVLTree.valid] := inhaleHeap#_22[this, AVLTree.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_22[this, AVLTree.valid] == Heap;
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_22[this, AVLTree.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_22, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // unfold
  assert {:msg "  46.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  exhaleMask#_23 := Mask;
  fraction#_24 := 100;
  assert {:msg "  46.3: unfold might fail because the predicate AVLTree.valid does not hold. Insufficient fraction at <undefined position> for AVLTree.valid."} (fraction#_24 <= exhaleMask#_23[this, AVLTree.valid][perm$R]) && ((fraction#_24 == exhaleMask#_23[this, AVLTree.valid][perm$R]) ==> (0 <= exhaleMask#_23[this, AVLTree.valid][perm$N]));
  exhaleMask#_23[this, AVLTree.valid] := exhaleMask#_23[this, AVLTree.valid][perm$R := exhaleMask#_23[this, AVLTree.valid][perm$R] - fraction#_24];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_23);
  Mask := exhaleMask#_23;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (unfold)
  inhaleHeap#_25 := Heap[this, AVLTree.valid];
  assume IsGoodInhaleState(inhaleHeap#_25, Heap, Mask);
  assume this != null;
  Heap[this, AVLTree.root] := inhaleHeap#_25[this, AVLTree.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
  Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_25[this, AVLTree.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_25, Mask);
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[this, AVLTree.root] != null;
    Heap[Heap[this, AVLTree.root], AVLTreeNode.valid] := inhaleHeap#_25[Heap[this, AVLTree.root], AVLTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_25[Heap[this, AVLTree.root], AVLTreeNode.valid] == Heap;
    Mask[Heap[this, AVLTree.root], AVLTreeNode.valid] := Mask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_25[Heap[this, AVLTree.root], AVLTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_25, Mask);
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[this, AVLTree.root] != null;
    Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_25[Heap[this, AVLTree.root], AVLTreeNode.parent];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_25[Heap[this, AVLTree.root], AVLTreeNode.parent]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_25, Mask);
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null;
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[this, AVLTree.root] != null;
    Heap[Heap[this, AVLTree.root], AVLTreeNode.root] := inhaleHeap#_25[Heap[this, AVLTree.root], AVLTreeNode.root];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.root] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.root]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTree.root], AVLTreeNode.root] := Mask[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_25[Heap[this, AVLTree.root], AVLTreeNode.root]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_25, Mask);
  } else {
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[Heap[this, AVLTree.root], AVLTreeNode.root] == Heap[this, AVLTree.root];
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // if
  assert {:msg "  47.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  47.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
  if (Heap[this, AVLTree.root] == null) {
    // assigment to b
    b#1 := false;
    // fold
    assert {:msg "  49.4: The target of the fold statement might be null."} this != null;
    // begin exhale (fold)
    exhaleMask#_26 := Mask;
    fraction#_27 := 100;
    assert {:msg "  49.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 10.6 for AVLTree.root."} (fraction#_27 <= exhaleMask#_26[this, AVLTree.root][perm$R]) && ((fraction#_27 == exhaleMask#_26[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_26[this, AVLTree.root][perm$N]));
    exhaleMask#_26[this, AVLTree.root] := exhaleMask#_26[this, AVLTree.root][perm$R := exhaleMask#_26[this, AVLTree.root][perm$R] - fraction#_27];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_26);
    if (!(Heap[this, AVLTree.root] == null)) {
      fraction#_28 := 100;
      assert {:msg "  49.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid."} (fraction#_28 <= exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) && ((fraction#_28 == exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$N]));
      exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.valid] := exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] - fraction#_28];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_26);
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      fraction#_29 := 100;
      assert {:msg "  49.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 13.22 for AVLTreeNode.parent."} (fraction#_29 <= exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) && ((fraction#_29 == exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$N]));
      exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.parent] := exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] - fraction#_29];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_26);
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      assert {:msg "  49.4: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 14.22 might not evaluate to true."} Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null;
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      fraction#_30 := 50;
      assert {:msg "  49.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 15.22 for AVLTreeNode.root."} (fraction#_30 <= exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R]) && ((fraction#_30 == exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.root][perm$N]));
      exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.root] := exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R := exhaleMask#_26[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R] - fraction#_30];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_26);
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      assert {:msg "  49.4: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true."} Heap[Heap[this, AVLTree.root], AVLTreeNode.root] == Heap[this, AVLTree.root];
    } else {
    }
    Mask := exhaleMask#_26;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_31;
    assume IsGoodInhaleState(inhaleHeap#_31, Heap, Mask);
    assume this != null;
    Heap[this, AVLTree.valid] := inhaleHeap#_31[this, AVLTree.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_31[this, AVLTree.valid] == Heap;
    Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_31[this, AVLTree.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_31, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[this, AVLTree.valid] := Heap;
    assume wf(Heap, Mask);
  } else {
    // local var n
    // assigment to n
    assert {:msg "  51.27: Receiver might be null."} true ==> (this != null);
    assert {:msg "  51.27: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
    n#3 := Heap[this, AVLTree.root];
    // assigment to b
    b#1 := false;
    // local var end
    // assigment to end
    end#5 := false;
    // fold
    assert {:msg "  54.4: The target of the fold statement might be null."} n#3 != null;
    // begin exhale (fold)
    exhaleMask#_32 := Mask;
    fraction#_33 := 50;
    assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 216.6 for AVLTreeNode.parent."} (fraction#_33 <= exhaleMask#_32[n#3, AVLTreeNode.parent][perm$R]) && ((fraction#_33 == exhaleMask#_32[n#3, AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_32[n#3, AVLTreeNode.parent][perm$N]));
    exhaleMask#_32[n#3, AVLTreeNode.parent] := exhaleMask#_32[n#3, AVLTreeNode.parent][perm$R := exhaleMask#_32[n#3, AVLTreeNode.parent][perm$R] - fraction#_33];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_32);
    fraction#_34 := 10;
    assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 217.6 for AVLTreeNode.root."} (fraction#_34 <= exhaleMask#_32[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_34 == exhaleMask#_32[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_32[n#3, AVLTreeNode.root][perm$N]));
    exhaleMask#_32[n#3, AVLTreeNode.root] := exhaleMask#_32[n#3, AVLTreeNode.root][perm$R := exhaleMask#_32[n#3, AVLTreeNode.root][perm$R] - fraction#_34];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_32);
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      fraction#_35 := 100;
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 218.24 for AVLTreeNode.udValid."} (fraction#_35 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) && ((fraction#_35 == exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) ==> (0 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$N]));
      exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] - fraction#_35];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_32);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      fraction#_36 := 50;
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 219.24 for AVLTreeNode.leftDown."} (fraction#_36 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) && ((fraction#_36 == exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$N]));
      exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] - fraction#_36];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_32);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      fraction#_37 := 50;
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 220.24 for AVLTreeNode.left."} (fraction#_37 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) && ((fraction#_37 == exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$N]));
      exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] - fraction#_37];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_32);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 221.26 might not evaluate to true."} Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      fraction#_38 := 50;
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 222.24 for AVLTreeNode.right."} (fraction#_38 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) && ((fraction#_38 == exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$N]));
      exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] - fraction#_38];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_32);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 223.25 might not evaluate to true."} (!Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      fraction#_39 := 50;
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 224.24 for AVLTreeNode.root."} (fraction#_39 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) && ((fraction#_39 == exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$N]));
      exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := exhaleMask#_32[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] - fraction#_39];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_32);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 225.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
    } else {
    }
    if (Heap[n#3, AVLTreeNode.parent] == null) {
      assert {:msg "  54.4: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 226.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == n#3;
    } else {
    }
    Mask := exhaleMask#_32;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_40;
    assume IsGoodInhaleState(inhaleHeap#_40, Heap, Mask);
    assume n#3 != null;
    Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_40[n#3, AVLTreeNode.udParentValid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_40[n#3, AVLTreeNode.udParentValid] == Heap;
    Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_40[n#3, AVLTreeNode.udParentValid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_40, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[n#3, AVLTreeNode.udParentValid] := Heap;
    assume wf(Heap, Mask);
    // while
    whileHeap#_41 := Heap;
    whileMask#_42 := Mask;
    whileCredits#_43 := Credits;
    // begin exhale (loop invariant, initially)
    exhaleMask#_47 := Mask;
    fraction#_48 := 100;
    assert {:msg "  56.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 56.15 for AVLTree.root."} (fraction#_48 <= exhaleMask#_47[this, AVLTree.root][perm$R]) && ((fraction#_48 == exhaleMask#_47[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_47[this, AVLTree.root][perm$N]));
    exhaleMask#_47[this, AVLTree.root] := exhaleMask#_47[this, AVLTree.root][perm$R := exhaleMask#_47[this, AVLTree.root][perm$R] - fraction#_48];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_47);
    fraction#_49 := 50;
    assert {:msg "  57.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 57.15 for AVLTreeNode.parent."} (fraction#_49 <= exhaleMask#_47[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) && ((fraction#_49 == exhaleMask#_47[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_47[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$N]));
    exhaleMask#_47[Heap[this, AVLTree.root], AVLTreeNode.parent] := exhaleMask#_47[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := exhaleMask#_47[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] - fraction#_49];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_47);
    assert {:msg "  58.15: The loop invariant might not hold on entry to the loop. The expression at 58.15 might not evaluate to true."} !(n#3 == null);
    fraction#_50 := 100;
    assert {:msg "  59.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 59.15 for AVLTreeNode.valid."} (fraction#_50 <= exhaleMask#_47[n#3, AVLTreeNode.valid][perm$R]) && ((fraction#_50 == exhaleMask#_47[n#3, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_47[n#3, AVLTreeNode.valid][perm$N]));
    exhaleMask#_47[n#3, AVLTreeNode.valid] := exhaleMask#_47[n#3, AVLTreeNode.valid][perm$R := exhaleMask#_47[n#3, AVLTreeNode.valid][perm$R] - fraction#_50];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_47);
    fraction#_51 := 40;
    assert {:msg "  60.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 60.15 for AVLTreeNode.root."} (fraction#_51 <= exhaleMask#_47[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_51 == exhaleMask#_47[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_47[n#3, AVLTreeNode.root][perm$N]));
    exhaleMask#_47[n#3, AVLTreeNode.root] := exhaleMask#_47[n#3, AVLTreeNode.root][perm$R := exhaleMask#_47[n#3, AVLTreeNode.root][perm$R] - fraction#_51];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_47);
    fraction#_52 := 100;
    assert {:msg "  61.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 61.15 for AVLTreeNode.udParentValid."} (fraction#_52 <= exhaleMask#_47[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_52 == exhaleMask#_47[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_47[n#3, AVLTreeNode.udParentValid][perm$N]));
    exhaleMask#_47[n#3, AVLTreeNode.udParentValid] := exhaleMask#_47[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_47[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_52];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_47);
    assert {:msg "  62.15: The loop invariant might not hold on entry to the loop. The expression at 62.15 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
    assert {:msg "  63.15: The loop invariant might not hold on entry to the loop. The expression at 63.15 might not evaluate to true."} !(Heap[this, AVLTree.root] == null);
    Mask := exhaleMask#_47;
    assume wf(Heap, Mask);
    // end exhale
    assert {:msg "  55.4: Loop invariant must consume all debt on entry to the loop."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
    // check lockchange on entry to the loop
    assert {:msg "  55.4: Method execution before loop might lock/unlock more than allowed by lockchange clause of loop."} (forall lk#_53: ref :: {Heap[lk#_53, held]} {Heap[lk#_53, rdheld]} (((0 < Heap[lk#_53, held]) == (0 < old(Heap)[lk#_53, held])) && (Heap[lk#_53, rdheld] == old(Heap)[lk#_53, rdheld])) || false);
    end#13 := end#5;
    b#14 := b#1;
    n#15 := n#3;
    havoc end#5;
    havoc b#1;
    havoc n#3;
    if (*) {
      // check loop invariant definedness
      havoc Heap;
      Mask := ZeroMask;
      Credits := ZeroCredits;
      // inhale (loop invariant definedness)
      havoc inhaleHeap#_54;
      assume IsGoodInhaleState(inhaleHeap#_54, Heap, Mask);
      assert {:msg "  56.24: Fraction might be negative."} 0 <= 100;
      assert {:msg "  56.24: Fraction might exceed 100."} 100 <= 100;
      assume this != null;
      Heap[this, AVLTree.root] := inhaleHeap#_54[this, AVLTree.root];
      assume wf(Heap, Mask);
      assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
      Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_54[this, AVLTree.root]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_54, Mask);
      assert {:msg "  57.19: Receiver might be null."} true ==> (this != null);
      assert {:msg "  57.19: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
      assert {:msg "  57.31: Fraction might be negative."} 0 <= 50;
      assert {:msg "  57.31: Fraction might exceed 100."} 50 <= 100;
      assume Heap[this, AVLTree.root] != null;
      Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_54[Heap[this, AVLTree.root], AVLTreeNode.parent];
      assume wf(Heap, Mask);
      assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
      Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 50];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_54[Heap[this, AVLTree.root], AVLTreeNode.parent]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_54, Mask);
      assume !(n#3 == null);
      assume n#3 != null;
      Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_54[n#3, AVLTreeNode.valid];
      assume wf(Heap, Mask);
      assume inhaleHeap#_54[n#3, AVLTreeNode.valid] == Heap;
      Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_54[n#3, AVLTreeNode.valid]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_54, Mask);
      assert {:msg "  60.26: Fraction might be negative."} 0 <= 40;
      assert {:msg "  60.26: Fraction might exceed 100."} 40 <= 100;
      assume n#3 != null;
      Heap[n#3, AVLTreeNode.root] := inhaleHeap#_54[n#3, AVLTreeNode.root];
      assume wf(Heap, Mask);
      assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
      Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 40];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_54[n#3, AVLTreeNode.root]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_54, Mask);
      assume n#3 != null;
      Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_54[n#3, AVLTreeNode.udParentValid];
      assume wf(Heap, Mask);
      assume inhaleHeap#_54[n#3, AVLTreeNode.udParentValid] == Heap;
      Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_54[n#3, AVLTreeNode.udParentValid]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_54, Mask);
      // unfolding
      assert {:msg "  62.25: Receiver might be null."} true ==> (n#3 != null);
      Heap#_58 := Heap;
      Mask#_59 := Mask;
      Credits#_60 := Credits;
      // begin exhale (unfolding)
      exhaleMask#_61 := Mask#_59;
      fraction#_62 := 100;
      assert {:msg "  62.15: Unfolding might fail. Insufficient fraction at 62.25 for AVLTreeNode.valid."} (fraction#_62 <= exhaleMask#_61[n#3, AVLTreeNode.valid][perm$R]) && ((fraction#_62 == exhaleMask#_61[n#3, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_61[n#3, AVLTreeNode.valid][perm$N]));
      exhaleMask#_61[n#3, AVLTreeNode.valid] := exhaleMask#_61[n#3, AVLTreeNode.valid][perm$R := exhaleMask#_61[n#3, AVLTreeNode.valid][perm$R] - fraction#_62];
      assume IsGoodMask(Mask#_59);
      assume wf(Heap#_58, Mask#_59);
      assume wf(Heap#_58, exhaleMask#_61);
      Mask#_59 := exhaleMask#_61;
      assume wf(Heap#_58, Mask#_59);
      // end exhale
      // inhale (unfolding)
      inhaleHeap#_63 := Heap[n#3, AVLTreeNode.valid];
      assume IsGoodInhaleState(inhaleHeap#_63, Heap#_58, Mask#_59);
      assume n#3 != null;
      Heap#_58[n#3, AVLTreeNode.validRest] := inhaleHeap#_63[n#3, AVLTreeNode.validRest];
      assume wf(Heap#_58, Mask#_59);
      assume inhaleHeap#_63[n#3, AVLTreeNode.validRest] == Heap#_58;
      Mask#_59[n#3, AVLTreeNode.validRest] := Mask#_59[n#3, AVLTreeNode.validRest][perm$R := Mask#_59[n#3, AVLTreeNode.validRest][perm$R] + 100];
      assume IsGoodMask(Mask#_59);
      assume IsGoodState(inhaleHeap#_63[n#3, AVLTreeNode.validRest]);
      assume wf(Heap#_58, Mask#_59);
      assume wf(inhaleHeap#_63, Mask#_59);
      assume n#3 != null;
      Heap#_58[n#3, AVLTreeNode.leftValid] := inhaleHeap#_63[n#3, AVLTreeNode.leftValid];
      assume wf(Heap#_58, Mask#_59);
      assume inhaleHeap#_63[n#3, AVLTreeNode.leftValid] == Heap#_58;
      Mask#_59[n#3, AVLTreeNode.leftValid] := Mask#_59[n#3, AVLTreeNode.leftValid][perm$R := Mask#_59[n#3, AVLTreeNode.leftValid][perm$R] + 100];
      assume IsGoodMask(Mask#_59);
      assume IsGoodState(inhaleHeap#_63[n#3, AVLTreeNode.leftValid]);
      assume wf(Heap#_58, Mask#_59);
      assume wf(inhaleHeap#_63, Mask#_59);
      assume n#3 != null;
      Heap#_58[n#3, AVLTreeNode.rightValid] := inhaleHeap#_63[n#3, AVLTreeNode.rightValid];
      assume wf(Heap#_58, Mask#_59);
      assume inhaleHeap#_63[n#3, AVLTreeNode.rightValid] == Heap#_58;
      Mask#_59[n#3, AVLTreeNode.rightValid] := Mask#_59[n#3, AVLTreeNode.rightValid][perm$R := Mask#_59[n#3, AVLTreeNode.rightValid][perm$R] + 100];
      assume IsGoodMask(Mask#_59);
      assume IsGoodState(inhaleHeap#_63[n#3, AVLTreeNode.rightValid]);
      assume wf(Heap#_58, Mask#_59);
      assume wf(inhaleHeap#_63, Mask#_59);
      assume IsGoodMask(Mask#_59);
      assume wf(Heap#_58, Mask#_59);
      // end inhale
      assert {:msg "  62.36: Receiver might be null."} true ==> (n#3 != null);
      assert {:msg "  62.36: Location might not be readable."} true ==> CanRead(Mask#_59, n#3, AVLTreeNode.root);
      assert {:msg "  62.44: Receiver might be null."} true ==> (this != null);
      assert {:msg "  62.44: Location might not be readable."} true ==> CanRead(Mask#_59, this, AVLTree.root);
      assume Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
      assert {:msg "  63.15: Receiver might be null."} true ==> (this != null);
      assert {:msg "  63.15: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
      assume !(Heap[this, AVLTree.root] == null);
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      // end inhale
      assume false;
    } else {
      if (*) {
        havoc Heap;
        Mask := ZeroMask;
        Credits := ZeroCredits;
        // inhale (loop invariant, body)
        havoc inhaleHeap#_64;
        assume IsGoodInhaleState(inhaleHeap#_64, Heap, Mask);
        assume this != null;
        Heap[this, AVLTree.root] := inhaleHeap#_64[this, AVLTree.root];
        assume wf(Heap, Mask);
        assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
        Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_64[this, AVLTree.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_64, Mask);
        assume Heap[this, AVLTree.root] != null;
        Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_64[Heap[this, AVLTree.root], AVLTreeNode.parent];
        assume wf(Heap, Mask);
        assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
        Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 50];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_64[Heap[this, AVLTree.root], AVLTreeNode.parent]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_64, Mask);
        assume !(n#3 == null);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_64[n#3, AVLTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_64[n#3, AVLTreeNode.valid] == Heap;
        Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_64[n#3, AVLTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_64, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.root] := inhaleHeap#_64[n#3, AVLTreeNode.root];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 40];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_64[n#3, AVLTreeNode.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_64, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_64[n#3, AVLTreeNode.udParentValid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_64[n#3, AVLTreeNode.udParentValid] == Heap;
        Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_64[n#3, AVLTreeNode.udParentValid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_64, Mask);
        assume Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
        assume !(Heap[this, AVLTree.root] == null);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // assume lockchange at the beginning of the loop iteration
        assume (forall lk#_65: ref :: {Heap[lk#_65, held]} {Heap[lk#_65, rdheld]} (((0 < Heap[lk#_65, held]) == (0 < old(Heap)[lk#_65, held])) && (Heap[lk#_65, rdheld] == old(Heap)[lk#_65, rdheld])) || false);
        iterStartHeap#_44 := Heap;
        iterStartMask#_45 := Mask;
        iterStartCredits#_46 := Credits;
        end#16 := end#5;
        b#17 := b#1;
        n#18 := n#3;
        assume !end#5;
        // unfold
        assert {:msg "  65.5: The target of the fold statement might be null."} n#3 != null;
        // begin exhale (unfold)
        exhaleMask#_66 := Mask;
        fraction#_67 := 100;
        assert {:msg "  65.5: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid."} (fraction#_67 <= exhaleMask#_66[n#3, AVLTreeNode.valid][perm$R]) && ((fraction#_67 == exhaleMask#_66[n#3, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_66[n#3, AVLTreeNode.valid][perm$N]));
        exhaleMask#_66[n#3, AVLTreeNode.valid] := exhaleMask#_66[n#3, AVLTreeNode.valid][perm$R := exhaleMask#_66[n#3, AVLTreeNode.valid][perm$R] - fraction#_67];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_66);
        Mask := exhaleMask#_66;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (unfold)
        inhaleHeap#_68 := Heap[n#3, AVLTreeNode.valid];
        assume IsGoodInhaleState(inhaleHeap#_68, Heap, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.validRest] := inhaleHeap#_68[n#3, AVLTreeNode.validRest];
        assume wf(Heap, Mask);
        assume inhaleHeap#_68[n#3, AVLTreeNode.validRest] == Heap;
        Mask[n#3, AVLTreeNode.validRest] := Mask[n#3, AVLTreeNode.validRest][perm$R := Mask[n#3, AVLTreeNode.validRest][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_68[n#3, AVLTreeNode.validRest]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_68, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.leftValid] := inhaleHeap#_68[n#3, AVLTreeNode.leftValid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_68[n#3, AVLTreeNode.leftValid] == Heap;
        Mask[n#3, AVLTreeNode.leftValid] := Mask[n#3, AVLTreeNode.leftValid][perm$R := Mask[n#3, AVLTreeNode.leftValid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_68[n#3, AVLTreeNode.leftValid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_68, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.rightValid] := inhaleHeap#_68[n#3, AVLTreeNode.rightValid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_68[n#3, AVLTreeNode.rightValid] == Heap;
        Mask[n#3, AVLTreeNode.rightValid] := Mask[n#3, AVLTreeNode.rightValid][perm$R := Mask[n#3, AVLTreeNode.rightValid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_68[n#3, AVLTreeNode.rightValid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_68, Mask);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // unfold
        assert {:msg "  66.5: The target of the fold statement might be null."} n#3 != null;
        // begin exhale (unfold)
        exhaleMask#_69 := Mask;
        fraction#_70 := 100;
        assert {:msg "  66.5: unfold might fail because the predicate AVLTreeNode.validRest does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.validRest."} (fraction#_70 <= exhaleMask#_69[n#3, AVLTreeNode.validRest][perm$R]) && ((fraction#_70 == exhaleMask#_69[n#3, AVLTreeNode.validRest][perm$R]) ==> (0 <= exhaleMask#_69[n#3, AVLTreeNode.validRest][perm$N]));
        exhaleMask#_69[n#3, AVLTreeNode.validRest] := exhaleMask#_69[n#3, AVLTreeNode.validRest][perm$R := exhaleMask#_69[n#3, AVLTreeNode.validRest][perm$R] - fraction#_70];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_69);
        Mask := exhaleMask#_69;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (unfold)
        inhaleHeap#_71 := Heap[n#3, AVLTreeNode.validRest];
        assume IsGoodInhaleState(inhaleHeap#_71, Heap, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.key] := inhaleHeap#_71[n#3, AVLTreeNode.key];
        assume wf(Heap, Mask);
        assume true;
        Mask[n#3, AVLTreeNode.key] := Mask[n#3, AVLTreeNode.key][perm$R := Mask[n#3, AVLTreeNode.key][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_71[n#3, AVLTreeNode.key]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_71, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.root] := inhaleHeap#_71[n#3, AVLTreeNode.root];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 30];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_71[n#3, AVLTreeNode.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_71, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.left] := inhaleHeap#_71[n#3, AVLTreeNode.left];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.left] == null) || (dtype(Heap[n#3, AVLTreeNode.left]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.left] := Mask[n#3, AVLTreeNode.left][perm$R := Mask[n#3, AVLTreeNode.left][perm$R] + 75];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_71[n#3, AVLTreeNode.left]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_71, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.right] := inhaleHeap#_71[n#3, AVLTreeNode.right];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.right] == null) || (dtype(Heap[n#3, AVLTreeNode.right]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.right] := Mask[n#3, AVLTreeNode.right][perm$R := Mask[n#3, AVLTreeNode.right][perm$R] + 75];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_71[n#3, AVLTreeNode.right]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_71, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.leftDown] := inhaleHeap#_71[n#3, AVLTreeNode.leftDown];
        assume wf(Heap, Mask);
        assume true;
        Mask[n#3, AVLTreeNode.leftDown] := Mask[n#3, AVLTreeNode.leftDown][perm$R := Mask[n#3, AVLTreeNode.leftDown][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_71[n#3, AVLTreeNode.leftDown]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_71, Mask);
        assume (!(Heap[n#3, AVLTreeNode.right] == Heap[n#3, AVLTreeNode.left])) || (Heap[n#3, AVLTreeNode.right] == null);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // if
        assert {:msg "  67.9: Receiver might be null."} true ==> (n#3 != null);
        assert {:msg "  67.9: Location might not be readable."} true ==> CanRead(Mask, n#3, AVLTreeNode.key);
        if (Heap[n#3, AVLTreeNode.key] == k#0) {
          // assigment to b
          b#1 := true;
          // fold
          assert {:msg "  69.6: The target of the fold statement might be null."} n#3 != null;
          // begin exhale (fold)
          exhaleMask#_72 := Mask;
          fraction#_73 := 100;
          assert {:msg "  69.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 172.6 for AVLTreeNode.key."} (fraction#_73 <= exhaleMask#_72[n#3, AVLTreeNode.key][perm$R]) && ((fraction#_73 == exhaleMask#_72[n#3, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_72[n#3, AVLTreeNode.key][perm$N]));
          exhaleMask#_72[n#3, AVLTreeNode.key] := exhaleMask#_72[n#3, AVLTreeNode.key][perm$R := exhaleMask#_72[n#3, AVLTreeNode.key][perm$R] - fraction#_73];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_72);
          fraction#_74 := 30;
          assert {:msg "  69.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 173.6 for AVLTreeNode.root."} (fraction#_74 <= exhaleMask#_72[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_74 == exhaleMask#_72[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_72[n#3, AVLTreeNode.root][perm$N]));
          exhaleMask#_72[n#3, AVLTreeNode.root] := exhaleMask#_72[n#3, AVLTreeNode.root][perm$R := exhaleMask#_72[n#3, AVLTreeNode.root][perm$R] - fraction#_74];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_72);
          fraction#_75 := 75;
          assert {:msg "  69.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 174.6 for AVLTreeNode.left."} (fraction#_75 <= exhaleMask#_72[n#3, AVLTreeNode.left][perm$R]) && ((fraction#_75 == exhaleMask#_72[n#3, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_72[n#3, AVLTreeNode.left][perm$N]));
          exhaleMask#_72[n#3, AVLTreeNode.left] := exhaleMask#_72[n#3, AVLTreeNode.left][perm$R := exhaleMask#_72[n#3, AVLTreeNode.left][perm$R] - fraction#_75];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_72);
          fraction#_76 := 75;
          assert {:msg "  69.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 175.6 for AVLTreeNode.right."} (fraction#_76 <= exhaleMask#_72[n#3, AVLTreeNode.right][perm$R]) && ((fraction#_76 == exhaleMask#_72[n#3, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_72[n#3, AVLTreeNode.right][perm$N]));
          exhaleMask#_72[n#3, AVLTreeNode.right] := exhaleMask#_72[n#3, AVLTreeNode.right][perm$R := exhaleMask#_72[n#3, AVLTreeNode.right][perm$R] - fraction#_76];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_72);
          fraction#_77 := 100;
          assert {:msg "  69.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 176.6 for AVLTreeNode.leftDown."} (fraction#_77 <= exhaleMask#_72[n#3, AVLTreeNode.leftDown][perm$R]) && ((fraction#_77 == exhaleMask#_72[n#3, AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_72[n#3, AVLTreeNode.leftDown][perm$N]));
          exhaleMask#_72[n#3, AVLTreeNode.leftDown] := exhaleMask#_72[n#3, AVLTreeNode.leftDown][perm$R := exhaleMask#_72[n#3, AVLTreeNode.leftDown][perm$R] - fraction#_77];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_72);
          assert {:msg "  69.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. The expression at 177.7 might not evaluate to true."} (!(Heap[n#3, AVLTreeNode.right] == Heap[n#3, AVLTreeNode.left])) || (Heap[n#3, AVLTreeNode.right] == null);
          Mask := exhaleMask#_72;
          assume wf(Heap, Mask);
          // end exhale
          // inhale (fold)
          havoc inhaleHeap#_78;
          assume IsGoodInhaleState(inhaleHeap#_78, Heap, Mask);
          assume n#3 != null;
          Heap[n#3, AVLTreeNode.validRest] := inhaleHeap#_78[n#3, AVLTreeNode.validRest];
          assume wf(Heap, Mask);
          assume inhaleHeap#_78[n#3, AVLTreeNode.validRest] == Heap;
          Mask[n#3, AVLTreeNode.validRest] := Mask[n#3, AVLTreeNode.validRest][perm$R := Mask[n#3, AVLTreeNode.validRest][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_78[n#3, AVLTreeNode.validRest]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_78, Mask);
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          // end inhale
          Heap[n#3, AVLTreeNode.validRest] := Heap;
          assume wf(Heap, Mask);
          // fold
          assert {:msg "  70.6: The target of the fold statement might be null."} n#3 != null;
          // begin exhale (fold)
          exhaleMask#_79 := Mask;
          fraction#_80 := 100;
          assert {:msg "  70.6: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 165.6 for AVLTreeNode.validRest."} (fraction#_80 <= exhaleMask#_79[n#3, AVLTreeNode.validRest][perm$R]) && ((fraction#_80 == exhaleMask#_79[n#3, AVLTreeNode.validRest][perm$R]) ==> (0 <= exhaleMask#_79[n#3, AVLTreeNode.validRest][perm$N]));
          exhaleMask#_79[n#3, AVLTreeNode.validRest] := exhaleMask#_79[n#3, AVLTreeNode.validRest][perm$R := exhaleMask#_79[n#3, AVLTreeNode.validRest][perm$R] - fraction#_80];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_79);
          fraction#_81 := 100;
          assert {:msg "  70.6: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 166.6 for AVLTreeNode.leftValid."} (fraction#_81 <= exhaleMask#_79[n#3, AVLTreeNode.leftValid][perm$R]) && ((fraction#_81 == exhaleMask#_79[n#3, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_79[n#3, AVLTreeNode.leftValid][perm$N]));
          exhaleMask#_79[n#3, AVLTreeNode.leftValid] := exhaleMask#_79[n#3, AVLTreeNode.leftValid][perm$R := exhaleMask#_79[n#3, AVLTreeNode.leftValid][perm$R] - fraction#_81];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_79);
          fraction#_82 := 100;
          assert {:msg "  70.6: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 167.6 for AVLTreeNode.rightValid."} (fraction#_82 <= exhaleMask#_79[n#3, AVLTreeNode.rightValid][perm$R]) && ((fraction#_82 == exhaleMask#_79[n#3, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_79[n#3, AVLTreeNode.rightValid][perm$N]));
          exhaleMask#_79[n#3, AVLTreeNode.rightValid] := exhaleMask#_79[n#3, AVLTreeNode.rightValid][perm$R := exhaleMask#_79[n#3, AVLTreeNode.rightValid][perm$R] - fraction#_82];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_79);
          Mask := exhaleMask#_79;
          assume wf(Heap, Mask);
          // end exhale
          // inhale (fold)
          havoc inhaleHeap#_83;
          assume IsGoodInhaleState(inhaleHeap#_83, Heap, Mask);
          assume n#3 != null;
          Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_83[n#3, AVLTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_83[n#3, AVLTreeNode.valid] == Heap;
          Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_83[n#3, AVLTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_83, Mask);
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          // end inhale
          Heap[n#3, AVLTreeNode.valid] := Heap;
          assume wf(Heap, Mask);
          // assigment to end
          end#5 := true;
        } else {
          // if
          assert {:msg "  73.10: Receiver might be null."} true ==> (n#3 != null);
          assert {:msg "  73.10: Location might not be readable."} true ==> CanRead(Mask, n#3, AVLTreeNode.key);
          if (Heap[n#3, AVLTreeNode.key] < k#0) {
            // if
            assert {:msg "  74.11: Receiver might be null."} true ==> (n#3 != null);
            assert {:msg "  74.11: Location might not be readable."} true ==> CanRead(Mask, n#3, AVLTreeNode.left);
            if (Heap[n#3, AVLTreeNode.left] == null) {
              // assigment to end
              end#5 := true;
              // fold
              assert {:msg "  76.8: The target of the fold statement might be null."} n#3 != null;
              // begin exhale (fold)
              exhaleMask#_84 := Mask;
              fraction#_85 := 100;
              assert {:msg "  76.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 172.6 for AVLTreeNode.key."} (fraction#_85 <= exhaleMask#_84[n#3, AVLTreeNode.key][perm$R]) && ((fraction#_85 == exhaleMask#_84[n#3, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_84[n#3, AVLTreeNode.key][perm$N]));
              exhaleMask#_84[n#3, AVLTreeNode.key] := exhaleMask#_84[n#3, AVLTreeNode.key][perm$R := exhaleMask#_84[n#3, AVLTreeNode.key][perm$R] - fraction#_85];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_84);
              fraction#_86 := 30;
              assert {:msg "  76.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 173.6 for AVLTreeNode.root."} (fraction#_86 <= exhaleMask#_84[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_86 == exhaleMask#_84[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_84[n#3, AVLTreeNode.root][perm$N]));
              exhaleMask#_84[n#3, AVLTreeNode.root] := exhaleMask#_84[n#3, AVLTreeNode.root][perm$R := exhaleMask#_84[n#3, AVLTreeNode.root][perm$R] - fraction#_86];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_84);
              fraction#_87 := 75;
              assert {:msg "  76.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 174.6 for AVLTreeNode.left."} (fraction#_87 <= exhaleMask#_84[n#3, AVLTreeNode.left][perm$R]) && ((fraction#_87 == exhaleMask#_84[n#3, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_84[n#3, AVLTreeNode.left][perm$N]));
              exhaleMask#_84[n#3, AVLTreeNode.left] := exhaleMask#_84[n#3, AVLTreeNode.left][perm$R := exhaleMask#_84[n#3, AVLTreeNode.left][perm$R] - fraction#_87];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_84);
              fraction#_88 := 75;
              assert {:msg "  76.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 175.6 for AVLTreeNode.right."} (fraction#_88 <= exhaleMask#_84[n#3, AVLTreeNode.right][perm$R]) && ((fraction#_88 == exhaleMask#_84[n#3, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_84[n#3, AVLTreeNode.right][perm$N]));
              exhaleMask#_84[n#3, AVLTreeNode.right] := exhaleMask#_84[n#3, AVLTreeNode.right][perm$R := exhaleMask#_84[n#3, AVLTreeNode.right][perm$R] - fraction#_88];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_84);
              fraction#_89 := 100;
              assert {:msg "  76.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 176.6 for AVLTreeNode.leftDown."} (fraction#_89 <= exhaleMask#_84[n#3, AVLTreeNode.leftDown][perm$R]) && ((fraction#_89 == exhaleMask#_84[n#3, AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_84[n#3, AVLTreeNode.leftDown][perm$N]));
              exhaleMask#_84[n#3, AVLTreeNode.leftDown] := exhaleMask#_84[n#3, AVLTreeNode.leftDown][perm$R := exhaleMask#_84[n#3, AVLTreeNode.leftDown][perm$R] - fraction#_89];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_84);
              assert {:msg "  76.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. The expression at 177.7 might not evaluate to true."} (!(Heap[n#3, AVLTreeNode.right] == Heap[n#3, AVLTreeNode.left])) || (Heap[n#3, AVLTreeNode.right] == null);
              Mask := exhaleMask#_84;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_90;
              assume IsGoodInhaleState(inhaleHeap#_90, Heap, Mask);
              assume n#3 != null;
              Heap[n#3, AVLTreeNode.validRest] := inhaleHeap#_90[n#3, AVLTreeNode.validRest];
              assume wf(Heap, Mask);
              assume inhaleHeap#_90[n#3, AVLTreeNode.validRest] == Heap;
              Mask[n#3, AVLTreeNode.validRest] := Mask[n#3, AVLTreeNode.validRest][perm$R := Mask[n#3, AVLTreeNode.validRest][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_90[n#3, AVLTreeNode.validRest]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_90, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[n#3, AVLTreeNode.validRest] := Heap;
              assume wf(Heap, Mask);
              // fold
              assert {:msg "  77.8: The target of the fold statement might be null."} n#3 != null;
              // begin exhale (fold)
              exhaleMask#_91 := Mask;
              fraction#_92 := 100;
              assert {:msg "  77.8: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 165.6 for AVLTreeNode.validRest."} (fraction#_92 <= exhaleMask#_91[n#3, AVLTreeNode.validRest][perm$R]) && ((fraction#_92 == exhaleMask#_91[n#3, AVLTreeNode.validRest][perm$R]) ==> (0 <= exhaleMask#_91[n#3, AVLTreeNode.validRest][perm$N]));
              exhaleMask#_91[n#3, AVLTreeNode.validRest] := exhaleMask#_91[n#3, AVLTreeNode.validRest][perm$R := exhaleMask#_91[n#3, AVLTreeNode.validRest][perm$R] - fraction#_92];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_91);
              fraction#_93 := 100;
              assert {:msg "  77.8: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 166.6 for AVLTreeNode.leftValid."} (fraction#_93 <= exhaleMask#_91[n#3, AVLTreeNode.leftValid][perm$R]) && ((fraction#_93 == exhaleMask#_91[n#3, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_91[n#3, AVLTreeNode.leftValid][perm$N]));
              exhaleMask#_91[n#3, AVLTreeNode.leftValid] := exhaleMask#_91[n#3, AVLTreeNode.leftValid][perm$R := exhaleMask#_91[n#3, AVLTreeNode.leftValid][perm$R] - fraction#_93];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_91);
              fraction#_94 := 100;
              assert {:msg "  77.8: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 167.6 for AVLTreeNode.rightValid."} (fraction#_94 <= exhaleMask#_91[n#3, AVLTreeNode.rightValid][perm$R]) && ((fraction#_94 == exhaleMask#_91[n#3, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_91[n#3, AVLTreeNode.rightValid][perm$N]));
              exhaleMask#_91[n#3, AVLTreeNode.rightValid] := exhaleMask#_91[n#3, AVLTreeNode.rightValid][perm$R := exhaleMask#_91[n#3, AVLTreeNode.rightValid][perm$R] - fraction#_94];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_91);
              Mask := exhaleMask#_91;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_95;
              assume IsGoodInhaleState(inhaleHeap#_95, Heap, Mask);
              assume n#3 != null;
              Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_95[n#3, AVLTreeNode.valid];
              assume wf(Heap, Mask);
              assume inhaleHeap#_95[n#3, AVLTreeNode.valid] == Heap;
              Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_95[n#3, AVLTreeNode.valid]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_95, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[n#3, AVLTreeNode.valid] := Heap;
              assume wf(Heap, Mask);
            } else {
              // local var p
              // assigment to p
              p#7 := n#3;
              // unfold
              assert {:msg "  80.8: The target of the fold statement might be null."} p#7 != null;
              // begin exhale (unfold)
              exhaleMask#_96 := Mask;
              fraction#_97 := 100;
              assert {:msg "  80.8: unfold might fail because the predicate AVLTreeNode.leftValid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.leftValid."} (fraction#_97 <= exhaleMask#_96[p#7, AVLTreeNode.leftValid][perm$R]) && ((fraction#_97 == exhaleMask#_96[p#7, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_96[p#7, AVLTreeNode.leftValid][perm$N]));
              exhaleMask#_96[p#7, AVLTreeNode.leftValid] := exhaleMask#_96[p#7, AVLTreeNode.leftValid][perm$R := exhaleMask#_96[p#7, AVLTreeNode.leftValid][perm$R] - fraction#_97];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_96);
              Mask := exhaleMask#_96;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (unfold)
              inhaleHeap#_98 := Heap[p#7, AVLTreeNode.leftValid];
              assume IsGoodInhaleState(inhaleHeap#_98, Heap, Mask);
              assume p#7 != null;
              Heap[p#7, AVLTreeNode.left] := inhaleHeap#_98[p#7, AVLTreeNode.left];
              assume wf(Heap, Mask);
              assume (Heap[p#7, AVLTreeNode.left] == null) || (dtype(Heap[p#7, AVLTreeNode.left]) == AVLTreeNode#t);
              Mask[p#7, AVLTreeNode.left] := Mask[p#7, AVLTreeNode.left][perm$R := Mask[p#7, AVLTreeNode.left][perm$R] + 25];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_98[p#7, AVLTreeNode.left]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_98, Mask);
              assume p#7 != null;
              Heap[p#7, AVLTreeNode.root] := inhaleHeap#_98[p#7, AVLTreeNode.root];
              assume wf(Heap, Mask);
              assume (Heap[p#7, AVLTreeNode.root] == null) || (dtype(Heap[p#7, AVLTreeNode.root]) == AVLTreeNode#t);
              Mask[p#7, AVLTreeNode.root] := Mask[p#7, AVLTreeNode.root][perm$R := Mask[p#7, AVLTreeNode.root][perm$R] + 10];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_98[p#7, AVLTreeNode.root]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_98, Mask);
              if (!(Heap[p#7, AVLTreeNode.left] == null)) {
                assume Heap[p#7, AVLTreeNode.left] != null;
                Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.valid] := inhaleHeap#_98[Heap[p#7, AVLTreeNode.left], AVLTreeNode.valid];
                assume wf(Heap, Mask);
                assume inhaleHeap#_98[Heap[p#7, AVLTreeNode.left], AVLTreeNode.valid] == Heap;
                Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + 100];
                assume IsGoodMask(Mask);
                assume IsGoodState(inhaleHeap#_98[Heap[p#7, AVLTreeNode.left], AVLTreeNode.valid]);
                assume wf(Heap, Mask);
                assume wf(inhaleHeap#_98, Mask);
              } else {
              }
              if (!(Heap[p#7, AVLTreeNode.left] == null)) {
                assume Heap[p#7, AVLTreeNode.left] != null;
                Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent] := inhaleHeap#_98[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent];
                assume wf(Heap, Mask);
                assume (Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent]) == AVLTreeNode#t);
                Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent] := Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent][perm$R := Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent][perm$R] + 100];
                assume IsGoodMask(Mask);
                assume IsGoodState(inhaleHeap#_98[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent]);
                assume wf(Heap, Mask);
                assume wf(inhaleHeap#_98, Mask);
              } else {
              }
              if (!(Heap[p#7, AVLTreeNode.left] == null)) {
                assume Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent] == p#7;
              } else {
              }
              if (!(Heap[p#7, AVLTreeNode.left] == null)) {
                assume Heap[p#7, AVLTreeNode.left] != null;
                Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root] := inhaleHeap#_98[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root];
                assume wf(Heap, Mask);
                assume (Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root] == null) || (dtype(Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root]) == AVLTreeNode#t);
                Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root] := Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root][perm$R := Mask[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root][perm$R] + 50];
                assume IsGoodMask(Mask);
                assume IsGoodState(inhaleHeap#_98[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root]);
                assume wf(Heap, Mask);
                assume wf(inhaleHeap#_98, Mask);
              } else {
              }
              if (!(Heap[p#7, AVLTreeNode.left] == null)) {
                assume Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.root] == Heap[p#7, AVLTreeNode.root];
              } else {
              }
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              // assigment to n
              assert {:msg "  81.13: Receiver might be null."} true ==> (p#7 != null);
              assert {:msg "  81.13: Location might not be readable."} true ==> CanRead(Mask, p#7, AVLTreeNode.left);
              n#3 := Heap[p#7, AVLTreeNode.left];
              // update field leftDown
              assert {:msg "  82.8: Location might not be writable"} CanWrite(Mask, p#7, AVLTreeNode.leftDown);
              Heap[p#7, AVLTreeNode.leftDown] := true;
              assume wf(Heap, Mask);
              // fold
              assert {:msg "  83.8: The target of the fold statement might be null."} p#7 != null;
              // begin exhale (fold)
              exhaleMask#_99 := Mask;
              fraction#_100 := 25;
              assert {:msg "  83.8: Fold might fail because the definition of AVLTreeNode.leftOpen does not hold. Insufficient fraction at 201.6 for AVLTreeNode.left."} (fraction#_100 <= exhaleMask#_99[p#7, AVLTreeNode.left][perm$R]) && ((fraction#_100 == exhaleMask#_99[p#7, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_99[p#7, AVLTreeNode.left][perm$N]));
              exhaleMask#_99[p#7, AVLTreeNode.left] := exhaleMask#_99[p#7, AVLTreeNode.left][perm$R := exhaleMask#_99[p#7, AVLTreeNode.left][perm$R] - fraction#_100];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_99);
              fraction#_101 := 10;
              assert {:msg "  83.8: Fold might fail because the definition of AVLTreeNode.leftOpen does not hold. Insufficient fraction at 202.6 for AVLTreeNode.root."} (fraction#_101 <= exhaleMask#_99[p#7, AVLTreeNode.root][perm$R]) && ((fraction#_101 == exhaleMask#_99[p#7, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_99[p#7, AVLTreeNode.root][perm$N]));
              exhaleMask#_99[p#7, AVLTreeNode.root] := exhaleMask#_99[p#7, AVLTreeNode.root][perm$R := exhaleMask#_99[p#7, AVLTreeNode.root][perm$R] - fraction#_101];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_99);
              if (!(Heap[p#7, AVLTreeNode.left] == null)) {
                fraction#_102 := 50;
                assert {:msg "  83.8: Fold might fail because the definition of AVLTreeNode.leftOpen does not hold. Insufficient fraction at 203.22 for AVLTreeNode.parent."} (fraction#_102 <= exhaleMask#_99[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent][perm$R]) && ((fraction#_102 == exhaleMask#_99[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_99[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent][perm$N]));
                exhaleMask#_99[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent] := exhaleMask#_99[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent][perm$R := exhaleMask#_99[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent][perm$R] - fraction#_102];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_99);
              } else {
              }
              if (!(Heap[p#7, AVLTreeNode.left] == null)) {
                assert {:msg "  83.8: Fold might fail because the definition of AVLTreeNode.leftOpen does not hold. The expression at 204.22 might not evaluate to true."} Heap[Heap[p#7, AVLTreeNode.left], AVLTreeNode.parent] == p#7;
              } else {
              }
              Mask := exhaleMask#_99;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_103;
              assume IsGoodInhaleState(inhaleHeap#_103, Heap, Mask);
              assume p#7 != null;
              Heap[p#7, AVLTreeNode.leftOpen] := inhaleHeap#_103[p#7, AVLTreeNode.leftOpen];
              assume wf(Heap, Mask);
              assume inhaleHeap#_103[p#7, AVLTreeNode.leftOpen] == Heap;
              Mask[p#7, AVLTreeNode.leftOpen] := Mask[p#7, AVLTreeNode.leftOpen][perm$R := Mask[p#7, AVLTreeNode.leftOpen][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_103[p#7, AVLTreeNode.leftOpen]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_103, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[p#7, AVLTreeNode.leftOpen] := Heap;
              assume wf(Heap, Mask);
              // fold
              assert {:msg "  84.8: The target of the fold statement might be null."} p#7 != null;
              // begin exhale (fold)
              exhaleMask#_104 := Mask;
              fraction#_105 := 100;
              assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 230.6 for AVLTreeNode.key."} (fraction#_105 <= exhaleMask#_104[p#7, AVLTreeNode.key][perm$R]) && ((fraction#_105 == exhaleMask#_104[p#7, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.key][perm$N]));
              exhaleMask#_104[p#7, AVLTreeNode.key] := exhaleMask#_104[p#7, AVLTreeNode.key][perm$R := exhaleMask#_104[p#7, AVLTreeNode.key][perm$R] - fraction#_105];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_104);
              fraction#_106 := 50;
              assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 231.6 for AVLTreeNode.leftDown."} (fraction#_106 <= exhaleMask#_104[p#7, AVLTreeNode.leftDown][perm$R]) && ((fraction#_106 == exhaleMask#_104[p#7, AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.leftDown][perm$N]));
              exhaleMask#_104[p#7, AVLTreeNode.leftDown] := exhaleMask#_104[p#7, AVLTreeNode.leftDown][perm$R := exhaleMask#_104[p#7, AVLTreeNode.leftDown][perm$R] - fraction#_106];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_104);
              fraction#_107 := 25;
              assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 232.6 for AVLTreeNode.left."} (fraction#_107 <= exhaleMask#_104[p#7, AVLTreeNode.left][perm$R]) && ((fraction#_107 == exhaleMask#_104[p#7, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.left][perm$N]));
              exhaleMask#_104[p#7, AVLTreeNode.left] := exhaleMask#_104[p#7, AVLTreeNode.left][perm$R := exhaleMask#_104[p#7, AVLTreeNode.left][perm$R] - fraction#_107];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_104);
              fraction#_108 := 25;
              assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 233.6 for AVLTreeNode.right."} (fraction#_108 <= exhaleMask#_104[p#7, AVLTreeNode.right][perm$R]) && ((fraction#_108 == exhaleMask#_104[p#7, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.right][perm$N]));
              exhaleMask#_104[p#7, AVLTreeNode.right] := exhaleMask#_104[p#7, AVLTreeNode.right][perm$R := exhaleMask#_104[p#7, AVLTreeNode.right][perm$R] - fraction#_108];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_104);
              fraction#_109 := 20;
              assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 235.6 for AVLTreeNode.root."} (fraction#_109 <= exhaleMask#_104[p#7, AVLTreeNode.root][perm$R]) && ((fraction#_109 == exhaleMask#_104[p#7, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.root][perm$N]));
              exhaleMask#_104[p#7, AVLTreeNode.root] := exhaleMask#_104[p#7, AVLTreeNode.root][perm$R := exhaleMask#_104[p#7, AVLTreeNode.root][perm$R] - fraction#_109];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_104);
              if (Heap[p#7, AVLTreeNode.leftDown]) {
                fraction#_110 := 100;
                assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 236.21 for AVLTreeNode.rightValid."} (fraction#_110 <= exhaleMask#_104[p#7, AVLTreeNode.rightValid][perm$R]) && ((fraction#_110 == exhaleMask#_104[p#7, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.rightValid][perm$N]));
                exhaleMask#_104[p#7, AVLTreeNode.rightValid] := exhaleMask#_104[p#7, AVLTreeNode.rightValid][perm$R := exhaleMask#_104[p#7, AVLTreeNode.rightValid][perm$R] - fraction#_110];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_104);
              } else {
              }
              if (Heap[p#7, AVLTreeNode.leftDown]) {
                fraction#_111 := 100;
                assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 237.21 for AVLTreeNode.leftOpen."} (fraction#_111 <= exhaleMask#_104[p#7, AVLTreeNode.leftOpen][perm$R]) && ((fraction#_111 == exhaleMask#_104[p#7, AVLTreeNode.leftOpen][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.leftOpen][perm$N]));
                exhaleMask#_104[p#7, AVLTreeNode.leftOpen] := exhaleMask#_104[p#7, AVLTreeNode.leftOpen][perm$R := exhaleMask#_104[p#7, AVLTreeNode.leftOpen][perm$R] - fraction#_111];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_104);
              } else {
              }
              if (!Heap[p#7, AVLTreeNode.leftDown]) {
                fraction#_112 := 100;
                assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 238.21 for AVLTreeNode.leftValid."} (fraction#_112 <= exhaleMask#_104[p#7, AVLTreeNode.leftValid][perm$R]) && ((fraction#_112 == exhaleMask#_104[p#7, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.leftValid][perm$N]));
                exhaleMask#_104[p#7, AVLTreeNode.leftValid] := exhaleMask#_104[p#7, AVLTreeNode.leftValid][perm$R := exhaleMask#_104[p#7, AVLTreeNode.leftValid][perm$R] - fraction#_112];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_104);
              } else {
              }
              if (!Heap[p#7, AVLTreeNode.leftDown]) {
                fraction#_113 := 100;
                assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 239.21 for AVLTreeNode.rightOpen."} (fraction#_113 <= exhaleMask#_104[p#7, AVLTreeNode.rightOpen][perm$R]) && ((fraction#_113 == exhaleMask#_104[p#7, AVLTreeNode.rightOpen][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.rightOpen][perm$N]));
                exhaleMask#_104[p#7, AVLTreeNode.rightOpen] := exhaleMask#_104[p#7, AVLTreeNode.rightOpen][perm$R := exhaleMask#_104[p#7, AVLTreeNode.rightOpen][perm$R] - fraction#_113];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_104);
              } else {
              }
              fraction#_114 := 100;
              assert {:msg "  84.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 241.6 for AVLTreeNode.udParentValid."} (fraction#_114 <= exhaleMask#_104[p#7, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_114 == exhaleMask#_104[p#7, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_104[p#7, AVLTreeNode.udParentValid][perm$N]));
              exhaleMask#_104[p#7, AVLTreeNode.udParentValid] := exhaleMask#_104[p#7, AVLTreeNode.udParentValid][perm$R := exhaleMask#_104[p#7, AVLTreeNode.udParentValid][perm$R] - fraction#_114];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_104);
              Mask := exhaleMask#_104;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_115;
              assume IsGoodInhaleState(inhaleHeap#_115, Heap, Mask);
              assume p#7 != null;
              Heap[p#7, AVLTreeNode.udValid] := inhaleHeap#_115[p#7, AVLTreeNode.udValid];
              assume wf(Heap, Mask);
              assume inhaleHeap#_115[p#7, AVLTreeNode.udValid] == Heap;
              Mask[p#7, AVLTreeNode.udValid] := Mask[p#7, AVLTreeNode.udValid][perm$R := Mask[p#7, AVLTreeNode.udValid][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_115[p#7, AVLTreeNode.udValid]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_115, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[p#7, AVLTreeNode.udValid] := Heap;
              assume wf(Heap, Mask);
              // assert
              Heap#_119 := Heap;
              Mask#_120 := Mask;
              Credits#_121 := Credits;
              // begin exhale (assert)
              exhaleMask#_122 := Mask#_120;
              assert {:msg "  85.15: Receiver might be null."} true ==> (p#7 != null);
              assert {:msg "  85.15: Location might not be readable."} true ==> CanRead(Mask#_120, p#7, AVLTreeNode.right);
              assert {:msg "  85.24: Receiver might be null."} true ==> (p#7 != null);
              assert {:msg "  85.24: Location might not be readable."} true ==> CanRead(Mask#_120, p#7, AVLTreeNode.left);
              assert {:msg "  85.8: Assertion might not hold. The expression at 85.15 might not evaluate to true."} !(Heap#_119[p#7, AVLTreeNode.right] == Heap#_119[p#7, AVLTreeNode.left]);
              Mask#_120 := exhaleMask#_122;
              assume wf(Heap#_119, Mask#_120);
              // end exhale
              // assert
              Heap#_126 := Heap;
              Mask#_127 := Mask;
              Credits#_128 := Credits;
              // begin exhale (assert)
              exhaleMask#_129 := Mask#_127;
              assert {:msg "  86.15: Receiver might be null."} true ==> (n#3 != null);
              assert {:msg "  86.15: Location might not be readable."} true ==> CanRead(Mask#_127, n#3, AVLTreeNode.parent);
              assert {:msg "  86.15: Receiver might be null."} true ==> (Heap#_126[n#3, AVLTreeNode.parent] != null);
              assert {:msg "  86.15: Location might not be readable."} true ==> CanRead(Mask#_127, Heap#_126[n#3, AVLTreeNode.parent], AVLTreeNode.left);
              assert {:msg "  86.8: Assertion might not hold. The expression at 86.15 might not evaluate to true."} Heap#_126[Heap#_126[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3;
              Mask#_127 := exhaleMask#_129;
              assume wf(Heap#_126, Mask#_127);
              // end exhale
              // fold
              assert {:msg "  87.8: The target of the fold statement might be null."} n#3 != null;
              // begin exhale (fold)
              exhaleMask#_130 := Mask;
              fraction#_131 := 50;
              assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 216.6 for AVLTreeNode.parent."} (fraction#_131 <= exhaleMask#_130[n#3, AVLTreeNode.parent][perm$R]) && ((fraction#_131 == exhaleMask#_130[n#3, AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_130[n#3, AVLTreeNode.parent][perm$N]));
              exhaleMask#_130[n#3, AVLTreeNode.parent] := exhaleMask#_130[n#3, AVLTreeNode.parent][perm$R := exhaleMask#_130[n#3, AVLTreeNode.parent][perm$R] - fraction#_131];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_130);
              fraction#_132 := 10;
              assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 217.6 for AVLTreeNode.root."} (fraction#_132 <= exhaleMask#_130[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_132 == exhaleMask#_130[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_130[n#3, AVLTreeNode.root][perm$N]));
              exhaleMask#_130[n#3, AVLTreeNode.root] := exhaleMask#_130[n#3, AVLTreeNode.root][perm$R := exhaleMask#_130[n#3, AVLTreeNode.root][perm$R] - fraction#_132];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_130);
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_133 := 100;
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 218.24 for AVLTreeNode.udValid."} (fraction#_133 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) && ((fraction#_133 == exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) ==> (0 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$N]));
                exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] - fraction#_133];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_130);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_134 := 50;
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 219.24 for AVLTreeNode.leftDown."} (fraction#_134 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) && ((fraction#_134 == exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$N]));
                exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] - fraction#_134];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_130);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_135 := 50;
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 220.24 for AVLTreeNode.left."} (fraction#_135 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) && ((fraction#_135 == exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$N]));
                exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] - fraction#_135];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_130);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 221.26 might not evaluate to true."} Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_136 := 50;
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 222.24 for AVLTreeNode.right."} (fraction#_136 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) && ((fraction#_136 == exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$N]));
                exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] - fraction#_136];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_130);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 223.25 might not evaluate to true."} (!Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_137 := 50;
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 224.24 for AVLTreeNode.root."} (fraction#_137 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) && ((fraction#_137 == exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$N]));
                exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := exhaleMask#_130[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] - fraction#_137];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_130);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 225.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
              } else {
              }
              if (Heap[n#3, AVLTreeNode.parent] == null) {
                assert {:msg "  87.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 226.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == n#3;
              } else {
              }
              Mask := exhaleMask#_130;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_138;
              assume IsGoodInhaleState(inhaleHeap#_138, Heap, Mask);
              assume n#3 != null;
              Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_138[n#3, AVLTreeNode.udParentValid];
              assume wf(Heap, Mask);
              assume inhaleHeap#_138[n#3, AVLTreeNode.udParentValid] == Heap;
              Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_138[n#3, AVLTreeNode.udParentValid]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_138, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[n#3, AVLTreeNode.udParentValid] := Heap;
              assume wf(Heap, Mask);
            }
          } else {
            // if
            assert {:msg "  90.11: Receiver might be null."} true ==> (n#3 != null);
            assert {:msg "  90.11: Location might not be readable."} true ==> CanRead(Mask, n#3, AVLTreeNode.right);
            if (Heap[n#3, AVLTreeNode.right] == null) {
              // assigment to end
              end#5 := true;
              // fold
              assert {:msg "  92.8: The target of the fold statement might be null."} n#3 != null;
              // begin exhale (fold)
              exhaleMask#_139 := Mask;
              fraction#_140 := 100;
              assert {:msg "  92.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 172.6 for AVLTreeNode.key."} (fraction#_140 <= exhaleMask#_139[n#3, AVLTreeNode.key][perm$R]) && ((fraction#_140 == exhaleMask#_139[n#3, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_139[n#3, AVLTreeNode.key][perm$N]));
              exhaleMask#_139[n#3, AVLTreeNode.key] := exhaleMask#_139[n#3, AVLTreeNode.key][perm$R := exhaleMask#_139[n#3, AVLTreeNode.key][perm$R] - fraction#_140];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_139);
              fraction#_141 := 30;
              assert {:msg "  92.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 173.6 for AVLTreeNode.root."} (fraction#_141 <= exhaleMask#_139[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_141 == exhaleMask#_139[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_139[n#3, AVLTreeNode.root][perm$N]));
              exhaleMask#_139[n#3, AVLTreeNode.root] := exhaleMask#_139[n#3, AVLTreeNode.root][perm$R := exhaleMask#_139[n#3, AVLTreeNode.root][perm$R] - fraction#_141];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_139);
              fraction#_142 := 75;
              assert {:msg "  92.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 174.6 for AVLTreeNode.left."} (fraction#_142 <= exhaleMask#_139[n#3, AVLTreeNode.left][perm$R]) && ((fraction#_142 == exhaleMask#_139[n#3, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_139[n#3, AVLTreeNode.left][perm$N]));
              exhaleMask#_139[n#3, AVLTreeNode.left] := exhaleMask#_139[n#3, AVLTreeNode.left][perm$R := exhaleMask#_139[n#3, AVLTreeNode.left][perm$R] - fraction#_142];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_139);
              fraction#_143 := 75;
              assert {:msg "  92.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 175.6 for AVLTreeNode.right."} (fraction#_143 <= exhaleMask#_139[n#3, AVLTreeNode.right][perm$R]) && ((fraction#_143 == exhaleMask#_139[n#3, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_139[n#3, AVLTreeNode.right][perm$N]));
              exhaleMask#_139[n#3, AVLTreeNode.right] := exhaleMask#_139[n#3, AVLTreeNode.right][perm$R := exhaleMask#_139[n#3, AVLTreeNode.right][perm$R] - fraction#_143];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_139);
              fraction#_144 := 100;
              assert {:msg "  92.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 176.6 for AVLTreeNode.leftDown."} (fraction#_144 <= exhaleMask#_139[n#3, AVLTreeNode.leftDown][perm$R]) && ((fraction#_144 == exhaleMask#_139[n#3, AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_139[n#3, AVLTreeNode.leftDown][perm$N]));
              exhaleMask#_139[n#3, AVLTreeNode.leftDown] := exhaleMask#_139[n#3, AVLTreeNode.leftDown][perm$R := exhaleMask#_139[n#3, AVLTreeNode.leftDown][perm$R] - fraction#_144];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_139);
              assert {:msg "  92.8: Fold might fail because the definition of AVLTreeNode.validRest does not hold. The expression at 177.7 might not evaluate to true."} (!(Heap[n#3, AVLTreeNode.right] == Heap[n#3, AVLTreeNode.left])) || (Heap[n#3, AVLTreeNode.right] == null);
              Mask := exhaleMask#_139;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_145;
              assume IsGoodInhaleState(inhaleHeap#_145, Heap, Mask);
              assume n#3 != null;
              Heap[n#3, AVLTreeNode.validRest] := inhaleHeap#_145[n#3, AVLTreeNode.validRest];
              assume wf(Heap, Mask);
              assume inhaleHeap#_145[n#3, AVLTreeNode.validRest] == Heap;
              Mask[n#3, AVLTreeNode.validRest] := Mask[n#3, AVLTreeNode.validRest][perm$R := Mask[n#3, AVLTreeNode.validRest][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_145[n#3, AVLTreeNode.validRest]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_145, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[n#3, AVLTreeNode.validRest] := Heap;
              assume wf(Heap, Mask);
              // fold
              assert {:msg "  93.8: The target of the fold statement might be null."} n#3 != null;
              // begin exhale (fold)
              exhaleMask#_146 := Mask;
              fraction#_147 := 100;
              assert {:msg "  93.8: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 165.6 for AVLTreeNode.validRest."} (fraction#_147 <= exhaleMask#_146[n#3, AVLTreeNode.validRest][perm$R]) && ((fraction#_147 == exhaleMask#_146[n#3, AVLTreeNode.validRest][perm$R]) ==> (0 <= exhaleMask#_146[n#3, AVLTreeNode.validRest][perm$N]));
              exhaleMask#_146[n#3, AVLTreeNode.validRest] := exhaleMask#_146[n#3, AVLTreeNode.validRest][perm$R := exhaleMask#_146[n#3, AVLTreeNode.validRest][perm$R] - fraction#_147];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_146);
              fraction#_148 := 100;
              assert {:msg "  93.8: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 166.6 for AVLTreeNode.leftValid."} (fraction#_148 <= exhaleMask#_146[n#3, AVLTreeNode.leftValid][perm$R]) && ((fraction#_148 == exhaleMask#_146[n#3, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_146[n#3, AVLTreeNode.leftValid][perm$N]));
              exhaleMask#_146[n#3, AVLTreeNode.leftValid] := exhaleMask#_146[n#3, AVLTreeNode.leftValid][perm$R := exhaleMask#_146[n#3, AVLTreeNode.leftValid][perm$R] - fraction#_148];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_146);
              fraction#_149 := 100;
              assert {:msg "  93.8: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 167.6 for AVLTreeNode.rightValid."} (fraction#_149 <= exhaleMask#_146[n#3, AVLTreeNode.rightValid][perm$R]) && ((fraction#_149 == exhaleMask#_146[n#3, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_146[n#3, AVLTreeNode.rightValid][perm$N]));
              exhaleMask#_146[n#3, AVLTreeNode.rightValid] := exhaleMask#_146[n#3, AVLTreeNode.rightValid][perm$R := exhaleMask#_146[n#3, AVLTreeNode.rightValid][perm$R] - fraction#_149];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_146);
              Mask := exhaleMask#_146;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_150;
              assume IsGoodInhaleState(inhaleHeap#_150, Heap, Mask);
              assume n#3 != null;
              Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_150[n#3, AVLTreeNode.valid];
              assume wf(Heap, Mask);
              assume inhaleHeap#_150[n#3, AVLTreeNode.valid] == Heap;
              Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_150[n#3, AVLTreeNode.valid]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_150, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[n#3, AVLTreeNode.valid] := Heap;
              assume wf(Heap, Mask);
            } else {
              // local var p
              // assigment to p
              p#9 := n#3;
              // unfold
              assert {:msg "  96.8: The target of the fold statement might be null."} p#9 != null;
              // begin exhale (unfold)
              exhaleMask#_151 := Mask;
              fraction#_152 := 100;
              assert {:msg "  96.8: unfold might fail because the predicate AVLTreeNode.rightValid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.rightValid."} (fraction#_152 <= exhaleMask#_151[p#9, AVLTreeNode.rightValid][perm$R]) && ((fraction#_152 == exhaleMask#_151[p#9, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_151[p#9, AVLTreeNode.rightValid][perm$N]));
              exhaleMask#_151[p#9, AVLTreeNode.rightValid] := exhaleMask#_151[p#9, AVLTreeNode.rightValid][perm$R := exhaleMask#_151[p#9, AVLTreeNode.rightValid][perm$R] - fraction#_152];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_151);
              Mask := exhaleMask#_151;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (unfold)
              inhaleHeap#_153 := Heap[p#9, AVLTreeNode.rightValid];
              assume IsGoodInhaleState(inhaleHeap#_153, Heap, Mask);
              assume p#9 != null;
              Heap[p#9, AVLTreeNode.right] := inhaleHeap#_153[p#9, AVLTreeNode.right];
              assume wf(Heap, Mask);
              assume (Heap[p#9, AVLTreeNode.right] == null) || (dtype(Heap[p#9, AVLTreeNode.right]) == AVLTreeNode#t);
              Mask[p#9, AVLTreeNode.right] := Mask[p#9, AVLTreeNode.right][perm$R := Mask[p#9, AVLTreeNode.right][perm$R] + 25];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_153[p#9, AVLTreeNode.right]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_153, Mask);
              assume p#9 != null;
              Heap[p#9, AVLTreeNode.root] := inhaleHeap#_153[p#9, AVLTreeNode.root];
              assume wf(Heap, Mask);
              assume (Heap[p#9, AVLTreeNode.root] == null) || (dtype(Heap[p#9, AVLTreeNode.root]) == AVLTreeNode#t);
              Mask[p#9, AVLTreeNode.root] := Mask[p#9, AVLTreeNode.root][perm$R := Mask[p#9, AVLTreeNode.root][perm$R] + 10];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_153[p#9, AVLTreeNode.root]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_153, Mask);
              if (!(Heap[p#9, AVLTreeNode.right] == null)) {
                assume Heap[p#9, AVLTreeNode.right] != null;
                Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.valid] := inhaleHeap#_153[Heap[p#9, AVLTreeNode.right], AVLTreeNode.valid];
                assume wf(Heap, Mask);
                assume inhaleHeap#_153[Heap[p#9, AVLTreeNode.right], AVLTreeNode.valid] == Heap;
                Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + 100];
                assume IsGoodMask(Mask);
                assume IsGoodState(inhaleHeap#_153[Heap[p#9, AVLTreeNode.right], AVLTreeNode.valid]);
                assume wf(Heap, Mask);
                assume wf(inhaleHeap#_153, Mask);
              } else {
              }
              if (!(Heap[p#9, AVLTreeNode.right] == null)) {
                assume Heap[p#9, AVLTreeNode.right] != null;
                Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent] := inhaleHeap#_153[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent];
                assume wf(Heap, Mask);
                assume (Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent]) == AVLTreeNode#t);
                Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent] := Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent][perm$R := Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent][perm$R] + 100];
                assume IsGoodMask(Mask);
                assume IsGoodState(inhaleHeap#_153[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent]);
                assume wf(Heap, Mask);
                assume wf(inhaleHeap#_153, Mask);
              } else {
              }
              if (!(Heap[p#9, AVLTreeNode.right] == null)) {
                assume Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent] == p#9;
              } else {
              }
              if (!(Heap[p#9, AVLTreeNode.right] == null)) {
                assume Heap[p#9, AVLTreeNode.right] != null;
                Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root] := inhaleHeap#_153[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root];
                assume wf(Heap, Mask);
                assume (Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root] == null) || (dtype(Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root]) == AVLTreeNode#t);
                Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root] := Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root][perm$R := Mask[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root][perm$R] + 50];
                assume IsGoodMask(Mask);
                assume IsGoodState(inhaleHeap#_153[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root]);
                assume wf(Heap, Mask);
                assume wf(inhaleHeap#_153, Mask);
              } else {
              }
              if (!(Heap[p#9, AVLTreeNode.right] == null)) {
                assume Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.root] == Heap[p#9, AVLTreeNode.root];
              } else {
              }
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              // assigment to n
              assert {:msg "  97.13: Receiver might be null."} true ==> (p#9 != null);
              assert {:msg "  97.13: Location might not be readable."} true ==> CanRead(Mask, p#9, AVLTreeNode.right);
              n#3 := Heap[p#9, AVLTreeNode.right];
              // update field leftDown
              assert {:msg "  98.8: Location might not be writable"} CanWrite(Mask, p#9, AVLTreeNode.leftDown);
              Heap[p#9, AVLTreeNode.leftDown] := false;
              assume wf(Heap, Mask);
              // fold
              assert {:msg "  99.8: The target of the fold statement might be null."} p#9 != null;
              // begin exhale (fold)
              exhaleMask#_154 := Mask;
              fraction#_155 := 25;
              assert {:msg "  99.8: Fold might fail because the definition of AVLTreeNode.rightOpen does not hold. Insufficient fraction at 208.6 for AVLTreeNode.right."} (fraction#_155 <= exhaleMask#_154[p#9, AVLTreeNode.right][perm$R]) && ((fraction#_155 == exhaleMask#_154[p#9, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_154[p#9, AVLTreeNode.right][perm$N]));
              exhaleMask#_154[p#9, AVLTreeNode.right] := exhaleMask#_154[p#9, AVLTreeNode.right][perm$R := exhaleMask#_154[p#9, AVLTreeNode.right][perm$R] - fraction#_155];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_154);
              fraction#_156 := 10;
              assert {:msg "  99.8: Fold might fail because the definition of AVLTreeNode.rightOpen does not hold. Insufficient fraction at 209.6 for AVLTreeNode.root."} (fraction#_156 <= exhaleMask#_154[p#9, AVLTreeNode.root][perm$R]) && ((fraction#_156 == exhaleMask#_154[p#9, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_154[p#9, AVLTreeNode.root][perm$N]));
              exhaleMask#_154[p#9, AVLTreeNode.root] := exhaleMask#_154[p#9, AVLTreeNode.root][perm$R := exhaleMask#_154[p#9, AVLTreeNode.root][perm$R] - fraction#_156];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_154);
              if (!(Heap[p#9, AVLTreeNode.right] == null)) {
                fraction#_157 := 50;
                assert {:msg "  99.8: Fold might fail because the definition of AVLTreeNode.rightOpen does not hold. Insufficient fraction at 210.23 for AVLTreeNode.parent."} (fraction#_157 <= exhaleMask#_154[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent][perm$R]) && ((fraction#_157 == exhaleMask#_154[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_154[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent][perm$N]));
                exhaleMask#_154[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent] := exhaleMask#_154[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent][perm$R := exhaleMask#_154[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent][perm$R] - fraction#_157];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_154);
              } else {
              }
              if (!(Heap[p#9, AVLTreeNode.right] == null)) {
                assert {:msg "  99.8: Fold might fail because the definition of AVLTreeNode.rightOpen does not hold. The expression at 211.23 might not evaluate to true."} Heap[Heap[p#9, AVLTreeNode.right], AVLTreeNode.parent] == p#9;
              } else {
              }
              Mask := exhaleMask#_154;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_158;
              assume IsGoodInhaleState(inhaleHeap#_158, Heap, Mask);
              assume p#9 != null;
              Heap[p#9, AVLTreeNode.rightOpen] := inhaleHeap#_158[p#9, AVLTreeNode.rightOpen];
              assume wf(Heap, Mask);
              assume inhaleHeap#_158[p#9, AVLTreeNode.rightOpen] == Heap;
              Mask[p#9, AVLTreeNode.rightOpen] := Mask[p#9, AVLTreeNode.rightOpen][perm$R := Mask[p#9, AVLTreeNode.rightOpen][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_158[p#9, AVLTreeNode.rightOpen]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_158, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[p#9, AVLTreeNode.rightOpen] := Heap;
              assume wf(Heap, Mask);
              // fold
              assert {:msg "  100.8: The target of the fold statement might be null."} p#9 != null;
              // begin exhale (fold)
              exhaleMask#_159 := Mask;
              fraction#_160 := 100;
              assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 230.6 for AVLTreeNode.key."} (fraction#_160 <= exhaleMask#_159[p#9, AVLTreeNode.key][perm$R]) && ((fraction#_160 == exhaleMask#_159[p#9, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.key][perm$N]));
              exhaleMask#_159[p#9, AVLTreeNode.key] := exhaleMask#_159[p#9, AVLTreeNode.key][perm$R := exhaleMask#_159[p#9, AVLTreeNode.key][perm$R] - fraction#_160];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_159);
              fraction#_161 := 50;
              assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 231.6 for AVLTreeNode.leftDown."} (fraction#_161 <= exhaleMask#_159[p#9, AVLTreeNode.leftDown][perm$R]) && ((fraction#_161 == exhaleMask#_159[p#9, AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.leftDown][perm$N]));
              exhaleMask#_159[p#9, AVLTreeNode.leftDown] := exhaleMask#_159[p#9, AVLTreeNode.leftDown][perm$R := exhaleMask#_159[p#9, AVLTreeNode.leftDown][perm$R] - fraction#_161];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_159);
              fraction#_162 := 25;
              assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 232.6 for AVLTreeNode.left."} (fraction#_162 <= exhaleMask#_159[p#9, AVLTreeNode.left][perm$R]) && ((fraction#_162 == exhaleMask#_159[p#9, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.left][perm$N]));
              exhaleMask#_159[p#9, AVLTreeNode.left] := exhaleMask#_159[p#9, AVLTreeNode.left][perm$R := exhaleMask#_159[p#9, AVLTreeNode.left][perm$R] - fraction#_162];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_159);
              fraction#_163 := 25;
              assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 233.6 for AVLTreeNode.right."} (fraction#_163 <= exhaleMask#_159[p#9, AVLTreeNode.right][perm$R]) && ((fraction#_163 == exhaleMask#_159[p#9, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.right][perm$N]));
              exhaleMask#_159[p#9, AVLTreeNode.right] := exhaleMask#_159[p#9, AVLTreeNode.right][perm$R := exhaleMask#_159[p#9, AVLTreeNode.right][perm$R] - fraction#_163];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_159);
              fraction#_164 := 20;
              assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 235.6 for AVLTreeNode.root."} (fraction#_164 <= exhaleMask#_159[p#9, AVLTreeNode.root][perm$R]) && ((fraction#_164 == exhaleMask#_159[p#9, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.root][perm$N]));
              exhaleMask#_159[p#9, AVLTreeNode.root] := exhaleMask#_159[p#9, AVLTreeNode.root][perm$R := exhaleMask#_159[p#9, AVLTreeNode.root][perm$R] - fraction#_164];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_159);
              if (Heap[p#9, AVLTreeNode.leftDown]) {
                fraction#_165 := 100;
                assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 236.21 for AVLTreeNode.rightValid."} (fraction#_165 <= exhaleMask#_159[p#9, AVLTreeNode.rightValid][perm$R]) && ((fraction#_165 == exhaleMask#_159[p#9, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.rightValid][perm$N]));
                exhaleMask#_159[p#9, AVLTreeNode.rightValid] := exhaleMask#_159[p#9, AVLTreeNode.rightValid][perm$R := exhaleMask#_159[p#9, AVLTreeNode.rightValid][perm$R] - fraction#_165];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_159);
              } else {
              }
              if (Heap[p#9, AVLTreeNode.leftDown]) {
                fraction#_166 := 100;
                assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 237.21 for AVLTreeNode.leftOpen."} (fraction#_166 <= exhaleMask#_159[p#9, AVLTreeNode.leftOpen][perm$R]) && ((fraction#_166 == exhaleMask#_159[p#9, AVLTreeNode.leftOpen][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.leftOpen][perm$N]));
                exhaleMask#_159[p#9, AVLTreeNode.leftOpen] := exhaleMask#_159[p#9, AVLTreeNode.leftOpen][perm$R := exhaleMask#_159[p#9, AVLTreeNode.leftOpen][perm$R] - fraction#_166];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_159);
              } else {
              }
              if (!Heap[p#9, AVLTreeNode.leftDown]) {
                fraction#_167 := 100;
                assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 238.21 for AVLTreeNode.leftValid."} (fraction#_167 <= exhaleMask#_159[p#9, AVLTreeNode.leftValid][perm$R]) && ((fraction#_167 == exhaleMask#_159[p#9, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.leftValid][perm$N]));
                exhaleMask#_159[p#9, AVLTreeNode.leftValid] := exhaleMask#_159[p#9, AVLTreeNode.leftValid][perm$R := exhaleMask#_159[p#9, AVLTreeNode.leftValid][perm$R] - fraction#_167];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_159);
              } else {
              }
              if (!Heap[p#9, AVLTreeNode.leftDown]) {
                fraction#_168 := 100;
                assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 239.21 for AVLTreeNode.rightOpen."} (fraction#_168 <= exhaleMask#_159[p#9, AVLTreeNode.rightOpen][perm$R]) && ((fraction#_168 == exhaleMask#_159[p#9, AVLTreeNode.rightOpen][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.rightOpen][perm$N]));
                exhaleMask#_159[p#9, AVLTreeNode.rightOpen] := exhaleMask#_159[p#9, AVLTreeNode.rightOpen][perm$R := exhaleMask#_159[p#9, AVLTreeNode.rightOpen][perm$R] - fraction#_168];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_159);
              } else {
              }
              fraction#_169 := 100;
              assert {:msg "  100.8: Fold might fail because the definition of AVLTreeNode.udValid does not hold. Insufficient fraction at 241.6 for AVLTreeNode.udParentValid."} (fraction#_169 <= exhaleMask#_159[p#9, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_169 == exhaleMask#_159[p#9, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_159[p#9, AVLTreeNode.udParentValid][perm$N]));
              exhaleMask#_159[p#9, AVLTreeNode.udParentValid] := exhaleMask#_159[p#9, AVLTreeNode.udParentValid][perm$R := exhaleMask#_159[p#9, AVLTreeNode.udParentValid][perm$R] - fraction#_169];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_159);
              Mask := exhaleMask#_159;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_170;
              assume IsGoodInhaleState(inhaleHeap#_170, Heap, Mask);
              assume p#9 != null;
              Heap[p#9, AVLTreeNode.udValid] := inhaleHeap#_170[p#9, AVLTreeNode.udValid];
              assume wf(Heap, Mask);
              assume inhaleHeap#_170[p#9, AVLTreeNode.udValid] == Heap;
              Mask[p#9, AVLTreeNode.udValid] := Mask[p#9, AVLTreeNode.udValid][perm$R := Mask[p#9, AVLTreeNode.udValid][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_170[p#9, AVLTreeNode.udValid]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_170, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[p#9, AVLTreeNode.udValid] := Heap;
              assume wf(Heap, Mask);
              // fold
              assert {:msg "  101.8: The target of the fold statement might be null."} n#3 != null;
              // begin exhale (fold)
              exhaleMask#_171 := Mask;
              fraction#_172 := 50;
              assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 216.6 for AVLTreeNode.parent."} (fraction#_172 <= exhaleMask#_171[n#3, AVLTreeNode.parent][perm$R]) && ((fraction#_172 == exhaleMask#_171[n#3, AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_171[n#3, AVLTreeNode.parent][perm$N]));
              exhaleMask#_171[n#3, AVLTreeNode.parent] := exhaleMask#_171[n#3, AVLTreeNode.parent][perm$R := exhaleMask#_171[n#3, AVLTreeNode.parent][perm$R] - fraction#_172];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_171);
              fraction#_173 := 10;
              assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 217.6 for AVLTreeNode.root."} (fraction#_173 <= exhaleMask#_171[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_173 == exhaleMask#_171[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_171[n#3, AVLTreeNode.root][perm$N]));
              exhaleMask#_171[n#3, AVLTreeNode.root] := exhaleMask#_171[n#3, AVLTreeNode.root][perm$R := exhaleMask#_171[n#3, AVLTreeNode.root][perm$R] - fraction#_173];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_171);
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_174 := 100;
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 218.24 for AVLTreeNode.udValid."} (fraction#_174 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) && ((fraction#_174 == exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) ==> (0 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$N]));
                exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] - fraction#_174];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_171);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_175 := 50;
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 219.24 for AVLTreeNode.leftDown."} (fraction#_175 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) && ((fraction#_175 == exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$N]));
                exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] - fraction#_175];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_171);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_176 := 50;
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 220.24 for AVLTreeNode.left."} (fraction#_176 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) && ((fraction#_176 == exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$N]));
                exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] - fraction#_176];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_171);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 221.26 might not evaluate to true."} Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_177 := 50;
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 222.24 for AVLTreeNode.right."} (fraction#_177 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) && ((fraction#_177 == exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$N]));
                exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] - fraction#_177];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_171);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 223.25 might not evaluate to true."} (!Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                fraction#_178 := 50;
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 224.24 for AVLTreeNode.root."} (fraction#_178 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) && ((fraction#_178 == exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$N]));
                exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := exhaleMask#_171[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] - fraction#_178];
                assume IsGoodMask(Mask);
                assume wf(Heap, Mask);
                assume wf(Heap, exhaleMask#_171);
              } else {
              }
              if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 225.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
              } else {
              }
              if (Heap[n#3, AVLTreeNode.parent] == null) {
                assert {:msg "  101.8: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 226.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == n#3;
              } else {
              }
              Mask := exhaleMask#_171;
              assume wf(Heap, Mask);
              // end exhale
              // inhale (fold)
              havoc inhaleHeap#_179;
              assume IsGoodInhaleState(inhaleHeap#_179, Heap, Mask);
              assume n#3 != null;
              Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_179[n#3, AVLTreeNode.udParentValid];
              assume wf(Heap, Mask);
              assume inhaleHeap#_179[n#3, AVLTreeNode.udParentValid] == Heap;
              Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_179[n#3, AVLTreeNode.udParentValid]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_179, Mask);
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              // end inhale
              Heap[n#3, AVLTreeNode.udParentValid] := Heap;
              assume wf(Heap, Mask);
            }
          }
        }
        // begin exhale (loop invariant, maintained)
        exhaleMask#_180 := Mask;
        fraction#_181 := 100;
        assert {:msg "  56.15: The loop invariant at 56.15 might not be preserved by the loop. Insufficient fraction at 56.15 for AVLTree.root."} (fraction#_181 <= exhaleMask#_180[this, AVLTree.root][perm$R]) && ((fraction#_181 == exhaleMask#_180[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_180[this, AVLTree.root][perm$N]));
        exhaleMask#_180[this, AVLTree.root] := exhaleMask#_180[this, AVLTree.root][perm$R := exhaleMask#_180[this, AVLTree.root][perm$R] - fraction#_181];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_180);
        fraction#_182 := 50;
        assert {:msg "  57.15: The loop invariant at 57.15 might not be preserved by the loop. Insufficient fraction at 57.15 for AVLTreeNode.parent."} (fraction#_182 <= exhaleMask#_180[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) && ((fraction#_182 == exhaleMask#_180[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_180[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$N]));
        exhaleMask#_180[Heap[this, AVLTree.root], AVLTreeNode.parent] := exhaleMask#_180[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := exhaleMask#_180[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] - fraction#_182];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_180);
        assert {:msg "  58.15: The loop invariant at 58.15 might not be preserved by the loop. The expression at 58.15 might not evaluate to true."} !(n#3 == null);
        fraction#_183 := 100;
        assert {:msg "  59.15: The loop invariant at 59.15 might not be preserved by the loop. Insufficient fraction at 59.15 for AVLTreeNode.valid."} (fraction#_183 <= exhaleMask#_180[n#3, AVLTreeNode.valid][perm$R]) && ((fraction#_183 == exhaleMask#_180[n#3, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_180[n#3, AVLTreeNode.valid][perm$N]));
        exhaleMask#_180[n#3, AVLTreeNode.valid] := exhaleMask#_180[n#3, AVLTreeNode.valid][perm$R := exhaleMask#_180[n#3, AVLTreeNode.valid][perm$R] - fraction#_183];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_180);
        fraction#_184 := 40;
        assert {:msg "  60.15: The loop invariant at 60.15 might not be preserved by the loop. Insufficient fraction at 60.15 for AVLTreeNode.root."} (fraction#_184 <= exhaleMask#_180[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_184 == exhaleMask#_180[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_180[n#3, AVLTreeNode.root][perm$N]));
        exhaleMask#_180[n#3, AVLTreeNode.root] := exhaleMask#_180[n#3, AVLTreeNode.root][perm$R := exhaleMask#_180[n#3, AVLTreeNode.root][perm$R] - fraction#_184];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_180);
        fraction#_185 := 100;
        assert {:msg "  61.15: The loop invariant at 61.15 might not be preserved by the loop. Insufficient fraction at 61.15 for AVLTreeNode.udParentValid."} (fraction#_185 <= exhaleMask#_180[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_185 == exhaleMask#_180[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_180[n#3, AVLTreeNode.udParentValid][perm$N]));
        exhaleMask#_180[n#3, AVLTreeNode.udParentValid] := exhaleMask#_180[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_180[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_185];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_180);
        assert {:msg "  62.15: The loop invariant at 62.15 might not be preserved by the loop. The expression at 62.15 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
        assert {:msg "  63.15: The loop invariant at 63.15 might not be preserved by the loop. The expression at 63.15 might not evaluate to true."} !(Heap[this, AVLTree.root] == null);
        Mask := exhaleMask#_180;
        assume wf(Heap, Mask);
        // end exhale
        // check lockchange after loop iteration
        assert {:msg "  55.4: The loop might lock/unlock more than the lockchange clause allows."} (forall lk#_186: ref :: {Heap[lk#_186, held]} {Heap[lk#_186, rdheld]} (((0 < Heap[lk#_186, held]) == (0 < old(Heap)[lk#_186, held])) && (Heap[lk#_186, rdheld] == old(Heap)[lk#_186, rdheld])) || false);
        assert {:msg "  55.4: Loop body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
        assume false;
      } else {
        // assume lockchange after the loop
        assume (forall lk#_189: ref :: {Heap[lk#_189, held]} {Heap[lk#_189, rdheld]} (((0 < Heap[lk#_189, held]) == (0 < old(Heap)[lk#_189, held])) && (Heap[lk#_189, rdheld] == old(Heap)[lk#_189, rdheld])) || false);
        // inhale (loop invariant, after loop)
        havoc inhaleHeap#_190;
        assume IsGoodInhaleState(inhaleHeap#_190, Heap, Mask);
        assume this != null;
        Heap[this, AVLTree.root] := inhaleHeap#_190[this, AVLTree.root];
        assume wf(Heap, Mask);
        assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
        Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_190[this, AVLTree.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_190, Mask);
        assume Heap[this, AVLTree.root] != null;
        Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_190[Heap[this, AVLTree.root], AVLTreeNode.parent];
        assume wf(Heap, Mask);
        assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
        Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 50];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_190[Heap[this, AVLTree.root], AVLTreeNode.parent]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_190, Mask);
        assume !(n#3 == null);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_190[n#3, AVLTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_190[n#3, AVLTreeNode.valid] == Heap;
        Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_190[n#3, AVLTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_190, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.root] := inhaleHeap#_190[n#3, AVLTreeNode.root];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 40];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_190[n#3, AVLTreeNode.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_190, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_190[n#3, AVLTreeNode.udParentValid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_190[n#3, AVLTreeNode.udParentValid] == Heap;
        Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_190[n#3, AVLTreeNode.udParentValid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_190, Mask);
        assume Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
        assume !(Heap[this, AVLTree.root] == null);
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        assume !(!end#5);
      }
    }
    // assigment to end
    end#5 := false;
    // while
    whileHeap#_191 := Heap;
    whileMask#_192 := Mask;
    whileCredits#_193 := Credits;
    // begin exhale (loop invariant, initially)
    exhaleMask#_197 := Mask;
    fraction#_198 := 100;
    assert {:msg "  109.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 109.15 for AVLTree.root."} (fraction#_198 <= exhaleMask#_197[this, AVLTree.root][perm$R]) && ((fraction#_198 == exhaleMask#_197[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_197[this, AVLTree.root][perm$N]));
    exhaleMask#_197[this, AVLTree.root] := exhaleMask#_197[this, AVLTree.root][perm$R := exhaleMask#_197[this, AVLTree.root][perm$R] - fraction#_198];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_197);
    fraction#_199 := 50;
    assert {:msg "  110.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 110.15 for AVLTreeNode.parent."} (fraction#_199 <= exhaleMask#_197[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) && ((fraction#_199 == exhaleMask#_197[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_197[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$N]));
    exhaleMask#_197[Heap[this, AVLTree.root], AVLTreeNode.parent] := exhaleMask#_197[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := exhaleMask#_197[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] - fraction#_199];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_197);
    assert {:msg "  111.15: The loop invariant might not hold on entry to the loop. The expression at 111.15 might not evaluate to true."} !(n#3 == null);
    fraction#_200 := 100;
    assert {:msg "  112.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 112.15 for AVLTreeNode.valid."} (fraction#_200 <= exhaleMask#_197[n#3, AVLTreeNode.valid][perm$R]) && ((fraction#_200 == exhaleMask#_197[n#3, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_197[n#3, AVLTreeNode.valid][perm$N]));
    exhaleMask#_197[n#3, AVLTreeNode.valid] := exhaleMask#_197[n#3, AVLTreeNode.valid][perm$R := exhaleMask#_197[n#3, AVLTreeNode.valid][perm$R] - fraction#_200];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_197);
    fraction#_201 := 100;
    assert {:msg "  113.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 113.15 for AVLTreeNode.udParentValid."} (fraction#_201 <= exhaleMask#_197[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_201 == exhaleMask#_197[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_197[n#3, AVLTreeNode.udParentValid][perm$N]));
    exhaleMask#_197[n#3, AVLTreeNode.udParentValid] := exhaleMask#_197[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_197[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_201];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_197);
    fraction#_202 := 40;
    assert {:msg "  114.15: The loop invariant might not hold on entry to the loop. Insufficient fraction at 114.15 for AVLTreeNode.root."} (fraction#_202 <= exhaleMask#_197[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_202 == exhaleMask#_197[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_197[n#3, AVLTreeNode.root][perm$N]));
    exhaleMask#_197[n#3, AVLTreeNode.root] := exhaleMask#_197[n#3, AVLTreeNode.root][perm$R := exhaleMask#_197[n#3, AVLTreeNode.root][perm$R] - fraction#_202];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_197);
    assert {:msg "  115.15: The loop invariant might not hold on entry to the loop. The expression at 115.15 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
    assert {:msg "  116.15: The loop invariant might not hold on entry to the loop. The expression at 116.15 might not evaluate to true."} !(Heap[this, AVLTree.root] == null);
    if (end#5) {
      assert {:msg "  117.15: The loop invariant might not hold on entry to the loop. The expression at 117.21 might not evaluate to true."} Heap[n#3, AVLTreeNode.parent] == null;
    } else {
    }
    Mask := exhaleMask#_197;
    assume wf(Heap, Mask);
    // end exhale
    assert {:msg "  108.4: Loop invariant must consume all debt on entry to the loop."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
    // check lockchange on entry to the loop
    assert {:msg "  108.4: Method execution before loop might lock/unlock more than allowed by lockchange clause of loop."} (forall lk#_203: ref :: {Heap[lk#_203, held]} {Heap[lk#_203, rdheld]} (((0 < Heap[lk#_203, held]) == (0 < old(Heap)[lk#_203, held])) && (Heap[lk#_203, rdheld] == old(Heap)[lk#_203, rdheld])) || false);
    end#19 := end#5;
    n#20 := n#3;
    havoc end#5;
    havoc n#3;
    if (*) {
      // check loop invariant definedness
      havoc Heap;
      Mask := ZeroMask;
      Credits := ZeroCredits;
      // inhale (loop invariant definedness)
      havoc inhaleHeap#_204;
      assume IsGoodInhaleState(inhaleHeap#_204, Heap, Mask);
      assert {:msg "  109.24: Fraction might be negative."} 0 <= 100;
      assert {:msg "  109.24: Fraction might exceed 100."} 100 <= 100;
      assume this != null;
      Heap[this, AVLTree.root] := inhaleHeap#_204[this, AVLTree.root];
      assume wf(Heap, Mask);
      assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
      Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_204[this, AVLTree.root]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_204, Mask);
      assert {:msg "  110.19: Receiver might be null."} true ==> (this != null);
      assert {:msg "  110.19: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
      assert {:msg "  110.31: Fraction might be negative."} 0 <= 50;
      assert {:msg "  110.31: Fraction might exceed 100."} 50 <= 100;
      assume Heap[this, AVLTree.root] != null;
      Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_204[Heap[this, AVLTree.root], AVLTreeNode.parent];
      assume wf(Heap, Mask);
      assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
      Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 50];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_204[Heap[this, AVLTree.root], AVLTreeNode.parent]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_204, Mask);
      assume !(n#3 == null);
      assume n#3 != null;
      Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_204[n#3, AVLTreeNode.valid];
      assume wf(Heap, Mask);
      assume inhaleHeap#_204[n#3, AVLTreeNode.valid] == Heap;
      Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_204[n#3, AVLTreeNode.valid]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_204, Mask);
      assume n#3 != null;
      Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_204[n#3, AVLTreeNode.udParentValid];
      assume wf(Heap, Mask);
      assume inhaleHeap#_204[n#3, AVLTreeNode.udParentValid] == Heap;
      Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_204[n#3, AVLTreeNode.udParentValid]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_204, Mask);
      assert {:msg "  114.26: Fraction might be negative."} 0 <= 40;
      assert {:msg "  114.26: Fraction might exceed 100."} 40 <= 100;
      assume n#3 != null;
      Heap[n#3, AVLTreeNode.root] := inhaleHeap#_204[n#3, AVLTreeNode.root];
      assume wf(Heap, Mask);
      assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
      Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 40];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_204[n#3, AVLTreeNode.root]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_204, Mask);
      // unfolding
      assert {:msg "  115.25: Receiver might be null."} true ==> (n#3 != null);
      Heap#_208 := Heap;
      Mask#_209 := Mask;
      Credits#_210 := Credits;
      // begin exhale (unfolding)
      exhaleMask#_211 := Mask#_209;
      fraction#_212 := 100;
      assert {:msg "  115.15: Unfolding might fail. Insufficient fraction at 115.25 for AVLTreeNode.valid."} (fraction#_212 <= exhaleMask#_211[n#3, AVLTreeNode.valid][perm$R]) && ((fraction#_212 == exhaleMask#_211[n#3, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_211[n#3, AVLTreeNode.valid][perm$N]));
      exhaleMask#_211[n#3, AVLTreeNode.valid] := exhaleMask#_211[n#3, AVLTreeNode.valid][perm$R := exhaleMask#_211[n#3, AVLTreeNode.valid][perm$R] - fraction#_212];
      assume IsGoodMask(Mask#_209);
      assume wf(Heap#_208, Mask#_209);
      assume wf(Heap#_208, exhaleMask#_211);
      Mask#_209 := exhaleMask#_211;
      assume wf(Heap#_208, Mask#_209);
      // end exhale
      // inhale (unfolding)
      inhaleHeap#_213 := Heap[n#3, AVLTreeNode.valid];
      assume IsGoodInhaleState(inhaleHeap#_213, Heap#_208, Mask#_209);
      assume n#3 != null;
      Heap#_208[n#3, AVLTreeNode.validRest] := inhaleHeap#_213[n#3, AVLTreeNode.validRest];
      assume wf(Heap#_208, Mask#_209);
      assume inhaleHeap#_213[n#3, AVLTreeNode.validRest] == Heap#_208;
      Mask#_209[n#3, AVLTreeNode.validRest] := Mask#_209[n#3, AVLTreeNode.validRest][perm$R := Mask#_209[n#3, AVLTreeNode.validRest][perm$R] + 100];
      assume IsGoodMask(Mask#_209);
      assume IsGoodState(inhaleHeap#_213[n#3, AVLTreeNode.validRest]);
      assume wf(Heap#_208, Mask#_209);
      assume wf(inhaleHeap#_213, Mask#_209);
      assume n#3 != null;
      Heap#_208[n#3, AVLTreeNode.leftValid] := inhaleHeap#_213[n#3, AVLTreeNode.leftValid];
      assume wf(Heap#_208, Mask#_209);
      assume inhaleHeap#_213[n#3, AVLTreeNode.leftValid] == Heap#_208;
      Mask#_209[n#3, AVLTreeNode.leftValid] := Mask#_209[n#3, AVLTreeNode.leftValid][perm$R := Mask#_209[n#3, AVLTreeNode.leftValid][perm$R] + 100];
      assume IsGoodMask(Mask#_209);
      assume IsGoodState(inhaleHeap#_213[n#3, AVLTreeNode.leftValid]);
      assume wf(Heap#_208, Mask#_209);
      assume wf(inhaleHeap#_213, Mask#_209);
      assume n#3 != null;
      Heap#_208[n#3, AVLTreeNode.rightValid] := inhaleHeap#_213[n#3, AVLTreeNode.rightValid];
      assume wf(Heap#_208, Mask#_209);
      assume inhaleHeap#_213[n#3, AVLTreeNode.rightValid] == Heap#_208;
      Mask#_209[n#3, AVLTreeNode.rightValid] := Mask#_209[n#3, AVLTreeNode.rightValid][perm$R := Mask#_209[n#3, AVLTreeNode.rightValid][perm$R] + 100];
      assume IsGoodMask(Mask#_209);
      assume IsGoodState(inhaleHeap#_213[n#3, AVLTreeNode.rightValid]);
      assume wf(Heap#_208, Mask#_209);
      assume wf(inhaleHeap#_213, Mask#_209);
      assume IsGoodMask(Mask#_209);
      assume wf(Heap#_208, Mask#_209);
      // end inhale
      assert {:msg "  115.36: Receiver might be null."} true ==> (n#3 != null);
      assert {:msg "  115.36: Location might not be readable."} true ==> CanRead(Mask#_209, n#3, AVLTreeNode.root);
      assert {:msg "  115.44: Receiver might be null."} true ==> (this != null);
      assert {:msg "  115.44: Location might not be readable."} true ==> CanRead(Mask#_209, this, AVLTree.root);
      assume Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
      assert {:msg "  116.15: Receiver might be null."} true ==> (this != null);
      assert {:msg "  116.15: Location might not be readable."} true ==> CanRead(Mask, this, AVLTree.root);
      assume !(Heap[this, AVLTree.root] == null);
      if (end#5) {
        // unfolding
        assert {:msg "  117.31: Receiver might be null."} true ==> (n#3 != null);
        Heap#_217 := Heap;
        Mask#_218 := Mask;
        Credits#_219 := Credits;
        // begin exhale (unfolding)
        exhaleMask#_220 := Mask#_218;
        fraction#_221 := 100;
        assert {:msg "  117.21: Unfolding might fail. Insufficient fraction at 117.31 for AVLTreeNode.udParentValid."} (fraction#_221 <= exhaleMask#_220[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_221 == exhaleMask#_220[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_220[n#3, AVLTreeNode.udParentValid][perm$N]));
        exhaleMask#_220[n#3, AVLTreeNode.udParentValid] := exhaleMask#_220[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_220[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_221];
        assume IsGoodMask(Mask#_218);
        assume wf(Heap#_217, Mask#_218);
        assume wf(Heap#_217, exhaleMask#_220);
        Mask#_218 := exhaleMask#_220;
        assume wf(Heap#_217, Mask#_218);
        // end exhale
        // inhale (unfolding)
        inhaleHeap#_222 := Heap[n#3, AVLTreeNode.udParentValid];
        assume IsGoodInhaleState(inhaleHeap#_222, Heap#_217, Mask#_218);
        assume n#3 != null;
        Heap#_217[n#3, AVLTreeNode.parent] := inhaleHeap#_222[n#3, AVLTreeNode.parent];
        assume wf(Heap#_217, Mask#_218);
        assume (Heap#_217[n#3, AVLTreeNode.parent] == null) || (dtype(Heap#_217[n#3, AVLTreeNode.parent]) == AVLTreeNode#t);
        Mask#_218[n#3, AVLTreeNode.parent] := Mask#_218[n#3, AVLTreeNode.parent][perm$R := Mask#_218[n#3, AVLTreeNode.parent][perm$R] + 50];
        assume IsGoodMask(Mask#_218);
        assume IsGoodState(inhaleHeap#_222[n#3, AVLTreeNode.parent]);
        assume wf(Heap#_217, Mask#_218);
        assume wf(inhaleHeap#_222, Mask#_218);
        assume n#3 != null;
        Heap#_217[n#3, AVLTreeNode.root] := inhaleHeap#_222[n#3, AVLTreeNode.root];
        assume wf(Heap#_217, Mask#_218);
        assume (Heap#_217[n#3, AVLTreeNode.root] == null) || (dtype(Heap#_217[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
        Mask#_218[n#3, AVLTreeNode.root] := Mask#_218[n#3, AVLTreeNode.root][perm$R := Mask#_218[n#3, AVLTreeNode.root][perm$R] + 10];
        assume IsGoodMask(Mask#_218);
        assume IsGoodState(inhaleHeap#_222[n#3, AVLTreeNode.root]);
        assume wf(Heap#_217, Mask#_218);
        assume wf(inhaleHeap#_222, Mask#_218);
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume Heap#_217[n#3, AVLTreeNode.parent] != null;
          Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.udValid];
          assume wf(Heap#_217, Mask#_218);
          assume inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] == Heap#_217;
          Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] + 100];
          assume IsGoodMask(Mask#_218);
          assume IsGoodState(inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.udValid]);
          assume wf(Heap#_217, Mask#_218);
          assume wf(inhaleHeap#_222, Mask#_218);
        } else {
        }
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume Heap#_217[n#3, AVLTreeNode.parent] != null;
          Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown];
          assume wf(Heap#_217, Mask#_218);
          assume true;
          Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] + 50];
          assume IsGoodMask(Mask#_218);
          assume IsGoodState(inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]);
          assume wf(Heap#_217, Mask#_218);
          assume wf(inhaleHeap#_222, Mask#_218);
        } else {
        }
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume Heap#_217[n#3, AVLTreeNode.parent] != null;
          Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left] := inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left];
          assume wf(Heap#_217, Mask#_218);
          assume (Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left] == null) || (dtype(Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left]) == AVLTreeNode#t);
          Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left] := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] + 50];
          assume IsGoodMask(Mask#_218);
          assume IsGoodState(inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left]);
          assume wf(Heap#_217, Mask#_218);
          assume wf(inhaleHeap#_222, Mask#_218);
        } else {
        }
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
        } else {
        }
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume Heap#_217[n#3, AVLTreeNode.parent] != null;
          Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right] := inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right];
          assume wf(Heap#_217, Mask#_218);
          assume (Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right] == null) || (dtype(Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right]) == AVLTreeNode#t);
          Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right] := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] + 50];
          assume IsGoodMask(Mask#_218);
          assume IsGoodState(inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right]);
          assume wf(Heap#_217, Mask#_218);
          assume wf(inhaleHeap#_222, Mask#_218);
        } else {
        }
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume (!Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
        } else {
        }
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume Heap#_217[n#3, AVLTreeNode.parent] != null;
          Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root] := inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root];
          assume wf(Heap#_217, Mask#_218);
          assume (Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root] == null) || (dtype(Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root]) == AVLTreeNode#t);
          Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root] := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := Mask#_218[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] + 50];
          assume IsGoodMask(Mask#_218);
          assume IsGoodState(inhaleHeap#_222[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root]);
          assume wf(Heap#_217, Mask#_218);
          assume wf(inhaleHeap#_222, Mask#_218);
        } else {
        }
        if (!(Heap#_217[n#3, AVLTreeNode.parent] == null)) {
          assume Heap#_217[n#3, AVLTreeNode.root] == Heap#_217[Heap#_217[n#3, AVLTreeNode.parent], AVLTreeNode.root];
        } else {
        }
        if (Heap#_217[n#3, AVLTreeNode.parent] == null) {
          assume Heap#_217[n#3, AVLTreeNode.root] == n#3;
        } else {
        }
        assume IsGoodMask(Mask#_218);
        assume wf(Heap#_217, Mask#_218);
        // end inhale
        assert {:msg "  117.50: Receiver might be null."} true ==> (n#3 != null);
        assert {:msg "  117.50: Location might not be readable."} true ==> CanRead(Mask#_218, n#3, AVLTreeNode.parent);
        assume Heap[n#3, AVLTreeNode.parent] == null;
      } else {
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      // end inhale
      assume false;
    } else {
      if (*) {
        havoc Heap;
        Mask := ZeroMask;
        Credits := ZeroCredits;
        // inhale (loop invariant, body)
        havoc inhaleHeap#_223;
        assume IsGoodInhaleState(inhaleHeap#_223, Heap, Mask);
        assume this != null;
        Heap[this, AVLTree.root] := inhaleHeap#_223[this, AVLTree.root];
        assume wf(Heap, Mask);
        assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
        Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_223[this, AVLTree.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_223, Mask);
        assume Heap[this, AVLTree.root] != null;
        Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_223[Heap[this, AVLTree.root], AVLTreeNode.parent];
        assume wf(Heap, Mask);
        assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
        Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 50];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_223[Heap[this, AVLTree.root], AVLTreeNode.parent]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_223, Mask);
        assume !(n#3 == null);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_223[n#3, AVLTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_223[n#3, AVLTreeNode.valid] == Heap;
        Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_223[n#3, AVLTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_223, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_223[n#3, AVLTreeNode.udParentValid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_223[n#3, AVLTreeNode.udParentValid] == Heap;
        Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_223[n#3, AVLTreeNode.udParentValid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_223, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.root] := inhaleHeap#_223[n#3, AVLTreeNode.root];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 40];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_223[n#3, AVLTreeNode.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_223, Mask);
        assume Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
        assume !(Heap[this, AVLTree.root] == null);
        if (end#5) {
          assume Heap[n#3, AVLTreeNode.parent] == null;
        } else {
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // assume lockchange at the beginning of the loop iteration
        assume (forall lk#_224: ref :: {Heap[lk#_224, held]} {Heap[lk#_224, rdheld]} (((0 < Heap[lk#_224, held]) == (0 < old(Heap)[lk#_224, held])) && (Heap[lk#_224, rdheld] == old(Heap)[lk#_224, rdheld])) || false);
        iterStartHeap#_194 := Heap;
        iterStartMask#_195 := Mask;
        iterStartCredits#_196 := Credits;
        end#21 := end#5;
        n#22 := n#3;
        assume !end#5;
        // unfold
        assert {:msg "  119.5: The target of the fold statement might be null."} n#3 != null;
        // begin exhale (unfold)
        exhaleMask#_225 := Mask;
        fraction#_226 := 100;
        assert {:msg "  119.5: unfold might fail because the predicate AVLTreeNode.udParentValid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.udParentValid."} (fraction#_226 <= exhaleMask#_225[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_226 == exhaleMask#_225[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_225[n#3, AVLTreeNode.udParentValid][perm$N]));
        exhaleMask#_225[n#3, AVLTreeNode.udParentValid] := exhaleMask#_225[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_225[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_226];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_225);
        Mask := exhaleMask#_225;
        assume wf(Heap, Mask);
        // end exhale
        // inhale (unfold)
        inhaleHeap#_227 := Heap[n#3, AVLTreeNode.udParentValid];
        assume IsGoodInhaleState(inhaleHeap#_227, Heap, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.parent] := inhaleHeap#_227[n#3, AVLTreeNode.parent];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.parent] == null) || (dtype(Heap[n#3, AVLTreeNode.parent]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.parent] := Mask[n#3, AVLTreeNode.parent][perm$R := Mask[n#3, AVLTreeNode.parent][perm$R] + 50];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_227[n#3, AVLTreeNode.parent]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_227, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.root] := inhaleHeap#_227[n#3, AVLTreeNode.root];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 10];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_227[n#3, AVLTreeNode.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_227, Mask);
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume Heap[n#3, AVLTreeNode.parent] != null;
          Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] == Heap;
          Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_227, Mask);
        } else {
        }
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume Heap[n#3, AVLTreeNode.parent] != null;
          Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown];
          assume wf(Heap, Mask);
          assume true;
          Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] + 50];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_227, Mask);
        } else {
        }
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume Heap[n#3, AVLTreeNode.parent] != null;
          Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left];
          assume wf(Heap, Mask);
          assume (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == null) || (dtype(Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left]) == AVLTreeNode#t);
          Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] + 50];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_227, Mask);
        } else {
        }
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
        } else {
        }
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume Heap[n#3, AVLTreeNode.parent] != null;
          Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right];
          assume wf(Heap, Mask);
          assume (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == null) || (dtype(Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right]) == AVLTreeNode#t);
          Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] + 50];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_227, Mask);
        } else {
        }
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume (!Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
        } else {
        }
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume Heap[n#3, AVLTreeNode.parent] != null;
          Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
          assume wf(Heap, Mask);
          assume (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] == null) || (dtype(Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root]) == AVLTreeNode#t);
          Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] + 50];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_227[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_227, Mask);
        } else {
        }
        if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
          assume Heap[n#3, AVLTreeNode.root] == Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
        } else {
        }
        if (Heap[n#3, AVLTreeNode.parent] == null) {
          assume Heap[n#3, AVLTreeNode.root] == n#3;
        } else {
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        // local var p
        // assigment to p
        assert {:msg "  120.28: Receiver might be null."} true ==> (n#3 != null);
        assert {:msg "  120.28: Location might not be readable."} true ==> CanRead(Mask, n#3, AVLTreeNode.parent);
        p#11 := Heap[n#3, AVLTreeNode.parent];
        // if
        if (p#11 == null) {
          // assigment to end
          end#5 := true;
          // fold
          assert {:msg "  123.6: The target of the fold statement might be null."} n#3 != null;
          // begin exhale (fold)
          exhaleMask#_228 := Mask;
          fraction#_229 := 50;
          assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 216.6 for AVLTreeNode.parent."} (fraction#_229 <= exhaleMask#_228[n#3, AVLTreeNode.parent][perm$R]) && ((fraction#_229 == exhaleMask#_228[n#3, AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_228[n#3, AVLTreeNode.parent][perm$N]));
          exhaleMask#_228[n#3, AVLTreeNode.parent] := exhaleMask#_228[n#3, AVLTreeNode.parent][perm$R := exhaleMask#_228[n#3, AVLTreeNode.parent][perm$R] - fraction#_229];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_228);
          fraction#_230 := 10;
          assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 217.6 for AVLTreeNode.root."} (fraction#_230 <= exhaleMask#_228[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_230 == exhaleMask#_228[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_228[n#3, AVLTreeNode.root][perm$N]));
          exhaleMask#_228[n#3, AVLTreeNode.root] := exhaleMask#_228[n#3, AVLTreeNode.root][perm$R := exhaleMask#_228[n#3, AVLTreeNode.root][perm$R] - fraction#_230];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_228);
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            fraction#_231 := 100;
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 218.24 for AVLTreeNode.udValid."} (fraction#_231 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) && ((fraction#_231 == exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R]) ==> (0 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$N]));
            exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] - fraction#_231];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_228);
          } else {
          }
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            fraction#_232 := 50;
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 219.24 for AVLTreeNode.leftDown."} (fraction#_232 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) && ((fraction#_232 == exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$N]));
            exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] - fraction#_232];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_228);
          } else {
          }
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            fraction#_233 := 50;
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 220.24 for AVLTreeNode.left."} (fraction#_233 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) && ((fraction#_233 == exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$N]));
            exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] - fraction#_233];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_228);
          } else {
          }
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 221.26 might not evaluate to true."} Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
          } else {
          }
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            fraction#_234 := 50;
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 222.24 for AVLTreeNode.right."} (fraction#_234 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) && ((fraction#_234 == exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$N]));
            exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] - fraction#_234];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_228);
          } else {
          }
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 223.25 might not evaluate to true."} (!Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
          } else {
          }
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            fraction#_235 := 50;
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. Insufficient fraction at 224.24 for AVLTreeNode.root."} (fraction#_235 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) && ((fraction#_235 == exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$N]));
            exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := exhaleMask#_228[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] - fraction#_235];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_228);
          } else {
          }
          if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 225.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
          } else {
          }
          if (Heap[n#3, AVLTreeNode.parent] == null) {
            assert {:msg "  123.6: Fold might fail because the definition of AVLTreeNode.udParentValid does not hold. The expression at 226.24 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == n#3;
          } else {
          }
          Mask := exhaleMask#_228;
          assume wf(Heap, Mask);
          // end exhale
          // inhale (fold)
          havoc inhaleHeap#_236;
          assume IsGoodInhaleState(inhaleHeap#_236, Heap, Mask);
          assume n#3 != null;
          Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_236[n#3, AVLTreeNode.udParentValid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_236[n#3, AVLTreeNode.udParentValid] == Heap;
          Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_236[n#3, AVLTreeNode.udParentValid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_236, Mask);
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          // end inhale
          Heap[n#3, AVLTreeNode.udParentValid] := Heap;
          assume wf(Heap, Mask);
        } else {
          // unfold
          assert {:msg "  125.6: The target of the fold statement might be null."} p#11 != null;
          // begin exhale (unfold)
          exhaleMask#_237 := Mask;
          fraction#_238 := 100;
          assert {:msg "  125.6: unfold might fail because the predicate AVLTreeNode.udValid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.udValid."} (fraction#_238 <= exhaleMask#_237[p#11, AVLTreeNode.udValid][perm$R]) && ((fraction#_238 == exhaleMask#_237[p#11, AVLTreeNode.udValid][perm$R]) ==> (0 <= exhaleMask#_237[p#11, AVLTreeNode.udValid][perm$N]));
          exhaleMask#_237[p#11, AVLTreeNode.udValid] := exhaleMask#_237[p#11, AVLTreeNode.udValid][perm$R := exhaleMask#_237[p#11, AVLTreeNode.udValid][perm$R] - fraction#_238];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_237);
          Mask := exhaleMask#_237;
          assume wf(Heap, Mask);
          // end exhale
          // inhale (unfold)
          inhaleHeap#_239 := Heap[p#11, AVLTreeNode.udValid];
          assume IsGoodInhaleState(inhaleHeap#_239, Heap, Mask);
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.key] := inhaleHeap#_239[p#11, AVLTreeNode.key];
          assume wf(Heap, Mask);
          assume true;
          Mask[p#11, AVLTreeNode.key] := Mask[p#11, AVLTreeNode.key][perm$R := Mask[p#11, AVLTreeNode.key][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.key]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_239, Mask);
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.leftDown] := inhaleHeap#_239[p#11, AVLTreeNode.leftDown];
          assume wf(Heap, Mask);
          assume true;
          Mask[p#11, AVLTreeNode.leftDown] := Mask[p#11, AVLTreeNode.leftDown][perm$R := Mask[p#11, AVLTreeNode.leftDown][perm$R] + 50];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.leftDown]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_239, Mask);
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.left] := inhaleHeap#_239[p#11, AVLTreeNode.left];
          assume wf(Heap, Mask);
          assume (Heap[p#11, AVLTreeNode.left] == null) || (dtype(Heap[p#11, AVLTreeNode.left]) == AVLTreeNode#t);
          Mask[p#11, AVLTreeNode.left] := Mask[p#11, AVLTreeNode.left][perm$R := Mask[p#11, AVLTreeNode.left][perm$R] + 25];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.left]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_239, Mask);
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.right] := inhaleHeap#_239[p#11, AVLTreeNode.right];
          assume wf(Heap, Mask);
          assume (Heap[p#11, AVLTreeNode.right] == null) || (dtype(Heap[p#11, AVLTreeNode.right]) == AVLTreeNode#t);
          Mask[p#11, AVLTreeNode.right] := Mask[p#11, AVLTreeNode.right][perm$R := Mask[p#11, AVLTreeNode.right][perm$R] + 25];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.right]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_239, Mask);
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.root] := inhaleHeap#_239[p#11, AVLTreeNode.root];
          assume wf(Heap, Mask);
          assume (Heap[p#11, AVLTreeNode.root] == null) || (dtype(Heap[p#11, AVLTreeNode.root]) == AVLTreeNode#t);
          Mask[p#11, AVLTreeNode.root] := Mask[p#11, AVLTreeNode.root][perm$R := Mask[p#11, AVLTreeNode.root][perm$R] + 20];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.root]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_239, Mask);
          if (Heap[p#11, AVLTreeNode.leftDown]) {
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.rightValid] := inhaleHeap#_239[p#11, AVLTreeNode.rightValid];
            assume wf(Heap, Mask);
            assume inhaleHeap#_239[p#11, AVLTreeNode.rightValid] == Heap;
            Mask[p#11, AVLTreeNode.rightValid] := Mask[p#11, AVLTreeNode.rightValid][perm$R := Mask[p#11, AVLTreeNode.rightValid][perm$R] + 100];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.rightValid]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_239, Mask);
          } else {
          }
          if (Heap[p#11, AVLTreeNode.leftDown]) {
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.leftOpen] := inhaleHeap#_239[p#11, AVLTreeNode.leftOpen];
            assume wf(Heap, Mask);
            assume inhaleHeap#_239[p#11, AVLTreeNode.leftOpen] == Heap;
            Mask[p#11, AVLTreeNode.leftOpen] := Mask[p#11, AVLTreeNode.leftOpen][perm$R := Mask[p#11, AVLTreeNode.leftOpen][perm$R] + 100];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.leftOpen]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_239, Mask);
          } else {
          }
          if (!Heap[p#11, AVLTreeNode.leftDown]) {
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.leftValid] := inhaleHeap#_239[p#11, AVLTreeNode.leftValid];
            assume wf(Heap, Mask);
            assume inhaleHeap#_239[p#11, AVLTreeNode.leftValid] == Heap;
            Mask[p#11, AVLTreeNode.leftValid] := Mask[p#11, AVLTreeNode.leftValid][perm$R := Mask[p#11, AVLTreeNode.leftValid][perm$R] + 100];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.leftValid]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_239, Mask);
          } else {
          }
          if (!Heap[p#11, AVLTreeNode.leftDown]) {
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.rightOpen] := inhaleHeap#_239[p#11, AVLTreeNode.rightOpen];
            assume wf(Heap, Mask);
            assume inhaleHeap#_239[p#11, AVLTreeNode.rightOpen] == Heap;
            Mask[p#11, AVLTreeNode.rightOpen] := Mask[p#11, AVLTreeNode.rightOpen][perm$R := Mask[p#11, AVLTreeNode.rightOpen][perm$R] + 100];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.rightOpen]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_239, Mask);
          } else {
          }
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.udParentValid] := inhaleHeap#_239[p#11, AVLTreeNode.udParentValid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_239[p#11, AVLTreeNode.udParentValid] == Heap;
          Mask[p#11, AVLTreeNode.udParentValid] := Mask[p#11, AVLTreeNode.udParentValid][perm$R := Mask[p#11, AVLTreeNode.udParentValid][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_239[p#11, AVLTreeNode.udParentValid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_239, Mask);
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          // end inhale
          // if
          assert {:msg "  126.10: Receiver might be null."} true ==> (p#11 != null);
          assert {:msg "  126.10: Location might not be readable."} true ==> CanRead(Mask, p#11, AVLTreeNode.left);
          if (Heap[p#11, AVLTreeNode.left] == n#3) {
            // unfold
            assert {:msg "  127.7: The target of the fold statement might be null."} p#11 != null;
            // begin exhale (unfold)
            exhaleMask#_240 := Mask;
            fraction#_241 := 100;
            assert {:msg "  127.7: unfold might fail because the predicate AVLTreeNode.leftOpen does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.leftOpen."} (fraction#_241 <= exhaleMask#_240[p#11, AVLTreeNode.leftOpen][perm$R]) && ((fraction#_241 == exhaleMask#_240[p#11, AVLTreeNode.leftOpen][perm$R]) ==> (0 <= exhaleMask#_240[p#11, AVLTreeNode.leftOpen][perm$N]));
            exhaleMask#_240[p#11, AVLTreeNode.leftOpen] := exhaleMask#_240[p#11, AVLTreeNode.leftOpen][perm$R := exhaleMask#_240[p#11, AVLTreeNode.leftOpen][perm$R] - fraction#_241];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_240);
            Mask := exhaleMask#_240;
            assume wf(Heap, Mask);
            // end exhale
            // inhale (unfold)
            inhaleHeap#_242 := Heap[p#11, AVLTreeNode.leftOpen];
            assume IsGoodInhaleState(inhaleHeap#_242, Heap, Mask);
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.left] := inhaleHeap#_242[p#11, AVLTreeNode.left];
            assume wf(Heap, Mask);
            assume (Heap[p#11, AVLTreeNode.left] == null) || (dtype(Heap[p#11, AVLTreeNode.left]) == AVLTreeNode#t);
            Mask[p#11, AVLTreeNode.left] := Mask[p#11, AVLTreeNode.left][perm$R := Mask[p#11, AVLTreeNode.left][perm$R] + 25];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_242[p#11, AVLTreeNode.left]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_242, Mask);
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.root] := inhaleHeap#_242[p#11, AVLTreeNode.root];
            assume wf(Heap, Mask);
            assume (Heap[p#11, AVLTreeNode.root] == null) || (dtype(Heap[p#11, AVLTreeNode.root]) == AVLTreeNode#t);
            Mask[p#11, AVLTreeNode.root] := Mask[p#11, AVLTreeNode.root][perm$R := Mask[p#11, AVLTreeNode.root][perm$R] + 10];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_242[p#11, AVLTreeNode.root]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_242, Mask);
            if (!(Heap[p#11, AVLTreeNode.left] == null)) {
              assume Heap[p#11, AVLTreeNode.left] != null;
              Heap[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent] := inhaleHeap#_242[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent];
              assume wf(Heap, Mask);
              assume (Heap[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent]) == AVLTreeNode#t);
              Mask[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent] := Mask[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent][perm$R := Mask[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent][perm$R] + 50];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_242[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_242, Mask);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.left] == null)) {
              assume Heap[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent] == p#11;
            } else {
            }
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            // end inhale
            // fold
            assert {:msg "  128.7: The target of the fold statement might be null."} p#11 != null;
            // begin exhale (fold)
            exhaleMask#_243 := Mask;
            fraction#_244 := 25;
            assert {:msg "  128.7: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 191.6 for AVLTreeNode.left."} (fraction#_244 <= exhaleMask#_243[p#11, AVLTreeNode.left][perm$R]) && ((fraction#_244 == exhaleMask#_243[p#11, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_243[p#11, AVLTreeNode.left][perm$N]));
            exhaleMask#_243[p#11, AVLTreeNode.left] := exhaleMask#_243[p#11, AVLTreeNode.left][perm$R := exhaleMask#_243[p#11, AVLTreeNode.left][perm$R] - fraction#_244];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_243);
            fraction#_245 := 10;
            assert {:msg "  128.7: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 192.6 for AVLTreeNode.root."} (fraction#_245 <= exhaleMask#_243[p#11, AVLTreeNode.root][perm$R]) && ((fraction#_245 == exhaleMask#_243[p#11, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_243[p#11, AVLTreeNode.root][perm$N]));
            exhaleMask#_243[p#11, AVLTreeNode.root] := exhaleMask#_243[p#11, AVLTreeNode.root][perm$R := exhaleMask#_243[p#11, AVLTreeNode.root][perm$R] - fraction#_245];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_243);
            if (!(Heap[p#11, AVLTreeNode.left] == null)) {
              fraction#_246 := 100;
              assert {:msg "  128.7: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 193.22 for AVLTreeNode.valid."} (fraction#_246 <= exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((fraction#_246 == exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
              exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - fraction#_246];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_243);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.left] == null)) {
              fraction#_247 := 100;
              assert {:msg "  128.7: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 194.22 for AVLTreeNode.parent."} (fraction#_247 <= exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent][perm$R]) && ((fraction#_247 == exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent][perm$N]));
              exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent] := exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent][perm$R := exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent][perm$R] - fraction#_247];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_243);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.left] == null)) {
              assert {:msg "  128.7: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. The expression at 195.22 might not evaluate to true."} Heap[Heap[p#11, AVLTreeNode.left], AVLTreeNode.parent] == p#11;
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.left] == null)) {
              fraction#_248 := 50;
              assert {:msg "  128.7: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 196.22 for AVLTreeNode.root."} (fraction#_248 <= exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.root][perm$R]) && ((fraction#_248 == exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.root][perm$N]));
              exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.root] := exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.root][perm$R := exhaleMask#_243[Heap[p#11, AVLTreeNode.left], AVLTreeNode.root][perm$R] - fraction#_248];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_243);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.left] == null)) {
              assert {:msg "  128.7: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. The expression at 197.22 might not evaluate to true."} Heap[Heap[p#11, AVLTreeNode.left], AVLTreeNode.root] == Heap[p#11, AVLTreeNode.root];
            } else {
            }
            Mask := exhaleMask#_243;
            assume wf(Heap, Mask);
            // end exhale
            // inhale (fold)
            havoc inhaleHeap#_249;
            assume IsGoodInhaleState(inhaleHeap#_249, Heap, Mask);
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.leftValid] := inhaleHeap#_249[p#11, AVLTreeNode.leftValid];
            assume wf(Heap, Mask);
            assume inhaleHeap#_249[p#11, AVLTreeNode.leftValid] == Heap;
            Mask[p#11, AVLTreeNode.leftValid] := Mask[p#11, AVLTreeNode.leftValid][perm$R := Mask[p#11, AVLTreeNode.leftValid][perm$R] + 100];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_249[p#11, AVLTreeNode.leftValid]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_249, Mask);
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            // end inhale
            Heap[p#11, AVLTreeNode.leftValid] := Heap;
            assume wf(Heap, Mask);
          } else {
            // unfold
            assert {:msg "  130.7: The target of the fold statement might be null."} p#11 != null;
            // begin exhale (unfold)
            exhaleMask#_250 := Mask;
            fraction#_251 := 100;
            assert {:msg "  130.7: unfold might fail because the predicate AVLTreeNode.rightOpen does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.rightOpen."} (fraction#_251 <= exhaleMask#_250[p#11, AVLTreeNode.rightOpen][perm$R]) && ((fraction#_251 == exhaleMask#_250[p#11, AVLTreeNode.rightOpen][perm$R]) ==> (0 <= exhaleMask#_250[p#11, AVLTreeNode.rightOpen][perm$N]));
            exhaleMask#_250[p#11, AVLTreeNode.rightOpen] := exhaleMask#_250[p#11, AVLTreeNode.rightOpen][perm$R := exhaleMask#_250[p#11, AVLTreeNode.rightOpen][perm$R] - fraction#_251];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_250);
            Mask := exhaleMask#_250;
            assume wf(Heap, Mask);
            // end exhale
            // inhale (unfold)
            inhaleHeap#_252 := Heap[p#11, AVLTreeNode.rightOpen];
            assume IsGoodInhaleState(inhaleHeap#_252, Heap, Mask);
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.right] := inhaleHeap#_252[p#11, AVLTreeNode.right];
            assume wf(Heap, Mask);
            assume (Heap[p#11, AVLTreeNode.right] == null) || (dtype(Heap[p#11, AVLTreeNode.right]) == AVLTreeNode#t);
            Mask[p#11, AVLTreeNode.right] := Mask[p#11, AVLTreeNode.right][perm$R := Mask[p#11, AVLTreeNode.right][perm$R] + 25];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_252[p#11, AVLTreeNode.right]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_252, Mask);
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.root] := inhaleHeap#_252[p#11, AVLTreeNode.root];
            assume wf(Heap, Mask);
            assume (Heap[p#11, AVLTreeNode.root] == null) || (dtype(Heap[p#11, AVLTreeNode.root]) == AVLTreeNode#t);
            Mask[p#11, AVLTreeNode.root] := Mask[p#11, AVLTreeNode.root][perm$R := Mask[p#11, AVLTreeNode.root][perm$R] + 10];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_252[p#11, AVLTreeNode.root]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_252, Mask);
            if (!(Heap[p#11, AVLTreeNode.right] == null)) {
              assume Heap[p#11, AVLTreeNode.right] != null;
              Heap[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent] := inhaleHeap#_252[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent];
              assume wf(Heap, Mask);
              assume (Heap[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent]) == AVLTreeNode#t);
              Mask[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent] := Mask[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent][perm$R := Mask[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent][perm$R] + 50];
              assume IsGoodMask(Mask);
              assume IsGoodState(inhaleHeap#_252[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent]);
              assume wf(Heap, Mask);
              assume wf(inhaleHeap#_252, Mask);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.right] == null)) {
              assume Heap[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent] == p#11;
            } else {
            }
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            // end inhale
            // fold
            assert {:msg "  131.7: The target of the fold statement might be null."} p#11 != null;
            // begin exhale (fold)
            exhaleMask#_253 := Mask;
            fraction#_254 := 25;
            assert {:msg "  131.7: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 182.6 for AVLTreeNode.right."} (fraction#_254 <= exhaleMask#_253[p#11, AVLTreeNode.right][perm$R]) && ((fraction#_254 == exhaleMask#_253[p#11, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_253[p#11, AVLTreeNode.right][perm$N]));
            exhaleMask#_253[p#11, AVLTreeNode.right] := exhaleMask#_253[p#11, AVLTreeNode.right][perm$R := exhaleMask#_253[p#11, AVLTreeNode.right][perm$R] - fraction#_254];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_253);
            fraction#_255 := 10;
            assert {:msg "  131.7: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 183.6 for AVLTreeNode.root."} (fraction#_255 <= exhaleMask#_253[p#11, AVLTreeNode.root][perm$R]) && ((fraction#_255 == exhaleMask#_253[p#11, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_253[p#11, AVLTreeNode.root][perm$N]));
            exhaleMask#_253[p#11, AVLTreeNode.root] := exhaleMask#_253[p#11, AVLTreeNode.root][perm$R := exhaleMask#_253[p#11, AVLTreeNode.root][perm$R] - fraction#_255];
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            assume wf(Heap, exhaleMask#_253);
            if (!(Heap[p#11, AVLTreeNode.right] == null)) {
              fraction#_256 := 100;
              assert {:msg "  131.7: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 184.23 for AVLTreeNode.valid."} (fraction#_256 <= exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((fraction#_256 == exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
              exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - fraction#_256];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_253);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.right] == null)) {
              fraction#_257 := 100;
              assert {:msg "  131.7: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 185.23 for AVLTreeNode.parent."} (fraction#_257 <= exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent][perm$R]) && ((fraction#_257 == exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent][perm$N]));
              exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent] := exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent][perm$R := exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent][perm$R] - fraction#_257];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_253);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.right] == null)) {
              assert {:msg "  131.7: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. The expression at 186.23 might not evaluate to true."} Heap[Heap[p#11, AVLTreeNode.right], AVLTreeNode.parent] == p#11;
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.right] == null)) {
              fraction#_258 := 50;
              assert {:msg "  131.7: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 187.23 for AVLTreeNode.root."} (fraction#_258 <= exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.root][perm$R]) && ((fraction#_258 == exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.root][perm$N]));
              exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.root] := exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.root][perm$R := exhaleMask#_253[Heap[p#11, AVLTreeNode.right], AVLTreeNode.root][perm$R] - fraction#_258];
              assume IsGoodMask(Mask);
              assume wf(Heap, Mask);
              assume wf(Heap, exhaleMask#_253);
            } else {
            }
            if (!(Heap[p#11, AVLTreeNode.right] == null)) {
              assert {:msg "  131.7: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. The expression at 188.23 might not evaluate to true."} Heap[Heap[p#11, AVLTreeNode.right], AVLTreeNode.root] == Heap[p#11, AVLTreeNode.root];
            } else {
            }
            Mask := exhaleMask#_253;
            assume wf(Heap, Mask);
            // end exhale
            // inhale (fold)
            havoc inhaleHeap#_259;
            assume IsGoodInhaleState(inhaleHeap#_259, Heap, Mask);
            assume p#11 != null;
            Heap[p#11, AVLTreeNode.rightValid] := inhaleHeap#_259[p#11, AVLTreeNode.rightValid];
            assume wf(Heap, Mask);
            assume inhaleHeap#_259[p#11, AVLTreeNode.rightValid] == Heap;
            Mask[p#11, AVLTreeNode.rightValid] := Mask[p#11, AVLTreeNode.rightValid][perm$R := Mask[p#11, AVLTreeNode.rightValid][perm$R] + 100];
            assume IsGoodMask(Mask);
            assume IsGoodState(inhaleHeap#_259[p#11, AVLTreeNode.rightValid]);
            assume wf(Heap, Mask);
            assume wf(inhaleHeap#_259, Mask);
            assume IsGoodMask(Mask);
            assume wf(Heap, Mask);
            // end inhale
            Heap[p#11, AVLTreeNode.rightValid] := Heap;
            assume wf(Heap, Mask);
          }
          // fold
          assert {:msg "  133.6: The target of the fold statement might be null."} p#11 != null;
          // begin exhale (fold)
          exhaleMask#_260 := Mask;
          fraction#_261 := 100;
          assert {:msg "  133.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 172.6 for AVLTreeNode.key."} (fraction#_261 <= exhaleMask#_260[p#11, AVLTreeNode.key][perm$R]) && ((fraction#_261 == exhaleMask#_260[p#11, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_260[p#11, AVLTreeNode.key][perm$N]));
          exhaleMask#_260[p#11, AVLTreeNode.key] := exhaleMask#_260[p#11, AVLTreeNode.key][perm$R := exhaleMask#_260[p#11, AVLTreeNode.key][perm$R] - fraction#_261];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_260);
          fraction#_262 := 30;
          assert {:msg "  133.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 173.6 for AVLTreeNode.root."} (fraction#_262 <= exhaleMask#_260[p#11, AVLTreeNode.root][perm$R]) && ((fraction#_262 == exhaleMask#_260[p#11, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_260[p#11, AVLTreeNode.root][perm$N]));
          exhaleMask#_260[p#11, AVLTreeNode.root] := exhaleMask#_260[p#11, AVLTreeNode.root][perm$R := exhaleMask#_260[p#11, AVLTreeNode.root][perm$R] - fraction#_262];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_260);
          fraction#_263 := 75;
          assert {:msg "  133.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 174.6 for AVLTreeNode.left."} (fraction#_263 <= exhaleMask#_260[p#11, AVLTreeNode.left][perm$R]) && ((fraction#_263 == exhaleMask#_260[p#11, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_260[p#11, AVLTreeNode.left][perm$N]));
          exhaleMask#_260[p#11, AVLTreeNode.left] := exhaleMask#_260[p#11, AVLTreeNode.left][perm$R := exhaleMask#_260[p#11, AVLTreeNode.left][perm$R] - fraction#_263];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_260);
          fraction#_264 := 75;
          assert {:msg "  133.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 175.6 for AVLTreeNode.right."} (fraction#_264 <= exhaleMask#_260[p#11, AVLTreeNode.right][perm$R]) && ((fraction#_264 == exhaleMask#_260[p#11, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_260[p#11, AVLTreeNode.right][perm$N]));
          exhaleMask#_260[p#11, AVLTreeNode.right] := exhaleMask#_260[p#11, AVLTreeNode.right][perm$R := exhaleMask#_260[p#11, AVLTreeNode.right][perm$R] - fraction#_264];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_260);
          fraction#_265 := 100;
          assert {:msg "  133.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 176.6 for AVLTreeNode.leftDown."} (fraction#_265 <= exhaleMask#_260[p#11, AVLTreeNode.leftDown][perm$R]) && ((fraction#_265 == exhaleMask#_260[p#11, AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_260[p#11, AVLTreeNode.leftDown][perm$N]));
          exhaleMask#_260[p#11, AVLTreeNode.leftDown] := exhaleMask#_260[p#11, AVLTreeNode.leftDown][perm$R := exhaleMask#_260[p#11, AVLTreeNode.leftDown][perm$R] - fraction#_265];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_260);
          assert {:msg "  133.6: Fold might fail because the definition of AVLTreeNode.validRest does not hold. The expression at 177.7 might not evaluate to true."} (!(Heap[p#11, AVLTreeNode.right] == Heap[p#11, AVLTreeNode.left])) || (Heap[p#11, AVLTreeNode.right] == null);
          Mask := exhaleMask#_260;
          assume wf(Heap, Mask);
          // end exhale
          // inhale (fold)
          havoc inhaleHeap#_266;
          assume IsGoodInhaleState(inhaleHeap#_266, Heap, Mask);
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.validRest] := inhaleHeap#_266[p#11, AVLTreeNode.validRest];
          assume wf(Heap, Mask);
          assume inhaleHeap#_266[p#11, AVLTreeNode.validRest] == Heap;
          Mask[p#11, AVLTreeNode.validRest] := Mask[p#11, AVLTreeNode.validRest][perm$R := Mask[p#11, AVLTreeNode.validRest][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_266[p#11, AVLTreeNode.validRest]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_266, Mask);
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          // end inhale
          Heap[p#11, AVLTreeNode.validRest] := Heap;
          assume wf(Heap, Mask);
          // fold
          assert {:msg "  134.6: The target of the fold statement might be null."} p#11 != null;
          // begin exhale (fold)
          exhaleMask#_267 := Mask;
          fraction#_268 := 100;
          assert {:msg "  134.6: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 165.6 for AVLTreeNode.validRest."} (fraction#_268 <= exhaleMask#_267[p#11, AVLTreeNode.validRest][perm$R]) && ((fraction#_268 == exhaleMask#_267[p#11, AVLTreeNode.validRest][perm$R]) ==> (0 <= exhaleMask#_267[p#11, AVLTreeNode.validRest][perm$N]));
          exhaleMask#_267[p#11, AVLTreeNode.validRest] := exhaleMask#_267[p#11, AVLTreeNode.validRest][perm$R := exhaleMask#_267[p#11, AVLTreeNode.validRest][perm$R] - fraction#_268];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_267);
          fraction#_269 := 100;
          assert {:msg "  134.6: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 166.6 for AVLTreeNode.leftValid."} (fraction#_269 <= exhaleMask#_267[p#11, AVLTreeNode.leftValid][perm$R]) && ((fraction#_269 == exhaleMask#_267[p#11, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_267[p#11, AVLTreeNode.leftValid][perm$N]));
          exhaleMask#_267[p#11, AVLTreeNode.leftValid] := exhaleMask#_267[p#11, AVLTreeNode.leftValid][perm$R := exhaleMask#_267[p#11, AVLTreeNode.leftValid][perm$R] - fraction#_269];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_267);
          fraction#_270 := 100;
          assert {:msg "  134.6: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 167.6 for AVLTreeNode.rightValid."} (fraction#_270 <= exhaleMask#_267[p#11, AVLTreeNode.rightValid][perm$R]) && ((fraction#_270 == exhaleMask#_267[p#11, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_267[p#11, AVLTreeNode.rightValid][perm$N]));
          exhaleMask#_267[p#11, AVLTreeNode.rightValid] := exhaleMask#_267[p#11, AVLTreeNode.rightValid][perm$R := exhaleMask#_267[p#11, AVLTreeNode.rightValid][perm$R] - fraction#_270];
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          assume wf(Heap, exhaleMask#_267);
          Mask := exhaleMask#_267;
          assume wf(Heap, Mask);
          // end exhale
          // inhale (fold)
          havoc inhaleHeap#_271;
          assume IsGoodInhaleState(inhaleHeap#_271, Heap, Mask);
          assume p#11 != null;
          Heap[p#11, AVLTreeNode.valid] := inhaleHeap#_271[p#11, AVLTreeNode.valid];
          assume wf(Heap, Mask);
          assume inhaleHeap#_271[p#11, AVLTreeNode.valid] == Heap;
          Mask[p#11, AVLTreeNode.valid] := Mask[p#11, AVLTreeNode.valid][perm$R := Mask[p#11, AVLTreeNode.valid][perm$R] + 100];
          assume IsGoodMask(Mask);
          assume IsGoodState(inhaleHeap#_271[p#11, AVLTreeNode.valid]);
          assume wf(Heap, Mask);
          assume wf(inhaleHeap#_271, Mask);
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask);
          // end inhale
          Heap[p#11, AVLTreeNode.valid] := Heap;
          assume wf(Heap, Mask);
          // assigment to n
          n#3 := p#11;
        }
        // begin exhale (loop invariant, maintained)
        exhaleMask#_272 := Mask;
        fraction#_273 := 100;
        assert {:msg "  109.15: The loop invariant at 109.15 might not be preserved by the loop. Insufficient fraction at 109.15 for AVLTree.root."} (fraction#_273 <= exhaleMask#_272[this, AVLTree.root][perm$R]) && ((fraction#_273 == exhaleMask#_272[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_272[this, AVLTree.root][perm$N]));
        exhaleMask#_272[this, AVLTree.root] := exhaleMask#_272[this, AVLTree.root][perm$R := exhaleMask#_272[this, AVLTree.root][perm$R] - fraction#_273];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_272);
        fraction#_274 := 50;
        assert {:msg "  110.15: The loop invariant at 110.15 might not be preserved by the loop. Insufficient fraction at 110.15 for AVLTreeNode.parent."} (fraction#_274 <= exhaleMask#_272[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) && ((fraction#_274 == exhaleMask#_272[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_272[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$N]));
        exhaleMask#_272[Heap[this, AVLTree.root], AVLTreeNode.parent] := exhaleMask#_272[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := exhaleMask#_272[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] - fraction#_274];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_272);
        assert {:msg "  111.15: The loop invariant at 111.15 might not be preserved by the loop. The expression at 111.15 might not evaluate to true."} !(n#3 == null);
        fraction#_275 := 100;
        assert {:msg "  112.15: The loop invariant at 112.15 might not be preserved by the loop. Insufficient fraction at 112.15 for AVLTreeNode.valid."} (fraction#_275 <= exhaleMask#_272[n#3, AVLTreeNode.valid][perm$R]) && ((fraction#_275 == exhaleMask#_272[n#3, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_272[n#3, AVLTreeNode.valid][perm$N]));
        exhaleMask#_272[n#3, AVLTreeNode.valid] := exhaleMask#_272[n#3, AVLTreeNode.valid][perm$R := exhaleMask#_272[n#3, AVLTreeNode.valid][perm$R] - fraction#_275];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_272);
        fraction#_276 := 100;
        assert {:msg "  113.15: The loop invariant at 113.15 might not be preserved by the loop. Insufficient fraction at 113.15 for AVLTreeNode.udParentValid."} (fraction#_276 <= exhaleMask#_272[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_276 == exhaleMask#_272[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_272[n#3, AVLTreeNode.udParentValid][perm$N]));
        exhaleMask#_272[n#3, AVLTreeNode.udParentValid] := exhaleMask#_272[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_272[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_276];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_272);
        fraction#_277 := 40;
        assert {:msg "  114.15: The loop invariant at 114.15 might not be preserved by the loop. Insufficient fraction at 114.15 for AVLTreeNode.root."} (fraction#_277 <= exhaleMask#_272[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_277 == exhaleMask#_272[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_272[n#3, AVLTreeNode.root][perm$N]));
        exhaleMask#_272[n#3, AVLTreeNode.root] := exhaleMask#_272[n#3, AVLTreeNode.root][perm$R := exhaleMask#_272[n#3, AVLTreeNode.root][perm$R] - fraction#_277];
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        assume wf(Heap, exhaleMask#_272);
        assert {:msg "  115.15: The loop invariant at 115.15 might not be preserved by the loop. The expression at 115.15 might not evaluate to true."} Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
        assert {:msg "  116.15: The loop invariant at 116.15 might not be preserved by the loop. The expression at 116.15 might not evaluate to true."} !(Heap[this, AVLTree.root] == null);
        if (end#5) {
          assert {:msg "  117.15: The loop invariant at 117.15 might not be preserved by the loop. The expression at 117.21 might not evaluate to true."} Heap[n#3, AVLTreeNode.parent] == null;
        } else {
        }
        Mask := exhaleMask#_272;
        assume wf(Heap, Mask);
        // end exhale
        // check lockchange after loop iteration
        assert {:msg "  108.4: The loop might lock/unlock more than the lockchange clause allows."} (forall lk#_278: ref :: {Heap[lk#_278, held]} {Heap[lk#_278, rdheld]} (((0 < Heap[lk#_278, held]) == (0 < old(Heap)[lk#_278, held])) && (Heap[lk#_278, rdheld] == old(Heap)[lk#_278, rdheld])) || false);
        assert {:msg "  108.4: Loop body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
        assume false;
      } else {
        // assume lockchange after the loop
        assume (forall lk#_281: ref :: {Heap[lk#_281, held]} {Heap[lk#_281, rdheld]} (((0 < Heap[lk#_281, held]) == (0 < old(Heap)[lk#_281, held])) && (Heap[lk#_281, rdheld] == old(Heap)[lk#_281, rdheld])) || false);
        // inhale (loop invariant, after loop)
        havoc inhaleHeap#_282;
        assume IsGoodInhaleState(inhaleHeap#_282, Heap, Mask);
        assume this != null;
        Heap[this, AVLTree.root] := inhaleHeap#_282[this, AVLTree.root];
        assume wf(Heap, Mask);
        assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
        Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_282[this, AVLTree.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_282, Mask);
        assume Heap[this, AVLTree.root] != null;
        Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] := inhaleHeap#_282[Heap[this, AVLTree.root], AVLTreeNode.parent];
        assume wf(Heap, Mask);
        assume (Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTree.root], AVLTreeNode.parent]) == AVLTreeNode#t);
        Mask[Heap[this, AVLTree.root], AVLTreeNode.parent] := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] + 50];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_282[Heap[this, AVLTree.root], AVLTreeNode.parent]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_282, Mask);
        assume !(n#3 == null);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.valid] := inhaleHeap#_282[n#3, AVLTreeNode.valid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_282[n#3, AVLTreeNode.valid] == Heap;
        Mask[n#3, AVLTreeNode.valid] := Mask[n#3, AVLTreeNode.valid][perm$R := Mask[n#3, AVLTreeNode.valid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_282[n#3, AVLTreeNode.valid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_282, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.udParentValid] := inhaleHeap#_282[n#3, AVLTreeNode.udParentValid];
        assume wf(Heap, Mask);
        assume inhaleHeap#_282[n#3, AVLTreeNode.udParentValid] == Heap;
        Mask[n#3, AVLTreeNode.udParentValid] := Mask[n#3, AVLTreeNode.udParentValid][perm$R := Mask[n#3, AVLTreeNode.udParentValid][perm$R] + 100];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_282[n#3, AVLTreeNode.udParentValid]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_282, Mask);
        assume n#3 != null;
        Heap[n#3, AVLTreeNode.root] := inhaleHeap#_282[n#3, AVLTreeNode.root];
        assume wf(Heap, Mask);
        assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
        Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 40];
        assume IsGoodMask(Mask);
        assume IsGoodState(inhaleHeap#_282[n#3, AVLTreeNode.root]);
        assume wf(Heap, Mask);
        assume wf(inhaleHeap#_282, Mask);
        assume Heap[n#3, AVLTreeNode.root] == Heap[this, AVLTree.root];
        assume !(Heap[this, AVLTree.root] == null);
        if (end#5) {
          assume Heap[n#3, AVLTreeNode.parent] == null;
        } else {
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask);
        // end inhale
        assume !(!end#5);
      }
    }
    // assert
    Heap#_286 := Heap;
    Mask#_287 := Mask;
    Credits#_288 := Credits;
    // begin exhale (assert)
    exhaleMask#_289 := Mask#_287;
    // unfolding
    assert {:msg "  138.21: Receiver might be null."} true ==> (n#3 != null);
    Heap#_293 := Heap#_286;
    Mask#_294 := Mask#_287;
    Credits#_295 := Credits#_288;
    // begin exhale (unfolding)
    exhaleMask#_296 := Mask#_294;
    fraction#_297 := 100;
    assert {:msg "  138.11: Unfolding might fail. Insufficient fraction at 138.21 for AVLTreeNode.udParentValid."} (fraction#_297 <= exhaleMask#_296[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_297 == exhaleMask#_296[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_296[n#3, AVLTreeNode.udParentValid][perm$N]));
    exhaleMask#_296[n#3, AVLTreeNode.udParentValid] := exhaleMask#_296[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_296[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_297];
    assume IsGoodMask(Mask#_294);
    assume wf(Heap#_293, Mask#_294);
    assume wf(Heap#_293, exhaleMask#_296);
    Mask#_294 := exhaleMask#_296;
    assume wf(Heap#_293, Mask#_294);
    // end exhale
    // inhale (unfolding)
    inhaleHeap#_298 := Heap#_286[n#3, AVLTreeNode.udParentValid];
    assume IsGoodInhaleState(inhaleHeap#_298, Heap#_293, Mask#_294);
    assume n#3 != null;
    Heap#_293[n#3, AVLTreeNode.parent] := inhaleHeap#_298[n#3, AVLTreeNode.parent];
    assume wf(Heap#_293, Mask#_294);
    assume (Heap#_293[n#3, AVLTreeNode.parent] == null) || (dtype(Heap#_293[n#3, AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask#_294[n#3, AVLTreeNode.parent] := Mask#_294[n#3, AVLTreeNode.parent][perm$R := Mask#_294[n#3, AVLTreeNode.parent][perm$R] + 50];
    assume IsGoodMask(Mask#_294);
    assume IsGoodState(inhaleHeap#_298[n#3, AVLTreeNode.parent]);
    assume wf(Heap#_293, Mask#_294);
    assume wf(inhaleHeap#_298, Mask#_294);
    assume n#3 != null;
    Heap#_293[n#3, AVLTreeNode.root] := inhaleHeap#_298[n#3, AVLTreeNode.root];
    assume wf(Heap#_293, Mask#_294);
    assume (Heap#_293[n#3, AVLTreeNode.root] == null) || (dtype(Heap#_293[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
    Mask#_294[n#3, AVLTreeNode.root] := Mask#_294[n#3, AVLTreeNode.root][perm$R := Mask#_294[n#3, AVLTreeNode.root][perm$R] + 10];
    assume IsGoodMask(Mask#_294);
    assume IsGoodState(inhaleHeap#_298[n#3, AVLTreeNode.root]);
    assume wf(Heap#_293, Mask#_294);
    assume wf(inhaleHeap#_298, Mask#_294);
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume Heap#_293[n#3, AVLTreeNode.parent] != null;
      Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.udValid];
      assume wf(Heap#_293, Mask#_294);
      assume inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] == Heap#_293;
      Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] + 100];
      assume IsGoodMask(Mask#_294);
      assume IsGoodState(inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.udValid]);
      assume wf(Heap#_293, Mask#_294);
      assume wf(inhaleHeap#_298, Mask#_294);
    } else {
    }
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume Heap#_293[n#3, AVLTreeNode.parent] != null;
      Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown];
      assume wf(Heap#_293, Mask#_294);
      assume true;
      Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] + 50];
      assume IsGoodMask(Mask#_294);
      assume IsGoodState(inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]);
      assume wf(Heap#_293, Mask#_294);
      assume wf(inhaleHeap#_298, Mask#_294);
    } else {
    }
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume Heap#_293[n#3, AVLTreeNode.parent] != null;
      Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left] := inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left];
      assume wf(Heap#_293, Mask#_294);
      assume (Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left] == null) || (dtype(Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left]) == AVLTreeNode#t);
      Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left] := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] + 50];
      assume IsGoodMask(Mask#_294);
      assume IsGoodState(inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left]);
      assume wf(Heap#_293, Mask#_294);
      assume wf(inhaleHeap#_298, Mask#_294);
    } else {
    }
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
    } else {
    }
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume Heap#_293[n#3, AVLTreeNode.parent] != null;
      Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right] := inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right];
      assume wf(Heap#_293, Mask#_294);
      assume (Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right] == null) || (dtype(Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right]) == AVLTreeNode#t);
      Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right] := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] + 50];
      assume IsGoodMask(Mask#_294);
      assume IsGoodState(inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right]);
      assume wf(Heap#_293, Mask#_294);
      assume wf(inhaleHeap#_298, Mask#_294);
    } else {
    }
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume (!Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
    } else {
    }
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume Heap#_293[n#3, AVLTreeNode.parent] != null;
      Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root] := inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root];
      assume wf(Heap#_293, Mask#_294);
      assume (Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root] == null) || (dtype(Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root]) == AVLTreeNode#t);
      Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root] := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := Mask#_294[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] + 50];
      assume IsGoodMask(Mask#_294);
      assume IsGoodState(inhaleHeap#_298[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root]);
      assume wf(Heap#_293, Mask#_294);
      assume wf(inhaleHeap#_298, Mask#_294);
    } else {
    }
    if (!(Heap#_293[n#3, AVLTreeNode.parent] == null)) {
      assume Heap#_293[n#3, AVLTreeNode.root] == Heap#_293[Heap#_293[n#3, AVLTreeNode.parent], AVLTreeNode.root];
    } else {
    }
    if (Heap#_293[n#3, AVLTreeNode.parent] == null) {
      assume Heap#_293[n#3, AVLTreeNode.root] == n#3;
    } else {
    }
    assume IsGoodMask(Mask#_294);
    assume wf(Heap#_293, Mask#_294);
    // end inhale
    assert {:msg "  138.43: Receiver might be null."} true ==> (this != null);
    assert {:msg "  138.43: Location might not be readable."} true ==> CanRead(Mask#_294, this, AVLTree.root);
    assert {:msg "  138.4: Assertion might not hold. The expression at 138.11 might not evaluate to true."} n#3 == Heap#_286[this, AVLTree.root];
    Mask#_287 := exhaleMask#_289;
    assume wf(Heap#_286, Mask#_287);
    // end exhale
    // assert
    Heap#_302 := Heap;
    Mask#_303 := Mask;
    Credits#_304 := Credits;
    // begin exhale (assert)
    exhaleMask#_305 := Mask#_303;
    assert {:msg "  139.22: Fraction might be negative."} 0 <= 40;
    assert {:msg "  139.22: Fraction might exceed 100."} 40 <= 100;
    assert {:msg "  139.4: Assertion might not hold. The target of the acc predicate at 139.11 might be null."} n#3 != null;
    fraction#_306 := 40;
    assert {:msg "  139.4: Assertion might not hold. Insufficient fraction at 139.11 for AVLTreeNode.root."} (fraction#_306 <= exhaleMask#_305[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_306 == exhaleMask#_305[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_305[n#3, AVLTreeNode.root][perm$N]));
    exhaleMask#_305[n#3, AVLTreeNode.root] := exhaleMask#_305[n#3, AVLTreeNode.root][perm$R := exhaleMask#_305[n#3, AVLTreeNode.root][perm$R] - fraction#_306];
    assume IsGoodMask(Mask#_303);
    assume wf(Heap#_302, Mask#_303);
    assume wf(Heap#_302, exhaleMask#_305);
    Mask#_303 := exhaleMask#_305;
    assume wf(Heap#_302, Mask#_303);
    // end exhale
    // unfold
    assert {:msg "  140.4: The target of the fold statement might be null."} n#3 != null;
    // begin exhale (unfold)
    exhaleMask#_307 := Mask;
    fraction#_308 := 100;
    assert {:msg "  140.4: unfold might fail because the predicate AVLTreeNode.udParentValid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.udParentValid."} (fraction#_308 <= exhaleMask#_307[n#3, AVLTreeNode.udParentValid][perm$R]) && ((fraction#_308 == exhaleMask#_307[n#3, AVLTreeNode.udParentValid][perm$R]) ==> (0 <= exhaleMask#_307[n#3, AVLTreeNode.udParentValid][perm$N]));
    exhaleMask#_307[n#3, AVLTreeNode.udParentValid] := exhaleMask#_307[n#3, AVLTreeNode.udParentValid][perm$R := exhaleMask#_307[n#3, AVLTreeNode.udParentValid][perm$R] - fraction#_308];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_307);
    Mask := exhaleMask#_307;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (unfold)
    inhaleHeap#_309 := Heap[n#3, AVLTreeNode.udParentValid];
    assume IsGoodInhaleState(inhaleHeap#_309, Heap, Mask);
    assume n#3 != null;
    Heap[n#3, AVLTreeNode.parent] := inhaleHeap#_309[n#3, AVLTreeNode.parent];
    assume wf(Heap, Mask);
    assume (Heap[n#3, AVLTreeNode.parent] == null) || (dtype(Heap[n#3, AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask[n#3, AVLTreeNode.parent] := Mask[n#3, AVLTreeNode.parent][perm$R := Mask[n#3, AVLTreeNode.parent][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_309[n#3, AVLTreeNode.parent]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_309, Mask);
    assume n#3 != null;
    Heap[n#3, AVLTreeNode.root] := inhaleHeap#_309[n#3, AVLTreeNode.root];
    assume wf(Heap, Mask);
    assume (Heap[n#3, AVLTreeNode.root] == null) || (dtype(Heap[n#3, AVLTreeNode.root]) == AVLTreeNode#t);
    Mask[n#3, AVLTreeNode.root] := Mask[n#3, AVLTreeNode.root][perm$R := Mask[n#3, AVLTreeNode.root][perm$R] + 10];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_309[n#3, AVLTreeNode.root]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_309, Mask);
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume Heap[n#3, AVLTreeNode.parent] != null;
      Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid];
      assume wf(Heap, Mask);
      assume inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] == Heap;
      Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] + 100];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.udValid]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_309, Mask);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume Heap[n#3, AVLTreeNode.parent] != null;
      Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown];
      assume wf(Heap, Mask);
      assume true;
      Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] + 50];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_309, Mask);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume Heap[n#3, AVLTreeNode.parent] != null;
      Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left];
      assume wf(Heap, Mask);
      assume (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == null) || (dtype(Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left]) == AVLTreeNode#t);
      Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left][perm$R] + 50];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_309, Mask);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.left] == n#3);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume Heap[n#3, AVLTreeNode.parent] != null;
      Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right];
      assume wf(Heap, Mask);
      assume (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == null) || (dtype(Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right]) == AVLTreeNode#t);
      Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right][perm$R] + 50];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_309, Mask);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume (!Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.right] == n#3);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume Heap[n#3, AVLTreeNode.parent] != null;
      Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
      assume wf(Heap, Mask);
      assume (Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] == null) || (dtype(Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root]) == AVLTreeNode#t);
      Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root] := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R := Mask[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root][perm$R] + 50];
      assume IsGoodMask(Mask);
      assume IsGoodState(inhaleHeap#_309[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root]);
      assume wf(Heap, Mask);
      assume wf(inhaleHeap#_309, Mask);
    } else {
    }
    if (!(Heap[n#3, AVLTreeNode.parent] == null)) {
      assume Heap[n#3, AVLTreeNode.root] == Heap[Heap[n#3, AVLTreeNode.parent], AVLTreeNode.root];
    } else {
    }
    if (Heap[n#3, AVLTreeNode.parent] == null) {
      assume Heap[n#3, AVLTreeNode.root] == n#3;
    } else {
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    // assert
    Heap#_313 := Heap;
    Mask#_314 := Mask;
    Credits#_315 := Credits;
    // begin exhale (assert)
    exhaleMask#_316 := Mask#_314;
    assert {:msg "  141.22: Fraction might be negative."} 0 <= 50;
    assert {:msg "  141.22: Fraction might exceed 100."} 50 <= 100;
    assert {:msg "  141.4: Assertion might not hold. The target of the acc predicate at 141.11 might be null."} n#3 != null;
    fraction#_317 := 50;
    assert {:msg "  141.4: Assertion might not hold. Insufficient fraction at 141.11 for AVLTreeNode.root."} (fraction#_317 <= exhaleMask#_316[n#3, AVLTreeNode.root][perm$R]) && ((fraction#_317 == exhaleMask#_316[n#3, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_316[n#3, AVLTreeNode.root][perm$N]));
    exhaleMask#_316[n#3, AVLTreeNode.root] := exhaleMask#_316[n#3, AVLTreeNode.root][perm$R := exhaleMask#_316[n#3, AVLTreeNode.root][perm$R] - fraction#_317];
    assume IsGoodMask(Mask#_314);
    assume wf(Heap#_313, Mask#_314);
    assume wf(Heap#_313, exhaleMask#_316);
    Mask#_314 := exhaleMask#_316;
    assume wf(Heap#_313, Mask#_314);
    // end exhale
    // fold
    assert {:msg "  142.4: The target of the fold statement might be null."} this != null;
    // begin exhale (fold)
    exhaleMask#_318 := Mask;
    fraction#_319 := 100;
    assert {:msg "  142.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 10.6 for AVLTree.root."} (fraction#_319 <= exhaleMask#_318[this, AVLTree.root][perm$R]) && ((fraction#_319 == exhaleMask#_318[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_318[this, AVLTree.root][perm$N]));
    exhaleMask#_318[this, AVLTree.root] := exhaleMask#_318[this, AVLTree.root][perm$R := exhaleMask#_318[this, AVLTree.root][perm$R] - fraction#_319];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_318);
    if (!(Heap[this, AVLTree.root] == null)) {
      fraction#_320 := 100;
      assert {:msg "  142.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid."} (fraction#_320 <= exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) && ((fraction#_320 == exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$N]));
      exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.valid] := exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] - fraction#_320];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_318);
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      fraction#_321 := 100;
      assert {:msg "  142.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 13.22 for AVLTreeNode.parent."} (fraction#_321 <= exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) && ((fraction#_321 == exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$N]));
      exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.parent] := exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R := exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.parent][perm$R] - fraction#_321];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_318);
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      assert {:msg "  142.4: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 14.22 might not evaluate to true."} Heap[Heap[this, AVLTree.root], AVLTreeNode.parent] == null;
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      fraction#_322 := 50;
      assert {:msg "  142.4: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 15.22 for AVLTreeNode.root."} (fraction#_322 <= exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R]) && ((fraction#_322 == exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.root][perm$N]));
      exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.root] := exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R := exhaleMask#_318[Heap[this, AVLTree.root], AVLTreeNode.root][perm$R] - fraction#_322];
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask);
      assume wf(Heap, exhaleMask#_318);
    } else {
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      assert {:msg "  142.4: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true."} Heap[Heap[this, AVLTree.root], AVLTreeNode.root] == Heap[this, AVLTree.root];
    } else {
    }
    Mask := exhaleMask#_318;
    assume wf(Heap, Mask);
    // end exhale
    // inhale (fold)
    havoc inhaleHeap#_323;
    assume IsGoodInhaleState(inhaleHeap#_323, Heap, Mask);
    assume this != null;
    Heap[this, AVLTree.valid] := inhaleHeap#_323[this, AVLTree.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_323[this, AVLTree.valid] == Heap;
    Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_323[this, AVLTree.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_323, Mask);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    // end inhale
    Heap[this, AVLTree.valid] := Heap;
    assume wf(Heap, Mask);
  }
  // begin exhale (postcondition)
  exhaleMask#_324 := Mask;
  fraction#_325 := 100;
  assert {:msg "  38.2: The postcondition at 42.11 might not hold. Insufficient fraction at 42.11 for AVLTree.valid."} (fraction#_325 <= exhaleMask#_324[this, AVLTree.valid][perm$R]) && ((fraction#_325 == exhaleMask#_324[this, AVLTree.valid][perm$R]) ==> (0 <= exhaleMask#_324[this, AVLTree.valid][perm$N]));
  exhaleMask#_324[this, AVLTree.valid] := exhaleMask#_324[this, AVLTree.valid][perm$R := exhaleMask#_324[this, AVLTree.valid][perm$R] - fraction#_325];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_324);
  Mask := exhaleMask#_324;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  38.2: Method might lock/unlock more than allowed."} (forall lk#_326: ref :: {Heap[lk#_326, held]} {Heap[lk#_326, rdheld]} (((0 < Heap[lk#_326, held]) == (0 < old(Heap)[lk#_326, held])) && (Heap[lk#_326, rdheld] == old(Heap)[lk#_326, rdheld])) || false);
  assert {:msg "  38.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique AVLTreeNode#t: TypeName;
procedure AVLTreeNode$monitorinvariant$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var h0#_327: HeapType;
  var m0#_328: MaskType;
  var c0#_329: CreditsType;
  var h1#_330: HeapType;
  var m1#_331: MaskType;
  var c1#_332: CreditsType;
  var lk#_333: ref;
  assume wf(h0#_327, m0#_328);
  assume wf(h1#_330, m1#_331);
  m1#_331 := ZeroMask;
  c1#_332 := ZeroCredits;
  Mask := ZeroMask;
  Credits := ZeroCredits;
  havoc Heap;
  assert {:msg "  149.1: Monitor invariant is not allowed to contain debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
const unique AVLTreeNode.key: Field (int);
axiom NonPredicateField(AVLTreeNode.key);
const unique AVLTreeNode.left: Field (ref);
axiom NonPredicateField(AVLTreeNode.left);
const unique AVLTreeNode.right: Field (ref);
axiom NonPredicateField(AVLTreeNode.right);
const unique AVLTreeNode.parent: Field (ref);
axiom NonPredicateField(AVLTreeNode.parent);
const unique AVLTreeNode.leftDown: Field (bool);
axiom NonPredicateField(AVLTreeNode.leftDown);
const unique AVLTreeNode.root: Field (ref);
axiom NonPredicateField(AVLTreeNode.root);
const unique AVLTreeNode.valid: Field (HeapType);
axiom PredicateField(AVLTreeNode.valid);
procedure AVLTreeNode.valid$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_334: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_334;
  assume IsGoodInhaleState(inhaleHeap#_334, Heap, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.validRest] := inhaleHeap#_334[this, AVLTreeNode.validRest];
  assume wf(Heap, Mask);
  assume inhaleHeap#_334[this, AVLTreeNode.validRest] == Heap;
  Mask[this, AVLTreeNode.validRest] := Mask[this, AVLTreeNode.validRest][perm$R := Mask[this, AVLTreeNode.validRest][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, AVLTreeNode.validRest]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.leftValid] := inhaleHeap#_334[this, AVLTreeNode.leftValid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_334[this, AVLTreeNode.leftValid] == Heap;
  Mask[this, AVLTreeNode.leftValid] := Mask[this, AVLTreeNode.leftValid][perm$R := Mask[this, AVLTreeNode.leftValid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, AVLTreeNode.leftValid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.rightValid] := inhaleHeap#_334[this, AVLTreeNode.rightValid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_334[this, AVLTreeNode.rightValid] == Heap;
  Mask[this, AVLTreeNode.rightValid] := Mask[this, AVLTreeNode.rightValid][perm$R := Mask[this, AVLTreeNode.rightValid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_334[this, AVLTreeNode.rightValid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_334, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
const unique AVLTreeNode.validRest: Field (HeapType);
axiom PredicateField(AVLTreeNode.validRest);
procedure AVLTreeNode.validRest$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_335: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_335;
  assume IsGoodInhaleState(inhaleHeap#_335, Heap, Mask);
  assert {:msg "  172.17: Fraction might be negative."} 0 <= 100;
  assert {:msg "  172.17: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.key] := inhaleHeap#_335[this, AVLTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.key] := Mask[this, AVLTreeNode.key][perm$R := Mask[this, AVLTreeNode.key][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_335[this, AVLTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_335, Mask);
  assert {:msg "  173.19: Fraction might be negative."} 0 <= 30;
  assert {:msg "  173.19: Fraction might exceed 100."} 30 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_335[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 30];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_335[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_335, Mask);
  assert {:msg "  174.17: Fraction might be negative."} 0 <= 75;
  assert {:msg "  174.17: Fraction might exceed 100."} 75 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.left] := inhaleHeap#_335[this, AVLTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.left] == null) || (dtype(Heap[this, AVLTreeNode.left]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.left] := Mask[this, AVLTreeNode.left][perm$R := Mask[this, AVLTreeNode.left][perm$R] + 75];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_335[this, AVLTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_335, Mask);
  assert {:msg "  175.17: Fraction might be negative."} 0 <= 75;
  assert {:msg "  175.17: Fraction might exceed 100."} 75 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.right] := inhaleHeap#_335[this, AVLTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.right] == null) || (dtype(Heap[this, AVLTreeNode.right]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.right] := Mask[this, AVLTreeNode.right][perm$R := Mask[this, AVLTreeNode.right][perm$R] + 75];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_335[this, AVLTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_335, Mask);
  assert {:msg "  176.19: Fraction might be negative."} 0 <= 100;
  assert {:msg "  176.19: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.leftDown] := inhaleHeap#_335[this, AVLTreeNode.leftDown];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.leftDown] := Mask[this, AVLTreeNode.leftDown][perm$R := Mask[this, AVLTreeNode.leftDown][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_335[this, AVLTreeNode.leftDown]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_335, Mask);
  assert {:msg "  177.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  177.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  assert {:msg "  177.14: Receiver might be null."} true ==> (this != null);
  assert {:msg "  177.14: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  assert {:msg "  177.22: Receiver might be null."} true && (!(!(Heap[this, AVLTreeNode.right] == Heap[this, AVLTreeNode.left]))) ==> (this != null);
  assert {:msg "  177.22: Location might not be readable."} true && (!(!(Heap[this, AVLTreeNode.right] == Heap[this, AVLTreeNode.left]))) ==> CanRead(Mask, this, AVLTreeNode.right);
  assume (!(Heap[this, AVLTreeNode.right] == Heap[this, AVLTreeNode.left])) || (Heap[this, AVLTreeNode.right] == null);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
const unique AVLTreeNode.rightValid: Field (HeapType);
axiom PredicateField(AVLTreeNode.rightValid);
procedure AVLTreeNode.rightValid$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_336: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_336;
  assume IsGoodInhaleState(inhaleHeap#_336, Heap, Mask);
  assert {:msg "  182.17: Fraction might be negative."} 0 <= 25;
  assert {:msg "  182.17: Fraction might exceed 100."} 25 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.right] := inhaleHeap#_336[this, AVLTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.right] == null) || (dtype(Heap[this, AVLTreeNode.right]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.right] := Mask[this, AVLTreeNode.right][perm$R := Mask[this, AVLTreeNode.right][perm$R] + 25];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_336[this, AVLTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_336, Mask);
  assert {:msg "  183.15: Fraction might be negative."} 0 <= 10;
  assert {:msg "  183.15: Fraction might exceed 100."} 10 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_336[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 10];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_336[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_336, Mask);
  assert {:msg "  184.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  184.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  184.23: Receiver might be null."} true ==> (this != null);
    assert {:msg "  184.23: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
    assume Heap[this, AVLTreeNode.right] != null;
    Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := inhaleHeap#_336[Heap[this, AVLTreeNode.right], AVLTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_336[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] == Heap;
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_336[Heap[this, AVLTreeNode.right], AVLTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_336, Mask);
  } else {
  }
  assert {:msg "  185.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  185.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  185.27: Receiver might be null."} true ==> (this != null);
    assert {:msg "  185.27: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
    assert {:msg "  185.40: Fraction might be negative."} 0 <= 100;
    assert {:msg "  185.40: Fraction might exceed 100."} 100 <= 100;
    assume Heap[this, AVLTreeNode.right] != null;
    Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] := inhaleHeap#_336[Heap[this, AVLTreeNode.right], AVLTreeNode.parent];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_336[Heap[this, AVLTreeNode.right], AVLTreeNode.parent]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_336, Mask);
  } else {
  }
  assert {:msg "  186.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  186.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  186.23: Receiver might be null."} true ==> (this != null);
    assert {:msg "  186.23: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
    assert {:msg "  186.23: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.right] != null);
    assert {:msg "  186.23: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.right], AVLTreeNode.parent);
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] == this;
  } else {
  }
  assert {:msg "  187.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  187.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  187.27: Receiver might be null."} true ==> (this != null);
    assert {:msg "  187.27: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
    assert {:msg "  187.38: Fraction might be negative."} 0 <= 50;
    assert {:msg "  187.38: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.right] != null;
    Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.root] := inhaleHeap#_336[Heap[this, AVLTreeNode.right], AVLTreeNode.root];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.root] == null) || (dtype(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.root]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.root] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.root][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.root][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_336[Heap[this, AVLTreeNode.right], AVLTreeNode.root]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_336, Mask);
  } else {
  }
  assert {:msg "  188.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  188.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  188.23: Receiver might be null."} true ==> (this != null);
    assert {:msg "  188.23: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
    assert {:msg "  188.23: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.right] != null);
    assert {:msg "  188.23: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.right], AVLTreeNode.root);
    assert {:msg "  188.35: Receiver might be null."} true ==> (this != null);
    assert {:msg "  188.35: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.root);
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.root] == Heap[this, AVLTreeNode.root];
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
const unique AVLTreeNode.leftValid: Field (HeapType);
axiom PredicateField(AVLTreeNode.leftValid);
procedure AVLTreeNode.leftValid$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_337: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_337;
  assume IsGoodInhaleState(inhaleHeap#_337, Heap, Mask);
  assert {:msg "  191.17: Fraction might be negative."} 0 <= 25;
  assert {:msg "  191.17: Fraction might exceed 100."} 25 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.left] := inhaleHeap#_337[this, AVLTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.left] == null) || (dtype(Heap[this, AVLTreeNode.left]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.left] := Mask[this, AVLTreeNode.left][perm$R := Mask[this, AVLTreeNode.left][perm$R] + 25];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_337[this, AVLTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_337, Mask);
  assert {:msg "  192.15: Fraction might be negative."} 0 <= 10;
  assert {:msg "  192.15: Fraction might exceed 100."} 10 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_337[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 10];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_337[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_337, Mask);
  assert {:msg "  193.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  193.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  193.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  193.22: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
    assume Heap[this, AVLTreeNode.left] != null;
    Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := inhaleHeap#_337[Heap[this, AVLTreeNode.left], AVLTreeNode.valid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_337[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] == Heap;
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_337[Heap[this, AVLTreeNode.left], AVLTreeNode.valid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_337, Mask);
  } else {
  }
  assert {:msg "  194.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  194.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  194.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  194.26: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
    assert {:msg "  194.38: Fraction might be negative."} 0 <= 100;
    assert {:msg "  194.38: Fraction might exceed 100."} 100 <= 100;
    assume Heap[this, AVLTreeNode.left] != null;
    Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] := inhaleHeap#_337[Heap[this, AVLTreeNode.left], AVLTreeNode.parent];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_337[Heap[this, AVLTreeNode.left], AVLTreeNode.parent]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_337, Mask);
  } else {
  }
  assert {:msg "  195.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  195.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  195.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  195.22: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
    assert {:msg "  195.22: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.left] != null);
    assert {:msg "  195.22: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.left], AVLTreeNode.parent);
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] == this;
  } else {
  }
  assert {:msg "  196.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  196.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  196.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  196.26: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
    assert {:msg "  196.36: Fraction might be negative."} 0 <= 50;
    assert {:msg "  196.36: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.left] != null;
    Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.root] := inhaleHeap#_337[Heap[this, AVLTreeNode.left], AVLTreeNode.root];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.root] == null) || (dtype(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.root]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.root] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.root][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.root][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_337[Heap[this, AVLTreeNode.left], AVLTreeNode.root]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_337, Mask);
  } else {
  }
  assert {:msg "  197.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  197.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  197.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  197.22: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
    assert {:msg "  197.22: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.left] != null);
    assert {:msg "  197.22: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.left], AVLTreeNode.root);
    assert {:msg "  197.35: Receiver might be null."} true ==> (this != null);
    assert {:msg "  197.35: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.root);
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.root] == Heap[this, AVLTreeNode.root];
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
const unique AVLTreeNode.leftOpen: Field (HeapType);
axiom PredicateField(AVLTreeNode.leftOpen);
procedure AVLTreeNode.leftOpen$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_338: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_338;
  assume IsGoodInhaleState(inhaleHeap#_338, Heap, Mask);
  assert {:msg "  201.17: Fraction might be negative."} 0 <= 25;
  assert {:msg "  201.17: Fraction might exceed 100."} 25 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.left] := inhaleHeap#_338[this, AVLTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.left] == null) || (dtype(Heap[this, AVLTreeNode.left]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.left] := Mask[this, AVLTreeNode.left][perm$R := Mask[this, AVLTreeNode.left][perm$R] + 25];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_338[this, AVLTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_338, Mask);
  assert {:msg "  202.15: Fraction might be negative."} 0 <= 10;
  assert {:msg "  202.15: Fraction might exceed 100."} 10 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_338[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 10];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_338[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_338, Mask);
  assert {:msg "  203.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  203.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  203.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  203.26: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
    assert {:msg "  203.38: Fraction might be negative."} 0 <= 50;
    assert {:msg "  203.38: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.left] != null;
    Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] := inhaleHeap#_338[Heap[this, AVLTreeNode.left], AVLTreeNode.parent];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_338[Heap[this, AVLTreeNode.left], AVLTreeNode.parent]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_338, Mask);
  } else {
  }
  assert {:msg "  204.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  204.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  204.22: Receiver might be null."} true ==> (this != null);
    assert {:msg "  204.22: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.left);
    assert {:msg "  204.22: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.left] != null);
    assert {:msg "  204.22: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.left], AVLTreeNode.parent);
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] == this;
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
const unique AVLTreeNode.rightOpen: Field (HeapType);
axiom PredicateField(AVLTreeNode.rightOpen);
procedure AVLTreeNode.rightOpen$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_339: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_339;
  assume IsGoodInhaleState(inhaleHeap#_339, Heap, Mask);
  assert {:msg "  208.18: Fraction might be negative."} 0 <= 25;
  assert {:msg "  208.18: Fraction might exceed 100."} 25 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.right] := inhaleHeap#_339[this, AVLTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.right] == null) || (dtype(Heap[this, AVLTreeNode.right]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.right] := Mask[this, AVLTreeNode.right][perm$R := Mask[this, AVLTreeNode.right][perm$R] + 25];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_339[this, AVLTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_339, Mask);
  assert {:msg "  209.15: Fraction might be negative."} 0 <= 10;
  assert {:msg "  209.15: Fraction might exceed 100."} 10 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_339[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 10];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_339[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_339, Mask);
  assert {:msg "  210.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  210.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  210.27: Receiver might be null."} true ==> (this != null);
    assert {:msg "  210.27: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
    assert {:msg "  210.40: Fraction might be negative."} 0 <= 50;
    assert {:msg "  210.40: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.right] != null;
    Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] := inhaleHeap#_339[Heap[this, AVLTreeNode.right], AVLTreeNode.parent];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] == null) || (dtype(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_339[Heap[this, AVLTreeNode.right], AVLTreeNode.parent]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_339, Mask);
  } else {
  }
  assert {:msg "  211.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  211.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  211.23: Receiver might be null."} true ==> (this != null);
    assert {:msg "  211.23: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.right);
    assert {:msg "  211.23: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.right] != null);
    assert {:msg "  211.23: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.right], AVLTreeNode.parent);
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] == this;
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
const unique AVLTreeNode.udParentValid: Field (HeapType);
axiom PredicateField(AVLTreeNode.udParentValid);
procedure AVLTreeNode.udParentValid$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_340: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_340;
  assume IsGoodInhaleState(inhaleHeap#_340, Heap, Mask);
  assert {:msg "  216.17: Fraction might be negative."} 0 <= 50;
  assert {:msg "  216.17: Fraction might exceed 100."} 50 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.parent] := inhaleHeap#_340[this, AVLTreeNode.parent];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.parent] == null) || (dtype(Heap[this, AVLTreeNode.parent]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.parent] := Mask[this, AVLTreeNode.parent][perm$R := Mask[this, AVLTreeNode.parent][perm$R] + 50];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_340[this, AVLTreeNode.parent]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_340, Mask);
  assert {:msg "  217.15: Fraction might be negative."} 0 <= 10;
  assert {:msg "  217.15: Fraction might exceed 100."} 10 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_340[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 10];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_340[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_340, Mask);
  assert {:msg "  218.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  218.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  218.24: Receiver might be null."} true ==> (this != null);
    assert {:msg "  218.24: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assume Heap[this, AVLTreeNode.parent] != null;
    Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.udValid] := inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.udValid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.udValid] == Heap;
    Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.udValid] := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.udValid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.udValid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_340, Mask);
  } else {
  }
  assert {:msg "  219.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  219.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  219.28: Receiver might be null."} true ==> (this != null);
    assert {:msg "  219.28: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  219.44: Fraction might be negative."} 0 <= 50;
    assert {:msg "  219.44: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.parent] != null;
    Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown] := inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown];
    assume wf(Heap, Mask);
    assume true;
    Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown] := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_340, Mask);
  } else {
  }
  assert {:msg "  220.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  220.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  220.28: Receiver might be null."} true ==> (this != null);
    assert {:msg "  220.28: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  220.40: Fraction might be negative."} 0 <= 50;
    assert {:msg "  220.40: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.parent] != null;
    Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.left] := inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.left];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.left] == null) || (dtype(Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.left]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.left] := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.left][perm$R := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.left][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.left]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_340, Mask);
  } else {
  }
  assert {:msg "  221.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  221.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  221.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  221.26: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  221.26: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.parent] != null);
    assert {:msg "  221.26: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown);
    assert {:msg "  221.45: Receiver might be null."} true ==> (this != null);
    assert {:msg "  221.45: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  221.45: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.parent] != null);
    assert {:msg "  221.45: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.parent], AVLTreeNode.left);
    assume Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown] <==> (Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.left] == this);
  } else {
  }
  assert {:msg "  222.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  222.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  222.28: Receiver might be null."} true ==> (this != null);
    assert {:msg "  222.28: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  222.41: Fraction might be negative."} 0 <= 50;
    assert {:msg "  222.41: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.parent] != null;
    Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.right] := inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.right];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.right] == null) || (dtype(Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.right]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.right] := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.right][perm$R := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.right][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.right]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_340, Mask);
  } else {
  }
  assert {:msg "  223.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  223.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  223.26: Receiver might be null."} true ==> (this != null);
    assert {:msg "  223.26: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  223.26: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.parent] != null);
    assert {:msg "  223.26: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown);
    assert {:msg "  223.45: Receiver might be null."} true ==> (this != null);
    assert {:msg "  223.45: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  223.45: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.parent] != null);
    assert {:msg "  223.45: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.parent], AVLTreeNode.right);
    assume (!Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.leftDown]) <==> (Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.right] == this);
  } else {
  }
  assert {:msg "  224.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  224.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  224.28: Receiver might be null."} true ==> (this != null);
    assert {:msg "  224.28: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  224.40: Fraction might be negative."} 0 <= 50;
    assert {:msg "  224.40: Fraction might exceed 100."} 50 <= 100;
    assume Heap[this, AVLTreeNode.parent] != null;
    Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.root] := inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.root];
    assume wf(Heap, Mask);
    assume (Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.root] == null) || (dtype(Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.root]) == AVLTreeNode#t);
    Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.root] := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.root][perm$R := Mask[Heap[this, AVLTreeNode.parent], AVLTreeNode.root][perm$R] + 50];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_340[Heap[this, AVLTreeNode.parent], AVLTreeNode.root]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_340, Mask);
  } else {
  }
  assert {:msg "  225.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  225.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (!(Heap[this, AVLTreeNode.parent] == null)) {
    assert {:msg "  225.24: Receiver might be null."} true ==> (this != null);
    assert {:msg "  225.24: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.root);
    assert {:msg "  225.30: Receiver might be null."} true ==> (this != null);
    assert {:msg "  225.30: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
    assert {:msg "  225.30: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.parent] != null);
    assert {:msg "  225.30: Location might not be readable."} true ==> CanRead(Mask, Heap[this, AVLTreeNode.parent], AVLTreeNode.root);
    assume Heap[this, AVLTreeNode.root] == Heap[Heap[this, AVLTreeNode.parent], AVLTreeNode.root];
  } else {
  }
  assert {:msg "  226.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  226.7: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.parent);
  if (Heap[this, AVLTreeNode.parent] == null) {
    assert {:msg "  226.24: Receiver might be null."} true ==> (this != null);
    assert {:msg "  226.24: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.root);
    assume Heap[this, AVLTreeNode.root] == this;
  } else {
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
const unique AVLTreeNode.udValid: Field (HeapType);
axiom PredicateField(AVLTreeNode.udValid);
procedure AVLTreeNode.udValid$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_341: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (predicate definition)
  havoc inhaleHeap#_341;
  assume IsGoodInhaleState(inhaleHeap#_341, Heap, Mask);
  assert {:msg "  230.17: Fraction might be negative."} 0 <= 100;
  assert {:msg "  230.17: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.key] := inhaleHeap#_341[this, AVLTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.key] := Mask[this, AVLTreeNode.key][perm$R := Mask[this, AVLTreeNode.key][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_341, Mask);
  assert {:msg "  231.19: Fraction might be negative."} 0 <= 50;
  assert {:msg "  231.19: Fraction might exceed 100."} 50 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.leftDown] := inhaleHeap#_341[this, AVLTreeNode.leftDown];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.leftDown] := Mask[this, AVLTreeNode.leftDown][perm$R := Mask[this, AVLTreeNode.leftDown][perm$R] + 50];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.leftDown]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_341, Mask);
  assert {:msg "  232.17: Fraction might be negative."} 0 <= 25;
  assert {:msg "  232.17: Fraction might exceed 100."} 25 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.left] := inhaleHeap#_341[this, AVLTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.left] == null) || (dtype(Heap[this, AVLTreeNode.left]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.left] := Mask[this, AVLTreeNode.left][perm$R := Mask[this, AVLTreeNode.left][perm$R] + 25];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_341, Mask);
  assert {:msg "  233.17: Fraction might be negative."} 0 <= 25;
  assert {:msg "  233.17: Fraction might exceed 100."} 25 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.right] := inhaleHeap#_341[this, AVLTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.right] == null) || (dtype(Heap[this, AVLTreeNode.right]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.right] := Mask[this, AVLTreeNode.right][perm$R := Mask[this, AVLTreeNode.right][perm$R] + 25];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_341, Mask);
  assert {:msg "  235.16: Fraction might be negative."} 0 <= 20;
  assert {:msg "  235.16: Fraction might exceed 100."} 20 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_341[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 20];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_341, Mask);
  assert {:msg "  236.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  236.8: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.leftDown);
  if (Heap[this, AVLTreeNode.leftDown]) {
    assume this != null;
    Heap[this, AVLTreeNode.rightValid] := inhaleHeap#_341[this, AVLTreeNode.rightValid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_341[this, AVLTreeNode.rightValid] == Heap;
    Mask[this, AVLTreeNode.rightValid] := Mask[this, AVLTreeNode.rightValid][perm$R := Mask[this, AVLTreeNode.rightValid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.rightValid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_341, Mask);
  } else {
  }
  assert {:msg "  237.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  237.8: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.leftDown);
  if (Heap[this, AVLTreeNode.leftDown]) {
    assume this != null;
    Heap[this, AVLTreeNode.leftOpen] := inhaleHeap#_341[this, AVLTreeNode.leftOpen];
    assume wf(Heap, Mask);
    assume inhaleHeap#_341[this, AVLTreeNode.leftOpen] == Heap;
    Mask[this, AVLTreeNode.leftOpen] := Mask[this, AVLTreeNode.leftOpen][perm$R := Mask[this, AVLTreeNode.leftOpen][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.leftOpen]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_341, Mask);
  } else {
  }
  assert {:msg "  238.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  238.8: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.leftDown);
  if (!Heap[this, AVLTreeNode.leftDown]) {
    assume this != null;
    Heap[this, AVLTreeNode.leftValid] := inhaleHeap#_341[this, AVLTreeNode.leftValid];
    assume wf(Heap, Mask);
    assume inhaleHeap#_341[this, AVLTreeNode.leftValid] == Heap;
    Mask[this, AVLTreeNode.leftValid] := Mask[this, AVLTreeNode.leftValid][perm$R := Mask[this, AVLTreeNode.leftValid][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.leftValid]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_341, Mask);
  } else {
  }
  assert {:msg "  239.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  239.8: Location might not be readable."} true ==> CanRead(Mask, this, AVLTreeNode.leftDown);
  if (!Heap[this, AVLTreeNode.leftDown]) {
    assume this != null;
    Heap[this, AVLTreeNode.rightOpen] := inhaleHeap#_341[this, AVLTreeNode.rightOpen];
    assume wf(Heap, Mask);
    assume inhaleHeap#_341[this, AVLTreeNode.rightOpen] == Heap;
    Mask[this, AVLTreeNode.rightOpen] := Mask[this, AVLTreeNode.rightOpen][perm$R := Mask[this, AVLTreeNode.rightOpen][perm$R] + 100];
    assume IsGoodMask(Mask);
    assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.rightOpen]);
    assume wf(Heap, Mask);
    assume wf(inhaleHeap#_341, Mask);
  } else {
  }
  assume this != null;
  Heap[this, AVLTreeNode.udParentValid] := inhaleHeap#_341[this, AVLTreeNode.udParentValid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_341[this, AVLTreeNode.udParentValid] == Heap;
  Mask[this, AVLTreeNode.udParentValid] := Mask[this, AVLTreeNode.udParentValid][perm$R := Mask[this, AVLTreeNode.udParentValid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_341[this, AVLTreeNode.udParentValid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_341, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure AVLTreeNode.init$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t), k#12: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_342: HeapType;
  var inhaleHeap#_343: HeapType;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  assume CanAssumeFunctionDefs;
  // inhale (precondition)
  havoc inhaleHeap#_342;
  assume IsGoodInhaleState(inhaleHeap#_342, Heap, Mask);
  assert {:msg "  246.23: Fraction might be negative."} 0 <= 100;
  assert {:msg "  246.23: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.key] := inhaleHeap#_342[this, AVLTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.key] := Mask[this, AVLTreeNode.key][perm$R := Mask[this, AVLTreeNode.key][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_342[this, AVLTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_342, Mask);
  assert {:msg "  248.23: Fraction might be negative."} 0 <= 100;
  assert {:msg "  248.23: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.left] := inhaleHeap#_342[this, AVLTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.left] == null) || (dtype(Heap[this, AVLTreeNode.left]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.left] := Mask[this, AVLTreeNode.left][perm$R := Mask[this, AVLTreeNode.left][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_342[this, AVLTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_342, Mask);
  assert {:msg "  249.23: Fraction might be negative."} 0 <= 100;
  assert {:msg "  249.23: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.right] := inhaleHeap#_342[this, AVLTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.right] == null) || (dtype(Heap[this, AVLTreeNode.right]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.right] := Mask[this, AVLTreeNode.right][perm$R := Mask[this, AVLTreeNode.right][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_342[this, AVLTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_342, Mask);
  assert {:msg "  251.26: Fraction might be negative."} 0 <= 100;
  assert {:msg "  251.26: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.leftDown] := inhaleHeap#_342[this, AVLTreeNode.leftDown];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.leftDown] := Mask[this, AVLTreeNode.leftDown][perm$R := Mask[this, AVLTreeNode.leftDown][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_342[this, AVLTreeNode.leftDown]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_342, Mask);
  assert {:msg "  252.26: Fraction might be negative."} 0 <= 100;
  assert {:msg "  252.26: Fraction might exceed 100."} 100 <= 100;
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_342[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_342[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_342, Mask);
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
  havoc inhaleHeap#_343;
  assume IsGoodInhaleState(inhaleHeap#_343, Heap, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.valid] := inhaleHeap#_343[this, AVLTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_343[this, AVLTreeNode.valid] == Heap;
  Mask[this, AVLTreeNode.valid] := Mask[this, AVLTreeNode.valid][perm$R := Mask[this, AVLTreeNode.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_343[this, AVLTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_343, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
}
procedure AVLTreeNode.init(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t), k#12: int where true) returns ()
  modifies Heap, Mask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask);
{
  var inhaleHeap#_344: HeapType;
  var exhaleMask#_345: MaskType;
  var fraction#_346: int;
  var fraction#_347: int;
  var fraction#_348: int;
  var fraction#_349: int;
  var fraction#_350: int;
  var inhaleHeap#_351: HeapType;
  var exhaleMask#_352: MaskType;
  var fraction#_353: int;
  var fraction#_354: int;
  var fraction#_355: int;
  var fraction#_356: int;
  var fraction#_357: int;
  var inhaleHeap#_358: HeapType;
  var exhaleMask#_359: MaskType;
  var fraction#_360: int;
  var fraction#_361: int;
  var fraction#_362: int;
  var fraction#_363: int;
  var fraction#_364: int;
  var inhaleHeap#_365: HeapType;
  var exhaleMask#_366: MaskType;
  var fraction#_367: int;
  var fraction#_368: int;
  var fraction#_369: int;
  var inhaleHeap#_370: HeapType;
  var exhaleMask#_371: MaskType;
  var fraction#_372: int;
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  havoc inhaleHeap#_344;
  assume IsGoodInhaleState(inhaleHeap#_344, Heap, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.key] := inhaleHeap#_344[this, AVLTreeNode.key];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.key] := Mask[this, AVLTreeNode.key][perm$R := Mask[this, AVLTreeNode.key][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_344[this, AVLTreeNode.key]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_344, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.left] := inhaleHeap#_344[this, AVLTreeNode.left];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.left] == null) || (dtype(Heap[this, AVLTreeNode.left]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.left] := Mask[this, AVLTreeNode.left][perm$R := Mask[this, AVLTreeNode.left][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_344[this, AVLTreeNode.left]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_344, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.right] := inhaleHeap#_344[this, AVLTreeNode.right];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.right] == null) || (dtype(Heap[this, AVLTreeNode.right]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.right] := Mask[this, AVLTreeNode.right][perm$R := Mask[this, AVLTreeNode.right][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_344[this, AVLTreeNode.right]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_344, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.leftDown] := inhaleHeap#_344[this, AVLTreeNode.leftDown];
  assume wf(Heap, Mask);
  assume true;
  Mask[this, AVLTreeNode.leftDown] := Mask[this, AVLTreeNode.leftDown][perm$R := Mask[this, AVLTreeNode.leftDown][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_344[this, AVLTreeNode.leftDown]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_344, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.root] := inhaleHeap#_344[this, AVLTreeNode.root];
  assume wf(Heap, Mask);
  assume (Heap[this, AVLTreeNode.root] == null) || (dtype(Heap[this, AVLTreeNode.root]) == AVLTreeNode#t);
  Mask[this, AVLTreeNode.root] := Mask[this, AVLTreeNode.root][perm$R := Mask[this, AVLTreeNode.root][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_344[this, AVLTreeNode.root]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_344, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume Credits == old(Credits);
  // update field left
  assert {:msg "  268.3: Location might not be writable"} CanWrite(Mask, this, AVLTreeNode.left);
  Heap[this, AVLTreeNode.left] := null;
  assume wf(Heap, Mask);
  // update field right
  assert {:msg "  269.3: Location might not be writable"} CanWrite(Mask, this, AVLTreeNode.right);
  Heap[this, AVLTreeNode.right] := null;
  assume wf(Heap, Mask);
  // update field key
  assert {:msg "  270.3: Location might not be writable"} CanWrite(Mask, this, AVLTreeNode.key);
  Heap[this, AVLTreeNode.key] := k#12;
  assume wf(Heap, Mask);
  // fold
  assert {:msg "  273.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_345 := Mask;
  fraction#_346 := 25;
  assert {:msg "  273.3: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 191.6 for AVLTreeNode.left."} (fraction#_346 <= exhaleMask#_345[this, AVLTreeNode.left][perm$R]) && ((fraction#_346 == exhaleMask#_345[this, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_345[this, AVLTreeNode.left][perm$N]));
  exhaleMask#_345[this, AVLTreeNode.left] := exhaleMask#_345[this, AVLTreeNode.left][perm$R := exhaleMask#_345[this, AVLTreeNode.left][perm$R] - fraction#_346];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_345);
  fraction#_347 := 10;
  assert {:msg "  273.3: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 192.6 for AVLTreeNode.root."} (fraction#_347 <= exhaleMask#_345[this, AVLTreeNode.root][perm$R]) && ((fraction#_347 == exhaleMask#_345[this, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_345[this, AVLTreeNode.root][perm$N]));
  exhaleMask#_345[this, AVLTreeNode.root] := exhaleMask#_345[this, AVLTreeNode.root][perm$R := exhaleMask#_345[this, AVLTreeNode.root][perm$R] - fraction#_347];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_345);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    fraction#_348 := 100;
    assert {:msg "  273.3: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 193.22 for AVLTreeNode.valid."} (fraction#_348 <= exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((fraction#_348 == exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
    exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - fraction#_348];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_345);
  } else {
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    fraction#_349 := 100;
    assert {:msg "  273.3: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 194.22 for AVLTreeNode.parent."} (fraction#_349 <= exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R]) && ((fraction#_349 == exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$N]));
    exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] := exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R := exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.parent][perm$R] - fraction#_349];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_345);
  } else {
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  273.3: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. The expression at 195.22 might not evaluate to true."} Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.parent] == this;
  } else {
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    fraction#_350 := 50;
    assert {:msg "  273.3: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. Insufficient fraction at 196.22 for AVLTreeNode.root."} (fraction#_350 <= exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.root][perm$R]) && ((fraction#_350 == exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.root][perm$N]));
    exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.root] := exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.root][perm$R := exhaleMask#_345[Heap[this, AVLTreeNode.left], AVLTreeNode.root][perm$R] - fraction#_350];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_345);
  } else {
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assert {:msg "  273.3: Fold might fail because the definition of AVLTreeNode.leftValid does not hold. The expression at 197.22 might not evaluate to true."} Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.root] == Heap[this, AVLTreeNode.root];
  } else {
  }
  Mask := exhaleMask#_345;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_351;
  assume IsGoodInhaleState(inhaleHeap#_351, Heap, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.leftValid] := inhaleHeap#_351[this, AVLTreeNode.leftValid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_351[this, AVLTreeNode.leftValid] == Heap;
  Mask[this, AVLTreeNode.leftValid] := Mask[this, AVLTreeNode.leftValid][perm$R := Mask[this, AVLTreeNode.leftValid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_351[this, AVLTreeNode.leftValid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_351, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, AVLTreeNode.leftValid] := Heap;
  assume wf(Heap, Mask);
  // fold
  assert {:msg "  274.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_352 := Mask;
  fraction#_353 := 25;
  assert {:msg "  274.3: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 182.6 for AVLTreeNode.right."} (fraction#_353 <= exhaleMask#_352[this, AVLTreeNode.right][perm$R]) && ((fraction#_353 == exhaleMask#_352[this, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_352[this, AVLTreeNode.right][perm$N]));
  exhaleMask#_352[this, AVLTreeNode.right] := exhaleMask#_352[this, AVLTreeNode.right][perm$R := exhaleMask#_352[this, AVLTreeNode.right][perm$R] - fraction#_353];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_352);
  fraction#_354 := 10;
  assert {:msg "  274.3: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 183.6 for AVLTreeNode.root."} (fraction#_354 <= exhaleMask#_352[this, AVLTreeNode.root][perm$R]) && ((fraction#_354 == exhaleMask#_352[this, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_352[this, AVLTreeNode.root][perm$N]));
  exhaleMask#_352[this, AVLTreeNode.root] := exhaleMask#_352[this, AVLTreeNode.root][perm$R := exhaleMask#_352[this, AVLTreeNode.root][perm$R] - fraction#_354];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_352);
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    fraction#_355 := 100;
    assert {:msg "  274.3: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 184.23 for AVLTreeNode.valid."} (fraction#_355 <= exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((fraction#_355 == exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
    exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - fraction#_355];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_352);
  } else {
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    fraction#_356 := 100;
    assert {:msg "  274.3: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 185.23 for AVLTreeNode.parent."} (fraction#_356 <= exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R]) && ((fraction#_356 == exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R]) ==> (0 <= exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$N]));
    exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] := exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R := exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.parent][perm$R] - fraction#_356];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_352);
  } else {
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  274.3: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. The expression at 186.23 might not evaluate to true."} Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.parent] == this;
  } else {
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    fraction#_357 := 50;
    assert {:msg "  274.3: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. Insufficient fraction at 187.23 for AVLTreeNode.root."} (fraction#_357 <= exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.root][perm$R]) && ((fraction#_357 == exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.root][perm$N]));
    exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.root] := exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.root][perm$R := exhaleMask#_352[Heap[this, AVLTreeNode.right], AVLTreeNode.root][perm$R] - fraction#_357];
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask);
    assume wf(Heap, exhaleMask#_352);
  } else {
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assert {:msg "  274.3: Fold might fail because the definition of AVLTreeNode.rightValid does not hold. The expression at 188.23 might not evaluate to true."} Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.root] == Heap[this, AVLTreeNode.root];
  } else {
  }
  Mask := exhaleMask#_352;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_358;
  assume IsGoodInhaleState(inhaleHeap#_358, Heap, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.rightValid] := inhaleHeap#_358[this, AVLTreeNode.rightValid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_358[this, AVLTreeNode.rightValid] == Heap;
  Mask[this, AVLTreeNode.rightValid] := Mask[this, AVLTreeNode.rightValid][perm$R := Mask[this, AVLTreeNode.rightValid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_358[this, AVLTreeNode.rightValid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_358, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, AVLTreeNode.rightValid] := Heap;
  assume wf(Heap, Mask);
  // fold
  assert {:msg "  275.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_359 := Mask;
  fraction#_360 := 100;
  assert {:msg "  275.3: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 172.6 for AVLTreeNode.key."} (fraction#_360 <= exhaleMask#_359[this, AVLTreeNode.key][perm$R]) && ((fraction#_360 == exhaleMask#_359[this, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_359[this, AVLTreeNode.key][perm$N]));
  exhaleMask#_359[this, AVLTreeNode.key] := exhaleMask#_359[this, AVLTreeNode.key][perm$R := exhaleMask#_359[this, AVLTreeNode.key][perm$R] - fraction#_360];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_359);
  fraction#_361 := 30;
  assert {:msg "  275.3: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 173.6 for AVLTreeNode.root."} (fraction#_361 <= exhaleMask#_359[this, AVLTreeNode.root][perm$R]) && ((fraction#_361 == exhaleMask#_359[this, AVLTreeNode.root][perm$R]) ==> (0 <= exhaleMask#_359[this, AVLTreeNode.root][perm$N]));
  exhaleMask#_359[this, AVLTreeNode.root] := exhaleMask#_359[this, AVLTreeNode.root][perm$R := exhaleMask#_359[this, AVLTreeNode.root][perm$R] - fraction#_361];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_359);
  fraction#_362 := 75;
  assert {:msg "  275.3: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 174.6 for AVLTreeNode.left."} (fraction#_362 <= exhaleMask#_359[this, AVLTreeNode.left][perm$R]) && ((fraction#_362 == exhaleMask#_359[this, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_359[this, AVLTreeNode.left][perm$N]));
  exhaleMask#_359[this, AVLTreeNode.left] := exhaleMask#_359[this, AVLTreeNode.left][perm$R := exhaleMask#_359[this, AVLTreeNode.left][perm$R] - fraction#_362];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_359);
  fraction#_363 := 75;
  assert {:msg "  275.3: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 175.6 for AVLTreeNode.right."} (fraction#_363 <= exhaleMask#_359[this, AVLTreeNode.right][perm$R]) && ((fraction#_363 == exhaleMask#_359[this, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_359[this, AVLTreeNode.right][perm$N]));
  exhaleMask#_359[this, AVLTreeNode.right] := exhaleMask#_359[this, AVLTreeNode.right][perm$R := exhaleMask#_359[this, AVLTreeNode.right][perm$R] - fraction#_363];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_359);
  fraction#_364 := 100;
  assert {:msg "  275.3: Fold might fail because the definition of AVLTreeNode.validRest does not hold. Insufficient fraction at 176.6 for AVLTreeNode.leftDown."} (fraction#_364 <= exhaleMask#_359[this, AVLTreeNode.leftDown][perm$R]) && ((fraction#_364 == exhaleMask#_359[this, AVLTreeNode.leftDown][perm$R]) ==> (0 <= exhaleMask#_359[this, AVLTreeNode.leftDown][perm$N]));
  exhaleMask#_359[this, AVLTreeNode.leftDown] := exhaleMask#_359[this, AVLTreeNode.leftDown][perm$R := exhaleMask#_359[this, AVLTreeNode.leftDown][perm$R] - fraction#_364];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_359);
  assert {:msg "  275.3: Fold might fail because the definition of AVLTreeNode.validRest does not hold. The expression at 177.7 might not evaluate to true."} (!(Heap[this, AVLTreeNode.right] == Heap[this, AVLTreeNode.left])) || (Heap[this, AVLTreeNode.right] == null);
  Mask := exhaleMask#_359;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_365;
  assume IsGoodInhaleState(inhaleHeap#_365, Heap, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.validRest] := inhaleHeap#_365[this, AVLTreeNode.validRest];
  assume wf(Heap, Mask);
  assume inhaleHeap#_365[this, AVLTreeNode.validRest] == Heap;
  Mask[this, AVLTreeNode.validRest] := Mask[this, AVLTreeNode.validRest][perm$R := Mask[this, AVLTreeNode.validRest][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_365[this, AVLTreeNode.validRest]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_365, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, AVLTreeNode.validRest] := Heap;
  assume wf(Heap, Mask);
  // fold
  assert {:msg "  276.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_366 := Mask;
  fraction#_367 := 100;
  assert {:msg "  276.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 165.6 for AVLTreeNode.validRest."} (fraction#_367 <= exhaleMask#_366[this, AVLTreeNode.validRest][perm$R]) && ((fraction#_367 == exhaleMask#_366[this, AVLTreeNode.validRest][perm$R]) ==> (0 <= exhaleMask#_366[this, AVLTreeNode.validRest][perm$N]));
  exhaleMask#_366[this, AVLTreeNode.validRest] := exhaleMask#_366[this, AVLTreeNode.validRest][perm$R := exhaleMask#_366[this, AVLTreeNode.validRest][perm$R] - fraction#_367];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_366);
  fraction#_368 := 100;
  assert {:msg "  276.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 166.6 for AVLTreeNode.leftValid."} (fraction#_368 <= exhaleMask#_366[this, AVLTreeNode.leftValid][perm$R]) && ((fraction#_368 == exhaleMask#_366[this, AVLTreeNode.leftValid][perm$R]) ==> (0 <= exhaleMask#_366[this, AVLTreeNode.leftValid][perm$N]));
  exhaleMask#_366[this, AVLTreeNode.leftValid] := exhaleMask#_366[this, AVLTreeNode.leftValid][perm$R := exhaleMask#_366[this, AVLTreeNode.leftValid][perm$R] - fraction#_368];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_366);
  fraction#_369 := 100;
  assert {:msg "  276.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 167.6 for AVLTreeNode.rightValid."} (fraction#_369 <= exhaleMask#_366[this, AVLTreeNode.rightValid][perm$R]) && ((fraction#_369 == exhaleMask#_366[this, AVLTreeNode.rightValid][perm$R]) ==> (0 <= exhaleMask#_366[this, AVLTreeNode.rightValid][perm$N]));
  exhaleMask#_366[this, AVLTreeNode.rightValid] := exhaleMask#_366[this, AVLTreeNode.rightValid][perm$R := exhaleMask#_366[this, AVLTreeNode.rightValid][perm$R] - fraction#_369];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_366);
  Mask := exhaleMask#_366;
  assume wf(Heap, Mask);
  // end exhale
  // inhale (fold)
  havoc inhaleHeap#_370;
  assume IsGoodInhaleState(inhaleHeap#_370, Heap, Mask);
  assume this != null;
  Heap[this, AVLTreeNode.valid] := inhaleHeap#_370[this, AVLTreeNode.valid];
  assume wf(Heap, Mask);
  assume inhaleHeap#_370[this, AVLTreeNode.valid] == Heap;
  Mask[this, AVLTreeNode.valid] := Mask[this, AVLTreeNode.valid][perm$R := Mask[this, AVLTreeNode.valid][perm$R] + 100];
  assume IsGoodMask(Mask);
  assume IsGoodState(inhaleHeap#_370[this, AVLTreeNode.valid]);
  assume wf(Heap, Mask);
  assume wf(inhaleHeap#_370, Mask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  // end inhale
  Heap[this, AVLTreeNode.valid] := Heap;
  assume wf(Heap, Mask);
  // begin exhale (postcondition)
  exhaleMask#_371 := Mask;
  fraction#_372 := 100;
  assert {:msg "  245.2: The postcondition at 257.11 might not hold. Insufficient fraction at 257.11 for AVLTreeNode.valid."} (fraction#_372 <= exhaleMask#_371[this, AVLTreeNode.valid][perm$R]) && ((fraction#_372 == exhaleMask#_371[this, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_371[this, AVLTreeNode.valid][perm$N]));
  exhaleMask#_371[this, AVLTreeNode.valid] := exhaleMask#_371[this, AVLTreeNode.valid][perm$R := exhaleMask#_371[this, AVLTreeNode.valid][perm$R] - fraction#_372];
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask);
  assume wf(Heap, exhaleMask#_371);
  Mask := exhaleMask#_371;
  assume wf(Heap, Mask);
  // end exhale
  assert {:msg "  245.2: Method might lock/unlock more than allowed."} (forall lk#_373: ref :: {Heap[lk#_373, held]} {Heap[lk#_373, rdheld]} (((0 < Heap[lk#_373, held]) == (0 < old(Heap)[lk#_373, held])) && (Heap[lk#_373, rdheld] == old(Heap)[lk#_373, rdheld])) || false);
  assert {:msg "  245.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
