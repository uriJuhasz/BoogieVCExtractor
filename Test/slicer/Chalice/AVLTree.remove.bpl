
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
procedure AVLTreeNode.remove(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t), k#19: int where true) returns (r#20: ref where (r#20 == null) || (dtype(r#20) == AVLTreeNode#t))
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var methodK#_506: int;
  var unfoldK#_507: int;
  var oldVers#_527: int;
  var newVers#_528: int;
  var cond#_529: bool;
  var cond#_530: bool;
  var assertHeap#_531: HeapType;
  var assertMask#_532: MaskType;
  var assertSecMask#_533: MaskType;
  var assertCredits#_534: CreditsType;
  var exhaleMask#_536: MaskType;
  var exhaleHeap#_535: HeapType;
  var unfoldingK#_542: int;
  var predFlag#_541: bool;
  var unfoldingHeap#_537: HeapType;
  var unfoldingMask#_538: MaskType;
  var unfoldingSecMask#_539: MaskType;
  var unfoldingCredits#_540: CreditsType;
  var oldVers#_562: int;
  var newVers#_563: int;
  var assertHeap#_580: HeapType;
  var assertMask#_581: MaskType;
  var assertSecMask#_582: MaskType;
  var assertCredits#_583: CreditsType;
  var exhaleMask#_585: MaskType;
  var exhaleHeap#_584: HeapType;
  var unfoldingK#_591: int;
  var predFlag#_590: bool;
  var unfoldingHeap#_586: HeapType;
  var unfoldingMask#_587: MaskType;
  var unfoldingSecMask#_588: MaskType;
  var unfoldingCredits#_589: CreditsType;
  var oldVers#_611: int;
  var newVers#_612: int;
  var cond#_629: bool;
  var bf#22: int where true;
  var nl#24: ref where (nl#24 == null) || (dtype(nl#24) == AVLTreeNode#t);
  var nr#26: ref where (nr#26 == null) || (dtype(nr#26) == AVLTreeNode#t);
  var methodCallK#_634: int;
  var this#248: ref where (this#248 == null) || (dtype(this#248) == AVLTreeNode#t);
  var bf#249: int where true;
  var callHeap#_630: HeapType;
  var callMask#_631: MaskType;
  var callSecMask#_632: MaskType;
  var callCredits#_633: CreditsType;
  var exhaleMask#_636: MaskType;
  var exhaleHeap#_635: HeapType;
  var isHeld#_643: int;
  var isRdHeld#_644: bool;
  var cond#_645: bool;
  var methodCallK#_650: int;
  var this#250: ref where (this#250 == null) || (dtype(this#250) == AVLTreeNode#t);
  var r#251: ref where (r#251 == null) || (dtype(r#251) == AVLTreeNode#t);
  var m#252: ref where (m#252 == null) || (dtype(m#252) == AVLTreeNode#t);
  var callHeap#_646: HeapType;
  var callMask#_647: MaskType;
  var callSecMask#_648: MaskType;
  var callCredits#_649: CreditsType;
  var exhaleMask#_652: MaskType;
  var exhaleHeap#_651: HeapType;
  var isHeld#_657: int;
  var isRdHeld#_658: bool;
  var methodCallK#_663: int;
  var this#254: ref where (this#254 == null) || (dtype(this#254) == AVLTreeNode#t);
  var r#255: ref where (r#255 == null) || (dtype(r#255) == AVLTreeNode#t);
  var m#256: ref where (m#256 == null) || (dtype(m#256) == AVLTreeNode#t);
  var callHeap#_659: HeapType;
  var callMask#_660: MaskType;
  var callSecMask#_661: MaskType;
  var callCredits#_662: CreditsType;
  var exhaleMask#_665: MaskType;
  var exhaleHeap#_664: HeapType;
  var isHeld#_670: int;
  var isRdHeld#_671: bool;
  var unfoldK#_672: int;
  var oldVers#_692: int;
  var newVers#_693: int;
  var methodCallK#_698: int;
  var this#264: ref where (this#264 == null) || (dtype(this#264) == AVLTreeNode#t);
  var callHeap#_694: HeapType;
  var callMask#_695: MaskType;
  var callSecMask#_696: MaskType;
  var callCredits#_697: CreditsType;
  var exhaleMask#_700: MaskType;
  var exhaleHeap#_699: HeapType;
  var isHeld#_715: int;
  var isRdHeld#_716: bool;
  var cond#_717: bool;
  var cond#_718: bool;
  var nl#28: ref where (nl#28 == null) || (dtype(nl#28) == AVLTreeNode#t);
  var methodCallK#_723: int;
  var this#269: ref where (this#269 == null) || (dtype(this#269) == AVLTreeNode#t);
  var k#270: int where true;
  var r#271: ref where (r#271 == null) || (dtype(r#271) == AVLTreeNode#t);
  var callHeap#_719: HeapType;
  var callMask#_720: MaskType;
  var callSecMask#_721: MaskType;
  var callCredits#_722: CreditsType;
  var exhaleMask#_725: MaskType;
  var exhaleHeap#_724: HeapType;
  var isHeld#_730: int;
  var isRdHeld#_731: bool;
  var bf#30: int where true;
  var methodCallK#_736: int;
  var this#274: ref where (this#274 == null) || (dtype(this#274) == AVLTreeNode#t);
  var bf#275: int where true;
  var callHeap#_732: HeapType;
  var callMask#_733: MaskType;
  var callSecMask#_734: MaskType;
  var callCredits#_735: CreditsType;
  var exhaleMask#_738: MaskType;
  var exhaleHeap#_737: HeapType;
  var isHeld#_745: int;
  var isRdHeld#_746: bool;
  var cond#_747: bool;
  var methodCallK#_752: int;
  var this#276: ref where (this#276 == null) || (dtype(this#276) == AVLTreeNode#t);
  var r#277: ref where (r#277 == null) || (dtype(r#277) == AVLTreeNode#t);
  var callHeap#_748: HeapType;
  var callMask#_749: MaskType;
  var callSecMask#_750: MaskType;
  var callCredits#_751: CreditsType;
  var exhaleMask#_754: MaskType;
  var exhaleHeap#_753: HeapType;
  var isHeld#_769: int;
  var isRdHeld#_770: bool;
  var methodCallK#_775: int;
  var this#282: ref where (this#282 == null) || (dtype(this#282) == AVLTreeNode#t);
  var callHeap#_771: HeapType;
  var callMask#_772: MaskType;
  var callSecMask#_773: MaskType;
  var callCredits#_774: CreditsType;
  var exhaleMask#_777: MaskType;
  var exhaleHeap#_776: HeapType;
  var isHeld#_792: int;
  var isRdHeld#_793: bool;
  var methodCallK#_798: int;
  var this#287: ref where (this#287 == null) || (dtype(this#287) == AVLTreeNode#t);
  var callHeap#_794: HeapType;
  var callMask#_795: MaskType;
  var callSecMask#_796: MaskType;
  var callCredits#_797: CreditsType;
  var exhaleMask#_800: MaskType;
  var exhaleHeap#_799: HeapType;
  var isHeld#_815: int;
  var isRdHeld#_816: bool;
  var cond#_817: bool;
  var nr#32: ref where (nr#32 == null) || (dtype(nr#32) == AVLTreeNode#t);
  var methodCallK#_822: int;
  var this#292: ref where (this#292 == null) || (dtype(this#292) == AVLTreeNode#t);
  var k#293: int where true;
  var r#294: ref where (r#294 == null) || (dtype(r#294) == AVLTreeNode#t);
  var callHeap#_818: HeapType;
  var callMask#_819: MaskType;
  var callSecMask#_820: MaskType;
  var callCredits#_821: CreditsType;
  var exhaleMask#_824: MaskType;
  var exhaleHeap#_823: HeapType;
  var isHeld#_829: int;
  var isRdHeld#_830: bool;
  var bf#34: int where true;
  var methodCallK#_835: int;
  var this#297: ref where (this#297 == null) || (dtype(this#297) == AVLTreeNode#t);
  var bf#298: int where true;
  var callHeap#_831: HeapType;
  var callMask#_832: MaskType;
  var callSecMask#_833: MaskType;
  var callCredits#_834: CreditsType;
  var exhaleMask#_837: MaskType;
  var exhaleHeap#_836: HeapType;
  var isHeld#_844: int;
  var isRdHeld#_845: bool;
  var cond#_846: bool;
  var methodCallK#_851: int;
  var this#299: ref where (this#299 == null) || (dtype(this#299) == AVLTreeNode#t);
  var r#300: ref where (r#300 == null) || (dtype(r#300) == AVLTreeNode#t);
  var callHeap#_847: HeapType;
  var callMask#_848: MaskType;
  var callSecMask#_849: MaskType;
  var callCredits#_850: CreditsType;
  var exhaleMask#_853: MaskType;
  var exhaleHeap#_852: HeapType;
  var isHeld#_868: int;
  var isRdHeld#_869: bool;
  var methodCallK#_874: int;
  var this#305: ref where (this#305 == null) || (dtype(this#305) == AVLTreeNode#t);
  var callHeap#_870: HeapType;
  var callMask#_871: MaskType;
  var callSecMask#_872: MaskType;
  var callCredits#_873: CreditsType;
  var exhaleMask#_876: MaskType;
  var exhaleHeap#_875: HeapType;
  var isHeld#_891: int;
  var isRdHeld#_892: bool;
  var methodCallK#_897: int;
  var this#310: ref where (this#310 == null) || (dtype(this#310) == AVLTreeNode#t);
  var callHeap#_893: HeapType;
  var callMask#_894: MaskType;
  var callSecMask#_895: MaskType;
  var callCredits#_896: CreditsType;
  var exhaleMask#_899: MaskType;
  var exhaleHeap#_898: HeapType;
  var isHeld#_914: int;
  var isRdHeld#_915: bool;
  var exhaleMask#_917: MaskType;
  var exhaleHeap#_916: HeapType;
  assume (0 < methodK#_506) && ((1000 * methodK#_506) < Fractions(1));
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
  Mask[this, AVLTreeNode.valid] := Mask[this, AVLTreeNode.valid][perm$R := Mask[this, AVLTreeNode.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, AVLTreeNode.keys] := Mask[this, AVLTreeNode.keys][perm$R := Mask[this, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, AVLTreeNode.height] := Mask[this, AVLTreeNode.height][perm$R := Mask[this, AVLTreeNode.height][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.height]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, AVLTreeNode.balanceFactor] := Mask[this, AVLTreeNode.balanceFactor][perm$R := Mask[this, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.balanceFactor]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume SecMask == old(SecMask);
  assume Credits == old(Credits);
  // unfold
  assume #AVLTreeNode.valid#trigger(this);
  assume (0 < unfoldK#_507) && (unfoldK#_507 < Fractions(1)) && ((1000 * unfoldK#_507) < methodK#_506);
  assert {:msg "  278.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  assert {:msg "  278.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  278.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid."} (Fractions(100) <= Mask[this, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask[this, AVLTreeNode.valid][perm$R]) ==> (0 <= Mask[this, AVLTreeNode.valid][perm$N]));
  Mask[this, AVLTreeNode.valid] := Mask[this, AVLTreeNode.valid][perm$R := Mask[this, AVLTreeNode.valid][perm$R] - Fractions(100)];
  if (false) {
    // begin exhale (update SecMask)
    if (!(Heap[this, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
      assume (forall lk#79#218: int :: (0 <= lk#79#218) && (lk#79#218 < Seq#Length(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], lk#79#218) < Heap[this, AVLTreeNode.key]));
    }
    if (!(Heap[this, AVLTreeNode.left] == null)) {
      //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
      assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
    }
    if (!(Heap[this, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
      assume (forall rk#80#219: int :: (0 <= rk#80#219) && (rk#80#219 < Seq#Length(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this, AVLTreeNode.key] < Seq#Index(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], rk#80#219)));
    }
    if (!(Heap[this, AVLTreeNode.right] == null)) {
      //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
      assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
    }
    //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
    assume Seq#Equal(Heap[this, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[this, AVLTreeNode.key])), ite(Heap[this, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys])));
    //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
    assume Seq#Contains(Heap[this, AVLTreeNode.keys], Heap[this, AVLTreeNode.key]);
    //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
    assume (forall kk#81: int :: Seq#Contains(Heap[this, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[this, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[this, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[this, AVLTreeNode.key])));
    //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
    assume Heap[this, AVLTreeNode.height] == ite(ite(Heap[this, AVLTreeNode.left] == null, 0, Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[this, AVLTreeNode.right] == null, 0, Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[this, AVLTreeNode.left] == null, 0, Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[this, AVLTreeNode.right] == null, 0, Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]) + 1);
    //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
    assume Heap[this, AVLTreeNode.balanceFactor] == (ite(Heap[this, AVLTreeNode.left] == null, 0, Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this, AVLTreeNode.right] == null, 0, Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]));
    //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
    assume Heap[this, AVLTreeNode.balanceFactor] <= 1;
    //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
    assume Heap[this, AVLTreeNode.balanceFactor] >= (0 - 1);
    //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
    assume Heap[this, AVLTreeNode.height] > 0;
    SecMask[this, AVLTreeNode.key] := SecMask[this, AVLTreeNode.key][perm$R := SecMask[this, AVLTreeNode.key][perm$R] - Fractions(100)];
    if (SecMask[this, AVLTreeNode.key][perm$R] < 0) {
      SecMask[this, AVLTreeNode.key] := SecMask[this, AVLTreeNode.key][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, AVLTreeNode.height] := SecMask[this, AVLTreeNode.height][perm$R := SecMask[this, AVLTreeNode.height][perm$R] - Fractions(50)];
    if (SecMask[this, AVLTreeNode.height][perm$R] < 0) {
      SecMask[this, AVLTreeNode.height] := SecMask[this, AVLTreeNode.height][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, AVLTreeNode.left] := SecMask[this, AVLTreeNode.left][perm$R := SecMask[this, AVLTreeNode.left][perm$R] - Fractions(100)];
    if (SecMask[this, AVLTreeNode.left][perm$R] < 0) {
      SecMask[this, AVLTreeNode.left] := SecMask[this, AVLTreeNode.left][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, AVLTreeNode.right] := SecMask[this, AVLTreeNode.right][perm$R := SecMask[this, AVLTreeNode.right][perm$R] - Fractions(100)];
    if (SecMask[this, AVLTreeNode.right][perm$R] < 0) {
      SecMask[this, AVLTreeNode.right] := SecMask[this, AVLTreeNode.right][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, AVLTreeNode.keys] := SecMask[this, AVLTreeNode.keys][perm$R := SecMask[this, AVLTreeNode.keys][perm$R] - Fractions(50)];
    if (SecMask[this, AVLTreeNode.keys][perm$R] < 0) {
      SecMask[this, AVLTreeNode.keys] := SecMask[this, AVLTreeNode.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, AVLTreeNode.balanceFactor] := SecMask[this, AVLTreeNode.balanceFactor][perm$R := SecMask[this, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    if (SecMask[this, AVLTreeNode.balanceFactor][perm$R] < 0) {
      SecMask[this, AVLTreeNode.balanceFactor] := SecMask[this, AVLTreeNode.balanceFactor][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[this, AVLTreeNode.left] == null)) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTreeNode.left] == null)) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTreeNode.left] == null)) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTreeNode.left] == null)) {
      SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTreeNode.right] == null)) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTreeNode.right] == null)) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTreeNode.right] == null)) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTreeNode.right] == null)) {
      SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(Mask, SecMask, this, AVLTreeNode.valid)) {
    oldVers#_527 := Heap[this, AVLTreeNode.valid];
    havoc newVers#_528;
    Heap[this, AVLTreeNode.valid] := newVers#_528;
    assume oldVers#_527 < Heap[this, AVLTreeNode.valid];
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (unfold)
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
  assume Fractions(50) > 0;
  Mask[this, AVLTreeNode.height] := Mask[this, AVLTreeNode.height][perm$R := Mask[this, AVLTreeNode.height][perm$R] + Fractions(50)];
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
  assume Fractions(50) > 0;
  Mask[this, AVLTreeNode.keys] := Mask[this, AVLTreeNode.keys][perm$R := Mask[this, AVLTreeNode.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTreeNode.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, AVLTreeNode.balanceFactor] := Mask[this, AVLTreeNode.balanceFactor][perm$R := Mask[this, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
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
    assume (forall lk#79#222: int :: (0 <= lk#79#222) && (lk#79#222 < Seq#Length(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], lk#79#222) < Heap[this, AVLTreeNode.key]));
  }
  if (!(Heap[this, AVLTreeNode.left] == null)) {
    assume Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
  }
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
    assume (forall rk#80#223: int :: (0 <= rk#80#223) && (rk#80#223 < Seq#Length(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this, AVLTreeNode.key] < Seq#Index(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], rk#80#223)));
  }
  if (!(Heap[this, AVLTreeNode.right] == null)) {
    assume Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
  }
  assume Seq#Equal(Heap[this, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[this, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[this, AVLTreeNode.key])), ite(Heap[this, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys])));
  assume Seq#Contains(Heap[this, AVLTreeNode.keys], Heap[this, AVLTreeNode.key]);
  assume (forall kk#81: int :: Seq#Contains(Heap[this, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[this, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[this, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[this, AVLTreeNode.key])));
  assume Heap[this, AVLTreeNode.height] == ite(ite(Heap[this, AVLTreeNode.left] == null, 0, Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[this, AVLTreeNode.right] == null, 0, Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[this, AVLTreeNode.left] == null, 0, Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[this, AVLTreeNode.right] == null, 0, Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]) + 1);
  assume Heap[this, AVLTreeNode.balanceFactor] == (ite(Heap[this, AVLTreeNode.left] == null, 0, Heap[Heap[this, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this, AVLTreeNode.right] == null, 0, Heap[Heap[this, AVLTreeNode.right], AVLTreeNode.height]));
  assume Heap[this, AVLTreeNode.balanceFactor] <= 1;
  assume Heap[this, AVLTreeNode.balanceFactor] >= (0 - 1);
  assume Heap[this, AVLTreeNode.height] > 0;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // if
  cond#_529 := Heap[this, AVLTreeNode.key] == k#19;
  assert {:msg "  279.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  279.7: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.key);
  if (cond#_529) {
    // if
    cond#_530 := (Heap[this, AVLTreeNode.left] == null) || (Heap[this, AVLTreeNode.right] == null);
    assert {:msg "  280.8: Receiver might be null."} true ==> (this != null);
    assert {:msg "  280.8: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
    assert {:msg "  280.22: Receiver might be null."} true && (!(Heap[this, AVLTreeNode.left] == null)) ==> (this != null);
    assert {:msg "  280.22: Location might not be readable."} true && (!(Heap[this, AVLTreeNode.left] == null)) ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
    if (cond#_530) {
      // assert
      assertHeap#_531 := Heap;
      assertMask#_532 := Mask;
      assertSecMask#_533 := SecMask;
      assertCredits#_534 := Credits;
      assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
      // begin exhale (assert)
      exhaleMask#_536 := assertMask#_532;
      havoc exhaleHeap#_535;
      assert {:msg "  281.12: Receiver might be null."} true ==> (this != null);
      assert {:msg "  281.12: Location might not be readable."} true ==> CanRead(assertMask#_532, assertSecMask#_533, this, AVLTreeNode.right);
      if (!(assertHeap#_531[this, AVLTreeNode.right] == null)) {
        // unfolding
        assume (0 < unfoldingK#_542) && ((1000 * unfoldingK#_542) < Fractions(1));
        predFlag#_541 := true;
        assert {:msg "  281.38: Receiver might be null."} true ==> (this != null);
        assert {:msg "  281.38: Location might not be readable."} true ==> CanRead(assertMask#_532, assertSecMask#_533, this, AVLTreeNode.right);
        assert {:msg "  281.38: Receiver might be null."} true ==> (assertHeap#_531[this, AVLTreeNode.right] != null);
        unfoldingHeap#_537 := assertHeap#_531;
        unfoldingMask#_538 := assertMask#_532;
        unfoldingSecMask#_539 := assertSecMask#_533;
        unfoldingCredits#_540 := assertCredits#_534;
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        // begin exhale (unfolding)
        assert {:msg "  281.28: Unfolding might fail. The permission at 281.38 might not be positive."} Fractions(100) > 0;
        assert {:msg "  281.28: Unfolding might fail. Insufficient fraction at 281.38 for AVLTreeNode.valid."} (Fractions(100) <= unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
        unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid] := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (false) {
          // begin exhale (update SecMask)
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
            assume (forall lk#79#224: int :: (0 <= lk#79#224) && (lk#79#224 < Seq#Length(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#224) < unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key]));
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
            assume unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
            assume (forall rk#80#225: int :: (0 <= rk#80#225) && (rk#80#225 < Seq#Length(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#225)));
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
            assume unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
          }
          //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
          assume Seq#Equal(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key])), ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
          //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
          assume Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys], unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key]);
          //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
          assume (forall kk#81: int :: Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key])));
          //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
          //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
          //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
          //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
          //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
          unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
            unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
          }
          assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
          if (unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
            unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
          }
          assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
            unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
          }
          assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
            unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
          }
          assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
          if (unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
            unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
          }
          assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          if (unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
            unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingSecMask#_539[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
          }
          assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
              unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingSecMask#_539[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
            assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          }
          assume wf(unfoldingHeap#_537, unfoldingSecMask#_539, unfoldingSecMask#_539);
          // end exhale
        }
        if (!CanRead(unfoldingMask#_538, unfoldingSecMask#_539, unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid)) {
          oldVers#_562 := unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid];
          havoc newVers#_563;
          unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid] := newVers#_563;
          assume oldVers#_562 < unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.valid];
        }
        assume IsGoodMask(unfoldingMask#_538);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume IsGoodMask(unfoldingMask#_538);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        // end exhale
        // inhale (unfolding)
        assume unfoldingHeap#_537[this, AVLTreeNode.right] != null;
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume true;
        assume Fractions(100) > 0;
        unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key] := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_538);
        assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key]));
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume unfoldingHeap#_537[this, AVLTreeNode.right] != null;
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume true;
        assume Fractions(50) > 0;
        unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height] := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(unfoldingMask#_538);
        assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height]));
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume unfoldingHeap#_537[this, AVLTreeNode.right] != null;
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume (unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null) || (dtype(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_538);
        assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left]));
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume unfoldingHeap#_537[this, AVLTreeNode.right] != null;
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume (unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null) || (dtype(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_538);
        assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right]));
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume unfoldingHeap#_537[this, AVLTreeNode.right] != null;
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume true;
        assume Fractions(50) > 0;
        unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys] := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(unfoldingMask#_538);
        assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys]));
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume unfoldingHeap#_537[this, AVLTreeNode.right] != null;
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume true;
        assume Fractions(50) > 0;
        unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_538[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(unfoldingMask#_538);
        assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume Fractions(100) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume (forall lk#79#228: int :: (0 <= lk#79#228) && (lk#79#228 < Seq#Length(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#228) < unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key]));
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume Fractions(100) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_538[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_538);
          assume IsGoodState(heapFragment(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor]));
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
          assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume (forall rk#80#229: int :: (0 <= rk#80#229) && (rk#80#229 < Seq#Length(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#229)));
        }
        if (!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
        }
        assume Seq#Equal(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key])), ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
        assume Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys], unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key]);
        assume (forall kk#81: int :: Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.key])));
        assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
        assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, unfoldingHeap#_537[unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
        assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
        assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
        assume unfoldingHeap#_537[unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
        assume IsGoodMask(unfoldingMask#_538);
        assume wf(unfoldingHeap#_537, unfoldingMask#_538, unfoldingSecMask#_539);
        // end inhale
        if (false) {
          // begin exhale (update SecMask)
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
            assume (forall lk#79#230: int :: (0 <= lk#79#230) && (lk#79#230 < Seq#Length(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#230) < assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key]));
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
            assume assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
            assume (forall rk#80#231: int :: (0 <= rk#80#231) && (rk#80#231 < Seq#Length(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#231)));
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
            assume assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
          }
          //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
          assume Seq#Equal(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key])), ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
          //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
          assume Seq#Contains(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys], assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key]);
          //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
          assume (forall kk#81: int :: Seq#Contains(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key])));
          //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
          //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
          //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
          //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
          //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
          assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] - Fractions(100)];
          if (assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] < 0) {
            assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := 0];
          }
          assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
          if (assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
            assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
          }
          assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] - Fractions(100)];
          if (assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] < 0) {
            assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := 0];
          }
          assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] - Fractions(100)];
          if (assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] < 0) {
            assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := 0];
          }
          assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
          if (assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
            assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
          }
          assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          if (assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
            assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
          }
          assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
            assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
              assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
            assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          }
          assume wf(assertHeap#_531, assertSecMask#_533, assertSecMask#_533);
          // end exhale
        }
        assume assertHeap#_531[this, AVLTreeNode.right] != null;
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume true;
        assume Fractions(100) > 0;
        assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key][perm$R] + Fractions(100)];
        assume IsGoodMask(assertMask#_532);
        assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key]));
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume assertHeap#_531[this, AVLTreeNode.right] != null;
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume true;
        assume Fractions(50) > 0;
        assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(assertMask#_532);
        assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height]));
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume assertHeap#_531[this, AVLTreeNode.right] != null;
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume (assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null) || (dtype(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left][perm$R] + Fractions(100)];
        assume IsGoodMask(assertMask#_532);
        assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left]));
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume assertHeap#_531[this, AVLTreeNode.right] != null;
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume (assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null) || (dtype(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right][perm$R] + Fractions(100)];
        assume IsGoodMask(assertMask#_532);
        assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right]));
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume assertHeap#_531[this, AVLTreeNode.right] != null;
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume true;
        assume Fractions(50) > 0;
        assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(assertMask#_532);
        assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys]));
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume assertHeap#_531[this, AVLTreeNode.right] != null;
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume true;
        assume Fractions(50) > 0;
        assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(assertMask#_532);
        assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume Fractions(100) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.valid]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.balanceFactor]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume (forall lk#79#234: int :: (0 <= lk#79#234) && (lk#79#234 < Seq#Length(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], lk#79#234) < assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key]));
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) {
          assume assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height] > 0;
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume Fractions(100) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.valid]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] != null;
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_532);
          assume IsGoodState(heapFragment(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.balanceFactor]));
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
          assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume (forall rk#80#235: int :: (0 <= rk#80#235) && (rk#80#235 < Seq#Length(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key] < Seq#Index(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], rk#80#235)));
        }
        if (!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) {
          assume assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height] > 0;
        }
        assume Seq#Equal(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, Seq#Empty(), assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key])), ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, Seq#Empty(), assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys])));
        assume Seq#Contains(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys], assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key]);
        assume (forall kk#81: int :: Seq#Contains(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys], kk#81) <==> ((((!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null)) && Seq#Contains(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null)) && Seq#Contains(assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.key])));
        assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height] == ite(ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) > ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]), ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]) + 1);
        assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] == (ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.left], AVLTreeNode.height]) - ite(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right] == null, 0, assertHeap#_531[assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.right], AVLTreeNode.height]));
        assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] <= 1;
        assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.balanceFactor] >= (0 - 1);
        assume assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.height] > 0;
        assert {:msg "  281.53: Receiver might be null."} true ==> (this != null);
        assert {:msg "  281.53: Location might not be readable."} true ==> CanRead(unfoldingMask#_538, unfoldingSecMask#_539, this, AVLTreeNode.right);
        assert {:msg "  281.53: Receiver might be null."} true ==> (unfoldingHeap#_537[this, AVLTreeNode.right] != null);
        assert {:msg "  281.53: Location might not be readable."} true ==> CanRead(unfoldingMask#_538, unfoldingSecMask#_539, unfoldingHeap#_537[this, AVLTreeNode.right], AVLTreeNode.keys);
        assert {:msg "  281.5: Assertion might not hold. The expression at 281.28 might not evaluate to true."} !Seq#Equal(assertHeap#_531[assertHeap#_531[this, AVLTreeNode.right], AVLTreeNode.keys], Seq#Empty());
      }
      assertMask#_532 := exhaleMask#_536;
      assume IsGoodExhaleState(exhaleHeap#_535, assertHeap#_531, assertMask#_532, assertSecMask#_533);
      assertHeap#_531 := exhaleHeap#_535;
      assume IsGoodMask(assertMask#_532);
      assume wf(assertHeap#_531, assertMask#_532, assertSecMask#_533);
      // end exhale
      // assert
      assertHeap#_580 := Heap;
      assertMask#_581 := Mask;
      assertSecMask#_582 := SecMask;
      assertCredits#_583 := Credits;
      assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
      // begin exhale (assert)
      exhaleMask#_585 := assertMask#_581;
      havoc exhaleHeap#_584;
      assert {:msg "  282.12: Receiver might be null."} true ==> (this != null);
      assert {:msg "  282.12: Location might not be readable."} true ==> CanRead(assertMask#_581, assertSecMask#_582, this, AVLTreeNode.left);
      if (!(assertHeap#_580[this, AVLTreeNode.left] == null)) {
        // unfolding
        assume (0 < unfoldingK#_591) && ((1000 * unfoldingK#_591) < Fractions(1));
        predFlag#_590 := true;
        assert {:msg "  282.38: Receiver might be null."} true ==> (this != null);
        assert {:msg "  282.38: Location might not be readable."} true ==> CanRead(assertMask#_581, assertSecMask#_582, this, AVLTreeNode.left);
        assert {:msg "  282.38: Receiver might be null."} true ==> (assertHeap#_580[this, AVLTreeNode.left] != null);
        unfoldingHeap#_586 := assertHeap#_580;
        unfoldingMask#_587 := assertMask#_581;
        unfoldingSecMask#_588 := assertSecMask#_582;
        unfoldingCredits#_589 := assertCredits#_583;
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        // begin exhale (unfolding)
        assert {:msg "  282.28: Unfolding might fail. The permission at 282.38 might not be positive."} Fractions(100) > 0;
        assert {:msg "  282.28: Unfolding might fail. Insufficient fraction at 282.38 for AVLTreeNode.valid."} (Fractions(100) <= unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
        unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid] := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (false) {
          // begin exhale (update SecMask)
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
            assume (forall lk#79#236: int :: (0 <= lk#79#236) && (lk#79#236 < Seq#Length(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#236) < unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key]));
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
            assume unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
            assume (forall rk#80#237: int :: (0 <= rk#80#237) && (rk#80#237 < Seq#Length(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#237)));
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
            assume unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
          }
          //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
          assume Seq#Equal(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key])), ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
          //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
          assume Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys], unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key]);
          //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
          assume (forall kk#81: int :: Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key])));
          //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
          //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
          //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
          //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
          //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
          unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
            unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
          }
          assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
          if (unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
            unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
          }
          assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
            unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
          }
          assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
          if (unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
            unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
          }
          assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
          if (unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
            unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
          }
          assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          if (unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
            unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingSecMask#_588[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
          }
          assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
              unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingSecMask#_588[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
            assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          }
          assume wf(unfoldingHeap#_586, unfoldingSecMask#_588, unfoldingSecMask#_588);
          // end exhale
        }
        if (!CanRead(unfoldingMask#_587, unfoldingSecMask#_588, unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid)) {
          oldVers#_611 := unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid];
          havoc newVers#_612;
          unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid] := newVers#_612;
          assume oldVers#_611 < unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.valid];
        }
        assume IsGoodMask(unfoldingMask#_587);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume IsGoodMask(unfoldingMask#_587);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        // end exhale
        // inhale (unfolding)
        assume unfoldingHeap#_586[this, AVLTreeNode.left] != null;
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume true;
        assume Fractions(100) > 0;
        unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key] := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_587);
        assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key]));
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume unfoldingHeap#_586[this, AVLTreeNode.left] != null;
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume true;
        assume Fractions(50) > 0;
        unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height] := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(unfoldingMask#_587);
        assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height]));
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume unfoldingHeap#_586[this, AVLTreeNode.left] != null;
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume (unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null) || (dtype(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_587);
        assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left]));
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume unfoldingHeap#_586[this, AVLTreeNode.left] != null;
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume (unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null) || (dtype(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] + Fractions(100)];
        assume IsGoodMask(unfoldingMask#_587);
        assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right]));
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume unfoldingHeap#_586[this, AVLTreeNode.left] != null;
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume true;
        assume Fractions(50) > 0;
        unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys] := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(unfoldingMask#_587);
        assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys]));
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume unfoldingHeap#_586[this, AVLTreeNode.left] != null;
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume true;
        assume Fractions(50) > 0;
        unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_587[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(unfoldingMask#_587);
        assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume Fractions(100) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume (forall lk#79#240: int :: (0 <= lk#79#240) && (lk#79#240 < Seq#Length(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#240) < unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key]));
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume Fractions(100) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume true;
          assume Fractions(50) > 0;
          unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_587[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(unfoldingMask#_587);
          assume IsGoodState(heapFragment(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor]));
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
          assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume (forall rk#80#241: int :: (0 <= rk#80#241) && (rk#80#241 < Seq#Length(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#241)));
        }
        if (!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
        }
        assume Seq#Equal(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key])), ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
        assume Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys], unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key]);
        assume (forall kk#81: int :: Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.key])));
        assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
        assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, unfoldingHeap#_586[unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
        assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
        assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
        assume unfoldingHeap#_586[unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
        assume IsGoodMask(unfoldingMask#_587);
        assume wf(unfoldingHeap#_586, unfoldingMask#_587, unfoldingSecMask#_588);
        // end inhale
        if (false) {
          // begin exhale (update SecMask)
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
            assume (forall lk#79#242: int :: (0 <= lk#79#242) && (lk#79#242 < Seq#Length(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#242) < assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key]));
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
            assume assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
            assume (forall rk#80#243: int :: (0 <= rk#80#243) && (rk#80#243 < Seq#Length(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#243)));
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
            assume assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
          }
          //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
          assume Seq#Equal(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key])), ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
          //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
          assume Seq#Contains(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys], assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key]);
          //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
          assume (forall kk#81: int :: Seq#Contains(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key])));
          //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
          //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
          //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
          //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
          //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
          assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] - Fractions(100)];
          if (assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] < 0) {
            assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := 0];
          }
          assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
          if (assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
            assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
          }
          assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] - Fractions(100)];
          if (assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] < 0) {
            assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := 0];
          }
          assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] - Fractions(100)];
          if (assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] < 0) {
            assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := 0];
          }
          assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
          if (assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
            assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
          }
          assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          if (assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
            assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
          }
          assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
            assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            if (assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
              assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
            }
            assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
            assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          }
          assume wf(assertHeap#_580, assertSecMask#_582, assertSecMask#_582);
          // end exhale
        }
        assume assertHeap#_580[this, AVLTreeNode.left] != null;
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume true;
        assume Fractions(100) > 0;
        assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key][perm$R] + Fractions(100)];
        assume IsGoodMask(assertMask#_581);
        assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key]));
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume assertHeap#_580[this, AVLTreeNode.left] != null;
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume true;
        assume Fractions(50) > 0;
        assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(assertMask#_581);
        assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height]));
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume assertHeap#_580[this, AVLTreeNode.left] != null;
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume (assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null) || (dtype(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left][perm$R] + Fractions(100)];
        assume IsGoodMask(assertMask#_581);
        assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left]));
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume assertHeap#_580[this, AVLTreeNode.left] != null;
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume (assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null) || (dtype(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right]) == AVLTreeNode#t);
        assume Fractions(100) > 0;
        assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right][perm$R] + Fractions(100)];
        assume IsGoodMask(assertMask#_581);
        assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right]));
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume assertHeap#_580[this, AVLTreeNode.left] != null;
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume true;
        assume Fractions(50) > 0;
        assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(assertMask#_581);
        assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys]));
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume assertHeap#_580[this, AVLTreeNode.left] != null;
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume true;
        assume Fractions(50) > 0;
        assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(assertMask#_581);
        assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume Fractions(100) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.valid]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.balanceFactor]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume (forall lk#79#246: int :: (0 <= lk#79#246) && (lk#79#246 < Seq#Length(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], lk#79#246) < assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key]));
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) {
          assume assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height] > 0;
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume Fractions(100) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.valid]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] != null;
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume true;
          assume Fractions(50) > 0;
          assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor] := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(assertMask#_581);
          assume IsGoodState(heapFragment(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.balanceFactor]));
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
          assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume (forall rk#80#247: int :: (0 <= rk#80#247) && (rk#80#247 < Seq#Length(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])) ==> (assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key] < Seq#Index(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], rk#80#247)));
        }
        if (!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) {
          assume assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height] > 0;
        }
        assume Seq#Equal(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Append(Seq#Append(ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, Seq#Empty(), assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key])), ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, Seq#Empty(), assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys])));
        assume Seq#Contains(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys], assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key]);
        assume (forall kk#81: int :: Seq#Contains(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys], kk#81) <==> ((((!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null)) && Seq#Contains(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null)) && Seq#Contains(assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.key])));
        assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height] == ite(ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) > ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]), ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]) + 1);
        assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] == (ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.left], AVLTreeNode.height]) - ite(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right] == null, 0, assertHeap#_580[assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.right], AVLTreeNode.height]));
        assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] <= 1;
        assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.balanceFactor] >= (0 - 1);
        assume assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.height] > 0;
        assert {:msg "  282.53: Receiver might be null."} true ==> (this != null);
        assert {:msg "  282.53: Location might not be readable."} true ==> CanRead(unfoldingMask#_587, unfoldingSecMask#_588, this, AVLTreeNode.left);
        assert {:msg "  282.53: Receiver might be null."} true ==> (unfoldingHeap#_586[this, AVLTreeNode.left] != null);
        assert {:msg "  282.53: Location might not be readable."} true ==> CanRead(unfoldingMask#_587, unfoldingSecMask#_588, unfoldingHeap#_586[this, AVLTreeNode.left], AVLTreeNode.keys);
        assert {:msg "  282.5: Assertion might not hold. The expression at 282.28 might not evaluate to true."} !Seq#Equal(assertHeap#_580[assertHeap#_580[this, AVLTreeNode.left], AVLTreeNode.keys], Seq#Empty());
      }
      assertMask#_581 := exhaleMask#_585;
      assume IsGoodExhaleState(exhaleHeap#_584, assertHeap#_580, assertMask#_581, assertSecMask#_582);
      assertHeap#_580 := exhaleHeap#_584;
      assume IsGoodMask(assertMask#_581);
      assume wf(assertHeap#_580, assertMask#_581, assertSecMask#_582);
      // end exhale
      // if
      cond#_629 := Heap[this, AVLTreeNode.left] == null;
      assert {:msg "  283.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  283.9: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
      if (cond#_629) {
        // assigment to r
        assert {:msg "  284.11: Receiver might be null."} true ==> (this != null);
        assert {:msg "  284.11: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
        r#20 := Heap[this, AVLTreeNode.right];
      } else {
        // assigment to r
        assert {:msg "  286.11: Receiver might be null."} true ==> (this != null);
        assert {:msg "  286.11: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
        r#20 := Heap[this, AVLTreeNode.left];
      }
    } else {
      // local var bf
      // local var nl
      // assigment to nl
      assert {:msg "  290.29: Receiver might be null."} true ==> (this != null);
      assert {:msg "  290.29: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
      nl#24 := Heap[this, AVLTreeNode.left];
      // local var nr
      // assigment to nr
      assert {:msg "  291.29: Receiver might be null."} true ==> (this != null);
      assert {:msg "  291.29: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
      nr#26 := Heap[this, AVLTreeNode.right];
      assume (0 < methodCallK#_634) && ((1000 * methodCallK#_634) < Fractions(1)) && ((1000 * methodCallK#_634) < methodK#_506);
      // call getBalanceFactorI
      callHeap#_630 := Heap;
      callMask#_631 := Mask;
      callSecMask#_632 := SecMask;
      callCredits#_633 := Credits;
      assume wf(callHeap#_630, callMask#_631, callSecMask#_632);
      assert {:msg "  293.5: The target of the method call might be null."} this != null;
      this#248 := this;
      // begin exhale (precondition)
      exhaleMask#_636 := Mask;
      havoc exhaleHeap#_635;
      assert {:msg "  293.5: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive."} methodCallK#_634 > 0;
      assert {:msg "  293.5: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left."} exhaleMask#_636[this#248, AVLTreeNode.left][perm$R] > 0;
      assume methodCallK#_634 < exhaleMask#_636[this#248, AVLTreeNode.left][perm$R];
      exhaleMask#_636[this#248, AVLTreeNode.left] := exhaleMask#_636[this#248, AVLTreeNode.left][perm$R := exhaleMask#_636[this#248, AVLTreeNode.left][perm$R] - methodCallK#_634];
      assume IsGoodMask(exhaleMask#_636);
      assume wf(Heap, exhaleMask#_636, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[this#248, AVLTreeNode.left] == null)) {
        assert {:msg "  293.5: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive."} methodCallK#_634 > 0;
        assert {:msg "  293.5: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height."} exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height][perm$R] > 0;
        assume methodCallK#_634 < exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height][perm$R];
        exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height][perm$R] - methodCallK#_634];
        assume IsGoodMask(exhaleMask#_636);
        assume wf(Heap, exhaleMask#_636, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assert {:msg "  293.5: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive."} methodCallK#_634 > 0;
      assert {:msg "  293.5: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right."} exhaleMask#_636[this#248, AVLTreeNode.right][perm$R] > 0;
      assume methodCallK#_634 < exhaleMask#_636[this#248, AVLTreeNode.right][perm$R];
      exhaleMask#_636[this#248, AVLTreeNode.right] := exhaleMask#_636[this#248, AVLTreeNode.right][perm$R := exhaleMask#_636[this#248, AVLTreeNode.right][perm$R] - methodCallK#_634];
      assume IsGoodMask(exhaleMask#_636);
      assume wf(Heap, exhaleMask#_636, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[this#248, AVLTreeNode.right] == null)) {
        assert {:msg "  293.5: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive."} methodCallK#_634 > 0;
        assert {:msg "  293.5: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height."} exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height][perm$R] > 0;
        assume methodCallK#_634 < exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height][perm$R];
        exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height][perm$R] - methodCallK#_634];
        assume IsGoodMask(exhaleMask#_636);
        assume wf(Heap, exhaleMask#_636, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#248, AVLTreeNode.left] == null)) {
        assert {:msg "  293.5: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive."} Fractions(100) > 0;
        assert {:msg "  293.5: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
        exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_636[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_636, SecMask, Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid)) {
          assume Heap[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_635[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_636);
        assume wf(Heap, exhaleMask#_636, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#248, AVLTreeNode.right] == null)) {
        assert {:msg "  293.5: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive."} Fractions(100) > 0;
        assert {:msg "  293.5: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
        exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_636[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_636, SecMask, Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid)) {
          assume Heap[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_635[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_636);
        assume wf(Heap, exhaleMask#_636, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      Mask := exhaleMask#_636;
      assume IsGoodExhaleState(exhaleHeap#_635, Heap, Mask, SecMask);
      Heap := exhaleHeap#_635;
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      havoc bf#249;
      // inhale (postcondition)
      assume this#248 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[this#248, AVLTreeNode.left] == null) || (dtype(Heap[this#248, AVLTreeNode.left]) == AVLTreeNode#t);
      assume methodCallK#_634 > 0;
      Mask[this#248, AVLTreeNode.left] := Mask[this#248, AVLTreeNode.left][perm$R := Mask[this#248, AVLTreeNode.left][perm$R] + methodCallK#_634];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[this#248, AVLTreeNode.left]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[this#248, AVLTreeNode.left] == null)) {
        assume Heap[this#248, AVLTreeNode.left] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[this#248, AVLTreeNode.left], AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#248, AVLTreeNode.left] == null)) {
        assume Heap[this#248, AVLTreeNode.left] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume methodCallK#_634 > 0;
        Mask[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height][perm$R] + methodCallK#_634];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume this#248 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[this#248, AVLTreeNode.right] == null) || (dtype(Heap[this#248, AVLTreeNode.right]) == AVLTreeNode#t);
      assume methodCallK#_634 > 0;
      Mask[this#248, AVLTreeNode.right] := Mask[this#248, AVLTreeNode.right][perm$R := Mask[this#248, AVLTreeNode.right][perm$R] + methodCallK#_634];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[this#248, AVLTreeNode.right]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[this#248, AVLTreeNode.right] == null)) {
        assume Heap[this#248, AVLTreeNode.right] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[this#248, AVLTreeNode.right], AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#248, AVLTreeNode.right] == null)) {
        assume Heap[this#248, AVLTreeNode.right] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume methodCallK#_634 > 0;
        Mask[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height][perm$R] + methodCallK#_634];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      assume bf#249 == (ite(Heap[this#248, AVLTreeNode.left] == null, 0, Heap[Heap[this#248, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#248, AVLTreeNode.right] == null, 0, Heap[Heap[this#248, AVLTreeNode.right], AVLTreeNode.height]));
      if (bf#249 > 0) {
        assume !(Heap[this#248, AVLTreeNode.left] == null);
      }
      if (bf#249 < 0) {
        assume !(Heap[this#248, AVLTreeNode.right] == null);
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      bf#22 := bf#249;
      // if
      cond#_645 := bf#22 > 0;
      if (cond#_645) {
        assume (0 < methodCallK#_650) && ((1000 * methodCallK#_650) < Fractions(1)) && ((1000 * methodCallK#_650) < methodK#_506);
        // call pruneMax
        callHeap#_646 := Heap;
        callMask#_647 := Mask;
        callSecMask#_648 := SecMask;
        callCredits#_649 := Credits;
        assume wf(callHeap#_646, callMask#_647, callSecMask#_648);
        assert {:msg "  295.19: Receiver might be null."} true ==> (this != null);
        assert {:msg "  295.19: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
        assert {:msg "  295.6: The target of the method call might be null."} Heap[this, AVLTreeNode.left] != null;
        this#250 := Heap[this, AVLTreeNode.left];
        // begin exhale (precondition)
        exhaleMask#_652 := Mask;
        havoc exhaleHeap#_651;
        assert {:msg "  295.6: The precondition at 349.12 might not hold. The permission at 349.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  295.6: The precondition at 349.12 might not hold. Insufficient fraction at 349.12 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_652[this#250, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_652[this#250, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_652[this#250, AVLTreeNode.valid][perm$N]));
        exhaleMask#_652[this#250, AVLTreeNode.valid] := exhaleMask#_652[this#250, AVLTreeNode.valid][perm$R := exhaleMask#_652[this#250, AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_652, SecMask, this#250, AVLTreeNode.valid)) {
          assume Heap[this#250, AVLTreeNode.valid] < exhaleHeap#_651[this#250, AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_652);
        assume wf(Heap, exhaleMask#_652, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  295.6: The precondition at 350.12 might not hold. The permission at 350.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  295.6: The precondition at 350.12 might not hold. Insufficient fraction at 350.12 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_652[this#250, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_652[this#250, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_652[this#250, AVLTreeNode.keys][perm$N]));
        exhaleMask#_652[this#250, AVLTreeNode.keys] := exhaleMask#_652[this#250, AVLTreeNode.keys][perm$R := exhaleMask#_652[this#250, AVLTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_652);
        assume wf(Heap, exhaleMask#_652, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  295.6: The precondition at 351.12 might not hold. The permission at 351.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  295.6: The precondition at 351.12 might not hold. Insufficient fraction at 351.12 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_652[this#250, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_652[this#250, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_652[this#250, AVLTreeNode.height][perm$N]));
        exhaleMask#_652[this#250, AVLTreeNode.height] := exhaleMask#_652[this#250, AVLTreeNode.height][perm$R := exhaleMask#_652[this#250, AVLTreeNode.height][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_652);
        assume wf(Heap, exhaleMask#_652, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  295.6: The precondition at 352.12 might not hold. The permission at 352.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  295.6: The precondition at 352.12 might not hold. Insufficient fraction at 352.12 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_652[this#250, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_652[this#250, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_652[this#250, AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_652[this#250, AVLTreeNode.balanceFactor] := exhaleMask#_652[this#250, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_652[this#250, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_652);
        assume wf(Heap, exhaleMask#_652, SecMask);
        assume wf(Heap, Mask, SecMask);
        Mask := exhaleMask#_652;
        assume IsGoodExhaleState(exhaleHeap#_651, Heap, Mask, SecMask);
        Heap := exhaleHeap#_651;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        havoc r#251;
        havoc m#252;
        // inhale (postcondition)
        if (!(r#251 == null)) {
          assume r#251 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[r#251, AVLTreeNode.valid] := Mask[r#251, AVLTreeNode.valid][perm$R := Mask[r#251, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#251, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#251 == null)) {
          assume r#251 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#251, AVLTreeNode.keys] := Mask[r#251, AVLTreeNode.keys][perm$R := Mask[r#251, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#251, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#251 == null)) {
          assume r#251 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#251, AVLTreeNode.height] := Mask[r#251, AVLTreeNode.height][perm$R := Mask[r#251, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#251, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#251 == null)) {
          assume r#251 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#251, AVLTreeNode.balanceFactor] := Mask[r#251, AVLTreeNode.balanceFactor][perm$R := Mask[r#251, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#251, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#251 == null)) {
          assume (Heap[r#251, AVLTreeNode.height] == callHeap#_646[this#250, AVLTreeNode.height]) || ((Heap[r#251, AVLTreeNode.height] + 1) == callHeap#_646[this#250, AVLTreeNode.height]);
        }
        if (!(r#251 == null)) {
          assume (Seq#Length(Heap[r#251, AVLTreeNode.keys]) + 1) == Seq#Length(callHeap#_646[this#250, AVLTreeNode.keys]);
        }
        if (callHeap#_646[this#250, AVLTreeNode.height] > 1) {
          assume !(r#251 == null);
        }
        if (callHeap#_646[this#250, AVLTreeNode.height] == 1) {
          assume r#251 == null;
        }
        assume (callHeap#_646[this#250, AVLTreeNode.height] == ite(r#251 == null, 0, Heap[r#251, AVLTreeNode.height])) || (callHeap#_646[this#250, AVLTreeNode.height] == (ite(r#251 == null, 0, Heap[r#251, AVLTreeNode.height]) + 1));
        assume !(m#252 == null);
        assume m#252 != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[m#252, AVLTreeNode.valid] := Mask[m#252, AVLTreeNode.valid][perm$R := Mask[m#252, AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#252, AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume m#252 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[m#252, AVLTreeNode.keys] := Mask[m#252, AVLTreeNode.keys][perm$R := Mask[m#252, AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#252, AVLTreeNode.keys]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume m#252 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[m#252, AVLTreeNode.height] := Mask[m#252, AVLTreeNode.height][perm$R := Mask[m#252, AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#252, AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume m#252 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[m#252, AVLTreeNode.balanceFactor] := Mask[m#252, AVLTreeNode.balanceFactor][perm$R := Mask[m#252, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#252, AVLTreeNode.balanceFactor]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[m#252, AVLTreeNode.height] == 1;
        assume Seq#Length(Heap[m#252, AVLTreeNode.keys]) == 1;
        assume Seq#Equal(Seq#Append(ite(r#251 == null, Seq#Empty(), Heap[r#251, AVLTreeNode.keys]), Heap[m#252, AVLTreeNode.keys]), callHeap#_646[this#250, AVLTreeNode.keys]);
        if (!(r#251 == null)) {
          assume (forall k#86#253: int :: (0 <= k#86#253) && (k#86#253 < Seq#Length(Heap[r#251, AVLTreeNode.keys])) ==> (Seq#Index(Heap[r#251, AVLTreeNode.keys], k#86#253) < Seq#Index(Heap[m#252, AVLTreeNode.keys], 0)));
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
        nl#24 := r#251;
        r#20 := m#252;
      } else {
        assume (0 < methodCallK#_663) && ((1000 * methodCallK#_663) < Fractions(1)) && ((1000 * methodCallK#_663) < methodK#_506);
        // call pruneMin
        callHeap#_659 := Heap;
        callMask#_660 := Mask;
        callSecMask#_661 := SecMask;
        callCredits#_662 := Credits;
        assume wf(callHeap#_659, callMask#_660, callSecMask#_661);
        assert {:msg "  297.19: Receiver might be null."} true ==> (this != null);
        assert {:msg "  297.19: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
        assert {:msg "  297.6: The target of the method call might be null."} Heap[this, AVLTreeNode.right] != null;
        this#254 := Heap[this, AVLTreeNode.right];
        // begin exhale (precondition)
        exhaleMask#_665 := Mask;
        havoc exhaleHeap#_664;
        assert {:msg "  297.6: The precondition at 404.12 might not hold. The permission at 404.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  297.6: The precondition at 404.12 might not hold. Insufficient fraction at 404.12 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_665[this#254, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_665[this#254, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_665[this#254, AVLTreeNode.valid][perm$N]));
        exhaleMask#_665[this#254, AVLTreeNode.valid] := exhaleMask#_665[this#254, AVLTreeNode.valid][perm$R := exhaleMask#_665[this#254, AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_665, SecMask, this#254, AVLTreeNode.valid)) {
          assume Heap[this#254, AVLTreeNode.valid] < exhaleHeap#_664[this#254, AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_665);
        assume wf(Heap, exhaleMask#_665, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  297.6: The precondition at 405.12 might not hold. The permission at 405.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  297.6: The precondition at 405.12 might not hold. Insufficient fraction at 405.12 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_665[this#254, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_665[this#254, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_665[this#254, AVLTreeNode.keys][perm$N]));
        exhaleMask#_665[this#254, AVLTreeNode.keys] := exhaleMask#_665[this#254, AVLTreeNode.keys][perm$R := exhaleMask#_665[this#254, AVLTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_665);
        assume wf(Heap, exhaleMask#_665, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  297.6: The precondition at 406.12 might not hold. The permission at 406.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  297.6: The precondition at 406.12 might not hold. Insufficient fraction at 406.12 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_665[this#254, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_665[this#254, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_665[this#254, AVLTreeNode.height][perm$N]));
        exhaleMask#_665[this#254, AVLTreeNode.height] := exhaleMask#_665[this#254, AVLTreeNode.height][perm$R := exhaleMask#_665[this#254, AVLTreeNode.height][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_665);
        assume wf(Heap, exhaleMask#_665, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  297.6: The precondition at 407.12 might not hold. The permission at 407.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  297.6: The precondition at 407.12 might not hold. Insufficient fraction at 407.12 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_665[this#254, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_665[this#254, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_665[this#254, AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_665[this#254, AVLTreeNode.balanceFactor] := exhaleMask#_665[this#254, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_665[this#254, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_665);
        assume wf(Heap, exhaleMask#_665, SecMask);
        assume wf(Heap, Mask, SecMask);
        Mask := exhaleMask#_665;
        assume IsGoodExhaleState(exhaleHeap#_664, Heap, Mask, SecMask);
        Heap := exhaleHeap#_664;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        havoc r#255;
        havoc m#256;
        // inhale (postcondition)
        if (!(r#255 == null)) {
          assume r#255 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[r#255, AVLTreeNode.valid] := Mask[r#255, AVLTreeNode.valid][perm$R := Mask[r#255, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#255, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#255 == null)) {
          assume r#255 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#255, AVLTreeNode.keys] := Mask[r#255, AVLTreeNode.keys][perm$R := Mask[r#255, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#255, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#255 == null)) {
          assume r#255 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#255, AVLTreeNode.height] := Mask[r#255, AVLTreeNode.height][perm$R := Mask[r#255, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#255, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#255 == null)) {
          assume r#255 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#255, AVLTreeNode.balanceFactor] := Mask[r#255, AVLTreeNode.balanceFactor][perm$R := Mask[r#255, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#255, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#255 == null)) {
          assume (Heap[r#255, AVLTreeNode.height] == callHeap#_659[this#254, AVLTreeNode.height]) || (Heap[r#255, AVLTreeNode.height] == (callHeap#_659[this#254, AVLTreeNode.height] - 1));
        }
        if (!(r#255 == null)) {
          assume (Seq#Length(Heap[r#255, AVLTreeNode.keys]) + 1) == Seq#Length(callHeap#_659[this#254, AVLTreeNode.keys]);
        }
        if (callHeap#_659[this#254, AVLTreeNode.height] > 1) {
          assume !(r#255 == null);
        }
        if (callHeap#_659[this#254, AVLTreeNode.height] == 1) {
          assume r#255 == null;
        }
        assume (callHeap#_659[this#254, AVLTreeNode.height] == ite(r#255 == null, 0, Heap[r#255, AVLTreeNode.height])) || (callHeap#_659[this#254, AVLTreeNode.height] == (ite(r#255 == null, 0, Heap[r#255, AVLTreeNode.height]) + 1));
        assume !(m#256 == null);
        assume m#256 != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[m#256, AVLTreeNode.valid] := Mask[m#256, AVLTreeNode.valid][perm$R := Mask[m#256, AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#256, AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume m#256 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[m#256, AVLTreeNode.keys] := Mask[m#256, AVLTreeNode.keys][perm$R := Mask[m#256, AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#256, AVLTreeNode.keys]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume m#256 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[m#256, AVLTreeNode.height] := Mask[m#256, AVLTreeNode.height][perm$R := Mask[m#256, AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#256, AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume m#256 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[m#256, AVLTreeNode.balanceFactor] := Mask[m#256, AVLTreeNode.balanceFactor][perm$R := Mask[m#256, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[m#256, AVLTreeNode.balanceFactor]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Heap[m#256, AVLTreeNode.height] == 1;
        assume Seq#Length(Heap[m#256, AVLTreeNode.keys]) == 1;
        assume Seq#Equal(Seq#Append(Heap[m#256, AVLTreeNode.keys], ite(r#255 == null, Seq#Empty(), Heap[r#255, AVLTreeNode.keys])), callHeap#_659[this#254, AVLTreeNode.keys]);
        if (!(r#255 == null)) {
          assume (forall k#89#257: int :: (0 <= k#89#257) && (k#89#257 < Seq#Length(Heap[r#255, AVLTreeNode.keys])) ==> (Seq#Index(Heap[m#256, AVLTreeNode.keys], 0) < Seq#Index(Heap[r#255, AVLTreeNode.keys], k#89#257)));
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
        nr#26 := r#255;
        r#20 := m#256;
      }
      // unfold
      assume #AVLTreeNode.valid#trigger(r#20);
      assume (0 < unfoldK#_672) && (unfoldK#_672 < Fractions(1)) && ((1000 * unfoldK#_672) < methodK#_506);
      assert {:msg "  299.5: The target of the fold statement might be null."} r#20 != null;
      // begin exhale (unfold)
      assert {:msg "  299.5: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
      assert {:msg "  299.5: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid."} (Fractions(100) <= Mask[r#20, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask[r#20, AVLTreeNode.valid][perm$R]) ==> (0 <= Mask[r#20, AVLTreeNode.valid][perm$N]));
      Mask[r#20, AVLTreeNode.valid] := Mask[r#20, AVLTreeNode.valid][perm$R := Mask[r#20, AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (false) {
        // begin exhale (update SecMask)
        if (!(Heap[r#20, AVLTreeNode.left] == null)) {
          //  assert <undefined position>:  The expression at 129.22 might not evaluate to true.
          assume (forall lk#79#258: int :: (0 <= lk#79#258) && (lk#79#258 < Seq#Length(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys], lk#79#258) < Heap[r#20, AVLTreeNode.key]));
        }
        if (!(Heap[r#20, AVLTreeNode.left] == null)) {
          //  assert <undefined position>:  The expression at 130.22 might not evaluate to true.
          assume Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height] > 0;
        }
        if (!(Heap[r#20, AVLTreeNode.right] == null)) {
          //  assert <undefined position>:  The expression at 136.24 might not evaluate to true.
          assume (forall rk#80#259: int :: (0 <= rk#80#259) && (rk#80#259 < Seq#Length(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#20, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys], rk#80#259)));
        }
        if (!(Heap[r#20, AVLTreeNode.right] == null)) {
          //  assert <undefined position>:  The expression at 137.23 might not evaluate to true.
          assume Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height] > 0;
        }
        //  assert <undefined position>:  The expression at 139.6 might not evaluate to true.
        assume Seq#Equal(Heap[r#20, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#20, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#20, AVLTreeNode.key])), ite(Heap[r#20, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys])));
        //  assert <undefined position>:  The expression at 140.6 might not evaluate to true.
        assume Seq#Contains(Heap[r#20, AVLTreeNode.keys], Heap[r#20, AVLTreeNode.key]);
        //  assert <undefined position>:  The expression at 141.7 might not evaluate to true.
        assume (forall kk#81: int :: Seq#Contains(Heap[r#20, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#20, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#20, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#20, AVLTreeNode.key])));
        //  assert <undefined position>:  The expression at 146.6 might not evaluate to true.
        assume Heap[r#20, AVLTreeNode.height] == ite(ite(Heap[r#20, AVLTreeNode.left] == null, 0, Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#20, AVLTreeNode.right] == null, 0, Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#20, AVLTreeNode.left] == null, 0, Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#20, AVLTreeNode.right] == null, 0, Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height]) + 1);
        //  assert <undefined position>:  The expression at 147.6 might not evaluate to true.
        assume Heap[r#20, AVLTreeNode.balanceFactor] == (ite(Heap[r#20, AVLTreeNode.left] == null, 0, Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#20, AVLTreeNode.right] == null, 0, Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height]));
        //  assert <undefined position>:  The expression at 148.6 might not evaluate to true.
        assume Heap[r#20, AVLTreeNode.balanceFactor] <= 1;
        //  assert <undefined position>:  The expression at 149.6 might not evaluate to true.
        assume Heap[r#20, AVLTreeNode.balanceFactor] >= (0 - 1);
        //  assert <undefined position>:  The expression at 150.6 might not evaluate to true.
        assume Heap[r#20, AVLTreeNode.height] > 0;
        SecMask[r#20, AVLTreeNode.key] := SecMask[r#20, AVLTreeNode.key][perm$R := SecMask[r#20, AVLTreeNode.key][perm$R] - Fractions(100)];
        if (SecMask[r#20, AVLTreeNode.key][perm$R] < 0) {
          SecMask[r#20, AVLTreeNode.key] := SecMask[r#20, AVLTreeNode.key][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[r#20, AVLTreeNode.height] := SecMask[r#20, AVLTreeNode.height][perm$R := SecMask[r#20, AVLTreeNode.height][perm$R] - Fractions(50)];
        if (SecMask[r#20, AVLTreeNode.height][perm$R] < 0) {
          SecMask[r#20, AVLTreeNode.height] := SecMask[r#20, AVLTreeNode.height][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[r#20, AVLTreeNode.left] := SecMask[r#20, AVLTreeNode.left][perm$R := SecMask[r#20, AVLTreeNode.left][perm$R] - Fractions(100)];
        if (SecMask[r#20, AVLTreeNode.left][perm$R] < 0) {
          SecMask[r#20, AVLTreeNode.left] := SecMask[r#20, AVLTreeNode.left][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[r#20, AVLTreeNode.right] := SecMask[r#20, AVLTreeNode.right][perm$R := SecMask[r#20, AVLTreeNode.right][perm$R] - Fractions(100)];
        if (SecMask[r#20, AVLTreeNode.right][perm$R] < 0) {
          SecMask[r#20, AVLTreeNode.right] := SecMask[r#20, AVLTreeNode.right][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[r#20, AVLTreeNode.keys] := SecMask[r#20, AVLTreeNode.keys][perm$R := SecMask[r#20, AVLTreeNode.keys][perm$R] - Fractions(50)];
        if (SecMask[r#20, AVLTreeNode.keys][perm$R] < 0) {
          SecMask[r#20, AVLTreeNode.keys] := SecMask[r#20, AVLTreeNode.keys][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        SecMask[r#20, AVLTreeNode.balanceFactor] := SecMask[r#20, AVLTreeNode.balanceFactor][perm$R := SecMask[r#20, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        if (SecMask[r#20, AVLTreeNode.balanceFactor][perm$R] < 0) {
          SecMask[r#20, AVLTreeNode.balanceFactor] := SecMask[r#20, AVLTreeNode.balanceFactor][perm$R := 0];
        }
        assume wf(Heap, SecMask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[r#20, AVLTreeNode.left] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid][perm$R := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[r#20, AVLTreeNode.left] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height][perm$R := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
          if (SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[r#20, AVLTreeNode.left] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys][perm$R := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
          if (SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[r#20, AVLTreeNode.left] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          if (SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor] := SecMask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[r#20, AVLTreeNode.right] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid][perm$R := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[r#20, AVLTreeNode.right] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height][perm$R := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
          if (SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[r#20, AVLTreeNode.right] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys][perm$R := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
          if (SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[r#20, AVLTreeNode.right] == null)) {
          SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          if (SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] < 0) {
            SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor] := SecMask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := 0];
          }
          assume wf(Heap, SecMask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume wf(Heap, SecMask, SecMask);
        // end exhale
      }
      if (!CanRead(Mask, SecMask, r#20, AVLTreeNode.valid)) {
        oldVers#_692 := Heap[r#20, AVLTreeNode.valid];
        havoc newVers#_693;
        Heap[r#20, AVLTreeNode.valid] := newVers#_693;
        assume oldVers#_692 < Heap[r#20, AVLTreeNode.valid];
      }
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      // inhale (unfold)
      assume r#20 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(100) > 0;
      Mask[r#20, AVLTreeNode.key] := Mask[r#20, AVLTreeNode.key][perm$R := Mask[r#20, AVLTreeNode.key][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[r#20, AVLTreeNode.key]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume r#20 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(50) > 0;
      Mask[r#20, AVLTreeNode.height] := Mask[r#20, AVLTreeNode.height][perm$R := Mask[r#20, AVLTreeNode.height][perm$R] + Fractions(50)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[r#20, AVLTreeNode.height]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume r#20 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[r#20, AVLTreeNode.left] == null) || (dtype(Heap[r#20, AVLTreeNode.left]) == AVLTreeNode#t);
      assume Fractions(100) > 0;
      Mask[r#20, AVLTreeNode.left] := Mask[r#20, AVLTreeNode.left][perm$R := Mask[r#20, AVLTreeNode.left][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[r#20, AVLTreeNode.left]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume r#20 != null;
      assume wf(Heap, Mask, SecMask);
      assume (Heap[r#20, AVLTreeNode.right] == null) || (dtype(Heap[r#20, AVLTreeNode.right]) == AVLTreeNode#t);
      assume Fractions(100) > 0;
      Mask[r#20, AVLTreeNode.right] := Mask[r#20, AVLTreeNode.right][perm$R := Mask[r#20, AVLTreeNode.right][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[r#20, AVLTreeNode.right]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume r#20 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(50) > 0;
      Mask[r#20, AVLTreeNode.keys] := Mask[r#20, AVLTreeNode.keys][perm$R := Mask[r#20, AVLTreeNode.keys][perm$R] + Fractions(50)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[r#20, AVLTreeNode.keys]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume r#20 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(50) > 0;
      Mask[r#20, AVLTreeNode.balanceFactor] := Mask[r#20, AVLTreeNode.balanceFactor][perm$R := Mask[r#20, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[r#20, AVLTreeNode.balanceFactor]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[r#20, AVLTreeNode.left] == null)) {
        assume Heap[r#20, AVLTreeNode.left] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.left] == null)) {
        assume Heap[r#20, AVLTreeNode.left] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.left] == null)) {
        assume Heap[r#20, AVLTreeNode.left] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys] := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys][perm$R := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.left] == null)) {
        assume Heap[r#20, AVLTreeNode.left] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor] := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.balanceFactor]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.left] == null)) {
        assume (forall lk#79#262: int :: (0 <= lk#79#262) && (lk#79#262 < Seq#Length(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys], lk#79#262) < Heap[r#20, AVLTreeNode.key]));
      }
      if (!(Heap[r#20, AVLTreeNode.left] == null)) {
        assume Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height] > 0;
      }
      if (!(Heap[r#20, AVLTreeNode.right] == null)) {
        assume Heap[r#20, AVLTreeNode.right] != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.right] == null)) {
        assume Heap[r#20, AVLTreeNode.right] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.right] == null)) {
        assume Heap[r#20, AVLTreeNode.right] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys] := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys][perm$R := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.right] == null)) {
        assume Heap[r#20, AVLTreeNode.right] != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor] := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.balanceFactor]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[r#20, AVLTreeNode.right] == null)) {
        assume (forall rk#80#263: int :: (0 <= rk#80#263) && (rk#80#263 < Seq#Length(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[r#20, AVLTreeNode.key] < Seq#Index(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys], rk#80#263)));
      }
      if (!(Heap[r#20, AVLTreeNode.right] == null)) {
        assume Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height] > 0;
      }
      assume Seq#Equal(Heap[r#20, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(Heap[r#20, AVLTreeNode.left] == null, Seq#Empty(), Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(Heap[r#20, AVLTreeNode.key])), ite(Heap[r#20, AVLTreeNode.right] == null, Seq#Empty(), Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys])));
      assume Seq#Contains(Heap[r#20, AVLTreeNode.keys], Heap[r#20, AVLTreeNode.key]);
      assume (forall kk#81: int :: Seq#Contains(Heap[r#20, AVLTreeNode.keys], kk#81) <==> ((((!(Heap[r#20, AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.keys], kk#81)) || ((!(Heap[r#20, AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.keys], kk#81))) || (kk#81 == Heap[r#20, AVLTreeNode.key])));
      assume Heap[r#20, AVLTreeNode.height] == ite(ite(Heap[r#20, AVLTreeNode.left] == null, 0, Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height]) > ite(Heap[r#20, AVLTreeNode.right] == null, 0, Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height]), ite(Heap[r#20, AVLTreeNode.left] == null, 0, Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(Heap[r#20, AVLTreeNode.right] == null, 0, Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height]) + 1);
      assume Heap[r#20, AVLTreeNode.balanceFactor] == (ite(Heap[r#20, AVLTreeNode.left] == null, 0, Heap[Heap[r#20, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[r#20, AVLTreeNode.right] == null, 0, Heap[Heap[r#20, AVLTreeNode.right], AVLTreeNode.height]));
      assume Heap[r#20, AVLTreeNode.balanceFactor] <= 1;
      assume Heap[r#20, AVLTreeNode.balanceFactor] >= (0 - 1);
      assume Heap[r#20, AVLTreeNode.height] > 0;
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
      // update field left
      assert {:msg "  300.5: Location might not be writable"} CanWrite(Mask, r#20, AVLTreeNode.left);
      Heap[r#20, AVLTreeNode.left] := nl#24;
      assume wf(Heap, Mask, SecMask);
      // update field right
      assert {:msg "  301.5: Location might not be writable"} CanWrite(Mask, r#20, AVLTreeNode.right);
      Heap[r#20, AVLTreeNode.right] := nr#26;
      assume wf(Heap, Mask, SecMask);
      assume (0 < methodCallK#_698) && ((1000 * methodCallK#_698) < Fractions(1)) && ((1000 * methodCallK#_698) < methodK#_506);
      // call close
      callHeap#_694 := Heap;
      callMask#_695 := Mask;
      callSecMask#_696 := SecMask;
      callCredits#_697 := Credits;
      assume wf(callHeap#_694, callMask#_695, callSecMask#_696);
      assert {:msg "  302.5: The target of the method call might be null."} r#20 != null;
      this#264 := r#20;
      // begin exhale (precondition)
      exhaleMask#_700 := Mask;
      havoc exhaleHeap#_699;
      if (!(Heap[this#264, AVLTreeNode.left] == null)) {
        assert {:msg "  302.5: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#265: int :: (0 <= k#92#265) && (k#92#265 < Seq#Length(Heap[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys], k#92#265) < Heap[this#264, AVLTreeNode.key]));
      }
      if (!(Heap[this#264, AVLTreeNode.right] == null)) {
        assert {:msg "  302.5: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#266: int :: (0 <= k#93#266) && (k#93#266 < Seq#Length(Heap[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#264, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys], k#93#266)));
      }
      assert {:msg "  302.5: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#264, AVLTreeNode.left] == null, 0, Heap[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#264, AVLTreeNode.right] == null, 0, Heap[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
      assert {:msg "  302.5: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#264, AVLTreeNode.left] == null, 0, Heap[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#264, AVLTreeNode.right] == null, 0, Heap[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
      assert {:msg "  302.5: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
      assert {:msg "  302.5: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_700[this#264, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_700[this#264, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_700[this#264, AVLTreeNode.key][perm$N]));
      exhaleMask#_700[this#264, AVLTreeNode.key] := exhaleMask#_700[this#264, AVLTreeNode.key][perm$R := exhaleMask#_700[this#264, AVLTreeNode.key][perm$R] - Fractions(100)];
      assume IsGoodMask(exhaleMask#_700);
      assume wf(Heap, exhaleMask#_700, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  302.5: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
      assert {:msg "  302.5: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_700[this#264, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_700[this#264, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_700[this#264, AVLTreeNode.height][perm$N]));
      exhaleMask#_700[this#264, AVLTreeNode.height] := exhaleMask#_700[this#264, AVLTreeNode.height][perm$R := exhaleMask#_700[this#264, AVLTreeNode.height][perm$R] - Fractions(100)];
      assume IsGoodMask(exhaleMask#_700);
      assume wf(Heap, exhaleMask#_700, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  302.5: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
      assert {:msg "  302.5: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_700[this#264, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_700[this#264, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_700[this#264, AVLTreeNode.left][perm$N]));
      exhaleMask#_700[this#264, AVLTreeNode.left] := exhaleMask#_700[this#264, AVLTreeNode.left][perm$R := exhaleMask#_700[this#264, AVLTreeNode.left][perm$R] - Fractions(100)];
      assume IsGoodMask(exhaleMask#_700);
      assume wf(Heap, exhaleMask#_700, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  302.5: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
      assert {:msg "  302.5: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_700[this#264, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_700[this#264, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_700[this#264, AVLTreeNode.right][perm$N]));
      exhaleMask#_700[this#264, AVLTreeNode.right] := exhaleMask#_700[this#264, AVLTreeNode.right][perm$R := exhaleMask#_700[this#264, AVLTreeNode.right][perm$R] - Fractions(100)];
      assume IsGoodMask(exhaleMask#_700);
      assume wf(Heap, exhaleMask#_700, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  302.5: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
      assert {:msg "  302.5: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_700[this#264, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_700[this#264, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_700[this#264, AVLTreeNode.keys][perm$N]));
      exhaleMask#_700[this#264, AVLTreeNode.keys] := exhaleMask#_700[this#264, AVLTreeNode.keys][perm$R := exhaleMask#_700[this#264, AVLTreeNode.keys][perm$R] - Fractions(100)];
      assume IsGoodMask(exhaleMask#_700);
      assume wf(Heap, exhaleMask#_700, SecMask);
      assume wf(Heap, Mask, SecMask);
      assert {:msg "  302.5: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
      assert {:msg "  302.5: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_700[this#264, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_700[this#264, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_700[this#264, AVLTreeNode.balanceFactor][perm$N]));
      exhaleMask#_700[this#264, AVLTreeNode.balanceFactor] := exhaleMask#_700[this#264, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_700[this#264, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
      assume IsGoodMask(exhaleMask#_700);
      assume wf(Heap, exhaleMask#_700, SecMask);
      assume wf(Heap, Mask, SecMask);
      if (!(Heap[this#264, AVLTreeNode.left] == null)) {
        assert {:msg "  302.5: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
        assert {:msg "  302.5: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_700, SecMask, Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid)) {
          assume Heap[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_699[Heap[this#264, AVLTreeNode.left], AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#264, AVLTreeNode.left] == null)) {
        assert {:msg "  302.5: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
        assert {:msg "  302.5: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#264, AVLTreeNode.left] == null)) {
        assert {:msg "  302.5: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
        assert {:msg "  302.5: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#264, AVLTreeNode.left] == null)) {
        assert {:msg "  302.5: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
        assert {:msg "  302.5: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#264, AVLTreeNode.right] == null)) {
        assert {:msg "  302.5: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
        assert {:msg "  302.5: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_700, SecMask, Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid)) {
          assume Heap[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_699[Heap[this#264, AVLTreeNode.right], AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#264, AVLTreeNode.right] == null)) {
        assert {:msg "  302.5: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
        assert {:msg "  302.5: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#264, AVLTreeNode.right] == null)) {
        assert {:msg "  302.5: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
        assert {:msg "  302.5: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      if (!(Heap[this#264, AVLTreeNode.right] == null)) {
        assert {:msg "  302.5: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
        assert {:msg "  302.5: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_700[Heap[this#264, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_700);
        assume wf(Heap, exhaleMask#_700, SecMask);
        assume wf(Heap, Mask, SecMask);
      }
      Mask := exhaleMask#_700;
      assume IsGoodExhaleState(exhaleHeap#_699, Heap, Mask, SecMask);
      Heap := exhaleHeap#_699;
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end exhale
      // inhale (postcondition)
      assume this#264 != null;
      assume wf(Heap, Mask, SecMask);
      assume Fractions(100) > 0;
      Mask[this#264, AVLTreeNode.valid] := Mask[this#264, AVLTreeNode.valid][perm$R := Mask[this#264, AVLTreeNode.valid][perm$R] + Fractions(100)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[this#264, AVLTreeNode.valid]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume this#264 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(50) > 0;
      Mask[this#264, AVLTreeNode.height] := Mask[this#264, AVLTreeNode.height][perm$R := Mask[this#264, AVLTreeNode.height][perm$R] + Fractions(50)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[this#264, AVLTreeNode.height]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume this#264 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(50) > 0;
      Mask[this#264, AVLTreeNode.keys] := Mask[this#264, AVLTreeNode.keys][perm$R := Mask[this#264, AVLTreeNode.keys][perm$R] + Fractions(50)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[this#264, AVLTreeNode.keys]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume this#264 != null;
      assume wf(Heap, Mask, SecMask);
      assume true;
      assume Fractions(50) > 0;
      Mask[this#264, AVLTreeNode.balanceFactor] := Mask[this#264, AVLTreeNode.balanceFactor][perm$R := Mask[this#264, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
      assume IsGoodMask(Mask);
      assume IsGoodState(heapFragment(Heap[this#264, AVLTreeNode.balanceFactor]));
      assume wf(Heap, Mask, SecMask);
      assume wf(Heap, Mask, SecMask);
      assume Seq#Equal(Heap[this#264, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_694[this#264, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_694[callHeap#_694[this#264, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_694[this#264, AVLTreeNode.key])), ite(callHeap#_694[this#264, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_694[callHeap#_694[this#264, AVLTreeNode.right], AVLTreeNode.keys])));
      assume Heap[this#264, AVLTreeNode.height] == ite(ite(callHeap#_694[this#264, AVLTreeNode.left] == null, 0, callHeap#_694[callHeap#_694[this#264, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_694[this#264, AVLTreeNode.right] == null, 0, callHeap#_694[callHeap#_694[this#264, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_694[this#264, AVLTreeNode.left] == null, 0, callHeap#_694[callHeap#_694[this#264, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_694[this#264, AVLTreeNode.right] == null, 0, callHeap#_694[callHeap#_694[this#264, AVLTreeNode.right], AVLTreeNode.height]) + 1);
      assume Heap[this#264, AVLTreeNode.balanceFactor] == (ite(callHeap#_694[this#264, AVLTreeNode.left] == null, 0, callHeap#_694[callHeap#_694[this#264, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_694[this#264, AVLTreeNode.right] == null, 0, callHeap#_694[callHeap#_694[this#264, AVLTreeNode.right], AVLTreeNode.height]));
      assume IsGoodMask(Mask);
      assume wf(Heap, Mask, SecMask);
      // end inhale
    }
  } else {
    // if
    cond#_717 := k#19 < Heap[this, AVLTreeNode.key];
    assert {:msg "  305.10: Receiver might be null."} true ==> (this != null);
    assert {:msg "  305.10: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.key);
    if (cond#_717) {
      // if
      cond#_718 := !(Heap[this, AVLTreeNode.left] == null);
      assert {:msg "  306.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  306.9: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
      if (cond#_718) {
        // local var nl
        assume (0 < methodCallK#_723) && ((1000 * methodCallK#_723) < Fractions(1)) && ((1000 * methodCallK#_723) < methodK#_506);
        // call remove
        callHeap#_719 := Heap;
        callMask#_720 := Mask;
        callSecMask#_721 := SecMask;
        callCredits#_722 := Credits;
        assume wf(callHeap#_719, callMask#_720, callSecMask#_721);
        assert {:msg "  308.17: Receiver might be null."} true ==> (this != null);
        assert {:msg "  308.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.left);
        assert {:msg "  308.6: The target of the method call might be null."} Heap[this, AVLTreeNode.left] != null;
        this#269 := Heap[this, AVLTreeNode.left];
        k#270 := k#19;
        // begin exhale (precondition)
        exhaleMask#_725 := Mask;
        havoc exhaleHeap#_724;
        assert {:msg "  308.6: The precondition at 254.12 might not hold. The permission at 254.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  308.6: The precondition at 254.12 might not hold. Insufficient fraction at 254.12 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_725[this#269, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_725[this#269, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_725[this#269, AVLTreeNode.valid][perm$N]));
        exhaleMask#_725[this#269, AVLTreeNode.valid] := exhaleMask#_725[this#269, AVLTreeNode.valid][perm$R := exhaleMask#_725[this#269, AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_725, SecMask, this#269, AVLTreeNode.valid)) {
          assume Heap[this#269, AVLTreeNode.valid] < exhaleHeap#_724[this#269, AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_725);
        assume wf(Heap, exhaleMask#_725, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  308.6: The precondition at 255.12 might not hold. The permission at 255.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  308.6: The precondition at 255.12 might not hold. Insufficient fraction at 255.12 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_725[this#269, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_725[this#269, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_725[this#269, AVLTreeNode.keys][perm$N]));
        exhaleMask#_725[this#269, AVLTreeNode.keys] := exhaleMask#_725[this#269, AVLTreeNode.keys][perm$R := exhaleMask#_725[this#269, AVLTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_725);
        assume wf(Heap, exhaleMask#_725, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  308.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  308.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_725[this#269, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_725[this#269, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_725[this#269, AVLTreeNode.height][perm$N]));
        exhaleMask#_725[this#269, AVLTreeNode.height] := exhaleMask#_725[this#269, AVLTreeNode.height][perm$R := exhaleMask#_725[this#269, AVLTreeNode.height][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_725);
        assume wf(Heap, exhaleMask#_725, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  308.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  308.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_725[this#269, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_725[this#269, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_725[this#269, AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_725[this#269, AVLTreeNode.balanceFactor] := exhaleMask#_725[this#269, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_725[this#269, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_725);
        assume wf(Heap, exhaleMask#_725, SecMask);
        assume wf(Heap, Mask, SecMask);
        Mask := exhaleMask#_725;
        assume IsGoodExhaleState(exhaleHeap#_724, Heap, Mask, SecMask);
        Heap := exhaleHeap#_724;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        havoc r#271;
        // inhale (postcondition)
        if (Seq#Equal(callHeap#_719[this#269, AVLTreeNode.keys], Seq#Singleton(k#270))) {
          assume r#271 == null;
        }
        if (!Seq#Equal(callHeap#_719[this#269, AVLTreeNode.keys], Seq#Singleton(k#270))) {
          assume !(r#271 == null);
        }
        if (!(r#271 == null)) {
          assume r#271 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[r#271, AVLTreeNode.valid] := Mask[r#271, AVLTreeNode.valid][perm$R := Mask[r#271, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#271, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#271 == null)) {
          assume r#271 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#271, AVLTreeNode.keys] := Mask[r#271, AVLTreeNode.keys][perm$R := Mask[r#271, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#271, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#271 == null)) {
          assume r#271 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#271, AVLTreeNode.height] := Mask[r#271, AVLTreeNode.height][perm$R := Mask[r#271, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#271, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#271 == null)) {
          assume r#271 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#271, AVLTreeNode.balanceFactor] := Mask[r#271, AVLTreeNode.balanceFactor][perm$R := Mask[r#271, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#271, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#271 == null)) {
          assume !Seq#Contains(Heap[r#271, AVLTreeNode.keys], k#270);
        }
        if (!(r#271 == null)) {
          assume (forall i#84#272: int :: (0 <= i#84#272) && (i#84#272 < Seq#Length(callHeap#_719[this#269, AVLTreeNode.keys])) ==> (Seq#Contains(Heap[r#271, AVLTreeNode.keys], Seq#Index(callHeap#_719[this#269, AVLTreeNode.keys], i#84#272)) || (Seq#Index(callHeap#_719[this#269, AVLTreeNode.keys], i#84#272) == k#270)));
        }
        if (!(r#271 == null)) {
          assume (forall i#85#273: int :: (0 <= i#85#273) && (i#85#273 < Seq#Length(Heap[r#271, AVLTreeNode.keys])) ==> Seq#Contains(callHeap#_719[this#269, AVLTreeNode.keys], Seq#Index(Heap[r#271, AVLTreeNode.keys], i#85#273)) && (!(Seq#Index(Heap[r#271, AVLTreeNode.keys], i#85#273) == k#270)));
        }
        if (!Seq#Contains(callHeap#_719[this#269, AVLTreeNode.keys], k#270)) {
          assume !(r#271 == null);
        }
        if (!Seq#Contains(callHeap#_719[this#269, AVLTreeNode.keys], k#270)) {
          assume Seq#Equal(Heap[r#271, AVLTreeNode.keys], callHeap#_719[this#269, AVLTreeNode.keys]);
        }
        if (!(r#271 == null)) {
          if (Seq#Contains(callHeap#_719[this#269, AVLTreeNode.keys], k#270)) {
            assume Seq#Length(Heap[r#271, AVLTreeNode.keys]) == (Seq#Length(callHeap#_719[this#269, AVLTreeNode.keys]) - 1);
          }
        }
        if (callHeap#_719[this#269, AVLTreeNode.height] > 1) {
          assume !(r#271 == null);
        }
        if (!(r#271 == null)) {
          assume (Heap[r#271, AVLTreeNode.height] == callHeap#_719[this#269, AVLTreeNode.height]) || ((Heap[r#271, AVLTreeNode.height] + 1) == callHeap#_719[this#269, AVLTreeNode.height]);
        }
        if (!Seq#Contains(callHeap#_719[this#269, AVLTreeNode.keys], k#270)) {
          assume Heap[r#271, AVLTreeNode.height] == callHeap#_719[this#269, AVLTreeNode.height];
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
        nl#28 := r#271;
        // update field left
        assert {:msg "  309.6: Location might not be writable"} CanWrite(Mask, this, AVLTreeNode.left);
        Heap[this, AVLTreeNode.left] := nl#28;
        assume wf(Heap, Mask, SecMask);
        // local var bf
        assume (0 < methodCallK#_736) && ((1000 * methodCallK#_736) < Fractions(1)) && ((1000 * methodCallK#_736) < methodK#_506);
        // call getBalanceFactorI
        callHeap#_732 := Heap;
        callMask#_733 := Mask;
        callSecMask#_734 := SecMask;
        callCredits#_735 := Credits;
        assume wf(callHeap#_732, callMask#_733, callSecMask#_734);
        assert {:msg "  312.6: The target of the method call might be null."} this != null;
        this#274 := this;
        // begin exhale (precondition)
        exhaleMask#_738 := Mask;
        havoc exhaleHeap#_737;
        assert {:msg "  312.6: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive."} methodCallK#_736 > 0;
        assert {:msg "  312.6: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left."} exhaleMask#_738[this#274, AVLTreeNode.left][perm$R] > 0;
        assume methodCallK#_736 < exhaleMask#_738[this#274, AVLTreeNode.left][perm$R];
        exhaleMask#_738[this#274, AVLTreeNode.left] := exhaleMask#_738[this#274, AVLTreeNode.left][perm$R := exhaleMask#_738[this#274, AVLTreeNode.left][perm$R] - methodCallK#_736];
        assume IsGoodMask(exhaleMask#_738);
        assume wf(Heap, exhaleMask#_738, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#274, AVLTreeNode.left] == null)) {
          assert {:msg "  312.6: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive."} methodCallK#_736 > 0;
          assert {:msg "  312.6: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height."} exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height][perm$R] > 0;
          assume methodCallK#_736 < exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height][perm$R];
          exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height][perm$R] - methodCallK#_736];
          assume IsGoodMask(exhaleMask#_738);
          assume wf(Heap, exhaleMask#_738, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assert {:msg "  312.6: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive."} methodCallK#_736 > 0;
        assert {:msg "  312.6: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right."} exhaleMask#_738[this#274, AVLTreeNode.right][perm$R] > 0;
        assume methodCallK#_736 < exhaleMask#_738[this#274, AVLTreeNode.right][perm$R];
        exhaleMask#_738[this#274, AVLTreeNode.right] := exhaleMask#_738[this#274, AVLTreeNode.right][perm$R := exhaleMask#_738[this#274, AVLTreeNode.right][perm$R] - methodCallK#_736];
        assume IsGoodMask(exhaleMask#_738);
        assume wf(Heap, exhaleMask#_738, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#274, AVLTreeNode.right] == null)) {
          assert {:msg "  312.6: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive."} methodCallK#_736 > 0;
          assert {:msg "  312.6: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height."} exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height][perm$R] > 0;
          assume methodCallK#_736 < exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height][perm$R];
          exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height][perm$R] - methodCallK#_736];
          assume IsGoodMask(exhaleMask#_738);
          assume wf(Heap, exhaleMask#_738, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#274, AVLTreeNode.left] == null)) {
          assert {:msg "  312.6: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  312.6: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
          exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_738[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_738, SecMask, Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid)) {
            assume Heap[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_737[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_738);
          assume wf(Heap, exhaleMask#_738, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#274, AVLTreeNode.right] == null)) {
          assert {:msg "  312.6: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive."} Fractions(100) > 0;
          assert {:msg "  312.6: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
          exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_738[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_738, SecMask, Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid)) {
            assume Heap[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_737[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_738);
          assume wf(Heap, exhaleMask#_738, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        Mask := exhaleMask#_738;
        assume IsGoodExhaleState(exhaleHeap#_737, Heap, Mask, SecMask);
        Heap := exhaleHeap#_737;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        havoc bf#275;
        // inhale (postcondition)
        assume this#274 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[this#274, AVLTreeNode.left] == null) || (dtype(Heap[this#274, AVLTreeNode.left]) == AVLTreeNode#t);
        assume methodCallK#_736 > 0;
        Mask[this#274, AVLTreeNode.left] := Mask[this#274, AVLTreeNode.left][perm$R := Mask[this#274, AVLTreeNode.left][perm$R] + methodCallK#_736];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#274, AVLTreeNode.left]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#274, AVLTreeNode.left] == null)) {
          assume Heap[this#274, AVLTreeNode.left] != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#274, AVLTreeNode.left], AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#274, AVLTreeNode.left] == null)) {
          assume Heap[this#274, AVLTreeNode.left] != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume methodCallK#_736 > 0;
          Mask[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height][perm$R] + methodCallK#_736];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume this#274 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[this#274, AVLTreeNode.right] == null) || (dtype(Heap[this#274, AVLTreeNode.right]) == AVLTreeNode#t);
        assume methodCallK#_736 > 0;
        Mask[this#274, AVLTreeNode.right] := Mask[this#274, AVLTreeNode.right][perm$R := Mask[this#274, AVLTreeNode.right][perm$R] + methodCallK#_736];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#274, AVLTreeNode.right]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#274, AVLTreeNode.right] == null)) {
          assume Heap[this#274, AVLTreeNode.right] != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#274, AVLTreeNode.right], AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#274, AVLTreeNode.right] == null)) {
          assume Heap[this#274, AVLTreeNode.right] != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume methodCallK#_736 > 0;
          Mask[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height][perm$R] + methodCallK#_736];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume bf#275 == (ite(Heap[this#274, AVLTreeNode.left] == null, 0, Heap[Heap[this#274, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#274, AVLTreeNode.right] == null, 0, Heap[Heap[this#274, AVLTreeNode.right], AVLTreeNode.height]));
        if (bf#275 > 0) {
          assume !(Heap[this#274, AVLTreeNode.left] == null);
        }
        if (bf#275 < 0) {
          assume !(Heap[this#274, AVLTreeNode.right] == null);
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
        bf#30 := bf#275;
        // if
        cond#_747 := bf#30 == (0 - 2);
        if (cond#_747) {
          assume (0 < methodCallK#_752) && ((1000 * methodCallK#_752) < Fractions(1)) && ((1000 * methodCallK#_752) < methodK#_506);
          // call rebalanceRight
          callHeap#_748 := Heap;
          callMask#_749 := Mask;
          callSecMask#_750 := SecMask;
          callCredits#_751 := Credits;
          assume wf(callHeap#_748, callMask#_749, callSecMask#_750);
          assert {:msg "  315.7: The target of the method call might be null."} this != null;
          this#276 := this;
          // begin exhale (precondition)
          exhaleMask#_754 := Mask;
          havoc exhaleHeap#_753;
          if (!(Heap[this#276, AVLTreeNode.left] == null)) {
            assert {:msg "  315.7: The precondition at 758.12 might not hold. The expression at 758.25 might not evaluate to true."} (forall k#104#278: int :: (0 <= k#104#278) && (k#104#278 < Seq#Length(Heap[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys], k#104#278) < Heap[this#276, AVLTreeNode.key]));
          }
          assert {:msg "  315.7: The precondition at 760.12 might not hold. The expression at 760.12 might not evaluate to true."} !(Heap[this#276, AVLTreeNode.right] == null);
          assert {:msg "  315.7: The precondition at 765.12 might not hold. The expression at 765.12 might not evaluate to true."} (forall k#105#279: int :: (0 <= k#105#279) && (k#105#279 < Seq#Length(Heap[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#276, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys], k#105#279)));
          assert {:msg "  315.7: The precondition at 768.12 might not hold. The expression at 768.12 might not evaluate to true."} (ite(Heap[this#276, AVLTreeNode.left] == null, 0, Heap[Heap[this#276, AVLTreeNode.left], AVLTreeNode.height]) - Heap[Heap[this#276, AVLTreeNode.right], AVLTreeNode.height]) == (0 - 2);
          assert {:msg "  315.7: The precondition at 746.12 might not hold. The permission at 746.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  315.7: The precondition at 746.12 might not hold. Insufficient fraction at 746.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_754[this#276, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_754[this#276, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_754[this#276, AVLTreeNode.key][perm$N]));
          exhaleMask#_754[this#276, AVLTreeNode.key] := exhaleMask#_754[this#276, AVLTreeNode.key][perm$R := exhaleMask#_754[this#276, AVLTreeNode.key][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 747.12 might not hold. The permission at 747.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  315.7: The precondition at 747.12 might not hold. Insufficient fraction at 747.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_754[this#276, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_754[this#276, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_754[this#276, AVLTreeNode.height][perm$N]));
          exhaleMask#_754[this#276, AVLTreeNode.height] := exhaleMask#_754[this#276, AVLTreeNode.height][perm$R := exhaleMask#_754[this#276, AVLTreeNode.height][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 748.12 might not hold. The permission at 748.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  315.7: The precondition at 748.12 might not hold. Insufficient fraction at 748.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_754[this#276, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_754[this#276, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_754[this#276, AVLTreeNode.left][perm$N]));
          exhaleMask#_754[this#276, AVLTreeNode.left] := exhaleMask#_754[this#276, AVLTreeNode.left][perm$R := exhaleMask#_754[this#276, AVLTreeNode.left][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 749.12 might not hold. The permission at 749.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  315.7: The precondition at 749.12 might not hold. Insufficient fraction at 749.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_754[this#276, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_754[this#276, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_754[this#276, AVLTreeNode.right][perm$N]));
          exhaleMask#_754[this#276, AVLTreeNode.right] := exhaleMask#_754[this#276, AVLTreeNode.right][perm$R := exhaleMask#_754[this#276, AVLTreeNode.right][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 751.12 might not hold. The permission at 751.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  315.7: The precondition at 751.12 might not hold. Insufficient fraction at 751.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_754[this#276, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_754[this#276, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_754[this#276, AVLTreeNode.keys][perm$N]));
          exhaleMask#_754[this#276, AVLTreeNode.keys] := exhaleMask#_754[this#276, AVLTreeNode.keys][perm$R := exhaleMask#_754[this#276, AVLTreeNode.keys][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 752.12 might not hold. The permission at 752.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  315.7: The precondition at 752.12 might not hold. Insufficient fraction at 752.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_754[this#276, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_754[this#276, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_754[this#276, AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_754[this#276, AVLTreeNode.balanceFactor] := exhaleMask#_754[this#276, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_754[this#276, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[this#276, AVLTreeNode.left] == null)) {
            assert {:msg "  315.7: The precondition at 754.12 might not hold. The permission at 754.25 might not be positive."} Fractions(100) > 0;
            assert {:msg "  315.7: The precondition at 754.12 might not hold. Insufficient fraction at 754.25 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
            exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (!CanRead(exhaleMask#_754, SecMask, Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid)) {
              assume Heap[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_753[Heap[this#276, AVLTreeNode.left], AVLTreeNode.valid];
            }
            assume IsGoodMask(exhaleMask#_754);
            assume wf(Heap, exhaleMask#_754, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#276, AVLTreeNode.left] == null)) {
            assert {:msg "  315.7: The precondition at 755.12 might not hold. The permission at 755.25 might not be positive."} Fractions(50) > 0;
            assert {:msg "  315.7: The precondition at 755.12 might not hold. Insufficient fraction at 755.25 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
            exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_754);
            assume wf(Heap, exhaleMask#_754, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#276, AVLTreeNode.left] == null)) {
            assert {:msg "  315.7: The precondition at 756.12 might not hold. The permission at 756.25 might not be positive."} Fractions(50) > 0;
            assert {:msg "  315.7: The precondition at 756.12 might not hold. Insufficient fraction at 756.25 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
            exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_754);
            assume wf(Heap, exhaleMask#_754, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#276, AVLTreeNode.left] == null)) {
            assert {:msg "  315.7: The precondition at 757.12 might not hold. The permission at 757.25 might not be positive."} Fractions(50) > 0;
            assert {:msg "  315.7: The precondition at 757.12 might not hold. Insufficient fraction at 757.25 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
            exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_754);
            assume wf(Heap, exhaleMask#_754, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          assert {:msg "  315.7: The precondition at 761.12 might not hold. The permission at 761.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  315.7: The precondition at 761.12 might not hold. Insufficient fraction at 761.12 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
          exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_754, SecMask, Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid)) {
            assume Heap[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_753[Heap[this#276, AVLTreeNode.right], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 762.12 might not hold. The permission at 762.12 might not be positive."} Fractions(50) > 0;
          assert {:msg "  315.7: The precondition at 762.12 might not hold. Insufficient fraction at 762.12 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
          exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 763.12 might not hold. The permission at 763.12 might not be positive."} Fractions(50) > 0;
          assert {:msg "  315.7: The precondition at 763.12 might not hold. Insufficient fraction at 763.12 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
          exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  315.7: The precondition at 764.12 might not hold. The permission at 764.12 might not be positive."} Fractions(50) > 0;
          assert {:msg "  315.7: The precondition at 764.12 might not hold. Insufficient fraction at 764.12 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_754[Heap[this#276, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_754);
          assume wf(Heap, exhaleMask#_754, SecMask);
          assume wf(Heap, Mask, SecMask);
          Mask := exhaleMask#_754;
          assume IsGoodExhaleState(exhaleHeap#_753, Heap, Mask, SecMask);
          Heap := exhaleHeap#_753;
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end exhale
          havoc r#277;
          // inhale (postcondition)
          assume !(r#277 == null);
          assume r#277 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[r#277, AVLTreeNode.valid] := Mask[r#277, AVLTreeNode.valid][perm$R := Mask[r#277, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#277, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume r#277 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#277, AVLTreeNode.height] := Mask[r#277, AVLTreeNode.height][perm$R := Mask[r#277, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#277, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume r#277 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#277, AVLTreeNode.keys] := Mask[r#277, AVLTreeNode.keys][perm$R := Mask[r#277, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#277, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume r#277 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#277, AVLTreeNode.balanceFactor] := Mask[r#277, AVLTreeNode.balanceFactor][perm$R := Mask[r#277, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#277, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume (Heap[r#277, AVLTreeNode.height] == callHeap#_748[callHeap#_748[this#276, AVLTreeNode.right], AVLTreeNode.height]) || (Heap[r#277, AVLTreeNode.height] == (callHeap#_748[callHeap#_748[this#276, AVLTreeNode.right], AVLTreeNode.height] + 1));
          assume Seq#Equal(Heap[r#277, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_748[this#276, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_748[callHeap#_748[this#276, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_748[this#276, AVLTreeNode.key])), callHeap#_748[callHeap#_748[this#276, AVLTreeNode.right], AVLTreeNode.keys]));
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end inhale
          r#20 := r#277;
        } else {
          assume (0 < methodCallK#_775) && ((1000 * methodCallK#_775) < Fractions(1)) && ((1000 * methodCallK#_775) < methodK#_506);
          // call close
          callHeap#_771 := Heap;
          callMask#_772 := Mask;
          callSecMask#_773 := SecMask;
          callCredits#_774 := Credits;
          assume wf(callHeap#_771, callMask#_772, callSecMask#_773);
          assert {:msg "  317.7: The target of the method call might be null."} this != null;
          this#282 := this;
          // begin exhale (precondition)
          exhaleMask#_777 := Mask;
          havoc exhaleHeap#_776;
          if (!(Heap[this#282, AVLTreeNode.left] == null)) {
            assert {:msg "  317.7: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#283: int :: (0 <= k#92#283) && (k#92#283 < Seq#Length(Heap[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys], k#92#283) < Heap[this#282, AVLTreeNode.key]));
          }
          if (!(Heap[this#282, AVLTreeNode.right] == null)) {
            assert {:msg "  317.7: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#284: int :: (0 <= k#93#284) && (k#93#284 < Seq#Length(Heap[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#282, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys], k#93#284)));
          }
          assert {:msg "  317.7: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#282, AVLTreeNode.left] == null, 0, Heap[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#282, AVLTreeNode.right] == null, 0, Heap[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
          assert {:msg "  317.7: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#282, AVLTreeNode.left] == null, 0, Heap[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#282, AVLTreeNode.right] == null, 0, Heap[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
          assert {:msg "  317.7: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  317.7: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_777[this#282, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_777[this#282, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_777[this#282, AVLTreeNode.key][perm$N]));
          exhaleMask#_777[this#282, AVLTreeNode.key] := exhaleMask#_777[this#282, AVLTreeNode.key][perm$R := exhaleMask#_777[this#282, AVLTreeNode.key][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_777);
          assume wf(Heap, exhaleMask#_777, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  317.7: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  317.7: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_777[this#282, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_777[this#282, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_777[this#282, AVLTreeNode.height][perm$N]));
          exhaleMask#_777[this#282, AVLTreeNode.height] := exhaleMask#_777[this#282, AVLTreeNode.height][perm$R := exhaleMask#_777[this#282, AVLTreeNode.height][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_777);
          assume wf(Heap, exhaleMask#_777, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  317.7: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  317.7: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_777[this#282, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_777[this#282, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_777[this#282, AVLTreeNode.left][perm$N]));
          exhaleMask#_777[this#282, AVLTreeNode.left] := exhaleMask#_777[this#282, AVLTreeNode.left][perm$R := exhaleMask#_777[this#282, AVLTreeNode.left][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_777);
          assume wf(Heap, exhaleMask#_777, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  317.7: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  317.7: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_777[this#282, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_777[this#282, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_777[this#282, AVLTreeNode.right][perm$N]));
          exhaleMask#_777[this#282, AVLTreeNode.right] := exhaleMask#_777[this#282, AVLTreeNode.right][perm$R := exhaleMask#_777[this#282, AVLTreeNode.right][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_777);
          assume wf(Heap, exhaleMask#_777, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  317.7: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  317.7: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_777[this#282, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_777[this#282, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_777[this#282, AVLTreeNode.keys][perm$N]));
          exhaleMask#_777[this#282, AVLTreeNode.keys] := exhaleMask#_777[this#282, AVLTreeNode.keys][perm$R := exhaleMask#_777[this#282, AVLTreeNode.keys][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_777);
          assume wf(Heap, exhaleMask#_777, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  317.7: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  317.7: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_777[this#282, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_777[this#282, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_777[this#282, AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_777[this#282, AVLTreeNode.balanceFactor] := exhaleMask#_777[this#282, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_777[this#282, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_777);
          assume wf(Heap, exhaleMask#_777, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[this#282, AVLTreeNode.left] == null)) {
            assert {:msg "  317.7: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
            assert {:msg "  317.7: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (!CanRead(exhaleMask#_777, SecMask, Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid)) {
              assume Heap[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_776[Heap[this#282, AVLTreeNode.left], AVLTreeNode.valid];
            }
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#282, AVLTreeNode.left] == null)) {
            assert {:msg "  317.7: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
            assert {:msg "  317.7: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#282, AVLTreeNode.left] == null)) {
            assert {:msg "  317.7: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
            assert {:msg "  317.7: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#282, AVLTreeNode.left] == null)) {
            assert {:msg "  317.7: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
            assert {:msg "  317.7: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#282, AVLTreeNode.right] == null)) {
            assert {:msg "  317.7: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
            assert {:msg "  317.7: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (!CanRead(exhaleMask#_777, SecMask, Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid)) {
              assume Heap[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_776[Heap[this#282, AVLTreeNode.right], AVLTreeNode.valid];
            }
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#282, AVLTreeNode.right] == null)) {
            assert {:msg "  317.7: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  317.7: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#282, AVLTreeNode.right] == null)) {
            assert {:msg "  317.7: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  317.7: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#282, AVLTreeNode.right] == null)) {
            assert {:msg "  317.7: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  317.7: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
            exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_777[Heap[this#282, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_777);
            assume wf(Heap, exhaleMask#_777, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          Mask := exhaleMask#_777;
          assume IsGoodExhaleState(exhaleHeap#_776, Heap, Mask, SecMask);
          Heap := exhaleHeap#_776;
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end exhale
          // inhale (postcondition)
          assume this#282 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[this#282, AVLTreeNode.valid] := Mask[this#282, AVLTreeNode.valid][perm$R := Mask[this#282, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#282, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume this#282 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[this#282, AVLTreeNode.height] := Mask[this#282, AVLTreeNode.height][perm$R := Mask[this#282, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#282, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume this#282 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[this#282, AVLTreeNode.keys] := Mask[this#282, AVLTreeNode.keys][perm$R := Mask[this#282, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#282, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume this#282 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[this#282, AVLTreeNode.balanceFactor] := Mask[this#282, AVLTreeNode.balanceFactor][perm$R := Mask[this#282, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#282, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume Seq#Equal(Heap[this#282, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_771[this#282, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_771[callHeap#_771[this#282, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_771[this#282, AVLTreeNode.key])), ite(callHeap#_771[this#282, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_771[callHeap#_771[this#282, AVLTreeNode.right], AVLTreeNode.keys])));
          assume Heap[this#282, AVLTreeNode.height] == ite(ite(callHeap#_771[this#282, AVLTreeNode.left] == null, 0, callHeap#_771[callHeap#_771[this#282, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_771[this#282, AVLTreeNode.right] == null, 0, callHeap#_771[callHeap#_771[this#282, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_771[this#282, AVLTreeNode.left] == null, 0, callHeap#_771[callHeap#_771[this#282, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_771[this#282, AVLTreeNode.right] == null, 0, callHeap#_771[callHeap#_771[this#282, AVLTreeNode.right], AVLTreeNode.height]) + 1);
          assume Heap[this#282, AVLTreeNode.balanceFactor] == (ite(callHeap#_771[this#282, AVLTreeNode.left] == null, 0, callHeap#_771[callHeap#_771[this#282, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_771[this#282, AVLTreeNode.right] == null, 0, callHeap#_771[callHeap#_771[this#282, AVLTreeNode.right], AVLTreeNode.height]));
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end inhale
          // assigment to r
          r#20 := this;
        }
      } else {
        // assigment to r
        r#20 := this;
        assume (0 < methodCallK#_798) && ((1000 * methodCallK#_798) < Fractions(1)) && ((1000 * methodCallK#_798) < methodK#_506);
        // call close
        callHeap#_794 := Heap;
        callMask#_795 := Mask;
        callSecMask#_796 := SecMask;
        callCredits#_797 := Credits;
        assume wf(callHeap#_794, callMask#_795, callSecMask#_796);
        assert {:msg "  322.6: The target of the method call might be null."} r#20 != null;
        this#287 := r#20;
        // begin exhale (precondition)
        exhaleMask#_800 := Mask;
        havoc exhaleHeap#_799;
        if (!(Heap[this#287, AVLTreeNode.left] == null)) {
          assert {:msg "  322.6: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#288: int :: (0 <= k#92#288) && (k#92#288 < Seq#Length(Heap[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys], k#92#288) < Heap[this#287, AVLTreeNode.key]));
        }
        if (!(Heap[this#287, AVLTreeNode.right] == null)) {
          assert {:msg "  322.6: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#289: int :: (0 <= k#93#289) && (k#93#289 < Seq#Length(Heap[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#287, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys], k#93#289)));
        }
        assert {:msg "  322.6: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#287, AVLTreeNode.left] == null, 0, Heap[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#287, AVLTreeNode.right] == null, 0, Heap[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
        assert {:msg "  322.6: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#287, AVLTreeNode.left] == null, 0, Heap[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#287, AVLTreeNode.right] == null, 0, Heap[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
        assert {:msg "  322.6: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  322.6: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_800[this#287, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_800[this#287, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_800[this#287, AVLTreeNode.key][perm$N]));
        exhaleMask#_800[this#287, AVLTreeNode.key] := exhaleMask#_800[this#287, AVLTreeNode.key][perm$R := exhaleMask#_800[this#287, AVLTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_800);
        assume wf(Heap, exhaleMask#_800, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  322.6: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  322.6: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_800[this#287, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_800[this#287, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_800[this#287, AVLTreeNode.height][perm$N]));
        exhaleMask#_800[this#287, AVLTreeNode.height] := exhaleMask#_800[this#287, AVLTreeNode.height][perm$R := exhaleMask#_800[this#287, AVLTreeNode.height][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_800);
        assume wf(Heap, exhaleMask#_800, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  322.6: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  322.6: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_800[this#287, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_800[this#287, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_800[this#287, AVLTreeNode.left][perm$N]));
        exhaleMask#_800[this#287, AVLTreeNode.left] := exhaleMask#_800[this#287, AVLTreeNode.left][perm$R := exhaleMask#_800[this#287, AVLTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_800);
        assume wf(Heap, exhaleMask#_800, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  322.6: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  322.6: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_800[this#287, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_800[this#287, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_800[this#287, AVLTreeNode.right][perm$N]));
        exhaleMask#_800[this#287, AVLTreeNode.right] := exhaleMask#_800[this#287, AVLTreeNode.right][perm$R := exhaleMask#_800[this#287, AVLTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_800);
        assume wf(Heap, exhaleMask#_800, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  322.6: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  322.6: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_800[this#287, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_800[this#287, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_800[this#287, AVLTreeNode.keys][perm$N]));
        exhaleMask#_800[this#287, AVLTreeNode.keys] := exhaleMask#_800[this#287, AVLTreeNode.keys][perm$R := exhaleMask#_800[this#287, AVLTreeNode.keys][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_800);
        assume wf(Heap, exhaleMask#_800, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  322.6: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  322.6: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_800[this#287, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_800[this#287, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_800[this#287, AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_800[this#287, AVLTreeNode.balanceFactor] := exhaleMask#_800[this#287, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_800[this#287, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_800);
        assume wf(Heap, exhaleMask#_800, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#287, AVLTreeNode.left] == null)) {
          assert {:msg "  322.6: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  322.6: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_800, SecMask, Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid)) {
            assume Heap[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_799[Heap[this#287, AVLTreeNode.left], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#287, AVLTreeNode.left] == null)) {
          assert {:msg "  322.6: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
          assert {:msg "  322.6: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#287, AVLTreeNode.left] == null)) {
          assert {:msg "  322.6: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
          assert {:msg "  322.6: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#287, AVLTreeNode.left] == null)) {
          assert {:msg "  322.6: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
          assert {:msg "  322.6: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#287, AVLTreeNode.right] == null)) {
          assert {:msg "  322.6: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
          assert {:msg "  322.6: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_800, SecMask, Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid)) {
            assume Heap[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_799[Heap[this#287, AVLTreeNode.right], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#287, AVLTreeNode.right] == null)) {
          assert {:msg "  322.6: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
          assert {:msg "  322.6: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#287, AVLTreeNode.right] == null)) {
          assert {:msg "  322.6: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
          assert {:msg "  322.6: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#287, AVLTreeNode.right] == null)) {
          assert {:msg "  322.6: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
          assert {:msg "  322.6: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_800[Heap[this#287, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_800);
          assume wf(Heap, exhaleMask#_800, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        Mask := exhaleMask#_800;
        assume IsGoodExhaleState(exhaleHeap#_799, Heap, Mask, SecMask);
        Heap := exhaleHeap#_799;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        // inhale (postcondition)
        assume this#287 != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[this#287, AVLTreeNode.valid] := Mask[this#287, AVLTreeNode.valid][perm$R := Mask[this#287, AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#287, AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume this#287 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#287, AVLTreeNode.height] := Mask[this#287, AVLTreeNode.height][perm$R := Mask[this#287, AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#287, AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume this#287 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#287, AVLTreeNode.keys] := Mask[this#287, AVLTreeNode.keys][perm$R := Mask[this#287, AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#287, AVLTreeNode.keys]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume this#287 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#287, AVLTreeNode.balanceFactor] := Mask[this#287, AVLTreeNode.balanceFactor][perm$R := Mask[this#287, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#287, AVLTreeNode.balanceFactor]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Seq#Equal(Heap[this#287, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_794[this#287, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_794[callHeap#_794[this#287, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_794[this#287, AVLTreeNode.key])), ite(callHeap#_794[this#287, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_794[callHeap#_794[this#287, AVLTreeNode.right], AVLTreeNode.keys])));
        assume Heap[this#287, AVLTreeNode.height] == ite(ite(callHeap#_794[this#287, AVLTreeNode.left] == null, 0, callHeap#_794[callHeap#_794[this#287, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_794[this#287, AVLTreeNode.right] == null, 0, callHeap#_794[callHeap#_794[this#287, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_794[this#287, AVLTreeNode.left] == null, 0, callHeap#_794[callHeap#_794[this#287, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_794[this#287, AVLTreeNode.right] == null, 0, callHeap#_794[callHeap#_794[this#287, AVLTreeNode.right], AVLTreeNode.height]) + 1);
        assume Heap[this#287, AVLTreeNode.balanceFactor] == (ite(callHeap#_794[this#287, AVLTreeNode.left] == null, 0, callHeap#_794[callHeap#_794[this#287, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_794[this#287, AVLTreeNode.right] == null, 0, callHeap#_794[callHeap#_794[this#287, AVLTreeNode.right], AVLTreeNode.height]));
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
      }
    } else {
      // if
      cond#_817 := !(Heap[this, AVLTreeNode.right] == null);
      assert {:msg "  325.9: Receiver might be null."} true ==> (this != null);
      assert {:msg "  325.9: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
      if (cond#_817) {
        // local var nr
        assume (0 < methodCallK#_822) && ((1000 * methodCallK#_822) < Fractions(1)) && ((1000 * methodCallK#_822) < methodK#_506);
        // call remove
        callHeap#_818 := Heap;
        callMask#_819 := Mask;
        callSecMask#_820 := SecMask;
        callCredits#_821 := Credits;
        assume wf(callHeap#_818, callMask#_819, callSecMask#_820);
        assert {:msg "  327.17: Receiver might be null."} true ==> (this != null);
        assert {:msg "  327.17: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTreeNode.right);
        assert {:msg "  327.6: The target of the method call might be null."} Heap[this, AVLTreeNode.right] != null;
        this#292 := Heap[this, AVLTreeNode.right];
        k#293 := k#19;
        // begin exhale (precondition)
        exhaleMask#_824 := Mask;
        havoc exhaleHeap#_823;
        assert {:msg "  327.6: The precondition at 254.12 might not hold. The permission at 254.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  327.6: The precondition at 254.12 might not hold. Insufficient fraction at 254.12 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_824[this#292, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_824[this#292, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_824[this#292, AVLTreeNode.valid][perm$N]));
        exhaleMask#_824[this#292, AVLTreeNode.valid] := exhaleMask#_824[this#292, AVLTreeNode.valid][perm$R := exhaleMask#_824[this#292, AVLTreeNode.valid][perm$R] - Fractions(100)];
        if (!CanRead(exhaleMask#_824, SecMask, this#292, AVLTreeNode.valid)) {
          assume Heap[this#292, AVLTreeNode.valid] < exhaleHeap#_823[this#292, AVLTreeNode.valid];
        }
        assume IsGoodMask(exhaleMask#_824);
        assume wf(Heap, exhaleMask#_824, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  327.6: The precondition at 255.12 might not hold. The permission at 255.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  327.6: The precondition at 255.12 might not hold. Insufficient fraction at 255.12 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_824[this#292, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_824[this#292, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_824[this#292, AVLTreeNode.keys][perm$N]));
        exhaleMask#_824[this#292, AVLTreeNode.keys] := exhaleMask#_824[this#292, AVLTreeNode.keys][perm$R := exhaleMask#_824[this#292, AVLTreeNode.keys][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_824);
        assume wf(Heap, exhaleMask#_824, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  327.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  327.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_824[this#292, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_824[this#292, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_824[this#292, AVLTreeNode.height][perm$N]));
        exhaleMask#_824[this#292, AVLTreeNode.height] := exhaleMask#_824[this#292, AVLTreeNode.height][perm$R := exhaleMask#_824[this#292, AVLTreeNode.height][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_824);
        assume wf(Heap, exhaleMask#_824, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  327.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive."} Fractions(50) > 0;
        assert {:msg "  327.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_824[this#292, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_824[this#292, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_824[this#292, AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_824[this#292, AVLTreeNode.balanceFactor] := exhaleMask#_824[this#292, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_824[this#292, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
        assume IsGoodMask(exhaleMask#_824);
        assume wf(Heap, exhaleMask#_824, SecMask);
        assume wf(Heap, Mask, SecMask);
        Mask := exhaleMask#_824;
        assume IsGoodExhaleState(exhaleHeap#_823, Heap, Mask, SecMask);
        Heap := exhaleHeap#_823;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        havoc r#294;
        // inhale (postcondition)
        if (Seq#Equal(callHeap#_818[this#292, AVLTreeNode.keys], Seq#Singleton(k#293))) {
          assume r#294 == null;
        }
        if (!Seq#Equal(callHeap#_818[this#292, AVLTreeNode.keys], Seq#Singleton(k#293))) {
          assume !(r#294 == null);
        }
        if (!(r#294 == null)) {
          assume r#294 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[r#294, AVLTreeNode.valid] := Mask[r#294, AVLTreeNode.valid][perm$R := Mask[r#294, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#294, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#294 == null)) {
          assume r#294 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#294, AVLTreeNode.keys] := Mask[r#294, AVLTreeNode.keys][perm$R := Mask[r#294, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#294, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#294 == null)) {
          assume r#294 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#294, AVLTreeNode.height] := Mask[r#294, AVLTreeNode.height][perm$R := Mask[r#294, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#294, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#294 == null)) {
          assume r#294 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#294, AVLTreeNode.balanceFactor] := Mask[r#294, AVLTreeNode.balanceFactor][perm$R := Mask[r#294, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#294, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(r#294 == null)) {
          assume !Seq#Contains(Heap[r#294, AVLTreeNode.keys], k#293);
        }
        if (!(r#294 == null)) {
          assume (forall i#84#295: int :: (0 <= i#84#295) && (i#84#295 < Seq#Length(callHeap#_818[this#292, AVLTreeNode.keys])) ==> (Seq#Contains(Heap[r#294, AVLTreeNode.keys], Seq#Index(callHeap#_818[this#292, AVLTreeNode.keys], i#84#295)) || (Seq#Index(callHeap#_818[this#292, AVLTreeNode.keys], i#84#295) == k#293)));
        }
        if (!(r#294 == null)) {
          assume (forall i#85#296: int :: (0 <= i#85#296) && (i#85#296 < Seq#Length(Heap[r#294, AVLTreeNode.keys])) ==> Seq#Contains(callHeap#_818[this#292, AVLTreeNode.keys], Seq#Index(Heap[r#294, AVLTreeNode.keys], i#85#296)) && (!(Seq#Index(Heap[r#294, AVLTreeNode.keys], i#85#296) == k#293)));
        }
        if (!Seq#Contains(callHeap#_818[this#292, AVLTreeNode.keys], k#293)) {
          assume !(r#294 == null);
        }
        if (!Seq#Contains(callHeap#_818[this#292, AVLTreeNode.keys], k#293)) {
          assume Seq#Equal(Heap[r#294, AVLTreeNode.keys], callHeap#_818[this#292, AVLTreeNode.keys]);
        }
        if (!(r#294 == null)) {
          if (Seq#Contains(callHeap#_818[this#292, AVLTreeNode.keys], k#293)) {
            assume Seq#Length(Heap[r#294, AVLTreeNode.keys]) == (Seq#Length(callHeap#_818[this#292, AVLTreeNode.keys]) - 1);
          }
        }
        if (callHeap#_818[this#292, AVLTreeNode.height] > 1) {
          assume !(r#294 == null);
        }
        if (!(r#294 == null)) {
          assume (Heap[r#294, AVLTreeNode.height] == callHeap#_818[this#292, AVLTreeNode.height]) || ((Heap[r#294, AVLTreeNode.height] + 1) == callHeap#_818[this#292, AVLTreeNode.height]);
        }
        if (!Seq#Contains(callHeap#_818[this#292, AVLTreeNode.keys], k#293)) {
          assume Heap[r#294, AVLTreeNode.height] == callHeap#_818[this#292, AVLTreeNode.height];
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
        nr#32 := r#294;
        // update field right
        assert {:msg "  328.6: Location might not be writable"} CanWrite(Mask, this, AVLTreeNode.right);
        Heap[this, AVLTreeNode.right] := nr#32;
        assume wf(Heap, Mask, SecMask);
        // local var bf
        assume (0 < methodCallK#_835) && ((1000 * methodCallK#_835) < Fractions(1)) && ((1000 * methodCallK#_835) < methodK#_506);
        // call getBalanceFactorI
        callHeap#_831 := Heap;
        callMask#_832 := Mask;
        callSecMask#_833 := SecMask;
        callCredits#_834 := Credits;
        assume wf(callHeap#_831, callMask#_832, callSecMask#_833);
        assert {:msg "  331.6: The target of the method call might be null."} this != null;
        this#297 := this;
        // begin exhale (precondition)
        exhaleMask#_837 := Mask;
        havoc exhaleHeap#_836;
        assert {:msg "  331.6: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive."} methodCallK#_835 > 0;
        assert {:msg "  331.6: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left."} exhaleMask#_837[this#297, AVLTreeNode.left][perm$R] > 0;
        assume methodCallK#_835 < exhaleMask#_837[this#297, AVLTreeNode.left][perm$R];
        exhaleMask#_837[this#297, AVLTreeNode.left] := exhaleMask#_837[this#297, AVLTreeNode.left][perm$R := exhaleMask#_837[this#297, AVLTreeNode.left][perm$R] - methodCallK#_835];
        assume IsGoodMask(exhaleMask#_837);
        assume wf(Heap, exhaleMask#_837, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#297, AVLTreeNode.left] == null)) {
          assert {:msg "  331.6: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive."} methodCallK#_835 > 0;
          assert {:msg "  331.6: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height."} exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height][perm$R] > 0;
          assume methodCallK#_835 < exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height][perm$R];
          exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height][perm$R] - methodCallK#_835];
          assume IsGoodMask(exhaleMask#_837);
          assume wf(Heap, exhaleMask#_837, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assert {:msg "  331.6: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive."} methodCallK#_835 > 0;
        assert {:msg "  331.6: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right."} exhaleMask#_837[this#297, AVLTreeNode.right][perm$R] > 0;
        assume methodCallK#_835 < exhaleMask#_837[this#297, AVLTreeNode.right][perm$R];
        exhaleMask#_837[this#297, AVLTreeNode.right] := exhaleMask#_837[this#297, AVLTreeNode.right][perm$R := exhaleMask#_837[this#297, AVLTreeNode.right][perm$R] - methodCallK#_835];
        assume IsGoodMask(exhaleMask#_837);
        assume wf(Heap, exhaleMask#_837, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#297, AVLTreeNode.right] == null)) {
          assert {:msg "  331.6: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive."} methodCallK#_835 > 0;
          assert {:msg "  331.6: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height."} exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height][perm$R] > 0;
          assume methodCallK#_835 < exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height][perm$R];
          exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height][perm$R] - methodCallK#_835];
          assume IsGoodMask(exhaleMask#_837);
          assume wf(Heap, exhaleMask#_837, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#297, AVLTreeNode.left] == null)) {
          assert {:msg "  331.6: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  331.6: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
          exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_837[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_837, SecMask, Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid)) {
            assume Heap[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_836[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_837);
          assume wf(Heap, exhaleMask#_837, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#297, AVLTreeNode.right] == null)) {
          assert {:msg "  331.6: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive."} Fractions(100) > 0;
          assert {:msg "  331.6: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
          exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_837[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_837, SecMask, Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid)) {
            assume Heap[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_836[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_837);
          assume wf(Heap, exhaleMask#_837, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        Mask := exhaleMask#_837;
        assume IsGoodExhaleState(exhaleHeap#_836, Heap, Mask, SecMask);
        Heap := exhaleHeap#_836;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        havoc bf#298;
        // inhale (postcondition)
        assume this#297 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[this#297, AVLTreeNode.left] == null) || (dtype(Heap[this#297, AVLTreeNode.left]) == AVLTreeNode#t);
        assume methodCallK#_835 > 0;
        Mask[this#297, AVLTreeNode.left] := Mask[this#297, AVLTreeNode.left][perm$R := Mask[this#297, AVLTreeNode.left][perm$R] + methodCallK#_835];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#297, AVLTreeNode.left]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#297, AVLTreeNode.left] == null)) {
          assume Heap[this#297, AVLTreeNode.left] != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid] := Mask[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid][perm$R := Mask[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#297, AVLTreeNode.left], AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#297, AVLTreeNode.left] == null)) {
          assume Heap[this#297, AVLTreeNode.left] != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume methodCallK#_835 > 0;
          Mask[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height] := Mask[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height][perm$R := Mask[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height][perm$R] + methodCallK#_835];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume this#297 != null;
        assume wf(Heap, Mask, SecMask);
        assume (Heap[this#297, AVLTreeNode.right] == null) || (dtype(Heap[this#297, AVLTreeNode.right]) == AVLTreeNode#t);
        assume methodCallK#_835 > 0;
        Mask[this#297, AVLTreeNode.right] := Mask[this#297, AVLTreeNode.right][perm$R := Mask[this#297, AVLTreeNode.right][perm$R] + methodCallK#_835];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#297, AVLTreeNode.right]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#297, AVLTreeNode.right] == null)) {
          assume Heap[this#297, AVLTreeNode.right] != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid] := Mask[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid][perm$R := Mask[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#297, AVLTreeNode.right], AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#297, AVLTreeNode.right] == null)) {
          assume Heap[this#297, AVLTreeNode.right] != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume methodCallK#_835 > 0;
          Mask[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height] := Mask[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height][perm$R := Mask[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height][perm$R] + methodCallK#_835];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        assume bf#298 == (ite(Heap[this#297, AVLTreeNode.left] == null, 0, Heap[Heap[this#297, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#297, AVLTreeNode.right] == null, 0, Heap[Heap[this#297, AVLTreeNode.right], AVLTreeNode.height]));
        if (bf#298 > 0) {
          assume !(Heap[this#297, AVLTreeNode.left] == null);
        }
        if (bf#298 < 0) {
          assume !(Heap[this#297, AVLTreeNode.right] == null);
        }
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
        bf#34 := bf#298;
        // if
        cond#_846 := bf#34 == 2;
        if (cond#_846) {
          assume (0 < methodCallK#_851) && ((1000 * methodCallK#_851) < Fractions(1)) && ((1000 * methodCallK#_851) < methodK#_506);
          // call rebalanceLeft
          callHeap#_847 := Heap;
          callMask#_848 := Mask;
          callSecMask#_849 := SecMask;
          callCredits#_850 := Credits;
          assume wf(callHeap#_847, callMask#_848, callSecMask#_849);
          assert {:msg "  333.7: The target of the method call might be null."} this != null;
          this#299 := this;
          // begin exhale (precondition)
          exhaleMask#_853 := Mask;
          havoc exhaleHeap#_852;
          assert {:msg "  333.7: The precondition at 608.12 might not hold. The expression at 608.12 might not evaluate to true."} !(Heap[this#299, AVLTreeNode.left] == null);
          assert {:msg "  333.7: The precondition at 613.12 might not hold. The expression at 613.12 might not evaluate to true."} (forall k#94#301: int :: (0 <= k#94#301) && (k#94#301 < Seq#Length(Heap[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys], k#94#301) < Heap[this#299, AVLTreeNode.key]));
          if (!(Heap[this#299, AVLTreeNode.right] == null)) {
            assert {:msg "  333.7: The precondition at 619.12 might not hold. The expression at 619.28 might not evaluate to true."} (forall k#95#302: int :: (0 <= k#95#302) && (k#95#302 < Seq#Length(Heap[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#299, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys], k#95#302)));
          }
          assert {:msg "  333.7: The precondition at 621.12 might not hold. The expression at 621.12 might not evaluate to true."} (Heap[Heap[this#299, AVLTreeNode.left], AVLTreeNode.height] - ite(Heap[this#299, AVLTreeNode.right] == null, 0, Heap[Heap[this#299, AVLTreeNode.right], AVLTreeNode.height])) == 2;
          assert {:msg "  333.7: The precondition at 600.12 might not hold. The permission at 600.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  333.7: The precondition at 600.12 might not hold. Insufficient fraction at 600.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_853[this#299, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_853[this#299, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_853[this#299, AVLTreeNode.key][perm$N]));
          exhaleMask#_853[this#299, AVLTreeNode.key] := exhaleMask#_853[this#299, AVLTreeNode.key][perm$R := exhaleMask#_853[this#299, AVLTreeNode.key][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 601.12 might not hold. The permission at 601.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  333.7: The precondition at 601.12 might not hold. Insufficient fraction at 601.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_853[this#299, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_853[this#299, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_853[this#299, AVLTreeNode.height][perm$N]));
          exhaleMask#_853[this#299, AVLTreeNode.height] := exhaleMask#_853[this#299, AVLTreeNode.height][perm$R := exhaleMask#_853[this#299, AVLTreeNode.height][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 602.12 might not hold. The permission at 602.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  333.7: The precondition at 602.12 might not hold. Insufficient fraction at 602.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_853[this#299, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_853[this#299, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_853[this#299, AVLTreeNode.left][perm$N]));
          exhaleMask#_853[this#299, AVLTreeNode.left] := exhaleMask#_853[this#299, AVLTreeNode.left][perm$R := exhaleMask#_853[this#299, AVLTreeNode.left][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 603.12 might not hold. The permission at 603.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  333.7: The precondition at 603.12 might not hold. Insufficient fraction at 603.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_853[this#299, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_853[this#299, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_853[this#299, AVLTreeNode.right][perm$N]));
          exhaleMask#_853[this#299, AVLTreeNode.right] := exhaleMask#_853[this#299, AVLTreeNode.right][perm$R := exhaleMask#_853[this#299, AVLTreeNode.right][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 605.12 might not hold. The permission at 605.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  333.7: The precondition at 605.12 might not hold. Insufficient fraction at 605.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_853[this#299, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_853[this#299, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_853[this#299, AVLTreeNode.keys][perm$N]));
          exhaleMask#_853[this#299, AVLTreeNode.keys] := exhaleMask#_853[this#299, AVLTreeNode.keys][perm$R := exhaleMask#_853[this#299, AVLTreeNode.keys][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 606.12 might not hold. The permission at 606.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  333.7: The precondition at 606.12 might not hold. Insufficient fraction at 606.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_853[this#299, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_853[this#299, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_853[this#299, AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_853[this#299, AVLTreeNode.balanceFactor] := exhaleMask#_853[this#299, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_853[this#299, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 609.12 might not hold. The permission at 609.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  333.7: The precondition at 609.12 might not hold. Insufficient fraction at 609.12 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
          exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_853, SecMask, Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid)) {
            assume Heap[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_852[Heap[this#299, AVLTreeNode.left], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 610.12 might not hold. The permission at 610.12 might not be positive."} Fractions(50) > 0;
          assert {:msg "  333.7: The precondition at 610.12 might not hold. Insufficient fraction at 610.12 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
          exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 611.12 might not hold. The permission at 611.12 might not be positive."} Fractions(50) > 0;
          assert {:msg "  333.7: The precondition at 611.12 might not hold. Insufficient fraction at 611.12 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
          exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  333.7: The precondition at 612.12 might not hold. The permission at 612.12 might not be positive."} Fractions(50) > 0;
          assert {:msg "  333.7: The precondition at 612.12 might not hold. Insufficient fraction at 612.12 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_853);
          assume wf(Heap, exhaleMask#_853, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[this#299, AVLTreeNode.right] == null)) {
            assert {:msg "  333.7: The precondition at 615.12 might not hold. The permission at 615.28 might not be positive."} Fractions(100) > 0;
            assert {:msg "  333.7: The precondition at 615.12 might not hold. Insufficient fraction at 615.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
            exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (!CanRead(exhaleMask#_853, SecMask, Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid)) {
              assume Heap[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_852[Heap[this#299, AVLTreeNode.right], AVLTreeNode.valid];
            }
            assume IsGoodMask(exhaleMask#_853);
            assume wf(Heap, exhaleMask#_853, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#299, AVLTreeNode.right] == null)) {
            assert {:msg "  333.7: The precondition at 616.12 might not hold. The permission at 616.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  333.7: The precondition at 616.12 might not hold. Insufficient fraction at 616.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
            exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_853);
            assume wf(Heap, exhaleMask#_853, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#299, AVLTreeNode.right] == null)) {
            assert {:msg "  333.7: The precondition at 617.12 might not hold. The permission at 617.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  333.7: The precondition at 617.12 might not hold. Insufficient fraction at 617.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
            exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_853);
            assume wf(Heap, exhaleMask#_853, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#299, AVLTreeNode.right] == null)) {
            assert {:msg "  333.7: The precondition at 618.12 might not hold. The permission at 618.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  333.7: The precondition at 618.12 might not hold. Insufficient fraction at 618.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
            exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_853[Heap[this#299, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_853);
            assume wf(Heap, exhaleMask#_853, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          Mask := exhaleMask#_853;
          assume IsGoodExhaleState(exhaleHeap#_852, Heap, Mask, SecMask);
          Heap := exhaleHeap#_852;
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end exhale
          havoc r#300;
          // inhale (postcondition)
          assume !(r#300 == null);
          assume r#300 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[r#300, AVLTreeNode.valid] := Mask[r#300, AVLTreeNode.valid][perm$R := Mask[r#300, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#300, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume r#300 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#300, AVLTreeNode.height] := Mask[r#300, AVLTreeNode.height][perm$R := Mask[r#300, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#300, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume r#300 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#300, AVLTreeNode.keys] := Mask[r#300, AVLTreeNode.keys][perm$R := Mask[r#300, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#300, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume r#300 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[r#300, AVLTreeNode.balanceFactor] := Mask[r#300, AVLTreeNode.balanceFactor][perm$R := Mask[r#300, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[r#300, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume (Heap[r#300, AVLTreeNode.height] == callHeap#_847[callHeap#_847[this#299, AVLTreeNode.left], AVLTreeNode.height]) || (Heap[r#300, AVLTreeNode.height] == (callHeap#_847[callHeap#_847[this#299, AVLTreeNode.left], AVLTreeNode.height] + 1));
          assume Seq#Equal(Heap[r#300, AVLTreeNode.keys], Seq#Append(Seq#Append(callHeap#_847[callHeap#_847[this#299, AVLTreeNode.left], AVLTreeNode.keys], Seq#Singleton(callHeap#_847[this#299, AVLTreeNode.key])), ite(callHeap#_847[this#299, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_847[callHeap#_847[this#299, AVLTreeNode.right], AVLTreeNode.keys])));
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end inhale
          r#20 := r#300;
        } else {
          // assigment to r
          r#20 := this;
          assume (0 < methodCallK#_874) && ((1000 * methodCallK#_874) < Fractions(1)) && ((1000 * methodCallK#_874) < methodK#_506);
          // call close
          callHeap#_870 := Heap;
          callMask#_871 := Mask;
          callSecMask#_872 := SecMask;
          callCredits#_873 := Credits;
          assume wf(callHeap#_870, callMask#_871, callSecMask#_872);
          assert {:msg "  336.7: The target of the method call might be null."} r#20 != null;
          this#305 := r#20;
          // begin exhale (precondition)
          exhaleMask#_876 := Mask;
          havoc exhaleHeap#_875;
          if (!(Heap[this#305, AVLTreeNode.left] == null)) {
            assert {:msg "  336.7: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#306: int :: (0 <= k#92#306) && (k#92#306 < Seq#Length(Heap[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys], k#92#306) < Heap[this#305, AVLTreeNode.key]));
          }
          if (!(Heap[this#305, AVLTreeNode.right] == null)) {
            assert {:msg "  336.7: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#307: int :: (0 <= k#93#307) && (k#93#307 < Seq#Length(Heap[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#305, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys], k#93#307)));
          }
          assert {:msg "  336.7: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#305, AVLTreeNode.left] == null, 0, Heap[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#305, AVLTreeNode.right] == null, 0, Heap[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
          assert {:msg "  336.7: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#305, AVLTreeNode.left] == null, 0, Heap[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#305, AVLTreeNode.right] == null, 0, Heap[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
          assert {:msg "  336.7: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  336.7: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_876[this#305, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_876[this#305, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_876[this#305, AVLTreeNode.key][perm$N]));
          exhaleMask#_876[this#305, AVLTreeNode.key] := exhaleMask#_876[this#305, AVLTreeNode.key][perm$R := exhaleMask#_876[this#305, AVLTreeNode.key][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_876);
          assume wf(Heap, exhaleMask#_876, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  336.7: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  336.7: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_876[this#305, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_876[this#305, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_876[this#305, AVLTreeNode.height][perm$N]));
          exhaleMask#_876[this#305, AVLTreeNode.height] := exhaleMask#_876[this#305, AVLTreeNode.height][perm$R := exhaleMask#_876[this#305, AVLTreeNode.height][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_876);
          assume wf(Heap, exhaleMask#_876, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  336.7: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  336.7: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_876[this#305, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_876[this#305, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_876[this#305, AVLTreeNode.left][perm$N]));
          exhaleMask#_876[this#305, AVLTreeNode.left] := exhaleMask#_876[this#305, AVLTreeNode.left][perm$R := exhaleMask#_876[this#305, AVLTreeNode.left][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_876);
          assume wf(Heap, exhaleMask#_876, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  336.7: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  336.7: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_876[this#305, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_876[this#305, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_876[this#305, AVLTreeNode.right][perm$N]));
          exhaleMask#_876[this#305, AVLTreeNode.right] := exhaleMask#_876[this#305, AVLTreeNode.right][perm$R := exhaleMask#_876[this#305, AVLTreeNode.right][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_876);
          assume wf(Heap, exhaleMask#_876, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  336.7: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  336.7: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_876[this#305, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_876[this#305, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_876[this#305, AVLTreeNode.keys][perm$N]));
          exhaleMask#_876[this#305, AVLTreeNode.keys] := exhaleMask#_876[this#305, AVLTreeNode.keys][perm$R := exhaleMask#_876[this#305, AVLTreeNode.keys][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_876);
          assume wf(Heap, exhaleMask#_876, SecMask);
          assume wf(Heap, Mask, SecMask);
          assert {:msg "  336.7: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
          assert {:msg "  336.7: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_876[this#305, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_876[this#305, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_876[this#305, AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_876[this#305, AVLTreeNode.balanceFactor] := exhaleMask#_876[this#305, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_876[this#305, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
          assume IsGoodMask(exhaleMask#_876);
          assume wf(Heap, exhaleMask#_876, SecMask);
          assume wf(Heap, Mask, SecMask);
          if (!(Heap[this#305, AVLTreeNode.left] == null)) {
            assert {:msg "  336.7: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
            assert {:msg "  336.7: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (!CanRead(exhaleMask#_876, SecMask, Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid)) {
              assume Heap[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_875[Heap[this#305, AVLTreeNode.left], AVLTreeNode.valid];
            }
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#305, AVLTreeNode.left] == null)) {
            assert {:msg "  336.7: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
            assert {:msg "  336.7: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#305, AVLTreeNode.left] == null)) {
            assert {:msg "  336.7: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
            assert {:msg "  336.7: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#305, AVLTreeNode.left] == null)) {
            assert {:msg "  336.7: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
            assert {:msg "  336.7: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#305, AVLTreeNode.right] == null)) {
            assert {:msg "  336.7: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
            assert {:msg "  336.7: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
            if (!CanRead(exhaleMask#_876, SecMask, Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid)) {
              assume Heap[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_875[Heap[this#305, AVLTreeNode.right], AVLTreeNode.valid];
            }
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#305, AVLTreeNode.right] == null)) {
            assert {:msg "  336.7: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  336.7: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#305, AVLTreeNode.right] == null)) {
            assert {:msg "  336.7: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  336.7: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          if (!(Heap[this#305, AVLTreeNode.right] == null)) {
            assert {:msg "  336.7: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
            assert {:msg "  336.7: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
            exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_876[Heap[this#305, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
            assume IsGoodMask(exhaleMask#_876);
            assume wf(Heap, exhaleMask#_876, SecMask);
            assume wf(Heap, Mask, SecMask);
          }
          Mask := exhaleMask#_876;
          assume IsGoodExhaleState(exhaleHeap#_875, Heap, Mask, SecMask);
          Heap := exhaleHeap#_875;
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end exhale
          // inhale (postcondition)
          assume this#305 != null;
          assume wf(Heap, Mask, SecMask);
          assume Fractions(100) > 0;
          Mask[this#305, AVLTreeNode.valid] := Mask[this#305, AVLTreeNode.valid][perm$R := Mask[this#305, AVLTreeNode.valid][perm$R] + Fractions(100)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#305, AVLTreeNode.valid]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume this#305 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[this#305, AVLTreeNode.height] := Mask[this#305, AVLTreeNode.height][perm$R := Mask[this#305, AVLTreeNode.height][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#305, AVLTreeNode.height]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume this#305 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[this#305, AVLTreeNode.keys] := Mask[this#305, AVLTreeNode.keys][perm$R := Mask[this#305, AVLTreeNode.keys][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#305, AVLTreeNode.keys]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume this#305 != null;
          assume wf(Heap, Mask, SecMask);
          assume true;
          assume Fractions(50) > 0;
          Mask[this#305, AVLTreeNode.balanceFactor] := Mask[this#305, AVLTreeNode.balanceFactor][perm$R := Mask[this#305, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
          assume IsGoodMask(Mask);
          assume IsGoodState(heapFragment(Heap[this#305, AVLTreeNode.balanceFactor]));
          assume wf(Heap, Mask, SecMask);
          assume wf(Heap, Mask, SecMask);
          assume Seq#Equal(Heap[this#305, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_870[this#305, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_870[callHeap#_870[this#305, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_870[this#305, AVLTreeNode.key])), ite(callHeap#_870[this#305, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_870[callHeap#_870[this#305, AVLTreeNode.right], AVLTreeNode.keys])));
          assume Heap[this#305, AVLTreeNode.height] == ite(ite(callHeap#_870[this#305, AVLTreeNode.left] == null, 0, callHeap#_870[callHeap#_870[this#305, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_870[this#305, AVLTreeNode.right] == null, 0, callHeap#_870[callHeap#_870[this#305, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_870[this#305, AVLTreeNode.left] == null, 0, callHeap#_870[callHeap#_870[this#305, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_870[this#305, AVLTreeNode.right] == null, 0, callHeap#_870[callHeap#_870[this#305, AVLTreeNode.right], AVLTreeNode.height]) + 1);
          assume Heap[this#305, AVLTreeNode.balanceFactor] == (ite(callHeap#_870[this#305, AVLTreeNode.left] == null, 0, callHeap#_870[callHeap#_870[this#305, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_870[this#305, AVLTreeNode.right] == null, 0, callHeap#_870[callHeap#_870[this#305, AVLTreeNode.right], AVLTreeNode.height]));
          assume IsGoodMask(Mask);
          assume wf(Heap, Mask, SecMask);
          // end inhale
        }
      } else {
        // assigment to r
        r#20 := this;
        assume (0 < methodCallK#_897) && ((1000 * methodCallK#_897) < Fractions(1)) && ((1000 * methodCallK#_897) < methodK#_506);
        // call close
        callHeap#_893 := Heap;
        callMask#_894 := Mask;
        callSecMask#_895 := SecMask;
        callCredits#_896 := Credits;
        assume wf(callHeap#_893, callMask#_894, callSecMask#_895);
        assert {:msg "  340.6: The target of the method call might be null."} r#20 != null;
        this#310 := r#20;
        // begin exhale (precondition)
        exhaleMask#_899 := Mask;
        havoc exhaleHeap#_898;
        if (!(Heap[this#310, AVLTreeNode.left] == null)) {
          assert {:msg "  340.6: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true."} (forall k#92#311: int :: (0 <= k#92#311) && (k#92#311 < Seq#Length(Heap[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys])) ==> (Seq#Index(Heap[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys], k#92#311) < Heap[this#310, AVLTreeNode.key]));
        }
        if (!(Heap[this#310, AVLTreeNode.right] == null)) {
          assert {:msg "  340.6: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true."} (forall k#93#312: int :: (0 <= k#93#312) && (k#93#312 < Seq#Length(Heap[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys])) ==> (Heap[this#310, AVLTreeNode.key] < Seq#Index(Heap[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys], k#93#312)));
        }
        assert {:msg "  340.6: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true."} (ite(Heap[this#310, AVLTreeNode.left] == null, 0, Heap[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#310, AVLTreeNode.right] == null, 0, Heap[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height])) <= 1;
        assert {:msg "  340.6: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true."} (ite(Heap[this#310, AVLTreeNode.left] == null, 0, Heap[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height]) - ite(Heap[this#310, AVLTreeNode.right] == null, 0, Heap[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height])) >= (0 - 1);
        assert {:msg "  340.6: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  340.6: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_899[this#310, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_899[this#310, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_899[this#310, AVLTreeNode.key][perm$N]));
        exhaleMask#_899[this#310, AVLTreeNode.key] := exhaleMask#_899[this#310, AVLTreeNode.key][perm$R := exhaleMask#_899[this#310, AVLTreeNode.key][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_899);
        assume wf(Heap, exhaleMask#_899, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  340.6: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  340.6: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_899[this#310, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_899[this#310, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_899[this#310, AVLTreeNode.height][perm$N]));
        exhaleMask#_899[this#310, AVLTreeNode.height] := exhaleMask#_899[this#310, AVLTreeNode.height][perm$R := exhaleMask#_899[this#310, AVLTreeNode.height][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_899);
        assume wf(Heap, exhaleMask#_899, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  340.6: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  340.6: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_899[this#310, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_899[this#310, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_899[this#310, AVLTreeNode.left][perm$N]));
        exhaleMask#_899[this#310, AVLTreeNode.left] := exhaleMask#_899[this#310, AVLTreeNode.left][perm$R := exhaleMask#_899[this#310, AVLTreeNode.left][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_899);
        assume wf(Heap, exhaleMask#_899, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  340.6: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  340.6: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_899[this#310, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_899[this#310, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_899[this#310, AVLTreeNode.right][perm$N]));
        exhaleMask#_899[this#310, AVLTreeNode.right] := exhaleMask#_899[this#310, AVLTreeNode.right][perm$R := exhaleMask#_899[this#310, AVLTreeNode.right][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_899);
        assume wf(Heap, exhaleMask#_899, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  340.6: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  340.6: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_899[this#310, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_899[this#310, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_899[this#310, AVLTreeNode.keys][perm$N]));
        exhaleMask#_899[this#310, AVLTreeNode.keys] := exhaleMask#_899[this#310, AVLTreeNode.keys][perm$R := exhaleMask#_899[this#310, AVLTreeNode.keys][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_899);
        assume wf(Heap, exhaleMask#_899, SecMask);
        assume wf(Heap, Mask, SecMask);
        assert {:msg "  340.6: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive."} Fractions(100) > 0;
        assert {:msg "  340.6: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_899[this#310, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_899[this#310, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_899[this#310, AVLTreeNode.balanceFactor][perm$N]));
        exhaleMask#_899[this#310, AVLTreeNode.balanceFactor] := exhaleMask#_899[this#310, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_899[this#310, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
        assume IsGoodMask(exhaleMask#_899);
        assume wf(Heap, exhaleMask#_899, SecMask);
        assume wf(Heap, Mask, SecMask);
        if (!(Heap[this#310, AVLTreeNode.left] == null)) {
          assert {:msg "  340.6: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive."} Fractions(100) > 0;
          assert {:msg "  340.6: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid] := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_899, SecMask, Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid)) {
            assume Heap[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid] < exhaleHeap#_898[Heap[this#310, AVLTreeNode.left], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#310, AVLTreeNode.left] == null)) {
          assert {:msg "  340.6: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive."} Fractions(50) > 0;
          assert {:msg "  340.6: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height] := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.height][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#310, AVLTreeNode.left] == null)) {
          assert {:msg "  340.6: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive."} Fractions(50) > 0;
          assert {:msg "  340.6: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys] := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#310, AVLTreeNode.left] == null)) {
          assert {:msg "  340.6: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive."} Fractions(50) > 0;
          assert {:msg "  340.6: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.balanceFactor] := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.left], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#310, AVLTreeNode.right] == null)) {
          assert {:msg "  340.6: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive."} Fractions(100) > 0;
          assert {:msg "  340.6: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid] := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid][perm$R] - Fractions(100)];
          if (!CanRead(exhaleMask#_899, SecMask, Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid)) {
            assume Heap[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid] < exhaleHeap#_898[Heap[this#310, AVLTreeNode.right], AVLTreeNode.valid];
          }
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#310, AVLTreeNode.right] == null)) {
          assert {:msg "  340.6: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive."} Fractions(50) > 0;
          assert {:msg "  340.6: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height] := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.height][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#310, AVLTreeNode.right] == null)) {
          assert {:msg "  340.6: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive."} Fractions(50) > 0;
          assert {:msg "  340.6: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys] := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.keys][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        if (!(Heap[this#310, AVLTreeNode.right] == null)) {
          assert {:msg "  340.6: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive."} Fractions(50) > 0;
          assert {:msg "  340.6: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$N]));
          exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.balanceFactor] := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_899[Heap[this#310, AVLTreeNode.right], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
          assume IsGoodMask(exhaleMask#_899);
          assume wf(Heap, exhaleMask#_899, SecMask);
          assume wf(Heap, Mask, SecMask);
        }
        Mask := exhaleMask#_899;
        assume IsGoodExhaleState(exhaleHeap#_898, Heap, Mask, SecMask);
        Heap := exhaleHeap#_898;
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end exhale
        // inhale (postcondition)
        assume this#310 != null;
        assume wf(Heap, Mask, SecMask);
        assume Fractions(100) > 0;
        Mask[this#310, AVLTreeNode.valid] := Mask[this#310, AVLTreeNode.valid][perm$R := Mask[this#310, AVLTreeNode.valid][perm$R] + Fractions(100)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#310, AVLTreeNode.valid]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume this#310 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#310, AVLTreeNode.height] := Mask[this#310, AVLTreeNode.height][perm$R := Mask[this#310, AVLTreeNode.height][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#310, AVLTreeNode.height]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume this#310 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#310, AVLTreeNode.keys] := Mask[this#310, AVLTreeNode.keys][perm$R := Mask[this#310, AVLTreeNode.keys][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#310, AVLTreeNode.keys]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume this#310 != null;
        assume wf(Heap, Mask, SecMask);
        assume true;
        assume Fractions(50) > 0;
        Mask[this#310, AVLTreeNode.balanceFactor] := Mask[this#310, AVLTreeNode.balanceFactor][perm$R := Mask[this#310, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
        assume IsGoodMask(Mask);
        assume IsGoodState(heapFragment(Heap[this#310, AVLTreeNode.balanceFactor]));
        assume wf(Heap, Mask, SecMask);
        assume wf(Heap, Mask, SecMask);
        assume Seq#Equal(Heap[this#310, AVLTreeNode.keys], Seq#Append(Seq#Append(ite(callHeap#_893[this#310, AVLTreeNode.left] == null, Seq#Empty(), callHeap#_893[callHeap#_893[this#310, AVLTreeNode.left], AVLTreeNode.keys]), Seq#Singleton(callHeap#_893[this#310, AVLTreeNode.key])), ite(callHeap#_893[this#310, AVLTreeNode.right] == null, Seq#Empty(), callHeap#_893[callHeap#_893[this#310, AVLTreeNode.right], AVLTreeNode.keys])));
        assume Heap[this#310, AVLTreeNode.height] == ite(ite(callHeap#_893[this#310, AVLTreeNode.left] == null, 0, callHeap#_893[callHeap#_893[this#310, AVLTreeNode.left], AVLTreeNode.height]) > ite(callHeap#_893[this#310, AVLTreeNode.right] == null, 0, callHeap#_893[callHeap#_893[this#310, AVLTreeNode.right], AVLTreeNode.height]), ite(callHeap#_893[this#310, AVLTreeNode.left] == null, 0, callHeap#_893[callHeap#_893[this#310, AVLTreeNode.left], AVLTreeNode.height]) + 1, ite(callHeap#_893[this#310, AVLTreeNode.right] == null, 0, callHeap#_893[callHeap#_893[this#310, AVLTreeNode.right], AVLTreeNode.height]) + 1);
        assume Heap[this#310, AVLTreeNode.balanceFactor] == (ite(callHeap#_893[this#310, AVLTreeNode.left] == null, 0, callHeap#_893[callHeap#_893[this#310, AVLTreeNode.left], AVLTreeNode.height]) - ite(callHeap#_893[this#310, AVLTreeNode.right] == null, 0, callHeap#_893[callHeap#_893[this#310, AVLTreeNode.right], AVLTreeNode.height]));
        assume IsGoodMask(Mask);
        assume wf(Heap, Mask, SecMask);
        // end inhale
      }
    }
  }
  // begin exhale (postcondition)
  exhaleMask#_917 := Mask;
  havoc exhaleHeap#_916;
  if (Seq#Equal(old(Heap)[this, AVLTreeNode.keys], Seq#Singleton(k#19))) {
    assert {:msg "  253.2: The postcondition at 259.11 might not hold. The expression at 259.30 might not evaluate to true."} r#20 == null;
  }
  if (!Seq#Equal(old(Heap)[this, AVLTreeNode.keys], Seq#Singleton(k#19))) {
    assert {:msg "  253.2: The postcondition at 260.11 might not hold. The expression at 260.30 might not evaluate to true."} !(r#20 == null);
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 267.11 might not hold. The expression at 267.25 might not evaluate to true."} !Seq#Contains(Heap[r#20, AVLTreeNode.keys], k#19);
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 268.11 might not hold. The expression at 268.25 might not evaluate to true."} (forall i#84#315: int :: (0 <= i#84#315) && (i#84#315 < Seq#Length(old(Heap)[this, AVLTreeNode.keys])) ==> (Seq#Contains(Heap[r#20, AVLTreeNode.keys], Seq#Index(old(Heap)[this, AVLTreeNode.keys], i#84#315)) || (Seq#Index(old(Heap)[this, AVLTreeNode.keys], i#84#315) == k#19)));
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 269.11 might not hold. The expression at 269.25 might not evaluate to true."} (forall i#85#316: int :: (0 <= i#85#316) && (i#85#316 < Seq#Length(Heap[r#20, AVLTreeNode.keys])) ==> Seq#Contains(old(Heap)[this, AVLTreeNode.keys], Seq#Index(Heap[r#20, AVLTreeNode.keys], i#85#316)) && (!(Seq#Index(Heap[r#20, AVLTreeNode.keys], i#85#316) == k#19)));
  }
  if (!Seq#Contains(old(Heap)[this, AVLTreeNode.keys], k#19)) {
    assert {:msg "  253.2: The postcondition at 270.11 might not hold. The expression at 270.34 might not evaluate to true."} !(r#20 == null);
  }
  if (!Seq#Contains(old(Heap)[this, AVLTreeNode.keys], k#19)) {
    assert {:msg "  253.2: The postcondition at 271.11 might not hold. The expression at 271.34 might not evaluate to true."} Seq#Equal(Heap[r#20, AVLTreeNode.keys], old(Heap)[this, AVLTreeNode.keys]);
  }
  if (!(r#20 == null)) {
    if (Seq#Contains(old(Heap)[this, AVLTreeNode.keys], k#19)) {
      assert {:msg "  253.2: The postcondition at 272.11 might not hold. The expression at 272.45 might not evaluate to true."} Seq#Length(Heap[r#20, AVLTreeNode.keys]) == (Seq#Length(old(Heap)[this, AVLTreeNode.keys]) - 1);
    }
  }
  if (old(Heap)[this, AVLTreeNode.height] > 1) {
    assert {:msg "  253.2: The postcondition at 274.11 might not hold. The expression at 274.29 might not evaluate to true."} !(r#20 == null);
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 275.11 might not hold. The expression at 275.25 might not evaluate to true."} (Heap[r#20, AVLTreeNode.height] == old(Heap)[this, AVLTreeNode.height]) || ((Heap[r#20, AVLTreeNode.height] + 1) == old(Heap)[this, AVLTreeNode.height]);
  }
  if (!Seq#Contains(old(Heap)[this, AVLTreeNode.keys], k#19)) {
    assert {:msg "  253.2: The postcondition at 276.11 might not hold. The expression at 276.33 might not evaluate to true."} Heap[r#20, AVLTreeNode.height] == old(Heap)[this, AVLTreeNode.height];
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 262.11 might not hold. The permission at 262.25 might not be positive."} Fractions(100) > 0;
    assert {:msg "  253.2: The postcondition at 262.11 might not hold. Insufficient fraction at 262.25 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_917[r#20, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_917[r#20, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_917[r#20, AVLTreeNode.valid][perm$N]));
    exhaleMask#_917[r#20, AVLTreeNode.valid] := exhaleMask#_917[r#20, AVLTreeNode.valid][perm$R := exhaleMask#_917[r#20, AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (!CanRead(exhaleMask#_917, SecMask, r#20, AVLTreeNode.valid)) {
      assume Heap[r#20, AVLTreeNode.valid] < exhaleHeap#_916[r#20, AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_917);
    assume wf(Heap, exhaleMask#_917, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 263.11 might not hold. The permission at 263.25 might not be positive."} Fractions(50) > 0;
    assert {:msg "  253.2: The postcondition at 263.11 might not hold. Insufficient fraction at 263.25 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_917[r#20, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_917[r#20, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_917[r#20, AVLTreeNode.keys][perm$N]));
    exhaleMask#_917[r#20, AVLTreeNode.keys] := exhaleMask#_917[r#20, AVLTreeNode.keys][perm$R := exhaleMask#_917[r#20, AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_917);
    assume wf(Heap, exhaleMask#_917, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 264.11 might not hold. The permission at 264.25 might not be positive."} Fractions(50) > 0;
    assert {:msg "  253.2: The postcondition at 264.11 might not hold. Insufficient fraction at 264.25 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_917[r#20, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_917[r#20, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_917[r#20, AVLTreeNode.height][perm$N]));
    exhaleMask#_917[r#20, AVLTreeNode.height] := exhaleMask#_917[r#20, AVLTreeNode.height][perm$R := exhaleMask#_917[r#20, AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_917);
    assume wf(Heap, exhaleMask#_917, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(r#20 == null)) {
    assert {:msg "  253.2: The postcondition at 265.11 might not hold. The permission at 265.25 might not be positive."} Fractions(50) > 0;
    assert {:msg "  253.2: The postcondition at 265.11 might not hold. Insufficient fraction at 265.25 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_917[r#20, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_917[r#20, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_917[r#20, AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_917[r#20, AVLTreeNode.balanceFactor] := exhaleMask#_917[r#20, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_917[r#20, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_917);
    assume wf(Heap, exhaleMask#_917, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(r#20 == null)) {
  }
  Mask := exhaleMask#_917;
  assume IsGoodExhaleState(exhaleHeap#_916, Heap, Mask, SecMask);
  Heap := exhaleHeap#_916;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  assert {:msg "  253.2: Method might lock/unlock more than allowed."} (forall lk#_922: ref :: {Heap[lk#_922, held]} {Heap[lk#_922, rdheld]} (((0 < Heap[lk#_922, held]) == (0 < old(Heap)[lk#_922, held])) && (Heap[lk#_922, rdheld] == old(Heap)[lk#_922, rdheld])) || false);
  assert {:msg "  253.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
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
procedure AVLTreeNode.rebalanceLR(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#71: ref where (r#71 == null) || (dtype(r#71) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
procedure AVLTreeNode.rebalanceLL(this: ref where (this == null) || (dtype(this) == AVLTreeNode#t)) returns (r#72: ref where (r#72 == null) || (dtype(r#72) == AVLTreeNode#t));
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
