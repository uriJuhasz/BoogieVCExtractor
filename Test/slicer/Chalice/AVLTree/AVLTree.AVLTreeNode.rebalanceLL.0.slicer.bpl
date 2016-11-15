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
procedure AVLTreeNode.rebalanceLL (this : ref) returns (r#72 : ref)
{
	var methodK#_3257 : int;
	var unfoldK#_3258 : int;
	var oldVers#_3278 : int;
	var newVers#_3279 : int;
	var methodCallK#_3284 : int;
	var this#939 : ref;
	var callHeap#_3280 : HeapType;
	var callMask#_3281 : MaskType;
	var callSecMask#_3282 : MaskType;
	var callCredits#_3283 : CreditsType;
	var exhaleMask#_3286 : MaskType;
	var exhaleHeap#_3285 : HeapType;
	var methodCallK#_3307 : int;
	var this#944 : ref;
	var callHeap#_3303 : HeapType;
	var callMask#_3304 : MaskType;
	var callSecMask#_3305 : MaskType;
	var callCredits#_3306 : CreditsType;
	var exhaleMask#_3309 : MaskType;
	var exhaleHeap#_3308 : HeapType;
	var exhaleMask#_3327 : MaskType;
	var exhaleHeap#_3326 : HeapType;
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
	if ($_$_condition_$0) { goto anon142_Then; } else { goto anon142_Else; }
anon141_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_7 == Mask_$_5;
	if ($_$_condition_$1) { goto anon142_Then; } else { goto anon142_Else; }
anon142_Then:
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
	if ($_$_condition_$2) { goto anon143_Then; } else { goto anon143_Else; }
anon142_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_9 == Mask_$_7;
	if ($_$_condition_$3) { goto anon143_Then; } else { goto anon143_Else; }
anon143_Then:
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
	if ($_$_condition_$4) { goto anon144_Then; } else { goto anon144_Else; }
anon143_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_11 == Mask_$_9;
	if ($_$_condition_$5) { goto anon144_Then; } else { goto anon144_Else; }
anon144_Then:
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
	if ($_$_condition_$6) { goto anon145_Then; } else { goto anon145_Else; }
anon144_Else:
	assume Heap[this,AVLTreeNode.left] == null;
	assume Mask_$_13 == Mask_$_11;
	if ($_$_condition_$7) { goto anon145_Then; } else { goto anon145_Else; }
anon145_Then:
	assume !(Heap[this,AVLTreeNode.left] == null);
	assume (forall  k#112#931 : Integer :: ( ((0 <= k#112#931) && (k#112#931 < Seq#Length(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap[Heap[this,AVLTreeNode.left],AVLTreeNode.keys],k#112#931) < Heap[this,AVLTreeNode.key]) ));
	goto anon10;
anon145_Else:
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
	assume false;
	goto $exit;
anon146_Else:
	assume !false;
	if ($_$_condition_$9) { goto anon173_Then; } else { goto anon173_Else; }
anon173_Then:
	assume !CanRead(Mask_$_18,ZeroMask,Heap[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume oldVers#_3278_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume Heap_$_0 == Heap[Heap[this,AVLTreeNode.right],AVLTreeNode.valid := newVers#_3279_$_0];
	assume oldVers#_3278_$_0 < Heap_$_0[Heap_$_0[this,AVLTreeNode.right],AVLTreeNode.valid];
	assume Heap_$_1 == Heap_$_0;
	goto anon66;
anon173_Else:
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
	if ($_$_condition_$11) { goto anon175_Then; } else { goto anon175_Else; }
anon174_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_26 == Mask_$_24;
	if ($_$_condition_$12) { goto anon175_Then; } else { goto anon175_Else; }
anon175_Then:
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
	if ($_$_condition_$13) { goto anon176_Then; } else { goto anon176_Else; }
anon175_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_28 == Mask_$_26;
	if ($_$_condition_$14) { goto anon176_Then; } else { goto anon176_Else; }
anon176_Then:
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
	if ($_$_condition_$15) { goto anon177_Then; } else { goto anon177_Else; }
anon176_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_30 == Mask_$_28;
	if ($_$_condition_$16) { goto anon177_Then; } else { goto anon177_Else; }
anon177_Then:
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
	if ($_$_condition_$17) { goto anon178_Then; } else { goto anon178_Else; }
anon177_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	assume Mask_$_32 == Mask_$_30;
	if ($_$_condition_$18) { goto anon178_Then; } else { goto anon178_Else; }
anon178_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume (forall  lk#79#937 : Integer :: ( ((0 <= lk#79#937) && (lk#79#937 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.keys],lk#79#937) < Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key]) ));
	if ($_$_condition_$19) { goto anon179_Then; } else { goto anon179_Else; }
anon178_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$20) { goto anon179_Then; } else { goto anon179_Else; }
anon179_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left],AVLTreeNode.height] > 0;
	if ($_$_condition_$21) { goto anon180_Then; } else { goto anon180_Else; }
anon179_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.left] == null;
	if ($_$_condition_$22) { goto anon180_Then; } else { goto anon180_Else; }
anon180_Then:
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
	if ($_$_condition_$23) { goto anon181_Then; } else { goto anon181_Else; }
anon180_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_34 == Mask_$_32;
	if ($_$_condition_$24) { goto anon181_Then; } else { goto anon181_Else; }
anon181_Then:
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
	if ($_$_condition_$25) { goto anon182_Then; } else { goto anon182_Else; }
anon181_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_36 == Mask_$_34;
	if ($_$_condition_$26) { goto anon182_Then; } else { goto anon182_Else; }
anon182_Then:
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
	if ($_$_condition_$27) { goto anon183_Then; } else { goto anon183_Else; }
anon182_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_38 == Mask_$_36;
	if ($_$_condition_$28) { goto anon183_Then; } else { goto anon183_Else; }
anon183_Then:
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
	if ($_$_condition_$29) { goto anon184_Then; } else { goto anon184_Else; }
anon183_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	assume Mask_$_40 == Mask_$_38;
	if ($_$_condition_$30) { goto anon184_Then; } else { goto anon184_Else; }
anon184_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume (forall  rk#80#938 : Integer :: ( ((0 <= rk#80#938) && (rk#80#938 < Seq#Length(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.key] < Seq#Index(Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.keys],rk#80#938)) ));
	if ($_$_condition_$31) { goto anon185_Then; } else { goto anon185_Else; }
anon184_Else:
	assume Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null;
	if ($_$_condition_$32) { goto anon185_Then; } else { goto anon185_Else; }
anon185_Then:
	assume !(Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right] == null);
	assume Heap_$_1[Heap_$_1[Heap_$_1[this,AVLTreeNode.right],AVLTreeNode.right],AVLTreeNode.height] > 0;
	goto anon90;
anon185_Else:
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
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#940 : Integer :: ( ((0 <= k#92#940) && (k#92#940 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys],k#92#940) < Heap_$_2[this,AVLTreeNode.key]) ));
	if ($_$_condition_$34) { goto anon187_Then; } else { goto anon187_Else; }
anon186_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	if ($_$_condition_$35) { goto anon187_Then; } else { goto anon187_Else; }
anon187_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#941 : Integer :: ( ((0 <= k#93#941) && (k#93#941 < Seq#Length(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_2[this,AVLTreeNode.key] < Seq#Index(Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys],k#93#941)) ));
	goto anon94;
anon187_Else:
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
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3286_$_6 == exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_3286_$_5[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$37) { goto anon189_Then; } else { goto anon189_Else; }
anon188_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_7 == exhaleMask#_3286_$_5;
	if ($_$_condition_$38) { goto anon190_Then; } else { goto anon190_Else; }
anon189_Then:
	assume !CanRead(exhaleMask#_3286_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_3285_$_0[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon97;
anon189_Else:
	assume CanRead(exhaleMask#_3286_$_6,ZeroMask,Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon97;
anon190_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3286_$_8 == exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_3286_$_7[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_8);
	assume wf(Heap_$_2,exhaleMask#_3286_$_8,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_9 == exhaleMask#_3286_$_8;
	if ($_$_condition_$40) { goto anon191_Then; } else { goto anon191_Else; }
anon190_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_9 == exhaleMask#_3286_$_7;
	if ($_$_condition_$41) { goto anon191_Then; } else { goto anon191_Else; }
anon97:
	assume IsGoodMask(exhaleMask#_3286_$_6);
	assume wf(Heap_$_2,exhaleMask#_3286_$_6,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_7 == exhaleMask#_3286_$_6;
	if ($_$_condition_$39) { goto anon190_Then; } else { goto anon190_Else; }
anon191_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3286_$_10 == exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_3286_$_9[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_10);
	assume wf(Heap_$_2,exhaleMask#_3286_$_10,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_11 == exhaleMask#_3286_$_10;
	if ($_$_condition_$42) { goto anon192_Then; } else { goto anon192_Else; }
anon191_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_11 == exhaleMask#_3286_$_9;
	if ($_$_condition_$43) { goto anon192_Then; } else { goto anon192_Else; }
anon192_Then:
	assume !(Heap_$_2[this,AVLTreeNode.left] == null);
	assert { :msg "  882.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3286_$_12 == exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3286_$_11[Heap_$_2[this,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_12);
	assume wf(Heap_$_2,exhaleMask#_3286_$_12,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_13 == exhaleMask#_3286_$_12;
	if ($_$_condition_$44) { goto anon193_Then; } else { goto anon193_Else; }
anon192_Else:
	assume Heap_$_2[this,AVLTreeNode.left] == null;
	assume exhaleMask#_3286_$_13 == exhaleMask#_3286_$_11;
	if ($_$_condition_$45) { goto anon193_Then; } else { goto anon193_Else; }
anon193_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  882.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3286_$_14 == exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_3286_$_13[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$46) { goto anon194_Then; } else { goto anon194_Else; }
anon193_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_3286_$_15 == exhaleMask#_3286_$_13;
	if ($_$_condition_$47) { goto anon195_Then; } else { goto anon195_Else; }
anon194_Then:
	assume !CanRead(exhaleMask#_3286_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_2[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_3285_$_0[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon107;
anon194_Else:
	assume CanRead(exhaleMask#_3286_$_14,ZeroMask,Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon107;
anon195_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3286_$_16 == exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_3286_$_15[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_16);
	assume wf(Heap_$_2,exhaleMask#_3286_$_16,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_17 == exhaleMask#_3286_$_16;
	if ($_$_condition_$49) { goto anon196_Then; } else { goto anon196_Else; }
anon195_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_3286_$_17 == exhaleMask#_3286_$_15;
	if ($_$_condition_$50) { goto anon196_Then; } else { goto anon196_Else; }
anon107:
	assume IsGoodMask(exhaleMask#_3286_$_14);
	assume wf(Heap_$_2,exhaleMask#_3286_$_14,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_15 == exhaleMask#_3286_$_14;
	if ($_$_condition_$48) { goto anon195_Then; } else { goto anon195_Else; }
anon196_Then:
	assume !(Heap_$_2[this,AVLTreeNode.right] == null);
	assert { :msg "  882.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  882.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3286_$_18 == exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_3286_$_17[Heap_$_2[this,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3286_$_18);
	assume wf(Heap_$_2,exhaleMask#_3286_$_18,ZeroMask);
	assume wf(Heap_$_2,Mask_$_40,ZeroMask);
	assume exhaleMask#_3286_$_19 == exhaleMask#_3286_$_18;
	if ($_$_condition_$51) { goto anon197_Then; } else { goto anon197_Else; }
anon196_Else:
	assume Heap_$_2[this,AVLTreeNode.right] == null;
	assume exhaleMask#_3286_$_19 == exhaleMask#_3286_$_17;
	if ($_$_condition_$52) { goto anon197_Then; } else { goto anon197_Else; }
anon197_Then:
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
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 556.12 might not hold. The expression at 556.27 might not evaluate to true." } (forall  k#92#945 : Integer :: ( ((0 <= k#92#945) && (k#92#945 < Seq#Length(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys]))) ==> (Seq#Index(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys],k#92#945) < Heap_$_3[r#72_$_0,AVLTreeNode.key]) ));
	if ($_$_condition_$54) { goto anon199_Then; } else { goto anon199_Else; }
anon198_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	if ($_$_condition_$55) { goto anon199_Then; } else { goto anon199_Else; }
anon199_Then:
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 562.12 might not hold. The expression at 562.28 might not evaluate to true." } (forall  k#93#946 : Integer :: ( ((0 <= k#93#946) && (k#93#946 < Seq#Length(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys]))) ==> (Heap_$_3[r#72_$_0,AVLTreeNode.key] < Seq#Index(Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys],k#93#946)) ));
	goto anon118;
anon199_Else:
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
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 552.12 might not hold. The permission at 552.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 552.12 might not hold. Insufficient fraction at 552.27 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3309_$_6 == exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid := exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R := exhaleMask#_3309_$_5[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$57) { goto anon201_Then; } else { goto anon201_Else; }
anon200_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_7 == exhaleMask#_3309_$_5;
	if ($_$_condition_$58) { goto anon202_Then; } else { goto anon202_Else; }
anon201_Then:
	assume !CanRead(exhaleMask#_3309_$_6,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid] < exhaleHeap#_3308_$_0[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid];
	goto anon121;
anon201_Else:
	assume CanRead(exhaleMask#_3309_$_6,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.valid);
	goto anon121;
anon202_Then:
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 553.12 might not hold. The permission at 553.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 553.12 might not hold. Insufficient fraction at 553.27 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3309_$_8 == exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height := exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R := exhaleMask#_3309_$_7[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_8);
	assume wf(Heap_$_3,exhaleMask#_3309_$_8,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_9 == exhaleMask#_3309_$_8;
	if ($_$_condition_$60) { goto anon203_Then; } else { goto anon203_Else; }
anon202_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_9 == exhaleMask#_3309_$_7;
	if ($_$_condition_$61) { goto anon203_Then; } else { goto anon203_Else; }
anon121:
	assume IsGoodMask(exhaleMask#_3309_$_6);
	assume wf(Heap_$_3,exhaleMask#_3309_$_6,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_7 == exhaleMask#_3309_$_6;
	if ($_$_condition_$59) { goto anon202_Then; } else { goto anon202_Else; }
anon203_Then:
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 554.12 might not hold. The permission at 554.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 554.12 might not hold. Insufficient fraction at 554.27 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3309_$_10 == exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys := exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R := exhaleMask#_3309_$_9[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_10);
	assume wf(Heap_$_3,exhaleMask#_3309_$_10,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_11 == exhaleMask#_3309_$_10;
	if ($_$_condition_$62) { goto anon204_Then; } else { goto anon204_Else; }
anon203_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_11 == exhaleMask#_3309_$_9;
	if ($_$_condition_$63) { goto anon204_Then; } else { goto anon204_Else; }
anon204_Then:
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.left] == null);
	assert { :msg "  884.3: The precondition at 555.12 might not hold. The permission at 555.27 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 555.12 might not hold. Insufficient fraction at 555.27 for AVLTreeNode.balanceFactor." } (Fractions(50) <= exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$N]));
	assume exhaleMask#_3309_$_12 == exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor := exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R := exhaleMask#_3309_$_11[Heap_$_3[r#72_$_0,AVLTreeNode.left],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_12);
	assume wf(Heap_$_3,exhaleMask#_3309_$_12,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_13 == exhaleMask#_3309_$_12;
	if ($_$_condition_$64) { goto anon205_Then; } else { goto anon205_Else; }
anon204_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.left] == null;
	assume exhaleMask#_3309_$_13 == exhaleMask#_3309_$_11;
	if ($_$_condition_$65) { goto anon205_Then; } else { goto anon205_Else; }
anon205_Then:
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 558.12 might not hold. The permission at 558.28 might not be positive." } Fractions(100) > 0;
	assert { :msg "  884.3: The precondition at 558.12 might not hold. Insufficient fraction at 558.28 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_3309_$_14 == exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid := exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R := exhaleMask#_3309_$_13[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$66) { goto anon206_Then; } else { goto anon206_Else; }
anon205_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_3309_$_15 == exhaleMask#_3309_$_13;
	if ($_$_condition_$67) { goto anon207_Then; } else { goto anon207_Else; }
anon206_Then:
	assume !CanRead(exhaleMask#_3309_$_14,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	assume Heap_$_3[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid] < exhaleHeap#_3308_$_0[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid];
	goto anon131;
anon206_Else:
	assume CanRead(exhaleMask#_3309_$_14,ZeroMask,Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.valid);
	goto anon131;
anon207_Then:
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 559.12 might not hold. The permission at 559.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 559.12 might not hold. Insufficient fraction at 559.28 for AVLTreeNode.height." } (Fractions(50) <= exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$N]));
	assume exhaleMask#_3309_$_16 == exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height := exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R := exhaleMask#_3309_$_15[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.height][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_16);
	assume wf(Heap_$_3,exhaleMask#_3309_$_16,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_17 == exhaleMask#_3309_$_16;
	if ($_$_condition_$69) { goto anon208_Then; } else { goto anon208_Else; }
anon207_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_3309_$_17 == exhaleMask#_3309_$_15;
	if ($_$_condition_$70) { goto anon208_Then; } else { goto anon208_Else; }
anon131:
	assume IsGoodMask(exhaleMask#_3309_$_14);
	assume wf(Heap_$_3,exhaleMask#_3309_$_14,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_15 == exhaleMask#_3309_$_14;
	if ($_$_condition_$68) { goto anon207_Then; } else { goto anon207_Else; }
anon208_Then:
	assume !(Heap_$_3[r#72_$_0,AVLTreeNode.right] == null);
	assert { :msg "  884.3: The precondition at 560.12 might not hold. The permission at 560.28 might not be positive." } Fractions(50) > 0;
	assert { :msg "  884.3: The precondition at 560.12 might not hold. Insufficient fraction at 560.28 for AVLTreeNode.keys." } (Fractions(50) <= exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$N]));
	assume exhaleMask#_3309_$_18 == exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys := exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R := exhaleMask#_3309_$_17[Heap_$_3[r#72_$_0,AVLTreeNode.right],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(exhaleMask#_3309_$_18);
	assume wf(Heap_$_3,exhaleMask#_3309_$_18,ZeroMask);
	assume wf(Heap_$_3,Mask_$_44,ZeroMask);
	assume exhaleMask#_3309_$_19 == exhaleMask#_3309_$_18;
	if ($_$_condition_$71) { goto anon209_Then; } else { goto anon209_Else; }
anon208_Else:
	assume Heap_$_3[r#72_$_0,AVLTreeNode.right] == null;
	assume exhaleMask#_3309_$_19 == exhaleMask#_3309_$_17;
	if ($_$_condition_$72) { goto anon209_Then; } else { goto anon209_Else; }
anon209_Then:
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
	assume !CanRead(exhaleMask#_3327_$_0,ZeroMask,r#72_$_0,AVLTreeNode.valid);
	assume exhaleHeap#_3308_$_0[r#72_$_0,AVLTreeNode.valid] < exhaleHeap#_3326_$_0[r#72_$_0,AVLTreeNode.valid];
	goto anon140;
anon210_Else:
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
}
