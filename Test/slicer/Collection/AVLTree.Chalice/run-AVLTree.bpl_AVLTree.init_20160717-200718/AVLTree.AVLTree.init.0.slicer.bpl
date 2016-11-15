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
procedure AVLTree.init (this : ref)
{
	var methodK#_11 : int;
	var foldK#_15 : int;
	var exhaleMask#_17 : MaskType;
	var exhaleHeap#_16 : HeapType;
	var predRec#_12 : ref;
	var predVer#_13 : int;
	var predFlag#_14 : bool;
	var exhaleMask#_25 : MaskType;
	var exhaleHeap#_24 : HeapType;
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
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true." } Seq#Equal(Heap_$_1[this,AVLTree.keys],Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$0) { goto anon44_Then; } else { goto anon44_Else; }
anon43_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	if ($_$_condition_$1) { goto anon44_Then; } else { goto anon44_Else; }
anon44_Then:
	assume Heap_$_1[this,AVLTree.root] == null;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 17.22 might not evaluate to true." } Seq#Equal(Heap_$_1[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon4;
anon44_Else:
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
	assume !(Heap_$_1[this,AVLTree.root] == null);
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 12.22 might not be positive." } Fractions(100) > 0;
	assert { :msg "  31.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid." } (Fractions(100) <= exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$N]));
	assume exhaleMask#_17_$_2 == exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid := exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R := exhaleMask#_17_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	assume Fractions(100) > 0;
	assume SecMask_$_2 == SecMask_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid][perm$R] + Fractions(100)]];
	if ($_$_condition_$3) { goto anon46_Then; } else { goto anon46_Else; }
anon45_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume SecMask_$_3 == SecMask_$_1;
	assume exhaleMask#_17_$_3 == exhaleMask#_17_$_1;
	if ($_$_condition_$4) { goto anon47_Then; } else { goto anon47_Else; }
anon46_Then:
	assume !CanRead(exhaleMask#_17_$_2,SecMask_$_2,Heap_$_1[this,AVLTree.root],AVLTreeNode.valid);
	assume Heap_$_1[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid] < exhaleHeap#_16_$_0[Heap_$_1[this,AVLTree.root],AVLTreeNode.valid];
	goto anon7;
anon46_Else:
	assume CanRead(exhaleMask#_17_$_2,SecMask_$_2,Heap_$_1[this,AVLTree.root],AVLTreeNode.valid);
	goto anon7;
anon47_Then:
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
	if ($_$_condition_$6) { goto anon48_Then; } else { goto anon48_Else; }
anon47_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume exhaleMask#_17_$_5 == exhaleMask#_17_$_3;
	assume SecMask_$_5 == SecMask_$_3;
	if ($_$_condition_$7) { goto anon48_Then; } else { goto anon48_Else; }
anon7:
	assume IsGoodMask(exhaleMask#_17_$_2);
	assume wf(Heap_$_1,exhaleMask#_17_$_2,SecMask_$_2);
	assume wf(Heap_$_1,Mask_$_1,SecMask_$_2);
	assume SecMask_$_3 == SecMask_$_2;
	assume exhaleMask#_17_$_3 == exhaleMask#_17_$_2;
	if ($_$_condition_$5) { goto anon47_Then; } else { goto anon47_Else; }
anon48_Then:
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
	if ($_$_condition_$8) { goto anon49_Then; } else { goto anon49_Else; }
anon48_Else:
	assume Heap_$_1[this,AVLTree.root] == null;
	assume SecMask_$_7 == SecMask_$_5;
	assume exhaleMask#_17_$_7 == exhaleMask#_17_$_5;
	if ($_$_condition_$9) { goto anon49_Then; } else { goto anon49_Else; }
anon49_Then:
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
	assume false || ((((predVer#_13_$_0 == exhaleHeap#_16_$_0[this,AVLTree.valid]) && (this == this)) && true) && true);
	if ($_$_condition_$11) { goto anon51_Then; } else { goto anon51_Else; }
anon50_Else:
	assume !(false || ((((predVer#_13_$_0 == exhaleHeap#_16_$_0[this,AVLTree.valid]) && (this == this)) && true) && true));
	assume SecMask_$_32 == SecMask_$_9;
	if ($_$_condition_$12) { goto anon63_Then; } else { goto anon63_Else; }
anon51_Then:
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume Seq#Equal(exhaleHeap#_16_$_0[this,AVLTree.keys],exhaleHeap#_16_$_0[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys]);
	if ($_$_condition_$13) { goto anon52_Then; } else { goto anon52_Else; }
anon51_Else:
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	if ($_$_condition_$14) { goto anon52_Then; } else { goto anon52_Else; }
anon63_Then:
	assume !CanRead(exhaleMask#_25_$_0,SecMask_$_32,this,AVLTree.valid);
	assume exhaleHeap#_16_$_0[this,AVLTree.valid] < exhaleHeap#_24_$_0[this,AVLTree.valid];
	goto anon42;
anon63_Else:
	assume CanRead(exhaleMask#_25_$_0,SecMask_$_32,this,AVLTree.valid);
	goto anon42;
anon52_Then:
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume Seq#Equal(exhaleHeap#_16_$_0[this,AVLTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon19;
anon52_Else:
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	goto anon19;
anon19:
	assume SecMask_$_10 == SecMask_$_9[this,AVLTree.root := SecMask_$_9[this,AVLTree.root][perm$R := SecMask_$_9[this,AVLTree.root][perm$R] - Fractions(100)]];
	if ($_$_condition_$15) { goto anon53_Then; } else { goto anon53_Else; }
anon53_Then:
	assume SecMask_$_10[this,AVLTree.root][perm$R] < 0;
	assume SecMask_$_11 == SecMask_$_10[this,AVLTree.root := SecMask_$_10[this,AVLTree.root][perm$R := 0]];
	assume SecMask_$_12 == SecMask_$_11;
	goto anon21;
anon53_Else:
	assume 0 <= SecMask_$_10[this,AVLTree.root][perm$R];
	assume SecMask_$_12 == SecMask_$_10;
	goto anon21;
anon21:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_12,SecMask_$_12);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_12);
	assume SecMask_$_13 == SecMask_$_12[this,AVLTree.keys := SecMask_$_12[this,AVLTree.keys][perm$R := SecMask_$_12[this,AVLTree.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$16) { goto anon54_Then; } else { goto anon54_Else; }
anon54_Then:
	assume SecMask_$_13[this,AVLTree.keys][perm$R] < 0;
	assume SecMask_$_14 == SecMask_$_13[this,AVLTree.keys := SecMask_$_13[this,AVLTree.keys][perm$R := 0]];
	assume SecMask_$_15 == SecMask_$_14;
	goto anon23;
anon54_Else:
	assume 0 <= SecMask_$_13[this,AVLTree.keys][perm$R];
	assume SecMask_$_15 == SecMask_$_13;
	goto anon23;
anon23:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_15,SecMask_$_15);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_15);
	if ($_$_condition_$17) { goto anon55_Then; } else { goto anon55_Else; }
anon55_Then:
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_16 == SecMask_$_15[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_15[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := SecMask_$_15[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] - Fractions(100)]];
	if ($_$_condition_$18) { goto anon56_Then; } else { goto anon56_Else; }
anon55_Else:
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_19 == SecMask_$_15;
	if ($_$_condition_$19) { goto anon57_Then; } else { goto anon57_Else; }
anon56_Then:
	assume SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R] < 0;
	assume SecMask_$_17 == SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid := SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R := 0]];
	assume SecMask_$_18 == SecMask_$_17;
	goto anon26;
anon56_Else:
	assume 0 <= SecMask_$_16[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.valid][perm$R];
	assume SecMask_$_18 == SecMask_$_16;
	goto anon26;
anon57_Then:
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_20 == SecMask_$_19[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_19[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := SecMask_$_19[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] - Fractions(50)]];
	if ($_$_condition_$21) { goto anon58_Then; } else { goto anon58_Else; }
anon57_Else:
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_23 == SecMask_$_19;
	if ($_$_condition_$22) { goto anon59_Then; } else { goto anon59_Else; }
anon26:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_18,SecMask_$_18);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_18);
	assume SecMask_$_19 == SecMask_$_18;
	if ($_$_condition_$20) { goto anon57_Then; } else { goto anon57_Else; }
anon58_Then:
	assume SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R] < 0;
	assume SecMask_$_21 == SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height := SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R := 0]];
	assume SecMask_$_22 == SecMask_$_21;
	goto anon30;
anon58_Else:
	assume 0 <= SecMask_$_20[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.height][perm$R];
	assume SecMask_$_22 == SecMask_$_20;
	goto anon30;
anon59_Then:
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_24 == SecMask_$_23[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_23[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := SecMask_$_23[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] - Fractions(50)]];
	if ($_$_condition_$24) { goto anon60_Then; } else { goto anon60_Else; }
anon59_Else:
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_27 == SecMask_$_23;
	if ($_$_condition_$25) { goto anon61_Then; } else { goto anon61_Else; }
anon30:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_22,SecMask_$_22);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_22);
	assume SecMask_$_23 == SecMask_$_22;
	if ($_$_condition_$23) { goto anon59_Then; } else { goto anon59_Else; }
anon60_Then:
	assume SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R] < 0;
	assume SecMask_$_25 == SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys := SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R := 0]];
	assume SecMask_$_26 == SecMask_$_25;
	goto anon34;
anon60_Else:
	assume 0 <= SecMask_$_24[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.keys][perm$R];
	assume SecMask_$_26 == SecMask_$_24;
	goto anon34;
anon61_Then:
	assume !(exhaleHeap#_16_$_0[this,AVLTree.root] == null);
	assume SecMask_$_28 == SecMask_$_27[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_27[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := SecMask_$_27[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] - Fractions(50)]];
	if ($_$_condition_$27) { goto anon62_Then; } else { goto anon62_Else; }
anon61_Else:
	assume exhaleHeap#_16_$_0[this,AVLTree.root] == null;
	assume SecMask_$_31 == SecMask_$_27;
	goto anon39;
anon34:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_26,SecMask_$_26);
	assume wf(exhaleHeap#_16_$_0,Mask_$_2,SecMask_$_26);
	assume SecMask_$_27 == SecMask_$_26;
	if ($_$_condition_$26) { goto anon61_Then; } else { goto anon61_Else; }
anon62_Then:
	assume SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R] < 0;
	assume SecMask_$_29 == SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor := SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R := 0]];
	assume SecMask_$_30 == SecMask_$_29;
	goto anon38;
anon62_Else:
	assume 0 <= SecMask_$_28[exhaleHeap#_16_$_0[this,AVLTree.root],AVLTreeNode.balanceFactor][perm$R];
	assume SecMask_$_30 == SecMask_$_28;
	goto anon38;
anon39:
	assume wf(exhaleHeap#_16_$_0,SecMask_$_31,SecMask_$_31);
	assume SecMask_$_32 == SecMask_$_31;
	if ($_$_condition_$28) { goto anon63_Then; } else { goto anon63_Else; }
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
}
