
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

type SharingMode;

const unique $sharingMode: Field SharingMode;

const unique $SharingMode_Unshared: SharingMode;

const unique $SharingMode_LockProtected: SharingMode;

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

axiom IncludeInMainFrameCondition($elementsBool) && IncludeInMainFrameCondition($elementsInt) && IncludeInMainFrameCondition($elementsRef) 
//&& IncludeInMainFrameCondition($elementsReal) 
&& IncludeInMainFrameCondition($elementsStruct);

axiom !IncludeInMainFrameCondition($inv);

axiom !IncludeInMainFrameCondition($localinv);

axiom IncludeInMainFrameCondition($ownerRef);

axiom IncludeInMainFrameCondition($ownerFrame);

axiom IncludeInMainFrameCondition($exposeVersion);

axiom !IncludeInMainFrameCondition($FirstConsistentOwner);

function IsStaticField<alpha>(f: Field alpha) : bool;

axiom !IsStaticField($allocated);

axiom !IsStaticField($elementsBool) && !IsStaticField($elementsInt) && !IsStaticField($elementsRef) && !IsStaticField($elementsStruct);
/*&& !IsStaticField($elementsReal) */


axiom !IsStaticField($inv);

axiom !IsStaticField($localinv);

axiom !IsStaticField($exposeVersion);

function $IncludedInModifiesStar<alpha>(f: Field alpha) : bool;

axiom !$IncludedInModifiesStar($ownerRef);

axiom !$IncludedInModifiesStar($ownerFrame);

axiom $IncludedInModifiesStar($exposeVersion);

axiom $IncludedInModifiesStar($elementsBool) && $IncludedInModifiesStar($elementsInt) && $IncludedInModifiesStar($elementsRef) 
/*&& $IncludedInModifiesStar($elementsReal)*/ 
&& $IncludedInModifiesStar($elementsStruct);

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

axiom (forall a: ref, i: int, heap: HeapType :: { heap[ArrayGet(heap[a, $elementsRef], i), $ownerRef] } { heap[ArrayGet(heap[a, $elementsRef], i), $ownerFrame] } IsHeap(heap) && $typeof(a) <: System.Array ==> ArrayGet(heap[a, $elementsRef], i) == null || $IsImmutable($typeof(ArrayGet(heap[a, $elementsRef], i))) || (heap[ArrayGet(heap[a, $elementsRef], i), $ownerRef] == heap[$ElementProxy(a, 0 - 1), $ownerRef] && heap[ArrayGet(heap[a, $elementsRef], i), $ownerFrame] == heap[$ElementProxy(a, 0 - 1), $ownerFrame]));

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

function $IsImmutable(T: TName) : bool;

axiom !$IsImmutable(System.Object);

function $AsImmutable(T: TName) : TName;

function $AsMutable(T: TName) : TName;

axiom (forall T: TName, U: TName :: { U <: $AsImmutable(T) } U <: $AsImmutable(T) ==> $IsImmutable(U) && $AsImmutable(U) == U);

axiom (forall T: TName, U: TName :: { U <: $AsMutable(T) } U <: $AsMutable(T) ==> !$IsImmutable(U) && $AsMutable(U) == U);

function AsOwner(string: ref, owner: ref) : ref;

axiom (forall o: ref, T: TName :: { $typeof(o) <: $AsImmutable(T) } o != null && o != $BeingConstructed && $typeof(o) <: $AsImmutable(T) ==> (forall h: HeapType :: { IsHeap(h) } IsHeap(h) ==> h[o, $inv] == $typeof(o) && h[o, $localinv] == $typeof(o) && h[o, $ownerFrame] == $PeerGroupPlaceholder && AsOwner(o, h[o, $ownerRef]) == o && (forall t: ref :: { AsOwner(o, h[t, $ownerRef]) } AsOwner(o, h[t, $ownerRef]) == o ==> t == o || h[t, $ownerFrame] != $PeerGroupPlaceholder)));

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

function $RealToReal(val: real, fromType: TName, toType: TName) : real;
*/
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

axiom (forall i: int, j: int :: { #shr(i, j) } 1 <= j ==> #shr(i, j) == #shr(i, j - 1) div 2);

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

const unique RTE.Instructions: Field ref;

const unique RTE.C: Field bool;

const unique RTE.CallStack: Field ref;

const unique RTE.Z: Field bool;

const unique RTE.Scratch: Field ref;

const unique RTE.MSP: Field int;

const unique RTE.CurrRTEMode: Field int;

const unique RTE.DPP: Field int;

const unique Memory.contents: Field ref;

const unique RTE.Program: Field ref;

const unique RTE.MStackBase: Field int;

const unique RTE.A: Field int;

const unique RTE.PC: Field int;

const unique RTE.RtnCode: Field int;

const unique RTE.CSP: Field int;

const unique RTE.Data: Field ref;

const unique RTE.MStackMaxSize: Field int;

const unique System.Reflection.IReflect: TName;

const unique System.Runtime.InteropServices._Type: TName;

const unique RTE: TName;

const unique Microsoft.Contracts.ObjectInvariantException: TName;

const unique System.Collections.Generic.IEnumerable`1...System.Char: TName;

const unique System.IComparable`1...System.String: TName;

const unique System.Collections.IEnumerable: TName;

const unique System.ICloneable: TName;

const unique System.Runtime.Serialization.ISerializable: TName;

const unique System.IComparable: TName;

const unique System.Runtime.InteropServices._Exception: TName;

const unique System.Collections.ICollection: TName;

const unique System.Runtime.InteropServices._MemberInfo: TName;

const unique System.IEquatable`1...System.String: TName;

const unique System.Exception: TName;

const unique Microsoft.Contracts.GuardException: TName;

const unique Memory: TName;

const unique System.Reflection.ICustomAttributeProvider: TName;

const unique System.Collections.IList: TName;

const unique Microsoft.Contracts.ICheckedException: TName;

const unique System.Reflection.MemberInfo: TName;

const unique System.IConvertible: TName;

axiom !IsStaticField(Memory.contents);

axiom IncludeInMainFrameCondition(Memory.contents);

axiom $IncludedInModifiesStar(Memory.contents);

axiom AsRepField(Memory.contents, Memory) == Memory.contents;

axiom DeclType(Memory.contents) == Memory;

axiom AsNonNullRefField(Memory.contents, IntArray(System.Byte, 1)) == Memory.contents;

function ##Memory.contents(ref) : ref;

// strict-readonly field is a function of the reference
axiom (forall $heap: HeapType, $r: ref :: { $heap[$r, Memory.contents] } IsHeap($heap) ==> $heap[$r, Memory.contents] == ##Memory.contents($r));

function #Memory.get_cont$System.Int32(HeapType, ref, int) : int;

function ##Memory.get_cont$System.Int32(exposeVersionType, int) : int;

function #Memory.InSandbox$System.Int32(HeapType, ref, int) : bool;

function ##Memory.InSandbox$System.Int32(exposeVersionType, int) : bool;

axiom !IsStaticField(RTE.Data);

axiom IncludeInMainFrameCondition(RTE.Data);

axiom $IncludedInModifiesStar(RTE.Data);

axiom AsRepField(RTE.Data, RTE) == RTE.Data;

axiom DeclType(RTE.Data) == RTE;

axiom AsNonNullRefField(RTE.Data, Memory) == RTE.Data;

axiom !IsStaticField(RTE.CallStack);

axiom IncludeInMainFrameCondition(RTE.CallStack);

axiom $IncludedInModifiesStar(RTE.CallStack);

axiom AsRepField(RTE.CallStack, RTE) == RTE.CallStack;

axiom DeclType(RTE.CallStack) == RTE;

axiom AsNonNullRefField(RTE.CallStack, IntArray(System.Int32, 1)) == RTE.CallStack;

axiom !IsStaticField(RTE.CSP);

axiom IncludeInMainFrameCondition(RTE.CSP);

axiom $IncludedInModifiesStar(RTE.CSP);

axiom DeclType(RTE.CSP) == RTE;

axiom AsRangeField(RTE.CSP, System.Int32) == RTE.CSP;

axiom !IsStaticField(RTE.MStackBase);

axiom IncludeInMainFrameCondition(RTE.MStackBase);

axiom $IncludedInModifiesStar(RTE.MStackBase);

axiom DeclType(RTE.MStackBase) == RTE;

axiom AsRangeField(RTE.MStackBase, System.Int32) == RTE.MStackBase;

function ##RTE.MStackBase(ref) : int;

// strict-readonly field is a function of the reference
axiom (forall $heap: HeapType, $r: ref :: { $heap[$r, RTE.MStackBase] } IsHeap($heap) ==> $heap[$r, RTE.MStackBase] == ##RTE.MStackBase($r));

axiom !IsStaticField(RTE.MSP);

axiom IncludeInMainFrameCondition(RTE.MSP);

axiom $IncludedInModifiesStar(RTE.MSP);

axiom DeclType(RTE.MSP) == RTE;

axiom AsRangeField(RTE.MSP, System.Int32) == RTE.MSP;

axiom !IsStaticField(RTE.MStackMaxSize);

axiom IncludeInMainFrameCondition(RTE.MStackMaxSize);

axiom $IncludedInModifiesStar(RTE.MStackMaxSize);

axiom DeclType(RTE.MStackMaxSize) == RTE;

axiom AsRangeField(RTE.MStackMaxSize, System.Int32) == RTE.MStackMaxSize;

function ##RTE.MStackMaxSize(ref) : int;

// strict-readonly field is a function of the reference
axiom (forall $heap: HeapType, $r: ref :: { $heap[$r, RTE.MStackMaxSize] } IsHeap($heap) ==> $heap[$r, RTE.MStackMaxSize] == ##RTE.MStackMaxSize($r));

axiom !IsStaticField(RTE.Scratch);

axiom IncludeInMainFrameCondition(RTE.Scratch);

axiom $IncludedInModifiesStar(RTE.Scratch);

axiom AsRepField(RTE.Scratch, RTE) == RTE.Scratch;

axiom DeclType(RTE.Scratch) == RTE;

axiom AsNonNullRefField(RTE.Scratch, Memory) == RTE.Scratch;

axiom !IsStaticField(RTE.DPP);

axiom IncludeInMainFrameCondition(RTE.DPP);

axiom $IncludedInModifiesStar(RTE.DPP);

axiom DeclType(RTE.DPP) == RTE;

axiom AsRangeField(RTE.DPP, System.Int32) == RTE.DPP;

axiom !IsStaticField(RTE.A);

axiom IncludeInMainFrameCondition(RTE.A);

axiom $IncludedInModifiesStar(RTE.A);

axiom DeclType(RTE.A) == RTE;

axiom AsRangeField(RTE.A, System.Int32) == RTE.A;

axiom !IsStaticField(RTE.Z);

axiom IncludeInMainFrameCondition(RTE.Z);

axiom $IncludedInModifiesStar(RTE.Z);

axiom DeclType(RTE.Z) == RTE;

axiom !IsStaticField(RTE.C);

axiom IncludeInMainFrameCondition(RTE.C);

axiom $IncludedInModifiesStar(RTE.C);

axiom DeclType(RTE.C) == RTE;

axiom !IsStaticField(RTE.PC);

axiom IncludeInMainFrameCondition(RTE.PC);

axiom $IncludedInModifiesStar(RTE.PC);

axiom DeclType(RTE.PC) == RTE;

axiom AsRangeField(RTE.PC, System.Int32) == RTE.PC;

axiom !IsStaticField(RTE.CurrRTEMode);

axiom IncludeInMainFrameCondition(RTE.CurrRTEMode);

axiom $IncludedInModifiesStar(RTE.CurrRTEMode);

axiom DeclType(RTE.CurrRTEMode) == RTE;

axiom AsRangeField(RTE.CurrRTEMode, System.Int32) == RTE.CurrRTEMode;

axiom !IsStaticField(RTE.RtnCode);

axiom IncludeInMainFrameCondition(RTE.RtnCode);

axiom $IncludedInModifiesStar(RTE.RtnCode);

axiom DeclType(RTE.RtnCode) == RTE;

axiom AsRangeField(RTE.RtnCode, System.Int32) == RTE.RtnCode;

axiom !IsStaticField(RTE.Program);

axiom IncludeInMainFrameCondition(RTE.Program);

axiom $IncludedInModifiesStar(RTE.Program);

axiom AsRepField(RTE.Program, RTE) == RTE.Program;

axiom DeclType(RTE.Program) == RTE;

axiom AsNonNullRefField(RTE.Program, Memory) == RTE.Program;

axiom !IsStaticField(RTE.Instructions);

axiom IncludeInMainFrameCondition(RTE.Instructions);

axiom $IncludedInModifiesStar(RTE.Instructions);

axiom AsRepField(RTE.Instructions, RTE) == RTE.Instructions;

axiom DeclType(RTE.Instructions) == RTE;

axiom AsNonNullRefField(RTE.Instructions, IntArray(System.Int32, 1)) == RTE.Instructions;

axiom Memory <: Memory;

axiom $BaseClass(Memory) == System.Object && AsDirectSubClass(Memory, $BaseClass(Memory)) == Memory;

axiom !$IsImmutable(Memory) && $AsMutable(Memory) == Memory;

// Memory object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: Memory } IsHeap($h) && $h[$oi, $inv] <: Memory && $h[$oi, $localinv] != $BaseClass(Memory) ==> true);

axiom System.Array <: System.Array;

axiom $BaseClass(System.Array) == System.Object && AsDirectSubClass(System.Array, $BaseClass(System.Array)) == System.Array;

axiom !$IsImmutable(System.Array) && $AsMutable(System.Array) == System.Array;

axiom System.ICloneable <: System.ICloneable;

axiom $IsMemberlessType(System.ICloneable);

axiom $AsInterface(System.ICloneable) == System.ICloneable;

axiom System.Array <: System.ICloneable;

axiom System.Collections.IList <: System.Collections.IList;

axiom System.Collections.ICollection <: System.Collections.ICollection;

axiom System.Collections.IEnumerable <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.IEnumerable);

axiom $AsInterface(System.Collections.IEnumerable) == System.Collections.IEnumerable;

axiom System.Collections.ICollection <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.ICollection);

axiom $AsInterface(System.Collections.ICollection) == System.Collections.ICollection;

axiom System.Collections.IList <: System.Collections.ICollection;

axiom System.Collections.IList <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Collections.IList);

axiom $AsInterface(System.Collections.IList) == System.Collections.IList;

axiom System.Array <: System.Collections.IList;

axiom System.Array <: System.Collections.ICollection;

axiom System.Array <: System.Collections.IEnumerable;

axiom $IsMemberlessType(System.Array);

// System.Array object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.Array } IsHeap($h) && $h[$oi, $inv] <: System.Array && $h[$oi, $localinv] != $BaseClass(System.Array) ==> true);

procedure Memory..ctor$System.Int32(this: ref where $IsNotNull(this, Memory) && $Heap[this, $allocated], n$in: int where InRange(n$in, System.Int32));
  // object is fully unpacked:  this.inv == Object
  free requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  // user-declared preconditions
  requires 0 < n$in;
  // nothing is owned by [this,*] and 'this' is alone in its own peer group
  free requires (forall $o: ref :: $o != this ==> $Heap[$o, $ownerRef] != this) && $Heap[this, $ownerRef] == this && $Heap[this, $ownerFrame] == $PeerGroupPlaceholder;
  free requires $BeingConstructed == this;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures $Length($Heap[this, Memory.contents]) == n$in;
  // target object is allocated upon return
  free ensures $Heap[this, $allocated];
  // target object is additively exposable for Memory
  ensures ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == Memory && $Heap[this, $localinv] == $typeof(this);
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(Memory <: DeclType($f))) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] && $o != this ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation Memory..ctor$System.Int32(this: ref, n$in: int)
{
  var n: int where InRange(n, System.Int32);
  var stack0i: int;
  var stack0o: ref;
  var temp0: ref;
  var temp1: exposeVersionType;

  entry:
    n := n$in;
    goto block3009;

  block3009:
    goto block3247;

  block3247:
    // ----- nop  ----- WindowsCard.ssc(7,5)
    // ----- copy  ----- WindowsCard.ssc(10,5)
    stack0i := n;
    // ----- new array  ----- WindowsCard.ssc(10,5)
    assert 0 <= stack0i;
    havoc temp0;
    assume $Heap[temp0, $allocated] == false && $Length(temp0) == stack0i;
    assume $Heap[$ElementProxy(temp0, -1), $allocated] == false && $ElementProxy(temp0, -1) != temp0 && $ElementProxy(temp0, -1) != null;
    assume temp0 != null;
    assume $typeof(temp0) == IntArray(System.Byte, 1);
    assume $Heap[temp0, $ownerRef] == temp0 && $Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder;
    assume $Heap[$ElementProxy(temp0, -1), $ownerRef] == $ElementProxy(temp0, -1) && $Heap[$ElementProxy(temp0, -1), $ownerFrame] == $PeerGroupPlaceholder;
    assume $Heap[temp0, $inv] == $typeof(temp0) && $Heap[temp0, $localinv] == $typeof(temp0);
    assume (forall $i: int :: ArrayGet($Heap[temp0, $elementsInt], $i) == 0);
    $Heap[temp0, $allocated] := true;
    call System.Object..ctor($ElementProxy(temp0, -1));
    stack0o := temp0;
    assume IsHeap($Heap);
    // ----- store field  ----- WindowsCard.ssc(10,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    assert ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == Memory) || $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: Memory && $Heap[this, $localinv] != $BaseClass(Memory) ==> (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[stack0o, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[stack0o, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: Memory && $Heap[this, $localinv] != $BaseClass(Memory) ==> $Heap[this, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[this, $ownerFrame] != $Heap[stack0o, $ownerFrame];
    assert stack0o == null || ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == Memory) || (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(Memory <: DeclType($f))) && true && true ==> !($f == $ownerRef || $f == $ownerFrame) || $Heap[$o, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[$o, $ownerFrame] != $Heap[stack0o, $ownerFrame]);
    call $UpdateOwnersForRep(this, Memory, stack0o);
    havoc temp1;
    $Heap[this, $exposeVersion] := temp1;
    assume $Heap[this, Memory.contents] == stack0o;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- call  ----- WindowsCard.ssc(11,5)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(Memory <: DeclType($f))) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || !(System.Object <: DeclType($f))) && true && true);
    call System.Object..ctor(this);
    goto block3060;

  block3060:
    // ----- nop  ----- WindowsCard.ssc(8,13)
    // ----- return  ----- WindowsCard.ssc(8,13)
    // ----- translation-inserted post-constructor pack
    assert this != null;
    assert $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == this && $Heap[$p, $ownerFrame] == Memory ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[this, $inv] := Memory;
    assume IsHeap($Heap);
    return;
}



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
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref, addr$in: int :: { #Memory.get_cont$System.Int32($Heap, this, addr$in) } IsPreHeap($Heap) && $IsNotNull(this, Memory) && $Heap[this, $allocated] && 0 <= addr$in && addr$in < $Length($Heap[this, Memory.contents]) && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder ==> ($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && (!($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref, addr$in: int :: { #Memory.get_cont$System.Int32($Heap, this, addr$in) } this != null && $typeof(this) <: Memory && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #Memory.get_cont$System.Int32($Heap, this, addr$in) == ##Memory.get_cont$System.Int32($Heap[this, $exposeVersion], addr$in));

procedure Memory.get_cont$System.Int32(this: ref where $IsNotNull(this, Memory) && $Heap[this, $allocated], addr$in: int where InRange(addr$in, System.Int32)) returns ($result: int where InRange($result, System.Byte));
  // user-declared preconditions
  requires 0 <= addr$in;
  requires addr$in < $Length($Heap[this, Memory.contents]);
  // target object is peer valid (pure method)
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // parameter of a pure method
  free requires $AsPureObject(this) == this;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // FCO info about pure receiver
  free ensures $Heap[this, $ownerFrame] != $PeerGroupPlaceholder ==> ($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && (!($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner]);
  // parameter of a pure method
  free ensures $AsPureObject(this) == this;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $result == #Memory.get_cont$System.Int32($Heap, this, addr$in);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation Memory.get_cont$System.Int32(this: ref, addr$in: int) returns ($result: int)
{
  var addr: int where InRange(addr, System.Int32);
  var stack0o: ref;
  var stack1i: int;
  var return.value: int where InRange(return.value, System.Byte);
  var SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Byte);
  var stack0i: int;

  entry:
    addr := addr$in;
    goto block3672;

  block3672:
    goto block3842;

  block3842:
    // ----- nop  ----- WindowsCard.ssc(17,5)
    // ----- load field  ----- WindowsCard.ssc(19,5)
    assert this != null;
    stack0o := $Heap[this, Memory.contents];
    // ----- copy  ----- WindowsCard.ssc(19,5)
    stack1i := addr;
    // ----- load element  ----- WindowsCard.ssc(19,5)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    return.value := ArrayGet($Heap[stack0o, $elementsInt], stack1i);
    // ----- branch  ----- WindowsCard.ssc(19,5)
    goto block3808;

  block3808:
    // ----- copy  ----- WindowsCard.ssc(19,5)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(19,5)
    stack0i := return.value;
    // ----- return  ----- WindowsCard.ssc(19,5)
    $result := stack0i;
    return;
}



procedure Memory.set_cont$System.Int32$System.Byte(this: ref where $IsNotNull(this, Memory) && $Heap[this, $allocated], addr$in: int where InRange(addr$in, System.Int32), value$in: int where InRange(value$in, System.Byte));
  // user-declared preconditions
  requires 0 <= addr$in;
  requires addr$in < $Length($Heap[this, Memory.contents]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation Memory.set_cont$System.Int32$System.Byte(this: ref, addr$in: int, value$in: int)
{
  var addr: int where InRange(addr, System.Int32);
  var value: int where InRange(value, System.Byte);
  var local1: ref where $Is(local1, Memory) && $Heap[local1, $allocated];
  var stack0o: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp0: exposeVersionType;
  var stack1i: int;

  entry:
    addr := addr$in;
    value := value$in;
    goto block4658;

  block4658:
    goto block4862;

  block4862:
    // ----- nop  ----- WindowsCard.ssc(24,5)
    // ----- copy  ----- WindowsCard.ssc(26,12)
    local1 := this;
    // ----- copy  ----- WindowsCard.ssc(26,12)
    stack0o := local1;
    // ----- load token  ----- WindowsCard.ssc(26,12)
    havoc stack1s;
    assume $IsTokenForType(stack1s, Memory);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(26,12)
    stack1o := TypeObject(Memory);
    // ----- local unpack  ----- WindowsCard.ssc(26,12)
    assert stack0o != null;
    assert ($Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame])) && $Heap[stack0o, $inv] <: Memory && $Heap[stack0o, $localinv] == $typeof(stack0o);
    $Heap[stack0o, $localinv] := System.Object;
    havoc temp0;
    // ----- frame condition  ----- WindowsCard.ssc(26,12)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && (stack0o != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[stack0o, $exposeVersion] := temp0;
    assume IsHeap($Heap);
    goto block4879;

  block4879:
    // ----- load field  ----- WindowsCard.ssc(27,7)
    assert this != null;
    stack0o := $Heap[this, Memory.contents];
    // ----- copy  ----- WindowsCard.ssc(27,7)
    stack1i := addr;
    // ----- store element  ----- WindowsCard.ssc(27,7)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    // ----- frame condition  ----- WindowsCard.ssc(27,7)
    assert !(old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && true);
    $Heap[stack0o, $elementsInt] := ArraySet($Heap[stack0o, $elementsInt], stack1i, value);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(27,7)
    goto block4930;

  block4930:
    // ----- copy  ----- WindowsCard.ssc(28,5)
    stack0o := local1;
    // ----- load token  ----- WindowsCard.ssc(28,5)
    havoc stack1s;
    assume $IsTokenForType(stack1s, Memory);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(28,5)
    stack1o := TypeObject(Memory);
    // ----- local pack  ----- WindowsCard.ssc(28,5)
    assert stack0o != null;
    assert $Heap[stack0o, $localinv] == System.Object;
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == stack0o && $Heap[$p, $ownerFrame] == Memory ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[stack0o, $localinv] := $typeof(stack0o);
    assume IsHeap($Heap);
    // ----- nop  ----- WindowsCard.ssc(28,5)
    // ----- branch
    goto block4896;

  block4896:
    // ----- return  ----- WindowsCard.ssc(28,5)
    return;
}



axiom System.Type <: System.Type;

axiom System.Reflection.MemberInfo <: System.Reflection.MemberInfo;

axiom $BaseClass(System.Reflection.MemberInfo) == System.Object && AsDirectSubClass(System.Reflection.MemberInfo, $BaseClass(System.Reflection.MemberInfo)) == System.Reflection.MemberInfo;

axiom $IsImmutable(System.Reflection.MemberInfo) && $AsImmutable(System.Reflection.MemberInfo) == System.Reflection.MemberInfo;

axiom System.Reflection.ICustomAttributeProvider <: System.Reflection.ICustomAttributeProvider;

axiom $IsMemberlessType(System.Reflection.ICustomAttributeProvider);

axiom $AsInterface(System.Reflection.ICustomAttributeProvider) == System.Reflection.ICustomAttributeProvider;

axiom System.Reflection.MemberInfo <: System.Reflection.ICustomAttributeProvider;

axiom System.Runtime.InteropServices._MemberInfo <: System.Runtime.InteropServices._MemberInfo;

axiom $IsMemberlessType(System.Runtime.InteropServices._MemberInfo);

axiom $AsInterface(System.Runtime.InteropServices._MemberInfo) == System.Runtime.InteropServices._MemberInfo;

axiom System.Reflection.MemberInfo <: System.Runtime.InteropServices._MemberInfo;

axiom $IsMemberlessType(System.Reflection.MemberInfo);

// System.Reflection.MemberInfo object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.Reflection.MemberInfo } IsHeap($h) && $h[$oi, $inv] <: System.Reflection.MemberInfo && $h[$oi, $localinv] != $BaseClass(System.Reflection.MemberInfo) ==> true);

axiom $BaseClass(System.Type) == System.Reflection.MemberInfo && AsDirectSubClass(System.Type, $BaseClass(System.Type)) == System.Type;

axiom $IsImmutable(System.Type) && $AsImmutable(System.Type) == System.Type;

axiom System.Runtime.InteropServices._Type <: System.Runtime.InteropServices._Type;

axiom $IsMemberlessType(System.Runtime.InteropServices._Type);

axiom $AsInterface(System.Runtime.InteropServices._Type) == System.Runtime.InteropServices._Type;

axiom System.Type <: System.Runtime.InteropServices._Type;

axiom System.Reflection.IReflect <: System.Reflection.IReflect;

axiom $IsMemberlessType(System.Reflection.IReflect);

axiom $AsInterface(System.Reflection.IReflect) == System.Reflection.IReflect;

axiom System.Type <: System.Reflection.IReflect;

axiom $IsMemberlessType(System.Type);

// System.Type object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.Type } IsHeap($h) && $h[$oi, $inv] <: System.Type && $h[$oi, $localinv] != $BaseClass(System.Type) ==> true);

// purity axiom (confined)
axiom $PurityAxiomsCanBeAssumed ==> (forall $Heap: HeapType, this: ref, addr$in: int :: { #Memory.InSandbox$System.Int32($Heap, this, addr$in) } IsPreHeap($Heap) && $IsNotNull(this, Memory) && $Heap[this, $allocated] && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc)) ==> (#Memory.InSandbox$System.Int32($Heap, this, addr$in) ==> 0 <= addr$in && addr$in < $Length($Heap[this, Memory.contents])) && ($Heap[this, $ownerFrame] != $PeerGroupPlaceholder ==> ($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && (!($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner])) && $AsPureObject(this) == this);

// expose version axiom for confined methods
axiom (forall $Heap: HeapType, this: ref, addr$in: int :: { #Memory.InSandbox$System.Int32($Heap, this, addr$in) } this != null && $typeof(this) <: Memory && $Heap[this, $inv] == $typeof(this) && $Heap[this, $localinv] == $typeof(this) && IsHeap($Heap) && $Heap[this, $allocated] ==> #Memory.InSandbox$System.Int32($Heap, this, addr$in) == ##Memory.InSandbox$System.Int32($Heap[this, $exposeVersion], addr$in));

procedure Memory.InSandbox$System.Int32(this: ref where $IsNotNull(this, Memory) && $Heap[this, $allocated], addr$in: int where InRange(addr$in, System.Int32)) returns ($result: bool where true);
  // target object is peer valid (pure method)
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // parameter of a pure method
  free requires $AsPureObject(this) == this;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures $result ==> 0 <= addr$in && addr$in < $Length($Heap[this, Memory.contents]);
  // FCO info about pure receiver
  free ensures $Heap[this, $ownerFrame] != $PeerGroupPlaceholder ==> ($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame]) ==> $Heap[this, $FirstConsistentOwner] == $Heap[this, $ownerRef]) && (!($Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $inv] <: $Heap[$Heap[this, $ownerRef], $ownerFrame] && $Heap[$Heap[$Heap[this, $ownerRef], $ownerRef], $localinv] != $BaseClass($Heap[$Heap[this, $ownerRef], $ownerFrame])) ==> $Heap[this, $FirstConsistentOwner] == $Heap[$Heap[this, $ownerRef], $FirstConsistentOwner]);
  // parameter of a pure method
  free ensures $AsPureObject(this) == this;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  free ensures $Heap == old($Heap);
  free ensures $result == #Memory.InSandbox$System.Int32($Heap, this, addr$in);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation Memory.InSandbox$System.Int32(this: ref, addr$in: int) returns ($result: bool)
{
  var addr: int where InRange(addr, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var stack0o: ref;
  var return.value: bool where true;
  var SS$Display.Return.Local: bool where true;

  entry:
    addr := addr$in;
    goto block5746;

  block5746:
    goto block5967;

  block5967:
    // ----- load constant 0  ----- WindowsCard.ssc(35,5)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(35,5)
    // ----- branch  ----- WindowsCard.ssc(35,5)
    goto true5967to5933, false5967to5780;

  true5967to5933:
    assume stack0i > addr;
    goto block5933;

  false5967to5780:
    assume stack0i <= addr;
    goto block5780;

  block5933:
    // ----- load constant 0  ----- WindowsCard.ssc(35,5)
    stack0b := false;
    goto block5814;

  block5780:
    // ----- load field  ----- WindowsCard.ssc(35,5)
    assert this != null;
    stack0o := $Heap[this, Memory.contents];
    // ----- unary operator  ----- WindowsCard.ssc(35,5)
    assert stack0o != null;
    stack0i := $Length(stack0o);
    // ----- unary operator  ----- WindowsCard.ssc(35,5)
    stack0i := $IntToInt(stack0i, System.UIntPtr, System.Int32);
    // ----- binary operator  ----- WindowsCard.ssc(35,5)
    // ----- branch  ----- WindowsCard.ssc(35,5)
    goto true5780to5984, false5780to6103;

  true5780to5984:
    assume addr < stack0i;
    goto block5984;

  false5780to6103:
    assume addr >= stack0i;
    goto block6103;

  block5984:
    // ----- load constant 1  ----- WindowsCard.ssc(35,5)
    stack0b := true;
    goto block6001;

  block6103:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(35,5)
    goto block6001;

  block5814:
    // ----- copy  ----- WindowsCard.ssc(35,5)
    return.value := stack0b;
    // ----- branch  ----- WindowsCard.ssc(35,5)
    goto block5763;

  block5763:
    // ----- nop  ----- WindowsCard.ssc(33,13)
    // ----- copy  ----- WindowsCard.ssc(33,13)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(36,3)
    stack0b := return.value;
    // ----- return  ----- WindowsCard.ssc(36,3)
    $result := stack0b;
    return;

  block6001:
    // ----- branch  ----- WindowsCard.ssc(35,5)
    goto block5814;
}



axiom RTE <: RTE;

axiom $BaseClass(RTE) == System.Object && AsDirectSubClass(RTE, $BaseClass(RTE)) == RTE;

axiom !$IsImmutable(RTE) && $AsMutable(RTE) == RTE;

axiom (forall $U: TName :: { $U <: RTE } $U <: RTE ==> $U == RTE);

// RTE object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: RTE } IsHeap($h) && $h[$oi, $inv] <: RTE && $h[$oi, $localinv] != $BaseClass(RTE) ==> 65536 == $Length($h[$h[$oi, RTE.Data], Memory.contents]) && $Length($h[$oi, RTE.CallStack]) == 10 && 0 <= $h[$oi, RTE.CSP] && $h[$oi, RTE.CSP] <= 10 && $h[$oi, RTE.MStackBase] <= $h[$oi, RTE.MSP] && $h[$oi, RTE.MSP] <= $h[$oi, RTE.MStackBase] + $h[$oi, RTE.MStackMaxSize] && $h[$oi, RTE.MSP] mod 4 == 0 && $h[$oi, RTE.MStackBase] mod 4 == 0 && $h[$oi, RTE.MStackMaxSize] mod 4 == 0 && $h[$oi, RTE.MStackBase] + $h[$oi, RTE.MStackMaxSize] <= $Length($h[$h[$oi, RTE.Scratch], Memory.contents]) && 0 <= $h[$oi, RTE.MStackBase] && 0 <= $h[$oi, RTE.MStackMaxSize] && $h[$oi, RTE.DPP] == $h[$oi, RTE.MStackBase] + $h[$oi, RTE.MStackMaxSize]);

procedure RTE.SpecSharp.CheckInvariant$System.Boolean(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], throwException$in: bool where true) returns ($result: bool where true);
  // user-declared preconditions
  requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this) && (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == this && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.SpecSharp.CheckInvariant$System.Boolean(this: ref, throwException$in: bool) returns ($result: bool)
{
  var throwException: bool where true;
  var stack0i: int;
  var stack1o: ref;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack50000o: ref;
  var return.value: bool where true;
  var SS$Display.Return.Local: bool where true;
  var stack2i: int;

  entry:
    throwException := throwException$in;
    goto block8194;

  block8194:
    goto block8942;

  block8942:
    // ----- nop  ----- WindowsCard.ssc(138,3)
    // ----- load constant 65536  ----- WindowsCard.ssc(138,3)
    stack0i := 65536;
    // ----- load field  ----- WindowsCard.ssc(138,3)
    assert this != null;
    stack1o := $Heap[this, RTE.Data];
    // ----- load field  ----- WindowsCard.ssc(138,3)
    assert stack1o != null;
    stack1o := $Heap[stack1o, Memory.contents];
    // ----- unary operator  ----- WindowsCard.ssc(138,3)
    assert stack1o != null;
    stack1i := $Length(stack1o);
    // ----- unary operator  ----- WindowsCard.ssc(138,3)
    stack1i := $IntToInt(stack1i, System.UIntPtr, System.Int32);
    // ----- binary operator  ----- WindowsCard.ssc(138,3)
    // ----- branch  ----- WindowsCard.ssc(138,3)
    goto true8942to8500, false8942to8211;

  true8942to8500:
    assume stack0i == stack1i;
    goto block8500;

  false8942to8211:
    assume stack0i != stack1i;
    goto block8211;

  block8500:
    // ----- load field  ----- WindowsCard.ssc(138,3)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- unary operator  ----- WindowsCard.ssc(138,3)
    assert stack0o != null;
    stack0i := $Length(stack0o);
    // ----- unary operator  ----- WindowsCard.ssc(138,3)
    stack0i := $IntToInt(stack0i, System.UIntPtr, System.Int32);
    // ----- load constant 10  ----- WindowsCard.ssc(138,3)
    stack1i := 10;
    // ----- binary operator  ----- WindowsCard.ssc(138,3)
    // ----- branch  ----- WindowsCard.ssc(138,3)
    goto true8500to8653, false8500to8840;

  block8211:
    // ----- copy  ----- WindowsCard.ssc(138,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(138,3)
    // ----- branch  ----- WindowsCard.ssc(138,3)
    goto true8211to8296, false8211to9129;

  true8211to8296:
    assume !stack0b;
    goto block8296;

  false8211to9129:
    assume stack0b;
    goto block9129;

  block8296:
    // ----- load constant 0  ----- WindowsCard.ssc(138,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(138,3)
    goto block8517;

  block9129:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(138,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(138,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(138,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(138,3)
    assert stack0o != null;
    assume false;
    return;

  true8500to8653:
    assume stack0i == stack1i;
    goto block8653;

  false8500to8840:
    assume stack0i != stack1i;
    goto block8840;

  block8653:
    // ----- load constant 0  ----- WindowsCard.ssc(143,3)
    stack0i := 0;
    // ----- load field  ----- WindowsCard.ssc(143,3)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- binary operator  ----- WindowsCard.ssc(143,3)
    // ----- branch  ----- WindowsCard.ssc(143,3)
    goto true8653to9146, false8653to8602;

  block8840:
    // ----- copy  ----- WindowsCard.ssc(138,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(138,3)
    // ----- branch  ----- WindowsCard.ssc(138,3)
    goto true8840to8908, false8840to8976;

  true8840to8908:
    assume !stack0b;
    goto block8908;

  false8840to8976:
    assume stack0b;
    goto block8976;

  block8908:
    // ----- load constant 0  ----- WindowsCard.ssc(143,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(143,3)
    goto block8517;

  block8976:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(143,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(143,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(143,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(143,3)
    assert stack0o != null;
    assume false;
    return;

  true8653to9146:
    assume stack0i <= stack1i;
    goto block9146;

  false8653to8602:
    assume stack0i > stack1i;
    goto block8602;

  block9146:
    // ----- load field  ----- WindowsCard.ssc(145,3)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 10  ----- WindowsCard.ssc(145,3)
    stack1i := 10;
    // ----- binary operator  ----- WindowsCard.ssc(145,3)
    // ----- branch  ----- WindowsCard.ssc(145,3)
    goto true9146to8721, false9146to8313;

  block8602:
    // ----- copy  ----- WindowsCard.ssc(143,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(143,3)
    // ----- branch  ----- WindowsCard.ssc(143,3)
    goto true8602to8704, false8602to8874;

  block8517:
    // ----- copy  ----- WindowsCard.ssc(163,3)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(163,3)
    stack0b := return.value;
    // ----- return  ----- WindowsCard.ssc(163,3)
    $result := stack0b;
    return;

  true9146to8721:
    assume stack0i <= stack1i;
    goto block8721;

  false9146to8313:
    assume stack0i > stack1i;
    goto block8313;

  block8721:
    // ----- load field  ----- WindowsCard.ssc(146,3)
    assert this != null;
    stack0i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(146,3)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- binary operator  ----- WindowsCard.ssc(146,3)
    // ----- branch  ----- WindowsCard.ssc(146,3)
    goto true8721to8959, false8721to8755;

  block8313:
    // ----- copy  ----- WindowsCard.ssc(145,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(145,3)
    // ----- branch  ----- WindowsCard.ssc(145,3)
    goto true8313to8347, false8313to8993;

  true8602to8704:
    assume !stack0b;
    goto block8704;

  false8602to8874:
    assume stack0b;
    goto block8874;

  block8704:
    // ----- load constant 0  ----- WindowsCard.ssc(145,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(145,3)
    goto block8517;

  block8874:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(145,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(145,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(145,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(145,3)
    assert stack0o != null;
    assume false;
    return;

  true8313to8347:
    assume !stack0b;
    goto block8347;

  false8313to8993:
    assume stack0b;
    goto block8993;

  block8347:
    // ----- load constant 0  ----- WindowsCard.ssc(146,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(146,3)
    goto block8517;

  block8993:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(146,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(146,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(146,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(146,3)
    assert stack0o != null;
    assume false;
    return;

  true8721to8959:
    assume stack0i <= stack1i;
    goto block8959;

  false8721to8755:
    assume stack0i > stack1i;
    goto block8755;

  block8959:
    // ----- load field  ----- WindowsCard.ssc(153,3)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(153,3)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(153,3)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(153,3)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(153,3)
    // ----- branch  ----- WindowsCard.ssc(153,3)
    goto true8959to8534, false8959to8789;

  block8755:
    // ----- copy  ----- WindowsCard.ssc(146,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(146,3)
    // ----- branch  ----- WindowsCard.ssc(146,3)
    goto true8755to8279, false8755to8925;

  true8755to8279:
    assume !stack0b;
    goto block8279;

  false8755to8925:
    assume stack0b;
    goto block8925;

  block8279:
    // ----- load constant 0  ----- WindowsCard.ssc(153,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(153,3)
    goto block8517;

  block8925:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(153,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(153,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(153,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(153,3)
    assert stack0o != null;
    assume false;
    return;

  true8959to8534:
    assume stack0i <= stack1i;
    goto block8534;

  false8959to8789:
    assume stack0i > stack1i;
    goto block8789;

  block8534:
    // ----- load field  ----- WindowsCard.ssc(154,3)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(154,3)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(154,3)
    assert stack1i != 0;
    stack0i := stack0i mod stack1i;
    // ----- load constant 0  ----- WindowsCard.ssc(154,3)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(154,3)
    // ----- branch  ----- WindowsCard.ssc(154,3)
    goto true8534to9095, false8534to8687;

  block8789:
    // ----- copy  ----- WindowsCard.ssc(153,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(153,3)
    // ----- branch  ----- WindowsCard.ssc(153,3)
    goto true8789to9214, false8789to9112;

  true8534to9095:
    assume stack0i == stack1i;
    goto block9095;

  false8534to8687:
    assume stack0i != stack1i;
    goto block8687;

  block9095:
    // ----- load field  ----- WindowsCard.ssc(155,3)
    assert this != null;
    stack0i := $Heap[this, RTE.MStackBase];
    // ----- load constant 4  ----- WindowsCard.ssc(155,3)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(155,3)
    assert stack1i != 0;
    stack0i := stack0i mod stack1i;
    // ----- load constant 0  ----- WindowsCard.ssc(155,3)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(155,3)
    // ----- branch  ----- WindowsCard.ssc(155,3)
    goto true9095to8585, false9095to9061;

  block8687:
    // ----- copy  ----- WindowsCard.ssc(154,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(154,3)
    // ----- branch  ----- WindowsCard.ssc(154,3)
    goto true8687to8228, false8687to8772;

  true8789to9214:
    assume !stack0b;
    goto block9214;

  false8789to9112:
    assume stack0b;
    goto block9112;

  block9214:
    // ----- load constant 0  ----- WindowsCard.ssc(154,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(154,3)
    goto block8517;

  block9112:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(154,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(154,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(154,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(154,3)
    assert stack0o != null;
    assume false;
    return;

  true8687to8228:
    assume !stack0b;
    goto block8228;

  false8687to8772:
    assume stack0b;
    goto block8772;

  block8228:
    // ----- load constant 0  ----- WindowsCard.ssc(155,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(155,3)
    goto block8517;

  block8772:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(155,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(155,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(155,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(155,3)
    assert stack0o != null;
    assume false;
    return;

  true9095to8585:
    assume stack0i == stack1i;
    goto block8585;

  false9095to9061:
    assume stack0i != stack1i;
    goto block9061;

  block8585:
    // ----- load field  ----- WindowsCard.ssc(156,3)
    assert this != null;
    stack0i := $Heap[this, RTE.MStackMaxSize];
    // ----- load constant 4  ----- WindowsCard.ssc(156,3)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(156,3)
    assert stack1i != 0;
    stack0i := stack0i mod stack1i;
    // ----- load constant 0  ----- WindowsCard.ssc(156,3)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(156,3)
    // ----- branch  ----- WindowsCard.ssc(156,3)
    goto true8585to8891, false8585to8262;

  block9061:
    // ----- copy  ----- WindowsCard.ssc(155,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(155,3)
    // ----- branch  ----- WindowsCard.ssc(155,3)
    goto true9061to8398, false9061to8551;

  true8585to8891:
    assume stack0i == stack1i;
    goto block8891;

  false8585to8262:
    assume stack0i != stack1i;
    goto block8262;

  block8891:
    // ----- load field  ----- WindowsCard.ssc(157,3)
    assert this != null;
    stack0i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(157,3)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(157,3)
    stack0i := stack0i + stack1i;
    // ----- load field  ----- WindowsCard.ssc(157,3)
    assert this != null;
    stack1o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(157,3)
    assert stack1o != null;
    stack1o := $Heap[stack1o, Memory.contents];
    // ----- unary operator  ----- WindowsCard.ssc(157,3)
    assert stack1o != null;
    stack1i := $Length(stack1o);
    // ----- unary operator  ----- WindowsCard.ssc(157,3)
    stack1i := $IntToInt(stack1i, System.UIntPtr, System.Int32);
    // ----- binary operator  ----- WindowsCard.ssc(157,3)
    // ----- branch  ----- WindowsCard.ssc(157,3)
    goto true8891to8330, false8891to8636;

  block8262:
    // ----- copy  ----- WindowsCard.ssc(156,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(156,3)
    // ----- branch  ----- WindowsCard.ssc(156,3)
    goto true8262to9078, false8262to8432;

  true9061to8398:
    assume !stack0b;
    goto block8398;

  false9061to8551:
    assume stack0b;
    goto block8551;

  block8398:
    // ----- load constant 0  ----- WindowsCard.ssc(156,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(156,3)
    goto block8517;

  block8551:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(156,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(156,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(156,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(156,3)
    assert stack0o != null;
    assume false;
    return;

  true8891to8330:
    assume stack0i <= stack1i;
    goto block8330;

  false8891to8636:
    assume stack0i > stack1i;
    goto block8636;

  block8330:
    // ----- load constant 0  ----- WindowsCard.ssc(158,3)
    stack0i := 0;
    // ----- load field  ----- WindowsCard.ssc(158,3)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(158,3)
    // ----- branch  ----- WindowsCard.ssc(158,3)
    goto true8330to8466, false8330to8415;

  block8636:
    // ----- copy  ----- WindowsCard.ssc(157,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(157,3)
    // ----- branch  ----- WindowsCard.ssc(157,3)
    goto true8636to9044, false8636to8381;

  true8262to9078:
    assume !stack0b;
    goto block9078;

  false8262to8432:
    assume stack0b;
    goto block8432;

  block9078:
    // ----- load constant 0  ----- WindowsCard.ssc(157,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(157,3)
    goto block8517;

  block8432:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(157,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(157,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(157,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(157,3)
    assert stack0o != null;
    assume false;
    return;

  true8330to8466:
    assume stack0i <= stack1i;
    goto block8466;

  false8330to8415:
    assume stack0i > stack1i;
    goto block8415;

  block8466:
    // ----- load constant 0  ----- WindowsCard.ssc(159,3)
    stack0i := 0;
    // ----- load field  ----- WindowsCard.ssc(159,3)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(159,3)
    // ----- branch  ----- WindowsCard.ssc(159,3)
    goto true8466to8857, false8466to9163;

  block8415:
    // ----- copy  ----- WindowsCard.ssc(158,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(158,3)
    // ----- branch  ----- WindowsCard.ssc(158,3)
    goto true8415to9197, false8415to8670;

  true8636to9044:
    assume !stack0b;
    goto block9044;

  false8636to8381:
    assume stack0b;
    goto block8381;

  block9044:
    // ----- load constant 0  ----- WindowsCard.ssc(158,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(158,3)
    goto block8517;

  block8381:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(158,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(158,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(158,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(158,3)
    assert stack0o != null;
    assume false;
    return;

  true8415to9197:
    assume !stack0b;
    goto block9197;

  false8415to8670:
    assume stack0b;
    goto block8670;

  block9197:
    // ----- load constant 0  ----- WindowsCard.ssc(159,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(159,3)
    goto block8517;

  block8670:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(159,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(159,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(159,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(159,3)
    assert stack0o != null;
    assume false;
    return;

  true8466to8857:
    assume stack0i <= stack1i;
    goto block8857;

  false8466to9163:
    assume stack0i > stack1i;
    goto block9163;

  block8857:
    // ----- load field  ----- WindowsCard.ssc(160,3)
    assert this != null;
    stack0i := $Heap[this, RTE.DPP];
    // ----- load field  ----- WindowsCard.ssc(160,3)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(160,3)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(160,3)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(160,3)
    // ----- branch  ----- WindowsCard.ssc(160,3)
    goto true8857to8245, false8857to8449;

  block9163:
    // ----- copy  ----- WindowsCard.ssc(159,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(159,3)
    // ----- branch  ----- WindowsCard.ssc(159,3)
    goto true9163to8738, false9163to9027;

  true9163to8738:
    assume !stack0b;
    goto block8738;

  false9163to9027:
    assume stack0b;
    goto block9027;

  block8738:
    // ----- load constant 0  ----- WindowsCard.ssc(160,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(160,3)
    goto block8517;

  block9027:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(160,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(160,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(160,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(160,3)
    assert stack0o != null;
    assume false;
    return;

  true8857to8245:
    assume stack0i == stack1i;
    goto block8245;

  false8857to8449:
    assume stack0i != stack1i;
    goto block8449;

  block8245:
    // ----- load constant 1  ----- WindowsCard.ssc(163,3)
    return.value := true;
    // ----- branch  ----- WindowsCard.ssc(163,3)
    goto block8517;

  block8449:
    // ----- copy  ----- WindowsCard.ssc(160,3)
    stack0b := throwException;
    // ----- unary operator  ----- WindowsCard.ssc(160,3)
    // ----- branch  ----- WindowsCard.ssc(160,3)
    goto true8449to8568, false8449to8806;

  true8449to8568:
    assume !stack0b;
    goto block8568;

  false8449to8806:
    assume stack0b;
    goto block8806;

  block8568:
    // ----- load constant 0  ----- WindowsCard.ssc(163,3)
    return.value := false;
    // ----- branch  ----- WindowsCard.ssc(163,3)
    goto block8517;

  block8806:
    assume false;
    // ----- new object  ----- WindowsCard.ssc(163,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Microsoft.Contracts.ObjectInvariantException;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(163,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true);
    call Microsoft.Contracts.ObjectInvariantException..ctor(stack50000o);
    // ----- copy  ----- WindowsCard.ssc(163,3)
    stack0o := stack50000o;
    // ----- throw  ----- WindowsCard.ssc(163,3)
    assert stack0o != null;
    assume false;
    return;
}



axiom Microsoft.Contracts.ObjectInvariantException <: Microsoft.Contracts.ObjectInvariantException;

axiom Microsoft.Contracts.GuardException <: Microsoft.Contracts.GuardException;

axiom System.Exception <: System.Exception;

axiom $BaseClass(System.Exception) == System.Object && AsDirectSubClass(System.Exception, $BaseClass(System.Exception)) == System.Exception;

axiom !$IsImmutable(System.Exception) && $AsMutable(System.Exception) == System.Exception;

axiom System.Runtime.Serialization.ISerializable <: System.Runtime.Serialization.ISerializable;

axiom $IsMemberlessType(System.Runtime.Serialization.ISerializable);

axiom $AsInterface(System.Runtime.Serialization.ISerializable) == System.Runtime.Serialization.ISerializable;

axiom System.Exception <: System.Runtime.Serialization.ISerializable;

axiom System.Runtime.InteropServices._Exception <: System.Runtime.InteropServices._Exception;

axiom $IsMemberlessType(System.Runtime.InteropServices._Exception);

axiom $AsInterface(System.Runtime.InteropServices._Exception) == System.Runtime.InteropServices._Exception;

axiom System.Exception <: System.Runtime.InteropServices._Exception;

// System.Exception object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: System.Exception } IsHeap($h) && $h[$oi, $inv] <: System.Exception && $h[$oi, $localinv] != $BaseClass(System.Exception) ==> true);

axiom $BaseClass(Microsoft.Contracts.GuardException) == System.Exception && AsDirectSubClass(Microsoft.Contracts.GuardException, $BaseClass(Microsoft.Contracts.GuardException)) == Microsoft.Contracts.GuardException;

axiom !$IsImmutable(Microsoft.Contracts.GuardException) && $AsMutable(Microsoft.Contracts.GuardException) == Microsoft.Contracts.GuardException;

// Microsoft.Contracts.GuardException object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: Microsoft.Contracts.GuardException } IsHeap($h) && $h[$oi, $inv] <: Microsoft.Contracts.GuardException && $h[$oi, $localinv] != $BaseClass(Microsoft.Contracts.GuardException) ==> true);

axiom $BaseClass(Microsoft.Contracts.ObjectInvariantException) == Microsoft.Contracts.GuardException && AsDirectSubClass(Microsoft.Contracts.ObjectInvariantException, $BaseClass(Microsoft.Contracts.ObjectInvariantException)) == Microsoft.Contracts.ObjectInvariantException;

axiom !$IsImmutable(Microsoft.Contracts.ObjectInvariantException) && $AsMutable(Microsoft.Contracts.ObjectInvariantException) == Microsoft.Contracts.ObjectInvariantException;

// Microsoft.Contracts.ObjectInvariantException object invariant
axiom (forall $oi: ref, $h: HeapType :: { $h[$oi, $inv] <: Microsoft.Contracts.ObjectInvariantException } IsHeap($h) && $h[$oi, $inv] <: Microsoft.Contracts.ObjectInvariantException && $h[$oi, $localinv] != $BaseClass(Microsoft.Contracts.ObjectInvariantException) ==> true);

procedure Microsoft.Contracts.ObjectInvariantException..ctor(this: ref where $IsNotNull(this, Microsoft.Contracts.ObjectInvariantException) && $Heap[this, $allocated]);
  // object is fully unpacked:  this.inv == Object
  free requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  // nothing is owned by [this,*] and 'this' is alone in its own peer group
  free requires (forall $o: ref :: $o != this ==> $Heap[$o, $ownerRef] != this) && $Heap[this, $ownerRef] == this && $Heap[this, $ownerFrame] == $PeerGroupPlaceholder;
  free requires $BeingConstructed == this;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // target object is allocated upon return
  free ensures $Heap[this, $allocated];
  // target object is additively exposable for Microsoft.Contracts.ObjectInvariantException
  ensures ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == Microsoft.Contracts.ObjectInvariantException && $Heap[this, $localinv] == $typeof(this);
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(Microsoft.Contracts.ObjectInvariantException <: DeclType($f))) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] && $o != this ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



procedure RTE..ctor$System.Int32.array$notnull$System.Int32$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], input$in: ref where $IsNotNull(input$in, IntArray(System.Int32, 1)) && $Heap[input$in, $allocated], baseAddress$in: int where InRange(baseAddress$in, System.Int32), size$in: int where InRange(size$in, System.Int32));
  // object is fully unpacked:  this.inv == Object
  free requires ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == System.Object && $Heap[this, $localinv] == $typeof(this);
  // user-declared preconditions
  requires 0 <= baseAddress$in;
  requires baseAddress$in mod 4 == 0;
  requires 0 <= size$in;
  requires size$in mod 4 == 0;
  requires baseAddress$in + size$in <= 254;
  // input is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[input$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[input$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // input is peer consistent (owner must not be valid)
  requires $Heap[input$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[input$in, $ownerRef], $inv] <: $Heap[input$in, $ownerFrame]) || $Heap[$Heap[input$in, $ownerRef], $localinv] == $BaseClass($Heap[input$in, $ownerFrame]);
  // nothing is owned by [this,*] and 'this' is alone in its own peer group
  free requires (forall $o: ref :: $o != this ==> $Heap[$o, $ownerRef] != this) && $Heap[this, $ownerRef] == this && $Heap[this, $ownerFrame] == $PeerGroupPlaceholder;
  free requires $BeingConstructed == this;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // target object is allocated upon return
  free ensures $Heap[this, $allocated];
  // target object is additively exposable for RTE
  ensures ($Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame])) && $Heap[this, $inv] == RTE && $Heap[this, $localinv] == $typeof(this);
  ensures $Heap[this, $ownerRef] == old($Heap)[this, $ownerRef] && $Heap[this, $ownerFrame] == old($Heap)[this, $ownerFrame];
  ensures $Heap[this, $sharingMode] == $SharingMode_Unshared;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] && $o != this ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } $o == this || old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE..ctor$System.Int32.array$notnull$System.Int32$System.Int32(this: ref, input$in: ref, baseAddress$in: int, size$in: int)
{
  var input: ref where $IsNotNull(input, IntArray(System.Int32, 1)) && $Heap[input, $allocated];
  var baseAddress: int where InRange(baseAddress, System.Int32);
  var size: int where InRange(size, System.Int32);
  var stack0i: int;
  var temp0: exposeVersionType;
  var stack0b: bool;
  var temp1: exposeVersionType;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var temp4: exposeVersionType;
  var temp5: exposeVersionType;
  var stack50000o: ref;
  var stack0o: ref;
  var temp6: exposeVersionType;
  var temp7: exposeVersionType;
  var temp8: exposeVersionType;
  var temp9: exposeVersionType;
  var temp10: exposeVersionType;
  var temp11: exposeVersionType;
  var temp12: exposeVersionType;
  var temp13: exposeVersionType;
  var n: int where InRange(n, System.Int32);
  var instrs: ref where $Is(instrs, IntArray(System.Int32, 1)) && $Heap[instrs, $allocated];
  var temp14: ref;
  var temp15: exposeVersionType;
  var stack1i: int;
  var stack2o: ref;
  var stack3i: int;
  var stack4i: int;
  var temp16: ref;
  var temp17: exposeVersionType;
  var temp18: ref;

  entry:
    input := input$in;
    baseAddress := baseAddress$in;
    size := size$in;
    assume $Heap[this, RTE.A] == 0;
    assume $Heap[this, RTE.Z] == false;
    assume $Heap[this, RTE.C] == false;
    assume $Heap[this, RTE.PC] == 0;
    assume $Heap[this, RTE.CurrRTEMode] == 0;
    assume $Heap[this, RTE.RtnCode] == 0;
    assume $Heap[this, RTE.CSP] == 0;
    assume $Heap[this, RTE.MSP] == 0;
    assume $Heap[this, RTE.DPP] == 0;
    goto block12818;

  block12818:
    goto block13005;

  block13005:
    // ----- nop  ----- WindowsCard.ssc(172,5)
    // ----- load constant 0  ----- WindowsCard.ssc(126,3)
    stack0i := 0;
    // ----- store field  ----- WindowsCard.ssc(126,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp0;
    $Heap[this, $exposeVersion] := temp0;
    // ----- frame condition  ----- WindowsCard.ssc(126,3)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.A))) && true && true);
    $Heap[this, RTE.A] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 0  ----- WindowsCard.ssc(127,3)
    stack0b := false;
    // ----- store field  ----- WindowsCard.ssc(127,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp1;
    $Heap[this, $exposeVersion] := temp1;
    // ----- frame condition  ----- WindowsCard.ssc(127,3)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.Z))) && true && true);
    $Heap[this, RTE.Z] := stack0b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 0  ----- WindowsCard.ssc(128,3)
    stack0b := false;
    // ----- store field  ----- WindowsCard.ssc(128,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(128,3)
    assert !(IncludeInMainFrameCondition(RTE.C) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.C))) && true && true);
    $Heap[this, RTE.C] := stack0b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 0  ----- WindowsCard.ssc(130,3)
    stack0i := 0;
    // ----- store field  ----- WindowsCard.ssc(130,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(130,3)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.PC))) && true && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 10  ----- WindowsCard.ssc(132,3)
    stack0i := 10;
    // ----- store field  ----- WindowsCard.ssc(132,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp4;
    $Heap[this, $exposeVersion] := temp4;
    // ----- frame condition  ----- WindowsCard.ssc(132,3)
    assert !(IncludeInMainFrameCondition(RTE.CurrRTEMode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.CurrRTEMode))) && true && true);
    $Heap[this, RTE.CurrRTEMode] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 0  ----- WindowsCard.ssc(133,3)
    stack0i := 0;
    // ----- store field  ----- WindowsCard.ssc(133,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp5;
    $Heap[this, $exposeVersion] := temp5;
    // ----- frame condition  ----- WindowsCard.ssc(133,3)
    assert !(IncludeInMainFrameCondition(RTE.RtnCode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.RtnCode))) && true && true);
    $Heap[this, RTE.RtnCode] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 65536  ----- WindowsCard.ssc(135,3)
    stack0i := 65536;
    // ----- new object  ----- WindowsCard.ssc(135,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Memory;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(135,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Memory <: DeclType($f))) && true && true);
    call Memory..ctor$System.Int32(stack50000o, stack0i);
    // ----- copy  ----- WindowsCard.ssc(135,3)
    stack0o := stack50000o;
    // ----- store field  ----- WindowsCard.ssc(135,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    assert ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[stack0o, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[stack0o, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> $Heap[this, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[this, $ownerFrame] != $Heap[stack0o, $ownerFrame];
    assert stack0o == null || ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> !($f == $ownerRef || $f == $ownerFrame) || $Heap[$o, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[$o, $ownerFrame] != $Heap[stack0o, $ownerFrame]);
    call $UpdateOwnersForRep(this, RTE, stack0o);
    havoc temp6;
    $Heap[this, $exposeVersion] := temp6;
    // ----- frame condition  ----- WindowsCard.ssc(135,3)
    assert !(IncludeInMainFrameCondition(RTE.Program) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.Program))) && true && true);
    $Heap[this, RTE.Program] := stack0o;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 65536  ----- WindowsCard.ssc(137,3)
    stack0i := 65536;
    // ----- new object  ----- WindowsCard.ssc(137,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Memory;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(137,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Memory <: DeclType($f))) && true && true);
    call Memory..ctor$System.Int32(stack50000o, stack0i);
    // ----- copy  ----- WindowsCard.ssc(137,3)
    stack0o := stack50000o;
    // ----- store field  ----- WindowsCard.ssc(137,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    assert ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[stack0o, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[stack0o, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> $Heap[this, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[this, $ownerFrame] != $Heap[stack0o, $ownerFrame];
    assert stack0o == null || ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> !($f == $ownerRef || $f == $ownerFrame) || $Heap[$o, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[$o, $ownerFrame] != $Heap[stack0o, $ownerFrame]);
    call $UpdateOwnersForRep(this, RTE, stack0o);
    havoc temp7;
    $Heap[this, $exposeVersion] := temp7;
    // ----- frame condition  ----- WindowsCard.ssc(137,3)
    assert !(IncludeInMainFrameCondition(RTE.Data) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.Data))) && true && true);
    $Heap[this, RTE.Data] := stack0o;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 65536 == $Length($Heap[$Heap[this, RTE.Data], Memory.contents]);
    assume IsHeap($Heap);
    // ----- load constant 256  ----- WindowsCard.ssc(139,3)
    stack0i := 256;
    // ----- new object  ----- WindowsCard.ssc(139,3)
    havoc stack50000o;
    assume $Heap[stack50000o, $allocated] == false && stack50000o != null && $typeof(stack50000o) == Memory;
    assume $Heap[stack50000o, $ownerRef] == stack50000o && $Heap[stack50000o, $ownerFrame] == $PeerGroupPlaceholder;
    // ----- call  ----- WindowsCard.ssc(139,3)
    assert stack50000o != null;
    assume $Utter($Heap[stack50000o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack50000o || !(Memory <: DeclType($f))) && true && true);
    call Memory..ctor$System.Int32(stack50000o, stack0i);
    // ----- copy  ----- WindowsCard.ssc(139,3)
    stack0o := stack50000o;
    // ----- store field  ----- WindowsCard.ssc(139,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    assert ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[stack0o, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[stack0o, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> $Heap[this, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[this, $ownerFrame] != $Heap[stack0o, $ownerFrame];
    assert stack0o == null || ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> !($f == $ownerRef || $f == $ownerFrame) || $Heap[$o, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[$o, $ownerFrame] != $Heap[stack0o, $ownerFrame]);
    call $UpdateOwnersForRep(this, RTE, stack0o);
    havoc temp8;
    $Heap[this, $exposeVersion] := temp8;
    // ----- frame condition  ----- WindowsCard.ssc(139,3)
    assert !(IncludeInMainFrameCondition(RTE.Scratch) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.Scratch))) && true && true);
    $Heap[this, RTE.Scratch] := stack0o;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize] <= $Length($Heap[$Heap[this, RTE.Scratch], Memory.contents]);
    assume IsHeap($Heap);
    // ----- load constant 0  ----- WindowsCard.ssc(144,3)
    stack0i := 0;
    // ----- store field  ----- WindowsCard.ssc(144,3)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp9;
    $Heap[this, $exposeVersion] := temp9;
    // ----- frame condition  ----- WindowsCard.ssc(144,3)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.CSP))) && true && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- store field  ----- WindowsCard.ssc(174,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp10;
    $Heap[this, $exposeVersion] := temp10;
    assume $Heap[this, RTE.MStackBase] == baseAddress;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] mod 4 == 0;
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize] <= $Length($Heap[$Heap[this, RTE.Scratch], Memory.contents]);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.MStackBase];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.DPP] == $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assume IsHeap($Heap);
    // ----- store field  ----- WindowsCard.ssc(175,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp11;
    $Heap[this, $exposeVersion] := temp11;
    assume $Heap[this, RTE.MStackMaxSize] == size;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackMaxSize] mod 4 == 0;
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize] <= $Length($Heap[$Heap[this, RTE.Scratch], Memory.contents]);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.DPP] == $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assume IsHeap($Heap);
    // ----- store field  ----- WindowsCard.ssc(176,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp12;
    $Heap[this, $exposeVersion] := temp12;
    // ----- frame condition  ----- WindowsCard.ssc(176,5)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.MSP))) && true && true);
    $Heap[this, RTE.MSP] := baseAddress;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- binary operator  ----- WindowsCard.ssc(178,5)
    stack0i := baseAddress + size;
    // ----- store field  ----- WindowsCard.ssc(178,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp13;
    $Heap[this, $exposeVersion] := temp13;
    // ----- frame condition  ----- WindowsCard.ssc(178,5)
    assert !(IncludeInMainFrameCondition(RTE.DPP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.DPP))) && true && true);
    $Heap[this, RTE.DPP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.DPP] == $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assume IsHeap($Heap);
    // ----- copy  ----- WindowsCard.ssc(180,9)
    stack0o := input;
    // ----- unary operator  ----- WindowsCard.ssc(180,9)
    assert stack0o != null;
    stack0i := $Length(stack0o);
    // ----- unary operator  ----- WindowsCard.ssc(180,9)
    stack0i := $IntToInt(stack0i, System.UIntPtr, System.Int32);
    // ----- copy  ----- WindowsCard.ssc(180,9)
    n := stack0i;
    // ----- copy  ----- WindowsCard.ssc(181,11)
    stack0i := n;
    // ----- new array  ----- WindowsCard.ssc(181,11)
    assert 0 <= stack0i;
    havoc temp14;
    assume $Heap[temp14, $allocated] == false && $Length(temp14) == stack0i;
    assume $Heap[$ElementProxy(temp14, -1), $allocated] == false && $ElementProxy(temp14, -1) != temp14 && $ElementProxy(temp14, -1) != null;
    assume temp14 != null;
    assume $typeof(temp14) == IntArray(System.Int32, 1);
    assume $Heap[temp14, $ownerRef] == temp14 && $Heap[temp14, $ownerFrame] == $PeerGroupPlaceholder;
    assume $Heap[$ElementProxy(temp14, -1), $ownerRef] == $ElementProxy(temp14, -1) && $Heap[$ElementProxy(temp14, -1), $ownerFrame] == $PeerGroupPlaceholder;
    assume $Heap[temp14, $inv] == $typeof(temp14) && $Heap[temp14, $localinv] == $typeof(temp14);
    assume (forall $i: int :: ArrayGet($Heap[temp14, $elementsInt], $i) == 0);
    $Heap[temp14, $allocated] := true;
    call System.Object..ctor($ElementProxy(temp14, -1));
    instrs := temp14;
    assume IsHeap($Heap);
    // ----- store field  ----- WindowsCard.ssc(182,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    assert ($Heap[instrs, $ownerRef] == this && $Heap[instrs, $ownerFrame] == RTE) || $Heap[instrs, $ownerFrame] == $PeerGroupPlaceholder;
    assert $Heap[instrs, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[instrs, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[instrs, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    assert $Heap[instrs, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> $Heap[this, $ownerRef] != $Heap[instrs, $ownerRef] || $Heap[this, $ownerFrame] != $Heap[instrs, $ownerFrame];
    assert instrs == null || ($Heap[instrs, $ownerRef] == this && $Heap[instrs, $ownerFrame] == RTE) || (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> !($f == $ownerRef || $f == $ownerFrame) || $Heap[$o, $ownerRef] != $Heap[instrs, $ownerRef] || $Heap[$o, $ownerFrame] != $Heap[instrs, $ownerFrame]);
    call $UpdateOwnersForRep(this, RTE, instrs);
    havoc temp15;
    $Heap[this, $exposeVersion] := temp15;
    // ----- frame condition  ----- WindowsCard.ssc(182,5)
    assert !(IncludeInMainFrameCondition(RTE.Instructions) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.Instructions))) && true && true);
    $Heap[this, RTE.Instructions] := instrs;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- copy  ----- WindowsCard.ssc(183,5)
    stack0o := input;
    // ----- load constant 0  ----- WindowsCard.ssc(183,5)
    stack1i := 0;
    // ----- copy  ----- WindowsCard.ssc(183,5)
    stack2o := instrs;
    // ----- load constant 0  ----- WindowsCard.ssc(183,5)
    stack3i := 0;
    // ----- copy  ----- WindowsCard.ssc(183,5)
    stack4i := n;
    // ----- call  ----- WindowsCard.ssc(183,5)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack2o || !($typeof(stack2o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack2o || $f != $exposeVersion));
    call System.Array.Copy$System.Array$notnull$System.Int32$System.Array$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2o, stack3i, stack4i);
    // ----- load constant 10  ----- WindowsCard.ssc(185,5)
    stack0i := 10;
    // ----- new array  ----- WindowsCard.ssc(185,5)
    assert 0 <= stack0i;
    havoc temp16;
    assume $Heap[temp16, $allocated] == false && $Length(temp16) == stack0i;
    assume $Heap[$ElementProxy(temp16, -1), $allocated] == false && $ElementProxy(temp16, -1) != temp16 && $ElementProxy(temp16, -1) != null;
    assume temp16 != null;
    assume $typeof(temp16) == IntArray(System.Int32, 1);
    assume $Heap[temp16, $ownerRef] == temp16 && $Heap[temp16, $ownerFrame] == $PeerGroupPlaceholder;
    assume $Heap[$ElementProxy(temp16, -1), $ownerRef] == $ElementProxy(temp16, -1) && $Heap[$ElementProxy(temp16, -1), $ownerFrame] == $PeerGroupPlaceholder;
    assume $Heap[temp16, $inv] == $typeof(temp16) && $Heap[temp16, $localinv] == $typeof(temp16);
    assume (forall $i: int :: ArrayGet($Heap[temp16, $elementsInt], $i) == 0);
    $Heap[temp16, $allocated] := true;
    call System.Object..ctor($ElementProxy(temp16, -1));
    stack0o := temp16;
    assume IsHeap($Heap);
    // ----- store field  ----- WindowsCard.ssc(185,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    assert ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[stack0o, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[stack0o, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder && $Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE) ==> $Heap[this, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[this, $ownerFrame] != $Heap[stack0o, $ownerFrame];
    assert stack0o == null || ($Heap[stack0o, $ownerRef] == this && $Heap[stack0o, $ownerFrame] == RTE) || (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> !($f == $ownerRef || $f == $ownerFrame) || $Heap[$o, $ownerRef] != $Heap[stack0o, $ownerRef] || $Heap[$o, $ownerFrame] != $Heap[stack0o, $ownerFrame]);
    call $UpdateOwnersForRep(this, RTE, stack0o);
    havoc temp17;
    $Heap[this, $exposeVersion] := temp17;
    // ----- frame condition  ----- WindowsCard.ssc(185,5)
    assert !(IncludeInMainFrameCondition(RTE.CallStack) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != this || !(RTE <: DeclType(RTE.CallStack))) && true && true);
    $Heap[this, RTE.CallStack] := stack0o;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Length($Heap[this, RTE.CallStack]) == 10;
    assume IsHeap($Heap);
    // ----- call  ----- WindowsCard.ssc(187,5)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != this || !(RTE <: DeclType($f))) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || !(System.Object <: DeclType($f))) && true && true);
    call System.Object..ctor(this);
    goto block12869;

  block12869:
    // ----- FrameGuard processing  ----- WindowsCard.ssc(188,3)
    temp18 := this;
    // ----- classic pack  ----- WindowsCard.ssc(188,3)
    assert temp18 != null;
    assert $Heap[temp18, $inv] == System.Object && $Heap[temp18, $localinv] == $typeof(temp18);
    assert 65536 == $Length($Heap[$Heap[temp18, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp18, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp18, RTE.CSP];
    assert $Heap[temp18, RTE.CSP] <= 10;
    assert $Heap[temp18, RTE.MStackBase] <= $Heap[temp18, RTE.MSP];
    assert $Heap[temp18, RTE.MSP] <= $Heap[temp18, RTE.MStackBase] + $Heap[temp18, RTE.MStackMaxSize];
    assert $Heap[temp18, RTE.MSP] mod 4 == 0;
    assert $Heap[temp18, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp18, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp18, RTE.MStackBase] + $Heap[temp18, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp18, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp18, RTE.MStackBase];
    assert 0 <= $Heap[temp18, RTE.MStackMaxSize];
    assert $Heap[temp18, RTE.DPP] == $Heap[temp18, RTE.MStackBase] + $Heap[temp18, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp18 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp18, $inv] := RTE;
    assume IsHeap($Heap);
    // ----- return  ----- WindowsCard.ssc(188,3)
    return;
}



procedure System.Array.Copy$System.Array$notnull$System.Int32$System.Array$notnull$System.Int32$System.Int32(sourceArray$in: ref where $IsNotNull(sourceArray$in, System.Array) && $Heap[sourceArray$in, $allocated], sourceIndex$in: int where InRange(sourceIndex$in, System.Int32), destinationArray$in: ref where $IsNotNull(destinationArray$in, System.Array) && $Heap[destinationArray$in, $allocated], destinationIndex$in: int where InRange(destinationIndex$in, System.Int32), length$in: int where InRange(length$in, System.Int32));
  // user-declared preconditions
  requires sourceArray$in != null;
  requires destinationArray$in != null;
  requires $Rank(sourceArray$in) == $Rank(destinationArray$in);
  requires sourceIndex$in >= $LBound(sourceArray$in, 0);
  requires destinationIndex$in >= $LBound(destinationArray$in, 0);
  requires length$in >= 0;
  requires sourceIndex$in + length$in <= $LBound(sourceArray$in, 0) + $Length(sourceArray$in);
  requires destinationIndex$in + length$in <= $LBound(destinationArray$in, 0) + $Length(destinationArray$in);
  // sourceArray is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[sourceArray$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[sourceArray$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // sourceArray is peer consistent (owner must not be valid)
  requires $Heap[sourceArray$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[sourceArray$in, $ownerRef], $inv] <: $Heap[sourceArray$in, $ownerFrame]) || $Heap[$Heap[sourceArray$in, $ownerRef], $localinv] == $BaseClass($Heap[sourceArray$in, $ownerFrame]);
  // destinationArray is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[destinationArray$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[destinationArray$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // destinationArray is peer consistent (owner must not be valid)
  requires $Heap[destinationArray$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[destinationArray$in, $ownerRef], $inv] <: $Heap[destinationArray$in, $ownerFrame]) || $Heap[$Heap[destinationArray$in, $ownerRef], $localinv] == $BaseClass($Heap[destinationArray$in, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // hard-coded postcondition
  ensures (forall $k: int :: { ArrayGet($Heap[destinationArray$in, $elementsBool], $k) } (destinationIndex$in <= $k && $k < destinationIndex$in + length$in ==> old(ArrayGet($Heap[sourceArray$in, $elementsBool], $k + sourceIndex$in - destinationIndex$in)) == ArrayGet($Heap[destinationArray$in, $elementsBool], $k)) && (!(destinationIndex$in <= $k && $k < destinationIndex$in + length$in) ==> old(ArrayGet($Heap[destinationArray$in, $elementsBool], $k)) == ArrayGet($Heap[destinationArray$in, $elementsBool], $k)));
  ensures (forall $k: int :: { ArrayGet($Heap[destinationArray$in, $elementsInt], $k) } (destinationIndex$in <= $k && $k < destinationIndex$in + length$in ==> old(ArrayGet($Heap[sourceArray$in, $elementsInt], $k + sourceIndex$in - destinationIndex$in)) == ArrayGet($Heap[destinationArray$in, $elementsInt], $k)) && (!(destinationIndex$in <= $k && $k < destinationIndex$in + length$in) ==> old(ArrayGet($Heap[destinationArray$in, $elementsInt], $k)) == ArrayGet($Heap[destinationArray$in, $elementsInt], $k)));
  ensures (forall $k: int :: { ArrayGet($Heap[destinationArray$in, $elementsRef], $k) } (destinationIndex$in <= $k && $k < destinationIndex$in + length$in ==> old(ArrayGet($Heap[sourceArray$in, $elementsRef], $k + sourceIndex$in - destinationIndex$in)) == ArrayGet($Heap[destinationArray$in, $elementsRef], $k)) && (!(destinationIndex$in <= $k && $k < destinationIndex$in + length$in) ==> old(ArrayGet($Heap[destinationArray$in, $elementsRef], $k)) == ArrayGet($Heap[destinationArray$in, $elementsRef], $k)));
//  ensures (forall $k: int :: { ArrayGet($Heap[destinationArray$in, $elementsReal], $k) } (destinationIndex$in <= $k && $k < destinationIndex$in + length$in ==> old(ArrayGet($Heap[sourceArray$in, $elementsReal], $k + sourceIndex$in - destinationIndex$in)) == ArrayGet($Heap[destinationArray$in, $elementsReal], $k)) && (!(destinationIndex$in <= $k && $k < destinationIndex$in + length$in) ==> old(ArrayGet($Heap[destinationArray$in, $elementsReal], $k)) == ArrayGet($Heap[destinationArray$in, $elementsReal], $k)));
  ensures (forall $k: int :: { ArrayGet($Heap[destinationArray$in, $elementsStruct], $k) } (destinationIndex$in <= $k && $k < destinationIndex$in + length$in ==> old(ArrayGet($Heap[sourceArray$in, $elementsStruct], $k + sourceIndex$in - destinationIndex$in)) == ArrayGet($Heap[destinationArray$in, $elementsStruct], $k)) && (!(destinationIndex$in <= $k && $k < destinationIndex$in + length$in) ==> old(ArrayGet($Heap[destinationArray$in, $elementsStruct], $k)) == ArrayGet($Heap[destinationArray$in, $elementsStruct], $k)));
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(destinationArray$in) || !($typeof(old(destinationArray$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(destinationArray$in) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



procedure RTE.apply$System.Int32$System.Int32$System.Int32(op$in: int where InRange(op$in, System.Int32), a$in: int where InRange(a$in, System.Int32), b$in: int where InRange(b$in, System.Int32)) returns ($result: int where InRange($result, System.Int32));
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.apply$System.Int32$System.Int32$System.Int32(op$in: int, a$in: int, b$in: int) returns ($result: int)
{
  var op: int where InRange(op, System.Int32);
  var a: int where InRange(a, System.Int32);
  var b: int where InRange(b, System.Int32);
  var local0: int where InRange(local0, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var return.value: int where InRange(return.value, System.Int32);
  var SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Int32);

  entry:
    op := op$in;
    a := a$in;
    b := b$in;
    goto block14416;

  block14416:
    goto block14484;

  block14484:
    // ----- copy  ----- WindowsCard.ssc(192,13)
    local0 := op;
    // ----- load constant 30  ----- WindowsCard.ssc(192,13)
    stack0i := 30;
    // ----- binary operator  ----- WindowsCard.ssc(192,13)
    // ----- branch  ----- WindowsCard.ssc(192,13)
    goto true14484to14450, false14484to14433;

  true14484to14450:
    assume local0 == stack0i;
    goto block14450;

  false14484to14433:
    assume local0 != stack0i;
    goto block14433;

  block14450:
    // ----- binary operator  ----- WindowsCard.ssc(193,17)
    stack0i := a + b;
    // ----- copy  ----- WindowsCard.ssc(193,17)
    return.value := stack0i;
    // ----- branch  ----- WindowsCard.ssc(193,17)
    goto block14535;

  block14433:
    // ----- load constant 31  ----- WindowsCard.ssc(192,13)
    stack0i := 31;
    // ----- binary operator  ----- WindowsCard.ssc(192,13)
    // ----- branch  ----- WindowsCard.ssc(192,13)
    goto true14433to14518, false14433to14467;

  true14433to14518:
    assume local0 == stack0i;
    goto block14518;

  false14433to14467:
    assume local0 != stack0i;
    goto block14467;

  block14518:
    // ----- binary operator  ----- WindowsCard.ssc(194,17)
    stack0i := a - b;
    // ----- copy  ----- WindowsCard.ssc(194,17)
    return.value := stack0i;
    // ----- branch  ----- WindowsCard.ssc(194,17)
    goto block14535;

  block14467:
    // ----- branch  ----- WindowsCard.ssc(192,13)
    goto block14501;

  block14535:
    // ----- copy  ----- WindowsCard.ssc(195,16)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(197,3)
    stack0i := return.value;
    // ----- return  ----- WindowsCard.ssc(197,3)
    $result := stack0i;
    return;

  block14501:
    // ----- load constant 0  ----- WindowsCard.ssc(195,16)
    return.value := 0;
    // ----- branch  ----- WindowsCard.ssc(195,16)
    goto block14535;
}



procedure RTE.ApplyQuad$System.Int32$System.Int32$System.Int32(op$in: int where InRange(op$in, System.Int32), a$in: int where InRange(a$in, System.Int32), b$in: int where InRange(b$in, System.Int32)) returns ($result: int where InRange($result, System.Int32));
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.ApplyQuad$System.Int32$System.Int32$System.Int32(op$in: int, a$in: int, b$in: int) returns ($result: int)
{
  var op: int where InRange(op, System.Int32);
  var a: int where InRange(a, System.Int32);
  var b: int where InRange(b, System.Int32);
  var local0: int where InRange(local0, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var return.value: int where InRange(return.value, System.Int32);
  var SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Int32);

  entry:
    op := op$in;
    a := a$in;
    b := b$in;
    goto block15028;

  block15028:
    goto block15096;

  block15096:
    // ----- copy  ----- WindowsCard.ssc(201,13)
    local0 := op;
    // ----- load constant 80  ----- WindowsCard.ssc(201,13)
    stack0i := 80;
    // ----- binary operator  ----- WindowsCard.ssc(201,13)
    // ----- branch  ----- WindowsCard.ssc(201,13)
    goto true15096to15113, false15096to15045;

  true15096to15113:
    assume local0 == stack0i;
    goto block15113;

  false15096to15045:
    assume local0 != stack0i;
    goto block15045;

  block15113:
    // ----- binary operator  ----- WindowsCard.ssc(202,18)
    stack0i := a + b;
    // ----- copy  ----- WindowsCard.ssc(202,18)
    return.value := stack0i;
    // ----- branch  ----- WindowsCard.ssc(202,18)
    goto block15147;

  block15045:
    // ----- load constant 81  ----- WindowsCard.ssc(201,13)
    stack0i := 81;
    // ----- binary operator  ----- WindowsCard.ssc(201,13)
    // ----- branch  ----- WindowsCard.ssc(201,13)
    goto true15045to15062, false15045to15130;

  true15045to15062:
    assume local0 == stack0i;
    goto block15062;

  false15045to15130:
    assume local0 != stack0i;
    goto block15130;

  block15062:
    // ----- binary operator  ----- WindowsCard.ssc(203,18)
    stack0i := a - b;
    // ----- copy  ----- WindowsCard.ssc(203,18)
    return.value := stack0i;
    // ----- branch  ----- WindowsCard.ssc(203,18)
    goto block15147;

  block15130:
    // ----- branch  ----- WindowsCard.ssc(201,13)
    goto block15079;

  block15147:
    // ----- copy  ----- WindowsCard.ssc(204,16)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(206,3)
    stack0i := return.value;
    // ----- return  ----- WindowsCard.ssc(206,3)
    $result := stack0i;
    return;

  block15079:
    // ----- load constant 0  ----- WindowsCard.ssc(204,16)
    return.value := 0;
    // ----- branch  ----- WindowsCard.ssc(204,16)
    goto block15147;
}



procedure RTE.carry$System.Int32$System.Int32$System.Int32(op$in: int where InRange(op$in, System.Int32), a$in: int where InRange(a$in, System.Int32), b$in: int where InRange(b$in, System.Int32)) returns ($result: bool where true);
  // user-declared preconditions
  requires op$in == 30 || op$in == 31;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.carry$System.Int32$System.Int32$System.Int32(op$in: int, a$in: int, b$in: int) returns ($result: bool)
{
  var op: int where InRange(op, System.Int32);
  var a: int where InRange(a, System.Int32);
  var b: int where InRange(b, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var stack1i: int;
  var return.value: bool where true;
  var SS$Display.Return.Local: bool where true;

  entry:
    op := op$in;
    a := a$in;
    b := b$in;
    goto block15844;

  block15844:
    goto block15878;

  block15878:
    // ----- nop  ----- WindowsCard.ssc(209,5)
    // ----- load constant 30  ----- WindowsCard.ssc(211,5)
    stack0i := 30;
    // ----- binary operator  ----- WindowsCard.ssc(211,5)
    // ----- branch  ----- WindowsCard.ssc(211,5)
    goto true15878to16116, false15878to15861;

  true15878to16116:
    assume op != stack0i;
    goto block16116;

  false15878to15861:
    assume op == stack0i;
    goto block15861;

  block16116:
    // ----- binary operator  ----- WindowsCard.ssc(214,7)
    stack0i := a - b;
    // ----- load constant 8  ----- WindowsCard.ssc(214,7)
    stack1i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(214,7)
    stack0i := #shr(stack0i, stack1i);
    // ----- load constant 2  ----- WindowsCard.ssc(214,7)
    stack1i := 2;
    // ----- binary operator  ----- WindowsCard.ssc(214,7)
    assert stack1i != 0;
    stack0i := stack0i mod stack1i;
    // ----- load constant 0  ----- WindowsCard.ssc(214,7)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(214,7)
    // ----- branch  ----- WindowsCard.ssc(214,7)
    goto true16116to15929, false16116to16150;

  block15861:
    // ----- binary operator  ----- WindowsCard.ssc(212,7)
    stack0i := a + b;
    // ----- load constant 8  ----- WindowsCard.ssc(212,7)
    stack1i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(212,7)
    stack0i := #shr(stack0i, stack1i);
    // ----- load constant 2  ----- WindowsCard.ssc(212,7)
    stack1i := 2;
    // ----- binary operator  ----- WindowsCard.ssc(212,7)
    assert stack1i != 0;
    stack0i := stack0i mod stack1i;
    // ----- load constant 0  ----- WindowsCard.ssc(212,7)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(212,7)
    // ----- branch  ----- WindowsCard.ssc(212,7)
    goto true15861to15895, false15861to16065;

  true16116to15929:
    assume stack0i != stack1i;
    goto block15929;

  false16116to16150:
    assume stack0i == stack1i;
    goto block16150;

  block15929:
    // ----- load constant 1  ----- WindowsCard.ssc(214,7)
    stack0b := true;
    goto block16048;

  block16150:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(214,7)
    goto block16048;

  true15861to15895:
    assume stack0i != stack1i;
    goto block15895;

  false15861to16065:
    assume stack0i == stack1i;
    goto block16065;

  block15895:
    // ----- load constant 1  ----- WindowsCard.ssc(212,7)
    stack0b := true;
    goto block15912;

  block16065:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(212,7)
    goto block15912;

  block16048:
    // ----- copy  ----- WindowsCard.ssc(214,7)
    return.value := stack0b;
    // ----- branch  ----- WindowsCard.ssc(214,7)
    goto block16014;

  block15912:
    // ----- copy  ----- WindowsCard.ssc(212,7)
    return.value := stack0b;
    // ----- branch  ----- WindowsCard.ssc(212,7)
    goto block16014;

  block16014:
    // ----- copy  ----- WindowsCard.ssc(216,3)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(216,3)
    stack0b := return.value;
    // ----- return  ----- WindowsCard.ssc(216,3)
    $result := stack0b;
    return;
}



procedure RTE.ReadQuad$Memory$notnull$System.Int32(m$in: ref where $IsNotNull(m$in, Memory) && $Heap[m$in, $allocated], addr$in: int where InRange(addr$in, System.Int32)) returns ($result: int where InRange($result, System.Int32));
  // user-declared preconditions
  requires 0 <= addr$in;
  requires addr$in <= $Length($Heap[m$in, Memory.contents]) - 4;
  // m is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[m$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[m$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // m is peer consistent (owner must not be valid)
  requires $Heap[m$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[m$in, $ownerRef], $inv] <: $Heap[m$in, $ownerFrame]) || $Heap[$Heap[m$in, $ownerRef], $localinv] == $BaseClass($Heap[m$in, $ownerFrame]);
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.ReadQuad$Memory$notnull$System.Int32(m$in: ref, addr$in: int) returns ($result: int)
{
  var m: ref where $IsNotNull(m, Memory) && $Heap[m, $allocated];
  var addr: int where InRange(addr, System.Int32);
  var stack0i: int;
  var stack1i: int;
  var stack2i: int;
  var return.value: int where InRange(return.value, System.Int32);
  var SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Int32);

  entry:
    m := m$in;
    addr := addr$in;
    goto block16983;

  block16983:
    goto block17102;

  block17102:
    // ----- nop  ----- WindowsCard.ssc(220,5)
    // ----- copy  ----- WindowsCard.ssc(222,5)
    stack0i := addr;
    // ----- call  ----- WindowsCard.ssc(222,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := Memory.get_cont$System.Int32(m, stack0i);
    // ----- load constant 12  ----- WindowsCard.ssc(222,5)
    stack1i := 12;
    // ----- load constant 1  ----- WindowsCard.ssc(222,5)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack2i := addr + stack2i;
    // ----- call  ----- WindowsCard.ssc(222,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := Memory.get_cont$System.Int32(m, stack2i);
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack0i := #shl(stack0i, stack1i);
    // ----- load constant 8  ----- WindowsCard.ssc(222,5)
    stack1i := 8;
    // ----- load constant 2  ----- WindowsCard.ssc(222,5)
    stack2i := 2;
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack2i := addr + stack2i;
    // ----- call  ----- WindowsCard.ssc(222,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := Memory.get_cont$System.Int32(m, stack2i);
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack0i := #shl(stack0i, stack1i);
    // ----- load constant 4  ----- WindowsCard.ssc(222,5)
    stack1i := 4;
    // ----- load constant 3  ----- WindowsCard.ssc(222,5)
    stack2i := 3;
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack2i := addr + stack2i;
    // ----- call  ----- WindowsCard.ssc(222,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := Memory.get_cont$System.Int32(m, stack2i);
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(222,5)
    stack0i := #shl(stack0i, stack1i);
    // ----- copy  ----- WindowsCard.ssc(222,5)
    return.value := stack0i;
    // ----- branch  ----- WindowsCard.ssc(222,5)
    goto block17000;

  block17000:
    // ----- copy  ----- WindowsCard.ssc(222,5)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(222,5)
    stack0i := return.value;
    // ----- return  ----- WindowsCard.ssc(222,5)
    $result := stack0i;
    return;
}



procedure RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(m$in: ref where $IsNotNull(m$in, Memory) && $Heap[m$in, $allocated], addr$in: int where InRange(addr$in, System.Int32), value$in: int where InRange(value$in, System.Int32));
  // user-declared preconditions
  requires 0 <= addr$in;
  requires addr$in <= $Length($Heap[m$in, Memory.contents]) - 4;
  // m is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[m$in, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[m$in, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // m is peer consistent (owner must not be valid)
  requires $Heap[m$in, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[m$in, $ownerRef], $inv] <: $Heap[m$in, $ownerFrame]) || $Heap[$Heap[m$in, $ownerRef], $localinv] == $BaseClass($Heap[m$in, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(m$in) || !($typeof(old(m$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(m$in) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(m$in: ref, addr$in: int, value$in: int)
{
  var m: ref where $IsNotNull(m, Memory) && $Heap[m, $allocated];
  var addr: int where InRange(addr, System.Int32);
  var value: int where InRange(value, System.Int32);
  var stack0i: int;
  var stack1i: int;
  var stack2i: int;

  entry:
    m := m$in;
    addr := addr$in;
    value := value$in;
    goto block17884;

  block17884:
    goto block18037;

  block18037:
    // ----- nop  ----- WindowsCard.ssc(227,5)
    // ----- copy  ----- WindowsCard.ssc(230,5)
    stack0i := addr;
    // ----- load constant 61440  ----- WindowsCard.ssc(230,5)
    stack1i := 61440;
    // ----- binary operator  ----- WindowsCard.ssc(230,5)
    stack1i := #and(value, stack1i);
    // ----- load constant 12  ----- WindowsCard.ssc(230,5)
    stack2i := 12;
    // ----- binary operator  ----- WindowsCard.ssc(230,5)
    stack1i := #shr(stack1i, stack2i);
    // ----- unary operator  ----- WindowsCard.ssc(230,5)
    stack1i := $IntToInt(stack1i, System.Int32, System.Byte);
    // ----- call  ----- WindowsCard.ssc(230,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(m$in) || !($typeof(old(m$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(m$in) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != m || !($typeof(m) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(m, stack0i, stack1i);
    // ----- load constant 1  ----- WindowsCard.ssc(231,5)
    stack0i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(231,5)
    stack0i := addr + stack0i;
    // ----- load constant 3840  ----- WindowsCard.ssc(231,5)
    stack1i := 3840;
    // ----- binary operator  ----- WindowsCard.ssc(231,5)
    stack1i := #and(value, stack1i);
    // ----- load constant 8  ----- WindowsCard.ssc(231,5)
    stack2i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(231,5)
    stack1i := #shr(stack1i, stack2i);
    // ----- unary operator  ----- WindowsCard.ssc(231,5)
    stack1i := $IntToInt(stack1i, System.Int32, System.Byte);
    // ----- call  ----- WindowsCard.ssc(231,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(m$in) || !($typeof(old(m$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(m$in) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != m || !($typeof(m) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(m, stack0i, stack1i);
    // ----- load constant 2  ----- WindowsCard.ssc(232,5)
    stack0i := 2;
    // ----- binary operator  ----- WindowsCard.ssc(232,5)
    stack0i := addr + stack0i;
    // ----- load constant 240  ----- WindowsCard.ssc(232,5)
    stack1i := 240;
    // ----- binary operator  ----- WindowsCard.ssc(232,5)
    stack1i := #and(value, stack1i);
    // ----- load constant 4  ----- WindowsCard.ssc(232,5)
    stack2i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(232,5)
    stack1i := #shr(stack1i, stack2i);
    // ----- unary operator  ----- WindowsCard.ssc(232,5)
    stack1i := $IntToInt(stack1i, System.Int32, System.Byte);
    // ----- call  ----- WindowsCard.ssc(232,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(m$in) || !($typeof(old(m$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(m$in) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != m || !($typeof(m) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(m, stack0i, stack1i);
    // ----- load constant 3  ----- WindowsCard.ssc(233,5)
    stack0i := 3;
    // ----- binary operator  ----- WindowsCard.ssc(233,5)
    stack0i := addr + stack0i;
    // ----- load constant 15  ----- WindowsCard.ssc(233,5)
    stack1i := 15;
    // ----- binary operator  ----- WindowsCard.ssc(233,5)
    stack1i := #and(value, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(233,5)
    stack1i := $IntToInt(stack1i, System.Int32, System.Byte);
    // ----- call  ----- WindowsCard.ssc(233,5)
    assert m != null;
    assume $Utter($Heap[m, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(m$in) || !($typeof(old(m$in)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != old(m$in) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != m || !($typeof(m) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(m, stack0i, stack1i);
    // ----- return  ----- WindowsCard.ssc(233,5)
    return;
}



procedure RTE.DP(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]) returns ($result: int where InRange($result, System.Int32));
  // user-declared preconditions
  requires ($Heap[$Heap[this, RTE.Scratch], $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$Heap[this, RTE.Scratch], $ownerRef], $inv] <: $Heap[$Heap[this, RTE.Scratch], $ownerFrame]) || $Heap[$Heap[$Heap[this, RTE.Scratch], $ownerRef], $localinv] == $BaseClass($Heap[$Heap[this, RTE.Scratch], $ownerFrame])) && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[$Heap[this, RTE.Scratch], $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[$Heap[this, RTE.Scratch], $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  requires 0 <= $Heap[this, RTE.DPP];
  requires $Heap[this, RTE.DPP] + 1 < $Length($Heap[$Heap[this, RTE.Scratch], Memory.contents]);
  // target object is exposed for RTE
  requires !($Heap[this, $inv] <: RTE) || $Heap[this, $localinv] == System.Object;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures 0 <= $result;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.DP(this: ref) returns ($result: int)
{
  var stack0o: ref;
  var stack1i: int;
  var a: int where InRange(a, System.Byte);
  var stack2i: int;
  var b: int where InRange(b, System.Byte);
  var stack0i: int;
  var return.value: int where InRange(return.value, System.Int32);
  var SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Int32);

  entry:
    goto block19023;

  block19023:
    goto block19227;

  block19227:
    // ----- nop  ----- WindowsCard.ssc(239,5)
    // ----- load field  ----- WindowsCard.ssc(243,10)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(243,10)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- call  ----- WindowsCard.ssc(243,10)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call a := Memory.get_cont$System.Int32(stack0o, stack1i);
    // ----- load field  ----- WindowsCard.ssc(244,10)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(244,10)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- load constant 1  ----- WindowsCard.ssc(244,10)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(244,10)
    stack1i := stack1i + stack2i;
    // ----- call  ----- WindowsCard.ssc(244,10)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && true && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call b := Memory.get_cont$System.Int32(stack0o, stack1i);
    // ----- load constant 8  ----- WindowsCard.ssc(245,5)
    stack0i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(245,5)
    stack0i := #shl(a, stack0i);
    // ----- binary operator  ----- WindowsCard.ssc(245,5)
    stack0i := stack0i + b;
    // ----- copy  ----- WindowsCard.ssc(245,5)
    return.value := stack0i;
    // ----- branch  ----- WindowsCard.ssc(245,5)
    goto block19176;

  block19176:
    // ----- nop  ----- WindowsCard.ssc(240,13)
    // ----- copy  ----- WindowsCard.ssc(240,13)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(240,13)
    stack0i := return.value;
    // ----- return  ----- WindowsCard.ssc(240,13)
    $result := stack0i;
    return;
}



procedure RTE.Terminate$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], code$in: int where InRange(code$in, System.Int32));
  // target object is exposed for RTE
  requires !($Heap[this, $inv] <: RTE) || $Heap[this, $localinv] == System.Object;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || $f != old(RTE.CurrRTEMode)) && ($o != old(this) || $f != old(RTE.RtnCode)) && ($o != old(this) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.Terminate$System.Int32(this: ref, code$in: int)
{
  var code: int where InRange(code, System.Int32);
  var stack0i: int;
  var temp0: exposeVersionType;
  var temp1: exposeVersionType;

  entry:
    code := code$in;
    goto block19924;

  block19924:
    goto block20026;

  block20026:
    // ----- nop  ----- WindowsCard.ssc(249,8)
    // ----- load constant 0  ----- WindowsCard.ssc(252,5)
    stack0i := 0;
    // ----- store field  ----- WindowsCard.ssc(252,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp0;
    $Heap[this, $exposeVersion] := temp0;
    // ----- frame condition  ----- WindowsCard.ssc(252,5)
    assert !(IncludeInMainFrameCondition(RTE.CurrRTEMode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || RTE.CurrRTEMode != old(RTE.CurrRTEMode)) && (this != old(this) || RTE.CurrRTEMode != old(RTE.RtnCode)));
    $Heap[this, RTE.CurrRTEMode] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- store field  ----- WindowsCard.ssc(253,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp1;
    $Heap[this, $exposeVersion] := temp1;
    // ----- frame condition  ----- WindowsCard.ssc(253,5)
    assert !(IncludeInMainFrameCondition(RTE.RtnCode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || RTE.RtnCode != old(RTE.CurrRTEMode)) && (this != old(this) || RTE.RtnCode != old(RTE.RtnCode)));
    $Heap[this, RTE.RtnCode] := code;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- return  ----- WindowsCard.ssc(253,5)
    return;
}



procedure RTE.Run(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]) returns ($result: int where InRange($result, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.Run(this: ref) returns ($result: int)
{
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var return.value: int where InRange(return.value, System.Int32);
  var SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Int32);
  var $Heap$block20434$LoopPreheader: HeapType;

  entry:
    goto block20417;

  block20417:
    goto block20536;

  block20536:
    // ----- nop  ----- WindowsCard.ssc(256,7)
    goto block20434$LoopPreheader;

  block20434:
    // ----- default loop invariant: allocation and ownership are stable  ----- WindowsCard.ssc(258,5)
    assume (forall $o: ref :: { $Heap[$o, $allocated] } $Heap$block20434$LoopPreheader[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } $Heap$block20434$LoopPreheader[$ot, $allocated] && $Heap$block20434$LoopPreheader[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == $Heap$block20434$LoopPreheader[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == $Heap$block20434$LoopPreheader[$ot, $ownerFrame]) && $Heap$block20434$LoopPreheader[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
    // ----- default loop invariant: exposure  ----- WindowsCard.ssc(258,5)
    assume (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $Heap$block20434$LoopPreheader[$o, $allocated] ==> $Heap$block20434$LoopPreheader[$o, $inv] == $Heap[$o, $inv] && $Heap$block20434$LoopPreheader[$o, $localinv] == $Heap[$o, $localinv]);
    assume (forall $o: ref :: !$Heap$block20434$LoopPreheader[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
    assume $Heap[this, $inv] == $Heap$block20434$LoopPreheader[this, $inv];
    // ----- default loop invariant: modifies  ----- WindowsCard.ssc(258,5)
    assume (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> $Heap$block20434$LoopPreheader[$o, $f] == $Heap[$o, $f]);
    assume $HeapSucc($Heap$block20434$LoopPreheader, $Heap);
    // ----- default loop invariant: owner fields  ----- WindowsCard.ssc(258,5)
    assert (forall $o: ref :: { $Heap[$o, $ownerFrame] } { $Heap[$o, $ownerRef] } $o != null && $Heap$block20434$LoopPreheader[$o, $allocated] ==> $Heap[$o, $ownerRef] == $Heap$block20434$LoopPreheader[$o, $ownerRef] && $Heap[$o, $ownerFrame] == $Heap$block20434$LoopPreheader[$o, $ownerFrame]);
    // ----- advance activity
    havoc $ActivityIndicator;
    // ----- load field  ----- WindowsCard.ssc(258,5)
    assert this != null;
    stack0i := $Heap[this, RTE.RtnCode];
    // ----- load constant 0  ----- WindowsCard.ssc(258,5)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(258,5)
    // ----- branch  ----- WindowsCard.ssc(258,5)
    goto true20434to20451, false20434to20553;

  true20434to20451:
    assume stack0i != stack1i;
    goto block20451;

  false20434to20553:
    assume stack0i == stack1i;
    goto block20553;

  block20451:
    // ----- load field  ----- WindowsCard.ssc(261,5)
    assert this != null;
    return.value := $Heap[this, RTE.RtnCode];
    // ----- branch  ----- WindowsCard.ssc(261,5)
    goto block20485;

  block20553:
    // ----- call  ----- WindowsCard.ssc(259,7)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || !($typeof(this) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call RTE.ExecuteInstruction(this);
    // ----- branch  ----- WindowsCard.ssc(260,6)
    goto block20434;

  block20485:
    // ----- copy  ----- WindowsCard.ssc(261,5)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(261,5)
    stack0i := return.value;
    // ----- return  ----- WindowsCard.ssc(261,5)
    $result := stack0i;
    return;

  block20434$LoopPreheader:
    $Heap$block20434$LoopPreheader := $Heap;
    goto block20434;
}



procedure RTE.ExecuteInstruction(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



procedure RTE.ApplyALU$System.Int32$System.Int32$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], opcd$in: int where InRange(opcd$in, System.Int32), valType$in: int where InRange(valType$in, System.Int32), val$in: int where InRange(val$in, System.Int32));
  // user-declared preconditions
  requires ($Heap[$Heap[this, RTE.Data], $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$Heap[this, RTE.Data], $ownerRef], $inv] <: $Heap[$Heap[this, RTE.Data], $ownerFrame]) || $Heap[$Heap[$Heap[this, RTE.Data], $ownerRef], $localinv] == $BaseClass($Heap[$Heap[this, RTE.Data], $ownerFrame])) && (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[$Heap[this, RTE.Data], $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[$Heap[this, RTE.Data], $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  requires valType$in == 120 || valType$in == 121;
  // target object is exposed for RTE
  requires !($Heap[this, $inv] <: RTE) || $Heap[this, $localinv] == System.Object;
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures $Length($Heap[$Heap[this, RTE.Data], Memory.contents]) == old($Length($Heap[$Heap[this, RTE.Data], Memory.contents]));
  // newly allocated objects are fully valid
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } $o != null && !old($Heap)[$o, $allocated] && $Heap[$o, $allocated] ==> $Heap[$o, $inv] == $typeof($o) && $Heap[$o, $localinv] == $typeof($o));
  // first consistent owner unchanged if its exposeVersion is
  free ensures (forall $o: ref :: { $Heap[$o, $FirstConsistentOwner] } old($Heap)[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] == $Heap[old($Heap)[$o, $FirstConsistentOwner], $exposeVersion] ==> old($Heap)[$o, $FirstConsistentOwner] == $Heap[$o, $FirstConsistentOwner]);
  // frame condition
  free ensures (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || $f != old(RTE.A)) && ($o != old(this) || $f != old(RTE.Z)) && ($o != old(this) || $f != old(RTE.C)) && ($o != old(this) || $f != old(RTE.CurrRTEMode)) && ($o != old(this) || $f != old(RTE.RtnCode)) && ($o != old(this) || $f != old($exposeVersion)) ==> old($Heap)[$o, $f] == $Heap[$o, $f]);
  free ensures $HeapSucc(old($Heap), $Heap);
  // inv/localinv change only in blocks
  free ensures (forall $o: ref :: { $Heap[$o, $localinv] } { $Heap[$o, $inv] } old($Heap)[$o, $allocated] ==> old($Heap)[$o, $inv] == $Heap[$o, $inv] && old($Heap)[$o, $localinv] == $Heap[$o, $localinv]);
  free ensures (forall $o: ref :: { $Heap[$o, $allocated] } old($Heap)[$o, $allocated] ==> $Heap[$o, $allocated]) && (forall $ot: ref :: { $Heap[$ot, $ownerFrame] } { $Heap[$ot, $ownerRef] } old($Heap)[$ot, $allocated] && old($Heap)[$ot, $ownerFrame] != $PeerGroupPlaceholder ==> $Heap[$ot, $ownerRef] == old($Heap)[$ot, $ownerRef] && $Heap[$ot, $ownerFrame] == old($Heap)[$ot, $ownerFrame]) && old($Heap)[$BeingConstructed, $NonNullFieldsAreInitialized] == $Heap[$BeingConstructed, $NonNullFieldsAreInitialized];
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.ApplyALU$System.Int32$System.Int32$System.Int32(this: ref, opcd$in: int, valType$in: int, val$in: int)
{
  var opcd: int where InRange(opcd, System.Int32);
  var valType: int where InRange(valType, System.Int32);
  var val: int where InRange(val, System.Int32);
  var local3: int where InRange(local3, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var val2: int where InRange(val2, System.Int32);
  var stack0o: ref;
  var stack1i: int;
  var stack2i: int;
  var res: int where InRange(res, System.Int32);
  var temp0: exposeVersionType;
  var stack1b: bool;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var temp2: exposeVersionType;

  entry:
    opcd := opcd$in;
    valType := valType$in;
    val := val$in;
    goto block21641;

  block21641:
    goto block22304;

  block22304:
    // ----- nop  ----- WindowsCard.ssc(267,5)
    // ----- copy  ----- WindowsCard.ssc(273,13)
    local3 := valType;
    // ----- load constant 120  ----- WindowsCard.ssc(273,13)
    stack0i := 120;
    // ----- binary operator  ----- WindowsCard.ssc(273,13)
    // ----- branch  ----- WindowsCard.ssc(273,13)
    goto true22304to22253, false22304to21811;

  true22304to22253:
    assume local3 == stack0i;
    goto block22253;

  false22304to21811:
    assume local3 != stack0i;
    goto block21811;

  block22253:
    // ----- copy  ----- WindowsCard.ssc(274,21)
    val2 := val;
    // ----- branch  ----- WindowsCard.ssc(274,33)
    goto block21896;

  block21811:
    // ----- load constant 121  ----- WindowsCard.ssc(273,13)
    stack0i := 121;
    // ----- binary operator  ----- WindowsCard.ssc(273,13)
    // ----- branch  ----- WindowsCard.ssc(273,13)
    goto true21811to21879, false21811to21743;

  true21811to21879:
    assume local3 == stack0i;
    goto block21879;

  false21811to21743:
    assume local3 != stack0i;
    goto block21743;

  block21879:
    // ----- load field  ----- WindowsCard.ssc(276,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(276,9)
    stack1i := val;
    // ----- call  ----- WindowsCard.ssc(276,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || $f != old(RTE.A)) && ($o != old(this) || $f != old(RTE.Z)) && ($o != old(this) || $f != old(RTE.C)) && ($o != old(this) || $f != old(RTE.CurrRTEMode)) && ($o != old(this) || $f != old(RTE.RtnCode)) && ($o != old(this) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(276,9)
    // ----- branch  ----- WindowsCard.ssc(276,9)
    goto true21879to21658, false21879to22151;

  block21743:
    // ----- branch  ----- WindowsCard.ssc(273,13)
    goto block22117;

  true21879to21658:
    assume !stack0b;
    goto block21658;

  false21879to22151:
    assume stack0b;
    goto block22151;

  block21658:
    // ----- load constant 24  ----- WindowsCard.ssc(279,11)
    stack0i := 24;
    // ----- call  ----- WindowsCard.ssc(279,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || $f != old(RTE.A)) && ($o != old(this) || $f != old(RTE.Z)) && ($o != old(this) || $f != old(RTE.C)) && ($o != old(this) || $f != old(RTE.CurrRTEMode)) && ($o != old(this) || $f != old(RTE.RtnCode)) && ($o != old(this) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- branch  ----- WindowsCard.ssc(280,11)
    goto block21862;

  block22151:
    // ----- load field  ----- WindowsCard.ssc(277,11)
    assert this != null;
    stack0o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(277,11)
    stack1i := val;
    // ----- call  ----- WindowsCard.ssc(277,11)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || $f != old(RTE.A)) && ($o != old(this) || $f != old(RTE.Z)) && ($o != old(this) || $f != old(RTE.C)) && ($o != old(this) || $f != old(RTE.CurrRTEMode)) && ($o != old(this) || $f != old(RTE.RtnCode)) && ($o != old(this) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call val2 := Memory.get_cont$System.Int32(stack0o, stack1i);
    // ----- branch  ----- WindowsCard.ssc(278,11)
    goto block21964;

  block21896:
    // ----- copy  ----- WindowsCard.ssc(286,9)
    stack0i := opcd;
    // ----- load field  ----- WindowsCard.ssc(286,9)
    assert this != null;
    stack1i := $Heap[this, RTE.A];
    // ----- copy  ----- WindowsCard.ssc(286,9)
    stack2i := val2;
    // ----- call  ----- WindowsCard.ssc(286,9)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || $f != old(RTE.A)) && ($o != old(this) || $f != old(RTE.Z)) && ($o != old(this) || $f != old(RTE.C)) && ($o != old(this) || $f != old(RTE.CurrRTEMode)) && ($o != old(this) || $f != old(RTE.RtnCode)) && ($o != old(this) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call res := RTE.apply$System.Int32$System.Int32$System.Int32(stack0i, stack1i, stack2i);
    // ----- store field  ----- WindowsCard.ssc(287,5)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp0;
    $Heap[this, $exposeVersion] := temp0;
    // ----- frame condition  ----- WindowsCard.ssc(287,5)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || RTE.A != old(RTE.A)) && true && true && (this != old(this) || RTE.A != old(RTE.CurrRTEMode)) && (this != old(this) || RTE.A != old(RTE.RtnCode)));
    $Heap[this, RTE.A] := res;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- copy
    stack0o := this;
    // ----- load constant 0  ----- WindowsCard.ssc(288,5)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(288,5)
    // ----- branch  ----- WindowsCard.ssc(288,5)
    goto true21896to21998, false21896to22015;

  true21896to21998:
    assume res == stack1i;
    goto block21998;

  false21896to22015:
    assume res != stack1i;
    goto block22015;

  block21998:
    // ----- load constant 1  ----- WindowsCard.ssc(288,5)
    stack1b := true;
    goto block21947;

  block22015:
    // ----- load constant 0
    stack1b := false;
    // ----- branch  ----- WindowsCard.ssc(288,5)
    goto block21947;

  block22117:
    // ----- serialized AssertStatement  ----- WindowsCard.ssc(284,9)
    assert false;
    return;

  block21964:
    // ----- branch  ----- WindowsCard.ssc(282,9)
    goto block21896;

  block21862:
    // ----- nop  ----- WindowsCard.ssc(270,13)
    // ----- return  ----- WindowsCard.ssc(270,13)
    return;

  block21947:
    // ----- store field  ----- WindowsCard.ssc(288,5)
    assert stack0o != null;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    havoc temp1;
    $Heap[stack0o, $exposeVersion] := temp1;
    // ----- frame condition  ----- WindowsCard.ssc(288,5)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && true && (stack0o != old(this) || RTE.Z != old(RTE.Z)) && (stack0o != old(this) || RTE.Z != old(RTE.C)) && true && true);
    $Heap[stack0o, RTE.Z] := stack1b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load constant 30  ----- WindowsCard.ssc(289,5)
    stack0i := 30;
    // ----- binary operator  ----- WindowsCard.ssc(289,5)
    // ----- branch  ----- WindowsCard.ssc(289,5)
    goto true21947to22270, false21947to22202;

  true21947to22270:
    assume opcd == stack0i;
    goto block22270;

  false21947to22202:
    assume opcd != stack0i;
    goto block22202;

  block22270:
    // ----- copy  ----- WindowsCard.ssc(290,7)
    stack0i := opcd;
    // ----- load field  ----- WindowsCard.ssc(290,7)
    assert this != null;
    stack1i := $Heap[this, RTE.A];
    // ----- copy  ----- WindowsCard.ssc(290,7)
    stack2i := val2;
    // ----- call  ----- WindowsCard.ssc(290,7)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || $f != old(RTE.A)) && ($o != old(this) || $f != old(RTE.Z)) && ($o != old(this) || $f != old(RTE.C)) && ($o != old(this) || $f != old(RTE.CurrRTEMode)) && ($o != old(this) || $f != old(RTE.RtnCode)) && ($o != old(this) || $f != old($exposeVersion)) ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := RTE.carry$System.Int32$System.Int32$System.Int32(stack0i, stack1i, stack2i);
    // ----- store field  ----- WindowsCard.ssc(290,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(290,7)
    assert !(IncludeInMainFrameCondition(RTE.C) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && true && (this != old(this) || RTE.C != old(RTE.Z)) && (this != old(this) || RTE.C != old(RTE.C)) && true && true);
    $Heap[this, RTE.C] := stack0b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    goto block21845;

  block22202:
    // ----- load constant 31  ----- WindowsCard.ssc(289,5)
    stack0i := 31;
    // ----- binary operator  ----- WindowsCard.ssc(289,5)
    // ----- branch  ----- WindowsCard.ssc(289,5)
    goto true22202to22270, false22202to22219;

  true22202to22270:
    assume opcd == stack0i;
    goto block22270;

  false22202to22219:
    assume opcd != stack0i;
    goto block22219;

  block22219:
    // ----- branch  ----- WindowsCard.ssc(289,5)
    goto block21845;

  block21845:
    // ----- branch  ----- WindowsCard.ssc(292,5)
    goto block21862;
}



axiom System.String <: System.String;

axiom $BaseClass(System.String) == System.Object && AsDirectSubClass(System.String, $BaseClass(System.String)) == System.String;

axiom $IsImmutable(System.String) && $AsImmutable(System.String) == System.String;

axiom System.IComparable <: System.IComparable;

axiom $IsMemberlessType(System.IComparable);

axiom $AsInterface(System.IComparable) == System.IComparable;

axiom System.String <: System.IComparable;

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

procedure RTE.OpArith$System.Int32$System.Int32$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], op$in: int where InRange(op$in, System.Int32), operand$in: int where InRange(operand$in, System.Int32), operandType$in: int where InRange(operandType$in, System.Int32));
  // user-declared preconditions
  requires operandType$in == 120 || operandType$in == 121;
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpArith$System.Int32$System.Int32$System.Int32(this: ref, op$in: int, operand$in: int, operandType$in: int)
{
  var op: int where InRange(op, System.Int32);
  var operand: int where InRange(operand, System.Int32);
  var operandType: int where InRange(operandType, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack2i: int;
  var temp2: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    op := op$in;
    operand := operand$in;
    operandType := operandType$in;
    goto block24531;

  block24531:
    goto block24769;

  block24769:
    // ----- nop  ----- WindowsCard.ssc(296,5)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(298,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(298,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(298,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(298,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(298,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block24786;

  block24786:
    // ----- copy  ----- WindowsCard.ssc(299,7)
    stack0i := op;
    // ----- copy  ----- WindowsCard.ssc(299,7)
    stack1i := operandType;
    // ----- copy  ----- WindowsCard.ssc(299,7)
    stack2i := operand;
    // ----- call  ----- WindowsCard.ssc(299,7)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.A) && ($o != this || $f != RTE.Z) && ($o != this || $f != RTE.C) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.ApplyALU$System.Int32$System.Int32$System.Int32(this, stack0i, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(300,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(300,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(300,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(300,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(300,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(300,7)
    goto block24973;

  block24973:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(300,7)
    // ----- branch  ----- WindowsCard.ssc(300,7)
    goto true24973to24922, false24973to24956;

  true24973to24922:
    assume local2 == stack0o;
    goto block24922;

  false24973to24956:
    assume local2 != stack0o;
    goto block24956;

  block24922:
    // ----- load token  ----- WindowsCard.ssc(301,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(301,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(301,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block24871;

  block24956:
    // ----- is instance  ----- WindowsCard.ssc(300,7)
    // ----- branch  ----- WindowsCard.ssc(300,7)
    goto true24956to24922, false24956to24939;

  true24956to24922:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block24922;

  false24956to24939:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block24939;

  block24939:
    // ----- branch  ----- WindowsCard.ssc(300,7)
    goto block24871;

  block24871:
    // ----- nop  ----- WindowsCard.ssc(301,5)
    // ----- branch
    goto block24837;

  block24837:
    // ----- return  ----- WindowsCard.ssc(301,5)
    return;
}



axiom Microsoft.Contracts.ICheckedException <: Microsoft.Contracts.ICheckedException;

axiom $IsMemberlessType(Microsoft.Contracts.ICheckedException);

axiom $AsInterface(Microsoft.Contracts.ICheckedException) == Microsoft.Contracts.ICheckedException;

procedure RTE.OpLDA$System.Int32$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32), operandType$in: int where InRange(operandType$in, System.Int32));
  // user-declared preconditions
  requires 0 <= operand$in;
  requires operand$in < $Length($Heap[$Heap[this, RTE.Data], Memory.contents]);
  requires operandType$in == 120 || operandType$in == 121;
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpLDA$System.Int32$System.Int32(this: ref, operand$in: int, operandType$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var operandType: int where InRange(operandType, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var local3: int where InRange(local3, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var temp2: exposeVersionType;
  var stack1i: int;
  var temp3: exposeVersionType;
  var stack0o: ref;
  var temp4: exposeVersionType;
  var stack0s: struct;

  entry:
    operand := operand$in;
    operandType := operandType$in;
    goto block26248;

  block26248:
    goto block26554;

  block26554:
    // ----- nop  ----- WindowsCard.ssc(306,5)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(308,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(308,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(308,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(308,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(308,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block26571;

  block26571:
    // ----- copy  ----- WindowsCard.ssc(309,15)
    local3 := operandType;
    // ----- load constant 120  ----- WindowsCard.ssc(309,15)
    stack0i := 120;
    // ----- binary operator  ----- WindowsCard.ssc(309,15)
    // ----- branch  ----- WindowsCard.ssc(309,15)
    goto true26571to26622, false26571to26588;

  true26571to26622:
    assume local3 == stack0i;
    goto block26622;

  false26571to26588:
    assume local3 != stack0i;
    goto block26588;

  block26622:
    // ----- store field  ----- WindowsCard.ssc(311,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(311,9)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.A)) || !$IncludedInModifiesStar(RTE.A)) && true);
    $Heap[this, RTE.A] := operand;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(312,9)
    goto block26656;

  block26588:
    // ----- load constant 121  ----- WindowsCard.ssc(309,15)
    stack0i := 121;
    // ----- binary operator  ----- WindowsCard.ssc(309,15)
    // ----- branch  ----- WindowsCard.ssc(309,15)
    goto true26588to26639, false26588to26605;

  true26588to26639:
    assume local3 == stack0i;
    goto block26639;

  false26588to26605:
    assume local3 != stack0i;
    goto block26605;

  block26639:
    // ----- load field  ----- WindowsCard.ssc(314,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(314,9)
    stack1i := operand;
    // ----- call  ----- WindowsCard.ssc(314,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := Memory.get_cont$System.Int32(stack0o, stack1i);
    // ----- store field  ----- WindowsCard.ssc(314,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp4;
    $Heap[this, $exposeVersion] := temp4;
    // ----- frame condition  ----- WindowsCard.ssc(314,9)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.A)) || !$IncludedInModifiesStar(RTE.A)) && true);
    $Heap[this, RTE.A] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(315,9)
    goto block26656;

  block26605:
    // ----- branch  ----- WindowsCard.ssc(309,15)
    goto block26656;

  block26656:
    // ----- load field  ----- WindowsCard.ssc(317,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(317,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(317,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(317,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(317,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(317,7)
    goto block26775;

  block26775:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(317,7)
    // ----- branch  ----- WindowsCard.ssc(317,7)
    goto true26775to26809, false26775to26758;

  true26775to26809:
    assume local2 == stack0o;
    goto block26809;

  false26775to26758:
    assume local2 != stack0o;
    goto block26758;

  block26809:
    // ----- load token  ----- WindowsCard.ssc(318,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(318,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(318,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block26826;

  block26758:
    // ----- is instance  ----- WindowsCard.ssc(317,7)
    // ----- branch  ----- WindowsCard.ssc(317,7)
    goto true26758to26809, false26758to26741;

  true26758to26809:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block26809;

  false26758to26741:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block26741;

  block26741:
    // ----- branch  ----- WindowsCard.ssc(317,7)
    goto block26826;

  block26826:
    // ----- nop  ----- WindowsCard.ssc(318,5)
    // ----- branch
    goto block26707;

  block26707:
    // ----- return  ----- WindowsCard.ssc(318,5)
    return;
}



procedure RTE.OpLDAC$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpLDAC$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0o: ref;
  var stack1i: int;
  var stack2i: int;
  var stack0b: bool;
  var stack0i: int;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block28067;

  block28067:
    goto block28220;

  block28220:
    // ----- nop  ----- WindowsCard.ssc(321,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(323,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(323,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(323,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(323,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(323,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block28237;

  block28237:
    // ----- load field  ----- WindowsCard.ssc(324,7)
    assert this != null;
    stack0o := $Heap[this, RTE.Program];
    // ----- load field  ----- WindowsCard.ssc(324,7)
    assert this != null;
    stack1i := $Heap[this, RTE.PC];
    // ----- load field  ----- WindowsCard.ssc(324,7)
    assert this != null;
    stack2i := $Heap[this, RTE.A];
    // ----- binary operator  ----- WindowsCard.ssc(324,7)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(324,7)
    stack1i := stack1i + operand;
    // ----- call  ----- WindowsCard.ssc(324,7)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(324,7)
    // ----- branch  ----- WindowsCard.ssc(324,7)
    goto true28237to28271, false28237to28254;

  true28237to28271:
    assume !stack0b;
    goto block28271;

  false28237to28254:
    assume stack0b;
    goto block28254;

  block28271:
    // ----- load constant 25  ----- WindowsCard.ssc(327,9)
    stack0i := 25;
    // ----- call  ----- WindowsCard.ssc(327,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(329,7)
    goto block28288;

  block28254:
    // ----- load field  ----- WindowsCard.ssc(325,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Program];
    // ----- load field  ----- WindowsCard.ssc(325,9)
    assert this != null;
    stack1i := $Heap[this, RTE.PC];
    // ----- load field  ----- WindowsCard.ssc(325,9)
    assert this != null;
    stack2i := $Heap[this, RTE.A];
    // ----- binary operator  ----- WindowsCard.ssc(325,9)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(325,9)
    stack1i := stack1i + operand;
    // ----- call  ----- WindowsCard.ssc(325,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := Memory.get_cont$System.Int32(stack0o, stack1i);
    // ----- store field  ----- WindowsCard.ssc(325,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(325,9)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.A)) || !$IncludedInModifiesStar(RTE.A)) && true);
    $Heap[this, RTE.A] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(326,9)
    goto block28288;

  block28288:
    // ----- load field  ----- WindowsCard.ssc(329,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(329,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(329,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(329,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(329,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(329,7)
    goto block28458;

  block28458:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(329,7)
    // ----- branch  ----- WindowsCard.ssc(329,7)
    goto true28458to28373, false28458to28390;

  true28458to28373:
    assume local2 == stack0o;
    goto block28373;

  false28458to28390:
    assume local2 != stack0o;
    goto block28390;

  block28373:
    // ----- load token  ----- WindowsCard.ssc(330,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(330,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(330,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block28492;

  block28390:
    // ----- is instance  ----- WindowsCard.ssc(329,7)
    // ----- branch  ----- WindowsCard.ssc(329,7)
    goto true28390to28373, false28390to28475;

  true28390to28373:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block28373;

  false28390to28475:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block28475;

  block28475:
    // ----- branch  ----- WindowsCard.ssc(329,7)
    goto block28492;

  block28492:
    // ----- nop  ----- WindowsCard.ssc(330,5)
    // ----- branch
    goto block28339;

  block28339:
    // ----- return  ----- WindowsCard.ssc(330,5)
    return;
}



procedure RTE.OpCLR$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpCLR$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0o: ref;
  var stack1i: int;
  var stack0b: bool;
  var stack2i: int;
  var temp2: exposeVersionType;
  var stack0i: int;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block29784;

  block29784:
    goto block29937;

  block29937:
    // ----- nop  ----- WindowsCard.ssc(333,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(335,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(335,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(335,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(335,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(335,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block29954;

  block29954:
    // ----- load field  ----- WindowsCard.ssc(336,7)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(336,7)
    stack1i := operand;
    // ----- call  ----- WindowsCard.ssc(336,7)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(336,7)
    // ----- branch  ----- WindowsCard.ssc(336,7)
    goto true29954to29988, false29954to29971;

  true29954to29988:
    assume !stack0b;
    goto block29988;

  false29954to29971:
    assume stack0b;
    goto block29971;

  block29988:
    // ----- load constant 21  ----- WindowsCard.ssc(340,9)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(340,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(342,7)
    goto block30005;

  block29971:
    // ----- load field  ----- WindowsCard.ssc(337,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(337,9)
    stack1i := operand;
    // ----- load constant 0  ----- WindowsCard.ssc(337,9)
    stack2i := 0;
    // ----- call  ----- WindowsCard.ssc(337,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(stack0o, stack1i, stack2i);
    // ----- load constant 1  ----- WindowsCard.ssc(338,9)
    stack0b := true;
    // ----- store field  ----- WindowsCard.ssc(338,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(338,9)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.Z)) || !$IncludedInModifiesStar(RTE.Z)) && true);
    $Heap[this, RTE.Z] := stack0b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(339,9)
    goto block30005;

  block30005:
    // ----- load field  ----- WindowsCard.ssc(342,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(342,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(342,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(342,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(342,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(342,7)
    goto block30124;

  block30124:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(342,7)
    // ----- branch  ----- WindowsCard.ssc(342,7)
    goto true30124to30090, false30124to30107;

  true30124to30090:
    assume local2 == stack0o;
    goto block30090;

  false30124to30107:
    assume local2 != stack0o;
    goto block30107;

  block30090:
    // ----- load token  ----- WindowsCard.ssc(343,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(343,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(343,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block30192;

  block30107:
    // ----- is instance  ----- WindowsCard.ssc(342,7)
    // ----- branch  ----- WindowsCard.ssc(342,7)
    goto true30107to30090, false30107to30158;

  true30107to30090:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block30090;

  false30107to30158:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block30158;

  block30158:
    // ----- branch  ----- WindowsCard.ssc(342,7)
    goto block30192;

  block30192:
    // ----- nop  ----- WindowsCard.ssc(343,5)
    // ----- branch
    goto block30056;

  block30056:
    // ----- return  ----- WindowsCard.ssc(343,5)
    return;
}



procedure RTE.OpDEC$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpDEC$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0o: ref;
  var stack1i: int;
  var stack0b: bool;
  var stack0i: int;
  var stack2o: ref;
  var stack3i: int;
  var stack2i: int;
  var stack1b: bool;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block31484;

  block31484:
    goto block31637;

  block31637:
    // ----- nop  ----- WindowsCard.ssc(346,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(348,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(348,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(348,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(348,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(348,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block31654;

  block31654:
    // ----- load field  ----- WindowsCard.ssc(349,7)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(349,7)
    stack1i := operand;
    // ----- call  ----- WindowsCard.ssc(349,7)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(349,7)
    // ----- branch  ----- WindowsCard.ssc(349,7)
    goto true31654to31739, false31654to31671;

  true31654to31739:
    assume !stack0b;
    goto block31739;

  false31654to31671:
    assume stack0b;
    goto block31671;

  block31739:
    // ----- load constant 21  ----- WindowsCard.ssc(354,9)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(354,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(356,7)
    goto block31756;

  block31671:
    // ----- load field  ----- WindowsCard.ssc(350,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(350,9)
    stack1i := operand;
    // ----- load field  ----- WindowsCard.ssc(350,9)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(350,9)
    stack3i := operand;
    // ----- call  ----- WindowsCard.ssc(350,9)
    assert stack2o != null;
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := Memory.get_cont$System.Int32(stack2o, stack3i);
    // ----- load constant 1  ----- WindowsCard.ssc(350,9)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(350,9)
    stack2i := stack2i - stack3i;
    // ----- unary operator  ----- WindowsCard.ssc(350,9)
    stack2i := stack2i;
    // ----- call  ----- WindowsCard.ssc(350,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(stack0o, stack1i, stack2i);
    // ----- copy
    stack0o := this;
    // ----- load field  ----- WindowsCard.ssc(351,9)
    assert this != null;
    stack1o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(351,9)
    stack2i := operand;
    // ----- call  ----- WindowsCard.ssc(351,9)
    assert stack1o != null;
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack1i := Memory.get_cont$System.Int32(stack1o, stack2i);
    // ----- load constant 1  ----- WindowsCard.ssc(351,9)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(351,9)
    stack1i := stack1i - stack2i;
    // ----- load constant 0  ----- WindowsCard.ssc(351,9)
    stack2i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(351,9)
    // ----- branch  ----- WindowsCard.ssc(351,9)
    goto true31671to31705, false31671to31688;

  true31671to31705:
    assume stack1i == stack2i;
    goto block31705;

  false31671to31688:
    assume stack1i != stack2i;
    goto block31688;

  block31705:
    // ----- load constant 1  ----- WindowsCard.ssc(351,9)
    stack1b := true;
    goto block31722;

  block31688:
    // ----- load constant 0
    stack1b := false;
    // ----- branch  ----- WindowsCard.ssc(351,9)
    goto block31722;

  block31756:
    // ----- load field  ----- WindowsCard.ssc(356,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(356,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(356,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(356,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(356,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(356,7)
    goto block31841;

  block31841:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(356,7)
    // ----- branch  ----- WindowsCard.ssc(356,7)
    goto true31841to31858, false31841to31926;

  true31841to31858:
    assume local2 == stack0o;
    goto block31858;

  false31841to31926:
    assume local2 != stack0o;
    goto block31926;

  block31858:
    // ----- load token  ----- WindowsCard.ssc(357,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(357,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(357,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block31960;

  block31926:
    // ----- is instance  ----- WindowsCard.ssc(356,7)
    // ----- branch  ----- WindowsCard.ssc(356,7)
    goto true31926to31858, false31926to31943;

  block31722:
    // ----- store field  ----- WindowsCard.ssc(351,9)
    assert stack0o != null;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    havoc temp3;
    $Heap[stack0o, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(351,9)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && (stack0o != old(this) || !($typeof(old(this)) <: DeclType(RTE.Z)) || !$IncludedInModifiesStar(RTE.Z)) && true);
    $Heap[stack0o, RTE.Z] := stack1b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(353,7)
    goto block31756;

  true31926to31858:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block31858;

  false31926to31943:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block31943;

  block31943:
    // ----- branch  ----- WindowsCard.ssc(356,7)
    goto block31960;

  block31960:
    // ----- nop  ----- WindowsCard.ssc(357,5)
    // ----- branch
    goto block31807;

  block31807:
    // ----- return  ----- WindowsCard.ssc(357,5)
    return;
}



procedure RTE.OpINC$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpINC$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0o: ref;
  var stack1i: int;
  var stack0b: bool;
  var stack2o: ref;
  var stack3i: int;
  var stack2i: int;
  var stack1b: bool;
  var stack0i: int;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block33507;

  block33507:
    goto block33660;

  block33660:
    // ----- nop  ----- WindowsCard.ssc(360,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(362,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(362,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(362,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(362,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(362,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block33677;

  block33677:
    // ----- load field  ----- WindowsCard.ssc(363,7)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(363,7)
    stack1i := operand;
    // ----- call  ----- WindowsCard.ssc(363,7)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(363,7)
    // ----- branch  ----- WindowsCard.ssc(363,7)
    goto true33677to33762, false33677to33694;

  true33677to33762:
    assume !stack0b;
    goto block33762;

  false33677to33694:
    assume stack0b;
    goto block33694;

  block33762:
    // ----- load constant 21  ----- WindowsCard.ssc(367,9)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(367,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(369,7)
    goto block33779;

  block33694:
    // ----- load field  ----- WindowsCard.ssc(364,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(364,9)
    stack1i := operand;
    // ----- load field  ----- WindowsCard.ssc(364,9)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(364,9)
    stack3i := operand;
    // ----- call  ----- WindowsCard.ssc(364,9)
    assert stack2o != null;
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := Memory.get_cont$System.Int32(stack2o, stack3i);
    // ----- load constant 1  ----- WindowsCard.ssc(364,9)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(364,9)
    stack2i := stack2i + stack3i;
    // ----- unary operator  ----- WindowsCard.ssc(364,9)
    stack2i := stack2i;
    // ----- call  ----- WindowsCard.ssc(364,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(stack0o, stack1i, stack2i);
    // ----- copy
    stack0o := this;
    // ----- load field  ----- WindowsCard.ssc(365,9)
    assert this != null;
    stack1o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(365,9)
    stack2i := operand;
    // ----- call  ----- WindowsCard.ssc(365,9)
    assert stack1o != null;
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack1i := Memory.get_cont$System.Int32(stack1o, stack2i);
    // ----- load constant 1  ----- WindowsCard.ssc(365,9)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(365,9)
    stack1i := stack1i + stack2i;
    // ----- load constant 0  ----- WindowsCard.ssc(365,9)
    stack2i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(365,9)
    // ----- branch  ----- WindowsCard.ssc(365,9)
    goto true33694to33728, false33694to33711;

  true33694to33728:
    assume stack1i == stack2i;
    goto block33728;

  false33694to33711:
    assume stack1i != stack2i;
    goto block33711;

  block33728:
    // ----- load constant 1  ----- WindowsCard.ssc(365,9)
    stack1b := true;
    goto block33745;

  block33711:
    // ----- load constant 0
    stack1b := false;
    // ----- branch  ----- WindowsCard.ssc(365,9)
    goto block33745;

  block33779:
    // ----- load field  ----- WindowsCard.ssc(369,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(369,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(369,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(369,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(369,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(369,7)
    goto block33949;

  block33745:
    // ----- store field  ----- WindowsCard.ssc(365,9)
    assert stack0o != null;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    havoc temp3;
    $Heap[stack0o, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(365,9)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && (stack0o != old(this) || !($typeof(old(this)) <: DeclType(RTE.Z)) || !$IncludedInModifiesStar(RTE.Z)) && true);
    $Heap[stack0o, RTE.Z] := stack1b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(366,9)
    goto block33779;

  block33949:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(369,7)
    // ----- branch  ----- WindowsCard.ssc(369,7)
    goto true33949to33932, false33949to33983;

  true33949to33932:
    assume local2 == stack0o;
    goto block33932;

  false33949to33983:
    assume local2 != stack0o;
    goto block33983;

  block33932:
    // ----- load token  ----- WindowsCard.ssc(370,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(370,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(370,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block33881;

  block33983:
    // ----- is instance  ----- WindowsCard.ssc(369,7)
    // ----- branch  ----- WindowsCard.ssc(369,7)
    goto true33983to33932, false33983to33915;

  true33983to33932:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block33932;

  false33983to33915:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block33915;

  block33915:
    // ----- branch  ----- WindowsCard.ssc(369,7)
    goto block33881;

  block33881:
    // ----- nop  ----- WindowsCard.ssc(370,5)
    // ----- branch
    goto block33830;

  block33830:
    // ----- return  ----- WindowsCard.ssc(370,5)
    return;
}



procedure RTE.OpJMP$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpJMP$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var temp2: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block35428;

  block35428:
    goto block35581;

  block35581:
    // ----- nop  ----- WindowsCard.ssc(373,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(375,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(375,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(375,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(375,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(375,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block35598;

  block35598:
    // ----- load field  ----- WindowsCard.ssc(376,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(376,7)
    stack0i := stack0i + operand;
    // ----- load constant 1  ----- WindowsCard.ssc(376,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(376,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(376,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(376,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(376,7)
    goto block35785;

  block35785:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(376,7)
    // ----- branch  ----- WindowsCard.ssc(376,7)
    goto true35785to35734, false35785to35768;

  true35785to35734:
    assume local2 == stack0o;
    goto block35734;

  false35785to35768:
    assume local2 != stack0o;
    goto block35768;

  block35734:
    // ----- load token  ----- WindowsCard.ssc(377,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(377,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(377,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block35751;

  block35768:
    // ----- is instance  ----- WindowsCard.ssc(376,7)
    // ----- branch  ----- WindowsCard.ssc(376,7)
    goto true35768to35734, false35768to35683;

  true35768to35734:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block35734;

  false35768to35683:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block35683;

  block35683:
    // ----- branch  ----- WindowsCard.ssc(376,7)
    goto block35751;

  block35751:
    // ----- nop  ----- WindowsCard.ssc(377,5)
    // ----- branch
    goto block35649;

  block35649:
    // ----- return  ----- WindowsCard.ssc(377,5)
    return;
}



procedure RTE.OpConditionalJump$System.Int32$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], op$in: int where InRange(op$in, System.Int32), operand$in: int where InRange(operand$in, System.Int32));
  // user-declared preconditions
  requires op$in == 51 || op$in == 52 || op$in == 53 || op$in == 54;
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpConditionalJump$System.Int32$System.Int32(this: ref, op$in: int, operand$in: int)
{
  var op: int where InRange(op, System.Int32);
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var local4: int where InRange(local4, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var takeBranch: bool where true;
  var stack1i: int;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0o: ref;
  var stack0s: struct;

  entry:
    op := op$in;
    operand := operand$in;
    goto block37315;

  block37315:
    goto block37587;

  block37587:
    // ----- nop  ----- WindowsCard.ssc(381,5)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(383,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(383,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(383,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(383,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(383,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block37604;

  block37604:
    // ----- copy  ----- WindowsCard.ssc(385,15)
    local4 := op;
    // ----- load constant 51  ----- WindowsCard.ssc(385,15)
    stack0i := 51;
    // ----- binary operator  ----- WindowsCard.ssc(385,15)
    // ----- branch  ----- WindowsCard.ssc(385,15)
    goto true37604to37689, false37604to37621;

  true37604to37689:
    assume local4 == stack0i;
    goto block37689;

  false37604to37621:
    assume local4 != stack0i;
    goto block37621;

  block37689:
    // ----- load field  ----- WindowsCard.ssc(386,18)
    assert this != null;
    takeBranch := $Heap[this, RTE.Z];
    // ----- branch  ----- WindowsCard.ssc(386,34)
    goto block37978;

  block37621:
    // ----- load constant 52  ----- WindowsCard.ssc(385,15)
    stack0i := 52;
    // ----- binary operator  ----- WindowsCard.ssc(385,15)
    // ----- branch  ----- WindowsCard.ssc(385,15)
    goto true37621to37706, false37621to37638;

  true37621to37706:
    assume local4 == stack0i;
    goto block37706;

  false37621to37638:
    assume local4 != stack0i;
    goto block37638;

  block37706:
    // ----- load field  ----- WindowsCard.ssc(387,19)
    assert this != null;
    // ----- branch  ----- WindowsCard.ssc(387,19)
    goto true37706to37740, false37706to37723;

  block37638:
    // ----- load constant 53  ----- WindowsCard.ssc(385,15)
    stack0i := 53;
    // ----- binary operator  ----- WindowsCard.ssc(385,15)
    // ----- branch  ----- WindowsCard.ssc(385,15)
    goto true37638to37774, false37638to37655;

  block37978:
    // ----- copy  ----- WindowsCard.ssc(393,7)
    stack0b := takeBranch;
    // ----- unary operator  ----- WindowsCard.ssc(393,7)
    // ----- branch  ----- WindowsCard.ssc(393,7)
    goto true37978to38012, false37978to37995;

  true37978to38012:
    assume !stack0b;
    goto block38012;

  false37978to37995:
    assume stack0b;
    goto block37995;

  block38012:
    // ----- load field  ----- WindowsCard.ssc(396,9)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(396,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(396,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(396,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(396,9)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- nop  ----- WindowsCard.ssc(398,5)
    goto block38029;

  block37995:
    // ----- load field  ----- WindowsCard.ssc(394,9)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(394,9)
    stack0i := stack0i + operand;
    // ----- load constant 1  ----- WindowsCard.ssc(394,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(394,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(394,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(394,9)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(395,9)
    goto block38029;

  true37638to37774:
    assume local4 == stack0i;
    goto block37774;

  false37638to37655:
    assume local4 != stack0i;
    goto block37655;

  block37774:
    // ----- load field  ----- WindowsCard.ssc(388,18)
    assert this != null;
    takeBranch := $Heap[this, RTE.C];
    // ----- branch  ----- WindowsCard.ssc(388,34)
    goto block37978;

  block37655:
    // ----- load constant 54  ----- WindowsCard.ssc(385,15)
    stack0i := 54;
    // ----- binary operator  ----- WindowsCard.ssc(385,15)
    // ----- branch  ----- WindowsCard.ssc(385,15)
    goto true37655to37791, false37655to37672;

  true37706to37740:
    assume $Heap[this, RTE.Z];
    goto block37740;

  false37706to37723:
    assume !$Heap[this, RTE.Z];
    goto block37723;

  block37740:
    // ----- load constant 0  ----- WindowsCard.ssc(387,19)
    stack0b := false;
    goto block37757;

  block37723:
    // ----- load constant 1
    stack0b := true;
    // ----- branch  ----- WindowsCard.ssc(387,19)
    goto block37757;

  true37655to37791:
    assume local4 == stack0i;
    goto block37791;

  false37655to37672:
    assume local4 != stack0i;
    goto block37672;

  block37791:
    // ----- load field  ----- WindowsCard.ssc(389,19)
    assert this != null;
    // ----- branch  ----- WindowsCard.ssc(389,19)
    goto true37791to37825, false37791to37808;

  block37672:
    // ----- branch  ----- WindowsCard.ssc(385,15)
    goto block37859;

  block38029:
    // ----- branch  ----- WindowsCard.ssc(398,5)
    goto block38199;

  true37791to37825:
    assume $Heap[this, RTE.C];
    goto block37825;

  false37791to37808:
    assume !$Heap[this, RTE.C];
    goto block37808;

  block37825:
    // ----- load constant 0  ----- WindowsCard.ssc(389,19)
    stack0b := false;
    goto block37842;

  block37808:
    // ----- load constant 1
    stack0b := true;
    // ----- branch  ----- WindowsCard.ssc(389,19)
    goto block37842;

  block37757:
    // ----- copy  ----- WindowsCard.ssc(387,19)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(387,36)
    goto block37978;

  block38199:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(398,5)
    // ----- branch  ----- WindowsCard.ssc(398,5)
    goto true38199to38216, false38199to38250;

  true38199to38216:
    assume local2 == stack0o;
    goto block38216;

  false38199to38250:
    assume local2 != stack0o;
    goto block38250;

  block38216:
    // ----- load token  ----- WindowsCard.ssc(398,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(398,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(398,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block38165;

  block38250:
    // ----- is instance  ----- WindowsCard.ssc(398,5)
    // ----- branch  ----- WindowsCard.ssc(398,5)
    goto true38250to38216, false38250to38131;

  block37859:
    // ----- serialized AssertStatement  ----- WindowsCard.ssc(391,11)
    assert false;
    return;

  true38250to38216:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block38216;

  false38250to38131:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block38131;

  block38131:
    // ----- branch  ----- WindowsCard.ssc(398,5)
    goto block38165;

  block37842:
    // ----- copy  ----- WindowsCard.ssc(389,19)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(389,36)
    goto block37978;

  block38165:
    // ----- nop  ----- WindowsCard.ssc(398,5)
    // ----- branch
    goto block38080;

  block38080:
    // ----- return  ----- WindowsCard.ssc(398,5)
    return;
}



procedure RTE.OpCALL$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpCALL$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack2i: int;
  var stack3i: int;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block39933;

  block39933:
    goto block40086;

  block40086:
    // ----- nop  ----- WindowsCard.ssc(401,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(403,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(403,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(403,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(403,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(403,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block40103;

  block40103:
    // ----- load field  ----- WindowsCard.ssc(404,7)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 10  ----- WindowsCard.ssc(404,7)
    stack1i := 10;
    // ----- binary operator  ----- WindowsCard.ssc(404,7)
    // ----- branch  ----- WindowsCard.ssc(404,7)
    goto true40103to40137, false40103to40120;

  true40103to40137:
    assume stack0i >= stack1i;
    goto block40137;

  false40103to40120:
    assume stack0i < stack1i;
    goto block40120;

  block40137:
    // ----- load constant 22  ----- WindowsCard.ssc(409,9)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(409,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(411,5)
    goto block40154;

  block40120:
    // ----- load field  ----- WindowsCard.ssc(405,9)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(405,9)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load field  ----- WindowsCard.ssc(405,9)
    assert this != null;
    stack2i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(405,9)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(405,9)
    stack2i := stack2i + stack3i;
    // ----- store element  ----- WindowsCard.ssc(405,9)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    // ----- frame condition  ----- WindowsCard.ssc(405,9)
    assert !(old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && true);
    $Heap[stack0o, $elementsInt] := ArraySet($Heap[stack0o, $elementsInt], stack1i, stack2i);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(406,9)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(406,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(406,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(406,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(406,9)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(407,9)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(407,9)
    stack0i := stack0i + operand;
    // ----- load constant 1  ----- WindowsCard.ssc(407,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(407,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(407,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(407,9)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(408,9)
    goto block40154;

  block40154:
    // ----- branch  ----- WindowsCard.ssc(411,5)
    goto block40307;

  block40307:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(411,5)
    // ----- branch  ----- WindowsCard.ssc(411,5)
    goto true40307to40341, false40307to40239;

  true40307to40341:
    assume local2 == stack0o;
    goto block40341;

  false40307to40239:
    assume local2 != stack0o;
    goto block40239;

  block40341:
    // ----- load token  ----- WindowsCard.ssc(411,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(411,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(411,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block40324;

  block40239:
    // ----- is instance  ----- WindowsCard.ssc(411,5)
    // ----- branch  ----- WindowsCard.ssc(411,5)
    goto true40239to40341, false40239to40256;

  true40239to40341:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block40341;

  false40239to40256:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block40256;

  block40256:
    // ----- branch  ----- WindowsCard.ssc(411,5)
    goto block40324;

  block40324:
    // ----- nop  ----- WindowsCard.ssc(411,5)
    // ----- branch
    goto block40205;

  block40205:
    // ----- return  ----- WindowsCard.ssc(411,5)
    return;
}



procedure RTE.OpRET(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpRET(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack2i: int;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    goto block41650;

  block41650:
    goto block41803;

  block41803:
    // ----- nop  ----- WindowsCard.ssc(414,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(416,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(416,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(416,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(416,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(416,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block41820;

  block41820:
    // ----- load field  ----- WindowsCard.ssc(417,7)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 0  ----- WindowsCard.ssc(417,7)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(417,7)
    // ----- branch  ----- WindowsCard.ssc(417,7)
    goto true41820to41854, false41820to41837;

  true41820to41854:
    assume stack0i <= stack1i;
    goto block41854;

  false41820to41837:
    assume stack0i > stack1i;
    goto block41837;

  block41854:
    // ----- load constant 22  ----- WindowsCard.ssc(421,9)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(421,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(423,5)
    goto block41871;

  block41837:
    // ----- load field  ----- WindowsCard.ssc(418,9)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(418,9)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(418,9)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(418,9)
    stack1i := stack1i - stack2i;
    // ----- load element  ----- WindowsCard.ssc(418,9)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    stack0i := ArrayGet($Heap[stack0o, $elementsInt], stack1i);
    // ----- store field  ----- WindowsCard.ssc(418,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(418,9)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(419,9)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(419,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(419,9)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(419,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(419,9)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(420,9)
    goto block41871;

  block41871:
    // ----- branch  ----- WindowsCard.ssc(423,5)
    goto block42075;

  block42075:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(423,5)
    // ----- branch  ----- WindowsCard.ssc(423,5)
    goto true42075to42024, false42075to42007;

  true42075to42024:
    assume local2 == stack0o;
    goto block42024;

  false42075to42007:
    assume local2 != stack0o;
    goto block42007;

  block42024:
    // ----- load token  ----- WindowsCard.ssc(423,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(423,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(423,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block41990;

  block42007:
    // ----- is instance  ----- WindowsCard.ssc(423,5)
    // ----- branch  ----- WindowsCard.ssc(423,5)
    goto true42007to42024, false42007to41973;

  true42007to42024:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block42024;

  false42007to41973:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block41973;

  block41973:
    // ----- branch  ----- WindowsCard.ssc(423,5)
    goto block41990;

  block41990:
    // ----- nop  ----- WindowsCard.ssc(423,5)
    // ----- branch
    goto block41922;

  block41922:
    // ----- return  ----- WindowsCard.ssc(423,5)
    return;
}



procedure RTE.OpNOP(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpNOP(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var temp2: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    goto block43231;

  block43231:
    goto block43384;

  block43384:
    // ----- nop  ----- WindowsCard.ssc(426,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(428,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(428,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(428,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(428,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(428,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block43401;

  block43401:
    // ----- load field  ----- WindowsCard.ssc(429,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(429,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(429,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(429,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(429,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(429,7)
    goto block43486;

  block43486:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(429,7)
    // ----- branch  ----- WindowsCard.ssc(429,7)
    goto true43486to43571, false43486to43520;

  true43486to43571:
    assume local2 == stack0o;
    goto block43571;

  false43486to43520:
    assume local2 != stack0o;
    goto block43520;

  block43571:
    // ----- load token  ----- WindowsCard.ssc(430,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(430,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(430,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block43503;

  block43520:
    // ----- is instance  ----- WindowsCard.ssc(429,7)
    // ----- branch  ----- WindowsCard.ssc(429,7)
    goto true43520to43571, false43520to43588;

  true43520to43571:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block43571;

  false43520to43588:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block43588;

  block43588:
    // ----- branch  ----- WindowsCard.ssc(429,7)
    goto block43503;

  block43503:
    // ----- nop  ----- WindowsCard.ssc(430,5)
    // ----- branch
    goto block43452;

  block43452:
    // ----- return  ----- WindowsCard.ssc(430,5)
    return;
}



procedure RTE.OpEND(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpEND(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    goto block44557;

  block44557:
    goto block44710;

  block44710:
    // ----- nop  ----- WindowsCard.ssc(433,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(435,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(435,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(435,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(435,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(435,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block44727;

  block44727:
    // ----- load constant 20  ----- WindowsCard.ssc(436,7)
    stack0i := 20;
    // ----- call  ----- WindowsCard.ssc(436,7)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- branch  ----- WindowsCard.ssc(436,7)
    goto block44829;

  block44829:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(436,7)
    // ----- branch  ----- WindowsCard.ssc(436,7)
    goto true44829to44846, false44829to44931;

  true44829to44846:
    assume local2 == stack0o;
    goto block44846;

  false44829to44931:
    assume local2 != stack0o;
    goto block44931;

  block44846:
    // ----- load token  ----- WindowsCard.ssc(437,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(437,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(437,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block44863;

  block44931:
    // ----- is instance  ----- WindowsCard.ssc(436,7)
    // ----- branch  ----- WindowsCard.ssc(436,7)
    goto true44931to44846, false44931to44812;

  true44931to44846:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block44846;

  false44931to44812:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block44812;

  block44812:
    // ----- branch  ----- WindowsCard.ssc(436,7)
    goto block44863;

  block44863:
    // ----- nop  ----- WindowsCard.ssc(437,5)
    // ----- branch
    goto block44778;

  block44778:
    // ----- return  ----- WindowsCard.ssc(437,5)
    return;
}



procedure RTE.OpESC(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.OpESC(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var temp2: exposeVersionType;
  var stack1i: int;
  var temp3: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    goto block45849;

  block45849:
    goto block46002;

  block46002:
    // ----- nop  ----- WindowsCard.ssc(440,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(442,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(442,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(442,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(442,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(442,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block46019;

  block46019:
    // ----- load constant 11  ----- WindowsCard.ssc(443,7)
    stack0i := 11;
    // ----- store field  ----- WindowsCard.ssc(443,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(443,7)
    assert !(IncludeInMainFrameCondition(RTE.CurrRTEMode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CurrRTEMode)) || !$IncludedInModifiesStar(RTE.CurrRTEMode)) && true);
    $Heap[this, RTE.CurrRTEMode] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(444,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(444,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(444,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(444,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(444,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(444,7)
    goto block46104;

  block46104:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(444,7)
    // ----- branch  ----- WindowsCard.ssc(444,7)
    goto true46104to46155, false46104to46223;

  true46104to46155:
    assume local2 == stack0o;
    goto block46155;

  false46104to46223:
    assume local2 != stack0o;
    goto block46223;

  block46155:
    // ----- load token  ----- WindowsCard.ssc(445,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(445,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(445,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block46172;

  block46223:
    // ----- is instance  ----- WindowsCard.ssc(444,7)
    // ----- branch  ----- WindowsCard.ssc(444,7)
    goto true46223to46155, false46223to46206;

  true46223to46155:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block46155;

  false46223to46206:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block46206;

  block46206:
    // ----- branch  ----- WindowsCard.ssc(444,7)
    goto block46172;

  block46172:
    // ----- nop  ----- WindowsCard.ssc(445,5)
    // ----- branch
    goto block46070;

  block46070:
    // ----- return  ----- WindowsCard.ssc(445,5)
    return;
}



procedure RTE.MOpNEG(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpNEG(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack2i: int;
  var stack3o: ref;
  var stack4i: int;
  var stack5i: int;
  var stack3i: int;
  var temp2: exposeVersionType;
  var stack0s: struct;

  entry:
    goto block47260;

  block47260:
    goto block47413;

  block47413:
    // ----- nop  ----- WindowsCard.ssc(448,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(450,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(450,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(450,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(450,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(450,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block47430;

  block47430:
    // ----- load field  ----- WindowsCard.ssc(451,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(451,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(451,7)
    // ----- branch  ----- WindowsCard.ssc(451,7)
    goto true47430to47464, false47430to47447;

  true47430to47464:
    assume stack0i == stack1i;
    goto block47464;

  false47430to47447:
    assume stack0i != stack1i;
    goto block47447;

  block47464:
    // ----- load constant 23  ----- WindowsCard.ssc(454,9)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(454,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(456,7)
    goto block47481;

  block47447:
    // ----- load field  ----- WindowsCard.ssc(452,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(452,9)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(452,9)
    stack2i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(452,9)
    stack1i := stack1i - stack2i;
    // ----- load constant -1  ----- WindowsCard.ssc(452,9)
    stack2i := -1;
    // ----- load field  ----- WindowsCard.ssc(452,9)
    assert this != null;
    stack3o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(452,9)
    assert this != null;
    stack4i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(452,9)
    stack5i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(452,9)
    stack4i := stack4i - stack5i;
    // ----- call  ----- WindowsCard.ssc(452,9)
    assume $Utter($Heap[stack3o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack3i := RTE.ReadQuad$Memory$notnull$System.Int32(stack3o, stack4i);
    // ----- binary operator  ----- WindowsCard.ssc(452,9)
    stack2i := stack2i * stack3i;
    // ----- call  ----- WindowsCard.ssc(452,9)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- branch  ----- WindowsCard.ssc(453,9)
    goto block47481;

  block47481:
    // ----- load field  ----- WindowsCard.ssc(456,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(456,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(456,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(456,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(456,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(456,7)
    goto block47617;

  block47617:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(456,7)
    // ----- branch  ----- WindowsCard.ssc(456,7)
    goto true47617to47583, false47617to47600;

  true47617to47583:
    assume local2 == stack0o;
    goto block47583;

  false47617to47600:
    assume local2 != stack0o;
    goto block47600;

  block47583:
    // ----- load token  ----- WindowsCard.ssc(457,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(457,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(457,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block47651;

  block47600:
    // ----- is instance  ----- WindowsCard.ssc(456,7)
    // ----- branch  ----- WindowsCard.ssc(456,7)
    goto true47600to47583, false47600to47634;

  true47600to47583:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block47583;

  false47600to47634:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block47634;

  block47634:
    // ----- branch  ----- WindowsCard.ssc(456,7)
    goto block47651;

  block47651:
    // ----- nop  ----- WindowsCard.ssc(457,5)
    // ----- branch
    goto block47532;

  block47532:
    // ----- return  ----- WindowsCard.ssc(457,5)
    return;
}



procedure RTE.MOpArith$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], op$in: int where InRange(op$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpArith$System.Int32(this: ref, op$in: int)
{
  var op: int where InRange(op, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var temp2: exposeVersionType;
  var stack2i: int;
  var stack3i: int;
  var stack2o: ref;
  var stack4i: int;
  var val: int where InRange(val, System.Int32);
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    op := op$in;
    goto block49096;

  block49096:
    goto block49249;

  block49249:
    // ----- nop  ----- WindowsCard.ssc(460,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(462,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(462,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(462,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(462,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(462,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block49266;

  block49266:
    // ----- load field  ----- WindowsCard.ssc(463,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(463,7)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(463,7)
    stack0i := stack0i - stack1i;
    // ----- load field  ----- WindowsCard.ssc(463,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(463,7)
    // ----- branch  ----- WindowsCard.ssc(463,7)
    goto true49266to49402, false49266to49283;

  true49266to49402:
    assume stack0i == stack1i;
    goto block49402;

  false49266to49283:
    assume stack0i != stack1i;
    goto block49283;

  block49402:
    // ----- load constant 23  ----- WindowsCard.ssc(469,9)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(469,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(471,7)
    goto block49419;

  block49283:
    // ----- load field  ----- WindowsCard.ssc(463,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(463,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(463,7)
    // ----- branch  ----- WindowsCard.ssc(463,7)
    goto true49283to49402, false49283to49300;

  true49283to49402:
    assume stack0i == stack1i;
    goto block49402;

  false49283to49300:
    assume stack0i != stack1i;
    goto block49300;

  block49300:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(464,9)
    assume 0 <= $Heap[this, RTE.MSP] - 8;
    goto block49385;

  block49419:
    // ----- load field  ----- WindowsCard.ssc(471,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(471,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(471,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(471,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(471,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(471,7)
    goto block49538;

  block49385:
    // ----- nop  ----- WindowsCard.ssc(464,16)
    // ----- copy  ----- WindowsCard.ssc(465,13)
    stack0i := op;
    // ----- load field  ----- WindowsCard.ssc(465,13)
    assert this != null;
    stack1o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(465,13)
    assert this != null;
    stack2i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(465,13)
    stack3i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(465,13)
    stack2i := stack2i - stack3i;
    // ----- call  ----- WindowsCard.ssc(465,13)
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack1i := RTE.ReadQuad$Memory$notnull$System.Int32(stack1o, stack2i);
    // ----- load field  ----- WindowsCard.ssc(465,13)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(465,13)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(465,13)
    stack4i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(465,13)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(465,13)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(465,13)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call val := RTE.ApplyQuad$System.Int32$System.Int32$System.Int32(stack0i, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(466,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(466,9)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(466,9)
    stack2i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(466,9)
    stack1i := stack1i - stack2i;
    // ----- copy  ----- WindowsCard.ssc(466,9)
    stack2i := val;
    // ----- call  ----- WindowsCard.ssc(466,9)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(467,9)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(467,9)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(467,9)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(467,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(467,9)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(468,9)
    goto block49419;

  block49538:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(471,7)
    // ----- branch  ----- WindowsCard.ssc(471,7)
    goto true49538to49589, false49538to49504;

  true49538to49589:
    assume local2 == stack0o;
    goto block49589;

  false49538to49504:
    assume local2 != stack0o;
    goto block49504;

  block49589:
    // ----- load token  ----- WindowsCard.ssc(472,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(472,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(472,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block49640;

  block49504:
    // ----- is instance  ----- WindowsCard.ssc(471,7)
    // ----- branch  ----- WindowsCard.ssc(471,7)
    goto true49504to49589, false49504to49555;

  true49504to49589:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block49589;

  false49504to49555:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block49555;

  block49555:
    // ----- branch  ----- WindowsCard.ssc(471,7)
    goto block49640;

  block49640:
    // ----- nop  ----- WindowsCard.ssc(472,5)
    // ----- branch
    goto block49470;

  block49470:
    // ----- return  ----- WindowsCard.ssc(472,5)
    return;
}



procedure RTE.MOpJMP$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpJMP$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var temp2: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block51238;

  block51238:
    goto block51391;

  block51391:
    // ----- nop  ----- WindowsCard.ssc(475,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(477,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(477,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(477,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(477,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(477,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block51408;

  block51408:
    // ----- load field  ----- WindowsCard.ssc(478,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(478,7)
    stack0i := stack0i + operand;
    // ----- load constant 1  ----- WindowsCard.ssc(478,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(478,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(478,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(478,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(478,7)
    goto block51493;

  block51493:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(478,7)
    // ----- branch  ----- WindowsCard.ssc(478,7)
    goto true51493to51612, false51493to51561;

  true51493to51612:
    assume local2 == stack0o;
    goto block51612;

  false51493to51561:
    assume local2 != stack0o;
    goto block51561;

  block51612:
    // ----- load token  ----- WindowsCard.ssc(479,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(479,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(479,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block51527;

  block51561:
    // ----- is instance  ----- WindowsCard.ssc(478,7)
    // ----- branch  ----- WindowsCard.ssc(478,7)
    goto true51561to51612, false51561to51510;

  true51561to51612:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block51612;

  false51561to51510:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block51510;

  block51510:
    // ----- branch  ----- WindowsCard.ssc(478,7)
    goto block51527;

  block51527:
    // ----- nop  ----- WindowsCard.ssc(479,5)
    // ----- branch
    goto block51459;

  block51459:
    // ----- return  ----- WindowsCard.ssc(479,5)
    return;
}



procedure RTE.MOpCALL$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpCALL$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack2i: int;
  var stack3i: int;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    operand := operand$in;
    goto block52632;

  block52632:
    goto block52785;

  block52785:
    // ----- nop  ----- WindowsCard.ssc(482,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(484,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(484,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(484,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(484,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(484,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block52802;

  block52802:
    // ----- load field  ----- WindowsCard.ssc(485,7)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 10  ----- WindowsCard.ssc(485,7)
    stack1i := 10;
    // ----- binary operator  ----- WindowsCard.ssc(485,7)
    // ----- branch  ----- WindowsCard.ssc(485,7)
    goto true52802to52836, false52802to52819;

  true52802to52836:
    assume stack0i >= stack1i;
    goto block52836;

  false52802to52819:
    assume stack0i < stack1i;
    goto block52819;

  block52836:
    // ----- load constant 22  ----- WindowsCard.ssc(490,9)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(490,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(492,5)
    goto block52853;

  block52819:
    // ----- load field  ----- WindowsCard.ssc(486,9)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(486,9)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load field  ----- WindowsCard.ssc(486,9)
    assert this != null;
    stack2i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(486,9)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(486,9)
    stack2i := stack2i + stack3i;
    // ----- store element  ----- WindowsCard.ssc(486,9)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    // ----- frame condition  ----- WindowsCard.ssc(486,9)
    assert !(old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && true);
    $Heap[stack0o, $elementsInt] := ArraySet($Heap[stack0o, $elementsInt], stack1i, stack2i);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(487,9)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(487,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(487,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(487,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(487,9)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(488,9)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(488,9)
    stack0i := stack0i + operand;
    // ----- load constant 1  ----- WindowsCard.ssc(488,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(488,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(488,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(488,9)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(489,9)
    goto block52853;

  block52853:
    // ----- branch  ----- WindowsCard.ssc(492,5)
    goto block53023;

  block53023:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(492,5)
    // ----- branch  ----- WindowsCard.ssc(492,5)
    goto true53023to53006, false53023to52989;

  true53023to53006:
    assume local2 == stack0o;
    goto block53006;

  false53023to52989:
    assume local2 != stack0o;
    goto block52989;

  block53006:
    // ----- load token  ----- WindowsCard.ssc(492,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(492,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(492,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block52972;

  block52989:
    // ----- is instance  ----- WindowsCard.ssc(492,5)
    // ----- branch  ----- WindowsCard.ssc(492,5)
    goto true52989to53006, false52989to52955;

  true52989to53006:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block53006;

  false52989to52955:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block52955;

  block52955:
    // ----- branch  ----- WindowsCard.ssc(492,5)
    goto block52972;

  block52972:
    // ----- nop  ----- WindowsCard.ssc(492,5)
    // ----- branch
    goto block52904;

  block52904:
    // ----- return  ----- WindowsCard.ssc(492,5)
    return;
}



procedure RTE.MOpRET(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpRET(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack2i: int;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    goto block54349;

  block54349:
    goto block54502;

  block54502:
    // ----- nop  ----- WindowsCard.ssc(495,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(497,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(497,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(497,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(497,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(497,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block54519;

  block54519:
    // ----- load field  ----- WindowsCard.ssc(498,7)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 0  ----- WindowsCard.ssc(498,7)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(498,7)
    // ----- branch  ----- WindowsCard.ssc(498,7)
    goto true54519to54553, false54519to54536;

  true54519to54553:
    assume stack0i <= stack1i;
    goto block54553;

  false54519to54536:
    assume stack0i > stack1i;
    goto block54536;

  block54553:
    // ----- load constant 22  ----- WindowsCard.ssc(502,9)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(502,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(504,5)
    goto block54570;

  block54536:
    // ----- load field  ----- WindowsCard.ssc(499,9)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(499,9)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(499,9)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(499,9)
    stack1i := stack1i - stack2i;
    // ----- load element  ----- WindowsCard.ssc(499,9)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    stack0i := ArrayGet($Heap[stack0o, $elementsInt], stack1i);
    // ----- store field  ----- WindowsCard.ssc(499,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(499,9)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(500,9)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(500,9)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(500,9)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(500,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(500,9)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(501,9)
    goto block54570;

  block54570:
    // ----- branch  ----- WindowsCard.ssc(504,5)
    goto block54723;

  block54723:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(504,5)
    // ----- branch  ----- WindowsCard.ssc(504,5)
    goto true54723to54740, false54723to54774;

  true54723to54740:
    assume local2 == stack0o;
    goto block54740;

  false54723to54774:
    assume local2 != stack0o;
    goto block54774;

  block54740:
    // ----- load token  ----- WindowsCard.ssc(504,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(504,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(504,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block54706;

  block54774:
    // ----- is instance  ----- WindowsCard.ssc(504,5)
    // ----- branch  ----- WindowsCard.ssc(504,5)
    goto true54774to54740, false54774to54655;

  true54774to54740:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block54740;

  false54774to54655:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block54655;

  block54655:
    // ----- branch  ----- WindowsCard.ssc(504,5)
    goto block54706;

  block54706:
    // ----- nop  ----- WindowsCard.ssc(504,5)
    // ----- branch
    goto block54621;

  block54621:
    // ----- return  ----- WindowsCard.ssc(504,5)
    return;
}



procedure RTE.MConditionalJump$System.Int32$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], op$in: int where InRange(op$in, System.Int32), operand$in: int where InRange(operand$in, System.Int32));
  // user-declared preconditions
  requires op$in == 91 || op$in == 92 || op$in == 93 || op$in == 94;
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MConditionalJump$System.Int32$System.Int32(this: ref, op$in: int, operand$in: int)
{
  var op: int where InRange(op, System.Int32);
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack2i: int;
  var val: int where InRange(val, System.Int32);
  var local5: int where InRange(local5, System.Int32);
  var takeBranch: bool where true;
  var stack0s: struct;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;

  entry:
    op := op$in;
    operand := operand$in;
    goto block56627;

  block56627:
    goto block56899;

  block56899:
    // ----- nop  ----- WindowsCard.ssc(508,5)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(510,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(510,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(510,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(510,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(510,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block56916;

  block56916:
    // ----- load field  ----- WindowsCard.ssc(511,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(511,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(511,7)
    // ----- branch  ----- WindowsCard.ssc(511,7)
    goto true56916to57477, false56916to56933;

  true56916to57477:
    assume stack0i == stack1i;
    goto block57477;

  false56916to56933:
    assume stack0i != stack1i;
    goto block56933;

  block57477:
    // ----- load constant 23  ----- WindowsCard.ssc(528,9)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(528,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(530,5)
    goto block57494;

  block56933:
    // ----- load field  ----- WindowsCard.ssc(512,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(512,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(512,13)
    stack2i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(512,13)
    stack1i := stack1i - stack2i;
    // ----- call  ----- WindowsCard.ssc(512,13)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call val := RTE.ReadQuad$Memory$notnull$System.Int32(stack0o, stack1i);
    // ----- copy  ----- WindowsCard.ssc(514,17)
    local5 := op;
    // ----- load constant 91  ----- WindowsCard.ssc(514,17)
    stack0i := 91;
    // ----- binary operator  ----- WindowsCard.ssc(514,17)
    // ----- branch  ----- WindowsCard.ssc(514,17)
    goto true56933to57018, false56933to56950;

  true56933to57018:
    assume local5 == stack0i;
    goto block57018;

  false56933to56950:
    assume local5 != stack0i;
    goto block56950;

  block57018:
    // ----- load constant 0  ----- WindowsCard.ssc(515,21)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(515,21)
    // ----- branch  ----- WindowsCard.ssc(515,21)
    goto true57018to57052, false57018to57035;

  block56950:
    // ----- load constant 92  ----- WindowsCard.ssc(514,17)
    stack0i := 92;
    // ----- binary operator  ----- WindowsCard.ssc(514,17)
    // ----- branch  ----- WindowsCard.ssc(514,17)
    goto true56950to57086, false56950to56967;

  true57018to57052:
    assume val == stack0i;
    goto block57052;

  false57018to57035:
    assume val != stack0i;
    goto block57035;

  block57052:
    // ----- load constant 1  ----- WindowsCard.ssc(515,21)
    stack0b := true;
    goto block57069;

  block57035:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(515,21)
    goto block57069;

  true56950to57086:
    assume local5 == stack0i;
    goto block57086;

  false56950to56967:
    assume local5 != stack0i;
    goto block56967;

  block57086:
    // ----- load constant 0  ----- WindowsCard.ssc(516,22)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(516,22)
    // ----- branch  ----- WindowsCard.ssc(516,22)
    goto true57086to57120, false57086to57103;

  block56967:
    // ----- load constant 93  ----- WindowsCard.ssc(514,17)
    stack0i := 93;
    // ----- binary operator  ----- WindowsCard.ssc(514,17)
    // ----- branch  ----- WindowsCard.ssc(514,17)
    goto true56967to57154, false56967to56984;

  block57494:
    // ----- branch  ----- WindowsCard.ssc(530,5)
    goto block57698;

  true57086to57120:
    assume val != stack0i;
    goto block57120;

  false57086to57103:
    assume val == stack0i;
    goto block57103;

  block57120:
    // ----- load constant 1  ----- WindowsCard.ssc(516,22)
    stack0b := true;
    goto block57137;

  block57103:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(516,22)
    goto block57137;

  true56967to57154:
    assume local5 == stack0i;
    goto block57154;

  false56967to56984:
    assume local5 != stack0i;
    goto block56984;

  block57154:
    // ----- load constant 0  ----- WindowsCard.ssc(517,23)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(517,23)
    // ----- branch  ----- WindowsCard.ssc(517,23)
    goto true57154to57188, false57154to57171;

  block56984:
    // ----- load constant 94  ----- WindowsCard.ssc(514,17)
    stack0i := 94;
    // ----- binary operator  ----- WindowsCard.ssc(514,17)
    // ----- branch  ----- WindowsCard.ssc(514,17)
    goto true56984to57222, false56984to57001;

  block57698:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(530,5)
    // ----- branch  ----- WindowsCard.ssc(530,5)
    goto true57698to57681, false57698to57596;

  true57698to57681:
    assume local2 == stack0o;
    goto block57681;

  false57698to57596:
    assume local2 != stack0o;
    goto block57596;

  block57681:
    // ----- load token  ----- WindowsCard.ssc(530,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(530,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(530,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block57630;

  block57596:
    // ----- is instance  ----- WindowsCard.ssc(530,5)
    // ----- branch  ----- WindowsCard.ssc(530,5)
    goto true57596to57681, false57596to57715;

  block57069:
    // ----- copy  ----- WindowsCard.ssc(515,21)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(515,44)
    goto block57409;

  true56984to57222:
    assume local5 == stack0i;
    goto block57222;

  false56984to57001:
    assume local5 != stack0i;
    goto block57001;

  block57222:
    // ----- load constant 0  ----- WindowsCard.ssc(518,23)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(518,23)
    // ----- branch  ----- WindowsCard.ssc(518,23)
    goto true57222to57256, false57222to57239;

  block57001:
    // ----- branch  ----- WindowsCard.ssc(514,17)
    goto block57290;

  true57154to57188:
    assume val >= stack0i;
    goto block57188;

  false57154to57171:
    assume val < stack0i;
    goto block57171;

  block57188:
    // ----- load constant 1  ----- WindowsCard.ssc(517,23)
    stack0b := true;
    goto block57205;

  block57171:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(517,23)
    goto block57205;

  true57596to57681:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block57681;

  false57596to57715:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block57715;

  block57715:
    // ----- branch  ----- WindowsCard.ssc(530,5)
    goto block57630;

  block57409:
    // ----- copy  ----- WindowsCard.ssc(522,9)
    stack0b := takeBranch;
    // ----- unary operator  ----- WindowsCard.ssc(522,9)
    // ----- branch  ----- WindowsCard.ssc(522,9)
    goto true57409to57443, false57409to57426;

  true57409to57443:
    assume !stack0b;
    goto block57443;

  false57409to57426:
    assume stack0b;
    goto block57426;

  block57443:
    // ----- load field  ----- WindowsCard.ssc(525,11)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(525,11)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(525,11)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(525,11)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(525,11)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- nop  ----- WindowsCard.ssc(527,7)
    goto block57460;

  block57426:
    // ----- load field  ----- WindowsCard.ssc(523,11)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(523,11)
    stack0i := stack0i + operand;
    // ----- load constant 1  ----- WindowsCard.ssc(523,11)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(523,11)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(523,11)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(523,11)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(524,11)
    goto block57460;

  block57137:
    // ----- copy  ----- WindowsCard.ssc(516,22)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(516,45)
    goto block57409;

  true57222to57256:
    assume val < stack0i;
    goto block57256;

  false57222to57239:
    assume val >= stack0i;
    goto block57239;

  block57256:
    // ----- load constant 1  ----- WindowsCard.ssc(518,23)
    stack0b := true;
    goto block57273;

  block57239:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(518,23)
    goto block57273;

  block57630:
    // ----- nop  ----- WindowsCard.ssc(530,5)
    // ----- branch
    goto block57545;

  block57290:
    // ----- serialized AssertStatement  ----- WindowsCard.ssc(520,13)
    assert false;
    return;

  block57205:
    // ----- copy  ----- WindowsCard.ssc(517,23)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(517,46)
    goto block57409;

  block57545:
    // ----- return  ----- WindowsCard.ssc(530,5)
    return;

  block57460:
    // ----- branch  ----- WindowsCard.ssc(527,9)
    goto block57494;

  block57273:
    // ----- copy  ----- WindowsCard.ssc(518,23)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(518,45)
    goto block57409;
}



procedure RTE.MOpDUP(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpDUP(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack2i: int;
  var stack0o: ref;
  var temp2: exposeVersionType;
  var stack2o: ref;
  var stack3i: int;
  var stack4i: int;
  var temp3: exposeVersionType;
  var stack0s: struct;

  entry:
    goto block60044;

  block60044:
    goto block60197;

  block60197:
    // ----- nop  ----- WindowsCard.ssc(533,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(535,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(535,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(535,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(535,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(535,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block60214;

  block60214:
    // ----- load field  ----- WindowsCard.ssc(536,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(536,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(536,7)
    // ----- branch  ----- WindowsCard.ssc(536,7)
    goto true60214to60469, false60214to60231;

  true60214to60469:
    assume stack0i == stack1i;
    goto block60469;

  false60214to60231:
    assume stack0i != stack1i;
    goto block60231;

  block60469:
    // ----- load constant 23  ----- WindowsCard.ssc(541,9)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(541,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(543,7)
    goto block60486;

  block60231:
    // ----- load field  ----- WindowsCard.ssc(536,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(536,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(536,7)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(536,7)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(536,7)
    // ----- branch  ----- WindowsCard.ssc(536,7)
    goto true60231to60469, false60231to60248;

  true60231to60469:
    assume stack0i == stack1i;
    goto block60469;

  false60231to60248:
    assume stack0i != stack1i;
    goto block60248;

  block60248:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(537,9)
    assume $Heap[this, RTE.MStackBase] mod 4 == 0 && $Heap[this, RTE.MStackMaxSize] mod 4 == 0 ==> ($Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize]) mod 4 == 0;
    goto block60452;

  block60486:
    // ----- load field  ----- WindowsCard.ssc(543,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(543,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(543,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(543,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(543,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(543,7)
    goto block60690;

  block60452:
    // ----- nop  ----- WindowsCard.ssc(537,16)
    // ----- load field  ----- WindowsCard.ssc(538,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(538,9)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(538,9)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(538,9)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(538,9)
    stack4i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(538,9)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(538,9)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(538,9)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(539,9)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(539,9)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(539,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(539,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(539,9)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(540,9)
    goto block60486;

  block60690:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(543,7)
    // ----- branch  ----- WindowsCard.ssc(543,7)
    goto true60690to60571, false60690to60639;

  true60690to60571:
    assume local2 == stack0o;
    goto block60571;

  false60690to60639:
    assume local2 != stack0o;
    goto block60639;

  block60571:
    // ----- load token  ----- WindowsCard.ssc(544,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(544,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(544,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block60605;

  block60639:
    // ----- is instance  ----- WindowsCard.ssc(543,7)
    // ----- branch  ----- WindowsCard.ssc(543,7)
    goto true60639to60571, false60639to60707;

  true60639to60571:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block60571;

  false60639to60707:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block60707;

  block60707:
    // ----- branch  ----- WindowsCard.ssc(543,7)
    goto block60605;

  block60605:
    // ----- nop  ----- WindowsCard.ssc(544,5)
    // ----- branch
    goto block60537;

  block60537:
    // ----- return  ----- WindowsCard.ssc(544,5)
    return;
}



procedure RTE.MOpPUSH$System.Int32$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32), operandType$in: int where InRange(operandType$in, System.Int32));
  // user-declared preconditions
  requires 0 <= operand$in;
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpPUSH$System.Int32$System.Int32(this: ref, operand$in: int, operandType$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var operandType: int where InRange(operandType, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var local3: int where InRange(local3, System.Int32);
  var stack0i: int;
  var stack0b: bool;
  var stack1i: int;
  var stack2i: int;
  var stack0o: ref;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var address: int where InRange(address, System.Int32);
  var stack0s: struct;
  var stack2o: ref;
  var stack3i: int;
  var temp4: exposeVersionType;

  entry:
    operand := operand$in;
    operandType := operandType$in;
    goto block62934;

  block62934:
    goto block63138;

  block63138:
    // ----- nop  ----- WindowsCard.ssc(548,5)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(550,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(550,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(550,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(550,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(550,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block63155;

  block63155:
    // ----- copy  ----- WindowsCard.ssc(551,15)
    local3 := operandType;
    // ----- load constant 120  ----- WindowsCard.ssc(551,15)
    stack0i := 120;
    // ----- binary operator  ----- WindowsCard.ssc(551,15)
    // ----- branch  ----- WindowsCard.ssc(551,15)
    goto true63155to63206, false63155to63172;

  true63155to63206:
    assume local3 == stack0i;
    goto block63206;

  false63155to63172:
    assume local3 != stack0i;
    goto block63172;

  block63206:
    // ----- load field  ----- WindowsCard.ssc(553,9)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(553,9)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(553,9)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(553,9)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(553,9)
    // ----- branch  ----- WindowsCard.ssc(553,9)
    goto true63206to63444, false63206to63223;

  block63172:
    // ----- load constant 121  ----- WindowsCard.ssc(551,15)
    stack0i := 121;
    // ----- binary operator  ----- WindowsCard.ssc(551,15)
    // ----- branch  ----- WindowsCard.ssc(551,15)
    goto true63172to63478, false63172to63189;

  true63206to63444:
    assume stack0i == stack1i;
    goto block63444;

  false63206to63223:
    assume stack0i != stack1i;
    goto block63223;

  block63444:
    // ----- load constant 23  ----- WindowsCard.ssc(558,11)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(558,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(560,9)
    goto block63461;

  block63223:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(554,11)
    assume $Heap[this, RTE.MStackBase] mod 4 == 0 && $Heap[this, RTE.MStackMaxSize] mod 4 == 0 ==> ($Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize]) mod 4 == 0;
    goto block63427;

  true63172to63478:
    assume local3 == stack0i;
    goto block63478;

  false63172to63189:
    assume local3 != stack0i;
    goto block63189;

  block63478:
    // ----- load field  ----- WindowsCard.ssc(562,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(562,9)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- call  ----- WindowsCard.ssc(562,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(562,9)
    // ----- branch  ----- WindowsCard.ssc(562,9)
    goto true63478to63835, false63478to63495;

  block63189:
    // ----- branch  ----- WindowsCard.ssc(551,15)
    goto block63869;

  true63478to63835:
    assume !stack0b;
    goto block63835;

  false63478to63495:
    assume stack0b;
    goto block63495;

  block63835:
    // ----- load constant 21  ----- WindowsCard.ssc(576,11)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(576,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(578,9)
    goto block63852;

  block63495:
    // ----- load field  ----- WindowsCard.ssc(562,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(562,9)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- load constant 1  ----- WindowsCard.ssc(562,9)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(562,9)
    stack1i := stack1i + stack2i;
    // ----- call  ----- WindowsCard.ssc(562,9)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(562,9)
    // ----- branch  ----- WindowsCard.ssc(562,9)
    goto true63495to63835, false63495to63512;

  block63427:
    // ----- nop  ----- WindowsCard.ssc(554,18)
    // ----- load field  ----- WindowsCard.ssc(555,11)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(555,11)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- copy  ----- WindowsCard.ssc(555,11)
    stack2i := operand;
    // ----- call  ----- WindowsCard.ssc(555,11)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(556,11)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(556,11)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(556,11)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(556,11)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(556,11)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(557,11)
    goto block63461;

  block63461:
    // ----- branch  ----- WindowsCard.ssc(560,9)
    goto block63869;

  true63495to63835:
    assume !stack0b;
    goto block63835;

  false63495to63512:
    assume stack0b;
    goto block63512;

  block63512:
    // ----- call  ----- WindowsCard.ssc(563,15)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := RTE.DP(this);
    // ----- load constant 4  ----- WindowsCard.ssc(563,15)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(563,15)
    stack1i := operand * stack1i;
    // ----- binary operator  ----- WindowsCard.ssc(563,15)
    stack0i := stack0i + stack1i;
    // ----- copy  ----- WindowsCard.ssc(563,15)
    address := stack0i;
    // ----- load constant 4  ----- WindowsCard.ssc(564,11)
    stack0i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(564,11)
    stack0i := address + stack0i;
    // ----- load constant 65536  ----- WindowsCard.ssc(564,11)
    stack1i := 65536;
    // ----- binary operator  ----- WindowsCard.ssc(564,11)
    // ----- branch  ----- WindowsCard.ssc(564,11)
    goto true63512to63801, false63512to63529;

  block63869:
    // ----- load field  ----- WindowsCard.ssc(580,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(580,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(580,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(580,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(580,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(580,7)
    goto block63954;

  block63852:
    // ----- branch  ----- WindowsCard.ssc(578,9)
    goto block63869;

  true63512to63801:
    assume stack0i > stack1i;
    goto block63801;

  false63512to63529:
    assume stack0i <= stack1i;
    goto block63529;

  block63801:
    // ----- load constant 24  ----- WindowsCard.ssc(573,13)
    stack0i := 24;
    // ----- call  ----- WindowsCard.ssc(573,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(575,9)
    goto block63818;

  block63529:
    // ----- load field  ----- WindowsCard.ssc(565,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(565,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(565,13)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(565,13)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(565,13)
    // ----- branch  ----- WindowsCard.ssc(565,13)
    goto true63529to63767, false63529to63546;

  block63954:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(580,7)
    // ----- branch  ----- WindowsCard.ssc(580,7)
    goto true63954to64005, false63954to63988;

  true63954to64005:
    assume local2 == stack0o;
    goto block64005;

  false63954to63988:
    assume local2 != stack0o;
    goto block63988;

  block64005:
    // ----- load token  ----- WindowsCard.ssc(581,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(581,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(581,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block63971;

  block63988:
    // ----- is instance  ----- WindowsCard.ssc(580,7)
    // ----- branch  ----- WindowsCard.ssc(580,7)
    goto true63988to64005, false63988to64090;

  true63529to63767:
    assume stack0i == stack1i;
    goto block63767;

  false63529to63546:
    assume stack0i != stack1i;
    goto block63546;

  block63767:
    // ----- load constant 23  ----- WindowsCard.ssc(570,15)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(570,15)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(572,11)
    goto block63784;

  block63546:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(566,15)
    assume $Heap[this, RTE.MStackBase] mod 4 == 0 && $Heap[this, RTE.MStackMaxSize] mod 4 == 0 ==> ($Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize]) mod 4 == 0;
    goto block63750;

  true63988to64005:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block64005;

  false63988to64090:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block64090;

  block64090:
    // ----- branch  ----- WindowsCard.ssc(580,7)
    goto block63971;

  block63818:
    // ----- branch  ----- WindowsCard.ssc(575,11)
    goto block63852;

  block63971:
    // ----- nop  ----- WindowsCard.ssc(581,5)
    // ----- branch
    goto block63920;

  block63750:
    // ----- nop  ----- WindowsCard.ssc(566,22)
    // ----- load field  ----- WindowsCard.ssc(567,15)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(567,15)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(567,15)
    assert this != null;
    stack2o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(567,15)
    stack3i := address;
    // ----- call  ----- WindowsCard.ssc(567,15)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(567,15)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(568,15)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(568,15)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(568,15)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(568,15)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp4;
    $Heap[this, $exposeVersion] := temp4;
    // ----- frame condition  ----- WindowsCard.ssc(568,15)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(569,15)
    goto block63784;

  block63784:
    // ----- branch  ----- WindowsCard.ssc(572,13)
    goto block63818;

  block63920:
    // ----- return  ----- WindowsCard.ssc(581,5)
    return;
}



procedure RTE.MOpSWAP(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpSWAP(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var temp2: exposeVersionType;
  var stack0o: ref;
  var stack2i: int;
  var stack2o: ref;
  var stack3i: int;
  var stack4i: int;
  var stack0s: struct;

  entry:
    goto block66555;

  block66555:
    goto block66708;

  block66708:
    // ----- nop  ----- WindowsCard.ssc(584,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(586,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(586,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(586,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(586,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(586,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block66725;

  block66725:
    // ----- load field  ----- WindowsCard.ssc(587,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(587,7)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(587,7)
    stack0i := stack0i - stack1i;
    // ----- load field  ----- WindowsCard.ssc(587,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(587,7)
    // ----- branch  ----- WindowsCard.ssc(587,7)
    goto true66725to66861, false66725to66742;

  true66725to66861:
    assume stack0i == stack1i;
    goto block66861;

  false66725to66742:
    assume stack0i != stack1i;
    goto block66742;

  block66861:
    // ----- load constant 23  ----- WindowsCard.ssc(592,9)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(592,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(594,7)
    goto block66878;

  block66742:
    // ----- load field  ----- WindowsCard.ssc(587,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(587,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(587,7)
    // ----- branch  ----- WindowsCard.ssc(587,7)
    goto true66742to66861, false66742to66759;

  true66742to66861:
    assume stack0i == stack1i;
    goto block66861;

  false66742to66759:
    assume stack0i != stack1i;
    goto block66759;

  block66759:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(588,9)
    assume 0 <= $Heap[this, RTE.MSP] - 8;
    goto block66844;

  block66878:
    // ----- load field  ----- WindowsCard.ssc(594,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(594,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(594,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(594,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(594,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(594,7)
    goto block66980;

  block66980:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(594,7)
    // ----- branch  ----- WindowsCard.ssc(594,7)
    goto true66980to66963, false66980to67048;

  true66980to66963:
    assume local2 == stack0o;
    goto block66963;

  false66980to67048:
    assume local2 != stack0o;
    goto block67048;

  block66963:
    // ----- load token  ----- WindowsCard.ssc(595,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(595,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(595,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block66997;

  block67048:
    // ----- is instance  ----- WindowsCard.ssc(594,7)
    // ----- branch  ----- WindowsCard.ssc(594,7)
    goto true67048to66963, false67048to67031;

  block66844:
    // ----- nop  ----- WindowsCard.ssc(588,16)
    // ----- load field  ----- WindowsCard.ssc(589,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(589,9)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(589,9)
    stack2i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(589,9)
    stack1i := stack1i - stack2i;
    // ----- load field  ----- WindowsCard.ssc(589,9)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(589,9)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(589,9)
    stack4i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(589,9)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(589,9)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(589,9)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(590,9)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(590,9)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(590,9)
    stack2i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(590,9)
    stack1i := stack1i - stack2i;
    // ----- load field  ----- WindowsCard.ssc(590,9)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(590,9)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(590,9)
    stack4i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(590,9)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(590,9)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(590,9)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- branch  ----- WindowsCard.ssc(591,9)
    goto block66878;

  true67048to66963:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block66963;

  false67048to67031:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block67031;

  block67031:
    // ----- branch  ----- WindowsCard.ssc(594,7)
    goto block66997;

  block66997:
    // ----- nop  ----- WindowsCard.ssc(595,5)
    // ----- branch
    goto block66929;

  block66929:
    // ----- return  ----- WindowsCard.ssc(595,5)
    return;
}



procedure RTE.MOpPOP$System.Int32(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated], operand$in: int where InRange(operand$in, System.Int32));
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpPOP$System.Int32(this: ref, operand$in: int)
{
  var operand: int where InRange(operand, System.Int32);
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0o: ref;
  var stack1i: int;
  var stack0b: bool;
  var stack0i: int;
  var stack2i: int;
  var address: int where InRange(address, System.Int32);
  var stack0s: struct;
  var temp2: exposeVersionType;
  var stack2o: ref;
  var stack3i: int;
  var stack4i: int;
  var temp3: exposeVersionType;

  entry:
    operand := operand$in;
    goto block68850;

  block68850:
    goto block69003;

  block69003:
    // ----- nop  ----- WindowsCard.ssc(598,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(600,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(600,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(600,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(600,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(600,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block69020;

  block69020:
    // ----- load field  ----- WindowsCard.ssc(601,7)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(601,7)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- call  ----- WindowsCard.ssc(601,7)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(601,7)
    // ----- branch  ----- WindowsCard.ssc(601,7)
    goto true69020to69190, false69020to69037;

  true69020to69190:
    assume !stack0b;
    goto block69190;

  false69020to69037:
    assume stack0b;
    goto block69037;

  block69190:
    // ----- load constant 21  ----- WindowsCard.ssc(615,9)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(615,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(617,5)
    goto block69207;

  block69037:
    // ----- load field  ----- WindowsCard.ssc(601,7)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(601,7)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- load constant 1  ----- WindowsCard.ssc(601,7)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(601,7)
    stack1i := stack1i + stack2i;
    // ----- call  ----- WindowsCard.ssc(601,7)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(601,7)
    // ----- branch  ----- WindowsCard.ssc(601,7)
    goto true69037to69190, false69037to69054;

  true69037to69190:
    assume !stack0b;
    goto block69190;

  false69037to69054:
    assume stack0b;
    goto block69054;

  block69054:
    // ----- call  ----- WindowsCard.ssc(602,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := RTE.DP(this);
    // ----- load constant 4  ----- WindowsCard.ssc(602,13)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(602,13)
    stack1i := operand * stack1i;
    // ----- binary operator  ----- WindowsCard.ssc(602,13)
    stack0i := stack0i + stack1i;
    // ----- load constant 4  ----- WindowsCard.ssc(602,13)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(602,13)
    stack0i := stack0i + stack1i;
    // ----- copy  ----- WindowsCard.ssc(602,13)
    address := stack0i;
    // ----- load constant 0  ----- WindowsCard.ssc(603,9)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(603,9)
    // ----- branch  ----- WindowsCard.ssc(603,9)
    goto true69054to69156, false69054to69071;

  block69207:
    // ----- branch  ----- WindowsCard.ssc(617,5)
    goto block69411;

  true69054to69156:
    assume stack0i > address;
    goto block69156;

  false69054to69071:
    assume stack0i <= address;
    goto block69071;

  block69156:
    // ----- load constant 24  ----- WindowsCard.ssc(611,11)
    stack0i := 24;
    // ----- call  ----- WindowsCard.ssc(611,11)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(613,9)
    goto block69173;

  block69071:
    // ----- load constant 65532  ----- WindowsCard.ssc(603,9)
    stack0i := 65532;
    // ----- binary operator  ----- WindowsCard.ssc(603,9)
    // ----- branch  ----- WindowsCard.ssc(603,9)
    goto true69071to69156, false69071to69088;

  block69411:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(617,5)
    // ----- branch  ----- WindowsCard.ssc(617,5)
    goto true69411to69309, false69411to69394;

  true69411to69309:
    assume local2 == stack0o;
    goto block69309;

  false69411to69394:
    assume local2 != stack0o;
    goto block69394;

  block69309:
    // ----- load token  ----- WindowsCard.ssc(617,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(617,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(617,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block69377;

  block69394:
    // ----- is instance  ----- WindowsCard.ssc(617,5)
    // ----- branch  ----- WindowsCard.ssc(617,5)
    goto true69394to69309, false69394to69343;

  true69071to69156:
    assume address >= stack0i;
    goto block69156;

  false69071to69088:
    assume address < stack0i;
    goto block69088;

  block69088:
    // ----- load field  ----- WindowsCard.ssc(604,11)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(604,11)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(604,11)
    // ----- branch  ----- WindowsCard.ssc(604,11)
    goto true69088to69122, false69088to69105;

  true69394to69309:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block69309;

  false69394to69343:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block69343;

  block69343:
    // ----- branch  ----- WindowsCard.ssc(617,5)
    goto block69377;

  block69173:
    // ----- load field  ----- WindowsCard.ssc(613,9)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 2  ----- WindowsCard.ssc(613,9)
    stack1i := 2;
    // ----- binary operator  ----- WindowsCard.ssc(613,9)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(613,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(613,9)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(614,9)
    goto block69207;

  true69088to69122:
    assume stack0i == stack1i;
    goto block69122;

  false69088to69105:
    assume stack0i != stack1i;
    goto block69105;

  block69122:
    // ----- load constant 23  ----- WindowsCard.ssc(608,13)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(608,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(610,9)
    goto block69139;

  block69105:
    // ----- load field  ----- WindowsCard.ssc(605,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(605,13)
    stack1i := address;
    // ----- load field  ----- WindowsCard.ssc(605,13)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(605,13)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(605,13)
    stack4i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(605,13)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(605,13)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(605,13)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(606,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(606,13)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(606,13)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(606,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(606,13)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(607,13)
    goto block69139;

  block69377:
    // ----- nop  ----- WindowsCard.ssc(617,5)
    // ----- branch
    goto block69258;

  block69258:
    // ----- return  ----- WindowsCard.ssc(617,5)
    return;

  block69139:
    // ----- branch  ----- WindowsCard.ssc(610,11)
    goto block69173;
}



procedure RTE.MOpPOPA(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpPOPA(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var temp2: exposeVersionType;
  var stack1i: int;
  var temp3: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    goto block71162;

  block71162:
    goto block71315;

  block71315:
    // ----- nop  ----- WindowsCard.ssc(620,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(622,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(622,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(622,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(622,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(622,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block71332;

  block71332:
    // ----- load field  ----- WindowsCard.ssc(623,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MStackBase];
    // ----- store field  ----- WindowsCard.ssc(623,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(623,7)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(624,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(624,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(624,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(624,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(624,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(624,7)
    goto block71485;

  block71485:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(624,7)
    // ----- branch  ----- WindowsCard.ssc(624,7)
    goto true71485to71417, false71485to71519;

  true71485to71417:
    assume local2 == stack0o;
    goto block71417;

  false71485to71519:
    assume local2 != stack0o;
    goto block71519;

  block71417:
    // ----- load token  ----- WindowsCard.ssc(625,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(625,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(625,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block71434;

  block71519:
    // ----- is instance  ----- WindowsCard.ssc(624,7)
    // ----- branch  ----- WindowsCard.ssc(624,7)
    goto true71519to71417, false71519to71451;

  true71519to71417:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block71417;

  false71519to71451:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block71451;

  block71451:
    // ----- branch  ----- WindowsCard.ssc(624,7)
    goto block71434;

  block71434:
    // ----- nop  ----- WindowsCard.ssc(625,5)
    // ----- branch
    goto block71383;

  block71383:
    // ----- return  ----- WindowsCard.ssc(625,5)
    return;
}



procedure RTE.MOpPOP1(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpPOP1(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var temp2: exposeVersionType;
  var temp3: exposeVersionType;
  var stack0o: ref;
  var stack0s: struct;

  entry:
    goto block72573;

  block72573:
    goto block72726;

  block72726:
    // ----- nop  ----- WindowsCard.ssc(628,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(630,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(630,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(630,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(630,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(630,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block72743;

  block72743:
    // ----- load field  ----- WindowsCard.ssc(631,7)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(631,7)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(631,7)
    // ----- branch  ----- WindowsCard.ssc(631,7)
    goto true72743to72777, false72743to72760;

  true72743to72777:
    assume stack0i == stack1i;
    goto block72777;

  false72743to72760:
    assume stack0i != stack1i;
    goto block72760;

  block72777:
    // ----- load constant 23  ----- WindowsCard.ssc(634,9)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(634,9)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(636,7)
    goto block72794;

  block72760:
    // ----- load field  ----- WindowsCard.ssc(632,9)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(632,9)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(632,9)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(632,9)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(632,9)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(633,9)
    goto block72794;

  block72794:
    // ----- load field  ----- WindowsCard.ssc(636,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(636,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(636,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(636,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(636,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(636,7)
    goto block72896;

  block72896:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(636,7)
    // ----- branch  ----- WindowsCard.ssc(636,7)
    goto true72896to72947, false72896to72879;

  true72896to72947:
    assume local2 == stack0o;
    goto block72947;

  false72896to72879:
    assume local2 != stack0o;
    goto block72879;

  block72947:
    // ----- load token  ----- WindowsCard.ssc(637,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(637,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(637,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block72964;

  block72879:
    // ----- is instance  ----- WindowsCard.ssc(636,7)
    // ----- branch  ----- WindowsCard.ssc(636,7)
    goto true72879to72947, false72879to72913;

  true72879to72947:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block72947;

  false72879to72913:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block72913;

  block72913:
    // ----- branch  ----- WindowsCard.ssc(636,7)
    goto block72964;

  block72964:
    // ----- nop  ----- WindowsCard.ssc(637,5)
    // ----- branch
    goto block72845;

  block72845:
    // ----- return  ----- WindowsCard.ssc(637,5)
    return;
}



procedure RTE.MOpNOP(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpNOP(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var temp2: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    goto block74120;

  block74120:
    goto block74273;

  block74273:
    // ----- nop  ----- WindowsCard.ssc(640,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(642,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(642,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(642,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(642,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(642,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block74290;

  block74290:
    // ----- load field  ----- WindowsCard.ssc(643,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(643,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(643,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(643,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(643,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(643,7)
    goto block74477;

  block74477:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(643,7)
    // ----- branch  ----- WindowsCard.ssc(643,7)
    goto true74477to74460, false74477to74494;

  true74477to74460:
    assume local2 == stack0o;
    goto block74460;

  false74477to74494:
    assume local2 != stack0o;
    goto block74494;

  block74460:
    // ----- load token  ----- WindowsCard.ssc(644,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(644,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(644,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block74426;

  block74494:
    // ----- is instance  ----- WindowsCard.ssc(643,7)
    // ----- branch  ----- WindowsCard.ssc(643,7)
    goto true74494to74460, false74494to74375;

  true74494to74460:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block74460;

  false74494to74375:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block74375;

  block74375:
    // ----- branch  ----- WindowsCard.ssc(643,7)
    goto block74426;

  block74426:
    // ----- nop  ----- WindowsCard.ssc(644,5)
    // ----- branch
    goto block74341;

  block74341:
    // ----- return  ----- WindowsCard.ssc(644,5)
    return;
}



procedure RTE.MOpEND(this: ref where $IsNotNull(this, RTE) && $Heap[this, $allocated]);
  // target object is peer consistent
  requires (forall $pc: ref :: { $typeof($pc) } { $Heap[$pc, $localinv] } { $Heap[$pc, $inv] } { $Heap[$pc, $ownerFrame] } { $Heap[$pc, $ownerRef] } $pc != null && $Heap[$pc, $allocated] && $Heap[$pc, $ownerRef] == $Heap[this, $ownerRef] && $Heap[$pc, $ownerFrame] == $Heap[this, $ownerFrame] ==> $Heap[$pc, $inv] == $typeof($pc) && $Heap[$pc, $localinv] == $typeof($pc));
  // target object is peer consistent (owner must not be valid)
  requires $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.MOpEND(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var temp2: exposeVersionType;
  var stack1i: int;
  var temp3: exposeVersionType;
  var stack0o: ref;
  var stack0b: bool;
  var stack0s: struct;

  entry:
    goto block75446;

  block75446:
    goto block75599;

  block75599:
    // ----- nop  ----- WindowsCard.ssc(647,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(649,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(649,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(649,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(649,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(649,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block75616;

  block75616:
    // ----- load constant 10  ----- WindowsCard.ssc(650,7)
    stack0i := 10;
    // ----- store field  ----- WindowsCard.ssc(650,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(650,7)
    assert !(IncludeInMainFrameCondition(RTE.CurrRTEMode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CurrRTEMode)) || !$IncludedInModifiesStar(RTE.CurrRTEMode)) && true);
    $Heap[this, RTE.CurrRTEMode] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(651,7)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(651,7)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(651,7)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(651,7)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(651,7)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(651,7)
    goto block75820;

  block75820:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(651,7)
    // ----- branch  ----- WindowsCard.ssc(651,7)
    goto true75820to75803, false75820to75786;

  true75820to75803:
    assume local2 == stack0o;
    goto block75803;

  false75820to75786:
    assume local2 != stack0o;
    goto block75786;

  block75803:
    // ----- load token  ----- WindowsCard.ssc(652,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(652,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(652,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block75769;

  block75786:
    // ----- is instance  ----- WindowsCard.ssc(651,7)
    // ----- branch  ----- WindowsCard.ssc(651,7)
    goto true75786to75803, false75786to75735;

  true75786to75803:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block75803;

  false75786to75735:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block75735;

  block75735:
    // ----- branch  ----- WindowsCard.ssc(651,7)
    goto block75769;

  block75769:
    // ----- nop  ----- WindowsCard.ssc(652,5)
    // ----- branch
    goto block75667;

  block75667:
    // ----- return  ----- WindowsCard.ssc(652,5)
    return;
}



implementation RTE.ExecuteInstruction(this: ref)
{
  var temp0: ref;
  var stack1s: struct;
  var stack1o: ref;
  var temp1: exposeVersionType;
  var local2: ref where $Is(local2, System.Exception) && $Heap[local2, $allocated];
  var stack0i: int;
  var stack1i: int;
  var stack0b: bool;
  var stack0o: ref;
  var stack0s: struct;
  var currInstr: int where InRange(currInstr, System.Int32);
  var opcd: int where InRange(opcd, System.Int32);
  var oprnd: int where InRange(oprnd, System.Int32);
  var oprndType: int where InRange(oprndType, System.Int32);
  var local7: int where InRange(local7, System.Int32);
  var stack2i: int;
  var temp2: exposeVersionType;
  var local8: int where InRange(local8, System.Int32);
  var temp3: exposeVersionType;
  var temp4: exposeVersionType;
  var temp5: exposeVersionType;
  var temp6: exposeVersionType;
  var temp7: exposeVersionType;
  var temp8: exposeVersionType;
  var stack2o: ref;
  var stack3i: int;
  var stack1b: bool;
  var temp9: exposeVersionType;
  var temp10: exposeVersionType;
  var temp11: exposeVersionType;
  var temp12: exposeVersionType;
  var local10: int where InRange(local10, System.Int32);
  var temp13: exposeVersionType;
  var temp14: exposeVersionType;
  var takeBranch: bool where true;
  var temp15: exposeVersionType;
  var temp16: exposeVersionType;
  var temp17: exposeVersionType;
  var temp18: exposeVersionType;
  var temp19: exposeVersionType;
  var temp20: exposeVersionType;
  var temp21: exposeVersionType;
  var temp22: exposeVersionType;
  var temp23: exposeVersionType;
  var stack3o: ref;
  var stack4i: int;
  var stack5i: int;
  var temp24: exposeVersionType;
  var stack4o: ref;
  var stack6i: int;
  var temp25: exposeVersionType;
  var temp26: exposeVersionType;
  var temp27: exposeVersionType;
  var temp28: exposeVersionType;
  var temp29: exposeVersionType;
  var temp30: exposeVersionType;
  var val: int where InRange(val, System.Int32);
  var local15: int where InRange(local15, System.Int32);
  var takeBranch2: bool where true;
  var local18: int where InRange(local18, System.Int32);
  var temp31: exposeVersionType;
  var temp32: exposeVersionType;
  var temp33: exposeVersionType;
  var temp34: exposeVersionType;
  var temp35: exposeVersionType;
  var temp36: exposeVersionType;
  var temp37: exposeVersionType;
  var temp38: exposeVersionType;
  var temp39: exposeVersionType;
  var address: int where InRange(address, System.Int32);
  var temp40: exposeVersionType;
  var temp41: exposeVersionType;
  var temp42: exposeVersionType;
  var temp43: exposeVersionType;
  var temp44: exposeVersionType;
  var temp45: exposeVersionType;
  var temp46: exposeVersionType;
  var temp47: exposeVersionType;

  entry:
    goto block81430;

  block81430:
    goto block81583;

  block81583:
    // ----- nop  ----- WindowsCard.ssc(655,8)
    // ----- FrameGuard processing  ----- WindowsCard.ssc(657,13)
    temp0 := this;
    // ----- load token  ----- WindowsCard.ssc(657,13)
    havoc stack1s;
    assume $IsTokenForType(stack1s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(657,13)
    stack1o := TypeObject(RTE);
    // ----- local unpack  ----- WindowsCard.ssc(657,13)
    assert temp0 != null;
    assert ($Heap[temp0, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[temp0, $ownerRef], $inv] <: $Heap[temp0, $ownerFrame]) || $Heap[$Heap[temp0, $ownerRef], $localinv] == $BaseClass($Heap[temp0, $ownerFrame])) && $Heap[temp0, $inv] <: RTE && $Heap[temp0, $localinv] == $typeof(temp0);
    $Heap[temp0, $localinv] := System.Object;
    havoc temp1;
    // ----- frame condition  ----- WindowsCard.ssc(657,13)
    assert !(IncludeInMainFrameCondition($exposeVersion) && old($Heap)[temp0, $allocated] && (old($Heap)[temp0, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[temp0, $ownerRef], $inv] <: old($Heap)[temp0, $ownerFrame]) || old($Heap)[old($Heap)[temp0, $ownerRef], $localinv] == $BaseClass(old($Heap)[temp0, $ownerFrame])) && (temp0 != old(this) || !($typeof(old(this)) <: DeclType($exposeVersion)) || !$IncludedInModifiesStar($exposeVersion)) && true);
    $Heap[temp0, $exposeVersion] := temp1;
    assume IsHeap($Heap);
    local2 := null;
    goto block81600;

  block81600:
    // ----- load constant 0  ----- WindowsCard.ssc(658,9)
    stack0i := 0;
    // ----- load field  ----- WindowsCard.ssc(658,9)
    assert this != null;
    stack1i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(658,9)
    // ----- branch  ----- WindowsCard.ssc(658,9)
    goto true81600to81634, false81600to81617;

  true81600to81634:
    assume stack0i <= stack1i;
    goto block81634;

  false81600to81617:
    assume stack0i > stack1i;
    goto block81617;

  block81634:
    // ----- load constant 1  ----- WindowsCard.ssc(658,9)
    stack0b := true;
    goto block81651;

  block81617:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(658,9)
    goto block81651;

  block81651:
    // ----- branch (no expression improvement)  ----- WindowsCard.ssc(658,9)
    goto true81651to81685, false81651to81668;

  true81651to81685:
    assume stack0b;
    goto block81685;

  false81651to81668:
    assume !stack0b;
    goto block81668;

  block81685:
    // ----- load constant 0  ----- WindowsCard.ssc(658,9)
    stack0b := false;
    goto block81702;

  block81668:
    // ----- load constant 1
    stack0b := true;
    // ----- branch  ----- WindowsCard.ssc(658,9)
    goto block81702;

  block81702:
    // ----- branch (no expression improvement)  ----- WindowsCard.ssc(658,9)
    goto true81702to81855, false81702to81719;

  true81702to81855:
    assume stack0b;
    goto block81855;

  false81702to81719:
    assume !stack0b;
    goto block81719;

  block81855:
    // ----- load constant 25  ----- WindowsCard.ssc(659,13)
    stack0i := 25;
    // ----- call  ----- WindowsCard.ssc(659,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- branch  ----- WindowsCard.ssc(660,13)
    goto block86462;

  block81719:
    // ----- load field  ----- WindowsCard.ssc(658,9)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load field  ----- WindowsCard.ssc(658,9)
    assert this != null;
    stack1o := $Heap[this, RTE.Instructions];
    // ----- unary operator  ----- WindowsCard.ssc(658,9)
    assert stack1o != null;
    stack1i := $Length(stack1o);
    // ----- unary operator  ----- WindowsCard.ssc(658,9)
    stack1i := $IntToInt(stack1i, System.UIntPtr, System.Int32);
    // ----- binary operator  ----- WindowsCard.ssc(658,9)
    // ----- branch  ----- WindowsCard.ssc(658,9)
    goto true81719to81753, false81719to81736;

  true81719to81753:
    assume stack0i < stack1i;
    goto block81753;

  false81719to81736:
    assume stack0i >= stack1i;
    goto block81736;

  block81753:
    // ----- load constant 1  ----- WindowsCard.ssc(658,9)
    stack0b := true;
    goto block81770;

  block81736:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(658,9)
    goto block81770;

  block86462:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(926,13)
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto true86462to86581, false86462to86394;

  true86462to86581:
    assume local2 == stack0o;
    goto block86581;

  false86462to86394:
    assume local2 != stack0o;
    goto block86394;

  block86581:
    // ----- load token  ----- WindowsCard.ssc(928,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(928,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(928,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block86632;

  block86394:
    // ----- is instance  ----- WindowsCard.ssc(926,13)
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto true86394to86581, false86394to86445;

  block81770:
    // ----- branch (no expression improvement)  ----- WindowsCard.ssc(658,9)
    goto true81770to81804, false81770to81787;

  true81770to81804:
    assume stack0b;
    goto block81804;

  false81770to81787:
    assume !stack0b;
    goto block81787;

  block81804:
    // ----- load constant 0  ----- WindowsCard.ssc(658,9)
    stack0b := false;
    goto block81821;

  block81787:
    // ----- load constant 1
    stack0b := true;
    // ----- branch  ----- WindowsCard.ssc(658,9)
    goto block81821;

  true86394to86581:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block86581;

  false86394to86445:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block86445;

  block86445:
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto block86632;

  block86632:
    // ----- nop  ----- WindowsCard.ssc(928,5)
    // ----- branch
    goto block86275;

  block81821:
    // ----- branch (no expression improvement)  ----- WindowsCard.ssc(658,9)
    goto true81821to81855, false81821to81838;

  true81821to81855:
    assume stack0b;
    goto block81855;

  false81821to81838:
    assume !stack0b;
    goto block81838;

  block81838:
    // ----- branch  ----- WindowsCard.ssc(658,9)
    goto block81872;

  block86275:
    // ----- return  ----- WindowsCard.ssc(928,5)
    return;

  block81872:
    // ----- load field  ----- WindowsCard.ssc(663,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Instructions];
    // ----- load field  ----- WindowsCard.ssc(663,13)
    assert this != null;
    stack1i := $Heap[this, RTE.PC];
    // ----- load element  ----- WindowsCard.ssc(663,13)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    currInstr := ArrayGet($Heap[stack0o, $elementsInt], stack1i);
    // ----- copy  ----- WindowsCard.ssc(664,13)
    opcd := currInstr;
    // ----- load constant 0  ----- WindowsCard.ssc(665,13)
    oprnd := 0;
    // ----- copy  ----- WindowsCard.ssc(666,13)
    stack0i := currInstr;
    // ----- call  ----- WindowsCard.ssc(666,13)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call oprndType := RTE.DecodeOperandType$System.Int32(stack0i);
    // ----- copy  ----- WindowsCard.ssc(667,18)
    local7 := currInstr;
    // ----- load constant 30  ----- WindowsCard.ssc(667,18)
    stack0i := 30;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81872to82586, false81872to81889;

  true81872to82586:
    assume local7 == stack0i;
    goto block82586;

  false81872to81889:
    assume local7 != stack0i;
    goto block81889;

  block82586:
    // ----- copy  ----- WindowsCard.ssc(673,13)
    stack0i := opcd;
    // ----- copy  ----- WindowsCard.ssc(673,13)
    stack1i := oprndType;
    // ----- copy  ----- WindowsCard.ssc(673,13)
    stack2i := oprnd;
    // ----- call  ----- WindowsCard.ssc(673,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.A) && ($o != this || $f != RTE.Z) && ($o != this || $f != RTE.C) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.ApplyALU$System.Int32$System.Int32$System.Int32(this, stack0i, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(674,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(674,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(674,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(674,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp2;
    $Heap[this, $exposeVersion] := temp2;
    // ----- frame condition  ----- WindowsCard.ssc(674,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(675,13)
    goto block86224;

  block81889:
    // ----- load constant 31  ----- WindowsCard.ssc(667,18)
    stack0i := 31;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81889to82586, false81889to81906;

  true81889to82586:
    assume local7 == stack0i;
    goto block82586;

  false81889to81906:
    assume local7 != stack0i;
    goto block81906;

  block81906:
    // ----- load constant 32  ----- WindowsCard.ssc(667,18)
    stack0i := 32;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81906to82586, false81906to81923;

  true81906to82586:
    assume local7 == stack0i;
    goto block82586;

  false81906to81923:
    assume local7 != stack0i;
    goto block81923;

  block81923:
    // ----- load constant 33  ----- WindowsCard.ssc(667,18)
    stack0i := 33;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81923to82586, false81923to81940;

  block86224:
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto block86326;

  true81923to82586:
    assume local7 == stack0i;
    goto block82586;

  false81923to81940:
    assume local7 != stack0i;
    goto block81940;

  block81940:
    // ----- load constant 34  ----- WindowsCard.ssc(667,18)
    stack0i := 34;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81940to82586, false81940to81957;

  block86326:
    stack0o := null;
    // ----- binary operator  ----- WindowsCard.ssc(926,13)
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto true86326to86377, false86326to86360;

  true86326to86377:
    assume local2 == stack0o;
    goto block86377;

  false86326to86360:
    assume local2 != stack0o;
    goto block86360;

  block86377:
    // ----- load token  ----- WindowsCard.ssc(928,5)
    havoc stack0s;
    assume $IsTokenForType(stack0s, RTE);
    // ----- statically resolved GetTypeFromHandle call  ----- WindowsCard.ssc(928,5)
    stack0o := TypeObject(RTE);
    // ----- local pack  ----- WindowsCard.ssc(928,5)
    assert temp0 != null;
    assert $Heap[temp0, $localinv] == System.Object;
    assert 65536 == $Length($Heap[$Heap[temp0, RTE.Data], Memory.contents]);
    assert $Length($Heap[temp0, RTE.CallStack]) == 10;
    assert 0 <= $Heap[temp0, RTE.CSP];
    assert $Heap[temp0, RTE.CSP] <= 10;
    assert $Heap[temp0, RTE.MStackBase] <= $Heap[temp0, RTE.MSP];
    assert $Heap[temp0, RTE.MSP] <= $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.MSP] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackMaxSize] mod 4 == 0;
    assert $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize] <= $Length($Heap[$Heap[temp0, RTE.Scratch], Memory.contents]);
    assert 0 <= $Heap[temp0, RTE.MStackBase];
    assert 0 <= $Heap[temp0, RTE.MStackMaxSize];
    assert $Heap[temp0, RTE.DPP] == $Heap[temp0, RTE.MStackBase] + $Heap[temp0, RTE.MStackMaxSize];
    assert (forall $p: ref :: $p != null && $Heap[$p, $allocated] && $Heap[$p, $ownerRef] == temp0 && $Heap[$p, $ownerFrame] == RTE ==> $Heap[$p, $inv] == $typeof($p) && $Heap[$p, $localinv] == $typeof($p));
    $Heap[temp0, $localinv] := $typeof(temp0);
    assume IsHeap($Heap);
    goto block86598;

  block86360:
    // ----- is instance  ----- WindowsCard.ssc(926,13)
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto true86360to86377, false86360to86547;

  true81940to82586:
    assume local7 == stack0i;
    goto block82586;

  false81940to81957:
    assume local7 != stack0i;
    goto block81957;

  block81957:
    // ----- load constant 40  ----- WindowsCard.ssc(667,18)
    stack0i := 40;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81957to82603, false81957to81974;

  true86360to86377:
    assume $As(local2, Microsoft.Contracts.ICheckedException) != null;
    goto block86377;

  false86360to86547:
    assume $As(local2, Microsoft.Contracts.ICheckedException) == null;
    goto block86547;

  block86547:
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto block86598;

  true81957to82603:
    assume local7 == stack0i;
    goto block82603;

  false81957to81974:
    assume local7 != stack0i;
    goto block81974;

  block82603:
    // ----- copy  ----- WindowsCard.ssc(677,21)
    local8 := oprndType;
    // ----- load constant 120  ----- WindowsCard.ssc(677,21)
    stack0i := 120;
    // ----- binary operator  ----- WindowsCard.ssc(677,21)
    // ----- branch  ----- WindowsCard.ssc(677,21)
    goto true82603to82654, false82603to82620;

  block81974:
    // ----- load constant 41  ----- WindowsCard.ssc(667,18)
    stack0i := 41;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81974to82705, false81974to81991;

  block86598:
    // ----- nop  ----- WindowsCard.ssc(928,5)
    // ----- branch
    goto block86275;

  true81974to82705:
    assume local7 == stack0i;
    goto block82705;

  false81974to81991:
    assume local7 != stack0i;
    goto block81991;

  block82705:
    // ----- load field  ----- WindowsCard.ssc(688,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Program];
    // ----- load field  ----- WindowsCard.ssc(688,13)
    assert this != null;
    stack1i := $Heap[this, RTE.PC];
    // ----- load field  ----- WindowsCard.ssc(688,13)
    assert this != null;
    stack2i := $Heap[this, RTE.A];
    // ----- binary operator  ----- WindowsCard.ssc(688,13)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(688,13)
    stack1i := stack1i + oprnd;
    // ----- call  ----- WindowsCard.ssc(688,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(688,13)
    // ----- branch  ----- WindowsCard.ssc(688,13)
    goto true82705to82739, false82705to82722;

  block81991:
    // ----- load constant 60  ----- WindowsCard.ssc(667,18)
    stack0i := 60;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true81991to82773, false81991to82008;

  true82603to82654:
    assume local8 == stack0i;
    goto block82654;

  false82603to82620:
    assume local8 != stack0i;
    goto block82620;

  block82654:
    // ----- store field  ----- WindowsCard.ssc(679,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp3;
    $Heap[this, $exposeVersion] := temp3;
    // ----- frame condition  ----- WindowsCard.ssc(679,17)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.A)) || !$IncludedInModifiesStar(RTE.A)) && true);
    $Heap[this, RTE.A] := oprnd;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(680,17)
    goto block82688;

  block82620:
    // ----- load constant 121  ----- WindowsCard.ssc(677,21)
    stack0i := 121;
    // ----- binary operator  ----- WindowsCard.ssc(677,21)
    // ----- branch  ----- WindowsCard.ssc(677,21)
    goto true82620to82671, false82620to82637;

  true82705to82739:
    assume !stack0b;
    goto block82739;

  false82705to82722:
    assume stack0b;
    goto block82722;

  block82739:
    // ----- load constant 25  ----- WindowsCard.ssc(691,17)
    stack0i := 25;
    // ----- call  ----- WindowsCard.ssc(691,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(693,13)
    goto block82756;

  block82722:
    // ----- load field  ----- WindowsCard.ssc(689,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Program];
    // ----- load field  ----- WindowsCard.ssc(689,17)
    assert this != null;
    stack1i := $Heap[this, RTE.PC];
    // ----- load field  ----- WindowsCard.ssc(689,17)
    assert this != null;
    stack2i := $Heap[this, RTE.A];
    // ----- binary operator  ----- WindowsCard.ssc(689,17)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(689,17)
    stack1i := stack1i + oprnd;
    // ----- call  ----- WindowsCard.ssc(689,17)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := Memory.get_cont$System.Int32(stack0o, stack1i);
    // ----- store field  ----- WindowsCard.ssc(689,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp4;
    $Heap[this, $exposeVersion] := temp4;
    // ----- frame condition  ----- WindowsCard.ssc(689,17)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.A)) || !$IncludedInModifiesStar(RTE.A)) && true);
    $Heap[this, RTE.A] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(690,15)
    goto block82756;

  true81991to82773:
    assume local7 == stack0i;
    goto block82773;

  false81991to82008:
    assume local7 != stack0i;
    goto block82008;

  block82773:
    // ----- load field  ----- WindowsCard.ssc(696,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(696,13)
    stack1i := oprnd;
    // ----- call  ----- WindowsCard.ssc(696,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(696,13)
    // ----- branch  ----- WindowsCard.ssc(696,13)
    goto true82773to82807, false82773to82790;

  block82008:
    // ----- load constant 61  ----- WindowsCard.ssc(667,18)
    stack0i := 61;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82008to82841, false82008to82025;

  true82620to82671:
    assume local8 == stack0i;
    goto block82671;

  false82620to82637:
    assume local8 != stack0i;
    goto block82637;

  block82671:
    // ----- load field  ----- WindowsCard.ssc(682,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(682,17)
    stack1i := oprnd;
    // ----- call  ----- WindowsCard.ssc(682,17)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := Memory.get_cont$System.Int32(stack0o, stack1i);
    // ----- store field  ----- WindowsCard.ssc(682,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp5;
    $Heap[this, $exposeVersion] := temp5;
    // ----- frame condition  ----- WindowsCard.ssc(682,17)
    assert !(IncludeInMainFrameCondition(RTE.A) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.A)) || !$IncludedInModifiesStar(RTE.A)) && true);
    $Heap[this, RTE.A] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(683,17)
    goto block82688;

  block82637:
    // ----- branch  ----- WindowsCard.ssc(677,21)
    goto block82688;

  true82008to82841:
    assume local7 == stack0i;
    goto block82841;

  false82008to82025:
    assume local7 != stack0i;
    goto block82025;

  block82841:
    // ----- load field  ----- WindowsCard.ssc(705,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(705,13)
    stack1i := oprnd;
    // ----- call  ----- WindowsCard.ssc(705,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(705,13)
    // ----- branch  ----- WindowsCard.ssc(705,13)
    goto true82841to82926, false82841to82858;

  block82025:
    // ----- load constant 62  ----- WindowsCard.ssc(667,18)
    stack0i := 62;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82025to82960, false82025to82042;

  true82773to82807:
    assume !stack0b;
    goto block82807;

  false82773to82790:
    assume stack0b;
    goto block82790;

  block82807:
    // ----- load constant 21  ----- WindowsCard.ssc(700,17)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(700,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(702,13)
    goto block82824;

  block82790:
    // ----- load field  ----- WindowsCard.ssc(697,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(697,17)
    stack1i := oprnd;
    // ----- load constant 0  ----- WindowsCard.ssc(697,17)
    stack2i := 0;
    // ----- call  ----- WindowsCard.ssc(697,17)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(stack0o, stack1i, stack2i);
    // ----- load constant 1  ----- WindowsCard.ssc(698,17)
    stack0b := true;
    // ----- store field  ----- WindowsCard.ssc(698,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp8;
    $Heap[this, $exposeVersion] := temp8;
    // ----- frame condition  ----- WindowsCard.ssc(698,17)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.Z)) || !$IncludedInModifiesStar(RTE.Z)) && true);
    $Heap[this, RTE.Z] := stack0b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(699,15)
    goto block82824;

  block82688:
    // ----- load field  ----- WindowsCard.ssc(685,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(685,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(685,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(685,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp6;
    $Heap[this, $exposeVersion] := temp6;
    // ----- frame condition  ----- WindowsCard.ssc(685,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(686,13)
    goto block86224;

  block82756:
    // ----- load field  ----- WindowsCard.ssc(693,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(693,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(693,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(693,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp7;
    $Heap[this, $exposeVersion] := temp7;
    // ----- frame condition  ----- WindowsCard.ssc(693,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(694,13)
    goto block86224;

  true82025to82960:
    assume local7 == stack0i;
    goto block82960;

  false82025to82042:
    assume local7 != stack0i;
    goto block82042;

  block82960:
    // ----- load field  ----- WindowsCard.ssc(715,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(715,13)
    stack1i := oprnd;
    // ----- call  ----- WindowsCard.ssc(715,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(715,13)
    // ----- branch  ----- WindowsCard.ssc(715,13)
    goto true82960to83045, false82960to82977;

  block82042:
    // ----- load constant 50  ----- WindowsCard.ssc(667,18)
    stack0i := 50;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82042to83079, false82042to82059;

  true82841to82926:
    assume !stack0b;
    goto block82926;

  false82841to82858:
    assume stack0b;
    goto block82858;

  block82926:
    // ----- load constant 21  ----- WindowsCard.ssc(710,17)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(710,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(712,13)
    goto block82943;

  block82858:
    // ----- load field  ----- WindowsCard.ssc(706,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(706,17)
    stack1i := oprnd;
    // ----- load field  ----- WindowsCard.ssc(706,17)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(706,17)
    stack3i := oprnd;
    // ----- call  ----- WindowsCard.ssc(706,17)
    assert stack2o != null;
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := Memory.get_cont$System.Int32(stack2o, stack3i);
    // ----- load constant 1  ----- WindowsCard.ssc(706,17)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(706,17)
    stack2i := stack2i - stack3i;
    // ----- unary operator  ----- WindowsCard.ssc(706,17)
    stack2i := stack2i;
    // ----- call  ----- WindowsCard.ssc(706,17)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(stack0o, stack1i, stack2i);
    // ----- copy
    stack0o := this;
    // ----- load field  ----- WindowsCard.ssc(707,17)
    assert this != null;
    stack1o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(707,17)
    stack2i := oprnd;
    // ----- call  ----- WindowsCard.ssc(707,17)
    assert stack1o != null;
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack1i := Memory.get_cont$System.Int32(stack1o, stack2i);
    // ----- load constant 1  ----- WindowsCard.ssc(707,17)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(707,17)
    stack1i := stack1i - stack2i;
    // ----- load constant 0  ----- WindowsCard.ssc(707,17)
    stack2i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(707,17)
    // ----- branch  ----- WindowsCard.ssc(707,17)
    goto true82858to82892, false82858to82875;

  true82960to83045:
    assume !stack0b;
    goto block83045;

  false82960to82977:
    assume stack0b;
    goto block82977;

  block83045:
    // ----- load constant 21  ----- WindowsCard.ssc(720,13)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(720,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(720,35)
    goto block83062;

  block82977:
    // ----- load field  ----- WindowsCard.ssc(716,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(716,17)
    stack1i := oprnd;
    // ----- load field  ----- WindowsCard.ssc(716,17)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(716,17)
    stack3i := oprnd;
    // ----- call  ----- WindowsCard.ssc(716,17)
    assert stack2o != null;
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := Memory.get_cont$System.Int32(stack2o, stack3i);
    // ----- load constant 1  ----- WindowsCard.ssc(716,17)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(716,17)
    stack2i := stack2i + stack3i;
    // ----- unary operator  ----- WindowsCard.ssc(716,17)
    stack2i := stack2i;
    // ----- call  ----- WindowsCard.ssc(716,17)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true);
    call Memory.set_cont$System.Int32$System.Byte(stack0o, stack1i, stack2i);
    // ----- copy
    stack0o := this;
    // ----- load field  ----- WindowsCard.ssc(717,17)
    assert this != null;
    stack1o := $Heap[this, RTE.Scratch];
    // ----- copy  ----- WindowsCard.ssc(717,17)
    stack2i := oprnd;
    // ----- call  ----- WindowsCard.ssc(717,17)
    assert stack1o != null;
    assume $Utter($Heap[stack1o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack1i := Memory.get_cont$System.Int32(stack1o, stack2i);
    // ----- load constant 1  ----- WindowsCard.ssc(717,17)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(717,17)
    stack1i := stack1i + stack2i;
    // ----- load constant 0  ----- WindowsCard.ssc(717,17)
    stack2i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(717,17)
    // ----- branch  ----- WindowsCard.ssc(717,17)
    goto true82977to83011, false82977to82994;

  true82042to83079:
    assume local7 == stack0i;
    goto block83079;

  false82042to82059:
    assume local7 != stack0i;
    goto block82059;

  block83079:
    // ----- load field  ----- WindowsCard.ssc(724,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(724,13)
    stack0i := stack0i + oprnd;
    // ----- load constant 1  ----- WindowsCard.ssc(724,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(724,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(724,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp10;
    $Heap[this, $exposeVersion] := temp10;
    // ----- frame condition  ----- WindowsCard.ssc(724,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(725,13)
    goto block86224;

  block82059:
    // ----- load constant 51  ----- WindowsCard.ssc(667,18)
    stack0i := 51;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82059to83096, false82059to82076;

  true82858to82892:
    assume stack1i == stack2i;
    goto block82892;

  false82858to82875:
    assume stack1i != stack2i;
    goto block82875;

  block82892:
    // ----- load constant 1  ----- WindowsCard.ssc(707,17)
    stack1b := true;
    goto block82909;

  block82875:
    // ----- load constant 0
    stack1b := false;
    // ----- branch  ----- WindowsCard.ssc(707,17)
    goto block82909;

  block82824:
    // ----- load field  ----- WindowsCard.ssc(702,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(702,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(702,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(702,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp9;
    $Heap[this, $exposeVersion] := temp9;
    // ----- frame condition  ----- WindowsCard.ssc(702,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(703,13)
    goto block86224;

  true82977to83011:
    assume stack1i == stack2i;
    goto block83011;

  false82977to82994:
    assume stack1i != stack2i;
    goto block82994;

  block83011:
    // ----- load constant 1  ----- WindowsCard.ssc(717,17)
    stack1b := true;
    goto block83028;

  block82994:
    // ----- load constant 0
    stack1b := false;
    // ----- branch  ----- WindowsCard.ssc(717,17)
    goto block83028;

  true82059to83096:
    assume local7 == stack0i;
    goto block83096;

  false82059to82076:
    assume local7 != stack0i;
    goto block82076;

  block83096:
    // ----- copy  ----- WindowsCard.ssc(731,21)
    local10 := opcd;
    // ----- load constant 51  ----- WindowsCard.ssc(731,21)
    stack0i := 51;
    // ----- binary operator  ----- WindowsCard.ssc(731,21)
    // ----- branch  ----- WindowsCard.ssc(731,21)
    goto true83096to83181, false83096to83113;

  block82076:
    // ----- load constant 52  ----- WindowsCard.ssc(667,18)
    stack0i := 52;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82076to83096, false82076to82093;

  block82943:
    // ----- load field  ----- WindowsCard.ssc(712,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(712,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(712,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(712,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp11;
    $Heap[this, $exposeVersion] := temp11;
    // ----- frame condition  ----- WindowsCard.ssc(712,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(713,13)
    goto block86224;

  block83062:
    // ----- load field  ----- WindowsCard.ssc(721,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(721,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(721,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(721,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp12;
    $Heap[this, $exposeVersion] := temp12;
    // ----- frame condition  ----- WindowsCard.ssc(721,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(722,13)
    goto block86224;

  true82076to83096:
    assume local7 == stack0i;
    goto block83096;

  false82076to82093:
    assume local7 != stack0i;
    goto block82093;

  block82093:
    // ----- load constant 53  ----- WindowsCard.ssc(667,18)
    stack0i := 53;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82093to83096, false82093to82110;

  true83096to83181:
    assume local10 == stack0i;
    goto block83181;

  false83096to83113:
    assume local10 != stack0i;
    goto block83113;

  block83181:
    // ----- load field  ----- WindowsCard.ssc(732,22)
    assert this != null;
    takeBranch := $Heap[this, RTE.Z];
    // ----- branch  ----- WindowsCard.ssc(732,38)
    goto block83470;

  block83113:
    // ----- load constant 52  ----- WindowsCard.ssc(731,21)
    stack0i := 52;
    // ----- binary operator  ----- WindowsCard.ssc(731,21)
    // ----- branch  ----- WindowsCard.ssc(731,21)
    goto true83113to83198, false83113to83130;

  block82909:
    // ----- store field  ----- WindowsCard.ssc(707,17)
    assert stack0o != null;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    havoc temp13;
    $Heap[stack0o, $exposeVersion] := temp13;
    // ----- frame condition  ----- WindowsCard.ssc(707,17)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && (stack0o != old(this) || !($typeof(old(this)) <: DeclType(RTE.Z)) || !$IncludedInModifiesStar(RTE.Z)) && true);
    $Heap[stack0o, RTE.Z] := stack1b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(709,13)
    goto block82943;

  block83028:
    // ----- store field  ----- WindowsCard.ssc(717,17)
    assert stack0o != null;
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    havoc temp14;
    $Heap[stack0o, $exposeVersion] := temp14;
    // ----- frame condition  ----- WindowsCard.ssc(717,17)
    assert !(IncludeInMainFrameCondition(RTE.Z) && old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && (stack0o != old(this) || !($typeof(old(this)) <: DeclType(RTE.Z)) || !$IncludedInModifiesStar(RTE.Z)) && true);
    $Heap[stack0o, RTE.Z] := stack1b;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(719,13)
    goto block83062;

  true82093to83096:
    assume local7 == stack0i;
    goto block83096;

  false82093to82110:
    assume local7 != stack0i;
    goto block82110;

  block82110:
    // ----- load constant 54  ----- WindowsCard.ssc(667,18)
    stack0i := 54;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82110to83096, false82110to82127;

  true83113to83198:
    assume local10 == stack0i;
    goto block83198;

  false83113to83130:
    assume local10 != stack0i;
    goto block83130;

  block83198:
    // ----- load field  ----- WindowsCard.ssc(733,23)
    assert this != null;
    // ----- branch  ----- WindowsCard.ssc(733,23)
    goto true83198to83232, false83198to83215;

  block83130:
    // ----- load constant 53  ----- WindowsCard.ssc(731,21)
    stack0i := 53;
    // ----- binary operator  ----- WindowsCard.ssc(731,21)
    // ----- branch  ----- WindowsCard.ssc(731,21)
    goto true83130to83266, false83130to83147;

  true82110to83096:
    assume local7 == stack0i;
    goto block83096;

  false82110to82127:
    assume local7 != stack0i;
    goto block82127;

  block82127:
    // ----- load constant 55  ----- WindowsCard.ssc(667,18)
    stack0i := 55;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82127to83538, false82127to82144;

  true83130to83266:
    assume local10 == stack0i;
    goto block83266;

  false83130to83147:
    assume local10 != stack0i;
    goto block83147;

  block83266:
    // ----- load field  ----- WindowsCard.ssc(734,22)
    assert this != null;
    takeBranch := $Heap[this, RTE.C];
    // ----- branch  ----- WindowsCard.ssc(734,38)
    goto block83470;

  block83147:
    // ----- load constant 54  ----- WindowsCard.ssc(731,21)
    stack0i := 54;
    // ----- binary operator  ----- WindowsCard.ssc(731,21)
    // ----- branch  ----- WindowsCard.ssc(731,21)
    goto true83147to83283, false83147to83164;

  true83198to83232:
    assume $Heap[this, RTE.Z];
    goto block83232;

  false83198to83215:
    assume !$Heap[this, RTE.Z];
    goto block83215;

  block83232:
    // ----- load constant 0  ----- WindowsCard.ssc(733,23)
    stack0b := false;
    goto block83249;

  block83215:
    // ----- load constant 1
    stack0b := true;
    // ----- branch  ----- WindowsCard.ssc(733,23)
    goto block83249;

  block83470:
    // ----- copy  ----- WindowsCard.ssc(739,13)
    stack0b := takeBranch;
    // ----- unary operator  ----- WindowsCard.ssc(739,13)
    // ----- branch  ----- WindowsCard.ssc(739,13)
    goto true83470to83504, false83470to83487;

  true83470to83504:
    assume !stack0b;
    goto block83504;

  false83470to83487:
    assume stack0b;
    goto block83487;

  block83504:
    // ----- load field  ----- WindowsCard.ssc(742,17)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(742,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(742,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(742,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp15;
    $Heap[this, $exposeVersion] := temp15;
    // ----- frame condition  ----- WindowsCard.ssc(742,17)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- nop  ----- WindowsCard.ssc(744,13)
    goto block83521;

  block83487:
    // ----- load field  ----- WindowsCard.ssc(740,17)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(740,17)
    stack0i := stack0i + oprnd;
    // ----- load constant 1  ----- WindowsCard.ssc(740,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(740,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(740,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp16;
    $Heap[this, $exposeVersion] := temp16;
    // ----- frame condition  ----- WindowsCard.ssc(740,17)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(741,15)
    goto block83521;

  true82127to83538:
    assume local7 == stack0i;
    goto block83538;

  false82127to82144:
    assume local7 != stack0i;
    goto block82144;

  block83538:
    // ----- load field  ----- WindowsCard.ssc(746,13)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 10  ----- WindowsCard.ssc(746,13)
    stack1i := 10;
    // ----- binary operator  ----- WindowsCard.ssc(746,13)
    // ----- branch  ----- WindowsCard.ssc(746,13)
    goto true83538to83572, false83538to83555;

  block82144:
    // ----- load constant 56  ----- WindowsCard.ssc(667,18)
    stack0i := 56;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82144to83606, false82144to82161;

  true83147to83283:
    assume local10 == stack0i;
    goto block83283;

  false83147to83164:
    assume local10 != stack0i;
    goto block83164;

  block83283:
    // ----- load field  ----- WindowsCard.ssc(735,23)
    assert this != null;
    // ----- branch  ----- WindowsCard.ssc(735,23)
    goto true83283to83317, false83283to83300;

  block83164:
    // ----- branch  ----- WindowsCard.ssc(731,21)
    goto block83351;

  true82144to83606:
    assume local7 == stack0i;
    goto block83606;

  false82144to82161:
    assume local7 != stack0i;
    goto block82161;

  block83606:
    // ----- load field  ----- WindowsCard.ssc(755,13)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 0  ----- WindowsCard.ssc(755,13)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(755,13)
    // ----- branch  ----- WindowsCard.ssc(755,13)
    goto true83606to83640, false83606to83623;

  block82161:
    // ----- load constant 70  ----- WindowsCard.ssc(667,18)
    stack0i := 70;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82161to83674, false82161to82178;

  true83538to83572:
    assume stack0i >= stack1i;
    goto block83572;

  false83538to83555:
    assume stack0i < stack1i;
    goto block83555;

  block83572:
    // ----- load constant 22  ----- WindowsCard.ssc(751,17)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(751,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(753,13)
    goto block83589;

  block83555:
    // ----- load field  ----- WindowsCard.ssc(747,17)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(747,17)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load field  ----- WindowsCard.ssc(747,17)
    assert this != null;
    stack2i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(747,17)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(747,17)
    stack2i := stack2i + stack3i;
    // ----- store element  ----- WindowsCard.ssc(747,17)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    // ----- frame condition  ----- WindowsCard.ssc(747,17)
    assert !(old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && true);
    $Heap[stack0o, $elementsInt] := ArraySet($Heap[stack0o, $elementsInt], stack1i, stack2i);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(748,17)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(748,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(748,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(748,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp17;
    $Heap[this, $exposeVersion] := temp17;
    // ----- frame condition  ----- WindowsCard.ssc(748,17)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(749,17)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(749,17)
    stack0i := stack0i + oprnd;
    // ----- load constant 1  ----- WindowsCard.ssc(749,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(749,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(749,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp18;
    $Heap[this, $exposeVersion] := temp18;
    // ----- frame condition  ----- WindowsCard.ssc(749,17)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(750,15)
    goto block83589;

  true83283to83317:
    assume $Heap[this, RTE.C];
    goto block83317;

  false83283to83300:
    assume !$Heap[this, RTE.C];
    goto block83300;

  block83317:
    // ----- load constant 0  ----- WindowsCard.ssc(735,23)
    stack0b := false;
    goto block83334;

  block83300:
    // ----- load constant 1
    stack0b := true;
    // ----- branch  ----- WindowsCard.ssc(735,23)
    goto block83334;

  block83249:
    // ----- copy  ----- WindowsCard.ssc(733,23)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(733,40)
    goto block83470;

  block83521:
    // ----- branch  ----- WindowsCard.ssc(744,13)
    goto block86224;

  true83606to83640:
    assume stack0i <= stack1i;
    goto block83640;

  false83606to83623:
    assume stack0i > stack1i;
    goto block83623;

  block83640:
    // ----- load constant 22  ----- WindowsCard.ssc(759,17)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(759,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(761,13)
    goto block83657;

  block83623:
    // ----- load field  ----- WindowsCard.ssc(756,17)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(756,17)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(756,17)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(756,17)
    stack1i := stack1i - stack2i;
    // ----- load element  ----- WindowsCard.ssc(756,17)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    stack0i := ArrayGet($Heap[stack0o, $elementsInt], stack1i);
    // ----- store field  ----- WindowsCard.ssc(756,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp19;
    $Heap[this, $exposeVersion] := temp19;
    // ----- frame condition  ----- WindowsCard.ssc(756,17)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(757,17)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(757,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(757,17)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(757,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp20;
    $Heap[this, $exposeVersion] := temp20;
    // ----- frame condition  ----- WindowsCard.ssc(757,17)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(758,15)
    goto block83657;

  true82161to83674:
    assume local7 == stack0i;
    goto block83674;

  false82161to82178:
    assume local7 != stack0i;
    goto block82178;

  block83674:
    // ----- load field  ----- WindowsCard.ssc(763,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(763,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(763,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(763,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp21;
    $Heap[this, $exposeVersion] := temp21;
    // ----- frame condition  ----- WindowsCard.ssc(763,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(764,13)
    goto block86224;

  block82178:
    // ----- load constant 71  ----- WindowsCard.ssc(667,18)
    stack0i := 71;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82178to83691, false82178to82195;

  block83351:
    // ----- serialized AssertStatement  ----- WindowsCard.ssc(737,17)
    assert false;
    return;

  true82178to83691:
    assume local7 == stack0i;
    goto block83691;

  false82178to82195:
    assume local7 != stack0i;
    goto block82195;

  block83691:
    // ----- load constant 20  ----- WindowsCard.ssc(766,13)
    stack0i := 20;
    // ----- call  ----- WindowsCard.ssc(766,13)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- branch  ----- WindowsCard.ssc(767,13)
    goto block86224;

  block82195:
    // ----- load constant 73  ----- WindowsCard.ssc(667,18)
    stack0i := 73;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82195to83708, false82195to82212;

  block83589:
    // ----- branch  ----- WindowsCard.ssc(753,13)
    goto block86224;

  block83334:
    // ----- copy  ----- WindowsCard.ssc(735,23)
    takeBranch := stack0b;
    // ----- branch  ----- WindowsCard.ssc(735,40)
    goto block83470;

  block83657:
    // ----- branch  ----- WindowsCard.ssc(761,13)
    goto block86224;

  true82195to83708:
    assume local7 == stack0i;
    goto block83708;

  false82195to82212:
    assume local7 != stack0i;
    goto block82212;

  block83708:
    // ----- load constant 11  ----- WindowsCard.ssc(769,13)
    stack0i := 11;
    // ----- store field  ----- WindowsCard.ssc(769,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp22;
    $Heap[this, $exposeVersion] := temp22;
    // ----- frame condition  ----- WindowsCard.ssc(769,13)
    assert !(IncludeInMainFrameCondition(RTE.CurrRTEMode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CurrRTEMode)) || !$IncludedInModifiesStar(RTE.CurrRTEMode)) && true);
    $Heap[this, RTE.CurrRTEMode] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(770,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(770,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(770,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(770,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp23;
    $Heap[this, $exposeVersion] := temp23;
    // ----- frame condition  ----- WindowsCard.ssc(770,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(771,13)
    goto block86224;

  block82212:
    // ----- load constant 85  ----- WindowsCard.ssc(667,18)
    stack0i := 85;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82212to83725, false82212to82229;

  true82212to83725:
    assume local7 == stack0i;
    goto block83725;

  false82212to82229:
    assume local7 != stack0i;
    goto block82229;

  block83725:
    // ----- load field  ----- WindowsCard.ssc(773,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(773,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(773,13)
    // ----- branch  ----- WindowsCard.ssc(773,13)
    goto true83725to83759, false83725to83742;

  block82229:
    // ----- load constant 80  ----- WindowsCard.ssc(667,18)
    stack0i := 80;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82229to83793, false82229to82246;

  true82229to83793:
    assume local7 == stack0i;
    goto block83793;

  false82229to82246:
    assume local7 != stack0i;
    goto block82246;

  block83793:
    // ----- load field  ----- WindowsCard.ssc(784,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(784,13)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(784,13)
    stack0i := stack0i - stack1i;
    // ----- load field  ----- WindowsCard.ssc(784,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(784,13)
    // ----- branch  ----- WindowsCard.ssc(784,13)
    goto true83793to83929, false83793to83810;

  block82246:
    // ----- load constant 81  ----- WindowsCard.ssc(667,18)
    stack0i := 81;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82246to83793, false82246to82263;

  true83725to83759:
    assume stack0i == stack1i;
    goto block83759;

  false83725to83742:
    assume stack0i != stack1i;
    goto block83742;

  block83759:
    // ----- load constant 23  ----- WindowsCard.ssc(776,17)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(776,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(778,9)
    goto block83776;

  block83742:
    // ----- load field  ----- WindowsCard.ssc(774,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(774,17)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(774,17)
    stack2i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(774,17)
    stack1i := stack1i - stack2i;
    // ----- load constant -1  ----- WindowsCard.ssc(774,17)
    stack2i := -1;
    // ----- load field  ----- WindowsCard.ssc(774,17)
    assert this != null;
    stack3o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(774,17)
    assert this != null;
    stack4i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(774,17)
    stack5i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(774,17)
    stack4i := stack4i - stack5i;
    // ----- call  ----- WindowsCard.ssc(774,17)
    assume $Utter($Heap[stack3o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack3i := RTE.ReadQuad$Memory$notnull$System.Int32(stack3o, stack4i);
    // ----- binary operator  ----- WindowsCard.ssc(774,17)
    stack2i := stack2i * stack3i;
    // ----- call  ----- WindowsCard.ssc(774,17)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- branch  ----- WindowsCard.ssc(775,15)
    goto block83776;

  true83793to83929:
    assume stack0i == stack1i;
    goto block83929;

  false83793to83810:
    assume stack0i != stack1i;
    goto block83810;

  block83929:
    // ----- load constant 23  ----- WindowsCard.ssc(789,17)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(789,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(791,13)
    goto block83946;

  block83810:
    // ----- load field  ----- WindowsCard.ssc(784,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(784,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(784,13)
    // ----- branch  ----- WindowsCard.ssc(784,13)
    goto true83810to83929, false83810to83827;

  true82246to83793:
    assume local7 == stack0i;
    goto block83793;

  false82246to82263:
    assume local7 != stack0i;
    goto block82263;

  block82263:
    // ----- load constant 82  ----- WindowsCard.ssc(667,18)
    stack0i := 82;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82263to83793, false82263to82280;

  true83810to83929:
    assume stack0i == stack1i;
    goto block83929;

  false83810to83827:
    assume stack0i != stack1i;
    goto block83827;

  block83827:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(785,17)
    assume 0 <= $Heap[this, RTE.MSP] - 8;
    goto block83912;

  true82263to83793:
    assume local7 == stack0i;
    goto block83793;

  false82263to82280:
    assume local7 != stack0i;
    goto block82280;

  block82280:
    // ----- load constant 83  ----- WindowsCard.ssc(667,18)
    stack0i := 83;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82280to83793, false82280to82297;

  block83776:
    // ----- branch  ----- WindowsCard.ssc(778,9)
    goto block86224;

  block83946:
    // ----- load field  ----- WindowsCard.ssc(791,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(791,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(791,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(791,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp24;
    $Heap[this, $exposeVersion] := temp24;
    // ----- frame condition  ----- WindowsCard.ssc(791,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(792,13)
    goto block86224;

  true82280to83793:
    assume local7 == stack0i;
    goto block83793;

  false82280to82297:
    assume local7 != stack0i;
    goto block82297;

  block82297:
    // ----- load constant 84  ----- WindowsCard.ssc(667,18)
    stack0i := 84;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82297to83793, false82297to82314;

  block83912:
    // ----- nop  ----- WindowsCard.ssc(785,24)
    // ----- load field  ----- WindowsCard.ssc(786,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(786,17)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(786,17)
    stack2i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(786,17)
    stack1i := stack1i - stack2i;
    // ----- copy  ----- WindowsCard.ssc(786,17)
    stack2i := opcd;
    // ----- load field  ----- WindowsCard.ssc(786,17)
    assert this != null;
    stack3o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(786,17)
    assert this != null;
    stack4i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(786,17)
    stack5i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(786,17)
    stack4i := stack4i - stack5i;
    // ----- call  ----- WindowsCard.ssc(786,17)
    assume $Utter($Heap[stack3o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack3i := RTE.ReadQuad$Memory$notnull$System.Int32(stack3o, stack4i);
    // ----- load field  ----- WindowsCard.ssc(786,17)
    assert this != null;
    stack4o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(786,17)
    assert this != null;
    stack5i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(786,17)
    stack6i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(786,17)
    stack5i := stack5i - stack6i;
    // ----- call  ----- WindowsCard.ssc(786,17)
    assume $Utter($Heap[stack4o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack4i := RTE.ReadQuad$Memory$notnull$System.Int32(stack4o, stack5i);
    // ----- call  ----- WindowsCard.ssc(786,17)
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ApplyQuad$System.Int32$System.Int32$System.Int32(stack2i, stack3i, stack4i);
    // ----- call  ----- WindowsCard.ssc(786,17)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(787,17)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(787,17)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(787,17)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(787,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp25;
    $Heap[this, $exposeVersion] := temp25;
    // ----- frame condition  ----- WindowsCard.ssc(787,17)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(788,15)
    goto block83946;

  true82297to83793:
    assume local7 == stack0i;
    goto block83793;

  false82297to82314:
    assume local7 != stack0i;
    goto block82314;

  block82314:
    // ----- load constant 90  ----- WindowsCard.ssc(667,18)
    stack0i := 90;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82314to83963, false82314to82331;

  true82314to83963:
    assume local7 == stack0i;
    goto block83963;

  false82314to82331:
    assume local7 != stack0i;
    goto block82331;

  block83963:
    // ----- load field  ----- WindowsCard.ssc(794,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(794,13)
    stack0i := stack0i + oprnd;
    // ----- load constant 1  ----- WindowsCard.ssc(794,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(794,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(794,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp26;
    $Heap[this, $exposeVersion] := temp26;
    // ----- frame condition  ----- WindowsCard.ssc(794,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(795,13)
    goto block86224;

  block82331:
    // ----- load constant 95  ----- WindowsCard.ssc(667,18)
    stack0i := 95;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82331to83980, false82331to82348;

  true82331to83980:
    assume local7 == stack0i;
    goto block83980;

  false82331to82348:
    assume local7 != stack0i;
    goto block82348;

  block83980:
    // ----- load field  ----- WindowsCard.ssc(797,13)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 10  ----- WindowsCard.ssc(797,13)
    stack1i := 10;
    // ----- binary operator  ----- WindowsCard.ssc(797,13)
    // ----- branch  ----- WindowsCard.ssc(797,13)
    goto true83980to84014, false83980to83997;

  block82348:
    // ----- load constant 96  ----- WindowsCard.ssc(667,18)
    stack0i := 96;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82348to84048, false82348to82365;

  true82348to84048:
    assume local7 == stack0i;
    goto block84048;

  false82348to82365:
    assume local7 != stack0i;
    goto block82365;

  block84048:
    // ----- load field  ----- WindowsCard.ssc(806,13)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 0  ----- WindowsCard.ssc(806,13)
    stack1i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(806,13)
    // ----- branch  ----- WindowsCard.ssc(806,13)
    goto true84048to84082, false84048to84065;

  block82365:
    // ----- load constant 91  ----- WindowsCard.ssc(667,18)
    stack0i := 91;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82365to84116, false82365to82382;

  true83980to84014:
    assume stack0i >= stack1i;
    goto block84014;

  false83980to83997:
    assume stack0i < stack1i;
    goto block83997;

  block84014:
    // ----- load constant 22  ----- WindowsCard.ssc(802,17)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(802,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(804,13)
    goto block84031;

  block83997:
    // ----- load field  ----- WindowsCard.ssc(798,17)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(798,17)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load field  ----- WindowsCard.ssc(798,17)
    assert this != null;
    stack2i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(798,17)
    stack3i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(798,17)
    stack2i := stack2i + stack3i;
    // ----- store element  ----- WindowsCard.ssc(798,17)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    assert $Heap[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[stack0o, $ownerRef], $inv] <: $Heap[stack0o, $ownerFrame]) || $Heap[$Heap[stack0o, $ownerRef], $localinv] == $BaseClass($Heap[stack0o, $ownerFrame]);
    // ----- frame condition  ----- WindowsCard.ssc(798,17)
    assert !(old($Heap)[stack0o, $allocated] && (old($Heap)[stack0o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[stack0o, $ownerRef], $inv] <: old($Heap)[stack0o, $ownerFrame]) || old($Heap)[old($Heap)[stack0o, $ownerRef], $localinv] == $BaseClass(old($Heap)[stack0o, $ownerFrame])) && true);
    $Heap[stack0o, $elementsInt] := ArraySet($Heap[stack0o, $elementsInt], stack1i, stack2i);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(799,17)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(799,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(799,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(799,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp27;
    $Heap[this, $exposeVersion] := temp27;
    // ----- frame condition  ----- WindowsCard.ssc(799,17)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(800,17)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(800,17)
    stack0i := stack0i + oprnd;
    // ----- load constant 1  ----- WindowsCard.ssc(800,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(800,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(800,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp28;
    $Heap[this, $exposeVersion] := temp28;
    // ----- frame condition  ----- WindowsCard.ssc(800,17)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(801,15)
    goto block84031;

  true82365to84116:
    assume local7 == stack0i;
    goto block84116;

  false82365to82382:
    assume local7 != stack0i;
    goto block82382;

  block84116:
    // ----- load field  ----- WindowsCard.ssc(817,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(817,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(817,13)
    // ----- branch  ----- WindowsCard.ssc(817,13)
    goto true84116to84677, false84116to84133;

  block82382:
    // ----- load constant 92  ----- WindowsCard.ssc(667,18)
    stack0i := 92;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82382to84116, false82382to82399;

  true84048to84082:
    assume stack0i <= stack1i;
    goto block84082;

  false84048to84065:
    assume stack0i > stack1i;
    goto block84065;

  block84082:
    // ----- load constant 22  ----- WindowsCard.ssc(810,17)
    stack0i := 22;
    // ----- call  ----- WindowsCard.ssc(810,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(812,13)
    goto block84099;

  block84065:
    // ----- load field  ----- WindowsCard.ssc(807,17)
    assert this != null;
    stack0o := $Heap[this, RTE.CallStack];
    // ----- load field  ----- WindowsCard.ssc(807,17)
    assert this != null;
    stack1i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(807,17)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(807,17)
    stack1i := stack1i - stack2i;
    // ----- load element  ----- WindowsCard.ssc(807,17)
    assert stack0o != null;
    assert 0 <= stack1i;
    assert stack1i < $Length(stack0o);
    stack0i := ArrayGet($Heap[stack0o, $elementsInt], stack1i);
    // ----- store field  ----- WindowsCard.ssc(807,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp29;
    $Heap[this, $exposeVersion] := temp29;
    // ----- frame condition  ----- WindowsCard.ssc(807,17)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(808,17)
    assert this != null;
    stack0i := $Heap[this, RTE.CSP];
    // ----- load constant 1  ----- WindowsCard.ssc(808,17)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(808,17)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(808,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp30;
    $Heap[this, $exposeVersion] := temp30;
    // ----- frame condition  ----- WindowsCard.ssc(808,17)
    assert !(IncludeInMainFrameCondition(RTE.CSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CSP)) || !$IncludedInModifiesStar(RTE.CSP)) && true);
    $Heap[this, RTE.CSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || 0 <= $Heap[this, RTE.CSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.CSP] <= 10;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(809,15)
    goto block84099;

  true84116to84677:
    assume stack0i == stack1i;
    goto block84677;

  false84116to84133:
    assume stack0i != stack1i;
    goto block84133;

  block84677:
    // ----- load constant 23  ----- WindowsCard.ssc(834,17)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(834,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(836,13)
    goto block84694;

  block84133:
    // ----- load field  ----- WindowsCard.ssc(818,21)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(818,21)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(818,21)
    stack2i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(818,21)
    stack1i := stack1i - stack2i;
    // ----- call  ----- WindowsCard.ssc(818,21)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call val := RTE.ReadQuad$Memory$notnull$System.Int32(stack0o, stack1i);
    // ----- copy  ----- WindowsCard.ssc(820,25)
    local15 := opcd;
    // ----- load constant 91  ----- WindowsCard.ssc(820,25)
    stack0i := 91;
    // ----- binary operator  ----- WindowsCard.ssc(820,25)
    // ----- branch  ----- WindowsCard.ssc(820,25)
    goto true84133to84218, false84133to84150;

  true82382to84116:
    assume local7 == stack0i;
    goto block84116;

  false82382to82399:
    assume local7 != stack0i;
    goto block82399;

  block82399:
    // ----- load constant 93  ----- WindowsCard.ssc(667,18)
    stack0i := 93;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82399to84116, false82399to82416;

  block84031:
    // ----- branch  ----- WindowsCard.ssc(804,13)
    goto block86224;

  true84133to84218:
    assume local15 == stack0i;
    goto block84218;

  false84133to84150:
    assume local15 != stack0i;
    goto block84150;

  block84218:
    // ----- load constant 0  ----- WindowsCard.ssc(821,31)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(821,31)
    // ----- branch  ----- WindowsCard.ssc(821,31)
    goto true84218to84252, false84218to84235;

  block84150:
    // ----- load constant 92  ----- WindowsCard.ssc(820,25)
    stack0i := 92;
    // ----- binary operator  ----- WindowsCard.ssc(820,25)
    // ----- branch  ----- WindowsCard.ssc(820,25)
    goto true84150to84286, false84150to84167;

  true82399to84116:
    assume local7 == stack0i;
    goto block84116;

  false82399to82416:
    assume local7 != stack0i;
    goto block82416;

  block82416:
    // ----- load constant 94  ----- WindowsCard.ssc(667,18)
    stack0i := 94;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82416to84116, false82416to82433;

  block84099:
    // ----- branch  ----- WindowsCard.ssc(812,13)
    goto block86224;

  true84218to84252:
    assume val == stack0i;
    goto block84252;

  false84218to84235:
    assume val != stack0i;
    goto block84235;

  block84252:
    // ----- load constant 1  ----- WindowsCard.ssc(821,31)
    stack0b := true;
    goto block84269;

  block84235:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(821,31)
    goto block84269;

  true84150to84286:
    assume local15 == stack0i;
    goto block84286;

  false84150to84167:
    assume local15 != stack0i;
    goto block84167;

  block84286:
    // ----- load constant 0  ----- WindowsCard.ssc(822,32)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(822,32)
    // ----- branch  ----- WindowsCard.ssc(822,32)
    goto true84286to84320, false84286to84303;

  block84167:
    // ----- load constant 93  ----- WindowsCard.ssc(820,25)
    stack0i := 93;
    // ----- binary operator  ----- WindowsCard.ssc(820,25)
    // ----- branch  ----- WindowsCard.ssc(820,25)
    goto true84167to84354, false84167to84184;

  block84694:
    // ----- branch  ----- WindowsCard.ssc(836,13)
    goto block86224;

  true82416to84116:
    assume local7 == stack0i;
    goto block84116;

  false82416to82433:
    assume local7 != stack0i;
    goto block82433;

  block82433:
    // ----- load constant 114  ----- WindowsCard.ssc(667,18)
    stack0i := 114;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82433to84711, false82433to82450;

  true84286to84320:
    assume val != stack0i;
    goto block84320;

  false84286to84303:
    assume val == stack0i;
    goto block84303;

  block84320:
    // ----- load constant 1  ----- WindowsCard.ssc(822,32)
    stack0b := true;
    goto block84337;

  block84303:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(822,32)
    goto block84337;

  true84167to84354:
    assume local15 == stack0i;
    goto block84354;

  false84167to84184:
    assume local15 != stack0i;
    goto block84184;

  block84354:
    // ----- load constant 0  ----- WindowsCard.ssc(823,33)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(823,33)
    // ----- branch  ----- WindowsCard.ssc(823,33)
    goto true84354to84388, false84354to84371;

  block84184:
    // ----- load constant 94  ----- WindowsCard.ssc(820,25)
    stack0i := 94;
    // ----- binary operator  ----- WindowsCard.ssc(820,25)
    // ----- branch  ----- WindowsCard.ssc(820,25)
    goto true84184to84422, false84184to84201;

  true82433to84711:
    assume local7 == stack0i;
    goto block84711;

  false82433to82450:
    assume local7 != stack0i;
    goto block82450;

  block84711:
    // ----- load field  ----- WindowsCard.ssc(838,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(838,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(838,13)
    // ----- branch  ----- WindowsCard.ssc(838,13)
    goto true84711to84966, false84711to84728;

  block82450:
    // ----- load constant 110  ----- WindowsCard.ssc(667,18)
    stack0i := 110;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82450to85000, false82450to82467;

  block84269:
    // ----- copy  ----- WindowsCard.ssc(821,31)
    takeBranch2 := stack0b;
    // ----- branch  ----- WindowsCard.ssc(821,57)
    goto block84609;

  true84354to84388:
    assume val >= stack0i;
    goto block84388;

  false84354to84371:
    assume val < stack0i;
    goto block84371;

  block84388:
    // ----- load constant 1  ----- WindowsCard.ssc(823,33)
    stack0b := true;
    goto block84405;

  block84371:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(823,33)
    goto block84405;

  true84184to84422:
    assume local15 == stack0i;
    goto block84422;

  false84184to84201:
    assume local15 != stack0i;
    goto block84201;

  block84422:
    // ----- load constant 0  ----- WindowsCard.ssc(824,33)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(824,33)
    // ----- branch  ----- WindowsCard.ssc(824,33)
    goto true84422to84456, false84422to84439;

  block84201:
    // ----- branch  ----- WindowsCard.ssc(820,25)
    goto block84490;

  true82450to85000:
    assume local7 == stack0i;
    goto block85000;

  false82450to82467:
    assume local7 != stack0i;
    goto block82467;

  block85000:
    // ----- copy  ----- WindowsCard.ssc(848,21)
    local18 := oprndType;
    // ----- load constant 120  ----- WindowsCard.ssc(848,21)
    stack0i := 120;
    // ----- binary operator  ----- WindowsCard.ssc(848,21)
    // ----- branch  ----- WindowsCard.ssc(848,21)
    goto true85000to85051, false85000to85017;

  block82467:
    // ----- load constant 115  ----- WindowsCard.ssc(667,18)
    stack0i := 115;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82467to85731, false82467to82484;

  true84711to84966:
    assume stack0i == stack1i;
    goto block84966;

  false84711to84728:
    assume stack0i != stack1i;
    goto block84728;

  block84966:
    // ----- load constant 23  ----- WindowsCard.ssc(843,17)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(843,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(845,13)
    goto block84983;

  block84728:
    // ----- load field  ----- WindowsCard.ssc(838,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(838,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(838,13)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(838,13)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(838,13)
    // ----- branch  ----- WindowsCard.ssc(838,13)
    goto true84728to84966, false84728to84745;

  block84609:
    // ----- copy  ----- WindowsCard.ssc(828,17)
    stack0b := takeBranch2;
    // ----- unary operator  ----- WindowsCard.ssc(828,17)
    // ----- branch  ----- WindowsCard.ssc(828,17)
    goto true84609to84643, false84609to84626;

  true84609to84643:
    assume !stack0b;
    goto block84643;

  false84609to84626:
    assume stack0b;
    goto block84626;

  block84643:
    // ----- load field  ----- WindowsCard.ssc(831,21)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(831,21)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(831,21)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(831,21)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp32;
    $Heap[this, $exposeVersion] := temp32;
    // ----- frame condition  ----- WindowsCard.ssc(831,21)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- nop  ----- WindowsCard.ssc(833,13)
    goto block84660;

  block84626:
    // ----- load field  ----- WindowsCard.ssc(829,21)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- binary operator  ----- WindowsCard.ssc(829,21)
    stack0i := stack0i + oprnd;
    // ----- load constant 1  ----- WindowsCard.ssc(829,21)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(829,21)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(829,21)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp31;
    $Heap[this, $exposeVersion] := temp31;
    // ----- frame condition  ----- WindowsCard.ssc(829,21)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(830,19)
    goto block84660;

  block84337:
    // ----- copy  ----- WindowsCard.ssc(822,32)
    takeBranch2 := stack0b;
    // ----- branch  ----- WindowsCard.ssc(822,58)
    goto block84609;

  true84422to84456:
    assume val < stack0i;
    goto block84456;

  false84422to84439:
    assume val >= stack0i;
    goto block84439;

  block84456:
    // ----- load constant 1  ----- WindowsCard.ssc(824,33)
    stack0b := true;
    goto block84473;

  block84439:
    // ----- load constant 0
    stack0b := false;
    // ----- branch  ----- WindowsCard.ssc(824,33)
    goto block84473;

  true82467to85731:
    assume local7 == stack0i;
    goto block85731;

  false82467to82484:
    assume local7 != stack0i;
    goto block82484;

  block85731:
    // ----- load field  ----- WindowsCard.ssc(880,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(880,13)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(880,13)
    stack0i := stack0i - stack1i;
    // ----- load field  ----- WindowsCard.ssc(880,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(880,13)
    // ----- branch  ----- WindowsCard.ssc(880,13)
    goto true85731to85867, false85731to85748;

  block82484:
    // ----- load constant 111  ----- WindowsCard.ssc(667,18)
    stack0i := 111;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82484to85901, false82484to82501;

  true85000to85051:
    assume local18 == stack0i;
    goto block85051;

  false85000to85017:
    assume local18 != stack0i;
    goto block85017;

  block85051:
    // ----- load field  ----- WindowsCard.ssc(850,17)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(850,17)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(850,17)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(850,17)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(850,17)
    // ----- branch  ----- WindowsCard.ssc(850,17)
    goto true85051to85289, false85051to85068;

  block85017:
    // ----- load constant 121  ----- WindowsCard.ssc(848,21)
    stack0i := 121;
    // ----- binary operator  ----- WindowsCard.ssc(848,21)
    // ----- branch  ----- WindowsCard.ssc(848,21)
    goto true85017to85323, false85017to85034;

  true84728to84966:
    assume stack0i == stack1i;
    goto block84966;

  false84728to84745:
    assume stack0i != stack1i;
    goto block84745;

  block84745:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(839,17)
    assume $Heap[this, RTE.MStackBase] mod 4 == 0 && $Heap[this, RTE.MStackMaxSize] mod 4 == 0 ==> ($Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize]) mod 4 == 0;
    goto block84949;

  block84405:
    // ----- copy  ----- WindowsCard.ssc(823,33)
    takeBranch2 := stack0b;
    // ----- branch  ----- WindowsCard.ssc(823,59)
    goto block84609;

  block84490:
    // ----- serialized AssertStatement  ----- WindowsCard.ssc(826,21)
    assert false;
    return;

  true82484to85901:
    assume local7 == stack0i;
    goto block85901;

  false82484to82501:
    assume local7 != stack0i;
    goto block82501;

  block85901:
    // ----- load field  ----- WindowsCard.ssc(890,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(890,13)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- call  ----- WindowsCard.ssc(890,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(890,13)
    // ----- branch  ----- WindowsCard.ssc(890,13)
    goto true85901to86071, false85901to85918;

  block82501:
    // ----- load constant 113  ----- WindowsCard.ssc(667,18)
    stack0i := 113;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82501to86105, false82501to82518;

  true85731to85867:
    assume stack0i == stack1i;
    goto block85867;

  false85731to85748:
    assume stack0i != stack1i;
    goto block85748;

  block85867:
    // ----- load constant 23  ----- WindowsCard.ssc(885,17)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(885,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(887,13)
    goto block85884;

  block85748:
    // ----- load field  ----- WindowsCard.ssc(880,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(880,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(880,13)
    // ----- branch  ----- WindowsCard.ssc(880,13)
    goto true85748to85867, false85748to85765;

  true85051to85289:
    assume stack0i == stack1i;
    goto block85289;

  false85051to85068:
    assume stack0i != stack1i;
    goto block85068;

  block85289:
    // ----- load constant 23  ----- WindowsCard.ssc(855,21)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(855,21)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(857,17)
    goto block85306;

  block85068:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(851,21)
    assume $Heap[this, RTE.MStackBase] mod 4 == 0 && $Heap[this, RTE.MStackMaxSize] mod 4 == 0 ==> ($Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize]) mod 4 == 0;
    goto block85272;

  true85017to85323:
    assume local18 == stack0i;
    goto block85323;

  false85017to85034:
    assume local18 != stack0i;
    goto block85034;

  block85323:
    // ----- load field  ----- WindowsCard.ssc(859,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(859,17)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- call  ----- WindowsCard.ssc(859,17)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(859,17)
    // ----- branch  ----- WindowsCard.ssc(859,17)
    goto true85323to85680, false85323to85340;

  block85034:
    // ----- branch  ----- WindowsCard.ssc(848,21)
    goto block85714;

  block84983:
    // ----- load field  ----- WindowsCard.ssc(845,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(845,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(845,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(845,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp33;
    $Heap[this, $exposeVersion] := temp33;
    // ----- frame condition  ----- WindowsCard.ssc(845,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(846,13)
    goto block86224;

  block84660:
    // ----- branch  ----- WindowsCard.ssc(833,15)
    goto block84694;

  block84473:
    // ----- copy  ----- WindowsCard.ssc(824,33)
    takeBranch2 := stack0b;
    // ----- branch  ----- WindowsCard.ssc(824,58)
    goto block84609;

  true85901to86071:
    assume !stack0b;
    goto block86071;

  false85901to85918:
    assume stack0b;
    goto block85918;

  block86071:
    // ----- load constant 21  ----- WindowsCard.ssc(904,17)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(904,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(906,13)
    goto block86088;

  block85918:
    // ----- load field  ----- WindowsCard.ssc(890,13)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(890,13)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- load constant 1  ----- WindowsCard.ssc(890,13)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(890,13)
    stack1i := stack1i + stack2i;
    // ----- call  ----- WindowsCard.ssc(890,13)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(890,13)
    // ----- branch  ----- WindowsCard.ssc(890,13)
    goto true85918to86071, false85918to85935;

  true82501to86105:
    assume local7 == stack0i;
    goto block86105;

  false82501to82518:
    assume local7 != stack0i;
    goto block82518;

  block86105:
    // ----- load field  ----- WindowsCard.ssc(908,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MStackBase];
    // ----- store field  ----- WindowsCard.ssc(908,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp35;
    $Heap[this, $exposeVersion] := temp35;
    // ----- frame condition  ----- WindowsCard.ssc(908,13)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(909,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(909,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(909,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(909,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp36;
    $Heap[this, $exposeVersion] := temp36;
    // ----- frame condition  ----- WindowsCard.ssc(909,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(910,13)
    goto block86224;

  block82518:
    // ----- load constant 112  ----- WindowsCard.ssc(667,18)
    stack0i := 112;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82518to86122, false82518to82535;

  true85748to85867:
    assume stack0i == stack1i;
    goto block85867;

  false85748to85765:
    assume stack0i != stack1i;
    goto block85765;

  block85765:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(881,17)
    assume 0 <= $Heap[this, RTE.MSP] - 8;
    goto block85850;

  true85323to85680:
    assume !stack0b;
    goto block85680;

  false85323to85340:
    assume stack0b;
    goto block85340;

  block85680:
    // ----- load constant 21  ----- WindowsCard.ssc(873,21)
    stack0i := 21;
    // ----- call  ----- WindowsCard.ssc(873,21)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(875,17)
    goto block85697;

  block85340:
    // ----- load field  ----- WindowsCard.ssc(859,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(859,17)
    assert this != null;
    stack1i := $Heap[this, RTE.DPP];
    // ----- load constant 1  ----- WindowsCard.ssc(859,17)
    stack2i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(859,17)
    stack1i := stack1i + stack2i;
    // ----- call  ----- WindowsCard.ssc(859,17)
    assert stack0o != null;
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0b := Memory.InSandbox$System.Int32(stack0o, stack1i);
    // ----- unary operator  ----- WindowsCard.ssc(859,17)
    // ----- branch  ----- WindowsCard.ssc(859,17)
    goto true85340to85680, false85340to85357;

  block84949:
    // ----- nop  ----- WindowsCard.ssc(839,24)
    // ----- load field  ----- WindowsCard.ssc(840,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(840,17)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(840,17)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(840,17)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(840,17)
    stack4i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(840,17)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(840,17)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(840,17)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(841,17)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(841,17)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(841,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(841,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp34;
    $Heap[this, $exposeVersion] := temp34;
    // ----- frame condition  ----- WindowsCard.ssc(841,17)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(842,15)
    goto block84983;

  true85918to86071:
    assume !stack0b;
    goto block86071;

  false85918to85935:
    assume stack0b;
    goto block85935;

  block85935:
    // ----- call  ----- WindowsCard.ssc(891,21)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := RTE.DP(this);
    // ----- load constant 4  ----- WindowsCard.ssc(891,21)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(891,21)
    stack1i := oprnd * stack1i;
    // ----- binary operator  ----- WindowsCard.ssc(891,21)
    stack0i := stack0i + stack1i;
    // ----- load constant 4  ----- WindowsCard.ssc(891,21)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(891,21)
    stack0i := stack0i + stack1i;
    // ----- copy  ----- WindowsCard.ssc(891,21)
    address := stack0i;
    // ----- load constant 0  ----- WindowsCard.ssc(892,17)
    stack0i := 0;
    // ----- binary operator  ----- WindowsCard.ssc(892,17)
    // ----- branch  ----- WindowsCard.ssc(892,17)
    goto true85935to86037, false85935to85952;

  true82518to86122:
    assume local7 == stack0i;
    goto block86122;

  false82518to82535:
    assume local7 != stack0i;
    goto block82535;

  block86122:
    // ----- load field  ----- WindowsCard.ssc(912,13)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(912,13)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(912,13)
    // ----- branch  ----- WindowsCard.ssc(912,13)
    goto true86122to86156, false86122to86139;

  block82535:
    // ----- load constant 100  ----- WindowsCard.ssc(667,18)
    stack0i := 100;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82535to86190, false82535to82552;

  block85884:
    // ----- load field  ----- WindowsCard.ssc(887,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(887,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(887,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(887,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp37;
    $Heap[this, $exposeVersion] := temp37;
    // ----- frame condition  ----- WindowsCard.ssc(887,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(888,13)
    goto block86224;

  block85306:
    // ----- branch  ----- WindowsCard.ssc(857,17)
    goto block85714;

  block85272:
    // ----- nop  ----- WindowsCard.ssc(851,28)
    // ----- load field  ----- WindowsCard.ssc(852,21)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(852,21)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- copy  ----- WindowsCard.ssc(852,21)
    stack2i := oprnd;
    // ----- call  ----- WindowsCard.ssc(852,21)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(853,21)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(853,21)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(853,21)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(853,21)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp38;
    $Heap[this, $exposeVersion] := temp38;
    // ----- frame condition  ----- WindowsCard.ssc(853,21)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(854,19)
    goto block85306;

  true85340to85680:
    assume !stack0b;
    goto block85680;

  false85340to85357:
    assume stack0b;
    goto block85357;

  block85357:
    // ----- call  ----- WindowsCard.ssc(860,25)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack0i := RTE.DP(this);
    // ----- load constant 4  ----- WindowsCard.ssc(860,25)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(860,25)
    stack1i := oprnd * stack1i;
    // ----- binary operator  ----- WindowsCard.ssc(860,25)
    stack0i := stack0i + stack1i;
    // ----- copy  ----- WindowsCard.ssc(860,25)
    address := stack0i;
    // ----- load constant 4  ----- WindowsCard.ssc(861,21)
    stack0i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(861,21)
    stack0i := address + stack0i;
    // ----- load constant 65536  ----- WindowsCard.ssc(861,21)
    stack1i := 65536;
    // ----- binary operator  ----- WindowsCard.ssc(861,21)
    // ----- branch  ----- WindowsCard.ssc(861,21)
    goto true85357to85646, false85357to85374;

  block85714:
    // ----- load field  ----- WindowsCard.ssc(877,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(877,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(877,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(877,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp39;
    $Heap[this, $exposeVersion] := temp39;
    // ----- frame condition  ----- WindowsCard.ssc(877,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(878,13)
    goto block86224;

  block86088:
    // ----- branch  ----- WindowsCard.ssc(906,13)
    goto block86224;

  true85935to86037:
    assume stack0i > address;
    goto block86037;

  false85935to85952:
    assume stack0i <= address;
    goto block85952;

  block86037:
    // ----- load constant 24  ----- WindowsCard.ssc(900,21)
    stack0i := 24;
    // ----- call  ----- WindowsCard.ssc(900,21)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(902,17)
    goto block86054;

  block85952:
    // ----- load constant 65532  ----- WindowsCard.ssc(892,17)
    stack0i := 65532;
    // ----- binary operator  ----- WindowsCard.ssc(892,17)
    // ----- branch  ----- WindowsCard.ssc(892,17)
    goto true85952to86037, false85952to85969;

  true86122to86156:
    assume stack0i == stack1i;
    goto block86156;

  false86122to86139:
    assume stack0i != stack1i;
    goto block86139;

  block86156:
    // ----- load constant 23  ----- WindowsCard.ssc(915,17)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(915,17)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(917,13)
    goto block86173;

  block86139:
    // ----- load field  ----- WindowsCard.ssc(913,17)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(913,17)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(913,17)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(913,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp40;
    $Heap[this, $exposeVersion] := temp40;
    // ----- frame condition  ----- WindowsCard.ssc(913,17)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(914,15)
    goto block86173;

  true82535to86190:
    assume local7 == stack0i;
    goto block86190;

  false82535to82552:
    assume local7 != stack0i;
    goto block82552;

  block86190:
    // ----- load field  ----- WindowsCard.ssc(921,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(921,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(921,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(921,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp41;
    $Heap[this, $exposeVersion] := temp41;
    // ----- frame condition  ----- WindowsCard.ssc(921,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(922,13)
    goto block86224;

  block82552:
    // ----- load constant 101  ----- WindowsCard.ssc(667,18)
    stack0i := 101;
    // ----- binary operator  ----- WindowsCard.ssc(667,18)
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto true82552to86207, false82552to82569;

  block85850:
    // ----- nop  ----- WindowsCard.ssc(881,24)
    // ----- load field  ----- WindowsCard.ssc(882,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(882,17)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(882,17)
    stack2i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(882,17)
    stack1i := stack1i - stack2i;
    // ----- load field  ----- WindowsCard.ssc(882,17)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(882,17)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(882,17)
    stack4i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(882,17)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(882,17)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(882,17)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(883,17)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(883,17)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(883,17)
    stack2i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(883,17)
    stack1i := stack1i - stack2i;
    // ----- load field  ----- WindowsCard.ssc(883,17)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(883,17)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 8  ----- WindowsCard.ssc(883,17)
    stack4i := 8;
    // ----- binary operator  ----- WindowsCard.ssc(883,17)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(883,17)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(883,17)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- branch  ----- WindowsCard.ssc(884,15)
    goto block85884;

  true85357to85646:
    assume stack0i > stack1i;
    goto block85646;

  false85357to85374:
    assume stack0i <= stack1i;
    goto block85374;

  block85646:
    // ----- load constant 24  ----- WindowsCard.ssc(870,25)
    stack0i := 24;
    // ----- call  ----- WindowsCard.ssc(870,25)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(872,17)
    goto block85663;

  block85374:
    // ----- load field  ----- WindowsCard.ssc(862,25)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(862,25)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- load field  ----- WindowsCard.ssc(862,25)
    assert this != null;
    stack2i := $Heap[this, RTE.MStackMaxSize];
    // ----- binary operator  ----- WindowsCard.ssc(862,25)
    stack1i := stack1i + stack2i;
    // ----- binary operator  ----- WindowsCard.ssc(862,25)
    // ----- branch  ----- WindowsCard.ssc(862,25)
    goto true85374to85612, false85374to85391;

  block85697:
    // ----- branch  ----- WindowsCard.ssc(875,17)
    goto block85714;

  true85952to86037:
    assume address >= stack0i;
    goto block86037;

  false85952to85969:
    assume address < stack0i;
    goto block85969;

  block85969:
    // ----- load field  ----- WindowsCard.ssc(893,21)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(893,21)
    assert this != null;
    stack1i := $Heap[this, RTE.MStackBase];
    // ----- binary operator  ----- WindowsCard.ssc(893,21)
    // ----- branch  ----- WindowsCard.ssc(893,21)
    goto true85969to86003, false85969to85986;

  true82552to86207:
    assume local7 == stack0i;
    goto block86207;

  false82552to82569:
    assume local7 != stack0i;
    goto block82569;

  block86207:
    // ----- load constant 10  ----- WindowsCard.ssc(924,13)
    stack0i := 10;
    // ----- store field  ----- WindowsCard.ssc(924,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp44;
    $Heap[this, $exposeVersion] := temp44;
    // ----- frame condition  ----- WindowsCard.ssc(924,13)
    assert !(IncludeInMainFrameCondition(RTE.CurrRTEMode) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.CurrRTEMode)) || !$IncludedInModifiesStar(RTE.CurrRTEMode)) && true);
    $Heap[this, RTE.CurrRTEMode] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- load field  ----- WindowsCard.ssc(925,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(925,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(925,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(925,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp45;
    $Heap[this, $exposeVersion] := temp45;
    // ----- frame condition  ----- WindowsCard.ssc(925,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(926,13)
    goto block86224;

  block82569:
    // ----- branch  ----- WindowsCard.ssc(667,18)
    goto block86224;

  true85374to85612:
    assume stack0i == stack1i;
    goto block85612;

  false85374to85391:
    assume stack0i != stack1i;
    goto block85391;

  block85612:
    // ----- load constant 23  ----- WindowsCard.ssc(867,29)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(867,29)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(869,21)
    goto block85629;

  block85391:
    // ----- serialized AssumeStatement  ----- WindowsCard.ssc(863,29)
    assume $Heap[this, RTE.MStackBase] mod 4 == 0 && $Heap[this, RTE.MStackMaxSize] mod 4 == 0 ==> ($Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize]) mod 4 == 0;
    goto block85595;

  block86054:
    // ----- load field  ----- WindowsCard.ssc(902,17)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 2  ----- WindowsCard.ssc(902,17)
    stack1i := 2;
    // ----- binary operator  ----- WindowsCard.ssc(902,17)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(902,17)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp42;
    $Heap[this, $exposeVersion] := temp42;
    // ----- frame condition  ----- WindowsCard.ssc(902,17)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(903,15)
    goto block86088;

  true85969to86003:
    assume stack0i == stack1i;
    goto block86003;

  false85969to85986:
    assume stack0i != stack1i;
    goto block85986;

  block86003:
    // ----- load constant 23  ----- WindowsCard.ssc(897,25)
    stack0i := 23;
    // ----- call  ----- WindowsCard.ssc(897,25)
    assert this != null;
    assume $Utter($Heap[this, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != this || $f != RTE.CurrRTEMode) && ($o != this || $f != RTE.RtnCode) && ($o != this || $f != $exposeVersion));
    call RTE.Terminate$System.Int32(this, stack0i);
    // ----- nop  ----- WindowsCard.ssc(899,17)
    goto block86020;

  block85986:
    // ----- load field  ----- WindowsCard.ssc(894,25)
    assert this != null;
    stack0o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(894,25)
    stack1i := address;
    // ----- load field  ----- WindowsCard.ssc(894,25)
    assert this != null;
    stack2o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(894,25)
    assert this != null;
    stack3i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(894,25)
    stack4i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(894,25)
    stack3i := stack3i - stack4i;
    // ----- call  ----- WindowsCard.ssc(894,25)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(894,25)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(895,25)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(895,25)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(895,25)
    stack0i := stack0i - stack1i;
    // ----- store field  ----- WindowsCard.ssc(895,25)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp46;
    $Heap[this, $exposeVersion] := temp46;
    // ----- frame condition  ----- WindowsCard.ssc(895,25)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(896,23)
    goto block86020;

  block86173:
    // ----- load field  ----- WindowsCard.ssc(917,13)
    assert this != null;
    stack0i := $Heap[this, RTE.PC];
    // ----- load constant 1  ----- WindowsCard.ssc(917,13)
    stack1i := 1;
    // ----- binary operator  ----- WindowsCard.ssc(917,13)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(917,13)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp43;
    $Heap[this, $exposeVersion] := temp43;
    // ----- frame condition  ----- WindowsCard.ssc(917,13)
    assert !(IncludeInMainFrameCondition(RTE.PC) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.PC)) || !$IncludedInModifiesStar(RTE.PC)) && true);
    $Heap[this, RTE.PC] := stack0i;
    assume IsPreHeap($Heap);
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(918,13)
    goto block86224;

  block85663:
    // ----- branch  ----- WindowsCard.ssc(872,19)
    goto block85697;

  block85629:
    // ----- branch  ----- WindowsCard.ssc(869,23)
    goto block85663;

  block85595:
    // ----- nop  ----- WindowsCard.ssc(863,36)
    // ----- load field  ----- WindowsCard.ssc(864,29)
    assert this != null;
    stack0o := $Heap[this, RTE.Scratch];
    // ----- load field  ----- WindowsCard.ssc(864,29)
    assert this != null;
    stack1i := $Heap[this, RTE.MSP];
    // ----- load field  ----- WindowsCard.ssc(864,29)
    assert this != null;
    stack2o := $Heap[this, RTE.Data];
    // ----- copy  ----- WindowsCard.ssc(864,29)
    stack3i := address;
    // ----- call  ----- WindowsCard.ssc(864,29)
    assume $Utter($Heap[stack2o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && true && true);
    call stack2i := RTE.ReadQuad$Memory$notnull$System.Int32(stack2o, stack3i);
    // ----- call  ----- WindowsCard.ssc(864,29)
    assume $Utter($Heap[stack0o, $ownerRef]);
    assert (forall<alpha> $o: ref, $f: Field alpha :: { $Heap[$o, $f] } $o != null && IncludeInMainFrameCondition($f) && old($Heap)[$o, $allocated] && (old($Heap)[$o, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[$o, $ownerRef], $inv] <: old($Heap)[$o, $ownerFrame]) || old($Heap)[old($Heap)[$o, $ownerRef], $localinv] == $BaseClass(old($Heap)[$o, $ownerFrame])) && ($o != old(this) || !($typeof(old(this)) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && true ==> IncludeInMainFrameCondition($f) && $Heap[$o, $allocated] && ($Heap[$o, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[$o, $ownerRef], $inv] <: $Heap[$o, $ownerFrame]) || $Heap[$Heap[$o, $ownerRef], $localinv] == $BaseClass($Heap[$o, $ownerFrame])) && ($o != stack0o || !($typeof(stack0o) <: DeclType($f)) || !$IncludedInModifiesStar($f)) && ($o != stack0o || $f != $exposeVersion));
    call RTE.WriteQuad$Memory$notnull$System.Int32$System.Int32(stack0o, stack1i, stack2i);
    // ----- load field  ----- WindowsCard.ssc(865,29)
    assert this != null;
    stack0i := $Heap[this, RTE.MSP];
    // ----- load constant 4  ----- WindowsCard.ssc(865,29)
    stack1i := 4;
    // ----- binary operator  ----- WindowsCard.ssc(865,29)
    stack0i := stack0i + stack1i;
    // ----- store field  ----- WindowsCard.ssc(865,29)
    assert this != null;
    assert $Heap[this, $ownerFrame] == $PeerGroupPlaceholder || !($Heap[$Heap[this, $ownerRef], $inv] <: $Heap[this, $ownerFrame]) || $Heap[$Heap[this, $ownerRef], $localinv] == $BaseClass($Heap[this, $ownerFrame]);
    havoc temp47;
    $Heap[this, $exposeVersion] := temp47;
    // ----- frame condition  ----- WindowsCard.ssc(865,29)
    assert !(IncludeInMainFrameCondition(RTE.MSP) && old($Heap)[this, $allocated] && (old($Heap)[this, $ownerFrame] == $PeerGroupPlaceholder || !(old($Heap)[old($Heap)[this, $ownerRef], $inv] <: old($Heap)[this, $ownerFrame]) || old($Heap)[old($Heap)[this, $ownerRef], $localinv] == $BaseClass(old($Heap)[this, $ownerFrame])) && (this != old(this) || !($typeof(old(this)) <: DeclType(RTE.MSP)) || !$IncludedInModifiesStar(RTE.MSP)) && true);
    $Heap[this, RTE.MSP] := stack0i;
    assume IsPreHeap($Heap);
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MStackBase] <= $Heap[this, RTE.MSP];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] <= $Heap[this, RTE.MStackBase] + $Heap[this, RTE.MStackMaxSize];
    assert !($Heap[this, $inv] <: RTE && $Heap[this, $localinv] != $BaseClass(RTE)) || $Heap[this, RTE.MSP] mod 4 == 0;
    assume IsHeap($Heap);
    // ----- branch  ----- WindowsCard.ssc(866,27)
    goto block85629;

  block86020:
    // ----- branch  ----- WindowsCard.ssc(899,19)
    goto block86054;
}



procedure RTE.DecodeOperandType$System.Int32(instr$in: int where InRange(instr$in, System.Int32)) returns ($result: int where InRange($result, System.Int32));
  free requires $BeingConstructed == null;
  free requires $PurityAxiomsCanBeAssumed;
  modifies $Heap, $ActivityIndicator;
  // user-declared postconditions
  ensures $result == 120 || $result == 121;
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE.DecodeOperandType$System.Int32(instr$in: int) returns ($result: int)
{
  var instr: int where InRange(instr, System.Int32);
  var return.value: int where InRange(return.value, System.Int32);
  var SS$Display.Return.Local: int where InRange(SS$Display.Return.Local, System.Int32);
  var stack0i: int;

  entry:
    instr := instr$in;
    goto block100946;

  block100946:
    goto block101031;

  block101031:
    // ----- load constant 120  ----- WindowsCard.ssc(934,5)
    return.value := 120;
    // ----- branch  ----- WindowsCard.ssc(934,5)
    goto block101082;

  block101082:
    // ----- nop  ----- WindowsCard.ssc(932,13)
    // ----- copy  ----- WindowsCard.ssc(932,13)
    SS$Display.Return.Local := return.value;
    // ----- copy  ----- WindowsCard.ssc(935,3)
    stack0i := return.value;
    // ----- return  ----- WindowsCard.ssc(935,3)
    $result := stack0i;
    return;
}


/*
procedure RTE..cctor();
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
  free ensures (forall $o: ref :: { $Heap[$o, $sharingMode] } old($Heap[$o, $sharingMode]) == $Heap[$o, $sharingMode]);



implementation RTE..cctor()
{

  entry:
    goto block101388;

  block101388:
    goto block101439;

  block101439:
    // ----- nop
    // ----- return
    return;
};
*/


