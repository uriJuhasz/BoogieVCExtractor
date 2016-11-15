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
procedure AVLTree.remove (this : ref,k#3 : int)
{
	var methodK#_107 : int;
	var unfoldK#_108 : int;
	var oldVers#_120 : int;
	var newVers#_121 : int;
	var cond#_122 : bool;
	var methodCallK#_127 : int;
	var this#133 : ref;
	var k#134 : int;
	var r#135 : ref;
	var callHeap#_123 : HeapType;
	var callMask#_124 : MaskType;
	var callSecMask#_125 : MaskType;
	var callCredits#_126 : CreditsType;
	var exhaleMask#_129 : MaskType;
	var exhaleHeap#_128 : HeapType;
	var r#78 : ref;
	var foldK#_139 : int;
	var exhaleMask#_141 : MaskType;
	var exhaleHeap#_140 : HeapType;
	var predRec#_136 : ref;
	var predVer#_137 : int;
	var predFlag#_138 : bool;
	var exhaleMask#_149 : MaskType;
	var exhaleHeap#_148 : HeapType;
	var Mask_$_0 : MaskType;
	var Mask_$_1 : MaskType;
	var Mask_$_2 : MaskType;
	var oldVers#_120_$_0 : int;
	var newVers#_121_$_0 : int;
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
	var cond#_122_$_0 : bool;
	var this#133_$_0 : ref;
	var exhaleHeap#_128_$_0 : HeapType;
	var exhaleMask#_129_$_0 : MaskType;
	var exhaleMask#_129_$_1 : MaskType;
	var exhaleMask#_129_$_2 : MaskType;
	var exhaleMask#_129_$_3 : MaskType;
	var r#135_$_0 : ref;
	var Mask_$_13 : MaskType;
	var Mask_$_14 : MaskType;
	var Mask_$_15 : MaskType;
	var Mask_$_16 : MaskType;
	var Mask_$_17 : MaskType;
	var Mask_$_18 : MaskType;
	var Mask_$_19 : MaskType;
	var Mask_$_20 : MaskType;
	var Heap_$_2 : HeapType;
	var Heap_$_3 : HeapType;
	var Mask_$_21 : MaskType;
	var Heap_$_4 : HeapType;
	var exhaleHeap#_140_$_0 : HeapType;
	var exhaleMask#_141_$_0 : MaskType;
	var SecMask_$_0 : MaskType;
	var exhaleMask#_141_$_1 : MaskType;
	var SecMask_$_1 : MaskType;
	var exhaleMask#_141_$_2 : MaskType;
	var SecMask_$_2 : MaskType;
	var SecMask_$_3 : MaskType;
	var exhaleMask#_141_$_3 : MaskType;
	var exhaleMask#_141_$_4 : MaskType;
	var SecMask_$_4 : MaskType;
	var exhaleMask#_141_$_5 : MaskType;
	var SecMask_$_5 : MaskType;
	var exhaleMask#_141_$_6 : MaskType;
	var SecMask_$_6 : MaskType;
	var SecMask_$_7 : MaskType;
	var exhaleMask#_141_$_7 : MaskType;
	var exhaleMask#_141_$_8 : MaskType;
	var SecMask_$_8 : MaskType;
	var exhaleMask#_141_$_9 : MaskType;
	var SecMask_$_9 : MaskType;
	var Mask_$_22 : MaskType;
	var predVer#_137_$_0 : int;
	var exhaleHeap#_148_$_0 : HeapType;
	var exhaleMask#_149_$_0 : MaskType;
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
	var exhaleMask#_149_$_1 : MaskType;
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
	assume (this#133 == null) || (dtype(this#133) == AVLTreeNode#t);
	assume true;
	assume (r#135 == null) || (dtype(r#135) == AVLTreeNode#t);
	assume (r#78 == null) || (dtype(r#78) == AVLTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_107) && ((1000 * methodK#_107) < Fractions(1));
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
	assume ((0 < unfoldK#_108) && (unfoldK#_108 < Fractions(1))) && ((1000 * unfoldK#_108) < methodK#_107);
	assert { :msg "  71.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  71.3: unfold might fail because the predicate AVLTree.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  71.3: unfold might fail because the predicate AVLTree.valid does not hold. Insufficient fraction at <undefined position> for AVLTree.valid." } (Fractions(100) <= Mask_$_1[this,AVLTree.valid][perm$R]) && ((Fractions(100) == Mask_$_1[this,AVLTree.valid][perm$R]) ==> (0 <= Mask_$_1[this,AVLTree.valid][perm$N]));
	assume Mask_$_2 == Mask_$_1[this,AVLTree.valid := Mask_$_1[this,AVLTree.valid][perm$R := Mask_$_1[this,AVLTree.valid][perm$R] - Fractions(100)]];
	if ($_$_condition) { goto anon122_Then; } else { goto anon122_Else; }
anon122_Then:
	assume false;
	goto $exit;
anon122_Else:
	assume !false;
	if ($_$_condition_$0) { goto anon135_Then; } else { goto anon135_Else; }
anon135_Then:
	assume !CanRead(Mask_$_2,ZeroMask,this,AVLTree.valid);
	assume oldVers#_120_$_0 == Heap[this,AVLTree.valid];
	assume Heap_$_0 == Heap[this,AVLTree.valid := newVers#_121_$_0];
	assume oldVers#_120_$_0 < Heap_$_0[this,AVLTree.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon28;
anon135_Else:
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
	if ($_$_condition_$1) { goto anon136_Then; } else { goto anon136_Else; }
anon136_Then:
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
	if ($_$_condition_$2) { goto anon137_Then; } else { goto anon137_Else; }
anon136_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_6 == Mask_$_4;
	if ($_$_condition_$3) { goto anon137_Then; } else { goto anon137_Else; }
anon137_Then:
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
	if ($_$_condition_$4) { goto anon138_Then; } else { goto anon138_Else; }
anon137_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_8 == Mask_$_6;
	if ($_$_condition_$5) { goto anon138_Then; } else { goto anon138_Else; }
anon138_Then:
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
	if ($_$_condition_$6) { goto anon139_Then; } else { goto anon139_Else; }
anon138_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_10 == Mask_$_8;
	if ($_$_condition_$7) { goto anon139_Then; } else { goto anon139_Else; }
anon139_Then:
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
	if ($_$_condition_$8) { goto anon140_Then; } else { goto anon140_Else; }
anon139_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Mask_$_12 == Mask_$_10;
	if ($_$_condition_$9) { goto anon140_Then; } else { goto anon140_Else; }
anon140_Then:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assume Seq#Equal(Heap_$_1[this,AVLTree.keys],Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$10) { goto anon141_Then; } else { goto anon141_Else; }
anon140_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	if ($_$_condition_$11) { goto anon141_Then; } else { goto anon141_Else; }
anon141_Then:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume Seq#Equal(Heap_$_1[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon40;
anon141_Else:
	assume !(Heap_$_1[this,AVLTree.root] == null);
	goto anon40;
anon40:
	assume IsGoodMask(Mask_$_12);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assume cond#_122_$_0 <==> (Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  72.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  72.7: Location might not be readable." } true ==> CanRead(Mask_$_12,ZeroMask,this,AVLTree.root);
	if ($_$_condition_$12) { goto anon142_Then; } else { goto anon142_Else; }
anon142_Then:
	assume cond#_122_$_0;
	assume Mask_$_21 == Mask_$_12;
	assume Heap_$_4 == Heap_$_1;
	goto anon79;
anon142_Else:
	assume !cond#_122_$_0;
	assume ((0 < methodCallK#_127) && ((1000 * methodCallK#_127) < Fractions(1))) && ((1000 * methodCallK#_127) < methodK#_107);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  74.14: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  74.14: Location might not be readable." } true ==> CanRead(Mask_$_12,ZeroMask,this,AVLTree.root);
	assert { :msg "  74.4: The target of the method call might be null." } !(Heap_$_1[this,AVLTree.root] == null);
	assume this#133_$_0 == Heap_$_1[this,AVLTree.root];
	assert { :msg "  74.4: The precondition at 254.12 might not hold. The permission at 254.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  74.4: The precondition at 254.12 might not hold. Insufficient fraction at 254.12 for AVLTreeNode.valid." } (Fractions(100) <= Mask_$_12[this#133_$_0,AVLTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_12[this#133_$_0,AVLTreeNode.valid][perm$R]) ==> (0 <= Mask_$_12[this#133_$_0,AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_129_$_0 == Mask_$_12[this#133_$_0,AVLTreeNode.valid := Mask_$_12[this#133_$_0,AVLTreeNode.valid][perm$R := Mask_$_12[this#133_$_0,AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$13) { goto anon143_Then; } else { goto anon143_Else; }
anon79:
	assume #AVLTree.valid#trigger(this);
	assume ((0 < foldK#_139) && ((1000 * foldK#_139) < Fractions(1))) && ((1000 * foldK#_139) < methodK#_107);
	assert { :msg "  78.3: The target of the fold statement might be null." } !(this == null);
	if ($_$_condition_$46) { goto anon161_Then; } else { goto anon161_Else; }
anon143_Then:
	assume !CanRead(exhaleMask#_129_$_0,ZeroMask,this#133_$_0,AVLTreeNode.valid);
	assume Heap_$_1[this#133_$_0,AVLTreeNode.valid] < exhaleHeap#_128_$_0[this#133_$_0,AVLTreeNode.valid];
	goto anon44;
anon143_Else:
	assume CanRead(exhaleMask#_129_$_0,ZeroMask,this#133_$_0,AVLTreeNode.valid);
	goto anon44;
anon44:
	assume IsGoodMask(exhaleMask#_129_$_0);
	assume wf(Heap_$_1,exhaleMask#_129_$_0,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  74.4: The precondition at 255.12 might not hold. The permission at 255.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  74.4: The precondition at 255.12 might not hold. Insufficient fraction at 255.12 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_129_$_0[this#133_$_0,AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_129_$_0[this#133_$_0,AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_129_$_0[this#133_$_0,AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_129_$_1 == exhaleMask#_129_$_0[this#133_$_0,AVLTreeNode.keys := exhaleMask#_129_$_0[this#133_$_0,AVLTreeNode.keys][perm$R := exhaleMask#_129_$_0[this#133_$_0,AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_129_$_1);
	assume wf(Heap_$_1,exhaleMask#_129_$_1,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  74.4: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  74.4: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_129_$_1[this#133_$_0,AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_129_$_1[this#133_$_0,AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_129_$_1[this#133_$_0,AVLTreeNode.height][perm$N]));
	assume exhaleMask#_129_$_2 == exhaleMask#_129_$_1[this#133_$_0,AVLTreeNode.height := exhaleMask#_129_$_1[this#133_$_0,AVLTreeNode.height][perm$R := exhaleMask#_129_$_1[this#133_$_0,AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_129_$_2);
	assume wf(Heap_$_1,exhaleMask#_129_$_2,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assert { :msg "  74.4: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive." } Fractions(50) > 0;
	assert { :msg "  74.4: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_129_$_2[this#133_$_0,AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_129_$_2[this#133_$_0,AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_129_$_2[this#133_$_0,AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_129_$_3 == exhaleMask#_129_$_2[this#133_$_0,AVLTreeNode.balanceFactor := exhaleMask#_129_$_2[this#133_$_0,AVLTreeNode.balanceFactor][perm$R := exhaleMask#_129_$_2[this#133_$_0,AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_129_$_3);
	assume wf(Heap_$_1,exhaleMask#_129_$_3,ZeroMask);
	assume wf(Heap_$_1,Mask_$_12,ZeroMask);
	assume IsGoodExhaleState(exhaleHeap#_128_$_0,Heap_$_1,exhaleMask#_129_$_3,ZeroMask);
	assume IsGoodMask(exhaleMask#_129_$_3);
	assume wf(exhaleHeap#_128_$_0,exhaleMask#_129_$_3,ZeroMask);
	assume (r#135_$_0 == null) || (dtype(r#135_$_0) == AVLTreeNode#t);
	if ($_$_condition_$14) { goto anon144_Then; } else { goto anon144_Else; }
anon144_Then:
	assume Seq#Equal(Heap_$_1[this#133_$_0,AVLTreeNode.keys],Seq#Singleton(k#3));
	assume r#135_$_0 == null;
	if ($_$_condition_$15) { goto anon145_Then; } else { goto anon145_Else; }
anon144_Else:
	assume !Seq#Equal(Heap_$_1[this#133_$_0,AVLTreeNode.keys],Seq#Singleton(k#3));
	if ($_$_condition_$16) { goto anon145_Then; } else { goto anon145_Else; }
anon145_Then:
	assume !Seq#Equal(Heap_$_1[this#133_$_0,AVLTreeNode.keys],Seq#Singleton(k#3));
	assume !(r#135_$_0 == null);
	if ($_$_condition_$17) { goto anon146_Then; } else { goto anon146_Else; }
anon145_Else:
	assume Seq#Equal(Heap_$_1[this#133_$_0,AVLTreeNode.keys],Seq#Singleton(k#3));
	if ($_$_condition_$18) { goto anon146_Then; } else { goto anon146_Else; }
anon146_Then:
	assume !(r#135_$_0 == null);
	assume !(r#135_$_0 == null);
	assume wf(exhaleHeap#_128_$_0,exhaleMask#_129_$_3,ZeroMask);
	assume Fractions(100) > 0;
	assume Mask_$_13 == exhaleMask#_129_$_3[r#135_$_0,AVLTreeNode.valid := exhaleMask#_129_$_3[r#135_$_0,AVLTreeNode.valid][perm$R := exhaleMask#_129_$_3[r#135_$_0,AVLTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_13);
	assume IsGoodState(heapFragment(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.valid]));
	assume wf(exhaleHeap#_128_$_0,Mask_$_13,ZeroMask);
	assume wf(exhaleHeap#_128_$_0,Mask_$_13,ZeroMask);
	assume Mask_$_14 == Mask_$_13;
	if ($_$_condition_$19) { goto anon147_Then; } else { goto anon147_Else; }
anon146_Else:
	assume r#135_$_0 == null;
	assume Mask_$_14 == exhaleMask#_129_$_3;
	if ($_$_condition_$20) { goto anon147_Then; } else { goto anon147_Else; }
anon147_Then:
	assume !(r#135_$_0 == null);
	assume !(r#135_$_0 == null);
	assume wf(exhaleHeap#_128_$_0,Mask_$_14,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_15 == Mask_$_14[r#135_$_0,AVLTreeNode.keys := Mask_$_14[r#135_$_0,AVLTreeNode.keys][perm$R := Mask_$_14[r#135_$_0,AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_15);
	assume IsGoodState(heapFragment(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys]));
	assume wf(exhaleHeap#_128_$_0,Mask_$_15,ZeroMask);
	assume wf(exhaleHeap#_128_$_0,Mask_$_15,ZeroMask);
	assume Mask_$_16 == Mask_$_15;
	if ($_$_condition_$21) { goto anon148_Then; } else { goto anon148_Else; }
anon147_Else:
	assume r#135_$_0 == null;
	assume Mask_$_16 == Mask_$_14;
	if ($_$_condition_$22) { goto anon148_Then; } else { goto anon148_Else; }
anon148_Then:
	assume !(r#135_$_0 == null);
	assume !(r#135_$_0 == null);
	assume wf(exhaleHeap#_128_$_0,Mask_$_16,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_17 == Mask_$_16[r#135_$_0,AVLTreeNode.height := Mask_$_16[r#135_$_0,AVLTreeNode.height][perm$R := Mask_$_16[r#135_$_0,AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(heapFragment(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.height]));
	assume wf(exhaleHeap#_128_$_0,Mask_$_17,ZeroMask);
	assume wf(exhaleHeap#_128_$_0,Mask_$_17,ZeroMask);
	assume Mask_$_18 == Mask_$_17;
	if ($_$_condition_$23) { goto anon149_Then; } else { goto anon149_Else; }
anon148_Else:
	assume r#135_$_0 == null;
	assume Mask_$_18 == Mask_$_16;
	if ($_$_condition_$24) { goto anon149_Then; } else { goto anon149_Else; }
anon149_Then:
	assume !(r#135_$_0 == null);
	assume !(r#135_$_0 == null);
	assume wf(exhaleHeap#_128_$_0,Mask_$_18,ZeroMask);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_19 == Mask_$_18[r#135_$_0,AVLTreeNode.balanceFactor := Mask_$_18[r#135_$_0,AVLTreeNode.balanceFactor][perm$R := Mask_$_18[r#135_$_0,AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.balanceFactor]));
	assume wf(exhaleHeap#_128_$_0,Mask_$_19,ZeroMask);
	assume wf(exhaleHeap#_128_$_0,Mask_$_19,ZeroMask);
	assume Mask_$_20 == Mask_$_19;
	if ($_$_condition_$25) { goto anon150_Then; } else { goto anon150_Else; }
anon149_Else:
	assume r#135_$_0 == null;
	assume Mask_$_20 == Mask_$_18;
	if ($_$_condition_$26) { goto anon150_Then; } else { goto anon150_Else; }
anon150_Then:
	assume !(r#135_$_0 == null);
	assume !Seq#Contains(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys],k#3);
	if ($_$_condition_$27) { goto anon151_Then; } else { goto anon151_Else; }
anon150_Else:
	assume r#135_$_0 == null;
	if ($_$_condition_$28) { goto anon151_Then; } else { goto anon151_Else; }
anon151_Then:
	assume !(r#135_$_0 == null);
	assume (forall  i#84#136 : Integer :: ( ((0 <= i#84#136) && (i#84#136 < Seq#Length(Heap_$_1[this#133_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys],Seq#Index(Heap_$_1[this#133_$_0,AVLTreeNode.keys],i#84#136)) || (Seq#Index(Heap_$_1[this#133_$_0,AVLTreeNode.keys],i#84#136) == k#3)) ));
	if ($_$_condition_$29) { goto anon152_Then; } else { goto anon152_Else; }
anon151_Else:
	assume r#135_$_0 == null;
	if ($_$_condition_$30) { goto anon152_Then; } else { goto anon152_Else; }
anon152_Then:
	assume !(r#135_$_0 == null);
	assume (forall  i#85#137 : Integer :: ( ((0 <= i#85#137) && (i#85#137 < Seq#Length(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys]))) ==> (Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],Seq#Index(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys],i#85#137)) && (!(Seq#Index(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys],i#85#137) == k#3))) ));
	if ($_$_condition_$31) { goto anon153_Then; } else { goto anon153_Else; }
anon152_Else:
	assume r#135_$_0 == null;
	if ($_$_condition_$32) { goto anon153_Then; } else { goto anon153_Else; }
anon153_Then:
	assume !Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	assume !(r#135_$_0 == null);
	if ($_$_condition_$33) { goto anon154_Then; } else { goto anon154_Else; }
anon153_Else:
	assume Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	if ($_$_condition_$34) { goto anon154_Then; } else { goto anon154_Else; }
anon154_Then:
	assume !Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	assume Seq#Equal(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys],Heap_$_1[this#133_$_0,AVLTreeNode.keys]);
	if ($_$_condition_$35) { goto anon155_Then; } else { goto anon155_Else; }
anon154_Else:
	assume Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	if ($_$_condition_$36) { goto anon155_Then; } else { goto anon155_Else; }
anon155_Then:
	assume !(r#135_$_0 == null);
	if ($_$_condition_$37) { goto anon156_Then; } else { goto anon156_Else; }
anon155_Else:
	assume r#135_$_0 == null;
	if ($_$_condition_$38) { goto anon157_Then; } else { goto anon157_Else; }
anon156_Then:
	assume Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	assume Seq#Length(exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.keys]) == (Seq#Length(Heap_$_1[this#133_$_0,AVLTreeNode.keys]) - 1);
	if ($_$_condition_$39) { goto anon157_Then; } else { goto anon157_Else; }
anon156_Else:
	assume !Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	if ($_$_condition_$40) { goto anon157_Then; } else { goto anon157_Else; }
anon157_Then:
	assume Heap_$_1[this#133_$_0,AVLTreeNode.height] > 1;
	assume !(r#135_$_0 == null);
	if ($_$_condition_$41) { goto anon158_Then; } else { goto anon158_Else; }
anon157_Else:
	assume 1 >= Heap_$_1[this#133_$_0,AVLTreeNode.height];
	if ($_$_condition_$42) { goto anon158_Then; } else { goto anon158_Else; }
anon158_Then:
	assume !(r#135_$_0 == null);
	assume (exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.height] == Heap_$_1[this#133_$_0,AVLTreeNode.height]) || ((exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.height] + 1) == Heap_$_1[this#133_$_0,AVLTreeNode.height]);
	if ($_$_condition_$43) { goto anon159_Then; } else { goto anon159_Else; }
anon158_Else:
	assume r#135_$_0 == null;
	if ($_$_condition_$44) { goto anon159_Then; } else { goto anon159_Else; }
anon159_Then:
	assume !Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	assume exhaleHeap#_128_$_0[r#135_$_0,AVLTreeNode.height] == Heap_$_1[this#133_$_0,AVLTreeNode.height];
	goto anon75;
anon159_Else:
	assume Seq#Contains(Heap_$_1[this#133_$_0,AVLTreeNode.keys],k#3);
	goto anon75;
anon75:
	assume IsGoodMask(Mask_$_20);
	assume wf(exhaleHeap#_128_$_0,Mask_$_20,ZeroMask);
	assert { :msg "  75.4: Location might not be writable" } CanWrite(Mask_$_20,this,AVLTree.root);
	assume Heap_$_2 == exhaleHeap#_128_$_0[this,AVLTree.root := r#135_$_0];
	assume wf(Heap_$_2,Mask_$_20,ZeroMask);
	assert { :msg "  76.4: Location might not be writable" } CanWrite(Mask_$_20,this,AVLTree.keys);
	assert { :msg "  76.13: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  76.13: Location might not be readable." } true ==> CanRead(Mask_$_20,ZeroMask,this,AVLTree.root);
	if ($_$_condition_$45) { goto anon160_Then; } else { goto anon160_Else; }
anon160_Then:
	assume Heap_$_2[this,AVLTree.root] == null;
	goto anon78;
anon160_Else:
	assume !(Heap_$_2[this,AVLTree.root] == null);
	assert { :msg "  76.33: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  76.33: Location might not be readable." } true ==> CanRead(Mask_$_20,ZeroMask,this,AVLTree.root);
	assert { :msg "  76.33: Receiver might be null." } true ==> (!(Heap_$_2[this,AVLTree.root] == null));
	assert { :msg "  76.33: Location might not be readable." } true ==> CanRead(Mask_$_20,ZeroMask,Heap_$_2[this,AVLTree.root],AVLTreeNode.keys);
	goto anon78;
anon78:
	assume Heap_$_3 == Heap_$_2[this,AVLTree.keys := ite(Heap_$_2[this,AVLTree.root] == null,(Seq#Empty() : Seq (Integer) ),Heap_$_2[Heap_$_2[this,AVLTree.root],AVLTreeNode.keys])];
	assume wf(Heap_$_3,Mask_$_20,ZeroMask);
	assume Mask_$_21 == Mask_$_20;
	assume Heap_$_4 == Heap_$_3;
	goto anon79;
anon161_Then:
	assume !(Heap_$_4[this,AVLTree.root] == null);
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true." } Seq#Equal(Heap_$_4[this,AVLTree.keys],Heap_$_4[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$47) { goto anon162_Then; } else { goto anon162_Else; }
anon161_Else:
	assume Heap_$_4[this,AVLTree.root] == null;
	if ($_$_condition_$48) { goto anon162_Then; } else { goto anon162_Else; }
anon162_Then:
	assume Heap_$_4[this,AVLTree.root] == null;
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 17.22 might not evaluate to true." } Seq#Equal(Heap_$_4[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon83;
anon162_Else:
	assume !(Heap_$_4[this,AVLTree.root] == null);
	goto anon83;
anon83:
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 10.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 10.6 for AVLTree.root." } (Fractions(100) <= Mask_$_21[this,AVLTree.root][perm$R]) && ((Fractions(100) == Mask_$_21[this,AVLTree.root][perm$R]) ==> (0 <= Mask_$_21[this,AVLTree.root][perm$N]));
	assume exhaleMask#_141_$_0 == Mask_$_21[this,AVLTree.root := Mask_$_21[this,AVLTree.root][perm$R := Mask_$_21[this,AVLTree.root][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_0 == ZeroMask[this,AVLTree.root := ZeroMask[this,AVLTree.root][perm$R := ZeroMask[this,AVLTree.root][perm$R] + Fractions(100)]];
	assume IsGoodMask(exhaleMask#_141_$_0);
	assume wf(Heap_$_4,exhaleMask#_141_$_0,SecMask_$_0);
	assume wf(Heap_$_4,Mask_$_21,SecMask_$_0);
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 11.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 11.6 for AVLTree.keys." } (Fractions(50) <= exhaleMask#_141_$_0[this,AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_141_$_0[this,AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_141_$_0[this,AVLTree.keys][perm$N]));
	assume exhaleMask#_141_$_1 == exhaleMask#_141_$_0[this,AVLTree.keys := exhaleMask#_141_$_0[this,AVLTree.keys][perm$R := exhaleMask#_141_$_0[this,AVLTree.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_1 == SecMask_$_0[this,AVLTree.keys := SecMask_$_0[this,AVLTree.keys][perm$R := SecMask_$_0[this,AVLTree.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_141_$_1);
	assume wf(Heap_$_4,exhaleMask#_141_$_1,SecMask_$_1);
	assume wf(Heap_$_4,Mask_$_21,SecMask_$_1);
	if ($_$_condition_$49) { goto anon163_Then; } else { goto anon163_Else; }
anon163_Then:
	assume !(Heap_$_4[this,AVLTree.root] == null);
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 12.22 might not be positive." } Fractions(100) > 0;
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_141_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_141_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_141_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_141_$_2 == exhaleMask#_141_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid := exhaleMask#_141_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid][perm$R := exhaleMask#_141_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_2 == SecMask_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_1[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$50) { goto anon164_Then; } else { goto anon164_Else; }
anon163_Else:
	assume Heap_$_4[this,AVLTree.root] == null;
	assume SecMask_$_3 == SecMask_$_1;
	assume exhaleMask#_141_$_3 == exhaleMask#_141_$_1;
	if ($_$_condition_$51) { goto anon165_Then; } else { goto anon165_Else; }
anon164_Then:
	assume !CanRead(exhaleMask#_141_$_2,SecMask_$_2,Heap_$_4[this,AVLTree.root],AVLTreeNode.valid);
	assume Heap_$_4[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid] < exhaleHeap#_140_$_0[Heap_$_4[this,AVLTree.root],AVLTreeNode.valid];
	goto anon86;
anon164_Else:
	assume CanRead(exhaleMask#_141_$_2,SecMask_$_2,Heap_$_4[this,AVLTree.root],AVLTreeNode.valid);
	goto anon86;
anon165_Then:
	assume !(Heap_$_4[this,AVLTree.root] == null);
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 13.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 13.22 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_141_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_141_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_141_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_141_$_4 == exhaleMask#_141_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height := exhaleMask#_141_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height][perm$R := exhaleMask#_141_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_4 == SecMask_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height := SecMask_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height][perm$R := SecMask_$_3[Heap_$_4[this,AVLTree.root],AVLTreeNode.height][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_141_$_4);
	assume wf(Heap_$_4,exhaleMask#_141_$_4,SecMask_$_4);
	assume wf(Heap_$_4,Mask_$_21,SecMask_$_4);
	assume exhaleMask#_141_$_5 == exhaleMask#_141_$_4;
	assume SecMask_$_5 == SecMask_$_4;
	if ($_$_condition_$53) { goto anon166_Then; } else { goto anon166_Else; }
anon165_Else:
	assume Heap_$_4[this,AVLTree.root] == null;
	assume exhaleMask#_141_$_5 == exhaleMask#_141_$_3;
	assume SecMask_$_5 == SecMask_$_3;
	if ($_$_condition_$54) { goto anon166_Then; } else { goto anon166_Else; }
anon86:
	assume IsGoodMask(exhaleMask#_141_$_2);
	assume wf(Heap_$_4,exhaleMask#_141_$_2,SecMask_$_2);
	assume wf(Heap_$_4,Mask_$_21,SecMask_$_2);
	assume SecMask_$_3 == SecMask_$_2;
	assume exhaleMask#_141_$_3 == exhaleMask#_141_$_2;
	if ($_$_condition_$52) { goto anon165_Then; } else { goto anon165_Else; }
anon166_Then:
	assume !(Heap_$_4[this,AVLTree.root] == null);
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 14.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 14.22 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_141_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_141_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_141_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_141_$_6 == exhaleMask#_141_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys := exhaleMask#_141_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys][perm$R := exhaleMask#_141_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_6 == SecMask_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys][perm$R := SecMask_$_5[Heap_$_4[this,AVLTree.root],AVLTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_141_$_6);
	assume wf(Heap_$_4,exhaleMask#_141_$_6,SecMask_$_6);
	assume wf(Heap_$_4,Mask_$_21,SecMask_$_6);
	assume SecMask_$_7 == SecMask_$_6;
	assume exhaleMask#_141_$_7 == exhaleMask#_141_$_6;
	if ($_$_condition_$55) { goto anon167_Then; } else { goto anon167_Else; }
anon166_Else:
	assume Heap_$_4[this,AVLTree.root] == null;
	assume SecMask_$_7 == SecMask_$_5;
	assume exhaleMask#_141_$_7 == exhaleMask#_141_$_5;
	if ($_$_condition_$56) { goto anon167_Then; } else { goto anon167_Else; }
anon167_Then:
	assume !(Heap_$_4[this,AVLTree.root] == null);
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 15.22 might not be positive." } Fractions(50) > 0;
	assert { :msg "  78.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 15.22 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_141_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_141_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_141_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_141_$_8 == exhaleMask#_141_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor := exhaleMask#_141_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_141_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume Fractions(50) > 0;
	assume SecMask_$_8 == SecMask_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := SecMask_$_7[Heap_$_4[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] + Fractions(50)]];
	assume IsGoodMask(exhaleMask#_141_$_8);
	assume wf(Heap_$_4,exhaleMask#_141_$_8,SecMask_$_8);
	assume wf(Heap_$_4,Mask_$_21,SecMask_$_8);
	assume exhaleMask#_141_$_9 == exhaleMask#_141_$_8;
	assume SecMask_$_9 == SecMask_$_8;
	goto anon93;
anon167_Else:
	assume Heap_$_4[this,AVLTree.root] == null;
	assume exhaleMask#_141_$_9 == exhaleMask#_141_$_7;
	assume SecMask_$_9 == SecMask_$_7;
	goto anon93;
anon93:
	assume IsGoodExhaleState(exhaleHeap#_140_$_0,Heap_$_4,exhaleMask#_141_$_9,SecMask_$_9);
	assume IsGoodMask(exhaleMask#_141_$_9);
	assume wf(exhaleHeap#_140_$_0,exhaleMask#_141_$_9,SecMask_$_9);
	assume !(this == null);
	assume wf(exhaleHeap#_140_$_0,exhaleMask#_141_$_9,SecMask_$_9);
	assume Fractions(100) > 0;
	assume Mask_$_22 == exhaleMask#_141_$_9[this,AVLTree.valid := exhaleMask#_141_$_9[this,AVLTree.valid][perm$R := exhaleMask#_141_$_9[this,AVLTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_22);
	assume IsGoodState(heapFragment(exhaleHeap#_140_$_0[this,AVLTree.valid]));
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_9);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_9);
	assume IsGoodMask(Mask_$_22);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_9);
	assume predVer#_137_$_0 == exhaleHeap#_140_$_0[this,AVLTree.valid];
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_9);
	assert { :msg "  60.2: The postcondition at 67.11 might not hold. The expression at 67.11 might not evaluate to true." } !Seq#Contains(exhaleHeap#_140_$_0[this,AVLTree.keys],k#3);
	assert { :msg "  60.2: The postcondition at 68.11 might not hold. The expression at 68.11 might not evaluate to true." } (forall  j#76#138 : Integer :: ( ((0 <= j#76#138) && (j#76#138 < Seq#Length(Heap[this,AVLTree.keys]))) ==> (Seq#Contains(exhaleHeap#_140_$_0[this,AVLTree.keys],Seq#Index(Heap[this,AVLTree.keys],j#76#138)) || (Seq#Index(Heap[this,AVLTree.keys],j#76#138) == k#3)) ));
	assert { :msg "  60.2: The postcondition at 69.11 might not hold. The expression at 69.11 might not evaluate to true." } (forall  j#77#139 : Integer :: ( ((0 <= j#77#139) && (j#77#139 < Seq#Length(exhaleHeap#_140_$_0[this,AVLTree.keys]))) ==> (Seq#Contains(Heap[this,AVLTree.keys],Seq#Index(exhaleHeap#_140_$_0[this,AVLTree.keys],j#77#139)) && (!(Seq#Index(exhaleHeap#_140_$_0[this,AVLTree.keys],j#77#139) == k#3))) ));
	assert { :msg "  60.2: The postcondition at 64.11 might not hold. The permission at 64.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  60.2: The postcondition at 64.11 might not hold. Insufficient fraction at 64.11 for AVLTree.valid." } (Fractions(100) <= Mask_$_22[this,AVLTree.valid][perm$R]) && ((Fractions(100) == Mask_$_22[this,AVLTree.valid][perm$R]) ==> (0 <= Mask_$_22[this,AVLTree.valid][perm$N]));
	assume exhaleMask#_149_$_0 == Mask_$_22[this,AVLTree.valid := Mask_$_22[this,AVLTree.valid][perm$R := Mask_$_22[this,AVLTree.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$57) { goto anon168_Then; } else { goto anon168_Else; }
anon168_Then:
	assume false || (((((predVer#_137_$_0 == exhaleHeap#_140_$_0[this,AVLTree.valid]) && (this == this)) && true) && (!cond#_122_$_0)) && true);
	if ($_$_condition_$58) { goto anon169_Then; } else { goto anon169_Else; }
anon168_Else:
	assume !(false || (((((predVer#_137_$_0 == exhaleHeap#_140_$_0[this,AVLTree.valid]) && (this == this)) && true) && (!cond#_122_$_0)) && true));
	assume SecMask_$_32 == SecMask_$_9;
	if ($_$_condition_$59) { goto anon181_Then; } else { goto anon181_Else; }
anon169_Then:
	assume !(exhaleHeap#_140_$_0[this,AVLTree.root] == null);
	assume Seq#Equal(exhaleHeap#_140_$_0[this,AVLTree.keys],exhaleHeap#_140_$_0[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$60) { goto anon170_Then; } else { goto anon170_Else; }
anon169_Else:
	assume exhaleHeap#_140_$_0[this,AVLTree.root] == null;
	if ($_$_condition_$61) { goto anon170_Then; } else { goto anon170_Else; }
anon181_Then:
	assume !CanRead(exhaleMask#_149_$_0,SecMask_$_32,this,AVLTree.valid);
	assume exhaleHeap#_140_$_0[this,AVLTree.valid] < exhaleHeap#_148_$_0[this,AVLTree.valid];
	goto anon121;
anon181_Else:
	assume CanRead(exhaleMask#_149_$_0,SecMask_$_32,this,AVLTree.valid);
	goto anon121;
anon170_Then:
	assume exhaleHeap#_140_$_0[this,AVLTree.root] == null;
	assume Seq#Equal(exhaleHeap#_140_$_0[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon98;
anon170_Else:
	assume !(exhaleHeap#_140_$_0[this,AVLTree.root] == null);
	goto anon98;
anon98:
	assume SecMask_$_10 == SecMask_$_9[this,AVLTree.root := SecMask_$_9[this,AVLTree.root][perm$R := SecMask_$_9[this,AVLTree.root][perm$R] - Fractions(100)]];
	if ($_$_condition_$62) { goto anon171_Then; } else { goto anon171_Else; }
anon171_Then:
	assume SecMask_$_10[this,AVLTree.root][perm$R] < 0;
	assume SecMask_$_11 == SecMask_$_10[this,AVLTree.root := SecMask_$_10[this,AVLTree.root][perm$R := 0]];
	assume SecMask_$_12 == SecMask_$_11;
	goto anon100;
anon171_Else:
	assume 0 <= SecMask_$_10[this,AVLTree.root][perm$R];
	assume SecMask_$_12 == SecMask_$_10;
	goto anon100;
anon100:
	assume wf(exhaleHeap#_140_$_0,SecMask_$_12,SecMask_$_12);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_12);
	assume SecMask_$_13 == SecMask_$_12[this,AVLTree.keys := SecMask_$_12[this,AVLTree.keys][perm$R := SecMask_$_12[this,AVLTree.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$63) { goto anon172_Then; } else { goto anon172_Else; }
anon172_Then:
	assume SecMask_$_13[this,AVLTree.keys][perm$R] < 0;
	assume SecMask_$_14 == SecMask_$_13[this,AVLTree.keys := SecMask_$_13[this,AVLTree.keys][perm$R := 0]];
	assume SecMask_$_15 == SecMask_$_14;
	goto anon102;
anon172_Else:
	assume 0 <= SecMask_$_13[this,AVLTree.keys][perm$R];
	assume SecMask_$_15 == SecMask_$_13;
	goto anon102;
anon102:
	assume wf(exhaleHeap#_140_$_0,SecMask_$_15,SecMask_$_15);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_15);
	if ($_$_condition_$64) { goto anon173_Then; } else { goto anon173_Else; }
anon173_Then:
	assume !(exhaleHeap#_140_$_0[this,AVLTree.root] == null);
	assume SecMask_$_16 == SecMask_$_15[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_15[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_15[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$65) { goto anon174_Then; } else { goto anon174_Else; }
anon173_Else:
	assume exhaleHeap#_140_$_0[this,AVLTree.root] == null;
	assume SecMask_$_19 == SecMask_$_15;
	if ($_$_condition_$66) { goto anon175_Then; } else { goto anon175_Else; }
anon174_Then:
	assume SecMask_$_16[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_17 == SecMask_$_16[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_16[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_18 == SecMask_$_17;
	goto anon105;
anon174_Else:
	assume 0 <= SecMask_$_16[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R];
	assume SecMask_$_18 == SecMask_$_16;
	goto anon105;
anon175_Then:
	assume !(exhaleHeap#_140_$_0[this,AVLTree.root] == null);
	assume SecMask_$_20 == SecMask_$_19[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_19[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := SecMask_$_19[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$68) { goto anon176_Then; } else { goto anon176_Else; }
anon175_Else:
	assume exhaleHeap#_140_$_0[this,AVLTree.root] == null;
	assume SecMask_$_23 == SecMask_$_19;
	if ($_$_condition_$69) { goto anon177_Then; } else { goto anon177_Else; }
anon105:
	assume wf(exhaleHeap#_140_$_0,SecMask_$_18,SecMask_$_18);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_18);
	assume SecMask_$_19 == SecMask_$_18;
	if ($_$_condition_$67) { goto anon175_Then; } else { goto anon175_Else; }
anon176_Then:
	assume SecMask_$_20[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_21 == SecMask_$_20[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_20[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_22 == SecMask_$_21;
	goto anon109;
anon176_Else:
	assume 0 <= SecMask_$_20[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R];
	assume SecMask_$_22 == SecMask_$_20;
	goto anon109;
anon177_Then:
	assume !(exhaleHeap#_140_$_0[this,AVLTree.root] == null);
	assume SecMask_$_24 == SecMask_$_23[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_23[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := SecMask_$_23[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$71) { goto anon178_Then; } else { goto anon178_Else; }
anon177_Else:
	assume exhaleHeap#_140_$_0[this,AVLTree.root] == null;
	assume SecMask_$_27 == SecMask_$_23;
	if ($_$_condition_$72) { goto anon179_Then; } else { goto anon179_Else; }
anon109:
	assume wf(exhaleHeap#_140_$_0,SecMask_$_22,SecMask_$_22);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_22);
	assume SecMask_$_23 == SecMask_$_22;
	if ($_$_condition_$70) { goto anon177_Then; } else { goto anon177_Else; }
anon178_Then:
	assume SecMask_$_24[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_25 == SecMask_$_24[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_24[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_26 == SecMask_$_25;
	goto anon113;
anon178_Else:
	assume 0 <= SecMask_$_24[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R];
	assume SecMask_$_26 == SecMask_$_24;
	goto anon113;
anon179_Then:
	assume !(exhaleHeap#_140_$_0[this,AVLTree.root] == null);
	assume SecMask_$_28 == SecMask_$_27[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_27[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := SecMask_$_27[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$74) { goto anon180_Then; } else { goto anon180_Else; }
anon179_Else:
	assume exhaleHeap#_140_$_0[this,AVLTree.root] == null;
	assume SecMask_$_31 == SecMask_$_27;
	goto anon118;
anon113:
	assume wf(exhaleHeap#_140_$_0,SecMask_$_26,SecMask_$_26);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_26);
	assume SecMask_$_27 == SecMask_$_26;
	if ($_$_condition_$73) { goto anon179_Then; } else { goto anon179_Else; }
anon180_Then:
	assume SecMask_$_28[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_28[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon117;
anon180_Else:
	assume 0 <= SecMask_$_28[exhaleHeap#_140_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon117;
anon118:
	assume wf(exhaleHeap#_140_$_0,SecMask_$_31,SecMask_$_31);
	assume SecMask_$_32 == SecMask_$_31;
	if ($_$_condition_$75) { goto anon181_Then; } else { goto anon181_Else; }
anon117:
	assume wf(exhaleHeap#_140_$_0,SecMask_$_30,SecMask_$_30);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_30);
	assume SecMask_$_31 == SecMask_$_30;
	goto anon118;
anon121:
	assume IsGoodMask(exhaleMask#_149_$_0);
	assume wf(exhaleHeap#_140_$_0,exhaleMask#_149_$_0,SecMask_$_32);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_32);
	assert { :msg "  60.2: The postcondition at 65.11 might not hold. The permission at 65.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  60.2: The postcondition at 65.11 might not hold. Insufficient fraction at 65.11 for AVLTree.keys." } (Fractions(50) <= exhaleMask#_149_$_0[this,AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_149_$_0[this,AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_149_$_0[this,AVLTree.keys][perm$N]));
	assume exhaleMask#_149_$_1 == exhaleMask#_149_$_0[this,AVLTree.keys := exhaleMask#_149_$_0[this,AVLTree.keys][perm$R := exhaleMask#_149_$_0[this,AVLTree.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_149_$_1);
	assume wf(exhaleHeap#_140_$_0,exhaleMask#_149_$_1,SecMask_$_32);
	assume wf(exhaleHeap#_140_$_0,Mask_$_22,SecMask_$_32);
	assume IsGoodExhaleState(exhaleHeap#_148_$_0,exhaleHeap#_140_$_0,exhaleMask#_149_$_1,SecMask_$_32);
	assume IsGoodMask(exhaleMask#_149_$_1);
	assume wf(exhaleHeap#_148_$_0,exhaleMask#_149_$_1,SecMask_$_32);
	assert { :msg "  60.2: Method might lock/unlock more than allowed." } (forall  lk#_160 : ref :: {exhaleHeap#_148_$_0[lk#_160,held]} {exhaleHeap#_148_$_0[lk#_160,rdheld]} ( (((0 < exhaleHeap#_148_$_0[lk#_160,held]) <==> (0 < Heap[lk#_160,held])) && (exhaleHeap#_148_$_0[lk#_160,rdheld] <==> Heap[lk#_160,rdheld])) || false ));
	assert { :msg "  60.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
