// Dafny program verifier version 2.2.30705.1126, Copyright (c) 2003-2011, Microsoft.
// Command Line Options: /print:AVLTree.bpl AVLTree.dfy

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

axiom (forall<T> r: T :: { MultiSet#Singleton(r) } MultiSet#Singleton(r)[r] == 1);

axiom (forall<T> r: T, o: T :: { MultiSet#Singleton(r)[o] } (MultiSet#Singleton(r)[o] == 1 <==> r == o) && (MultiSet#Singleton(r)[o] == 0 <==> r != o));

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

type Seq _;

function Seq#Length<T>(Seq T) : int;

axiom (forall<T> s: Seq T :: { Seq#Length(s) } 0 <= Seq#Length(s));

function Seq#Empty<T>() : Seq T;

axiom (forall<T>  :: Seq#Length(Seq#Empty(): Seq T) == 0);

axiom (forall<T> s: Seq T :: { Seq#Length(s) } Seq#Length(s) == 0 ==> s == Seq#Empty());

function Seq#Singleton<T>(T) : Seq T;

axiom (forall<T> t: T :: { Seq#Length(Seq#Singleton(t)) } Seq#Length(Seq#Singleton(t)) == 1);

function Seq#Build<T>(s: Seq T, index: int, val: T, newLength: int) : Seq T;

axiom (forall<T> s: Seq T, i: int, v: T, len: int :: { Seq#Length(Seq#Build(s, i, v, len)) } 0 <= len ==> Seq#Length(Seq#Build(s, i, v, len)) == len);

function Seq#Append<T>(Seq T, Seq T) : Seq T;

axiom (forall<T> s0: Seq T, s1: Seq T :: { Seq#Length(Seq#Append(s0, s1)) } Seq#Length(Seq#Append(s0, s1)) == Seq#Length(s0) + Seq#Length(s1));

function Seq#Index<T>(Seq T, int) : T;

axiom (forall<T> t: T :: { Seq#Index(Seq#Singleton(t), 0) } Seq#Index(Seq#Singleton(t), 0) == t);

axiom (forall<T> s0: Seq T, s1: Seq T, n: int :: { Seq#Index(Seq#Append(s0, s1), n) } (n < Seq#Length(s0) ==> Seq#Index(Seq#Append(s0, s1), n) == Seq#Index(s0, n)) && (Seq#Length(s0) <= n ==> Seq#Index(Seq#Append(s0, s1), n) == Seq#Index(s1, n - Seq#Length(s0))));

axiom (forall<T> s: Seq T, i: int, v: T, len: int, n: int :: { Seq#Index(Seq#Build(s, i, v, len), n) } 0 <= n && n < len ==> (i == n ==> Seq#Index(Seq#Build(s, i, v, len), n) == v) && (i != n ==> Seq#Index(Seq#Build(s, i, v, len), n) == Seq#Index(s, n)));

function Seq#Update<T>(Seq T, int, T) : Seq T;

axiom (forall<T> s: Seq T, i: int, v: T :: { Seq#Length(Seq#Update(s, i, v)) } 0 <= i && i < Seq#Length(s) ==> Seq#Length(Seq#Update(s, i, v)) == Seq#Length(s));

axiom (forall<T> s: Seq T, i: int, v: T, n: int :: { Seq#Index(Seq#Update(s, i, v), n) } 0 <= n && n < Seq#Length(s) ==> (i == n ==> Seq#Index(Seq#Update(s, i, v), n) == v) && (i != n ==> Seq#Index(Seq#Update(s, i, v), n) == Seq#Index(s, n)));

function Seq#Contains<T>(Seq T, T) : bool;

axiom (forall<T> s: Seq T, x: T :: { Seq#Contains(s, x) } Seq#Contains(s, x) <==> (exists i: int :: { Seq#Index(s, i) } 0 <= i && i < Seq#Length(s) && Seq#Index(s, i) == x));

axiom (forall x: ref :: { Seq#Contains(Seq#Empty(), x) } !Seq#Contains(Seq#Empty(), x));

axiom (forall<T> s0: Seq T, s1: Seq T, x: T :: { Seq#Contains(Seq#Append(s0, s1), x) } Seq#Contains(Seq#Append(s0, s1), x) <==> Seq#Contains(s0, x) || Seq#Contains(s1, x));

axiom (forall<T> i: int, v: T, len: int, x: T :: { Seq#Contains(Seq#Build(Seq#Empty(), i, v, len), x) } 0 <= i && i < len ==> (Seq#Contains(Seq#Build(Seq#Empty(), i, v, len), x) <==> x == v));

axiom (forall<T> s: Seq T, i0: int, v0: T, len0: int, i1: int, v1: T, len1: int, x: T :: { Seq#Contains(Seq#Build(Seq#Build(s, i0, v0, len0), i1, v1, len1), x) } 0 <= i0 && i0 < len0 && len0 <= i1 && i1 < len1 ==> (Seq#Contains(Seq#Build(Seq#Build(s, i0, v0, len0), i1, v1, len1), x) <==> v1 == x || Seq#Contains(Seq#Build(s, i0, v0, len0), x)));

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

//axiom (forall a: HeapType, b: HeapType, c: HeapType :: { $HeapSucc(a, b), $HeapSucc(b, c) } $HeapSucc(a, b) && $HeapSucc(b, c) ==> $HeapSucc(a, c));

axiom (forall h: HeapType, k: HeapType :: { $HeapSucc(h, k) } $HeapSucc(h, k) ==> (forall o: ref :: { read(k, o, alloc) } read(h, o, alloc) ==> read(k, o, alloc)));

type TickType;

var $Tick: TickType;

//axiom (forall x: int, y: int :: { x % y } { x / y } x % y == x - x / y * y);

//axiom (forall x: int, y: int :: { x % y } 0 < y ==> 0 <= x % y && x % y < y);

//axiom (forall x: int, y: int :: { x % y } y < 0 ==> 0 <= x % y && x % y < 0 - y);

//axiom (forall a: int, b: int, d: int :: { a % d, b % d } 2 <= d && a % d == b % d && a < b ==> a + d <= b);

const unique class.object: ClassName;

const unique class.array: ClassName;

const unique class.AVLTree: ClassName;

axiom FDim(AVLTree.root) == 0 && DeclType(AVLTree.root) == class.AVLTree;

const unique AVLTree.root: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, AVLTree.root) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, AVLTree.root) == null || (read($h, read($h, $o, AVLTree.root), alloc) && dtype(read($h, $o, AVLTree.root)) == class.Node));

axiom FDim(AVLTree.Contents) == 0 && DeclType(AVLTree.Contents) == class.AVLTree;

const unique AVLTree.Contents: Field (Set BoxType);

axiom FDim(AVLTree.Repr) == 0 && DeclType(AVLTree.Repr) == class.AVLTree;

const unique AVLTree.Repr: Field (Set BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, AVLTree.Repr) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $t#1: BoxType :: { read($h, $o, AVLTree.Repr)[$t#1] } read($h, $o, AVLTree.Repr)[$t#1] ==> $Unbox($t#1): ref == null || (read($h, $Unbox($t#1): ref, alloc) && dtype($Unbox($t#1): ref) == class.Node)));

procedure CheckWellformed$$AVLTree.Init(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, v#0: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$AVLTree.Init(this: ref, v#0: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this);
    assume $HeapSucc(old($Heap), $Heap);
    assume AVLTree.Valid#canCall($Heap, this);
    assume AVLTree.Valid($Heap, this);
}



axiom FDim(Node.Repr) == 0 && DeclType(Node.Repr) == class.Node;

axiom FDim(Node.Contents) == 0 && DeclType(Node.Contents) == class.Node;

procedure AVLTree.Init(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, v#0: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;
  free ensures AVLTree.Valid#canCall($Heap, this) && AVLTree.Valid($Heap, this) && read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) && Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.root) != null;
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))];
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Valid($Heap, read($Heap, this, AVLTree.root));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.BalanceValid($Heap, read($Heap, this, AVLTree.root));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this);
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation AVLTree.Init(this: ref, v#0: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $rhs#0: ref;
  var $nw: ref;
  var v#46: int;
  var $rhs#1: Set BoxType;
  var $rhs#2: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
    // ----- assignment statement ----- AVLTree.dfy(11,12)
    assume true;
    assert $_Frame[this, AVLTree.root];
    havoc $nw;
    assume $nw != null && !read($Heap, $nw, alloc) && dtype($nw) == class.Node;
    $Heap := update($Heap, $nw, alloc, true);
    assume $IsGoodHeap($Heap);
    $rhs#0 := $nw;
    $Heap := update($Heap, this, AVLTree.root, $rhs#0);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(11,12)"} true;
    // ----- call statement ----- AVLTree.dfy(12,12)
    assume true;
    v#46 := v#0;
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == read($Heap, this, AVLTree.root) ==> $_Frame[$o, $f]);
    call Node.Init(read($Heap, this, AVLTree.root), v#46);
    assume {:captureState "AVLTree.dfy(12,12)"} true;
    // ----- assignment statement ----- AVLTree.dfy(13,21)
    assume true;
    assert $_Frame[this, AVLTree.Contents];
    assert read($Heap, this, AVLTree.root) != null;
    assume true;
    $rhs#1 := read($Heap, read($Heap, this, AVLTree.root), Node.Contents);
    $Heap := update($Heap, this, AVLTree.Contents, $rhs#1);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(13,21)"} true;
    // ----- assignment statement ----- AVLTree.dfy(14,17)
    assume true;
    assert $_Frame[this, AVLTree.Repr];
    assert read($Heap, this, AVLTree.root) != null;
    assume true;
    $rhs#2 := read($Heap, read($Heap, this, AVLTree.root), Node.Repr);
    $Heap := update($Heap, this, AVLTree.Repr, $rhs#2);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(14,17)"} true;
}



function AVLTree.Valid($heap: HeapType, this: ref) : bool;

function AVLTree.Valid#canCall($heap: HeapType, this: ref) : bool;

// definition axiom for AVLTree.Valid
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (7 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { AVLTree.Valid($Heap, this) } AVLTree.Valid#canCall($Heap, this) || ((0 != $ModuleContextHeight || 7 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree) ==> (read($Heap, this, AVLTree.root) != null ==> true) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] ==> true) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) ==> true) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) ==> Node.Valid#canCall($Heap, read($Heap, this, AVLTree.root))) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) ==> Node.BalanceValid#canCall($Heap, read($Heap, this, AVLTree.root))) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) ==> Node.Balanced#canCall($Heap, read($Heap, this, AVLTree.root))) && AVLTree.Valid($Heap, this) == (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) && Node.Balanced($Heap, read($Heap, this, AVLTree.root))));

// frame axiom for AVLTree.Valid
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), AVLTree.Valid($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.AVLTree && read($h1, this, alloc) && dtype(this) == class.AVLTree && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == this || read($h0, this, AVLTree.Repr)[$Box($o)]) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> AVLTree.Valid($h0, this) == AVLTree.Valid($h1, this));

procedure CheckWellformed$$AVLTree.Valid(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree);
  free requires 0 == $ModuleContextHeight && 7 == $FunctionContextHeight;



implementation CheckWellformed$$AVLTree.Valid(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#47: ref;
  var n#48: ref;
  var n#49: ref;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || read($Heap, this, AVLTree.Repr)[$Box($o)]);
        assert $_Frame[this, AVLTree.root];
        if (read($Heap, this, AVLTree.root) != null)
        {
            assert $_Frame[this, AVLTree.root];
            assert $_Frame[this, AVLTree.Repr];
        }

        if (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))])
        {
            assert $_Frame[this, AVLTree.Repr];
            assert $_Frame[this, AVLTree.root];
            assert read($Heap, this, AVLTree.root) != null;
            assert $_Frame[read($Heap, this, AVLTree.root), Node.Repr];
        }

        if (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)))
        {
            assert $_Frame[this, AVLTree.Contents];
            assert $_Frame[this, AVLTree.root];
            assert read($Heap, this, AVLTree.root) != null;
            assert $_Frame[read($Heap, this, AVLTree.root), Node.Contents];
        }

        if (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)))
        {
            assert $_Frame[this, AVLTree.root];
            n#47 := read($Heap, this, AVLTree.root);
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#47 || (n#47 != null && read($Heap, n#47, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
            assume Node.Valid#canCall($Heap, read($Heap, this, AVLTree.root));
        }

        if (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)))
        {
            assert $_Frame[this, AVLTree.root];
            n#48 := read($Heap, this, AVLTree.root);
            assert Node.Valid($Heap, n#48);
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#48 || (n#48 != null && read($Heap, n#48, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
            assume Node.BalanceValid#canCall($Heap, read($Heap, this, AVLTree.root));
        }

        if (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)))
        {
            assert $_Frame[this, AVLTree.root];
            n#49 := read($Heap, this, AVLTree.root);
            assert Node.Valid($Heap, n#49) && Node.BalanceValid($Heap, n#49);
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#49 || (n#49 != null && read($Heap, n#49, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
            assume Node.Balanced#canCall($Heap, read($Heap, this, AVLTree.root));
        }

        assume AVLTree.Valid($Heap, this) == (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) && Node.Balanced($Heap, read($Heap, this, AVLTree.root)));
        assume (read($Heap, this, AVLTree.root) != null ==> true) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] ==> true) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) ==> true) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) ==> Node.Valid#canCall($Heap, read($Heap, this, AVLTree.root))) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) ==> Node.BalanceValid#canCall($Heap, read($Heap, this, AVLTree.root))) && (read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) ==> Node.Balanced#canCall($Heap, read($Heap, this, AVLTree.root)));
    }
}



procedure CheckWellformed$$AVLTree.Find(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, key#1: int) returns (b#2: bool);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$AVLTree.Find(this: ref, key#1: int) returns (b#2: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume AVLTree.Valid#canCall($Heap, this);
    assume AVLTree.Valid($Heap, this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    havoc b#2;
    assume read($Heap, this, AVLTree.Contents)[$Box(key#1)] <==> b#2;
}



procedure AVLTree.Find(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, key#1: int) returns (b#2: bool);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires AVLTree.Valid#canCall($Heap, this) && AVLTree.Valid($Heap, this) && read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) && Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.root) != null;
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))];
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Valid($Heap, read($Heap, this, AVLTree.root));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.BalanceValid($Heap, read($Heap, this, AVLTree.root));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  modifies $Heap, $Tick;
  ensures read($Heap, this, AVLTree.Contents)[$Box(key#1)] <==> b#2;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



axiom FDim(Node.left) == 0 && DeclType(Node.left) == class.Node;

axiom FDim(Node.right) == 0 && DeclType(Node.right) == class.Node;

axiom FDim(Node.value) == 0 && DeclType(Node.value) == class.Node;

implementation AVLTree.Find(this: ref, key#1: int) returns (b#2: bool)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var t#3: ref where t#3 == null || (read($Heap, t#3, alloc) && dtype(t#3) == class.Node);
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: Set BoxType;
  var $w0: bool;
  var n#50: ref;
  var $decr0$0: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    // ----- var-declaration statement ----- AVLTree.dfy(29,11)
    // ----- assignment statement ----- AVLTree.dfy(29,13)
    assume true;
    assume true;
    t#3 := read($Heap, this, AVLTree.root);
    assume {:captureState "AVLTree.dfy(29,13)"} true;
    // ----- while statement ----- AVLTree.dfy(30,7)
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := read($Heap, t#3, Node.Repr);
    havoc $w0;
    while (true)
      free invariant $w0 ==> t#3 != null ==> Node.Valid#canCall($Heap, t#3);
      invariant $w0 ==> t#3 != null;
      free invariant $w0 ==> Node.Valid#canCall($Heap, t#3) && Node.Valid($Heap, t#3) && (t#3 != null ==> read($Heap, t#3, Node.Repr)[$Box(t#3)] && !read($Heap, t#3, Node.Repr)[$Box(null)] && (read($Heap, t#3, Node.left) != null ==> read($Heap, t#3, Node.Repr)[$Box(read($Heap, t#3, Node.left))] && !read($Heap, read($Heap, t#3, Node.left), Node.Repr)[$Box(t#3)] && Set#Subset(read($Heap, read($Heap, t#3, Node.left), Node.Repr), read($Heap, t#3, Node.Repr))) && (read($Heap, t#3, Node.right) != null ==> read($Heap, t#3, Node.Repr)[$Box(read($Heap, t#3, Node.right))] && !read($Heap, read($Heap, t#3, Node.right), Node.Repr)[$Box(t#3)] && Set#Subset(read($Heap, read($Heap, t#3, Node.right), Node.Repr), read($Heap, t#3, Node.Repr))) && Node.Valid($Heap, read($Heap, t#3, Node.left)) && Node.Valid($Heap, read($Heap, t#3, Node.right)) && (read($Heap, t#3, Node.right) != null && read($Heap, t#3, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, t#3, Node.left), Node.Repr), read($Heap, read($Heap, t#3, Node.right), Node.Repr))) && Set#Equal(read($Heap, t#3, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#3)), (if read($Heap, t#3, Node.left) != null then read($Heap, read($Heap, t#3, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, t#3, Node.right) != null then read($Heap, read($Heap, t#3, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, t#3, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#3, Node.value))), (if read($Heap, t#3, Node.left) != null then read($Heap, read($Heap, t#3, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, t#3, Node.right) != null then read($Heap, read($Heap, t#3, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, t#3, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, t#3, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, t#3, Node.value))) && (read($Heap, t#3, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, t#3, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, t#3, Node.value) < i#17)));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.Repr)[$Box(t#3)]);
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> !read($Heap, t#3, Node.Repr)[$Box(null)]);
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.left) != null ==> read($Heap, t#3, Node.Repr)[$Box(read($Heap, t#3, Node.left))]);
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.left) != null ==> !read($Heap, read($Heap, t#3, Node.left), Node.Repr)[$Box(t#3)]);
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, t#3, Node.left), Node.Repr), read($Heap, t#3, Node.Repr)));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.right) != null ==> read($Heap, t#3, Node.Repr)[$Box(read($Heap, t#3, Node.right))]);
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.right) != null ==> !read($Heap, read($Heap, t#3, Node.right), Node.Repr)[$Box(t#3)]);
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, t#3, Node.right), Node.Repr), read($Heap, t#3, Node.Repr)));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> Node.Valid($Heap, read($Heap, t#3, Node.left)));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> Node.Valid($Heap, read($Heap, t#3, Node.right)));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.right) != null && read($Heap, t#3, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, t#3, Node.left), Node.Repr), read($Heap, read($Heap, t#3, Node.right), Node.Repr)));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> Set#Equal(read($Heap, t#3, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#3)), (if read($Heap, t#3, Node.left) != null then read($Heap, read($Heap, t#3, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, t#3, Node.right) != null then read($Heap, read($Heap, t#3, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> Set#Equal(read($Heap, t#3, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#3, Node.value))), (if read($Heap, t#3, Node.left) != null then read($Heap, read($Heap, t#3, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, t#3, Node.right) != null then read($Heap, read($Heap, t#3, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, t#3, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, t#3, Node.value)));
      invariant $w0 ==> Node.Valid#canCall($Heap, t#3) ==> Node.Valid($Heap, t#3) || (t#3 != null ==> read($Heap, t#3, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, t#3, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, t#3, Node.value) < i#17));
      free invariant $w0 ==> true;
      invariant $w0 ==> !(read($Heap, this, AVLTree.Contents)[$Box(key#1)] && !read($Heap, t#3, Node.Contents)[$Box(key#1)]);
      free invariant $w0 ==> true;
      invariant $w0 ==> Set#Subset(read($Heap, t#3, Node.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents));
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f));
      free invariant $HeapSucc($PreLoopHeap0, $Heap);
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read($PreLoopHeap0, $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f) || $_Frame[$o, $f]);
      free invariant Set#Subset(read($Heap, t#3, Node.Repr), $decr0$init$0) && (Set#Equal(read($Heap, t#3, Node.Repr), $decr0$init$0) ==> true);
    {
        if (!$w0)
        {
            if (t#3 != null)
            {
                n#50 := t#3;
                assume Node.Valid#canCall($Heap, t#3);
            }

            assume t#3 != null ==> Node.Valid#canCall($Heap, t#3);
            assume t#3 != null && Node.Valid($Heap, t#3);
            assert {:subsumption 0} t#3 != null;
            assume true;
            assume !(read($Heap, this, AVLTree.Contents)[$Box(key#1)] && !read($Heap, t#3, Node.Contents)[$Box(key#1)]);
            assert {:subsumption 0} t#3 != null;
            assert {:subsumption 0} read($Heap, this, AVLTree.root) != null;
            assume true;
            assume Set#Subset(read($Heap, t#3, Node.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents));
            assert t#3 != null;
            assume true;
            assume false;
        }

        assume true;
        if (!true)
        {
            break;
        }

        assume {:captureState "AVLTree.dfy(30,7): loop entered"} true;
        $decr0$0 := read($Heap, t#3, Node.Repr);
        // ----- if statement ----- AVLTree.dfy(36,10)
        assert t#3 != null;
        assume true;
        if (read($Heap, t#3, Node.value) == key#1)
        {
            // ----- assert statement ----- AVLTree.dfy(38,13)
            assert {:subsumption 0} t#3 != null;
            assert {:subsumption 0} t#3 != null;
            assume true;
            assert read($Heap, t#3, Node.Contents)[$Box(read($Heap, t#3, Node.value))];
            // ----- assignment statement ----- AVLTree.dfy(39,15)
            assume true;
            assume true;
            b#2 := true;
            assume {:captureState "AVLTree.dfy(39,15)"} true;
            // ----- return statement ----- AVLTree.dfy(40,13)
            return;
        }
        else
        {
            // ----- if statement ----- AVLTree.dfy(42,15)
            assert t#3 != null;
            assume true;
            if (read($Heap, t#3, Node.value) < key#1)
            {
                // ----- assignment statement ----- AVLTree.dfy(44,15)
                assume true;
                assert t#3 != null;
                assume true;
                t#3 := read($Heap, t#3, Node.right);
                assume {:captureState "AVLTree.dfy(44,15)"} true;
            }
            else
            {
                // ----- assignment statement ----- AVLTree.dfy(48,15)
                assume true;
                assert t#3 != null;
                assume true;
                t#3 := read($Heap, t#3, Node.left);
                assume {:captureState "AVLTree.dfy(48,15)"} true;
            }
        }

        // ----- if statement ----- AVLTree.dfy(50,10)
        assume true;
        if (t#3 == null)
        {
            // ----- assignment statement ----- AVLTree.dfy(52,15)
            assume true;
            assume true;
            b#2 := false;
            assume {:captureState "AVLTree.dfy(52,15)"} true;
            // ----- return statement ----- AVLTree.dfy(53,13)
            return;
        }
        else
        {
        }

        assert Set#Subset(read($Heap, t#3, Node.Repr), $decr0$0) && !Set#Subset($decr0$0, read($Heap, t#3, Node.Repr));
        assume t#3 != null ==> Node.Valid#canCall($Heap, t#3);
        assume true;
        assume true;
    }

    assume {:captureState "AVLTree.dfy(30,7): loop exit"} true;
}



procedure CheckWellformed$$AVLTree.Insert(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, key#4: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$AVLTree.Insert(this: ref, key#4: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || read($Heap, this, AVLTree.Repr)[$Box($o)]);
    assume AVLTree.Valid#canCall($Heap, this);
    assume AVLTree.Valid($Heap, this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this || read(old($Heap), this, AVLTree.Repr)[$Box($o)]);
    assume $HeapSucc(old($Heap), $Heap);
    assume Set#Equal(read($Heap, this, AVLTree.Contents), Set#Union(old(read($Heap, this, AVLTree.Contents)), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#4))));
    assume AVLTree.Valid#canCall($Heap, this);
    assume AVLTree.Valid($Heap, this);
}



procedure AVLTree.Insert(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, key#4: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires AVLTree.Valid#canCall($Heap, this) && AVLTree.Valid($Heap, this) && read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) && Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.root) != null;
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))];
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Valid($Heap, read($Heap, this, AVLTree.root));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.BalanceValid($Heap, read($Heap, this, AVLTree.root));
  requires AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  modifies $Heap, $Tick;
  ensures Set#Equal(read($Heap, this, AVLTree.Contents), Set#Union(old(read($Heap, this, AVLTree.Contents)), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#4))));
  free ensures AVLTree.Valid#canCall($Heap, this) && AVLTree.Valid($Heap, this) && read($Heap, this, AVLTree.root) != null && read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))] && Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr)) && Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents)) && Node.Valid($Heap, read($Heap, this, AVLTree.root)) && Node.BalanceValid($Heap, read($Heap, this, AVLTree.root)) && Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.root) != null;
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || read($Heap, this, AVLTree.Repr)[$Box(read($Heap, this, AVLTree.root))];
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Repr), read($Heap, read($Heap, this, AVLTree.root), Node.Repr));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Set#Equal(read($Heap, this, AVLTree.Contents), read($Heap, read($Heap, this, AVLTree.root), Node.Contents));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Valid($Heap, read($Heap, this, AVLTree.root));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.BalanceValid($Heap, read($Heap, this, AVLTree.root));
  ensures AVLTree.Valid#canCall($Heap, this) ==> AVLTree.Valid($Heap, this) || Node.Balanced($Heap, read($Heap, this, AVLTree.root));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this || read(old($Heap), this, AVLTree.Repr)[$Box($o)]);
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation AVLTree.Insert(this: ref, key#4: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var dummy#5: int;
  var $obj0: ref;
  var $rhs#0: ref where $rhs#0 == null || (read($Heap, $rhs#0, alloc) && dtype($rhs#0) == class.Node);
  var $rhs#1: int;
  var t#51: ref;
  var key#52: int;
  var $rhs#2: Set BoxType;
  var $rhs#3: Set BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || read($Heap, this, AVLTree.Repr)[$Box($o)]);
    // ----- var-declaration statement ----- AVLTree.dfy(63,11)
    // ----- call statement ----- AVLTree.dfy(64,22)
    assume true;
    $obj0 := this;
    assert $_Frame[$obj0, AVLTree.root];
    assume true;
    assume true;
    t#51 := read($Heap, this, AVLTree.root);
    assume true;
    key#52 := key#4;
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && t#51 != null && read($Heap, t#51, Node.Repr)[$Box($o)] ==> $_Frame[$o, $f]);
    call $rhs#0, $rhs#1 := AVLTree.InsertRecursion(this, t#51, key#52);
    $Heap := update($Heap, $obj0, AVLTree.root, $rhs#0);
    assume $IsGoodHeap($Heap);
    dummy#5 := $rhs#1;
    assume {:captureState "AVLTree.dfy(64,22)"} true;
    // ----- assignment statement ----- AVLTree.dfy(65,16)
    assume true;
    assert $_Frame[this, AVLTree.Contents];
    assert read($Heap, this, AVLTree.root) != null;
    assume true;
    $rhs#2 := read($Heap, read($Heap, this, AVLTree.root), Node.Contents);
    $Heap := update($Heap, this, AVLTree.Contents, $rhs#2);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(65,16)"} true;
    // ----- assignment statement ----- AVLTree.dfy(66,12)
    assume true;
    assert $_Frame[this, AVLTree.Repr];
    assert read($Heap, this, AVLTree.root) != null;
    assume true;
    $rhs#3 := read($Heap, read($Heap, this, AVLTree.root), Node.Repr);
    $Heap := update($Heap, this, AVLTree.Repr, $rhs#3);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(66,12)"} true;
}



procedure CheckWellformed$$AVLTree.InsertRecursion(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, t#6: ref where t#6 == null || (read($Heap, t#6, alloc) && dtype(t#6) == class.Node), key#7: int) returns (r#8: ref where r#8 == null || (read($Heap, r#8, alloc) && dtype(r#8) == class.Node), deltaH#9: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



axiom FDim(Node.balance) == 0 && DeclType(Node.balance) == class.Node;

implementation CheckWellformed$$AVLTree.InsertRecursion(this: ref, t#6: ref, key#7: int) returns (r#8: ref, deltaH#9: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#53: ref;
  var n#54: ref;
  var n#55: ref;
  var n#56: ref;
  var n#57: ref;
  var n#58: ref;
  var n#59: ref;
  var n#60: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> t#6 != null && read($Heap, t#6, Node.Repr)[$Box($o)]);
    n#53 := t#6;
    assume Node.Valid#canCall($Heap, t#6);
    if (Node.Valid($Heap, t#6))
    {
        n#54 := t#6;
        assert Node.Valid($Heap, n#54);
        assume Node.BalanceValid#canCall($Heap, t#6);
    }

    if (Node.Valid($Heap, t#6) && Node.BalanceValid($Heap, t#6))
    {
        n#55 := t#6;
        assert Node.Valid($Heap, n#55) && Node.BalanceValid($Heap, n#55);
        assume Node.Balanced#canCall($Heap, t#6);
    }

    assume Node.Valid($Heap, t#6) && Node.BalanceValid($Heap, t#6) && Node.Balanced($Heap, t#6);
    if (t#6 != null)
    {
        assert t#6 != null;
    }
    else
    {
    }

    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || (t#6 != null && read(old($Heap), t#6, Node.Repr)[$Box($o)]));
    assume $HeapSucc(old($Heap), $Heap);
    havoc r#8, deltaH#9;
    if (r#8 != null)
    {
        if (t#6 != null)
        {
            assert t#6 != null;
        }

        if (!(t#6 != null && old(read($Heap, t#6, Node.Repr))[$Box(r#8)]))
        {
        }
    }

    assume r#8 != null && ((t#6 != null && old(read($Heap, t#6, Node.Repr))[$Box(r#8)]) || r#8 == null || !read(old($Heap), r#8, alloc));
    if (t#6 != null)
    {
        assert r#8 != null;
        assert t#6 != null;
        if ((forall $o: ref :: $o != null && read($Heap, r#8, Node.Repr)[$Box($o)] && !old(read($Heap, t#6, Node.Repr))[$Box($o)] ==> !read(old($Heap), $o, alloc)))
        {
            assert r#8 != null;
            assert t#6 != null;
        }
    }

    assume t#6 != null ==> (forall $o: ref :: $o != null && read($Heap, r#8, Node.Repr)[$Box($o)] && !old(read($Heap, t#6, Node.Repr))[$Box($o)] ==> !read(old($Heap), $o, alloc)) && Set#Equal(read($Heap, r#8, Node.Contents), Set#Union(old(read($Heap, t#6, Node.Contents)), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#7))));
    if (t#6 == null)
    {
        assert r#8 != null;
        if ((forall $o: ref :: $o != null && read($Heap, r#8, Node.Repr)[$Box($o)] ==> !read(old($Heap), $o, alloc)))
        {
            assert r#8 != null;
        }
    }

    assume t#6 == null ==> (forall $o: ref :: $o != null && read($Heap, r#8, Node.Repr)[$Box($o)] ==> !read(old($Heap), $o, alloc)) && Set#Equal(read($Heap, r#8, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#7)));
    n#56 := r#8;
    assume Node.Valid#canCall($Heap, r#8);
    if (Node.Valid($Heap, r#8))
    {
        n#57 := r#8;
        assert Node.Valid($Heap, n#57);
        assume Node.BalanceValid#canCall($Heap, r#8);
    }

    if (Node.Valid($Heap, r#8) && Node.BalanceValid($Heap, r#8))
    {
        n#58 := r#8;
        assert Node.Valid($Heap, n#58) && Node.BalanceValid($Heap, n#58);
        assume Node.Balanced#canCall($Heap, r#8);
    }

    assume Node.Valid($Heap, r#8) && Node.BalanceValid($Heap, r#8) && Node.Balanced($Heap, r#8);
    n#59 := r#8;
    assert Node.Valid($Heap, n#59);
    assume Node.Height#canCall($Heap, r#8);
    n#60 := t#6;
    assert t#6 == null || (read(old($Heap), t#6, alloc) && dtype(t#6) == class.Node);
    assert Node.Valid(old($Heap), n#60);
    assume Node.Height#canCall(old($Heap), t#6);
    if (Node.Height($Heap, r#8) - old(Node.Height($Heap, t#6)) == deltaH#9)
    {
        if (deltaH#9 != 0)
        {
        }
    }

    assume Node.Height($Heap, r#8) - old(Node.Height($Heap, t#6)) == deltaH#9 && (deltaH#9 == 0 || deltaH#9 == 1);
    if (t#6 != null)
    {
    }

    if (t#6 != null && deltaH#9 == 1)
    {
        assert r#8 != null;
    }

    assume t#6 != null && deltaH#9 == 1 ==> read($Heap, r#8, Node.balance) != 0;
}



procedure AVLTree.InsertRecursion(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.AVLTree, t#6: ref where t#6 == null || (read($Heap, t#6, alloc) && dtype(t#6) == class.Node), key#7: int) returns (r#8: ref where r#8 == null || (read($Heap, r#8, alloc) && dtype(r#8) == class.Node), deltaH#9: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires Node.Valid#canCall($Heap, t#6) && Node.Valid($Heap, t#6) && (t#6 != null ==> read($Heap, t#6, Node.Repr)[$Box(t#6)] && !read($Heap, t#6, Node.Repr)[$Box(null)] && (read($Heap, t#6, Node.left) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.left))] && !read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(t#6)] && Set#Subset(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, t#6, Node.Repr))) && (read($Heap, t#6, Node.right) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.right))] && !read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(t#6)] && Set#Subset(read($Heap, read($Heap, t#6, Node.right), Node.Repr), read($Heap, t#6, Node.Repr))) && Node.Valid($Heap, read($Heap, t#6, Node.left)) && Node.Valid($Heap, read($Heap, t#6, Node.right)) && (read($Heap, t#6, Node.right) != null && read($Heap, t#6, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, read($Heap, t#6, Node.right), Node.Repr))) && Set#Equal(read($Heap, t#6, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#6)), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, t#6, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#6, Node.value))), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, t#6, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, t#6, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, t#6, Node.value))) && (read($Heap, t#6, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, t#6, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, t#6, Node.value) < i#17)));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.Repr)[$Box(t#6)]);
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> !read($Heap, t#6, Node.Repr)[$Box(null)]);
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.left))]);
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> !read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(t#6)]);
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, t#6, Node.Repr)));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.right))]);
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> !read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(t#6)]);
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, t#6, Node.right), Node.Repr), read($Heap, t#6, Node.Repr)));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Node.Valid($Heap, read($Heap, t#6, Node.left)));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Node.Valid($Heap, read($Heap, t#6, Node.right)));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null && read($Heap, t#6, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, read($Heap, t#6, Node.right), Node.Repr)));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Set#Equal(read($Heap, t#6, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#6)), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Set#Equal(read($Heap, t#6, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#6, Node.value))), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, t#6, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, t#6, Node.value)));
  requires Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, t#6, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, t#6, Node.value) < i#17));
  free requires Node.BalanceValid#canCall($Heap, t#6) && Node.BalanceValid($Heap, t#6) && (t#6 != null ==> read($Heap, t#6, Node.balance) == Node.Height($Heap, read($Heap, t#6, Node.right)) - Node.Height($Heap, read($Heap, t#6, Node.left)) && (read($Heap, t#6, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.left))) && (read($Heap, t#6, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.right))));
  requires Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.balance) == Node.Height($Heap, read($Heap, t#6, Node.right)) - Node.Height($Heap, read($Heap, t#6, Node.left)));
  requires Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.left)));
  requires Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.right)));
  free requires Node.Balanced#canCall($Heap, t#6) && Node.Balanced($Heap, t#6) && (t#6 != null ==> (read($Heap, t#6, Node.balance) == 0 - 1 || read($Heap, t#6, Node.balance) == 0 || read($Heap, t#6, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, t#6, Node.right)) && Node.Balanced($Heap, read($Heap, t#6, Node.left)));
  requires Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.balance) == 0 - 1 || read($Heap, t#6, Node.balance) == 0 || read($Heap, t#6, Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> Node.Balanced($Heap, read($Heap, t#6, Node.right)));
  requires Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> Node.Balanced($Heap, read($Heap, t#6, Node.left)));
  modifies $Heap, $Tick;
  ensures r#8 != null;
  ensures (t#6 != null && old(read($Heap, t#6, Node.Repr))[$Box(r#8)]) || r#8 == null || !read(old($Heap), r#8, alloc);
  ensures t#6 != null ==> (forall $o: ref :: $o != null && read($Heap, r#8, Node.Repr)[$Box($o)] && !old(read($Heap, t#6, Node.Repr))[$Box($o)] ==> !read(old($Heap), $o, alloc));
  ensures t#6 != null ==> Set#Equal(read($Heap, r#8, Node.Contents), Set#Union(old(read($Heap, t#6, Node.Contents)), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#7))));
  ensures t#6 == null ==> (forall $o: ref :: $o != null && read($Heap, r#8, Node.Repr)[$Box($o)] ==> !read(old($Heap), $o, alloc));
  ensures t#6 == null ==> Set#Equal(read($Heap, r#8, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#7)));
  free ensures Node.Valid#canCall($Heap, r#8) && Node.Valid($Heap, r#8) && (r#8 != null ==> read($Heap, r#8, Node.Repr)[$Box(r#8)] && !read($Heap, r#8, Node.Repr)[$Box(null)] && (read($Heap, r#8, Node.left) != null ==> read($Heap, r#8, Node.Repr)[$Box(read($Heap, r#8, Node.left))] && !read($Heap, read($Heap, r#8, Node.left), Node.Repr)[$Box(r#8)] && Set#Subset(read($Heap, read($Heap, r#8, Node.left), Node.Repr), read($Heap, r#8, Node.Repr))) && (read($Heap, r#8, Node.right) != null ==> read($Heap, r#8, Node.Repr)[$Box(read($Heap, r#8, Node.right))] && !read($Heap, read($Heap, r#8, Node.right), Node.Repr)[$Box(r#8)] && Set#Subset(read($Heap, read($Heap, r#8, Node.right), Node.Repr), read($Heap, r#8, Node.Repr))) && Node.Valid($Heap, read($Heap, r#8, Node.left)) && Node.Valid($Heap, read($Heap, r#8, Node.right)) && (read($Heap, r#8, Node.right) != null && read($Heap, r#8, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#8, Node.left), Node.Repr), read($Heap, read($Heap, r#8, Node.right), Node.Repr))) && Set#Equal(read($Heap, r#8, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#8)), (if read($Heap, r#8, Node.left) != null then read($Heap, read($Heap, r#8, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#8, Node.right) != null then read($Heap, read($Heap, r#8, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, r#8, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#8, Node.value))), (if read($Heap, r#8, Node.left) != null then read($Heap, read($Heap, r#8, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#8, Node.right) != null then read($Heap, read($Heap, r#8, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, r#8, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#8, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#8, Node.value))) && (read($Heap, r#8, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#8, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#8, Node.value) < i#17)));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.Repr)[$Box(r#8)]);
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> !read($Heap, r#8, Node.Repr)[$Box(null)]);
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.left) != null ==> read($Heap, r#8, Node.Repr)[$Box(read($Heap, r#8, Node.left))]);
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.left) != null ==> !read($Heap, read($Heap, r#8, Node.left), Node.Repr)[$Box(r#8)]);
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, r#8, Node.left), Node.Repr), read($Heap, r#8, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.right) != null ==> read($Heap, r#8, Node.Repr)[$Box(read($Heap, r#8, Node.right))]);
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.right) != null ==> !read($Heap, read($Heap, r#8, Node.right), Node.Repr)[$Box(r#8)]);
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, r#8, Node.right), Node.Repr), read($Heap, r#8, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> Node.Valid($Heap, read($Heap, r#8, Node.left)));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> Node.Valid($Heap, read($Heap, r#8, Node.right)));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.right) != null && read($Heap, r#8, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#8, Node.left), Node.Repr), read($Heap, read($Heap, r#8, Node.right), Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> Set#Equal(read($Heap, r#8, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#8)), (if read($Heap, r#8, Node.left) != null then read($Heap, read($Heap, r#8, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#8, Node.right) != null then read($Heap, read($Heap, r#8, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> Set#Equal(read($Heap, r#8, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#8, Node.value))), (if read($Heap, r#8, Node.left) != null then read($Heap, read($Heap, r#8, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#8, Node.right) != null then read($Heap, read($Heap, r#8, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#8, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#8, Node.value)));
  ensures Node.Valid#canCall($Heap, r#8) ==> Node.Valid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#8, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#8, Node.value) < i#17));
  free ensures Node.BalanceValid#canCall($Heap, r#8) && Node.BalanceValid($Heap, r#8) && (r#8 != null ==> read($Heap, r#8, Node.balance) == Node.Height($Heap, read($Heap, r#8, Node.right)) - Node.Height($Heap, read($Heap, r#8, Node.left)) && (read($Heap, r#8, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#8, Node.left))) && (read($Heap, r#8, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#8, Node.right))));
  ensures Node.BalanceValid#canCall($Heap, r#8) ==> Node.BalanceValid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.balance) == Node.Height($Heap, read($Heap, r#8, Node.right)) - Node.Height($Heap, read($Heap, r#8, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#8) ==> Node.BalanceValid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#8, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#8) ==> Node.BalanceValid($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#8, Node.right)));
  free ensures Node.Balanced#canCall($Heap, r#8) && Node.Balanced($Heap, r#8) && (r#8 != null ==> (read($Heap, r#8, Node.balance) == 0 - 1 || read($Heap, r#8, Node.balance) == 0 || read($Heap, r#8, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, r#8, Node.right)) && Node.Balanced($Heap, read($Heap, r#8, Node.left)));
  ensures Node.Balanced#canCall($Heap, r#8) ==> Node.Balanced($Heap, r#8) || (r#8 != null ==> read($Heap, r#8, Node.balance) == 0 - 1 || read($Heap, r#8, Node.balance) == 0 || read($Heap, r#8, Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, r#8) ==> Node.Balanced($Heap, r#8) || (r#8 != null ==> Node.Balanced($Heap, read($Heap, r#8, Node.right)));
  ensures Node.Balanced#canCall($Heap, r#8) ==> Node.Balanced($Heap, r#8) || (r#8 != null ==> Node.Balanced($Heap, read($Heap, r#8, Node.left)));
  ensures Node.Height#2($Heap, r#8) - old(Node.Height#2($Heap, t#6)) == deltaH#9;
  ensures deltaH#9 == 0 || deltaH#9 == 1;
  ensures t#6 != null && deltaH#9 == 1 ==> read($Heap, r#8, Node.balance) != 0;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || (t#6 != null && read(old($Heap), t#6, Node.Repr)[$Box($o)]));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation AVLTree.InsertRecursion(this: ref, t#6: ref, key#7: int) returns (r#8: ref, deltaH#9: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $nw: ref;
  var v#61: int;
  var d#10: int;
  var n#62: ref;
  var $obj0: ref;
  var $rhs#0: ref where $rhs#0 == null || (read($Heap, $rhs#0, alloc) && dtype($rhs#0) == class.Node);
  var $rhs#1: int;
  var t#63: ref;
  var key#64: int;
  var $rhs#2: Set BoxType;
  var $rhs#3: Set BoxType;
  var n#65: ref;
  var n#66: ref;
  var n#67: ref;
  var $rhs#4: ref;
  var $rhs#5: int;
  var $rhs#6: int;
  var n#68: ref;
  var n#69: ref;
  var $rhs#7: ref where $rhs#7 == null || (read($Heap, $rhs#7, alloc) && dtype($rhs#7) == class.Node);
  var n#70: ref;
  var $rhs#8: ref where $rhs#8 == null || (read($Heap, $rhs#8, alloc) && dtype($rhs#8) == class.Node);
  var n#71: ref;
  var n#72: ref;
  var n#73: ref;
  var $rhs#9: ref where $rhs#9 == null || (read($Heap, $rhs#9, alloc) && dtype($rhs#9) == class.Node);
  var $rhs#10: int;
  var t#74: ref;
  var key#75: int;
  var $rhs#11: Set BoxType;
  var $rhs#12: Set BoxType;
  var n#76: ref;
  var $rhs#13: int;
  var n#77: ref;
  var n#78: ref;
  var $rhs#14: ref where $rhs#14 == null || (read($Heap, $rhs#14, alloc) && dtype($rhs#14) == class.Node);
  var n#79: ref;
  var $rhs#15: ref where $rhs#15 == null || (read($Heap, $rhs#15, alloc) && dtype($rhs#15) == class.Node);
  var n#80: ref;
  var n#81: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> t#6 != null && read($Heap, t#6, Node.Repr)[$Box($o)]);
    // ----- if statement ----- AVLTree.dfy(81,7)
    assume true;
    if (t#6 == null)
    {
        // ----- assignment statement ----- AVLTree.dfy(83,12)
        assume true;
        havoc $nw;
        assume $nw != null && !read($Heap, $nw, alloc) && dtype($nw) == class.Node;
        $Heap := update($Heap, $nw, alloc, true);
        assume $IsGoodHeap($Heap);
        // ----- init call statement ----- AVLTree.dfy(83,24)
        assume true;
        v#61 := key#7;
        assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == $nw ==> $_Frame[$o, $f]);
        call Node.Init($nw, v#61);
        assume {:captureState "AVLTree.dfy(83,24)"} true;
        r#8 := $nw;
        assume {:captureState "AVLTree.dfy(83,12)"} true;
        // ----- assignment statement ----- AVLTree.dfy(84,17)
        assume true;
        assume true;
        deltaH#9 := 1;
        assume {:captureState "AVLTree.dfy(84,17)"} true;
        // ----- return statement ----- AVLTree.dfy(85,10)
        return;
    }
    else
    {
        // ----- assignment statement ----- AVLTree.dfy(89,12)
        assume true;
        assume true;
        r#8 := t#6;
        assume {:captureState "AVLTree.dfy(89,12)"} true;
        // ----- var-declaration statement ----- AVLTree.dfy(90,14)
        // ----- if statement ----- AVLTree.dfy(91,10)
        assert t#6 != null;
        assume true;
        if (key#7 < read($Heap, t#6, Node.value))
        {
            // ----- assert statement ----- AVLTree.dfy(93,13)
            assert {:subsumption 0} t#6 != null;
            n#62 := read($Heap, t#6, Node.left);
            assume Node.Valid#canCall($Heap, read($Heap, t#6, Node.left));
            assume Node.Valid#canCall($Heap, read($Heap, t#6, Node.left));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(read($Heap, t#6, Node.left))]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> !read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(null)]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(read($Heap, read($Heap, t#6, Node.left), Node.left))]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.left) != null ==> !read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left), Node.Repr)[$Box(read($Heap, t#6, Node.left))]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.left) != null ==> Set#Subset(read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left), Node.Repr), read($Heap, read($Heap, t#6, Node.left), Node.Repr)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.right) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(read($Heap, read($Heap, t#6, Node.left), Node.right))]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.right) != null ==> !read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right), Node.Repr)[$Box(read($Heap, t#6, Node.left))]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.right) != null ==> Set#Subset(read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right), Node.Repr), read($Heap, read($Heap, t#6, Node.left), Node.Repr)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> Node.Valid($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> Node.Valid($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.right) != null && read($Heap, read($Heap, t#6, Node.left), Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left), Node.Repr), read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right), Node.Repr)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> Set#Equal(read($Heap, read($Heap, t#6, Node.left), Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#6, Node.left))), (if read($Heap, read($Heap, t#6, Node.left), Node.left) != null then read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, read($Heap, t#6, Node.left), Node.right) != null then read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> Set#Equal(read($Heap, read($Heap, t#6, Node.left), Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, read($Heap, t#6, Node.left), Node.value))), (if read($Heap, read($Heap, t#6, Node.left), Node.left) != null then read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, read($Heap, t#6, Node.left), Node.right) != null then read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, read($Heap, t#6, Node.left), Node.value)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Valid($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, read($Heap, t#6, Node.left), Node.value) < i#17));
            assume Node.Valid($Heap, read($Heap, t#6, Node.left));
            // ----- call statement ----- AVLTree.dfy(94,26)
            assert t#6 != null;
            assume true;
            $obj0 := t#6;
            assert $_Frame[$obj0, Node.left];
            assume true;
            assert t#6 != null;
            assume true;
            t#63 := read($Heap, t#6, Node.left);
            assume true;
            key#64 := key#7;
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && t#63 != null && read($Heap, t#63, Node.Repr)[$Box($o)] ==> $_Frame[$o, $f]);
            assert Set#Subset((if t#63 != null then read($Heap, t#63, Node.Repr) else Set#Empty(): Set BoxType), (if t#6 != null then read($Heap, t#6, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if t#6 != null then read($Heap, t#6, Node.Repr) else Set#Empty(): Set BoxType), (if t#63 != null then read($Heap, t#63, Node.Repr) else Set#Empty(): Set BoxType));
            call $rhs#0, $rhs#1 := AVLTree.InsertRecursion(this, t#63, key#64);
            $Heap := update($Heap, $obj0, Node.left, $rhs#0);
            assume $IsGoodHeap($Heap);
            d#10 := $rhs#1;
            assume {:captureState "AVLTree.dfy(94,26)"} true;
            // ----- assignment statement ----- AVLTree.dfy(95,20)
            assert t#6 != null;
            assume true;
            assert $_Frame[t#6, Node.Repr];
            assert t#6 != null;
            assert read($Heap, t#6, Node.left) != null;
            assert t#6 != null;
            if (read($Heap, t#6, Node.right) != null)
            {
                assert t#6 != null;
                assert read($Heap, t#6, Node.right) != null;
            }
            else
            {
            }

            assume (read($Heap, t#6, Node.right) != null ==> true) && (read($Heap, t#6, Node.right) == null ==> true);
            $rhs#2 := Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#6)), read($Heap, read($Heap, t#6, Node.left), Node.Repr)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Repr) else Set#Empty(): Set BoxType));
            $Heap := update($Heap, t#6, Node.Repr, $rhs#2);
            assume $IsGoodHeap($Heap);
            assume {:captureState "AVLTree.dfy(95,20)"} true;
            // ----- assignment statement ----- AVLTree.dfy(96,24)
            assert t#6 != null;
            assume true;
            assert $_Frame[t#6, Node.Contents];
            assert t#6 != null;
            assume true;
            $rhs#3 := Set#Union(read($Heap, t#6, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#7)));
            $Heap := update($Heap, t#6, Node.Contents, $rhs#3);
            assume $IsGoodHeap($Heap);
            assume {:captureState "AVLTree.dfy(96,24)"} true;
            // ----- assert statement ----- AVLTree.dfy(97,4)
            n#65 := t#6;
            assume Node.Valid#canCall($Heap, t#6);
            assume Node.Valid#canCall($Heap, t#6);
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.Repr)[$Box(t#6)]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> !read($Heap, t#6, Node.Repr)[$Box(null)]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.left))]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> !read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(t#6)]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, t#6, Node.Repr)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.right))]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> !read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(t#6)]);
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, t#6, Node.right), Node.Repr), read($Heap, t#6, Node.Repr)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Node.Valid($Heap, read($Heap, t#6, Node.left)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Node.Valid($Heap, read($Heap, t#6, Node.right)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null && read($Heap, t#6, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, read($Heap, t#6, Node.right), Node.Repr)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Set#Equal(read($Heap, t#6, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#6)), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Set#Equal(read($Heap, t#6, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#6, Node.value))), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, t#6, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, t#6, Node.value)));
            assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, t#6, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, t#6, Node.value) < i#17));
            assume Node.Valid($Heap, t#6);
            // ----- if statement ----- AVLTree.dfy(98,13)
            assume true;
            if (d#10 == 0)
            {
                // ----- assert statement ----- AVLTree.dfy(100,7)
                assert {:subsumption 0} t#6 != null;
                n#66 := read($Heap, t#6, Node.left);
                assert {:subsumption 0} Node.Valid($Heap, n#66);
                assume Node.Height#canCall($Heap, read($Heap, t#6, Node.left));
                assert {:subsumption 0} t#6 != null;
                n#67 := read(old($Heap), t#6, Node.left);
                assert read(old($Heap), t#6, Node.left) == null || (read(old($Heap), read(old($Heap), t#6, Node.left), alloc) && dtype(read(old($Heap), t#6, Node.left)) == class.Node);
                assert {:subsumption 0} Node.Valid(old($Heap), n#67);
                assume Node.Height#canCall(old($Heap), read(old($Heap), t#6, Node.left));
                assume Node.Height#canCall($Heap, read($Heap, t#6, Node.left)) && old(Node.Height#canCall($Heap, read($Heap, t#6, Node.left)));
                assert {:subsumption 0} Node.Height#2($Heap, read($Heap, t#6, Node.left)) == old(Node.Height#2($Heap, read($Heap, t#6, Node.left)));
                assume Node.Height($Heap, read($Heap, t#6, Node.left)) == old(Node.Height($Heap, read($Heap, t#6, Node.left)));
                // ----- return statement ----- AVLTree.dfy(101,7)
                // ----- update statement ----- AVLTree.dfy(101,7)
                assume true;
                assume true;
                assume true;
                $rhs#4 := r#8;
                assume true;
                $rhs#5 := 0;
                r#8 := $rhs#4;
                deltaH#9 := $rhs#5;
                assume {:captureState "AVLTree.dfy(101,7)"} true;
                return;
            }
            else
            {
            }

            // ----- assignment statement ----- AVLTree.dfy(104,20)
            assume true;
            assert t#6 != null;
            if (read($Heap, t#6, Node.balance) == 0)
            {
            }
            else
            {
            }

            assume (read($Heap, t#6, Node.balance) == 0 ==> true) && (read($Heap, t#6, Node.balance) != 0 ==> true);
            deltaH#9 := (if read($Heap, t#6, Node.balance) == 0 then 1 else 0);
            assume {:captureState "AVLTree.dfy(104,20)"} true;
            // ----- assignment statement ----- AVLTree.dfy(105,23)
            assert t#6 != null;
            assume true;
            assert $_Frame[t#6, Node.balance];
            assert t#6 != null;
            assume true;
            $rhs#6 := read($Heap, t#6, Node.balance) - 1;
            $Heap := update($Heap, t#6, Node.balance, $rhs#6);
            assume $IsGoodHeap($Heap);
            assume {:captureState "AVLTree.dfy(105,23)"} true;
            // ----- assert statement ----- AVLTree.dfy(106,13)
            n#68 := t#6;
            assert {:subsumption 0} Node.Valid($Heap, n#68);
            assume Node.BalanceValid#canCall($Heap, t#6);
            assume Node.BalanceValid#canCall($Heap, t#6);
            assert {:subsumption 0} Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.balance) == Node.Height($Heap, read($Heap, t#6, Node.right)) - Node.Height($Heap, read($Heap, t#6, Node.left)));
            assert {:subsumption 0} Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.left)));
            assert {:subsumption 0} Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.right)));
            assume Node.BalanceValid($Heap, t#6);
            // ----- if statement ----- AVLTree.dfy(107,7)
            assert t#6 != null;
            assume true;
            if (read($Heap, t#6, Node.balance) == 0 - 2)
            {
                // ----- assert statement ----- AVLTree.dfy(109,16)
                assert {:subsumption 0} t#6 != null;
                n#69 := read($Heap, t#6, Node.left);
                assert {:subsumption 0} Node.Valid($Heap, n#69) && Node.BalanceValid($Heap, n#69);
                assume Node.Balanced#canCall($Heap, read($Heap, t#6, Node.left));
                assume Node.Balanced#canCall($Heap, read($Heap, t#6, Node.left));
                assert {:subsumption 0} Node.Balanced#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Balanced($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> read($Heap, read($Heap, t#6, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, t#6, Node.left), Node.balance) == 0 || read($Heap, read($Heap, t#6, Node.left), Node.balance) == 1);
                assert {:subsumption 0} Node.Balanced#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Balanced($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, t#6, Node.left), Node.right)));
                assert {:subsumption 0} Node.Balanced#canCall($Heap, read($Heap, t#6, Node.left)) ==> Node.Balanced($Heap, read($Heap, t#6, Node.left)) || (read($Heap, t#6, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, t#6, Node.left), Node.left)));
                assume Node.Balanced($Heap, read($Heap, t#6, Node.left));
                // ----- if statement ----- AVLTree.dfy(110,16)
                assert t#6 != null;
                assert read($Heap, t#6, Node.left) != null;
                assume true;
                if (read($Heap, read($Heap, t#6, Node.left), Node.balance) == 1)
                {
                    // ----- call statement ----- AVLTree.dfy(112,34)
                    assert t#6 != null;
                    assume true;
                    $obj0 := t#6;
                    assert $_Frame[$obj0, Node.left];
                    assert t#6 != null;
                    assume true;
                    n#70 := read($Heap, t#6, Node.left);
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#70 || (n#70 != null && $o == read($Heap, n#70, Node.right))) ==> $_Frame[$o, $f]);
                    call $rhs#7 := Node.WeakLeftRotation(n#70);
                    $Heap := update($Heap, $obj0, Node.left, $rhs#7);
                    assume $IsGoodHeap($Heap);
                    assume {:captureState "AVLTree.dfy(112,34)"} true;
                }
                else
                {
                }

                // ----- call statement ----- AVLTree.dfy(114,26)
                assume true;
                assume true;
                n#71 := t#6;
                assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#71 || (n#71 != null && $o == read($Heap, n#71, Node.left))) ==> $_Frame[$o, $f]);
                call $rhs#8 := Node.StrongRightRotation(n#71);
                r#8 := $rhs#8;
                assume {:captureState "AVLTree.dfy(114,26)"} true;
                // ----- return statement ----- AVLTree.dfy(115,16)
                return;
            }
            else
            {
                // ----- assert statement ----- AVLTree.dfy(119,16)
                n#72 := t#6;
                assert {:subsumption 0} Node.Valid($Heap, n#72) && Node.BalanceValid($Heap, n#72);
                assume Node.Balanced#canCall($Heap, t#6);
                assume Node.Balanced#canCall($Heap, t#6);
                assert {:subsumption 0} Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.balance) == 0 - 1 || read($Heap, t#6, Node.balance) == 0 || read($Heap, t#6, Node.balance) == 1);
                assert {:subsumption 0} Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> Node.Balanced($Heap, read($Heap, t#6, Node.right)));
                assert {:subsumption 0} Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> Node.Balanced($Heap, read($Heap, t#6, Node.left)));
                assume Node.Balanced($Heap, t#6);
                // ----- return statement ----- AVLTree.dfy(120,16)
                return;
            }
        }
        else
        {
            // ----- if statement ----- AVLTree.dfy(123,15)
            assert t#6 != null;
            assume true;
            if (read($Heap, t#6, Node.value) < key#7)
            {
                // ----- assert statement ----- AVLTree.dfy(125,13)
                assert {:subsumption 0} t#6 != null;
                n#73 := read($Heap, t#6, Node.right);
                assume Node.Valid#canCall($Heap, read($Heap, t#6, Node.right));
                assume Node.Valid#canCall($Heap, read($Heap, t#6, Node.right));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(read($Heap, t#6, Node.right))]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> !read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(null)]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.left) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(read($Heap, read($Heap, t#6, Node.right), Node.left))]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.left) != null ==> !read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left), Node.Repr)[$Box(read($Heap, t#6, Node.right))]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.left) != null ==> Set#Subset(read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left), Node.Repr), read($Heap, read($Heap, t#6, Node.right), Node.Repr)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(read($Heap, read($Heap, t#6, Node.right), Node.right))]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.right) != null ==> !read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right), Node.Repr)[$Box(read($Heap, t#6, Node.right))]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.right) != null ==> Set#Subset(read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right), Node.Repr), read($Heap, read($Heap, t#6, Node.right), Node.Repr)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> Node.Valid($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> Node.Valid($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.right) != null && read($Heap, read($Heap, t#6, Node.right), Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left), Node.Repr), read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right), Node.Repr)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> Set#Equal(read($Heap, read($Heap, t#6, Node.right), Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#6, Node.right))), (if read($Heap, read($Heap, t#6, Node.right), Node.left) != null then read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, read($Heap, t#6, Node.right), Node.right) != null then read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> Set#Equal(read($Heap, read($Heap, t#6, Node.right), Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, read($Heap, t#6, Node.right), Node.value))), (if read($Heap, read($Heap, t#6, Node.right), Node.left) != null then read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, read($Heap, t#6, Node.right), Node.right) != null then read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, read($Heap, t#6, Node.right), Node.value)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Valid($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, read($Heap, t#6, Node.right), Node.value) < i#17));
                assume Node.Valid($Heap, read($Heap, t#6, Node.right));
                // ----- call statement ----- AVLTree.dfy(126,27)
                assert t#6 != null;
                assume true;
                $obj0 := t#6;
                assert $_Frame[$obj0, Node.right];
                assume true;
                assert t#6 != null;
                assume true;
                t#74 := read($Heap, t#6, Node.right);
                assume true;
                key#75 := key#7;
                assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && t#74 != null && read($Heap, t#74, Node.Repr)[$Box($o)] ==> $_Frame[$o, $f]);
                assert Set#Subset((if t#74 != null then read($Heap, t#74, Node.Repr) else Set#Empty(): Set BoxType), (if t#6 != null then read($Heap, t#6, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if t#6 != null then read($Heap, t#6, Node.Repr) else Set#Empty(): Set BoxType), (if t#74 != null then read($Heap, t#74, Node.Repr) else Set#Empty(): Set BoxType));
                call $rhs#9, $rhs#10 := AVLTree.InsertRecursion(this, t#74, key#75);
                $Heap := update($Heap, $obj0, Node.right, $rhs#9);
                assume $IsGoodHeap($Heap);
                d#10 := $rhs#10;
                assume {:captureState "AVLTree.dfy(126,27)"} true;
                // ----- assignment statement ----- AVLTree.dfy(127,20)
                assert t#6 != null;
                assume true;
                assert $_Frame[t#6, Node.Repr];
                assert t#6 != null;
                assert read($Heap, t#6, Node.right) != null;
                assert t#6 != null;
                if (read($Heap, t#6, Node.left) != null)
                {
                    assert t#6 != null;
                    assert read($Heap, t#6, Node.left) != null;
                }
                else
                {
                }

                assume (read($Heap, t#6, Node.left) != null ==> true) && (read($Heap, t#6, Node.left) == null ==> true);
                $rhs#11 := Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#6)), read($Heap, read($Heap, t#6, Node.right), Node.Repr)), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Repr) else Set#Empty(): Set BoxType));
                $Heap := update($Heap, t#6, Node.Repr, $rhs#11);
                assume $IsGoodHeap($Heap);
                assume {:captureState "AVLTree.dfy(127,20)"} true;
                // ----- assignment statement ----- AVLTree.dfy(128,24)
                assert t#6 != null;
                assume true;
                assert $_Frame[t#6, Node.Contents];
                assert t#6 != null;
                assume true;
                $rhs#12 := Set#Union(read($Heap, t#6, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(key#7)));
                $Heap := update($Heap, t#6, Node.Contents, $rhs#12);
                assume $IsGoodHeap($Heap);
                assume {:captureState "AVLTree.dfy(128,24)"} true;
                // ----- assert statement ----- AVLTree.dfy(129,13)
                n#76 := t#6;
                assume Node.Valid#canCall($Heap, t#6);
                assume Node.Valid#canCall($Heap, t#6);
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.Repr)[$Box(t#6)]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> !read($Heap, t#6, Node.Repr)[$Box(null)]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.left))]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> !read($Heap, read($Heap, t#6, Node.left), Node.Repr)[$Box(t#6)]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, t#6, Node.Repr)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> read($Heap, t#6, Node.Repr)[$Box(read($Heap, t#6, Node.right))]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> !read($Heap, read($Heap, t#6, Node.right), Node.Repr)[$Box(t#6)]);
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, t#6, Node.right), Node.Repr), read($Heap, t#6, Node.Repr)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Node.Valid($Heap, read($Heap, t#6, Node.left)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Node.Valid($Heap, read($Heap, t#6, Node.right)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null && read($Heap, t#6, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, t#6, Node.left), Node.Repr), read($Heap, read($Heap, t#6, Node.right), Node.Repr)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Set#Equal(read($Heap, t#6, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(t#6)), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> Set#Equal(read($Heap, t#6, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, t#6, Node.value))), (if read($Heap, t#6, Node.left) != null then read($Heap, read($Heap, t#6, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, t#6, Node.right) != null then read($Heap, read($Heap, t#6, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, t#6, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, t#6, Node.value)));
                assert {:subsumption 0} Node.Valid#canCall($Heap, t#6) ==> Node.Valid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, t#6, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, t#6, Node.value) < i#17));
                assume Node.Valid($Heap, t#6);
                // ----- if statement ----- AVLTree.dfy(130,13)
                assume true;
                if (d#10 == 0)
                {
                    // ----- assignment statement ----- AVLTree.dfy(132,23)
                    assume true;
                    assume true;
                    deltaH#9 := 0;
                    assume {:captureState "AVLTree.dfy(132,23)"} true;
                    // ----- return statement ----- AVLTree.dfy(133,16)
                    return;
                }
                else
                {
                }

                // ----- assignment statement ----- AVLTree.dfy(136,20)
                assume true;
                assert t#6 != null;
                if (read($Heap, t#6, Node.balance) == 0)
                {
                }
                else
                {
                }

                assume (read($Heap, t#6, Node.balance) == 0 ==> true) && (read($Heap, t#6, Node.balance) != 0 ==> true);
                deltaH#9 := (if read($Heap, t#6, Node.balance) == 0 then 1 else 0);
                assume {:captureState "AVLTree.dfy(136,20)"} true;
                // ----- assignment statement ----- AVLTree.dfy(137,23)
                assert t#6 != null;
                assume true;
                assert $_Frame[t#6, Node.balance];
                assert t#6 != null;
                assume true;
                $rhs#13 := read($Heap, t#6, Node.balance) + d#10;
                $Heap := update($Heap, t#6, Node.balance, $rhs#13);
                assume $IsGoodHeap($Heap);
                assume {:captureState "AVLTree.dfy(137,23)"} true;
                // ----- assert statement ----- AVLTree.dfy(138,13)
                n#77 := t#6;
                assert {:subsumption 0} Node.Valid($Heap, n#77);
                assume Node.BalanceValid#canCall($Heap, t#6);
                assume Node.BalanceValid#canCall($Heap, t#6);
                assert {:subsumption 0} Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.balance) == Node.Height($Heap, read($Heap, t#6, Node.right)) - Node.Height($Heap, read($Heap, t#6, Node.left)));
                assert {:subsumption 0} Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.left)));
                assert {:subsumption 0} Node.BalanceValid#canCall($Heap, t#6) ==> Node.BalanceValid($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, t#6, Node.right)));
                assume Node.BalanceValid($Heap, t#6);
                // ----- if statement ----- AVLTree.dfy(140,13)
                assert t#6 != null;
                assume true;
                if (read($Heap, t#6, Node.balance) == 2)
                {
                    // ----- assert statement ----- AVLTree.dfy(142,16)
                    assert {:subsumption 0} t#6 != null;
                    n#78 := read($Heap, t#6, Node.right);
                    assert {:subsumption 0} Node.Valid($Heap, n#78) && Node.BalanceValid($Heap, n#78);
                    assume Node.Balanced#canCall($Heap, read($Heap, t#6, Node.right));
                    assume Node.Balanced#canCall($Heap, read($Heap, t#6, Node.right));
                    assert {:subsumption 0} Node.Balanced#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Balanced($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> read($Heap, read($Heap, t#6, Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, t#6, Node.right), Node.balance) == 0 || read($Heap, read($Heap, t#6, Node.right), Node.balance) == 1);
                    assert {:subsumption 0} Node.Balanced#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Balanced($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, t#6, Node.right), Node.right)));
                    assert {:subsumption 0} Node.Balanced#canCall($Heap, read($Heap, t#6, Node.right)) ==> Node.Balanced($Heap, read($Heap, t#6, Node.right)) || (read($Heap, t#6, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, t#6, Node.right), Node.left)));
                    assume Node.Balanced($Heap, read($Heap, t#6, Node.right));
                    // ----- if statement ----- AVLTree.dfy(143,16)
                    assert t#6 != null;
                    assert read($Heap, t#6, Node.right) != null;
                    assume true;
                    if (read($Heap, read($Heap, t#6, Node.right), Node.balance) == 0 - 1)
                    {
                        // ----- call statement ----- AVLTree.dfy(145,35)
                        assert t#6 != null;
                        assume true;
                        $obj0 := t#6;
                        assert $_Frame[$obj0, Node.right];
                        assert t#6 != null;
                        assume true;
                        n#79 := read($Heap, t#6, Node.right);
                        assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#79 || (n#79 != null && $o == read($Heap, n#79, Node.left))) ==> $_Frame[$o, $f]);
                        call $rhs#14 := Node.WeakRightRotation(n#79);
                        $Heap := update($Heap, $obj0, Node.right, $rhs#14);
                        assume $IsGoodHeap($Heap);
                        assume {:captureState "AVLTree.dfy(145,35)"} true;
                    }
                    else
                    {
                    }

                    // ----- call statement ----- AVLTree.dfy(147,26)
                    assume true;
                    assume true;
                    n#80 := t#6;
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#80 || (n#80 != null && $o == read($Heap, n#80, Node.right))) ==> $_Frame[$o, $f]);
                    call $rhs#15 := Node.StrongLeftRotation(n#80);
                    r#8 := $rhs#15;
                    assume {:captureState "AVLTree.dfy(147,26)"} true;
                    // ----- return statement ----- AVLTree.dfy(148,16)
                    return;
                }
                else
                {
                }

                // ----- assert statement ----- AVLTree.dfy(150,13)
                n#81 := t#6;
                assert {:subsumption 0} Node.Valid($Heap, n#81) && Node.BalanceValid($Heap, n#81);
                assume Node.Balanced#canCall($Heap, t#6);
                assume Node.Balanced#canCall($Heap, t#6);
                assert {:subsumption 0} Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> read($Heap, t#6, Node.balance) == 0 - 1 || read($Heap, t#6, Node.balance) == 0 || read($Heap, t#6, Node.balance) == 1);
                assert {:subsumption 0} Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> Node.Balanced($Heap, read($Heap, t#6, Node.right)));
                assert {:subsumption 0} Node.Balanced#canCall($Heap, t#6) ==> Node.Balanced($Heap, t#6) || (t#6 != null ==> Node.Balanced($Heap, read($Heap, t#6, Node.left)));
                assume Node.Balanced($Heap, t#6);
                // ----- return statement ----- AVLTree.dfy(151,13)
                return;
            }
            else
            {
                // ----- assert statement ----- AVLTree.dfy(155,13)
                assert {:subsumption 0} t#6 != null;
                assume true;
                assert key#7 == read($Heap, t#6, Node.value);
                // ----- assignment statement ----- AVLTree.dfy(156,20)
                assume true;
                assume true;
                deltaH#9 := 0;
                assume {:captureState "AVLTree.dfy(156,20)"} true;
                // ----- return statement ----- AVLTree.dfy(157,13)
                return;
            }
        }
    }
}



const unique class.Node: ClassName;

const unique Node.value: Field int;

const unique Node.balance: Field int;

const unique Node.left: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.left) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, Node.left) == null || (read($h, read($h, $o, Node.left), alloc) && dtype(read($h, $o, Node.left)) == class.Node));

const unique Node.right: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.right) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, Node.right) == null || (read($h, read($h, $o, Node.right), alloc) && dtype(read($h, $o, Node.right)) == class.Node));

const unique Node.Contents: Field (Set BoxType);

const unique Node.Repr: Field (Set BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.Repr) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $t#1: BoxType :: { read($h, $o, Node.Repr)[$t#1] } read($h, $o, Node.Repr)[$t#1] ==> $Unbox($t#1): ref == null || (read($h, $Unbox($t#1): ref, alloc) && dtype($Unbox($t#1): ref) == class.Node)));

procedure CheckWellformed$$Node.Init(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node, v#11: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Node.Init(this: ref, v#11: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#82: ref;
  var n#83: ref;
  var n#84: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this);
    assume $HeapSucc(old($Heap), $Heap);
    n#82 := this;
    assume Node.Valid#canCall($Heap, this);
    if (Node.Valid($Heap, this))
    {
        n#83 := this;
        assert Node.Valid($Heap, n#83);
        assume Node.BalanceValid#canCall($Heap, this);
    }

    if (Node.Valid($Heap, this) && Node.BalanceValid($Heap, this))
    {
        n#84 := this;
        assert Node.Valid($Heap, n#84) && Node.BalanceValid($Heap, n#84);
        assume Node.Balanced#canCall($Heap, this);
    }

    assume Node.Valid($Heap, this) && Node.BalanceValid($Heap, this) && Node.Balanced($Heap, this);
    if (read($Heap, this, Node.left) == null)
    {
    }

    assume read($Heap, this, Node.left) == null && read($Heap, this, Node.right) == null;
    assume Set#Equal(read($Heap, this, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(v#11)));
}



procedure Node.Init(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Node, v#11: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;
  free ensures Node.Valid#canCall($Heap, this) && Node.Valid($Heap, this) && (this != null ==> read($Heap, this, Node.Repr)[$Box(this)] && !read($Heap, this, Node.Repr)[$Box(null)] && (read($Heap, this, Node.left) != null ==> read($Heap, this, Node.Repr)[$Box(read($Heap, this, Node.left))] && !read($Heap, read($Heap, this, Node.left), Node.Repr)[$Box(this)] && Set#Subset(read($Heap, read($Heap, this, Node.left), Node.Repr), read($Heap, this, Node.Repr))) && (read($Heap, this, Node.right) != null ==> read($Heap, this, Node.Repr)[$Box(read($Heap, this, Node.right))] && !read($Heap, read($Heap, this, Node.right), Node.Repr)[$Box(this)] && Set#Subset(read($Heap, read($Heap, this, Node.right), Node.Repr), read($Heap, this, Node.Repr))) && Node.Valid($Heap, read($Heap, this, Node.left)) && Node.Valid($Heap, read($Heap, this, Node.right)) && (read($Heap, this, Node.right) != null && read($Heap, this, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, this, Node.left), Node.Repr), read($Heap, read($Heap, this, Node.right), Node.Repr))) && Set#Equal(read($Heap, this, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(this)), (if read($Heap, this, Node.left) != null then read($Heap, read($Heap, this, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, this, Node.right) != null then read($Heap, read($Heap, this, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, this, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.value))), (if read($Heap, this, Node.left) != null then read($Heap, read($Heap, this, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, this, Node.right) != null then read($Heap, read($Heap, this, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, this, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, this, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, this, Node.value))) && (read($Heap, this, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, this, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, this, Node.value) < i#17)));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.Repr)[$Box(this)]);
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> !read($Heap, this, Node.Repr)[$Box(null)]);
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.left) != null ==> read($Heap, this, Node.Repr)[$Box(read($Heap, this, Node.left))]);
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.left) != null ==> !read($Heap, read($Heap, this, Node.left), Node.Repr)[$Box(this)]);
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, this, Node.left), Node.Repr), read($Heap, this, Node.Repr)));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.right) != null ==> read($Heap, this, Node.Repr)[$Box(read($Heap, this, Node.right))]);
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.right) != null ==> !read($Heap, read($Heap, this, Node.right), Node.Repr)[$Box(this)]);
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, this, Node.right), Node.Repr), read($Heap, this, Node.Repr)));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> Node.Valid($Heap, read($Heap, this, Node.left)));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> Node.Valid($Heap, read($Heap, this, Node.right)));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.right) != null && read($Heap, this, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, this, Node.left), Node.Repr), read($Heap, read($Heap, this, Node.right), Node.Repr)));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> Set#Equal(read($Heap, this, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(this)), (if read($Heap, this, Node.left) != null then read($Heap, read($Heap, this, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, this, Node.right) != null then read($Heap, read($Heap, this, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> Set#Equal(read($Heap, this, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, this, Node.value))), (if read($Heap, this, Node.left) != null then read($Heap, read($Heap, this, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, this, Node.right) != null then read($Heap, read($Heap, this, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, this, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, this, Node.value)));
  ensures Node.Valid#canCall($Heap, this) ==> Node.Valid($Heap, this) || (this != null ==> read($Heap, this, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, this, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, this, Node.value) < i#17));
  free ensures Node.BalanceValid#canCall($Heap, this) && Node.BalanceValid($Heap, this) && (this != null ==> read($Heap, this, Node.balance) == Node.Height($Heap, read($Heap, this, Node.right)) - Node.Height($Heap, read($Heap, this, Node.left)) && (read($Heap, this, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, this, Node.left))) && (read($Heap, this, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, this, Node.right))));
  ensures Node.BalanceValid#canCall($Heap, this) ==> Node.BalanceValid($Heap, this) || (this != null ==> read($Heap, this, Node.balance) == Node.Height($Heap, read($Heap, this, Node.right)) - Node.Height($Heap, read($Heap, this, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, this) ==> Node.BalanceValid($Heap, this) || (this != null ==> read($Heap, this, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, this, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, this) ==> Node.BalanceValid($Heap, this) || (this != null ==> read($Heap, this, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, this, Node.right)));
  free ensures Node.Balanced#canCall($Heap, this) && Node.Balanced($Heap, this) && (this != null ==> (read($Heap, this, Node.balance) == 0 - 1 || read($Heap, this, Node.balance) == 0 || read($Heap, this, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, this, Node.right)) && Node.Balanced($Heap, read($Heap, this, Node.left)));
  ensures Node.Balanced#canCall($Heap, this) ==> Node.Balanced($Heap, this) || (this != null ==> read($Heap, this, Node.balance) == 0 - 1 || read($Heap, this, Node.balance) == 0 || read($Heap, this, Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, this) ==> Node.Balanced($Heap, this) || (this != null ==> Node.Balanced($Heap, read($Heap, this, Node.right)));
  ensures Node.Balanced#canCall($Heap, this) ==> Node.Balanced($Heap, this) || (this != null ==> Node.Balanced($Heap, read($Heap, this, Node.left)));
  ensures read($Heap, this, Node.left) == null;
  ensures read($Heap, this, Node.right) == null;
  ensures Set#Equal(read($Heap, this, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(v#11)));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this);
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Node.Init(this: ref, v#11: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $rhs#0: Set BoxType;
  var $rhs#1: Set BoxType;
  var $rhs#2: ref;
  var $rhs#3: ref;
  var $rhs#4: int;
  var $rhs#5: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
    // ----- assignment statement ----- AVLTree.dfy(178,12)
    assume true;
    assert $_Frame[this, Node.Repr];
    assume true;
    $rhs#0 := Set#UnionOne(Set#Empty(): Set BoxType, $Box(this));
    $Heap := update($Heap, this, Node.Repr, $rhs#0);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(178,12)"} true;
    // ----- assignment statement ----- AVLTree.dfy(179,16)
    assume true;
    assert $_Frame[this, Node.Contents];
    assume true;
    $rhs#1 := Set#UnionOne(Set#Empty(): Set BoxType, $Box(v#11));
    $Heap := update($Heap, this, Node.Contents, $rhs#1);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(179,16)"} true;
    // ----- assignment statement ----- AVLTree.dfy(180,12)
    assume true;
    assert $_Frame[this, Node.left];
    assume true;
    $rhs#2 := null;
    $Heap := update($Heap, this, Node.left, $rhs#2);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(180,12)"} true;
    // ----- assignment statement ----- AVLTree.dfy(181,13)
    assume true;
    assert $_Frame[this, Node.right];
    assume true;
    $rhs#3 := null;
    $Heap := update($Heap, this, Node.right, $rhs#3);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(181,13)"} true;
    // ----- assignment statement ----- AVLTree.dfy(182,13)
    assume true;
    assert $_Frame[this, Node.value];
    assume true;
    $rhs#4 := v#11;
    $Heap := update($Heap, this, Node.value, $rhs#4);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(182,13)"} true;
    // ----- assignment statement ----- AVLTree.dfy(183,15)
    assume true;
    assert $_Frame[this, Node.balance];
    assume true;
    $rhs#5 := 0;
    $Heap := update($Heap, this, Node.balance, $rhs#5);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(183,15)"} true;
}



function Node.Balanced($heap: HeapType, n#12: ref) : bool;

function Node.Balanced#limited($heap: HeapType, n#12: ref) : bool;

function Node.Balanced#2($heap: HeapType, n#12: ref) : bool;

function Node.Balanced#canCall($heap: HeapType, n#12: ref) : bool;

axiom (forall $Heap: HeapType, n#12: ref :: { Node.Balanced#2($Heap, n#12) } Node.Balanced#2($Heap, n#12) == Node.Balanced($Heap, n#12));

axiom (forall $Heap: HeapType, n#12: ref :: { Node.Balanced($Heap, n#12) } Node.Balanced($Heap, n#12) == Node.Balanced#limited($Heap, n#12));

// definition axiom for Node.Balanced
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (6 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#12: ref :: { Node.Balanced($Heap, n#12) } Node.Balanced#canCall($Heap, n#12) || ((0 != $ModuleContextHeight || 6 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#12 == null || (read($Heap, n#12, alloc) && dtype(n#12) == class.Node)) && Node.Valid($Heap, n#12) && Node.BalanceValid($Heap, n#12)) ==> (n#12 != null ==> (read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1 ==> Node.Balanced#canCall($Heap, read($Heap, n#12, Node.right))) && ((read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, n#12, Node.right)) ==> Node.Balanced#canCall($Heap, read($Heap, n#12, Node.left)))) && Node.Balanced($Heap, n#12) == (n#12 != null ==> (read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1) && Node.Balanced#limited($Heap, read($Heap, n#12, Node.right)) && Node.Balanced#limited($Heap, read($Heap, n#12, Node.left))));

// definition axiom for Node.Balanced#2
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (6 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#12: ref :: { Node.Balanced#2($Heap, n#12) } Node.Balanced#canCall($Heap, n#12) || ((0 != $ModuleContextHeight || 6 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#12 == null || (read($Heap, n#12, alloc) && dtype(n#12) == class.Node)) && Node.Valid($Heap, n#12) && Node.BalanceValid($Heap, n#12)) ==> Node.Balanced#2($Heap, n#12) == (n#12 != null ==> (read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, n#12, Node.right)) && Node.Balanced($Heap, read($Heap, n#12, Node.left))));

// frame axiom for Node.Balanced
axiom (forall $h0: HeapType, $h1: HeapType, n#12: ref :: { $HeapSucc($h0, $h1), Node.Balanced($h1, n#12) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#12 == null || (read($h0, n#12, alloc) && dtype(n#12) == class.Node)) && (n#12 == null || (read($h1, n#12, alloc) && dtype(n#12) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == n#12 || (n#12 != null && read($h0, n#12, Node.Repr)[$Box($o)])) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.Balanced($h0, n#12) == Node.Balanced($h1, n#12));

axiom (forall $h0: HeapType, $h1: HeapType, n#12: ref :: { $HeapSucc($h0, $h1), Node.Balanced#limited($h1, n#12) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#12 == null || (read($h0, n#12, alloc) && dtype(n#12) == class.Node)) && (n#12 == null || (read($h1, n#12, alloc) && dtype(n#12) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == n#12 || (n#12 != null && read($h0, n#12, Node.Repr)[$Box($o)])) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.Balanced#limited($h0, n#12) == Node.Balanced#limited($h1, n#12));

procedure CheckWellformed$$Node.Balanced(n#12: ref where n#12 == null || (read($Heap, n#12, alloc) && dtype(n#12) == class.Node));
  free requires 0 == $ModuleContextHeight && 6 == $FunctionContextHeight;



implementation CheckWellformed$$Node.Balanced(n#12: ref)
{
  var n#85: ref;
  var n#86: ref;
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#87: ref;
  var n#88: ref;

    n#85 := n#12;
    assume Node.Valid#canCall($Heap, n#12);
    if (Node.Valid($Heap, n#12))
    {
        n#86 := n#12;
        assert Node.Valid($Heap, n#86);
        assume Node.BalanceValid#canCall($Heap, n#12);
    }

    assume Node.Valid($Heap, n#12) && Node.BalanceValid($Heap, n#12);
    if (n#12 != null)
    {
        assert n#12 != null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#12 || (n#12 != null && read($Heap, n#12, Node.Repr)[$Box($o)]));
        if (n#12 != null)
        {
            assert n#12 != null;
            assert $_Frame[n#12, Node.balance];
            if (read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1)
            {
                assert n#12 != null;
                assert $_Frame[n#12, Node.right];
                n#87 := read($Heap, n#12, Node.right);
                assert Node.Valid($Heap, n#87) && Node.BalanceValid($Heap, n#87);
                assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#87 || (n#87 != null && read($Heap, n#87, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
                assert Set#Subset((if n#87 != null then read($Heap, n#87, Node.Repr) else Set#Empty(): Set BoxType), (if n#12 != null then read($Heap, n#12, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#12 != null then read($Heap, n#12, Node.Repr) else Set#Empty(): Set BoxType), (if n#87 != null then read($Heap, n#87, Node.Repr) else Set#Empty(): Set BoxType));
                assume Node.Balanced#canCall($Heap, read($Heap, n#12, Node.right));
            }

            if ((read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, n#12, Node.right)))
            {
                assert n#12 != null;
                assert $_Frame[n#12, Node.left];
                n#88 := read($Heap, n#12, Node.left);
                assert Node.Valid($Heap, n#88) && Node.BalanceValid($Heap, n#88);
                assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#88 || (n#88 != null && read($Heap, n#88, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
                assert Set#Subset((if n#88 != null then read($Heap, n#88, Node.Repr) else Set#Empty(): Set BoxType), (if n#12 != null then read($Heap, n#12, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#12 != null then read($Heap, n#12, Node.Repr) else Set#Empty(): Set BoxType), (if n#88 != null then read($Heap, n#88, Node.Repr) else Set#Empty(): Set BoxType));
                assume Node.Balanced#canCall($Heap, read($Heap, n#12, Node.left));
            }
        }

        assume Node.Balanced($Heap, n#12) == (n#12 != null ==> (read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, n#12, Node.right)) && Node.Balanced($Heap, read($Heap, n#12, Node.left)));
        assume n#12 != null ==> (read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1 ==> Node.Balanced#canCall($Heap, read($Heap, n#12, Node.right))) && ((read($Heap, n#12, Node.balance) == 0 - 1 || read($Heap, n#12, Node.balance) == 0 || read($Heap, n#12, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, n#12, Node.right)) ==> Node.Balanced#canCall($Heap, read($Heap, n#12, Node.left)));
    }
}



function Node.BalanceValid($heap: HeapType, n#13: ref) : bool;

function Node.BalanceValid#limited($heap: HeapType, n#13: ref) : bool;

function Node.BalanceValid#2($heap: HeapType, n#13: ref) : bool;

function Node.BalanceValid#canCall($heap: HeapType, n#13: ref) : bool;

axiom (forall $Heap: HeapType, n#13: ref :: { Node.BalanceValid#2($Heap, n#13) } Node.BalanceValid#2($Heap, n#13) == Node.BalanceValid($Heap, n#13));

axiom (forall $Heap: HeapType, n#13: ref :: { Node.BalanceValid($Heap, n#13) } Node.BalanceValid($Heap, n#13) == Node.BalanceValid#limited($Heap, n#13));

// definition axiom for Node.BalanceValid
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (5 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#13: ref :: { Node.BalanceValid($Heap, n#13) } Node.BalanceValid#canCall($Heap, n#13) || ((0 != $ModuleContextHeight || 5 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#13 == null || (read($Heap, n#13, alloc) && dtype(n#13) == class.Node)) && Node.Valid($Heap, n#13)) ==> (n#13 != null ==> Node.Height#canCall($Heap, read($Heap, n#13, Node.right)) && Node.Height#canCall($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) ==> read($Heap, n#13, Node.left) != null ==> Node.BalanceValid#canCall($Heap, read($Heap, n#13, Node.left))) && (read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#13, Node.left))) ==> read($Heap, n#13, Node.right) != null ==> Node.BalanceValid#canCall($Heap, read($Heap, n#13, Node.right)))) && Node.BalanceValid($Heap, n#13) == (n#13 != null ==> read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.left) != null ==> Node.BalanceValid#limited($Heap, read($Heap, n#13, Node.left))) && (read($Heap, n#13, Node.right) != null ==> Node.BalanceValid#limited($Heap, read($Heap, n#13, Node.right)))));

// definition axiom for Node.BalanceValid#2
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (5 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#13: ref :: { Node.BalanceValid#2($Heap, n#13) } Node.BalanceValid#canCall($Heap, n#13) || ((0 != $ModuleContextHeight || 5 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#13 == null || (read($Heap, n#13, alloc) && dtype(n#13) == class.Node)) && Node.Valid($Heap, n#13)) ==> Node.BalanceValid#2($Heap, n#13) == (n#13 != null ==> read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#13, Node.left))) && (read($Heap, n#13, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#13, Node.right)))));

// frame axiom for Node.BalanceValid
axiom (forall $h0: HeapType, $h1: HeapType, n#13: ref :: { $HeapSucc($h0, $h1), Node.BalanceValid($h1, n#13) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#13 == null || (read($h0, n#13, alloc) && dtype(n#13) == class.Node)) && (n#13 == null || (read($h1, n#13, alloc) && dtype(n#13) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == n#13 || (n#13 != null && read($h0, n#13, Node.Repr)[$Box($o)])) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.BalanceValid($h0, n#13) == Node.BalanceValid($h1, n#13));

axiom (forall $h0: HeapType, $h1: HeapType, n#13: ref :: { $HeapSucc($h0, $h1), Node.BalanceValid#limited($h1, n#13) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#13 == null || (read($h0, n#13, alloc) && dtype(n#13) == class.Node)) && (n#13 == null || (read($h1, n#13, alloc) && dtype(n#13) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == n#13 || (n#13 != null && read($h0, n#13, Node.Repr)[$Box($o)])) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.BalanceValid#limited($h0, n#13) == Node.BalanceValid#limited($h1, n#13));

procedure CheckWellformed$$Node.BalanceValid(n#13: ref where n#13 == null || (read($Heap, n#13, alloc) && dtype(n#13) == class.Node));
  free requires 0 == $ModuleContextHeight && 5 == $FunctionContextHeight;



implementation CheckWellformed$$Node.BalanceValid(n#13: ref)
{
  var n#89: ref;
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#90: ref;
  var n#91: ref;
  var n#92: ref;
  var n#93: ref;

    n#89 := n#13;
    assume Node.Valid#canCall($Heap, n#13);
    assume Node.Valid($Heap, n#13);
    if (n#13 != null)
    {
        assert n#13 != null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#13 || (n#13 != null && read($Heap, n#13, Node.Repr)[$Box($o)]));
        if (n#13 != null)
        {
            assert n#13 != null;
            assert $_Frame[n#13, Node.balance];
            assert n#13 != null;
            assert $_Frame[n#13, Node.right];
            n#90 := read($Heap, n#13, Node.right);
            assert Node.Valid($Heap, n#90);
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && n#90 != null && read($Heap, n#90, Node.Repr)[$Box($o)] ==> $_Frame[$o, $f]);
            assume Node.Height#canCall($Heap, read($Heap, n#13, Node.right));
            assert n#13 != null;
            assert $_Frame[n#13, Node.left];
            n#91 := read($Heap, n#13, Node.left);
            assert Node.Valid($Heap, n#91);
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && n#91 != null && read($Heap, n#91, Node.Repr)[$Box($o)] ==> $_Frame[$o, $f]);
            assume Node.Height#canCall($Heap, read($Heap, n#13, Node.left));
            if (read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)))
            {
                assert n#13 != null;
                assert $_Frame[n#13, Node.left];
                if (read($Heap, n#13, Node.left) != null)
                {
                    assert n#13 != null;
                    assert $_Frame[n#13, Node.left];
                    n#92 := read($Heap, n#13, Node.left);
                    assert Node.Valid($Heap, n#92);
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#92 || (n#92 != null && read($Heap, n#92, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
                    assert Set#Subset((if n#92 != null then read($Heap, n#92, Node.Repr) else Set#Empty(): Set BoxType), (if n#13 != null then read($Heap, n#13, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#13 != null then read($Heap, n#13, Node.Repr) else Set#Empty(): Set BoxType), (if n#92 != null then read($Heap, n#92, Node.Repr) else Set#Empty(): Set BoxType));
                    assume Node.BalanceValid#canCall($Heap, read($Heap, n#13, Node.left));
                }
            }

            if (read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#13, Node.left))))
            {
                assert n#13 != null;
                assert $_Frame[n#13, Node.right];
                if (read($Heap, n#13, Node.right) != null)
                {
                    assert n#13 != null;
                    assert $_Frame[n#13, Node.right];
                    n#93 := read($Heap, n#13, Node.right);
                    assert Node.Valid($Heap, n#93);
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#93 || (n#93 != null && read($Heap, n#93, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
                    assert Set#Subset((if n#93 != null then read($Heap, n#93, Node.Repr) else Set#Empty(): Set BoxType), (if n#13 != null then read($Heap, n#13, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#13 != null then read($Heap, n#13, Node.Repr) else Set#Empty(): Set BoxType), (if n#93 != null then read($Heap, n#93, Node.Repr) else Set#Empty(): Set BoxType));
                    assume Node.BalanceValid#canCall($Heap, read($Heap, n#13, Node.right));
                }
            }
        }

        assume Node.BalanceValid($Heap, n#13) == (n#13 != null ==> read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#13, Node.left))) && (read($Heap, n#13, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#13, Node.right))));
        assume n#13 != null ==> Node.Height#canCall($Heap, read($Heap, n#13, Node.right)) && Node.Height#canCall($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) ==> read($Heap, n#13, Node.left) != null ==> Node.BalanceValid#canCall($Heap, read($Heap, n#13, Node.left))) && (read($Heap, n#13, Node.balance) == Node.Height($Heap, read($Heap, n#13, Node.right)) - Node.Height($Heap, read($Heap, n#13, Node.left)) && (read($Heap, n#13, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#13, Node.left))) ==> read($Heap, n#13, Node.right) != null ==> Node.BalanceValid#canCall($Heap, read($Heap, n#13, Node.right)));
    }
}



function Node.Height($heap: HeapType, n#14: ref) : int;

function Node.Height#limited($heap: HeapType, n#14: ref) : int;

function Node.Height#2($heap: HeapType, n#14: ref) : int;

function Node.Height#canCall($heap: HeapType, n#14: ref) : bool;

axiom (forall $Heap: HeapType, n#14: ref :: { Node.Height#2($Heap, n#14) } Node.Height#2($Heap, n#14) == Node.Height($Heap, n#14));

axiom (forall $Heap: HeapType, n#14: ref :: { Node.Height($Heap, n#14) } Node.Height($Heap, n#14) == Node.Height#limited($Heap, n#14));

// definition axiom for Node.Height
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (4 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#14: ref :: { Node.Height($Heap, n#14) } Node.Height#canCall($Heap, n#14) || ((0 != $ModuleContextHeight || 4 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#14 == null || (read($Heap, n#14, alloc) && dtype(n#14) == class.Node)) && Node.Valid($Heap, n#14)) ==> (n#14 == null ==> true) && (n#14 != null ==> Node.Height#canCall($Heap, read($Heap, n#14, Node.left)) && Node.Height#canCall($Heap, read($Heap, n#14, Node.right)) && Math.max#canCall($Heap, Node.Height($Heap, read($Heap, n#14, Node.left)), Node.Height($Heap, read($Heap, n#14, Node.right)))) && Node.Height($Heap, n#14) == (if n#14 == null then 0 else Math.max($Heap, Node.Height#limited($Heap, read($Heap, n#14, Node.left)), Node.Height#limited($Heap, read($Heap, n#14, Node.right))) + 1) && 0 <= Node.Height($Heap, n#14));

// definition axiom for Node.Height#2
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (4 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#14: ref :: { Node.Height#2($Heap, n#14) } Node.Height#canCall($Heap, n#14) || ((0 != $ModuleContextHeight || 4 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#14 == null || (read($Heap, n#14, alloc) && dtype(n#14) == class.Node)) && Node.Valid($Heap, n#14)) ==> Node.Height#2($Heap, n#14) == (if n#14 == null then 0 else Math.max($Heap, Node.Height($Heap, read($Heap, n#14, Node.left)), Node.Height($Heap, read($Heap, n#14, Node.right))) + 1));

// frame axiom for Node.Height
axiom (forall $h0: HeapType, $h1: HeapType, n#14: ref :: { $HeapSucc($h0, $h1), Node.Height($h1, n#14) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#14 == null || (read($h0, n#14, alloc) && dtype(n#14) == class.Node)) && (n#14 == null || (read($h1, n#14, alloc) && dtype(n#14) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && n#14 != null && read($h0, n#14, Node.Repr)[$Box($o)] ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.Height($h0, n#14) == Node.Height($h1, n#14));

axiom (forall $h0: HeapType, $h1: HeapType, n#14: ref :: { $HeapSucc($h0, $h1), Node.Height#limited($h1, n#14) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#14 == null || (read($h0, n#14, alloc) && dtype(n#14) == class.Node)) && (n#14 == null || (read($h1, n#14, alloc) && dtype(n#14) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && n#14 != null && read($h0, n#14, Node.Repr)[$Box($o)] ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.Height#limited($h0, n#14) == Node.Height#limited($h1, n#14));

procedure CheckWellformed$$Node.Height(n#14: ref where n#14 == null || (read($Heap, n#14, alloc) && dtype(n#14) == class.Node));
  free requires 0 == $ModuleContextHeight && 4 == $FunctionContextHeight;



implementation CheckWellformed$$Node.Height(n#14: ref)
{
  var n#94: ref;
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#95: ref;
  var n#96: ref;
  var a#97: int;
  var b#98: int;

    n#94 := n#14;
    assume Node.Valid#canCall($Heap, n#14);
    assume Node.Valid($Heap, n#14);
    if (n#14 != null)
    {
        assert n#14 != null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> n#14 != null && read($Heap, n#14, Node.Repr)[$Box($o)]);
        if (n#14 == null)
        {
        }
        else
        {
            assert n#14 != null;
            assert $_Frame[n#14, Node.left];
            n#95 := read($Heap, n#14, Node.left);
            assert Node.Valid($Heap, n#95);
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && n#95 != null && read($Heap, n#95, Node.Repr)[$Box($o)] ==> $_Frame[$o, $f]);
            assert Set#Subset((if n#95 != null then read($Heap, n#95, Node.Repr) else Set#Empty(): Set BoxType), (if n#14 != null then read($Heap, n#14, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#14 != null then read($Heap, n#14, Node.Repr) else Set#Empty(): Set BoxType), (if n#95 != null then read($Heap, n#95, Node.Repr) else Set#Empty(): Set BoxType));
            assume Node.Height#canCall($Heap, read($Heap, n#14, Node.left));
            assert n#14 != null;
            assert $_Frame[n#14, Node.right];
            n#96 := read($Heap, n#14, Node.right);
            assert Node.Valid($Heap, n#96);
            assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && n#96 != null && read($Heap, n#96, Node.Repr)[$Box($o)] ==> $_Frame[$o, $f]);
            assert Set#Subset((if n#96 != null then read($Heap, n#96, Node.Repr) else Set#Empty(): Set BoxType), (if n#14 != null then read($Heap, n#14, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#14 != null then read($Heap, n#14, Node.Repr) else Set#Empty(): Set BoxType), (if n#96 != null then read($Heap, n#96, Node.Repr) else Set#Empty(): Set BoxType));
            assume Node.Height#canCall($Heap, read($Heap, n#14, Node.right));
            assert 0 <= Node.Height($Heap, read($Heap, n#14, Node.left));
            a#97 := Node.Height($Heap, read($Heap, n#14, Node.left));
            assert 0 <= Node.Height($Heap, read($Heap, n#14, Node.right));
            b#98 := Node.Height($Heap, read($Heap, n#14, Node.right));
            assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
            assume Math.max#canCall($Heap, Node.Height($Heap, read($Heap, n#14, Node.left)), Node.Height($Heap, read($Heap, n#14, Node.right)));
        }

        assert 0 <= (if n#14 == null then 0 else Math.max($Heap, Node.Height($Heap, read($Heap, n#14, Node.left)), Node.Height($Heap, read($Heap, n#14, Node.right))) + 1);
        assume Node.Height($Heap, n#14) == (if n#14 == null then 0 else Math.max($Heap, Node.Height($Heap, read($Heap, n#14, Node.left)), Node.Height($Heap, read($Heap, n#14, Node.right))) + 1);
        assume (n#14 == null ==> true) && (n#14 != null ==> Node.Height#canCall($Heap, read($Heap, n#14, Node.left)) && Node.Height#canCall($Heap, read($Heap, n#14, Node.right)) && Math.max#canCall($Heap, Node.Height($Heap, read($Heap, n#14, Node.left)), Node.Height($Heap, read($Heap, n#14, Node.right))));
    }
}



function Node.Valid($heap: HeapType, n#15: ref) : bool;

function Node.Valid#limited($heap: HeapType, n#15: ref) : bool;

function Node.Valid#2($heap: HeapType, n#15: ref) : bool;

function Node.Valid#canCall($heap: HeapType, n#15: ref) : bool;

axiom (forall $Heap: HeapType, n#15: ref :: { Node.Valid#2($Heap, n#15) } Node.Valid#2($Heap, n#15) == Node.Valid($Heap, n#15));

axiom (forall $Heap: HeapType, n#15: ref :: { Node.Valid($Heap, n#15) } Node.Valid($Heap, n#15) == Node.Valid#limited($Heap, n#15));

// definition axiom for Node.Valid
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (2 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#15: ref :: { Node.Valid($Heap, n#15) } Node.Valid#canCall($Heap, n#15) || ((0 != $ModuleContextHeight || 2 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#15 == null || (read($Heap, n#15, alloc) && dtype(n#15) == class.Node))) ==> (n#15 != null ==> (read($Heap, n#15, Node.Repr)[$Box(n#15)] ==> true) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] ==> read($Heap, n#15, Node.left) != null ==> (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] ==> true) && (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) ==> read($Heap, n#15, Node.right) != null ==> (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] ==> true) && (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) ==> Node.Valid#canCall($Heap, read($Heap, n#15, Node.left)) && (Node.Valid($Heap, read($Heap, n#15, Node.left)) ==> Node.Valid#canCall($Heap, read($Heap, n#15, Node.right)))) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) ==> (read($Heap, n#15, Node.right) != null ==> true) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) ==> (read($Heap, n#15, Node.left) != null ==> true) && (read($Heap, n#15, Node.left) == null ==> true) && (read($Heap, n#15, Node.right) != null ==> true) && (read($Heap, n#15, Node.right) == null ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) ==> (read($Heap, n#15, Node.left) != null ==> true) && (read($Heap, n#15, Node.left) == null ==> true) && (read($Heap, n#15, Node.right) != null ==> true) && (read($Heap, n#15, Node.right) == null ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) ==> read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#15, Node.value))) ==> read($Heap, n#15, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#15, Node.right), Node.Contents)[$Box(i#17)] ==> true))) && Node.Valid($Heap, n#15) == (n#15 != null ==> read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid#limited($Heap, read($Heap, n#15, Node.left)) && Node.Valid#limited($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#15, Node.value))) && (read($Heap, n#15, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#15, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#15, Node.value) < i#17))));

// definition axiom for Node.Valid#2
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (2 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, n#15: ref :: { Node.Valid#2($Heap, n#15) } Node.Valid#canCall($Heap, n#15) || ((0 != $ModuleContextHeight || 2 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && (n#15 == null || (read($Heap, n#15, alloc) && dtype(n#15) == class.Node))) ==> Node.Valid#2($Heap, n#15) == (n#15 != null ==> read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#15, Node.value))) && (read($Heap, n#15, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#15, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#15, Node.value) < i#17))));

// frame axiom for Node.Valid
axiom (forall $h0: HeapType, $h1: HeapType, n#15: ref :: { $HeapSucc($h0, $h1), Node.Valid($h1, n#15) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#15 == null || (read($h0, n#15, alloc) && dtype(n#15) == class.Node)) && (n#15 == null || (read($h1, n#15, alloc) && dtype(n#15) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == n#15 || (n#15 != null && read($h0, n#15, Node.Repr)[$Box($o)])) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.Valid($h0, n#15) == Node.Valid($h1, n#15));

axiom (forall $h0: HeapType, $h1: HeapType, n#15: ref :: { $HeapSucc($h0, $h1), Node.Valid#limited($h1, n#15) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && (n#15 == null || (read($h0, n#15, alloc) && dtype(n#15) == class.Node)) && (n#15 == null || (read($h1, n#15, alloc) && dtype(n#15) == class.Node)) && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == n#15 || (n#15 != null && read($h0, n#15, Node.Repr)[$Box($o)])) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Node.Valid#limited($h0, n#15) == Node.Valid#limited($h1, n#15));

procedure CheckWellformed$$Node.Valid(n#15: ref where n#15 == null || (read($Heap, n#15, alloc) && dtype(n#15) == class.Node));
  free requires 0 == $ModuleContextHeight && 2 == $FunctionContextHeight;



implementation CheckWellformed$$Node.Valid(n#15: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#99: ref;
  var n#100: ref;
  var i#101: int;
  var i#102: int;

    if (n#15 != null)
    {
        assert n#15 != null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#15 || (n#15 != null && read($Heap, n#15, Node.Repr)[$Box($o)]));
        if (n#15 != null)
        {
            assert n#15 != null;
            assert $_Frame[n#15, Node.Repr];
            if (read($Heap, n#15, Node.Repr)[$Box(n#15)])
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.Repr];
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)])
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.left];
                if (read($Heap, n#15, Node.left) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.left];
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.Repr];
                    if (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))])
                    {
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.left];
                        assert read($Heap, n#15, Node.left) != null;
                        assert $_Frame[read($Heap, n#15, Node.left), Node.Repr];
                    }

                    if (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)])
                    {
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.left];
                        assert read($Heap, n#15, Node.left) != null;
                        assert $_Frame[read($Heap, n#15, Node.left), Node.Repr];
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.Repr];
                    }
                }
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))))
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.right];
                if (read($Heap, n#15, Node.right) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.right];
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.Repr];
                    if (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))])
                    {
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.right];
                        assert read($Heap, n#15, Node.right) != null;
                        assert $_Frame[read($Heap, n#15, Node.right), Node.Repr];
                    }

                    if (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)])
                    {
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.right];
                        assert read($Heap, n#15, Node.right) != null;
                        assert $_Frame[read($Heap, n#15, Node.right), Node.Repr];
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.Repr];
                    }
                }
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))))
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.left];
                n#99 := read($Heap, n#15, Node.left);
                assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#99 || (n#99 != null && read($Heap, n#99, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
                assert Set#Subset((if n#99 != null then read($Heap, n#99, Node.Repr) else Set#Empty(): Set BoxType), (if n#15 != null then read($Heap, n#15, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#15 != null then read($Heap, n#15, Node.Repr) else Set#Empty(): Set BoxType), (if n#99 != null then read($Heap, n#99, Node.Repr) else Set#Empty(): Set BoxType));
                assume Node.Valid#canCall($Heap, read($Heap, n#15, Node.left));
                if (Node.Valid($Heap, read($Heap, n#15, Node.left)))
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.right];
                    n#100 := read($Heap, n#15, Node.right);
                    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && ($o == n#100 || (n#100 != null && read($Heap, n#100, Node.Repr)[$Box($o)])) ==> $_Frame[$o, $f]);
                    assert Set#Subset((if n#100 != null then read($Heap, n#100, Node.Repr) else Set#Empty(): Set BoxType), (if n#15 != null then read($Heap, n#15, Node.Repr) else Set#Empty(): Set BoxType)) && !Set#Subset((if n#15 != null then read($Heap, n#15, Node.Repr) else Set#Empty(): Set BoxType), (if n#100 != null then read($Heap, n#100, Node.Repr) else Set#Empty(): Set BoxType));
                    assume Node.Valid#canCall($Heap, read($Heap, n#15, Node.right));
                }
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)))
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.right];
                if (read($Heap, n#15, Node.right) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.left];
                }

                if (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.left];
                    assert read($Heap, n#15, Node.left) != null;
                    assert $_Frame[read($Heap, n#15, Node.left), Node.Repr];
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.right];
                    assert read($Heap, n#15, Node.right) != null;
                    assert $_Frame[read($Heap, n#15, Node.right), Node.Repr];
                }
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))))
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.Repr];
                assert n#15 != null;
                assert $_Frame[n#15, Node.left];
                if (read($Heap, n#15, Node.left) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.left];
                    assert read($Heap, n#15, Node.left) != null;
                    assert $_Frame[read($Heap, n#15, Node.left), Node.Repr];
                }
                else
                {
                }

                assert n#15 != null;
                assert $_Frame[n#15, Node.right];
                if (read($Heap, n#15, Node.right) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.right];
                    assert read($Heap, n#15, Node.right) != null;
                    assert $_Frame[read($Heap, n#15, Node.right), Node.Repr];
                }
                else
                {
                }
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))))
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.Contents];
                assert n#15 != null;
                assert $_Frame[n#15, Node.value];
                assert n#15 != null;
                assert $_Frame[n#15, Node.left];
                if (read($Heap, n#15, Node.left) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.left];
                    assert read($Heap, n#15, Node.left) != null;
                    assert $_Frame[read($Heap, n#15, Node.left), Node.Contents];
                }
                else
                {
                }

                assert n#15 != null;
                assert $_Frame[n#15, Node.right];
                if (read($Heap, n#15, Node.right) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.right];
                    assert read($Heap, n#15, Node.right) != null;
                    assert $_Frame[read($Heap, n#15, Node.right), Node.Contents];
                }
                else
                {
                }
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))))
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.left];
                if (read($Heap, n#15, Node.left) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.left];
                    assert read($Heap, n#15, Node.left) != null;
                    assert $_Frame[read($Heap, n#15, Node.left), Node.Contents];
                    if (read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#101)])
                    {
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.value];
                    }
                }
            }

            if (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#15, Node.value))))
            {
                assert n#15 != null;
                assert $_Frame[n#15, Node.right];
                if (read($Heap, n#15, Node.right) != null)
                {
                    assert n#15 != null;
                    assert $_Frame[n#15, Node.right];
                    assert read($Heap, n#15, Node.right) != null;
                    assert $_Frame[read($Heap, n#15, Node.right), Node.Contents];
                    if (read($Heap, read($Heap, n#15, Node.right), Node.Contents)[$Box(i#102)])
                    {
                        assert n#15 != null;
                        assert $_Frame[n#15, Node.value];
                    }
                }
            }
        }

        assume Node.Valid($Heap, n#15) == (n#15 != null ==> read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#15, Node.value))) && (read($Heap, n#15, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#15, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#15, Node.value) < i#17)));
        assume n#15 != null ==> (read($Heap, n#15, Node.Repr)[$Box(n#15)] ==> true) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] ==> read($Heap, n#15, Node.left) != null ==> (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] ==> true) && (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) ==> read($Heap, n#15, Node.right) != null ==> (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] ==> true) && (read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) ==> Node.Valid#canCall($Heap, read($Heap, n#15, Node.left)) && (Node.Valid($Heap, read($Heap, n#15, Node.left)) ==> Node.Valid#canCall($Heap, read($Heap, n#15, Node.right)))) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) ==> (read($Heap, n#15, Node.right) != null ==> true) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) ==> (read($Heap, n#15, Node.left) != null ==> true) && (read($Heap, n#15, Node.left) == null ==> true) && (read($Heap, n#15, Node.right) != null ==> true) && (read($Heap, n#15, Node.right) == null ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) ==> (read($Heap, n#15, Node.left) != null ==> true) && (read($Heap, n#15, Node.left) == null ==> true) && (read($Heap, n#15, Node.right) != null ==> true) && (read($Heap, n#15, Node.right) == null ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) ==> read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> true)) && (read($Heap, n#15, Node.Repr)[$Box(n#15)] && !read($Heap, n#15, Node.Repr)[$Box(null)] && (read($Heap, n#15, Node.left) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.left))] && !read($Heap, read($Heap, n#15, Node.left), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, n#15, Node.Repr))) && (read($Heap, n#15, Node.right) != null ==> read($Heap, n#15, Node.Repr)[$Box(read($Heap, n#15, Node.right))] && !read($Heap, read($Heap, n#15, Node.right), Node.Repr)[$Box(n#15)] && Set#Subset(read($Heap, read($Heap, n#15, Node.right), Node.Repr), read($Heap, n#15, Node.Repr))) && Node.Valid($Heap, read($Heap, n#15, Node.left)) && Node.Valid($Heap, read($Heap, n#15, Node.right)) && (read($Heap, n#15, Node.right) != null && read($Heap, n#15, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#15, Node.left), Node.Repr), read($Heap, read($Heap, n#15, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#15, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#15)), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#15, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#15, Node.value))), (if read($Heap, n#15, Node.left) != null then read($Heap, read($Heap, n#15, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#15, Node.right) != null then read($Heap, read($Heap, n#15, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#15, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#15, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#15, Node.value))) ==> read($Heap, n#15, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#15, Node.right), Node.Contents)[$Box(i#17)] ==> true));
    }
}



procedure CheckWellformed$$Node.WeakRightRotation(n#18: ref where n#18 == null || (read($Heap, n#18, alloc) && dtype(n#18) == class.Node)) returns (r#19: ref where r#19 == null || (read($Heap, r#19, alloc) && dtype(r#19) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Node.WeakRightRotation(n#18: ref) returns (r#19: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#103: ref;
  var n#104: ref;
  var n#105: ref;
  var n#106: ref;
  var n#107: ref;
  var n#108: ref;
  var n#109: ref;
  var n#110: ref;
  var n#111: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#18 || (n#18 != null && $o == read($Heap, n#18, Node.left)));
    if (n#18 != null)
    {
        assert n#18 != null;
    }

    assume n#18 != null && read($Heap, n#18, Node.left) != null;
    n#103 := n#18;
    assume Node.Valid#canCall($Heap, n#18);
    if (Node.Valid($Heap, n#18))
    {
        n#104 := n#18;
        assert Node.Valid($Heap, n#104);
        assume Node.BalanceValid#canCall($Heap, n#18);
    }

    if (Node.Valid($Heap, n#18) && Node.BalanceValid($Heap, n#18))
    {
        n#105 := n#18;
        assert Node.Valid($Heap, n#105) && Node.BalanceValid($Heap, n#105);
        assume Node.Balanced#canCall($Heap, n#18);
    }

    assume Node.Valid($Heap, n#18) && Node.BalanceValid($Heap, n#18) && Node.Balanced($Heap, n#18);
    assert n#18 != null;
    assume read($Heap, n#18, Node.balance) == 0 - 1;
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#18 || (n#18 != null && $o == read(old($Heap), n#18, Node.left)));
    assume $HeapSucc(old($Heap), $Heap);
    havoc r#19;
    assert n#18 != null;
    if (r#19 == old(read($Heap, n#18, Node.left)))
    {
        assert r#19 != null;
        assert n#18 != null;
    }

    if (r#19 == old(read($Heap, n#18, Node.left)) && Set#Equal(read($Heap, r#19, Node.Contents), old(read($Heap, n#18, Node.Contents))))
    {
        assert r#19 != null;
        assert n#18 != null;
    }

    assume r#19 == old(read($Heap, n#18, Node.left)) && Set#Equal(read($Heap, r#19, Node.Contents), old(read($Heap, n#18, Node.Contents))) && Set#Equal(read($Heap, r#19, Node.Repr), old(read($Heap, n#18, Node.Repr)));
    n#106 := r#19;
    assume Node.Valid#canCall($Heap, r#19);
    if (Node.Valid($Heap, r#19))
    {
        n#107 := r#19;
        assert Node.Valid($Heap, n#107);
        assume Node.BalanceValid#canCall($Heap, r#19);
    }

    assume Node.Valid($Heap, r#19) && Node.BalanceValid($Heap, r#19);
    assert r#19 != null;
    n#108 := read($Heap, r#19, Node.left);
    assert Node.Valid($Heap, n#108) && Node.BalanceValid($Heap, n#108);
    assume Node.Balanced#canCall($Heap, read($Heap, r#19, Node.left));
    if (Node.Balanced($Heap, read($Heap, r#19, Node.left)))
    {
        assert r#19 != null;
        n#109 := read($Heap, r#19, Node.right);
        assert Node.Valid($Heap, n#109) && Node.BalanceValid($Heap, n#109);
        assume Node.Balanced#canCall($Heap, read($Heap, r#19, Node.right));
    }

    assume Node.Balanced($Heap, read($Heap, r#19, Node.left)) && Node.Balanced($Heap, read($Heap, r#19, Node.right));
    n#110 := r#19;
    assert Node.Valid($Heap, n#110);
    assume Node.Height#canCall($Heap, r#19);
    n#111 := n#18;
    assert n#18 == null || (read(old($Heap), n#18, alloc) && dtype(n#18) == class.Node);
    assert Node.Valid(old($Heap), n#111);
    assume Node.Height#canCall(old($Heap), n#18);
    assume Node.Height($Heap, r#19) == old(Node.Height($Heap, n#18));
    assert r#19 != null;
    if (read($Heap, r#19, Node.balance) != 1)
    {
        assert r#19 != null;
    }

    assume read($Heap, r#19, Node.balance) == 1 || read($Heap, r#19, Node.balance) == 2;
}



procedure Node.WeakRightRotation(n#18: ref where n#18 == null || (read($Heap, n#18, alloc) && dtype(n#18) == class.Node)) returns (r#19: ref where r#19 == null || (read($Heap, r#19, alloc) && dtype(r#19) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires n#18 != null;
  requires read($Heap, n#18, Node.left) != null;
  free requires Node.Valid#canCall($Heap, n#18) && Node.Valid($Heap, n#18) && (n#18 != null ==> read($Heap, n#18, Node.Repr)[$Box(n#18)] && !read($Heap, n#18, Node.Repr)[$Box(null)] && (read($Heap, n#18, Node.left) != null ==> read($Heap, n#18, Node.Repr)[$Box(read($Heap, n#18, Node.left))] && !read($Heap, read($Heap, n#18, Node.left), Node.Repr)[$Box(n#18)] && Set#Subset(read($Heap, read($Heap, n#18, Node.left), Node.Repr), read($Heap, n#18, Node.Repr))) && (read($Heap, n#18, Node.right) != null ==> read($Heap, n#18, Node.Repr)[$Box(read($Heap, n#18, Node.right))] && !read($Heap, read($Heap, n#18, Node.right), Node.Repr)[$Box(n#18)] && Set#Subset(read($Heap, read($Heap, n#18, Node.right), Node.Repr), read($Heap, n#18, Node.Repr))) && Node.Valid($Heap, read($Heap, n#18, Node.left)) && Node.Valid($Heap, read($Heap, n#18, Node.right)) && (read($Heap, n#18, Node.right) != null && read($Heap, n#18, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#18, Node.left), Node.Repr), read($Heap, read($Heap, n#18, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#18, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#18)), (if read($Heap, n#18, Node.left) != null then read($Heap, read($Heap, n#18, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#18, Node.right) != null then read($Heap, read($Heap, n#18, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#18, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#18, Node.value))), (if read($Heap, n#18, Node.left) != null then read($Heap, read($Heap, n#18, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#18, Node.right) != null then read($Heap, read($Heap, n#18, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#18, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#18, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#18, Node.value))) && (read($Heap, n#18, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#18, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#18, Node.value) < i#17)));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.Repr)[$Box(n#18)]);
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> !read($Heap, n#18, Node.Repr)[$Box(null)]);
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.left) != null ==> read($Heap, n#18, Node.Repr)[$Box(read($Heap, n#18, Node.left))]);
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.left) != null ==> !read($Heap, read($Heap, n#18, Node.left), Node.Repr)[$Box(n#18)]);
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, n#18, Node.left), Node.Repr), read($Heap, n#18, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.right) != null ==> read($Heap, n#18, Node.Repr)[$Box(read($Heap, n#18, Node.right))]);
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.right) != null ==> !read($Heap, read($Heap, n#18, Node.right), Node.Repr)[$Box(n#18)]);
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, n#18, Node.right), Node.Repr), read($Heap, n#18, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> Node.Valid($Heap, read($Heap, n#18, Node.left)));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> Node.Valid($Heap, read($Heap, n#18, Node.right)));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.right) != null && read($Heap, n#18, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#18, Node.left), Node.Repr), read($Heap, read($Heap, n#18, Node.right), Node.Repr)));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> Set#Equal(read($Heap, n#18, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#18)), (if read($Heap, n#18, Node.left) != null then read($Heap, read($Heap, n#18, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#18, Node.right) != null then read($Heap, read($Heap, n#18, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> Set#Equal(read($Heap, n#18, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#18, Node.value))), (if read($Heap, n#18, Node.left) != null then read($Heap, read($Heap, n#18, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#18, Node.right) != null then read($Heap, read($Heap, n#18, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#18, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#18, Node.value)));
  requires Node.Valid#canCall($Heap, n#18) ==> Node.Valid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#18, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#18, Node.value) < i#17));
  free requires Node.BalanceValid#canCall($Heap, n#18) && Node.BalanceValid($Heap, n#18) && (n#18 != null ==> read($Heap, n#18, Node.balance) == Node.Height($Heap, read($Heap, n#18, Node.right)) - Node.Height($Heap, read($Heap, n#18, Node.left)) && (read($Heap, n#18, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#18, Node.left))) && (read($Heap, n#18, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#18, Node.right))));
  requires Node.BalanceValid#canCall($Heap, n#18) ==> Node.BalanceValid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.balance) == Node.Height($Heap, read($Heap, n#18, Node.right)) - Node.Height($Heap, read($Heap, n#18, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#18) ==> Node.BalanceValid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#18, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#18) ==> Node.BalanceValid($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#18, Node.right)));
  free requires Node.Balanced#canCall($Heap, n#18) && Node.Balanced($Heap, n#18) && (n#18 != null ==> (read($Heap, n#18, Node.balance) == 0 - 1 || read($Heap, n#18, Node.balance) == 0 || read($Heap, n#18, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, n#18, Node.right)) && Node.Balanced($Heap, read($Heap, n#18, Node.left)));
  requires Node.Balanced#canCall($Heap, n#18) ==> Node.Balanced($Heap, n#18) || (n#18 != null ==> read($Heap, n#18, Node.balance) == 0 - 1 || read($Heap, n#18, Node.balance) == 0 || read($Heap, n#18, Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, n#18) ==> Node.Balanced($Heap, n#18) || (n#18 != null ==> Node.Balanced($Heap, read($Heap, n#18, Node.right)));
  requires Node.Balanced#canCall($Heap, n#18) ==> Node.Balanced($Heap, n#18) || (n#18 != null ==> Node.Balanced($Heap, read($Heap, n#18, Node.left)));
  requires read($Heap, n#18, Node.balance) == 0 - 1;
  modifies $Heap, $Tick;
  ensures r#19 == old(read($Heap, n#18, Node.left));
  ensures Set#Equal(read($Heap, r#19, Node.Contents), old(read($Heap, n#18, Node.Contents)));
  ensures Set#Equal(read($Heap, r#19, Node.Repr), old(read($Heap, n#18, Node.Repr)));
  free ensures Node.Valid#canCall($Heap, r#19) && Node.Valid($Heap, r#19) && (r#19 != null ==> read($Heap, r#19, Node.Repr)[$Box(r#19)] && !read($Heap, r#19, Node.Repr)[$Box(null)] && (read($Heap, r#19, Node.left) != null ==> read($Heap, r#19, Node.Repr)[$Box(read($Heap, r#19, Node.left))] && !read($Heap, read($Heap, r#19, Node.left), Node.Repr)[$Box(r#19)] && Set#Subset(read($Heap, read($Heap, r#19, Node.left), Node.Repr), read($Heap, r#19, Node.Repr))) && (read($Heap, r#19, Node.right) != null ==> read($Heap, r#19, Node.Repr)[$Box(read($Heap, r#19, Node.right))] && !read($Heap, read($Heap, r#19, Node.right), Node.Repr)[$Box(r#19)] && Set#Subset(read($Heap, read($Heap, r#19, Node.right), Node.Repr), read($Heap, r#19, Node.Repr))) && Node.Valid($Heap, read($Heap, r#19, Node.left)) && Node.Valid($Heap, read($Heap, r#19, Node.right)) && (read($Heap, r#19, Node.right) != null && read($Heap, r#19, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#19, Node.left), Node.Repr), read($Heap, read($Heap, r#19, Node.right), Node.Repr))) && Set#Equal(read($Heap, r#19, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#19)), (if read($Heap, r#19, Node.left) != null then read($Heap, read($Heap, r#19, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#19, Node.right) != null then read($Heap, read($Heap, r#19, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, r#19, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#19, Node.value))), (if read($Heap, r#19, Node.left) != null then read($Heap, read($Heap, r#19, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#19, Node.right) != null then read($Heap, read($Heap, r#19, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, r#19, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#19, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#19, Node.value))) && (read($Heap, r#19, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#19, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#19, Node.value) < i#17)));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.Repr)[$Box(r#19)]);
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> !read($Heap, r#19, Node.Repr)[$Box(null)]);
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.left) != null ==> read($Heap, r#19, Node.Repr)[$Box(read($Heap, r#19, Node.left))]);
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.left) != null ==> !read($Heap, read($Heap, r#19, Node.left), Node.Repr)[$Box(r#19)]);
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, r#19, Node.left), Node.Repr), read($Heap, r#19, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.right) != null ==> read($Heap, r#19, Node.Repr)[$Box(read($Heap, r#19, Node.right))]);
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.right) != null ==> !read($Heap, read($Heap, r#19, Node.right), Node.Repr)[$Box(r#19)]);
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, r#19, Node.right), Node.Repr), read($Heap, r#19, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> Node.Valid($Heap, read($Heap, r#19, Node.left)));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> Node.Valid($Heap, read($Heap, r#19, Node.right)));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.right) != null && read($Heap, r#19, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#19, Node.left), Node.Repr), read($Heap, read($Heap, r#19, Node.right), Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> Set#Equal(read($Heap, r#19, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#19)), (if read($Heap, r#19, Node.left) != null then read($Heap, read($Heap, r#19, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#19, Node.right) != null then read($Heap, read($Heap, r#19, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> Set#Equal(read($Heap, r#19, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#19, Node.value))), (if read($Heap, r#19, Node.left) != null then read($Heap, read($Heap, r#19, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#19, Node.right) != null then read($Heap, read($Heap, r#19, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#19, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#19, Node.value)));
  ensures Node.Valid#canCall($Heap, r#19) ==> Node.Valid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#19, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#19, Node.value) < i#17));
  free ensures Node.BalanceValid#canCall($Heap, r#19) && Node.BalanceValid($Heap, r#19) && (r#19 != null ==> read($Heap, r#19, Node.balance) == Node.Height($Heap, read($Heap, r#19, Node.right)) - Node.Height($Heap, read($Heap, r#19, Node.left)) && (read($Heap, r#19, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#19, Node.left))) && (read($Heap, r#19, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#19, Node.right))));
  ensures Node.BalanceValid#canCall($Heap, r#19) ==> Node.BalanceValid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.balance) == Node.Height($Heap, read($Heap, r#19, Node.right)) - Node.Height($Heap, read($Heap, r#19, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#19) ==> Node.BalanceValid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#19, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#19) ==> Node.BalanceValid($Heap, r#19) || (r#19 != null ==> read($Heap, r#19, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#19, Node.right)));
  free ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.left)) && Node.Balanced($Heap, read($Heap, r#19, Node.left)) && (read($Heap, r#19, Node.left) != null ==> (read($Heap, read($Heap, r#19, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#19, Node.left), Node.balance) == 0 || read($Heap, read($Heap, r#19, Node.left), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.left), Node.left)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.left)) ==> Node.Balanced($Heap, read($Heap, r#19, Node.left)) || (read($Heap, r#19, Node.left) != null ==> read($Heap, read($Heap, r#19, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#19, Node.left), Node.balance) == 0 || read($Heap, read($Heap, r#19, Node.left), Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.left)) ==> Node.Balanced($Heap, read($Heap, r#19, Node.left)) || (read($Heap, r#19, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.left), Node.right)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.left)) ==> Node.Balanced($Heap, read($Heap, r#19, Node.left)) || (read($Heap, r#19, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.left), Node.left)));
  free ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.right)) && Node.Balanced($Heap, read($Heap, r#19, Node.right)) && (read($Heap, r#19, Node.right) != null ==> (read($Heap, read($Heap, r#19, Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#19, Node.right), Node.balance) == 0 || read($Heap, read($Heap, r#19, Node.right), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.right), Node.left)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.right)) ==> Node.Balanced($Heap, read($Heap, r#19, Node.right)) || (read($Heap, r#19, Node.right) != null ==> read($Heap, read($Heap, r#19, Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#19, Node.right), Node.balance) == 0 || read($Heap, read($Heap, r#19, Node.right), Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.right)) ==> Node.Balanced($Heap, read($Heap, r#19, Node.right)) || (read($Heap, r#19, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.right), Node.right)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#19, Node.right)) ==> Node.Balanced($Heap, read($Heap, r#19, Node.right)) || (read($Heap, r#19, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#19, Node.right), Node.left)));
  ensures Node.Height#2($Heap, r#19) == old(Node.Height#2($Heap, n#18));
  ensures read($Heap, r#19, Node.balance) == 1 || read($Heap, r#19, Node.balance) == 2;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#18 || (n#18 != null && $o == read(old($Heap), n#18, Node.left)));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Node.WeakRightRotation(n#18: ref) returns (r#19: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var a#20: ref where a#20 == null || (read($Heap, a#20, alloc) && dtype(a#20) == class.Node);
  var b#21: ref where b#21 == null || (read($Heap, b#21, alloc) && dtype(b#21) == class.Node);
  var c#22: ref where c#22 == null || (read($Heap, c#22, alloc) && dtype(c#22) == class.Node);
  var $rhs#0: ref;
  var $rhs#1: ref;
  var $rhs#2: ref;
  var a#112: ref;
  var b#113: ref;
  var x#114: ref;
  var d#115: int;
  var a#116: ref;
  var b#117: ref;
  var x#118: ref;
  var d#119: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#18 || (n#18 != null && $o == read($Heap, n#18, Node.left)));
    // ----- assignment statement ----- AVLTree.dfy(247,9)
    assume true;
    assert n#18 != null;
    assume true;
    r#19 := read($Heap, n#18, Node.left);
    assume {:captureState "AVLTree.dfy(247,9)"} true;
    // ----- assert statement ----- AVLTree.dfy(248,7)
    assert {:subsumption 0} n#18 != null;
    assert {:subsumption 0} r#19 != null;
    assert {:subsumption 0} n#18 != null;
    assert {:subsumption 0} n#18 != null;
    if (read($Heap, n#18, Node.right) != null)
    {
        assert {:subsumption 0} n#18 != null;
        assert {:subsumption 0} read($Heap, n#18, Node.right) != null;
    }
    else
    {
    }

    assume (read($Heap, n#18, Node.right) != null ==> true) && (read($Heap, n#18, Node.right) == null ==> true);
    assert Set#Equal(read($Heap, n#18, Node.Contents), Set#Union(Set#Union(read($Heap, r#19, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#18, Node.value)))), (if read($Heap, n#18, Node.right) != null then read($Heap, read($Heap, n#18, Node.right), Node.Contents) else Set#Empty(): Set BoxType)));
    // ----- var-declaration statement ----- AVLTree.dfy(249,11)
    // ----- var-declaration statement ----- AVLTree.dfy(249,14)
    // ----- var-declaration statement ----- AVLTree.dfy(249,17)
    // ----- update statement ----- AVLTree.dfy(249,19)
    assume true;
    assume true;
    assume true;
    assert r#19 != null;
    assume true;
    $rhs#0 := read($Heap, r#19, Node.left);
    assert r#19 != null;
    assume true;
    $rhs#1 := read($Heap, r#19, Node.right);
    assert n#18 != null;
    assume true;
    $rhs#2 := read($Heap, n#18, Node.right);
    a#20 := $rhs#0;
    b#21 := $rhs#1;
    c#22 := $rhs#2;
    assume {:captureState "AVLTree.dfy(249,19)"} true;
    // ----- call statement ----- AVLTree.dfy(250,7)
    assume true;
    a#112 := b#21;
    assume true;
    b#113 := c#22;
    assume true;
    x#114 := n#18;
    assert r#19 != null;
    if (read($Heap, r#19, Node.balance) == 0 - 1)
    {
    }
    else
    {
    }

    assume (read($Heap, r#19, Node.balance) == 0 - 1 ==> true) && (read($Heap, r#19, Node.balance) != 0 - 1 ==> true);
    d#115 := (if read($Heap, r#19, Node.balance) == 0 - 1 then 1 else 0);
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#114 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#112, b#113, x#114, d#115);
    assume {:captureState "AVLTree.dfy(250,7)"} true;
    // ----- call statement ----- AVLTree.dfy(251,7)
    assume true;
    a#116 := a#20;
    assume true;
    b#117 := n#18;
    assume true;
    x#118 := r#19;
    assert r#19 != null;
    if (read($Heap, r#19, Node.balance) == 1)
    {
    }
    else
    {
    }

    assume (read($Heap, r#19, Node.balance) == 1 ==> true) && (read($Heap, r#19, Node.balance) != 1 ==> true);
    d#119 := (if read($Heap, r#19, Node.balance) == 1 then 2 else 1);
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#118 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#116, b#117, x#118, d#119);
    assume {:captureState "AVLTree.dfy(251,7)"} true;
}



procedure CheckWellformed$$Node.WeakLeftRotation(n#23: ref where n#23 == null || (read($Heap, n#23, alloc) && dtype(n#23) == class.Node)) returns (r#24: ref where r#24 == null || (read($Heap, r#24, alloc) && dtype(r#24) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Node.WeakLeftRotation(n#23: ref) returns (r#24: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#120: ref;
  var n#121: ref;
  var n#122: ref;
  var n#123: ref;
  var n#124: ref;
  var n#125: ref;
  var n#126: ref;
  var n#127: ref;
  var n#128: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#23 || (n#23 != null && $o == read($Heap, n#23, Node.right)));
    if (n#23 != null)
    {
        assert n#23 != null;
    }

    assume n#23 != null && read($Heap, n#23, Node.right) != null;
    n#120 := n#23;
    assume Node.Valid#canCall($Heap, n#23);
    if (Node.Valid($Heap, n#23))
    {
        n#121 := n#23;
        assert Node.Valid($Heap, n#121);
        assume Node.BalanceValid#canCall($Heap, n#23);
    }

    if (Node.Valid($Heap, n#23) && Node.BalanceValid($Heap, n#23))
    {
        n#122 := n#23;
        assert Node.Valid($Heap, n#122) && Node.BalanceValid($Heap, n#122);
        assume Node.Balanced#canCall($Heap, n#23);
    }

    assume Node.Valid($Heap, n#23) && Node.BalanceValid($Heap, n#23) && Node.Balanced($Heap, n#23);
    assert n#23 != null;
    assume read($Heap, n#23, Node.balance) == 1;
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#23 || (n#23 != null && $o == read(old($Heap), n#23, Node.right)));
    assume $HeapSucc(old($Heap), $Heap);
    havoc r#24;
    assert n#23 != null;
    if (r#24 == old(read($Heap, n#23, Node.right)))
    {
        assert r#24 != null;
        assert n#23 != null;
    }

    if (r#24 == old(read($Heap, n#23, Node.right)) && Set#Equal(read($Heap, r#24, Node.Contents), old(read($Heap, n#23, Node.Contents))))
    {
        assert r#24 != null;
        assert n#23 != null;
    }

    assume r#24 == old(read($Heap, n#23, Node.right)) && Set#Equal(read($Heap, r#24, Node.Contents), old(read($Heap, n#23, Node.Contents))) && Set#Equal(read($Heap, r#24, Node.Repr), old(read($Heap, n#23, Node.Repr)));
    n#123 := r#24;
    assume Node.Valid#canCall($Heap, r#24);
    if (Node.Valid($Heap, r#24))
    {
        n#124 := r#24;
        assert Node.Valid($Heap, n#124);
        assume Node.BalanceValid#canCall($Heap, r#24);
    }

    assume Node.Valid($Heap, r#24) && Node.BalanceValid($Heap, r#24);
    assert r#24 != null;
    n#125 := read($Heap, r#24, Node.left);
    assert Node.Valid($Heap, n#125) && Node.BalanceValid($Heap, n#125);
    assume Node.Balanced#canCall($Heap, read($Heap, r#24, Node.left));
    if (Node.Balanced($Heap, read($Heap, r#24, Node.left)))
    {
        assert r#24 != null;
        n#126 := read($Heap, r#24, Node.right);
        assert Node.Valid($Heap, n#126) && Node.BalanceValid($Heap, n#126);
        assume Node.Balanced#canCall($Heap, read($Heap, r#24, Node.right));
    }

    assume Node.Balanced($Heap, read($Heap, r#24, Node.left)) && Node.Balanced($Heap, read($Heap, r#24, Node.right));
    n#127 := r#24;
    assert Node.Valid($Heap, n#127);
    assume Node.Height#canCall($Heap, r#24);
    n#128 := n#23;
    assert n#23 == null || (read(old($Heap), n#23, alloc) && dtype(n#23) == class.Node);
    assert Node.Valid(old($Heap), n#128);
    assume Node.Height#canCall(old($Heap), n#23);
    assume Node.Height($Heap, r#24) == old(Node.Height($Heap, n#23));
    assert r#24 != null;
    if (read($Heap, r#24, Node.balance) != 0 - 1)
    {
        assert r#24 != null;
    }

    assume read($Heap, r#24, Node.balance) == 0 - 1 || read($Heap, r#24, Node.balance) == 0 - 2;
}



procedure Node.WeakLeftRotation(n#23: ref where n#23 == null || (read($Heap, n#23, alloc) && dtype(n#23) == class.Node)) returns (r#24: ref where r#24 == null || (read($Heap, r#24, alloc) && dtype(r#24) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires n#23 != null;
  requires read($Heap, n#23, Node.right) != null;
  free requires Node.Valid#canCall($Heap, n#23) && Node.Valid($Heap, n#23) && (n#23 != null ==> read($Heap, n#23, Node.Repr)[$Box(n#23)] && !read($Heap, n#23, Node.Repr)[$Box(null)] && (read($Heap, n#23, Node.left) != null ==> read($Heap, n#23, Node.Repr)[$Box(read($Heap, n#23, Node.left))] && !read($Heap, read($Heap, n#23, Node.left), Node.Repr)[$Box(n#23)] && Set#Subset(read($Heap, read($Heap, n#23, Node.left), Node.Repr), read($Heap, n#23, Node.Repr))) && (read($Heap, n#23, Node.right) != null ==> read($Heap, n#23, Node.Repr)[$Box(read($Heap, n#23, Node.right))] && !read($Heap, read($Heap, n#23, Node.right), Node.Repr)[$Box(n#23)] && Set#Subset(read($Heap, read($Heap, n#23, Node.right), Node.Repr), read($Heap, n#23, Node.Repr))) && Node.Valid($Heap, read($Heap, n#23, Node.left)) && Node.Valid($Heap, read($Heap, n#23, Node.right)) && (read($Heap, n#23, Node.right) != null && read($Heap, n#23, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#23, Node.left), Node.Repr), read($Heap, read($Heap, n#23, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#23, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#23)), (if read($Heap, n#23, Node.left) != null then read($Heap, read($Heap, n#23, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#23, Node.right) != null then read($Heap, read($Heap, n#23, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#23, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#23, Node.value))), (if read($Heap, n#23, Node.left) != null then read($Heap, read($Heap, n#23, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#23, Node.right) != null then read($Heap, read($Heap, n#23, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#23, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#23, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#23, Node.value))) && (read($Heap, n#23, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#23, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#23, Node.value) < i#17)));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.Repr)[$Box(n#23)]);
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> !read($Heap, n#23, Node.Repr)[$Box(null)]);
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.left) != null ==> read($Heap, n#23, Node.Repr)[$Box(read($Heap, n#23, Node.left))]);
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.left) != null ==> !read($Heap, read($Heap, n#23, Node.left), Node.Repr)[$Box(n#23)]);
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, n#23, Node.left), Node.Repr), read($Heap, n#23, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.right) != null ==> read($Heap, n#23, Node.Repr)[$Box(read($Heap, n#23, Node.right))]);
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.right) != null ==> !read($Heap, read($Heap, n#23, Node.right), Node.Repr)[$Box(n#23)]);
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, n#23, Node.right), Node.Repr), read($Heap, n#23, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> Node.Valid($Heap, read($Heap, n#23, Node.left)));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> Node.Valid($Heap, read($Heap, n#23, Node.right)));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.right) != null && read($Heap, n#23, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#23, Node.left), Node.Repr), read($Heap, read($Heap, n#23, Node.right), Node.Repr)));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> Set#Equal(read($Heap, n#23, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#23)), (if read($Heap, n#23, Node.left) != null then read($Heap, read($Heap, n#23, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#23, Node.right) != null then read($Heap, read($Heap, n#23, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> Set#Equal(read($Heap, n#23, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#23, Node.value))), (if read($Heap, n#23, Node.left) != null then read($Heap, read($Heap, n#23, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#23, Node.right) != null then read($Heap, read($Heap, n#23, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#23, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#23, Node.value)));
  requires Node.Valid#canCall($Heap, n#23) ==> Node.Valid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#23, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#23, Node.value) < i#17));
  free requires Node.BalanceValid#canCall($Heap, n#23) && Node.BalanceValid($Heap, n#23) && (n#23 != null ==> read($Heap, n#23, Node.balance) == Node.Height($Heap, read($Heap, n#23, Node.right)) - Node.Height($Heap, read($Heap, n#23, Node.left)) && (read($Heap, n#23, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#23, Node.left))) && (read($Heap, n#23, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#23, Node.right))));
  requires Node.BalanceValid#canCall($Heap, n#23) ==> Node.BalanceValid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.balance) == Node.Height($Heap, read($Heap, n#23, Node.right)) - Node.Height($Heap, read($Heap, n#23, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#23) ==> Node.BalanceValid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#23, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#23) ==> Node.BalanceValid($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#23, Node.right)));
  free requires Node.Balanced#canCall($Heap, n#23) && Node.Balanced($Heap, n#23) && (n#23 != null ==> (read($Heap, n#23, Node.balance) == 0 - 1 || read($Heap, n#23, Node.balance) == 0 || read($Heap, n#23, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, n#23, Node.right)) && Node.Balanced($Heap, read($Heap, n#23, Node.left)));
  requires Node.Balanced#canCall($Heap, n#23) ==> Node.Balanced($Heap, n#23) || (n#23 != null ==> read($Heap, n#23, Node.balance) == 0 - 1 || read($Heap, n#23, Node.balance) == 0 || read($Heap, n#23, Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, n#23) ==> Node.Balanced($Heap, n#23) || (n#23 != null ==> Node.Balanced($Heap, read($Heap, n#23, Node.right)));
  requires Node.Balanced#canCall($Heap, n#23) ==> Node.Balanced($Heap, n#23) || (n#23 != null ==> Node.Balanced($Heap, read($Heap, n#23, Node.left)));
  requires read($Heap, n#23, Node.balance) == 1;
  modifies $Heap, $Tick;
  ensures r#24 == old(read($Heap, n#23, Node.right));
  ensures Set#Equal(read($Heap, r#24, Node.Contents), old(read($Heap, n#23, Node.Contents)));
  ensures Set#Equal(read($Heap, r#24, Node.Repr), old(read($Heap, n#23, Node.Repr)));
  free ensures Node.Valid#canCall($Heap, r#24) && Node.Valid($Heap, r#24) && (r#24 != null ==> read($Heap, r#24, Node.Repr)[$Box(r#24)] && !read($Heap, r#24, Node.Repr)[$Box(null)] && (read($Heap, r#24, Node.left) != null ==> read($Heap, r#24, Node.Repr)[$Box(read($Heap, r#24, Node.left))] && !read($Heap, read($Heap, r#24, Node.left), Node.Repr)[$Box(r#24)] && Set#Subset(read($Heap, read($Heap, r#24, Node.left), Node.Repr), read($Heap, r#24, Node.Repr))) && (read($Heap, r#24, Node.right) != null ==> read($Heap, r#24, Node.Repr)[$Box(read($Heap, r#24, Node.right))] && !read($Heap, read($Heap, r#24, Node.right), Node.Repr)[$Box(r#24)] && Set#Subset(read($Heap, read($Heap, r#24, Node.right), Node.Repr), read($Heap, r#24, Node.Repr))) && Node.Valid($Heap, read($Heap, r#24, Node.left)) && Node.Valid($Heap, read($Heap, r#24, Node.right)) && (read($Heap, r#24, Node.right) != null && read($Heap, r#24, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#24, Node.left), Node.Repr), read($Heap, read($Heap, r#24, Node.right), Node.Repr))) && Set#Equal(read($Heap, r#24, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#24)), (if read($Heap, r#24, Node.left) != null then read($Heap, read($Heap, r#24, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#24, Node.right) != null then read($Heap, read($Heap, r#24, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, r#24, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#24, Node.value))), (if read($Heap, r#24, Node.left) != null then read($Heap, read($Heap, r#24, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#24, Node.right) != null then read($Heap, read($Heap, r#24, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, r#24, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#24, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#24, Node.value))) && (read($Heap, r#24, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#24, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#24, Node.value) < i#17)));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.Repr)[$Box(r#24)]);
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> !read($Heap, r#24, Node.Repr)[$Box(null)]);
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.left) != null ==> read($Heap, r#24, Node.Repr)[$Box(read($Heap, r#24, Node.left))]);
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.left) != null ==> !read($Heap, read($Heap, r#24, Node.left), Node.Repr)[$Box(r#24)]);
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, r#24, Node.left), Node.Repr), read($Heap, r#24, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.right) != null ==> read($Heap, r#24, Node.Repr)[$Box(read($Heap, r#24, Node.right))]);
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.right) != null ==> !read($Heap, read($Heap, r#24, Node.right), Node.Repr)[$Box(r#24)]);
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, r#24, Node.right), Node.Repr), read($Heap, r#24, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> Node.Valid($Heap, read($Heap, r#24, Node.left)));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> Node.Valid($Heap, read($Heap, r#24, Node.right)));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.right) != null && read($Heap, r#24, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#24, Node.left), Node.Repr), read($Heap, read($Heap, r#24, Node.right), Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> Set#Equal(read($Heap, r#24, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#24)), (if read($Heap, r#24, Node.left) != null then read($Heap, read($Heap, r#24, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#24, Node.right) != null then read($Heap, read($Heap, r#24, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> Set#Equal(read($Heap, r#24, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#24, Node.value))), (if read($Heap, r#24, Node.left) != null then read($Heap, read($Heap, r#24, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#24, Node.right) != null then read($Heap, read($Heap, r#24, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#24, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#24, Node.value)));
  ensures Node.Valid#canCall($Heap, r#24) ==> Node.Valid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#24, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#24, Node.value) < i#17));
  free ensures Node.BalanceValid#canCall($Heap, r#24) && Node.BalanceValid($Heap, r#24) && (r#24 != null ==> read($Heap, r#24, Node.balance) == Node.Height($Heap, read($Heap, r#24, Node.right)) - Node.Height($Heap, read($Heap, r#24, Node.left)) && (read($Heap, r#24, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#24, Node.left))) && (read($Heap, r#24, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#24, Node.right))));
  ensures Node.BalanceValid#canCall($Heap, r#24) ==> Node.BalanceValid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.balance) == Node.Height($Heap, read($Heap, r#24, Node.right)) - Node.Height($Heap, read($Heap, r#24, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#24) ==> Node.BalanceValid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#24, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#24) ==> Node.BalanceValid($Heap, r#24) || (r#24 != null ==> read($Heap, r#24, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#24, Node.right)));
  free ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.left)) && Node.Balanced($Heap, read($Heap, r#24, Node.left)) && (read($Heap, r#24, Node.left) != null ==> (read($Heap, read($Heap, r#24, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#24, Node.left), Node.balance) == 0 || read($Heap, read($Heap, r#24, Node.left), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.left), Node.left)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.left)) ==> Node.Balanced($Heap, read($Heap, r#24, Node.left)) || (read($Heap, r#24, Node.left) != null ==> read($Heap, read($Heap, r#24, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#24, Node.left), Node.balance) == 0 || read($Heap, read($Heap, r#24, Node.left), Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.left)) ==> Node.Balanced($Heap, read($Heap, r#24, Node.left)) || (read($Heap, r#24, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.left), Node.right)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.left)) ==> Node.Balanced($Heap, read($Heap, r#24, Node.left)) || (read($Heap, r#24, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.left), Node.left)));
  free ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.right)) && Node.Balanced($Heap, read($Heap, r#24, Node.right)) && (read($Heap, r#24, Node.right) != null ==> (read($Heap, read($Heap, r#24, Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#24, Node.right), Node.balance) == 0 || read($Heap, read($Heap, r#24, Node.right), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.right), Node.left)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.right)) ==> Node.Balanced($Heap, read($Heap, r#24, Node.right)) || (read($Heap, r#24, Node.right) != null ==> read($Heap, read($Heap, r#24, Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, r#24, Node.right), Node.balance) == 0 || read($Heap, read($Heap, r#24, Node.right), Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.right)) ==> Node.Balanced($Heap, read($Heap, r#24, Node.right)) || (read($Heap, r#24, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.right), Node.right)));
  ensures Node.Balanced#canCall($Heap, read($Heap, r#24, Node.right)) ==> Node.Balanced($Heap, read($Heap, r#24, Node.right)) || (read($Heap, r#24, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, r#24, Node.right), Node.left)));
  ensures Node.Height#2($Heap, r#24) == old(Node.Height#2($Heap, n#23));
  ensures read($Heap, r#24, Node.balance) == 0 - 1 || read($Heap, r#24, Node.balance) == 0 - 2;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#23 || (n#23 != null && $o == read(old($Heap), n#23, Node.right)));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Node.WeakLeftRotation(n#23: ref) returns (r#24: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var a#25: ref where a#25 == null || (read($Heap, a#25, alloc) && dtype(a#25) == class.Node);
  var b#26: ref where b#26 == null || (read($Heap, b#26, alloc) && dtype(b#26) == class.Node);
  var c#27: ref where c#27 == null || (read($Heap, c#27, alloc) && dtype(c#27) == class.Node);
  var $rhs#0: ref;
  var $rhs#1: ref;
  var $rhs#2: ref;
  var a#129: ref;
  var b#130: ref;
  var x#131: ref;
  var d#132: int;
  var a#133: ref;
  var b#134: ref;
  var x#135: ref;
  var d#136: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#23 || (n#23 != null && $o == read($Heap, n#23, Node.right)));
    // ----- assignment statement ----- AVLTree.dfy(269,9)
    assume true;
    assert n#23 != null;
    assume true;
    r#24 := read($Heap, n#23, Node.right);
    assume {:captureState "AVLTree.dfy(269,9)"} true;
    // ----- assert statement ----- AVLTree.dfy(270,7)
    assert {:subsumption 0} n#23 != null;
    assert {:subsumption 0} r#24 != null;
    assert {:subsumption 0} n#23 != null;
    assert {:subsumption 0} n#23 != null;
    if (read($Heap, n#23, Node.left) != null)
    {
        assert {:subsumption 0} n#23 != null;
        assert {:subsumption 0} read($Heap, n#23, Node.left) != null;
    }
    else
    {
    }

    assume (read($Heap, n#23, Node.left) != null ==> true) && (read($Heap, n#23, Node.left) == null ==> true);
    assert Set#Equal(read($Heap, n#23, Node.Contents), Set#Union(Set#Union(read($Heap, r#24, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#23, Node.value)))), (if read($Heap, n#23, Node.left) != null then read($Heap, read($Heap, n#23, Node.left), Node.Contents) else Set#Empty(): Set BoxType)));
    // ----- var-declaration statement ----- AVLTree.dfy(271,11)
    // ----- var-declaration statement ----- AVLTree.dfy(271,14)
    // ----- var-declaration statement ----- AVLTree.dfy(271,17)
    // ----- update statement ----- AVLTree.dfy(271,19)
    assume true;
    assume true;
    assume true;
    assert n#23 != null;
    assume true;
    $rhs#0 := read($Heap, n#23, Node.left);
    assert r#24 != null;
    assume true;
    $rhs#1 := read($Heap, r#24, Node.left);
    assert r#24 != null;
    assume true;
    $rhs#2 := read($Heap, r#24, Node.right);
    a#25 := $rhs#0;
    b#26 := $rhs#1;
    c#27 := $rhs#2;
    assume {:captureState "AVLTree.dfy(271,19)"} true;
    // ----- call statement ----- AVLTree.dfy(272,7)
    assume true;
    a#129 := a#25;
    assume true;
    b#130 := b#26;
    assume true;
    x#131 := n#23;
    assert r#24 != null;
    if (read($Heap, r#24, Node.balance) == 1)
    {
    }
    else
    {
    }

    assume (read($Heap, r#24, Node.balance) == 1 ==> true) && (read($Heap, r#24, Node.balance) != 1 ==> true);
    d#132 := (if read($Heap, r#24, Node.balance) == 1 then 0 - 1 else 0);
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#131 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#129, b#130, x#131, d#132);
    assume {:captureState "AVLTree.dfy(272,7)"} true;
    // ----- call statement ----- AVLTree.dfy(273,7)
    assume true;
    a#133 := n#23;
    assume true;
    b#134 := c#27;
    assume true;
    x#135 := r#24;
    assert r#24 != null;
    if (read($Heap, r#24, Node.balance) == 0 - 1)
    {
    }
    else
    {
    }

    assume (read($Heap, r#24, Node.balance) == 0 - 1 ==> true) && (read($Heap, r#24, Node.balance) != 0 - 1 ==> true);
    d#136 := (if read($Heap, r#24, Node.balance) == 0 - 1 then 0 - 2 else 0 - 1);
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#135 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#133, b#134, x#135, d#136);
    assume {:captureState "AVLTree.dfy(273,7)"} true;
}



procedure CheckWellformed$$Node.StrongRightRotation(n#28: ref where n#28 == null || (read($Heap, n#28, alloc) && dtype(n#28) == class.Node)) returns (r#29: ref where r#29 == null || (read($Heap, r#29, alloc) && dtype(r#29) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Node.StrongRightRotation(n#28: ref) returns (r#29: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#137: ref;
  var n#138: ref;
  var n#139: ref;
  var n#140: ref;
  var n#141: ref;
  var n#142: ref;
  var n#143: ref;
  var n#144: ref;
  var n#145: ref;
  var n#146: ref;
  var n#147: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#28 || (n#28 != null && $o == read($Heap, n#28, Node.left)));
    if (n#28 != null)
    {
        assert n#28 != null;
    }

    assume n#28 != null && read($Heap, n#28, Node.left) != null;
    n#137 := n#28;
    assume Node.Valid#canCall($Heap, n#28);
    if (Node.Valid($Heap, n#28))
    {
        n#138 := n#28;
        assert Node.Valid($Heap, n#138);
        assume Node.BalanceValid#canCall($Heap, n#28);
    }

    assume Node.Valid($Heap, n#28) && Node.BalanceValid($Heap, n#28);
    assert n#28 != null;
    assume read($Heap, n#28, Node.balance) == 0 - 2;
    assert n#28 != null;
    assert read($Heap, n#28, Node.left) != null;
    if (read($Heap, read($Heap, n#28, Node.left), Node.balance) != 0 - 1)
    {
        assert n#28 != null;
        assert read($Heap, n#28, Node.left) != null;
    }

    assume read($Heap, read($Heap, n#28, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, n#28, Node.left), Node.balance) == 0 - 2;
    assert n#28 != null;
    n#139 := read($Heap, n#28, Node.left);
    assert Node.Valid($Heap, n#139);
    assume Node.BalanceValid#canCall($Heap, read($Heap, n#28, Node.left));
    if (Node.BalanceValid($Heap, read($Heap, n#28, Node.left)))
    {
        assert n#28 != null;
        assert read($Heap, n#28, Node.left) != null;
        n#140 := read($Heap, read($Heap, n#28, Node.left), Node.right);
        assert Node.Valid($Heap, n#140) && Node.BalanceValid($Heap, n#140);
        assume Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right));
    }

    if (Node.BalanceValid($Heap, read($Heap, n#28, Node.left)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)))
    {
        assert n#28 != null;
        assert read($Heap, n#28, Node.left) != null;
        n#141 := read($Heap, read($Heap, n#28, Node.left), Node.left);
        assert Node.Valid($Heap, n#141) && Node.BalanceValid($Heap, n#141);
        assume Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left));
    }

    if (Node.BalanceValid($Heap, read($Heap, n#28, Node.left)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)))
    {
        assert n#28 != null;
        n#142 := read($Heap, n#28, Node.right);
        assert Node.Valid($Heap, n#142) && Node.BalanceValid($Heap, n#142);
        assume Node.Balanced#canCall($Heap, read($Heap, n#28, Node.right));
    }

    assume Node.BalanceValid($Heap, read($Heap, n#28, Node.left)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) && Node.Balanced($Heap, read($Heap, n#28, Node.right));
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#28 || (n#28 != null && $o == read(old($Heap), n#28, Node.left)));
    assume $HeapSucc(old($Heap), $Heap);
    havoc r#29;
    assert n#28 != null;
    if (r#29 == old(read($Heap, n#28, Node.left)))
    {
        assert r#29 != null;
        assert n#28 != null;
    }

    if (r#29 == old(read($Heap, n#28, Node.left)) && Set#Equal(read($Heap, r#29, Node.Contents), old(read($Heap, n#28, Node.Contents))))
    {
        assert r#29 != null;
        assert n#28 != null;
    }

    assume r#29 == old(read($Heap, n#28, Node.left)) && Set#Equal(read($Heap, r#29, Node.Contents), old(read($Heap, n#28, Node.Contents))) && Set#Equal(read($Heap, r#29, Node.Repr), old(read($Heap, n#28, Node.Repr)));
    n#143 := r#29;
    assume Node.Valid#canCall($Heap, r#29);
    if (Node.Valid($Heap, r#29))
    {
        n#144 := r#29;
        assert Node.Valid($Heap, n#144);
        assume Node.BalanceValid#canCall($Heap, r#29);
    }

    if (Node.Valid($Heap, r#29) && Node.BalanceValid($Heap, r#29))
    {
        n#145 := r#29;
        assert Node.Valid($Heap, n#145) && Node.BalanceValid($Heap, n#145);
        assume Node.Balanced#canCall($Heap, r#29);
    }

    assume Node.Valid($Heap, r#29) && Node.BalanceValid($Heap, r#29) && Node.Balanced($Heap, r#29);
    n#146 := r#29;
    assert Node.Valid($Heap, n#146);
    assume Node.Height#canCall($Heap, r#29);
    n#147 := n#28;
    assert n#28 == null || (read(old($Heap), n#28, alloc) && dtype(n#28) == class.Node);
    assert Node.Valid(old($Heap), n#147);
    assume Node.Height#canCall(old($Heap), n#28);
    assume Node.Height($Heap, r#29) + 1 == old(Node.Height($Heap, n#28));
    assert r#29 != null;
    assume read($Heap, r#29, Node.balance) == 0;
}



procedure Node.StrongRightRotation(n#28: ref where n#28 == null || (read($Heap, n#28, alloc) && dtype(n#28) == class.Node)) returns (r#29: ref where r#29 == null || (read($Heap, r#29, alloc) && dtype(r#29) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires n#28 != null;
  requires read($Heap, n#28, Node.left) != null;
  free requires Node.Valid#canCall($Heap, n#28) && Node.Valid($Heap, n#28) && (n#28 != null ==> read($Heap, n#28, Node.Repr)[$Box(n#28)] && !read($Heap, n#28, Node.Repr)[$Box(null)] && (read($Heap, n#28, Node.left) != null ==> read($Heap, n#28, Node.Repr)[$Box(read($Heap, n#28, Node.left))] && !read($Heap, read($Heap, n#28, Node.left), Node.Repr)[$Box(n#28)] && Set#Subset(read($Heap, read($Heap, n#28, Node.left), Node.Repr), read($Heap, n#28, Node.Repr))) && (read($Heap, n#28, Node.right) != null ==> read($Heap, n#28, Node.Repr)[$Box(read($Heap, n#28, Node.right))] && !read($Heap, read($Heap, n#28, Node.right), Node.Repr)[$Box(n#28)] && Set#Subset(read($Heap, read($Heap, n#28, Node.right), Node.Repr), read($Heap, n#28, Node.Repr))) && Node.Valid($Heap, read($Heap, n#28, Node.left)) && Node.Valid($Heap, read($Heap, n#28, Node.right)) && (read($Heap, n#28, Node.right) != null && read($Heap, n#28, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#28, Node.left), Node.Repr), read($Heap, read($Heap, n#28, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#28, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#28)), (if read($Heap, n#28, Node.left) != null then read($Heap, read($Heap, n#28, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#28, Node.right) != null then read($Heap, read($Heap, n#28, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#28, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#28, Node.value))), (if read($Heap, n#28, Node.left) != null then read($Heap, read($Heap, n#28, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#28, Node.right) != null then read($Heap, read($Heap, n#28, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#28, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#28, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#28, Node.value))) && (read($Heap, n#28, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#28, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#28, Node.value) < i#17)));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.Repr)[$Box(n#28)]);
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> !read($Heap, n#28, Node.Repr)[$Box(null)]);
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.left) != null ==> read($Heap, n#28, Node.Repr)[$Box(read($Heap, n#28, Node.left))]);
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.left) != null ==> !read($Heap, read($Heap, n#28, Node.left), Node.Repr)[$Box(n#28)]);
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, n#28, Node.left), Node.Repr), read($Heap, n#28, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.right) != null ==> read($Heap, n#28, Node.Repr)[$Box(read($Heap, n#28, Node.right))]);
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.right) != null ==> !read($Heap, read($Heap, n#28, Node.right), Node.Repr)[$Box(n#28)]);
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, n#28, Node.right), Node.Repr), read($Heap, n#28, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> Node.Valid($Heap, read($Heap, n#28, Node.left)));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> Node.Valid($Heap, read($Heap, n#28, Node.right)));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.right) != null && read($Heap, n#28, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#28, Node.left), Node.Repr), read($Heap, read($Heap, n#28, Node.right), Node.Repr)));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> Set#Equal(read($Heap, n#28, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#28)), (if read($Heap, n#28, Node.left) != null then read($Heap, read($Heap, n#28, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#28, Node.right) != null then read($Heap, read($Heap, n#28, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> Set#Equal(read($Heap, n#28, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#28, Node.value))), (if read($Heap, n#28, Node.left) != null then read($Heap, read($Heap, n#28, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#28, Node.right) != null then read($Heap, read($Heap, n#28, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#28, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#28, Node.value)));
  requires Node.Valid#canCall($Heap, n#28) ==> Node.Valid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#28, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#28, Node.value) < i#17));
  free requires Node.BalanceValid#canCall($Heap, n#28) && Node.BalanceValid($Heap, n#28) && (n#28 != null ==> read($Heap, n#28, Node.balance) == Node.Height($Heap, read($Heap, n#28, Node.right)) - Node.Height($Heap, read($Heap, n#28, Node.left)) && (read($Heap, n#28, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#28, Node.left))) && (read($Heap, n#28, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#28, Node.right))));
  requires Node.BalanceValid#canCall($Heap, n#28) ==> Node.BalanceValid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.balance) == Node.Height($Heap, read($Heap, n#28, Node.right)) - Node.Height($Heap, read($Heap, n#28, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#28) ==> Node.BalanceValid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#28, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#28) ==> Node.BalanceValid($Heap, n#28) || (n#28 != null ==> read($Heap, n#28, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#28, Node.right)));
  requires read($Heap, n#28, Node.balance) == 0 - 2;
  requires read($Heap, read($Heap, n#28, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, n#28, Node.left), Node.balance) == 0 - 2;
  free requires Node.BalanceValid#canCall($Heap, read($Heap, n#28, Node.left)) && Node.BalanceValid($Heap, read($Heap, n#28, Node.left)) && (read($Heap, n#28, Node.left) != null ==> read($Heap, read($Heap, n#28, Node.left), Node.balance) == Node.Height($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) - Node.Height($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) && (read($Heap, read($Heap, n#28, Node.left), Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left))) && (read($Heap, read($Heap, n#28, Node.left), Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right))));
  requires Node.BalanceValid#canCall($Heap, read($Heap, n#28, Node.left)) ==> Node.BalanceValid($Heap, read($Heap, n#28, Node.left)) || (read($Heap, n#28, Node.left) != null ==> read($Heap, read($Heap, n#28, Node.left), Node.balance) == Node.Height($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) - Node.Height($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)));
  requires Node.BalanceValid#canCall($Heap, read($Heap, n#28, Node.left)) ==> Node.BalanceValid($Heap, read($Heap, n#28, Node.left)) || (read($Heap, n#28, Node.left) != null ==> read($Heap, read($Heap, n#28, Node.left), Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)));
  requires Node.BalanceValid#canCall($Heap, read($Heap, n#28, Node.left)) ==> Node.BalanceValid($Heap, read($Heap, n#28, Node.left)) || (read($Heap, n#28, Node.left) != null ==> read($Heap, read($Heap, n#28, Node.left), Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)));
  free requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) && (read($Heap, read($Heap, n#28, Node.left), Node.right) != null ==> (read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.left)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) || (read($Heap, read($Heap, n#28, Node.left), Node.right) != null ==> read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) || (read($Heap, read($Heap, n#28, Node.left), Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.right)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right)) || (read($Heap, read($Heap, n#28, Node.left), Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.right), Node.left)));
  free requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) && (read($Heap, read($Heap, n#28, Node.left), Node.left) != null ==> (read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.left)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) || (read($Heap, read($Heap, n#28, Node.left), Node.left) != null ==> read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) || (read($Heap, read($Heap, n#28, Node.left), Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.right)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left)) || (read($Heap, read($Heap, n#28, Node.left), Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#28, Node.left), Node.left), Node.left)));
  free requires Node.Balanced#canCall($Heap, read($Heap, n#28, Node.right)) && Node.Balanced($Heap, read($Heap, n#28, Node.right)) && (read($Heap, n#28, Node.right) != null ==> (read($Heap, read($Heap, n#28, Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, n#28, Node.right), Node.balance) == 0 || read($Heap, read($Heap, n#28, Node.right), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.right), Node.left)));
  requires Node.Balanced#canCall($Heap, read($Heap, n#28, Node.right)) ==> Node.Balanced($Heap, read($Heap, n#28, Node.right)) || (read($Heap, n#28, Node.right) != null ==> read($Heap, read($Heap, n#28, Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, n#28, Node.right), Node.balance) == 0 || read($Heap, read($Heap, n#28, Node.right), Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, read($Heap, n#28, Node.right)) ==> Node.Balanced($Heap, read($Heap, n#28, Node.right)) || (read($Heap, n#28, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.right), Node.right)));
  requires Node.Balanced#canCall($Heap, read($Heap, n#28, Node.right)) ==> Node.Balanced($Heap, read($Heap, n#28, Node.right)) || (read($Heap, n#28, Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, n#28, Node.right), Node.left)));
  modifies $Heap, $Tick;
  ensures r#29 == old(read($Heap, n#28, Node.left));
  ensures Set#Equal(read($Heap, r#29, Node.Contents), old(read($Heap, n#28, Node.Contents)));
  ensures Set#Equal(read($Heap, r#29, Node.Repr), old(read($Heap, n#28, Node.Repr)));
  free ensures Node.Valid#canCall($Heap, r#29) && Node.Valid($Heap, r#29) && (r#29 != null ==> read($Heap, r#29, Node.Repr)[$Box(r#29)] && !read($Heap, r#29, Node.Repr)[$Box(null)] && (read($Heap, r#29, Node.left) != null ==> read($Heap, r#29, Node.Repr)[$Box(read($Heap, r#29, Node.left))] && !read($Heap, read($Heap, r#29, Node.left), Node.Repr)[$Box(r#29)] && Set#Subset(read($Heap, read($Heap, r#29, Node.left), Node.Repr), read($Heap, r#29, Node.Repr))) && (read($Heap, r#29, Node.right) != null ==> read($Heap, r#29, Node.Repr)[$Box(read($Heap, r#29, Node.right))] && !read($Heap, read($Heap, r#29, Node.right), Node.Repr)[$Box(r#29)] && Set#Subset(read($Heap, read($Heap, r#29, Node.right), Node.Repr), read($Heap, r#29, Node.Repr))) && Node.Valid($Heap, read($Heap, r#29, Node.left)) && Node.Valid($Heap, read($Heap, r#29, Node.right)) && (read($Heap, r#29, Node.right) != null && read($Heap, r#29, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#29, Node.left), Node.Repr), read($Heap, read($Heap, r#29, Node.right), Node.Repr))) && Set#Equal(read($Heap, r#29, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#29)), (if read($Heap, r#29, Node.left) != null then read($Heap, read($Heap, r#29, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#29, Node.right) != null then read($Heap, read($Heap, r#29, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, r#29, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#29, Node.value))), (if read($Heap, r#29, Node.left) != null then read($Heap, read($Heap, r#29, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#29, Node.right) != null then read($Heap, read($Heap, r#29, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, r#29, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#29, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#29, Node.value))) && (read($Heap, r#29, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#29, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#29, Node.value) < i#17)));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.Repr)[$Box(r#29)]);
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> !read($Heap, r#29, Node.Repr)[$Box(null)]);
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.left) != null ==> read($Heap, r#29, Node.Repr)[$Box(read($Heap, r#29, Node.left))]);
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.left) != null ==> !read($Heap, read($Heap, r#29, Node.left), Node.Repr)[$Box(r#29)]);
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, r#29, Node.left), Node.Repr), read($Heap, r#29, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.right) != null ==> read($Heap, r#29, Node.Repr)[$Box(read($Heap, r#29, Node.right))]);
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.right) != null ==> !read($Heap, read($Heap, r#29, Node.right), Node.Repr)[$Box(r#29)]);
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, r#29, Node.right), Node.Repr), read($Heap, r#29, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> Node.Valid($Heap, read($Heap, r#29, Node.left)));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> Node.Valid($Heap, read($Heap, r#29, Node.right)));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.right) != null && read($Heap, r#29, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#29, Node.left), Node.Repr), read($Heap, read($Heap, r#29, Node.right), Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> Set#Equal(read($Heap, r#29, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#29)), (if read($Heap, r#29, Node.left) != null then read($Heap, read($Heap, r#29, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#29, Node.right) != null then read($Heap, read($Heap, r#29, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> Set#Equal(read($Heap, r#29, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#29, Node.value))), (if read($Heap, r#29, Node.left) != null then read($Heap, read($Heap, r#29, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#29, Node.right) != null then read($Heap, read($Heap, r#29, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#29, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#29, Node.value)));
  ensures Node.Valid#canCall($Heap, r#29) ==> Node.Valid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#29, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#29, Node.value) < i#17));
  free ensures Node.BalanceValid#canCall($Heap, r#29) && Node.BalanceValid($Heap, r#29) && (r#29 != null ==> read($Heap, r#29, Node.balance) == Node.Height($Heap, read($Heap, r#29, Node.right)) - Node.Height($Heap, read($Heap, r#29, Node.left)) && (read($Heap, r#29, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#29, Node.left))) && (read($Heap, r#29, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#29, Node.right))));
  ensures Node.BalanceValid#canCall($Heap, r#29) ==> Node.BalanceValid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.balance) == Node.Height($Heap, read($Heap, r#29, Node.right)) - Node.Height($Heap, read($Heap, r#29, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#29) ==> Node.BalanceValid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#29, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#29) ==> Node.BalanceValid($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#29, Node.right)));
  free ensures Node.Balanced#canCall($Heap, r#29) && Node.Balanced($Heap, r#29) && (r#29 != null ==> (read($Heap, r#29, Node.balance) == 0 - 1 || read($Heap, r#29, Node.balance) == 0 || read($Heap, r#29, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, r#29, Node.right)) && Node.Balanced($Heap, read($Heap, r#29, Node.left)));
  ensures Node.Balanced#canCall($Heap, r#29) ==> Node.Balanced($Heap, r#29) || (r#29 != null ==> read($Heap, r#29, Node.balance) == 0 - 1 || read($Heap, r#29, Node.balance) == 0 || read($Heap, r#29, Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, r#29) ==> Node.Balanced($Heap, r#29) || (r#29 != null ==> Node.Balanced($Heap, read($Heap, r#29, Node.right)));
  ensures Node.Balanced#canCall($Heap, r#29) ==> Node.Balanced($Heap, r#29) || (r#29 != null ==> Node.Balanced($Heap, read($Heap, r#29, Node.left)));
  ensures Node.Height#2($Heap, r#29) + 1 == old(Node.Height#2($Heap, n#28));
  ensures read($Heap, r#29, Node.balance) == 0;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#28 || (n#28 != null && $o == read(old($Heap), n#28, Node.left)));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Node.StrongRightRotation(n#28: ref) returns (r#29: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var a#30: ref where a#30 == null || (read($Heap, a#30, alloc) && dtype(a#30) == class.Node);
  var b#31: ref where b#31 == null || (read($Heap, b#31, alloc) && dtype(b#31) == class.Node);
  var c#32: ref where c#32 == null || (read($Heap, c#32, alloc) && dtype(c#32) == class.Node);
  var $rhs#0: ref;
  var $rhs#1: ref;
  var $rhs#2: ref;
  var a#148: ref;
  var b#149: ref;
  var x#150: ref;
  var d#151: int;
  var a#152: ref;
  var b#153: ref;
  var x#154: ref;
  var d#155: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#28 || (n#28 != null && $o == read($Heap, n#28, Node.left)));
    // ----- assignment statement ----- AVLTree.dfy(290,9)
    assume true;
    assert n#28 != null;
    assume true;
    r#29 := read($Heap, n#28, Node.left);
    assume {:captureState "AVLTree.dfy(290,9)"} true;
    // ----- assert statement ----- AVLTree.dfy(291,7)
    assert {:subsumption 0} n#28 != null;
    assert {:subsumption 0} r#29 != null;
    assert {:subsumption 0} n#28 != null;
    assert {:subsumption 0} n#28 != null;
    if (read($Heap, n#28, Node.right) != null)
    {
        assert {:subsumption 0} n#28 != null;
        assert {:subsumption 0} read($Heap, n#28, Node.right) != null;
    }
    else
    {
    }

    assume (read($Heap, n#28, Node.right) != null ==> true) && (read($Heap, n#28, Node.right) == null ==> true);
    assert Set#Equal(read($Heap, n#28, Node.Contents), Set#Union(Set#Union(read($Heap, r#29, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#28, Node.value)))), (if read($Heap, n#28, Node.right) != null then read($Heap, read($Heap, n#28, Node.right), Node.Contents) else Set#Empty(): Set BoxType)));
    // ----- var-declaration statement ----- AVLTree.dfy(292,11)
    // ----- var-declaration statement ----- AVLTree.dfy(292,14)
    // ----- var-declaration statement ----- AVLTree.dfy(292,17)
    // ----- update statement ----- AVLTree.dfy(292,19)
    assume true;
    assume true;
    assume true;
    assert r#29 != null;
    assume true;
    $rhs#0 := read($Heap, r#29, Node.left);
    assert r#29 != null;
    assume true;
    $rhs#1 := read($Heap, r#29, Node.right);
    assert n#28 != null;
    assume true;
    $rhs#2 := read($Heap, n#28, Node.right);
    a#30 := $rhs#0;
    b#31 := $rhs#1;
    c#32 := $rhs#2;
    assume {:captureState "AVLTree.dfy(292,19)"} true;
    // ----- call statement ----- AVLTree.dfy(293,7)
    assume true;
    a#148 := b#31;
    assume true;
    b#149 := c#32;
    assume true;
    x#150 := n#28;
    assert r#29 != null;
    if (read($Heap, r#29, Node.balance) == 0 - 2)
    {
    }
    else
    {
    }

    assume (read($Heap, r#29, Node.balance) == 0 - 2 ==> true) && (read($Heap, r#29, Node.balance) != 0 - 2 ==> true);
    d#151 := (if read($Heap, r#29, Node.balance) == 0 - 2 then 1 else 0);
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#150 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#148, b#149, x#150, d#151);
    assume {:captureState "AVLTree.dfy(293,7)"} true;
    // ----- call statement ----- AVLTree.dfy(294,7)
    assume true;
    a#152 := a#30;
    assume true;
    b#153 := n#28;
    assume true;
    x#154 := r#29;
    assume true;
    d#155 := 0;
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#154 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#152, b#153, x#154, d#155);
    assume {:captureState "AVLTree.dfy(294,7)"} true;
}



procedure CheckWellformed$$Node.StrongLeftRotation(n#33: ref where n#33 == null || (read($Heap, n#33, alloc) && dtype(n#33) == class.Node)) returns (r#34: ref where r#34 == null || (read($Heap, r#34, alloc) && dtype(r#34) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Node.StrongLeftRotation(n#33: ref) returns (r#34: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#156: ref;
  var n#157: ref;
  var n#158: ref;
  var n#159: ref;
  var n#160: ref;
  var n#161: ref;
  var n#162: ref;
  var n#163: ref;
  var n#164: ref;
  var n#165: ref;
  var n#166: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#33 || (n#33 != null && $o == read($Heap, n#33, Node.right)));
    if (n#33 != null)
    {
        assert n#33 != null;
    }

    assume n#33 != null && read($Heap, n#33, Node.right) != null;
    n#156 := n#33;
    assume Node.Valid#canCall($Heap, n#33);
    if (Node.Valid($Heap, n#33))
    {
        n#157 := n#33;
        assert Node.Valid($Heap, n#157);
        assume Node.BalanceValid#canCall($Heap, n#33);
    }

    assume Node.Valid($Heap, n#33) && Node.BalanceValid($Heap, n#33);
    assert n#33 != null;
    assume read($Heap, n#33, Node.balance) == 2;
    assert n#33 != null;
    assert read($Heap, n#33, Node.right) != null;
    if (read($Heap, read($Heap, n#33, Node.right), Node.balance) != 1)
    {
        assert n#33 != null;
        assert read($Heap, n#33, Node.right) != null;
    }

    assume read($Heap, read($Heap, n#33, Node.right), Node.balance) == 1 || read($Heap, read($Heap, n#33, Node.right), Node.balance) == 2;
    assert n#33 != null;
    n#158 := read($Heap, n#33, Node.right);
    assert Node.Valid($Heap, n#158);
    assume Node.BalanceValid#canCall($Heap, read($Heap, n#33, Node.right));
    if (Node.BalanceValid($Heap, read($Heap, n#33, Node.right)))
    {
        assert n#33 != null;
        assert read($Heap, n#33, Node.right) != null;
        n#159 := read($Heap, read($Heap, n#33, Node.right), Node.right);
        assert Node.Valid($Heap, n#159) && Node.BalanceValid($Heap, n#159);
        assume Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right));
    }

    if (Node.BalanceValid($Heap, read($Heap, n#33, Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)))
    {
        assert n#33 != null;
        assert read($Heap, n#33, Node.right) != null;
        n#160 := read($Heap, read($Heap, n#33, Node.right), Node.left);
        assert Node.Valid($Heap, n#160) && Node.BalanceValid($Heap, n#160);
        assume Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left));
    }

    if (Node.BalanceValid($Heap, read($Heap, n#33, Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)))
    {
        assert n#33 != null;
        n#161 := read($Heap, n#33, Node.left);
        assert Node.Valid($Heap, n#161) && Node.BalanceValid($Heap, n#161);
        assume Node.Balanced#canCall($Heap, read($Heap, n#33, Node.left));
    }

    assume Node.BalanceValid($Heap, read($Heap, n#33, Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) && Node.Balanced($Heap, read($Heap, n#33, Node.left));
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#33 || (n#33 != null && $o == read(old($Heap), n#33, Node.right)));
    assume $HeapSucc(old($Heap), $Heap);
    havoc r#34;
    assert n#33 != null;
    if (r#34 == old(read($Heap, n#33, Node.right)))
    {
        assert r#34 != null;
        assert n#33 != null;
    }

    if (r#34 == old(read($Heap, n#33, Node.right)) && Set#Equal(read($Heap, r#34, Node.Contents), old(read($Heap, n#33, Node.Contents))))
    {
        assert r#34 != null;
        assert n#33 != null;
    }

    assume r#34 == old(read($Heap, n#33, Node.right)) && Set#Equal(read($Heap, r#34, Node.Contents), old(read($Heap, n#33, Node.Contents))) && Set#Equal(read($Heap, r#34, Node.Repr), old(read($Heap, n#33, Node.Repr)));
    n#162 := r#34;
    assume Node.Valid#canCall($Heap, r#34);
    if (Node.Valid($Heap, r#34))
    {
        n#163 := r#34;
        assert Node.Valid($Heap, n#163);
        assume Node.BalanceValid#canCall($Heap, r#34);
    }

    if (Node.Valid($Heap, r#34) && Node.BalanceValid($Heap, r#34))
    {
        n#164 := r#34;
        assert Node.Valid($Heap, n#164) && Node.BalanceValid($Heap, n#164);
        assume Node.Balanced#canCall($Heap, r#34);
    }

    assume Node.Valid($Heap, r#34) && Node.BalanceValid($Heap, r#34) && Node.Balanced($Heap, r#34);
    n#165 := r#34;
    assert Node.Valid($Heap, n#165);
    assume Node.Height#canCall($Heap, r#34);
    n#166 := n#33;
    assert n#33 == null || (read(old($Heap), n#33, alloc) && dtype(n#33) == class.Node);
    assert Node.Valid(old($Heap), n#166);
    assume Node.Height#canCall(old($Heap), n#33);
    assume Node.Height($Heap, r#34) + 1 == old(Node.Height($Heap, n#33));
    assert r#34 != null;
    assume read($Heap, r#34, Node.balance) == 0;
}



procedure Node.StrongLeftRotation(n#33: ref where n#33 == null || (read($Heap, n#33, alloc) && dtype(n#33) == class.Node)) returns (r#34: ref where r#34 == null || (read($Heap, r#34, alloc) && dtype(r#34) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires n#33 != null;
  requires read($Heap, n#33, Node.right) != null;
  free requires Node.Valid#canCall($Heap, n#33) && Node.Valid($Heap, n#33) && (n#33 != null ==> read($Heap, n#33, Node.Repr)[$Box(n#33)] && !read($Heap, n#33, Node.Repr)[$Box(null)] && (read($Heap, n#33, Node.left) != null ==> read($Heap, n#33, Node.Repr)[$Box(read($Heap, n#33, Node.left))] && !read($Heap, read($Heap, n#33, Node.left), Node.Repr)[$Box(n#33)] && Set#Subset(read($Heap, read($Heap, n#33, Node.left), Node.Repr), read($Heap, n#33, Node.Repr))) && (read($Heap, n#33, Node.right) != null ==> read($Heap, n#33, Node.Repr)[$Box(read($Heap, n#33, Node.right))] && !read($Heap, read($Heap, n#33, Node.right), Node.Repr)[$Box(n#33)] && Set#Subset(read($Heap, read($Heap, n#33, Node.right), Node.Repr), read($Heap, n#33, Node.Repr))) && Node.Valid($Heap, read($Heap, n#33, Node.left)) && Node.Valid($Heap, read($Heap, n#33, Node.right)) && (read($Heap, n#33, Node.right) != null && read($Heap, n#33, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#33, Node.left), Node.Repr), read($Heap, read($Heap, n#33, Node.right), Node.Repr))) && Set#Equal(read($Heap, n#33, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#33)), (if read($Heap, n#33, Node.left) != null then read($Heap, read($Heap, n#33, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#33, Node.right) != null then read($Heap, read($Heap, n#33, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, n#33, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#33, Node.value))), (if read($Heap, n#33, Node.left) != null then read($Heap, read($Heap, n#33, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#33, Node.right) != null then read($Heap, read($Heap, n#33, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, n#33, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#33, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#33, Node.value))) && (read($Heap, n#33, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#33, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#33, Node.value) < i#17)));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.Repr)[$Box(n#33)]);
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> !read($Heap, n#33, Node.Repr)[$Box(null)]);
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.left) != null ==> read($Heap, n#33, Node.Repr)[$Box(read($Heap, n#33, Node.left))]);
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.left) != null ==> !read($Heap, read($Heap, n#33, Node.left), Node.Repr)[$Box(n#33)]);
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, n#33, Node.left), Node.Repr), read($Heap, n#33, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.right) != null ==> read($Heap, n#33, Node.Repr)[$Box(read($Heap, n#33, Node.right))]);
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.right) != null ==> !read($Heap, read($Heap, n#33, Node.right), Node.Repr)[$Box(n#33)]);
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, n#33, Node.right), Node.Repr), read($Heap, n#33, Node.Repr)));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> Node.Valid($Heap, read($Heap, n#33, Node.left)));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> Node.Valid($Heap, read($Heap, n#33, Node.right)));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.right) != null && read($Heap, n#33, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, n#33, Node.left), Node.Repr), read($Heap, read($Heap, n#33, Node.right), Node.Repr)));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> Set#Equal(read($Heap, n#33, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(n#33)), (if read($Heap, n#33, Node.left) != null then read($Heap, read($Heap, n#33, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, n#33, Node.right) != null then read($Heap, read($Heap, n#33, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> Set#Equal(read($Heap, n#33, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#33, Node.value))), (if read($Heap, n#33, Node.left) != null then read($Heap, read($Heap, n#33, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, n#33, Node.right) != null then read($Heap, read($Heap, n#33, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, n#33, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, n#33, Node.value)));
  requires Node.Valid#canCall($Heap, n#33) ==> Node.Valid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, n#33, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, n#33, Node.value) < i#17));
  free requires Node.BalanceValid#canCall($Heap, n#33) && Node.BalanceValid($Heap, n#33) && (n#33 != null ==> read($Heap, n#33, Node.balance) == Node.Height($Heap, read($Heap, n#33, Node.right)) - Node.Height($Heap, read($Heap, n#33, Node.left)) && (read($Heap, n#33, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#33, Node.left))) && (read($Heap, n#33, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#33, Node.right))));
  requires Node.BalanceValid#canCall($Heap, n#33) ==> Node.BalanceValid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.balance) == Node.Height($Heap, read($Heap, n#33, Node.right)) - Node.Height($Heap, read($Heap, n#33, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#33) ==> Node.BalanceValid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, n#33, Node.left)));
  requires Node.BalanceValid#canCall($Heap, n#33) ==> Node.BalanceValid($Heap, n#33) || (n#33 != null ==> read($Heap, n#33, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, n#33, Node.right)));
  requires read($Heap, n#33, Node.balance) == 2;
  requires read($Heap, read($Heap, n#33, Node.right), Node.balance) == 1 || read($Heap, read($Heap, n#33, Node.right), Node.balance) == 2;
  free requires Node.BalanceValid#canCall($Heap, read($Heap, n#33, Node.right)) && Node.BalanceValid($Heap, read($Heap, n#33, Node.right)) && (read($Heap, n#33, Node.right) != null ==> read($Heap, read($Heap, n#33, Node.right), Node.balance) == Node.Height($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) - Node.Height($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) && (read($Heap, read($Heap, n#33, Node.right), Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left))) && (read($Heap, read($Heap, n#33, Node.right), Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right))));
  requires Node.BalanceValid#canCall($Heap, read($Heap, n#33, Node.right)) ==> Node.BalanceValid($Heap, read($Heap, n#33, Node.right)) || (read($Heap, n#33, Node.right) != null ==> read($Heap, read($Heap, n#33, Node.right), Node.balance) == Node.Height($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) - Node.Height($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)));
  requires Node.BalanceValid#canCall($Heap, read($Heap, n#33, Node.right)) ==> Node.BalanceValid($Heap, read($Heap, n#33, Node.right)) || (read($Heap, n#33, Node.right) != null ==> read($Heap, read($Heap, n#33, Node.right), Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)));
  requires Node.BalanceValid#canCall($Heap, read($Heap, n#33, Node.right)) ==> Node.BalanceValid($Heap, read($Heap, n#33, Node.right)) || (read($Heap, n#33, Node.right) != null ==> read($Heap, read($Heap, n#33, Node.right), Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)));
  free requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) && (read($Heap, read($Heap, n#33, Node.right), Node.right) != null ==> (read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.left)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) || (read($Heap, read($Heap, n#33, Node.right), Node.right) != null ==> read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) || (read($Heap, read($Heap, n#33, Node.right), Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.right)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right)) || (read($Heap, read($Heap, n#33, Node.right), Node.right) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.right), Node.left)));
  free requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) && (read($Heap, read($Heap, n#33, Node.right), Node.left) != null ==> (read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.left)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) || (read($Heap, read($Heap, n#33, Node.right), Node.left) != null ==> read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.balance) == 0 || read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) || (read($Heap, read($Heap, n#33, Node.right), Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.right)));
  requires Node.Balanced#canCall($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left)) || (read($Heap, read($Heap, n#33, Node.right), Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, read($Heap, n#33, Node.right), Node.left), Node.left)));
  free requires Node.Balanced#canCall($Heap, read($Heap, n#33, Node.left)) && Node.Balanced($Heap, read($Heap, n#33, Node.left)) && (read($Heap, n#33, Node.left) != null ==> (read($Heap, read($Heap, n#33, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, n#33, Node.left), Node.balance) == 0 || read($Heap, read($Heap, n#33, Node.left), Node.balance) == 1) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.left), Node.right)) && Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.left), Node.left)));
  requires Node.Balanced#canCall($Heap, read($Heap, n#33, Node.left)) ==> Node.Balanced($Heap, read($Heap, n#33, Node.left)) || (read($Heap, n#33, Node.left) != null ==> read($Heap, read($Heap, n#33, Node.left), Node.balance) == 0 - 1 || read($Heap, read($Heap, n#33, Node.left), Node.balance) == 0 || read($Heap, read($Heap, n#33, Node.left), Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, read($Heap, n#33, Node.left)) ==> Node.Balanced($Heap, read($Heap, n#33, Node.left)) || (read($Heap, n#33, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.left), Node.right)));
  requires Node.Balanced#canCall($Heap, read($Heap, n#33, Node.left)) ==> Node.Balanced($Heap, read($Heap, n#33, Node.left)) || (read($Heap, n#33, Node.left) != null ==> Node.Balanced($Heap, read($Heap, read($Heap, n#33, Node.left), Node.left)));
  modifies $Heap, $Tick;
  ensures r#34 == old(read($Heap, n#33, Node.right));
  ensures Set#Equal(read($Heap, r#34, Node.Contents), old(read($Heap, n#33, Node.Contents)));
  ensures Set#Equal(read($Heap, r#34, Node.Repr), old(read($Heap, n#33, Node.Repr)));
  free ensures Node.Valid#canCall($Heap, r#34) && Node.Valid($Heap, r#34) && (r#34 != null ==> read($Heap, r#34, Node.Repr)[$Box(r#34)] && !read($Heap, r#34, Node.Repr)[$Box(null)] && (read($Heap, r#34, Node.left) != null ==> read($Heap, r#34, Node.Repr)[$Box(read($Heap, r#34, Node.left))] && !read($Heap, read($Heap, r#34, Node.left), Node.Repr)[$Box(r#34)] && Set#Subset(read($Heap, read($Heap, r#34, Node.left), Node.Repr), read($Heap, r#34, Node.Repr))) && (read($Heap, r#34, Node.right) != null ==> read($Heap, r#34, Node.Repr)[$Box(read($Heap, r#34, Node.right))] && !read($Heap, read($Heap, r#34, Node.right), Node.Repr)[$Box(r#34)] && Set#Subset(read($Heap, read($Heap, r#34, Node.right), Node.Repr), read($Heap, r#34, Node.Repr))) && Node.Valid($Heap, read($Heap, r#34, Node.left)) && Node.Valid($Heap, read($Heap, r#34, Node.right)) && (read($Heap, r#34, Node.right) != null && read($Heap, r#34, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#34, Node.left), Node.Repr), read($Heap, read($Heap, r#34, Node.right), Node.Repr))) && Set#Equal(read($Heap, r#34, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#34)), (if read($Heap, r#34, Node.left) != null then read($Heap, read($Heap, r#34, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#34, Node.right) != null then read($Heap, read($Heap, r#34, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, r#34, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#34, Node.value))), (if read($Heap, r#34, Node.left) != null then read($Heap, read($Heap, r#34, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#34, Node.right) != null then read($Heap, read($Heap, r#34, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, r#34, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#34, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#34, Node.value))) && (read($Heap, r#34, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#34, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#34, Node.value) < i#17)));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.Repr)[$Box(r#34)]);
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> !read($Heap, r#34, Node.Repr)[$Box(null)]);
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.left) != null ==> read($Heap, r#34, Node.Repr)[$Box(read($Heap, r#34, Node.left))]);
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.left) != null ==> !read($Heap, read($Heap, r#34, Node.left), Node.Repr)[$Box(r#34)]);
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, r#34, Node.left), Node.Repr), read($Heap, r#34, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.right) != null ==> read($Heap, r#34, Node.Repr)[$Box(read($Heap, r#34, Node.right))]);
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.right) != null ==> !read($Heap, read($Heap, r#34, Node.right), Node.Repr)[$Box(r#34)]);
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, r#34, Node.right), Node.Repr), read($Heap, r#34, Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> Node.Valid($Heap, read($Heap, r#34, Node.left)));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> Node.Valid($Heap, read($Heap, r#34, Node.right)));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.right) != null && read($Heap, r#34, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, r#34, Node.left), Node.Repr), read($Heap, read($Heap, r#34, Node.right), Node.Repr)));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> Set#Equal(read($Heap, r#34, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(r#34)), (if read($Heap, r#34, Node.left) != null then read($Heap, read($Heap, r#34, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, r#34, Node.right) != null then read($Heap, read($Heap, r#34, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> Set#Equal(read($Heap, r#34, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, r#34, Node.value))), (if read($Heap, r#34, Node.left) != null then read($Heap, read($Heap, r#34, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, r#34, Node.right) != null then read($Heap, read($Heap, r#34, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, r#34, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, r#34, Node.value)));
  ensures Node.Valid#canCall($Heap, r#34) ==> Node.Valid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, r#34, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, r#34, Node.value) < i#17));
  free ensures Node.BalanceValid#canCall($Heap, r#34) && Node.BalanceValid($Heap, r#34) && (r#34 != null ==> read($Heap, r#34, Node.balance) == Node.Height($Heap, read($Heap, r#34, Node.right)) - Node.Height($Heap, read($Heap, r#34, Node.left)) && (read($Heap, r#34, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#34, Node.left))) && (read($Heap, r#34, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#34, Node.right))));
  ensures Node.BalanceValid#canCall($Heap, r#34) ==> Node.BalanceValid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.balance) == Node.Height($Heap, read($Heap, r#34, Node.right)) - Node.Height($Heap, read($Heap, r#34, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#34) ==> Node.BalanceValid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, r#34, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, r#34) ==> Node.BalanceValid($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, r#34, Node.right)));
  free ensures Node.Balanced#canCall($Heap, r#34) && Node.Balanced($Heap, r#34) && (r#34 != null ==> (read($Heap, r#34, Node.balance) == 0 - 1 || read($Heap, r#34, Node.balance) == 0 || read($Heap, r#34, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, r#34, Node.right)) && Node.Balanced($Heap, read($Heap, r#34, Node.left)));
  ensures Node.Balanced#canCall($Heap, r#34) ==> Node.Balanced($Heap, r#34) || (r#34 != null ==> read($Heap, r#34, Node.balance) == 0 - 1 || read($Heap, r#34, Node.balance) == 0 || read($Heap, r#34, Node.balance) == 1);
  ensures Node.Balanced#canCall($Heap, r#34) ==> Node.Balanced($Heap, r#34) || (r#34 != null ==> Node.Balanced($Heap, read($Heap, r#34, Node.right)));
  ensures Node.Balanced#canCall($Heap, r#34) ==> Node.Balanced($Heap, r#34) || (r#34 != null ==> Node.Balanced($Heap, read($Heap, r#34, Node.left)));
  ensures Node.Height#2($Heap, r#34) + 1 == old(Node.Height#2($Heap, n#33));
  ensures read($Heap, r#34, Node.balance) == 0;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == n#33 || (n#33 != null && $o == read(old($Heap), n#33, Node.right)));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Node.StrongLeftRotation(n#33: ref) returns (r#34: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var a#35: ref where a#35 == null || (read($Heap, a#35, alloc) && dtype(a#35) == class.Node);
  var b#36: ref where b#36 == null || (read($Heap, b#36, alloc) && dtype(b#36) == class.Node);
  var c#37: ref where c#37 == null || (read($Heap, c#37, alloc) && dtype(c#37) == class.Node);
  var $rhs#0: ref;
  var $rhs#1: ref;
  var $rhs#2: ref;
  var a#167: ref;
  var b#168: ref;
  var x#169: ref;
  var d#170: int;
  var a#171: ref;
  var b#172: ref;
  var x#173: ref;
  var d#174: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == n#33 || (n#33 != null && $o == read($Heap, n#33, Node.right)));
    // ----- assignment statement ----- AVLTree.dfy(311,9)
    assume true;
    assert n#33 != null;
    assume true;
    r#34 := read($Heap, n#33, Node.right);
    assume {:captureState "AVLTree.dfy(311,9)"} true;
    // ----- assert statement ----- AVLTree.dfy(312,7)
    assert {:subsumption 0} n#33 != null;
    assert {:subsumption 0} r#34 != null;
    assert {:subsumption 0} n#33 != null;
    assert {:subsumption 0} n#33 != null;
    if (read($Heap, n#33, Node.left) != null)
    {
        assert {:subsumption 0} n#33 != null;
        assert {:subsumption 0} read($Heap, n#33, Node.left) != null;
    }
    else
    {
    }

    assume (read($Heap, n#33, Node.left) != null ==> true) && (read($Heap, n#33, Node.left) == null ==> true);
    assert Set#Equal(read($Heap, n#33, Node.Contents), Set#Union(Set#Union(read($Heap, r#34, Node.Contents), Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, n#33, Node.value)))), (if read($Heap, n#33, Node.left) != null then read($Heap, read($Heap, n#33, Node.left), Node.Contents) else Set#Empty(): Set BoxType)));
    // ----- var-declaration statement ----- AVLTree.dfy(313,11)
    // ----- var-declaration statement ----- AVLTree.dfy(313,14)
    // ----- var-declaration statement ----- AVLTree.dfy(313,17)
    // ----- update statement ----- AVLTree.dfy(313,19)
    assume true;
    assume true;
    assume true;
    assert n#33 != null;
    assume true;
    $rhs#0 := read($Heap, n#33, Node.left);
    assert r#34 != null;
    assume true;
    $rhs#1 := read($Heap, r#34, Node.left);
    assert r#34 != null;
    assume true;
    $rhs#2 := read($Heap, r#34, Node.right);
    a#35 := $rhs#0;
    b#36 := $rhs#1;
    c#37 := $rhs#2;
    assume {:captureState "AVLTree.dfy(313,19)"} true;
    // ----- call statement ----- AVLTree.dfy(314,7)
    assume true;
    a#167 := a#35;
    assume true;
    b#168 := b#36;
    assume true;
    x#169 := n#33;
    assert r#34 != null;
    if (read($Heap, r#34, Node.balance) == 2)
    {
    }
    else
    {
    }

    assume (read($Heap, r#34, Node.balance) == 2 ==> true) && (read($Heap, r#34, Node.balance) != 2 ==> true);
    d#170 := (if read($Heap, r#34, Node.balance) == 2 then 0 - 1 else 0);
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#169 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#167, b#168, x#169, d#170);
    assume {:captureState "AVLTree.dfy(314,7)"} true;
    // ----- call statement ----- AVLTree.dfy(315,7)
    assume true;
    a#171 := n#33;
    assume true;
    b#172 := c#37;
    assume true;
    x#173 := r#34;
    assume true;
    d#174 := 0;
    assert (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) && $o == x#173 ==> $_Frame[$o, $f]);
    call Node.AssembleSingle(a#171, b#172, x#173, d#174);
    assume {:captureState "AVLTree.dfy(315,7)"} true;
}



procedure CheckWellformed$$Node.AssembleSingle(a#38: ref where a#38 == null || (read($Heap, a#38, alloc) && dtype(a#38) == class.Node), b#39: ref where b#39 == null || (read($Heap, b#39, alloc) && dtype(b#39) == class.Node), x#40: ref where x#40 == null || (read($Heap, x#40, alloc) && dtype(x#40) == class.Node), d#41: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Node.AssembleSingle(a#38: ref, b#39: ref, x#40: ref, d#41: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var n#175: ref;
  var n#176: ref;
  var n#177: ref;
  var n#178: ref;
  var n#179: ref;
  var n#180: ref;
  var i#181: int;
  var i#182: int;
  var n#183: ref;
  var n#184: ref;
  var n#185: ref;
  var n#186: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == x#40);
    assume x#40 != null;
    n#175 := a#38;
    assume Node.Valid#canCall($Heap, a#38);
    if (Node.Valid($Heap, a#38))
    {
        n#176 := b#39;
        assume Node.Valid#canCall($Heap, b#39);
    }

    assume Node.Valid($Heap, a#38) && Node.Valid($Heap, b#39);
    n#177 := a#38;
    assert Node.Valid($Heap, n#177);
    assume Node.BalanceValid#canCall($Heap, a#38);
    if (Node.BalanceValid($Heap, a#38))
    {
        n#178 := b#39;
        assert Node.Valid($Heap, n#178);
        assume Node.BalanceValid#canCall($Heap, b#39);
    }

    assume Node.BalanceValid($Heap, a#38) && Node.BalanceValid($Heap, b#39);
    n#179 := a#38;
    assert Node.Valid($Heap, n#179) && Node.BalanceValid($Heap, n#179);
    assume Node.Balanced#canCall($Heap, a#38);
    if (Node.Balanced($Heap, a#38))
    {
        n#180 := b#39;
        assert Node.Valid($Heap, n#180) && Node.BalanceValid($Heap, n#180);
        assume Node.Balanced#canCall($Heap, b#39);
    }

    assume Node.Balanced($Heap, a#38) && Node.Balanced($Heap, b#39);
    if (a#38 != null)
    {
    }

    if (a#38 != null && b#39 != null)
    {
        assert a#38 != null;
        assert b#39 != null;
    }

    assume a#38 != null && b#39 != null ==> Set#Disjoint(read($Heap, a#38, Node.Repr), read($Heap, b#39, Node.Repr));
    if (a#38 != null)
    {
        assert a#38 != null;
        if (read($Heap, a#38, Node.Contents)[$Box(i#181)])
        {
            assert x#40 != null;
        }
    }

    assume a#38 != null ==> (forall i#42: int :: true ==> read($Heap, a#38, Node.Contents)[$Box(i#42)] ==> i#42 < read($Heap, x#40, Node.value));
    if (b#39 != null)
    {
        assert b#39 != null;
        if (read($Heap, b#39, Node.Contents)[$Box(i#182)])
        {
            assert x#40 != null;
        }
    }

    assume b#39 != null ==> (forall i#43: int :: true ==> read($Heap, b#39, Node.Contents)[$Box(i#43)] ==> read($Heap, x#40, Node.value) < i#43);
    if (a#38 != null)
    {
        assert a#38 != null;
    }

    assume a#38 != null ==> !read($Heap, a#38, Node.Repr)[$Box(x#40)];
    if (b#39 != null)
    {
        assert b#39 != null;
    }

    assume b#39 != null ==> !read($Heap, b#39, Node.Repr)[$Box(x#40)];
    n#183 := b#39;
    assert Node.Valid($Heap, n#183);
    assume Node.Height#canCall($Heap, b#39);
    n#184 := a#38;
    assert Node.Valid($Heap, n#184);
    assume Node.Height#canCall($Heap, a#38);
    assume d#41 == Node.Height($Heap, b#39) - Node.Height($Heap, a#38);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == x#40);
    assume $HeapSucc(old($Heap), $Heap);
    n#185 := x#40;
    assume Node.Valid#canCall($Heap, x#40);
    if (Node.Valid($Heap, x#40))
    {
        n#186 := x#40;
        assert Node.Valid($Heap, n#186);
        assume Node.BalanceValid#canCall($Heap, x#40);
    }

    assume Node.Valid($Heap, x#40) && Node.BalanceValid($Heap, x#40);
    assert x#40 != null;
    assume read($Heap, x#40, Node.balance) == d#41;
    assert x#40 != null;
    assert x#40 != null;
    if (read($Heap, x#40, Node.value) == old(read($Heap, x#40, Node.value)))
    {
        assert x#40 != null;
    }

    if (read($Heap, x#40, Node.value) == old(read($Heap, x#40, Node.value)) && read($Heap, x#40, Node.left) == a#38)
    {
        assert x#40 != null;
    }

    assume read($Heap, x#40, Node.value) == old(read($Heap, x#40, Node.value)) && read($Heap, x#40, Node.left) == a#38 && read($Heap, x#40, Node.right) == b#39;
    assert x#40 != null;
    if (a#38 != null)
    {
        assert a#38 != null;
    }
    else
    {
    }

    if (b#39 != null)
    {
        assert b#39 != null;
    }
    else
    {
    }

    assume Set#Equal(read($Heap, x#40, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(x#40)), (if a#38 != null then read($Heap, a#38, Node.Repr) else Set#Empty(): Set BoxType)), (if b#39 != null then read($Heap, b#39, Node.Repr) else Set#Empty(): Set BoxType)));
    assert x#40 != null;
    assert x#40 != null;
    if (a#38 != null)
    {
        assert a#38 != null;
    }
    else
    {
    }

    if (b#39 != null)
    {
        assert b#39 != null;
    }
    else
    {
    }

    assume Set#Equal(read($Heap, x#40, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, x#40, Node.value))), (if a#38 != null then read($Heap, a#38, Node.Contents) else Set#Empty(): Set BoxType)), (if b#39 != null then read($Heap, b#39, Node.Contents) else Set#Empty(): Set BoxType)));
}



procedure Node.AssembleSingle(a#38: ref where a#38 == null || (read($Heap, a#38, alloc) && dtype(a#38) == class.Node), b#39: ref where b#39 == null || (read($Heap, b#39, alloc) && dtype(b#39) == class.Node), x#40: ref where x#40 == null || (read($Heap, x#40, alloc) && dtype(x#40) == class.Node), d#41: int);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  requires x#40 != null;
  free requires Node.Valid#canCall($Heap, a#38) && Node.Valid($Heap, a#38) && (a#38 != null ==> read($Heap, a#38, Node.Repr)[$Box(a#38)] && !read($Heap, a#38, Node.Repr)[$Box(null)] && (read($Heap, a#38, Node.left) != null ==> read($Heap, a#38, Node.Repr)[$Box(read($Heap, a#38, Node.left))] && !read($Heap, read($Heap, a#38, Node.left), Node.Repr)[$Box(a#38)] && Set#Subset(read($Heap, read($Heap, a#38, Node.left), Node.Repr), read($Heap, a#38, Node.Repr))) && (read($Heap, a#38, Node.right) != null ==> read($Heap, a#38, Node.Repr)[$Box(read($Heap, a#38, Node.right))] && !read($Heap, read($Heap, a#38, Node.right), Node.Repr)[$Box(a#38)] && Set#Subset(read($Heap, read($Heap, a#38, Node.right), Node.Repr), read($Heap, a#38, Node.Repr))) && Node.Valid($Heap, read($Heap, a#38, Node.left)) && Node.Valid($Heap, read($Heap, a#38, Node.right)) && (read($Heap, a#38, Node.right) != null && read($Heap, a#38, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, a#38, Node.left), Node.Repr), read($Heap, read($Heap, a#38, Node.right), Node.Repr))) && Set#Equal(read($Heap, a#38, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(a#38)), (if read($Heap, a#38, Node.left) != null then read($Heap, read($Heap, a#38, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, a#38, Node.right) != null then read($Heap, read($Heap, a#38, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, a#38, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, a#38, Node.value))), (if read($Heap, a#38, Node.left) != null then read($Heap, read($Heap, a#38, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, a#38, Node.right) != null then read($Heap, read($Heap, a#38, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, a#38, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, a#38, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, a#38, Node.value))) && (read($Heap, a#38, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, a#38, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, a#38, Node.value) < i#17)));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.Repr)[$Box(a#38)]);
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> !read($Heap, a#38, Node.Repr)[$Box(null)]);
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.left) != null ==> read($Heap, a#38, Node.Repr)[$Box(read($Heap, a#38, Node.left))]);
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.left) != null ==> !read($Heap, read($Heap, a#38, Node.left), Node.Repr)[$Box(a#38)]);
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, a#38, Node.left), Node.Repr), read($Heap, a#38, Node.Repr)));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.right) != null ==> read($Heap, a#38, Node.Repr)[$Box(read($Heap, a#38, Node.right))]);
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.right) != null ==> !read($Heap, read($Heap, a#38, Node.right), Node.Repr)[$Box(a#38)]);
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, a#38, Node.right), Node.Repr), read($Heap, a#38, Node.Repr)));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> Node.Valid($Heap, read($Heap, a#38, Node.left)));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> Node.Valid($Heap, read($Heap, a#38, Node.right)));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.right) != null && read($Heap, a#38, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, a#38, Node.left), Node.Repr), read($Heap, read($Heap, a#38, Node.right), Node.Repr)));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> Set#Equal(read($Heap, a#38, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(a#38)), (if read($Heap, a#38, Node.left) != null then read($Heap, read($Heap, a#38, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, a#38, Node.right) != null then read($Heap, read($Heap, a#38, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> Set#Equal(read($Heap, a#38, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, a#38, Node.value))), (if read($Heap, a#38, Node.left) != null then read($Heap, read($Heap, a#38, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, a#38, Node.right) != null then read($Heap, read($Heap, a#38, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, a#38, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, a#38, Node.value)));
  requires Node.Valid#canCall($Heap, a#38) ==> Node.Valid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, a#38, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, a#38, Node.value) < i#17));
  free requires Node.Valid#canCall($Heap, b#39) && Node.Valid($Heap, b#39) && (b#39 != null ==> read($Heap, b#39, Node.Repr)[$Box(b#39)] && !read($Heap, b#39, Node.Repr)[$Box(null)] && (read($Heap, b#39, Node.left) != null ==> read($Heap, b#39, Node.Repr)[$Box(read($Heap, b#39, Node.left))] && !read($Heap, read($Heap, b#39, Node.left), Node.Repr)[$Box(b#39)] && Set#Subset(read($Heap, read($Heap, b#39, Node.left), Node.Repr), read($Heap, b#39, Node.Repr))) && (read($Heap, b#39, Node.right) != null ==> read($Heap, b#39, Node.Repr)[$Box(read($Heap, b#39, Node.right))] && !read($Heap, read($Heap, b#39, Node.right), Node.Repr)[$Box(b#39)] && Set#Subset(read($Heap, read($Heap, b#39, Node.right), Node.Repr), read($Heap, b#39, Node.Repr))) && Node.Valid($Heap, read($Heap, b#39, Node.left)) && Node.Valid($Heap, read($Heap, b#39, Node.right)) && (read($Heap, b#39, Node.right) != null && read($Heap, b#39, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, b#39, Node.left), Node.Repr), read($Heap, read($Heap, b#39, Node.right), Node.Repr))) && Set#Equal(read($Heap, b#39, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(b#39)), (if read($Heap, b#39, Node.left) != null then read($Heap, read($Heap, b#39, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, b#39, Node.right) != null then read($Heap, read($Heap, b#39, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, b#39, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, b#39, Node.value))), (if read($Heap, b#39, Node.left) != null then read($Heap, read($Heap, b#39, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, b#39, Node.right) != null then read($Heap, read($Heap, b#39, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, b#39, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, b#39, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, b#39, Node.value))) && (read($Heap, b#39, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, b#39, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, b#39, Node.value) < i#17)));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.Repr)[$Box(b#39)]);
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> !read($Heap, b#39, Node.Repr)[$Box(null)]);
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.left) != null ==> read($Heap, b#39, Node.Repr)[$Box(read($Heap, b#39, Node.left))]);
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.left) != null ==> !read($Heap, read($Heap, b#39, Node.left), Node.Repr)[$Box(b#39)]);
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, b#39, Node.left), Node.Repr), read($Heap, b#39, Node.Repr)));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.right) != null ==> read($Heap, b#39, Node.Repr)[$Box(read($Heap, b#39, Node.right))]);
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.right) != null ==> !read($Heap, read($Heap, b#39, Node.right), Node.Repr)[$Box(b#39)]);
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, b#39, Node.right), Node.Repr), read($Heap, b#39, Node.Repr)));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> Node.Valid($Heap, read($Heap, b#39, Node.left)));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> Node.Valid($Heap, read($Heap, b#39, Node.right)));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.right) != null && read($Heap, b#39, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, b#39, Node.left), Node.Repr), read($Heap, read($Heap, b#39, Node.right), Node.Repr)));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> Set#Equal(read($Heap, b#39, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(b#39)), (if read($Heap, b#39, Node.left) != null then read($Heap, read($Heap, b#39, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, b#39, Node.right) != null then read($Heap, read($Heap, b#39, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> Set#Equal(read($Heap, b#39, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, b#39, Node.value))), (if read($Heap, b#39, Node.left) != null then read($Heap, read($Heap, b#39, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, b#39, Node.right) != null then read($Heap, read($Heap, b#39, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, b#39, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, b#39, Node.value)));
  requires Node.Valid#canCall($Heap, b#39) ==> Node.Valid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, b#39, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, b#39, Node.value) < i#17));
  free requires Node.BalanceValid#canCall($Heap, a#38) && Node.BalanceValid($Heap, a#38) && (a#38 != null ==> read($Heap, a#38, Node.balance) == Node.Height($Heap, read($Heap, a#38, Node.right)) - Node.Height($Heap, read($Heap, a#38, Node.left)) && (read($Heap, a#38, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, a#38, Node.left))) && (read($Heap, a#38, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, a#38, Node.right))));
  requires Node.BalanceValid#canCall($Heap, a#38) ==> Node.BalanceValid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.balance) == Node.Height($Heap, read($Heap, a#38, Node.right)) - Node.Height($Heap, read($Heap, a#38, Node.left)));
  requires Node.BalanceValid#canCall($Heap, a#38) ==> Node.BalanceValid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, a#38, Node.left)));
  requires Node.BalanceValid#canCall($Heap, a#38) ==> Node.BalanceValid($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, a#38, Node.right)));
  free requires Node.BalanceValid#canCall($Heap, b#39) && Node.BalanceValid($Heap, b#39) && (b#39 != null ==> read($Heap, b#39, Node.balance) == Node.Height($Heap, read($Heap, b#39, Node.right)) - Node.Height($Heap, read($Heap, b#39, Node.left)) && (read($Heap, b#39, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, b#39, Node.left))) && (read($Heap, b#39, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, b#39, Node.right))));
  requires Node.BalanceValid#canCall($Heap, b#39) ==> Node.BalanceValid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.balance) == Node.Height($Heap, read($Heap, b#39, Node.right)) - Node.Height($Heap, read($Heap, b#39, Node.left)));
  requires Node.BalanceValid#canCall($Heap, b#39) ==> Node.BalanceValid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, b#39, Node.left)));
  requires Node.BalanceValid#canCall($Heap, b#39) ==> Node.BalanceValid($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, b#39, Node.right)));
  free requires Node.Balanced#canCall($Heap, a#38) && Node.Balanced($Heap, a#38) && (a#38 != null ==> (read($Heap, a#38, Node.balance) == 0 - 1 || read($Heap, a#38, Node.balance) == 0 || read($Heap, a#38, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, a#38, Node.right)) && Node.Balanced($Heap, read($Heap, a#38, Node.left)));
  requires Node.Balanced#canCall($Heap, a#38) ==> Node.Balanced($Heap, a#38) || (a#38 != null ==> read($Heap, a#38, Node.balance) == 0 - 1 || read($Heap, a#38, Node.balance) == 0 || read($Heap, a#38, Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, a#38) ==> Node.Balanced($Heap, a#38) || (a#38 != null ==> Node.Balanced($Heap, read($Heap, a#38, Node.right)));
  requires Node.Balanced#canCall($Heap, a#38) ==> Node.Balanced($Heap, a#38) || (a#38 != null ==> Node.Balanced($Heap, read($Heap, a#38, Node.left)));
  free requires Node.Balanced#canCall($Heap, b#39) && Node.Balanced($Heap, b#39) && (b#39 != null ==> (read($Heap, b#39, Node.balance) == 0 - 1 || read($Heap, b#39, Node.balance) == 0 || read($Heap, b#39, Node.balance) == 1) && Node.Balanced($Heap, read($Heap, b#39, Node.right)) && Node.Balanced($Heap, read($Heap, b#39, Node.left)));
  requires Node.Balanced#canCall($Heap, b#39) ==> Node.Balanced($Heap, b#39) || (b#39 != null ==> read($Heap, b#39, Node.balance) == 0 - 1 || read($Heap, b#39, Node.balance) == 0 || read($Heap, b#39, Node.balance) == 1);
  requires Node.Balanced#canCall($Heap, b#39) ==> Node.Balanced($Heap, b#39) || (b#39 != null ==> Node.Balanced($Heap, read($Heap, b#39, Node.right)));
  requires Node.Balanced#canCall($Heap, b#39) ==> Node.Balanced($Heap, b#39) || (b#39 != null ==> Node.Balanced($Heap, read($Heap, b#39, Node.left)));
  requires a#38 != null && b#39 != null ==> Set#Disjoint(read($Heap, a#38, Node.Repr), read($Heap, b#39, Node.Repr));
  requires a#38 != null ==> (forall i#42: int :: true ==> read($Heap, a#38, Node.Contents)[$Box(i#42)] ==> i#42 < read($Heap, x#40, Node.value));
  requires b#39 != null ==> (forall i#43: int :: true ==> read($Heap, b#39, Node.Contents)[$Box(i#43)] ==> read($Heap, x#40, Node.value) < i#43);
  requires a#38 != null ==> !read($Heap, a#38, Node.Repr)[$Box(x#40)];
  requires b#39 != null ==> !read($Heap, b#39, Node.Repr)[$Box(x#40)];
  requires d#41 == Node.Height#2($Heap, b#39) - Node.Height#2($Heap, a#38);
  modifies $Heap, $Tick;
  free ensures Node.Valid#canCall($Heap, x#40) && Node.Valid($Heap, x#40) && (x#40 != null ==> read($Heap, x#40, Node.Repr)[$Box(x#40)] && !read($Heap, x#40, Node.Repr)[$Box(null)] && (read($Heap, x#40, Node.left) != null ==> read($Heap, x#40, Node.Repr)[$Box(read($Heap, x#40, Node.left))] && !read($Heap, read($Heap, x#40, Node.left), Node.Repr)[$Box(x#40)] && Set#Subset(read($Heap, read($Heap, x#40, Node.left), Node.Repr), read($Heap, x#40, Node.Repr))) && (read($Heap, x#40, Node.right) != null ==> read($Heap, x#40, Node.Repr)[$Box(read($Heap, x#40, Node.right))] && !read($Heap, read($Heap, x#40, Node.right), Node.Repr)[$Box(x#40)] && Set#Subset(read($Heap, read($Heap, x#40, Node.right), Node.Repr), read($Heap, x#40, Node.Repr))) && Node.Valid($Heap, read($Heap, x#40, Node.left)) && Node.Valid($Heap, read($Heap, x#40, Node.right)) && (read($Heap, x#40, Node.right) != null && read($Heap, x#40, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, x#40, Node.left), Node.Repr), read($Heap, read($Heap, x#40, Node.right), Node.Repr))) && Set#Equal(read($Heap, x#40, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(x#40)), (if read($Heap, x#40, Node.left) != null then read($Heap, read($Heap, x#40, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, x#40, Node.right) != null then read($Heap, read($Heap, x#40, Node.right), Node.Repr) else Set#Empty(): Set BoxType))) && Set#Equal(read($Heap, x#40, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, x#40, Node.value))), (if read($Heap, x#40, Node.left) != null then read($Heap, read($Heap, x#40, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, x#40, Node.right) != null then read($Heap, read($Heap, x#40, Node.right), Node.Contents) else Set#Empty(): Set BoxType))) && (read($Heap, x#40, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, x#40, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, x#40, Node.value))) && (read($Heap, x#40, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, x#40, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, x#40, Node.value) < i#17)));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.Repr)[$Box(x#40)]);
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> !read($Heap, x#40, Node.Repr)[$Box(null)]);
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.left) != null ==> read($Heap, x#40, Node.Repr)[$Box(read($Heap, x#40, Node.left))]);
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.left) != null ==> !read($Heap, read($Heap, x#40, Node.left), Node.Repr)[$Box(x#40)]);
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.left) != null ==> Set#Subset(read($Heap, read($Heap, x#40, Node.left), Node.Repr), read($Heap, x#40, Node.Repr)));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.right) != null ==> read($Heap, x#40, Node.Repr)[$Box(read($Heap, x#40, Node.right))]);
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.right) != null ==> !read($Heap, read($Heap, x#40, Node.right), Node.Repr)[$Box(x#40)]);
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.right) != null ==> Set#Subset(read($Heap, read($Heap, x#40, Node.right), Node.Repr), read($Heap, x#40, Node.Repr)));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> Node.Valid($Heap, read($Heap, x#40, Node.left)));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> Node.Valid($Heap, read($Heap, x#40, Node.right)));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.right) != null && read($Heap, x#40, Node.left) != null ==> Set#Disjoint(read($Heap, read($Heap, x#40, Node.left), Node.Repr), read($Heap, read($Heap, x#40, Node.right), Node.Repr)));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> Set#Equal(read($Heap, x#40, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(x#40)), (if read($Heap, x#40, Node.left) != null then read($Heap, read($Heap, x#40, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, x#40, Node.right) != null then read($Heap, read($Heap, x#40, Node.right), Node.Repr) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> Set#Equal(read($Heap, x#40, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, x#40, Node.value))), (if read($Heap, x#40, Node.left) != null then read($Heap, read($Heap, x#40, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, x#40, Node.right) != null then read($Heap, read($Heap, x#40, Node.right), Node.Contents) else Set#Empty(): Set BoxType))));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.left) != null ==> (forall i#16: int :: true ==> read($Heap, read($Heap, x#40, Node.left), Node.Contents)[$Box(i#16)] ==> i#16 < read($Heap, x#40, Node.value)));
  ensures Node.Valid#canCall($Heap, x#40) ==> Node.Valid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.right) != null ==> (forall i#17: int :: true ==> read($Heap, read($Heap, x#40, Node.right), Node.Contents)[$Box(i#17)] ==> read($Heap, x#40, Node.value) < i#17));
  free ensures Node.BalanceValid#canCall($Heap, x#40) && Node.BalanceValid($Heap, x#40) && (x#40 != null ==> read($Heap, x#40, Node.balance) == Node.Height($Heap, read($Heap, x#40, Node.right)) - Node.Height($Heap, read($Heap, x#40, Node.left)) && (read($Heap, x#40, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, x#40, Node.left))) && (read($Heap, x#40, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, x#40, Node.right))));
  ensures Node.BalanceValid#canCall($Heap, x#40) ==> Node.BalanceValid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.balance) == Node.Height($Heap, read($Heap, x#40, Node.right)) - Node.Height($Heap, read($Heap, x#40, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, x#40) ==> Node.BalanceValid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.left) != null ==> Node.BalanceValid($Heap, read($Heap, x#40, Node.left)));
  ensures Node.BalanceValid#canCall($Heap, x#40) ==> Node.BalanceValid($Heap, x#40) || (x#40 != null ==> read($Heap, x#40, Node.right) != null ==> Node.BalanceValid($Heap, read($Heap, x#40, Node.right)));
  ensures read($Heap, x#40, Node.balance) == d#41;
  ensures read($Heap, x#40, Node.value) == old(read($Heap, x#40, Node.value));
  ensures read($Heap, x#40, Node.left) == a#38;
  ensures read($Heap, x#40, Node.right) == b#39;
  ensures Set#Equal(read($Heap, x#40, Node.Repr), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(x#40)), (if a#38 != null then read($Heap, a#38, Node.Repr) else Set#Empty(): Set BoxType)), (if b#39 != null then read($Heap, b#39, Node.Repr) else Set#Empty(): Set BoxType)));
  ensures Set#Equal(read($Heap, x#40, Node.Contents), Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, x#40, Node.value))), (if a#38 != null then read($Heap, a#38, Node.Contents) else Set#Empty(): Set BoxType)), (if b#39 != null then read($Heap, b#39, Node.Contents) else Set#Empty(): Set BoxType)));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == x#40);
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Node.AssembleSingle(a#38: ref, b#39: ref, x#40: ref, d#41: int)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $rhs#0: ref;
  var $rhs#1: ref;
  var $rhs#2: Set BoxType;
  var $rhs#3: Set BoxType;
  var $rhs#4: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == x#40);
    // ----- assignment statement ----- AVLTree.dfy(342,14)
    assert x#40 != null;
    assume true;
    assert $_Frame[x#40, Node.left];
    assume true;
    $rhs#0 := a#38;
    $Heap := update($Heap, x#40, Node.left, $rhs#0);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(342,14)"} true;
    // ----- assignment statement ----- AVLTree.dfy(343,15)
    assert x#40 != null;
    assume true;
    assert $_Frame[x#40, Node.right];
    assume true;
    $rhs#1 := b#39;
    $Heap := update($Heap, x#40, Node.right, $rhs#1);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(343,15)"} true;
    // ----- assignment statement ----- AVLTree.dfy(344,18)
    assert x#40 != null;
    assume true;
    assert $_Frame[x#40, Node.Contents];
    assert x#40 != null;
    assert x#40 != null;
    if (read($Heap, x#40, Node.left) != null)
    {
        assert x#40 != null;
        assert read($Heap, x#40, Node.left) != null;
    }
    else
    {
    }

    assert x#40 != null;
    if (read($Heap, x#40, Node.right) != null)
    {
        assert x#40 != null;
        assert read($Heap, x#40, Node.right) != null;
    }
    else
    {
    }

    assume (read($Heap, x#40, Node.left) != null ==> true) && (read($Heap, x#40, Node.left) == null ==> true) && (read($Heap, x#40, Node.right) != null ==> true) && (read($Heap, x#40, Node.right) == null ==> true);
    $rhs#2 := Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(read($Heap, x#40, Node.value))), (if read($Heap, x#40, Node.left) != null then read($Heap, read($Heap, x#40, Node.left), Node.Contents) else Set#Empty(): Set BoxType)), (if read($Heap, x#40, Node.right) != null then read($Heap, read($Heap, x#40, Node.right), Node.Contents) else Set#Empty(): Set BoxType));
    $Heap := update($Heap, x#40, Node.Contents, $rhs#2);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(344,18)"} true;
    // ----- assignment statement ----- AVLTree.dfy(346,14)
    assert x#40 != null;
    assume true;
    assert $_Frame[x#40, Node.Repr];
    assert x#40 != null;
    if (read($Heap, x#40, Node.left) != null)
    {
        assert x#40 != null;
        assert read($Heap, x#40, Node.left) != null;
    }
    else
    {
    }

    assert x#40 != null;
    if (read($Heap, x#40, Node.right) != null)
    {
        assert x#40 != null;
        assert read($Heap, x#40, Node.right) != null;
    }
    else
    {
    }

    assume (read($Heap, x#40, Node.left) != null ==> true) && (read($Heap, x#40, Node.left) == null ==> true) && (read($Heap, x#40, Node.right) != null ==> true) && (read($Heap, x#40, Node.right) == null ==> true);
    $rhs#3 := Set#Union(Set#Union(Set#UnionOne(Set#Empty(): Set BoxType, $Box(x#40)), (if read($Heap, x#40, Node.left) != null then read($Heap, read($Heap, x#40, Node.left), Node.Repr) else Set#Empty(): Set BoxType)), (if read($Heap, x#40, Node.right) != null then read($Heap, read($Heap, x#40, Node.right), Node.Repr) else Set#Empty(): Set BoxType));
    $Heap := update($Heap, x#40, Node.Repr, $rhs#3);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(346,14)"} true;
    // ----- assignment statement ----- AVLTree.dfy(348,17)
    assert x#40 != null;
    assume true;
    assert $_Frame[x#40, Node.balance];
    assume true;
    $rhs#4 := d#41;
    $Heap := update($Heap, x#40, Node.balance, $rhs#4);
    assume $IsGoodHeap($Heap);
    assume {:captureState "AVLTree.dfy(348,17)"} true;
}



const unique class.Math: ClassName;

function Math.max($heap: HeapType, a#44: int, b#45: int) : int;

function Math.max#limited($heap: HeapType, a#44: int, b#45: int) : int;

function Math.max#2($heap: HeapType, a#44: int, b#45: int) : int;

function Math.max#canCall($heap: HeapType, a#44: int, b#45: int) : bool;

axiom (forall $Heap: HeapType, a#44: int, b#45: int :: { Math.max#2($Heap, a#44, b#45) } Math.max#2($Heap, a#44, b#45) == Math.max($Heap, a#44, b#45));

axiom (forall $Heap: HeapType, a#44: int, b#45: int :: { Math.max($Heap, a#44, b#45) } Math.max($Heap, a#44, b#45) == Math.max#limited($Heap, a#44, b#45));

// definition axiom for Math.max
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (3 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, a#44: int, b#45: int :: { Math.max($Heap, a#44, b#45) } Math.max#canCall($Heap, a#44, b#45) || ((0 != $ModuleContextHeight || 3 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && 0 <= a#44 && 0 <= b#45) ==> (a#44 < b#45 ==> true) && (a#44 >= b#45 ==> true) && Math.max($Heap, a#44, b#45) == (if a#44 < b#45 then b#45 else a#44) && (a#44 == b#45 ==> Math.max#limited($Heap, a#44, b#45) == a#44 && a#44 == b#45) && a#44 <= Math.max#limited($Heap, a#44, b#45) && b#45 <= Math.max#limited($Heap, a#44, b#45) && 0 <= Math.max($Heap, a#44, b#45));

// definition axiom for Math.max#2
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (3 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, a#44: int, b#45: int :: { Math.max#2($Heap, a#44, b#45) } Math.max#canCall($Heap, a#44, b#45) || ((0 != $ModuleContextHeight || 3 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && 0 <= a#44 && 0 <= b#45) ==> Math.max#2($Heap, a#44, b#45) == (if a#44 < b#45 then b#45 else a#44));

// frame axiom for Math.max
axiom (forall $h0: HeapType, $h1: HeapType, a#44: int, b#45: int :: { $HeapSucc($h0, $h1), Math.max($h1, a#44, b#45) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && 0 <= a#44 && 0 <= a#44 && 0 <= b#45 && 0 <= b#45 && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: false ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Math.max($h0, a#44, b#45) == Math.max($h1, a#44, b#45));

axiom (forall $h0: HeapType, $h1: HeapType, a#44: int, b#45: int :: { $HeapSucc($h0, $h1), Math.max#limited($h1, a#44, b#45) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && 0 <= a#44 && 0 <= a#44 && 0 <= b#45 && 0 <= b#45 && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: false ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Math.max#limited($h0, a#44, b#45) == Math.max#limited($h1, a#44, b#45));

procedure CheckWellformed$$Math.max(a#44: int where 0 <= a#44, b#45: int where 0 <= b#45);
  free requires 0 == $ModuleContextHeight && 3 == $FunctionContextHeight;



implementation CheckWellformed$$Math.max(a#44: int, b#45: int)
{
  var a#187: int;
  var b#188: int;
  var a#189: int;
  var b#190: int;
  var a#191: int;
  var b#192: int;
  var $_Frame: <beta>[ref,Field beta]bool;

    if (*)
    {
        if (a#44 == b#45)
        {
            assert 0 <= a#44;
            a#187 := a#44;
            assert 0 <= b#45;
            b#188 := b#45;
            assert 0 <= a#44 || a#187 == a#44;
            assert 0 <= b#45 || a#187 < a#44 || b#188 == b#45;
            assert (a#44 == a#44 && b#45 == b#45) || a#187 < a#44 || (a#187 == a#44 && b#188 < b#45);
            assume (a#44 == a#44 && b#45 == b#45) || Math.max#canCall($Heap, a#44, b#45);
            if (Math.max($Heap, a#44, b#45) == a#44)
            {
            }
        }

        assume a#44 == b#45 ==> Math.max($Heap, a#44, b#45) == a#44 && a#44 == b#45;
        assert 0 <= a#44;
        a#189 := a#44;
        assert 0 <= b#45;
        b#190 := b#45;
        assert 0 <= a#44 || a#189 == a#44;
        assert 0 <= b#45 || a#189 < a#44 || b#190 == b#45;
        assert (a#44 == a#44 && b#45 == b#45) || a#189 < a#44 || (a#189 == a#44 && b#190 < b#45);
        assume (a#44 == a#44 && b#45 == b#45) || Math.max#canCall($Heap, a#44, b#45);
        if (a#44 <= Math.max($Heap, a#44, b#45))
        {
            assert 0 <= a#44;
            a#191 := a#44;
            assert 0 <= b#45;
            b#192 := b#45;
            assert 0 <= a#44 || a#191 == a#44;
            assert 0 <= b#45 || a#191 < a#44 || b#192 == b#45;
            assert (a#44 == a#44 && b#45 == b#45) || a#191 < a#44 || (a#191 == a#44 && b#192 < b#45);
            assume (a#44 == a#44 && b#45 == b#45) || Math.max#canCall($Heap, a#44, b#45);
        }

        assume a#44 <= Math.max($Heap, a#44, b#45) && b#45 <= Math.max($Heap, a#44, b#45);
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
        if (a#44 < b#45)
        {
        }
        else
        {
        }

        assert 0 <= (if a#44 < b#45 then b#45 else a#44);
        assume Math.max($Heap, a#44, b#45) == (if a#44 < b#45 then b#45 else a#44);
        assume (a#44 < b#45 ==> true) && (a#44 >= b#45 ==> true);
        assert a#44 == b#45 ==> Math.max#2($Heap, a#44, b#45) == a#44;
        assert a#44 == b#45 ==> a#44 == b#45;
        assert a#44 <= Math.max#2($Heap, a#44, b#45);
        assert b#45 <= Math.max#2($Heap, a#44, b#45);
    }
}



const unique class._default: ClassName;
