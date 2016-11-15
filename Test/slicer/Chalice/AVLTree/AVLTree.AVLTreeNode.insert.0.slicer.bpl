type Integer = int;
type Boolean = bool;
type HeapType = <a>[ref,Field (a)]a;
type MaskType = <a>[ref,Field (a)][PermissionComponent]int;
type CreditsType = [ref]int;
type ArgSeq = <T>[int]T;
type string = int;
type Field m0;
type ref;
type PermissionComponent;
type PartialHeapType;
type ModuleName;
type TypeName;
type Mu;
type Seq m0;
const null : ref;
const unique perm$R : PermissionComponent;
const unique perm$N : PermissionComponent;
const Permission$denominator : int;
const Permission$FullFraction : int;
const Permission$Zero : [PermissionComponent]int;
const Permission$Full : [PermissionComponent]int;
const ZeroMask : MaskType;
const unique joinable : Field (int);
const unique token#t : TypeName;
const unique forkK : Field (int);
const channelK : int;
const monitorK : int;
const predicateK : int;
const emptyPartialHeap : PartialHeapType;
const CurrentModule : ModuleName;
const CanAssumeFunctionDefs : bool;
const unique mu : Field (Mu);
const $LockBottom : Mu;
const unique held : Field (int);
const unique rdheld : Field (bool);
const ZeroCredits : CreditsType;
const unique AVLTree#t : TypeName;
const unique module#default : ModuleName;
const unique AVLTree.root : Field (ref);
const unique AVLTree.keys : Field (Seq (int));
const unique AVLTree.valid : Field (int);
const unique AVLTreeNode#t : TypeName;
const unique AVLTreeNode.key : Field (int);
const unique AVLTreeNode.height : Field (int);
const unique AVLTreeNode.left : Field (ref);
const unique AVLTreeNode.right : Field (ref);
const unique AVLTreeNode.keys : Field (Seq (int));
const unique AVLTreeNode.balanceFactor : Field (int);
const unique AVLTreeNode.valid : Field (int);
const $old_Heap : HeapType;
const $old_Mask : MaskType;
const $old_SecMask : MaskType;
const $old_Credits : CreditsType;
function Fractions(int) : int;
function IsGoodState(PartialHeapType) : bool;
function combine(PartialHeapType,PartialHeapType) : PartialHeapType;
function heapFragment <T> (T) : PartialHeapType;
function dtype(ref) : TypeName;
function MuBelow(Mu,Mu) : bool;
function Acquire$Heap(int) : HeapType;
function Acquire$Mask(int) : MaskType;
function Acquire$SecMask(int) : MaskType;
function Acquire$Credits(int) : CreditsType;
function LastSeen$Heap(Mu,int) : HeapType;
function LastSeen$Mask(Mu,int) : MaskType;
function LastSeen$SecMask(Mu,int) : MaskType;
function LastSeen$Credits(Mu,int) : CreditsType;
function wf(HeapType,MaskType,MaskType) : bool;
function IsGoodInhaleState(HeapType,HeapType,MaskType,MaskType) : bool;
function IsGoodExhaleState(HeapType,HeapType,MaskType,MaskType) : bool;
function CanRead <T> (MaskType,MaskType,ref,Field (T)) : bool;
function CanReadForSure <T> (MaskType,ref,Field (T)) : bool;
function CanWrite <T> (MaskType,ref,Field (T)) : bool;
function IsGoodMask(MaskType) : bool;
function DecPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function DecEpsilons <T> (MaskType,ref,Field (T),int) : MaskType;
function IncPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function IncEpsilons <T> (MaskType,ref,Field (T),int) : MaskType;
function Havocing <T,U> (HeapType,ref,Field (T),U) : HeapType;
function Call$Heap(int) : HeapType;
function Call$Mask(int) : MaskType;
function Call$SecMask(int) : MaskType;
function Call$Credits(int) : CreditsType;
function Call$Args(int) : ArgSeq;
function EmptyMask(MaskType) : bool;
function EmptyCredits(CreditsType) : bool;
function NonPredicateField <T> (Field (T)) : bool;
function PredicateField <T> (Field (T)) : bool;
function submask(MaskType,MaskType) : bool;
function ite <T> (bool,T,T) : T;
function Seq#Length <T> (Seq (T)) : int;
function Seq#Empty <T> () : Seq (T);
function Seq#Singleton <T> (T) : Seq (T);
function Seq#Build <T> (Seq (T),int,T,int) : Seq (T);
function Seq#Append <T> (Seq (T),Seq (T)) : Seq (T);
function Seq#Index <T> (Seq (T),int) : T;
function Seq#Contains <T> (Seq (T),T) : bool;
function Seq#Equal <T> (Seq (T),Seq (T)) : bool;
function Seq#SameUntil <T> (Seq (T),Seq (T),int) : bool;
function Seq#Take <T> (Seq (T),int) : Seq (T);
function Seq#Drop <T> (Seq (T),int) : Seq (T);
function Seq#Range(int,int) : Seq (int);
function #AVLTree.valid#trigger(ref) : bool;
function #AVLTreeNode.valid#trigger(ref) : bool;
var Heap : HeapType;
var Mask : MaskType;
var SecMask : MaskType;
var Credits : CreditsType;
var this#165 : ref;
var nl#12 : ref;
var this#170 : ref;
var this#172 : ref;
var r#174 : ref;
var this#177 : ref;
var this#179 : ref;
var r#180 : ref;
var this#185 : ref;
var nr#16 : ref;
var this#190 : ref;
var this#192 : ref;
var r#194 : ref;
var this#197 : ref;
var this#199 : ref;
var r#200 : ref;
var this#205 : ref;
var methodK#_261 : int;
var Mask_$_0 : MaskType;
var Mask_$_1 : MaskType;
var Mask_$_2 : MaskType;
var Mask_$_3 : MaskType;
var unfoldK#_262 : int;
var Mask_$_4 : MaskType;
var Heap_$_1 : HeapType;
var Mask_$_5 : MaskType;
var Mask_$_6 : MaskType;
var Mask_$_7 : MaskType;
var Mask_$_8 : MaskType;
var Mask_$_9 : MaskType;
var Mask_$_10 : MaskType;
var Mask_$_12 : MaskType;
var Mask_$_14 : MaskType;
var Mask_$_16 : MaskType;
var Mask_$_18 : MaskType;
var Mask_$_20 : MaskType;
var Mask_$_22 : MaskType;
var Mask_$_24 : MaskType;
var Mask_$_26 : MaskType;
var cond#_284_$_0 : bool;
var cond#_314_$_0 : bool;
var cond#_407_$_0 : bool;
var methodCallK#_428 : int;
var this#192_$_0 : ref;
var exhaleMask#_430_$_0 : MaskType;
var exhaleMask#_430_$_1 : MaskType;
var exhaleMask#_430_$_2 : MaskType;
var exhaleMask#_430_$_3 : MaskType;
var exhaleHeap#_429_$_0 : HeapType;
var r#194_$_0 : ref;
var Mask_$_38 : MaskType;
var Mask_$_39 : MaskType;
var Mask_$_40 : MaskType;
var Mask_$_41 : MaskType;
var Mask_$_42 : MaskType;
var Heap_$_2 : HeapType;
var nr#16_$_0 : ref;
var Heap_$_3 : HeapType;
var methodCallK#_441 : int;
var exhaleMask#_443_$_0 : MaskType;
var exhaleMask#_443_$_2 : MaskType;
var exhaleMask#_443_$_3 : MaskType;
var exhaleMask#_443_$_5 : MaskType;
var exhaleMask#_443_$_7 : MaskType;
var exhaleMask#_443_$_9 : MaskType;
var exhaleHeap#_442_$_0 : HeapType;
var Mask_$_43 : MaskType;
var Mask_$_45 : MaskType;
var Mask_$_47 : MaskType;
var Mask_$_48 : MaskType;
var Mask_$_50 : MaskType;
var Mask_$_52 : MaskType;
var bf#198_$_0 : int;
var cond#_452_$_0 : bool;
var methodCallK#_480 : int;
var exhaleMask#_482_$_0 : MaskType;
var exhaleMask#_482_$_1 : MaskType;
var exhaleMask#_482_$_2 : MaskType;
var exhaleMask#_482_$_3 : MaskType;
var exhaleMask#_482_$_4 : MaskType;
var exhaleMask#_482_$_5 : MaskType;
var exhaleMask#_482_$_7 : MaskType;
var exhaleMask#_482_$_9 : MaskType;
var exhaleMask#_482_$_11 : MaskType;
var exhaleMask#_482_$_13 : MaskType;
var exhaleMask#_482_$_15 : MaskType;
var exhaleMask#_482_$_17 : MaskType;
var exhaleMask#_482_$_19 : MaskType;
var exhaleMask#_482_$_21 : MaskType;
var exhaleHeap#_481_$_0 : HeapType;
var Mask_$_53 : MaskType;
var Mask_$_54 : MaskType;
var Mask_$_55 : MaskType;
var Mask_$_56 : MaskType;
var Heap_$_6 : HeapType;
var Mask_$_99 : MaskType;
var r#10_$_0 : ref;
var exhaleMask#_500_$_0 : MaskType;
var exhaleMask#_500_$_1 : MaskType;
var exhaleMask#_500_$_2 : MaskType;
var exhaleMask#_500_$_3 : MaskType;
var exhaleHeap#_499_$_0 : HeapType;
var exhaleMask#_482_$_20 : MaskType;
var exhaleMask#_482_$_18 : MaskType;
var exhaleMask#_482_$_16 : MaskType;
var exhaleMask#_482_$_14 : MaskType;
var exhaleMask#_482_$_12 : MaskType;
var exhaleMask#_482_$_10 : MaskType;
var exhaleMask#_482_$_8 : MaskType;
var exhaleMask#_482_$_6 : MaskType;
var methodCallK#_457 : int;
var exhaleMask#_459_$_0 : MaskType;
var exhaleMask#_459_$_1 : MaskType;
var exhaleMask#_459_$_2 : MaskType;
var exhaleMask#_459_$_3 : MaskType;
var exhaleMask#_459_$_4 : MaskType;
var exhaleMask#_459_$_5 : MaskType;
var exhaleMask#_459_$_7 : MaskType;
var exhaleMask#_459_$_9 : MaskType;
var exhaleMask#_459_$_11 : MaskType;
var exhaleMask#_459_$_13 : MaskType;
var exhaleMask#_459_$_14 : MaskType;
var exhaleMask#_459_$_15 : MaskType;
var exhaleMask#_459_$_16 : MaskType;
var exhaleMask#_459_$_17 : MaskType;
var exhaleHeap#_458_$_0 : HeapType;
var r#200_$_0 : ref;
var Mask_$_57 : MaskType;
var Mask_$_58 : MaskType;
var Mask_$_59 : MaskType;
var Mask_$_60 : MaskType;
var exhaleMask#_459_$_12 : MaskType;
var exhaleMask#_459_$_10 : MaskType;
var exhaleMask#_459_$_8 : MaskType;
var exhaleMask#_459_$_6 : MaskType;
var Mask_$_51 : MaskType;
var Mask_$_49 : MaskType;
var Mask_$_46 : MaskType;
var Mask_$_44 : MaskType;
var exhaleMask#_443_$_8 : MaskType;
var exhaleMask#_443_$_6 : MaskType;
var exhaleMask#_443_$_4 : MaskType;
var exhaleMask#_443_$_1 : MaskType;
var nw#_408_$_0 : ref;
var Mask_$_27 : MaskType;
var Mask_$_28 : MaskType;
var Mask_$_29 : MaskType;
var Mask_$_30 : MaskType;
var Mask_$_31 : MaskType;
var Mask_$_32 : MaskType;
var Mask_$_33 : MaskType;
var methodCallK#_413 : int;
var exhaleMask#_415_$_0 : MaskType;
var exhaleMask#_415_$_1 : MaskType;
var exhaleMask#_415_$_2 : MaskType;
var exhaleMask#_415_$_3 : MaskType;
var exhaleMask#_415_$_4 : MaskType;
var exhaleMask#_415_$_5 : MaskType;
var exhaleHeap#_414_$_0 : HeapType;
var Mask_$_34 : MaskType;
var Mask_$_35 : MaskType;
var Mask_$_36 : MaskType;
var Mask_$_37 : MaskType;
var cond#_315_$_0 : bool;
var methodCallK#_336 : int;
var this#172_$_0 : ref;
var exhaleMask#_338_$_0 : MaskType;
var exhaleMask#_338_$_1 : MaskType;
var exhaleMask#_338_$_2 : MaskType;
var exhaleMask#_338_$_3 : MaskType;
var exhaleHeap#_337_$_0 : HeapType;
var r#174_$_0 : ref;
var Mask_$_72 : MaskType;
var Mask_$_73 : MaskType;
var Mask_$_74 : MaskType;
var Mask_$_75 : MaskType;
var Mask_$_76 : MaskType;
var Heap_$_4 : HeapType;
var nl#12_$_0 : ref;
var Heap_$_5 : HeapType;
var methodCallK#_349 : int;
var exhaleMask#_351_$_0 : MaskType;
var exhaleMask#_351_$_2 : MaskType;
var exhaleMask#_351_$_3 : MaskType;
var exhaleMask#_351_$_5 : MaskType;
var exhaleMask#_351_$_7 : MaskType;
var exhaleMask#_351_$_9 : MaskType;
var exhaleHeap#_350_$_0 : HeapType;
var Mask_$_77 : MaskType;
var Mask_$_79 : MaskType;
var Mask_$_81 : MaskType;
var Mask_$_82 : MaskType;
var Mask_$_84 : MaskType;
var Mask_$_86 : MaskType;
var bf#178_$_0 : int;
var cond#_360_$_0 : bool;
var methodCallK#_388 : int;
var exhaleMask#_390_$_0 : MaskType;
var exhaleMask#_390_$_1 : MaskType;
var exhaleMask#_390_$_2 : MaskType;
var exhaleMask#_390_$_3 : MaskType;
var exhaleMask#_390_$_4 : MaskType;
var exhaleMask#_390_$_5 : MaskType;
var exhaleMask#_390_$_7 : MaskType;
var exhaleMask#_390_$_9 : MaskType;
var exhaleMask#_390_$_11 : MaskType;
var exhaleMask#_390_$_13 : MaskType;
var exhaleMask#_390_$_15 : MaskType;
var exhaleMask#_390_$_17 : MaskType;
var exhaleMask#_390_$_19 : MaskType;
var exhaleMask#_390_$_21 : MaskType;
var exhaleHeap#_389_$_0 : HeapType;
var Mask_$_87 : MaskType;
var Mask_$_88 : MaskType;
var Mask_$_89 : MaskType;
var Mask_$_90 : MaskType;
var exhaleMask#_390_$_20 : MaskType;
var exhaleMask#_390_$_18 : MaskType;
var exhaleMask#_390_$_16 : MaskType;
var exhaleMask#_390_$_14 : MaskType;
var exhaleMask#_390_$_12 : MaskType;
var exhaleMask#_390_$_10 : MaskType;
var exhaleMask#_390_$_8 : MaskType;
var exhaleMask#_390_$_6 : MaskType;
var methodCallK#_365 : int;
var exhaleMask#_367_$_0 : MaskType;
var exhaleMask#_367_$_1 : MaskType;
var exhaleMask#_367_$_2 : MaskType;
var exhaleMask#_367_$_3 : MaskType;
var exhaleMask#_367_$_4 : MaskType;
var exhaleMask#_367_$_5 : MaskType;
var exhaleMask#_367_$_6 : MaskType;
var exhaleMask#_367_$_7 : MaskType;
var exhaleMask#_367_$_8 : MaskType;
var exhaleMask#_367_$_9 : MaskType;
var exhaleMask#_367_$_11 : MaskType;
var exhaleMask#_367_$_13 : MaskType;
var exhaleMask#_367_$_15 : MaskType;
var exhaleMask#_367_$_17 : MaskType;
var exhaleHeap#_366_$_0 : HeapType;
var r#180_$_0 : ref;
var Mask_$_91 : MaskType;
var Mask_$_92 : MaskType;
var Mask_$_93 : MaskType;
var Mask_$_94 : MaskType;
var exhaleMask#_367_$_16 : MaskType;
var exhaleMask#_367_$_14 : MaskType;
var exhaleMask#_367_$_12 : MaskType;
var exhaleMask#_367_$_10 : MaskType;
var Mask_$_85 : MaskType;
var Mask_$_83 : MaskType;
var Mask_$_80 : MaskType;
var Mask_$_78 : MaskType;
var exhaleMask#_351_$_8 : MaskType;
var exhaleMask#_351_$_6 : MaskType;
var exhaleMask#_351_$_4 : MaskType;
var exhaleMask#_351_$_1 : MaskType;
var nw#_316_$_0 : ref;
var Mask_$_61 : MaskType;
var Mask_$_62 : MaskType;
var Mask_$_63 : MaskType;
var Mask_$_64 : MaskType;
var Mask_$_65 : MaskType;
var Mask_$_66 : MaskType;
var Mask_$_67 : MaskType;
var methodCallK#_321 : int;
var exhaleMask#_323_$_0 : MaskType;
var exhaleMask#_323_$_1 : MaskType;
var exhaleMask#_323_$_2 : MaskType;
var exhaleMask#_323_$_3 : MaskType;
var exhaleMask#_323_$_4 : MaskType;
var exhaleMask#_323_$_5 : MaskType;
var exhaleHeap#_322_$_0 : HeapType;
var Mask_$_68 : MaskType;
var Mask_$_69 : MaskType;
var Mask_$_70 : MaskType;
var Mask_$_71 : MaskType;
var exhaleHeap#_289_$_0 : HeapType;
var methodCallK#_295 : int;
var exhaleMask#_297_$_0 : MaskType;
var exhaleMask#_297_$_1 : MaskType;
var exhaleMask#_297_$_2 : MaskType;
var exhaleMask#_297_$_3 : MaskType;
var exhaleMask#_297_$_4 : MaskType;
var exhaleMask#_297_$_5 : MaskType;
var exhaleMask#_297_$_7 : MaskType;
var exhaleMask#_297_$_9 : MaskType;
var exhaleMask#_297_$_11 : MaskType;
var exhaleMask#_297_$_13 : MaskType;
var exhaleMask#_297_$_15 : MaskType;
var exhaleMask#_297_$_17 : MaskType;
var exhaleMask#_297_$_19 : MaskType;
var exhaleMask#_297_$_21 : MaskType;
var exhaleHeap#_296_$_0 : HeapType;
var Mask_$_95 : MaskType;
var Mask_$_96 : MaskType;
var Mask_$_97 : MaskType;
var Mask_$_98 : MaskType;
var exhaleMask#_297_$_20 : MaskType;
var exhaleMask#_297_$_18 : MaskType;
var exhaleMask#_297_$_16 : MaskType;
var exhaleMask#_297_$_14 : MaskType;
var exhaleMask#_297_$_12 : MaskType;
var exhaleMask#_297_$_10 : MaskType;
var exhaleMask#_297_$_8 : MaskType;
var exhaleMask#_297_$_6 : MaskType;
var Mask_$_25 : MaskType;
var Mask_$_23 : MaskType;
var Mask_$_21 : MaskType;
var Mask_$_19 : MaskType;
var Mask_$_17 : MaskType;
var Mask_$_15 : MaskType;
var Mask_$_13 : MaskType;
var Mask_$_11 : MaskType;
var oldVers#_282_$_0 : int;
var Heap_$_0 : HeapType;
var newVers#_283_$_0 : int;
var oldVers#_282 : int;
var newVers#_283 : int;
var cond#_284 : bool;
var assertHeap#_285 : HeapType;
var assertMask#_286 : MaskType;
var assertSecMask#_287 : MaskType;
var assertCredits#_288 : CreditsType;
var exhaleMask#_290 : MaskType;
var exhaleHeap#_289 : HeapType;
var callHeap#_291 : HeapType;
var callMask#_292 : MaskType;
var callSecMask#_293 : MaskType;
var callCredits#_294 : CreditsType;
var exhaleMask#_297 : MaskType;
var exhaleHeap#_296 : HeapType;
var cond#_314 : bool;
var cond#_315 : bool;
var nw#_316 : ref;
var k#171 : int;
var callHeap#_317 : HeapType;
var callMask#_318 : MaskType;
var callSecMask#_319 : MaskType;
var callCredits#_320 : CreditsType;
var exhaleMask#_323 : MaskType;
var exhaleHeap#_322 : HeapType;
var k#173 : int;
var callHeap#_332 : HeapType;
var callMask#_333 : MaskType;
var callSecMask#_334 : MaskType;
var callCredits#_335 : CreditsType;
var exhaleMask#_338 : MaskType;
var exhaleHeap#_337 : HeapType;
var bf#14 : int;
var bf#178 : int;
var callHeap#_345 : HeapType;
var callMask#_346 : MaskType;
var callSecMask#_347 : MaskType;
var callCredits#_348 : CreditsType;
var exhaleMask#_351 : MaskType;
var exhaleHeap#_350 : HeapType;
var cond#_360 : bool;
var callHeap#_361 : HeapType;
var callMask#_362 : MaskType;
var callSecMask#_363 : MaskType;
var callCredits#_364 : CreditsType;
var exhaleMask#_367 : MaskType;
var exhaleHeap#_366 : HeapType;
var callHeap#_384 : HeapType;
var callMask#_385 : MaskType;
var callSecMask#_386 : MaskType;
var callCredits#_387 : CreditsType;
var exhaleMask#_390 : MaskType;
var exhaleHeap#_389 : HeapType;
var cond#_407 : bool;
var nw#_408 : ref;
var k#191 : int;
var callHeap#_409 : HeapType;
var callMask#_410 : MaskType;
var callSecMask#_411 : MaskType;
var callCredits#_412 : CreditsType;
var exhaleMask#_415 : MaskType;
var exhaleHeap#_414 : HeapType;
var k#193 : int;
var callHeap#_424 : HeapType;
var callMask#_425 : MaskType;
var callSecMask#_426 : MaskType;
var callCredits#_427 : CreditsType;
var exhaleMask#_430 : MaskType;
var exhaleHeap#_429 : HeapType;
var bf#18 : int;
var bf#198 : int;
var callHeap#_437 : HeapType;
var callMask#_438 : MaskType;
var callSecMask#_439 : MaskType;
var callCredits#_440 : CreditsType;
var exhaleMask#_443 : MaskType;
var exhaleHeap#_442 : HeapType;
var cond#_452 : bool;
var callHeap#_453 : HeapType;
var callMask#_454 : MaskType;
var callSecMask#_455 : MaskType;
var callCredits#_456 : CreditsType;
var exhaleMask#_459 : MaskType;
var exhaleHeap#_458 : HeapType;
var callHeap#_476 : HeapType;
var callMask#_477 : MaskType;
var callSecMask#_478 : MaskType;
var callCredits#_479 : CreditsType;
var exhaleMask#_482 : MaskType;
var exhaleHeap#_481 : HeapType;
var exhaleMask#_500 : MaskType;
var exhaleHeap#_499 : HeapType;
procedure AVLTreeNode.insert (this : ref,k#9 : int) returns (r#10 : ref)
{
	var methodK#_261 : int;
	var unfoldK#_262 : int;
	var oldVers#_282 : int;
	var newVers#_283 : int;
	var cond#_284 : bool;
	var assertHeap#_285 : HeapType;
	var assertMask#_286 : MaskType;
	var assertSecMask#_287 : MaskType;
	var assertCredits#_288 : CreditsType;
	var exhaleMask#_290 : MaskType;
	var exhaleHeap#_289 : HeapType;
	var methodCallK#_295 : int;
	var this#165 : ref;
	var callHeap#_291 : HeapType;
	var callMask#_292 : MaskType;
	var callSecMask#_293 : MaskType;
	var callCredits#_294 : CreditsType;
	var exhaleMask#_297 : MaskType;
	var exhaleHeap#_296 : HeapType;
	var cond#_314 : bool;
	var nl#12 : ref;
	var cond#_315 : bool;
	var nw#_316 : ref;
	var methodCallK#_321 : int;
	var this#170 : ref;
	var k#171 : int;
	var callHeap#_317 : HeapType;
	var callMask#_318 : MaskType;
	var callSecMask#_319 : MaskType;
	var callCredits#_320 : CreditsType;
	var exhaleMask#_323 : MaskType;
	var exhaleHeap#_322 : HeapType;
	var methodCallK#_336 : int;
	var this#172 : ref;
	var k#173 : int;
	var r#174 : ref;
	var callHeap#_332 : HeapType;
	var callMask#_333 : MaskType;
	var callSecMask#_334 : MaskType;
	var callCredits#_335 : CreditsType;
	var exhaleMask#_338 : MaskType;
	var exhaleHeap#_337 : HeapType;
	var bf#14 : int;
	var methodCallK#_349 : int;
	var this#177 : ref;
	var bf#178 : int;
	var callHeap#_345 : HeapType;
	var callMask#_346 : MaskType;
	var callSecMask#_347 : MaskType;
	var callCredits#_348 : CreditsType;
	var exhaleMask#_351 : MaskType;
	var exhaleHeap#_350 : HeapType;
	var cond#_360 : bool;
	var methodCallK#_365 : int;
	var this#179 : ref;
	var r#180 : ref;
	var callHeap#_361 : HeapType;
	var callMask#_362 : MaskType;
	var callSecMask#_363 : MaskType;
	var callCredits#_364 : CreditsType;
	var exhaleMask#_367 : MaskType;
	var exhaleHeap#_366 : HeapType;
	var methodCallK#_388 : int;
	var this#185 : ref;
	var callHeap#_384 : HeapType;
	var callMask#_385 : MaskType;
	var callSecMask#_386 : MaskType;
	var callCredits#_387 : CreditsType;
	var exhaleMask#_390 : MaskType;
	var exhaleHeap#_389 : HeapType;
	var nr#16 : ref;
	var cond#_407 : bool;
	var nw#_408 : ref;
	var methodCallK#_413 : int;
	var this#190 : ref;
	var k#191 : int;
	var callHeap#_409 : HeapType;
	var callMask#_410 : MaskType;
	var callSecMask#_411 : MaskType;
	var callCredits#_412 : CreditsType;
	var exhaleMask#_415 : MaskType;
	var exhaleHeap#_414 : HeapType;
	var methodCallK#_428 : int;
	var this#192 : ref;
	var k#193 : int;
	var r#194 : ref;
	var callHeap#_424 : HeapType;
	var callMask#_425 : MaskType;
	var callSecMask#_426 : MaskType;
	var callCredits#_427 : CreditsType;
	var exhaleMask#_430 : MaskType;
	var exhaleHeap#_429 : HeapType;
	var bf#18 : int;
	var methodCallK#_441 : int;
	var this#197 : ref;
	var bf#198 : int;
	var callHeap#_437 : HeapType;
	var callMask#_438 : MaskType;
	var callSecMask#_439 : MaskType;
	var callCredits#_440 : CreditsType;
	var exhaleMask#_443 : MaskType;
	var exhaleHeap#_442 : HeapType;
	var cond#_452 : bool;
	var methodCallK#_457 : int;
	var this#199 : ref;
	var r#200 : ref;
	var callHeap#_453 : HeapType;
	var callMask#_454 : MaskType;
	var callSecMask#_455 : MaskType;
	var callCredits#_456 : CreditsType;
	var exhaleMask#_459 : MaskType;
	var exhaleHeap#_458 : HeapType;
	var methodCallK#_480 : int;
	var this#205 : ref;
	var callHeap#_476 : HeapType;
	var callMask#_477 : MaskType;
	var callSecMask#_478 : MaskType;
	var callCredits#_479 : CreditsType;
	var exhaleMask#_482 : MaskType;
	var exhaleHeap#_481 : HeapType;
	var exhaleMask#_500 : MaskType;
	var exhaleHeap#_499 : HeapType;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var Mask_$_3 : MaskType;
	var Mask_$_4 : MaskType;
	var oldVers#_282_$_0 : int;
	var newVers#_283_$_0 : int;
	var Heap_$_0 : HeapType;
	var Heap_$_1 : HeapType;
	var Mask_$_5 : MaskType;
	var Mask_$_6 : MaskType;
	var Mask_$_7 : MaskType;
	var Mask_$_8 : MaskType;
	var Mask_$_9 : MaskType;
	var Mask_$_10 : MaskType;
	var Mask_$_11 : MaskType;
	var Mask_$_12 : MaskType;
	var Mask_$_13 : MaskType;
	var Mask_$_14 : MaskType;
	var Mask_$_15 : MaskType;
	var Mask_$_16 : MaskType;
	var Mask_$_17 : MaskType;
	var Mask_$_18 : MaskType;
	var Mask_$_19 : MaskType;
	var Mask_$_20 : MaskType;
	var Mask_$_21 : MaskType;
	var Mask_$_22 : MaskType;
	var Mask_$_23 : MaskType;
	var Mask_$_24 : MaskType;
	var Mask_$_25 : MaskType;
	var Mask_$_26 : MaskType;
	var cond#_284_$_0 : bool;
	var exhaleHeap#_289_$_0 : HeapType;
	var exhaleHeap#_296_$_0 : HeapType;
	var cond#_314_$_0 : bool;
	var cond#_315_$_0 : bool;
	var cond#_407_$_0 : bool;
	var nw#_408_$_0 : ref;
	var Mask_$_27 : MaskType;
	var Mask_$_28 : MaskType;
	var Mask_$_29 : MaskType;
	var Mask_$_30 : MaskType;
	var Mask_$_31 : MaskType;
	var Mask_$_32 : MaskType;
	var Mask_$_33 : MaskType;
	var exhaleHeap#_414_$_0 : HeapType;
	var exhaleMask#_415_$_0 : MaskType;
	var exhaleMask#_415_$_1 : MaskType;
	var exhaleMask#_415_$_2 : MaskType;
	var exhaleMask#_415_$_3 : MaskType;
	var exhaleMask#_415_$_4 : MaskType;
	var exhaleMask#_415_$_5 : MaskType;
	var Mask_$_34 : MaskType;
	var Mask_$_35 : MaskType;
	var Mask_$_36 : MaskType;
	var Mask_$_37 : MaskType;
	var this#192_$_0 : ref;
	var exhaleHeap#_429_$_0 : HeapType;
	var exhaleMask#_430_$_0 : MaskType;
	var exhaleMask#_430_$_1 : MaskType;
	var exhaleMask#_430_$_2 : MaskType;
	var exhaleMask#_430_$_3 : MaskType;
	var r#194_$_0 : ref;
	var Mask_$_38 : MaskType;
	var Mask_$_39 : MaskType;
	var Mask_$_40 : MaskType;
	var Mask_$_41 : MaskType;
	var Mask_$_42 : MaskType;
	var Heap_$_2 : HeapType;
	var nr#16_$_0 : ref;
	var Heap_$_3 : HeapType;
	var exhaleHeap#_442_$_0 : HeapType;
	var exhaleMask#_443_$_0 : MaskType;
	var exhaleMask#_443_$_1 : MaskType;
	var exhaleMask#_443_$_2 : MaskType;
	var exhaleMask#_443_$_3 : MaskType;
	var exhaleMask#_443_$_4 : MaskType;
	var exhaleMask#_443_$_5 : MaskType;
	var exhaleMask#_443_$_6 : MaskType;
	var exhaleMask#_443_$_7 : MaskType;
	var exhaleMask#_443_$_8 : MaskType;
	var exhaleMask#_443_$_9 : MaskType;
	var bf#198_$_0 : int;
	var Mask_$_43 : MaskType;
	var Mask_$_44 : MaskType;
	var Mask_$_45 : MaskType;
	var Mask_$_46 : MaskType;
	var Mask_$_47 : MaskType;
	var Mask_$_48 : MaskType;
	var Mask_$_49 : MaskType;
	var Mask_$_50 : MaskType;
	var Mask_$_51 : MaskType;
	var Mask_$_52 : MaskType;
	var cond#_452_$_0 : bool;
	var exhaleHeap#_458_$_0 : HeapType;
	var exhaleHeap#_481_$_0 : HeapType;
	var exhaleMask#_482_$_0 : MaskType;
	var exhaleMask#_482_$_1 : MaskType;
	var exhaleMask#_482_$_2 : MaskType;
	var exhaleMask#_482_$_3 : MaskType;
	var exhaleMask#_482_$_4 : MaskType;
	var exhaleMask#_482_$_5 : MaskType;
	var exhaleMask#_482_$_6 : MaskType;
	var exhaleMask#_482_$_7 : MaskType;
	var exhaleMask#_482_$_8 : MaskType;
	var exhaleMask#_482_$_9 : MaskType;
	var exhaleMask#_482_$_10 : MaskType;
	var exhaleMask#_482_$_11 : MaskType;
	var exhaleMask#_482_$_12 : MaskType;
	var exhaleMask#_482_$_13 : MaskType;
	var exhaleMask#_482_$_14 : MaskType;
	var exhaleMask#_482_$_15 : MaskType;
	var exhaleMask#_482_$_16 : MaskType;
	var exhaleMask#_482_$_17 : MaskType;
	var exhaleMask#_482_$_18 : MaskType;
	var exhaleMask#_482_$_19 : MaskType;
	var exhaleMask#_482_$_20 : MaskType;
	var exhaleMask#_482_$_21 : MaskType;
	var Mask_$_53 : MaskType;
	var Mask_$_54 : MaskType;
	var Mask_$_55 : MaskType;
	var Mask_$_56 : MaskType;
	var exhaleMask#_459_$_0 : MaskType;
	var exhaleMask#_459_$_1 : MaskType;
	var exhaleMask#_459_$_2 : MaskType;
	var exhaleMask#_459_$_3 : MaskType;
	var exhaleMask#_459_$_4 : MaskType;
	var exhaleMask#_459_$_5 : MaskType;
	var exhaleMask#_459_$_6 : MaskType;
	var exhaleMask#_459_$_7 : MaskType;
	var exhaleMask#_459_$_8 : MaskType;
	var exhaleMask#_459_$_9 : MaskType;
	var exhaleMask#_459_$_10 : MaskType;
	var exhaleMask#_459_$_11 : MaskType;
	var exhaleMask#_459_$_12 : MaskType;
	var exhaleMask#_459_$_13 : MaskType;
	var exhaleMask#_459_$_14 : MaskType;
	var exhaleMask#_459_$_15 : MaskType;
	var exhaleMask#_459_$_16 : MaskType;
	var exhaleMask#_459_$_17 : MaskType;
	var r#200_$_0 : ref;
	var Mask_$_57 : MaskType;
	var Mask_$_58 : MaskType;
	var Mask_$_59 : MaskType;
	var Mask_$_60 : MaskType;
	var nw#_316_$_0 : ref;
	var Mask_$_61 : MaskType;
	var Mask_$_62 : MaskType;
	var Mask_$_63 : MaskType;
	var Mask_$_64 : MaskType;
	var Mask_$_65 : MaskType;
	var Mask_$_66 : MaskType;
	var Mask_$_67 : MaskType;
	var exhaleHeap#_322_$_0 : HeapType;
	var exhaleMask#_323_$_0 : MaskType;
	var exhaleMask#_323_$_1 : MaskType;
	var exhaleMask#_323_$_2 : MaskType;
	var exhaleMask#_323_$_3 : MaskType;
	var exhaleMask#_323_$_4 : MaskType;
	var exhaleMask#_323_$_5 : MaskType;
	var Mask_$_68 : MaskType;
	var Mask_$_69 : MaskType;
	var Mask_$_70 : MaskType;
	var Mask_$_71 : MaskType;
	var this#172_$_0 : ref;
	var exhaleHeap#_337_$_0 : HeapType;
	var exhaleMask#_338_$_0 : MaskType;
	var exhaleMask#_338_$_1 : MaskType;
	var exhaleMask#_338_$_2 : MaskType;
	var exhaleMask#_338_$_3 : MaskType;
	var r#174_$_0 : ref;
	var Mask_$_72 : MaskType;
	var Mask_$_73 : MaskType;
	var Mask_$_74 : MaskType;
	var Mask_$_75 : MaskType;
	var Mask_$_76 : MaskType;
	var Heap_$_4 : HeapType;
	var nl#12_$_0 : ref;
	var Heap_$_5 : HeapType;
	var exhaleHeap#_350_$_0 : HeapType;
	var exhaleMask#_351_$_0 : MaskType;
	var exhaleMask#_351_$_1 : MaskType;
	var exhaleMask#_351_$_2 : MaskType;
	var exhaleMask#_351_$_3 : MaskType;
	var exhaleMask#_351_$_4 : MaskType;
	var exhaleMask#_351_$_5 : MaskType;
	var exhaleMask#_351_$_6 : MaskType;
	var exhaleMask#_351_$_7 : MaskType;
	var exhaleMask#_351_$_8 : MaskType;
	var exhaleMask#_351_$_9 : MaskType;
	var bf#178_$_0 : int;
	var Mask_$_77 : MaskType;
	var Mask_$_78 : MaskType;
	var Mask_$_79 : MaskType;
	var Mask_$_80 : MaskType;
	var Mask_$_81 : MaskType;
	var Mask_$_82 : MaskType;
	var Mask_$_83 : MaskType;
	var Mask_$_84 : MaskType;
	var Mask_$_85 : MaskType;
	var Mask_$_86 : MaskType;
	var cond#_360_$_0 : bool;
	var exhaleHeap#_366_$_0 : HeapType;
	var exhaleHeap#_389_$_0 : HeapType;
	var exhaleMask#_390_$_0 : MaskType;
	var exhaleMask#_390_$_1 : MaskType;
	var exhaleMask#_390_$_2 : MaskType;
	var exhaleMask#_390_$_3 : MaskType;
	var exhaleMask#_390_$_4 : MaskType;
	var exhaleMask#_390_$_5 : MaskType;
	var exhaleMask#_390_$_6 : MaskType;
	var exhaleMask#_390_$_7 : MaskType;
	var exhaleMask#_390_$_8 : MaskType;
	var exhaleMask#_390_$_9 : MaskType;
	var exhaleMask#_390_$_10 : MaskType;
	var exhaleMask#_390_$_11 : MaskType;
	var exhaleMask#_390_$_12 : MaskType;
	var exhaleMask#_390_$_13 : MaskType;
	var exhaleMask#_390_$_14 : MaskType;
	var exhaleMask#_390_$_15 : MaskType;
	var exhaleMask#_390_$_16 : MaskType;
	var exhaleMask#_390_$_17 : MaskType;
	var exhaleMask#_390_$_18 : MaskType;
	var exhaleMask#_390_$_19 : MaskType;
	var exhaleMask#_390_$_20 : MaskType;
	var exhaleMask#_390_$_21 : MaskType;
	var Mask_$_87 : MaskType;
	var Mask_$_88 : MaskType;
	var Mask_$_89 : MaskType;
	var Mask_$_90 : MaskType;
	var exhaleMask#_367_$_0 : MaskType;
	var exhaleMask#_367_$_1 : MaskType;
	var exhaleMask#_367_$_2 : MaskType;
	var exhaleMask#_367_$_3 : MaskType;
	var exhaleMask#_367_$_4 : MaskType;
	var exhaleMask#_367_$_5 : MaskType;
	var exhaleMask#_367_$_6 : MaskType;
	var exhaleMask#_367_$_7 : MaskType;
	var exhaleMask#_367_$_8 : MaskType;
	var exhaleMask#_367_$_9 : MaskType;
	var exhaleMask#_367_$_10 : MaskType;
	var exhaleMask#_367_$_11 : MaskType;
	var exhaleMask#_367_$_12 : MaskType;
	var exhaleMask#_367_$_13 : MaskType;
	var exhaleMask#_367_$_14 : MaskType;
	var exhaleMask#_367_$_15 : MaskType;
	var exhaleMask#_367_$_16 : MaskType;
	var exhaleMask#_367_$_17 : MaskType;
	var r#180_$_0 : ref;
	var Mask_$_91 : MaskType;
	var Mask_$_92 : MaskType;
	var Mask_$_93 : MaskType;
	var Mask_$_94 : MaskType;
	var exhaleMask#_297_$_0 : MaskType;
	var exhaleMask#_297_$_1 : MaskType;
	var exhaleMask#_297_$_2 : MaskType;
	var exhaleMask#_297_$_3 : MaskType;
	var exhaleMask#_297_$_4 : MaskType;
	var exhaleMask#_297_$_5 : MaskType;
	var exhaleMask#_297_$_6 : MaskType;
	var exhaleMask#_297_$_7 : MaskType;
	var exhaleMask#_297_$_8 : MaskType;
	var exhaleMask#_297_$_9 : MaskType;
	var exhaleMask#_297_$_10 : MaskType;
	var exhaleMask#_297_$_11 : MaskType;
	var exhaleMask#_297_$_12 : MaskType;
	var exhaleMask#_297_$_13 : MaskType;
	var exhaleMask#_297_$_14 : MaskType;
	var exhaleMask#_297_$_15 : MaskType;
	var exhaleMask#_297_$_16 : MaskType;
	var exhaleMask#_297_$_17 : MaskType;
	var exhaleMask#_297_$_18 : MaskType;
	var exhaleMask#_297_$_19 : MaskType;
	var exhaleMask#_297_$_20 : MaskType;
	var exhaleMask#_297_$_21 : MaskType;
	var Mask_$_95 : MaskType;
	var Mask_$_96 : MaskType;
	var Mask_$_97 : MaskType;
	var Mask_$_98 : MaskType;
	var Heap_$_6 : HeapType;
	var Mask_$_99 : MaskType;
	var r#10_$_0 : ref;
	var exhaleHeap#_499_$_0 : HeapType;
	var exhaleMask#_500_$_0 : MaskType;
	var exhaleMask#_500_$_1 : MaskType;
	var exhaleMask#_500_$_2 : MaskType;
	var exhaleMask#_500_$_3 : MaskType;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$1 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$3 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$5 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$7 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$9 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$11 : bool;
	var $_$_condition_$12 : bool;
	var $_$_condition_$13 : bool;
	var $_$_condition_$14 : bool;
	var $_$_condition_$15 : bool;
	var $_$_condition_$16 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$18 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$20 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$22 : bool;
	var $_$_condition_$23 : bool;
	var $_$_condition_$24 : bool;
	var $_$_condition_$25 : bool;
	var $_$_condition_$26 : bool;
	var $_$_condition_$27 : bool;
	var $_$_condition_$28 : bool;
	var $_$_condition_$29 : bool;
	var $_$_condition_$30 : bool;
	var $_$_condition_$31 : bool;
	var $_$_condition_$32 : bool;
	var $_$_condition_$33 : bool;
	var $_$_condition_$34 : bool;
	var $_$_condition_$35 : bool;
	var $_$_condition_$36 : bool;
	var $_$_condition_$37 : bool;
	var $_$_condition_$38 : bool;
	var $_$_condition_$39 : bool;
	var $_$_condition_$40 : bool;
	var $_$_condition_$41 : bool;
	var $_$_condition_$42 : bool;
	var $_$_condition_$43 : bool;
	var $_$_condition_$44 : bool;
	var $_$_condition_$45 : bool;
	var $_$_condition_$46 : bool;
	var $_$_condition_$47 : bool;
	var $_$_condition_$48 : bool;
	var $_$_condition_$49 : bool;
	var $_$_condition_$50 : bool;
	var $_$_condition_$51 : bool;
	var $_$_condition_$52 : bool;
	var $_$_condition_$53 : bool;
	var $_$_condition_$54 : bool;
	var $_$_condition_$55 : bool;
	var $_$_condition_$56 : bool;
	var $_$_condition_$57 : bool;
	var $_$_condition_$58 : bool;
	var $_$_condition_$59 : bool;
	var $_$_condition_$60 : bool;
	var $_$_condition_$61 : bool;
	var $_$_condition_$62 : bool;
	var $_$_condition_$63 : bool;
	var $_$_condition_$64 : bool;
	var $_$_condition_$65 : bool;
	var $_$_condition_$66 : bool;
	var $_$_condition_$67 : bool;
	var $_$_condition_$68 : bool;
	var $_$_condition_$69 : bool;
	var $_$_condition_$70 : bool;
	var $_$_condition_$71 : bool;
	var $_$_condition_$72 : bool;
	var $_$_condition_$73 : bool;
	var $_$_condition_$74 : bool;
	var $_$_condition_$75 : bool;
	var $_$_condition_$76 : bool;
	var $_$_condition_$77 : bool;
	var $_$_condition_$78 : bool;
	var $_$_condition_$79 : bool;
	var $_$_condition_$80 : bool;
	var $_$_condition_$81 : bool;
	var $_$_condition_$82 : bool;
	var $_$_condition_$83 : bool;
	var $_$_condition_$84 : bool;
	var $_$_condition_$85 : bool;
	var $_$_condition_$86 : bool;
	var $_$_condition_$87 : bool;
	var $_$_condition_$88 : bool;
	var $_$_condition_$89 : bool;
	var $_$_condition_$90 : bool;
	var $_$_condition_$91 : bool;
	var $_$_condition_$92 : bool;
	var $_$_condition_$93 : bool;
	var $_$_condition_$94 : bool;
	var $_$_condition_$95 : bool;
	var $_$_condition_$96 : bool;
	var $_$_condition_$97 : bool;
	var $_$_condition_$98 : bool;
	var $_$_condition_$99 : bool;
	var $_$_condition_$100 : bool;
	var $_$_condition_$101 : bool;
	var $_$_condition_$102 : bool;
	var $_$_condition_$103 : bool;
	var $_$_condition_$104 : bool;
	var $_$_condition_$105 : bool;
	var $_$_condition_$106 : bool;
	var $_$_condition_$107 : bool;
	var $_$_condition_$108 : bool;
	var $_$_condition_$109 : bool;
	var $_$_condition_$110 : bool;
	var $_$_condition_$111 : bool;
	var $_$_condition_$112 : bool;
	var $_$_condition_$113 : bool;
	var $_$_condition_$114 : bool;
	var $_$_condition_$115 : bool;
	var $_$_condition_$116 : bool;
	var $_$_condition_$117 : bool;
	var $_$_condition_$118 : bool;
	var $_$_condition_$119 : bool;
	var $_$_condition_$120 : bool;
	var $_$_condition_$121 : bool;
	var $_$_condition_$122 : bool;
	var $_$_condition_$123 : bool;
	var $_$_condition_$124 : bool;
	var $_$_condition_$125 : bool;
	var $_$_condition_$126 : bool;
	var $_$_condition_$127 : bool;
	var $_$_condition_$128 : bool;
	var $_$_condition_$129 : bool;
	var $_$_condition_$130 : bool;
	var $_$_condition_$131 : bool;
	var $_$_condition_$132 : bool;
	var $_$_condition_$133 : bool;
	var $_$_condition_$134 : bool;
	var $_$_condition_$135 : bool;
	var $_$_condition_$136 : bool;
	var $_$_condition_$137 : bool;
	var $_$_condition_$138 : bool;
	var $_$_condition_$139 : bool;
	var $_$_condition_$140 : bool;
	var $_$_condition_$141 : bool;
	var $_$_condition_$142 : bool;
	var $_$_condition_$143 : bool;
	var $_$_condition_$144 : bool;
	var $_$_condition_$145 : bool;
	var $_$_condition_$146 : bool;
	var $_$_condition_$147 : bool;
	var $_$_condition_$148 : bool;
	var $_$_condition_$149 : bool;
	var $_$_condition_$150 : bool;
	var $_$_condition_$151 : bool;
	var $_$_condition_$152 : bool;
	var $_$_condition_$153 : bool;
	var $_$_condition_$154 : bool;
	var $_$_condition_$155 : bool;
	var $_$_condition_$156 : bool;
	var $_$_condition_$157 : bool;
	var $_$_condition_$158 : bool;
$start:
	assume Permission$denominator > 0;
	assume (Permission$Zero[perm$R] == 0) && (Permission$Zero[perm$N] == 0);
	assume (Permission$Full[perm$R] == Permission$FullFraction) && (Permission$Full[perm$N] == 0);
	assume (forall<T> o : ref, f : Field (T) , pc : PermissionComponent :: ( ZeroMask[o,f][pc] == 0 ));
	assume IsGoodMask(ZeroMask);
	assume NonPredicateField(joinable);
	assume NonPredicateField(forkK);
	assume (forall  n : Integer :: {Fractions(n)} ( Fractions(n) == (n * Permission$denominator) ));
	assume (forall  x : Integer, y : Integer :: ( ((0 <= x) && (x <= y)) ==> (Fractions(x) <= Fractions(y)) ));
	assume Permission$FullFraction == Fractions(100);
	assume (0 < channelK) && ((1000 * channelK) < Fractions(1));
	assume (0 < monitorK) && ((1000 * monitorK) < Fractions(1));
	assume (0 < predicateK) && ((1000 * predicateK) < Fractions(1));
	assume (predicateK == channelK) && (channelK == monitorK);
	assume (forall  a : PartialHeapType, b : PartialHeapType :: {IsGoodState(combine(a,b))} ( IsGoodState(combine(a,b)) <==> (IsGoodState(a) && IsGoodState(b)) ));
	assume IsGoodState(emptyPartialHeap);
	assume NonPredicateField(mu);
	assume (forall  m : Mu, n_$0 : Mu :: {MuBelow(m,n_$0),MuBelow(n_$0,m)} ( !(MuBelow(m,n_$0) && MuBelow(n_$0,m)) ));
	assume (forall  m_$0 : Mu, n_$1 : Mu, o_$0 : Mu :: {MuBelow(m_$0,n_$1),MuBelow(n_$1,o_$0)} ( (MuBelow(m_$0,n_$1) && MuBelow(n_$1,o_$0)) ==> MuBelow(m_$0,o_$0) ));
	assume (forall  m_$1 : Mu, n_$2 : Mu :: ( MuBelow(m_$1,n_$2) ==> (!(n_$2 == $LockBottom)) ));
	assume NonPredicateField(held);
	assume NonPredicateField(rdheld);
	assume (forall  ih : HeapType, h : HeapType, m_$2 : MaskType, sm : MaskType :: {IsGoodInhaleState(ih,h,m_$2,sm)} ( IsGoodInhaleState(ih,h,m_$2,sm) <==> ((((((forall<T> o_$1 : ref, f_$0 : Field (T)  :: {ih[o_$1,f_$0]} ( CanRead(m_$2,sm,o_$1,f_$0) ==> (ih[o_$1,f_$0] == h[o_$1,f_$0]) ))) && ((forall  o_$2 : ref :: {ih[o_$2,held]} ( (0 < ih[o_$2,held]) <==> (0 < h[o_$2,held]) )))) && ((forall  o_$3 : ref :: {ih[o_$3,rdheld]} ( ih[o_$3,rdheld] <==> h[o_$3,rdheld] )))) && ((forall  o_$4 : ref :: {h[o_$4,held]} ( (0 < h[o_$4,held]) ==> (ih[o_$4,mu] == h[o_$4,mu]) )))) && ((forall  o_$5 : ref :: {h[o_$5,rdheld]} ( h[o_$5,rdheld] ==> (ih[o_$5,mu] == h[o_$5,mu]) )))) ));
	assume (forall  eh : HeapType, h_$0 : HeapType, m_$3 : MaskType, sm_$0 : MaskType :: {IsGoodExhaleState(eh,h_$0,m_$3,sm_$0)} ( IsGoodExhaleState(eh,h_$0,m_$3,sm_$0) <==> (((((((((forall<T> o_$6 : ref, f_$1 : Field (T)  :: {eh[o_$6,f_$1]} ( CanRead(m_$3,sm_$0,o_$6,f_$1) ==> (eh[o_$6,f_$1] == h_$0[o_$6,f_$1]) ))) && ((forall  o_$7 : ref :: {eh[o_$7,held]} ( (0 < eh[o_$7,held]) <==> (0 < h_$0[o_$7,held]) )))) && ((forall  o_$8 : ref :: {eh[o_$8,rdheld]} ( eh[o_$8,rdheld] <==> h_$0[o_$8,rdheld] )))) && ((forall  o_$9 : ref :: {h_$0[o_$9,held]} ( (0 < h_$0[o_$9,held]) ==> (eh[o_$9,mu] == h_$0[o_$9,mu]) )))) && ((forall  o_$10 : ref :: {h_$0[o_$10,rdheld]} ( h_$0[o_$10,rdheld] ==> (eh[o_$10,mu] == h_$0[o_$10,mu]) )))) && ((forall  o_$11 : ref :: {h_$0[o_$11,forkK]} {eh[o_$11,forkK]} ( h_$0[o_$11,forkK] == eh[o_$11,forkK] )))) && ((forall  o_$12 : ref :: {h_$0[o_$12,held]} {eh[o_$12,held]} ( h_$0[o_$12,held] == eh[o_$12,held] )))) && ((forall  o_$13 : ref, f_$2 : Field (Integer)  :: {eh[o_$13,f_$2],PredicateField(f_$2)} ( PredicateField(f_$2) ==> (h_$0[o_$13,f_$2] <= eh[o_$13,f_$2]) )))) ));
	assume (forall<T> m_$4 : MaskType, sm_$1 : MaskType, obj : ref, f_$3 : Field (T)  :: {CanRead(m_$4,sm_$1,obj,f_$3)} ( CanRead(m_$4,sm_$1,obj,f_$3) <==> ((((0 < m_$4[obj,f_$3][perm$R]) || (0 < m_$4[obj,f_$3][perm$N])) || (0 < sm_$1[obj,f_$3][perm$R])) || (0 < sm_$1[obj,f_$3][perm$N])) ));
	assume (forall<T> m_$5 : MaskType, obj_$0 : ref, f_$4 : Field (T)  :: {CanReadForSure(m_$5,obj_$0,f_$4)} ( CanReadForSure(m_$5,obj_$0,f_$4) <==> ((0 < m_$5[obj_$0,f_$4][perm$R]) || (0 < m_$5[obj_$0,f_$4][perm$N])) ));
	assume (forall<T> m_$6 : MaskType, obj_$1 : ref, f_$5 : Field (T)  :: {CanWrite(m_$6,obj_$1,f_$5)} ( CanWrite(m_$6,obj_$1,f_$5) <==> ((m_$6[obj_$1,f_$5][perm$R] == Permission$FullFraction) && (m_$6[obj_$1,f_$5][perm$N] == 0)) ));
	assume (forall  m_$7 : MaskType :: {IsGoodMask(m_$7)} ( IsGoodMask(m_$7) <==> ((forall<T> o_$14 : ref, f_$6 : Field (T)  :: ( ((0 <= m_$7[o_$14,f_$6][perm$R]) && (NonPredicateField(f_$6) ==> ((m_$7[o_$14,f_$6][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14,f_$6][perm$N]) ==> (m_$7[o_$14,f_$6][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14,f_$6][perm$N] < 0) ==> (0 < m_$7[o_$14,f_$6][perm$R])) ))) ));
	assume (forall  h_$1 : HeapType, m_$8 : MaskType, sm_$2 : MaskType, o_$15 : ref, q : ref :: {wf(h_$1,m_$8,sm_$2),h_$1[o_$15,mu],h_$1[q,mu]} ( (((wf(h_$1,m_$8,sm_$2) && (!(o_$15 == q))) && ((0 < h_$1[o_$15,held]) || h_$1[o_$15,rdheld])) && ((0 < h_$1[q,held]) || h_$1[q,rdheld])) ==> (!(h_$1[o_$15,mu] == h_$1[q,mu])) ));
	assume (forall<T,U> m_$9 : MaskType, o_$16 : ref, f_$7 : Field (T) , howMuch : Integer, q_$0 : ref, g : Field (U)  :: {DecPerm(m_$9,o_$16,f_$7,howMuch)[q_$0,g][perm$R]} ( DecPerm(m_$9,o_$16,f_$7,howMuch)[q_$0,g][perm$R] == ite((o_$16 == q_$0) && (f_$7 == g),m_$9[q_$0,g][perm$R] - howMuch,m_$9[q_$0,g][perm$R]) ));
	assume (forall<T,U> m_$10 : MaskType, o_$17 : ref, f_$8 : Field (T) , howMuch_$0 : Integer, q_$1 : ref, g_$0 : Field (U)  :: {DecPerm(m_$10,o_$17,f_$8,howMuch_$0)[q_$1,g_$0][perm$N]} ( DecEpsilons(m_$10,o_$17,f_$8,howMuch_$0)[q_$1,g_$0][perm$N] == ite((o_$17 == q_$1) && (f_$8 == g_$0),m_$10[q_$1,g_$0][perm$N] - howMuch_$0,m_$10[q_$1,g_$0][perm$N]) ));
	assume (forall<T,U> m_$11 : MaskType, o_$18 : ref, f_$9 : Field (T) , howMuch_$1 : Integer, q_$2 : ref, g_$1 : Field (U)  :: {IncPerm(m_$11,o_$18,f_$9,howMuch_$1)[q_$2,g_$1][perm$R]} ( IncPerm(m_$11,o_$18,f_$9,howMuch_$1)[q_$2,g_$1][perm$R] == ite((o_$18 == q_$2) && (f_$9 == g_$1),m_$11[q_$2,g_$1][perm$R] + howMuch_$1,m_$11[q_$2,g_$1][perm$R]) ));
	assume (forall<T,U> m_$12 : MaskType, o_$19 : ref, f_$10 : Field (T) , howMuch_$2 : Integer, q_$3 : ref, g_$2 : Field (U)  :: {IncPerm(m_$12,o_$19,f_$10,howMuch_$2)[q_$3,g_$2][perm$N]} ( IncEpsilons(m_$12,o_$19,f_$10,howMuch_$2)[q_$3,g_$2][perm$N] == ite((o_$19 == q_$3) && (f_$10 == g_$2),m_$12[q_$3,g_$2][perm$N] + howMuch_$2,m_$12[q_$3,g_$2][perm$N]) ));
	assume (forall<T,U> h_$2 : HeapType, o_$20 : ref, f_$11 : Field (T) , newValue : U, q_$4 : ref, g_$3 : Field (U)  :: {Havocing(h_$2,o_$20,f_$11,newValue)[q_$4,g_$3]} ( Havocing(h_$2,o_$20,f_$11,newValue)[q_$4,g_$3] == ite((o_$20 == q_$4) && (f_$11 == g_$3),newValue,h_$2[q_$4,g_$3]) ));
	assume (forall  m_$13 : MaskType :: {EmptyMask(m_$13)} ( EmptyMask(m_$13) <==> ((forall<T> o_$21 : ref, f_$12 : Field (T)  :: ( NonPredicateField(f_$12) ==> ((m_$13[o_$21,f_$12][perm$R] <= 0) && (m_$13[o_$21,f_$12][perm$N] <= 0)) ))) ));
	assume (forall  o_$22 : ref :: ( ZeroCredits[o_$22] == 0 ));
	assume (forall  c : CreditsType :: {EmptyCredits(c)} ( EmptyCredits(c) <==> ((forall  o_$23 : ref :: ( (!(o_$23 == null)) ==> (c[o_$23] == 0) ))) ));
	assume (forall<T> f_$13 : Field (T)  :: ( NonPredicateField(f_$13) ==> (!PredicateField(f_$13)) ));
	assume (forall<T> f_$14 : Field (T)  :: ( PredicateField(f_$14) ==> (!NonPredicateField(f_$14)) ));
	assume (forall  m1 : MaskType, m2 : MaskType :: {submask(m1,m2)} ( submask(m1,m2) <==> ((forall<T> o_$24 : ref, f_$15 : Field (T)  :: ( (m1[o_$24,f_$15][perm$R] < m2[o_$24,f_$15][perm$R]) || ((m1[o_$24,f_$15][perm$R] == m2[o_$24,f_$15][perm$R]) && (m1[o_$24,f_$15][perm$N] <= m2[o_$24,f_$15][perm$N])) ))) ));
	assume (forall<T> con : Boolean, a_$0 : T, b_$0 : T :: {ite(con,a_$0,b_$0)} ( con ==> (ite(con,a_$0,b_$0) == a_$0) ));
	assume (forall<T> con_$0 : Boolean, a_$1 : T, b_$1 : T :: {ite(con_$0,a_$1,b_$1)} ( (!con_$0) ==> (ite(con_$0,a_$1,b_$1) == b_$1) ));
	assume (forall<T> s : Seq (T)  :: {Seq#Length(s)} ( 0 <= Seq#Length(s) ));
	assume (forall<T> :: Seq#Length((Seq#Empty() : Seq (T) )) == 0);
	assume (forall<T> s_$0 : Seq (T)  :: {Seq#Length(s_$0)} ( (Seq#Length(s_$0) == 0) ==> (s_$0 == (Seq#Empty() : Seq (T) )) ));
	assume (forall<T> t : T :: {Seq#Length(Seq#Singleton(t))} ( Seq#Length(Seq#Singleton(t)) == 1 ));
	assume (forall<T> s_$1 : Seq (T) , i : Integer, v : T, len : Integer :: {Seq#Length(Seq#Build(s_$1,i,v,len))} ( (0 <= len) ==> (Seq#Length(Seq#Build(s_$1,i,v,len)) == len) ));
	assume (forall<T> s0 : Seq (T) , s1 : Seq (T)  :: {Seq#Length(Seq#Append(s0,s1))} ( Seq#Length(Seq#Append(s0,s1)) == (Seq#Length(s0) + Seq#Length(s1)) ));
	assume (forall<T> t_$0 : T :: {Seq#Index(Seq#Singleton(t_$0),0)} ( Seq#Index(Seq#Singleton(t_$0),0) == t_$0 ));
	assume (forall<T> s0_$0 : Seq (T) , s1_$0 : Seq (T) , n_$3 : Integer :: {Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3)} ( ((n_$3 < Seq#Length(s0_$0)) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3) == Seq#Index(s0_$0,n_$3))) && ((Seq#Length(s0_$0) <= n_$3) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3) == Seq#Index(s1_$0,n_$3 - Seq#Length(s0_$0)))) ));
	assume (forall<T> s_$2 : Seq (T) , i_$0 : Integer, v_$0 : T, len_$0 : Integer, n_$4 : Integer :: {Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4)} ( ((0 <= n_$4) && (n_$4 < len_$0)) ==> (((i_$0 == n_$4) ==> (Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4) == v_$0)) && ((!(i_$0 == n_$4)) ==> (Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4) == Seq#Index(s_$2,n_$4)))) ));
	assume (forall<T> s_$3 : Seq (T) , x_$0 : T :: {Seq#Contains(s_$3,x_$0)} ( Seq#Contains(s_$3,x_$0) <==> ((exists  i_$1 : Integer :: {Seq#Index(s_$3,i_$1)} ( ((0 <= i_$1) && (i_$1 < Seq#Length(s_$3))) && (Seq#Index(s_$3,i_$1) == x_$0) ))) ));
	assume (forall  x_$1 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1) ));
	assume (forall<T> s0_$1 : Seq (T) , s1_$1 : Seq (T) , x_$2 : T :: {Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$2)} ( Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$2) <==> (Seq#Contains(s0_$1,x_$2) || Seq#Contains(s1_$1,x_$2)) ));
	assume (forall<T> s_$4 : Seq (T) , i_$2 : Integer, v_$1 : T, len_$1 : Integer, x_$3 : T :: {Seq#Contains(Seq#Build(s_$4,i_$2,v_$1,len_$1),x_$3)} ( Seq#Contains(Seq#Build(s_$4,i_$2,v_$1,len_$1),x_$3) <==> ((((0 <= i_$2) && (i_$2 < len_$1)) && (x_$3 == v_$1)) || ((exists  j : Integer :: {Seq#Index(s_$4,j)} ( ((((0 <= j) && (j < Seq#Length(s_$4))) && (j < len_$1)) && (!(j == i_$2))) && (Seq#Index(s_$4,j) == x_$3) )))) ));
	assume (forall<T> s_$5 : Seq (T) , n_$5 : Integer, x_$4 : T :: {Seq#Contains(Seq#Take(s_$5,n_$5),x_$4)} ( Seq#Contains(Seq#Take(s_$5,n_$5),x_$4) <==> ((exists  i_$3 : Integer :: {Seq#Index(s_$5,i_$3)} ( (((0 <= i_$3) && (i_$3 < n_$5)) && (i_$3 < Seq#Length(s_$5))) && (Seq#Index(s_$5,i_$3) == x_$4) ))) ));
	assume (forall<T> s_$6 : Seq (T) , n_$6 : Integer, x_$5 : T :: {Seq#Contains(Seq#Drop(s_$6,n_$6),x_$5)} ( Seq#Contains(Seq#Drop(s_$6,n_$6),x_$5) <==> ((exists  i_$4 : Integer :: {Seq#Index(s_$6,i_$4)} ( (((0 <= n_$6) && (n_$6 <= i_$4)) && (i_$4 < Seq#Length(s_$6))) && (Seq#Index(s_$6,i_$4) == x_$5) ))) ));
	assume (forall<T> s0_$2 : Seq (T) , s1_$2 : Seq (T)  :: {Seq#Equal(s0_$2,s1_$2)} ( Seq#Equal(s0_$2,s1_$2) <==> ((Seq#Length(s0_$2) == Seq#Length(s1_$2)) && ((forall  j_$0 : Integer :: {Seq#Index(s0_$2,j_$0)} {Seq#Index(s1_$2,j_$0)} ( ((0 <= j_$0) && (j_$0 < Seq#Length(s0_$2))) ==> (Seq#Index(s0_$2,j_$0) == Seq#Index(s1_$2,j_$0)) )))) ));
	assume (forall<T> a_$2 : Seq (T) , b_$2 : Seq (T)  :: {Seq#Equal(a_$2,b_$2)} ( Seq#Equal(a_$2,b_$2) ==> (a_$2 == b_$2) ));
	assume (forall<T> s0_$3 : Seq (T) , s1_$3 : Seq (T) , n_$7 : Integer :: {Seq#SameUntil(s0_$3,s1_$3,n_$7)} ( Seq#SameUntil(s0_$3,s1_$3,n_$7) <==> ((forall  j_$1 : Integer :: {Seq#Index(s0_$3,j_$1)} {Seq#Index(s1_$3,j_$1)} ( ((0 <= j_$1) && (j_$1 < n_$7)) ==> (Seq#Index(s0_$3,j_$1) == Seq#Index(s1_$3,j_$1)) ))) ));
	assume (forall<T> s_$7 : Seq (T) , n_$8 : Integer :: {Seq#Length(Seq#Take(s_$7,n_$8))} ( (0 <= n_$8) ==> (((n_$8 <= Seq#Length(s_$7)) ==> (Seq#Length(Seq#Take(s_$7,n_$8)) == n_$8)) && ((Seq#Length(s_$7) < n_$8) ==> (Seq#Length(Seq#Take(s_$7,n_$8)) == Seq#Length(s_$7)))) ));
	assume (forall<T> s_$8 : Seq (T) , n_$9 : Integer, j_$2 : Integer :: {Seq#Index(Seq#Take(s_$8,n_$9),j_$2)} {:weight  25}( (((0 <= j_$2) && (j_$2 < n_$9)) && (j_$2 < Seq#Length(s_$8))) ==> (Seq#Index(Seq#Take(s_$8,n_$9),j_$2) == Seq#Index(s_$8,j_$2)) ));
	assume (forall<T> s_$9 : Seq (T) , n_$10 : Integer :: {Seq#Length(Seq#Drop(s_$9,n_$10))} ( (0 <= n_$10) ==> (((n_$10 <= Seq#Length(s_$9)) ==> (Seq#Length(Seq#Drop(s_$9,n_$10)) == (Seq#Length(s_$9) - n_$10))) && ((Seq#Length(s_$9) < n_$10) ==> (Seq#Length(Seq#Drop(s_$9,n_$10)) == 0))) ));
	assume (forall<T> s_$10 : Seq (T) , n_$11 : Integer, j_$3 : Integer :: {Seq#Index(Seq#Drop(s_$10,n_$11),j_$3)} {:weight  25}( (((0 <= n_$11) && (0 <= j_$3)) && (j_$3 < (Seq#Length(s_$10) - n_$11))) ==> (Seq#Index(Seq#Drop(s_$10,n_$11),j_$3) == Seq#Index(s_$10,j_$3 + n_$11)) ));
	assume (forall<T> s_$11 : Seq (T) , t_$1 : Seq (T)  :: {Seq#Append(s_$11,t_$1)} ( (Seq#Take(Seq#Append(s_$11,t_$1),Seq#Length(s_$11)) == s_$11) && (Seq#Drop(Seq#Append(s_$11,t_$1),Seq#Length(s_$11)) == t_$1) ));
	assume (forall  min : Integer, max : Integer :: {Seq#Length(Seq#Range(min,max))} ( ((min < max) ==> (Seq#Length(Seq#Range(min,max)) == (max - min))) && ((max <= min) ==> (Seq#Length(Seq#Range(min,max)) == 0)) ));
	assume (forall  min_$0 : Integer, max_$0 : Integer, j_$4 : Integer :: {Seq#Index(Seq#Range(min_$0,max_$0),j_$4)} ( ((0 <= j_$4) && (j_$4 < (max_$0 - min_$0))) ==> (Seq#Index(Seq#Range(min_$0,max_$0),j_$4) == (min_$0 + j_$4)) ));
	assume (forall<T> x_$6 : T, y_$0 : T :: {Seq#Contains(Seq#Singleton(x_$6),y_$0)} ( Seq#Contains(Seq#Singleton(x_$6),y_$0) <==> (x_$6 == y_$0) ));
	assume NonPredicateField(AVLTree.root);
	assume NonPredicateField(AVLTree.keys);
	assume PredicateField(AVLTree.valid);
	assume NonPredicateField(AVLTreeNode.key);
	assume NonPredicateField(AVLTreeNode.height);
	assume NonPredicateField(AVLTreeNode.left);
	assume NonPredicateField(AVLTreeNode.right);
	assume NonPredicateField(AVLTreeNode.keys);
	assume NonPredicateField(AVLTreeNode.balanceFactor);
	assume PredicateField(AVLTreeNode.valid);
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume IsGoodMask(Mask);
	assume IsGoodMask(SecMask);
	assume (this == null) || (dtype(this) == AVLTreeNode#t);
	assume true;
	assume (r#10 == null) || (dtype(r#10) == AVLTreeNode#t);
	assume (this#165 == null) || (dtype(this#165) == AVLTreeNode#t);
	assume (nl#12 == null) || (dtype(nl#12) == AVLTreeNode#t);
	assume (this#170 == null) || (dtype(this#170) == AVLTreeNode#t);
	assume true;
	assume (this#172 == null) || (dtype(this#172) == AVLTreeNode#t);
	assume true;
	assume (r#174 == null) || (dtype(r#174) == AVLTreeNode#t);
	assume true;
	assume (this#177 == null) || (dtype(this#177) == AVLTreeNode#t);
	assume true;
	assume (this#179 == null) || (dtype(this#179) == AVLTreeNode#t);
	assume (r#180 == null) || (dtype(r#180) == AVLTreeNode#t);
	assume (this#185 == null) || (dtype(this#185) == AVLTreeNode#t);
	assume (nr#16 == null) || (dtype(nr#16) == AVLTreeNode#t);
	assume (this#190 == null) || (dtype(this#190) == AVLTreeNode#t);
	assume true;
	assume (this#192 == null) || (dtype(this#192) == AVLTreeNode#t);
	assume true;
	assume (r#194 == null) || (dtype(r#194) == AVLTreeNode#t);
	assume true;
	assume (this#197 == null) || (dtype(this#197) == AVLTreeNode#t);
	assume true;
	assume (this#199 == null) || (dtype(this#199) == AVLTreeNode#t);
	assume (r#200 == null) || (dtype(r#200) == AVLTreeNode#t);
	assume (this#205 == null) || (dtype(this#205) == AVLTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_261) && ((1000 * methodK#_261) < Fractions(1));
	assume CurrentModule == module#default;
	assume CanAssumeFunctionDefs;
	assume !(this == null);
	assume wf(Heap,ZeroMask,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,AVLTreeNode.valid := ZeroMask[this,AVLTreeNode.valid][perm$R := ZeroMask[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_1 == Mask_$_0[this,AVLTreeNode.keys := Mask_$_0[this,AVLTreeNode.keys][perm$R := Mask_$_0[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_2 == Mask_$_1[this,AVLTreeNode.height := Mask_$_1[this,AVLTreeNode.height][perm$R := Mask_$_1[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_2);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.height]));
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_3 == Mask_$_2[this,AVLTreeNode.balanceFactor := Mask_$_2[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_2[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_3);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume IsGoodMask(Mask_$_3);
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume Heap == Heap;
	assume Mask_$_3 == Mask;
	assume ZeroMask == SecMask;
	assume ZeroCredits == Credits;
	assume #AVLTreeNode.valid#trigger(this);
	assume ((0 < unfoldK#_262) && (unfoldK#_262 < Fractions(1))) && ((1000 * unfoldK#_262) < methodK#_261);
	assert { :msg "  205.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  205.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  205.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_3[this,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_3[this,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_3[this,AVLTreeNode.valid][perm$N]));
	assume Mask_$_4 == Mask_$_3[this,AVLTreeNode.valid := Mask_$_3[this,AVLTreeNode.valid][perm$R := Mask_$_3[this,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition) { goto anon268_Then; } else { goto anon268_Else; }
anon268_Then:
	assume false;
	goto $exit;
anon268_Else:
	assume !false;
	if ($_$_condition_$0) { goto anon295_Then; } else { goto anon295_Else; }
anon295_Then:
	assume !CanRead(Mask_$_4,ZeroMask,this,AVLTreeNode.valid);
	assume oldVers#_282_$_0 == Heap[this,AVLTreeNode.valid];
	assume Heap_$_0 == Heap[this,AVLTreeNode.valid := newVers#_283_$_0];
	assume oldVers#_282_$_0 < Heap_$_0[this,AVLTreeNode.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon56;
anon295_Else:
	assume CanRead(Mask_$_4,ZeroMask,this,AVLTreeNode.valid);
	assume Heap_$_1 == Heap;
	goto anon56;
anon56:
	assume IsGoodMask(Mask_$_4);
	assume wf(Heap_$_1,Mask_$_4,ZeroMask);
	assume IsGoodMask(Mask_$_4);
	assume wf(Heap_$_1,Mask_$_4,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_4,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_5 == Mask_$_4[this,AVLTreeNode.key := Mask_$_4[this,AVLTreeNode.key][perm$R := Mask_$_4[this,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_5);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTreeNode.key]));
	assume wf(Heap_$_1,Mask_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_5,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_5,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_6 == Mask_$_5[this,AVLTreeNode.height := Mask_$_5[this,AVLTreeNode.height][perm$R := Mask_$_5[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_6);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_6,ZeroMask);
	assume wf(Heap_$_1,Mask_$_6,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_6,ZeroMask);
	assume (Heap_$_1[this,AVLTreeNode.left] == null) || (dtype(Heap_$_1[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_7 == Mask_$_6[this,AVLTreeNode.left := Mask_$_6[this,AVLTreeNode.left][perm$R := Mask_$_6[this,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_7);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTreeNode.left]));
	assume wf(Heap_$_1,Mask_$_7,ZeroMask);
	assume wf(Heap_$_1,Mask_$_7,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_7,ZeroMask);
	assume (Heap_$_1[this,AVLTreeNode.right] == null) || (dtype(Heap_$_1[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_8 == Mask_$_7[this,AVLTreeNode.right := Mask_$_7[this,AVLTreeNode.right][perm$R := Mask_$_7[this,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_8);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTreeNode.right]));
	assume wf(Heap_$_1,Mask_$_8,ZeroMask);
	assume wf(Heap_$_1,Mask_$_8,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_8,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_9 == Mask_$_8[this,AVLTreeNode.keys := Mask_$_8[this,AVLTreeNode.keys][perm$R := Mask_$_8[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_9);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_9,ZeroMask);
	assume wf(Heap_$_1,Mask_$_9,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_9,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_10 == Mask_$_9[this,AVLTreeNode.balanceFactor := Mask_$_9[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_9[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_10);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_10,ZeroMask);
	assume wf(Heap_$_1,Mask_$_10,ZeroMask);
	if ($_$_condition_$1) { goto anon296_Then; } else { goto anon296_Else; }
anon296_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_10,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_11 == Mask_$_10[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_10[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_10[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_11);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_11,ZeroMask);
	assume wf(Heap_$_1,Mask_$_11,ZeroMask);
	assume Mask_$_12 == Mask_$_11;
	if ($_$_condition_$2) { goto anon297_Then; } else { goto anon297_Else; }
anon296_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_12 == Mask_$_10;
	if ($_$_condition_$3) { goto anon297_Then; } else { goto anon297_Else; }
anon297_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_13 == Mask_$_12[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_12[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_12[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_13);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_13,ZeroMask);
	assume wf(Heap_$_1,Mask_$_13,ZeroMask);
	assume Mask_$_14 == Mask_$_13;
	if ($_$_condition_$4) { goto anon298_Then; } else { goto anon298_Else; }
anon297_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_14 == Mask_$_12;
	if ($_$_condition_$5) { goto anon298_Then; } else { goto anon298_Else; }
anon298_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_14,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_15 == Mask_$_14[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := Mask_$_14[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_14[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_15);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_15,ZeroMask);
	assume wf(Heap_$_1,Mask_$_15,ZeroMask);
	assume Mask_$_16 == Mask_$_15;
	if ($_$_condition_$6) { goto anon299_Then; } else { goto anon299_Else; }
anon298_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_16 == Mask_$_14;
	if ($_$_condition_$7) { goto anon299_Then; } else { goto anon299_Else; }
anon299_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_16,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_17 == Mask_$_16[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_16[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_16[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_17,ZeroMask);
	assume wf(Heap_$_1,Mask_$_17,ZeroMask);
	assume Mask_$_18 == Mask_$_17;
	if ($_$_condition_$8) { goto anon300_Then; } else { goto anon300_Else; }
anon299_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_18 == Mask_$_16;
	if ($_$_condition_$9) { goto anon300_Then; } else { goto anon300_Else; }
anon300_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume (forall  lk#79#163 : Integer :: ( ((0 <= lk#79#163) && (lk#79#163 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],lk#79#163) < Heap_$_1[this,AVLTreeNode.key]) ));
	if ($_$_condition_$10) { goto anon301_Then; } else { goto anon301_Else; }
anon300_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$11) { goto anon301_Then; } else { goto anon301_Else; }
anon301_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$12) { goto anon302_Then; } else { goto anon302_Else; }
anon301_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$13) { goto anon302_Then; } else { goto anon302_Else; }
anon302_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_18,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_19 == Mask_$_18[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_18[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_18[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assume Mask_$_20 == Mask_$_19;
	if ($_$_condition_$14) { goto anon303_Then; } else { goto anon303_Else; }
anon302_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_20 == Mask_$_18;
	if ($_$_condition_$15) { goto anon303_Then; } else { goto anon303_Else; }
anon303_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_20,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_21 == Mask_$_20[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_20[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_20[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_21,ZeroMask);
	assume wf(Heap_$_1,Mask_$_21,ZeroMask);
	assume Mask_$_22 == Mask_$_21;
	if ($_$_condition_$16) { goto anon304_Then; } else { goto anon304_Else; }
anon303_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_22 == Mask_$_20;
	if ($_$_condition_$17) { goto anon304_Then; } else { goto anon304_Else; }
anon304_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_22,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_23 == Mask_$_22[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := Mask_$_22[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_22[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_23);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_23,ZeroMask);
	assume wf(Heap_$_1,Mask_$_23,ZeroMask);
	assume Mask_$_24 == Mask_$_23;
	if ($_$_condition_$18) { goto anon305_Then; } else { goto anon305_Else; }
anon304_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_24 == Mask_$_22;
	if ($_$_condition_$19) { goto anon305_Then; } else { goto anon305_Else; }
anon305_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_24,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_25 == Mask_$_24[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_24[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_24[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_25);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_25,ZeroMask);
	assume wf(Heap_$_1,Mask_$_25,ZeroMask);
	assume Mask_$_26 == Mask_$_25;
	if ($_$_condition_$20) { goto anon306_Then; } else { goto anon306_Else; }
anon305_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_26 == Mask_$_24;
	if ($_$_condition_$21) { goto anon306_Then; } else { goto anon306_Else; }
anon306_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume (forall  rk#80#164 : Integer :: ( ((0 <= rk#80#164) && (rk#80#164 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[this,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],rk#80#164)) ));
	if ($_$_condition_$22) { goto anon307_Then; } else { goto anon307_Else; }
anon306_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	if ($_$_condition_$23) { goto anon307_Then; } else { goto anon307_Else; }
anon307_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon80;
anon307_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	goto anon80;
anon80:
	assume Seq#Equal(Heap_$_1[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[this,AVLTreeNode.key])),ite(Heap_$_1[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_1[this,AVLTreeNode.keys],Heap_$_1[this,AVLTreeNode.key]);
	assume (forall  kk#81 : Integer :: ( Seq#Contains(Heap_$_1[this,AVLTreeNode.keys],kk#81) <==> ((((!(Heap_$_1[this,AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81)) || ((!(Heap_$_1[this,AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81))) || (kk#81 == Heap_$_1[this,AVLTreeNode.key])) ));
	assume Heap_$_1[this,AVLTreeNode.height] == ite(ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_1[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_1[this,AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_1[this,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_1[this,AVLTreeNode.height] > 0;
	assume IsGoodMask(Mask_$_26);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume cond#_284_$_0 <==> (Heap_$_1[this,AVLTreeNode.key] == k#9);
	assert { :msg "  206.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  206.7: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.key);
	if ($_$_condition_$24) { goto anon308_Then; } else { goto anon308_Else; }
anon308_Then:
	assume cond#_284_$_0;
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  208.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  208.15: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.key);
	assert { :msg "  208.14: Sequence index might be negative." } true ==> (0 <= 0);
	assert { :msg "  208.14: Sequence index might be larger than or equal to the length of the sequence." } true ==> (0 < Seq#Length(Seq#Singleton(Heap_$_1[this,AVLTreeNode.key])));
	assert { :msg "  208.4: Assertion might not hold. The expression at 208.11 might not evaluate to true." } k#9 == Seq#Index(Seq#Singleton(Heap_$_1[this,AVLTreeNode.key]),0);
	assume IsGoodExhaleState(exhaleHeap#_289_$_0,Heap_$_1,Mask_$_26,ZeroMask);
	assume IsGoodMask(Mask_$_26);
	assume wf(exhaleHeap#_289_$_0,Mask_$_26,ZeroMask);
	assume ((0 < methodCallK#_295) && ((1000 * methodCallK#_295) < Fractions(1))) && ((1000 * methodCallK#_295) < methodK#_261);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  209.4: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$25) { goto anon309_Then; } else { goto anon309_Else; }
anon308_Else:
	assume !cond#_284_$_0;
	assume cond#_314_$_0 <==> (k#9 < Heap_$_1[this,AVLTreeNode.key]);
	assert { :msg "  211.10: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  211.10: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.key);
	if ($_$_condition_$26) { goto anon321_Then; } else { goto anon321_Else; }
anon309_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  209.4: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#166 : Integer :: ( ((0 <= k#92#166) && (k#92#166 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#166) < Heap_$_1[this,AVLTreeNode.key]) ));
	if ($_$_condition_$27) { goto anon310_Then; } else { goto anon310_Else; }
anon309_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$28) { goto anon310_Then; } else { goto anon310_Else; }
anon321_Then:
	assume cond#_314_$_0;
	assume cond#_315_$_0 <==> (Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  213.9: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  213.9: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$29) { goto anon322_Then; } else { goto anon322_Else; }
anon321_Else:
	assume !cond#_314_$_0;
	assume cond#_407_$_0 <==> (Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  231.9: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  231.9: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$30) { goto anon359_Then; } else { goto anon359_Else; }
anon310_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  209.4: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#167 : Integer :: ( ((0 <= k#93#167) && (k#93#167 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[this,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#167)) ));
	goto anon85;
anon310_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	goto anon85;
anon322_Then:
	assume cond#_315_$_0;
	assume (!(nw#_316_$_0 == null)) && (dtype(nw#_316_$_0) == AVLTreeNode#t);
	assume (forall<T#_1> f_$16 : Field (T#_1)  :: ( (Mask_$_26[nw#_316_$_0,f_$16][perm$R] == 0) && (Mask_$_26[nw#_316_$_0,f_$16][perm$N] == 0) ));
	assume Heap_$_1[nw#_316_$_0,mu] == $LockBottom;
	assume Heap_$_1[nw#_316_$_0,held] <= 0;
	assume Heap_$_1[nw#_316_$_0,rdheld] <==> false;
	assume Mask_$_61 == Mask_$_26[nw#_316_$_0,AVLTreeNode.key := Mask_$_26[nw#_316_$_0,AVLTreeNode.key][perm$R := Mask_$_26[nw#_316_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume Mask_$_62 == Mask_$_61[nw#_316_$_0,AVLTreeNode.height := Mask_$_61[nw#_316_$_0,AVLTreeNode.height][perm$R := Mask_$_61[nw#_316_$_0,AVLTreeNode.height][perm$R] + Fractions(100)]];
	assume Mask_$_63 == Mask_$_62[nw#_316_$_0,AVLTreeNode.left := Mask_$_62[nw#_316_$_0,AVLTreeNode.left][perm$R := Mask_$_62[nw#_316_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume Mask_$_64 == Mask_$_63[nw#_316_$_0,AVLTreeNode.right := Mask_$_63[nw#_316_$_0,AVLTreeNode.right][perm$R := Mask_$_63[nw#_316_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume Mask_$_65 == Mask_$_64[nw#_316_$_0,AVLTreeNode.keys := Mask_$_64[nw#_316_$_0,AVLTreeNode.keys][perm$R := Mask_$_64[nw#_316_$_0,AVLTreeNode.keys][perm$R] + Fractions(100)]];
	assume Mask_$_66 == Mask_$_65[nw#_316_$_0,AVLTreeNode.balanceFactor := Mask_$_65[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_65[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(100)]];
	assume Mask_$_67 == Mask_$_66[nw#_316_$_0,mu := Mask_$_66[nw#_316_$_0,mu][perm$R := Mask_$_66[nw#_316_$_0,mu][perm$R] + Fractions(100)]];
	assume ((0 < methodCallK#_321) && ((1000 * methodCallK#_321) < Fractions(1))) && ((1000 * methodCallK#_321) < methodK#_261);
	assume wf(Heap_$_1,Mask_$_67,ZeroMask);
	assert { :msg "  215.6: The target of the method call might be null." } !(nw#_316_$_0 == null);
	assert { :msg "  215.6: The precondition at 155.12 might not hold. The permission at 155.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  215.6: The precondition at 155.12 might not hold. Insufficient fraction at 155.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_67[nw#_316_$_0,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_67[nw#_316_$_0,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_67[nw#_316_$_0,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_323_$_0 == Mask_$_67[nw#_316_$_0,AVLTreeNode.key := Mask_$_67[nw#_316_$_0,AVLTreeNode.key][perm$R := Mask_$_67[nw#_316_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_323_$_0);
	assume wf(Heap_$_1,exhaleMask#_323_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_67,ZeroMask);
	assert { :msg "  215.6: The precondition at 156.12 might not hold. The permission at 156.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  215.6: The precondition at 156.12 might not hold. Insufficient fraction at 156.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_323_$_0[nw#_316_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_323_$_0[nw#_316_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_323_$_0[nw#_316_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_323_$_1 == exhaleMask#_323_$_0[nw#_316_$_0,AVLTreeNode.height := exhaleMask#_323_$_0[nw#_316_$_0,AVLTreeNode.height][perm$R := exhaleMask#_323_$_0[nw#_316_$_0,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_323_$_1);
	assume wf(Heap_$_1,exhaleMask#_323_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_67,ZeroMask);
	assert { :msg "  215.6: The precondition at 157.12 might not hold. The permission at 157.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  215.6: The precondition at 157.12 might not hold. Insufficient fraction at 157.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_323_$_1[nw#_316_$_0,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_323_$_1[nw#_316_$_0,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_323_$_1[nw#_316_$_0,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_323_$_2 == exhaleMask#_323_$_1[nw#_316_$_0,AVLTreeNode.left := exhaleMask#_323_$_1[nw#_316_$_0,AVLTreeNode.left][perm$R := exhaleMask#_323_$_1[nw#_316_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_323_$_2);
	assume wf(Heap_$_1,exhaleMask#_323_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_67,ZeroMask);
	assert { :msg "  215.6: The precondition at 158.12 might not hold. The permission at 158.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  215.6: The precondition at 158.12 might not hold. Insufficient fraction at 158.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_323_$_2[nw#_316_$_0,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_323_$_2[nw#_316_$_0,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_323_$_2[nw#_316_$_0,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_323_$_3 == exhaleMask#_323_$_2[nw#_316_$_0,AVLTreeNode.right := exhaleMask#_323_$_2[nw#_316_$_0,AVLTreeNode.right][perm$R := exhaleMask#_323_$_2[nw#_316_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_323_$_3);
	assume wf(Heap_$_1,exhaleMask#_323_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_67,ZeroMask);
	assert { :msg "  215.6: The precondition at 160.12 might not hold. The permission at 160.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  215.6: The precondition at 160.12 might not hold. Insufficient fraction at 160.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_323_$_3[nw#_316_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_323_$_3[nw#_316_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_323_$_3[nw#_316_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_323_$_4 == exhaleMask#_323_$_3[nw#_316_$_0,AVLTreeNode.keys := exhaleMask#_323_$_3[nw#_316_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_323_$_3[nw#_316_$_0,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_323_$_4);
	assume wf(Heap_$_1,exhaleMask#_323_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_67,ZeroMask);
	assert { :msg "  215.6: The precondition at 161.12 might not hold. The permission at 161.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  215.6: The precondition at 161.12 might not hold. Insufficient fraction at 161.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_323_$_4[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_323_$_4[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_323_$_4[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_323_$_5 == exhaleMask#_323_$_4[nw#_316_$_0,AVLTreeNode.balanceFactor := exhaleMask#_323_$_4[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_323_$_4[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_323_$_5);
	assume wf(Heap_$_1,exhaleMask#_323_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_67,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_322_$_0,Heap_$_1,exhaleMask#_323_$_5,ZeroMask);
	assume IsGoodMask(exhaleMask#_323_$_5);
	assume wf(exhaleHeap#_322_$_0,exhaleMask#_323_$_5,ZeroMask);
	assume !(nw#_316_$_0 == null);
	assume wf(exhaleHeap#_322_$_0,exhaleMask#_323_$_5,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_68 == exhaleMask#_323_$_5[nw#_316_$_0,AVLTreeNode.valid := exhaleMask#_323_$_5[nw#_316_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_323_$_5[nw#_316_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_68);
	assume IsGoodState(heapFragment(exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_322_$_0,Mask_$_68,ZeroMask);
	assume wf(exhaleHeap#_322_$_0,Mask_$_68,ZeroMask);
	assume !(nw#_316_$_0 == null);
	assume wf(exhaleHeap#_322_$_0,Mask_$_68,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_69 == Mask_$_68[nw#_316_$_0,AVLTreeNode.keys := Mask_$_68[nw#_316_$_0,AVLTreeNode.keys][perm$R := Mask_$_68[nw#_316_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_69);
	assume IsGoodState(heapFragment(exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_322_$_0,Mask_$_69,ZeroMask);
	assume wf(exhaleHeap#_322_$_0,Mask_$_69,ZeroMask);
	assume !(nw#_316_$_0 == null);
	assume wf(exhaleHeap#_322_$_0,Mask_$_69,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_70 == Mask_$_69[nw#_316_$_0,AVLTreeNode.height := Mask_$_69[nw#_316_$_0,AVLTreeNode.height][perm$R := Mask_$_69[nw#_316_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_70);
	assume IsGoodState(heapFragment(exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_322_$_0,Mask_$_70,ZeroMask);
	assume wf(exhaleHeap#_322_$_0,Mask_$_70,ZeroMask);
	assume !(nw#_316_$_0 == null);
	assume wf(exhaleHeap#_322_$_0,Mask_$_70,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_71 == Mask_$_70[nw#_316_$_0,AVLTreeNode.balanceFactor := Mask_$_70[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_70[nw#_316_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_71);
	assume IsGoodState(heapFragment(exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_322_$_0,Mask_$_71,ZeroMask);
	assume wf(exhaleHeap#_322_$_0,Mask_$_71,ZeroMask);
	assume exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.height] == 1;
	assume Seq#Equal(exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.keys],Seq#Singleton(k#9));
	assume exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.balanceFactor] == 0;
	assume Seq#Contains(exhaleHeap#_322_$_0[nw#_316_$_0,AVLTreeNode.keys],k#9);
	assume IsGoodMask(Mask_$_71);
	assume wf(exhaleHeap#_322_$_0,Mask_$_71,ZeroMask);
	assume Mask_$_76 == Mask_$_71;
	assume Heap_$_4 == exhaleHeap#_322_$_0;
	assume nl#12_$_0 == nw#_316_$_0;
	goto anon118;
anon322_Else:
	assume !cond#_315_$_0;
	assume ((0 < methodCallK#_336) && ((1000 * methodCallK#_336) < Fractions(1))) && ((1000 * methodCallK#_336) < methodK#_261);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  217.17: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  217.17: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  217.6: The target of the method call might be null." } !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume this#172_$_0 == Heap_$_1[this,AVLTreeNode.left];
	assert { :msg "  217.6: The precondition at 185.12 might not hold. The permission at 185.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  217.6: The precondition at 185.12 might not hold. Insufficient fraction at 185.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_26[this#172_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_26[this#172_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_26[this#172_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_338_$_0 == Mask_$_26[this#172_$_0,AVLTreeNode.valid := Mask_$_26[this#172_$_0,AVLTreeNode.valid][perm$R := Mask_$_26[this#172_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$31) { goto anon323_Then; } else { goto anon323_Else; }
anon359_Then:
	assume cond#_407_$_0;
	assume (!(nw#_408_$_0 == null)) && (dtype(nw#_408_$_0) == AVLTreeNode#t);
	assume (forall<T#_2> f_$17 : Field (T#_2)  :: ( (Mask_$_26[nw#_408_$_0,f_$17][perm$R] == 0) && (Mask_$_26[nw#_408_$_0,f_$17][perm$N] == 0) ));
	assume Heap_$_1[nw#_408_$_0,mu] == $LockBottom;
	assume Heap_$_1[nw#_408_$_0,held] <= 0;
	assume Heap_$_1[nw#_408_$_0,rdheld] <==> false;
	assume Mask_$_27 == Mask_$_26[nw#_408_$_0,AVLTreeNode.key := Mask_$_26[nw#_408_$_0,AVLTreeNode.key][perm$R := Mask_$_26[nw#_408_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume Mask_$_28 == Mask_$_27[nw#_408_$_0,AVLTreeNode.height := Mask_$_27[nw#_408_$_0,AVLTreeNode.height][perm$R := Mask_$_27[nw#_408_$_0,AVLTreeNode.height][perm$R] + Fractions(100)]];
	assume Mask_$_29 == Mask_$_28[nw#_408_$_0,AVLTreeNode.left := Mask_$_28[nw#_408_$_0,AVLTreeNode.left][perm$R := Mask_$_28[nw#_408_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume Mask_$_30 == Mask_$_29[nw#_408_$_0,AVLTreeNode.right := Mask_$_29[nw#_408_$_0,AVLTreeNode.right][perm$R := Mask_$_29[nw#_408_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume Mask_$_31 == Mask_$_30[nw#_408_$_0,AVLTreeNode.keys := Mask_$_30[nw#_408_$_0,AVLTreeNode.keys][perm$R := Mask_$_30[nw#_408_$_0,AVLTreeNode.keys][perm$R] + Fractions(100)]];
	assume Mask_$_32 == Mask_$_31[nw#_408_$_0,AVLTreeNode.balanceFactor := Mask_$_31[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_31[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(100)]];
	assume Mask_$_33 == Mask_$_32[nw#_408_$_0,mu := Mask_$_32[nw#_408_$_0,mu][perm$R := Mask_$_32[nw#_408_$_0,mu][perm$R] + Fractions(100)]];
	assume ((0 < methodCallK#_413) && ((1000 * methodCallK#_413) < Fractions(1))) && ((1000 * methodCallK#_413) < methodK#_261);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assert { :msg "  233.6: The target of the method call might be null." } !(nw#_408_$_0 == null);
	assert { :msg "  233.6: The precondition at 155.12 might not hold. The permission at 155.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  233.6: The precondition at 155.12 might not hold. Insufficient fraction at 155.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_33[nw#_408_$_0,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_33[nw#_408_$_0,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_33[nw#_408_$_0,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_415_$_0 == Mask_$_33[nw#_408_$_0,AVLTreeNode.key := Mask_$_33[nw#_408_$_0,AVLTreeNode.key][perm$R := Mask_$_33[nw#_408_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_415_$_0);
	assume wf(Heap_$_1,exhaleMask#_415_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assert { :msg "  233.6: The precondition at 156.12 might not hold. The permission at 156.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  233.6: The precondition at 156.12 might not hold. Insufficient fraction at 156.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_415_$_0[nw#_408_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_415_$_0[nw#_408_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_415_$_0[nw#_408_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_415_$_1 == exhaleMask#_415_$_0[nw#_408_$_0,AVLTreeNode.height := exhaleMask#_415_$_0[nw#_408_$_0,AVLTreeNode.height][perm$R := exhaleMask#_415_$_0[nw#_408_$_0,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_415_$_1);
	assume wf(Heap_$_1,exhaleMask#_415_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assert { :msg "  233.6: The precondition at 157.12 might not hold. The permission at 157.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  233.6: The precondition at 157.12 might not hold. Insufficient fraction at 157.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_415_$_1[nw#_408_$_0,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_415_$_1[nw#_408_$_0,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_415_$_1[nw#_408_$_0,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_415_$_2 == exhaleMask#_415_$_1[nw#_408_$_0,AVLTreeNode.left := exhaleMask#_415_$_1[nw#_408_$_0,AVLTreeNode.left][perm$R := exhaleMask#_415_$_1[nw#_408_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_415_$_2);
	assume wf(Heap_$_1,exhaleMask#_415_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assert { :msg "  233.6: The precondition at 158.12 might not hold. The permission at 158.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  233.6: The precondition at 158.12 might not hold. Insufficient fraction at 158.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_415_$_2[nw#_408_$_0,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_415_$_2[nw#_408_$_0,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_415_$_2[nw#_408_$_0,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_415_$_3 == exhaleMask#_415_$_2[nw#_408_$_0,AVLTreeNode.right := exhaleMask#_415_$_2[nw#_408_$_0,AVLTreeNode.right][perm$R := exhaleMask#_415_$_2[nw#_408_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_415_$_3);
	assume wf(Heap_$_1,exhaleMask#_415_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assert { :msg "  233.6: The precondition at 160.12 might not hold. The permission at 160.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  233.6: The precondition at 160.12 might not hold. Insufficient fraction at 160.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_415_$_3[nw#_408_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_415_$_3[nw#_408_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_415_$_3[nw#_408_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_415_$_4 == exhaleMask#_415_$_3[nw#_408_$_0,AVLTreeNode.keys := exhaleMask#_415_$_3[nw#_408_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_415_$_3[nw#_408_$_0,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_415_$_4);
	assume wf(Heap_$_1,exhaleMask#_415_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assert { :msg "  233.6: The precondition at 161.12 might not hold. The permission at 161.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  233.6: The precondition at 161.12 might not hold. Insufficient fraction at 161.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_415_$_4[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_415_$_4[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_415_$_4[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_415_$_5 == exhaleMask#_415_$_4[nw#_408_$_0,AVLTreeNode.balanceFactor := exhaleMask#_415_$_4[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_415_$_4[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_415_$_5);
	assume wf(Heap_$_1,exhaleMask#_415_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_414_$_0,Heap_$_1,exhaleMask#_415_$_5,ZeroMask);
	assume IsGoodMask(exhaleMask#_415_$_5);
	assume wf(exhaleHeap#_414_$_0,exhaleMask#_415_$_5,ZeroMask);
	assume !(nw#_408_$_0 == null);
	assume wf(exhaleHeap#_414_$_0,exhaleMask#_415_$_5,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_34 == exhaleMask#_415_$_5[nw#_408_$_0,AVLTreeNode.valid := exhaleMask#_415_$_5[nw#_408_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_415_$_5[nw#_408_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_34);
	assume IsGoodState(heapFragment(exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_414_$_0,Mask_$_34,ZeroMask);
	assume wf(exhaleHeap#_414_$_0,Mask_$_34,ZeroMask);
	assume !(nw#_408_$_0 == null);
	assume wf(exhaleHeap#_414_$_0,Mask_$_34,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_35 == Mask_$_34[nw#_408_$_0,AVLTreeNode.keys := Mask_$_34[nw#_408_$_0,AVLTreeNode.keys][perm$R := Mask_$_34[nw#_408_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_35);
	assume IsGoodState(heapFragment(exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_414_$_0,Mask_$_35,ZeroMask);
	assume wf(exhaleHeap#_414_$_0,Mask_$_35,ZeroMask);
	assume !(nw#_408_$_0 == null);
	assume wf(exhaleHeap#_414_$_0,Mask_$_35,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_36 == Mask_$_35[nw#_408_$_0,AVLTreeNode.height := Mask_$_35[nw#_408_$_0,AVLTreeNode.height][perm$R := Mask_$_35[nw#_408_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_36);
	assume IsGoodState(heapFragment(exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_414_$_0,Mask_$_36,ZeroMask);
	assume wf(exhaleHeap#_414_$_0,Mask_$_36,ZeroMask);
	assume !(nw#_408_$_0 == null);
	assume wf(exhaleHeap#_414_$_0,Mask_$_36,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_37 == Mask_$_36[nw#_408_$_0,AVLTreeNode.balanceFactor := Mask_$_36[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_36[nw#_408_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_37);
	assume IsGoodState(heapFragment(exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_414_$_0,Mask_$_37,ZeroMask);
	assume wf(exhaleHeap#_414_$_0,Mask_$_37,ZeroMask);
	assume exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.height] == 1;
	assume Seq#Equal(exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.keys],Seq#Singleton(k#9));
	assume exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.balanceFactor] == 0;
	assume Seq#Contains(exhaleHeap#_414_$_0[nw#_408_$_0,AVLTreeNode.keys],k#9);
	assume IsGoodMask(Mask_$_37);
	assume wf(exhaleHeap#_414_$_0,Mask_$_37,ZeroMask);
	assume Mask_$_42 == Mask_$_37;
	assume Heap_$_2 == exhaleHeap#_414_$_0;
	assume nr#16_$_0 == nw#_408_$_0;
	goto anon194;
anon359_Else:
	assume !cond#_407_$_0;
	assume ((0 < methodCallK#_428) && ((1000 * methodCallK#_428) < Fractions(1))) && ((1000 * methodCallK#_428) < methodK#_261);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  235.17: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  235.17: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  235.6: The target of the method call might be null." } !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume this#192_$_0 == Heap_$_1[this,AVLTreeNode.right];
	assert { :msg "  235.6: The precondition at 185.12 might not hold. The permission at 185.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  235.6: The precondition at 185.12 might not hold. Insufficient fraction at 185.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_26[this#192_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_26[this#192_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_26[this#192_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_430_$_0 == Mask_$_26[this#192_$_0,AVLTreeNode.valid := Mask_$_26[this#192_$_0,AVLTreeNode.valid][perm$R := Mask_$_26[this#192_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$32) { goto anon360_Then; } else { goto anon360_Else; }
anon85:
	assert { :msg "  209.4: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  209.4: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  209.4: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_26[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_26[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_26[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_297_$_0 == Mask_$_26[this,AVLTreeNode.key := Mask_$_26[this,AVLTreeNode.key][perm$R := Mask_$_26[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_297_$_0);
	assume wf(Heap_$_1,exhaleMask#_297_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  209.4: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_297_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_297_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_297_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_297_$_1 == exhaleMask#_297_$_0[this,AVLTreeNode.height := exhaleMask#_297_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_297_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_297_$_1);
	assume wf(Heap_$_1,exhaleMask#_297_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  209.4: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_297_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_297_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_297_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_297_$_2 == exhaleMask#_297_$_1[this,AVLTreeNode.left := exhaleMask#_297_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_297_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_297_$_2);
	assume wf(Heap_$_1,exhaleMask#_297_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  209.4: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_297_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_297_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_297_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_297_$_3 == exhaleMask#_297_$_2[this,AVLTreeNode.right := exhaleMask#_297_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_297_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_297_$_3);
	assume wf(Heap_$_1,exhaleMask#_297_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  209.4: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_297_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_297_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_297_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_297_$_4 == exhaleMask#_297_$_3[this,AVLTreeNode.keys := exhaleMask#_297_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_297_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_297_$_4);
	assume wf(Heap_$_1,exhaleMask#_297_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  209.4: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_297_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_297_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_297_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_297_$_5 == exhaleMask#_297_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_297_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_297_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_297_$_5);
	assume wf(Heap_$_1,exhaleMask#_297_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	if ($_$_condition_$33) { goto anon311_Then; } else { goto anon311_Else; }
anon118:
	assert { :msg "  219.5: Location might not be writable" } CanWrite(Mask_$_76,this,AVLTreeNode.left);
	assume Heap_$_5 == Heap_$_4[this,AVLTreeNode.left := nl#12_$_0];
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	assume ((0 < methodCallK#_349) && ((1000 * methodCallK#_349) < Fractions(1))) && ((1000 * methodCallK#_349) < methodK#_261);
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	assert { :msg "  221.5: The target of the method call might be null." } !(this == null);
	assert { :msg "  221.5: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive." } methodCallK#_349 > 0;
	assert { :msg "  221.5: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left." } Mask_$_76[this,AVLTreeNode.left][perm$R] > 0;
	assume methodCallK#_349 < Mask_$_76[this,AVLTreeNode.left][perm$R];
	assume exhaleMask#_351_$_0 == Mask_$_76[this,AVLTreeNode.left := Mask_$_76[this,AVLTreeNode.left][perm$R := Mask_$_76[this,AVLTreeNode.left][perm$R] - methodCallK#_349]];
	assume IsGoodMask(exhaleMask#_351_$_0);
	assume wf(Heap_$_5,exhaleMask#_351_$_0,ZeroMask);
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	if ($_$_condition_$53) { goto anon327_Then; } else { goto anon327_Else; }
anon323_Then:
	assume !CanRead(exhaleMask#_338_$_0,ZeroMask,this#172_$_0,AVLTreeNode.valid);
	assume Heap_$_1[this#172_$_0,AVLTreeNode.valid] < exhaleHeap#_337_$_0[this#172_$_0,AVLTreeNode.valid];
	goto anon111;
anon323_Else:
	assume CanRead(exhaleMask#_338_$_0,ZeroMask,this#172_$_0,AVLTreeNode.valid);
	goto anon111;
anon194:
	assert { :msg "  237.5: Location might not be writable" } CanWrite(Mask_$_42,this,AVLTreeNode.right);
	assume Heap_$_3 == Heap_$_2[this,AVLTreeNode.right := nr#16_$_0];
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	assume ((0 < methodCallK#_441) && ((1000 * methodCallK#_441) < Fractions(1))) && ((1000 * methodCallK#_441) < methodK#_261);
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	assert { :msg "  240.5: The target of the method call might be null." } !(this == null);
	assert { :msg "  240.5: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive." } methodCallK#_441 > 0;
	assert { :msg "  240.5: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left." } Mask_$_42[this,AVLTreeNode.left][perm$R] > 0;
	assume methodCallK#_441 < Mask_$_42[this,AVLTreeNode.left][perm$R];
	assume exhaleMask#_443_$_0 == Mask_$_42[this,AVLTreeNode.left := Mask_$_42[this,AVLTreeNode.left][perm$R := Mask_$_42[this,AVLTreeNode.left][perm$R] - methodCallK#_441]];
	assume IsGoodMask(exhaleMask#_443_$_0);
	assume wf(Heap_$_3,exhaleMask#_443_$_0,ZeroMask);
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	if ($_$_condition_$54) { goto anon364_Then; } else { goto anon364_Else; }
anon360_Then:
	assume !CanRead(exhaleMask#_430_$_0,ZeroMask,this#192_$_0,AVLTreeNode.valid);
	assume Heap_$_1[this#192_$_0,AVLTreeNode.valid] < exhaleHeap#_429_$_0[this#192_$_0,AVLTreeNode.valid];
	goto anon187;
anon360_Else:
	assume CanRead(exhaleMask#_430_$_0,ZeroMask,this#192_$_0,AVLTreeNode.valid);
	goto anon187;
anon311_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  209.4: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_297_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_297_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_297_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_297_$_6 == exhaleMask#_297_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_297_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_297_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$34) { goto anon312_Then; } else { goto anon312_Else; }
anon311_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_297_$_7 == exhaleMask#_297_$_5;
	if ($_$_condition_$35) { goto anon313_Then; } else { goto anon313_Else; }
anon111:
	assume IsGoodMask(exhaleMask#_338_$_0);
	assume wf(Heap_$_1,exhaleMask#_338_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  217.6: The precondition at 186.12 might not hold. The permission at 186.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  217.6: The precondition at 186.12 might not hold. Insufficient fraction at 186.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_338_$_0[this#172_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_338_$_0[this#172_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_338_$_0[this#172_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_338_$_1 == exhaleMask#_338_$_0[this#172_$_0,AVLTreeNode.keys := exhaleMask#_338_$_0[this#172_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_338_$_0[this#172_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_338_$_1);
	assume wf(Heap_$_1,exhaleMask#_338_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  217.6: The precondition at 187.12 might not hold. The permission at 187.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  217.6: The precondition at 187.12 might not hold. Insufficient fraction at 187.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_338_$_1[this#172_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_338_$_1[this#172_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_338_$_1[this#172_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_338_$_2 == exhaleMask#_338_$_1[this#172_$_0,AVLTreeNode.height := exhaleMask#_338_$_1[this#172_$_0,AVLTreeNode.height][perm$R := exhaleMask#_338_$_1[this#172_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_338_$_2);
	assume wf(Heap_$_1,exhaleMask#_338_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  217.6: The precondition at 188.12 might not hold. The permission at 188.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  217.6: The precondition at 188.12 might not hold. Insufficient fraction at 188.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_338_$_2[this#172_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_338_$_2[this#172_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_338_$_2[this#172_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_338_$_3 == exhaleMask#_338_$_2[this#172_$_0,AVLTreeNode.balanceFactor := exhaleMask#_338_$_2[this#172_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_338_$_2[this#172_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_338_$_3);
	assume wf(Heap_$_1,exhaleMask#_338_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_337_$_0,Heap_$_1,exhaleMask#_338_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_338_$_3);
	assume wf(exhaleHeap#_337_$_0,exhaleMask#_338_$_3,ZeroMask);
	assume (r#174_$_0 == null) || (dtype(r#174_$_0) == AVLTreeNode#t);
	assume !(r#174_$_0 == null);
	assume !(r#174_$_0 == null);
	assume wf(exhaleHeap#_337_$_0,exhaleMask#_338_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_72 == exhaleMask#_338_$_3[r#174_$_0,AVLTreeNode.valid := exhaleMask#_338_$_3[r#174_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_338_$_3[r#174_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_72);
	assume IsGoodState(heapFragment(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_337_$_0,Mask_$_72,ZeroMask);
	assume wf(exhaleHeap#_337_$_0,Mask_$_72,ZeroMask);
	assume !(r#174_$_0 == null);
	assume wf(exhaleHeap#_337_$_0,Mask_$_72,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_73 == Mask_$_72[r#174_$_0,AVLTreeNode.keys := Mask_$_72[r#174_$_0,AVLTreeNode.keys][perm$R := Mask_$_72[r#174_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_73);
	assume IsGoodState(heapFragment(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_337_$_0,Mask_$_73,ZeroMask);
	assume wf(exhaleHeap#_337_$_0,Mask_$_73,ZeroMask);
	assume !(r#174_$_0 == null);
	assume wf(exhaleHeap#_337_$_0,Mask_$_73,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_74 == Mask_$_73[r#174_$_0,AVLTreeNode.height := Mask_$_73[r#174_$_0,AVLTreeNode.height][perm$R := Mask_$_73[r#174_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_74);
	assume IsGoodState(heapFragment(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_337_$_0,Mask_$_74,ZeroMask);
	assume wf(exhaleHeap#_337_$_0,Mask_$_74,ZeroMask);
	assume !(r#174_$_0 == null);
	assume wf(exhaleHeap#_337_$_0,Mask_$_74,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_75 == Mask_$_74[r#174_$_0,AVLTreeNode.balanceFactor := Mask_$_74[r#174_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_74[r#174_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_75);
	assume IsGoodState(heapFragment(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_337_$_0,Mask_$_75,ZeroMask);
	assume wf(exhaleHeap#_337_$_0,Mask_$_75,ZeroMask);
	assume Seq#Contains(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys],k#9);
	assume (forall  i#82#175 : Integer :: ( ((0 <= i#82#175) && (i#82#175 < Seq#Length(Heap_$_1[this#172_$_0,AVLTreeNode.keys]))) ==> Seq#Contains(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys],Seq#Index(Heap_$_1[this#172_$_0,AVLTreeNode.keys],i#82#175)) ));
	assume (forall  i#83#176 : Integer :: ( ((0 <= i#83#176) && (i#83#176 < Seq#Length(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap_$_1[this#172_$_0,AVLTreeNode.keys],Seq#Index(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys],i#83#176)) || (Seq#Index(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys],i#83#176) == k#9)) ));
	if ($_$_condition_$36) { goto anon324_Then; } else { goto anon324_Else; }
anon187:
	assume IsGoodMask(exhaleMask#_430_$_0);
	assume wf(Heap_$_1,exhaleMask#_430_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  235.6: The precondition at 186.12 might not hold. The permission at 186.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  235.6: The precondition at 186.12 might not hold. Insufficient fraction at 186.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_430_$_0[this#192_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_430_$_0[this#192_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_430_$_0[this#192_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_430_$_1 == exhaleMask#_430_$_0[this#192_$_0,AVLTreeNode.keys := exhaleMask#_430_$_0[this#192_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_430_$_0[this#192_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_430_$_1);
	assume wf(Heap_$_1,exhaleMask#_430_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  235.6: The precondition at 187.12 might not hold. The permission at 187.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  235.6: The precondition at 187.12 might not hold. Insufficient fraction at 187.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_430_$_1[this#192_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_430_$_1[this#192_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_430_$_1[this#192_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_430_$_2 == exhaleMask#_430_$_1[this#192_$_0,AVLTreeNode.height := exhaleMask#_430_$_1[this#192_$_0,AVLTreeNode.height][perm$R := exhaleMask#_430_$_1[this#192_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_430_$_2);
	assume wf(Heap_$_1,exhaleMask#_430_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  235.6: The precondition at 188.12 might not hold. The permission at 188.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  235.6: The precondition at 188.12 might not hold. Insufficient fraction at 188.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_430_$_2[this#192_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_430_$_2[this#192_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_430_$_2[this#192_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_430_$_3 == exhaleMask#_430_$_2[this#192_$_0,AVLTreeNode.balanceFactor := exhaleMask#_430_$_2[this#192_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_430_$_2[this#192_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_430_$_3);
	assume wf(Heap_$_1,exhaleMask#_430_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_429_$_0,Heap_$_1,exhaleMask#_430_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_430_$_3);
	assume wf(exhaleHeap#_429_$_0,exhaleMask#_430_$_3,ZeroMask);
	assume (r#194_$_0 == null) || (dtype(r#194_$_0) == AVLTreeNode#t);
	assume !(r#194_$_0 == null);
	assume !(r#194_$_0 == null);
	assume wf(exhaleHeap#_429_$_0,exhaleMask#_430_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_38 == exhaleMask#_430_$_3[r#194_$_0,AVLTreeNode.valid := exhaleMask#_430_$_3[r#194_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_430_$_3[r#194_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_38);
	assume IsGoodState(heapFragment(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_429_$_0,Mask_$_38,ZeroMask);
	assume wf(exhaleHeap#_429_$_0,Mask_$_38,ZeroMask);
	assume !(r#194_$_0 == null);
	assume wf(exhaleHeap#_429_$_0,Mask_$_38,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_39 == Mask_$_38[r#194_$_0,AVLTreeNode.keys := Mask_$_38[r#194_$_0,AVLTreeNode.keys][perm$R := Mask_$_38[r#194_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_39);
	assume IsGoodState(heapFragment(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_429_$_0,Mask_$_39,ZeroMask);
	assume wf(exhaleHeap#_429_$_0,Mask_$_39,ZeroMask);
	assume !(r#194_$_0 == null);
	assume wf(exhaleHeap#_429_$_0,Mask_$_39,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_40 == Mask_$_39[r#194_$_0,AVLTreeNode.height := Mask_$_39[r#194_$_0,AVLTreeNode.height][perm$R := Mask_$_39[r#194_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_40);
	assume IsGoodState(heapFragment(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_429_$_0,Mask_$_40,ZeroMask);
	assume wf(exhaleHeap#_429_$_0,Mask_$_40,ZeroMask);
	assume !(r#194_$_0 == null);
	assume wf(exhaleHeap#_429_$_0,Mask_$_40,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_41 == Mask_$_40[r#194_$_0,AVLTreeNode.balanceFactor := Mask_$_40[r#194_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_40[r#194_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_41);
	assume IsGoodState(heapFragment(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_429_$_0,Mask_$_41,ZeroMask);
	assume wf(exhaleHeap#_429_$_0,Mask_$_41,ZeroMask);
	assume Seq#Contains(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys],k#9);
	assume (forall  i#82#195 : Integer :: ( ((0 <= i#82#195) && (i#82#195 < Seq#Length(Heap_$_1[this#192_$_0,AVLTreeNode.keys]))) ==> Seq#Contains(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys],Seq#Index(Heap_$_1[this#192_$_0,AVLTreeNode.keys],i#82#195)) ));
	assume (forall  i#83#196 : Integer :: ( ((0 <= i#83#196) && (i#83#196 < Seq#Length(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap_$_1[this#192_$_0,AVLTreeNode.keys],Seq#Index(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys],i#83#196)) || (Seq#Index(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys],i#83#196) == k#9)) ));
	if ($_$_condition_$37) { goto anon361_Then; } else { goto anon361_Else; }
anon312_Then:
	assume !CanRead(exhaleMask#_297_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_296_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon88;
anon312_Else:
	assume CanRead(exhaleMask#_297_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon88;
anon313_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  209.4: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  209.4: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_297_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_297_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_297_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_297_$_8 == exhaleMask#_297_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_297_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_297_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_297_$_8);
	assume wf(Heap_$_1,exhaleMask#_297_$_8,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_9 == exhaleMask#_297_$_8;
	if ($_$_condition_$43) { goto anon314_Then; } else { goto anon314_Else; }
anon313_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_297_$_9 == exhaleMask#_297_$_7;
	if ($_$_condition_$44) { goto anon314_Then; } else { goto anon314_Else; }
anon324_Then:
	assume Seq#Contains(Heap_$_1[this#172_$_0,AVLTreeNode.keys],k#9);
	assume Seq#Equal(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys],Heap_$_1[this#172_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$38) { goto anon325_Then; } else { goto anon325_Else; }
anon324_Else:
	assume !Seq#Contains(Heap_$_1[this#172_$_0,AVLTreeNode.keys],k#9);
	if ($_$_condition_$39) { goto anon325_Then; } else { goto anon325_Else; }
anon361_Then:
	assume Seq#Contains(Heap_$_1[this#192_$_0,AVLTreeNode.keys],k#9);
	assume Seq#Equal(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys],Heap_$_1[this#192_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$40) { goto anon362_Then; } else { goto anon362_Else; }
anon361_Else:
	assume !Seq#Contains(Heap_$_1[this#192_$_0,AVLTreeNode.keys],k#9);
	if ($_$_condition_$41) { goto anon362_Then; } else { goto anon362_Else; }
anon88:
	assume IsGoodMask(exhaleMask#_297_$_6);
	assume wf(Heap_$_1,exhaleMask#_297_$_6,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_7 == exhaleMask#_297_$_6;
	if ($_$_condition_$42) { goto anon313_Then; } else { goto anon313_Else; }
anon325_Then:
	assume !Seq#Contains(Heap_$_1[this#172_$_0,AVLTreeNode.keys],k#9);
	assume Seq#Length(exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.keys]) == (Seq#Length(Heap_$_1[this#172_$_0,AVLTreeNode.keys]) + 1);
	goto anon115;
anon325_Else:
	assume Seq#Contains(Heap_$_1[this#172_$_0,AVLTreeNode.keys],k#9);
	goto anon115;
anon362_Then:
	assume !Seq#Contains(Heap_$_1[this#192_$_0,AVLTreeNode.keys],k#9);
	assume Seq#Length(exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.keys]) == (Seq#Length(Heap_$_1[this#192_$_0,AVLTreeNode.keys]) + 1);
	goto anon191;
anon362_Else:
	assume Seq#Contains(Heap_$_1[this#192_$_0,AVLTreeNode.keys],k#9);
	goto anon191;
anon115:
	assume (exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.height] == Heap_$_1[this#172_$_0,AVLTreeNode.height]) || (exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.height] == (Heap_$_1[this#172_$_0,AVLTreeNode.height] + 1));
	if ($_$_condition_$45) { goto anon326_Then; } else { goto anon326_Else; }
anon191:
	assume (exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.height] == Heap_$_1[this#192_$_0,AVLTreeNode.height]) || (exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.height] == (Heap_$_1[this#192_$_0,AVLTreeNode.height] + 1));
	if ($_$_condition_$46) { goto anon363_Then; } else { goto anon363_Else; }
anon314_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  209.4: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  209.4: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_297_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_297_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_297_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_297_$_10 == exhaleMask#_297_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_297_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_297_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_297_$_10);
	assume wf(Heap_$_1,exhaleMask#_297_$_10,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_11 == exhaleMask#_297_$_10;
	if ($_$_condition_$47) { goto anon315_Then; } else { goto anon315_Else; }
anon314_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_297_$_11 == exhaleMask#_297_$_9;
	if ($_$_condition_$48) { goto anon315_Then; } else { goto anon315_Else; }
anon326_Then:
	assume Seq#Contains(Heap_$_1[this#172_$_0,AVLTreeNode.keys],k#9);
	assume exhaleHeap#_337_$_0[r#174_$_0,AVLTreeNode.height] == Heap_$_1[this#172_$_0,AVLTreeNode.height];
	goto anon117;
anon326_Else:
	assume !Seq#Contains(Heap_$_1[this#172_$_0,AVLTreeNode.keys],k#9);
	goto anon117;
anon363_Then:
	assume Seq#Contains(Heap_$_1[this#192_$_0,AVLTreeNode.keys],k#9);
	assume exhaleHeap#_429_$_0[r#194_$_0,AVLTreeNode.height] == Heap_$_1[this#192_$_0,AVLTreeNode.height];
	goto anon193;
anon363_Else:
	assume !Seq#Contains(Heap_$_1[this#192_$_0,AVLTreeNode.keys],k#9);
	goto anon193;
anon315_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  209.4: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  209.4: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_297_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_297_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_297_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_297_$_12 == exhaleMask#_297_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_297_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_297_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_297_$_12);
	assume wf(Heap_$_1,exhaleMask#_297_$_12,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_13 == exhaleMask#_297_$_12;
	if ($_$_condition_$49) { goto anon316_Then; } else { goto anon316_Else; }
anon315_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_297_$_13 == exhaleMask#_297_$_11;
	if ($_$_condition_$50) { goto anon316_Then; } else { goto anon316_Else; }
anon117:
	assume IsGoodMask(Mask_$_75);
	assume wf(exhaleHeap#_337_$_0,Mask_$_75,ZeroMask);
	assume Mask_$_76 == Mask_$_75;
	assume Heap_$_4 == exhaleHeap#_337_$_0;
	assume nl#12_$_0 == r#174_$_0;
	goto anon118;
anon193:
	assume IsGoodMask(Mask_$_41);
	assume wf(exhaleHeap#_429_$_0,Mask_$_41,ZeroMask);
	assume Mask_$_42 == Mask_$_41;
	assume Heap_$_2 == exhaleHeap#_429_$_0;
	assume nr#16_$_0 == r#194_$_0;
	goto anon194;
anon316_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  209.4: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  209.4: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_297_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_297_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_297_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_297_$_14 == exhaleMask#_297_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_297_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_297_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$51) { goto anon317_Then; } else { goto anon317_Else; }
anon316_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_297_$_15 == exhaleMask#_297_$_13;
	if ($_$_condition_$52) { goto anon318_Then; } else { goto anon318_Else; }
anon317_Then:
	assume !CanRead(exhaleMask#_297_$_14,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_296_$_0[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon98;
anon317_Else:
	assume CanRead(exhaleMask#_297_$_14,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon98;
anon318_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  209.4: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  209.4: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_297_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_297_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_297_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_297_$_16 == exhaleMask#_297_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_297_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_297_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_297_$_16);
	assume wf(Heap_$_1,exhaleMask#_297_$_16,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_17 == exhaleMask#_297_$_16;
	if ($_$_condition_$58) { goto anon319_Then; } else { goto anon319_Else; }
anon318_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_297_$_17 == exhaleMask#_297_$_15;
	if ($_$_condition_$59) { goto anon319_Then; } else { goto anon319_Else; }
anon327_Then:
	assume !(Heap_$_5[this,AVLTreeNode.left] == null);
	assert { :msg "  221.5: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive." } methodCallK#_349 > 0;
	assert { :msg "  221.5: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height." } exhaleMask#_351_$_0[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_349 < exhaleMask#_351_$_0[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume exhaleMask#_351_$_1 == exhaleMask#_351_$_0[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_351_$_0[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_351_$_0[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - methodCallK#_349]];
	assume IsGoodMask(exhaleMask#_351_$_1);
	assume wf(Heap_$_5,exhaleMask#_351_$_1,ZeroMask);
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	assume exhaleMask#_351_$_2 == exhaleMask#_351_$_1;
	goto anon120;
anon327_Else:
	assume Heap_$_5[this,AVLTreeNode.left] == null;
	assume exhaleMask#_351_$_2 == exhaleMask#_351_$_0;
	goto anon120;
anon364_Then:
	assume !(Heap_$_3[this,AVLTreeNode.left] == null);
	assert { :msg "  240.5: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive." } methodCallK#_441 > 0;
	assert { :msg "  240.5: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height." } exhaleMask#_443_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_441 < exhaleMask#_443_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume exhaleMask#_443_$_1 == exhaleMask#_443_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_443_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_443_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - methodCallK#_441]];
	assume IsGoodMask(exhaleMask#_443_$_1);
	assume wf(Heap_$_3,exhaleMask#_443_$_1,ZeroMask);
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	assume exhaleMask#_443_$_2 == exhaleMask#_443_$_1;
	goto anon196;
anon364_Else:
	assume Heap_$_3[this,AVLTreeNode.left] == null;
	assume exhaleMask#_443_$_2 == exhaleMask#_443_$_0;
	goto anon196;
anon98:
	assume IsGoodMask(exhaleMask#_297_$_14);
	assume wf(Heap_$_1,exhaleMask#_297_$_14,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_15 == exhaleMask#_297_$_14;
	if ($_$_condition_$55) { goto anon318_Then; } else { goto anon318_Else; }
anon120:
	assert { :msg "  221.5: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive." } methodCallK#_349 > 0;
	assert { :msg "  221.5: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right." } exhaleMask#_351_$_2[this,AVLTreeNode.right][perm$R] > 0;
	assume methodCallK#_349 < exhaleMask#_351_$_2[this,AVLTreeNode.right][perm$R];
	assume exhaleMask#_351_$_3 == exhaleMask#_351_$_2[this,AVLTreeNode.right := exhaleMask#_351_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_351_$_2[this,AVLTreeNode.right][perm$R] - methodCallK#_349]];
	assume IsGoodMask(exhaleMask#_351_$_3);
	assume wf(Heap_$_5,exhaleMask#_351_$_3,ZeroMask);
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	if ($_$_condition_$56) { goto anon328_Then; } else { goto anon328_Else; }
anon196:
	assert { :msg "  240.5: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive." } methodCallK#_441 > 0;
	assert { :msg "  240.5: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right." } exhaleMask#_443_$_2[this,AVLTreeNode.right][perm$R] > 0;
	assume methodCallK#_441 < exhaleMask#_443_$_2[this,AVLTreeNode.right][perm$R];
	assume exhaleMask#_443_$_3 == exhaleMask#_443_$_2[this,AVLTreeNode.right := exhaleMask#_443_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_443_$_2[this,AVLTreeNode.right][perm$R] - methodCallK#_441]];
	assume IsGoodMask(exhaleMask#_443_$_3);
	assume wf(Heap_$_3,exhaleMask#_443_$_3,ZeroMask);
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	if ($_$_condition_$57) { goto anon365_Then; } else { goto anon365_Else; }
anon328_Then:
	assume !(Heap_$_5[this,AVLTreeNode.right] == null);
	assert { :msg "  221.5: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive." } methodCallK#_349 > 0;
	assert { :msg "  221.5: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height." } exhaleMask#_351_$_3[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_349 < exhaleMask#_351_$_3[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume exhaleMask#_351_$_4 == exhaleMask#_351_$_3[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_351_$_3[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_351_$_3[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - methodCallK#_349]];
	assume IsGoodMask(exhaleMask#_351_$_4);
	assume wf(Heap_$_5,exhaleMask#_351_$_4,ZeroMask);
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	assume exhaleMask#_351_$_5 == exhaleMask#_351_$_4;
	if ($_$_condition_$60) { goto anon329_Then; } else { goto anon329_Else; }
anon328_Else:
	assume Heap_$_5[this,AVLTreeNode.right] == null;
	assume exhaleMask#_351_$_5 == exhaleMask#_351_$_3;
	if ($_$_condition_$61) { goto anon329_Then; } else { goto anon329_Else; }
anon365_Then:
	assume !(Heap_$_3[this,AVLTreeNode.right] == null);
	assert { :msg "  240.5: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive." } methodCallK#_441 > 0;
	assert { :msg "  240.5: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height." } exhaleMask#_443_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_441 < exhaleMask#_443_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume exhaleMask#_443_$_4 == exhaleMask#_443_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_443_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_443_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - methodCallK#_441]];
	assume IsGoodMask(exhaleMask#_443_$_4);
	assume wf(Heap_$_3,exhaleMask#_443_$_4,ZeroMask);
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	assume exhaleMask#_443_$_5 == exhaleMask#_443_$_4;
	if ($_$_condition_$62) { goto anon366_Then; } else { goto anon366_Else; }
anon365_Else:
	assume Heap_$_3[this,AVLTreeNode.right] == null;
	assume exhaleMask#_443_$_5 == exhaleMask#_443_$_3;
	if ($_$_condition_$63) { goto anon366_Then; } else { goto anon366_Else; }
anon319_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  209.4: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  209.4: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_297_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_297_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_297_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_297_$_18 == exhaleMask#_297_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_297_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_297_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_297_$_18);
	assume wf(Heap_$_1,exhaleMask#_297_$_18,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_19 == exhaleMask#_297_$_18;
	if ($_$_condition_$64) { goto anon320_Then; } else { goto anon320_Else; }
anon319_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_297_$_19 == exhaleMask#_297_$_17;
	if ($_$_condition_$65) { goto anon320_Then; } else { goto anon320_Else; }
anon329_Then:
	assume !(Heap_$_5[this,AVLTreeNode.left] == null);
	assert { :msg "  221.5: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  221.5: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_351_$_5[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_351_$_5[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_351_$_5[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_351_$_6 == exhaleMask#_351_$_5[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_351_$_5[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_351_$_5[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$66) { goto anon330_Then; } else { goto anon330_Else; }
anon329_Else:
	assume Heap_$_5[this,AVLTreeNode.left] == null;
	assume exhaleMask#_351_$_7 == exhaleMask#_351_$_5;
	if ($_$_condition_$67) { goto anon331_Then; } else { goto anon331_Else; }
anon366_Then:
	assume !(Heap_$_3[this,AVLTreeNode.left] == null);
	assert { :msg "  240.5: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  240.5: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_443_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_443_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_443_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_443_$_6 == exhaleMask#_443_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_443_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_443_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$68) { goto anon367_Then; } else { goto anon367_Else; }
anon366_Else:
	assume Heap_$_3[this,AVLTreeNode.left] == null;
	assume exhaleMask#_443_$_7 == exhaleMask#_443_$_5;
	if ($_$_condition_$69) { goto anon368_Then; } else { goto anon368_Else; }
anon320_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  209.4: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  209.4: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_297_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_297_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_297_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_297_$_20 == exhaleMask#_297_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_297_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_297_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_297_$_20);
	assume wf(Heap_$_1,exhaleMask#_297_$_20,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_297_$_21 == exhaleMask#_297_$_20;
	goto anon105;
anon320_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_297_$_21 == exhaleMask#_297_$_19;
	goto anon105;
anon330_Then:
	assume !CanRead(exhaleMask#_351_$_6,ZeroMask,Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_5[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_350_$_0[Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon125;
anon330_Else:
	assume CanRead(exhaleMask#_351_$_6,ZeroMask,Heap_$_5[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon125;
anon331_Then:
	assume !(Heap_$_5[this,AVLTreeNode.right] == null);
	assert { :msg "  221.5: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  221.5: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_351_$_7[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_351_$_7[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_351_$_7[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_351_$_8 == exhaleMask#_351_$_7[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_351_$_7[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_351_$_7[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$72) { goto anon332_Then; } else { goto anon332_Else; }
anon331_Else:
	assume Heap_$_5[this,AVLTreeNode.right] == null;
	assume exhaleMask#_351_$_9 == exhaleMask#_351_$_7;
	goto anon130;
anon367_Then:
	assume !CanRead(exhaleMask#_443_$_6,ZeroMask,Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_442_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon201;
anon367_Else:
	assume CanRead(exhaleMask#_443_$_6,ZeroMask,Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon201;
anon368_Then:
	assume !(Heap_$_3[this,AVLTreeNode.right] == null);
	assert { :msg "  240.5: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  240.5: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_443_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_443_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_443_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_443_$_8 == exhaleMask#_443_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_443_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_443_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$73) { goto anon369_Then; } else { goto anon369_Else; }
anon368_Else:
	assume Heap_$_3[this,AVLTreeNode.right] == null;
	assume exhaleMask#_443_$_9 == exhaleMask#_443_$_7;
	goto anon206;
anon105:
	assume IsGoodExhaleState(exhaleHeap#_296_$_0,Heap_$_1,exhaleMask#_297_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_297_$_21);
	assume wf(exhaleHeap#_296_$_0,exhaleMask#_297_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_296_$_0,exhaleMask#_297_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_95 == exhaleMask#_297_$_21[this,AVLTreeNode.valid := exhaleMask#_297_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_297_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_95);
	assume IsGoodState(heapFragment(exhaleHeap#_296_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_296_$_0,Mask_$_95,ZeroMask);
	assume wf(exhaleHeap#_296_$_0,Mask_$_95,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_296_$_0,Mask_$_95,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_96 == Mask_$_95[this,AVLTreeNode.height := Mask_$_95[this,AVLTreeNode.height][perm$R := Mask_$_95[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_96);
	assume IsGoodState(heapFragment(exhaleHeap#_296_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_296_$_0,Mask_$_96,ZeroMask);
	assume wf(exhaleHeap#_296_$_0,Mask_$_96,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_296_$_0,Mask_$_96,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_97 == Mask_$_96[this,AVLTreeNode.keys := Mask_$_96[this,AVLTreeNode.keys][perm$R := Mask_$_96[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_97);
	assume IsGoodState(heapFragment(exhaleHeap#_296_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_296_$_0,Mask_$_97,ZeroMask);
	assume wf(exhaleHeap#_296_$_0,Mask_$_97,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_296_$_0,Mask_$_97,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_98 == Mask_$_97[this,AVLTreeNode.balanceFactor := Mask_$_97[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_97[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_98);
	assume IsGoodState(heapFragment(exhaleHeap#_296_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_296_$_0,Mask_$_98,ZeroMask);
	assume wf(exhaleHeap#_296_$_0,Mask_$_98,ZeroMask);
	assume Seq#Equal(exhaleHeap#_296_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[this,AVLTreeNode.key])),ite(Heap_$_1[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_296_$_0[this,AVLTreeNode.height] == ite(ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_296_$_0[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_98);
	assume wf(exhaleHeap#_296_$_0,Mask_$_98,ZeroMask);
	assume Heap_$_6 == exhaleHeap#_296_$_0;
	assume Mask_$_99 == Mask_$_98;
	assume r#10_$_0 == this;
	goto anon259;
anon125:
	assume IsGoodMask(exhaleMask#_351_$_6);
	assume wf(Heap_$_5,exhaleMask#_351_$_6,ZeroMask);
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	assume exhaleMask#_351_$_7 == exhaleMask#_351_$_6;
	if ($_$_condition_$70) { goto anon331_Then; } else { goto anon331_Else; }
anon201:
	assume IsGoodMask(exhaleMask#_443_$_6);
	assume wf(Heap_$_3,exhaleMask#_443_$_6,ZeroMask);
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	assume exhaleMask#_443_$_7 == exhaleMask#_443_$_6;
	if ($_$_condition_$71) { goto anon368_Then; } else { goto anon368_Else; }
anon259:
	assert { :msg "  184.2: The postcondition at 190.11 might not hold. The expression at 190.11 might not evaluate to true." } !(r#10_$_0 == null);
	assert { :msg "  184.2: The postcondition at 196.11 might not hold. The expression at 196.11 might not evaluate to true." } Seq#Contains(Heap_$_6[r#10_$_0,AVLTreeNode.keys],k#9);
	assert { :msg "  184.2: The postcondition at 197.11 might not hold. The expression at 197.11 might not evaluate to true." } (forall  i#82#210 : Integer :: ( ((0 <= i#82#210) && (i#82#210 < Seq#Length(Heap[this,AVLTreeNode.keys]))) ==> Seq#Contains(Heap_$_6[r#10_$_0,AVLTreeNode.keys],Seq#Index(Heap[this,AVLTreeNode.keys],i#82#210)) ));
	assert { :msg "  184.2: The postcondition at 198.11 might not hold. The expression at 198.11 might not evaluate to true." } (forall  i#83#211 : Integer :: ( ((0 <= i#83#211) && (i#83#211 < Seq#Length(Heap_$_6[r#10_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap[this,AVLTreeNode.keys],Seq#Index(Heap_$_6[r#10_$_0,AVLTreeNode.keys],i#83#211)) || (Seq#Index(Heap_$_6[r#10_$_0,AVLTreeNode.keys],i#83#211) == k#9)) ));
	if ($_$_condition_$154) { goto anon396_Then; } else { goto anon396_Else; }
anon332_Then:
	assume !CanRead(exhaleMask#_351_$_8,ZeroMask,Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_5[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_350_$_0[Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon129;
anon332_Else:
	assume CanRead(exhaleMask#_351_$_8,ZeroMask,Heap_$_5[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon129;
anon130:
	assume IsGoodExhaleState(exhaleHeap#_350_$_0,Heap_$_5,exhaleMask#_351_$_9,ZeroMask);
	assume IsGoodMask(exhaleMask#_351_$_9);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_351_$_9,ZeroMask);
	assume true;
	assume !(this == null);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_351_$_9,ZeroMask);
	assume (exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_350_$_0[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume methodCallK#_349 > 0;
	assume Mask_$_77 == exhaleMask#_351_$_9[this,AVLTreeNode.left := exhaleMask#_351_$_9[this,AVLTreeNode.left][perm$R := exhaleMask#_351_$_9[this,AVLTreeNode.left][perm$R] + methodCallK#_349]];
	assume IsGoodMask(Mask_$_77);
	assume IsGoodState(heapFragment(exhaleHeap#_350_$_0[this,AVLTreeNode.left]));
	assume wf(exhaleHeap#_350_$_0,Mask_$_77,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_77,ZeroMask);
	if ($_$_condition_$74) { goto anon333_Then; } else { goto anon333_Else; }
anon369_Then:
	assume !CanRead(exhaleMask#_443_$_8,ZeroMask,Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_442_$_0[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon205;
anon369_Else:
	assume CanRead(exhaleMask#_443_$_8,ZeroMask,Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon205;
anon206:
	assume IsGoodExhaleState(exhaleHeap#_442_$_0,Heap_$_3,exhaleMask#_443_$_9,ZeroMask);
	assume IsGoodMask(exhaleMask#_443_$_9);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_443_$_9,ZeroMask);
	assume true;
	assume !(this == null);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_443_$_9,ZeroMask);
	assume (exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_442_$_0[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume methodCallK#_441 > 0;
	assume Mask_$_43 == exhaleMask#_443_$_9[this,AVLTreeNode.left := exhaleMask#_443_$_9[this,AVLTreeNode.left][perm$R := exhaleMask#_443_$_9[this,AVLTreeNode.left][perm$R] + methodCallK#_441]];
	assume IsGoodMask(Mask_$_43);
	assume IsGoodState(heapFragment(exhaleHeap#_442_$_0[this,AVLTreeNode.left]));
	assume wf(exhaleHeap#_442_$_0,Mask_$_43,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_43,ZeroMask);
	if ($_$_condition_$75) { goto anon370_Then; } else { goto anon370_Else; }
anon129:
	assume IsGoodMask(exhaleMask#_351_$_8);
	assume wf(Heap_$_5,exhaleMask#_351_$_8,ZeroMask);
	assume wf(Heap_$_5,Mask_$_76,ZeroMask);
	assume exhaleMask#_351_$_9 == exhaleMask#_351_$_8;
	goto anon130;
anon205:
	assume IsGoodMask(exhaleMask#_443_$_8);
	assume wf(Heap_$_3,exhaleMask#_443_$_8,ZeroMask);
	assume wf(Heap_$_3,Mask_$_42,ZeroMask);
	assume exhaleMask#_443_$_9 == exhaleMask#_443_$_8;
	goto anon206;
anon333_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_350_$_0,Mask_$_77,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_78 == Mask_$_77[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_77[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_77[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_78);
	assume IsGoodState(heapFragment(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_350_$_0,Mask_$_78,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_78,ZeroMask);
	assume Mask_$_79 == Mask_$_78;
	if ($_$_condition_$76) { goto anon334_Then; } else { goto anon334_Else; }
anon333_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_79 == Mask_$_77;
	if ($_$_condition_$77) { goto anon334_Then; } else { goto anon334_Else; }
anon370_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_442_$_0,Mask_$_43,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_44 == Mask_$_43[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_43[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_43[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_44);
	assume IsGoodState(heapFragment(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_442_$_0,Mask_$_44,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_44,ZeroMask);
	assume Mask_$_45 == Mask_$_44;
	if ($_$_condition_$78) { goto anon371_Then; } else { goto anon371_Else; }
anon370_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_45 == Mask_$_43;
	if ($_$_condition_$79) { goto anon371_Then; } else { goto anon371_Else; }
anon334_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_350_$_0,Mask_$_79,ZeroMask);
	assume true;
	assume methodCallK#_349 > 0;
	assume Mask_$_80 == Mask_$_79[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_79[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_79[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + methodCallK#_349]];
	assume IsGoodMask(Mask_$_80);
	assume IsGoodState(heapFragment(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_350_$_0,Mask_$_80,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_80,ZeroMask);
	assume Mask_$_81 == Mask_$_80;
	goto anon134;
anon334_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_81 == Mask_$_79;
	goto anon134;
anon371_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_442_$_0,Mask_$_45,ZeroMask);
	assume true;
	assume methodCallK#_441 > 0;
	assume Mask_$_46 == Mask_$_45[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_45[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_45[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + methodCallK#_441]];
	assume IsGoodMask(Mask_$_46);
	assume IsGoodState(heapFragment(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_442_$_0,Mask_$_46,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_46,ZeroMask);
	assume Mask_$_47 == Mask_$_46;
	goto anon210;
anon371_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_47 == Mask_$_45;
	goto anon210;
anon134:
	assume !(this == null);
	assume wf(exhaleHeap#_350_$_0,Mask_$_81,ZeroMask);
	assume (exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_350_$_0[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume methodCallK#_349 > 0;
	assume Mask_$_82 == Mask_$_81[this,AVLTreeNode.right := Mask_$_81[this,AVLTreeNode.right][perm$R := Mask_$_81[this,AVLTreeNode.right][perm$R] + methodCallK#_349]];
	assume IsGoodMask(Mask_$_82);
	assume IsGoodState(heapFragment(exhaleHeap#_350_$_0[this,AVLTreeNode.right]));
	assume wf(exhaleHeap#_350_$_0,Mask_$_82,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_82,ZeroMask);
	if ($_$_condition_$80) { goto anon335_Then; } else { goto anon335_Else; }
anon210:
	assume !(this == null);
	assume wf(exhaleHeap#_442_$_0,Mask_$_47,ZeroMask);
	assume (exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_442_$_0[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume methodCallK#_441 > 0;
	assume Mask_$_48 == Mask_$_47[this,AVLTreeNode.right := Mask_$_47[this,AVLTreeNode.right][perm$R := Mask_$_47[this,AVLTreeNode.right][perm$R] + methodCallK#_441]];
	assume IsGoodMask(Mask_$_48);
	assume IsGoodState(heapFragment(exhaleHeap#_442_$_0[this,AVLTreeNode.right]));
	assume wf(exhaleHeap#_442_$_0,Mask_$_48,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_48,ZeroMask);
	if ($_$_condition_$81) { goto anon372_Then; } else { goto anon372_Else; }
anon335_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_350_$_0,Mask_$_82,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_83 == Mask_$_82[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_82[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_82[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_83);
	assume IsGoodState(heapFragment(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_350_$_0,Mask_$_83,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_83,ZeroMask);
	assume Mask_$_84 == Mask_$_83;
	if ($_$_condition_$82) { goto anon336_Then; } else { goto anon336_Else; }
anon335_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_84 == Mask_$_82;
	if ($_$_condition_$83) { goto anon336_Then; } else { goto anon336_Else; }
anon372_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_442_$_0,Mask_$_48,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_49 == Mask_$_48[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_48[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_48[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_49);
	assume IsGoodState(heapFragment(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_442_$_0,Mask_$_49,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_49,ZeroMask);
	assume Mask_$_50 == Mask_$_49;
	if ($_$_condition_$84) { goto anon373_Then; } else { goto anon373_Else; }
anon372_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_50 == Mask_$_48;
	if ($_$_condition_$85) { goto anon373_Then; } else { goto anon373_Else; }
anon336_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_350_$_0,Mask_$_84,ZeroMask);
	assume true;
	assume methodCallK#_349 > 0;
	assume Mask_$_85 == Mask_$_84[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_84[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_84[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + methodCallK#_349]];
	assume IsGoodMask(Mask_$_85);
	assume IsGoodState(heapFragment(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_350_$_0,Mask_$_85,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_85,ZeroMask);
	assume Mask_$_86 == Mask_$_85;
	goto anon138;
anon336_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_86 == Mask_$_84;
	goto anon138;
anon373_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_442_$_0,Mask_$_50,ZeroMask);
	assume true;
	assume methodCallK#_441 > 0;
	assume Mask_$_51 == Mask_$_50[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_50[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_50[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + methodCallK#_441]];
	assume IsGoodMask(Mask_$_51);
	assume IsGoodState(heapFragment(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_442_$_0,Mask_$_51,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_51,ZeroMask);
	assume Mask_$_52 == Mask_$_51;
	goto anon214;
anon373_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_52 == Mask_$_50;
	goto anon214;
anon138:
	assume bf#178_$_0 == (ite(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	if ($_$_condition_$86) { goto anon337_Then; } else { goto anon337_Else; }
anon214:
	assume bf#198_$_0 == (ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	if ($_$_condition_$87) { goto anon374_Then; } else { goto anon374_Else; }
anon337_Then:
	assume bf#178_$_0 > 0;
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	if ($_$_condition_$88) { goto anon338_Then; } else { goto anon338_Else; }
anon337_Else:
	assume 0 >= bf#178_$_0;
	if ($_$_condition_$89) { goto anon338_Then; } else { goto anon338_Else; }
anon374_Then:
	assume bf#198_$_0 > 0;
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	if ($_$_condition_$90) { goto anon375_Then; } else { goto anon375_Else; }
anon374_Else:
	assume 0 >= bf#198_$_0;
	if ($_$_condition_$91) { goto anon375_Then; } else { goto anon375_Else; }
anon338_Then:
	assume bf#178_$_0 < 0;
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	goto anon142;
anon338_Else:
	assume 0 <= bf#178_$_0;
	goto anon142;
anon375_Then:
	assume bf#198_$_0 < 0;
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	goto anon218;
anon375_Else:
	assume 0 <= bf#198_$_0;
	goto anon218;
anon142:
	assume IsGoodMask(Mask_$_86);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume cond#_360_$_0 <==> (bf#178_$_0 == 2);
	if ($_$_condition_$92) { goto anon339_Then; } else { goto anon339_Else; }
anon218:
	assume IsGoodMask(Mask_$_52);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume cond#_452_$_0 <==> (bf#198_$_0 == (0 - 2));
	if ($_$_condition_$93) { goto anon376_Then; } else { goto anon376_Else; }
anon339_Then:
	assume cond#_360_$_0;
	assume ((0 < methodCallK#_365) && ((1000 * methodCallK#_365) < Fractions(1))) && ((1000 * methodCallK#_365) < methodK#_261);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The target of the method call might be null." } !(this == null);
	assert { :msg "  224.6: The precondition at 608.12 might not hold. The expression at 608.12 might not evaluate to true." } !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  224.6: The precondition at 613.12 might not hold. The expression at 613.12 might not evaluate to true." } (forall  k#94#181 : Integer :: ( ((0 <= k#94#181) && (k#94#181 < Seq#Length(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#94#181) < exhaleHeap#_350_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$94) { goto anon340_Then; } else { goto anon340_Else; }
anon339_Else:
	assume !cond#_360_$_0;
	assume ((0 < methodCallK#_388) && ((1000 * methodCallK#_388) < Fractions(1))) && ((1000 * methodCallK#_388) < methodK#_261);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  227.6: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$95) { goto anon347_Then; } else { goto anon347_Else; }
anon376_Then:
	assume cond#_452_$_0;
	assume ((0 < methodCallK#_457) && ((1000 * methodCallK#_457) < Fractions(1))) && ((1000 * methodCallK#_457) < methodK#_261);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$96) { goto anon377_Then; } else { goto anon377_Else; }
anon376_Else:
	assume !cond#_452_$_0;
	assume ((0 < methodCallK#_480) && ((1000 * methodCallK#_480) < Fractions(1))) && ((1000 * methodCallK#_480) < methodK#_261);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  245.6: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$97) { goto anon384_Then; } else { goto anon384_Else; }
anon340_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  224.6: The precondition at 619.12 might not hold. The expression at 619.28 might not evaluate to true." } (forall  k#95#182 : Integer :: ( ((0 <= k#95#182) && (k#95#182 < Seq#Length(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_350_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#95#182)) ));
	goto anon145;
anon340_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	goto anon145;
anon347_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  227.6: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#186 : Integer :: ( ((0 <= k#92#186) && (k#92#186 < Seq#Length(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#186) < exhaleHeap#_350_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$98) { goto anon348_Then; } else { goto anon348_Else; }
anon347_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null;
	if ($_$_condition_$99) { goto anon348_Then; } else { goto anon348_Else; }
anon377_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  242.6: The precondition at 758.12 might not hold. The expression at 758.25 might not evaluate to true." } (forall  k#104#201 : Integer :: ( ((0 <= k#104#201) && (k#104#201 < Seq#Length(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#104#201) < exhaleHeap#_442_$_0[this,AVLTreeNode.key]) ));
	goto anon221;
anon377_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	goto anon221;
anon384_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  245.6: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#206 : Integer :: ( ((0 <= k#92#206) && (k#92#206 < Seq#Length(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#206) < exhaleHeap#_442_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$100) { goto anon385_Then; } else { goto anon385_Else; }
anon384_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	if ($_$_condition_$101) { goto anon385_Then; } else { goto anon385_Else; }
anon145:
	assert { :msg "  224.6: The precondition at 621.12 might not hold. The expression at 621.12 might not evaluate to true." } (exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height] - ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) == 2;
	assert { :msg "  224.6: The precondition at 600.12 might not hold. The permission at 600.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 600.12 might not hold. Insufficient fraction at 600.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_86[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_86[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_86[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_367_$_0 == Mask_$_86[this,AVLTreeNode.key := Mask_$_86[this,AVLTreeNode.key][perm$R := Mask_$_86[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_367_$_0);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_0,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 601.12 might not hold. The permission at 601.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 601.12 might not hold. Insufficient fraction at 601.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_367_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_367_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_367_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_367_$_1 == exhaleMask#_367_$_0[this,AVLTreeNode.height := exhaleMask#_367_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_367_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_367_$_1);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_1,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 602.12 might not hold. The permission at 602.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 602.12 might not hold. Insufficient fraction at 602.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_367_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_367_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_367_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_367_$_2 == exhaleMask#_367_$_1[this,AVLTreeNode.left := exhaleMask#_367_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_367_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_367_$_2);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_2,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 603.12 might not hold. The permission at 603.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 603.12 might not hold. Insufficient fraction at 603.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_367_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_367_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_367_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_367_$_3 == exhaleMask#_367_$_2[this,AVLTreeNode.right := exhaleMask#_367_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_367_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_367_$_3);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_3,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 605.12 might not hold. The permission at 605.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 605.12 might not hold. Insufficient fraction at 605.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_367_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_367_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_367_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_367_$_4 == exhaleMask#_367_$_3[this,AVLTreeNode.keys := exhaleMask#_367_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_367_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_367_$_4);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_4,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 606.12 might not hold. The permission at 606.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 606.12 might not hold. Insufficient fraction at 606.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_367_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_367_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_367_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_367_$_5 == exhaleMask#_367_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_367_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_367_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_367_$_5);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_5,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 609.12 might not hold. The permission at 609.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 609.12 might not hold. Insufficient fraction at 609.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_367_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_367_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_367_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_367_$_6 == exhaleMask#_367_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_367_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_367_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$102) { goto anon341_Then; } else { goto anon341_Else; }
anon348_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  227.6: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#187 : Integer :: ( ((0 <= k#93#187) && (k#93#187 < Seq#Length(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_350_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#187)) ));
	goto anon162;
anon348_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	goto anon162;
anon221:
	assert { :msg "  242.6: The precondition at 760.12 might not hold. The expression at 760.12 might not evaluate to true." } !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  242.6: The precondition at 765.12 might not hold. The expression at 765.12 might not evaluate to true." } (forall  k#105#202 : Integer :: ( ((0 <= k#105#202) && (k#105#202 < Seq#Length(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_442_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#105#202)) ));
	assert { :msg "  242.6: The precondition at 768.12 might not hold. The expression at 768.12 might not evaluate to true." } (ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) == (0 - 2);
	assert { :msg "  242.6: The precondition at 746.12 might not hold. The permission at 746.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 746.12 might not hold. Insufficient fraction at 746.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_52[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_52[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_52[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_459_$_0 == Mask_$_52[this,AVLTreeNode.key := Mask_$_52[this,AVLTreeNode.key][perm$R := Mask_$_52[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_459_$_0);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_0,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 747.12 might not hold. The permission at 747.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 747.12 might not hold. Insufficient fraction at 747.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_459_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_459_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_459_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_459_$_1 == exhaleMask#_459_$_0[this,AVLTreeNode.height := exhaleMask#_459_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_459_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_459_$_1);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_1,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 748.12 might not hold. The permission at 748.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 748.12 might not hold. Insufficient fraction at 748.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_459_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_459_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_459_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_459_$_2 == exhaleMask#_459_$_1[this,AVLTreeNode.left := exhaleMask#_459_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_459_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_459_$_2);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_2,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 749.12 might not hold. The permission at 749.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 749.12 might not hold. Insufficient fraction at 749.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_459_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_459_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_459_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_459_$_3 == exhaleMask#_459_$_2[this,AVLTreeNode.right := exhaleMask#_459_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_459_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_459_$_3);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_3,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 751.12 might not hold. The permission at 751.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 751.12 might not hold. Insufficient fraction at 751.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_459_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_459_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_459_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_459_$_4 == exhaleMask#_459_$_3[this,AVLTreeNode.keys := exhaleMask#_459_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_459_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_459_$_4);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_4,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 752.12 might not hold. The permission at 752.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 752.12 might not hold. Insufficient fraction at 752.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_459_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_459_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_459_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_459_$_5 == exhaleMask#_459_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_459_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_459_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_459_$_5);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_5,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	if ($_$_condition_$103) { goto anon378_Then; } else { goto anon378_Else; }
anon385_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  245.6: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#207 : Integer :: ( ((0 <= k#93#207) && (k#93#207 < Seq#Length(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_442_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#207)) ));
	goto anon238;
anon385_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null;
	goto anon238;
anon341_Then:
	assume !CanRead(exhaleMask#_367_$_6,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_366_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon147;
anon341_Else:
	assume CanRead(exhaleMask#_367_$_6,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon147;
anon162:
	assert { :msg "  227.6: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  227.6: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  227.6: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_86[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_86[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_86[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_390_$_0 == Mask_$_86[this,AVLTreeNode.key := Mask_$_86[this,AVLTreeNode.key][perm$R := Mask_$_86[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_390_$_0);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_0,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  227.6: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_390_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_390_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_390_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_390_$_1 == exhaleMask#_390_$_0[this,AVLTreeNode.height := exhaleMask#_390_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_390_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_390_$_1);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_1,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  227.6: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_390_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_390_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_390_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_390_$_2 == exhaleMask#_390_$_1[this,AVLTreeNode.left := exhaleMask#_390_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_390_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_390_$_2);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_2,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  227.6: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_390_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_390_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_390_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_390_$_3 == exhaleMask#_390_$_2[this,AVLTreeNode.right := exhaleMask#_390_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_390_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_390_$_3);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_3,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  227.6: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_390_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_390_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_390_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_390_$_4 == exhaleMask#_390_$_3[this,AVLTreeNode.keys := exhaleMask#_390_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_390_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_390_$_4);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_4,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  227.6: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_390_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_390_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_390_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_390_$_5 == exhaleMask#_390_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_390_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_390_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_390_$_5);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_5,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	if ($_$_condition_$104) { goto anon349_Then; } else { goto anon349_Else; }
anon378_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  242.6: The precondition at 754.12 might not hold. The permission at 754.25 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 754.12 might not hold. Insufficient fraction at 754.25 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_459_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_459_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_459_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_459_$_6 == exhaleMask#_459_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_459_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_459_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$105) { goto anon379_Then; } else { goto anon379_Else; }
anon378_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_459_$_7 == exhaleMask#_459_$_5;
	if ($_$_condition_$106) { goto anon380_Then; } else { goto anon380_Else; }
anon238:
	assert { :msg "  245.6: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  245.6: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  245.6: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_52[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_52[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_52[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_482_$_0 == Mask_$_52[this,AVLTreeNode.key := Mask_$_52[this,AVLTreeNode.key][perm$R := Mask_$_52[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_482_$_0);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_0,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  245.6: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_482_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_482_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_482_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_482_$_1 == exhaleMask#_482_$_0[this,AVLTreeNode.height := exhaleMask#_482_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_482_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_482_$_1);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_1,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  245.6: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_482_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_482_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_482_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_482_$_2 == exhaleMask#_482_$_1[this,AVLTreeNode.left := exhaleMask#_482_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_482_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_482_$_2);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_2,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  245.6: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_482_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_482_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_482_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_482_$_3 == exhaleMask#_482_$_2[this,AVLTreeNode.right := exhaleMask#_482_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_482_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_482_$_3);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_3,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  245.6: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_482_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_482_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_482_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_482_$_4 == exhaleMask#_482_$_3[this,AVLTreeNode.keys := exhaleMask#_482_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_482_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_482_$_4);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_4,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  245.6: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_482_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_482_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_482_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_482_$_5 == exhaleMask#_482_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_482_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_482_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_482_$_5);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_5,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	if ($_$_condition_$107) { goto anon386_Then; } else { goto anon386_Else; }
anon147:
	assume IsGoodMask(exhaleMask#_367_$_6);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_6,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 610.12 might not hold. The permission at 610.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  224.6: The precondition at 610.12 might not hold. Insufficient fraction at 610.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_367_$_6[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_367_$_6[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_367_$_6[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_367_$_7 == exhaleMask#_367_$_6[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_367_$_6[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_367_$_6[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_367_$_7);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_7,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 611.12 might not hold. The permission at 611.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  224.6: The precondition at 611.12 might not hold. Insufficient fraction at 611.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_367_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_367_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_367_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_367_$_8 == exhaleMask#_367_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_367_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_367_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_367_$_8);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_8,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assert { :msg "  224.6: The precondition at 612.12 might not hold. The permission at 612.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  224.6: The precondition at 612.12 might not hold. Insufficient fraction at 612.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_367_$_8[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_367_$_8[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_367_$_8[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_367_$_9 == exhaleMask#_367_$_8[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_367_$_8[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_367_$_8[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_367_$_9);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_9,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	if ($_$_condition_$108) { goto anon342_Then; } else { goto anon342_Else; }
anon349_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  227.6: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_390_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_390_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_390_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_390_$_6 == exhaleMask#_390_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_390_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_390_$_5[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$109) { goto anon350_Then; } else { goto anon350_Else; }
anon349_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_390_$_7 == exhaleMask#_390_$_5;
	if ($_$_condition_$110) { goto anon351_Then; } else { goto anon351_Else; }
anon379_Then:
	assume !CanRead(exhaleMask#_459_$_6,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_458_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon224;
anon379_Else:
	assume CanRead(exhaleMask#_459_$_6,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon224;
anon380_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  242.6: The precondition at 755.12 might not hold. The permission at 755.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  242.6: The precondition at 755.12 might not hold. Insufficient fraction at 755.25 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_459_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_459_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_459_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_459_$_8 == exhaleMask#_459_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_459_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_459_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_459_$_8);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_8,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_459_$_9 == exhaleMask#_459_$_8;
	if ($_$_condition_$117) { goto anon381_Then; } else { goto anon381_Else; }
anon380_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_459_$_9 == exhaleMask#_459_$_7;
	if ($_$_condition_$118) { goto anon381_Then; } else { goto anon381_Else; }
anon386_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  245.6: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_482_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_482_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_482_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_482_$_6 == exhaleMask#_482_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_482_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_482_$_5[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$111) { goto anon387_Then; } else { goto anon387_Else; }
anon386_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_482_$_7 == exhaleMask#_482_$_5;
	if ($_$_condition_$112) { goto anon388_Then; } else { goto anon388_Else; }
anon342_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  224.6: The precondition at 615.12 might not hold. The permission at 615.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  224.6: The precondition at 615.12 might not hold. Insufficient fraction at 615.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_367_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_367_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_367_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_367_$_10 == exhaleMask#_367_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_367_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_367_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$113) { goto anon343_Then; } else { goto anon343_Else; }
anon342_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_367_$_11 == exhaleMask#_367_$_9;
	if ($_$_condition_$114) { goto anon344_Then; } else { goto anon344_Else; }
anon350_Then:
	assume !CanRead(exhaleMask#_390_$_6,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_389_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon165;
anon350_Else:
	assume CanRead(exhaleMask#_390_$_6,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon165;
anon351_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  227.6: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  227.6: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_390_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_390_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_390_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_390_$_8 == exhaleMask#_390_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_390_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_390_$_7[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_390_$_8);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_8,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_9 == exhaleMask#_390_$_8;
	if ($_$_condition_$121) { goto anon352_Then; } else { goto anon352_Else; }
anon351_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_390_$_9 == exhaleMask#_390_$_7;
	if ($_$_condition_$122) { goto anon352_Then; } else { goto anon352_Else; }
anon224:
	assume IsGoodMask(exhaleMask#_459_$_6);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_6,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_459_$_7 == exhaleMask#_459_$_6;
	if ($_$_condition_$115) { goto anon380_Then; } else { goto anon380_Else; }
anon387_Then:
	assume !CanRead(exhaleMask#_482_$_6,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_481_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon241;
anon387_Else:
	assume CanRead(exhaleMask#_482_$_6,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon241;
anon388_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  245.6: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  245.6: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_482_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_482_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_482_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_482_$_8 == exhaleMask#_482_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_482_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_482_$_7[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_482_$_8);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_8,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_9 == exhaleMask#_482_$_8;
	if ($_$_condition_$125) { goto anon389_Then; } else { goto anon389_Else; }
anon388_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_482_$_9 == exhaleMask#_482_$_7;
	if ($_$_condition_$126) { goto anon389_Then; } else { goto anon389_Else; }
anon343_Then:
	assume !CanRead(exhaleMask#_367_$_10,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_366_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon150;
anon343_Else:
	assume CanRead(exhaleMask#_367_$_10,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon150;
anon344_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  224.6: The precondition at 616.12 might not hold. The permission at 616.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  224.6: The precondition at 616.12 might not hold. Insufficient fraction at 616.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_367_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_367_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_367_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_367_$_12 == exhaleMask#_367_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_367_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_367_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_367_$_12);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_12,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_367_$_13 == exhaleMask#_367_$_12;
	if ($_$_condition_$127) { goto anon345_Then; } else { goto anon345_Else; }
anon344_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_367_$_13 == exhaleMask#_367_$_11;
	if ($_$_condition_$128) { goto anon345_Then; } else { goto anon345_Else; }
anon165:
	assume IsGoodMask(exhaleMask#_390_$_6);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_6,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_7 == exhaleMask#_390_$_6;
	if ($_$_condition_$116) { goto anon351_Then; } else { goto anon351_Else; }
anon241:
	assume IsGoodMask(exhaleMask#_482_$_6);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_6,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_7 == exhaleMask#_482_$_6;
	if ($_$_condition_$119) { goto anon388_Then; } else { goto anon388_Else; }
anon150:
	assume IsGoodMask(exhaleMask#_367_$_10);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_10,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_367_$_11 == exhaleMask#_367_$_10;
	if ($_$_condition_$120) { goto anon344_Then; } else { goto anon344_Else; }
anon381_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  242.6: The precondition at 756.12 might not hold. The permission at 756.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  242.6: The precondition at 756.12 might not hold. Insufficient fraction at 756.25 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_459_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_459_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_459_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_459_$_10 == exhaleMask#_459_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_459_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_459_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_459_$_10);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_10,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_459_$_11 == exhaleMask#_459_$_10;
	if ($_$_condition_$123) { goto anon382_Then; } else { goto anon382_Else; }
anon381_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_459_$_11 == exhaleMask#_459_$_9;
	if ($_$_condition_$124) { goto anon382_Then; } else { goto anon382_Else; }
anon352_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  227.6: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  227.6: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_390_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_390_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_390_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_390_$_10 == exhaleMask#_390_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_390_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_390_$_9[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_390_$_10);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_10,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_11 == exhaleMask#_390_$_10;
	if ($_$_condition_$129) { goto anon353_Then; } else { goto anon353_Else; }
anon352_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_390_$_11 == exhaleMask#_390_$_9;
	if ($_$_condition_$130) { goto anon353_Then; } else { goto anon353_Else; }
anon382_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  242.6: The precondition at 757.12 might not hold. The permission at 757.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  242.6: The precondition at 757.12 might not hold. Insufficient fraction at 757.25 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_459_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_459_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_459_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_459_$_12 == exhaleMask#_459_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_459_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_459_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_459_$_12);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_12,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_459_$_13 == exhaleMask#_459_$_12;
	goto anon231;
anon382_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_459_$_13 == exhaleMask#_459_$_11;
	goto anon231;
anon389_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  245.6: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  245.6: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_482_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_482_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_482_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_482_$_10 == exhaleMask#_482_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_482_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_482_$_9[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_482_$_10);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_10,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_11 == exhaleMask#_482_$_10;
	if ($_$_condition_$131) { goto anon390_Then; } else { goto anon390_Else; }
anon389_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_482_$_11 == exhaleMask#_482_$_9;
	if ($_$_condition_$132) { goto anon390_Then; } else { goto anon390_Else; }
anon345_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  224.6: The precondition at 617.12 might not hold. The permission at 617.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  224.6: The precondition at 617.12 might not hold. Insufficient fraction at 617.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_367_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_367_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_367_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_367_$_14 == exhaleMask#_367_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_367_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_367_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_367_$_14);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_14,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_367_$_15 == exhaleMask#_367_$_14;
	if ($_$_condition_$133) { goto anon346_Then; } else { goto anon346_Else; }
anon345_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_367_$_15 == exhaleMask#_367_$_13;
	if ($_$_condition_$134) { goto anon346_Then; } else { goto anon346_Else; }
anon353_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  227.6: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  227.6: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_390_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_390_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_390_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_390_$_12 == exhaleMask#_390_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_390_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_390_$_11[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_390_$_12);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_12,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_13 == exhaleMask#_390_$_12;
	if ($_$_condition_$135) { goto anon354_Then; } else { goto anon354_Else; }
anon353_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_390_$_13 == exhaleMask#_390_$_11;
	if ($_$_condition_$136) { goto anon354_Then; } else { goto anon354_Else; }
anon231:
	assert { :msg "  242.6: The precondition at 761.12 might not hold. The permission at 761.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  242.6: The precondition at 761.12 might not hold. Insufficient fraction at 761.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_459_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_459_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_459_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_459_$_14 == exhaleMask#_459_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_459_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_459_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$137) { goto anon383_Then; } else { goto anon383_Else; }
anon390_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  245.6: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  245.6: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_482_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_482_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_482_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_482_$_12 == exhaleMask#_482_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_482_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_482_$_11[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_482_$_12);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_12,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_13 == exhaleMask#_482_$_12;
	if ($_$_condition_$138) { goto anon391_Then; } else { goto anon391_Else; }
anon390_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_482_$_13 == exhaleMask#_482_$_11;
	if ($_$_condition_$139) { goto anon391_Then; } else { goto anon391_Else; }
anon346_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  224.6: The precondition at 618.12 might not hold. The permission at 618.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  224.6: The precondition at 618.12 might not hold. Insufficient fraction at 618.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_367_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_367_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_367_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_367_$_16 == exhaleMask#_367_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_367_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_367_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_367_$_16);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_367_$_16,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_367_$_17 == exhaleMask#_367_$_16;
	goto anon157;
anon346_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_367_$_17 == exhaleMask#_367_$_15;
	goto anon157;
anon354_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  227.6: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  227.6: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_390_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_390_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_390_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_390_$_14 == exhaleMask#_390_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_390_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_390_$_13[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$140) { goto anon355_Then; } else { goto anon355_Else; }
anon354_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_390_$_15 == exhaleMask#_390_$_13;
	if ($_$_condition_$141) { goto anon356_Then; } else { goto anon356_Else; }
anon383_Then:
	assume !CanRead(exhaleMask#_459_$_14,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_458_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon233;
anon383_Else:
	assume CanRead(exhaleMask#_459_$_14,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon233;
anon391_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  245.6: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  245.6: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_482_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_482_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_482_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_482_$_14 == exhaleMask#_482_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_482_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_482_$_13[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$142) { goto anon392_Then; } else { goto anon392_Else; }
anon391_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_482_$_15 == exhaleMask#_482_$_13;
	if ($_$_condition_$143) { goto anon393_Then; } else { goto anon393_Else; }
anon157:
	assume IsGoodExhaleState(exhaleHeap#_366_$_0,exhaleHeap#_350_$_0,exhaleMask#_367_$_17,ZeroMask);
	assume IsGoodMask(exhaleMask#_367_$_17);
	assume wf(exhaleHeap#_366_$_0,exhaleMask#_367_$_17,ZeroMask);
	assume (r#180_$_0 == null) || (dtype(r#180_$_0) == AVLTreeNode#t);
	assume !(r#180_$_0 == null);
	assume !(r#180_$_0 == null);
	assume wf(exhaleHeap#_366_$_0,exhaleMask#_367_$_17,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_91 == exhaleMask#_367_$_17[r#180_$_0,AVLTreeNode.valid := exhaleMask#_367_$_17[r#180_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_367_$_17[r#180_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_91);
	assume IsGoodState(heapFragment(exhaleHeap#_366_$_0[r#180_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_366_$_0,Mask_$_91,ZeroMask);
	assume wf(exhaleHeap#_366_$_0,Mask_$_91,ZeroMask);
	assume !(r#180_$_0 == null);
	assume wf(exhaleHeap#_366_$_0,Mask_$_91,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_92 == Mask_$_91[r#180_$_0,AVLTreeNode.height := Mask_$_91[r#180_$_0,AVLTreeNode.height][perm$R := Mask_$_91[r#180_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_92);
	assume IsGoodState(heapFragment(exhaleHeap#_366_$_0[r#180_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_366_$_0,Mask_$_92,ZeroMask);
	assume wf(exhaleHeap#_366_$_0,Mask_$_92,ZeroMask);
	assume !(r#180_$_0 == null);
	assume wf(exhaleHeap#_366_$_0,Mask_$_92,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_93 == Mask_$_92[r#180_$_0,AVLTreeNode.keys := Mask_$_92[r#180_$_0,AVLTreeNode.keys][perm$R := Mask_$_92[r#180_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_93);
	assume IsGoodState(heapFragment(exhaleHeap#_366_$_0[r#180_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_366_$_0,Mask_$_93,ZeroMask);
	assume wf(exhaleHeap#_366_$_0,Mask_$_93,ZeroMask);
	assume !(r#180_$_0 == null);
	assume wf(exhaleHeap#_366_$_0,Mask_$_93,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_94 == Mask_$_93[r#180_$_0,AVLTreeNode.balanceFactor := Mask_$_93[r#180_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_93[r#180_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_94);
	assume IsGoodState(heapFragment(exhaleHeap#_366_$_0[r#180_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_366_$_0,Mask_$_94,ZeroMask);
	assume wf(exhaleHeap#_366_$_0,Mask_$_94,ZeroMask);
	assume (exhaleHeap#_366_$_0[r#180_$_0,AVLTreeNode.height] == exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) || (exhaleHeap#_366_$_0[r#180_$_0,AVLTreeNode.height] == (exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height] + 1));
	assume Seq#Equal(exhaleHeap#_366_$_0[r#180_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Singleton(exhaleHeap#_350_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume IsGoodMask(Mask_$_94);
	assume wf(exhaleHeap#_366_$_0,Mask_$_94,ZeroMask);
	assume Heap_$_6 == exhaleHeap#_366_$_0;
	assume Mask_$_99 == Mask_$_94;
	assume r#10_$_0 == r#180_$_0;
	goto anon259;
anon355_Then:
	assume !CanRead(exhaleMask#_390_$_14,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_389_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon175;
anon355_Else:
	assume CanRead(exhaleMask#_390_$_14,ZeroMask,exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon175;
anon356_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  227.6: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  227.6: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_390_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_390_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_390_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_390_$_16 == exhaleMask#_390_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_390_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_390_$_15[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_390_$_16);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_16,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_17 == exhaleMask#_390_$_16;
	if ($_$_condition_$146) { goto anon357_Then; } else { goto anon357_Else; }
anon356_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_390_$_17 == exhaleMask#_390_$_15;
	if ($_$_condition_$147) { goto anon357_Then; } else { goto anon357_Else; }
anon233:
	assume IsGoodMask(exhaleMask#_459_$_14);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_14,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 762.12 might not hold. The permission at 762.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  242.6: The precondition at 762.12 might not hold. Insufficient fraction at 762.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_459_$_14[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_459_$_14[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_459_$_14[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_459_$_15 == exhaleMask#_459_$_14[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_459_$_14[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_459_$_14[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_459_$_15);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_15,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 763.12 might not hold. The permission at 763.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  242.6: The precondition at 763.12 might not hold. Insufficient fraction at 763.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_459_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_459_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_459_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_459_$_16 == exhaleMask#_459_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_459_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_459_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_459_$_16);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_16,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assert { :msg "  242.6: The precondition at 764.12 might not hold. The permission at 764.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  242.6: The precondition at 764.12 might not hold. Insufficient fraction at 764.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_459_$_16[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_459_$_16[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_459_$_16[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_459_$_17 == exhaleMask#_459_$_16[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_459_$_16[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_459_$_16[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_459_$_17);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_459_$_17,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_458_$_0,exhaleHeap#_442_$_0,exhaleMask#_459_$_17,ZeroMask);
	assume IsGoodMask(exhaleMask#_459_$_17);
	assume wf(exhaleHeap#_458_$_0,exhaleMask#_459_$_17,ZeroMask);
	assume (r#200_$_0 == null) || (dtype(r#200_$_0) == AVLTreeNode#t);
	assume !(r#200_$_0 == null);
	assume !(r#200_$_0 == null);
	assume wf(exhaleHeap#_458_$_0,exhaleMask#_459_$_17,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_57 == exhaleMask#_459_$_17[r#200_$_0,AVLTreeNode.valid := exhaleMask#_459_$_17[r#200_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_459_$_17[r#200_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_57);
	assume IsGoodState(heapFragment(exhaleHeap#_458_$_0[r#200_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_458_$_0,Mask_$_57,ZeroMask);
	assume wf(exhaleHeap#_458_$_0,Mask_$_57,ZeroMask);
	assume !(r#200_$_0 == null);
	assume wf(exhaleHeap#_458_$_0,Mask_$_57,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_58 == Mask_$_57[r#200_$_0,AVLTreeNode.height := Mask_$_57[r#200_$_0,AVLTreeNode.height][perm$R := Mask_$_57[r#200_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_58);
	assume IsGoodState(heapFragment(exhaleHeap#_458_$_0[r#200_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_458_$_0,Mask_$_58,ZeroMask);
	assume wf(exhaleHeap#_458_$_0,Mask_$_58,ZeroMask);
	assume !(r#200_$_0 == null);
	assume wf(exhaleHeap#_458_$_0,Mask_$_58,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_59 == Mask_$_58[r#200_$_0,AVLTreeNode.keys := Mask_$_58[r#200_$_0,AVLTreeNode.keys][perm$R := Mask_$_58[r#200_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_59);
	assume IsGoodState(heapFragment(exhaleHeap#_458_$_0[r#200_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_458_$_0,Mask_$_59,ZeroMask);
	assume wf(exhaleHeap#_458_$_0,Mask_$_59,ZeroMask);
	assume !(r#200_$_0 == null);
	assume wf(exhaleHeap#_458_$_0,Mask_$_59,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_60 == Mask_$_59[r#200_$_0,AVLTreeNode.balanceFactor := Mask_$_59[r#200_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_59[r#200_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_60);
	assume IsGoodState(heapFragment(exhaleHeap#_458_$_0[r#200_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_458_$_0,Mask_$_60,ZeroMask);
	assume wf(exhaleHeap#_458_$_0,Mask_$_60,ZeroMask);
	assume (exhaleHeap#_458_$_0[r#200_$_0,AVLTreeNode.height] == exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) || (exhaleHeap#_458_$_0[r#200_$_0,AVLTreeNode.height] == (exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height] + 1));
	assume Seq#Equal(exhaleHeap#_458_$_0[r#200_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_442_$_0[this,AVLTreeNode.key])),exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume IsGoodMask(Mask_$_60);
	assume wf(exhaleHeap#_458_$_0,Mask_$_60,ZeroMask);
	assume Heap_$_6 == exhaleHeap#_458_$_0;
	assume Mask_$_99 == Mask_$_60;
	assume r#10_$_0 == r#200_$_0;
	goto anon259;
anon392_Then:
	assume !CanRead(exhaleMask#_482_$_14,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_481_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon251;
anon392_Else:
	assume CanRead(exhaleMask#_482_$_14,ZeroMask,exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon251;
anon393_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  245.6: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  245.6: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_482_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_482_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_482_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_482_$_16 == exhaleMask#_482_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_482_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_482_$_15[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_482_$_16);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_16,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_17 == exhaleMask#_482_$_16;
	if ($_$_condition_$148) { goto anon394_Then; } else { goto anon394_Else; }
anon393_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_482_$_17 == exhaleMask#_482_$_15;
	if ($_$_condition_$149) { goto anon394_Then; } else { goto anon394_Else; }
anon175:
	assume IsGoodMask(exhaleMask#_390_$_14);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_14,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_15 == exhaleMask#_390_$_14;
	if ($_$_condition_$144) { goto anon356_Then; } else { goto anon356_Else; }
anon251:
	assume IsGoodMask(exhaleMask#_482_$_14);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_14,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_15 == exhaleMask#_482_$_14;
	if ($_$_condition_$145) { goto anon393_Then; } else { goto anon393_Else; }
anon357_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  227.6: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  227.6: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_390_$_17[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_390_$_17[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_390_$_17[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_390_$_18 == exhaleMask#_390_$_17[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_390_$_17[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_390_$_17[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_390_$_18);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_18,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_19 == exhaleMask#_390_$_18;
	if ($_$_condition_$150) { goto anon358_Then; } else { goto anon358_Else; }
anon357_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_390_$_19 == exhaleMask#_390_$_17;
	if ($_$_condition_$151) { goto anon358_Then; } else { goto anon358_Else; }
anon394_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  245.6: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  245.6: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_482_$_17[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_482_$_17[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_482_$_17[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_482_$_18 == exhaleMask#_482_$_17[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_482_$_17[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_482_$_17[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_482_$_18);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_18,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_19 == exhaleMask#_482_$_18;
	if ($_$_condition_$152) { goto anon395_Then; } else { goto anon395_Else; }
anon394_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_482_$_19 == exhaleMask#_482_$_17;
	if ($_$_condition_$153) { goto anon395_Then; } else { goto anon395_Else; }
anon358_Then:
	assume !(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  227.6: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  227.6: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_390_$_19[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_390_$_19[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_390_$_19[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_390_$_20 == exhaleMask#_390_$_19[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_390_$_19[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_390_$_19[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_390_$_20);
	assume wf(exhaleHeap#_350_$_0,exhaleMask#_390_$_20,ZeroMask);
	assume wf(exhaleHeap#_350_$_0,Mask_$_86,ZeroMask);
	assume exhaleMask#_390_$_21 == exhaleMask#_390_$_20;
	goto anon182;
anon358_Else:
	assume exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_390_$_21 == exhaleMask#_390_$_19;
	goto anon182;
anon395_Then:
	assume !(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  245.6: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  245.6: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_482_$_19[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_482_$_19[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_482_$_19[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_482_$_20 == exhaleMask#_482_$_19[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_482_$_19[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_482_$_19[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_482_$_20);
	assume wf(exhaleHeap#_442_$_0,exhaleMask#_482_$_20,ZeroMask);
	assume wf(exhaleHeap#_442_$_0,Mask_$_52,ZeroMask);
	assume exhaleMask#_482_$_21 == exhaleMask#_482_$_20;
	goto anon258;
anon395_Else:
	assume exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_482_$_21 == exhaleMask#_482_$_19;
	goto anon258;
anon182:
	assume IsGoodExhaleState(exhaleHeap#_389_$_0,exhaleHeap#_350_$_0,exhaleMask#_390_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_390_$_21);
	assume wf(exhaleHeap#_389_$_0,exhaleMask#_390_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_389_$_0,exhaleMask#_390_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_87 == exhaleMask#_390_$_21[this,AVLTreeNode.valid := exhaleMask#_390_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_390_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_87);
	assume IsGoodState(heapFragment(exhaleHeap#_389_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_389_$_0,Mask_$_87,ZeroMask);
	assume wf(exhaleHeap#_389_$_0,Mask_$_87,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_389_$_0,Mask_$_87,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_88 == Mask_$_87[this,AVLTreeNode.height := Mask_$_87[this,AVLTreeNode.height][perm$R := Mask_$_87[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_88);
	assume IsGoodState(heapFragment(exhaleHeap#_389_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_389_$_0,Mask_$_88,ZeroMask);
	assume wf(exhaleHeap#_389_$_0,Mask_$_88,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_389_$_0,Mask_$_88,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_89 == Mask_$_88[this,AVLTreeNode.keys := Mask_$_88[this,AVLTreeNode.keys][perm$R := Mask_$_88[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_89);
	assume IsGoodState(heapFragment(exhaleHeap#_389_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_389_$_0,Mask_$_89,ZeroMask);
	assume wf(exhaleHeap#_389_$_0,Mask_$_89,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_389_$_0,Mask_$_89,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_90 == Mask_$_89[this,AVLTreeNode.balanceFactor := Mask_$_89[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_89[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_90);
	assume IsGoodState(heapFragment(exhaleHeap#_389_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_389_$_0,Mask_$_90,ZeroMask);
	assume wf(exhaleHeap#_389_$_0,Mask_$_90,ZeroMask);
	assume Seq#Equal(exhaleHeap#_389_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_350_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_389_$_0[this,AVLTreeNode.height] == ite(ite(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_389_$_0[this,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_350_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_350_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_350_$_0[exhaleHeap#_350_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_90);
	assume wf(exhaleHeap#_389_$_0,Mask_$_90,ZeroMask);
	assume Heap_$_6 == exhaleHeap#_389_$_0;
	assume Mask_$_99 == Mask_$_90;
	assume r#10_$_0 == this;
	goto anon259;
anon258:
	assume IsGoodExhaleState(exhaleHeap#_481_$_0,exhaleHeap#_442_$_0,exhaleMask#_482_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_482_$_21);
	assume wf(exhaleHeap#_481_$_0,exhaleMask#_482_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_481_$_0,exhaleMask#_482_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_53 == exhaleMask#_482_$_21[this,AVLTreeNode.valid := exhaleMask#_482_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_482_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_53);
	assume IsGoodState(heapFragment(exhaleHeap#_481_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_481_$_0,Mask_$_53,ZeroMask);
	assume wf(exhaleHeap#_481_$_0,Mask_$_53,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_481_$_0,Mask_$_53,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_54 == Mask_$_53[this,AVLTreeNode.height := Mask_$_53[this,AVLTreeNode.height][perm$R := Mask_$_53[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_54);
	assume IsGoodState(heapFragment(exhaleHeap#_481_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_481_$_0,Mask_$_54,ZeroMask);
	assume wf(exhaleHeap#_481_$_0,Mask_$_54,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_481_$_0,Mask_$_54,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_55 == Mask_$_54[this,AVLTreeNode.keys := Mask_$_54[this,AVLTreeNode.keys][perm$R := Mask_$_54[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_55);
	assume IsGoodState(heapFragment(exhaleHeap#_481_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_481_$_0,Mask_$_55,ZeroMask);
	assume wf(exhaleHeap#_481_$_0,Mask_$_55,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_481_$_0,Mask_$_55,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_56 == Mask_$_55[this,AVLTreeNode.balanceFactor := Mask_$_55[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_55[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_56);
	assume IsGoodState(heapFragment(exhaleHeap#_481_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_481_$_0,Mask_$_56,ZeroMask);
	assume wf(exhaleHeap#_481_$_0,Mask_$_56,ZeroMask);
	assume Seq#Equal(exhaleHeap#_481_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_442_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_481_$_0[this,AVLTreeNode.height] == ite(ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_481_$_0[this,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_442_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_442_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_442_$_0[exhaleHeap#_442_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_56);
	assume wf(exhaleHeap#_481_$_0,Mask_$_56,ZeroMask);
	assume Heap_$_6 == exhaleHeap#_481_$_0;
	assume Mask_$_99 == Mask_$_56;
	assume r#10_$_0 == this;
	goto anon259;
anon396_Then:
	assume Seq#Contains(Heap[this,AVLTreeNode.keys],k#9);
	assert { :msg "  184.2: The postcondition at 199.11 might not hold. The expression at 199.30 might not evaluate to true." } Seq#Equal(Heap_$_6[r#10_$_0,AVLTreeNode.keys],Heap[this,AVLTreeNode.keys]);
	if ($_$_condition_$155) { goto anon397_Then; } else { goto anon397_Else; }
anon396_Else:
	assume !Seq#Contains(Heap[this,AVLTreeNode.keys],k#9);
	if ($_$_condition_$156) { goto anon397_Then; } else { goto anon397_Else; }
anon397_Then:
	assume !Seq#Contains(Heap[this,AVLTreeNode.keys],k#9);
	assert { :msg "  184.2: The postcondition at 200.11 might not hold. The expression at 200.33 might not evaluate to true." } Seq#Length(Heap_$_6[r#10_$_0,AVLTreeNode.keys]) == (Seq#Length(Heap[this,AVLTreeNode.keys]) + 1);
	goto anon263;
anon397_Else:
	assume Seq#Contains(Heap[this,AVLTreeNode.keys],k#9);
	goto anon263;
anon263:
	assert { :msg "  184.2: The postcondition at 202.11 might not hold. The expression at 202.11 might not evaluate to true." } (Heap_$_6[r#10_$_0,AVLTreeNode.height] == Heap[this,AVLTreeNode.height]) || (Heap_$_6[r#10_$_0,AVLTreeNode.height] == (Heap[this,AVLTreeNode.height] + 1));
	if ($_$_condition_$157) { goto anon398_Then; } else { goto anon398_Else; }
anon398_Then:
	assume Seq#Contains(Heap[this,AVLTreeNode.keys],k#9);
	assert { :msg "  184.2: The postcondition at 203.11 might not hold. The expression at 203.30 might not evaluate to true." } Heap_$_6[r#10_$_0,AVLTreeNode.height] == Heap[this,AVLTreeNode.height];
	goto anon265;
anon398_Else:
	assume !Seq#Contains(Heap[this,AVLTreeNode.keys],k#9);
	goto anon265;
anon265:
	assert { :msg "  184.2: The postcondition at 191.11 might not hold. The permission at 191.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  184.2: The postcondition at 191.11 might not hold. Insufficient fraction at 191.11 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_99[r#10_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_99[r#10_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_99[r#10_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_500_$_0 == Mask_$_99[r#10_$_0,AVLTreeNode.valid := Mask_$_99[r#10_$_0,AVLTreeNode.valid][perm$R := Mask_$_99[r#10_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$158) { goto anon399_Then; } else { goto anon399_Else; }
anon399_Then:
	assume !CanRead(exhaleMask#_500_$_0,ZeroMask,r#10_$_0,AVLTreeNode.valid);
	assume Heap_$_6[r#10_$_0,AVLTreeNode.valid] < exhaleHeap#_499_$_0[r#10_$_0,AVLTreeNode.valid];
	goto anon267;
anon399_Else:
	assume CanRead(exhaleMask#_500_$_0,ZeroMask,r#10_$_0,AVLTreeNode.valid);
	goto anon267;
anon267:
	assume IsGoodMask(exhaleMask#_500_$_0);
	assume wf(Heap_$_6,exhaleMask#_500_$_0,ZeroMask);
	assume wf(Heap_$_6,Mask_$_99,ZeroMask);
	assert { :msg "  184.2: The postcondition at 192.11 might not hold. The permission at 192.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  184.2: The postcondition at 192.11 might not hold. Insufficient fraction at 192.11 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_500_$_0[r#10_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_500_$_0[r#10_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_500_$_0[r#10_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_500_$_1 == exhaleMask#_500_$_0[r#10_$_0,AVLTreeNode.keys := exhaleMask#_500_$_0[r#10_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_500_$_0[r#10_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_500_$_1);
	assume wf(Heap_$_6,exhaleMask#_500_$_1,ZeroMask);
	assume wf(Heap_$_6,Mask_$_99,ZeroMask);
	assert { :msg "  184.2: The postcondition at 193.11 might not hold. The permission at 193.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  184.2: The postcondition at 193.11 might not hold. Insufficient fraction at 193.11 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_500_$_1[r#10_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_500_$_1[r#10_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_500_$_1[r#10_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_500_$_2 == exhaleMask#_500_$_1[r#10_$_0,AVLTreeNode.height := exhaleMask#_500_$_1[r#10_$_0,AVLTreeNode.height][perm$R := exhaleMask#_500_$_1[r#10_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_500_$_2);
	assume wf(Heap_$_6,exhaleMask#_500_$_2,ZeroMask);
	assume wf(Heap_$_6,Mask_$_99,ZeroMask);
	assert { :msg "  184.2: The postcondition at 194.11 might not hold. The permission at 194.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  184.2: The postcondition at 194.11 might not hold. Insufficient fraction at 194.11 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_500_$_2[r#10_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_500_$_2[r#10_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_500_$_2[r#10_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_500_$_3 == exhaleMask#_500_$_2[r#10_$_0,AVLTreeNode.balanceFactor := exhaleMask#_500_$_2[r#10_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_500_$_2[r#10_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_500_$_3);
	assume wf(Heap_$_6,exhaleMask#_500_$_3,ZeroMask);
	assume wf(Heap_$_6,Mask_$_99,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_499_$_0,Heap_$_6,exhaleMask#_500_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_500_$_3);
	assume wf(exhaleHeap#_499_$_0,exhaleMask#_500_$_3,ZeroMask);
	assert { :msg "  184.2: Method might lock/unlock more than allowed." } (forall  lk#_505 : ref :: {exhaleHeap#_499_$_0[lk#_505,held]} {exhaleHeap#_499_$_0[lk#_505,rdheld]} ( (((0 < exhaleHeap#_499_$_0[lk#_505,held]) <==> (0 < Heap[lk#_505,held])) && (exhaleHeap#_499_$_0[lk#_505,rdheld] <==> Heap[lk#_505,rdheld])) || false ));
	assert { :msg "  184.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
