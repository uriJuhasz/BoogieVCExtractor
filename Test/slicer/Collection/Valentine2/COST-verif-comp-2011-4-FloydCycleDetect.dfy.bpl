// Dafny program verifier version 1.7.0.00806, Copyright (c) 2003-2013, Microsoft.
// Command Line Options: /compile:0 /print COST-verif-comp-2011-4-FloydCycleDetect.dfy.bpl COST-verif-comp-2011-4-FloydCycleDetect.dfy

const $$Language$Dafny: bool;

axiom $$Language$Dafny;

function {:identity} Lit<T>(x: T) : T;

axiom (forall<T> x: T :: {:identity} { Lit(x): T } Lit(x): T == x);

axiom (forall<T> x: T :: { $Box(Lit(x)) } $Box(Lit(x)) == Lit($Box(x)));

type ref;

const null: ref;

type Set T = [T]bool;

function Set#Card<T>(Set T) : int;

axiom (forall<T> s: Set T :: { Set#Card(s) } 0 <= Set#Card(s));

function Set#Empty<T>() : Set T;

axiom (forall<T> o: T :: { Set#Empty()[o] } !Set#Empty()[o]);

axiom (forall<T> s: Set T :: { Set#Card(s) } (Set#Card(s) == 0 <==> s == Set#Empty()) && (Set#Card(s) != 0 ==> (exists x: T :: s[x])));

function Set#Singleton<T>(T) : Set T;

axiom (forall<T> r: T :: { Set#Singleton(r) } Set#Singleton(r)[r]);

axiom (forall<T> r: T, o: T :: { Set#Singleton(r)[o] } Set#Singleton(r)[o] <==> r == o);

axiom (forall<T> r: T :: { Set#Card(Set#Singleton(r)) } Set#Card(Set#Singleton(r)) == 1);

function Set#UnionOne<T>(Set T, T) : Set T;

axiom (forall<T> a: Set T, x: T, o: T :: { Set#UnionOne(a, x)[o] } Set#UnionOne(a, x)[o] <==> o == x || a[o]);

axiom (forall<T> a: Set T, x: T :: { Set#UnionOne(a, x) } Set#UnionOne(a, x)[x]);

axiom (forall<T> a: Set T, x: T, y: T :: { Set#UnionOne(a, x), a[y] } a[y] ==> Set#UnionOne(a, x)[y]);

axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#UnionOne(a, x)) } a[x] ==> Set#Card(Set#UnionOne(a, x)) == Set#Card(a));

axiom (forall<T> a: Set T, x: T :: { Set#Card(Set#UnionOne(a, x)) } !a[x] ==> Set#Card(Set#UnionOne(a, x)) == Set#Card(a) + 1);

function Set#Union<T>(Set T, Set T) : Set T;

axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Union(a, b)[o] } Set#Union(a, b)[o] <==> a[o] || b[o]);

axiom (forall<T> a: Set T, b: Set T, y: T :: { Set#Union(a, b), a[y] } a[y] ==> Set#Union(a, b)[y]);

axiom (forall<T> a: Set T, b: Set T, y: T :: { Set#Union(a, b), b[y] } b[y] ==> Set#Union(a, b)[y]);

axiom (forall<T> a: Set T, b: Set T :: { Set#Union(a, b) } Set#Disjoint(a, b) ==> Set#Difference(Set#Union(a, b), a) == b && Set#Difference(Set#Union(a, b), b) == a);

function Set#Intersection<T>(Set T, Set T) : Set T;

axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Intersection(a, b)[o] } Set#Intersection(a, b)[o] <==> a[o] && b[o]);

axiom (forall<T> a: Set T, b: Set T :: { Set#Union(Set#Union(a, b), b) } Set#Union(Set#Union(a, b), b) == Set#Union(a, b));

axiom (forall<T> a: Set T, b: Set T :: { Set#Union(a, Set#Union(a, b)) } Set#Union(a, Set#Union(a, b)) == Set#Union(a, b));

axiom (forall<T> a: Set T, b: Set T :: { Set#Intersection(Set#Intersection(a, b), b) } Set#Intersection(Set#Intersection(a, b), b) == Set#Intersection(a, b));

axiom (forall<T> a: Set T, b: Set T :: { Set#Intersection(a, Set#Intersection(a, b)) } Set#Intersection(a, Set#Intersection(a, b)) == Set#Intersection(a, b));

axiom (forall<T> a: Set T, b: Set T :: { Set#Card(Set#Union(a, b)) } { Set#Card(Set#Intersection(a, b)) } Set#Card(Set#Union(a, b)) + Set#Card(Set#Intersection(a, b)) == Set#Card(a) + Set#Card(b));

function Set#Difference<T>(Set T, Set T) : Set T;

axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Difference(a, b)[o] } Set#Difference(a, b)[o] <==> a[o] && !b[o]);

axiom (forall<T> a: Set T, b: Set T, y: T :: { Set#Difference(a, b), b[y] } b[y] ==> !Set#Difference(a, b)[y]);

axiom (forall<T> a: Set T, b: Set T :: { Set#Card(Set#Difference(a, b)) } Set#Card(Set#Difference(a, b)) + Set#Card(Set#Difference(b, a)) + Set#Card(Set#Intersection(a, b)) == Set#Card(Set#Union(a, b)) && Set#Card(Set#Difference(a, b)) == Set#Card(a) - Set#Card(Set#Intersection(a, b)));

function Set#Subset<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: { Set#Subset(a, b) } Set#Subset(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] ==> b[o]));

function Set#Equal<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: { Set#Equal(a, b) } Set#Equal(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] <==> b[o]));

axiom (forall<T> a: Set T, b: Set T :: { Set#Equal(a, b) } Set#Equal(a, b) ==> a == b);

function Set#Disjoint<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: { Set#Disjoint(a, b) } Set#Disjoint(a, b) <==> (forall o: T :: { a[o] } { b[o] } !a[o] || !b[o]));

function Math#min(a: int, b: int) : int;

axiom (forall a: int, b: int :: { Math#min(a, b) } a <= b <==> Math#min(a, b) == a);

axiom (forall a: int, b: int :: { Math#min(a, b) } b <= a <==> Math#min(a, b) == b);

axiom (forall a: int, b: int :: { Math#min(a, b) } Math#min(a, b) == a || Math#min(a, b) == b);

function Math#clip(a: int) : int;

axiom (forall a: int :: { Math#clip(a) } 0 <= a ==> Math#clip(a) == a);

axiom (forall a: int :: { Math#clip(a) } a < 0 ==> Math#clip(a) == 0);

type MultiSet T = [T]int;

function $IsGoodMultiSet<T>(ms: MultiSet T) : bool;

axiom (forall<T> ms: MultiSet T :: { $IsGoodMultiSet(ms) } $IsGoodMultiSet(ms) <==> (forall bx: T :: { ms[bx] } 0 <= ms[bx]));

function MultiSet#Card<T>(MultiSet T) : int;

axiom (forall<T> s: MultiSet T :: { MultiSet#Card(s) } 0 <= MultiSet#Card(s));

axiom (forall<T> s: MultiSet T, x: T, n: int :: { MultiSet#Card(s[x := n]) } 0 <= n ==> MultiSet#Card(s[x := n]) == MultiSet#Card(s) - s[x] + n);

function MultiSet#Empty<T>() : MultiSet T;

axiom (forall<T> o: T :: { MultiSet#Empty()[o] } MultiSet#Empty()[o] == 0);

axiom (forall<T> s: MultiSet T :: { MultiSet#Card(s) } (MultiSet#Card(s) == 0 <==> s == MultiSet#Empty()) && (MultiSet#Card(s) != 0 ==> (exists x: T :: 0 < s[x])));

function MultiSet#Singleton<T>(T) : MultiSet T;

axiom (forall<T> r: T, o: T :: { MultiSet#Singleton(r)[o] } (MultiSet#Singleton(r)[o] == 1 <==> r == o) && (MultiSet#Singleton(r)[o] == 0 <==> r != o));

axiom (forall<T> r: T :: { MultiSet#Singleton(r) } MultiSet#Singleton(r) == MultiSet#UnionOne(MultiSet#Empty(), r));

function MultiSet#UnionOne<T>(MultiSet T, T) : MultiSet T;

axiom (forall<T> a: MultiSet T, x: T, o: T :: { MultiSet#UnionOne(a, x)[o] } 0 < MultiSet#UnionOne(a, x)[o] <==> o == x || 0 < a[o]);

axiom (forall<T> a: MultiSet T, x: T :: { MultiSet#UnionOne(a, x) } MultiSet#UnionOne(a, x)[x] == a[x] + 1);

axiom (forall<T> a: MultiSet T, x: T, y: T :: { MultiSet#UnionOne(a, x), a[y] } 0 < a[y] ==> 0 < MultiSet#UnionOne(a, x)[y]);

axiom (forall<T> a: MultiSet T, x: T, y: T :: { MultiSet#UnionOne(a, x), a[y] } x != y ==> a[y] == MultiSet#UnionOne(a, x)[y]);

axiom (forall<T> a: MultiSet T, x: T :: { MultiSet#Card(MultiSet#UnionOne(a, x)) } MultiSet#Card(MultiSet#UnionOne(a, x)) == MultiSet#Card(a) + 1);

function MultiSet#Union<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: { MultiSet#Union(a, b)[o] } MultiSet#Union(a, b)[o] == a[o] + b[o]);

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Card(MultiSet#Union(a, b)) } MultiSet#Card(MultiSet#Union(a, b)) == MultiSet#Card(a) + MultiSet#Card(b));

function MultiSet#Intersection<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: { MultiSet#Intersection(a, b)[o] } MultiSet#Intersection(a, b)[o] == Math#min(a[o], b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Intersection(MultiSet#Intersection(a, b), b) } MultiSet#Intersection(MultiSet#Intersection(a, b), b) == MultiSet#Intersection(a, b));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Intersection(a, MultiSet#Intersection(a, b)) } MultiSet#Intersection(a, MultiSet#Intersection(a, b)) == MultiSet#Intersection(a, b));

function MultiSet#Difference<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: { MultiSet#Difference(a, b)[o] } MultiSet#Difference(a, b)[o] == Math#clip(a[o] - b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T, y: T :: { MultiSet#Difference(a, b), b[y], a[y] } a[y] <= b[y] ==> MultiSet#Difference(a, b)[y] == 0);

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Card(MultiSet#Difference(a, b)) } MultiSet#Card(MultiSet#Difference(a, b)) + MultiSet#Card(MultiSet#Difference(b, a)) + 2 * MultiSet#Card(MultiSet#Intersection(a, b)) == MultiSet#Card(MultiSet#Union(a, b)) && MultiSet#Card(MultiSet#Difference(a, b)) == MultiSet#Card(a) - MultiSet#Card(MultiSet#Intersection(a, b)));

function MultiSet#Subset<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Subset(a, b) } MultiSet#Subset(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] <= b[o]));

function MultiSet#Equal<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Equal(a, b) } MultiSet#Equal(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] == b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Equal(a, b) } MultiSet#Equal(a, b) ==> a == b);

function MultiSet#Disjoint<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Disjoint(a, b) } MultiSet#Disjoint(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] == 0 || b[o] == 0));

function MultiSet#FromSet<T>(Set T) : MultiSet T;

axiom (forall<T> s: Set T, a: T :: { MultiSet#FromSet(s)[a] } (MultiSet#FromSet(s)[a] == 0 <==> !s[a]) && (MultiSet#FromSet(s)[a] == 1 <==> s[a]));

axiom (forall<T> s: Set T :: { MultiSet#Card(MultiSet#FromSet(s)) } MultiSet#Card(MultiSet#FromSet(s)) == Set#Card(s));

function MultiSet#FromSeq<T>(Seq T) : MultiSet T;

axiom (forall<T> s: Seq T :: { MultiSet#FromSeq(s) } $IsGoodMultiSet(MultiSet#FromSeq(s)));

axiom (forall<T> s: Seq T, v: T :: { MultiSet#FromSeq(Seq#Build(s, v)) } MultiSet#FromSeq(Seq#Build(s, v)) == MultiSet#UnionOne(MultiSet#FromSeq(s), v));

axiom (forall<T>  :: MultiSet#FromSeq(Seq#Empty(): Seq T) == MultiSet#Empty(): MultiSet T);

axiom (forall<T> a: Seq T, b: Seq T :: { MultiSet#FromSeq(Seq#Append(a, b)) } MultiSet#FromSeq(Seq#Append(a, b)) == MultiSet#Union(MultiSet#FromSeq(a), MultiSet#FromSeq(b)));

axiom (forall<T> s: Seq T, i: int, v: T, x: T :: { MultiSet#FromSeq(Seq#Update(s, i, v))[x] } 0 <= i && i < Seq#Length(s) ==> MultiSet#FromSeq(Seq#Update(s, i, v))[x] == MultiSet#Union(MultiSet#Difference(MultiSet#FromSeq(s), MultiSet#Singleton(Seq#Index(s, i))), MultiSet#Singleton(v))[x]);

axiom (forall<T> s: Seq T, x: T :: { MultiSet#FromSeq(s)[x] } (exists i: int :: { Seq#Index(s, i) } 0 <= i && i < Seq#Length(s) && x == Seq#Index(s, i)) <==> 0 < MultiSet#FromSeq(s)[x]);

type Seq _;

function Seq#Length<T>(Seq T) : int;

axiom (forall<T> s: Seq T :: { Seq#Length(s) } 0 <= Seq#Length(s));

function Seq#Empty<T>() : Seq T;

axiom (forall<T>  :: Seq#Length(Seq#Empty(): Seq T) == 0);

axiom (forall<T> s: Seq T :: { Seq#Length(s) } Seq#Length(s) == 0 ==> s == Seq#Empty());

function Seq#Singleton<T>(T) : Seq T;

axiom (forall<T> t: T :: { Seq#Length(Seq#Singleton(t)) } Seq#Length(Seq#Singleton(t)) == 1);

function Seq#Build<T>(s: Seq T, val: T) : Seq T;

axiom (forall<T> s: Seq T, v: T :: { Seq#Length(Seq#Build(s, v)) } Seq#Length(Seq#Build(s, v)) == 1 + Seq#Length(s));

axiom (forall<T> s: Seq T, i: int, v: T :: { Seq#Index(Seq#Build(s, v), i) } (i == Seq#Length(s) ==> Seq#Index(Seq#Build(s, v), i) == v) && (i != Seq#Length(s) ==> Seq#Index(Seq#Build(s, v), i) == Seq#Index(s, i)));

function Seq#Append<T>(Seq T, Seq T) : Seq T;

axiom (forall<T> s0: Seq T, s1: Seq T :: { Seq#Length(Seq#Append(s0, s1)) } Seq#Length(Seq#Append(s0, s1)) == Seq#Length(s0) + Seq#Length(s1));

function Seq#Index<T>(Seq T, int) : T;

axiom (forall<T> t: T :: { Seq#Index(Seq#Singleton(t), 0) } Seq#Index(Seq#Singleton(t), 0) == t);

axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: { Seq#Index(Seq#Append(s0, s1), n) } (n < Seq#Length(s0) ==> Seq#Index(Seq#Append(s0, s1), n) == Seq#Index(s0, n)) && (Seq#Length(s0) <= n ==> Seq#Index(Seq#Append(s0, s1), n) == Seq#Index(s1, n - Seq#Length(s0))));

function Seq#Update<T>(Seq T, int, T) : Seq T;

axiom (forall<T> s: Seq T, i: int, v: T :: { Seq#Length(Seq#Update(s, i, v)) } 0 <= i && i < Seq#Length(s) ==> Seq#Length(Seq#Update(s, i, v)) == Seq#Length(s));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Index(Seq#Update(s, i, v), n) } 0 <= n && n < Seq#Length(s) ==> (i == n ==> Seq#Index(Seq#Update(s, i, v), n) == v) && (i != n ==> Seq#Index(Seq#Update(s, i, v), n) == Seq#Index(s, n)));

function Seq#Contains<T>(Seq T, T) : bool;

axiom (forall<T> s: Seq T, x: T :: { Seq#Contains(s, x) } Seq#Contains(s, x) <==> (exists i: int :: { Seq#Index(s, i) } 0 <= i && i < Seq#Length(s) && Seq#Index(s, i) == x));

axiom (forall x: ref :: { Seq#Contains(Seq#Empty(), x) } !Seq#Contains(Seq#Empty(), x));

axiom (forall<T> s0: Seq T, s1: Seq T, x: T :: { Seq#Contains(Seq#Append(s0, s1), x) } Seq#Contains(Seq#Append(s0, s1), x) <==> Seq#Contains(s0, x) || Seq#Contains(s1, x));

axiom (forall<T> s: Seq T, v: T, x: T :: { Seq#Contains(Seq#Build(s, v), x) } Seq#Contains(Seq#Build(s, v), x) <==> v == x || Seq#Contains(s, x));

axiom (forall<T> s: Seq T, n: int, x: T :: { Seq#Contains(Seq#Take(s, n), x) } Seq#Contains(Seq#Take(s, n), x) <==> (exists i: int :: { Seq#Index(s, i) } 0 <= i && i < n && i < Seq#Length(s) && Seq#Index(s, i) == x));

axiom (forall<T> s: Seq T, n: int, x: T :: { Seq#Contains(Seq#Drop(s, n), x) } Seq#Contains(Seq#Drop(s, n), x) <==> (exists i: int :: { Seq#Index(s, i) } 0 <= n && n <= i && i < Seq#Length(s) && Seq#Index(s, i) == x));

function Seq#Equal<T>(Seq T, Seq T) : bool;

axiom (forall<T> s0: Seq T, s1: Seq T :: { Seq#Equal(s0, s1) } Seq#Equal(s0, s1) <==> Seq#Length(s0) == Seq#Length(s1) && (forall j: int :: { Seq#Index(s0, j) } { Seq#Index(s1, j) } 0 <= j && j < Seq#Length(s0) ==> Seq#Index(s0, j) == Seq#Index(s1, j)));

axiom (forall<T> a: Seq T, b: Seq T :: { Seq#Equal(a, b) } Seq#Equal(a, b) ==> a == b);

function Seq#SameUntil<T>(Seq T, Seq T, int) : bool;

axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: { Seq#SameUntil(s0, s1, n) } Seq#SameUntil(s0, s1, n) <==> (forall j: int :: { Seq#Index(s0, j) } { Seq#Index(s1, j) } 0 <= j && j < n ==> Seq#Index(s0, j) == Seq#Index(s1, j)));

function Seq#Take<T>(s: Seq T, howMany: int) : Seq T;

axiom (forall<T> s: Seq T, n: int :: { Seq#Length(Seq#Take(s, n)) } 0 <= n ==> (n <= Seq#Length(s) ==> Seq#Length(Seq#Take(s, n)) == n) && (Seq#Length(s) < n ==> Seq#Length(Seq#Take(s, n)) == Seq#Length(s)));

axiom (forall<T> s: Seq T, n: int, j: int :: {:weight 25} { Seq#Index(Seq#Take(s, n), j) } 0 <= j && j < n && j < Seq#Length(s) ==> Seq#Index(Seq#Take(s, n), j) == Seq#Index(s, j));

function Seq#Drop<T>(s: Seq T, howMany: int) : Seq T;

axiom (forall<T> s: Seq T, n: int :: { Seq#Length(Seq#Drop(s, n)) } 0 <= n ==> (n <= Seq#Length(s) ==> Seq#Length(Seq#Drop(s, n)) == Seq#Length(s) - n) && (Seq#Length(s) < n ==> Seq#Length(Seq#Drop(s, n)) == 0));

axiom (forall<T> s: Seq T, n: int, j: int :: {:weight 25} { Seq#Index(Seq#Drop(s, n), j) } 0 <= n && 0 <= j && j < Seq#Length(s) - n ==> Seq#Index(Seq#Drop(s, n), j) == Seq#Index(s, j + n));

axiom (forall<T> s: Seq T, t: Seq T :: { Seq#Append(s, t) } Seq#Take(Seq#Append(s, t), Seq#Length(s)) == s && Seq#Drop(Seq#Append(s, t), Seq#Length(s)) == t);

function Seq#FromArray(h: HeapType, a: ref) : Seq BoxType;

axiom (forall h: HeapType, a: ref :: { Seq#Length(Seq#FromArray(h, a)) } Seq#Length(Seq#FromArray(h, a)) == _System.array.Length(a));

axiom (forall h: HeapType, a: ref :: { Seq#FromArray(h, a): Seq BoxType } (forall i: int :: 0 <= i && i < Seq#Length(Seq#FromArray(h, a)) ==> Seq#Index(Seq#FromArray(h, a), i) == read(h, a, IndexField(i))));

axiom (forall<alpha> h: HeapType, o: ref, f: Field alpha, v: alpha, a: ref :: { Seq#FromArray(update(h, o, f, v), a) } o != a ==> Seq#FromArray(update(h, o, f, v), a) == Seq#FromArray(h, a));

axiom (forall h: HeapType, i: int, v: BoxType, a: ref :: { Seq#FromArray(update(h, a, IndexField(i), v), a) } 0 <= i && i < _System.array.Length(a) ==> Seq#FromArray(update(h, a, IndexField(i), v), a) == Seq#Update(Seq#FromArray(h, a), i, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Take(Seq#Update(s, i, v), n) } 0 <= i && i < n && n <= Seq#Length(s) ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Update(Seq#Take(s, n), i, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Take(Seq#Update(s, i, v), n) } n <= i && i < Seq#Length(s) ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Take(s, n));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Drop(Seq#Update(s, i, v), n) } 0 <= n && n <= i && i < Seq#Length(s) ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Update(Seq#Drop(s, n), i - n, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Drop(Seq#Update(s, i, v), n) } 0 <= i && i < n && n < Seq#Length(s) ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Drop(s, n));

axiom (forall h: HeapType, a: ref, n0: int, n1: int :: { Seq#Take(Seq#FromArray(h, a), n0), Seq#Take(Seq#FromArray(h, a), n1) } n0 + 1 == n1 && 0 <= n0 && n1 <= _System.array.Length(a) ==> Seq#Take(Seq#FromArray(h, a), n1) == Seq#Build(Seq#Take(Seq#FromArray(h, a), n0), read(h, a, IndexField(n0): Field BoxType)));

axiom (forall<T> s: Seq T, v: T, n: int :: { Seq#Drop(Seq#Build(s, v), n) } 0 <= n && n <= Seq#Length(s) ==> Seq#Drop(Seq#Build(s, v), n) == Seq#Build(Seq#Drop(s, n), v));

function Seq#Rank<T>(Seq T) : int;

axiom (forall s: Seq BoxType, i: int :: { DtRank($Unbox(Seq#Index(s, i)): DatatypeType) } 0 <= i && i < Seq#Length(s) ==> DtRank($Unbox(Seq#Index(s, i)): DatatypeType) < Seq#Rank(s));

axiom (forall<T> s: Seq T, i: int :: { Seq#Rank(Seq#Drop(s, i)) } 0 < i && i <= Seq#Length(s) ==> Seq#Rank(Seq#Drop(s, i)) < Seq#Rank(s));

axiom (forall<T> s: Seq T, i: int :: { Seq#Rank(Seq#Take(s, i)) } 0 <= i && i < Seq#Length(s) ==> Seq#Rank(Seq#Take(s, i)) < Seq#Rank(s));

axiom (forall<T> s: Seq T, i: int, j: int :: { Seq#Rank(Seq#Append(Seq#Take(s, i), Seq#Drop(s, j))) } 0 <= i && i < j && j <= Seq#Length(s) ==> Seq#Rank(Seq#Append(Seq#Take(s, i), Seq#Drop(s, j))) < Seq#Rank(s));

axiom Seq#Take(Seq#Empty(): Seq BoxType, 0) == Seq#Empty();

axiom Seq#Drop(Seq#Empty(): Seq BoxType, 0) == Seq#Empty();

type Map _ _;

function Map#Domain<U,V>(Map U V) : [U]bool;

function Map#Elements<U,V>(Map U V) : [U]V;

function Map#Card<U,V>(Map U V) : int;

axiom (forall<U,V> m: Map U V :: { Map#Card(m) } 0 <= Map#Card(m));

function Map#Empty<U,V>() : Map U V;

axiom (forall<U,V> u: U :: { Map#Domain(Map#Empty(): Map U V)[u] } !Map#Domain(Map#Empty(): Map U V)[u]);

axiom (forall<U,V> m: Map U V :: { Map#Card(m) } Map#Card(m) == 0 <==> m == Map#Empty());

function Map#Glue<U,V>([U]bool, [U]V) : Map U V;

axiom (forall<U,V> a: [U]bool, b: [U]V :: { Map#Domain(Map#Glue(a, b)) } Map#Domain(Map#Glue(a, b)) == a);

axiom (forall<U,V> a: [U]bool, b: [U]V :: { Map#Elements(Map#Glue(a, b)) } Map#Elements(Map#Glue(a, b)) == b);

function Map#Build<U,V>(Map U V, U, V) : Map U V;

axiom (forall<U,V> m: Map U V, u: U, u': U, v: V :: { Map#Domain(Map#Build(m, u, v))[u'] } { Map#Elements(Map#Build(m, u, v))[u'] } (u' == u ==> Map#Domain(Map#Build(m, u, v))[u'] && Map#Elements(Map#Build(m, u, v))[u'] == v) && (u' != u ==> Map#Domain(Map#Build(m, u, v))[u'] == Map#Domain(m)[u'] && Map#Elements(Map#Build(m, u, v))[u'] == Map#Elements(m)[u']));

axiom (forall<U,V> m: Map U V, u: U, v: V :: { Map#Card(Map#Build(m, u, v)) } Map#Domain(m)[u] ==> Map#Card(Map#Build(m, u, v)) == Map#Card(m));

axiom (forall<U,V> m: Map U V, u: U, v: V :: { Map#Card(Map#Build(m, u, v)) } !Map#Domain(m)[u] ==> Map#Card(Map#Build(m, u, v)) == Map#Card(m) + 1);

function Map#Equal<U,V>(Map U V, Map U V) : bool;

axiom (forall<U,V> m: Map U V, m': Map U V :: { Map#Equal(m, m') } Map#Equal(m, m') <==> (forall u: U :: Map#Domain(m)[u] == Map#Domain(m')[u]) && (forall u: U :: Map#Domain(m)[u] ==> Map#Elements(m)[u] == Map#Elements(m')[u]));

axiom (forall<U,V> m: Map U V, m': Map U V :: { Map#Equal(m, m') } Map#Equal(m, m') ==> m == m');

function Map#Disjoint<U,V>(Map U V, Map U V) : bool;

axiom (forall<U,V> m: Map U V, m': Map U V :: { Map#Disjoint(m, m') } Map#Disjoint(m, m') <==> (forall o: U :: { Map#Domain(m)[o] } { Map#Domain(m')[o] } !Map#Domain(m)[o] || !Map#Domain(m')[o]));

type BoxType;

function $Box<T>(T) : BoxType;

function $Unbox<T>(BoxType) : T;

axiom (forall<T> x: T :: { $Box(x) } $Unbox($Box(x)) == x);

axiom (forall b: BoxType :: { $Unbox(b): int } $Box($Unbox(b): int) == b);

axiom (forall b: BoxType :: { $Unbox(b): ref } $Box($Unbox(b): ref) == b);

axiom (forall b: BoxType :: { $Unbox(b): Set BoxType } $Box($Unbox(b): Set BoxType) == b);

axiom (forall b: BoxType :: { $Unbox(b): Seq BoxType } $Box($Unbox(b): Seq BoxType) == b);

axiom (forall b: BoxType :: { $Unbox(b): Map BoxType BoxType } $Box($Unbox(b): Map BoxType BoxType) == b);

axiom (forall b: BoxType :: { $Unbox(b): DatatypeType } $Box($Unbox(b): DatatypeType) == b);

function $IsCanonicalBoolBox(BoxType) : bool;

axiom $IsCanonicalBoolBox($Box(false)) && $IsCanonicalBoolBox($Box(true));

axiom (forall b: BoxType :: { $Unbox(b): bool } $IsCanonicalBoolBox(b) ==> $Box($Unbox(b): bool) == b);

function $IsGoodSet_Extended<T>(s: Set BoxType, dummy: T) : bool;

axiom (forall<T> ss: Set BoxType, dummy: T, bx: BoxType :: { $IsGoodSet_Extended(ss, dummy), ss[bx] } $IsGoodSet_Extended(ss, dummy) ==> ss[bx] ==> bx == $Box($Unbox(bx): T));

function $IsGoodMultiSet_Extended<T>(ms: MultiSet BoxType, dummy: T) : bool;

axiom (forall<T> ms: MultiSet BoxType, dummy: T, bx: BoxType :: { $IsGoodMultiSet_Extended(ms, dummy), ms[bx] } $IsGoodMultiSet_Extended(ms, dummy) ==> 0 < ms[bx] ==> bx == $Box($Unbox(bx): T));

type ClassName;

const unique class._System.int: ClassName;

const unique class._System.bool: ClassName;

const unique class._System.set: ClassName;

const unique class._System.seq: ClassName;

const unique class._System.multiset: ClassName;

const unique class._System.array: ClassName;

function dtype(ref) : ClassName;

function TypeParams(ref, int) : ClassName;

function TypeTuple(a: ClassName, b: ClassName) : ClassName;

function TypeTupleCar(ClassName) : ClassName;

function TypeTupleCdr(ClassName) : ClassName;

axiom (forall a: ClassName, b: ClassName :: { TypeTuple(a, b) } TypeTupleCar(TypeTuple(a, b)) == a && TypeTupleCdr(TypeTuple(a, b)) == b);

type DatatypeType;

function DtType(DatatypeType) : ClassName;

function DtTypeParams(DatatypeType, int) : ClassName;

type DtCtorId;

function DatatypeCtorId(DatatypeType) : DtCtorId;

function DtRank(DatatypeType) : int;

const $ModuleContextHeight: int;

const $FunctionContextHeight: int;

type LayerType;

const $LZ: LayerType;

function $LS(LayerType) : LayerType;

type Field _;

function FDim<T>(Field T) : int;

function IndexField(int) : Field BoxType;

axiom (forall i: int :: { IndexField(i) } FDim(IndexField(i)) == 1);

function IndexField_Inverse<T>(Field T) : int;

axiom (forall i: int :: { IndexField(i) } IndexField_Inverse(IndexField(i)) == i);

function MultiIndexField(Field BoxType, int) : Field BoxType;

axiom (forall f: Field BoxType, i: int :: { MultiIndexField(f, i) } FDim(MultiIndexField(f, i)) == FDim(f) + 1);

function MultiIndexField_Inverse0<T>(Field T) : Field T;

function MultiIndexField_Inverse1<T>(Field T) : int;

axiom (forall f: Field BoxType, i: int :: { MultiIndexField(f, i) } MultiIndexField_Inverse0(MultiIndexField(f, i)) == f && MultiIndexField_Inverse1(MultiIndexField(f, i)) == i);

function DeclType<T>(Field T) : ClassName;

type NameFamily;

function DeclName<T>(Field T) : NameFamily;

function FieldOfDecl<alpha>(ClassName, NameFamily) : Field alpha;

axiom (forall<T> cl: ClassName, nm: NameFamily :: { FieldOfDecl(cl, nm): Field T } DeclType(FieldOfDecl(cl, nm): Field T) == cl && DeclName(FieldOfDecl(cl, nm): Field T) == nm);

function $IsGhostField<T>(Field T) : bool;

const unique alloc: Field bool;

axiom FDim(alloc) == 0 && !$IsGhostField(alloc);

function DtAlloc(DatatypeType, HeapType) : bool;

axiom (forall h: HeapType, k: HeapType, d: DatatypeType :: { $HeapSucc(h, k), DtAlloc(d, h) } { $HeapSucc(h, k), DtAlloc(d, k) } $HeapSucc(h, k) ==> DtAlloc(d, h) ==> DtAlloc(d, k));

function GenericAlloc(BoxType, HeapType) : bool;

axiom (forall h: HeapType, k: HeapType, d: BoxType :: { $HeapSucc(h, k), GenericAlloc(d, h) } { $HeapSucc(h, k), GenericAlloc(d, k) } $HeapSucc(h, k) ==> GenericAlloc(d, h) ==> GenericAlloc(d, k));

axiom (forall b: BoxType, h: HeapType :: { GenericAlloc(b, h), h[$Unbox(b): ref, alloc] } GenericAlloc(b, h) ==> $Unbox(b): ref == null || h[$Unbox(b): ref, alloc]);

axiom (forall b: BoxType, h: HeapType, i: int :: { GenericAlloc(b, h), Seq#Index($Unbox(b): Seq BoxType, i) } GenericAlloc(b, h) && 0 <= i && i < Seq#Length($Unbox(b): Seq BoxType) ==> GenericAlloc(Seq#Index($Unbox(b): Seq BoxType, i), h));

axiom (forall b: BoxType, h: HeapType, i: BoxType :: { GenericAlloc(b, h), Map#Domain($Unbox(b): Map BoxType BoxType)[i] } GenericAlloc(b, h) && Map#Domain($Unbox(b): Map BoxType BoxType)[i] ==> GenericAlloc(Map#Elements($Unbox(b): Map BoxType BoxType)[i], h));

axiom (forall b: BoxType, h: HeapType, t: BoxType :: { GenericAlloc(b, h), Map#Domain($Unbox(b): Map BoxType BoxType)[t] } GenericAlloc(b, h) && Map#Domain($Unbox(b): Map BoxType BoxType)[t] ==> GenericAlloc(t, h));

axiom (forall b: BoxType, h: HeapType, t: BoxType :: { GenericAlloc(b, h), ($Unbox(b): Set BoxType)[t] } GenericAlloc(b, h) && ($Unbox(b): Set BoxType)[t] ==> GenericAlloc(t, h));

axiom (forall b: BoxType, h: HeapType :: { GenericAlloc(b, h), DtType($Unbox(b): DatatypeType) } GenericAlloc(b, h) ==> DtAlloc($Unbox(b): DatatypeType, h));

axiom (forall b: bool, h: HeapType :: $IsGoodHeap(h) ==> GenericAlloc($Box(b), h));

axiom (forall x: int, h: HeapType :: $IsGoodHeap(h) ==> GenericAlloc($Box(x), h));

axiom (forall r: ref, h: HeapType :: { GenericAlloc($Box(r), h) } $IsGoodHeap(h) && (r == null || h[r, alloc]) ==> GenericAlloc($Box(r), h));

axiom (forall r: ref, f: Field BoxType, h: HeapType :: { GenericAlloc(read(h, r, f), h) } $IsGoodHeap(h) && r != null && read(h, r, alloc) ==> GenericAlloc(read(h, r, f), h));

function _System.array.Length(a: ref) : int;

axiom (forall o: ref :: 0 <= _System.array.Length(o));

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

axiom (forall<alpha> h: HeapType, r: ref, f: Field alpha, x: alpha :: { update(h, r, f, x) } $IsGoodHeap(update(h, r, f, x)) ==> $HeapSucc(h, update(h, r, f, x)));

axiom (forall a: HeapType, b: HeapType, c: HeapType :: { $HeapSucc(a, b), $HeapSucc(b, c) } $HeapSucc(a, b) && $HeapSucc(b, c) ==> $HeapSucc(a, c));

axiom (forall h: HeapType, k: HeapType :: { $HeapSucc(h, k) } $HeapSucc(h, k) ==> (forall o: ref :: { read(k, o, alloc) } read(h, o, alloc) ==> read(k, o, alloc)));

function $HeapSuccGhost(HeapType, HeapType) : bool;

axiom (forall h: HeapType, k: HeapType :: { $HeapSuccGhost(h, k) } $HeapSuccGhost(h, k) ==> $HeapSucc(h, k) && (forall<alpha> o: ref, f: Field alpha :: { read(k, o, f) } !$IsGhostField(f) ==> read(h, o, f) == read(k, o, f)));

type TickType;

var $Tick: TickType;

procedure $YieldHavoc(this: ref, rds: Set BoxType, nw: Set BoxType);
  modifies $Heap;
  ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> $o == this || rds[$Box($o)] || nw[$Box($o)] ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  ensures $HeapSucc(old($Heap), $Heap);



procedure $IterHavoc0(this: ref, rds: Set BoxType, modi: Set BoxType);
  modifies $Heap;
  ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> rds[$Box($o)] && !modi[$Box($o)] && $o != this ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  ensures $HeapSucc(old($Heap), $Heap);



procedure $IterHavoc1(this: ref, modi: Set BoxType, nw: Set BoxType);
  modifies $Heap;
  ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this || modi[$Box($o)] || nw[$Box($o)]);
  ensures $HeapSucc(old($Heap), $Heap);



procedure $IterCollectNewObjects(prevHeap: HeapType, newHeap: HeapType, this: ref, NW: Field (Set BoxType)) returns (s: Set BoxType);
  ensures (forall bx: BoxType :: { s[bx] } s[bx] <==> read(newHeap, this, NW)[bx] || ($Unbox(bx) != null && !read(prevHeap, $Unbox(bx): ref, alloc) && read(newHeap, $Unbox(bx): ref, alloc)));



const unique class._System.object: ClassName;

const unique class._module.Node: ClassName;

axiom FDim(_module.Node.next) == 0 && FieldOfDecl(class._module.Node, field$next) == _module.Node.next && !$IsGhostField(_module.Node.next);

const _module.Node.next: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, _module.Node.next) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, _module.Node.next) == null || (read($h, read($h, $o, _module.Node.next), alloc) && dtype(read($h, $o, _module.Node.next)) == class._module.Node));

// function declaration for _module.Node.IsClosed
function _module.Node.IsClosed($heap: HeapType, this: ref, S#0: Set BoxType) : bool;

function _module.Node.IsClosed#canCall($heap: HeapType, this: ref, S#0: Set BoxType) : bool;

// frame axiom for _module.Node.IsClosed
axiom (forall $h0: HeapType, $h1: HeapType, this: ref, S#0: Set BoxType :: { $HeapSucc($h0, $h1), _module.Node.IsClosed($h1, this, S#0) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class._module.Node && read($h1, this, alloc) && dtype(this) == class._module.Node && (_module.Node.IsClosed#canCall($h0, this, S#0) || (forall $t#0: BoxType :: { S#0[$t#0] } S#0[$t#0] ==> $Unbox($t#0): ref == null || (read($h0, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node))) && (_module.Node.IsClosed#canCall($h1, this, S#0) || (forall $t#1: BoxType :: { S#0[$t#1] } S#0[$t#1] ==> $Unbox($t#1): ref == null || (read($h1, $Unbox($t#1): ref, alloc) && dtype($Unbox($t#1): ref) == class._module.Node))) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && S#0[$Box($o)] ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> _module.Node.IsClosed($h0, this, S#0) == _module.Node.IsClosed($h1, this, S#0));

// consequence axiom for _module.Node.IsClosed
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && 0 <= $FunctionContextHeight) ==> (forall $Heap: HeapType, this: ref, S#0: Set BoxType :: { _module.Node.IsClosed($Heap, this, S#0) } _module.Node.IsClosed#canCall($Heap, this, S#0) || ((0 != $ModuleContextHeight || 0 != $FunctionContextHeight) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (forall $t#2: BoxType :: { S#0[$t#2] } S#0[$t#2] ==> $Unbox($t#2): ref == null || (read($Heap, $Unbox($t#2): ref, alloc) && dtype($Unbox($t#2): ref) == class._module.Node))) ==> true);

// definition axiom for _module.Node.IsClosed (intra-module)
axiom 0 == $ModuleContextHeight && 0 <= $FunctionContextHeight ==> (forall $Heap: HeapType, this: ref, S#0: Set BoxType :: { _module.Node.IsClosed($Heap, this, S#0) } _module.Node.IsClosed#canCall($Heap, this, S#0) || (0 != $FunctionContextHeight && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (forall $t#3: BoxType :: { S#0[$t#3] } S#0[$t#3] ==> $Unbox($t#3): ref == null || (read($Heap, $Unbox($t#3): ref, alloc) && dtype($Unbox($t#3): ref) == class._module.Node))) ==> (S#0[$Box(this)] ==> true) && (S#0[$Box(this)] && S#0[$Box(null)] ==> (forall n#1: ref :: n#1 == null || (read($Heap, n#1, alloc) && dtype(n#1) == class._module.Node) ==> (S#0[$Box(n#1)] ==> true) && (S#0[$Box(n#1)] && n#1 != null ==> true) && (S#0[$Box(n#1)] && n#1 != null && read($Heap, n#1, _module.Node.next) != null ==> true))) && _module.Node.IsClosed($Heap, this, S#0) == (S#0[$Box(this)] && S#0[$Box(null)] && (forall n#1: ref :: n#1 == null || (read($Heap, n#1, alloc) && dtype(n#1) == class._module.Node) ==> S#0[$Box(n#1)] && n#1 != null && read($Heap, n#1, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#1, _module.Node.next))])));

// definition axiom for _module.Node.IsClosed (foreign modules)
axiom 0 < $ModuleContextHeight ==> (forall $Heap: HeapType, this: ref, S#0: Set BoxType :: { _module.Node.IsClosed($Heap, this, S#0) } _module.Node.IsClosed#canCall($Heap, this, S#0) || ($IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (forall $t#4: BoxType :: { S#0[$t#4] } S#0[$t#4] ==> $Unbox($t#4): ref == null || (read($Heap, $Unbox($t#4): ref, alloc) && dtype($Unbox($t#4): ref) == class._module.Node))) ==> true);

procedure CheckWellformed$$_module.Node.IsClosed(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#5: BoxType :: { S#0[$t#5] } S#0[$t#5] ==> $Unbox($t#5): ref == null || (read($Heap, $Unbox($t#5): ref, alloc) && dtype($Unbox($t#5): ref) == class._module.Node)));
  free requires 0 == $ModuleContextHeight && 0 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.IsClosed(this: ref, S#0: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#2: ref;

    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(126,12): initial state"} true;
    if (*)
    {
        assume false;
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> S#0[$Box($o)]);
        if (S#0[$Box(this)])
        {
        }

        if (S#0[$Box(this)] && S#0[$Box(null)])
        {
            havoc n#2;
            assume n#2 == null || (read($Heap, n#2, alloc) && dtype(n#2) == class._module.Node);
            if (S#0[$Box(n#2)])
            {
            }

            if (S#0[$Box(n#2)] && n#2 != null)
            {
                assert n#2 != null;
                assert $_Frame[n#2, _module.Node.next];
            }

            if (S#0[$Box(n#2)] && n#2 != null && read($Heap, n#2, _module.Node.next) != null)
            {
                assert n#2 != null;
                assert $_Frame[n#2, _module.Node.next];
            }
        }

        assume _module.Node.IsClosed($Heap, this, S#0) == (S#0[$Box(this)] && S#0[$Box(null)] && (forall n#3: ref :: n#3 == null || (read($Heap, n#3, alloc) && dtype(n#3) == class._module.Node) ==> S#0[$Box(n#3)] && n#3 != null && read($Heap, n#3, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#3, _module.Node.next))]));
        assume (S#0[$Box(this)] ==> true) && (S#0[$Box(this)] && S#0[$Box(null)] ==> (forall n#3: ref :: n#3 == null || (read($Heap, n#3, alloc) && dtype(n#3) == class._module.Node) ==> (S#0[$Box(n#3)] ==> true) && (S#0[$Box(n#3)] && n#3 != null ==> true) && (S#0[$Box(n#3)] && n#3 != null && read($Heap, n#3, _module.Node.next) != null ==> true)));
    }
}



// function declaration for _module.Node.Nexxxt
function _module.Node.Nexxxt($ly: LayerType, $heap: HeapType, this: ref, k#0: int, S#1: Set BoxType) : ref;

function _module.Node.Nexxxt#canCall($heap: HeapType, this: ref, k#0: int, S#1: Set BoxType) : bool;

// layer synonym axiom
axiom (forall $ly: LayerType, $Heap: HeapType, this: ref, k#0: int, S#1: Set BoxType :: { _module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1) } _module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1) == _module.Node.Nexxxt($ly, $Heap, this, k#0, S#1));

// frame axiom for _module.Node.Nexxxt
axiom (forall $ly: LayerType, $h0: HeapType, $h1: HeapType, this: ref, k#0: int, S#1: Set BoxType :: { $HeapSucc($h0, $h1), _module.Node.Nexxxt($ly, $h1, this, k#0, S#1) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class._module.Node && read($h1, this, alloc) && dtype(this) == class._module.Node && (_module.Node.Nexxxt#canCall($h0, this, k#0, S#1) || (forall $t#6: BoxType :: { S#1[$t#6] } S#1[$t#6] ==> $Unbox($t#6): ref == null || (read($h0, $Unbox($t#6): ref, alloc) && dtype($Unbox($t#6): ref) == class._module.Node))) && (_module.Node.Nexxxt#canCall($h1, this, k#0, S#1) || (forall $t#7: BoxType :: { S#1[$t#7] } S#1[$t#7] ==> $Unbox($t#7): ref == null || (read($h1, $Unbox($t#7): ref, alloc) && dtype($Unbox($t#7): ref) == class._module.Node))) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && S#1[$Box($o)] ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> _module.Node.Nexxxt($ly, $h0, this, k#0, S#1) == _module.Node.Nexxxt($ly, $h1, this, k#0, S#1));

// consequence axiom for _module.Node.Nexxxt
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && 1 <= $FunctionContextHeight) ==> (forall $ly: LayerType, $Heap: HeapType, this: ref, k#0: int, S#1: Set BoxType :: { _module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1) } _module.Node.Nexxxt#canCall($Heap, this, k#0, S#1) || ((0 != $ModuleContextHeight || 1 != $FunctionContextHeight) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (forall $t#8: BoxType :: { S#1[$t#8] } S#1[$t#8] ==> $Unbox($t#8): ref == null || (read($Heap, $Unbox($t#8): ref, alloc) && dtype($Unbox($t#8): ref) == class._module.Node)) && _module.Node.IsClosed($Heap, this, S#1) && 0 <= k#0) ==> S#1[$Box(_module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1))] && (_module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1) == null || (read($Heap, _module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1), alloc) && dtype(_module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1)) == class._module.Node)));

// definition axiom for _module.Node.Nexxxt (intra-module)
axiom 0 == $ModuleContextHeight && 1 <= $FunctionContextHeight ==> (forall $ly: LayerType, $Heap: HeapType, this: ref, k#0: int, S#1: Set BoxType :: { _module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1) } _module.Node.Nexxxt#canCall($Heap, this, k#0, S#1) || (1 != $FunctionContextHeight && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (forall $t#9: BoxType :: { S#1[$t#9] } S#1[$t#9] ==> $Unbox($t#9): ref == null || (read($Heap, $Unbox($t#9): ref, alloc) && dtype($Unbox($t#9): ref) == class._module.Node)) && _module.Node.IsClosed($Heap, this, S#1) && 0 <= k#0) ==> (k#0 == 0 ==> true) && (k#0 != 0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#0 - 1, S#1) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, k#0 - 1, S#1) == null ==> true) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, k#0 - 1, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#0 - 1, S#1))) && _module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1) == (if k#0 == 0 then this else (if _module.Node.Nexxxt($ly, $Heap, this, k#0 - 1, S#1) == null then null else read($Heap, _module.Node.Nexxxt($ly, $Heap, this, k#0 - 1, S#1), _module.Node.next))));

// definition axiom for _module.Node.Nexxxt (foreign modules)
axiom 0 < $ModuleContextHeight ==> (forall $ly: LayerType, $Heap: HeapType, this: ref, k#0: int, S#1: Set BoxType :: { _module.Node.Nexxxt($LS($ly), $Heap, this, k#0, S#1) } _module.Node.Nexxxt#canCall($Heap, this, k#0, S#1) || ($IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (forall $t#10: BoxType :: { S#1[$t#10] } S#1[$t#10] ==> $Unbox($t#10): ref == null || (read($Heap, $Unbox($t#10): ref, alloc) && dtype($Unbox($t#10): ref) == class._module.Node)) && _module.Node.IsClosed($Heap, this, S#1) && 0 <= k#0) ==> true);

procedure CheckWellformed$$_module.Node.Nexxxt(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, k#0: int, S#1: Set BoxType where (forall $t#11: BoxType :: { S#1[$t#11] } S#1[$t#11] ==> $Unbox($t#11): ref == null || (read($Heap, $Unbox($t#11): ref, alloc) && dtype($Unbox($t#11): ref) == class._module.Node)));
  free requires 0 == $ModuleContextHeight && 1 == $FunctionContextHeight;
  modifies $Heap, $Tick;
  ensures S#1[$Box(_module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#0, S#1))];



implementation CheckWellformed$$_module.Node.Nexxxt(this: ref, k#0: int, S#1: Set BoxType)
{
  var S#2: Set BoxType;
  var k#3: int;
  var S#4: Set BoxType;
  var $_Frame: <beta>[ref,Field beta]bool;
  var k#5: int;
  var S#6: Set BoxType;
  var k#7: int;
  var S#8: Set BoxType;

    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(133,12): initial state"} true;
    S#2 := S#1;
    assume _module.Node.IsClosed#canCall($Heap, this, S#1);
    if (_module.Node.IsClosed($Heap, this, S#1))
    {
    }

    assume _module.Node.IsClosed($Heap, this, S#1) && 0 <= k#0;
    if (*)
    {
        assume _module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1) == null || (read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1), alloc) && dtype(_module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1)) == class._module.Node);
        k#3 := k#0;
        S#4 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#4) && 0 <= k#3;
        assert 0 <= k#0 || k#3 == k#0;
        assert (this == this && k#0 == k#0 && S#1 == S#1) || k#3 < k#0;
        assume (this == this && k#0 == k#0 && S#1 == S#1) || _module.Node.Nexxxt#canCall($Heap, this, k#0, S#1);
        assume S#1[$Box(_module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1))];
        assume false;
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> S#1[$Box($o)]);
        if (k#0 == 0)
        {
            assume _module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1) == this;
            assume true;
        }
        else
        {
            k#5 := k#0 - 1;
            S#6 := S#1;
            assert _module.Node.IsClosed($Heap, this, S#6) && 0 <= k#5;
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && S#6[$Box($o)] ==> $_Frame[$o, $f]);
            assert 0 <= k#0 || k#5 == k#0;
            assert k#5 < k#0;
            assume _module.Node.Nexxxt#canCall($Heap, this, k#0 - 1, S#1);
            if (_module.Node.Nexxxt($LS($LZ), $Heap, this, k#0 - 1, S#1) == null)
            {
                assume _module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1) == null;
                assume true;
            }
            else
            {
                k#7 := k#0 - 1;
                S#8 := S#1;
                assert _module.Node.IsClosed($Heap, this, S#8) && 0 <= k#7;
                assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && S#8[$Box($o)] ==> $_Frame[$o, $f]);
                assert 0 <= k#0 || k#7 == k#0;
                assert k#7 < k#0;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#0 - 1, S#1);
                assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#0 - 1, S#1) != null;
                assert $_Frame[_module.Node.Nexxxt($LS($LZ), $Heap, this, k#0 - 1, S#1), _module.Node.next];
                assume _module.Node.Nexxxt($LS($LZ), $Heap, this, k#0, S#1) == read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#0 - 1, S#1), _module.Node.next);
                assume _module.Node.Nexxxt#canCall($Heap, this, k#0 - 1, S#1);
            }
        }
    }
}



// function declaration for _module.Node.Reaches
function _module.Node.Reaches($ly: LayerType, $heap: HeapType, this: ref, sink#0: ref, S#1: Set BoxType) : bool;

function _module.Node.Reaches#canCall($heap: HeapType, this: ref, sink#0: ref, S#1: Set BoxType) : bool;

// layer synonym axiom
axiom (forall $ly: LayerType, $Heap: HeapType, this: ref, sink#0: ref, S#1: Set BoxType :: { _module.Node.Reaches($LS($ly), $Heap, this, sink#0, S#1) } _module.Node.Reaches($LS($ly), $Heap, this, sink#0, S#1) == _module.Node.Reaches($ly, $Heap, this, sink#0, S#1));

// frame axiom for _module.Node.Reaches
axiom (forall $ly: LayerType, $h0: HeapType, $h1: HeapType, this: ref, sink#0: ref, S#1: Set BoxType :: { $HeapSucc($h0, $h1), _module.Node.Reaches($ly, $h1, this, sink#0, S#1) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class._module.Node && read($h1, this, alloc) && dtype(this) == class._module.Node && (_module.Node.Reaches#canCall($h0, this, sink#0, S#1) || ((sink#0 == null || (read($h0, sink#0, alloc) && dtype(sink#0) == class._module.Node)) && (forall $t#12: BoxType :: { S#1[$t#12] } S#1[$t#12] ==> $Unbox($t#12): ref == null || (read($h0, $Unbox($t#12): ref, alloc) && dtype($Unbox($t#12): ref) == class._module.Node)))) && (_module.Node.Reaches#canCall($h1, this, sink#0, S#1) || ((sink#0 == null || (read($h1, sink#0, alloc) && dtype(sink#0) == class._module.Node)) && (forall $t#13: BoxType :: { S#1[$t#13] } S#1[$t#13] ==> $Unbox($t#13): ref == null || (read($h1, $Unbox($t#13): ref, alloc) && dtype($Unbox($t#13): ref) == class._module.Node)))) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && S#1[$Box($o)] ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> _module.Node.Reaches($ly, $h0, this, sink#0, S#1) == _module.Node.Reaches($ly, $h1, this, sink#0, S#1));

// consequence axiom for _module.Node.Reaches
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && 2 <= $FunctionContextHeight) ==> (forall $ly: LayerType, $Heap: HeapType, this: ref, sink#0: ref, S#1: Set BoxType :: { _module.Node.Reaches($LS($ly), $Heap, this, sink#0, S#1) } _module.Node.Reaches#canCall($Heap, this, sink#0, S#1) || ((0 != $ModuleContextHeight || 2 != $FunctionContextHeight) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (sink#0 == null || (read($Heap, sink#0, alloc) && dtype(sink#0) == class._module.Node)) && (forall $t#14: BoxType :: { S#1[$t#14] } S#1[$t#14] ==> $Unbox($t#14): ref == null || (read($Heap, $Unbox($t#14): ref, alloc) && dtype($Unbox($t#14): ref) == class._module.Node)) && _module.Node.IsClosed($Heap, this, S#1)) ==> _module.Node.Reaches($LS($LZ), $Heap, this, sink#0, S#1) ==> S#1[$Box(sink#0)]);

// definition axiom for _module.Node.Reaches (intra-module)
axiom 0 == $ModuleContextHeight && 2 <= $FunctionContextHeight ==> (forall $ly: LayerType, $Heap: HeapType, this: ref, sink#0: ref, S#1: Set BoxType :: { _module.Node.Reaches($LS($ly), $Heap, this, sink#0, S#1) } _module.Node.Reaches#canCall($Heap, this, sink#0, S#1) || (2 != $FunctionContextHeight && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (sink#0 == null || (read($Heap, sink#0, alloc) && dtype(sink#0) == class._module.Node)) && (forall $t#15: BoxType :: { S#1[$t#15] } S#1[$t#15] ==> $Unbox($t#15): ref == null || (read($Heap, $Unbox($t#15): ref, alloc) && dtype($Unbox($t#15): ref) == class._module.Node)) && _module.Node.IsClosed($Heap, this, S#1)) ==> (forall k#2: int :: true ==> 0 <= k#2 ==> _module.Node.Nexxxt#canCall($Heap, this, k#2, S#1)) && _module.Node.Reaches($LS($ly), $Heap, this, sink#0, S#1) == (exists k#2: int :: 0 <= k#2 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#2, S#1) == sink#0));

// definition axiom for _module.Node.Reaches (foreign modules)
axiom 0 < $ModuleContextHeight ==> (forall $ly: LayerType, $Heap: HeapType, this: ref, sink#0: ref, S#1: Set BoxType :: { _module.Node.Reaches($LS($ly), $Heap, this, sink#0, S#1) } _module.Node.Reaches#canCall($Heap, this, sink#0, S#1) || ($IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node && (sink#0 == null || (read($Heap, sink#0, alloc) && dtype(sink#0) == class._module.Node)) && (forall $t#16: BoxType :: { S#1[$t#16] } S#1[$t#16] ==> $Unbox($t#16): ref == null || (read($Heap, $Unbox($t#16): ref, alloc) && dtype($Unbox($t#16): ref) == class._module.Node)) && _module.Node.IsClosed($Heap, this, S#1)) ==> true);

procedure CheckWellformed$$_module.Node.Reaches(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, sink#0: ref where sink#0 == null || (read($Heap, sink#0, alloc) && dtype(sink#0) == class._module.Node), S#1: Set BoxType where (forall $t#17: BoxType :: { S#1[$t#17] } S#1[$t#17] ==> $Unbox($t#17): ref == null || (read($Heap, $Unbox($t#17): ref, alloc) && dtype($Unbox($t#17): ref) == class._module.Node)));
  free requires 0 == $ModuleContextHeight && 2 == $FunctionContextHeight;
  modifies $Heap, $Tick;
  ensures _module.Node.Reaches($LS($LZ), $Heap, this, sink#0, S#1) ==> S#1[$Box(sink#0)];



implementation CheckWellformed$$_module.Node.Reaches(this: ref, sink#0: ref, S#1: Set BoxType)
{
  var S#3: Set BoxType;
  var sink#4: ref;
  var S#5: Set BoxType;
  var $_Frame: <beta>[ref,Field beta]bool;
  var k#6: int;
  var k#7: int;
  var S#8: Set BoxType;

    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(144,12): initial state"} true;
    S#3 := S#1;
    assume _module.Node.IsClosed#canCall($Heap, this, S#1);
    assume _module.Node.IsClosed($Heap, this, S#1);
    if (*)
    {
        sink#4 := sink#0;
        S#5 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#5);
        assert (this == this && sink#0 == sink#0 && S#1 == S#1) || (Set#Subset(S#5, S#1) && !Set#Subset(S#1, S#5)) || (Set#Equal(S#5, S#1) && ((sink#4 == null && sink#0 != null) || ((sink#4 != null <==> sink#0 != null) && Set#Subset(S#5, S#1) && !Set#Subset(S#1, S#5))));
        assume (this == this && sink#0 == sink#0 && S#1 == S#1) || _module.Node.Reaches#canCall($Heap, this, sink#0, S#1);
        if (_module.Node.Reaches($LS($LZ), $Heap, this, sink#0, S#1))
        {
        }

        assume _module.Node.Reaches($LS($LZ), $Heap, this, sink#0, S#1) ==> S#1[$Box(sink#0)];
        assume false;
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> S#1[$Box($o)]);
        havoc k#6;
        if (0 <= k#6)
        {
            k#7 := k#6;
            S#8 := S#1;
            assert _module.Node.IsClosed($Heap, this, S#8) && 0 <= k#7;
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && S#8[$Box($o)] ==> $_Frame[$o, $f]);
            assume _module.Node.Nexxxt#canCall($Heap, this, k#6, S#1);
        }

        assume _module.Node.Reaches($LS($LZ), $Heap, this, sink#0, S#1) == (exists k#9: int :: 0 <= k#9 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#9, S#1) == sink#0);
        assume (forall k#9: int :: true ==> 0 <= k#9 ==> _module.Node.Nexxxt#canCall($Heap, this, k#9, S#1));
    }
}



procedure CheckWellformed$$_module.Node.Cyclic(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#18: BoxType :: { S#0[$t#18] } S#0[$t#18] ==> $Unbox($t#18): ref == null || (read($Heap, $Unbox($t#18): ref, alloc) && dtype($Unbox($t#18): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (reachesCycle#1: bool);
  free requires 0 == $ModuleContextHeight && 12 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Cyclic(this: ref, S#0: Set BoxType) returns (reachesCycle#1: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#2: Set BoxType;
  var n#3: ref;
  var sink#4: ref;
  var S#5: Set BoxType;
  var sink#6: ref;
  var S#7: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(152,10): initial state"} true;
    S#2 := S#0;
    assume _module.Node.IsClosed#canCall($Heap, this, S#0);
    assume _module.Node.IsClosed($Heap, this, S#0);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    havoc reachesCycle#1;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(154,26): post-state"} true;
    havoc n#3;
    assume n#3 == null || (read($Heap, n#3, alloc) && dtype(n#3) == class._module.Node);
    if (n#3 != null)
    {
        sink#4 := n#3;
        S#5 := S#0;
        assert _module.Node.IsClosed($Heap, this, S#5);
        assume _module.Node.Reaches#canCall($Heap, this, n#3, S#0);
    }

    if (n#3 != null && _module.Node.Reaches($LS($LZ), $Heap, this, n#3, S#0))
    {
        assert n#3 != null;
    }

    if (n#3 != null && _module.Node.Reaches($LS($LZ), $Heap, this, n#3, S#0) && read($Heap, n#3, _module.Node.next) != null)
    {
        assert n#3 != null;
        assert read($Heap, n#3, _module.Node.next) != null;
        sink#6 := n#3;
        S#7 := S#0;
        assert _module.Node.IsClosed($Heap, read($Heap, n#3, _module.Node.next), S#7);
        assume _module.Node.Reaches#canCall($Heap, read($Heap, n#3, _module.Node.next), n#3, S#0);
    }

    assume reachesCycle#1 <==> (exists n#8: ref :: (n#8 == null || (read($Heap, n#8, alloc) && dtype(n#8) == class._module.Node)) && n#8 != null && _module.Node.Reaches($LS($LZ), $Heap, this, n#8, S#0) && read($Heap, n#8, _module.Node.next) != null && _module.Node.Reaches($LS($LZ), $Heap, read($Heap, n#8, _module.Node.next), n#8, S#0));
}



procedure InterModuleCall$$_module.Node.Cyclic(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#0: BoxType :: { S#0[$t#0] } S#0[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (reachesCycle#1: bool);
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#0);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures reachesCycle#1 <==> (exists n#8: ref :: (n#8 == null || (read($Heap, n#8, alloc) && dtype(n#8) == class._module.Node)) && n#8 != null && _module.Node.Reaches($LS($LS($LZ)), $Heap, this, n#8, S#0) && read($Heap, n#8, _module.Node.next) != null && _module.Node.Reaches($LS($LS($LZ)), $Heap, read($Heap, n#8, _module.Node.next), n#8, S#0));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



procedure IntraModuleCall$$_module.Node.Cyclic(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#1: BoxType :: { S#0[$t#1] } S#0[$t#1] ==> $Unbox($t#1): ref == null || (read($Heap, $Unbox($t#1): ref, alloc) && dtype($Unbox($t#1): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (reachesCycle#1: bool);
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || (forall n#9: ref :: n#9 == null || (read($Heap, n#9, alloc) && dtype(n#9) == class._module.Node) ==> S#0[$Box(n#9)] && n#9 != null && read($Heap, n#9, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#9, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#0) && _module.Node.IsClosed($Heap, this, S#0) && S#0[$Box(this)] && S#0[$Box(null)] && (forall n#10: ref :: n#10 == null || (read($Heap, n#10, alloc) && dtype(n#10) == class._module.Node) ==> S#0[$Box(n#10)] && n#10 != null && read($Heap, n#10, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#10, _module.Node.next))]);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures reachesCycle#1 <==> (exists n#8: ref :: (n#8 == null || (read($Heap, n#8, alloc) && dtype(n#8) == class._module.Node)) && n#8 != null && _module.Node.Reaches($LS($LS($LZ)), $Heap, this, n#8, S#0) && read($Heap, n#8, _module.Node.next) != null && _module.Node.Reaches($LS($LS($LZ)), $Heap, read($Heap, n#8, _module.Node.next), n#8, S#0));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



procedure Impl$$_module.Node.Cyclic(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#2: BoxType :: { S#0[$t#2] } S#0[$t#2] ==> $Unbox($t#2): ref == null || (read($Heap, $Unbox($t#2): ref, alloc) && dtype($Unbox($t#2): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (reachesCycle#1: bool, $_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 12 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || (forall n#11: ref :: n#11 == null || (read($Heap, n#11, alloc) && dtype(n#11) == class._module.Node) ==> S#0[$Box(n#11)] && n#11 != null && read($Heap, n#11, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#11, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#0) && _module.Node.IsClosed($Heap, this, S#0) && S#0[$Box(this)] && S#0[$Box(null)] && (forall n#12: ref :: n#12 == null || (read($Heap, n#12, alloc) && dtype(n#12) == class._module.Node) ==> S#0[$Box(n#12)] && n#12 != null && read($Heap, n#12, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#12, _module.Node.next))]);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures reachesCycle#1 <==> (exists n#8: ref :: (n#8 == null || (read($Heap, n#8, alloc) && dtype(n#8) == class._module.Node)) && n#8 != null && _module.Node.Reaches($LS($LS($LZ)), $Heap, this, n#8, S#0) && read($Heap, n#8, _module.Node.next) != null && _module.Node.Reaches($LS($LS($LZ)), $Heap, read($Heap, n#8, _module.Node.next), n#8, S#0));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Impl$$_module.Node.Cyclic(this: ref, S#0: Set BoxType) returns (reachesCycle#1: bool, $_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var A#13: int;
  var B#14: int;
  var $rhs##3: int;
  var $rhs##4: int;
  var S##15: Set BoxType;
  var tortoise#16: ref where tortoise#16 == null || (read($Heap, tortoise#16, alloc) && dtype(tortoise#16) == class._module.Node);
  var hare#17: ref where hare#17 == null || (read($Heap, hare#17, alloc) && dtype(hare#17) == class._module.Node);
  var $rhs#5: ref;
  var $rhs#6: ref;
  var t#18: int;
  var h#19: int;
  var $rhs#7: int;
  var $rhs#8: int;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: int;
  var $w0: bool;
  var k#20: int;
  var S#21: Set BoxType;
  var k#22: int;
  var S#23: Set BoxType;
  var k#24: int;
  var k#25: int;
  var S#26: Set BoxType;
  var k#27: int;
  var S#28: Set BoxType;
  var $decr0$0: int;
  var distanceToNull#31: int;
  var n##32: int;
  var S##33: Set BoxType;
  var k#34: int;
  var l#35: int;
  var k#36: int;
  var S#37: Set BoxType;
  var k#38: int;
  var S#39: Set BoxType;
  var k#40: int;
  var S#41: Set BoxType;
  var k#42: int;
  var S#43: Set BoxType;
  var k#44: int;
  var S#45: Set BoxType;
  var d##50: int;
  var S##51: Set BoxType;
  var k#52: int;
  var S#53: Set BoxType;
  var $rhs#12: ref;
  var $rhs#13: int;
  var $rhs#14: ref;
  var $rhs#15: int;
  var a##54: int;
  var b##55: int;
  var S##56: Set BoxType;
  var d##57: int;
  var S##58: Set BoxType;
  var x##59: int;
  var y##60: int;
  var S##61: Set BoxType;
  var sink#62: ref;
  var S#63: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(152,10): initial state"} true;
    $_reverifyPost := false;
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(156,15)
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(156,18)
    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(156,23)
    assume true;
    assume true;
    assume true;
    S##15 := S#0;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call $rhs##3, $rhs##4 := IntraModuleCall$$_module.Node.AnalyzeList(this, S##15);
    A#13 := $rhs##3;
    B#14 := $rhs##4;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(156,23)"} true;
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(157,9)
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(157,19)
    // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(157,23)
    assume true;
    assume true;
    assume true;
    $rhs#5 := this;
    assume true;
    $rhs#6 := read($Heap, this, _module.Node.next);
    tortoise#16 := $rhs#5;
    hare#17 := $rhs#6;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(157,23)"} true;
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(158,15)
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(158,18)
    // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(158,20)
    assume true;
    assume true;
    assume true;
    $rhs#7 := Lit(0);
    assume true;
    $rhs#8 := Lit(1);
    t#18 := $rhs#7;
    h#19 := $rhs#8;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(158,20)"} true;
    // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(159,5)
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := A#13 + B#14 - t#18;
    havoc $w0;
    while (true)
      free invariant $w0 ==> (tortoise#16 != null ==> true) && (tortoise#16 != null && S#0[$Box(tortoise#16)] ==> true);
      invariant $w0 ==> tortoise#16 != null;
      invariant $w0 ==> S#0[$Box(tortoise#16)];
      invariant $w0 ==> S#0[$Box(hare#17)];
      free invariant $w0 ==> (0 <= t#18 ==> true) && (0 <= t#18 && t#18 < h#19 ==> _module.Node.Nexxxt#canCall($Heap, this, t#18, S#0)) && (0 <= t#18 && t#18 < h#19 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#18, S#0) == tortoise#16 ==> _module.Node.Nexxxt#canCall($Heap, this, h#19, S#0));
      invariant $w0 ==> 0 <= t#18;
      invariant $w0 ==> t#18 < h#19;
      invariant $w0 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, t#18, S#0) == tortoise#16;
      invariant $w0 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, h#19, S#0) == hare#17;
      free invariant $w0 ==> h#19 == 1 + 2 * t#18 ==> true;
      invariant $w0 ==> h#19 == 1 + 2 * t#18;
      invariant $w0 ==> t#18 <= A#13 + B#14;
      free invariant $w0 ==> (forall k#29: int :: true ==> (0 <= k#29 ==> true) && (0 <= k#29 && k#29 < t#18 ==> _module.Node.Nexxxt#canCall($Heap, this, k#29, S#0) && _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * k#29, S#0)));
      invariant $w0 ==> (forall k#29: int :: (forall k$ih#9#30: int :: true ==> 0 <= k$ih#9#30 && k$ih#9#30 < k#29 ==> 0 <= k$ih#9#30 && k$ih#9#30 < t#18 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#9#30, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * k$ih#9#30, S#0)) && true ==> 0 <= k#29 && k#29 < t#18 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#29, S#0) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, 1 + 2 * k#29, S#0));
      free invariant $w0 ==> (forall k#29: int :: true ==> 0 <= k#29 && k#29 < t#18 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#29, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * k#29, S#0));
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f));
      free invariant $HeapSucc($PreLoopHeap0, $Heap);
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
      free invariant A#13 + B#14 - t#18 <= $decr0$init$0 && (A#13 + B#14 - t#18 == $decr0$init$0 ==> true);
    {
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(159,5): after some loop iterations"} true;
        if (!$w0)
        {
            if (tortoise#16 != null)
            {
            }

            if (tortoise#16 != null && S#0[$Box(tortoise#16)])
            {
            }

            assume (tortoise#16 != null ==> true) && (tortoise#16 != null && S#0[$Box(tortoise#16)] ==> true);
            assume tortoise#16 != null && S#0[$Box(tortoise#16)] && S#0[$Box(hare#17)];
            if (0 <= t#18)
            {
            }

            if (0 <= t#18 && t#18 < h#19)
            {
                k#20 := t#18;
                S#21 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#21) && 0 <= k#20;
                assume _module.Node.Nexxxt#canCall($Heap, this, t#18, S#0);
            }

            if (0 <= t#18 && t#18 < h#19 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#18, S#0) == tortoise#16)
            {
                k#22 := h#19;
                S#23 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#23) && 0 <= k#22;
                assume _module.Node.Nexxxt#canCall($Heap, this, h#19, S#0);
            }

            assume (0 <= t#18 ==> true) && (0 <= t#18 && t#18 < h#19 ==> _module.Node.Nexxxt#canCall($Heap, this, t#18, S#0)) && (0 <= t#18 && t#18 < h#19 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#18, S#0) == tortoise#16 ==> _module.Node.Nexxxt#canCall($Heap, this, h#19, S#0));
            assume 0 <= t#18 && t#18 < h#19 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#18, S#0) == tortoise#16 && _module.Node.Nexxxt($LS($LZ), $Heap, this, h#19, S#0) == hare#17;
            if (h#19 == 1 + 2 * t#18)
            {
            }

            assume h#19 == 1 + 2 * t#18 ==> true;
            assume h#19 == 1 + 2 * t#18 && t#18 <= A#13 + B#14;
            havoc k#24;
            if (0 <= k#24)
            {
            }

            if (0 <= k#24 && k#24 < t#18)
            {
                k#25 := k#24;
                S#26 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#26) && 0 <= k#25;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#24, S#0);
                k#27 := 1 + 2 * k#24;
                S#28 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#28) && 0 <= k#27;
                assume _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * k#24, S#0);
            }

            assume (forall k#29: int :: true ==> (0 <= k#29 ==> true) && (0 <= k#29 && k#29 < t#18 ==> _module.Node.Nexxxt#canCall($Heap, this, k#29, S#0) && _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * k#29, S#0)));
            assume (forall k#29: int :: true ==> 0 <= k#29 && k#29 < t#18 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#29, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * k#29, S#0));
            assume true;
            assume false;
        }

        assume true;
        if (hare#17 == tortoise#16)
        {
            break;
        }

        $decr0$0 := A#13 + B#14 - t#18;
        // ----- if statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(167,7)
        if (hare#17 != null)
        {
            assert hare#17 != null;
        }

        assume hare#17 != null ==> true;
        if (hare#17 == null || read($Heap, hare#17, _module.Node.next) == null)
        {
            // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(168,19)
            // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(168,34)
            assume true;
            if (hare#17 == null)
            {
            }
            else
            {
            }

            assume (hare#17 == null ==> true) && (hare#17 != null ==> true);
            distanceToNull#31 := (if hare#17 == null then h#19 else h#19 + 1);
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(168,34)"} true;
            // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(169,9)
            assume true;
            n##32 := distanceToNull#31;
            assume true;
            S##33 := S#0;
            assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
            call IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles(this, n##32, S##33);
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(169,9)"} true;
            // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(170,9)
            havoc k#34;
            havoc l#35;
            if (0 <= k#34)
            {
            }

            if (0 <= k#34 && 0 <= l#35)
            {
                k#36 := k#34;
                S#37 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#37) && 0 <= k#36;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#34, S#0);
            }

            if (0 <= k#34 && 0 <= l#35 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0) != null)
            {
                k#38 := k#34;
                S#39 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#39) && 0 <= k#38;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#34, S#0);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0) != null;
            }

            if (0 <= k#34 && 0 <= l#35 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0), _module.Node.next) != null)
            {
                k#40 := k#34;
                S#41 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#41) && 0 <= k#40;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#34, S#0);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0) != null;
                assert {:subsumption 0} read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0), _module.Node.next) != null;
                k#42 := l#35;
                S#43 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0), _module.Node.next), S#43) && 0 <= k#42;
                assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#34, S#0), _module.Node.next), l#35, S#0);
                k#44 := k#34;
                S#45 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#45) && 0 <= k#44;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#34, S#0);
            }

            assume (forall k#46: int, l#47: int :: true ==> (0 <= k#46 ==> true) && (0 <= k#46 && 0 <= l#47 ==> _module.Node.Nexxxt#canCall($Heap, this, k#46, S#0)) && (0 <= k#46 && 0 <= l#47 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#46, S#0)) && (0 <= k#46 && 0 <= l#47 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#46, S#0) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0), _module.Node.next), l#47, S#0) && _module.Node.Nexxxt#canCall($Heap, this, k#46, S#0)));
            assert {:subsumption 0} !(exists k#46: int, l#47: int :: (forall k$ih#10#48: int, l$ih#11#49: int :: true ==> (0 <= k$ih#10#48 && k$ih#10#48 < k#46) || (k$ih#10#48 == k#46 && 0 <= l$ih#11#49 && l$ih#11#49 < l#47) ==> !(0 <= k$ih#10#48 && 0 <= l$ih#11#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#10#48, S#0) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#10#48, S#0), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#10#48, S#0), _module.Node.next), l$ih#11#49, S#0) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#10#48, S#0))) && true && 0 <= k#46 && 0 <= l#47 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#46, S#0) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#46, S#0), _module.Node.next) != null && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#46, S#0), _module.Node.next), l#47, S#0) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#46, S#0));
            assume !(exists k#46: int, l#47: int :: 0 <= k#46 && 0 <= l#47 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0), _module.Node.next), l#47, S#0) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#46, S#0));
            // ----- return statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(171,9)
            // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(171,9)
            assume true;
            assume true;
            reachesCycle#1 := Lit(false);
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(171,9)"} true;
            return;
        }
        else
        {
        }

        // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(173,7)
        assume true;
        d##50 := h#19 + 1;
        assume true;
        S##51 := S#0;
        assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
        call IntraModuleCall$$_module.Node.Lemma__NullIsTerminal(this, d##50, S##51);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(173,7)"} true;
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(174,7)
        k#52 := t#18 + 1;
        S#53 := S#0;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#53) && 0 <= k#52;
        assume _module.Node.Nexxxt#canCall($Heap, this, t#18 + 1, S#0);
        assume _module.Node.Nexxxt#canCall($Heap, this, t#18 + 1, S#0);
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, t#18 + 1, S#0) != null;
        assume _module.Node.Nexxxt($LS($LZ), $Heap, this, t#18 + 1, S#0) != null;
        // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(175,28)
        assume true;
        assume true;
        assume true;
        assume true;
        assert tortoise#16 != null;
        assume true;
        $rhs#12 := read($Heap, tortoise#16, _module.Node.next);
        assume true;
        $rhs#13 := t#18 + 1;
        assert hare#17 != null;
        assert read($Heap, hare#17, _module.Node.next) != null;
        assume true;
        $rhs#14 := read($Heap, read($Heap, hare#17, _module.Node.next), _module.Node.next);
        assume true;
        $rhs#15 := h#19 + 2;
        tortoise#16 := $rhs#12;
        t#18 := $rhs#13;
        hare#17 := $rhs#14;
        h#19 := $rhs#15;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(175,28)"} true;
        // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(176,7)
        assume true;
        a##54 := A#13;
        assume true;
        b##55 := B#14;
        assume true;
        S##56 := S#0;
        assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
        call IntraModuleCall$$_module.Node.CrucialLemma(this, a##54, b##55, S##56);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(176,7)"} true;
        assert 0 <= $decr0$0 || A#13 + B#14 - t#18 == $decr0$0;
        assert A#13 + B#14 - t#18 < $decr0$0;
        assume (tortoise#16 != null ==> true) && (tortoise#16 != null && S#0[$Box(tortoise#16)] ==> true);
        assume (0 <= t#18 ==> true) && (0 <= t#18 && t#18 < h#19 ==> _module.Node.Nexxxt#canCall($Heap, this, t#18, S#0)) && (0 <= t#18 && t#18 < h#19 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#18, S#0) == tortoise#16 ==> _module.Node.Nexxxt#canCall($Heap, this, h#19, S#0));
        assume h#19 == 1 + 2 * t#18 ==> true;
        assume (forall k#29: int :: true ==> (0 <= k#29 ==> true) && (0 <= k#29 && k#29 < t#18 ==> _module.Node.Nexxxt#canCall($Heap, this, k#29, S#0) && _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * k#29, S#0)));
    }

    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(178,5)
    assume true;
    d##57 := h#19;
    assume true;
    S##58 := S#0;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call IntraModuleCall$$_module.Node.Lemma__NullIsTerminal(this, d##57, S##58);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(178,5)"} true;
    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(179,5)
    assume true;
    x##59 := t#18 + 1;
    assume true;
    y##60 := h#19 - (t#18 + 1);
    assume true;
    S##61 := S#0;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this, x##59, y##60, S##61);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(179,5)"} true;
    // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(180,5)
    assert {:subsumption 0} tortoise#16 != null;
    assert {:subsumption 0} read($Heap, tortoise#16, _module.Node.next) != null;
    sink#62 := tortoise#16;
    S#63 := S#0;
    assert {:subsumption 0} _module.Node.IsClosed($Heap, read($Heap, tortoise#16, _module.Node.next), S#63);
    assume _module.Node.Reaches#canCall($Heap, read($Heap, tortoise#16, _module.Node.next), tortoise#16, S#0);
    assume _module.Node.Reaches#canCall($Heap, read($Heap, tortoise#16, _module.Node.next), tortoise#16, S#0);
    assert {:subsumption 0} _module.Node.Reaches#canCall($Heap, read($Heap, tortoise#16, _module.Node.next), tortoise#16, S#0) ==> _module.Node.Reaches($LS($LZ), $Heap, read($Heap, tortoise#16, _module.Node.next), tortoise#16, S#0) || (exists k#64: int :: 0 <= k#64 && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, tortoise#16, _module.Node.next), k#64, S#0) == tortoise#16);
    assume _module.Node.Reaches($LS($LZ), $Heap, read($Heap, tortoise#16, _module.Node.next), tortoise#16, S#0);
    // ----- return statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(181,5)
    // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(181,5)
    assume true;
    assume true;
    reachesCycle#1 := Lit(true);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(181,5)"} true;
    return;
}



procedure CheckWellformed$$_module.Node.AnalyzeList(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#0: BoxType :: { S#0[$t#0] } S#0[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (A#1: int, B#2: int);
  free requires 0 == $ModuleContextHeight && 4 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.AnalyzeList(this: ref, S#0: Set BoxType) returns (A#1: int, B#2: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#3: Set BoxType;
  var k#4: int;
  var l#5: int;
  var k#6: int;
  var S#7: Set BoxType;
  var k#8: int;
  var S#9: Set BoxType;
  var k#12: int;
  var S#13: Set BoxType;
  var k#14: int;
  var S#15: Set BoxType;
  var k#16: int;
  var S#17: Set BoxType;
  var k#18: int;
  var S#19: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(189,16): initial state"} true;
    S#3 := S#0;
    assume _module.Node.IsClosed#canCall($Heap, this, S#0);
    assume _module.Node.IsClosed($Heap, this, S#0);
    havoc $Heap;
    assume old($Heap) == $Heap;
    havoc A#1, B#2;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(194,20): post-state"} true;
    if (0 <= A#1)
    {
    }

    assume 0 <= A#1 && 1 <= B#2;
    havoc k#4;
    havoc l#5;
    if (0 <= k#4)
    {
    }

    if (0 <= k#4 && k#4 < l#5)
    {
    }

    if (0 <= k#4 && k#4 < l#5 && l#5 < A#1)
    {
        k#6 := k#4;
        S#7 := S#0;
        assert _module.Node.IsClosed($Heap, this, S#7) && 0 <= k#6;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#4, S#0);
        k#8 := l#5;
        S#9 := S#0;
        assert _module.Node.IsClosed($Heap, this, S#9) && 0 <= k#8;
        assume _module.Node.Nexxxt#canCall($Heap, this, l#5, S#0);
    }

    assume (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#0));
    k#12 := A#1;
    S#13 := S#0;
    assert _module.Node.IsClosed($Heap, this, S#13) && 0 <= k#12;
    assume _module.Node.Nexxxt#canCall($Heap, this, A#1, S#0);
    if (_module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0) != null)
    {
        k#14 := A#1;
        S#15 := S#0;
        assert _module.Node.IsClosed($Heap, this, S#15) && 0 <= k#14;
        assume _module.Node.Nexxxt#canCall($Heap, this, A#1, S#0);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0) != null;
        k#16 := B#2;
        S#17 := S#0;
        assert _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0), S#17) && 0 <= k#16;
        assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0), B#2, S#0);
        k#18 := A#1;
        S#19 := S#0;
        assert _module.Node.IsClosed($Heap, this, S#19) && 0 <= k#18;
        assume _module.Node.Nexxxt#canCall($Heap, this, A#1, S#0);
    }

    assume _module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0) == null || _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0), B#2, S#0) == _module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0);
}



procedure InterModuleCall$$_module.Node.AnalyzeList(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#0: BoxType :: { S#0[$t#0] } S#0[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (A#1: int, B#2: int);
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#0);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures 0 <= A#1;
  ensures 1 <= B#2;
  ensures (forall k#10: int, l#11: int :: (forall k$ih#1#20: int, l$ih#2#21: int :: true ==> (0 <= k$ih#1#20 && k$ih#1#20 < k#10) || (k$ih#1#20 == k#10 && 0 <= l$ih#2#21 && l$ih#2#21 < l#11) ==> 0 <= k$ih#1#20 && k$ih#1#20 < l$ih#2#21 && l$ih#2#21 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#20, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l$ih#2#21, S#0)) && true ==> 0 <= k#10 && k#10 < l#11 && l#11 < A#1 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#10, S#0) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, l#11, S#0));
  free ensures (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#0));
  ensures _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0) == null || _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0), B#2, S#0) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.AnalyzeList(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#3: BoxType :: { S#0[$t#3] } S#0[$t#3] ==> $Unbox($t#3): ref == null || (read($Heap, $Unbox($t#3): ref, alloc) && dtype($Unbox($t#3): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (A#1: int, B#2: int);
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || (forall n#22: ref :: n#22 == null || (read($Heap, n#22, alloc) && dtype(n#22) == class._module.Node) ==> S#0[$Box(n#22)] && n#22 != null && read($Heap, n#22, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#22, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#0) && _module.Node.IsClosed($Heap, this, S#0) && S#0[$Box(this)] && S#0[$Box(null)] && (forall n#23: ref :: n#23 == null || (read($Heap, n#23, alloc) && dtype(n#23) == class._module.Node) ==> S#0[$Box(n#23)] && n#23 != null && read($Heap, n#23, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#23, _module.Node.next))]);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures 0 <= A#1;
  ensures 1 <= B#2;
  ensures (forall k#10: int, l#11: int :: (forall k$ih#4#24: int, l$ih#5#25: int :: true ==> (0 <= k$ih#4#24 && k$ih#4#24 < k#10) || (k$ih#4#24 == k#10 && 0 <= l$ih#5#25 && l$ih#5#25 < l#11) ==> 0 <= k$ih#4#24 && k$ih#4#24 < l$ih#5#25 && l$ih#5#25 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#24, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l$ih#5#25, S#0)) && true ==> 0 <= k#10 && k#10 < l#11 && l#11 < A#1 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#10, S#0) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, l#11, S#0));
  free ensures (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#0));
  ensures _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0) == null || _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0), B#2, S#0) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.AnalyzeList(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, S#0: Set BoxType where (forall $t#6: BoxType :: { S#0[$t#6] } S#0[$t#6] ==> $Unbox($t#6): ref == null || (read($Heap, $Unbox($t#6): ref, alloc) && dtype($Unbox($t#6): ref) == class._module.Node)) && $IsGoodSet_Extended(S#0, null)) returns (A#1: int, B#2: int, $_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 4 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || S#0[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#0) ==> _module.Node.IsClosed($Heap, this, S#0) || (forall n#26: ref :: n#26 == null || (read($Heap, n#26, alloc) && dtype(n#26) == class._module.Node) ==> S#0[$Box(n#26)] && n#26 != null && read($Heap, n#26, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#26, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#0) && _module.Node.IsClosed($Heap, this, S#0) && S#0[$Box(this)] && S#0[$Box(null)] && (forall n#27: ref :: n#27 == null || (read($Heap, n#27, alloc) && dtype(n#27) == class._module.Node) ==> S#0[$Box(n#27)] && n#27 != null && read($Heap, n#27, _module.Node.next) != null ==> S#0[$Box(read($Heap, n#27, _module.Node.next))]);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures 0 <= A#1;
  ensures 1 <= B#2;
  ensures (forall k#10: int, l#11: int :: (forall k$ih#7#28: int, l$ih#8#29: int :: true ==> (0 <= k$ih#7#28 && k$ih#7#28 < k#10) || (k$ih#7#28 == k#10 && 0 <= l$ih#8#29 && l$ih#8#29 < l#11) ==> 0 <= k$ih#7#28 && k$ih#7#28 < l$ih#8#29 && l$ih#8#29 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#28, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l$ih#8#29, S#0)) && true ==> 0 <= k#10 && k#10 < l#11 && l#11 < A#1 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#10, S#0) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, l#11, S#0));
  free ensures (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#0));
  ensures _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0) == null || _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0), B#2, S#0) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0);
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.AnalyzeList(this: ref, S#0: Set BoxType) returns (A#1: int, B#2: int, $_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var p#30: ref where p#30 == null || (read($Heap, p#30, alloc) && dtype(p#30) == class._module.Node);
  var steps#31: int;
  var Visited#32: Set BoxType where (forall $t#9: BoxType :: { Visited#32[$t#9] } Visited#32[$t#9] ==> $Unbox($t#9): ref == null || (read($Heap, $Unbox($t#9): ref, alloc) && dtype($Unbox($t#9): ref) == class._module.Node));
  var $rhs#10: ref;
  var $rhs#11: int;
  var $rhs#12: Set BoxType;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: Set BoxType;
  var $w0: bool;
  var k#33: int;
  var S#34: Set BoxType;
  var t#35: int;
  var k#36: int;
  var S#37: Set BoxType;
  var q#40: ref;
  var t#41: int;
  var k#42: int;
  var S#43: Set BoxType;
  var k#46: int;
  var l#47: int;
  var k#48: int;
  var S#49: Set BoxType;
  var k#50: int;
  var S#51: Set BoxType;
  var $decr0$0: Set BoxType;
  var $rhs#16: ref;
  var $rhs#17: int;
  var $rhs#18: Set BoxType;
  var $rhs#19: int;
  var $rhs#20: int;
  var k#56: int;
  var k#57: int;
  var S#58: Set BoxType;
  var $PreLoopHeap1: HeapType;
  var $decr1$init$0: int;
  var $w1: bool;
  var k#60: int;
  var k#61: int;
  var S#62: Set BoxType;
  var k#65: int;
  var S#66: Set BoxType;
  var $decr1$0: int;
  var k#67: int;
  var S#68: Set BoxType;
  var x##69: int;
  var y##70: int;
  var S##71: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(189,16): initial state"} true;
    $_reverifyPost := false;
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(199,9)
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(199,12)
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(199,19)
    // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(199,27)
    assume true;
    assume true;
    assume true;
    assume true;
    $rhs#10 := this;
    assume true;
    $rhs#11 := Lit(0);
    assume true;
    $rhs#12 := Set#UnionOne(Set#Empty(): Set BoxType, $Box(null));
    p#30 := $rhs#10;
    steps#31 := $rhs#11;
    Visited#32 := $rhs#12;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(199,27)"} true;
    // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(200,5)
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := Set#Difference(S#0, Visited#32);
    havoc $w0;
    while (true)
      free invariant $w0 ==> (0 <= steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, steps#31, S#0)) && (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) ==> true) && (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) && S#0[$Box(p#30)] ==> true);
      invariant $w0 ==> 0 <= steps#31;
      invariant $w0 ==> p#30 == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, steps#31, S#0);
      invariant $w0 ==> S#0[$Box(p#30)];
      invariant $w0 ==> Visited#32[$Box(null)];
      free invariant $w0 ==> true;
      invariant $w0 ==> Set#Subset(Visited#32, S#0);
      free invariant $w0 ==> (forall t#38: int :: true ==> (0 <= t#38 ==> true) && (0 <= t#38 && t#38 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, t#38, S#0)));
      invariant $w0 ==> (forall t#38: int :: (forall t$ih#13#39: int :: true ==> 0 <= t$ih#13#39 && t$ih#13#39 < t#38 ==> 0 <= t$ih#13#39 && t$ih#13#39 < steps#31 ==> Visited#32[$Box(_module.Node.Nexxxt($LS($LZ), $Heap, this, t$ih#13#39, S#0))]) && true ==> 0 <= t#38 && t#38 < steps#31 ==> Visited#32[$Box(_module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, t#38, S#0))]);
      free invariant $w0 ==> (forall t#38: int :: true ==> 0 <= t#38 && t#38 < steps#31 ==> Visited#32[$Box(_module.Node.Nexxxt($LS($LZ), $Heap, this, t#38, S#0))]);
      free invariant $w0 ==> (forall q#45: ref :: q#45 == null || (read($Heap, q#45, alloc) && dtype(q#45) == class._module.Node) ==> Visited#32[$Box(q#45)] ==> q#45 != null ==> (forall t#44: int :: true ==> (0 <= t#44 ==> true) && (0 <= t#44 && t#44 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, t#44, S#0))));
      invariant $w0 ==> (forall q#45: ref :: q#45 == null || (read($Heap, q#45, alloc) && dtype(q#45) == class._module.Node) ==> Visited#32[$Box(q#45)] ==> q#45 == null || (exists t#44: int :: 0 <= t#44 && t#44 < steps#31 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, t#44, S#0) == q#45));
      free invariant $w0 ==> (forall q#45: ref :: q#45 == null || (read($Heap, q#45, alloc) && dtype(q#45) == class._module.Node) ==> Visited#32[$Box(q#45)] ==> q#45 == null || (exists t#44: int :: 0 <= t#44 && t#44 < steps#31 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#44, S#0) == q#45));
      free invariant $w0 ==> (forall k#52: int, l#53: int :: true ==> (0 <= k#52 ==> true) && (0 <= k#52 && k#52 < l#53 ==> true) && (0 <= k#52 && k#52 < l#53 && l#53 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, k#52, S#0) && _module.Node.Nexxxt#canCall($Heap, this, l#53, S#0)));
      invariant $w0 ==> (forall k#52: int, l#53: int :: (forall k$ih#14#54: int, l$ih#15#55: int :: true ==> (0 <= k$ih#14#54 && k$ih#14#54 < k#52) || (k$ih#14#54 == k#52 && 0 <= l$ih#15#55 && l$ih#15#55 < l#53) ==> 0 <= k$ih#14#54 && k$ih#14#54 < l$ih#15#55 && l$ih#15#55 < steps#31 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#14#54, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l$ih#15#55, S#0)) && true ==> 0 <= k#52 && k#52 < l#53 && l#53 < steps#31 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#52, S#0) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, l#53, S#0));
      free invariant $w0 ==> (forall k#52: int, l#53: int :: true ==> 0 <= k#52 && k#52 < l#53 && l#53 < steps#31 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#52, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#53, S#0));
      free invariant $PreLoopHeap0 == $Heap;
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
      free invariant Set#Subset(Set#Difference(S#0, Visited#32), $decr0$init$0) && (Set#Equal(Set#Difference(S#0, Visited#32), $decr0$init$0) ==> true);
    {
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(200,5): after some loop iterations"} true;
        if (!$w0)
        {
            if (0 <= steps#31)
            {
                k#33 := steps#31;
                S#34 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#34) && 0 <= k#33;
                assume _module.Node.Nexxxt#canCall($Heap, this, steps#31, S#0);
            }

            if (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0))
            {
            }

            if (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) && S#0[$Box(p#30)])
            {
            }

            assume (0 <= steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, steps#31, S#0)) && (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) ==> true) && (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) && S#0[$Box(p#30)] ==> true);
            assume 0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) && S#0[$Box(p#30)] && Visited#32[$Box(null)];
            assume true;
            assume Set#Subset(Visited#32, S#0);
            havoc t#35;
            if (0 <= t#35)
            {
            }

            if (0 <= t#35 && t#35 < steps#31)
            {
                k#36 := t#35;
                S#37 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#37) && 0 <= k#36;
                assume _module.Node.Nexxxt#canCall($Heap, this, t#35, S#0);
            }

            assume (forall t#38: int :: true ==> (0 <= t#38 ==> true) && (0 <= t#38 && t#38 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, t#38, S#0)));
            assume (forall t#38: int :: true ==> 0 <= t#38 && t#38 < steps#31 ==> Visited#32[$Box(_module.Node.Nexxxt($LS($LZ), $Heap, this, t#38, S#0))]);
            havoc q#40;
            assume q#40 == null || (read($Heap, q#40, alloc) && dtype(q#40) == class._module.Node);
            if (Visited#32[$Box(q#40)])
            {
                if (q#40 != null)
                {
                    havoc t#41;
                    if (0 <= t#41)
                    {
                    }

                    if (0 <= t#41 && t#41 < steps#31)
                    {
                        k#42 := t#41;
                        S#43 := S#0;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#43) && 0 <= k#42;
                        assume _module.Node.Nexxxt#canCall($Heap, this, t#41, S#0);
                    }
                }
            }

            assume (forall q#45: ref :: q#45 == null || (read($Heap, q#45, alloc) && dtype(q#45) == class._module.Node) ==> Visited#32[$Box(q#45)] ==> q#45 != null ==> (forall t#44: int :: true ==> (0 <= t#44 ==> true) && (0 <= t#44 && t#44 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, t#44, S#0))));
            assume (forall q#45: ref :: q#45 == null || (read($Heap, q#45, alloc) && dtype(q#45) == class._module.Node) ==> Visited#32[$Box(q#45)] ==> q#45 == null || (exists t#44: int :: 0 <= t#44 && t#44 < steps#31 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#44, S#0) == q#45));
            havoc k#46;
            havoc l#47;
            if (0 <= k#46)
            {
            }

            if (0 <= k#46 && k#46 < l#47)
            {
            }

            if (0 <= k#46 && k#46 < l#47 && l#47 < steps#31)
            {
                k#48 := k#46;
                S#49 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#49) && 0 <= k#48;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#46, S#0);
                k#50 := l#47;
                S#51 := S#0;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#51) && 0 <= k#50;
                assume _module.Node.Nexxxt#canCall($Heap, this, l#47, S#0);
            }

            assume (forall k#52: int, l#53: int :: true ==> (0 <= k#52 ==> true) && (0 <= k#52 && k#52 < l#53 ==> true) && (0 <= k#52 && k#52 < l#53 && l#53 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, k#52, S#0) && _module.Node.Nexxxt#canCall($Heap, this, l#53, S#0)));
            assume (forall k#52: int, l#53: int :: true ==> 0 <= k#52 && k#52 < l#53 && l#53 < steps#31 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#52, S#0) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#53, S#0));
            assume true;
            assume false;
        }

        assume true;
        if (Visited#32[$Box(p#30)])
        {
            break;
        }

        $decr0$0 := Set#Difference(S#0, Visited#32);
        // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(208,25)
        assume true;
        assume true;
        assume true;
        assert p#30 != null;
        assume true;
        $rhs#16 := read($Heap, p#30, _module.Node.next);
        assume true;
        $rhs#17 := steps#31 + 1;
        assume true;
        $rhs#18 := Set#Union(Visited#32, Set#UnionOne(Set#Empty(): Set BoxType, $Box(p#30)));
        p#30 := $rhs#16;
        steps#31 := $rhs#17;
        Visited#32 := $rhs#18;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(208,25)"} true;
        assert Set#Subset(Set#Difference(S#0, Visited#32), $decr0$0) && !Set#Subset($decr0$0, Set#Difference(S#0, Visited#32));
        assume (0 <= steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, steps#31, S#0)) && (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) ==> true) && (0 <= steps#31 && p#30 == _module.Node.Nexxxt($LS($LZ), $Heap, this, steps#31, S#0) && S#0[$Box(p#30)] ==> true);
        assume true;
        assume (forall t#38: int :: true ==> (0 <= t#38 ==> true) && (0 <= t#38 && t#38 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, t#38, S#0)));
        assume (forall q#45: ref :: q#45 == null || (read($Heap, q#45, alloc) && dtype(q#45) == class._module.Node) ==> Visited#32[$Box(q#45)] ==> q#45 != null ==> (forall t#44: int :: true ==> (0 <= t#44 ==> true) && (0 <= t#44 && t#44 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, t#44, S#0))));
        assume (forall k#52: int, l#53: int :: true ==> (0 <= k#52 ==> true) && (0 <= k#52 && k#52 < l#53 ==> true) && (0 <= k#52 && k#52 < l#53 && l#53 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, k#52, S#0) && _module.Node.Nexxxt#canCall($Heap, this, l#53, S#0)));
    }

    // ----- if statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(210,5)
    assume true;
    if (p#30 == null)
    {
        // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(211,12)
        assume true;
        assume true;
        assume true;
        $rhs#19 := steps#31;
        assume true;
        $rhs#20 := Lit(1);
        A#1 := $rhs#19;
        B#2 := $rhs#20;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(211,12)"} true;
    }
    else
    {
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(213,7)
        havoc k#56;
        if (0 <= k#56)
        {
        }

        if (0 <= k#56 && k#56 < steps#31)
        {
            k#57 := k#56;
            S#58 := S#0;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#58) && 0 <= k#57;
            assume _module.Node.Nexxxt#canCall($Heap, this, k#56, S#0);
        }

        assume (forall k#59: int :: true ==> (0 <= k#59 ==> true) && (0 <= k#59 && k#59 < steps#31 ==> _module.Node.Nexxxt#canCall($Heap, this, k#59, S#0)));
        assert (exists k#59: int :: 0 <= k#59 && k#59 < steps#31 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#59, S#0) == p#30);
        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(215,9)
        assume true;
        assume true;
        A#1 := Lit(0);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(215,9)"} true;
        // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(216,7)
        $PreLoopHeap1 := $Heap;
        $decr1$init$0 := steps#31 - A#1;
        havoc $w1;
        while (true)
          free invariant $w1 ==> 0 <= A#1 ==> true;
          invariant $w1 ==> 0 <= A#1;
          invariant $w1 ==> A#1 < steps#31;
          free invariant $w1 ==> (forall k#63: int :: true ==> (0 <= k#63 ==> true) && (0 <= k#63 && k#63 < A#1 ==> _module.Node.Nexxxt#canCall($Heap, this, k#63, S#0)));
          invariant $w1 ==> (forall k#63: int :: (forall k$ih#21#64: int :: true ==> 0 <= k$ih#21#64 && k$ih#21#64 < k#63 ==> 0 <= k$ih#21#64 && k$ih#21#64 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#21#64, S#0) != p#30) && true ==> 0 <= k#63 && k#63 < A#1 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#63, S#0) != p#30);
          free invariant $w1 ==> (forall k#63: int :: true ==> 0 <= k#63 && k#63 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#63, S#0) != p#30);
          free invariant $PreLoopHeap1 == $Heap;
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap1, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap1, $o, $f) || $_Frame[$o, $f]);
          free invariant steps#31 - A#1 <= $decr1$init$0 && (steps#31 - A#1 == $decr1$init$0 ==> true);
        {
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(216,7): after some loop iterations"} true;
            if (!$w1)
            {
                if (0 <= A#1)
                {
                }

                assume 0 <= A#1 ==> true;
                assume 0 <= A#1 && A#1 < steps#31;
                havoc k#60;
                if (0 <= k#60)
                {
                }

                if (0 <= k#60 && k#60 < A#1)
                {
                    k#61 := k#60;
                    S#62 := S#0;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#62) && 0 <= k#61;
                    assume _module.Node.Nexxxt#canCall($Heap, this, k#60, S#0);
                }

                assume (forall k#63: int :: true ==> (0 <= k#63 ==> true) && (0 <= k#63 && k#63 < A#1 ==> _module.Node.Nexxxt#canCall($Heap, this, k#63, S#0)));
                assume (forall k#63: int :: true ==> 0 <= k#63 && k#63 < A#1 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#63, S#0) != p#30);
                assume true;
                assume false;
            }

            k#65 := A#1;
            S#66 := S#0;
            assert _module.Node.IsClosed($Heap, this, S#66) && 0 <= k#65;
            assume _module.Node.Nexxxt#canCall($Heap, this, A#1, S#0);
            assume _module.Node.Nexxxt#canCall($Heap, this, A#1, S#0);
            if (_module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0) == p#30)
            {
                break;
            }

            $decr1$0 := steps#31 - A#1;
            // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(221,11)
            assume true;
            assume true;
            A#1 := A#1 + 1;
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(221,11)"} true;
            assert 0 <= $decr1$0 || steps#31 - A#1 == $decr1$0;
            assert steps#31 - A#1 < $decr1$0;
            assume 0 <= A#1 ==> true;
            assume (forall k#63: int :: true ==> (0 <= k#63 ==> true) && (0 <= k#63 && k#63 < A#1 ==> _module.Node.Nexxxt#canCall($Heap, this, k#63, S#0)));
        }

        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(223,9)
        assume true;
        assume true;
        B#2 := steps#31 - A#1;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(223,9)"} true;
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(224,7)
        k#67 := A#1;
        S#68 := S#0;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#68) && 0 <= k#67;
        assume _module.Node.Nexxxt#canCall($Heap, this, A#1, S#0);
        assume _module.Node.Nexxxt#canCall($Heap, this, A#1, S#0);
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, A#1, S#0) != null;
        assume _module.Node.Nexxxt($LS($LZ), $Heap, this, A#1, S#0) != null;
        // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(225,7)
        assume true;
        x##69 := A#1;
        assume true;
        y##70 := B#2;
        assume true;
        S##71 := S#0;
        assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
        call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this, x##69, y##70, S##71);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(225,7)"} true;
    }
}



procedure CheckWellformed$$_module.Node.CrucialLemma(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, S#2: Set BoxType where (forall $t#0: BoxType :: { S#2[$t#0] } S#2[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null));
  free requires 0 == $ModuleContextHeight && 11 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.CrucialLemma(this: ref, a#0: int, b#1: int, S#2: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#3: Set BoxType;
  var k#4: int;
  var l#5: int;
  var k#6: int;
  var S#7: Set BoxType;
  var k#8: int;
  var S#9: Set BoxType;
  var k#12: int;
  var S#13: Set BoxType;
  var k#14: int;
  var S#15: Set BoxType;
  var k#16: int;
  var S#17: Set BoxType;
  var k#18: int;
  var S#19: Set BoxType;
  var T#20: int;
  var k#21: int;
  var S#22: Set BoxType;
  var k#23: int;
  var S#24: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(229,16): initial state"} true;
    S#3 := S#2;
    assume _module.Node.IsClosed#canCall($Heap, this, S#2);
    assume _module.Node.IsClosed($Heap, this, S#2);
    if (0 <= a#0)
    {
    }

    assume 0 <= a#0 && 1 <= b#1;
    havoc k#4;
    havoc l#5;
    if (0 <= k#4)
    {
    }

    if (0 <= k#4 && k#4 < l#5)
    {
    }

    if (0 <= k#4 && k#4 < l#5 && l#5 < a#0)
    {
        k#6 := k#4;
        S#7 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#7) && 0 <= k#6;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#4, S#2);
        k#8 := l#5;
        S#9 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#9) && 0 <= k#8;
        assume _module.Node.Nexxxt#canCall($Heap, this, l#5, S#2);
    }

    assume (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#2) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#2));
    k#12 := a#0;
    S#13 := S#2;
    assert _module.Node.IsClosed($Heap, this, S#13) && 0 <= k#12;
    assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
    if (_module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) != null)
    {
        k#14 := a#0;
        S#15 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#15) && 0 <= k#14;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) != null;
        k#16 := b#1;
        S#17 := S#2;
        assert _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2), S#17) && 0 <= k#16;
        assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2), b#1, S#2);
        k#18 := a#0;
        S#19 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#19) && 0 <= k#18;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
    }

    assume _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) == null || _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2), b#1, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2);
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(234,13): post-state"} true;
    havoc T#20;
    if (0 <= T#20)
    {
    }

    if (0 <= T#20 && T#20 < a#0 + b#1)
    {
        k#21 := T#20;
        S#22 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#22) && 0 <= k#21;
        assume _module.Node.Nexxxt#canCall($Heap, this, T#20, S#2);
        k#23 := 1 + 2 * T#20;
        S#24 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#24) && 0 <= k#23;
        assume _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * T#20, S#2);
    }

    assume (exists T#25: int :: 0 <= T#25 && T#25 < a#0 + b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, T#25, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * T#25, S#2));
}



procedure InterModuleCall$$_module.Node.CrucialLemma(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, S#2: Set BoxType where (forall $t#0: BoxType :: { S#2[$t#0] } S#2[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#2);
  requires 0 <= a#0;
  requires 1 <= b#1;
  requires (forall k#10: int, l#11: int :: (forall k$ih#1#26: int, l$ih#2#27: int :: true ==> (0 <= k$ih#1#26 && k$ih#1#26 < k#10) || (k$ih#1#26 == k#10 && 0 <= l$ih#2#27 && l$ih#2#27 < l#11) ==> 0 <= k$ih#1#26 && k$ih#1#26 < l$ih#2#27 && l$ih#2#27 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#26, S#2) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l$ih#2#27, S#2)) && true ==> 0 <= k#10 && k#10 < l#11 && l#11 < a#0 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#10, S#2) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, l#11, S#2));
  free requires (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#2) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#2));
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2) == null || _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2), b#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (exists T#25: int :: 0 <= T#25 && T#25 < a#0 + b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, T#25, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * T#25, S#2));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.CrucialLemma(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, S#2: Set BoxType where (forall $t#3: BoxType :: { S#2[$t#3] } S#2[$t#3] ==> $Unbox($t#3): ref == null || (read($Heap, $Unbox($t#3): ref, alloc) && dtype($Unbox($t#3): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || (forall n#28: ref :: n#28 == null || (read($Heap, n#28, alloc) && dtype(n#28) == class._module.Node) ==> S#2[$Box(n#28)] && n#28 != null && read($Heap, n#28, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#28, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#2) && _module.Node.IsClosed($Heap, this, S#2) && S#2[$Box(this)] && S#2[$Box(null)] && (forall n#29: ref :: n#29 == null || (read($Heap, n#29, alloc) && dtype(n#29) == class._module.Node) ==> S#2[$Box(n#29)] && n#29 != null && read($Heap, n#29, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#29, _module.Node.next))]);
  requires 0 <= a#0;
  requires 1 <= b#1;
  requires (forall k#10: int, l#11: int :: (forall k$ih#4#30: int, l$ih#5#31: int :: true ==> (0 <= k$ih#4#30 && k$ih#4#30 < k#10) || (k$ih#4#30 == k#10 && 0 <= l$ih#5#31 && l$ih#5#31 < l#11) ==> 0 <= k$ih#4#30 && k$ih#4#30 < l$ih#5#31 && l$ih#5#31 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#30, S#2) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l$ih#5#31, S#2)) && true ==> 0 <= k#10 && k#10 < l#11 && l#11 < a#0 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#10, S#2) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, l#11, S#2));
  free requires (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#2) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#2));
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2) == null || _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2), b#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (exists T#25: int :: 0 <= T#25 && T#25 < a#0 + b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, T#25, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * T#25, S#2));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.CrucialLemma(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, S#2: Set BoxType where (forall $t#6: BoxType :: { S#2[$t#6] } S#2[$t#6] ==> $Unbox($t#6): ref == null || (read($Heap, $Unbox($t#6): ref, alloc) && dtype($Unbox($t#6): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 11 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || (forall n#32: ref :: n#32 == null || (read($Heap, n#32, alloc) && dtype(n#32) == class._module.Node) ==> S#2[$Box(n#32)] && n#32 != null && read($Heap, n#32, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#32, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#2) && _module.Node.IsClosed($Heap, this, S#2) && S#2[$Box(this)] && S#2[$Box(null)] && (forall n#33: ref :: n#33 == null || (read($Heap, n#33, alloc) && dtype(n#33) == class._module.Node) ==> S#2[$Box(n#33)] && n#33 != null && read($Heap, n#33, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#33, _module.Node.next))]);
  requires 0 <= a#0;
  requires 1 <= b#1;
  requires (forall k#10: int, l#11: int :: (forall k$ih#7#34: int, l$ih#8#35: int :: true ==> (0 <= k$ih#7#34 && k$ih#7#34 < k#10) || (k$ih#7#34 == k#10 && 0 <= l$ih#8#35 && l$ih#8#35 < l#11) ==> 0 <= k$ih#7#34 && k$ih#7#34 < l$ih#8#35 && l$ih#8#35 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#34, S#2) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l$ih#8#35, S#2)) && true ==> 0 <= k#10 && k#10 < l#11 && l#11 < a#0 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#10, S#2) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, l#11, S#2));
  free requires (forall k#10: int, l#11: int :: true ==> 0 <= k#10 && k#10 < l#11 && l#11 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#10, S#2) != _module.Node.Nexxxt($LS($LZ), $Heap, this, l#11, S#2));
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2) == null || _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2), b#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (exists T#25: int :: 0 <= T#25 && T#25 < a#0 + b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, T#25, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * T#25, S#2));
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.CrucialLemma(this: ref, a#0: int, b#1: int, S#2: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#10: HeapType;
  var k#40: int;
  var S#41: Set BoxType;
  var d##42: int;
  var S##43: Set BoxType;
  var k#44: int;
  var S#45: Set BoxType;
  var k#46: int;
  var S#47: Set BoxType;
  var k#48: int;
  var S#49: Set BoxType;
  var k#50: int;
  var S#51: Set BoxType;
  var k#52: int;
  var S#53: Set BoxType;
  var k#54: int;
  var S#55: Set BoxType;
  var x##56: int;
  var y##57: int;
  var S##58: Set BoxType;
  var k#59: int;
  var S#60: Set BoxType;
  var k#61: int;
  var S#62: Set BoxType;
  var t#63: int;
  var h#64: int;
  var $rhs#12: int;
  var $rhs#13: int;
  var vt#65: int;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: int;
  var $w0: bool;
  var k#66: int;
  var S#67: Set BoxType;
  var k#68: int;
  var S#69: Set BoxType;
  var $decr0$0: int;
  var a##70: int;
  var b##71: int;
  var k##72: int;
  var S##73: Set BoxType;
  var catchup#74: int;
  var i#75: int;
  var $PreLoopHeap1: HeapType;
  var $decr1$init$0: int;
  var $w1: bool;
  var k#76: int;
  var S#77: Set BoxType;
  var k#78: int;
  var S#79: Set BoxType;
  var k#80: int;
  var S#81: Set BoxType;
  var k#82: int;
  var S#83: Set BoxType;
  var $decr1$0: int;
  var $rhs#14: int;
  var $rhs#15: int;
  var $rhs#16: int;
  var $rhs#17: int;
  var k#84: int;
  var S#85: Set BoxType;
  var k#86: int;
  var S#87: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(229,16): initial state"} true;
    $initHeapForallStmt#10 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#10 == $Heap;
    assume (forall $ih#S9#36: Set BoxType :: (forall $t#11: BoxType :: { $ih#S9#36[$t#11] } $ih#S9#36[$t#11] ==> $Unbox($t#11): ref == null || (read($initHeapForallStmt#10, $Unbox($t#11): ref, alloc) && dtype($Unbox($t#11): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#10, this, $ih#S9#36) && 0 <= a#0 && 1 <= b#1 && (forall k#37: int, l#38: int :: true ==> 0 <= k#37 && k#37 < l#38 && l#38 < a#0 ==> _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, k#37, $ih#S9#36) != _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, l#38, $ih#S9#36)) && (_module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, a#0, $ih#S9#36) == null || _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, a#0, $ih#S9#36), b#1, $ih#S9#36) == _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, a#0, $ih#S9#36)) && ((0 <= a#0 && a#0 < a#0) || (a#0 == a#0 && ((0 <= b#1 && b#1 < b#1) || (b#1 == b#1 && Set#Subset($ih#S9#36, S#2) && !Set#Subset(S#2, $ih#S9#36))))) ==> (exists T#39: int :: 0 <= T#39 && T#39 < a#0 + b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, T#39, $ih#S9#36) == _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * T#39, $ih#S9#36)));
    $_reverifyPost := false;
    // ----- if statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(236,5)
    k#40 := a#0;
    S#41 := S#2;
    assert _module.Node.IsClosed($Heap, this, S#41) && 0 <= k#40;
    assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
    assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
    if (_module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) == null)
    {
        // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(237,7)
        assume true;
        d##42 := 1 + 2 * a#0;
        assume true;
        S##43 := S#2;
        assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
        call IntraModuleCall$$_module.Node.Lemma__NullIsTerminal(this, d##42, S##43);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(237,7)"} true;
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(238,7)
        k#44 := a#0;
        S#45 := S#2;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#45) && 0 <= k#44;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
        if (_module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) == null)
        {
            k#46 := 1 + 2 * a#0;
            S#47 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#47) && 0 <= k#46;
            assume _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * a#0, S#2);
        }

        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) == null ==> _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * a#0, S#2));
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) == null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, 1 + 2 * a#0, S#2) == null;
        assume _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) == null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * a#0, S#2) == null;
    }
    else
    {
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(240,7)
        k#48 := a#0;
        S#49 := S#2;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#49) && 0 <= k#48;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
        if (_module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) != null)
        {
            k#50 := a#0;
            S#51 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#51) && 0 <= k#50;
            assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) != null;
            k#52 := b#1;
            S#53 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2), S#53) && 0 <= k#52;
            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2), b#1, S#2);
            k#54 := a#0;
            S#55 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#55) && 0 <= k#54;
            assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
        }

        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) != null ==> _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2), b#1, S#2) && _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2));
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2) != null;
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2), b#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2);
        assume _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2) != null && _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2), b#1, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2);
        // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(241,7)
        assume true;
        x##56 := a#0;
        assume true;
        y##57 := b#1;
        assume true;
        S##58 := S#2;
        assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
        call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this, x##56, y##57, S##58);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(241,7)"} true;
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(242,7)
        k#59 := a#0 + b#1;
        S#60 := S#2;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#60) && 0 <= k#59;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0 + b#1, S#2);
        k#61 := a#0;
        S#62 := S#2;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#62) && 0 <= k#61;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0 + b#1, S#2) && _module.Node.Nexxxt#canCall($Heap, this, a#0, S#2);
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0 + b#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#2);
        assume _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0 + b#1, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#2);
        // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(249,11)
        // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(249,14)
        // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(249,16)
        assume true;
        assume true;
        assume true;
        $rhs#12 := a#0;
        assume true;
        $rhs#13 := 1 + 2 * a#0;
        t#63 := $rhs#12;
        h#64 := $rhs#13;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(249,16)"} true;
        // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(250,11)
        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(250,14)
        assume true;
        assume true;
        vt#65 := a#0;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(250,14)"} true;
        // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(251,7)
        $PreLoopHeap0 := $Heap;
        $decr0$init$0 := h#64 - vt#65;
        havoc $w0;
        while (true)
          free invariant $w0 ==> t#63 <= vt#65 ==> true;
          invariant $w0 ==> t#63 <= vt#65;
          invariant $w0 ==> vt#65 < h#64 + b#1;
          free invariant $w0 ==> _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2) && _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2);
          invariant $w0 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, vt#65, S#2);
          free invariant $PreLoopHeap0 == $Heap;
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
          free invariant h#64 - vt#65 <= $decr0$init$0 && (h#64 - vt#65 == $decr0$init$0 ==> true);
        {
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(251,7): after some loop iterations"} true;
            if (!$w0)
            {
                if (t#63 <= vt#65)
                {
                }

                assume t#63 <= vt#65 ==> true;
                assume t#63 <= vt#65 && vt#65 < h#64 + b#1;
                k#66 := t#63;
                S#67 := S#2;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#67) && 0 <= k#66;
                assume _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2);
                k#68 := vt#65;
                S#69 := S#2;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#69) && 0 <= k#68;
                assume _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2);
                assume _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2) && _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2);
                assume _module.Node.Nexxxt($LS($LZ), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, vt#65, S#2);
                assume true;
                assume false;
            }

            assume true;
            if (h#64 <= vt#65)
            {
                break;
            }

            $decr0$0 := h#64 - vt#65;
            // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(255,9)
            assume true;
            a##70 := a#0;
            assume true;
            b##71 := b#1;
            assume true;
            k##72 := vt#65;
            assume true;
            S##73 := S#2;
            assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
            call IntraModuleCall$$_module.Node.Lemma__AboutCycles(this, a##70, b##71, k##72, S##73);
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(255,9)"} true;
            // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(256,12)
            assume true;
            assume true;
            vt#65 := vt#65 + b#1;
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(256,12)"} true;
            assert 0 <= $decr0$0 || h#64 - vt#65 == $decr0$0;
            assert h#64 - vt#65 < $decr0$0;
            assume t#63 <= vt#65 ==> true;
            assume _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2) && _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2);
        }

        // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(261,11)
        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(261,19)
        assume true;
        assume true;
        catchup#74 := vt#65 - h#64;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(261,19)"} true;
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(262,7)
        if (0 <= catchup#74)
        {
        }

        assume 0 <= catchup#74 ==> true;
        assert {:subsumption 0} 0 <= catchup#74;
        assert {:subsumption 0} catchup#74 < b#1;
        assume 0 <= catchup#74 && catchup#74 < b#1;
        // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(265,11)
        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(265,13)
        assume true;
        assume true;
        i#75 := Lit(0);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(265,13)"} true;
        // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(266,7)
        $PreLoopHeap1 := $Heap;
        $decr1$init$0 := catchup#74 - i#75;
        havoc $w1;
        while (true)
          free invariant $w1 ==> 0 <= i#75 ==> true;
          invariant $w1 ==> 0 <= i#75;
          invariant $w1 ==> i#75 <= catchup#74;
          free invariant $w1 ==> (t#63 == a#0 + i#75 ==> true) && (t#63 == a#0 + i#75 && h#64 == 1 + 2 * t#63 ==> true);
          invariant $w1 ==> t#63 == a#0 + i#75;
          invariant $w1 ==> h#64 == 1 + 2 * t#63;
          invariant $w1 ==> t#63 <= vt#65;
          free invariant $w1 ==> _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2) && _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, vt#65, S#2) ==> _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2) && _module.Node.Nexxxt#canCall($Heap, this, h#64 + catchup#74 - i#75, S#2));
          invariant $w1 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, vt#65, S#2);
          invariant $w1 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, vt#65, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, h#64 + catchup#74 - i#75, S#2);
          free invariant $PreLoopHeap1 == $Heap;
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap1, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap1, $o, $f) || $_Frame[$o, $f]);
          free invariant catchup#74 - i#75 <= $decr1$init$0 && (catchup#74 - i#75 == $decr1$init$0 ==> true);
        {
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(266,7): after some loop iterations"} true;
            if (!$w1)
            {
                if (0 <= i#75)
                {
                }

                assume 0 <= i#75 ==> true;
                assume 0 <= i#75 && i#75 <= catchup#74;
                if (t#63 == a#0 + i#75)
                {
                }

                if (t#63 == a#0 + i#75 && h#64 == 1 + 2 * t#63)
                {
                }

                assume (t#63 == a#0 + i#75 ==> true) && (t#63 == a#0 + i#75 && h#64 == 1 + 2 * t#63 ==> true);
                assume t#63 == a#0 + i#75 && h#64 == 1 + 2 * t#63 && t#63 <= vt#65;
                k#76 := t#63;
                S#77 := S#2;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#77) && 0 <= k#76;
                assume _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2);
                k#78 := vt#65;
                S#79 := S#2;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#79) && 0 <= k#78;
                assume _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2);
                if (_module.Node.Nexxxt($LS($LZ), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, vt#65, S#2))
                {
                    k#80 := vt#65;
                    S#81 := S#2;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#81) && 0 <= k#80;
                    assume _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2);
                    k#82 := h#64 + catchup#74 - i#75;
                    S#83 := S#2;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#83) && 0 <= k#82;
                    assume _module.Node.Nexxxt#canCall($Heap, this, h#64 + catchup#74 - i#75, S#2);
                }

                assume _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2) && _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, vt#65, S#2) ==> _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2) && _module.Node.Nexxxt#canCall($Heap, this, h#64 + catchup#74 - i#75, S#2));
                assume _module.Node.Nexxxt($LS($LZ), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, vt#65, S#2) && _module.Node.Nexxxt($LS($LZ), $Heap, this, vt#65, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, h#64 + catchup#74 - i#75, S#2);
                assume true;
                assume false;
            }

            assume true;
            if (catchup#74 <= i#75)
            {
                break;
            }

            $decr1$0 := catchup#74 - i#75;
            // ----- update statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(271,21)
            assume true;
            assume true;
            assume true;
            assume true;
            assume true;
            $rhs#14 := i#75 + 1;
            assume true;
            $rhs#15 := t#63 + 1;
            assume true;
            $rhs#16 := vt#65 + 1;
            assume true;
            $rhs#17 := h#64 + 2;
            i#75 := $rhs#14;
            t#63 := $rhs#15;
            vt#65 := $rhs#16;
            h#64 := $rhs#17;
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(271,21)"} true;
            assert 0 <= $decr1$0 || catchup#74 - i#75 == $decr1$0;
            assert catchup#74 - i#75 < $decr1$0;
            assume 0 <= i#75 ==> true;
            assume (t#63 == a#0 + i#75 ==> true) && (t#63 == a#0 + i#75 && h#64 == 1 + 2 * t#63 ==> true);
            assume _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2) && _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, vt#65, S#2) ==> _module.Node.Nexxxt#canCall($Heap, this, vt#65, S#2) && _module.Node.Nexxxt#canCall($Heap, this, h#64 + catchup#74 - i#75, S#2));
        }

        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(273,7)
        if (a#0 <= t#63)
        {
        }

        if (a#0 <= t#63 && t#63 < a#0 + b#1)
        {
            k#84 := t#63;
            S#85 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#85) && 0 <= k#84;
            assume _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2);
            k#86 := 1 + 2 * t#63;
            S#87 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#87) && 0 <= k#86;
            assume _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * t#63, S#2);
        }

        assume (a#0 <= t#63 ==> true) && (a#0 <= t#63 && t#63 < a#0 + b#1 ==> _module.Node.Nexxxt#canCall($Heap, this, t#63, S#2) && _module.Node.Nexxxt#canCall($Heap, this, 1 + 2 * t#63, S#2));
        assert {:subsumption 0} a#0 <= t#63;
        assert {:subsumption 0} t#63 < a#0 + b#1;
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, 1 + 2 * t#63, S#2);
        assume a#0 <= t#63 && t#63 < a#0 + b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, t#63, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, 1 + 2 * t#63, S#2);
    }
}



procedure CheckWellformed$$_module.Node.Lemma__AboutCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, k#2: int, S#3: Set BoxType where (forall $t#0: BoxType :: { S#3[$t#0] } S#3[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#3, null));
  free requires 0 == $ModuleContextHeight && 10 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Lemma__AboutCycles(this: ref, a#0: int, b#1: int, k#2: int, S#3: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#4: Set BoxType;
  var k#5: int;
  var S#6: Set BoxType;
  var k#7: int;
  var S#8: Set BoxType;
  var k#9: int;
  var S#10: Set BoxType;
  var k#11: int;
  var S#12: Set BoxType;
  var k#13: int;
  var S#14: Set BoxType;
  var k#15: int;
  var S#16: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(277,16): initial state"} true;
    S#4 := S#3;
    assume _module.Node.IsClosed#canCall($Heap, this, S#3);
    assume _module.Node.IsClosed($Heap, this, S#3);
    if (0 <= a#0)
    {
    }

    if (0 <= a#0 && a#0 <= k#2)
    {
    }

    if (0 <= a#0 && a#0 <= k#2 && 1 <= b#1)
    {
        k#5 := a#0;
        S#6 := S#3;
        assert _module.Node.IsClosed($Heap, this, S#6) && 0 <= k#5;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#3);
    }

    if (0 <= a#0 && a#0 <= k#2 && 1 <= b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#3) != null)
    {
        k#7 := a#0;
        S#8 := S#3;
        assert _module.Node.IsClosed($Heap, this, S#8) && 0 <= k#7;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#3);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#3) != null;
        k#9 := b#1;
        S#10 := S#3;
        assert _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#3), S#10) && 0 <= k#9;
        assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#3), b#1, S#3);
        k#11 := a#0;
        S#12 := S#3;
        assert _module.Node.IsClosed($Heap, this, S#12) && 0 <= k#11;
        assume _module.Node.Nexxxt#canCall($Heap, this, a#0, S#3);
    }

    assume 0 <= a#0 && a#0 <= k#2 && 1 <= b#1 && _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#3) != null && _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#3), b#1, S#3) == _module.Node.Nexxxt($LS($LZ), $Heap, this, a#0, S#3);
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(280,30): post-state"} true;
    k#13 := k#2 + b#1;
    S#14 := S#3;
    assert _module.Node.IsClosed($Heap, this, S#14) && 0 <= k#13;
    assume _module.Node.Nexxxt#canCall($Heap, this, k#2 + b#1, S#3);
    k#15 := k#2;
    S#16 := S#3;
    assert _module.Node.IsClosed($Heap, this, S#16) && 0 <= k#15;
    assume _module.Node.Nexxxt#canCall($Heap, this, k#2, S#3);
    assume _module.Node.Nexxxt($LS($LZ), $Heap, this, k#2 + b#1, S#3) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#2, S#3);
}



procedure InterModuleCall$$_module.Node.Lemma__AboutCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, k#2: int, S#3: Set BoxType where (forall $t#0: BoxType :: { S#3[$t#0] } S#3[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#3, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#3);
  requires 0 <= a#0;
  requires a#0 <= k#2;
  requires 1 <= b#1;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3) != null;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3), b#1, S#3) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#2 + b#1, S#3) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#2, S#3);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.Lemma__AboutCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, k#2: int, S#3: Set BoxType where (forall $t#1: BoxType :: { S#3[$t#1] } S#3[$t#1] ==> $Unbox($t#1): ref == null || (read($Heap, $Unbox($t#1): ref, alloc) && dtype($Unbox($t#1): ref) == class._module.Node)) && $IsGoodSet_Extended(S#3, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#3) ==> _module.Node.IsClosed($Heap, this, S#3) || S#3[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#3) ==> _module.Node.IsClosed($Heap, this, S#3) || S#3[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#3) ==> _module.Node.IsClosed($Heap, this, S#3) || (forall n#17: ref :: n#17 == null || (read($Heap, n#17, alloc) && dtype(n#17) == class._module.Node) ==> S#3[$Box(n#17)] && n#17 != null && read($Heap, n#17, _module.Node.next) != null ==> S#3[$Box(read($Heap, n#17, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#3) && _module.Node.IsClosed($Heap, this, S#3) && S#3[$Box(this)] && S#3[$Box(null)] && (forall n#18: ref :: n#18 == null || (read($Heap, n#18, alloc) && dtype(n#18) == class._module.Node) ==> S#3[$Box(n#18)] && n#18 != null && read($Heap, n#18, _module.Node.next) != null ==> S#3[$Box(read($Heap, n#18, _module.Node.next))]);
  requires 0 <= a#0;
  requires a#0 <= k#2;
  requires 1 <= b#1;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3) != null;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3), b#1, S#3) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#2 + b#1, S#3) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#2, S#3);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.Lemma__AboutCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, a#0: int, b#1: int, k#2: int, S#3: Set BoxType where (forall $t#2: BoxType :: { S#3[$t#2] } S#3[$t#2] ==> $Unbox($t#2): ref == null || (read($Heap, $Unbox($t#2): ref, alloc) && dtype($Unbox($t#2): ref) == class._module.Node)) && $IsGoodSet_Extended(S#3, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 10 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#3) ==> _module.Node.IsClosed($Heap, this, S#3) || S#3[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#3) ==> _module.Node.IsClosed($Heap, this, S#3) || S#3[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#3) ==> _module.Node.IsClosed($Heap, this, S#3) || (forall n#19: ref :: n#19 == null || (read($Heap, n#19, alloc) && dtype(n#19) == class._module.Node) ==> S#3[$Box(n#19)] && n#19 != null && read($Heap, n#19, _module.Node.next) != null ==> S#3[$Box(read($Heap, n#19, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#3) && _module.Node.IsClosed($Heap, this, S#3) && S#3[$Box(this)] && S#3[$Box(null)] && (forall n#20: ref :: n#20 == null || (read($Heap, n#20, alloc) && dtype(n#20) == class._module.Node) ==> S#3[$Box(n#20)] && n#20 != null && read($Heap, n#20, _module.Node.next) != null ==> S#3[$Box(read($Heap, n#20, _module.Node.next))]);
  requires 0 <= a#0;
  requires a#0 <= k#2;
  requires 1 <= b#1;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3) != null;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3), b#1, S#3) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, a#0, S#3);
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#2 + b#1, S#3) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#2, S#3);
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.Lemma__AboutCycles(this: ref, a#0: int, b#1: int, k#2: int, S#3: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#6: HeapType;
  var x##24: int;
  var y##25: int;
  var S##26: Set BoxType;
  var n#27: int;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: int;
  var $w0: bool;
  var k#28: int;
  var S#29: Set BoxType;
  var k#30: int;
  var S#31: Set BoxType;
  var $decr0$0: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(277,16): initial state"} true;
    $initHeapForallStmt#6 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#6 == $Heap;
    assume (forall $ih#b3#21: int, $ih#k4#22: int, $ih#S5#23: Set BoxType :: (forall $t#7: BoxType :: { $ih#S5#23[$t#7] } $ih#S5#23[$t#7] ==> $Unbox($t#7): ref == null || (read($initHeapForallStmt#6, $Unbox($t#7): ref, alloc) && dtype($Unbox($t#7): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#6, this, $ih#S5#23) && 0 <= a#0 && a#0 <= $ih#k4#22 && 1 <= $ih#b3#21 && _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#6, this, a#0, $ih#S5#23) != null && _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#6, _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#6, this, a#0, $ih#S5#23), $ih#b3#21, $ih#S5#23) == _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#6, this, a#0, $ih#S5#23) && ((0 <= a#0 && a#0 < a#0) || (a#0 == a#0 && ((0 <= $ih#b3#21 && $ih#b3#21 < b#1) || ($ih#b3#21 == b#1 && ((0 <= $ih#k4#22 && $ih#k4#22 < k#2) || ($ih#k4#22 == k#2 && Set#Subset($ih#S5#23, S#3) && !Set#Subset(S#3, $ih#S5#23))))))) ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, $ih#k4#22 + $ih#b3#21, $ih#S5#23) == _module.Node.Nexxxt($LS($LZ), $Heap, this, $ih#k4#22, $ih#S5#23));
    $_reverifyPost := false;
    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(282,5)
    assume true;
    x##24 := a#0;
    assume true;
    y##25 := b#1;
    assume true;
    S##26 := S#3;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this, x##24, y##25, S##26);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(282,5)"} true;
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(283,9)
    // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(283,11)
    assume true;
    assume true;
    n#27 := a#0;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(283,11)"} true;
    // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(284,5)
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := k#2 - n#27;
    havoc $w0;
    while (true)
      free invariant $w0 ==> a#0 <= n#27 ==> true;
      invariant $w0 ==> a#0 <= n#27;
      invariant $w0 ==> n#27 <= k#2;
      free invariant $w0 ==> _module.Node.Nexxxt#canCall($Heap, this, n#27 + b#1, S#3) && _module.Node.Nexxxt#canCall($Heap, this, n#27, S#3);
      invariant $w0 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#27 + b#1, S#3) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#27, S#3);
      free invariant $PreLoopHeap0 == $Heap;
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
      free invariant k#2 - n#27 <= $decr0$init$0 && (k#2 - n#27 == $decr0$init$0 ==> true);
    {
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(284,5): after some loop iterations"} true;
        if (!$w0)
        {
            if (a#0 <= n#27)
            {
            }

            assume a#0 <= n#27 ==> true;
            assume a#0 <= n#27 && n#27 <= k#2;
            k#28 := n#27 + b#1;
            S#29 := S#3;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#29) && 0 <= k#28;
            assume _module.Node.Nexxxt#canCall($Heap, this, n#27 + b#1, S#3);
            k#30 := n#27;
            S#31 := S#3;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#31) && 0 <= k#30;
            assume _module.Node.Nexxxt#canCall($Heap, this, n#27, S#3);
            assume _module.Node.Nexxxt#canCall($Heap, this, n#27 + b#1, S#3) && _module.Node.Nexxxt#canCall($Heap, this, n#27, S#3);
            assume _module.Node.Nexxxt($LS($LZ), $Heap, this, n#27 + b#1, S#3) == _module.Node.Nexxxt($LS($LZ), $Heap, this, n#27, S#3);
            assume true;
            assume false;
        }

        assume true;
        if (k#2 <= n#27)
        {
            break;
        }

        $decr0$0 := k#2 - n#27;
        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(288,9)
        assume true;
        assume true;
        n#27 := n#27 + 1;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(288,9)"} true;
        assert 0 <= $decr0$0 || k#2 - n#27 == $decr0$0;
        assert k#2 - n#27 < $decr0$0;
        assume a#0 <= n#27 ==> true;
        assume _module.Node.Nexxxt#canCall($Heap, this, n#27 + b#1, S#3) && _module.Node.Nexxxt#canCall($Heap, this, n#27, S#3);
    }
}



procedure CheckWellformed$$_module.Node.Lemma__NexxxtIsTransitive(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, x#0: int, y#1: int, S#2: Set BoxType where (forall $t#0: BoxType :: { S#2[$t#0] } S#2[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null));
  free requires 0 == $ModuleContextHeight && 3 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Lemma__NexxxtIsTransitive(this: ref, x#0: int, y#1: int, S#2: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#3: Set BoxType;
  var k#4: int;
  var S#5: Set BoxType;
  var k#6: int;
  var S#7: Set BoxType;
  var k#8: int;
  var S#9: Set BoxType;
  var k#10: int;
  var S#11: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(292,16): initial state"} true;
    S#3 := S#2;
    assume _module.Node.IsClosed#canCall($Heap, this, S#2);
    if (_module.Node.IsClosed($Heap, this, S#2))
    {
    }

    if (_module.Node.IsClosed($Heap, this, S#2) && 0 <= x#0)
    {
    }

    assume _module.Node.IsClosed($Heap, this, S#2) && 0 <= x#0 && 0 <= y#1;
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(294,34): post-state"} true;
    k#4 := x#0;
    S#5 := S#2;
    assert _module.Node.IsClosed($Heap, this, S#5) && 0 <= k#4;
    assume _module.Node.Nexxxt#canCall($Heap, this, x#0, S#2);
    if (_module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null)
    {
        k#6 := x#0;
        S#7 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#7) && 0 <= k#6;
        assume _module.Node.Nexxxt#canCall($Heap, this, x#0, S#2);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null;
        k#8 := y#1;
        S#9 := S#2;
        assert _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), S#9) && 0 <= k#8;
        assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), y#1, S#2);
        k#10 := x#0 + y#1;
        S#11 := S#2;
        assert _module.Node.IsClosed($Heap, this, S#11) && 0 <= k#10;
        assume _module.Node.Nexxxt#canCall($Heap, this, x#0 + y#1, S#2);
    }

    assume _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), y#1, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0 + y#1, S#2);
}



procedure InterModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, x#0: int, y#1: int, S#2: Set BoxType where (forall $t#0: BoxType :: { S#2[$t#0] } S#2[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#2);
  requires 0 <= x#0;
  requires 0 <= y#1;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0, S#2), y#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0 + y#1, S#2);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, x#0: int, y#1: int, S#2: Set BoxType where (forall $t#1: BoxType :: { S#2[$t#1] } S#2[$t#1] ==> $Unbox($t#1): ref == null || (read($Heap, $Unbox($t#1): ref, alloc) && dtype($Unbox($t#1): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || (forall n#12: ref :: n#12 == null || (read($Heap, n#12, alloc) && dtype(n#12) == class._module.Node) ==> S#2[$Box(n#12)] && n#12 != null && read($Heap, n#12, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#12, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#2) && _module.Node.IsClosed($Heap, this, S#2) && S#2[$Box(this)] && S#2[$Box(null)] && (forall n#13: ref :: n#13 == null || (read($Heap, n#13, alloc) && dtype(n#13) == class._module.Node) ==> S#2[$Box(n#13)] && n#13 != null && read($Heap, n#13, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#13, _module.Node.next))]);
  requires 0 <= x#0;
  requires 0 <= y#1;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0, S#2), y#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0 + y#1, S#2);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.Lemma__NexxxtIsTransitive(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, x#0: int, y#1: int, S#2: Set BoxType where (forall $t#2: BoxType :: { S#2[$t#2] } S#2[$t#2] ==> $Unbox($t#2): ref == null || (read($Heap, $Unbox($t#2): ref, alloc) && dtype($Unbox($t#2): ref) == class._module.Node)) && $IsGoodSet_Extended(S#2, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 3 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || S#2[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#2) ==> _module.Node.IsClosed($Heap, this, S#2) || (forall n#14: ref :: n#14 == null || (read($Heap, n#14, alloc) && dtype(n#14) == class._module.Node) ==> S#2[$Box(n#14)] && n#14 != null && read($Heap, n#14, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#14, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#2) && _module.Node.IsClosed($Heap, this, S#2) && S#2[$Box(this)] && S#2[$Box(null)] && (forall n#15: ref :: n#15 == null || (read($Heap, n#15, alloc) && dtype(n#15) == class._module.Node) ==> S#2[$Box(n#15)] && n#15 != null && read($Heap, n#15, _module.Node.next) != null ==> S#2[$Box(read($Heap, n#15, _module.Node.next))]);
  requires 0 <= x#0;
  requires 0 <= y#1;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0, S#2), y#1, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0 + y#1, S#2);
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.Lemma__NexxxtIsTransitive(this: ref, x#0: int, y#1: int, S#2: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#6: HeapType;
  var k#19: int;
  var S#20: Set BoxType;
  var j#21: int;
  var k#22: int;
  var S#23: Set BoxType;
  var k#24: int;
  var S#25: Set BoxType;
  var k#26: int;
  var S#27: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(292,16): initial state"} true;
    $initHeapForallStmt#6 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#6 == $Heap;
    assume (forall $ih#x3#16: int, $ih#y4#17: int, $ih#S5#18: Set BoxType :: (forall $t#7: BoxType :: { $ih#S5#18[$t#7] } $ih#S5#18[$t#7] ==> $Unbox($t#7): ref == null || (read($initHeapForallStmt#6, $Unbox($t#7): ref, alloc) && dtype($Unbox($t#7): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#6, this, $ih#S5#18) && 0 <= $ih#x3#16 && 0 <= $ih#y4#17 && ((0 <= $ih#x3#16 && $ih#x3#16 < x#0) || ($ih#x3#16 == x#0 && ((0 <= $ih#y4#17 && $ih#y4#17 < y#1) || ($ih#y4#17 == y#1 && Set#Subset($ih#S5#18, S#2) && !Set#Subset(S#2, $ih#S5#18))))) ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, $ih#x3#16, $ih#S5#18) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, $ih#x3#16, $ih#S5#18), $ih#y4#17, $ih#S5#18) == _module.Node.Nexxxt($LS($LZ), $Heap, this, $ih#x3#16 + $ih#y4#17, $ih#S5#18));
    $_reverifyPost := false;
    // ----- if statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(296,5)
    k#19 := x#0;
    S#20 := S#2;
    assert _module.Node.IsClosed($Heap, this, S#20) && 0 <= k#19;
    assume _module.Node.Nexxxt#canCall($Heap, this, x#0, S#2);
    assume _module.Node.Nexxxt#canCall($Heap, this, x#0, S#2);
    if (_module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null)
    {
        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(298,7)
        havoc j#21;
        if (0 <= j#21)
        {
            k#22 := x#0;
            S#23 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#23) && 0 <= k#22;
            assume _module.Node.Nexxxt#canCall($Heap, this, x#0, S#2);
            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2) != null;
            k#24 := j#21;
            S#25 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), S#25) && 0 <= k#24;
            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), j#21, S#2);
            k#26 := x#0 + j#21;
            S#27 := S#2;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#27) && 0 <= k#26;
            assume _module.Node.Nexxxt#canCall($Heap, this, x#0 + j#21, S#2);
        }

        assume (forall j#28: int :: true ==> 0 <= j#28 ==> _module.Node.Nexxxt#canCall($Heap, this, x#0, S#2) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), j#28, S#2) && _module.Node.Nexxxt#canCall($Heap, this, x#0 + j#28, S#2));
        assert {:subsumption 0} (forall j#28: int :: (forall j$ih#8#29: int :: true ==> 0 <= j$ih#8#29 && j$ih#8#29 < j#28 ==> 0 <= j$ih#8#29 ==> _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), j$ih#8#29, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0 + j$ih#8#29, S#2)) && true ==> 0 <= j#28 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0, S#2), j#28, S#2) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, x#0 + j#28, S#2));
        assume (forall j#28: int :: true ==> 0 <= j#28 ==> _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0, S#2), j#28, S#2) == _module.Node.Nexxxt($LS($LZ), $Heap, this, x#0 + j#28, S#2));
    }
    else
    {
    }
}



procedure CheckWellformed$$_module.Node.Lemma__NullIsTerminal(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, d#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  free requires 0 == $ModuleContextHeight && 9 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Lemma__NullIsTerminal(this: ref, d#0: int, S#1: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#2: Set BoxType;
  var k#3: int;
  var k#4: int;
  var S#5: Set BoxType;
  var k#6: int;
  var S#7: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(311,16): initial state"} true;
    S#2 := S#1;
    assume _module.Node.IsClosed#canCall($Heap, this, S#1);
    if (_module.Node.IsClosed($Heap, this, S#1))
    {
    }

    assume _module.Node.IsClosed($Heap, this, S#1) && 0 <= d#0;
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(313,13): post-state"} true;
    havoc k#3;
    if (0 <= k#3)
    {
    }

    if (0 <= k#3 && k#3 < d#0)
    {
        k#4 := d#0;
        S#5 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#5) && 0 <= k#4;
        assume _module.Node.Nexxxt#canCall($Heap, this, d#0, S#1);
    }

    if (0 <= k#3 && k#3 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null)
    {
        k#6 := k#3;
        S#7 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#7) && 0 <= k#6;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#3, S#1);
    }

    assume (forall k#8: int :: true ==> 0 <= k#8 && k#8 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#8, S#1) != null);
}



procedure InterModuleCall$$_module.Node.Lemma__NullIsTerminal(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, d#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#1);
  requires 0 <= d#0;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#8: int :: (forall k$ih#1#9: int :: true ==> 0 <= k$ih#1#9 && k$ih#1#9 < k#8 ==> 0 <= k$ih#1#9 && k$ih#1#9 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#9, S#1) != null) && true ==> 0 <= k#8 && k#8 < d#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#8, S#1) != null);
  free ensures (forall k#8: int :: true ==> 0 <= k#8 && k#8 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#8, S#1) != null);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.Lemma__NullIsTerminal(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, d#0: int, S#1: Set BoxType where (forall $t#2: BoxType :: { S#1[$t#2] } S#1[$t#2] ==> $Unbox($t#2): ref == null || (read($Heap, $Unbox($t#2): ref, alloc) && dtype($Unbox($t#2): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#10: ref :: n#10 == null || (read($Heap, n#10, alloc) && dtype(n#10) == class._module.Node) ==> S#1[$Box(n#10)] && n#10 != null && read($Heap, n#10, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#10, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#11: ref :: n#11 == null || (read($Heap, n#11, alloc) && dtype(n#11) == class._module.Node) ==> S#1[$Box(n#11)] && n#11 != null && read($Heap, n#11, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#11, _module.Node.next))]);
  requires 0 <= d#0;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#8: int :: (forall k$ih#3#12: int :: true ==> 0 <= k$ih#3#12 && k$ih#3#12 < k#8 ==> 0 <= k$ih#3#12 && k$ih#3#12 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#3#12, S#1) != null) && true ==> 0 <= k#8 && k#8 < d#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#8, S#1) != null);
  free ensures (forall k#8: int :: true ==> 0 <= k#8 && k#8 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#8, S#1) != null);
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.Lemma__NullIsTerminal(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, d#0: int, S#1: Set BoxType where (forall $t#4: BoxType :: { S#1[$t#4] } S#1[$t#4] ==> $Unbox($t#4): ref == null || (read($Heap, $Unbox($t#4): ref, alloc) && dtype($Unbox($t#4): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 9 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#13: ref :: n#13 == null || (read($Heap, n#13, alloc) && dtype(n#13) == class._module.Node) ==> S#1[$Box(n#13)] && n#13 != null && read($Heap, n#13, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#13, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#14: ref :: n#14 == null || (read($Heap, n#14, alloc) && dtype(n#14) == class._module.Node) ==> S#1[$Box(n#14)] && n#14 != null && read($Heap, n#14, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#14, _module.Node.next))]);
  requires 0 <= d#0;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#8: int :: (forall k$ih#5#15: int :: true ==> 0 <= k$ih#5#15 && k$ih#5#15 < k#8 ==> 0 <= k$ih#5#15 && k$ih#5#15 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#5#15, S#1) != null) && true ==> 0 <= k#8 && k#8 < d#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#8, S#1) != null);
  free ensures (forall k#8: int :: true ==> 0 <= k#8 && k#8 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#8, S#1) != null);
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.Lemma__NullIsTerminal(this: ref, d#0: int, S#1: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#8: HeapType;
  var j#19: int;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: int;
  var $w0: bool;
  var k#20: int;
  var k#21: int;
  var S#22: Set BoxType;
  var k#23: int;
  var S#24: Set BoxType;
  var $decr0$0: int;
  var k#27: int;
  var S#28: Set BoxType;
  var k#29: int;
  var S#30: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(311,16): initial state"} true;
    $initHeapForallStmt#8 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#8 == $Heap;
    assume (forall $ih#d6#16: int, $ih#S7#17: Set BoxType :: (forall $t#9: BoxType :: { $ih#S7#17[$t#9] } $ih#S7#17[$t#9] ==> $Unbox($t#9): ref == null || (read($initHeapForallStmt#8, $Unbox($t#9): ref, alloc) && dtype($Unbox($t#9): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#8, this, $ih#S7#17) && 0 <= $ih#d6#16 && ((0 <= $ih#d6#16 && $ih#d6#16 < d#0) || ($ih#d6#16 == d#0 && Set#Subset($ih#S7#17, S#1) && !Set#Subset(S#1, $ih#S7#17))) ==> (forall k#18: int :: true ==> 0 <= k#18 && k#18 < $ih#d6#16 && _module.Node.Nexxxt($LS($LZ), $Heap, this, $ih#d6#16, $ih#S7#17) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#18, $ih#S7#17) != null));
    $_reverifyPost := false;
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(315,9)
    // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(315,11)
    assume true;
    assume true;
    j#19 := d#0;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(315,11)"} true;
    // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(316,5)
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := j#19 - 0;
    havoc $w0;
    while (true)
      free invariant $w0 ==> 0 <= j#19 ==> true;
      invariant $w0 ==> 0 <= j#19;
      invariant $w0 ==> j#19 <= d#0;
      free invariant $w0 ==> (forall k#25: int :: true ==> (j#19 <= k#25 ==> true) && (j#19 <= k#25 && k#25 < d#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#25, S#1)) && (j#19 <= k#25 && k#25 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#25, S#1) == null ==> _module.Node.Nexxxt#canCall($Heap, this, d#0, S#1)));
      invariant $w0 ==> (forall k#25: int :: (forall k$ih#10#26: int :: true ==> 0 <= k$ih#10#26 && k$ih#10#26 < k#25 ==> j#19 <= k$ih#10#26 && k$ih#10#26 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#10#26, S#1) == null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) == null) && true ==> j#19 <= k#25 && k#25 < d#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#25, S#1) == null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, d#0, S#1) == null);
      free invariant $w0 ==> (forall k#25: int :: true ==> j#19 <= k#25 && k#25 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#25, S#1) == null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) == null);
      free invariant $PreLoopHeap0 == $Heap;
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
      free invariant j#19 - 0 <= $decr0$init$0 && (j#19 - 0 == $decr0$init$0 ==> true);
    {
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(316,5): after some loop iterations"} true;
        if (!$w0)
        {
            if (0 <= j#19)
            {
            }

            assume 0 <= j#19 ==> true;
            assume 0 <= j#19 && j#19 <= d#0;
            havoc k#20;
            if (j#19 <= k#20)
            {
            }

            if (j#19 <= k#20 && k#20 < d#0)
            {
                k#21 := k#20;
                S#22 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#22) && 0 <= k#21;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#20, S#1);
            }

            if (j#19 <= k#20 && k#20 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#20, S#1) == null)
            {
                k#23 := d#0;
                S#24 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#24) && 0 <= k#23;
                assume _module.Node.Nexxxt#canCall($Heap, this, d#0, S#1);
            }

            assume (forall k#25: int :: true ==> (j#19 <= k#25 ==> true) && (j#19 <= k#25 && k#25 < d#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#25, S#1)) && (j#19 <= k#25 && k#25 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#25, S#1) == null ==> _module.Node.Nexxxt#canCall($Heap, this, d#0, S#1)));
            assume (forall k#25: int :: true ==> j#19 <= k#25 && k#25 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#25, S#1) == null ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, d#0, S#1) == null);
            assume true;
            assume false;
        }

        assume true;
        if (j#19 <= 0)
        {
            break;
        }

        $decr0$0 := j#19 - 0;
        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(320,9)
        assume true;
        assume true;
        j#19 := j#19 - 1;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(320,9)"} true;
        // ----- if statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(321,7)
        k#27 := j#19;
        S#28 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#28) && 0 <= k#27;
        assume _module.Node.Nexxxt#canCall($Heap, this, j#19, S#1);
        assume _module.Node.Nexxxt#canCall($Heap, this, j#19, S#1);
        if (_module.Node.Nexxxt($LS($LZ), $Heap, this, j#19, S#1) == null)
        {
            // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(322,9)
            k#29 := j#19 + 1;
            S#30 := S#1;
            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#30) && 0 <= k#29;
            assume _module.Node.Nexxxt#canCall($Heap, this, j#19 + 1, S#1);
            assume _module.Node.Nexxxt#canCall($Heap, this, j#19 + 1, S#1);
            assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, j#19 + 1, S#1) == null;
            assume _module.Node.Nexxxt($LS($LZ), $Heap, this, j#19 + 1, S#1) == null;
        }
        else
        {
        }

        assert 0 <= $decr0$0 || j#19 - 0 == $decr0$0;
        assert j#19 - 0 < $decr0$0;
        assume 0 <= j#19 ==> true;
        assume (forall k#25: int :: true ==> (j#19 <= k#25 ==> true) && (j#19 <= k#25 && k#25 < d#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#25, S#1)) && (j#19 <= k#25 && k#25 < d#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#25, S#1) == null ==> _module.Node.Nexxxt#canCall($Heap, this, d#0, S#1)));
    }
}



procedure CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  free requires 0 == $ModuleContextHeight && 8 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles(this: ref, n#0: int, S#1: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#2: Set BoxType;
  var k#3: int;
  var S#4: Set BoxType;
  var k#5: int;
  var l#6: int;
  var k#7: int;
  var S#8: Set BoxType;
  var k#9: int;
  var S#10: Set BoxType;
  var k#11: int;
  var S#12: Set BoxType;
  var k#13: int;
  var S#14: Set BoxType;
  var k#15: int;
  var S#16: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(327,16): initial state"} true;
    S#2 := S#1;
    assume _module.Node.IsClosed#canCall($Heap, this, S#1);
    if (_module.Node.IsClosed($Heap, this, S#1))
    {
    }

    if (_module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0)
    {
        k#3 := n#0;
        S#4 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#4) && 0 <= k#3;
        assume _module.Node.Nexxxt#canCall($Heap, this, n#0, S#1);
    }

    assume _module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, n#0, S#1) == null;
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(329,13): post-state"} true;
    havoc k#5;
    havoc l#6;
    if (0 <= k#5)
    {
    }

    if (0 <= k#5 && 0 <= l#6)
    {
        k#7 := k#5;
        S#8 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#8) && 0 <= k#7;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    if (0 <= k#5 && 0 <= l#6 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null)
    {
        k#9 := k#5;
        S#10 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#10) && 0 <= k#9;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
    }

    if (0 <= k#5 && 0 <= l#6 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null)
    {
        k#11 := k#5;
        S#12 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#12) && 0 <= k#11;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
        assert read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null;
        k#13 := l#6;
        S#14 := S#1;
        assert _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), S#14) && 0 <= k#13;
        assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), l#6, S#1);
        k#15 := k#5;
        S#16 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#16) && 0 <= k#15;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    assume !(exists k#17: int, l#18: int :: 0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
}



procedure InterModuleCall$$_module.Node.Lemma__NullImpliesNoCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#1);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures !(exists k#17: int, l#18: int :: (forall k$ih#1#19: int, l$ih#2#20: int :: true ==> (0 <= k$ih#1#19 && k$ih#1#19 < k#17) || (k$ih#1#19 == k#17 && 0 <= l$ih#2#20 && l$ih#2#20 < l#18) ==> !(0 <= k$ih#1#19 && 0 <= l$ih#2#20 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next), l$ih#2#20, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1))) && true && 0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures !(exists k#17: int, l#18: int :: 0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#3: BoxType :: { S#1[$t#3] } S#1[$t#3] ==> $Unbox($t#3): ref == null || (read($Heap, $Unbox($t#3): ref, alloc) && dtype($Unbox($t#3): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#21: ref :: n#21 == null || (read($Heap, n#21, alloc) && dtype(n#21) == class._module.Node) ==> S#1[$Box(n#21)] && n#21 != null && read($Heap, n#21, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#21, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#22: ref :: n#22 == null || (read($Heap, n#22, alloc) && dtype(n#22) == class._module.Node) ==> S#1[$Box(n#22)] && n#22 != null && read($Heap, n#22, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#22, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures !(exists k#17: int, l#18: int :: (forall k$ih#4#23: int, l$ih#5#24: int :: true ==> (0 <= k$ih#4#23 && k$ih#4#23 < k#17) || (k$ih#4#23 == k#17 && 0 <= l$ih#5#24 && l$ih#5#24 < l#18) ==> !(0 <= k$ih#4#23 && 0 <= l$ih#5#24 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next), l$ih#5#24, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1))) && true && 0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures !(exists k#17: int, l#18: int :: 0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.Lemma__NullImpliesNoCycles(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#6: BoxType :: { S#1[$t#6] } S#1[$t#6] ==> $Unbox($t#6): ref == null || (read($Heap, $Unbox($t#6): ref, alloc) && dtype($Unbox($t#6): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 8 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#25: ref :: n#25 == null || (read($Heap, n#25, alloc) && dtype(n#25) == class._module.Node) ==> S#1[$Box(n#25)] && n#25 != null && read($Heap, n#25, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#25, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#26: ref :: n#26 == null || (read($Heap, n#26, alloc) && dtype(n#26) == class._module.Node) ==> S#1[$Box(n#26)] && n#26 != null && read($Heap, n#26, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#26, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures !(exists k#17: int, l#18: int :: (forall k$ih#7#27: int, l$ih#8#28: int :: true ==> (0 <= k$ih#7#27 && k$ih#7#27 < k#17) || (k$ih#7#27 == k#17 && 0 <= l$ih#8#28 && l$ih#8#28 < l#18) ==> !(0 <= k$ih#7#27 && 0 <= l$ih#8#28 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next), l$ih#8#28, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1))) && true && 0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures !(exists k#17: int, l#18: int :: 0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.Lemma__NullImpliesNoCycles(this: ref, n#0: int, S#1: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#10: HeapType;
  var n##32: int;
  var S##33: Set BoxType;
  var n##34: int;
  var S##35: Set BoxType;
  var n##36: int;
  var S##37: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(327,16): initial state"} true;
    $initHeapForallStmt#10 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#10 == $Heap;
    assume (forall $ih#S9#29: Set BoxType :: (forall $t#11: BoxType :: { $ih#S9#29[$t#11] } $ih#S9#29[$t#11] ==> $Unbox($t#11): ref == null || (read($initHeapForallStmt#10, $Unbox($t#11): ref, alloc) && dtype($Unbox($t#11): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#10, this, $ih#S9#29) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, n#0, $ih#S9#29) == null && ((0 <= n#0 && n#0 < n#0) || (n#0 == n#0 && Set#Subset($ih#S9#29, S#1) && !Set#Subset(S#1, $ih#S9#29))) ==> !(exists k#30: int, l#31: int :: 0 <= k#30 && 0 <= l#31 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next) != null && _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next), l#31, $ih#S9#29) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29)));
    $_reverifyPost := false;
    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(333,5)
    assume true;
    n##32 := n#0;
    assume true;
    S##33 := S#1;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part0(this, n##32, S##33);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(333,5)"} true;
    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(334,5)
    assume true;
    n##34 := n#0;
    assume true;
    S##35 := S#1;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part1(this, n##34, S##35);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(334,5)"} true;
    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(335,5)
    assume true;
    n##36 := n#0;
    assume true;
    S##37 := S#1;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part2(this, n##36, S##37);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(335,5)"} true;
}



procedure CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles__part0(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  free requires 0 == $ModuleContextHeight && 5 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles__part0(this: ref, n#0: int, S#1: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#2: Set BoxType;
  var k#3: int;
  var S#4: Set BoxType;
  var k#5: int;
  var l#6: int;
  var k#7: int;
  var S#8: Set BoxType;
  var k#9: int;
  var S#10: Set BoxType;
  var k#11: int;
  var S#12: Set BoxType;
  var k#13: int;
  var S#14: Set BoxType;
  var k#15: int;
  var S#16: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(338,16): initial state"} true;
    S#2 := S#1;
    assume _module.Node.IsClosed#canCall($Heap, this, S#1);
    if (_module.Node.IsClosed($Heap, this, S#1))
    {
    }

    if (_module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0)
    {
        k#3 := n#0;
        S#4 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#4) && 0 <= k#3;
        assume _module.Node.Nexxxt#canCall($Heap, this, n#0, S#1);
    }

    assume _module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, n#0, S#1) == null;
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(340,13): post-state"} true;
    havoc k#5;
    havoc l#6;
    if (n#0 <= k#5)
    {
    }

    if (n#0 <= k#5 && 0 <= l#6)
    {
        k#7 := k#5;
        S#8 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#8) && 0 <= k#7;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    if (n#0 <= k#5 && 0 <= l#6 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null)
    {
        k#9 := k#5;
        S#10 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#10) && 0 <= k#9;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
    }

    if (n#0 <= k#5 && 0 <= l#6 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null)
    {
        k#11 := k#5;
        S#12 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#12) && 0 <= k#11;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
        assert read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null;
        k#13 := l#6;
        S#14 := S#1;
        assert _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), S#14) && 0 <= k#13;
        assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), l#6, S#1);
        k#15 := k#5;
        S#16 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#16) && 0 <= k#15;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    assume (forall k#17: int, l#18: int :: true ==> n#0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
}



procedure InterModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part0(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#1);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#1#19: int, l$ih#2#20: int :: true ==> (0 <= k$ih#1#19 && k$ih#1#19 < k#17) || (k$ih#1#19 == k#17 && 0 <= l$ih#2#20 && l$ih#2#20 < l#18) ==> n#0 <= k$ih#1#19 && 0 <= l$ih#2#20 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next), l$ih#2#20, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1)) && true ==> n#0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> n#0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part0(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#3: BoxType :: { S#1[$t#3] } S#1[$t#3] ==> $Unbox($t#3): ref == null || (read($Heap, $Unbox($t#3): ref, alloc) && dtype($Unbox($t#3): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#21: ref :: n#21 == null || (read($Heap, n#21, alloc) && dtype(n#21) == class._module.Node) ==> S#1[$Box(n#21)] && n#21 != null && read($Heap, n#21, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#21, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#22: ref :: n#22 == null || (read($Heap, n#22, alloc) && dtype(n#22) == class._module.Node) ==> S#1[$Box(n#22)] && n#22 != null && read($Heap, n#22, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#22, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#4#23: int, l$ih#5#24: int :: true ==> (0 <= k$ih#4#23 && k$ih#4#23 < k#17) || (k$ih#4#23 == k#17 && 0 <= l$ih#5#24 && l$ih#5#24 < l#18) ==> n#0 <= k$ih#4#23 && 0 <= l$ih#5#24 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next), l$ih#5#24, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1)) && true ==> n#0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> n#0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.Lemma__NullImpliesNoCycles__part0(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#6: BoxType :: { S#1[$t#6] } S#1[$t#6] ==> $Unbox($t#6): ref == null || (read($Heap, $Unbox($t#6): ref, alloc) && dtype($Unbox($t#6): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 5 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#25: ref :: n#25 == null || (read($Heap, n#25, alloc) && dtype(n#25) == class._module.Node) ==> S#1[$Box(n#25)] && n#25 != null && read($Heap, n#25, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#25, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#26: ref :: n#26 == null || (read($Heap, n#26, alloc) && dtype(n#26) == class._module.Node) ==> S#1[$Box(n#26)] && n#26 != null && read($Heap, n#26, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#26, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#7#27: int, l$ih#8#28: int :: true ==> (0 <= k$ih#7#27 && k$ih#7#27 < k#17) || (k$ih#7#27 == k#17 && 0 <= l$ih#8#28 && l$ih#8#28 < l#18) ==> n#0 <= k$ih#7#27 && 0 <= l$ih#8#28 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next), l$ih#8#28, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1)) && true ==> n#0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> n#0 <= k#17 && 0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.Lemma__NullImpliesNoCycles__part0(this: ref, n#0: int, S#1: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#10: HeapType;
  var k#32: int;
  var k#33: int;
  var S#34: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(338,16): initial state"} true;
    $initHeapForallStmt#10 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#10 == $Heap;
    assume (forall $ih#S9#29: Set BoxType :: (forall $t#11: BoxType :: { $ih#S9#29[$t#11] } $ih#S9#29[$t#11] ==> $Unbox($t#11): ref == null || (read($initHeapForallStmt#10, $Unbox($t#11): ref, alloc) && dtype($Unbox($t#11): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#10, this, $ih#S9#29) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, n#0, $ih#S9#29) == null && ((0 <= n#0 && n#0 < n#0) || (n#0 == n#0 && Set#Subset($ih#S9#29, S#1) && !Set#Subset(S#1, $ih#S9#29))) ==> (forall k#30: int, l#31: int :: true ==> n#0 <= k#30 && 0 <= l#31 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next), l#31, $ih#S9#29) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29)));
    $_reverifyPost := false;
    // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(342,5)
    havoc k#32;
    if (n#0 <= k#32)
    {
        k#33 := k#32;
        S#34 := S#1;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#34) && 0 <= k#33;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#32, S#1);
    }

    assume (forall k#35: int :: true ==> n#0 <= k#35 ==> _module.Node.Nexxxt#canCall($Heap, this, k#35, S#1));
    assert {:subsumption 0} (forall k#35: int :: (forall k$ih#12#36: int :: true ==> 0 <= k$ih#12#36 && k$ih#12#36 < k#35 ==> n#0 <= k$ih#12#36 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#36, S#1) == null) && true ==> n#0 <= k#35 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#35, S#1) == null);
    assume (forall k#35: int :: true ==> n#0 <= k#35 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, k#35, S#1) == null);
}



procedure CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles__part1(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  free requires 0 == $ModuleContextHeight && 6 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles__part1(this: ref, n#0: int, S#1: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#2: Set BoxType;
  var k#3: int;
  var S#4: Set BoxType;
  var k#5: int;
  var l#6: int;
  var k#7: int;
  var S#8: Set BoxType;
  var k#9: int;
  var S#10: Set BoxType;
  var k#11: int;
  var S#12: Set BoxType;
  var k#13: int;
  var S#14: Set BoxType;
  var k#15: int;
  var S#16: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(345,16): initial state"} true;
    S#2 := S#1;
    assume _module.Node.IsClosed#canCall($Heap, this, S#1);
    if (_module.Node.IsClosed($Heap, this, S#1))
    {
    }

    if (_module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0)
    {
        k#3 := n#0;
        S#4 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#4) && 0 <= k#3;
        assume _module.Node.Nexxxt#canCall($Heap, this, n#0, S#1);
    }

    assume _module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, n#0, S#1) == null;
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(347,13): post-state"} true;
    havoc k#5;
    havoc l#6;
    if (0 <= k#5)
    {
    }

    if (0 <= k#5 && n#0 <= l#6)
    {
        k#7 := k#5;
        S#8 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#8) && 0 <= k#7;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    if (0 <= k#5 && n#0 <= l#6 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null)
    {
        k#9 := k#5;
        S#10 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#10) && 0 <= k#9;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
    }

    if (0 <= k#5 && n#0 <= l#6 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null)
    {
        k#11 := k#5;
        S#12 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#12) && 0 <= k#11;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
        assert read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null;
        k#13 := l#6;
        S#14 := S#1;
        assert _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), S#14) && 0 <= k#13;
        assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), l#6, S#1);
        k#15 := k#5;
        S#16 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#16) && 0 <= k#15;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    assume (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && n#0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
}



procedure InterModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part1(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#1);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#1#19: int, l$ih#2#20: int :: true ==> (0 <= k$ih#1#19 && k$ih#1#19 < k#17) || (k$ih#1#19 == k#17 && 0 <= l$ih#2#20 && l$ih#2#20 < l#18) ==> 0 <= k$ih#1#19 && n#0 <= l$ih#2#20 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next), l$ih#2#20, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1)) && true ==> 0 <= k#17 && n#0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && n#0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part1(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#3: BoxType :: { S#1[$t#3] } S#1[$t#3] ==> $Unbox($t#3): ref == null || (read($Heap, $Unbox($t#3): ref, alloc) && dtype($Unbox($t#3): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#21: ref :: n#21 == null || (read($Heap, n#21, alloc) && dtype(n#21) == class._module.Node) ==> S#1[$Box(n#21)] && n#21 != null && read($Heap, n#21, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#21, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#22: ref :: n#22 == null || (read($Heap, n#22, alloc) && dtype(n#22) == class._module.Node) ==> S#1[$Box(n#22)] && n#22 != null && read($Heap, n#22, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#22, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#4#23: int, l$ih#5#24: int :: true ==> (0 <= k$ih#4#23 && k$ih#4#23 < k#17) || (k$ih#4#23 == k#17 && 0 <= l$ih#5#24 && l$ih#5#24 < l#18) ==> 0 <= k$ih#4#23 && n#0 <= l$ih#5#24 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next), l$ih#5#24, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1)) && true ==> 0 <= k#17 && n#0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && n#0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.Lemma__NullImpliesNoCycles__part1(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#6: BoxType :: { S#1[$t#6] } S#1[$t#6] ==> $Unbox($t#6): ref == null || (read($Heap, $Unbox($t#6): ref, alloc) && dtype($Unbox($t#6): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 6 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#25: ref :: n#25 == null || (read($Heap, n#25, alloc) && dtype(n#25) == class._module.Node) ==> S#1[$Box(n#25)] && n#25 != null && read($Heap, n#25, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#25, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#26: ref :: n#26 == null || (read($Heap, n#26, alloc) && dtype(n#26) == class._module.Node) ==> S#1[$Box(n#26)] && n#26 != null && read($Heap, n#26, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#26, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#7#27: int, l$ih#8#28: int :: true ==> (0 <= k$ih#7#27 && k$ih#7#27 < k#17) || (k$ih#7#27 == k#17 && 0 <= l$ih#8#28 && l$ih#8#28 < l#18) ==> 0 <= k$ih#7#27 && n#0 <= l$ih#8#28 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next), l$ih#8#28, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1)) && true ==> 0 <= k#17 && n#0 <= l#18 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && n#0 <= l#18 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.Lemma__NullImpliesNoCycles__part1(this: ref, n#0: int, S#1: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#10: HeapType;
  var k#32: int;
  var l#33: int;
  var k#34: int;
  var S#35: Set BoxType;
  var k#36: int;
  var S#37: Set BoxType;
  var k#38: int;
  var S#39: Set BoxType;
  var k#40: int;
  var S#41: Set BoxType;
  var k#42: int;
  var S#43: Set BoxType;
  var kl#48: int;
  var k#49: int;
  var S#50: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(345,16): initial state"} true;
    $initHeapForallStmt#10 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#10 == $Heap;
    assume (forall $ih#S9#29: Set BoxType :: (forall $t#11: BoxType :: { $ih#S9#29[$t#11] } $ih#S9#29[$t#11] ==> $Unbox($t#11): ref == null || (read($initHeapForallStmt#10, $Unbox($t#11): ref, alloc) && dtype($Unbox($t#11): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#10, this, $ih#S9#29) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, n#0, $ih#S9#29) == null && ((0 <= n#0 && n#0 < n#0) || (n#0 == n#0 && Set#Subset($ih#S9#29, S#1) && !Set#Subset(S#1, $ih#S9#29))) ==> (forall k#30: int, l#31: int :: true ==> 0 <= k#30 && n#0 <= l#31 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next), l#31, $ih#S9#29) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29)));
    $_reverifyPost := false;
    // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(350,5)
    havoc k#32;
    havoc l#33;
    if (0 <= k#32)
    {
    }

    if (0 <= k#32 && 0 <= l#33)
    {
        k#34 := k#32;
        S#35 := S#1;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#35) && 0 <= k#34;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#32, S#1);
    }

    if (0 <= k#32 && 0 <= l#33 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1) != null)
    {
        k#36 := k#32;
        S#37 := S#1;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#37) && 0 <= k#36;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#32, S#1);
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1) != null;
    }

    if (0 <= k#32 && 0 <= l#33 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1), _module.Node.next) != null)
    {
        k#38 := k#32;
        S#39 := S#1;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#39) && 0 <= k#38;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#32, S#1);
        assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1) != null;
        assert {:subsumption 0} read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1), _module.Node.next) != null;
        k#40 := l#33;
        S#41 := S#1;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1), _module.Node.next), S#41) && 0 <= k#40;
        assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#32, S#1), _module.Node.next), l#33, S#1);
        k#42 := k#32 + 1 + l#33;
        S#43 := S#1;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#43) && 0 <= k#42;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#32 + 1 + l#33, S#1);
    }

    assume (forall k#44: int, l#45: int :: true ==> (0 <= k#44 ==> true) && (0 <= k#44 && 0 <= l#45 ==> _module.Node.Nexxxt#canCall($Heap, this, k#44, S#1)) && (0 <= k#44 && 0 <= l#45 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#44, S#1)) && (0 <= k#44 && 0 <= l#45 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#44, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44, S#1), _module.Node.next), l#45, S#1) && _module.Node.Nexxxt#canCall($Heap, this, k#44 + 1 + l#45, S#1)));
    assert {:subsumption 0} (forall k#44: int, l#45: int :: (forall k$ih#12#46: int, l$ih#13#47: int :: true ==> (0 <= k$ih#12#46 && k$ih#12#46 < k#44) || (k$ih#12#46 == k#44 && 0 <= l$ih#13#47 && l$ih#13#47 < l#45) ==> 0 <= k$ih#12#46 && 0 <= l$ih#13#47 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#46, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#46, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#46, S#1), _module.Node.next), l$ih#13#47, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#46 + 1 + l$ih#13#47, S#1)) && true ==> 0 <= k#44 && 0 <= l#45 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#44, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#44, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#44, S#1), _module.Node.next), l#45, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#44 + 1 + l#45, S#1));
    assume (forall k#44: int, l#45: int :: true ==> 0 <= k#44 && 0 <= l#45 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44, S#1), _module.Node.next), l#45, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, k#44 + 1 + l#45, S#1));
    // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(351,5)
    havoc kl#48;
    if (n#0 <= kl#48)
    {
        k#49 := kl#48;
        S#50 := S#1;
        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#50) && 0 <= k#49;
        assume _module.Node.Nexxxt#canCall($Heap, this, kl#48, S#1);
    }

    assume (forall kl#51: int :: true ==> n#0 <= kl#51 ==> _module.Node.Nexxxt#canCall($Heap, this, kl#51, S#1));
    assert {:subsumption 0} (forall kl#51: int :: (forall kl$ih#14#52: int :: true ==> 0 <= kl$ih#14#52 && kl$ih#14#52 < kl#51 ==> n#0 <= kl$ih#14#52 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, kl$ih#14#52, S#1) == null) && true ==> n#0 <= kl#51 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kl#51, S#1) == null);
    assume (forall kl#51: int :: true ==> n#0 <= kl#51 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, kl#51, S#1) == null);
}



procedure CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles__part2(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  free requires 0 == $ModuleContextHeight && 7 == $FunctionContextHeight;
  modifies $Heap, $Tick;



implementation CheckWellformed$$_module.Node.Lemma__NullImpliesNoCycles__part2(this: ref, n#0: int, S#1: Set BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var S#2: Set BoxType;
  var k#3: int;
  var S#4: Set BoxType;
  var k#5: int;
  var l#6: int;
  var k#7: int;
  var S#8: Set BoxType;
  var k#9: int;
  var S#10: Set BoxType;
  var k#11: int;
  var S#12: Set BoxType;
  var k#13: int;
  var S#14: Set BoxType;
  var k#15: int;
  var S#16: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(354,16): initial state"} true;
    S#2 := S#1;
    assume _module.Node.IsClosed#canCall($Heap, this, S#1);
    if (_module.Node.IsClosed($Heap, this, S#1))
    {
    }

    if (_module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0)
    {
        k#3 := n#0;
        S#4 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#4) && 0 <= k#3;
        assume _module.Node.Nexxxt#canCall($Heap, this, n#0, S#1);
    }

    assume _module.Node.IsClosed($Heap, this, S#1) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, n#0, S#1) == null;
    havoc $Heap;
    assume old($Heap) == $Heap;
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(356,13): post-state"} true;
    havoc k#5;
    havoc l#6;
    if (0 <= k#5)
    {
    }

    if (0 <= k#5 && k#5 < n#0)
    {
        if (0 <= l#6)
        {
        }
    }

    if (0 <= k#5 && k#5 < n#0 && 0 <= l#6 && l#6 < n#0)
    {
        k#7 := k#5;
        S#8 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#8) && 0 <= k#7;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    if (0 <= k#5 && k#5 < n#0 && 0 <= l#6 && l#6 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null)
    {
        k#9 := k#5;
        S#10 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#10) && 0 <= k#9;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
    }

    if (0 <= k#5 && k#5 < n#0 && 0 <= l#6 && l#6 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null)
    {
        k#11 := k#5;
        S#12 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#12) && 0 <= k#11;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1) != null;
        assert read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next) != null;
        k#13 := l#6;
        S#14 := S#1;
        assert _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), S#14) && 0 <= k#13;
        assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#5, S#1), _module.Node.next), l#6, S#1);
        k#15 := k#5;
        S#16 := S#1;
        assert _module.Node.IsClosed($Heap, this, S#16) && 0 <= k#15;
        assume _module.Node.Nexxxt#canCall($Heap, this, k#5, S#1);
    }

    assume (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && k#17 < n#0 && 0 <= l#18 && l#18 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
}



procedure InterModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part2(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#0: BoxType :: { S#1[$t#0] } S#1[$t#0] ==> $Unbox($t#0): ref == null || (read($Heap, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed($Heap, this, S#1);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#1#19: int, l$ih#2#20: int :: true ==> (0 <= k$ih#1#19 && k$ih#1#19 < k#17) || (k$ih#1#19 == k#17 && 0 <= l$ih#2#20 && l$ih#2#20 < l#18) ==> 0 <= k$ih#1#19 && k$ih#1#19 < n#0 && 0 <= l$ih#2#20 && l$ih#2#20 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1), _module.Node.next), l$ih#2#20, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#1#19, S#1)) && true ==> 0 <= k#17 && k#17 < n#0 && 0 <= l#18 && l#18 < n#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && k#17 < n#0 && 0 <= l#18 && l#18 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure IntraModuleCall$$_module.Node.Lemma__NullImpliesNoCycles__part2(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#3: BoxType :: { S#1[$t#3] } S#1[$t#3] ==> $Unbox($t#3): ref == null || (read($Heap, $Unbox($t#3): ref, alloc) && dtype($Unbox($t#3): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null));
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#21: ref :: n#21 == null || (read($Heap, n#21, alloc) && dtype(n#21) == class._module.Node) ==> S#1[$Box(n#21)] && n#21 != null && read($Heap, n#21, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#21, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#22: ref :: n#22 == null || (read($Heap, n#22, alloc) && dtype(n#22) == class._module.Node) ==> S#1[$Box(n#22)] && n#22 != null && read($Heap, n#22, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#22, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#4#23: int, l$ih#5#24: int :: true ==> (0 <= k$ih#4#23 && k$ih#4#23 < k#17) || (k$ih#4#23 == k#17 && 0 <= l$ih#5#24 && l$ih#5#24 < l#18) ==> 0 <= k$ih#4#23 && k$ih#4#23 < n#0 && 0 <= l$ih#5#24 && l$ih#5#24 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1), _module.Node.next), l$ih#5#24, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#4#23, S#1)) && true ==> 0 <= k#17 && k#17 < n#0 && 0 <= l#18 && l#18 < n#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && k#17 < n#0 && 0 <= l#18 && l#18 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



procedure Impl$$_module.Node.Lemma__NullImpliesNoCycles__part2(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class._module.Node, n#0: int, S#1: Set BoxType where (forall $t#6: BoxType :: { S#1[$t#6] } S#1[$t#6] ==> $Unbox($t#6): ref == null || (read($Heap, $Unbox($t#6): ref, alloc) && dtype($Unbox($t#6): ref) == class._module.Node)) && $IsGoodSet_Extended(S#1, null)) returns ($_reverifyPost: bool);
  free requires 0 == $ModuleContextHeight && 7 == $FunctionContextHeight;
  // user-defined preconditions
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(this)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || S#1[$Box(null)];
  requires _module.Node.IsClosed#canCall($Heap, this, S#1) ==> _module.Node.IsClosed($Heap, this, S#1) || (forall n#25: ref :: n#25 == null || (read($Heap, n#25, alloc) && dtype(n#25) == class._module.Node) ==> S#1[$Box(n#25)] && n#25 != null && read($Heap, n#25, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#25, _module.Node.next))]);
  free requires _module.Node.IsClosed#canCall($Heap, this, S#1) && _module.Node.IsClosed($Heap, this, S#1) && S#1[$Box(this)] && S#1[$Box(null)] && (forall n#26: ref :: n#26 == null || (read($Heap, n#26, alloc) && dtype(n#26) == class._module.Node) ==> S#1[$Box(n#26)] && n#26 != null && read($Heap, n#26, _module.Node.next) != null ==> S#1[$Box(read($Heap, n#26, _module.Node.next))]);
  requires 0 <= n#0;
  requires _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, n#0, S#1) == null;
  modifies $Heap, $Tick;
  // user-defined postconditions
  ensures (forall k#17: int, l#18: int :: (forall k$ih#7#27: int, l$ih#8#28: int :: true ==> (0 <= k$ih#7#27 && k$ih#7#27 < k#17) || (k$ih#7#27 == k#17 && 0 <= l$ih#8#28 && l$ih#8#28 < l#18) ==> 0 <= k$ih#7#27 && k$ih#7#27 < n#0 && 0 <= l$ih#8#28 && l$ih#8#28 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1), _module.Node.next), l$ih#8#28, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#7#27, S#1)) && true ==> 0 <= k#17 && k#17 < n#0 && 0 <= l#18 && l#18 < n#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#17, S#1));
  free ensures (forall k#17: int, l#18: int :: true ==> 0 <= k#17 && k#17 < n#0 && 0 <= l#18 && l#18 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1), _module.Node.next), l#18, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#17, S#1));
  // frame condition
  free ensures old($Heap) == $Heap;



implementation Impl$$_module.Node.Lemma__NullImpliesNoCycles__part2(this: ref, n#0: int, S#1: Set BoxType) returns ($_reverifyPost: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $initHeapForallStmt#10: HeapType;
  var kn#32: int;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: int;
  var $w0: bool;
  var k#33: int;
  var l#34: int;
  var k#35: int;
  var S#36: Set BoxType;
  var k#37: int;
  var S#38: Set BoxType;
  var k#39: int;
  var S#40: Set BoxType;
  var k#41: int;
  var S#42: Set BoxType;
  var k#43: int;
  var S#44: Set BoxType;
  var $decr0$0: int;
  var ln#49: int;
  var $PreLoopHeap1: HeapType;
  var $decr1$init$0: int;
  var $w1: bool;
  var k#50: int;
  var l#51: int;
  var k#52: int;
  var S#53: Set BoxType;
  var k#54: int;
  var S#55: Set BoxType;
  var k#56: int;
  var S#57: Set BoxType;
  var k#58: int;
  var S#59: Set BoxType;
  var k#60: int;
  var S#61: Set BoxType;
  var l#66: int;
  var k#67: int;
  var S#68: Set BoxType;
  var k#69: int;
  var S#70: Set BoxType;
  var k#71: int;
  var S#72: Set BoxType;
  var k#73: int;
  var S#74: Set BoxType;
  var k#75: int;
  var S#76: Set BoxType;
  var $decr1$0: int;
  var k#79: int;
  var S#80: Set BoxType;
  var k#81: int;
  var S#82: Set BoxType;
  var k#83: int;
  var S#84: Set BoxType;
  var x##85: int;
  var y##86: int;
  var S##87: Set BoxType;
  var k#88: int;
  var S#89: Set BoxType;
  var k#90: int;
  var S#91: Set BoxType;
  var k#92: int;
  var S#93: Set BoxType;
  var x##94: int;
  var y##95: int;
  var S##96: Set BoxType;
  var k#97: int;
  var S#98: Set BoxType;
  var k#99: int;
  var S#100: Set BoxType;
  var k#101: int;
  var S#102: Set BoxType;
  var k#103: int;
  var S#104: Set BoxType;
  var k#105: int;
  var S#106: Set BoxType;
  var k#107: int;
  var S#108: Set BoxType;
  var nn#109: int;
  var $PreLoopHeap2: HeapType;
  var $decr2$init$0: int;
  var $w2: bool;
  var k#110: int;
  var S#111: Set BoxType;
  var k#112: int;
  var S#113: Set BoxType;
  var k#114: int;
  var S#115: Set BoxType;
  var $decr2$0: int;
  var k#116: int;
  var S#117: Set BoxType;
  var k#118: int;
  var S#119: Set BoxType;
  var k#120: int;
  var S#121: Set BoxType;
  var k#122: int;
  var S#123: Set BoxType;
  var k#124: int;
  var S#125: Set BoxType;
  var k#126: int;
  var S#127: Set BoxType;
  var k#128: int;
  var S#129: Set BoxType;
  var k#130: int;
  var S#131: Set BoxType;
  var k#132: int;
  var S#133: Set BoxType;
  var k#134: int;
  var S#135: Set BoxType;
  var k#136: int;
  var S#137: Set BoxType;
  var k#138: int;
  var S#139: Set BoxType;
  var x##140: int;
  var y##141: int;
  var S##142: Set BoxType;
  var k#143: int;
  var S#144: Set BoxType;
  var k#145: int;
  var S#146: Set BoxType;
  var k#147: int;
  var S#148: Set BoxType;
  var x##149: int;
  var y##150: int;
  var S##151: Set BoxType;
  var k#152: int;
  var S#153: Set BoxType;
  var k#154: int;
  var S#155: Set BoxType;
  var k#156: int;
  var S#157: Set BoxType;
  var j#158: int;
  var k#159: int;
  var S#160: Set BoxType;
  var k#163: int;
  var S#164: Set BoxType;
  var k#165: int;
  var S#166: Set BoxType;
  var k#167: int;
  var S#168: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(354,16): initial state"} true;
    $initHeapForallStmt#10 := $Heap;
    havoc $Heap, $Tick;
    assume $initHeapForallStmt#10 == $Heap;
    assume (forall $ih#S9#29: Set BoxType :: (forall $t#11: BoxType :: { $ih#S9#29[$t#11] } $ih#S9#29[$t#11] ==> $Unbox($t#11): ref == null || (read($initHeapForallStmt#10, $Unbox($t#11): ref, alloc) && dtype($Unbox($t#11): ref) == class._module.Node)) && _module.Node.IsClosed($initHeapForallStmt#10, this, $ih#S9#29) && 0 <= n#0 && _module.Node.Nexxxt($LS($LZ), $initHeapForallStmt#10, this, n#0, $ih#S9#29) == null && ((0 <= n#0 && n#0 < n#0) || (n#0 == n#0 && Set#Subset($ih#S9#29, S#1) && !Set#Subset(S#1, $ih#S9#29))) ==> (forall k#30: int, l#31: int :: true ==> 0 <= k#30 && k#30 < n#0 && 0 <= l#31 && l#31 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29), _module.Node.next), l#31, $ih#S9#29) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#30, $ih#S9#29)));
    $_reverifyPost := false;
    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(358,9)
    // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(358,12)
    assume true;
    assume true;
    kn#32 := Lit(0);
    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(358,12)"} true;
    // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(359,5)
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := n#0 - kn#32;
    havoc $w0;
    while (true)
      free invariant $w0 ==> 0 <= kn#32 ==> true;
      invariant $w0 ==> 0 <= kn#32;
      invariant $w0 ==> kn#32 <= n#0;
      free invariant $w0 ==> (forall k#45: int, l#46: int :: true ==> (0 <= k#45 ==> true) && (0 <= k#45 && k#45 < kn#32 ==> 0 <= l#46 ==> true) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next), l#46, S#1) && _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)));
      invariant $w0 ==> (forall k#45: int, l#46: int :: (forall k$ih#12#47: int, l$ih#13#48: int :: true ==> (0 <= k$ih#12#47 && k$ih#12#47 < k#45) || (k$ih#12#47 == k#45 && 0 <= l$ih#13#48 && l$ih#13#48 < l#46) ==> 0 <= k$ih#12#47 && k$ih#12#47 < kn#32 && 0 <= l$ih#13#48 && l$ih#13#48 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#47, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#47, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#47, S#1), _module.Node.next), l$ih#13#48, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#12#47, S#1)) && true ==> 0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#45, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#45, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#45, S#1), _module.Node.next), l#46, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#45, S#1));
      free invariant $w0 ==> (forall k#45: int, l#46: int :: true ==> 0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next), l#46, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1));
      free invariant $PreLoopHeap0 == $Heap;
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
      free invariant n#0 - kn#32 <= $decr0$init$0 && (n#0 - kn#32 == $decr0$init$0 ==> true);
    {
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(359,5): after some loop iterations"} true;
        if (!$w0)
        {
            if (0 <= kn#32)
            {
            }

            assume 0 <= kn#32 ==> true;
            assume 0 <= kn#32 && kn#32 <= n#0;
            havoc k#33;
            havoc l#34;
            if (0 <= k#33)
            {
            }

            if (0 <= k#33 && k#33 < kn#32)
            {
                if (0 <= l#34)
                {
                }
            }

            if (0 <= k#33 && k#33 < kn#32 && 0 <= l#34 && l#34 < n#0)
            {
                k#35 := k#33;
                S#36 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#36) && 0 <= k#35;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#33, S#1);
            }

            if (0 <= k#33 && k#33 < kn#32 && 0 <= l#34 && l#34 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1) != null)
            {
                k#37 := k#33;
                S#38 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#38) && 0 <= k#37;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#33, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1) != null;
            }

            if (0 <= k#33 && k#33 < kn#32 && 0 <= l#34 && l#34 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1), _module.Node.next) != null)
            {
                k#39 := k#33;
                S#40 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#40) && 0 <= k#39;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#33, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1) != null;
                assert {:subsumption 0} read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1), _module.Node.next) != null;
                k#41 := l#34;
                S#42 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1), _module.Node.next), S#42) && 0 <= k#41;
                assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#33, S#1), _module.Node.next), l#34, S#1);
                k#43 := k#33;
                S#44 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#44) && 0 <= k#43;
                assume _module.Node.Nexxxt#canCall($Heap, this, k#33, S#1);
            }

            assume (forall k#45: int, l#46: int :: true ==> (0 <= k#45 ==> true) && (0 <= k#45 && k#45 < kn#32 ==> 0 <= l#46 ==> true) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next), l#46, S#1) && _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)));
            assume (forall k#45: int, l#46: int :: true ==> 0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next), l#46, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1));
            assume true;
            assume false;
        }

        assume true;
        if (n#0 <= kn#32)
        {
            break;
        }

        $decr0$0 := n#0 - kn#32;
        // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(363,11)
        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(363,14)
        assume true;
        assume true;
        ln#49 := Lit(0);
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(363,14)"} true;
        // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(364,7)
        $PreLoopHeap1 := $Heap;
        $decr1$init$0 := n#0 - ln#49;
        havoc $w1;
        while (true)
          free invariant $w1 ==> 0 <= ln#49 ==> true;
          invariant $w1 ==> 0 <= ln#49;
          invariant $w1 ==> ln#49 <= n#0;
          free invariant $w1 ==> (forall k#62: int, l#63: int :: true ==> (0 <= k#62 ==> true) && (0 <= k#62 && k#62 < kn#32 ==> 0 <= l#63 ==> true) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next), l#63, S#1) && _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)));
          invariant $w1 ==> (forall k#62: int, l#63: int :: (forall k$ih#14#64: int, l$ih#15#65: int :: true ==> (0 <= k$ih#14#64 && k$ih#14#64 < k#62) || (k$ih#14#64 == k#62 && 0 <= l$ih#15#65 && l$ih#15#65 < l#63) ==> 0 <= k$ih#14#64 && k$ih#14#64 < kn#32 && 0 <= l$ih#15#65 && l$ih#15#65 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#14#64, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#14#64, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#14#64, S#1), _module.Node.next), l$ih#15#65, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k$ih#14#64, S#1)) && true ==> 0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#62, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#62, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#62, S#1), _module.Node.next), l#63, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, k#62, S#1));
          free invariant $w1 ==> (forall k#62: int, l#63: int :: true ==> 0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next), l#63, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1));
          free invariant $w1 ==> (forall l#77: int :: true ==> (0 <= l#77 ==> true) && (0 <= l#77 && l#77 < ln#49 ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)) && (0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)) && (0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), l#77, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)));
          invariant $w1 ==> (forall l#77: int :: (forall l$ih#16#78: int :: true ==> 0 <= l$ih#16#78 && l$ih#16#78 < l#77 ==> 0 <= l$ih#16#78 && l$ih#16#78 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), l$ih#16#78, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1)) && true ==> 0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), _module.Node.next), l#77, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1));
          free invariant $w1 ==> (forall l#77: int :: true ==> 0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), l#77, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1));
          free invariant $PreLoopHeap1 == $Heap;
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap1, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap1, $o, $f) || $_Frame[$o, $f]);
          free invariant n#0 - ln#49 <= $decr1$init$0 && (n#0 - ln#49 == $decr1$init$0 ==> true);
        {
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(364,7): after some loop iterations"} true;
            if (!$w1)
            {
                if (0 <= ln#49)
                {
                }

                assume 0 <= ln#49 ==> true;
                assume 0 <= ln#49 && ln#49 <= n#0;
                havoc k#50;
                havoc l#51;
                if (0 <= k#50)
                {
                }

                if (0 <= k#50 && k#50 < kn#32)
                {
                    if (0 <= l#51)
                    {
                    }
                }

                if (0 <= k#50 && k#50 < kn#32 && 0 <= l#51 && l#51 < n#0)
                {
                    k#52 := k#50;
                    S#53 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#53) && 0 <= k#52;
                    assume _module.Node.Nexxxt#canCall($Heap, this, k#50, S#1);
                }

                if (0 <= k#50 && k#50 < kn#32 && 0 <= l#51 && l#51 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1) != null)
                {
                    k#54 := k#50;
                    S#55 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#55) && 0 <= k#54;
                    assume _module.Node.Nexxxt#canCall($Heap, this, k#50, S#1);
                    assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1) != null;
                }

                if (0 <= k#50 && k#50 < kn#32 && 0 <= l#51 && l#51 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1), _module.Node.next) != null)
                {
                    k#56 := k#50;
                    S#57 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#57) && 0 <= k#56;
                    assume _module.Node.Nexxxt#canCall($Heap, this, k#50, S#1);
                    assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1) != null;
                    assert {:subsumption 0} read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1), _module.Node.next) != null;
                    k#58 := l#51;
                    S#59 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1), _module.Node.next), S#59) && 0 <= k#58;
                    assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#50, S#1), _module.Node.next), l#51, S#1);
                    k#60 := k#50;
                    S#61 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#61) && 0 <= k#60;
                    assume _module.Node.Nexxxt#canCall($Heap, this, k#50, S#1);
                }

                assume (forall k#62: int, l#63: int :: true ==> (0 <= k#62 ==> true) && (0 <= k#62 && k#62 < kn#32 ==> 0 <= l#63 ==> true) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next), l#63, S#1) && _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)));
                assume (forall k#62: int, l#63: int :: true ==> 0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next), l#63, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1));
                havoc l#66;
                if (0 <= l#66)
                {
                }

                if (0 <= l#66 && l#66 < ln#49)
                {
                    k#67 := kn#32;
                    S#68 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#68) && 0 <= k#67;
                    assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                }

                if (0 <= l#66 && l#66 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null)
                {
                    k#69 := kn#32;
                    S#70 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#70) && 0 <= k#69;
                    assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                    assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                }

                if (0 <= l#66 && l#66 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null)
                {
                    k#71 := kn#32;
                    S#72 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#72) && 0 <= k#71;
                    assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                    assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                    assert {:subsumption 0} read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null;
                    k#73 := l#66;
                    S#74 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), S#74) && 0 <= k#73;
                    assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), l#66, S#1);
                    k#75 := kn#32;
                    S#76 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#76) && 0 <= k#75;
                    assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                }

                assume (forall l#77: int :: true ==> (0 <= l#77 ==> true) && (0 <= l#77 && l#77 < ln#49 ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)) && (0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)) && (0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), l#77, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)));
                assume (forall l#77: int :: true ==> 0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), l#77, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1));
                assume true;
                assume false;
            }

            assume true;
            if (n#0 <= ln#49)
            {
                break;
            }

            $decr1$0 := n#0 - ln#49;
            // ----- if statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(369,9)
            k#79 := kn#32;
            S#80 := S#1;
            assert _module.Node.IsClosed($Heap, this, S#80) && 0 <= k#79;
            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
            if (_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null)
            {
                k#81 := kn#32;
                S#82 := S#1;
                assert _module.Node.IsClosed($Heap, this, S#82) && 0 <= k#81;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                assert _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
            }

            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1));
            if (_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null)
            {
                // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(370,11)
                k#83 := kn#32 + 1;
                S#84 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#84) && 0 <= k#83;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1, S#1);
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32 + 1, S#1) != null;
                assume _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1, S#1) != null;
                // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(371,11)
                assume true;
                x##85 := kn#32 + 1;
                assume true;
                y##86 := ln#49;
                assume true;
                S##87 := S#1;
                assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
                call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this, x##85, y##86, S##87);
                assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(371,11)"} true;
                // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(372,11)
                k#88 := kn#32;
                S#89 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#89) && 0 <= k#88;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                assert {:subsumption 0} read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null;
                k#90 := ln#49;
                S#91 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), S#91) && 0 <= k#90;
                assume _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), ln#49, S#1);
                k#92 := kn#32 + 1 + ln#49;
                S#93 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#93) && 0 <= k#92;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1 + ln#49, S#1);
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), ln#49, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1 + ln#49, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, read($Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), _module.Node.next), ln#49, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32 + 1 + ln#49, S#1);
                assume _module.Node.Nexxxt($LS($LZ), $Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), ln#49, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1 + ln#49, S#1);
                // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(373,11)
                assume true;
                x##94 := kn#32;
                assume true;
                y##95 := 1 + ln#49;
                assume true;
                S##96 := S#1;
                assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
                call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this, x##94, y##95, S##96);
                assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(373,11)"} true;
                // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(374,11)
                k#97 := kn#32 + 1 + ln#49;
                S#98 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#98) && 0 <= k#97;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1 + ln#49, S#1);
                k#99 := kn#32;
                S#100 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#100) && 0 <= k#99;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                k#101 := 1 + ln#49;
                S#102 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#102) && 0 <= k#101;
                assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1 + ln#49, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32 + 1 + ln#49, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                assume _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1 + ln#49, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                // ----- if statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(378,11)
                k#103 := kn#32;
                S#104 := S#1;
                assert _module.Node.IsClosed($Heap, this, S#104) && 0 <= k#103;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                assert _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                k#105 := 1 + ln#49;
                S#106 := S#1;
                assert _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#106) && 0 <= k#105;
                assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                k#107 := kn#32;
                S#108 := S#1;
                assert _module.Node.IsClosed($Heap, this, S#108) && 0 <= k#107;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                if (_module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1))
                {
                    // ----- var-declaration statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(379,17)
                    // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(379,20)
                    assume true;
                    assume true;
                    nn#109 := 1 + ln#49;
                    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(379,20)"} true;
                    // ----- while statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(380,13)
                    $PreLoopHeap2 := $Heap;
                    $decr2$init$0 := n#0 - nn#109;
                    havoc $w2;
                    while (true)
                      free invariant $w2 ==> true;
                      invariant $w2 ==> 0 <= nn#109;
                      free invariant $w2 ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                      invariant $w2 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1);
                      free invariant $PreLoopHeap2 == $Heap;
                      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap2, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap2, $o, $f) || $_Frame[$o, $f]);
                      free invariant n#0 - nn#109 <= $decr2$init$0 && (n#0 - nn#109 == $decr2$init$0 ==> true);
                    {
                        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(380,13): after some loop iterations"} true;
                        if (!$w2)
                        {
                            assume true;
                            assume 0 <= nn#109;
                            k#110 := kn#32;
                            S#111 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#111) && 0 <= k#110;
                            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                            k#112 := nn#109;
                            S#113 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#113) && 0 <= k#112;
                            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1);
                            k#114 := kn#32;
                            S#115 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#115) && 0 <= k#114;
                            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                            assume _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1);
                            assume true;
                            assume false;
                        }

                        assume true;
                        if (n#0 <= nn#109)
                        {
                            break;
                        }

                        $decr2$0 := n#0 - nn#109;
                        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(384,15)
                        k#116 := kn#32;
                        S#117 := S#1;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#117) && 0 <= k#116;
                        assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                        k#118 := kn#32;
                        S#119 := S#1;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#119) && 0 <= k#118;
                        assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                        assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                        k#120 := nn#109;
                        S#121 := S#1;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#121) && 0 <= k#120;
                        assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1);
                        if (_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1))
                        {
                            k#122 := kn#32;
                            S#123 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#123) && 0 <= k#122;
                            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                            k#124 := nn#109;
                            S#125 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#125) && 0 <= k#124;
                            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1);
                            k#126 := kn#32;
                            S#127 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#127) && 0 <= k#126;
                            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                            k#128 := 1 + ln#49;
                            S#129 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#129) && 0 <= k#128;
                            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                        }

                        if (_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1))
                        {
                            k#130 := kn#32;
                            S#131 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#131) && 0 <= k#130;
                            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                            k#132 := 1 + ln#49;
                            S#133 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#133) && 0 <= k#132;
                            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                            k#134 := kn#32;
                            S#135 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#135) && 0 <= k#134;
                            assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                            k#136 := nn#109;
                            S#137 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#137) && 0 <= k#136;
                            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1);
                            assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) != null;
                            k#138 := 1 + ln#49;
                            S#139 := S#1;
                            assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1), S#139) && 0 <= k#138;
                            assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1), 1 + ln#49, S#1);
                        }

                        assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1)) && (_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1) ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1), 1 + ln#49, S#1));
                        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), nn#109, S#1);
                        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), 1 + ln#49, S#1);
                        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), 1 + ln#49, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), nn#109, S#1), 1 + ln#49, S#1);
                        assume _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1) && _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), 1 + ln#49, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1), 1 + ln#49, S#1);
                        // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(388,29)
                        assert _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                        assume true;
                        x##140 := 1 + ln#49;
                        assume true;
                        y##141 := nn#109;
                        assume true;
                        S##142 := S#1;
                        assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
                        call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(_module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), x##140, y##141, S##142);
                        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(388,29)"} true;
                        // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(389,15)
                        k#143 := kn#32;
                        S#144 := S#1;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#144) && 0 <= k#143;
                        assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                        assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                        k#145 := nn#109 + 1 + ln#49;
                        S#146 := S#1;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#146) && 0 <= k#145;
                        assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109 + 1 + ln#49, S#1);
                        k#147 := kn#32;
                        S#148 := S#1;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#148) && 0 <= k#147;
                        assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                        assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109 + 1 + ln#49, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                        assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), nn#109 + 1 + ln#49, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1);
                        assume _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109 + 1 + ln#49, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1);
                        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(390,18)
                        assume true;
                        assume true;
                        nn#109 := nn#109 + 1 + ln#49;
                        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(390,18)"} true;
                        assert 0 <= $decr2$0 || n#0 - nn#109 == $decr2$0;
                        assert n#0 - nn#109 < $decr2$0;
                        assume true;
                        assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                    }

                    // ----- call statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(392,13)
                    assume true;
                    x##149 := kn#32;
                    assume true;
                    y##150 := nn#109;
                    assume true;
                    S##151 := S#1;
                    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
                    call IntraModuleCall$$_module.Node.Lemma__NexxxtIsTransitive(this, x##149, y##150, S##151);
                    assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(392,13)"} true;
                    // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(393,13)
                    k#152 := kn#32;
                    S#153 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#153) && 0 <= k#152;
                    assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                    assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null;
                    k#154 := nn#109;
                    S#155 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), S#155) && 0 <= k#154;
                    assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1);
                    k#156 := kn#32 + nn#109;
                    S#157 := S#1;
                    assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#157) && 0 <= k#156;
                    assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + nn#109, S#1);
                    assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32 + nn#109, S#1);
                    assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32 + nn#109, S#1);
                    assume _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), nn#109, S#1) == _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + nn#109, S#1);
                    // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(394,13)
                    havoc j#158;
                    if (n#0 <= j#158)
                    {
                        k#159 := j#158;
                        S#160 := S#1;
                        assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#160) && 0 <= k#159;
                        assume _module.Node.Nexxxt#canCall($Heap, this, j#158, S#1);
                    }

                    assume (forall j#161: int :: true ==> n#0 <= j#161 ==> _module.Node.Nexxxt#canCall($Heap, this, j#161, S#1));
                    assert {:subsumption 0} (forall j#161: int :: (forall j$ih#17#162: int :: true ==> 0 <= j$ih#17#162 && j$ih#17#162 < j#161 ==> n#0 <= j$ih#17#162 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, j$ih#17#162, S#1) == null) && true ==> n#0 <= j#161 ==> _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, j#161, S#1) == null);
                    assume (forall j#161: int :: true ==> n#0 <= j#161 ==> _module.Node.Nexxxt($LS($LZ), $Heap, this, j#161, S#1) == null);
                    // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(395,13)
                    assume true;
                    assert Lit(false);
                }
                else
                {
                }

                // ----- assert statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(397,11)
                k#163 := kn#32 + 1;
                S#164 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#164) && 0 <= k#163;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1, S#1) != null;
                k#165 := ln#49;
                S#166 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1, S#1), S#166) && 0 <= k#165;
                assume _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1, S#1), ln#49, S#1);
                k#167 := kn#32;
                S#168 := S#1;
                assert {:subsumption 0} _module.Node.IsClosed($Heap, this, S#168) && 0 <= k#167;
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                assume _module.Node.Nexxxt#canCall($Heap, this, kn#32 + 1, S#1) && _module.Node.Nexxxt#canCall($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1, S#1), ln#49, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1);
                assert {:subsumption 0} _module.Node.Nexxxt($LS($LS($LZ)), $Heap, _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32 + 1, S#1), ln#49, S#1) != _module.Node.Nexxxt($LS($LS($LZ)), $Heap, this, kn#32, S#1);
                assume _module.Node.Nexxxt($LS($LZ), $Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32 + 1, S#1), ln#49, S#1) != _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1);
            }
            else
            {
            }

            // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(399,12)
            assume true;
            assume true;
            ln#49 := ln#49 + 1;
            assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(399,12)"} true;
            assert 0 <= $decr1$0 || n#0 - ln#49 == $decr1$0;
            assert n#0 - ln#49 < $decr1$0;
            assume 0 <= ln#49 ==> true;
            assume (forall k#62: int, l#63: int :: true ==> (0 <= k#62 ==> true) && (0 <= k#62 && k#62 < kn#32 ==> 0 <= l#63 ==> true) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)) && (0 <= k#62 && k#62 < kn#32 && 0 <= l#63 && l#63 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#62, S#1), _module.Node.next), l#63, S#1) && _module.Node.Nexxxt#canCall($Heap, this, k#62, S#1)));
            assume (forall l#77: int :: true ==> (0 <= l#77 ==> true) && (0 <= l#77 && l#77 < ln#49 ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)) && (0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)) && (0 <= l#77 && l#77 < ln#49 && _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, kn#32, S#1), _module.Node.next), l#77, S#1) && _module.Node.Nexxxt#canCall($Heap, this, kn#32, S#1)));
        }

        // ----- assignment statement ----- COST-verif-comp-2011-4-FloydCycleDetect.dfy(401,10)
        assume true;
        assume true;
        kn#32 := kn#32 + 1;
        assume {:captureState "COST-verif-comp-2011-4-FloydCycleDetect.dfy(401,10)"} true;
        assert 0 <= $decr0$0 || n#0 - kn#32 == $decr0$0;
        assert n#0 - kn#32 < $decr0$0;
        assume 0 <= kn#32 ==> true;
        assume (forall k#45: int, l#46: int :: true ==> (0 <= k#45 ==> true) && (0 <= k#45 && k#45 < kn#32 ==> 0 <= l#46 ==> true) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)) && (0 <= k#45 && k#45 < kn#32 && 0 <= l#46 && l#46 < n#0 && _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1) != null && read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next) != null ==> _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1) && _module.Node.Nexxxt#canCall($Heap, read($Heap, _module.Node.Nexxxt($LS($LZ), $Heap, this, k#45, S#1), _module.Node.next), l#46, S#1) && _module.Node.Nexxxt#canCall($Heap, this, k#45, S#1)));
    }
}



const unique class._module.__default: ClassName;

const unique field$next: NameFamily;
