// Spec# program verifier version 2.0.0.0, Copyright (c) 2003-2010, Microsoft.
// Command Line Options: /print:Debug.bpl /trMethod:Nary.Simplify PrettySx.dll /noVerify

type TName;

//type real;

type Elements T;

type struct;

const $ZeroStruct: struct;

type ref;

const null: ref;

type Field _;

type HeapType = <beta>[ref,Field beta]beta;

var $Heap: HeapType where IsHeap($Heap);

type ActivityType;

var $ActivityIndicator: ActivityType;

function IsHeap(h: HeapType) : bool;

function IsPreHeap(h: HeapType) : bool;

axiom (forall h: HeapType :: { IsPreHeap(h) } IsHeap(h) ==> IsPreHeap(h));

const unique $allocated: Field bool;

const unique $elementsBool: Field (Elements bool);

const unique $elementsInt: Field (Elements int);

const unique $elementsRef: Field (Elements ref);

//const unique $elementsReal: Field (Elements real);

const unique $elementsStruct: Field (Elements struct);

axiom DeclType($elementsBool) == System.Array;

axiom DeclType($elementsInt) == System.Array;

axiom DeclType($elementsRef) == System.Array;

//axiom DeclType($elementsReal) == System.Array;

axiom DeclType($elementsStruct) == System.Array;

const unique $inv: Field TName;

const unique $localinv: Field TName;

type exposeVersionType;

const unique $exposeVersion: Field exposeVersionType;

axiom DeclType($exposeVersion) == System.Object;

const unique $ownerRef: Field ref;

const unique $ownerFrame: Field TName;

const unique $PeerGroupPlaceholder: TName;

function ClassRepr(class: TName) : ref;

function ClassReprInv(ref) : TName;

axiom (forall c: TName :: { ClassRepr(c) } ClassReprInv(ClassRepr(c)) == c);

axiom (forall T: TName :: !($typeof(ClassRepr(T)) <: System.Object));

axiom (forall T: TName :: ClassRepr(T) != null);

axiom (forall T: TName, h: HeapType :: { h[ClassRepr(T), $ownerFrame] } IsHeap(h) ==> h[ClassRepr(T), $ownerFrame] == $PeerGroupPlaceholder);

function $Utter(ref) : bool;

function IncludeInMainFrameCondition<alpha>(f: Field alpha) : bool;

axiom IncludeInMainFrameCondition($allocated);

axiom IncludeInMainFrameCondition($frozen);

axiom IncludeInMainFrameCondition($elementsBool) && IncludeInMainFrameCondition($elementsInt) && IncludeInMainFrameCondition($elementsRef) /*&& IncludeInMainFrameCondition($elementsReal)*/ && IncludeInMainFrameCondition($elementsStruct);

axiom !IncludeInMainFrameCondition($inv);

axiom !IncludeInMainFrameCondition($localinv);

axiom IncludeInMainFrameCondition($ownerRef);

axiom IncludeInMainFrameCondition($ownerFrame);

axiom IncludeInMainFrameCondition($exposeVersion);

axiom !IncludeInMainFrameCondition($FirstConsistentOwner);

function IsStaticField<alpha>(f: Field alpha) : bool;

axiom !IsStaticField($allocated);

axiom !IsStaticField($frozen);

axiom !IsStaticField($elementsBool) && !IsStaticField($elementsInt) && !IsStaticField($elementsRef) /*&& !IsStaticField($elementsReal)*/ && !IsStaticField($elementsStruct);

axiom !IsStaticField($inv);

axiom !IsStaticField($localinv);

axiom !IsStaticField($exposeVersion);

function $IncludedInModifiesStar<alpha>(f: Field alpha) : bool;

axiom !$IncludedInModifiesStar($ownerRef);

axiom !$IncludedInModifiesStar($ownerFrame);

axiom $IncludedInModifiesStar($exposeVersion);

axiom $IncludedInModifiesStar($elementsBool) && $IncludedInModifiesStar($elementsInt) && $IncludedInModifiesStar($elementsRef) /*&& $IncludedInModifiesStar($elementsReal)*/ && $IncludedInModifiesStar($elementsStruct);

function ArrayGet<alpha>(Elements alpha, int) : alpha;

function ArraySet<alpha>(Elements alpha, int, alpha) : Elements alpha;

axiom (forall<alpha> A: Elements alpha, i: int, x: alpha :: ArrayGet(ArraySet(A, i, x), i) == x);

axiom (forall<alpha> A: Elements alpha, i: int, j: int, x: alpha :: i != j ==> ArrayGet(ArraySet(A, i, x), j) == ArrayGet(A, j));

function ArrayIndex(arr: ref, dim: int, indexAtDim: int, remainingIndexContribution: int) : int;

function ArrayIndexInvX(arrayIndex: int) : int;

function ArrayIndexInvY(arrayIndex: int) : int;

axiom (forall a: ref, d: int, x: int, y: int :: { ArrayIndex(a, d, x, y) } ArrayIndexInvX(ArrayIndex(a, d, x, y)) == x);

axiom (forall a: ref, d: int, x: int, y: int :: { ArrayIndex(a, d, x, y) } ArrayIndexInvY(ArrayIndex(a, d, x, y)) == y);

axiom (forall a: ref, i: int, heap: HeapType :: { ArrayGet(heap[a, $elementsInt], i) } IsHeap(heap) ==> InRange(ArrayGet(heap[a, $elementsInt], i), $ElementType($typeof(a))));

axiom (forall a: ref, i: int, heap: HeapType :: { $typeof(ArrayGet(heap[a, $elementsRef], i)) } IsHeap(heap) && ArrayGet(heap[a, $elementsRef], i) != null ==> $typeof(ArrayGet(heap[a, $elementsRef], i)) <: $ElementType($typeof(a)));

axiom (forall a: ref, T: TName, i: int, r: int, heap: HeapType :: { $typeof(a) <: NonNullRefArray(T, r), ArrayGet(heap[a, $elementsRef], i) } IsHeap(heap) && $typeof(a) <: NonNullRefArray(T, r) ==> ArrayGet(heap[a, $elementsRef], i) != null);

function $Rank(ref) : int;

axiom (forall a: ref :: 1 <= $Rank(a));

axiom (forall a: ref, T: TName, r: int :: { $typeof(a) <: RefArray(T, r) } a != null && $typeof(a) <: RefArray(T, r) ==> $Rank(a) == r);

axiom (forall a: ref, T: TName, r: int :: { $typeof(a) <: NonNullRefArray(T, r) } a != null && $typeof(a) <: NonNullRefArray(T, r) ==> $Rank(a) == r);

axiom (forall a: ref, T: TName, r: int :: { $typeof(a) <: ValueArray(T, r) } a != null && $typeof(a) <: ValueArray(T, r) ==> $Rank(a) == r);

axiom (forall a: ref, T: TName, r: int :: { $typeof(a) <: IntArray(T, r) } a != null && $typeof(a) <: IntArray(T, r) ==> $Rank(a) == r);

function $Length(ref) : int;

axiom (forall a: ref :: { $Length(a) } 0 <= $Length(a) && $Length(a) <= 2147483647);

function $DimLength(ref, int) : int;

axiom (forall a: ref, i: int :: 0 <= $DimLength(a, i));

axiom (forall a: ref :: { $DimLength(a, 0) } $Rank(a) == 1 ==> $DimLength(a, 0) == $Length(a));

function $LBound(ref, int) : int;

function $UBound(ref, int) : int;

axiom (forall a: ref, i: int :: { $LBound(a, i) } $LBound(a, i) == 0);

axiom (forall a: ref, i: int :: { $UBound(a, i) } $UBound(a, i) == $DimLength(a, i) - 1);

type ArrayCategory;

const unique $ArrayCategoryValue: ArrayCategory;

const unique $ArrayCategoryInt: ArrayCategory;

const unique $ArrayCategoryRef: ArrayCategory;

const unique $ArrayCategoryNonNullRef: ArrayCategory;

function $ArrayCategory(arrayType: TName) : ArrayCategory;

axiom (forall T: TName, ET: TName, r: int :: { T <: ValueArray(ET, r) } T <: ValueArray(ET, r) ==> $ArrayCategory(T) == $ArrayCategoryValue);

axiom (forall T: TName, ET: TName, r: int :: { T <: IntArray(ET, r) } T <: IntArray(ET, r) ==> $ArrayCategory(T) == $ArrayCategoryInt);

axiom (forall T: TName, ET: TName, r: int :: { T <: RefArray(ET, r) } T <: RefArray(ET, r) ==> $ArrayCategory(T) == $ArrayCategoryRef);

axiom (forall T: TName, ET: TName, r: int :: { T <: NonNullRefArray(ET, r) } T <: NonNullRefArray(ET, r) ==> $ArrayCategory(T) == $ArrayCategoryNonNullRef);

const unique System.Array: TName;

axiom System.Array <: System.Object;

function $ElementType(TName) : TName;

function ValueArray(elementType: TName, rank: int) : TName;

axiom (forall T: TName, r: int :: { ValueArray(T, r) } ValueArray(T, r) <: ValueArray(T, r) && ValueArray(T, r) <: System.Array);

function IntArray(elementType: TName, rank: int) : TName;

axiom (forall T: TName, r: int :: { IntArray(T, r) } IntArray(T, r) <: IntArray(T, r) && IntArray(T, r) <: System.Array);

function RefArray(elementType: TName, rank: int) : TName;

axiom (forall T: TName, r: int :: { RefArray(T, r) } RefArray(T, r) <: RefArray(T, r) && RefArray(T, r) <: System.Array);

function NonNullRefArray(elementType: TName, rank: int) : TName;

axiom (forall T: TName, r: int :: { NonNullRefArray(T, r) } NonNullRefArray(T, r) <: NonNullRefArray(T, r) && NonNullRefArray(T, r) <: System.Array);

function NonNullRefArrayRaw(array: ref, elementType: TName, rank: int) : bool;

axiom (forall array: ref, elementType: TName, rank: int :: { NonNullRefArrayRaw(array, elementType, rank) } NonNullRefArrayRaw(array, elementType, rank) ==> $typeof(array) <: System.Array && $Rank(array) == rank && elementType <: $ElementType($typeof(array)));

axiom (forall T: TName, U: TName, r: int :: U <: T ==> RefArray(U, r) <: RefArray(T, r));

axiom (forall T: TName, U: TName, r: int :: U <: T ==> NonNullRefArray(U, r) <: NonNullRefArray(T, r));

axiom (forall A: TName, r: int :: $ElementType(ValueArray(A, r)) == A);

axiom (forall A: TName, r: int :: $ElementType(IntArray(A, r)) == A);

axiom (forall A: TName, r: int :: $ElementType(RefArray(A, r)) == A);

axiom (forall A: TName, r: int :: $ElementType(NonNullRefArray(A, r)) == A);

axiom (forall A: TName, r: int, T: TName :: { T <: RefArray(A, r) } T <: RefArray(A, r) ==> T != A && T == RefArray($ElementType(T), r) && $ElementType(T) <: A);

axiom (forall A: TName, r: int, T: TName :: { T <: NonNullRefArray(A, r) } T <: NonNullRefArray(A, r) ==> T != A && T == NonNullRefArray($ElementType(T), r) && $ElementType(T) <: A);

axiom (forall A: TName, r: int, T: TName :: { T <: ValueArray(A, r) } T <: ValueArray(A, r) ==> T == ValueArray(A, r));

axiom (forall A: TName, r: int, T: TName :: { T <: IntArray(A, r) } T <: IntArray(A, r) ==> T == IntArray(A, r));

axiom (forall A: TName, r: int, T: TName :: { RefArray(A, r) <: T } RefArray(A, r) <: T ==> System.Array <: T || (T == RefArray($ElementType(T), r) && A <: $ElementType(T)));

axiom (forall A: TName, r: int, T: TName :: { NonNullRefArray(A, r) <: T } NonNullRefArray(A, r) <: T ==> System.Array <: T || (T == NonNullRefArray($ElementType(T), r) && A <: $ElementType(T)));

axiom (forall A: TName, r: int, T: TName :: { ValueArray(A, r) <: T } ValueArray(A, r) <: T ==> System.Array <: T || T == ValueArray(A, r));

axiom (forall A: TName, r: int, T: TName :: { IntArray(A, r) <: T } IntArray(A, r) <: T ==> System.Array <: T || T == IntArray(A, r));

function $ArrayPtr(elementType: TName) : TName;

function $ElementProxy(ref, int) : ref;

function $ElementProxyStruct(struct, int) : ref;

axiom (forall a: ref, i: int, heap: HeapType :: { heap[ArrayGet(heap[a, $elementsRef], i), $ownerRef] } { heap[ArrayGet(heap[a, $elementsRef], i), $ownerFrame] } IsHeap(heap) && $typeof(a) <: System.Array ==> ArrayGet(heap[a, $elementsRef], i) == null || (heap[ArrayGet(heap[a, $elementsRef], i), $ownerRef] == heap[$ElementProxy(a, 0 - 1), $ownerRef] && heap[ArrayGet(heap[a, $elementsRef], i), $ownerFrame] == heap[$ElementProxy(a, 0 - 1), $ownerFrame]));

axiom (forall a: ref, heap: HeapType :: { IsAllocated(heap, a) } IsHeap(heap) && IsAllocated(heap, a) && $typeof(a) <: System.Array ==> IsAllocated(heap, $ElementProxy(a, 0 - 1)));

axiom (forall o: ref, pos: int :: { $typeof($ElementProxy(o, pos)) } $typeof($ElementProxy(o, pos)) == System.Object);

axiom (forall o: struct, pos: int :: { $typeof($ElementProxyStruct(o, pos)) } $typeof($ElementProxyStruct(o, pos)) == System.Object);

function $StructGet<alpha>(struct, Field alpha) : alpha;

function $StructSet<alpha>(struct, Field alpha, alpha) : struct;

axiom (forall<alpha> s: struct, f: Field alpha, x: alpha :: $StructGet($StructSet(s, f, x), f) == x);

axiom (forall<alpha,beta> s: struct, f: Field alpha, f': Field beta, x: alpha :: f != f' ==> $StructGet($StructSet(s, f, x), f') == $StructGet(s, f'));

function ZeroInit(s: struct, typ: TName) : bool;

function ZeroInitStruct(TName) : struct;

axiom (forall t: TName :: { ZeroInitStruct(t) } ZeroInit(ZeroInitStruct(t), t));

function $typeof(ref) : TName;

function $BaseClass(sub: TName) : TName;

axiom (forall T: TName :: { $BaseClass(T) } T <: $BaseClass(T) && (!$IsValueType(T) && T != System.Object ==> T != $BaseClass(T)));

function AsDirectSubClass(sub: TName, base: TName) : TName;

function OneClassDown(sub: TName, base: TName) : TName;

axiom (forall A: TName, B: TName, C: TName :: { C <: AsDirectSubClass(B, A) } C <: AsDirectSubClass(B, A) ==> OneClassDown(C, A) == B);

function $IsValueType(TName) : bool;

axiom (forall T: TName :: $IsValueType(T) ==> (forall U: TName :: T <: U ==> T == U) && (forall U: TName :: U <: T ==> T == U));

const unique System.Boolean: TName;

axiom $IsValueType(System.Boolean);

const unique System.Object: TName;

axiom (forall T: TName :: T <: System.Object ==> !$IsValueType(T));

function $IsTokenForType(struct, TName) : bool;

function TypeObject(TName) : ref;

const unique System.Type: TName;

axiom System.Type <: System.Object;

axiom (forall T: TName :: { TypeObject(T) } $IsNotNull(TypeObject(T), System.Type));

function TypeName(ref) : TName;

axiom (forall T: TName :: { TypeObject(T) } TypeName(TypeObject(T)) == T);

function $Is(ref, TName) : bool;

axiom (forall o: ref, T: TName :: { $Is(o, T) } $Is(o, T) <==> o == null || $typeof(o) <: T);

function $IsNotNull(ref, TName) : bool;

axiom (forall o: ref, T: TName :: { $IsNotNull(o, T) } $IsNotNull(o, T) <==> o != null && $Is(o, T));

function $As(ref, TName) : ref;

axiom (forall o: ref, T: TName :: $Is(o, T) ==> $As(o, T) == o);

axiom (forall o: ref, T: TName :: !$Is(o, T) ==> $As(o, T) == null);

axiom (forall h: HeapType, o: ref :: { $typeof(o) <: System.Array, h[o, $inv] } IsHeap(h) && o != null && $typeof(o) <: System.Array ==> h[o, $inv] == $typeof(o) && h[o, $localinv] == $typeof(o));

function IsAllocated<alpha>(h: HeapType, o: alpha) : bool;

axiom (forall<alpha> h: HeapType, o: ref, f: Field alpha :: { IsAllocated(h, h[o, f]) } IsHeap(h) && h[o, $allocated] ==> IsAllocated(h, h[o, f]));

axiom (forall h: HeapType, o: ref, f: Field ref :: { h[h[o, f], $allocated] } IsHeap(h) && h[o, $allocated] ==> h[h[o, f], $allocated]);

axiom (forall<alpha> h: HeapType, s: struct, f: Field alpha :: { IsAllocated(h, $StructGet(s, f)) } IsAllocated(h, s) ==> IsAllocated(h, $StructGet(s, f)));

axiom (forall<alpha> h: HeapType, e: Elements alpha, i: int :: { IsAllocated(h, ArrayGet(e, i)) } IsAllocated(h, e) ==> IsAllocated(h, ArrayGet(e, i)));

axiom (forall h: HeapType, o: ref :: { h[o, $allocated] } IsAllocated(h, o) ==> h[o, $allocated]);

axiom (forall h: HeapType, c: TName :: { h[ClassRepr(c), $allocated] } IsHeap(h) ==> h[ClassRepr(c), $allocated]);

const $BeingConstructed: ref;

const unique $NonNullFieldsAreInitialized: Field bool;

const $PurityAxiomsCanBeAssumed: bool;

axiom DeclType($NonNullFieldsAreInitialized) == System.Object;

function DeclType<alpha>(field: Field alpha) : TName;

function AsNonNullRefField(field: Field ref, T: TName) : Field ref;

function AsRefField(field: Field ref, T: TName) : Field ref;

function AsRangeField(field: Field int, T: TName) : Field int;

axiom (forall f: Field ref, T: TName :: { AsNonNullRefField(f, T) } AsNonNullRefField(f, T) == f ==> AsRefField(f, T) == f);

axiom (forall h: HeapType, o: ref, f: Field ref, T: TName :: { h[o, AsRefField(f, T)] } IsHeap(h) ==> $Is(h[o, AsRefField(f, T)], T));

axiom (forall h: HeapType, o: ref, f: Field ref, T: TName :: { h[o, AsNonNullRefField(f, T)] } IsHeap(h) && o != null && (o != $BeingConstructed || h[$BeingConstructed, $NonNullFieldsAreInitialized] == true) ==> h[o, AsNonNullRefField(f, T)] != null);

axiom (forall h: HeapType, o: ref, f: Field int, T: TName :: { h[o, AsRangeField(f, T)] } IsHeap(h) ==> InRange(h[o, AsRangeField(f, T)], T));

function $IsMemberlessType(TName) : bool;

axiom (forall o: ref :: { $IsMemberlessType($typeof(o)) } !$IsMemberlessType($typeof(o)));

function $AsInterface(TName) : TName;

axiom (forall J: TName :: { System.Object <: $AsInterface(J) } $AsInterface(J) == J ==> !(System.Object <: J));

axiom (forall<T> $J: TName, s: T, b: ref :: { UnboxedType(Box(s, b)) <: $AsInterface($J) } $AsInterface($J) == $J && Box(s, b) == b && UnboxedType(Box(s, b)) <: $AsInterface($J) ==> $typeof(b) <: $J);

function $HeapSucc(oldHeap: HeapType, newHeap: HeapType) : bool;

const unique $Freezer: TName;

const unique $freezerRef: ref;

const unique $frozen: Field bool;

function IsFrozen(o: ref, h: HeapType) : bool;

function AsFrozenField(f: Field ref) : Field ref;

function AsElementsFrozenField(f: Field ref, position: int) : Field ref;

function UltimateValue<alpha>(o: ref, f: Field alpha) : alpha;

axiom (forall h: HeapType, o: ref :: IsHeap(h) && IsFrozen(o, h) <==> h[o, $frozen]);

axiom (forall h: HeapType :: { IsFrozen($freezerRef, h) } IsHeap(h) ==> IsFrozen($freezerRef, h));

axiom (forall h: HeapType, o: ref :: { IsFrozen(o, h) } IsHeap(h) && o != null && h[h[o, $ownerRef], $frozen] ==> IsFrozen(o, h));

axiom (forall h: HeapType, o: ref, f: Field ref :: { h[o, AsFrozenField(f)] } IsHeap(h) && h[o, AsFrozenField(f)] != null ==> IsFrozen(h[o, AsFrozenField(f)], h));

axiom (forall h: HeapType, o: ref, f: Field ref, i: int :: { h[o, AsElementsFrozenField(f, i)] } IsHeap(h) && h[o, AsElementsFrozenField(f, i)] != null ==> IsFrozen($ElementProxy(h[o, AsElementsFrozenField(f, i)], i), h));

axiom (forall h: HeapType, o: ref, i: int :: { IsFrozen($ElementProxy(o, i), h) } h[$ElementProxy(o, 0 - 1), $frozen] ==> IsFrozen($ElementProxy(o, i), h));

axiom (forall h: HeapType, o: ref :: IsHeap(h) && h[o, $frozen] ==> (forall p: ref :: { $typeof(p) } { h[p, $localinv] } { h[p, $inv] } { h[p, $ownerRef] } { h[p, $ownerFrame] } p != null && h[p, $allocated] && h[p, $ownerRef] == h[o, $ownerRef] && h[p, $ownerFrame] == h[o, $ownerFrame] ==> h[p, $inv] == $typeof(p) && h[p, $localinv] == $typeof(p)));

axiom (forall h: HeapType, o: ref :: { h[o, $ownerRef] } { h[o, $ownerFrame] } { h[o, $inv] } { h[o, $localinv] } IsHeap(h) && h[o, $allocated] && h[o, $ownerRef] == $freezerRef && h[o, $ownerFrame] == $Freezer ==> h[o, $inv] == $typeof(o) && h[o, $localinv] == $typeof(o));

axiom (forall h: HeapType, o: ref, p: ref :: { h[o, $frozen], h[p, $allocated] } IsHeap(h) && h[o, $frozen] && p != null && h[p, $ownerRef] == h[o, $ownerRef] && h[p, $ownerFrame] == h[o, $ownerFrame] ==> IsFrozen(p, h));

axiom (forall<alpha> h: HeapType, o: ref, f: Field alpha :: { IsHeap(h), UltimateValue(o, f) } IsHeap(h) && f != $frozen && f != $allocated && f != $ownerRef && f != $ownerFrame && f != $elementsRef && f != $elementsInt && f != $elementsBool /*&& f != $elementsReal*/ && f != $elementsStruct && h[o, $frozen] ==> h[o, f] == UltimateValue(o, f));

axiom (forall oldHeap: HeapType, newHeap: HeapType, o: ref :: { $HeapSucc(oldHeap, newHeap), IsFrozen(o, newHeap) } $HeapSucc(oldHeap, newHeap) && oldHeap[o, $frozen] ==> IsFrozen(o, newHeap));

procedure $UpdateOwnersForFrozen(x: ref);
  modifies $Heap;
  ensures (forall<alpha> p: ref, F: Field alpha :: { $Heap[p, F] } (F != $ownerRef && F != $ownerFrame && F != $FirstConsistentOwner) || old($Heap[p, $ownerRef] != $Heap[x, $ownerRef] || $Heap[p, $ownerFrame] != $Heap[x, $ownerFrame]) ==> old($Heap[p, F]) == $Heap[p, F]);
  ensures x == null ==> $Heap == old($Heap);
  ensures x != null ==> (forall p: ref :: { $Heap[p, $ownerRef] } { $Heap[p, $ownerFrame] } old($Heap[p, $ownerRef] == $Heap[x, $ownerRef] && $Heap[p, $ownerFrame] == $Heap[x, $ownerFrame]) ==> $Heap[p, $ownerRef] == $freezerRef && $Heap[p, $ownerFrame] == $Freezer);
  free ensures $HeapSucc(old($Heap), $Heap);



const unique System.String: TName;

function $StringLength(ref) : int;

axiom (forall s: ref :: { $StringLength(s) } 0 <= $StringLength(s));

function AsRepField(f: Field ref, declaringType: TName) : Field ref;

axiom (forall h: HeapType, o: ref, f: Field ref, T: TName :: { h[o, AsRepField(f, T)] } IsHeap(h) && h[o, AsRepField(f, T)] != null ==> h[h[o, AsRepField(f, T)], $ownerRef] == o && h[h[o, AsRepField(f, T)], $ownerFrame] == T);

function AsPeerField(f: Field ref) : Field ref;

axiom (forall h: HeapType, o: ref, f: Field ref :: { h[o, AsPeerField(f)] } IsHeap(h) && h[o, AsPeerField(f)] != null ==> h[h[o, AsPeerField(f)], $ownerRef] == h[o, $ownerRef] && h[h[o, AsPeerField(f)], $ownerFrame] == h[o, $ownerFrame]);

function AsElementsRepField(f: Field ref, declaringType: TName, position: int) : Field ref;

axiom (forall h: HeapType, o: ref, f: Field ref, T: TName, i: int :: { h[o, AsElementsRepField(f, T, i)] } IsHeap(h) && h[o, AsElementsRepField(f, T, i)] != null ==> h[$ElementProxy(h[o, AsElementsRepField(f, T, i)], i), $ownerRef] == o && h[$ElementProxy(h[o, AsElementsRepField(f, T, i)], i), $ownerFrame] == T);

function AsElementsPeerField(f: Field ref, position: int) : Field ref;

axiom (forall h: HeapType, o: ref, f: Field ref, i: int :: { h[o, AsElementsPeerField(f, i)] } IsHeap(h) && h[o, AsElementsPeerField(f, i)] != null ==> h[$ElementProxy(h[o, AsElementsPeerField(f, i)], i), $ownerRef] == h[o, $ownerRef] && h[$ElementProxy(h[o, AsElementsPeerField(f, i)], i), $ownerFrame] == h[o, $ownerFrame]);

axiom (forall h: HeapType, o: ref :: { h[h[o, $ownerRef], $inv] <: h[o, $ownerFrame] } IsHeap(h) && h[o, $ownerFrame] != $PeerGroupPlaceholder && h[h[o, $ownerRef], $inv] <: h[o, $ownerFrame] && h[h[o, $ownerRef], $localinv] != $BaseClass(h[o, $ownerFrame]) ==> h[o, $inv] == $typeof(o) && h[o, $localinv] == $typeof(o));

procedure $SetOwner(o: ref, ow: ref, fr: TName);
  modifies $Heap;
  ensures (forall<alpha> p: ref, F: Field alpha :: { $Heap[p, F] } (F != $ownerRef && F != $ownerFrame) || old($Heap[p, $ownerRef] != $Heap[o, $ownerRef]) || old($Heap[p, $ownerFrame] != $Heap[o, $ownerFrame]) ==> old($Heap[p, F]) == $Heap[p, F]);
  ensures (forall p: ref :: { $Heap[p, $ownerRef] } { $Heap[p, $ownerFrame] } old($Heap[p, $ownerRef] == $Heap[o, $ownerRef]) && old($Heap[p, $ownerFrame] == $Heap[o, $ownerFrame]) ==> $Heap[p, $ownerRef] == ow && $Heap[p, $ownerFrame] == fr);
  free ensures $HeapSucc(old($Heap), $Heap);



procedure $UpdateOwnersForRep(o: ref, T: TName, e: ref);
  modifies $Heap;
  ensures (forall<alpha> p: ref, F: Field alpha :: { $Heap[p, F] } (F != $ownerRef && F != $ownerFrame) || old($Heap[p, $ownerRef] != $Heap[e, $ownerRef]) || old($Heap[p, $ownerFrame] != $Heap[e, $ownerFrame]) ==> old($Heap[p, F]) == $Heap[p, F]);
  ensures e == null ==> $Heap == old($Heap);
  ensures e != null ==> (forall p: ref :: { $Heap[p, $ownerRef] } { $Heap[p, $ownerFrame] } old($Heap[p, $ownerRef] == $Heap[e, $ownerRef]) && old($Heap[p, $ownerFrame] == $Heap[e, $ownerFrame]) ==> $Heap[p, $ownerRef] == o && $Heap[p, $ownerFrame] == T);
  free ensures $HeapSucc(old($Heap), $Heap);



procedure $UpdateOwnersForPeer(c: ref, d: ref);
  modifies $Heap;
  ensures (forall<alpha> p: ref, F: Field alpha :: { $Heap[p, F] } (F != $ownerRef && F != $ownerFrame) || old($Heap[p, $ownerRef] != $Heap[d, $ownerRef] || $Heap[p, $ownerFrame] != $Heap[d, $ownerFrame]) ==> old($Heap[p, F]) == $Heap[p, F]);
  ensures d == null ==> $Heap == old($Heap);
  ensures d != null ==> (forall p: ref :: { $Heap[p, $ownerRef] } { $Heap[p, $ownerFrame] } old($Heap[p, $ownerRef] == $Heap[d, $ownerRef] && $Heap[p, $ownerFrame] == $Heap[d, $ownerFrame]) ==> $Heap[p, $ownerRef] == old($Heap)[c, $ownerRef] && $Heap[p, $ownerFrame] == old($Heap)[c, $ownerFrame]);
  free ensures $HeapSucc(old($Heap), $Heap);



const unique $FirstConsistentOwner: Field ref;

function $AsPureObject(ref) : ref;

function ##FieldDependsOnFCO<alpha>(o: ref, f: Field alpha, ev: exposeVersionType) : alpha;

axiom (forall<alpha> o: ref, f: Field alpha, h: HeapType :: { h[$AsPureObject(o), f] } IsHeap(h) && o != null && h[o, $allocated] == true && $AsPureObject(o) == o && h[o, $ownerFrame] != $PeerGroupPlaceholder && h[h[o, $ownerRef], $inv] <: h[o, $ownerFrame] && h[h[o, $ownerRef], $localinv] != $BaseClass(h[o, $ownerFrame]) ==> h[o, f] == ##FieldDependsOnFCO(o, f, h[h[o, $FirstConsistentOwner], $exposeVersion]));

axiom (forall o: ref, h: HeapType :: { h[o, $FirstConsistentOwner] } IsHeap(h) && o != null && h[o, $allocated] == true && h[o, $ownerFrame] != $PeerGroupPlaceholder && h[h[o, $ownerRef], $inv] <: h[o, $ownerFrame] && h[h[o, $ownerRef], $localinv] != $BaseClass(h[o, $ownerFrame]) ==> h[o, $FirstConsistentOwner] != null && h[h[o, $FirstConsistentOwner], $allocated] == true && (h[h[o, $FirstConsistentOwner], $ownerFrame] == $PeerGroupPlaceholder || !(h[h[h[o, $FirstConsistentOwner], $ownerRef], $inv] <: h[h[o, $FirstConsistentOwner], $ownerFrame]) || h[h[h[o, $FirstConsistentOwner], $ownerRef], $localinv] == $BaseClass(h[h[o, $FirstConsistentOwner], $ownerFrame])));

function Box<T>(T, ref) : ref;

function Unbox<T>(ref) : T;

type NondetType;

function MeldNondets<a>(NondetType, a) : NondetType;

function BoxFunc<T>(value: T, typ: TName) : ref;

function AllocFunc(typ: TName) : ref;

function NewInstance(object: ref, occurrence: NondetType, activity: ActivityType) : ref;

axiom (forall<T> value: T, typ: TName, occurrence: NondetType, activity: ActivityType :: { NewInstance(BoxFunc(value, typ), occurrence, activity) } Box(value, NewInstance(BoxFunc(value, typ), occurrence, activity)) == NewInstance(BoxFunc(value, typ), occurrence, activity) && UnboxedType(NewInstance(BoxFunc(value, typ), occurrence, activity)) == typ);

axiom (forall x: ref, typ: TName, occurrence: NondetType, activity: ActivityType :: !$IsValueType(UnboxedType(x)) ==> NewInstance(BoxFunc(x, typ), occurrence, activity) == x);

axiom (forall<T> x: T, p: ref :: { Unbox(Box(x, p)): T } Unbox(Box(x, p)) == x);

function UnboxedType(ref) : TName;

axiom (forall p: ref :: { $IsValueType(UnboxedType(p)) } $IsValueType(UnboxedType(p)) ==> (forall<T> heap: HeapType, x: T :: { heap[Box(x, p), $inv] } IsHeap(heap) ==> heap[Box(x, p), $inv] == $typeof(Box(x, p)) && heap[Box(x, p), $localinv] == $typeof(Box(x, p))));

axiom (forall<T> x: T, p: ref :: { UnboxedType(Box(x, p)) <: System.Object } UnboxedType(Box(x, p)) <: System.Object && Box(x, p) == p ==> x == p);

function BoxTester(p: ref, typ: TName) : ref;

axiom (forall p: ref, typ: TName :: { BoxTester(p, typ) } UnboxedType(p) == typ <==> BoxTester(p, typ) != null);

axiom (forall p: ref, typ: TName :: { BoxTester(p, typ) } BoxTester(p, typ) != null ==> (forall<T>  :: Box(Unbox(p): T, p) == p));

function BoxDisguise<U>(U) : ref;

function UnBoxDisguise<U>(ref) : U;

axiom (forall<U> x: ref, p: ref :: { Unbox(Box(x, p)): U } Box(x, p) == p ==> Unbox(Box(x, p)): U == UnBoxDisguise(x) && BoxDisguise(Unbox(Box(x, p)): U) == x);

axiom (forall typ: TName, occurrence: NondetType, activity: ActivityType :: { NewInstance(AllocFunc(typ), occurrence, activity) } $typeof(NewInstance(AllocFunc(typ), occurrence, activity)) == typ && NewInstance(AllocFunc(typ), occurrence, activity) != null);

axiom (forall typ: TName, occurrence: NondetType, activity: ActivityType, heap: HeapType :: { heap[NewInstance(AllocFunc(typ), occurrence, activity), $allocated] } IsHeap(heap) ==> heap[NewInstance(AllocFunc(typ), occurrence, activity), $allocated]);

const unique System.SByte: TName;

axiom $IsValueType(System.SByte);

const unique System.Byte: TName;

axiom $IsValueType(System.Byte);

const unique System.Int16: TName;

axiom $IsValueType(System.Int16);

const unique System.UInt16: TName;

axiom $IsValueType(System.UInt16);

const unique System.Int32: TName;

axiom $IsValueType(System.Int32);

const unique System.UInt32: TName;

axiom $IsValueType(System.UInt32);

const unique System.Int64: TName;

axiom $IsValueType(System.Int64);

const unique System.UInt64: TName;

axiom $IsValueType(System.UInt64);

const unique System.Char: TName;

axiom $IsValueType(System.Char);

const unique System.UIntPtr: TName;

axiom $IsValueType(System.UIntPtr);

const unique System.IntPtr: TName;

axiom $IsValueType(System.IntPtr);

function InRange(i: int, T: TName) : bool;

axiom (forall i: int :: InRange(i, System.SByte) <==> 0 - 128 <= i && i < 128);

axiom (forall i: int :: InRange(i, System.Byte) <==> 0 <= i && i < 256);

axiom (forall i: int :: InRange(i, System.Int16) <==> 0 - 32768 <= i && i < 32768);

axiom (forall i: int :: InRange(i, System.UInt16) <==> 0 <= i && i < 65536);

axiom (forall i: int :: InRange(i, System.Int32) <==> 0 - 2147483648 <= i && i <= 2147483647);

axiom (forall i: int :: InRange(i, System.UInt32) <==> 0 <= i && i <= 4294967295);

axiom (forall i: int :: InRange(i, System.Int64) <==> 0 - 9223372036854775808 <= i && i <= 9223372036854775807);

axiom (forall i: int :: InRange(i, System.UInt64) <==> 0 <= i && i <= 18446744073709551615);

axiom (forall i: int :: InRange(i, System.Char) <==> 0 <= i && i < 65536);

function $IntToInt(val: int, fromType: TName, toType: TName) : int;

/*function $IntToReal(val: int, fromType: TName, toType: TName) : real;

function $RealToInt(val: real, fromType: TName, toType: TName) : int;

function $RealToReal(val: real, fromType: TName, toType: TName) : real;*/

axiom (forall z: int, B: TName, C: TName :: InRange(z, C) ==> $IntToInt(z, B, C) == z);

function $SizeIs(TName, int) : bool;

function $IfThenElse<a>(bool, a, a) : a;

axiom (forall<a> b: bool, x: a, y: a :: { $IfThenElse(b, x, y) } b ==> $IfThenElse(b, x, y) == x);

axiom (forall<a> b: bool, x: a, y: a :: { $IfThenElse(b, x, y) } !b ==> $IfThenElse(b, x, y) == y);

function #neg(int) : int;

function #and(int, int) : int;

function #or(int, int) : int;

function #xor(int, int) : int;

function #shl(int, int) : int;

function #shr(int, int) : int;

/*function #rneg(real) : real;

function #radd(real, real) : real;

function #rsub(real, real) : real;

function #rmul(real, real) : real;

function #rdiv(real, real) : real;

function #rmod(real, real) : real;

function #rLess(real, real) : bool;

function #rAtmost(real, real) : bool;

function #rEq(real, real) : bool;

function #rNeq(real, real) : bool;

function #rAtleast(real, real) : bool;

function #rGreater(real, real) : bool;
*/
//function mod(int,int) : int;

axiom (forall x: int, y: int :: { x mod y } { x div y } x mod y == x - x div y * y);

axiom (forall x: int, y: int :: { x mod y } 0 <= x && 0 < y ==> 0 <= x mod y && x mod y < y);

axiom (forall x: int, y: int :: { x mod y } 0 <= x && y < 0 ==> 0 <= x mod y && x mod y < 0 - y);

axiom (forall x: int, y: int :: { x mod y } x <= 0 && 0 < y ==> 0 - y < x mod y && x mod y <= 0);

axiom (forall x: int, y: int :: { x mod y } x <= 0 && y < 0 ==> y < x mod y && x mod y <= 0);

axiom (forall x: int, y: int :: { (x + y) mod y } 0 <= x && 0 <= y ==> (x + y) mod y == x mod y);

axiom (forall x: int, y: int :: { (y + x) mod y } 0 <= x && 0 <= y ==> (y + x) mod y == x mod y);

axiom (forall x: int, y: int :: { (x - y) mod y } 0 <= x - y && 0 <= y ==> (x - y) mod y == x mod y);

axiom (forall a: int, b: int, d: int :: { a mod d, b mod d } 2 <= d && a mod d == b mod d && a < b ==> a + d <= b);

axiom (forall x: int, y: int :: { #and(x, y) } #and(x, y) == #and(y, x));

axiom (forall x: int, y: int :: { #or(x, y) } #or(x, y) == #or(y, x));

axiom (forall x: int, y: int :: { #and(x, y) } 0 <= x || 0 <= y ==> 0 <= #and(x, y));

axiom (forall x: int, y: int :: { #or(x, y) } 0 <= x && 0 <= y ==> 0 <= #or(x, y) && #or(x, y) <= x + y);

axiom (forall x: int :: { #and(x, 0 - 1) } #and(x, 0 - 1) == x);

axiom (forall x: int :: { #and(x, 0) } #and(x, 0) == 0);

axiom (forall x: int :: { #or(x, 0 - 1) } #or(x, 0 - 1) == 0 - 1);

axiom (forall x: int :: { #or(x, 0) } #or(x, 0) == x);

axiom (forall i: int :: { #shl(i, 0) } #shl(i, 0) == i);

axiom (forall i: int, j: int :: { #shl(i, j) } 1 <= j ==> #shl(i, j) == #shl(i, j - 1) * 2);

axiom (forall i: int, j: int :: { #shl(i, j) } 0 <= i && i < 32768 && 0 <= j && j <= 16 ==> 0 <= #shl(i, j) && #shl(i, j) <= 2147483647);

axiom (forall i: int :: { #shr(i, 0) } #shr(i, 0) == i);

axiom (forall i: int, j: int :: { #shr(i, j) } 1 <= j ==> #shr(i, j) == #shr(i, j - 1) div 2 );

function #min(int, int) : int;

function #max(int, int) : int;

axiom (forall x: int, y: int :: { #min(x, y) } (#min(x, y) == x || #min(x, y) == y) && #min(x, y) <= x && #min(x, y) <= y);

axiom (forall x: int, y: int :: { #max(x, y) } (#max(x, y) == x || #max(x, y) == y) && x <= #max(x, y) && y <= #max(x, y));

function #System.String.IsInterned$System.String$notnull(HeapType, ref) : ref;

function #System.String.Equals$System.String(HeapType, ref, ref) : bool;

function #System.String.Equals$System.String$System.String(HeapType, ref, ref) : bool;

function ##StringEquals(ref, ref) : bool;

axiom (forall h: HeapType, a: ref, b: ref :: { #System.String.Equals$System.String(h, a, b) } #System.String.Equals$System.String(h, a, b) == #System.String.Equals$System.String$System.String(h, a, b));

axiom (forall h: HeapType, a: ref, b: ref :: { #System.String.Equals$System.String$System.String(h, a, b) } #System.String.Equals$System.String$System.String(h, a, b) == ##StringEquals(a, b) && #System.String.Equals$System.String$System.String(h, a, b) == ##StringEquals(b, a) && (a == b ==> ##StringEquals(a, b)));

axiom (forall a: ref, b: ref, c: ref :: ##StringEquals(a, b) && ##StringEquals(b, c) ==> ##StringEquals(a, c));

axiom (forall h: HeapType, a: ref, b: ref :: { #System.String.Equals$System.String$System.String(h, a, b) } a != null && b != null && #System.String.Equals$System.String$System.String(h, a, b) ==> #System.String.IsInterned$System.String$notnull(h, a) == #System.String.IsInterned$System.String$notnull(h, b));

const unique SExpressionSimplifier.Nary.F: Field ref;

const unique SExpressionSimplifier.Nary.Args: Field ref;

const unique System.IComparable`1...System.String: TName;

const unique System.Collections.IList: TName;

const unique SExpressionSimplifier.PrettySx.Token: TName;

const unique System.ICloneable: TName;

const unique SExpressionSimplifier.Nary: TName;

const unique System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator: TName;

const unique System.IO.TextWriter: TName;

const unique System.MarshalByRefObject: TName;

const unique System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx: TName;

const unique System.Collections.ICollection: TName;

const unique System.Collections.Generic.IEnumerable`1...System.Char: TName;

const unique System.IConvertible: TName;

const unique System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx: TName;

const unique System.Collections.IEnumerable: TName;

const unique System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx: TName;

const unique SExpressionSimplifier.PrettySx: TName;

const unique System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx: TName;

const unique System.Collections.IEnumerator: TName;

const unique System.IEquatable`1...System.String: TName;

const unique System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx: TName;

const unique SExpressionSimplifier.Sx: TName;

const unique System.IDisposable: TName;

const unique SExpressionSimplifier.Atom: TName;

const unique System.IComparable: TName;

axiom !IsStaticField(SExpressionSimplifier.Nary.F);

axiom IncludeInMainFrameCondition(SExpressionSimplifier.Nary.F);

axiom $IncludedInModifiesStar(SExpressionSimplifier.Nary.F);

axiom AsFrozenField(SExpressionSimplifier.Nary.F) == SExpressionSimplifier.Nary.F;

axiom DeclType(SExpressionSimplifier.Nary.F) == SExpressionSimplifier.Nary;

axiom AsNonNullRefField(SExpressionSimplifier.Nary.F, System.String) == SExpressionSimplifier.Nary.F;

axiom !IsStaticField(SExpressionSimplifier.Nary.Args);

axiom IncludeInMainFrameCondition(SExpressionSimplifier.Nary.Args);

axiom $IncludedInModifiesStar(SExpressionSimplifier.Nary.Args);

axiom AsRepField(SExpressionSimplifier.Nary.Args, SExpressionSimplifier.Nary) == SExpressionSimplifier.Nary.Args;

axiom AsElementsFrozenField(SExpressionSimplifier.Nary.Args, 0) == SExpressionSimplifier.Nary.Args;

axiom DeclType(SExpressionSimplifier.Nary.Args) == SExpressionSimplifier.Nary;

axiom AsNonNullRefField(SExpressionSimplifier.Nary.Args, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) == SExpressionSimplifier.Nary.Args;

function #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count(HeapType, ref) : int;

function ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count(exposeVersionType) : int;

function #SExpressionSimplifier.Sx.get_IsTrue(HeapType, ref) : bool;

function ##SExpressionSimplifier.Sx.get_IsTrue(exposeVersionType) : bool;

function #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32(HeapType, ref, int) : ref;

function ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32(exposeVersionType, int) : ref;

function #System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32(HeapType, ref, int) : ref;

function ##System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32(exposeVersionType, int) : ref;

function #System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count(HeapType, ref) : int;

function ##System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count(exposeVersionType) : int;

function #System.Collections.ICollection.get_Count(HeapType, ref) : int;

function ##System.Collections.ICollection.get_Count(exposeVersionType) : int;

function #SExpressionSimplifier.Sx.get_IsFalse(HeapType, ref) : bool;

function ##SExpressionSimplifier.Sx.get_IsFalse(exposeVersionType) : bool;

function #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator(HeapType, ref) : struct;

function ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator(exposeVersionType) : struct;

function #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current(HeapType, struct) : ref;

function ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current(struct) : ref;

function #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current(HeapType, ref) : ref;

function ##System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current(exposeVersionType) : ref;

axiom SExpressionSimplifier.PrettySx <: SExpressionSimplifier.PrettySx;

axiom $BaseClass(SExpressionSimplifier.PrettySx) == System.Object && AsDirectSubClass(SExpressionSimplifier.PrettySx, $BaseClass(SExpressionSimplifier.PrettySx)) == SExpressionSimplifier.PrettySx;

// SExpressionSimplifier.PrettySx object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: SExpressionSimplifier.PrettySx } IsHeap($h) && $h[$oi, $inv] <: SExpressionSimplifier.PrettySx && $h[$oi, $localinv] != $BaseClass(SExpressionSimplifier.PrettySx) ==> true);

// enum definition for SExpressionSimplifier.PrettySx+Token
axiom (forall $ev: int :: { InRange($ev, SExpressionSimplifier.PrettySx.Token) } InRange($ev, SExpressionSimplifier.PrettySx.Token) <==> 0 <= $ev && $ev <= 2);

axiom SExpressionSimplifier.Sx <: SExpressionSimplifier.Sx;

axiom $BaseClass(SExpressionSimplifier.Sx) == System.Object && AsDirectSubClass(SExpressionSimplifier.Sx, $BaseClass(SExpressionSimplifier.Sx)) == SExpressionSimplifier.Sx;

axiom $IsMemberlessType(SExpressionSimplifier.Sx);

axiom SExpressionSimplifier.Atom <: SExpressionSimplifier.Atom;

axiom $BaseClass(SExpressionSimplifier.Atom) == SExpressionSimplifier.Sx && AsDirectSubClass(SExpressionSimplifier.Atom, $BaseClass(SExpressionSimplifier.Atom)) == SExpressionSimplifier.Atom;

axiom (forall $U: TName :: { $U <: SExpressionSimplifier.Atom } $U <: SExpressionSimplifier.Atom ==> $U == SExpressionSimplifier.Atom);

// SExpressionSimplifier.Atom object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: SExpressionSimplifier.Atom } IsHeap($h) && $h[$oi, $inv] <: SExpressionSimplifier.Atom && $h[$oi, $localinv] != $BaseClass(SExpressionSimplifier.Atom) ==> true);

axiom SExpressionSimplifier.Nary <: SExpressionSimplifier.Nary;

axiom $BaseClass(SExpressionSimplifier.Nary) == SExpressionSimplifier.Sx && AsDirectSubClass(SExpressionSimplifier.Nary, $BaseClass(SExpressionSimplifier.Nary)) == SExpressionSimplifier.Nary;

axiom (forall $U: TName :: { $U <: SExpressionSimplifier.Nary } $U <: SExpressionSimplifier.Nary ==> $U == SExpressionSimplifier.Nary);

// SExpressionSimplifier.Nary object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: SExpressionSimplifier.Nary } IsHeap($h) && $h[$oi, $inv] <: SExpressionSimplifier.Nary && $h[$oi, $localinv] != $BaseClass(SExpressionSimplifier.Nary) ==> true);

axiom (forall $U: TName :: { $U <: SExpressionSimplifier.Sx } $U <: SExpressionSimplifier.Sx ==> $U == SExpressionSimplifier.Sx || $U <: SExpressionSimplifier.Atom || $U <: SExpressionSimplifier.Nary);

// SExpressionSimplifier.Sx object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: SExpressionSimplifier.Sx } IsHeap($h) && $h[$oi, $inv] <: SExpressionSimplifier.Sx && $h[$oi, $localinv] != $BaseClass(SExpressionSimplifier.Sx) ==> true);

axiom System.IO.TextWriter <: System.IO.TextWriter;

axiom System.MarshalByRefObject <: System.MarshalByRefObject;

axiom $BaseClass(System.MarshalByRefObject) == System.Object && AsDirectSubClass(System.MarshalByRefObject, $BaseClass(System.MarshalByRefObject)) == System.MarshalByRefObject;

axiom $IsMemberlessType(System.MarshalByRefObject);

// System.MarshalByRefObject object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.MarshalByRefObject } IsHeap($h) && $h[$oi, $inv] <: System.MarshalByRefObject && $h[$oi, $localinv] != $BaseClass(System.MarshalByRefObject) ==> true);

axiom $BaseClass(System.IO.TextWriter) == System.MarshalByRefObject && AsDirectSubClass(System.IO.TextWriter, $BaseClass(System.IO.TextWriter)) == System.IO.TextWriter;

axiom System.IDisposable <: System.IDisposable;

axiom $IsMemberlessType(System.IDisposable);

axiom $AsInterface(System.IDisposable) == System.IDisposable;

axiom System.IO.TextWriter <: System.IDisposable;

axiom $IsMemberlessType(System.IO.TextWriter);

// System.IO.TextWriter object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.IO.TextWriter } IsHeap($h) && $h[$oi, $inv] <: System.IO.TextWriter && $h[$oi, $localinv] != $BaseClass(System.IO.TextWriter) ==> true);

procedure SExpressionSimplifier.Sx.Write$System.IO.TextWriter$notnull(this: ref where $IsNotNull(this, SExpressionSimplifier.Sx) && $Heap[this, $allocated], wr$in: ref where $IsNotNull(wr$in, System.IO.TextWriter) && $Heap[wr$in, $allocated]);
  // target object is frozen
  requires IsFrozen(this, $Heap);
  // wr is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[wr$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[wr$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // wr is peer consistent (owner must not be valid)
  requires $Heap[wr$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[wr$in, $ownerRef], $inv] <: $Heap[wr$in, $ownerFrame]) || $Heap[$Heap[wr$in, $ownerRef], $localinv] == $BaseClass($Heap[wr$in, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(wr$in) || !($typeof(old(wr$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(wr$in) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Nary.Simplify(this: ref where $IsNotNull(this, SExpressionSimplifier.Nary) && $Heap[this, $allocated]) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Sx) && $Heap[$result, $allocated]);
  // target object is frozen
  requires IsFrozen(this, $Heap);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



implementation SExpressionSimplifier.Nary.Simplify(this: ref) returns ($result: ref)
{
  var local4: ref where $Is(local4, System.String) && $Heap[local4, $allocated] && (local4 != null ==> IsFrozen(local4, $Heap));
  var stack0o: ref;
  var stack0b: bool;
  var local5: ref where $Is(local5, System.String) && $Heap[local5, $allocated] && (local5 != null ==> IsFrozen(local5, $Heap));
  var return.value: ref where $Is(return.value, SExpressionSimplifier.Sx) && $Heap[return.value, $allocated] && (return.value != null ==> IsFrozen(return.value, $Heap));
  var SS$Display.Return.Local: ref where $Is(SS$Display.Return.Local, SExpressionSimplifier.Sx) && $Heap[SS$Display.Return.Local, $allocated] && (SS$Display.Return.Local != null ==> IsFrozen(SS$Display.Return.Local, $Heap));
  var stack50000o: ref;
  var aa: ref where $Is(aa, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[aa, $allocated];
  var stack1b: bool;
  var stack1o: ref;
  var a1: ref where $Is(a1, SExpressionSimplifier.Sx) && $Heap[a1, $allocated] && (a1 != null ==> IsFrozen(a1, $Heap));
  var a0: ref where $Is(a0, SExpressionSimplifier.Sx) && $Heap[a0, $allocated] && (a0 != null ==> IsFrozen(a0, $Heap));
  var stack1i: int;
  var stack0i: int;
  var argList: ref where $Is(argList, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[argList, $allocated];
  var i: int where InRange(i, System.Int32);
  var n: ref where $Is(n, SExpressionSimplifier.Nary) && $Heap[n, $allocated] && (n != null ==> IsFrozen(n, $Heap));
  var local17: int where InRange(local17, System.Int32);
  var cmp: ref where $Is(cmp, SExpressionSimplifier.Nary) && $Heap[cmp, $allocated] && (cmp != null ==> IsFrozen(cmp, $Heap));
  var local18: ref where $Is(local18, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[local18, $allocated];
  var foreachEnumerator^.33574638: struct where IsAllocated($Heap, foreachEnumerator^.33574638);
  var stack2i: int;
  var stack2o: ref;
  var stack3i: int;
  var local20: ref where $Is(local20, SExpressionSimplifier.Sx) && $Heap[local20, $allocated] && (local20 != null ==> IsFrozen(local20, $Heap));
  var arg: ref where $Is(arg, SExpressionSimplifier.Sx) && $Heap[arg, $allocated] && (arg != null ==> IsFrozen(arg, $Heap));
  var $Heap$block13957$LoopPreheader: HeapType;
  var $Heap$block13685$LoopPreheader: HeapType;

  entry:
    goto block12444;

  block12444:
    goto block13736;

  block13736:
    // ----- load field  ----- PrettySx.ssc(355,15)
    assert this != null;
    local4 := $Heap[this, SExpressionSimplifier.Nary.F];
    stack0o := null;
    // ----- binary operator  ----- PrettySx.ssc(355,15)
    // ----- branch  ----- PrettySx.ssc(355,15)
    goto true13736to13073, false13736to12648;

  true13736to13073:
    assume local4 == stack0o;
    goto block13073;

  false13736to12648:
    assume local4 != stack0o;
    goto block12648;

  block13073:
    // ----- copy  ----- PrettySx.ssc(441,11)
    return.value := this;
    // ----- branch  ----- PrettySx.ssc(441,11)
    goto block12750;

  block12648:
    // ----- copy
    stack0o := local4;
    // ----- call
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call local5 := System.String.IsInterned$System.String$notnull(stack0o);
    stack0o := null;
    // ----- binary operator
    // ----- branch
    goto true12648to13073, false12648to13243;

  true12648to13073:
    assume local5 == stack0o;
    goto block13073;

  false12648to13243:
    assume local5 != stack0o;
    goto block13243;

  block13243:
    // ----- copy
    local4 := local5;
    // ----- load constant "AND"
    stack0o := $stringLiteral0;
    // ----- binary operator
    // ----- branch
    goto true13243to13090, false13243to13022;

  true13243to13090:
    assume local4 == stack0o;
    goto block13090;

  false13243to13022:
    assume local4 != stack0o;
    goto block13022;

  block13090:
    // ----- new object  ----- PrettySx.ssc(357,11)
    havoc stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $allocated] == false && $ElementProxy(stack50000o, 0) != null && $ElementProxy(stack50000o, 0) != stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $ownerRef] == $ElementProxy(stack50000o, 0) && $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    call System.Object..ctor($ElementProxy(stack50000o, 0));
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- PrettySx.ssc(357,11)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: DeclType($f))) && true && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx..ctor(stack50000o);
    assert $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    assert (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[$ElementProxy(stack50000o, 0), $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    call $UpdateOwnersForFrozen($ElementProxy(stack50000o, 0));
    // ----- copy  ----- PrettySx.ssc(357,11)
    stack0o := stack50000o;
    // ----- copy  ----- PrettySx.ssc(357,11)
    aa := stack0o;
    // ----- copy  ----- PrettySx.ssc(358,11)
    stack0o := aa;
    // ----- load constant 1  ----- PrettySx.ssc(358,11)
    stack1b := true;
    // ----- call  ----- PrettySx.ssc(358,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call SExpressionSimplifier.Nary.CollectArguments$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull$System.Boolean(this, stack0o, stack1b);
    // ----- load constant 1  ----- PrettySx.ssc(359,11)
    stack0b := true;
    // ----- copy  ----- PrettySx.ssc(359,11)
    stack1o := aa;
    // ----- call  ----- PrettySx.ssc(359,11)
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && !(($f == $ownerRef || $f == $ownerFrame) && $Heap[$o, $ownerRef] == $Heap[stack1o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap[stack1o, $ownerFrame]) && ($o != stack1o || !($typeof(stack1o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack1o || $f != $exposeVersion));
    call return.value := SExpressionSimplifier.Nary.JunctionFromArguments$System.Boolean$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull(stack0b, stack1o);
    // ----- branch  ----- PrettySx.ssc(359,11)
    goto block12750;

  block13022:
    // ----- load constant "OR"
    stack0o := $stringLiteral1;
    // ----- binary operator
    // ----- branch
    goto true13022to14042, false13022to12852;

  block12750:
    // ----- copy
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- PrettySx.ssc(443,5)
    stack0o := return.value;
    // ----- return  ----- PrettySx.ssc(443,5)
    $result := stack0o;
    return;

  true13022to14042:
    assume local4 == stack0o;
    goto block14042;

  false13022to12852:
    assume local4 != stack0o;
    goto block12852;

  block14042:
    // ----- new object  ----- PrettySx.ssc(362,11)
    havoc stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $allocated] == false && $ElementProxy(stack50000o, 0) != null && $ElementProxy(stack50000o, 0) != stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $ownerRef] == $ElementProxy(stack50000o, 0) && $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    call System.Object..ctor($ElementProxy(stack50000o, 0));
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- PrettySx.ssc(362,11)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: DeclType($f))) && true && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx..ctor(stack50000o);
    assert $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    assert (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[$ElementProxy(stack50000o, 0), $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    call $UpdateOwnersForFrozen($ElementProxy(stack50000o, 0));
    // ----- copy  ----- PrettySx.ssc(362,11)
    stack0o := stack50000o;
    // ----- copy  ----- PrettySx.ssc(362,11)
    aa := stack0o;
    // ----- copy  ----- PrettySx.ssc(363,11)
    stack0o := aa;
    // ----- load constant 0  ----- PrettySx.ssc(363,11)
    stack1b := false;
    // ----- call  ----- PrettySx.ssc(363,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call SExpressionSimplifier.Nary.CollectArguments$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull$System.Boolean(this, stack0o, stack1b);
    // ----- load constant 0  ----- PrettySx.ssc(364,11)
    stack0b := false;
    // ----- copy  ----- PrettySx.ssc(364,11)
    stack1o := aa;
    // ----- call  ----- PrettySx.ssc(364,11)
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && !(($f == $ownerRef || $f == $ownerFrame) && $Heap[$o, $ownerRef] == $Heap[stack1o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap[stack1o, $ownerFrame]) && ($o != stack1o || !($typeof(stack1o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack1o || $f != $exposeVersion));
    call return.value := SExpressionSimplifier.Nary.JunctionFromArguments$System.Boolean$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull(stack0b, stack1o);
    // ----- branch  ----- PrettySx.ssc(364,11)
    goto block12750;

  block12852:
    // ----- load constant "IMPLIES"
    stack0o := $stringLiteral2;
    // ----- binary operator
    // ----- branch
    goto true12852to14059, false12852to13702;

  true12852to14059:
    assume local4 == stack0o;
    goto block14059;

  false12852to13702:
    assume local4 != stack0o;
    goto block13702;

  block14059:
    // ----- serialized AssumeStatement  ----- PrettySx.ssc(367,11)
    assume #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, $Heap[this, SExpressionSimplifier.Nary.Args]) == 2;
    goto block13838;

  block13702:
    // ----- load constant "IFF"
    stack0o := $stringLiteral3;
    // ----- binary operator
    // ----- branch
    goto true13702to13175, false13702to13158;

  true13702to13175:
    assume local4 == stack0o;
    goto block13175;

  false13702to13158:
    assume local4 != stack0o;
    goto block13158;

  block13175:
    // ----- serialized AssumeStatement  ----- PrettySx.ssc(380,11)
    assume #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, $Heap[this, SExpressionSimplifier.Nary.Args]) == 2;
    goto block13634;

  block13158:
    // ----- load constant "NOT"
    stack0o := $stringLiteral5;
    // ----- binary operator
    // ----- branch
    goto true13158to13362, false13158to14025;

  true13158to13362:
    assume local4 == stack0o;
    goto block13362;

  false13158to14025:
    assume local4 != stack0o;
    goto block14025;

  block13362:
    // ----- serialized AssumeStatement  ----- PrettySx.ssc(394,11)
    assume #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, $Heap[this, SExpressionSimplifier.Nary.Args]) == 1;
    goto block13651;

  block14025:
    // ----- load constant "FORALL"
    stack0o := $stringLiteral7;
    // ----- binary operator
    // ----- branch
    goto true14025to12478, false14025to13396;

  block13838:
    // ----- nop
    // ----- new object  ----- PrettySx.ssc(368,11)
    havoc stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $allocated] == false && $ElementProxy(stack50000o, 0) != null && $ElementProxy(stack50000o, 0) != stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $ownerRef] == $ElementProxy(stack50000o, 0) && $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    call System.Object..ctor($ElementProxy(stack50000o, 0));
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- PrettySx.ssc(368,11)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: DeclType($f))) && true && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx..ctor(stack50000o);
    assert $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    assert (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[$ElementProxy(stack50000o, 0), $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    call $UpdateOwnersForFrozen($ElementProxy(stack50000o, 0));
    // ----- copy  ----- PrettySx.ssc(368,11)
    stack0o := stack50000o;
    // ----- copy  ----- PrettySx.ssc(368,11)
    aa := stack0o;
    // ----- copy  ----- PrettySx.ssc(369,11)
    stack0o := aa;
    // ----- load address  ----- PrettySx.ssc(369,11)
    havoc stack1o;
    // ----- call  ----- PrettySx.ssc(369,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call a1 := SExpressionSimplifier.Nary.CollectAntecedent$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.optional...NonNullType.Sx.ptr(this, stack0o);
    // ----- load constant 1  ----- PrettySx.ssc(370,11)
    stack0b := true;
    // ----- copy  ----- PrettySx.ssc(370,11)
    stack1o := aa;
    // ----- call  ----- PrettySx.ssc(370,11)
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && !(($f == $ownerRef || $f == $ownerFrame) && $Heap[$o, $ownerRef] == $Heap[stack1o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap[stack1o, $ownerFrame]) && ($o != stack1o || !($typeof(stack1o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack1o || $f != $exposeVersion));
    call a0 := SExpressionSimplifier.Nary.JunctionFromArguments$System.Boolean$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull(stack0b, stack1o);
    // ----- call  ----- PrettySx.ssc(371,11)
    assert a0 != null;
    assume $Utter($Heap[a0, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsTrue(a0);
    // ----- branch (no expression improvement)  ----- PrettySx.ssc(371,11)
    goto true13838to13124, false13838to12954;

  true13838to13124:
    assume stack0b;
    goto block13124;

  false13838to12954:
    assume !stack0b;
    goto block12954;

  block13124:
    // ----- copy  ----- PrettySx.ssc(372,13)
    return.value := a1;
    // ----- branch  ----- PrettySx.ssc(372,13)
    goto block12750;

  block12954:
    // ----- call
    assert a1 != null;
    assume $Utter($Heap[a1, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsTrue(a1);
    // ----- branch (no expression improvement)
    goto true12954to13124, false12954to13464;

  true14025to12478:
    assume local4 == stack0o;
    goto block12478;

  false14025to13396:
    assume local4 != stack0o;
    goto block13396;

  block12478:
    // ----- serialized AssumeStatement  ----- PrettySx.ssc(425,11)
    assume #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, $Heap[this, SExpressionSimplifier.Nary.Args]) >= 2;
    goto block13566;

  block13396:
    // ----- load constant "EXISTS"
    stack0o := $stringLiteral9;
    // ----- binary operator
    // ----- branch
    goto true13396to12478, false13396to13583;

  block13634:
    // ----- nop
    // ----- load field  ----- PrettySx.ssc(381,11)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- load constant 0  ----- PrettySx.ssc(381,11)
    stack1i := 0;
    // ----- call  ----- PrettySx.ssc(381,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack0o, stack1i, false);
    // ----- call  ----- PrettySx.ssc(381,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call a0 := SExpressionSimplifier.Sx.Simplify$.Virtual.$(stack0o);
    // ----- load field  ----- PrettySx.ssc(382,11)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- load constant 1  ----- PrettySx.ssc(382,11)
    stack1i := 1;
    // ----- call  ----- PrettySx.ssc(382,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack0o, stack1i, false);
    // ----- call  ----- PrettySx.ssc(382,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call a1 := SExpressionSimplifier.Sx.Simplify$.Virtual.$(stack0o);
    // ----- call  ----- PrettySx.ssc(383,11)
    assert a0 != null;
    assume $Utter($Heap[a0, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsTrue(a0);
    // ----- unary operator  ----- PrettySx.ssc(383,11)
    // ----- branch  ----- PrettySx.ssc(383,11)
    goto true13634to12801, false13634to12886;

  true13634to12801:
    assume !stack0b;
    goto block12801;

  false13634to12886:
    assume stack0b;
    goto block12886;

  block12801:
    // ----- call  ----- PrettySx.ssc(385,18)
    assert a1 != null;
    assume $Utter($Heap[a1, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsTrue(a1);
    // ----- unary operator  ----- PrettySx.ssc(385,18)
    // ----- branch  ----- PrettySx.ssc(385,18)
    goto true12801to13226, false12801to13294;

  block12886:
    // ----- copy  ----- PrettySx.ssc(384,13)
    return.value := a1;
    // ----- branch  ----- PrettySx.ssc(384,13)
    goto block12750;

  true12954to13124:
    assume stack0b;
    goto block13124;

  false12954to13464:
    assume !stack0b;
    goto block13464;

  block13464:
    // ----- branch
    goto block12512;

  block13651:
    // ----- nop
    // ----- load field  ----- PrettySx.ssc(395,11)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- load constant 0  ----- PrettySx.ssc(395,11)
    stack1i := 0;
    // ----- call  ----- PrettySx.ssc(395,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call a0 := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack0o, stack1i, false);
    // ----- is instance  ----- PrettySx.ssc(396,11)
    stack0o := $As(a0, SExpressionSimplifier.Nary);
    // ----- unary operator  ----- PrettySx.ssc(396,11)
    // ----- branch  ----- PrettySx.ssc(396,11)
    goto true13651to13668, false13651to13872;

  true13651to13668:
    assume stack0o == null;
    goto block13668;

  false13651to13872:
    assume stack0o != null;
    goto block13872;

  block13668:
    // ----- call  ----- PrettySx.ssc(402,11)
    assert a0 != null;
    assume $Utter($Heap[a0, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call a0 := SExpressionSimplifier.Sx.Simplify$.Virtual.$(a0);
    // ----- call  ----- PrettySx.ssc(403,11)
    assert a0 != null;
    assume $Utter($Heap[a0, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsTrue(a0);
    // ----- unary operator  ----- PrettySx.ssc(403,11)
    // ----- branch  ----- PrettySx.ssc(403,11)
    goto true13668to13719, false13668to13923;

  block13872:
    // ----- castclass
    assert $Is(a0, SExpressionSimplifier.Nary);
    stack0o := a0;
    // ----- load field
    assert stack0o != null;
    stack0o := $Heap[stack0o, SExpressionSimplifier.Nary.F];
    // ----- load field
    assert this != null;
    stack1o := $Heap[this, SExpressionSimplifier.Nary.F];
    // ----- call
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := System.String.Equals$System.String$System.String(stack0o, stack1o);
    // ----- unary operator
    // ----- branch
    goto true13872to13668, false13872to13532;

  true13396to12478:
    assume local4 == stack0o;
    goto block12478;

  false13396to13583:
    assume local4 != stack0o;
    goto block13583;

  block13583:
    // ----- load constant "LBLPOS"
    stack0o := $stringLiteral10;
    // ----- binary operator
    // ----- branch
    goto true13583to12478, false13583to12937;

  true12801to13226:
    assume !stack0b;
    goto block13226;

  false12801to13294:
    assume stack0b;
    goto block13294;

  block13226:
    // ----- call  ----- PrettySx.ssc(387,18)
    assert a0 != null;
    assume $Utter($Heap[a0, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsFalse(a0);
    // ----- unary operator  ----- PrettySx.ssc(387,18)
    // ----- branch  ----- PrettySx.ssc(387,18)
    goto true13226to12733, false13226to13260;

  block13294:
    // ----- copy  ----- PrettySx.ssc(386,13)
    return.value := a0;
    // ----- branch  ----- PrettySx.ssc(386,13)
    goto block12750;

  true13872to13668:
    assume !stack0b;
    goto block13668;

  false13872to13532:
    assume stack0b;
    goto block13532;

  block13532:
    // ----- castclass  ----- PrettySx.ssc(398,18)
    assert $Is(a0, SExpressionSimplifier.Nary);
    stack0o := a0;
    // ----- copy  ----- PrettySx.ssc(398,18)
    n := stack0o;
    // ----- serialized AssumeStatement  ----- PrettySx.ssc(399,13)
    assume #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, $Heap[n, SExpressionSimplifier.Nary.Args]) == 1;
    goto block12716;

  true13668to13719:
    assume !stack0b;
    goto block13719;

  false13668to13923:
    assume stack0b;
    goto block13923;

  block13719:
    // ----- call  ----- PrettySx.ssc(405,18)
    assert a0 != null;
    assume $Utter($Heap[a0, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsFalse(a0);
    // ----- unary operator  ----- PrettySx.ssc(405,18)
    // ----- branch  ----- PrettySx.ssc(405,18)
    goto true13719to12665, false13719to12495;

  block13923:
    // ----- call  ----- PrettySx.ssc(404,13)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Sx.get_False();
    // ----- branch  ----- PrettySx.ssc(404,13)
    goto block12750;

  block13566:
    // ----- nop
    // ----- load field  ----- PrettySx.ssc(426,11)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- call  ----- PrettySx.ssc(426,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count$.Virtual.$(stack0o, false);
    // ----- new object  ----- PrettySx.ssc(426,11)
    havoc stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $allocated] == false && $ElementProxy(stack50000o, 0) != null && $ElementProxy(stack50000o, 0) != stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $ownerRef] == $ElementProxy(stack50000o, 0) && $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    call System.Object..ctor($ElementProxy(stack50000o, 0));
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- PrettySx.ssc(426,11)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: DeclType($f))) && true && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx..ctor$System.Int32(stack50000o, stack0i);
    assert $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    assert (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[$ElementProxy(stack50000o, 0), $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    call $UpdateOwnersForFrozen($ElementProxy(stack50000o, 0));
    // ----- copy  ----- PrettySx.ssc(426,11)
    stack0o := stack50000o;
    // ----- copy  ----- PrettySx.ssc(426,11)
    argList := stack0o;
    // ----- load field  ----- PrettySx.ssc(427,11)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- load constant 0  ----- PrettySx.ssc(427,11)
    stack1i := 0;
    // ----- call  ----- PrettySx.ssc(427,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack0o, stack1i, false);
    // ----- call  ----- PrettySx.ssc(427,11)
    assert argList != null;
    assume $Utter($Heap[argList, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != argList || !($typeof(argList) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Add$SExpressionSimplifier.Sx$notnull$.Virtual.$(argList, stack0o);
    // ----- load constant 1  ----- PrettySx.ssc(428,20)
    i := 1;
    goto block13957$LoopPreheader;

  true13583to12478:
    assume local4 == stack0o;
    goto block12478;

  false13583to12937:
    assume local4 != stack0o;
    goto block12937;

  block12937:
    // ----- load constant "LBLNEG"
    stack0o := $stringLiteral12;
    // ----- binary operator
    // ----- branch
    goto true12937to12478, false12937to13787;

  true13226to12733:
    assume !stack0b;
    goto block12733;

  false13226to13260:
    assume stack0b;
    goto block13260;

  block12733:
    // ----- copy  ----- PrettySx.ssc(390,13)
    stack0o := a0;
    // ----- copy  ----- PrettySx.ssc(390,13)
    stack1o := a1;
    // ----- call  ----- PrettySx.ssc(390,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Nary.FromArguments$SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.Sx$notnull(this, stack0o, stack1o);
    // ----- branch  ----- PrettySx.ssc(390,13)
    goto block12750;

  block13260:
    // ----- call
    assert a1 != null;
    assume $Utter($Heap[a1, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsFalse(a1);
    // ----- unary operator
    // ----- branch
    goto true13260to12733, false13260to13311;

  block12512:
    // ----- call  ----- PrettySx.ssc(373,18)
    assert a0 != null;
    assume $Utter($Heap[a0, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := SExpressionSimplifier.Sx.get_IsFalse(a0);
    // ----- unary operator  ----- PrettySx.ssc(373,18)
    // ----- branch  ----- PrettySx.ssc(373,18)
    goto true12512to13804, false12512to13821;

  true12512to13804:
    assume !stack0b;
    goto block13804;

  false12512to13821:
    assume stack0b;
    goto block13821;

  block13804:
    // ----- copy  ----- PrettySx.ssc(376,13)
    stack0o := a0;
    // ----- copy  ----- PrettySx.ssc(376,13)
    stack1o := a1;
    // ----- call  ----- PrettySx.ssc(376,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Nary.FromArguments$SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.Sx$notnull(this, stack0o, stack1o);
    // ----- branch  ----- PrettySx.ssc(376,13)
    goto block12750;

  block13821:
    // ----- call  ----- PrettySx.ssc(374,13)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Sx.get_True();
    // ----- branch  ----- PrettySx.ssc(374,13)
    goto block12750;

  true13719to12665:
    assume !stack0b;
    goto block12665;

  false13719to12495:
    assume stack0b;
    goto block12495;

  block12665:
    // ----- is instance  ----- PrettySx.ssc(408,13)
    stack0o := $As(a0, SExpressionSimplifier.Nary);
    // ----- unary operator  ----- PrettySx.ssc(408,13)
    // ----- branch  ----- PrettySx.ssc(408,13)
    goto true12665to13039, false12665to13906;

  block12495:
    // ----- call  ----- PrettySx.ssc(406,13)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Sx.get_True();
    // ----- branch  ----- PrettySx.ssc(406,13)
    goto block12750;

  block13957:
    // ----- default loop invariant: allocation and ownership are stable  ----- PrettySx.ssc(428,27)
    assume (forall $o: ref :: { $Heap[$o, $allocated] } $Heap$block13957$LoopPreheader[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } $Heap$block13957$LoopPreheader[$ot, $allocated] && $Heap$block13957$LoopPreheader[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == $Heap$block13957$LoopPreheader[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == $Heap$block13957$LoopPreheader[$ot, $ownerFrame]) && $Heap$block13957$LoopPreheader[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
    // ----- default loop invariant: exposure  ----- PrettySx.ssc(428,27)
    assume (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $Heap$block13957$LoopPreheader[$o, $allocated] ==> $Heap$block13957$LoopPreheader[$o, $inv] == $Heap[$o, $inv] && $Heap$block13957$LoopPreheader[$o, $localinv] == $Heap[$o, $localinv]);
    assume (forall $o: ref :: !$Heap$block13957$LoopPreheader[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
    assume $Heap[this, $inv] == $Heap$block13957$LoopPreheader[this, $inv];
    // ----- default loop invariant: modifies  ----- PrettySx.ssc(428,27)
    assume (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> $Heap$block13957$LoopPreheader[$o, $f] == $Heap[$o, $f]);
    assume $HeapSucc($Heap$block13957$LoopPreheader, $Heap);
    // ----- default loop invariant: owner fields  ----- PrettySx.ssc(428,27)
    assert (forall $o: ref :: { $Heap[$o, $ownerFrame] } { $Heap[$o, $ownerRef] } $o != null && $Heap$block13957$LoopPreheader[$o, $allocated] ==> $Heap[$o, $ownerRef] == $Heap$block13957$LoopPreheader[$o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap$block13957$LoopPreheader[$o, $ownerFrame]);
    // ----- advance activity
    havoc $ActivityIndicator;
    // ----- load field  ----- PrettySx.ssc(428,27)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- call  ----- PrettySx.ssc(428,27)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count$.Virtual.$(stack0o, false);
    // ----- binary operator  ----- PrettySx.ssc(428,27)
    // ----- branch  ----- PrettySx.ssc(428,27)
    goto true13957to13974, false13957to13447;

  true13957to13974:
    assume i >= stack0i;
    goto block13974;

  false13957to13447:
    assume i < stack0i;
    goto block13447;

  block13974:
    // ----- copy  ----- PrettySx.ssc(431,11)
    stack0o := argList;
    // ----- call  ----- PrettySx.ssc(431,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && !(($f == $ownerRef || $f == $ownerFrame) && $Heap[$o, $ownerRef] == $Heap[stack0o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap[stack0o, $ownerFrame]) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call return.value := SExpressionSimplifier.Nary.FromArguments$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull(this, stack0o);
    // ----- branch  ----- PrettySx.ssc(431,11)
    goto block12750;

  block13447:
    // ----- load field  ----- PrettySx.ssc(429,13)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- copy  ----- PrettySx.ssc(429,13)
    stack1i := i;
    // ----- call  ----- PrettySx.ssc(429,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack0o, stack1i, false);
    // ----- call  ----- PrettySx.ssc(429,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0o := SExpressionSimplifier.Sx.Simplify$.Virtual.$(stack0o);
    // ----- call  ----- PrettySx.ssc(429,13)
    assert argList != null;
    assume $Utter($Heap[argList, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != argList || !($typeof(argList) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Add$SExpressionSimplifier.Sx$notnull$.Virtual.$(argList, stack0o);
    // ----- copy  ----- PrettySx.ssc(428,43)
    local17 := i;
    // ----- load constant 1  ----- PrettySx.ssc(428,43)
    stack0i := 1;
    // ----- binary operator  ----- PrettySx.ssc(428,43)
    stack0i := local17 + stack0i;
    // ----- copy  ----- PrettySx.ssc(428,43)
    i := stack0i;
    // ----- copy  ----- PrettySx.ssc(428,43)
    stack0i := local17;
    // ----- branch  ----- PrettySx.ssc(428,43)
    goto block13957;

  true12937to12478:
    assume local4 == stack0o;
    goto block12478;

  false12937to13787:
    assume local4 != stack0o;
    goto block13787;

  block13787:
    // ----- load constant "BG_PUSH"
    stack0o := $stringLiteral13;
    // ----- binary operator
    // ----- branch
    goto true13787to13379, false13787to12614;

  true13260to12733:
    assume !stack0b;
    goto block12733;

  false13260to13311:
    assume stack0b;
    goto block13311;

  block13311:
    // ----- call  ----- PrettySx.ssc(388,13)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Sx.get_True();
    // ----- branch  ----- PrettySx.ssc(388,13)
    goto block12750;

  block12716:
    // ----- nop
    // ----- load field  ----- PrettySx.ssc(400,13)
    assert n != null;
    stack0o := $Heap[n, SExpressionSimplifier.Nary.Args];
    // ----- load constant 0  ----- PrettySx.ssc(400,13)
    stack1i := 0;
    // ----- call  ----- PrettySx.ssc(400,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack0o, stack1i, false);
    // ----- call  ----- PrettySx.ssc(400,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Sx.Simplify$.Virtual.$(stack0o);
    // ----- branch  ----- PrettySx.ssc(400,13)
    goto block12750;

  true12665to13039:
    assume stack0o == null;
    goto block13039;

  false12665to13906:
    assume stack0o != null;
    goto block13906;

  block13039:
    // ----- copy  ----- PrettySx.ssc(418,13)
    stack0o := a0;
    // ----- call  ----- PrettySx.ssc(418,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call return.value := SExpressionSimplifier.Nary.FromArguments$SExpressionSimplifier.Sx$notnull(this, stack0o);
    // ----- branch  ----- PrettySx.ssc(418,13)
    goto block12750;

  block13906:
    // ----- castclass  ----- PrettySx.ssc(409,20)
    assert $Is(a0, SExpressionSimplifier.Nary);
    stack0o := a0;
    // ----- copy  ----- PrettySx.ssc(409,20)
    cmp := stack0o;
    // ----- load field  ----- PrettySx.ssc(410,15)
    assert cmp != null;
    stack0o := $Heap[cmp, SExpressionSimplifier.Nary.F];
    // ----- load constant "EQ"  ----- PrettySx.ssc(410,15)
    stack1o := $stringLiteral14;
    // ----- call  ----- PrettySx.ssc(410,15)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := System.String.Equals$System.String$System.String(stack0o, stack1o);
    // ----- unary operator  ----- PrettySx.ssc(410,15)
    // ----- branch  ----- PrettySx.ssc(410,15)
    goto true13906to13770, false13906to12461;

  true13787to13379:
    assume local4 == stack0o;
    goto block13379;

  false13787to12614:
    assume local4 != stack0o;
    goto block12614;

  block13379:
    // ----- load field  ----- PrettySx.ssc(434,11)
    assert this != null;
    stack0o := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- call  ----- PrettySx.ssc(434,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count$.Virtual.$(stack0o, false);
    // ----- new object  ----- PrettySx.ssc(434,11)
    havoc stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $allocated] == false && $ElementProxy(stack50000o, 0) != null && $ElementProxy(stack50000o, 0) != stack50000o;
    assume $Heap[$ElementProxy(stack50000o, 0), $ownerRef] == $ElementProxy(stack50000o, 0) && $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    call System.Object..ctor($ElementProxy(stack50000o, 0));
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- PrettySx.ssc(434,11)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: DeclType($f))) && true && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx..ctor$System.Int32(stack50000o, stack0i);
    assert $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] == $PeerGroupPlaceholder;
    assert (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[$ElementProxy(stack50000o, 0), $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[$ElementProxy(stack50000o, 0), $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    call $UpdateOwnersForFrozen($ElementProxy(stack50000o, 0));
    // ----- copy  ----- PrettySx.ssc(434,11)
    stack0o := stack50000o;
    // ----- copy  ----- PrettySx.ssc(434,11)
    argList := stack0o;
    // ----- load field  ----- PrettySx.ssc(435,11)
    assert this != null;
    local18 := $Heap[this, SExpressionSimplifier.Nary.Args];
    // ----- call  ----- PrettySx.ssc(435,30)
    assert local18 != null;
    assume $Utter($Heap[local18, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call foreachEnumerator^.33574638 := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator(local18);
    goto block13685$LoopPreheader;

  block12614:
    // ----- branch
    goto block13073;

  true13906to13770:
    assume !stack0b;
    goto block13770;

  false13906to12461:
    assume stack0b;
    goto block12461;

  block13770:
    // ----- load field  ----- PrettySx.ssc(413,22)
    assert cmp != null;
    stack0o := $Heap[cmp, SExpressionSimplifier.Nary.F];
    // ----- load constant "NEQ"  ----- PrettySx.ssc(413,22)
    stack1o := $stringLiteral15;
    // ----- call  ----- PrettySx.ssc(413,22)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := System.String.Equals$System.String$System.String(stack0o, stack1o);
    // ----- unary operator  ----- PrettySx.ssc(413,22)
    // ----- branch  ----- PrettySx.ssc(413,22)
    goto true13770to12835, false13770to13498;

  block12461:
    // ----- serialized AssumeStatement  ----- PrettySx.ssc(411,17)
    assume #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, $Heap[cmp, SExpressionSimplifier.Nary.Args]) == 2;
    goto block12784;

  true13770to12835:
    assume !stack0b;
    goto block12835;

  false13770to13498:
    assume stack0b;
    goto block13498;

  block12835:
    // ----- nop  ----- PrettySx.ssc(417,13)
    goto block13039;

  block13498:
    // ----- serialized AssumeStatement  ----- PrettySx.ssc(414,17)
    assume #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, $Heap[cmp, SExpressionSimplifier.Nary.Args]) == 2;
    goto block12903;

  block13685:
    // ----- default loop invariant: allocation and ownership are stable  ----- PrettySx.ssc(435,23)
    assume (forall $o: ref :: { $Heap[$o, $allocated] } $Heap$block13685$LoopPreheader[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } $Heap$block13685$LoopPreheader[$ot, $allocated] && $Heap$block13685$LoopPreheader[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == $Heap$block13685$LoopPreheader[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == $Heap$block13685$LoopPreheader[$ot, $ownerFrame]) && $Heap$block13685$LoopPreheader[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
    // ----- default loop invariant: exposure  ----- PrettySx.ssc(435,23)
    assume (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $Heap$block13685$LoopPreheader[$o, $allocated] ==> $Heap$block13685$LoopPreheader[$o, $inv] == $Heap[$o, $inv] && $Heap$block13685$LoopPreheader[$o, $localinv] == $Heap[$o, $localinv]);
    assume (forall $o: ref :: !$Heap$block13685$LoopPreheader[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
    assume $Heap[this, $inv] == $Heap$block13685$LoopPreheader[this, $inv];
    // ----- default loop invariant: modifies  ----- PrettySx.ssc(435,23)
    assume (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> $Heap$block13685$LoopPreheader[$o, $f] == $Heap[$o, $f]);
    assume $HeapSucc($Heap$block13685$LoopPreheader, $Heap);
    // ----- default loop invariant: owner fields  ----- PrettySx.ssc(435,23)
    assert (forall $o: ref :: { $Heap[$o, $ownerFrame] } { $Heap[$o, $ownerRef] } $o != null && $Heap$block13685$LoopPreheader[$o, $allocated] ==> $Heap[$o, $ownerRef] == $Heap$block13685$LoopPreheader[$o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap$block13685$LoopPreheader[$o, $ownerFrame]);
    // ----- advance activity
    havoc $ActivityIndicator;
    // ----- load address  ----- PrettySx.ssc(435,23)
    havoc stack0o;
    // ----- call  ----- PrettySx.ssc(435,23)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call foreachEnumerator^.33574638, stack0b := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.MoveNext(foreachEnumerator^.33574638);
    // ----- unary operator  ----- PrettySx.ssc(435,23)
    // ----- branch  ----- PrettySx.ssc(435,23)
    goto true13685to12529, false13685to13056;

  true13685to12529:
    assume !stack0b;
    goto block12529;

  false13685to13056:
    assume stack0b;
    goto block13056;

  block12529:
    // ----- copy  ----- PrettySx.ssc(438,11)
    stack0o := argList;
    // ----- call  ----- PrettySx.ssc(438,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && !(($f == $ownerRef || $f == $ownerFrame) && $Heap[$o, $ownerRef] == $Heap[stack0o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap[stack0o, $ownerFrame]) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call return.value := SExpressionSimplifier.Nary.FromArguments$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull(this, stack0o);
    // ----- branch  ----- PrettySx.ssc(438,11)
    goto block12750;

  block13056:
    // ----- load address  ----- PrettySx.ssc(435,23)
    havoc stack0o;
    // ----- call  ----- PrettySx.ssc(435,23)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call local20 := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current(foreachEnumerator^.33574638, true);
    // ----- copy  ----- PrettySx.ssc(435,23)
    arg := local20;
    // ----- call  ----- PrettySx.ssc(436,13)
    assert arg != null;
    assume $Utter($Heap[arg, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0o := SExpressionSimplifier.Sx.Simplify$.Virtual.$(arg);
    // ----- call  ----- PrettySx.ssc(436,13)
    assert argList != null;
    assume $Utter($Heap[argList, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != argList || !($typeof(argList) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Add$SExpressionSimplifier.Sx$notnull$.Virtual.$(argList, stack0o);
    // ----- branch  ----- PrettySx.ssc(436,13)
    goto block13685;

  block12784:
    // ----- nop
    // ----- load constant "NEQ"  ----- PrettySx.ssc(412,17)
    stack0o := $stringLiteral15;
    // ----- load field  ----- PrettySx.ssc(412,17)
    assert cmp != null;
    stack1o := $Heap[cmp, SExpressionSimplifier.Nary.Args];
    // ----- load constant 0  ----- PrettySx.ssc(412,17)
    stack2i := 0;
    // ----- call  ----- PrettySx.ssc(412,17)
    assert stack1o != null;
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack1o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack1o, stack2i, false);
    // ----- load field  ----- PrettySx.ssc(412,17)
    assert cmp != null;
    stack2o := $Heap[cmp, SExpressionSimplifier.Nary.Args];
    // ----- load constant 1  ----- PrettySx.ssc(412,17)
    stack3i := 1;
    // ----- call  ----- PrettySx.ssc(412,17)
    assert stack2o != null;
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack2o, stack3i, false);
    // ----- new object  ----- PrettySx.ssc(412,17)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == SExpressionSimplifier.Nary;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- PrettySx.ssc(412,17)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack1o, $ownerRef]);
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(SExpressionSimplifier.Nary <: DeclType($f))) && true && true);
    call SExpressionSimplifier.Nary..ctor$System.String$notnull$SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.Sx$notnull(stack50000o, stack0o, stack1o, stack2o);
    assert $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    assert (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[stack50000o, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[stack50000o, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    call $UpdateOwnersForFrozen(stack50000o);
    // ----- copy  ----- PrettySx.ssc(412,17)
    stack0o := stack50000o;
    // ----- copy  ----- PrettySx.ssc(412,17)
    return.value := stack0o;
    // ----- branch  ----- PrettySx.ssc(412,17)
    goto block12750;

  block12903:
    // ----- nop
    // ----- load constant "EQ"  ----- PrettySx.ssc(415,17)
    stack0o := $stringLiteral14;
    // ----- load field  ----- PrettySx.ssc(415,17)
    assert cmp != null;
    stack1o := $Heap[cmp, SExpressionSimplifier.Nary.Args];
    // ----- load constant 0  ----- PrettySx.ssc(415,17)
    stack2i := 0;
    // ----- call  ----- PrettySx.ssc(415,17)
    assert stack1o != null;
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack1o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack1o, stack2i, false);
    // ----- load field  ----- PrettySx.ssc(415,17)
    assert cmp != null;
    stack2o := $Heap[cmp, SExpressionSimplifier.Nary.Args];
    // ----- load constant 1  ----- PrettySx.ssc(415,17)
    stack3i := 1;
    // ----- call  ----- PrettySx.ssc(415,17)
    assert stack2o != null;
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2o := System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(stack2o, stack3i, false);
    // ----- new object  ----- PrettySx.ssc(415,17)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == SExpressionSimplifier.Nary;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- PrettySx.ssc(415,17)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack1o, $ownerRef]);
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(SExpressionSimplifier.Nary <: DeclType($f))) && true && true);
    call SExpressionSimplifier.Nary..ctor$System.String$notnull$SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.Sx$notnull(stack50000o, stack0o, stack1o, stack2o);
    assert $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    assert (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[stack50000o, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[stack50000o, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    call $UpdateOwnersForFrozen(stack50000o);
    // ----- copy  ----- PrettySx.ssc(415,17)
    stack0o := stack50000o;
    // ----- copy  ----- PrettySx.ssc(415,17)
    return.value := stack0o;
    // ----- branch  ----- PrettySx.ssc(415,17)
    goto block12750;

  block13957$LoopPreheader:
    $Heap$block13957$LoopPreheader := $Heap;
    goto block13957;

  block13685$LoopPreheader:
    $Heap$block13685$LoopPreheader := $Heap;
    goto block13685;
}



axiom System.String <: System.String;

axiom $BaseClass(System.String) == System.Object && AsDirectSubClass(System.String, $BaseClass(System.String)) == System.String;

axiom System.IComparable <: System.IComparable;

axiom $IsMemberlessType(System.IComparable);

axiom $AsInterface(System.IComparable) == System.IComparable;

axiom System.String <: System.IComparable;

axiom System.ICloneable <: System.ICloneable;

axiom $IsMemberlessType(System.ICloneable);

axiom $AsInterface(System.ICloneable) == System.ICloneable;

axiom System.String <: System.ICloneable;

axiom System.IConvertible <: System.IConvertible;

axiom $IsMemberlessType(System.IConvertible);

axiom $AsInterface(System.IConvertible) == System.IConvertible;

axiom System.String <: System.IConvertible;

axiom System.IComparable`1...System.String <: System.IComparable`1...System.String;

axiom $IsMemberlessType(System.IComparable`1...System.String);

axiom $AsInterface(System.IComparable`1...System.String) == System.IComparable`1...System.String;

axiom System.String <: System.IComparable`1...System.String;

axiom System.Collections.Generic.IEnumerable`1...System.Char <: System.Collections.Generic.IEnumerable`1...System.Char;

axiom System.Collections.IEnumerable <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.IEnumerable);

axiom $AsInterface(System.Collections.IEnumerable) == System.Collections.IEnumerable;

axiom System.Collections.Generic.IEnumerable`1...System.Char <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.Generic.IEnumerable`1...System.Char);

axiom $AsInterface(System.Collections.Generic.IEnumerable`1...System.Char) == System.Collections.Generic.IEnumerable`1...System.Char;

axiom System.String <: System.Collections.Generic.IEnumerable`1...System.Char;

axiom System.String <: System.Collections.IEnumerable;

axiom System.IEquatable`1...System.String <: System.IEquatable`1...System.String;

axiom $IsMemberlessType(System.IEquatable`1...System.String);

axiom $AsInterface(System.IEquatable`1...System.String) == System.IEquatable`1...System.String;

axiom System.String <: System.IEquatable`1...System.String;

axiom (forall $U: TName :: { $U <: System.String } $U <: System.String ==> $U == System.String);

// System.String object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.String } IsHeap($h) && $h[$oi, $inv] <: System.String && $h[$oi, $localinv] != $BaseClass(System.String) ==> true);

procedure System.String.IsInterned$System.String$notnull(str$in: ref where $IsNotNull(str$in, System.String) && $Heap[str$in, $allocated]) returns ($result: ref where $Is($result, System.String) && $Heap[$result, $allocated]);
  // user-declared preconditions
  requires str$in != null;
  // str is frozen (pure method)
  requires IsFrozen(str$in, $Heap);
  // parameter of a pure method
  free requires $AsPureObject(str$in) == str$in;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures $result != null ==> $StringLength($result) == $StringLength(str$in);
  ensures $result != null ==> #System.String.Equals$System.String($Heap, str$in, $result);
  // parameter of a pure method
  free ensures $AsPureObject(str$in) == str$in;
  // return value is frozen (pure method)
  ensures $result == null || IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $result == #System.String.IsInterned$System.String$notnull($Heap, str$in);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom $BaseClass(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) == System.Object && AsDirectSubClass(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx, $BaseClass(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx)) == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx);

axiom $AsInterface(System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) == System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx);

axiom $AsInterface(System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) == System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx);

axiom $AsInterface(System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) == System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.IEnumerable`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.IList <: System.Collections.IList;

axiom System.Collections.ICollection <: System.Collections.ICollection;

axiom System.Collections.ICollection <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.ICollection);

axiom $AsInterface(System.Collections.ICollection) == System.Collections.ICollection;

axiom System.Collections.IList <: System.Collections.ICollection;

axiom System.Collections.IList <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.IList);

axiom $AsInterface(System.Collections.IList) == System.Collections.IList;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.IList;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.ICollection;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.IEnumerable;

// System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx> object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx } IsHeap($h) && $h[$oi, $inv] <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $h[$oi, $localinv] != $BaseClass(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) ==> true);

procedure System.Object..ctor(this: ref where $IsNotNull(this, System.Object) && $Heap[this, $allocated]);
  // object is fully unpacked:  this.inv == Object
  free requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  // nothing is owned by [this,*] and 'this' is alone in its own peer group
  free requires (forall $o: ref :: $o != this ==> $Heap[$o, $ownerRef] != this) && $Heap[this, $ownerRef] == this && $Heap[this, $ownerFrame] == $PeerGroupPlaceholder;
  free requires $BeingConstructed == this;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // target object is allocated upon return
  free ensures $Heap[this, $allocated];
  // target object is additively exposable for System.Object
  ensures ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(System.Object <: DeclType($f))) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] && $o != this ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx..ctor(this: ref where $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated]);
  // object is fully unpacked:  this.inv == Object
  free requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  // nothing is owned by [this,*] and 'this' is alone in its own peer group
  free requires (forall $o: ref :: $o != this ==> $Heap[$o, $ownerRef] != this) && $Heap[this, $ownerRef] == this && $Heap[this, $ownerFrame] == $PeerGroupPlaceholder;
  free requires $BeingConstructed == this;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // target object is allocated upon return
  free ensures $Heap[this, $allocated];
  // target object is additively exposable for System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>
  ensures ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $localinv] == $typeof(this);
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: DeclType($f))) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] && $o != this ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Nary.CollectArguments$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull$System.Boolean(this: ref where $IsNotNull(this, SExpressionSimplifier.Nary) && $Heap[this, $allocated], list$in: ref where $IsNotNull(list$in, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[list$in, $allocated], and$in: bool where true);
  // user-declared preconditions
  requires (and$in && #System.String.Equals$System.String($Heap, $Heap[this, SExpressionSimplifier.Nary.F], $stringLiteral0)) || (!and$in && #System.String.Equals$System.String($Heap, $Heap[this, SExpressionSimplifier.Nary.F], $stringLiteral1));
  // target object is frozen
  requires IsFrozen(this, $Heap);
  // elements of list are frozen
  requires IsFrozen($ElementProxy(list$in, 0), $Heap);
  // list is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[list$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[list$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // list is peer consistent (owner must not be valid)
  requires $Heap[list$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[list$in, $ownerRef], $inv] <: $Heap[list$in, $ownerFrame]) || $Heap[$Heap[list$in, $ownerRef], $localinv] == $BaseClass($Heap[list$in, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(list$in) || !($typeof(old(list$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(list$in) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Nary.JunctionFromArguments$System.Boolean$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull(and$in: bool where true, args$in: ref where $IsNotNull(args$in, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[args$in, $allocated]) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Sx) && $Heap[$result, $allocated]);
  requires $Heap[args$in, $ownerFrame] == $PeerGroupPlaceholder;
  // elements of args are frozen
  requires IsFrozen($ElementProxy(args$in, 0), $Heap);
  // args is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[args$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[args$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // args is peer consistent (owner must not be valid)
  requires $Heap[args$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[args$in, $ownerRef], $inv] <: $Heap[args$in, $ownerFrame]) || $Heap[$Heap[args$in, $ownerRef], $localinv] == $BaseClass($Heap[args$in, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && !(($f == $ownerRef || $f == $ownerFrame) && old($Heap[$o, $ownerRef] == $Heap[args$in, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap[args$in, $ownerFrame])) && ($o != old(args$in) || !($typeof(old(args$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(args$in) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) } IsPreHeap($Heap) && $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated] && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) >= 0 && ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) } this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) == ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap[this, $exposeVersion]));

procedure SExpressionSimplifier.Nary.CollectAntecedent$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.optional...NonNullType.Sx.ptr(this: ref where $IsNotNull(this, SExpressionSimplifier.Nary) && $Heap[this, $allocated], antecedent$in: ref where $IsNotNull(antecedent$in, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[antecedent$in, $allocated]) returns (consequent$out: ref where $IsNotNull(consequent$out, SExpressionSimplifier.Sx) && $Heap[consequent$out, $allocated]);
  // user-declared preconditions
  requires #System.String.Equals$System.String$System.String($Heap, $Heap[this, SExpressionSimplifier.Nary.F], $stringLiteral2);
  // target object is frozen
  requires IsFrozen(this, $Heap);
  // elements of antecedent are frozen
  requires IsFrozen($ElementProxy(antecedent$in, 0), $Heap);
  // antecedent is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[antecedent$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[antecedent$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // antecedent is peer consistent (owner must not be valid)
  requires $Heap[antecedent$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[antecedent$in, $ownerRef], $inv] <: $Heap[antecedent$in, $ownerFrame]) || $Heap[$Heap[antecedent$in, $ownerRef], $localinv] == $BaseClass($Heap[antecedent$in, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // consequent is frozen
  ensures IsFrozen(consequent$out, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(antecedent$in) || !($typeof(old(antecedent$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(antecedent$in) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref :: { #SExpressionSimplifier.Sx.get_IsTrue($Heap, this) } IsPreHeap($Heap) && $IsNotNull(this, SExpressionSimplifier.Sx) && $Heap[this, $allocated] && IsFrozen(this, $Heap) ==> $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref :: { #SExpressionSimplifier.Sx.get_IsTrue($Heap, this) } this != null && $typeof(this) <: SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #SExpressionSimplifier.Sx.get_IsTrue($Heap, this) == ##SExpressionSimplifier.Sx.get_IsTrue($Heap[this, $exposeVersion]));

procedure SExpressionSimplifier.Sx.get_IsTrue(this: ref where $IsNotNull(this, SExpressionSimplifier.Sx) && $Heap[this, $allocated]) returns ($result: bool where true);
  // target object is frozen (pure method)
  requires IsFrozen(this, $Heap);
  // parameter of a pure method
  free requires $AsPureObject(this) == this;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // parameter of a pure method
  free ensures $AsPureObject(this) == this;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $result == #SExpressionSimplifier.Sx.get_IsTrue($Heap, this);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref, index$in: int :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) } IsPreHeap($Heap) && $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated] && 0 <= index$in && index$in < #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> $IsNotNull(#System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in), SExpressionSimplifier.Sx) && $Heap[#System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in), $allocated] && ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this && IsFrozen(#System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in), $Heap));

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref, index$in: int :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) } this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) == ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap[this, $exposeVersion], index$in));

// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref, index$in: int :: { #System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) } IsPreHeap($Heap) && $IsNotNull(this, System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated] && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> $IsNotNull(#System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in), SExpressionSimplifier.Sx) && $Heap[#System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in), $allocated] && ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this && IsFrozen(#System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in), $Heap));

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref, index$in: int :: { #System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) } this != null && $typeof(this) <: System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) == ##System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap[this, $exposeVersion], index$in));

// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Item(System.Int32) --> System.Collections.Generic.IList`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Item(System.Int32))
axiom (forall $Heap: HeapType, this: ref, index$in: int :: this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) == #System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in));

procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32$.Virtual.$(this: ref where $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated], index$in: int where InRange(index$in, System.Int32), $isBaseCall: bool) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Sx) && $Heap[$result, $allocated]);
  // user-declared preconditions
  requires 0 <= index$in;
  requires index$in < #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this);
  // target object is peer valid (pure method)
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // parameter of a pure method
  free requires $AsPureObject(this) == this;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value pre-allocated
  ensures old($Heap)[$result, $allocated];
  // FCO info about pure receiver
  free ensures $Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner]);
  // parameter of a pure method
  free ensures $AsPureObject(this) == this;
  // return value is frozen (pure method)
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $isBaseCall || $result == #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Item(System.Int32) --> System.Collections.Generic.IList`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Item(System.Int32))
axiom (forall $Heap: HeapType, this: ref, index$in: int :: this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in) == #System.Collections.Generic.IList`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Item$System.Int32($Heap, this, index$in));

procedure SExpressionSimplifier.Sx.Simplify$.Virtual.$(this: ref where $IsNotNull(this, SExpressionSimplifier.Sx) && $Heap[this, $allocated]) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Sx) && $Heap[$result, $allocated]);
  // target object is frozen
  requires IsFrozen(this, $Heap);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure System.String.Equals$System.String$System.String(a$in: ref where $Is(a$in, System.String) && $Heap[a$in, $allocated], b$in: ref where $Is(b$in, System.String) && $Heap[b$in, $allocated]) returns ($result: bool where true);
  // a is frozen (pure method)
  requires a$in == null || IsFrozen(a$in, $Heap);
  // parameter of a pure method
  free requires $AsPureObject(a$in) == a$in;
  // b is frozen (pure method)
  requires b$in == null || IsFrozen(b$in, $Heap);
  // parameter of a pure method
  free requires $AsPureObject(b$in) == b$in;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures a$in != null && a$in == b$in ==> $result;
  // parameter of a pure method
  free ensures $AsPureObject(a$in) == a$in;
  // parameter of a pure method
  free ensures $AsPureObject(b$in) == b$in;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $result == #System.String.Equals$System.String$System.String($Heap, a$in, b$in);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) } IsPreHeap($Heap) && $IsNotNull(this, System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated] && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) } this != null && $typeof(this) <: System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) == ##System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap[this, $exposeVersion]));

// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Count --> System.Collections.Generic.ICollection`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Count)
axiom (forall $Heap: HeapType, this: ref :: this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) == #System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this));

// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref :: { #System.Collections.ICollection.get_Count($Heap, this) } IsPreHeap($Heap) && $IsNotNull(this, System.Collections.ICollection) && $Heap[this, $allocated] && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> #System.Collections.ICollection.get_Count($Heap, this) >= 0 && ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref :: { #System.Collections.ICollection.get_Count($Heap, this) } this != null && $typeof(this) <: System.Collections.ICollection && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #System.Collections.ICollection.get_Count($Heap, this) == ##System.Collections.ICollection.get_Count($Heap[this, $exposeVersion]));

// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Count --> System.Collections.ICollection.get_Count)
axiom (forall $Heap: HeapType, this: ref :: this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) == #System.Collections.ICollection.get_Count($Heap, this));

procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count$.Virtual.$(this: ref where $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated], $isBaseCall: bool) returns ($result: int where InRange($result, System.Int32));
  // target object is peer valid (pure method)
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // parameter of a pure method
  free requires $AsPureObject(this) == this;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures $result >= 0;
  // FCO info about pure receiver
  free ensures $Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner]);
  // parameter of a pure method
  free ensures $AsPureObject(this) == this;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $isBaseCall || $result == #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Count --> System.Collections.Generic.ICollection`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Count)
axiom (forall $Heap: HeapType, this: ref :: this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) == #System.Collections.Generic.ICollection`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this));

// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Count --> System.Collections.ICollection.get_Count)
axiom (forall $Heap: HeapType, this: ref :: this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) == #System.Collections.ICollection.get_Count($Heap, this));

procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx..ctor$System.Int32(this: ref where $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated], capacity$in: int where InRange(capacity$in, System.Int32));
  // object is fully unpacked:  this.inv == Object
  free requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  // nothing is owned by [this,*] and 'this' is alone in its own peer group
  free requires (forall $o: ref :: $o != this ==> $Heap[$o, $ownerRef] != this) && $Heap[this, $ownerRef] == this && $Heap[this, $ownerFrame] == $PeerGroupPlaceholder;
  free requires $BeingConstructed == this;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // target object is allocated upon return
  free ensures $Heap[this, $allocated];
  // target object is additively exposable for System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>
  ensures ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $localinv] == $typeof(this);
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: DeclType($f))) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] && $o != this ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Add$SExpressionSimplifier.Sx$notnull$.Virtual.$(this: ref where $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated], item$in: ref where $IsNotNull(item$in, SExpressionSimplifier.Sx) && $Heap[item$in, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  // item is frozen
  requires IsFrozen(item$in, $Heap);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this) == old(#System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Count($Heap, this)) + 1;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref :: { #SExpressionSimplifier.Sx.get_IsFalse($Heap, this) } IsPreHeap($Heap) && $IsNotNull(this, SExpressionSimplifier.Sx) && $Heap[this, $allocated] && IsFrozen(this, $Heap) ==> $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref :: { #SExpressionSimplifier.Sx.get_IsFalse($Heap, this) } this != null && $typeof(this) <: SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #SExpressionSimplifier.Sx.get_IsFalse($Heap, this) == ##SExpressionSimplifier.Sx.get_IsFalse($Heap[this, $exposeVersion]));

procedure SExpressionSimplifier.Sx.get_IsFalse(this: ref where $IsNotNull(this, SExpressionSimplifier.Sx) && $Heap[this, $allocated]) returns ($result: bool where true);
  // target object is frozen (pure method)
  requires IsFrozen(this, $Heap);
  // parameter of a pure method
  free requires $AsPureObject(this) == this;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // parameter of a pure method
  free ensures $AsPureObject(this) == this;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $result == #SExpressionSimplifier.Sx.get_IsFalse($Heap, this);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Sx.get_False() returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Sx) && $Heap[$result, $allocated]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Nary.FromArguments$SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.Sx$notnull(this: ref where $IsNotNull(this, SExpressionSimplifier.Nary) && $Heap[this, $allocated], arg0$in: ref where $IsNotNull(arg0$in, SExpressionSimplifier.Sx) && $Heap[arg0$in, $allocated], arg1$in: ref where $IsNotNull(arg1$in, SExpressionSimplifier.Sx) && $Heap[arg1$in, $allocated]) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Nary) && $Heap[$result, $allocated]);
  // target object is frozen
  requires IsFrozen(this, $Heap);
  // arg0 is frozen
  requires IsFrozen(arg0$in, $Heap);
  // arg1 is frozen
  requires IsFrozen(arg1$in, $Heap);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Sx.get_True() returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Sx) && $Heap[$result, $allocated]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Nary.FromArguments$System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx$notnull(this: ref where $IsNotNull(this, SExpressionSimplifier.Nary) && $Heap[this, $allocated], args$in: ref where $IsNotNull(args$in, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[args$in, $allocated]) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Nary) && $Heap[$result, $allocated]);
  requires $Heap[args$in, $ownerFrame] == $PeerGroupPlaceholder;
  // target object is frozen
  requires IsFrozen(this, $Heap);
  // elements of args are frozen
  requires IsFrozen($ElementProxy(args$in, 0), $Heap);
  // args is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[args$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[args$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // args is peer consistent (owner must not be valid)
  requires $Heap[args$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[args$in, $ownerRef], $inv] <: $Heap[args$in, $ownerFrame]) || $Heap[$Heap[args$in, $ownerRef], $localinv] == $BaseClass($Heap[args$in, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && !(($f == $ownerRef || $f == $ownerFrame) && old($Heap[$o, $ownerRef] == $Heap[args$in, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap[args$in, $ownerFrame])) && ($o != old(args$in) || !($typeof(old(args$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(args$in) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Nary.FromArguments$SExpressionSimplifier.Sx$notnull(this: ref where $IsNotNull(this, SExpressionSimplifier.Nary) && $Heap[this, $allocated], arg$in: ref where $IsNotNull(arg$in, SExpressionSimplifier.Sx) && $Heap[arg$in, $allocated]) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Nary) && $Heap[$result, $allocated]);
  // target object is frozen
  requires IsFrozen(this, $Heap);
  // arg is frozen
  requires IsFrozen(arg$in, $Heap);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



axiom System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.IDisposable;

axiom System.Collections.IEnumerator <: System.Collections.IEnumerator;

axiom $IsMemberlessType(System.Collections.IEnumerator);

axiom $AsInterface(System.Collections.IEnumerator) == System.Collections.IEnumerator;

axiom System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx <: System.Collections.IEnumerator;

axiom $IsMemberlessType(System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx);

axiom $AsInterface(System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) == System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator <: System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator <: System.IDisposable;

axiom System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator <: System.Collections.IEnumerator;

axiom (forall $bx: ref :: { BoxTester($bx, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator) } BoxTester($bx, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator) != null ==> (exists $s: struct :: Box($s, $bx) == $bx));

// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator($Heap, this) } IsPreHeap($Heap) && $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated] && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator($Heap, this) } this != null && $typeof(this) <: System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator($Heap, this) == ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator($Heap[this, $exposeVersion]));

procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator(this: ref where $IsNotNull(this, System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated]) returns ($result: struct where IsAllocated($Heap, $result));
  // target object is peer valid (pure method)
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // parameter of a pure method
  free requires $AsPureObject(this) == this;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // FCO info about pure receiver
  free ensures $Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner]);
  // parameter of a pure method
  free ensures $AsPureObject(this) == this;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $result == #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.GetEnumerator($Heap, this);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.MoveNext(this$in: struct where IsAllocated($Heap, this$in)) returns (this$out: struct, $result: bool where true);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



procedure SExpressionSimplifier.Nary..ctor$System.String$notnull$SExpressionSimplifier.Sx$notnull$SExpressionSimplifier.Sx$notnull(this: ref where $IsNotNull(this, SExpressionSimplifier.Nary) && $Heap[this, $allocated], functionName$in: ref where $IsNotNull(functionName$in, System.String) && $Heap[functionName$in, $allocated], arg0$in: ref where $IsNotNull(arg0$in, SExpressionSimplifier.Sx) && $Heap[arg0$in, $allocated], arg1$in: ref where $IsNotNull(arg1$in, SExpressionSimplifier.Sx) && $Heap[arg1$in, $allocated]);
  // object is fully unpacked:  this.inv == Object
  free requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  // functionName is frozen
  requires IsFrozen(functionName$in, $Heap);
  // arg0 is frozen
  requires IsFrozen(arg0$in, $Heap);
  // arg1 is frozen
  requires IsFrozen(arg1$in, $Heap);
  // nothing is owned by [this,*] and 'this' is alone in its own peer group
  free requires (forall $o: ref :: $o != this ==> $Heap[$o, $ownerRef] != this) && $Heap[this, $ownerRef] == this && $Heap[this, $ownerFrame] == $PeerGroupPlaceholder;
  free requires $BeingConstructed == this;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // target object is allocated upon return
  free ensures $Heap[this, $allocated];
  // target object is additively exposable for SExpressionSimplifier.Nary
  ensures ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == SExpressionSimplifier.Nary && $Heap[this, $localinv] == $typeof(this);
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(SExpressionSimplifier.Nary <: DeclType($f))) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] && $o != this ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// purity axiom (state independent)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this$in: struct :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in) } IsPreHeap($Heap) ==> $IsNotNull(#System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in), SExpressionSimplifier.Sx) && $Heap[#System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in), $allocated] && IsFrozen(#System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in), $Heap));

// state-independent methods do not depend on the heap
axiom (forall $Heap: HeapType, this$in: struct :: { #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in) } #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in) == ##System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current(this$in));

// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, this) } IsPreHeap($Heap) && $IsNotNull(this, System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx) && $Heap[this, $allocated] && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> $IsNotNull(#System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, this), SExpressionSimplifier.Sx) && $Heap[#System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, this), $allocated] && ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame] && $Heap[$Heap[this, $ownerRef], $localinv] != $BaseClass($Heap[this, $ownerFrame]) ==> (!($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && ($Heap[$Heap[this, $ownerRef], $ownerFrame] != $PeerGroupPlaceholder && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this && IsFrozen(#System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, this), $Heap));

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref :: { #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, this) } this != null && $typeof(this) <: System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, this) == ##System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap[this, $exposeVersion]));

// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>+Enumerator.get_Current --> System.Collections.Generic.IEnumerator`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Current)
axiom (forall $Heap: HeapType, this$in: struct, $bx: ref :: { #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, Box(this$in, $bx)) } IsHeap($Heap) && Box(this$in, $bx) == $bx && $typeof($bx) <: System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in) == #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, Box(this$in, $bx)));

procedure System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current(this$in: struct where IsAllocated($Heap, this$in), $isBaseCall: bool) returns ($result: ref where $IsNotNull($result, SExpressionSimplifier.Sx) && $Heap[$result, $allocated]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // return value is frozen (pure method)
  ensures IsFrozen($result, $Heap);
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $isBaseCall || $result == #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];



// pure-method interface connection (System.Collections.Generic.List`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>+Enumerator.get_Current --> System.Collections.Generic.IEnumerator`1<optional(Microsoft.Contracts.NonNullType) SExpressionSimplifier.Sx>.get_Current)
axiom (forall $Heap: HeapType, this$in: struct, $bx: ref :: { #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, Box(this$in, $bx)) } IsHeap($Heap) && Box(this$in, $bx) == $bx && $typeof($bx) <: System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx ==> #System.Collections.Generic.List`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.Enumerator.get_Current($Heap, this$in) == #System.Collections.Generic.IEnumerator`1...optional...Microsoft.Contracts.NonNullType.SExpressionSimplifier.Sx.get_Current($Heap, Box(this$in, $bx)));

const unique $stringLiteral0: ref;

// $stringLiteral0 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral0, System.String) && $StringLength($stringLiteral0) == 3 && (forall heap: HeapType :: { heap[$stringLiteral0, $allocated] } IsHeap(heap) ==> heap[$stringLiteral0, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral0) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral0) == $stringLiteral0) && (forall heap: HeapType :: { IsFrozen($stringLiteral0, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral0, heap));

const unique $stringLiteral1: ref;

// $stringLiteral1 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral1, System.String) && $StringLength($stringLiteral1) == 2 && (forall heap: HeapType :: { heap[$stringLiteral1, $allocated] } IsHeap(heap) ==> heap[$stringLiteral1, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral1) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral1) == $stringLiteral1) && (forall heap: HeapType :: { IsFrozen($stringLiteral1, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral1, heap));

const unique $stringLiteral2: ref;

// $stringLiteral2 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral2, System.String) && $StringLength($stringLiteral2) == 7 && (forall heap: HeapType :: { heap[$stringLiteral2, $allocated] } IsHeap(heap) ==> heap[$stringLiteral2, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral2) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral2) == $stringLiteral2) && (forall heap: HeapType :: { IsFrozen($stringLiteral2, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral2, heap));

const unique $stringLiteral3: ref;

// $stringLiteral3 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral3, System.String) && $StringLength($stringLiteral3) == 3 && (forall heap: HeapType :: { heap[$stringLiteral3, $allocated] } IsHeap(heap) ==> heap[$stringLiteral3, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral3) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral3) == $stringLiteral3) && (forall heap: HeapType :: { IsFrozen($stringLiteral3, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral3, heap));

const unique $stringLiteral5: ref;

// $stringLiteral5 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral5, System.String) && $StringLength($stringLiteral5) == 3 && (forall heap: HeapType :: { heap[$stringLiteral5, $allocated] } IsHeap(heap) ==> heap[$stringLiteral5, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral5) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral5) == $stringLiteral5) && (forall heap: HeapType :: { IsFrozen($stringLiteral5, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral5, heap));

const unique $stringLiteral7: ref;

// $stringLiteral7 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral7, System.String) && $StringLength($stringLiteral7) == 6 && (forall heap: HeapType :: { heap[$stringLiteral7, $allocated] } IsHeap(heap) ==> heap[$stringLiteral7, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral7) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral7) == $stringLiteral7) && (forall heap: HeapType :: { IsFrozen($stringLiteral7, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral7, heap));

const unique $stringLiteral9: ref;

// $stringLiteral9 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral9, System.String) && $StringLength($stringLiteral9) == 6 && (forall heap: HeapType :: { heap[$stringLiteral9, $allocated] } IsHeap(heap) ==> heap[$stringLiteral9, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral9) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral9) == $stringLiteral9) && (forall heap: HeapType :: { IsFrozen($stringLiteral9, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral9, heap));

const unique $stringLiteral10: ref;

// $stringLiteral10 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral10, System.String) && $StringLength($stringLiteral10) == 6 && (forall heap: HeapType :: { heap[$stringLiteral10, $allocated] } IsHeap(heap) ==> heap[$stringLiteral10, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral10) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral10) == $stringLiteral10) && (forall heap: HeapType :: { IsFrozen($stringLiteral10, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral10, heap));

const unique $stringLiteral12: ref;

// $stringLiteral12 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral12, System.String) && $StringLength($stringLiteral12) == 6 && (forall heap: HeapType :: { heap[$stringLiteral12, $allocated] } IsHeap(heap) ==> heap[$stringLiteral12, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral12) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral12) == $stringLiteral12) && (forall heap: HeapType :: { IsFrozen($stringLiteral12, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral12, heap));

const unique $stringLiteral13: ref;

// $stringLiteral13 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral13, System.String) && $StringLength($stringLiteral13) == 7 && (forall heap: HeapType :: { heap[$stringLiteral13, $allocated] } IsHeap(heap) ==> heap[$stringLiteral13, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral13) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral13) == $stringLiteral13) && (forall heap: HeapType :: { IsFrozen($stringLiteral13, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral13, heap));

const unique $stringLiteral14: ref;

// $stringLiteral14 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral14, System.String) && $StringLength($stringLiteral14) == 2 && (forall heap: HeapType :: { heap[$stringLiteral14, $allocated] } IsHeap(heap) ==> heap[$stringLiteral14, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral14) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral14) == $stringLiteral14) && (forall heap: HeapType :: { IsFrozen($stringLiteral14, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral14, heap));

const unique $stringLiteral15: ref;

// $stringLiteral15 is allocated, interned, frozen, and has the appropriate type and length
axiom $IsNotNull($stringLiteral15, System.String) && $StringLength($stringLiteral15) == 3 && (forall heap: HeapType :: { heap[$stringLiteral15, $allocated] } IsHeap(heap) ==> heap[$stringLiteral15, $allocated]) && (forall heap: HeapType :: { #System.String.IsInterned$System.String$notnull(heap, $stringLiteral15) } IsHeap(heap) ==> #System.String.IsInterned$System.String$notnull(heap, $stringLiteral15) == $stringLiteral15) && (forall heap: HeapType :: { IsFrozen($stringLiteral15, heap) } IsHeap(heap) ==> IsFrozen($stringLiteral15, heap));
