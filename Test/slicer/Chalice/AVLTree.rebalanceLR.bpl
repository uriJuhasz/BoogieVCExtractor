
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

function /*{:expand false}*/ CanRead<T>(m: MaskType, sm: MaskType, obj: ref, f: Field T) returns (bool)
{
  0 <  m[obj,f][perm$R] || 0 <  m[obj,f][perm$N] ||
  0 < sm[obj,f][perm$R] || 0 < sm[obj,f][perm$N]
}
function /*{:expand false}*/ CanReadForSure<T>(m: MaskType, obj: ref, f: Field T) returns (bool)
{
  0 < m[obj,f][perm$R] || 0 < m[obj,f][perm$N]
}
function /*{:expand false}*/ CanWrite<T>(m: MaskType, obj: ref, f: Field T) returns (bool)
{
  m[obj,f][perm$R] == Permission$FullFraction && m[obj,f][perm$N] == 0
}
function /*{:expand true}*/ IsGoodMask(m: MaskType) returns (bool)
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

// the connection between % and /
//axiom (forall x:int, y:int :: {x % y} {x / y}  x % y == x - x / y * y);

// sign of denominator determines sign of remainder
//axiom (forall x:int, y:int :: {x % y}  0 < y  ==>  0 <= x % y  &&  x % y < y);
//axiom (forall x:int, y:int :: {x % y}  y < 0  ==>  y < x % y  &&  x % y <= 0);

// the following axiom has some unfortunate matching, but it does state a property about % that
// is sometime useful
//axiom (forall a: int, b: int, d: int :: { a % d, b % d } 2 <= d && a % d == b % d && a < b  ==>  a + d <= b);

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

const unique AVLTree#t: TypeName;
const unique module#default: ModuleName;
const unique AVLTree.root: Field (ref);
axiom NonPredicateField(AVLTree.root);
const unique AVLTree.keys: Field (Seq (int));
axiom NonPredicateField(AVLTree.keys);
const unique AVLTree.valid: Field (int);
axiom PredicateField(AVLTree.valid);
function #AVLTree.valid#trigger(this: ref) returns ($myresult: bool);
const unique AVLTreeNode#t: TypeName;
const unique AVLTreeNode.key: Field (int);
axiom NonPredicateField(AVLTreeNode.key);
const unique AVLTreeNode.height: Field (int);
axiom NonPredicateField(AVLTreeNode.height);
const unique AVLTreeNode.left: Field (ref);
axiom NonPredicateField(AVLTreeNode.left);
const unique AVLTreeNode.right: Field (ref);
axiom NonPredicateField(AVLTreeNode.right);
const unique AVLTreeNode.keys: Field (Seq (int));
axiom NonPredicateField(AVLTreeNode.keys);
const unique AVLTreeNode.balanceFactor: Field (int);
axiom NonPredicateField(AVLTreeNode.balanceFactor);
const unique AVLTreeNode.valid: Field (int);
axiom PredicateField(AVLTreeNode.valid);
function #AVLTreeNode.valid#trigger(this: ref) returns ($myresult: bool);
procedure AVLTreeNode.init(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t), k#8: int where true) returns ();
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.insert(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t), k#9: int where true) returns (r#10: ref where (r#10 == null) || (dtype(r#10) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.remove(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t), k#19: int where true) returns (r#20: ref where (r#20 == null) || (dtype(r#20) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.pruneMax(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#35: ref where (r#35 == null) || (dtype(r#35) == AVLTreeNode#t), m#36: ref where (m#36 == null) || (dtype(m#36) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
  var methodK#_923: int;
procedure AVLTreeNode.pruneMin(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#41: ref where (r#41 == null) || (dtype(r#41) == AVLTreeNode#t), m#42: ref where (m#42 == null) || (dtype(m#42) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.has(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t), k#47: int where true) returns (b#48: bool where true);
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.getBalanceFactor(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (bf#49: int where true);
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.getBalanceFactorI$checkDefinedness(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (bf#54: int where true);
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.getBalanceFactorI(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (bf#54: int where true);
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.close(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns ();
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceLeft(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#63: ref where (r#63 == null) || (dtype(r#63) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceRL(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#66: ref where (r#66 == null) || (dtype(r#66) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceRR(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#67: ref where (r#67 == null) || (dtype(r#67) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceRight(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#68: ref where (r#68 == null) || (dtype(r#68) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceLR(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#71: ref where (r#71 == null) || (dtype(r#71) == AVLTreeNode#t))
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var methodK#_2935: int;
  var predRec#_2982: ref;
  var predFlag#_2984: bool;
  var predVer#_2983: int;
  var assertHeap#_3001: HeapType;
  var assertMask#_3002: MaskType;
  var assertSecMask#_3003: MaskType;
  var assertCredits#_3004: CreditsType;
  var exhaleMask#_3006: MaskType;
  var exhaleHeap#_3005: HeapType;
  var k#108#861: int where true;
  var unfoldK#_3007: int;
  var oldVers#_3027: int;
  var newVers#_3028: int;
  var assertHeap#_3029: HeapType;
  var assertMask#_3030: MaskType;
  var assertSecMask#_3031: MaskType;
  var assertCredits#_3032: CreditsType;
  var exhaleMask#_3034: MaskType;
  var exhaleHeap#_3033: HeapType;
  var k#109#870: int where true;
  var unfoldK#_3035: int;
  var oldVers#_3055: int;
  var newVers#_3056: int;
  var assertHeap#_3057: HeapType;
  var assertMask#_3058: MaskType;
  var assertSecMask#_3059: MaskType;
  var assertCredits#_3060: CreditsType;
  var exhaleMask#_3062: MaskType;
  var exhaleHeap#_3061: HeapType;
  var k#110#879: int where true;
  var methodCallK#_3067: int;
  var this#881: ref where (this#881 == null) || (dtype(this#881) == AVLTreeNode#t);
  var callHeap#_3063: HeapType;
  var callMask#_3064: MaskType;
  var callSecMask#_3065: MaskType;
  var callCredits#_3066: CreditsType;
  var exhaleMask#_3069: MaskType;
  var exhaleHeap#_3068: HeapType;
  var isHeld#_3116: int;
  var isRdHeld#_3117: bool;
  var assertHeap#_3118: HeapType;
  var assertMask#_3119: MaskType;
  var assertSecMask#_3120: MaskType;
  var assertCredits#_3121: CreditsType;
  var exhaleMask#_3123: MaskType;
  var exhaleHeap#_3122: HeapType;
  var k#111#895: int where true;
  var methodCallK#_3128: int;
  var this#897: ref where (this#897 == null) || (dtype(this#897) == AVLTreeNode#t);
  var callHeap#_3124: HeapType;
  var callMask#_3125: MaskType;
  var callSecMask#_3126: MaskType;
  var callCredits#_3127: CreditsType;
  var exhaleMask#_3130: MaskType;
  var exhaleHeap#_3129: HeapType;
  var isHeld#_3177: int;
  var isRdHeld#_3178: bool;
  var methodCallK#_3183: int;
  var this#910: ref where (this#910 == null) || (dtype(this#910) == AVLTreeNode#t);
  var callHeap#_3179: HeapType;
  var callMask#_3180: MaskType;
  var callSecMask#_3181: MaskType;
  var callCredits#_3182: CreditsType;
  var exhaleMask#_3185: MaskType;
  var exhaleHeap#_3184: HeapType;
  var isHeld#_3232: int;
  var isRdHeld#_3233: bool;
  var exhaleMask#_3235: MaskType;
  var exhaleHeap#_3234: HeapType;
  assume (0 < methodK#_2935) && ((1000 * methodK#_2935) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, AVLTreeNode.key] := Mask[this, AVLTreeNode.key][perm$R := Mask[this, AVLTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.key]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, AVLTreeNode.height] := Mask[this, AVLTreeNode.height][perm$R := Mask[this, AVLTreeNode.height][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, AVLTreeNode.left] == null) || (dtype(Heap[this, AVLTreeNode.left]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, AVLTreeNode.left] := Mask[this, AVLTreeNode.left][perm$R := Mask[this, AVLTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.left]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, AVLTreeNode.right] == null) || (dtype(Heap[this, AVLTreeNode.right]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, AVLTreeNode.right] := Mask[this, AVLTreeNode.right][perm$R := Mask[this, AVLTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.right]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, AVLTreeNode.keys] := Mask[this, AVLTreeNode.keys][perm$R := Mask[this, AVLTreeNode.keys][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[this, AVLTreeNode.balanceFactor] := Mask[this, AVLTreeNode.balanceFactor][perm$R := Mask[this, AVLTreeNode.balanceFactor][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assume Heap[this, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assume Heap[this, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assume Heap[this, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assume Heap[this, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assume (forall k#106#852: int :: (0 <= k#106#852) && (k#106#852 < Seq#Length(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], k#106#852) < Heap[this, AVLTreeNode.key]));
  }
  assume !(Heap[this, AVLTreeNode.right] == null);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume (forall k#107#853: int :: (0 <= k#107#853) && (k#107#853 < Seq#Length(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this, AVLTreeNode.key] < Seq#Index(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], k#107#853)));
  predRec#_2982 := Heap[this, AVLTreeNode.right];
  predFlag#_2984 := true;
  assume #AVLTreeNode.valid#trigger(Heap[this, AVLTreeNode.right]);
  predVer#_2983 := Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid];
  if (false) {
    // begin exhale (update SecMask)
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#854: int :: (0 <= lk#79#854) && (lk#79#854 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#854) < Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key]));
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#855: int :: (0 <= rk#80#855) && (rk#80#855 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#855)));
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  assume predRec#_2982 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  SecMask[predRec#_2982, AVLTreeNode.key] := SecMask[predRec#_2982, AVLTreeNode.key][perm$R := SecMask[predRec#_2982, AVLTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2982, AVLTreeNode.key]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2982 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  SecMask[predRec#_2982, AVLTreeNode.height] := SecMask[predRec#_2982, AVLTreeNode.height][perm$R := SecMask[predRec#_2982, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2982, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2982 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[predRec#_2982, AVLTreeNode.left] == null) || (dtype(Heap[predRec#_2982, AVLTreeNode.left]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  SecMask[predRec#_2982, AVLTreeNode.left] := SecMask[predRec#_2982, AVLTreeNode.left][perm$R := SecMask[predRec#_2982, AVLTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2982, AVLTreeNode.left]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2982 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[predRec#_2982, AVLTreeNode.right] == null) || (dtype(Heap[predRec#_2982, AVLTreeNode.right]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  SecMask[predRec#_2982, AVLTreeNode.right] := SecMask[predRec#_2982, AVLTreeNode.right][perm$R := SecMask[predRec#_2982, AVLTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2982, AVLTreeNode.right]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2982 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  SecMask[predRec#_2982, AVLTreeNode.keys] := SecMask[predRec#_2982, AVLTreeNode.keys][perm$R := SecMask[predRec#_2982, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2982, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2982 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  SecMask[predRec#_2982, AVLTreeNode.balanceFactor] := SecMask[predRec#_2982, AVLTreeNode.balanceFactor][perm$R := SecMask[predRec#_2982, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2982, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[predRec#_2982, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.left] == null)) {
    assume (forall lk#79#858: int :: (0 <= lk#79#858) && (lk#79#858 < Seq#Length(Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys], lk#79#858) < Heap[predRec#_2982, AVLTreeNode.key]));
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.left] == null)) {
    assume Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height] > 0;
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2982, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.right] == null)) {
    assume (forall rk#80#859: int :: (0 <= rk#80#859) && (rk#80#859 < Seq#Length(Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[predRec#_2982, AVLTreeNode.key] < Seq#Index(Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys], rk#80#859)));
  }
  if (!(Heap[predRec#_2982, AVLTreeNode.right] == null)) {
    assume Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height] > 0;
  }
  assume Seq#Equal(Heap[predRec#_2982, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[predRec#_2982, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[predRec#_2982, AVLTreeNode.key])), ite(Heap[predRec#_2982, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Seq#Contains(Heap[predRec#_2982, AVLTreeNode.keys], Heap[predRec#_2982, AVLTreeNode.key]);
  assume (forall kk#81: int :: Seq#Contains(Heap[predRec#_2982, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[predRec#_2982, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[predRec#_2982, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[predRec#_2982, AVLTreeNode.key])));
  assume Heap[predRec#_2982, AVLTreeNode.height] == ite(ite(Heap[predRec#_2982, AVLTreeNode.left] == null, 0, Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[predRec#_2982, AVLTreeNode.right] == null, 0, Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[predRec#_2982, AVLTreeNode.left] == null, 0, Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[predRec#_2982, AVLTreeNode.right] == null, 0, Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[predRec#_2982, AVLTreeNode.balanceFactor] == (ite(Heap[predRec#_2982, AVLTreeNode.left] == null, 0, Heap[Heap[predRec#_2982, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[predRec#_2982, AVLTreeNode.right] == null, 0, Heap[Heap[predRec#_2982, AVLTreeNode.right], AVLTreeNode.height]));
  assume Heap[predRec#_2982, AVLTreeNode.balanceFactor] <= 1;
  assume Heap[predRec#_2982, AVLTreeNode.balanceFactor] >= (0 - 1);
  assume Heap[predRec#_2982, AVLTreeNode.height] > 0;
  assume !(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null);
  assume (ite(Heap[this, AVLTreeNode.left] == null, 0, Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]) - Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]) == (0 - 2);
  assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == 1;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume SecMask == old(SecMask);
  assume Credits == old(Credits);
  // assert
  assertHeap#_3001 := Heap;
  assertMask#_3002 := Mask;
  assertSecMask#_3003 := SecMask;
  assertCredits#_3004 := Credits;
  assume wf(assertHeap#_3001, assertMask#_3002, assertSecMask#_3003);
  // begin exhale (assert)
  exhaleMask#_3006 := assertMask#_3002;
  havoc exhaleHeap#_3005;
  assert {:msg "  826.10: Receiver might be null."} true && (0 <= k#108#861) ==> (this != null);
  assert {:msg "  826.10: Location might not be readable."} true && (0 <= k#108#861) ==> CanRead(assertMask#_3002, assertSecMask#_3003, this, AVLTreeNode.right);
  assert {:msg "  826.10: Receiver might be null."} true && (0 <= k#108#861) ==> (assertHeap#_3001[this, AVLTreeNode.right] != null);
  assert {:msg "  826.10: Location might not be readable."} true && (0 <= k#108#861) ==> CanRead(assertMask#_3002, assertSecMask#_3003, assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys);
  assert {:msg "  826.36: Receiver might be null."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (this != null);
  assert {:msg "  826.36: Location might not be readable."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_3002, assertSecMask#_3003, this, AVLTreeNode.key);
  assert {:msg "  826.10: Receiver might be null."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (this != null);
  assert {:msg "  826.10: Location might not be readable."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_3002, assertSecMask#_3003, this, AVLTreeNode.right);
  assert {:msg "  826.10: Receiver might be null."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_3001[this, AVLTreeNode.right] != null);
  assert {:msg "  826.10: Location might not be readable."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_3002, assertSecMask#_3003, assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys);
  assert {:msg "  826.42: Sequence index might be negative."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (0 <= k#108#861);
  assert {:msg "  826.42: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#108#861) && (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (k#108#861 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys]));
  assert {:msg "  826.3: Assertion might not hold. The expression at 826.10 might not evaluate to true."} (forall k#108#860: int :: (0 <= k#108#860) && (k#108#860 < Seq#Length(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_3001[this, AVLTreeNode.key] < Seq#Index(assertHeap#_3001[assertHeap#_3001[this, AVLTreeNode.right], AVLTreeNode.keys], k#108#860)));
  assertMask#_3002 := exhaleMask#_3006;
  assume IsGoodExhaleState(exhaleHeap#_3005, assertHeap#_3001, assertMask#_3002, assertSecMask#_3003);
  assertHeap#_3001 := exhaleHeap#_3005;
  assume IsGoodMask(assertMask#_3002);
  assume wf(assertHeap#_3001, assertMask#_3002, assertSecMask#_3003);
  // end exhale
  // unfold
  assume #AVLTreeNode.valid#trigger(Heap[this, AVLTreeNode.right]);
  assume (0 < unfoldK#_3007) && (unfoldK#_3007 < Fractions(1)) && ((1000 * unfoldK#_3007) < methodK#_2935);
  assert {:msg "  827.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  827.10: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
  assert {:msg "  827.3: The target of the fold statement might be null."} Heap[this, AVLTreeNode.right] != null;
  // begin exhale (unfold)
  assert {:msg "  827.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  827.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid."} (Fractions(100) <= Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
  if (false || ((predVer#_2983 == Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid]) && (predRec#_2982 == Heap[this, AVLTreeNode.right]) && true && predFlag#_2984)) {
    // begin exhale (update SecMask)
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#863: int :: (0 <= lk#79#863) && (lk#79#863 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#863) < Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key]));
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#864: int :: (0 <= rk#80#864) && (rk#80#864 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#864)));
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(Mask, SecMask, Heap[this, AVLTreeNode.right], AVLTreeNode.valid)) {
    oldVers#_3027 := Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid];
    havoc newVers#_3028;
    Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := newVers#_3028;
    assume oldVers#_3027 < Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid];
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (unfold)
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.key] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null) || (dtype(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.left] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null) || (dtype(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.right] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.right] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
    assume (forall lk#79#867: int :: (0 <= lk#79#867) && (lk#79#867 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#867) < Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key]));
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
    assume Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
    assume (forall rk#80#868: int :: (0 <= rk#80#868) && (rk#80#868 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#868)));
  }
  if (!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
    assume Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
  }
  assume Seq#Equal(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
  assume Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key]);
  assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.key])));
  assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
  assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
  assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
  assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // assigment to r
  assert {:msg "  828.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  828.8: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
  assert {:msg "  828.8: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.right] != null);
  assert {:msg "  828.8: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, AVLTreeNode.right], AVLTreeNode.left);
  r#71 := Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left];
  // assert
  assertHeap#_3029 := Heap;
  assertMask#_3030 := Mask;
  assertSecMask#_3031 := SecMask;
  assertCredits#_3032 := Credits;
  assume wf(assertHeap#_3029, assertMask#_3030, assertSecMask#_3031);
  // begin exhale (assert)
  exhaleMask#_3034 := assertMask#_3030;
  havoc exhaleHeap#_3033;
  assert {:msg "  829.10: Receiver might be null."} true && (0 <= k#109#870) ==> (r#71 != null);
  assert {:msg "  829.10: Location might not be readable."} true && (0 <= k#109#870) ==> CanRead(assertMask#_3030, assertSecMask#_3031, r#71, AVLTreeNode.keys);
  assert {:msg "  829.32: Receiver might be null."} true && (0 <= k#109#870) && (k#109#870 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys])) ==> (this != null);
  assert {:msg "  829.32: Location might not be readable."} true && (0 <= k#109#870) && (k#109#870 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys])) ==> CanRead(assertMask#_3030, assertSecMask#_3031, this, AVLTreeNode.key);
  assert {:msg "  829.10: Receiver might be null."} true && (0 <= k#109#870) && (k#109#870 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys])) ==> (r#71 != null);
  assert {:msg "  829.10: Location might not be readable."} true && (0 <= k#109#870) && (k#109#870 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys])) ==> CanRead(assertMask#_3030, assertSecMask#_3031, r#71, AVLTreeNode.keys);
  assert {:msg "  829.38: Sequence index might be negative."} true && (0 <= k#109#870) && (k#109#870 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys])) ==> (0 <= k#109#870);
  assert {:msg "  829.38: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#109#870) && (k#109#870 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys])) ==> (k#109#870 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys]));
  assert {:msg "  829.3: Assertion might not hold. The expression at 829.10 might not evaluate to true."} (forall k#109#869: int :: (0 <= k#109#869) && (k#109#869 < Seq#Length(assertHeap#_3029[r#71, AVLTreeNode.keys])) ==> (assertHeap#_3029[this, AVLTreeNode.key] < Seq#Index(assertHeap#_3029[r#71, AVLTreeNode.keys], k#109#869)));
  assertMask#_3030 := exhaleMask#_3034;
  assume IsGoodExhaleState(exhaleHeap#_3033, assertHeap#_3029, assertMask#_3030, assertSecMask#_3031);
  assertHeap#_3029 := exhaleHeap#_3033;
  assume IsGoodMask(assertMask#_3030);
  assume wf(assertHeap#_3029, assertMask#_3030, assertSecMask#_3031);
  // end exhale
  // unfold
  assume #AVLTreeNode.valid#trigger(r#71);
  assume (0 < unfoldK#_3035) && (unfoldK#_3035 < Fractions(1)) && ((1000 * unfoldK#_3035) < methodK#_2935);
  assert {:msg "  830.3: The target of the fold statement might be null."} r#71 != null;
  // begin exhale (unfold)
  assert {:msg "  830.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  830.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid."} (Fractions(100) <= Mask[r#71, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask[r#71, AVLTreeNode.valid][perm$R]) ==> (0 <= Mask[r#71, AVLTreeNode.valid][perm$N]));
  Mask[r#71, AVLTreeNode.valid] := Mask[r#71, AVLTreeNode.valid][perm$R := Mask[r#71, AVLTreeNode.valid][perm$R] - Fractions(100)];
  if (false || ((predVer#_2983 == Heap[r#71, AVLTreeNode.valid]) && (predRec#_2982 == r#71) && true && predFlag#_2984)) {
    // begin exhale (update SecMask)
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#872: int :: (0 <= lk#79#872) && (lk#79#872 < Seq#Length(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys], lk#79#872) < Heap[r#71, AVLTreeNode.key]));
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#873: int :: (0 <= rk#80#873) && (rk#80#873 < Seq#Length(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#71, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys], rk#80#873)));
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[r#71, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#71, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#71, AVLTreeNode.key])), ite(Heap[r#71, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[r#71, AVLTreeNode.keys], Heap[r#71, AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[r#71, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#71, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#71, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#71, AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.height] == ite(ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.balanceFactor] == (ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.height] > 0;
    SecMask[r#71, AVLTreeNode.key] := SecMask[r#71, AVLTreeNode.key][perm$R := SecMask[r#71, AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[r#71, AVLTreeNode.key][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.key] := SecMask[r#71, AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.height] := SecMask[r#71, AVLTreeNode.height][perm$R := SecMask[r#71, AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[r#71, AVLTreeNode.height][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.height] := SecMask[r#71, AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.left] := SecMask[r#71, AVLTreeNode.left][perm$R := SecMask[r#71, AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[r#71, AVLTreeNode.left][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.left] := SecMask[r#71, AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.right] := SecMask[r#71, AVLTreeNode.right][perm$R := SecMask[r#71, AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[r#71, AVLTreeNode.right][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.right] := SecMask[r#71, AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.keys] := SecMask[r#71, AVLTreeNode.keys][perm$R := SecMask[r#71, AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[r#71, AVLTreeNode.keys][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.keys] := SecMask[r#71, AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.balanceFactor] := SecMask[r#71, AVLTreeNode.balanceFactor][perm$R := SecMask[r#71, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[r#71, AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.balanceFactor] := SecMask[r#71, AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(Mask, SecMask, r#71, AVLTreeNode.valid)) {
    oldVers#_3055 := Heap[r#71, AVLTreeNode.valid];
    havoc newVers#_3056;
    Heap[r#71, AVLTreeNode.valid] := newVers#_3056;
    assume oldVers#_3055 < Heap[r#71, AVLTreeNode.valid];
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (unfold)
  assume r#71 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[r#71, AVLTreeNode.key] := Mask[r#71, AVLTreeNode.key][perm$R := Mask[r#71, AVLTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#71, AVLTreeNode.key]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#71 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[r#71, AVLTreeNode.height] := Mask[r#71, AVLTreeNode.height][perm$R := Mask[r#71, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#71, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#71 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[r#71, AVLTreeNode.left] == null) || (dtype(Heap[r#71, AVLTreeNode.left]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[r#71, AVLTreeNode.left] := Mask[r#71, AVLTreeNode.left][perm$R := Mask[r#71, AVLTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#71, AVLTreeNode.left]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#71 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[r#71, AVLTreeNode.right] == null) || (dtype(Heap[r#71, AVLTreeNode.right]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[r#71, AVLTreeNode.right] := Mask[r#71, AVLTreeNode.right][perm$R := Mask[r#71, AVLTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#71, AVLTreeNode.right]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#71 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[r#71, AVLTreeNode.keys] := Mask[r#71, AVLTreeNode.keys][perm$R := Mask[r#71, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#71, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#71 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[r#71, AVLTreeNode.balanceFactor] := Mask[r#71, AVLTreeNode.balanceFactor][perm$R := Mask[r#71, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#71, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[r#71, AVLTreeNode.left] == null)) {
    assume Heap[r#71, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.left] == null)) {
    assume Heap[r#71, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.left] == null)) {
    assume Heap[r#71, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.left] == null)) {
    assume Heap[r#71, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.left] == null)) {
    assume (forall lk#79#876: int :: (0 <= lk#79#876) && (lk#79#876 < Seq#Length(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys], lk#79#876) < Heap[r#71, AVLTreeNode.key]));
  }
  if (!(Heap[r#71, AVLTreeNode.left] == null)) {
    assume Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] > 0;
  }
  if (!(Heap[r#71, AVLTreeNode.right] == null)) {
    assume Heap[r#71, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.right] == null)) {
    assume Heap[r#71, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.right] == null)) {
    assume Heap[r#71, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.right] == null)) {
    assume Heap[r#71, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#71, AVLTreeNode.right] == null)) {
    assume (forall rk#80#877: int :: (0 <= rk#80#877) && (rk#80#877 < Seq#Length(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#71, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys], rk#80#877)));
  }
  if (!(Heap[r#71, AVLTreeNode.right] == null)) {
    assume Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] > 0;
  }
  assume Seq#Equal(Heap[r#71, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#71, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#71, AVLTreeNode.key])), ite(Heap[r#71, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Seq#Contains(Heap[r#71, AVLTreeNode.keys], Heap[r#71, AVLTreeNode.key]);
  assume (forall kk#81: int :: Seq#Contains(Heap[r#71, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#71, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#71, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#71, AVLTreeNode.key])));
  assume Heap[r#71, AVLTreeNode.height] == ite(ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[r#71, AVLTreeNode.balanceFactor] == (ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]));
  assume Heap[r#71, AVLTreeNode.balanceFactor] <= 1;
  assume Heap[r#71, AVLTreeNode.balanceFactor] >= (0 - 1);
  assume Heap[r#71, AVLTreeNode.height] > 0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // assert
  assertHeap#_3057 := Heap;
  assertMask#_3058 := Mask;
  assertSecMask#_3059 := SecMask;
  assertCredits#_3060 := Credits;
  assume wf(assertHeap#_3057, assertMask#_3058, assertSecMask#_3059);
  // begin exhale (assert)
  exhaleMask#_3062 := assertMask#_3058;
  havoc exhaleHeap#_3061;
  assert {:msg "  831.10: Receiver might be null."} true ==> (r#71 != null);
  assert {:msg "  831.10: Location might not be readable."} true ==> CanRead(assertMask#_3058, assertSecMask#_3059, r#71, AVLTreeNode.left);
  if (!(assertHeap#_3057[r#71, AVLTreeNode.left] == null)) {
    assert {:msg "  831.10: Receiver might be null."} true && (0 <= k#110#879) ==> (r#71 != null);
    assert {:msg "  831.10: Location might not be readable."} true && (0 <= k#110#879) ==> CanRead(assertMask#_3058, assertSecMask#_3059, r#71, AVLTreeNode.left);
    assert {:msg "  831.10: Receiver might be null."} true && (0 <= k#110#879) ==> (assertHeap#_3057[r#71, AVLTreeNode.left] != null);
    assert {:msg "  831.10: Location might not be readable."} true && (0 <= k#110#879) ==> CanRead(assertMask#_3058, assertSecMask#_3059, assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys);
    assert {:msg "  831.54: Receiver might be null."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (this != null);
    assert {:msg "  831.54: Location might not be readable."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_3058, assertSecMask#_3059, this, AVLTreeNode.key);
    assert {:msg "  831.10: Receiver might be null."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (r#71 != null);
    assert {:msg "  831.10: Location might not be readable."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_3058, assertSecMask#_3059, r#71, AVLTreeNode.left);
    assert {:msg "  831.10: Receiver might be null."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (assertHeap#_3057[r#71, AVLTreeNode.left] != null);
    assert {:msg "  831.10: Location might not be readable."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_3058, assertSecMask#_3059, assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys);
    assert {:msg "  831.60: Sequence index might be negative."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (0 <= k#110#879);
    assert {:msg "  831.60: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#110#879) && (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (k#110#879 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys]));
    assert {:msg "  831.3: Assertion might not hold. The expression at 831.27 might not evaluate to true."} (forall k#110#878: int :: (0 <= k#110#878) && (k#110#878 < Seq#Length(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (assertHeap#_3057[this, AVLTreeNode.key] < Seq#Index(assertHeap#_3057[assertHeap#_3057[r#71, AVLTreeNode.left], AVLTreeNode.keys], k#110#878)));
  }
  assertMask#_3058 := exhaleMask#_3062;
  assume IsGoodExhaleState(exhaleHeap#_3061, assertHeap#_3057, assertMask#_3058, assertSecMask#_3059);
  assertHeap#_3057 := exhaleHeap#_3061;
  assume IsGoodMask(assertMask#_3058);
  assume wf(assertHeap#_3057, assertMask#_3058, assertSecMask#_3059);
  // end exhale
  // update field left
  assert {:msg "  832.3: Receiver might be null."} true ==> (this != null);
  assert {:msg "  832.3: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
  assert {:msg "  832.3: Location might not be writable"} CanWrite(Mask, Heap[this, AVLTreeNode.right], AVLTreeNode.left);
  assert {:msg "  832.17: Receiver might be null."} true ==> (r#71 != null);
  assert {:msg "  832.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, r#71, AVLTreeNode.right);
  Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.left] := Heap[r#71, AVLTreeNode.right];
  assume wf(Heap, Mask, SecMask);
  assume (0 < methodCallK#_3067) && ((1000 * methodCallK#_3067) < Fractions(1)) && ((1000 * methodCallK#_3067) < methodK#_2935);
  // call close
  callHeap#_3063 := Heap;
  callMask#_3064 := Mask;
  callSecMask#_3065 := SecMask;
  callCredits#_3066 := Credits;
  assume wf(callHeap#_3063, callMask#_3064, callSecMask#_3065);
  assert {:msg "  833.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  833.8: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
  assert {:msg "  833.3: The target of the method call might be null."} Heap[this, AVLTreeNode.right] != null;
  this#881 := Heap[this, AVLTreeNode.right];
  // begin exhale (precondition)
  exhaleMask#_3069 := Mask;
  havoc exhaleHeap#_3068;
  if (!(Heap[this#881, AVLTreeNode.left] == null)) {
    assert {:msg "  833.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#882: int :: (0 <= k#92#882) && (k#92#882 < Seq#Length(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys], k#92#882) < Heap[this#881, AVLTreeNode.key]));
  }
  if (!(Heap[this#881, AVLTreeNode.right] == null)) {
    assert {:msg "  833.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#883: int :: (0 <= k#93#883) && (k#93#883 < Seq#Length(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#881, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys], k#93#883)));
  }
  assert {:msg "  833.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#881, AVLTreeNode.left] == null, 0, Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#881, AVLTreeNode.right] == null, 0, Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
  assert {:msg "  833.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#881, AVLTreeNode.left] == null, 0, Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#881, AVLTreeNode.right] == null, 0, Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
  assert {:msg "  833.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  833.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_3069[this#881, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_3069[this#881, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_3069[this#881, AVLTreeNode.key][perm$N]));
  exhaleMask#_3069[this#881, AVLTreeNode.key] := exhaleMask#_3069[this#881, AVLTreeNode.key][perm$R := exhaleMask#_3069[this#881, AVLTreeNode.key][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3069);
  assume wf(Heap, exhaleMask#_3069, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  833.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  833.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_3069[this#881, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_3069[this#881, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3069[this#881, AVLTreeNode.height][perm$N]));
  exhaleMask#_3069[this#881, AVLTreeNode.height] := exhaleMask#_3069[this#881, AVLTreeNode.height][perm$R := exhaleMask#_3069[this#881, AVLTreeNode.height][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3069);
  assume wf(Heap, exhaleMask#_3069, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  833.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  833.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_3069[this#881, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_3069[this#881, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_3069[this#881, AVLTreeNode.left][perm$N]));
  exhaleMask#_3069[this#881, AVLTreeNode.left] := exhaleMask#_3069[this#881, AVLTreeNode.left][perm$R := exhaleMask#_3069[this#881, AVLTreeNode.left][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3069);
  assume wf(Heap, exhaleMask#_3069, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  833.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  833.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_3069[this#881, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_3069[this#881, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_3069[this#881, AVLTreeNode.right][perm$N]));
  exhaleMask#_3069[this#881, AVLTreeNode.right] := exhaleMask#_3069[this#881, AVLTreeNode.right][perm$R := exhaleMask#_3069[this#881, AVLTreeNode.right][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3069);
  assume wf(Heap, exhaleMask#_3069, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  833.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  833.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_3069[this#881, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_3069[this#881, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3069[this#881, AVLTreeNode.keys][perm$N]));
  exhaleMask#_3069[this#881, AVLTreeNode.keys] := exhaleMask#_3069[this#881, AVLTreeNode.keys][perm$R := exhaleMask#_3069[this#881, AVLTreeNode.keys][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3069);
  assume wf(Heap, exhaleMask#_3069, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  833.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  833.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_3069[this#881, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_3069[this#881, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3069[this#881, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_3069[this#881, AVLTreeNode.balanceFactor] := exhaleMask#_3069[this#881, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3069[this#881, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3069);
  assume wf(Heap, exhaleMask#_3069, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this#881, AVLTreeNode.left] == null)) {
    assert {:msg "  833.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
    assert {:msg "  833.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2983 == Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid]) && (predRec#_2982 == Heap[this#881, AVLTreeNode.left]) && true && predFlag#_2984)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#884: int :: (0 <= lk#79#884) && (lk#79#884 < Seq#Length(Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#884) < Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#885: int :: (0 <= rk#80#885) && (rk#80#885 < Seq#Length(Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#885)));
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height] > 0;
      SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_3069, SecMask, Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid)) {
      assume Heap[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_3068[Heap[this#881, AVLTreeNode.left], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#881, AVLTreeNode.left] == null)) {
    assert {:msg "  833.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  833.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#881, AVLTreeNode.left] == null)) {
    assert {:msg "  833.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  833.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#881, AVLTreeNode.left] == null)) {
    assert {:msg "  833.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  833.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#881, AVLTreeNode.right] == null)) {
    assert {:msg "  833.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
    assert {:msg "  833.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2983 == Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid]) && (predRec#_2982 == Heap[this#881, AVLTreeNode.right]) && true && predFlag#_2984)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#889: int :: (0 <= lk#79#889) && (lk#79#889 < Seq#Length(Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#889) < Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#890: int :: (0 <= rk#80#890) && (rk#80#890 < Seq#Length(Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#890)));
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height] > 0;
      SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_3069, SecMask, Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid)) {
      assume Heap[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_3068[Heap[this#881, AVLTreeNode.right], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#881, AVLTreeNode.right] == null)) {
    assert {:msg "  833.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  833.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#881, AVLTreeNode.right] == null)) {
    assert {:msg "  833.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  833.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#881, AVLTreeNode.right] == null)) {
    assert {:msg "  833.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  833.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3069[Heap[this#881, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3069);
    assume wf(Heap, exhaleMask#_3069, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_3069;
  assume IsGoodExhaleState(exhaleHeap#_3068, Heap, Mask, SecMask);
  Heap := exhaleHeap#_3068;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (postcondition)
  assume this#881 != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this#881, AVLTreeNode.valid] := Mask[this#881, AVLTreeNode.valid][perm$R := Mask[this#881, AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#881, AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#881 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#881, AVLTreeNode.height] := Mask[this#881, AVLTreeNode.height][perm$R := Mask[this#881, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#881, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#881 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#881, AVLTreeNode.keys] := Mask[this#881, AVLTreeNode.keys][perm$R := Mask[this#881, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#881, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#881 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#881, AVLTreeNode.balanceFactor] := Mask[this#881, AVLTreeNode.balanceFactor][perm$R := Mask[this#881, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#881, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Seq#Equal(Heap[this#881, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_3063[this#881, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_3063[this#881, AVLTreeNode.key])), ite(callHeap#_3063[this#881, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Heap[this#881, AVLTreeNode.height] == ite(ite(callHeap#_3063[this#881, AVLTreeNode.left] == null, 0, callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_3063[this#881, AVLTreeNode.right] == null, 0, callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_3063[this#881, AVLTreeNode.left] == null, 0, callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_3063[this#881, AVLTreeNode.right] == null, 0, callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[this#881, AVLTreeNode.balanceFactor] == (ite(callHeap#_3063[this#881, AVLTreeNode.left] == null, 0, callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_3063[this#881, AVLTreeNode.right] == null, 0, callHeap#_3063[callHeap#_3063[this#881, AVLTreeNode.right], AVLTreeNode.height]));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // update field right
  assert {:msg "  834.3: Location might not be writable"} CanWrite(Mask, r#71, AVLTreeNode.right);
  assert {:msg "  834.17: Receiver might be null."} true ==> (this != null);
  assert {:msg "  834.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
  Heap[r#71, AVLTreeNode.right] := Heap[this, AVLTreeNode.right];
  assume wf(Heap, Mask, SecMask);
  // update field right
  assert {:msg "  835.3: Location might not be writable"} CanWrite(Mask, this, AVLTreeNode.right);
  assert {:msg "  835.17: Receiver might be null."} true ==> (r#71 != null);
  assert {:msg "  835.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, r#71, AVLTreeNode.left);
  Heap[this, AVLTreeNode.right] := Heap[r#71, AVLTreeNode.left];
  assume wf(Heap, Mask, SecMask);
  // assert
  assertHeap#_3118 := Heap;
  assertMask#_3119 := Mask;
  assertSecMask#_3120 := SecMask;
  assertCredits#_3121 := Credits;
  assume wf(assertHeap#_3118, assertMask#_3119, assertSecMask#_3120);
  // begin exhale (assert)
  exhaleMask#_3123 := assertMask#_3119;
  havoc exhaleHeap#_3122;
  assert {:msg "  836.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  836.10: Location might not be readable."} true ==> CanRead(assertMask#_3119, assertSecMask#_3120, this, AVLTreeNode.right);
  if (!(assertHeap#_3118[this, AVLTreeNode.right] == null)) {
    assert {:msg "  836.10: Receiver might be null."} true && (0 <= k#111#895) ==> (this != null);
    assert {:msg "  836.10: Location might not be readable."} true && (0 <= k#111#895) ==> CanRead(assertMask#_3119, assertSecMask#_3120, this, AVLTreeNode.right);
    assert {:msg "  836.10: Receiver might be null."} true && (0 <= k#111#895) ==> (assertHeap#_3118[this, AVLTreeNode.right] != null);
    assert {:msg "  836.10: Location might not be readable."} true && (0 <= k#111#895) ==> CanRead(assertMask#_3119, assertSecMask#_3120, assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys);
    assert {:msg "  836.52: Receiver might be null."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (this != null);
    assert {:msg "  836.52: Location might not be readable."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_3119, assertSecMask#_3120, this, AVLTreeNode.key);
    assert {:msg "  836.10: Receiver might be null."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (this != null);
    assert {:msg "  836.10: Location might not be readable."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_3119, assertSecMask#_3120, this, AVLTreeNode.right);
    assert {:msg "  836.10: Receiver might be null."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_3118[this, AVLTreeNode.right] != null);
    assert {:msg "  836.10: Location might not be readable."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_3119, assertSecMask#_3120, assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys);
    assert {:msg "  836.58: Sequence index might be negative."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (0 <= k#111#895);
    assert {:msg "  836.58: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#111#895) && (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (k#111#895 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys]));
    assert {:msg "  836.3: Assertion might not hold. The expression at 836.26 might not evaluate to true."} (forall k#111#894: int :: (0 <= k#111#894) && (k#111#894 < Seq#Length(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_3118[this, AVLTreeNode.key] < Seq#Index(assertHeap#_3118[assertHeap#_3118[this, AVLTreeNode.right], AVLTreeNode.keys], k#111#894)));
  }
  assertMask#_3119 := exhaleMask#_3123;
  assume IsGoodExhaleState(exhaleHeap#_3122, assertHeap#_3118, assertMask#_3119, assertSecMask#_3120);
  assertHeap#_3118 := exhaleHeap#_3122;
  assume IsGoodMask(assertMask#_3119);
  assume wf(assertHeap#_3118, assertMask#_3119, assertSecMask#_3120);
  // end exhale
  assume (0 < methodCallK#_3128) && ((1000 * methodCallK#_3128) < Fractions(1)) && ((1000 * methodCallK#_3128) < methodK#_2935);
  // call close
  callHeap#_3124 := Heap;
  callMask#_3125 := Mask;
  callSecMask#_3126 := SecMask;
  callCredits#_3127 := Credits;
  assume wf(callHeap#_3124, callMask#_3125, callSecMask#_3126);
  assert {:msg "  837.3: The target of the method call might be null."} this != null;
  this#897 := this;
  // begin exhale (precondition)
  exhaleMask#_3130 := Mask;
  havoc exhaleHeap#_3129;
  if (!(Heap[this#897, AVLTreeNode.left] == null)) {
    assert {:msg "  837.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#898: int :: (0 <= k#92#898) && (k#92#898 < Seq#Length(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys], k#92#898) < Heap[this#897, AVLTreeNode.key]));
  }
  if (!(Heap[this#897, AVLTreeNode.right] == null)) {
    assert {:msg "  837.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#899: int :: (0 <= k#93#899) && (k#93#899 < Seq#Length(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#897, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys], k#93#899)));
  }
  assert {:msg "  837.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#897, AVLTreeNode.left] == null, 0, Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#897, AVLTreeNode.right] == null, 0, Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
  assert {:msg "  837.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#897, AVLTreeNode.left] == null, 0, Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#897, AVLTreeNode.right] == null, 0, Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
  assert {:msg "  837.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  837.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_3130[this#897, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_3130[this#897, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_3130[this#897, AVLTreeNode.key][perm$N]));
  exhaleMask#_3130[this#897, AVLTreeNode.key] := exhaleMask#_3130[this#897, AVLTreeNode.key][perm$R := exhaleMask#_3130[this#897, AVLTreeNode.key][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3130);
  assume wf(Heap, exhaleMask#_3130, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  837.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  837.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_3130[this#897, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_3130[this#897, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3130[this#897, AVLTreeNode.height][perm$N]));
  exhaleMask#_3130[this#897, AVLTreeNode.height] := exhaleMask#_3130[this#897, AVLTreeNode.height][perm$R := exhaleMask#_3130[this#897, AVLTreeNode.height][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3130);
  assume wf(Heap, exhaleMask#_3130, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  837.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  837.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_3130[this#897, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_3130[this#897, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_3130[this#897, AVLTreeNode.left][perm$N]));
  exhaleMask#_3130[this#897, AVLTreeNode.left] := exhaleMask#_3130[this#897, AVLTreeNode.left][perm$R := exhaleMask#_3130[this#897, AVLTreeNode.left][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3130);
  assume wf(Heap, exhaleMask#_3130, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  837.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  837.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_3130[this#897, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_3130[this#897, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_3130[this#897, AVLTreeNode.right][perm$N]));
  exhaleMask#_3130[this#897, AVLTreeNode.right] := exhaleMask#_3130[this#897, AVLTreeNode.right][perm$R := exhaleMask#_3130[this#897, AVLTreeNode.right][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3130);
  assume wf(Heap, exhaleMask#_3130, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  837.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  837.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_3130[this#897, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_3130[this#897, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3130[this#897, AVLTreeNode.keys][perm$N]));
  exhaleMask#_3130[this#897, AVLTreeNode.keys] := exhaleMask#_3130[this#897, AVLTreeNode.keys][perm$R := exhaleMask#_3130[this#897, AVLTreeNode.keys][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3130);
  assume wf(Heap, exhaleMask#_3130, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  837.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  837.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_3130[this#897, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_3130[this#897, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3130[this#897, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_3130[this#897, AVLTreeNode.balanceFactor] := exhaleMask#_3130[this#897, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3130[this#897, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3130);
  assume wf(Heap, exhaleMask#_3130, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this#897, AVLTreeNode.left] == null)) {
    assert {:msg "  837.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
    assert {:msg "  837.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2983 == Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid]) && (predRec#_2982 == Heap[this#897, AVLTreeNode.left]) && true && predFlag#_2984)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#900: int :: (0 <= lk#79#900) && (lk#79#900 < Seq#Length(Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#900) < Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#901: int :: (0 <= rk#80#901) && (rk#80#901 < Seq#Length(Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#901)));
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height] > 0;
      SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_3130, SecMask, Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid)) {
      assume Heap[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_3129[Heap[this#897, AVLTreeNode.left], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#897, AVLTreeNode.left] == null)) {
    assert {:msg "  837.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  837.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#897, AVLTreeNode.left] == null)) {
    assert {:msg "  837.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  837.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#897, AVLTreeNode.left] == null)) {
    assert {:msg "  837.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  837.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#897, AVLTreeNode.right] == null)) {
    assert {:msg "  837.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
    assert {:msg "  837.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2983 == Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid]) && (predRec#_2982 == Heap[this#897, AVLTreeNode.right]) && true && predFlag#_2984)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#905: int :: (0 <= lk#79#905) && (lk#79#905 < Seq#Length(Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#905) < Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#906: int :: (0 <= rk#80#906) && (rk#80#906 < Seq#Length(Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#906)));
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height] > 0;
      SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_3130, SecMask, Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid)) {
      assume Heap[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_3129[Heap[this#897, AVLTreeNode.right], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#897, AVLTreeNode.right] == null)) {
    assert {:msg "  837.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  837.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#897, AVLTreeNode.right] == null)) {
    assert {:msg "  837.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  837.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#897, AVLTreeNode.right] == null)) {
    assert {:msg "  837.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  837.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3130[Heap[this#897, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3130);
    assume wf(Heap, exhaleMask#_3130, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_3130;
  assume IsGoodExhaleState(exhaleHeap#_3129, Heap, Mask, SecMask);
  Heap := exhaleHeap#_3129;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (postcondition)
  assume this#897 != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this#897, AVLTreeNode.valid] := Mask[this#897, AVLTreeNode.valid][perm$R := Mask[this#897, AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#897, AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#897 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#897, AVLTreeNode.height] := Mask[this#897, AVLTreeNode.height][perm$R := Mask[this#897, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#897, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#897 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#897, AVLTreeNode.keys] := Mask[this#897, AVLTreeNode.keys][perm$R := Mask[this#897, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#897, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#897 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#897, AVLTreeNode.balanceFactor] := Mask[this#897, AVLTreeNode.balanceFactor][perm$R := Mask[this#897, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#897, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Seq#Equal(Heap[this#897, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_3124[this#897, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_3124[this#897, AVLTreeNode.key])), ite(callHeap#_3124[this#897, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Heap[this#897, AVLTreeNode.height] == ite(ite(callHeap#_3124[this#897, AVLTreeNode.left] == null, 0, callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_3124[this#897, AVLTreeNode.right] == null, 0, callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_3124[this#897, AVLTreeNode.left] == null, 0, callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_3124[this#897, AVLTreeNode.right] == null, 0, callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[this#897, AVLTreeNode.balanceFactor] == (ite(callHeap#_3124[this#897, AVLTreeNode.left] == null, 0, callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_3124[this#897, AVLTreeNode.right] == null, 0, callHeap#_3124[callHeap#_3124[this#897, AVLTreeNode.right], AVLTreeNode.height]));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // update field left
  assert {:msg "  838.3: Location might not be writable"} CanWrite(Mask, r#71, AVLTreeNode.left);
  Heap[r#71, AVLTreeNode.left] := this;
  assume wf(Heap, Mask, SecMask);
  assume (0 < methodCallK#_3183) && ((1000 * methodCallK#_3183) < Fractions(1)) && ((1000 * methodCallK#_3183) < methodK#_2935);
  // call close
  callHeap#_3179 := Heap;
  callMask#_3180 := Mask;
  callSecMask#_3181 := SecMask;
  callCredits#_3182 := Credits;
  assume wf(callHeap#_3179, callMask#_3180, callSecMask#_3181);
  assert {:msg "  839.3: The target of the method call might be null."} r#71 != null;
  this#910 := r#71;
  // begin exhale (precondition)
  exhaleMask#_3185 := Mask;
  havoc exhaleHeap#_3184;
  if (!(Heap[this#910, AVLTreeNode.left] == null)) {
    assert {:msg "  839.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#911: int :: (0 <= k#92#911) && (k#92#911 < Seq#Length(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys], k#92#911) < Heap[this#910, AVLTreeNode.key]));
  }
  if (!(Heap[this#910, AVLTreeNode.right] == null)) {
    assert {:msg "  839.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#912: int :: (0 <= k#93#912) && (k#93#912 < Seq#Length(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#910, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys], k#93#912)));
  }
  assert {:msg "  839.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#910, AVLTreeNode.left] == null, 0, Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#910, AVLTreeNode.right] == null, 0, Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
  assert {:msg "  839.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#910, AVLTreeNode.left] == null, 0, Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#910, AVLTreeNode.right] == null, 0, Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
  assert {:msg "  839.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  839.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_3185[this#910, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_3185[this#910, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_3185[this#910, AVLTreeNode.key][perm$N]));
  exhaleMask#_3185[this#910, AVLTreeNode.key] := exhaleMask#_3185[this#910, AVLTreeNode.key][perm$R := exhaleMask#_3185[this#910, AVLTreeNode.key][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3185);
  assume wf(Heap, exhaleMask#_3185, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  839.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  839.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_3185[this#910, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_3185[this#910, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3185[this#910, AVLTreeNode.height][perm$N]));
  exhaleMask#_3185[this#910, AVLTreeNode.height] := exhaleMask#_3185[this#910, AVLTreeNode.height][perm$R := exhaleMask#_3185[this#910, AVLTreeNode.height][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3185);
  assume wf(Heap, exhaleMask#_3185, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  839.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  839.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_3185[this#910, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_3185[this#910, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_3185[this#910, AVLTreeNode.left][perm$N]));
  exhaleMask#_3185[this#910, AVLTreeNode.left] := exhaleMask#_3185[this#910, AVLTreeNode.left][perm$R := exhaleMask#_3185[this#910, AVLTreeNode.left][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3185);
  assume wf(Heap, exhaleMask#_3185, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  839.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  839.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_3185[this#910, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_3185[this#910, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_3185[this#910, AVLTreeNode.right][perm$N]));
  exhaleMask#_3185[this#910, AVLTreeNode.right] := exhaleMask#_3185[this#910, AVLTreeNode.right][perm$R := exhaleMask#_3185[this#910, AVLTreeNode.right][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3185);
  assume wf(Heap, exhaleMask#_3185, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  839.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  839.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_3185[this#910, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_3185[this#910, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3185[this#910, AVLTreeNode.keys][perm$N]));
  exhaleMask#_3185[this#910, AVLTreeNode.keys] := exhaleMask#_3185[this#910, AVLTreeNode.keys][perm$R := exhaleMask#_3185[this#910, AVLTreeNode.keys][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3185);
  assume wf(Heap, exhaleMask#_3185, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  839.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  839.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_3185[this#910, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_3185[this#910, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3185[this#910, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_3185[this#910, AVLTreeNode.balanceFactor] := exhaleMask#_3185[this#910, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3185[this#910, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_3185);
  assume wf(Heap, exhaleMask#_3185, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this#910, AVLTreeNode.left] == null)) {
    assert {:msg "  839.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
    assert {:msg "  839.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2983 == Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid]) && (predRec#_2982 == Heap[this#910, AVLTreeNode.left]) && true && predFlag#_2984)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#913: int :: (0 <= lk#79#913) && (lk#79#913 < Seq#Length(Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#913) < Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#914: int :: (0 <= rk#80#914) && (rk#80#914 < Seq#Length(Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#914)));
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height] > 0;
      SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_3185, SecMask, Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid)) {
      assume Heap[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_3184[Heap[this#910, AVLTreeNode.left], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#910, AVLTreeNode.left] == null)) {
    assert {:msg "  839.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  839.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#910, AVLTreeNode.left] == null)) {
    assert {:msg "  839.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  839.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#910, AVLTreeNode.left] == null)) {
    assert {:msg "  839.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  839.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#910, AVLTreeNode.right] == null)) {
    assert {:msg "  839.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
    assert {:msg "  839.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2983 == Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid]) && (predRec#_2982 == Heap[this#910, AVLTreeNode.right]) && true && predFlag#_2984)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#918: int :: (0 <= lk#79#918) && (lk#79#918 < Seq#Length(Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#918) < Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#919: int :: (0 <= rk#80#919) && (rk#80#919 < Seq#Length(Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#919)));
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height] > 0;
      SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_3185, SecMask, Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid)) {
      assume Heap[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_3184[Heap[this#910, AVLTreeNode.right], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#910, AVLTreeNode.right] == null)) {
    assert {:msg "  839.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  839.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#910, AVLTreeNode.right] == null)) {
    assert {:msg "  839.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  839.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#910, AVLTreeNode.right] == null)) {
    assert {:msg "  839.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  839.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3185[Heap[this#910, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_3185);
    assume wf(Heap, exhaleMask#_3185, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_3185;
  assume IsGoodExhaleState(exhaleHeap#_3184, Heap, Mask, SecMask);
  Heap := exhaleHeap#_3184;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (postcondition)
  assume this#910 != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this#910, AVLTreeNode.valid] := Mask[this#910, AVLTreeNode.valid][perm$R := Mask[this#910, AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#910, AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#910 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#910, AVLTreeNode.height] := Mask[this#910, AVLTreeNode.height][perm$R := Mask[this#910, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#910, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#910 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#910, AVLTreeNode.keys] := Mask[this#910, AVLTreeNode.keys][perm$R := Mask[this#910, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#910, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#910 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#910, AVLTreeNode.balanceFactor] := Mask[this#910, AVLTreeNode.balanceFactor][perm$R := Mask[this#910, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#910, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Seq#Equal(Heap[this#910, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_3179[this#910, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_3179[this#910, AVLTreeNode.key])), ite(callHeap#_3179[this#910, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Heap[this#910, AVLTreeNode.height] == ite(ite(callHeap#_3179[this#910, AVLTreeNode.left] == null, 0, callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_3179[this#910, AVLTreeNode.right] == null, 0, callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_3179[this#910, AVLTreeNode.left] == null, 0, callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_3179[this#910, AVLTreeNode.right] == null, 0, callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[this#910, AVLTreeNode.balanceFactor] == (ite(callHeap#_3179[this#910, AVLTreeNode.left] == null, 0, callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_3179[this#910, AVLTreeNode.right] == null, 0, callHeap#_3179[callHeap#_3179[this#910, AVLTreeNode.right], AVLTreeNode.height]));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // begin exhale (postcondition)
  exhaleMask#_3235 := Mask;
  havoc exhaleHeap#_3234;
  assert {:msg "  790.2: The postcondition at 817.11 might not hold. The expression at 817.11 might not evaluate to true."} !(r#71 == null);
  assert {:msg "  790.2: The postcondition at 823.11 might not hold. The expression at 823.11 might not evaluate to true."} Heap[r#71, AVLTreeNode.height] == old(Heap)[old(Heap)[this, AVLTreeNode.right], AVLTreeNode.height];
  assert {:msg "  790.2: The postcondition at 824.11 might not hold. The expression at 824.11 might not evaluate to true."} Seq#Equal(Heap[r#71, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(old(Heap)[this, AVLTreeNode.left] == null, Seq#Empty(), old(Heap)[old(Heap)[this, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(old(Heap)[this, AVLTreeNode.key])), old(Heap)[old(Heap)[this, AVLTreeNode.right], AVLTreeNode.keys]));
  assert {:msg "  790.2: The postcondition at 818.11 might not hold. The permission at 818.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  790.2: The postcondition at 818.11 might not hold. Insufficient fraction at 818.11 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_3235[r#71, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3235[r#71, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3235[r#71, AVLTreeNode.valid][perm$N]));
  exhaleMask#_3235[r#71, AVLTreeNode.valid] := exhaleMask#_3235[r#71, AVLTreeNode.valid][perm$R := exhaleMask#_3235[r#71, AVLTreeNode.valid][perm$R] - Fractions(100)];
  if (false || ((predVer#_2983 == Heap[r#71, AVLTreeNode.valid]) && (predRec#_2982 == r#71) && true && predFlag#_2984)) {
    // begin exhale (update SecMask)
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#923: int :: (0 <= lk#79#923) && (lk#79#923 < Seq#Length(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys], lk#79#923) < Heap[r#71, AVLTreeNode.key]));
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#924: int :: (0 <= rk#80#924) && (rk#80#924 < Seq#Length(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#71, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys], rk#80#924)));
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[r#71, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#71, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#71, AVLTreeNode.key])), ite(Heap[r#71, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[r#71, AVLTreeNode.keys], Heap[r#71, AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[r#71, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#71, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#71, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#71, AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.height] == ite(ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.balanceFactor] == (ite(Heap[r#71, AVLTreeNode.left] == null, 0, Heap[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#71, AVLTreeNode.right] == null, 0, Heap[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[r#71, AVLTreeNode.height] > 0;
    SecMask[r#71, AVLTreeNode.key] := SecMask[r#71, AVLTreeNode.key][perm$R := SecMask[r#71, AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[r#71, AVLTreeNode.key][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.key] := SecMask[r#71, AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.height] := SecMask[r#71, AVLTreeNode.height][perm$R := SecMask[r#71, AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[r#71, AVLTreeNode.height][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.height] := SecMask[r#71, AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.left] := SecMask[r#71, AVLTreeNode.left][perm$R := SecMask[r#71, AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[r#71, AVLTreeNode.left][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.left] := SecMask[r#71, AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.right] := SecMask[r#71, AVLTreeNode.right][perm$R := SecMask[r#71, AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[r#71, AVLTreeNode.right][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.right] := SecMask[r#71, AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.keys] := SecMask[r#71, AVLTreeNode.keys][perm$R := SecMask[r#71, AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[r#71, AVLTreeNode.keys][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.keys] := SecMask[r#71, AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#71, AVLTreeNode.balanceFactor] := SecMask[r#71, AVLTreeNode.balanceFactor][perm$R := SecMask[r#71, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[r#71, AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[r#71, AVLTreeNode.balanceFactor] := SecMask[r#71, AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#71, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#71, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(exhaleMask#_3235, SecMask, r#71, AVLTreeNode.valid)) {
    assume Heap[r#71, AVLTreeNode.valid] < exhaleHeap#_3234[r#71, AVLTreeNode.valid];
  }
  assume IsGoodMask(exhaleMask#_3235);
  assume wf(Heap, exhaleMask#_3235, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  790.2: The postcondition at 819.11 might not hold. The permission at 819.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  790.2: The postcondition at 819.11 might not hold. Insufficient fraction at 819.11 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_3235[r#71, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3235[r#71, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3235[r#71, AVLTreeNode.height][perm$N]));
  exhaleMask#_3235[r#71, AVLTreeNode.height] := exhaleMask#_3235[r#71, AVLTreeNode.height][perm$R := exhaleMask#_3235[r#71, AVLTreeNode.height][perm$R] - Fractions(50)];
  assume IsGoodMask(exhaleMask#_3235);
  assume wf(Heap, exhaleMask#_3235, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  790.2: The postcondition at 820.11 might not hold. The permission at 820.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  790.2: The postcondition at 820.11 might not hold. Insufficient fraction at 820.11 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_3235[r#71, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3235[r#71, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3235[r#71, AVLTreeNode.keys][perm$N]));
  exhaleMask#_3235[r#71, AVLTreeNode.keys] := exhaleMask#_3235[r#71, AVLTreeNode.keys][perm$R := exhaleMask#_3235[r#71, AVLTreeNode.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(exhaleMask#_3235);
  assume wf(Heap, exhaleMask#_3235, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  790.2: The postcondition at 821.11 might not hold. The permission at 821.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  790.2: The postcondition at 821.11 might not hold. Insufficient fraction at 821.11 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_3235[r#71, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3235[r#71, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3235[r#71, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_3235[r#71, AVLTreeNode.balanceFactor] := exhaleMask#_3235[r#71, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3235[r#71, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
  assume IsGoodMask(exhaleMask#_3235);
  assume wf(Heap, exhaleMask#_3235, SecMask);
  assume wf(Heap, Mask, SecMask);
  Mask := exhaleMask#_3235;
  assume IsGoodExhaleState(exhaleHeap#_3234, Heap, Mask, SecMask);
  Heap := exhaleHeap#_3234;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  assert {:msg "  790.2: Method might lock/unlock more than allowed."} (forall lk#_3256: ref :: {Heap[lk#_3256, held]} {Heap[lk#_3256, rdheld]} (((0 < Heap[lk#_3256, held]) == (0 < old(Heap)[lk#_3256, held])) && (Heap[lk#_3256, rdheld] == old(Heap)[lk#_3256, rdheld])) || false);
  assert {:msg "  790.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure AVLTreeNode.rebalanceLL(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#72: ref where (r#72 == null) || (dtype(r#72) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
