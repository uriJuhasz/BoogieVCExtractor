// Dafny program verifier version 2.0.0.0, Copyright (c) 2003-2011, Microsoft.
// Command Line Options: c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy /traceTimes /print:b4.bpl

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

axiom (forall<T> s: Seq T, i: int, v: T, len: int, x: T :: { Seq#Contains(Seq#Build(s, i, v, len), x) } Seq#Contains(Seq#Build(s, i, v, len), x) <==> (0 <= i && i < len && x == v) || (exists j: int :: { Seq#Index(s, j) } 0 <= j && j < Seq#Length(s) && j < len && j != i && Seq#Index(s, j) == x));

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

axiom (forall<alpha> h: HeapType, r: ref, f: Field alpha, x: alpha :: { update(h, r, f, x) } $HeapSucc(h, update(h, r, f, x)));

axiom (forall a: HeapType, b: HeapType, c: HeapType :: { $HeapSucc(a, b), $HeapSucc(b, c) } $HeapSucc(a, b) && $HeapSucc(b, c) ==> $HeapSucc(a, c));

axiom (forall h: HeapType, k: HeapType :: { $HeapSucc(h, k) } $HeapSucc(h, k) ==> (forall o: ref :: { read(k, o, alloc) } read(h, o, alloc) ==> read(k, o, alloc)));

type TickType;

var $Tick: TickType;

axiom (forall x: int, y: int :: { x mod y } { x div y } x mod y == x - x div y * y);

axiom (forall x: int, y: int :: { x mod y } 0 < y ==> 0 <= x mod y && x mod y < y);

axiom (forall x: int, y: int :: { x mod y } y < 0 ==> y < x mod y && x mod y <= 0);

axiom (forall a: int, b: int, d: int :: { a mod d, b mod d } 2 <= d && a mod d == b mod d && a < b ==> a + d <= b);

const unique class.object: ClassName;

const unique class.array: ClassName;

axiom (forall o: ref :: 0 <= array.Length(o));

function array.Length(this: ref) : int;

const unique class.Map: ClassName;

axiom FDim(Map.Keys) == 0 && DeclType(Map.Keys) == class.Map;

const unique Map.Keys: Field (Seq BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Map.Keys) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $i#0: int :: { Seq#Index(read($h, $o, Map.Keys), $i#0) } 0 <= $i#0 && $i#0 < Seq#Length(read($h, $o, Map.Keys)) ==> GenericAlloc(Seq#Index(read($h, $o, Map.Keys), $i#0), $h)));

axiom FDim(Map.Values) == 0 && DeclType(Map.Values) == class.Map;

const unique Map.Values: Field (Seq BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Map.Values) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $i#1: int :: { Seq#Index(read($h, $o, Map.Values), $i#1) } 0 <= $i#1 && $i#1 < Seq#Length(read($h, $o, Map.Values)) ==> GenericAlloc(Seq#Index(read($h, $o, Map.Values), $i#1), $h)));

axiom FDim(Map.Repr) == 0 && DeclType(Map.Repr) == class.Map;

const unique Map.Repr: Field (Set BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Map.Repr) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $t#2: BoxType :: { read($h, $o, Map.Repr)[$t#2] } read($h, $o, Map.Repr)[$t#2] ==> $Unbox($t#2): ref == null || read($h, $Unbox($t#2): ref, alloc)));

axiom FDim(Map.head) == 0 && DeclType(Map.head) == class.Map;

const unique Map.head: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Map.head) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, Map.head) == null || (read($h, read($h, $o, Map.head), alloc) && dtype(read($h, $o, Map.head)) == class.Node));

axiom FDim(Map.nodes) == 0 && DeclType(Map.nodes) == class.Map;

const unique Map.nodes: Field (Seq BoxType);

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Map.nodes) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> (forall $i#3: int :: { Seq#Index(read($h, $o, Map.nodes), $i#3) } 0 <= $i#3 && $i#3 < Seq#Length(read($h, $o, Map.nodes)) ==> $Unbox(Seq#Index(read($h, $o, Map.nodes), $i#3)): ref == null || (read($h, $Unbox(Seq#Index(read($h, $o, Map.nodes), $i#3)): ref, alloc) && dtype($Unbox(Seq#Index(read($h, $o, Map.nodes), $i#3)): ref) == class.Node)));

function Map.Valid($heap: HeapType, this: ref) : bool;

function Map.Valid#canCall($heap: HeapType, this: ref) : bool;

axiom FDim(Node.key) == 0 && DeclType(Node.key) == class.Node;

axiom FDim(Node.val) == 0 && DeclType(Node.val) == class.Node;

axiom FDim(Node.next) == 0 && DeclType(Node.next) == class.Node;

// definition axiom for Map.Valid
axiom 0 < $ModuleContextHeight || (0 == $ModuleContextHeight && (4 <= $FunctionContextHeight || $InMethodContext)) ==> (forall $Heap: HeapType, this: ref :: { Map.Valid($Heap, this) } Map.Valid#canCall($Heap, this) || ((0 != $ModuleContextHeight || 4 != $FunctionContextHeight || $InMethodContext) && $IsGoodHeap($Heap) && this != null && read($Heap, this, alloc) && dtype(this) == class.Map) ==> (read($Heap, this, Map.Repr)[$Box(this)] ==> true) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) ==> true) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 ==> true) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref ==> (forall i#0: int :: true ==> (0 <= i#0 ==> true) && (0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) ==> true)))) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) ==> true) && Map.Valid($Heap, this) == (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null));

// frame axiom for Map.Valid
axiom (forall $h0: HeapType, $h1: HeapType, this: ref :: { $HeapSucc($h0, $h1), Map.Valid($h1, this) } $IsGoodHeap($h0) && $IsGoodHeap($h1) && this != null && read($h0, this, alloc) && dtype(this) == class.Map && read($h1, this, alloc) && dtype(this) == class.Map && $HeapSucc($h0, $h1) ==> (forall<alpha> $o: ref, $f: Field alpha :: $o != null && read($h0, $o, alloc) && read($h1, $o, alloc) && ($o == this || read($h0, this, Map.Repr)[$Box($o)]) ==> read($h0, $o, $f) == read($h1, $o, $f)) ==> Map.Valid($h0, this) == Map.Valid($h1, this));

procedure CheckWellformed$$Map.Valid(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map);
  free requires 0 == $ModuleContextHeight && 4 == $FunctionContextHeight;



implementation CheckWellformed$$Map.Valid(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var i#27: int;

    if (*)
    {
    }
    else
    {
        $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this || read($Heap, this, Map.Repr)[$Box($o)]);
        assert $_Frame[this, Map.Repr];
        if (read($Heap, this, Map.Repr)[$Box(this)])
        {
            assert $_Frame[this, Map.Keys];
            assert $_Frame[this, Map.Values];
        }

        if (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)))
        {
            assert $_Frame[this, Map.nodes];
            assert $_Frame[this, Map.Keys];
        }

        if (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1)
        {
            assert $_Frame[this, Map.head];
            assert $_Frame[this, Map.nodes];
            assert 0 <= 0 && 0 < Seq#Length(read($Heap, this, Map.nodes));
        }

        if (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref)
        {
            if (0 <= i#27)
            {
                assert $_Frame[this, Map.Keys];
            }

            if (0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.Keys)))
            {
                assert $_Frame[this, Map.nodes];
                assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.nodes));
                if ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null)
                {
                    assert $_Frame[this, Map.nodes];
                    assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.nodes));
                    assert $_Frame[this, Map.Repr];
                }

                if ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref)])
                {
                    assert $_Frame[this, Map.nodes];
                    assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.nodes));
                    assert $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null;
                    assert $_Frame[$Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.key];
                    assert $_Frame[this, Map.Keys];
                    assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.Keys));
                }

                if ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#27))
                {
                    assert $_Frame[this, Map.nodes];
                    assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.nodes));
                    assert $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null;
                    assert $_Frame[$Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.key];
                    assert $_Frame[this, Map.Keys];
                    assert 0 <= i#27 + 1 && i#27 + 1 <= Seq#Length(read($Heap, this, Map.Keys));
                }

                if ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#27) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#27 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.key)))
                {
                    assert $_Frame[this, Map.nodes];
                    assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.nodes));
                    assert $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null;
                    assert $_Frame[$Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.val];
                    assert $_Frame[this, Map.Values];
                    assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.Values));
                }

                if ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#27) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#27 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#27))
                {
                    assert $_Frame[this, Map.nodes];
                    assert 0 <= i#27 && i#27 < Seq#Length(read($Heap, this, Map.nodes));
                    assert $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref != null;
                    assert $_Frame[$Unbox(Seq#Index(read($Heap, this, Map.nodes), i#27)): ref, Node.next];
                    assert $_Frame[this, Map.nodes];
                    assert 0 <= i#27 + 1 && i#27 + 1 < Seq#Length(read($Heap, this, Map.nodes));
                }
            }
        }

        if (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref))
        {
            assert $_Frame[this, Map.nodes];
            assert $_Frame[this, Map.nodes];
            assert 0 <= Seq#Length(read($Heap, this, Map.nodes)) - 1 && Seq#Length(read($Heap, this, Map.nodes)) - 1 < Seq#Length(read($Heap, this, Map.nodes));
        }

        assume Map.Valid($Heap, this) == (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null);
        assume (read($Heap, this, Map.Repr)[$Box(this)] ==> true) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) ==> true) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 ==> true) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref ==> (forall i#0: int :: true ==> (0 <= i#0 ==> true) && (0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) ==> true) && ($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) ==> true)))) && (read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) ==> true);
    }
}



procedure CheckWellformed$$Map.Init(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Map.Init(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this);
    assume $HeapSucc(old($Heap), $Heap);
    assume Map.Valid#canCall($Heap, this);
    if (Map.Valid($Heap, this))
    {
    }

    assume Map.Valid($Heap, this) && (forall $o: ref :: $o != null && read($Heap, this, Map.Repr)[$Box($o)] && $o != this ==> !read(old($Heap), $o, alloc));
    assume Seq#Length(read($Heap, this, Map.Keys)) == 0;
}



procedure Map.Init(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map);
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;
  free ensures Map.Valid#canCall($Heap, this) && Map.Valid($Heap, this) && read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.Repr)[$Box(this)];
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values));
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref);
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  ensures (forall $o: ref :: $o != null && read($Heap, this, Map.Repr)[$Box($o)] && $o != this ==> !read(old($Heap), $o, alloc));
  ensures Seq#Length(read($Heap, this, Map.Keys)) == 0;
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || $o == this);
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Map.Init(this: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $rhs#0: Seq BoxType;
  var $rhs#1: Seq BoxType;
  var $rhs#2: Set BoxType;
  var $rhs#3: ref;
  var $rhs#4: Seq BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> $o == this);
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(45,10)
    assume true;
    assert $_Frame[this, Map.Keys];
    assume true;
    $rhs#0 := Seq#Empty(): Seq BoxType;
    $Heap := update($Heap, this, Map.Keys, $rhs#0);
    assume $IsGoodHeap($Heap);
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(46,12)
    assume true;
    assert $_Frame[this, Map.Values];
    assume true;
    $rhs#1 := Seq#Empty(): Seq BoxType;
    $Heap := update($Heap, this, Map.Values, $rhs#1);
    assume $IsGoodHeap($Heap);
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(47,10)
    assume true;
    assert $_Frame[this, Map.Repr];
    assume true;
    $rhs#2 := Set#UnionOne(Set#Empty(): Set BoxType, $Box(this));
    $Heap := update($Heap, this, Map.Repr, $rhs#2);
    assume $IsGoodHeap($Heap);
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(48,10)
    assume true;
    assert $_Frame[this, Map.head];
    assume true;
    $rhs#3 := null;
    $Heap := update($Heap, this, Map.head, $rhs#3);
    assume $IsGoodHeap($Heap);
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(49,11)
    assume true;
    assert $_Frame[this, Map.nodes];
    assume true;
    $rhs#4 := Seq#Build(Seq#Empty(): Seq BoxType, 0, $Box(null), 1);
    $Heap := update($Heap, this, Map.nodes, $rhs#4);
    assume $IsGoodHeap($Heap);
}



procedure CheckWellformed$$Map.Find(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#1: BoxType where GenericAlloc(key#1, $Heap)) returns (present#2: bool, val#3: BoxType where GenericAlloc(val#3, $Heap));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Map.Find(this: ref, key#1: BoxType) returns (present#2: bool, val#3: BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var i#28: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume Map.Valid#canCall($Heap, this);
    assume Map.Valid($Heap, this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    havoc present#2, val#3;
    if (!present#2)
    {
    }

    assume !present#2 ==> !Seq#Contains(read($Heap, this, Map.Keys), key#1);
    if (present#2)
    {
        if (0 <= i#28)
        {
        }

        if (0 <= i#28 && i#28 < Seq#Length(read($Heap, this, Map.Keys)))
        {
            assert 0 <= i#28 && i#28 < Seq#Length(read($Heap, this, Map.Keys));
        }

        if (0 <= i#28 && i#28 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), i#28) == key#1)
        {
            assert 0 <= i#28 && i#28 < Seq#Length(read($Heap, this, Map.Values));
        }
    }

    assume present#2 ==> (exists i#4: int :: 0 <= i#4 && i#4 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), i#4) == key#1 && Seq#Index(read($Heap, this, Map.Values), i#4) == val#3);
}



procedure Map.Find(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#1: BoxType where GenericAlloc(key#1, $Heap)) returns (present#2: bool, val#3: BoxType where GenericAlloc(val#3, $Heap));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires Map.Valid#canCall($Heap, this) && Map.Valid($Heap, this) && read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.Repr)[$Box(this)];
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values));
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref);
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  modifies $Heap, $Tick;
  ensures !present#2 ==> !Seq#Contains(read($Heap, this, Map.Keys), key#1);
  ensures present#2 ==> (exists i#4: int :: 0 <= i#4 && i#4 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), i#4) == key#1 && Seq#Index(read($Heap, this, Map.Values), i#4) == val#3);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Map.Find(this: ref, key#1: BoxType) returns (present#2: bool, val#3: BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var p#5: ref where p#5 == null || (read($Heap, p#5, alloc) && dtype(p#5) == class.Node);
  var n#6: int;
  var prev#7: ref where prev#7 == null || (read($Heap, prev#7, alloc) && dtype(prev#7) == class.Node);
  var $rhs#0: ref where $rhs#0 == null || (read($Heap, $rhs#0, alloc) && dtype($rhs#0) == class.Node);
  var $rhs#1: int;
  var $rhs#2: ref where $rhs#2 == null || (read($Heap, $rhs#2, alloc) && dtype($rhs#2) == class.Node);
  var key#29: BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(57,9)
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(57,12)
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(57,15)
    // ----- call statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(57,23)
    assume true;
    assume true;
    assume true;
    assume true;
    key#29 := key#1;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call $rhs#0, $rhs#1, $rhs#2 := Map.FindIndex(this, key#29);
    p#5 := $rhs#0;
    n#6 := $rhs#1;
    prev#7 := $rhs#2;
    assume {:captureState "c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(57,23)"} true;
    // ----- if statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(58,5)
    assume true;
    if (p#5 == null)
    {
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(59,15)
        assume true;
        assume true;
        present#2 := false;
    }
    else
    {
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(61,11)
        assume true;
        assert p#5 != null;
        assume true;
        val#3 := read($Heap, p#5, Node.val);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(62,15)
        assume true;
        assume true;
        present#2 := true;
    }
}



procedure CheckWellformed$$Map.Add(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#8: BoxType where GenericAlloc(key#8, $Heap), val#9: BoxType where GenericAlloc(val#9, $Heap));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Map.Add(this: ref, key#8: BoxType, val#9: BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var i#30: int;
  var j#31: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> read($Heap, this, Map.Repr)[$Box($o)]);
    assume Map.Valid#canCall($Heap, this);
    assume Map.Valid($Heap, this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || read(old($Heap), this, Map.Repr)[$Box($o)]);
    assume $HeapSucc(old($Heap), $Heap);
    assume Map.Valid#canCall($Heap, this);
    if (Map.Valid($Heap, this))
    {
    }

    assume Map.Valid($Heap, this) && (forall $o: ref :: $o != null && read($Heap, this, Map.Repr)[$Box($o)] && !old(read($Heap, this, Map.Repr))[$Box($o)] ==> !read(old($Heap), $o, alloc));
    if (0 <= i#30)
    {
    }

    if (0 <= i#30 && i#30 < Seq#Length(old(read($Heap, this, Map.Keys))))
    {
        assert 0 <= i#30 && i#30 < Seq#Length(old(read($Heap, this, Map.Keys)));
    }

    if (0 <= i#30 && i#30 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Index(old(read($Heap, this, Map.Keys)), i#30) == key#8)
    {
        if (Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))))
        {
            assert 0 <= i#30 && i#30 < Seq#Length(read($Heap, this, Map.Keys));
        }

        if (Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Index(read($Heap, this, Map.Keys), i#30) == key#8)
        {
            assert 0 <= i#30 && i#30 < Seq#Length(read($Heap, this, Map.Values));
        }

        if (Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Index(read($Heap, this, Map.Keys), i#30) == key#8 && Seq#Index(read($Heap, this, Map.Values), i#30) == val#9)
        {
            if (0 <= j#31)
            {
            }

            if (0 <= j#31 && j#31 < Seq#Length(read($Heap, this, Map.Values)))
            {
            }

            if (0 <= j#31 && j#31 < Seq#Length(read($Heap, this, Map.Values)) && i#30 != j#31)
            {
                assert 0 <= j#31 && j#31 < Seq#Length(read($Heap, this, Map.Keys));
                assert 0 <= j#31 && j#31 < Seq#Length(old(read($Heap, this, Map.Keys)));
                if (Seq#Index(read($Heap, this, Map.Keys), j#31) == Seq#Index(old(read($Heap, this, Map.Keys)), j#31))
                {
                    assert 0 <= j#31 && j#31 < Seq#Length(read($Heap, this, Map.Values));
                    assert 0 <= j#31 && j#31 < Seq#Length(old(read($Heap, this, Map.Values)));
                }
            }
        }
    }

    assume (forall i#10: int :: true ==> 0 <= i#10 && i#10 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Index(old(read($Heap, this, Map.Keys)), i#10) == key#8 ==> Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Index(read($Heap, this, Map.Keys), i#10) == key#8 && Seq#Index(read($Heap, this, Map.Values), i#10) == val#9 && (forall j#11: int :: true ==> 0 <= j#11 && j#11 < Seq#Length(read($Heap, this, Map.Values)) && i#10 != j#11 ==> Seq#Index(read($Heap, this, Map.Keys), j#11) == Seq#Index(old(read($Heap, this, Map.Keys)), j#11) && Seq#Index(read($Heap, this, Map.Values), j#11) == Seq#Index(old(read($Heap, this, Map.Values)), j#11)));
    if (!Seq#Contains(old(read($Heap, this, Map.Keys)), key#8))
    {
        if (Seq#Equal(read($Heap, this, Map.Keys), Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, key#8, 1), old(read($Heap, this, Map.Keys)))))
        {
        }
    }

    assume !Seq#Contains(old(read($Heap, this, Map.Keys)), key#8) ==> Seq#Equal(read($Heap, this, Map.Keys), Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, key#8, 1), old(read($Heap, this, Map.Keys)))) && Seq#Equal(read($Heap, this, Map.Values), Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, val#9, 1), old(read($Heap, this, Map.Values))));
}



procedure Map.Add(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#8: BoxType where GenericAlloc(key#8, $Heap), val#9: BoxType where GenericAlloc(val#9, $Heap));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires Map.Valid#canCall($Heap, this) && Map.Valid($Heap, this) && read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.Repr)[$Box(this)];
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values));
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref);
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  modifies $Heap, $Tick;
  free ensures Map.Valid#canCall($Heap, this) && Map.Valid($Heap, this) && read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.Repr)[$Box(this)];
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values));
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref);
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  ensures (forall $o: ref :: $o != null && read($Heap, this, Map.Repr)[$Box($o)] && !old(read($Heap, this, Map.Repr))[$Box($o)] ==> !read(old($Heap), $o, alloc));
  ensures (forall i#10: int :: true ==> 0 <= i#10 && i#10 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Index(old(read($Heap, this, Map.Keys)), i#10) == key#8 ==> Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Index(read($Heap, this, Map.Keys), i#10) == key#8 && Seq#Index(read($Heap, this, Map.Values), i#10) == val#9 && (forall j#11: int :: true ==> 0 <= j#11 && j#11 < Seq#Length(read($Heap, this, Map.Values)) && i#10 != j#11 ==> Seq#Index(read($Heap, this, Map.Keys), j#11) == Seq#Index(old(read($Heap, this, Map.Keys)), j#11) && Seq#Index(read($Heap, this, Map.Values), j#11) == Seq#Index(old(read($Heap, this, Map.Values)), j#11)));
  ensures !Seq#Contains(old(read($Heap, this, Map.Keys)), key#8) ==> Seq#Equal(read($Heap, this, Map.Keys), Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, key#8, 1), old(read($Heap, this, Map.Keys))));
  ensures !Seq#Contains(old(read($Heap, this, Map.Keys)), key#8) ==> Seq#Equal(read($Heap, this, Map.Values), Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, val#9, 1), old(read($Heap, this, Map.Values))));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || read(old($Heap), this, Map.Repr)[$Box($o)]);
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Map.Add(this: ref, key#8: BoxType, val#9: BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var p#12: ref where p#12 == null || (read($Heap, p#12, alloc) && dtype(p#12) == class.Node);
  var n#13: int;
  var prev#14: ref where prev#14 == null || (read($Heap, prev#14, alloc) && dtype(prev#14) == class.Node);
  var $rhs#0: ref where $rhs#0 == null || (read($Heap, $rhs#0, alloc) && dtype($rhs#0) == class.Node);
  var $rhs#1: int;
  var $rhs#2: ref where $rhs#2 == null || (read($Heap, $rhs#2, alloc) && dtype($rhs#2) == class.Node);
  var key#32: BoxType;
  var h#15: ref where h#15 == null || (read($Heap, h#15, alloc) && dtype(h#15) == class.Node);
  var $nw: ref;
  var $rhs#3: BoxType;
  var $rhs#4: BoxType;
  var $rhs#5: ref;
  var $rhs#6: ref;
  var $rhs#7: Seq BoxType;
  var $rhs#8: Seq BoxType;
  var $rhs#9: Seq BoxType;
  var $rhs#10: Set BoxType;
  var $rhs#11: BoxType;
  var $rhs#12: Seq BoxType;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> read($Heap, this, Map.Repr)[$Box($o)]);
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(77,9)
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(77,12)
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(77,15)
    // ----- call statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(77,23)
    assume true;
    assume true;
    assume true;
    assume true;
    key#32 := key#8;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call $rhs#0, $rhs#1, $rhs#2 := Map.FindIndex(this, key#32);
    p#12 := $rhs#0;
    n#13 := $rhs#1;
    prev#14 := $rhs#2;
    assume {:captureState "c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(77,23)"} true;
    // ----- if statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(78,5)
    assume true;
    if (p#12 == null)
    {
        // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(79,11)
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(79,13)
        assume true;
        havoc $nw;
        assume $nw != null && !read($Heap, $nw, alloc) && dtype($nw) == class.Node;
        $Heap := update($Heap, $nw, alloc, true);
        assume $IsGoodHeap($Heap);
        h#15 := $nw;
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(80,13)
        assert h#15 != null;
        assume true;
        assert $_Frame[h#15, Node.key];
        assume true;
        $rhs#3 := key#8;
        $Heap := update($Heap, h#15, Node.key, $rhs#3);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(80,28)
        assert h#15 != null;
        assume true;
        assert $_Frame[h#15, Node.val];
        assume true;
        $rhs#4 := val#9;
        $Heap := update($Heap, h#15, Node.val, $rhs#4);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(80,44)
        assert h#15 != null;
        assume true;
        assert $_Frame[h#15, Node.next];
        assume true;
        $rhs#5 := read($Heap, this, Map.head);
        $Heap := update($Heap, h#15, Node.next, $rhs#5);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(81,12)
        assume true;
        assert $_Frame[this, Map.head];
        assume true;
        $rhs#6 := h#15;
        $Heap := update($Heap, this, Map.head, $rhs#6);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(82,12)
        assume true;
        assert $_Frame[this, Map.Keys];
        assume true;
        $rhs#7 := Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, key#8, 1), read($Heap, this, Map.Keys));
        $Heap := update($Heap, this, Map.Keys, $rhs#7);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(82,37)
        assume true;
        assert $_Frame[this, Map.Values];
        assume true;
        $rhs#8 := Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, val#9, 1), read($Heap, this, Map.Values));
        $Heap := update($Heap, this, Map.Values, $rhs#8);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(83,13)
        assume true;
        assert $_Frame[this, Map.nodes];
        assume true;
        $rhs#9 := Seq#Append(Seq#Build(Seq#Empty(): Seq BoxType, 0, $Box(h#15), 1), read($Heap, this, Map.nodes));
        $Heap := update($Heap, this, Map.nodes, $rhs#9);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(84,12)
        assume true;
        assert $_Frame[this, Map.Repr];
        assume true;
        $rhs#10 := Set#Union(read($Heap, this, Map.Repr), Set#UnionOne(Set#Empty(): Set BoxType, $Box(h#15)));
        $Heap := update($Heap, this, Map.Repr, $rhs#10);
        assume $IsGoodHeap($Heap);
    }
    else
    {
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(86,13)
        assert p#12 != null;
        assume true;
        assert $_Frame[p#12, Node.val];
        assume true;
        $rhs#11 := val#9;
        $Heap := update($Heap, p#12, Node.val, $rhs#11);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(87,14)
        assume true;
        assert $_Frame[this, Map.Values];
        assert 0 <= n#13 && n#13 < Seq#Length(read($Heap, this, Map.Values));
        assume true;
        $rhs#12 := Seq#Update(read($Heap, this, Map.Values), n#13, val#9);
        $Heap := update($Heap, this, Map.Values, $rhs#12);
        assume $IsGoodHeap($Heap);
    }
}



procedure CheckWellformed$$Map.Remove(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#16: BoxType where GenericAlloc(key#16, $Heap));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Map.Remove(this: ref, key#16: BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var k#33: BoxType;
  var k#34: BoxType;
  var h#35: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> read($Heap, this, Map.Repr)[$Box($o)]);
    assume Map.Valid#canCall($Heap, this);
    assume Map.Valid($Heap, this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || read(old($Heap), this, Map.Repr)[$Box($o)]);
    assume $HeapSucc(old($Heap), $Heap);
    assume Map.Valid#canCall($Heap, this);
    if (Map.Valid($Heap, this))
    {
    }

    assume Map.Valid($Heap, this) && (forall $o: ref :: $o != null && read($Heap, this, Map.Repr)[$Box($o)] && !old(read($Heap, this, Map.Repr))[$Box($o)] ==> !read(old($Heap), $o, alloc));
    assume GenericAlloc(k#33, $Heap);
    if (Seq#Contains(read($Heap, this, Map.Keys), k#33))
    {
    }

    assume (forall k#17: BoxType :: GenericAlloc(k#17, $Heap) ==> Seq#Contains(read($Heap, this, Map.Keys), k#17) ==> Seq#Contains(old(read($Heap, this, Map.Keys)), k#17));
    assume GenericAlloc(k#34, $Heap);
    if (Seq#Contains(old(read($Heap, this, Map.Keys)), k#34))
    {
        if (!Seq#Contains(read($Heap, this, Map.Keys), k#34))
        {
        }
    }

    assume (forall k#18: BoxType :: GenericAlloc(k#18, $Heap) ==> Seq#Contains(old(read($Heap, this, Map.Keys)), k#18) ==> Seq#Contains(read($Heap, this, Map.Keys), k#18) || k#18 == key#16);
    if (!Seq#Contains(old(read($Heap, this, Map.Keys)), key#16))
    {
        if (Seq#Equal(read($Heap, this, Map.Keys), old(read($Heap, this, Map.Keys))))
        {
        }
    }

    assume !Seq#Contains(old(read($Heap, this, Map.Keys)), key#16) ==> Seq#Equal(read($Heap, this, Map.Keys), old(read($Heap, this, Map.Keys))) && Seq#Equal(read($Heap, this, Map.Values), old(read($Heap, this, Map.Values)));
    if (Seq#Contains(old(read($Heap, this, Map.Keys)), key#16))
    {
        if (Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) - 1)
        {
        }

        if (Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) - 1 && !Seq#Contains(read($Heap, this, Map.Keys), key#16))
        {
            if (0 <= h#35)
            {
            }

            if (0 <= h#35 && h#35 < Seq#Length(old(read($Heap, this, Map.Keys))))
            {
                assert 0 <= h#35 && h#35 <= Seq#Length(read($Heap, this, Map.Keys));
                assert 0 <= h#35 && h#35 <= Seq#Length(old(read($Heap, this, Map.Keys)));
            }

            if (0 <= h#35 && h#35 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Equal(Seq#Take(read($Heap, this, Map.Keys), h#35), Seq#Take(old(read($Heap, this, Map.Keys)), h#35)))
            {
                assert 0 <= h#35 && h#35 <= Seq#Length(read($Heap, this, Map.Values));
                assert 0 <= h#35 && h#35 <= Seq#Length(old(read($Heap, this, Map.Values)));
            }

            if (0 <= h#35 && h#35 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Equal(Seq#Take(read($Heap, this, Map.Keys), h#35), Seq#Take(old(read($Heap, this, Map.Keys)), h#35)) && Seq#Equal(Seq#Take(read($Heap, this, Map.Values), h#35), Seq#Take(old(read($Heap, this, Map.Values)), h#35)))
            {
                assert 0 <= h#35 && h#35 <= Seq#Length(read($Heap, this, Map.Keys));
                assert 0 <= h#35 + 1 && h#35 + 1 <= Seq#Length(old(read($Heap, this, Map.Keys)));
            }

            if (0 <= h#35 && h#35 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Equal(Seq#Take(read($Heap, this, Map.Keys), h#35), Seq#Take(old(read($Heap, this, Map.Keys)), h#35)) && Seq#Equal(Seq#Take(read($Heap, this, Map.Values), h#35), Seq#Take(old(read($Heap, this, Map.Values)), h#35)) && Seq#Equal(Seq#Drop(read($Heap, this, Map.Keys), h#35), Seq#Drop(old(read($Heap, this, Map.Keys)), h#35 + 1)))
            {
                assert 0 <= h#35 && h#35 <= Seq#Length(read($Heap, this, Map.Values));
                assert 0 <= h#35 + 1 && h#35 + 1 <= Seq#Length(old(read($Heap, this, Map.Values)));
            }
        }
    }

    assume Seq#Contains(old(read($Heap, this, Map.Keys)), key#16) ==> Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) - 1 && !Seq#Contains(read($Heap, this, Map.Keys), key#16) && (exists h#19: int :: 0 <= h#19 && h#19 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Equal(Seq#Take(read($Heap, this, Map.Keys), h#19), Seq#Take(old(read($Heap, this, Map.Keys)), h#19)) && Seq#Equal(Seq#Take(read($Heap, this, Map.Values), h#19), Seq#Take(old(read($Heap, this, Map.Values)), h#19)) && Seq#Equal(Seq#Drop(read($Heap, this, Map.Keys), h#19), Seq#Drop(old(read($Heap, this, Map.Keys)), h#19 + 1)) && Seq#Equal(Seq#Drop(read($Heap, this, Map.Values), h#19), Seq#Drop(old(read($Heap, this, Map.Values)), h#19 + 1)));
}



procedure Map.Remove(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#16: BoxType where GenericAlloc(key#16, $Heap));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires Map.Valid#canCall($Heap, this) && Map.Valid($Heap, this) && read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.Repr)[$Box(this)];
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values));
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref);
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  modifies $Heap, $Tick;
  free ensures Map.Valid#canCall($Heap, this) && Map.Valid($Heap, this) && read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.Repr)[$Box(this)];
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values));
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref;
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref);
  ensures Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  ensures (forall $o: ref :: $o != null && read($Heap, this, Map.Repr)[$Box($o)] && !old(read($Heap, this, Map.Repr))[$Box($o)] ==> !read(old($Heap), $o, alloc));
  ensures (forall k#17: BoxType :: GenericAlloc(k#17, $Heap) ==> Seq#Contains(read($Heap, this, Map.Keys), k#17) ==> Seq#Contains(old(read($Heap, this, Map.Keys)), k#17));
  ensures (forall k#18: BoxType :: GenericAlloc(k#18, $Heap) ==> Seq#Contains(old(read($Heap, this, Map.Keys)), k#18) ==> Seq#Contains(read($Heap, this, Map.Keys), k#18) || k#18 == key#16);
  ensures !Seq#Contains(old(read($Heap, this, Map.Keys)), key#16) ==> Seq#Equal(read($Heap, this, Map.Keys), old(read($Heap, this, Map.Keys)));
  ensures !Seq#Contains(old(read($Heap, this, Map.Keys)), key#16) ==> Seq#Equal(read($Heap, this, Map.Values), old(read($Heap, this, Map.Values)));
  ensures Seq#Contains(old(read($Heap, this, Map.Keys)), key#16) ==> Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(old(read($Heap, this, Map.Keys))) - 1;
  ensures Seq#Contains(old(read($Heap, this, Map.Keys)), key#16) ==> !Seq#Contains(read($Heap, this, Map.Keys), key#16);
  ensures Seq#Contains(old(read($Heap, this, Map.Keys)), key#16) ==> (exists h#19: int :: 0 <= h#19 && h#19 < Seq#Length(old(read($Heap, this, Map.Keys))) && Seq#Equal(Seq#Take(read($Heap, this, Map.Keys), h#19), Seq#Take(old(read($Heap, this, Map.Keys)), h#19)) && Seq#Equal(Seq#Take(read($Heap, this, Map.Values), h#19), Seq#Take(old(read($Heap, this, Map.Values)), h#19)) && Seq#Equal(Seq#Drop(read($Heap, this, Map.Keys), h#19), Seq#Drop(old(read($Heap, this, Map.Keys)), h#19 + 1)) && Seq#Equal(Seq#Drop(read($Heap, this, Map.Values), h#19), Seq#Drop(old(read($Heap, this, Map.Values)), h#19 + 1)));
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f) || read(old($Heap), this, Map.Repr)[$Box($o)]);
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Map.Remove(this: ref, key#16: BoxType)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var p#20: ref where p#20 == null || (read($Heap, p#20, alloc) && dtype(p#20) == class.Node);
  var n#21: int;
  var prev#22: ref where prev#22 == null || (read($Heap, prev#22, alloc) && dtype(prev#22) == class.Node);
  var $rhs#0: ref where $rhs#0 == null || (read($Heap, $rhs#0, alloc) && dtype($rhs#0) == class.Node);
  var $rhs#1: int;
  var $rhs#2: ref where $rhs#2 == null || (read($Heap, $rhs#2, alloc) && dtype($rhs#2) == class.Node);
  var key#36: BoxType;
  var $rhs#3: Seq BoxType;
  var $rhs#4: Seq BoxType;
  var $rhs#5: Seq BoxType;
  var $rhs#6: ref;
  var $rhs#7: ref;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> read($Heap, this, Map.Repr)[$Box($o)]);
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(110,9)
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(110,12)
    // ----- var-declaration statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(110,15)
    // ----- call statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(110,23)
    assume true;
    assume true;
    assume true;
    assume true;
    key#36 := key#16;
    assert (forall<alpha> $o: ref, $f: Field alpha :: false ==> $_Frame[$o, $f]);
    call $rhs#0, $rhs#1, $rhs#2 := Map.FindIndex(this, key#36);
    p#20 := $rhs#0;
    n#21 := $rhs#1;
    prev#22 := $rhs#2;
    assume {:captureState "c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(110,23)"} true;
    // ----- if statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(111,5)
    assume true;
    if (p#20 != null)
    {
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(112,12)
        assume true;
        assert $_Frame[this, Map.Keys];
        assert 0 <= n#21 && n#21 <= Seq#Length(read($Heap, this, Map.Keys));
        assert 0 <= n#21 + 1 && n#21 + 1 <= Seq#Length(read($Heap, this, Map.Keys));
        assume true;
        $rhs#3 := Seq#Append(Seq#Take(read($Heap, this, Map.Keys), n#21), Seq#Drop(read($Heap, this, Map.Keys), n#21 + 1));
        $Heap := update($Heap, this, Map.Keys, $rhs#3);
        assume $IsGoodHeap($Heap);
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(113,14)
        assume true;
        assert $_Frame[this, Map.Values];
        assert 0 <= n#21 && n#21 <= Seq#Length(read($Heap, this, Map.Values));
        assert 0 <= n#21 + 1 && n#21 + 1 <= Seq#Length(read($Heap, this, Map.Values));
        assume true;
        $rhs#4 := Seq#Append(Seq#Take(read($Heap, this, Map.Values), n#21), Seq#Drop(read($Heap, this, Map.Values), n#21 + 1));
        $Heap := update($Heap, this, Map.Values, $rhs#4);
        assume $IsGoodHeap($Heap);
        // ----- assert statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(114,7)
        assert {:subsumption 0} 0 <= n#21 && n#21 <= Seq#Length(read($Heap, this, Map.Keys));
        assert {:subsumption 0} 0 <= n#21 + 1 && n#21 + 1 <= Seq#Length(old(read($Heap, this, Map.Keys)));
        assume old(true);
        assert Seq#Equal(Seq#Drop(read($Heap, this, Map.Keys), n#21), Seq#Drop(old(read($Heap, this, Map.Keys)), n#21 + 1));
        // ----- assert statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(115,7)
        assert {:subsumption 0} 0 <= n#21 && n#21 <= Seq#Length(read($Heap, this, Map.Values));
        assert {:subsumption 0} 0 <= n#21 + 1 && n#21 + 1 <= Seq#Length(old(read($Heap, this, Map.Values)));
        assume old(true);
        assert Seq#Equal(Seq#Drop(read($Heap, this, Map.Values), n#21), Seq#Drop(old(read($Heap, this, Map.Values)), n#21 + 1));
        // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(117,13)
        assume true;
        assert $_Frame[this, Map.nodes];
        assert 0 <= n#21 && n#21 <= Seq#Length(read($Heap, this, Map.nodes));
        assert 0 <= n#21 + 1 && n#21 + 1 <= Seq#Length(read($Heap, this, Map.nodes));
        assume true;
        $rhs#5 := Seq#Append(Seq#Take(read($Heap, this, Map.nodes), n#21), Seq#Drop(read($Heap, this, Map.nodes), n#21 + 1));
        $Heap := update($Heap, this, Map.nodes, $rhs#5);
        assume $IsGoodHeap($Heap);
        // ----- if statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(118,7)
        assume true;
        if (prev#22 == null)
        {
            // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(119,14)
            assume true;
            assert $_Frame[this, Map.head];
            assert read($Heap, this, Map.head) != null;
            assume true;
            $rhs#6 := read($Heap, read($Heap, this, Map.head), Node.next);
            $Heap := update($Heap, this, Map.head, $rhs#6);
            assume $IsGoodHeap($Heap);
        }
        else
        {
            // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(121,19)
            assert prev#22 != null;
            assume true;
            assert $_Frame[prev#22, Node.next];
            assert p#20 != null;
            assume true;
            $rhs#7 := read($Heap, p#20, Node.next);
            $Heap := update($Heap, prev#22, Node.next, $rhs#7);
            assume $IsGoodHeap($Heap);
        }
    }
    else
    {
    }
}



procedure CheckWellformed$$Map.FindIndex(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#23: BoxType where GenericAlloc(key#23, $Heap)) returns (p#24: ref where p#24 == null || (read($Heap, p#24, alloc) && dtype(p#24) == class.Node), n#25: int, prev#26: ref where prev#26 == null || (read($Heap, prev#26, alloc) && dtype(prev#26) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  modifies $Heap, $Tick;



implementation CheckWellformed$$Map.FindIndex(this: ref, key#23: BoxType) returns (p#24: ref, n#25: int, prev#26: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    assume Map.Valid#canCall($Heap, this);
    assume Map.Valid($Heap, this);
    havoc $Heap;
    assume (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
    assume $HeapSucc(old($Heap), $Heap);
    havoc p#24, n#25, prev#26;
    if (p#24 == null)
    {
    }

    assume p#24 == null ==> !Seq#Contains(read($Heap, this, Map.Keys), key#23);
    if (p#24 != null)
    {
        if (0 <= n#25)
        {
        }

        if (0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.Keys)))
        {
            assert 0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.Keys));
        }

        if (0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), n#25) == key#23)
        {
            assert 0 <= n#25 && n#25 <= Seq#Length(read($Heap, this, Map.Keys));
        }

        if (0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), n#25) == key#23 && !Seq#Contains(Seq#Take(read($Heap, this, Map.Keys), n#25), key#23))
        {
            assert 0 <= n#25 + 1 && n#25 + 1 <= Seq#Length(read($Heap, this, Map.Keys));
        }

        if (0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), n#25) == key#23 && !Seq#Contains(Seq#Take(read($Heap, this, Map.Keys), n#25), key#23) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), n#25 + 1), key#23))
        {
            assert 0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.nodes));
        }

        if (0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), n#25) == key#23 && !Seq#Contains(Seq#Take(read($Heap, this, Map.Keys), n#25), key#23) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), n#25 + 1), key#23) && p#24 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25)): ref)
        {
            if (n#25 == 0)
            {
            }

            if (!(n#25 == 0 && prev#26 == null))
            {
                if (0 < n#25)
                {
                    assert 0 <= n#25 - 1 && n#25 - 1 < Seq#Length(read($Heap, this, Map.nodes));
                }
            }
        }
    }

    assume p#24 != null ==> 0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.Keys)) && Seq#Index(read($Heap, this, Map.Keys), n#25) == key#23 && !Seq#Contains(Seq#Take(read($Heap, this, Map.Keys), n#25), key#23) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), n#25 + 1), key#23) && p#24 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25)): ref && ((n#25 == 0 && prev#26 == null) || (0 < n#25 && prev#26 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25 - 1)): ref));
}



procedure Map.FindIndex(this: ref where this != null && read($Heap, this, alloc) && dtype(this) == class.Map, key#23: BoxType where GenericAlloc(key#23, $Heap)) returns (p#24: ref where p#24 == null || (read($Heap, p#24, alloc) && dtype(p#24) == class.Node), n#25: int, prev#26: ref where prev#26 == null || (read($Heap, prev#26, alloc) && dtype(prev#26) == class.Node));
  free requires 0 == $ModuleContextHeight && $InMethodContext;
  free requires Map.Valid#canCall($Heap, this) && Map.Valid($Heap, this) && read($Heap, this, Map.Repr)[$Box(this)] && Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values)) && Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1 && read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref && (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref) && $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.Repr)[$Box(this)];
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.Keys)) == Seq#Length(read($Heap, this, Map.Values));
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || Seq#Length(read($Heap, this, Map.nodes)) == Seq#Length(read($Heap, this, Map.Keys)) + 1;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || read($Heap, this, Map.head) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), 0)): ref;
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || (forall i#0: int :: true ==> 0 <= i#0 && i#0 < Seq#Length(read($Heap, this, Map.Keys)) ==> $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref != null && read($Heap, this, Map.Repr)[$Box($Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref)] && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key) == Seq#Index(read($Heap, this, Map.Keys), i#0) && !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), i#0 + 1), read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.key)) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.val) == Seq#Index(read($Heap, this, Map.Values), i#0) && read($Heap, $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0)): ref, Node.next) == $Unbox(Seq#Index(read($Heap, this, Map.nodes), i#0 + 1)): ref);
  requires Map.Valid#canCall($Heap, this) ==> Map.Valid($Heap, this) || $Unbox(Seq#Index(read($Heap, this, Map.nodes), Seq#Length(read($Heap, this, Map.nodes)) - 1)): ref == null;
  modifies $Heap, $Tick;
  ensures p#24 == null ==> !Seq#Contains(read($Heap, this, Map.Keys), key#23);
  ensures p#24 != null ==> 0 <= n#25;
  ensures p#24 != null ==> n#25 < Seq#Length(read($Heap, this, Map.Keys));
  ensures p#24 != null ==> Seq#Index(read($Heap, this, Map.Keys), n#25) == key#23;
  ensures p#24 != null ==> !Seq#Contains(Seq#Take(read($Heap, this, Map.Keys), n#25), key#23);
  ensures p#24 != null ==> !Seq#Contains(Seq#Drop(read($Heap, this, Map.Keys), n#25 + 1), key#23);
  ensures p#24 != null ==> p#24 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25)): ref;
  ensures p#24 != null ==> (n#25 == 0 && prev#26 == null) || (0 < n#25 && prev#26 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25 - 1)): ref);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read(old($Heap), $o, $f));
  // boilerplate
  free ensures $HeapSucc(old($Heap), $Heap);



implementation Map.FindIndex(this: ref, key#23: BoxType) returns (p#24: ref, n#25: int, prev#26: ref)
{
  var $_Frame: <beta>[ref,Field beta]bool;
  var $PreLoopHeap0: HeapType;
  var $decr0$init$0: int;
  var $w0: bool;
  var $decr0$0: int;

    $_Frame := (lambda<alpha> $o: ref, $f: Field alpha :: $o != null && read($Heap, $o, alloc) ==> false);
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(135,7)
    assume true;
    assume true;
    n#25 := 0;
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(136,10)
    assume true;
    assume true;
    prev#26 := null;
    // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(137,7)
    assume true;
    assume true;
    p#24 := read($Heap, this, Map.head);
    // ----- while statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(138,5)
    $PreLoopHeap0 := $Heap;
    $decr0$init$0 := Seq#Length(read($Heap, this, Map.Keys)) - n#25;
    havoc $w0;
    while (true)
      free invariant $w0 ==> n#25 <= Seq#Length(read($Heap, this, Map.Keys)) ==> true;
      invariant $w0 ==> n#25 <= Seq#Length(read($Heap, this, Map.Keys));
      invariant $w0 ==> p#24 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25)): ref;
      free invariant $w0 ==> true;
      invariant $w0 ==> !Seq#Contains(Seq#Take(read($Heap, this, Map.Keys), n#25), key#23);
      free invariant $w0 ==> (n#25 == 0 ==> true) && (!(n#25 == 0 && prev#26 == null) ==> 0 < n#25 ==> true);
      invariant $w0 ==> (n#25 == 0 && prev#26 == null) || (0 < n#25 && prev#26 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25 - 1)): ref);
      free invariant (forall<alpha> $o: ref, $f: Field alpha :: { read($Heap, $o, $f) } $o != null && read(old($Heap), $o, alloc) ==> read($Heap, $o, $f) == read($PreLoopHeap0, $o, $f));
      free invariant $HeapSucc($PreLoopHeap0, $Heap);
      free invariant Seq#Length(read($Heap, this, Map.Keys)) - n#25 <= $decr0$init$0 && (Seq#Length(read($Heap, this, Map.Keys)) - n#25 == $decr0$init$0 ==> true);
    {
        if (!$w0)
        {
            if (n#25 <= Seq#Length(read($Heap, this, Map.Keys)))
            {
                assert {:subsumption 0} 0 <= n#25 && n#25 < Seq#Length(read($Heap, this, Map.nodes));
            }

            assume n#25 <= Seq#Length(read($Heap, this, Map.Keys)) ==> true;
            assume n#25 <= Seq#Length(read($Heap, this, Map.Keys)) && p#24 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25)): ref;
            assert {:subsumption 0} 0 <= n#25 && n#25 <= Seq#Length(read($Heap, this, Map.Keys));
            assume true;
            assume !Seq#Contains(Seq#Take(read($Heap, this, Map.Keys), n#25), key#23);
            if (n#25 == 0)
            {
            }

            if (!(n#25 == 0 && prev#26 == null))
            {
                if (0 < n#25)
                {
                    assert {:subsumption 0} 0 <= n#25 - 1 && n#25 - 1 < Seq#Length(read($Heap, this, Map.nodes));
                }
            }

            assume (n#25 == 0 ==> true) && (!(n#25 == 0 && prev#26 == null) ==> 0 < n#25 ==> true);
            assume (n#25 == 0 && prev#26 == null) || (0 < n#25 && prev#26 == $Unbox(Seq#Index(read($Heap, this, Map.nodes), n#25 - 1)): ref);
            assume true;
            assume false;
        }

        assume true;
        if (p#24 == null)
        {
            break;
        }

        assume {:captureState "c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(138,5): loop entered"} true;
        $decr0$0 := Seq#Length(read($Heap, this, Map.Keys)) - n#25;
        // ----- if statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(144,7)
        assert p#24 != null;
        assume true;
        if (read($Heap, p#24, Node.key) == key#23)
        {
            // ----- return statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(145,9)
            return;
        }
        else
        {
            // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(147,11)
            assume true;
            assume true;
            n#25 := n#25 + 1;
            // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(148,14)
            assume true;
            assume true;
            prev#26 := p#24;
            // ----- assignment statement ----- c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(149,11)
            assume true;
            assert p#24 != null;
            assume true;
            p#24 := read($Heap, p#24, Node.next);
        }

        assert 0 <= $decr0$0 || Seq#Length(read($Heap, this, Map.Keys)) - n#25 == $decr0$0;
        assert Seq#Length(read($Heap, this, Map.Keys)) - n#25 < $decr0$0;
        assume n#25 <= Seq#Length(read($Heap, this, Map.Keys)) ==> true;
        assume true;
        assume (n#25 == 0 ==> true) && (!(n#25 == 0 && prev#26 == null) ==> 0 < n#25 ==> true);
    }

    assume {:captureState "c:\Users\Uri\Boogie2\Test\VSI-BENCHMARKS\b4.dfy(138,5): loop exit"} true;
}



const unique class.Node: ClassName;

const unique Node.key: Field BoxType;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.key) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> GenericAlloc(read($h, $o, Node.key), $h));

const unique Node.val: Field BoxType;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.val) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> GenericAlloc(read($h, $o, Node.val), $h));

const unique Node.next: Field ref;

axiom (forall $h: HeapType, $o: ref :: { read($h, $o, Node.next) } $IsGoodHeap($h) && $o != null && read($h, $o, alloc) ==> read($h, $o, Node.next) == null || (read($h, read($h, $o, Node.next), alloc) && dtype(read($h, $o, Node.next)) == class.Node));

const unique class._default: ClassName;
