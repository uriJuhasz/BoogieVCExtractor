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
procedure AVLTreeNode.pruneMax (this : ref) returns (r#35 : ref,m#36 : ref)
{
	var methodK#_923 : int;
	var unfoldK#_924 : int;
	var oldVers#_944 : int;
	var newVers#_945 : int;
	var cond#_946 : bool;
	var methodCallK#_951 : int;
	var this#327 : ref;
	var callHeap#_947 : HeapType;
	var callMask#_948 : MaskType;
	var callSecMask#_949 : MaskType;
	var callCredits#_950 : CreditsType;
	var exhaleMask#_953 : MaskType;
	var exhaleHeap#_952 : HeapType;
	var assertHeap#_970 : HeapType;
	var assertMask#_971 : MaskType;
	var assertSecMask#_972 : MaskType;
	var assertCredits#_973 : CreditsType;
	var exhaleMask#_975 : MaskType;
	var exhaleHeap#_974 : HeapType;
	var k#87#333 : int;
	var nr#38 : ref;
	var methodCallK#_980 : int;
	var this#335 : ref;
	var r#336 : ref;
	var m#337 : ref;
	var callHeap#_976 : HeapType;
	var callMask#_977 : MaskType;
	var callSecMask#_978 : MaskType;
	var callCredits#_979 : CreditsType;
	var exhaleMask#_982 : MaskType;
	var exhaleHeap#_981 : HeapType;
	var bf#40 : int;
	var methodCallK#_993 : int;
	var this#339 : ref;
	var bf#340 : int;
	var callHeap#_989 : HeapType;
	var callMask#_990 : MaskType;
	var callSecMask#_991 : MaskType;
	var callCredits#_992 : CreditsType;
	var exhaleMask#_995 : MaskType;
	var exhaleHeap#_994 : HeapType;
	var cond#_1004 : bool;
	var methodCallK#_1009 : int;
	var this#341 : ref;
	var r#342 : ref;
	var callHeap#_1005 : HeapType;
	var callMask#_1006 : MaskType;
	var callSecMask#_1007 : MaskType;
	var callCredits#_1008 : CreditsType;
	var exhaleMask#_1011 : MaskType;
	var exhaleHeap#_1010 : HeapType;
	var methodCallK#_1032 : int;
	var this#347 : ref;
	var callHeap#_1028 : HeapType;
	var callMask#_1029 : MaskType;
	var callSecMask#_1030 : MaskType;
	var callCredits#_1031 : CreditsType;
	var exhaleMask#_1034 : MaskType;
	var exhaleHeap#_1033 : HeapType;
	var assertHeap#_1051 : HeapType;
	var assertMask#_1052 : MaskType;
	var assertSecMask#_1053 : MaskType;
	var assertCredits#_1054 : CreditsType;
	var exhaleMask#_1056 : MaskType;
	var exhaleHeap#_1055 : HeapType;
	var k#88#353 : int;
	var exhaleMask#_1058 : MaskType;
	var exhaleHeap#_1057 : HeapType;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var Mask_$_3 : MaskType;
	var Mask_$_4 : MaskType;
	var oldVers#_944_$_0 : int;
	var newVers#_945_$_0 : int;
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
	var cond#_946_$_0 : bool;
	var r#35_$_0 : ref;
	var Heap_$_2 : HeapType;
	var exhaleHeap#_952_$_0 : HeapType;
	var this#335_$_0 : ref;
	var exhaleHeap#_981_$_0 : HeapType;
	var exhaleMask#_982_$_0 : MaskType;
	var exhaleMask#_982_$_1 : MaskType;
	var exhaleMask#_982_$_2 : MaskType;
	var exhaleMask#_982_$_3 : MaskType;
	var r#336_$_0 : ref;
	var m#337_$_0 : ref;
	var Mask_$_27 : MaskType;
	var Mask_$_28 : MaskType;
	var Mask_$_29 : MaskType;
	var Mask_$_30 : MaskType;
	var Mask_$_31 : MaskType;
	var Mask_$_32 : MaskType;
	var Mask_$_33 : MaskType;
	var Mask_$_34 : MaskType;
	var Mask_$_35 : MaskType;
	var Mask_$_36 : MaskType;
	var Mask_$_37 : MaskType;
	var Mask_$_38 : MaskType;
	var Heap_$_3 : HeapType;
	var exhaleHeap#_994_$_0 : HeapType;
	var exhaleMask#_995_$_0 : MaskType;
	var exhaleMask#_995_$_1 : MaskType;
	var exhaleMask#_995_$_2 : MaskType;
	var exhaleMask#_995_$_3 : MaskType;
	var exhaleMask#_995_$_4 : MaskType;
	var exhaleMask#_995_$_5 : MaskType;
	var exhaleMask#_995_$_6 : MaskType;
	var exhaleMask#_995_$_7 : MaskType;
	var exhaleMask#_995_$_8 : MaskType;
	var exhaleMask#_995_$_9 : MaskType;
	var bf#340_$_0 : int;
	var Mask_$_39 : MaskType;
	var Mask_$_40 : MaskType;
	var Mask_$_41 : MaskType;
	var Mask_$_42 : MaskType;
	var Mask_$_43 : MaskType;
	var Mask_$_44 : MaskType;
	var Mask_$_45 : MaskType;
	var Mask_$_46 : MaskType;
	var Mask_$_47 : MaskType;
	var Mask_$_48 : MaskType;
	var cond#_1004_$_0 : bool;
	var exhaleHeap#_1010_$_0 : HeapType;
	var exhaleHeap#_1033_$_0 : HeapType;
	var exhaleMask#_1034_$_0 : MaskType;
	var exhaleMask#_1034_$_1 : MaskType;
	var exhaleMask#_1034_$_2 : MaskType;
	var exhaleMask#_1034_$_3 : MaskType;
	var exhaleMask#_1034_$_4 : MaskType;
	var exhaleMask#_1034_$_5 : MaskType;
	var exhaleMask#_1034_$_6 : MaskType;
	var exhaleMask#_1034_$_7 : MaskType;
	var exhaleMask#_1034_$_8 : MaskType;
	var exhaleMask#_1034_$_9 : MaskType;
	var exhaleMask#_1034_$_10 : MaskType;
	var exhaleMask#_1034_$_11 : MaskType;
	var exhaleMask#_1034_$_12 : MaskType;
	var exhaleMask#_1034_$_13 : MaskType;
	var exhaleMask#_1034_$_14 : MaskType;
	var exhaleMask#_1034_$_15 : MaskType;
	var exhaleMask#_1034_$_16 : MaskType;
	var exhaleMask#_1034_$_17 : MaskType;
	var exhaleMask#_1034_$_18 : MaskType;
	var exhaleMask#_1034_$_19 : MaskType;
	var exhaleMask#_1034_$_20 : MaskType;
	var exhaleMask#_1034_$_21 : MaskType;
	var Mask_$_49 : MaskType;
	var Mask_$_50 : MaskType;
	var Mask_$_51 : MaskType;
	var Mask_$_52 : MaskType;
	var exhaleMask#_1011_$_0 : MaskType;
	var exhaleMask#_1011_$_1 : MaskType;
	var exhaleMask#_1011_$_2 : MaskType;
	var exhaleMask#_1011_$_3 : MaskType;
	var exhaleMask#_1011_$_4 : MaskType;
	var exhaleMask#_1011_$_5 : MaskType;
	var exhaleMask#_1011_$_6 : MaskType;
	var exhaleMask#_1011_$_7 : MaskType;
	var exhaleMask#_1011_$_8 : MaskType;
	var exhaleMask#_1011_$_9 : MaskType;
	var exhaleMask#_1011_$_10 : MaskType;
	var exhaleMask#_1011_$_11 : MaskType;
	var exhaleMask#_1011_$_12 : MaskType;
	var exhaleMask#_1011_$_13 : MaskType;
	var exhaleMask#_1011_$_14 : MaskType;
	var exhaleMask#_1011_$_15 : MaskType;
	var exhaleMask#_1011_$_16 : MaskType;
	var exhaleMask#_1011_$_17 : MaskType;
	var r#342_$_0 : ref;
	var Mask_$_53 : MaskType;
	var Mask_$_54 : MaskType;
	var Mask_$_55 : MaskType;
	var Mask_$_56 : MaskType;
	var Mask_$_57 : MaskType;
	var Heap_$_4 : HeapType;
	var r#35_$_1 : ref;
	var exhaleHeap#_1055_$_0 : HeapType;
	var exhaleMask#_953_$_0 : MaskType;
	var exhaleMask#_953_$_1 : MaskType;
	var exhaleMask#_953_$_2 : MaskType;
	var exhaleMask#_953_$_3 : MaskType;
	var exhaleMask#_953_$_4 : MaskType;
	var exhaleMask#_953_$_5 : MaskType;
	var exhaleMask#_953_$_6 : MaskType;
	var exhaleMask#_953_$_7 : MaskType;
	var exhaleMask#_953_$_8 : MaskType;
	var exhaleMask#_953_$_9 : MaskType;
	var exhaleMask#_953_$_10 : MaskType;
	var exhaleMask#_953_$_11 : MaskType;
	var exhaleMask#_953_$_12 : MaskType;
	var exhaleMask#_953_$_13 : MaskType;
	var exhaleMask#_953_$_14 : MaskType;
	var exhaleMask#_953_$_15 : MaskType;
	var exhaleMask#_953_$_16 : MaskType;
	var exhaleMask#_953_$_17 : MaskType;
	var exhaleMask#_953_$_18 : MaskType;
	var exhaleMask#_953_$_19 : MaskType;
	var exhaleMask#_953_$_20 : MaskType;
	var exhaleMask#_953_$_21 : MaskType;
	var Mask_$_58 : MaskType;
	var Mask_$_59 : MaskType;
	var Mask_$_60 : MaskType;
	var Mask_$_61 : MaskType;
	var exhaleHeap#_974_$_0 : HeapType;
	var Mask_$_62 : MaskType;
	var Heap_$_5 : HeapType;
	var r#35_$_2 : ref;
	var m#36_$_0 : ref;
	var exhaleHeap#_1057_$_0 : HeapType;
	var exhaleMask#_1058_$_0 : MaskType;
	var exhaleMask#_1058_$_1 : MaskType;
	var exhaleMask#_1058_$_2 : MaskType;
	var exhaleMask#_1058_$_3 : MaskType;
	var exhaleMask#_1058_$_4 : MaskType;
	var exhaleMask#_1058_$_5 : MaskType;
	var exhaleMask#_1058_$_6 : MaskType;
	var exhaleMask#_1058_$_7 : MaskType;
	var exhaleMask#_1058_$_8 : MaskType;
	var exhaleMask#_1058_$_9 : MaskType;
	var exhaleMask#_1058_$_10 : MaskType;
	var exhaleMask#_1058_$_11 : MaskType;
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
	assume (r#35 == null) || (dtype(r#35) == AVLTreeNode#t);
	assume (m#36 == null) || (dtype(m#36) == AVLTreeNode#t);
	assume (this#327 == null) || (dtype(this#327) == AVLTreeNode#t);
	assume true;
	assume (nr#38 == null) || (dtype(nr#38) == AVLTreeNode#t);
	assume (this#335 == null) || (dtype(this#335) == AVLTreeNode#t);
	assume (r#336 == null) || (dtype(r#336) == AVLTreeNode#t);
	assume (m#337 == null) || (dtype(m#337) == AVLTreeNode#t);
	assume true;
	assume (this#339 == null) || (dtype(this#339) == AVLTreeNode#t);
	assume true;
	assume (this#341 == null) || (dtype(this#341) == AVLTreeNode#t);
	assume (r#342 == null) || (dtype(r#342) == AVLTreeNode#t);
	assume (this#347 == null) || (dtype(this#347) == AVLTreeNode#t);
	assume true;
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_923) && ((1000 * methodK#_923) < Fractions(1));
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
	assume ((0 < unfoldK#_924) && (unfoldK#_924 < Fractions(1))) && ((1000 * unfoldK#_924) < methodK#_923);
	assert { :msg "  375.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  375.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  375.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_3[this,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_3[this,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_3[this,AVLTreeNode.valid][perm$N]));
	assume Mask_$_4 == Mask_$_3[this,AVLTreeNode.valid := Mask_$_3[this,AVLTreeNode.valid][perm$R := Mask_$_3[this,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition) { goto anon219_Then; } else { goto anon219_Else; }
anon219_Then:
	assume false;
	goto $exit;
anon219_Else:
	assume !false;
	if ($_$_condition_$0) { goto anon246_Then; } else { goto anon246_Else; }
anon246_Then:
	assume !CanRead(Mask_$_4,ZeroMask,this,AVLTreeNode.valid);
	assume oldVers#_944_$_0 == Heap[this,AVLTreeNode.valid];
	assume Heap_$_0 == Heap[this,AVLTreeNode.valid := newVers#_945_$_0];
	assume oldVers#_944_$_0 < Heap_$_0[this,AVLTreeNode.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon56;
anon246_Else:
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
	if ($_$_condition_$1) { goto anon247_Then; } else { goto anon247_Else; }
anon247_Then:
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
	if ($_$_condition_$2) { goto anon248_Then; } else { goto anon248_Else; }
anon247_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_12 == Mask_$_10;
	if ($_$_condition_$3) { goto anon248_Then; } else { goto anon248_Else; }
anon248_Then:
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
	if ($_$_condition_$4) { goto anon249_Then; } else { goto anon249_Else; }
anon248_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_14 == Mask_$_12;
	if ($_$_condition_$5) { goto anon249_Then; } else { goto anon249_Else; }
anon249_Then:
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
	if ($_$_condition_$6) { goto anon250_Then; } else { goto anon250_Else; }
anon249_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_16 == Mask_$_14;
	if ($_$_condition_$7) { goto anon250_Then; } else { goto anon250_Else; }
anon250_Then:
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
	if ($_$_condition_$8) { goto anon251_Then; } else { goto anon251_Else; }
anon250_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_18 == Mask_$_16;
	if ($_$_condition_$9) { goto anon251_Then; } else { goto anon251_Else; }
anon251_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume (forall  lk#79#325 : Integer :: ( ((0 <= lk#79#325) && (lk#79#325 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],lk#79#325) < Heap_$_1[this,AVLTreeNode.key]) ));
	if ($_$_condition_$10) { goto anon252_Then; } else { goto anon252_Else; }
anon251_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$11) { goto anon252_Then; } else { goto anon252_Else; }
anon252_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$12) { goto anon253_Then; } else { goto anon253_Else; }
anon252_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$13) { goto anon253_Then; } else { goto anon253_Else; }
anon253_Then:
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
	if ($_$_condition_$14) { goto anon254_Then; } else { goto anon254_Else; }
anon253_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_20 == Mask_$_18;
	if ($_$_condition_$15) { goto anon254_Then; } else { goto anon254_Else; }
anon254_Then:
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
	if ($_$_condition_$16) { goto anon255_Then; } else { goto anon255_Else; }
anon254_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_22 == Mask_$_20;
	if ($_$_condition_$17) { goto anon255_Then; } else { goto anon255_Else; }
anon255_Then:
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
	if ($_$_condition_$18) { goto anon256_Then; } else { goto anon256_Else; }
anon255_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_24 == Mask_$_22;
	if ($_$_condition_$19) { goto anon256_Then; } else { goto anon256_Else; }
anon256_Then:
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
	if ($_$_condition_$20) { goto anon257_Then; } else { goto anon257_Else; }
anon256_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_26 == Mask_$_24;
	if ($_$_condition_$21) { goto anon257_Then; } else { goto anon257_Else; }
anon257_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume (forall  rk#80#326 : Integer :: ( ((0 <= rk#80#326) && (rk#80#326 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[this,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],rk#80#326)) ));
	if ($_$_condition_$22) { goto anon258_Then; } else { goto anon258_Else; }
anon257_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	if ($_$_condition_$23) { goto anon258_Then; } else { goto anon258_Else; }
anon258_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon80;
anon258_Else:
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
	assume cond#_946_$_0 <==> (Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  377.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  377.7: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$24) { goto anon259_Then; } else { goto anon259_Else; }
anon259_Then:
	assume cond#_946_$_0;
	assert { :msg "  378.9: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  378.9: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	assume r#35_$_0 == Heap_$_1[this,AVLTreeNode.left];
	assert { :msg "  379.4: Location might not be writable" } CanWrite(Mask_$_26,this,AVLTreeNode.left);
	assume Heap_$_2 == Heap_$_1[this,AVLTreeNode.left := null];
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume ((0 < methodCallK#_951) && ((1000 * methodCallK#_951) < Fractions(1))) && ((1000 * methodCallK#_951) < methodK#_923);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assert { :msg "  380.4: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$25) { goto anon260_Then; } else { goto anon260_Else; }
anon259_Else:
	assume !cond#_946_$_0;
	assume ((0 < methodCallK#_980) && ((1000 * methodCallK#_980) < Fractions(1))) && ((1000 * methodCallK#_980) < methodK#_923);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  387.17: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  387.17: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  387.4: The target of the method call might be null." } !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume this#335_$_0 == Heap_$_1[this,AVLTreeNode.right];
	assert { :msg "  387.4: The precondition at 349.12 might not hold. The permission at 349.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  387.4: The precondition at 349.12 might not hold. Insufficient fraction at 349.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_26[this#335_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_26[this#335_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_26[this#335_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_982_$_0 == Mask_$_26[this#335_$_0,AVLTreeNode.valid := Mask_$_26[this#335_$_0,AVLTreeNode.valid][perm$R := Mask_$_26[this#335_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$26) { goto anon273_Then; } else { goto anon273_Else; }
anon260_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  380.4: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#328 : Integer :: ( ((0 <= k#92#328) && (k#92#328 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#328) < Heap_$_2[this,AVLTreeNode.key]) ));
	if ($_$_condition_$27) { goto anon261_Then; } else { goto anon261_Else; }
anon260_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	if ($_$_condition_$28) { goto anon261_Then; } else { goto anon261_Else; }
anon273_Then:
	assume !CanRead(exhaleMask#_982_$_0,ZeroMask,this#335_$_0,AVLTreeNode.valid);
	assume Heap_$_1[this#335_$_0,AVLTreeNode.valid] < exhaleHeap#_981_$_0[this#335_$_0,AVLTreeNode.valid];
	goto anon110;
anon273_Else:
	assume CanRead(exhaleMask#_982_$_0,ZeroMask,this#335_$_0,AVLTreeNode.valid);
	goto anon110;
anon261_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  380.4: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#329 : Integer :: ( ((0 <= k#93#329) && (k#93#329 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_2[this,AVLTreeNode.key] < Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#329)) ));
	goto anon85;
anon261_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	goto anon85;
anon110:
	assume IsGoodMask(exhaleMask#_982_$_0);
	assume wf(Heap_$_1,exhaleMask#_982_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  387.4: The precondition at 350.12 might not hold. The permission at 350.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  387.4: The precondition at 350.12 might not hold. Insufficient fraction at 350.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_982_$_0[this#335_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_982_$_0[this#335_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_982_$_0[this#335_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_982_$_1 == exhaleMask#_982_$_0[this#335_$_0,AVLTreeNode.keys := exhaleMask#_982_$_0[this#335_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_982_$_0[this#335_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_982_$_1);
	assume wf(Heap_$_1,exhaleMask#_982_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  387.4: The precondition at 351.12 might not hold. The permission at 351.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  387.4: The precondition at 351.12 might not hold. Insufficient fraction at 351.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_982_$_1[this#335_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_982_$_1[this#335_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_982_$_1[this#335_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_982_$_2 == exhaleMask#_982_$_1[this#335_$_0,AVLTreeNode.height := exhaleMask#_982_$_1[this#335_$_0,AVLTreeNode.height][perm$R := exhaleMask#_982_$_1[this#335_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_982_$_2);
	assume wf(Heap_$_1,exhaleMask#_982_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  387.4: The precondition at 352.12 might not hold. The permission at 352.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  387.4: The precondition at 352.12 might not hold. Insufficient fraction at 352.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_982_$_2[this#335_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_982_$_2[this#335_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_982_$_2[this#335_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_982_$_3 == exhaleMask#_982_$_2[this#335_$_0,AVLTreeNode.balanceFactor := exhaleMask#_982_$_2[this#335_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_982_$_2[this#335_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_982_$_3);
	assume wf(Heap_$_1,exhaleMask#_982_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_981_$_0,Heap_$_1,exhaleMask#_982_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_982_$_3);
	assume wf(exhaleHeap#_981_$_0,exhaleMask#_982_$_3,ZeroMask);
	assume (r#336_$_0 == null) || (dtype(r#336_$_0) == AVLTreeNode#t);
	assume (m#337_$_0 == null) || (dtype(m#337_$_0) == AVLTreeNode#t);
	if ($_$_condition_$29) { goto anon274_Then; } else { goto anon274_Else; }
anon85:
	assert { :msg "  380.4: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  380.4: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  380.4: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_26[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_26[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_26[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_953_$_0 == Mask_$_26[this,AVLTreeNode.key := Mask_$_26[this,AVLTreeNode.key][perm$R := Mask_$_26[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_953_$_0);
	assume wf(Heap_$_2,exhaleMask#_953_$_0,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assert { :msg "  380.4: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_953_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_953_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_953_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_953_$_1 == exhaleMask#_953_$_0[this,AVLTreeNode.height := exhaleMask#_953_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_953_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_953_$_1);
	assume wf(Heap_$_2,exhaleMask#_953_$_1,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assert { :msg "  380.4: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_953_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_953_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_953_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_953_$_2 == exhaleMask#_953_$_1[this,AVLTreeNode.left := exhaleMask#_953_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_953_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_953_$_2);
	assume wf(Heap_$_2,exhaleMask#_953_$_2,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assert { :msg "  380.4: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_953_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_953_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_953_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_953_$_3 == exhaleMask#_953_$_2[this,AVLTreeNode.right := exhaleMask#_953_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_953_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_953_$_3);
	assume wf(Heap_$_2,exhaleMask#_953_$_3,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assert { :msg "  380.4: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_953_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_953_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_953_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_953_$_4 == exhaleMask#_953_$_3[this,AVLTreeNode.keys := exhaleMask#_953_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_953_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_953_$_4);
	assume wf(Heap_$_2,exhaleMask#_953_$_4,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assert { :msg "  380.4: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_953_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_953_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_953_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_953_$_5 == exhaleMask#_953_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_953_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_953_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_953_$_5);
	assume wf(Heap_$_2,exhaleMask#_953_$_5,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	if ($_$_condition_$30) { goto anon262_Then; } else { goto anon262_Else; }
anon274_Then:
	assume !(r#336_$_0 == null);
	assume !(r#336_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,exhaleMask#_982_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_27 == exhaleMask#_982_$_3[r#336_$_0,AVLTreeNode.valid := exhaleMask#_982_$_3[r#336_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_982_$_3[r#336_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_27);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_27,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_27,ZeroMask);
	assume Mask_$_28 == Mask_$_27;
	if ($_$_condition_$31) { goto anon275_Then; } else { goto anon275_Else; }
anon274_Else:
	assume r#336_$_0 == null;
	assume Mask_$_28 == exhaleMask#_982_$_3;
	if ($_$_condition_$32) { goto anon275_Then; } else { goto anon275_Else; }
anon262_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  380.4: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_953_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_953_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_953_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_953_$_6 == exhaleMask#_953_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_953_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_953_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$33) { goto anon263_Then; } else { goto anon263_Else; }
anon262_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_953_$_7 == exhaleMask#_953_$_5;
	if ($_$_condition_$34) { goto anon264_Then; } else { goto anon264_Else; }
anon275_Then:
	assume !(r#336_$_0 == null);
	assume !(r#336_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,Mask_$_28,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_29 == Mask_$_28[r#336_$_0,AVLTreeNode.keys := Mask_$_28[r#336_$_0,AVLTreeNode.keys][perm$R := Mask_$_28[r#336_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_29);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_29,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_29,ZeroMask);
	assume Mask_$_30 == Mask_$_29;
	if ($_$_condition_$35) { goto anon276_Then; } else { goto anon276_Else; }
anon275_Else:
	assume r#336_$_0 == null;
	assume Mask_$_30 == Mask_$_28;
	if ($_$_condition_$36) { goto anon276_Then; } else { goto anon276_Else; }
anon263_Then:
	assume !CanRead(exhaleMask#_953_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_952_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon88;
anon263_Else:
	assume CanRead(exhaleMask#_953_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon88;
anon264_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  380.4: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  380.4: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_953_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_953_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_953_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_953_$_8 == exhaleMask#_953_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_953_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_953_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_953_$_8);
	assume wf(Heap_$_2,exhaleMask#_953_$_8,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_9 == exhaleMask#_953_$_8;
	if ($_$_condition_$42) { goto anon265_Then; } else { goto anon265_Else; }
anon264_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_953_$_9 == exhaleMask#_953_$_7;
	if ($_$_condition_$43) { goto anon265_Then; } else { goto anon265_Else; }
anon276_Then:
	assume !(r#336_$_0 == null);
	assume !(r#336_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,Mask_$_30,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_31 == Mask_$_30[r#336_$_0,AVLTreeNode.height := Mask_$_30[r#336_$_0,AVLTreeNode.height][perm$R := Mask_$_30[r#336_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_31);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_31,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_31,ZeroMask);
	assume Mask_$_32 == Mask_$_31;
	if ($_$_condition_$37) { goto anon277_Then; } else { goto anon277_Else; }
anon276_Else:
	assume r#336_$_0 == null;
	assume Mask_$_32 == Mask_$_30;
	if ($_$_condition_$38) { goto anon277_Then; } else { goto anon277_Else; }
anon88:
	assume IsGoodMask(exhaleMask#_953_$_6);
	assume wf(Heap_$_2,exhaleMask#_953_$_6,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_7 == exhaleMask#_953_$_6;
	if ($_$_condition_$39) { goto anon264_Then; } else { goto anon264_Else; }
anon277_Then:
	assume !(r#336_$_0 == null);
	assume !(r#336_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,Mask_$_32,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_33 == Mask_$_32[r#336_$_0,AVLTreeNode.balanceFactor := Mask_$_32[r#336_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_32[r#336_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_33);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_33,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_33,ZeroMask);
	assume Mask_$_34 == Mask_$_33;
	if ($_$_condition_$40) { goto anon278_Then; } else { goto anon278_Else; }
anon277_Else:
	assume r#336_$_0 == null;
	assume Mask_$_34 == Mask_$_32;
	if ($_$_condition_$41) { goto anon278_Then; } else { goto anon278_Else; }
anon278_Then:
	assume !(r#336_$_0 == null);
	assume (exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.height] == Heap_$_1[this#335_$_0,AVLTreeNode.height]) || ((exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.height] + 1) == Heap_$_1[this#335_$_0,AVLTreeNode.height]);
	if ($_$_condition_$44) { goto anon279_Then; } else { goto anon279_Else; }
anon278_Else:
	assume r#336_$_0 == null;
	if ($_$_condition_$45) { goto anon279_Then; } else { goto anon279_Else; }
anon265_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  380.4: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  380.4: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_953_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_953_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_953_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_953_$_10 == exhaleMask#_953_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_953_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_953_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_953_$_10);
	assume wf(Heap_$_2,exhaleMask#_953_$_10,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_11 == exhaleMask#_953_$_10;
	if ($_$_condition_$46) { goto anon266_Then; } else { goto anon266_Else; }
anon265_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_953_$_11 == exhaleMask#_953_$_9;
	if ($_$_condition_$47) { goto anon266_Then; } else { goto anon266_Else; }
anon279_Then:
	assume !(r#336_$_0 == null);
	assume (Seq#Length(exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.keys]) + 1) == Seq#Length(Heap_$_1[this#335_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$48) { goto anon280_Then; } else { goto anon280_Else; }
anon279_Else:
	assume r#336_$_0 == null;
	if ($_$_condition_$49) { goto anon280_Then; } else { goto anon280_Else; }
anon266_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  380.4: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  380.4: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_953_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_953_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_953_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_953_$_12 == exhaleMask#_953_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_953_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_953_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_953_$_12);
	assume wf(Heap_$_2,exhaleMask#_953_$_12,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_13 == exhaleMask#_953_$_12;
	if ($_$_condition_$50) { goto anon267_Then; } else { goto anon267_Else; }
anon266_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_953_$_13 == exhaleMask#_953_$_11;
	if ($_$_condition_$51) { goto anon267_Then; } else { goto anon267_Else; }
anon280_Then:
	assume Heap_$_1[this#335_$_0,AVLTreeNode.height] > 1;
	assume !(r#336_$_0 == null);
	if ($_$_condition_$52) { goto anon281_Then; } else { goto anon281_Else; }
anon280_Else:
	assume 1 >= Heap_$_1[this#335_$_0,AVLTreeNode.height];
	if ($_$_condition_$53) { goto anon281_Then; } else { goto anon281_Else; }
anon267_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  380.4: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  380.4: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_953_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_953_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_953_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_953_$_14 == exhaleMask#_953_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_953_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_953_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$54) { goto anon268_Then; } else { goto anon268_Else; }
anon267_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_953_$_15 == exhaleMask#_953_$_13;
	if ($_$_condition_$55) { goto anon269_Then; } else { goto anon269_Else; }
anon281_Then:
	assume Heap_$_1[this#335_$_0,AVLTreeNode.height] == 1;
	assume r#336_$_0 == null;
	goto anon126;
anon281_Else:
	assume !(Heap_$_1[this#335_$_0,AVLTreeNode.height] == 1);
	goto anon126;
anon268_Then:
	assume !CanRead(exhaleMask#_953_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_952_$_0[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon98;
anon268_Else:
	assume CanRead(exhaleMask#_953_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon98;
anon269_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  380.4: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  380.4: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_953_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_953_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_953_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_953_$_16 == exhaleMask#_953_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_953_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_953_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_953_$_16);
	assume wf(Heap_$_2,exhaleMask#_953_$_16,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_17 == exhaleMask#_953_$_16;
	if ($_$_condition_$58) { goto anon270_Then; } else { goto anon270_Else; }
anon269_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_953_$_17 == exhaleMask#_953_$_15;
	if ($_$_condition_$59) { goto anon270_Then; } else { goto anon270_Else; }
anon126:
	assume (Heap_$_1[this#335_$_0,AVLTreeNode.height] == ite(r#336_$_0 == null,0,exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.height])) || (Heap_$_1[this#335_$_0,AVLTreeNode.height] == (ite(r#336_$_0 == null,0,exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.height]) + 1));
	assume !(m#337_$_0 == null);
	assume !(m#337_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,Mask_$_34,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_35 == Mask_$_34[m#337_$_0,AVLTreeNode.valid := Mask_$_34[m#337_$_0,AVLTreeNode.valid][perm$R := Mask_$_34[m#337_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_35);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_35,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_35,ZeroMask);
	assume !(m#337_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,Mask_$_35,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_36 == Mask_$_35[m#337_$_0,AVLTreeNode.keys := Mask_$_35[m#337_$_0,AVLTreeNode.keys][perm$R := Mask_$_35[m#337_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_36);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_36,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_36,ZeroMask);
	assume !(m#337_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,Mask_$_36,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_37 == Mask_$_36[m#337_$_0,AVLTreeNode.height := Mask_$_36[m#337_$_0,AVLTreeNode.height][perm$R := Mask_$_36[m#337_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_37);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_37,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_37,ZeroMask);
	assume !(m#337_$_0 == null);
	assume wf(exhaleHeap#_981_$_0,Mask_$_37,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_38 == Mask_$_37[m#337_$_0,AVLTreeNode.balanceFactor := Mask_$_37[m#337_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_37[m#337_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_38);
	assume IsGoodState(heapFragment(exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_981_$_0,Mask_$_38,ZeroMask);
	assume wf(exhaleHeap#_981_$_0,Mask_$_38,ZeroMask);
	assume exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.height] == 1;
	assume Seq#Length(exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.keys]) == 1;
	assume Seq#Equal(Seq#Append(ite(r#336_$_0 == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.keys]),exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.keys]),Heap_$_1[this#335_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$56) { goto anon282_Then; } else { goto anon282_Else; }
anon98:
	assume IsGoodMask(exhaleMask#_953_$_14);
	assume wf(Heap_$_2,exhaleMask#_953_$_14,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_15 == exhaleMask#_953_$_14;
	if ($_$_condition_$57) { goto anon269_Then; } else { goto anon269_Else; }
anon282_Then:
	assume !(r#336_$_0 == null);
	assume (forall  k#86#338 : Integer :: ( ((0 <= k#86#338) && (k#86#338 < Seq#Length(exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_981_$_0[r#336_$_0,AVLTreeNode.keys],k#86#338) < Seq#Index(exhaleHeap#_981_$_0[m#337_$_0,AVLTreeNode.keys],0)) ));
	goto anon128;
anon282_Else:
	assume r#336_$_0 == null;
	goto anon128;
anon128:
	assume IsGoodMask(Mask_$_38);
	assume wf(exhaleHeap#_981_$_0,Mask_$_38,ZeroMask);
	assert { :msg "  388.4: Location might not be writable" } CanWrite(Mask_$_38,this,AVLTreeNode.right);
	assume Heap_$_3 == exhaleHeap#_981_$_0[this,AVLTreeNode.right := r#336_$_0];
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	assume ((0 < methodCallK#_993) && ((1000 * methodCallK#_993) < Fractions(1))) && ((1000 * methodCallK#_993) < methodK#_923);
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	assert { :msg "  390.4: The target of the method call might be null." } !(this == null);
	assert { :msg "  390.4: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive." } methodCallK#_993 > 0;
	assert { :msg "  390.4: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left." } Mask_$_38[this,AVLTreeNode.left][perm$R] > 0;
	assume methodCallK#_993 < Mask_$_38[this,AVLTreeNode.left][perm$R];
	assume exhaleMask#_995_$_0 == Mask_$_38[this,AVLTreeNode.left := Mask_$_38[this,AVLTreeNode.left][perm$R := Mask_$_38[this,AVLTreeNode.left][perm$R] - methodCallK#_993]];
	assume IsGoodMask(exhaleMask#_995_$_0);
	assume wf(Heap_$_3,exhaleMask#_995_$_0,ZeroMask);
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	if ($_$_condition_$60) { goto anon283_Then; } else { goto anon283_Else; }
anon270_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  380.4: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  380.4: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_953_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_953_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_953_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_953_$_18 == exhaleMask#_953_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_953_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_953_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_953_$_18);
	assume wf(Heap_$_2,exhaleMask#_953_$_18,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_19 == exhaleMask#_953_$_18;
	if ($_$_condition_$61) { goto anon271_Then; } else { goto anon271_Else; }
anon270_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_953_$_19 == exhaleMask#_953_$_17;
	if ($_$_condition_$62) { goto anon271_Then; } else { goto anon271_Else; }
anon283_Then:
	assume !(Heap_$_3[this,AVLTreeNode.left] == null);
	assert { :msg "  390.4: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive." } methodCallK#_993 > 0;
	assert { :msg "  390.4: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height." } exhaleMask#_995_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_993 < exhaleMask#_995_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume exhaleMask#_995_$_1 == exhaleMask#_995_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_995_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_995_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - methodCallK#_993]];
	assume IsGoodMask(exhaleMask#_995_$_1);
	assume wf(Heap_$_3,exhaleMask#_995_$_1,ZeroMask);
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	assume exhaleMask#_995_$_2 == exhaleMask#_995_$_1;
	goto anon130;
anon283_Else:
	assume Heap_$_3[this,AVLTreeNode.left] == null;
	assume exhaleMask#_995_$_2 == exhaleMask#_995_$_0;
	goto anon130;
anon271_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  380.4: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  380.4: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_953_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_953_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_953_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_953_$_20 == exhaleMask#_953_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_953_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_953_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_953_$_20);
	assume wf(Heap_$_2,exhaleMask#_953_$_20,ZeroMask);
	assume wf(Heap_$_2,Mask_$_26,ZeroMask);
	assume exhaleMask#_953_$_21 == exhaleMask#_953_$_20;
	goto anon105;
anon271_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_953_$_21 == exhaleMask#_953_$_19;
	goto anon105;
anon130:
	assert { :msg "  390.4: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive." } methodCallK#_993 > 0;
	assert { :msg "  390.4: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right." } exhaleMask#_995_$_2[this,AVLTreeNode.right][perm$R] > 0;
	assume methodCallK#_993 < exhaleMask#_995_$_2[this,AVLTreeNode.right][perm$R];
	assume exhaleMask#_995_$_3 == exhaleMask#_995_$_2[this,AVLTreeNode.right := exhaleMask#_995_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_995_$_2[this,AVLTreeNode.right][perm$R] - methodCallK#_993]];
	assume IsGoodMask(exhaleMask#_995_$_3);
	assume wf(Heap_$_3,exhaleMask#_995_$_3,ZeroMask);
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	if ($_$_condition_$63) { goto anon284_Then; } else { goto anon284_Else; }
anon105:
	assume IsGoodExhaleState(exhaleHeap#_952_$_0,Heap_$_2,exhaleMask#_953_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_953_$_21);
	assume wf(exhaleHeap#_952_$_0,exhaleMask#_953_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_952_$_0,exhaleMask#_953_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_58 == exhaleMask#_953_$_21[this,AVLTreeNode.valid := exhaleMask#_953_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_953_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_58);
	assume IsGoodState(heapFragment(exhaleHeap#_952_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_952_$_0,Mask_$_58,ZeroMask);
	assume wf(exhaleHeap#_952_$_0,Mask_$_58,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_952_$_0,Mask_$_58,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_59 == Mask_$_58[this,AVLTreeNode.height := Mask_$_58[this,AVLTreeNode.height][perm$R := Mask_$_58[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_59);
	assume IsGoodState(heapFragment(exhaleHeap#_952_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_952_$_0,Mask_$_59,ZeroMask);
	assume wf(exhaleHeap#_952_$_0,Mask_$_59,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_952_$_0,Mask_$_59,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_60 == Mask_$_59[this,AVLTreeNode.keys := Mask_$_59[this,AVLTreeNode.keys][perm$R := Mask_$_59[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_60);
	assume IsGoodState(heapFragment(exhaleHeap#_952_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_952_$_0,Mask_$_60,ZeroMask);
	assume wf(exhaleHeap#_952_$_0,Mask_$_60,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_952_$_0,Mask_$_60,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_61 == Mask_$_60[this,AVLTreeNode.balanceFactor := Mask_$_60[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_60[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_61);
	assume IsGoodState(heapFragment(exhaleHeap#_952_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_952_$_0,Mask_$_61,ZeroMask);
	assume wf(exhaleHeap#_952_$_0,Mask_$_61,ZeroMask);
	assume Seq#Equal(exhaleHeap#_952_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_2[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_2[this,AVLTreeNode.key])),ite(Heap_$_2[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_952_$_0[this,AVLTreeNode.height] == ite(ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_952_$_0[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_61);
	assume wf(exhaleHeap#_952_$_0,Mask_$_61,ZeroMask);
	assume wf(exhaleHeap#_952_$_0,Mask_$_61,ZeroMask);
	if ($_$_condition_$64) { goto anon272_Then; } else { goto anon272_Else; }
anon284_Then:
	assume !(Heap_$_3[this,AVLTreeNode.right] == null);
	assert { :msg "  390.4: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive." } methodCallK#_993 > 0;
	assert { :msg "  390.4: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height." } exhaleMask#_995_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_993 < exhaleMask#_995_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume exhaleMask#_995_$_4 == exhaleMask#_995_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_995_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_995_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - methodCallK#_993]];
	assume IsGoodMask(exhaleMask#_995_$_4);
	assume wf(Heap_$_3,exhaleMask#_995_$_4,ZeroMask);
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	assume exhaleMask#_995_$_5 == exhaleMask#_995_$_4;
	if ($_$_condition_$65) { goto anon285_Then; } else { goto anon285_Else; }
anon284_Else:
	assume Heap_$_3[this,AVLTreeNode.right] == null;
	assume exhaleMask#_995_$_5 == exhaleMask#_995_$_3;
	if ($_$_condition_$66) { goto anon285_Then; } else { goto anon285_Else; }
anon272_Then:
	assume !(r#35_$_0 == null);
	assert { :msg "  382.11: Receiver might be null." } (true && (0 <= k#87#333)) ==> (!(r#35_$_0 == null));
	assert { :msg "  382.11: Location might not be readable." } (true && (0 <= k#87#333)) ==> CanRead(Mask_$_61,ZeroMask,r#35_$_0,AVLTreeNode.keys);
	assert { :msg "  382.11: Receiver might be null." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> (!(r#35_$_0 == null));
	assert { :msg "  382.11: Location might not be readable." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> CanRead(Mask_$_61,ZeroMask,r#35_$_0,AVLTreeNode.keys);
	assert { :msg "  382.45: Sequence index might be negative." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> (0 <= k#87#333);
	assert { :msg "  382.45: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]));
	assert { :msg "  382.49: Receiver might be null." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> (!(this == null));
	assert { :msg "  382.49: Location might not be readable." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> CanRead(Mask_$_61,ZeroMask,this,AVLTreeNode.keys);
	assert { :msg "  382.49: Sequence index might be negative." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> (0 <= 0);
	assert { :msg "  382.49: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#87#333)) && (k#87#333 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> (0 < Seq#Length(exhaleHeap#_952_$_0[this,AVLTreeNode.keys]));
	assert { :msg "  382.4: Assertion might not hold. The expression at 382.23 might not evaluate to true." } (forall  k#87#332 : Integer :: ( ((0 <= k#87#332) && (k#87#332 < Seq#Length(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_952_$_0[r#35_$_0,AVLTreeNode.keys],k#87#332) < Seq#Index(exhaleHeap#_952_$_0[this,AVLTreeNode.keys],0)) ));
	goto anon107;
anon272_Else:
	assume r#35_$_0 == null;
	goto anon107;
anon285_Then:
	assume !(Heap_$_3[this,AVLTreeNode.left] == null);
	assert { :msg "  390.4: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  390.4: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_995_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_995_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_995_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_995_$_6 == exhaleMask#_995_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_995_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_995_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$67) { goto anon286_Then; } else { goto anon286_Else; }
anon285_Else:
	assume Heap_$_3[this,AVLTreeNode.left] == null;
	assume exhaleMask#_995_$_7 == exhaleMask#_995_$_5;
	if ($_$_condition_$68) { goto anon287_Then; } else { goto anon287_Else; }
anon107:
	assume IsGoodExhaleState(exhaleHeap#_974_$_0,exhaleHeap#_952_$_0,Mask_$_61,ZeroMask);
	assume IsGoodMask(Mask_$_61);
	assume wf(exhaleHeap#_974_$_0,Mask_$_61,ZeroMask);
	assume Mask_$_62 == Mask_$_61;
	assume Heap_$_5 == exhaleHeap#_952_$_0;
	assume r#35_$_2 == r#35_$_0;
	assume m#36_$_0 == this;
	if ($_$_condition_$69) { goto anon316_Then; } else { goto anon316_Else; }
anon286_Then:
	assume !CanRead(exhaleMask#_995_$_6,ZeroMask,Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_994_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon135;
anon286_Else:
	assume CanRead(exhaleMask#_995_$_6,ZeroMask,Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon135;
anon287_Then:
	assume !(Heap_$_3[this,AVLTreeNode.right] == null);
	assert { :msg "  390.4: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  390.4: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_995_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_995_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_995_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_995_$_8 == exhaleMask#_995_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_995_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_995_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$71) { goto anon288_Then; } else { goto anon288_Else; }
anon287_Else:
	assume Heap_$_3[this,AVLTreeNode.right] == null;
	assume exhaleMask#_995_$_9 == exhaleMask#_995_$_7;
	goto anon140;
anon316_Then:
	assume !(r#35_$_2 == null);
	assert { :msg "  348.2: The postcondition at 358.11 might not hold. The expression at 358.26 might not evaluate to true." } (Heap_$_5[r#35_$_2,AVLTreeNode.height] == Heap[this,AVLTreeNode.height]) || ((Heap_$_5[r#35_$_2,AVLTreeNode.height] + 1) == Heap[this,AVLTreeNode.height]);
	if ($_$_condition_$114) { goto anon317_Then; } else { goto anon317_Else; }
anon316_Else:
	assume r#35_$_2 == null;
	if ($_$_condition_$115) { goto anon317_Then; } else { goto anon317_Else; }
anon135:
	assume IsGoodMask(exhaleMask#_995_$_6);
	assume wf(Heap_$_3,exhaleMask#_995_$_6,ZeroMask);
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	assume exhaleMask#_995_$_7 == exhaleMask#_995_$_6;
	if ($_$_condition_$70) { goto anon287_Then; } else { goto anon287_Else; }
anon288_Then:
	assume !CanRead(exhaleMask#_995_$_8,ZeroMask,Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_994_$_0[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon139;
anon288_Else:
	assume CanRead(exhaleMask#_995_$_8,ZeroMask,Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon139;
anon140:
	assume IsGoodExhaleState(exhaleHeap#_994_$_0,Heap_$_3,exhaleMask#_995_$_9,ZeroMask);
	assume IsGoodMask(exhaleMask#_995_$_9);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_995_$_9,ZeroMask);
	assume true;
	assume !(this == null);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_995_$_9,ZeroMask);
	assume (exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_994_$_0[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume methodCallK#_993 > 0;
	assume Mask_$_39 == exhaleMask#_995_$_9[this,AVLTreeNode.left := exhaleMask#_995_$_9[this,AVLTreeNode.left][perm$R := exhaleMask#_995_$_9[this,AVLTreeNode.left][perm$R] + methodCallK#_993]];
	assume IsGoodMask(Mask_$_39);
	assume IsGoodState(heapFragment(exhaleHeap#_994_$_0[this,AVLTreeNode.left]));
	assume wf(exhaleHeap#_994_$_0,Mask_$_39,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_39,ZeroMask);
	if ($_$_condition_$72) { goto anon289_Then; } else { goto anon289_Else; }
anon139:
	assume IsGoodMask(exhaleMask#_995_$_8);
	assume wf(Heap_$_3,exhaleMask#_995_$_8,ZeroMask);
	assume wf(Heap_$_3,Mask_$_38,ZeroMask);
	assume exhaleMask#_995_$_9 == exhaleMask#_995_$_8;
	goto anon140;
anon289_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_994_$_0,Mask_$_39,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_40 == Mask_$_39[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_39[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_39[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_40);
	assume IsGoodState(heapFragment(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_994_$_0,Mask_$_40,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_40,ZeroMask);
	assume Mask_$_41 == Mask_$_40;
	if ($_$_condition_$73) { goto anon290_Then; } else { goto anon290_Else; }
anon289_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_41 == Mask_$_39;
	if ($_$_condition_$74) { goto anon290_Then; } else { goto anon290_Else; }
anon290_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_994_$_0,Mask_$_41,ZeroMask);
	assume true;
	assume methodCallK#_993 > 0;
	assume Mask_$_42 == Mask_$_41[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_41[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_41[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + methodCallK#_993]];
	assume IsGoodMask(Mask_$_42);
	assume IsGoodState(heapFragment(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_994_$_0,Mask_$_42,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_42,ZeroMask);
	assume Mask_$_43 == Mask_$_42;
	goto anon144;
anon290_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_43 == Mask_$_41;
	goto anon144;
anon144:
	assume !(this == null);
	assume wf(exhaleHeap#_994_$_0,Mask_$_43,ZeroMask);
	assume (exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_994_$_0[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume methodCallK#_993 > 0;
	assume Mask_$_44 == Mask_$_43[this,AVLTreeNode.right := Mask_$_43[this,AVLTreeNode.right][perm$R := Mask_$_43[this,AVLTreeNode.right][perm$R] + methodCallK#_993]];
	assume IsGoodMask(Mask_$_44);
	assume IsGoodState(heapFragment(exhaleHeap#_994_$_0[this,AVLTreeNode.right]));
	assume wf(exhaleHeap#_994_$_0,Mask_$_44,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_44,ZeroMask);
	if ($_$_condition_$75) { goto anon291_Then; } else { goto anon291_Else; }
anon291_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_994_$_0,Mask_$_44,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_45 == Mask_$_44[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_44[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_44[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_45);
	assume IsGoodState(heapFragment(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_994_$_0,Mask_$_45,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_45,ZeroMask);
	assume Mask_$_46 == Mask_$_45;
	if ($_$_condition_$76) { goto anon292_Then; } else { goto anon292_Else; }
anon291_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_46 == Mask_$_44;
	if ($_$_condition_$77) { goto anon292_Then; } else { goto anon292_Else; }
anon292_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_994_$_0,Mask_$_46,ZeroMask);
	assume true;
	assume methodCallK#_993 > 0;
	assume Mask_$_47 == Mask_$_46[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_46[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_46[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + methodCallK#_993]];
	assume IsGoodMask(Mask_$_47);
	assume IsGoodState(heapFragment(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_994_$_0,Mask_$_47,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_47,ZeroMask);
	assume Mask_$_48 == Mask_$_47;
	goto anon148;
anon292_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_48 == Mask_$_46;
	goto anon148;
anon148:
	assume bf#340_$_0 == (ite(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	if ($_$_condition_$78) { goto anon293_Then; } else { goto anon293_Else; }
anon293_Then:
	assume bf#340_$_0 > 0;
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	if ($_$_condition_$79) { goto anon294_Then; } else { goto anon294_Else; }
anon293_Else:
	assume 0 >= bf#340_$_0;
	if ($_$_condition_$80) { goto anon294_Then; } else { goto anon294_Else; }
anon294_Then:
	assume bf#340_$_0 < 0;
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	goto anon152;
anon294_Else:
	assume 0 <= bf#340_$_0;
	goto anon152;
anon152:
	assume IsGoodMask(Mask_$_48);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume cond#_1004_$_0 <==> (bf#340_$_0 == 2);
	if ($_$_condition_$81) { goto anon295_Then; } else { goto anon295_Else; }
anon295_Then:
	assume cond#_1004_$_0;
	assume ((0 < methodCallK#_1009) && ((1000 * methodCallK#_1009) < Fractions(1))) && ((1000 * methodCallK#_1009) < methodK#_923);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The target of the method call might be null." } !(this == null);
	assert { :msg "  392.5: The precondition at 608.12 might not hold. The expression at 608.12 might not evaluate to true." } !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  392.5: The precondition at 613.12 might not hold. The expression at 613.12 might not evaluate to true." } (forall  k#94#343 : Integer :: ( ((0 <= k#94#343) && (k#94#343 < Seq#Length(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#94#343) < exhaleHeap#_994_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$82) { goto anon296_Then; } else { goto anon296_Else; }
anon295_Else:
	assume !cond#_1004_$_0;
	assume ((0 < methodCallK#_1032) && ((1000 * methodCallK#_1032) < Fractions(1))) && ((1000 * methodCallK#_1032) < methodK#_923);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  394.5: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$83) { goto anon303_Then; } else { goto anon303_Else; }
anon296_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  392.5: The precondition at 619.12 might not hold. The expression at 619.28 might not evaluate to true." } (forall  k#95#344 : Integer :: ( ((0 <= k#95#344) && (k#95#344 < Seq#Length(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_994_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#95#344)) ));
	goto anon155;
anon296_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	goto anon155;
anon303_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  394.5: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#348 : Integer :: ( ((0 <= k#92#348) && (k#92#348 < Seq#Length(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#348) < exhaleHeap#_994_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$84) { goto anon304_Then; } else { goto anon304_Else; }
anon303_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null;
	if ($_$_condition_$85) { goto anon304_Then; } else { goto anon304_Else; }
anon155:
	assert { :msg "  392.5: The precondition at 621.12 might not hold. The expression at 621.12 might not evaluate to true." } (exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height] - ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) == 2;
	assert { :msg "  392.5: The precondition at 600.12 might not hold. The permission at 600.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 600.12 might not hold. Insufficient fraction at 600.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_48[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_48[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_48[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_1011_$_0 == Mask_$_48[this,AVLTreeNode.key := Mask_$_48[this,AVLTreeNode.key][perm$R := Mask_$_48[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1011_$_0);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_0,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 601.12 might not hold. The permission at 601.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 601.12 might not hold. Insufficient fraction at 601.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_1011_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_1011_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1011_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1011_$_1 == exhaleMask#_1011_$_0[this,AVLTreeNode.height := exhaleMask#_1011_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_1011_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1011_$_1);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_1,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 602.12 might not hold. The permission at 602.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 602.12 might not hold. Insufficient fraction at 602.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_1011_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_1011_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_1011_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_1011_$_2 == exhaleMask#_1011_$_1[this,AVLTreeNode.left := exhaleMask#_1011_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_1011_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1011_$_2);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_2,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 603.12 might not hold. The permission at 603.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 603.12 might not hold. Insufficient fraction at 603.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_1011_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_1011_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_1011_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_1011_$_3 == exhaleMask#_1011_$_2[this,AVLTreeNode.right := exhaleMask#_1011_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_1011_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1011_$_3);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_3,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 605.12 might not hold. The permission at 605.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 605.12 might not hold. Insufficient fraction at 605.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_1011_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_1011_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1011_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1011_$_4 == exhaleMask#_1011_$_3[this,AVLTreeNode.keys := exhaleMask#_1011_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_1011_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1011_$_4);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_4,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 606.12 might not hold. The permission at 606.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 606.12 might not hold. Insufficient fraction at 606.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_1011_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_1011_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1011_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1011_$_5 == exhaleMask#_1011_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_1011_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1011_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1011_$_5);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_5,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 609.12 might not hold. The permission at 609.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 609.12 might not hold. Insufficient fraction at 609.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1011_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1011_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1011_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1011_$_6 == exhaleMask#_1011_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_1011_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_1011_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$86) { goto anon297_Then; } else { goto anon297_Else; }
anon304_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  394.5: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#349 : Integer :: ( ((0 <= k#93#349) && (k#93#349 < Seq#Length(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_994_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#349)) ));
	goto anon172;
anon304_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	goto anon172;
anon297_Then:
	assume !CanRead(exhaleMask#_1011_$_6,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_1010_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon157;
anon297_Else:
	assume CanRead(exhaleMask#_1011_$_6,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon157;
anon172:
	assert { :msg "  394.5: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  394.5: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  394.5: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_48[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_48[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_48[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_1034_$_0 == Mask_$_48[this,AVLTreeNode.key := Mask_$_48[this,AVLTreeNode.key][perm$R := Mask_$_48[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1034_$_0);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_0,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  394.5: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_1034_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_1034_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1034_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1034_$_1 == exhaleMask#_1034_$_0[this,AVLTreeNode.height := exhaleMask#_1034_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_1034_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1034_$_1);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_1,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  394.5: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_1034_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_1034_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_1034_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_1034_$_2 == exhaleMask#_1034_$_1[this,AVLTreeNode.left := exhaleMask#_1034_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_1034_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1034_$_2);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_2,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  394.5: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_1034_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_1034_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_1034_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_1034_$_3 == exhaleMask#_1034_$_2[this,AVLTreeNode.right := exhaleMask#_1034_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_1034_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1034_$_3);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_3,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  394.5: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_1034_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_1034_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1034_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1034_$_4 == exhaleMask#_1034_$_3[this,AVLTreeNode.keys := exhaleMask#_1034_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_1034_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1034_$_4);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_4,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  394.5: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_1034_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_1034_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1034_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1034_$_5 == exhaleMask#_1034_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_1034_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1034_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1034_$_5);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_5,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	if ($_$_condition_$87) { goto anon305_Then; } else { goto anon305_Else; }
anon157:
	assume IsGoodMask(exhaleMask#_1011_$_6);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_6,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 610.12 might not hold. The permission at 610.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  392.5: The precondition at 610.12 might not hold. Insufficient fraction at 610.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1011_$_6[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1011_$_6[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1011_$_6[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1011_$_7 == exhaleMask#_1011_$_6[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_1011_$_6[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_1011_$_6[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1011_$_7);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_7,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 611.12 might not hold. The permission at 611.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  392.5: The precondition at 611.12 might not hold. Insufficient fraction at 611.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1011_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1011_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1011_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1011_$_8 == exhaleMask#_1011_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_1011_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_1011_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1011_$_8);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_8,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  392.5: The precondition at 612.12 might not hold. The permission at 612.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  392.5: The precondition at 612.12 might not hold. Insufficient fraction at 612.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1011_$_8[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1011_$_8[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1011_$_8[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1011_$_9 == exhaleMask#_1011_$_8[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_1011_$_8[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1011_$_8[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1011_$_9);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_9,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	if ($_$_condition_$88) { goto anon298_Then; } else { goto anon298_Else; }
anon305_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  394.5: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1034_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1034_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1034_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1034_$_6 == exhaleMask#_1034_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_1034_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_1034_$_5[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$89) { goto anon306_Then; } else { goto anon306_Else; }
anon305_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1034_$_7 == exhaleMask#_1034_$_5;
	if ($_$_condition_$90) { goto anon307_Then; } else { goto anon307_Else; }
anon298_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  392.5: The precondition at 615.12 might not hold. The permission at 615.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  392.5: The precondition at 615.12 might not hold. Insufficient fraction at 615.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1011_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1011_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1011_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1011_$_10 == exhaleMask#_1011_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_1011_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_1011_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$91) { goto anon299_Then; } else { goto anon299_Else; }
anon298_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1011_$_11 == exhaleMask#_1011_$_9;
	if ($_$_condition_$92) { goto anon300_Then; } else { goto anon300_Else; }
anon306_Then:
	assume !CanRead(exhaleMask#_1034_$_6,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_1033_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon175;
anon306_Else:
	assume CanRead(exhaleMask#_1034_$_6,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon175;
anon307_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  394.5: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  394.5: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1034_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1034_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1034_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1034_$_8 == exhaleMask#_1034_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_1034_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_1034_$_7[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1034_$_8);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_8,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_9 == exhaleMask#_1034_$_8;
	if ($_$_condition_$95) { goto anon308_Then; } else { goto anon308_Else; }
anon307_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1034_$_9 == exhaleMask#_1034_$_7;
	if ($_$_condition_$96) { goto anon308_Then; } else { goto anon308_Else; }
anon299_Then:
	assume !CanRead(exhaleMask#_1011_$_10,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_1010_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon160;
anon299_Else:
	assume CanRead(exhaleMask#_1011_$_10,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon160;
anon300_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  392.5: The precondition at 616.12 might not hold. The permission at 616.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  392.5: The precondition at 616.12 might not hold. Insufficient fraction at 616.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1011_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1011_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1011_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1011_$_12 == exhaleMask#_1011_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_1011_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_1011_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1011_$_12);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_12,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1011_$_13 == exhaleMask#_1011_$_12;
	if ($_$_condition_$97) { goto anon301_Then; } else { goto anon301_Else; }
anon300_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1011_$_13 == exhaleMask#_1011_$_11;
	if ($_$_condition_$98) { goto anon301_Then; } else { goto anon301_Else; }
anon175:
	assume IsGoodMask(exhaleMask#_1034_$_6);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_6,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_7 == exhaleMask#_1034_$_6;
	if ($_$_condition_$93) { goto anon307_Then; } else { goto anon307_Else; }
anon160:
	assume IsGoodMask(exhaleMask#_1011_$_10);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_10,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1011_$_11 == exhaleMask#_1011_$_10;
	if ($_$_condition_$94) { goto anon300_Then; } else { goto anon300_Else; }
anon308_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  394.5: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  394.5: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1034_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1034_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1034_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1034_$_10 == exhaleMask#_1034_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_1034_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_1034_$_9[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1034_$_10);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_10,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_11 == exhaleMask#_1034_$_10;
	if ($_$_condition_$99) { goto anon309_Then; } else { goto anon309_Else; }
anon308_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1034_$_11 == exhaleMask#_1034_$_9;
	if ($_$_condition_$100) { goto anon309_Then; } else { goto anon309_Else; }
anon301_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  392.5: The precondition at 617.12 might not hold. The permission at 617.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  392.5: The precondition at 617.12 might not hold. Insufficient fraction at 617.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1011_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1011_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1011_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1011_$_14 == exhaleMask#_1011_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_1011_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_1011_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1011_$_14);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_14,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1011_$_15 == exhaleMask#_1011_$_14;
	if ($_$_condition_$101) { goto anon302_Then; } else { goto anon302_Else; }
anon301_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1011_$_15 == exhaleMask#_1011_$_13;
	if ($_$_condition_$102) { goto anon302_Then; } else { goto anon302_Else; }
anon309_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  394.5: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  394.5: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1034_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1034_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1034_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1034_$_12 == exhaleMask#_1034_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_1034_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1034_$_11[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1034_$_12);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_12,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_13 == exhaleMask#_1034_$_12;
	if ($_$_condition_$103) { goto anon310_Then; } else { goto anon310_Else; }
anon309_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1034_$_13 == exhaleMask#_1034_$_11;
	if ($_$_condition_$104) { goto anon310_Then; } else { goto anon310_Else; }
anon302_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  392.5: The precondition at 618.12 might not hold. The permission at 618.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  392.5: The precondition at 618.12 might not hold. Insufficient fraction at 618.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1011_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1011_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1011_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1011_$_16 == exhaleMask#_1011_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_1011_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1011_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1011_$_16);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1011_$_16,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1011_$_17 == exhaleMask#_1011_$_16;
	goto anon167;
anon302_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1011_$_17 == exhaleMask#_1011_$_15;
	goto anon167;
anon310_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  394.5: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  394.5: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1034_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1034_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1034_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1034_$_14 == exhaleMask#_1034_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_1034_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_1034_$_13[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$105) { goto anon311_Then; } else { goto anon311_Else; }
anon310_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1034_$_15 == exhaleMask#_1034_$_13;
	if ($_$_condition_$106) { goto anon312_Then; } else { goto anon312_Else; }
anon167:
	assume IsGoodExhaleState(exhaleHeap#_1010_$_0,exhaleHeap#_994_$_0,exhaleMask#_1011_$_17,ZeroMask);
	assume IsGoodMask(exhaleMask#_1011_$_17);
	assume wf(exhaleHeap#_1010_$_0,exhaleMask#_1011_$_17,ZeroMask);
	assume (r#342_$_0 == null) || (dtype(r#342_$_0) == AVLTreeNode#t);
	assume !(r#342_$_0 == null);
	assume !(r#342_$_0 == null);
	assume wf(exhaleHeap#_1010_$_0,exhaleMask#_1011_$_17,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_53 == exhaleMask#_1011_$_17[r#342_$_0,AVLTreeNode.valid := exhaleMask#_1011_$_17[r#342_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_1011_$_17[r#342_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_53);
	assume IsGoodState(heapFragment(exhaleHeap#_1010_$_0[r#342_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1010_$_0,Mask_$_53,ZeroMask);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_53,ZeroMask);
	assume !(r#342_$_0 == null);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_53,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_54 == Mask_$_53[r#342_$_0,AVLTreeNode.height := Mask_$_53[r#342_$_0,AVLTreeNode.height][perm$R := Mask_$_53[r#342_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_54);
	assume IsGoodState(heapFragment(exhaleHeap#_1010_$_0[r#342_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_1010_$_0,Mask_$_54,ZeroMask);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_54,ZeroMask);
	assume !(r#342_$_0 == null);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_54,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_55 == Mask_$_54[r#342_$_0,AVLTreeNode.keys := Mask_$_54[r#342_$_0,AVLTreeNode.keys][perm$R := Mask_$_54[r#342_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_55);
	assume IsGoodState(heapFragment(exhaleHeap#_1010_$_0[r#342_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1010_$_0,Mask_$_55,ZeroMask);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_55,ZeroMask);
	assume !(r#342_$_0 == null);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_55,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_56 == Mask_$_55[r#342_$_0,AVLTreeNode.balanceFactor := Mask_$_55[r#342_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_55[r#342_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_56);
	assume IsGoodState(heapFragment(exhaleHeap#_1010_$_0[r#342_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1010_$_0,Mask_$_56,ZeroMask);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_56,ZeroMask);
	assume (exhaleHeap#_1010_$_0[r#342_$_0,AVLTreeNode.height] == exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) || (exhaleHeap#_1010_$_0[r#342_$_0,AVLTreeNode.height] == (exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height] + 1));
	assume Seq#Equal(exhaleHeap#_1010_$_0[r#342_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Singleton(exhaleHeap#_994_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume IsGoodMask(Mask_$_56);
	assume wf(exhaleHeap#_1010_$_0,Mask_$_56,ZeroMask);
	assume Mask_$_57 == Mask_$_56;
	assume Heap_$_4 == exhaleHeap#_1010_$_0;
	assume r#35_$_1 == r#342_$_0;
	goto anon193;
anon311_Then:
	assume !CanRead(exhaleMask#_1034_$_14,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_1033_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon185;
anon311_Else:
	assume CanRead(exhaleMask#_1034_$_14,ZeroMask,exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon185;
anon312_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  394.5: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  394.5: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1034_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1034_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1034_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1034_$_16 == exhaleMask#_1034_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_1034_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_1034_$_15[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1034_$_16);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_16,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_17 == exhaleMask#_1034_$_16;
	if ($_$_condition_$108) { goto anon313_Then; } else { goto anon313_Else; }
anon312_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1034_$_17 == exhaleMask#_1034_$_15;
	if ($_$_condition_$109) { goto anon313_Then; } else { goto anon313_Else; }
anon193:
	assume wf(Heap_$_4,Mask_$_57,ZeroMask);
	if ($_$_condition_$112) { goto anon315_Then; } else { goto anon315_Else; }
anon185:
	assume IsGoodMask(exhaleMask#_1034_$_14);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_14,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_15 == exhaleMask#_1034_$_14;
	if ($_$_condition_$107) { goto anon312_Then; } else { goto anon312_Else; }
anon313_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  394.5: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  394.5: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1034_$_17[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1034_$_17[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1034_$_17[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1034_$_18 == exhaleMask#_1034_$_17[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_1034_$_17[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_1034_$_17[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1034_$_18);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_18,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_19 == exhaleMask#_1034_$_18;
	if ($_$_condition_$110) { goto anon314_Then; } else { goto anon314_Else; }
anon313_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1034_$_19 == exhaleMask#_1034_$_17;
	if ($_$_condition_$111) { goto anon314_Then; } else { goto anon314_Else; }
anon314_Then:
	assume !(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  394.5: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  394.5: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1034_$_19[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1034_$_19[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1034_$_19[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1034_$_20 == exhaleMask#_1034_$_19[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_1034_$_19[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1034_$_19[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1034_$_20);
	assume wf(exhaleHeap#_994_$_0,exhaleMask#_1034_$_20,ZeroMask);
	assume wf(exhaleHeap#_994_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_1034_$_21 == exhaleMask#_1034_$_20;
	goto anon192;
anon314_Else:
	assume exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1034_$_21 == exhaleMask#_1034_$_19;
	goto anon192;
anon192:
	assume IsGoodExhaleState(exhaleHeap#_1033_$_0,exhaleHeap#_994_$_0,exhaleMask#_1034_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_1034_$_21);
	assume wf(exhaleHeap#_1033_$_0,exhaleMask#_1034_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_1033_$_0,exhaleMask#_1034_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_49 == exhaleMask#_1034_$_21[this,AVLTreeNode.valid := exhaleMask#_1034_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_1034_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_49);
	assume IsGoodState(heapFragment(exhaleHeap#_1033_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1033_$_0,Mask_$_49,ZeroMask);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_49,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_49,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_50 == Mask_$_49[this,AVLTreeNode.height := Mask_$_49[this,AVLTreeNode.height][perm$R := Mask_$_49[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_50);
	assume IsGoodState(heapFragment(exhaleHeap#_1033_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_1033_$_0,Mask_$_50,ZeroMask);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_50,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_50,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_51 == Mask_$_50[this,AVLTreeNode.keys := Mask_$_50[this,AVLTreeNode.keys][perm$R := Mask_$_50[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_51);
	assume IsGoodState(heapFragment(exhaleHeap#_1033_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_1033_$_0,Mask_$_51,ZeroMask);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_51,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_51,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_52 == Mask_$_51[this,AVLTreeNode.balanceFactor := Mask_$_51[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_51[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_52);
	assume IsGoodState(heapFragment(exhaleHeap#_1033_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_1033_$_0,Mask_$_52,ZeroMask);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_52,ZeroMask);
	assume Seq#Equal(exhaleHeap#_1033_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_994_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_1033_$_0[this,AVLTreeNode.height] == ite(ite(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1033_$_0[this,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_994_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_994_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_994_$_0[exhaleHeap#_994_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_52);
	assume wf(exhaleHeap#_1033_$_0,Mask_$_52,ZeroMask);
	assume Mask_$_57 == Mask_$_52;
	assume Heap_$_4 == exhaleHeap#_1033_$_0;
	assume r#35_$_1 == this;
	goto anon193;
anon315_Then:
	assume !(r#35_$_1 == null);
	assert { :msg "  397.11: Receiver might be null." } (true && (0 <= k#88#353)) ==> (!(r#35_$_1 == null));
	assert { :msg "  397.11: Location might not be readable." } (true && (0 <= k#88#353)) ==> CanRead(Mask_$_57,ZeroMask,r#35_$_1,AVLTreeNode.keys);
	assert { :msg "  397.11: Receiver might be null." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> (!(r#35_$_1 == null));
	assert { :msg "  397.11: Location might not be readable." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> CanRead(Mask_$_57,ZeroMask,r#35_$_1,AVLTreeNode.keys);
	assert { :msg "  397.45: Sequence index might be negative." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> (0 <= k#88#353);
	assert { :msg "  397.45: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]));
	assert { :msg "  397.49: Receiver might be null." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> (!(m#337_$_0 == null));
	assert { :msg "  397.49: Location might not be readable." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> CanRead(Mask_$_57,ZeroMask,m#337_$_0,AVLTreeNode.keys);
	assert { :msg "  397.49: Sequence index might be negative." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> (0 <= 0);
	assert { :msg "  397.49: Sequence index might be larger than or equal to the length of the sequence." } ((true && (0 <= k#88#353)) && (k#88#353 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> (0 < Seq#Length(Heap_$_4[m#337_$_0,AVLTreeNode.keys]));
	assert { :msg "  397.4: Assertion might not hold. The expression at 397.23 might not evaluate to true." } (forall  k#88#352 : Integer :: ( ((0 <= k#88#352) && (k#88#352 < Seq#Length(Heap_$_4[r#35_$_1,AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_4[r#35_$_1,AVLTreeNode.keys],k#88#352) < Seq#Index(Heap_$_4[m#337_$_0,AVLTreeNode.keys],0)) ));
	goto anon195;
anon315_Else:
	assume r#35_$_1 == null;
	goto anon195;
anon195:
	assume IsGoodExhaleState(exhaleHeap#_1055_$_0,Heap_$_4,Mask_$_57,ZeroMask);
	assume IsGoodMask(Mask_$_57);
	assume wf(exhaleHeap#_1055_$_0,Mask_$_57,ZeroMask);
	assume Mask_$_62 == Mask_$_57;
	assume Heap_$_5 == Heap_$_4;
	assume r#35_$_2 == r#35_$_1;
	assume m#36_$_0 == m#337_$_0;
	if ($_$_condition_$113) { goto anon316_Then; } else { goto anon316_Else; }
anon317_Then:
	assume !(r#35_$_2 == null);
	assert { :msg "  348.2: The postcondition at 359.11 might not hold. The expression at 359.24 might not evaluate to true." } (Seq#Length(Heap_$_5[r#35_$_2,AVLTreeNode.keys]) + 1) == Seq#Length(Heap[this,AVLTreeNode.keys]);
	if ($_$_condition_$116) { goto anon318_Then; } else { goto anon318_Else; }
anon317_Else:
	assume r#35_$_2 == null;
	if ($_$_condition_$117) { goto anon318_Then; } else { goto anon318_Else; }
anon318_Then:
	assume Heap[this,AVLTreeNode.height] > 1;
	assert { :msg "  348.2: The postcondition at 360.11 might not hold. The expression at 360.30 might not evaluate to true." } !(r#35_$_2 == null);
	if ($_$_condition_$118) { goto anon319_Then; } else { goto anon319_Else; }
anon318_Else:
	assume 1 >= Heap[this,AVLTreeNode.height];
	if ($_$_condition_$119) { goto anon319_Then; } else { goto anon319_Else; }
anon319_Then:
	assume Heap[this,AVLTreeNode.height] == 1;
	assert { :msg "  348.2: The postcondition at 361.11 might not hold. The expression at 361.30 might not evaluate to true." } r#35_$_2 == null;
	goto anon204;
anon319_Else:
	assume !(Heap[this,AVLTreeNode.height] == 1);
	goto anon204;
anon204:
	assert { :msg "  348.2: The postcondition at 362.11 might not hold. The expression at 362.11 might not evaluate to true." } (Heap[this,AVLTreeNode.height] == ite(r#35_$_2 == null,0,Heap_$_5[r#35_$_2,AVLTreeNode.height])) || (Heap[this,AVLTreeNode.height] == (ite(r#35_$_2 == null,0,Heap_$_5[r#35_$_2,AVLTreeNode.height]) + 1));
	assert { :msg "  348.2: The postcondition at 364.11 might not hold. The expression at 364.11 might not evaluate to true." } !(m#36_$_0 == null);
	assert { :msg "  348.2: The postcondition at 369.11 might not hold. The expression at 369.11 might not evaluate to true." } Heap_$_5[m#36_$_0,AVLTreeNode.height] == 1;
	assert { :msg "  348.2: The postcondition at 370.11 might not hold. The expression at 370.11 might not evaluate to true." } Seq#Length(Heap_$_5[m#36_$_0,AVLTreeNode.keys]) == 1;
	assert { :msg "  348.2: The postcondition at 372.11 might not hold. The expression at 372.11 might not evaluate to true." } Seq#Equal(Seq#Append(ite(r#35_$_2 == null,(Seq#Empty() : Seq (Integer) ),Heap_$_5[r#35_$_2,AVLTreeNode.keys]),Heap_$_5[m#36_$_0,AVLTreeNode.keys]),Heap[this,AVLTreeNode.keys]);
	if ($_$_condition_$120) { goto anon320_Then; } else { goto anon320_Else; }
anon320_Then:
	assume !(r#35_$_2 == null);
	assert { :msg "  348.2: The postcondition at 373.11 might not hold. The expression at 373.23 might not evaluate to true." } (forall  k#86#355 : Integer :: ( ((0 <= k#86#355) && (k#86#355 < Seq#Length(Heap_$_5[r#35_$_2,AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_5[r#35_$_2,AVLTreeNode.keys],k#86#355) < Seq#Index(Heap_$_5[m#36_$_0,AVLTreeNode.keys],0)) ));
	if ($_$_condition_$121) { goto anon321_Then; } else { goto anon321_Else; }
anon320_Else:
	assume r#35_$_2 == null;
	if ($_$_condition_$122) { goto anon321_Then; } else { goto anon321_Else; }
anon321_Then:
	assume !(r#35_$_2 == null);
	assert { :msg "  348.2: The postcondition at 354.11 might not hold. The permission at 354.25 might not be positive." } Fractions(100) > 0;
	assert { :msg "  348.2: The postcondition at 354.11 might not hold. Insufficient fraction at 354.25 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_62[r#35_$_2,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_62[r#35_$_2,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_62[r#35_$_2,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1058_$_0 == Mask_$_62[r#35_$_2,AVLTreeNode.valid := Mask_$_62[r#35_$_2,AVLTreeNode.valid][perm$R := Mask_$_62[r#35_$_2,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$123) { goto anon322_Then; } else { goto anon322_Else; }
anon321_Else:
	assume r#35_$_2 == null;
	assume exhaleMask#_1058_$_1 == Mask_$_62;
	if ($_$_condition_$124) { goto anon323_Then; } else { goto anon323_Else; }
anon322_Then:
	assume !CanRead(exhaleMask#_1058_$_0,ZeroMask,r#35_$_2,AVLTreeNode.valid);
	assume Heap_$_5[r#35_$_2,AVLTreeNode.valid] < exhaleHeap#_1057_$_0[r#35_$_2,AVLTreeNode.valid];
	goto anon209;
anon322_Else:
	assume CanRead(exhaleMask#_1058_$_0,ZeroMask,r#35_$_2,AVLTreeNode.valid);
	goto anon209;
anon323_Then:
	assume !(r#35_$_2 == null);
	assert { :msg "  348.2: The postcondition at 355.11 might not hold. The permission at 355.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  348.2: The postcondition at 355.11 might not hold. Insufficient fraction at 355.25 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1058_$_1[r#35_$_2,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1058_$_1[r#35_$_2,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1058_$_1[r#35_$_2,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1058_$_2 == exhaleMask#_1058_$_1[r#35_$_2,AVLTreeNode.keys := exhaleMask#_1058_$_1[r#35_$_2,AVLTreeNode.keys][perm$R := exhaleMask#_1058_$_1[r#35_$_2,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1058_$_2);
	assume wf(Heap_$_5,exhaleMask#_1058_$_2,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assume exhaleMask#_1058_$_3 == exhaleMask#_1058_$_2;
	if ($_$_condition_$126) { goto anon324_Then; } else { goto anon324_Else; }
anon323_Else:
	assume r#35_$_2 == null;
	assume exhaleMask#_1058_$_3 == exhaleMask#_1058_$_1;
	if ($_$_condition_$127) { goto anon324_Then; } else { goto anon324_Else; }
anon209:
	assume IsGoodMask(exhaleMask#_1058_$_0);
	assume wf(Heap_$_5,exhaleMask#_1058_$_0,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assume exhaleMask#_1058_$_1 == exhaleMask#_1058_$_0;
	if ($_$_condition_$125) { goto anon323_Then; } else { goto anon323_Else; }
anon324_Then:
	assume !(r#35_$_2 == null);
	assert { :msg "  348.2: The postcondition at 356.11 might not hold. The permission at 356.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  348.2: The postcondition at 356.11 might not hold. Insufficient fraction at 356.25 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1058_$_3[r#35_$_2,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1058_$_3[r#35_$_2,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1058_$_3[r#35_$_2,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1058_$_4 == exhaleMask#_1058_$_3[r#35_$_2,AVLTreeNode.height := exhaleMask#_1058_$_3[r#35_$_2,AVLTreeNode.height][perm$R := exhaleMask#_1058_$_3[r#35_$_2,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1058_$_4);
	assume wf(Heap_$_5,exhaleMask#_1058_$_4,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assume exhaleMask#_1058_$_5 == exhaleMask#_1058_$_4;
	if ($_$_condition_$128) { goto anon325_Then; } else { goto anon325_Else; }
anon324_Else:
	assume r#35_$_2 == null;
	assume exhaleMask#_1058_$_5 == exhaleMask#_1058_$_3;
	if ($_$_condition_$129) { goto anon325_Then; } else { goto anon325_Else; }
anon325_Then:
	assume !(r#35_$_2 == null);
	assert { :msg "  348.2: The postcondition at 357.11 might not hold. The permission at 357.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  348.2: The postcondition at 357.11 might not hold. Insufficient fraction at 357.25 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1058_$_5[r#35_$_2,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1058_$_5[r#35_$_2,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1058_$_5[r#35_$_2,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1058_$_6 == exhaleMask#_1058_$_5[r#35_$_2,AVLTreeNode.balanceFactor := exhaleMask#_1058_$_5[r#35_$_2,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1058_$_5[r#35_$_2,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1058_$_6);
	assume wf(Heap_$_5,exhaleMask#_1058_$_6,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assume exhaleMask#_1058_$_7 == exhaleMask#_1058_$_6;
	goto anon216;
anon325_Else:
	assume r#35_$_2 == null;
	assume exhaleMask#_1058_$_7 == exhaleMask#_1058_$_5;
	goto anon216;
anon216:
	assert { :msg "  348.2: The postcondition at 365.11 might not hold. The permission at 365.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  348.2: The postcondition at 365.11 might not hold. Insufficient fraction at 365.11 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1058_$_7[m#36_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1058_$_7[m#36_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1058_$_7[m#36_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1058_$_8 == exhaleMask#_1058_$_7[m#36_$_0,AVLTreeNode.valid := exhaleMask#_1058_$_7[m#36_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_1058_$_7[m#36_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$130) { goto anon326_Then; } else { goto anon326_Else; }
anon326_Then:
	assume !CanRead(exhaleMask#_1058_$_8,ZeroMask,m#36_$_0,AVLTreeNode.valid);
	assume Heap_$_5[m#36_$_0,AVLTreeNode.valid] < exhaleHeap#_1057_$_0[m#36_$_0,AVLTreeNode.valid];
	goto anon218;
anon326_Else:
	assume CanRead(exhaleMask#_1058_$_8,ZeroMask,m#36_$_0,AVLTreeNode.valid);
	goto anon218;
anon218:
	assume IsGoodMask(exhaleMask#_1058_$_8);
	assume wf(Heap_$_5,exhaleMask#_1058_$_8,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assert { :msg "  348.2: The postcondition at 366.11 might not hold. The permission at 366.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  348.2: The postcondition at 366.11 might not hold. Insufficient fraction at 366.11 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1058_$_8[m#36_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1058_$_8[m#36_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1058_$_8[m#36_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1058_$_9 == exhaleMask#_1058_$_8[m#36_$_0,AVLTreeNode.keys := exhaleMask#_1058_$_8[m#36_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_1058_$_8[m#36_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1058_$_9);
	assume wf(Heap_$_5,exhaleMask#_1058_$_9,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assert { :msg "  348.2: The postcondition at 367.11 might not hold. The permission at 367.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  348.2: The postcondition at 367.11 might not hold. Insufficient fraction at 367.11 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1058_$_9[m#36_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1058_$_9[m#36_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1058_$_9[m#36_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1058_$_10 == exhaleMask#_1058_$_9[m#36_$_0,AVLTreeNode.height := exhaleMask#_1058_$_9[m#36_$_0,AVLTreeNode.height][perm$R := exhaleMask#_1058_$_9[m#36_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1058_$_10);
	assume wf(Heap_$_5,exhaleMask#_1058_$_10,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assert { :msg "  348.2: The postcondition at 368.11 might not hold. The permission at 368.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  348.2: The postcondition at 368.11 might not hold. Insufficient fraction at 368.11 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1058_$_10[m#36_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1058_$_10[m#36_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1058_$_10[m#36_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1058_$_11 == exhaleMask#_1058_$_10[m#36_$_0,AVLTreeNode.balanceFactor := exhaleMask#_1058_$_10[m#36_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1058_$_10[m#36_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1058_$_11);
	assume wf(Heap_$_5,exhaleMask#_1058_$_11,ZeroMask);
	assume wf(Heap_$_5,Mask_$_62,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_1057_$_0,Heap_$_5,exhaleMask#_1058_$_11,ZeroMask);
	assume IsGoodMask(exhaleMask#_1058_$_11);
	assume wf(exhaleHeap#_1057_$_0,exhaleMask#_1058_$_11,ZeroMask);
	assert { :msg "  348.2: Method might lock/unlock more than allowed." } (forall  lk#_1067 : ref :: {exhaleHeap#_1057_$_0[lk#_1067,held]} {exhaleHeap#_1057_$_0[lk#_1067,rdheld]} ( (((0 < exhaleHeap#_1057_$_0[lk#_1067,held]) <==> (0 < Heap[lk#_1067,held])) && (exhaleHeap#_1057_$_0[lk#_1067,rdheld] <==> Heap[lk#_1067,rdheld])) || false ));
	assert { :msg "  348.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
