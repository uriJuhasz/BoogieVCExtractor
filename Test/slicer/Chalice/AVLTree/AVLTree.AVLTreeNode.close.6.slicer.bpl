type Integer = int;
type Boolean = bool;
type HeapType = <a>[ref,Field (a)]a;
type MaskType = <a>[ref,Field (a)][PermissionComponent]int;
type CreditsType = [ref]int;
type ArgSeq = <T>[int]T;
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
function Fractions(int) : int;
function IsGoodState(PartialHeapType) : bool;
function heapFragment <T> (T) : PartialHeapType;
function dtype(ref) : TypeName;
function MuBelow(Mu,Mu) : bool;
function wf(HeapType,MaskType,MaskType) : bool;
function IsGoodExhaleState(HeapType,HeapType,MaskType,MaskType) : bool;
function CanRead <T> (MaskType,MaskType,ref,Field (T)) : bool;
function CanWrite <T> (MaskType,ref,Field (T)) : bool;
function IsGoodMask(MaskType) : bool;
function DecPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function IncPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function NonPredicateField <T> (Field (T)) : bool;
function PredicateField <T> (Field (T)) : bool;
function ite <T> (bool,T,T) : T;
function Seq#Length <T> (Seq (T)) : int;
function Seq#Empty <T> () : Seq (T);
function Seq#Singleton <T> (T) : Seq (T);
function Seq#Build <T> (Seq (T),int,T,int) : Seq (T);
function Seq#Append <T> (Seq (T),Seq (T)) : Seq (T);
function Seq#Index <T> (Seq (T),int) : T;
function Seq#Contains <T> (Seq (T),T) : bool;
function Seq#Equal <T> (Seq (T),Seq (T)) : bool;
function Seq#Take <T> (Seq (T),int) : Seq (T);
function Seq#Drop <T> (Seq (T),int) : Seq (T);
function Seq#Range(int,int) : Seq (int);
function #AVLTreeNode.valid#trigger(ref) : bool;
var Heap : HeapType;
var Mask : MaskType;
var SecMask : MaskType;
var Credits : CreditsType;
procedure AVLTreeNode.close (this : ref)
{
	var methodK#_1603 : int;
	var unfoldingK#_1615 : int;
	var unfoldingK#_1664 : int;
	var foldK#_1711 : int;
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
	var $_$_condition_$2 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$12 : bool;
	var $_$_condition_$14 : bool;
	var $_$_condition_$16 : bool;
	var $_$_condition_$18 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$20 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$22 : bool;
	var $_$_condition_$23 : bool;
	var $_$_condition_$24 : bool;
	var $_$_condition_$26 : bool;
	var $_$_condition_$28 : bool;
	var $_$_condition_$30 : bool;
	var $_$_condition_$32 : bool;
	var $_$_condition_$34 : bool;
	var $_$_condition_$36 : bool;
	var $_$_condition_$38 : bool;
	var $_$_condition_$40 : bool;
	var $_$_condition_$42 : bool;
	var $_$_condition_$44 : bool;
	var $_$_condition_$46 : bool;
	var $_$_condition_$47 : bool;
	var $_$_condition_$48 : bool;
	var $_$_condition_$50 : bool;
	var $_$_condition_$52 : bool;
	var $_$_condition_$54 : bool;
	var $_$_condition_$56 : bool;
	var $_$_condition_$58 : bool;
	var $_$_condition_$60 : bool;
	var $_$_condition_$62 : bool;
	var $_$_condition_$64 : bool;
	var $_$_condition_$66 : bool;
	var $_$_condition_$68 : bool;
	var $_$_condition_$70 : bool;
	var $_$_condition_$71 : bool;
	var $_$_condition_$72 : bool;
	var $_$_condition_$73 : bool;
	var $_$_condition_$74 : bool;
	var $_$_condition_$76 : bool;
	var $_$_condition_$78 : bool;
	var $_$_condition_$80 : bool;
	var $_$_condition_$82 : bool;
	var $_$_condition_$84 : bool;
	var $_$_condition_$86 : bool;
	var $_$_condition_$88 : bool;
	var $_$_condition_$90 : bool;
	var $_$_condition_$92 : bool;
	var $_$_condition_$94 : bool;
	var $_$_condition_$96 : bool;
	var $_$_condition_$97 : bool;
	var $_$_condition_$98 : bool;
	var $_$_condition_$100 : bool;
	var $_$_condition_$102 : bool;
	var $_$_condition_$104 : bool;
	var $_$_condition_$106 : bool;
	var $_$_condition_$108 : bool;
	var $_$_condition_$110 : bool;
	var $_$_condition_$112 : bool;
	var $_$_condition_$114 : bool;
	var $_$_condition_$116 : bool;
	var $_$_condition_$118 : bool;
	var $_$_condition_$120 : bool;
	var $_$_condition_$121 : bool;
	var $_$_condition_$122 : bool;
	var $_$_condition_$124 : bool;
	var $_$_condition_$125 : bool;
	var $_$_condition_$126 : bool;
	var $_$_condition_$127 : bool;
	var $_$_condition_$128 : bool;
	var $_$_condition_$129 : bool;
	var $_$_condition_$130 : bool;
	var $_$_condition_$131 : bool;
	var $_$_condition_$133 : bool;
	var $_$_condition_$135 : bool;
	var $_$_condition_$137 : bool;
	var $_$_condition_$138 : bool;
	var $_$_condition_$139 : bool;
	var $_$_condition_$141 : bool;
	var $_$_condition_$143 : bool;
	var $_$_condition_$145 : bool;
	var $_$_condition_$147 : bool;
	var $_$_condition_$148 : bool;
	var $_$_condition_$150 : bool;
	var $_$_condition_$152 : bool;
	var $_$_condition_$154 : bool;
	var $_$_condition_$155 : bool;
	var $_$_condition_$156 : bool;
	var $_$_condition_$157 : bool;
	var $_$_condition_$159 : bool;
	var $_$_condition_$161 : bool;
	var $_$_condition_$163 : bool;
	var $_$_condition_$164 : bool;
	var $_$_condition_$165 : bool;
	var $_$_condition_$166 : bool;
	var $_$_condition_$167 : bool;
	var $_$_condition_$168 : bool;
	var $_$_condition_$169 : bool;
	var $_$_condition_$170 : bool;
	var $_$_condition_$171 : bool;
	var $_$_condition_$173 : bool;
	var $_$_condition_$174 : bool;
	var $_$_condition_$176 : bool;
	var $_$_condition_$177 : bool;
	var $_$_condition_$179 : bool;
	var $_$_condition_$180 : bool;
	var $_$_condition_$182 : bool;
	var $_$_condition_$183 : bool;
	var $_$_condition_$185 : bool;
	var $_$_condition_$186 : bool;
	var $_$_condition_$188 : bool;
	var $_$_condition_$189 : bool;
	var $_$_condition_$191 : bool;
$start:
	assume Permission$denominator > 0;
	assume (Permission$Zero[perm$R] == 0) && (Permission$Zero[perm$N] == 0);
	assume (Permission$Full[perm$R] == Permission$FullFraction) && (Permission$Full[perm$N] == 0);
	assume (((((forall  o_$25 : ref, f_$16 : Field (Boolean) , pc_$0 : PermissionComponent :: ( ZeroMask[o_$25,f_$16][pc_$0] == 0 ))) && ((forall  o_$26 : ref, f_$17 : Field (Integer) , pc_$1 : PermissionComponent :: ( ZeroMask[o_$26,f_$17][pc_$1] == 0 )))) && ((forall  o_$27 : ref, f_$18 : Field (ref) , pc_$2 : PermissionComponent :: ( ZeroMask[o_$27,f_$18][pc_$2] == 0 )))) && ((forall  o_$28 : ref, f_$19 : Field (Mu) , pc_$3 : PermissionComponent :: ( ZeroMask[o_$28,f_$19][pc_$3] == 0 )))) && ((forall  o_$29 : ref, f_$20 : Field (Seq (Integer) ) , pc_$4 : PermissionComponent :: ( ZeroMask[o_$29,f_$20][pc_$4] == 0 )));
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
	assume IsGoodState(emptyPartialHeap);
	assume NonPredicateField(mu);
	assume (forall  m : Mu, n_$0 : Mu :: {MuBelow(m,n_$0),MuBelow(n_$0,m)} ( !(MuBelow(m,n_$0) && MuBelow(n_$0,m)) ));
	assume (forall  m_$0 : Mu, n_$1 : Mu, o_$0 : Mu :: {MuBelow(m_$0,n_$1),MuBelow(n_$1,o_$0)} ( (MuBelow(m_$0,n_$1) && MuBelow(n_$1,o_$0)) ==> MuBelow(m_$0,o_$0) ));
	assume (forall  m_$1 : Mu, n_$2 : Mu :: ( MuBelow(m_$1,n_$2) ==> (!(n_$2 == $LockBottom)) ));
	assume NonPredicateField(held);
	assume NonPredicateField(rdheld);
	assume (forall  eh : HeapType, h_$0 : HeapType, m_$3 : MaskType, sm_$0 : MaskType :: {IsGoodExhaleState(eh,h_$0,m_$3,sm_$0)} ( IsGoodExhaleState(eh,h_$0,m_$3,sm_$0) <==> (((((((((((((forall  o_$6_$0 : ref, f_$1_$0 : Field (Boolean)  :: {eh[o_$6_$0,f_$1_$0]} ( CanRead(m_$3,sm_$0,o_$6_$0,f_$1_$0) ==> (eh[o_$6_$0,f_$1_$0] == h_$0[o_$6_$0,f_$1_$0]) ))) && ((forall  o_$6_$1 : ref, f_$1_$1 : Field (Integer)  :: {eh[o_$6_$1,f_$1_$1]} ( CanRead(m_$3,sm_$0,o_$6_$1,f_$1_$1) ==> (eh[o_$6_$1,f_$1_$1] == h_$0[o_$6_$1,f_$1_$1]) )))) && ((forall  o_$6_$2 : ref, f_$1_$2 : Field (ref)  :: {eh[o_$6_$2,f_$1_$2]} ( CanRead(m_$3,sm_$0,o_$6_$2,f_$1_$2) ==> (eh[o_$6_$2,f_$1_$2] == h_$0[o_$6_$2,f_$1_$2]) )))) && ((forall  o_$6_$3 : ref, f_$1_$3 : Field (Mu)  :: {eh[o_$6_$3,f_$1_$3]} ( CanRead(m_$3,sm_$0,o_$6_$3,f_$1_$3) ==> (eh[o_$6_$3,f_$1_$3] == h_$0[o_$6_$3,f_$1_$3]) )))) && ((forall  o_$6_$4 : ref, f_$1_$4 : Field (Seq (Integer) )  :: {eh[o_$6_$4,f_$1_$4]} ( CanRead(m_$3,sm_$0,o_$6_$4,f_$1_$4) ==> (eh[o_$6_$4,f_$1_$4] == h_$0[o_$6_$4,f_$1_$4]) )))) && ((forall  o_$7 : ref :: {eh[o_$7,held]} ( (0 < eh[o_$7,held]) <==> (0 < h_$0[o_$7,held]) )))) && ((forall  o_$8 : ref :: {eh[o_$8,rdheld]} ( eh[o_$8,rdheld] <==> h_$0[o_$8,rdheld] )))) && ((forall  o_$9 : ref :: {h_$0[o_$9,held]} ( (0 < h_$0[o_$9,held]) ==> (eh[o_$9,mu] == h_$0[o_$9,mu]) )))) && ((forall  o_$10 : ref :: {h_$0[o_$10,rdheld]} ( h_$0[o_$10,rdheld] ==> (eh[o_$10,mu] == h_$0[o_$10,mu]) )))) && ((forall  o_$11 : ref :: {h_$0[o_$11,forkK]} {eh[o_$11,forkK]} ( h_$0[o_$11,forkK] == eh[o_$11,forkK] )))) && ((forall  o_$12 : ref :: {h_$0[o_$12,held]} {eh[o_$12,held]} ( h_$0[o_$12,held] == eh[o_$12,held] )))) && ((forall  o_$13 : ref, f_$2 : Field (Integer)  :: {eh[o_$13,f_$2],PredicateField(f_$2)} ( PredicateField(f_$2) ==> (h_$0[o_$13,f_$2] <= eh[o_$13,f_$2]) )))) ));
	assume (((((forall  m_$4_$0 : MaskType, sm_$1_$0 : MaskType, obj_$2 : ref, f_$3_$0 : Field (Boolean)  :: {CanRead(m_$4_$0,sm_$1_$0,obj_$2,f_$3_$0)} ( CanRead(m_$4_$0,sm_$1_$0,obj_$2,f_$3_$0) <==> ((((0 < m_$4_$0[obj_$2,f_$3_$0][perm$R]) || (0 < m_$4_$0[obj_$2,f_$3_$0][perm$N])) || (0 < sm_$1_$0[obj_$2,f_$3_$0][perm$R])) || (0 < sm_$1_$0[obj_$2,f_$3_$0][perm$N])) ))) && ((forall  m_$4_$1 : MaskType, sm_$1_$1 : MaskType, obj_$3 : ref, f_$3_$1 : Field (Integer)  :: {CanRead(m_$4_$1,sm_$1_$1,obj_$3,f_$3_$1)} ( CanRead(m_$4_$1,sm_$1_$1,obj_$3,f_$3_$1) <==> ((((0 < m_$4_$1[obj_$3,f_$3_$1][perm$R]) || (0 < m_$4_$1[obj_$3,f_$3_$1][perm$N])) || (0 < sm_$1_$1[obj_$3,f_$3_$1][perm$R])) || (0 < sm_$1_$1[obj_$3,f_$3_$1][perm$N])) )))) && ((forall  m_$4_$2 : MaskType, sm_$1_$2 : MaskType, obj_$4 : ref, f_$3_$2 : Field (ref)  :: {CanRead(m_$4_$2,sm_$1_$2,obj_$4,f_$3_$2)} ( CanRead(m_$4_$2,sm_$1_$2,obj_$4,f_$3_$2) <==> ((((0 < m_$4_$2[obj_$4,f_$3_$2][perm$R]) || (0 < m_$4_$2[obj_$4,f_$3_$2][perm$N])) || (0 < sm_$1_$2[obj_$4,f_$3_$2][perm$R])) || (0 < sm_$1_$2[obj_$4,f_$3_$2][perm$N])) )))) && ((forall  m_$4_$3 : MaskType, sm_$1_$3 : MaskType, obj_$5 : ref, f_$3_$3 : Field (Mu)  :: {CanRead(m_$4_$3,sm_$1_$3,obj_$5,f_$3_$3)} ( CanRead(m_$4_$3,sm_$1_$3,obj_$5,f_$3_$3) <==> ((((0 < m_$4_$3[obj_$5,f_$3_$3][perm$R]) || (0 < m_$4_$3[obj_$5,f_$3_$3][perm$N])) || (0 < sm_$1_$3[obj_$5,f_$3_$3][perm$R])) || (0 < sm_$1_$3[obj_$5,f_$3_$3][perm$N])) )))) && ((forall  m_$4_$4 : MaskType, sm_$1_$4 : MaskType, obj_$6 : ref, f_$3_$4 : Field (Seq (Integer) )  :: {CanRead(m_$4_$4,sm_$1_$4,obj_$6,f_$3_$4)} ( CanRead(m_$4_$4,sm_$1_$4,obj_$6,f_$3_$4) <==> ((((0 < m_$4_$4[obj_$6,f_$3_$4][perm$R]) || (0 < m_$4_$4[obj_$6,f_$3_$4][perm$N])) || (0 < sm_$1_$4[obj_$6,f_$3_$4][perm$R])) || (0 < sm_$1_$4[obj_$6,f_$3_$4][perm$N])) )));
	assume (((((forall  m_$6_$0 : MaskType, obj_$1_$0 : ref, f_$5_$0 : Field (Boolean)  :: {CanWrite(m_$6_$0,obj_$1_$0,f_$5_$0)} ( CanWrite(m_$6_$0,obj_$1_$0,f_$5_$0) <==> ((m_$6_$0[obj_$1_$0,f_$5_$0][perm$R] == Permission$FullFraction) && (m_$6_$0[obj_$1_$0,f_$5_$0][perm$N] == 0)) ))) && ((forall  m_$6_$1 : MaskType, obj_$1_$1 : ref, f_$5_$1 : Field (Integer)  :: {CanWrite(m_$6_$1,obj_$1_$1,f_$5_$1)} ( CanWrite(m_$6_$1,obj_$1_$1,f_$5_$1) <==> ((m_$6_$1[obj_$1_$1,f_$5_$1][perm$R] == Permission$FullFraction) && (m_$6_$1[obj_$1_$1,f_$5_$1][perm$N] == 0)) )))) && ((forall  m_$6_$2 : MaskType, obj_$1_$2 : ref, f_$5_$2 : Field (ref)  :: {CanWrite(m_$6_$2,obj_$1_$2,f_$5_$2)} ( CanWrite(m_$6_$2,obj_$1_$2,f_$5_$2) <==> ((m_$6_$2[obj_$1_$2,f_$5_$2][perm$R] == Permission$FullFraction) && (m_$6_$2[obj_$1_$2,f_$5_$2][perm$N] == 0)) )))) && ((forall  m_$6_$3 : MaskType, obj_$1_$3 : ref, f_$5_$3 : Field (Mu)  :: {CanWrite(m_$6_$3,obj_$1_$3,f_$5_$3)} ( CanWrite(m_$6_$3,obj_$1_$3,f_$5_$3) <==> ((m_$6_$3[obj_$1_$3,f_$5_$3][perm$R] == Permission$FullFraction) && (m_$6_$3[obj_$1_$3,f_$5_$3][perm$N] == 0)) )))) && ((forall  m_$6_$4 : MaskType, obj_$1_$4 : ref, f_$5_$4 : Field (Seq (Integer) )  :: {CanWrite(m_$6_$4,obj_$1_$4,f_$5_$4)} ( CanWrite(m_$6_$4,obj_$1_$4,f_$5_$4) <==> ((m_$6_$4[obj_$1_$4,f_$5_$4][perm$R] == Permission$FullFraction) && (m_$6_$4[obj_$1_$4,f_$5_$4][perm$N] == 0)) )));
	assume (forall  m_$7 : MaskType :: {IsGoodMask(m_$7)} ( IsGoodMask(m_$7) <==> ((((((forall  o_$14_$0 : ref, f_$6_$0 : Field (Boolean)  :: ( ((0 <= m_$7[o_$14_$0,f_$6_$0][perm$R]) && (NonPredicateField(f_$6_$0) ==> ((m_$7[o_$14_$0,f_$6_$0][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$0,f_$6_$0][perm$N]) ==> (m_$7[o_$14_$0,f_$6_$0][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$0,f_$6_$0][perm$N] < 0) ==> (0 < m_$7[o_$14_$0,f_$6_$0][perm$R])) ))) && ((forall  o_$14_$1 : ref, f_$6_$1 : Field (Integer)  :: ( ((0 <= m_$7[o_$14_$1,f_$6_$1][perm$R]) && (NonPredicateField(f_$6_$1) ==> ((m_$7[o_$14_$1,f_$6_$1][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$1,f_$6_$1][perm$N]) ==> (m_$7[o_$14_$1,f_$6_$1][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$1,f_$6_$1][perm$N] < 0) ==> (0 < m_$7[o_$14_$1,f_$6_$1][perm$R])) )))) && ((forall  o_$14_$2 : ref, f_$6_$2 : Field (ref)  :: ( ((0 <= m_$7[o_$14_$2,f_$6_$2][perm$R]) && (NonPredicateField(f_$6_$2) ==> ((m_$7[o_$14_$2,f_$6_$2][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$2,f_$6_$2][perm$N]) ==> (m_$7[o_$14_$2,f_$6_$2][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$2,f_$6_$2][perm$N] < 0) ==> (0 < m_$7[o_$14_$2,f_$6_$2][perm$R])) )))) && ((forall  o_$14_$3 : ref, f_$6_$3 : Field (Mu)  :: ( ((0 <= m_$7[o_$14_$3,f_$6_$3][perm$R]) && (NonPredicateField(f_$6_$3) ==> ((m_$7[o_$14_$3,f_$6_$3][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$3,f_$6_$3][perm$N]) ==> (m_$7[o_$14_$3,f_$6_$3][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$3,f_$6_$3][perm$N] < 0) ==> (0 < m_$7[o_$14_$3,f_$6_$3][perm$R])) )))) && ((forall  o_$14_$4 : ref, f_$6_$4 : Field (Seq (Integer) )  :: ( ((0 <= m_$7[o_$14_$4,f_$6_$4][perm$R]) && (NonPredicateField(f_$6_$4) ==> ((m_$7[o_$14_$4,f_$6_$4][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14_$4,f_$6_$4][perm$N]) ==> (m_$7[o_$14_$4,f_$6_$4][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14_$4,f_$6_$4][perm$N] < 0) ==> (0 < m_$7[o_$14_$4,f_$6_$4][perm$R])) )))) ));
	assume (forall  h_$1 : HeapType, m_$8 : MaskType, sm_$2 : MaskType, o_$15 : ref, q : ref :: {wf(h_$1,m_$8,sm_$2),h_$1[o_$15,mu],h_$1[q,mu]} ( (((wf(h_$1,m_$8,sm_$2) && (!(o_$15 == q))) && ((0 < h_$1[o_$15,held]) || h_$1[o_$15,rdheld])) && ((0 < h_$1[q,held]) || h_$1[q,rdheld])) ==> (!(h_$1[o_$15,mu] == h_$1[q,mu])) ));
	assume (((((((((((((((((((((((((forall  m_$9_$0 : MaskType, o_$16_$0 : ref, f_$7_$0 : Field (Boolean) , howMuch_$3 : Integer, q_$0_$0 : ref, g_$4 : Field (Boolean)  :: {DecPerm(m_$9_$0,o_$16_$0,f_$7_$0,howMuch_$3)[q_$0_$0,g_$4][perm$R]} ( DecPerm(m_$9_$0,o_$16_$0,f_$7_$0,howMuch_$3)[q_$0_$0,g_$4][perm$R] == ite((o_$16_$0 == q_$0_$0) && (f_$7_$0 == g_$4),m_$9_$0[q_$0_$0,g_$4][perm$R] - howMuch_$3,m_$9_$0[q_$0_$0,g_$4][perm$R]) ))) && ((forall  m_$9_$1 : MaskType, o_$16_$1 : ref, f_$7_$1 : Field (Integer) , howMuch_$4 : Integer, q_$0_$1 : ref, g_$5 : Field (Boolean)  :: {DecPerm(m_$9_$1,o_$16_$1,f_$7_$1,howMuch_$4)[q_$0_$1,g_$5][perm$R]} ( DecPerm(m_$9_$1,o_$16_$1,f_$7_$1,howMuch_$4)[q_$0_$1,g_$5][perm$R] == ite((o_$16_$1 == q_$0_$1) && false,m_$9_$1[q_$0_$1,g_$5][perm$R] - howMuch_$4,m_$9_$1[q_$0_$1,g_$5][perm$R]) )))) && ((forall  m_$9_$2 : MaskType, o_$16_$2 : ref, f_$7_$2 : Field (ref) , howMuch_$5 : Integer, q_$0_$2 : ref, g_$6 : Field (Boolean)  :: {DecPerm(m_$9_$2,o_$16_$2,f_$7_$2,howMuch_$5)[q_$0_$2,g_$6][perm$R]} ( DecPerm(m_$9_$2,o_$16_$2,f_$7_$2,howMuch_$5)[q_$0_$2,g_$6][perm$R] == ite((o_$16_$2 == q_$0_$2) && false,m_$9_$2[q_$0_$2,g_$6][perm$R] - howMuch_$5,m_$9_$2[q_$0_$2,g_$6][perm$R]) )))) && ((forall  m_$9_$3 : MaskType, o_$16_$3 : ref, f_$7_$3 : Field (Mu) , howMuch_$6 : Integer, q_$0_$3 : ref, g_$7 : Field (Boolean)  :: {DecPerm(m_$9_$3,o_$16_$3,f_$7_$3,howMuch_$6)[q_$0_$3,g_$7][perm$R]} ( DecPerm(m_$9_$3,o_$16_$3,f_$7_$3,howMuch_$6)[q_$0_$3,g_$7][perm$R] == ite((o_$16_$3 == q_$0_$3) && false,m_$9_$3[q_$0_$3,g_$7][perm$R] - howMuch_$6,m_$9_$3[q_$0_$3,g_$7][perm$R]) )))) && ((forall  m_$9_$4 : MaskType, o_$16_$4 : ref, f_$7_$4 : Field (Seq (Integer) ) , howMuch_$7 : Integer, q_$0_$4 : ref, g_$8 : Field (Boolean)  :: {DecPerm(m_$9_$4,o_$16_$4,f_$7_$4,howMuch_$7)[q_$0_$4,g_$8][perm$R]} ( DecPerm(m_$9_$4,o_$16_$4,f_$7_$4,howMuch_$7)[q_$0_$4,g_$8][perm$R] == ite((o_$16_$4 == q_$0_$4) && false,m_$9_$4[q_$0_$4,g_$8][perm$R] - howMuch_$7,m_$9_$4[q_$0_$4,g_$8][perm$R]) )))) && ((forall  m_$9_$5 : MaskType, o_$16_$5 : ref, f_$7_$5 : Field (Boolean) , howMuch_$8 : Integer, q_$0_$5 : ref, g_$9 : Field (Integer)  :: {DecPerm(m_$9_$5,o_$16_$5,f_$7_$5,howMuch_$8)[q_$0_$5,g_$9][perm$R]} ( DecPerm(m_$9_$5,o_$16_$5,f_$7_$5,howMuch_$8)[q_$0_$5,g_$9][perm$R] == ite((o_$16_$5 == q_$0_$5) && false,m_$9_$5[q_$0_$5,g_$9][perm$R] - howMuch_$8,m_$9_$5[q_$0_$5,g_$9][perm$R]) )))) && ((forall  m_$9_$6 : MaskType, o_$16_$6 : ref, f_$7_$6 : Field (Integer) , howMuch_$9 : Integer, q_$0_$6 : ref, g_$10 : Field (Integer)  :: {DecPerm(m_$9_$6,o_$16_$6,f_$7_$6,howMuch_$9)[q_$0_$6,g_$10][perm$R]} ( DecPerm(m_$9_$6,o_$16_$6,f_$7_$6,howMuch_$9)[q_$0_$6,g_$10][perm$R] == ite((o_$16_$6 == q_$0_$6) && (f_$7_$6 == g_$10),m_$9_$6[q_$0_$6,g_$10][perm$R] - howMuch_$9,m_$9_$6[q_$0_$6,g_$10][perm$R]) )))) && ((forall  m_$9_$7 : MaskType, o_$16_$7 : ref, f_$7_$7 : Field (ref) , howMuch_$10 : Integer, q_$0_$7 : ref, g_$11 : Field (Integer)  :: {DecPerm(m_$9_$7,o_$16_$7,f_$7_$7,howMuch_$10)[q_$0_$7,g_$11][perm$R]} ( DecPerm(m_$9_$7,o_$16_$7,f_$7_$7,howMuch_$10)[q_$0_$7,g_$11][perm$R] == ite((o_$16_$7 == q_$0_$7) && false,m_$9_$7[q_$0_$7,g_$11][perm$R] - howMuch_$10,m_$9_$7[q_$0_$7,g_$11][perm$R]) )))) && ((forall  m_$9_$8 : MaskType, o_$16_$8 : ref, f_$7_$8 : Field (Mu) , howMuch_$11 : Integer, q_$0_$8 : ref, g_$12 : Field (Integer)  :: {DecPerm(m_$9_$8,o_$16_$8,f_$7_$8,howMuch_$11)[q_$0_$8,g_$12][perm$R]} ( DecPerm(m_$9_$8,o_$16_$8,f_$7_$8,howMuch_$11)[q_$0_$8,g_$12][perm$R] == ite((o_$16_$8 == q_$0_$8) && false,m_$9_$8[q_$0_$8,g_$12][perm$R] - howMuch_$11,m_$9_$8[q_$0_$8,g_$12][perm$R]) )))) && ((forall  m_$9_$9 : MaskType, o_$16_$9 : ref, f_$7_$9 : Field (Seq (Integer) ) , howMuch_$12 : Integer, q_$0_$9 : ref, g_$13 : Field (Integer)  :: {DecPerm(m_$9_$9,o_$16_$9,f_$7_$9,howMuch_$12)[q_$0_$9,g_$13][perm$R]} ( DecPerm(m_$9_$9,o_$16_$9,f_$7_$9,howMuch_$12)[q_$0_$9,g_$13][perm$R] == ite((o_$16_$9 == q_$0_$9) && false,m_$9_$9[q_$0_$9,g_$13][perm$R] - howMuch_$12,m_$9_$9[q_$0_$9,g_$13][perm$R]) )))) && ((forall  m_$9_$10 : MaskType, o_$16_$10 : ref, f_$7_$10 : Field (Boolean) , howMuch_$13 : Integer, q_$0_$10 : ref, g_$14 : Field (ref)  :: {DecPerm(m_$9_$10,o_$16_$10,f_$7_$10,howMuch_$13)[q_$0_$10,g_$14][perm$R]} ( DecPerm(m_$9_$10,o_$16_$10,f_$7_$10,howMuch_$13)[q_$0_$10,g_$14][perm$R] == ite((o_$16_$10 == q_$0_$10) && false,m_$9_$10[q_$0_$10,g_$14][perm$R] - howMuch_$13,m_$9_$10[q_$0_$10,g_$14][perm$R]) )))) && ((forall  m_$9_$11 : MaskType, o_$16_$11 : ref, f_$7_$11 : Field (Integer) , howMuch_$14 : Integer, q_$0_$11 : ref, g_$15 : Field (ref)  :: {DecPerm(m_$9_$11,o_$16_$11,f_$7_$11,howMuch_$14)[q_$0_$11,g_$15][perm$R]} ( DecPerm(m_$9_$11,o_$16_$11,f_$7_$11,howMuch_$14)[q_$0_$11,g_$15][perm$R] == ite((o_$16_$11 == q_$0_$11) && false,m_$9_$11[q_$0_$11,g_$15][perm$R] - howMuch_$14,m_$9_$11[q_$0_$11,g_$15][perm$R]) )))) && ((forall  m_$9_$12 : MaskType, o_$16_$12 : ref, f_$7_$12 : Field (ref) , howMuch_$15 : Integer, q_$0_$12 : ref, g_$16 : Field (ref)  :: {DecPerm(m_$9_$12,o_$16_$12,f_$7_$12,howMuch_$15)[q_$0_$12,g_$16][perm$R]} ( DecPerm(m_$9_$12,o_$16_$12,f_$7_$12,howMuch_$15)[q_$0_$12,g_$16][perm$R] == ite((o_$16_$12 == q_$0_$12) && (f_$7_$12 == g_$16),m_$9_$12[q_$0_$12,g_$16][perm$R] - howMuch_$15,m_$9_$12[q_$0_$12,g_$16][perm$R]) )))) && ((forall  m_$9_$13 : MaskType, o_$16_$13 : ref, f_$7_$13 : Field (Mu) , howMuch_$16 : Integer, q_$0_$13 : ref, g_$17 : Field (ref)  :: {DecPerm(m_$9_$13,o_$16_$13,f_$7_$13,howMuch_$16)[q_$0_$13,g_$17][perm$R]} ( DecPerm(m_$9_$13,o_$16_$13,f_$7_$13,howMuch_$16)[q_$0_$13,g_$17][perm$R] == ite((o_$16_$13 == q_$0_$13) && false,m_$9_$13[q_$0_$13,g_$17][perm$R] - howMuch_$16,m_$9_$13[q_$0_$13,g_$17][perm$R]) )))) && ((forall  m_$9_$14 : MaskType, o_$16_$14 : ref, f_$7_$14 : Field (Seq (Integer) ) , howMuch_$17 : Integer, q_$0_$14 : ref, g_$18 : Field (ref)  :: {DecPerm(m_$9_$14,o_$16_$14,f_$7_$14,howMuch_$17)[q_$0_$14,g_$18][perm$R]} ( DecPerm(m_$9_$14,o_$16_$14,f_$7_$14,howMuch_$17)[q_$0_$14,g_$18][perm$R] == ite((o_$16_$14 == q_$0_$14) && false,m_$9_$14[q_$0_$14,g_$18][perm$R] - howMuch_$17,m_$9_$14[q_$0_$14,g_$18][perm$R]) )))) && ((forall  m_$9_$15 : MaskType, o_$16_$15 : ref, f_$7_$15 : Field (Boolean) , howMuch_$18 : Integer, q_$0_$15 : ref, g_$19 : Field (Mu)  :: {DecPerm(m_$9_$15,o_$16_$15,f_$7_$15,howMuch_$18)[q_$0_$15,g_$19][perm$R]} ( DecPerm(m_$9_$15,o_$16_$15,f_$7_$15,howMuch_$18)[q_$0_$15,g_$19][perm$R] == ite((o_$16_$15 == q_$0_$15) && false,m_$9_$15[q_$0_$15,g_$19][perm$R] - howMuch_$18,m_$9_$15[q_$0_$15,g_$19][perm$R]) )))) && ((forall  m_$9_$16 : MaskType, o_$16_$16 : ref, f_$7_$16 : Field (Integer) , howMuch_$19 : Integer, q_$0_$16 : ref, g_$20 : Field (Mu)  :: {DecPerm(m_$9_$16,o_$16_$16,f_$7_$16,howMuch_$19)[q_$0_$16,g_$20][perm$R]} ( DecPerm(m_$9_$16,o_$16_$16,f_$7_$16,howMuch_$19)[q_$0_$16,g_$20][perm$R] == ite((o_$16_$16 == q_$0_$16) && false,m_$9_$16[q_$0_$16,g_$20][perm$R] - howMuch_$19,m_$9_$16[q_$0_$16,g_$20][perm$R]) )))) && ((forall  m_$9_$17 : MaskType, o_$16_$17 : ref, f_$7_$17 : Field (ref) , howMuch_$20 : Integer, q_$0_$17 : ref, g_$21 : Field (Mu)  :: {DecPerm(m_$9_$17,o_$16_$17,f_$7_$17,howMuch_$20)[q_$0_$17,g_$21][perm$R]} ( DecPerm(m_$9_$17,o_$16_$17,f_$7_$17,howMuch_$20)[q_$0_$17,g_$21][perm$R] == ite((o_$16_$17 == q_$0_$17) && false,m_$9_$17[q_$0_$17,g_$21][perm$R] - howMuch_$20,m_$9_$17[q_$0_$17,g_$21][perm$R]) )))) && ((forall  m_$9_$18 : MaskType, o_$16_$18 : ref, f_$7_$18 : Field (Mu) , howMuch_$21 : Integer, q_$0_$18 : ref, g_$22 : Field (Mu)  :: {DecPerm(m_$9_$18,o_$16_$18,f_$7_$18,howMuch_$21)[q_$0_$18,g_$22][perm$R]} ( DecPerm(m_$9_$18,o_$16_$18,f_$7_$18,howMuch_$21)[q_$0_$18,g_$22][perm$R] == ite((o_$16_$18 == q_$0_$18) && (f_$7_$18 == g_$22),m_$9_$18[q_$0_$18,g_$22][perm$R] - howMuch_$21,m_$9_$18[q_$0_$18,g_$22][perm$R]) )))) && ((forall  m_$9_$19 : MaskType, o_$16_$19 : ref, f_$7_$19 : Field (Seq (Integer) ) , howMuch_$22 : Integer, q_$0_$19 : ref, g_$23 : Field (Mu)  :: {DecPerm(m_$9_$19,o_$16_$19,f_$7_$19,howMuch_$22)[q_$0_$19,g_$23][perm$R]} ( DecPerm(m_$9_$19,o_$16_$19,f_$7_$19,howMuch_$22)[q_$0_$19,g_$23][perm$R] == ite((o_$16_$19 == q_$0_$19) && false,m_$9_$19[q_$0_$19,g_$23][perm$R] - howMuch_$22,m_$9_$19[q_$0_$19,g_$23][perm$R]) )))) && ((forall  m_$9_$20 : MaskType, o_$16_$20 : ref, f_$7_$20 : Field (Boolean) , howMuch_$23 : Integer, q_$0_$20 : ref, g_$24 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$20,o_$16_$20,f_$7_$20,howMuch_$23)[q_$0_$20,g_$24][perm$R]} ( DecPerm(m_$9_$20,o_$16_$20,f_$7_$20,howMuch_$23)[q_$0_$20,g_$24][perm$R] == ite((o_$16_$20 == q_$0_$20) && false,m_$9_$20[q_$0_$20,g_$24][perm$R] - howMuch_$23,m_$9_$20[q_$0_$20,g_$24][perm$R]) )))) && ((forall  m_$9_$21 : MaskType, o_$16_$21 : ref, f_$7_$21 : Field (Integer) , howMuch_$24 : Integer, q_$0_$21 : ref, g_$25 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$21,o_$16_$21,f_$7_$21,howMuch_$24)[q_$0_$21,g_$25][perm$R]} ( DecPerm(m_$9_$21,o_$16_$21,f_$7_$21,howMuch_$24)[q_$0_$21,g_$25][perm$R] == ite((o_$16_$21 == q_$0_$21) && false,m_$9_$21[q_$0_$21,g_$25][perm$R] - howMuch_$24,m_$9_$21[q_$0_$21,g_$25][perm$R]) )))) && ((forall  m_$9_$22 : MaskType, o_$16_$22 : ref, f_$7_$22 : Field (ref) , howMuch_$25 : Integer, q_$0_$22 : ref, g_$26 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$22,o_$16_$22,f_$7_$22,howMuch_$25)[q_$0_$22,g_$26][perm$R]} ( DecPerm(m_$9_$22,o_$16_$22,f_$7_$22,howMuch_$25)[q_$0_$22,g_$26][perm$R] == ite((o_$16_$22 == q_$0_$22) && false,m_$9_$22[q_$0_$22,g_$26][perm$R] - howMuch_$25,m_$9_$22[q_$0_$22,g_$26][perm$R]) )))) && ((forall  m_$9_$23 : MaskType, o_$16_$23 : ref, f_$7_$23 : Field (Mu) , howMuch_$26 : Integer, q_$0_$23 : ref, g_$27 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$23,o_$16_$23,f_$7_$23,howMuch_$26)[q_$0_$23,g_$27][perm$R]} ( DecPerm(m_$9_$23,o_$16_$23,f_$7_$23,howMuch_$26)[q_$0_$23,g_$27][perm$R] == ite((o_$16_$23 == q_$0_$23) && false,m_$9_$23[q_$0_$23,g_$27][perm$R] - howMuch_$26,m_$9_$23[q_$0_$23,g_$27][perm$R]) )))) && ((forall  m_$9_$24 : MaskType, o_$16_$24 : ref, f_$7_$24 : Field (Seq (Integer) ) , howMuch_$27 : Integer, q_$0_$24 : ref, g_$28 : Field (Seq (Integer) )  :: {DecPerm(m_$9_$24,o_$16_$24,f_$7_$24,howMuch_$27)[q_$0_$24,g_$28][perm$R]} ( DecPerm(m_$9_$24,o_$16_$24,f_$7_$24,howMuch_$27)[q_$0_$24,g_$28][perm$R] == ite((o_$16_$24 == q_$0_$24) && (f_$7_$24 == g_$28),m_$9_$24[q_$0_$24,g_$28][perm$R] - howMuch_$27,m_$9_$24[q_$0_$24,g_$28][perm$R]) )));
	assume (((((((((((((((((((((((((forall  m_$11_$0 : MaskType, o_$18_$0 : ref, f_$9_$0 : Field (Boolean) , howMuch_$1_$0 : Integer, q_$2_$0 : ref, g_$1_$0 : Field (Boolean)  :: {IncPerm(m_$11_$0,o_$18_$0,f_$9_$0,howMuch_$1_$0)[q_$2_$0,g_$1_$0][perm$R]} ( IncPerm(m_$11_$0,o_$18_$0,f_$9_$0,howMuch_$1_$0)[q_$2_$0,g_$1_$0][perm$R] == ite((o_$18_$0 == q_$2_$0) && (f_$9_$0 == g_$1_$0),m_$11_$0[q_$2_$0,g_$1_$0][perm$R] + howMuch_$1_$0,m_$11_$0[q_$2_$0,g_$1_$0][perm$R]) ))) && ((forall  m_$11_$1 : MaskType, o_$18_$1 : ref, f_$9_$1 : Field (Integer) , howMuch_$1_$1 : Integer, q_$2_$1 : ref, g_$1_$1 : Field (Boolean)  :: {IncPerm(m_$11_$1,o_$18_$1,f_$9_$1,howMuch_$1_$1)[q_$2_$1,g_$1_$1][perm$R]} ( IncPerm(m_$11_$1,o_$18_$1,f_$9_$1,howMuch_$1_$1)[q_$2_$1,g_$1_$1][perm$R] == ite((o_$18_$1 == q_$2_$1) && false,m_$11_$1[q_$2_$1,g_$1_$1][perm$R] + howMuch_$1_$1,m_$11_$1[q_$2_$1,g_$1_$1][perm$R]) )))) && ((forall  m_$11_$2 : MaskType, o_$18_$2 : ref, f_$9_$2 : Field (ref) , howMuch_$1_$2 : Integer, q_$2_$2 : ref, g_$1_$2 : Field (Boolean)  :: {IncPerm(m_$11_$2,o_$18_$2,f_$9_$2,howMuch_$1_$2)[q_$2_$2,g_$1_$2][perm$R]} ( IncPerm(m_$11_$2,o_$18_$2,f_$9_$2,howMuch_$1_$2)[q_$2_$2,g_$1_$2][perm$R] == ite((o_$18_$2 == q_$2_$2) && false,m_$11_$2[q_$2_$2,g_$1_$2][perm$R] + howMuch_$1_$2,m_$11_$2[q_$2_$2,g_$1_$2][perm$R]) )))) && ((forall  m_$11_$3 : MaskType, o_$18_$3 : ref, f_$9_$3 : Field (Mu) , howMuch_$1_$3 : Integer, q_$2_$3 : ref, g_$1_$3 : Field (Boolean)  :: {IncPerm(m_$11_$3,o_$18_$3,f_$9_$3,howMuch_$1_$3)[q_$2_$3,g_$1_$3][perm$R]} ( IncPerm(m_$11_$3,o_$18_$3,f_$9_$3,howMuch_$1_$3)[q_$2_$3,g_$1_$3][perm$R] == ite((o_$18_$3 == q_$2_$3) && false,m_$11_$3[q_$2_$3,g_$1_$3][perm$R] + howMuch_$1_$3,m_$11_$3[q_$2_$3,g_$1_$3][perm$R]) )))) && ((forall  m_$11_$4 : MaskType, o_$18_$4 : ref, f_$9_$4 : Field (Seq (Integer) ) , howMuch_$1_$4 : Integer, q_$2_$4 : ref, g_$1_$4 : Field (Boolean)  :: {IncPerm(m_$11_$4,o_$18_$4,f_$9_$4,howMuch_$1_$4)[q_$2_$4,g_$1_$4][perm$R]} ( IncPerm(m_$11_$4,o_$18_$4,f_$9_$4,howMuch_$1_$4)[q_$2_$4,g_$1_$4][perm$R] == ite((o_$18_$4 == q_$2_$4) && false,m_$11_$4[q_$2_$4,g_$1_$4][perm$R] + howMuch_$1_$4,m_$11_$4[q_$2_$4,g_$1_$4][perm$R]) )))) && ((forall  m_$11_$5 : MaskType, o_$18_$5 : ref, f_$9_$5 : Field (Boolean) , howMuch_$1_$5 : Integer, q_$2_$5 : ref, g_$1_$5 : Field (Integer)  :: {IncPerm(m_$11_$5,o_$18_$5,f_$9_$5,howMuch_$1_$5)[q_$2_$5,g_$1_$5][perm$R]} ( IncPerm(m_$11_$5,o_$18_$5,f_$9_$5,howMuch_$1_$5)[q_$2_$5,g_$1_$5][perm$R] == ite((o_$18_$5 == q_$2_$5) && false,m_$11_$5[q_$2_$5,g_$1_$5][perm$R] + howMuch_$1_$5,m_$11_$5[q_$2_$5,g_$1_$5][perm$R]) )))) && ((forall  m_$11_$6 : MaskType, o_$18_$6 : ref, f_$9_$6 : Field (Integer) , howMuch_$1_$6 : Integer, q_$2_$6 : ref, g_$1_$6 : Field (Integer)  :: {IncPerm(m_$11_$6,o_$18_$6,f_$9_$6,howMuch_$1_$6)[q_$2_$6,g_$1_$6][perm$R]} ( IncPerm(m_$11_$6,o_$18_$6,f_$9_$6,howMuch_$1_$6)[q_$2_$6,g_$1_$6][perm$R] == ite((o_$18_$6 == q_$2_$6) && (f_$9_$6 == g_$1_$6),m_$11_$6[q_$2_$6,g_$1_$6][perm$R] + howMuch_$1_$6,m_$11_$6[q_$2_$6,g_$1_$6][perm$R]) )))) && ((forall  m_$11_$7 : MaskType, o_$18_$7 : ref, f_$9_$7 : Field (ref) , howMuch_$1_$7 : Integer, q_$2_$7 : ref, g_$1_$7 : Field (Integer)  :: {IncPerm(m_$11_$7,o_$18_$7,f_$9_$7,howMuch_$1_$7)[q_$2_$7,g_$1_$7][perm$R]} ( IncPerm(m_$11_$7,o_$18_$7,f_$9_$7,howMuch_$1_$7)[q_$2_$7,g_$1_$7][perm$R] == ite((o_$18_$7 == q_$2_$7) && false,m_$11_$7[q_$2_$7,g_$1_$7][perm$R] + howMuch_$1_$7,m_$11_$7[q_$2_$7,g_$1_$7][perm$R]) )))) && ((forall  m_$11_$8 : MaskType, o_$18_$8 : ref, f_$9_$8 : Field (Mu) , howMuch_$1_$8 : Integer, q_$2_$8 : ref, g_$1_$8 : Field (Integer)  :: {IncPerm(m_$11_$8,o_$18_$8,f_$9_$8,howMuch_$1_$8)[q_$2_$8,g_$1_$8][perm$R]} ( IncPerm(m_$11_$8,o_$18_$8,f_$9_$8,howMuch_$1_$8)[q_$2_$8,g_$1_$8][perm$R] == ite((o_$18_$8 == q_$2_$8) && false,m_$11_$8[q_$2_$8,g_$1_$8][perm$R] + howMuch_$1_$8,m_$11_$8[q_$2_$8,g_$1_$8][perm$R]) )))) && ((forall  m_$11_$9 : MaskType, o_$18_$9 : ref, f_$9_$9 : Field (Seq (Integer) ) , howMuch_$1_$9 : Integer, q_$2_$9 : ref, g_$1_$9 : Field (Integer)  :: {IncPerm(m_$11_$9,o_$18_$9,f_$9_$9,howMuch_$1_$9)[q_$2_$9,g_$1_$9][perm$R]} ( IncPerm(m_$11_$9,o_$18_$9,f_$9_$9,howMuch_$1_$9)[q_$2_$9,g_$1_$9][perm$R] == ite((o_$18_$9 == q_$2_$9) && false,m_$11_$9[q_$2_$9,g_$1_$9][perm$R] + howMuch_$1_$9,m_$11_$9[q_$2_$9,g_$1_$9][perm$R]) )))) && ((forall  m_$11_$10 : MaskType, o_$18_$10 : ref, f_$9_$10 : Field (Boolean) , howMuch_$1_$10 : Integer, q_$2_$10 : ref, g_$1_$10 : Field (ref)  :: {IncPerm(m_$11_$10,o_$18_$10,f_$9_$10,howMuch_$1_$10)[q_$2_$10,g_$1_$10][perm$R]} ( IncPerm(m_$11_$10,o_$18_$10,f_$9_$10,howMuch_$1_$10)[q_$2_$10,g_$1_$10][perm$R] == ite((o_$18_$10 == q_$2_$10) && false,m_$11_$10[q_$2_$10,g_$1_$10][perm$R] + howMuch_$1_$10,m_$11_$10[q_$2_$10,g_$1_$10][perm$R]) )))) && ((forall  m_$11_$11 : MaskType, o_$18_$11 : ref, f_$9_$11 : Field (Integer) , howMuch_$1_$11 : Integer, q_$2_$11 : ref, g_$1_$11 : Field (ref)  :: {IncPerm(m_$11_$11,o_$18_$11,f_$9_$11,howMuch_$1_$11)[q_$2_$11,g_$1_$11][perm$R]} ( IncPerm(m_$11_$11,o_$18_$11,f_$9_$11,howMuch_$1_$11)[q_$2_$11,g_$1_$11][perm$R] == ite((o_$18_$11 == q_$2_$11) && false,m_$11_$11[q_$2_$11,g_$1_$11][perm$R] + howMuch_$1_$11,m_$11_$11[q_$2_$11,g_$1_$11][perm$R]) )))) && ((forall  m_$11_$12 : MaskType, o_$18_$12 : ref, f_$9_$12 : Field (ref) , howMuch_$1_$12 : Integer, q_$2_$12 : ref, g_$1_$12 : Field (ref)  :: {IncPerm(m_$11_$12,o_$18_$12,f_$9_$12,howMuch_$1_$12)[q_$2_$12,g_$1_$12][perm$R]} ( IncPerm(m_$11_$12,o_$18_$12,f_$9_$12,howMuch_$1_$12)[q_$2_$12,g_$1_$12][perm$R] == ite((o_$18_$12 == q_$2_$12) && (f_$9_$12 == g_$1_$12),m_$11_$12[q_$2_$12,g_$1_$12][perm$R] + howMuch_$1_$12,m_$11_$12[q_$2_$12,g_$1_$12][perm$R]) )))) && ((forall  m_$11_$13 : MaskType, o_$18_$13 : ref, f_$9_$13 : Field (Mu) , howMuch_$1_$13 : Integer, q_$2_$13 : ref, g_$1_$13 : Field (ref)  :: {IncPerm(m_$11_$13,o_$18_$13,f_$9_$13,howMuch_$1_$13)[q_$2_$13,g_$1_$13][perm$R]} ( IncPerm(m_$11_$13,o_$18_$13,f_$9_$13,howMuch_$1_$13)[q_$2_$13,g_$1_$13][perm$R] == ite((o_$18_$13 == q_$2_$13) && false,m_$11_$13[q_$2_$13,g_$1_$13][perm$R] + howMuch_$1_$13,m_$11_$13[q_$2_$13,g_$1_$13][perm$R]) )))) && ((forall  m_$11_$14 : MaskType, o_$18_$14 : ref, f_$9_$14 : Field (Seq (Integer) ) , howMuch_$1_$14 : Integer, q_$2_$14 : ref, g_$1_$14 : Field (ref)  :: {IncPerm(m_$11_$14,o_$18_$14,f_$9_$14,howMuch_$1_$14)[q_$2_$14,g_$1_$14][perm$R]} ( IncPerm(m_$11_$14,o_$18_$14,f_$9_$14,howMuch_$1_$14)[q_$2_$14,g_$1_$14][perm$R] == ite((o_$18_$14 == q_$2_$14) && false,m_$11_$14[q_$2_$14,g_$1_$14][perm$R] + howMuch_$1_$14,m_$11_$14[q_$2_$14,g_$1_$14][perm$R]) )))) && ((forall  m_$11_$15 : MaskType, o_$18_$15 : ref, f_$9_$15 : Field (Boolean) , howMuch_$1_$15 : Integer, q_$2_$15 : ref, g_$1_$15 : Field (Mu)  :: {IncPerm(m_$11_$15,o_$18_$15,f_$9_$15,howMuch_$1_$15)[q_$2_$15,g_$1_$15][perm$R]} ( IncPerm(m_$11_$15,o_$18_$15,f_$9_$15,howMuch_$1_$15)[q_$2_$15,g_$1_$15][perm$R] == ite((o_$18_$15 == q_$2_$15) && false,m_$11_$15[q_$2_$15,g_$1_$15][perm$R] + howMuch_$1_$15,m_$11_$15[q_$2_$15,g_$1_$15][perm$R]) )))) && ((forall  m_$11_$16 : MaskType, o_$18_$16 : ref, f_$9_$16 : Field (Integer) , howMuch_$1_$16 : Integer, q_$2_$16 : ref, g_$1_$16 : Field (Mu)  :: {IncPerm(m_$11_$16,o_$18_$16,f_$9_$16,howMuch_$1_$16)[q_$2_$16,g_$1_$16][perm$R]} ( IncPerm(m_$11_$16,o_$18_$16,f_$9_$16,howMuch_$1_$16)[q_$2_$16,g_$1_$16][perm$R] == ite((o_$18_$16 == q_$2_$16) && false,m_$11_$16[q_$2_$16,g_$1_$16][perm$R] + howMuch_$1_$16,m_$11_$16[q_$2_$16,g_$1_$16][perm$R]) )))) && ((forall  m_$11_$17 : MaskType, o_$18_$17 : ref, f_$9_$17 : Field (ref) , howMuch_$1_$17 : Integer, q_$2_$17 : ref, g_$1_$17 : Field (Mu)  :: {IncPerm(m_$11_$17,o_$18_$17,f_$9_$17,howMuch_$1_$17)[q_$2_$17,g_$1_$17][perm$R]} ( IncPerm(m_$11_$17,o_$18_$17,f_$9_$17,howMuch_$1_$17)[q_$2_$17,g_$1_$17][perm$R] == ite((o_$18_$17 == q_$2_$17) && false,m_$11_$17[q_$2_$17,g_$1_$17][perm$R] + howMuch_$1_$17,m_$11_$17[q_$2_$17,g_$1_$17][perm$R]) )))) && ((forall  m_$11_$18 : MaskType, o_$18_$18 : ref, f_$9_$18 : Field (Mu) , howMuch_$1_$18 : Integer, q_$2_$18 : ref, g_$1_$18 : Field (Mu)  :: {IncPerm(m_$11_$18,o_$18_$18,f_$9_$18,howMuch_$1_$18)[q_$2_$18,g_$1_$18][perm$R]} ( IncPerm(m_$11_$18,o_$18_$18,f_$9_$18,howMuch_$1_$18)[q_$2_$18,g_$1_$18][perm$R] == ite((o_$18_$18 == q_$2_$18) && (f_$9_$18 == g_$1_$18),m_$11_$18[q_$2_$18,g_$1_$18][perm$R] + howMuch_$1_$18,m_$11_$18[q_$2_$18,g_$1_$18][perm$R]) )))) && ((forall  m_$11_$19 : MaskType, o_$18_$19 : ref, f_$9_$19 : Field (Seq (Integer) ) , howMuch_$1_$19 : Integer, q_$2_$19 : ref, g_$1_$19 : Field (Mu)  :: {IncPerm(m_$11_$19,o_$18_$19,f_$9_$19,howMuch_$1_$19)[q_$2_$19,g_$1_$19][perm$R]} ( IncPerm(m_$11_$19,o_$18_$19,f_$9_$19,howMuch_$1_$19)[q_$2_$19,g_$1_$19][perm$R] == ite((o_$18_$19 == q_$2_$19) && false,m_$11_$19[q_$2_$19,g_$1_$19][perm$R] + howMuch_$1_$19,m_$11_$19[q_$2_$19,g_$1_$19][perm$R]) )))) && ((forall  m_$11_$20 : MaskType, o_$18_$20 : ref, f_$9_$20 : Field (Boolean) , howMuch_$1_$20 : Integer, q_$2_$20 : ref, g_$1_$20 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$20,o_$18_$20,f_$9_$20,howMuch_$1_$20)[q_$2_$20,g_$1_$20][perm$R]} ( IncPerm(m_$11_$20,o_$18_$20,f_$9_$20,howMuch_$1_$20)[q_$2_$20,g_$1_$20][perm$R] == ite((o_$18_$20 == q_$2_$20) && false,m_$11_$20[q_$2_$20,g_$1_$20][perm$R] + howMuch_$1_$20,m_$11_$20[q_$2_$20,g_$1_$20][perm$R]) )))) && ((forall  m_$11_$21 : MaskType, o_$18_$21 : ref, f_$9_$21 : Field (Integer) , howMuch_$1_$21 : Integer, q_$2_$21 : ref, g_$1_$21 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$21,o_$18_$21,f_$9_$21,howMuch_$1_$21)[q_$2_$21,g_$1_$21][perm$R]} ( IncPerm(m_$11_$21,o_$18_$21,f_$9_$21,howMuch_$1_$21)[q_$2_$21,g_$1_$21][perm$R] == ite((o_$18_$21 == q_$2_$21) && false,m_$11_$21[q_$2_$21,g_$1_$21][perm$R] + howMuch_$1_$21,m_$11_$21[q_$2_$21,g_$1_$21][perm$R]) )))) && ((forall  m_$11_$22 : MaskType, o_$18_$22 : ref, f_$9_$22 : Field (ref) , howMuch_$1_$22 : Integer, q_$2_$22 : ref, g_$1_$22 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$22,o_$18_$22,f_$9_$22,howMuch_$1_$22)[q_$2_$22,g_$1_$22][perm$R]} ( IncPerm(m_$11_$22,o_$18_$22,f_$9_$22,howMuch_$1_$22)[q_$2_$22,g_$1_$22][perm$R] == ite((o_$18_$22 == q_$2_$22) && false,m_$11_$22[q_$2_$22,g_$1_$22][perm$R] + howMuch_$1_$22,m_$11_$22[q_$2_$22,g_$1_$22][perm$R]) )))) && ((forall  m_$11_$23 : MaskType, o_$18_$23 : ref, f_$9_$23 : Field (Mu) , howMuch_$1_$23 : Integer, q_$2_$23 : ref, g_$1_$23 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$23,o_$18_$23,f_$9_$23,howMuch_$1_$23)[q_$2_$23,g_$1_$23][perm$R]} ( IncPerm(m_$11_$23,o_$18_$23,f_$9_$23,howMuch_$1_$23)[q_$2_$23,g_$1_$23][perm$R] == ite((o_$18_$23 == q_$2_$23) && false,m_$11_$23[q_$2_$23,g_$1_$23][perm$R] + howMuch_$1_$23,m_$11_$23[q_$2_$23,g_$1_$23][perm$R]) )))) && ((forall  m_$11_$24 : MaskType, o_$18_$24 : ref, f_$9_$24 : Field (Seq (Integer) ) , howMuch_$1_$24 : Integer, q_$2_$24 : ref, g_$1_$24 : Field (Seq (Integer) )  :: {IncPerm(m_$11_$24,o_$18_$24,f_$9_$24,howMuch_$1_$24)[q_$2_$24,g_$1_$24][perm$R]} ( IncPerm(m_$11_$24,o_$18_$24,f_$9_$24,howMuch_$1_$24)[q_$2_$24,g_$1_$24][perm$R] == ite((o_$18_$24 == q_$2_$24) && (f_$9_$24 == g_$1_$24),m_$11_$24[q_$2_$24,g_$1_$24][perm$R] + howMuch_$1_$24,m_$11_$24[q_$2_$24,g_$1_$24][perm$R]) )));
	assume (forall  o_$22 : ref :: ( ZeroCredits[o_$22] == 0 ));
	assume (((((forall  f_$13_$0 : Field (Boolean)  :: ( NonPredicateField(f_$13_$0) ==> (!PredicateField(f_$13_$0)) ))) && ((forall  f_$13_$1 : Field (Integer)  :: ( NonPredicateField(f_$13_$1) ==> (!PredicateField(f_$13_$1)) )))) && ((forall  f_$13_$2 : Field (ref)  :: ( NonPredicateField(f_$13_$2) ==> (!PredicateField(f_$13_$2)) )))) && ((forall  f_$13_$3 : Field (Mu)  :: ( NonPredicateField(f_$13_$3) ==> (!PredicateField(f_$13_$3)) )))) && ((forall  f_$13_$4 : Field (Seq (Integer) )  :: ( NonPredicateField(f_$13_$4) ==> (!PredicateField(f_$13_$4)) )));
	assume (((((forall  f_$14_$0 : Field (Boolean)  :: ( PredicateField(f_$14_$0) ==> (!NonPredicateField(f_$14_$0)) ))) && ((forall  f_$14_$1 : Field (Integer)  :: ( PredicateField(f_$14_$1) ==> (!NonPredicateField(f_$14_$1)) )))) && ((forall  f_$14_$2 : Field (ref)  :: ( PredicateField(f_$14_$2) ==> (!NonPredicateField(f_$14_$2)) )))) && ((forall  f_$14_$3 : Field (Mu)  :: ( PredicateField(f_$14_$3) ==> (!NonPredicateField(f_$14_$3)) )))) && ((forall  f_$14_$4 : Field (Seq (Integer) )  :: ( PredicateField(f_$14_$4) ==> (!NonPredicateField(f_$14_$4)) )));
	assume (((((((((((((((((((forall  con_$1 : Boolean, a_$0_$0 : Boolean, b_$0_$0 : Boolean :: {ite(con_$1,a_$0_$0,b_$0_$0)} ( con_$1 ==> (ite(con_$1,a_$0_$0,b_$0_$0) == a_$0_$0) ))) && ((forall  con_$2 : Boolean, a_$0_$1 : Integer, b_$0_$1 : Integer :: {ite(con_$2,a_$0_$1,b_$0_$1)} ( con_$2 ==> (ite(con_$2,a_$0_$1,b_$0_$1) == a_$0_$1) )))) && ((forall  con_$3 : Boolean, a_$0_$2 : [PermissionComponent]Integer, b_$0_$2 : [PermissionComponent]Integer :: {ite(con_$3,a_$0_$2,b_$0_$2)} ( con_$3 ==> (ite(con_$3,a_$0_$2,b_$0_$2) == a_$0_$2) )))) && ((forall  con_$4 : Boolean, a_$0_$3 : PermissionComponent, b_$0_$3 : PermissionComponent :: {ite(con_$4,a_$0_$3,b_$0_$3)} ( con_$4 ==> (ite(con_$4,a_$0_$3,b_$0_$3) == a_$0_$3) )))) && ((forall  con_$5 : Boolean, a_$0_$4 : MaskType, b_$0_$4 : MaskType :: {ite(con_$5,a_$0_$4,b_$0_$4)} ( con_$5 ==> (ite(con_$5,a_$0_$4,b_$0_$4) == a_$0_$4) )))) && ((forall  con_$6 : Boolean, a_$0_$5 : ref, b_$0_$5 : ref :: {ite(con_$6,a_$0_$5,b_$0_$5)} ( con_$6 ==> (ite(con_$6,a_$0_$5,b_$0_$5) == a_$0_$5) )))) && ((forall  con_$7 : Boolean, a_$0_$6 : Field (Integer) , b_$0_$6 : Field (Integer)  :: {ite(con_$7,a_$0_$6,b_$0_$6)} ( con_$7 ==> (ite(con_$7,a_$0_$6,b_$0_$6) == a_$0_$6) )))) && ((forall  con_$8 : Boolean, a_$0_$7 : PartialHeapType, b_$0_$7 : PartialHeapType :: {ite(con_$8,a_$0_$7,b_$0_$7)} ( con_$8 ==> (ite(con_$8,a_$0_$7,b_$0_$7) == a_$0_$7) )))) && ((forall  con_$9 : Boolean, a_$0_$8 : Field (Mu) , b_$0_$8 : Field (Mu)  :: {ite(con_$9,a_$0_$8,b_$0_$8)} ( con_$9 ==> (ite(con_$9,a_$0_$8,b_$0_$8) == a_$0_$8) )))) && ((forall  con_$10 : Boolean, a_$0_$9 : Mu, b_$0_$9 : Mu :: {ite(con_$10,a_$0_$9,b_$0_$9)} ( con_$10 ==> (ite(con_$10,a_$0_$9,b_$0_$9) == a_$0_$9) )))) && ((forall  con_$11 : Boolean, a_$0_$10 : Field (Boolean) , b_$0_$10 : Field (Boolean)  :: {ite(con_$11,a_$0_$10,b_$0_$10)} ( con_$11 ==> (ite(con_$11,a_$0_$10,b_$0_$10) == a_$0_$10) )))) && ((forall  con_$12 : Boolean, a_$0_$11 : HeapType, b_$0_$11 : HeapType :: {ite(con_$12,a_$0_$11,b_$0_$11)} ( con_$12 ==> (ite(con_$12,a_$0_$11,b_$0_$11) == a_$0_$11) )))) && ((forall  con_$13 : Boolean, a_$0_$12 : CreditsType, b_$0_$12 : CreditsType :: {ite(con_$13,a_$0_$12,b_$0_$12)} ( con_$13 ==> (ite(con_$13,a_$0_$12,b_$0_$12) == a_$0_$12) )))) && ((forall  con_$14 : Boolean, a_$0_$13 : Seq (ref) , b_$0_$13 : Seq (ref)  :: {ite(con_$14,a_$0_$13,b_$0_$13)} ( con_$14 ==> (ite(con_$14,a_$0_$13,b_$0_$13) == a_$0_$13) )))) && ((forall  con_$15 : Boolean, a_$0_$14 : Seq (Integer) , b_$0_$14 : Seq (Integer)  :: {ite(con_$15,a_$0_$14,b_$0_$14)} ( con_$15 ==> (ite(con_$15,a_$0_$14,b_$0_$14) == a_$0_$14) )))) && ((forall  con_$16 : Boolean, a_$0_$15 : Field (ref) , b_$0_$15 : Field (ref)  :: {ite(con_$16,a_$0_$15,b_$0_$15)} ( con_$16 ==> (ite(con_$16,a_$0_$15,b_$0_$15) == a_$0_$15) )))) && ((forall  con_$17 : Boolean, a_$0_$16 : Field (Seq (Integer) ) , b_$0_$16 : Field (Seq (Integer) )  :: {ite(con_$17,a_$0_$16,b_$0_$16)} ( con_$17 ==> (ite(con_$17,a_$0_$16,b_$0_$16) == a_$0_$16) )))) && ((forall  con_$18 : Boolean, a_$0_$17 : TypeName, b_$0_$17 : TypeName :: {ite(con_$18,a_$0_$17,b_$0_$17)} ( con_$18 ==> (ite(con_$18,a_$0_$17,b_$0_$17) == a_$0_$17) )))) && ((forall  con_$19 : Boolean, a_$0_$18 : ModuleName, b_$0_$18 : ModuleName :: {ite(con_$19,a_$0_$18,b_$0_$18)} ( con_$19 ==> (ite(con_$19,a_$0_$18,b_$0_$18) == a_$0_$18) )));
	assume (((((((((((((((((((forall  con_$0_$0 : Boolean, a_$1_$0 : Boolean, b_$1_$0 : Boolean :: {ite(con_$0_$0,a_$1_$0,b_$1_$0)} ( (!con_$0_$0) ==> (ite(con_$0_$0,a_$1_$0,b_$1_$0) == b_$1_$0) ))) && ((forall  con_$0_$1 : Boolean, a_$1_$1 : Integer, b_$1_$1 : Integer :: {ite(con_$0_$1,a_$1_$1,b_$1_$1)} ( (!con_$0_$1) ==> (ite(con_$0_$1,a_$1_$1,b_$1_$1) == b_$1_$1) )))) && ((forall  con_$0_$2 : Boolean, a_$1_$2 : [PermissionComponent]Integer, b_$1_$2 : [PermissionComponent]Integer :: {ite(con_$0_$2,a_$1_$2,b_$1_$2)} ( (!con_$0_$2) ==> (ite(con_$0_$2,a_$1_$2,b_$1_$2) == b_$1_$2) )))) && ((forall  con_$0_$3 : Boolean, a_$1_$3 : PermissionComponent, b_$1_$3 : PermissionComponent :: {ite(con_$0_$3,a_$1_$3,b_$1_$3)} ( (!con_$0_$3) ==> (ite(con_$0_$3,a_$1_$3,b_$1_$3) == b_$1_$3) )))) && ((forall  con_$0_$4 : Boolean, a_$1_$4 : MaskType, b_$1_$4 : MaskType :: {ite(con_$0_$4,a_$1_$4,b_$1_$4)} ( (!con_$0_$4) ==> (ite(con_$0_$4,a_$1_$4,b_$1_$4) == b_$1_$4) )))) && ((forall  con_$0_$5 : Boolean, a_$1_$5 : ref, b_$1_$5 : ref :: {ite(con_$0_$5,a_$1_$5,b_$1_$5)} ( (!con_$0_$5) ==> (ite(con_$0_$5,a_$1_$5,b_$1_$5) == b_$1_$5) )))) && ((forall  con_$0_$6 : Boolean, a_$1_$6 : Field (Integer) , b_$1_$6 : Field (Integer)  :: {ite(con_$0_$6,a_$1_$6,b_$1_$6)} ( (!con_$0_$6) ==> (ite(con_$0_$6,a_$1_$6,b_$1_$6) == b_$1_$6) )))) && ((forall  con_$0_$7 : Boolean, a_$1_$7 : PartialHeapType, b_$1_$7 : PartialHeapType :: {ite(con_$0_$7,a_$1_$7,b_$1_$7)} ( (!con_$0_$7) ==> (ite(con_$0_$7,a_$1_$7,b_$1_$7) == b_$1_$7) )))) && ((forall  con_$0_$8 : Boolean, a_$1_$8 : Field (Mu) , b_$1_$8 : Field (Mu)  :: {ite(con_$0_$8,a_$1_$8,b_$1_$8)} ( (!con_$0_$8) ==> (ite(con_$0_$8,a_$1_$8,b_$1_$8) == b_$1_$8) )))) && ((forall  con_$0_$9 : Boolean, a_$1_$9 : Mu, b_$1_$9 : Mu :: {ite(con_$0_$9,a_$1_$9,b_$1_$9)} ( (!con_$0_$9) ==> (ite(con_$0_$9,a_$1_$9,b_$1_$9) == b_$1_$9) )))) && ((forall  con_$0_$10 : Boolean, a_$1_$10 : Field (Boolean) , b_$1_$10 : Field (Boolean)  :: {ite(con_$0_$10,a_$1_$10,b_$1_$10)} ( (!con_$0_$10) ==> (ite(con_$0_$10,a_$1_$10,b_$1_$10) == b_$1_$10) )))) && ((forall  con_$0_$11 : Boolean, a_$1_$11 : HeapType, b_$1_$11 : HeapType :: {ite(con_$0_$11,a_$1_$11,b_$1_$11)} ( (!con_$0_$11) ==> (ite(con_$0_$11,a_$1_$11,b_$1_$11) == b_$1_$11) )))) && ((forall  con_$0_$12 : Boolean, a_$1_$12 : CreditsType, b_$1_$12 : CreditsType :: {ite(con_$0_$12,a_$1_$12,b_$1_$12)} ( (!con_$0_$12) ==> (ite(con_$0_$12,a_$1_$12,b_$1_$12) == b_$1_$12) )))) && ((forall  con_$0_$13 : Boolean, a_$1_$13 : Seq (ref) , b_$1_$13 : Seq (ref)  :: {ite(con_$0_$13,a_$1_$13,b_$1_$13)} ( (!con_$0_$13) ==> (ite(con_$0_$13,a_$1_$13,b_$1_$13) == b_$1_$13) )))) && ((forall  con_$0_$14 : Boolean, a_$1_$14 : Seq (Integer) , b_$1_$14 : Seq (Integer)  :: {ite(con_$0_$14,a_$1_$14,b_$1_$14)} ( (!con_$0_$14) ==> (ite(con_$0_$14,a_$1_$14,b_$1_$14) == b_$1_$14) )))) && ((forall  con_$0_$15 : Boolean, a_$1_$15 : Field (ref) , b_$1_$15 : Field (ref)  :: {ite(con_$0_$15,a_$1_$15,b_$1_$15)} ( (!con_$0_$15) ==> (ite(con_$0_$15,a_$1_$15,b_$1_$15) == b_$1_$15) )))) && ((forall  con_$0_$16 : Boolean, a_$1_$16 : Field (Seq (Integer) ) , b_$1_$16 : Field (Seq (Integer) )  :: {ite(con_$0_$16,a_$1_$16,b_$1_$16)} ( (!con_$0_$16) ==> (ite(con_$0_$16,a_$1_$16,b_$1_$16) == b_$1_$16) )))) && ((forall  con_$0_$17 : Boolean, a_$1_$17 : TypeName, b_$1_$17 : TypeName :: {ite(con_$0_$17,a_$1_$17,b_$1_$17)} ( (!con_$0_$17) ==> (ite(con_$0_$17,a_$1_$17,b_$1_$17) == b_$1_$17) )))) && ((forall  con_$0_$18 : Boolean, a_$1_$18 : ModuleName, b_$1_$18 : ModuleName :: {ite(con_$0_$18,a_$1_$18,b_$1_$18)} ( (!con_$0_$18) ==> (ite(con_$0_$18,a_$1_$18,b_$1_$18) == b_$1_$18) )));
	assume ((forall  s_$12 : Seq (Integer)  :: {Seq#Length(s_$12)} ( 0 <= Seq#Length(s_$12) ))) && ((forall  s_$13 : Seq (ref)  :: {Seq#Length(s_$13)} ( 0 <= Seq#Length(s_$13) )));
	assume (Seq#Length((Seq#Empty() : Seq (Integer) )) == 0) && (Seq#Length((Seq#Empty() : Seq (ref) )) == 0);
	assume ((forall  s_$0_$0 : Seq (Integer)  :: {Seq#Length(s_$0_$0)} ( (Seq#Length(s_$0_$0) == 0) ==> (s_$0_$0 == (Seq#Empty() : Seq (Integer) )) ))) && ((forall  s_$0_$1 : Seq (ref)  :: {Seq#Length(s_$0_$1)} ( (Seq#Length(s_$0_$1) == 0) ==> (s_$0_$1 == (Seq#Empty() : Seq (ref) )) )));
	assume ((forall  t_$2 : Integer :: {Seq#Length(Seq#Singleton(t_$2))} ( Seq#Length(Seq#Singleton(t_$2)) == 1 ))) && ((forall  t_$3 : ref :: {Seq#Length(Seq#Singleton(t_$3))} ( Seq#Length(Seq#Singleton(t_$3)) == 1 )));
	assume ((forall  s_$1_$0 : Seq (Integer) , i_$5 : Integer, v_$2 : Integer, len_$2 : Integer :: {Seq#Length(Seq#Build(s_$1_$0,i_$5,v_$2,len_$2))} ( (0 <= len_$2) ==> (Seq#Length(Seq#Build(s_$1_$0,i_$5,v_$2,len_$2)) == len_$2) ))) && ((forall  s_$1_$1 : Seq (ref) , i_$6 : Integer, v_$3 : ref, len_$3 : Integer :: {Seq#Length(Seq#Build(s_$1_$1,i_$6,v_$3,len_$3))} ( (0 <= len_$3) ==> (Seq#Length(Seq#Build(s_$1_$1,i_$6,v_$3,len_$3)) == len_$3) )));
	assume ((forall  s0_$4 : Seq (Integer) , s1_$4 : Seq (Integer)  :: {Seq#Length(Seq#Append(s0_$4,s1_$4))} ( Seq#Length(Seq#Append(s0_$4,s1_$4)) == (Seq#Length(s0_$4) + Seq#Length(s1_$4)) ))) && ((forall  s0_$5 : Seq (ref) , s1_$5 : Seq (ref)  :: {Seq#Length(Seq#Append(s0_$5,s1_$5))} ( Seq#Length(Seq#Append(s0_$5,s1_$5)) == (Seq#Length(s0_$5) + Seq#Length(s1_$5)) )));
	assume ((forall  t_$0_$0 : Integer :: {Seq#Index(Seq#Singleton(t_$0_$0),0)} ( Seq#Index(Seq#Singleton(t_$0_$0),0) == t_$0_$0 ))) && ((forall  t_$0_$1 : ref :: {Seq#Index(Seq#Singleton(t_$0_$1),0)} ( Seq#Index(Seq#Singleton(t_$0_$1),0) == t_$0_$1 )));
	assume ((forall  s0_$0_$0 : Seq (Integer) , s1_$0_$0 : Seq (Integer) , n_$3_$0 : Integer :: {Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0)} ( ((n_$3_$0 < Seq#Length(s0_$0_$0)) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0) == Seq#Index(s0_$0_$0,n_$3_$0))) && ((Seq#Length(s0_$0_$0) <= n_$3_$0) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0) == Seq#Index(s1_$0_$0,n_$3_$0 - Seq#Length(s0_$0_$0)))) ))) && ((forall  s0_$0_$1 : Seq (ref) , s1_$0_$1 : Seq (ref) , n_$3_$1 : Integer :: {Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1)} ( ((n_$3_$1 < Seq#Length(s0_$0_$1)) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1) == Seq#Index(s0_$0_$1,n_$3_$1))) && ((Seq#Length(s0_$0_$1) <= n_$3_$1) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1) == Seq#Index(s1_$0_$1,n_$3_$1 - Seq#Length(s0_$0_$1)))) )));
	assume ((forall  s_$2_$0 : Seq (Integer) , i_$0_$0 : Integer, v_$0_$0 : Integer, len_$0_$0 : Integer, n_$4_$0 : Integer :: {Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0)} ( ((0 <= n_$4_$0) && (n_$4_$0 < len_$0_$0)) ==> (((i_$0_$0 == n_$4_$0) ==> (Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0) == v_$0_$0)) && ((!(i_$0_$0 == n_$4_$0)) ==> (Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0) == Seq#Index(s_$2_$0,n_$4_$0)))) ))) && ((forall  s_$2_$1 : Seq (ref) , i_$0_$1 : Integer, v_$0_$1 : ref, len_$0_$1 : Integer, n_$4_$1 : Integer :: {Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1)} ( ((0 <= n_$4_$1) && (n_$4_$1 < len_$0_$1)) ==> (((i_$0_$1 == n_$4_$1) ==> (Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1) == v_$0_$1)) && ((!(i_$0_$1 == n_$4_$1)) ==> (Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1) == Seq#Index(s_$2_$1,n_$4_$1)))) )));
	assume ((forall  s_$3_$0 : Seq (Integer) , x_$0_$0 : Integer :: {Seq#Contains(s_$3_$0,x_$0_$0)} ( Seq#Contains(s_$3_$0,x_$0_$0) <==> ((exists  i_$1_$1 : Integer :: {Seq#Index(s_$3_$0,i_$1_$1)} ( ((0 <= i_$1_$1) && (i_$1_$1 < Seq#Length(s_$3_$0))) && (Seq#Index(s_$3_$0,i_$1_$1) == x_$0_$0) ))) ))) && ((forall  s_$3_$1 : Seq (ref) , x_$0_$1 : ref :: {Seq#Contains(s_$3_$1,x_$0_$1)} ( Seq#Contains(s_$3_$1,x_$0_$1) <==> ((exists  i_$1_$3 : Integer :: {Seq#Index(s_$3_$1,i_$1_$3)} ( ((0 <= i_$1_$3) && (i_$1_$3 < Seq#Length(s_$3_$1))) && (Seq#Index(s_$3_$1,i_$1_$3) == x_$0_$1) ))) )));
	assume (forall  x_$1 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$1) ));
	assume ((forall  s0_$1_$0 : Seq (Integer) , s1_$1_$0 : Seq (Integer) , x_$2_$0 : Integer :: {Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$2_$0)} ( Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$2_$0) <==> (Seq#Contains(s0_$1_$0,x_$2_$0) || Seq#Contains(s1_$1_$0,x_$2_$0)) ))) && ((forall  s0_$1_$1 : Seq (ref) , s1_$1_$1 : Seq (ref) , x_$2_$1 : ref :: {Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$2_$1)} ( Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$2_$1) <==> (Seq#Contains(s0_$1_$1,x_$2_$1) || Seq#Contains(s1_$1_$1,x_$2_$1)) )));
	assume ((forall  s_$4_$0 : Seq (Integer) , i_$2_$0 : Integer, v_$1_$0 : Integer, len_$1_$0 : Integer, x_$3_$0 : Integer :: {Seq#Contains(Seq#Build(s_$4_$0,i_$2_$0,v_$1_$0,len_$1_$0),x_$3_$0)} ( Seq#Contains(Seq#Build(s_$4_$0,i_$2_$0,v_$1_$0,len_$1_$0),x_$3_$0) <==> ((((0 <= i_$2_$0) && (i_$2_$0 < len_$1_$0)) && (x_$3_$0 == v_$1_$0)) || ((exists  j_$6 : Integer :: {Seq#Index(s_$4_$0,j_$6)} ( ((((0 <= j_$6) && (j_$6 < Seq#Length(s_$4_$0))) && (j_$6 < len_$1_$0)) && (!(j_$6 == i_$2_$0))) && (Seq#Index(s_$4_$0,j_$6) == x_$3_$0) )))) ))) && ((forall  s_$4_$1 : Seq (ref) , i_$2_$1 : Integer, v_$1_$1 : ref, len_$1_$1 : Integer, x_$3_$1 : ref :: {Seq#Contains(Seq#Build(s_$4_$1,i_$2_$1,v_$1_$1,len_$1_$1),x_$3_$1)} ( Seq#Contains(Seq#Build(s_$4_$1,i_$2_$1,v_$1_$1,len_$1_$1),x_$3_$1) <==> ((((0 <= i_$2_$1) && (i_$2_$1 < len_$1_$1)) && (x_$3_$1 == v_$1_$1)) || ((exists  j_$8 : Integer :: {Seq#Index(s_$4_$1,j_$8)} ( ((((0 <= j_$8) && (j_$8 < Seq#Length(s_$4_$1))) && (j_$8 < len_$1_$1)) && (!(j_$8 == i_$2_$1))) && (Seq#Index(s_$4_$1,j_$8) == x_$3_$1) )))) )));
	assume ((forall  s_$5_$0 : Seq (Integer) , n_$5_$0 : Integer, x_$4_$0 : Integer :: {Seq#Contains(Seq#Take(s_$5_$0,n_$5_$0),x_$4_$0)} ( Seq#Contains(Seq#Take(s_$5_$0,n_$5_$0),x_$4_$0) <==> ((exists  i_$3_$1 : Integer :: {Seq#Index(s_$5_$0,i_$3_$1)} ( (((0 <= i_$3_$1) && (i_$3_$1 < n_$5_$0)) && (i_$3_$1 < Seq#Length(s_$5_$0))) && (Seq#Index(s_$5_$0,i_$3_$1) == x_$4_$0) ))) ))) && ((forall  s_$5_$1 : Seq (ref) , n_$5_$1 : Integer, x_$4_$1 : ref :: {Seq#Contains(Seq#Take(s_$5_$1,n_$5_$1),x_$4_$1)} ( Seq#Contains(Seq#Take(s_$5_$1,n_$5_$1),x_$4_$1) <==> ((exists  i_$3_$3 : Integer :: {Seq#Index(s_$5_$1,i_$3_$3)} ( (((0 <= i_$3_$3) && (i_$3_$3 < n_$5_$1)) && (i_$3_$3 < Seq#Length(s_$5_$1))) && (Seq#Index(s_$5_$1,i_$3_$3) == x_$4_$1) ))) )));
	assume ((forall  s_$6_$0 : Seq (Integer) , n_$6_$0 : Integer, x_$5_$0 : Integer :: {Seq#Contains(Seq#Drop(s_$6_$0,n_$6_$0),x_$5_$0)} ( Seq#Contains(Seq#Drop(s_$6_$0,n_$6_$0),x_$5_$0) <==> ((exists  i_$4_$1 : Integer :: {Seq#Index(s_$6_$0,i_$4_$1)} ( (((0 <= n_$6_$0) && (n_$6_$0 <= i_$4_$1)) && (i_$4_$1 < Seq#Length(s_$6_$0))) && (Seq#Index(s_$6_$0,i_$4_$1) == x_$5_$0) ))) ))) && ((forall  s_$6_$1 : Seq (ref) , n_$6_$1 : Integer, x_$5_$1 : ref :: {Seq#Contains(Seq#Drop(s_$6_$1,n_$6_$1),x_$5_$1)} ( Seq#Contains(Seq#Drop(s_$6_$1,n_$6_$1),x_$5_$1) <==> ((exists  i_$4_$3 : Integer :: {Seq#Index(s_$6_$1,i_$4_$3)} ( (((0 <= n_$6_$1) && (n_$6_$1 <= i_$4_$3)) && (i_$4_$3 < Seq#Length(s_$6_$1))) && (Seq#Index(s_$6_$1,i_$4_$3) == x_$5_$1) ))) )));
	assume ((forall  s0_$2_$0 : Seq (Integer) , s1_$2_$0 : Seq (Integer)  :: {Seq#Equal(s0_$2_$0,s1_$2_$0)} ( Seq#Equal(s0_$2_$0,s1_$2_$0) <==> ((Seq#Length(s0_$2_$0) == Seq#Length(s1_$2_$0)) && ((forall  j_$0_$1 : Integer :: {Seq#Index(s0_$2_$0,j_$0_$1)} {Seq#Index(s1_$2_$0,j_$0_$1)} ( ((0 <= j_$0_$1) && (j_$0_$1 < Seq#Length(s0_$2_$0))) ==> (Seq#Index(s0_$2_$0,j_$0_$1) == Seq#Index(s1_$2_$0,j_$0_$1)) )))) ))) && ((forall  s0_$2_$1 : Seq (ref) , s1_$2_$1 : Seq (ref)  :: {Seq#Equal(s0_$2_$1,s1_$2_$1)} ( Seq#Equal(s0_$2_$1,s1_$2_$1) <==> ((Seq#Length(s0_$2_$1) == Seq#Length(s1_$2_$1)) && ((forall  j_$0_$3 : Integer :: {Seq#Index(s0_$2_$1,j_$0_$3)} {Seq#Index(s1_$2_$1,j_$0_$3)} ( ((0 <= j_$0_$3) && (j_$0_$3 < Seq#Length(s0_$2_$1))) ==> (Seq#Index(s0_$2_$1,j_$0_$3) == Seq#Index(s1_$2_$1,j_$0_$3)) )))) )));
	assume ((forall  a_$2_$0 : Seq (Integer) , b_$2_$0 : Seq (Integer)  :: {Seq#Equal(a_$2_$0,b_$2_$0)} ( Seq#Equal(a_$2_$0,b_$2_$0) ==> (a_$2_$0 == b_$2_$0) ))) && ((forall  a_$2_$1 : Seq (ref) , b_$2_$1 : Seq (ref)  :: {Seq#Equal(a_$2_$1,b_$2_$1)} ( Seq#Equal(a_$2_$1,b_$2_$1) ==> (a_$2_$1 == b_$2_$1) )));
	assume ((forall  s_$7_$0 : Seq (Integer) , n_$8_$0 : Integer :: {Seq#Length(Seq#Take(s_$7_$0,n_$8_$0))} ( (0 <= n_$8_$0) ==> (((n_$8_$0 <= Seq#Length(s_$7_$0)) ==> (Seq#Length(Seq#Take(s_$7_$0,n_$8_$0)) == n_$8_$0)) && ((Seq#Length(s_$7_$0) < n_$8_$0) ==> (Seq#Length(Seq#Take(s_$7_$0,n_$8_$0)) == Seq#Length(s_$7_$0)))) ))) && ((forall  s_$7_$1 : Seq (ref) , n_$8_$1 : Integer :: {Seq#Length(Seq#Take(s_$7_$1,n_$8_$1))} ( (0 <= n_$8_$1) ==> (((n_$8_$1 <= Seq#Length(s_$7_$1)) ==> (Seq#Length(Seq#Take(s_$7_$1,n_$8_$1)) == n_$8_$1)) && ((Seq#Length(s_$7_$1) < n_$8_$1) ==> (Seq#Length(Seq#Take(s_$7_$1,n_$8_$1)) == Seq#Length(s_$7_$1)))) )));
	assume ((forall  s_$8_$0 : Seq (Integer) , n_$9_$0 : Integer, j_$2_$0 : Integer :: {Seq#Index(Seq#Take(s_$8_$0,n_$9_$0),j_$2_$0)} {:weight  25}( (((0 <= j_$2_$0) && (j_$2_$0 < n_$9_$0)) && (j_$2_$0 < Seq#Length(s_$8_$0))) ==> (Seq#Index(Seq#Take(s_$8_$0,n_$9_$0),j_$2_$0) == Seq#Index(s_$8_$0,j_$2_$0)) ))) && ((forall  s_$8_$1 : Seq (ref) , n_$9_$1 : Integer, j_$2_$1 : Integer :: {Seq#Index(Seq#Take(s_$8_$1,n_$9_$1),j_$2_$1)} {:weight  25}( (((0 <= j_$2_$1) && (j_$2_$1 < n_$9_$1)) && (j_$2_$1 < Seq#Length(s_$8_$1))) ==> (Seq#Index(Seq#Take(s_$8_$1,n_$9_$1),j_$2_$1) == Seq#Index(s_$8_$1,j_$2_$1)) )));
	assume ((forall  s_$9_$0 : Seq (Integer) , n_$10_$0 : Integer :: {Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0))} ( (0 <= n_$10_$0) ==> (((n_$10_$0 <= Seq#Length(s_$9_$0)) ==> (Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0)) == (Seq#Length(s_$9_$0) - n_$10_$0))) && ((Seq#Length(s_$9_$0) < n_$10_$0) ==> (Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0)) == 0))) ))) && ((forall  s_$9_$1 : Seq (ref) , n_$10_$1 : Integer :: {Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1))} ( (0 <= n_$10_$1) ==> (((n_$10_$1 <= Seq#Length(s_$9_$1)) ==> (Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1)) == (Seq#Length(s_$9_$1) - n_$10_$1))) && ((Seq#Length(s_$9_$1) < n_$10_$1) ==> (Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1)) == 0))) )));
	assume ((forall  s_$10_$0 : Seq (Integer) , n_$11_$0 : Integer, j_$3_$0 : Integer :: {Seq#Index(Seq#Drop(s_$10_$0,n_$11_$0),j_$3_$0)} {:weight  25}( (((0 <= n_$11_$0) && (0 <= j_$3_$0)) && (j_$3_$0 < (Seq#Length(s_$10_$0) - n_$11_$0))) ==> (Seq#Index(Seq#Drop(s_$10_$0,n_$11_$0),j_$3_$0) == Seq#Index(s_$10_$0,j_$3_$0 + n_$11_$0)) ))) && ((forall  s_$10_$1 : Seq (ref) , n_$11_$1 : Integer, j_$3_$1 : Integer :: {Seq#Index(Seq#Drop(s_$10_$1,n_$11_$1),j_$3_$1)} {:weight  25}( (((0 <= n_$11_$1) && (0 <= j_$3_$1)) && (j_$3_$1 < (Seq#Length(s_$10_$1) - n_$11_$1))) ==> (Seq#Index(Seq#Drop(s_$10_$1,n_$11_$1),j_$3_$1) == Seq#Index(s_$10_$1,j_$3_$1 + n_$11_$1)) )));
	assume ((forall  s_$11_$0 : Seq (Integer) , t_$1_$0 : Seq (Integer)  :: {Seq#Append(s_$11_$0,t_$1_$0)} ( (Seq#Take(Seq#Append(s_$11_$0,t_$1_$0),Seq#Length(s_$11_$0)) == s_$11_$0) && (Seq#Drop(Seq#Append(s_$11_$0,t_$1_$0),Seq#Length(s_$11_$0)) == t_$1_$0) ))) && ((forall  s_$11_$1 : Seq (ref) , t_$1_$1 : Seq (ref)  :: {Seq#Append(s_$11_$1,t_$1_$1)} ( (Seq#Take(Seq#Append(s_$11_$1,t_$1_$1),Seq#Length(s_$11_$1)) == s_$11_$1) && (Seq#Drop(Seq#Append(s_$11_$1,t_$1_$1),Seq#Length(s_$11_$1)) == t_$1_$1) )));
	assume (forall  min : Integer, max : Integer :: {Seq#Length(Seq#Range(min,max))} ( ((min < max) ==> (Seq#Length(Seq#Range(min,max)) == (max - min))) && ((max <= min) ==> (Seq#Length(Seq#Range(min,max)) == 0)) ));
	assume (forall  min_$0 : Integer, max_$0 : Integer, j_$4 : Integer :: {Seq#Index(Seq#Range(min_$0,max_$0),j_$4)} ( ((0 <= j_$4) && (j_$4 < (max_$0 - min_$0))) ==> (Seq#Index(Seq#Range(min_$0,max_$0),j_$4) == (min_$0 + j_$4)) ));
	assume ((forall  x_$6_$0 : Integer, y_$0_$0 : Integer :: {Seq#Contains(Seq#Singleton(x_$6_$0),y_$0_$0)} ( Seq#Contains(Seq#Singleton(x_$6_$0),y_$0_$0) <==> (x_$6_$0 == y_$0_$0) ))) && ((forall  x_$6_$1 : ref, y_$0_$1 : ref :: {Seq#Contains(Seq#Singleton(x_$6_$1),y_$0_$1)} ( Seq#Contains(Seq#Singleton(x_$6_$1),y_$0_$1) <==> (x_$6_$1 == y_$0_$1) )));
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
	assume $_$_condition;
	assume $_$_condition <==> (!(Heap[this,AVLTreeNode.left] == null));
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
	goto $branchMerge_0;
anon456_Else:
	assume !$_$_condition;
	assume $_$_condition <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_7 == Mask_$_5;
	goto $branchMerge_0;
anon457_Then:
	assume $_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap[this,AVLTreeNode.left] == null));
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
	goto $branchMerge_1;
anon457_Else:
	assume !$_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_9 == Mask_$_7;
	goto $branchMerge_1;
anon458_Then:
	assume $_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap[this,AVLTreeNode.left] == null));
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
	goto $branchMerge_2;
anon458_Else:
	assume !$_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_11 == Mask_$_9;
	goto $branchMerge_2;
anon459_Then:
	assume $_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap[this,AVLTreeNode.left] == null));
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
	goto $branchMerge_3;
anon459_Else:
	assume !$_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_13 == Mask_$_11;
	goto $branchMerge_3;
anon460_Then:
	assume $_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume (forall  k#92#481 : Integer :: ( ((0 <= k#92#481) && (k#92#481 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#481) < Heap[this,AVLTreeNode.key]) ));
	goto $branchMerge_4;
anon460_Else:
	assume !$_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	goto $branchMerge_4;
anon461_Then:
	assume $_$_condition_$8;
	assume $_$_condition_$8 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_5;
anon461_Else:
	assume !$_$_condition_$8;
	assume $_$_condition_$8 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_15 == Mask_$_13;
	goto $branchMerge_5;
anon462_Then:
	assume $_$_condition_$10;
	assume $_$_condition_$10 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_6;
anon462_Else:
	assume !$_$_condition_$10;
	assume $_$_condition_$10 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_17 == Mask_$_15;
	goto $branchMerge_6;
anon463_Then:
	assume $_$_condition_$12;
	assume $_$_condition_$12 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_7;
anon463_Else:
	assume !$_$_condition_$12;
	assume $_$_condition_$12 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_19 == Mask_$_17;
	goto $branchMerge_7;
anon464_Then:
	assume $_$_condition_$14;
	assume $_$_condition_$14 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_8;
anon464_Else:
	assume !$_$_condition_$14;
	assume $_$_condition_$14 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume Mask_$_21 == Mask_$_19;
	goto $branchMerge_8;
anon465_Then:
	assume $_$_condition_$16;
	assume $_$_condition_$16 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume (forall  k#93#482 : Integer :: ( ((0 <= k#93#482) && (k#93#482 < Seq#Length(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[this,AVLTreeNode.key] < Seq#Index(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#482)) ));
	goto anon20;
anon465_Else:
	assume !$_$_condition_$16;
	assume $_$_condition_$16 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	assume $_$_condition_$18;
	assume $_$_condition_$18 <==> (Heap[this,AVLTreeNode.left] == null);
	assume Heap[this,AVLTreeNode.left] == null;
	goto anon23;
anon466_Else:
	assume !$_$_condition_$18;
	assume $_$_condition_$18 <==> (Heap[this,AVLTreeNode.left] == null);
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
	assume $_$_condition_$19;
	assume $_$_condition_$19 <==> (Heap[this,AVLTreeNode.right] == null);
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon26;
anon467_Else:
	assume !$_$_condition_$19;
	assume $_$_condition_$19 <==> (Heap[this,AVLTreeNode.right] == null);
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
	assume $_$_condition_$20;
	assume $_$_condition_$20 <==> (!(Heap[this,AVLTreeNode.left] == null));
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
	assume !$_$_condition_$20;
	assume $_$_condition_$20 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_22 == ZeroMask;
	goto anon186;
anon469_Then:
	assume $_$_condition_$21;
	assume $_$_condition_$21 <==> false;
	assume false;
	goto $exit;
anon469_Else:
	assume !$_$_condition_$21;
	assume $_$_condition_$21 <==> false;
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
	assume $_$_condition_$22;
	assume $_$_condition_$22 <==> (!CanRead(unfoldingMask#_1611_$_0,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(unfoldingMask#_1611_$_0,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume oldVers#_1635_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_1610_$_0 == Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.valid := newVers#_1636_$_0];
	assume oldVers#_1635_$_0 < unfoldingHeap#_1610_$_0[unfoldingHeap#_1610_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_1610_$_1 == unfoldingHeap#_1610_$_0;
	goto anon83;
anon496_Else:
	assume !$_$_condition_$22;
	assume $_$_condition_$22 <==> (!CanRead(unfoldingMask#_1611_$_0,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.valid));
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
	assume $_$_condition_$23;
	assume $_$_condition_$23 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_9;
anon497_Else:
	assume !$_$_condition_$23;
	assume $_$_condition_$23 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_8 == unfoldingMask#_1611_$_6;
	goto $branchMerge_9;
anon498_Then:
	assume $_$_condition_$24;
	assume $_$_condition_$24 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_10;
anon498_Else:
	assume !$_$_condition_$24;
	assume $_$_condition_$24 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_10 == unfoldingMask#_1611_$_8;
	goto $branchMerge_10;
anon499_Then:
	assume $_$_condition_$26;
	assume $_$_condition_$26 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_11;
anon499_Else:
	assume !$_$_condition_$26;
	assume $_$_condition_$26 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_12 == unfoldingMask#_1611_$_10;
	goto $branchMerge_11;
anon500_Then:
	assume $_$_condition_$28;
	assume $_$_condition_$28 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_12;
anon500_Else:
	assume !$_$_condition_$28;
	assume $_$_condition_$28 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_1611_$_14 == unfoldingMask#_1611_$_12;
	goto $branchMerge_12;
anon501_Then:
	assume $_$_condition_$30;
	assume $_$_condition_$30 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#487 : Integer :: ( ((0 <= lk#79#487) && (lk#79#487 < Seq#Length(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#487) < unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_13;
anon501_Else:
	assume !$_$_condition_$30;
	assume $_$_condition_$30 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_13;
anon502_Then:
	assume $_$_condition_$32;
	assume $_$_condition_$32 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_14;
anon502_Else:
	assume !$_$_condition_$32;
	assume $_$_condition_$32 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_14;
anon503_Then:
	assume $_$_condition_$34;
	assume $_$_condition_$34 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_15;
anon503_Else:
	assume !$_$_condition_$34;
	assume $_$_condition_$34 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_16 == unfoldingMask#_1611_$_14;
	goto $branchMerge_15;
anon504_Then:
	assume $_$_condition_$36;
	assume $_$_condition_$36 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_16;
anon504_Else:
	assume !$_$_condition_$36;
	assume $_$_condition_$36 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_18 == unfoldingMask#_1611_$_16;
	goto $branchMerge_16;
anon505_Then:
	assume $_$_condition_$38;
	assume $_$_condition_$38 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_17;
anon505_Else:
	assume !$_$_condition_$38;
	assume $_$_condition_$38 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_20 == unfoldingMask#_1611_$_18;
	goto $branchMerge_17;
anon506_Then:
	assume $_$_condition_$40;
	assume $_$_condition_$40 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_18;
anon506_Else:
	assume !$_$_condition_$40;
	assume $_$_condition_$40 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_1611_$_22 == unfoldingMask#_1611_$_20;
	goto $branchMerge_18;
anon507_Then:
	assume $_$_condition_$42;
	assume $_$_condition_$42 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#488 : Integer :: ( ((0 <= rk#80#488) && (rk#80#488 < Seq#Length(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#488)) ));
	goto $branchMerge_19;
anon507_Else:
	assume !$_$_condition_$42;
	assume $_$_condition_$42 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_19;
anon508_Then:
	assume $_$_condition_$44;
	assume $_$_condition_$44 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon107;
anon508_Else:
	assume !$_$_condition_$44;
	assume $_$_condition_$44 <==> (!(unfoldingHeap#_1610_$_1[unfoldingHeap#_1610_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	assume $_$_condition_$46;
	assume $_$_condition_$46 <==> false;
	assume false;
	goto $exit;
anon509_Else:
	assume !$_$_condition_$46;
	assume $_$_condition_$46 <==> false;
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
	assume $_$_condition_$47;
	assume $_$_condition_$47 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_20;
anon536_Else:
	assume !$_$_condition_$47;
	assume $_$_condition_$47 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_7 == assertSecMask#_1606_$_5;
	goto $branchMerge_20;
anon537_Then:
	assume $_$_condition_$48;
	assume $_$_condition_$48 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_21;
anon537_Else:
	assume !$_$_condition_$48;
	assume $_$_condition_$48 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_9 == assertSecMask#_1606_$_7;
	goto $branchMerge_21;
anon538_Then:
	assume $_$_condition_$50;
	assume $_$_condition_$50 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_22;
anon538_Else:
	assume !$_$_condition_$50;
	assume $_$_condition_$50 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_11 == assertSecMask#_1606_$_9;
	goto $branchMerge_22;
anon539_Then:
	assume $_$_condition_$52;
	assume $_$_condition_$52 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
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
	goto $branchMerge_23;
anon539_Else:
	assume !$_$_condition_$52;
	assume $_$_condition_$52 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_1606_$_13 == assertSecMask#_1606_$_11;
	goto $branchMerge_23;
anon540_Then:
	assume $_$_condition_$54;
	assume $_$_condition_$54 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#493 : Integer :: ( ((0 <= lk#79#493) && (lk#79#493 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#493) < Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	goto $branchMerge_24;
anon540_Else:
	assume !$_$_condition_$54;
	assume $_$_condition_$54 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_24;
anon541_Then:
	assume $_$_condition_$56;
	assume $_$_condition_$56 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_25;
anon541_Else:
	assume !$_$_condition_$56;
	assume $_$_condition_$56 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	goto $branchMerge_25;
anon542_Then:
	assume $_$_condition_$58;
	assume $_$_condition_$58 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_26;
anon542_Else:
	assume !$_$_condition_$58;
	assume $_$_condition_$58 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_15 == assertSecMask#_1606_$_13;
	goto $branchMerge_26;
anon543_Then:
	assume $_$_condition_$60;
	assume $_$_condition_$60 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_27;
anon543_Else:
	assume !$_$_condition_$60;
	assume $_$_condition_$60 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_17 == assertSecMask#_1606_$_15;
	goto $branchMerge_27;
anon544_Then:
	assume $_$_condition_$62;
	assume $_$_condition_$62 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_28;
anon544_Else:
	assume !$_$_condition_$62;
	assume $_$_condition_$62 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_19 == assertSecMask#_1606_$_17;
	goto $branchMerge_28;
anon545_Then:
	assume $_$_condition_$64;
	assume $_$_condition_$64 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	goto $branchMerge_29;
anon545_Else:
	assume !$_$_condition_$64;
	assume $_$_condition_$64 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_1606_$_21 == assertSecMask#_1606_$_19;
	goto $branchMerge_29;
anon546_Then:
	assume $_$_condition_$66;
	assume $_$_condition_$66 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#494 : Integer :: ( ((0 <= rk#80#494) && (rk#80#494 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#494)) ));
	goto $branchMerge_30;
anon546_Else:
	assume !$_$_condition_$66;
	assume $_$_condition_$66 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto $branchMerge_30;
anon547_Then:
	assume $_$_condition_$68;
	assume $_$_condition_$68 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon185;
anon547_Else:
	assume !$_$_condition_$68;
	assume $_$_condition_$68 <==> (!(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.right] == null));
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
	assume $_$_condition_$70;
	assume $_$_condition_$70 <==> (!(Heap[this,AVLTreeNode.right] == null));
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
	assume !$_$_condition_$70;
	assume $_$_condition_$70 <==> (!(Heap[this,AVLTreeNode.right] == null));
	assume Heap[this,AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_22 == ZeroMask;
	goto anon346;
anon549_Then:
	assume $_$_condition_$71;
	assume $_$_condition_$71 <==> false;
	assume false;
	goto $exit;
anon549_Else:
	assume !$_$_condition_$71;
	assume $_$_condition_$71 <==> false;
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
	assume $_$_condition_$72;
	assume $_$_condition_$72 <==> (!CanRead(unfoldingMask#_1660_$_0,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(unfoldingMask#_1660_$_0,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume oldVers#_1684_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume unfoldingHeap#_1659_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := newVers#_1685_$_0];
	assume oldVers#_1684_$_0 < unfoldingHeap#_1659_$_0[unfoldingHeap#_1659_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume unfoldingHeap#_1659_$_1 == unfoldingHeap#_1659_$_0;
	goto anon243;
anon576_Else:
	assume !$_$_condition_$72;
	assume $_$_condition_$72 <==> (!CanRead(unfoldingMask#_1660_$_0,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid));
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
	assume $_$_condition_$73;
	assume $_$_condition_$73 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_31;
anon577_Else:
	assume !$_$_condition_$73;
	assume $_$_condition_$73 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_8 == unfoldingMask#_1660_$_6;
	goto $branchMerge_31;
anon578_Then:
	assume $_$_condition_$74;
	assume $_$_condition_$74 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_32;
anon578_Else:
	assume !$_$_condition_$74;
	assume $_$_condition_$74 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_10 == unfoldingMask#_1660_$_8;
	goto $branchMerge_32;
anon579_Then:
	assume $_$_condition_$76;
	assume $_$_condition_$76 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_33;
anon579_Else:
	assume !$_$_condition_$76;
	assume $_$_condition_$76 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_12 == unfoldingMask#_1660_$_10;
	goto $branchMerge_33;
anon580_Then:
	assume $_$_condition_$78;
	assume $_$_condition_$78 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_34;
anon580_Else:
	assume !$_$_condition_$78;
	assume $_$_condition_$78 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_1660_$_14 == unfoldingMask#_1660_$_12;
	goto $branchMerge_34;
anon581_Then:
	assume $_$_condition_$80;
	assume $_$_condition_$80 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#499 : Integer :: ( ((0 <= lk#79#499) && (lk#79#499 < Seq#Length(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#499) < unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_35;
anon581_Else:
	assume !$_$_condition_$80;
	assume $_$_condition_$80 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_35;
anon582_Then:
	assume $_$_condition_$82;
	assume $_$_condition_$82 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_36;
anon582_Else:
	assume !$_$_condition_$82;
	assume $_$_condition_$82 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_36;
anon583_Then:
	assume $_$_condition_$84;
	assume $_$_condition_$84 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_37;
anon583_Else:
	assume !$_$_condition_$84;
	assume $_$_condition_$84 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_16 == unfoldingMask#_1660_$_14;
	goto $branchMerge_37;
anon584_Then:
	assume $_$_condition_$86;
	assume $_$_condition_$86 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_38;
anon584_Else:
	assume !$_$_condition_$86;
	assume $_$_condition_$86 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_18 == unfoldingMask#_1660_$_16;
	goto $branchMerge_38;
anon585_Then:
	assume $_$_condition_$88;
	assume $_$_condition_$88 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_39;
anon585_Else:
	assume !$_$_condition_$88;
	assume $_$_condition_$88 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_20 == unfoldingMask#_1660_$_18;
	goto $branchMerge_39;
anon586_Then:
	assume $_$_condition_$90;
	assume $_$_condition_$90 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_40;
anon586_Else:
	assume !$_$_condition_$90;
	assume $_$_condition_$90 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_1660_$_22 == unfoldingMask#_1660_$_20;
	goto $branchMerge_40;
anon587_Then:
	assume $_$_condition_$92;
	assume $_$_condition_$92 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#500 : Integer :: ( ((0 <= rk#80#500) && (rk#80#500 < Seq#Length(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#500)) ));
	goto $branchMerge_41;
anon587_Else:
	assume !$_$_condition_$92;
	assume $_$_condition_$92 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_41;
anon588_Then:
	assume $_$_condition_$94;
	assume $_$_condition_$94 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon267;
anon588_Else:
	assume !$_$_condition_$94;
	assume $_$_condition_$94 <==> (!(unfoldingHeap#_1659_$_1[unfoldingHeap#_1659_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	assume $_$_condition_$96;
	assume $_$_condition_$96 <==> false;
	assume false;
	goto $exit;
anon589_Else:
	assume !$_$_condition_$96;
	assume $_$_condition_$96 <==> false;
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
	assume $_$_condition_$97;
	assume $_$_condition_$97 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_42;
anon616_Else:
	assume !$_$_condition_$97;
	assume $_$_condition_$97 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_7 == assertSecMask#_1655_$_5;
	goto $branchMerge_42;
anon617_Then:
	assume $_$_condition_$98;
	assume $_$_condition_$98 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_43;
anon617_Else:
	assume !$_$_condition_$98;
	assume $_$_condition_$98 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_9 == assertSecMask#_1655_$_7;
	goto $branchMerge_43;
anon618_Then:
	assume $_$_condition_$100;
	assume $_$_condition_$100 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_44;
anon618_Else:
	assume !$_$_condition_$100;
	assume $_$_condition_$100 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_11 == assertSecMask#_1655_$_9;
	goto $branchMerge_44;
anon619_Then:
	assume $_$_condition_$102;
	assume $_$_condition_$102 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
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
	goto $branchMerge_45;
anon619_Else:
	assume !$_$_condition_$102;
	assume $_$_condition_$102 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_1655_$_13 == assertSecMask#_1655_$_11;
	goto $branchMerge_45;
anon620_Then:
	assume $_$_condition_$104;
	assume $_$_condition_$104 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#505 : Integer :: ( ((0 <= lk#79#505) && (lk#79#505 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#505) < Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_46;
anon620_Else:
	assume !$_$_condition_$104;
	assume $_$_condition_$104 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_46;
anon621_Then:
	assume $_$_condition_$106;
	assume $_$_condition_$106 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_47;
anon621_Else:
	assume !$_$_condition_$106;
	assume $_$_condition_$106 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_47;
anon622_Then:
	assume $_$_condition_$108;
	assume $_$_condition_$108 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_48;
anon622_Else:
	assume !$_$_condition_$108;
	assume $_$_condition_$108 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_15 == assertSecMask#_1655_$_13;
	goto $branchMerge_48;
anon623_Then:
	assume $_$_condition_$110;
	assume $_$_condition_$110 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_49;
anon623_Else:
	assume !$_$_condition_$110;
	assume $_$_condition_$110 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_17 == assertSecMask#_1655_$_15;
	goto $branchMerge_49;
anon624_Then:
	assume $_$_condition_$112;
	assume $_$_condition_$112 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_50;
anon624_Else:
	assume !$_$_condition_$112;
	assume $_$_condition_$112 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_19 == assertSecMask#_1655_$_17;
	goto $branchMerge_50;
anon625_Then:
	assume $_$_condition_$114;
	assume $_$_condition_$114 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	goto $branchMerge_51;
anon625_Else:
	assume !$_$_condition_$114;
	assume $_$_condition_$114 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_1655_$_21 == assertSecMask#_1655_$_19;
	goto $branchMerge_51;
anon626_Then:
	assume $_$_condition_$116;
	assume $_$_condition_$116 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#506 : Integer :: ( ((0 <= rk#80#506) && (rk#80#506 < Seq#Length(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#506)) ));
	goto $branchMerge_52;
anon626_Else:
	assume !$_$_condition_$116;
	assume $_$_condition_$116 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_52;
anon627_Then:
	assume $_$_condition_$118;
	assume $_$_condition_$118 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap[Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon345;
anon627_Else:
	assume !$_$_condition_$118;
	assume $_$_condition_$118 <==> (!(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.right] == null));
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
	assume $_$_condition_$120;
	assume $_$_condition_$120 <==> (Heap[this,AVLTreeNode.left] == null);
	assume Heap[this,AVLTreeNode.left] == null;
	goto anon349;
anon628_Else:
	assume !$_$_condition_$120;
	assume $_$_condition_$120 <==> (Heap[this,AVLTreeNode.left] == null);
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
	assume $_$_condition_$121;
	assume $_$_condition_$121 <==> (Heap[this,AVLTreeNode.right] == null);
	assume Heap[this,AVLTreeNode.right] == null;
	goto $branchMerge_53;
anon629_Else:
	assume !$_$_condition_$121;
	assume $_$_condition_$121 <==> (Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assert { :msg "  590.69: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.69: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  590.69: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.right] == null));
	assert { :msg "  590.69: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.height);
	goto $branchMerge_53;
anon630_Then:
	assume $_$_condition_$122;
	assume ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]);
	assert { :msg "  590.89: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.89: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$124) { goto anon631_Then; } else { goto anon631_Else; }
anon630_Else:
	assume !$_$_condition_$122;
	assume ite(Heap[this,AVLTreeNode.right] == null,0,Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]) >= ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]);
	assert { :msg "  590.126: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.126: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$125) { goto anon632_Then; } else { goto anon632_Else; }
anon631_Then:
	assume $_$_condition_$124;
	assume $_$_condition_$124 <==> (Heap[this,AVLTreeNode.left] == null);
	assume Heap[this,AVLTreeNode.left] == null;
	goto anon359;
anon631_Else:
	assume !$_$_condition_$124;
	assume $_$_condition_$124 <==> (Heap[this,AVLTreeNode.left] == null);
	assume !(Heap[this,AVLTreeNode.left] == null);
	assert { :msg "  590.106: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  590.106: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  590.106: Receiver might be null." } true ==> (!(Heap[this,AVLTreeNode.left] == null));
	assert { :msg "  590.106: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap[this,AVLTreeNode.left],AVLTreeNode.height);
	goto anon359;
anon632_Then:
	assume $_$_condition_$125;
	assume $_$_condition_$125 <==> (Heap[this,AVLTreeNode.right] == null);
	assume Heap[this,AVLTreeNode.right] == null;
	goto anon359;
anon632_Else:
	assume !$_$_condition_$125;
	assume $_$_condition_$125 <==> (Heap[this,AVLTreeNode.right] == null);
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
	assume $_$_condition_$126;
	assume $_$_condition_$126 <==> (Heap_$_0[this,AVLTreeNode.left] == null);
	assume Heap_$_0[this,AVLTreeNode.left] == null;
	goto anon362;
anon633_Else:
	assume !$_$_condition_$126;
	assume $_$_condition_$126 <==> (Heap_$_0[this,AVLTreeNode.left] == null);
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
	assume $_$_condition_$127;
	assume $_$_condition_$127 <==> (Heap_$_0[this,AVLTreeNode.right] == null);
	assume Heap_$_0[this,AVLTreeNode.right] == null;
	goto anon365;
anon634_Else:
	assume !$_$_condition_$127;
	assume $_$_condition_$127 <==> (Heap_$_0[this,AVLTreeNode.right] == null);
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
	assume $_$_condition_$128;
	assume $_$_condition_$128 <==> (Heap_$_1[this,AVLTreeNode.left] == null);
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	goto anon368;
anon635_Else:
	assume !$_$_condition_$128;
	assume $_$_condition_$128 <==> (Heap_$_1[this,AVLTreeNode.left] == null);
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
	assume $_$_condition_$129;
	assume $_$_condition_$129 <==> (Heap_$_1[this,AVLTreeNode.right] == null);
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	goto anon371;
anon636_Else:
	assume !$_$_condition_$129;
	assume $_$_condition_$129 <==> (Heap_$_1[this,AVLTreeNode.right] == null);
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
	assume $_$_condition_$130;
	assume $_$_condition_$130 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 129.22 might not evaluate to true." } (forall  lk#79#507 : Integer :: ( ((0 <= lk#79#507) && (lk#79#507 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys],lk#79#507) < Heap_$_2[this,AVLTreeNode.key]) ));
	goto $branchMerge_54;
anon637_Else:
	assume !$_$_condition_$130;
	assume $_$_condition_$130 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	goto $branchMerge_54;
anon638_Then:
	assume $_$_condition_$131;
	assume $_$_condition_$131 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 130.22 might not evaluate to true." } Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_55;
anon638_Else:
	assume !$_$_condition_$131;
	assume $_$_condition_$131 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	goto $branchMerge_55;
anon639_Then:
	assume $_$_condition_$133;
	assume $_$_condition_$133 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 136.24 might not evaluate to true." } (forall  rk#80#508 : Integer :: ( ((0 <= rk#80#508) && (rk#80#508 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_2[this,AVLTreeNode.key] < Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys],rk#80#508)) ));
	goto $branchMerge_56;
anon639_Else:
	assume !$_$_condition_$133;
	assume $_$_condition_$133 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	goto $branchMerge_56;
anon640_Then:
	assume $_$_condition_$135;
	assume $_$_condition_$135 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The expression at 137.23 might not evaluate to true." } Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon379;
anon640_Else:
	assume !$_$_condition_$135;
	assume $_$_condition_$135 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
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
	assume $_$_condition_$137;
	assume $_$_condition_$137 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 125.22 might not be positive." } Fractions(100) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 125.22 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1713_$_6 == exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_1713_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_6 == SecMask_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$138) { goto anon642_Then; } else { goto anon642_Else; }
anon641_Else:
	assume !$_$_condition_$137;
	assume $_$_condition_$137 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume SecMask_$_7 == SecMask_$_5;
	assume exhaleMask#_1713_$_7 == exhaleMask#_1713_$_5;
	goto $branchMerge_57;
anon642_Then:
	assume $_$_condition_$138;
	assume $_$_condition_$138 <==> (!CanRead(exhaleMask#_1713_$_6,SecMask_$_6,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1713_$_6,SecMask_$_6,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_1712_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon382;
anon642_Else:
	assume !$_$_condition_$138;
	assume $_$_condition_$138 <==> (!CanRead(exhaleMask#_1713_$_6,SecMask_$_6,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1713_$_6,SecMask_$_6,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon382;
anon643_Then:
	assume $_$_condition_$139;
	assume $_$_condition_$139 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
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
	goto $branchMerge_58;
anon643_Else:
	assume !$_$_condition_$139;
	assume $_$_condition_$139 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1713_$_9 == exhaleMask#_1713_$_7;
	assume SecMask_$_9 == SecMask_$_7;
	goto $branchMerge_58;
anon382:
	assume IsGoodMask(exhaleMask#_1713_$_6);
	assume wf(Heap_$_2,exhaleMask#_1713_$_6,SecMask_$_6);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_6);
	assume SecMask_$_7 == SecMask_$_6;
	assume exhaleMask#_1713_$_7 == exhaleMask#_1713_$_6;
	goto $branchMerge_57;
anon644_Then:
	assume $_$_condition_$141;
	assume $_$_condition_$141 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
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
	goto $branchMerge_59;
anon644_Else:
	assume !$_$_condition_$141;
	assume $_$_condition_$141 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume SecMask_$_11 == SecMask_$_9;
	assume exhaleMask#_1713_$_11 == exhaleMask#_1713_$_9;
	goto $branchMerge_59;
anon645_Then:
	assume $_$_condition_$143;
	assume $_$_condition_$143 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
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
	goto $branchMerge_60;
anon645_Else:
	assume !$_$_condition_$143;
	assume $_$_condition_$143 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_1713_$_13 == exhaleMask#_1713_$_11;
	assume SecMask_$_13 == SecMask_$_11;
	goto $branchMerge_60;
anon646_Then:
	assume $_$_condition_$145;
	assume $_$_condition_$145 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. The permission at 132.23 might not be positive." } Fractions(100) > 0;
	assert { :msg "  595.3: Fold might fail because the definition of AVLTreeNode.valid does not hold. Insufficient fraction at 132.23 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_1713_$_14 == exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_1713_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_14 == SecMask_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$147) { goto anon647_Then; } else { goto anon647_Else; }
anon646_Else:
	assume !$_$_condition_$145;
	assume $_$_condition_$145 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume SecMask_$_15 == SecMask_$_13;
	assume exhaleMask#_1713_$_15 == exhaleMask#_1713_$_13;
	goto $branchMerge_61;
anon647_Then:
	assume $_$_condition_$147;
	assume $_$_condition_$147 <==> (!CanRead(exhaleMask#_1713_$_14,SecMask_$_14,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1713_$_14,SecMask_$_14,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_1712_$_0[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon392;
anon647_Else:
	assume !$_$_condition_$147;
	assume $_$_condition_$147 <==> (!CanRead(exhaleMask#_1713_$_14,SecMask_$_14,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1713_$_14,SecMask_$_14,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon392;
anon648_Then:
	assume $_$_condition_$148;
	assume $_$_condition_$148 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_62;
anon648_Else:
	assume !$_$_condition_$148;
	assume $_$_condition_$148 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_1713_$_17 == exhaleMask#_1713_$_15;
	assume SecMask_$_17 == SecMask_$_15;
	goto $branchMerge_62;
anon392:
	assume IsGoodMask(exhaleMask#_1713_$_14);
	assume wf(Heap_$_2,exhaleMask#_1713_$_14,SecMask_$_14);
	assume wf(Heap_$_2,Mask_$_21,SecMask_$_14);
	assume SecMask_$_15 == SecMask_$_14;
	assume exhaleMask#_1713_$_15 == exhaleMask#_1713_$_14;
	goto $branchMerge_61;
anon649_Then:
	assume $_$_condition_$150;
	assume $_$_condition_$150 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
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
	goto $branchMerge_63;
anon649_Else:
	assume !$_$_condition_$150;
	assume $_$_condition_$150 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume SecMask_$_19 == SecMask_$_17;
	assume exhaleMask#_1713_$_19 == exhaleMask#_1713_$_17;
	goto $branchMerge_63;
anon650_Then:
	assume $_$_condition_$152;
	assume $_$_condition_$152 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
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
	assume !$_$_condition_$152;
	assume $_$_condition_$152 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
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
	assume $_$_condition_$154;
	assume $_$_condition_$154 <==> (false || ((((predVer#_1709_$_0 == exhaleHeap#_1712_$_0[this,AVLTreeNode.valid]) && (this == this)) && true) && true));
	assume false || ((((predVer#_1709_$_0 == exhaleHeap#_1712_$_0[this,AVLTreeNode.valid]) && (this == this)) && true) && true);
	if ($_$_condition_$155) { goto anon652_Then; } else { goto anon652_Else; }
anon651_Else:
	assume !$_$_condition_$154;
	assume $_$_condition_$154 <==> (false || ((((predVer#_1709_$_0 == exhaleHeap#_1712_$_0[this,AVLTreeNode.valid]) && (this == this)) && true) && true));
	assume !(false || ((((predVer#_1709_$_0 == exhaleHeap#_1712_$_0[this,AVLTreeNode.valid]) && (this == this)) && true) && true));
	assume SecMask_$_72 == SecMask_$_21;
	goto $branchMerge_64;
anon652_Then:
	assume $_$_condition_$155;
	assume $_$_condition_$155 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume (forall  lk#79#511 : Integer :: ( ((0 <= lk#79#511) && (lk#79#511 < Seq#Length(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],lk#79#511) < exhaleHeap#_1712_$_0[this,AVLTreeNode.key]) ));
	goto $branchMerge_65;
anon652_Else:
	assume !$_$_condition_$155;
	assume $_$_condition_$155 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	goto $branchMerge_65;
anon678_Then:
	assume $_$_condition_$156;
	assume $_$_condition_$156 <==> (!CanRead(exhaleMask#_1729_$_0,SecMask_$_72,this,AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_1729_$_0,SecMask_$_72,this,AVLTreeNode.valid);
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.valid] < exhaleHeap#_1728_$_0[this,AVLTreeNode.valid];
	goto anon455;
anon678_Else:
	assume !$_$_condition_$156;
	assume $_$_condition_$156 <==> (!CanRead(exhaleMask#_1729_$_0,SecMask_$_72,this,AVLTreeNode.valid));
	assume CanRead(exhaleMask#_1729_$_0,SecMask_$_72,this,AVLTreeNode.valid);
	goto anon455;
anon653_Then:
	assume $_$_condition_$157;
	assume $_$_condition_$157 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_66;
anon653_Else:
	assume !$_$_condition_$157;
	assume $_$_condition_$157 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	goto $branchMerge_66;
anon654_Then:
	assume $_$_condition_$159;
	assume $_$_condition_$159 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume (forall  rk#80#512 : Integer :: ( ((0 <= rk#80#512) && (rk#80#512 < Seq#Length(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_1712_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],rk#80#512)) ));
	goto $branchMerge_67;
anon654_Else:
	assume !$_$_condition_$159;
	assume $_$_condition_$159 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	goto $branchMerge_67;
anon655_Then:
	assume $_$_condition_$161;
	assume $_$_condition_$161 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume exhaleHeap#_1712_$_0[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon408;
anon655_Else:
	assume !$_$_condition_$161;
	assume $_$_condition_$161 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
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
	assume $_$_condition_$163;
	assume SecMask_$_22[this,AVLTreeNode.key][perm$R] < 0;
	assume SecMask_$_23 == SecMask_$_22[this,AVLTreeNode.key := SecMask_$_22[this,AVLTreeNode.key][perm$R := 0]];
	assume SecMask_$_24 == SecMask_$_23;
	goto anon410;
anon656_Else:
	assume !$_$_condition_$163;
	assume 0 <= SecMask_$_22[this,AVLTreeNode.key][perm$R];
	assume SecMask_$_24 == SecMask_$_22;
	goto anon410;
anon410:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_24,SecMask_$_24);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_24);
	assume SecMask_$_25 == SecMask_$_24[this,AVLTreeNode.height := SecMask_$_24[this,AVLTreeNode.height][perm$R := SecMask_$_24[this,AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$164) { goto anon657_Then; } else { goto anon657_Else; }
anon657_Then:
	assume $_$_condition_$164;
	assume SecMask_$_25[this,AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_26 == SecMask_$_25[this,AVLTreeNode.height := SecMask_$_25[this,AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_27 == SecMask_$_26;
	goto anon412;
anon657_Else:
	assume !$_$_condition_$164;
	assume 0 <= SecMask_$_25[this,AVLTreeNode.height][perm$R];
	assume SecMask_$_27 == SecMask_$_25;
	goto anon412;
anon412:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_27,SecMask_$_27);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_27);
	assume SecMask_$_28 == SecMask_$_27[this,AVLTreeNode.left := SecMask_$_27[this,AVLTreeNode.left][perm$R := SecMask_$_27[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	if ($_$_condition_$165) { goto anon658_Then; } else { goto anon658_Else; }
anon658_Then:
	assume $_$_condition_$165;
	assume SecMask_$_28[this,AVLTreeNode.left][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[this,AVLTreeNode.left := SecMask_$_28[this,AVLTreeNode.left][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon414;
anon658_Else:
	assume !$_$_condition_$165;
	assume 0 <= SecMask_$_28[this,AVLTreeNode.left][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon414;
anon414:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_30,SecMask_$_30);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30[this,AVLTreeNode.right := SecMask_$_30[this,AVLTreeNode.right][perm$R := SecMask_$_30[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	if ($_$_condition_$166) { goto anon659_Then; } else { goto anon659_Else; }
anon659_Then:
	assume $_$_condition_$166;
	assume SecMask_$_31[this,AVLTreeNode.right][perm$R] < 0;
	assume SecMask_$_32 == SecMask_$_31[this,AVLTreeNode.right := SecMask_$_31[this,AVLTreeNode.right][perm$R := 0]];
	assume SecMask_$_33 == SecMask_$_32;
	goto anon416;
anon659_Else:
	assume !$_$_condition_$166;
	assume 0 <= SecMask_$_31[this,AVLTreeNode.right][perm$R];
	assume SecMask_$_33 == SecMask_$_31;
	goto anon416;
anon416:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_33,SecMask_$_33);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_33);
	assume SecMask_$_34 == SecMask_$_33[this,AVLTreeNode.keys := SecMask_$_33[this,AVLTreeNode.keys][perm$R := SecMask_$_33[this,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$167) { goto anon660_Then; } else { goto anon660_Else; }
anon660_Then:
	assume $_$_condition_$167;
	assume SecMask_$_34[this,AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_35 == SecMask_$_34[this,AVLTreeNode.keys := SecMask_$_34[this,AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_36 == SecMask_$_35;
	goto anon418;
anon660_Else:
	assume !$_$_condition_$167;
	assume 0 <= SecMask_$_34[this,AVLTreeNode.keys][perm$R];
	assume SecMask_$_36 == SecMask_$_34;
	goto anon418;
anon418:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_36,SecMask_$_36);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_36);
	assume SecMask_$_37 == SecMask_$_36[this,AVLTreeNode.balanceFactor := SecMask_$_36[this,AVLTreeNode.balanceFactor][perm$R := SecMask_$_36[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$168) { goto anon661_Then; } else { goto anon661_Else; }
anon661_Then:
	assume $_$_condition_$168;
	assume SecMask_$_37[this,AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_38 == SecMask_$_37[this,AVLTreeNode.balanceFactor := SecMask_$_37[this,AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_39 == SecMask_$_38;
	goto anon420;
anon661_Else:
	assume !$_$_condition_$168;
	assume 0 <= SecMask_$_37[this,AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_39 == SecMask_$_37;
	goto anon420;
anon420:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_39,SecMask_$_39);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_39);
	if ($_$_condition_$169) { goto anon662_Then; } else { goto anon662_Else; }
anon662_Then:
	assume $_$_condition_$169;
	assume $_$_condition_$169 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_40 == SecMask_$_39[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_39[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := SecMask_$_39[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$170) { goto anon663_Then; } else { goto anon663_Else; }
anon662_Else:
	assume !$_$_condition_$169;
	assume $_$_condition_$169 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_43 == SecMask_$_39;
	goto $branchMerge_68;
anon663_Then:
	assume $_$_condition_$170;
	assume SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_41 == SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_42 == SecMask_$_41;
	goto anon423;
anon663_Else:
	assume !$_$_condition_$170;
	assume 0 <= SecMask_$_40[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R];
	assume SecMask_$_42 == SecMask_$_40;
	goto anon423;
anon664_Then:
	assume $_$_condition_$171;
	assume $_$_condition_$171 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_44 == SecMask_$_43[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_43[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := SecMask_$_43[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$173) { goto anon665_Then; } else { goto anon665_Else; }
anon664_Else:
	assume !$_$_condition_$171;
	assume $_$_condition_$171 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_47 == SecMask_$_43;
	goto $branchMerge_69;
anon423:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_42,SecMask_$_42);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_42);
	assume SecMask_$_43 == SecMask_$_42;
	goto $branchMerge_68;
anon665_Then:
	assume $_$_condition_$173;
	assume SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_45 == SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height := SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_46 == SecMask_$_45;
	goto anon427;
anon665_Else:
	assume !$_$_condition_$173;
	assume 0 <= SecMask_$_44[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume SecMask_$_46 == SecMask_$_44;
	goto anon427;
anon666_Then:
	assume $_$_condition_$174;
	assume $_$_condition_$174 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_48 == SecMask_$_47[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_47[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := SecMask_$_47[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$176) { goto anon667_Then; } else { goto anon667_Else; }
anon666_Else:
	assume !$_$_condition_$174;
	assume $_$_condition_$174 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_51 == SecMask_$_47;
	goto $branchMerge_70;
anon427:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_46,SecMask_$_46);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_46);
	assume SecMask_$_47 == SecMask_$_46;
	goto $branchMerge_69;
anon667_Then:
	assume $_$_condition_$176;
	assume SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_49 == SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_50 == SecMask_$_49;
	goto anon431;
anon667_Else:
	assume !$_$_condition_$176;
	assume 0 <= SecMask_$_48[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R];
	assume SecMask_$_50 == SecMask_$_48;
	goto anon431;
anon668_Then:
	assume $_$_condition_$177;
	assume $_$_condition_$177 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null);
	assume SecMask_$_52 == SecMask_$_51[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_51[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := SecMask_$_51[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$179) { goto anon669_Then; } else { goto anon669_Else; }
anon668_Else:
	assume !$_$_condition_$177;
	assume $_$_condition_$177 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.left] == null;
	assume SecMask_$_55 == SecMask_$_51;
	goto $branchMerge_71;
anon431:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_50,SecMask_$_50);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_50);
	assume SecMask_$_51 == SecMask_$_50;
	goto $branchMerge_70;
anon669_Then:
	assume $_$_condition_$179;
	assume SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_53 == SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_54 == SecMask_$_53;
	goto anon435;
anon669_Else:
	assume !$_$_condition_$179;
	assume 0 <= SecMask_$_52[exhaleHeap#_1712_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_54 == SecMask_$_52;
	goto anon435;
anon670_Then:
	assume $_$_condition_$180;
	assume $_$_condition_$180 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_56 == SecMask_$_55[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_55[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := SecMask_$_55[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$182) { goto anon671_Then; } else { goto anon671_Else; }
anon670_Else:
	assume !$_$_condition_$180;
	assume $_$_condition_$180 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_59 == SecMask_$_55;
	goto $branchMerge_72;
anon435:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_54,SecMask_$_54);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_54);
	assume SecMask_$_55 == SecMask_$_54;
	goto $branchMerge_71;
anon671_Then:
	assume $_$_condition_$182;
	assume SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_57 == SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_58 == SecMask_$_57;
	goto anon439;
anon671_Else:
	assume !$_$_condition_$182;
	assume 0 <= SecMask_$_56[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R];
	assume SecMask_$_58 == SecMask_$_56;
	goto anon439;
anon672_Then:
	assume $_$_condition_$183;
	assume $_$_condition_$183 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_60 == SecMask_$_59[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_59[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := SecMask_$_59[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$185) { goto anon673_Then; } else { goto anon673_Else; }
anon672_Else:
	assume !$_$_condition_$183;
	assume $_$_condition_$183 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_63 == SecMask_$_59;
	goto $branchMerge_73;
anon439:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_58,SecMask_$_58);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_58);
	assume SecMask_$_59 == SecMask_$_58;
	goto $branchMerge_72;
anon673_Then:
	assume $_$_condition_$185;
	assume SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_61 == SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height := SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_62 == SecMask_$_61;
	goto anon443;
anon673_Else:
	assume !$_$_condition_$185;
	assume 0 <= SecMask_$_60[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume SecMask_$_62 == SecMask_$_60;
	goto anon443;
anon674_Then:
	assume $_$_condition_$186;
	assume $_$_condition_$186 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_64 == SecMask_$_63[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_63[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := SecMask_$_63[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$188) { goto anon675_Then; } else { goto anon675_Else; }
anon674_Else:
	assume !$_$_condition_$186;
	assume $_$_condition_$186 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_67 == SecMask_$_63;
	goto $branchMerge_74;
anon443:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_62,SecMask_$_62);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_62);
	assume SecMask_$_63 == SecMask_$_62;
	goto $branchMerge_73;
anon675_Then:
	assume $_$_condition_$188;
	assume SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_65 == SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_66 == SecMask_$_65;
	goto anon447;
anon675_Else:
	assume !$_$_condition_$188;
	assume 0 <= SecMask_$_64[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R];
	assume SecMask_$_66 == SecMask_$_64;
	goto anon447;
anon676_Then:
	assume $_$_condition_$189;
	assume $_$_condition_$189 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume !(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null);
	assume SecMask_$_68 == SecMask_$_67[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_67[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := SecMask_$_67[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$191) { goto anon677_Then; } else { goto anon677_Else; }
anon676_Else:
	assume !$_$_condition_$189;
	assume $_$_condition_$189 <==> (!(exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null));
	assume exhaleHeap#_1712_$_0[this,AVLTreeNode.right] == null;
	assume SecMask_$_71 == SecMask_$_67;
	goto anon452;
anon447:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_66,SecMask_$_66);
	assume wf(exhaleHeap#_1712_$_0,Mask_$_22,SecMask_$_66);
	assume SecMask_$_67 == SecMask_$_66;
	goto $branchMerge_74;
anon677_Then:
	assume $_$_condition_$191;
	assume SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_69 == SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_70 == SecMask_$_69;
	goto anon451;
anon677_Else:
	assume !$_$_condition_$191;
	assume 0 <= SecMask_$_68[exhaleHeap#_1712_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_70 == SecMask_$_68;
	goto anon451;
anon452:
	assume wf(exhaleHeap#_1712_$_0,SecMask_$_71,SecMask_$_71);
	assume SecMask_$_72 == SecMask_$_71;
	goto $branchMerge_64;
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
$branchMerge_0:
	if ($_$_condition_$0) { goto anon457_Then; } else { goto anon457_Else; }
$branchMerge_1:
	if ($_$_condition_$2) { goto anon458_Then; } else { goto anon458_Else; }
$branchMerge_2:
	if ($_$_condition_$4) { goto anon459_Then; } else { goto anon459_Else; }
$branchMerge_3:
	if ($_$_condition_$6) { goto anon460_Then; } else { goto anon460_Else; }
$branchMerge_4:
	if ($_$_condition_$8) { goto anon461_Then; } else { goto anon461_Else; }
$branchMerge_5:
	if ($_$_condition_$10) { goto anon462_Then; } else { goto anon462_Else; }
$branchMerge_6:
	if ($_$_condition_$12) { goto anon463_Then; } else { goto anon463_Else; }
$branchMerge_7:
	if ($_$_condition_$14) { goto anon464_Then; } else { goto anon464_Else; }
$branchMerge_8:
	if ($_$_condition_$16) { goto anon465_Then; } else { goto anon465_Else; }
$branchMerge_9:
	if ($_$_condition_$24) { goto anon498_Then; } else { goto anon498_Else; }
$branchMerge_10:
	if ($_$_condition_$26) { goto anon499_Then; } else { goto anon499_Else; }
$branchMerge_11:
	if ($_$_condition_$28) { goto anon500_Then; } else { goto anon500_Else; }
$branchMerge_12:
	if ($_$_condition_$30) { goto anon501_Then; } else { goto anon501_Else; }
$branchMerge_13:
	if ($_$_condition_$32) { goto anon502_Then; } else { goto anon502_Else; }
$branchMerge_14:
	if ($_$_condition_$34) { goto anon503_Then; } else { goto anon503_Else; }
$branchMerge_15:
	if ($_$_condition_$36) { goto anon504_Then; } else { goto anon504_Else; }
$branchMerge_16:
	if ($_$_condition_$38) { goto anon505_Then; } else { goto anon505_Else; }
$branchMerge_17:
	if ($_$_condition_$40) { goto anon506_Then; } else { goto anon506_Else; }
$branchMerge_18:
	if ($_$_condition_$42) { goto anon507_Then; } else { goto anon507_Else; }
$branchMerge_19:
	if ($_$_condition_$44) { goto anon508_Then; } else { goto anon508_Else; }
$branchMerge_20:
	if ($_$_condition_$48) { goto anon537_Then; } else { goto anon537_Else; }
$branchMerge_21:
	if ($_$_condition_$50) { goto anon538_Then; } else { goto anon538_Else; }
$branchMerge_22:
	if ($_$_condition_$52) { goto anon539_Then; } else { goto anon539_Else; }
$branchMerge_23:
	if ($_$_condition_$54) { goto anon540_Then; } else { goto anon540_Else; }
$branchMerge_24:
	if ($_$_condition_$56) { goto anon541_Then; } else { goto anon541_Else; }
$branchMerge_25:
	if ($_$_condition_$58) { goto anon542_Then; } else { goto anon542_Else; }
$branchMerge_26:
	if ($_$_condition_$60) { goto anon543_Then; } else { goto anon543_Else; }
$branchMerge_27:
	if ($_$_condition_$62) { goto anon544_Then; } else { goto anon544_Else; }
$branchMerge_28:
	if ($_$_condition_$64) { goto anon545_Then; } else { goto anon545_Else; }
$branchMerge_29:
	if ($_$_condition_$66) { goto anon546_Then; } else { goto anon546_Else; }
$branchMerge_30:
	if ($_$_condition_$68) { goto anon547_Then; } else { goto anon547_Else; }
$branchMerge_31:
	if ($_$_condition_$74) { goto anon578_Then; } else { goto anon578_Else; }
$branchMerge_32:
	if ($_$_condition_$76) { goto anon579_Then; } else { goto anon579_Else; }
$branchMerge_33:
	if ($_$_condition_$78) { goto anon580_Then; } else { goto anon580_Else; }
$branchMerge_34:
	if ($_$_condition_$80) { goto anon581_Then; } else { goto anon581_Else; }
$branchMerge_35:
	if ($_$_condition_$82) { goto anon582_Then; } else { goto anon582_Else; }
$branchMerge_36:
	if ($_$_condition_$84) { goto anon583_Then; } else { goto anon583_Else; }
$branchMerge_37:
	if ($_$_condition_$86) { goto anon584_Then; } else { goto anon584_Else; }
$branchMerge_38:
	if ($_$_condition_$88) { goto anon585_Then; } else { goto anon585_Else; }
$branchMerge_39:
	if ($_$_condition_$90) { goto anon586_Then; } else { goto anon586_Else; }
$branchMerge_40:
	if ($_$_condition_$92) { goto anon587_Then; } else { goto anon587_Else; }
$branchMerge_41:
	if ($_$_condition_$94) { goto anon588_Then; } else { goto anon588_Else; }
$branchMerge_42:
	if ($_$_condition_$98) { goto anon617_Then; } else { goto anon617_Else; }
$branchMerge_43:
	if ($_$_condition_$100) { goto anon618_Then; } else { goto anon618_Else; }
$branchMerge_44:
	if ($_$_condition_$102) { goto anon619_Then; } else { goto anon619_Else; }
$branchMerge_45:
	if ($_$_condition_$104) { goto anon620_Then; } else { goto anon620_Else; }
$branchMerge_46:
	if ($_$_condition_$106) { goto anon621_Then; } else { goto anon621_Else; }
$branchMerge_47:
	if ($_$_condition_$108) { goto anon622_Then; } else { goto anon622_Else; }
$branchMerge_48:
	if ($_$_condition_$110) { goto anon623_Then; } else { goto anon623_Else; }
$branchMerge_49:
	if ($_$_condition_$112) { goto anon624_Then; } else { goto anon624_Else; }
$branchMerge_50:
	if ($_$_condition_$114) { goto anon625_Then; } else { goto anon625_Else; }
$branchMerge_51:
	if ($_$_condition_$116) { goto anon626_Then; } else { goto anon626_Else; }
$branchMerge_52:
	if ($_$_condition_$118) { goto anon627_Then; } else { goto anon627_Else; }
$branchMerge_53:
	if ($_$_condition_$122) { goto anon630_Then; } else { goto anon630_Else; }
$branchMerge_54:
	if ($_$_condition_$131) { goto anon638_Then; } else { goto anon638_Else; }
$branchMerge_55:
	if ($_$_condition_$133) { goto anon639_Then; } else { goto anon639_Else; }
$branchMerge_56:
	if ($_$_condition_$135) { goto anon640_Then; } else { goto anon640_Else; }
$branchMerge_57:
	if ($_$_condition_$139) { goto anon643_Then; } else { goto anon643_Else; }
$branchMerge_58:
	if ($_$_condition_$141) { goto anon644_Then; } else { goto anon644_Else; }
$branchMerge_59:
	if ($_$_condition_$143) { goto anon645_Then; } else { goto anon645_Else; }
$branchMerge_60:
	if ($_$_condition_$145) { goto anon646_Then; } else { goto anon646_Else; }
$branchMerge_61:
	if ($_$_condition_$148) { goto anon648_Then; } else { goto anon648_Else; }
$branchMerge_62:
	if ($_$_condition_$150) { goto anon649_Then; } else { goto anon649_Else; }
$branchMerge_63:
	if ($_$_condition_$152) { goto anon650_Then; } else { goto anon650_Else; }
$branchMerge_64:
	if ($_$_condition_$156) { goto anon678_Then; } else { goto anon678_Else; }
$branchMerge_65:
	if ($_$_condition_$157) { goto anon653_Then; } else { goto anon653_Else; }
$branchMerge_66:
	if ($_$_condition_$159) { goto anon654_Then; } else { goto anon654_Else; }
$branchMerge_67:
	if ($_$_condition_$161) { goto anon655_Then; } else { goto anon655_Else; }
$branchMerge_68:
	if ($_$_condition_$171) { goto anon664_Then; } else { goto anon664_Else; }
$branchMerge_69:
	if ($_$_condition_$174) { goto anon666_Then; } else { goto anon666_Else; }
$branchMerge_70:
	if ($_$_condition_$177) { goto anon668_Then; } else { goto anon668_Else; }
$branchMerge_71:
	if ($_$_condition_$180) { goto anon670_Then; } else { goto anon670_Else; }
$branchMerge_72:
	if ($_$_condition_$183) { goto anon672_Then; } else { goto anon672_Else; }
$branchMerge_73:
	if ($_$_condition_$186) { goto anon674_Then; } else { goto anon674_Else; }
$branchMerge_74:
	if ($_$_condition_$189) { goto anon676_Then; } else { goto anon676_Else; }
}
