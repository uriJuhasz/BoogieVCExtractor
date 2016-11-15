// Boogie program verifier version 2.3.0.61016, Copyright (c) 2003-2014, Microsoft.
// Command Line Options: /trace /traceTimes /print:BFS.BFS.bpl /printInlined BFS.bpl /proc:BreadthFirstSearch.BFS

const $$Language$Dafny: bool;

axiom $$Language$Dafny;

type ref;

const null: ref;

type Set T = [T]bool;

function Set#Empty<T>() : Set T;

axiom (forall<T> o: T :: { Set#Empty()[o] } !Set#Empty()[o]);

function Set#Singleton<T>(T) : Set T;

axiom (forall<T> r: T :: { Set#Singleton(r) } Set#Singleton(r)[r]);

axiom (forall<T> r: T, o: T :: 
  { Set#Singleton(r)[o] } 
  Set#Singleton(r)[o] <==> r == o);

function Set#UnionOne<T>(Set T, T) : Set T;

axiom (forall<T> a: Set T, x: T, o: T :: 
  { Set#UnionOne(a, x)[o] } 
  Set#UnionOne(a, x)[o] <==> o == x || a[o]);

axiom (forall<T> a: Set T, x: T :: { Set#UnionOne(a, x) } Set#UnionOne(a, x)[x]);

axiom (forall<T> a: Set T, x: T, y: T :: 
  { Set#UnionOne(a, x), a[y] } 
  a[y] ==> Set#UnionOne(a, x)[y]);

function Set#Union<T>(Set T, Set T) : Set T;

axiom (forall<T> a: Set T, b: Set T, o: T :: 
  { Set#Union(a, b)[o] } 
  Set#Union(a, b)[o] <==> a[o] || b[o]);

axiom (forall<T> a: Set T, b: Set T, y: T :: 
  { Set#Union(a, b), a[y] } 
  a[y] ==> Set#Union(a, b)[y]);

axiom (forall<T> a: Set T, b: Set T, y: T :: 
  { Set#Union(a, b), b[y] } 
  b[y] ==> Set#Union(a, b)[y]);

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Union(a, b) } 
  Set#Disjoint(a, b)
     ==> Set#Difference(Set#Union(a, b), a) == b
       && Set#Difference(Set#Union(a, b), b) == a);

function Set#Intersection<T>(Set T, Set T) : Set T;

axiom (forall<T> a: Set T, b: Set T, o: T :: 
  { Set#Intersection(a, b)[o] } 
  Set#Intersection(a, b)[o] <==> a[o] && b[o]);

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Union(Set#Union(a, b), b) } 
  Set#Union(Set#Union(a, b), b) == Set#Union(a, b));

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Union(a, Set#Union(a, b)) } 
  Set#Union(a, Set#Union(a, b)) == Set#Union(a, b));

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Intersection(Set#Intersection(a, b), b) } 
  Set#Intersection(Set#Intersection(a, b), b) == Set#Intersection(a, b));

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Intersection(a, Set#Intersection(a, b)) } 
  Set#Intersection(a, Set#Intersection(a, b)) == Set#Intersection(a, b));

function Set#Difference<T>(Set T, Set T) : Set T;

axiom (forall<T> a: Set T, b: Set T, o: T :: 
  { Set#Difference(a, b)[o] } 
  Set#Difference(a, b)[o] <==> a[o] && !b[o]);

axiom (forall<T> a: Set T, b: Set T, y: T :: 
  { Set#Difference(a, b), b[y] } 
  b[y] ==> !Set#Difference(a, b)[y]);

function Set#Subset<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Subset(a, b) } 
  Set#Subset(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] ==> b[o]));

function Set#Equal<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Equal(a, b) } 
  Set#Equal(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] <==> b[o]));

axiom (forall<T> a: Set T, b: Set T :: { Set#Equal(a, b) } Set#Equal(a, b) ==> a == b);

function Set#Disjoint<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: 
  { Set#Disjoint(a, b) } 
  Set#Disjoint(a, b) <==> (forall o: T :: { a[o] } { b[o] } !a[o] || !b[o]));

function Set#Choose<T>(Set T, TickType) : T;

axiom (forall<T> a: Set T, tick: TickType :: 
  { Set#Choose(a, tick) } 
  a != Set#Empty() ==> a[Set#Choose(a, tick)]);

function Math#min(a: int, b: int) : int;

axiom (forall a: int, b: int :: { Math#min(a, b) } a <= b <==> Math#min(a, b) == a);

axiom (forall a: int, b: int :: { Math#min(a, b) } b <= a <==> Math#min(a, b) == b);

axiom (forall a: int, b: int :: 
  { Math#min(a, b) } 
  Math#min(a, b) == a || Math#min(a, b) == b);

function Math#clip(a: int) : int;

axiom (forall a: int :: { Math#clip(a) } 0 <= a ==> Math#clip(a) == a);

axiom (forall a: int :: { Math#clip(a) } a < 0 ==> Math#clip(a) == 0);

type MultiSet T = [T]int;

function $IsGoodMultiSet<T>(ms: MultiSet T) : bool;

axiom (forall<T> ms: MultiSet T :: 
  { $IsGoodMultiSet(ms) } 
  $IsGoodMultiSet(ms) <==> (forall o: T :: { ms[o] } 0 <= ms[o]));

function MultiSet#Empty<T>() : MultiSet T;

axiom (forall<T> o: T :: { MultiSet#Empty()[o] } MultiSet#Empty()[o] == 0);

function MultiSet#Singleton<T>(T) : MultiSet T;

axiom (forall<T> r: T, o: T :: 
  { MultiSet#Singleton(r)[o] } 
  (MultiSet#Singleton(r)[o] == 1 <==> r == o)
     && (MultiSet#Singleton(r)[o] == 0 <==> r != o));

axiom (forall<T> r: T :: 
  { MultiSet#Singleton(r) } 
  MultiSet#Singleton(r) == MultiSet#UnionOne(MultiSet#Empty(), r));

function MultiSet#UnionOne<T>(MultiSet T, T) : MultiSet T;

axiom (forall<T> a: MultiSet T, x: T, o: T :: 
  { MultiSet#UnionOne(a, x)[o] } 
  0 < MultiSet#UnionOne(a, x)[o] <==> o == x || 0 < a[o]);

axiom (forall<T> a: MultiSet T, x: T :: 
  { MultiSet#UnionOne(a, x) } 
  MultiSet#UnionOne(a, x)[x] == a[x] + 1);

axiom (forall<T> a: MultiSet T, x: T, y: T :: 
  { MultiSet#UnionOne(a, x), a[y] } 
  0 < a[y] ==> 0 < MultiSet#UnionOne(a, x)[y]);

axiom (forall<T> a: MultiSet T, x: T, y: T :: 
  { MultiSet#UnionOne(a, x), a[y] } 
  x != y ==> a[y] == MultiSet#UnionOne(a, x)[y]);

function MultiSet#Union<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: 
  { MultiSet#Union(a, b)[o] } 
  MultiSet#Union(a, b)[o] == a[o] + b[o]);

axiom (forall<T> a: MultiSet T, b: MultiSet T, y: T :: 
  { MultiSet#Union(a, b), a[y] } 
  0 < a[y] ==> 0 < MultiSet#Union(a, b)[y]);

axiom (forall<T> a: MultiSet T, b: MultiSet T, y: T :: 
  { MultiSet#Union(a, b), b[y] } 
  0 < b[y] ==> 0 < MultiSet#Union(a, b)[y]);

axiom (forall<T> a: MultiSet T, b: MultiSet T :: 
  { MultiSet#Union(a, b) } 
  MultiSet#Difference(MultiSet#Union(a, b), a) == b
     && MultiSet#Difference(MultiSet#Union(a, b), b) == a);

function MultiSet#Intersection<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: 
  { MultiSet#Intersection(a, b)[o] } 
  MultiSet#Intersection(a, b)[o] == Math#min(a[o], b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: 
  { MultiSet#Intersection(MultiSet#Intersection(a, b), b) } 
  MultiSet#Intersection(MultiSet#Intersection(a, b), b)
     == MultiSet#Intersection(a, b));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: 
  { MultiSet#Intersection(a, MultiSet#Intersection(a, b)) } 
  MultiSet#Intersection(a, MultiSet#Intersection(a, b))
     == MultiSet#Intersection(a, b));

function MultiSet#Difference<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: 
  { MultiSet#Difference(a, b)[o] } 
  MultiSet#Difference(a, b)[o] == Math#clip(a[o] - b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T, y: T :: 
  { MultiSet#Difference(a, b), b[y], a[y] } 
  a[y] <= b[y] ==> MultiSet#Difference(a, b)[y] == 0);

function MultiSet#Subset<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: 
  { MultiSet#Subset(a, b) } 
  MultiSet#Subset(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] <= b[o]));

function MultiSet#Equal<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: 
  { MultiSet#Equal(a, b) } 
  MultiSet#Equal(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] == b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: 
  { MultiSet#Equal(a, b) } 
  MultiSet#Equal(a, b) ==> a == b);

function MultiSet#Disjoint<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: 
  { MultiSet#Disjoint(a, b) } 
  MultiSet#Disjoint(a, b)
     <==> (forall o: T :: { a[o] } { b[o] } a[o] == 0 || b[o] == 0));

function MultiSet#FromSet<T>(Set T) : MultiSet T;

axiom (forall<T> s: Set T, a: T :: 
  { MultiSet#FromSet(s)[a] } 
  (MultiSet#FromSet(s)[a] == 0 <==> !s[a])
     && (MultiSet#FromSet(s)[a] == 1 <==> s[a]));

function MultiSet#FromSeq<T>(Seq T) : MultiSet T;

axiom (forall<T> s: Seq T :: 
  { MultiSet#FromSeq(s) } 
  $IsGoodMultiSet(MultiSet#FromSeq(s)));

axiom (forall<T> s: Seq T, v: T :: 
  { MultiSet#FromSeq(Seq#Build(s, v)) } 
  MultiSet#FromSeq(Seq#Build(s, v)) == MultiSet#UnionOne(MultiSet#FromSeq(s), v));

axiom (forall<T>  :: 
  MultiSet#FromSeq(Seq#Empty(): Seq T) == MultiSet#Empty(): MultiSet T);

axiom (forall<T> a: Seq T, b: Seq T :: 
  { MultiSet#FromSeq(Seq#Append(a, b)) } 
  MultiSet#FromSeq(Seq#Append(a, b))
     == MultiSet#Union(MultiSet#FromSeq(a), MultiSet#FromSeq(b)));

axiom (forall<T> s: Seq T, i: int, v: T, x: T :: 
  { MultiSet#FromSeq(Seq#Update(s, i, v))[x] } 
  0 <= i && i < Seq#Length(s)
     ==> MultiSet#FromSeq(Seq#Update(s, i, v))[x]
       == MultiSet#Union(MultiSet#Difference(MultiSet#FromSeq(s), MultiSet#Singleton(Seq#Index(s, i))), 
        MultiSet#Singleton(v))[x]);

axiom (forall<T> s: Seq T, x: T :: 
  { MultiSet#FromSeq(s)[x] } 
  (exists i: int :: 
      { Seq#Index(s, i) } 
      0 <= i && i < Seq#Length(s) && x == Seq#Index(s, i))
     <==> 0 < MultiSet#FromSeq(s)[x]);

type Seq _;

function Seq#Length<T>(Seq T) : int;

axiom (forall<T> s: Seq T :: { Seq#Length(s) } 0 <= Seq#Length(s));

function Seq#Empty<T>() : Seq T;

axiom (forall<T>  :: Seq#Length(Seq#Empty(): Seq T) == 0);

axiom (forall<T> s: Seq T :: 
  { Seq#Length(s) } 
  Seq#Length(s) == 0 ==> s == Seq#Empty());

function Seq#Singleton<T>(T) : Seq T;

axiom (forall<T> t: T :: 
  { Seq#Length(Seq#Singleton(t)) } 
  Seq#Length(Seq#Singleton(t)) == 1);

function Seq#Build<T>(s: Seq T, val: T) : Seq T;

axiom (forall<T> s: Seq T, v: T :: 
  { Seq#Length(Seq#Build(s, v)) } 
  Seq#Length(Seq#Build(s, v)) == 1 + Seq#Length(s));

axiom (forall<T> s: Seq T, i: int, v: T :: 
  { Seq#Index(Seq#Build(s, v), i) } 
  (i == Seq#Length(s) ==> Seq#Index(Seq#Build(s, v), i) == v)
     && (i != Seq#Length(s) ==> Seq#Index(Seq#Build(s, v), i) == Seq#Index(s, i)));

function Seq#Append<T>(Seq T, Seq T) : Seq T;

axiom (forall<T> s0: Seq T, s1: Seq T :: 
  { Seq#Length(Seq#Append(s0, s1)) } 
  Seq#Length(Seq#Append(s0, s1)) == Seq#Length(s0) + Seq#Length(s1));

function Seq#Index<T>(Seq T, int) : T;

axiom (forall<T> t: T :: 
  { Seq#Index(Seq#Singleton(t), 0) } 
  Seq#Index(Seq#Singleton(t), 0) == t);

axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: 
  { Seq#Index(Seq#Append(s0, s1), n) } 
  (n < Seq#Length(s0) ==> Seq#Index(Seq#Append(s0, s1), n) == Seq#Index(s0, n))
     && (Seq#Length(s0) <= n
       ==> Seq#Index(Seq#Append(s0, s1), n) == Seq#Index(s1, n - Seq#Length(s0))));

function Seq#Update<T>(Seq T, int, T) : Seq T;

axiom (forall<T> s: Seq T, i: int, v: T :: 
  { Seq#Length(Seq#Update(s, i, v)) } 
  0 <= i && i < Seq#Length(s) ==> Seq#Length(Seq#Update(s, i, v)) == Seq#Length(s));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: 
  { Seq#Index(Seq#Update(s, i, v), n) } 
  0 <= n && n < Seq#Length(s)
     ==> (i == n ==> Seq#Index(Seq#Update(s, i, v), n) == v)
       && (i != n ==> Seq#Index(Seq#Update(s, i, v), n) == Seq#Index(s, n)));

function Seq#Contains<T>(Seq T, T) : bool;

axiom (forall<T> s: Seq T, x: T :: 
  { Seq#Contains(s, x) } 
  Seq#Contains(s, x)
     <==> (exists i: int :: 
      { Seq#Index(s, i) } 
      0 <= i && i < Seq#Length(s) && Seq#Index(s, i) == x));

axiom (forall x: ref :: 
  { Seq#Contains(Seq#Empty(), x) } 
  !Seq#Contains(Seq#Empty(), x));

axiom (forall<T> s0: Seq T, s1: Seq T, x: T :: 
  { Seq#Contains(Seq#Append(s0, s1), x) } 
  Seq#Contains(Seq#Append(s0, s1), x)
     <==> Seq#Contains(s0, x) || Seq#Contains(s1, x));

axiom (forall<T> s: Seq T, v: T, x: T :: 
  { Seq#Contains(Seq#Build(s, v), x) } 
  Seq#Contains(Seq#Build(s, v), x) <==> v == x || Seq#Contains(s, x));

axiom (forall<T> s: Seq T, n: int, x: T :: 
  { Seq#Contains(Seq#Take(s, n), x) } 
  Seq#Contains(Seq#Take(s, n), x)
     <==> (exists i: int :: 
      { Seq#Index(s, i) } 
      0 <= i && i < n && i < Seq#Length(s) && Seq#Index(s, i) == x));

axiom (forall<T> s: Seq T, n: int, x: T :: 
  { Seq#Contains(Seq#Drop(s, n), x) } 
  Seq#Contains(Seq#Drop(s, n), x)
     <==> (exists i: int :: 
      { Seq#Index(s, i) } 
      0 <= n && n <= i && i < Seq#Length(s) && Seq#Index(s, i) == x));

function Seq#Equal<T>(Seq T, Seq T) : bool;

axiom (forall<T> s0: Seq T, s1: Seq T :: 
  { Seq#Equal(s0, s1) } 
  Seq#Equal(s0, s1)
     <==> Seq#Length(s0) == Seq#Length(s1)
       && (forall j: int :: 
        { Seq#Index(s0, j) } { Seq#Index(s1, j) } 
        0 <= j && j < Seq#Length(s0) ==> Seq#Index(s0, j) == Seq#Index(s1, j)));

axiom (forall<T> a: Seq T, b: Seq T :: { Seq#Equal(a, b) } Seq#Equal(a, b) ==> a == b);

function Seq#SameUntil<T>(Seq T, Seq T, int) : bool;

axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: 
  { Seq#SameUntil(s0, s1, n) } 
  Seq#SameUntil(s0, s1, n)
     <==> (forall j: int :: 
      { Seq#Index(s0, j) } { Seq#Index(s1, j) } 
      0 <= j && j < n ==> Seq#Index(s0, j) == Seq#Index(s1, j)));

function Seq#Take<T>(s: Seq T, howMany: int) : Seq T;

axiom (forall<T> s: Seq T, n: int :: 
  { Seq#Length(Seq#Take(s, n)) } 
  0 <= n
     ==> (n <= Seq#Length(s) ==> Seq#Length(Seq#Take(s, n)) == n)
       && (Seq#Length(s) < n ==> Seq#Length(Seq#Take(s, n)) == Seq#Length(s)));

axiom (forall<T> s: Seq T, n: int, j: int :: 
  {:weight 25} { Seq#Index(Seq#Take(s, n), j) } 
  0 <= j && j < n && j < Seq#Length(s)
     ==> Seq#Index(Seq#Take(s, n), j) == Seq#Index(s, j));

function Seq#Drop<T>(s: Seq T, howMany: int) : Seq T;

axiom (forall<T> s: Seq T, n: int :: 
  { Seq#Length(Seq#Drop(s, n)) } 
  0 <= n
     ==> (n <= Seq#Length(s) ==> Seq#Length(Seq#Drop(s, n)) == Seq#Length(s) - n)
       && (Seq#Length(s) < n ==> Seq#Length(Seq#Drop(s, n)) == 0));

axiom (forall<T> s: Seq T, n: int, j: int :: 
  {:weight 25} { Seq#Index(Seq#Drop(s, n), j) } 
  0 <= n && 0 <= j && j < Seq#Length(s) - n
     ==> Seq#Index(Seq#Drop(s, n), j) == Seq#Index(s, j + n));

axiom (forall<T> s: Seq T, t: Seq T :: 
  { Seq#Append(s, t) } 
  Seq#Take(Seq#Append(s, t), Seq#Length(s)) == s
     && Seq#Drop(Seq#Append(s, t), Seq#Length(s)) == t);

function Seq#FromArray(h: HeapType, a: ref) : Seq BoxType;

axiom (forall h: HeapType, a: ref :: 
  { Seq#Length(Seq#FromArray(h, a)) } 
  Seq#Length(Seq#FromArray(h, a)) == array.Length(a));

axiom (forall h: HeapType, a: ref :: 
  { Seq#FromArray(h, a): Seq BoxType } 
  (forall i: int :: 
    0 <= i && i < Seq#Length(Seq#FromArray(h, a))
       ==> Seq#Index(Seq#FromArray(h, a), i) == read(h, a, IndexField(i))));

axiom (forall<alpha> h: HeapType, o: ref, f: Field alpha, v: alpha, a: ref :: 
  { Seq#FromArray(update(h, o, f, v), a) } 
  o != a ==> Seq#FromArray(update(h, o, f, v), a) == Seq#FromArray(h, a));

axiom (forall h: HeapType, i: int, v: BoxType, a: ref :: 
  { Seq#FromArray(update(h, a, IndexField(i), v), a) } 
  0 <= i && i < array.Length(a)
     ==> Seq#FromArray(update(h, a, IndexField(i), v), a)
       == Seq#Update(Seq#FromArray(h, a), i, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: 
  { Seq#Take(Seq#Update(s, i, v), n) } 
  0 <= i && i < n && n <= Seq#Length(s)
     ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Update(Seq#Take(s, n), i, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: 
  { Seq#Take(Seq#Update(s, i, v), n) } 
  n <= i && i < Seq#Length(s)
     ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Take(s, n));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: 
  { Seq#Drop(Seq#Update(s, i, v), n) } 
  0 <= n && n <= i && i < Seq#Length(s)
     ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Update(Seq#Drop(s, n), i - n, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: 
  { Seq#Drop(Seq#Update(s, i, v), n) } 
  0 <= i && i < n && n < Seq#Length(s)
     ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Drop(s, n));

axiom (forall h: HeapType, a: ref, n0: int, n1: int :: 
  { Seq#Take(Seq#FromArray(h, a), n0), Seq#Take(Seq#FromArray(h, a), n1) } 
  n0 + 1 == n1 && 0 <= n0 && n1 <= array.Length(a)
     ==> Seq#Take(Seq#FromArray(h, a), n1)
       == Seq#Build(Seq#Take(Seq#FromArray(h, a), n0), read(h, a, IndexField(n0): Field BoxType)));

axiom (forall<T> s: Seq T, v: T, n: int :: 
  { Seq#Drop(Seq#Build(s, v), n) } 
  0 <= n && n <= Seq#Length(s)
     ==> Seq#Drop(Seq#Build(s, v), n) == Seq#Build(Seq#Drop(s, n), v));

type BoxType;

function $Box<T>(T) : BoxType;

function $Unbox<T>(BoxType) : T;

axiom (forall<T> x: T :: { $Box(x) } $Unbox($Box(x)) == x);

axiom (forall b: BoxType :: { $Unbox(b): int } $Box($Unbox(b): int) == b);

axiom (forall b: BoxType :: { $Unbox(b): ref } $Box($Unbox(b): ref) == b);

axiom (forall b: BoxType :: 
  { $Unbox(b): Set BoxType } 
  $Box($Unbox(b): Set BoxType) == b);

axiom (forall b: BoxType :: 
  { $Unbox(b): Seq BoxType } 
  $Box($Unbox(b): Seq BoxType) == b);

axiom (forall b: BoxType :: 
  { $Unbox(b): DatatypeType } 
  $Box($Unbox(b): DatatypeType) == b);

function $IsCanonicalBoolBox(BoxType) : bool;

axiom $IsCanonicalBoolBox($Box(false)) && $IsCanonicalBoolBox($Box(true));

axiom (forall b: BoxType :: 
  { $Unbox(b): bool } 
  $IsCanonicalBoolBox(b) ==> $Box($Unbox(b): bool) == b);

type ClassName;

const unique class.int: ClassName;

const unique class.bool: ClassName;

const unique class.set: ClassName;

const unique class.seq: ClassName;

const unique class.multiset: ClassName;

function dtype(ref) : ClassName;

function TypeParams(ref, int) : ClassName;

function TypeTuple(a: ClassName, b: ClassName) : ClassName;

function TypeTupleCar(ClassName) : ClassName;

function TypeTupleCdr(ClassName) : ClassName;

axiom (forall a: ClassName, b: ClassName :: 
  { TypeTuple(a, b) } 
  TypeTupleCar(TypeTuple(a, b)) == a && TypeTupleCdr(TypeTuple(a, b)) == b);

type DatatypeType;

function DtType(DatatypeType) : ClassName;

function DtTypeParams(DatatypeType, int) : ClassName;

type DtCtorId;

function DatatypeCtorId(DatatypeType) : DtCtorId;

function DtRank(DatatypeType) : int;

const $ModuleContextHeight: int;

const $FunctionContextHeight: int;

const $InMethodContext: bool;

type Field _;

function FDim<T>(Field T) : int;

function IndexField(int) : Field BoxType;

axiom (forall i: int :: { IndexField(i) } FDim(IndexField(i)) == 1);

function IndexField_Inverse<T>(Field T) : int;

axiom (forall i: int :: { IndexField(i) } IndexField_Inverse(IndexField(i)) == i);

function MultiIndexField(Field BoxType, int) : Field BoxType;

axiom (forall f: Field BoxType, i: int :: 
  { MultiIndexField(f, i) } 
  FDim(MultiIndexField(f, i)) == FDim(f) + 1);

function MultiIndexField_Inverse0<T>(Field T) : Field T;

function MultiIndexField_Inverse1<T>(Field T) : int;

axiom (forall f: Field BoxType, i: int :: 
  { MultiIndexField(f, i) } 
  MultiIndexField_Inverse0(MultiIndexField(f, i)) == f
     && MultiIndexField_Inverse1(MultiIndexField(f, i)) == i);

function DeclType<T>(Field T) : ClassName;

const unique alloc: Field bool;

axiom FDim(alloc) == 0;

function DtAlloc(DatatypeType, HeapType) : bool;

axiom (forall h: HeapType, k: HeapType, d: DatatypeType :: 
  { $HeapSucc(h, k), DtAlloc(d, h) } { $HeapSucc(h, k), DtAlloc(d, k) } 
  $HeapSucc(h, k) ==> DtAlloc(d, h) ==> DtAlloc(d, k));

function GenericAlloc(BoxType, HeapType) : bool;

axiom (forall h: HeapType, k: HeapType, d: BoxType :: 
  { $HeapSucc(h, k), GenericAlloc(d, h) } { $HeapSucc(h, k), GenericAlloc(d, k) } 
  $HeapSucc(h, k) ==> GenericAlloc(d, h) ==> GenericAlloc(d, k));

axiom (forall b: BoxType, h: HeapType :: 
  { GenericAlloc(b, h), h[$Unbox(b): ref, alloc] } 
  GenericAlloc(b, h) ==> $Unbox(b): ref == null || h[$Unbox(b): ref, alloc]);

axiom (forall b: BoxType, h: HeapType, i: int :: 
  { GenericAlloc(b, h), Seq#Index($Unbox(b): Seq BoxType, i) } 
  GenericAlloc(b, h) && 0 <= i && i < Seq#Length($Unbox(b): Seq BoxType)
     ==> GenericAlloc(Seq#Index($Unbox(b): Seq BoxType, i), h));

axiom (forall b: BoxType, h: HeapType, t: BoxType :: 
  { GenericAlloc(b, h), ($Unbox(b): Set BoxType)[t] } 
  GenericAlloc(b, h) && ($Unbox(b): Set BoxType)[t] ==> GenericAlloc(t, h));

axiom (forall b: BoxType, h: HeapType :: 
  { GenericAlloc(b, h), DtType($Unbox(b): DatatypeType) } 
  GenericAlloc(b, h) ==> DtAlloc($Unbox(b): DatatypeType, h));

axiom (forall b: bool, h: HeapType :: $IsGoodHeap(h) ==> GenericAlloc($Box(b), h));

axiom (forall x: int, h: HeapType :: $IsGoodHeap(h) ==> GenericAlloc($Box(x), h));

axiom (forall r: ref, h: HeapType :: 
  { GenericAlloc($Box(r), h) } 
  $IsGoodHeap(h) && (r == null || h[r, alloc]) ==> GenericAlloc($Box(r), h));

function array.Length(a: ref) : int;

axiom (forall o: ref :: 0 <= array.Length(o));

procedure UpdateArrayRange(arr: ref, low: int, high: int, rhs: BoxType);
  modifies $Heap;
  ensures $HeapSucc(old($Heap), $Heap);
  ensures (forall i: int :: 
  { read($Heap, arr, IndexField(i)) } 
  low <= i && i < high ==> read($Heap, arr, IndexField(i)) == rhs);
  ensures (forall<alpha> o: ref, f: Field alpha :: 
  { read($Heap, o, f) } 
  read($Heap, o, f) == read(old($Heap), o, f)
     || (
      o == arr
       && FDim(f) == 1
       && low <= IndexField_Inverse(f)
       && IndexField_Inverse(f) < high));



type HeapType = <alpha>[ref,Field alpha]alpha;

function {:inline true} read<alpha>(H: HeapType, r: ref, f: Field alpha) : alpha
{
  H[r, f]
}

function {:inline true} update<alpha>(H: HeapType, r: ref, f: Field alpha, v: alpha) : HeapType
{
  H[r, f := v]
}

function $IsGoodHeap(HeapType) : bool;

var $Heap: HeapType where $IsGoodHeap($Heap);

function $HeapSucc(HeapType, HeapType) : bool;

axiom (forall<alpha> h: HeapType, r: ref, f: Field alpha, x: alpha :: 
  { update(h, r, f, x) } 
  $IsGoodHeap(update(h, r, f, x)) ==> $HeapSucc(h, update(h, r, f, x)));

axiom (forall a: HeapType, b: HeapType, c: HeapType :: 
  { $HeapSucc(a, b), $HeapSucc(b, c) } 
  $HeapSucc(a, b) && $HeapSucc(b, c) ==> $HeapSucc(a, c));

axiom (forall h: HeapType, k: HeapType :: 
  { $HeapSucc(h, k) } 
  $HeapSucc(h, k)
     ==> (forall o: ref :: { read(k, o, alloc) } read(h, o, alloc) ==> read(k, o, alloc)));

type TickType;

var $Tick: TickType;

axiom (forall x: int, y: int :: { x mod y } { x div y } x mod y == x - x div y * y);

axiom (forall x: int, y: int :: { x mod y } 0 < y ==> 0 <= x mod y && x mod y < y);

axiom (forall x: int, y: int :: { x mod y } y < 0 ==> 0 <= x mod y && x mod y < 0 - y);

axiom (forall a: int, b: int, d: int :: 
  { a mod d, b mod d } 
  2 <= d && a mod d == b mod d && a < b ==> a + d <= b);

const unique class.object: ClassName;

const unique class.array: ClassName;

const unique class.BreadthFirstSearch: ClassName;

function BreadthFirstSearch.Succ($heap: HeapType, this: ref, x#0: BoxType) : Set BoxType;

function BreadthFirstSearch.Succ#canCall($heap: HeapType, this: ref, x#0: BoxType) : bool;

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight && (0 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, x#0: BoxType :: 
    { BreadthFirstSearch.Succ($Heap, this, x#0) } 
    BreadthFirstSearch.Succ#canCall($Heap, this, x#0)
         || (
          (0 != $ModuleContextHeight || 0 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(x#0, $Heap))
       ==> (forall $t#0: BoxType :: 
        { BreadthFirstSearch.Succ($Heap, this, x#0)[$t#0] } 
        BreadthFirstSearch.Succ($Heap, this, x#0)[$t#0] ==> GenericAlloc($t#0, $Heap)));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, x#0: BoxType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.Succ($h1, this, x#0) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(x#0, $h0)
       && GenericAlloc(x#0, $h1)
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.Succ($h0, this, x#0)
       == BreadthFirstSearch.Succ($h1, this, x#0));

procedure CheckWellformed$$BreadthFirstSearch.Succ(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    x#0: BoxType where GenericAlloc(x#0, $Heap));
  free requires 0 == $ModuleContextHeight && 0 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.Succ(this: ref, x#0: BoxType)
{

  anon0:
    goto anon3_Then, anon3_Else;

  anon3_Then:
    return;

  anon3_Else:
    return;
}



function BreadthFirstSearch.IsPath($heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType)
   : bool;

function BreadthFirstSearch.IsPath#limited($heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType)
   : bool;

function BreadthFirstSearch.IsPath#2($heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType)
   : bool;

function BreadthFirstSearch.IsPath#canCall($heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType)
   : bool;

axiom (forall $Heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType :: 
  { BreadthFirstSearch.IsPath#2($Heap, this, source#1, dest#2, p#3) } 
  BreadthFirstSearch.IsPath#2($Heap, this, source#1, dest#2, p#3)
     == BreadthFirstSearch.IsPath($Heap, this, source#1, dest#2, p#3));

axiom (forall $Heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType :: 
  { BreadthFirstSearch.IsPath($Heap, this, source#1, dest#2, p#3) } 
  BreadthFirstSearch.IsPath($Heap, this, source#1, dest#2, p#3)
     == BreadthFirstSearch.IsPath#limited($Heap, this, source#1, dest#2, p#3));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight && (1 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType :: 
    { BreadthFirstSearch.IsPath($Heap, this, source#1, dest#2, p#3) } 
    BreadthFirstSearch.IsPath#canCall($Heap, this, source#1, dest#2, p#3)
         || (
          (0 != $ModuleContextHeight || 1 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#1, $Heap)
           && GenericAlloc(dest#2, $Heap)
           && (forall $i#1: int :: 
            { Seq#Index(p#3, $i#1) } 
            0 <= $i#1 && $i#1 < Seq#Length(p#3)
               ==> GenericAlloc(Seq#Index(p#3, $i#1), $Heap)))
       ==> (source#1 == dest#2 ==> true)
         && (source#1 != dest#2
           ==> (!Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
               ==> BreadthFirstSearch.Succ#canCall($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1)))
             && (!Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
                 && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1))[dest#2]
               ==> BreadthFirstSearch.IsPath#canCall($Heap, 
                this, 
                source#1, 
                Seq#Index(p#3, Seq#Length(p#3) - 1), 
                Seq#Take(p#3, Seq#Length(p#3) - 1))))
         && BreadthFirstSearch.IsPath($Heap, this, source#1, dest#2, p#3)
           == (if source#1 == dest#2
             then Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
             else !Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
               && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1))[dest#2]
               && BreadthFirstSearch.IsPath#limited($Heap, 
                this, 
                source#1, 
                Seq#Index(p#3, Seq#Length(p#3) - 1), 
                Seq#Take(p#3, Seq#Length(p#3) - 1))));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight && (1 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType :: 
    { BreadthFirstSearch.IsPath#2($Heap, this, source#1, dest#2, p#3) } 
    BreadthFirstSearch.IsPath#canCall($Heap, this, source#1, dest#2, p#3)
         || (
          (0 != $ModuleContextHeight || 1 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#1, $Heap)
           && GenericAlloc(dest#2, $Heap)
           && (forall $i#2: int :: 
            { Seq#Index(p#3, $i#2) } 
            0 <= $i#2 && $i#2 < Seq#Length(p#3)
               ==> GenericAlloc(Seq#Index(p#3, $i#2), $Heap)))
       ==> BreadthFirstSearch.IsPath#2($Heap, this, source#1, dest#2, p#3)
         == (if source#1 == dest#2
           then Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
           else !Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
             && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1))[dest#2]
             && BreadthFirstSearch.IsPath($Heap, 
              this, 
              source#1, 
              Seq#Index(p#3, Seq#Length(p#3) - 1), 
              Seq#Take(p#3, Seq#Length(p#3) - 1))));

axiom (forall $h0: HeapType, 
    $h1: HeapType, 
    this: ref, 
    source#1: BoxType, 
    dest#2: BoxType, 
    p#3: Seq BoxType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.IsPath($h1, this, source#1, dest#2, p#3) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#1, $h0)
       && GenericAlloc(source#1, $h1)
       && GenericAlloc(dest#2, $h0)
       && GenericAlloc(dest#2, $h1)
       && (forall $i#3: int :: 
        { Seq#Index(p#3, $i#3) } 
        0 <= $i#3 && $i#3 < Seq#Length(p#3) ==> GenericAlloc(Seq#Index(p#3, $i#3), $h0))
       && (forall $i#4: int :: 
        { Seq#Index(p#3, $i#4) } 
        0 <= $i#4 && $i#4 < Seq#Length(p#3) ==> GenericAlloc(Seq#Index(p#3, $i#4), $h1))
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.IsPath($h0, this, source#1, dest#2, p#3)
       == BreadthFirstSearch.IsPath($h1, this, source#1, dest#2, p#3));

axiom (forall $h0: HeapType, 
    $h1: HeapType, 
    this: ref, 
    source#1: BoxType, 
    dest#2: BoxType, 
    p#3: Seq BoxType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.IsPath#limited($h1, this, source#1, dest#2, p#3) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#1, $h0)
       && GenericAlloc(source#1, $h1)
       && GenericAlloc(dest#2, $h0)
       && GenericAlloc(dest#2, $h1)
       && (forall $i#3: int :: 
        { Seq#Index(p#3, $i#3) } 
        0 <= $i#3 && $i#3 < Seq#Length(p#3) ==> GenericAlloc(Seq#Index(p#3, $i#3), $h0))
       && (forall $i#4: int :: 
        { Seq#Index(p#3, $i#4) } 
        0 <= $i#4 && $i#4 < Seq#Length(p#3) ==> GenericAlloc(Seq#Index(p#3, $i#4), $h1))
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.IsPath#limited($h0, this, source#1, dest#2, p#3)
       == BreadthFirstSearch.IsPath#limited($h1, this, source#1, dest#2, p#3));

procedure CheckWellformed$$BreadthFirstSearch.IsPath(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#1: BoxType where GenericAlloc(source#1, $Heap), 
    dest#2: BoxType where GenericAlloc(dest#2, $Heap), 
    p#3: Seq BoxType
       where (forall $i#5: int :: 
        { Seq#Index(p#3, $i#5) } 
        0 <= $i#5 && $i#5 < Seq#Length(p#3)
           ==> GenericAlloc(Seq#Index(p#3, $i#5), $Heap)));
  free requires 0 == $ModuleContextHeight && 1 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.IsPath(this: ref, source#1: BoxType, dest#2: BoxType, p#3: Seq BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var x#90: BoxType;
  var source#91: BoxType;
  var dest#92: BoxType;
  var p#93: Seq BoxType;

  anon0:
    goto anon9_Then, anon9_Else;

  anon9_Then:
    return;

  anon9_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} source#1 == dest#2;
    goto anon8;

  anon10_Else:
    assume {:partition} source#1 != dest#2;
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} !Seq#Equal(p#3, Seq#Empty(): Seq BoxType);
    assert 0 <= Seq#Length(p#3) - 1 && Seq#Length(p#3) - 1 < Seq#Length(p#3);
    x#90 := Seq#Index(p#3, Seq#Length(p#3) - 1);
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assume BreadthFirstSearch.Succ#canCall($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1));
    goto anon6;

  anon11_Else:
    assume {:partition} Seq#Equal(p#3, Seq#Empty(): Seq BoxType);
    goto anon6;

  anon6:
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} !Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
   && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1))[dest#2];
    assert 0 <= Seq#Length(p#3) - 1 && Seq#Length(p#3) - 1 < Seq#Length(p#3);
    assert 0 <= Seq#Length(p#3) - 1 && Seq#Length(p#3) - 1 <= Seq#Length(p#3);
    source#91 := source#1;
    dest#92 := Seq#Index(p#3, Seq#Length(p#3) - 1);
    p#93 := Seq#Take(p#3, Seq#Length(p#3) - 1);
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert Seq#Length(p#93) < Seq#Length(p#3);
    assume BreadthFirstSearch.IsPath#canCall($Heap, 
  this, 
  source#1, 
  Seq#Index(p#3, Seq#Length(p#3) - 1), 
  Seq#Take(p#3, Seq#Length(p#3) - 1));
    goto anon8;

  anon12_Else:
    assume {:partition} !(!Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
   && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1))[dest#2]);
    goto anon8;

  anon8:
    assume BreadthFirstSearch.IsPath($Heap, this, source#1, dest#2, p#3)
   == (if source#1 == dest#2
     then Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
     else !Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
       && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1))[dest#2]
       && BreadthFirstSearch.IsPath($Heap, 
        this, 
        source#1, 
        Seq#Index(p#3, Seq#Length(p#3) - 1), 
        Seq#Take(p#3, Seq#Length(p#3) - 1)));
    assume (source#1 == dest#2 ==> true)
   && (source#1 != dest#2
     ==> (!Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
         ==> BreadthFirstSearch.Succ#canCall($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1)))
       && (!Seq#Equal(p#3, Seq#Empty(): Seq BoxType)
           && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#3, Seq#Length(p#3) - 1))[dest#2]
         ==> BreadthFirstSearch.IsPath#canCall($Heap, 
          this, 
          source#1, 
          Seq#Index(p#3, Seq#Length(p#3) - 1), 
          Seq#Take(p#3, Seq#Length(p#3) - 1))));
    return;
}



function BreadthFirstSearch.IsClosed($heap: HeapType, this: ref, S#4: Set BoxType) : bool;

function BreadthFirstSearch.IsClosed#canCall($heap: HeapType, this: ref, S#4: Set BoxType) : bool;

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight && (2 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, S#4: Set BoxType :: 
    { BreadthFirstSearch.IsClosed($Heap, this, S#4) } 
    BreadthFirstSearch.IsClosed#canCall($Heap, this, S#4)
         || (
          (0 != $ModuleContextHeight || 2 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && (forall $t#6: BoxType :: { S#4[$t#6] } S#4[$t#6] ==> GenericAlloc($t#6, $Heap)))
       ==> (forall v#5: BoxType :: 
          GenericAlloc(v#5, $Heap)
             ==> 
            S#4[v#5]
             ==> BreadthFirstSearch.Succ#canCall($Heap, this, v#5))
         && BreadthFirstSearch.IsClosed($Heap, this, S#4)
           == (forall v#5: BoxType :: 
            GenericAlloc(v#5, $Heap)
               ==> 
              S#4[v#5]
               ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), S#4)));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, S#4: Set BoxType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.IsClosed($h1, this, S#4) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && (forall $t#7: BoxType :: { S#4[$t#7] } S#4[$t#7] ==> GenericAlloc($t#7, $h0))
       && (forall $t#8: BoxType :: { S#4[$t#8] } S#4[$t#8] ==> GenericAlloc($t#8, $h1))
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.IsClosed($h0, this, S#4)
       == BreadthFirstSearch.IsClosed($h1, this, S#4));

procedure CheckWellformed$$BreadthFirstSearch.IsClosed(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    S#4: Set BoxType
       where (forall $t#9: BoxType :: { S#4[$t#9] } S#4[$t#9] ==> GenericAlloc($t#9, $Heap)));
  free requires 0 == $ModuleContextHeight && 2 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.IsClosed(this: ref, S#4: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var v#94: BoxType;
  var x#95: BoxType;

  anon0:
    goto anon5_Then, anon5_Else;

  anon5_Then:
    return;

  anon5_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    havoc v#94;
    assume GenericAlloc(v#94, $Heap);
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} S#4[v#94];
    x#95 := v#94;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assume BreadthFirstSearch.Succ#canCall($Heap, this, v#94);
    goto anon4;

  anon6_Else:
    assume {:partition} !S#4[v#94];
    goto anon4;

  anon4:
    assume BreadthFirstSearch.IsClosed($Heap, this, S#4)
   == (forall v#5: BoxType :: 
    GenericAlloc(v#5, $Heap)
       ==> 
      S#4[v#5]
       ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), S#4));
    assume (forall v#5: BoxType :: 
  GenericAlloc(v#5, $Heap)
     ==> 
    S#4[v#5]
     ==> BreadthFirstSearch.Succ#canCall($Heap, this, v#5));
    return;
}



procedure CheckWellformed$$BreadthFirstSearch.BFS(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#6: BoxType where GenericAlloc(source#6, $Heap), 
    dest#7: BoxType where GenericAlloc(dest#7, $Heap), 
    AllVertices#8: Set BoxType
       where (forall $t#10: BoxType :: 
        { AllVertices#8[$t#10] } 
        AllVertices#8[$t#10] ==> GenericAlloc($t#10, $Heap)))
   returns (d#9: int, 
    path#10: Seq BoxType
       where (forall $i#11: int :: 
        { Seq#Index(path#10, $i#11) } 
        0 <= $i#11 && $i#11 < Seq#Length(path#10)
           ==> GenericAlloc(Seq#Index(path#10, $i#11), $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$BreadthFirstSearch.BFS(this: ref, source#6: BoxType, dest#7: BoxType, AllVertices#8: Set BoxType)
   returns (d#9: int, path#10: Seq BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#96: Set BoxType;
  var source#97: BoxType;
  var dest#98: BoxType;
  var p#99: Seq BoxType;
  var p#100: Seq BoxType;
  var source#101: BoxType;
  var dest#102: BoxType;
  var p#103: Seq BoxType;
  var p#104: Seq BoxType;
  var source#105: BoxType;
  var dest#106: BoxType;
  var p#107: Seq BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} AllVertices#8[source#6];
    goto anon2;

  anon11_Else:
    assume {:partition} !AllVertices#8[source#6];
    goto anon2;

  anon2:
    assume AllVertices#8[source#6] && AllVertices#8[dest#7];
    S#96 := AllVertices#8;
    assume BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#8);
    assume BreadthFirstSearch.IsClosed($Heap, this, AllVertices#8);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    havoc d#9, path#10;
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} 0 <= d#9;
    source#97 := source#6;
    dest#98 := dest#7;
    p#99 := path#10;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, path#10);
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, path#10);
    goto anon5;

  anon13_Else:
    assume {:partition} !BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, path#10);
    goto anon5;

  anon12_Else:
    assume {:partition} d#9 < 0;
    goto anon5;

  anon5:
    assume 0 <= d#9
   ==> BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, path#10)
     && Seq#Length(path#10) == d#9;
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} 0 <= d#9;
    havoc p#100;
    assume (forall $i#12: int :: 
  { Seq#Index(p#100, $i#12) } 
  0 <= $i#12 && $i#12 < Seq#Length(p#100)
     ==> GenericAlloc(Seq#Index(p#100, $i#12), $Heap));
    source#101 := source#6;
    dest#102 := dest#7;
    p#103 := p#100;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#100);
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#100);
    goto anon8;

  anon15_Else:
    assume {:partition} !BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#100);
    goto anon8;

  anon14_Else:
    assume {:partition} d#9 < 0;
    goto anon8;

  anon8:
    assume 0 <= d#9
   ==> (forall p#11: Seq BoxType :: 
    (forall $i#13: int :: 
        { Seq#Index(p#11, $i#13) } 
        0 <= $i#13 && $i#13 < Seq#Length(p#11)
           ==> GenericAlloc(Seq#Index(p#11, $i#13), $Heap))
       ==> 
      BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#11)
       ==> Seq#Length(path#10) <= Seq#Length(p#11));
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} d#9 < 0;
    havoc p#104;
    assume (forall $i#14: int :: 
  { Seq#Index(p#104, $i#14) } 
  0 <= $i#14 && $i#14 < Seq#Length(p#104)
     ==> GenericAlloc(Seq#Index(p#104, $i#14), $Heap));
    source#105 := source#6;
    dest#106 := dest#7;
    p#107 := p#104;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#104);
    goto anon10;

  anon16_Else:
    assume {:partition} 0 <= d#9;
    goto anon10;

  anon10:
    assume d#9 < 0
   ==> !(exists p#12: Seq BoxType :: 
    (forall $i#15: int :: 
        { Seq#Index(p#12, $i#15) } 
        0 <= $i#15 && $i#15 < Seq#Length(p#12)
           ==> GenericAlloc(Seq#Index(p#12, $i#15), $Heap))
       && BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#12));
    return;
}



procedure BreadthFirstSearch.BFS(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#6: BoxType where GenericAlloc(source#6, $Heap), 
    dest#7: BoxType where GenericAlloc(dest#7, $Heap), 
    AllVertices#8: Set BoxType
       where (forall $t#0: BoxType :: 
        { AllVertices#8[$t#0] } 
        AllVertices#8[$t#0] ==> GenericAlloc($t#0, $Heap)))
   returns (d#9: int, 
    path#10: Seq BoxType
       where (forall $i#1: int :: 
        { Seq#Index(path#10, $i#1) } 
        0 <= $i#1 && $i#1 < Seq#Length(path#10)
           ==> GenericAlloc(Seq#Index(path#10, $i#1), $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires AllVertices#8[source#6];
  requires AllVertices#8[dest#7];
  free requires BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#8)
   && BreadthFirstSearch.IsClosed($Heap, this, AllVertices#8)
   && (forall v#5: BoxType :: 
    GenericAlloc(v#5, $Heap)
       ==> 
      AllVertices#8[v#5]
       ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), AllVertices#8));
  requires BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#8)
   ==> BreadthFirstSearch.IsClosed($Heap, this, AllVertices#8)
     || (forall v#5: BoxType :: 
      GenericAlloc(v#5, $Heap)
         ==> 
        AllVertices#8[v#5]
         ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), AllVertices#8));
  modifies $Heap, $Tick;
  free ensures 0 <= d#9
   ==> BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, path#10)
     && BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, path#10)
     && (if source#6 == dest#7
       then Seq#Equal(path#10, Seq#Empty(): Seq BoxType)
       else !Seq#Equal(path#10, Seq#Empty(): Seq BoxType)
         && BreadthFirstSearch.Succ($Heap, this, Seq#Index(path#10, Seq#Length(path#10) - 1))[dest#7]
         && BreadthFirstSearch.IsPath($Heap, 
          this, 
          source#6, 
          Seq#Index(path#10, Seq#Length(path#10) - 1), 
          Seq#Take(path#10, Seq#Length(path#10) - 1)));
  ensures 0 <= d#9
   ==> 
  BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, path#10)
   ==> BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, path#10)
     || (if source#6 == dest#7
       then Seq#Equal(path#10, Seq#Empty(): Seq BoxType)
       else !Seq#Equal(path#10, Seq#Empty(): Seq BoxType)
         && BreadthFirstSearch.Succ($Heap, this, Seq#Index(path#10, Seq#Length(path#10) - 1))[dest#7]
         && BreadthFirstSearch.IsPath($Heap, 
          this, 
          source#6, 
          Seq#Index(path#10, Seq#Length(path#10) - 1), 
          Seq#Take(path#10, Seq#Length(path#10) - 1)));
  ensures 0 <= d#9 ==> Seq#Length(path#10) == d#9;
  ensures 0 <= d#9
   ==> (forall p#11: Seq BoxType :: 
    (forall $i#4: int :: 
          { Seq#Index(p#11, $i#4) } 
          0 <= $i#4 && $i#4 < Seq#Length(p#11)
             ==> GenericAlloc(Seq#Index(p#11, $i#4), $Heap))
         && (forall p$ih#2#108: Seq BoxType :: 
          (forall $i#3: int :: 
              { Seq#Index(p$ih#2#108, $i#3) } 
              0 <= $i#3 && $i#3 < Seq#Length(p$ih#2#108)
                 ==> GenericAlloc(Seq#Index(p$ih#2#108, $i#3), $Heap))
             ==> 
            Seq#Length(p$ih#2#108) < Seq#Length(p#11)
             ==> 
            BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p$ih#2#108)
             ==> Seq#Length(path#10) <= Seq#Length(p$ih#2#108))
         && true
       ==> 
      BreadthFirstSearch.IsPath#2($Heap, this, source#6, dest#7, p#11)
       ==> Seq#Length(path#10) <= Seq#Length(p#11));
  free ensures 0 <= d#9
   ==> (forall p#11: Seq BoxType :: 
    (forall $i#5: int :: 
        { Seq#Index(p#11, $i#5) } 
        0 <= $i#5 && $i#5 < Seq#Length(p#11)
           ==> GenericAlloc(Seq#Index(p#11, $i#5), $Heap))
       ==> 
      BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#11)
       ==> Seq#Length(path#10) <= Seq#Length(p#11));
  ensures d#9 < 0
   ==> !(exists p#12: Seq BoxType :: 
    (forall $i#8: int :: 
        { Seq#Index(p#12, $i#8) } 
        0 <= $i#8 && $i#8 < Seq#Length(p#12)
           ==> GenericAlloc(Seq#Index(p#12, $i#8), $Heap))
       && (forall p$ih#6#109: Seq BoxType :: 
        (forall $i#7: int :: 
            { Seq#Index(p$ih#6#109, $i#7) } 
            0 <= $i#7 && $i#7 < Seq#Length(p$ih#6#109)
               ==> GenericAlloc(Seq#Index(p$ih#6#109, $i#7), $Heap))
           ==> 
          Seq#Length(p$ih#6#109) < Seq#Length(p#12)
           ==> !BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p$ih#6#109))
       && true
       && BreadthFirstSearch.IsPath#2($Heap, this, source#6, dest#7, p#12));
  free ensures d#9 < 0
   ==> !(exists p#12: Seq BoxType :: 
    (forall $i#9: int :: 
        { Seq#Index(p#12, $i#9) } 
        0 <= $i#9 && $i#9 < Seq#Length(p#12)
           ==> GenericAlloc(Seq#Index(p#12, $i#9), $Heap))
       && BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#12));
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  free ensures $HeapSucc(old($Heap), $Heap);



implementation BreadthFirstSearch.BFS(this: ref, source#6: BoxType, dest#7: BoxType, AllVertices#8: Set BoxType)
   returns (d#9: int, path#10: Seq BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var V#13: Set BoxType
   where (forall $t#10: BoxType :: 
    { V#13[$t#10] } 
    V#13[$t#10] ==> GenericAlloc($t#10, $Heap));
  var C#14: Set BoxType
   where (forall $t#11: BoxType :: 
    { C#14[$t#11] } 
    C#14[$t#11] ==> GenericAlloc($t#11, $Heap));
  var N#15: Set BoxType
   where (forall $t#12: BoxType :: 
    { N#15[$t#12] } 
    N#15[$t#12] ==> GenericAlloc($t#12, $Heap));
  var $rhs#13: Set BoxType;
  var $rhs#14: Set BoxType;
  var $rhs#15: Set BoxType;
  var Processed#16: Set BoxType
   where (forall $t#16: BoxType :: 
    { Processed#16[$t#16] } 
    Processed#16[$t#16] ==> GenericAlloc($t#16, $Heap));
  var paths#17: DatatypeType
   where DtAlloc(paths#17, $Heap) && DtType(paths#17) == class.Map;
  var $rhs#17: Set BoxType;
  var $rhs#18: DatatypeType;
  var dd#18: DatatypeType where DtAlloc(dd#18, $Heap) && DtType(dd#18) == class.Nat;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: Set BoxType;
  var $w0: bool;
  var source#110: BoxType;
  var m#111: DatatypeType;
  var m#112: DatatypeType;
  var x#113: BoxType;
  var source#114: BoxType;
  var x#115: BoxType;
  var m#116: DatatypeType;
  var x#117: BoxType;
  var source#118: BoxType;
  var x#119: BoxType;
  var m#120: DatatypeType;
  var source#121: BoxType;
  var nn#122: DatatypeType;
  var AllVertices#123: Set BoxType;
  var source#124: BoxType;
  var nn#125: DatatypeType;
  var AllVertices#126: Set BoxType;
  var source#127: BoxType;
  var nn#128: DatatypeType;
  var AllVertices#129: Set BoxType;
  var S#130: Set BoxType;
  var AllVertices#131: Set BoxType;
  var source#132: BoxType;
  var nn#133: DatatypeType;
  var AllVertices#134: Set BoxType;
  var nn#135: DatatypeType;
  var $decr0$0: Set BoxType;
  var v#21: BoxType where GenericAlloc(v#21, $Heap);
  var $rhs#19: Set BoxType;
  var $rhs#20: Set BoxType;
  var pathToV#22: Seq BoxType
   where (forall $i#21: int :: 
    { Seq#Index(pathToV#22, $i#21) } 
    0 <= $i#21 && $i#21 < Seq#Length(pathToV#22)
       ==> GenericAlloc(Seq#Index(pathToV#22, $i#21), $Heap));
  var source#136: BoxType;
  var x#137: BoxType;
  var m#138: DatatypeType;
  var p#23: Seq BoxType;
  var source#139: BoxType;
  var dest#140: BoxType;
  var p#141: Seq BoxType;
  var source#142: BoxType;
  var x#143: BoxType;
  var p#144: Seq BoxType;
  var AllVertices#145: Set BoxType;
  var n#146: int;
  var source#147: BoxType;
  var mm#148: DatatypeType;
  var n#149: int;
  var nn#150: DatatypeType;
  var AllVertices#151: Set BoxType;
  var source#153: BoxType;
  var dest#154: BoxType;
  var p#155: Seq BoxType;
  var p#152a: Seq BoxType;
  var $rhs#24: int;
  var $rhs#25: Seq BoxType;
  var newlyEncountered#24: Set BoxType
   where (forall $t#26: BoxType :: 
    { newlyEncountered#24[$t#26] } 
    newlyEncountered#24[$t#26] ==> GenericAlloc($t#26, $Heap));
  var w#156: BoxType;
  var x#157: BoxType;
  var $rhs#28: Set BoxType;
  var $rhs#29: Set BoxType;
  var $rhs#30: DatatypeType
   where DtAlloc($rhs#30, $Heap) && DtType($rhs#30) == class.Map;
  var vSuccs#158: Set BoxType;
  var source#159: BoxType;
  var paths#160: DatatypeType;
  var v#161: BoxType;
  var pathToV#162: Seq BoxType;
  var $rhs#31: Set BoxType;
  var $rhs#32: Set BoxType;
  var $rhs#33: int;
  var $rhs#34: DatatypeType;
  var nn#26: DatatypeType;
  var nn#163: DatatypeType;
  var nn#164: DatatypeType;
  var source#165: BoxType;
  var mm#166: DatatypeType;
  var nn#167: DatatypeType;
  var AllVertices#168: Set BoxType;
  var source#169: BoxType;
  var mm#170: DatatypeType;
  var nn#171: DatatypeType;
  var AllVertices#172: Set BoxType;
  var source#173: BoxType;
  var nn#174: DatatypeType;
  var AllVertices#175: Set BoxType;
  var p#27: Seq BoxType;
  var source#177: BoxType;
  var dest#178: BoxType;
  var p#179: Seq BoxType;
  var source#180: BoxType;
  var x#181: BoxType;
  var p#182: Seq BoxType;
  var AllVertices#183: Set BoxType;
  var source#185: BoxType;
  var dest#186: BoxType;
  var p#187: Seq BoxType;
  var p#184a: Seq BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    assume true;
    assume true;
    assume true;
    assume true;
    $rhs#13 := Set#UnionOne(Set#Empty(): Set BoxType, source#6);
    assume true;
    $rhs#14 := Set#UnionOne(Set#Empty(): Set BoxType, source#6);
    assume true;
    $rhs#15 := Set#Empty(): Set BoxType;
    V#13 := $rhs#13;
    C#14 := $rhs#14;
    N#15 := $rhs#15;
    assume {:captureState "BreadthFirstSearch.dfy(43,17)"} true;
    assume true;
    assume true;
    assume true;
    $rhs#17 := Set#Empty(): Set BoxType;
    assume true;
    $rhs#18 := #Map.Maplet(Set#UnionOne(Set#Empty(): Set BoxType, source#6), 
  source#6, 
  Seq#Empty(): Seq BoxType, 
  #Map.Empty());
    Processed#16 := $rhs#17;
    paths#17 := $rhs#18;
    assume {:captureState "BreadthFirstSearch.dfy(44,32)"} true;
    assume true;
    assume true;
    d#9 := 0;
    assume {:captureState "BreadthFirstSearch.dfy(51,7)"} true;
    assume true;
    assume true;
    dd#18 := #Nat.Zero();
    assume {:captureState "BreadthFirstSearch.dfy(52,12)"} true;
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := Set#Difference(AllVertices#8, Processed#16);
    havoc $w0;
    goto anon50_LoopHead;

  anon50_LoopHead:
    assume $w0
   ==> (Set#Subset(V#13, AllVertices#8) ==> true)
     && (Set#Subset(V#13, AllVertices#8) && Set#Subset(Processed#16, AllVertices#8)
       ==> true)
     && (Set#Subset(V#13, AllVertices#8)
         && Set#Subset(Processed#16, AllVertices#8)
         && Set#Subset(C#14, AllVertices#8)
       ==> true);
    assert $w0 ==> Set#Subset(V#13, AllVertices#8);
    assert $w0 ==> Set#Subset(Processed#16, AllVertices#8);
    assert $w0 ==> Set#Subset(C#14, AllVertices#8);
    assert $w0 ==> Set#Subset(N#15, AllVertices#8);
    assume $w0 ==> true;
    assert $w0 ==> V#13[source#6];
    assume $w0 ==> true;
    assert $w0 ==> Set#Equal(V#13, Set#Union(Set#Union(Processed#16, C#14), N#15));
    assume $w0 ==> Set#Disjoint(Processed#16, C#14) ==> true;
    assert $w0 ==> Set#Disjoint(Processed#16, C#14);
    assert $w0 ==> Set#Disjoint(Set#Union(Processed#16, C#14), N#15);
    assume $w0 ==> BreadthFirstSearch.ValidMap#canCall($Heap, this, source#6, paths#17);
    assert $w0 ==> BreadthFirstSearch.ValidMap#2($Heap, this, source#6, paths#17);
    assume $w0 ==> BreadthFirstSearch.Domain#canCall($Heap, this, paths#17);
    assert $w0 ==> Set#Equal(V#13, BreadthFirstSearch.Domain($Heap, this, paths#17));
    assume $w0
   ==> (forall x#19: BoxType :: 
    GenericAlloc(x#19, $Heap)
       ==> 
      C#14[x#19]
       ==> BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#19, paths#17));
    assert $w0
   ==> (forall x#19: BoxType :: 
    GenericAlloc(x#19, $Heap)
       ==> 
      C#14[x#19]
       ==> Seq#Length(BreadthFirstSearch.Find#2($Heap, this, source#6, x#19, paths#17))
         == d#9);
    assume $w0
   ==> (forall x#20: BoxType :: 
    GenericAlloc(x#20, $Heap)
       ==> 
      N#15[x#20]
       ==> BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#20, paths#17));
    assert $w0
   ==> (forall x#20: BoxType :: 
    GenericAlloc(x#20, $Heap)
       ==> 
      N#15[x#20]
       ==> Seq#Length(BreadthFirstSearch.Find#2($Heap, this, source#6, x#20, paths#17))
         == d#9 + 1);
    assume $w0
   ==> BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8)
     && (BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)[dest#7]
       ==> true);
    assert $w0
   ==> 
  BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)[dest#7]
   ==> C#14[dest#7];
    assume $w0
   ==> 
  d#9 != 0
   ==> BreadthFirstSearch.R#canCall($Heap, this, source#6, Nat.predecessor(dd#18), AllVertices#8);
    assert $w0
   ==> 
  d#9 != 0
   ==> !BreadthFirstSearch.R#2($Heap, this, source#6, Nat.predecessor(dd#18), AllVertices#8)[dest#7];
    assume $w0
   ==> BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assert $w0
   ==> Set#Equal(Set#Union(Processed#16, C#14), 
    BreadthFirstSearch.R#2($Heap, this, source#6, dd#18, AllVertices#8));
    assume $w0
   ==> BreadthFirstSearch.Successors#canCall($Heap, this, Processed#16, AllVertices#8)
     && BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assert $w0
   ==> Set#Equal(N#15, 
    Set#Difference(BreadthFirstSearch.Successors($Heap, this, Processed#16, AllVertices#8), 
      BreadthFirstSearch.R#2($Heap, this, source#6, dd#18, AllVertices#8)));
    assume $w0 ==> Set#Equal(C#14, Set#Empty(): Set BoxType) ==> true;
    assert $w0
   ==> 
  Set#Equal(C#14, Set#Empty(): Set BoxType)
   ==> Set#Equal(N#15, Set#Empty(): Set BoxType);
    assume $w0 ==> BreadthFirstSearch.Value#canCall($Heap, this, dd#18);
    assert $w0 ==> BreadthFirstSearch.Value#2($Heap, this, dd#18) == d#9;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f));
    assume $HeapSucc($PreLoopHeap0, $Heap);
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read($PreLoopHeap0, $o, alloc)
     ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
    assume Set#Subset(Set#Difference(AllVertices#8, Processed#16), $decr0$init$0)
   && (Set#Equal(Set#Difference(AllVertices#8, Processed#16), $decr0$init$0) ==> true);
    goto anon50_LoopDone, anon50_LoopBody;

  anon50_LoopBody:
    assume {:partition} true;
    goto anon51_Then, anon51_Else;

  anon51_Then:
    assume {:partition} !$w0;
    goto anon52_Then, anon52_Else;

  anon52_Then:
    assume {:partition} Set#Subset(V#13, AllVertices#8);
    goto anon4;

  anon52_Else:
    assume {:partition} !Set#Subset(V#13, AllVertices#8);
    goto anon4;

  anon4:
    goto anon53_Then, anon53_Else;

  anon53_Then:
    assume {:partition} Set#Subset(V#13, AllVertices#8) && Set#Subset(Processed#16, AllVertices#8);
    goto anon6;

  anon53_Else:
    assume {:partition} !(Set#Subset(V#13, AllVertices#8) && Set#Subset(Processed#16, AllVertices#8));
    goto anon6;

  anon6:
    goto anon54_Then, anon54_Else;

  anon54_Then:
    assume {:partition} Set#Subset(V#13, AllVertices#8)
   && Set#Subset(Processed#16, AllVertices#8)
   && Set#Subset(C#14, AllVertices#8);
    goto anon8;

  anon54_Else:
    assume {:partition} !(
  Set#Subset(V#13, AllVertices#8)
   && Set#Subset(Processed#16, AllVertices#8)
   && Set#Subset(C#14, AllVertices#8));
    goto anon8;

  anon8:
    assume (Set#Subset(V#13, AllVertices#8) ==> true)
   && (Set#Subset(V#13, AllVertices#8) && Set#Subset(Processed#16, AllVertices#8)
     ==> true)
   && (Set#Subset(V#13, AllVertices#8)
       && Set#Subset(Processed#16, AllVertices#8)
       && Set#Subset(C#14, AllVertices#8)
     ==> true);
    assume Set#Subset(V#13, AllVertices#8)
   && Set#Subset(Processed#16, AllVertices#8)
   && Set#Subset(C#14, AllVertices#8)
   && Set#Subset(N#15, AllVertices#8);
    assume true;
    assume V#13[source#6];
    assume true;
    assume Set#Equal(V#13, Set#Union(Set#Union(Processed#16, C#14), N#15));
    goto anon55_Then, anon55_Else;

  anon55_Then:
    assume {:partition} Set#Disjoint(Processed#16, C#14);
    goto anon10;

  anon55_Else:
    assume {:partition} !Set#Disjoint(Processed#16, C#14);
    goto anon10;

  anon10:
    assume Set#Disjoint(Processed#16, C#14) ==> true;
    assume Set#Disjoint(Processed#16, C#14)
   && Set#Disjoint(Set#Union(Processed#16, C#14), N#15);
    source#110 := source#6;
    m#111 := paths#17;
    assume BreadthFirstSearch.ValidMap#canCall($Heap, this, source#6, paths#17);
    assume BreadthFirstSearch.ValidMap#canCall($Heap, this, source#6, paths#17);
    assume BreadthFirstSearch.ValidMap($Heap, this, source#6, paths#17);
    m#112 := paths#17;
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#17);
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#17);
    assume Set#Equal(V#13, BreadthFirstSearch.Domain($Heap, this, paths#17));
    havoc x#113;
    assume GenericAlloc(x#113, $Heap);
    goto anon56_Then, anon56_Else;

  anon56_Then:
    assume {:partition} C#14[x#113];
    source#114 := source#6;
    x#115 := x#113;
    m#116 := paths#17;
    assert {:subsumption 0} BreadthFirstSearch.ValidMap($Heap, this, source#114, m#116)
   && BreadthFirstSearch.Domain($Heap, this, m#116)[x#115];
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#113, paths#17);
    goto anon12;

  anon56_Else:
    assume {:partition} !C#14[x#113];
    goto anon12;

  anon12:
    assume (forall x#19: BoxType :: 
  GenericAlloc(x#19, $Heap)
     ==> 
    C#14[x#19]
     ==> BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#19, paths#17));
    assume (forall x#19: BoxType :: 
  GenericAlloc(x#19, $Heap)
     ==> 
    C#14[x#19]
     ==> Seq#Length(BreadthFirstSearch.Find($Heap, this, source#6, x#19, paths#17))
       == d#9);
    havoc x#117;
    assume GenericAlloc(x#117, $Heap);
    goto anon57_Then, anon57_Else;

  anon57_Then:
    assume {:partition} N#15[x#117];
    source#118 := source#6;
    x#119 := x#117;
    m#120 := paths#17;
    assert {:subsumption 0} BreadthFirstSearch.ValidMap($Heap, this, source#118, m#120)
   && BreadthFirstSearch.Domain($Heap, this, m#120)[x#119];
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#117, paths#17);
    goto anon14;

  anon57_Else:
    assume {:partition} !N#15[x#117];
    goto anon14;

  anon14:
    assume (forall x#20: BoxType :: 
  GenericAlloc(x#20, $Heap)
     ==> 
    N#15[x#20]
     ==> BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#20, paths#17));
    assume (forall x#20: BoxType :: 
  GenericAlloc(x#20, $Heap)
     ==> 
    N#15[x#20]
     ==> Seq#Length(BreadthFirstSearch.Find($Heap, this, source#6, x#20, paths#17))
       == d#9 + 1);
    source#121 := source#6;
    nn#122 := dd#18;
    AllVertices#123 := AllVertices#8;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    goto anon58_Then, anon58_Else;

  anon58_Then:
    assume {:partition} BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)[dest#7];
    goto anon16;

  anon58_Else:
    assume {:partition} !BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)[dest#7];
    goto anon16;

  anon16:
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8)
   && (BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)[dest#7]
     ==> true);
    assume BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)[dest#7]
   ==> C#14[dest#7];
    goto anon59_Then, anon59_Else;

  anon59_Then:
    assume {:partition} d#9 != 0;
    source#124 := source#6;
    nn#125 := Nat.predecessor(dd#18);
    AllVertices#126 := AllVertices#8;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, Nat.predecessor(dd#18), AllVertices#8);
    goto anon18;

  anon59_Else:
    assume {:partition} d#9 == 0;
    goto anon18;

  anon18:
    assume d#9 != 0
   ==> BreadthFirstSearch.R#canCall($Heap, this, source#6, Nat.predecessor(dd#18), AllVertices#8);
    assume d#9 != 0
   ==> !BreadthFirstSearch.R($Heap, this, source#6, Nat.predecessor(dd#18), AllVertices#8)[dest#7];
    source#127 := source#6;
    nn#128 := dd#18;
    AllVertices#129 := AllVertices#8;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assume Set#Equal(Set#Union(Processed#16, C#14), 
  BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8));
    S#130 := Processed#16;
    AllVertices#131 := AllVertices#8;
    assume BreadthFirstSearch.Successors#canCall($Heap, this, Processed#16, AllVertices#8);
    source#132 := source#6;
    nn#133 := dd#18;
    AllVertices#134 := AllVertices#8;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assume BreadthFirstSearch.Successors#canCall($Heap, this, Processed#16, AllVertices#8)
   && BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assume Set#Equal(N#15, 
  Set#Difference(BreadthFirstSearch.Successors($Heap, this, Processed#16, AllVertices#8), 
    BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)));
    goto anon60_Then, anon60_Else;

  anon60_Then:
    assume {:partition} Set#Equal(C#14, Set#Empty(): Set BoxType);
    goto anon20;

  anon60_Else:
    assume {:partition} !Set#Equal(C#14, Set#Empty(): Set BoxType);
    goto anon20;

  anon20:
    assume Set#Equal(C#14, Set#Empty(): Set BoxType) ==> true;
    assume Set#Equal(C#14, Set#Empty(): Set BoxType)
   ==> Set#Equal(N#15, Set#Empty(): Set BoxType);
    nn#135 := dd#18;
    assume BreadthFirstSearch.Value#canCall($Heap, this, dd#18);
    assume BreadthFirstSearch.Value#canCall($Heap, this, dd#18);
    assume BreadthFirstSearch.Value($Heap, this, dd#18) == d#9;
    assume true;
    assume false;
    goto anon21;

  anon51_Else:
    assume {:partition} $w0;
    goto anon21;

  anon21:
    assume true;
    goto anon61_Then, anon61_Else;

  anon61_Then:
    assume {:partition} Set#Equal(C#14, Set#Empty(): Set BoxType);
    goto anon40;

  anon61_Else:
    assume {:partition} !Set#Equal(C#14, Set#Empty(): Set BoxType);
    goto anon23;

  anon23:
    assume {:captureState "BreadthFirstSearch.dfy(53,5): loop entered"} true;
    $decr0$0 := Set#Difference(AllVertices#8, Processed#16);
    assume true;
    assert C#14 != Set#Empty(): Set BoxType;
    assume true;
    v#21 := Set#Choose(C#14, $Tick);
    havoc $Tick;
    assume {:captureState "BreadthFirstSearch.dfy(83,13)"} true;
    assume true;
    assume true;
    assume true;
    $rhs#19 := Set#Difference(C#14, Set#UnionOne(Set#Empty(): Set BoxType, v#21));
    assume true;
    $rhs#20 := Set#Union(Processed#16, Set#UnionOne(Set#Empty(): Set BoxType, v#21));
    C#14 := $rhs#19;
    Processed#16 := $rhs#20;
    assume {:captureState "BreadthFirstSearch.dfy(84,20)"} true;
    assume true;
    source#136 := source#6;
    x#137 := v#21;
    m#138 := paths#17;
    assert BreadthFirstSearch.ValidMap($Heap, this, source#136, m#138)
   && BreadthFirstSearch.Domain($Heap, this, m#138)[x#137];
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#6, v#21, paths#17);
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#6, v#21, paths#17);
    pathToV#22 := BreadthFirstSearch.Find($Heap, this, source#6, v#21, paths#17);
    assume {:captureState "BreadthFirstSearch.dfy(85,25)"} true;
    assume true;
    goto anon62_Then, anon62_Else;

  anon62_Then:
    assume {:partition} v#21 == dest#7;
    goto anon63_Then, anon63_Else;

  anon63_Then:
    havoc p#23;
    assume (forall $i#22: int :: 
  { Seq#Index(p#23, $i#22) } 
  0 <= $i#22 && $i#22 < Seq#Length(p#23)
     ==> GenericAlloc(Seq#Index(p#23, $i#22), $Heap));
    source#139 := source#6;
    dest#140 := dest#7;
    p#141 := p#23;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#23);
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#23);
    assume BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#23);
    assume true;
    source#142 := source#6;
    assume true;
    x#143 := dest#7;
    assume true;
    p#144 := p#23;
    assume true;
    AllVertices#145 := AllVertices#8;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call BreadthFirstSearch.Lemma_IsPath_R(this, source#142, x#143, p#144, AllVertices#145);
    assume {:captureState "BreadthFirstSearch.dfy(91,11)"} true;
    assume true;
    goto anon64_Then, anon64_Else;

  anon64_Then:
    assume {:partition} Seq#Length(p#23) < Seq#Length(pathToV#22);
    assume true;
    assert 0 <= Seq#Length(p#23);
    n#146 := Seq#Length(p#23);
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call BreadthFirstSearch.ToNat_Value_Bijection(this, n#146);
    assume {:captureState "BreadthFirstSearch.dfy(94,13)"} true;
    assume true;
    source#147 := source#6;
    assert 0 <= Seq#Length(p#23);
    n#149 := Seq#Length(p#23);
    assume BreadthFirstSearch.ToNat#canCall($Heap, this, Seq#Length(p#23));
    assume BreadthFirstSearch.ToNat#canCall($Heap, this, Seq#Length(p#23));
    mm#148 := BreadthFirstSearch.ToNat($Heap, this, Seq#Length(p#23));
    assume true;
    nn#150 := Nat.predecessor(dd#18);
    assume true;
    AllVertices#151 := AllVertices#8;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call BreadthFirstSearch.RMonotonicity(this, source#147, mm#148, nn#150, AllVertices#151);
    assume {:captureState "BreadthFirstSearch.dfy(95,13)"} true;
    goto anon28;

  anon64_Else:
    assume {:partition} Seq#Length(pathToV#22) <= Seq#Length(p#23);
    goto anon28;

  anon28:
    assume true;
    assert Seq#Length(pathToV#22) <= Seq#Length(p#23);
    assume false;
    source#153 := source#6;
    dest#154 := dest#7;
    p#155 := p#152a;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#152a);
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#152a);
    goto anon30;

  anon63_Else:
    assume (forall p#152: Seq BoxType :: 
  (forall $i#23: int :: 
        { Seq#Index(p#152, $i#23) } 
        0 <= $i#23 && $i#23 < Seq#Length(p#152)
           ==> GenericAlloc(Seq#Index(p#152, $i#23), $Heap))
       && BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#152)
     ==> Seq#Length(pathToV#22) <= Seq#Length(p#152));
    goto anon30;

  anon30:
    assume {:captureState "BreadthFirstSearch.dfy(88,9)"} true;
    assume true;
    assume true;
    assume true;
    $rhs#24 := d#9;
    assume true;
    $rhs#25 := pathToV#22;
    d#9 := $rhs#24;
    path#10 := $rhs#25;
    assume {:captureState "BreadthFirstSearch.dfy(98,9)"} true;
    return;

  anon62_Else:
    assume {:partition} v#21 != dest#7;
    goto anon32;

  anon32:
    assume true;
    havoc w#156;
    assume GenericAlloc(w#156, $Heap);
    x#157 := v#21;
    assume BreadthFirstSearch.Succ#canCall($Heap, this, v#21);
    goto anon65_Then, anon65_Else;

  anon65_Then:
    assume {:partition} BreadthFirstSearch.Succ($Heap, this, v#21)[w#156];
    goto anon34;

  anon65_Else:
    assume {:partition} !BreadthFirstSearch.Succ($Heap, this, v#21)[w#156];
    goto anon34;

  anon34:
    goto anon66_Then, anon66_Else;

  anon66_Then:
    assume {:partition} BreadthFirstSearch.Succ($Heap, this, v#21)[w#156] && !V#13[w#156];
    goto anon36;

  anon66_Else:
    assume {:partition} !(BreadthFirstSearch.Succ($Heap, this, v#21)[w#156] && !V#13[w#156]);
    goto anon36;

  anon36:
    assume (forall w#25: BoxType :: 
  GenericAlloc(w#25, $Heap)
     ==> BreadthFirstSearch.Succ#canCall($Heap, this, v#21)
       && (BreadthFirstSearch.Succ($Heap, this, v#21)[w#25] ==> true));
    newlyEncountered#24 := (lambda $y#27: BoxType :: 
  (exists w#25: BoxType :: 
    GenericAlloc(w#25, $Heap)
       && BreadthFirstSearch.Succ($Heap, this, v#21)[w#25]
       && !V#13[w#25]
       && $y#27 == w#25));
    assume {:captureState "BreadthFirstSearch.dfy(102,28)"} true;
    assume true;
    assume true;
    assume true;
    $rhs#28 := Set#Union(V#13, newlyEncountered#24);
    assume true;
    $rhs#29 := Set#Union(N#15, newlyEncountered#24);
    V#13 := $rhs#28;
    N#15 := $rhs#29;
    assume {:captureState "BreadthFirstSearch.dfy(103,12)"} true;
    assume true;
    assume true;
    vSuccs#158 := newlyEncountered#24;
    assume true;
    source#159 := source#6;
    assume true;
    paths#160 := paths#17;
    assume true;
    v#161 := v#21;
    assume true;
    pathToV#162 := pathToV#22;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call $rhs#30 := BreadthFirstSearch.UpdatePaths(this, vSuccs#158, source#159, paths#160, v#161, pathToV#162);
    paths#17 := $rhs#30;
    assume {:captureState "BreadthFirstSearch.dfy(104,16)"} true;
    assume true;
    goto anon67_Then, anon67_Else;

  anon67_Then:
    assume {:partition} Set#Equal(C#14, Set#Empty(): Set BoxType);
    assume true;
    assume true;
    assume true;
    assume true;
    assume true;
    $rhs#31 := N#15;
    assume true;
    $rhs#32 := Set#Empty(): Set BoxType;
    assume true;
    $rhs#33 := d#9 + 1;
    assume true;
    $rhs#34 := #Nat.Suc(dd#18);
    C#14 := $rhs#31;
    N#15 := $rhs#32;
    d#9 := $rhs#33;
    dd#18 := $rhs#34;
    assume {:captureState "BreadthFirstSearch.dfy(107,21)"} true;
    goto anon39;

  anon67_Else:
    assume {:partition} !Set#Equal(C#14, Set#Empty(): Set BoxType);
    goto anon39;

  anon39:
    assert Set#Subset(Set#Difference(AllVertices#8, Processed#16), $decr0$0)
   && !Set#Subset($decr0$0, Set#Difference(AllVertices#8, Processed#16));
    assume (Set#Subset(V#13, AllVertices#8) ==> true)
   && (Set#Subset(V#13, AllVertices#8) && Set#Subset(Processed#16, AllVertices#8)
     ==> true)
   && (Set#Subset(V#13, AllVertices#8)
       && Set#Subset(Processed#16, AllVertices#8)
       && Set#Subset(C#14, AllVertices#8)
     ==> true);
    assume true;
    assume true;
    assume Set#Disjoint(Processed#16, C#14) ==> true;
    assume BreadthFirstSearch.ValidMap#canCall($Heap, this, source#6, paths#17);
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#17);
    assume (forall x#19: BoxType :: 
  GenericAlloc(x#19, $Heap)
     ==> 
    C#14[x#19]
     ==> BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#19, paths#17));
    assume (forall x#20: BoxType :: 
  GenericAlloc(x#20, $Heap)
     ==> 
    N#15[x#20]
     ==> BreadthFirstSearch.Find#canCall($Heap, this, source#6, x#20, paths#17));
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8)
   && (BreadthFirstSearch.R($Heap, this, source#6, dd#18, AllVertices#8)[dest#7]
     ==> true);
    assume d#9 != 0
   ==> BreadthFirstSearch.R#canCall($Heap, this, source#6, Nat.predecessor(dd#18), AllVertices#8);
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assume BreadthFirstSearch.Successors#canCall($Heap, this, Processed#16, AllVertices#8)
   && BreadthFirstSearch.R#canCall($Heap, this, source#6, dd#18, AllVertices#8);
    assume Set#Equal(C#14, Set#Empty(): Set BoxType) ==> true;
    assume BreadthFirstSearch.Value#canCall($Heap, this, dd#18);
    goto anon50_LoopHead;

  anon50_LoopDone:
    assume {:partition} !true;
    goto anon40;

  anon40:
    assume {:captureState "BreadthFirstSearch.dfy(53,5): loop exit"} true;
    goto anon68_Then, anon68_Else;

  anon68_Then:
    havoc nn#26;
    assume DtAlloc(nn#26, $Heap) && DtType(nn#26) == class.Nat;
    assume true;
    assume true;
    nn#163 := nn#26;
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#26);
    nn#164 := dd#18;
    assume BreadthFirstSearch.Value#canCall($Heap, this, dd#18);
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#26)
   && BreadthFirstSearch.Value#canCall($Heap, this, dd#18);
    goto anon69_Then, anon69_Else;

  anon69_Then:
    assume {:partition} BreadthFirstSearch.Value($Heap, this, nn#26)
   < BreadthFirstSearch.Value($Heap, this, dd#18);
    assume true;
    source#165 := source#6;
    assume true;
    mm#166 := nn#26;
    assume true;
    nn#167 := dd#18;
    assume true;
    AllVertices#168 := AllVertices#8;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call BreadthFirstSearch.RMonotonicity(this, source#165, mm#166, nn#167, AllVertices#168);
    assume {:captureState "BreadthFirstSearch.dfy(117,9)"} true;
    goto anon44;

  anon69_Else:
    assume {:partition} BreadthFirstSearch.Value($Heap, this, dd#18)
   <= BreadthFirstSearch.Value($Heap, this, nn#26);
    assume true;
    source#169 := source#6;
    assume true;
    mm#170 := dd#18;
    assume true;
    nn#171 := nn#26;
    assume true;
    AllVertices#172 := AllVertices#8;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call BreadthFirstSearch.IsReachFixpoint(this, source#169, mm#170, nn#171, AllVertices#172);
    assume {:captureState "BreadthFirstSearch.dfy(119,9)"} true;
    goto anon44;

  anon44:
    source#173 := source#6;
    nn#174 := nn#26;
    AllVertices#175 := AllVertices#8;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, nn#26, AllVertices#8);
    assume BreadthFirstSearch.R#canCall($Heap, this, source#6, nn#26, AllVertices#8);
    assert !BreadthFirstSearch.R#2($Heap, this, source#6, nn#26, AllVertices#8)[dest#7];
    assume false;
    assume true;
    goto anon46;

  anon68_Else:
    assume (forall nn#176: DatatypeType :: 
  DtAlloc(nn#176, $Heap) && DtType(nn#176) == class.Nat && true
     ==> !BreadthFirstSearch.R($Heap, this, source#6, nn#176, AllVertices#8)[dest#7]);
    goto anon46;

  anon46:
    assume {:captureState "BreadthFirstSearch.dfy(113,5)"} true;
    goto anon70_Then, anon70_Else;

  anon70_Then:
    havoc p#27;
    assume (forall $i#35: int :: 
  { Seq#Index(p#27, $i#35) } 
  0 <= $i#35 && $i#35 < Seq#Length(p#27)
     ==> GenericAlloc(Seq#Index(p#27, $i#35), $Heap));
    source#177 := source#6;
    dest#178 := dest#7;
    p#179 := p#27;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#27);
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#27);
    assume BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#27);
    assume true;
    source#180 := source#6;
    assume true;
    x#181 := dest#7;
    assume true;
    p#182 := p#27;
    assume true;
    AllVertices#183 := AllVertices#8;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call BreadthFirstSearch.Lemma_IsPath_R(this, source#180, x#181, p#182, AllVertices#183);
    assume {:captureState "BreadthFirstSearch.dfy(130,7)"} true;
    assume true;
    assert false;
    assume false;
    source#185 := source#6;
    dest#186 := dest#7;
    p#187 := p#184a;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#184a);
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#6, dest#7, p#184a);
    goto anon49;

  anon70_Else:
    assume (forall p#184: Seq BoxType :: 
  (forall $i#36: int :: 
        { Seq#Index(p#184, $i#36) } 
        0 <= $i#36 && $i#36 < Seq#Length(p#184)
           ==> GenericAlloc(Seq#Index(p#184, $i#36), $Heap))
       && BreadthFirstSearch.IsPath($Heap, this, source#6, dest#7, p#184)
     ==> false);
    goto anon49;

  anon49:
    assume {:captureState "BreadthFirstSearch.dfy(125,5)"} true;
    assume true;
    assume true;
    d#9 := 0 - 1;
    assume {:captureState "BreadthFirstSearch.dfy(136,7)"} true;
    return;
}



procedure CheckWellformed$$BreadthFirstSearch.Lemma_IsPath_Closure(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#28: BoxType where GenericAlloc(source#28, $Heap), 
    dest#29: BoxType where GenericAlloc(dest#29, $Heap), 
    p#30: Seq BoxType
       where (forall $i#0: int :: 
        { Seq#Index(p#30, $i#0) } 
        0 <= $i#0 && $i#0 < Seq#Length(p#30)
           ==> GenericAlloc(Seq#Index(p#30, $i#0), $Heap)), 
    AllVertices#31: Set BoxType
       where (forall $t#1: BoxType :: 
        { AllVertices#31[$t#1] } 
        AllVertices#31[$t#1] ==> GenericAlloc($t#1, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$BreadthFirstSearch.Lemma_IsPath_Closure(this: ref, 
    source#28: BoxType, 
    dest#29: BoxType, 
    p#30: Seq BoxType, 
    AllVertices#31: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var source#188: BoxType;
  var dest#189: BoxType;
  var p#190: Seq BoxType;
  var S#191: Set BoxType;
  var v#192: BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    source#188 := source#28;
    dest#189 := dest#29;
    p#190 := p#30;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#28, dest#29, p#30);
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} BreadthFirstSearch.IsPath($Heap, this, source#28, dest#29, p#30);
    goto anon2;

  anon8_Else:
    assume {:partition} !BreadthFirstSearch.IsPath($Heap, this, source#28, dest#29, p#30);
    goto anon2;

  anon2:
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} BreadthFirstSearch.IsPath($Heap, this, source#28, dest#29, p#30)
   && AllVertices#31[source#28];
    S#191 := AllVertices#31;
    assume BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#31);
    goto anon4;

  anon9_Else:
    assume {:partition} !(BreadthFirstSearch.IsPath($Heap, this, source#28, dest#29, p#30)
   && AllVertices#31[source#28]);
    goto anon4;

  anon4:
    assume BreadthFirstSearch.IsPath($Heap, this, source#28, dest#29, p#30)
   && AllVertices#31[source#28]
   && BreadthFirstSearch.IsClosed($Heap, this, AllVertices#31);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} AllVertices#31[dest#29];
    havoc v#192;
    assume GenericAlloc(v#192, $Heap);
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} Seq#Contains(p#30, v#192);
    goto anon7;

  anon11_Else:
    assume {:partition} !Seq#Contains(p#30, v#192);
    goto anon7;

  anon10_Else:
    assume {:partition} !AllVertices#31[dest#29];
    goto anon7;

  anon7:
    assume AllVertices#31[dest#29]
   && (forall v#32: BoxType :: 
    GenericAlloc(v#32, $Heap) ==> Seq#Contains(p#30, v#32) ==> AllVertices#31[v#32]);
    return;
}



procedure BreadthFirstSearch.Lemma_IsPath_Closure(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#28: BoxType where GenericAlloc(source#28, $Heap), 
    dest#29: BoxType where GenericAlloc(dest#29, $Heap), 
    p#30: Seq BoxType
       where (forall $i#0: int :: 
        { Seq#Index(p#30, $i#0) } 
        0 <= $i#0 && $i#0 < Seq#Length(p#30)
           ==> GenericAlloc(Seq#Index(p#30, $i#0), $Heap)), 
    AllVertices#31: Set BoxType
       where (forall $t#1: BoxType :: 
        { AllVertices#31[$t#1] } 
        AllVertices#31[$t#1] ==> GenericAlloc($t#1, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires BreadthFirstSearch.IsPath#canCall($Heap, this, source#28, dest#29, p#30)
   && BreadthFirstSearch.IsPath($Heap, this, source#28, dest#29, p#30)
   && (if source#28 == dest#29
     then Seq#Equal(p#30, Seq#Empty(): Seq BoxType)
     else !Seq#Equal(p#30, Seq#Empty(): Seq BoxType)
       && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#30, Seq#Length(p#30) - 1))[dest#29]
       && BreadthFirstSearch.IsPath($Heap, 
        this, 
        source#28, 
        Seq#Index(p#30, Seq#Length(p#30) - 1), 
        Seq#Take(p#30, Seq#Length(p#30) - 1)));
  requires BreadthFirstSearch.IsPath#canCall($Heap, this, source#28, dest#29, p#30)
   ==> BreadthFirstSearch.IsPath($Heap, this, source#28, dest#29, p#30)
     || (if source#28 == dest#29
       then Seq#Equal(p#30, Seq#Empty(): Seq BoxType)
       else !Seq#Equal(p#30, Seq#Empty(): Seq BoxType)
         && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#30, Seq#Length(p#30) - 1))[dest#29]
         && BreadthFirstSearch.IsPath($Heap, 
          this, 
          source#28, 
          Seq#Index(p#30, Seq#Length(p#30) - 1), 
          Seq#Take(p#30, Seq#Length(p#30) - 1)));
  requires AllVertices#31[source#28];
  free requires BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#31)
   && BreadthFirstSearch.IsClosed($Heap, this, AllVertices#31)
   && (forall v#5: BoxType :: 
    GenericAlloc(v#5, $Heap)
       ==> 
      AllVertices#31[v#5]
       ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), AllVertices#31));
  requires BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#31)
   ==> BreadthFirstSearch.IsClosed($Heap, this, AllVertices#31)
     || (forall v#5: BoxType :: 
      GenericAlloc(v#5, $Heap)
         ==> 
        AllVertices#31[v#5]
         ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), AllVertices#31));
  modifies $Heap, $Tick;
  ensures AllVertices#31[dest#29];
  ensures (forall v#32: BoxType :: 
  GenericAlloc(v#32, $Heap) ==> Seq#Contains(p#30, v#32) ==> AllVertices#31[v#32]);
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  free ensures $HeapSucc(old($Heap), $Heap);



implementation BreadthFirstSearch.Lemma_IsPath_Closure(this: ref, 
    source#28: BoxType, 
    dest#29: BoxType, 
    p#30: Seq BoxType, 
    AllVertices#31: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var last#33: int;
  var source#193: BoxType;
  var dest#194: BoxType;
  var p#195: Seq BoxType;
  var AllVertices#196: Set BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    assume true;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} !Seq#Equal(p#30, Seq#Empty(): Seq BoxType);
    assume true;
    assume true;
    last#33 := Seq#Length(p#30) - 1;
    assume {:captureState "BreadthFirstSearch.dfy(147,16)"} true;
    assume true;
    source#193 := source#28;
    assert 0 <= last#33 && last#33 < Seq#Length(p#30);
    assume true;
    dest#194 := Seq#Index(p#30, last#33);
    assert 0 <= last#33 && last#33 <= Seq#Length(p#30);
    assume true;
    p#195 := Seq#Take(p#30, last#33);
    assume true;
    AllVertices#196 := AllVertices#31;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert Seq#Length(p#195) < Seq#Length(p#30)
   || (
    Seq#Length(p#195) == Seq#Length(p#30)
     && Set#Subset(AllVertices#196, AllVertices#31)
     && !Set#Subset(AllVertices#31, AllVertices#196));
    call BreadthFirstSearch.Lemma_IsPath_Closure(this, source#193, dest#194, p#195, AllVertices#196);
    assume {:captureState "BreadthFirstSearch.dfy(148,7)"} true;
    return;

  anon3_Else:
    assume {:partition} Seq#Equal(p#30, Seq#Empty(): Seq BoxType);
    return;
}



function BreadthFirstSearch.Value($heap: HeapType, this: ref, nn#34: DatatypeType) : int;

function BreadthFirstSearch.Value#limited($heap: HeapType, this: ref, nn#34: DatatypeType) : int;

function BreadthFirstSearch.Value#2($heap: HeapType, this: ref, nn#34: DatatypeType) : int;

function BreadthFirstSearch.Value#canCall($heap: HeapType, this: ref, nn#34: DatatypeType) : bool;

axiom (forall $Heap: HeapType, this: ref, nn#34: DatatypeType :: 
  { BreadthFirstSearch.Value#2($Heap, this, nn#34) } 
  BreadthFirstSearch.Value#2($Heap, this, nn#34)
     == BreadthFirstSearch.Value($Heap, this, nn#34));

axiom (forall $Heap: HeapType, this: ref, nn#34: DatatypeType :: 
  { BreadthFirstSearch.Value($Heap, this, nn#34) } 
  BreadthFirstSearch.Value($Heap, this, nn#34)
     == BreadthFirstSearch.Value#limited($Heap, this, nn#34));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (11 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref :: 
    { BreadthFirstSearch.Value($Heap, this, #Nat.Zero()) } 
    BreadthFirstSearch.Value#canCall($Heap, this, #Nat.Zero())
         || (
          (0 != $ModuleContextHeight || 11 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch)
       ==> BreadthFirstSearch.Value($Heap, this, #Nat.Zero()) == 0
         && 0 <= BreadthFirstSearch.Value($Heap, this, #Nat.Zero()));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (11 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, mm#35: DatatypeType :: 
    { BreadthFirstSearch.Value($Heap, this, #Nat.Suc(mm#35)) } 
    BreadthFirstSearch.Value#canCall($Heap, this, #Nat.Suc(mm#35))
         || (
          (0 != $ModuleContextHeight || 11 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && DtAlloc(mm#35, $Heap)
           && DtType(mm#35) == class.Nat)
       ==> BreadthFirstSearch.Value#canCall($Heap, this, mm#35)
         && BreadthFirstSearch.Value($Heap, this, #Nat.Suc(mm#35))
           == BreadthFirstSearch.Value#limited($Heap, this, mm#35) + 1
         && 0 <= BreadthFirstSearch.Value($Heap, this, #Nat.Suc(mm#35)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (11 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, nn#34: DatatypeType :: 
    { BreadthFirstSearch.Value($Heap, this, nn#34) } 
    BreadthFirstSearch.Value#canCall($Heap, this, nn#34)
         || (
          (0 != $ModuleContextHeight || 11 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && DtAlloc(nn#34, $Heap)
           && DtType(nn#34) == class.Nat)
       ==> BreadthFirstSearch.ToNat($Heap, this, BreadthFirstSearch.Value#limited($Heap, this, nn#34))
           == nn#34
         && 0 <= BreadthFirstSearch.Value($Heap, this, nn#34));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (11 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref :: 
    { BreadthFirstSearch.Value#2($Heap, this, #Nat.Zero()) } 
    BreadthFirstSearch.Value#canCall($Heap, this, #Nat.Zero())
         || (
          (0 != $ModuleContextHeight || 11 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch)
       ==> BreadthFirstSearch.Value#2($Heap, this, #Nat.Zero()) == 0);

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (11 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, mm#35: DatatypeType :: 
    { BreadthFirstSearch.Value#2($Heap, this, #Nat.Suc(mm#35)) } 
    BreadthFirstSearch.Value#canCall($Heap, this, #Nat.Suc(mm#35))
         || (
          (0 != $ModuleContextHeight || 11 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && DtAlloc(mm#35, $Heap)
           && DtType(mm#35) == class.Nat)
       ==> BreadthFirstSearch.Value#2($Heap, this, #Nat.Suc(mm#35))
         == BreadthFirstSearch.Value($Heap, this, mm#35) + 1);

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (11 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, nn#34: DatatypeType :: 
    { BreadthFirstSearch.Value#2($Heap, this, nn#34) } 
    BreadthFirstSearch.Value#canCall($Heap, this, nn#34)
         || (
          (0 != $ModuleContextHeight || 11 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && DtAlloc(nn#34, $Heap)
           && DtType(nn#34) == class.Nat)
       ==> true);

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, nn#34: DatatypeType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.Value($h1, this, nn#34) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && DtAlloc(nn#34, $h0)
       && DtType(nn#34) == class.Nat
       && DtAlloc(nn#34, $h1)
       && DtType(nn#34) == class.Nat
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.Value($h0, this, nn#34)
       == BreadthFirstSearch.Value($h1, this, nn#34));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, nn#34: DatatypeType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.Value#limited($h1, this, nn#34) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && DtAlloc(nn#34, $h0)
       && DtType(nn#34) == class.Nat
       && DtAlloc(nn#34, $h1)
       && DtType(nn#34) == class.Nat
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.Value#limited($h0, this, nn#34)
       == BreadthFirstSearch.Value#limited($h1, this, nn#34));

procedure CheckWellformed$$BreadthFirstSearch.Value(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    nn#34: DatatypeType where DtAlloc(nn#34, $Heap) && DtType(nn#34) == class.Nat);
  free requires 0 == $ModuleContextHeight && 11 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.Value(this: ref, nn#34: DatatypeType)
{
  var nn#197: DatatypeType;
  var n#198: int;
  var $_Frame: <beta>[ref,Field beta]bool;
  var mm#35: DatatypeType;
  var nn#199: DatatypeType;

  anon0:
    goto anon7_Then, anon7_Else;

  anon7_Then:
    nn#197 := nn#34;
    assert (this == this && nn#34 == nn#34) || DtRank(nn#197) < DtRank(nn#34);
    assume (this == this && nn#34 == nn#34)
   || BreadthFirstSearch.Value#canCall($Heap, this, nn#34);
    assert 0 <= BreadthFirstSearch.Value($Heap, this, nn#34);
    n#198 := BreadthFirstSearch.Value($Heap, this, nn#34);
    assume BreadthFirstSearch.ToNat#canCall($Heap, this, BreadthFirstSearch.Value($Heap, this, nn#34));
    assume BreadthFirstSearch.ToNat($Heap, this, BreadthFirstSearch.Value($Heap, this, nn#34))
   == nn#34;
    return;

  anon7_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} nn#34 == #Nat.Zero();
    assert 0 <= 0;
    assume BreadthFirstSearch.Value($Heap, this, nn#34) == 0;
    assume true;
    goto anon6;

  anon8_Else:
    assume {:partition} nn#34 != #Nat.Zero();
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} nn#34 == #Nat.Suc(mm#35);
    assume DtAlloc(mm#35, $Heap) && DtType(mm#35) == class.Nat;
    nn#199 := mm#35;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert DtRank(nn#199) < DtRank(nn#34);
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#35);
    assert 0 <= BreadthFirstSearch.Value($Heap, this, mm#35) + 1;
    assume BreadthFirstSearch.Value($Heap, this, nn#34)
   == BreadthFirstSearch.Value($Heap, this, mm#35) + 1;
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#35);
    goto anon6;

  anon9_Else:
    assume {:partition} nn#34 != #Nat.Suc(mm#35);
    assume false;
    goto anon6;

  anon6:
    assert BreadthFirstSearch.ToNat#2($Heap, this, BreadthFirstSearch.Value#2($Heap, this, nn#34))
   == nn#34;
    return;
}



function BreadthFirstSearch.ToNat($heap: HeapType, this: ref, n#36: int) : DatatypeType;

function BreadthFirstSearch.ToNat#limited($heap: HeapType, this: ref, n#36: int) : DatatypeType;

function BreadthFirstSearch.ToNat#2($heap: HeapType, this: ref, n#36: int) : DatatypeType;

function BreadthFirstSearch.ToNat#canCall($heap: HeapType, this: ref, n#36: int) : bool;

axiom (forall $Heap: HeapType, this: ref, n#36: int :: 
  { BreadthFirstSearch.ToNat#2($Heap, this, n#36) } 
  BreadthFirstSearch.ToNat#2($Heap, this, n#36)
     == BreadthFirstSearch.ToNat($Heap, this, n#36));

axiom (forall $Heap: HeapType, this: ref, n#36: int :: 
  { BreadthFirstSearch.ToNat($Heap, this, n#36) } 
  BreadthFirstSearch.ToNat($Heap, this, n#36)
     == BreadthFirstSearch.ToNat#limited($Heap, this, n#36));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (10 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, n#36: int :: 
    { BreadthFirstSearch.ToNat($Heap, this, n#36) } 
    BreadthFirstSearch.ToNat#canCall($Heap, this, n#36)
         || (
          (0 != $ModuleContextHeight || 10 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && 0 <= n#36)
       ==> (n#36 == 0 ==> true)
         && (n#36 != 0 ==> BreadthFirstSearch.ToNat#canCall($Heap, this, n#36 - 1))
         && BreadthFirstSearch.ToNat($Heap, this, n#36)
           == (if n#36 == 0
             then #Nat.Zero()
             else #Nat.Suc(BreadthFirstSearch.ToNat#limited($Heap, this, n#36 - 1)))
         && DtAlloc(BreadthFirstSearch.ToNat($Heap, this, n#36), $Heap)
         && DtType(BreadthFirstSearch.ToNat($Heap, this, n#36)) == class.Nat);

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (10 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, n#36: int :: 
    { BreadthFirstSearch.ToNat#2($Heap, this, n#36) } 
    BreadthFirstSearch.ToNat#canCall($Heap, this, n#36)
         || (
          (0 != $ModuleContextHeight || 10 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && 0 <= n#36)
       ==> BreadthFirstSearch.ToNat#2($Heap, this, n#36)
         == (if n#36 == 0
           then #Nat.Zero()
           else #Nat.Suc(BreadthFirstSearch.ToNat($Heap, this, n#36 - 1))));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, n#36: int :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.ToNat($h1, this, n#36) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && 0 <= n#36
       && 0 <= n#36
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.ToNat($h0, this, n#36)
       == BreadthFirstSearch.ToNat($h1, this, n#36));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, n#36: int :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.ToNat#limited($h1, this, n#36) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && 0 <= n#36
       && 0 <= n#36
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.ToNat#limited($h0, this, n#36)
       == BreadthFirstSearch.ToNat#limited($h1, this, n#36));

procedure CheckWellformed$$BreadthFirstSearch.ToNat(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    n#36: int where 0 <= n#36);
  free requires 0 == $ModuleContextHeight && 10 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.ToNat(this: ref, n#36: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#200: int;

  anon0:
    goto anon6_Then, anon6_Else;

  anon6_Then:
    return;

  anon6_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} n#36 == 0;
    goto anon5;

  anon7_Else:
    assume {:partition} n#36 != 0;
    assert 0 <= n#36 - 1;
    n#200 := n#36 - 1;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert 0 <= n#36 || n#200 == n#36;
    assert n#200 < n#36;
    assume BreadthFirstSearch.ToNat#canCall($Heap, this, n#36 - 1);
    goto anon5;

  anon5:
    assume BreadthFirstSearch.ToNat($Heap, this, n#36)
   == (if n#36 == 0
     then #Nat.Zero()
     else #Nat.Suc(BreadthFirstSearch.ToNat($Heap, this, n#36 - 1)));
    assume (n#36 == 0 ==> true)
   && (n#36 != 0 ==> BreadthFirstSearch.ToNat#canCall($Heap, this, n#36 - 1));
    return;
}



procedure CheckWellformed$$BreadthFirstSearch.ToNat_Value_Bijection(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    n#37: int where 0 <= n#37);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$BreadthFirstSearch.ToNat_Value_Bijection(this: ref, n#37: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#201: int;
  var nn#202: DatatypeType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    assert 0 <= n#37;
    n#201 := n#37;
    assume BreadthFirstSearch.ToNat#canCall($Heap, this, n#37);
    nn#202 := BreadthFirstSearch.ToNat($Heap, this, n#37);
    assume BreadthFirstSearch.Value#canCall($Heap, this, BreadthFirstSearch.ToNat($Heap, this, n#37));
    assume BreadthFirstSearch.Value($Heap, this, BreadthFirstSearch.ToNat($Heap, this, n#37))
   == n#37;
    return;
}



procedure BreadthFirstSearch.ToNat_Value_Bijection(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    n#37: int where 0 <= n#37);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;
  ensures BreadthFirstSearch.Value#2($Heap, this, BreadthFirstSearch.ToNat#2($Heap, this, n#37))
   == n#37;
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  free ensures $HeapSucc(old($Heap), $Heap);



implementation BreadthFirstSearch.ToNat_Value_Bijection(this: ref, n#37: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    return;
}



function BreadthFirstSearch.R($heap: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType)
   : Set BoxType;

function BreadthFirstSearch.R#limited($heap: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType)
   : Set BoxType;

function BreadthFirstSearch.R#2($heap: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType)
   : Set BoxType;

function BreadthFirstSearch.R#canCall($heap: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType)
   : bool;

axiom (forall $Heap: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType :: 
  { BreadthFirstSearch.R#2($Heap, this, source#38, nn#39, AllVertices#40) } 
  BreadthFirstSearch.R#2($Heap, this, source#38, nn#39, AllVertices#40)
     == BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40));

axiom (forall $Heap: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType :: 
  { BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40) } 
  BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40)
     == BreadthFirstSearch.R#limited($Heap, this, source#38, nn#39, AllVertices#40));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (13 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#38: BoxType, AllVertices#40: Set BoxType :: 
    { BreadthFirstSearch.R($Heap, this, source#38, #Nat.Zero(), AllVertices#40) } 
    BreadthFirstSearch.R#canCall($Heap, this, source#38, #Nat.Zero(), AllVertices#40)
         || (
          (0 != $ModuleContextHeight || 13 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#38, $Heap)
           && (forall $t#0: BoxType :: 
            { AllVertices#40[$t#0] } 
            AllVertices#40[$t#0] ==> GenericAlloc($t#0, $Heap)))
       ==> BreadthFirstSearch.R($Heap, this, source#38, #Nat.Zero(), AllVertices#40)
           == Set#UnionOne(Set#Empty(): Set BoxType, source#38)
         && (forall $t#1: BoxType :: 
          { BreadthFirstSearch.R($Heap, this, source#38, #Nat.Zero(), AllVertices#40)[$t#1] } 
          BreadthFirstSearch.R($Heap, this, source#38, #Nat.Zero(), AllVertices#40)[$t#1]
             ==> GenericAlloc($t#1, $Heap)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (13 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      mm#41: DatatypeType, 
      source#38: BoxType, 
      AllVertices#40: Set BoxType :: 
    { BreadthFirstSearch.R($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40) } 
    BreadthFirstSearch.R#canCall($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40)
         || (
          (0 != $ModuleContextHeight || 13 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && DtAlloc(mm#41, $Heap)
           && DtType(mm#41) == class.Nat
           && GenericAlloc(source#38, $Heap)
           && (forall $t#2: BoxType :: 
            { AllVertices#40[$t#2] } 
            AllVertices#40[$t#2] ==> GenericAlloc($t#2, $Heap)))
       ==> BreadthFirstSearch.R#canCall($Heap, this, source#38, mm#41, AllVertices#40)
         && BreadthFirstSearch.R#canCall($Heap, this, source#38, mm#41, AllVertices#40)
         && BreadthFirstSearch.Successors#canCall($Heap, 
          this, 
          BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40), 
          AllVertices#40)
         && BreadthFirstSearch.R($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40)
           == Set#Union(BreadthFirstSearch.R#limited($Heap, this, source#38, mm#41, AllVertices#40), 
            BreadthFirstSearch.Successors($Heap, 
              this, 
              BreadthFirstSearch.R#limited($Heap, this, source#38, mm#41, AllVertices#40), 
              AllVertices#40))
         && (forall $t#3: BoxType :: 
          { BreadthFirstSearch.R($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40)[$t#3] } 
          BreadthFirstSearch.R($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40)[$t#3]
             ==> GenericAlloc($t#3, $Heap)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (13 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      source#38: BoxType, 
      nn#39: DatatypeType, 
      AllVertices#40: Set BoxType :: 
    { BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40) } 
    BreadthFirstSearch.R#canCall($Heap, this, source#38, nn#39, AllVertices#40)
         || (
          (0 != $ModuleContextHeight || 13 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#38, $Heap)
           && DtAlloc(nn#39, $Heap)
           && DtType(nn#39) == class.Nat
           && (forall $t#4: BoxType :: 
            { AllVertices#40[$t#4] } 
            AllVertices#40[$t#4] ==> GenericAlloc($t#4, $Heap)))
       ==> (forall $t#5: BoxType :: 
        { BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40)[$t#5] } 
        BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40)[$t#5]
           ==> GenericAlloc($t#5, $Heap)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (13 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#38: BoxType, AllVertices#40: Set BoxType :: 
    { BreadthFirstSearch.R#2($Heap, this, source#38, #Nat.Zero(), AllVertices#40) } 
    BreadthFirstSearch.R#canCall($Heap, this, source#38, #Nat.Zero(), AllVertices#40)
         || (
          (0 != $ModuleContextHeight || 13 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#38, $Heap)
           && (forall $t#6: BoxType :: 
            { AllVertices#40[$t#6] } 
            AllVertices#40[$t#6] ==> GenericAlloc($t#6, $Heap)))
       ==> BreadthFirstSearch.R#2($Heap, this, source#38, #Nat.Zero(), AllVertices#40)
         == Set#UnionOne(Set#Empty(): Set BoxType, source#38));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (13 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      mm#41: DatatypeType, 
      source#38: BoxType, 
      AllVertices#40: Set BoxType :: 
    { BreadthFirstSearch.R#2($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40) } 
    BreadthFirstSearch.R#canCall($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40)
         || (
          (0 != $ModuleContextHeight || 13 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && DtAlloc(mm#41, $Heap)
           && DtType(mm#41) == class.Nat
           && GenericAlloc(source#38, $Heap)
           && (forall $t#7: BoxType :: 
            { AllVertices#40[$t#7] } 
            AllVertices#40[$t#7] ==> GenericAlloc($t#7, $Heap)))
       ==> BreadthFirstSearch.R#2($Heap, this, source#38, #Nat.Suc(mm#41), AllVertices#40)
         == Set#Union(BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40), 
          BreadthFirstSearch.Successors($Heap, 
            this, 
            BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40), 
            AllVertices#40)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (13 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      source#38: BoxType, 
      nn#39: DatatypeType, 
      AllVertices#40: Set BoxType :: 
    { BreadthFirstSearch.R#2($Heap, this, source#38, nn#39, AllVertices#40) } 
    BreadthFirstSearch.R#canCall($Heap, this, source#38, nn#39, AllVertices#40)
         || (
          (0 != $ModuleContextHeight || 13 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#38, $Heap)
           && DtAlloc(nn#39, $Heap)
           && DtType(nn#39) == class.Nat
           && (forall $t#8: BoxType :: 
            { AllVertices#40[$t#8] } 
            AllVertices#40[$t#8] ==> GenericAlloc($t#8, $Heap)))
       ==> true);

axiom (forall $h0: HeapType, 
    $h1: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.R($h1, this, source#38, nn#39, AllVertices#40) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#38, $h0)
       && GenericAlloc(source#38, $h1)
       && DtAlloc(nn#39, $h0)
       && DtType(nn#39) == class.Nat
       && DtAlloc(nn#39, $h1)
       && DtType(nn#39) == class.Nat
       && (forall $t#9: BoxType :: 
        { AllVertices#40[$t#9] } 
        AllVertices#40[$t#9] ==> GenericAlloc($t#9, $h0))
       && (forall $t#10: BoxType :: 
        { AllVertices#40[$t#10] } 
        AllVertices#40[$t#10] ==> GenericAlloc($t#10, $h1))
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.R($h0, this, source#38, nn#39, AllVertices#40)
       == BreadthFirstSearch.R($h1, this, source#38, nn#39, AllVertices#40));

axiom (forall $h0: HeapType, 
    $h1: HeapType, 
    this: ref, 
    source#38: BoxType, 
    nn#39: DatatypeType, 
    AllVertices#40: Set BoxType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.R#limited($h1, this, source#38, nn#39, AllVertices#40) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#38, $h0)
       && GenericAlloc(source#38, $h1)
       && DtAlloc(nn#39, $h0)
       && DtType(nn#39) == class.Nat
       && DtAlloc(nn#39, $h1)
       && DtType(nn#39) == class.Nat
       && (forall $t#9: BoxType :: 
        { AllVertices#40[$t#9] } 
        AllVertices#40[$t#9] ==> GenericAlloc($t#9, $h0))
       && (forall $t#10: BoxType :: 
        { AllVertices#40[$t#10] } 
        AllVertices#40[$t#10] ==> GenericAlloc($t#10, $h1))
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.R#limited($h0, this, source#38, nn#39, AllVertices#40)
       == BreadthFirstSearch.R#limited($h1, this, source#38, nn#39, AllVertices#40));

procedure CheckWellformed$$BreadthFirstSearch.R(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#38: BoxType where GenericAlloc(source#38, $Heap), 
    nn#39: DatatypeType where DtAlloc(nn#39, $Heap) && DtType(nn#39) == class.Nat, 
    AllVertices#40: Set BoxType
       where (forall $t#11: BoxType :: 
        { AllVertices#40[$t#11] } 
        AllVertices#40[$t#11] ==> GenericAlloc($t#11, $Heap)));
  free requires 0 == $ModuleContextHeight && 13 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.R(this: ref, source#38: BoxType, nn#39: DatatypeType, AllVertices#40: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var mm#41: DatatypeType;
  var source#203: BoxType;
  var nn#204: DatatypeType;
  var AllVertices#205: Set BoxType;
  var source#206: BoxType;
  var nn#207: DatatypeType;
  var AllVertices#208: Set BoxType;
  var S#209: Set BoxType;
  var AllVertices#210: Set BoxType;

  anon0:
    goto anon6_Then, anon6_Else;

  anon6_Then:
    return;

  anon6_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} nn#39 == #Nat.Zero();
    assume BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40)
   == Set#UnionOne(Set#Empty(): Set BoxType, source#38);
    assume true;
    return;

  anon7_Else:
    assume {:partition} nn#39 != #Nat.Zero();
    goto anon8_Then, anon8_Else;

  anon8_Then:
    assume {:partition} nn#39 == #Nat.Suc(mm#41);
    assume DtAlloc(mm#41, $Heap) && DtType(mm#41) == class.Nat;
    source#203 := source#38;
    nn#204 := mm#41;
    AllVertices#205 := AllVertices#40;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert DtRank(nn#204) < DtRank(nn#39)
   || (
    DtRank(nn#204) == DtRank(nn#39)
     && Set#Subset(AllVertices#205, AllVertices#40)
     && !Set#Subset(AllVertices#40, AllVertices#205));
    assume BreadthFirstSearch.R#canCall($Heap, this, source#38, mm#41, AllVertices#40);
    source#206 := source#38;
    nn#207 := mm#41;
    AllVertices#208 := AllVertices#40;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert DtRank(nn#207) < DtRank(nn#39)
   || (
    DtRank(nn#207) == DtRank(nn#39)
     && Set#Subset(AllVertices#208, AllVertices#40)
     && !Set#Subset(AllVertices#40, AllVertices#208));
    assume BreadthFirstSearch.R#canCall($Heap, this, source#38, mm#41, AllVertices#40);
    S#209 := BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40);
    AllVertices#210 := AllVertices#40;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assume BreadthFirstSearch.Successors#canCall($Heap, 
  this, 
  BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40), 
  AllVertices#40);
    assume BreadthFirstSearch.R($Heap, this, source#38, nn#39, AllVertices#40)
   == Set#Union(BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40), 
    BreadthFirstSearch.Successors($Heap, 
      this, 
      BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40), 
      AllVertices#40));
    assume BreadthFirstSearch.R#canCall($Heap, this, source#38, mm#41, AllVertices#40)
   && BreadthFirstSearch.R#canCall($Heap, this, source#38, mm#41, AllVertices#40)
   && BreadthFirstSearch.Successors#canCall($Heap, 
    this, 
    BreadthFirstSearch.R($Heap, this, source#38, mm#41, AllVertices#40), 
    AllVertices#40);
    return;

  anon8_Else:
    assume {:partition} nn#39 != #Nat.Suc(mm#41);
    assume false;
    return;
}



function BreadthFirstSearch.Successors($heap: HeapType, this: ref, S#42: Set BoxType, AllVertices#43: Set BoxType)
   : Set BoxType;

function BreadthFirstSearch.Successors#canCall($heap: HeapType, this: ref, S#42: Set BoxType, AllVertices#43: Set BoxType)
   : bool;

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (12 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, S#42: Set BoxType, AllVertices#43: Set BoxType :: 
    { BreadthFirstSearch.Successors($Heap, this, S#42, AllVertices#43) } 
    BreadthFirstSearch.Successors#canCall($Heap, this, S#42, AllVertices#43)
         || (
          (0 != $ModuleContextHeight || 12 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && (forall $t#12: BoxType :: 
            { S#42[$t#12] } 
            S#42[$t#12] ==> GenericAlloc($t#12, $Heap))
           && (forall $t#13: BoxType :: 
            { AllVertices#43[$t#13] } 
            AllVertices#43[$t#13] ==> GenericAlloc($t#13, $Heap)))
       ==> (forall w#44: BoxType :: 
          GenericAlloc(w#44, $Heap)
             ==> 
            AllVertices#43[w#44]
             ==> (forall x#45: BoxType :: 
              GenericAlloc(x#45, $Heap)
                 ==> 
                S#42[x#45]
                 ==> BreadthFirstSearch.Succ#canCall($Heap, this, x#45)))
         && BreadthFirstSearch.Successors($Heap, this, S#42, AllVertices#43)
           == (lambda $y#14: BoxType :: 
            (exists w#44: BoxType :: 
              GenericAlloc(w#44, $Heap)
                 && AllVertices#43[w#44]
                 && (exists x#45: BoxType :: 
                  GenericAlloc(x#45, $Heap)
                     && S#42[x#45]
                     && BreadthFirstSearch.Succ($Heap, this, x#45)[w#44])
                 && $y#14 == w#44))
         && (forall $t#15: BoxType :: 
          { BreadthFirstSearch.Successors($Heap, this, S#42, AllVertices#43)[$t#15] } 
          BreadthFirstSearch.Successors($Heap, this, S#42, AllVertices#43)[$t#15]
             ==> GenericAlloc($t#15, $Heap)));

axiom (forall $h0: HeapType, 
    $h1: HeapType, 
    this: ref, 
    S#42: Set BoxType, 
    AllVertices#43: Set BoxType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.Successors($h1, this, S#42, AllVertices#43) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && (forall $t#16: BoxType :: 
        { S#42[$t#16] } 
        S#42[$t#16] ==> GenericAlloc($t#16, $h0))
       && (forall $t#17: BoxType :: 
        { S#42[$t#17] } 
        S#42[$t#17] ==> GenericAlloc($t#17, $h1))
       && (forall $t#18: BoxType :: 
        { AllVertices#43[$t#18] } 
        AllVertices#43[$t#18] ==> GenericAlloc($t#18, $h0))
       && (forall $t#19: BoxType :: 
        { AllVertices#43[$t#19] } 
        AllVertices#43[$t#19] ==> GenericAlloc($t#19, $h1))
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.Successors($h0, this, S#42, AllVertices#43)
       == BreadthFirstSearch.Successors($h1, this, S#42, AllVertices#43));

procedure CheckWellformed$$BreadthFirstSearch.Successors(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    S#42: Set BoxType
       where (forall $t#20: BoxType :: 
        { S#42[$t#20] } 
        S#42[$t#20] ==> GenericAlloc($t#20, $Heap)), 
    AllVertices#43: Set BoxType
       where (forall $t#21: BoxType :: 
        { AllVertices#43[$t#21] } 
        AllVertices#43[$t#21] ==> GenericAlloc($t#21, $Heap)));
  free requires 0 == $ModuleContextHeight && 12 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.Successors(this: ref, S#42: Set BoxType, AllVertices#43: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var w#211: BoxType;
  var x#212: BoxType;
  var x#213: BoxType;

  anon0:
    goto anon8_Then, anon8_Else;

  anon8_Then:
    return;

  anon8_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    havoc w#211;
    assume GenericAlloc(w#211, $Heap);
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} AllVertices#43[w#211];
    havoc x#212;
    assume GenericAlloc(x#212, $Heap);
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} S#42[x#212];
    x#213 := x#212;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assume BreadthFirstSearch.Succ#canCall($Heap, this, x#212);
    goto anon5;

  anon10_Else:
    assume {:partition} !S#42[x#212];
    goto anon5;

  anon9_Else:
    assume {:partition} !AllVertices#43[w#211];
    goto anon5;

  anon5:
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} AllVertices#43[w#211]
   && (exists x#45: BoxType :: 
    GenericAlloc(x#45, $Heap)
       && S#42[x#45]
       && BreadthFirstSearch.Succ($Heap, this, x#45)[w#211]);
    goto anon7;

  anon11_Else:
    assume {:partition} !(AllVertices#43[w#211]
   && (exists x#45: BoxType :: 
    GenericAlloc(x#45, $Heap)
       && S#42[x#45]
       && BreadthFirstSearch.Succ($Heap, this, x#45)[w#211]));
    goto anon7;

  anon7:
    assume BreadthFirstSearch.Successors($Heap, this, S#42, AllVertices#43)
   == (lambda $y#22: BoxType :: 
    (exists w#44: BoxType :: 
      GenericAlloc(w#44, $Heap)
         && AllVertices#43[w#44]
         && (exists x#45: BoxType :: 
          GenericAlloc(x#45, $Heap)
             && S#42[x#45]
             && BreadthFirstSearch.Succ($Heap, this, x#45)[w#44])
         && $y#22 == w#44));
    assume (forall w#44: BoxType :: 
  GenericAlloc(w#44, $Heap)
     ==> 
    AllVertices#43[w#44]
     ==> (forall x#45: BoxType :: 
      GenericAlloc(x#45, $Heap)
         ==> 
        S#42[x#45]
         ==> BreadthFirstSearch.Succ#canCall($Heap, this, x#45)));
    return;
}



procedure CheckWellformed$$BreadthFirstSearch.RMonotonicity(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#46: BoxType where GenericAlloc(source#46, $Heap), 
    mm#47: DatatypeType where DtAlloc(mm#47, $Heap) && DtType(mm#47) == class.Nat, 
    nn#48: DatatypeType where DtAlloc(nn#48, $Heap) && DtType(nn#48) == class.Nat, 
    AllVertices#49: Set BoxType
       where (forall $t#23: BoxType :: 
        { AllVertices#49[$t#23] } 
        AllVertices#49[$t#23] ==> GenericAlloc($t#23, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$BreadthFirstSearch.RMonotonicity(this: ref, 
    source#46: BoxType, 
    mm#47: DatatypeType, 
    nn#48: DatatypeType, 
    AllVertices#49: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var nn#214: DatatypeType;
  var nn#215: DatatypeType;
  var nn#216: DatatypeType;
  var nn#217: DatatypeType;
  var source#218: BoxType;
  var nn#219: DatatypeType;
  var AllVertices#220: Set BoxType;
  var source#221: BoxType;
  var nn#222: DatatypeType;
  var AllVertices#223: Set BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    nn#214 := mm#47;
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#47);
    nn#215 := nn#48;
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#48);
    assume BreadthFirstSearch.Value($Heap, this, mm#47)
   <= BreadthFirstSearch.Value($Heap, this, nn#48);
    nn#216 := nn#48;
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#48);
    nn#217 := mm#47;
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#47);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    source#218 := source#46;
    nn#219 := mm#47;
    AllVertices#220 := AllVertices#49;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#46, mm#47, AllVertices#49);
    source#221 := source#46;
    nn#222 := nn#48;
    AllVertices#223 := AllVertices#49;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#46, nn#48, AllVertices#49);
    assume Set#Subset(BreadthFirstSearch.R($Heap, this, source#46, mm#47, AllVertices#49), 
  BreadthFirstSearch.R($Heap, this, source#46, nn#48, AllVertices#49));
    return;
}



procedure BreadthFirstSearch.RMonotonicity(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#46: BoxType where GenericAlloc(source#46, $Heap), 
    mm#47: DatatypeType where DtAlloc(mm#47, $Heap) && DtType(mm#47) == class.Nat, 
    nn#48: DatatypeType where DtAlloc(nn#48, $Heap) && DtType(nn#48) == class.Nat, 
    AllVertices#49: Set BoxType
       where (forall $t#0: BoxType :: 
        { AllVertices#49[$t#0] } 
        AllVertices#49[$t#0] ==> GenericAlloc($t#0, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires BreadthFirstSearch.Value#2($Heap, this, mm#47)
   <= BreadthFirstSearch.Value#2($Heap, this, nn#48);
  modifies $Heap, $Tick;
  ensures Set#Subset(BreadthFirstSearch.R#2($Heap, this, source#46, mm#47, AllVertices#49), 
  BreadthFirstSearch.R#2($Heap, this, source#46, nn#48, AllVertices#49));
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  free ensures $HeapSucc(old($Heap), $Heap);



implementation BreadthFirstSearch.RMonotonicity(this: ref, 
    source#46: BoxType, 
    mm#47: DatatypeType, 
    nn#48: DatatypeType, 
    AllVertices#49: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var nn#224: DatatypeType;
  var nn#225: DatatypeType;
  var source#226: BoxType;
  var mm#227: DatatypeType;
  var nn#228: DatatypeType;
  var AllVertices#229: Set BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    nn#224 := mm#47;
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#47);
    nn#225 := nn#48;
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#48);
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#47)
   && BreadthFirstSearch.Value#canCall($Heap, this, nn#48);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} BreadthFirstSearch.Value($Heap, this, mm#47)
   < BreadthFirstSearch.Value($Heap, this, nn#48);
    assume true;
    source#226 := source#46;
    assume true;
    mm#227 := #Nat.Suc(mm#47);
    assume true;
    nn#228 := nn#48;
    assume true;
    AllVertices#229 := AllVertices#49;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert 0
     <= BreadthFirstSearch.Value($Heap, this, nn#48)
       - BreadthFirstSearch.Value($Heap, this, mm#47)
   || BreadthFirstSearch.Value($Heap, this, nn#228)
       - BreadthFirstSearch.Value($Heap, this, mm#227)
     == BreadthFirstSearch.Value($Heap, this, nn#48)
       - BreadthFirstSearch.Value($Heap, this, mm#47);
    assert BreadthFirstSearch.Value($Heap, this, nn#228)
     - BreadthFirstSearch.Value($Heap, this, mm#227)
   < BreadthFirstSearch.Value($Heap, this, nn#48)
     - BreadthFirstSearch.Value($Heap, this, mm#47);
    call BreadthFirstSearch.RMonotonicity(this, source#226, mm#227, nn#228, AllVertices#229);
    assume {:captureState "BreadthFirstSearch.dfy(194,7)"} true;
    return;

  anon3_Else:
    assume {:partition} BreadthFirstSearch.Value($Heap, this, nn#48)
   <= BreadthFirstSearch.Value($Heap, this, mm#47);
    return;
}



procedure CheckWellformed$$BreadthFirstSearch.IsReachFixpoint(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#50: BoxType where GenericAlloc(source#50, $Heap), 
    mm#51: DatatypeType where DtAlloc(mm#51, $Heap) && DtType(mm#51) == class.Nat, 
    nn#52: DatatypeType where DtAlloc(nn#52, $Heap) && DtType(nn#52) == class.Nat, 
    AllVertices#53: Set BoxType
       where (forall $t#0: BoxType :: 
        { AllVertices#53[$t#0] } 
        AllVertices#53[$t#0] ==> GenericAlloc($t#0, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$BreadthFirstSearch.IsReachFixpoint(this: ref, 
    source#50: BoxType, 
    mm#51: DatatypeType, 
    nn#52: DatatypeType, 
    AllVertices#53: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var source#230: BoxType;
  var nn#231: DatatypeType;
  var AllVertices#232: Set BoxType;
  var source#233: BoxType;
  var nn#234: DatatypeType;
  var AllVertices#235: Set BoxType;
  var nn#236: DatatypeType;
  var nn#237: DatatypeType;
  var nn#238: DatatypeType;
  var nn#239: DatatypeType;
  var source#240: BoxType;
  var nn#241: DatatypeType;
  var AllVertices#242: Set BoxType;
  var source#243: BoxType;
  var nn#244: DatatypeType;
  var AllVertices#245: Set BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    source#230 := source#50;
    nn#231 := mm#51;
    AllVertices#232 := AllVertices#53;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#50, mm#51, AllVertices#53);
    source#233 := source#50;
    nn#234 := #Nat.Suc(mm#51);
    AllVertices#235 := AllVertices#53;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#50, #Nat.Suc(mm#51), AllVertices#53);
    assume Set#Equal(BreadthFirstSearch.R($Heap, this, source#50, mm#51, AllVertices#53), 
  BreadthFirstSearch.R($Heap, this, source#50, #Nat.Suc(mm#51), AllVertices#53));
    nn#236 := mm#51;
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#51);
    nn#237 := nn#52;
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#52);
    assume BreadthFirstSearch.Value($Heap, this, mm#51)
   <= BreadthFirstSearch.Value($Heap, this, nn#52);
    nn#238 := nn#52;
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#52);
    nn#239 := mm#51;
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#51);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    source#240 := source#50;
    nn#241 := mm#51;
    AllVertices#242 := AllVertices#53;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#50, mm#51, AllVertices#53);
    source#243 := source#50;
    nn#244 := nn#52;
    AllVertices#245 := AllVertices#53;
    assume BreadthFirstSearch.R#canCall($Heap, this, source#50, nn#52, AllVertices#53);
    assume Set#Equal(BreadthFirstSearch.R($Heap, this, source#50, mm#51, AllVertices#53), 
  BreadthFirstSearch.R($Heap, this, source#50, nn#52, AllVertices#53));
    return;
}



procedure BreadthFirstSearch.IsReachFixpoint(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#50: BoxType where GenericAlloc(source#50, $Heap), 
    mm#51: DatatypeType where DtAlloc(mm#51, $Heap) && DtType(mm#51) == class.Nat, 
    nn#52: DatatypeType where DtAlloc(nn#52, $Heap) && DtType(nn#52) == class.Nat, 
    AllVertices#53: Set BoxType
       where (forall $t#0: BoxType :: 
        { AllVertices#53[$t#0] } 
        AllVertices#53[$t#0] ==> GenericAlloc($t#0, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires Set#Equal(BreadthFirstSearch.R#2($Heap, this, source#50, mm#51, AllVertices#53), 
  BreadthFirstSearch.R#2($Heap, this, source#50, #Nat.Suc(mm#51), AllVertices#53));
  requires BreadthFirstSearch.Value#2($Heap, this, mm#51)
   <= BreadthFirstSearch.Value#2($Heap, this, nn#52);
  modifies $Heap, $Tick;
  ensures Set#Equal(BreadthFirstSearch.R#2($Heap, this, source#50, mm#51, AllVertices#53), 
  BreadthFirstSearch.R#2($Heap, this, source#50, nn#52, AllVertices#53));
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  free ensures $HeapSucc(old($Heap), $Heap);



implementation BreadthFirstSearch.IsReachFixpoint(this: ref, 
    source#50: BoxType, 
    mm#51: DatatypeType, 
    nn#52: DatatypeType, 
    AllVertices#53: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var nn#246: DatatypeType;
  var nn#247: DatatypeType;
  var source#248: BoxType;
  var mm#249: DatatypeType;
  var nn#250: DatatypeType;
  var AllVertices#251: Set BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    nn#246 := mm#51;
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#51);
    nn#247 := nn#52;
    assume BreadthFirstSearch.Value#canCall($Heap, this, nn#52);
    assume BreadthFirstSearch.Value#canCall($Heap, this, mm#51)
   && BreadthFirstSearch.Value#canCall($Heap, this, nn#52);
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} BreadthFirstSearch.Value($Heap, this, mm#51)
   < BreadthFirstSearch.Value($Heap, this, nn#52);
    assume true;
    source#248 := source#50;
    assume true;
    mm#249 := #Nat.Suc(mm#51);
    assume true;
    nn#250 := nn#52;
    assume true;
    AllVertices#251 := AllVertices#53;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert 0
     <= BreadthFirstSearch.Value($Heap, this, nn#52)
       - BreadthFirstSearch.Value($Heap, this, mm#51)
   || BreadthFirstSearch.Value($Heap, this, nn#250)
       - BreadthFirstSearch.Value($Heap, this, mm#249)
     == BreadthFirstSearch.Value($Heap, this, nn#52)
       - BreadthFirstSearch.Value($Heap, this, mm#51);
    assert BreadthFirstSearch.Value($Heap, this, nn#250)
     - BreadthFirstSearch.Value($Heap, this, mm#249)
   < BreadthFirstSearch.Value($Heap, this, nn#52)
     - BreadthFirstSearch.Value($Heap, this, mm#51);
    call BreadthFirstSearch.IsReachFixpoint(this, source#248, mm#249, nn#250, AllVertices#251);
    assume {:captureState "BreadthFirstSearch.dfy(205,7)"} true;
    return;

  anon3_Else:
    assume {:partition} BreadthFirstSearch.Value($Heap, this, nn#52)
   <= BreadthFirstSearch.Value($Heap, this, mm#51);
    return;
}



procedure CheckWellformed$$BreadthFirstSearch.Lemma_IsPath_R(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#54: BoxType where GenericAlloc(source#54, $Heap), 
    x#55: BoxType where GenericAlloc(x#55, $Heap), 
    p#56: Seq BoxType
       where (forall $i#0: int :: 
        { Seq#Index(p#56, $i#0) } 
        0 <= $i#0 && $i#0 < Seq#Length(p#56)
           ==> GenericAlloc(Seq#Index(p#56, $i#0), $Heap)), 
    AllVertices#57: Set BoxType
       where (forall $t#1: BoxType :: 
        { AllVertices#57[$t#1] } 
        AllVertices#57[$t#1] ==> GenericAlloc($t#1, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$BreadthFirstSearch.Lemma_IsPath_R(this: ref, 
    source#54: BoxType, 
    x#55: BoxType, 
    p#56: Seq BoxType, 
    AllVertices#57: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var source#252: BoxType;
  var dest#253: BoxType;
  var p#254: Seq BoxType;
  var S#255: Set BoxType;
  var n#256: int;
  var source#257: BoxType;
  var nn#258: DatatypeType;
  var AllVertices#259: Set BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    source#252 := source#54;
    dest#253 := x#55;
    p#254 := p#56;
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#54, x#55, p#56);
    goto anon5_Then, anon5_Else;

  anon5_Then:
    assume {:partition} BreadthFirstSearch.IsPath($Heap, this, source#54, x#55, p#56);
    goto anon2;

  anon5_Else:
    assume {:partition} !BreadthFirstSearch.IsPath($Heap, this, source#54, x#55, p#56);
    goto anon2;

  anon2:
    goto anon6_Then, anon6_Else;

  anon6_Then:
    assume {:partition} BreadthFirstSearch.IsPath($Heap, this, source#54, x#55, p#56)
   && AllVertices#57[source#54];
    S#255 := AllVertices#57;
    assume BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#57);
    goto anon4;

  anon6_Else:
    assume {:partition} !(BreadthFirstSearch.IsPath($Heap, this, source#54, x#55, p#56)
   && AllVertices#57[source#54]);
    goto anon4;

  anon4:
    assume BreadthFirstSearch.IsPath($Heap, this, source#54, x#55, p#56)
   && AllVertices#57[source#54]
   && BreadthFirstSearch.IsClosed($Heap, this, AllVertices#57);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    assert 0 <= Seq#Length(p#56);
    n#256 := Seq#Length(p#56);
    assume BreadthFirstSearch.ToNat#canCall($Heap, this, Seq#Length(p#56));
    source#257 := source#54;
    nn#258 := BreadthFirstSearch.ToNat($Heap, this, Seq#Length(p#56));
    AllVertices#259 := AllVertices#57;
    assume BreadthFirstSearch.R#canCall($Heap, 
  this, 
  source#54, 
  BreadthFirstSearch.ToNat($Heap, this, Seq#Length(p#56)), 
  AllVertices#57);
    assume BreadthFirstSearch.R($Heap, 
  this, 
  source#54, 
  BreadthFirstSearch.ToNat($Heap, this, Seq#Length(p#56)), 
  AllVertices#57)[x#55];
    return;
}



procedure BreadthFirstSearch.Lemma_IsPath_R(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#54: BoxType where GenericAlloc(source#54, $Heap), 
    x#55: BoxType where GenericAlloc(x#55, $Heap), 
    p#56: Seq BoxType
       where (forall $i#0: int :: 
        { Seq#Index(p#56, $i#0) } 
        0 <= $i#0 && $i#0 < Seq#Length(p#56)
           ==> GenericAlloc(Seq#Index(p#56, $i#0), $Heap)), 
    AllVertices#57: Set BoxType
       where (forall $t#1: BoxType :: 
        { AllVertices#57[$t#1] } 
        AllVertices#57[$t#1] ==> GenericAlloc($t#1, $Heap)));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires BreadthFirstSearch.IsPath#canCall($Heap, this, source#54, x#55, p#56)
   && BreadthFirstSearch.IsPath($Heap, this, source#54, x#55, p#56)
   && (if source#54 == x#55
     then Seq#Equal(p#56, Seq#Empty(): Seq BoxType)
     else !Seq#Equal(p#56, Seq#Empty(): Seq BoxType)
       && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#56, Seq#Length(p#56) - 1))[x#55]
       && BreadthFirstSearch.IsPath($Heap, 
        this, 
        source#54, 
        Seq#Index(p#56, Seq#Length(p#56) - 1), 
        Seq#Take(p#56, Seq#Length(p#56) - 1)));
  requires BreadthFirstSearch.IsPath#canCall($Heap, this, source#54, x#55, p#56)
   ==> BreadthFirstSearch.IsPath($Heap, this, source#54, x#55, p#56)
     || (if source#54 == x#55
       then Seq#Equal(p#56, Seq#Empty(): Seq BoxType)
       else !Seq#Equal(p#56, Seq#Empty(): Seq BoxType)
         && BreadthFirstSearch.Succ($Heap, this, Seq#Index(p#56, Seq#Length(p#56) - 1))[x#55]
         && BreadthFirstSearch.IsPath($Heap, 
          this, 
          source#54, 
          Seq#Index(p#56, Seq#Length(p#56) - 1), 
          Seq#Take(p#56, Seq#Length(p#56) - 1)));
  requires AllVertices#57[source#54];
  free requires BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#57)
   && BreadthFirstSearch.IsClosed($Heap, this, AllVertices#57)
   && (forall v#5: BoxType :: 
    GenericAlloc(v#5, $Heap)
       ==> 
      AllVertices#57[v#5]
       ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), AllVertices#57));
  requires BreadthFirstSearch.IsClosed#canCall($Heap, this, AllVertices#57)
   ==> BreadthFirstSearch.IsClosed($Heap, this, AllVertices#57)
     || (forall v#5: BoxType :: 
      GenericAlloc(v#5, $Heap)
         ==> 
        AllVertices#57[v#5]
         ==> Set#Subset(BreadthFirstSearch.Succ($Heap, this, v#5), AllVertices#57));
  modifies $Heap, $Tick;
  ensures BreadthFirstSearch.R#2($Heap, 
  this, 
  source#54, 
  BreadthFirstSearch.ToNat#2($Heap, this, Seq#Length(p#56)), 
  AllVertices#57)[x#55];
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  free ensures $HeapSucc(old($Heap), $Heap);



implementation BreadthFirstSearch.Lemma_IsPath_R(this: ref, 
    source#54: BoxType, 
    x#55: BoxType, 
    p#56: Seq BoxType, 
    AllVertices#57: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var source#260: BoxType;
  var dest#261: BoxType;
  var p#262: Seq BoxType;
  var AllVertices#263: Set BoxType;
  var last#58: int;
  var source#264: BoxType;
  var x#265: BoxType;
  var p#266: Seq BoxType;
  var AllVertices#267: Set BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    assume true;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} !Seq#Equal(p#56, Seq#Empty(): Seq BoxType);
    assume true;
    source#260 := source#54;
    assume true;
    dest#261 := x#55;
    assume true;
    p#262 := p#56;
    assume true;
    AllVertices#263 := AllVertices#57;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call BreadthFirstSearch.Lemma_IsPath_Closure(this, source#260, dest#261, p#262, AllVertices#263);
    assume {:captureState "BreadthFirstSearch.dfy(215,7)"} true;
    assume true;
    assume true;
    last#58 := Seq#Length(p#56) - 1;
    assume {:captureState "BreadthFirstSearch.dfy(216,16)"} true;
    assume true;
    source#264 := source#54;
    assert 0 <= last#58 && last#58 < Seq#Length(p#56);
    assume true;
    x#265 := Seq#Index(p#56, last#58);
    assert 0 <= last#58 && last#58 <= Seq#Length(p#56);
    assume true;
    p#266 := Seq#Take(p#56, last#58);
    assume true;
    AllVertices#267 := AllVertices#57;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert Seq#Length(p#266) < Seq#Length(p#56)
   || (
    Seq#Length(p#266) == Seq#Length(p#56)
     && Set#Subset(AllVertices#267, AllVertices#57)
     && !Set#Subset(AllVertices#57, AllVertices#267));
    call BreadthFirstSearch.Lemma_IsPath_R(this, source#264, x#265, p#266, AllVertices#267);
    assume {:captureState "BreadthFirstSearch.dfy(217,7)"} true;
    return;

  anon3_Else:
    assume {:partition} Seq#Equal(p#56, Seq#Empty(): Seq BoxType);
    return;
}



function BreadthFirstSearch.Domain($heap: HeapType, this: ref, m#59: DatatypeType) : Set BoxType;

function BreadthFirstSearch.Domain#canCall($heap: HeapType, this: ref, m#59: DatatypeType) : bool;

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (14 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, m#59: DatatypeType :: 
    { BreadthFirstSearch.Domain($Heap, this, m#59) } 
    BreadthFirstSearch.Domain#canCall($Heap, this, m#59)
         || (
          (0 != $ModuleContextHeight || 14 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && DtAlloc(m#59, $Heap)
           && DtType(m#59) == class.Map)
       ==> (m#59 == #Map.Empty() ==> true)
         && (m#59 != #Map.Empty() ==> true)
         && BreadthFirstSearch.Domain($Heap, this, m#59)
           == (if m#59 == #Map.Empty() then Set#Empty(): Set BoxType else Map.dom(m#59))
         && (forall $t#0: BoxType :: 
          { BreadthFirstSearch.Domain($Heap, this, m#59)[$t#0] } 
          BreadthFirstSearch.Domain($Heap, this, m#59)[$t#0] ==> GenericAlloc($t#0, $Heap)));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, m#59: DatatypeType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.Domain($h1, this, m#59) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && DtAlloc(m#59, $h0)
       && DtType(m#59) == class.Map
       && DtAlloc(m#59, $h1)
       && DtType(m#59) == class.Map
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.Domain($h0, this, m#59)
       == BreadthFirstSearch.Domain($h1, this, m#59));

procedure CheckWellformed$$BreadthFirstSearch.Domain(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    m#59: DatatypeType where DtAlloc(m#59, $Heap) && DtType(m#59) == class.Map);
  free requires 0 == $ModuleContextHeight && 14 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.Domain(this: ref, m#59: DatatypeType)
{
  var $_Frame: <beta>[ref,Field beta]bool;

  anon0:
    goto anon6_Then, anon6_Else;

  anon6_Then:
    return;

  anon6_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon7_Then, anon7_Else;

  anon7_Then:
    assume {:partition} m#59 == #Map.Empty();
    goto anon5;

  anon7_Else:
    assume {:partition} m#59 != #Map.Empty();
    goto anon5;

  anon5:
    assume BreadthFirstSearch.Domain($Heap, this, m#59)
   == (if m#59 == #Map.Empty() then Set#Empty(): Set BoxType else Map.dom(m#59));
    assume (m#59 == #Map.Empty() ==> true) && (m#59 != #Map.Empty() ==> true);
    return;
}



function BreadthFirstSearch.ValidMap($heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType) : bool;

function BreadthFirstSearch.ValidMap#limited($heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType) : bool;

function BreadthFirstSearch.ValidMap#2($heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType) : bool;

function BreadthFirstSearch.ValidMap#canCall($heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType) : bool;

axiom (forall $Heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType :: 
  { BreadthFirstSearch.ValidMap#2($Heap, this, source#60, m#61) } 
  BreadthFirstSearch.ValidMap#2($Heap, this, source#60, m#61)
     == BreadthFirstSearch.ValidMap($Heap, this, source#60, m#61));

axiom (forall $Heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType :: 
  { BreadthFirstSearch.ValidMap($Heap, this, source#60, m#61) } 
  BreadthFirstSearch.ValidMap($Heap, this, source#60, m#61)
     == BreadthFirstSearch.ValidMap#limited($Heap, this, source#60, m#61));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (15 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#60: BoxType :: 
    { BreadthFirstSearch.ValidMap($Heap, this, source#60, #Map.Empty()) } 
    BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, #Map.Empty())
         || (
          (0 != $ModuleContextHeight || 15 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#60, $Heap))
       ==> BreadthFirstSearch.ValidMap($Heap, this, source#60, #Map.Empty()) == true);

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (15 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      dom#62: Set BoxType, 
      v#63: BoxType, 
      path#64: Seq BoxType, 
      next#65: DatatypeType, 
      source#60: BoxType :: 
    { BreadthFirstSearch.ValidMap($Heap, this, source#60, #Map.Maplet(dom#62, v#63, path#64, next#65)) } 
    BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, #Map.Maplet(dom#62, v#63, path#64, next#65))
         || (
          (0 != $ModuleContextHeight || 15 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && (forall $t#1: BoxType :: 
            { dom#62[$t#1] } 
            dom#62[$t#1] ==> GenericAlloc($t#1, $Heap))
           && GenericAlloc(v#63, $Heap)
           && (forall $i#2: int :: 
            { Seq#Index(path#64, $i#2) } 
            0 <= $i#2 && $i#2 < Seq#Length(path#64)
               ==> GenericAlloc(Seq#Index(path#64, $i#2), $Heap))
           && DtAlloc(next#65, $Heap)
           && DtType(next#65) == class.Map
           && GenericAlloc(source#60, $Heap))
       ==> (dom#62[v#63] ==> BreadthFirstSearch.Domain#canCall($Heap, this, next#65))
         && (dom#62[v#63]
             && Set#Equal(dom#62, 
              Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
                Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
           ==> BreadthFirstSearch.IsPath#canCall($Heap, this, source#60, v#63, path#64))
         && (dom#62[v#63]
             && Set#Equal(dom#62, 
              Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
                Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
             && BreadthFirstSearch.IsPath($Heap, this, source#60, v#63, path#64)
           ==> BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, next#65))
         && BreadthFirstSearch.ValidMap($Heap, this, source#60, #Map.Maplet(dom#62, v#63, path#64, next#65))
           == (
            dom#62[v#63]
             && Set#Equal(dom#62, 
              Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
                Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
             && BreadthFirstSearch.IsPath($Heap, this, source#60, v#63, path#64)
             && BreadthFirstSearch.ValidMap#limited($Heap, this, source#60, next#65)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (15 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType :: 
    { BreadthFirstSearch.ValidMap($Heap, this, source#60, m#61) } 
    BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, m#61)
         || (
          (0 != $ModuleContextHeight || 15 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#60, $Heap)
           && DtAlloc(m#61, $Heap)
           && DtType(m#61) == class.Map)
       ==> true);

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (15 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#60: BoxType :: 
    { BreadthFirstSearch.ValidMap#2($Heap, this, source#60, #Map.Empty()) } 
    BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, #Map.Empty())
         || (
          (0 != $ModuleContextHeight || 15 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#60, $Heap))
       ==> BreadthFirstSearch.ValidMap#2($Heap, this, source#60, #Map.Empty()) == true);

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (15 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      dom#62: Set BoxType, 
      v#63: BoxType, 
      path#64: Seq BoxType, 
      next#65: DatatypeType, 
      source#60: BoxType :: 
    { BreadthFirstSearch.ValidMap#2($Heap, this, source#60, #Map.Maplet(dom#62, v#63, path#64, next#65)) } 
    BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, #Map.Maplet(dom#62, v#63, path#64, next#65))
         || (
          (0 != $ModuleContextHeight || 15 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && (forall $t#3: BoxType :: 
            { dom#62[$t#3] } 
            dom#62[$t#3] ==> GenericAlloc($t#3, $Heap))
           && GenericAlloc(v#63, $Heap)
           && (forall $i#4: int :: 
            { Seq#Index(path#64, $i#4) } 
            0 <= $i#4 && $i#4 < Seq#Length(path#64)
               ==> GenericAlloc(Seq#Index(path#64, $i#4), $Heap))
           && DtAlloc(next#65, $Heap)
           && DtType(next#65) == class.Map
           && GenericAlloc(source#60, $Heap))
       ==> BreadthFirstSearch.ValidMap#2($Heap, this, source#60, #Map.Maplet(dom#62, v#63, path#64, next#65))
         == (
          dom#62[v#63]
           && Set#Equal(dom#62, 
            Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
              Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
           && BreadthFirstSearch.IsPath($Heap, this, source#60, v#63, path#64)
           && BreadthFirstSearch.ValidMap($Heap, this, source#60, next#65)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (15 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType :: 
    { BreadthFirstSearch.ValidMap#2($Heap, this, source#60, m#61) } 
    BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, m#61)
         || (
          (0 != $ModuleContextHeight || 15 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#60, $Heap)
           && DtAlloc(m#61, $Heap)
           && DtType(m#61) == class.Map)
       ==> true);

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.ValidMap($h1, this, source#60, m#61) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#60, $h0)
       && GenericAlloc(source#60, $h1)
       && DtAlloc(m#61, $h0)
       && DtType(m#61) == class.Map
       && DtAlloc(m#61, $h1)
       && DtType(m#61) == class.Map
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.ValidMap($h0, this, source#60, m#61)
       == BreadthFirstSearch.ValidMap($h1, this, source#60, m#61));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref, source#60: BoxType, m#61: DatatypeType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.ValidMap#limited($h1, this, source#60, m#61) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#60, $h0)
       && GenericAlloc(source#60, $h1)
       && DtAlloc(m#61, $h0)
       && DtType(m#61) == class.Map
       && DtAlloc(m#61, $h1)
       && DtType(m#61) == class.Map
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.ValidMap#limited($h0, this, source#60, m#61)
       == BreadthFirstSearch.ValidMap#limited($h1, this, source#60, m#61));

procedure CheckWellformed$$BreadthFirstSearch.ValidMap(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#60: BoxType where GenericAlloc(source#60, $Heap), 
    m#61: DatatypeType where DtAlloc(m#61, $Heap) && DtType(m#61) == class.Map);
  free requires 0 == $ModuleContextHeight && 15 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.ValidMap(this: ref, source#60: BoxType, m#61: DatatypeType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var dom#62: Set BoxType;
  var v#63: BoxType;
  var path#64: Seq BoxType;
  var next#65: DatatypeType;
  var m#268: DatatypeType;
  var source#269: BoxType;
  var dest#270: BoxType;
  var p#271: Seq BoxType;
  var source#272: BoxType;
  var m#273: DatatypeType;

  anon0:
    goto anon12_Then, anon12_Else;

  anon12_Then:
    return;

  anon12_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon13_Then, anon13_Else;

  anon13_Then:
    assume {:partition} m#61 == #Map.Empty();
    assume BreadthFirstSearch.ValidMap($Heap, this, source#60, m#61) == true;
    assume true;
    return;

  anon13_Else:
    assume {:partition} m#61 != #Map.Empty();
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} m#61 == #Map.Maplet(dom#62, v#63, path#64, next#65);
    assume (forall $t#5: BoxType :: 
  { dom#62[$t#5] } 
  dom#62[$t#5] ==> GenericAlloc($t#5, $Heap));
    assume GenericAlloc(v#63, $Heap);
    assume (forall $i#6: int :: 
  { Seq#Index(path#64, $i#6) } 
  0 <= $i#6 && $i#6 < Seq#Length(path#64)
     ==> GenericAlloc(Seq#Index(path#64, $i#6), $Heap));
    assume DtAlloc(next#65, $Heap) && DtType(next#65) == class.Map;
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} dom#62[v#63];
    m#268 := next#65;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assume BreadthFirstSearch.Domain#canCall($Heap, this, next#65);
    goto anon6;

  anon15_Else:
    assume {:partition} !dom#62[v#63];
    goto anon6;

  anon6:
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} dom#62[v#63]
   && Set#Equal(dom#62, 
    Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
      Set#UnionOne(Set#Empty(): Set BoxType, v#63)));
    source#269 := source#60;
    dest#270 := v#63;
    p#271 := path#64;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assume BreadthFirstSearch.IsPath#canCall($Heap, this, source#60, v#63, path#64);
    goto anon8;

  anon16_Else:
    assume {:partition} !(dom#62[v#63]
   && Set#Equal(dom#62, 
    Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
      Set#UnionOne(Set#Empty(): Set BoxType, v#63))));
    goto anon8;

  anon8:
    goto anon17_Then, anon17_Else;

  anon17_Then:
    assume {:partition} dom#62[v#63]
   && Set#Equal(dom#62, 
    Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
      Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
   && BreadthFirstSearch.IsPath($Heap, this, source#60, v#63, path#64);
    source#272 := source#60;
    m#273 := next#65;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert DtRank(m#273) < DtRank(m#61);
    assume BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, next#65);
    goto anon10;

  anon17_Else:
    assume {:partition} !(
  dom#62[v#63]
   && Set#Equal(dom#62, 
    Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
      Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
   && BreadthFirstSearch.IsPath($Heap, this, source#60, v#63, path#64));
    goto anon10;

  anon10:
    assume BreadthFirstSearch.ValidMap($Heap, this, source#60, m#61)
   == (
    dom#62[v#63]
     && Set#Equal(dom#62, 
      Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
        Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
     && BreadthFirstSearch.IsPath($Heap, this, source#60, v#63, path#64)
     && BreadthFirstSearch.ValidMap($Heap, this, source#60, next#65));
    assume (dom#62[v#63] ==> BreadthFirstSearch.Domain#canCall($Heap, this, next#65))
   && (dom#62[v#63]
       && Set#Equal(dom#62, 
        Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
          Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
     ==> BreadthFirstSearch.IsPath#canCall($Heap, this, source#60, v#63, path#64))
   && (dom#62[v#63]
       && Set#Equal(dom#62, 
        Set#Union(BreadthFirstSearch.Domain($Heap, this, next#65), 
          Set#UnionOne(Set#Empty(): Set BoxType, v#63)))
       && BreadthFirstSearch.IsPath($Heap, this, source#60, v#63, path#64)
     ==> BreadthFirstSearch.ValidMap#canCall($Heap, this, source#60, next#65));
    return;

  anon14_Else:
    assume {:partition} m#61 != #Map.Maplet(dom#62, v#63, path#64, next#65);
    assume false;
    return;
}



function BreadthFirstSearch.Find($heap: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType)
   : Seq BoxType;

function BreadthFirstSearch.Find#limited($heap: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType)
   : Seq BoxType;

function BreadthFirstSearch.Find#2($heap: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType)
   : Seq BoxType;

function BreadthFirstSearch.Find#canCall($heap: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType)
   : bool;

axiom (forall $Heap: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType :: 
  { BreadthFirstSearch.Find#2($Heap, this, source#66, x#67, m#68) } 
  BreadthFirstSearch.Find#2($Heap, this, source#66, x#67, m#68)
     == BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68));

axiom (forall $Heap: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType :: 
  { BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68) } 
  BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68)
     == BreadthFirstSearch.Find#limited($Heap, this, source#66, x#67, m#68));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (16 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      dom#69: Set BoxType, 
      v#70: BoxType, 
      path#71: Seq BoxType, 
      next#72: DatatypeType, 
      source#66: BoxType, 
      x#67: BoxType :: 
    { BreadthFirstSearch.Find($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72)) } 
    BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72))
         || (
          (0 != $ModuleContextHeight || 16 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && (forall $t#7: BoxType :: 
            { dom#69[$t#7] } 
            dom#69[$t#7] ==> GenericAlloc($t#7, $Heap))
           && GenericAlloc(v#70, $Heap)
           && (forall $i#8: int :: 
            { Seq#Index(path#71, $i#8) } 
            0 <= $i#8 && $i#8 < Seq#Length(path#71)
               ==> GenericAlloc(Seq#Index(path#71, $i#8), $Heap))
           && DtAlloc(next#72, $Heap)
           && DtType(next#72) == class.Map
           && GenericAlloc(source#66, $Heap)
           && GenericAlloc(x#67, $Heap)
           && BreadthFirstSearch.ValidMap($Heap, this, source#66, #Map.Maplet(dom#69, v#70, path#71, next#72))
           && BreadthFirstSearch.Domain($Heap, this, #Map.Maplet(dom#69, v#70, path#71, next#72))[x#67])
       ==> (x#67 == v#70 ==> true)
         && (x#67 != v#70
           ==> BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, next#72))
         && BreadthFirstSearch.Find($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72))
           == (if x#67 == v#70
             then path#71
             else BreadthFirstSearch.Find#limited($Heap, this, source#66, x#67, next#72))
         && (forall $i#9: int :: 
          { Seq#Index(BreadthFirstSearch.Find($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72)), 
              $i#9) } 
          0 <= $i#9
               && $i#9
                 < Seq#Length(BreadthFirstSearch.Find($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72)))
             ==> GenericAlloc(Seq#Index(BreadthFirstSearch.Find($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72)), 
                $i#9), 
              $Heap)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (16 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      source#66: BoxType, 
      x#67: BoxType, 
      m#68: DatatypeType :: 
    { BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68) } 
    BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, m#68)
         || (
          (0 != $ModuleContextHeight || 16 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#66, $Heap)
           && GenericAlloc(x#67, $Heap)
           && DtAlloc(m#68, $Heap)
           && DtType(m#68) == class.Map
           && BreadthFirstSearch.ValidMap($Heap, this, source#66, m#68)
           && BreadthFirstSearch.Domain($Heap, this, m#68)[x#67])
       ==> BreadthFirstSearch.IsPath($Heap, 
          this, 
          source#66, 
          x#67, 
          BreadthFirstSearch.Find#limited($Heap, this, source#66, x#67, m#68))
         && (forall $i#10: int :: 
          { Seq#Index(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68), $i#10) } 
          0 <= $i#10
               && $i#10 < Seq#Length(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68))
             ==> GenericAlloc(Seq#Index(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68), $i#10), 
              $Heap)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (16 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      dom#69: Set BoxType, 
      v#70: BoxType, 
      path#71: Seq BoxType, 
      next#72: DatatypeType, 
      source#66: BoxType, 
      x#67: BoxType :: 
    { BreadthFirstSearch.Find#2($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72)) } 
    BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72))
         || (
          (0 != $ModuleContextHeight || 16 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && (forall $t#11: BoxType :: 
            { dom#69[$t#11] } 
            dom#69[$t#11] ==> GenericAlloc($t#11, $Heap))
           && GenericAlloc(v#70, $Heap)
           && (forall $i#12: int :: 
            { Seq#Index(path#71, $i#12) } 
            0 <= $i#12 && $i#12 < Seq#Length(path#71)
               ==> GenericAlloc(Seq#Index(path#71, $i#12), $Heap))
           && DtAlloc(next#72, $Heap)
           && DtType(next#72) == class.Map
           && GenericAlloc(source#66, $Heap)
           && GenericAlloc(x#67, $Heap)
           && BreadthFirstSearch.ValidMap($Heap, this, source#66, #Map.Maplet(dom#69, v#70, path#71, next#72))
           && BreadthFirstSearch.Domain($Heap, this, #Map.Maplet(dom#69, v#70, path#71, next#72))[x#67])
       ==> BreadthFirstSearch.Find#2($Heap, this, source#66, x#67, #Map.Maplet(dom#69, v#70, path#71, next#72))
         == (if x#67 == v#70
           then path#71
           else BreadthFirstSearch.Find($Heap, this, source#66, x#67, next#72)));

axiom 0 < $ModuleContextHeight
     || (0 == $ModuleContextHeight
       && (16 <= $FunctionContextHeight || $InMethodContext))
   ==> (forall $Heap: HeapType, 
      this: ref, 
      source#66: BoxType, 
      x#67: BoxType, 
      m#68: DatatypeType :: 
    { BreadthFirstSearch.Find#2($Heap, this, source#66, x#67, m#68) } 
    BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, m#68)
         || (
          (0 != $ModuleContextHeight || 16 != $FunctionContextHeight || $InMethodContext)
           && $IsGoodHeap($Heap)
           && this != null
           && read($Heap, this, alloc)
           && dtype(this) == class.BreadthFirstSearch
           && GenericAlloc(source#66, $Heap)
           && GenericAlloc(x#67, $Heap)
           && DtAlloc(m#68, $Heap)
           && DtType(m#68) == class.Map
           && BreadthFirstSearch.ValidMap($Heap, this, source#66, m#68)
           && BreadthFirstSearch.Domain($Heap, this, m#68)[x#67])
       ==> true);

axiom (forall $h0: HeapType, 
    $h1: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.Find($h1, this, source#66, x#67, m#68) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#66, $h0)
       && GenericAlloc(source#66, $h1)
       && GenericAlloc(x#67, $h0)
       && GenericAlloc(x#67, $h1)
       && DtAlloc(m#68, $h0)
       && DtType(m#68) == class.Map
       && DtAlloc(m#68, $h1)
       && DtType(m#68) == class.Map
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.Find($h0, this, source#66, x#67, m#68)
       == BreadthFirstSearch.Find($h1, this, source#66, x#67, m#68));

axiom (forall $h0: HeapType, 
    $h1: HeapType, 
    this: ref, 
    source#66: BoxType, 
    x#67: BoxType, 
    m#68: DatatypeType :: 
  { $HeapSucc($h0, $h1), BreadthFirstSearch.Find#limited($h1, this, source#66, x#67, m#68) } 
  $IsGoodHeap($h0)
       && $IsGoodHeap($h1)
       && this != null
       && read($h0, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && read($h1, this, alloc)
       && dtype(this) == class.BreadthFirstSearch
       && GenericAlloc(source#66, $h0)
       && GenericAlloc(source#66, $h1)
       && GenericAlloc(x#67, $h0)
       && GenericAlloc(x#67, $h1)
       && DtAlloc(m#68, $h0)
       && DtType(m#68) == class.Map
       && DtAlloc(m#68, $h1)
       && DtType(m#68) == class.Map
       && $HeapSucc($h0, $h1)
     ==> 
    (forall<alpha> $o: ref, $f: Field alpha :: 
      false ==> read($h0, $o, $f) == read($h1, $o, $f))
     ==> BreadthFirstSearch.Find#limited($h0, this, source#66, x#67, m#68)
       == BreadthFirstSearch.Find#limited($h1, this, source#66, x#67, m#68));

procedure CheckWellformed$$BreadthFirstSearch.Find(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    source#66: BoxType where GenericAlloc(source#66, $Heap), 
    x#67: BoxType where GenericAlloc(x#67, $Heap), 
    m#68: DatatypeType where DtAlloc(m#68, $Heap) && DtType(m#68) == class.Map);
  free requires 0 == $ModuleContextHeight && 16 == $FunctionContextHeight;



implementation CheckWellformed$$BreadthFirstSearch.Find(this: ref, source#66: BoxType, x#67: BoxType, m#68: DatatypeType)
{
  var source#274: BoxType;
  var m#275: DatatypeType;
  var m#276: DatatypeType;
  var source#277: BoxType;
  var x#278: BoxType;
  var m#279: DatatypeType;
  var source#280: BoxType;
  var dest#281: BoxType;
  var p#282: Seq BoxType;
  var $_Frame: <beta>[ref,Field beta]bool;
  var dom#69: Set BoxType;
  var v#70: BoxType;
  var path#71: Seq BoxType;
  var next#72: DatatypeType;
  var source#283: BoxType;
  var x#284: BoxType;
  var m#285: DatatypeType;

  anon0:
    source#274 := source#66;
    m#275 := m#68;
    assume BreadthFirstSearch.ValidMap#canCall($Heap, this, source#66, m#68);
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} BreadthFirstSearch.ValidMap($Heap, this, source#66, m#68);
    m#276 := m#68;
    assume BreadthFirstSearch.Domain#canCall($Heap, this, m#68);
    goto anon2;

  anon12_Else:
    assume {:partition} !BreadthFirstSearch.ValidMap($Heap, this, source#66, m#68);
    goto anon2;

  anon2:
    assume BreadthFirstSearch.ValidMap($Heap, this, source#66, m#68)
   && BreadthFirstSearch.Domain($Heap, this, m#68)[x#67];
    goto anon13_Then, anon13_Else;

  anon13_Then:
    source#277 := source#66;
    x#278 := x#67;
    m#279 := m#68;
    assert BreadthFirstSearch.ValidMap($Heap, this, source#277, m#279)
   && BreadthFirstSearch.Domain($Heap, this, m#279)[x#278];
    assert (this == this && source#66 == source#66 && x#67 == x#67 && m#68 == m#68)
   || DtRank(m#279) < DtRank(m#68);
    assume (this == this && source#66 == source#66 && x#67 == x#67 && m#68 == m#68)
   || BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, m#68);
    source#280 := source#66;
    dest#281 := x#67;
    p#282 := BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68);
    assume BreadthFirstSearch.IsPath#canCall($Heap, 
  this, 
  source#66, 
  x#67, 
  BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68));
    assume BreadthFirstSearch.IsPath($Heap, 
  this, 
  source#66, 
  x#67, 
  BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68));
    return;

  anon13_Else:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    goto anon14_Then, anon14_Else;

  anon14_Then:
    assume {:partition} m#68 == #Map.Maplet(dom#69, v#70, path#71, next#72);
    assume (forall $t#13: BoxType :: 
  { dom#69[$t#13] } 
  dom#69[$t#13] ==> GenericAlloc($t#13, $Heap));
    assume GenericAlloc(v#70, $Heap);
    assume (forall $i#14: int :: 
  { Seq#Index(path#71, $i#14) } 
  0 <= $i#14 && $i#14 < Seq#Length(path#71)
     ==> GenericAlloc(Seq#Index(path#71, $i#14), $Heap));
    assume DtAlloc(next#72, $Heap) && DtType(next#72) == class.Map;
    goto anon15_Then, anon15_Else;

  anon15_Then:
    assume {:partition} x#67 == v#70;
    goto anon8;

  anon15_Else:
    assume {:partition} x#67 != v#70;
    source#283 := source#66;
    x#284 := x#67;
    m#285 := next#72;
    assert BreadthFirstSearch.ValidMap($Heap, this, source#283, m#285)
   && BreadthFirstSearch.Domain($Heap, this, m#285)[x#284];
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert DtRank(m#285) < DtRank(m#68);
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, next#72);
    goto anon8;

  anon8:
    assume BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68)
   == (if x#67 == v#70
     then path#71
     else BreadthFirstSearch.Find($Heap, this, source#66, x#67, next#72));
    assume (x#67 == v#70 ==> true)
   && (x#67 != v#70
     ==> BreadthFirstSearch.Find#canCall($Heap, this, source#66, x#67, next#72));
    goto anon11;

  anon14_Else:
    assume {:partition} m#68 != #Map.Maplet(dom#69, v#70, path#71, next#72);
    goto anon16_Then, anon16_Else;

  anon16_Then:
    assume {:partition} m#68 == #Map.Empty();
    assert false;
    goto anon11;

  anon16_Else:
    assume {:partition} m#68 != #Map.Empty();
    assume false;
    goto anon11;

  anon11:
    assert BreadthFirstSearch.IsPath#canCall($Heap, 
    this, 
    source#66, 
    x#67, 
    BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68))
   ==> BreadthFirstSearch.IsPath($Heap, 
      this, 
      source#66, 
      x#67, 
      BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68))
     || (if source#66 == x#67
       then Seq#Equal(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68), 
        Seq#Empty(): Seq BoxType)
       else !Seq#Equal(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68), 
          Seq#Empty(): Seq BoxType)
         && BreadthFirstSearch.Succ($Heap, 
          this, 
          Seq#Index(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68), 
            Seq#Length(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68)) - 1))[x#67]
         && BreadthFirstSearch.IsPath($Heap, 
          this, 
          source#66, 
          Seq#Index(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68), 
            Seq#Length(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68)) - 1), 
          Seq#Take(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68), 
            Seq#Length(BreadthFirstSearch.Find($Heap, this, source#66, x#67, m#68)) - 1)));
    return;
}



procedure CheckWellformed$$BreadthFirstSearch.UpdatePaths(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    vSuccs#73: Set BoxType
       where (forall $t#15: BoxType :: 
        { vSuccs#73[$t#15] } 
        vSuccs#73[$t#15] ==> GenericAlloc($t#15, $Heap)), 
    source#74: BoxType where GenericAlloc(source#74, $Heap), 
    paths#75: DatatypeType
       where DtAlloc(paths#75, $Heap) && DtType(paths#75) == class.Map, 
    v#76: BoxType where GenericAlloc(v#76, $Heap), 
    pathToV#77: Seq BoxType
       where (forall $i#16: int :: 
        { Seq#Index(pathToV#77, $i#16) } 
        0 <= $i#16 && $i#16 < Seq#Length(pathToV#77)
           ==> GenericAlloc(Seq#Index(pathToV#77, $i#16), $Heap)))
   returns (newPaths#78: DatatypeType
       where DtAlloc(newPaths#78, $Heap) && DtType(newPaths#78) == class.Map);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$BreadthFirstSearch.UpdatePaths(this: ref, 
    vSuccs#73: Set BoxType, 
    source#74: BoxType, 
    paths#75: DatatypeType, 
    v#76: BoxType, 
    pathToV#77: Seq BoxType)
   returns (newPaths#78: DatatypeType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var source#286: BoxType;
  var m#287: DatatypeType;
  var m#288: DatatypeType;
  var succ#289: BoxType;
  var source#290: BoxType;
  var dest#291: BoxType;
  var p#292: Seq BoxType;
  var source#293: BoxType;
  var m#294: DatatypeType;
  var m#295: DatatypeType;
  var m#296: DatatypeType;
  var x#297: BoxType;
  var m#298: DatatypeType;
  var source#299: BoxType;
  var x#300: BoxType;
  var m#301: DatatypeType;
  var source#302: BoxType;
  var x#303: BoxType;
  var m#304: DatatypeType;
  var x#305: BoxType;
  var source#306: BoxType;
  var x#307: BoxType;
  var m#308: DatatypeType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    source#286 := source#74;
    m#287 := paths#75;
    assume BreadthFirstSearch.ValidMap#canCall($Heap, this, source#74, paths#75);
    assume BreadthFirstSearch.ValidMap($Heap, this, source#74, paths#75);
    m#288 := paths#75;
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#75);
    assume Set#Disjoint(vSuccs#73, BreadthFirstSearch.Domain($Heap, this, paths#75));
    havoc succ#289;
    assume GenericAlloc(succ#289, $Heap);
    goto anon9_Then, anon9_Else;

  anon9_Then:
    assume {:partition} vSuccs#73[succ#289];
    source#290 := source#74;
    dest#291 := succ#289;
    p#292 := Seq#Append(pathToV#77, Seq#Build(Seq#Empty(): Seq BoxType, v#76));
    assume BreadthFirstSearch.IsPath#canCall($Heap, 
  this, 
  source#74, 
  succ#289, 
  Seq#Append(pathToV#77, Seq#Build(Seq#Empty(): Seq BoxType, v#76)));
    goto anon2;

  anon9_Else:
    assume {:partition} !vSuccs#73[succ#289];
    goto anon2;

  anon2:
    assume (forall succ#79: BoxType :: 
  GenericAlloc(succ#79, $Heap)
     ==> 
    vSuccs#73[succ#79]
     ==> BreadthFirstSearch.IsPath($Heap, 
      this, 
      source#74, 
      succ#79, 
      Seq#Append(pathToV#77, Seq#Build(Seq#Empty(): Seq BoxType, v#76))));
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    havoc newPaths#78;
    source#293 := source#74;
    m#294 := newPaths#78;
    assume BreadthFirstSearch.ValidMap#canCall($Heap, this, source#74, newPaths#78);
    goto anon10_Then, anon10_Else;

  anon10_Then:
    assume {:partition} BreadthFirstSearch.ValidMap($Heap, this, source#74, newPaths#78);
    m#295 := newPaths#78;
    assume BreadthFirstSearch.Domain#canCall($Heap, this, newPaths#78);
    m#296 := paths#75;
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#75);
    goto anon4;

  anon10_Else:
    assume {:partition} !BreadthFirstSearch.ValidMap($Heap, this, source#74, newPaths#78);
    goto anon4;

  anon4:
    assume BreadthFirstSearch.ValidMap($Heap, this, source#74, newPaths#78)
   && Set#Equal(BreadthFirstSearch.Domain($Heap, this, newPaths#78), 
    Set#Union(BreadthFirstSearch.Domain($Heap, this, paths#75), vSuccs#73));
    havoc x#297;
    assume GenericAlloc(x#297, $Heap);
    m#298 := paths#75;
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#75);
    goto anon11_Then, anon11_Else;

  anon11_Then:
    assume {:partition} BreadthFirstSearch.Domain($Heap, this, paths#75)[x#297];
    source#299 := source#74;
    x#300 := x#297;
    m#301 := paths#75;
    assert BreadthFirstSearch.ValidMap($Heap, this, source#299, m#301)
   && BreadthFirstSearch.Domain($Heap, this, m#301)[x#300];
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#74, x#297, paths#75);
    source#302 := source#74;
    x#303 := x#297;
    m#304 := newPaths#78;
    assert BreadthFirstSearch.ValidMap($Heap, this, source#302, m#304)
   && BreadthFirstSearch.Domain($Heap, this, m#304)[x#303];
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#74, x#297, newPaths#78);
    goto anon6;

  anon11_Else:
    assume {:partition} !BreadthFirstSearch.Domain($Heap, this, paths#75)[x#297];
    goto anon6;

  anon6:
    assume (forall x#80: BoxType :: 
  GenericAlloc(x#80, $Heap)
     ==> 
    BreadthFirstSearch.Domain($Heap, this, paths#75)[x#80]
     ==> Seq#Equal(BreadthFirstSearch.Find($Heap, this, source#74, x#80, paths#75), 
      BreadthFirstSearch.Find($Heap, this, source#74, x#80, newPaths#78)));
    havoc x#305;
    assume GenericAlloc(x#305, $Heap);
    goto anon12_Then, anon12_Else;

  anon12_Then:
    assume {:partition} vSuccs#73[x#305];
    source#306 := source#74;
    x#307 := x#305;
    m#308 := newPaths#78;
    assert BreadthFirstSearch.ValidMap($Heap, this, source#306, m#308)
   && BreadthFirstSearch.Domain($Heap, this, m#308)[x#307];
    assume BreadthFirstSearch.Find#canCall($Heap, this, source#74, x#305, newPaths#78);
    goto anon8;

  anon12_Else:
    assume {:partition} !vSuccs#73[x#305];
    goto anon8;

  anon8:
    assume (forall x#81: BoxType :: 
  GenericAlloc(x#81, $Heap)
     ==> 
    vSuccs#73[x#81]
     ==> Seq#Equal(BreadthFirstSearch.Find($Heap, this, source#74, x#81, newPaths#78), 
      Seq#Append(pathToV#77, Seq#Build(Seq#Empty(): Seq BoxType, v#76))));
    return;
}



procedure BreadthFirstSearch.UpdatePaths(this: ref
       where this != null
         && read($Heap, this, alloc)
         && dtype(this) == class.BreadthFirstSearch, 
    vSuccs#73: Set BoxType
       where (forall $t#0: BoxType :: 
        { vSuccs#73[$t#0] } 
        vSuccs#73[$t#0] ==> GenericAlloc($t#0, $Heap)), 
    source#74: BoxType where GenericAlloc(source#74, $Heap), 
    paths#75: DatatypeType
       where DtAlloc(paths#75, $Heap) && DtType(paths#75) == class.Map, 
    v#76: BoxType where GenericAlloc(v#76, $Heap), 
    pathToV#77: Seq BoxType
       where (forall $i#1: int :: 
        { Seq#Index(pathToV#77, $i#1) } 
        0 <= $i#1 && $i#1 < Seq#Length(pathToV#77)
           ==> GenericAlloc(Seq#Index(pathToV#77, $i#1), $Heap)))
   returns (newPaths#78: DatatypeType
       where DtAlloc(newPaths#78, $Heap) && DtType(newPaths#78) == class.Map);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires BreadthFirstSearch.ValidMap#2($Heap, this, source#74, paths#75);
  requires Set#Disjoint(vSuccs#73, BreadthFirstSearch.Domain($Heap, this, paths#75));
  requires (forall succ#79: BoxType :: 
  GenericAlloc(succ#79, $Heap)
     ==> 
    vSuccs#73[succ#79]
     ==> BreadthFirstSearch.IsPath#2($Heap, 
      this, 
      source#74, 
      succ#79, 
      Seq#Append(pathToV#77, Seq#Build(Seq#Empty(): Seq BoxType, v#76))));
  modifies $Heap, $Tick;
  ensures BreadthFirstSearch.ValidMap#2($Heap, this, source#74, newPaths#78);
  ensures Set#Equal(BreadthFirstSearch.Domain($Heap, this, newPaths#78), 
  Set#Union(BreadthFirstSearch.Domain($Heap, this, paths#75), vSuccs#73));
  ensures (forall x#80: BoxType :: 
  GenericAlloc(x#80, $Heap)
     ==> 
    BreadthFirstSearch.Domain($Heap, this, paths#75)[x#80]
     ==> Seq#Equal(BreadthFirstSearch.Find#2($Heap, this, source#74, x#80, paths#75), 
      BreadthFirstSearch.Find#2($Heap, this, source#74, x#80, newPaths#78)));
  ensures (forall x#81: BoxType :: 
  GenericAlloc(x#81, $Heap)
     ==> 
    vSuccs#73[x#81]
     ==> Seq#Equal(BreadthFirstSearch.Find#2($Heap, this, source#74, x#81, newPaths#78), 
      Seq#Append(pathToV#77, Seq#Build(Seq#Empty(): Seq BoxType, v#76))));
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: 
  { read($Heap, $o, $f) } 
  $o != null && read(old($Heap), $o, alloc)
     ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  free ensures $HeapSucc(old($Heap), $Heap);



implementation BreadthFirstSearch.UpdatePaths(this: ref, 
    vSuccs#73: Set BoxType, 
    source#74: BoxType, 
    paths#75: DatatypeType, 
    v#76: BoxType, 
    pathToV#77: Seq BoxType)
   returns (newPaths#78: DatatypeType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var succ#82: BoxType where GenericAlloc(succ#82, $Heap);
  var m#309: DatatypeType;
  var $rhs#2: DatatypeType where DtAlloc($rhs#2, $Heap) && DtType($rhs#2) == class.Map;
  var vSuccs#310: Set BoxType;
  var source#311: BoxType;
  var paths#312: DatatypeType;
  var v#313: BoxType;
  var pathToV#314: Seq BoxType;

  anon0:
    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: 
  $o != null && read($Heap, $o, alloc) ==> false);
    assume true;
    goto anon3_Then, anon3_Else;

  anon3_Then:
    assume {:partition} Set#Equal(vSuccs#73, Set#Empty(): Set BoxType);
    assume true;
    assume true;
    newPaths#78 := paths#75;
    assume {:captureState "BreadthFirstSearch.dfy(261,16)"} true;
    return;

  anon3_Else:
    assume {:partition} !Set#Equal(vSuccs#73, Set#Empty(): Set BoxType);
    assume true;
    assert vSuccs#73 != Set#Empty(): Set BoxType;
    assume true;
    succ#82 := Set#Choose(vSuccs#73, $Tick);
    havoc $Tick;
    assume {:captureState "BreadthFirstSearch.dfy(263,16)"} true;
    assume true;
    m#309 := paths#75;
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#75);
    assume BreadthFirstSearch.Domain#canCall($Heap, this, paths#75);
    newPaths#78 := #Map.Maplet(Set#Union(BreadthFirstSearch.Domain($Heap, this, paths#75), 
    Set#UnionOne(Set#Empty(): Set BoxType, succ#82)), 
  succ#82, 
  Seq#Append(pathToV#77, Seq#Build(Seq#Empty(): Seq BoxType, v#76)), 
  paths#75);
    assume {:captureState "BreadthFirstSearch.dfy(264,16)"} true;
    assume true;
    assume true;
    vSuccs#310 := Set#Difference(vSuccs#73, Set#UnionOne(Set#Empty(): Set BoxType, succ#82));
    assume true;
    source#311 := source#74;
    assume true;
    paths#312 := newPaths#78;
    assume true;
    v#313 := v#76;
    assume true;
    pathToV#314 := pathToV#77;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    assert (Set#Subset(vSuccs#310, vSuccs#73) && !Set#Subset(vSuccs#73, vSuccs#310))
   || (Set#Equal(vSuccs#310, vSuccs#73)
     && (DtRank(paths#312) < DtRank(paths#75)
       || (DtRank(paths#312) == DtRank(paths#75)
         && Seq#Length(pathToV#314) < Seq#Length(pathToV#77))));
    call $rhs#2 := BreadthFirstSearch.UpdatePaths(this, vSuccs#310, source#311, paths#312, v#313, pathToV#314);
    newPaths#78 := $rhs#2;
    assume {:captureState "BreadthFirstSearch.dfy(265,19)"} true;
    return;
}



const unique class.Map: ClassName;

function #Map.Empty() : DatatypeType;

axiom DtType(#Map.Empty()) == class.Map;

const unique ##Map.Empty: DtCtorId;

axiom DatatypeCtorId(#Map.Empty()) == ##Map.Empty;

axiom (forall d: DatatypeType :: Map.Empty?(d) ==> d == #Map.Empty());

function Map.Empty?(this: DatatypeType) : bool;

axiom (forall this: DatatypeType :: 
  { Map.Empty?(this): bool } 
  Map.Empty?(this): bool == (DatatypeCtorId(this) == ##Map.Empty));

axiom (forall $h: HeapType :: 
  { DtAlloc(#Map.Empty(), $h) } 
  $IsGoodHeap($h) ==> (DtAlloc(#Map.Empty(), $h) <==> true));

function #Map.Maplet(Set BoxType, BoxType, Seq BoxType, DatatypeType) : DatatypeType;

axiom (forall a0#0: Set BoxType, a1#1: BoxType, a2#2: Seq BoxType, a3#3: DatatypeType :: 
  DtType(#Map.Maplet(a0#0, a1#1, a2#2, a3#3)) == class.Map);

const unique ##Map.Maplet: DtCtorId;

axiom (forall a0#4: Set BoxType, a1#5: BoxType, a2#6: Seq BoxType, a3#7: DatatypeType :: 
  DatatypeCtorId(#Map.Maplet(a0#4, a1#5, a2#6, a3#7)) == ##Map.Maplet);

axiom (forall d: DatatypeType :: 
  Map.Maplet?(d)
     ==> (exists a0#8: Set BoxType, a1#9: BoxType, a2#10: Seq BoxType, a3#11: DatatypeType :: 
      d == #Map.Maplet(a0#8, a1#9, a2#10, a3#11)));

function Map.Maplet?(this: DatatypeType) : bool;

axiom (forall this: DatatypeType :: 
  { Map.Maplet?(this): bool } 
  Map.Maplet?(this): bool == (DatatypeCtorId(this) == ##Map.Maplet));

axiom (forall a0#12: Set BoxType, 
    a1#13: BoxType, 
    a2#14: Seq BoxType, 
    a3#15: DatatypeType, 
    $h: HeapType :: 
  { DtAlloc(#Map.Maplet(a0#12, a1#13, a2#14, a3#15), $h) } 
  $IsGoodHeap($h)
     ==> (DtAlloc(#Map.Maplet(a0#12, a1#13, a2#14, a3#15), $h)
       <==> (forall $t#16: BoxType :: 
          { a0#12[$t#16] } 
          a0#12[$t#16] ==> GenericAlloc($t#16, $h))
         && GenericAlloc(a1#13, $h)
         && (forall $i#17: int :: 
          { Seq#Index(a2#14, $i#17) } 
          0 <= $i#17 && $i#17 < Seq#Length(a2#14)
             ==> GenericAlloc(Seq#Index(a2#14, $i#17), $h))
         && DtAlloc(a3#15, $h)
         && DtType(a3#15) == class.Map));

function Map.dom(this: DatatypeType) : Set BoxType;

axiom (forall a0#18: Set BoxType, a1#19: BoxType, a2#20: Seq BoxType, a3#21: DatatypeType :: 
  Map.dom(#Map.Maplet(a0#18, a1#19, a2#20, a3#21)) == a0#18);

axiom (forall a0#22: Set BoxType, 
    a1#23: BoxType, 
    a2#24: Seq BoxType, 
    a3#25: DatatypeType, 
    d: DatatypeType :: 
  a0#22[$Box(d)] ==> DtRank(d) < DtRank(#Map.Maplet(a0#22, a1#23, a2#24, a3#25)));

function ##Map.Maplet#1(DatatypeType) : BoxType;

axiom (forall a0#26: Set BoxType, a1#27: BoxType, a2#28: Seq BoxType, a3#29: DatatypeType :: 
  ##Map.Maplet#1(#Map.Maplet(a0#26, a1#27, a2#28, a3#29)) == a1#27);

axiom (forall a0#30: Set BoxType, a1#31: BoxType, a2#32: Seq BoxType, a3#33: DatatypeType :: 
  DtRank($Unbox(a1#31): DatatypeType)
     < DtRank(#Map.Maplet(a0#30, a1#31, a2#32, a3#33)));

function ##Map.Maplet#2(DatatypeType) : Seq BoxType;

axiom (forall a0#34: Set BoxType, a1#35: BoxType, a2#36: Seq BoxType, a3#37: DatatypeType :: 
  ##Map.Maplet#2(#Map.Maplet(a0#34, a1#35, a2#36, a3#37)) == a2#36);

axiom (forall a0#38: Set BoxType, 
    a1#39: BoxType, 
    a2#40: Seq BoxType, 
    a3#41: DatatypeType, 
    i: int :: 
  0 <= i && i < Seq#Length(a2#40)
     ==> DtRank($Unbox(Seq#Index(a2#40, i)): DatatypeType)
       < DtRank(#Map.Maplet(a0#38, a1#39, a2#40, a3#41)));

function Map.next(this: DatatypeType) : DatatypeType;

axiom (forall a0#42: Set BoxType, a1#43: BoxType, a2#44: Seq BoxType, a3#45: DatatypeType :: 
  Map.next(#Map.Maplet(a0#42, a1#43, a2#44, a3#45)) == a3#45);

axiom (forall a0#46: Set BoxType, a1#47: BoxType, a2#48: Seq BoxType, a3#49: DatatypeType :: 
  DtRank(a3#49) < DtRank(#Map.Maplet(a0#46, a1#47, a2#48, a3#49)));

const unique class.List: ClassName;

function #List.Nil() : DatatypeType;

axiom DtType(#List.Nil()) == class.List;

const unique ##List.Nil: DtCtorId;

axiom DatatypeCtorId(#List.Nil()) == ##List.Nil;

axiom (forall d: DatatypeType :: List.Nil?(d) ==> d == #List.Nil());

function List.Nil?(this: DatatypeType) : bool;

axiom (forall this: DatatypeType :: 
  { List.Nil?(this): bool } 
  List.Nil?(this): bool == (DatatypeCtorId(this) == ##List.Nil));

axiom (forall $h: HeapType :: 
  { DtAlloc(#List.Nil(), $h) } 
  $IsGoodHeap($h) ==> (DtAlloc(#List.Nil(), $h) <==> true));

function #List.Cons(BoxType, DatatypeType) : DatatypeType;

axiom (forall a0#50: BoxType, a1#51: DatatypeType :: 
  DtType(#List.Cons(a0#50, a1#51)) == class.List);

const unique ##List.Cons: DtCtorId;

axiom (forall a0#52: BoxType, a1#53: DatatypeType :: 
  DatatypeCtorId(#List.Cons(a0#52, a1#53)) == ##List.Cons);

axiom (forall d: DatatypeType :: 
  List.Cons?(d)
     ==> (exists a0#54: BoxType, a1#55: DatatypeType :: d == #List.Cons(a0#54, a1#55)));

function List.Cons?(this: DatatypeType) : bool;

axiom (forall this: DatatypeType :: 
  { List.Cons?(this): bool } 
  List.Cons?(this): bool == (DatatypeCtorId(this) == ##List.Cons));

axiom (forall a0#56: BoxType, a1#57: DatatypeType, $h: HeapType :: 
  { DtAlloc(#List.Cons(a0#56, a1#57), $h) } 
  $IsGoodHeap($h)
     ==> (DtAlloc(#List.Cons(a0#56, a1#57), $h)
       <==> GenericAlloc(a0#56, $h) && DtAlloc(a1#57, $h) && DtType(a1#57) == class.List));

function ##List.Cons#0(DatatypeType) : BoxType;

axiom (forall a0#58: BoxType, a1#59: DatatypeType :: 
  ##List.Cons#0(#List.Cons(a0#58, a1#59)) == a0#58);

axiom (forall a0#60: BoxType, a1#61: DatatypeType :: 
  DtRank($Unbox(a0#60): DatatypeType) < DtRank(#List.Cons(a0#60, a1#61)));

function ##List.Cons#1(DatatypeType) : DatatypeType;

axiom (forall a0#62: BoxType, a1#63: DatatypeType :: 
  ##List.Cons#1(#List.Cons(a0#62, a1#63)) == a1#63);

axiom (forall a0#64: BoxType, a1#65: DatatypeType :: 
  DtRank(a1#65) < DtRank(#List.Cons(a0#64, a1#65)));

const unique class.Nat: ClassName;

function #Nat.Zero() : DatatypeType;

axiom DtType(#Nat.Zero()) == class.Nat;

const unique ##Nat.Zero: DtCtorId;

axiom DatatypeCtorId(#Nat.Zero()) == ##Nat.Zero;

axiom (forall d: DatatypeType :: Nat.Zero?(d) ==> d == #Nat.Zero());

function Nat.Zero?(this: DatatypeType) : bool;

axiom (forall this: DatatypeType :: 
  { Nat.Zero?(this): bool } 
  Nat.Zero?(this): bool == (DatatypeCtorId(this) == ##Nat.Zero));

axiom (forall $h: HeapType :: 
  { DtAlloc(#Nat.Zero(), $h) } 
  $IsGoodHeap($h) ==> (DtAlloc(#Nat.Zero(), $h) <==> true));

function #Nat.Suc(DatatypeType) : DatatypeType;

axiom (forall a0#66: DatatypeType :: DtType(#Nat.Suc(a0#66)) == class.Nat);

const unique ##Nat.Suc: DtCtorId;

axiom (forall a0#67: DatatypeType :: DatatypeCtorId(#Nat.Suc(a0#67)) == ##Nat.Suc);

axiom (forall d: DatatypeType :: 
  Nat.Suc?(d) ==> (exists a0#68: DatatypeType :: d == #Nat.Suc(a0#68)));

function Nat.Suc?(this: DatatypeType) : bool;

axiom (forall this: DatatypeType :: 
  { Nat.Suc?(this): bool } 
  Nat.Suc?(this): bool == (DatatypeCtorId(this) == ##Nat.Suc));

axiom (forall a0#69: DatatypeType, $h: HeapType :: 
  { DtAlloc(#Nat.Suc(a0#69), $h) } 
  $IsGoodHeap($h)
     ==> (DtAlloc(#Nat.Suc(a0#69), $h)
       <==> DtAlloc(a0#69, $h) && DtType(a0#69) == class.Nat));

function Nat.predecessor(this: DatatypeType) : DatatypeType;

axiom (forall a0#70: DatatypeType :: Nat.predecessor(#Nat.Suc(a0#70)) == a0#70);

axiom (forall a0#71: DatatypeType :: DtRank(a0#71) < DtRank(#Nat.Suc(a0#71)));

const unique class._default: ClassName;
