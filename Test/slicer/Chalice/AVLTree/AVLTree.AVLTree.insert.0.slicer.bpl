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
procedure AVLTree.insert (this : ref,k#0 : int)
{
	var methodK#_37 : int;
	var unfoldK#_38 : int;
	var oldVers#_50 : int;
	var newVers#_51 : int;
	var cond#_52 : bool;
	var n#2 : ref;
	var nw#_53 : ref;
	var methodCallK#_58 : int;
	var this#118 : ref;
	var k#119 : int;
	var callHeap#_54 : HeapType;
	var callMask#_55 : MaskType;
	var callSecMask#_56 : MaskType;
	var callCredits#_57 : CreditsType;
	var exhaleMask#_60 : MaskType;
	var exhaleHeap#_59 : HeapType;
	var methodCallK#_73 : int;
	var this#120 : ref;
	var k#121 : int;
	var r#122 : ref;
	var callHeap#_69 : HeapType;
	var callMask#_70 : MaskType;
	var callSecMask#_71 : MaskType;
	var callCredits#_72 : CreditsType;
	var exhaleMask#_75 : MaskType;
	var exhaleHeap#_74 : HeapType;
	var r#75 : ref;
	var foldK#_85 : int;
	var exhaleMask#_87 : MaskType;
	var exhaleHeap#_86 : HeapType;
	var predRec#_82 : ref;
	var predVer#_83 : int;
	var predFlag#_84 : bool;
	var exhaleMask#_95 : MaskType;
	var exhaleHeap#_94 : HeapType;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var oldVers#_50_$_0 : int;
	var newVers#_51_$_0 : int;
	var Heap_$_0 : HeapType;
	var Heap_$_1 : HeapType;
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
	var cond#_52_$_0 : bool;
	var nw#_53_$_0 : ref;
	var Mask_$_13 : MaskType;
	var Mask_$_14 : MaskType;
	var Mask_$_15 : MaskType;
	var Mask_$_16 : MaskType;
	var Mask_$_17 : MaskType;
	var Mask_$_18 : MaskType;
	var Mask_$_19 : MaskType;
	var exhaleHeap#_59_$_0 : HeapType;
	var exhaleMask#_60_$_0 : MaskType;
	var exhaleMask#_60_$_1 : MaskType;
	var exhaleMask#_60_$_2 : MaskType;
	var exhaleMask#_60_$_3 : MaskType;
	var exhaleMask#_60_$_4 : MaskType;
	var exhaleMask#_60_$_5 : MaskType;
	var Mask_$_20 : MaskType;
	var Mask_$_21 : MaskType;
	var Mask_$_22 : MaskType;
	var Mask_$_23 : MaskType;
	var Heap_$_2 : HeapType;
	var this#120_$_0 : ref;
	var exhaleHeap#_74_$_0 : HeapType;
	var exhaleMask#_75_$_0 : MaskType;
	var exhaleMask#_75_$_1 : MaskType;
	var exhaleMask#_75_$_2 : MaskType;
	var exhaleMask#_75_$_3 : MaskType;
	var r#122_$_0 : ref;
	var Mask_$_24 : MaskType;
	var Mask_$_25 : MaskType;
	var Mask_$_26 : MaskType;
	var Mask_$_27 : MaskType;
	var Heap_$_3 : HeapType;
	var Mask_$_28 : MaskType;
	var Heap_$_4 : HeapType;
	var Heap_$_5 : HeapType;
	var exhaleHeap#_86_$_0 : HeapType;
	var exhaleMask#_87_$_0 : MaskType;
	var SecMask_$_0 : MaskType;
	var exhaleMask#_87_$_1 : MaskType;
	var SecMask_$_1 : MaskType;
	var exhaleMask#_87_$_2 : MaskType;
	var SecMask_$_2 : MaskType;
	var SecMask_$_3 : MaskType;
	var exhaleMask#_87_$_3 : MaskType;
	var exhaleMask#_87_$_4 : MaskType;
	var SecMask_$_4 : MaskType;
	var exhaleMask#_87_$_5 : MaskType;
	var SecMask_$_5 : MaskType;
	var exhaleMask#_87_$_6 : MaskType;
	var SecMask_$_6 : MaskType;
	var SecMask_$_7 : MaskType;
	var exhaleMask#_87_$_7 : MaskType;
	var exhaleMask#_87_$_8 : MaskType;
	var SecMask_$_8 : MaskType;
	var exhaleMask#_87_$_9 : MaskType;
	var SecMask_$_9 : MaskType;
	var Mask_$_29 : MaskType;
	var predVer#_83_$_0 : int;
	var exhaleHeap#_94_$_0 : HeapType;
	var exhaleMask#_95_$_0 : MaskType;
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
	var exhaleMask#_95_$_1 : MaskType;
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
	assume (this == null) || (dtype(this) == AVLTree#t);
	assume true;
	assume (n#2 == null) || (dtype(n#2) == AVLTreeNode#t);
	assume (this#118 == null) || (dtype(this#118) == AVLTreeNode#t);
	assume true;
	assume (this#120 == null) || (dtype(this#120) == AVLTreeNode#t);
	assume true;
	assume (r#122 == null) || (dtype(r#122) == AVLTreeNode#t);
	assume (r#75 == null) || (dtype(r#75) == AVLTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_37) && ((1000 * methodK#_37) < Fractions(1));
	assume CurrentModule == module#default;
	assume CanAssumeFunctionDefs;
	assume !(this == null);
	assume wf(Heap,ZeroMask,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,AVLTree.valid := ZeroMask[this,AVLTree.valid][perm$R := ZeroMask[this,AVLTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(heapFragment(Heap[this,AVLTree.valid]));
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume !(this == null);
	assume wf(Heap,Mask_$_0,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_1 == Mask_$_0[this,AVLTree.keys := Mask_$_0[this,AVLTree.keys][perm$R := Mask_$_0[this,AVLTree.keys][perm$R] + Fractions(50)]];
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
	assume #AVLTree.valid#trigger(this);
	assume ((0 < unfoldK#_38) && (unfoldK#_38 < Fractions(1))) && ((1000 * unfoldK#_38) < methodK#_37);
	assert { :msg "  46.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  46.3: unfold might fail because the predicate AVLTree.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  46.3: unfold might fail because the predicate AVLTree.valid does not hold. Insufficient fraction at <undefined position> for AVLTree.valid." } (Fractions(100) <= Mask_$_1[this,AVLTree.valid][perm$R]) && ((Fractions(100) == Mask_$_1[this,AVLTree.valid][perm$R]) ==> (0 <= Mask_$_1[this,AVLTree.valid][perm$N]));
	assume Mask_$_2 == Mask_$_1[this,AVLTree.valid := Mask_$_1[this,AVLTree.valid][perm$R := Mask_$_1[this,AVLTree.valid][perm$R] - Fractions(100)]];
	if ($_$_condition) { goto anon94_Then; } else { goto anon94_Else; }
anon94_Then:
	assume false;
	goto $exit;
anon94_Else:
	assume !false;
	if ($_$_condition_$0) { goto anon107_Then; } else { goto anon107_Else; }
anon107_Then:
	assume !CanRead(Mask_$_2,ZeroMask,this,AVLTree.valid);
	assume oldVers#_50_$_0 == Heap[this,AVLTree.valid];
	assume Heap_$_0 == Heap[this,AVLTree.valid := newVers#_51_$_0];
	assume oldVers#_50_$_0 < Heap_$_0[this,AVLTree.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon28;
anon107_Else:
	assume CanRead(Mask_$_2,ZeroMask,this,AVLTree.valid);
	assume Heap_$_1 == Heap;
	goto anon28;
anon28:
	assume IsGoodMask(Mask_$_2);
	assume wf(Heap_$_1,Mask_$_2,ZeroMask);
	assume IsGoodMask(Mask_$_2);
	assume wf(Heap_$_1,Mask_$_2,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_2,ZeroMask);
	assume (Heap_$_1[this,AVLTree.root] == null) || (dtype(Heap_$_1[this,AVLTree.root]) == AVLTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_3 == Mask_$_2[this,AVLTree.root := Mask_$_2[this,AVLTree.root][perm$R := Mask_$_2[this,AVLTree.root][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_3);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTree.root]));
	assume wf(Heap_$_1,Mask_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_3,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_1,Mask_$_3,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_4 == Mask_$_3[this,AVLTree.keys := Mask_$_3[this,AVLTree.keys][perm$R := Mask_$_3[this,AVLTree.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_4);
	assume IsGoodState(heapFragment(Heap_$_1[this,AVLTree.keys]));
	assume wf(Heap_$_1,Mask_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_4,ZeroMask);
	if ($_$_condition_$1) { goto anon108_Then; } else { goto anon108_Else; }
anon108_Then:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume wf(Heap_$_1,Mask_$_4,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_5 == Mask_$_4[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid := Mask_$_4[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R := Mask_$_4[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_5);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid]));
	assume wf(Heap_$_1,Mask_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_5,ZeroMask);
	assume Mask_$_6 == Mask_$_5;
	if ($_$_condition_$2) { goto anon109_Then; } else { goto anon109_Else; }
anon108_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_6 == Mask_$_4;
	if ($_$_condition_$3) { goto anon109_Then; } else { goto anon109_Else; }
anon109_Then:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume wf(Heap_$_1,Mask_$_6,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_7 == Mask_$_6[Heap_$_1[this,AVLTree.root],AVLTreeNode.height := Mask_$_6[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R := Mask_$_6[Heap_$_1[this,AVLTree.root],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_7);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.height]));
	assume wf(Heap_$_1,Mask_$_7,ZeroMask);
	assume wf(Heap_$_1,Mask_$_7,ZeroMask);
	assume Mask_$_8 == Mask_$_7;
	if ($_$_condition_$4) { goto anon110_Then; } else { goto anon110_Else; }
anon109_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_8 == Mask_$_6;
	if ($_$_condition_$5) { goto anon110_Then; } else { goto anon110_Else; }
anon110_Then:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume wf(Heap_$_1,Mask_$_8,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_9 == Mask_$_8[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys := Mask_$_8[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R := Mask_$_8[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_9);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys]));
	assume wf(Heap_$_1,Mask_$_9,ZeroMask);
	assume wf(Heap_$_1,Mask_$_9,ZeroMask);
	assume Mask_$_10 == Mask_$_9;
	if ($_$_condition_$6) { goto anon111_Then; } else { goto anon111_Else; }
anon110_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_10 == Mask_$_8;
	if ($_$_condition_$7) { goto anon111_Then; } else { goto anon111_Else; }
anon111_Then:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume wf(Heap_$_1,Mask_$_10,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_11 == Mask_$_10[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor := Mask_$_10[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := Mask_$_10[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_11);
	assume IsGoodState(heapFragment(Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.balanceFactor]));
	assume wf(Heap_$_1,Mask_$_11,ZeroMask);
	assume wf(Heap_$_1,Mask_$_11,ZeroMask);
	assume Mask_$_12 == Mask_$_11;
	if ($_$_condition_$8) { goto anon112_Then; } else { goto anon112_Else; }
anon111_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_12 == Mask_$_10;
	if ($_$_condition_$9) { goto anon112_Then; } else { goto anon112_Else; }
anon112_Then:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume Seq#Equal(Heap_$_1[this,AVLTree.keys],Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$10) { goto anon113_Then; } else { goto anon113_Else; }
anon112_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	if ($_$_condition_$11) { goto anon113_Then; } else { goto anon113_Else; }
anon113_Then:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Seq#Equal(Heap_$_1[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon40;
anon113_Else:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	goto anon40;
anon40:
	assume IsGoodMask(Mask_$_12);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assume cond#_52_$_0 <==> (Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  47.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  47.7: Location might not be readable." } true ==> CanRead(Mask_$_12,ZeroMask,this,AVLTree.root);
	if ($_$_condition_$12) { goto anon114_Then; } else { goto anon114_Else; }
anon114_Then:
	assume cond#_52_$_0;
	assume (!(nw#_53_$_0 == null)) && (dtype(nw#_53_$_0) == AVLTreeNode#t);
	assume (forall<T#_0> f_$16 : Field (T#_0)  :: ( (Mask_$_12[nw#_53_$_0,f_$16][perm$R] == 0) && (Mask_$_12[nw#_53_$_0,f_$16][perm$N] == 0) ));
	assume Heap_$_1[nw#_53_$_0,mu] == $LockBottom;
	assume Heap_$_1[nw#_53_$_0,held] <= 0;
	assume Heap_$_1[nw#_53_$_0,rdheld] <==> false;
	assume Mask_$_13 == Mask_$_12[nw#_53_$_0,AVLTreeNode.key := Mask_$_12[nw#_53_$_0,AVLTreeNode.key][perm$R := Mask_$_12[nw#_53_$_0,AVLTreeNode.key][perm$R] + Fractions(100)]];
	assume Mask_$_14 == Mask_$_13[nw#_53_$_0,AVLTreeNode.height := Mask_$_13[nw#_53_$_0,AVLTreeNode.height][perm$R := Mask_$_13[nw#_53_$_0,AVLTreeNode.height][perm$R] + Fractions(100)]];
	assume Mask_$_15 == Mask_$_14[nw#_53_$_0,AVLTreeNode.left := Mask_$_14[nw#_53_$_0,AVLTreeNode.left][perm$R := Mask_$_14[nw#_53_$_0,AVLTreeNode.left][perm$R] + Fractions(100)]];
	assume Mask_$_16 == Mask_$_15[nw#_53_$_0,AVLTreeNode.right := Mask_$_15[nw#_53_$_0,AVLTreeNode.right][perm$R := Mask_$_15[nw#_53_$_0,AVLTreeNode.right][perm$R] + Fractions(100)]];
	assume Mask_$_17 == Mask_$_16[nw#_53_$_0,AVLTreeNode.keys := Mask_$_16[nw#_53_$_0,AVLTreeNode.keys][perm$R := Mask_$_16[nw#_53_$_0,AVLTreeNode.keys][perm$R] + Fractions(100)]];
	assume Mask_$_18 == Mask_$_17[nw#_53_$_0,AVLTreeNode.balanceFactor := Mask_$_17[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_17[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(100)]];
	assume Mask_$_19 == Mask_$_18[nw#_53_$_0,mu := Mask_$_18[nw#_53_$_0,mu][perm$R := Mask_$_18[nw#_53_$_0,mu][perm$R] + Fractions(100)]];
	assume ((0 < methodCallK#_58) && ((1000 * methodCallK#_58) < Fractions(1))) && ((1000 * methodCallK#_58) < methodK#_37);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assert { :msg "  49.4: The target of the method call might be null." } !(nw#_53_$_0 == null);
	assert { :msg "  49.4: The precondition at 155.12 might not hold. The permission at 155.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  49.4: The precondition at 155.12 might not hold. Insufficient fraction at 155.12 for AVLTreeNode.key." } (Fractions(100) <= Mask_$_19[nw#_53_$_0,AVLTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_19[nw#_53_$_0,AVLTreeNode.key][perm$R]) ==> (0 <= Mask_$_19[nw#_53_$_0,AVLTreeNode.key][perm$N]));
	assume exhaleMask#_60_$_0 == Mask_$_19[nw#_53_$_0,AVLTreeNode.key := Mask_$_19[nw#_53_$_0,AVLTreeNode.key][perm$R := Mask_$_19[nw#_53_$_0,AVLTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_60_$_0);
	assume wf(Heap_$_1,exhaleMask#_60_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assert { :msg "  49.4: The precondition at 156.12 might not hold. The permission at 156.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  49.4: The precondition at 156.12 might not hold. Insufficient fraction at 156.12 for AVLTreeNode.height." } (Fractions(100) <= exhaleMask#_60_$_0[nw#_53_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_60_$_0[nw#_53_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_60_$_0[nw#_53_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_60_$_1 == exhaleMask#_60_$_0[nw#_53_$_0,AVLTreeNode.height := exhaleMask#_60_$_0[nw#_53_$_0,AVLTreeNode.height][perm$R := exhaleMask#_60_$_0[nw#_53_$_0,AVLTreeNode.height][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_60_$_1);
	assume wf(Heap_$_1,exhaleMask#_60_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assert { :msg "  49.4: The precondition at 157.12 might not hold. The permission at 157.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  49.4: The precondition at 157.12 might not hold. Insufficient fraction at 157.12 for AVLTreeNode.left." } (Fractions(100) <= exhaleMask#_60_$_1[nw#_53_$_0,AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_60_$_1[nw#_53_$_0,AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_60_$_1[nw#_53_$_0,AVLTreeNode.left][perm$N]));
	assume exhaleMask#_60_$_2 == exhaleMask#_60_$_1[nw#_53_$_0,AVLTreeNode.left := exhaleMask#_60_$_1[nw#_53_$_0,AVLTreeNode.left][perm$R := exhaleMask#_60_$_1[nw#_53_$_0,AVLTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_60_$_2);
	assume wf(Heap_$_1,exhaleMask#_60_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assert { :msg "  49.4: The precondition at 158.12 might not hold. The permission at 158.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  49.4: The precondition at 158.12 might not hold. Insufficient fraction at 158.12 for AVLTreeNode.right." } (Fractions(100) <= exhaleMask#_60_$_2[nw#_53_$_0,AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_60_$_2[nw#_53_$_0,AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_60_$_2[nw#_53_$_0,AVLTreeNode.right][perm$N]));
	assume exhaleMask#_60_$_3 == exhaleMask#_60_$_2[nw#_53_$_0,AVLTreeNode.right := exhaleMask#_60_$_2[nw#_53_$_0,AVLTreeNode.right][perm$R := exhaleMask#_60_$_2[nw#_53_$_0,AVLTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_60_$_3);
	assume wf(Heap_$_1,exhaleMask#_60_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assert { :msg "  49.4: The precondition at 160.12 might not hold. The permission at 160.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  49.4: The precondition at 160.12 might not hold. Insufficient fraction at 160.12 for AVLTreeNode.keys." } (Fractions(100) <= exhaleMask#_60_$_3[nw#_53_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_60_$_3[nw#_53_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_60_$_3[nw#_53_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_60_$_4 == exhaleMask#_60_$_3[nw#_53_$_0,AVLTreeNode.keys := exhaleMask#_60_$_3[nw#_53_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_60_$_3[nw#_53_$_0,AVLTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_60_$_4);
	assume wf(Heap_$_1,exhaleMask#_60_$_4,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assert { :msg "  49.4: The precondition at 161.12 might not hold. The permission at 161.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  49.4: The precondition at 161.12 might not hold. Insufficient fraction at 161.12 for AVLTreeNode.balanceFactor." } (Fractions(100) <= exhaleMask#_60_$_4[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_60_$_4[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_60_$_4[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_60_$_5 == exhaleMask#_60_$_4[nw#_53_$_0,AVLTreeNode.balanceFactor := exhaleMask#_60_$_4[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_60_$_4[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(100)]];
	assume IsGoodMask(exhaleMask#_60_$_5);
	assume wf(Heap_$_1,exhaleMask#_60_$_5,ZeroMask);
	assume wf(Heap_$_1,Mask_$_19,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_59_$_0,Heap_$_1,exhaleMask#_60_$_5,ZeroMask);
	assume IsGoodMask(exhaleMask#_60_$_5);
	assume wf(exhaleHeap#_59_$_0,exhaleMask#_60_$_5,ZeroMask);
	assume !(nw#_53_$_0 == null);
	assume wf(exhaleHeap#_59_$_0,exhaleMask#_60_$_5,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_20 == exhaleMask#_60_$_5[nw#_53_$_0,AVLTreeNode.valid := exhaleMask#_60_$_5[nw#_53_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_60_$_5[nw#_53_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_20);
	assume IsGoodState(heapFragment(exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_59_$_0,Mask_$_20,ZeroMask);
	assume wf(exhaleHeap#_59_$_0,Mask_$_20,ZeroMask);
	assume !(nw#_53_$_0 == null);
	assume wf(exhaleHeap#_59_$_0,Mask_$_20,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_21 == Mask_$_20[nw#_53_$_0,AVLTreeNode.keys := Mask_$_20[nw#_53_$_0,AVLTreeNode.keys][perm$R := Mask_$_20[nw#_53_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_21);
	assume IsGoodState(heapFragment(exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_59_$_0,Mask_$_21,ZeroMask);
	assume wf(exhaleHeap#_59_$_0,Mask_$_21,ZeroMask);
	assume !(nw#_53_$_0 == null);
	assume wf(exhaleHeap#_59_$_0,Mask_$_21,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_22 == Mask_$_21[nw#_53_$_0,AVLTreeNode.height := Mask_$_21[nw#_53_$_0,AVLTreeNode.height][perm$R := Mask_$_21[nw#_53_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_22);
	assume IsGoodState(heapFragment(exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_59_$_0,Mask_$_22,ZeroMask);
	assume wf(exhaleHeap#_59_$_0,Mask_$_22,ZeroMask);
	assume !(nw#_53_$_0 == null);
	assume wf(exhaleHeap#_59_$_0,Mask_$_22,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_23 == Mask_$_22[nw#_53_$_0,AVLTreeNode.balanceFactor := Mask_$_22[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_22[nw#_53_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_23);
	assume IsGoodState(heapFragment(exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_59_$_0,Mask_$_23,ZeroMask);
	assume wf(exhaleHeap#_59_$_0,Mask_$_23,ZeroMask);
	assume exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.height] == 1;
	assume Seq#Equal(exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.keys],Seq#Singleton(k#0));
	assume exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.balanceFactor] == 0;
	assume Seq#Contains(exhaleHeap#_59_$_0[nw#_53_$_0,AVLTreeNode.keys],k#0);
	assume IsGoodMask(Mask_$_23);
	assume wf(exhaleHeap#_59_$_0,Mask_$_23,ZeroMask);
	assert { :msg "  50.4: Location might not be writable" } CanWrite(Mask_$_23,this,AVLTree.root);
	assume Heap_$_2 == exhaleHeap#_59_$_0[this,AVLTree.root := nw#_53_$_0];
	assume wf(Heap_$_2,Mask_$_23,ZeroMask);
	assume Mask_$_28 == Mask_$_23;
	assume Heap_$_4 == Heap_$_2;
	goto anon51;
anon114_Else:
	assume !cond#_52_$_0;
	assume ((0 < methodCallK#_73) && ((1000 * methodCallK#_73) < Fractions(1))) && ((1000 * methodCallK#_73) < methodK#_37);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  52.14: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  52.14: Location might not be readable." } true ==> CanRead(Mask_$_12,ZeroMask,this,AVLTree.root);
	assert { :msg "  52.4: The target of the method call might be null." } !(Heap_$_1[this,AVLTree.root] == null);
	assume this#120_$_0 == Heap_$_1[this,AVLTree.root];
	assert { :msg "  52.4: The precondition at 185.12 might not hold. The permission at 185.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  52.4: The precondition at 185.12 might not hold. Insufficient fraction at 185.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_12[this#120_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_12[this#120_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_12[this#120_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_75_$_0 == Mask_$_12[this#120_$_0,AVLTreeNode.valid := Mask_$_12[this#120_$_0,AVLTreeNode.valid][perm$R := Mask_$_12[this#120_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$13) { goto anon115_Then; } else { goto anon115_Else; }
anon51:
	assert { :msg "  55.3: Location might not be writable" } CanWrite(Mask_$_28,this,AVLTree.keys);
	assert { :msg "  55.11: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  55.11: Location might not be readable." } true ==> CanRead(Mask_$_28,ZeroMask,this,AVLTree.root);
	assert { :msg "  55.11: Receiver might be null." } true ==> (!(Heap_$_4[this,AVLTree.root] == null));
	assert { :msg "  55.11: Location might not be readable." } true ==> CanRead(Mask_$_28,ZeroMask,Heap_$_4[this,AVLTree.root],AVLTreeNode.keys);
	assume Heap_$_5 == Heap_$_4[this,AVLTree.keys := Heap_$_4[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys]];
	assume wf(Heap_$_5,Mask_$_28,ZeroMask);
	assume #AVLTree.valid#trigger(this);
	assume ((0 < foldK#_85) && ((1000 * foldK#_85) < Fractions(1))) && ((1000 * foldK#_85) < methodK#_37);
	assert { :msg "  56.3: The target of the fold statement might be null." } !(this == null);
	if ($_$_condition_$18) { goto anon119_Then; } else { goto anon119_Else; }
anon115_Then:
	assume !CanRead(exhaleMask#_75_$_0,ZeroMask,this#120_$_0,AVLTreeNode.valid);
	assume Heap_$_1[this#120_$_0,AVLTreeNode.valid] < exhaleHeap#_74_$_0[this#120_$_0,AVLTreeNode.valid];
	goto anon44;
anon115_Else:
	assume CanRead(exhaleMask#_75_$_0,ZeroMask,this#120_$_0,AVLTreeNode.valid);
	goto anon44;
anon44:
	assume IsGoodMask(exhaleMask#_75_$_0);
	assume wf(Heap_$_1,exhaleMask#_75_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  52.4: The precondition at 186.12 might not hold. The permission at 186.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  52.4: The precondition at 186.12 might not hold. Insufficient fraction at 186.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_75_$_0[this#120_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_75_$_0[this#120_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_75_$_0[this#120_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_75_$_1 == exhaleMask#_75_$_0[this#120_$_0,AVLTreeNode.keys := exhaleMask#_75_$_0[this#120_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_75_$_0[this#120_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_75_$_1);
	assume wf(Heap_$_1,exhaleMask#_75_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  52.4: The precondition at 187.12 might not hold. The permission at 187.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  52.4: The precondition at 187.12 might not hold. Insufficient fraction at 187.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_75_$_1[this#120_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_75_$_1[this#120_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_75_$_1[this#120_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_75_$_2 == exhaleMask#_75_$_1[this#120_$_0,AVLTreeNode.height := exhaleMask#_75_$_1[this#120_$_0,AVLTreeNode.height][perm$R := exhaleMask#_75_$_1[this#120_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_75_$_2);
	assume wf(Heap_$_1,exhaleMask#_75_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  52.4: The precondition at 188.12 might not hold. The permission at 188.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  52.4: The precondition at 188.12 might not hold. Insufficient fraction at 188.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_75_$_2[this#120_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_75_$_2[this#120_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_75_$_2[this#120_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_75_$_3 == exhaleMask#_75_$_2[this#120_$_0,AVLTreeNode.balanceFactor := exhaleMask#_75_$_2[this#120_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_75_$_2[this#120_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_75_$_3);
	assume wf(Heap_$_1,exhaleMask#_75_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_74_$_0,Heap_$_1,exhaleMask#_75_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_75_$_3);
	assume wf(exhaleHeap#_74_$_0,exhaleMask#_75_$_3,ZeroMask);
	assume (r#122_$_0 == null) || (dtype(r#122_$_0) == AVLTreeNode#t);
	assume !(r#122_$_0 == null);
	assume !(r#122_$_0 == null);
	assume wf(exhaleHeap#_74_$_0,exhaleMask#_75_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_24 == exhaleMask#_75_$_3[r#122_$_0,AVLTreeNode.valid := exhaleMask#_75_$_3[r#122_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_75_$_3[r#122_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_24);
	assume IsGoodState(heapFragment(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_74_$_0,Mask_$_24,ZeroMask);
	assume wf(exhaleHeap#_74_$_0,Mask_$_24,ZeroMask);
	assume !(r#122_$_0 == null);
	assume wf(exhaleHeap#_74_$_0,Mask_$_24,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_25 == Mask_$_24[r#122_$_0,AVLTreeNode.keys := Mask_$_24[r#122_$_0,AVLTreeNode.keys][perm$R := Mask_$_24[r#122_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_25);
	assume IsGoodState(heapFragment(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_74_$_0,Mask_$_25,ZeroMask);
	assume wf(exhaleHeap#_74_$_0,Mask_$_25,ZeroMask);
	assume !(r#122_$_0 == null);
	assume wf(exhaleHeap#_74_$_0,Mask_$_25,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_26 == Mask_$_25[r#122_$_0,AVLTreeNode.height := Mask_$_25[r#122_$_0,AVLTreeNode.height][perm$R := Mask_$_25[r#122_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_26);
	assume IsGoodState(heapFragment(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_74_$_0,Mask_$_26,ZeroMask);
	assume wf(exhaleHeap#_74_$_0,Mask_$_26,ZeroMask);
	assume !(r#122_$_0 == null);
	assume wf(exhaleHeap#_74_$_0,Mask_$_26,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_27 == Mask_$_26[r#122_$_0,AVLTreeNode.balanceFactor := Mask_$_26[r#122_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_26[r#122_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_27);
	assume IsGoodState(heapFragment(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_74_$_0,Mask_$_27,ZeroMask);
	assume wf(exhaleHeap#_74_$_0,Mask_$_27,ZeroMask);
	assume Seq#Contains(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys],k#0);
	assume (forall  i#82#123 : Integer :: ( ((0 <= i#82#123) && (i#82#123 < Seq#Length(Heap_$_1[this#120_$_0,AVLTreeNode.keys]))) ==> Seq#Contains(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys],Seq#Index(Heap_$_1[this#120_$_0,AVLTreeNode.keys],i#82#123)) ));
	assume (forall  i#83#124 : Integer :: ( ((0 <= i#83#124) && (i#83#124 < Seq#Length(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap_$_1[this#120_$_0,AVLTreeNode.keys],Seq#Index(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys],i#83#124)) || (Seq#Index(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys],i#83#124) == k#0)) ));
	if ($_$_condition_$14) { goto anon116_Then; } else { goto anon116_Else; }
anon116_Then:
	assume Seq#Contains(Heap_$_1[this#120_$_0,AVLTreeNode.keys],k#0);
	assume Seq#Equal(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys],Heap_$_1[this#120_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$15) { goto anon117_Then; } else { goto anon117_Else; }
anon116_Else:
	assume !Seq#Contains(Heap_$_1[this#120_$_0,AVLTreeNode.keys],k#0);
	if ($_$_condition_$16) { goto anon117_Then; } else { goto anon117_Else; }
anon117_Then:
	assume !Seq#Contains(Heap_$_1[this#120_$_0,AVLTreeNode.keys],k#0);
	assume Seq#Length(exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.keys]) == (Seq#Length(Heap_$_1[this#120_$_0,AVLTreeNode.keys]) + 1);
	goto anon48;
anon117_Else:
	assume Seq#Contains(Heap_$_1[this#120_$_0,AVLTreeNode.keys],k#0);
	goto anon48;
anon48:
	assume (exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.height] == Heap_$_1[this#120_$_0,AVLTreeNode.height]) || (exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.height] == (Heap_$_1[this#120_$_0,AVLTreeNode.height] + 1));
	if ($_$_condition_$17) { goto anon118_Then; } else { goto anon118_Else; }
anon118_Then:
	assume Seq#Contains(Heap_$_1[this#120_$_0,AVLTreeNode.keys],k#0);
	assume exhaleHeap#_74_$_0[r#122_$_0,AVLTreeNode.height] == Heap_$_1[this#120_$_0,AVLTreeNode.height];
	goto anon50;
anon118_Else:
	assume !Seq#Contains(Heap_$_1[this#120_$_0,AVLTreeNode.keys],k#0);
	goto anon50;
anon50:
	assume IsGoodMask(Mask_$_27);
	assume wf(exhaleHeap#_74_$_0,Mask_$_27,ZeroMask);
	assert { :msg "  53.4: Location might not be writable" } CanWrite(Mask_$_27,this,AVLTree.root);
	assume Heap_$_3 == exhaleHeap#_74_$_0[this,AVLTree.root := r#122_$_0];
	assume wf(Heap_$_3,Mask_$_27,ZeroMask);
	assume Mask_$_28 == Mask_$_27;
	assume Heap_$_4 == Heap_$_3;
	goto anon51;
anon119_Then:
	assume !(Heap_$_5[this,AVLTree.root] == null);
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true." } Seq#Equal(Heap_$_5[this,AVLTree.keys],Heap_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$19) { goto anon120_Then; } else { goto anon120_Else; }
anon119_Else:
	assume Heap_$_5[this,AVLTree.root] == null;
	if ($_$_condition_$20) { goto anon120_Then; } else { goto anon120_Else; }
anon120_Then:
	assume Heap_$_5[this,AVLTree.root] == null;
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 17.22 might not evaluate to true." } Seq#Equal(Heap_$_5[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon55;
anon120_Else:
	assume !(Heap_$_5[this,AVLTree.root] == null);
	goto anon55;
anon55:
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 10.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 10.6 for AVLTree.root." } (Fractions(100) <= Mask_$_28[this,AVLTree.root][perm$R]) && ((Fractions(100) == Mask_$_28[this,AVLTree.root][perm$R]) ==> (0 <= Mask_$_28[this,AVLTree.root][perm$N]));
	assume exhaleMask#_87_$_0 == Mask_$_28[this,AVLTree.root := Mask_$_28[this,AVLTree.root][perm$R := Mask_$_28[this,AVLTree.root][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_0 == ZeroMask[this,AVLTree.root := ZeroMask[this,AVLTree.root][perm$R := ZeroMask[this,AVLTree.root][perm$R] + Fractions(100)]];
	assume IsGoodMask(exhaleMask#_87_$_0);
	assume wf(Heap_$_5,exhaleMask#_87_$_0,SecMask_$_0);
	assume wf(Heap_$_5,Mask_$_28,SecMask_$_0);
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 11.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 11.6 for AVLTree.keys." } (Fractions(50) <= exhaleMask#_87_$_0[this,AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_87_$_0[this,AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_87_$_0[this,AVLTree.keys][perm$N]));
	assume exhaleMask#_87_$_1 == exhaleMask#_87_$_0[this,AVLTree.keys := exhaleMask#_87_$_0[this,AVLTree.keys][perm$R := exhaleMask#_87_$_0[this,AVLTree.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_1 == SecMask_$_0[this,AVLTree.keys := SecMask_$_0[this,AVLTree.keys][perm$R := SecMask_$_0[this,AVLTree.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_87_$_1);
	assume wf(Heap_$_5,exhaleMask#_87_$_1,SecMask_$_1);
	assume wf(Heap_$_5,Mask_$_28,SecMask_$_1);
	if ($_$_condition_$21) { goto anon121_Then; } else { goto anon121_Else; }
anon121_Then:
	assume !(Heap_$_5[this,AVLTree.root] == null);
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 12.22 might not be positive." } Fractions(100) > 0;
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_87_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_87_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_87_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_87_$_2 == exhaleMask#_87_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid := exhaleMask#_87_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid][perm$R := exhaleMask#_87_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_2 == SecMask_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_1[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$22) { goto anon122_Then; } else { goto anon122_Else; }
anon121_Else:
	assume Heap_$_5[this,AVLTree.root] == null;
	assume SecMask_$_3 == SecMask_$_1;
	assume exhaleMask#_87_$_3 == exhaleMask#_87_$_1;
	if ($_$_condition_$23) { goto anon123_Then; } else { goto anon123_Else; }
anon122_Then:
	assume !CanRead(exhaleMask#_87_$_2,SecMask_$_2,Heap_$_5[this,AVLTree.root],AVLTreeNode.valid);
	assume Heap_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid] < exhaleHeap#_86_$_0[Heap_$_5[this,AVLTree.root],AVLTreeNode.valid];
	goto anon58;
anon122_Else:
	assume CanRead(exhaleMask#_87_$_2,SecMask_$_2,Heap_$_5[this,AVLTree.root],AVLTreeNode.valid);
	goto anon58;
anon123_Then:
	assume !(Heap_$_5[this,AVLTree.root] == null);
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 13.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 13.22 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_87_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_87_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_87_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_87_$_4 == exhaleMask#_87_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height := exhaleMask#_87_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height][perm$R := exhaleMask#_87_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_4 == SecMask_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height := SecMask_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height][perm$R := SecMask_$_3[Heap_$_5[this,AVLTree.root],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_87_$_4);
	assume wf(Heap_$_5,exhaleMask#_87_$_4,SecMask_$_4);
	assume wf(Heap_$_5,Mask_$_28,SecMask_$_4);
	assume exhaleMask#_87_$_5 == exhaleMask#_87_$_4;
	assume SecMask_$_5 == SecMask_$_4;
	if ($_$_condition_$25) { goto anon124_Then; } else { goto anon124_Else; }
anon123_Else:
	assume Heap_$_5[this,AVLTree.root] == null;
	assume exhaleMask#_87_$_5 == exhaleMask#_87_$_3;
	assume SecMask_$_5 == SecMask_$_3;
	if ($_$_condition_$26) { goto anon124_Then; } else { goto anon124_Else; }
anon58:
	assume IsGoodMask(exhaleMask#_87_$_2);
	assume wf(Heap_$_5,exhaleMask#_87_$_2,SecMask_$_2);
	assume wf(Heap_$_5,Mask_$_28,SecMask_$_2);
	assume SecMask_$_3 == SecMask_$_2;
	assume exhaleMask#_87_$_3 == exhaleMask#_87_$_2;
	if ($_$_condition_$24) { goto anon123_Then; } else { goto anon123_Else; }
anon124_Then:
	assume !(Heap_$_5[this,AVLTree.root] == null);
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 14.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 14.22 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_87_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_87_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_87_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_87_$_6 == exhaleMask#_87_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys := exhaleMask#_87_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys][perm$R := exhaleMask#_87_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_6 == SecMask_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys][perm$R := SecMask_$_5[Heap_$_5[this,AVLTree.root],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_87_$_6);
	assume wf(Heap_$_5,exhaleMask#_87_$_6,SecMask_$_6);
	assume wf(Heap_$_5,Mask_$_28,SecMask_$_6);
	assume SecMask_$_7 == SecMask_$_6;
	assume exhaleMask#_87_$_7 == exhaleMask#_87_$_6;
	if ($_$_condition_$27) { goto anon125_Then; } else { goto anon125_Else; }
anon124_Else:
	assume Heap_$_5[this,AVLTree.root] == null;
	assume SecMask_$_7 == SecMask_$_5;
	assume exhaleMask#_87_$_7 == exhaleMask#_87_$_5;
	if ($_$_condition_$28) { goto anon125_Then; } else { goto anon125_Else; }
anon125_Then:
	assume !(Heap_$_5[this,AVLTree.root] == null);
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 15.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 15.22 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_87_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_87_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_87_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_87_$_8 == exhaleMask#_87_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor := exhaleMask#_87_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_87_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_8 == SecMask_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := SecMask_$_7[Heap_$_5[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_87_$_8);
	assume wf(Heap_$_5,exhaleMask#_87_$_8,SecMask_$_8);
	assume wf(Heap_$_5,Mask_$_28,SecMask_$_8);
	assume exhaleMask#_87_$_9 == exhaleMask#_87_$_8;
	assume SecMask_$_9 == SecMask_$_8;
	goto anon65;
anon125_Else:
	assume Heap_$_5[this,AVLTree.root] == null;
	assume exhaleMask#_87_$_9 == exhaleMask#_87_$_7;
	assume SecMask_$_9 == SecMask_$_7;
	goto anon65;
anon65:
	assume IsGoodExhaleState(exhaleHeap#_86_$_0,Heap_$_5,exhaleMask#_87_$_9,SecMask_$_9);
	assume IsGoodMask(exhaleMask#_87_$_9);
	assume wf(exhaleHeap#_86_$_0,exhaleMask#_87_$_9,SecMask_$_9);
	assume !(this == null);
	assume wf(exhaleHeap#_86_$_0,exhaleMask#_87_$_9,SecMask_$_9);
	assume Fractions(100) > 0;
	assume Mask_$_29 == exhaleMask#_87_$_9[this,AVLTree.valid := exhaleMask#_87_$_9[this,AVLTree.valid][perm$R := exhaleMask#_87_$_9[this,AVLTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_29);
	assume IsGoodState(heapFragment(exhaleHeap#_86_$_0[this,AVLTree.valid]));
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_9);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_9);
	assume IsGoodMask(Mask_$_29);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_9);
	assume predVer#_83_$_0 == exhaleHeap#_86_$_0[this,AVLTree.valid];
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_9);
	assert { :msg "  35.2: The postcondition at 42.11 might not hold. The expression at 42.11 might not evaluate to true." } Seq#Contains(exhaleHeap#_86_$_0[this,AVLTree.keys],k#0);
	assert { :msg "  35.2: The postcondition at 43.11 might not hold. The expression at 43.11 might not evaluate to true." } (forall  j#73#125 : Integer :: ( ((0 <= j#73#125) && (j#73#125 < Seq#Length(Heap[this,AVLTree.keys]))) ==> Seq#Contains(exhaleHeap#_86_$_0[this,AVLTree.keys],Seq#Index(Heap[this,AVLTree.keys],j#73#125)) ));
	assert { :msg "  35.2: The postcondition at 44.11 might not hold. The expression at 44.11 might not evaluate to true." } (forall  j#74#126 : Integer :: ( ((0 <= j#74#126) && (j#74#126 < Seq#Length(exhaleHeap#_86_$_0[this,AVLTree.keys]))) ==> (Seq#Contains(Heap[this,AVLTree.keys],Seq#Index(exhaleHeap#_86_$_0[this,AVLTree.keys],j#74#126)) || (Seq#Index(exhaleHeap#_86_$_0[this,AVLTree.keys],j#74#126) == k#0)) ));
	assert { :msg "  35.2: The postcondition at 39.11 might not hold. The permission at 39.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  35.2: The postcondition at 39.11 might not hold. Insufficient fraction at 39.11 for AVLTree.valid." } (Fractions(100) <= Mask_$_29[this,AVLTree.valid][perm$R]) && ((Fractions(100) == Mask_$_29[this,AVLTree.valid][perm$R]) ==> (0 <= Mask_$_29[this,AVLTree.valid][perm$N]));
	assume exhaleMask#_95_$_0 == Mask_$_29[this,AVLTree.valid := Mask_$_29[this,AVLTree.valid][perm$R := Mask_$_29[this,AVLTree.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$29) { goto anon126_Then; } else { goto anon126_Else; }
anon126_Then:
	assume false || (((((predVer#_83_$_0 == exhaleHeap#_86_$_0[this,AVLTree.valid]) && (this == this)) && true) && (!cond#_52_$_0)) && true);
	if ($_$_condition_$30) { goto anon127_Then; } else { goto anon127_Else; }
anon126_Else:
	assume !(false || (((((predVer#_83_$_0 == exhaleHeap#_86_$_0[this,AVLTree.valid]) && (this == this)) && true) && (!cond#_52_$_0)) && true));
	assume SecMask_$_32 == SecMask_$_9;
	if ($_$_condition_$31) { goto anon139_Then; } else { goto anon139_Else; }
anon127_Then:
	assume !(exhaleHeap#_86_$_0[this,AVLTree.root] == null);
	assume Seq#Equal(exhaleHeap#_86_$_0[this,AVLTree.keys],exhaleHeap#_86_$_0[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$32) { goto anon128_Then; } else { goto anon128_Else; }
anon127_Else:
	assume exhaleHeap#_86_$_0[this,AVLTree.root] == null;
	if ($_$_condition_$33) { goto anon128_Then; } else { goto anon128_Else; }
anon139_Then:
	assume !CanRead(exhaleMask#_95_$_0,SecMask_$_32,this,AVLTree.valid);
	assume exhaleHeap#_86_$_0[this,AVLTree.valid] < exhaleHeap#_94_$_0[this,AVLTree.valid];
	goto anon93;
anon139_Else:
	assume CanRead(exhaleMask#_95_$_0,SecMask_$_32,this,AVLTree.valid);
	goto anon93;
anon128_Then:
	assume exhaleHeap#_86_$_0[this,AVLTree.root] == null;
	assume Seq#Equal(exhaleHeap#_86_$_0[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon70;
anon128_Else:
	assume !(exhaleHeap#_86_$_0[this,AVLTree.root] == null);
	goto anon70;
anon70:
	assume SecMask_$_10 == SecMask_$_9[this,AVLTree.root := SecMask_$_9[this,AVLTree.root][perm$R := SecMask_$_9[this,AVLTree.root][perm$R] - Fractions(100)]];
	if ($_$_condition_$34) { goto anon129_Then; } else { goto anon129_Else; }
anon129_Then:
	assume SecMask_$_10[this,AVLTree.root][perm$R] < 0;
	assume SecMask_$_11 == SecMask_$_10[this,AVLTree.root := SecMask_$_10[this,AVLTree.root][perm$R := 0]];
	assume SecMask_$_12 == SecMask_$_11;
	goto anon72;
anon129_Else:
	assume 0 <= SecMask_$_10[this,AVLTree.root][perm$R];
	assume SecMask_$_12 == SecMask_$_10;
	goto anon72;
anon72:
	assume wf(exhaleHeap#_86_$_0,SecMask_$_12,SecMask_$_12);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_12);
	assume SecMask_$_13 == SecMask_$_12[this,AVLTree.keys := SecMask_$_12[this,AVLTree.keys][perm$R := SecMask_$_12[this,AVLTree.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$35) { goto anon130_Then; } else { goto anon130_Else; }
anon130_Then:
	assume SecMask_$_13[this,AVLTree.keys][perm$R] < 0;
	assume SecMask_$_14 == SecMask_$_13[this,AVLTree.keys := SecMask_$_13[this,AVLTree.keys][perm$R := 0]];
	assume SecMask_$_15 == SecMask_$_14;
	goto anon74;
anon130_Else:
	assume 0 <= SecMask_$_13[this,AVLTree.keys][perm$R];
	assume SecMask_$_15 == SecMask_$_13;
	goto anon74;
anon74:
	assume wf(exhaleHeap#_86_$_0,SecMask_$_15,SecMask_$_15);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_15);
	if ($_$_condition_$36) { goto anon131_Then; } else { goto anon131_Else; }
anon131_Then:
	assume !(exhaleHeap#_86_$_0[this,AVLTree.root] == null);
	assume SecMask_$_16 == SecMask_$_15[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_15[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_15[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$37) { goto anon132_Then; } else { goto anon132_Else; }
anon131_Else:
	assume exhaleHeap#_86_$_0[this,AVLTree.root] == null;
	assume SecMask_$_19 == SecMask_$_15;
	if ($_$_condition_$38) { goto anon133_Then; } else { goto anon133_Else; }
anon132_Then:
	assume SecMask_$_16[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_17 == SecMask_$_16[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_16[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_18 == SecMask_$_17;
	goto anon77;
anon132_Else:
	assume 0 <= SecMask_$_16[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R];
	assume SecMask_$_18 == SecMask_$_16;
	goto anon77;
anon133_Then:
	assume !(exhaleHeap#_86_$_0[this,AVLTree.root] == null);
	assume SecMask_$_20 == SecMask_$_19[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_19[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := SecMask_$_19[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$40) { goto anon134_Then; } else { goto anon134_Else; }
anon133_Else:
	assume exhaleHeap#_86_$_0[this,AVLTree.root] == null;
	assume SecMask_$_23 == SecMask_$_19;
	if ($_$_condition_$41) { goto anon135_Then; } else { goto anon135_Else; }
anon77:
	assume wf(exhaleHeap#_86_$_0,SecMask_$_18,SecMask_$_18);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_18);
	assume SecMask_$_19 == SecMask_$_18;
	if ($_$_condition_$39) { goto anon133_Then; } else { goto anon133_Else; }
anon134_Then:
	assume SecMask_$_20[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_21 == SecMask_$_20[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_20[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_22 == SecMask_$_21;
	goto anon81;
anon134_Else:
	assume 0 <= SecMask_$_20[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R];
	assume SecMask_$_22 == SecMask_$_20;
	goto anon81;
anon135_Then:
	assume !(exhaleHeap#_86_$_0[this,AVLTree.root] == null);
	assume SecMask_$_24 == SecMask_$_23[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_23[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := SecMask_$_23[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$43) { goto anon136_Then; } else { goto anon136_Else; }
anon135_Else:
	assume exhaleHeap#_86_$_0[this,AVLTree.root] == null;
	assume SecMask_$_27 == SecMask_$_23;
	if ($_$_condition_$44) { goto anon137_Then; } else { goto anon137_Else; }
anon81:
	assume wf(exhaleHeap#_86_$_0,SecMask_$_22,SecMask_$_22);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_22);
	assume SecMask_$_23 == SecMask_$_22;
	if ($_$_condition_$42) { goto anon135_Then; } else { goto anon135_Else; }
anon136_Then:
	assume SecMask_$_24[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_25 == SecMask_$_24[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_24[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_26 == SecMask_$_25;
	goto anon85;
anon136_Else:
	assume 0 <= SecMask_$_24[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R];
	assume SecMask_$_26 == SecMask_$_24;
	goto anon85;
anon137_Then:
	assume !(exhaleHeap#_86_$_0[this,AVLTree.root] == null);
	assume SecMask_$_28 == SecMask_$_27[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_27[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := SecMask_$_27[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$46) { goto anon138_Then; } else { goto anon138_Else; }
anon137_Else:
	assume exhaleHeap#_86_$_0[this,AVLTree.root] == null;
	assume SecMask_$_31 == SecMask_$_27;
	goto anon90;
anon85:
	assume wf(exhaleHeap#_86_$_0,SecMask_$_26,SecMask_$_26);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_26);
	assume SecMask_$_27 == SecMask_$_26;
	if ($_$_condition_$45) { goto anon137_Then; } else { goto anon137_Else; }
anon138_Then:
	assume SecMask_$_28[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_28[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon89;
anon138_Else:
	assume 0 <= SecMask_$_28[exhaleHeap#_86_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon89;
anon90:
	assume wf(exhaleHeap#_86_$_0,SecMask_$_31,SecMask_$_31);
	assume SecMask_$_32 == SecMask_$_31;
	if ($_$_condition_$47) { goto anon139_Then; } else { goto anon139_Else; }
anon89:
	assume wf(exhaleHeap#_86_$_0,SecMask_$_30,SecMask_$_30);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30;
	goto anon90;
anon93:
	assume IsGoodMask(exhaleMask#_95_$_0);
	assume wf(exhaleHeap#_86_$_0,exhaleMask#_95_$_0,SecMask_$_32);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_32);
	assert { :msg "  35.2: The postcondition at 40.11 might not hold. The permission at 40.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  35.2: The postcondition at 40.11 might not hold. Insufficient fraction at 40.11 for AVLTree.keys." } (Fractions(50) <= exhaleMask#_95_$_0[this,AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_95_$_0[this,AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_95_$_0[this,AVLTree.keys][perm$N]));
	assume exhaleMask#_95_$_1 == exhaleMask#_95_$_0[this,AVLTree.keys := exhaleMask#_95_$_0[this,AVLTree.keys][perm$R := exhaleMask#_95_$_0[this,AVLTree.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_95_$_1);
	assume wf(exhaleHeap#_86_$_0,exhaleMask#_95_$_1,SecMask_$_32);
	assume wf(exhaleHeap#_86_$_0,Mask_$_29,SecMask_$_32);
	assume IsGoodExhaleState(exhaleHeap#_94_$_0,exhaleHeap#_86_$_0,exhaleMask#_95_$_1,SecMask_$_32);
	assume IsGoodMask(exhaleMask#_95_$_1);
	assume wf(exhaleHeap#_94_$_0,exhaleMask#_95_$_1,SecMask_$_32);
	assert { :msg "  35.2: Method might lock/unlock more than allowed." } (forall  lk#_106 : ref :: {exhaleHeap#_94_$_0[lk#_106,held]} {exhaleHeap#_94_$_0[lk#_106,rdheld]} ( (((0 < exhaleHeap#_94_$_0[lk#_106,held]) <==> (0 < Heap[lk#_106,held])) && (exhaleHeap#_94_$_0[lk#_106,rdheld] <==> Heap[lk#_106,rdheld])) || false ));
	assert { :msg "  35.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
