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
procedure AVLTreeNode.rebalanceLL (this : ref) returns (r#72 : ref)
{
	var methodK#_3257 : int;
	var unfoldK#_3258 : int;
	var methodCallK#_3284 : int;
	var this#939 : ref;
	var methodCallK#_3307 : int;
	var this#944 : ref;
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
	var oldVers#_3278_$_0 : int;
	var newVers#_3279_$_0 : int;
	var Heap_$_0 : HeapType;
	var Heap_$_1 : HeapType;
	var Mask_$_19 : MaskType;
	var Mask_$_20 : MaskType;
	var Mask_$_21 : MaskType;
	var Mask_$_22 : MaskType;
	var Mask_$_23 : MaskType;
	var Mask_$_24 : MaskType;
	var Mask_$_25 : MaskType;
	var Mask_$_26 : MaskType;
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
	var Mask_$_39 : MaskType;
	var Mask_$_40 : MaskType;
	var r#72_$_0 : ref;
	var Heap_$_2 : HeapType;
	var exhaleHeap#_3285_$_0 : HeapType;
	var exhaleMask#_3286_$_0 : MaskType;
	var exhaleMask#_3286_$_1 : MaskType;
	var exhaleMask#_3286_$_2 : MaskType;
	var exhaleMask#_3286_$_3 : MaskType;
	var exhaleMask#_3286_$_4 : MaskType;
	var exhaleMask#_3286_$_5 : MaskType;
	var exhaleMask#_3286_$_6 : MaskType;
	var exhaleMask#_3286_$_7 : MaskType;
	var exhaleMask#_3286_$_8 : MaskType;
	var exhaleMask#_3286_$_9 : MaskType;
	var exhaleMask#_3286_$_10 : MaskType;
	var exhaleMask#_3286_$_11 : MaskType;
	var exhaleMask#_3286_$_12 : MaskType;
	var exhaleMask#_3286_$_13 : MaskType;
	var exhaleMask#_3286_$_14 : MaskType;
	var exhaleMask#_3286_$_15 : MaskType;
	var exhaleMask#_3286_$_16 : MaskType;
	var exhaleMask#_3286_$_17 : MaskType;
	var exhaleMask#_3286_$_18 : MaskType;
	var exhaleMask#_3286_$_19 : MaskType;
	var exhaleMask#_3286_$_20 : MaskType;
	var exhaleMask#_3286_$_21 : MaskType;
	var Mask_$_41 : MaskType;
	var Mask_$_42 : MaskType;
	var Mask_$_43 : MaskType;
	var Mask_$_44 : MaskType;
	var Heap_$_3 : HeapType;
	var exhaleHeap#_3308_$_0 : HeapType;
	var exhaleMask#_3309_$_0 : MaskType;
	var exhaleMask#_3309_$_1 : MaskType;
	var exhaleMask#_3309_$_2 : MaskType;
	var exhaleMask#_3309_$_3 : MaskType;
	var exhaleMask#_3309_$_4 : MaskType;
	var exhaleMask#_3309_$_5 : MaskType;
	var exhaleMask#_3309_$_6 : MaskType;
	var exhaleMask#_3309_$_7 : MaskType;
	var exhaleMask#_3309_$_8 : MaskType;
	var exhaleMask#_3309_$_9 : MaskType;
	var exhaleMask#_3309_$_10 : MaskType;
	var exhaleMask#_3309_$_11 : MaskType;
	var exhaleMask#_3309_$_12 : MaskType;
	var exhaleMask#_3309_$_13 : MaskType;
	var exhaleMask#_3309_$_14 : MaskType;
	var exhaleMask#_3309_$_15 : MaskType;
	var exhaleMask#_3309_$_16 : MaskType;
	var exhaleMask#_3309_$_17 : MaskType;
	var exhaleMask#_3309_$_18 : MaskType;
	var exhaleMask#_3309_$_19 : MaskType;
	var exhaleMask#_3309_$_20 : MaskType;
	var exhaleMask#_3309_$_21 : MaskType;
	var Mask_$_45 : MaskType;
	var Mask_$_46 : MaskType;
	var Mask_$_47 : MaskType;
	var Mask_$_48 : MaskType;
	var exhaleHeap#_3326_$_0 : HeapType;
	var exhaleMask#_3327_$_0 : MaskType;
	var exhaleMask#_3327_$_1 : MaskType;
	var exhaleMask#_3327_$_2 : MaskType;
	var exhaleMask#_3327_$_3 : MaskType;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$9 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$11 : bool;
	var $_$_condition_$13 : bool;
	var $_$_condition_$15 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$23 : bool;
	var $_$_condition_$25 : bool;
	var $_$_condition_$27 : bool;
	var $_$_condition_$29 : bool;
	var $_$_condition_$31 : bool;
	var $_$_condition_$33 : bool;
	var $_$_condition_$34 : bool;
	var $_$_condition_$36 : bool;
	var $_$_condition_$37 : bool;
	var $_$_condition_$38 : bool;
	var $_$_condition_$40 : bool;
	var $_$_condition_$42 : bool;
	var $_$_condition_$44 : bool;
	var $_$_condition_$46 : bool;
	var $_$_condition_$47 : bool;
	var $_$_condition_$49 : bool;
	var $_$_condition_$51 : bool;
	var $_$_condition_$53 : bool;
	var $_$_condition_$54 : bool;
	var $_$_condition_$56 : bool;
	var $_$_condition_$57 : bool;
	var $_$_condition_$58 : bool;
	var $_$_condition_$60 : bool;
	var $_$_condition_$62 : bool;
	var $_$_condition_$64 : bool;
	var $_$_condition_$66 : bool;
	var $_$_condition_$67 : bool;
	var $_$_condition_$69 : bool;
	var $_$_condition_$71 : bool;
	var $_$_condition_$73 : bool;
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
	assume (r#72 == null) || (dtype(r#72) == AVLTreeNode#t);
	assume (this#939 == null) || (dtype(this#939) == AVLTreeNode#t);
	assume (this#944 == null) || (dtype(this#944) == AVLTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_3257) && ((1000 * methodK#_3257) < Fractions(1));
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
	if ($_$_condition) { goto anon141_Then; } else { goto anon141_Else; }
anon141_Then:
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
anon141_Else:
	assume !$_$_condition;
	assume $_$_condition <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_7 == Mask_$_5;
	goto $branchMerge_0;
anon142_Then:
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
anon142_Else:
	assume !$_$_condition_$0;
	assume $_$_condition_$0 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_9 == Mask_$_7;
	goto $branchMerge_1;
anon143_Then:
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
anon143_Else:
	assume !$_$_condition_$2;
	assume $_$_condition_$2 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_11 == Mask_$_9;
	goto $branchMerge_2;
anon144_Then:
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
anon144_Else:
	assume !$_$_condition_$4;
	assume $_$_condition_$4 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_13 == Mask_$_11;
	goto $branchMerge_3;
anon145_Then:
	assume $_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume (forall  k#112#931 : Integer :: ( ((0 <= k#112#931) && (k#112#931 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],k#112#931) < Heap[this,AVLTreeNode.key]) ));
	goto anon10;
anon145_Else:
	assume !$_$_condition_$6;
	assume $_$_condition_$6 <==> (!(Heap[this,AVLTreeNode.left] == null));
	assume Heap[this,AVLTreeNode.left] == null;
	goto anon10;
anon10:
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_13,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_14 == Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_13[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_14);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap,Mask_$_14,ZeroMask);
	assume wf(Heap,Mask_$_14,ZeroMask);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_14,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_15 == Mask_$_14[Heap[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_14[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_14[Heap[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_15);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap,Mask_$_15,ZeroMask);
	assume wf(Heap,Mask_$_15,ZeroMask);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_15,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_16 == Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.keys := Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_15[Heap[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_16);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap,Mask_$_16,ZeroMask);
	assume wf(Heap,Mask_$_16,ZeroMask);
	assume !(Heap[this,AVLTreeNode.right] == null);
	assume wf(Heap,Mask_$_16,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_17 == Mask_$_16[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_16[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_16[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap,Mask_$_17,ZeroMask);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assume (forall  k#113#932 : Integer :: ( ((0 <= k#113#932) && (k#113#932 < Seq#Length(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap[this,AVLTreeNode.key] < Seq#Index(Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys],k#113#932)) ));
	assume (ite(Heap[this,AVLTreeNode.left] == null,0,Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.height]) - Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]) == (0 - 2);
	assume Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 0;
	assume IsGoodMask(Mask_$_17);
	assume wf(Heap,Mask_$_17,ZeroMask);
	assume Heap == Heap;
	assume Mask_$_17 == Mask;
	assume ZeroMask == SecMask;
	assume ZeroCredits == Credits;
	assume #AVLTreeNode.valid#trigger(Heap[this,AVLTreeNode.right]);
	assume ((0 < unfoldK#_3258) && (unfoldK#_3258 < Fractions(1))) && ((1000 * unfoldK#_3258) < methodK#_3257);
	assert { :msg "  879.10: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  879.10: Location might not be readable." } true ==> CanRead(Mask_$_17,ZeroMask,this,AVLTreeNode.right);
	assert { :msg "  879.3: The target of the fold statement might be null." } !(Heap[this,AVLTreeNode.right] == null);
	assert { :msg "  879.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  879.3: unfold might fail because the predicate AVLTreeNode.valid does not hold. Insufficient fraction at <undefined position> for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume Mask_$_18 == Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_17[Heap[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$8) { goto anon146_Then; } else { goto anon146_Else; }
anon146_Then:
	assume $_$_condition_$8;
	assume $_$_condition_$8 <==> false;
	assume false;
	goto $exit;
anon146_Else:
	assume !$_$_condition_$8;
	assume $_$_condition_$8 <==> false;
	assume !false;
	if ($_$_condition_$9) { goto anon173_Then; } else { goto anon173_Else; }
anon173_Then:
	assume $_$_condition_$9;
	assume $_$_condition_$9 <==> (!CanRead(Mask_$_18,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(Mask_$_18,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume oldVers#_3278_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume Heap_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := newVers#_3279_$_0];
	assume oldVers#_3278_$_0 < Heap_$_0[Heap_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon66;
anon173_Else:
	assume !$_$_condition_$9;
	assume $_$_condition_$9 <==> (!CanRead(Mask_$_18,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(Mask_$_18,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_1 == Heap;
	goto anon66;
anon66:
	assume IsGoodMask(Mask_$_18);
	assume wf(Heap_$_1,Mask_$_18,ZeroMask);
	assume IsGoodMask(Mask_$_18);
	assume wf(Heap_$_1,Mask_$_18,ZeroMask);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_18,ZeroMask);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_19 == Mask_$_18[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key := Mask_$_18[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R := Mask_$_18[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key]));
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_20 == Mask_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height := Mask_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_19[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_20);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_20,ZeroMask);
	assume wf(Heap_$_1,Mask_$_20,ZeroMask);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_20,ZeroMask);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_21 == Mask_$_20[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left := Mask_$_20[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R := Mask_$_20[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left]));
	assume wf(Heap_$_1,Mask_$_21,ZeroMask);
	assume wf(Heap_$_1,Mask_$_21,ZeroMask);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_21,ZeroMask);
	assume (Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null) || (dtype(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_22 == Mask_$_21[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right := Mask_$_21[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R := Mask_$_21[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_22);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right]));
	assume wf(Heap_$_1,Mask_$_22,ZeroMask);
	assume wf(Heap_$_1,Mask_$_22,ZeroMask);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_22,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_23 == Mask_$_22[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys := Mask_$_22[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_22[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_23);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_23,ZeroMask);
	assume wf(Heap_$_1,Mask_$_23,ZeroMask);
	assume !(Heap_$_1[this,AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_23,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_24 == Mask_$_23[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_23[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_23[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_24);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_24,ZeroMask);
	assume wf(Heap_$_1,Mask_$_24,ZeroMask);
	if ($_$_condition_$10) { goto anon174_Then; } else { goto anon174_Else; }
anon174_Then:
	assume $_$_condition_$10;
	assume $_$_condition_$10 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_24,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_25 == Mask_$_24[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid := Mask_$_24[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R := Mask_$_24[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_25);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_25,ZeroMask);
	assume wf(Heap_$_1,Mask_$_25,ZeroMask);
	assume Mask_$_26 == Mask_$_25;
	goto $branchMerge_4;
anon174_Else:
	assume !$_$_condition_$10;
	assume $_$_condition_$10 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_26 == Mask_$_24;
	goto $branchMerge_4;
anon175_Then:
	assume $_$_condition_$11;
	assume $_$_condition_$11 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_26,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_27 == Mask_$_26[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height := Mask_$_26[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R := Mask_$_26[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_27);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_27,ZeroMask);
	assume wf(Heap_$_1,Mask_$_27,ZeroMask);
	assume Mask_$_28 == Mask_$_27;
	goto $branchMerge_5;
anon175_Else:
	assume !$_$_condition_$11;
	assume $_$_condition_$11 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_28 == Mask_$_26;
	goto $branchMerge_5;
anon176_Then:
	assume $_$_condition_$13;
	assume $_$_condition_$13 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_28,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_29 == Mask_$_28[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys := Mask_$_28[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R := Mask_$_28[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_29);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_29,ZeroMask);
	assume wf(Heap_$_1,Mask_$_29,ZeroMask);
	assume Mask_$_30 == Mask_$_29;
	goto $branchMerge_6;
anon176_Else:
	assume !$_$_condition_$13;
	assume $_$_condition_$13 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_30 == Mask_$_28;
	goto $branchMerge_6;
anon177_Then:
	assume $_$_condition_$15;
	assume $_$_condition_$15 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume wf(Heap_$_1,Mask_$_30,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_31 == Mask_$_30[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor := Mask_$_30[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := Mask_$_30[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_31);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_31,ZeroMask);
	assume wf(Heap_$_1,Mask_$_31,ZeroMask);
	assume Mask_$_32 == Mask_$_31;
	goto $branchMerge_7;
anon177_Else:
	assume !$_$_condition_$15;
	assume $_$_condition_$15 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_32 == Mask_$_30;
	goto $branchMerge_7;
anon178_Then:
	assume $_$_condition_$17;
	assume $_$_condition_$17 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#937 : Integer :: ( ((0 <= lk#79#937) && (lk#79#937 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#937) < Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	goto $branchMerge_8;
anon178_Else:
	assume !$_$_condition_$17;
	assume $_$_condition_$17 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_8;
anon179_Then:
	assume $_$_condition_$19;
	assume $_$_condition_$19 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	goto $branchMerge_9;
anon179_Else:
	assume !$_$_condition_$19;
	assume $_$_condition_$19 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	goto $branchMerge_9;
anon180_Then:
	assume $_$_condition_$21;
	assume $_$_condition_$21 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_32,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_33 == Mask_$_32[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid := Mask_$_32[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R := Mask_$_32[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_33);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assume wf(Heap_$_1,Mask_$_33,ZeroMask);
	assume Mask_$_34 == Mask_$_33;
	goto $branchMerge_10;
anon180_Else:
	assume !$_$_condition_$21;
	assume $_$_condition_$21 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_34 == Mask_$_32;
	goto $branchMerge_10;
anon181_Then:
	assume $_$_condition_$23;
	assume $_$_condition_$23 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_34,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_35 == Mask_$_34[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height := Mask_$_34[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R := Mask_$_34[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_35);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_35,ZeroMask);
	assume wf(Heap_$_1,Mask_$_35,ZeroMask);
	assume Mask_$_36 == Mask_$_35;
	goto $branchMerge_11;
anon181_Else:
	assume !$_$_condition_$23;
	assume $_$_condition_$23 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_36 == Mask_$_34;
	goto $branchMerge_11;
anon182_Then:
	assume $_$_condition_$25;
	assume $_$_condition_$25 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_36,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_37 == Mask_$_36[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys := Mask_$_36[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R := Mask_$_36[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_37);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_37,ZeroMask);
	assume wf(Heap_$_1,Mask_$_37,ZeroMask);
	assume Mask_$_38 == Mask_$_37;
	goto $branchMerge_12;
anon182_Else:
	assume !$_$_condition_$25;
	assume $_$_condition_$25 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_38 == Mask_$_36;
	goto $branchMerge_12;
anon183_Then:
	assume $_$_condition_$27;
	assume $_$_condition_$27 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume wf(Heap_$_1,Mask_$_38,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_39 == Mask_$_38[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor := Mask_$_38[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := Mask_$_38[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_39);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_39,ZeroMask);
	assume wf(Heap_$_1,Mask_$_39,ZeroMask);
	assume Mask_$_40 == Mask_$_39;
	goto $branchMerge_13;
anon183_Else:
	assume !$_$_condition_$27;
	assume $_$_condition_$27 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_40 == Mask_$_38;
	goto $branchMerge_13;
anon184_Then:
	assume $_$_condition_$29;
	assume $_$_condition_$29 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#938 : Integer :: ( ((0 <= rk#80#938) && (rk#80#938 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#938)) ));
	goto $branchMerge_14;
anon184_Else:
	assume !$_$_condition_$29;
	assume $_$_condition_$29 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto $branchMerge_14;
anon185_Then:
	assume $_$_condition_$31;
	assume $_$_condition_$31 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon90;
anon185_Else:
	assume !$_$_condition_$31;
	assume $_$_condition_$31 <==> (!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	goto anon90;
anon90:
	assume Seq#Equal(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key])),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys])));
	assume Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key]);
	assume (forall  kk#81 : Integer :: ( Seq#Contains(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.keys],kk#81) <==> ((((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],kk#81)) || ((!(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null)) && Seq#Contains(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],kk#81))) || (kk#81 == Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key])) ));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height] == ite(ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] == (ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null,0,Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height]));
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] <= 1;
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.balanceFactor] >= (0 - 1);
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.height] > 0;
	assume IsGoodMask(Mask_$_40);
	assume wf(Heap_$_1,Mask_$_40,ZeroMask);
	assert { :msg "  880.14: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  880.14: Location might not be readable." } true ==> CanRead(Mask_$_40,ZeroMask,this,AVLTreeNode.right);
	assume r#72_$_0 == Heap_$_1[this,AVLTreeNode.right];
	assert { :msg "  881.3: Location might not be writable" } CanWrite(Mask_$_40,this,AVLTreeNode.right);
	assert { :msg "  881.15: Receiver might be null." } true ==> (!(r#72_$_0 == null));
	assert { :msg "  881.15: Location might not be readable." } true ==> CanRead(Mask_$_40,ZeroMask,r#72_$_0,AVLTreeNode.left);
	assume Heap_$_2 == Heap_$_1[this,AVLTreeNode.right := Heap_$_1[r#72_$_0,AVLTreeNode.left]];
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume ((0 < methodCallK#_3284) && ((1000 * methodCallK#_3284) < Fractions(1))) && ((1000 * methodCallK#_3284) < methodK#_3257);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assert { :msg "  882.3: The target of the method call might be null." } !(this == null);
	if ($_$_condition_$33) { goto anon186_Then; } else { goto anon186_Else; }
anon186_Then:
	assume $_$_condition_$33;
	assume $_$_condition_$33 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#940 : Integer :: ( ((0 <= k#92#940) && (k#92#940 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#940) < Heap_$_2[this,AVLTreeNode.key]) ));
	goto $branchMerge_15;
anon186_Else:
	assume !$_$_condition_$33;
	assume $_$_condition_$33 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	goto $branchMerge_15;
anon187_Then:
	assume $_$_condition_$34;
	assume $_$_condition_$34 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#941 : Integer :: ( ((0 <= k#93#941) && (k#93#941 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_2[this,AVLTreeNode.key] < Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#941)) ));
	goto anon94;
anon187_Else:
	assume !$_$_condition_$34;
	assume $_$_condition_$34 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	goto anon94;
anon94:
	assert { :msg "  882.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  882.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  882.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_40[this,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_40[this,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_40[this,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_3286_$_0 == Mask_$_40[this,AVLTreeNode.key := Mask_$_40[this,AVLTreeNode.key][perm$R := Mask_$_40[this,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3286_$_0);
	assume wf(Heap_$_2,exhaleMask#_3286_$_0,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assert { :msg "  882.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_3286_$_0[this,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_0[this,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3286_$_0[this,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3286_$_1 == exhaleMask#_3286_$_0[this,AVLTreeNode.height := exhaleMask#_3286_$_0[this,AVLTreeNode.height][perm$R := exhaleMask#_3286_$_0[this,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3286_$_1);
	assume wf(Heap_$_2,exhaleMask#_3286_$_1,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assert { :msg "  882.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_3286_$_1[this,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_1[this,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_3286_$_1[this,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_3286_$_2 == exhaleMask#_3286_$_1[this,AVLTreeNode.left := exhaleMask#_3286_$_1[this,AVLTreeNode.left][perm$R := exhaleMask#_3286_$_1[this,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3286_$_2);
	assume wf(Heap_$_2,exhaleMask#_3286_$_2,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assert { :msg "  882.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_3286_$_2[this,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_2[this,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_3286_$_2[this,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_3286_$_3 == exhaleMask#_3286_$_2[this,AVLTreeNode.right := exhaleMask#_3286_$_2[this,AVLTreeNode.right][perm$R := exhaleMask#_3286_$_2[this,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3286_$_3);
	assume wf(Heap_$_2,exhaleMask#_3286_$_3,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assert { :msg "  882.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_3286_$_3[this,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_3[this,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3286_$_3[this,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3286_$_4 == exhaleMask#_3286_$_3[this,AVLTreeNode.keys := exhaleMask#_3286_$_3[this,AVLTreeNode.keys][perm$R := exhaleMask#_3286_$_3[this,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3286_$_4);
	assume wf(Heap_$_2,exhaleMask#_3286_$_4,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assert { :msg "  882.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_3286_$_4[this,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_4[this,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3286_$_4[this,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3286_$_5 == exhaleMask#_3286_$_4[this,AVLTreeNode.balanceFactor := exhaleMask#_3286_$_4[this,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3286_$_4[this,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3286_$_5);
	assume wf(Heap_$_2,exhaleMask#_3286_$_5,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	if ($_$_condition_$36) { goto anon188_Then; } else { goto anon188_Else; }
anon188_Then:
	assume $_$_condition_$36;
	assume $_$_condition_$36 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3286_$_6 == exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$37) { goto anon189_Then; } else { goto anon189_Else; }
anon188_Else:
	assume !$_$_condition_$36;
	assume $_$_condition_$36 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_7 == exhaleMask#_3286_$_5;
	goto $branchMerge_16;
anon189_Then:
	assume $_$_condition_$37;
	assume $_$_condition_$37 <==> (!CanRead(exhaleMask#_3286_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_3286_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_3285_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon97;
anon189_Else:
	assume !$_$_condition_$37;
	assume $_$_condition_$37 <==> (!CanRead(exhaleMask#_3286_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_3286_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon97;
anon190_Then:
	assume $_$_condition_$38;
	assume $_$_condition_$38 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3286_$_8 == exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_8);
	assume wf(Heap_$_2,exhaleMask#_3286_$_8,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_9 == exhaleMask#_3286_$_8;
	goto $branchMerge_17;
anon190_Else:
	assume !$_$_condition_$38;
	assume $_$_condition_$38 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_9 == exhaleMask#_3286_$_7;
	goto $branchMerge_17;
anon97:
	assume IsGoodMask(exhaleMask#_3286_$_6);
	assume wf(Heap_$_2,exhaleMask#_3286_$_6,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_7 == exhaleMask#_3286_$_6;
	goto $branchMerge_16;
anon191_Then:
	assume $_$_condition_$40;
	assume $_$_condition_$40 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3286_$_10 == exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_10);
	assume wf(Heap_$_2,exhaleMask#_3286_$_10,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_11 == exhaleMask#_3286_$_10;
	goto $branchMerge_18;
anon191_Else:
	assume !$_$_condition_$40;
	assume $_$_condition_$40 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_11 == exhaleMask#_3286_$_9;
	goto $branchMerge_18;
anon192_Then:
	assume $_$_condition_$42;
	assume $_$_condition_$42 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3286_$_12 == exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_12);
	assume wf(Heap_$_2,exhaleMask#_3286_$_12,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_13 == exhaleMask#_3286_$_12;
	goto $branchMerge_19;
anon192_Else:
	assume !$_$_condition_$42;
	assume $_$_condition_$42 <==> (!(Heap_$_2[this,AVLTreeNode.left] == null));
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_13 == exhaleMask#_3286_$_11;
	goto $branchMerge_19;
anon193_Then:
	assume $_$_condition_$44;
	assume $_$_condition_$44 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3286_$_14 == exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$46) { goto anon194_Then; } else { goto anon194_Else; }
anon193_Else:
	assume !$_$_condition_$44;
	assume $_$_condition_$44 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_3286_$_15 == exhaleMask#_3286_$_13;
	goto $branchMerge_20;
anon194_Then:
	assume $_$_condition_$46;
	assume $_$_condition_$46 <==> (!CanRead(exhaleMask#_3286_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_3286_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_3285_$_0[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon107;
anon194_Else:
	assume !$_$_condition_$46;
	assume $_$_condition_$46 <==> (!CanRead(exhaleMask#_3286_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_3286_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon107;
anon195_Then:
	assume $_$_condition_$47;
	assume $_$_condition_$47 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3286_$_16 == exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_16);
	assume wf(Heap_$_2,exhaleMask#_3286_$_16,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_17 == exhaleMask#_3286_$_16;
	goto $branchMerge_21;
anon195_Else:
	assume !$_$_condition_$47;
	assume $_$_condition_$47 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_3286_$_17 == exhaleMask#_3286_$_15;
	goto $branchMerge_21;
anon107:
	assume IsGoodMask(exhaleMask#_3286_$_14);
	assume wf(Heap_$_2,exhaleMask#_3286_$_14,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_15 == exhaleMask#_3286_$_14;
	goto $branchMerge_20;
anon196_Then:
	assume $_$_condition_$49;
	assume $_$_condition_$49 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3286_$_18 == exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_18);
	assume wf(Heap_$_2,exhaleMask#_3286_$_18,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_19 == exhaleMask#_3286_$_18;
	goto $branchMerge_22;
anon196_Else:
	assume !$_$_condition_$49;
	assume $_$_condition_$49 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_3286_$_19 == exhaleMask#_3286_$_17;
	goto $branchMerge_22;
anon197_Then:
	assume $_$_condition_$51;
	assume $_$_condition_$51 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_3286_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3286_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3286_$_20 == exhaleMask#_3286_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_3286_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3286_$_19[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_20);
	assume wf(Heap_$_2,exhaleMask#_3286_$_20,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_21 == exhaleMask#_3286_$_20;
	goto anon114;
anon197_Else:
	assume !$_$_condition_$51;
	assume $_$_condition_$51 <==> (!(Heap_$_2[this,AVLTreeNode.right] == null));
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_3286_$_21 == exhaleMask#_3286_$_19;
	goto anon114;
anon114:
	assume IsGoodExhaleState(exhaleHeap#_3285_$_0,Heap_$_2,exhaleMask#_3286_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_3286_$_21);
	assume wf(exhaleHeap#_3285_$_0,exhaleMask#_3286_$_21,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_3285_$_0,exhaleMask#_3286_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_41 == exhaleMask#_3286_$_21[this,AVLTreeNode.valid := exhaleMask#_3286_$_21[this,AVLTreeNode.valid][perm$R := exhaleMask#_3286_$_21[this,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_41);
	assume IsGoodState(heapFragment(exhaleHeap#_3285_$_0[this,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_3285_$_0,Mask_$_41,ZeroMask);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_41,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_41,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_42 == Mask_$_41[this,AVLTreeNode.height := Mask_$_41[this,AVLTreeNode.height][perm$R := Mask_$_41[this,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_42);
	assume IsGoodState(heapFragment(exhaleHeap#_3285_$_0[this,AVLTreeNode.height]));
	assume wf(exhaleHeap#_3285_$_0,Mask_$_42,ZeroMask);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_42,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_42,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_43 == Mask_$_42[this,AVLTreeNode.keys := Mask_$_42[this,AVLTreeNode.keys][perm$R := Mask_$_42[this,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_43);
	assume IsGoodState(heapFragment(exhaleHeap#_3285_$_0[this,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_3285_$_0,Mask_$_43,ZeroMask);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_43,ZeroMask);
	assume !(this == null);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_43,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_44 == Mask_$_43[this,AVLTreeNode.balanceFactor := Mask_$_43[this,AVLTreeNode.balanceFactor][perm$R := Mask_$_43[this,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_44);
	assume IsGoodState(heapFragment(exhaleHeap#_3285_$_0[this,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_3285_$_0,Mask_$_44,ZeroMask);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_44,ZeroMask);
	assume Seq#Equal(exhaleHeap#_3285_$_0[this,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_2[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_2[this,AVLTreeNode.key])),ite(Heap_$_2[this,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_3285_$_0[this,AVLTreeNode.height] == ite(ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_3285_$_0[this,AVLTreeNode.balanceFactor] == (ite(Heap_$_2[this,AVLTreeNode.left] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_2[this,AVLTreeNode.right] == null,0,Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_44);
	assume wf(exhaleHeap#_3285_$_0,Mask_$_44,ZeroMask);
	assert { :msg "  883.3: Location might not be writable" } CanWrite(Mask_$_44,r#72_$_0,AVLTreeNode.left);
	assume Heap_$_3 == exhaleHeap#_3285_$_0[r#72_$_0,AVLTreeNode.left := this];
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume ((0 < methodCallK#_3307) && ((1000 * methodCallK#_3307) < Fractions(1))) && ((1000 * methodCallK#_3307) < methodK#_3257);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assert { :msg "  884.3: The target of the method call might be null." } !(r#72_$_0 == null);
	if ($_$_condition_$53) { goto anon198_Then; } else { goto anon198_Else; }
anon198_Then:
	assume $_$_condition_$53;
	assume $_$_condition_$53 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#945 : Integer :: ( ((0 <= k#92#945) && (k#92#945 < Seq#Length(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys],k#92#945) < Heap_$_3[r#72_$_0,AVLTreeNode.key]) ));
	goto $branchMerge_23;
anon198_Else:
	assume !$_$_condition_$53;
	assume $_$_condition_$53 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	goto $branchMerge_23;
anon199_Then:
	assume $_$_condition_$54;
	assume $_$_condition_$54 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#946 : Integer :: ( ((0 <= k#93#946) && (k#93#946 < Seq#Length(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_3[r#72_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#93#946)) ));
	goto anon118;
anon199_Else:
	assume !$_$_condition_$54;
	assume $_$_condition_$54 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	goto anon118;
anon118:
	assert { :msg "  884.3: The precondition at 564.12 might not hold. The expression at 564.12 might not evaluate to true." } (ite(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height])) <= 1;
	assert { :msg "  884.3: The precondition at 565.12 might not hold. The expression at 565.12 might not evaluate to true." } (ite(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height])) >= (0 - 1);
	assert { :msg "  884.3: The precondition at 544.12 might not hold. The permission at 544.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 544.12 might not hold. Insufficient fraction at 544.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_44[r#72_$_0,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_44[r#72_$_0,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_44[r#72_$_0,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_3309_$_0 == Mask_$_44[r#72_$_0,AVLTreeNode.key := Mask_$_44[r#72_$_0,AVLTreeNode.key][perm$R := Mask_$_44[r#72_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3309_$_0);
	assume wf(Heap_$_3,exhaleMask#_3309_$_0,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assert { :msg "  884.3: The precondition at 545.12 might not hold. The permission at 545.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 545.12 might not hold. Insufficient fraction at 545.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_3309_$_0[r#72_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_0[r#72_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3309_$_0[r#72_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3309_$_1 == exhaleMask#_3309_$_0[r#72_$_0,AVLTreeNode.height := exhaleMask#_3309_$_0[r#72_$_0,AVLTreeNode.height][perm$R := exhaleMask#_3309_$_0[r#72_$_0,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3309_$_1);
	assume wf(Heap_$_3,exhaleMask#_3309_$_1,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assert { :msg "  884.3: The precondition at 546.12 might not hold. The permission at 546.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 546.12 might not hold. Insufficient fraction at 546.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_3309_$_1[r#72_$_0,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_1[r#72_$_0,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_3309_$_1[r#72_$_0,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_3309_$_2 == exhaleMask#_3309_$_1[r#72_$_0,AVLTreeNode.left := exhaleMask#_3309_$_1[r#72_$_0,AVLTreeNode.left][perm$R := exhaleMask#_3309_$_1[r#72_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3309_$_2);
	assume wf(Heap_$_3,exhaleMask#_3309_$_2,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assert { :msg "  884.3: The precondition at 547.12 might not hold. The permission at 547.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 547.12 might not hold. Insufficient fraction at 547.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_3309_$_2[r#72_$_0,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_2[r#72_$_0,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_3309_$_2[r#72_$_0,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_3309_$_3 == exhaleMask#_3309_$_2[r#72_$_0,AVLTreeNode.right := exhaleMask#_3309_$_2[r#72_$_0,AVLTreeNode.right][perm$R := exhaleMask#_3309_$_2[r#72_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3309_$_3);
	assume wf(Heap_$_3,exhaleMask#_3309_$_3,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assert { :msg "  884.3: The precondition at 549.12 might not hold. The permission at 549.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 549.12 might not hold. Insufficient fraction at 549.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_3309_$_3[r#72_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_3[r#72_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3309_$_3[r#72_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3309_$_4 == exhaleMask#_3309_$_3[r#72_$_0,AVLTreeNode.keys := exhaleMask#_3309_$_3[r#72_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_3309_$_3[r#72_$_0,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3309_$_4);
	assume wf(Heap_$_3,exhaleMask#_3309_$_4,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assert { :msg "  884.3: The precondition at 550.12 might not hold. The permission at 550.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 550.12 might not hold. Insufficient fraction at 550.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_3309_$_4[r#72_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_4[r#72_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3309_$_4[r#72_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3309_$_5 == exhaleMask#_3309_$_4[r#72_$_0,AVLTreeNode.balanceFactor := exhaleMask#_3309_$_4[r#72_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3309_$_4[r#72_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_3309_$_5);
	assume wf(Heap_$_3,exhaleMask#_3309_$_5,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	if ($_$_condition_$56) { goto anon200_Then; } else { goto anon200_Else; }
anon200_Then:
	assume $_$_condition_$56;
	assume $_$_condition_$56 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3309_$_6 == exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$57) { goto anon201_Then; } else { goto anon201_Else; }
anon200_Else:
	assume !$_$_condition_$56;
	assume $_$_condition_$56 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_7 == exhaleMask#_3309_$_5;
	goto $branchMerge_24;
anon201_Then:
	assume $_$_condition_$57;
	assume $_$_condition_$57 <==> (!CanRead(exhaleMask#_3309_$_6,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_3309_$_6,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_3308_$_0[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon121;
anon201_Else:
	assume !$_$_condition_$57;
	assume $_$_condition_$57 <==> (!CanRead(exhaleMask#_3309_$_6,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_3309_$_6,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon121;
anon202_Then:
	assume $_$_condition_$58;
	assume $_$_condition_$58 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3309_$_8 == exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_8);
	assume wf(Heap_$_3,exhaleMask#_3309_$_8,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_9 == exhaleMask#_3309_$_8;
	goto $branchMerge_25;
anon202_Else:
	assume !$_$_condition_$58;
	assume $_$_condition_$58 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_9 == exhaleMask#_3309_$_7;
	goto $branchMerge_25;
anon121:
	assume IsGoodMask(exhaleMask#_3309_$_6);
	assume wf(Heap_$_3,exhaleMask#_3309_$_6,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_7 == exhaleMask#_3309_$_6;
	goto $branchMerge_24;
anon203_Then:
	assume $_$_condition_$60;
	assume $_$_condition_$60 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3309_$_10 == exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_10);
	assume wf(Heap_$_3,exhaleMask#_3309_$_10,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_11 == exhaleMask#_3309_$_10;
	goto $branchMerge_26;
anon203_Else:
	assume !$_$_condition_$60;
	assume $_$_condition_$60 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_11 == exhaleMask#_3309_$_9;
	goto $branchMerge_26;
anon204_Then:
	assume $_$_condition_$62;
	assume $_$_condition_$62 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3309_$_12 == exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_12);
	assume wf(Heap_$_3,exhaleMask#_3309_$_12,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_13 == exhaleMask#_3309_$_12;
	goto $branchMerge_27;
anon204_Else:
	assume !$_$_condition_$62;
	assume $_$_condition_$62 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_13 == exhaleMask#_3309_$_11;
	goto $branchMerge_27;
anon205_Then:
	assume $_$_condition_$64;
	assume $_$_condition_$64 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3309_$_14 == exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$66) { goto anon206_Then; } else { goto anon206_Else; }
anon205_Else:
	assume !$_$_condition_$64;
	assume $_$_condition_$64 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_3309_$_15 == exhaleMask#_3309_$_13;
	goto $branchMerge_28;
anon206_Then:
	assume $_$_condition_$66;
	assume $_$_condition_$66 <==> (!CanRead(exhaleMask#_3309_$_14,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_3309_$_14,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_3308_$_0[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon131;
anon206_Else:
	assume !$_$_condition_$66;
	assume $_$_condition_$66 <==> (!CanRead(exhaleMask#_3309_$_14,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid));
	assume CanRead(exhaleMask#_3309_$_14,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon131;
anon207_Then:
	assume $_$_condition_$67;
	assume $_$_condition_$67 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3309_$_16 == exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_16);
	assume wf(Heap_$_3,exhaleMask#_3309_$_16,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_17 == exhaleMask#_3309_$_16;
	goto $branchMerge_29;
anon207_Else:
	assume !$_$_condition_$67;
	assume $_$_condition_$67 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_3309_$_17 == exhaleMask#_3309_$_15;
	goto $branchMerge_29;
anon131:
	assume IsGoodMask(exhaleMask#_3309_$_14);
	assume wf(Heap_$_3,exhaleMask#_3309_$_14,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_15 == exhaleMask#_3309_$_14;
	goto $branchMerge_28;
anon208_Then:
	assume $_$_condition_$69;
	assume $_$_condition_$69 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3309_$_18 == exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_18);
	assume wf(Heap_$_3,exhaleMask#_3309_$_18,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_19 == exhaleMask#_3309_$_18;
	goto $branchMerge_30;
anon208_Else:
	assume !$_$_condition_$69;
	assume $_$_condition_$69 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_3309_$_19 == exhaleMask#_3309_$_17;
	goto $branchMerge_30;
anon209_Then:
	assume $_$_condition_$71;
	assume $_$_condition_$71 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 561.12 might not hold. The permission at 561.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 561.12 might not hold. Insufficient fraction at 561.28 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_3309_$_19[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_19[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3309_$_19[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3309_$_20 == exhaleMask#_3309_$_19[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor := exhaleMask#_3309_$_19[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3309_$_19[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_20);
	assume wf(Heap_$_3,exhaleMask#_3309_$_20,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_21 == exhaleMask#_3309_$_20;
	goto anon138;
anon209_Else:
	assume !$_$_condition_$71;
	assume $_$_condition_$71 <==> (!(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null));
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_3309_$_21 == exhaleMask#_3309_$_19;
	goto anon138;
anon138:
	assume IsGoodExhaleState(exhaleHeap#_3308_$_0,Heap_$_3,exhaleMask#_3309_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_3309_$_21);
	assume wf(exhaleHeap#_3308_$_0,exhaleMask#_3309_$_21,ZeroMask);
	assume !(r#72_$_0 == null);
	assume wf(exhaleHeap#_3308_$_0,exhaleMask#_3309_$_21,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_45 == exhaleMask#_3309_$_21[r#72_$_0,AVLTreeNode.valid := exhaleMask#_3309_$_21[r#72_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_3309_$_21[r#72_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_45);
	assume IsGoodState(heapFragment(exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_3308_$_0,Mask_$_45,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_45,ZeroMask);
	assume !(r#72_$_0 == null);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_45,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_46 == Mask_$_45[r#72_$_0,AVLTreeNode.height := Mask_$_45[r#72_$_0,AVLTreeNode.height][perm$R := Mask_$_45[r#72_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_46);
	assume IsGoodState(heapFragment(exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_3308_$_0,Mask_$_46,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_46,ZeroMask);
	assume !(r#72_$_0 == null);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_46,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_47 == Mask_$_46[r#72_$_0,AVLTreeNode.keys := Mask_$_46[r#72_$_0,AVLTreeNode.keys][perm$R := Mask_$_46[r#72_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_47);
	assume IsGoodState(heapFragment(exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_3308_$_0,Mask_$_47,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_47,ZeroMask);
	assume !(r#72_$_0 == null);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_47,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_48 == Mask_$_47[r#72_$_0,AVLTreeNode.balanceFactor := Mask_$_47[r#72_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_47[r#72_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_48);
	assume IsGoodState(heapFragment(exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_3308_$_0,Mask_$_48,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_48,ZeroMask);
	assume Seq#Equal(exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap_$_3[r#72_$_0,AVLTreeNode.key])),ite(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys])));
	assume exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.height] == ite(ite(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height]) > ite(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height]),ite(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height]) + 1,ite(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height]) + 1);
	assume exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.balanceFactor] == (ite(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height]) - ite(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null,0,Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height]));
	assume IsGoodMask(Mask_$_48);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  845.2: The postcondition at 870.11 might not hold. The expression at 870.11 might not evaluate to true." } !(r#72_$_0 == null);
	assert { :msg "  845.2: The postcondition at 876.11 might not hold. The expression at 876.11 might not evaluate to true." } (exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.height] == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height]) || (exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.height] == (Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.height] + 1));
	assert { :msg "  845.2: The postcondition at 877.11 might not hold. The expression at 877.11 might not evaluate to true." } Seq#Equal(exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.keys],Seq#Append(Seq#Append(ite(Heap[this,AVLTreeNode.left] == null,(Seq#Empty() : Seq (Integer) ),Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]),Seq#Singleton(Heap[this,AVLTreeNode.key])),Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.keys]));
	assert { :msg "  845.2: The postcondition at 871.11 might not hold. The permission at 871.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  845.2: The postcondition at 871.11 might not hold. Insufficient fraction at 871.11 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_48[r#72_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_48[r#72_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_48[r#72_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3327_$_0 == Mask_$_48[r#72_$_0,AVLTreeNode.valid := Mask_$_48[r#72_$_0,AVLTreeNode.valid][perm$R := Mask_$_48[r#72_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$73) { goto anon210_Then; } else { goto anon210_Else; }
anon210_Then:
	assume $_$_condition_$73;
	assume $_$_condition_$73 <==> (!CanRead(exhaleMask#_3327_$_0,ZeroMask,r#72_$_0,AVLTreeNode.valid));
	assume !CanRead(exhaleMask#_3327_$_0,ZeroMask,r#72_$_0,AVLTreeNode.valid);
	assume exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.valid] < exhaleHeap#_3326_$_0[r#72_$_0,AVLTreeNode.valid];
	goto anon140;
anon210_Else:
	assume !$_$_condition_$73;
	assume $_$_condition_$73 <==> (!CanRead(exhaleMask#_3327_$_0,ZeroMask,r#72_$_0,AVLTreeNode.valid));
	assume CanRead(exhaleMask#_3327_$_0,ZeroMask,r#72_$_0,AVLTreeNode.valid);
	goto anon140;
anon140:
	assume IsGoodMask(exhaleMask#_3327_$_0);
	assume wf(exhaleHeap#_3308_$_0,exhaleMask#_3327_$_0,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  845.2: The postcondition at 872.11 might not hold. The permission at 872.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  845.2: The postcondition at 872.11 might not hold. Insufficient fraction at 872.11 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3327_$_0[r#72_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3327_$_0[r#72_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3327_$_0[r#72_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3327_$_1 == exhaleMask#_3327_$_0[r#72_$_0,AVLTreeNode.height := exhaleMask#_3327_$_0[r#72_$_0,AVLTreeNode.height][perm$R := exhaleMask#_3327_$_0[r#72_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3327_$_1);
	assume wf(exhaleHeap#_3308_$_0,exhaleMask#_3327_$_1,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  845.2: The postcondition at 873.11 might not hold. The permission at 873.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  845.2: The postcondition at 873.11 might not hold. Insufficient fraction at 873.11 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3327_$_1[r#72_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3327_$_1[r#72_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3327_$_1[r#72_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3327_$_2 == exhaleMask#_3327_$_1[r#72_$_0,AVLTreeNode.keys := exhaleMask#_3327_$_1[r#72_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_3327_$_1[r#72_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3327_$_2);
	assume wf(exhaleHeap#_3308_$_0,exhaleMask#_3327_$_2,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_48,ZeroMask);
	assert { :msg "  845.2: The postcondition at 874.11 might not hold. The permission at 874.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  845.2: The postcondition at 874.11 might not hold. Insufficient fraction at 874.11 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_3327_$_2[r#72_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3327_$_2[r#72_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3327_$_2[r#72_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3327_$_3 == exhaleMask#_3327_$_2[r#72_$_0,AVLTreeNode.balanceFactor := exhaleMask#_3327_$_2[r#72_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3327_$_2[r#72_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3327_$_3);
	assume wf(exhaleHeap#_3308_$_0,exhaleMask#_3327_$_3,ZeroMask);
	assume wf(exhaleHeap#_3308_$_0,Mask_$_48,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_3326_$_0,exhaleHeap#_3308_$_0,exhaleMask#_3327_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_3327_$_3);
	assume wf(exhaleHeap#_3326_$_0,exhaleMask#_3327_$_3,ZeroMask);
	assert { :msg "  845.2: Method might lock/unlock more than allowed." } (forall  lk#_3332 : ref :: {exhaleHeap#_3326_$_0[lk#_3332,held]} {exhaleHeap#_3326_$_0[lk#_3332,rdheld]} ( (((0 < exhaleHeap#_3326_$_0[lk#_3332,held]) <==> (0 < Heap[lk#_3332,held])) && (exhaleHeap#_3326_$_0[lk#_3332,rdheld] <==> Heap[lk#_3332,rdheld])) || false ));
	assert { :msg "  845.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
$branchMerge_0:
	if ($_$_condition_$0) { goto anon142_Then; } else { goto anon142_Else; }
$branchMerge_1:
	if ($_$_condition_$2) { goto anon143_Then; } else { goto anon143_Else; }
$branchMerge_2:
	if ($_$_condition_$4) { goto anon144_Then; } else { goto anon144_Else; }
$branchMerge_3:
	if ($_$_condition_$6) { goto anon145_Then; } else { goto anon145_Else; }
$branchMerge_4:
	if ($_$_condition_$11) { goto anon175_Then; } else { goto anon175_Else; }
$branchMerge_5:
	if ($_$_condition_$13) { goto anon176_Then; } else { goto anon176_Else; }
$branchMerge_6:
	if ($_$_condition_$15) { goto anon177_Then; } else { goto anon177_Else; }
$branchMerge_7:
	if ($_$_condition_$17) { goto anon178_Then; } else { goto anon178_Else; }
$branchMerge_8:
	if ($_$_condition_$19) { goto anon179_Then; } else { goto anon179_Else; }
$branchMerge_9:
	if ($_$_condition_$21) { goto anon180_Then; } else { goto anon180_Else; }
$branchMerge_10:
	if ($_$_condition_$23) { goto anon181_Then; } else { goto anon181_Else; }
$branchMerge_11:
	if ($_$_condition_$25) { goto anon182_Then; } else { goto anon182_Else; }
$branchMerge_12:
	if ($_$_condition_$27) { goto anon183_Then; } else { goto anon183_Else; }
$branchMerge_13:
	if ($_$_condition_$29) { goto anon184_Then; } else { goto anon184_Else; }
$branchMerge_14:
	if ($_$_condition_$31) { goto anon185_Then; } else { goto anon185_Else; }
$branchMerge_15:
	if ($_$_condition_$34) { goto anon187_Then; } else { goto anon187_Else; }
$branchMerge_16:
	if ($_$_condition_$38) { goto anon190_Then; } else { goto anon190_Else; }
$branchMerge_17:
	if ($_$_condition_$40) { goto anon191_Then; } else { goto anon191_Else; }
$branchMerge_18:
	if ($_$_condition_$42) { goto anon192_Then; } else { goto anon192_Else; }
$branchMerge_19:
	if ($_$_condition_$44) { goto anon193_Then; } else { goto anon193_Else; }
$branchMerge_20:
	if ($_$_condition_$47) { goto anon195_Then; } else { goto anon195_Else; }
$branchMerge_21:
	if ($_$_condition_$49) { goto anon196_Then; } else { goto anon196_Else; }
$branchMerge_22:
	if ($_$_condition_$51) { goto anon197_Then; } else { goto anon197_Else; }
$branchMerge_23:
	if ($_$_condition_$54) { goto anon199_Then; } else { goto anon199_Else; }
$branchMerge_24:
	if ($_$_condition_$58) { goto anon202_Then; } else { goto anon202_Else; }
$branchMerge_25:
	if ($_$_condition_$60) { goto anon203_Then; } else { goto anon203_Else; }
$branchMerge_26:
	if ($_$_condition_$62) { goto anon204_Then; } else { goto anon204_Else; }
$branchMerge_27:
	if ($_$_condition_$64) { goto anon205_Then; } else { goto anon205_Else; }
$branchMerge_28:
	if ($_$_condition_$67) { goto anon207_Then; } else { goto anon207_Else; }
$branchMerge_29:
	if ($_$_condition_$69) { goto anon208_Then; } else { goto anon208_Else; }
$branchMerge_30:
	if ($_$_condition_$71) { goto anon209_Then; } else { goto anon209_Else; }
}
