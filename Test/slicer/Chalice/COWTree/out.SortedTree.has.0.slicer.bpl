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
const unique SortedTreeSnapshot#t : TypeName;
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
const $old_Heap : HeapType;
const $old_Mask : MaskType;
const $old_Credits : CreditsType;
function Fractions(int) : int;
function IsGoodState <T> (T) : bool;
function combine <T,U> (T,U) : T;
function dtype(ref) : TypeName;
function MuBelow(Mu,Mu) : bool;
function Acquire$Heap(int) : HeapType;
function Acquire$Mask(int) : MaskType;
function Acquire$Credits(int) : CreditsType;
function LastSeen$Heap(Mu,int) : HeapType;
function LastSeen$Mask(Mu,int) : MaskType;
function LastSeen$Credits(Mu,int) : CreditsType;
function wf(HeapType,MaskType) : bool;
function IsGoodInhaleState(HeapType,HeapType,MaskType) : bool;
function {:expand  false} CanRead <T> (MaskType,ref,Field (T)) : bool;
function {:expand  false} CanWrite <T> (MaskType,ref,Field (T)) : bool;
function {:expand  true} IsGoodMask(MaskType) : bool;
function DecPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function DecEpsilons <T> (MaskType,ref,Field (T),int) : MaskType;
function IncPerm <T> (MaskType,ref,Field (T),int) : MaskType;
function IncEpsilons <T> (MaskType,ref,Field (T),int) : MaskType;
function Havocing <T,U> (HeapType,ref,Field (T),U) : HeapType;
function Call$Heap(int) : HeapType;
function Call$Mask(int) : MaskType;
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
	var inhaleHeap#_109 : HeapType;
	var unfoldK#_110 : int;
	var exhaleMask#_111 : MaskType;
	var inhaleHeap#_113 : HeapType;
	var foldK#_114 : int;
	var exhaleMask#_115 : MaskType;
	var inhaleHeap#_121 : HeapType;
	var bb#9 : bool;
	var methodCallK#_125 : int;
	var this#52 : ref;
	var k#53 : int;
	var b#54 : bool;
	var callHeap#_122 : HeapType;
	var callMask#_123 : MaskType;
	var callCredits#_124 : CreditsType;
	var exhaleMask#_126 : MaskType;
	var inhaleHeap#_131 : HeapType;
	var foldK#_132 : int;
	var exhaleMask#_133 : MaskType;
	var inhaleHeap#_139 : HeapType;
	var exhaleMask#_140 : MaskType;
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
	assume (forall<T,U> a : T, b : U :: {IsGoodState(combine(a,b))} ( IsGoodState(combine(a,b)) <==> (IsGoodState(a) && IsGoodState(b)) ));
	assume IsGoodState(nostate);
	assume NonPredicateField(mu);
	assume (forall  m : Mu, n_$0 : Mu :: {MuBelow(m,n_$0),MuBelow(n_$0,m)} ( !(MuBelow(m,n_$0) && MuBelow(n_$0,m)) ));
	assume (forall  m_$0 : Mu, n_$1 : Mu, o_$0 : Mu :: {MuBelow(m_$0,n_$1),MuBelow(n_$1,o_$0)} ( (MuBelow(m_$0,n_$1) && MuBelow(n_$1,o_$0)) ==> MuBelow(m_$0,o_$0) ));
	assume (forall  m_$1 : Mu, n_$2 : Mu :: ( MuBelow(m_$1,n_$2) ==> (!(n_$2 == $LockBottom)) ));
	assume NonPredicateField(held);
	assume NonPredicateField(rdheld);
	assume (forall  ih : HeapType, h : HeapType, m_$2 : MaskType :: {IsGoodInhaleState(ih,h,m_$2)} ( IsGoodInhaleState(ih,h,m_$2) <==> ((((((forall<T> o_$1 : ref, f_$0 : Field (T)  :: {ih[o_$1,f_$0]} ( CanRead(m_$2,o_$1,f_$0) ==> (ih[o_$1,f_$0] == h[o_$1,f_$0]) ))) && ((forall  o_$2 : ref :: {ih[o_$2,held]} ( (0 < ih[o_$2,held]) <==> (0 < h[o_$2,held]) )))) && ((forall  o_$3 : ref :: {ih[o_$3,rdheld]} ( ih[o_$3,rdheld] <==> h[o_$3,rdheld] )))) && ((forall  o_$4 : ref :: {h[o_$4,held]} ( (0 < h[o_$4,held]) ==> (ih[o_$4,mu] == h[o_$4,mu]) )))) && ((forall  o_$5 : ref :: {h[o_$5,rdheld]} ( h[o_$5,rdheld] ==> (ih[o_$5,mu] == h[o_$5,mu]) )))) ));
	assume (forall<T> m_$3 : MaskType, obj : ref, f_$1 : Field (T)  :: {CanRead(m_$3,obj,f_$1)} {:expand  false}( CanRead(m_$3,obj,f_$1) <==> ((0 < m_$3[obj,f_$1][perm$R]) || (0 < m_$3[obj,f_$1][perm$N])) ));
	assume (forall<T> m_$4 : MaskType, obj_$0 : ref, f_$2 : Field (T)  :: {CanWrite(m_$4,obj_$0,f_$2)} {:expand  false}( CanWrite(m_$4,obj_$0,f_$2) <==> ((m_$4[obj_$0,f_$2][perm$R] == Permission$FullFraction) && (m_$4[obj_$0,f_$2][perm$N] == 0)) ));
	assume (forall  m_$5 : MaskType :: {IsGoodMask(m_$5)} {:expand  true}( IsGoodMask(m_$5) <==> ((forall<T> o_$6 : ref, f_$3 : Field (T)  :: ( ((0 <= m_$5[o_$6,f_$3][perm$R]) && (NonPredicateField(f_$3) ==> ((m_$5[o_$6,f_$3][perm$R] <= Permission$FullFraction) && ((0 < m_$5[o_$6,f_$3][perm$N]) ==> (m_$5[o_$6,f_$3][perm$R] < Permission$FullFraction))))) && ((m_$5[o_$6,f_$3][perm$N] < 0) ==> (0 < m_$5[o_$6,f_$3][perm$R])) ))) ));
	assume (forall  h_$0 : HeapType, m_$6 : MaskType, o_$7 : ref, q : ref :: {wf(h_$0,m_$6),h_$0[o_$7,mu],h_$0[q,mu]} ( (((wf(h_$0,m_$6) && (!(o_$7 == q))) && ((0 < h_$0[o_$7,held]) || h_$0[o_$7,rdheld])) && ((0 < h_$0[q,held]) || h_$0[q,rdheld])) ==> (!(h_$0[o_$7,mu] == h_$0[q,mu])) ));
	assume (forall<T,U> m_$7 : MaskType, o_$8 : ref, f_$4 : Field (T) , howMuch : Integer, q_$0 : ref, g : Field (U)  :: {DecPerm(m_$7,o_$8,f_$4,howMuch)[q_$0,g][perm$R]} ( DecPerm(m_$7,o_$8,f_$4,howMuch)[q_$0,g][perm$R] == ite((o_$8 == q_$0) && (f_$4 == g),m_$7[q_$0,g][perm$R] - howMuch,m_$7[q_$0,g][perm$R]) ));
	assume (forall<T,U> m_$8 : MaskType, o_$9 : ref, f_$5 : Field (T) , howMuch_$0 : Integer, q_$1 : ref, g_$0 : Field (U)  :: {DecPerm(m_$8,o_$9,f_$5,howMuch_$0)[q_$1,g_$0][perm$N]} ( DecEpsilons(m_$8,o_$9,f_$5,howMuch_$0)[q_$1,g_$0][perm$N] == ite((o_$9 == q_$1) && (f_$5 == g_$0),m_$8[q_$1,g_$0][perm$N] - howMuch_$0,m_$8[q_$1,g_$0][perm$N]) ));
	assume (forall<T,U> m_$9 : MaskType, o_$10 : ref, f_$6 : Field (T) , howMuch_$1 : Integer, q_$2 : ref, g_$1 : Field (U)  :: {IncPerm(m_$9,o_$10,f_$6,howMuch_$1)[q_$2,g_$1][perm$R]} ( IncPerm(m_$9,o_$10,f_$6,howMuch_$1)[q_$2,g_$1][perm$R] == ite((o_$10 == q_$2) && (f_$6 == g_$1),m_$9[q_$2,g_$1][perm$R] + howMuch_$1,m_$9[q_$2,g_$1][perm$R]) ));
	assume (forall<T,U> m_$10 : MaskType, o_$11 : ref, f_$7 : Field (T) , howMuch_$2 : Integer, q_$3 : ref, g_$2 : Field (U)  :: {IncPerm(m_$10,o_$11,f_$7,howMuch_$2)[q_$3,g_$2][perm$N]} ( IncEpsilons(m_$10,o_$11,f_$7,howMuch_$2)[q_$3,g_$2][perm$N] == ite((o_$11 == q_$3) && (f_$7 == g_$2),m_$10[q_$3,g_$2][perm$N] + howMuch_$2,m_$10[q_$3,g_$2][perm$N]) ));
	assume (forall<T,U> h_$1 : HeapType, o_$12 : ref, f_$8 : Field (T) , newValue : U, q_$4 : ref, g_$3 : Field (U)  :: {Havocing(h_$1,o_$12,f_$8,newValue)[q_$4,g_$3]} ( Havocing(h_$1,o_$12,f_$8,newValue)[q_$4,g_$3] == ite((o_$12 == q_$4) && (f_$8 == g_$3),newValue,h_$1[q_$4,g_$3]) ));
	assume (forall  m_$11 : MaskType :: {EmptyMask(m_$11)} ( EmptyMask(m_$11) <==> ((forall<T> o_$13 : ref, f_$9 : Field (T)  :: ( NonPredicateField(f_$9) ==> ((m_$11[o_$13,f_$9][perm$R] <= 0) && (m_$11[o_$13,f_$9][perm$N] <= 0)) ))) ));
	assume (forall  o_$14 : ref :: ( ZeroCredits[o_$14] == 0 ));
	assume (forall  c : CreditsType :: {EmptyCredits(c)} ( EmptyCredits(c) <==> ((forall  o_$15 : ref :: ( (!(o_$15 == null)) ==> (c[o_$15] == 0) ))) ));
	assume (forall<T> f_$10 : Field (T)  :: ( NonPredicateField(f_$10) ==> (!PredicateField(f_$10)) ));
	assume (forall<T> f_$11 : Field (T)  :: ( PredicateField(f_$11) ==> (!NonPredicateField(f_$11)) ));
	assume (forall  m1 : MaskType, m2 : MaskType :: {submask(m1,m2)} ( submask(m1,m2) <==> ((forall<T> o_$16 : ref, f_$12 : Field (T)  :: ( (m1[o_$16,f_$12][perm$R] < m2[o_$16,f_$12][perm$R]) || ((m1[o_$16,f_$12][perm$R] == m2[o_$16,f_$12][perm$R]) && (m1[o_$16,f_$12][perm$N] <= m2[o_$16,f_$12][perm$N])) ))) ));
	assume (forall<T> con : Boolean, a_$0 : T, b_$0 : T :: {ite(con,a_$0,b_$0)} ( con ==> (ite(con,a_$0,b_$0) == a_$0) ));
	assume (forall<T> con_$0 : Boolean, a_$1 : T, b_$1 : T :: {ite(con_$0,a_$1,b_$1)} ( (!con_$0) ==> (ite(con_$0,a_$1,b_$1) == b_$1) ));
	assume (forall  x_$0 : Integer, y_$0 : Integer :: {x_$0 mod y_$0} {x_$0 div y_$0} ( (x_$0 mod y_$0) == (x_$0 - ((x_$0 div y_$0) * y_$0)) ));
	assume (forall  x_$1 : Integer, y_$1 : Integer :: {x_$1 mod y_$1} ( (0 < y_$1) ==> ((0 <= (x_$1 mod y_$1)) && ((x_$1 mod y_$1) < y_$1)) ));
	assume (forall  x_$2 : Integer, y_$2 : Integer :: {x_$2 mod y_$2} ( (y_$2 < 0) ==> ((y_$2 < (x_$2 mod y_$2)) && ((x_$2 mod y_$2) <= 0)) ));
	assume (forall  a_$2 : Integer, b_$2 : Integer, d : Integer :: {a_$2 mod d,b_$2 mod d} ( (((2 <= d) && ((a_$2 mod d) == (b_$2 mod d))) && (a_$2 < b_$2)) ==> ((a_$2 + d) <= b_$2) ));
	assume (forall<T> s : Seq (T)  :: {Seq#Length(s)} ( 0 <= Seq#Length(s) ));
	assume (forall<T> :: Seq#Length((Seq#Empty() : Seq (T) )) == 0);
	assume (forall<T> s_$0 : Seq (T)  :: {Seq#Length(s_$0)} ( (Seq#Length(s_$0) == 0) ==> (s_$0 == (Seq#Empty() : Seq (T) )) ));
	assume (forall<T> t : T :: {Seq#Length(Seq#Singleton(t))} ( Seq#Length(Seq#Singleton(t)) == 1 ));
	assume (forall<T> s_$1 : Seq (T) , i : Integer, v : T, len : Integer :: {Seq#Length(Seq#Build(s_$1,i,v,len))} ( (0 <= len) ==> (Seq#Length(Seq#Build(s_$1,i,v,len)) == len) ));
	assume (forall<T> s0 : Seq (T) , s1 : Seq (T)  :: {Seq#Length(Seq#Append(s0,s1))} ( Seq#Length(Seq#Append(s0,s1)) == (Seq#Length(s0) + Seq#Length(s1)) ));
	assume (forall<T> t_$0 : T :: {Seq#Index(Seq#Singleton(t_$0),0)} ( Seq#Index(Seq#Singleton(t_$0),0) == t_$0 ));
	assume (forall<T> s0_$0 : Seq (T) , s1_$0 : Seq (T) , n_$3 : Integer :: {Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3)} ( ((n_$3 < Seq#Length(s0_$0)) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3) == Seq#Index(s0_$0,n_$3))) && ((Seq#Length(s0_$0) <= n_$3) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$3) == Seq#Index(s1_$0,n_$3 - Seq#Length(s0_$0)))) ));
	assume (forall<T> s_$2 : Seq (T) , i_$0 : Integer, v_$0 : T, len_$0 : Integer, n_$4 : Integer :: {Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4)} ( ((0 <= n_$4) && (n_$4 < len_$0)) ==> (((i_$0 == n_$4) ==> (Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4) == v_$0)) && ((!(i_$0 == n_$4)) ==> (Seq#Index(Seq#Build(s_$2,i_$0,v_$0,len_$0),n_$4) == Seq#Index(s_$2,n_$4)))) ));
	assume (forall<T> s_$3 : Seq (T) , x_$3 : T :: {Seq#Contains(s_$3,x_$3)} ( Seq#Contains(s_$3,x_$3) <==> ((exists  i_$1 : Integer :: {Seq#Index(s_$3,i_$1)} ( ((0 <= i_$1) && (i_$1 < Seq#Length(s_$3))) && (Seq#Index(s_$3,i_$1) == x_$3) ))) ));
	assume (forall  x_$4 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$4)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$4) ));
	assume (forall<T> s0_$1 : Seq (T) , s1_$1 : Seq (T) , x_$5 : T :: {Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$5)} ( Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$5) <==> (Seq#Contains(s0_$1,x_$5) || Seq#Contains(s1_$1,x_$5)) ));
	assume (forall<T> s_$4 : Seq (T) , i_$2 : Integer, v_$1 : T, len_$1 : Integer, x_$6 : T :: {Seq#Contains(Seq#Build(s_$4,i_$2,v_$1,len_$1),x_$6)} ( Seq#Contains(Seq#Build(s_$4,i_$2,v_$1,len_$1),x_$6) <==> ((((0 <= i_$2) && (i_$2 < len_$1)) && (x_$6 == v_$1)) || ((exists  j : Integer :: {Seq#Index(s_$4,j)} ( ((((0 <= j) && (j < Seq#Length(s_$4))) && (j < len_$1)) && (!(j == i_$2))) && (Seq#Index(s_$4,j) == x_$6) )))) ));
	assume (forall<T> s_$5 : Seq (T) , n_$5 : Integer, x_$7 : T :: {Seq#Contains(Seq#Take(s_$5,n_$5),x_$7)} ( Seq#Contains(Seq#Take(s_$5,n_$5),x_$7) <==> ((exists  i_$3 : Integer :: {Seq#Index(s_$5,i_$3)} ( (((0 <= i_$3) && (i_$3 < n_$5)) && (i_$3 < Seq#Length(s_$5))) && (Seq#Index(s_$5,i_$3) == x_$7) ))) ));
	assume (forall<T> s_$6 : Seq (T) , n_$6 : Integer, x_$8 : T :: {Seq#Contains(Seq#Drop(s_$6,n_$6),x_$8)} ( Seq#Contains(Seq#Drop(s_$6,n_$6),x_$8) <==> ((exists  i_$4 : Integer :: {Seq#Index(s_$6,i_$4)} ( (((0 <= n_$6) && (n_$6 <= i_$4)) && (i_$4 < Seq#Length(s_$6))) && (Seq#Index(s_$6,i_$4) == x_$8) ))) ));
	assume (forall<T> s0_$2 : Seq (T) , s1_$2 : Seq (T)  :: {Seq#Equal(s0_$2,s1_$2)} ( Seq#Equal(s0_$2,s1_$2) <==> ((Seq#Length(s0_$2) == Seq#Length(s1_$2)) && ((forall  j_$0 : Integer :: {Seq#Index(s0_$2,j_$0)} {Seq#Index(s1_$2,j_$0)} ( ((0 <= j_$0) && (j_$0 < Seq#Length(s0_$2))) ==> (Seq#Index(s0_$2,j_$0) == Seq#Index(s1_$2,j_$0)) )))) ));
	assume (forall<T> a_$3 : Seq (T) , b_$3 : Seq (T)  :: {Seq#Equal(a_$3,b_$3)} ( Seq#Equal(a_$3,b_$3) ==> (a_$3 == b_$3) ));
	assume (forall<T> s0_$3 : Seq (T) , s1_$3 : Seq (T) , n_$7 : Integer :: {Seq#SameUntil(s0_$3,s1_$3,n_$7)} ( Seq#SameUntil(s0_$3,s1_$3,n_$7) <==> ((forall  j_$1 : Integer :: {Seq#Index(s0_$3,j_$1)} {Seq#Index(s1_$3,j_$1)} ( ((0 <= j_$1) && (j_$1 < n_$7)) ==> (Seq#Index(s0_$3,j_$1) == Seq#Index(s1_$3,j_$1)) ))) ));
	assume (forall<T> s_$7 : Seq (T) , n_$8 : Integer :: {Seq#Length(Seq#Take(s_$7,n_$8))} ( (0 <= n_$8) ==> (((n_$8 <= Seq#Length(s_$7)) ==> (Seq#Length(Seq#Take(s_$7,n_$8)) == n_$8)) && ((Seq#Length(s_$7) < n_$8) ==> (Seq#Length(Seq#Take(s_$7,n_$8)) == Seq#Length(s_$7)))) ));
	assume (forall<T> s_$8 : Seq (T) , n_$9 : Integer, j_$2 : Integer :: {Seq#Index(Seq#Take(s_$8,n_$9),j_$2)} {:weight  25}( (((0 <= j_$2) && (j_$2 < n_$9)) && (j_$2 < Seq#Length(s_$8))) ==> (Seq#Index(Seq#Take(s_$8,n_$9),j_$2) == Seq#Index(s_$8,j_$2)) ));
	assume (forall<T> s_$9 : Seq (T) , n_$10 : Integer :: {Seq#Length(Seq#Drop(s_$9,n_$10))} ( (0 <= n_$10) ==> (((n_$10 <= Seq#Length(s_$9)) ==> (Seq#Length(Seq#Drop(s_$9,n_$10)) == (Seq#Length(s_$9) - n_$10))) && ((Seq#Length(s_$9) < n_$10) ==> (Seq#Length(Seq#Drop(s_$9,n_$10)) == 0))) ));
	assume (forall<T> s_$10 : Seq (T) , n_$11 : Integer, j_$3 : Integer :: {Seq#Index(Seq#Drop(s_$10,n_$11),j_$3)} {:weight  25}( (((0 <= n_$11) && (0 <= j_$3)) && (j_$3 < (Seq#Length(s_$10) - n_$11))) ==> (Seq#Index(Seq#Drop(s_$10,n_$11),j_$3) == Seq#Index(s_$10,j_$3 + n_$11)) ));
	assume (forall<T> s_$11 : Seq (T) , t_$1 : Seq (T)  :: {Seq#Append(s_$11,t_$1)} ( (Seq#Take(Seq#Append(s_$11,t_$1),Seq#Length(s_$11)) == s_$11) && (Seq#Drop(Seq#Append(s_$11,t_$1),Seq#Length(s_$11)) == t_$1) ));
	assume (forall  min : Integer, max : Integer :: {Seq#Length(Seq#Range(min,max))} ( ((min < max) ==> (Seq#Length(Seq#Range(min,max)) == (max - min))) && ((max <= min) ==> (Seq#Length(Seq#Range(min,max)) == 0)) ));
	assume (forall  min_$0 : Integer, max_$0 : Integer, j_$4 : Integer :: {Seq#Index(Seq#Range(min_$0,max_$0),j_$4)} ( ((0 <= j_$4) && (j_$4 < (max_$0 - min_$0))) ==> (Seq#Index(Seq#Range(min_$0,max_$0),j_$4) == (min_$0 + j_$4)) ));
	assume (forall<T> x_$9 : T, y_$3 : T :: {Seq#Contains(Seq#Singleton(x_$9),y_$3)} ( Seq#Contains(Seq#Singleton(x_$9),y_$3) <==> (x_$9 == y_$3) ));
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
	if ($_$_condition_$0) { goto anon65_Then; } else { goto anon65_Else; }
anon64_Else:
	assume Heap_$_4[this,SortedTree.root] == null;
	assume Mask_$_6 == Mask_$_4;
	assume Heap_$_6 == Heap_$_4;
	if ($_$_condition_$1) { goto anon65_Then; } else { goto anon65_Else; }
anon65_Then:
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
	if ($_$_condition_$2) { goto anon66_Then; } else { goto anon66_Else; }
anon65_Else:
	assume Heap_$_6[this,SortedTree.root] == null;
	assume Heap_$_8 == Heap_$_6;
	assume Mask_$_8 == Mask_$_6;
	if ($_$_condition_$3) { goto anon66_Then; } else { goto anon66_Else; }
anon66_Then:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assume Seq#Equal(Heap_$_8[this,SortedTree.keys],Heap_$_8[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys]);
	if ($_$_condition_$4) { goto anon67_Then; } else { goto anon67_Else; }
anon66_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	if ($_$_condition_$5) { goto anon67_Then; } else { goto anon67_Else; }
anon67_Then:
	assume Heap_$_8[this,SortedTree.root] == null;
	assume Seq#Equal(Heap_$_8[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon12;
anon67_Else:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto anon12;
anon12:
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assert { :msg "  93.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  93.7: Location might not be readable." } true ==> CanRead(Mask_$_8,this,SortedTree.root);
	if ($_$_condition_$6) { goto anon68_Then; } else { goto anon68_Else; }
anon68_Then:
	assume Heap_$_8[this,SortedTree.root] == null;
	assume ((0 < foldK#_114) && ((1000 * foldK#_114) < Fractions(1))) && ((1000 * foldK#_114) < methodK#_106);
	assert { :msg "  95.4: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true." } Heap_$_8[this,SortedTree.numClones] >= 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true." } Heap_$_8[this,SortedTree.numClones] < 50;
	if ($_$_condition_$7) { goto anon69_Then; } else { goto anon69_Else; }
anon68_Else:
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
	assume !(Heap_$_8[this,SortedTree.root] == null);
	if ($_$_condition_$9) { goto anon70_Then; } else { goto anon70_Else; }
anon69_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	if ($_$_condition_$10) { goto anon70_Then; } else { goto anon70_Else; }
anon77_Then:
	assume !(Heap_$_10[this,SortedTree.root] == null);
	if ($_$_condition_$11) { goto anon78_Then; } else { goto anon78_Else; }
anon77_Else:
	assume Heap_$_10[this,SortedTree.root] == null;
	if ($_$_condition_$12) { goto anon78_Then; } else { goto anon78_Else; }
anon70_Then:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	if ($_$_condition_$13) { goto anon71_Then; } else { goto anon71_Else; }
anon70_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	if ($_$_condition_$14) { goto anon71_Then; } else { goto anon71_Else; }
anon78_Then:
	assume !(Heap_$_10[this,SortedTree.root] == null);
	if ($_$_condition_$15) { goto anon79_Then; } else { goto anon79_Else; }
anon78_Else:
	assume Heap_$_10[this,SortedTree.root] == null;
	if ($_$_condition_$16) { goto anon79_Then; } else { goto anon79_Else; }
anon71_Then:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true." } Seq#Equal(Heap_$_8[this,SortedTree.keys],Heap_$_8[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys]);
	if ($_$_condition_$17) { goto anon72_Then; } else { goto anon72_Else; }
anon71_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	if ($_$_condition_$18) { goto anon72_Then; } else { goto anon72_Else; }
anon79_Then:
	assume !(Heap_$_10[this,SortedTree.root] == null);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true." } Seq#Equal(Heap_$_10[this,SortedTree.keys],Heap_$_10[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys]);
	if ($_$_condition_$19) { goto anon80_Then; } else { goto anon80_Else; }
anon79_Else:
	assume Heap_$_10[this,SortedTree.root] == null;
	if ($_$_condition_$20) { goto anon80_Then; } else { goto anon80_Else; }
anon72_Then:
	assume Heap_$_8[this,SortedTree.root] == null;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true." } Seq#Equal(Heap_$_8[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon25;
anon72_Else:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto anon25;
anon80_Then:
	assume Heap_$_10[this,SortedTree.root] == null;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true." } Seq#Equal(Heap_$_10[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon50;
anon80_Else:
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
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive." } (Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones])) > 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid." } ((Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones])) <= exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones])) == exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_115_$_3 == exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid := exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R := exhaleMask#_115_$_2[Heap_$_8[this,SortedTree.root],SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap_$_8[this,SortedTree.numClones]))]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_115_$_3);
	assume exhaleMask#_115_$_4 == exhaleMask#_115_$_3;
	if ($_$_condition_$23) { goto anon74_Then; } else { goto anon74_Else; }
anon73_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	assume exhaleMask#_115_$_4 == exhaleMask#_115_$_2;
	if ($_$_condition_$24) { goto anon74_Then; } else { goto anon74_Else; }
anon81_Then:
	assume !(Heap_$_10[this,SortedTree.root] == null);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive." } (Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones])) > 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid." } ((Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones])) <= exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones])) == exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_133_$_3 == exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid := exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R := exhaleMask#_133_$_2[Heap_$_10[this,SortedTree.root],SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap_$_10[this,SortedTree.numClones]))]];
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(Heap_$_10,exhaleMask#_133_$_3);
	assume exhaleMask#_133_$_4 == exhaleMask#_133_$_3;
	if ($_$_condition_$25) { goto anon82_Then; } else { goto anon82_Else; }
anon81_Else:
	assume Heap_$_10[this,SortedTree.root] == null;
	assume exhaleMask#_133_$_4 == exhaleMask#_133_$_2;
	if ($_$_condition_$26) { goto anon82_Then; } else { goto anon82_Else; }
anon74_Then:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive." } Fractions(50 - Heap_$_8[this,SortedTree.numClones]) > 0;
	assert { :msg "  95.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys." } (Fractions(50 - Heap_$_8[this,SortedTree.numClones]) <= exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap_$_8[this,SortedTree.numClones]) == exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_115_$_5 == exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys := exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R := exhaleMask#_115_$_4[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys][perm$R] - Fractions(50 - Heap_$_8[this,SortedTree.numClones])]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_115_$_5);
	assume exhaleMask#_115_$_6 == exhaleMask#_115_$_5;
	if ($_$_condition_$27) { goto anon75_Then; } else { goto anon75_Else; }
anon74_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	assume exhaleMask#_115_$_6 == exhaleMask#_115_$_4;
	if ($_$_condition_$28) { goto anon75_Then; } else { goto anon75_Else; }
anon82_Then:
	assume !(Heap_$_10[this,SortedTree.root] == null);
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive." } Fractions(50 - Heap_$_10[this,SortedTree.numClones]) > 0;
	assert { :msg "  100.4: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys." } (Fractions(50 - Heap_$_10[this,SortedTree.numClones]) <= exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap_$_10[this,SortedTree.numClones]) == exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_133_$_5 == exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys := exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R := exhaleMask#_133_$_4[Heap_$_10[this,SortedTree.root],SortedTreeNode.keys][perm$R] - Fractions(50 - Heap_$_10[this,SortedTree.numClones])]];
	assume IsGoodMask(Mask_$_10);
	assume wf(Heap_$_10,Mask_$_10);
	assume wf(Heap_$_10,exhaleMask#_133_$_5);
	assume exhaleMask#_133_$_6 == exhaleMask#_133_$_5;
	if ($_$_condition_$29) { goto anon83_Then; } else { goto anon83_Else; }
anon82_Else:
	assume Heap_$_10[this,SortedTree.root] == null;
	assume exhaleMask#_133_$_6 == exhaleMask#_133_$_4;
	if ($_$_condition_$30) { goto anon83_Then; } else { goto anon83_Else; }
anon75_Then:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	if ($_$_condition_$31) { goto anon76_Then; } else { goto anon76_Else; }
anon75_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	if ($_$_condition_$32) { goto anon76_Then; } else { goto anon76_Else; }
anon83_Then:
	assume !(Heap_$_10[this,SortedTree.root] == null);
	if ($_$_condition_$33) { goto anon84_Then; } else { goto anon84_Else; }
anon83_Else:
	assume Heap_$_10[this,SortedTree.root] == null;
	if ($_$_condition_$34) { goto anon84_Then; } else { goto anon84_Else; }
anon76_Then:
	assume Heap_$_8[this,SortedTree.root] == null;
	goto anon37;
anon76_Else:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto anon37;
anon84_Then:
	assume Heap_$_10[this,SortedTree.root] == null;
	goto anon62;
anon84_Else:
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
}
