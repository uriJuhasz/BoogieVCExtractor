type Integer = int;
type Boolean = bool;
type HeapType = <a>[ref,Field (a)]a;
type MaskType = <a>[ref,Field (a)][PermissionComponent]int;
type CreditsType = [ref]int;
type ArgSeq = <T>[int]T;
type Field m0;
type ref;
type PermissionComponent;
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
const nostate : HeapType;
const CurrentModule : ModuleName;
const CanAssumeFunctionDefs : bool;
const unique mu : Field (Mu);
const $LockBottom : Mu;
const unique held : Field (int);
const unique rdheld : Field (bool);
const ZeroCredits : CreditsType;
const unique SortedTree#t : TypeName;
const unique module#default : ModuleName;
const unique SortedTree.root : Field (ref);
const unique SortedTree.keys : Field (Seq (int));
const unique SortedTree.numClones : Field (int);
const unique SortedTree.valid : Field (HeapType);
const unique SortedTreeSnapshot.root : Field (ref);
const unique SortedTreeSnapshot.keys : Field (Seq (int));
const unique SortedTreeSnapshot.valid : Field (HeapType);
const unique SortedTreeNode#t : TypeName;
const unique SortedTreeNode.key : Field (int);
const unique SortedTreeNode.left : Field (ref);
const unique SortedTreeNode.right : Field (ref);
const unique SortedTreeNode.keys : Field (Seq (int));
const unique SortedTreeNode.shared : Field (bool);
const unique SortedTreeNode.valid : Field (HeapType);
function Fractions(int) : int;
function IsGoodState <T> (T) : bool;
function dtype(ref) : TypeName;
function MuBelow(Mu,Mu) : bool;
function wf(HeapType,MaskType) : bool;
function IsGoodInhaleState(HeapType,HeapType,MaskType) : bool;
function {:expand  false} CanRead <T> (MaskType,ref,Field (T)) : bool;
function {:expand  true} IsGoodMask(MaskType) : bool;
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
var Heap : HeapType;
var Mask : MaskType;
var Credits : CreditsType;
var this#52 : ref;
var methodK#_106 : int;
var inhaleHeap#_109_$_0 : HeapType;
var Heap_$_0 : HeapType;
var Mask_$_0 : MaskType;
var Heap_$_1 : HeapType;
var Mask_$_1 : MaskType;
var unfoldK#_110 : int;
var exhaleMask#_111_$_0 : MaskType;
var inhaleHeap#_113_$_0 : HeapType;
var Heap_$_2 : HeapType;
var Mask_$_2 : MaskType;
var Heap_$_3 : HeapType;
var Mask_$_3 : MaskType;
var Heap_$_4 : HeapType;
var Mask_$_4 : MaskType;
var Mask_$_6 : MaskType;
var Heap_$_6 : HeapType;
var Heap_$_8 : HeapType;
var Mask_$_8 : MaskType;
var methodCallK#_125 : int;
var this#52_$_0 : ref;
var exhaleMask#_126_$_0 : MaskType;
var exhaleMask#_126_$_1 : MaskType;
var inhaleHeap#_131_$_0 : HeapType;
var Heap_$_9 : HeapType;
var Mask_$_9 : MaskType;
var Heap_$_10 : HeapType;
var Mask_$_10 : MaskType;
var b#54_$_0 : bool;
var foldK#_132 : int;
var exhaleMask#_133_$_0 : MaskType;
var exhaleMask#_133_$_1 : MaskType;
var exhaleMask#_133_$_2 : MaskType;
var exhaleMask#_133_$_4 : MaskType;
var exhaleMask#_133_$_6 : MaskType;
var inhaleHeap#_139_$_0 : HeapType;
var Heap_$_11 : HeapType;
var Mask_$_11 : MaskType;
var Heap_$_12 : HeapType;
var Mask_$_13 : MaskType;
var Heap_$_15 : HeapType;
var b#7_$_0 : bool;
var exhaleMask#_140_$_0 : MaskType;
var exhaleMask#_140_$_1 : MaskType;
var exhaleMask#_133_$_5 : MaskType;
var exhaleMask#_133_$_3 : MaskType;
var foldK#_114 : int;
var exhaleMask#_115_$_0 : MaskType;
var exhaleMask#_115_$_1 : MaskType;
var exhaleMask#_115_$_2 : MaskType;
var exhaleMask#_115_$_4 : MaskType;
var exhaleMask#_115_$_6 : MaskType;
var inhaleHeap#_121_$_0 : HeapType;
var Heap_$_13 : HeapType;
var Mask_$_12 : MaskType;
var Heap_$_14 : HeapType;
var exhaleMask#_115_$_5 : MaskType;
var exhaleMask#_115_$_3 : MaskType;
var Heap_$_7 : HeapType;
var Mask_$_7 : MaskType;
var Heap_$_5 : HeapType;
var Mask_$_5 : MaskType;
var inhaleHeap#_109 : HeapType;
var exhaleMask#_111 : MaskType;
var inhaleHeap#_113 : HeapType;
var exhaleMask#_115 : MaskType;
var inhaleHeap#_121 : HeapType;
var bb#9 : bool;
var k#53 : int;
var b#54 : bool;
var callHeap#_122 : HeapType;
var callMask#_123 : MaskType;
var callCredits#_124 : CreditsType;
var exhaleMask#_126 : MaskType;
var inhaleHeap#_131 : HeapType;
var exhaleMask#_133 : MaskType;
var inhaleHeap#_139 : HeapType;
var exhaleMask#_140 : MaskType;
procedure SortedTree.has (this : ref,k#6 : int) returns (b#7 : bool)
{
	var methodK#_106 : int;
	var unfoldK#_110 : int;
	var foldK#_114 : int;
	var methodCallK#_125 : int;
	var this#52 : ref;
	var foldK#_132 : int;
	var inhaleHeap#_109_$_0 : HeapType;
	var Heap_$_0 : HeapType;
	var Mask_$_0 : MaskType;
	var Heap_$_1 : HeapType;
	var Mask_$_1 : MaskType;
	var exhaleMask#_111_$_0 : MaskType;
	var inhaleHeap#_113_$_0 : HeapType;
	var Heap_$_2 : HeapType;
	var Mask_$_2 : MaskType;
	var Heap_$_3 : HeapType;
	var Mask_$_3 : MaskType;
	var Heap_$_4 : HeapType;
	var Mask_$_4 : MaskType;
	var Heap_$_5 : HeapType;
	var Mask_$_5 : MaskType;
	var Mask_$_6 : MaskType;
	var Heap_$_6 : HeapType;
	var Heap_$_7 : HeapType;
	var Mask_$_7 : MaskType;
	var Heap_$_8 : HeapType;
	var Mask_$_8 : MaskType;
	var this#52_$_0 : ref;
	var exhaleMask#_126_$_0 : MaskType;
	var exhaleMask#_126_$_1 : MaskType;
	var b#54_$_0 : bool;
	var inhaleHeap#_131_$_0 : HeapType;
	var Heap_$_9 : HeapType;
	var Mask_$_9 : MaskType;
	var Heap_$_10 : HeapType;
	var Mask_$_10 : MaskType;
	var exhaleMask#_133_$_0 : MaskType;
	var exhaleMask#_133_$_1 : MaskType;
	var exhaleMask#_133_$_2 : MaskType;
	var exhaleMask#_133_$_3 : MaskType;
	var exhaleMask#_133_$_4 : MaskType;
	var exhaleMask#_133_$_5 : MaskType;
	var exhaleMask#_133_$_6 : MaskType;
	var inhaleHeap#_139_$_0 : HeapType;
	var Heap_$_11 : HeapType;
	var Mask_$_11 : MaskType;
	var Heap_$_12 : HeapType;
	var exhaleMask#_115_$_0 : MaskType;
	var exhaleMask#_115_$_1 : MaskType;
	var exhaleMask#_115_$_2 : MaskType;
	var exhaleMask#_115_$_3 : MaskType;
	var exhaleMask#_115_$_4 : MaskType;
	var exhaleMask#_115_$_5 : MaskType;
	var exhaleMask#_115_$_6 : MaskType;
	var inhaleHeap#_121_$_0 : HeapType;
	var Heap_$_13 : HeapType;
	var Mask_$_12 : MaskType;
	var Heap_$_14 : HeapType;
	var Mask_$_13 : MaskType;
	var Heap_$_15 : HeapType;
	var b#7_$_0 : bool;
	var exhaleMask#_140_$_0 : MaskType;
	var exhaleMask#_140_$_1 : MaskType;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$7 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$9 : bool;
	var $_$_condition_$11 : bool;
	var $_$_condition_$13 : bool;
	var $_$_condition_$15 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$22 : bool;
	var $_$_condition_$23 : bool;
	var $_$_condition_$25 : bool;
	var $_$_condition_$27 : bool;
	var $_$_condition_$29 : bool;
	var $_$_condition_$31 : bool;
	var $_$_condition_$33 : bool;
$start:
	assume Permission$denominator > 0;
	assume (Permission$Zero[perm$R] == 0) && (Permission$Zero[perm$N] == 0);
	assume (Permission$Full[perm$R] == Permission$FullFraction) && (Permission$Full[perm$N] == 0);
	assume ((((((forall  o_$17 : ref, f_$13 : Field (Boolean) , pc_$0 : PermissionComponent :: ( ZeroMask[o_$17,f_$13][pc_$0] == 0 ))) && ((forall  o_$18 : ref, f_$14 : Field (Integer) , pc_$1 : PermissionComponent :: ( ZeroMask[o_$18,f_$14][pc_$1] == 0 )))) && ((forall  o_$19 : ref, f_$15 : Field (ref) , pc_$2 : PermissionComponent :: ( ZeroMask[o_$19,f_$15][pc_$2] == 0 )))) && ((forall  o_$20 : ref, f_$16 : Field (HeapType) , pc_$3 : PermissionComponent :: ( ZeroMask[o_$20,f_$16][pc_$3] == 0 )))) && ((forall  o_$21 : ref, f_$17 : Field (Mu) , pc_$4 : PermissionComponent :: ( ZeroMask[o_$21,f_$17][pc_$4] == 0 )))) && ((forall  o_$22 : ref, f_$18 : Field (Seq (Integer) ) , pc_$5 : PermissionComponent :: ( ZeroMask[o_$22,f_$18][pc_$5] == 0 )));
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
	assume IsGoodState(nostate);
	assume NonPredicateField(mu);
	assume (forall  m : Mu, n_$0 : Mu :: {MuBelow(m,n_$0),MuBelow(n_$0,m)} ( !(MuBelow(m,n_$0) && MuBelow(n_$0,m)) ));
	assume (forall  m_$0 : Mu, n_$1 : Mu, o_$0 : Mu :: {MuBelow(m_$0,n_$1),MuBelow(n_$1,o_$0)} ( (MuBelow(m_$0,n_$1) && MuBelow(n_$1,o_$0)) ==> MuBelow(m_$0,o_$0) ));
	assume (forall  m_$1 : Mu, n_$2 : Mu :: ( MuBelow(m_$1,n_$2) ==> (!(n_$2 == $LockBottom)) ));
	assume NonPredicateField(held);
	assume NonPredicateField(rdheld);
	assume (forall  ih : HeapType, h : HeapType, m_$2 : MaskType :: {IsGoodInhaleState(ih,h,m_$2)} ( IsGoodInhaleState(ih,h,m_$2) <==> (((((((((((forall  o_$1_$0 : ref, f_$0_$0 : Field (Boolean)  :: {ih[o_$1_$0,f_$0_$0]} ( CanRead(m_$2,o_$1_$0,f_$0_$0) ==> (ih[o_$1_$0,f_$0_$0] == h[o_$1_$0,f_$0_$0]) ))) && ((forall  o_$1_$1 : ref, f_$0_$1 : Field (Integer)  :: {ih[o_$1_$1,f_$0_$1]} ( CanRead(m_$2,o_$1_$1,f_$0_$1) ==> (ih[o_$1_$1,f_$0_$1] == h[o_$1_$1,f_$0_$1]) )))) && ((forall  o_$1_$2 : ref, f_$0_$2 : Field (ref)  :: {ih[o_$1_$2,f_$0_$2]} ( CanRead(m_$2,o_$1_$2,f_$0_$2) ==> (ih[o_$1_$2,f_$0_$2] == h[o_$1_$2,f_$0_$2]) )))) && ((forall  o_$1_$3 : ref, f_$0_$3 : Field (HeapType)  :: {ih[o_$1_$3,f_$0_$3]} ( CanRead(m_$2,o_$1_$3,f_$0_$3) ==> (ih[o_$1_$3,f_$0_$3] == h[o_$1_$3,f_$0_$3]) )))) && ((forall  o_$1_$4 : ref, f_$0_$4 : Field (Mu)  :: {ih[o_$1_$4,f_$0_$4]} ( CanRead(m_$2,o_$1_$4,f_$0_$4) ==> (ih[o_$1_$4,f_$0_$4] == h[o_$1_$4,f_$0_$4]) )))) && ((forall  o_$1_$5 : ref, f_$0_$5 : Field (Seq (Integer) )  :: {ih[o_$1_$5,f_$0_$5]} ( CanRead(m_$2,o_$1_$5,f_$0_$5) ==> (ih[o_$1_$5,f_$0_$5] == h[o_$1_$5,f_$0_$5]) )))) && ((forall  o_$2 : ref :: {ih[o_$2,held]} ( (0 < ih[o_$2,held]) <==> (0 < h[o_$2,held]) )))) && ((forall  o_$3 : ref :: {ih[o_$3,rdheld]} ( ih[o_$3,rdheld] <==> h[o_$3,rdheld] )))) && ((forall  o_$4 : ref :: {h[o_$4,held]} ( (0 < h[o_$4,held]) ==> (ih[o_$4,mu] == h[o_$4,mu]) )))) && ((forall  o_$5 : ref :: {h[o_$5,rdheld]} ( h[o_$5,rdheld] ==> (ih[o_$5,mu] == h[o_$5,mu]) )))) ));
	assume ((((((forall  m_$3_$0 : MaskType, obj_$1 : ref, f_$1_$0 : Field (Boolean)  :: {CanRead(m_$3_$0,obj_$1,f_$1_$0)} {:expand  false}( CanRead(m_$3_$0,obj_$1,f_$1_$0) <==> ((0 < m_$3_$0[obj_$1,f_$1_$0][perm$R]) || (0 < m_$3_$0[obj_$1,f_$1_$0][perm$N])) ))) && ((forall  m_$3_$1 : MaskType, obj_$2 : ref, f_$1_$1 : Field (Integer)  :: {CanRead(m_$3_$1,obj_$2,f_$1_$1)} {:expand  false}( CanRead(m_$3_$1,obj_$2,f_$1_$1) <==> ((0 < m_$3_$1[obj_$2,f_$1_$1][perm$R]) || (0 < m_$3_$1[obj_$2,f_$1_$1][perm$N])) )))) && ((forall  m_$3_$2 : MaskType, obj_$3 : ref, f_$1_$2 : Field (ref)  :: {CanRead(m_$3_$2,obj_$3,f_$1_$2)} {:expand  false}( CanRead(m_$3_$2,obj_$3,f_$1_$2) <==> ((0 < m_$3_$2[obj_$3,f_$1_$2][perm$R]) || (0 < m_$3_$2[obj_$3,f_$1_$2][perm$N])) )))) && ((forall  m_$3_$3 : MaskType, obj_$4 : ref, f_$1_$3 : Field (HeapType)  :: {CanRead(m_$3_$3,obj_$4,f_$1_$3)} {:expand  false}( CanRead(m_$3_$3,obj_$4,f_$1_$3) <==> ((0 < m_$3_$3[obj_$4,f_$1_$3][perm$R]) || (0 < m_$3_$3[obj_$4,f_$1_$3][perm$N])) )))) && ((forall  m_$3_$4 : MaskType, obj_$5 : ref, f_$1_$4 : Field (Mu)  :: {CanRead(m_$3_$4,obj_$5,f_$1_$4)} {:expand  false}( CanRead(m_$3_$4,obj_$5,f_$1_$4) <==> ((0 < m_$3_$4[obj_$5,f_$1_$4][perm$R]) || (0 < m_$3_$4[obj_$5,f_$1_$4][perm$N])) )))) && ((forall  m_$3_$5 : MaskType, obj_$6 : ref, f_$1_$5 : Field (Seq (Integer) )  :: {CanRead(m_$3_$5,obj_$6,f_$1_$5)} {:expand  false}( CanRead(m_$3_$5,obj_$6,f_$1_$5) <==> ((0 < m_$3_$5[obj_$6,f_$1_$5][perm$R]) || (0 < m_$3_$5[obj_$6,f_$1_$5][perm$N])) )));
	assume (forall  m_$5 : MaskType :: {IsGoodMask(m_$5)} {:expand  true}( IsGoodMask(m_$5) <==> (((((((forall  o_$6_$0 : ref, f_$3_$0 : Field (Boolean)  :: ( ((0 <= m_$5[o_$6_$0,f_$3_$0][perm$R]) && (NonPredicateField(f_$3_$0) ==> ((m_$5[o_$6_$0,f_$3_$0][perm$R] <= Permission$FullFraction) && ((0 < m_$5[o_$6_$0,f_$3_$0][perm$N]) ==> (m_$5[o_$6_$0,f_$3_$0][perm$R] < Permission$FullFraction))))) && ((m_$5[o_$6_$0,f_$3_$0][perm$N] < 0) ==> (0 < m_$5[o_$6_$0,f_$3_$0][perm$R])) ))) && ((forall  o_$6_$1 : ref, f_$3_$1 : Field (Integer)  :: ( ((0 <= m_$5[o_$6_$1,f_$3_$1][perm$R]) && (NonPredicateField(f_$3_$1) ==> ((m_$5[o_$6_$1,f_$3_$1][perm$R] <= Permission$FullFraction) && ((0 < m_$5[o_$6_$1,f_$3_$1][perm$N]) ==> (m_$5[o_$6_$1,f_$3_$1][perm$R] < Permission$FullFraction))))) && ((m_$5[o_$6_$1,f_$3_$1][perm$N] < 0) ==> (0 < m_$5[o_$6_$1,f_$3_$1][perm$R])) )))) && ((forall  o_$6_$2 : ref, f_$3_$2 : Field (ref)  :: ( ((0 <= m_$5[o_$6_$2,f_$3_$2][perm$R]) && (NonPredicateField(f_$3_$2) ==> ((m_$5[o_$6_$2,f_$3_$2][perm$R] <= Permission$FullFraction) && ((0 < m_$5[o_$6_$2,f_$3_$2][perm$N]) ==> (m_$5[o_$6_$2,f_$3_$2][perm$R] < Permission$FullFraction))))) && ((m_$5[o_$6_$2,f_$3_$2][perm$N] < 0) ==> (0 < m_$5[o_$6_$2,f_$3_$2][perm$R])) )))) && ((forall  o_$6_$3 : ref, f_$3_$3 : Field (HeapType)  :: ( ((0 <= m_$5[o_$6_$3,f_$3_$3][perm$R]) && (NonPredicateField(f_$3_$3) ==> ((m_$5[o_$6_$3,f_$3_$3][perm$R] <= Permission$FullFraction) && ((0 < m_$5[o_$6_$3,f_$3_$3][perm$N]) ==> (m_$5[o_$6_$3,f_$3_$3][perm$R] < Permission$FullFraction))))) && ((m_$5[o_$6_$3,f_$3_$3][perm$N] < 0) ==> (0 < m_$5[o_$6_$3,f_$3_$3][perm$R])) )))) && ((forall  o_$6_$4 : ref, f_$3_$4 : Field (Mu)  :: ( ((0 <= m_$5[o_$6_$4,f_$3_$4][perm$R]) && (NonPredicateField(f_$3_$4) ==> ((m_$5[o_$6_$4,f_$3_$4][perm$R] <= Permission$FullFraction) && ((0 < m_$5[o_$6_$4,f_$3_$4][perm$N]) ==> (m_$5[o_$6_$4,f_$3_$4][perm$R] < Permission$FullFraction))))) && ((m_$5[o_$6_$4,f_$3_$4][perm$N] < 0) ==> (0 < m_$5[o_$6_$4,f_$3_$4][perm$R])) )))) && ((forall  o_$6_$5 : ref, f_$3_$5 : Field (Seq (Integer) )  :: ( ((0 <= m_$5[o_$6_$5,f_$3_$5][perm$R]) && (NonPredicateField(f_$3_$5) ==> ((m_$5[o_$6_$5,f_$3_$5][perm$R] <= Permission$FullFraction) && ((0 < m_$5[o_$6_$5,f_$3_$5][perm$N]) ==> (m_$5[o_$6_$5,f_$3_$5][perm$R] < Permission$FullFraction))))) && ((m_$5[o_$6_$5,f_$3_$5][perm$N] < 0) ==> (0 < m_$5[o_$6_$5,f_$3_$5][perm$R])) )))) ));
	assume (forall  h_$0 : HeapType, m_$6 : MaskType, o_$7 : ref, q : ref :: {wf(h_$0,m_$6),h_$0[o_$7,mu],h_$0[q,mu]} ( (((wf(h_$0,m_$6) && (!(o_$7 == q))) && ((0 < h_$0[o_$7,held]) || h_$0[o_$7,rdheld])) && ((0 < h_$0[q,held]) || h_$0[q,rdheld])) ==> (!(h_$0[o_$7,mu] == h_$0[q,mu])) ));
	assume ((((((((((((((((((((((((((((((((((((forall  m_$7_$0 : MaskType, o_$8_$0 : ref, f_$4_$0 : Field (Boolean) , howMuch_$3 : Integer, q_$0_$0 : ref, g_$4 : Field (Boolean)  :: {DecPerm(m_$7_$0,o_$8_$0,f_$4_$0,howMuch_$3)[q_$0_$0,g_$4][perm$R]} ( DecPerm(m_$7_$0,o_$8_$0,f_$4_$0,howMuch_$3)[q_$0_$0,g_$4][perm$R] == ite((o_$8_$0 == q_$0_$0) && (f_$4_$0 == g_$4),m_$7_$0[q_$0_$0,g_$4][perm$R] - howMuch_$3,m_$7_$0[q_$0_$0,g_$4][perm$R]) ))) && ((forall  m_$7_$1 : MaskType, o_$8_$1 : ref, f_$4_$1 : Field (Integer) , howMuch_$4 : Integer, q_$0_$1 : ref, g_$5 : Field (Boolean)  :: {DecPerm(m_$7_$1,o_$8_$1,f_$4_$1,howMuch_$4)[q_$0_$1,g_$5][perm$R]} ( DecPerm(m_$7_$1,o_$8_$1,f_$4_$1,howMuch_$4)[q_$0_$1,g_$5][perm$R] == ite((o_$8_$1 == q_$0_$1) && false,m_$7_$1[q_$0_$1,g_$5][perm$R] - howMuch_$4,m_$7_$1[q_$0_$1,g_$5][perm$R]) )))) && ((forall  m_$7_$2 : MaskType, o_$8_$2 : ref, f_$4_$2 : Field (ref) , howMuch_$5 : Integer, q_$0_$2 : ref, g_$6 : Field (Boolean)  :: {DecPerm(m_$7_$2,o_$8_$2,f_$4_$2,howMuch_$5)[q_$0_$2,g_$6][perm$R]} ( DecPerm(m_$7_$2,o_$8_$2,f_$4_$2,howMuch_$5)[q_$0_$2,g_$6][perm$R] == ite((o_$8_$2 == q_$0_$2) && false,m_$7_$2[q_$0_$2,g_$6][perm$R] - howMuch_$5,m_$7_$2[q_$0_$2,g_$6][perm$R]) )))) && ((forall  m_$7_$3 : MaskType, o_$8_$3 : ref, f_$4_$3 : Field (HeapType) , howMuch_$6 : Integer, q_$0_$3 : ref, g_$7 : Field (Boolean)  :: {DecPerm(m_$7_$3,o_$8_$3,f_$4_$3,howMuch_$6)[q_$0_$3,g_$7][perm$R]} ( DecPerm(m_$7_$3,o_$8_$3,f_$4_$3,howMuch_$6)[q_$0_$3,g_$7][perm$R] == ite((o_$8_$3 == q_$0_$3) && false,m_$7_$3[q_$0_$3,g_$7][perm$R] - howMuch_$6,m_$7_$3[q_$0_$3,g_$7][perm$R]) )))) && ((forall  m_$7_$4 : MaskType, o_$8_$4 : ref, f_$4_$4 : Field (Mu) , howMuch_$7 : Integer, q_$0_$4 : ref, g_$8 : Field (Boolean)  :: {DecPerm(m_$7_$4,o_$8_$4,f_$4_$4,howMuch_$7)[q_$0_$4,g_$8][perm$R]} ( DecPerm(m_$7_$4,o_$8_$4,f_$4_$4,howMuch_$7)[q_$0_$4,g_$8][perm$R] == ite((o_$8_$4 == q_$0_$4) && false,m_$7_$4[q_$0_$4,g_$8][perm$R] - howMuch_$7,m_$7_$4[q_$0_$4,g_$8][perm$R]) )))) && ((forall  m_$7_$5 : MaskType, o_$8_$5 : ref, f_$4_$5 : Field (Seq (Integer) ) , howMuch_$8 : Integer, q_$0_$5 : ref, g_$9 : Field (Boolean)  :: {DecPerm(m_$7_$5,o_$8_$5,f_$4_$5,howMuch_$8)[q_$0_$5,g_$9][perm$R]} ( DecPerm(m_$7_$5,o_$8_$5,f_$4_$5,howMuch_$8)[q_$0_$5,g_$9][perm$R] == ite((o_$8_$5 == q_$0_$5) && false,m_$7_$5[q_$0_$5,g_$9][perm$R] - howMuch_$8,m_$7_$5[q_$0_$5,g_$9][perm$R]) )))) && ((forall  m_$7_$6 : MaskType, o_$8_$6 : ref, f_$4_$6 : Field (Boolean) , howMuch_$9 : Integer, q_$0_$6 : ref, g_$10 : Field (Integer)  :: {DecPerm(m_$7_$6,o_$8_$6,f_$4_$6,howMuch_$9)[q_$0_$6,g_$10][perm$R]} ( DecPerm(m_$7_$6,o_$8_$6,f_$4_$6,howMuch_$9)[q_$0_$6,g_$10][perm$R] == ite((o_$8_$6 == q_$0_$6) && false,m_$7_$6[q_$0_$6,g_$10][perm$R] - howMuch_$9,m_$7_$6[q_$0_$6,g_$10][perm$R]) )))) && ((forall  m_$7_$7 : MaskType, o_$8_$7 : ref, f_$4_$7 : Field (Integer) , howMuch_$10 : Integer, q_$0_$7 : ref, g_$11 : Field (Integer)  :: {DecPerm(m_$7_$7,o_$8_$7,f_$4_$7,howMuch_$10)[q_$0_$7,g_$11][perm$R]} ( DecPerm(m_$7_$7,o_$8_$7,f_$4_$7,howMuch_$10)[q_$0_$7,g_$11][perm$R] == ite((o_$8_$7 == q_$0_$7) && (f_$4_$7 == g_$11),m_$7_$7[q_$0_$7,g_$11][perm$R] - howMuch_$10,m_$7_$7[q_$0_$7,g_$11][perm$R]) )))) && ((forall  m_$7_$8 : MaskType, o_$8_$8 : ref, f_$4_$8 : Field (ref) , howMuch_$11 : Integer, q_$0_$8 : ref, g_$12 : Field (Integer)  :: {DecPerm(m_$7_$8,o_$8_$8,f_$4_$8,howMuch_$11)[q_$0_$8,g_$12][perm$R]} ( DecPerm(m_$7_$8,o_$8_$8,f_$4_$8,howMuch_$11)[q_$0_$8,g_$12][perm$R] == ite((o_$8_$8 == q_$0_$8) && false,m_$7_$8[q_$0_$8,g_$12][perm$R] - howMuch_$11,m_$7_$8[q_$0_$8,g_$12][perm$R]) )))) && ((forall  m_$7_$9 : MaskType, o_$8_$9 : ref, f_$4_$9 : Field (HeapType) , howMuch_$12 : Integer, q_$0_$9 : ref, g_$13 : Field (Integer)  :: {DecPerm(m_$7_$9,o_$8_$9,f_$4_$9,howMuch_$12)[q_$0_$9,g_$13][perm$R]} ( DecPerm(m_$7_$9,o_$8_$9,f_$4_$9,howMuch_$12)[q_$0_$9,g_$13][perm$R] == ite((o_$8_$9 == q_$0_$9) && false,m_$7_$9[q_$0_$9,g_$13][perm$R] - howMuch_$12,m_$7_$9[q_$0_$9,g_$13][perm$R]) )))) && ((forall  m_$7_$10 : MaskType, o_$8_$10 : ref, f_$4_$10 : Field (Mu) , howMuch_$13 : Integer, q_$0_$10 : ref, g_$14 : Field (Integer)  :: {DecPerm(m_$7_$10,o_$8_$10,f_$4_$10,howMuch_$13)[q_$0_$10,g_$14][perm$R]} ( DecPerm(m_$7_$10,o_$8_$10,f_$4_$10,howMuch_$13)[q_$0_$10,g_$14][perm$R] == ite((o_$8_$10 == q_$0_$10) && false,m_$7_$10[q_$0_$10,g_$14][perm$R] - howMuch_$13,m_$7_$10[q_$0_$10,g_$14][perm$R]) )))) && ((forall  m_$7_$11 : MaskType, o_$8_$11 : ref, f_$4_$11 : Field (Seq (Integer) ) , howMuch_$14 : Integer, q_$0_$11 : ref, g_$15 : Field (Integer)  :: {DecPerm(m_$7_$11,o_$8_$11,f_$4_$11,howMuch_$14)[q_$0_$11,g_$15][perm$R]} ( DecPerm(m_$7_$11,o_$8_$11,f_$4_$11,howMuch_$14)[q_$0_$11,g_$15][perm$R] == ite((o_$8_$11 == q_$0_$11) && false,m_$7_$11[q_$0_$11,g_$15][perm$R] - howMuch_$14,m_$7_$11[q_$0_$11,g_$15][perm$R]) )))) && ((forall  m_$7_$12 : MaskType, o_$8_$12 : ref, f_$4_$12 : Field (Boolean) , howMuch_$15 : Integer, q_$0_$12 : ref, g_$16 : Field (ref)  :: {DecPerm(m_$7_$12,o_$8_$12,f_$4_$12,howMuch_$15)[q_$0_$12,g_$16][perm$R]} ( DecPerm(m_$7_$12,o_$8_$12,f_$4_$12,howMuch_$15)[q_$0_$12,g_$16][perm$R] == ite((o_$8_$12 == q_$0_$12) && false,m_$7_$12[q_$0_$12,g_$16][perm$R] - howMuch_$15,m_$7_$12[q_$0_$12,g_$16][perm$R]) )))) && ((forall  m_$7_$13 : MaskType, o_$8_$13 : ref, f_$4_$13 : Field (Integer) , howMuch_$16 : Integer, q_$0_$13 : ref, g_$17 : Field (ref)  :: {DecPerm(m_$7_$13,o_$8_$13,f_$4_$13,howMuch_$16)[q_$0_$13,g_$17][perm$R]} ( DecPerm(m_$7_$13,o_$8_$13,f_$4_$13,howMuch_$16)[q_$0_$13,g_$17][perm$R] == ite((o_$8_$13 == q_$0_$13) && false,m_$7_$13[q_$0_$13,g_$17][perm$R] - howMuch_$16,m_$7_$13[q_$0_$13,g_$17][perm$R]) )))) && ((forall  m_$7_$14 : MaskType, o_$8_$14 : ref, f_$4_$14 : Field (ref) , howMuch_$17 : Integer, q_$0_$14 : ref, g_$18 : Field (ref)  :: {DecPerm(m_$7_$14,o_$8_$14,f_$4_$14,howMuch_$17)[q_$0_$14,g_$18][perm$R]} ( DecPerm(m_$7_$14,o_$8_$14,f_$4_$14,howMuch_$17)[q_$0_$14,g_$18][perm$R] == ite((o_$8_$14 == q_$0_$14) && (f_$4_$14 == g_$18),m_$7_$14[q_$0_$14,g_$18][perm$R] - howMuch_$17,m_$7_$14[q_$0_$14,g_$18][perm$R]) )))) && ((forall  m_$7_$15 : MaskType, o_$8_$15 : ref, f_$4_$15 : Field (HeapType) , howMuch_$18 : Integer, q_$0_$15 : ref, g_$19 : Field (ref)  :: {DecPerm(m_$7_$15,o_$8_$15,f_$4_$15,howMuch_$18)[q_$0_$15,g_$19][perm$R]} ( DecPerm(m_$7_$15,o_$8_$15,f_$4_$15,howMuch_$18)[q_$0_$15,g_$19][perm$R] == ite((o_$8_$15 == q_$0_$15) && false,m_$7_$15[q_$0_$15,g_$19][perm$R] - howMuch_$18,m_$7_$15[q_$0_$15,g_$19][perm$R]) )))) && ((forall  m_$7_$16 : MaskType, o_$8_$16 : ref, f_$4_$16 : Field (Mu) , howMuch_$19 : Integer, q_$0_$16 : ref, g_$20 : Field (ref)  :: {DecPerm(m_$7_$16,o_$8_$16,f_$4_$16,howMuch_$19)[q_$0_$16,g_$20][perm$R]} ( DecPerm(m_$7_$16,o_$8_$16,f_$4_$16,howMuch_$19)[q_$0_$16,g_$20][perm$R] == ite((o_$8_$16 == q_$0_$16) && false,m_$7_$16[q_$0_$16,g_$20][perm$R] - howMuch_$19,m_$7_$16[q_$0_$16,g_$20][perm$R]) )))) && ((forall  m_$7_$17 : MaskType, o_$8_$17 : ref, f_$4_$17 : Field (Seq (Integer) ) , howMuch_$20 : Integer, q_$0_$17 : ref, g_$21 : Field (ref)  :: {DecPerm(m_$7_$17,o_$8_$17,f_$4_$17,howMuch_$20)[q_$0_$17,g_$21][perm$R]} ( DecPerm(m_$7_$17,o_$8_$17,f_$4_$17,howMuch_$20)[q_$0_$17,g_$21][perm$R] == ite((o_$8_$17 == q_$0_$17) && false,m_$7_$17[q_$0_$17,g_$21][perm$R] - howMuch_$20,m_$7_$17[q_$0_$17,g_$21][perm$R]) )))) && ((forall  m_$7_$18 : MaskType, o_$8_$18 : ref, f_$4_$18 : Field (Boolean) , howMuch_$21 : Integer, q_$0_$18 : ref, g_$22 : Field (HeapType)  :: {DecPerm(m_$7_$18,o_$8_$18,f_$4_$18,howMuch_$21)[q_$0_$18,g_$22][perm$R]} ( DecPerm(m_$7_$18,o_$8_$18,f_$4_$18,howMuch_$21)[q_$0_$18,g_$22][perm$R] == ite((o_$8_$18 == q_$0_$18) && false,m_$7_$18[q_$0_$18,g_$22][perm$R] - howMuch_$21,m_$7_$18[q_$0_$18,g_$22][perm$R]) )))) && ((forall  m_$7_$19 : MaskType, o_$8_$19 : ref, f_$4_$19 : Field (Integer) , howMuch_$22 : Integer, q_$0_$19 : ref, g_$23 : Field (HeapType)  :: {DecPerm(m_$7_$19,o_$8_$19,f_$4_$19,howMuch_$22)[q_$0_$19,g_$23][perm$R]} ( DecPerm(m_$7_$19,o_$8_$19,f_$4_$19,howMuch_$22)[q_$0_$19,g_$23][perm$R] == ite((o_$8_$19 == q_$0_$19) && false,m_$7_$19[q_$0_$19,g_$23][perm$R] - howMuch_$22,m_$7_$19[q_$0_$19,g_$23][perm$R]) )))) && ((forall  m_$7_$20 : MaskType, o_$8_$20 : ref, f_$4_$20 : Field (ref) , howMuch_$23 : Integer, q_$0_$20 : ref, g_$24 : Field (HeapType)  :: {DecPerm(m_$7_$20,o_$8_$20,f_$4_$20,howMuch_$23)[q_$0_$20,g_$24][perm$R]} ( DecPerm(m_$7_$20,o_$8_$20,f_$4_$20,howMuch_$23)[q_$0_$20,g_$24][perm$R] == ite((o_$8_$20 == q_$0_$20) && false,m_$7_$20[q_$0_$20,g_$24][perm$R] - howMuch_$23,m_$7_$20[q_$0_$20,g_$24][perm$R]) )))) && ((forall  m_$7_$21 : MaskType, o_$8_$21 : ref, f_$4_$21 : Field (HeapType) , howMuch_$24 : Integer, q_$0_$21 : ref, g_$25 : Field (HeapType)  :: {DecPerm(m_$7_$21,o_$8_$21,f_$4_$21,howMuch_$24)[q_$0_$21,g_$25][perm$R]} ( DecPerm(m_$7_$21,o_$8_$21,f_$4_$21,howMuch_$24)[q_$0_$21,g_$25][perm$R] == ite((o_$8_$21 == q_$0_$21) && (f_$4_$21 == g_$25),m_$7_$21[q_$0_$21,g_$25][perm$R] - howMuch_$24,m_$7_$21[q_$0_$21,g_$25][perm$R]) )))) && ((forall  m_$7_$22 : MaskType, o_$8_$22 : ref, f_$4_$22 : Field (Mu) , howMuch_$25 : Integer, q_$0_$22 : ref, g_$26 : Field (HeapType)  :: {DecPerm(m_$7_$22,o_$8_$22,f_$4_$22,howMuch_$25)[q_$0_$22,g_$26][perm$R]} ( DecPerm(m_$7_$22,o_$8_$22,f_$4_$22,howMuch_$25)[q_$0_$22,g_$26][perm$R] == ite((o_$8_$22 == q_$0_$22) && false,m_$7_$22[q_$0_$22,g_$26][perm$R] - howMuch_$25,m_$7_$22[q_$0_$22,g_$26][perm$R]) )))) && ((forall  m_$7_$23 : MaskType, o_$8_$23 : ref, f_$4_$23 : Field (Seq (Integer) ) , howMuch_$26 : Integer, q_$0_$23 : ref, g_$27 : Field (HeapType)  :: {DecPerm(m_$7_$23,o_$8_$23,f_$4_$23,howMuch_$26)[q_$0_$23,g_$27][perm$R]} ( DecPerm(m_$7_$23,o_$8_$23,f_$4_$23,howMuch_$26)[q_$0_$23,g_$27][perm$R] == ite((o_$8_$23 == q_$0_$23) && false,m_$7_$23[q_$0_$23,g_$27][perm$R] - howMuch_$26,m_$7_$23[q_$0_$23,g_$27][perm$R]) )))) && ((forall  m_$7_$24 : MaskType, o_$8_$24 : ref, f_$4_$24 : Field (Boolean) , howMuch_$27 : Integer, q_$0_$24 : ref, g_$28 : Field (Mu)  :: {DecPerm(m_$7_$24,o_$8_$24,f_$4_$24,howMuch_$27)[q_$0_$24,g_$28][perm$R]} ( DecPerm(m_$7_$24,o_$8_$24,f_$4_$24,howMuch_$27)[q_$0_$24,g_$28][perm$R] == ite((o_$8_$24 == q_$0_$24) && false,m_$7_$24[q_$0_$24,g_$28][perm$R] - howMuch_$27,m_$7_$24[q_$0_$24,g_$28][perm$R]) )))) && ((forall  m_$7_$25 : MaskType, o_$8_$25 : ref, f_$4_$25 : Field (Integer) , howMuch_$28 : Integer, q_$0_$25 : ref, g_$29 : Field (Mu)  :: {DecPerm(m_$7_$25,o_$8_$25,f_$4_$25,howMuch_$28)[q_$0_$25,g_$29][perm$R]} ( DecPerm(m_$7_$25,o_$8_$25,f_$4_$25,howMuch_$28)[q_$0_$25,g_$29][perm$R] == ite((o_$8_$25 == q_$0_$25) && false,m_$7_$25[q_$0_$25,g_$29][perm$R] - howMuch_$28,m_$7_$25[q_$0_$25,g_$29][perm$R]) )))) && ((forall  m_$7_$26 : MaskType, o_$8_$26 : ref, f_$4_$26 : Field (ref) , howMuch_$29 : Integer, q_$0_$26 : ref, g_$30 : Field (Mu)  :: {DecPerm(m_$7_$26,o_$8_$26,f_$4_$26,howMuch_$29)[q_$0_$26,g_$30][perm$R]} ( DecPerm(m_$7_$26,o_$8_$26,f_$4_$26,howMuch_$29)[q_$0_$26,g_$30][perm$R] == ite((o_$8_$26 == q_$0_$26) && false,m_$7_$26[q_$0_$26,g_$30][perm$R] - howMuch_$29,m_$7_$26[q_$0_$26,g_$30][perm$R]) )))) && ((forall  m_$7_$27 : MaskType, o_$8_$27 : ref, f_$4_$27 : Field (HeapType) , howMuch_$30 : Integer, q_$0_$27 : ref, g_$31 : Field (Mu)  :: {DecPerm(m_$7_$27,o_$8_$27,f_$4_$27,howMuch_$30)[q_$0_$27,g_$31][perm$R]} ( DecPerm(m_$7_$27,o_$8_$27,f_$4_$27,howMuch_$30)[q_$0_$27,g_$31][perm$R] == ite((o_$8_$27 == q_$0_$27) && false,m_$7_$27[q_$0_$27,g_$31][perm$R] - howMuch_$30,m_$7_$27[q_$0_$27,g_$31][perm$R]) )))) && ((forall  m_$7_$28 : MaskType, o_$8_$28 : ref, f_$4_$28 : Field (Mu) , howMuch_$31 : Integer, q_$0_$28 : ref, g_$32 : Field (Mu)  :: {DecPerm(m_$7_$28,o_$8_$28,f_$4_$28,howMuch_$31)[q_$0_$28,g_$32][perm$R]} ( DecPerm(m_$7_$28,o_$8_$28,f_$4_$28,howMuch_$31)[q_$0_$28,g_$32][perm$R] == ite((o_$8_$28 == q_$0_$28) && (f_$4_$28 == g_$32),m_$7_$28[q_$0_$28,g_$32][perm$R] - howMuch_$31,m_$7_$28[q_$0_$28,g_$32][perm$R]) )))) && ((forall  m_$7_$29 : MaskType, o_$8_$29 : ref, f_$4_$29 : Field (Seq (Integer) ) , howMuch_$32 : Integer, q_$0_$29 : ref, g_$33 : Field (Mu)  :: {DecPerm(m_$7_$29,o_$8_$29,f_$4_$29,howMuch_$32)[q_$0_$29,g_$33][perm$R]} ( DecPerm(m_$7_$29,o_$8_$29,f_$4_$29,howMuch_$32)[q_$0_$29,g_$33][perm$R] == ite((o_$8_$29 == q_$0_$29) && false,m_$7_$29[q_$0_$29,g_$33][perm$R] - howMuch_$32,m_$7_$29[q_$0_$29,g_$33][perm$R]) )))) && ((forall  m_$7_$30 : MaskType, o_$8_$30 : ref, f_$4_$30 : Field (Boolean) , howMuch_$33 : Integer, q_$0_$30 : ref, g_$34 : Field (Seq (Integer) )  :: {DecPerm(m_$7_$30,o_$8_$30,f_$4_$30,howMuch_$33)[q_$0_$30,g_$34][perm$R]} ( DecPerm(m_$7_$30,o_$8_$30,f_$4_$30,howMuch_$33)[q_$0_$30,g_$34][perm$R] == ite((o_$8_$30 == q_$0_$30) && false,m_$7_$30[q_$0_$30,g_$34][perm$R] - howMuch_$33,m_$7_$30[q_$0_$30,g_$34][perm$R]) )))) && ((forall  m_$7_$31 : MaskType, o_$8_$31 : ref, f_$4_$31 : Field (Integer) , howMuch_$34 : Integer, q_$0_$31 : ref, g_$35 : Field (Seq (Integer) )  :: {DecPerm(m_$7_$31,o_$8_$31,f_$4_$31,howMuch_$34)[q_$0_$31,g_$35][perm$R]} ( DecPerm(m_$7_$31,o_$8_$31,f_$4_$31,howMuch_$34)[q_$0_$31,g_$35][perm$R] == ite((o_$8_$31 == q_$0_$31) && false,m_$7_$31[q_$0_$31,g_$35][perm$R] - howMuch_$34,m_$7_$31[q_$0_$31,g_$35][perm$R]) )))) && ((forall  m_$7_$32 : MaskType, o_$8_$32 : ref, f_$4_$32 : Field (ref) , howMuch_$35 : Integer, q_$0_$32 : ref, g_$36 : Field (Seq (Integer) )  :: {DecPerm(m_$7_$32,o_$8_$32,f_$4_$32,howMuch_$35)[q_$0_$32,g_$36][perm$R]} ( DecPerm(m_$7_$32,o_$8_$32,f_$4_$32,howMuch_$35)[q_$0_$32,g_$36][perm$R] == ite((o_$8_$32 == q_$0_$32) && false,m_$7_$32[q_$0_$32,g_$36][perm$R] - howMuch_$35,m_$7_$32[q_$0_$32,g_$36][perm$R]) )))) && ((forall  m_$7_$33 : MaskType, o_$8_$33 : ref, f_$4_$33 : Field (HeapType) , howMuch_$36 : Integer, q_$0_$33 : ref, g_$37 : Field (Seq (Integer) )  :: {DecPerm(m_$7_$33,o_$8_$33,f_$4_$33,howMuch_$36)[q_$0_$33,g_$37][perm$R]} ( DecPerm(m_$7_$33,o_$8_$33,f_$4_$33,howMuch_$36)[q_$0_$33,g_$37][perm$R] == ite((o_$8_$33 == q_$0_$33) && false,m_$7_$33[q_$0_$33,g_$37][perm$R] - howMuch_$36,m_$7_$33[q_$0_$33,g_$37][perm$R]) )))) && ((forall  m_$7_$34 : MaskType, o_$8_$34 : ref, f_$4_$34 : Field (Mu) , howMuch_$37 : Integer, q_$0_$34 : ref, g_$38 : Field (Seq (Integer) )  :: {DecPerm(m_$7_$34,o_$8_$34,f_$4_$34,howMuch_$37)[q_$0_$34,g_$38][perm$R]} ( DecPerm(m_$7_$34,o_$8_$34,f_$4_$34,howMuch_$37)[q_$0_$34,g_$38][perm$R] == ite((o_$8_$34 == q_$0_$34) && false,m_$7_$34[q_$0_$34,g_$38][perm$R] - howMuch_$37,m_$7_$34[q_$0_$34,g_$38][perm$R]) )))) && ((forall  m_$7_$35 : MaskType, o_$8_$35 : ref, f_$4_$35 : Field (Seq (Integer) ) , howMuch_$38 : Integer, q_$0_$35 : ref, g_$39 : Field (Seq (Integer) )  :: {DecPerm(m_$7_$35,o_$8_$35,f_$4_$35,howMuch_$38)[q_$0_$35,g_$39][perm$R]} ( DecPerm(m_$7_$35,o_$8_$35,f_$4_$35,howMuch_$38)[q_$0_$35,g_$39][perm$R] == ite((o_$8_$35 == q_$0_$35) && (f_$4_$35 == g_$39),m_$7_$35[q_$0_$35,g_$39][perm$R] - howMuch_$38,m_$7_$35[q_$0_$35,g_$39][perm$R]) )));
	assume ((((((((((((((((((((((((((((((((((((forall  m_$9_$0 : MaskType, o_$10_$0 : ref, f_$6_$0 : Field (Boolean) , howMuch_$1_$0 : Integer, q_$2_$0 : ref, g_$1_$0 : Field (Boolean)  :: {IncPerm(m_$9_$0,o_$10_$0,f_$6_$0,howMuch_$1_$0)[q_$2_$0,g_$1_$0][perm$R]} ( IncPerm(m_$9_$0,o_$10_$0,f_$6_$0,howMuch_$1_$0)[q_$2_$0,g_$1_$0][perm$R] == ite((o_$10_$0 == q_$2_$0) && (f_$6_$0 == g_$1_$0),m_$9_$0[q_$2_$0,g_$1_$0][perm$R] + howMuch_$1_$0,m_$9_$0[q_$2_$0,g_$1_$0][perm$R]) ))) && ((forall  m_$9_$1 : MaskType, o_$10_$1 : ref, f_$6_$1 : Field (Integer) , howMuch_$1_$1 : Integer, q_$2_$1 : ref, g_$1_$1 : Field (Boolean)  :: {IncPerm(m_$9_$1,o_$10_$1,f_$6_$1,howMuch_$1_$1)[q_$2_$1,g_$1_$1][perm$R]} ( IncPerm(m_$9_$1,o_$10_$1,f_$6_$1,howMuch_$1_$1)[q_$2_$1,g_$1_$1][perm$R] == ite((o_$10_$1 == q_$2_$1) && false,m_$9_$1[q_$2_$1,g_$1_$1][perm$R] + howMuch_$1_$1,m_$9_$1[q_$2_$1,g_$1_$1][perm$R]) )))) && ((forall  m_$9_$2 : MaskType, o_$10_$2 : ref, f_$6_$2 : Field (ref) , howMuch_$1_$2 : Integer, q_$2_$2 : ref, g_$1_$2 : Field (Boolean)  :: {IncPerm(m_$9_$2,o_$10_$2,f_$6_$2,howMuch_$1_$2)[q_$2_$2,g_$1_$2][perm$R]} ( IncPerm(m_$9_$2,o_$10_$2,f_$6_$2,howMuch_$1_$2)[q_$2_$2,g_$1_$2][perm$R] == ite((o_$10_$2 == q_$2_$2) && false,m_$9_$2[q_$2_$2,g_$1_$2][perm$R] + howMuch_$1_$2,m_$9_$2[q_$2_$2,g_$1_$2][perm$R]) )))) && ((forall  m_$9_$3 : MaskType, o_$10_$3 : ref, f_$6_$3 : Field (HeapType) , howMuch_$1_$3 : Integer, q_$2_$3 : ref, g_$1_$3 : Field (Boolean)  :: {IncPerm(m_$9_$3,o_$10_$3,f_$6_$3,howMuch_$1_$3)[q_$2_$3,g_$1_$3][perm$R]} ( IncPerm(m_$9_$3,o_$10_$3,f_$6_$3,howMuch_$1_$3)[q_$2_$3,g_$1_$3][perm$R] == ite((o_$10_$3 == q_$2_$3) && false,m_$9_$3[q_$2_$3,g_$1_$3][perm$R] + howMuch_$1_$3,m_$9_$3[q_$2_$3,g_$1_$3][perm$R]) )))) && ((forall  m_$9_$4 : MaskType, o_$10_$4 : ref, f_$6_$4 : Field (Mu) , howMuch_$1_$4 : Integer, q_$2_$4 : ref, g_$1_$4 : Field (Boolean)  :: {IncPerm(m_$9_$4,o_$10_$4,f_$6_$4,howMuch_$1_$4)[q_$2_$4,g_$1_$4][perm$R]} ( IncPerm(m_$9_$4,o_$10_$4,f_$6_$4,howMuch_$1_$4)[q_$2_$4,g_$1_$4][perm$R] == ite((o_$10_$4 == q_$2_$4) && false,m_$9_$4[q_$2_$4,g_$1_$4][perm$R] + howMuch_$1_$4,m_$9_$4[q_$2_$4,g_$1_$4][perm$R]) )))) && ((forall  m_$9_$5 : MaskType, o_$10_$5 : ref, f_$6_$5 : Field (Seq (Integer) ) , howMuch_$1_$5 : Integer, q_$2_$5 : ref, g_$1_$5 : Field (Boolean)  :: {IncPerm(m_$9_$5,o_$10_$5,f_$6_$5,howMuch_$1_$5)[q_$2_$5,g_$1_$5][perm$R]} ( IncPerm(m_$9_$5,o_$10_$5,f_$6_$5,howMuch_$1_$5)[q_$2_$5,g_$1_$5][perm$R] == ite((o_$10_$5 == q_$2_$5) && false,m_$9_$5[q_$2_$5,g_$1_$5][perm$R] + howMuch_$1_$5,m_$9_$5[q_$2_$5,g_$1_$5][perm$R]) )))) && ((forall  m_$9_$6 : MaskType, o_$10_$6 : ref, f_$6_$6 : Field (Boolean) , howMuch_$1_$6 : Integer, q_$2_$6 : ref, g_$1_$6 : Field (Integer)  :: {IncPerm(m_$9_$6,o_$10_$6,f_$6_$6,howMuch_$1_$6)[q_$2_$6,g_$1_$6][perm$R]} ( IncPerm(m_$9_$6,o_$10_$6,f_$6_$6,howMuch_$1_$6)[q_$2_$6,g_$1_$6][perm$R] == ite((o_$10_$6 == q_$2_$6) && false,m_$9_$6[q_$2_$6,g_$1_$6][perm$R] + howMuch_$1_$6,m_$9_$6[q_$2_$6,g_$1_$6][perm$R]) )))) && ((forall  m_$9_$7 : MaskType, o_$10_$7 : ref, f_$6_$7 : Field (Integer) , howMuch_$1_$7 : Integer, q_$2_$7 : ref, g_$1_$7 : Field (Integer)  :: {IncPerm(m_$9_$7,o_$10_$7,f_$6_$7,howMuch_$1_$7)[q_$2_$7,g_$1_$7][perm$R]} ( IncPerm(m_$9_$7,o_$10_$7,f_$6_$7,howMuch_$1_$7)[q_$2_$7,g_$1_$7][perm$R] == ite((o_$10_$7 == q_$2_$7) && (f_$6_$7 == g_$1_$7),m_$9_$7[q_$2_$7,g_$1_$7][perm$R] + howMuch_$1_$7,m_$9_$7[q_$2_$7,g_$1_$7][perm$R]) )))) && ((forall  m_$9_$8 : MaskType, o_$10_$8 : ref, f_$6_$8 : Field (ref) , howMuch_$1_$8 : Integer, q_$2_$8 : ref, g_$1_$8 : Field (Integer)  :: {IncPerm(m_$9_$8,o_$10_$8,f_$6_$8,howMuch_$1_$8)[q_$2_$8,g_$1_$8][perm$R]} ( IncPerm(m_$9_$8,o_$10_$8,f_$6_$8,howMuch_$1_$8)[q_$2_$8,g_$1_$8][perm$R] == ite((o_$10_$8 == q_$2_$8) && false,m_$9_$8[q_$2_$8,g_$1_$8][perm$R] + howMuch_$1_$8,m_$9_$8[q_$2_$8,g_$1_$8][perm$R]) )))) && ((forall  m_$9_$9 : MaskType, o_$10_$9 : ref, f_$6_$9 : Field (HeapType) , howMuch_$1_$9 : Integer, q_$2_$9 : ref, g_$1_$9 : Field (Integer)  :: {IncPerm(m_$9_$9,o_$10_$9,f_$6_$9,howMuch_$1_$9)[q_$2_$9,g_$1_$9][perm$R]} ( IncPerm(m_$9_$9,o_$10_$9,f_$6_$9,howMuch_$1_$9)[q_$2_$9,g_$1_$9][perm$R] == ite((o_$10_$9 == q_$2_$9) && false,m_$9_$9[q_$2_$9,g_$1_$9][perm$R] + howMuch_$1_$9,m_$9_$9[q_$2_$9,g_$1_$9][perm$R]) )))) && ((forall  m_$9_$10 : MaskType, o_$10_$10 : ref, f_$6_$10 : Field (Mu) , howMuch_$1_$10 : Integer, q_$2_$10 : ref, g_$1_$10 : Field (Integer)  :: {IncPerm(m_$9_$10,o_$10_$10,f_$6_$10,howMuch_$1_$10)[q_$2_$10,g_$1_$10][perm$R]} ( IncPerm(m_$9_$10,o_$10_$10,f_$6_$10,howMuch_$1_$10)[q_$2_$10,g_$1_$10][perm$R] == ite((o_$10_$10 == q_$2_$10) && false,m_$9_$10[q_$2_$10,g_$1_$10][perm$R] + howMuch_$1_$10,m_$9_$10[q_$2_$10,g_$1_$10][perm$R]) )))) && ((forall  m_$9_$11 : MaskType, o_$10_$11 : ref, f_$6_$11 : Field (Seq (Integer) ) , howMuch_$1_$11 : Integer, q_$2_$11 : ref, g_$1_$11 : Field (Integer)  :: {IncPerm(m_$9_$11,o_$10_$11,f_$6_$11,howMuch_$1_$11)[q_$2_$11,g_$1_$11][perm$R]} ( IncPerm(m_$9_$11,o_$10_$11,f_$6_$11,howMuch_$1_$11)[q_$2_$11,g_$1_$11][perm$R] == ite((o_$10_$11 == q_$2_$11) && false,m_$9_$11[q_$2_$11,g_$1_$11][perm$R] + howMuch_$1_$11,m_$9_$11[q_$2_$11,g_$1_$11][perm$R]) )))) && ((forall  m_$9_$12 : MaskType, o_$10_$12 : ref, f_$6_$12 : Field (Boolean) , howMuch_$1_$12 : Integer, q_$2_$12 : ref, g_$1_$12 : Field (ref)  :: {IncPerm(m_$9_$12,o_$10_$12,f_$6_$12,howMuch_$1_$12)[q_$2_$12,g_$1_$12][perm$R]} ( IncPerm(m_$9_$12,o_$10_$12,f_$6_$12,howMuch_$1_$12)[q_$2_$12,g_$1_$12][perm$R] == ite((o_$10_$12 == q_$2_$12) && false,m_$9_$12[q_$2_$12,g_$1_$12][perm$R] + howMuch_$1_$12,m_$9_$12[q_$2_$12,g_$1_$12][perm$R]) )))) && ((forall  m_$9_$13 : MaskType, o_$10_$13 : ref, f_$6_$13 : Field (Integer) , howMuch_$1_$13 : Integer, q_$2_$13 : ref, g_$1_$13 : Field (ref)  :: {IncPerm(m_$9_$13,o_$10_$13,f_$6_$13,howMuch_$1_$13)[q_$2_$13,g_$1_$13][perm$R]} ( IncPerm(m_$9_$13,o_$10_$13,f_$6_$13,howMuch_$1_$13)[q_$2_$13,g_$1_$13][perm$R] == ite((o_$10_$13 == q_$2_$13) && false,m_$9_$13[q_$2_$13,g_$1_$13][perm$R] + howMuch_$1_$13,m_$9_$13[q_$2_$13,g_$1_$13][perm$R]) )))) && ((forall  m_$9_$14 : MaskType, o_$10_$14 : ref, f_$6_$14 : Field (ref) , howMuch_$1_$14 : Integer, q_$2_$14 : ref, g_$1_$14 : Field (ref)  :: {IncPerm(m_$9_$14,o_$10_$14,f_$6_$14,howMuch_$1_$14)[q_$2_$14,g_$1_$14][perm$R]} ( IncPerm(m_$9_$14,o_$10_$14,f_$6_$14,howMuch_$1_$14)[q_$2_$14,g_$1_$14][perm$R] == ite((o_$10_$14 == q_$2_$14) && (f_$6_$14 == g_$1_$14),m_$9_$14[q_$2_$14,g_$1_$14][perm$R] + howMuch_$1_$14,m_$9_$14[q_$2_$14,g_$1_$14][perm$R]) )))) && ((forall  m_$9_$15 : MaskType, o_$10_$15 : ref, f_$6_$15 : Field (HeapType) , howMuch_$1_$15 : Integer, q_$2_$15 : ref, g_$1_$15 : Field (ref)  :: {IncPerm(m_$9_$15,o_$10_$15,f_$6_$15,howMuch_$1_$15)[q_$2_$15,g_$1_$15][perm$R]} ( IncPerm(m_$9_$15,o_$10_$15,f_$6_$15,howMuch_$1_$15)[q_$2_$15,g_$1_$15][perm$R] == ite((o_$10_$15 == q_$2_$15) && false,m_$9_$15[q_$2_$15,g_$1_$15][perm$R] + howMuch_$1_$15,m_$9_$15[q_$2_$15,g_$1_$15][perm$R]) )))) && ((forall  m_$9_$16 : MaskType, o_$10_$16 : ref, f_$6_$16 : Field (Mu) , howMuch_$1_$16 : Integer, q_$2_$16 : ref, g_$1_$16 : Field (ref)  :: {IncPerm(m_$9_$16,o_$10_$16,f_$6_$16,howMuch_$1_$16)[q_$2_$16,g_$1_$16][perm$R]} ( IncPerm(m_$9_$16,o_$10_$16,f_$6_$16,howMuch_$1_$16)[q_$2_$16,g_$1_$16][perm$R] == ite((o_$10_$16 == q_$2_$16) && false,m_$9_$16[q_$2_$16,g_$1_$16][perm$R] + howMuch_$1_$16,m_$9_$16[q_$2_$16,g_$1_$16][perm$R]) )))) && ((forall  m_$9_$17 : MaskType, o_$10_$17 : ref, f_$6_$17 : Field (Seq (Integer) ) , howMuch_$1_$17 : Integer, q_$2_$17 : ref, g_$1_$17 : Field (ref)  :: {IncPerm(m_$9_$17,o_$10_$17,f_$6_$17,howMuch_$1_$17)[q_$2_$17,g_$1_$17][perm$R]} ( IncPerm(m_$9_$17,o_$10_$17,f_$6_$17,howMuch_$1_$17)[q_$2_$17,g_$1_$17][perm$R] == ite((o_$10_$17 == q_$2_$17) && false,m_$9_$17[q_$2_$17,g_$1_$17][perm$R] + howMuch_$1_$17,m_$9_$17[q_$2_$17,g_$1_$17][perm$R]) )))) && ((forall  m_$9_$18 : MaskType, o_$10_$18 : ref, f_$6_$18 : Field (Boolean) , howMuch_$1_$18 : Integer, q_$2_$18 : ref, g_$1_$18 : Field (HeapType)  :: {IncPerm(m_$9_$18,o_$10_$18,f_$6_$18,howMuch_$1_$18)[q_$2_$18,g_$1_$18][perm$R]} ( IncPerm(m_$9_$18,o_$10_$18,f_$6_$18,howMuch_$1_$18)[q_$2_$18,g_$1_$18][perm$R] == ite((o_$10_$18 == q_$2_$18) && false,m_$9_$18[q_$2_$18,g_$1_$18][perm$R] + howMuch_$1_$18,m_$9_$18[q_$2_$18,g_$1_$18][perm$R]) )))) && ((forall  m_$9_$19 : MaskType, o_$10_$19 : ref, f_$6_$19 : Field (Integer) , howMuch_$1_$19 : Integer, q_$2_$19 : ref, g_$1_$19 : Field (HeapType)  :: {IncPerm(m_$9_$19,o_$10_$19,f_$6_$19,howMuch_$1_$19)[q_$2_$19,g_$1_$19][perm$R]} ( IncPerm(m_$9_$19,o_$10_$19,f_$6_$19,howMuch_$1_$19)[q_$2_$19,g_$1_$19][perm$R] == ite((o_$10_$19 == q_$2_$19) && false,m_$9_$19[q_$2_$19,g_$1_$19][perm$R] + howMuch_$1_$19,m_$9_$19[q_$2_$19,g_$1_$19][perm$R]) )))) && ((forall  m_$9_$20 : MaskType, o_$10_$20 : ref, f_$6_$20 : Field (ref) , howMuch_$1_$20 : Integer, q_$2_$20 : ref, g_$1_$20 : Field (HeapType)  :: {IncPerm(m_$9_$20,o_$10_$20,f_$6_$20,howMuch_$1_$20)[q_$2_$20,g_$1_$20][perm$R]} ( IncPerm(m_$9_$20,o_$10_$20,f_$6_$20,howMuch_$1_$20)[q_$2_$20,g_$1_$20][perm$R] == ite((o_$10_$20 == q_$2_$20) && false,m_$9_$20[q_$2_$20,g_$1_$20][perm$R] + howMuch_$1_$20,m_$9_$20[q_$2_$20,g_$1_$20][perm$R]) )))) && ((forall  m_$9_$21 : MaskType, o_$10_$21 : ref, f_$6_$21 : Field (HeapType) , howMuch_$1_$21 : Integer, q_$2_$21 : ref, g_$1_$21 : Field (HeapType)  :: {IncPerm(m_$9_$21,o_$10_$21,f_$6_$21,howMuch_$1_$21)[q_$2_$21,g_$1_$21][perm$R]} ( IncPerm(m_$9_$21,o_$10_$21,f_$6_$21,howMuch_$1_$21)[q_$2_$21,g_$1_$21][perm$R] == ite((o_$10_$21 == q_$2_$21) && (f_$6_$21 == g_$1_$21),m_$9_$21[q_$2_$21,g_$1_$21][perm$R] + howMuch_$1_$21,m_$9_$21[q_$2_$21,g_$1_$21][perm$R]) )))) && ((forall  m_$9_$22 : MaskType, o_$10_$22 : ref, f_$6_$22 : Field (Mu) , howMuch_$1_$22 : Integer, q_$2_$22 : ref, g_$1_$22 : Field (HeapType)  :: {IncPerm(m_$9_$22,o_$10_$22,f_$6_$22,howMuch_$1_$22)[q_$2_$22,g_$1_$22][perm$R]} ( IncPerm(m_$9_$22,o_$10_$22,f_$6_$22,howMuch_$1_$22)[q_$2_$22,g_$1_$22][perm$R] == ite((o_$10_$22 == q_$2_$22) && false,m_$9_$22[q_$2_$22,g_$1_$22][perm$R] + howMuch_$1_$22,m_$9_$22[q_$2_$22,g_$1_$22][perm$R]) )))) && ((forall  m_$9_$23 : MaskType, o_$10_$23 : ref, f_$6_$23 : Field (Seq (Integer) ) , howMuch_$1_$23 : Integer, q_$2_$23 : ref, g_$1_$23 : Field (HeapType)  :: {IncPerm(m_$9_$23,o_$10_$23,f_$6_$23,howMuch_$1_$23)[q_$2_$23,g_$1_$23][perm$R]} ( IncPerm(m_$9_$23,o_$10_$23,f_$6_$23,howMuch_$1_$23)[q_$2_$23,g_$1_$23][perm$R] == ite((o_$10_$23 == q_$2_$23) && false,m_$9_$23[q_$2_$23,g_$1_$23][perm$R] + howMuch_$1_$23,m_$9_$23[q_$2_$23,g_$1_$23][perm$R]) )))) && ((forall  m_$9_$24 : MaskType, o_$10_$24 : ref, f_$6_$24 : Field (Boolean) , howMuch_$1_$24 : Integer, q_$2_$24 : ref, g_$1_$24 : Field (Mu)  :: {IncPerm(m_$9_$24,o_$10_$24,f_$6_$24,howMuch_$1_$24)[q_$2_$24,g_$1_$24][perm$R]} ( IncPerm(m_$9_$24,o_$10_$24,f_$6_$24,howMuch_$1_$24)[q_$2_$24,g_$1_$24][perm$R] == ite((o_$10_$24 == q_$2_$24) && false,m_$9_$24[q_$2_$24,g_$1_$24][perm$R] + howMuch_$1_$24,m_$9_$24[q_$2_$24,g_$1_$24][perm$R]) )))) && ((forall  m_$9_$25 : MaskType, o_$10_$25 : ref, f_$6_$25 : Field (Integer) , howMuch_$1_$25 : Integer, q_$2_$25 : ref, g_$1_$25 : Field (Mu)  :: {IncPerm(m_$9_$25,o_$10_$25,f_$6_$25,howMuch_$1_$25)[q_$2_$25,g_$1_$25][perm$R]} ( IncPerm(m_$9_$25,o_$10_$25,f_$6_$25,howMuch_$1_$25)[q_$2_$25,g_$1_$25][perm$R] == ite((o_$10_$25 == q_$2_$25) && false,m_$9_$25[q_$2_$25,g_$1_$25][perm$R] + howMuch_$1_$25,m_$9_$25[q_$2_$25,g_$1_$25][perm$R]) )))) && ((forall  m_$9_$26 : MaskType, o_$10_$26 : ref, f_$6_$26 : Field (ref) , howMuch_$1_$26 : Integer, q_$2_$26 : ref, g_$1_$26 : Field (Mu)  :: {IncPerm(m_$9_$26,o_$10_$26,f_$6_$26,howMuch_$1_$26)[q_$2_$26,g_$1_$26][perm$R]} ( IncPerm(m_$9_$26,o_$10_$26,f_$6_$26,howMuch_$1_$26)[q_$2_$26,g_$1_$26][perm$R] == ite((o_$10_$26 == q_$2_$26) && false,m_$9_$26[q_$2_$26,g_$1_$26][perm$R] + howMuch_$1_$26,m_$9_$26[q_$2_$26,g_$1_$26][perm$R]) )))) && ((forall  m_$9_$27 : MaskType, o_$10_$27 : ref, f_$6_$27 : Field (HeapType) , howMuch_$1_$27 : Integer, q_$2_$27 : ref, g_$1_$27 : Field (Mu)  :: {IncPerm(m_$9_$27,o_$10_$27,f_$6_$27,howMuch_$1_$27)[q_$2_$27,g_$1_$27][perm$R]} ( IncPerm(m_$9_$27,o_$10_$27,f_$6_$27,howMuch_$1_$27)[q_$2_$27,g_$1_$27][perm$R] == ite((o_$10_$27 == q_$2_$27) && false,m_$9_$27[q_$2_$27,g_$1_$27][perm$R] + howMuch_$1_$27,m_$9_$27[q_$2_$27,g_$1_$27][perm$R]) )))) && ((forall  m_$9_$28 : MaskType, o_$10_$28 : ref, f_$6_$28 : Field (Mu) , howMuch_$1_$28 : Integer, q_$2_$28 : ref, g_$1_$28 : Field (Mu)  :: {IncPerm(m_$9_$28,o_$10_$28,f_$6_$28,howMuch_$1_$28)[q_$2_$28,g_$1_$28][perm$R]} ( IncPerm(m_$9_$28,o_$10_$28,f_$6_$28,howMuch_$1_$28)[q_$2_$28,g_$1_$28][perm$R] == ite((o_$10_$28 == q_$2_$28) && (f_$6_$28 == g_$1_$28),m_$9_$28[q_$2_$28,g_$1_$28][perm$R] + howMuch_$1_$28,m_$9_$28[q_$2_$28,g_$1_$28][perm$R]) )))) && ((forall  m_$9_$29 : MaskType, o_$10_$29 : ref, f_$6_$29 : Field (Seq (Integer) ) , howMuch_$1_$29 : Integer, q_$2_$29 : ref, g_$1_$29 : Field (Mu)  :: {IncPerm(m_$9_$29,o_$10_$29,f_$6_$29,howMuch_$1_$29)[q_$2_$29,g_$1_$29][perm$R]} ( IncPerm(m_$9_$29,o_$10_$29,f_$6_$29,howMuch_$1_$29)[q_$2_$29,g_$1_$29][perm$R] == ite((o_$10_$29 == q_$2_$29) && false,m_$9_$29[q_$2_$29,g_$1_$29][perm$R] + howMuch_$1_$29,m_$9_$29[q_$2_$29,g_$1_$29][perm$R]) )))) && ((forall  m_$9_$30 : MaskType, o_$10_$30 : ref, f_$6_$30 : Field (Boolean) , howMuch_$1_$30 : Integer, q_$2_$30 : ref, g_$1_$30 : Field (Seq (Integer) )  :: {IncPerm(m_$9_$30,o_$10_$30,f_$6_$30,howMuch_$1_$30)[q_$2_$30,g_$1_$30][perm$R]} ( IncPerm(m_$9_$30,o_$10_$30,f_$6_$30,howMuch_$1_$30)[q_$2_$30,g_$1_$30][perm$R] == ite((o_$10_$30 == q_$2_$30) && false,m_$9_$30[q_$2_$30,g_$1_$30][perm$R] + howMuch_$1_$30,m_$9_$30[q_$2_$30,g_$1_$30][perm$R]) )))) && ((forall  m_$9_$31 : MaskType, o_$10_$31 : ref, f_$6_$31 : Field (Integer) , howMuch_$1_$31 : Integer, q_$2_$31 : ref, g_$1_$31 : Field (Seq (Integer) )  :: {IncPerm(m_$9_$31,o_$10_$31,f_$6_$31,howMuch_$1_$31)[q_$2_$31,g_$1_$31][perm$R]} ( IncPerm(m_$9_$31,o_$10_$31,f_$6_$31,howMuch_$1_$31)[q_$2_$31,g_$1_$31][perm$R] == ite((o_$10_$31 == q_$2_$31) && false,m_$9_$31[q_$2_$31,g_$1_$31][perm$R] + howMuch_$1_$31,m_$9_$31[q_$2_$31,g_$1_$31][perm$R]) )))) && ((forall  m_$9_$32 : MaskType, o_$10_$32 : ref, f_$6_$32 : Field (ref) , howMuch_$1_$32 : Integer, q_$2_$32 : ref, g_$1_$32 : Field (Seq (Integer) )  :: {IncPerm(m_$9_$32,o_$10_$32,f_$6_$32,howMuch_$1_$32)[q_$2_$32,g_$1_$32][perm$R]} ( IncPerm(m_$9_$32,o_$10_$32,f_$6_$32,howMuch_$1_$32)[q_$2_$32,g_$1_$32][perm$R] == ite((o_$10_$32 == q_$2_$32) && false,m_$9_$32[q_$2_$32,g_$1_$32][perm$R] + howMuch_$1_$32,m_$9_$32[q_$2_$32,g_$1_$32][perm$R]) )))) && ((forall  m_$9_$33 : MaskType, o_$10_$33 : ref, f_$6_$33 : Field (HeapType) , howMuch_$1_$33 : Integer, q_$2_$33 : ref, g_$1_$33 : Field (Seq (Integer) )  :: {IncPerm(m_$9_$33,o_$10_$33,f_$6_$33,howMuch_$1_$33)[q_$2_$33,g_$1_$33][perm$R]} ( IncPerm(m_$9_$33,o_$10_$33,f_$6_$33,howMuch_$1_$33)[q_$2_$33,g_$1_$33][perm$R] == ite((o_$10_$33 == q_$2_$33) && false,m_$9_$33[q_$2_$33,g_$1_$33][perm$R] + howMuch_$1_$33,m_$9_$33[q_$2_$33,g_$1_$33][perm$R]) )))) && ((forall  m_$9_$34 : MaskType, o_$10_$34 : ref, f_$6_$34 : Field (Mu) , howMuch_$1_$34 : Integer, q_$2_$34 : ref, g_$1_$34 : Field (Seq (Integer) )  :: {IncPerm(m_$9_$34,o_$10_$34,f_$6_$34,howMuch_$1_$34)[q_$2_$34,g_$1_$34][perm$R]} ( IncPerm(m_$9_$34,o_$10_$34,f_$6_$34,howMuch_$1_$34)[q_$2_$34,g_$1_$34][perm$R] == ite((o_$10_$34 == q_$2_$34) && false,m_$9_$34[q_$2_$34,g_$1_$34][perm$R] + howMuch_$1_$34,m_$9_$34[q_$2_$34,g_$1_$34][perm$R]) )))) && ((forall  m_$9_$35 : MaskType, o_$10_$35 : ref, f_$6_$35 : Field (Seq (Integer) ) , howMuch_$1_$35 : Integer, q_$2_$35 : ref, g_$1_$35 : Field (Seq (Integer) )  :: {IncPerm(m_$9_$35,o_$10_$35,f_$6_$35,howMuch_$1_$35)[q_$2_$35,g_$1_$35][perm$R]} ( IncPerm(m_$9_$35,o_$10_$35,f_$6_$35,howMuch_$1_$35)[q_$2_$35,g_$1_$35][perm$R] == ite((o_$10_$35 == q_$2_$35) && (f_$6_$35 == g_$1_$35),m_$9_$35[q_$2_$35,g_$1_$35][perm$R] + howMuch_$1_$35,m_$9_$35[q_$2_$35,g_$1_$35][perm$R]) )));
	assume (forall  o_$14 : ref :: ( ZeroCredits[o_$14] == 0 ));
	assume ((((((forall  f_$10_$0 : Field (Boolean)  :: ( NonPredicateField(f_$10_$0) ==> (!PredicateField(f_$10_$0)) ))) && ((forall  f_$10_$1 : Field (Integer)  :: ( NonPredicateField(f_$10_$1) ==> (!PredicateField(f_$10_$1)) )))) && ((forall  f_$10_$2 : Field (ref)  :: ( NonPredicateField(f_$10_$2) ==> (!PredicateField(f_$10_$2)) )))) && ((forall  f_$10_$3 : Field (HeapType)  :: ( NonPredicateField(f_$10_$3) ==> (!PredicateField(f_$10_$3)) )))) && ((forall  f_$10_$4 : Field (Mu)  :: ( NonPredicateField(f_$10_$4) ==> (!PredicateField(f_$10_$4)) )))) && ((forall  f_$10_$5 : Field (Seq (Integer) )  :: ( NonPredicateField(f_$10_$5) ==> (!PredicateField(f_$10_$5)) )));
	assume ((((((forall  f_$11_$0 : Field (Boolean)  :: ( PredicateField(f_$11_$0) ==> (!NonPredicateField(f_$11_$0)) ))) && ((forall  f_$11_$1 : Field (Integer)  :: ( PredicateField(f_$11_$1) ==> (!NonPredicateField(f_$11_$1)) )))) && ((forall  f_$11_$2 : Field (ref)  :: ( PredicateField(f_$11_$2) ==> (!NonPredicateField(f_$11_$2)) )))) && ((forall  f_$11_$3 : Field (HeapType)  :: ( PredicateField(f_$11_$3) ==> (!NonPredicateField(f_$11_$3)) )))) && ((forall  f_$11_$4 : Field (Mu)  :: ( PredicateField(f_$11_$4) ==> (!NonPredicateField(f_$11_$4)) )))) && ((forall  f_$11_$5 : Field (Seq (Integer) )  :: ( PredicateField(f_$11_$5) ==> (!NonPredicateField(f_$11_$5)) )));
	assume (((((((((((((((((((forall  con_$1 : Boolean, a_$0_$0 : Boolean, b_$0_$0 : Boolean :: {ite(con_$1,a_$0_$0,b_$0_$0)} ( con_$1 ==> (ite(con_$1,a_$0_$0,b_$0_$0) == a_$0_$0) ))) && ((forall  con_$2 : Boolean, a_$0_$1 : Integer, b_$0_$1 : Integer :: {ite(con_$2,a_$0_$1,b_$0_$1)} ( con_$2 ==> (ite(con_$2,a_$0_$1,b_$0_$1) == a_$0_$1) )))) && ((forall  con_$3 : Boolean, a_$0_$2 : [PermissionComponent]Integer, b_$0_$2 : [PermissionComponent]Integer :: {ite(con_$3,a_$0_$2,b_$0_$2)} ( con_$3 ==> (ite(con_$3,a_$0_$2,b_$0_$2) == a_$0_$2) )))) && ((forall  con_$4 : Boolean, a_$0_$3 : PermissionComponent, b_$0_$3 : PermissionComponent :: {ite(con_$4,a_$0_$3,b_$0_$3)} ( con_$4 ==> (ite(con_$4,a_$0_$3,b_$0_$3) == a_$0_$3) )))) && ((forall  con_$5 : Boolean, a_$0_$4 : MaskType, b_$0_$4 : MaskType :: {ite(con_$5,a_$0_$4,b_$0_$4)} ( con_$5 ==> (ite(con_$5,a_$0_$4,b_$0_$4) == a_$0_$4) )))) && ((forall  con_$6 : Boolean, a_$0_$5 : ref, b_$0_$5 : ref :: {ite(con_$6,a_$0_$5,b_$0_$5)} ( con_$6 ==> (ite(con_$6,a_$0_$5,b_$0_$5) == a_$0_$5) )))) && ((forall  con_$7 : Boolean, a_$0_$6 : Field (Integer) , b_$0_$6 : Field (Integer)  :: {ite(con_$7,a_$0_$6,b_$0_$6)} ( con_$7 ==> (ite(con_$7,a_$0_$6,b_$0_$6) == a_$0_$6) )))) && ((forall  con_$8 : Boolean, a_$0_$7 : HeapType, b_$0_$7 : HeapType :: {ite(con_$8,a_$0_$7,b_$0_$7)} ( con_$8 ==> (ite(con_$8,a_$0_$7,b_$0_$7) == a_$0_$7) )))) && ((forall  con_$9 : Boolean, a_$0_$8 : Field (Mu) , b_$0_$8 : Field (Mu)  :: {ite(con_$9,a_$0_$8,b_$0_$8)} ( con_$9 ==> (ite(con_$9,a_$0_$8,b_$0_$8) == a_$0_$8) )))) && ((forall  con_$10 : Boolean, a_$0_$9 : Mu, b_$0_$9 : Mu :: {ite(con_$10,a_$0_$9,b_$0_$9)} ( con_$10 ==> (ite(con_$10,a_$0_$9,b_$0_$9) == a_$0_$9) )))) && ((forall  con_$11 : Boolean, a_$0_$10 : Field (Boolean) , b_$0_$10 : Field (Boolean)  :: {ite(con_$11,a_$0_$10,b_$0_$10)} ( con_$11 ==> (ite(con_$11,a_$0_$10,b_$0_$10) == a_$0_$10) )))) && ((forall  con_$12 : Boolean, a_$0_$11 : CreditsType, b_$0_$11 : CreditsType :: {ite(con_$12,a_$0_$11,b_$0_$11)} ( con_$12 ==> (ite(con_$12,a_$0_$11,b_$0_$11) == a_$0_$11) )))) && ((forall  con_$13 : Boolean, a_$0_$12 : Seq (ref) , b_$0_$12 : Seq (ref)  :: {ite(con_$13,a_$0_$12,b_$0_$12)} ( con_$13 ==> (ite(con_$13,a_$0_$12,b_$0_$12) == a_$0_$12) )))) && ((forall  con_$14 : Boolean, a_$0_$13 : Seq (Integer) , b_$0_$13 : Seq (Integer)  :: {ite(con_$14,a_$0_$13,b_$0_$13)} ( con_$14 ==> (ite(con_$14,a_$0_$13,b_$0_$13) == a_$0_$13) )))) && ((forall  con_$15 : Boolean, a_$0_$14 : Field (ref) , b_$0_$14 : Field (ref)  :: {ite(con_$15,a_$0_$14,b_$0_$14)} ( con_$15 ==> (ite(con_$15,a_$0_$14,b_$0_$14) == a_$0_$14) )))) && ((forall  con_$16 : Boolean, a_$0_$15 : Field (Seq (Integer) ) , b_$0_$15 : Field (Seq (Integer) )  :: {ite(con_$16,a_$0_$15,b_$0_$15)} ( con_$16 ==> (ite(con_$16,a_$0_$15,b_$0_$15) == a_$0_$15) )))) && ((forall  con_$17 : Boolean, a_$0_$16 : Field (HeapType) , b_$0_$16 : Field (HeapType)  :: {ite(con_$17,a_$0_$16,b_$0_$16)} ( con_$17 ==> (ite(con_$17,a_$0_$16,b_$0_$16) == a_$0_$16) )))) && ((forall  con_$18 : Boolean, a_$0_$17 : TypeName, b_$0_$17 : TypeName :: {ite(con_$18,a_$0_$17,b_$0_$17)} ( con_$18 ==> (ite(con_$18,a_$0_$17,b_$0_$17) == a_$0_$17) )))) && ((forall  con_$19 : Boolean, a_$0_$18 : ModuleName, b_$0_$18 : ModuleName :: {ite(con_$19,a_$0_$18,b_$0_$18)} ( con_$19 ==> (ite(con_$19,a_$0_$18,b_$0_$18) == a_$0_$18) )));
	assume (((((((((((((((((((forall  con_$0_$0 : Boolean, a_$1_$0 : Boolean, b_$1_$0 : Boolean :: {ite(con_$0_$0,a_$1_$0,b_$1_$0)} ( (!con_$0_$0) ==> (ite(con_$0_$0,a_$1_$0,b_$1_$0) == b_$1_$0) ))) && ((forall  con_$0_$1 : Boolean, a_$1_$1 : Integer, b_$1_$1 : Integer :: {ite(con_$0_$1,a_$1_$1,b_$1_$1)} ( (!con_$0_$1) ==> (ite(con_$0_$1,a_$1_$1,b_$1_$1) == b_$1_$1) )))) && ((forall  con_$0_$2 : Boolean, a_$1_$2 : [PermissionComponent]Integer, b_$1_$2 : [PermissionComponent]Integer :: {ite(con_$0_$2,a_$1_$2,b_$1_$2)} ( (!con_$0_$2) ==> (ite(con_$0_$2,a_$1_$2,b_$1_$2) == b_$1_$2) )))) && ((forall  con_$0_$3 : Boolean, a_$1_$3 : PermissionComponent, b_$1_$3 : PermissionComponent :: {ite(con_$0_$3,a_$1_$3,b_$1_$3)} ( (!con_$0_$3) ==> (ite(con_$0_$3,a_$1_$3,b_$1_$3) == b_$1_$3) )))) && ((forall  con_$0_$4 : Boolean, a_$1_$4 : MaskType, b_$1_$4 : MaskType :: {ite(con_$0_$4,a_$1_$4,b_$1_$4)} ( (!con_$0_$4) ==> (ite(con_$0_$4,a_$1_$4,b_$1_$4) == b_$1_$4) )))) && ((forall  con_$0_$5 : Boolean, a_$1_$5 : ref, b_$1_$5 : ref :: {ite(con_$0_$5,a_$1_$5,b_$1_$5)} ( (!con_$0_$5) ==> (ite(con_$0_$5,a_$1_$5,b_$1_$5) == b_$1_$5) )))) && ((forall  con_$0_$6 : Boolean, a_$1_$6 : Field (Integer) , b_$1_$6 : Field (Integer)  :: {ite(con_$0_$6,a_$1_$6,b_$1_$6)} ( (!con_$0_$6) ==> (ite(con_$0_$6,a_$1_$6,b_$1_$6) == b_$1_$6) )))) && ((forall  con_$0_$7 : Boolean, a_$1_$7 : HeapType, b_$1_$7 : HeapType :: {ite(con_$0_$7,a_$1_$7,b_$1_$7)} ( (!con_$0_$7) ==> (ite(con_$0_$7,a_$1_$7,b_$1_$7) == b_$1_$7) )))) && ((forall  con_$0_$8 : Boolean, a_$1_$8 : Field (Mu) , b_$1_$8 : Field (Mu)  :: {ite(con_$0_$8,a_$1_$8,b_$1_$8)} ( (!con_$0_$8) ==> (ite(con_$0_$8,a_$1_$8,b_$1_$8) == b_$1_$8) )))) && ((forall  con_$0_$9 : Boolean, a_$1_$9 : Mu, b_$1_$9 : Mu :: {ite(con_$0_$9,a_$1_$9,b_$1_$9)} ( (!con_$0_$9) ==> (ite(con_$0_$9,a_$1_$9,b_$1_$9) == b_$1_$9) )))) && ((forall  con_$0_$10 : Boolean, a_$1_$10 : Field (Boolean) , b_$1_$10 : Field (Boolean)  :: {ite(con_$0_$10,a_$1_$10,b_$1_$10)} ( (!con_$0_$10) ==> (ite(con_$0_$10,a_$1_$10,b_$1_$10) == b_$1_$10) )))) && ((forall  con_$0_$11 : Boolean, a_$1_$11 : CreditsType, b_$1_$11 : CreditsType :: {ite(con_$0_$11,a_$1_$11,b_$1_$11)} ( (!con_$0_$11) ==> (ite(con_$0_$11,a_$1_$11,b_$1_$11) == b_$1_$11) )))) && ((forall  con_$0_$12 : Boolean, a_$1_$12 : Seq (ref) , b_$1_$12 : Seq (ref)  :: {ite(con_$0_$12,a_$1_$12,b_$1_$12)} ( (!con_$0_$12) ==> (ite(con_$0_$12,a_$1_$12,b_$1_$12) == b_$1_$12) )))) && ((forall  con_$0_$13 : Boolean, a_$1_$13 : Seq (Integer) , b_$1_$13 : Seq (Integer)  :: {ite(con_$0_$13,a_$1_$13,b_$1_$13)} ( (!con_$0_$13) ==> (ite(con_$0_$13,a_$1_$13,b_$1_$13) == b_$1_$13) )))) && ((forall  con_$0_$14 : Boolean, a_$1_$14 : Field (ref) , b_$1_$14 : Field (ref)  :: {ite(con_$0_$14,a_$1_$14,b_$1_$14)} ( (!con_$0_$14) ==> (ite(con_$0_$14,a_$1_$14,b_$1_$14) == b_$1_$14) )))) && ((forall  con_$0_$15 : Boolean, a_$1_$15 : Field (Seq (Integer) ) , b_$1_$15 : Field (Seq (Integer) )  :: {ite(con_$0_$15,a_$1_$15,b_$1_$15)} ( (!con_$0_$15) ==> (ite(con_$0_$15,a_$1_$15,b_$1_$15) == b_$1_$15) )))) && ((forall  con_$0_$16 : Boolean, a_$1_$16 : Field (HeapType) , b_$1_$16 : Field (HeapType)  :: {ite(con_$0_$16,a_$1_$16,b_$1_$16)} ( (!con_$0_$16) ==> (ite(con_$0_$16,a_$1_$16,b_$1_$16) == b_$1_$16) )))) && ((forall  con_$0_$17 : Boolean, a_$1_$17 : TypeName, b_$1_$17 : TypeName :: {ite(con_$0_$17,a_$1_$17,b_$1_$17)} ( (!con_$0_$17) ==> (ite(con_$0_$17,a_$1_$17,b_$1_$17) == b_$1_$17) )))) && ((forall  con_$0_$18 : Boolean, a_$1_$18 : ModuleName, b_$1_$18 : ModuleName :: {ite(con_$0_$18,a_$1_$18,b_$1_$18)} ( (!con_$0_$18) ==> (ite(con_$0_$18,a_$1_$18,b_$1_$18) == b_$1_$18) )));
	assume (forall  x_$0 : Integer, y_$0 : Integer :: {x_$0 mod y_$0} {x_$0 div y_$0} ( (x_$0 mod y_$0) == (x_$0 - ((x_$0 div y_$0) * y_$0)) ));
	assume (forall  x_$1 : Integer, y_$1 : Integer :: {x_$1 mod y_$1} ( (0 < y_$1) ==> ((0 <= (x_$1 mod y_$1)) && ((x_$1 mod y_$1) < y_$1)) ));
	assume (forall  x_$2 : Integer, y_$2 : Integer :: {x_$2 mod y_$2} ( (y_$2 < 0) ==> ((y_$2 < (x_$2 mod y_$2)) && ((x_$2 mod y_$2) <= 0)) ));
	assume (forall  a_$2 : Integer, b_$2 : Integer, d : Integer :: {a_$2 mod d,b_$2 mod d} ( (((2 <= d) && ((a_$2 mod d) == (b_$2 mod d))) && (a_$2 < b_$2)) ==> ((a_$2 + d) <= b_$2) ));
	assume ((forall  s_$12 : Seq (Integer)  :: {Seq#Length(s_$12)} ( 0 <= Seq#Length(s_$12) ))) && ((forall  s_$13 : Seq (ref)  :: {Seq#Length(s_$13)} ( 0 <= Seq#Length(s_$13) )));
	assume (Seq#Length((Seq#Empty() : Seq (Integer) )) == 0) && (Seq#Length((Seq#Empty() : Seq (ref) )) == 0);
	assume ((forall  s_$0_$0 : Seq (Integer)  :: {Seq#Length(s_$0_$0)} ( (Seq#Length(s_$0_$0) == 0) ==> (s_$0_$0 == (Seq#Empty() : Seq (Integer) )) ))) && ((forall  s_$0_$1 : Seq (ref)  :: {Seq#Length(s_$0_$1)} ( (Seq#Length(s_$0_$1) == 0) ==> (s_$0_$1 == (Seq#Empty() : Seq (ref) )) )));
	assume ((forall  t_$2 : Integer :: {Seq#Length(Seq#Singleton(t_$2))} ( Seq#Length(Seq#Singleton(t_$2)) == 1 ))) && ((forall  t_$3 : ref :: {Seq#Length(Seq#Singleton(t_$3))} ( Seq#Length(Seq#Singleton(t_$3)) == 1 )));
	assume ((forall  s_$1_$0 : Seq (Integer) , i_$5 : Integer, v_$2 : Integer, len_$2 : Integer :: {Seq#Length(Seq#Build(s_$1_$0,i_$5,v_$2,len_$2))} ( (0 <= len_$2) ==> (Seq#Length(Seq#Build(s_$1_$0,i_$5,v_$2,len_$2)) == len_$2) ))) && ((forall  s_$1_$1 : Seq (ref) , i_$6 : Integer, v_$3 : ref, len_$3 : Integer :: {Seq#Length(Seq#Build(s_$1_$1,i_$6,v_$3,len_$3))} ( (0 <= len_$3) ==> (Seq#Length(Seq#Build(s_$1_$1,i_$6,v_$3,len_$3)) == len_$3) )));
	assume ((forall  s0_$4 : Seq (Integer) , s1_$4 : Seq (Integer)  :: {Seq#Length(Seq#Append(s0_$4,s1_$4))} ( Seq#Length(Seq#Append(s0_$4,s1_$4)) == (Seq#Length(s0_$4) + Seq#Length(s1_$4)) ))) && ((forall  s0_$5 : Seq (ref) , s1_$5 : Seq (ref)  :: {Seq#Length(Seq#Append(s0_$5,s1_$5))} ( Seq#Length(Seq#Append(s0_$5,s1_$5)) == (Seq#Length(s0_$5) + Seq#Length(s1_$5)) )));
	assume ((forall  t_$0_$0 : Integer :: {Seq#Index(Seq#Singleton(t_$0_$0),0)} ( Seq#Index(Seq#Singleton(t_$0_$0),0) == t_$0_$0 ))) && ((forall  t_$0_$1 : ref :: {Seq#Index(Seq#Singleton(t_$0_$1),0)} ( Seq#Index(Seq#Singleton(t_$0_$1),0) == t_$0_$1 )));
	assume ((forall  s0_$0_$0 : Seq (Integer) , s1_$0_$0 : Seq (Integer) , n_$3_$0 : Integer :: {Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0)} ( ((n_$3_$0 < Seq#Length(s0_$0_$0)) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0) == Seq#Index(s0_$0_$0,n_$3_$0))) && ((Seq#Length(s0_$0_$0) <= n_$3_$0) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$3_$0) == Seq#Index(s1_$0_$0,n_$3_$0 - Seq#Length(s0_$0_$0)))) ))) && ((forall  s0_$0_$1 : Seq (ref) , s1_$0_$1 : Seq (ref) , n_$3_$1 : Integer :: {Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1)} ( ((n_$3_$1 < Seq#Length(s0_$0_$1)) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1) == Seq#Index(s0_$0_$1,n_$3_$1))) && ((Seq#Length(s0_$0_$1) <= n_$3_$1) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$3_$1) == Seq#Index(s1_$0_$1,n_$3_$1 - Seq#Length(s0_$0_$1)))) )));
	assume ((forall  s_$2_$0 : Seq (Integer) , i_$0_$0 : Integer, v_$0_$0 : Integer, len_$0_$0 : Integer, n_$4_$0 : Integer :: {Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0)} ( ((0 <= n_$4_$0) && (n_$4_$0 < len_$0_$0)) ==> (((i_$0_$0 == n_$4_$0) ==> (Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0) == v_$0_$0)) && ((!(i_$0_$0 == n_$4_$0)) ==> (Seq#Index(Seq#Build(s_$2_$0,i_$0_$0,v_$0_$0,len_$0_$0),n_$4_$0) == Seq#Index(s_$2_$0,n_$4_$0)))) ))) && ((forall  s_$2_$1 : Seq (ref) , i_$0_$1 : Integer, v_$0_$1 : ref, len_$0_$1 : Integer, n_$4_$1 : Integer :: {Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1)} ( ((0 <= n_$4_$1) && (n_$4_$1 < len_$0_$1)) ==> (((i_$0_$1 == n_$4_$1) ==> (Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1) == v_$0_$1)) && ((!(i_$0_$1 == n_$4_$1)) ==> (Seq#Index(Seq#Build(s_$2_$1,i_$0_$1,v_$0_$1,len_$0_$1),n_$4_$1) == Seq#Index(s_$2_$1,n_$4_$1)))) )));
	assume ((forall  s_$3_$0 : Seq (Integer) , x_$3_$0 : Integer :: {Seq#Contains(s_$3_$0,x_$3_$0)} ( Seq#Contains(s_$3_$0,x_$3_$0) <==> ((exists  i_$1_$1 : Integer :: {Seq#Index(s_$3_$0,i_$1_$1)} ( ((0 <= i_$1_$1) && (i_$1_$1 < Seq#Length(s_$3_$0))) && (Seq#Index(s_$3_$0,i_$1_$1) == x_$3_$0) ))) ))) && ((forall  s_$3_$1 : Seq (ref) , x_$3_$1 : ref :: {Seq#Contains(s_$3_$1,x_$3_$1)} ( Seq#Contains(s_$3_$1,x_$3_$1) <==> ((exists  i_$1_$3 : Integer :: {Seq#Index(s_$3_$1,i_$1_$3)} ( ((0 <= i_$1_$3) && (i_$1_$3 < Seq#Length(s_$3_$1))) && (Seq#Index(s_$3_$1,i_$1_$3) == x_$3_$1) ))) )));
	assume (forall  x_$4 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$4)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$4) ));
	assume ((forall  s0_$1_$0 : Seq (Integer) , s1_$1_$0 : Seq (Integer) , x_$5_$0 : Integer :: {Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$5_$0)} ( Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$5_$0) <==> (Seq#Contains(s0_$1_$0,x_$5_$0) || Seq#Contains(s1_$1_$0,x_$5_$0)) ))) && ((forall  s0_$1_$1 : Seq (ref) , s1_$1_$1 : Seq (ref) , x_$5_$1 : ref :: {Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$5_$1)} ( Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$5_$1) <==> (Seq#Contains(s0_$1_$1,x_$5_$1) || Seq#Contains(s1_$1_$1,x_$5_$1)) )));
	assume ((forall  s_$4_$0 : Seq (Integer) , i_$2_$0 : Integer, v_$1_$0 : Integer, len_$1_$0 : Integer, x_$6_$0 : Integer :: {Seq#Contains(Seq#Build(s_$4_$0,i_$2_$0,v_$1_$0,len_$1_$0),x_$6_$0)} ( Seq#Contains(Seq#Build(s_$4_$0,i_$2_$0,v_$1_$0,len_$1_$0),x_$6_$0) <==> ((((0 <= i_$2_$0) && (i_$2_$0 < len_$1_$0)) && (x_$6_$0 == v_$1_$0)) || ((exists  j_$6 : Integer :: {Seq#Index(s_$4_$0,j_$6)} ( ((((0 <= j_$6) && (j_$6 < Seq#Length(s_$4_$0))) && (j_$6 < len_$1_$0)) && (!(j_$6 == i_$2_$0))) && (Seq#Index(s_$4_$0,j_$6) == x_$6_$0) )))) ))) && ((forall  s_$4_$1 : Seq (ref) , i_$2_$1 : Integer, v_$1_$1 : ref, len_$1_$1 : Integer, x_$6_$1 : ref :: {Seq#Contains(Seq#Build(s_$4_$1,i_$2_$1,v_$1_$1,len_$1_$1),x_$6_$1)} ( Seq#Contains(Seq#Build(s_$4_$1,i_$2_$1,v_$1_$1,len_$1_$1),x_$6_$1) <==> ((((0 <= i_$2_$1) && (i_$2_$1 < len_$1_$1)) && (x_$6_$1 == v_$1_$1)) || ((exists  j_$8 : Integer :: {Seq#Index(s_$4_$1,j_$8)} ( ((((0 <= j_$8) && (j_$8 < Seq#Length(s_$4_$1))) && (j_$8 < len_$1_$1)) && (!(j_$8 == i_$2_$1))) && (Seq#Index(s_$4_$1,j_$8) == x_$6_$1) )))) )));
	assume ((forall  s_$5_$0 : Seq (Integer) , n_$5_$0 : Integer, x_$7_$0 : Integer :: {Seq#Contains(Seq#Take(s_$5_$0,n_$5_$0),x_$7_$0)} ( Seq#Contains(Seq#Take(s_$5_$0,n_$5_$0),x_$7_$0) <==> ((exists  i_$3_$1 : Integer :: {Seq#Index(s_$5_$0,i_$3_$1)} ( (((0 <= i_$3_$1) && (i_$3_$1 < n_$5_$0)) && (i_$3_$1 < Seq#Length(s_$5_$0))) && (Seq#Index(s_$5_$0,i_$3_$1) == x_$7_$0) ))) ))) && ((forall  s_$5_$1 : Seq (ref) , n_$5_$1 : Integer, x_$7_$1 : ref :: {Seq#Contains(Seq#Take(s_$5_$1,n_$5_$1),x_$7_$1)} ( Seq#Contains(Seq#Take(s_$5_$1,n_$5_$1),x_$7_$1) <==> ((exists  i_$3_$3 : Integer :: {Seq#Index(s_$5_$1,i_$3_$3)} ( (((0 <= i_$3_$3) && (i_$3_$3 < n_$5_$1)) && (i_$3_$3 < Seq#Length(s_$5_$1))) && (Seq#Index(s_$5_$1,i_$3_$3) == x_$7_$1) ))) )));
	assume ((forall  s_$6_$0 : Seq (Integer) , n_$6_$0 : Integer, x_$8_$0 : Integer :: {Seq#Contains(Seq#Drop(s_$6_$0,n_$6_$0),x_$8_$0)} ( Seq#Contains(Seq#Drop(s_$6_$0,n_$6_$0),x_$8_$0) <==> ((exists  i_$4_$1 : Integer :: {Seq#Index(s_$6_$0,i_$4_$1)} ( (((0 <= n_$6_$0) && (n_$6_$0 <= i_$4_$1)) && (i_$4_$1 < Seq#Length(s_$6_$0))) && (Seq#Index(s_$6_$0,i_$4_$1) == x_$8_$0) ))) ))) && ((forall  s_$6_$1 : Seq (ref) , n_$6_$1 : Integer, x_$8_$1 : ref :: {Seq#Contains(Seq#Drop(s_$6_$1,n_$6_$1),x_$8_$1)} ( Seq#Contains(Seq#Drop(s_$6_$1,n_$6_$1),x_$8_$1) <==> ((exists  i_$4_$3 : Integer :: {Seq#Index(s_$6_$1,i_$4_$3)} ( (((0 <= n_$6_$1) && (n_$6_$1 <= i_$4_$3)) && (i_$4_$3 < Seq#Length(s_$6_$1))) && (Seq#Index(s_$6_$1,i_$4_$3) == x_$8_$1) ))) )));
	assume ((forall  s0_$2_$0 : Seq (Integer) , s1_$2_$0 : Seq (Integer)  :: {Seq#Equal(s0_$2_$0,s1_$2_$0)} ( Seq#Equal(s0_$2_$0,s1_$2_$0) <==> ((Seq#Length(s0_$2_$0) == Seq#Length(s1_$2_$0)) && ((forall  j_$0_$1 : Integer :: {Seq#Index(s0_$2_$0,j_$0_$1)} {Seq#Index(s1_$2_$0,j_$0_$1)} ( ((0 <= j_$0_$1) && (j_$0_$1 < Seq#Length(s0_$2_$0))) ==> (Seq#Index(s0_$2_$0,j_$0_$1) == Seq#Index(s1_$2_$0,j_$0_$1)) )))) ))) && ((forall  s0_$2_$1 : Seq (ref) , s1_$2_$1 : Seq (ref)  :: {Seq#Equal(s0_$2_$1,s1_$2_$1)} ( Seq#Equal(s0_$2_$1,s1_$2_$1) <==> ((Seq#Length(s0_$2_$1) == Seq#Length(s1_$2_$1)) && ((forall  j_$0_$3 : Integer :: {Seq#Index(s0_$2_$1,j_$0_$3)} {Seq#Index(s1_$2_$1,j_$0_$3)} ( ((0 <= j_$0_$3) && (j_$0_$3 < Seq#Length(s0_$2_$1))) ==> (Seq#Index(s0_$2_$1,j_$0_$3) == Seq#Index(s1_$2_$1,j_$0_$3)) )))) )));
	assume ((forall  a_$3_$0 : Seq (Integer) , b_$3_$0 : Seq (Integer)  :: {Seq#Equal(a_$3_$0,b_$3_$0)} ( Seq#Equal(a_$3_$0,b_$3_$0) ==> (a_$3_$0 == b_$3_$0) ))) && ((forall  a_$3_$1 : Seq (ref) , b_$3_$1 : Seq (ref)  :: {Seq#Equal(a_$3_$1,b_$3_$1)} ( Seq#Equal(a_$3_$1,b_$3_$1) ==> (a_$3_$1 == b_$3_$1) )));
	assume ((forall  s_$7_$0 : Seq (Integer) , n_$8_$0 : Integer :: {Seq#Length(Seq#Take(s_$7_$0,n_$8_$0))} ( (0 <= n_$8_$0) ==> (((n_$8_$0 <= Seq#Length(s_$7_$0)) ==> (Seq#Length(Seq#Take(s_$7_$0,n_$8_$0)) == n_$8_$0)) && ((Seq#Length(s_$7_$0) < n_$8_$0) ==> (Seq#Length(Seq#Take(s_$7_$0,n_$8_$0)) == Seq#Length(s_$7_$0)))) ))) && ((forall  s_$7_$1 : Seq (ref) , n_$8_$1 : Integer :: {Seq#Length(Seq#Take(s_$7_$1,n_$8_$1))} ( (0 <= n_$8_$1) ==> (((n_$8_$1 <= Seq#Length(s_$7_$1)) ==> (Seq#Length(Seq#Take(s_$7_$1,n_$8_$1)) == n_$8_$1)) && ((Seq#Length(s_$7_$1) < n_$8_$1) ==> (Seq#Length(Seq#Take(s_$7_$1,n_$8_$1)) == Seq#Length(s_$7_$1)))) )));
	assume ((forall  s_$8_$0 : Seq (Integer) , n_$9_$0 : Integer, j_$2_$0 : Integer :: {Seq#Index(Seq#Take(s_$8_$0,n_$9_$0),j_$2_$0)} {:weight  25}( (((0 <= j_$2_$0) && (j_$2_$0 < n_$9_$0)) && (j_$2_$0 < Seq#Length(s_$8_$0))) ==> (Seq#Index(Seq#Take(s_$8_$0,n_$9_$0),j_$2_$0) == Seq#Index(s_$8_$0,j_$2_$0)) ))) && ((forall  s_$8_$1 : Seq (ref) , n_$9_$1 : Integer, j_$2_$1 : Integer :: {Seq#Index(Seq#Take(s_$8_$1,n_$9_$1),j_$2_$1)} {:weight  25}( (((0 <= j_$2_$1) && (j_$2_$1 < n_$9_$1)) && (j_$2_$1 < Seq#Length(s_$8_$1))) ==> (Seq#Index(Seq#Take(s_$8_$1,n_$9_$1),j_$2_$1) == Seq#Index(s_$8_$1,j_$2_$1)) )));
	assume ((forall  s_$9_$0 : Seq (Integer) , n_$10_$0 : Integer :: {Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0))} ( (0 <= n_$10_$0) ==> (((n_$10_$0 <= Seq#Length(s_$9_$0)) ==> (Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0)) == (Seq#Length(s_$9_$0) - n_$10_$0))) && ((Seq#Length(s_$9_$0) < n_$10_$0) ==> (Seq#Length(Seq#Drop(s_$9_$0,n_$10_$0)) == 0))) ))) && ((forall  s_$9_$1 : Seq (ref) , n_$10_$1 : Integer :: {Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1))} ( (0 <= n_$10_$1) ==> (((n_$10_$1 <= Seq#Length(s_$9_$1)) ==> (Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1)) == (Seq#Length(s_$9_$1) - n_$10_$1))) && ((Seq#Length(s_$9_$1) < n_$10_$1) ==> (Seq#Length(Seq#Drop(s_$9_$1,n_$10_$1)) == 0))) )));
	assume ((forall  s_$10_$0 : Seq (Integer) , n_$11_$0 : Integer, j_$3_$0 : Integer :: {Seq#Index(Seq#Drop(s_$10_$0,n_$11_$0),j_$3_$0)} {:weight  25}( (((0 <= n_$11_$0) && (0 <= j_$3_$0)) && (j_$3_$0 < (Seq#Length(s_$10_$0) - n_$11_$0))) ==> (Seq#Index(Seq#Drop(s_$10_$0,n_$11_$0),j_$3_$0) == Seq#Index(s_$10_$0,j_$3_$0 + n_$11_$0)) ))) && ((forall  s_$10_$1 : Seq (ref) , n_$11_$1 : Integer, j_$3_$1 : Integer :: {Seq#Index(Seq#Drop(s_$10_$1,n_$11_$1),j_$3_$1)} {:weight  25}( (((0 <= n_$11_$1) && (0 <= j_$3_$1)) && (j_$3_$1 < (Seq#Length(s_$10_$1) - n_$11_$1))) ==> (Seq#Index(Seq#Drop(s_$10_$1,n_$11_$1),j_$3_$1) == Seq#Index(s_$10_$1,j_$3_$1 + n_$11_$1)) )));
	assume ((forall  s_$11_$0 : Seq (Integer) , t_$1_$0 : Seq (Integer)  :: {Seq#Append(s_$11_$0,t_$1_$0)} ( (Seq#Take(Seq#Append(s_$11_$0,t_$1_$0),Seq#Length(s_$11_$0)) == s_$11_$0) && (Seq#Drop(Seq#Append(s_$11_$0,t_$1_$0),Seq#Length(s_$11_$0)) == t_$1_$0) ))) && ((forall  s_$11_$1 : Seq (ref) , t_$1_$1 : Seq (ref)  :: {Seq#Append(s_$11_$1,t_$1_$1)} ( (Seq#Take(Seq#Append(s_$11_$1,t_$1_$1),Seq#Length(s_$11_$1)) == s_$11_$1) && (Seq#Drop(Seq#Append(s_$11_$1,t_$1_$1),Seq#Length(s_$11_$1)) == t_$1_$1) )));
	assume (forall  min : Integer, max : Integer :: {Seq#Length(Seq#Range(min,max))} ( ((min < max) ==> (Seq#Length(Seq#Range(min,max)) == (max - min))) && ((max <= min) ==> (Seq#Length(Seq#Range(min,max)) == 0)) ));
	assume (forall  min_$0 : Integer, max_$0 : Integer, j_$4 : Integer :: {Seq#Index(Seq#Range(min_$0,max_$0),j_$4)} ( ((0 <= j_$4) && (j_$4 < (max_$0 - min_$0))) ==> (Seq#Index(Seq#Range(min_$0,max_$0),j_$4) == (min_$0 + j_$4)) ));
	assume ((forall  x_$9_$0 : Integer, y_$3_$0 : Integer :: {Seq#Contains(Seq#Singleton(x_$9_$0),y_$3_$0)} ( Seq#Contains(Seq#Singleton(x_$9_$0),y_$3_$0) <==> (x_$9_$0 == y_$3_$0) ))) && ((forall  x_$9_$1 : ref, y_$3_$1 : ref :: {Seq#Contains(Seq#Singleton(x_$9_$1),y_$3_$1)} ( Seq#Contains(Seq#Singleton(x_$9_$1),y_$3_$1) <==> (x_$9_$1 == y_$3_$1) )));
	assume NonPredicateField(SortedTree.root);
	assume NonPredicateField(SortedTree.keys);
	assume NonPredicateField(SortedTree.numClones);
	assume PredicateField(SortedTree.valid);
	assume NonPredicateField(SortedTreeSnapshot.root);
	assume NonPredicateField(SortedTreeSnapshot.keys);
	assume PredicateField(SortedTreeSnapshot.valid);
	assume NonPredicateField(SortedTreeNode.key);
	assume NonPredicateField(SortedTreeNode.left);
	assume NonPredicateField(SortedTreeNode.right);
	assume NonPredicateField(SortedTreeNode.keys);
	assume NonPredicateField(SortedTreeNode.shared);
	assume PredicateField(SortedTreeNode.valid);
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume IsGoodMask(Mask);
	assume (this == null) || (dtype(this) == SortedTree#t);
	assume true;
	assume true;
	assume true;
	assume (this#52 == null) || (dtype(this#52) == SortedTreeNode#t);
	assume true;
	assume true;
	assume !(this == null);
	assume wf(Heap,Mask);
	goto anon0;
anon0:
	assume (0 < methodK#_106) && ((1000 * methodK#_106) < Fractions(1));
	assume CurrentModule == module#default;
	assume CanAssumeFunctionDefs;
	assume IsGoodInhaleState(inhaleHeap#_109_$_0,Heap,ZeroMask);
	assume !(this == null);
	assume Heap_$_0 == Heap[this,SortedTree.valid := inhaleHeap#_109_$_0[this,SortedTree.valid]];
	assume wf(Heap_$_0,ZeroMask);
	assume inhaleHeap#_109_$_0[this,SortedTree.valid] == Heap_$_0;
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,SortedTree.valid := ZeroMask[this,SortedTree.valid][perm$R := ZeroMask[this,SortedTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(inhaleHeap#_109_$_0[this,SortedTree.valid]);
	assume wf(Heap_$_0,Mask_$_0);
	assume wf(inhaleHeap#_109_$_0,Mask_$_0);
	assume !(this == null);
	assume Heap_$_1 == Heap_$_0[this,SortedTree.keys := inhaleHeap#_109_$_0[this,SortedTree.keys]];
	assume wf(Heap_$_1,Mask_$_0);
	assume true;
	assume methodK#_106 > 0;
	assume Mask_$_1 == Mask_$_0[this,SortedTree.keys := Mask_$_0[this,SortedTree.keys][perm$R := Mask_$_0[this,SortedTree.keys][perm$R] + methodK#_106]];
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(inhaleHeap#_109_$_0[this,SortedTree.keys]);
	assume wf(Heap_$_1,Mask_$_1);
	assume wf(inhaleHeap#_109_$_0,Mask_$_1);
	assume IsGoodMask(Mask_$_1);
	assume wf(Heap_$_1,Mask_$_1);
	assume Heap_$_1 == Heap;
	assume Mask_$_1 == Mask;
	assume ZeroCredits == Credits;
	assume ((0 < unfoldK#_110) && (unfoldK#_110 < Fractions(1))) && ((1000 * unfoldK#_110) < methodK#_106);
	assert { :msg "  92.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  92.3: unfold might fail because the predicate SortedTree.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  92.3: unfold might fail because the predicate SortedTree.valid does not hold. Insufficient fraction at <undefined position> for SortedTree.valid." } (Fractions(100) <= Mask_$_1[this,SortedTree.valid][perm$R]) && ((Fractions(100) == Mask_$_1[this,SortedTree.valid][perm$R]) ==> (0 <= Mask_$_1[this,SortedTree.valid][perm$N]));
	assume exhaleMask#_111_$_0 == Mask_$_1[this,SortedTree.valid := Mask_$_1[this,SortedTree.valid][perm$R := Mask_$_1[this,SortedTree.valid][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_1);
	assume wf(Heap_$_1,Mask_$_1);
	assume wf(Heap_$_1,exhaleMask#_111_$_0);
	assume wf(Heap_$_1,exhaleMask#_111_$_0);
	assume inhaleHeap#_113_$_0 == Heap_$_1[this,SortedTree.valid];
	assume IsGoodInhaleState(inhaleHeap#_113_$_0,Heap_$_1,exhaleMask#_111_$_0);
	assume !(this == null);
	assume Heap_$_2 == Heap_$_1[this,SortedTree.root := inhaleHeap#_113_$_0[this,SortedTree.root]];
	assume wf(Heap_$_2,exhaleMask#_111_$_0);
	assume (Heap_$_2[this,SortedTree.root] == null) || (dtype(Heap_$_2[this,SortedTree.root]) == SortedTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_2 == exhaleMask#_111_$_0[this,SortedTree.root := exhaleMask#_111_$_0[this,SortedTree.root][perm$R := exhaleMask#_111_$_0[this,SortedTree.root][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_2);
	assume IsGoodState(inhaleHeap#_113_$_0[this,SortedTree.root]);
	assume wf(Heap_$_2,Mask_$_2);
	assume wf(inhaleHeap#_113_$_0,Mask_$_2);
	assume !(this == null);
	assume Heap_$_3 == Heap_$_2[this,SortedTree.keys := inhaleHeap#_113_$_0[this,SortedTree.keys]];
	assume wf(Heap_$_3,Mask_$_2);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_3 == Mask_$_2[this,SortedTree.keys := Mask_$_2[this,SortedTree.keys][perm$R := Mask_$_2[this,SortedTree.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_3);
	assume IsGoodState(inhaleHeap#_113_$_0[this,SortedTree.keys]);
	assume wf(Heap_$_3,Mask_$_3);
	assume wf(inhaleHeap#_113_$_0,Mask_$_3);
	assume !(this == null);
	assume Heap_$_4 == Heap_$_3[this,SortedTree.numClones := inhaleHeap#_113_$_0[this,SortedTree.numClones]];
	assume wf(Heap_$_4,Mask_$_3);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_4 == Mask_$_3[this,SortedTree.numClones := Mask_$_3[this,SortedTree.numClones][perm$R := Mask_$_3[this,SortedTree.numClones][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_4);
	assume IsGoodState(inhaleHeap#_113_$_0[this,SortedTree.numClones]);
	assume wf(Heap_$_4,Mask_$_4);
	assume wf(inhaleHeap#_113_$_0,Mask_$_4);
	assume Heap_$_4[this,SortedTree.numClones] >= 0;
	assume Heap_$_4[this,SortedTree.numClones] < 50;
	if ($_$_condition) { goto anon64_Then; } else { goto anon64_Else; }
anon64_Then:
	assume $_$_condition;
	assume $_$_condition <==> (!(Heap_$_4[this,SortedTree.root] == null));
	assume !(Heap_$_4[this,SortedTree.root] == null);
	assume !(Heap_$_4[this,SortedTree.root] == null);
	assume Heap_$_5 == Heap_$_4[Heap_$_4[this,SortedTree.root],SortedTreeNode.valid := inhaleHeap#_113_$_0[Heap_$_4[this,SortedTree.root],SortedTreeNode.valid]];
	assume wf(Heap_$_5,Mask_$_4);
	assume inhaleHeap#_113_$_0[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid] == Heap_$_5;
	assume (Fractions(100) - Fractions(Heap_$_5[this,SortedTree.numClones])) > 0;
	assume Mask_$_5 == Mask_$_4[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid := Mask_$_4[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid][perm$R := Mask_$_4[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid][perm$R] + (Fractions(100) - Fractions(Heap_$_5[this,SortedTree.numClones]))]];
	assume IsGoodMask(Mask_$_5);
	assume IsGoodState(inhaleHeap#_113_$_0[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid]);
	assume wf(Heap_$_5,Mask_$_5);
	assume wf(inhaleHeap#_113_$_0,Mask_$_5);
	assume Mask_$_6 == Mask_$_5;
	assume Heap_$_6 == Heap_$_5;
	goto $branchMerge_0;
anon64_Else:
	assume !$_$_condition;
	assume $_$_condition <==> (!(Heap_$_4[this,SortedTree.root] == null));
	assume Heap_$_4[this,SortedTree.root] == null;
	assume Mask_$_6 == Mask_$_4;
	assume Heap_$_6 == Heap_$_4;
	goto $branchMerge_0;
anon65_Then:
	assume $_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap_$_6[this,SortedTree.root] == null));
	assume !(Heap_$_6[this,SortedTree.root] == null);
	assume !(Heap_$_6[this,SortedTree.root] == null);
	assume Heap_$_7 == Heap_$_6[Heap_$_6[this,SortedTree.root],SortedTreeNode.keys := inhaleHeap#_113_$_0[Heap_$_6[this,SortedTree.root],SortedTreeNode.keys]];
	assume wf(Heap_$_7,Mask_$_6);
	assume true;
	assume Fractions(50 - Heap_$_7[this,SortedTree.numClones]) > 0;
	assume Mask_$_7 == Mask_$_6[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys := Mask_$_6[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys][perm$R := Mask_$_6[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys][perm$R] + Fractions(50 - Heap_$_7[this,SortedTree.numClones])]];
	assume IsGoodMask(Mask_$_7);
	assume IsGoodState(inhaleHeap#_113_$_0[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys]);
	assume wf(Heap_$_7,Mask_$_7);
	assume wf(inhaleHeap#_113_$_0,Mask_$_7);
	assume Heap_$_8 == Heap_$_7;
	assume Mask_$_8 == Mask_$_7;
	goto $branchMerge_1;
anon65_Else:
	assume !$_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap_$_6[this,SortedTree.root] == null));
	assume Heap_$_6[this,SortedTree.root] == null;
	assume Heap_$_8 == Heap_$_6;
	assume Mask_$_8 == Mask_$_6;
	goto $branchMerge_1;
anon66_Then:
	assume $_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assume Seq#Equal(Heap_$_8[this,SortedTree.keys],Heap_$_8[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys]);
	goto $branchMerge_2;
anon66_Else:
	assume !$_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume Heap_$_8[this,SortedTree.root] == null;
	goto $branchMerge_2;
anon67_Then:
	assume $_$_condition_$4;
	assume $_$_condition_$4 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume Heap_$_8[this,SortedTree.root] == null;
	assume Seq#Equal(Heap_$_8[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon12;
anon67_Else:
	assume !$_$_condition_$4;
	assume $_$_condition_$4 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto anon12;
anon12:
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assert { :msg "  93.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  93.7: Location might not be readable." } true ==> CanRead(Mask_$_8,this,SortedTree.root);
	if ($_$_condition_$6) { goto anon68_Then; } else { goto anon68_Else; }
anon68_Then:
	assume $_$_condition_$6;
	assume $_$_condition_$6 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume Heap_$_8[this,SortedTree.root] == null;
	assume ((0 < foldK#_114) && ((1000 * foldK#_114) < Fractions(1))) && ((1000 * foldK#_114) < methodK#_106);
	assert { :msg "  95.4: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true." } Heap_$_8[this,SortedTree.numClones] >= 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true." } Heap_$_8[this,SortedTree.numClones] < 50;
	if ($_$_condition_$7) { goto anon69_Then; } else { goto anon69_Else; }
anon68_Else:
	assume !$_$_condition_$6;
	assume $_$_condition_$6 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assume ((0 < methodCallK#_125) && ((1000 * methodCallK#_125) < Fractions(1))) && ((1000 * methodCallK#_125) < methodK#_106);
	assert { :msg "  98.14: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  98.14: Location might not be readable." } true ==> CanRead(Mask_$_8,this,SortedTree.root);
	assert { :msg "  98.4: The target of the method call might be null." } !(Heap_$_8[this,SortedTree.root] == null);
	assume this#52_$_0 == Heap_$_8[this,SortedTree.root];
	assert { :msg "  98.4: The precondition at 284.12 might not hold. The permission at 284.12 might not be positive." } Fractions(1) > 0;
	assert { :msg "  98.4: The precondition at 284.12 might not hold. Insufficient fraction at 284.12 for SortedTreeNode.valid." } (Fractions(1) <= Mask_$_8[this#52_$_0,SortedTreeNode.valid][perm$R]) && ((Fractions(1) == Mask_$_8[this#52_$_0,SortedTreeNode.valid][perm$R]) ==> (0 <= Mask_$_8[this#52_$_0,SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_126_$_0 == Mask_$_8[this#52_$_0,SortedTreeNode.valid := Mask_$_8[this#52_$_0,SortedTreeNode.valid][perm$R := Mask_$_8[this#52_$_0,SortedTreeNode.valid][perm$R] - Fractions(1)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_126_$_0);
	assert { :msg "  98.4: The precondition at 285.12 might not hold. The permission at 285.12 might not be positive." } Fractions(1) > 0;
	assert { :msg "  98.4: The precondition at 285.12 might not hold. Insufficient fraction at 285.12 for SortedTreeNode.keys." } (Fractions(1) <= exhaleMask#_126_$_0[this#52_$_0,SortedTreeNode.keys][perm$R]) && ((Fractions(1) == exhaleMask#_126_$_0[this#52_$_0,SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_126_$_0[this#52_$_0,SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_126_$_1 == exhaleMask#_126_$_0[this#52_$_0,SortedTreeNode.keys := exhaleMask#_126_$_0[this#52_$_0,SortedTreeNode.keys][perm$R := exhaleMask#_126_$_0[this#52_$_0,SortedTreeNode.keys][perm$R] - Fractions(1)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_126_$_1);
	assume wf(Heap_$_8,exhaleMask#_126_$_1);
	assume true;
	assume IsGoodInhaleState(inhaleHeap#_131_$_0,Heap_$_8,exhaleMask#_126_$_1);
	assume !(this#52_$_0 == null);
	assume Heap_$_9 == Heap_$_8[this#52_$_0,SortedTreeNode.valid := inhaleHeap#_131_$_0[this#52_$_0,SortedTreeNode.valid]];
	assume wf(Heap_$_9,exhaleMask#_126_$_1);
	assume inhaleHeap#_131_$_0[this#52_$_0,SortedTreeNode.valid] == Heap_$_9;
	assume Fractions(1) > 0;
	assume Mask_$_9 == exhaleMask#_126_$_1[this#52_$_0,SortedTreeNode.valid := exhaleMask#_126_$_1[this#52_$_0,SortedTreeNode.valid][perm$R := exhaleMask#_126_$_1[this#52_$_0,SortedTreeNode.valid][perm$R] + Fractions(1)]];
	assume IsGoodMask(Mask_$_9);
	assume IsGoodState(inhaleHeap#_131_$_0[this#52_$_0,SortedTreeNode.valid]);
	assume wf(Heap_$_9,Mask_$_9);
	assume wf(inhaleHeap#_131_$_0,Mask_$_9);
	assume !(this#52_$_0 == null);
	assume Heap_$_10 == Heap_$_9[this#52_$_0,SortedTreeNode.keys := inhaleHeap#_131_$_0[this#52_$_0,SortedTreeNode.keys]];
	assume wf(Heap_$_10,Mask_$_9);
	assume true;
	assume Fractions(1) > 0;
	assume Mask_$_10 == Mask_$_9[this#52_$_0,SortedTreeNode.keys := Mask_$_9[this#52_$_0,SortedTreeNode.keys][perm$R := Mask_$_9[this#52_$_0,SortedTreeNode.keys][perm$R] + Fractions(1)]];
	assume IsGoodMask(Mask_$_10);
	assume IsGoodState(inhaleHeap#_131_$_0[this#52_$_0,SortedTreeNode.keys]);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(inhaleHeap#_131_$_0,Mask_$_10);
	assume b#54_$_0 <==> Seq#Contains(Heap_$_10[this#52_$_0,SortedTreeNode.keys],k#6);
	assume Seq#Equal(Heap_$_10[this#52_$_0,SortedTreeNode.keys],Heap_$_8[this#52_$_0,SortedTreeNode.keys]);
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume ((0 < foldK#_132) && ((1000 * foldK#_132) < Fractions(1))) && ((1000 * foldK#_132) < methodK#_106);
	assert { :msg "  100.4: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true." } Heap_$_10[this,SortedTree.numClones] >= 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true." } Heap_$_10[this,SortedTree.numClones] < 50;
	if ($_$_condition_$8) { goto anon77_Then; } else { goto anon77_Else; }
anon69_Then:
	assume $_$_condition_$7;
	assume $_$_condition_$7 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto $branchMerge_3;
anon69_Else:
	assume !$_$_condition_$7;
	assume $_$_condition_$7 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume Heap_$_8[this,SortedTree.root] == null;
	goto $branchMerge_3;
anon77_Then:
	assume $_$_condition_$8;
	assume $_$_condition_$8 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume !(Heap_$_10[this,SortedTree.root] == null);
	goto $branchMerge_4;
anon77_Else:
	assume !$_$_condition_$8;
	assume $_$_condition_$8 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume Heap_$_10[this,SortedTree.root] == null;
	goto $branchMerge_4;
anon70_Then:
	assume $_$_condition_$9;
	assume $_$_condition_$9 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto $branchMerge_5;
anon70_Else:
	assume !$_$_condition_$9;
	assume $_$_condition_$9 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume Heap_$_8[this,SortedTree.root] == null;
	goto $branchMerge_5;
anon78_Then:
	assume $_$_condition_$11;
	assume $_$_condition_$11 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume !(Heap_$_10[this,SortedTree.root] == null);
	goto $branchMerge_6;
anon78_Else:
	assume !$_$_condition_$11;
	assume $_$_condition_$11 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume Heap_$_10[this,SortedTree.root] == null;
	goto $branchMerge_6;
anon71_Then:
	assume $_$_condition_$13;
	assume $_$_condition_$13 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true." } Seq#Equal(Heap_$_8[this,SortedTree.keys],Heap_$_8[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys]);
	goto $branchMerge_7;
anon71_Else:
	assume !$_$_condition_$13;
	assume $_$_condition_$13 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume Heap_$_8[this,SortedTree.root] == null;
	goto $branchMerge_7;
anon79_Then:
	assume $_$_condition_$15;
	assume $_$_condition_$15 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume !(Heap_$_10[this,SortedTree.root] == null);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true." } Seq#Equal(Heap_$_10[this,SortedTree.keys],Heap_$_10[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys]);
	goto $branchMerge_8;
anon79_Else:
	assume !$_$_condition_$15;
	assume $_$_condition_$15 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume Heap_$_10[this,SortedTree.root] == null;
	goto $branchMerge_8;
anon72_Then:
	assume $_$_condition_$17;
	assume $_$_condition_$17 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume Heap_$_8[this,SortedTree.root] == null;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true." } Seq#Equal(Heap_$_8[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon25;
anon72_Else:
	assume !$_$_condition_$17;
	assume $_$_condition_$17 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto anon25;
anon80_Then:
	assume $_$_condition_$19;
	assume $_$_condition_$19 <==> (Heap_$_10[this,SortedTree.root] == null);
	assume Heap_$_10[this,SortedTree.root] == null;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true." } Seq#Equal(Heap_$_10[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon50;
anon80_Else:
	assume !$_$_condition_$19;
	assume $_$_condition_$19 <==> (Heap_$_10[this,SortedTree.root] == null);
	assume !(Heap_$_10[this,SortedTree.root] == null);
	goto anon50;
anon25:
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root." } (Fractions(100) <= Mask_$_8[this,SortedTree.root][perm$R]) && ((Fractions(100) == Mask_$_8[this,SortedTree.root][perm$R]) ==> (0 <= Mask_$_8[this,SortedTree.root][perm$N]));
	assume exhaleMask#_115_$_0 == Mask_$_8[this,SortedTree.root := Mask_$_8[this,SortedTree.root][perm$R := Mask_$_8[this,SortedTree.root][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_115_$_0);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys." } (Fractions(50) <= exhaleMask#_115_$_0[this,SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_115_$_0[this,SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_115_$_0[this,SortedTree.keys][perm$N]));
	assume exhaleMask#_115_$_1 == exhaleMask#_115_$_0[this,SortedTree.keys := exhaleMask#_115_$_0[this,SortedTree.keys][perm$R := exhaleMask#_115_$_0[this,SortedTree.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_115_$_1);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones." } (Fractions(100) <= exhaleMask#_115_$_1[this,SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_115_$_1[this,SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_115_$_1[this,SortedTree.numClones][perm$N]));
	assume exhaleMask#_115_$_2 == exhaleMask#_115_$_1[this,SortedTree.numClones := exhaleMask#_115_$_1[this,SortedTree.numClones][perm$R := exhaleMask#_115_$_1[this,SortedTree.numClones][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_115_$_2);
	if ($_$_condition_$21) { goto anon73_Then; } else { goto anon73_Else; }
anon50:
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root." } (Fractions(100) <= Mask_$_10[this,SortedTree.root][perm$R]) && ((Fractions(100) == Mask_$_10[this,SortedTree.root][perm$R]) ==> (0 <= Mask_$_10[this,SortedTree.root][perm$N]));
	assume exhaleMask#_133_$_0 == Mask_$_10[this,SortedTree.root := Mask_$_10[this,SortedTree.root][perm$R := Mask_$_10[this,SortedTree.root][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(Heap_$_10,exhaleMask#_133_$_0);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys." } (Fractions(50) <= exhaleMask#_133_$_0[this,SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_133_$_0[this,SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_133_$_0[this,SortedTree.keys][perm$N]));
	assume exhaleMask#_133_$_1 == exhaleMask#_133_$_0[this,SortedTree.keys := exhaleMask#_133_$_0[this,SortedTree.keys][perm$R := exhaleMask#_133_$_0[this,SortedTree.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(Heap_$_10,exhaleMask#_133_$_1);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones." } (Fractions(100) <= exhaleMask#_133_$_1[this,SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_133_$_1[this,SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_133_$_1[this,SortedTree.numClones][perm$N]));
	assume exhaleMask#_133_$_2 == exhaleMask#_133_$_1[this,SortedTree.numClones := exhaleMask#_133_$_1[this,SortedTree.numClones][perm$R := exhaleMask#_133_$_1[this,SortedTree.numClones][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(Heap_$_10,exhaleMask#_133_$_2);
	if ($_$_condition_$22) { goto anon81_Then; } else { goto anon81_Else; }
anon73_Then:
	assume $_$_condition_$21;
	assume $_$_condition_$21 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive." } (Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones])) > 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid." } ((Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones])) <= exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones])) == exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_115_$_3 == exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid := exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R := exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones]))]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_115_$_3);
	assume exhaleMask#_115_$_4 == exhaleMask#_115_$_3;
	goto $branchMerge_9;
anon73_Else:
	assume !$_$_condition_$21;
	assume $_$_condition_$21 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume Heap_$_8[this,SortedTree.root] == null;
	assume exhaleMask#_115_$_4 == exhaleMask#_115_$_2;
	goto $branchMerge_9;
anon81_Then:
	assume $_$_condition_$22;
	assume $_$_condition_$22 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume !(Heap_$_10[this,SortedTree.root] == null);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive." } (Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones])) > 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid." } ((Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones])) <= exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones])) == exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_133_$_3 == exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid := exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R := exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones]))]];
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(Heap_$_10,exhaleMask#_133_$_3);
	assume exhaleMask#_133_$_4 == exhaleMask#_133_$_3;
	goto $branchMerge_10;
anon81_Else:
	assume !$_$_condition_$22;
	assume $_$_condition_$22 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume Heap_$_10[this,SortedTree.root] == null;
	assume exhaleMask#_133_$_4 == exhaleMask#_133_$_2;
	goto $branchMerge_10;
anon74_Then:
	assume $_$_condition_$23;
	assume $_$_condition_$23 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive." } Fractions(50 - Heap_$_8[this,SortedTree.numClones]) > 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys." } (Fractions(50 - Heap_$_8[this,SortedTree.numClones]) <= exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap_$_8[this,SortedTree.numClones]) == exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_115_$_5 == exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys := exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R := exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R] - Fractions(50 - Heap_$_8[this,SortedTree.numClones])]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_115_$_5);
	assume exhaleMask#_115_$_6 == exhaleMask#_115_$_5;
	goto $branchMerge_11;
anon74_Else:
	assume !$_$_condition_$23;
	assume $_$_condition_$23 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume Heap_$_8[this,SortedTree.root] == null;
	assume exhaleMask#_115_$_6 == exhaleMask#_115_$_4;
	goto $branchMerge_11;
anon82_Then:
	assume $_$_condition_$25;
	assume $_$_condition_$25 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume !(Heap_$_10[this,SortedTree.root] == null);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive." } Fractions(50 - Heap_$_10[this,SortedTree.numClones]) > 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys." } (Fractions(50 - Heap_$_10[this,SortedTree.numClones]) <= exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap_$_10[this,SortedTree.numClones]) == exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_133_$_5 == exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys := exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R := exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R] - Fractions(50 - Heap_$_10[this,SortedTree.numClones])]];
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(Heap_$_10,exhaleMask#_133_$_5);
	assume exhaleMask#_133_$_6 == exhaleMask#_133_$_5;
	goto $branchMerge_12;
anon82_Else:
	assume !$_$_condition_$25;
	assume $_$_condition_$25 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume Heap_$_10[this,SortedTree.root] == null;
	assume exhaleMask#_133_$_6 == exhaleMask#_133_$_4;
	goto $branchMerge_12;
anon75_Then:
	assume $_$_condition_$27;
	assume $_$_condition_$27 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto $branchMerge_13;
anon75_Else:
	assume !$_$_condition_$27;
	assume $_$_condition_$27 <==> (!(Heap_$_8[this,SortedTree.root] == null));
	assume Heap_$_8[this,SortedTree.root] == null;
	goto $branchMerge_13;
anon83_Then:
	assume $_$_condition_$29;
	assume $_$_condition_$29 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume !(Heap_$_10[this,SortedTree.root] == null);
	goto $branchMerge_14;
anon83_Else:
	assume !$_$_condition_$29;
	assume $_$_condition_$29 <==> (!(Heap_$_10[this,SortedTree.root] == null));
	assume Heap_$_10[this,SortedTree.root] == null;
	goto $branchMerge_14;
anon76_Then:
	assume $_$_condition_$31;
	assume $_$_condition_$31 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume Heap_$_8[this,SortedTree.root] == null;
	goto anon37;
anon76_Else:
	assume !$_$_condition_$31;
	assume $_$_condition_$31 <==> (Heap_$_8[this,SortedTree.root] == null);
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto anon37;
anon84_Then:
	assume $_$_condition_$33;
	assume $_$_condition_$33 <==> (Heap_$_10[this,SortedTree.root] == null);
	assume Heap_$_10[this,SortedTree.root] == null;
	goto anon62;
anon84_Else:
	assume !$_$_condition_$33;
	assume $_$_condition_$33 <==> (Heap_$_10[this,SortedTree.root] == null);
	assume !(Heap_$_10[this,SortedTree.root] == null);
	goto anon62;
anon37:
	assume wf(Heap_$_8,exhaleMask#_115_$_6);
	assume IsGoodInhaleState(inhaleHeap#_121_$_0,Heap_$_8,exhaleMask#_115_$_6);
	assume !(this == null);
	assume Heap_$_13 == Heap_$_8[this,SortedTree.valid := inhaleHeap#_121_$_0[this,SortedTree.valid]];
	assume wf(Heap_$_13,exhaleMask#_115_$_6);
	assume inhaleHeap#_121_$_0[this,SortedTree.valid] == Heap_$_13;
	assume Fractions(100) > 0;
	assume Mask_$_12 == exhaleMask#_115_$_6[this,SortedTree.valid := exhaleMask#_115_$_6[this,SortedTree.valid][perm$R := exhaleMask#_115_$_6[this,SortedTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_12);
	assume IsGoodState(inhaleHeap#_121_$_0[this,SortedTree.valid]);
	assume wf(Heap_$_13,Mask_$_12);
	assume wf(inhaleHeap#_121_$_0,Mask_$_12);
	assume IsGoodMask(Mask_$_12);
	assume wf(Heap_$_13,Mask_$_12);
	assume Heap_$_14 == Heap_$_13[this,SortedTree.valid := Heap_$_13];
	assume wf(Heap_$_14,Mask_$_12);
	assume Mask_$_13 == Mask_$_12;
	assume Heap_$_15 == Heap_$_14;
	assume b#7_$_0 <==> false;
	goto anon63;
anon62:
	assume wf(Heap_$_10,exhaleMask#_133_$_6);
	assume IsGoodInhaleState(inhaleHeap#_139_$_0,Heap_$_10,exhaleMask#_133_$_6);
	assume !(this == null);
	assume Heap_$_11 == Heap_$_10[this,SortedTree.valid := inhaleHeap#_139_$_0[this,SortedTree.valid]];
	assume wf(Heap_$_11,exhaleMask#_133_$_6);
	assume inhaleHeap#_139_$_0[this,SortedTree.valid] == Heap_$_11;
	assume Fractions(100) > 0;
	assume Mask_$_11 == exhaleMask#_133_$_6[this,SortedTree.valid := exhaleMask#_133_$_6[this,SortedTree.valid][perm$R := exhaleMask#_133_$_6[this,SortedTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_11);
	assume IsGoodState(inhaleHeap#_139_$_0[this,SortedTree.valid]);
	assume wf(Heap_$_11,Mask_$_11);
	assume wf(inhaleHeap#_139_$_0,Mask_$_11);
	assume IsGoodMask(Mask_$_11);
	assume wf(Heap_$_11,Mask_$_11);
	assume Heap_$_12 == Heap_$_11[this,SortedTree.valid := Heap_$_11];
	assume wf(Heap_$_12,Mask_$_11);
	assume Mask_$_13 == Mask_$_11;
	assume Heap_$_15 == Heap_$_12;
	assume b#7_$_0 <==> b#54_$_0;
	goto anon63;
anon63:
	assert { :msg "  84.2: The postcondition at 90.11 might not hold. The expression at 90.11 might not evaluate to true." } b#7_$_0 <==> Seq#Contains(Heap_$_15[this,SortedTree.keys],k#6);
	assert { :msg "  84.2: The postcondition at 88.11 might not hold. The permission at 88.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  84.2: The postcondition at 88.11 might not hold. Insufficient fraction at 88.11 for SortedTree.valid." } (Fractions(100) <= Mask_$_13[this,SortedTree.valid][perm$R]) && ((Fractions(100) == Mask_$_13[this,SortedTree.valid][perm$R]) ==> (0 <= Mask_$_13[this,SortedTree.valid][perm$N]));
	assume exhaleMask#_140_$_0 == Mask_$_13[this,SortedTree.valid := Mask_$_13[this,SortedTree.valid][perm$R := Mask_$_13[this,SortedTree.valid][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_13);
	assume wf(Heap_$_15,Mask_$_13);
	assume wf(Heap_$_15,exhaleMask#_140_$_0);
	assert { :msg "  84.2: The postcondition at 89.11 might not hold. The permission at 89.11 might not be positive." } methodK#_106 > 0;
	assert { :msg "  84.2: The postcondition at 89.11 might not hold. Insufficient fraction at 89.11 for SortedTree.keys." } (methodK#_106 <= exhaleMask#_140_$_0[this,SortedTree.keys][perm$R]) && ((methodK#_106 == exhaleMask#_140_$_0[this,SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_140_$_0[this,SortedTree.keys][perm$N]));
	assume exhaleMask#_140_$_1 == exhaleMask#_140_$_0[this,SortedTree.keys := exhaleMask#_140_$_0[this,SortedTree.keys][perm$R := exhaleMask#_140_$_0[this,SortedTree.keys][perm$R] - methodK#_106]];
	assume IsGoodMask(Mask_$_13);
	assume wf(Heap_$_15,Mask_$_13);
	assume wf(Heap_$_15,exhaleMask#_140_$_1);
	assume wf(Heap_$_15,exhaleMask#_140_$_1);
	assert { :msg "  84.2: Method might lock/unlock more than allowed." } (forall  lk#_143 : ref :: {Heap_$_15[lk#_143,held]} {Heap_$_15[lk#_143,rdheld]} ( (((0 < Heap_$_15[lk#_143,held]) <==> (0 < Heap[lk#_143,held])) && (Heap_$_15[lk#_143,rdheld] <==> Heap[lk#_143,rdheld])) || false ));
	assert { :msg "  84.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
$branchMerge_0:
	if ($_$_condition_$0) { goto anon65_Then; } else { goto anon65_Else; }
$branchMerge_1:
	if ($_$_condition_$2) { goto anon66_Then; } else { goto anon66_Else; }
$branchMerge_2:
	if ($_$_condition_$4) { goto anon67_Then; } else { goto anon67_Else; }
$branchMerge_3:
	if ($_$_condition_$9) { goto anon70_Then; } else { goto anon70_Else; }
$branchMerge_4:
	if ($_$_condition_$11) { goto anon78_Then; } else { goto anon78_Else; }
$branchMerge_5:
	if ($_$_condition_$13) { goto anon71_Then; } else { goto anon71_Else; }
$branchMerge_6:
	if ($_$_condition_$15) { goto anon79_Then; } else { goto anon79_Else; }
$branchMerge_7:
	if ($_$_condition_$17) { goto anon72_Then; } else { goto anon72_Else; }
$branchMerge_8:
	if ($_$_condition_$19) { goto anon80_Then; } else { goto anon80_Else; }
$branchMerge_9:
	if ($_$_condition_$23) { goto anon74_Then; } else { goto anon74_Else; }
$branchMerge_10:
	if ($_$_condition_$25) { goto anon82_Then; } else { goto anon82_Else; }
$branchMerge_11:
	if ($_$_condition_$27) { goto anon75_Then; } else { goto anon75_Else; }
$branchMerge_12:
	if ($_$_condition_$29) { goto anon83_Then; } else { goto anon83_Else; }
$branchMerge_13:
	if ($_$_condition_$31) { goto anon76_Then; } else { goto anon76_Else; }
$branchMerge_14:
	if ($_$_condition_$33) { goto anon84_Then; } else { goto anon84_Else; }
}
