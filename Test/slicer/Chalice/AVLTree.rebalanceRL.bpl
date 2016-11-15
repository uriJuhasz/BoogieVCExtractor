
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
procedure AVLTreeNode.rebalanceRL(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#66: ref where (r#66 == null) || (dtype(r#66) == AVLTreeNode#t))
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var methodK#_2144: int;
  var predRec#_2191: ref;
  var predFlag#_2193: bool;
  var predVer#_2192: int;
  var assertHeap#_2210: HeapType;
  var assertMask#_2211: MaskType;
  var assertSecMask#_2212: MaskType;
  var assertCredits#_2213: CreditsType;
  var exhaleMask#_2215: MaskType;
  var exhaleHeap#_2214: HeapType;
  var k#98#644: int where true;
  var unfoldK#_2216: int;
  var oldVers#_2236: int;
  var newVers#_2237: int;
  var assertHeap#_2238: HeapType;
  var assertMask#_2239: MaskType;
  var assertSecMask#_2240: MaskType;
  var assertCredits#_2241: CreditsType;
  var exhaleMask#_2243: MaskType;
  var exhaleHeap#_2242: HeapType;
  var k#99#653: int where true;
  var unfoldK#_2244: int;
  var oldVers#_2264: int;
  var newVers#_2265: int;
  var assertHeap#_2266: HeapType;
  var assertMask#_2267: MaskType;
  var assertSecMask#_2268: MaskType;
  var assertCredits#_2269: CreditsType;
  var exhaleMask#_2271: MaskType;
  var exhaleHeap#_2270: HeapType;
  var k#100#662: int where true;
  var methodCallK#_2276: int;
  var this#664: ref where (this#664 == null) || (dtype(this#664) == AVLTreeNode#t);
  var callHeap#_2272: HeapType;
  var callMask#_2273: MaskType;
  var callSecMask#_2274: MaskType;
  var callCredits#_2275: CreditsType;
  var exhaleMask#_2278: MaskType;
  var exhaleHeap#_2277: HeapType;
  var isHeld#_2325: int;
  var isRdHeld#_2326: bool;
  var assertHeap#_2327: HeapType;
  var assertMask#_2328: MaskType;
  var assertSecMask#_2329: MaskType;
  var assertCredits#_2330: CreditsType;
  var exhaleMask#_2332: MaskType;
  var exhaleHeap#_2331: HeapType;
  var k#101#678: int where true;
  var methodCallK#_2337: int;
  var this#680: ref where (this#680 == null) || (dtype(this#680) == AVLTreeNode#t);
  var callHeap#_2333: HeapType;
  var callMask#_2334: MaskType;
  var callSecMask#_2335: MaskType;
  var callCredits#_2336: CreditsType;
  var exhaleMask#_2339: MaskType;
  var exhaleHeap#_2338: HeapType;
  var isHeld#_2386: int;
  var isRdHeld#_2387: bool;
  var methodCallK#_2392: int;
  var this#693: ref where (this#693 == null) || (dtype(this#693) == AVLTreeNode#t);
  var callHeap#_2388: HeapType;
  var callMask#_2389: MaskType;
  var callSecMask#_2390: MaskType;
  var callCredits#_2391: CreditsType;
  var exhaleMask#_2394: MaskType;
  var exhaleHeap#_2393: HeapType;
  var isHeld#_2441: int;
  var isRdHeld#_2442: bool;
  var exhaleMask#_2444: MaskType;
  var exhaleHeap#_2443: HeapType;
  assume (0 < methodK#_2144) && ((1000 * methodK#_2144) < Fractions(1));
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
  assume !(Heap[this, AVLTreeNode.left] == null);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume (forall k#96#635: int :: (0 <= k#96#635) && (k#96#635 < Seq#Length(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], k#96#635) < Heap[this, AVLTreeNode.key]));
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assume Heap[this, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assume Heap[this, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assume Heap[this, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assume Heap[this, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assume (forall k#97#636: int :: (0 <= k#97#636) && (k#97#636 < Seq#Length(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this, AVLTreeNode.key] < Seq#Index(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], k#97#636)));
  }
  predRec#_2191 := Heap[this, AVLTreeNode.left];
  predFlag#_2193 := true;
  assume #AVLTreeNode.valid#trigger(Heap[this, AVLTreeNode.left]);
  predVer#_2192 := Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid];
  if (false) {
    // begin exhale (update SecMask)
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#637: int :: (0 <= lk#79#637) && (lk#79#637 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#637) < Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key]));
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#638: int :: (0 <= rk#80#638) && (rk#80#638 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#638)));
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  assume predRec#_2191 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  SecMask[predRec#_2191, AVLTreeNode.key] := SecMask[predRec#_2191, AVLTreeNode.key][perm$R := SecMask[predRec#_2191, AVLTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2191, AVLTreeNode.key]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2191 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  SecMask[predRec#_2191, AVLTreeNode.height] := SecMask[predRec#_2191, AVLTreeNode.height][perm$R := SecMask[predRec#_2191, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2191, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2191 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[predRec#_2191, AVLTreeNode.left] == null) || (dtype(Heap[predRec#_2191, AVLTreeNode.left]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  SecMask[predRec#_2191, AVLTreeNode.left] := SecMask[predRec#_2191, AVLTreeNode.left][perm$R := SecMask[predRec#_2191, AVLTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2191, AVLTreeNode.left]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2191 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[predRec#_2191, AVLTreeNode.right] == null) || (dtype(Heap[predRec#_2191, AVLTreeNode.right]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  SecMask[predRec#_2191, AVLTreeNode.right] := SecMask[predRec#_2191, AVLTreeNode.right][perm$R := SecMask[predRec#_2191, AVLTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2191, AVLTreeNode.right]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2191 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  SecMask[predRec#_2191, AVLTreeNode.keys] := SecMask[predRec#_2191, AVLTreeNode.keys][perm$R := SecMask[predRec#_2191, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2191, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume predRec#_2191 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  SecMask[predRec#_2191, AVLTreeNode.balanceFactor] := SecMask[predRec#_2191, AVLTreeNode.balanceFactor][perm$R := SecMask[predRec#_2191, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[predRec#_2191, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[predRec#_2191, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.left] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.left] == null)) {
    assume (forall lk#79#641: int :: (0 <= lk#79#641) && (lk#79#641 < Seq#Length(Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys], lk#79#641) < Heap[predRec#_2191, AVLTreeNode.key]));
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.left] == null)) {
    assume Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height] > 0;
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.right] == null)) {
    assume Heap[predRec#_2191, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.right] == null)) {
    assume (forall rk#80#642: int :: (0 <= rk#80#642) && (rk#80#642 < Seq#Length(Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[predRec#_2191, AVLTreeNode.key] < Seq#Index(Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys], rk#80#642)));
  }
  if (!(Heap[predRec#_2191, AVLTreeNode.right] == null)) {
    assume Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height] > 0;
  }
  assume Seq#Equal(Heap[predRec#_2191, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[predRec#_2191, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[predRec#_2191, AVLTreeNode.key])), ite(Heap[predRec#_2191, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Seq#Contains(Heap[predRec#_2191, AVLTreeNode.keys], Heap[predRec#_2191, AVLTreeNode.key]);
  assume (forall kk#81: int :: Seq#Contains(Heap[predRec#_2191, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[predRec#_2191, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[predRec#_2191, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[predRec#_2191, AVLTreeNode.key])));
  assume Heap[predRec#_2191, AVLTreeNode.height] == ite(ite(Heap[predRec#_2191, AVLTreeNode.left] == null, 0, Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[predRec#_2191, AVLTreeNode.right] == null, 0, Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[predRec#_2191, AVLTreeNode.left] == null, 0, Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[predRec#_2191, AVLTreeNode.right] == null, 0, Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[predRec#_2191, AVLTreeNode.balanceFactor] == (ite(Heap[predRec#_2191, AVLTreeNode.left] == null, 0, Heap[Heap[predRec#_2191, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[predRec#_2191, AVLTreeNode.right] == null, 0, Heap[Heap[predRec#_2191, AVLTreeNode.right], AVLTreeNode.height]));
  assume Heap[predRec#_2191, AVLTreeNode.balanceFactor] <= 1;
  assume Heap[predRec#_2191, AVLTreeNode.balanceFactor] >= (0 - 1);
  assume Heap[predRec#_2191, AVLTreeNode.height] > 0;
  assume !(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null);
  assume (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] - ite(Heap[this, AVLTreeNode.right] == null, 0, Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height])) == 2;
  assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (0 - 1);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume SecMask == old(SecMask);
  assume Credits == old(Credits);
  // assert
  assertHeap#_2210 := Heap;
  assertMask#_2211 := Mask;
  assertSecMask#_2212 := SecMask;
  assertCredits#_2213 := Credits;
  assume wf(assertHeap#_2210, assertMask#_2211, assertSecMask#_2212);
  // begin exhale (assert)
  exhaleMask#_2215 := assertMask#_2211;
  havoc exhaleHeap#_2214;
  assert {:msg "  679.10: Receiver might be null."} true && (0 <= k#98#644) ==> (this != null);
  assert {:msg "  679.10: Location might not be readable."} true && (0 <= k#98#644) ==> CanRead(assertMask#_2211, assertSecMask#_2212, this, AVLTreeNode.left);
  assert {:msg "  679.10: Receiver might be null."} true && (0 <= k#98#644) ==> (assertHeap#_2210[this, AVLTreeNode.left] != null);
  assert {:msg "  679.10: Location might not be readable."} true && (0 <= k#98#644) ==> CanRead(assertMask#_2211, assertSecMask#_2212, assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys);
  assert {:msg "  679.10: Receiver might be null."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (this != null);
  assert {:msg "  679.10: Location might not be readable."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_2211, assertSecMask#_2212, this, AVLTreeNode.left);
  assert {:msg "  679.10: Receiver might be null."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (assertHeap#_2210[this, AVLTreeNode.left] != null);
  assert {:msg "  679.10: Location might not be readable."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_2211, assertSecMask#_2212, assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys);
  assert {:msg "  679.35: Sequence index might be negative."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (0 <= k#98#644);
  assert {:msg "  679.35: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys]));
  assert {:msg "  679.39: Receiver might be null."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (this != null);
  assert {:msg "  679.39: Location might not be readable."} true && (0 <= k#98#644) && (k#98#644 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_2211, assertSecMask#_2212, this, AVLTreeNode.key);
  assert {:msg "  679.3: Assertion might not hold. The expression at 679.10 might not evaluate to true."} (forall k#98#643: int :: (0 <= k#98#643) && (k#98#643 < Seq#Length(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_2210[assertHeap#_2210[this, AVLTreeNode.left], AVLTreeNode.keys], k#98#643) < assertHeap#_2210[this, AVLTreeNode.key]));
  assertMask#_2211 := exhaleMask#_2215;
  assume IsGoodExhaleState(exhaleHeap#_2214, assertHeap#_2210, assertMask#_2211, assertSecMask#_2212);
  assertHeap#_2210 := exhaleHeap#_2214;
  assume IsGoodMask(assertMask#_2211);
  assume wf(assertHeap#_2210, assertMask#_2211, assertSecMask#_2212);
  // end exhale
  // unfold
  assume #AVLTreeNode.valid#trigger(Heap[this, AVLTreeNode.left]);
  assume (0 < unfoldK#_2216) && (unfoldK#_2216 < Fractions(1)) && ((1000 * unfoldK#_2216) < methodK#_2144);
  assert {:msg "  680.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  680.10: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
  assert {:msg "  680.3: The target of the fold statement might be null."} Heap[this, AVLTreeNode.left] != null;
  // begin exhale (unfold)
  assert {:msg "  680.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  680.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid."} (Fractions(100) <= Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
  if (false || ((predVer#_2192 == Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid]) && (predRec#_2191 == Heap[this, AVLTreeNode.left]) && true && predFlag#_2193)) {
    // begin exhale (update SecMask)
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#646: int :: (0 <= lk#79#646) && (lk#79#646 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#646) < Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key]));
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#647: int :: (0 <= rk#80#647) && (rk#80#647 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#647)));
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
      SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(Mask, SecMask, Heap[this, AVLTreeNode.left], AVLTreeNode.valid)) {
    oldVers#_2236 := Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid];
    havoc newVers#_2237;
    Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := newVers#_2237;
    assume oldVers#_2236 < Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.valid];
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (unfold)
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.key] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null) || (dtype(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.left] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null) || (dtype(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.right] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Heap[this, AVLTreeNode.left] != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
    assume (forall lk#79#650: int :: (0 <= lk#79#650) && (lk#79#650 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#650) < Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key]));
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
    assume Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
    assume (forall rk#80#651: int :: (0 <= rk#80#651) && (rk#80#651 < Seq#Length(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#651)));
  }
  if (!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
    assume Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
  }
  assume Seq#Equal(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
  assume Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key]);
  assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.key])));
  assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
  assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
  assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
  assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // assigment to r
  assert {:msg "  681.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  681.8: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
  assert {:msg "  681.8: Receiver might be null."} true ==> (Heap[this, AVLTreeNode.left] != null);
  assert {:msg "  681.8: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, AVLTreeNode.left], AVLTreeNode.right);
  r#66 := Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right];
  // assert
  assertHeap#_2238 := Heap;
  assertMask#_2239 := Mask;
  assertSecMask#_2240 := SecMask;
  assertCredits#_2241 := Credits;
  assume wf(assertHeap#_2238, assertMask#_2239, assertSecMask#_2240);
  // begin exhale (assert)
  exhaleMask#_2243 := assertMask#_2239;
  havoc exhaleHeap#_2242;
  assert {:msg "  682.10: Receiver might be null."} true && (0 <= k#99#653) ==> (r#66 != null);
  assert {:msg "  682.10: Location might not be readable."} true && (0 <= k#99#653) ==> CanRead(assertMask#_2239, assertSecMask#_2240, r#66, AVLTreeNode.keys);
  assert {:msg "  682.10: Receiver might be null."} true && (0 <= k#99#653) && (k#99#653 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys])) ==> (r#66 != null);
  assert {:msg "  682.10: Location might not be readable."} true && (0 <= k#99#653) && (k#99#653 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys])) ==> CanRead(assertMask#_2239, assertSecMask#_2240, r#66, AVLTreeNode.keys);
  assert {:msg "  682.32: Sequence index might be negative."} true && (0 <= k#99#653) && (k#99#653 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys])) ==> (0 <= k#99#653);
  assert {:msg "  682.32: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#99#653) && (k#99#653 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys])) ==> (k#99#653 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys]));
  assert {:msg "  682.36: Receiver might be null."} true && (0 <= k#99#653) && (k#99#653 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys])) ==> (this != null);
  assert {:msg "  682.36: Location might not be readable."} true && (0 <= k#99#653) && (k#99#653 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys])) ==> CanRead(assertMask#_2239, assertSecMask#_2240, this, AVLTreeNode.key);
  assert {:msg "  682.3: Assertion might not hold. The expression at 682.10 might not evaluate to true."} (forall k#99#652: int :: (0 <= k#99#652) && (k#99#652 < Seq#Length(assertHeap#_2238[r#66, AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_2238[r#66, AVLTreeNode.keys], k#99#652) < assertHeap#_2238[this, AVLTreeNode.key]));
  assertMask#_2239 := exhaleMask#_2243;
  assume IsGoodExhaleState(exhaleHeap#_2242, assertHeap#_2238, assertMask#_2239, assertSecMask#_2240);
  assertHeap#_2238 := exhaleHeap#_2242;
  assume IsGoodMask(assertMask#_2239);
  assume wf(assertHeap#_2238, assertMask#_2239, assertSecMask#_2240);
  // end exhale
  // unfold
  assume #AVLTreeNode.valid#trigger(r#66);
  assume (0 < unfoldK#_2244) && (unfoldK#_2244 < Fractions(1)) && ((1000 * unfoldK#_2244) < methodK#_2144);
  assert {:msg "  683.3: The target of the fold statement might be null."} r#66 != null;
  // begin exhale (unfold)
  assert {:msg "  683.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  683.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid."} (Fractions(100) <= Mask[r#66, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask[r#66, AVLTreeNode.valid][perm$R]) ==> (0 <= Mask[r#66, AVLTreeNode.valid][perm$N]));
  Mask[r#66, AVLTreeNode.valid] := Mask[r#66, AVLTreeNode.valid][perm$R := Mask[r#66, AVLTreeNode.valid][perm$R] - Fractions(100)];
  if (false || ((predVer#_2192 == Heap[r#66, AVLTreeNode.valid]) && (predRec#_2191 == r#66) && true && predFlag#_2193)) {
    // begin exhale (update SecMask)
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#655: int :: (0 <= lk#79#655) && (lk#79#655 < Seq#Length(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys], lk#79#655) < Heap[r#66, AVLTreeNode.key]));
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#656: int :: (0 <= rk#80#656) && (rk#80#656 < Seq#Length(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#66, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys], rk#80#656)));
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[r#66, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#66, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#66, AVLTreeNode.key])), ite(Heap[r#66, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[r#66, AVLTreeNode.keys], Heap[r#66, AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[r#66, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#66, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#66, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#66, AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.height] == ite(ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.balanceFactor] == (ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.height] > 0;
    SecMask[r#66, AVLTreeNode.key] := SecMask[r#66, AVLTreeNode.key][perm$R := SecMask[r#66, AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[r#66, AVLTreeNode.key][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.key] := SecMask[r#66, AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.height] := SecMask[r#66, AVLTreeNode.height][perm$R := SecMask[r#66, AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[r#66, AVLTreeNode.height][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.height] := SecMask[r#66, AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.left] := SecMask[r#66, AVLTreeNode.left][perm$R := SecMask[r#66, AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[r#66, AVLTreeNode.left][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.left] := SecMask[r#66, AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.right] := SecMask[r#66, AVLTreeNode.right][perm$R := SecMask[r#66, AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[r#66, AVLTreeNode.right][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.right] := SecMask[r#66, AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.keys] := SecMask[r#66, AVLTreeNode.keys][perm$R := SecMask[r#66, AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[r#66, AVLTreeNode.keys][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.keys] := SecMask[r#66, AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.balanceFactor] := SecMask[r#66, AVLTreeNode.balanceFactor][perm$R := SecMask[r#66, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[r#66, AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.balanceFactor] := SecMask[r#66, AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(Mask, SecMask, r#66, AVLTreeNode.valid)) {
    oldVers#_2264 := Heap[r#66, AVLTreeNode.valid];
    havoc newVers#_2265;
    Heap[r#66, AVLTreeNode.valid] := newVers#_2265;
    assume oldVers#_2264 < Heap[r#66, AVLTreeNode.valid];
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (unfold)
  assume r#66 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(100) > 0;
  Mask[r#66, AVLTreeNode.key] := Mask[r#66, AVLTreeNode.key][perm$R := Mask[r#66, AVLTreeNode.key][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#66, AVLTreeNode.key]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#66 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[r#66, AVLTreeNode.height] := Mask[r#66, AVLTreeNode.height][perm$R := Mask[r#66, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#66, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#66 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[r#66, AVLTreeNode.left] == null) || (dtype(Heap[r#66, AVLTreeNode.left]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[r#66, AVLTreeNode.left] := Mask[r#66, AVLTreeNode.left][perm$R := Mask[r#66, AVLTreeNode.left][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#66, AVLTreeNode.left]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#66 != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[r#66, AVLTreeNode.right] == null) || (dtype(Heap[r#66, AVLTreeNode.right]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[r#66, AVLTreeNode.right] := Mask[r#66, AVLTreeNode.right][perm$R := Mask[r#66, AVLTreeNode.right][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#66, AVLTreeNode.right]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#66 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[r#66, AVLTreeNode.keys] := Mask[r#66, AVLTreeNode.keys][perm$R := Mask[r#66, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#66, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume r#66 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[r#66, AVLTreeNode.balanceFactor] := Mask[r#66, AVLTreeNode.balanceFactor][perm$R := Mask[r#66, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[r#66, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[r#66, AVLTreeNode.left] == null)) {
    assume Heap[r#66, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.left] == null)) {
    assume Heap[r#66, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.left] == null)) {
    assume Heap[r#66, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.left] == null)) {
    assume Heap[r#66, AVLTreeNode.left] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.left] == null)) {
    assume (forall lk#79#659: int :: (0 <= lk#79#659) && (lk#79#659 < Seq#Length(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys], lk#79#659) < Heap[r#66, AVLTreeNode.key]));
  }
  if (!(Heap[r#66, AVLTreeNode.left] == null)) {
    assume Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] > 0;
  }
  if (!(Heap[r#66, AVLTreeNode.right] == null)) {
    assume Heap[r#66, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.right] == null)) {
    assume Heap[r#66, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.right] == null)) {
    assume Heap[r#66, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.right] == null)) {
    assume Heap[r#66, AVLTreeNode.right] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[r#66, AVLTreeNode.right] == null)) {
    assume (forall rk#80#660: int :: (0 <= rk#80#660) && (rk#80#660 < Seq#Length(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#66, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys], rk#80#660)));
  }
  if (!(Heap[r#66, AVLTreeNode.right] == null)) {
    assume Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] > 0;
  }
  assume Seq#Equal(Heap[r#66, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#66, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#66, AVLTreeNode.key])), ite(Heap[r#66, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Seq#Contains(Heap[r#66, AVLTreeNode.keys], Heap[r#66, AVLTreeNode.key]);
  assume (forall kk#81: int :: Seq#Contains(Heap[r#66, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#66, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#66, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#66, AVLTreeNode.key])));
  assume Heap[r#66, AVLTreeNode.height] == ite(ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[r#66, AVLTreeNode.balanceFactor] == (ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]));
  assume Heap[r#66, AVLTreeNode.balanceFactor] <= 1;
  assume Heap[r#66, AVLTreeNode.balanceFactor] >= (0 - 1);
  assume Heap[r#66, AVLTreeNode.height] > 0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // assert
  assertHeap#_2266 := Heap;
  assertMask#_2267 := Mask;
  assertSecMask#_2268 := SecMask;
  assertCredits#_2269 := Credits;
  assume wf(assertHeap#_2266, assertMask#_2267, assertSecMask#_2268);
  // begin exhale (assert)
  exhaleMask#_2271 := assertMask#_2267;
  havoc exhaleHeap#_2270;
  assert {:msg "  685.10: Receiver might be null."} true ==> (r#66 != null);
  assert {:msg "  685.10: Location might not be readable."} true ==> CanRead(assertMask#_2267, assertSecMask#_2268, r#66, AVLTreeNode.right);
  if (!(assertHeap#_2266[r#66, AVLTreeNode.right] == null)) {
    assert {:msg "  685.10: Receiver might be null."} true && (0 <= k#100#662) ==> (r#66 != null);
    assert {:msg "  685.10: Location might not be readable."} true && (0 <= k#100#662) ==> CanRead(assertMask#_2267, assertSecMask#_2268, r#66, AVLTreeNode.right);
    assert {:msg "  685.10: Receiver might be null."} true && (0 <= k#100#662) ==> (assertHeap#_2266[r#66, AVLTreeNode.right] != null);
    assert {:msg "  685.10: Location might not be readable."} true && (0 <= k#100#662) ==> CanRead(assertMask#_2267, assertSecMask#_2268, assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys);
    assert {:msg "  685.10: Receiver might be null."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (r#66 != null);
    assert {:msg "  685.10: Location might not be readable."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_2267, assertSecMask#_2268, r#66, AVLTreeNode.right);
    assert {:msg "  685.10: Receiver might be null."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_2266[r#66, AVLTreeNode.right] != null);
    assert {:msg "  685.10: Location might not be readable."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_2267, assertSecMask#_2268, assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys);
    assert {:msg "  685.56: Sequence index might be negative."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (0 <= k#100#662);
    assert {:msg "  685.56: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys]));
    assert {:msg "  685.60: Receiver might be null."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (this != null);
    assert {:msg "  685.60: Location might not be readable."} true && (0 <= k#100#662) && (k#100#662 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> CanRead(assertMask#_2267, assertSecMask#_2268, this, AVLTreeNode.key);
    assert {:msg "  685.3: Assertion might not hold. The expression at 685.28 might not evaluate to true."} (forall k#100#661: int :: (0 <= k#100#661) && (k#100#661 < Seq#Length(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_2266[assertHeap#_2266[r#66, AVLTreeNode.right], AVLTreeNode.keys], k#100#661) < assertHeap#_2266[this, AVLTreeNode.key]));
  }
  assertMask#_2267 := exhaleMask#_2271;
  assume IsGoodExhaleState(exhaleHeap#_2270, assertHeap#_2266, assertMask#_2267, assertSecMask#_2268);
  assertHeap#_2266 := exhaleHeap#_2270;
  assume IsGoodMask(assertMask#_2267);
  assume wf(assertHeap#_2266, assertMask#_2267, assertSecMask#_2268);
  // end exhale
  // update field right
  assert {:msg "  687.3: Receiver might be null."} true ==> (this != null);
  assert {:msg "  687.3: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
  assert {:msg "  687.3: Location might not be writable"} CanWrite(Mask, Heap[this, AVLTreeNode.left], AVLTreeNode.right);
  assert {:msg "  687.17: Receiver might be null."} true ==> (r#66 != null);
  assert {:msg "  687.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, r#66, AVLTreeNode.left);
  Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.right] := Heap[r#66, AVLTreeNode.left];
  assume wf(Heap, Mask, SecMask);
  assume (0 < methodCallK#_2276) && ((1000 * methodCallK#_2276) < Fractions(1)) && ((1000 * methodCallK#_2276) < methodK#_2144);
  // call close
  callHeap#_2272 := Heap;
  callMask#_2273 := Mask;
  callSecMask#_2274 := SecMask;
  callCredits#_2275 := Credits;
  assume wf(callHeap#_2272, callMask#_2273, callSecMask#_2274);
  assert {:msg "  688.8: Receiver might be null."} true ==> (this != null);
  assert {:msg "  688.8: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
  assert {:msg "  688.3: The target of the method call might be null."} Heap[this, AVLTreeNode.left] != null;
  this#664 := Heap[this, AVLTreeNode.left];
  // begin exhale (precondition)
  exhaleMask#_2278 := Mask;
  havoc exhaleHeap#_2277;
  if (!(Heap[this#664, AVLTreeNode.left] == null)) {
    assert {:msg "  688.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#665: int :: (0 <= k#92#665) && (k#92#665 < Seq#Length(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys], k#92#665) < Heap[this#664, AVLTreeNode.key]));
  }
  if (!(Heap[this#664, AVLTreeNode.right] == null)) {
    assert {:msg "  688.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#666: int :: (0 <= k#93#666) && (k#93#666 < Seq#Length(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#664, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys], k#93#666)));
  }
  assert {:msg "  688.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#664, AVLTreeNode.left] == null, 0, Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#664, AVLTreeNode.right] == null, 0, Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
  assert {:msg "  688.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#664, AVLTreeNode.left] == null, 0, Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#664, AVLTreeNode.right] == null, 0, Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
  assert {:msg "  688.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  688.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_2278[this#664, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_2278[this#664, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_2278[this#664, AVLTreeNode.key][perm$N]));
  exhaleMask#_2278[this#664, AVLTreeNode.key] := exhaleMask#_2278[this#664, AVLTreeNode.key][perm$R := exhaleMask#_2278[this#664, AVLTreeNode.key][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2278);
  assume wf(Heap, exhaleMask#_2278, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  688.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  688.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_2278[this#664, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_2278[this#664, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278[this#664, AVLTreeNode.height][perm$N]));
  exhaleMask#_2278[this#664, AVLTreeNode.height] := exhaleMask#_2278[this#664, AVLTreeNode.height][perm$R := exhaleMask#_2278[this#664, AVLTreeNode.height][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2278);
  assume wf(Heap, exhaleMask#_2278, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  688.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  688.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_2278[this#664, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_2278[this#664, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_2278[this#664, AVLTreeNode.left][perm$N]));
  exhaleMask#_2278[this#664, AVLTreeNode.left] := exhaleMask#_2278[this#664, AVLTreeNode.left][perm$R := exhaleMask#_2278[this#664, AVLTreeNode.left][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2278);
  assume wf(Heap, exhaleMask#_2278, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  688.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  688.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_2278[this#664, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_2278[this#664, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_2278[this#664, AVLTreeNode.right][perm$N]));
  exhaleMask#_2278[this#664, AVLTreeNode.right] := exhaleMask#_2278[this#664, AVLTreeNode.right][perm$R := exhaleMask#_2278[this#664, AVLTreeNode.right][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2278);
  assume wf(Heap, exhaleMask#_2278, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  688.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  688.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_2278[this#664, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_2278[this#664, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278[this#664, AVLTreeNode.keys][perm$N]));
  exhaleMask#_2278[this#664, AVLTreeNode.keys] := exhaleMask#_2278[this#664, AVLTreeNode.keys][perm$R := exhaleMask#_2278[this#664, AVLTreeNode.keys][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2278);
  assume wf(Heap, exhaleMask#_2278, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  688.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  688.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_2278[this#664, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_2278[this#664, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2278[this#664, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_2278[this#664, AVLTreeNode.balanceFactor] := exhaleMask#_2278[this#664, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2278[this#664, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2278);
  assume wf(Heap, exhaleMask#_2278, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this#664, AVLTreeNode.left] == null)) {
    assert {:msg "  688.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
    assert {:msg "  688.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2192 == Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid]) && (predRec#_2191 == Heap[this#664, AVLTreeNode.left]) && true && predFlag#_2193)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#667: int :: (0 <= lk#79#667) && (lk#79#667 < Seq#Length(Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#667) < Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#668: int :: (0 <= rk#80#668) && (rk#80#668 < Seq#Length(Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#668)));
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height] > 0;
      SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_2278, SecMask, Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid)) {
      assume Heap[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_2277[Heap[this#664, AVLTreeNode.left], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#664, AVLTreeNode.left] == null)) {
    assert {:msg "  688.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  688.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#664, AVLTreeNode.left] == null)) {
    assert {:msg "  688.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  688.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#664, AVLTreeNode.left] == null)) {
    assert {:msg "  688.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  688.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#664, AVLTreeNode.right] == null)) {
    assert {:msg "  688.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
    assert {:msg "  688.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2192 == Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid]) && (predRec#_2191 == Heap[this#664, AVLTreeNode.right]) && true && predFlag#_2193)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#672: int :: (0 <= lk#79#672) && (lk#79#672 < Seq#Length(Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#672) < Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#673: int :: (0 <= rk#80#673) && (rk#80#673 < Seq#Length(Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#673)));
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height] > 0;
      SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_2278, SecMask, Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid)) {
      assume Heap[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_2277[Heap[this#664, AVLTreeNode.right], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#664, AVLTreeNode.right] == null)) {
    assert {:msg "  688.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  688.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#664, AVLTreeNode.right] == null)) {
    assert {:msg "  688.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  688.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#664, AVLTreeNode.right] == null)) {
    assert {:msg "  688.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  688.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2278[Heap[this#664, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2278);
    assume wf(Heap, exhaleMask#_2278, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_2278;
  assume IsGoodExhaleState(exhaleHeap#_2277, Heap, Mask, SecMask);
  Heap := exhaleHeap#_2277;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (postcondition)
  assume this#664 != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this#664, AVLTreeNode.valid] := Mask[this#664, AVLTreeNode.valid][perm$R := Mask[this#664, AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#664, AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#664 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#664, AVLTreeNode.height] := Mask[this#664, AVLTreeNode.height][perm$R := Mask[this#664, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#664, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#664 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#664, AVLTreeNode.keys] := Mask[this#664, AVLTreeNode.keys][perm$R := Mask[this#664, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#664, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#664 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#664, AVLTreeNode.balanceFactor] := Mask[this#664, AVLTreeNode.balanceFactor][perm$R := Mask[this#664, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#664, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Seq#Equal(Heap[this#664, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_2272[this#664, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_2272[this#664, AVLTreeNode.key])), ite(callHeap#_2272[this#664, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Heap[this#664, AVLTreeNode.height] == ite(ite(callHeap#_2272[this#664, AVLTreeNode.left] == null, 0, callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_2272[this#664, AVLTreeNode.right] == null, 0, callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_2272[this#664, AVLTreeNode.left] == null, 0, callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_2272[this#664, AVLTreeNode.right] == null, 0, callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[this#664, AVLTreeNode.balanceFactor] == (ite(callHeap#_2272[this#664, AVLTreeNode.left] == null, 0, callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_2272[this#664, AVLTreeNode.right] == null, 0, callHeap#_2272[callHeap#_2272[this#664, AVLTreeNode.right], AVLTreeNode.height]));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // update field left
  assert {:msg "  689.3: Location might not be writable"} CanWrite(Mask, r#66, AVLTreeNode.left);
  assert {:msg "  689.17: Receiver might be null."} true ==> (this != null);
  assert {:msg "  689.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
  Heap[r#66, AVLTreeNode.left] := Heap[this, AVLTreeNode.left];
  assume wf(Heap, Mask, SecMask);
  // update field left
  assert {:msg "  690.3: Location might not be writable"} CanWrite(Mask, this, AVLTreeNode.left);
  assert {:msg "  690.17: Receiver might be null."} true ==> (r#66 != null);
  assert {:msg "  690.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, r#66, AVLTreeNode.right);
  Heap[this, AVLTreeNode.left] := Heap[r#66, AVLTreeNode.right];
  assume wf(Heap, Mask, SecMask);
  // assert
  assertHeap#_2327 := Heap;
  assertMask#_2328 := Mask;
  assertSecMask#_2329 := SecMask;
  assertCredits#_2330 := Credits;
  assume wf(assertHeap#_2327, assertMask#_2328, assertSecMask#_2329);
  // begin exhale (assert)
  exhaleMask#_2332 := assertMask#_2328;
  havoc exhaleHeap#_2331;
  assert {:msg "  692.10: Receiver might be null."} true ==> (this != null);
  assert {:msg "  692.10: Location might not be readable."} true ==> CanRead(assertMask#_2328, assertSecMask#_2329, this, AVLTreeNode.left);
  if (!(assertHeap#_2327[this, AVLTreeNode.left] == null)) {
    assert {:msg "  692.10: Receiver might be null."} true && (0 <= k#101#678) ==> (this != null);
    assert {:msg "  692.10: Location might not be readable."} true && (0 <= k#101#678) ==> CanRead(assertMask#_2328, assertSecMask#_2329, this, AVLTreeNode.left);
    assert {:msg "  692.10: Receiver might be null."} true && (0 <= k#101#678) ==> (assertHeap#_2327[this, AVLTreeNode.left] != null);
    assert {:msg "  692.10: Location might not be readable."} true && (0 <= k#101#678) ==> CanRead(assertMask#_2328, assertSecMask#_2329, assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys);
    assert {:msg "  692.10: Receiver might be null."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (this != null);
    assert {:msg "  692.10: Location might not be readable."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_2328, assertSecMask#_2329, this, AVLTreeNode.left);
    assert {:msg "  692.10: Receiver might be null."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (assertHeap#_2327[this, AVLTreeNode.left] != null);
    assert {:msg "  692.10: Location might not be readable."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_2328, assertSecMask#_2329, assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys);
    assert {:msg "  692.50: Sequence index might be negative."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (0 <= k#101#678);
    assert {:msg "  692.50: Sequence index might be larger than or equal to the length of the sequence."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys]));
    assert {:msg "  692.54: Receiver might be null."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (this != null);
    assert {:msg "  692.54: Location might not be readable."} true && (0 <= k#101#678) && (k#101#678 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> CanRead(assertMask#_2328, assertSecMask#_2329, this, AVLTreeNode.key);
    assert {:msg "  692.3: Assertion might not hold. The expression at 692.25 might not evaluate to true."} (forall k#101#677: int :: (0 <= k#101#677) && (k#101#677 < Seq#Length(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_2327[assertHeap#_2327[this, AVLTreeNode.left], AVLTreeNode.keys], k#101#677) < assertHeap#_2327[this, AVLTreeNode.key]));
  }
  assertMask#_2328 := exhaleMask#_2332;
  assume IsGoodExhaleState(exhaleHeap#_2331, assertHeap#_2327, assertMask#_2328, assertSecMask#_2329);
  assertHeap#_2327 := exhaleHeap#_2331;
  assume IsGoodMask(assertMask#_2328);
  assume wf(assertHeap#_2327, assertMask#_2328, assertSecMask#_2329);
  // end exhale
  assume (0 < methodCallK#_2337) && ((1000 * methodCallK#_2337) < Fractions(1)) && ((1000 * methodCallK#_2337) < methodK#_2144);
  // call close
  callHeap#_2333 := Heap;
  callMask#_2334 := Mask;
  callSecMask#_2335 := SecMask;
  callCredits#_2336 := Credits;
  assume wf(callHeap#_2333, callMask#_2334, callSecMask#_2335);
  assert {:msg "  693.3: The target of the method call might be null."} this != null;
  this#680 := this;
  // begin exhale (precondition)
  exhaleMask#_2339 := Mask;
  havoc exhaleHeap#_2338;
  if (!(Heap[this#680, AVLTreeNode.left] == null)) {
    assert {:msg "  693.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#681: int :: (0 <= k#92#681) && (k#92#681 < Seq#Length(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys], k#92#681) < Heap[this#680, AVLTreeNode.key]));
  }
  if (!(Heap[this#680, AVLTreeNode.right] == null)) {
    assert {:msg "  693.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#682: int :: (0 <= k#93#682) && (k#93#682 < Seq#Length(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#680, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys], k#93#682)));
  }
  assert {:msg "  693.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#680, AVLTreeNode.left] == null, 0, Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#680, AVLTreeNode.right] == null, 0, Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
  assert {:msg "  693.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#680, AVLTreeNode.left] == null, 0, Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#680, AVLTreeNode.right] == null, 0, Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
  assert {:msg "  693.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  693.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_2339[this#680, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_2339[this#680, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_2339[this#680, AVLTreeNode.key][perm$N]));
  exhaleMask#_2339[this#680, AVLTreeNode.key] := exhaleMask#_2339[this#680, AVLTreeNode.key][perm$R := exhaleMask#_2339[this#680, AVLTreeNode.key][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2339);
  assume wf(Heap, exhaleMask#_2339, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  693.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  693.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_2339[this#680, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_2339[this#680, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339[this#680, AVLTreeNode.height][perm$N]));
  exhaleMask#_2339[this#680, AVLTreeNode.height] := exhaleMask#_2339[this#680, AVLTreeNode.height][perm$R := exhaleMask#_2339[this#680, AVLTreeNode.height][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2339);
  assume wf(Heap, exhaleMask#_2339, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  693.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  693.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_2339[this#680, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_2339[this#680, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_2339[this#680, AVLTreeNode.left][perm$N]));
  exhaleMask#_2339[this#680, AVLTreeNode.left] := exhaleMask#_2339[this#680, AVLTreeNode.left][perm$R := exhaleMask#_2339[this#680, AVLTreeNode.left][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2339);
  assume wf(Heap, exhaleMask#_2339, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  693.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  693.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_2339[this#680, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_2339[this#680, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_2339[this#680, AVLTreeNode.right][perm$N]));
  exhaleMask#_2339[this#680, AVLTreeNode.right] := exhaleMask#_2339[this#680, AVLTreeNode.right][perm$R := exhaleMask#_2339[this#680, AVLTreeNode.right][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2339);
  assume wf(Heap, exhaleMask#_2339, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  693.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  693.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_2339[this#680, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_2339[this#680, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339[this#680, AVLTreeNode.keys][perm$N]));
  exhaleMask#_2339[this#680, AVLTreeNode.keys] := exhaleMask#_2339[this#680, AVLTreeNode.keys][perm$R := exhaleMask#_2339[this#680, AVLTreeNode.keys][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2339);
  assume wf(Heap, exhaleMask#_2339, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  693.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  693.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_2339[this#680, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_2339[this#680, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2339[this#680, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_2339[this#680, AVLTreeNode.balanceFactor] := exhaleMask#_2339[this#680, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2339[this#680, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2339);
  assume wf(Heap, exhaleMask#_2339, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this#680, AVLTreeNode.left] == null)) {
    assert {:msg "  693.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
    assert {:msg "  693.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2192 == Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid]) && (predRec#_2191 == Heap[this#680, AVLTreeNode.left]) && true && predFlag#_2193)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#683: int :: (0 <= lk#79#683) && (lk#79#683 < Seq#Length(Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#683) < Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#684: int :: (0 <= rk#80#684) && (rk#80#684 < Seq#Length(Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#684)));
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height] > 0;
      SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_2339, SecMask, Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid)) {
      assume Heap[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_2338[Heap[this#680, AVLTreeNode.left], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#680, AVLTreeNode.left] == null)) {
    assert {:msg "  693.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  693.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#680, AVLTreeNode.left] == null)) {
    assert {:msg "  693.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  693.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#680, AVLTreeNode.left] == null)) {
    assert {:msg "  693.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  693.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#680, AVLTreeNode.right] == null)) {
    assert {:msg "  693.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
    assert {:msg "  693.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2192 == Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid]) && (predRec#_2191 == Heap[this#680, AVLTreeNode.right]) && true && predFlag#_2193)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#688: int :: (0 <= lk#79#688) && (lk#79#688 < Seq#Length(Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#688) < Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#689: int :: (0 <= rk#80#689) && (rk#80#689 < Seq#Length(Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#689)));
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height] > 0;
      SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_2339, SecMask, Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid)) {
      assume Heap[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_2338[Heap[this#680, AVLTreeNode.right], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#680, AVLTreeNode.right] == null)) {
    assert {:msg "  693.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  693.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#680, AVLTreeNode.right] == null)) {
    assert {:msg "  693.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  693.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#680, AVLTreeNode.right] == null)) {
    assert {:msg "  693.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  693.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2339[Heap[this#680, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2339);
    assume wf(Heap, exhaleMask#_2339, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_2339;
  assume IsGoodExhaleState(exhaleHeap#_2338, Heap, Mask, SecMask);
  Heap := exhaleHeap#_2338;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (postcondition)
  assume this#680 != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this#680, AVLTreeNode.valid] := Mask[this#680, AVLTreeNode.valid][perm$R := Mask[this#680, AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#680, AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#680 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#680, AVLTreeNode.height] := Mask[this#680, AVLTreeNode.height][perm$R := Mask[this#680, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#680, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#680 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#680, AVLTreeNode.keys] := Mask[this#680, AVLTreeNode.keys][perm$R := Mask[this#680, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#680, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#680 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#680, AVLTreeNode.balanceFactor] := Mask[this#680, AVLTreeNode.balanceFactor][perm$R := Mask[this#680, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#680, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Seq#Equal(Heap[this#680, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_2333[this#680, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_2333[this#680, AVLTreeNode.key])), ite(callHeap#_2333[this#680, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Heap[this#680, AVLTreeNode.height] == ite(ite(callHeap#_2333[this#680, AVLTreeNode.left] == null, 0, callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_2333[this#680, AVLTreeNode.right] == null, 0, callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_2333[this#680, AVLTreeNode.left] == null, 0, callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_2333[this#680, AVLTreeNode.right] == null, 0, callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[this#680, AVLTreeNode.balanceFactor] == (ite(callHeap#_2333[this#680, AVLTreeNode.left] == null, 0, callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_2333[this#680, AVLTreeNode.right] == null, 0, callHeap#_2333[callHeap#_2333[this#680, AVLTreeNode.right], AVLTreeNode.height]));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // update field right
  assert {:msg "  694.3: Location might not be writable"} CanWrite(Mask, r#66, AVLTreeNode.right);
  Heap[r#66, AVLTreeNode.right] := this;
  assume wf(Heap, Mask, SecMask);
  assume (0 < methodCallK#_2392) && ((1000 * methodCallK#_2392) < Fractions(1)) && ((1000 * methodCallK#_2392) < methodK#_2144);
  // call close
  callHeap#_2388 := Heap;
  callMask#_2389 := Mask;
  callSecMask#_2390 := SecMask;
  callCredits#_2391 := Credits;
  assume wf(callHeap#_2388, callMask#_2389, callSecMask#_2390);
  assert {:msg "  695.3: The target of the method call might be null."} r#66 != null;
  this#693 := r#66;
  // begin exhale (precondition)
  exhaleMask#_2394 := Mask;
  havoc exhaleHeap#_2393;
  if (!(Heap[this#693, AVLTreeNode.left] == null)) {
    assert {:msg "  695.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#694: int :: (0 <= k#92#694) && (k#92#694 < Seq#Length(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys], k#92#694) < Heap[this#693, AVLTreeNode.key]));
  }
  if (!(Heap[this#693, AVLTreeNode.right] == null)) {
    assert {:msg "  695.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#695: int :: (0 <= k#93#695) && (k#93#695 < Seq#Length(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#693, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys], k#93#695)));
  }
  assert {:msg "  695.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#693, AVLTreeNode.left] == null, 0, Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#693, AVLTreeNode.right] == null, 0, Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
  assert {:msg "  695.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#693, AVLTreeNode.left] == null, 0, Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#693, AVLTreeNode.right] == null, 0, Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
  assert {:msg "  695.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  695.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_2394[this#693, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_2394[this#693, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_2394[this#693, AVLTreeNode.key][perm$N]));
  exhaleMask#_2394[this#693, AVLTreeNode.key] := exhaleMask#_2394[this#693, AVLTreeNode.key][perm$R := exhaleMask#_2394[this#693, AVLTreeNode.key][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2394);
  assume wf(Heap, exhaleMask#_2394, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  695.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  695.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_2394[this#693, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_2394[this#693, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394[this#693, AVLTreeNode.height][perm$N]));
  exhaleMask#_2394[this#693, AVLTreeNode.height] := exhaleMask#_2394[this#693, AVLTreeNode.height][perm$R := exhaleMask#_2394[this#693, AVLTreeNode.height][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2394);
  assume wf(Heap, exhaleMask#_2394, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  695.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  695.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_2394[this#693, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_2394[this#693, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_2394[this#693, AVLTreeNode.left][perm$N]));
  exhaleMask#_2394[this#693, AVLTreeNode.left] := exhaleMask#_2394[this#693, AVLTreeNode.left][perm$R := exhaleMask#_2394[this#693, AVLTreeNode.left][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2394);
  assume wf(Heap, exhaleMask#_2394, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  695.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  695.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_2394[this#693, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_2394[this#693, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_2394[this#693, AVLTreeNode.right][perm$N]));
  exhaleMask#_2394[this#693, AVLTreeNode.right] := exhaleMask#_2394[this#693, AVLTreeNode.right][perm$R := exhaleMask#_2394[this#693, AVLTreeNode.right][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2394);
  assume wf(Heap, exhaleMask#_2394, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  695.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  695.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_2394[this#693, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_2394[this#693, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394[this#693, AVLTreeNode.keys][perm$N]));
  exhaleMask#_2394[this#693, AVLTreeNode.keys] := exhaleMask#_2394[this#693, AVLTreeNode.keys][perm$R := exhaleMask#_2394[this#693, AVLTreeNode.keys][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2394);
  assume wf(Heap, exhaleMask#_2394, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  695.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
  assert {:msg "  695.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_2394[this#693, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_2394[this#693, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2394[this#693, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_2394[this#693, AVLTreeNode.balanceFactor] := exhaleMask#_2394[this#693, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2394[this#693, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
  assume IsGoodMask(exhaleMask#_2394);
  assume wf(Heap, exhaleMask#_2394, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this#693, AVLTreeNode.left] == null)) {
    assert {:msg "  695.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
    assert {:msg "  695.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2192 == Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid]) && (predRec#_2191 == Heap[this#693, AVLTreeNode.left]) && true && predFlag#_2193)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#696: int :: (0 <= lk#79#696) && (lk#79#696 < Seq#Length(Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#696) < Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#697: int :: (0 <= rk#80#697) && (rk#80#697 < Seq#Length(Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#697)));
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key])), ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys], Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height] > 0;
      SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key][perm$R := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left][perm$R := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right][perm$R := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_2394, SecMask, Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid)) {
      assume Heap[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_2393[Heap[this#693, AVLTreeNode.left], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#693, AVLTreeNode.left] == null)) {
    assert {:msg "  695.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  695.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#693, AVLTreeNode.left] == null)) {
    assert {:msg "  695.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  695.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#693, AVLTreeNode.left] == null)) {
    assert {:msg "  695.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
    assert {:msg "  695.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#693, AVLTreeNode.right] == null)) {
    assert {:msg "  695.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
    assert {:msg "  695.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (false || ((predVer#_2192 == Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid]) && (predRec#_2191 == Heap[this#693, AVLTreeNode.right]) && true && predFlag#_2193)) {
      // begin exhale (update SecMask)
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
        assume (forall lk#79#701: int :: (0 <= lk#79#701) && (lk#79#701 < Seq#Length(Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#701) < Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key]));
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
        assume Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
        assume (forall rk#80#702: int :: (0 <= rk#80#702) && (rk#80#702 < Seq#Length(Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#702)));
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
        assume Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
      assume Seq#Equal(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key])), ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
      //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
      assume Seq#Contains(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys], Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key]);
      //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
      assume (forall kk#81: int :: Seq#Contains(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key])));
      //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
      //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null, 0, Heap[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
      //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
      //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
      //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
      assume Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height] > 0;
      SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key][perm$R := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left][perm$R := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right][perm$R := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
      if (SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right] == null)) {
        SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume wf(Heap, SecMask, SecMask);
      // end exhale
    }
    if (!CanRead(exhaleMask#_2394, SecMask, Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid)) {
      assume Heap[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_2393[Heap[this#693, AVLTreeNode.right], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#693, AVLTreeNode.right] == null)) {
    assert {:msg "  695.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  695.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#693, AVLTreeNode.right] == null)) {
    assert {:msg "  695.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  695.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this#693, AVLTreeNode.right] == null)) {
    assert {:msg "  695.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
    assert {:msg "  695.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2394[Heap[this#693, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_2394);
    assume wf(Heap, exhaleMask#_2394, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_2394;
  assume IsGoodExhaleState(exhaleHeap#_2393, Heap, Mask, SecMask);
  Heap := exhaleHeap#_2393;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (postcondition)
  assume this#693 != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this#693, AVLTreeNode.valid] := Mask[this#693, AVLTreeNode.valid][perm$R := Mask[this#693, AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#693, AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#693 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#693, AVLTreeNode.height] := Mask[this#693, AVLTreeNode.height][perm$R := Mask[this#693, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#693, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#693 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#693, AVLTreeNode.keys] := Mask[this#693, AVLTreeNode.keys][perm$R := Mask[this#693, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#693, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this#693 != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this#693, AVLTreeNode.balanceFactor] := Mask[this#693, AVLTreeNode.balanceFactor][perm$R := Mask[this#693, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this#693, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume Seq#Equal(Heap[this#693, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_2388[this#693, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_2388[this#693, AVLTreeNode.key])), ite(callHeap#_2388[this#693, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Heap[this#693, AVLTreeNode.height] == ite(ite(callHeap#_2388[this#693, AVLTreeNode.left] == null, 0, callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_2388[this#693, AVLTreeNode.right] == null, 0, callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_2388[this#693, AVLTreeNode.left] == null, 0, callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_2388[this#693, AVLTreeNode.right] == null, 0, callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[this#693, AVLTreeNode.balanceFactor] == (ite(callHeap#_2388[this#693, AVLTreeNode.left] == null, 0, callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_2388[this#693, AVLTreeNode.right] == null, 0, callHeap#_2388[callHeap#_2388[this#693, AVLTreeNode.right], AVLTreeNode.height]));
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // begin exhale (postcondition)
  exhaleMask#_2444 := Mask;
  havoc exhaleHeap#_2443;
  assert {:msg "  643.2: The postcondition at 670.11 might not hold. The expression at 670.11 might not evaluate to true."} !(r#66 == null);
  assert {:msg "  643.2: The postcondition at 676.11 might not hold. The expression at 676.11 might not evaluate to true."} Heap[r#66, AVLTreeNode.height] == old(Heap)[old(Heap)[this, AVLTreeNode.left], AVLTreeNode.height];
  assert {:msg "  643.2: The postcondition at 677.11 might not hold. The expression at 677.11 might not evaluate to true."} Seq#Equal(Heap[r#66, AVLTreeNode.keys], Seq#Append(Seq#Append(old(Heap)[old(Heap)[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Singleton(old(Heap)[this, AVLTreeNode.key])), ite(old(Heap)[this, AVLTreeNode.right] == null, Seq#Empty(), old(Heap)[old(Heap)[this, AVLTreeNode.right], AVLTreeNode.keys])));
  assert {:msg "  643.2: The postcondition at 671.11 might not hold. The permission at 671.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  643.2: The postcondition at 671.11 might not hold. Insufficient fraction at 671.11 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_2444[r#66, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_2444[r#66, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_2444[r#66, AVLTreeNode.valid][perm$N]));
  exhaleMask#_2444[r#66, AVLTreeNode.valid] := exhaleMask#_2444[r#66, AVLTreeNode.valid][perm$R := exhaleMask#_2444[r#66, AVLTreeNode.valid][perm$R] - Fractions(100)];
  if (false || ((predVer#_2192 == Heap[r#66, AVLTreeNode.valid]) && (predRec#_2191 == r#66) && true && predFlag#_2193)) {
    // begin exhale (update SecMask)
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#706: int :: (0 <= lk#79#706) && (lk#79#706 < Seq#Length(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys], lk#79#706) < Heap[r#66, AVLTreeNode.key]));
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#707: int :: (0 <= rk#80#707) && (rk#80#707 < Seq#Length(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#66, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys], rk#80#707)));
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[r#66, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#66, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#66, AVLTreeNode.key])), ite(Heap[r#66, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[r#66, AVLTreeNode.keys], Heap[r#66, AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[r#66, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#66, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#66, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#66, AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.height] == ite(ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.balanceFactor] == (ite(Heap[r#66, AVLTreeNode.left] == null, 0, Heap[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#66, AVLTreeNode.right] == null, 0, Heap[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[r#66, AVLTreeNode.height] > 0;
    SecMask[r#66, AVLTreeNode.key] := SecMask[r#66, AVLTreeNode.key][perm$R := SecMask[r#66, AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[r#66, AVLTreeNode.key][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.key] := SecMask[r#66, AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.height] := SecMask[r#66, AVLTreeNode.height][perm$R := SecMask[r#66, AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[r#66, AVLTreeNode.height][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.height] := SecMask[r#66, AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.left] := SecMask[r#66, AVLTreeNode.left][perm$R := SecMask[r#66, AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[r#66, AVLTreeNode.left][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.left] := SecMask[r#66, AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.right] := SecMask[r#66, AVLTreeNode.right][perm$R := SecMask[r#66, AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[r#66, AVLTreeNode.right][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.right] := SecMask[r#66, AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.keys] := SecMask[r#66, AVLTreeNode.keys][perm$R := SecMask[r#66, AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[r#66, AVLTreeNode.keys][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.keys] := SecMask[r#66, AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[r#66, AVLTreeNode.balanceFactor] := SecMask[r#66, AVLTreeNode.balanceFactor][perm$R := SecMask[r#66, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[r#66, AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[r#66, AVLTreeNode.balanceFactor] := SecMask[r#66, AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.left] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[r#66, AVLTreeNode.right] == null)) {
      SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#66, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(exhaleMask#_2444, SecMask, r#66, AVLTreeNode.valid)) {
    assume Heap[r#66, AVLTreeNode.valid] < exhaleHeap#_2443[r#66, AVLTreeNode.valid];
  }
  assume IsGoodMask(exhaleMask#_2444);
  assume wf(Heap, exhaleMask#_2444, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  643.2: The postcondition at 672.11 might not hold. The permission at 672.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  643.2: The postcondition at 672.11 might not hold. Insufficient fraction at 672.11 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_2444[r#66, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_2444[r#66, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_2444[r#66, AVLTreeNode.height][perm$N]));
  exhaleMask#_2444[r#66, AVLTreeNode.height] := exhaleMask#_2444[r#66, AVLTreeNode.height][perm$R := exhaleMask#_2444[r#66, AVLTreeNode.height][perm$R] - Fractions(50)];
  assume IsGoodMask(exhaleMask#_2444);
  assume wf(Heap, exhaleMask#_2444, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  643.2: The postcondition at 673.11 might not hold. The permission at 673.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  643.2: The postcondition at 673.11 might not hold. Insufficient fraction at 673.11 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_2444[r#66, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_2444[r#66, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_2444[r#66, AVLTreeNode.keys][perm$N]));
  exhaleMask#_2444[r#66, AVLTreeNode.keys] := exhaleMask#_2444[r#66, AVLTreeNode.keys][perm$R := exhaleMask#_2444[r#66, AVLTreeNode.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(exhaleMask#_2444);
  assume wf(Heap, exhaleMask#_2444, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  643.2: The postcondition at 674.11 might not hold. The permission at 674.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  643.2: The postcondition at 674.11 might not hold. Insufficient fraction at 674.11 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_2444[r#66, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_2444[r#66, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_2444[r#66, AVLTreeNode.balanceFactor][perm$N]));
  exhaleMask#_2444[r#66, AVLTreeNode.balanceFactor] := exhaleMask#_2444[r#66, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_2444[r#66, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
  assume IsGoodMask(exhaleMask#_2444);
  assume wf(Heap, exhaleMask#_2444, SecMask);
  assume wf(Heap, Mask, SecMask);
  Mask := exhaleMask#_2444;
  assume IsGoodExhaleState(exhaleHeap#_2443, Heap, Mask, SecMask);
  Heap := exhaleHeap#_2443;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  assert {:msg "  643.2: Method might lock/unlock more than allowed."} (forall lk#_2465: ref :: {Heap[lk#_2465, held]} {Heap[lk#_2465, rdheld]} (((0 < Heap[lk#_2465, held]) == (0 < old(Heap)[lk#_2465, held])) && (Heap[lk#_2465, rdheld] == old(Heap)[lk#_2465, rdheld])) || false);
  assert {:msg "  643.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
procedure AVLTreeNode.rebalanceRR(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#67: ref where (r#67 == null) || (dtype(r#67) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceRight(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#68: ref where (r#68 == null) || (dtype(r#68) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceLR(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#71: ref where (r#71 == null) || (dtype(r#71) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceLL(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#72: ref where (r#72 == null) || (dtype(r#72) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
