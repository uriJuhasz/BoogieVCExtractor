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
procedure AVLTreeNode.close (this : ref)
{
	var methodK#_1603 : int;
	var lh#60 : int;
	var rh#62 : int;
	var assertHeap#_1604 : HeapType;
	var assertMask#_1605 : MaskType;
	var assertSecMask#_1606 : MaskType;
	var assertCredits#_1607 : CreditsType;
	var exhaleMask#_1609 : MaskType;
	var exhaleHeap#_1608 : HeapType;
	var unfoldingK#_1615 : int;
	var predFlag#_1614 : bool;
	var unfoldingHeap#_1610 : HeapType;
	var unfoldingMask#_1611 : MaskType;
	var unfoldingSecMask#_1612 : MaskType;
	var unfoldingCredits#_1613 : CreditsType;
	var oldVers#_1635 : int;
	var newVers#_1636 : int;
	var assertHeap#_1653 : HeapType;
	var assertMask#_1654 : MaskType;
	var assertSecMask#_1655 : MaskType;
	var assertCredits#_1656 : CreditsType;
	var exhaleMask#_1658 : MaskType;
	var exhaleHeap#_1657 : HeapType;
	var unfoldingK#_1664 : int;
	var predFlag#_1663 : bool;
	var unfoldingHeap#_1659 : HeapType;
	var unfoldingMask#_1660 : MaskType;
	var unfoldingSecMask#_1661 : MaskType;
	var unfoldingCredits#_1662 : CreditsType;
	var oldVers#_1684 : int;
	var newVers#_1685 : int;
	var assertHeap#_1702 : HeapType;
	var assertMask#_1703 : MaskType;
	var assertSecMask#_1704 : MaskType;
	var assertCredits#_1705 : CreditsType;
	var exhaleMask#_1707 : MaskType;
	var exhaleHeap#_1706 : HeapType;
	var foldK#_1711 : int;
	var exhaleMask#_1713 : MaskType;
	var exhaleHeap#_1712 : HeapType;
	var predRec#_1708 : ref;
	var predVer#_1709 : int;
	var predFlag#_1710 : bool;
	var exhaleMask#_1729 : MaskType;
	var exhaleHeap#_1728 : HeapType;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var Mask_$_3 : MaskType;
	var Mask_$_4 : MaskType;
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
	var lh#60_$_0 : int;
	var rh#62_$_0 : int;
	var exhaleHeap#_1608_$_0 : HeapType;
	var unfoldingMask#_1611_$_0 : MaskType;
	var oldVers#_1635_$_0 : int;
	var newVers#_1636_$_0 : int;
	var unfoldingHeap#_1610_$_0 : HeapType;
	var unfoldingHeap#_1610_$_1 : HeapType;
	var unfoldingMask#_1611_$_1 : MaskType;
	var unfoldingMask#_1611_$_2 : MaskType;
	var unfoldingMask#_1611_$_3 : MaskType;
	var unfoldingMask#_1611_$_4 : MaskType;
	var unfoldingMask#_1611_$_5 : MaskType;
	var unfoldingMask#_1611_$_6 : MaskType;
	var unfoldingMask#_1611_$_7 : MaskType;
	var unfoldingMask#_1611_$_8 : MaskType;
	var unfoldingMask#_1611_$_9 : MaskType;
	var unfoldingMask#_1611_$_10 : MaskType;
	var unfoldingMask#_1611_$_11 : MaskType;
	var unfoldingMask#_1611_$_12 : MaskType;
	var unfoldingMask#_1611_$_13 : MaskType;
	var unfoldingMask#_1611_$_14 : MaskType;
	var unfoldingMask#_1611_$_15 : MaskType;
	var unfoldingMask#_1611_$_16 : MaskType;
	var unfoldingMask#_1611_$_17 : MaskType;
	var unfoldingMask#_1611_$_18 : MaskType;
	var unfoldingMask#_1611_$_19 : MaskType;
	var unfoldingMask#_1611_$_20 : MaskType;
	var unfoldingMask#_1611_$_21 : MaskType;
	var unfoldingMask#_1611_$_22 : MaskType;
	var assertSecMask#_1606_$_0 : MaskType;
	var assertSecMask#_1606_$_1 : MaskType;
	var assertSecMask#_1606_$_2 : MaskType;
	var assertSecMask#_1606_$_3 : MaskType;
	var assertSecMask#_1606_$_4 : MaskType;
	var assertSecMask#_1606_$_5 : MaskType;
	var assertSecMask#_1606_$_6 : MaskType;
	var assertSecMask#_1606_$_7 : MaskType;
	var assertSecMask#_1606_$_8 : MaskType;
	var assertSecMask#_1606_$_9 : MaskType;
	var assertSecMask#_1606_$_10 : MaskType;
	var assertSecMask#_1606_$_11 : MaskType;
	var assertSecMask#_1606_$_12 : MaskType;
	var assertSecMask#_1606_$_13 : MaskType;
	var assertSecMask#_1606_$_14 : MaskType;
	var assertSecMask#_1606_$_15 : MaskType;
	var assertSecMask#_1606_$_16 : MaskType;
	var assertSecMask#_1606_$_17 : MaskType;
	var assertSecMask#_1606_$_18 : MaskType;
	var assertSecMask#_1606_$_19 : MaskType;
	var assertSecMask#_1606_$_20 : MaskType;
	var assertSecMask#_1606_$_21 : MaskType;
	var assertSecMask#_1606_$_22 : MaskType;
	var exhaleHeap#_1657_$_0 : HeapType;
	var unfoldingMask#_1660_$_0 : MaskType;
	var oldVers#_1684_$_0 : int;
	var newVers#_1685_$_0 : int;
	var unfoldingHeap#_1659_$_0 : HeapType;
	var unfoldingHeap#_1659_$_1 : HeapType;
	var unfoldingMask#_1660_$_1 : MaskType;
	var unfoldingMask#_1660_$_2 : MaskType;
	var unfoldingMask#_1660_$_3 : MaskType;
	var unfoldingMask#_1660_$_4 : MaskType;
	var unfoldingMask#_1660_$_5 : MaskType;
	var unfoldingMask#_1660_$_6 : MaskType;
	var unfoldingMask#_1660_$_7 : MaskType;
	var unfoldingMask#_1660_$_8 : MaskType;
	var unfoldingMask#_1660_$_9 : MaskType;
	var unfoldingMask#_1660_$_10 : MaskType;
	var unfoldingMask#_1660_$_11 : MaskType;
	var unfoldingMask#_1660_$_12 : MaskType;
	var unfoldingMask#_1660_$_13 : MaskType;
	var unfoldingMask#_1660_$_14 : MaskType;
	var unfoldingMask#_1660_$_15 : MaskType;
	var unfoldingMask#_1660_$_16 : MaskType;
	var unfoldingMask#_1660_$_17 : MaskType;
	var unfoldingMask#_1660_$_18 : MaskType;
	var unfoldingMask#_1660_$_19 : MaskType;
	var unfoldingMask#_1660_$_20 : MaskType;
	var unfoldingMask#_1660_$_21 : MaskType;
	var unfoldingMask#_1660_$_22 : MaskType;
	var assertSecMask#_1655_$_0 : MaskType;
	var assertSecMask#_1655_$_1 : MaskType;
	var assertSecMask#_1655_$_2 : MaskType;
	var assertSecMask#_1655_$_3 : MaskType;
	var assertSecMask#_1655_$_4 : MaskType;
	var assertSecMask#_1655_$_5 : MaskType;
	var assertSecMask#_1655_$_6 : MaskType;
	var assertSecMask#_1655_$_7 : MaskType;
	var assertSecMask#_1655_$_8 : MaskType;
	var assertSecMask#_1655_$_9 : MaskType;
	var assertSecMask#_1655_$_10 : MaskType;
	var assertSecMask#_1655_$_11 : MaskType;
	var assertSecMask#_1655_$_12 : MaskType;
	var assertSecMask#_1655_$_13 : MaskType;
	var assertSecMask#_1655_$_14 : MaskType;
	var assertSecMask#_1655_$_15 : MaskType;
	var assertSecMask#_1655_$_16 : MaskType;
	var assertSecMask#_1655_$_17 : MaskType;
	var assertSecMask#_1655_$_18 : MaskType;
	var assertSecMask#_1655_$_19 : MaskType;
	var assertSecMask#_1655_$_20 : MaskType;
	var assertSecMask#_1655_$_21 : MaskType;
	var assertSecMask#_1655_$_22 : MaskType;
	var Heap_$_0 : HeapType;
	var Heap_$_1 : HeapType;
	var Heap_$_2 : HeapType;
	var exhaleHeap#_1706_$_0 : HeapType;
	var exhaleHeap#_1712_$_0 : HeapType;
	var exhaleMask#_1713_$_0 : MaskType;
	var SecMask_$_0 : MaskType;
	var exhaleMask#_1713_$_1 : MaskType;
	var SecMask_$_1 : MaskType;
	var exhaleMask#_1713_$_2 : MaskType;
	var SecMask_$_2 : MaskType;
	var exhaleMask#_1713_$_3 : MaskType;
	var SecMask_$_3 : MaskType;
	var exhaleMask#_1713_$_4 : MaskType;
	var SecMask_$_4 : MaskType;
	var exhaleMask#_1713_$_5 : MaskType;
	var SecMask_$_5 : MaskType;
	var exhaleMask#_1713_$_6 : MaskType;
	var SecMask_$_6 : MaskType;
	var SecMask_$_7 : MaskType;
	var exhaleMask#_1713_$_7 : MaskType;
	var exhaleMask#_1713_$_8 : MaskType;
	var SecMask_$_8 : MaskType;
	var exhaleMask#_1713_$_9 : MaskType;
	var SecMask_$_9 : MaskType;
	var exhaleMask#_1713_$_10 : MaskType;
	var SecMask_$_10 : MaskType;
	var SecMask_$_11 : MaskType;
	var exhaleMask#_1713_$_11 : MaskType;
	var exhaleMask#_1713_$_12 : MaskType;
	var SecMask_$_12 : MaskType;
	var exhaleMask#_1713_$_13 : MaskType;
	var SecMask_$_13 : MaskType;
	var exhaleMask#_1713_$_14 : MaskType;
	var SecMask_$_14 : MaskType;
	var SecMask_$_15 : MaskType;
	var exhaleMask#_1713_$_15 : MaskType;
	var exhaleMask#_1713_$_16 : MaskType;
	var SecMask_$_16 : MaskType;
	var exhaleMask#_1713_$_17 : MaskType;
	var SecMask_$_17 : MaskType;
	var exhaleMask#_1713_$_18 : MaskType;
	var SecMask_$_18 : MaskType;
	var SecMask_$_19 : MaskType;
	var exhaleMask#_1713_$_19 : MaskType;
	var exhaleMask#_1713_$_20 : MaskType;
	var SecMask_$_20 : MaskType;
	var exhaleMask#_1713_$_21 : MaskType;
	var SecMask_$_21 : MaskType;
	var Mask_$_22 : MaskType;
	var predVer#_1709_$_0 : int;
	var exhaleHeap#_1728_$_0 : HeapType;
	var exhaleMask#_1729_$_0 : MaskType;
	var SecMask_$_22 : MaskType;
	var SecMask_$_23 : MaskType;
	var SecMask_$_24 : MaskType;
	var SecMask_$_25 : MaskType;
	var SecMask_$_26 : MaskType;
	var SecMask_$_27 : MaskType;
	var SecMask_$_28 : MaskType;
	var SecMask_$_29 : MaskType;
	var SecMask_$_30 : MaskType;
	var SecMask_$_31 : MaskType;
	var SecMask_$_32 : MaskType;
	var SecMask_$_33 : MaskType;
	var SecMask_$_34 : MaskType;
	var SecMask_$_35 : MaskType;
	var SecMask_$_36 : MaskType;
	var SecMask_$_37 : MaskType;
	var SecMask_$_38 : MaskType;
	var SecMask_$_39 : MaskType;
	var SecMask_$_40 : MaskType;
	var SecMask_$_41 : MaskType;
	var SecMask_$_42 : MaskType;
	var SecMask_$_43 : MaskType;
	var SecMask_$_44 : MaskType;
	var SecMask_$_45 : MaskType;
	var SecMask_$_46 : MaskType;
	var SecMask_$_47 : MaskType;
	var SecMask_$_48 : MaskType;
	var SecMask_$_49 : MaskType;
	var SecMask_$_50 : MaskType;
	var SecMask_$_51 : MaskType;
	var SecMask_$_52 : MaskType;
	var SecMask_$_53 : MaskType;
	var SecMask_$_54 : MaskType;
	var SecMask_$_55 : MaskType;
	var SecMask_$_56 : MaskType;
	var SecMask_$_57 : MaskType;
	var SecMask_$_58 : MaskType;
	var SecMask_$_59 : MaskType;
	var SecMask_$_60 : MaskType;
	var SecMask_$_61 : MaskType;
	var SecMask_$_62 : MaskType;
	var SecMask_$_63 : MaskType;
	var SecMask_$_64 : MaskType;
	var SecMask_$_65 : MaskType;
	var SecMask_$_66 : MaskType;
	var SecMask_$_67 : MaskType;
	var SecMask_$_68 : MaskType;
	var SecMask_$_69 : MaskType;
	var SecMask_$_70 : MaskType;
	var SecMask_$_71 : MaskType;
	var SecMask_$_72 : MaskType;
	var exhaleMask#_1729_$_1 : MaskType;
	var exhaleMask#_1729_$_2 : MaskType;
	var exhaleMask#_1729_$_3 : MaskType;
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
	var $_$_condition_$159 : bool;
	var $_$_condition_$160 : bool;
	var $_$_condition_$161 : bool;
	var $_$_condition_$162 : bool;
	var $_$_condition_$163 : bool;
	var $_$_condition_$164 : bool;
	var $_$_condition_$165 : bool;
	var $_$_condition_$166 : bool;
	var $_$_condition_$167 : bool;
	var $_$_condition_$168 : bool;
	var $_$_condition_$169 : bool;
	var $_$_condition_$170 : bool;
	var $_$_condition_$171 : bool;
	var $_$_condition_$172 : bool;
	var $_$_condition_$173 : bool;
	var $_$_condition_$174 : bool;
	var $_$_condition_$175 : bool;
	var $_$_condition_$176 : bool;
	var $_$_condition_$177 : bool;
	var $_$_condition_$178 : bool;
	var $_$_condition_$179 : bool;
	var $_$_condition_$180 : bool;
	var $_$_condition_$181 : bool;
	var $_$_condition_$182 : bool;
	var $_$_condition_$183 : bool;
	var $_$_condition_$184 : bool;
	var $_$_condition_$185 : bool;
	var $_$_condition_$186 : bool;
	var $_$_condition_$187 : bool;
	var $_$_condition_$188 : bool;
	var $_$_condition_$189 : bool;
	var $_$_condition_$190 : bool;
	var $_$_condition_$191 : bool;
	var $_$_condition_$192 : bool;
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
	assume true;
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_1603) && ((1000 * methodK#_1603) < Fractions(1));
	assume CurrentModule == module#default;
	assume CanAssumeFunctionDefs;
	assume !(this == null);
	assume wf(Heap,ZeroMask,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,AVLTreeNode.key := ZeroMask[this,AVLTreeNode.key][perm$R := ZeroMask[this,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.key]));
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_1 == Mask_$_0[this,AVLTreeNode.height := Mask_$_0[this,AVLTreeNode.height][perm$R := Mask_$_0[this,AVLTreeNode.height][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.height]));
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume (Heap[this,AVLTreeNode.left] == null) || (dtype(Heap[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_2 == Mask_$_1[this,AVLTreeNode.left := Mask_$_1[this,AVLTreeNode.left][perm$R := Mask_$_1[this,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_2);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.left]));
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_2,ZeroMask);
	assume (Heap[this,AVLTreeNode.right] == null) || (dtype(Heap[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_3 == Mask_$_2[this,AVLTreeNode.right := Mask_$_2[this,AVLTreeNode.right][perm$R := Mask_$_2[this,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_3);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.right]));
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_3,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_4 == Mask_$_3[this,AVLTreeNode.keys := Mask_$_3[this,AVLTreeNode.keys][perm$R := Mask_$_3[this,AVLTreeNode.keys][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_4);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_4,ZeroMask);
	assume wf(Heap,Mask_$_4,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_4,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_5 == Mask_$_4[this,AVLTreeNode.balanceFactor := Mask_$_4[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_4[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_5);
	assume IsGoodState(heapFragment(Heap[this,AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_5,ZeroMask);
	assume wf(Heap,Mask_$_5,ZeroMask);
	if ($_$_condition) { goto anon456_Then; } else { goto anon456_Else; }
anon456_Then:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_5,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_6 == Mask_$_5[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_5[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_5[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_6);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_6,ZeroMask);
	assume wf(Heap,Mask_$_6,ZeroMask);
	assume Mask_$_7 == Mask_$_6;
	if ($_$_condition_$0) { goto anon457_Then; } else { goto anon457_Else; }
anon456_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_7 == Mask_$_5;
	if ($_$_condition_$1) { goto anon457_Then; } else { goto anon457_Else; }
anon457_Then:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_7,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_8 == Mask_$_7[Heap[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_7[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_7[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_8);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_8,ZeroMask);
	assume wf(Heap,Mask_$_8,ZeroMask);
	assume Mask_$_9 == Mask_$_8;
	if ($_$_condition_$2) { goto anon458_Then; } else { goto anon458_Else; }
anon457_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_9 == Mask_$_7;
	if ($_$_condition_$3) { goto anon458_Then; } else { goto anon458_Else; }
anon458_Then:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_9,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_10 == Mask_$_9[Heap[this,AVLTreeNode.left],AVLTreeNode.keys := Mask_$_9[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_9[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_10);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_10,ZeroMask);
	assume wf(Heap,Mask_$_10,ZeroMask);
	assume Mask_$_11 == Mask_$_10;
	if ($_$_condition_$4) { goto anon459_Then; } else { goto anon459_Else; }
anon458_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_11 == Mask_$_9;
	if ($_$_condition_$5) { goto anon459_Then; } else { goto anon459_Else; }
anon459_Then:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_11,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_12 == Mask_$_11[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_11[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_11[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_12);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_12,ZeroMask);
	assume wf(Heap,Mask_$_12,ZeroMask);
	assume Mask_$_13 == Mask_$_12;
	if ($_$_condition_$6) { goto anon460_Then; } else { goto anon460_Else; }
anon459_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_13 == Mask_$_11;
	if ($_$_condition_$7) { goto anon460_Then; } else { goto anon460_Else; }
anon460_Then:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume (forall  k#92#481 : Integer :: ( ((0 <= k#92#481) && (k#92#481 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#481) < Heap[this,AVLTreeNode.key]) ));
	if ($_$_condition_$8) { goto anon461_Then; } else { goto anon461_Else; }
anon460_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	if ($_$_condition_$9) { goto anon461_Then; } else { goto anon461_Else; }
anon461_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_13,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_14 == Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_14);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_14,ZeroMask);
	assume wf(Heap,Mask_$_14,ZeroMask);
	assume Mask_$_15 == Mask_$_14;
	if ($_$_condition_$10) { goto anon462_Then; } else { goto anon462_Else; }
anon461_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_15 == Mask_$_13;
	if ($_$_condition_$11) { goto anon462_Then; } else { goto anon462_Else; }
anon462_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_15,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_16 == Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_16);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_16,ZeroMask);
	assume wf(Heap,Mask_$_16,ZeroMask);
	assume Mask_$_17 == Mask_$_16;
	if ($_$_condition_$12) { goto anon463_Then; } else { goto anon463_Else; }
anon462_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_17 == Mask_$_15;
	if ($_$_condition_$13) { goto anon463_Then; } else { goto anon463_Else; }
anon463_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_18 == Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.keys := Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_18);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_18,ZeroMask);
	assume wf(Heap,Mask_$_18,ZeroMask);
	assume Mask_$_19 == Mask_$_18;
	if ($_$_condition_$14) { goto anon464_Then; } else { goto anon464_Else; }
anon463_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_19 == Mask_$_17;
	if ($_$_condition_$15) { goto anon464_Then; } else { goto anon464_Else; }
anon464_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_19,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_20 == Mask_$_19[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_19[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_19[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_20);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_20,ZeroMask);
	assume wf(Heap,Mask_$_20,ZeroMask);
	assume Mask_$_21 == Mask_$_20;
	if ($_$_condition_$16) { goto anon465_Then; } else { goto anon465_Else; }
anon464_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_21 == Mask_$_19;
	if ($_$_condition_$17) { goto anon465_Then; } else { goto anon465_Else; }
anon465_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume (forall  k#93#482 : Integer :: ( ((0 <= k#93#482) && (k#93#482 < Seq#Length(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[this,AVLTreeNode.key] < Seq#Index(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#482)) ));
	goto anon20;
anon465_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon20;
anon20:
	assume (ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assume (ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assume IsGoodMask(Mask_$_21);
	assume wf(Heap,Mask_$_21,ZeroMask);
	assume Heap == Heap;
	assume Mask_$_21 == Mask;
	assume ZeroMask == SecMask;
	assume ZeroCredits == Credits;
	assert { :msg "  585.20: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  585.20: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$18) { goto anon466_Then; } else { goto anon466_Else; }
anon466_Then:
	assume Heap[this,AVLTreeNode.left] == null;
	goto anon23;
anon466_Else:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assert { :msg "  585.38: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  585.38: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  585.38: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.left] == null));
	assert { :msg "  585.38: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.height);
	goto anon23;
anon23:
	assume lh#60_$_0 == ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]);
	assert { :msg "  586.20: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  586.20: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$19) { goto anon467_Then; } else { goto anon467_Else; }
anon467_Then:
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon26;
anon467_Else:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assert { :msg "  586.38: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  586.38: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  586.38: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.right] == null));
	assert { :msg "  586.38: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.height);
	goto anon26;
anon26:
	assume rh#62_$_0 == ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]);
	assume wf(Heap,Mask_$_21,ZeroMask);
	assert { :msg "  588.10: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  588.10: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$20) { goto anon468_Then; } else { goto anon468_Else; }
anon468_Then:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume (0 < unfoldingK#_1615) && ((1000 * unfoldingK#_1615) < Fractions(1));
	assert { :msg "  588.36: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  588.36: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  588.36: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.left] == null));
	assume wf(Heap,Mask_$_21,ZeroMask);
	assert { :msg "  588.26: Unfolding might fail. The permission at 588.36 might not be positive." } Fractions(100) > 0;
	assert { :msg "  588.26: Unfolding might fail. Insufficient fraction at 588.36 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume unfoldingMask#_1611_$_0 == Mask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_21[Heap[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$21) { goto anon469_Then; } else { goto anon469_Else; }
anon468_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_22 == ZeroMask;
	goto anon186;
anon469_Then:
	assume false;
	goto $exit;
anon469_Else:
	assume !false;
	if ($_$_condition_$22) { goto anon496_Then; } else { goto anon496_Else; }
anon186:
	assume IsGoodExhaleState(exhaleHeap#_1608_$_0,Heap,Mask_$_21,assertSecMask#_1606_$_22);
	assume IsGoodMask(Mask_$_21);
	assume wf(exhaleHeap#_1608_$_0,Mask_$_21,assertSecMask#_1606_$_22);
	assume wf(Heap,Mask_$_21,ZeroMask);
	assert { :msg "  589.10: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  589.10: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$70) { goto anon548_Then; } else { goto anon548_Else; }
anon496_Then:
	assume !CanRead(unfoldingMask#_1611_$_0,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume oldVers#_1635_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_1610_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := newVers#_1636_$_0];
	assume oldVers#_1635_$_0 < unfoldingHeap#_1610_$_0[unfoldingHeap#_1610_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_1610_$_1 == unfoldingHeap#_1610_$_0;
	goto anon83;
anon496_Else:
	assume CanRead(unfoldingMask#_1611_$_0,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume unfoldingHeap#_1610_$_1 == Heap;
	goto anon83;
anon83:
	assume IsGoodMask(unfoldingMask#_1611_$_0);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_0,ZeroMask);
	assume IsGoodMask(unfoldingMask#_1611_$_0);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_0,ZeroMask);
	assume !(unfoldingHeap#_1610_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_0,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume unfoldingMask#_1611_$_1 == unfoldingMask#_1611_$_0[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key := unfoldingMask#_1611_$_0[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := unfoldingMask#_1611_$_0[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1611_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_1,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_1,ZeroMask);
	assume !(unfoldingHeap#_1610_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_1,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_2 == unfoldingMask#_1611_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_1611_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_1611_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_2,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_2,ZeroMask);
	assume !(unfoldingHeap#_1610_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_2,ZeroMask);
	assume (unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null) || (dtype(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1611_$_3 == unfoldingMask#_1611_$_2[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left := unfoldingMask#_1611_$_2[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := unfoldingMask#_1611_$_2[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1611_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_3,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_3,ZeroMask);
	assume !(unfoldingHeap#_1610_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_3,ZeroMask);
	assume (unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null) || (dtype(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1611_$_4 == unfoldingMask#_1611_$_3[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right := unfoldingMask#_1611_$_3[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := unfoldingMask#_1611_$_3[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1611_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_4,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_4,ZeroMask);
	assume !(unfoldingHeap#_1610_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_4,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_5 == unfoldingMask#_1611_$_4[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_1611_$_4[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_1611_$_4[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_5,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_5,ZeroMask);
	assume !(unfoldingHeap#_1610_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_5,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_6 == unfoldingMask#_1611_$_5[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_1611_$_5[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1611_$_5[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_6,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_6,ZeroMask);
	if ($_$_condition_$23) { goto anon497_Then; } else { goto anon497_Else; }
anon497_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_6,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1611_$_7 == unfoldingMask#_1611_$_6[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := unfoldingMask#_1611_$_6[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := unfoldingMask#_1611_$_6[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1611_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_7,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_7,ZeroMask);
	assume unfoldingMask#_1611_$_8 == unfoldingMask#_1611_$_7;
	if ($_$_condition_$24) { goto anon498_Then; } else { goto anon498_Else; }
anon497_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_8 == unfoldingMask#_1611_$_6;
	if ($_$_condition_$25) { goto anon498_Then; } else { goto anon498_Else; }
anon498_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_8,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_9 == unfoldingMask#_1611_$_8[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_1611_$_8[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_1611_$_8[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_9);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_9,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_9,ZeroMask);
	assume unfoldingMask#_1611_$_10 == unfoldingMask#_1611_$_9;
	if ($_$_condition_$26) { goto anon499_Then; } else { goto anon499_Else; }
anon498_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_10 == unfoldingMask#_1611_$_8;
	if ($_$_condition_$27) { goto anon499_Then; } else { goto anon499_Else; }
anon499_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_10,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_11 == unfoldingMask#_1611_$_10[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_1611_$_10[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_1611_$_10[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_11);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_11,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_11,ZeroMask);
	assume unfoldingMask#_1611_$_12 == unfoldingMask#_1611_$_11;
	if ($_$_condition_$28) { goto anon500_Then; } else { goto anon500_Else; }
anon499_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_12 == unfoldingMask#_1611_$_10;
	if ($_$_condition_$29) { goto anon500_Then; } else { goto anon500_Else; }
anon500_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_12,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_13 == unfoldingMask#_1611_$_12[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_1611_$_12[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1611_$_12[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_13);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_13,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_13,ZeroMask);
	assume unfoldingMask#_1611_$_14 == unfoldingMask#_1611_$_13;
	if ($_$_condition_$30) { goto anon501_Then; } else { goto anon501_Else; }
anon500_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_14 == unfoldingMask#_1611_$_12;
	if ($_$_condition_$31) { goto anon501_Then; } else { goto anon501_Else; }
anon501_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#487 : Integer :: ( ((0 <= lk#79#487) && (lk#79#487 < Seq#Length(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#487) < unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$32) { goto anon502_Then; } else { goto anon502_Else; }
anon501_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$33) { goto anon502_Then; } else { goto anon502_Else; }
anon502_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$34) { goto anon503_Then; } else { goto anon503_Else; }
anon502_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$35) { goto anon503_Then; } else { goto anon503_Else; }
anon503_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_14,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1611_$_15 == unfoldingMask#_1611_$_14[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := unfoldingMask#_1611_$_14[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := unfoldingMask#_1611_$_14[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1611_$_15);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_15,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_15,ZeroMask);
	assume unfoldingMask#_1611_$_16 == unfoldingMask#_1611_$_15;
	if ($_$_condition_$36) { goto anon504_Then; } else { goto anon504_Else; }
anon503_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_16 == unfoldingMask#_1611_$_14;
	if ($_$_condition_$37) { goto anon504_Then; } else { goto anon504_Else; }
anon504_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_16,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_17 == unfoldingMask#_1611_$_16[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := unfoldingMask#_1611_$_16[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingMask#_1611_$_16[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_17);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_17,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_17,ZeroMask);
	assume unfoldingMask#_1611_$_18 == unfoldingMask#_1611_$_17;
	if ($_$_condition_$38) { goto anon505_Then; } else { goto anon505_Else; }
anon504_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_18 == unfoldingMask#_1611_$_16;
	if ($_$_condition_$39) { goto anon505_Then; } else { goto anon505_Else; }
anon505_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_18,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_19 == unfoldingMask#_1611_$_18[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := unfoldingMask#_1611_$_18[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingMask#_1611_$_18[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_19);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_19,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_19,ZeroMask);
	assume unfoldingMask#_1611_$_20 == unfoldingMask#_1611_$_19;
	if ($_$_condition_$40) { goto anon506_Then; } else { goto anon506_Else; }
anon505_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_20 == unfoldingMask#_1611_$_18;
	if ($_$_condition_$41) { goto anon506_Then; } else { goto anon506_Else; }
anon506_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_20,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1611_$_21 == unfoldingMask#_1611_$_20[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingMask#_1611_$_20[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1611_$_20[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1611_$_21);
	assume IsGoodState(heapFragment(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_21,ZeroMask);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_21,ZeroMask);
	assume unfoldingMask#_1611_$_22 == unfoldingMask#_1611_$_21;
	if ($_$_condition_$42) { goto anon507_Then; } else { goto anon507_Else; }
anon506_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_22 == unfoldingMask#_1611_$_20;
	if ($_$_condition_$43) { goto anon507_Then; } else { goto anon507_Else; }
anon507_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#488 : Integer :: ( ((0 <= rk#80#488) && (rk#80#488 < Seq#Length(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#488)) ));
	if ($_$_condition_$44) { goto anon508_Then; } else { goto anon508_Else; }
anon507_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$45) { goto anon508_Then; } else { goto anon508_Else; }
anon508_Then:
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon107;
anon508_Else:
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon107;
anon107:
	assume Seq#Equal(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key])),ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81 : Integer :: ( Seq#Contains(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81) <==> ((((!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81)) || ((!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81))) || (kk#81 == unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume IsGoodMask(unfoldingMask#_1611_$_22);
	assume wf(unfoldingHeap#_1610_$_1,unfoldingMask#_1611_$_22,ZeroMask);
	if ($_$_condition_$46) { goto anon509_Then; } else { goto anon509_Else; }
anon509_Then:
	assume false;
	goto $exit;
anon509_Else:
	assume !false;
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume assertSecMask#_1606_$_0 == ZeroMask[Heap[this,AVLTreeNode.left],AVLTreeNode.key := ZeroMask[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := ZeroMask[Heap[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_0);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_0);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_0);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_1 == assertSecMask#_1606_$_0[Heap[this,AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1606_$_0[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_1606_$_0[Heap[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_1);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_1);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_1);
	assume (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null) || (dtype(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_1606_$_2 == assertSecMask#_1606_$_1[Heap[this,AVLTreeNode.left],AVLTreeNode.left := assertSecMask#_1606_$_1[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := assertSecMask#_1606_$_1[Heap[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_2);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_2);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_2);
	assume (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null) || (dtype(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_1606_$_3 == assertSecMask#_1606_$_2[Heap[this,AVLTreeNode.left],AVLTreeNode.right := assertSecMask#_1606_$_2[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := assertSecMask#_1606_$_2[Heap[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_3);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_3);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_3);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_4 == assertSecMask#_1606_$_3[Heap[this,AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1606_$_3[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_1606_$_3[Heap[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_4);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_4);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_4);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_5 == assertSecMask#_1606_$_4[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1606_$_4[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1606_$_4[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_5);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_5);
	if ($_$_condition_$47) { goto anon536_Then; } else { goto anon536_Else; }
anon536_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_5);
	assume Fractions(100) > 0;
	assume assertSecMask#_1606_$_6 == assertSecMask#_1606_$_5[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := assertSecMask#_1606_$_5[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := assertSecMask#_1606_$_5[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_6);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_6);
	assume assertSecMask#_1606_$_7 == assertSecMask#_1606_$_6;
	if ($_$_condition_$48) { goto anon537_Then; } else { goto anon537_Else; }
anon536_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_7 == assertSecMask#_1606_$_5;
	if ($_$_condition_$49) { goto anon537_Then; } else { goto anon537_Else; }
anon537_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_7);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_8 == assertSecMask#_1606_$_7[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1606_$_7[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_1606_$_7[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_8);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_8);
	assume assertSecMask#_1606_$_9 == assertSecMask#_1606_$_8;
	if ($_$_condition_$50) { goto anon538_Then; } else { goto anon538_Else; }
anon537_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_9 == assertSecMask#_1606_$_7;
	if ($_$_condition_$51) { goto anon538_Then; } else { goto anon538_Else; }
anon538_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_9);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_10 == assertSecMask#_1606_$_9[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1606_$_9[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_1606_$_9[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_10);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_10);
	assume assertSecMask#_1606_$_11 == assertSecMask#_1606_$_10;
	if ($_$_condition_$52) { goto anon539_Then; } else { goto anon539_Else; }
anon538_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_11 == assertSecMask#_1606_$_9;
	if ($_$_condition_$53) { goto anon539_Then; } else { goto anon539_Else; }
anon539_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_11);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_12 == assertSecMask#_1606_$_11[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1606_$_11[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1606_$_11[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_12);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_12);
	assume assertSecMask#_1606_$_13 == assertSecMask#_1606_$_12;
	if ($_$_condition_$54) { goto anon540_Then; } else { goto anon540_Else; }
anon539_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_13 == assertSecMask#_1606_$_11;
	if ($_$_condition_$55) { goto anon540_Then; } else { goto anon540_Else; }
anon540_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#493 : Integer :: ( ((0 <= lk#79#493) && (lk#79#493 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#493) < Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$56) { goto anon541_Then; } else { goto anon541_Else; }
anon540_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$57) { goto anon541_Then; } else { goto anon541_Else; }
anon541_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$58) { goto anon542_Then; } else { goto anon542_Else; }
anon541_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$59) { goto anon542_Then; } else { goto anon542_Else; }
anon542_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_13);
	assume Fractions(100) > 0;
	assume assertSecMask#_1606_$_14 == assertSecMask#_1606_$_13[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := assertSecMask#_1606_$_13[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := assertSecMask#_1606_$_13[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_14);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_14);
	assume assertSecMask#_1606_$_15 == assertSecMask#_1606_$_14;
	if ($_$_condition_$60) { goto anon543_Then; } else { goto anon543_Else; }
anon542_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_15 == assertSecMask#_1606_$_13;
	if ($_$_condition_$61) { goto anon543_Then; } else { goto anon543_Else; }
anon543_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_15);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_16 == assertSecMask#_1606_$_15[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_1606_$_15[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_1606_$_15[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_16);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_16);
	assume assertSecMask#_1606_$_17 == assertSecMask#_1606_$_16;
	if ($_$_condition_$62) { goto anon544_Then; } else { goto anon544_Else; }
anon543_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_17 == assertSecMask#_1606_$_15;
	if ($_$_condition_$63) { goto anon544_Then; } else { goto anon544_Else; }
anon544_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_17);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_18 == assertSecMask#_1606_$_17[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_1606_$_17[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_1606_$_17[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_18);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_18);
	assume assertSecMask#_1606_$_19 == assertSecMask#_1606_$_18;
	if ($_$_condition_$64) { goto anon545_Then; } else { goto anon545_Else; }
anon544_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_19 == assertSecMask#_1606_$_17;
	if ($_$_condition_$65) { goto anon545_Then; } else { goto anon545_Else; }
anon545_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_19);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1606_$_20 == assertSecMask#_1606_$_19[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_1606_$_19[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1606_$_19[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_20);
	assume wf(Heap,Mask_$_21,assertSecMask#_1606_$_20);
	assume assertSecMask#_1606_$_21 == assertSecMask#_1606_$_20;
	if ($_$_condition_$66) { goto anon546_Then; } else { goto anon546_Else; }
anon545_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_21 == assertSecMask#_1606_$_19;
	if ($_$_condition_$67) { goto anon546_Then; } else { goto anon546_Else; }
anon546_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#494 : Integer :: ( ((0 <= rk#80#494) && (rk#80#494 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#494)) ));
	if ($_$_condition_$68) { goto anon547_Then; } else { goto anon547_Else; }
anon546_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$69) { goto anon547_Then; } else { goto anon547_Else; }
anon547_Then:
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon185;
anon547_Else:
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon185;
anon185:
	assume Seq#Equal(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$0 : Integer :: ( Seq#Contains(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$0) <==> ((((!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$0)) || ((!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$0))) || (kk#81_$0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assert { :msg "  588.51: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  588.51: Location might not be readable." } true ==> CanRead(unfoldingMask#_1611_$_22,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  588.51: Receiver might be null." } true ==> (!(unfoldingHeap#_1610_$_1[this,AVLTreeNode.left] == null));
	assert { :msg "  588.51: Location might not be readable." } true ==> CanRead(unfoldingMask#_1611_$_22,ZeroMask,unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.height);
	assert { :msg "  588.3: Assertion might not hold. The expression at 588.26 might not evaluate to true." } Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume assertSecMask#_1606_$_22 == assertSecMask#_1606_$_21;
	goto anon186;
anon548_Then:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume (0 < unfoldingK#_1664) && ((1000 * unfoldingK#_1664) < Fractions(1));
	assert { :msg "  589.36: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  589.36: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  589.36: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.right] == null));
	assume wf(Heap,Mask_$_21,ZeroMask);
	assert { :msg "  589.26: Unfolding might fail. The permission at 589.36 might not be positive." } Fractions(100) > 0;
	assert { :msg "  589.26: Unfolding might fail. Insufficient fraction at 589.36 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_21[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_21[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_21[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume unfoldingMask#_1660_$_0 == Mask_$_21[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_21[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_21[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$71) { goto anon549_Then; } else { goto anon549_Else; }
anon548_Else:
	assume Heap[this,AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_22 == ZeroMask;
	goto anon346;
anon549_Then:
	assume false;
	goto $exit;
anon549_Else:
	assume !false;
	if ($_$_condition_$72) { goto anon576_Then; } else { goto anon576_Else; }
anon346:
	assume IsGoodExhaleState(exhaleHeap#_1657_$_0,Heap,Mask_$_21,assertSecMask#_1655_$_22);
	assume IsGoodMask(Mask_$_21);
	assume wf(exhaleHeap#_1657_$_0,Mask_$_21,assertSecMask#_1655_$_22);
	assert { :msg "  590.3: Location might not be writable" } CanWrite(Mask_$_21,this,AVLTreeNode.height);
	assert { :msg "  590.18: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.18: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$120) { goto anon628_Then; } else { goto anon628_Else; }
anon576_Then:
	assume !CanRead(unfoldingMask#_1660_$_0,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume oldVers#_1684_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume unfoldingHeap#_1659_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := newVers#_1685_$_0];
	assume oldVers#_1684_$_0 < unfoldingHeap#_1659_$_0[unfoldingHeap#_1659_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume unfoldingHeap#_1659_$_1 == unfoldingHeap#_1659_$_0;
	goto anon243;
anon576_Else:
	assume CanRead(unfoldingMask#_1660_$_0,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume unfoldingHeap#_1659_$_1 == Heap;
	goto anon243;
anon243:
	assume IsGoodMask(unfoldingMask#_1660_$_0);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_0,ZeroMask);
	assume IsGoodMask(unfoldingMask#_1660_$_0);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_0,ZeroMask);
	assume !(unfoldingHeap#_1659_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_0,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume unfoldingMask#_1660_$_1 == unfoldingMask#_1660_$_0[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key := unfoldingMask#_1660_$_0[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := unfoldingMask#_1660_$_0[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1660_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_1,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_1,ZeroMask);
	assume !(unfoldingHeap#_1659_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_1,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_2 == unfoldingMask#_1660_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.height := unfoldingMask#_1660_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingMask#_1660_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_2,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_2,ZeroMask);
	assume !(unfoldingHeap#_1659_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_2,ZeroMask);
	assume (unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null) || (dtype(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1660_$_3 == unfoldingMask#_1660_$_2[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left := unfoldingMask#_1660_$_2[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := unfoldingMask#_1660_$_2[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1660_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_3,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_3,ZeroMask);
	assume !(unfoldingHeap#_1659_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_3,ZeroMask);
	assume (unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null) || (dtype(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1660_$_4 == unfoldingMask#_1660_$_3[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right := unfoldingMask#_1660_$_3[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := unfoldingMask#_1660_$_3[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1660_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_4,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_4,ZeroMask);
	assume !(unfoldingHeap#_1659_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_4,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_5 == unfoldingMask#_1660_$_4[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := unfoldingMask#_1660_$_4[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingMask#_1660_$_4[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_5,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_5,ZeroMask);
	assume !(unfoldingHeap#_1659_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_5,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_6 == unfoldingMask#_1660_$_5[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingMask#_1660_$_5[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1660_$_5[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_6,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_6,ZeroMask);
	if ($_$_condition_$73) { goto anon577_Then; } else { goto anon577_Else; }
anon577_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_6,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1660_$_7 == unfoldingMask#_1660_$_6[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := unfoldingMask#_1660_$_6[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := unfoldingMask#_1660_$_6[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1660_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_7,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_7,ZeroMask);
	assume unfoldingMask#_1660_$_8 == unfoldingMask#_1660_$_7;
	if ($_$_condition_$74) { goto anon578_Then; } else { goto anon578_Else; }
anon577_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_8 == unfoldingMask#_1660_$_6;
	if ($_$_condition_$75) { goto anon578_Then; } else { goto anon578_Else; }
anon578_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_8,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_9 == unfoldingMask#_1660_$_8[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_1660_$_8[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_1660_$_8[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_9);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_9,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_9,ZeroMask);
	assume unfoldingMask#_1660_$_10 == unfoldingMask#_1660_$_9;
	if ($_$_condition_$76) { goto anon579_Then; } else { goto anon579_Else; }
anon578_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_10 == unfoldingMask#_1660_$_8;
	if ($_$_condition_$77) { goto anon579_Then; } else { goto anon579_Else; }
anon579_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_10,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_11 == unfoldingMask#_1660_$_10[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_1660_$_10[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_1660_$_10[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_11);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_11,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_11,ZeroMask);
	assume unfoldingMask#_1660_$_12 == unfoldingMask#_1660_$_11;
	if ($_$_condition_$78) { goto anon580_Then; } else { goto anon580_Else; }
anon579_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_12 == unfoldingMask#_1660_$_10;
	if ($_$_condition_$79) { goto anon580_Then; } else { goto anon580_Else; }
anon580_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_12,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_13 == unfoldingMask#_1660_$_12[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_1660_$_12[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1660_$_12[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_13);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_13,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_13,ZeroMask);
	assume unfoldingMask#_1660_$_14 == unfoldingMask#_1660_$_13;
	if ($_$_condition_$80) { goto anon581_Then; } else { goto anon581_Else; }
anon580_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_14 == unfoldingMask#_1660_$_12;
	if ($_$_condition_$81) { goto anon581_Then; } else { goto anon581_Else; }
anon581_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#499 : Integer :: ( ((0 <= lk#79#499) && (lk#79#499 < Seq#Length(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#499) < unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$82) { goto anon582_Then; } else { goto anon582_Else; }
anon581_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$83) { goto anon582_Then; } else { goto anon582_Else; }
anon582_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$84) { goto anon583_Then; } else { goto anon583_Else; }
anon582_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$85) { goto anon583_Then; } else { goto anon583_Else; }
anon583_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_14,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_1660_$_15 == unfoldingMask#_1660_$_14[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := unfoldingMask#_1660_$_14[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := unfoldingMask#_1660_$_14[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_1660_$_15);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_15,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_15,ZeroMask);
	assume unfoldingMask#_1660_$_16 == unfoldingMask#_1660_$_15;
	if ($_$_condition_$86) { goto anon584_Then; } else { goto anon584_Else; }
anon583_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_16 == unfoldingMask#_1660_$_14;
	if ($_$_condition_$87) { goto anon584_Then; } else { goto anon584_Else; }
anon584_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_16,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_17 == unfoldingMask#_1660_$_16[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := unfoldingMask#_1660_$_16[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingMask#_1660_$_16[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_17);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_17,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_17,ZeroMask);
	assume unfoldingMask#_1660_$_18 == unfoldingMask#_1660_$_17;
	if ($_$_condition_$88) { goto anon585_Then; } else { goto anon585_Else; }
anon584_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_18 == unfoldingMask#_1660_$_16;
	if ($_$_condition_$89) { goto anon585_Then; } else { goto anon585_Else; }
anon585_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_18,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_19 == unfoldingMask#_1660_$_18[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := unfoldingMask#_1660_$_18[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingMask#_1660_$_18[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_19);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_19,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_19,ZeroMask);
	assume unfoldingMask#_1660_$_20 == unfoldingMask#_1660_$_19;
	if ($_$_condition_$90) { goto anon586_Then; } else { goto anon586_Else; }
anon585_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_20 == unfoldingMask#_1660_$_18;
	if ($_$_condition_$91) { goto anon586_Then; } else { goto anon586_Else; }
anon586_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_20,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_1660_$_21 == unfoldingMask#_1660_$_20[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingMask#_1660_$_20[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_1660_$_20[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_1660_$_21);
	assume IsGoodState(heapFragment(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_21,ZeroMask);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_21,ZeroMask);
	assume unfoldingMask#_1660_$_22 == unfoldingMask#_1660_$_21;
	if ($_$_condition_$92) { goto anon587_Then; } else { goto anon587_Else; }
anon586_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_22 == unfoldingMask#_1660_$_20;
	if ($_$_condition_$93) { goto anon587_Then; } else { goto anon587_Else; }
anon587_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#500 : Integer :: ( ((0 <= rk#80#500) && (rk#80#500 < Seq#Length(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#500)) ));
	if ($_$_condition_$94) { goto anon588_Then; } else { goto anon588_Else; }
anon587_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$95) { goto anon588_Then; } else { goto anon588_Else; }
anon588_Then:
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon267;
anon588_Else:
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon267;
anon267:
	assume Seq#Equal(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key])),ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$1 : Integer :: ( Seq#Contains(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$1) <==> ((((!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$1)) || ((!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$1))) || (kk#81_$1 == unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume IsGoodMask(unfoldingMask#_1660_$_22);
	assume wf(unfoldingHeap#_1659_$_1,unfoldingMask#_1660_$_22,ZeroMask);
	if ($_$_condition_$96) { goto anon589_Then; } else { goto anon589_Else; }
anon589_Then:
	assume false;
	goto $exit;
anon589_Else:
	assume !false;
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume assertSecMask#_1655_$_0 == ZeroMask[Heap[this,AVLTreeNode.right],AVLTreeNode.key := ZeroMask[Heap[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := ZeroMask[Heap[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_0);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_0);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_0);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_1 == assertSecMask#_1655_$_0[Heap[this,AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_1655_$_0[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_1655_$_0[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_1);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_1);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_1);
	assume (Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null) || (dtype(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_1655_$_2 == assertSecMask#_1655_$_1[Heap[this,AVLTreeNode.right],AVLTreeNode.left := assertSecMask#_1655_$_1[Heap[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := assertSecMask#_1655_$_1[Heap[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_2);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_2);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_2);
	assume (Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null) || (dtype(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_1655_$_3 == assertSecMask#_1655_$_2[Heap[this,AVLTreeNode.right],AVLTreeNode.right := assertSecMask#_1655_$_2[Heap[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := assertSecMask#_1655_$_2[Heap[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_3);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_3);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_3);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_4 == assertSecMask#_1655_$_3[Heap[this,AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_1655_$_3[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_1655_$_3[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_4);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_4);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_4);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_5 == assertSecMask#_1655_$_4[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_1655_$_4[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1655_$_4[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_5);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_5);
	if ($_$_condition_$97) { goto anon616_Then; } else { goto anon616_Else; }
anon616_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_5);
	assume Fractions(100) > 0;
	assume assertSecMask#_1655_$_6 == assertSecMask#_1655_$_5[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := assertSecMask#_1655_$_5[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := assertSecMask#_1655_$_5[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_6);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_6);
	assume assertSecMask#_1655_$_7 == assertSecMask#_1655_$_6;
	if ($_$_condition_$98) { goto anon617_Then; } else { goto anon617_Else; }
anon616_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_7 == assertSecMask#_1655_$_5;
	if ($_$_condition_$99) { goto anon617_Then; } else { goto anon617_Else; }
anon617_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_7);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_8 == assertSecMask#_1655_$_7[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_1655_$_7[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_1655_$_7[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_8);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_8);
	assume assertSecMask#_1655_$_9 == assertSecMask#_1655_$_8;
	if ($_$_condition_$100) { goto anon618_Then; } else { goto anon618_Else; }
anon617_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_9 == assertSecMask#_1655_$_7;
	if ($_$_condition_$101) { goto anon618_Then; } else { goto anon618_Else; }
anon618_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_9);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_10 == assertSecMask#_1655_$_9[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_1655_$_9[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_1655_$_9[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_10);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_10);
	assume assertSecMask#_1655_$_11 == assertSecMask#_1655_$_10;
	if ($_$_condition_$102) { goto anon619_Then; } else { goto anon619_Else; }
anon618_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_11 == assertSecMask#_1655_$_9;
	if ($_$_condition_$103) { goto anon619_Then; } else { goto anon619_Else; }
anon619_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_11);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_12 == assertSecMask#_1655_$_11[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_1655_$_11[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1655_$_11[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_12);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_12);
	assume assertSecMask#_1655_$_13 == assertSecMask#_1655_$_12;
	if ($_$_condition_$104) { goto anon620_Then; } else { goto anon620_Else; }
anon619_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_13 == assertSecMask#_1655_$_11;
	if ($_$_condition_$105) { goto anon620_Then; } else { goto anon620_Else; }
anon620_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#505 : Integer :: ( ((0 <= lk#79#505) && (lk#79#505 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#505) < Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$106) { goto anon621_Then; } else { goto anon621_Else; }
anon620_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$107) { goto anon621_Then; } else { goto anon621_Else; }
anon621_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$108) { goto anon622_Then; } else { goto anon622_Else; }
anon621_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$109) { goto anon622_Then; } else { goto anon622_Else; }
anon622_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_13);
	assume Fractions(100) > 0;
	assume assertSecMask#_1655_$_14 == assertSecMask#_1655_$_13[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := assertSecMask#_1655_$_13[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := assertSecMask#_1655_$_13[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_14);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_14);
	assume assertSecMask#_1655_$_15 == assertSecMask#_1655_$_14;
	if ($_$_condition_$110) { goto anon623_Then; } else { goto anon623_Else; }
anon622_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_15 == assertSecMask#_1655_$_13;
	if ($_$_condition_$111) { goto anon623_Then; } else { goto anon623_Else; }
anon623_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_15);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_16 == assertSecMask#_1655_$_15[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_1655_$_15[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_1655_$_15[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_16);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_16);
	assume assertSecMask#_1655_$_17 == assertSecMask#_1655_$_16;
	if ($_$_condition_$112) { goto anon624_Then; } else { goto anon624_Else; }
anon623_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_17 == assertSecMask#_1655_$_15;
	if ($_$_condition_$113) { goto anon624_Then; } else { goto anon624_Else; }
anon624_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_17);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_18 == assertSecMask#_1655_$_17[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_1655_$_17[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_1655_$_17[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_18);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_18);
	assume assertSecMask#_1655_$_19 == assertSecMask#_1655_$_18;
	if ($_$_condition_$114) { goto anon625_Then; } else { goto anon625_Else; }
anon624_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_19 == assertSecMask#_1655_$_17;
	if ($_$_condition_$115) { goto anon625_Then; } else { goto anon625_Else; }
anon625_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_19);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_1655_$_20 == assertSecMask#_1655_$_19[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_1655_$_19[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_1655_$_19[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_20);
	assume wf(Heap,Mask_$_21,assertSecMask#_1655_$_20);
	assume assertSecMask#_1655_$_21 == assertSecMask#_1655_$_20;
	if ($_$_condition_$116) { goto anon626_Then; } else { goto anon626_Else; }
anon625_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_21 == assertSecMask#_1655_$_19;
	if ($_$_condition_$117) { goto anon626_Then; } else { goto anon626_Else; }
anon626_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#506 : Integer :: ( ((0 <= rk#80#506) && (rk#80#506 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#506)) ));
	if ($_$_condition_$118) { goto anon627_Then; } else { goto anon627_Else; }
anon626_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$119) { goto anon627_Then; } else { goto anon627_Else; }
anon627_Then:
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon345;
anon627_Else:
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon345;
anon345:
	assume Seq#Equal(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key])),ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$2 : Integer :: ( Seq#Contains(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$2) <==> ((((!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$2)) || ((!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$2))) || (kk#81_$2 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assert { :msg "  589.51: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  589.51: Location might not be readable." } true ==> CanRead(unfoldingMask#_1660_$_22,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  589.51: Receiver might be null." } true ==> (!(unfoldingHeap#_1659_$_1[this,AVLTreeNode.right] == null));
	assert { :msg "  589.51: Location might not be readable." } true ==> CanRead(unfoldingMask#_1660_$_22,ZeroMask,unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.height);
	assert { :msg "  589.3: Assertion might not hold. The expression at 589.26 might not evaluate to true." } Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume assertSecMask#_1655_$_22 == assertSecMask#_1655_$_21;
	goto anon346;
anon628_Then:
	assume Heap[this,AVLTreeNode.left] == null;
	goto anon349;
anon628_Else:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assert { :msg "  590.35: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.35: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  590.35: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.left] == null));
	assert { :msg "  590.35: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.height);
	goto anon349;
anon349:
	assert { :msg "  590.51: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.51: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$121) { goto anon629_Then; } else { goto anon629_Else; }
anon629_Then:
	assume Heap[this,AVLTreeNode.right] == null;
	if ($_$_condition_$122) { goto anon630_Then; } else { goto anon630_Else; }
anon629_Else:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assert { :msg "  590.69: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.69: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  590.69: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.right] == null));
	assert { :msg "  590.69: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.height);
	if ($_$_condition_$123) { goto anon630_Then; } else { goto anon630_Else; }
anon630_Then:
	assume ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]);
	assert { :msg "  590.89: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.89: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$124) { goto anon631_Then; } else { goto anon631_Else; }
anon630_Else:
	assume ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]) >= ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]);
	assert { :msg "  590.126: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.126: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$125) { goto anon632_Then; } else { goto anon632_Else; }
anon631_Then:
	assume Heap[this,AVLTreeNode.left] == null;
	goto anon359;
anon631_Else:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assert { :msg "  590.106: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.106: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  590.106: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.left] == null));
	assert { :msg "  590.106: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.height);
	goto anon359;
anon632_Then:
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon359;
anon632_Else:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assert { :msg "  590.144: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.144: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  590.144: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.right] == null));
	assert { :msg "  590.144: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.height);
	goto anon359;
anon359:
	assume Heap_$_0 == Heap[this,AVLTreeNode.height := ite(ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]) + 1)];
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  592.3: Location might not be writable" } CanWrite(Mask_$_21,this,AVLTreeNode.balanceFactor);
	assert { :msg "  592.22: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  592.22: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$126) { goto anon633_Then; } else { goto anon633_Else; }
anon633_Then:
	assume Heap_$_0[this,AVLTreeNode.left] == null;
	goto anon362;
anon633_Else:
	assume !(Heap_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  592.39: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  592.39: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  592.39: Receiver might be null." } true ==> (!(Heap_$_0[this,AVLTreeNode.left] == null));
	assert { :msg "  592.39: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,AVLTreeNode.left],AVLTreeNode.height);
	goto anon362;
anon362:
	assert { :msg "  592.55: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  592.55: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$127) { goto anon634_Then; } else { goto anon634_Else; }
anon634_Then:
	assume Heap_$_0[this,AVLTreeNode.right] == null;
	goto anon365;
anon634_Else:
	assume !(Heap_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  592.73: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  592.73: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  592.73: Receiver might be null." } true ==> (!(Heap_$_0[this,AVLTreeNode.right] == null));
	assert { :msg "  592.73: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,AVLTreeNode.right],AVLTreeNode.height);
	goto anon365;
anon365:
	assume Heap_$_1 == Heap_$_0[this,AVLTreeNode.balanceFactor := ite(Heap_$_0[this,AVLTreeNode.left] == null,0,Heap_$_0[Heap_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_0[this,AVLTreeNode.right] == null,0,Heap_$_0[Heap_$_0[this,AVLTreeNode.right],AVLTreeNode.height])];
	assume wf(Heap_$_1,Mask_$_21,ZeroMask);
	assert { :msg "  593.3: Location might not be writable" } CanWrite(Mask_$_21,this,AVLTreeNode.keys);
	assert { :msg "  593.22: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  593.22: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$128) { goto anon635_Then; } else { goto anon635_Else; }
anon635_Then:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	goto anon368;
anon635_Else:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  593.46: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  593.46: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  593.46: Receiver might be null." } true ==> (!(Heap_$_1[this,AVLTreeNode.left] == null));
	assert { :msg "  593.46: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys);
	goto anon368;
anon368:
	assert { :msg "  593.62: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  593.62: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.key);
	assert { :msg "  593.72: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  593.72: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$129) { goto anon636_Then; } else { goto anon636_Else; }
anon636_Then:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	goto anon371;
anon636_Else:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  593.97: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  593.97: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  593.97: Receiver might be null." } true ==> (!(Heap_$_1[this,AVLTreeNode.right] == null));
	assert { :msg "  593.97: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys);
	goto anon371;
anon371:
	assume Heap_$_2 == Heap_$_1[this,AVLTreeNode.keys := Seq#Append(Seq#Append(ite(Heap_$_1[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[this,AVLTreeNode.key])),ite(Heap_$_1[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]))];
	assume wf(Heap_$_2,Mask_$_21,ZeroMask);
	assume wf(Heap_$_2,Mask_$_21,ZeroMask);
	assert { :msg "  594.11: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  594.11: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.key);
	assert { :msg "  594.10: Sequence index might be negative." } true ==> (0 <= 0);
	assert { :msg "  594.10: Sequence index might be larger than or equal to the length of the sequence." } true ==> (0 < Seq#Length(Seq#Singleton(Heap_$_2[this,AVLTreeNode.key])));
	assert { :msg "  594.22: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  594.22: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.key);
	assert { :msg "  594.3: Assertion might not hold. The expression at 594.10 might not evaluate to true." } Seq#Index(Seq#Singleton(Heap_$_2[this,AVLTreeNode.key]),0) == Heap_$_2[this,AVLTreeNode.key];
	assume IsGoodExhaleState(exhaleHeap#_1706_$_0,Heap_$_2,Mask_$_21,ZeroMask);
	assume IsGoodMask(Mask_$_21);
	assume wf(exhaleHeap#_1706_$_0,Mask_$_21,ZeroMask);
	assume #AVLTreeNode.valid#trigger(this);
	assume ((0 < foldK#_1711) && ((1000 * foldK#_1711) < Fractions(1))) && ((1000 * foldK#_1711) < methodK#_1603);
	assert { :msg "  595.3: The target of the fold statement might be null." } !(this == null);
	if ($_$_condition_$130) { goto anon637_Then; } else { goto anon637_Else; }
anon637_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 129.22 might not evaluate to true." } (forall  lk#79#507 : Integer :: ( ((0 <= lk#79#507) && (lk#79#507 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys],lk#79#507) < Heap_$_2[this,AVLTreeNode.key]) ));
	if ($_$_condition_$131) { goto anon638_Then; } else { goto anon638_Else; }
anon637_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	if ($_$_condition_$132) { goto anon638_Then; } else { goto anon638_Else; }
anon638_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 130.22 might not evaluate to true." } Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$133) { goto anon639_Then; } else { goto anon639_Else; }
anon638_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	if ($_$_condition_$134) { goto anon639_Then; } else { goto anon639_Else; }
anon639_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 136.24 might not evaluate to true." } (forall  rk#80#508 : Integer :: ( ((0 <= rk#80#508) && (rk#80#508 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_2[this,AVLTreeNode.key] < Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys],rk#80#508)) ));
	if ($_$_condition_$135) { goto anon640_Then; } else { goto anon640_Else; }
anon639_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	if ($_$_condition_$136) { goto anon640_Then; } else { goto anon640_Else; }
anon640_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 137.23 might not evaluate to true." } Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon379;
anon640_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	goto anon379;
anon379:
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 139.6 might not evaluate to true." } Seq#Equal(Heap_$_2[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_2[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_2[this,AVLTreeNode.key])),ite(Heap_$_2[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 140.6 might not evaluate to true." } Seq#Contains(Heap_$_2[this,AVLTreeNode.keys],Heap_$_2[this,AVLTreeNode.key]);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 141.7 might not evaluate to true." } (forall  kk#81_$3 : Integer :: ( Seq#Contains(Heap_$_2[this,AVLTreeNode.keys],kk#81_$3) <==> ((((!(Heap_$_2[this,AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$3)) || ((!(Heap_$_2[this,AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$3))) || (kk#81_$3 == Heap_$_2[this,AVLTreeNode.key])) ));
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 146.6 might not evaluate to true." } Heap_$_2[this,AVLTreeNode.height] == ite(ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 147.6 might not evaluate to true." } Heap_$_2[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]));
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 148.6 might not evaluate to true." } Heap_$_2[this,AVLTreeNode.balanceFactor] <= 1;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 149.6 might not evaluate to true." } Heap_$_2[this,AVLTreeNode.balanceFactor] >= (0 - 1);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 150.6 might not evaluate to true." } Heap_$_2[this,AVLTreeNode.height] > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 117.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 117.6 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_21[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_21[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_21[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_1713_$_0 == Mask_$_21[this,AVLTreeNode.key := Mask_$_21[this,AVLTreeNode.key][perm$R := Mask_$_21[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_0 == ZeroMask[this,AVLTreeNode.key := ZeroMask[this,AVLTreeNode.key][perm$R := ZeroMask[this,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1713_$_0);
	assume wf(Heap_$_2,exhaleMask#_1713_$_0,SecMask_$_0);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_0);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 118.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 118.6 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1713_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1713_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1713_$_1 == exhaleMask#_1713_$_0[this,AVLTreeNode.height := exhaleMask#_1713_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_1713_$_0[this,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_1 == SecMask_$_0[this,AVLTreeNode.height := SecMask_$_0[this,AVLTreeNode.height][perm$R := SecMask_$_0[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_1);
	assume wf(Heap_$_2,exhaleMask#_1713_$_1,SecMask_$_1);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_1);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 119.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 119.6 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_1713_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_1713_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_1713_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_1713_$_2 == exhaleMask#_1713_$_1[this,AVLTreeNode.left := exhaleMask#_1713_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_1713_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_2 == SecMask_$_1[this,AVLTreeNode.left := SecMask_$_1[this,AVLTreeNode.left][perm$R := SecMask_$_1[this,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1713_$_2);
	assume wf(Heap_$_2,exhaleMask#_1713_$_2,SecMask_$_2);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_2);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 120.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 120.6 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_1713_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_1713_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_1713_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_1713_$_3 == exhaleMask#_1713_$_2[this,AVLTreeNode.right := exhaleMask#_1713_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_1713_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_3 == SecMask_$_2[this,AVLTreeNode.right := SecMask_$_2[this,AVLTreeNode.right][perm$R := SecMask_$_2[this,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(exhaleMask#_1713_$_3);
	assume wf(Heap_$_2,exhaleMask#_1713_$_3,SecMask_$_3);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_3);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 122.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 122.6 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1713_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1713_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1713_$_4 == exhaleMask#_1713_$_3[this,AVLTreeNode.keys := exhaleMask#_1713_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_1713_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_4 == SecMask_$_3[this,AVLTreeNode.keys := SecMask_$_3[this,AVLTreeNode.keys][perm$R := SecMask_$_3[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_4);
	assume wf(Heap_$_2,exhaleMask#_1713_$_4,SecMask_$_4);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_4);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 123.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 123.6 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1713_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1713_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1713_$_5 == exhaleMask#_1713_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_1713_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1713_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_5 == SecMask_$_4[this,AVLTreeNode.balanceFactor := SecMask_$_4[this,AVLTreeNode.balanceFactor][perm$R := SecMask_$_4[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_5);
	assume wf(Heap_$_2,exhaleMask#_1713_$_5,SecMask_$_5);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_5);
	if ($_$_condition_$137) { goto anon641_Then; } else { goto anon641_Else; }
anon641_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 125.22 might not be positive." } Fractions(100) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 125.22 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1713_$_6 == exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_6 == SecMask_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$138) { goto anon642_Then; } else { goto anon642_Else; }
anon641_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume SecMask_$_7 == SecMask_$_5;
	assume exhaleMask#_1713_$_7 == exhaleMask#_1713_$_5;
	if ($_$_condition_$139) { goto anon643_Then; } else { goto anon643_Else; }
anon642_Then:
	assume !CanRead(exhaleMask#_1713_$_6,SecMask_$_6,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_1712_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon382;
anon642_Else:
	assume CanRead(exhaleMask#_1713_$_6,SecMask_$_6,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon382;
anon643_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 126.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 126.22 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1713_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1713_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1713_$_8 == exhaleMask#_1713_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_1713_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_1713_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_8 == SecMask_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_8);
	assume wf(Heap_$_2,exhaleMask#_1713_$_8,SecMask_$_8);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_8);
	assume exhaleMask#_1713_$_9 == exhaleMask#_1713_$_8;
	assume SecMask_$_9 == SecMask_$_8;
	if ($_$_condition_$141) { goto anon644_Then; } else { goto anon644_Else; }
anon643_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1713_$_9 == exhaleMask#_1713_$_7;
	assume SecMask_$_9 == SecMask_$_7;
	if ($_$_condition_$142) { goto anon644_Then; } else { goto anon644_Else; }
anon382:
	assume IsGoodMask(exhaleMask#_1713_$_6);
	assume wf(Heap_$_2,exhaleMask#_1713_$_6,SecMask_$_6);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_6);
	assume SecMask_$_7 == SecMask_$_6;
	assume exhaleMask#_1713_$_7 == exhaleMask#_1713_$_6;
	if ($_$_condition_$140) { goto anon643_Then; } else { goto anon643_Else; }
anon644_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 127.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 127.22 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1713_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1713_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1713_$_10 == exhaleMask#_1713_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_1713_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_1713_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_10 == SecMask_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_10);
	assume wf(Heap_$_2,exhaleMask#_1713_$_10,SecMask_$_10);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_10);
	assume SecMask_$_11 == SecMask_$_10;
	assume exhaleMask#_1713_$_11 == exhaleMask#_1713_$_10;
	if ($_$_condition_$143) { goto anon645_Then; } else { goto anon645_Else; }
anon644_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume SecMask_$_11 == SecMask_$_9;
	assume exhaleMask#_1713_$_11 == exhaleMask#_1713_$_9;
	if ($_$_condition_$144) { goto anon645_Then; } else { goto anon645_Else; }
anon645_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 128.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 128.22 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1713_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1713_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1713_$_12 == exhaleMask#_1713_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_1713_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1713_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_12 == SecMask_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_12);
	assume wf(Heap_$_2,exhaleMask#_1713_$_12,SecMask_$_12);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_12);
	assume exhaleMask#_1713_$_13 == exhaleMask#_1713_$_12;
	assume SecMask_$_13 == SecMask_$_12;
	if ($_$_condition_$145) { goto anon646_Then; } else { goto anon646_Else; }
anon645_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1713_$_13 == exhaleMask#_1713_$_11;
	assume SecMask_$_13 == SecMask_$_11;
	if ($_$_condition_$146) { goto anon646_Then; } else { goto anon646_Else; }
anon646_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 132.23 might not be positive." } Fractions(100) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 132.23 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1713_$_14 == exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_14 == SecMask_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$147) { goto anon647_Then; } else { goto anon647_Else; }
anon646_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume SecMask_$_15 == SecMask_$_13;
	assume exhaleMask#_1713_$_15 == exhaleMask#_1713_$_13;
	if ($_$_condition_$148) { goto anon648_Then; } else { goto anon648_Else; }
anon647_Then:
	assume !CanRead(exhaleMask#_1713_$_14,SecMask_$_14,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_1712_$_0[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon392;
anon647_Else:
	assume CanRead(exhaleMask#_1713_$_14,SecMask_$_14,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon392;
anon648_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 133.23 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 133.23 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1713_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1713_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1713_$_16 == exhaleMask#_1713_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_1713_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_1713_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_16 == SecMask_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_16);
	assume wf(Heap_$_2,exhaleMask#_1713_$_16,SecMask_$_16);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_16);
	assume exhaleMask#_1713_$_17 == exhaleMask#_1713_$_16;
	assume SecMask_$_17 == SecMask_$_16;
	if ($_$_condition_$150) { goto anon649_Then; } else { goto anon649_Else; }
anon648_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1713_$_17 == exhaleMask#_1713_$_15;
	assume SecMask_$_17 == SecMask_$_15;
	if ($_$_condition_$151) { goto anon649_Then; } else { goto anon649_Else; }
anon392:
	assume IsGoodMask(exhaleMask#_1713_$_14);
	assume wf(Heap_$_2,exhaleMask#_1713_$_14,SecMask_$_14);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_14);
	assume SecMask_$_15 == SecMask_$_14;
	assume exhaleMask#_1713_$_15 == exhaleMask#_1713_$_14;
	if ($_$_condition_$149) { goto anon648_Then; } else { goto anon648_Else; }
anon649_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 134.23 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 134.23 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1713_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1713_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1713_$_18 == exhaleMask#_1713_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_1713_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_1713_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_18 == SecMask_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_18);
	assume wf(Heap_$_2,exhaleMask#_1713_$_18,SecMask_$_18);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_18);
	assume SecMask_$_19 == SecMask_$_18;
	assume exhaleMask#_1713_$_19 == exhaleMask#_1713_$_18;
	if ($_$_condition_$152) { goto anon650_Then; } else { goto anon650_Else; }
anon649_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume SecMask_$_19 == SecMask_$_17;
	assume exhaleMask#_1713_$_19 == exhaleMask#_1713_$_17;
	if ($_$_condition_$153) { goto anon650_Then; } else { goto anon650_Else; }
anon650_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 135.23 might not be positive." } Fractions(50) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 135.23 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1713_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1713_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1713_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1713_$_20 == exhaleMask#_1713_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_1713_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1713_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_20 == SecMask_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1713_$_20);
	assume wf(Heap_$_2,exhaleMask#_1713_$_20,SecMask_$_20);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_20);
	assume exhaleMask#_1713_$_21 == exhaleMask#_1713_$_20;
	assume SecMask_$_21 == SecMask_$_20;
	goto anon399;
anon650_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1713_$_21 == exhaleMask#_1713_$_19;
	assume SecMask_$_21 == SecMask_$_19;
	goto anon399;
anon399:
	assume IsGoodExhaleState(exhaleHeap#_1712_$_0,Heap_$_2,exhaleMask#_1713_$_21,SecMask_$_21);
	assume IsGoodMask(exhaleMask#_1713_$_21);
	assume wf(exhaleHeap#_1712_$_0,exhaleMask#_1713_$_21,SecMask_$_21);
	assume !(this == null);
	assume wf(exhaleHeap#_1712_$_0,exhaleMask#_1713_$_21,SecMask_$_21);
	assume Fractions(100) > 0;
	assume Mask_$_22 == exhaleMask#_1713_$_21[this,AVLTreeNode.valid := exhaleMask#_1713_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_1713_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_22);
	assume IsGoodState(heapFragment(exhaleHeap#_1712_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_21);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_21);
	assume IsGoodMask(Mask_$_22);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_21);
	assume predVer#_1709_$_0 == exhaleHeap#_1712_$_0[this,AVLTreeNode.valid];
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_21);
	assert { :msg "  543.2: The postcondition at 572.11 might not hold. The expression at 572.11 might not evaluate to true." } Seq#Equal(exhaleHeap#_1712_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap[this,AVLTreeNode.key])),ite(Heap[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assert { :msg "  543.2: The postcondition at 575.11 might not hold. The expression at 575.11 might not evaluate to true." } exhaleHeap#_1712_$_0[this,AVLTreeNode.height] == ite(ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assert { :msg "  543.2: The postcondition at 582.11 might not hold. The expression at 582.11 might not evaluate to true." } exhaleHeap#_1712_$_0[this,AVLTreeNode.balanceFactor] == (ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]));
	assert { :msg "  543.2: The postcondition at 567.11 might not hold. The permission at 567.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  543.2: The postcondition at 567.11 might not hold. Insufficient fraction at 567.11 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_22[this,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_22[this,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_22[this,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1729_$_0 == Mask_$_22[this,AVLTreeNode.valid := Mask_$_22[this,AVLTreeNode.valid][perm$R := Mask_$_22[this,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$154) { goto anon651_Then; } else { goto anon651_Else; }
anon651_Then:
	assume false || ((((predVer#_1709_$_0 == exhaleHeap#_1712_$_0[this,AVLTreeNode.valid]) && (this == this)) && true) && true);
	if ($_$_condition_$155) { goto anon652_Then; } else { goto anon652_Else; }
anon651_Else:
	assume !(false || ((((predVer#_1709_$_0 == exhaleHeap#_1712_$_0[this,AVLTreeNode.valid]) && (this == this)) && true) && true));
	assume SecMask_$_72 == SecMask_$_21;
	if ($_$_condition_$156) { goto anon678_Then; } else { goto anon678_Else; }
anon652_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume (forall  lk#79#511 : Integer :: ( ((0 <= lk#79#511) && (lk#79#511 < Seq#Length(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],lk#79#511) < exhaleHeap#_1712_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$157) { goto anon653_Then; } else { goto anon653_Else; }
anon652_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	if ($_$_condition_$158) { goto anon653_Then; } else { goto anon653_Else; }
anon678_Then:
	assume !CanRead(exhaleMask#_1729_$_0,SecMask_$_72,this,AVLTreeNode.valid);
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.valid] < exhaleHeap#_1728_$_0[this,AVLTreeNode.valid];
	goto anon455;
anon678_Else:
	assume CanRead(exhaleMask#_1729_$_0,SecMask_$_72,this,AVLTreeNode.valid);
	goto anon455;
anon653_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$159) { goto anon654_Then; } else { goto anon654_Else; }
anon653_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	if ($_$_condition_$160) { goto anon654_Then; } else { goto anon654_Else; }
anon654_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume (forall  rk#80#512 : Integer :: ( ((0 <= rk#80#512) && (rk#80#512 < Seq#Length(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1712_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],rk#80#512)) ));
	if ($_$_condition_$161) { goto anon655_Then; } else { goto anon655_Else; }
anon654_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	if ($_$_condition_$162) { goto anon655_Then; } else { goto anon655_Else; }
anon655_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon408;
anon655_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	goto anon408;
anon408:
	assume Seq#Equal(exhaleHeap#_1712_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_1712_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(exhaleHeap#_1712_$_0[this,AVLTreeNode.keys],exhaleHeap#_1712_$_0[this,AVLTreeNode.key]);
	assume (forall  kk#81_$4 : Integer :: ( Seq#Contains(exhaleHeap#_1712_$_0[this,AVLTreeNode.keys],kk#81_$4) <==> ((((!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null)) && Seq#Contains(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$4)) || ((!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null)) && Seq#Contains(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$4))) || (kk#81_$4 == exhaleHeap#_1712_$_0[this,AVLTreeNode.key])) ));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.height] == ite(ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.balanceFactor] <= 1;
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.height] > 0;
	assume SecMask_$_22 == SecMask_$_21[this,AVLTreeNode.key := SecMask_$_21[this,AVLTreeNode.key][perm$R := SecMask_$_21[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	if ($_$_condition_$163) { goto anon656_Then; } else { goto anon656_Else; }
anon656_Then:
	assume SecMask_$_22[this,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_23 == SecMask_$_22[this,AVLTreeNode.key := SecMask_$_22[this,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_24 == SecMask_$_23;
	goto anon410;
anon656_Else:
	assume 0 <= SecMask_$_22[this,AVLTreeNode.key][perm$R];
	assume SecMask_$_24 == SecMask_$_22;
	goto anon410;
anon410:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_24,SecMask_$_24);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_24);
	assume SecMask_$_25 == SecMask_$_24[this,AVLTreeNode.height := SecMask_$_24[this,AVLTreeNode.height][perm$R := SecMask_$_24[this,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$164) { goto anon657_Then; } else { goto anon657_Else; }
anon657_Then:
	assume SecMask_$_25[this,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_26 == SecMask_$_25[this,AVLTreeNode.height := SecMask_$_25[this,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_27 == SecMask_$_26;
	goto anon412;
anon657_Else:
	assume 0 <= SecMask_$_25[this,AVLTreeNode.height][perm$R];
	assume SecMask_$_27 == SecMask_$_25;
	goto anon412;
anon412:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_27,SecMask_$_27);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_27);
	assume SecMask_$_28 == SecMask_$_27[this,AVLTreeNode.left := SecMask_$_27[this,AVLTreeNode.left][perm$R := SecMask_$_27[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$165) { goto anon658_Then; } else { goto anon658_Else; }
anon658_Then:
	assume SecMask_$_28[this,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[this,AVLTreeNode.left := SecMask_$_28[this,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon414;
anon658_Else:
	assume 0 <= SecMask_$_28[this,AVLTreeNode.left][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon414;
anon414:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_30,SecMask_$_30);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30[this,AVLTreeNode.right := SecMask_$_30[this,AVLTreeNode.right][perm$R := SecMask_$_30[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$166) { goto anon659_Then; } else { goto anon659_Else; }
anon659_Then:
	assume SecMask_$_31[this,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_32 == SecMask_$_31[this,AVLTreeNode.right := SecMask_$_31[this,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_33 == SecMask_$_32;
	goto anon416;
anon659_Else:
	assume 0 <= SecMask_$_31[this,AVLTreeNode.right][perm$R];
	assume SecMask_$_33 == SecMask_$_31;
	goto anon416;
anon416:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_33,SecMask_$_33);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_33);
	assume SecMask_$_34 == SecMask_$_33[this,AVLTreeNode.keys := SecMask_$_33[this,AVLTreeNode.keys][perm$R := SecMask_$_33[this,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$167) { goto anon660_Then; } else { goto anon660_Else; }
anon660_Then:
	assume SecMask_$_34[this,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_35 == SecMask_$_34[this,AVLTreeNode.keys := SecMask_$_34[this,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_36 == SecMask_$_35;
	goto anon418;
anon660_Else:
	assume 0 <= SecMask_$_34[this,AVLTreeNode.keys][perm$R];
	assume SecMask_$_36 == SecMask_$_34;
	goto anon418;
anon418:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_36,SecMask_$_36);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_36);
	assume SecMask_$_37 == SecMask_$_36[this,AVLTreeNode.balanceFactor := SecMask_$_36[this,AVLTreeNode.balanceFactor][perm$R := SecMask_$_36[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$168) { goto anon661_Then; } else { goto anon661_Else; }
anon661_Then:
	assume SecMask_$_37[this,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_38 == SecMask_$_37[this,AVLTreeNode.balanceFactor := SecMask_$_37[this,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_39 == SecMask_$_38;
	goto anon420;
anon661_Else:
	assume 0 <= SecMask_$_37[this,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_39 == SecMask_$_37;
	goto anon420;
anon420:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_39,SecMask_$_39);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_39);
	if ($_$_condition_$169) { goto anon662_Then; } else { goto anon662_Else; }
anon662_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_40 == SecMask_$_39[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_39[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_39[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$170) { goto anon663_Then; } else { goto anon663_Else; }
anon662_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_43 == SecMask_$_39;
	if ($_$_condition_$171) { goto anon664_Then; } else { goto anon664_Else; }
anon663_Then:
	assume SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_41 == SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_42 == SecMask_$_41;
	goto anon423;
anon663_Else:
	assume 0 <= SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_42 == SecMask_$_40;
	goto anon423;
anon664_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_44 == SecMask_$_43[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_43[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_43[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$173) { goto anon665_Then; } else { goto anon665_Else; }
anon664_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_47 == SecMask_$_43;
	if ($_$_condition_$174) { goto anon666_Then; } else { goto anon666_Else; }
anon423:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_42,SecMask_$_42);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_42);
	assume SecMask_$_43 == SecMask_$_42;
	if ($_$_condition_$172) { goto anon664_Then; } else { goto anon664_Else; }
anon665_Then:
	assume SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_45 == SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_46 == SecMask_$_45;
	goto anon427;
anon665_Else:
	assume 0 <= SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_46 == SecMask_$_44;
	goto anon427;
anon666_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_48 == SecMask_$_47[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_47[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_47[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$176) { goto anon667_Then; } else { goto anon667_Else; }
anon666_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_51 == SecMask_$_47;
	if ($_$_condition_$177) { goto anon668_Then; } else { goto anon668_Else; }
anon427:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_46,SecMask_$_46);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_46);
	assume SecMask_$_47 == SecMask_$_46;
	if ($_$_condition_$175) { goto anon666_Then; } else { goto anon666_Else; }
anon667_Then:
	assume SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_49 == SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_50 == SecMask_$_49;
	goto anon431;
anon667_Else:
	assume 0 <= SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_50 == SecMask_$_48;
	goto anon431;
anon668_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_52 == SecMask_$_51[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_51[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_51[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$179) { goto anon669_Then; } else { goto anon669_Else; }
anon668_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_55 == SecMask_$_51;
	if ($_$_condition_$180) { goto anon670_Then; } else { goto anon670_Else; }
anon431:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_50,SecMask_$_50);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_50);
	assume SecMask_$_51 == SecMask_$_50;
	if ($_$_condition_$178) { goto anon668_Then; } else { goto anon668_Else; }
anon669_Then:
	assume SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_53 == SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_54 == SecMask_$_53;
	goto anon435;
anon669_Else:
	assume 0 <= SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_54 == SecMask_$_52;
	goto anon435;
anon670_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_56 == SecMask_$_55[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_55[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_55[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$182) { goto anon671_Then; } else { goto anon671_Else; }
anon670_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_59 == SecMask_$_55;
	if ($_$_condition_$183) { goto anon672_Then; } else { goto anon672_Else; }
anon435:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_54,SecMask_$_54);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_54);
	assume SecMask_$_55 == SecMask_$_54;
	if ($_$_condition_$181) { goto anon670_Then; } else { goto anon670_Else; }
anon671_Then:
	assume SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_57 == SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_58 == SecMask_$_57;
	goto anon439;
anon671_Else:
	assume 0 <= SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_58 == SecMask_$_56;
	goto anon439;
anon672_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_60 == SecMask_$_59[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_59[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_59[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$185) { goto anon673_Then; } else { goto anon673_Else; }
anon672_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_63 == SecMask_$_59;
	if ($_$_condition_$186) { goto anon674_Then; } else { goto anon674_Else; }
anon439:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_58,SecMask_$_58);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_58);
	assume SecMask_$_59 == SecMask_$_58;
	if ($_$_condition_$184) { goto anon672_Then; } else { goto anon672_Else; }
anon673_Then:
	assume SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_61 == SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_62 == SecMask_$_61;
	goto anon443;
anon673_Else:
	assume 0 <= SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_62 == SecMask_$_60;
	goto anon443;
anon674_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_64 == SecMask_$_63[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_63[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_63[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$188) { goto anon675_Then; } else { goto anon675_Else; }
anon674_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_67 == SecMask_$_63;
	if ($_$_condition_$189) { goto anon676_Then; } else { goto anon676_Else; }
anon443:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_62,SecMask_$_62);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_62);
	assume SecMask_$_63 == SecMask_$_62;
	if ($_$_condition_$187) { goto anon674_Then; } else { goto anon674_Else; }
anon675_Then:
	assume SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_65 == SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_66 == SecMask_$_65;
	goto anon447;
anon675_Else:
	assume 0 <= SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_66 == SecMask_$_64;
	goto anon447;
anon676_Then:
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_68 == SecMask_$_67[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_67[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_67[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$191) { goto anon677_Then; } else { goto anon677_Else; }
anon676_Else:
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_71 == SecMask_$_67;
	goto anon452;
anon447:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_66,SecMask_$_66);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_66);
	assume SecMask_$_67 == SecMask_$_66;
	if ($_$_condition_$190) { goto anon676_Then; } else { goto anon676_Else; }
anon677_Then:
	assume SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_69 == SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_70 == SecMask_$_69;
	goto anon451;
anon677_Else:
	assume 0 <= SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_70 == SecMask_$_68;
	goto anon451;
anon452:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_71,SecMask_$_71);
	assume SecMask_$_72 == SecMask_$_71;
	if ($_$_condition_$192) { goto anon678_Then; } else { goto anon678_Else; }
anon451:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_70,SecMask_$_70);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_70);
	assume SecMask_$_71 == SecMask_$_70;
	goto anon452;
anon455:
	assume IsGoodMask(exhaleMask#_1729_$_0);
	assume wf(exhaleHeap#_1712_$_0,exhaleMask#_1729_$_0,SecMask_$_72);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_72);
	assert { :msg "  543.2: The postcondition at 568.11 might not hold. The permission at 568.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  543.2: The postcondition at 568.11 might not hold. Insufficient fraction at 568.11 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_1729_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_1729_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_1729_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_1729_$_1 == exhaleMask#_1729_$_0[this,AVLTreeNode.height := exhaleMask#_1729_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_1729_$_0[this,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1729_$_1);
	assume wf(exhaleHeap#_1712_$_0,exhaleMask#_1729_$_1,SecMask_$_72);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_72);
	assert { :msg "  543.2: The postcondition at 569.11 might not hold. The permission at 569.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  543.2: The postcondition at 569.11 might not hold. Insufficient fraction at 569.11 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_1729_$_1[this,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_1729_$_1[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_1729_$_1[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_1729_$_2 == exhaleMask#_1729_$_1[this,AVLTreeNode.keys := exhaleMask#_1729_$_1[this,AVLTreeNode.keys][perm$R := exhaleMask#_1729_$_1[this,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1729_$_2);
	assume wf(exhaleHeap#_1712_$_0,exhaleMask#_1729_$_2,SecMask_$_72);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_72);
	assert { :msg "  543.2: The postcondition at 570.11 might not hold. The permission at 570.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  543.2: The postcondition at 570.11 might not hold. Insufficient fraction at 570.11 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_1729_$_2[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_1729_$_2[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_1729_$_2[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_1729_$_3 == exhaleMask#_1729_$_2[this,AVLTreeNode.balanceFactor := exhaleMask#_1729_$_2[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_1729_$_2[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_1729_$_3);
	assume wf(exhaleHeap#_1712_$_0,exhaleMask#_1729_$_3,SecMask_$_72);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_72);
	assume IsGoodExhaleState(exhaleHeap#_1728_$_0,exhaleHeap#_1712_$_0,exhaleMask#_1729_$_3,SecMask_$_72);
	assume IsGoodMask(exhaleMask#_1729_$_3);
	assume wf(exhaleHeap#_1728_$_0,exhaleMask#_1729_$_3,SecMask_$_72);
	assert { :msg "  543.2: Method might lock/unlock more than allowed." } (forall  lk#_1750 : ref :: {exhaleHeap#_1728_$_0[lk#_1750,held]} {exhaleHeap#_1728_$_0[lk#_1750,rdheld]} ( (((0 < exhaleHeap#_1728_$_0[lk#_1750,held]) <==> (0 < Heap[lk#_1750,held])) && (exhaleHeap#_1728_$_0[lk#_1750,rdheld] <==> Heap[lk#_1750,rdheld])) || false ));
	assert { :msg "  543.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
