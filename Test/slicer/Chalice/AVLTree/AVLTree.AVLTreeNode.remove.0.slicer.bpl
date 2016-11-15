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
var nl#24 : ref;
var nr#26 : ref;
var this#248 : ref;
var this#250 : ref;
var r#251 : ref;
var m#252 : ref;
var this#254 : ref;
var r#255 : ref;
var m#256 : ref;
var this#264 : ref;
var nl#28 : ref;
var this#269 : ref;
var r#271 : ref;
var this#274 : ref;
var this#276 : ref;
var r#277 : ref;
var this#282 : ref;
var this#287 : ref;
var nr#32 : ref;
var this#292 : ref;
var r#294 : ref;
var this#297 : ref;
var this#299 : ref;
var r#300 : ref;
var this#305 : ref;
var this#310 : ref;
var methodK#_506 : int;
var Mask_$_0 : MaskType;
var Mask_$_1 : MaskType;
var Mask_$_2 : MaskType;
var Mask_$_3 : MaskType;
var unfoldK#_507 : int;
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
var cond#_529_$_0 : bool;
var cond#_717_$_0 : bool;
var cond#_817_$_0 : bool;
var methodCallK#_897 : int;
var exhaleMask#_899_$_0 : MaskType;
var exhaleMask#_899_$_1 : MaskType;
var exhaleMask#_899_$_2 : MaskType;
var exhaleMask#_899_$_3 : MaskType;
var exhaleMask#_899_$_4 : MaskType;
var exhaleMask#_899_$_5 : MaskType;
var exhaleMask#_899_$_7 : MaskType;
var exhaleMask#_899_$_9 : MaskType;
var exhaleMask#_899_$_11 : MaskType;
var exhaleMask#_899_$_13 : MaskType;
var exhaleMask#_899_$_15 : MaskType;
var exhaleMask#_899_$_17 : MaskType;
var exhaleMask#_899_$_19 : MaskType;
var exhaleMask#_899_$_21 : MaskType;
var exhaleHeap#_898_$_0 : HeapType;
var Mask_$_27 : MaskType;
var Mask_$_28 : MaskType;
var Mask_$_29 : MaskType;
var Mask_$_30 : MaskType;
var Mask_$_149 : MaskType;
var Heap_$_9 : HeapType;
var r#20_$_3 : ref;
var exhaleMask#_917_$_1 : MaskType;
var exhaleMask#_917_$_3 : MaskType;
var exhaleMask#_917_$_5 : MaskType;
var exhaleMask#_917_$_7 : MaskType;
var exhaleHeap#_916_$_0 : HeapType;
var exhaleMask#_917_$_6 : MaskType;
var exhaleMask#_917_$_4 : MaskType;
var exhaleMask#_917_$_2 : MaskType;
var exhaleMask#_917_$_0 : MaskType;
var exhaleMask#_899_$_20 : MaskType;
var exhaleMask#_899_$_18 : MaskType;
var exhaleMask#_899_$_16 : MaskType;
var exhaleMask#_899_$_14 : MaskType;
var exhaleMask#_899_$_12 : MaskType;
var exhaleMask#_899_$_10 : MaskType;
var exhaleMask#_899_$_8 : MaskType;
var exhaleMask#_899_$_6 : MaskType;
var methodCallK#_822 : int;
var this#292_$_0 : ref;
var exhaleMask#_824_$_0 : MaskType;
var exhaleMask#_824_$_1 : MaskType;
var exhaleMask#_824_$_2 : MaskType;
var exhaleMask#_824_$_3 : MaskType;
var exhaleHeap#_823_$_0 : HeapType;
var r#294_$_0 : ref;
var Mask_$_32 : MaskType;
var Mask_$_34 : MaskType;
var Mask_$_36 : MaskType;
var Mask_$_38 : MaskType;
var Heap_$_2 : HeapType;
var methodCallK#_835 : int;
var exhaleMask#_837_$_0 : MaskType;
var exhaleMask#_837_$_2 : MaskType;
var exhaleMask#_837_$_3 : MaskType;
var exhaleMask#_837_$_5 : MaskType;
var exhaleMask#_837_$_7 : MaskType;
var exhaleMask#_837_$_9 : MaskType;
var exhaleHeap#_836_$_0 : HeapType;
var Mask_$_39 : MaskType;
var Mask_$_41 : MaskType;
var Mask_$_43 : MaskType;
var Mask_$_44 : MaskType;
var Mask_$_46 : MaskType;
var Mask_$_48 : MaskType;
var bf#298_$_0 : int;
var cond#_846_$_0 : bool;
var methodCallK#_874 : int;
var exhaleMask#_876_$_0 : MaskType;
var exhaleMask#_876_$_1 : MaskType;
var exhaleMask#_876_$_2 : MaskType;
var exhaleMask#_876_$_3 : MaskType;
var exhaleMask#_876_$_4 : MaskType;
var exhaleMask#_876_$_5 : MaskType;
var exhaleMask#_876_$_7 : MaskType;
var exhaleMask#_876_$_9 : MaskType;
var exhaleMask#_876_$_11 : MaskType;
var exhaleMask#_876_$_13 : MaskType;
var exhaleMask#_876_$_15 : MaskType;
var exhaleMask#_876_$_17 : MaskType;
var exhaleMask#_876_$_19 : MaskType;
var exhaleMask#_876_$_21 : MaskType;
var exhaleHeap#_875_$_0 : HeapType;
var Mask_$_49 : MaskType;
var Mask_$_50 : MaskType;
var Mask_$_51 : MaskType;
var Mask_$_52 : MaskType;
var exhaleMask#_876_$_20 : MaskType;
var exhaleMask#_876_$_18 : MaskType;
var exhaleMask#_876_$_16 : MaskType;
var exhaleMask#_876_$_14 : MaskType;
var exhaleMask#_876_$_12 : MaskType;
var exhaleMask#_876_$_10 : MaskType;
var exhaleMask#_876_$_8 : MaskType;
var exhaleMask#_876_$_6 : MaskType;
var methodCallK#_851 : int;
var exhaleMask#_853_$_0 : MaskType;
var exhaleMask#_853_$_1 : MaskType;
var exhaleMask#_853_$_2 : MaskType;
var exhaleMask#_853_$_3 : MaskType;
var exhaleMask#_853_$_4 : MaskType;
var exhaleMask#_853_$_5 : MaskType;
var exhaleMask#_853_$_6 : MaskType;
var exhaleMask#_853_$_7 : MaskType;
var exhaleMask#_853_$_8 : MaskType;
var exhaleMask#_853_$_9 : MaskType;
var exhaleMask#_853_$_11 : MaskType;
var exhaleMask#_853_$_13 : MaskType;
var exhaleMask#_853_$_15 : MaskType;
var exhaleMask#_853_$_17 : MaskType;
var exhaleHeap#_852_$_0 : HeapType;
var r#300_$_0 : ref;
var Mask_$_53 : MaskType;
var Mask_$_54 : MaskType;
var Mask_$_55 : MaskType;
var Mask_$_56 : MaskType;
var exhaleMask#_853_$_16 : MaskType;
var exhaleMask#_853_$_14 : MaskType;
var exhaleMask#_853_$_12 : MaskType;
var exhaleMask#_853_$_10 : MaskType;
var Mask_$_47 : MaskType;
var Mask_$_45 : MaskType;
var Mask_$_42 : MaskType;
var Mask_$_40 : MaskType;
var exhaleMask#_837_$_8 : MaskType;
var exhaleMask#_837_$_6 : MaskType;
var exhaleMask#_837_$_4 : MaskType;
var exhaleMask#_837_$_1 : MaskType;
var Mask_$_37 : MaskType;
var Mask_$_35 : MaskType;
var Mask_$_33 : MaskType;
var Mask_$_31 : MaskType;
var cond#_718_$_0 : bool;
var methodCallK#_798 : int;
var exhaleMask#_800_$_0 : MaskType;
var exhaleMask#_800_$_1 : MaskType;
var exhaleMask#_800_$_2 : MaskType;
var exhaleMask#_800_$_3 : MaskType;
var exhaleMask#_800_$_4 : MaskType;
var exhaleMask#_800_$_5 : MaskType;
var exhaleMask#_800_$_7 : MaskType;
var exhaleMask#_800_$_9 : MaskType;
var exhaleMask#_800_$_11 : MaskType;
var exhaleMask#_800_$_13 : MaskType;
var exhaleMask#_800_$_15 : MaskType;
var exhaleMask#_800_$_17 : MaskType;
var exhaleMask#_800_$_19 : MaskType;
var exhaleMask#_800_$_21 : MaskType;
var exhaleHeap#_799_$_0 : HeapType;
var Mask_$_57 : MaskType;
var Mask_$_58 : MaskType;
var Mask_$_59 : MaskType;
var Mask_$_60 : MaskType;
var exhaleMask#_800_$_20 : MaskType;
var exhaleMask#_800_$_18 : MaskType;
var exhaleMask#_800_$_16 : MaskType;
var exhaleMask#_800_$_14 : MaskType;
var exhaleMask#_800_$_12 : MaskType;
var exhaleMask#_800_$_10 : MaskType;
var exhaleMask#_800_$_8 : MaskType;
var exhaleMask#_800_$_6 : MaskType;
var methodCallK#_723 : int;
var this#269_$_0 : ref;
var exhaleMask#_725_$_0 : MaskType;
var exhaleMask#_725_$_1 : MaskType;
var exhaleMask#_725_$_2 : MaskType;
var exhaleMask#_725_$_3 : MaskType;
var exhaleHeap#_724_$_0 : HeapType;
var r#271_$_0 : ref;
var Mask_$_62 : MaskType;
var Mask_$_64 : MaskType;
var Mask_$_66 : MaskType;
var Mask_$_68 : MaskType;
var Heap_$_3 : HeapType;
var methodCallK#_736 : int;
var exhaleMask#_738_$_0 : MaskType;
var exhaleMask#_738_$_2 : MaskType;
var exhaleMask#_738_$_3 : MaskType;
var exhaleMask#_738_$_5 : MaskType;
var exhaleMask#_738_$_7 : MaskType;
var exhaleMask#_738_$_9 : MaskType;
var exhaleHeap#_737_$_0 : HeapType;
var Mask_$_69 : MaskType;
var Mask_$_71 : MaskType;
var Mask_$_73 : MaskType;
var Mask_$_74 : MaskType;
var Mask_$_76 : MaskType;
var Mask_$_78 : MaskType;
var bf#275_$_0 : int;
var cond#_747_$_0 : bool;
var methodCallK#_775 : int;
var exhaleMask#_777_$_0 : MaskType;
var exhaleMask#_777_$_1 : MaskType;
var exhaleMask#_777_$_2 : MaskType;
var exhaleMask#_777_$_3 : MaskType;
var exhaleMask#_777_$_4 : MaskType;
var exhaleMask#_777_$_5 : MaskType;
var exhaleMask#_777_$_7 : MaskType;
var exhaleMask#_777_$_9 : MaskType;
var exhaleMask#_777_$_11 : MaskType;
var exhaleMask#_777_$_13 : MaskType;
var exhaleMask#_777_$_15 : MaskType;
var exhaleMask#_777_$_17 : MaskType;
var exhaleMask#_777_$_19 : MaskType;
var exhaleMask#_777_$_21 : MaskType;
var exhaleHeap#_776_$_0 : HeapType;
var Mask_$_79 : MaskType;
var Mask_$_80 : MaskType;
var Mask_$_81 : MaskType;
var Mask_$_82 : MaskType;
var exhaleMask#_777_$_20 : MaskType;
var exhaleMask#_777_$_18 : MaskType;
var exhaleMask#_777_$_16 : MaskType;
var exhaleMask#_777_$_14 : MaskType;
var exhaleMask#_777_$_12 : MaskType;
var exhaleMask#_777_$_10 : MaskType;
var exhaleMask#_777_$_8 : MaskType;
var exhaleMask#_777_$_6 : MaskType;
var methodCallK#_752 : int;
var exhaleMask#_754_$_0 : MaskType;
var exhaleMask#_754_$_1 : MaskType;
var exhaleMask#_754_$_2 : MaskType;
var exhaleMask#_754_$_3 : MaskType;
var exhaleMask#_754_$_4 : MaskType;
var exhaleMask#_754_$_5 : MaskType;
var exhaleMask#_754_$_7 : MaskType;
var exhaleMask#_754_$_9 : MaskType;
var exhaleMask#_754_$_11 : MaskType;
var exhaleMask#_754_$_13 : MaskType;
var exhaleMask#_754_$_14 : MaskType;
var exhaleMask#_754_$_15 : MaskType;
var exhaleMask#_754_$_16 : MaskType;
var exhaleMask#_754_$_17 : MaskType;
var exhaleHeap#_753_$_0 : HeapType;
var r#277_$_0 : ref;
var Mask_$_83 : MaskType;
var Mask_$_84 : MaskType;
var Mask_$_85 : MaskType;
var Mask_$_86 : MaskType;
var exhaleMask#_754_$_12 : MaskType;
var exhaleMask#_754_$_10 : MaskType;
var exhaleMask#_754_$_8 : MaskType;
var exhaleMask#_754_$_6 : MaskType;
var Mask_$_77 : MaskType;
var Mask_$_75 : MaskType;
var Mask_$_72 : MaskType;
var Mask_$_70 : MaskType;
var exhaleMask#_738_$_8 : MaskType;
var exhaleMask#_738_$_6 : MaskType;
var exhaleMask#_738_$_4 : MaskType;
var exhaleMask#_738_$_1 : MaskType;
var Mask_$_67 : MaskType;
var Mask_$_65 : MaskType;
var Mask_$_63 : MaskType;
var Mask_$_61 : MaskType;
var cond#_530_$_0 : bool;
var nl#24_$_0 : ref;
var nr#26_$_0 : ref;
var methodCallK#_634 : int;
var exhaleMask#_636_$_0 : MaskType;
var exhaleMask#_636_$_2 : MaskType;
var exhaleMask#_636_$_3 : MaskType;
var exhaleMask#_636_$_5 : MaskType;
var exhaleMask#_636_$_7 : MaskType;
var exhaleMask#_636_$_9 : MaskType;
var exhaleHeap#_635_$_0 : HeapType;
var Mask_$_87 : MaskType;
var Mask_$_89 : MaskType;
var Mask_$_91 : MaskType;
var Mask_$_92 : MaskType;
var Mask_$_94 : MaskType;
var Mask_$_96 : MaskType;
var bf#249_$_0 : int;
var cond#_645_$_0 : bool;
var methodCallK#_663 : int;
var this#254_$_0 : ref;
var exhaleMask#_665_$_0 : MaskType;
var exhaleMask#_665_$_1 : MaskType;
var exhaleMask#_665_$_2 : MaskType;
var exhaleMask#_665_$_3 : MaskType;
var exhaleHeap#_664_$_0 : HeapType;
var r#255_$_0 : ref;
var m#256_$_0 : ref;
var Mask_$_98 : MaskType;
var Mask_$_100 : MaskType;
var Mask_$_102 : MaskType;
var Mask_$_104 : MaskType;
var Mask_$_105 : MaskType;
var Mask_$_106 : MaskType;
var Mask_$_107 : MaskType;
var Mask_$_108 : MaskType;
var Mask_$_121 : MaskType;
var Heap_$_4 : HeapType;
var nl#24_$_1 : ref;
var nr#26_$_1 : ref;
var r#20_$_0 : ref;
var unfoldK#_672 : int;
var Mask_$_122 : MaskType;
var Heap_$_6 : HeapType;
var Mask_$_123 : MaskType;
var Mask_$_124 : MaskType;
var Mask_$_125 : MaskType;
var Mask_$_126 : MaskType;
var Mask_$_127 : MaskType;
var Mask_$_128 : MaskType;
var Mask_$_130 : MaskType;
var Mask_$_132 : MaskType;
var Mask_$_134 : MaskType;
var Mask_$_136 : MaskType;
var Mask_$_138 : MaskType;
var Mask_$_140 : MaskType;
var Mask_$_142 : MaskType;
var Mask_$_144 : MaskType;
var Heap_$_7 : HeapType;
var Heap_$_8 : HeapType;
var methodCallK#_698 : int;
var exhaleMask#_700_$_0 : MaskType;
var exhaleMask#_700_$_1 : MaskType;
var exhaleMask#_700_$_2 : MaskType;
var exhaleMask#_700_$_3 : MaskType;
var exhaleMask#_700_$_4 : MaskType;
var exhaleMask#_700_$_5 : MaskType;
var exhaleMask#_700_$_7 : MaskType;
var exhaleMask#_700_$_9 : MaskType;
var exhaleMask#_700_$_11 : MaskType;
var exhaleMask#_700_$_13 : MaskType;
var exhaleMask#_700_$_15 : MaskType;
var exhaleMask#_700_$_17 : MaskType;
var exhaleMask#_700_$_19 : MaskType;
var exhaleMask#_700_$_21 : MaskType;
var exhaleHeap#_699_$_0 : HeapType;
var Mask_$_145 : MaskType;
var Mask_$_146 : MaskType;
var Mask_$_147 : MaskType;
var Mask_$_148 : MaskType;
var exhaleMask#_700_$_20 : MaskType;
var exhaleMask#_700_$_18 : MaskType;
var exhaleMask#_700_$_16 : MaskType;
var exhaleMask#_700_$_14 : MaskType;
var exhaleMask#_700_$_12 : MaskType;
var exhaleMask#_700_$_10 : MaskType;
var exhaleMask#_700_$_8 : MaskType;
var exhaleMask#_700_$_6 : MaskType;
var Mask_$_143 : MaskType;
var Mask_$_141 : MaskType;
var Mask_$_139 : MaskType;
var Mask_$_137 : MaskType;
var Mask_$_135 : MaskType;
var Mask_$_133 : MaskType;
var Mask_$_131 : MaskType;
var Mask_$_129 : MaskType;
var oldVers#_692_$_0 : int;
var Heap_$_5 : HeapType;
var newVers#_693_$_0 : int;
var Mask_$_103 : MaskType;
var Mask_$_101 : MaskType;
var Mask_$_99 : MaskType;
var Mask_$_97 : MaskType;
var methodCallK#_650 : int;
var this#250_$_0 : ref;
var exhaleMask#_652_$_0 : MaskType;
var exhaleMask#_652_$_1 : MaskType;
var exhaleMask#_652_$_2 : MaskType;
var exhaleMask#_652_$_3 : MaskType;
var exhaleHeap#_651_$_0 : HeapType;
var r#251_$_0 : ref;
var m#252_$_0 : ref;
var Mask_$_110 : MaskType;
var Mask_$_112 : MaskType;
var Mask_$_114 : MaskType;
var Mask_$_116 : MaskType;
var Mask_$_117 : MaskType;
var Mask_$_118 : MaskType;
var Mask_$_119 : MaskType;
var Mask_$_120 : MaskType;
var Mask_$_115 : MaskType;
var Mask_$_113 : MaskType;
var Mask_$_111 : MaskType;
var Mask_$_109 : MaskType;
var Mask_$_95 : MaskType;
var Mask_$_93 : MaskType;
var Mask_$_90 : MaskType;
var Mask_$_88 : MaskType;
var exhaleMask#_636_$_8 : MaskType;
var exhaleMask#_636_$_6 : MaskType;
var exhaleMask#_636_$_4 : MaskType;
var exhaleMask#_636_$_1 : MaskType;
var assertSecMask#_533_$_22 : MaskType;
var exhaleHeap#_535_$_0 : HeapType;
var assertSecMask#_582_$_22 : MaskType;
var exhaleHeap#_584_$_0 : HeapType;
var cond#_629_$_0 : bool;
var r#20_$_2 : ref;
var r#20_$_1 : ref;
var unfoldingK#_591 : int;
var unfoldingMask#_587_$_0 : MaskType;
var unfoldingHeap#_586_$_1 : HeapType;
var unfoldingMask#_587_$_1 : MaskType;
var unfoldingMask#_587_$_2 : MaskType;
var unfoldingMask#_587_$_3 : MaskType;
var unfoldingMask#_587_$_4 : MaskType;
var unfoldingMask#_587_$_5 : MaskType;
var unfoldingMask#_587_$_6 : MaskType;
var unfoldingMask#_587_$_8 : MaskType;
var unfoldingMask#_587_$_10 : MaskType;
var unfoldingMask#_587_$_12 : MaskType;
var unfoldingMask#_587_$_14 : MaskType;
var unfoldingMask#_587_$_16 : MaskType;
var unfoldingMask#_587_$_18 : MaskType;
var unfoldingMask#_587_$_20 : MaskType;
var unfoldingMask#_587_$_22 : MaskType;
var assertSecMask#_582_$_0 : MaskType;
var assertSecMask#_582_$_1 : MaskType;
var assertSecMask#_582_$_2 : MaskType;
var assertSecMask#_582_$_3 : MaskType;
var assertSecMask#_582_$_4 : MaskType;
var assertSecMask#_582_$_5 : MaskType;
var assertSecMask#_582_$_7 : MaskType;
var assertSecMask#_582_$_9 : MaskType;
var assertSecMask#_582_$_11 : MaskType;
var assertSecMask#_582_$_13 : MaskType;
var assertSecMask#_582_$_15 : MaskType;
var assertSecMask#_582_$_17 : MaskType;
var assertSecMask#_582_$_19 : MaskType;
var assertSecMask#_582_$_21 : MaskType;
var assertSecMask#_582_$_20 : MaskType;
var assertSecMask#_582_$_18 : MaskType;
var assertSecMask#_582_$_16 : MaskType;
var assertSecMask#_582_$_14 : MaskType;
var assertSecMask#_582_$_12 : MaskType;
var assertSecMask#_582_$_10 : MaskType;
var assertSecMask#_582_$_8 : MaskType;
var assertSecMask#_582_$_6 : MaskType;
var unfoldingMask#_587_$_21 : MaskType;
var unfoldingMask#_587_$_19 : MaskType;
var unfoldingMask#_587_$_17 : MaskType;
var unfoldingMask#_587_$_15 : MaskType;
var unfoldingMask#_587_$_13 : MaskType;
var unfoldingMask#_587_$_11 : MaskType;
var unfoldingMask#_587_$_9 : MaskType;
var unfoldingMask#_587_$_7 : MaskType;
var oldVers#_611_$_0 : int;
var unfoldingHeap#_586_$_0 : HeapType;
var newVers#_612_$_0 : int;
var unfoldingK#_542 : int;
var unfoldingMask#_538_$_0 : MaskType;
var unfoldingHeap#_537_$_1 : HeapType;
var unfoldingMask#_538_$_1 : MaskType;
var unfoldingMask#_538_$_2 : MaskType;
var unfoldingMask#_538_$_3 : MaskType;
var unfoldingMask#_538_$_4 : MaskType;
var unfoldingMask#_538_$_5 : MaskType;
var unfoldingMask#_538_$_6 : MaskType;
var unfoldingMask#_538_$_8 : MaskType;
var unfoldingMask#_538_$_10 : MaskType;
var unfoldingMask#_538_$_12 : MaskType;
var unfoldingMask#_538_$_14 : MaskType;
var unfoldingMask#_538_$_16 : MaskType;
var unfoldingMask#_538_$_18 : MaskType;
var unfoldingMask#_538_$_20 : MaskType;
var unfoldingMask#_538_$_22 : MaskType;
var assertSecMask#_533_$_0 : MaskType;
var assertSecMask#_533_$_1 : MaskType;
var assertSecMask#_533_$_2 : MaskType;
var assertSecMask#_533_$_3 : MaskType;
var assertSecMask#_533_$_4 : MaskType;
var assertSecMask#_533_$_5 : MaskType;
var assertSecMask#_533_$_7 : MaskType;
var assertSecMask#_533_$_9 : MaskType;
var assertSecMask#_533_$_11 : MaskType;
var assertSecMask#_533_$_13 : MaskType;
var assertSecMask#_533_$_15 : MaskType;
var assertSecMask#_533_$_17 : MaskType;
var assertSecMask#_533_$_19 : MaskType;
var assertSecMask#_533_$_21 : MaskType;
var assertSecMask#_533_$_20 : MaskType;
var assertSecMask#_533_$_18 : MaskType;
var assertSecMask#_533_$_16 : MaskType;
var assertSecMask#_533_$_14 : MaskType;
var assertSecMask#_533_$_12 : MaskType;
var assertSecMask#_533_$_10 : MaskType;
var assertSecMask#_533_$_8 : MaskType;
var assertSecMask#_533_$_6 : MaskType;
var unfoldingMask#_538_$_21 : MaskType;
var unfoldingMask#_538_$_19 : MaskType;
var unfoldingMask#_538_$_17 : MaskType;
var unfoldingMask#_538_$_15 : MaskType;
var unfoldingMask#_538_$_13 : MaskType;
var unfoldingMask#_538_$_11 : MaskType;
var unfoldingMask#_538_$_9 : MaskType;
var unfoldingMask#_538_$_7 : MaskType;
var oldVers#_562_$_0 : int;
var unfoldingHeap#_537_$_0 : HeapType;
var newVers#_563_$_0 : int;
var Mask_$_25 : MaskType;
var Mask_$_23 : MaskType;
var Mask_$_21 : MaskType;
var Mask_$_19 : MaskType;
var Mask_$_17 : MaskType;
var Mask_$_15 : MaskType;
var Mask_$_13 : MaskType;
var Mask_$_11 : MaskType;
var oldVers#_527_$_0 : int;
var Heap_$_0 : HeapType;
var newVers#_528_$_0 : int;
var oldVers#_527 : int;
var newVers#_528 : int;
var cond#_529 : bool;
var cond#_530 : bool;
var assertHeap#_531 : HeapType;
var assertMask#_532 : MaskType;
var assertSecMask#_533 : MaskType;
var assertCredits#_534 : CreditsType;
var exhaleMask#_536 : MaskType;
var exhaleHeap#_535 : HeapType;
var predFlag#_541 : bool;
var unfoldingHeap#_537 : HeapType;
var unfoldingMask#_538 : MaskType;
var unfoldingSecMask#_539 : MaskType;
var unfoldingCredits#_540 : CreditsType;
var oldVers#_562 : int;
var newVers#_563 : int;
var assertHeap#_580 : HeapType;
var assertMask#_581 : MaskType;
var assertSecMask#_582 : MaskType;
var assertCredits#_583 : CreditsType;
var exhaleMask#_585 : MaskType;
var exhaleHeap#_584 : HeapType;
var predFlag#_590 : bool;
var unfoldingHeap#_586 : HeapType;
var unfoldingMask#_587 : MaskType;
var unfoldingSecMask#_588 : MaskType;
var unfoldingCredits#_589 : CreditsType;
var oldVers#_611 : int;
var newVers#_612 : int;
var cond#_629 : bool;
var bf#22 : int;
var bf#249 : int;
var callHeap#_630 : HeapType;
var callMask#_631 : MaskType;
var callSecMask#_632 : MaskType;
var callCredits#_633 : CreditsType;
var exhaleMask#_636 : MaskType;
var exhaleHeap#_635 : HeapType;
var cond#_645 : bool;
var callHeap#_646 : HeapType;
var callMask#_647 : MaskType;
var callSecMask#_648 : MaskType;
var callCredits#_649 : CreditsType;
var exhaleMask#_652 : MaskType;
var exhaleHeap#_651 : HeapType;
var callHeap#_659 : HeapType;
var callMask#_660 : MaskType;
var callSecMask#_661 : MaskType;
var callCredits#_662 : CreditsType;
var exhaleMask#_665 : MaskType;
var exhaleHeap#_664 : HeapType;
var oldVers#_692 : int;
var newVers#_693 : int;
var callHeap#_694 : HeapType;
var callMask#_695 : MaskType;
var callSecMask#_696 : MaskType;
var callCredits#_697 : CreditsType;
var exhaleMask#_700 : MaskType;
var exhaleHeap#_699 : HeapType;
var cond#_717 : bool;
var cond#_718 : bool;
var k#270 : int;
var callHeap#_719 : HeapType;
var callMask#_720 : MaskType;
var callSecMask#_721 : MaskType;
var callCredits#_722 : CreditsType;
var exhaleMask#_725 : MaskType;
var exhaleHeap#_724 : HeapType;
var bf#30 : int;
var bf#275 : int;
var callHeap#_732 : HeapType;
var callMask#_733 : MaskType;
var callSecMask#_734 : MaskType;
var callCredits#_735 : CreditsType;
var exhaleMask#_738 : MaskType;
var exhaleHeap#_737 : HeapType;
var cond#_747 : bool;
var callHeap#_748 : HeapType;
var callMask#_749 : MaskType;
var callSecMask#_750 : MaskType;
var callCredits#_751 : CreditsType;
var exhaleMask#_754 : MaskType;
var exhaleHeap#_753 : HeapType;
var callHeap#_771 : HeapType;
var callMask#_772 : MaskType;
var callSecMask#_773 : MaskType;
var callCredits#_774 : CreditsType;
var exhaleMask#_777 : MaskType;
var exhaleHeap#_776 : HeapType;
var callHeap#_794 : HeapType;
var callMask#_795 : MaskType;
var callSecMask#_796 : MaskType;
var callCredits#_797 : CreditsType;
var exhaleMask#_800 : MaskType;
var exhaleHeap#_799 : HeapType;
var cond#_817 : bool;
var k#293 : int;
var callHeap#_818 : HeapType;
var callMask#_819 : MaskType;
var callSecMask#_820 : MaskType;
var callCredits#_821 : CreditsType;
var exhaleMask#_824 : MaskType;
var exhaleHeap#_823 : HeapType;
var bf#34 : int;
var bf#298 : int;
var callHeap#_831 : HeapType;
var callMask#_832 : MaskType;
var callSecMask#_833 : MaskType;
var callCredits#_834 : CreditsType;
var exhaleMask#_837 : MaskType;
var exhaleHeap#_836 : HeapType;
var cond#_846 : bool;
var callHeap#_847 : HeapType;
var callMask#_848 : MaskType;
var callSecMask#_849 : MaskType;
var callCredits#_850 : CreditsType;
var exhaleMask#_853 : MaskType;
var exhaleHeap#_852 : HeapType;
var callHeap#_870 : HeapType;
var callMask#_871 : MaskType;
var callSecMask#_872 : MaskType;
var callCredits#_873 : CreditsType;
var exhaleMask#_876 : MaskType;
var exhaleHeap#_875 : HeapType;
var callHeap#_893 : HeapType;
var callMask#_894 : MaskType;
var callSecMask#_895 : MaskType;
var callCredits#_896 : CreditsType;
var exhaleMask#_899 : MaskType;
var exhaleHeap#_898 : HeapType;
var exhaleMask#_917 : MaskType;
var exhaleHeap#_916 : HeapType;
procedure AVLTreeNode.remove (this : ref,k#19 : int) returns (r#20 : ref)
{
	var methodK#_506 : int;
	var unfoldK#_507 : int;
	var oldVers#_527 : int;
	var newVers#_528 : int;
	var cond#_529 : bool;
	var cond#_530 : bool;
	var assertHeap#_531 : HeapType;
	var assertMask#_532 : MaskType;
	var assertSecMask#_533 : MaskType;
	var assertCredits#_534 : CreditsType;
	var exhaleMask#_536 : MaskType;
	var exhaleHeap#_535 : HeapType;
	var unfoldingK#_542 : int;
	var predFlag#_541 : bool;
	var unfoldingHeap#_537 : HeapType;
	var unfoldingMask#_538 : MaskType;
	var unfoldingSecMask#_539 : MaskType;
	var unfoldingCredits#_540 : CreditsType;
	var oldVers#_562 : int;
	var newVers#_563 : int;
	var assertHeap#_580 : HeapType;
	var assertMask#_581 : MaskType;
	var assertSecMask#_582 : MaskType;
	var assertCredits#_583 : CreditsType;
	var exhaleMask#_585 : MaskType;
	var exhaleHeap#_584 : HeapType;
	var unfoldingK#_591 : int;
	var predFlag#_590 : bool;
	var unfoldingHeap#_586 : HeapType;
	var unfoldingMask#_587 : MaskType;
	var unfoldingSecMask#_588 : MaskType;
	var unfoldingCredits#_589 : CreditsType;
	var oldVers#_611 : int;
	var newVers#_612 : int;
	var cond#_629 : bool;
	var bf#22 : int;
	var nl#24 : ref;
	var nr#26 : ref;
	var methodCallK#_634 : int;
	var this#248 : ref;
	var bf#249 : int;
	var callHeap#_630 : HeapType;
	var callMask#_631 : MaskType;
	var callSecMask#_632 : MaskType;
	var callCredits#_633 : CreditsType;
	var exhaleMask#_636 : MaskType;
	var exhaleHeap#_635 : HeapType;
	var cond#_645 : bool;
	var methodCallK#_650 : int;
	var this#250 : ref;
	var r#251 : ref;
	var m#252 : ref;
	var callHeap#_646 : HeapType;
	var callMask#_647 : MaskType;
	var callSecMask#_648 : MaskType;
	var callCredits#_649 : CreditsType;
	var exhaleMask#_652 : MaskType;
	var exhaleHeap#_651 : HeapType;
	var methodCallK#_663 : int;
	var this#254 : ref;
	var r#255 : ref;
	var m#256 : ref;
	var callHeap#_659 : HeapType;
	var callMask#_660 : MaskType;
	var callSecMask#_661 : MaskType;
	var callCredits#_662 : CreditsType;
	var exhaleMask#_665 : MaskType;
	var exhaleHeap#_664 : HeapType;
	var unfoldK#_672 : int;
	var oldVers#_692 : int;
	var newVers#_693 : int;
	var methodCallK#_698 : int;
	var this#264 : ref;
	var callHeap#_694 : HeapType;
	var callMask#_695 : MaskType;
	var callSecMask#_696 : MaskType;
	var callCredits#_697 : CreditsType;
	var exhaleMask#_700 : MaskType;
	var exhaleHeap#_699 : HeapType;
	var cond#_717 : bool;
	var cond#_718 : bool;
	var nl#28 : ref;
	var methodCallK#_723 : int;
	var this#269 : ref;
	var k#270 : int;
	var r#271 : ref;
	var callHeap#_719 : HeapType;
	var callMask#_720 : MaskType;
	var callSecMask#_721 : MaskType;
	var callCredits#_722 : CreditsType;
	var exhaleMask#_725 : MaskType;
	var exhaleHeap#_724 : HeapType;
	var bf#30 : int;
	var methodCallK#_736 : int;
	var this#274 : ref;
	var bf#275 : int;
	var callHeap#_732 : HeapType;
	var callMask#_733 : MaskType;
	var callSecMask#_734 : MaskType;
	var callCredits#_735 : CreditsType;
	var exhaleMask#_738 : MaskType;
	var exhaleHeap#_737 : HeapType;
	var cond#_747 : bool;
	var methodCallK#_752 : int;
	var this#276 : ref;
	var r#277 : ref;
	var callHeap#_748 : HeapType;
	var callMask#_749 : MaskType;
	var callSecMask#_750 : MaskType;
	var callCredits#_751 : CreditsType;
	var exhaleMask#_754 : MaskType;
	var exhaleHeap#_753 : HeapType;
	var methodCallK#_775 : int;
	var this#282 : ref;
	var callHeap#_771 : HeapType;
	var callMask#_772 : MaskType;
	var callSecMask#_773 : MaskType;
	var callCredits#_774 : CreditsType;
	var exhaleMask#_777 : MaskType;
	var exhaleHeap#_776 : HeapType;
	var methodCallK#_798 : int;
	var this#287 : ref;
	var callHeap#_794 : HeapType;
	var callMask#_795 : MaskType;
	var callSecMask#_796 : MaskType;
	var callCredits#_797 : CreditsType;
	var exhaleMask#_800 : MaskType;
	var exhaleHeap#_799 : HeapType;
	var cond#_817 : bool;
	var nr#32 : ref;
	var methodCallK#_822 : int;
	var this#292 : ref;
	var k#293 : int;
	var r#294 : ref;
	var callHeap#_818 : HeapType;
	var callMask#_819 : MaskType;
	var callSecMask#_820 : MaskType;
	var callCredits#_821 : CreditsType;
	var exhaleMask#_824 : MaskType;
	var exhaleHeap#_823 : HeapType;
	var bf#34 : int;
	var methodCallK#_835 : int;
	var this#297 : ref;
	var bf#298 : int;
	var callHeap#_831 : HeapType;
	var callMask#_832 : MaskType;
	var callSecMask#_833 : MaskType;
	var callCredits#_834 : CreditsType;
	var exhaleMask#_837 : MaskType;
	var exhaleHeap#_836 : HeapType;
	var cond#_846 : bool;
	var methodCallK#_851 : int;
	var this#299 : ref;
	var r#300 : ref;
	var callHeap#_847 : HeapType;
	var callMask#_848 : MaskType;
	var callSecMask#_849 : MaskType;
	var callCredits#_850 : CreditsType;
	var exhaleMask#_853 : MaskType;
	var exhaleHeap#_852 : HeapType;
	var methodCallK#_874 : int;
	var this#305 : ref;
	var callHeap#_870 : HeapType;
	var callMask#_871 : MaskType;
	var callSecMask#_872 : MaskType;
	var callCredits#_873 : CreditsType;
	var exhaleMask#_876 : MaskType;
	var exhaleHeap#_875 : HeapType;
	var methodCallK#_897 : int;
	var this#310 : ref;
	var callHeap#_893 : HeapType;
	var callMask#_894 : MaskType;
	var callSecMask#_895 : MaskType;
	var callCredits#_896 : CreditsType;
	var exhaleMask#_899 : MaskType;
	var exhaleHeap#_898 : HeapType;
	var exhaleMask#_917 : MaskType;
	var exhaleHeap#_916 : HeapType;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var Mask_$_3 : MaskType;
	var Mask_$_4 : MaskType;
	var oldVers#_527_$_0 : int;
	var newVers#_528_$_0 : int;
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
	var cond#_529_$_0 : bool;
	var cond#_530_$_0 : bool;
	var cond#_717_$_0 : bool;
	var cond#_718_$_0 : bool;
	var cond#_817_$_0 : bool;
	var this#292_$_0 : ref;
	var exhaleHeap#_823_$_0 : HeapType;
	var exhaleMask#_824_$_0 : MaskType;
	var exhaleHeap#_898_$_0 : HeapType;
	var exhaleMask#_899_$_0 : MaskType;
	var exhaleMask#_899_$_1 : MaskType;
	var exhaleMask#_899_$_2 : MaskType;
	var exhaleMask#_899_$_3 : MaskType;
	var exhaleMask#_899_$_4 : MaskType;
	var exhaleMask#_899_$_5 : MaskType;
	var exhaleMask#_899_$_6 : MaskType;
	var exhaleMask#_899_$_7 : MaskType;
	var exhaleMask#_899_$_8 : MaskType;
	var exhaleMask#_899_$_9 : MaskType;
	var exhaleMask#_899_$_10 : MaskType;
	var exhaleMask#_899_$_11 : MaskType;
	var exhaleMask#_899_$_12 : MaskType;
	var exhaleMask#_899_$_13 : MaskType;
	var exhaleMask#_899_$_14 : MaskType;
	var exhaleMask#_899_$_15 : MaskType;
	var exhaleMask#_899_$_16 : MaskType;
	var exhaleMask#_899_$_17 : MaskType;
	var exhaleMask#_899_$_18 : MaskType;
	var exhaleMask#_899_$_19 : MaskType;
	var exhaleMask#_899_$_20 : MaskType;
	var exhaleMask#_899_$_21 : MaskType;
	var Mask_$_27 : MaskType;
	var Mask_$_28 : MaskType;
	var Mask_$_29 : MaskType;
	var Mask_$_30 : MaskType;
	var exhaleMask#_824_$_1 : MaskType;
	var exhaleMask#_824_$_2 : MaskType;
	var exhaleMask#_824_$_3 : MaskType;
	var r#294_$_0 : ref;
	var Mask_$_31 : MaskType;
	var Mask_$_32 : MaskType;
	var Mask_$_33 : MaskType;
	var Mask_$_34 : MaskType;
	var Mask_$_35 : MaskType;
	var Mask_$_36 : MaskType;
	var Mask_$_37 : MaskType;
	var Mask_$_38 : MaskType;
	var Heap_$_2 : HeapType;
	var exhaleHeap#_836_$_0 : HeapType;
	var exhaleMask#_837_$_0 : MaskType;
	var exhaleMask#_837_$_1 : MaskType;
	var exhaleMask#_837_$_2 : MaskType;
	var exhaleMask#_837_$_3 : MaskType;
	var exhaleMask#_837_$_4 : MaskType;
	var exhaleMask#_837_$_5 : MaskType;
	var exhaleMask#_837_$_6 : MaskType;
	var exhaleMask#_837_$_7 : MaskType;
	var exhaleMask#_837_$_8 : MaskType;
	var exhaleMask#_837_$_9 : MaskType;
	var bf#298_$_0 : int;
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
	var cond#_846_$_0 : bool;
	var exhaleHeap#_852_$_0 : HeapType;
	var exhaleHeap#_875_$_0 : HeapType;
	var exhaleMask#_876_$_0 : MaskType;
	var exhaleMask#_876_$_1 : MaskType;
	var exhaleMask#_876_$_2 : MaskType;
	var exhaleMask#_876_$_3 : MaskType;
	var exhaleMask#_876_$_4 : MaskType;
	var exhaleMask#_876_$_5 : MaskType;
	var exhaleMask#_876_$_6 : MaskType;
	var exhaleMask#_876_$_7 : MaskType;
	var exhaleMask#_876_$_8 : MaskType;
	var exhaleMask#_876_$_9 : MaskType;
	var exhaleMask#_876_$_10 : MaskType;
	var exhaleMask#_876_$_11 : MaskType;
	var exhaleMask#_876_$_12 : MaskType;
	var exhaleMask#_876_$_13 : MaskType;
	var exhaleMask#_876_$_14 : MaskType;
	var exhaleMask#_876_$_15 : MaskType;
	var exhaleMask#_876_$_16 : MaskType;
	var exhaleMask#_876_$_17 : MaskType;
	var exhaleMask#_876_$_18 : MaskType;
	var exhaleMask#_876_$_19 : MaskType;
	var exhaleMask#_876_$_20 : MaskType;
	var exhaleMask#_876_$_21 : MaskType;
	var Mask_$_49 : MaskType;
	var Mask_$_50 : MaskType;
	var Mask_$_51 : MaskType;
	var Mask_$_52 : MaskType;
	var exhaleMask#_853_$_0 : MaskType;
	var exhaleMask#_853_$_1 : MaskType;
	var exhaleMask#_853_$_2 : MaskType;
	var exhaleMask#_853_$_3 : MaskType;
	var exhaleMask#_853_$_4 : MaskType;
	var exhaleMask#_853_$_5 : MaskType;
	var exhaleMask#_853_$_6 : MaskType;
	var exhaleMask#_853_$_7 : MaskType;
	var exhaleMask#_853_$_8 : MaskType;
	var exhaleMask#_853_$_9 : MaskType;
	var exhaleMask#_853_$_10 : MaskType;
	var exhaleMask#_853_$_11 : MaskType;
	var exhaleMask#_853_$_12 : MaskType;
	var exhaleMask#_853_$_13 : MaskType;
	var exhaleMask#_853_$_14 : MaskType;
	var exhaleMask#_853_$_15 : MaskType;
	var exhaleMask#_853_$_16 : MaskType;
	var exhaleMask#_853_$_17 : MaskType;
	var r#300_$_0 : ref;
	var Mask_$_53 : MaskType;
	var Mask_$_54 : MaskType;
	var Mask_$_55 : MaskType;
	var Mask_$_56 : MaskType;
	var this#269_$_0 : ref;
	var exhaleHeap#_724_$_0 : HeapType;
	var exhaleMask#_725_$_0 : MaskType;
	var exhaleHeap#_799_$_0 : HeapType;
	var exhaleMask#_800_$_0 : MaskType;
	var exhaleMask#_800_$_1 : MaskType;
	var exhaleMask#_800_$_2 : MaskType;
	var exhaleMask#_800_$_3 : MaskType;
	var exhaleMask#_800_$_4 : MaskType;
	var exhaleMask#_800_$_5 : MaskType;
	var exhaleMask#_800_$_6 : MaskType;
	var exhaleMask#_800_$_7 : MaskType;
	var exhaleMask#_800_$_8 : MaskType;
	var exhaleMask#_800_$_9 : MaskType;
	var exhaleMask#_800_$_10 : MaskType;
	var exhaleMask#_800_$_11 : MaskType;
	var exhaleMask#_800_$_12 : MaskType;
	var exhaleMask#_800_$_13 : MaskType;
	var exhaleMask#_800_$_14 : MaskType;
	var exhaleMask#_800_$_15 : MaskType;
	var exhaleMask#_800_$_16 : MaskType;
	var exhaleMask#_800_$_17 : MaskType;
	var exhaleMask#_800_$_18 : MaskType;
	var exhaleMask#_800_$_19 : MaskType;
	var exhaleMask#_800_$_20 : MaskType;
	var exhaleMask#_800_$_21 : MaskType;
	var Mask_$_57 : MaskType;
	var Mask_$_58 : MaskType;
	var Mask_$_59 : MaskType;
	var Mask_$_60 : MaskType;
	var exhaleMask#_725_$_1 : MaskType;
	var exhaleMask#_725_$_2 : MaskType;
	var exhaleMask#_725_$_3 : MaskType;
	var r#271_$_0 : ref;
	var Mask_$_61 : MaskType;
	var Mask_$_62 : MaskType;
	var Mask_$_63 : MaskType;
	var Mask_$_64 : MaskType;
	var Mask_$_65 : MaskType;
	var Mask_$_66 : MaskType;
	var Mask_$_67 : MaskType;
	var Mask_$_68 : MaskType;
	var Heap_$_3 : HeapType;
	var exhaleHeap#_737_$_0 : HeapType;
	var exhaleMask#_738_$_0 : MaskType;
	var exhaleMask#_738_$_1 : MaskType;
	var exhaleMask#_738_$_2 : MaskType;
	var exhaleMask#_738_$_3 : MaskType;
	var exhaleMask#_738_$_4 : MaskType;
	var exhaleMask#_738_$_5 : MaskType;
	var exhaleMask#_738_$_6 : MaskType;
	var exhaleMask#_738_$_7 : MaskType;
	var exhaleMask#_738_$_8 : MaskType;
	var exhaleMask#_738_$_9 : MaskType;
	var bf#275_$_0 : int;
	var Mask_$_69 : MaskType;
	var Mask_$_70 : MaskType;
	var Mask_$_71 : MaskType;
	var Mask_$_72 : MaskType;
	var Mask_$_73 : MaskType;
	var Mask_$_74 : MaskType;
	var Mask_$_75 : MaskType;
	var Mask_$_76 : MaskType;
	var Mask_$_77 : MaskType;
	var Mask_$_78 : MaskType;
	var cond#_747_$_0 : bool;
	var exhaleHeap#_753_$_0 : HeapType;
	var exhaleHeap#_776_$_0 : HeapType;
	var exhaleMask#_777_$_0 : MaskType;
	var exhaleMask#_777_$_1 : MaskType;
	var exhaleMask#_777_$_2 : MaskType;
	var exhaleMask#_777_$_3 : MaskType;
	var exhaleMask#_777_$_4 : MaskType;
	var exhaleMask#_777_$_5 : MaskType;
	var exhaleMask#_777_$_6 : MaskType;
	var exhaleMask#_777_$_7 : MaskType;
	var exhaleMask#_777_$_8 : MaskType;
	var exhaleMask#_777_$_9 : MaskType;
	var exhaleMask#_777_$_10 : MaskType;
	var exhaleMask#_777_$_11 : MaskType;
	var exhaleMask#_777_$_12 : MaskType;
	var exhaleMask#_777_$_13 : MaskType;
	var exhaleMask#_777_$_14 : MaskType;
	var exhaleMask#_777_$_15 : MaskType;
	var exhaleMask#_777_$_16 : MaskType;
	var exhaleMask#_777_$_17 : MaskType;
	var exhaleMask#_777_$_18 : MaskType;
	var exhaleMask#_777_$_19 : MaskType;
	var exhaleMask#_777_$_20 : MaskType;
	var exhaleMask#_777_$_21 : MaskType;
	var Mask_$_79 : MaskType;
	var Mask_$_80 : MaskType;
	var Mask_$_81 : MaskType;
	var Mask_$_82 : MaskType;
	var exhaleMask#_754_$_0 : MaskType;
	var exhaleMask#_754_$_1 : MaskType;
	var exhaleMask#_754_$_2 : MaskType;
	var exhaleMask#_754_$_3 : MaskType;
	var exhaleMask#_754_$_4 : MaskType;
	var exhaleMask#_754_$_5 : MaskType;
	var exhaleMask#_754_$_6 : MaskType;
	var exhaleMask#_754_$_7 : MaskType;
	var exhaleMask#_754_$_8 : MaskType;
	var exhaleMask#_754_$_9 : MaskType;
	var exhaleMask#_754_$_10 : MaskType;
	var exhaleMask#_754_$_11 : MaskType;
	var exhaleMask#_754_$_12 : MaskType;
	var exhaleMask#_754_$_13 : MaskType;
	var exhaleMask#_754_$_14 : MaskType;
	var exhaleMask#_754_$_15 : MaskType;
	var exhaleMask#_754_$_16 : MaskType;
	var exhaleMask#_754_$_17 : MaskType;
	var r#277_$_0 : ref;
	var Mask_$_83 : MaskType;
	var Mask_$_84 : MaskType;
	var Mask_$_85 : MaskType;
	var Mask_$_86 : MaskType;
	var exhaleHeap#_535_$_0 : HeapType;
	var nl#24_$_0 : ref;
	var nr#26_$_0 : ref;
	var exhaleHeap#_635_$_0 : HeapType;
	var exhaleMask#_636_$_0 : MaskType;
	var exhaleMask#_636_$_1 : MaskType;
	var exhaleMask#_636_$_2 : MaskType;
	var exhaleMask#_636_$_3 : MaskType;
	var exhaleMask#_636_$_4 : MaskType;
	var exhaleMask#_636_$_5 : MaskType;
	var exhaleMask#_636_$_6 : MaskType;
	var exhaleMask#_636_$_7 : MaskType;
	var exhaleMask#_636_$_8 : MaskType;
	var exhaleMask#_636_$_9 : MaskType;
	var bf#249_$_0 : int;
	var Mask_$_87 : MaskType;
	var Mask_$_88 : MaskType;
	var Mask_$_89 : MaskType;
	var Mask_$_90 : MaskType;
	var Mask_$_91 : MaskType;
	var Mask_$_92 : MaskType;
	var Mask_$_93 : MaskType;
	var Mask_$_94 : MaskType;
	var Mask_$_95 : MaskType;
	var Mask_$_96 : MaskType;
	var cond#_645_$_0 : bool;
	var this#250_$_0 : ref;
	var exhaleHeap#_651_$_0 : HeapType;
	var exhaleMask#_652_$_0 : MaskType;
	var this#254_$_0 : ref;
	var exhaleHeap#_664_$_0 : HeapType;
	var exhaleMask#_665_$_0 : MaskType;
	var exhaleMask#_665_$_1 : MaskType;
	var exhaleMask#_665_$_2 : MaskType;
	var exhaleMask#_665_$_3 : MaskType;
	var r#255_$_0 : ref;
	var m#256_$_0 : ref;
	var Mask_$_97 : MaskType;
	var Mask_$_98 : MaskType;
	var Mask_$_99 : MaskType;
	var Mask_$_100 : MaskType;
	var Mask_$_101 : MaskType;
	var Mask_$_102 : MaskType;
	var Mask_$_103 : MaskType;
	var Mask_$_104 : MaskType;
	var Mask_$_105 : MaskType;
	var Mask_$_106 : MaskType;
	var Mask_$_107 : MaskType;
	var Mask_$_108 : MaskType;
	var exhaleMask#_652_$_1 : MaskType;
	var exhaleMask#_652_$_2 : MaskType;
	var exhaleMask#_652_$_3 : MaskType;
	var r#251_$_0 : ref;
	var m#252_$_0 : ref;
	var Mask_$_109 : MaskType;
	var Mask_$_110 : MaskType;
	var Mask_$_111 : MaskType;
	var Mask_$_112 : MaskType;
	var Mask_$_113 : MaskType;
	var Mask_$_114 : MaskType;
	var Mask_$_115 : MaskType;
	var Mask_$_116 : MaskType;
	var Mask_$_117 : MaskType;
	var Mask_$_118 : MaskType;
	var Mask_$_119 : MaskType;
	var Mask_$_120 : MaskType;
	var Mask_$_121 : MaskType;
	var Heap_$_4 : HeapType;
	var nl#24_$_1 : ref;
	var nr#26_$_1 : ref;
	var r#20_$_0 : ref;
	var Mask_$_122 : MaskType;
	var oldVers#_692_$_0 : int;
	var newVers#_693_$_0 : int;
	var Heap_$_5 : HeapType;
	var Heap_$_6 : HeapType;
	var Mask_$_123 : MaskType;
	var Mask_$_124 : MaskType;
	var Mask_$_125 : MaskType;
	var Mask_$_126 : MaskType;
	var Mask_$_127 : MaskType;
	var Mask_$_128 : MaskType;
	var Mask_$_129 : MaskType;
	var Mask_$_130 : MaskType;
	var Mask_$_131 : MaskType;
	var Mask_$_132 : MaskType;
	var Mask_$_133 : MaskType;
	var Mask_$_134 : MaskType;
	var Mask_$_135 : MaskType;
	var Mask_$_136 : MaskType;
	var Mask_$_137 : MaskType;
	var Mask_$_138 : MaskType;
	var Mask_$_139 : MaskType;
	var Mask_$_140 : MaskType;
	var Mask_$_141 : MaskType;
	var Mask_$_142 : MaskType;
	var Mask_$_143 : MaskType;
	var Mask_$_144 : MaskType;
	var Heap_$_7 : HeapType;
	var Heap_$_8 : HeapType;
	var exhaleHeap#_699_$_0 : HeapType;
	var exhaleMask#_700_$_0 : MaskType;
	var exhaleMask#_700_$_1 : MaskType;
	var exhaleMask#_700_$_2 : MaskType;
	var exhaleMask#_700_$_3 : MaskType;
	var exhaleMask#_700_$_4 : MaskType;
	var exhaleMask#_700_$_5 : MaskType;
	var exhaleMask#_700_$_6 : MaskType;
	var exhaleMask#_700_$_7 : MaskType;
	var exhaleMask#_700_$_8 : MaskType;
	var exhaleMask#_700_$_9 : MaskType;
	var exhaleMask#_700_$_10 : MaskType;
	var exhaleMask#_700_$_11 : MaskType;
	var exhaleMask#_700_$_12 : MaskType;
	var exhaleMask#_700_$_13 : MaskType;
	var exhaleMask#_700_$_14 : MaskType;
	var exhaleMask#_700_$_15 : MaskType;
	var exhaleMask#_700_$_16 : MaskType;
	var exhaleMask#_700_$_17 : MaskType;
	var exhaleMask#_700_$_18 : MaskType;
	var exhaleMask#_700_$_19 : MaskType;
	var exhaleMask#_700_$_20 : MaskType;
	var exhaleMask#_700_$_21 : MaskType;
	var Mask_$_145 : MaskType;
	var Mask_$_146 : MaskType;
	var Mask_$_147 : MaskType;
	var Mask_$_148 : MaskType;
	var unfoldingMask#_538_$_0 : MaskType;
	var oldVers#_562_$_0 : int;
	var newVers#_563_$_0 : int;
	var unfoldingHeap#_537_$_0 : HeapType;
	var unfoldingHeap#_537_$_1 : HeapType;
	var unfoldingMask#_538_$_1 : MaskType;
	var unfoldingMask#_538_$_2 : MaskType;
	var unfoldingMask#_538_$_3 : MaskType;
	var unfoldingMask#_538_$_4 : MaskType;
	var unfoldingMask#_538_$_5 : MaskType;
	var unfoldingMask#_538_$_6 : MaskType;
	var unfoldingMask#_538_$_7 : MaskType;
	var unfoldingMask#_538_$_8 : MaskType;
	var unfoldingMask#_538_$_9 : MaskType;
	var unfoldingMask#_538_$_10 : MaskType;
	var unfoldingMask#_538_$_11 : MaskType;
	var unfoldingMask#_538_$_12 : MaskType;
	var unfoldingMask#_538_$_13 : MaskType;
	var unfoldingMask#_538_$_14 : MaskType;
	var unfoldingMask#_538_$_15 : MaskType;
	var unfoldingMask#_538_$_16 : MaskType;
	var unfoldingMask#_538_$_17 : MaskType;
	var unfoldingMask#_538_$_18 : MaskType;
	var unfoldingMask#_538_$_19 : MaskType;
	var unfoldingMask#_538_$_20 : MaskType;
	var unfoldingMask#_538_$_21 : MaskType;
	var unfoldingMask#_538_$_22 : MaskType;
	var assertSecMask#_533_$_0 : MaskType;
	var assertSecMask#_533_$_1 : MaskType;
	var assertSecMask#_533_$_2 : MaskType;
	var assertSecMask#_533_$_3 : MaskType;
	var assertSecMask#_533_$_4 : MaskType;
	var assertSecMask#_533_$_5 : MaskType;
	var assertSecMask#_533_$_6 : MaskType;
	var assertSecMask#_533_$_7 : MaskType;
	var assertSecMask#_533_$_8 : MaskType;
	var assertSecMask#_533_$_9 : MaskType;
	var assertSecMask#_533_$_10 : MaskType;
	var assertSecMask#_533_$_11 : MaskType;
	var assertSecMask#_533_$_12 : MaskType;
	var assertSecMask#_533_$_13 : MaskType;
	var assertSecMask#_533_$_14 : MaskType;
	var assertSecMask#_533_$_15 : MaskType;
	var assertSecMask#_533_$_16 : MaskType;
	var assertSecMask#_533_$_17 : MaskType;
	var assertSecMask#_533_$_18 : MaskType;
	var assertSecMask#_533_$_19 : MaskType;
	var assertSecMask#_533_$_20 : MaskType;
	var assertSecMask#_533_$_21 : MaskType;
	var assertSecMask#_533_$_22 : MaskType;
	var exhaleHeap#_584_$_0 : HeapType;
	var unfoldingMask#_587_$_0 : MaskType;
	var oldVers#_611_$_0 : int;
	var newVers#_612_$_0 : int;
	var unfoldingHeap#_586_$_0 : HeapType;
	var unfoldingHeap#_586_$_1 : HeapType;
	var unfoldingMask#_587_$_1 : MaskType;
	var unfoldingMask#_587_$_2 : MaskType;
	var unfoldingMask#_587_$_3 : MaskType;
	var unfoldingMask#_587_$_4 : MaskType;
	var unfoldingMask#_587_$_5 : MaskType;
	var unfoldingMask#_587_$_6 : MaskType;
	var unfoldingMask#_587_$_7 : MaskType;
	var unfoldingMask#_587_$_8 : MaskType;
	var unfoldingMask#_587_$_9 : MaskType;
	var unfoldingMask#_587_$_10 : MaskType;
	var unfoldingMask#_587_$_11 : MaskType;
	var unfoldingMask#_587_$_12 : MaskType;
	var unfoldingMask#_587_$_13 : MaskType;
	var unfoldingMask#_587_$_14 : MaskType;
	var unfoldingMask#_587_$_15 : MaskType;
	var unfoldingMask#_587_$_16 : MaskType;
	var unfoldingMask#_587_$_17 : MaskType;
	var unfoldingMask#_587_$_18 : MaskType;
	var unfoldingMask#_587_$_19 : MaskType;
	var unfoldingMask#_587_$_20 : MaskType;
	var unfoldingMask#_587_$_21 : MaskType;
	var unfoldingMask#_587_$_22 : MaskType;
	var assertSecMask#_582_$_0 : MaskType;
	var assertSecMask#_582_$_1 : MaskType;
	var assertSecMask#_582_$_2 : MaskType;
	var assertSecMask#_582_$_3 : MaskType;
	var assertSecMask#_582_$_4 : MaskType;
	var assertSecMask#_582_$_5 : MaskType;
	var assertSecMask#_582_$_6 : MaskType;
	var assertSecMask#_582_$_7 : MaskType;
	var assertSecMask#_582_$_8 : MaskType;
	var assertSecMask#_582_$_9 : MaskType;
	var assertSecMask#_582_$_10 : MaskType;
	var assertSecMask#_582_$_11 : MaskType;
	var assertSecMask#_582_$_12 : MaskType;
	var assertSecMask#_582_$_13 : MaskType;
	var assertSecMask#_582_$_14 : MaskType;
	var assertSecMask#_582_$_15 : MaskType;
	var assertSecMask#_582_$_16 : MaskType;
	var assertSecMask#_582_$_17 : MaskType;
	var assertSecMask#_582_$_18 : MaskType;
	var assertSecMask#_582_$_19 : MaskType;
	var assertSecMask#_582_$_20 : MaskType;
	var assertSecMask#_582_$_21 : MaskType;
	var assertSecMask#_582_$_22 : MaskType;
	var cond#_629_$_0 : bool;
	var r#20_$_1 : ref;
	var r#20_$_2 : ref;
	var Mask_$_149 : MaskType;
	var Heap_$_9 : HeapType;
	var r#20_$_3 : ref;
	var exhaleHeap#_916_$_0 : HeapType;
	var exhaleMask#_917_$_0 : MaskType;
	var exhaleMask#_917_$_1 : MaskType;
	var exhaleMask#_917_$_2 : MaskType;
	var exhaleMask#_917_$_3 : MaskType;
	var exhaleMask#_917_$_4 : MaskType;
	var exhaleMask#_917_$_5 : MaskType;
	var exhaleMask#_917_$_6 : MaskType;
	var exhaleMask#_917_$_7 : MaskType;
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
	var $_$_condition_$193 : bool;
	var $_$_condition_$194 : bool;
	var $_$_condition_$195 : bool;
	var $_$_condition_$196 : bool;
	var $_$_condition_$197 : bool;
	var $_$_condition_$198 : bool;
	var $_$_condition_$199 : bool;
	var $_$_condition_$200 : bool;
	var $_$_condition_$201 : bool;
	var $_$_condition_$202 : bool;
	var $_$_condition_$203 : bool;
	var $_$_condition_$204 : bool;
	var $_$_condition_$205 : bool;
	var $_$_condition_$206 : bool;
	var $_$_condition_$207 : bool;
	var $_$_condition_$208 : bool;
	var $_$_condition_$209 : bool;
	var $_$_condition_$210 : bool;
	var $_$_condition_$211 : bool;
	var $_$_condition_$212 : bool;
	var $_$_condition_$213 : bool;
	var $_$_condition_$214 : bool;
	var $_$_condition_$215 : bool;
	var $_$_condition_$216 : bool;
	var $_$_condition_$217 : bool;
	var $_$_condition_$218 : bool;
	var $_$_condition_$219 : bool;
	var $_$_condition_$220 : bool;
	var $_$_condition_$221 : bool;
	var $_$_condition_$222 : bool;
	var $_$_condition_$223 : bool;
	var $_$_condition_$224 : bool;
	var $_$_condition_$225 : bool;
	var $_$_condition_$226 : bool;
	var $_$_condition_$227 : bool;
	var $_$_condition_$228 : bool;
	var $_$_condition_$229 : bool;
	var $_$_condition_$230 : bool;
	var $_$_condition_$231 : bool;
	var $_$_condition_$232 : bool;
	var $_$_condition_$233 : bool;
	var $_$_condition_$234 : bool;
	var $_$_condition_$235 : bool;
	var $_$_condition_$236 : bool;
	var $_$_condition_$237 : bool;
	var $_$_condition_$238 : bool;
	var $_$_condition_$239 : bool;
	var $_$_condition_$240 : bool;
	var $_$_condition_$241 : bool;
	var $_$_condition_$242 : bool;
	var $_$_condition_$243 : bool;
	var $_$_condition_$244 : bool;
	var $_$_condition_$245 : bool;
	var $_$_condition_$246 : bool;
	var $_$_condition_$247 : bool;
	var $_$_condition_$248 : bool;
	var $_$_condition_$249 : bool;
	var $_$_condition_$250 : bool;
	var $_$_condition_$251 : bool;
	var $_$_condition_$252 : bool;
	var $_$_condition_$253 : bool;
	var $_$_condition_$254 : bool;
	var $_$_condition_$255 : bool;
	var $_$_condition_$256 : bool;
	var $_$_condition_$257 : bool;
	var $_$_condition_$258 : bool;
	var $_$_condition_$259 : bool;
	var $_$_condition_$260 : bool;
	var $_$_condition_$261 : bool;
	var $_$_condition_$262 : bool;
	var $_$_condition_$263 : bool;
	var $_$_condition_$264 : bool;
	var $_$_condition_$265 : bool;
	var $_$_condition_$266 : bool;
	var $_$_condition_$267 : bool;
	var $_$_condition_$268 : bool;
	var $_$_condition_$269 : bool;
	var $_$_condition_$270 : bool;
	var $_$_condition_$271 : bool;
	var $_$_condition_$272 : bool;
	var $_$_condition_$273 : bool;
	var $_$_condition_$274 : bool;
	var $_$_condition_$275 : bool;
	var $_$_condition_$276 : bool;
	var $_$_condition_$277 : bool;
	var $_$_condition_$278 : bool;
	var $_$_condition_$279 : bool;
	var $_$_condition_$280 : bool;
	var $_$_condition_$281 : bool;
	var $_$_condition_$282 : bool;
	var $_$_condition_$283 : bool;
	var $_$_condition_$284 : bool;
	var $_$_condition_$285 : bool;
	var $_$_condition_$286 : bool;
	var $_$_condition_$287 : bool;
	var $_$_condition_$288 : bool;
	var $_$_condition_$289 : bool;
	var $_$_condition_$290 : bool;
	var $_$_condition_$291 : bool;
	var $_$_condition_$292 : bool;
	var $_$_condition_$293 : bool;
	var $_$_condition_$294 : bool;
	var $_$_condition_$295 : bool;
	var $_$_condition_$296 : bool;
	var $_$_condition_$297 : bool;
	var $_$_condition_$298 : bool;
	var $_$_condition_$299 : bool;
	var $_$_condition_$300 : bool;
	var $_$_condition_$301 : bool;
	var $_$_condition_$302 : bool;
	var $_$_condition_$303 : bool;
	var $_$_condition_$304 : bool;
	var $_$_condition_$305 : bool;
	var $_$_condition_$306 : bool;
	var $_$_condition_$307 : bool;
	var $_$_condition_$308 : bool;
	var $_$_condition_$309 : bool;
	var $_$_condition_$310 : bool;
	var $_$_condition_$311 : bool;
	var $_$_condition_$312 : bool;
	var $_$_condition_$313 : bool;
	var $_$_condition_$314 : bool;
	var $_$_condition_$315 : bool;
	var $_$_condition_$316 : bool;
	var $_$_condition_$317 : bool;
	var $_$_condition_$318 : bool;
	var $_$_condition_$319 : bool;
	var $_$_condition_$320 : bool;
	var $_$_condition_$321 : bool;
	var $_$_condition_$322 : bool;
	var $_$_condition_$323 : bool;
	var $_$_condition_$324 : bool;
	var $_$_condition_$325 : bool;
	var $_$_condition_$326 : bool;
	var $_$_condition_$327 : bool;
	var $_$_condition_$328 : bool;
	var $_$_condition_$329 : bool;
	var $_$_condition_$330 : bool;
	var $_$_condition_$331 : bool;
	var $_$_condition_$332 : bool;
	var $_$_condition_$333 : bool;
	var $_$_condition_$334 : bool;
	var $_$_condition_$335 : bool;
	var $_$_condition_$336 : bool;
	var $_$_condition_$337 : bool;
	var $_$_condition_$338 : bool;
	var $_$_condition_$339 : bool;
	var $_$_condition_$340 : bool;
	var $_$_condition_$341 : bool;
	var $_$_condition_$342 : bool;
	var $_$_condition_$343 : bool;
	var $_$_condition_$344 : bool;
	var $_$_condition_$345 : bool;
	var $_$_condition_$346 : bool;
	var $_$_condition_$347 : bool;
	var $_$_condition_$348 : bool;
	var $_$_condition_$349 : bool;
	var $_$_condition_$350 : bool;
	var $_$_condition_$351 : bool;
	var $_$_condition_$352 : bool;
	var $_$_condition_$353 : bool;
	var $_$_condition_$354 : bool;
	var $_$_condition_$355 : bool;
	var $_$_condition_$356 : bool;
	var $_$_condition_$357 : bool;
	var $_$_condition_$358 : bool;
	var $_$_condition_$359 : bool;
	var $_$_condition_$360 : bool;
	var $_$_condition_$361 : bool;
	var $_$_condition_$362 : bool;
	var $_$_condition_$363 : bool;
	var $_$_condition_$364 : bool;
	var $_$_condition_$365 : bool;
	var $_$_condition_$366 : bool;
	var $_$_condition_$367 : bool;
	var $_$_condition_$368 : bool;
	var $_$_condition_$369 : bool;
	var $_$_condition_$370 : bool;
	var $_$_condition_$371 : bool;
	var $_$_condition_$372 : bool;
	var $_$_condition_$373 : bool;
	var $_$_condition_$374 : bool;
	var $_$_condition_$375 : bool;
	var $_$_condition_$376 : bool;
	var $_$_condition_$377 : bool;
	var $_$_condition_$378 : bool;
	var $_$_condition_$379 : bool;
	var $_$_condition_$380 : bool;
	var $_$_condition_$381 : bool;
	var $_$_condition_$382 : bool;
	var $_$_condition_$383 : bool;
	var $_$_condition_$384 : bool;
	var $_$_condition_$385 : bool;
	var $_$_condition_$386 : bool;
	var $_$_condition_$387 : bool;
	var $_$_condition_$388 : bool;
	var $_$_condition_$389 : bool;
	var $_$_condition_$390 : bool;
	var $_$_condition_$391 : bool;
	var $_$_condition_$392 : bool;
	var $_$_condition_$393 : bool;
	var $_$_condition_$394 : bool;
	var $_$_condition_$395 : bool;
	var $_$_condition_$396 : bool;
	var $_$_condition_$397 : bool;
	var $_$_condition_$398 : bool;
	var $_$_condition_$399 : bool;
	var $_$_condition_$400 : bool;
	var $_$_condition_$401 : bool;
	var $_$_condition_$402 : bool;
	var $_$_condition_$403 : bool;
	var $_$_condition_$404 : bool;
	var $_$_condition_$405 : bool;
	var $_$_condition_$406 : bool;
	var $_$_condition_$407 : bool;
	var $_$_condition_$408 : bool;
	var $_$_condition_$409 : bool;
	var $_$_condition_$410 : bool;
	var $_$_condition_$411 : bool;
	var $_$_condition_$412 : bool;
	var $_$_condition_$413 : bool;
	var $_$_condition_$414 : bool;
	var $_$_condition_$415 : bool;
	var $_$_condition_$416 : bool;
	var $_$_condition_$417 : bool;
	var $_$_condition_$418 : bool;
	var $_$_condition_$419 : bool;
	var $_$_condition_$420 : bool;
	var $_$_condition_$421 : bool;
	var $_$_condition_$422 : bool;
	var $_$_condition_$423 : bool;
	var $_$_condition_$424 : bool;
	var $_$_condition_$425 : bool;
	var $_$_condition_$426 : bool;
	var $_$_condition_$427 : bool;
	var $_$_condition_$428 : bool;
	var $_$_condition_$429 : bool;
	var $_$_condition_$430 : bool;
	var $_$_condition_$431 : bool;
	var $_$_condition_$432 : bool;
	var $_$_condition_$433 : bool;
	var $_$_condition_$434 : bool;
	var $_$_condition_$435 : bool;
	var $_$_condition_$436 : bool;
	var $_$_condition_$437 : bool;
	var $_$_condition_$438 : bool;
	var $_$_condition_$439 : bool;
	var $_$_condition_$440 : bool;
	var $_$_condition_$441 : bool;
	var $_$_condition_$442 : bool;
	var $_$_condition_$443 : bool;
	var $_$_condition_$444 : bool;
	var $_$_condition_$445 : bool;
	var $_$_condition_$446 : bool;
	var $_$_condition_$447 : bool;
	var $_$_condition_$448 : bool;
	var $_$_condition_$449 : bool;
	var $_$_condition_$450 : bool;
	var $_$_condition_$451 : bool;
	var $_$_condition_$452 : bool;
	var $_$_condition_$453 : bool;
	var $_$_condition_$454 : bool;
	var $_$_condition_$455 : bool;
	var $_$_condition_$456 : bool;
	var $_$_condition_$457 : bool;
	var $_$_condition_$458 : bool;
	var $_$_condition_$459 : bool;
	var $_$_condition_$460 : bool;
	var $_$_condition_$461 : bool;
	var $_$_condition_$462 : bool;
	var $_$_condition_$463 : bool;
	var $_$_condition_$464 : bool;
	var $_$_condition_$465 : bool;
	var $_$_condition_$466 : bool;
	var $_$_condition_$467 : bool;
	var $_$_condition_$468 : bool;
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
	assume (r#20 == null) || (dtype(r#20) == AVLTreeNode#t);
	assume true;
	assume (nl#24 == null) || (dtype(nl#24) == AVLTreeNode#t);
	assume (nr#26 == null) || (dtype(nr#26) == AVLTreeNode#t);
	assume (this#248 == null) || (dtype(this#248) == AVLTreeNode#t);
	assume true;
	assume (this#250 == null) || (dtype(this#250) == AVLTreeNode#t);
	assume (r#251 == null) || (dtype(r#251) == AVLTreeNode#t);
	assume (m#252 == null) || (dtype(m#252) == AVLTreeNode#t);
	assume (this#254 == null) || (dtype(this#254) == AVLTreeNode#t);
	assume (r#255 == null) || (dtype(r#255) == AVLTreeNode#t);
	assume (m#256 == null) || (dtype(m#256) == AVLTreeNode#t);
	assume (this#264 == null) || (dtype(this#264) == AVLTreeNode#t);
	assume (nl#28 == null) || (dtype(nl#28) == AVLTreeNode#t);
	assume (this#269 == null) || (dtype(this#269) == AVLTreeNode#t);
	assume true;
	assume (r#271 == null) || (dtype(r#271) == AVLTreeNode#t);
	assume true;
	assume (this#274 == null) || (dtype(this#274) == AVLTreeNode#t);
	assume true;
	assume (this#276 == null) || (dtype(this#276) == AVLTreeNode#t);
	assume (r#277 == null) || (dtype(r#277) == AVLTreeNode#t);
	assume (this#282 == null) || (dtype(this#282) == AVLTreeNode#t);
	assume (this#287 == null) || (dtype(this#287) == AVLTreeNode#t);
	assume (nr#32 == null) || (dtype(nr#32) == AVLTreeNode#t);
	assume (this#292 == null) || (dtype(this#292) == AVLTreeNode#t);
	assume true;
	assume (r#294 == null) || (dtype(r#294) == AVLTreeNode#t);
	assume true;
	assume (this#297 == null) || (dtype(this#297) == AVLTreeNode#t);
	assume true;
	assume (this#299 == null) || (dtype(this#299) == AVLTreeNode#t);
	assume (r#300 == null) || (dtype(r#300) == AVLTreeNode#t);
	assume (this#305 == null) || (dtype(this#305) == AVLTreeNode#t);
	assume (this#310 == null) || (dtype(this#310) == AVLTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_506) && ((1000 * methodK#_506) < Fractions(1));
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
	assume ((0 < unfoldK#_507) && (unfoldK#_507 < Fractions(1))) && ((1000 * unfoldK#_507) < methodK#_506);
	assert { :msg "  278.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  278.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  278.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_3[this,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_3[this,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_3[this,AVLTreeNode.valid][perm$N]));
	assume Mask_$_4 == Mask_$_3[this,AVLTreeNode.valid := Mask_$_3[this,AVLTreeNode.valid][perm$R := Mask_$_3[this,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition) { goto anon862_Then; } else { goto anon862_Else; }
anon862_Then:
	assume false;
	goto $exit;
anon862_Else:
	assume !false;
	if ($_$_condition_$0) { goto anon889_Then; } else { goto anon889_Else; }
anon889_Then:
	assume !CanRead(Mask_$_4,ZeroMask,this,AVLTreeNode.valid);
	assume oldVers#_527_$_0 == Heap[this,AVLTreeNode.valid];
	assume Heap_$_0 == Heap[this,AVLTreeNode.valid := newVers#_528_$_0];
	assume oldVers#_527_$_0 < Heap_$_0[this,AVLTreeNode.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon56;
anon889_Else:
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
	if ($_$_condition_$1) { goto anon890_Then; } else { goto anon890_Else; }
anon890_Then:
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
	if ($_$_condition_$2) { goto anon891_Then; } else { goto anon891_Else; }
anon890_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_12 == Mask_$_10;
	if ($_$_condition_$3) { goto anon891_Then; } else { goto anon891_Else; }
anon891_Then:
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
	if ($_$_condition_$4) { goto anon892_Then; } else { goto anon892_Else; }
anon891_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_14 == Mask_$_12;
	if ($_$_condition_$5) { goto anon892_Then; } else { goto anon892_Else; }
anon892_Then:
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
	if ($_$_condition_$6) { goto anon893_Then; } else { goto anon893_Else; }
anon892_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_16 == Mask_$_14;
	if ($_$_condition_$7) { goto anon893_Then; } else { goto anon893_Else; }
anon893_Then:
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
	if ($_$_condition_$8) { goto anon894_Then; } else { goto anon894_Else; }
anon893_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume Mask_$_18 == Mask_$_16;
	if ($_$_condition_$9) { goto anon894_Then; } else { goto anon894_Else; }
anon894_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume (forall  lk#79#222 : Integer :: ( ((0 <= lk#79#222) && (lk#79#222 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],lk#79#222) < Heap_$_1[this,AVLTreeNode.key]) ));
	if ($_$_condition_$10) { goto anon895_Then; } else { goto anon895_Else; }
anon894_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$11) { goto anon895_Then; } else { goto anon895_Else; }
anon895_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$12) { goto anon896_Then; } else { goto anon896_Else; }
anon895_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$13) { goto anon896_Then; } else { goto anon896_Else; }
anon896_Then:
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
	if ($_$_condition_$14) { goto anon897_Then; } else { goto anon897_Else; }
anon896_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_20 == Mask_$_18;
	if ($_$_condition_$15) { goto anon897_Then; } else { goto anon897_Else; }
anon897_Then:
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
	if ($_$_condition_$16) { goto anon898_Then; } else { goto anon898_Else; }
anon897_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_22 == Mask_$_20;
	if ($_$_condition_$17) { goto anon898_Then; } else { goto anon898_Else; }
anon898_Then:
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
	if ($_$_condition_$18) { goto anon899_Then; } else { goto anon899_Else; }
anon898_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_24 == Mask_$_22;
	if ($_$_condition_$19) { goto anon899_Then; } else { goto anon899_Else; }
anon899_Then:
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
	if ($_$_condition_$20) { goto anon900_Then; } else { goto anon900_Else; }
anon899_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume Mask_$_26 == Mask_$_24;
	if ($_$_condition_$21) { goto anon900_Then; } else { goto anon900_Else; }
anon900_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume (forall  rk#80#223 : Integer :: ( ((0 <= rk#80#223) && (rk#80#223 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[this,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],rk#80#223)) ));
	if ($_$_condition_$22) { goto anon901_Then; } else { goto anon901_Else; }
anon900_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	if ($_$_condition_$23) { goto anon901_Then; } else { goto anon901_Else; }
anon901_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon80;
anon901_Else:
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
	assume cond#_529_$_0 <==> (Heap_$_1[this,AVLTreeNode.key] == k#19);
	assert { :msg "  279.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  279.7: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.key);
	if ($_$_condition_$24) { goto anon902_Then; } else { goto anon902_Else; }
anon902_Then:
	assume cond#_529_$_0;
	assume cond#_530_$_0 <==> ((Heap_$_1[this,AVLTreeNode.left] == null) || (Heap_$_1[this,AVLTreeNode.right] == null));
	assert { :msg "  280.8: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  280.8: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  280.22: Receiver might be null." } (true && (!(Heap_$_1[this,AVLTreeNode.left] == null))) ==> (!(this == null));
	assert { :msg "  280.22: Location might not be readable." } (true && (!(Heap_$_1[this,AVLTreeNode.left] == null))) ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$25) { goto anon903_Then; } else { goto anon903_Else; }
anon902_Else:
	assume !cond#_529_$_0;
	assume cond#_717_$_0 <==> (k#19 < Heap_$_1[this,AVLTreeNode.key]);
	assert { :msg "  305.10: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  305.10: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.key);
	if ($_$_condition_$26) { goto anon1150_Then; } else { goto anon1150_Else; }
anon903_Then:
	assume cond#_530_$_0;
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  281.12: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  281.12: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$27) { goto anon904_Then; } else { goto anon904_Else; }
anon903_Else:
	assume !cond#_530_$_0;
	assert { :msg "  290.29: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  290.29: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	assume nl#24_$_0 == Heap_$_1[this,AVLTreeNode.left];
	assert { :msg "  291.29: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  291.29: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	assume nr#26_$_0 == Heap_$_1[this,AVLTreeNode.right];
	assume ((0 < methodCallK#_634) && ((1000 * methodCallK#_634) < Fractions(1))) && ((1000 * methodCallK#_634) < methodK#_506);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  293.5: The target of the method call might be null." } !(this == null);
	assert { :msg "  293.5: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive." } methodCallK#_634 > 0;
	assert { :msg "  293.5: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left." } Mask_$_26[this,AVLTreeNode.left][perm$R] > 0;
	assume methodCallK#_634 < Mask_$_26[this,AVLTreeNode.left][perm$R];
	assume exhaleMask#_636_$_0 == Mask_$_26[this,AVLTreeNode.left := Mask_$_26[this,AVLTreeNode.left][perm$R := Mask_$_26[this,AVLTreeNode.left][perm$R] - methodCallK#_634]];
	assume IsGoodMask(exhaleMask#_636_$_0);
	assume wf(Heap_$_1,exhaleMask#_636_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	if ($_$_condition_$28) { goto anon1065_Then; } else { goto anon1065_Else; }
anon1150_Then:
	assume cond#_717_$_0;
	assume cond#_718_$_0 <==> (!(Heap_$_1[this,AVLTreeNode.left] == null));
	assert { :msg "  306.9: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  306.9: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$29) { goto anon1151_Then; } else { goto anon1151_Else; }
anon1150_Else:
	assume !cond#_717_$_0;
	assume cond#_817_$_0 <==> (!(Heap_$_1[this,AVLTreeNode.right] == null));
	assert { :msg "  325.9: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  325.9: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	if ($_$_condition_$30) { goto anon1213_Then; } else { goto anon1213_Else; }
anon904_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume (0 < unfoldingK#_542) && ((1000 * unfoldingK#_542) < Fractions(1));
	assert { :msg "  281.38: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  281.38: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  281.38: Receiver might be null." } true ==> (!(Heap_$_1[this,AVLTreeNode.right] == null));
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  281.28: Unfolding might fail. The permission at 281.38 might not be positive." } Fractions(100) > 0;
	assert { :msg "  281.28: Unfolding might fail. Insufficient fraction at 281.38 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_26[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_26[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_26[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume unfoldingMask#_538_$_0 == Mask_$_26[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_26[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_26[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$31) { goto anon905_Then; } else { goto anon905_Else; }
anon904_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume assertSecMask#_533_$_22 == ZeroMask;
	goto anon242;
anon1065_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  293.5: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive." } methodCallK#_634 > 0;
	assert { :msg "  293.5: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height." } exhaleMask#_636_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_634 < exhaleMask#_636_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume exhaleMask#_636_$_1 == exhaleMask#_636_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_636_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_636_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - methodCallK#_634]];
	assume IsGoodMask(exhaleMask#_636_$_1);
	assume wf(Heap_$_1,exhaleMask#_636_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_636_$_2 == exhaleMask#_636_$_1;
	goto anon407;
anon1065_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_636_$_2 == exhaleMask#_636_$_0;
	goto anon407;
anon1151_Then:
	assume cond#_718_$_0;
	assume ((0 < methodCallK#_723) && ((1000 * methodCallK#_723) < Fractions(1))) && ((1000 * methodCallK#_723) < methodK#_506);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  308.17: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  308.17: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  308.6: The target of the method call might be null." } !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume this#269_$_0 == Heap_$_1[this,AVLTreeNode.left];
	assert { :msg "  308.6: The precondition at 254.12 might not hold. The permission at 254.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  308.6: The precondition at 254.12 might not hold. Insufficient fraction at 254.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_26[this#269_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_26[this#269_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_26[this#269_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_725_$_0 == Mask_$_26[this#269_$_0,AVLTreeNode.valid := Mask_$_26[this#269_$_0,AVLTreeNode.valid][perm$R := Mask_$_26[this#269_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$32) { goto anon1152_Then; } else { goto anon1152_Else; }
anon1151_Else:
	assume !cond#_718_$_0;
	assume ((0 < methodCallK#_798) && ((1000 * methodCallK#_798) < Fractions(1))) && ((1000 * methodCallK#_798) < methodK#_506);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  322.6: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$33) { goto anon1201_Then; } else { goto anon1201_Else; }
anon1213_Then:
	assume cond#_817_$_0;
	assume ((0 < methodCallK#_822) && ((1000 * methodCallK#_822) < Fractions(1))) && ((1000 * methodCallK#_822) < methodK#_506);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  327.17: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  327.17: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  327.6: The target of the method call might be null." } !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume this#292_$_0 == Heap_$_1[this,AVLTreeNode.right];
	assert { :msg "  327.6: The precondition at 254.12 might not hold. The permission at 254.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  327.6: The precondition at 254.12 might not hold. Insufficient fraction at 254.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_26[this#292_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_26[this#292_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_26[this#292_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_824_$_0 == Mask_$_26[this#292_$_0,AVLTreeNode.valid := Mask_$_26[this#292_$_0,AVLTreeNode.valid][perm$R := Mask_$_26[this#292_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$34) { goto anon1214_Then; } else { goto anon1214_Else; }
anon1213_Else:
	assume !cond#_817_$_0;
	assume ((0 < methodCallK#_897) && ((1000 * methodCallK#_897) < Fractions(1))) && ((1000 * methodCallK#_897) < methodK#_506);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  340.6: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$35) { goto anon1263_Then; } else { goto anon1263_Else; }
anon905_Then:
	assume false;
	goto $exit;
anon905_Else:
	assume !false;
	if ($_$_condition_$36) { goto anon932_Then; } else { goto anon932_Else; }
anon242:
	assume IsGoodExhaleState(exhaleHeap#_535_$_0,Heap_$_1,Mask_$_26,assertSecMask#_533_$_22);
	assume IsGoodMask(Mask_$_26);
	assume wf(exhaleHeap#_535_$_0,Mask_$_26,assertSecMask#_533_$_22);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  282.12: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  282.12: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$259) { goto anon984_Then; } else { goto anon984_Else; }
anon407:
	assert { :msg "  293.5: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive." } methodCallK#_634 > 0;
	assert { :msg "  293.5: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right." } exhaleMask#_636_$_2[this,AVLTreeNode.right][perm$R] > 0;
	assume methodCallK#_634 < exhaleMask#_636_$_2[this,AVLTreeNode.right][perm$R];
	assume exhaleMask#_636_$_3 == exhaleMask#_636_$_2[this,AVLTreeNode.right := exhaleMask#_636_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_636_$_2[this,AVLTreeNode.right][perm$R] - methodCallK#_634]];
	assume IsGoodMask(exhaleMask#_636_$_3);
	assume wf(Heap_$_1,exhaleMask#_636_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	if ($_$_condition_$37) { goto anon1066_Then; } else { goto anon1066_Else; }
anon1152_Then:
	assume !CanRead(exhaleMask#_725_$_0,ZeroMask,this#269_$_0,AVLTreeNode.valid);
	assume Heap_$_1[this#269_$_0,AVLTreeNode.valid] < exhaleHeap#_724_$_0[this#269_$_0,AVLTreeNode.valid];
	goto anon581;
anon1152_Else:
	assume CanRead(exhaleMask#_725_$_0,ZeroMask,this#269_$_0,AVLTreeNode.valid);
	goto anon581;
anon1201_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  322.6: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#288 : Integer :: ( ((0 <= k#92#288) && (k#92#288 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#288) < Heap_$_1[this,AVLTreeNode.key]) ));
	if ($_$_condition_$38) { goto anon1202_Then; } else { goto anon1202_Else; }
anon1201_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$39) { goto anon1202_Then; } else { goto anon1202_Else; }
anon1214_Then:
	assume !CanRead(exhaleMask#_824_$_0,ZeroMask,this#292_$_0,AVLTreeNode.valid);
	assume Heap_$_1[this#292_$_0,AVLTreeNode.valid] < exhaleHeap#_823_$_0[this#292_$_0,AVLTreeNode.valid];
	goto anon705;
anon1214_Else:
	assume CanRead(exhaleMask#_824_$_0,ZeroMask,this#292_$_0,AVLTreeNode.valid);
	goto anon705;
anon1263_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  340.6: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#311 : Integer :: ( ((0 <= k#92#311) && (k#92#311 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#311) < Heap_$_1[this,AVLTreeNode.key]) ));
	if ($_$_condition_$40) { goto anon1264_Then; } else { goto anon1264_Else; }
anon1263_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	if ($_$_condition_$41) { goto anon1264_Then; } else { goto anon1264_Else; }
anon932_Then:
	assume !CanRead(unfoldingMask#_538_$_0,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume oldVers#_562_$_0 == Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume unfoldingHeap#_537_$_0 == Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid := newVers#_563_$_0];
	assume oldVers#_562_$_0 < unfoldingHeap#_537_$_0[unfoldingHeap#_537_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume unfoldingHeap#_537_$_1 == unfoldingHeap#_537_$_0;
	goto anon139;
anon932_Else:
	assume CanRead(unfoldingMask#_538_$_0,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume unfoldingHeap#_537_$_1 == Heap_$_1;
	goto anon139;
anon1066_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  293.5: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive." } methodCallK#_634 > 0;
	assert { :msg "  293.5: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height." } exhaleMask#_636_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_634 < exhaleMask#_636_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume exhaleMask#_636_$_4 == exhaleMask#_636_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_636_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_636_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - methodCallK#_634]];
	assume IsGoodMask(exhaleMask#_636_$_4);
	assume wf(Heap_$_1,exhaleMask#_636_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_636_$_5 == exhaleMask#_636_$_4;
	if ($_$_condition_$42) { goto anon1067_Then; } else { goto anon1067_Else; }
anon1066_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_636_$_5 == exhaleMask#_636_$_3;
	if ($_$_condition_$43) { goto anon1067_Then; } else { goto anon1067_Else; }
anon581:
	assume IsGoodMask(exhaleMask#_725_$_0);
	assume wf(Heap_$_1,exhaleMask#_725_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  308.6: The precondition at 255.12 might not hold. The permission at 255.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  308.6: The precondition at 255.12 might not hold. Insufficient fraction at 255.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_725_$_0[this#269_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_725_$_0[this#269_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_725_$_0[this#269_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_725_$_1 == exhaleMask#_725_$_0[this#269_$_0,AVLTreeNode.keys := exhaleMask#_725_$_0[this#269_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_725_$_0[this#269_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_725_$_1);
	assume wf(Heap_$_1,exhaleMask#_725_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  308.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  308.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_725_$_1[this#269_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_725_$_1[this#269_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_725_$_1[this#269_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_725_$_2 == exhaleMask#_725_$_1[this#269_$_0,AVLTreeNode.height := exhaleMask#_725_$_1[this#269_$_0,AVLTreeNode.height][perm$R := exhaleMask#_725_$_1[this#269_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_725_$_2);
	assume wf(Heap_$_1,exhaleMask#_725_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  308.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  308.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_725_$_2[this#269_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_725_$_2[this#269_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_725_$_2[this#269_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_725_$_3 == exhaleMask#_725_$_2[this#269_$_0,AVLTreeNode.balanceFactor := exhaleMask#_725_$_2[this#269_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_725_$_2[this#269_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_725_$_3);
	assume wf(Heap_$_1,exhaleMask#_725_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_724_$_0,Heap_$_1,exhaleMask#_725_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_725_$_3);
	assume wf(exhaleHeap#_724_$_0,exhaleMask#_725_$_3,ZeroMask);
	assume (r#271_$_0 == null) || (dtype(r#271_$_0) == AVLTreeNode#t);
	if ($_$_condition_$44) { goto anon1153_Then; } else { goto anon1153_Else; }
anon1202_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  322.6: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#289 : Integer :: ( ((0 <= k#93#289) && (k#93#289 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[this,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#289)) ));
	goto anon681;
anon1202_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	goto anon681;
anon705:
	assume IsGoodMask(exhaleMask#_824_$_0);
	assume wf(Heap_$_1,exhaleMask#_824_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  327.6: The precondition at 255.12 might not hold. The permission at 255.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  327.6: The precondition at 255.12 might not hold. Insufficient fraction at 255.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_824_$_0[this#292_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_824_$_0[this#292_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_824_$_0[this#292_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_824_$_1 == exhaleMask#_824_$_0[this#292_$_0,AVLTreeNode.keys := exhaleMask#_824_$_0[this#292_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_824_$_0[this#292_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_824_$_1);
	assume wf(Heap_$_1,exhaleMask#_824_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  327.6: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  327.6: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_824_$_1[this#292_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_824_$_1[this#292_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_824_$_1[this#292_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_824_$_2 == exhaleMask#_824_$_1[this#292_$_0,AVLTreeNode.height := exhaleMask#_824_$_1[this#292_$_0,AVLTreeNode.height][perm$R := exhaleMask#_824_$_1[this#292_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_824_$_2);
	assume wf(Heap_$_1,exhaleMask#_824_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  327.6: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  327.6: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_824_$_2[this#292_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_824_$_2[this#292_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_824_$_2[this#292_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_824_$_3 == exhaleMask#_824_$_2[this#292_$_0,AVLTreeNode.balanceFactor := exhaleMask#_824_$_2[this#292_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_824_$_2[this#292_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_824_$_3);
	assume wf(Heap_$_1,exhaleMask#_824_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_823_$_0,Heap_$_1,exhaleMask#_824_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_824_$_3);
	assume wf(exhaleHeap#_823_$_0,exhaleMask#_824_$_3,ZeroMask);
	assume (r#294_$_0 == null) || (dtype(r#294_$_0) == AVLTreeNode#t);
	if ($_$_condition_$45) { goto anon1215_Then; } else { goto anon1215_Else; }
anon1264_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  340.6: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#312 : Integer :: ( ((0 <= k#93#312) && (k#93#312 < Seq#Length(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[this,AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#312)) ));
	goto anon805;
anon1264_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	goto anon805;
anon139:
	assume IsGoodMask(unfoldingMask#_538_$_0);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_0,ZeroMask);
	assume IsGoodMask(unfoldingMask#_538_$_0);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_0,ZeroMask);
	assume !(unfoldingHeap#_537_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_0,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume unfoldingMask#_538_$_1 == unfoldingMask#_538_$_0[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key := unfoldingMask#_538_$_0[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := unfoldingMask#_538_$_0[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_538_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_1,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_1,ZeroMask);
	assume !(unfoldingHeap#_537_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_1,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_2 == unfoldingMask#_538_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.height := unfoldingMask#_538_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingMask#_538_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_2,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_2,ZeroMask);
	assume !(unfoldingHeap#_537_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_2,ZeroMask);
	assume (unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null) || (dtype(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_538_$_3 == unfoldingMask#_538_$_2[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left := unfoldingMask#_538_$_2[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := unfoldingMask#_538_$_2[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_538_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_3,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_3,ZeroMask);
	assume !(unfoldingHeap#_537_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_3,ZeroMask);
	assume (unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null) || (dtype(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_538_$_4 == unfoldingMask#_538_$_3[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right := unfoldingMask#_538_$_3[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := unfoldingMask#_538_$_3[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_538_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_4,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_4,ZeroMask);
	assume !(unfoldingHeap#_537_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_4,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_5 == unfoldingMask#_538_$_4[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := unfoldingMask#_538_$_4[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingMask#_538_$_4[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_5,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_5,ZeroMask);
	assume !(unfoldingHeap#_537_$_1[this,AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_5,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_6 == unfoldingMask#_538_$_5[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingMask#_538_$_5[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_538_$_5[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_6,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_6,ZeroMask);
	if ($_$_condition_$46) { goto anon933_Then; } else { goto anon933_Else; }
anon1067_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  293.5: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  293.5: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_636_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_636_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_636_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_636_$_6 == exhaleMask#_636_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_636_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_636_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$47) { goto anon1068_Then; } else { goto anon1068_Else; }
anon1067_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_636_$_7 == exhaleMask#_636_$_5;
	if ($_$_condition_$48) { goto anon1069_Then; } else { goto anon1069_Else; }
anon1153_Then:
	assume Seq#Equal(Heap_$_1[this#269_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	assume r#271_$_0 == null;
	if ($_$_condition_$49) { goto anon1154_Then; } else { goto anon1154_Else; }
anon1153_Else:
	assume !Seq#Equal(Heap_$_1[this#269_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	if ($_$_condition_$50) { goto anon1154_Then; } else { goto anon1154_Else; }
anon681:
	assert { :msg "  322.6: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  322.6: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  322.6: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_26[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_26[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_26[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_800_$_0 == Mask_$_26[this,AVLTreeNode.key := Mask_$_26[this,AVLTreeNode.key][perm$R := Mask_$_26[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_800_$_0);
	assume wf(Heap_$_1,exhaleMask#_800_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  322.6: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_800_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_800_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_800_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_800_$_1 == exhaleMask#_800_$_0[this,AVLTreeNode.height := exhaleMask#_800_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_800_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_800_$_1);
	assume wf(Heap_$_1,exhaleMask#_800_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  322.6: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_800_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_800_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_800_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_800_$_2 == exhaleMask#_800_$_1[this,AVLTreeNode.left := exhaleMask#_800_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_800_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_800_$_2);
	assume wf(Heap_$_1,exhaleMask#_800_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  322.6: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_800_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_800_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_800_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_800_$_3 == exhaleMask#_800_$_2[this,AVLTreeNode.right := exhaleMask#_800_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_800_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_800_$_3);
	assume wf(Heap_$_1,exhaleMask#_800_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  322.6: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_800_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_800_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_800_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_800_$_4 == exhaleMask#_800_$_3[this,AVLTreeNode.keys := exhaleMask#_800_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_800_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_800_$_4);
	assume wf(Heap_$_1,exhaleMask#_800_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  322.6: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_800_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_800_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_800_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_800_$_5 == exhaleMask#_800_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_800_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_800_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_800_$_5);
	assume wf(Heap_$_1,exhaleMask#_800_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	if ($_$_condition_$51) { goto anon1203_Then; } else { goto anon1203_Else; }
anon1215_Then:
	assume Seq#Equal(Heap_$_1[this#292_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	assume r#294_$_0 == null;
	if ($_$_condition_$52) { goto anon1216_Then; } else { goto anon1216_Else; }
anon1215_Else:
	assume !Seq#Equal(Heap_$_1[this#292_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	if ($_$_condition_$53) { goto anon1216_Then; } else { goto anon1216_Else; }
anon805:
	assert { :msg "  340.6: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  340.6: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  340.6: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_26[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_26[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_26[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_899_$_0 == Mask_$_26[this,AVLTreeNode.key := Mask_$_26[this,AVLTreeNode.key][perm$R := Mask_$_26[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_899_$_0);
	assume wf(Heap_$_1,exhaleMask#_899_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  340.6: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_899_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_899_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_899_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_899_$_1 == exhaleMask#_899_$_0[this,AVLTreeNode.height := exhaleMask#_899_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_899_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_899_$_1);
	assume wf(Heap_$_1,exhaleMask#_899_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  340.6: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_899_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_899_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_899_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_899_$_2 == exhaleMask#_899_$_1[this,AVLTreeNode.left := exhaleMask#_899_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_899_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_899_$_2);
	assume wf(Heap_$_1,exhaleMask#_899_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  340.6: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_899_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_899_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_899_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_899_$_3 == exhaleMask#_899_$_2[this,AVLTreeNode.right := exhaleMask#_899_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_899_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_899_$_3);
	assume wf(Heap_$_1,exhaleMask#_899_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  340.6: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_899_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_899_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_899_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_899_$_4 == exhaleMask#_899_$_3[this,AVLTreeNode.keys := exhaleMask#_899_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_899_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_899_$_4);
	assume wf(Heap_$_1,exhaleMask#_899_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  340.6: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_899_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_899_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_899_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_899_$_5 == exhaleMask#_899_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_899_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_899_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_899_$_5);
	assume wf(Heap_$_1,exhaleMask#_899_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	if ($_$_condition_$54) { goto anon1265_Then; } else { goto anon1265_Else; }
anon933_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_6,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_538_$_7 == unfoldingMask#_538_$_6[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := unfoldingMask#_538_$_6[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := unfoldingMask#_538_$_6[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_538_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_7,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_7,ZeroMask);
	assume unfoldingMask#_538_$_8 == unfoldingMask#_538_$_7;
	if ($_$_condition_$55) { goto anon934_Then; } else { goto anon934_Else; }
anon933_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_538_$_8 == unfoldingMask#_538_$_6;
	if ($_$_condition_$56) { goto anon934_Then; } else { goto anon934_Else; }
anon1068_Then:
	assume !CanRead(exhaleMask#_636_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_635_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon412;
anon1068_Else:
	assume CanRead(exhaleMask#_636_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon412;
anon1069_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  293.5: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  293.5: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_636_$_7[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_636_$_7[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_636_$_7[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_636_$_8 == exhaleMask#_636_$_7[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_636_$_7[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_636_$_7[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$74) { goto anon1070_Then; } else { goto anon1070_Else; }
anon1069_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_636_$_9 == exhaleMask#_636_$_7;
	goto anon417;
anon1154_Then:
	assume !Seq#Equal(Heap_$_1[this#269_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	assume !(r#271_$_0 == null);
	if ($_$_condition_$57) { goto anon1155_Then; } else { goto anon1155_Else; }
anon1154_Else:
	assume Seq#Equal(Heap_$_1[this#269_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	if ($_$_condition_$58) { goto anon1155_Then; } else { goto anon1155_Else; }
anon1203_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  322.6: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_800_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_800_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_800_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_800_$_6 == exhaleMask#_800_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_800_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_800_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$59) { goto anon1204_Then; } else { goto anon1204_Else; }
anon1203_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_800_$_7 == exhaleMask#_800_$_5;
	if ($_$_condition_$60) { goto anon1205_Then; } else { goto anon1205_Else; }
anon1216_Then:
	assume !Seq#Equal(Heap_$_1[this#292_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	assume !(r#294_$_0 == null);
	if ($_$_condition_$61) { goto anon1217_Then; } else { goto anon1217_Else; }
anon1216_Else:
	assume Seq#Equal(Heap_$_1[this#292_$_0,AVLTreeNode.keys],Seq#Singleton(k#19));
	if ($_$_condition_$62) { goto anon1217_Then; } else { goto anon1217_Else; }
anon1265_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  340.6: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_899_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_899_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_899_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_899_$_6 == exhaleMask#_899_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_899_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_899_$_5[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$63) { goto anon1266_Then; } else { goto anon1266_Else; }
anon1265_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_899_$_7 == exhaleMask#_899_$_5;
	if ($_$_condition_$64) { goto anon1267_Then; } else { goto anon1267_Else; }
anon934_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_8,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_9 == unfoldingMask#_538_$_8[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_538_$_8[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_538_$_8[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_9);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_9,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_9,ZeroMask);
	assume unfoldingMask#_538_$_10 == unfoldingMask#_538_$_9;
	if ($_$_condition_$65) { goto anon935_Then; } else { goto anon935_Else; }
anon934_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_538_$_10 == unfoldingMask#_538_$_8;
	if ($_$_condition_$66) { goto anon935_Then; } else { goto anon935_Else; }
anon412:
	assume IsGoodMask(exhaleMask#_636_$_6);
	assume wf(Heap_$_1,exhaleMask#_636_$_6,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_636_$_7 == exhaleMask#_636_$_6;
	if ($_$_condition_$67) { goto anon1069_Then; } else { goto anon1069_Else; }
anon1155_Then:
	assume !(r#271_$_0 == null);
	assume !(r#271_$_0 == null);
	assume wf(exhaleHeap#_724_$_0,exhaleMask#_725_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_61 == exhaleMask#_725_$_3[r#271_$_0,AVLTreeNode.valid := exhaleMask#_725_$_3[r#271_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_725_$_3[r#271_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_61);
	assume IsGoodState(heapFragment(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_724_$_0,Mask_$_61,ZeroMask);
	assume wf(exhaleHeap#_724_$_0,Mask_$_61,ZeroMask);
	assume Mask_$_62 == Mask_$_61;
	if ($_$_condition_$68) { goto anon1156_Then; } else { goto anon1156_Else; }
anon1155_Else:
	assume r#271_$_0 == null;
	assume Mask_$_62 == exhaleMask#_725_$_3;
	if ($_$_condition_$69) { goto anon1156_Then; } else { goto anon1156_Else; }
anon1204_Then:
	assume !CanRead(exhaleMask#_800_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_799_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon684;
anon1204_Else:
	assume CanRead(exhaleMask#_800_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon684;
anon1205_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  322.6: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  322.6: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_800_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_800_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_800_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_800_$_8 == exhaleMask#_800_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_800_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_800_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_800_$_8);
	assume wf(Heap_$_1,exhaleMask#_800_$_8,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_9 == exhaleMask#_800_$_8;
	if ($_$_condition_$85) { goto anon1206_Then; } else { goto anon1206_Else; }
anon1205_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_800_$_9 == exhaleMask#_800_$_7;
	if ($_$_condition_$86) { goto anon1206_Then; } else { goto anon1206_Else; }
anon1217_Then:
	assume !(r#294_$_0 == null);
	assume !(r#294_$_0 == null);
	assume wf(exhaleHeap#_823_$_0,exhaleMask#_824_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_31 == exhaleMask#_824_$_3[r#294_$_0,AVLTreeNode.valid := exhaleMask#_824_$_3[r#294_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_824_$_3[r#294_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_31);
	assume IsGoodState(heapFragment(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_823_$_0,Mask_$_31,ZeroMask);
	assume wf(exhaleHeap#_823_$_0,Mask_$_31,ZeroMask);
	assume Mask_$_32 == Mask_$_31;
	if ($_$_condition_$70) { goto anon1218_Then; } else { goto anon1218_Else; }
anon1217_Else:
	assume r#294_$_0 == null;
	assume Mask_$_32 == exhaleMask#_824_$_3;
	if ($_$_condition_$71) { goto anon1218_Then; } else { goto anon1218_Else; }
anon1266_Then:
	assume !CanRead(exhaleMask#_899_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_898_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon808;
anon1266_Else:
	assume CanRead(exhaleMask#_899_$_6,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon808;
anon1267_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  340.6: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  340.6: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_899_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_899_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_899_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_899_$_8 == exhaleMask#_899_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_899_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_899_$_7[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_899_$_8);
	assume wf(Heap_$_1,exhaleMask#_899_$_8,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_9 == exhaleMask#_899_$_8;
	if ($_$_condition_$89) { goto anon1268_Then; } else { goto anon1268_Else; }
anon1267_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_899_$_9 == exhaleMask#_899_$_7;
	if ($_$_condition_$90) { goto anon1268_Then; } else { goto anon1268_Else; }
anon935_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_10,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_11 == unfoldingMask#_538_$_10[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_538_$_10[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_538_$_10[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_11);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_11,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_11,ZeroMask);
	assume unfoldingMask#_538_$_12 == unfoldingMask#_538_$_11;
	if ($_$_condition_$72) { goto anon936_Then; } else { goto anon936_Else; }
anon935_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_538_$_12 == unfoldingMask#_538_$_10;
	if ($_$_condition_$73) { goto anon936_Then; } else { goto anon936_Else; }
anon1156_Then:
	assume !(r#271_$_0 == null);
	assume !(r#271_$_0 == null);
	assume wf(exhaleHeap#_724_$_0,Mask_$_62,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_63 == Mask_$_62[r#271_$_0,AVLTreeNode.keys := Mask_$_62[r#271_$_0,AVLTreeNode.keys][perm$R := Mask_$_62[r#271_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_63);
	assume IsGoodState(heapFragment(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_724_$_0,Mask_$_63,ZeroMask);
	assume wf(exhaleHeap#_724_$_0,Mask_$_63,ZeroMask);
	assume Mask_$_64 == Mask_$_63;
	if ($_$_condition_$75) { goto anon1157_Then; } else { goto anon1157_Else; }
anon1156_Else:
	assume r#271_$_0 == null;
	assume Mask_$_64 == Mask_$_62;
	if ($_$_condition_$76) { goto anon1157_Then; } else { goto anon1157_Else; }
anon684:
	assume IsGoodMask(exhaleMask#_800_$_6);
	assume wf(Heap_$_1,exhaleMask#_800_$_6,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_7 == exhaleMask#_800_$_6;
	if ($_$_condition_$77) { goto anon1205_Then; } else { goto anon1205_Else; }
anon1218_Then:
	assume !(r#294_$_0 == null);
	assume !(r#294_$_0 == null);
	assume wf(exhaleHeap#_823_$_0,Mask_$_32,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_33 == Mask_$_32[r#294_$_0,AVLTreeNode.keys := Mask_$_32[r#294_$_0,AVLTreeNode.keys][perm$R := Mask_$_32[r#294_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_33);
	assume IsGoodState(heapFragment(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_823_$_0,Mask_$_33,ZeroMask);
	assume wf(exhaleHeap#_823_$_0,Mask_$_33,ZeroMask);
	assume Mask_$_34 == Mask_$_33;
	if ($_$_condition_$78) { goto anon1219_Then; } else { goto anon1219_Else; }
anon1218_Else:
	assume r#294_$_0 == null;
	assume Mask_$_34 == Mask_$_32;
	if ($_$_condition_$79) { goto anon1219_Then; } else { goto anon1219_Else; }
anon808:
	assume IsGoodMask(exhaleMask#_899_$_6);
	assume wf(Heap_$_1,exhaleMask#_899_$_6,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_7 == exhaleMask#_899_$_6;
	if ($_$_condition_$80) { goto anon1267_Then; } else { goto anon1267_Else; }
anon936_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_12,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_13 == unfoldingMask#_538_$_12[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_538_$_12[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_538_$_12[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_13);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_13,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_13,ZeroMask);
	assume unfoldingMask#_538_$_14 == unfoldingMask#_538_$_13;
	if ($_$_condition_$81) { goto anon937_Then; } else { goto anon937_Else; }
anon936_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume unfoldingMask#_538_$_14 == unfoldingMask#_538_$_12;
	if ($_$_condition_$82) { goto anon937_Then; } else { goto anon937_Else; }
anon1070_Then:
	assume !CanRead(exhaleMask#_636_$_8,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_635_$_0[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon416;
anon1070_Else:
	assume CanRead(exhaleMask#_636_$_8,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon416;
anon417:
	assume IsGoodExhaleState(exhaleHeap#_635_$_0,Heap_$_1,exhaleMask#_636_$_9,ZeroMask);
	assume IsGoodMask(exhaleMask#_636_$_9);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_636_$_9,ZeroMask);
	assume true;
	assume !(this == null);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_636_$_9,ZeroMask);
	assume (exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_635_$_0[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume methodCallK#_634 > 0;
	assume Mask_$_87 == exhaleMask#_636_$_9[this,AVLTreeNode.left := exhaleMask#_636_$_9[this,AVLTreeNode.left][perm$R := exhaleMask#_636_$_9[this,AVLTreeNode.left][perm$R] + methodCallK#_634]];
	assume IsGoodMask(Mask_$_87);
	assume IsGoodState(heapFragment(exhaleHeap#_635_$_0[this,AVLTreeNode.left]));
	assume wf(exhaleHeap#_635_$_0,Mask_$_87,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_87,ZeroMask);
	if ($_$_condition_$103) { goto anon1071_Then; } else { goto anon1071_Else; }
anon1157_Then:
	assume !(r#271_$_0 == null);
	assume !(r#271_$_0 == null);
	assume wf(exhaleHeap#_724_$_0,Mask_$_64,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_65 == Mask_$_64[r#271_$_0,AVLTreeNode.height := Mask_$_64[r#271_$_0,AVLTreeNode.height][perm$R := Mask_$_64[r#271_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_65);
	assume IsGoodState(heapFragment(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_724_$_0,Mask_$_65,ZeroMask);
	assume wf(exhaleHeap#_724_$_0,Mask_$_65,ZeroMask);
	assume Mask_$_66 == Mask_$_65;
	if ($_$_condition_$83) { goto anon1158_Then; } else { goto anon1158_Else; }
anon1157_Else:
	assume r#271_$_0 == null;
	assume Mask_$_66 == Mask_$_64;
	if ($_$_condition_$84) { goto anon1158_Then; } else { goto anon1158_Else; }
anon1219_Then:
	assume !(r#294_$_0 == null);
	assume !(r#294_$_0 == null);
	assume wf(exhaleHeap#_823_$_0,Mask_$_34,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_35 == Mask_$_34[r#294_$_0,AVLTreeNode.height := Mask_$_34[r#294_$_0,AVLTreeNode.height][perm$R := Mask_$_34[r#294_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_35);
	assume IsGoodState(heapFragment(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_823_$_0,Mask_$_35,ZeroMask);
	assume wf(exhaleHeap#_823_$_0,Mask_$_35,ZeroMask);
	assume Mask_$_36 == Mask_$_35;
	if ($_$_condition_$87) { goto anon1220_Then; } else { goto anon1220_Else; }
anon1219_Else:
	assume r#294_$_0 == null;
	assume Mask_$_36 == Mask_$_34;
	if ($_$_condition_$88) { goto anon1220_Then; } else { goto anon1220_Else; }
anon937_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#228 : Integer :: ( ((0 <= lk#79#228) && (lk#79#228 < Seq#Length(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#228) < unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$91) { goto anon938_Then; } else { goto anon938_Else; }
anon937_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$92) { goto anon938_Then; } else { goto anon938_Else; }
anon416:
	assume IsGoodMask(exhaleMask#_636_$_8);
	assume wf(Heap_$_1,exhaleMask#_636_$_8,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_636_$_9 == exhaleMask#_636_$_8;
	goto anon417;
anon1158_Then:
	assume !(r#271_$_0 == null);
	assume !(r#271_$_0 == null);
	assume wf(exhaleHeap#_724_$_0,Mask_$_66,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_67 == Mask_$_66[r#271_$_0,AVLTreeNode.balanceFactor := Mask_$_66[r#271_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_66[r#271_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_67);
	assume IsGoodState(heapFragment(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_724_$_0,Mask_$_67,ZeroMask);
	assume wf(exhaleHeap#_724_$_0,Mask_$_67,ZeroMask);
	assume Mask_$_68 == Mask_$_67;
	if ($_$_condition_$93) { goto anon1159_Then; } else { goto anon1159_Else; }
anon1158_Else:
	assume r#271_$_0 == null;
	assume Mask_$_68 == Mask_$_66;
	if ($_$_condition_$94) { goto anon1159_Then; } else { goto anon1159_Else; }
anon1206_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  322.6: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  322.6: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_800_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_800_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_800_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_800_$_10 == exhaleMask#_800_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_800_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_800_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_800_$_10);
	assume wf(Heap_$_1,exhaleMask#_800_$_10,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_11 == exhaleMask#_800_$_10;
	if ($_$_condition_$95) { goto anon1207_Then; } else { goto anon1207_Else; }
anon1206_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_800_$_11 == exhaleMask#_800_$_9;
	if ($_$_condition_$96) { goto anon1207_Then; } else { goto anon1207_Else; }
anon1220_Then:
	assume !(r#294_$_0 == null);
	assume !(r#294_$_0 == null);
	assume wf(exhaleHeap#_823_$_0,Mask_$_36,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_37 == Mask_$_36[r#294_$_0,AVLTreeNode.balanceFactor := Mask_$_36[r#294_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_36[r#294_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_37);
	assume IsGoodState(heapFragment(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_823_$_0,Mask_$_37,ZeroMask);
	assume wf(exhaleHeap#_823_$_0,Mask_$_37,ZeroMask);
	assume Mask_$_38 == Mask_$_37;
	if ($_$_condition_$97) { goto anon1221_Then; } else { goto anon1221_Else; }
anon1220_Else:
	assume r#294_$_0 == null;
	assume Mask_$_38 == Mask_$_36;
	if ($_$_condition_$98) { goto anon1221_Then; } else { goto anon1221_Else; }
anon1268_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  340.6: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  340.6: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_899_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_899_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_899_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_899_$_10 == exhaleMask#_899_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_899_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_899_$_9[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_899_$_10);
	assume wf(Heap_$_1,exhaleMask#_899_$_10,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_11 == exhaleMask#_899_$_10;
	if ($_$_condition_$99) { goto anon1269_Then; } else { goto anon1269_Else; }
anon1268_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_899_$_11 == exhaleMask#_899_$_9;
	if ($_$_condition_$100) { goto anon1269_Then; } else { goto anon1269_Else; }
anon938_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$101) { goto anon939_Then; } else { goto anon939_Else; }
anon938_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$102) { goto anon939_Then; } else { goto anon939_Else; }
anon1159_Then:
	assume !(r#271_$_0 == null);
	assume !Seq#Contains(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$104) { goto anon1160_Then; } else { goto anon1160_Else; }
anon1159_Else:
	assume r#271_$_0 == null;
	if ($_$_condition_$105) { goto anon1160_Then; } else { goto anon1160_Else; }
anon1207_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  322.6: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  322.6: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_800_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_800_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_800_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_800_$_12 == exhaleMask#_800_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_800_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_800_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_800_$_12);
	assume wf(Heap_$_1,exhaleMask#_800_$_12,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_13 == exhaleMask#_800_$_12;
	if ($_$_condition_$106) { goto anon1208_Then; } else { goto anon1208_Else; }
anon1207_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_800_$_13 == exhaleMask#_800_$_11;
	if ($_$_condition_$107) { goto anon1208_Then; } else { goto anon1208_Else; }
anon1221_Then:
	assume !(r#294_$_0 == null);
	assume !Seq#Contains(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$108) { goto anon1222_Then; } else { goto anon1222_Else; }
anon1221_Else:
	assume r#294_$_0 == null;
	if ($_$_condition_$109) { goto anon1222_Then; } else { goto anon1222_Else; }
anon1269_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  340.6: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  340.6: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_899_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_899_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_899_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_899_$_12 == exhaleMask#_899_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_899_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_899_$_11[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_899_$_12);
	assume wf(Heap_$_1,exhaleMask#_899_$_12,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_13 == exhaleMask#_899_$_12;
	if ($_$_condition_$110) { goto anon1270_Then; } else { goto anon1270_Else; }
anon1269_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume exhaleMask#_899_$_13 == exhaleMask#_899_$_11;
	if ($_$_condition_$111) { goto anon1270_Then; } else { goto anon1270_Else; }
anon939_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_14,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_538_$_15 == unfoldingMask#_538_$_14[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := unfoldingMask#_538_$_14[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := unfoldingMask#_538_$_14[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_538_$_15);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_15,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_15,ZeroMask);
	assume unfoldingMask#_538_$_16 == unfoldingMask#_538_$_15;
	if ($_$_condition_$112) { goto anon940_Then; } else { goto anon940_Else; }
anon939_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_538_$_16 == unfoldingMask#_538_$_14;
	if ($_$_condition_$113) { goto anon940_Then; } else { goto anon940_Else; }
anon1071_Then:
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_635_$_0,Mask_$_87,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_88 == Mask_$_87[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_87[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_87[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_88);
	assume IsGoodState(heapFragment(exhaleHeap#_635_$_0[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_635_$_0,Mask_$_88,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_88,ZeroMask);
	assume Mask_$_89 == Mask_$_88;
	if ($_$_condition_$114) { goto anon1072_Then; } else { goto anon1072_Else; }
anon1071_Else:
	assume exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_89 == Mask_$_87;
	if ($_$_condition_$115) { goto anon1072_Then; } else { goto anon1072_Else; }
anon1160_Then:
	assume !(r#271_$_0 == null);
	assume (forall  i#84#272 : Integer :: ( ((0 <= i#84#272) && (i#84#272 < Seq#Length(Heap_$_1[this#269_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys],Seq#Index(Heap_$_1[this#269_$_0,AVLTreeNode.keys],i#84#272)) || (Seq#Index(Heap_$_1[this#269_$_0,AVLTreeNode.keys],i#84#272) == k#19)) ));
	if ($_$_condition_$116) { goto anon1161_Then; } else { goto anon1161_Else; }
anon1160_Else:
	assume r#271_$_0 == null;
	if ($_$_condition_$117) { goto anon1161_Then; } else { goto anon1161_Else; }
anon1208_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  322.6: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  322.6: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_800_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_800_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_800_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_800_$_14 == exhaleMask#_800_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_800_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_800_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$118) { goto anon1209_Then; } else { goto anon1209_Else; }
anon1208_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_800_$_15 == exhaleMask#_800_$_13;
	if ($_$_condition_$119) { goto anon1210_Then; } else { goto anon1210_Else; }
anon1222_Then:
	assume !(r#294_$_0 == null);
	assume (forall  i#84#295 : Integer :: ( ((0 <= i#84#295) && (i#84#295 < Seq#Length(Heap_$_1[this#292_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys],Seq#Index(Heap_$_1[this#292_$_0,AVLTreeNode.keys],i#84#295)) || (Seq#Index(Heap_$_1[this#292_$_0,AVLTreeNode.keys],i#84#295) == k#19)) ));
	if ($_$_condition_$120) { goto anon1223_Then; } else { goto anon1223_Else; }
anon1222_Else:
	assume r#294_$_0 == null;
	if ($_$_condition_$121) { goto anon1223_Then; } else { goto anon1223_Else; }
anon1270_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  340.6: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  340.6: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_899_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_899_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_899_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_899_$_14 == exhaleMask#_899_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_899_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_899_$_13[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$122) { goto anon1271_Then; } else { goto anon1271_Else; }
anon1270_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_899_$_15 == exhaleMask#_899_$_13;
	if ($_$_condition_$123) { goto anon1272_Then; } else { goto anon1272_Else; }
anon940_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_16,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_17 == unfoldingMask#_538_$_16[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := unfoldingMask#_538_$_16[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingMask#_538_$_16[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_17);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_17,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_17,ZeroMask);
	assume unfoldingMask#_538_$_18 == unfoldingMask#_538_$_17;
	if ($_$_condition_$124) { goto anon941_Then; } else { goto anon941_Else; }
anon940_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_538_$_18 == unfoldingMask#_538_$_16;
	if ($_$_condition_$125) { goto anon941_Then; } else { goto anon941_Else; }
anon1072_Then:
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_635_$_0,Mask_$_89,ZeroMask);
	assume true;
	assume methodCallK#_634 > 0;
	assume Mask_$_90 == Mask_$_89[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_89[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_89[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + methodCallK#_634]];
	assume IsGoodMask(Mask_$_90);
	assume IsGoodState(heapFragment(exhaleHeap#_635_$_0[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_635_$_0,Mask_$_90,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_90,ZeroMask);
	assume Mask_$_91 == Mask_$_90;
	goto anon421;
anon1072_Else:
	assume exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_91 == Mask_$_89;
	goto anon421;
anon1161_Then:
	assume !(r#271_$_0 == null);
	assume (forall  i#85#273 : Integer :: ( ((0 <= i#85#273) && (i#85#273 < Seq#Length(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],Seq#Index(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys],i#85#273)) && (!(Seq#Index(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys],i#85#273) == k#19))) ));
	if ($_$_condition_$126) { goto anon1162_Then; } else { goto anon1162_Else; }
anon1161_Else:
	assume r#271_$_0 == null;
	if ($_$_condition_$127) { goto anon1162_Then; } else { goto anon1162_Else; }
anon1209_Then:
	assume !CanRead(exhaleMask#_800_$_14,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_799_$_0[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon694;
anon1209_Else:
	assume CanRead(exhaleMask#_800_$_14,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon694;
anon1210_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  322.6: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  322.6: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_800_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_800_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_800_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_800_$_16 == exhaleMask#_800_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_800_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_800_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_800_$_16);
	assume wf(Heap_$_1,exhaleMask#_800_$_16,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_17 == exhaleMask#_800_$_16;
	if ($_$_condition_$145) { goto anon1211_Then; } else { goto anon1211_Else; }
anon1210_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_800_$_17 == exhaleMask#_800_$_15;
	if ($_$_condition_$146) { goto anon1211_Then; } else { goto anon1211_Else; }
anon1223_Then:
	assume !(r#294_$_0 == null);
	assume (forall  i#85#296 : Integer :: ( ((0 <= i#85#296) && (i#85#296 < Seq#Length(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],Seq#Index(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys],i#85#296)) && (!(Seq#Index(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys],i#85#296) == k#19))) ));
	if ($_$_condition_$128) { goto anon1224_Then; } else { goto anon1224_Else; }
anon1223_Else:
	assume r#294_$_0 == null;
	if ($_$_condition_$129) { goto anon1224_Then; } else { goto anon1224_Else; }
anon1271_Then:
	assume !CanRead(exhaleMask#_899_$_14,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_898_$_0[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon818;
anon1271_Else:
	assume CanRead(exhaleMask#_899_$_14,ZeroMask,Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon818;
anon1272_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  340.6: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  340.6: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_899_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_899_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_899_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_899_$_16 == exhaleMask#_899_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_899_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_899_$_15[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_899_$_16);
	assume wf(Heap_$_1,exhaleMask#_899_$_16,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_17 == exhaleMask#_899_$_16;
	if ($_$_condition_$149) { goto anon1273_Then; } else { goto anon1273_Else; }
anon1272_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_899_$_17 == exhaleMask#_899_$_15;
	if ($_$_condition_$150) { goto anon1273_Then; } else { goto anon1273_Else; }
anon941_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_18,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_19 == unfoldingMask#_538_$_18[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := unfoldingMask#_538_$_18[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingMask#_538_$_18[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_19);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_19,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_19,ZeroMask);
	assume unfoldingMask#_538_$_20 == unfoldingMask#_538_$_19;
	if ($_$_condition_$130) { goto anon942_Then; } else { goto anon942_Else; }
anon941_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_538_$_20 == unfoldingMask#_538_$_18;
	if ($_$_condition_$131) { goto anon942_Then; } else { goto anon942_Else; }
anon421:
	assume !(this == null);
	assume wf(exhaleHeap#_635_$_0,Mask_$_91,ZeroMask);
	assume (exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_635_$_0[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume methodCallK#_634 > 0;
	assume Mask_$_92 == Mask_$_91[this,AVLTreeNode.right := Mask_$_91[this,AVLTreeNode.right][perm$R := Mask_$_91[this,AVLTreeNode.right][perm$R] + methodCallK#_634]];
	assume IsGoodMask(Mask_$_92);
	assume IsGoodState(heapFragment(exhaleHeap#_635_$_0[this,AVLTreeNode.right]));
	assume wf(exhaleHeap#_635_$_0,Mask_$_92,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_92,ZeroMask);
	if ($_$_condition_$132) { goto anon1073_Then; } else { goto anon1073_Else; }
anon1162_Then:
	assume !Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	assume !(r#271_$_0 == null);
	if ($_$_condition_$133) { goto anon1163_Then; } else { goto anon1163_Else; }
anon1162_Else:
	assume Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$134) { goto anon1163_Then; } else { goto anon1163_Else; }
anon694:
	assume IsGoodMask(exhaleMask#_800_$_14);
	assume wf(Heap_$_1,exhaleMask#_800_$_14,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_15 == exhaleMask#_800_$_14;
	if ($_$_condition_$135) { goto anon1210_Then; } else { goto anon1210_Else; }
anon1224_Then:
	assume !Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	assume !(r#294_$_0 == null);
	if ($_$_condition_$136) { goto anon1225_Then; } else { goto anon1225_Else; }
anon1224_Else:
	assume Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$137) { goto anon1225_Then; } else { goto anon1225_Else; }
anon818:
	assume IsGoodMask(exhaleMask#_899_$_14);
	assume wf(Heap_$_1,exhaleMask#_899_$_14,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_15 == exhaleMask#_899_$_14;
	if ($_$_condition_$138) { goto anon1272_Then; } else { goto anon1272_Else; }
anon942_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_20,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_538_$_21 == unfoldingMask#_538_$_20[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingMask#_538_$_20[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_538_$_20[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_538_$_21);
	assume IsGoodState(heapFragment(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_21,ZeroMask);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_21,ZeroMask);
	assume unfoldingMask#_538_$_22 == unfoldingMask#_538_$_21;
	if ($_$_condition_$139) { goto anon943_Then; } else { goto anon943_Else; }
anon942_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume unfoldingMask#_538_$_22 == unfoldingMask#_538_$_20;
	if ($_$_condition_$140) { goto anon943_Then; } else { goto anon943_Else; }
anon1073_Then:
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_635_$_0,Mask_$_92,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_93 == Mask_$_92[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_92[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_92[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_93);
	assume IsGoodState(heapFragment(exhaleHeap#_635_$_0[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_635_$_0,Mask_$_93,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_93,ZeroMask);
	assume Mask_$_94 == Mask_$_93;
	if ($_$_condition_$141) { goto anon1074_Then; } else { goto anon1074_Else; }
anon1073_Else:
	assume exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_94 == Mask_$_92;
	if ($_$_condition_$142) { goto anon1074_Then; } else { goto anon1074_Else; }
anon1163_Then:
	assume !Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	assume Seq#Equal(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys],Heap_$_1[this#269_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$143) { goto anon1164_Then; } else { goto anon1164_Else; }
anon1163_Else:
	assume Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$144) { goto anon1164_Then; } else { goto anon1164_Else; }
anon1225_Then:
	assume !Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	assume Seq#Equal(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys],Heap_$_1[this#292_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$147) { goto anon1226_Then; } else { goto anon1226_Else; }
anon1225_Else:
	assume Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$148) { goto anon1226_Then; } else { goto anon1226_Else; }
anon943_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#229 : Integer :: ( ((0 <= rk#80#229) && (rk#80#229 < Seq#Length(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#229)) ));
	if ($_$_condition_$151) { goto anon944_Then; } else { goto anon944_Else; }
anon943_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$152) { goto anon944_Then; } else { goto anon944_Else; }
anon1074_Then:
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_635_$_0,Mask_$_94,ZeroMask);
	assume true;
	assume methodCallK#_634 > 0;
	assume Mask_$_95 == Mask_$_94[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_94[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_94[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + methodCallK#_634]];
	assume IsGoodMask(Mask_$_95);
	assume IsGoodState(heapFragment(exhaleHeap#_635_$_0[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_635_$_0,Mask_$_95,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_95,ZeroMask);
	assume Mask_$_96 == Mask_$_95;
	goto anon425;
anon1074_Else:
	assume exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_96 == Mask_$_94;
	goto anon425;
anon1164_Then:
	assume !(r#271_$_0 == null);
	if ($_$_condition_$153) { goto anon1165_Then; } else { goto anon1165_Else; }
anon1164_Else:
	assume r#271_$_0 == null;
	if ($_$_condition_$154) { goto anon1166_Then; } else { goto anon1166_Else; }
anon1211_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  322.6: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  322.6: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_800_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_800_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_800_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_800_$_18 == exhaleMask#_800_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_800_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_800_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_800_$_18);
	assume wf(Heap_$_1,exhaleMask#_800_$_18,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_19 == exhaleMask#_800_$_18;
	if ($_$_condition_$155) { goto anon1212_Then; } else { goto anon1212_Else; }
anon1211_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_800_$_19 == exhaleMask#_800_$_17;
	if ($_$_condition_$156) { goto anon1212_Then; } else { goto anon1212_Else; }
anon1226_Then:
	assume !(r#294_$_0 == null);
	if ($_$_condition_$157) { goto anon1227_Then; } else { goto anon1227_Else; }
anon1226_Else:
	assume r#294_$_0 == null;
	if ($_$_condition_$158) { goto anon1228_Then; } else { goto anon1228_Else; }
anon1273_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  340.6: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  340.6: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_899_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_899_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_899_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_899_$_18 == exhaleMask#_899_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_899_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_899_$_17[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_899_$_18);
	assume wf(Heap_$_1,exhaleMask#_899_$_18,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_19 == exhaleMask#_899_$_18;
	if ($_$_condition_$159) { goto anon1274_Then; } else { goto anon1274_Else; }
anon1273_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_899_$_19 == exhaleMask#_899_$_17;
	if ($_$_condition_$160) { goto anon1274_Then; } else { goto anon1274_Else; }
anon944_Then:
	assume !(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon163;
anon944_Else:
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon163;
anon425:
	assume bf#249_$_0 == (ite(exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_635_$_0[exhaleHeap#_635_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_635_$_0[exhaleHeap#_635_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	if ($_$_condition_$161) { goto anon1075_Then; } else { goto anon1075_Else; }
anon1165_Then:
	assume Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	assume Seq#Length(exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.keys]) == (Seq#Length(Heap_$_1[this#269_$_0,AVLTreeNode.keys]) - 1);
	if ($_$_condition_$162) { goto anon1166_Then; } else { goto anon1166_Else; }
anon1165_Else:
	assume !Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$163) { goto anon1166_Then; } else { goto anon1166_Else; }
anon1166_Then:
	assume Heap_$_1[this#269_$_0,AVLTreeNode.height] > 1;
	assume !(r#271_$_0 == null);
	if ($_$_condition_$169) { goto anon1167_Then; } else { goto anon1167_Else; }
anon1166_Else:
	assume 1 >= Heap_$_1[this#269_$_0,AVLTreeNode.height];
	if ($_$_condition_$170) { goto anon1167_Then; } else { goto anon1167_Else; }
anon1212_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  322.6: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  322.6: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_800_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_800_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_800_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_800_$_20 == exhaleMask#_800_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_800_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_800_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_800_$_20);
	assume wf(Heap_$_1,exhaleMask#_800_$_20,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_800_$_21 == exhaleMask#_800_$_20;
	goto anon701;
anon1212_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_800_$_21 == exhaleMask#_800_$_19;
	goto anon701;
anon1227_Then:
	assume Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	assume Seq#Length(exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.keys]) == (Seq#Length(Heap_$_1[this#292_$_0,AVLTreeNode.keys]) - 1);
	if ($_$_condition_$164) { goto anon1228_Then; } else { goto anon1228_Else; }
anon1227_Else:
	assume !Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	if ($_$_condition_$165) { goto anon1228_Then; } else { goto anon1228_Else; }
anon1228_Then:
	assume Heap_$_1[this#292_$_0,AVLTreeNode.height] > 1;
	assume !(r#294_$_0 == null);
	if ($_$_condition_$172) { goto anon1229_Then; } else { goto anon1229_Else; }
anon1228_Else:
	assume 1 >= Heap_$_1[this#292_$_0,AVLTreeNode.height];
	if ($_$_condition_$173) { goto anon1229_Then; } else { goto anon1229_Else; }
anon1274_Then:
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assert { :msg "  340.6: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  340.6: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_899_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_899_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_899_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_899_$_20 == exhaleMask#_899_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_899_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_899_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_899_$_20);
	assume wf(Heap_$_1,exhaleMask#_899_$_20,ZeroMask);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume exhaleMask#_899_$_21 == exhaleMask#_899_$_20;
	goto anon825;
anon1274_Else:
	assume Heap_$_1[this,AVLTreeNode.right] == null;
	assume exhaleMask#_899_$_21 == exhaleMask#_899_$_19;
	goto anon825;
anon163:
	assume Seq#Equal(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key])),ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$0 : Integer :: ( Seq#Contains(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$0) <==> ((((!(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$0)) || ((!(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$0))) || (kk#81_$0 == unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume unfoldingHeap#_537_$_1[unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume IsGoodMask(unfoldingMask#_538_$_22);
	assume wf(unfoldingHeap#_537_$_1,unfoldingMask#_538_$_22,ZeroMask);
	if ($_$_condition_$166) { goto anon945_Then; } else { goto anon945_Else; }
anon1075_Then:
	assume bf#249_$_0 > 0;
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null);
	if ($_$_condition_$167) { goto anon1076_Then; } else { goto anon1076_Else; }
anon1075_Else:
	assume 0 >= bf#249_$_0;
	if ($_$_condition_$168) { goto anon1076_Then; } else { goto anon1076_Else; }
anon701:
	assume IsGoodExhaleState(exhaleHeap#_799_$_0,Heap_$_1,exhaleMask#_800_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_800_$_21);
	assume wf(exhaleHeap#_799_$_0,exhaleMask#_800_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_799_$_0,exhaleMask#_800_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_57 == exhaleMask#_800_$_21[this,AVLTreeNode.valid := exhaleMask#_800_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_800_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_57);
	assume IsGoodState(heapFragment(exhaleHeap#_799_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_799_$_0,Mask_$_57,ZeroMask);
	assume wf(exhaleHeap#_799_$_0,Mask_$_57,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_799_$_0,Mask_$_57,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_58 == Mask_$_57[this,AVLTreeNode.height := Mask_$_57[this,AVLTreeNode.height][perm$R := Mask_$_57[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_58);
	assume IsGoodState(heapFragment(exhaleHeap#_799_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_799_$_0,Mask_$_58,ZeroMask);
	assume wf(exhaleHeap#_799_$_0,Mask_$_58,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_799_$_0,Mask_$_58,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_59 == Mask_$_58[this,AVLTreeNode.keys := Mask_$_58[this,AVLTreeNode.keys][perm$R := Mask_$_58[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_59);
	assume IsGoodState(heapFragment(exhaleHeap#_799_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_799_$_0,Mask_$_59,ZeroMask);
	assume wf(exhaleHeap#_799_$_0,Mask_$_59,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_799_$_0,Mask_$_59,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_60 == Mask_$_59[this,AVLTreeNode.balanceFactor := Mask_$_59[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_59[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_60);
	assume IsGoodState(heapFragment(exhaleHeap#_799_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_799_$_0,Mask_$_60,ZeroMask);
	assume wf(exhaleHeap#_799_$_0,Mask_$_60,ZeroMask);
	assume Seq#Equal(exhaleHeap#_799_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[this,AVLTreeNode.key])),ite(Heap_$_1[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_799_$_0[this,AVLTreeNode.height] == ite(ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_799_$_0[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_60);
	assume wf(exhaleHeap#_799_$_0,Mask_$_60,ZeroMask);
	assume Mask_$_149 == Mask_$_60;
	assume Heap_$_9 == exhaleHeap#_799_$_0;
	assume r#20_$_3 == this;
	if ($_$_condition_$171) { goto anon1275_Then; } else { goto anon1275_Else; }
anon825:
	assume IsGoodExhaleState(exhaleHeap#_898_$_0,Heap_$_1,exhaleMask#_899_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_899_$_21);
	assume wf(exhaleHeap#_898_$_0,exhaleMask#_899_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_898_$_0,exhaleMask#_899_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_27 == exhaleMask#_899_$_21[this,AVLTreeNode.valid := exhaleMask#_899_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_899_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_27);
	assume IsGoodState(heapFragment(exhaleHeap#_898_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_898_$_0,Mask_$_27,ZeroMask);
	assume wf(exhaleHeap#_898_$_0,Mask_$_27,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_898_$_0,Mask_$_27,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_28 == Mask_$_27[this,AVLTreeNode.height := Mask_$_27[this,AVLTreeNode.height][perm$R := Mask_$_27[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_28);
	assume IsGoodState(heapFragment(exhaleHeap#_898_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_898_$_0,Mask_$_28,ZeroMask);
	assume wf(exhaleHeap#_898_$_0,Mask_$_28,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_898_$_0,Mask_$_28,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_29 == Mask_$_28[this,AVLTreeNode.keys := Mask_$_28[this,AVLTreeNode.keys][perm$R := Mask_$_28[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_29);
	assume IsGoodState(heapFragment(exhaleHeap#_898_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_898_$_0,Mask_$_29,ZeroMask);
	assume wf(exhaleHeap#_898_$_0,Mask_$_29,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_898_$_0,Mask_$_29,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_30 == Mask_$_29[this,AVLTreeNode.balanceFactor := Mask_$_29[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_29[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_30);
	assume IsGoodState(heapFragment(exhaleHeap#_898_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_898_$_0,Mask_$_30,ZeroMask);
	assume wf(exhaleHeap#_898_$_0,Mask_$_30,ZeroMask);
	assume Seq#Equal(exhaleHeap#_898_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[this,AVLTreeNode.key])),ite(Heap_$_1[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_898_$_0[this,AVLTreeNode.height] == ite(ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_898_$_0[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_1[this,AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[this,AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_30);
	assume wf(exhaleHeap#_898_$_0,Mask_$_30,ZeroMask);
	assume Mask_$_149 == Mask_$_30;
	assume Heap_$_9 == exhaleHeap#_898_$_0;
	assume r#20_$_3 == this;
	if ($_$_condition_$174) { goto anon1275_Then; } else { goto anon1275_Else; }
anon945_Then:
	assume false;
	goto $exit;
anon945_Else:
	assume !false;
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume assertSecMask#_533_$_0 == ZeroMask[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key := ZeroMask[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := ZeroMask[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_0);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_0);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_0);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_1 == assertSecMask#_533_$_0[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_533_$_0[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_533_$_0[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_1);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_1);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_1);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_533_$_2 == assertSecMask#_533_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left := assertSecMask#_533_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := assertSecMask#_533_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_2);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_2);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_2);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_533_$_3 == assertSecMask#_533_$_2[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right := assertSecMask#_533_$_2[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := assertSecMask#_533_$_2[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_3);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_3);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_3);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_4 == assertSecMask#_533_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_533_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_533_$_3[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_4);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_4);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_4);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_5 == assertSecMask#_533_$_4[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_533_$_4[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533_$_4[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_5);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_5);
	if ($_$_condition_$175) { goto anon972_Then; } else { goto anon972_Else; }
anon1076_Then:
	assume bf#249_$_0 < 0;
	assume !(exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null);
	goto anon429;
anon1076_Else:
	assume 0 <= bf#249_$_0;
	goto anon429;
anon1167_Then:
	assume !(r#271_$_0 == null);
	assume (exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.height] == Heap_$_1[this#269_$_0,AVLTreeNode.height]) || ((exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.height] + 1) == Heap_$_1[this#269_$_0,AVLTreeNode.height]);
	if ($_$_condition_$176) { goto anon1168_Then; } else { goto anon1168_Else; }
anon1167_Else:
	assume r#271_$_0 == null;
	if ($_$_condition_$177) { goto anon1168_Then; } else { goto anon1168_Else; }
anon1275_Then:
	assume Seq#Equal(Heap[this,AVLTreeNode.keys],Seq#Singleton(k#19));
	assert { :msg "  253.2: The postcondition at 259.11 might not hold. The expression at 259.30 might not evaluate to true." } r#20_$_3 == null;
	if ($_$_condition_$436) { goto anon1276_Then; } else { goto anon1276_Else; }
anon1275_Else:
	assume !Seq#Equal(Heap[this,AVLTreeNode.keys],Seq#Singleton(k#19));
	if ($_$_condition_$437) { goto anon1276_Then; } else { goto anon1276_Else; }
anon1229_Then:
	assume !(r#294_$_0 == null);
	assume (exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.height] == Heap_$_1[this#292_$_0,AVLTreeNode.height]) || ((exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.height] + 1) == Heap_$_1[this#292_$_0,AVLTreeNode.height]);
	if ($_$_condition_$178) { goto anon1230_Then; } else { goto anon1230_Else; }
anon1229_Else:
	assume r#294_$_0 == null;
	if ($_$_condition_$179) { goto anon1230_Then; } else { goto anon1230_Else; }
anon972_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_5);
	assume Fractions(100) > 0;
	assume assertSecMask#_533_$_6 == assertSecMask#_533_$_5[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := assertSecMask#_533_$_5[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := assertSecMask#_533_$_5[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_6);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_6);
	assume assertSecMask#_533_$_7 == assertSecMask#_533_$_6;
	if ($_$_condition_$180) { goto anon973_Then; } else { goto anon973_Else; }
anon972_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_533_$_7 == assertSecMask#_533_$_5;
	if ($_$_condition_$181) { goto anon973_Then; } else { goto anon973_Else; }
anon429:
	assume IsGoodMask(Mask_$_96);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assume cond#_645_$_0 <==> (bf#249_$_0 > 0);
	if ($_$_condition_$182) { goto anon1077_Then; } else { goto anon1077_Else; }
anon1168_Then:
	assume !Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	assume exhaleHeap#_724_$_0[r#271_$_0,AVLTreeNode.height] == Heap_$_1[this#269_$_0,AVLTreeNode.height];
	goto anon612;
anon1168_Else:
	assume Seq#Contains(Heap_$_1[this#269_$_0,AVLTreeNode.keys],k#19);
	goto anon612;
anon1230_Then:
	assume !Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	assume exhaleHeap#_823_$_0[r#294_$_0,AVLTreeNode.height] == Heap_$_1[this#292_$_0,AVLTreeNode.height];
	goto anon736;
anon1230_Else:
	assume Seq#Contains(Heap_$_1[this#292_$_0,AVLTreeNode.keys],k#19);
	goto anon736;
anon973_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_7);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_8 == assertSecMask#_533_$_7[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_533_$_7[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_533_$_7[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_8);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_8);
	assume assertSecMask#_533_$_9 == assertSecMask#_533_$_8;
	if ($_$_condition_$183) { goto anon974_Then; } else { goto anon974_Else; }
anon973_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_533_$_9 == assertSecMask#_533_$_7;
	if ($_$_condition_$184) { goto anon974_Then; } else { goto anon974_Else; }
anon1077_Then:
	assume cond#_645_$_0;
	assume ((0 < methodCallK#_650) && ((1000 * methodCallK#_650) < Fractions(1))) && ((1000 * methodCallK#_650) < methodK#_506);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  295.19: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  295.19: Location might not be readable." } true ==> CanRead(Mask_$_96,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  295.6: The target of the method call might be null." } !(exhaleHeap#_635_$_0[this,AVLTreeNode.left] == null);
	assume this#250_$_0 == exhaleHeap#_635_$_0[this,AVLTreeNode.left];
	assert { :msg "  295.6: The precondition at 349.12 might not hold. The permission at 349.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  295.6: The precondition at 349.12 might not hold. Insufficient fraction at 349.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_96[this#250_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_96[this#250_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_96[this#250_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_652_$_0 == Mask_$_96[this#250_$_0,AVLTreeNode.valid := Mask_$_96[this#250_$_0,AVLTreeNode.valid][perm$R := Mask_$_96[this#250_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$185) { goto anon1078_Then; } else { goto anon1078_Else; }
anon1077_Else:
	assume !cond#_645_$_0;
	assume ((0 < methodCallK#_663) && ((1000 * methodCallK#_663) < Fractions(1))) && ((1000 * methodCallK#_663) < methodK#_506);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  297.19: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  297.19: Location might not be readable." } true ==> CanRead(Mask_$_96,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  297.6: The target of the method call might be null." } !(exhaleHeap#_635_$_0[this,AVLTreeNode.right] == null);
	assume this#254_$_0 == exhaleHeap#_635_$_0[this,AVLTreeNode.right];
	assert { :msg "  297.6: The precondition at 404.12 might not hold. The permission at 404.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  297.6: The precondition at 404.12 might not hold. Insufficient fraction at 404.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_96[this#254_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_96[this#254_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_96[this#254_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_665_$_0 == Mask_$_96[this#254_$_0,AVLTreeNode.valid := Mask_$_96[this#254_$_0,AVLTreeNode.valid][perm$R := Mask_$_96[this#254_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$186) { goto anon1088_Then; } else { goto anon1088_Else; }
anon612:
	assume IsGoodMask(Mask_$_68);
	assume wf(exhaleHeap#_724_$_0,Mask_$_68,ZeroMask);
	assert { :msg "  309.6: Location might not be writable" } CanWrite(Mask_$_68,this,AVLTreeNode.left);
	assume Heap_$_3 == exhaleHeap#_724_$_0[this,AVLTreeNode.left := r#271_$_0];
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	assume ((0 < methodCallK#_736) && ((1000 * methodCallK#_736) < Fractions(1))) && ((1000 * methodCallK#_736) < methodK#_506);
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	assert { :msg "  312.6: The target of the method call might be null." } !(this == null);
	assert { :msg "  312.6: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive." } methodCallK#_736 > 0;
	assert { :msg "  312.6: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left." } Mask_$_68[this,AVLTreeNode.left][perm$R] > 0;
	assume methodCallK#_736 < Mask_$_68[this,AVLTreeNode.left][perm$R];
	assume exhaleMask#_738_$_0 == Mask_$_68[this,AVLTreeNode.left := Mask_$_68[this,AVLTreeNode.left][perm$R := Mask_$_68[this,AVLTreeNode.left][perm$R] - methodCallK#_736]];
	assume IsGoodMask(exhaleMask#_738_$_0);
	assume wf(Heap_$_3,exhaleMask#_738_$_0,ZeroMask);
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	if ($_$_condition_$187) { goto anon1169_Then; } else { goto anon1169_Else; }
anon736:
	assume IsGoodMask(Mask_$_38);
	assume wf(exhaleHeap#_823_$_0,Mask_$_38,ZeroMask);
	assert { :msg "  328.6: Location might not be writable" } CanWrite(Mask_$_38,this,AVLTreeNode.right);
	assume Heap_$_2 == exhaleHeap#_823_$_0[this,AVLTreeNode.right := r#294_$_0];
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	assume ((0 < methodCallK#_835) && ((1000 * methodCallK#_835) < Fractions(1))) && ((1000 * methodCallK#_835) < methodK#_506);
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	assert { :msg "  331.6: The target of the method call might be null." } !(this == null);
	assert { :msg "  331.6: The precondition at 511.12 might not hold. The permission at 511.12 might not be positive." } methodCallK#_835 > 0;
	assert { :msg "  331.6: The precondition at 511.12 might not hold. Insufficient fraction at 511.12 for AVLTreeNode.left." } Mask_$_38[this,AVLTreeNode.left][perm$R] > 0;
	assume methodCallK#_835 < Mask_$_38[this,AVLTreeNode.left][perm$R];
	assume exhaleMask#_837_$_0 == Mask_$_38[this,AVLTreeNode.left := Mask_$_38[this,AVLTreeNode.left][perm$R := Mask_$_38[this,AVLTreeNode.left][perm$R] - methodCallK#_835]];
	assume IsGoodMask(exhaleMask#_837_$_0);
	assume wf(Heap_$_2,exhaleMask#_837_$_0,ZeroMask);
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	if ($_$_condition_$188) { goto anon1231_Then; } else { goto anon1231_Else; }
anon974_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_9);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_10 == assertSecMask#_533_$_9[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_533_$_9[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_533_$_9[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_10);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_10);
	assume assertSecMask#_533_$_11 == assertSecMask#_533_$_10;
	if ($_$_condition_$189) { goto anon975_Then; } else { goto anon975_Else; }
anon974_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_533_$_11 == assertSecMask#_533_$_9;
	if ($_$_condition_$190) { goto anon975_Then; } else { goto anon975_Else; }
anon1078_Then:
	assume !CanRead(exhaleMask#_652_$_0,ZeroMask,this#250_$_0,AVLTreeNode.valid);
	assume exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.valid] < exhaleHeap#_651_$_0[this#250_$_0,AVLTreeNode.valid];
	goto anon432;
anon1078_Else:
	assume CanRead(exhaleMask#_652_$_0,ZeroMask,this#250_$_0,AVLTreeNode.valid);
	goto anon432;
anon1088_Then:
	assume !CanRead(exhaleMask#_665_$_0,ZeroMask,this#254_$_0,AVLTreeNode.valid);
	assume exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.valid] < exhaleHeap#_664_$_0[this#254_$_0,AVLTreeNode.valid];
	goto anon453;
anon1088_Else:
	assume CanRead(exhaleMask#_665_$_0,ZeroMask,this#254_$_0,AVLTreeNode.valid);
	goto anon453;
anon1169_Then:
	assume !(Heap_$_3[this,AVLTreeNode.left] == null);
	assert { :msg "  312.6: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive." } methodCallK#_736 > 0;
	assert { :msg "  312.6: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height." } exhaleMask#_738_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_736 < exhaleMask#_738_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume exhaleMask#_738_$_1 == exhaleMask#_738_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_738_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_738_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - methodCallK#_736]];
	assume IsGoodMask(exhaleMask#_738_$_1);
	assume wf(Heap_$_3,exhaleMask#_738_$_1,ZeroMask);
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	assume exhaleMask#_738_$_2 == exhaleMask#_738_$_1;
	goto anon614;
anon1169_Else:
	assume Heap_$_3[this,AVLTreeNode.left] == null;
	assume exhaleMask#_738_$_2 == exhaleMask#_738_$_0;
	goto anon614;
anon1231_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  331.6: The precondition at 513.12 might not hold. The permission at 513.27 might not be positive." } methodCallK#_835 > 0;
	assert { :msg "  331.6: The precondition at 513.12 might not hold. Insufficient fraction at 513.27 for AVLTreeNode.height." } exhaleMask#_837_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_835 < exhaleMask#_837_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R];
	assume exhaleMask#_837_$_1 == exhaleMask#_837_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_837_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_837_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - methodCallK#_835]];
	assume IsGoodMask(exhaleMask#_837_$_1);
	assume wf(Heap_$_2,exhaleMask#_837_$_1,ZeroMask);
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	assume exhaleMask#_837_$_2 == exhaleMask#_837_$_1;
	goto anon738;
anon1231_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_837_$_2 == exhaleMask#_837_$_0;
	goto anon738;
anon975_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_11);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_12 == assertSecMask#_533_$_11[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_533_$_11[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533_$_11[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_12);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_12);
	assume assertSecMask#_533_$_13 == assertSecMask#_533_$_12;
	if ($_$_condition_$191) { goto anon976_Then; } else { goto anon976_Else; }
anon975_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume assertSecMask#_533_$_13 == assertSecMask#_533_$_11;
	if ($_$_condition_$192) { goto anon976_Then; } else { goto anon976_Else; }
anon432:
	assume IsGoodMask(exhaleMask#_652_$_0);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_652_$_0,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  295.6: The precondition at 350.12 might not hold. The permission at 350.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  295.6: The precondition at 350.12 might not hold. Insufficient fraction at 350.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_652_$_0[this#250_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_652_$_0[this#250_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_652_$_0[this#250_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_652_$_1 == exhaleMask#_652_$_0[this#250_$_0,AVLTreeNode.keys := exhaleMask#_652_$_0[this#250_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_652_$_0[this#250_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_652_$_1);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_652_$_1,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  295.6: The precondition at 351.12 might not hold. The permission at 351.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  295.6: The precondition at 351.12 might not hold. Insufficient fraction at 351.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_652_$_1[this#250_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_652_$_1[this#250_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_652_$_1[this#250_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_652_$_2 == exhaleMask#_652_$_1[this#250_$_0,AVLTreeNode.height := exhaleMask#_652_$_1[this#250_$_0,AVLTreeNode.height][perm$R := exhaleMask#_652_$_1[this#250_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_652_$_2);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_652_$_2,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  295.6: The precondition at 352.12 might not hold. The permission at 352.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  295.6: The precondition at 352.12 might not hold. Insufficient fraction at 352.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_652_$_2[this#250_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_652_$_2[this#250_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_652_$_2[this#250_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_652_$_3 == exhaleMask#_652_$_2[this#250_$_0,AVLTreeNode.balanceFactor := exhaleMask#_652_$_2[this#250_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_652_$_2[this#250_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_652_$_3);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_652_$_3,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_651_$_0,exhaleHeap#_635_$_0,exhaleMask#_652_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_652_$_3);
	assume wf(exhaleHeap#_651_$_0,exhaleMask#_652_$_3,ZeroMask);
	assume (r#251_$_0 == null) || (dtype(r#251_$_0) == AVLTreeNode#t);
	assume (m#252_$_0 == null) || (dtype(m#252_$_0) == AVLTreeNode#t);
	if ($_$_condition_$193) { goto anon1079_Then; } else { goto anon1079_Else; }
anon453:
	assume IsGoodMask(exhaleMask#_665_$_0);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_665_$_0,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  297.6: The precondition at 405.12 might not hold. The permission at 405.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  297.6: The precondition at 405.12 might not hold. Insufficient fraction at 405.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_665_$_0[this#254_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_665_$_0[this#254_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_665_$_0[this#254_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_665_$_1 == exhaleMask#_665_$_0[this#254_$_0,AVLTreeNode.keys := exhaleMask#_665_$_0[this#254_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_665_$_0[this#254_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_665_$_1);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_665_$_1,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  297.6: The precondition at 406.12 might not hold. The permission at 406.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  297.6: The precondition at 406.12 might not hold. Insufficient fraction at 406.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_665_$_1[this#254_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_665_$_1[this#254_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_665_$_1[this#254_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_665_$_2 == exhaleMask#_665_$_1[this#254_$_0,AVLTreeNode.height := exhaleMask#_665_$_1[this#254_$_0,AVLTreeNode.height][perm$R := exhaleMask#_665_$_1[this#254_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_665_$_2);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_665_$_2,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assert { :msg "  297.6: The precondition at 407.12 might not hold. The permission at 407.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  297.6: The precondition at 407.12 might not hold. Insufficient fraction at 407.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_665_$_2[this#254_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_665_$_2[this#254_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_665_$_2[this#254_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_665_$_3 == exhaleMask#_665_$_2[this#254_$_0,AVLTreeNode.balanceFactor := exhaleMask#_665_$_2[this#254_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_665_$_2[this#254_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_665_$_3);
	assume wf(exhaleHeap#_635_$_0,exhaleMask#_665_$_3,ZeroMask);
	assume wf(exhaleHeap#_635_$_0,Mask_$_96,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_664_$_0,exhaleHeap#_635_$_0,exhaleMask#_665_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_665_$_3);
	assume wf(exhaleHeap#_664_$_0,exhaleMask#_665_$_3,ZeroMask);
	assume (r#255_$_0 == null) || (dtype(r#255_$_0) == AVLTreeNode#t);
	assume (m#256_$_0 == null) || (dtype(m#256_$_0) == AVLTreeNode#t);
	if ($_$_condition_$194) { goto anon1089_Then; } else { goto anon1089_Else; }
anon614:
	assert { :msg "  312.6: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive." } methodCallK#_736 > 0;
	assert { :msg "  312.6: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right." } exhaleMask#_738_$_2[this,AVLTreeNode.right][perm$R] > 0;
	assume methodCallK#_736 < exhaleMask#_738_$_2[this,AVLTreeNode.right][perm$R];
	assume exhaleMask#_738_$_3 == exhaleMask#_738_$_2[this,AVLTreeNode.right := exhaleMask#_738_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_738_$_2[this,AVLTreeNode.right][perm$R] - methodCallK#_736]];
	assume IsGoodMask(exhaleMask#_738_$_3);
	assume wf(Heap_$_3,exhaleMask#_738_$_3,ZeroMask);
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	if ($_$_condition_$195) { goto anon1170_Then; } else { goto anon1170_Else; }
anon738:
	assert { :msg "  331.6: The precondition at 515.12 might not hold. The permission at 515.12 might not be positive." } methodCallK#_835 > 0;
	assert { :msg "  331.6: The precondition at 515.12 might not hold. Insufficient fraction at 515.12 for AVLTreeNode.right." } exhaleMask#_837_$_2[this,AVLTreeNode.right][perm$R] > 0;
	assume methodCallK#_835 < exhaleMask#_837_$_2[this,AVLTreeNode.right][perm$R];
	assume exhaleMask#_837_$_3 == exhaleMask#_837_$_2[this,AVLTreeNode.right := exhaleMask#_837_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_837_$_2[this,AVLTreeNode.right][perm$R] - methodCallK#_835]];
	assume IsGoodMask(exhaleMask#_837_$_3);
	assume wf(Heap_$_2,exhaleMask#_837_$_3,ZeroMask);
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	if ($_$_condition_$196) { goto anon1232_Then; } else { goto anon1232_Else; }
anon976_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#234 : Integer :: ( ((0 <= lk#79#234) && (lk#79#234 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#234) < Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$197) { goto anon977_Then; } else { goto anon977_Else; }
anon976_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$198) { goto anon977_Then; } else { goto anon977_Else; }
anon1079_Then:
	assume !(r#251_$_0 == null);
	assume !(r#251_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,exhaleMask#_652_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_109 == exhaleMask#_652_$_3[r#251_$_0,AVLTreeNode.valid := exhaleMask#_652_$_3[r#251_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_652_$_3[r#251_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_109);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_109,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_109,ZeroMask);
	assume Mask_$_110 == Mask_$_109;
	if ($_$_condition_$199) { goto anon1080_Then; } else { goto anon1080_Else; }
anon1079_Else:
	assume r#251_$_0 == null;
	assume Mask_$_110 == exhaleMask#_652_$_3;
	if ($_$_condition_$200) { goto anon1080_Then; } else { goto anon1080_Else; }
anon1089_Then:
	assume !(r#255_$_0 == null);
	assume !(r#255_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,exhaleMask#_665_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_97 == exhaleMask#_665_$_3[r#255_$_0,AVLTreeNode.valid := exhaleMask#_665_$_3[r#255_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_665_$_3[r#255_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_97);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_97,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_97,ZeroMask);
	assume Mask_$_98 == Mask_$_97;
	if ($_$_condition_$201) { goto anon1090_Then; } else { goto anon1090_Else; }
anon1089_Else:
	assume r#255_$_0 == null;
	assume Mask_$_98 == exhaleMask#_665_$_3;
	if ($_$_condition_$202) { goto anon1090_Then; } else { goto anon1090_Else; }
anon1170_Then:
	assume !(Heap_$_3[this,AVLTreeNode.right] == null);
	assert { :msg "  312.6: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive." } methodCallK#_736 > 0;
	assert { :msg "  312.6: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height." } exhaleMask#_738_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_736 < exhaleMask#_738_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume exhaleMask#_738_$_4 == exhaleMask#_738_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_738_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_738_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - methodCallK#_736]];
	assume IsGoodMask(exhaleMask#_738_$_4);
	assume wf(Heap_$_3,exhaleMask#_738_$_4,ZeroMask);
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	assume exhaleMask#_738_$_5 == exhaleMask#_738_$_4;
	if ($_$_condition_$203) { goto anon1171_Then; } else { goto anon1171_Else; }
anon1170_Else:
	assume Heap_$_3[this,AVLTreeNode.right] == null;
	assume exhaleMask#_738_$_5 == exhaleMask#_738_$_3;
	if ($_$_condition_$204) { goto anon1171_Then; } else { goto anon1171_Else; }
anon1232_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  331.6: The precondition at 517.12 might not hold. The permission at 517.28 might not be positive." } methodCallK#_835 > 0;
	assert { :msg "  331.6: The precondition at 517.12 might not hold. Insufficient fraction at 517.28 for AVLTreeNode.height." } exhaleMask#_837_$_3[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] > 0;
	assume methodCallK#_835 < exhaleMask#_837_$_3[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R];
	assume exhaleMask#_837_$_4 == exhaleMask#_837_$_3[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_837_$_3[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_837_$_3[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - methodCallK#_835]];
	assume IsGoodMask(exhaleMask#_837_$_4);
	assume wf(Heap_$_2,exhaleMask#_837_$_4,ZeroMask);
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	assume exhaleMask#_837_$_5 == exhaleMask#_837_$_4;
	if ($_$_condition_$205) { goto anon1233_Then; } else { goto anon1233_Else; }
anon1232_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_837_$_5 == exhaleMask#_837_$_3;
	if ($_$_condition_$206) { goto anon1233_Then; } else { goto anon1233_Else; }
anon977_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$207) { goto anon978_Then; } else { goto anon978_Else; }
anon977_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$208) { goto anon978_Then; } else { goto anon978_Else; }
anon1080_Then:
	assume !(r#251_$_0 == null);
	assume !(r#251_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,Mask_$_110,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_111 == Mask_$_110[r#251_$_0,AVLTreeNode.keys := Mask_$_110[r#251_$_0,AVLTreeNode.keys][perm$R := Mask_$_110[r#251_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_111);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_111,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_111,ZeroMask);
	assume Mask_$_112 == Mask_$_111;
	if ($_$_condition_$209) { goto anon1081_Then; } else { goto anon1081_Else; }
anon1080_Else:
	assume r#251_$_0 == null;
	assume Mask_$_112 == Mask_$_110;
	if ($_$_condition_$210) { goto anon1081_Then; } else { goto anon1081_Else; }
anon1090_Then:
	assume !(r#255_$_0 == null);
	assume !(r#255_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,Mask_$_98,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_99 == Mask_$_98[r#255_$_0,AVLTreeNode.keys := Mask_$_98[r#255_$_0,AVLTreeNode.keys][perm$R := Mask_$_98[r#255_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_99);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_99,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_99,ZeroMask);
	assume Mask_$_100 == Mask_$_99;
	if ($_$_condition_$211) { goto anon1091_Then; } else { goto anon1091_Else; }
anon1090_Else:
	assume r#255_$_0 == null;
	assume Mask_$_100 == Mask_$_98;
	if ($_$_condition_$212) { goto anon1091_Then; } else { goto anon1091_Else; }
anon1171_Then:
	assume !(Heap_$_3[this,AVLTreeNode.left] == null);
	assert { :msg "  312.6: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  312.6: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_738_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_738_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_738_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_738_$_6 == exhaleMask#_738_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_738_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_738_$_5[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$213) { goto anon1172_Then; } else { goto anon1172_Else; }
anon1171_Else:
	assume Heap_$_3[this,AVLTreeNode.left] == null;
	assume exhaleMask#_738_$_7 == exhaleMask#_738_$_5;
	if ($_$_condition_$214) { goto anon1173_Then; } else { goto anon1173_Else; }
anon1233_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  331.6: The precondition at 512.12 might not hold. The permission at 512.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  331.6: The precondition at 512.12 might not hold. Insufficient fraction at 512.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_837_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_837_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_837_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_837_$_6 == exhaleMask#_837_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_837_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_837_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$215) { goto anon1234_Then; } else { goto anon1234_Else; }
anon1233_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_837_$_7 == exhaleMask#_837_$_5;
	if ($_$_condition_$216) { goto anon1235_Then; } else { goto anon1235_Else; }
anon978_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_13);
	assume Fractions(100) > 0;
	assume assertSecMask#_533_$_14 == assertSecMask#_533_$_13[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := assertSecMask#_533_$_13[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := assertSecMask#_533_$_13[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_14);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_14);
	assume assertSecMask#_533_$_15 == assertSecMask#_533_$_14;
	if ($_$_condition_$217) { goto anon979_Then; } else { goto anon979_Else; }
anon978_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_533_$_15 == assertSecMask#_533_$_13;
	if ($_$_condition_$218) { goto anon979_Then; } else { goto anon979_Else; }
anon1081_Then:
	assume !(r#251_$_0 == null);
	assume !(r#251_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,Mask_$_112,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_113 == Mask_$_112[r#251_$_0,AVLTreeNode.height := Mask_$_112[r#251_$_0,AVLTreeNode.height][perm$R := Mask_$_112[r#251_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_113);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_113,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_113,ZeroMask);
	assume Mask_$_114 == Mask_$_113;
	if ($_$_condition_$219) { goto anon1082_Then; } else { goto anon1082_Else; }
anon1081_Else:
	assume r#251_$_0 == null;
	assume Mask_$_114 == Mask_$_112;
	if ($_$_condition_$220) { goto anon1082_Then; } else { goto anon1082_Else; }
anon1091_Then:
	assume !(r#255_$_0 == null);
	assume !(r#255_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,Mask_$_100,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_101 == Mask_$_100[r#255_$_0,AVLTreeNode.height := Mask_$_100[r#255_$_0,AVLTreeNode.height][perm$R := Mask_$_100[r#255_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_101);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_101,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_101,ZeroMask);
	assume Mask_$_102 == Mask_$_101;
	if ($_$_condition_$221) { goto anon1092_Then; } else { goto anon1092_Else; }
anon1091_Else:
	assume r#255_$_0 == null;
	assume Mask_$_102 == Mask_$_100;
	if ($_$_condition_$222) { goto anon1092_Then; } else { goto anon1092_Else; }
anon1172_Then:
	assume !CanRead(exhaleMask#_738_$_6,ZeroMask,Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_737_$_0[Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon619;
anon1172_Else:
	assume CanRead(exhaleMask#_738_$_6,ZeroMask,Heap_$_3[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon619;
anon1173_Then:
	assume !(Heap_$_3[this,AVLTreeNode.right] == null);
	assert { :msg "  312.6: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  312.6: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_738_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_738_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_738_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_738_$_8 == exhaleMask#_738_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_738_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_738_$_7[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$237) { goto anon1174_Then; } else { goto anon1174_Else; }
anon1173_Else:
	assume Heap_$_3[this,AVLTreeNode.right] == null;
	assume exhaleMask#_738_$_9 == exhaleMask#_738_$_7;
	goto anon624;
anon1234_Then:
	assume !CanRead(exhaleMask#_837_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_836_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon743;
anon1234_Else:
	assume CanRead(exhaleMask#_837_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon743;
anon1235_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  331.6: The precondition at 516.12 might not hold. The permission at 516.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  331.6: The precondition at 516.12 might not hold. Insufficient fraction at 516.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_837_$_7[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_837_$_7[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_837_$_7[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_837_$_8 == exhaleMask#_837_$_7[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_837_$_7[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_837_$_7[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$238) { goto anon1236_Then; } else { goto anon1236_Else; }
anon1235_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_837_$_9 == exhaleMask#_837_$_7;
	goto anon748;
anon979_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_15);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_16 == assertSecMask#_533_$_15[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_533_$_15[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_533_$_15[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_16);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_16);
	assume assertSecMask#_533_$_17 == assertSecMask#_533_$_16;
	if ($_$_condition_$223) { goto anon980_Then; } else { goto anon980_Else; }
anon979_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_533_$_17 == assertSecMask#_533_$_15;
	if ($_$_condition_$224) { goto anon980_Then; } else { goto anon980_Else; }
anon1082_Then:
	assume !(r#251_$_0 == null);
	assume !(r#251_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,Mask_$_114,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_115 == Mask_$_114[r#251_$_0,AVLTreeNode.balanceFactor := Mask_$_114[r#251_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_114[r#251_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_115);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_115,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_115,ZeroMask);
	assume Mask_$_116 == Mask_$_115;
	if ($_$_condition_$225) { goto anon1083_Then; } else { goto anon1083_Else; }
anon1082_Else:
	assume r#251_$_0 == null;
	assume Mask_$_116 == Mask_$_114;
	if ($_$_condition_$226) { goto anon1083_Then; } else { goto anon1083_Else; }
anon1092_Then:
	assume !(r#255_$_0 == null);
	assume !(r#255_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,Mask_$_102,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_103 == Mask_$_102[r#255_$_0,AVLTreeNode.balanceFactor := Mask_$_102[r#255_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_102[r#255_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_103);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_103,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_103,ZeroMask);
	assume Mask_$_104 == Mask_$_103;
	if ($_$_condition_$227) { goto anon1093_Then; } else { goto anon1093_Else; }
anon1092_Else:
	assume r#255_$_0 == null;
	assume Mask_$_104 == Mask_$_102;
	if ($_$_condition_$228) { goto anon1093_Then; } else { goto anon1093_Else; }
anon619:
	assume IsGoodMask(exhaleMask#_738_$_6);
	assume wf(Heap_$_3,exhaleMask#_738_$_6,ZeroMask);
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	assume exhaleMask#_738_$_7 == exhaleMask#_738_$_6;
	if ($_$_condition_$229) { goto anon1173_Then; } else { goto anon1173_Else; }
anon743:
	assume IsGoodMask(exhaleMask#_837_$_6);
	assume wf(Heap_$_2,exhaleMask#_837_$_6,ZeroMask);
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	assume exhaleMask#_837_$_7 == exhaleMask#_837_$_6;
	if ($_$_condition_$230) { goto anon1235_Then; } else { goto anon1235_Else; }
anon980_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_17);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_18 == assertSecMask#_533_$_17[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_533_$_17[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_533_$_17[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_18);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_18);
	assume assertSecMask#_533_$_19 == assertSecMask#_533_$_18;
	if ($_$_condition_$231) { goto anon981_Then; } else { goto anon981_Else; }
anon980_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_533_$_19 == assertSecMask#_533_$_17;
	if ($_$_condition_$232) { goto anon981_Then; } else { goto anon981_Else; }
anon1083_Then:
	assume !(r#251_$_0 == null);
	assume (exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.height] == exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height]) || ((exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.height] + 1) == exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height]);
	if ($_$_condition_$233) { goto anon1084_Then; } else { goto anon1084_Else; }
anon1083_Else:
	assume r#251_$_0 == null;
	if ($_$_condition_$234) { goto anon1084_Then; } else { goto anon1084_Else; }
anon1093_Then:
	assume !(r#255_$_0 == null);
	assume (exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.height] == exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height]) || (exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.height] == (exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height] - 1));
	if ($_$_condition_$235) { goto anon1094_Then; } else { goto anon1094_Else; }
anon1093_Else:
	assume r#255_$_0 == null;
	if ($_$_condition_$236) { goto anon1094_Then; } else { goto anon1094_Else; }
anon981_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_19);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_533_$_20 == assertSecMask#_533_$_19[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_533_$_19[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_533_$_19[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_20);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_533_$_20);
	assume assertSecMask#_533_$_21 == assertSecMask#_533_$_20;
	if ($_$_condition_$239) { goto anon982_Then; } else { goto anon982_Else; }
anon981_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume assertSecMask#_533_$_21 == assertSecMask#_533_$_19;
	if ($_$_condition_$240) { goto anon982_Then; } else { goto anon982_Else; }
anon1084_Then:
	assume !(r#251_$_0 == null);
	assume (Seq#Length(exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.keys]) + 1) == Seq#Length(exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$241) { goto anon1085_Then; } else { goto anon1085_Else; }
anon1084_Else:
	assume r#251_$_0 == null;
	if ($_$_condition_$242) { goto anon1085_Then; } else { goto anon1085_Else; }
anon1094_Then:
	assume !(r#255_$_0 == null);
	assume (Seq#Length(exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.keys]) + 1) == Seq#Length(exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$243) { goto anon1095_Then; } else { goto anon1095_Else; }
anon1094_Else:
	assume r#255_$_0 == null;
	if ($_$_condition_$244) { goto anon1095_Then; } else { goto anon1095_Else; }
anon1174_Then:
	assume !CanRead(exhaleMask#_738_$_8,ZeroMask,Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_737_$_0[Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon623;
anon1174_Else:
	assume CanRead(exhaleMask#_738_$_8,ZeroMask,Heap_$_3[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon623;
anon624:
	assume IsGoodExhaleState(exhaleHeap#_737_$_0,Heap_$_3,exhaleMask#_738_$_9,ZeroMask);
	assume IsGoodMask(exhaleMask#_738_$_9);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_738_$_9,ZeroMask);
	assume true;
	assume !(this == null);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_738_$_9,ZeroMask);
	assume (exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_737_$_0[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume methodCallK#_736 > 0;
	assume Mask_$_69 == exhaleMask#_738_$_9[this,AVLTreeNode.left := exhaleMask#_738_$_9[this,AVLTreeNode.left][perm$R := exhaleMask#_738_$_9[this,AVLTreeNode.left][perm$R] + methodCallK#_736]];
	assume IsGoodMask(Mask_$_69);
	assume IsGoodState(heapFragment(exhaleHeap#_737_$_0[this,AVLTreeNode.left]));
	assume wf(exhaleHeap#_737_$_0,Mask_$_69,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_69,ZeroMask);
	if ($_$_condition_$251) { goto anon1175_Then; } else { goto anon1175_Else; }
anon1236_Then:
	assume !CanRead(exhaleMask#_837_$_8,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_836_$_0[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon747;
anon1236_Else:
	assume CanRead(exhaleMask#_837_$_8,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon747;
anon748:
	assume IsGoodExhaleState(exhaleHeap#_836_$_0,Heap_$_2,exhaleMask#_837_$_9,ZeroMask);
	assume IsGoodMask(exhaleMask#_837_$_9);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_837_$_9,ZeroMask);
	assume true;
	assume !(this == null);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_837_$_9,ZeroMask);
	assume (exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null) || (dtype(exhaleHeap#_836_$_0[this,AVLTreeNode.left]) == AVLTreeNode#t);
	assume methodCallK#_835 > 0;
	assume Mask_$_39 == exhaleMask#_837_$_9[this,AVLTreeNode.left := exhaleMask#_837_$_9[this,AVLTreeNode.left][perm$R := exhaleMask#_837_$_9[this,AVLTreeNode.left][perm$R] + methodCallK#_835]];
	assume IsGoodMask(Mask_$_39);
	assume IsGoodState(heapFragment(exhaleHeap#_836_$_0[this,AVLTreeNode.left]));
	assume wf(exhaleHeap#_836_$_0,Mask_$_39,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_39,ZeroMask);
	if ($_$_condition_$252) { goto anon1237_Then; } else { goto anon1237_Else; }
anon982_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#235 : Integer :: ( ((0 <= rk#80#235) && (rk#80#235 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#235)) ));
	if ($_$_condition_$245) { goto anon983_Then; } else { goto anon983_Else; }
anon982_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$246) { goto anon983_Then; } else { goto anon983_Else; }
anon1085_Then:
	assume exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height] > 1;
	assume !(r#251_$_0 == null);
	if ($_$_condition_$247) { goto anon1086_Then; } else { goto anon1086_Else; }
anon1085_Else:
	assume 1 >= exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height];
	if ($_$_condition_$248) { goto anon1086_Then; } else { goto anon1086_Else; }
anon1095_Then:
	assume exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height] > 1;
	assume !(r#255_$_0 == null);
	if ($_$_condition_$249) { goto anon1096_Then; } else { goto anon1096_Else; }
anon1095_Else:
	assume 1 >= exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height];
	if ($_$_condition_$250) { goto anon1096_Then; } else { goto anon1096_Else; }
anon623:
	assume IsGoodMask(exhaleMask#_738_$_8);
	assume wf(Heap_$_3,exhaleMask#_738_$_8,ZeroMask);
	assume wf(Heap_$_3,Mask_$_68,ZeroMask);
	assume exhaleMask#_738_$_9 == exhaleMask#_738_$_8;
	goto anon624;
anon747:
	assume IsGoodMask(exhaleMask#_837_$_8);
	assume wf(Heap_$_2,exhaleMask#_837_$_8,ZeroMask);
	assume wf(Heap_$_2,Mask_$_38,ZeroMask);
	assume exhaleMask#_837_$_9 == exhaleMask#_837_$_8;
	goto anon748;
anon983_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon241;
anon983_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon241;
anon1086_Then:
	assume exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height] == 1;
	assume r#251_$_0 == null;
	goto anon448;
anon1086_Else:
	assume !(exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height] == 1);
	goto anon448;
anon1096_Then:
	assume exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height] == 1;
	assume r#255_$_0 == null;
	goto anon469;
anon1096_Else:
	assume !(exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height] == 1);
	goto anon469;
anon241:
	assume Seq#Equal(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key])),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81_$1 : Integer :: ( Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$1) <==> ((((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$1)) || ((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$1))) || (kk#81_$1 == Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assert { :msg "  281.53: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  281.53: Location might not be readable." } true ==> CanRead(unfoldingMask#_538_$_22,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  281.53: Receiver might be null." } true ==> (!(unfoldingHeap#_537_$_1[this,AVLTreeNode.right] == null));
	assert { :msg "  281.53: Location might not be readable." } true ==> CanRead(unfoldingMask#_538_$_22,ZeroMask,unfoldingHeap#_537_$_1[this,AVLTreeNode.right],AVLTreeNode.keys);
	assert { :msg "  281.5: Assertion might not hold. The expression at 281.28 might not evaluate to true." } !Seq#Equal(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],(Seq#Empty() : Seq (Integer) ));
	assume assertSecMask#_533_$_22 == assertSecMask#_533_$_21;
	goto anon242;
anon448:
	assume (exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height] == ite(r#251_$_0 == null,0,exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.height])) || (exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.height] == (ite(r#251_$_0 == null,0,exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.height]) + 1));
	assume !(m#252_$_0 == null);
	assume !(m#252_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,Mask_$_116,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_117 == Mask_$_116[m#252_$_0,AVLTreeNode.valid := Mask_$_116[m#252_$_0,AVLTreeNode.valid][perm$R := Mask_$_116[m#252_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_117);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_117,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_117,ZeroMask);
	assume !(m#252_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,Mask_$_117,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_118 == Mask_$_117[m#252_$_0,AVLTreeNode.keys := Mask_$_117[m#252_$_0,AVLTreeNode.keys][perm$R := Mask_$_117[m#252_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_118);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_118,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_118,ZeroMask);
	assume !(m#252_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,Mask_$_118,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_119 == Mask_$_118[m#252_$_0,AVLTreeNode.height := Mask_$_118[m#252_$_0,AVLTreeNode.height][perm$R := Mask_$_118[m#252_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_119);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_119,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_119,ZeroMask);
	assume !(m#252_$_0 == null);
	assume wf(exhaleHeap#_651_$_0,Mask_$_119,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_120 == Mask_$_119[m#252_$_0,AVLTreeNode.balanceFactor := Mask_$_119[m#252_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_119[m#252_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_120);
	assume IsGoodState(heapFragment(exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_651_$_0,Mask_$_120,ZeroMask);
	assume wf(exhaleHeap#_651_$_0,Mask_$_120,ZeroMask);
	assume exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.height] == 1;
	assume Seq#Length(exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.keys]) == 1;
	assume Seq#Equal(Seq#Append(ite(r#251_$_0 == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.keys]),exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.keys]),exhaleHeap#_635_$_0[this#250_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$253) { goto anon1087_Then; } else { goto anon1087_Else; }
anon469:
	assume (exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height] == ite(r#255_$_0 == null,0,exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.height])) || (exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.height] == (ite(r#255_$_0 == null,0,exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.height]) + 1));
	assume !(m#256_$_0 == null);
	assume !(m#256_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,Mask_$_104,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_105 == Mask_$_104[m#256_$_0,AVLTreeNode.valid := Mask_$_104[m#256_$_0,AVLTreeNode.valid][perm$R := Mask_$_104[m#256_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_105);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_105,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_105,ZeroMask);
	assume !(m#256_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,Mask_$_105,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_106 == Mask_$_105[m#256_$_0,AVLTreeNode.keys := Mask_$_105[m#256_$_0,AVLTreeNode.keys][perm$R := Mask_$_105[m#256_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_106);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_106,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_106,ZeroMask);
	assume !(m#256_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,Mask_$_106,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_107 == Mask_$_106[m#256_$_0,AVLTreeNode.height := Mask_$_106[m#256_$_0,AVLTreeNode.height][perm$R := Mask_$_106[m#256_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_107);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_107,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_107,ZeroMask);
	assume !(m#256_$_0 == null);
	assume wf(exhaleHeap#_664_$_0,Mask_$_107,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_108 == Mask_$_107[m#256_$_0,AVLTreeNode.balanceFactor := Mask_$_107[m#256_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_107[m#256_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_108);
	assume IsGoodState(heapFragment(exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_664_$_0,Mask_$_108,ZeroMask);
	assume wf(exhaleHeap#_664_$_0,Mask_$_108,ZeroMask);
	assume exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.height] == 1;
	assume Seq#Length(exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.keys]) == 1;
	assume Seq#Equal(Seq#Append(exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.keys],ite(r#255_$_0 == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.keys])),exhaleHeap#_635_$_0[this#254_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$254) { goto anon1097_Then; } else { goto anon1097_Else; }
anon1175_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_737_$_0,Mask_$_69,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_70 == Mask_$_69[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_69[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_69[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_70);
	assume IsGoodState(heapFragment(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_737_$_0,Mask_$_70,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_70,ZeroMask);
	assume Mask_$_71 == Mask_$_70;
	if ($_$_condition_$255) { goto anon1176_Then; } else { goto anon1176_Else; }
anon1175_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_71 == Mask_$_69;
	if ($_$_condition_$256) { goto anon1176_Then; } else { goto anon1176_Else; }
anon1237_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_836_$_0,Mask_$_39,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_40 == Mask_$_39[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_39[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_39[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_40);
	assume IsGoodState(heapFragment(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_836_$_0,Mask_$_40,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_40,ZeroMask);
	assume Mask_$_41 == Mask_$_40;
	if ($_$_condition_$257) { goto anon1238_Then; } else { goto anon1238_Else; }
anon1237_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_41 == Mask_$_39;
	if ($_$_condition_$258) { goto anon1238_Then; } else { goto anon1238_Else; }
anon1087_Then:
	assume !(r#251_$_0 == null);
	assume (forall  k#86#253 : Integer :: ( ((0 <= k#86#253) && (k#86#253 < Seq#Length(exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_651_$_0[r#251_$_0,AVLTreeNode.keys],k#86#253) < Seq#Index(exhaleHeap#_651_$_0[m#252_$_0,AVLTreeNode.keys],0)) ));
	goto anon450;
anon1087_Else:
	assume r#251_$_0 == null;
	goto anon450;
anon1097_Then:
	assume !(r#255_$_0 == null);
	assume (forall  k#89#257 : Integer :: ( ((0 <= k#89#257) && (k#89#257 < Seq#Length(exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_664_$_0[m#256_$_0,AVLTreeNode.keys],0) < Seq#Index(exhaleHeap#_664_$_0[r#255_$_0,AVLTreeNode.keys],k#89#257)) ));
	goto anon471;
anon1097_Else:
	assume r#255_$_0 == null;
	goto anon471;
anon1176_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_737_$_0,Mask_$_71,ZeroMask);
	assume true;
	assume methodCallK#_736 > 0;
	assume Mask_$_72 == Mask_$_71[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_71[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_71[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + methodCallK#_736]];
	assume IsGoodMask(Mask_$_72);
	assume IsGoodState(heapFragment(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_737_$_0,Mask_$_72,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_72,ZeroMask);
	assume Mask_$_73 == Mask_$_72;
	goto anon628;
anon1176_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_73 == Mask_$_71;
	goto anon628;
anon1238_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assume wf(exhaleHeap#_836_$_0,Mask_$_41,ZeroMask);
	assume true;
	assume methodCallK#_835 > 0;
	assume Mask_$_42 == Mask_$_41[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height := Mask_$_41[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_41[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + methodCallK#_835]];
	assume IsGoodMask(Mask_$_42);
	assume IsGoodState(heapFragment(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(exhaleHeap#_836_$_0,Mask_$_42,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_42,ZeroMask);
	assume Mask_$_43 == Mask_$_42;
	goto anon752;
anon1238_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null;
	assume Mask_$_43 == Mask_$_41;
	goto anon752;
anon984_Then:
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume (0 < unfoldingK#_591) && ((1000 * unfoldingK#_591) < Fractions(1));
	assert { :msg "  282.38: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  282.38: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  282.38: Receiver might be null." } true ==> (!(Heap_$_1[this,AVLTreeNode.left] == null));
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assert { :msg "  282.28: Unfolding might fail. The permission at 282.38 might not be positive." } Fractions(100) > 0;
	assert { :msg "  282.28: Unfolding might fail. Insufficient fraction at 282.38 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_26[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_26[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_26[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume unfoldingMask#_587_$_0 == Mask_$_26[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_26[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_26[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$260) { goto anon985_Then; } else { goto anon985_Else; }
anon984_Else:
	assume Heap_$_1[this,AVLTreeNode.left] == null;
	assume assertSecMask#_582_$_22 == ZeroMask;
	goto anon402;
anon450:
	assume IsGoodMask(Mask_$_120);
	assume wf(exhaleHeap#_651_$_0,Mask_$_120,ZeroMask);
	assume Mask_$_121 == Mask_$_120;
	assume Heap_$_4 == exhaleHeap#_651_$_0;
	assume nl#24_$_1 == r#251_$_0;
	assume nr#26_$_1 == nr#26_$_0;
	assume r#20_$_0 == m#252_$_0;
	goto anon472;
anon471:
	assume IsGoodMask(Mask_$_108);
	assume wf(exhaleHeap#_664_$_0,Mask_$_108,ZeroMask);
	assume Mask_$_121 == Mask_$_108;
	assume Heap_$_4 == exhaleHeap#_664_$_0;
	assume nl#24_$_1 == nl#24_$_0;
	assume nr#26_$_1 == r#255_$_0;
	assume r#20_$_0 == m#256_$_0;
	goto anon472;
anon628:
	assume !(this == null);
	assume wf(exhaleHeap#_737_$_0,Mask_$_73,ZeroMask);
	assume (exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_737_$_0[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume methodCallK#_736 > 0;
	assume Mask_$_74 == Mask_$_73[this,AVLTreeNode.right := Mask_$_73[this,AVLTreeNode.right][perm$R := Mask_$_73[this,AVLTreeNode.right][perm$R] + methodCallK#_736]];
	assume IsGoodMask(Mask_$_74);
	assume IsGoodState(heapFragment(exhaleHeap#_737_$_0[this,AVLTreeNode.right]));
	assume wf(exhaleHeap#_737_$_0,Mask_$_74,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_74,ZeroMask);
	if ($_$_condition_$261) { goto anon1177_Then; } else { goto anon1177_Else; }
anon752:
	assume !(this == null);
	assume wf(exhaleHeap#_836_$_0,Mask_$_43,ZeroMask);
	assume (exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null) || (dtype(exhaleHeap#_836_$_0[this,AVLTreeNode.right]) == AVLTreeNode#t);
	assume methodCallK#_835 > 0;
	assume Mask_$_44 == Mask_$_43[this,AVLTreeNode.right := Mask_$_43[this,AVLTreeNode.right][perm$R := Mask_$_43[this,AVLTreeNode.right][perm$R] + methodCallK#_835]];
	assume IsGoodMask(Mask_$_44);
	assume IsGoodState(heapFragment(exhaleHeap#_836_$_0[this,AVLTreeNode.right]));
	assume wf(exhaleHeap#_836_$_0,Mask_$_44,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_44,ZeroMask);
	if ($_$_condition_$262) { goto anon1239_Then; } else { goto anon1239_Else; }
anon985_Then:
	assume false;
	goto $exit;
anon985_Else:
	assume !false;
	if ($_$_condition_$263) { goto anon1012_Then; } else { goto anon1012_Else; }
anon402:
	assume IsGoodExhaleState(exhaleHeap#_584_$_0,Heap_$_1,Mask_$_26,assertSecMask#_582_$_22);
	assume IsGoodMask(Mask_$_26);
	assume wf(exhaleHeap#_584_$_0,Mask_$_26,assertSecMask#_582_$_22);
	assume cond#_629_$_0 <==> (Heap_$_1[this,AVLTreeNode.left] == null);
	assert { :msg "  283.9: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  283.9: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	if ($_$_condition_$430) { goto anon1064_Then; } else { goto anon1064_Else; }
anon472:
	assume #AVLTreeNode.valid#trigger(r#20_$_0);
	assume ((0 < unfoldK#_672) && (unfoldK#_672 < Fractions(1))) && ((1000 * unfoldK#_672) < methodK#_506);
	assert { :msg "  299.5: The target of the fold statement might be null." } !(r#20_$_0 == null);
	assert { :msg "  299.5: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  299.5: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_121[r#20_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_121[r#20_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_121[r#20_$_0,AVLTreeNode.valid][perm$N]));
	assume Mask_$_122 == Mask_$_121[r#20_$_0,AVLTreeNode.valid := Mask_$_121[r#20_$_0,AVLTreeNode.valid][perm$R := Mask_$_121[r#20_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$264) { goto anon1098_Then; } else { goto anon1098_Else; }
anon1177_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_737_$_0,Mask_$_74,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_75 == Mask_$_74[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_74[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_74[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_75);
	assume IsGoodState(heapFragment(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_737_$_0,Mask_$_75,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_75,ZeroMask);
	assume Mask_$_76 == Mask_$_75;
	if ($_$_condition_$265) { goto anon1178_Then; } else { goto anon1178_Else; }
anon1177_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_76 == Mask_$_74;
	if ($_$_condition_$266) { goto anon1178_Then; } else { goto anon1178_Else; }
anon1239_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_836_$_0,Mask_$_44,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_45 == Mask_$_44[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_44[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_44[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_45);
	assume IsGoodState(heapFragment(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(exhaleHeap#_836_$_0,Mask_$_45,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_45,ZeroMask);
	assume Mask_$_46 == Mask_$_45;
	if ($_$_condition_$267) { goto anon1240_Then; } else { goto anon1240_Else; }
anon1239_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_46 == Mask_$_44;
	if ($_$_condition_$268) { goto anon1240_Then; } else { goto anon1240_Else; }
anon1012_Then:
	assume !CanRead(unfoldingMask#_587_$_0,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume oldVers#_611_$_0 == Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_586_$_0 == Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid := newVers#_612_$_0];
	assume oldVers#_611_$_0 < unfoldingHeap#_586_$_0[unfoldingHeap#_586_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	assume unfoldingHeap#_586_$_1 == unfoldingHeap#_586_$_0;
	goto anon299;
anon1012_Else:
	assume CanRead(unfoldingMask#_587_$_0,ZeroMask,Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume unfoldingHeap#_586_$_1 == Heap_$_1;
	goto anon299;
anon1098_Then:
	assume false;
	goto $exit;
anon1098_Else:
	assume !false;
	if ($_$_condition_$269) { goto anon1125_Then; } else { goto anon1125_Else; }
anon1178_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_737_$_0,Mask_$_76,ZeroMask);
	assume true;
	assume methodCallK#_736 > 0;
	assume Mask_$_77 == Mask_$_76[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_76[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_76[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + methodCallK#_736]];
	assume IsGoodMask(Mask_$_77);
	assume IsGoodState(heapFragment(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_737_$_0,Mask_$_77,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_77,ZeroMask);
	assume Mask_$_78 == Mask_$_77;
	goto anon632;
anon1178_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_78 == Mask_$_76;
	goto anon632;
anon1240_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assume wf(exhaleHeap#_836_$_0,Mask_$_46,ZeroMask);
	assume true;
	assume methodCallK#_835 > 0;
	assume Mask_$_47 == Mask_$_46[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_46[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_46[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + methodCallK#_835]];
	assume IsGoodMask(Mask_$_47);
	assume IsGoodState(heapFragment(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(exhaleHeap#_836_$_0,Mask_$_47,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_47,ZeroMask);
	assume Mask_$_48 == Mask_$_47;
	goto anon756;
anon1240_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume Mask_$_48 == Mask_$_46;
	goto anon756;
anon299:
	assume IsGoodMask(unfoldingMask#_587_$_0);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_0,ZeroMask);
	assume IsGoodMask(unfoldingMask#_587_$_0);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_0,ZeroMask);
	assume !(unfoldingHeap#_586_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_0,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume unfoldingMask#_587_$_1 == unfoldingMask#_587_$_0[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key := unfoldingMask#_587_$_0[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := unfoldingMask#_587_$_0[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_587_$_1);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_1,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_1,ZeroMask);
	assume !(unfoldingHeap#_586_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_1,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_2 == unfoldingMask#_587_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_587_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_587_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_2);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_2,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_2,ZeroMask);
	assume !(unfoldingHeap#_586_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_2,ZeroMask);
	assume (unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null) || (dtype(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_587_$_3 == unfoldingMask#_587_$_2[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left := unfoldingMask#_587_$_2[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := unfoldingMask#_587_$_2[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_587_$_3);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_3,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_3,ZeroMask);
	assume !(unfoldingHeap#_586_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_3,ZeroMask);
	assume (unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null) || (dtype(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume unfoldingMask#_587_$_4 == unfoldingMask#_587_$_3[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right := unfoldingMask#_587_$_3[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := unfoldingMask#_587_$_3[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_587_$_4);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_4,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_4,ZeroMask);
	assume !(unfoldingHeap#_586_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_4,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_5 == unfoldingMask#_587_$_4[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_587_$_4[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_587_$_4[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_5);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_5,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_5,ZeroMask);
	assume !(unfoldingHeap#_586_$_1[this,AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_5,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_6 == unfoldingMask#_587_$_5[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_587_$_5[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_587_$_5[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_6);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_6,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_6,ZeroMask);
	if ($_$_condition_$270) { goto anon1013_Then; } else { goto anon1013_Else; }
anon1125_Then:
	assume !CanRead(Mask_$_122,ZeroMask,r#20_$_0,AVLTreeNode.valid);
	assume oldVers#_692_$_0 == Heap_$_4[r#20_$_0,AVLTreeNode.valid];
	assume Heap_$_5 == Heap_$_4[r#20_$_0,AVLTreeNode.valid := newVers#_693_$_0];
	assume oldVers#_692_$_0 < Heap_$_5[r#20_$_0,AVLTreeNode.valid];
	assume Heap_$_6 == Heap_$_5;
	goto anon528;
anon1125_Else:
	assume CanRead(Mask_$_122,ZeroMask,r#20_$_0,AVLTreeNode.valid);
	assume Heap_$_6 == Heap_$_4;
	goto anon528;
anon632:
	assume bf#275_$_0 == (ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	if ($_$_condition_$271) { goto anon1179_Then; } else { goto anon1179_Else; }
anon756:
	assume bf#298_$_0 == (ite(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	if ($_$_condition_$272) { goto anon1241_Then; } else { goto anon1241_Else; }
anon1013_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_6,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_587_$_7 == unfoldingMask#_587_$_6[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := unfoldingMask#_587_$_6[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := unfoldingMask#_587_$_6[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_587_$_7);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_7,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_7,ZeroMask);
	assume unfoldingMask#_587_$_8 == unfoldingMask#_587_$_7;
	if ($_$_condition_$273) { goto anon1014_Then; } else { goto anon1014_Else; }
anon1013_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_587_$_8 == unfoldingMask#_587_$_6;
	if ($_$_condition_$274) { goto anon1014_Then; } else { goto anon1014_Else; }
anon528:
	assume IsGoodMask(Mask_$_122);
	assume wf(Heap_$_6,Mask_$_122,ZeroMask);
	assume IsGoodMask(Mask_$_122);
	assume wf(Heap_$_6,Mask_$_122,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(Heap_$_6,Mask_$_122,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_123 == Mask_$_122[r#20_$_0,AVLTreeNode.key := Mask_$_122[r#20_$_0,AVLTreeNode.key][perm$R := Mask_$_122[r#20_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_123);
	assume IsGoodState(heapFragment(Heap_$_6[r#20_$_0,AVLTreeNode.key]));
	assume wf(Heap_$_6,Mask_$_123,ZeroMask);
	assume wf(Heap_$_6,Mask_$_123,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(Heap_$_6,Mask_$_123,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_124 == Mask_$_123[r#20_$_0,AVLTreeNode.height := Mask_$_123[r#20_$_0,AVLTreeNode.height][perm$R := Mask_$_123[r#20_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_124);
	assume IsGoodState(heapFragment(Heap_$_6[r#20_$_0,AVLTreeNode.height]));
	assume wf(Heap_$_6,Mask_$_124,ZeroMask);
	assume wf(Heap_$_6,Mask_$_124,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(Heap_$_6,Mask_$_124,ZeroMask);
	assume (Heap_$_6[r#20_$_0,AVLTreeNode.left] == null) || (dtype(Heap_$_6[r#20_$_0,AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_125 == Mask_$_124[r#20_$_0,AVLTreeNode.left := Mask_$_124[r#20_$_0,AVLTreeNode.left][perm$R := Mask_$_124[r#20_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_125);
	assume IsGoodState(heapFragment(Heap_$_6[r#20_$_0,AVLTreeNode.left]));
	assume wf(Heap_$_6,Mask_$_125,ZeroMask);
	assume wf(Heap_$_6,Mask_$_125,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(Heap_$_6,Mask_$_125,ZeroMask);
	assume (Heap_$_6[r#20_$_0,AVLTreeNode.right] == null) || (dtype(Heap_$_6[r#20_$_0,AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_126 == Mask_$_125[r#20_$_0,AVLTreeNode.right := Mask_$_125[r#20_$_0,AVLTreeNode.right][perm$R := Mask_$_125[r#20_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_126);
	assume IsGoodState(heapFragment(Heap_$_6[r#20_$_0,AVLTreeNode.right]));
	assume wf(Heap_$_6,Mask_$_126,ZeroMask);
	assume wf(Heap_$_6,Mask_$_126,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(Heap_$_6,Mask_$_126,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_127 == Mask_$_126[r#20_$_0,AVLTreeNode.keys := Mask_$_126[r#20_$_0,AVLTreeNode.keys][perm$R := Mask_$_126[r#20_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_127);
	assume IsGoodState(heapFragment(Heap_$_6[r#20_$_0,AVLTreeNode.keys]));
	assume wf(Heap_$_6,Mask_$_127,ZeroMask);
	assume wf(Heap_$_6,Mask_$_127,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(Heap_$_6,Mask_$_127,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_128 == Mask_$_127[r#20_$_0,AVLTreeNode.balanceFactor := Mask_$_127[r#20_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_127[r#20_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_128);
	assume IsGoodState(heapFragment(Heap_$_6[r#20_$_0,AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_6,Mask_$_128,ZeroMask);
	assume wf(Heap_$_6,Mask_$_128,ZeroMask);
	if ($_$_condition_$275) { goto anon1126_Then; } else { goto anon1126_Else; }
anon1179_Then:
	assume bf#275_$_0 > 0;
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	if ($_$_condition_$276) { goto anon1180_Then; } else { goto anon1180_Else; }
anon1179_Else:
	assume 0 >= bf#275_$_0;
	if ($_$_condition_$277) { goto anon1180_Then; } else { goto anon1180_Else; }
anon1241_Then:
	assume bf#298_$_0 > 0;
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	if ($_$_condition_$278) { goto anon1242_Then; } else { goto anon1242_Else; }
anon1241_Else:
	assume 0 >= bf#298_$_0;
	if ($_$_condition_$279) { goto anon1242_Then; } else { goto anon1242_Else; }
anon1014_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_8,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_9 == unfoldingMask#_587_$_8[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := unfoldingMask#_587_$_8[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := unfoldingMask#_587_$_8[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_9);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_9,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_9,ZeroMask);
	assume unfoldingMask#_587_$_10 == unfoldingMask#_587_$_9;
	if ($_$_condition_$280) { goto anon1015_Then; } else { goto anon1015_Else; }
anon1014_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_587_$_10 == unfoldingMask#_587_$_8;
	if ($_$_condition_$281) { goto anon1015_Then; } else { goto anon1015_Else; }
anon1126_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_6,Mask_$_128,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_129 == Mask_$_128[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid := Mask_$_128[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_128[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_129);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap_$_6,Mask_$_129,ZeroMask);
	assume wf(Heap_$_6,Mask_$_129,ZeroMask);
	assume Mask_$_130 == Mask_$_129;
	if ($_$_condition_$282) { goto anon1127_Then; } else { goto anon1127_Else; }
anon1126_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.left] == null;
	assume Mask_$_130 == Mask_$_128;
	if ($_$_condition_$283) { goto anon1127_Then; } else { goto anon1127_Else; }
anon1180_Then:
	assume bf#275_$_0 < 0;
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	goto anon636;
anon1180_Else:
	assume 0 <= bf#275_$_0;
	goto anon636;
anon1242_Then:
	assume bf#298_$_0 < 0;
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	goto anon760;
anon1242_Else:
	assume 0 <= bf#298_$_0;
	goto anon760;
anon1015_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_10,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_11 == unfoldingMask#_587_$_10[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := unfoldingMask#_587_$_10[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := unfoldingMask#_587_$_10[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_11);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_11,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_11,ZeroMask);
	assume unfoldingMask#_587_$_12 == unfoldingMask#_587_$_11;
	if ($_$_condition_$284) { goto anon1016_Then; } else { goto anon1016_Else; }
anon1015_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_587_$_12 == unfoldingMask#_587_$_10;
	if ($_$_condition_$285) { goto anon1016_Then; } else { goto anon1016_Else; }
anon1127_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_6,Mask_$_130,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_131 == Mask_$_130[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height := Mask_$_130[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_130[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_131);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_6,Mask_$_131,ZeroMask);
	assume wf(Heap_$_6,Mask_$_131,ZeroMask);
	assume Mask_$_132 == Mask_$_131;
	if ($_$_condition_$286) { goto anon1128_Then; } else { goto anon1128_Else; }
anon1127_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.left] == null;
	assume Mask_$_132 == Mask_$_130;
	if ($_$_condition_$287) { goto anon1128_Then; } else { goto anon1128_Else; }
anon636:
	assume IsGoodMask(Mask_$_78);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume cond#_747_$_0 <==> (bf#275_$_0 == (0 - 2));
	if ($_$_condition_$288) { goto anon1181_Then; } else { goto anon1181_Else; }
anon760:
	assume IsGoodMask(Mask_$_48);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume cond#_846_$_0 <==> (bf#298_$_0 == 2);
	if ($_$_condition_$289) { goto anon1243_Then; } else { goto anon1243_Else; }
anon1016_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_12,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_13 == unfoldingMask#_587_$_12[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := unfoldingMask#_587_$_12[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_587_$_12[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_13);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_13,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_13,ZeroMask);
	assume unfoldingMask#_587_$_14 == unfoldingMask#_587_$_13;
	if ($_$_condition_$290) { goto anon1017_Then; } else { goto anon1017_Else; }
anon1016_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume unfoldingMask#_587_$_14 == unfoldingMask#_587_$_12;
	if ($_$_condition_$291) { goto anon1017_Then; } else { goto anon1017_Else; }
anon1128_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_6,Mask_$_132,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_133 == Mask_$_132[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys := Mask_$_132[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_132[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_133);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_6,Mask_$_133,ZeroMask);
	assume wf(Heap_$_6,Mask_$_133,ZeroMask);
	assume Mask_$_134 == Mask_$_133;
	if ($_$_condition_$292) { goto anon1129_Then; } else { goto anon1129_Else; }
anon1128_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.left] == null;
	assume Mask_$_134 == Mask_$_132;
	if ($_$_condition_$293) { goto anon1129_Then; } else { goto anon1129_Else; }
anon1181_Then:
	assume cond#_747_$_0;
	assume ((0 < methodCallK#_752) && ((1000 * methodCallK#_752) < Fractions(1))) && ((1000 * methodCallK#_752) < methodK#_506);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$294) { goto anon1182_Then; } else { goto anon1182_Else; }
anon1181_Else:
	assume !cond#_747_$_0;
	assume ((0 < methodCallK#_775) && ((1000 * methodCallK#_775) < Fractions(1))) && ((1000 * methodCallK#_775) < methodK#_506);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  317.7: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$295) { goto anon1189_Then; } else { goto anon1189_Else; }
anon1243_Then:
	assume cond#_846_$_0;
	assume ((0 < methodCallK#_851) && ((1000 * methodCallK#_851) < Fractions(1))) && ((1000 * methodCallK#_851) < methodK#_506);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The target of the method call might be null." } !(this == null);
	assert { :msg "  333.7: The precondition at 608.12 might not hold. The expression at 608.12 might not evaluate to true." } !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  333.7: The precondition at 613.12 might not hold. The expression at 613.12 might not evaluate to true." } (forall  k#94#301 : Integer :: ( ((0 <= k#94#301) && (k#94#301 < Seq#Length(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#94#301) < exhaleHeap#_836_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$296) { goto anon1244_Then; } else { goto anon1244_Else; }
anon1243_Else:
	assume !cond#_846_$_0;
	assume ((0 < methodCallK#_874) && ((1000 * methodCallK#_874) < Fractions(1))) && ((1000 * methodCallK#_874) < methodK#_506);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  336.7: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$297) { goto anon1251_Then; } else { goto anon1251_Else; }
anon1017_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#240 : Integer :: ( ((0 <= lk#79#240) && (lk#79#240 < Seq#Length(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#240) < unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$298) { goto anon1018_Then; } else { goto anon1018_Else; }
anon1017_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$299) { goto anon1018_Then; } else { goto anon1018_Else; }
anon1129_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume wf(Heap_$_6,Mask_$_134,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_135 == Mask_$_134[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_134[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_134[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_135);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_6,Mask_$_135,ZeroMask);
	assume wf(Heap_$_6,Mask_$_135,ZeroMask);
	assume Mask_$_136 == Mask_$_135;
	if ($_$_condition_$300) { goto anon1130_Then; } else { goto anon1130_Else; }
anon1129_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.left] == null;
	assume Mask_$_136 == Mask_$_134;
	if ($_$_condition_$301) { goto anon1130_Then; } else { goto anon1130_Else; }
anon1182_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  315.7: The precondition at 758.12 might not hold. The expression at 758.25 might not evaluate to true." } (forall  k#104#278 : Integer :: ( ((0 <= k#104#278) && (k#104#278 < Seq#Length(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#104#278) < exhaleHeap#_737_$_0[this,AVLTreeNode.key]) ));
	goto anon639;
anon1182_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	goto anon639;
anon1189_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  317.7: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#283 : Integer :: ( ((0 <= k#92#283) && (k#92#283 < Seq#Length(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#283) < exhaleHeap#_737_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$302) { goto anon1190_Then; } else { goto anon1190_Else; }
anon1189_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	if ($_$_condition_$303) { goto anon1190_Then; } else { goto anon1190_Else; }
anon1244_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  333.7: The precondition at 619.12 might not hold. The expression at 619.28 might not evaluate to true." } (forall  k#95#302 : Integer :: ( ((0 <= k#95#302) && (k#95#302 < Seq#Length(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_836_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#95#302)) ));
	goto anon763;
anon1244_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	goto anon763;
anon1251_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  336.7: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#306 : Integer :: ( ((0 <= k#92#306) && (k#92#306 < Seq#Length(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#306) < exhaleHeap#_836_$_0[this,AVLTreeNode.key]) ));
	if ($_$_condition_$304) { goto anon1252_Then; } else { goto anon1252_Else; }
anon1251_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null;
	if ($_$_condition_$305) { goto anon1252_Then; } else { goto anon1252_Else; }
anon1018_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$306) { goto anon1019_Then; } else { goto anon1019_Else; }
anon1018_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$307) { goto anon1019_Then; } else { goto anon1019_Else; }
anon1130_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume (forall  lk#79#262 : Integer :: ( ((0 <= lk#79#262) && (lk#79#262 < Seq#Length(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys],lk#79#262) < Heap_$_6[r#20_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$308) { goto anon1131_Then; } else { goto anon1131_Else; }
anon1130_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$309) { goto anon1131_Then; } else { goto anon1131_Else; }
anon639:
	assert { :msg "  315.7: The precondition at 760.12 might not hold. The expression at 760.12 might not evaluate to true." } !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  315.7: The precondition at 765.12 might not hold. The expression at 765.12 might not evaluate to true." } (forall  k#105#279 : Integer :: ( ((0 <= k#105#279) && (k#105#279 < Seq#Length(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_737_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#105#279)) ));
	assert { :msg "  315.7: The precondition at 768.12 might not hold. The expression at 768.12 might not evaluate to true." } (ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) == (0 - 2);
	assert { :msg "  315.7: The precondition at 746.12 might not hold. The permission at 746.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 746.12 might not hold. Insufficient fraction at 746.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_78[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_78[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_78[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_754_$_0 == Mask_$_78[this,AVLTreeNode.key := Mask_$_78[this,AVLTreeNode.key][perm$R := Mask_$_78[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_754_$_0);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_0,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 747.12 might not hold. The permission at 747.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 747.12 might not hold. Insufficient fraction at 747.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_754_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_754_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_754_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_754_$_1 == exhaleMask#_754_$_0[this,AVLTreeNode.height := exhaleMask#_754_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_754_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_754_$_1);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_1,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 748.12 might not hold. The permission at 748.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 748.12 might not hold. Insufficient fraction at 748.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_754_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_754_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_754_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_754_$_2 == exhaleMask#_754_$_1[this,AVLTreeNode.left := exhaleMask#_754_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_754_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_754_$_2);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_2,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 749.12 might not hold. The permission at 749.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 749.12 might not hold. Insufficient fraction at 749.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_754_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_754_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_754_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_754_$_3 == exhaleMask#_754_$_2[this,AVLTreeNode.right := exhaleMask#_754_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_754_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_754_$_3);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_3,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 751.12 might not hold. The permission at 751.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 751.12 might not hold. Insufficient fraction at 751.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_754_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_754_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_754_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_754_$_4 == exhaleMask#_754_$_3[this,AVLTreeNode.keys := exhaleMask#_754_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_754_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_754_$_4);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_4,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 752.12 might not hold. The permission at 752.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 752.12 might not hold. Insufficient fraction at 752.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_754_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_754_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_754_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_754_$_5 == exhaleMask#_754_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_754_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_754_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_754_$_5);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_5,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	if ($_$_condition_$310) { goto anon1183_Then; } else { goto anon1183_Else; }
anon1190_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  317.7: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#284 : Integer :: ( ((0 <= k#93#284) && (k#93#284 < Seq#Length(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_737_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#284)) ));
	goto anon656;
anon1190_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null;
	goto anon656;
anon763:
	assert { :msg "  333.7: The precondition at 621.12 might not hold. The expression at 621.12 might not evaluate to true." } (exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height] - ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) == 2;
	assert { :msg "  333.7: The precondition at 600.12 might not hold. The permission at 600.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 600.12 might not hold. Insufficient fraction at 600.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_48[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_48[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_48[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_853_$_0 == Mask_$_48[this,AVLTreeNode.key := Mask_$_48[this,AVLTreeNode.key][perm$R := Mask_$_48[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_853_$_0);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_0,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 601.12 might not hold. The permission at 601.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 601.12 might not hold. Insufficient fraction at 601.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_853_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_853_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_853_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_853_$_1 == exhaleMask#_853_$_0[this,AVLTreeNode.height := exhaleMask#_853_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_853_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_853_$_1);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_1,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 602.12 might not hold. The permission at 602.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 602.12 might not hold. Insufficient fraction at 602.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_853_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_853_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_853_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_853_$_2 == exhaleMask#_853_$_1[this,AVLTreeNode.left := exhaleMask#_853_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_853_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_853_$_2);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_2,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 603.12 might not hold. The permission at 603.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 603.12 might not hold. Insufficient fraction at 603.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_853_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_853_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_853_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_853_$_3 == exhaleMask#_853_$_2[this,AVLTreeNode.right := exhaleMask#_853_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_853_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_853_$_3);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_3,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 605.12 might not hold. The permission at 605.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 605.12 might not hold. Insufficient fraction at 605.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_853_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_853_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_853_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_853_$_4 == exhaleMask#_853_$_3[this,AVLTreeNode.keys := exhaleMask#_853_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_853_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_853_$_4);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_4,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 606.12 might not hold. The permission at 606.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 606.12 might not hold. Insufficient fraction at 606.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_853_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_853_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_853_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_853_$_5 == exhaleMask#_853_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_853_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_853_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_853_$_5);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_5,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 609.12 might not hold. The permission at 609.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 609.12 might not hold. Insufficient fraction at 609.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_853_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_853_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_853_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_853_$_6 == exhaleMask#_853_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_853_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_853_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$311) { goto anon1245_Then; } else { goto anon1245_Else; }
anon1252_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  336.7: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#307 : Integer :: ( ((0 <= k#93#307) && (k#93#307 < Seq#Length(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (exhaleHeap#_836_$_0[this,AVLTreeNode.key] < Seq#Index(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#307)) ));
	goto anon780;
anon1252_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	goto anon780;
anon1019_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_14,ZeroMask);
	assume Fractions(100) > 0;
	assume unfoldingMask#_587_$_15 == unfoldingMask#_587_$_14[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := unfoldingMask#_587_$_14[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := unfoldingMask#_587_$_14[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(unfoldingMask#_587_$_15);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_15,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_15,ZeroMask);
	assume unfoldingMask#_587_$_16 == unfoldingMask#_587_$_15;
	if ($_$_condition_$312) { goto anon1020_Then; } else { goto anon1020_Else; }
anon1019_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_587_$_16 == unfoldingMask#_587_$_14;
	if ($_$_condition_$313) { goto anon1020_Then; } else { goto anon1020_Else; }
anon1131_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null);
	assume Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$314) { goto anon1132_Then; } else { goto anon1132_Else; }
anon1131_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$315) { goto anon1132_Then; } else { goto anon1132_Else; }
anon1183_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  315.7: The precondition at 754.12 might not hold. The permission at 754.25 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 754.12 might not hold. Insufficient fraction at 754.25 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_754_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_754_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_754_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_754_$_6 == exhaleMask#_754_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_754_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_754_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$316) { goto anon1184_Then; } else { goto anon1184_Else; }
anon1183_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_754_$_7 == exhaleMask#_754_$_5;
	if ($_$_condition_$317) { goto anon1185_Then; } else { goto anon1185_Else; }
anon656:
	assert { :msg "  317.7: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  317.7: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  317.7: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_78[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_78[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_78[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_777_$_0 == Mask_$_78[this,AVLTreeNode.key := Mask_$_78[this,AVLTreeNode.key][perm$R := Mask_$_78[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_777_$_0);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_0,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  317.7: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_777_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_777_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_777_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_777_$_1 == exhaleMask#_777_$_0[this,AVLTreeNode.height := exhaleMask#_777_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_777_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_777_$_1);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_1,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  317.7: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_777_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_777_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_777_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_777_$_2 == exhaleMask#_777_$_1[this,AVLTreeNode.left := exhaleMask#_777_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_777_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_777_$_2);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_2,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  317.7: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_777_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_777_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_777_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_777_$_3 == exhaleMask#_777_$_2[this,AVLTreeNode.right := exhaleMask#_777_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_777_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_777_$_3);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_3,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  317.7: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_777_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_777_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_777_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_777_$_4 == exhaleMask#_777_$_3[this,AVLTreeNode.keys := exhaleMask#_777_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_777_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_777_$_4);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_4,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  317.7: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_777_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_777_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_777_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_777_$_5 == exhaleMask#_777_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_777_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_777_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_777_$_5);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_5,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	if ($_$_condition_$318) { goto anon1191_Then; } else { goto anon1191_Else; }
anon1245_Then:
	assume !CanRead(exhaleMask#_853_$_6,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_852_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon765;
anon1245_Else:
	assume CanRead(exhaleMask#_853_$_6,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon765;
anon780:
	assert { :msg "  336.7: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  336.7: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  336.7: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_48[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_48[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_48[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_876_$_0 == Mask_$_48[this,AVLTreeNode.key := Mask_$_48[this,AVLTreeNode.key][perm$R := Mask_$_48[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_876_$_0);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_0,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  336.7: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_876_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_876_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_876_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_876_$_1 == exhaleMask#_876_$_0[this,AVLTreeNode.height := exhaleMask#_876_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_876_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_876_$_1);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_1,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  336.7: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_876_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_876_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_876_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_876_$_2 == exhaleMask#_876_$_1[this,AVLTreeNode.left := exhaleMask#_876_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_876_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_876_$_2);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_2,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  336.7: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_876_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_876_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_876_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_876_$_3 == exhaleMask#_876_$_2[this,AVLTreeNode.right := exhaleMask#_876_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_876_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_876_$_3);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_3,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  336.7: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_876_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_876_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_876_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_876_$_4 == exhaleMask#_876_$_3[this,AVLTreeNode.keys := exhaleMask#_876_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_876_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_876_$_4);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_4,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  336.7: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_876_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_876_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_876_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_876_$_5 == exhaleMask#_876_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_876_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_876_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_876_$_5);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_5,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	if ($_$_condition_$319) { goto anon1253_Then; } else { goto anon1253_Else; }
anon1020_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_16,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_17 == unfoldingMask#_587_$_16[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := unfoldingMask#_587_$_16[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := unfoldingMask#_587_$_16[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_17);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_17,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_17,ZeroMask);
	assume unfoldingMask#_587_$_18 == unfoldingMask#_587_$_17;
	if ($_$_condition_$320) { goto anon1021_Then; } else { goto anon1021_Else; }
anon1020_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_587_$_18 == unfoldingMask#_587_$_16;
	if ($_$_condition_$321) { goto anon1021_Then; } else { goto anon1021_Else; }
anon1132_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_6,Mask_$_136,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_137 == Mask_$_136[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_136[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_136[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_137);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap_$_6,Mask_$_137,ZeroMask);
	assume wf(Heap_$_6,Mask_$_137,ZeroMask);
	assume Mask_$_138 == Mask_$_137;
	if ($_$_condition_$322) { goto anon1133_Then; } else { goto anon1133_Else; }
anon1132_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.right] == null;
	assume Mask_$_138 == Mask_$_136;
	if ($_$_condition_$323) { goto anon1133_Then; } else { goto anon1133_Else; }
anon1184_Then:
	assume !CanRead(exhaleMask#_754_$_6,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_753_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon642;
anon1184_Else:
	assume CanRead(exhaleMask#_754_$_6,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon642;
anon1185_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  315.7: The precondition at 755.12 might not hold. The permission at 755.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  315.7: The precondition at 755.12 might not hold. Insufficient fraction at 755.25 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_754_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_754_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_754_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_754_$_8 == exhaleMask#_754_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_754_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_754_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_754_$_8);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_8,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_754_$_9 == exhaleMask#_754_$_8;
	if ($_$_condition_$340) { goto anon1186_Then; } else { goto anon1186_Else; }
anon1185_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_754_$_9 == exhaleMask#_754_$_7;
	if ($_$_condition_$341) { goto anon1186_Then; } else { goto anon1186_Else; }
anon1191_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  317.7: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_777_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_777_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_777_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_777_$_6 == exhaleMask#_777_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_777_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_777_$_5[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$324) { goto anon1192_Then; } else { goto anon1192_Else; }
anon1191_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_777_$_7 == exhaleMask#_777_$_5;
	if ($_$_condition_$325) { goto anon1193_Then; } else { goto anon1193_Else; }
anon765:
	assume IsGoodMask(exhaleMask#_853_$_6);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_6,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 610.12 might not hold. The permission at 610.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  333.7: The precondition at 610.12 might not hold. Insufficient fraction at 610.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_853_$_6[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_853_$_6[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_853_$_6[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_853_$_7 == exhaleMask#_853_$_6[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_853_$_6[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_853_$_6[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_853_$_7);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_7,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 611.12 might not hold. The permission at 611.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  333.7: The precondition at 611.12 might not hold. Insufficient fraction at 611.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_853_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_853_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_853_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_853_$_8 == exhaleMask#_853_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_853_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_853_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_853_$_8);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_8,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  333.7: The precondition at 612.12 might not hold. The permission at 612.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  333.7: The precondition at 612.12 might not hold. Insufficient fraction at 612.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_853_$_8[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_853_$_8[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_853_$_8[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_853_$_9 == exhaleMask#_853_$_8[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_853_$_8[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_853_$_8[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_853_$_9);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_9,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	if ($_$_condition_$326) { goto anon1246_Then; } else { goto anon1246_Else; }
anon1253_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  336.7: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_876_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_876_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_876_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_876_$_6 == exhaleMask#_876_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_876_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_876_$_5[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$327) { goto anon1254_Then; } else { goto anon1254_Else; }
anon1253_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_876_$_7 == exhaleMask#_876_$_5;
	if ($_$_condition_$328) { goto anon1255_Then; } else { goto anon1255_Else; }
anon1021_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_18,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_19 == unfoldingMask#_587_$_18[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := unfoldingMask#_587_$_18[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := unfoldingMask#_587_$_18[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_19);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_19,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_19,ZeroMask);
	assume unfoldingMask#_587_$_20 == unfoldingMask#_587_$_19;
	if ($_$_condition_$329) { goto anon1022_Then; } else { goto anon1022_Else; }
anon1021_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_587_$_20 == unfoldingMask#_587_$_18;
	if ($_$_condition_$330) { goto anon1022_Then; } else { goto anon1022_Else; }
anon1133_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_6,Mask_$_138,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_139 == Mask_$_138[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height := Mask_$_138[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_138[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_139);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_6,Mask_$_139,ZeroMask);
	assume wf(Heap_$_6,Mask_$_139,ZeroMask);
	assume Mask_$_140 == Mask_$_139;
	if ($_$_condition_$331) { goto anon1134_Then; } else { goto anon1134_Else; }
anon1133_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.right] == null;
	assume Mask_$_140 == Mask_$_138;
	if ($_$_condition_$332) { goto anon1134_Then; } else { goto anon1134_Else; }
anon642:
	assume IsGoodMask(exhaleMask#_754_$_6);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_6,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_754_$_7 == exhaleMask#_754_$_6;
	if ($_$_condition_$333) { goto anon1185_Then; } else { goto anon1185_Else; }
anon1192_Then:
	assume !CanRead(exhaleMask#_777_$_6,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_776_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon659;
anon1192_Else:
	assume CanRead(exhaleMask#_777_$_6,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon659;
anon1193_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  317.7: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  317.7: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_777_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_777_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_777_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_777_$_8 == exhaleMask#_777_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_777_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_777_$_7[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_777_$_8);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_8,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_9 == exhaleMask#_777_$_8;
	if ($_$_condition_$350) { goto anon1194_Then; } else { goto anon1194_Else; }
anon1193_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_777_$_9 == exhaleMask#_777_$_7;
	if ($_$_condition_$351) { goto anon1194_Then; } else { goto anon1194_Else; }
anon1246_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  333.7: The precondition at 615.12 might not hold. The permission at 615.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  333.7: The precondition at 615.12 might not hold. Insufficient fraction at 615.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_853_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_853_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_853_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_853_$_10 == exhaleMask#_853_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_853_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_853_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$334) { goto anon1247_Then; } else { goto anon1247_Else; }
anon1246_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_853_$_11 == exhaleMask#_853_$_9;
	if ($_$_condition_$335) { goto anon1248_Then; } else { goto anon1248_Else; }
anon1254_Then:
	assume !CanRead(exhaleMask#_876_$_6,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_875_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon783;
anon1254_Else:
	assume CanRead(exhaleMask#_876_$_6,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon783;
anon1255_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  336.7: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  336.7: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_876_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_876_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_876_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_876_$_8 == exhaleMask#_876_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_876_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_876_$_7[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_876_$_8);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_8,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_9 == exhaleMask#_876_$_8;
	if ($_$_condition_$353) { goto anon1256_Then; } else { goto anon1256_Else; }
anon1255_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_876_$_9 == exhaleMask#_876_$_7;
	if ($_$_condition_$354) { goto anon1256_Then; } else { goto anon1256_Else; }
anon1022_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_20,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume unfoldingMask#_587_$_21 == unfoldingMask#_587_$_20[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := unfoldingMask#_587_$_20[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := unfoldingMask#_587_$_20[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(unfoldingMask#_587_$_21);
	assume IsGoodState(heapFragment(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_21,ZeroMask);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_21,ZeroMask);
	assume unfoldingMask#_587_$_22 == unfoldingMask#_587_$_21;
	if ($_$_condition_$336) { goto anon1023_Then; } else { goto anon1023_Else; }
anon1022_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume unfoldingMask#_587_$_22 == unfoldingMask#_587_$_20;
	if ($_$_condition_$337) { goto anon1023_Then; } else { goto anon1023_Else; }
anon1134_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_6,Mask_$_140,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_141 == Mask_$_140[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys := Mask_$_140[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_140[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_141);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_6,Mask_$_141,ZeroMask);
	assume wf(Heap_$_6,Mask_$_141,ZeroMask);
	assume Mask_$_142 == Mask_$_141;
	if ($_$_condition_$338) { goto anon1135_Then; } else { goto anon1135_Else; }
anon1134_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.right] == null;
	assume Mask_$_142 == Mask_$_140;
	if ($_$_condition_$339) { goto anon1135_Then; } else { goto anon1135_Else; }
anon659:
	assume IsGoodMask(exhaleMask#_777_$_6);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_6,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_7 == exhaleMask#_777_$_6;
	if ($_$_condition_$342) { goto anon1193_Then; } else { goto anon1193_Else; }
anon1247_Then:
	assume !CanRead(exhaleMask#_853_$_10,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_852_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon768;
anon1247_Else:
	assume CanRead(exhaleMask#_853_$_10,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon768;
anon1248_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  333.7: The precondition at 616.12 might not hold. The permission at 616.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  333.7: The precondition at 616.12 might not hold. Insufficient fraction at 616.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_853_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_853_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_853_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_853_$_12 == exhaleMask#_853_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_853_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_853_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_853_$_12);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_12,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_853_$_13 == exhaleMask#_853_$_12;
	if ($_$_condition_$359) { goto anon1249_Then; } else { goto anon1249_Else; }
anon1248_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_853_$_13 == exhaleMask#_853_$_11;
	if ($_$_condition_$360) { goto anon1249_Then; } else { goto anon1249_Else; }
anon783:
	assume IsGoodMask(exhaleMask#_876_$_6);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_6,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_7 == exhaleMask#_876_$_6;
	if ($_$_condition_$343) { goto anon1255_Then; } else { goto anon1255_Else; }
anon1023_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#241 : Integer :: ( ((0 <= rk#80#241) && (rk#80#241 < Seq#Length(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#241)) ));
	if ($_$_condition_$344) { goto anon1024_Then; } else { goto anon1024_Else; }
anon1023_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$345) { goto anon1024_Then; } else { goto anon1024_Else; }
anon1135_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume wf(Heap_$_6,Mask_$_142,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_143 == Mask_$_142[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_142[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_142[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_143);
	assume IsGoodState(heapFragment(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_6,Mask_$_143,ZeroMask);
	assume wf(Heap_$_6,Mask_$_143,ZeroMask);
	assume Mask_$_144 == Mask_$_143;
	if ($_$_condition_$346) { goto anon1136_Then; } else { goto anon1136_Else; }
anon1135_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.right] == null;
	assume Mask_$_144 == Mask_$_142;
	if ($_$_condition_$347) { goto anon1136_Then; } else { goto anon1136_Else; }
anon1186_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  315.7: The precondition at 756.12 might not hold. The permission at 756.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  315.7: The precondition at 756.12 might not hold. Insufficient fraction at 756.25 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_754_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_754_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_754_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_754_$_10 == exhaleMask#_754_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_754_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_754_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_754_$_10);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_10,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_754_$_11 == exhaleMask#_754_$_10;
	if ($_$_condition_$348) { goto anon1187_Then; } else { goto anon1187_Else; }
anon1186_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_754_$_11 == exhaleMask#_754_$_9;
	if ($_$_condition_$349) { goto anon1187_Then; } else { goto anon1187_Else; }
anon768:
	assume IsGoodMask(exhaleMask#_853_$_10);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_10,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_853_$_11 == exhaleMask#_853_$_10;
	if ($_$_condition_$352) { goto anon1248_Then; } else { goto anon1248_Else; }
anon1024_Then:
	assume !(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon323;
anon1024_Else:
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon323;
anon1136_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume (forall  rk#80#263 : Integer :: ( ((0 <= rk#80#263) && (rk#80#263 < Seq#Length(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_6[r#20_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys],rk#80#263)) ));
	if ($_$_condition_$355) { goto anon1137_Then; } else { goto anon1137_Else; }
anon1136_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.right] == null;
	if ($_$_condition_$356) { goto anon1137_Then; } else { goto anon1137_Else; }
anon1187_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  315.7: The precondition at 757.12 might not hold. The permission at 757.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  315.7: The precondition at 757.12 might not hold. Insufficient fraction at 757.25 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_754_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_754_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_754_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_754_$_12 == exhaleMask#_754_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_754_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_754_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_754_$_12);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_12,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_754_$_13 == exhaleMask#_754_$_12;
	goto anon649;
anon1187_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_754_$_13 == exhaleMask#_754_$_11;
	goto anon649;
anon1194_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  317.7: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  317.7: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_777_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_777_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_777_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_777_$_10 == exhaleMask#_777_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_777_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_777_$_9[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_777_$_10);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_10,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_11 == exhaleMask#_777_$_10;
	if ($_$_condition_$357) { goto anon1195_Then; } else { goto anon1195_Else; }
anon1194_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_777_$_11 == exhaleMask#_777_$_9;
	if ($_$_condition_$358) { goto anon1195_Then; } else { goto anon1195_Else; }
anon1256_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  336.7: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  336.7: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_876_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_876_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_876_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_876_$_10 == exhaleMask#_876_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_876_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_876_$_9[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_876_$_10);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_10,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_11 == exhaleMask#_876_$_10;
	if ($_$_condition_$361) { goto anon1257_Then; } else { goto anon1257_Else; }
anon1256_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_876_$_11 == exhaleMask#_876_$_9;
	if ($_$_condition_$362) { goto anon1257_Then; } else { goto anon1257_Else; }
anon323:
	assume Seq#Equal(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key])),ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$2 : Integer :: ( Seq#Contains(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$2) <==> ((((!(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$2)) || ((!(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$2))) || (kk#81_$2 == unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume unfoldingHeap#_586_$_1[unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assume IsGoodMask(unfoldingMask#_587_$_22);
	assume wf(unfoldingHeap#_586_$_1,unfoldingMask#_587_$_22,ZeroMask);
	if ($_$_condition_$363) { goto anon1025_Then; } else { goto anon1025_Else; }
anon1137_Then:
	assume !(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null);
	assume Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon552;
anon1137_Else:
	assume Heap_$_6[r#20_$_0,AVLTreeNode.right] == null;
	goto anon552;
anon649:
	assert { :msg "  315.7: The precondition at 761.12 might not hold. The permission at 761.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  315.7: The precondition at 761.12 might not hold. Insufficient fraction at 761.12 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_754_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_754_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_754_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_754_$_14 == exhaleMask#_754_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_754_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_754_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$364) { goto anon1188_Then; } else { goto anon1188_Else; }
anon1195_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  317.7: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  317.7: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_777_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_777_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_777_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_777_$_12 == exhaleMask#_777_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_777_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_777_$_11[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_777_$_12);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_12,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_13 == exhaleMask#_777_$_12;
	if ($_$_condition_$365) { goto anon1196_Then; } else { goto anon1196_Else; }
anon1195_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_777_$_13 == exhaleMask#_777_$_11;
	if ($_$_condition_$366) { goto anon1196_Then; } else { goto anon1196_Else; }
anon1249_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  333.7: The precondition at 617.12 might not hold. The permission at 617.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  333.7: The precondition at 617.12 might not hold. Insufficient fraction at 617.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_853_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_853_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_853_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_853_$_14 == exhaleMask#_853_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_853_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_853_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_853_$_14);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_14,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_853_$_15 == exhaleMask#_853_$_14;
	if ($_$_condition_$367) { goto anon1250_Then; } else { goto anon1250_Else; }
anon1249_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_853_$_15 == exhaleMask#_853_$_13;
	if ($_$_condition_$368) { goto anon1250_Then; } else { goto anon1250_Else; }
anon1257_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null);
	assert { :msg "  336.7: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  336.7: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_876_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_876_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_876_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_876_$_12 == exhaleMask#_876_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_876_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_876_$_11[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_876_$_12);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_12,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_13 == exhaleMask#_876_$_12;
	if ($_$_condition_$369) { goto anon1258_Then; } else { goto anon1258_Else; }
anon1257_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null;
	assume exhaleMask#_876_$_13 == exhaleMask#_876_$_11;
	if ($_$_condition_$370) { goto anon1258_Then; } else { goto anon1258_Else; }
anon1025_Then:
	assume false;
	goto $exit;
anon1025_Else:
	assume !false;
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume assertSecMask#_582_$_0 == ZeroMask[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key := ZeroMask[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R := ZeroMask[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_0);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_0);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_0);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_1 == assertSecMask#_582_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_582_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_582_$_0[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_1);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_1);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_1);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_582_$_2 == assertSecMask#_582_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left := assertSecMask#_582_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R := assertSecMask#_582_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_2);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_2);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_2);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume assertSecMask#_582_$_3 == assertSecMask#_582_$_2[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right := assertSecMask#_582_$_2[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R := assertSecMask#_582_$_2[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_3);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_3);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_3);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_4 == assertSecMask#_582_$_3[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_582_$_3[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_582_$_3[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_4);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_4);
	assume !(Heap_$_1[this,AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_4);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_5 == assertSecMask#_582_$_4[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_582_$_4[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582_$_4[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_5);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_5);
	if ($_$_condition_$371) { goto anon1052_Then; } else { goto anon1052_Else; }
anon552:
	assume Seq#Equal(Heap_$_6[r#20_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_6[r#20_$_0,AVLTreeNode.key])),ite(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_6[r#20_$_0,AVLTreeNode.keys],Heap_$_6[r#20_$_0,AVLTreeNode.key]);
	assume (forall  kk#81_$3 : Integer :: ( Seq#Contains(Heap_$_6[r#20_$_0,AVLTreeNode.keys],kk#81_$3) <==> ((((!(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$3)) || ((!(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys],kk#81_$3))) || (kk#81_$3 == Heap_$_6[r#20_$_0,AVLTreeNode.key])) ));
	assume Heap_$_6[r#20_$_0,AVLTreeNode.height] == ite(ite(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_6[r#20_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_6[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_6[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_6[Heap_$_6[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_6[r#20_$_0,AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_6[r#20_$_0,AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_6[r#20_$_0,AVLTreeNode.height] > 0;
	assume IsGoodMask(Mask_$_144);
	assume wf(Heap_$_6,Mask_$_144,ZeroMask);
	assert { :msg "  300.5: Location might not be writable" } CanWrite(Mask_$_144,r#20_$_0,AVLTreeNode.left);
	assume Heap_$_7 == Heap_$_6[r#20_$_0,AVLTreeNode.left := nl#24_$_1];
	assume wf(Heap_$_7,Mask_$_144,ZeroMask);
	assert { :msg "  301.5: Location might not be writable" } CanWrite(Mask_$_144,r#20_$_0,AVLTreeNode.right);
	assume Heap_$_8 == Heap_$_7[r#20_$_0,AVLTreeNode.right := nr#26_$_1];
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume ((0 < methodCallK#_698) && ((1000 * methodCallK#_698) < Fractions(1))) && ((1000 * methodCallK#_698) < methodK#_506);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assert { :msg "  302.5: The target of the method call might be null." } !(r#20_$_0 == null);
	if ($_$_condition_$372) { goto anon1138_Then; } else { goto anon1138_Else; }
anon1188_Then:
	assume !CanRead(exhaleMask#_754_$_14,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_753_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon651;
anon1188_Else:
	assume CanRead(exhaleMask#_754_$_14,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon651;
anon1196_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  317.7: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  317.7: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_777_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_777_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_777_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_777_$_14 == exhaleMask#_777_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_777_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_777_$_13[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$373) { goto anon1197_Then; } else { goto anon1197_Else; }
anon1196_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_777_$_15 == exhaleMask#_777_$_13;
	if ($_$_condition_$374) { goto anon1198_Then; } else { goto anon1198_Else; }
anon1250_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  333.7: The precondition at 618.12 might not hold. The permission at 618.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  333.7: The precondition at 618.12 might not hold. Insufficient fraction at 618.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_853_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_853_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_853_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_853_$_16 == exhaleMask#_853_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_853_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_853_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_853_$_16);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_853_$_16,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_853_$_17 == exhaleMask#_853_$_16;
	goto anon775;
anon1250_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_853_$_17 == exhaleMask#_853_$_15;
	goto anon775;
anon1258_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  336.7: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  336.7: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_876_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_876_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_876_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_876_$_14 == exhaleMask#_876_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_876_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_876_$_13[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$375) { goto anon1259_Then; } else { goto anon1259_Else; }
anon1258_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_876_$_15 == exhaleMask#_876_$_13;
	if ($_$_condition_$376) { goto anon1260_Then; } else { goto anon1260_Else; }
anon1052_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_5);
	assume Fractions(100) > 0;
	assume assertSecMask#_582_$_6 == assertSecMask#_582_$_5[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid := assertSecMask#_582_$_5[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R := assertSecMask#_582_$_5[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_6);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_6);
	assume assertSecMask#_582_$_7 == assertSecMask#_582_$_6;
	if ($_$_condition_$377) { goto anon1053_Then; } else { goto anon1053_Else; }
anon1052_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_582_$_7 == assertSecMask#_582_$_5;
	if ($_$_condition_$378) { goto anon1053_Then; } else { goto anon1053_Else; }
anon1138_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null);
	assert { :msg "  302.5: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#265 : Integer :: ( ((0 <= k#92#265) && (k#92#265 < Seq#Length(Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys],k#92#265) < Heap_$_8[r#20_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$379) { goto anon1139_Then; } else { goto anon1139_Else; }
anon1138_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$380) { goto anon1139_Then; } else { goto anon1139_Else; }
anon651:
	assume IsGoodMask(exhaleMask#_754_$_14);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_14,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 762.12 might not hold. The permission at 762.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  315.7: The precondition at 762.12 might not hold. Insufficient fraction at 762.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_754_$_14[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_754_$_14[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_754_$_14[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_754_$_15 == exhaleMask#_754_$_14[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_754_$_14[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_754_$_14[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_754_$_15);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_15,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 763.12 might not hold. The permission at 763.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  315.7: The precondition at 763.12 might not hold. Insufficient fraction at 763.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_754_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_754_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_754_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_754_$_16 == exhaleMask#_754_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_754_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_754_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_754_$_16);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_16,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assert { :msg "  315.7: The precondition at 764.12 might not hold. The permission at 764.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  315.7: The precondition at 764.12 might not hold. Insufficient fraction at 764.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_754_$_16[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_754_$_16[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_754_$_16[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_754_$_17 == exhaleMask#_754_$_16[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_754_$_16[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_754_$_16[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_754_$_17);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_754_$_17,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_753_$_0,exhaleHeap#_737_$_0,exhaleMask#_754_$_17,ZeroMask);
	assume IsGoodMask(exhaleMask#_754_$_17);
	assume wf(exhaleHeap#_753_$_0,exhaleMask#_754_$_17,ZeroMask);
	assume (r#277_$_0 == null) || (dtype(r#277_$_0) == AVLTreeNode#t);
	assume !(r#277_$_0 == null);
	assume !(r#277_$_0 == null);
	assume wf(exhaleHeap#_753_$_0,exhaleMask#_754_$_17,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_83 == exhaleMask#_754_$_17[r#277_$_0,AVLTreeNode.valid := exhaleMask#_754_$_17[r#277_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_754_$_17[r#277_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_83);
	assume IsGoodState(heapFragment(exhaleHeap#_753_$_0[r#277_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_753_$_0,Mask_$_83,ZeroMask);
	assume wf(exhaleHeap#_753_$_0,Mask_$_83,ZeroMask);
	assume !(r#277_$_0 == null);
	assume wf(exhaleHeap#_753_$_0,Mask_$_83,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_84 == Mask_$_83[r#277_$_0,AVLTreeNode.height := Mask_$_83[r#277_$_0,AVLTreeNode.height][perm$R := Mask_$_83[r#277_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_84);
	assume IsGoodState(heapFragment(exhaleHeap#_753_$_0[r#277_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_753_$_0,Mask_$_84,ZeroMask);
	assume wf(exhaleHeap#_753_$_0,Mask_$_84,ZeroMask);
	assume !(r#277_$_0 == null);
	assume wf(exhaleHeap#_753_$_0,Mask_$_84,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_85 == Mask_$_84[r#277_$_0,AVLTreeNode.keys := Mask_$_84[r#277_$_0,AVLTreeNode.keys][perm$R := Mask_$_84[r#277_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_85);
	assume IsGoodState(heapFragment(exhaleHeap#_753_$_0[r#277_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_753_$_0,Mask_$_85,ZeroMask);
	assume wf(exhaleHeap#_753_$_0,Mask_$_85,ZeroMask);
	assume !(r#277_$_0 == null);
	assume wf(exhaleHeap#_753_$_0,Mask_$_85,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_86 == Mask_$_85[r#277_$_0,AVLTreeNode.balanceFactor := Mask_$_85[r#277_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_85[r#277_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_86);
	assume IsGoodState(heapFragment(exhaleHeap#_753_$_0[r#277_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_753_$_0,Mask_$_86,ZeroMask);
	assume wf(exhaleHeap#_753_$_0,Mask_$_86,ZeroMask);
	assume (exhaleHeap#_753_$_0[r#277_$_0,AVLTreeNode.height] == exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) || (exhaleHeap#_753_$_0[r#277_$_0,AVLTreeNode.height] == (exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height] + 1));
	assume Seq#Equal(exhaleHeap#_753_$_0[r#277_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_737_$_0[this,AVLTreeNode.key])),exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume IsGoodMask(Mask_$_86);
	assume wf(exhaleHeap#_753_$_0,Mask_$_86,ZeroMask);
	assume Mask_$_149 == Mask_$_86;
	assume Heap_$_9 == exhaleHeap#_753_$_0;
	assume r#20_$_3 == r#277_$_0;
	if ($_$_condition_$381) { goto anon1275_Then; } else { goto anon1275_Else; }
anon1197_Then:
	assume !CanRead(exhaleMask#_777_$_14,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_776_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon669;
anon1197_Else:
	assume CanRead(exhaleMask#_777_$_14,ZeroMask,exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon669;
anon1198_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  317.7: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  317.7: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_777_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_777_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_777_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_777_$_16 == exhaleMask#_777_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_777_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_777_$_15[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_777_$_16);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_16,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_17 == exhaleMask#_777_$_16;
	if ($_$_condition_$390) { goto anon1199_Then; } else { goto anon1199_Else; }
anon1198_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_777_$_17 == exhaleMask#_777_$_15;
	if ($_$_condition_$391) { goto anon1199_Then; } else { goto anon1199_Else; }
anon775:
	assume IsGoodExhaleState(exhaleHeap#_852_$_0,exhaleHeap#_836_$_0,exhaleMask#_853_$_17,ZeroMask);
	assume IsGoodMask(exhaleMask#_853_$_17);
	assume wf(exhaleHeap#_852_$_0,exhaleMask#_853_$_17,ZeroMask);
	assume (r#300_$_0 == null) || (dtype(r#300_$_0) == AVLTreeNode#t);
	assume !(r#300_$_0 == null);
	assume !(r#300_$_0 == null);
	assume wf(exhaleHeap#_852_$_0,exhaleMask#_853_$_17,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_53 == exhaleMask#_853_$_17[r#300_$_0,AVLTreeNode.valid := exhaleMask#_853_$_17[r#300_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_853_$_17[r#300_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_53);
	assume IsGoodState(heapFragment(exhaleHeap#_852_$_0[r#300_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_852_$_0,Mask_$_53,ZeroMask);
	assume wf(exhaleHeap#_852_$_0,Mask_$_53,ZeroMask);
	assume !(r#300_$_0 == null);
	assume wf(exhaleHeap#_852_$_0,Mask_$_53,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_54 == Mask_$_53[r#300_$_0,AVLTreeNode.height := Mask_$_53[r#300_$_0,AVLTreeNode.height][perm$R := Mask_$_53[r#300_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_54);
	assume IsGoodState(heapFragment(exhaleHeap#_852_$_0[r#300_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_852_$_0,Mask_$_54,ZeroMask);
	assume wf(exhaleHeap#_852_$_0,Mask_$_54,ZeroMask);
	assume !(r#300_$_0 == null);
	assume wf(exhaleHeap#_852_$_0,Mask_$_54,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_55 == Mask_$_54[r#300_$_0,AVLTreeNode.keys := Mask_$_54[r#300_$_0,AVLTreeNode.keys][perm$R := Mask_$_54[r#300_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_55);
	assume IsGoodState(heapFragment(exhaleHeap#_852_$_0[r#300_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_852_$_0,Mask_$_55,ZeroMask);
	assume wf(exhaleHeap#_852_$_0,Mask_$_55,ZeroMask);
	assume !(r#300_$_0 == null);
	assume wf(exhaleHeap#_852_$_0,Mask_$_55,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_56 == Mask_$_55[r#300_$_0,AVLTreeNode.balanceFactor := Mask_$_55[r#300_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_55[r#300_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_56);
	assume IsGoodState(heapFragment(exhaleHeap#_852_$_0[r#300_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_852_$_0,Mask_$_56,ZeroMask);
	assume wf(exhaleHeap#_852_$_0,Mask_$_56,ZeroMask);
	assume (exhaleHeap#_852_$_0[r#300_$_0,AVLTreeNode.height] == exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) || (exhaleHeap#_852_$_0[r#300_$_0,AVLTreeNode.height] == (exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height] + 1));
	assume Seq#Equal(exhaleHeap#_852_$_0[r#300_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Singleton(exhaleHeap#_836_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume IsGoodMask(Mask_$_56);
	assume wf(exhaleHeap#_852_$_0,Mask_$_56,ZeroMask);
	assume Mask_$_149 == Mask_$_56;
	assume Heap_$_9 == exhaleHeap#_852_$_0;
	assume r#20_$_3 == r#300_$_0;
	if ($_$_condition_$382) { goto anon1275_Then; } else { goto anon1275_Else; }
anon1259_Then:
	assume !CanRead(exhaleMask#_876_$_14,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_875_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon793;
anon1259_Else:
	assume CanRead(exhaleMask#_876_$_14,ZeroMask,exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon793;
anon1260_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  336.7: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  336.7: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_876_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_876_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_876_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_876_$_16 == exhaleMask#_876_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_876_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_876_$_15[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_876_$_16);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_16,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_17 == exhaleMask#_876_$_16;
	if ($_$_condition_$392) { goto anon1261_Then; } else { goto anon1261_Else; }
anon1260_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_876_$_17 == exhaleMask#_876_$_15;
	if ($_$_condition_$393) { goto anon1261_Then; } else { goto anon1261_Else; }
anon1053_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_7);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_8 == assertSecMask#_582_$_7[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height := assertSecMask#_582_$_7[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R := assertSecMask#_582_$_7[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_8);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_8);
	assume assertSecMask#_582_$_9 == assertSecMask#_582_$_8;
	if ($_$_condition_$383) { goto anon1054_Then; } else { goto anon1054_Else; }
anon1053_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_582_$_9 == assertSecMask#_582_$_7;
	if ($_$_condition_$384) { goto anon1054_Then; } else { goto anon1054_Else; }
anon1139_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null);
	assert { :msg "  302.5: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#266 : Integer :: ( ((0 <= k#93#266) && (k#93#266 < Seq#Length(Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_8[r#20_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#93#266)) ));
	goto anon556;
anon1139_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.right] == null;
	goto anon556;
anon669:
	assume IsGoodMask(exhaleMask#_777_$_14);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_14,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_15 == exhaleMask#_777_$_14;
	if ($_$_condition_$385) { goto anon1198_Then; } else { goto anon1198_Else; }
anon793:
	assume IsGoodMask(exhaleMask#_876_$_14);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_14,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_15 == exhaleMask#_876_$_14;
	if ($_$_condition_$386) { goto anon1260_Then; } else { goto anon1260_Else; }
anon1054_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_9);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_10 == assertSecMask#_582_$_9[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys := assertSecMask#_582_$_9[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R := assertSecMask#_582_$_9[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_10);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_10);
	assume assertSecMask#_582_$_11 == assertSecMask#_582_$_10;
	if ($_$_condition_$387) { goto anon1055_Then; } else { goto anon1055_Else; }
anon1054_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_582_$_11 == assertSecMask#_582_$_9;
	if ($_$_condition_$388) { goto anon1055_Then; } else { goto anon1055_Else; }
anon556:
	assert { :msg "  302.5: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  302.5: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  302.5: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_144[r#20_$_0,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_144[r#20_$_0,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_144[r#20_$_0,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_700_$_0 == Mask_$_144[r#20_$_0,AVLTreeNode.key := Mask_$_144[r#20_$_0,AVLTreeNode.key][perm$R := Mask_$_144[r#20_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_700_$_0);
	assume wf(Heap_$_8,exhaleMask#_700_$_0,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assert { :msg "  302.5: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_700_$_0[r#20_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_700_$_0[r#20_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_700_$_0[r#20_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_700_$_1 == exhaleMask#_700_$_0[r#20_$_0,AVLTreeNode.height := exhaleMask#_700_$_0[r#20_$_0,AVLTreeNode.height][perm$R := exhaleMask#_700_$_0[r#20_$_0,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_700_$_1);
	assume wf(Heap_$_8,exhaleMask#_700_$_1,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assert { :msg "  302.5: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_700_$_1[r#20_$_0,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_700_$_1[r#20_$_0,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_700_$_1[r#20_$_0,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_700_$_2 == exhaleMask#_700_$_1[r#20_$_0,AVLTreeNode.left := exhaleMask#_700_$_1[r#20_$_0,AVLTreeNode.left][perm$R := exhaleMask#_700_$_1[r#20_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_700_$_2);
	assume wf(Heap_$_8,exhaleMask#_700_$_2,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assert { :msg "  302.5: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_700_$_2[r#20_$_0,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_700_$_2[r#20_$_0,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_700_$_2[r#20_$_0,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_700_$_3 == exhaleMask#_700_$_2[r#20_$_0,AVLTreeNode.right := exhaleMask#_700_$_2[r#20_$_0,AVLTreeNode.right][perm$R := exhaleMask#_700_$_2[r#20_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_700_$_3);
	assume wf(Heap_$_8,exhaleMask#_700_$_3,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assert { :msg "  302.5: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_700_$_3[r#20_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_700_$_3[r#20_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_700_$_3[r#20_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_700_$_4 == exhaleMask#_700_$_3[r#20_$_0,AVLTreeNode.keys := exhaleMask#_700_$_3[r#20_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_700_$_3[r#20_$_0,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_700_$_4);
	assume wf(Heap_$_8,exhaleMask#_700_$_4,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assert { :msg "  302.5: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_700_$_4[r#20_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_700_$_4[r#20_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_700_$_4[r#20_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_700_$_5 == exhaleMask#_700_$_4[r#20_$_0,AVLTreeNode.balanceFactor := exhaleMask#_700_$_4[r#20_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_700_$_4[r#20_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_700_$_5);
	assume wf(Heap_$_8,exhaleMask#_700_$_5,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	if ($_$_condition_$389) { goto anon1140_Then; } else { goto anon1140_Else; }
anon1055_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_11);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_12 == assertSecMask#_582_$_11[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor := assertSecMask#_582_$_11[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582_$_11[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_12);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_12);
	assume assertSecMask#_582_$_13 == assertSecMask#_582_$_12;
	if ($_$_condition_$394) { goto anon1056_Then; } else { goto anon1056_Else; }
anon1055_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	assume assertSecMask#_582_$_13 == assertSecMask#_582_$_11;
	if ($_$_condition_$395) { goto anon1056_Then; } else { goto anon1056_Else; }
anon1140_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null);
	assert { :msg "  302.5: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_700_$_5[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_700_$_5[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_700_$_5[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_700_$_6 == exhaleMask#_700_$_5[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_700_$_5[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_700_$_5[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$396) { goto anon1141_Then; } else { goto anon1141_Else; }
anon1140_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_700_$_7 == exhaleMask#_700_$_5;
	if ($_$_condition_$397) { goto anon1142_Then; } else { goto anon1142_Else; }
anon1199_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  317.7: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  317.7: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_777_$_17[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_777_$_17[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_777_$_17[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_777_$_18 == exhaleMask#_777_$_17[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_777_$_17[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_777_$_17[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_777_$_18);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_18,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_19 == exhaleMask#_777_$_18;
	if ($_$_condition_$398) { goto anon1200_Then; } else { goto anon1200_Else; }
anon1199_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_777_$_19 == exhaleMask#_777_$_17;
	if ($_$_condition_$399) { goto anon1200_Then; } else { goto anon1200_Else; }
anon1261_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  336.7: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  336.7: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_876_$_17[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_876_$_17[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_876_$_17[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_876_$_18 == exhaleMask#_876_$_17[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_876_$_17[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_876_$_17[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_876_$_18);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_18,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_19 == exhaleMask#_876_$_18;
	if ($_$_condition_$400) { goto anon1262_Then; } else { goto anon1262_Else; }
anon1261_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_876_$_19 == exhaleMask#_876_$_17;
	if ($_$_condition_$401) { goto anon1262_Then; } else { goto anon1262_Else; }
anon1056_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume (forall  lk#79#246 : Integer :: ( ((0 <= lk#79#246) && (lk#79#246 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],lk#79#246) < Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key]) ));
	if ($_$_condition_$402) { goto anon1057_Then; } else { goto anon1057_Else; }
anon1056_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$403) { goto anon1057_Then; } else { goto anon1057_Else; }
anon1141_Then:
	assume !CanRead(exhaleMask#_700_$_6,ZeroMask,Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_699_$_0[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon559;
anon1141_Else:
	assume CanRead(exhaleMask#_700_$_6,ZeroMask,Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon559;
anon1142_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null);
	assert { :msg "  302.5: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  302.5: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_700_$_7[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_700_$_7[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_700_$_7[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_700_$_8 == exhaleMask#_700_$_7[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_700_$_7[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_700_$_7[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_700_$_8);
	assume wf(Heap_$_8,exhaleMask#_700_$_8,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_9 == exhaleMask#_700_$_8;
	if ($_$_condition_$411) { goto anon1143_Then; } else { goto anon1143_Else; }
anon1142_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_700_$_9 == exhaleMask#_700_$_7;
	if ($_$_condition_$412) { goto anon1143_Then; } else { goto anon1143_Else; }
anon1200_Then:
	assume !(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  317.7: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  317.7: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_777_$_19[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_777_$_19[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_777_$_19[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_777_$_20 == exhaleMask#_777_$_19[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_777_$_19[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_777_$_19[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_777_$_20);
	assume wf(exhaleHeap#_737_$_0,exhaleMask#_777_$_20,ZeroMask);
	assume wf(exhaleHeap#_737_$_0,Mask_$_78,ZeroMask);
	assume exhaleMask#_777_$_21 == exhaleMask#_777_$_20;
	goto anon676;
anon1200_Else:
	assume exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_777_$_21 == exhaleMask#_777_$_19;
	goto anon676;
anon1262_Then:
	assume !(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null);
	assert { :msg "  336.7: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  336.7: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_876_$_19[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_876_$_19[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_876_$_19[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_876_$_20 == exhaleMask#_876_$_19[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_876_$_19[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_876_$_19[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_876_$_20);
	assume wf(exhaleHeap#_836_$_0,exhaleMask#_876_$_20,ZeroMask);
	assume wf(exhaleHeap#_836_$_0,Mask_$_48,ZeroMask);
	assume exhaleMask#_876_$_21 == exhaleMask#_876_$_20;
	goto anon800;
anon1262_Else:
	assume exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null;
	assume exhaleMask#_876_$_21 == exhaleMask#_876_$_19;
	goto anon800;
anon1057_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$404) { goto anon1058_Then; } else { goto anon1058_Else; }
anon1057_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null;
	if ($_$_condition_$405) { goto anon1058_Then; } else { goto anon1058_Else; }
anon559:
	assume IsGoodMask(exhaleMask#_700_$_6);
	assume wf(Heap_$_8,exhaleMask#_700_$_6,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_7 == exhaleMask#_700_$_6;
	if ($_$_condition_$406) { goto anon1142_Then; } else { goto anon1142_Else; }
anon676:
	assume IsGoodExhaleState(exhaleHeap#_776_$_0,exhaleHeap#_737_$_0,exhaleMask#_777_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_777_$_21);
	assume wf(exhaleHeap#_776_$_0,exhaleMask#_777_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_776_$_0,exhaleMask#_777_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_79 == exhaleMask#_777_$_21[this,AVLTreeNode.valid := exhaleMask#_777_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_777_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_79);
	assume IsGoodState(heapFragment(exhaleHeap#_776_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_776_$_0,Mask_$_79,ZeroMask);
	assume wf(exhaleHeap#_776_$_0,Mask_$_79,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_776_$_0,Mask_$_79,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_80 == Mask_$_79[this,AVLTreeNode.height := Mask_$_79[this,AVLTreeNode.height][perm$R := Mask_$_79[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_80);
	assume IsGoodState(heapFragment(exhaleHeap#_776_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_776_$_0,Mask_$_80,ZeroMask);
	assume wf(exhaleHeap#_776_$_0,Mask_$_80,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_776_$_0,Mask_$_80,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_81 == Mask_$_80[this,AVLTreeNode.keys := Mask_$_80[this,AVLTreeNode.keys][perm$R := Mask_$_80[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_81);
	assume IsGoodState(heapFragment(exhaleHeap#_776_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_776_$_0,Mask_$_81,ZeroMask);
	assume wf(exhaleHeap#_776_$_0,Mask_$_81,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_776_$_0,Mask_$_81,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_82 == Mask_$_81[this,AVLTreeNode.balanceFactor := Mask_$_81[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_81[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_82);
	assume IsGoodState(heapFragment(exhaleHeap#_776_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_776_$_0,Mask_$_82,ZeroMask);
	assume wf(exhaleHeap#_776_$_0,Mask_$_82,ZeroMask);
	assume Seq#Equal(exhaleHeap#_776_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_737_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_776_$_0[this,AVLTreeNode.height] == ite(ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_776_$_0[this,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_737_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_737_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_737_$_0[exhaleHeap#_737_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_82);
	assume wf(exhaleHeap#_776_$_0,Mask_$_82,ZeroMask);
	assume Mask_$_149 == Mask_$_82;
	assume Heap_$_9 == exhaleHeap#_776_$_0;
	assume r#20_$_3 == this;
	if ($_$_condition_$407) { goto anon1275_Then; } else { goto anon1275_Else; }
anon800:
	assume IsGoodExhaleState(exhaleHeap#_875_$_0,exhaleHeap#_836_$_0,exhaleMask#_876_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_876_$_21);
	assume wf(exhaleHeap#_875_$_0,exhaleMask#_876_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_875_$_0,exhaleMask#_876_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_49 == exhaleMask#_876_$_21[this,AVLTreeNode.valid := exhaleMask#_876_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_876_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_49);
	assume IsGoodState(heapFragment(exhaleHeap#_875_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_875_$_0,Mask_$_49,ZeroMask);
	assume wf(exhaleHeap#_875_$_0,Mask_$_49,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_875_$_0,Mask_$_49,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_50 == Mask_$_49[this,AVLTreeNode.height := Mask_$_49[this,AVLTreeNode.height][perm$R := Mask_$_49[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_50);
	assume IsGoodState(heapFragment(exhaleHeap#_875_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_875_$_0,Mask_$_50,ZeroMask);
	assume wf(exhaleHeap#_875_$_0,Mask_$_50,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_875_$_0,Mask_$_50,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_51 == Mask_$_50[this,AVLTreeNode.keys := Mask_$_50[this,AVLTreeNode.keys][perm$R := Mask_$_50[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_51);
	assume IsGoodState(heapFragment(exhaleHeap#_875_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_875_$_0,Mask_$_51,ZeroMask);
	assume wf(exhaleHeap#_875_$_0,Mask_$_51,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_875_$_0,Mask_$_51,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_52 == Mask_$_51[this,AVLTreeNode.balanceFactor := Mask_$_51[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_51[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_52);
	assume IsGoodState(heapFragment(exhaleHeap#_875_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_875_$_0,Mask_$_52,ZeroMask);
	assume wf(exhaleHeap#_875_$_0,Mask_$_52,ZeroMask);
	assume Seq#Equal(exhaleHeap#_875_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(exhaleHeap#_836_$_0[this,AVLTreeNode.key])),ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_875_$_0[this,AVLTreeNode.height] == ite(ite(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height]),ite(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_875_$_0[this,AVLTreeNode.balanceFactor] == (ite(exhaleHeap#_836_$_0[this,AVLTreeNode.left] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(exhaleHeap#_836_$_0[this,AVLTreeNode.right] == null,0,exhaleHeap#_836_$_0[exhaleHeap#_836_$_0[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_52);
	assume wf(exhaleHeap#_875_$_0,Mask_$_52,ZeroMask);
	assume Mask_$_149 == Mask_$_52;
	assume Heap_$_9 == exhaleHeap#_875_$_0;
	assume r#20_$_3 == this;
	if ($_$_condition_$408) { goto anon1275_Then; } else { goto anon1275_Else; }
anon1058_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_13);
	assume Fractions(100) > 0;
	assume assertSecMask#_582_$_14 == assertSecMask#_582_$_13[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid := assertSecMask#_582_$_13[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R := assertSecMask#_582_$_13[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_14);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_14);
	assume assertSecMask#_582_$_15 == assertSecMask#_582_$_14;
	if ($_$_condition_$409) { goto anon1059_Then; } else { goto anon1059_Else; }
anon1058_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_582_$_15 == assertSecMask#_582_$_13;
	if ($_$_condition_$410) { goto anon1059_Then; } else { goto anon1059_Else; }
anon1059_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_15);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_16 == assertSecMask#_582_$_15[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height := assertSecMask#_582_$_15[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R := assertSecMask#_582_$_15[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_16);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_16);
	assume assertSecMask#_582_$_17 == assertSecMask#_582_$_16;
	if ($_$_condition_$413) { goto anon1060_Then; } else { goto anon1060_Else; }
anon1059_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_582_$_17 == assertSecMask#_582_$_15;
	if ($_$_condition_$414) { goto anon1060_Then; } else { goto anon1060_Else; }
anon1143_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null);
	assert { :msg "  302.5: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  302.5: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_700_$_9[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_700_$_9[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_700_$_9[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_700_$_10 == exhaleMask#_700_$_9[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_700_$_9[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_700_$_9[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_700_$_10);
	assume wf(Heap_$_8,exhaleMask#_700_$_10,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_11 == exhaleMask#_700_$_10;
	if ($_$_condition_$415) { goto anon1144_Then; } else { goto anon1144_Else; }
anon1143_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_700_$_11 == exhaleMask#_700_$_9;
	if ($_$_condition_$416) { goto anon1144_Then; } else { goto anon1144_Else; }
anon1060_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_17);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_18 == assertSecMask#_582_$_17[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys := assertSecMask#_582_$_17[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R := assertSecMask#_582_$_17[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_18);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_18);
	assume assertSecMask#_582_$_19 == assertSecMask#_582_$_18;
	if ($_$_condition_$417) { goto anon1061_Then; } else { goto anon1061_Else; }
anon1060_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_582_$_19 == assertSecMask#_582_$_17;
	if ($_$_condition_$418) { goto anon1061_Then; } else { goto anon1061_Else; }
anon1144_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null);
	assert { :msg "  302.5: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  302.5: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_700_$_11[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_700_$_11[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_700_$_11[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_700_$_12 == exhaleMask#_700_$_11[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_700_$_11[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_700_$_11[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_700_$_12);
	assume wf(Heap_$_8,exhaleMask#_700_$_12,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_13 == exhaleMask#_700_$_12;
	if ($_$_condition_$419) { goto anon1145_Then; } else { goto anon1145_Else; }
anon1144_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_700_$_13 == exhaleMask#_700_$_11;
	if ($_$_condition_$420) { goto anon1145_Then; } else { goto anon1145_Else; }
anon1061_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_19);
	assume true;
	assume Fractions(50) > 0;
	assume assertSecMask#_582_$_20 == assertSecMask#_582_$_19[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor := assertSecMask#_582_$_19[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := assertSecMask#_582_$_19[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_20);
	assume wf(Heap_$_1,Mask_$_26,assertSecMask#_582_$_20);
	assume assertSecMask#_582_$_21 == assertSecMask#_582_$_20;
	if ($_$_condition_$421) { goto anon1062_Then; } else { goto anon1062_Else; }
anon1061_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	assume assertSecMask#_582_$_21 == assertSecMask#_582_$_19;
	if ($_$_condition_$422) { goto anon1062_Then; } else { goto anon1062_Else; }
anon1145_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null);
	assert { :msg "  302.5: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  302.5: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_700_$_13[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_700_$_13[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_700_$_13[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_700_$_14 == exhaleMask#_700_$_13[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_700_$_13[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_700_$_13[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$423) { goto anon1146_Then; } else { goto anon1146_Else; }
anon1145_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_700_$_15 == exhaleMask#_700_$_13;
	if ($_$_condition_$424) { goto anon1147_Then; } else { goto anon1147_Else; }
anon1062_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume (forall  rk#80#247 : Integer :: ( ((0 <= rk#80#247) && (rk#80#247 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],rk#80#247)) ));
	if ($_$_condition_$425) { goto anon1063_Then; } else { goto anon1063_Else; }
anon1062_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	if ($_$_condition_$426) { goto anon1063_Then; } else { goto anon1063_Else; }
anon1146_Then:
	assume !CanRead(exhaleMask#_700_$_14,ZeroMask,Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_699_$_0[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon569;
anon1146_Else:
	assume CanRead(exhaleMask#_700_$_14,ZeroMask,Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon569;
anon1147_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null);
	assert { :msg "  302.5: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  302.5: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_700_$_15[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_700_$_15[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_700_$_15[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_700_$_16 == exhaleMask#_700_$_15[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_700_$_15[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_700_$_15[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_700_$_16);
	assume wf(Heap_$_8,exhaleMask#_700_$_16,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_17 == exhaleMask#_700_$_16;
	if ($_$_condition_$428) { goto anon1148_Then; } else { goto anon1148_Else; }
anon1147_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_700_$_17 == exhaleMask#_700_$_15;
	if ($_$_condition_$429) { goto anon1148_Then; } else { goto anon1148_Else; }
anon1063_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon401;
anon1063_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null;
	goto anon401;
anon569:
	assume IsGoodMask(exhaleMask#_700_$_14);
	assume wf(Heap_$_8,exhaleMask#_700_$_14,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_15 == exhaleMask#_700_$_14;
	if ($_$_condition_$427) { goto anon1147_Then; } else { goto anon1147_Else; }
anon401:
	assume Seq#Equal(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key])),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key]);
	assume (forall  kk#81_$4 : Integer :: ( Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],kk#81_$4) <==> ((((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.keys],kk#81_$4)) || ((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.keys],kk#81_$4))) || (kk#81_$4 == Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.key])) ));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height] == ite(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] == (ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.height] > 0;
	assert { :msg "  282.53: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  282.53: Location might not be readable." } true ==> CanRead(unfoldingMask#_587_$_22,ZeroMask,this,AVLTreeNode.left);
	assert { :msg "  282.53: Receiver might be null." } true ==> (!(unfoldingHeap#_586_$_1[this,AVLTreeNode.left] == null));
	assert { :msg "  282.53: Location might not be readable." } true ==> CanRead(unfoldingMask#_587_$_22,ZeroMask,unfoldingHeap#_586_$_1[this,AVLTreeNode.left],AVLTreeNode.keys);
	assert { :msg "  282.5: Assertion might not hold. The expression at 282.28 might not evaluate to true." } !Seq#Equal(Heap_$_1[Heap_$_1[this,AVLTreeNode.left],AVLTreeNode.keys],(Seq#Empty() : Seq (Integer) ));
	assume assertSecMask#_582_$_22 == assertSecMask#_582_$_21;
	goto anon402;
anon1148_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null);
	assert { :msg "  302.5: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  302.5: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_700_$_17[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_700_$_17[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_700_$_17[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_700_$_18 == exhaleMask#_700_$_17[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_700_$_17[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_700_$_17[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_700_$_18);
	assume wf(Heap_$_8,exhaleMask#_700_$_18,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_19 == exhaleMask#_700_$_18;
	if ($_$_condition_$431) { goto anon1149_Then; } else { goto anon1149_Else; }
anon1148_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_700_$_19 == exhaleMask#_700_$_17;
	if ($_$_condition_$432) { goto anon1149_Then; } else { goto anon1149_Else; }
anon1064_Then:
	assume cond#_629_$_0;
	assert { :msg "  284.11: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  284.11: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.right);
	assume r#20_$_1 == Heap_$_1[this,AVLTreeNode.right];
	assume Mask_$_149 == Mask_$_26;
	assume Heap_$_9 == Heap_$_1;
	assume r#20_$_3 == r#20_$_1;
	if ($_$_condition_$433) { goto anon1275_Then; } else { goto anon1275_Else; }
anon1064_Else:
	assume !cond#_629_$_0;
	assert { :msg "  286.11: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  286.11: Location might not be readable." } true ==> CanRead(Mask_$_26,ZeroMask,this,AVLTreeNode.left);
	assume r#20_$_2 == Heap_$_1[this,AVLTreeNode.left];
	assume Mask_$_149 == Mask_$_26;
	assume Heap_$_9 == Heap_$_1;
	assume r#20_$_3 == r#20_$_2;
	if ($_$_condition_$434) { goto anon1275_Then; } else { goto anon1275_Else; }
anon1149_Then:
	assume !(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null);
	assert { :msg "  302.5: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  302.5: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_700_$_19[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_700_$_19[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_700_$_19[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_700_$_20 == exhaleMask#_700_$_19[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_700_$_19[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_700_$_19[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_700_$_20);
	assume wf(Heap_$_8,exhaleMask#_700_$_20,ZeroMask);
	assume wf(Heap_$_8,Mask_$_144,ZeroMask);
	assume exhaleMask#_700_$_21 == exhaleMask#_700_$_20;
	goto anon576;
anon1149_Else:
	assume Heap_$_8[r#20_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_700_$_21 == exhaleMask#_700_$_19;
	goto anon576;
anon576:
	assume IsGoodExhaleState(exhaleHeap#_699_$_0,Heap_$_8,exhaleMask#_700_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_700_$_21);
	assume wf(exhaleHeap#_699_$_0,exhaleMask#_700_$_21,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(exhaleHeap#_699_$_0,exhaleMask#_700_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_145 == exhaleMask#_700_$_21[r#20_$_0,AVLTreeNode.valid := exhaleMask#_700_$_21[r#20_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_700_$_21[r#20_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_145);
	assume IsGoodState(heapFragment(exhaleHeap#_699_$_0[r#20_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_699_$_0,Mask_$_145,ZeroMask);
	assume wf(exhaleHeap#_699_$_0,Mask_$_145,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(exhaleHeap#_699_$_0,Mask_$_145,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_146 == Mask_$_145[r#20_$_0,AVLTreeNode.height := Mask_$_145[r#20_$_0,AVLTreeNode.height][perm$R := Mask_$_145[r#20_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_146);
	assume IsGoodState(heapFragment(exhaleHeap#_699_$_0[r#20_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_699_$_0,Mask_$_146,ZeroMask);
	assume wf(exhaleHeap#_699_$_0,Mask_$_146,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(exhaleHeap#_699_$_0,Mask_$_146,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_147 == Mask_$_146[r#20_$_0,AVLTreeNode.keys := Mask_$_146[r#20_$_0,AVLTreeNode.keys][perm$R := Mask_$_146[r#20_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_147);
	assume IsGoodState(heapFragment(exhaleHeap#_699_$_0[r#20_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_699_$_0,Mask_$_147,ZeroMask);
	assume wf(exhaleHeap#_699_$_0,Mask_$_147,ZeroMask);
	assume !(r#20_$_0 == null);
	assume wf(exhaleHeap#_699_$_0,Mask_$_147,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_148 == Mask_$_147[r#20_$_0,AVLTreeNode.balanceFactor := Mask_$_147[r#20_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_147[r#20_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_148);
	assume IsGoodState(heapFragment(exhaleHeap#_699_$_0[r#20_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_699_$_0,Mask_$_148,ZeroMask);
	assume wf(exhaleHeap#_699_$_0,Mask_$_148,ZeroMask);
	assume Seq#Equal(exhaleHeap#_699_$_0[r#20_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_8[r#20_$_0,AVLTreeNode.key])),ite(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_699_$_0[r#20_$_0,AVLTreeNode.height] == ite(ite(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_699_$_0[r#20_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_8[r#20_$_0,AVLTreeNode.left] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_8[r#20_$_0,AVLTreeNode.right] == null,0,Heap_$_8[Heap_$_8[r#20_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_148);
	assume wf(exhaleHeap#_699_$_0,Mask_$_148,ZeroMask);
	assume Mask_$_149 == Mask_$_148;
	assume Heap_$_9 == exhaleHeap#_699_$_0;
	assume r#20_$_3 == r#20_$_0;
	if ($_$_condition_$435) { goto anon1275_Then; } else { goto anon1275_Else; }
anon1276_Then:
	assume !Seq#Equal(Heap[this,AVLTreeNode.keys],Seq#Singleton(k#19));
	assert { :msg "  253.2: The postcondition at 260.11 might not hold. The expression at 260.30 might not evaluate to true." } !(r#20_$_3 == null);
	if ($_$_condition_$438) { goto anon1277_Then; } else { goto anon1277_Else; }
anon1276_Else:
	assume Seq#Equal(Heap[this,AVLTreeNode.keys],Seq#Singleton(k#19));
	if ($_$_condition_$439) { goto anon1277_Then; } else { goto anon1277_Else; }
anon1277_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 267.11 might not hold. The expression at 267.25 might not evaluate to true." } !Seq#Contains(Heap_$_9[r#20_$_3,AVLTreeNode.keys],k#19);
	if ($_$_condition_$440) { goto anon1278_Then; } else { goto anon1278_Else; }
anon1277_Else:
	assume r#20_$_3 == null;
	if ($_$_condition_$441) { goto anon1278_Then; } else { goto anon1278_Else; }
anon1278_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 268.11 might not hold. The expression at 268.25 might not evaluate to true." } (forall  i#84#315 : Integer :: ( ((0 <= i#84#315) && (i#84#315 < Seq#Length(Heap[this,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap_$_9[r#20_$_3,AVLTreeNode.keys],Seq#Index(Heap[this,AVLTreeNode.keys],i#84#315)) || (Seq#Index(Heap[this,AVLTreeNode.keys],i#84#315) == k#19)) ));
	if ($_$_condition_$442) { goto anon1279_Then; } else { goto anon1279_Else; }
anon1278_Else:
	assume r#20_$_3 == null;
	if ($_$_condition_$443) { goto anon1279_Then; } else { goto anon1279_Else; }
anon1279_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 269.11 might not hold. The expression at 269.25 might not evaluate to true." } (forall  i#85#316 : Integer :: ( ((0 <= i#85#316) && (i#85#316 < Seq#Length(Heap_$_9[r#20_$_3,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap[this,AVLTreeNode.keys],Seq#Index(Heap_$_9[r#20_$_3,AVLTreeNode.keys],i#85#316)) && (!(Seq#Index(Heap_$_9[r#20_$_3,AVLTreeNode.keys],i#85#316) == k#19))) ));
	if ($_$_condition_$444) { goto anon1280_Then; } else { goto anon1280_Else; }
anon1279_Else:
	assume r#20_$_3 == null;
	if ($_$_condition_$445) { goto anon1280_Then; } else { goto anon1280_Else; }
anon1280_Then:
	assume !Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	assert { :msg "  253.2: The postcondition at 270.11 might not hold. The expression at 270.34 might not evaluate to true." } !(r#20_$_3 == null);
	if ($_$_condition_$446) { goto anon1281_Then; } else { goto anon1281_Else; }
anon1280_Else:
	assume Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	if ($_$_condition_$447) { goto anon1281_Then; } else { goto anon1281_Else; }
anon1281_Then:
	assume !Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	assert { :msg "  253.2: The postcondition at 271.11 might not hold. The expression at 271.34 might not evaluate to true." } Seq#Equal(Heap_$_9[r#20_$_3,AVLTreeNode.keys],Heap[this,AVLTreeNode.keys]);
	if ($_$_condition_$448) { goto anon1282_Then; } else { goto anon1282_Else; }
anon1281_Else:
	assume Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	if ($_$_condition_$449) { goto anon1282_Then; } else { goto anon1282_Else; }
anon1282_Then:
	assume !(r#20_$_3 == null);
	if ($_$_condition_$450) { goto anon1283_Then; } else { goto anon1283_Else; }
anon1282_Else:
	assume r#20_$_3 == null;
	if ($_$_condition_$451) { goto anon1284_Then; } else { goto anon1284_Else; }
anon1283_Then:
	assume Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	assert { :msg "  253.2: The postcondition at 272.11 might not hold. The expression at 272.45 might not evaluate to true." } Seq#Length(Heap_$_9[r#20_$_3,AVLTreeNode.keys]) == (Seq#Length(Heap[this,AVLTreeNode.keys]) - 1);
	if ($_$_condition_$452) { goto anon1284_Then; } else { goto anon1284_Else; }
anon1283_Else:
	assume !Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	if ($_$_condition_$453) { goto anon1284_Then; } else { goto anon1284_Else; }
anon1284_Then:
	assume Heap[this,AVLTreeNode.height] > 1;
	assert { :msg "  253.2: The postcondition at 274.11 might not hold. The expression at 274.29 might not evaluate to true." } !(r#20_$_3 == null);
	if ($_$_condition_$454) { goto anon1285_Then; } else { goto anon1285_Else; }
anon1284_Else:
	assume 1 >= Heap[this,AVLTreeNode.height];
	if ($_$_condition_$455) { goto anon1285_Then; } else { goto anon1285_Else; }
anon1285_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 275.11 might not hold. The expression at 275.25 might not evaluate to true." } (Heap_$_9[r#20_$_3,AVLTreeNode.height] == Heap[this,AVLTreeNode.height]) || ((Heap_$_9[r#20_$_3,AVLTreeNode.height] + 1) == Heap[this,AVLTreeNode.height]);
	if ($_$_condition_$456) { goto anon1286_Then; } else { goto anon1286_Else; }
anon1285_Else:
	assume r#20_$_3 == null;
	if ($_$_condition_$457) { goto anon1286_Then; } else { goto anon1286_Else; }
anon1286_Then:
	assume !Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	assert { :msg "  253.2: The postcondition at 276.11 might not hold. The expression at 276.33 might not evaluate to true." } Heap_$_9[r#20_$_3,AVLTreeNode.height] == Heap[this,AVLTreeNode.height];
	if ($_$_condition_$458) { goto anon1287_Then; } else { goto anon1287_Else; }
anon1286_Else:
	assume Seq#Contains(Heap[this,AVLTreeNode.keys],k#19);
	if ($_$_condition_$459) { goto anon1287_Then; } else { goto anon1287_Else; }
anon1287_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 262.11 might not hold. The permission at 262.25 might not be positive." } Fractions(100) > 0;
	assert { :msg "  253.2: The postcondition at 262.11 might not hold. Insufficient fraction at 262.25 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_149[r#20_$_3,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_149[r#20_$_3,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_149[r#20_$_3,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_917_$_0 == Mask_$_149[r#20_$_3,AVLTreeNode.valid := Mask_$_149[r#20_$_3,AVLTreeNode.valid][perm$R := Mask_$_149[r#20_$_3,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$460) { goto anon1288_Then; } else { goto anon1288_Else; }
anon1287_Else:
	assume r#20_$_3 == null;
	assume exhaleMask#_917_$_1 == Mask_$_149;
	if ($_$_condition_$461) { goto anon1289_Then; } else { goto anon1289_Else; }
anon1288_Then:
	assume !CanRead(exhaleMask#_917_$_0,ZeroMask,r#20_$_3,AVLTreeNode.valid);
	assume Heap_$_9[r#20_$_3,AVLTreeNode.valid] < exhaleHeap#_916_$_0[r#20_$_3,AVLTreeNode.valid];
	goto anon852;
anon1288_Else:
	assume CanRead(exhaleMask#_917_$_0,ZeroMask,r#20_$_3,AVLTreeNode.valid);
	goto anon852;
anon1289_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 263.11 might not hold. The permission at 263.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  253.2: The postcondition at 263.11 might not hold. Insufficient fraction at 263.25 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_917_$_1[r#20_$_3,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_917_$_1[r#20_$_3,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_917_$_1[r#20_$_3,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_917_$_2 == exhaleMask#_917_$_1[r#20_$_3,AVLTreeNode.keys := exhaleMask#_917_$_1[r#20_$_3,AVLTreeNode.keys][perm$R := exhaleMask#_917_$_1[r#20_$_3,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_917_$_2);
	assume wf(Heap_$_9,exhaleMask#_917_$_2,ZeroMask);
	assume wf(Heap_$_9,Mask_$_149,ZeroMask);
	assume exhaleMask#_917_$_3 == exhaleMask#_917_$_2;
	if ($_$_condition_$463) { goto anon1290_Then; } else { goto anon1290_Else; }
anon1289_Else:
	assume r#20_$_3 == null;
	assume exhaleMask#_917_$_3 == exhaleMask#_917_$_1;
	if ($_$_condition_$464) { goto anon1290_Then; } else { goto anon1290_Else; }
anon852:
	assume IsGoodMask(exhaleMask#_917_$_0);
	assume wf(Heap_$_9,exhaleMask#_917_$_0,ZeroMask);
	assume wf(Heap_$_9,Mask_$_149,ZeroMask);
	assume exhaleMask#_917_$_1 == exhaleMask#_917_$_0;
	if ($_$_condition_$462) { goto anon1289_Then; } else { goto anon1289_Else; }
anon1290_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 264.11 might not hold. The permission at 264.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  253.2: The postcondition at 264.11 might not hold. Insufficient fraction at 264.25 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_917_$_3[r#20_$_3,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_917_$_3[r#20_$_3,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_917_$_3[r#20_$_3,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_917_$_4 == exhaleMask#_917_$_3[r#20_$_3,AVLTreeNode.height := exhaleMask#_917_$_3[r#20_$_3,AVLTreeNode.height][perm$R := exhaleMask#_917_$_3[r#20_$_3,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_917_$_4);
	assume wf(Heap_$_9,exhaleMask#_917_$_4,ZeroMask);
	assume wf(Heap_$_9,Mask_$_149,ZeroMask);
	assume exhaleMask#_917_$_5 == exhaleMask#_917_$_4;
	if ($_$_condition_$465) { goto anon1291_Then; } else { goto anon1291_Else; }
anon1290_Else:
	assume r#20_$_3 == null;
	assume exhaleMask#_917_$_5 == exhaleMask#_917_$_3;
	if ($_$_condition_$466) { goto anon1291_Then; } else { goto anon1291_Else; }
anon1291_Then:
	assume !(r#20_$_3 == null);
	assert { :msg "  253.2: The postcondition at 265.11 might not hold. The permission at 265.25 might not be positive." } Fractions(50) > 0;
	assert { :msg "  253.2: The postcondition at 265.11 might not hold. Insufficient fraction at 265.25 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_917_$_5[r#20_$_3,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_917_$_5[r#20_$_3,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_917_$_5[r#20_$_3,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_917_$_6 == exhaleMask#_917_$_5[r#20_$_3,AVLTreeNode.balanceFactor := exhaleMask#_917_$_5[r#20_$_3,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_917_$_5[r#20_$_3,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_917_$_6);
	assume wf(Heap_$_9,exhaleMask#_917_$_6,ZeroMask);
	assume wf(Heap_$_9,Mask_$_149,ZeroMask);
	assume exhaleMask#_917_$_7 == exhaleMask#_917_$_6;
	if ($_$_condition_$467) { goto anon1292_Then; } else { goto anon1292_Else; }
anon1291_Else:
	assume r#20_$_3 == null;
	assume exhaleMask#_917_$_7 == exhaleMask#_917_$_5;
	if ($_$_condition_$468) { goto anon1292_Then; } else { goto anon1292_Else; }
anon1292_Then:
	assume !(r#20_$_3 == null);
	goto anon861;
anon1292_Else:
	assume r#20_$_3 == null;
	goto anon861;
anon861:
	assume IsGoodExhaleState(exhaleHeap#_916_$_0,Heap_$_9,exhaleMask#_917_$_7,ZeroMask);
	assume IsGoodMask(exhaleMask#_917_$_7);
	assume wf(exhaleHeap#_916_$_0,exhaleMask#_917_$_7,ZeroMask);
	assert { :msg "  253.2: Method might lock/unlock more than allowed." } (forall  lk#_922 : ref :: {exhaleHeap#_916_$_0[lk#_922,held]} {exhaleHeap#_916_$_0[lk#_922,rdheld]} ( (((0 < exhaleHeap#_916_$_0[lk#_922,held]) <==> (0 < Heap[lk#_922,held])) && (exhaleHeap#_916_$_0[lk#_922,rdheld] <==> Heap[lk#_922,rdheld])) || false ));
	assert { :msg "  253.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
