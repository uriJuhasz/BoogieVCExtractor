// Dafny program verifier version 2.2.30705.1126, Copyright (c) 2003-2011, Microsoft.
// Command Line Options: TreeBarrier-NoRoot.dfy /print:out.bpl

const $$Language$Dafny: bool;

axiom $$Language$Dafny;

type ref;

const null: ref;

type Set T = [T]bool;

function Set#Empty<T>() : Set T;

axiom (forall<T> o: T :: { Set#Empty()[o] } !Set#Empty()[o]);

function Set#Singleton<T>(T) : Set T;

axiom (forall<T> r: T :: { Set#Singleton(r) } Set#Singleton(r)[r]);

axiom (forall<T> r: T, o: T :: { Set#Singleton(r)[o] } Set#Singleton(r)[o] <==> r == o);

function Set#UnionOne<T>(Set T, T) : Set T;

axiom (forall<T> a: Set T, x: T, o: T :: { Set#UnionOne(a, x)[o] } Set#UnionOne(a, x)[o] <==> o == x || a[o]);

axiom (forall<T> a: Set T, x: T :: { Set#UnionOne(a, x) } Set#UnionOne(a, x)[x]);

axiom (forall<T> a: Set T, x: T, y: T :: { Set#UnionOne(a, x), a[y] } a[y] ==> Set#UnionOne(a, x)[y]);

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

function Set#Difference<T>(Set T, Set T) : Set T;

axiom (forall<T> a: Set T, b: Set T, o: T :: { Set#Difference(a, b)[o] } Set#Difference(a, b)[o] <==> a[o] && !b[o]);

axiom (forall<T> a: Set T, b: Set T, y: T :: { Set#Difference(a, b), b[y] } b[y] ==> !Set#Difference(a, b)[y]);

function Set#Subset<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: { Set#Subset(a, b) } Set#Subset(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] ==> b[o]));

function Set#Equal<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: { Set#Equal(a, b) } Set#Equal(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] <==> b[o]));

axiom (forall<T> a: Set T, b: Set T :: { Set#Equal(a, b) } Set#Equal(a, b) ==> a == b);

function Set#Disjoint<T>(Set T, Set T) : bool;

axiom (forall<T> a: Set T, b: Set T :: { Set#Disjoint(a, b) } Set#Disjoint(a, b) <==> (forall o: T :: { a[o] } { b[o] } !a[o] || !b[o]));

function Set#Choose<T>(Set T, TickType) : T;

axiom (forall<T> a: Set T, tick: TickType :: { Set#Choose(a, tick) } a != Set#Empty() ==> a[Set#Choose(a, tick)]);

function Math#min(a: int, b: int) : int;

axiom (forall a: int, b: int :: { Math#min(a, b) } a <= b <==> Math#min(a, b) == a);

axiom (forall a: int, b: int :: { Math#min(a, b) } b <= a <==> Math#min(a, b) == b);

axiom (forall a: int, b: int :: { Math#min(a, b) } Math#min(a, b) == a || Math#min(a, b) == b);

function Math#clip(a: int) : int;

axiom (forall a: int :: { Math#clip(a) } 0 <= a ==> Math#clip(a) == a);

axiom (forall a: int :: { Math#clip(a) } a < 0 ==> Math#clip(a) == 0);

type MultiSet T = [T]int;

function $IsGoodMultiSet<T>(ms: MultiSet T) : bool;

axiom (forall<T> ms: MultiSet T :: { $IsGoodMultiSet(ms) } $IsGoodMultiSet(ms) <==> (forall o: T :: { ms[o] } 0 <= ms[o]));

function MultiSet#Empty<T>() : MultiSet T;

axiom (forall<T> o: T :: { MultiSet#Empty()[o] } MultiSet#Empty()[o] == 0);

function MultiSet#Singleton<T>(T) : MultiSet T;

axiom (forall<T> r: T, o: T :: { MultiSet#Singleton(r)[o] } (MultiSet#Singleton(r)[o] == 1 <==> r == o) && (MultiSet#Singleton(r)[o] == 0 <==> r != o));

axiom (forall<T> r: T :: { MultiSet#Singleton(r) } MultiSet#Singleton(r) == MultiSet#UnionOne(MultiSet#Empty(), r));

function MultiSet#UnionOne<T>(MultiSet T, T) : MultiSet T;

axiom (forall<T> a: MultiSet T, x: T, o: T :: { MultiSet#UnionOne(a, x)[o] } 0 < MultiSet#UnionOne(a, x)[o] <==> o == x || 0 < a[o]);

axiom (forall<T> a: MultiSet T, x: T :: { MultiSet#UnionOne(a, x) } MultiSet#UnionOne(a, x)[x] == a[x] + 1);

axiom (forall<T> a: MultiSet T, x: T, y: T :: { MultiSet#UnionOne(a, x), a[y] } 0 < a[y] ==> 0 < MultiSet#UnionOne(a, x)[y]);

axiom (forall<T> a: MultiSet T, x: T, y: T :: { MultiSet#UnionOne(a, x), a[y] } x != y ==> a[y] == MultiSet#UnionOne(a, x)[y]);

function MultiSet#Union<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: { MultiSet#Union(a, b)[o] } MultiSet#Union(a, b)[o] == a[o] + b[o]);

axiom (forall<T> a: MultiSet T, b: MultiSet T, y: T :: { MultiSet#Union(a, b), a[y] } 0 < a[y] ==> 0 < MultiSet#Union(a, b)[y]);

axiom (forall<T> a: MultiSet T, b: MultiSet T, y: T :: { MultiSet#Union(a, b), b[y] } 0 < b[y] ==> 0 < MultiSet#Union(a, b)[y]);

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Union(a, b) } MultiSet#Difference(MultiSet#Union(a, b), a) == b && MultiSet#Difference(MultiSet#Union(a, b), b) == a);

function MultiSet#Intersection<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: { MultiSet#Intersection(a, b)[o] } MultiSet#Intersection(a, b)[o] == Math#min(a[o], b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Intersection(MultiSet#Intersection(a, b), b) } MultiSet#Intersection(MultiSet#Intersection(a, b), b) == MultiSet#Intersection(a, b));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Intersection(a, MultiSet#Intersection(a, b)) } MultiSet#Intersection(a, MultiSet#Intersection(a, b)) == MultiSet#Intersection(a, b));

function MultiSet#Difference<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> a: MultiSet T, b: MultiSet T, o: T :: { MultiSet#Difference(a, b)[o] } MultiSet#Difference(a, b)[o] == Math#clip(a[o] - b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T, y: T :: { MultiSet#Difference(a, b), b[y], a[y] } a[y] <= b[y] ==> MultiSet#Difference(a, b)[y] == 0);

function MultiSet#Subset<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Subset(a, b) } MultiSet#Subset(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] <= b[o]));

function MultiSet#Equal<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Equal(a, b) } MultiSet#Equal(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] == b[o]));

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Equal(a, b) } MultiSet#Equal(a, b) ==> a == b);

function MultiSet#Disjoint<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> a: MultiSet T, b: MultiSet T :: { MultiSet#Disjoint(a, b) } MultiSet#Disjoint(a, b) <==> (forall o: T :: { a[o] } { b[o] } a[o] == 0 || b[o] == 0));

function MultiSet#FromSet<T>(Set T) : MultiSet T;

axiom (forall<T> s: Set T, a: T :: { MultiSet#FromSet(s)[a] } (MultiSet#FromSet(s)[a] == 0 <==> !s[a]) && (MultiSet#FromSet(s)[a] == 1 <==> s[a]));

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

axiom (forall h: HeapType, a: ref :: { Seq#Length(Seq#FromArray(h, a)) } Seq#Length(Seq#FromArray(h, a)) == array.Length(a));

axiom (forall h: HeapType, a: ref :: { Seq#FromArray(h, a): Seq BoxType } (forall i: int :: 0 <= i && i < Seq#Length(Seq#FromArray(h, a)) ==> Seq#Index(Seq#FromArray(h, a), i) == read(h, a, IndexField(i))));

axiom (forall<alpha> h: HeapType, o: ref, f: Field alpha, v: alpha, a: ref :: { Seq#FromArray(update(h, o, f, v), a) } o != a ==> Seq#FromArray(update(h, o, f, v), a) == Seq#FromArray(h, a));

axiom (forall h: HeapType, i: int, v: BoxType, a: ref :: { Seq#FromArray(update(h, a, IndexField(i), v), a) } 0 <= i && i < array.Length(a) ==> Seq#FromArray(update(h, a, IndexField(i), v), a) == Seq#Update(Seq#FromArray(h, a), i, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Take(Seq#Update(s, i, v), n) } 0 <= i && i < n && n <= Seq#Length(s) ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Update(Seq#Take(s, n), i, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Take(Seq#Update(s, i, v), n) } n <= i && i < Seq#Length(s) ==> Seq#Take(Seq#Update(s, i, v), n) == Seq#Take(s, n));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Drop(Seq#Update(s, i, v), n) } 0 <= n && n <= i && i < Seq#Length(s) ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Update(Seq#Drop(s, n), i - n, v));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Drop(Seq#Update(s, i, v), n) } 0 <= i && i < n && n < Seq#Length(s) ==> Seq#Drop(Seq#Update(s, i, v), n) == Seq#Drop(s, n));

axiom (forall h: HeapType, a: ref, n0: int, n1: int :: { Seq#Take(Seq#FromArray(h, a), n0), Seq#Take(Seq#FromArray(h, a), n1) } n0 + 1 == n1 && 0 <= n0 && n1 <= array.Length(a) ==> Seq#Take(Seq#FromArray(h, a), n1) == Seq#Build(Seq#Take(Seq#FromArray(h, a), n0), read(h, a, IndexField(n0): Field BoxType)));

axiom (forall<T> s: Seq T, v: T, n: int :: { Seq#Drop(Seq#Build(s, v), n) } 0 <= n && n <= Seq#Length(s) ==> Seq#Drop(Seq#Build(s, v), n) == Seq#Build(Seq#Drop(s, n), v));

type BoxType;

function $Box<T>(T) : BoxType;

function $Unbox<T>(BoxType) : T;

axiom (forall<T> x: T :: { $Box(x) } $Unbox($Box(x)) == x);

axiom (forall b: BoxType :: { $Unbox(b): int } $Box($Unbox(b): int) == b);

axiom (forall b: BoxType :: { $Unbox(b): ref } $Box($Unbox(b): ref) == b);

axiom (forall b: BoxType :: { $Unbox(b): Set BoxType } $Box($Unbox(b): Set BoxType) == b);

axiom (forall b: BoxType :: { $Unbox(b): Seq BoxType } $Box($Unbox(b): Seq BoxType) == b);

axiom (forall b: BoxType :: { $Unbox(b): DatatypeType } $Box($Unbox(b): DatatypeType) == b);

function $IsCanonicalBoolBox(BoxType) : bool;

axiom $IsCanonicalBoolBox($Box(false)) && $IsCanonicalBoolBox($Box(true));

axiom (forall b: BoxType :: { $Unbox(b): bool } $IsCanonicalBoolBox(b) ==> $Box($Unbox(b): bool) == b);

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

axiom (forall a: ClassName, b: ClassName :: { TypeTuple(a, b) } TypeTupleCar(TypeTuple(a, b)) == a && TypeTupleCdr(TypeTuple(a, b)) == b);

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

axiom (forall f: Field BoxType, i: int :: { MultiIndexField(f, i) } FDim(MultiIndexField(f, i)) == FDim(f) + 1);

function MultiIndexField_Inverse0<T>(Field T) : Field T;

function MultiIndexField_Inverse1<T>(Field T) : int;

axiom (forall f: Field BoxType, i: int :: { MultiIndexField(f, i) } MultiIndexField_Inverse0(MultiIndexField(f, i)) == f && MultiIndexField_Inverse1(MultiIndexField(f, i)) == i);

function DeclType<T>(Field T) : ClassName;

const unique alloc: Field bool;

axiom FDim(alloc) == 0;

function DtAlloc(DatatypeType, HeapType) : bool;

axiom (forall h: HeapType, k: HeapType, d: DatatypeType :: { $HeapSucc(h, k), DtAlloc(d, h) } { $HeapSucc(h, k), DtAlloc(d, k) } $HeapSucc(h, k) ==> DtAlloc(d, h) ==> DtAlloc(d, k));

function GenericAlloc(BoxType, HeapType) : bool;

axiom (forall h: HeapType, k: HeapType, d: BoxType :: { $HeapSucc(h, k), GenericAlloc(d, h) } { $HeapSucc(h, k), GenericAlloc(d, k) } $HeapSucc(h, k) ==> GenericAlloc(d, h) ==> GenericAlloc(d, k));

axiom (forall b: BoxType, h: HeapType :: { GenericAlloc(b, h), h[$Unbox(b): ref, alloc] } GenericAlloc(b, h) ==> $Unbox(b): ref == null || h[$Unbox(b): ref, alloc]);

axiom (forall b: BoxType, h: HeapType, i: int :: { GenericAlloc(b, h), Seq#Index($Unbox(b): Seq BoxType, i) } GenericAlloc(b, h) && 0 <= i && i < Seq#Length($Unbox(b): Seq BoxType) ==> GenericAlloc(Seq#Index($Unbox(b): Seq BoxType, i), h));

axiom (forall b: BoxType, h: HeapType, t: BoxType :: { GenericAlloc(b, h), ($Unbox(b): Set BoxType)[t] } GenericAlloc(b, h) && ($Unbox(b): Set BoxType)[t] ==> GenericAlloc(t, h));

axiom (forall b: BoxType, h: HeapType :: { GenericAlloc(b, h), DtType($Unbox(b): DatatypeType) } GenericAlloc(b, h) ==> DtAlloc($Unbox(b): DatatypeType, h));

axiom (forall b: bool, h: HeapType :: $IsGoodHeap(h) ==> GenericAlloc($Box(b), h));

axiom (forall x: int, h: HeapType :: $IsGoodHeap(h) ==> GenericAlloc($Box(x), h));

axiom (forall r: ref, h: HeapType :: { GenericAlloc($Box(r), h) } $IsGoodHeap(h) && (r == null || h[r, alloc]) ==> GenericAlloc($Box(r), h));

function array.Length(a: ref) : int;

axiom (forall o: ref :: 0 <= array.Length(o));

procedure UpdateArrayRange(arr: ref, low: int, high: int, rhs: BoxType);
  modifies $Heap;
  ensures $HeapSucc(old($Heap), $Heap);
  ensures (forall i: int :: { read($Heap, arr, IndexField(i)) } low <= i && i < high ==> read($Heap, arr, IndexField(i)) == rhs);
  ensures (forall<alpha> o: ref, f: Field alpha :: { read($Heap, o, f) } read($Heap, o, f) == read(old($Heap), o, f) || (o == arr && FDim(f) == 1 && low <= IndexField_Inverse(f) && IndexField_Inverse(f) < high));



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

type TickType;

var $Tick: TickType;

//axiom (forall x: int, y: int :: { x % y } { x / y } x % y == x - x / y * y);

//axiom (forall x: int, y: int :: { x % y } 0 < y ==> 0 <= x % y && x % y < y);

//axiom (forall x: int, y: int :: { x % y } y < 0 ==> 0 <= x % y && x % y < 0 - y);

//axiom (forall a: int, b: int, d: int :: { a % d, b % d } 2 <= d && a % d == b % d && a < b ==> a + d <= b);

const unique class.object: ClassName;

const unique class.array: ClassName;

const unique class.Node: ClassName;

axiom FDim(Node.left) == 0 && DeclType(Node.left) == class.Node;

const unique Node.left: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.left) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, Node.left) == null || (read($h, read($h, $o, Node.left), alloc) && dtype(read($h, $o, Node.left)) == class.Node));

axiom FDim(Node.right) == 0 && DeclType(Node.right) == class.Node;

const unique Node.right: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.right) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, Node.right) == null || (read($h, read($h, $o, Node.right), alloc) && dtype(read($h, $o, Node.right)) == class.Node));

axiom FDim(Node.parent) == 0 && DeclType(Node.parent) == class.Node;

const unique Node.parent: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.parent) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, Node.parent) == null || (read($h, read($h, $o, Node.parent), alloc) && dtype(read($h, $o, Node.parent)) == class.Node));

axiom FDim(Node.anc) == 0 && DeclType(Node.anc) == class.Node;

const unique Node.anc: Field (Set BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.anc) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $t#0: BoxType :: { read($h, $o, Node.anc)[$t#0] } read($h, $o, Node.anc)[$t#0] ==> $Unbox($t#0): ref == null || (read($h, $Unbox($t#0): ref, alloc) && dtype($Unbox($t#0): ref) == class.Node)));

axiom FDim(Node.desc) == 0 && DeclType(Node.desc) == class.Node;

const unique Node.desc: Field (Set BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.desc) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $t#1: BoxType :: { read($h, $o, Node.desc)[$t#1] } read($h, $o, Node.desc)[$t#1] ==> $Unbox($t#1): ref == null || (read($h, $Unbox($t#1): ref, alloc) && dtype($Unbox($t#1): ref) == class.Node)));

axiom FDim(Node.sense) == 0 && DeclType(Node.sense) == class.Node;

const unique Node.sense: Field bool;

axiom FDim(Node.pc) == 0 && DeclType(Node.pc) == class.Node;

const unique Node.pc: Field int;

function Node.validDown($heap: HeapType, this: ref) : bool;

function Node.validDown#limited($heap: HeapType, this: ref) : bool;

function Node.validDown#2($heap: HeapType, this: ref) : bool;

function Node.validDown#canCall($heap: HeapType, this: ref) : bool;

axiom (forall $Heap: HeapType, this: ref :: { Node.validDown#2($Heap, this) } Node.validDown#2($Heap, this) == Node.validDown($Heap, this));

axiom (forall $Heap: HeapType, this: ref :: { Node.validDown($Heap, this) } Node.validDown($Heap, this) == Node.validDown#limited($Heap, this));

// definition axiom for Node.validDown
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (2 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.validDown($Heap, this) } Node.validDown#canCall($Heap, this) || ((0 != $ModuleContextHeight || 2 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> (!read($Heap, this, Node.desc)[$Box(this)] ==> true) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] ==> true) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) ==> read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] ==> true) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) ==> read($Heap, this, Node.left) != null ==> (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] ==> read($Heap, this, Node.right) != null ==> true) && (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) ==> read($Heap, this, Node.right) == null ==> true) && (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) ==> Node.validDown#canCall($Heap, read($Heap, this, Node.left)))) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) ==> read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> true) && ((read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) ==> read($Heap, this, Node.right) == null ==> true)) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) ==> read($Heap, this, Node.right) != null ==> Node.validDown#canCall($Heap, read($Heap, this, Node.right))) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) ==> Node.blocked#canCall($Heap, this) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked#canCall($Heap, m#0)))) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))) ==> Node.after#canCall($Heap, this) && (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked#canCall($Heap, m#1) && (!Node.blocked($Heap, m#1) ==> Node.after#canCall($Heap, m#1))))) && Node.validDown($Heap, this) == (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown#limited($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown#limited($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))) && (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked($Heap, m#1) || Node.after($Heap, m#1)))));

// definition axiom for Node.validDown#2
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (2 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.validDown#2($Heap, this) } Node.validDown#canCall($Heap, this) || ((0 != $ModuleContextHeight || 2 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> Node.validDown#2($Heap, this) == (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))) && (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked($Heap, m#1) || Node.after($Heap, m#1)))));

// frame axiom for Node.validDown
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.validDown($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == this || read($h0, this, Node.desc)[$Box($o)]) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.validDown($h0, this) == Node.validDown($h1, this));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.validDown#limited($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == this || read($h0, this, Node.desc)[$Box($o)]) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.validDown#limited($h0, this) == Node.validDown#limited($h1, this));

procedure CheckWellformed$$Node.validDown(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node);
  free requires 0 == $ModuleContextHeight && 2 == $FunctionContextHeight;



implementation CheckWellformed$$Node.validDown(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var m#7: ref;
  var m#8: ref;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || read($Heap, this, Node.desc)[$Box($o)]);
        assert $_Frame[this, Node.desc];
        if (!read($Heap, this, Node.desc)[$Box(this)])
        {
            assert $_Frame[this, Node.desc];
        }

        if (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)])
        {
            assert $_Frame[this, Node.left];
            assert $_Frame[this, Node.right];
        }

        if (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right))
        {
            assert $_Frame[this, Node.right];
            if (read($Heap, this, Node.right) != null)
            {
                assert $_Frame[this, Node.right];
                assert $_Frame[this, Node.desc];
                if (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))])
                {
                    assert $_Frame[this, Node.left];
                    assert $_Frame[this, Node.right];
                    assert read($Heap, this, Node.right) != null;
                    assert $_Frame[read($Heap, this, Node.right), Node.desc];
                }
            }
        }

        if (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]))
        {
            assert $_Frame[this, Node.left];
            if (read($Heap, this, Node.left) != null)
            {
                assert $_Frame[this, Node.left];
                assert $_Frame[this, Node.desc];
                if (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))])
                {
                    assert $_Frame[this, Node.right];
                    if (read($Heap, this, Node.right) != null)
                    {
                        assert $_Frame[this, Node.desc];
                        assert $_Frame[this, Node.left];
                        assert $_Frame[this, Node.right];
                        assert $_Frame[this, Node.left];
                        assert read($Heap, this, Node.left) != null;
                        assert $_Frame[read($Heap, this, Node.left), Node.desc];
                        assert $_Frame[this, Node.right];
                        assert read($Heap, this, Node.right) != null;
                        assert $_Frame[read($Heap, this, Node.right), Node.desc];
                    }
                }

                if (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))))
                {
                    assert $_Frame[this, Node.right];
                    if (read($Heap, this, Node.right) == null)
                    {
                        assert $_Frame[this, Node.desc];
                        assert $_Frame[this, Node.left];
                        assert $_Frame[this, Node.left];
                        assert read($Heap, this, Node.left) != null;
                        assert $_Frame[read($Heap, this, Node.left), Node.desc];
                    }
                }

                if (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))))
                {
                    assert $_Frame[this, Node.left];
                    assert read($Heap, this, Node.left) != null;
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == read($Heap, this, Node.left) || (read($Heap, this, Node.left) != null && read($Heap, read($Heap, this, Node.left), Node.desc)[$Box($o)])) ==> $_Frame[$o, $f]);
                    assert Set#Subset(Set#Union(read($Heap, read($Heap, this, Node.left), Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left)))), Set#Union(read($Heap, this, Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(this)))) && !Set#Subset(Set#Union(read($Heap, this, Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(this))), Set#Union(read($Heap, read($Heap, this, Node.left), Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left)))));
                    assume Node.validDown#canCall($Heap, read($Heap, this, Node.left));
                }
            }
        }

        if (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))))
        {
            assert $_Frame[this, Node.left];
            if (read($Heap, this, Node.left) == null)
            {
                assert $_Frame[this, Node.right];
                if (read($Heap, this, Node.right) != null)
                {
                    assert $_Frame[this, Node.desc];
                    assert $_Frame[this, Node.right];
                    assert $_Frame[this, Node.right];
                    assert read($Heap, this, Node.right) != null;
                    assert $_Frame[read($Heap, this, Node.right), Node.desc];
                }

                if (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc))))
                {
                    assert $_Frame[this, Node.right];
                    if (read($Heap, this, Node.right) == null)
                    {
                        assert $_Frame[this, Node.desc];
                    }
                }
            }
        }

        if (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))))
        {
            assert $_Frame[this, Node.right];
            if (read($Heap, this, Node.right) != null)
            {
                assert $_Frame[this, Node.right];
                assert read($Heap, this, Node.right) != null;
                assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == read($Heap, this, Node.right) || (read($Heap, this, Node.right) != null && read($Heap, read($Heap, this, Node.right), Node.desc)[$Box($o)])) ==> $_Frame[$o, $f]);
                assert Set#Subset(Set#Union(read($Heap, read($Heap, this, Node.right), Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right)))), Set#Union(read($Heap, this, Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(this)))) && !Set#Subset(Set#Union(read($Heap, this, Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(this))), Set#Union(read($Heap, read($Heap, this, Node.right), Node.desc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right)))));
                assume Node.validDown#canCall($Heap, read($Heap, this, Node.right));
            }
        }

        if (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))))
        {
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == this ==> $_Frame[$o, $f]);
            assume Node.blocked#canCall($Heap, this);
            if (Node.blocked($Heap, this))
            {
                assume m#7 == null || (read($Heap, m#7, alloc) && dtype(m#7) == class.Node);
                assert $_Frame[this, Node.desc];
                if (read($Heap, this, Node.desc)[$Box(m#7)])
                {
                    assert m#7 != null;
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == m#7 ==> $_Frame[$o, $f]);
                    assume Node.blocked#canCall($Heap, m#7);
                }
            }
        }

        if (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))))
        {
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == this ==> $_Frame[$o, $f]);
            assume Node.after#canCall($Heap, this);
            if (Node.after($Heap, this))
            {
                assume m#8 == null || (read($Heap, m#8, alloc) && dtype(m#8) == class.Node);
                assert $_Frame[this, Node.desc];
                if (read($Heap, this, Node.desc)[$Box(m#8)])
                {
                    assert m#8 != null;
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == m#8 ==> $_Frame[$o, $f]);
                    assume Node.blocked#canCall($Heap, m#8);
                    if (!Node.blocked($Heap, m#8))
                    {
                        assert m#8 != null;
                        assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == m#8 ==> $_Frame[$o, $f]);
                        assume Node.after#canCall($Heap, m#8);
                    }
                }
            }
        }

        assume Node.validDown($Heap, this) == (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))) && (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked($Heap, m#1) || Node.after($Heap, m#1))));
        assume (!read($Heap, this, Node.desc)[$Box(this)] ==> true) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] ==> true) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) ==> read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] ==> true) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) ==> read($Heap, this, Node.left) != null ==> (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] ==> read($Heap, this, Node.right) != null ==> true) && (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) ==> read($Heap, this, Node.right) == null ==> true) && (read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) ==> Node.validDown#canCall($Heap, read($Heap, this, Node.left)))) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) ==> read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> true) && ((read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) ==> read($Heap, this, Node.right) == null ==> true)) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) ==> read($Heap, this, Node.right) != null ==> Node.validDown#canCall($Heap, read($Heap, this, Node.right))) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) ==> Node.blocked#canCall($Heap, this) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked#canCall($Heap, m#0)))) && (!read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))) ==> Node.after#canCall($Heap, this) && (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked#canCall($Heap, m#1) && (!Node.blocked($Heap, m#1) ==> Node.after#canCall($Heap, m#1)))));
    }
}



function Node.validUp($heap: HeapType, this: ref) : bool;

function Node.validUp#limited($heap: HeapType, this: ref) : bool;

function Node.validUp#2($heap: HeapType, this: ref) : bool;

function Node.validUp#canCall($heap: HeapType, this: ref) : bool;

axiom (forall $Heap: HeapType, this: ref :: { Node.validUp#2($Heap, this) } Node.validUp#2($Heap, this) == Node.validUp($Heap, this));

axiom (forall $Heap: HeapType, this: ref :: { Node.validUp($Heap, this) } Node.validUp($Heap, this) == Node.validUp#limited($Heap, this));

// definition axiom for Node.validUp
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (3 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.validUp($Heap, this) } Node.validUp#canCall($Heap, this) || ((0 != $ModuleContextHeight || 3 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> (!read($Heap, this, Node.anc)[$Box(this)] ==> true) && (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] ==> read($Heap, this, Node.parent) != null ==> (read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] ==> true) && (read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) ==> Node.validUp#canCall($Heap, read($Heap, this, Node.parent)))) && (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) ==> read($Heap, this, Node.parent) == null ==> true) && (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) && (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType)) ==> Node.after#canCall($Heap, this) && (Node.after($Heap, this) ==> (forall m#2: ref :: m#2 == null || (read($Heap, m#2, alloc) && dtype(m#2) == class.Node) ==> read($Heap, this, Node.anc)[$Box(m#2)] ==> Node.after#canCall($Heap, m#2)))) && Node.validUp($Heap, this) == (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp#limited($Heap, read($Heap, this, Node.parent))) && (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType)) && (Node.after($Heap, this) ==> (forall m#2: ref :: m#2 == null || (read($Heap, m#2, alloc) && dtype(m#2) == class.Node) ==> read($Heap, this, Node.anc)[$Box(m#2)] ==> Node.after($Heap, m#2)))));

// definition axiom for Node.validUp#2
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (3 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.validUp#2($Heap, this) } Node.validUp#canCall($Heap, this) || ((0 != $ModuleContextHeight || 3 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> Node.validUp#2($Heap, this) == (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) && (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType)) && (Node.after($Heap, this) ==> (forall m#2: ref :: m#2 == null || (read($Heap, m#2, alloc) && dtype(m#2) == class.Node) ==> read($Heap, this, Node.anc)[$Box(m#2)] ==> Node.after($Heap, m#2)))));

// frame axiom for Node.validUp
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.validUp($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == this || read($h0, this, Node.anc)[$Box($o)]) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.validUp($h0, this) == Node.validUp($h1, this));

axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.validUp#limited($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == this || read($h0, this, Node.anc)[$Box($o)]) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.validUp#limited($h0, this) == Node.validUp#limited($h1, this));

procedure CheckWellformed$$Node.validUp(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node);
  free requires 0 == $ModuleContextHeight && 3 == $FunctionContextHeight;



implementation CheckWellformed$$Node.validUp(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var m#9: ref;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || read($Heap, this, Node.anc)[$Box($o)]);
        assert $_Frame[this, Node.anc];
        if (!read($Heap, this, Node.anc)[$Box(this)])
        {
            assert $_Frame[this, Node.anc];
        }

        if (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)])
        {
            assert $_Frame[this, Node.parent];
            if (read($Heap, this, Node.parent) != null)
            {
                assert $_Frame[this, Node.parent];
                assert $_Frame[this, Node.anc];
                if (read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))])
                {
                    assert $_Frame[this, Node.anc];
                    assert $_Frame[this, Node.parent];
                    assert $_Frame[this, Node.parent];
                    assert read($Heap, this, Node.parent) != null;
                    assert $_Frame[read($Heap, this, Node.parent), Node.anc];
                }

                if (read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))))
                {
                    assert $_Frame[this, Node.parent];
                    assert read($Heap, this, Node.parent) != null;
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == read($Heap, this, Node.parent) || (read($Heap, this, Node.parent) != null && read($Heap, read($Heap, this, Node.parent), Node.anc)[$Box($o)])) ==> $_Frame[$o, $f]);
                    assert Set#Subset(Set#Union(read($Heap, read($Heap, this, Node.parent), Node.anc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent)))), Set#Union(read($Heap, this, Node.anc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(this)))) && !Set#Subset(Set#Union(read($Heap, this, Node.anc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(this))), Set#Union(read($Heap, read($Heap, this, Node.parent), Node.anc), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent)))));
                    assume Node.validUp#canCall($Heap, read($Heap, this, Node.parent));
                }
            }
        }

        if (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))))
        {
            assert $_Frame[this, Node.parent];
            if (read($Heap, this, Node.parent) == null)
            {
                assert $_Frame[this, Node.anc];
            }
        }

        if (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) && (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType)))
        {
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == this ==> $_Frame[$o, $f]);
            assume Node.after#canCall($Heap, this);
            if (Node.after($Heap, this))
            {
                assume m#9 == null || (read($Heap, m#9, alloc) && dtype(m#9) == class.Node);
                assert $_Frame[this, Node.anc];
                if (read($Heap, this, Node.anc)[$Box(m#9)])
                {
                    assert m#9 != null;
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == m#9 ==> $_Frame[$o, $f]);
                    assume Node.after#canCall($Heap, m#9);
                }
            }
        }

        assume Node.validUp($Heap, this) == (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) && (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType)) && (Node.after($Heap, this) ==> (forall m#2: ref :: m#2 == null || (read($Heap, m#2, alloc) && dtype(m#2) == class.Node) ==> read($Heap, this, Node.anc)[$Box(m#2)] ==> Node.after($Heap, m#2))));
        assume (!read($Heap, this, Node.anc)[$Box(this)] ==> true) && (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] ==> read($Heap, this, Node.parent) != null ==> (read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] ==> true) && (read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) ==> Node.validUp#canCall($Heap, read($Heap, this, Node.parent)))) && (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) ==> read($Heap, this, Node.parent) == null ==> true) && (!read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) && (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType)) ==> Node.after#canCall($Heap, this) && (Node.after($Heap, this) ==> (forall m#2: ref :: m#2 == null || (read($Heap, m#2, alloc) && dtype(m#2) == class.Node) ==> read($Heap, this, Node.anc)[$Box(m#2)] ==> Node.after#canCall($Heap, m#2))));
    }
}



function Node.valid($heap: HeapType, this: ref) : bool;

function Node.valid#canCall($heap: HeapType, this: ref) : bool;

// definition axiom for Node.valid
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (4 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.valid($Heap, this) } Node.valid#canCall($Heap, this) || ((0 != $ModuleContextHeight || 4 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> Node.validUp#canCall($Heap, this) && (Node.validUp($Heap, this) ==> Node.validDown#canCall($Heap, this)) && (Node.validUp($Heap, this) && Node.validDown($Heap, this) ==> true) && Node.valid($Heap, this) == (Node.validUp($Heap, this) && Node.validDown($Heap, this) && Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc))));

// frame axiom for Node.valid
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.valid($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == this || read($h0, this, Node.desc)[$Box($o)] || read($h0, this, Node.anc)[$Box($o)]) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.valid($h0, this) == Node.valid($h1, this));

procedure CheckWellformed$$Node.valid(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node);
  free requires 0 == $ModuleContextHeight && 4 == $FunctionContextHeight;



implementation CheckWellformed$$Node.valid(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || read($Heap, this, Node.desc)[$Box($o)] || read($Heap, this, Node.anc)[$Box($o)]);
        assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == this || read($Heap, this, Node.anc)[$Box($o)]) ==> $_Frame[$o, $f]);
        assume Node.validUp#canCall($Heap, this);
        if (Node.validUp($Heap, this))
        {
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == this || read($Heap, this, Node.desc)[$Box($o)]) ==> $_Frame[$o, $f]);
            assume Node.validDown#canCall($Heap, this);
        }

        if (Node.validUp($Heap, this) && Node.validDown($Heap, this))
        {
            assert $_Frame[this, Node.desc];
            assert $_Frame[this, Node.anc];
        }

        assume Node.valid($Heap, this) == (Node.validUp($Heap, this) && Node.validDown($Heap, this) && Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc)));
        assume Node.validUp#canCall($Heap, this) && (Node.validUp($Heap, this) ==> Node.validDown#canCall($Heap, this)) && (Node.validUp($Heap, this) && Node.validDown($Heap, this) ==> true);
    }
}



function Node.before($heap: HeapType, this: ref) : bool;

function Node.before#canCall($heap: HeapType, this: ref) : bool;

// definition axiom for Node.before
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (5 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.before($Heap, this) } Node.before#canCall($Heap, this) || ((0 != $ModuleContextHeight || 5 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> (!read($Heap, this, Node.sense) ==> true) && Node.before($Heap, this) == (!read($Heap, this, Node.sense) && read($Heap, this, Node.pc) <= 2));

// frame axiom for Node.before
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.before($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && $o == this ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.before($h0, this) == Node.before($h1, this));

procedure CheckWellformed$$Node.before(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node);
  free requires 0 == $ModuleContextHeight && 5 == $FunctionContextHeight;



implementation CheckWellformed$$Node.before(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
        assert $_Frame[this, Node.sense];
        if (!read($Heap, this, Node.sense))
        {
            assert $_Frame[this, Node.pc];
        }

        assume Node.before($Heap, this) == (!read($Heap, this, Node.sense) && read($Heap, this, Node.pc) <= 2);
        assume !read($Heap, this, Node.sense) ==> true;
    }
}



function Node.blocked($heap: HeapType, this: ref) : bool;

function Node.blocked#canCall($heap: HeapType, this: ref) : bool;

// definition axiom for Node.blocked
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (0 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.blocked($Heap, this) } Node.blocked#canCall($Heap, this) || ((0 != $ModuleContextHeight || 0 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> Node.blocked($Heap, this) == read($Heap, this, Node.sense));

// frame axiom for Node.blocked
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.blocked($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && $o == this ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.blocked($h0, this) == Node.blocked($h1, this));

procedure CheckWellformed$$Node.blocked(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node);
  free requires 0 == $ModuleContextHeight && 0 == $FunctionContextHeight;



implementation CheckWellformed$$Node.blocked(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
        assert $_Frame[this, Node.sense];
        assume Node.blocked($Heap, this) == read($Heap, this, Node.sense);
        assume true;
    }
}



function Node.after($heap: HeapType, this: ref) : bool;

function Node.after#canCall($heap: HeapType, this: ref) : bool;

// definition axiom for Node.after
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (1 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Node.after($Heap, this) } Node.after#canCall($Heap, this) || ((0 != $ModuleContextHeight || 1 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Node) ==> (!read($Heap, this, Node.sense) ==> true) && Node.after($Heap, this) == (!read($Heap, this, Node.sense) && read($Heap, this, Node.pc) >= 3));

// frame axiom for Node.after
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Node.after($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Node && read($h1, this, alloc) && dtype(this) == class.Node && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && $o == this ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.after($h0, this) == Node.after($h1, this));

procedure CheckWellformed$$Node.after(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node);
  free requires 0 == $ModuleContextHeight && 1 == $FunctionContextHeight;



implementation CheckWellformed$$Node.after(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
        assert $_Frame[this, Node.sense];
        if (!read($Heap, this, Node.sense))
        {
            assert $_Frame[this, Node.pc];
        }

        assume Node.after($Heap, this) == (!read($Heap, this, Node.sense) && read($Heap, this, Node.pc) >= 3);
        assume !read($Heap, this, Node.sense) ==> true;
    }
}



procedure CheckWellformed$$Node.barrier(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node, N#3: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Node.barrier(this: ref, N#3: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || $o == read($Heap, this, Node.left) || $o == read($Heap, this, Node.right));
    assume 0 < N#3;
    assume Node.valid#canCall($Heap, this);
    assume Node.valid($Heap, this);
    assume Node.before#canCall($Heap, this);
    assume Node.before($Heap, this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this || $o == read(old($Heap), this, Node.left) || $o == read(old($Heap), this, Node.right));
    assume $HeapSucc(old($Heap), $Heap);
}



procedure Node.barrier(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node, N#3: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires 0 < N#3;
  free requires Node.valid#canCall($Heap, this) && Node.valid($Heap, this) && Node.validUp($Heap, this) && Node.validDown($Heap, this) && Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
  requires Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validUp($Heap, this);
  requires Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validDown($Heap, this);
  requires Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
  free requires Node.before#canCall($Heap, this) && Node.before($Heap, this) && !read($Heap, this, Node.sense) && read($Heap, this, Node.pc) <= 2;
  requires Node.before#canCall($Heap, this) ==> Node.before($Heap, this) || !read($Heap, this, Node.sense);
  requires Node.before#canCall($Heap, this) ==> Node.before($Heap, this) || read($Heap, this, Node.pc) <= 2;
  modifies $Heap, $Tick;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this || $o == read(old($Heap), this, Node.left) || $o == read(old($Heap), this, Node.right));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Node.barrier(this: ref, N#3: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var z#4: int;
  var $rhs#0: int;
  var $PreLoopHeap0: HeapType;
  var #_Frame#0: <beta>[ref,Field beta]bool;
  var $decr0$init$0: int;
  var $w0: bool;
  var $decr0$0: int;
  var $rhs#1: bool;
  var m#10: ref;
  var $PreLoopHeap1: HeapType;
  var #_Frame#1: <beta>[ref,Field beta]bool;
  var $decr1$init$0: int;
  var $w1: bool;
  var $decr1$0: int;
  var $rhs#2: bool;
  var m#11: ref;
  var $rhs#3: int;
  var $rhs#4: bool;
  var $rhs#5: int;
  var $PreLoopHeap2: HeapType;
  var #_Frame#2: <beta>[ref,Field beta]bool;
  var $decr2$init$0: int;
  var $w2: bool;
  var $decr2$0: int;
  var $rhs#6: bool;
  var $rhs#7: int;
  var $rhs#8: bool;
  var $rhs#9: int;
  var $rhs#10: bool;
  var $rhs#11: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || $o == read($Heap, this, Node.left) || $o == read($Heap, this, Node.right));
    // ----- var-declaration statement ----- TreeBarrier-NoRoot.dfy(72,9)
    // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(72,11)
    assume true;
    assume true;
    z#4 := N#3;
    assume {:captureState "TreeBarrier-NoRoot.dfy(72,11)"} true;
    // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(75,8)
    assume true;
    assert $_Frame[this, Node.pc];
    assume true;
    $rhs#0 := 1;
    $Heap := update($Heap, this, Node.pc, $rhs#0);
    assume $IsGoodHeap($Heap);
    assume {:captureState "TreeBarrier-NoRoot.dfy(75,8)"} true;
    // ----- if statement ----- TreeBarrier-NoRoot.dfy(76,5)
    assume true;
    if (read($Heap, this, Node.left) != null)
    {
        // ----- while statement ----- TreeBarrier-NoRoot.dfy(77,7)
        assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == read($Heap, this, Node.left) ==> $_Frame[$o, $f]);
        #_Frame#0 := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == read($Heap, this, Node.left));
        $PreLoopHeap0 := $Heap;
        $decr0$init$0 := (if !read($Heap, read($Heap, this, Node.left), Node.sense) then z#4 - 0 else 0 - 1);
        havoc $w0;
        while (true)
          free invariant $w0 ==> Node.validDown#canCall($Heap, this);
          free invariant $w0 ==> Node.validDown#canCall($Heap, this) && Node.validDown($Heap, this) && !read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))) && (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked($Heap, m#1) || Node.after($Heap, m#1)));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || !read($Heap, this, Node.desc)[$Box(this)];
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || !read($Heap, this, Node.desc)[$Box(null)];
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || read($Heap, this, Node.left) != read($Heap, this, Node.right);
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))]);
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.right) != null ==> !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]);
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))]);
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc))));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc))));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> Node.validDown($Heap, read($Heap, this, Node.left)));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) == null ==> read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc))));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) == null ==> read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right)));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0)));
          invariant $w0 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked($Heap, m#1) || Node.after($Heap, m#1)));
          free invariant $w0 ==> Node.valid#canCall($Heap, this);
          free invariant $w0 ==> Node.valid#canCall($Heap, this) && Node.valid($Heap, this) && Node.validUp($Heap, this) && Node.validDown($Heap, this) && Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
          invariant $w0 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validUp($Heap, this);
          invariant $w0 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validDown($Heap, this);
          invariant $w0 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $o == this || $o == read(old($Heap), this, Node.left) || $o == read(old($Heap), this, Node.right));
          free invariant $HeapSucc($PreLoopHeap0, $Heap);
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || #_Frame#0[$o, $f]);
          free invariant (if !read($Heap, read($Heap, this, Node.left), Node.sense) then z#4 - 0 else 0 - 1) <= $decr0$init$0 && ((if !read($Heap, read($Heap, this, Node.left), Node.sense) then z#4 - 0 else 0 - 1) == $decr0$init$0 ==> true);
        {
            if (!$w0)
            {
                assume Node.validDown#canCall($Heap, this);
                assume Node.validDown#canCall($Heap, this);
                assume Node.validDown($Heap, this);
                assume Node.valid#canCall($Heap, this);
                assume Node.valid#canCall($Heap, this);
                assume Node.valid($Heap, this);
                assert read($Heap, this, Node.left) != null;
                if (!read($Heap, read($Heap, this, Node.left), Node.sense))
                {
                }
                else
                {
                }

                assume (!read($Heap, read($Heap, this, Node.left), Node.sense) ==> true) && (read($Heap, read($Heap, this, Node.left), Node.sense) ==> true);
                assume false;
            }

            assert read($Heap, this, Node.left) != null;
            if (!read($Heap, read($Heap, this, Node.left), Node.sense))
            {
            }

            assume !read($Heap, read($Heap, this, Node.left), Node.sense) ==> true;
            if (!(!read($Heap, read($Heap, this, Node.left), Node.sense) && 0 < z#4))
            {
                break;
            }

            assume {:captureState "TreeBarrier-NoRoot.dfy(77,7): loop entered"} true;
            $decr0$0 := (if !read($Heap, read($Heap, this, Node.left), Node.sense) then z#4 - 0 else 0 - 1);
            // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(90,20)
            assert read($Heap, this, Node.left) != null;
            assume true;
            assert #_Frame#0[read($Heap, this, Node.left), Node.sense];
            havoc $rhs#1;
            $Heap := update($Heap, read($Heap, this, Node.left), Node.sense, $rhs#1);
            assume $IsGoodHeap($Heap);
            assume {:captureState "TreeBarrier-NoRoot.dfy(90,20)"} true;
            // ----- assume statement ----- TreeBarrier-NoRoot.dfy(91,9)
            assert {:subsumption 0} read($Heap, this, Node.left) != null;
            assume Node.blocked#canCall($Heap, read($Heap, this, Node.left));
            if (Node.blocked($Heap, read($Heap, this, Node.left)))
            {
                assume m#10 == null || (read($Heap, m#10, alloc) && dtype(m#10) == class.Node);
                assert {:subsumption 0} read($Heap, this, Node.left) != null;
                if (read($Heap, read($Heap, this, Node.left), Node.desc)[$Box(m#10)])
                {
                    assert {:subsumption 0} m#10 != null;
                    assume Node.blocked#canCall($Heap, m#10);
                }
            }

            assume Node.blocked#canCall($Heap, read($Heap, this, Node.left)) && (Node.blocked($Heap, read($Heap, this, Node.left)) ==> (forall m#5: ref :: m#5 == null || (read($Heap, m#5, alloc) && dtype(m#5) == class.Node) ==> read($Heap, read($Heap, this, Node.left), Node.desc)[$Box(m#5)] ==> Node.blocked#canCall($Heap, m#5)));
            assume Node.blocked($Heap, read($Heap, this, Node.left)) ==> (forall m#5: ref :: m#5 == null || (read($Heap, m#5, alloc) && dtype(m#5) == class.Node) ==> read($Heap, read($Heap, this, Node.left), Node.desc)[$Box(m#5)] ==> Node.blocked($Heap, m#5));
            // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(92,11)
            assume true;
            assume true;
            z#4 := z#4 - 1;
            assume {:captureState "TreeBarrier-NoRoot.dfy(92,11)"} true;
            assert 0 <= $decr0$0 || (if !read($Heap, read($Heap, this, Node.left), Node.sense) then z#4 - 0 else 0 - 1) == $decr0$0;
            assert (if !read($Heap, read($Heap, this, Node.left), Node.sense) then z#4 - 0 else 0 - 1) < $decr0$0;
            assume Node.validDown#canCall($Heap, this);
            assume Node.valid#canCall($Heap, this);
        }

        assume {:captureState "TreeBarrier-NoRoot.dfy(77,7): loop exit"} true;
        // ----- assume statement ----- TreeBarrier-NoRoot.dfy(94,7)
        assume true;
        assume 0 < z#4;
    }
    else
    {
    }

    // ----- if statement ----- TreeBarrier-NoRoot.dfy(96,5)
    assume true;
    if (read($Heap, this, Node.right) != null)
    {
        // ----- while statement ----- TreeBarrier-NoRoot.dfy(97,7)
        assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == read($Heap, this, Node.right) ==> $_Frame[$o, $f]);
        #_Frame#1 := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == read($Heap, this, Node.right));
        $PreLoopHeap1 := $Heap;
        $decr1$init$0 := (if !read($Heap, read($Heap, this, Node.right), Node.sense) then z#4 - 0 else 0 - 1);
        havoc $w1;
        while (true)
          free invariant $w1 ==> Node.validDown#canCall($Heap, this);
          free invariant $w1 ==> Node.validDown#canCall($Heap, this) && Node.validDown($Heap, this) && !read($Heap, this, Node.desc)[$Box(this)] && !read($Heap, this, Node.desc)[$Box(null)] && read($Heap, this, Node.left) != read($Heap, this, Node.right) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]) && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))] && (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc)))) && Node.validDown($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.left) == null ==> (read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc)))) && (read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType))) && (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right))) && (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0))) && (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked($Heap, m#1) || Node.after($Heap, m#1)));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || !read($Heap, this, Node.desc)[$Box(this)];
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || !read($Heap, this, Node.desc)[$Box(null)];
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || read($Heap, this, Node.left) != read($Heap, this, Node.right);
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.right))]);
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.right) != null ==> !read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(read($Heap, this, Node.left))]);
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.desc)[$Box(read($Heap, this, Node.left))]);
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#Union(Set#UnionOne(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.left), Node.desc)), read($Heap, read($Heap, this, Node.right), Node.desc))));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.left))), read($Heap, read($Heap, this, Node.left), Node.desc))));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) != null ==> Node.validDown($Heap, read($Heap, this, Node.left)));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) == null ==> read($Heap, this, Node.right) != null ==> Set#Equal(read($Heap, this, Node.desc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.right))), read($Heap, read($Heap, this, Node.right), Node.desc))));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.left) == null ==> read($Heap, this, Node.right) == null ==> Set#Equal(read($Heap, this, Node.desc), Set#Empty(): Set BoxType));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (read($Heap, this, Node.right) != null ==> Node.validDown($Heap, read($Heap, this, Node.right)));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (Node.blocked($Heap, this) ==> (forall m#0: ref :: m#0 == null || (read($Heap, m#0, alloc) && dtype(m#0) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#0)] ==> Node.blocked($Heap, m#0)));
          invariant $w1 ==> Node.validDown#canCall($Heap, this) ==> Node.validDown($Heap, this) || (Node.after($Heap, this) ==> (forall m#1: ref :: m#1 == null || (read($Heap, m#1, alloc) && dtype(m#1) == class.Node) ==> read($Heap, this, Node.desc)[$Box(m#1)] ==> Node.blocked($Heap, m#1) || Node.after($Heap, m#1)));
          free invariant $w1 ==> Node.valid#canCall($Heap, this);
          free invariant $w1 ==> Node.valid#canCall($Heap, this) && Node.valid($Heap, this) && Node.validUp($Heap, this) && Node.validDown($Heap, this) && Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
          invariant $w1 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validUp($Heap, this);
          invariant $w1 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validDown($Heap, this);
          invariant $w1 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap1, $o, $f) || $o == this || $o == read(old($Heap), this, Node.left) || $o == read(old($Heap), this, Node.right));
          free invariant $HeapSucc($PreLoopHeap1, $Heap);
          free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap1, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap1, $o, $f) || #_Frame#1[$o, $f]);
          free invariant (if !read($Heap, read($Heap, this, Node.right), Node.sense) then z#4 - 0 else 0 - 1) <= $decr1$init$0 && ((if !read($Heap, read($Heap, this, Node.right), Node.sense) then z#4 - 0 else 0 - 1) == $decr1$init$0 ==> true);
        {
            if (!$w1)
            {
                assume Node.validDown#canCall($Heap, this);
                assume Node.validDown#canCall($Heap, this);
                assume Node.validDown($Heap, this);
                assume Node.valid#canCall($Heap, this);
                assume Node.valid#canCall($Heap, this);
                assume Node.valid($Heap, this);
                assert read($Heap, this, Node.right) != null;
                if (!read($Heap, read($Heap, this, Node.right), Node.sense))
                {
                }
                else
                {
                }

                assume (!read($Heap, read($Heap, this, Node.right), Node.sense) ==> true) && (read($Heap, read($Heap, this, Node.right), Node.sense) ==> true);
                assume false;
            }

            assert read($Heap, this, Node.right) != null;
            if (!read($Heap, read($Heap, this, Node.right), Node.sense))
            {
            }

            assume !read($Heap, read($Heap, this, Node.right), Node.sense) ==> true;
            if (!(!read($Heap, read($Heap, this, Node.right), Node.sense) && 0 < z#4))
            {
                break;
            }

            assume {:captureState "TreeBarrier-NoRoot.dfy(97,7): loop entered"} true;
            $decr1$0 := (if !read($Heap, read($Heap, this, Node.right), Node.sense) then z#4 - 0 else 0 - 1);
            // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(103,21)
            assert read($Heap, this, Node.right) != null;
            assume true;
            assert #_Frame#1[read($Heap, this, Node.right), Node.sense];
            havoc $rhs#2;
            $Heap := update($Heap, read($Heap, this, Node.right), Node.sense, $rhs#2);
            assume $IsGoodHeap($Heap);
            assume {:captureState "TreeBarrier-NoRoot.dfy(103,21)"} true;
            // ----- assume statement ----- TreeBarrier-NoRoot.dfy(104,9)
            assert {:subsumption 0} read($Heap, this, Node.right) != null;
            assume Node.blocked#canCall($Heap, read($Heap, this, Node.right));
            if (Node.blocked($Heap, read($Heap, this, Node.right)))
            {
                assume m#11 == null || (read($Heap, m#11, alloc) && dtype(m#11) == class.Node);
                assert {:subsumption 0} read($Heap, this, Node.right) != null;
                if (read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(m#11)])
                {
                    assert {:subsumption 0} m#11 != null;
                    assume Node.blocked#canCall($Heap, m#11);
                }
            }

            assume Node.blocked#canCall($Heap, read($Heap, this, Node.right)) && (Node.blocked($Heap, read($Heap, this, Node.right)) ==> (forall m#6: ref :: m#6 == null || (read($Heap, m#6, alloc) && dtype(m#6) == class.Node) ==> read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(m#6)] ==> Node.blocked#canCall($Heap, m#6)));
            assume Node.blocked($Heap, read($Heap, this, Node.right)) ==> (forall m#6: ref :: m#6 == null || (read($Heap, m#6, alloc) && dtype(m#6) == class.Node) ==> read($Heap, read($Heap, this, Node.right), Node.desc)[$Box(m#6)] ==> Node.blocked($Heap, m#6));
            // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(105,11)
            assume true;
            assume true;
            z#4 := z#4 - 1;
            assume {:captureState "TreeBarrier-NoRoot.dfy(105,11)"} true;
            assert 0 <= $decr1$0 || (if !read($Heap, read($Heap, this, Node.right), Node.sense) then z#4 - 0 else 0 - 1) == $decr1$0;
            assert (if !read($Heap, read($Heap, this, Node.right), Node.sense) then z#4 - 0 else 0 - 1) < $decr1$0;
            assume Node.validDown#canCall($Heap, this);
            assume Node.valid#canCall($Heap, this);
        }

        assume {:captureState "TreeBarrier-NoRoot.dfy(97,7): loop exit"} true;
        // ----- assume statement ----- TreeBarrier-NoRoot.dfy(107,7)
        assume true;
        assume 0 < z#4;
    }
    else
    {
    }

    // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(111,8)
    assume true;
    assert $_Frame[this, Node.pc];
    assume true;
    $rhs#3 := 2;
    $Heap := update($Heap, this, Node.pc, $rhs#3);
    assume $IsGoodHeap($Heap);
    assume {:captureState "TreeBarrier-NoRoot.dfy(111,8)"} true;
    // ----- if statement ----- TreeBarrier-NoRoot.dfy(112,5)
    assume true;
    if (read($Heap, this, Node.parent) != null)
    {
        // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(113,13)
        assume true;
        assert $_Frame[this, Node.sense];
        assume true;
        $rhs#4 := true;
        $Heap := update($Heap, this, Node.sense, $rhs#4);
        assume $IsGoodHeap($Heap);
        assume {:captureState "TreeBarrier-NoRoot.dfy(113,13)"} true;
    }
    else
    {
    }

    // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(116,8)
    assume true;
    assert $_Frame[this, Node.pc];
    assume true;
    $rhs#5 := 3;
    $Heap := update($Heap, this, Node.pc, $rhs#5);
    assume $IsGoodHeap($Heap);
    assume {:captureState "TreeBarrier-NoRoot.dfy(116,8)"} true;
    // ----- while statement ----- TreeBarrier-NoRoot.dfy(117,5)
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == this ==> $_Frame[$o, $f]);
    #_Frame#2 := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
    $PreLoopHeap2 := $Heap;
    $decr2$init$0 := (if read($Heap, this, Node.sense) then z#4 - 0 else 0 - 1);
    havoc $w2;
    while (true)
      free invariant $w2 ==> Node.validUp#canCall($Heap, this);
      free invariant $w2 ==> Node.validUp#canCall($Heap, this) && Node.validUp($Heap, this) && !read($Heap, this, Node.anc)[$Box(this)] && !read($Heap, this, Node.anc)[$Box(null)] && (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))] && Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))) && Node.validUp($Heap, read($Heap, this, Node.parent))) && (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType)) && (Node.after($Heap, this) ==> (forall m#2: ref :: m#2 == null || (read($Heap, m#2, alloc) && dtype(m#2) == class.Node) ==> read($Heap, this, Node.anc)[$Box(m#2)] ==> Node.after($Heap, m#2)));
      invariant $w2 ==> Node.validUp#canCall($Heap, this) ==> Node.validUp($Heap, this) || !read($Heap, this, Node.anc)[$Box(this)];
      invariant $w2 ==> Node.validUp#canCall($Heap, this) ==> Node.validUp($Heap, this) || !read($Heap, this, Node.anc)[$Box(null)];
      invariant $w2 ==> Node.validUp#canCall($Heap, this) ==> Node.validUp($Heap, this) || (read($Heap, this, Node.parent) != null ==> read($Heap, this, Node.anc)[$Box(read($Heap, this, Node.parent))]);
      invariant $w2 ==> Node.validUp#canCall($Heap, this) ==> Node.validUp($Heap, this) || (read($Heap, this, Node.parent) != null ==> Set#Equal(read($Heap, this, Node.anc), Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.parent))), read($Heap, read($Heap, this, Node.parent), Node.anc))));
      invariant $w2 ==> Node.validUp#canCall($Heap, this) ==> Node.validUp($Heap, this) || (read($Heap, this, Node.parent) != null ==> Node.validUp($Heap, read($Heap, this, Node.parent)));
      invariant $w2 ==> Node.validUp#canCall($Heap, this) ==> Node.validUp($Heap, this) || (read($Heap, this, Node.parent) == null ==> Set#Equal(read($Heap, this, Node.anc), Set#Empty(): Set BoxType));
      invariant $w2 ==> Node.validUp#canCall($Heap, this) ==> Node.validUp($Heap, this) || (Node.after($Heap, this) ==> (forall m#2: ref :: m#2 == null || (read($Heap, m#2, alloc) && dtype(m#2) == class.Node) ==> read($Heap, this, Node.anc)[$Box(m#2)] ==> Node.after($Heap, m#2)));
      free invariant $w2 ==> Node.valid#canCall($Heap, this);
      free invariant $w2 ==> Node.valid#canCall($Heap, this) && Node.valid($Heap, this) && Node.validUp($Heap, this) && Node.validDown($Heap, this) && Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
      invariant $w2 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validUp($Heap, this);
      invariant $w2 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Node.validDown($Heap, this);
      invariant $w2 ==> Node.valid#canCall($Heap, this) ==> Node.valid($Heap, this) || Set#Disjoint(read($Heap, this, Node.desc), read($Heap, this, Node.anc));
      free invariant $w2 ==> old(true);
      invariant $w2 ==> read($Heap, this, Node.left) == old(read($Heap, this, Node.left));
      free invariant $w2 ==> old(true);
      invariant $w2 ==> read($Heap, this, Node.right) == old(read($Heap, this, Node.right));
      free invariant $w2 ==> read($Heap, this, Node.sense) ==> true;
      invariant $w2 ==> read($Heap, this, Node.sense) ==> read($Heap, this, Node.parent) != null;
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap2, $o, $f) || $o == this || $o == read(old($Heap), this, Node.left) || $o == read(old($Heap), this, Node.right));
      free invariant $HeapSucc($PreLoopHeap2, $Heap);
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap2, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap2, $o, $f) || #_Frame#2[$o, $f]);
      free invariant (if read($Heap, this, Node.sense) then z#4 - 0 else 0 - 1) <= $decr2$init$0 && ((if read($Heap, this, Node.sense) then z#4 - 0 else 0 - 1) == $decr2$init$0 ==> true);
    {
        if (!$w2)
        {
            assume Node.validUp#canCall($Heap, this);
            assume Node.validUp#canCall($Heap, this);
            assume Node.validUp($Heap, this);
            assume Node.valid#canCall($Heap, this);
            assume Node.valid#canCall($Heap, this);
            assume Node.valid($Heap, this);
            assume old(true);
            assume read($Heap, this, Node.left) == old(read($Heap, this, Node.left));
            assume old(true);
            assume read($Heap, this, Node.right) == old(read($Heap, this, Node.right));
            if (read($Heap, this, Node.sense))
            {
            }

            assume read($Heap, this, Node.sense) ==> true;
            assume read($Heap, this, Node.sense) ==> read($Heap, this, Node.parent) != null;
            if (read($Heap, this, Node.sense))
            {
            }
            else
            {
            }

            assume (read($Heap, this, Node.sense) ==> true) && (!read($Heap, this, Node.sense) ==> true);
            assume false;
        }

        if (read($Heap, this, Node.sense))
        {
        }

        assume read($Heap, this, Node.sense) ==> true;
        if (!(read($Heap, this, Node.sense) && 0 < z#4))
        {
            break;
        }

        assume {:captureState "TreeBarrier-NoRoot.dfy(117,5): loop entered"} true;
        $decr2$0 := (if read($Heap, this, Node.sense) then z#4 - 0 else 0 - 1);
        // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(130,13)
        assume true;
        assert #_Frame#2[this, Node.sense];
        havoc $rhs#6;
        $Heap := update($Heap, this, Node.sense, $rhs#6);
        assume $IsGoodHeap($Heap);
        assume {:captureState "TreeBarrier-NoRoot.dfy(130,13)"} true;
        // ----- assume statement ----- TreeBarrier-NoRoot.dfy(131,7)
        if (!read($Heap, this, Node.sense))
        {
            assert {:subsumption 0} read($Heap, this, Node.parent) != null;
            assume Node.after#canCall($Heap, read($Heap, this, Node.parent));
        }

        assume !read($Heap, this, Node.sense) ==> Node.after#canCall($Heap, read($Heap, this, Node.parent));
        assume !read($Heap, this, Node.sense) ==> Node.after($Heap, read($Heap, this, Node.parent));
        // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(133,9)
        assume true;
        assume true;
        z#4 := z#4 - 1;
        assume {:captureState "TreeBarrier-NoRoot.dfy(133,9)"} true;
        assert 0 <= $decr2$0 || (if read($Heap, this, Node.sense) then z#4 - 0 else 0 - 1) == $decr2$0;
        assert (if read($Heap, this, Node.sense) then z#4 - 0 else 0 - 1) < $decr2$0;
        assume Node.validUp#canCall($Heap, this);
        assume Node.valid#canCall($Heap, this);
        assume old(true);
        assume old(true);
        assume read($Heap, this, Node.sense) ==> true;
    }

    assume {:captureState "TreeBarrier-NoRoot.dfy(117,5): loop exit"} true;
    // ----- assume statement ----- TreeBarrier-NoRoot.dfy(135,5)
    assume true;
    assume 0 < z#4;
    // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(137,8)
    assume true;
    assert $_Frame[this, Node.pc];
    assume true;
    $rhs#7 := 4;
    $Heap := update($Heap, this, Node.pc, $rhs#7);
    assume $IsGoodHeap($Heap);
    assume {:captureState "TreeBarrier-NoRoot.dfy(137,8)"} true;
    // ----- if statement ----- TreeBarrier-NoRoot.dfy(138,5)
    assume true;
    if (read($Heap, this, Node.left) != null)
    {
        // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(139,18)
        assert read($Heap, this, Node.left) != null;
        assume true;
        assert $_Frame[read($Heap, this, Node.left), Node.sense];
        assume true;
        $rhs#8 := false;
        $Heap := update($Heap, read($Heap, this, Node.left), Node.sense, $rhs#8);
        assume $IsGoodHeap($Heap);
        assume {:captureState "TreeBarrier-NoRoot.dfy(139,18)"} true;
    }
    else
    {
    }

    // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(142,8)
    assume true;
    assert $_Frame[this, Node.pc];
    assume true;
    $rhs#9 := 5;
    $Heap := update($Heap, this, Node.pc, $rhs#9);
    assume $IsGoodHeap($Heap);
    assume {:captureState "TreeBarrier-NoRoot.dfy(142,8)"} true;
    // ----- if statement ----- TreeBarrier-NoRoot.dfy(143,5)
    assume true;
    if (read($Heap, this, Node.right) != null)
    {
        // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(144,19)
        assert read($Heap, this, Node.right) != null;
        assume true;
        assert $_Frame[read($Heap, this, Node.right), Node.sense];
        assume true;
        $rhs#10 := false;
        $Heap := update($Heap, read($Heap, this, Node.right), Node.sense, $rhs#10);
        assume $IsGoodHeap($Heap);
        assume {:captureState "TreeBarrier-NoRoot.dfy(144,19)"} true;
    }
    else
    {
    }

    // ----- assignment statement ----- TreeBarrier-NoRoot.dfy(147,8)
    assume true;
    assert $_Frame[this, Node.pc];
    assume true;
    $rhs#11 := 6;
    $Heap := update($Heap, this, Node.pc, $rhs#11);
    assume $IsGoodHeap($Heap);
    assume {:captureState "TreeBarrier-NoRoot.dfy(147,8)"} true;
}



const unique class._default: ClassName;
