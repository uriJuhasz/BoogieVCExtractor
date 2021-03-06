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
function #AVLTree.valid#trigger(ref) : bool;
var Heap : HeapType;
var Mask : MaskType;
var SecMask : MaskType;
var Credits : CreditsType;
procedure AVLTree.init (this : ref)
{
	var methodK#_11 : int;
	var foldK#_15 : int;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Heap_$_0 : HeapType;
	var Heap_$_1 : HeapType;
	var exhaleHeap#_16_$_0 : HeapType;
	var exhaleMask#_17_$_0 : MaskType;
	var SecMask_$_0 : MaskType;
	var exhaleMask#_17_$_1 : MaskType;
	var SecMask_$_1 : MaskType;
	var exhaleMask#_17_$_2 : MaskType;
	var SecMask_$_2 : MaskType;
	var SecMask_$_3 : MaskType;
	var exhaleMask#_17_$_3 : MaskType;
	var exhaleMask#_17_$_4 : MaskType;
	var SecMask_$_4 : MaskType;
	var exhaleMask#_17_$_5 : MaskType;
	var SecMask_$_5 : MaskType;
	var exhaleMask#_17_$_6 : MaskType;
	var SecMask_$_6 : MaskType;
	var SecMask_$_7 : MaskType;
	var exhaleMask#_17_$_7 : MaskType;
	var exhaleMask#_17_$_8 : MaskType;
	var SecMask_$_8 : MaskType;
	var exhaleMask#_17_$_9 : MaskType;
	var SecMask_$_9 : MaskType;
	var Mask_$_2 : MaskType;
	var predVer#_13_$_0 : int;
	var exhaleHeap#_24_$_0 : HeapType;
	var exhaleMask#_25_$_0 : MaskType;
	var SecMask_$_10 : MaskType;
	var SecMask_$_11 : MaskType;
	var SecMask_$_12 : MaskType;
	var SecMask_$_13 : MaskType;
	var SecMask_$_14 : MaskType;
	var SecMask_$_15 : MaskType;
	var SecMask_$_16 : MaskType;
	var SecMask_$_17 : MaskType;
	var SecMask_$_18 : MaskType;
	var SecMask_$_19 : MaskType;
	var SecMask_$_20 : MaskType;
	var SecMask_$_21 : MaskType;
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
	var exhaleMask#_25_$_1 : MaskType;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$3 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$11 : bool;
	var $_$_condition_$12 : bool;
	var $_$_condition_$13 : bool;
	var $_$_condition_$15 : bool;
	var $_$_condition_$16 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$18 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$22 : bool;
	var $_$_condition_$24 : bool;
	var $_$_condition_$25 : bool;
	var $_$_condition_$27 : bool;
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
	assume (this == null) || (dtype(this) == AVLTree#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_11) && ((1000 * methodK#_11) < Fractions(1));
	assume CurrentModule == module#default;
	assume CanAssumeFunctionDefs;
	assume !(this == null);
	assume wf(Heap,ZeroMask,ZeroMask);
	assume (Heap[this,AVLTree.root] == null) || (dtype(Heap[this,AVLTree.root]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,AVLTree.root := ZeroMask[this,AVLTree.root][perm$R := ZeroMask[this,AVLTree.root][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,AVLTree.root]));
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_1 == Mask_$_0[this,AVLTree.keys := Mask_$_0[this,AVLTree.keys][perm$R := Mask_$_0[this,AVLTree.keys][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(heapFragment(Heap[this,AVLTree.keys]));
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume IsGoodMask(Mask_$_1);
	assume wf(Heap,Mask_$_1,ZeroMask);
	assume Heap == Heap;
	assume Mask_$_1 == Mask;
	assume ZeroMask == SecMask;
	assume ZeroCredits == Credits;
	assert { :msg "  29.3: Location might not be writable" } CanWrite(Mask_$_1,this,AVLTree.root);
	assume Heap_$_0 == Heap[this,AVLTree.root := null];
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	assert { :msg "  30.3: Location might not be writable" } CanWrite(Mask_$_1,this,AVLTree.keys);
	assume Heap_$_1 == Heap_$_0[this,AVLTree.keys := (Seq#Empty() : Seq (Integer) )];
	assume wf(Heap_$_1,Mask_$_1,ZeroMask);
	assume #AVLTree.valid#trigger(this);
	assume ((0 < foldK#_15) && ((1000 * foldK#_15) < Fractions(1))) && ((1000 * foldK#_15) < methodK#_11);
	assert { :msg "  31.3: The target of the fold statement might be null." } !(this == null);
	if ($_$_condition) { goto anon43_Then; } else { goto anon43_Else; }
anon43_Then:
	assume $_$_condition;
	assume $_$_condition <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true." } Seq#Equal(Heap_$_1[this,AVLTree.keys],Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys]);
	goto $branchMerge_0;
anon43_Else:
	assume !$_$_condition;
	assume $_$_condition <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume Heap_$_1[this,AVLTree.root] == null;
	goto $branchMerge_0;
anon44_Then:
	assume $_$_condition_$0;
	assume $_$_condition_$0 <==> (Heap_$_1[this,AVLTree.root] == null);
	assume Heap_$_1[this,AVLTree.root] == null;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 17.22 might not evaluate to true." } Seq#Equal(Heap_$_1[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon4;
anon44_Else:
	assume !$_$_condition_$0;
	assume $_$_condition_$0 <==> (Heap_$_1[this,AVLTree.root] == null);
	assume !(Heap_$_1[this,AVLTree.root] == null);
	goto anon4;
anon4:
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 10.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 10.6 for AVLTree.root." } (Fractions(100) <= Mask_$_1[this,AVLTree.root][perm$R]) && ((Fractions(100) == Mask_$_1[this,AVLTree.root][perm$R]) ==> (0 <= Mask_$_1[this,AVLTree.root][perm$N]));
	assume exhaleMask#_17_$_0 == Mask_$_1[this,AVLTree.root := Mask_$_1[this,AVLTree.root][perm$R := Mask_$_1[this,AVLTree.root][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_0 == ZeroMask[this,AVLTree.root := ZeroMask[this,AVLTree.root][perm$R := ZeroMask[this,AVLTree.root][perm$R] + Fractions(100)]];
	assume IsGoodMask(exhaleMask#_17_$_0);
	assume wf(Heap_$_1,exhaleMask#_17_$_0,SecMask_$_0);
	assume wf(Heap_$_1,Mask_$_1,SecMask_$_0);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 11.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 11.6 for AVLTree.keys." } (Fractions(50) <= exhaleMask#_17_$_0[this,AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_17_$_0[this,AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_17_$_0[this,AVLTree.keys][perm$N]));
	assume exhaleMask#_17_$_1 == exhaleMask#_17_$_0[this,AVLTree.keys := exhaleMask#_17_$_0[this,AVLTree.keys][perm$R := exhaleMask#_17_$_0[this,AVLTree.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_1 == SecMask_$_0[this,AVLTree.keys := SecMask_$_0[this,AVLTree.keys][perm$R := SecMask_$_0[this,AVLTree.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_17_$_1);
	assume wf(Heap_$_1,exhaleMask#_17_$_1,SecMask_$_1);
	assume wf(Heap_$_1,Mask_$_1,SecMask_$_1);
	if ($_$_condition_$2) { goto anon45_Then; } else { goto anon45_Else; }
anon45_Then:
	assume $_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 12.22 might not be positive." } Fractions(100) > 0;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_17_$_2 == exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid := exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R := exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_2 == SecMask_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$3) { goto anon46_Then; } else { goto anon46_Else; }
anon45_Else:
	assume !$_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume Heap_$_1[this,AVLTree.root] == null;
	assume SecMask_$_3 == SecMask_$_1;
	assume exhaleMask#_17_$_3 == exhaleMask#_17_$_1;
	goto $branchMerge_1;
anon46_Then:
	assume $_$_condition_$3;
	assume $_$_condition_$3 <==> (!CanRead(exhaleMask#_17_$_2,SecMask_$_2,Heap_$_1[this,AVLTree.root],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_17_$_2,SecMask_$_2,Heap_$_1[this,AVLTree.root],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid] < exhaleHeap#_16_$_0[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid];
	goto anon7;
anon46_Else:
	assume !$_$_condition_$3;
	assume $_$_condition_$3 <==> (!CanRead(exhaleMask#_17_$_2,SecMask_$_2,Heap_$_1[this,AVLTree.root],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_17_$_2,SecMask_$_2,Heap_$_1[this,AVLTree.root],AVLTreeNode.valid);
	goto anon7;
anon47_Then:
	assume $_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 13.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 13.22 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_17_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_17_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_17_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_17_$_4 == exhaleMask#_17_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height := exhaleMask#_17_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R := exhaleMask#_17_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_4 == SecMask_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height := SecMask_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R := SecMask_$_3[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_17_$_4);
	assume wf(Heap_$_1,exhaleMask#_17_$_4,SecMask_$_4);
	assume wf(Heap_$_1,Mask_$_1,SecMask_$_4);
	assume exhaleMask#_17_$_5 == exhaleMask#_17_$_4;
	assume SecMask_$_5 == SecMask_$_4;
	goto $branchMerge_2;
anon47_Else:
	assume !$_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume Heap_$_1[this,AVLTree.root] == null;
	assume exhaleMask#_17_$_5 == exhaleMask#_17_$_3;
	assume SecMask_$_5 == SecMask_$_3;
	goto $branchMerge_2;
anon7:
	assume IsGoodMask(exhaleMask#_17_$_2);
	assume wf(Heap_$_1,exhaleMask#_17_$_2,SecMask_$_2);
	assume wf(Heap_$_1,Mask_$_1,SecMask_$_2);
	assume SecMask_$_3 == SecMask_$_2;
	assume exhaleMask#_17_$_3 == exhaleMask#_17_$_2;
	goto $branchMerge_1;
anon48_Then:
	assume $_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 14.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 14.22 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_17_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_17_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_17_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_17_$_6 == exhaleMask#_17_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys := exhaleMask#_17_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R := exhaleMask#_17_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_6 == SecMask_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R := SecMask_$_5[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_17_$_6);
	assume wf(Heap_$_1,exhaleMask#_17_$_6,SecMask_$_6);
	assume wf(Heap_$_1,Mask_$_1,SecMask_$_6);
	assume SecMask_$_7 == SecMask_$_6;
	assume exhaleMask#_17_$_7 == exhaleMask#_17_$_6;
	goto $branchMerge_3;
anon48_Else:
	assume !$_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume Heap_$_1[this,AVLTree.root] == null;
	assume SecMask_$_7 == SecMask_$_5;
	assume exhaleMask#_17_$_7 == exhaleMask#_17_$_5;
	goto $branchMerge_3;
anon49_Then:
	assume $_$_condition_$8;
	assume $_$_condition_$8 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 15.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 15.22 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_17_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_17_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_17_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_17_$_8 == exhaleMask#_17_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor := exhaleMask#_17_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_17_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_8 == SecMask_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := SecMask_$_7[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_17_$_8);
	assume wf(Heap_$_1,exhaleMask#_17_$_8,SecMask_$_8);
	assume wf(Heap_$_1,Mask_$_1,SecMask_$_8);
	assume exhaleMask#_17_$_9 == exhaleMask#_17_$_8;
	assume SecMask_$_9 == SecMask_$_8;
	goto anon14;
anon49_Else:
	assume !$_$_condition_$8;
	assume $_$_condition_$8 <==> (!(Heap_$_1[this,AVLTree.root] == null));
	assume Heap_$_1[this,AVLTree.root] == null;
	assume exhaleMask#_17_$_9 == exhaleMask#_17_$_7;
	assume SecMask_$_9 == SecMask_$_7;
	goto anon14;
anon14:
	assume IsGoodExhaleState(exhaleHeap#_16_$_0,Heap_$_1,exhaleMask#_17_$_9,SecMask_$_9);
	assume IsGoodMask(exhaleMask#_17_$_9);
	assume wf(exhaleHeap#_16_$_0,exhaleMask#_17_$_9,SecMask_$_9);
	assume !(this == null);
	assume wf(exhaleHeap#_16_$_0,exhaleMask#_17_$_9,SecMask_$_9);
	assume Fractions(100) > 0;
	assume Mask_$_2 == exhaleMask#_17_$_9[this,AVLTree.valid := exhaleMask#_17_$_9[this,AVLTree.valid][perm$R := exhaleMask#_17_$_9[this,AVLTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_2);
	assume IsGoodState(heapFragment(exhaleHeap#_16_$_0[this,AVLTree.valid]));
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_9);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_9);
	assume IsGoodMask(Mask_$_2);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_9);
	assume predVer#_13_$_0 == exhaleHeap#_16_$_0[this,AVLTree.valid];
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_9);
	assert { :msg "  21.2: The postcondition at 27.11 might not hold. The expression at 27.11 might not evaluate to true." } Seq#Equal(exhaleHeap#_16_$_0[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	assert { :msg "  21.2: The postcondition at 25.11 might not hold. The permission at 25.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  21.2: The postcondition at 25.11 might not hold. Insufficient fraction at 25.11 for AVLTree.valid." } (Fractions(100) <= Mask_$_2[this,AVLTree.valid][perm$R]) && ((Fractions(100) == Mask_$_2[this,AVLTree.valid][perm$R]) ==> (0 <= Mask_$_2[this,AVLTree.valid][perm$N]));
	assume exhaleMask#_25_$_0 == Mask_$_2[this,AVLTree.valid := Mask_$_2[this,AVLTree.valid][perm$R := Mask_$_2[this,AVLTree.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$10) { goto anon50_Then; } else { goto anon50_Else; }
anon50_Then:
	assume $_$_condition_$10;
	assume $_$_condition_$10 <==> (false || ((((predVer#_13_$_0 == exhaleHeap#_16_$_0[this,AVLTree.valid]) && (this == this)) && true) && true));
	assume false || ((((predVer#_13_$_0 == exhaleHeap#_16_$_0[this,AVLTree.valid]) && (this == this)) && true) && true);
	if ($_$_condition_$11) { goto anon51_Then; } else { goto anon51_Else; }
anon50_Else:
	assume !$_$_condition_$10;
	assume $_$_condition_$10 <==> (false || ((((predVer#_13_$_0 == exhaleHeap#_16_$_0[this,AVLTree.valid]) && (this == this)) && true) && true));
	assume !(false || ((((predVer#_13_$_0 == exhaleHeap#_16_$_0[this,AVLTree.valid]) && (this == this)) && true) && true));
	assume SecMask_$_32 == SecMask_$_9;
	goto $branchMerge_4;
anon51_Then:
	assume $_$_condition_$11;
	assume $_$_condition_$11 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume Seq#Equal(exhaleHeap#_16_$_0[this,AVLTree.keys],exhaleHeap#_16_$_0[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys]);
	goto $branchMerge_5;
anon51_Else:
	assume !$_$_condition_$11;
	assume $_$_condition_$11 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	goto $branchMerge_5;
anon63_Then:
	assume $_$_condition_$12;
	assume $_$_condition_$12 <==> (!CanRead(exhaleMask#_25_$_0,SecMask_$_32,this,AVLTree.valid));
	assume !CanRead(exhaleMask#_25_$_0,SecMask_$_32,this,AVLTree.valid);
	assume exhaleHeap#_16_$_0[this,AVLTree.valid] < exhaleHeap#_24_$_0[this,AVLTree.valid];
	goto anon42;
anon63_Else:
	assume !$_$_condition_$12;
	assume $_$_condition_$12 <==> (!CanRead(exhaleMask#_25_$_0,SecMask_$_32,this,AVLTree.valid));
	assume CanRead(exhaleMask#_25_$_0,SecMask_$_32,this,AVLTree.valid);
	goto anon42;
anon52_Then:
	assume $_$_condition_$13;
	assume $_$_condition_$13 <==> (exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume Seq#Equal(exhaleHeap#_16_$_0[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon19;
anon52_Else:
	assume !$_$_condition_$13;
	assume $_$_condition_$13 <==> (exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	goto anon19;
anon19:
	assume SecMask_$_10 == SecMask_$_9[this,AVLTree.root := SecMask_$_9[this,AVLTree.root][perm$R := SecMask_$_9[this,AVLTree.root][perm$R] - Fractions(100)]];
	if ($_$_condition_$15) { goto anon53_Then; } else { goto anon53_Else; }
anon53_Then:
	assume $_$_condition_$15;
	assume SecMask_$_10[this,AVLTree.root][perm$R] < 0;
	assume SecMask_$_11 == SecMask_$_10[this,AVLTree.root := SecMask_$_10[this,AVLTree.root][perm$R := 0]];
	assume SecMask_$_12 == SecMask_$_11;
	goto anon21;
anon53_Else:
	assume !$_$_condition_$15;
	assume 0 <= SecMask_$_10[this,AVLTree.root][perm$R];
	assume SecMask_$_12 == SecMask_$_10;
	goto anon21;
anon21:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_12,SecMask_$_12);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_12);
	assume SecMask_$_13 == SecMask_$_12[this,AVLTree.keys := SecMask_$_12[this,AVLTree.keys][perm$R := SecMask_$_12[this,AVLTree.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$16) { goto anon54_Then; } else { goto anon54_Else; }
anon54_Then:
	assume $_$_condition_$16;
	assume SecMask_$_13[this,AVLTree.keys][perm$R] < 0;
	assume SecMask_$_14 == SecMask_$_13[this,AVLTree.keys := SecMask_$_13[this,AVLTree.keys][perm$R := 0]];
	assume SecMask_$_15 == SecMask_$_14;
	goto anon23;
anon54_Else:
	assume !$_$_condition_$16;
	assume 0 <= SecMask_$_13[this,AVLTree.keys][perm$R];
	assume SecMask_$_15 == SecMask_$_13;
	goto anon23;
anon23:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_15,SecMask_$_15);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_15);
	if ($_$_condition_$17) { goto anon55_Then; } else { goto anon55_Else; }
anon55_Then:
	assume $_$_condition_$17;
	assume $_$_condition_$17 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_16 == SecMask_$_15[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_15[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_15[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$18) { goto anon56_Then; } else { goto anon56_Else; }
anon55_Else:
	assume !$_$_condition_$17;
	assume $_$_condition_$17 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_19 == SecMask_$_15;
	goto $branchMerge_6;
anon56_Then:
	assume $_$_condition_$18;
	assume SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_17 == SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_18 == SecMask_$_17;
	goto anon26;
anon56_Else:
	assume !$_$_condition_$18;
	assume 0 <= SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R];
	assume SecMask_$_18 == SecMask_$_16;
	goto anon26;
anon57_Then:
	assume $_$_condition_$19;
	assume $_$_condition_$19 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_20 == SecMask_$_19[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_19[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := SecMask_$_19[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$21) { goto anon58_Then; } else { goto anon58_Else; }
anon57_Else:
	assume !$_$_condition_$19;
	assume $_$_condition_$19 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_23 == SecMask_$_19;
	goto $branchMerge_7;
anon26:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_18,SecMask_$_18);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_18);
	assume SecMask_$_19 == SecMask_$_18;
	goto $branchMerge_6;
anon58_Then:
	assume $_$_condition_$21;
	assume SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_21 == SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_22 == SecMask_$_21;
	goto anon30;
anon58_Else:
	assume !$_$_condition_$21;
	assume 0 <= SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R];
	assume SecMask_$_22 == SecMask_$_20;
	goto anon30;
anon59_Then:
	assume $_$_condition_$22;
	assume $_$_condition_$22 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_24 == SecMask_$_23[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_23[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := SecMask_$_23[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$24) { goto anon60_Then; } else { goto anon60_Else; }
anon59_Else:
	assume !$_$_condition_$22;
	assume $_$_condition_$22 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_27 == SecMask_$_23;
	goto $branchMerge_8;
anon30:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_22,SecMask_$_22);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_22);
	assume SecMask_$_23 == SecMask_$_22;
	goto $branchMerge_7;
anon60_Then:
	assume $_$_condition_$24;
	assume SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_25 == SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_26 == SecMask_$_25;
	goto anon34;
anon60_Else:
	assume !$_$_condition_$24;
	assume 0 <= SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R];
	assume SecMask_$_26 == SecMask_$_24;
	goto anon34;
anon61_Then:
	assume $_$_condition_$25;
	assume $_$_condition_$25 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_28 == SecMask_$_27[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_27[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := SecMask_$_27[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$27) { goto anon62_Then; } else { goto anon62_Else; }
anon61_Else:
	assume !$_$_condition_$25;
	assume $_$_condition_$25 <==> (!(exhaleHeap#_16_$_0[this,AVLTree.root] == null));
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_31 == SecMask_$_27;
	goto anon39;
anon34:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_26,SecMask_$_26);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_26);
	assume SecMask_$_27 == SecMask_$_26;
	goto $branchMerge_8;
anon62_Then:
	assume $_$_condition_$27;
	assume SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon38;
anon62_Else:
	assume !$_$_condition_$27;
	assume 0 <= SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon38;
anon39:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_31,SecMask_$_31);
	assume SecMask_$_32 == SecMask_$_31;
	goto $branchMerge_4;
anon38:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_30,SecMask_$_30);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30;
	goto anon39;
anon42:
	assume IsGoodMask(exhaleMask#_25_$_0);
	assume wf(exhaleHeap#_16_$_0,exhaleMask#_25_$_0,SecMask_$_32);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_32);
	assert { :msg "  21.2: The postcondition at 26.11 might not hold. The permission at 26.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  21.2: The postcondition at 26.11 might not hold. Insufficient fraction at 26.11 for AVLTree.keys." } (Fractions(50) <= exhaleMask#_25_$_0[this,AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_25_$_0[this,AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_25_$_0[this,AVLTree.keys][perm$N]));
	assume exhaleMask#_25_$_1 == exhaleMask#_25_$_0[this,AVLTree.keys := exhaleMask#_25_$_0[this,AVLTree.keys][perm$R := exhaleMask#_25_$_0[this,AVLTree.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_25_$_1);
	assume wf(exhaleHeap#_16_$_0,exhaleMask#_25_$_1,SecMask_$_32);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_32);
	assume IsGoodExhaleState(exhaleHeap#_24_$_0,exhaleHeap#_16_$_0,exhaleMask#_25_$_1,SecMask_$_32);
	assume IsGoodMask(exhaleMask#_25_$_1);
	assume wf(exhaleHeap#_24_$_0,exhaleMask#_25_$_1,SecMask_$_32);
	assert { :msg "  21.2: Method might lock/unlock more than allowed." } (forall  lk#_36 : ref :: {exhaleHeap#_24_$_0[lk#_36,held]} {exhaleHeap#_24_$_0[lk#_36,rdheld]} ( (((0 < exhaleHeap#_24_$_0[lk#_36,held]) <==> (0 < Heap[lk#_36,held])) && (exhaleHeap#_24_$_0[lk#_36,rdheld] <==> Heap[lk#_36,rdheld])) || false ));
	assert { :msg "  21.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
$branchMerge_0:
	if ($_$_condition_$0) { goto anon44_Then; } else { goto anon44_Else; }
$branchMerge_1:
	if ($_$_condition_$4) { goto anon47_Then; } else { goto anon47_Else; }
$branchMerge_2:
	if ($_$_condition_$6) { goto anon48_Then; } else { goto anon48_Else; }
$branchMerge_3:
	if ($_$_condition_$8) { goto anon49_Then; } else { goto anon49_Else; }
$branchMerge_4:
	if ($_$_condition_$12) { goto anon63_Then; } else { goto anon63_Else; }
$branchMerge_5:
	if ($_$_condition_$13) { goto anon52_Then; } else { goto anon52_Else; }
$branchMerge_6:
	if ($_$_condition_$19) { goto anon57_Then; } else { goto anon57_Else; }
$branchMerge_7:
	if ($_$_condition_$22) { goto anon59_Then; } else { goto anon59_Else; }
$branchMerge_8:
	if ($_$_condition_$25) { goto anon61_Then; } else { goto anon61_Else; }
}
