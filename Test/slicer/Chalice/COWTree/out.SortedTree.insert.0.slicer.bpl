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
var n#3 : ref;
var this#40 : ref;
var r#5 : ref;
var this#42 : ref;
var r#45 : ref;
var methodK#_58 : int;
var inhaleHeap#_61_$_0 : HeapType;
var Heap_$_0 : HeapType;
var Mask_$_0 : MaskType;
var Heap_$_1 : HeapType;
var Mask_$_1 : MaskType;
var unfoldK#_62 : int;
var exhaleMask#_63_$_0 : MaskType;
var inhaleHeap#_65_$_0 : HeapType;
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
var methodCallK#_83 : int;
var this#42_$_0 : ref;
var hasClones#44_$_0 : bool;
var exhaleMask#_84_$_1 : MaskType;
var exhaleMask#_84_$_3 : MaskType;
var exhaleMask#_84_$_4 : MaskType;
var exhaleMask#_84_$_5 : MaskType;
var exhaleMask#_84_$_7 : MaskType;
var exhaleMask#_84_$_9 : MaskType;
var r#45_$_0 : ref;
var inhaleHeap#_93_$_0 : HeapType;
var Heap_$_13 : HeapType;
var Mask_$_18 : MaskType;
var Heap_$_14 : HeapType;
var Mask_$_19 : MaskType;
var Heap_$_15 : HeapType;
var Heap_$_16 : HeapType;
var foldK#_94 : int;
var exhaleMask#_95_$_0 : MaskType;
var exhaleMask#_95_$_1 : MaskType;
var exhaleMask#_95_$_2 : MaskType;
var exhaleMask#_95_$_4 : MaskType;
var exhaleMask#_95_$_6 : MaskType;
var inhaleHeap#_101_$_0 : HeapType;
var Heap_$_17 : HeapType;
var Mask_$_20 : MaskType;
var Heap_$_18 : HeapType;
var exhaleMask#_102_$_0 : MaskType;
var exhaleMask#_102_$_1 : MaskType;
var exhaleMask#_95_$_5 : MaskType;
var exhaleMask#_95_$_3 : MaskType;
var r#20 : ref;
var exhaleMask#_84_$_8 : MaskType;
var exhaleMask#_84_$_6 : MaskType;
var exhaleMask#_84_$_2 : MaskType;
var exhaleMask#_84_$_0 : MaskType;
var nw#_66_$_0 : ref;
var Mask_$_9 : MaskType;
var Mask_$_10 : MaskType;
var Mask_$_11 : MaskType;
var Mask_$_12 : MaskType;
var Mask_$_13 : MaskType;
var Mask_$_14 : MaskType;
var methodCallK#_70 : int;
var exhaleMask#_71_$_0 : MaskType;
var exhaleMask#_71_$_1 : MaskType;
var exhaleMask#_71_$_2 : MaskType;
var exhaleMask#_71_$_3 : MaskType;
var exhaleMask#_71_$_4 : MaskType;
var inhaleHeap#_79_$_0 : HeapType;
var Heap_$_9 : HeapType;
var Mask_$_15 : MaskType;
var Heap_$_10 : HeapType;
var Mask_$_16 : MaskType;
var Heap_$_11 : HeapType;
var Mask_$_17 : MaskType;
var Heap_$_12 : HeapType;
var Heap_$_7 : HeapType;
var Mask_$_7 : MaskType;
var Heap_$_5 : HeapType;
var Mask_$_5 : MaskType;
var inhaleHeap#_61 : HeapType;
var exhaleMask#_63 : MaskType;
var inhaleHeap#_65 : HeapType;
var nw#_66 : ref;
var k#41 : int;
var callHeap#_67 : HeapType;
var callMask#_68 : MaskType;
var callCredits#_69 : CreditsType;
var exhaleMask#_71 : MaskType;
var inhaleHeap#_79 : HeapType;
var k#43 : int;
var hasClones#44 : bool;
var callHeap#_80 : HeapType;
var callMask#_81 : MaskType;
var callCredits#_82 : CreditsType;
var exhaleMask#_84 : MaskType;
var inhaleHeap#_93 : HeapType;
var exhaleMask#_95 : MaskType;
var inhaleHeap#_101 : HeapType;
var exhaleMask#_102 : MaskType;
procedure SortedTree.insert (this : ref,k#1 : int)
{
	var methodK#_58 : int;
	var inhaleHeap#_61 : HeapType;
	var unfoldK#_62 : int;
	var exhaleMask#_63 : MaskType;
	var inhaleHeap#_65 : HeapType;
	var n#3 : ref;
	var nw#_66 : ref;
	var methodCallK#_70 : int;
	var this#40 : ref;
	var k#41 : int;
	var callHeap#_67 : HeapType;
	var callMask#_68 : MaskType;
	var callCredits#_69 : CreditsType;
	var exhaleMask#_71 : MaskType;
	var inhaleHeap#_79 : HeapType;
	var r#5 : ref;
	var r#20 : ref;
	var methodCallK#_83 : int;
	var this#42 : ref;
	var k#43 : int;
	var hasClones#44 : bool;
	var r#45 : ref;
	var callHeap#_80 : HeapType;
	var callMask#_81 : MaskType;
	var callCredits#_82 : CreditsType;
	var exhaleMask#_84 : MaskType;
	var inhaleHeap#_93 : HeapType;
	var foldK#_94 : int;
	var exhaleMask#_95 : MaskType;
	var inhaleHeap#_101 : HeapType;
	var exhaleMask#_102 : MaskType;
	var inhaleHeap#_61_$_0 : HeapType;
	var Heap_$_0 : HeapType;
	var Mask_$_0 : MaskType;
	var Heap_$_1 : HeapType;
	var Mask_$_1 : MaskType;
	var exhaleMask#_63_$_0 : MaskType;
	var inhaleHeap#_65_$_0 : HeapType;
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
	var nw#_66_$_0 : ref;
	var Mask_$_9 : MaskType;
	var Mask_$_10 : MaskType;
	var Mask_$_11 : MaskType;
	var Mask_$_12 : MaskType;
	var Mask_$_13 : MaskType;
	var Mask_$_14 : MaskType;
	var exhaleMask#_71_$_0 : MaskType;
	var exhaleMask#_71_$_1 : MaskType;
	var exhaleMask#_71_$_2 : MaskType;
	var exhaleMask#_71_$_3 : MaskType;
	var exhaleMask#_71_$_4 : MaskType;
	var inhaleHeap#_79_$_0 : HeapType;
	var Heap_$_9 : HeapType;
	var Mask_$_15 : MaskType;
	var Heap_$_10 : HeapType;
	var Mask_$_16 : MaskType;
	var Heap_$_11 : HeapType;
	var Mask_$_17 : MaskType;
	var Heap_$_12 : HeapType;
	var this#42_$_0 : ref;
	var hasClones#44_$_0 : bool;
	var exhaleMask#_84_$_0 : MaskType;
	var exhaleMask#_84_$_1 : MaskType;
	var exhaleMask#_84_$_2 : MaskType;
	var exhaleMask#_84_$_3 : MaskType;
	var exhaleMask#_84_$_4 : MaskType;
	var exhaleMask#_84_$_5 : MaskType;
	var exhaleMask#_84_$_6 : MaskType;
	var exhaleMask#_84_$_7 : MaskType;
	var exhaleMask#_84_$_8 : MaskType;
	var exhaleMask#_84_$_9 : MaskType;
	var r#45_$_0 : ref;
	var inhaleHeap#_93_$_0 : HeapType;
	var Heap_$_13 : HeapType;
	var Mask_$_18 : MaskType;
	var Heap_$_14 : HeapType;
	var Mask_$_19 : MaskType;
	var Heap_$_15 : HeapType;
	var Heap_$_16 : HeapType;
	var exhaleMask#_95_$_0 : MaskType;
	var exhaleMask#_95_$_1 : MaskType;
	var exhaleMask#_95_$_2 : MaskType;
	var exhaleMask#_95_$_3 : MaskType;
	var exhaleMask#_95_$_4 : MaskType;
	var exhaleMask#_95_$_5 : MaskType;
	var exhaleMask#_95_$_6 : MaskType;
	var inhaleHeap#_101_$_0 : HeapType;
	var Heap_$_17 : HeapType;
	var Mask_$_20 : MaskType;
	var Heap_$_18 : HeapType;
	var exhaleMask#_102_$_0 : MaskType;
	var exhaleMask#_102_$_1 : MaskType;
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
	assume (n#3 == null) || (dtype(n#3) == SortedTreeNode#t);
	assume (this#40 == null) || (dtype(this#40) == SortedTreeNode#t);
	assume true;
	assume (r#5 == null) || (dtype(r#5) == SortedTreeNode#t);
	assume (r#5 == null) || (dtype(r#5) == SortedTreeNode#t);
	assume (this#42 == null) || (dtype(this#42) == SortedTreeNode#t);
	assume true;
	assume true;
	assume (r#45 == null) || (dtype(r#45) == SortedTreeNode#t);
	assume !(this == null);
	assume wf(Heap,Mask);
	goto anon0;
anon0:
	assume (0 < methodK#_58) && ((1000 * methodK#_58) < Fractions(1));
	assume CurrentModule == module#default;
	assume CanAssumeFunctionDefs;
	assume IsGoodInhaleState(inhaleHeap#_61_$_0,Heap,ZeroMask);
	assume !(this == null);
	assume Heap_$_0 == Heap[this,SortedTree.valid := inhaleHeap#_61_$_0[this,SortedTree.valid]];
	assume wf(Heap_$_0,ZeroMask);
	assume inhaleHeap#_61_$_0[this,SortedTree.valid] == Heap_$_0;
	assume Fractions(100) > 0;
	assume Mask_$_0 == ZeroMask[this,SortedTree.valid := ZeroMask[this,SortedTree.valid][perm$R := ZeroMask[this,SortedTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_0);
	assume IsGoodState(inhaleHeap#_61_$_0[this,SortedTree.valid]);
	assume wf(Heap_$_0,Mask_$_0);
	assume wf(inhaleHeap#_61_$_0,Mask_$_0);
	assume !(this == null);
	assume Heap_$_1 == Heap_$_0[this,SortedTree.keys := inhaleHeap#_61_$_0[this,SortedTree.keys]];
	assume wf(Heap_$_1,Mask_$_0);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_1 == Mask_$_0[this,SortedTree.keys := Mask_$_0[this,SortedTree.keys][perm$R := Mask_$_0[this,SortedTree.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(inhaleHeap#_61_$_0[this,SortedTree.keys]);
	assume wf(Heap_$_1,Mask_$_1);
	assume wf(inhaleHeap#_61_$_0,Mask_$_1);
	assume IsGoodMask(Mask_$_1);
	assume wf(Heap_$_1,Mask_$_1);
	assume Heap_$_1 == Heap;
	assume Mask_$_1 == Mask;
	assume ZeroCredits == Credits;
	assume ((0 < unfoldK#_62) && (unfoldK#_62 < Fractions(1))) && ((1000 * unfoldK#_62) < methodK#_58);
	assert { :msg "  68.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  68.3: unfold might fail because the predicate SortedTree.valid does not hold. The permission at <undefined position> might not be positive." } Fractions(100) > 0;
	assert { :msg "  68.3: unfold might fail because the predicate SortedTree.valid does not hold. Insufficient fraction at <undefined position> for SortedTree.valid." } (Fractions(100) <= Mask_$_1[this,SortedTree.valid][perm$R]) && ((Fractions(100) == Mask_$_1[this,SortedTree.valid][perm$R]) ==> (0 <= Mask_$_1[this,SortedTree.valid][perm$N]));
	assume exhaleMask#_63_$_0 == Mask_$_1[this,SortedTree.valid := Mask_$_1[this,SortedTree.valid][perm$R := Mask_$_1[this,SortedTree.valid][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_1);
	assume wf(Heap_$_1,Mask_$_1);
	assume wf(Heap_$_1,exhaleMask#_63_$_0);
	assume wf(Heap_$_1,exhaleMask#_63_$_0);
	assume inhaleHeap#_65_$_0 == Heap_$_1[this,SortedTree.valid];
	assume IsGoodInhaleState(inhaleHeap#_65_$_0,Heap_$_1,exhaleMask#_63_$_0);
	assume !(this == null);
	assume Heap_$_2 == Heap_$_1[this,SortedTree.root := inhaleHeap#_65_$_0[this,SortedTree.root]];
	assume wf(Heap_$_2,exhaleMask#_63_$_0);
	assume (Heap_$_2[this,SortedTree.root] == null) || (dtype(Heap_$_2[this,SortedTree.root]) == SortedTreeNode#t);
	assume Fractions(100) > 0;
	assume Mask_$_2 == exhaleMask#_63_$_0[this,SortedTree.root := exhaleMask#_63_$_0[this,SortedTree.root][perm$R := exhaleMask#_63_$_0[this,SortedTree.root][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_2);
	assume IsGoodState(inhaleHeap#_65_$_0[this,SortedTree.root]);
	assume wf(Heap_$_2,Mask_$_2);
	assume wf(inhaleHeap#_65_$_0,Mask_$_2);
	assume !(this == null);
	assume Heap_$_3 == Heap_$_2[this,SortedTree.keys := inhaleHeap#_65_$_0[this,SortedTree.keys]];
	assume wf(Heap_$_3,Mask_$_2);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_3 == Mask_$_2[this,SortedTree.keys := Mask_$_2[this,SortedTree.keys][perm$R := Mask_$_2[this,SortedTree.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_3);
	assume IsGoodState(inhaleHeap#_65_$_0[this,SortedTree.keys]);
	assume wf(Heap_$_3,Mask_$_3);
	assume wf(inhaleHeap#_65_$_0,Mask_$_3);
	assume !(this == null);
	assume Heap_$_4 == Heap_$_3[this,SortedTree.numClones := inhaleHeap#_65_$_0[this,SortedTree.numClones]];
	assume wf(Heap_$_4,Mask_$_3);
	assume true;
	assume Fractions(100) > 0;
	assume Mask_$_4 == Mask_$_3[this,SortedTree.numClones := Mask_$_3[this,SortedTree.numClones][perm$R := Mask_$_3[this,SortedTree.numClones][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_4);
	assume IsGoodState(inhaleHeap#_65_$_0[this,SortedTree.numClones]);
	assume wf(Heap_$_4,Mask_$_4);
	assume wf(inhaleHeap#_65_$_0,Mask_$_4);
	assume Heap_$_4[this,SortedTree.numClones] >= 0;
	assume Heap_$_4[this,SortedTree.numClones] < 50;
	if ($_$_condition) { goto anon70_Then; } else { goto anon70_Else; }
anon70_Then:
	assume !(Heap_$_4[this,SortedTree.root] == null);
	assume !(Heap_$_4[this,SortedTree.root] == null);
	assume Heap_$_5 == Heap_$_4[Heap_$_4[this,SortedTree.root],SortedTreeNode.valid := inhaleHeap#_65_$_0[Heap_$_4[this,SortedTree.root],SortedTreeNode.valid]];
	assume wf(Heap_$_5,Mask_$_4);
	assume inhaleHeap#_65_$_0[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid] == Heap_$_5;
	assume (Fractions(100) - Fractions(Heap_$_5[this,SortedTree.numClones])) > 0;
	assume Mask_$_5 == Mask_$_4[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid := Mask_$_4[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid][perm$R := Mask_$_4[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid][perm$R] + (Fractions(100) - Fractions(Heap_$_5[this,SortedTree.numClones]))]];
	assume IsGoodMask(Mask_$_5);
	assume IsGoodState(inhaleHeap#_65_$_0[Heap_$_5[this,SortedTree.root],SortedTreeNode.valid]);
	assume wf(Heap_$_5,Mask_$_5);
	assume wf(inhaleHeap#_65_$_0,Mask_$_5);
	assume Mask_$_6 == Mask_$_5;
	assume Heap_$_6 == Heap_$_5;
	if ($_$_condition_$0) { goto anon71_Then; } else { goto anon71_Else; }
anon70_Else:
	assume Heap_$_4[this,SortedTree.root] == null;
	assume Mask_$_6 == Mask_$_4;
	assume Heap_$_6 == Heap_$_4;
	if ($_$_condition_$1) { goto anon71_Then; } else { goto anon71_Else; }
anon71_Then:
	assume !(Heap_$_6[this,SortedTree.root] == null);
	assume !(Heap_$_6[this,SortedTree.root] == null);
	assume Heap_$_7 == Heap_$_6[Heap_$_6[this,SortedTree.root],SortedTreeNode.keys := inhaleHeap#_65_$_0[Heap_$_6[this,SortedTree.root],SortedTreeNode.keys]];
	assume wf(Heap_$_7,Mask_$_6);
	assume true;
	assume Fractions(50 - Heap_$_7[this,SortedTree.numClones]) > 0;
	assume Mask_$_7 == Mask_$_6[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys := Mask_$_6[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys][perm$R := Mask_$_6[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys][perm$R] + Fractions(50 - Heap_$_7[this,SortedTree.numClones])]];
	assume IsGoodMask(Mask_$_7);
	assume IsGoodState(inhaleHeap#_65_$_0[Heap_$_7[this,SortedTree.root],SortedTreeNode.keys]);
	assume wf(Heap_$_7,Mask_$_7);
	assume wf(inhaleHeap#_65_$_0,Mask_$_7);
	assume Heap_$_8 == Heap_$_7;
	assume Mask_$_8 == Mask_$_7;
	if ($_$_condition_$2) { goto anon72_Then; } else { goto anon72_Else; }
anon71_Else:
	assume Heap_$_6[this,SortedTree.root] == null;
	assume Heap_$_8 == Heap_$_6;
	assume Mask_$_8 == Mask_$_6;
	if ($_$_condition_$3) { goto anon72_Then; } else { goto anon72_Else; }
anon72_Then:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assume Seq#Equal(Heap_$_8[this,SortedTree.keys],Heap_$_8[Heap_$_8[this,SortedTree.root],SortedTreeNode.keys]);
	if ($_$_condition_$4) { goto anon73_Then; } else { goto anon73_Else; }
anon72_Else:
	assume Heap_$_8[this,SortedTree.root] == null;
	if ($_$_condition_$5) { goto anon73_Then; } else { goto anon73_Else; }
anon73_Then:
	assume Heap_$_8[this,SortedTree.root] == null;
	assume Seq#Equal(Heap_$_8[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon12;
anon73_Else:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	goto anon12;
anon12:
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assert { :msg "  69.7: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  69.7: Location might not be readable." } true ==> CanRead(Mask_$_8,this,SortedTree.root);
	if ($_$_condition_$6) { goto anon74_Then; } else { goto anon74_Else; }
anon74_Then:
	assume Heap_$_8[this,SortedTree.root] == null;
	assume (!(nw#_66_$_0 == null)) && (dtype(nw#_66_$_0) == SortedTreeNode#t);
	assume (forall<T#_1> f_$13 : Field (T#_1)  :: ( (Mask_$_8[nw#_66_$_0,f_$13][perm$R] == 0) && (Mask_$_8[nw#_66_$_0,f_$13][perm$N] == 0) ));
	assume Heap_$_8[nw#_66_$_0,mu] == $LockBottom;
	assume Heap_$_8[nw#_66_$_0,held] <= 0;
	assume Heap_$_8[nw#_66_$_0,rdheld] <==> false;
	assume Mask_$_9 == Mask_$_8[nw#_66_$_0,SortedTreeNode.key := Mask_$_8[nw#_66_$_0,SortedTreeNode.key][perm$R := Mask_$_8[nw#_66_$_0,SortedTreeNode.key][perm$R] + Fractions(100)]];
	assume Mask_$_10 == Mask_$_9[nw#_66_$_0,SortedTreeNode.left := Mask_$_9[nw#_66_$_0,SortedTreeNode.left][perm$R := Mask_$_9[nw#_66_$_0,SortedTreeNode.left][perm$R] + Fractions(100)]];
	assume Mask_$_11 == Mask_$_10[nw#_66_$_0,SortedTreeNode.right := Mask_$_10[nw#_66_$_0,SortedTreeNode.right][perm$R := Mask_$_10[nw#_66_$_0,SortedTreeNode.right][perm$R] + Fractions(100)]];
	assume Mask_$_12 == Mask_$_11[nw#_66_$_0,SortedTreeNode.keys := Mask_$_11[nw#_66_$_0,SortedTreeNode.keys][perm$R := Mask_$_11[nw#_66_$_0,SortedTreeNode.keys][perm$R] + Fractions(100)]];
	assume Mask_$_13 == Mask_$_12[nw#_66_$_0,SortedTreeNode.shared := Mask_$_12[nw#_66_$_0,SortedTreeNode.shared][perm$R := Mask_$_12[nw#_66_$_0,SortedTreeNode.shared][perm$R] + Fractions(100)]];
	assume Mask_$_14 == Mask_$_13[nw#_66_$_0,mu := Mask_$_13[nw#_66_$_0,mu][perm$R := Mask_$_13[nw#_66_$_0,mu][perm$R] + Fractions(100)]];
	assume ((0 < methodCallK#_70) && ((1000 * methodCallK#_70) < Fractions(1))) && ((1000 * methodCallK#_70) < methodK#_58);
	assert { :msg "  71.4: The target of the method call might be null." } !(nw#_66_$_0 == null);
	assert { :msg "  71.4: The precondition at 256.12 might not hold. The permission at 256.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  71.4: The precondition at 256.12 might not hold. Insufficient fraction at 256.12 for SortedTreeNode.key." } (Fractions(100) <= Mask_$_14[nw#_66_$_0,SortedTreeNode.key][perm$R]) && ((Fractions(100) == Mask_$_14[nw#_66_$_0,SortedTreeNode.key][perm$R]) ==> (0 <= Mask_$_14[nw#_66_$_0,SortedTreeNode.key][perm$N]));
	assume exhaleMask#_71_$_0 == Mask_$_14[nw#_66_$_0,SortedTreeNode.key := Mask_$_14[nw#_66_$_0,SortedTreeNode.key][perm$R := Mask_$_14[nw#_66_$_0,SortedTreeNode.key][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_14);
	assume wf(Heap_$_8,Mask_$_14);
	assume wf(Heap_$_8,exhaleMask#_71_$_0);
	assert { :msg "  71.4: The precondition at 257.12 might not hold. The permission at 257.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  71.4: The precondition at 257.12 might not hold. Insufficient fraction at 257.12 for SortedTreeNode.left." } (Fractions(100) <= exhaleMask#_71_$_0[nw#_66_$_0,SortedTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_71_$_0[nw#_66_$_0,SortedTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_71_$_0[nw#_66_$_0,SortedTreeNode.left][perm$N]));
	assume exhaleMask#_71_$_1 == exhaleMask#_71_$_0[nw#_66_$_0,SortedTreeNode.left := exhaleMask#_71_$_0[nw#_66_$_0,SortedTreeNode.left][perm$R := exhaleMask#_71_$_0[nw#_66_$_0,SortedTreeNode.left][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_14);
	assume wf(Heap_$_8,Mask_$_14);
	assume wf(Heap_$_8,exhaleMask#_71_$_1);
	assert { :msg "  71.4: The precondition at 258.12 might not hold. The permission at 258.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  71.4: The precondition at 258.12 might not hold. Insufficient fraction at 258.12 for SortedTreeNode.right." } (Fractions(100) <= exhaleMask#_71_$_1[nw#_66_$_0,SortedTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_71_$_1[nw#_66_$_0,SortedTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_71_$_1[nw#_66_$_0,SortedTreeNode.right][perm$N]));
	assume exhaleMask#_71_$_2 == exhaleMask#_71_$_1[nw#_66_$_0,SortedTreeNode.right := exhaleMask#_71_$_1[nw#_66_$_0,SortedTreeNode.right][perm$R := exhaleMask#_71_$_1[nw#_66_$_0,SortedTreeNode.right][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_14);
	assume wf(Heap_$_8,Mask_$_14);
	assume wf(Heap_$_8,exhaleMask#_71_$_2);
	assert { :msg "  71.4: The precondition at 260.12 might not hold. The permission at 260.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  71.4: The precondition at 260.12 might not hold. Insufficient fraction at 260.12 for SortedTreeNode.keys." } (Fractions(100) <= exhaleMask#_71_$_2[nw#_66_$_0,SortedTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_71_$_2[nw#_66_$_0,SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_71_$_2[nw#_66_$_0,SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_71_$_3 == exhaleMask#_71_$_2[nw#_66_$_0,SortedTreeNode.keys := exhaleMask#_71_$_2[nw#_66_$_0,SortedTreeNode.keys][perm$R := exhaleMask#_71_$_2[nw#_66_$_0,SortedTreeNode.keys][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_14);
	assume wf(Heap_$_8,Mask_$_14);
	assume wf(Heap_$_8,exhaleMask#_71_$_3);
	assert { :msg "  71.4: The precondition at 261.12 might not hold. The permission at 261.12 might not be positive." } Fractions(100) > 0;
	assert { :msg "  71.4: The precondition at 261.12 might not hold. Insufficient fraction at 261.12 for SortedTreeNode.shared." } (Fractions(100) <= exhaleMask#_71_$_3[nw#_66_$_0,SortedTreeNode.shared][perm$R]) && ((Fractions(100) == exhaleMask#_71_$_3[nw#_66_$_0,SortedTreeNode.shared][perm$R]) ==> (0 <= exhaleMask#_71_$_3[nw#_66_$_0,SortedTreeNode.shared][perm$N]));
	assume exhaleMask#_71_$_4 == exhaleMask#_71_$_3[nw#_66_$_0,SortedTreeNode.shared := exhaleMask#_71_$_3[nw#_66_$_0,SortedTreeNode.shared][perm$R := exhaleMask#_71_$_3[nw#_66_$_0,SortedTreeNode.shared][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_14);
	assume wf(Heap_$_8,Mask_$_14);
	assume wf(Heap_$_8,exhaleMask#_71_$_4);
	assume wf(Heap_$_8,exhaleMask#_71_$_4);
	assume IsGoodInhaleState(inhaleHeap#_79_$_0,Heap_$_8,exhaleMask#_71_$_4);
	assume !(nw#_66_$_0 == null);
	assume Heap_$_9 == Heap_$_8[nw#_66_$_0,SortedTreeNode.valid := inhaleHeap#_79_$_0[nw#_66_$_0,SortedTreeNode.valid]];
	assume wf(Heap_$_9,exhaleMask#_71_$_4);
	assume inhaleHeap#_79_$_0[nw#_66_$_0,SortedTreeNode.valid] == Heap_$_9;
	assume Fractions(100) > 0;
	assume Mask_$_15 == exhaleMask#_71_$_4[nw#_66_$_0,SortedTreeNode.valid := exhaleMask#_71_$_4[nw#_66_$_0,SortedTreeNode.valid][perm$R := exhaleMask#_71_$_4[nw#_66_$_0,SortedTreeNode.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_15);
	assume IsGoodState(inhaleHeap#_79_$_0[nw#_66_$_0,SortedTreeNode.valid]);
	assume wf(Heap_$_9,Mask_$_15);
	assume wf(inhaleHeap#_79_$_0,Mask_$_15);
	assume !(nw#_66_$_0 == null);
	assume Heap_$_10 == Heap_$_9[nw#_66_$_0,SortedTreeNode.keys := inhaleHeap#_79_$_0[nw#_66_$_0,SortedTreeNode.keys]];
	assume wf(Heap_$_10,Mask_$_15);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_16 == Mask_$_15[nw#_66_$_0,SortedTreeNode.keys := Mask_$_15[nw#_66_$_0,SortedTreeNode.keys][perm$R := Mask_$_15[nw#_66_$_0,SortedTreeNode.keys][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_16);
	assume IsGoodState(inhaleHeap#_79_$_0[nw#_66_$_0,SortedTreeNode.keys]);
	assume wf(Heap_$_10,Mask_$_16);
	assume wf(inhaleHeap#_79_$_0,Mask_$_16);
	assume !(nw#_66_$_0 == null);
	assume Heap_$_11 == Heap_$_10[nw#_66_$_0,SortedTreeNode.shared := inhaleHeap#_79_$_0[nw#_66_$_0,SortedTreeNode.shared]];
	assume wf(Heap_$_11,Mask_$_16);
	assume true;
	assume Fractions(50) > 0;
	assume Mask_$_17 == Mask_$_16[nw#_66_$_0,SortedTreeNode.shared := Mask_$_16[nw#_66_$_0,SortedTreeNode.shared][perm$R := Mask_$_16[nw#_66_$_0,SortedTreeNode.shared][perm$R] + Fractions(50)]];
	assume IsGoodMask(Mask_$_17);
	assume IsGoodState(inhaleHeap#_79_$_0[nw#_66_$_0,SortedTreeNode.shared]);
	assume wf(Heap_$_11,Mask_$_17);
	assume wf(inhaleHeap#_79_$_0,Mask_$_17);
	assume !Heap_$_11[nw#_66_$_0,SortedTreeNode.shared];
	assume Seq#Equal(Heap_$_11[nw#_66_$_0,SortedTreeNode.keys],Seq#Singleton(k#1));
	assume Seq#Contains(Heap_$_11[nw#_66_$_0,SortedTreeNode.keys],k#1);
	assume IsGoodMask(Mask_$_17);
	assume wf(Heap_$_11,Mask_$_17);
	assert { :msg "  72.4: Location might not be writable" } CanWrite(Mask_$_17,this,SortedTree.root);
	assume Heap_$_12 == Heap_$_11[this,SortedTree.root := nw#_66_$_0];
	assume wf(Heap_$_12,Mask_$_17);
	assume Mask_$_19 == Mask_$_17;
	assume Heap_$_15 == Heap_$_12;
	goto anon45;
anon74_Else:
	assume !(Heap_$_8[this,SortedTree.root] == null);
	assume ((0 < methodCallK#_83) && ((1000 * methodCallK#_83) < Fractions(1))) && ((1000 * methodCallK#_83) < methodK#_58);
	assert { :msg "  75.14: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  75.14: Location might not be readable." } true ==> CanRead(Mask_$_8,this,SortedTree.root);
	assert { :msg "  75.4: The target of the method call might be null." } !(Heap_$_8[this,SortedTree.root] == null);
	assert { :msg "  75.28: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  75.28: Location might not be readable." } true ==> CanRead(Mask_$_8,this,SortedTree.numClones);
	assume this#42_$_0 == Heap_$_8[this,SortedTree.root];
	assume hasClones#44_$_0 <==> (Heap_$_8[this,SortedTree.numClones] > 0);
	if ($_$_condition_$7) { goto anon75_Then; } else { goto anon75_Else; }
anon45:
	assert { :msg "  78.3: Location might not be writable" } CanWrite(Mask_$_19,this,SortedTree.keys);
	assert { :msg "  78.11: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  78.11: Location might not be readable." } true ==> CanRead(Mask_$_19,this,SortedTree.root);
	assert { :msg "  78.11: Receiver might be null." } true ==> (!(Heap_$_15[this,SortedTree.root] == null));
	assert { :msg "  78.11: Location might not be readable." } true ==> CanRead(Mask_$_19,Heap_$_15[this,SortedTree.root],SortedTreeNode.keys);
	assume Heap_$_16 == Heap_$_15[this,SortedTree.keys := Heap_$_15[Heap_$_15[this,SortedTree.root],SortedTreeNode.keys]];
	assume wf(Heap_$_16,Mask_$_19);
	assume ((0 < foldK#_94) && ((1000 * foldK#_94) < Fractions(1))) && ((1000 * foldK#_94) < methodK#_58);
	assert { :msg "  79.3: The target of the fold statement might be null." } !(this == null);
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 15.6 might not evaluate to true." } Heap_$_16[this,SortedTree.numClones] >= 0;
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 16.6 might not evaluate to true." } Heap_$_16[this,SortedTree.numClones] < 50;
	if ($_$_condition_$23) { goto anon85_Then; } else { goto anon85_Else; }
anon75_Then:
	assume !hasClones#44_$_0;
	if ($_$_condition_$8) { goto anon76_Then; } else { goto anon76_Else; }
anon75_Else:
	assume hasClones#44_$_0;
	if ($_$_condition_$9) { goto anon76_Then; } else { goto anon76_Else; }
anon76_Then:
	assume hasClones#44_$_0;
	goto anon20;
anon76_Else:
	assume !hasClones#44_$_0;
	goto anon20;
anon20:
	assert { :msg "  75.4: The precondition at 329.12 might not hold. The expression at 329.12 might not evaluate to true." } hasClones#44_$_0 <==> Heap_$_8[this#42_$_0,SortedTreeNode.shared];
	if ($_$_condition_$10) { goto anon77_Then; } else { goto anon77_Else; }
anon77_Then:
	assume !hasClones#44_$_0;
	if ($_$_condition_$11) { goto anon78_Then; } else { goto anon78_Else; }
anon77_Else:
	assume hasClones#44_$_0;
	if ($_$_condition_$12) { goto anon78_Then; } else { goto anon78_Else; }
anon78_Then:
	assume hasClones#44_$_0;
	if ($_$_condition_$13) { goto anon79_Then; } else { goto anon79_Else; }
anon78_Else:
	assume !hasClones#44_$_0;
	if ($_$_condition_$14) { goto anon79_Then; } else { goto anon79_Else; }
anon79_Then:
	assume !hasClones#44_$_0;
	assert { :msg "  75.4: The precondition at 325.12 might not hold. The permission at 325.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  75.4: The precondition at 325.12 might not hold. Insufficient fraction at 325.27 for SortedTreeNode.valid." } (Fractions(100) <= Mask_$_8[this#42_$_0,SortedTreeNode.valid][perm$R]) && ((Fractions(100) == Mask_$_8[this#42_$_0,SortedTreeNode.valid][perm$R]) ==> (0 <= Mask_$_8[this#42_$_0,SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_84_$_0 == Mask_$_8[this#42_$_0,SortedTreeNode.valid := Mask_$_8[this#42_$_0,SortedTreeNode.valid][perm$R := Mask_$_8[this#42_$_0,SortedTreeNode.valid][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_84_$_0);
	assume exhaleMask#_84_$_1 == exhaleMask#_84_$_0;
	if ($_$_condition_$15) { goto anon80_Then; } else { goto anon80_Else; }
anon79_Else:
	assume hasClones#44_$_0;
	assume exhaleMask#_84_$_1 == Mask_$_8;
	if ($_$_condition_$16) { goto anon80_Then; } else { goto anon80_Else; }
anon80_Then:
	assume hasClones#44_$_0;
	assert { :msg "  75.4: The precondition at 326.12 might not hold. The permission at 326.26 might not be positive." } Fractions(1) > 0;
	assert { :msg "  75.4: The precondition at 326.12 might not hold. Insufficient fraction at 326.26 for SortedTreeNode.valid." } (Fractions(1) <= exhaleMask#_84_$_1[this#42_$_0,SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_84_$_1[this#42_$_0,SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84_$_1[this#42_$_0,SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_84_$_2 == exhaleMask#_84_$_1[this#42_$_0,SortedTreeNode.valid := exhaleMask#_84_$_1[this#42_$_0,SortedTreeNode.valid][perm$R := exhaleMask#_84_$_1[this#42_$_0,SortedTreeNode.valid][perm$R] - Fractions(1)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_84_$_2);
	assume exhaleMask#_84_$_3 == exhaleMask#_84_$_2;
	goto anon32;
anon80_Else:
	assume !hasClones#44_$_0;
	assume exhaleMask#_84_$_3 == exhaleMask#_84_$_1;
	goto anon32;
anon32:
	assert { :msg "  75.4: The precondition at 327.12 might not hold. The permission at 327.12 might not be positive." } Fractions(50 - ite(hasClones#44_$_0,49,0)) > 0;
	assert { :msg "  75.4: The precondition at 327.12 might not hold. Insufficient fraction at 327.12 for SortedTreeNode.valid." } (Fractions(50 - ite(hasClones#44_$_0,49,0)) <= exhaleMask#_84_$_3[this#42_$_0,SortedTreeNode.valid][perm$R]) && ((Fractions(50 - ite(hasClones#44_$_0,49,0)) == exhaleMask#_84_$_3[this#42_$_0,SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84_$_3[this#42_$_0,SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_84_$_4 == exhaleMask#_84_$_3[this#42_$_0,SortedTreeNode.valid := exhaleMask#_84_$_3[this#42_$_0,SortedTreeNode.valid][perm$R := exhaleMask#_84_$_3[this#42_$_0,SortedTreeNode.valid][perm$R] - Fractions(50 - ite(hasClones#44_$_0,49,0))]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_84_$_4);
	assert { :msg "  75.4: The precondition at 328.12 might not hold. The permission at 328.12 might not be positive." } Fractions(50 - ite(hasClones#44_$_0,49,0)) > 0;
	assert { :msg "  75.4: The precondition at 328.12 might not hold. Insufficient fraction at 328.12 for SortedTreeNode.keys." } (Fractions(50 - ite(hasClones#44_$_0,49,0)) <= exhaleMask#_84_$_4[this#42_$_0,SortedTreeNode.keys][perm$R]) && ((Fractions(50 - ite(hasClones#44_$_0,49,0)) == exhaleMask#_84_$_4[this#42_$_0,SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_84_$_4[this#42_$_0,SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_84_$_5 == exhaleMask#_84_$_4[this#42_$_0,SortedTreeNode.keys := exhaleMask#_84_$_4[this#42_$_0,SortedTreeNode.keys][perm$R := exhaleMask#_84_$_4[this#42_$_0,SortedTreeNode.keys][perm$R] - Fractions(50 - ite(hasClones#44_$_0,49,0))]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_84_$_5);
	if ($_$_condition_$17) { goto anon81_Then; } else { goto anon81_Else; }
anon81_Then:
	assume !hasClones#44_$_0;
	assert { :msg "  75.4: The precondition at 332.12 might not hold. The permission at 332.27 might not be positive." } Fractions(100) > 0;
	assert { :msg "  75.4: The precondition at 332.12 might not hold. Insufficient fraction at 332.27 for SortedTreeNode.valid." } (Fractions(100) <= exhaleMask#_84_$_5[r#20,SortedTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_84_$_5[r#20,SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84_$_5[r#20,SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_84_$_6 == exhaleMask#_84_$_5[r#20,SortedTreeNode.valid := exhaleMask#_84_$_5[r#20,SortedTreeNode.valid][perm$R := exhaleMask#_84_$_5[r#20,SortedTreeNode.valid][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_84_$_6);
	assume exhaleMask#_84_$_7 == exhaleMask#_84_$_6;
	if ($_$_condition_$18) { goto anon82_Then; } else { goto anon82_Else; }
anon81_Else:
	assume hasClones#44_$_0;
	assume exhaleMask#_84_$_7 == exhaleMask#_84_$_5;
	if ($_$_condition_$19) { goto anon82_Then; } else { goto anon82_Else; }
anon82_Then:
	assume hasClones#44_$_0;
	assert { :msg "  75.4: The precondition at 333.12 might not hold. The permission at 333.26 might not be positive." } Fractions(1) > 0;
	assert { :msg "  75.4: The precondition at 333.12 might not hold. Insufficient fraction at 333.26 for SortedTreeNode.valid." } (Fractions(1) <= exhaleMask#_84_$_7[r#20,SortedTreeNode.valid][perm$R]) && ((Fractions(1) == exhaleMask#_84_$_7[r#20,SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_84_$_7[r#20,SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_84_$_8 == exhaleMask#_84_$_7[r#20,SortedTreeNode.valid := exhaleMask#_84_$_7[r#20,SortedTreeNode.valid][perm$R := exhaleMask#_84_$_7[r#20,SortedTreeNode.valid][perm$R] - Fractions(1)]];
	assume IsGoodMask(Mask_$_8);
	assume wf(Heap_$_8,Mask_$_8);
	assume wf(Heap_$_8,exhaleMask#_84_$_8);
	assume exhaleMask#_84_$_9 == exhaleMask#_84_$_8;
	goto anon38;
anon82_Else:
	assume !hasClones#44_$_0;
	assume exhaleMask#_84_$_9 == exhaleMask#_84_$_7;
	goto anon38;
anon38:
	assume wf(Heap_$_8,exhaleMask#_84_$_9);
	assume (r#45_$_0 == null) || (dtype(r#45_$_0) == SortedTreeNode#t);
	assume IsGoodInhaleState(inhaleHeap#_93_$_0,Heap_$_8,exhaleMask#_84_$_9);
	assume !(r#45_$_0 == null);
	assume !(r#45_$_0 == null);
	assume Heap_$_13 == Heap_$_8[r#45_$_0,SortedTreeNode.keys := inhaleHeap#_93_$_0[r#45_$_0,SortedTreeNode.keys]];
	assume wf(Heap_$_13,exhaleMask#_84_$_9);
	assume true;
	assume Fractions(50 - ite(hasClones#44_$_0,49,0)) > 0;
	assume Mask_$_18 == exhaleMask#_84_$_9[r#45_$_0,SortedTreeNode.keys := exhaleMask#_84_$_9[r#45_$_0,SortedTreeNode.keys][perm$R := exhaleMask#_84_$_9[r#45_$_0,SortedTreeNode.keys][perm$R] + Fractions(50 - ite(hasClones#44_$_0,49,0))]];
	assume IsGoodMask(Mask_$_18);
	assume IsGoodState(inhaleHeap#_93_$_0[r#45_$_0,SortedTreeNode.keys]);
	assume wf(Heap_$_13,Mask_$_18);
	assume wf(inhaleHeap#_93_$_0,Mask_$_18);
	assume Seq#Contains(Heap_$_13[r#45_$_0,SortedTreeNode.keys],k#1);
	assume (forall  i#32#46 : Integer :: ( ((0 <= i#32#46) && (i#32#46 < Seq#Length(Heap_$_8[this#42_$_0,SortedTreeNode.keys]))) ==> Seq#Contains(Heap_$_13[r#45_$_0,SortedTreeNode.keys],Seq#Index(Heap_$_8[this#42_$_0,SortedTreeNode.keys],i#32#46)) ));
	assume (forall  i#33#47 : Integer :: ( ((0 <= i#33#47) && (i#33#47 < Seq#Length(Heap_$_13[r#45_$_0,SortedTreeNode.keys]))) ==> (Seq#Contains(Heap_$_8[this#42_$_0,SortedTreeNode.keys],Seq#Index(Heap_$_13[r#45_$_0,SortedTreeNode.keys],i#33#47)) || (Seq#Index(Heap_$_13[r#45_$_0,SortedTreeNode.keys],i#33#47) == k#1)) ));
	if ($_$_condition_$20) { goto anon83_Then; } else { goto anon83_Else; }
anon83_Then:
	assume Seq#Contains(Heap_$_8[this#42_$_0,SortedTreeNode.keys],k#1);
	assume Seq#Equal(Heap_$_13[r#45_$_0,SortedTreeNode.keys],Heap_$_8[this#42_$_0,SortedTreeNode.keys]);
	if ($_$_condition_$21) { goto anon84_Then; } else { goto anon84_Else; }
anon83_Else:
	assume !Seq#Contains(Heap_$_8[this#42_$_0,SortedTreeNode.keys],k#1);
	if ($_$_condition_$22) { goto anon84_Then; } else { goto anon84_Else; }
anon84_Then:
	assume !Seq#Contains(Heap_$_8[this#42_$_0,SortedTreeNode.keys],k#1);
	assume Seq#Length(Heap_$_13[r#45_$_0,SortedTreeNode.keys]) == (Seq#Length(Heap_$_8[this#42_$_0,SortedTreeNode.keys]) + 1);
	goto anon44;
anon84_Else:
	assume Seq#Contains(Heap_$_8[this#42_$_0,SortedTreeNode.keys],k#1);
	goto anon44;
anon44:
	assume IsGoodMask(Mask_$_18);
	assume wf(Heap_$_13,Mask_$_18);
	assert { :msg "  76.4: Location might not be writable" } CanWrite(Mask_$_18,this,SortedTree.root);
	assume Heap_$_14 == Heap_$_13[this,SortedTree.root := r#45_$_0];
	assume wf(Heap_$_14,Mask_$_18);
	assume Mask_$_19 == Mask_$_18;
	assume Heap_$_15 == Heap_$_14;
	goto anon45;
anon85_Then:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	if ($_$_condition_$24) { goto anon86_Then; } else { goto anon86_Else; }
anon85_Else:
	assume Heap_$_16[this,SortedTree.root] == null;
	if ($_$_condition_$25) { goto anon86_Then; } else { goto anon86_Else; }
anon86_Then:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	if ($_$_condition_$26) { goto anon87_Then; } else { goto anon87_Else; }
anon86_Else:
	assume Heap_$_16[this,SortedTree.root] == null;
	if ($_$_condition_$27) { goto anon87_Then; } else { goto anon87_Else; }
anon87_Then:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 19.22 might not evaluate to true." } Seq#Equal(Heap_$_16[this,SortedTree.keys],Heap_$_16[Heap_$_16[this,SortedTree.root],SortedTreeNode.keys]);
	if ($_$_condition_$28) { goto anon88_Then; } else { goto anon88_Else; }
anon87_Else:
	assume Heap_$_16[this,SortedTree.root] == null;
	if ($_$_condition_$29) { goto anon88_Then; } else { goto anon88_Else; }
anon88_Then:
	assume Heap_$_16[this,SortedTree.root] == null;
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The expression at 20.22 might not evaluate to true." } Seq#Equal(Heap_$_16[this,SortedTree.keys],(Seq#Empty() : Seq (Integer) ));
	goto anon57;
anon88_Else:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	goto anon57;
anon57:
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 11.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 11.6 for SortedTree.root." } (Fractions(100) <= Mask_$_19[this,SortedTree.root][perm$R]) && ((Fractions(100) == Mask_$_19[this,SortedTree.root][perm$R]) ==> (0 <= Mask_$_19[this,SortedTree.root][perm$N]));
	assume exhaleMask#_95_$_0 == Mask_$_19[this,SortedTree.root := Mask_$_19[this,SortedTree.root][perm$R := Mask_$_19[this,SortedTree.root][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume wf(Heap_$_16,Mask_$_19);
	assume wf(Heap_$_16,exhaleMask#_95_$_0);
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 12.6 might not be positive." } Fractions(50) > 0;
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 12.6 for SortedTree.keys." } (Fractions(50) <= exhaleMask#_95_$_0[this,SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_95_$_0[this,SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_95_$_0[this,SortedTree.keys][perm$N]));
	assume exhaleMask#_95_$_1 == exhaleMask#_95_$_0[this,SortedTree.keys := exhaleMask#_95_$_0[this,SortedTree.keys][perm$R := exhaleMask#_95_$_0[this,SortedTree.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(Mask_$_19);
	assume wf(Heap_$_16,Mask_$_19);
	assume wf(Heap_$_16,exhaleMask#_95_$_1);
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 13.6 might not be positive." } Fractions(100) > 0;
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 13.6 for SortedTree.numClones." } (Fractions(100) <= exhaleMask#_95_$_1[this,SortedTree.numClones][perm$R]) && ((Fractions(100) == exhaleMask#_95_$_1[this,SortedTree.numClones][perm$R]) ==> (0 <= exhaleMask#_95_$_1[this,SortedTree.numClones][perm$N]));
	assume exhaleMask#_95_$_2 == exhaleMask#_95_$_1[this,SortedTree.numClones := exhaleMask#_95_$_1[this,SortedTree.numClones][perm$R := exhaleMask#_95_$_1[this,SortedTree.numClones][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_19);
	assume wf(Heap_$_16,Mask_$_19);
	assume wf(Heap_$_16,exhaleMask#_95_$_2);
	if ($_$_condition_$30) { goto anon89_Then; } else { goto anon89_Else; }
anon89_Then:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 17.22 might not be positive." } (Fractions(100) - Fractions(Heap_$_16[this,SortedTree.numClones])) > 0;
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 17.22 for SortedTreeNode.valid." } ((Fractions(100) - Fractions(Heap_$_16[this,SortedTree.numClones])) <= exhaleMask#_95_$_2[Heap_$_16[this,SortedTree.root],SortedTreeNode.valid][perm$R]) && (((Fractions(100) - Fractions(Heap_$_16[this,SortedTree.numClones])) == exhaleMask#_95_$_2[Heap_$_16[this,SortedTree.root],SortedTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_95_$_2[Heap_$_16[this,SortedTree.root],SortedTreeNode.valid][perm$N]));
	assume exhaleMask#_95_$_3 == exhaleMask#_95_$_2[Heap_$_16[this,SortedTree.root],SortedTreeNode.valid := exhaleMask#_95_$_2[Heap_$_16[this,SortedTree.root],SortedTreeNode.valid][perm$R := exhaleMask#_95_$_2[Heap_$_16[this,SortedTree.root],SortedTreeNode.valid][perm$R] - (Fractions(100) - Fractions(Heap_$_16[this,SortedTree.numClones]))]];
	assume IsGoodMask(Mask_$_19);
	assume wf(Heap_$_16,Mask_$_19);
	assume wf(Heap_$_16,exhaleMask#_95_$_3);
	assume exhaleMask#_95_$_4 == exhaleMask#_95_$_3;
	if ($_$_condition_$31) { goto anon90_Then; } else { goto anon90_Else; }
anon89_Else:
	assume Heap_$_16[this,SortedTree.root] == null;
	assume exhaleMask#_95_$_4 == exhaleMask#_95_$_2;
	if ($_$_condition_$32) { goto anon90_Then; } else { goto anon90_Else; }
anon90_Then:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. The permission at 18.22 might not be positive." } Fractions(50 - Heap_$_16[this,SortedTree.numClones]) > 0;
	assert { :msg "  79.3: Fold might fail because the definition of SortedTree.valid does not hold. Insufficient fraction at 18.22 for SortedTreeNode.keys." } (Fractions(50 - Heap_$_16[this,SortedTree.numClones]) <= exhaleMask#_95_$_4[Heap_$_16[this,SortedTree.root],SortedTreeNode.keys][perm$R]) && ((Fractions(50 - Heap_$_16[this,SortedTree.numClones]) == exhaleMask#_95_$_4[Heap_$_16[this,SortedTree.root],SortedTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_95_$_4[Heap_$_16[this,SortedTree.root],SortedTreeNode.keys][perm$N]));
	assume exhaleMask#_95_$_5 == exhaleMask#_95_$_4[Heap_$_16[this,SortedTree.root],SortedTreeNode.keys := exhaleMask#_95_$_4[Heap_$_16[this,SortedTree.root],SortedTreeNode.keys][perm$R := exhaleMask#_95_$_4[Heap_$_16[this,SortedTree.root],SortedTreeNode.keys][perm$R] - Fractions(50 - Heap_$_16[this,SortedTree.numClones])]];
	assume IsGoodMask(Mask_$_19);
	assume wf(Heap_$_16,Mask_$_19);
	assume wf(Heap_$_16,exhaleMask#_95_$_5);
	assume exhaleMask#_95_$_6 == exhaleMask#_95_$_5;
	if ($_$_condition_$33) { goto anon91_Then; } else { goto anon91_Else; }
anon90_Else:
	assume Heap_$_16[this,SortedTree.root] == null;
	assume exhaleMask#_95_$_6 == exhaleMask#_95_$_4;
	if ($_$_condition_$34) { goto anon91_Then; } else { goto anon91_Else; }
anon91_Then:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	if ($_$_condition_$35) { goto anon92_Then; } else { goto anon92_Else; }
anon91_Else:
	assume Heap_$_16[this,SortedTree.root] == null;
	if ($_$_condition_$36) { goto anon92_Then; } else { goto anon92_Else; }
anon92_Then:
	assume Heap_$_16[this,SortedTree.root] == null;
	goto anon69;
anon92_Else:
	assume !(Heap_$_16[this,SortedTree.root] == null);
	goto anon69;
anon69:
	assume wf(Heap_$_16,exhaleMask#_95_$_6);
	assume IsGoodInhaleState(inhaleHeap#_101_$_0,Heap_$_16,exhaleMask#_95_$_6);
	assume !(this == null);
	assume Heap_$_17 == Heap_$_16[this,SortedTree.valid := inhaleHeap#_101_$_0[this,SortedTree.valid]];
	assume wf(Heap_$_17,exhaleMask#_95_$_6);
	assume inhaleHeap#_101_$_0[this,SortedTree.valid] == Heap_$_17;
	assume Fractions(100) > 0;
	assume Mask_$_20 == exhaleMask#_95_$_6[this,SortedTree.valid := exhaleMask#_95_$_6[this,SortedTree.valid][perm$R := exhaleMask#_95_$_6[this,SortedTree.valid][perm$R] + Fractions(100)]];
	assume IsGoodMask(Mask_$_20);
	assume IsGoodState(inhaleHeap#_101_$_0[this,SortedTree.valid]);
	assume wf(Heap_$_17,Mask_$_20);
	assume wf(inhaleHeap#_101_$_0,Mask_$_20);
	assume IsGoodMask(Mask_$_20);
	assume wf(Heap_$_17,Mask_$_20);
	assume Heap_$_18 == Heap_$_17[this,SortedTree.valid := Heap_$_17];
	assume wf(Heap_$_18,Mask_$_20);
	assert { :msg "  57.2: The postcondition at 64.11 might not hold. The expression at 64.11 might not evaluate to true." } Seq#Contains(Heap_$_18[this,SortedTree.keys],k#1);
	assert { :msg "  57.2: The postcondition at 65.11 might not hold. The expression at 65.11 might not evaluate to true." } (forall  j#25#48 : Integer :: ( ((0 <= j#25#48) && (j#25#48 < Seq#Length(Heap[this,SortedTree.keys]))) ==> Seq#Contains(Heap_$_18[this,SortedTree.keys],Seq#Index(Heap[this,SortedTree.keys],j#25#48)) ));
	assert { :msg "  57.2: The postcondition at 66.11 might not hold. The expression at 66.11 might not evaluate to true." } (forall  j#26#49 : Integer :: ( ((0 <= j#26#49) && (j#26#49 < Seq#Length(Heap_$_18[this,SortedTree.keys]))) ==> (Seq#Contains(Heap[this,SortedTree.keys],Seq#Index(Heap_$_18[this,SortedTree.keys],j#26#49)) || (Seq#Index(Heap_$_18[this,SortedTree.keys],j#26#49) == k#1)) ));
	assert { :msg "  57.2: The postcondition at 61.11 might not hold. The permission at 61.11 might not be positive." } Fractions(100) > 0;
	assert { :msg "  57.2: The postcondition at 61.11 might not hold. Insufficient fraction at 61.11 for SortedTree.valid." } (Fractions(100) <= Mask_$_20[this,SortedTree.valid][perm$R]) && ((Fractions(100) == Mask_$_20[this,SortedTree.valid][perm$R]) ==> (0 <= Mask_$_20[this,SortedTree.valid][perm$N]));
	assume exhaleMask#_102_$_0 == Mask_$_20[this,SortedTree.valid := Mask_$_20[this,SortedTree.valid][perm$R := Mask_$_20[this,SortedTree.valid][perm$R] - Fractions(100)]];
	assume IsGoodMask(Mask_$_20);
	assume wf(Heap_$_18,Mask_$_20);
	assume wf(Heap_$_18,exhaleMask#_102_$_0);
	assert { :msg "  57.2: The postcondition at 62.11 might not hold. The permission at 62.11 might not be positive." } Fractions(50) > 0;
	assert { :msg "  57.2: The postcondition at 62.11 might not hold. Insufficient fraction at 62.11 for SortedTree.keys." } (Fractions(50) <= exhaleMask#_102_$_0[this,SortedTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_102_$_0[this,SortedTree.keys][perm$R]) ==> (0 <= exhaleMask#_102_$_0[this,SortedTree.keys][perm$N]));
	assume exhaleMask#_102_$_1 == exhaleMask#_102_$_0[this,SortedTree.keys := exhaleMask#_102_$_0[this,SortedTree.keys][perm$R := exhaleMask#_102_$_0[this,SortedTree.keys][perm$R] - Fractions(50)]];
	assume IsGoodMask(Mask_$_20);
	assume wf(Heap_$_18,Mask_$_20);
	assume wf(Heap_$_18,exhaleMask#_102_$_1);
	assume wf(Heap_$_18,exhaleMask#_102_$_1);
	assert { :msg "  57.2: Method might lock/unlock more than allowed." } (forall  lk#_105 : ref :: {Heap_$_18[lk#_105,held]} {Heap_$_18[lk#_105,rdheld]} ( (((0 < Heap_$_18[lk#_105,held]) <==> (0 < Heap[lk#_105,held])) && (Heap_$_18[lk#_105,rdheld] <==> Heap[lk#_105,rdheld])) || false ));
	assert { :msg "  57.2: Method body is not allowed to leave any debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
