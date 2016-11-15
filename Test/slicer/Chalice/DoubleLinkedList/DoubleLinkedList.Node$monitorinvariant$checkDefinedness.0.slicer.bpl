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
const unique Node#t : TypeName;
const unique module#default : ModuleName;
const unique Node.next : Field (ref);
const unique Node.prev : Field (ref);
const unique Node.inv : Field (int);
const unique Node.invLeft : Field (int);
const unique Node.invRight : Field (int);
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
function {:expand  false} CanRead <T> (MaskType,MaskType,ref,Field (T)) : bool;
function {:expand  false} CanReadForSure <T> (MaskType,ref,Field (T)) : bool;
function {:expand  false} CanWrite <T> (MaskType,ref,Field (T)) : bool;
function {:expand  true} IsGoodMask(MaskType) : bool;
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
function #Node.inv#trigger(ref) : bool;
function #Node.invLeft#trigger(ref) : bool;
function #Node.invRight#trigger(ref) : bool;
var Heap : HeapType;
var Mask : MaskType;
var SecMask : MaskType;
var Credits : CreditsType;
var methodK#_9 : int;
var h0#_0 : HeapType;
var m0#_1 : MaskType;
var sm0#_2 : MaskType;
var h1#_4 : HeapType;
var m1#_5 : MaskType;
var sm1#_6 : MaskType;
var h1#_4_$_0 : HeapType;
var m1#_5_$_0 : MaskType;
var m1#_5_$_1 : MaskType;
var m1#_5_$_2 : MaskType;
var m1#_5_$_3 : MaskType;
var m1#_5_$_4 : MaskType;
var m1#_5_$_5 : MaskType;
var m1#_5_$_9 : MaskType;
var m1#_5_$_13 : MaskType;
var m1#_5_$_17 : MaskType;
var m1#_5_$_21 : MaskType;
var Heap_$_0 : HeapType;
var Mask_$_0 : MaskType;
var Mask_$_1 : MaskType;
var Mask_$_2 : MaskType;
var Mask_$_3 : MaskType;
var Mask_$_4 : MaskType;
var Mask_$_5 : MaskType;
var Mask_$_9 : MaskType;
var Mask_$_13 : MaskType;
var Mask_$_17 : MaskType;
var Mask_$_21 : MaskType;
var exhaleMask#_11_$_0 : MaskType;
var exhaleMask#_11_$_1 : MaskType;
var exhaleMask#_11_$_2 : MaskType;
var exhaleMask#_11_$_3 : MaskType;
var exhaleMask#_11_$_4 : MaskType;
var exhaleMask#_11_$_5 : MaskType;
var exhaleMask#_11_$_9 : MaskType;
var exhaleMask#_11_$_13 : MaskType;
var exhaleMask#_11_$_17 : MaskType;
var exhaleMask#_11_$_21 : MaskType;
var exhaleHeap#_10_$_0 : HeapType;
var exhaleMask#_11_$_18 : MaskType;
var exhaleMask#_11_$_19 : MaskType;
var exhaleMask#_11_$_20 : MaskType;
var exhaleMask#_11_$_14 : MaskType;
var exhaleMask#_11_$_15 : MaskType;
var exhaleMask#_11_$_16 : MaskType;
var exhaleMask#_11_$_10 : MaskType;
var exhaleMask#_11_$_11 : MaskType;
var exhaleMask#_11_$_12 : MaskType;
var exhaleMask#_11_$_6 : MaskType;
var exhaleMask#_11_$_7 : MaskType;
var exhaleMask#_11_$_8 : MaskType;
var Mask_$_18 : MaskType;
var Mask_$_19 : MaskType;
var Mask_$_20 : MaskType;
var Mask_$_14 : MaskType;
var Mask_$_15 : MaskType;
var Mask_$_16 : MaskType;
var Mask_$_10 : MaskType;
var Mask_$_11 : MaskType;
var Mask_$_12 : MaskType;
var Mask_$_6 : MaskType;
var Mask_$_7 : MaskType;
var Mask_$_8 : MaskType;
var m1#_5_$_18 : MaskType;
var m1#_5_$_19 : MaskType;
var m1#_5_$_20 : MaskType;
var m1#_5_$_14 : MaskType;
var m1#_5_$_15 : MaskType;
var m1#_5_$_16 : MaskType;
var m1#_5_$_10 : MaskType;
var m1#_5_$_11 : MaskType;
var m1#_5_$_12 : MaskType;
var m1#_5_$_6 : MaskType;
var m1#_5_$_7 : MaskType;
var m1#_5_$_8 : MaskType;
var c1#_7 : CreditsType;
var exhaleMask#_11 : MaskType;
var exhaleHeap#_10 : HeapType;
procedure Node$monitorinvariant$checkDefinedness (this : ref)
{
	var methodK#_9 : int;
	var h0#_0 : HeapType;
	var m0#_1 : MaskType;
	var sm0#_2 : MaskType;
	var h1#_4 : HeapType;
	var m1#_5 : MaskType;
	var sm1#_6 : MaskType;
	var c1#_7 : CreditsType;
	var exhaleMask#_11 : MaskType;
	var exhaleHeap#_10 : HeapType;
	var h1#_4_$_0 : HeapType;
	var m1#_5_$_0 : MaskType;
	var m1#_5_$_1 : MaskType;
	var m1#_5_$_2 : MaskType;
	var m1#_5_$_3 : MaskType;
	var m1#_5_$_4 : MaskType;
	var m1#_5_$_5 : MaskType;
	var m1#_5_$_6 : MaskType;
	var m1#_5_$_7 : MaskType;
	var m1#_5_$_8 : MaskType;
	var m1#_5_$_9 : MaskType;
	var m1#_5_$_10 : MaskType;
	var m1#_5_$_11 : MaskType;
	var m1#_5_$_12 : MaskType;
	var m1#_5_$_13 : MaskType;
	var m1#_5_$_14 : MaskType;
	var m1#_5_$_15 : MaskType;
	var m1#_5_$_16 : MaskType;
	var m1#_5_$_17 : MaskType;
	var m1#_5_$_18 : MaskType;
	var m1#_5_$_19 : MaskType;
	var m1#_5_$_20 : MaskType;
	var m1#_5_$_21 : MaskType;
	var Heap_$_0 : HeapType;
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
	var Mask_$_19 : MaskType;
	var Mask_$_20 : MaskType;
	var Mask_$_21 : MaskType;
	var exhaleHeap#_10_$_0 : HeapType;
	var exhaleMask#_11_$_0 : MaskType;
	var exhaleMask#_11_$_1 : MaskType;
	var exhaleMask#_11_$_2 : MaskType;
	var exhaleMask#_11_$_3 : MaskType;
	var exhaleMask#_11_$_4 : MaskType;
	var exhaleMask#_11_$_5 : MaskType;
	var exhaleMask#_11_$_6 : MaskType;
	var exhaleMask#_11_$_7 : MaskType;
	var exhaleMask#_11_$_8 : MaskType;
	var exhaleMask#_11_$_9 : MaskType;
	var exhaleMask#_11_$_10 : MaskType;
	var exhaleMask#_11_$_11 : MaskType;
	var exhaleMask#_11_$_12 : MaskType;
	var exhaleMask#_11_$_13 : MaskType;
	var exhaleMask#_11_$_14 : MaskType;
	var exhaleMask#_11_$_15 : MaskType;
	var exhaleMask#_11_$_16 : MaskType;
	var exhaleMask#_11_$_17 : MaskType;
	var exhaleMask#_11_$_18 : MaskType;
	var exhaleMask#_11_$_19 : MaskType;
	var exhaleMask#_11_$_20 : MaskType;
	var exhaleMask#_11_$_21 : MaskType;
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
	assume (forall<T> m_$4 : MaskType, sm_$1 : MaskType, obj : ref, f_$3 : Field (T)  :: {CanRead(m_$4,sm_$1,obj,f_$3)} {:expand  false}( CanRead(m_$4,sm_$1,obj,f_$3) <==> ((((0 < m_$4[obj,f_$3][perm$R]) || (0 < m_$4[obj,f_$3][perm$N])) || (0 < sm_$1[obj,f_$3][perm$R])) || (0 < sm_$1[obj,f_$3][perm$N])) ));
	assume (forall<T> m_$5 : MaskType, obj_$0 : ref, f_$4 : Field (T)  :: {CanReadForSure(m_$5,obj_$0,f_$4)} {:expand  false}( CanReadForSure(m_$5,obj_$0,f_$4) <==> ((0 < m_$5[obj_$0,f_$4][perm$R]) || (0 < m_$5[obj_$0,f_$4][perm$N])) ));
	assume (forall<T> m_$6 : MaskType, obj_$1 : ref, f_$5 : Field (T)  :: {CanWrite(m_$6,obj_$1,f_$5)} {:expand  false}( CanWrite(m_$6,obj_$1,f_$5) <==> ((m_$6[obj_$1,f_$5][perm$R] == Permission$FullFraction) && (m_$6[obj_$1,f_$5][perm$N] == 0)) ));
	assume (forall  m_$7 : MaskType :: {IsGoodMask(m_$7)} {:expand  true}( IsGoodMask(m_$7) <==> ((forall<T> o_$14 : ref, f_$6 : Field (T)  :: ( ((0 <= m_$7[o_$14,f_$6][perm$R]) && (NonPredicateField(f_$6) ==> ((m_$7[o_$14,f_$6][perm$R] <= Permission$FullFraction) && ((0 < m_$7[o_$14,f_$6][perm$N]) ==> (m_$7[o_$14,f_$6][perm$R] < Permission$FullFraction))))) && ((m_$7[o_$14,f_$6][perm$N] < 0) ==> (0 < m_$7[o_$14,f_$6][perm$R])) ))) ));
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
	assume (forall  x_$0 : Integer, y_$0 : Integer :: {x_$0 mod y_$0} {x_$0 div y_$0} ( (x_$0 mod y_$0) == (x_$0 - ((x_$0 div y_$0) * y_$0)) ));
	assume (forall  x_$1 : Integer, y_$1 : Integer :: {x_$1 mod y_$1} ( (0 < y_$1) ==> ((0 <= (x_$1 mod y_$1)) && ((x_$1 mod y_$1) < y_$1)) ));
	assume (forall  x_$2 : Integer, y_$2 : Integer :: {x_$2 mod y_$2} ( (y_$2 < 0) ==> ((y_$2 < (x_$2 mod y_$2)) && ((x_$2 mod y_$2) <= 0)) ));
	assume (forall  a_$2 : Integer, b_$2 : Integer, d : Integer :: {a_$2 mod d,b_$2 mod d} ( (((2 <= d) && ((a_$2 mod d) == (b_$2 mod d))) && (a_$2 < b_$2)) ==> ((a_$2 + d) <= b_$2) ));
	assume NonPredicateField(Node.next);
	assume NonPredicateField(Node.prev);
	assume PredicateField(Node.inv);
	assume PredicateField(Node.invLeft);
	assume PredicateField(Node.invRight);
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume IsGoodMask(Mask);
	assume IsGoodMask(SecMask);
	assume (this == null) || (dtype(this) == Node#t);
	assume !(this == null);
	assume wf(Heap,Mask,SecMask);
	goto anon0;
anon0:
	assume (0 < methodK#_9) && ((1000 * methodK#_9) < Fractions(1));
	assume wf(h0#_0,m0#_1,sm0#_2);
	assume wf(h1#_4,m1#_5,sm1#_6);
	assume !(this == null);
	assume wf(h1#_4_$_0,ZeroMask,ZeroMask);
	assume (h1#_4_$_0[this,Node.prev] == null) || (dtype(h1#_4_$_0[this,Node.prev]) == Node#t);
	assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assume m1#_5_$_0 == ZeroMask[this,Node.prev := ZeroMask[this,Node.prev][perm$R := ZeroMask[this,Node.prev][perm$R] + (Fractions(50) - 0)]];
	assume m1#_5_$_1 == m1#_5_$_0[this,Node.prev := m1#_5_$_0[this,Node.prev][perm$N := m1#_5_$_0[this,Node.prev][perm$N] + (0 - 1)]];
	assume wf(h1#_4_$_0,m1#_5_$_1,ZeroMask);
	assume IsGoodMask(m1#_5_$_1);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,Node.prev]));
	assume wf(h1#_4_$_0,m1#_5_$_1,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_1,ZeroMask);
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_1,ZeroMask);
	assume (h1#_4_$_0[this,Node.next] == null) || (dtype(h1#_4_$_0[this,Node.next]) == Node#t);
	assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assume m1#_5_$_2 == m1#_5_$_1[this,Node.next := m1#_5_$_1[this,Node.next][perm$R := m1#_5_$_1[this,Node.next][perm$R] + (Fractions(50) - 0)]];
	assume m1#_5_$_3 == m1#_5_$_2[this,Node.next := m1#_5_$_2[this,Node.next][perm$N := m1#_5_$_2[this,Node.next][perm$N] + (0 - 1)]];
	assume wf(h1#_4_$_0,m1#_5_$_3,ZeroMask);
	assume IsGoodMask(m1#_5_$_3);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,Node.next]));
	assume wf(h1#_4_$_0,m1#_5_$_3,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_3,ZeroMask);
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_3,ZeroMask);
	assume true;
	assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assume m1#_5_$_4 == m1#_5_$_3[this,mu := m1#_5_$_3[this,mu][perm$R := m1#_5_$_3[this,mu][perm$R] + (Fractions(50) - 0)]];
	assume m1#_5_$_5 == m1#_5_$_4[this,mu := m1#_5_$_4[this,mu][perm$N := m1#_5_$_4[this,mu][perm$N] + (0 - 1)]];
	assume wf(h1#_4_$_0,m1#_5_$_5,ZeroMask);
	assume IsGoodMask(m1#_5_$_5);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,mu]));
	assume wf(h1#_4_$_0,m1#_5_$_5,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_5,ZeroMask);
	if ($_$_condition) { goto anon49_Then; } else { goto anon49_Else; }
anon49_Then:
	assume h1#_4_$_0[this,Node.next] == null;
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_5,ZeroMask);
	assume (h1#_4_$_0[this,Node.prev] == null) || (dtype(h1#_4_$_0[this,Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_6 == m1#_5_$_5[this,Node.prev := m1#_5_$_5[this,Node.prev][perm$R := m1#_5_$_5[this,Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_6);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,Node.prev]));
	assume wf(h1#_4_$_0,m1#_5_$_6,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_6,ZeroMask);
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_6,ZeroMask);
	assume (h1#_4_$_0[this,Node.next] == null) || (dtype(h1#_4_$_0[this,Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_7 == m1#_5_$_6[this,Node.next := m1#_5_$_6[this,Node.next][perm$R := m1#_5_$_6[this,Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_7);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,Node.next]));
	assume wf(h1#_4_$_0,m1#_5_$_7,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_7,ZeroMask);
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_7,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume m1#_5_$_8 == m1#_5_$_7[this,mu := m1#_5_$_7[this,mu][perm$R := m1#_5_$_7[this,mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_8);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,mu]));
	assume wf(h1#_4_$_0,m1#_5_$_8,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_8,ZeroMask);
	assume m1#_5_$_9 == m1#_5_$_8;
	if ($_$_condition_$0) { goto anon50_Then; } else { goto anon50_Else; }
anon49_Else:
	assume !(h1#_4_$_0[this,Node.next] == null);
	assume m1#_5_$_9 == m1#_5_$_5;
	if ($_$_condition_$1) { goto anon50_Then; } else { goto anon50_Else; }
anon50_Then:
	assume !(h1#_4_$_0[this,Node.next] == null);
	assume !(h1#_4_$_0[this,Node.next] == null);
	assume wf(h1#_4_$_0,m1#_5_$_9,ZeroMask);
	assume (h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.next] == null) || (dtype(h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_10 == m1#_5_$_9[h1#_4_$_0[this,Node.next],Node.next := m1#_5_$_9[h1#_4_$_0[this,Node.next],Node.next][perm$R := m1#_5_$_9[h1#_4_$_0[this,Node.next],Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_10);
	assume IsGoodState(heapFragment(h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.next]));
	assume wf(h1#_4_$_0,m1#_5_$_10,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_10,ZeroMask);
	assume !(h1#_4_$_0[this,Node.next] == null);
	assume wf(h1#_4_$_0,m1#_5_$_10,ZeroMask);
	assume (h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.prev] == null) || (dtype(h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_11 == m1#_5_$_10[h1#_4_$_0[this,Node.next],Node.prev := m1#_5_$_10[h1#_4_$_0[this,Node.next],Node.prev][perm$R := m1#_5_$_10[h1#_4_$_0[this,Node.next],Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_11);
	assume IsGoodState(heapFragment(h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.prev]));
	assume wf(h1#_4_$_0,m1#_5_$_11,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_11,ZeroMask);
	assume !(h1#_4_$_0[this,Node.next] == null);
	assume wf(h1#_4_$_0,m1#_5_$_11,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume m1#_5_$_12 == m1#_5_$_11[h1#_4_$_0[this,Node.next],mu := m1#_5_$_11[h1#_4_$_0[this,Node.next],mu][perm$R := m1#_5_$_11[h1#_4_$_0[this,Node.next],mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_12);
	assume IsGoodState(heapFragment(h1#_4_$_0[h1#_4_$_0[this,Node.next],mu]));
	assume wf(h1#_4_$_0,m1#_5_$_12,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_12,ZeroMask);
	assume m1#_5_$_13 == m1#_5_$_12;
	if ($_$_condition_$2) { goto anon51_Then; } else { goto anon51_Else; }
anon50_Else:
	assume h1#_4_$_0[this,Node.next] == null;
	assume m1#_5_$_13 == m1#_5_$_9;
	if ($_$_condition_$3) { goto anon51_Then; } else { goto anon51_Else; }
anon51_Then:
	assume h1#_4_$_0[this,Node.prev] == null;
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_13,ZeroMask);
	assume (h1#_4_$_0[this,Node.prev] == null) || (dtype(h1#_4_$_0[this,Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_14 == m1#_5_$_13[this,Node.prev := m1#_5_$_13[this,Node.prev][perm$R := m1#_5_$_13[this,Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_14);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,Node.prev]));
	assume wf(h1#_4_$_0,m1#_5_$_14,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_14,ZeroMask);
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_14,ZeroMask);
	assume (h1#_4_$_0[this,Node.next] == null) || (dtype(h1#_4_$_0[this,Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_15 == m1#_5_$_14[this,Node.next := m1#_5_$_14[this,Node.next][perm$R := m1#_5_$_14[this,Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_15);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,Node.next]));
	assume wf(h1#_4_$_0,m1#_5_$_15,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_15,ZeroMask);
	assume !(this == null);
	assume wf(h1#_4_$_0,m1#_5_$_15,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume m1#_5_$_16 == m1#_5_$_15[this,mu := m1#_5_$_15[this,mu][perm$R := m1#_5_$_15[this,mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_16);
	assume IsGoodState(heapFragment(h1#_4_$_0[this,mu]));
	assume wf(h1#_4_$_0,m1#_5_$_16,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_16,ZeroMask);
	assume m1#_5_$_17 == m1#_5_$_16;
	if ($_$_condition_$4) { goto anon52_Then; } else { goto anon52_Else; }
anon51_Else:
	assume !(h1#_4_$_0[this,Node.prev] == null);
	assume m1#_5_$_17 == m1#_5_$_13;
	if ($_$_condition_$5) { goto anon52_Then; } else { goto anon52_Else; }
anon52_Then:
	assume !(h1#_4_$_0[this,Node.prev] == null);
	assume !(h1#_4_$_0[this,Node.prev] == null);
	assume wf(h1#_4_$_0,m1#_5_$_17,ZeroMask);
	assume (h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.next] == null) || (dtype(h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_18 == m1#_5_$_17[h1#_4_$_0[this,Node.prev],Node.next := m1#_5_$_17[h1#_4_$_0[this,Node.prev],Node.next][perm$R := m1#_5_$_17[h1#_4_$_0[this,Node.prev],Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_18);
	assume IsGoodState(heapFragment(h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.next]));
	assume wf(h1#_4_$_0,m1#_5_$_18,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_18,ZeroMask);
	assume !(h1#_4_$_0[this,Node.prev] == null);
	assume wf(h1#_4_$_0,m1#_5_$_18,ZeroMask);
	assume (h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.prev] == null) || (dtype(h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume m1#_5_$_19 == m1#_5_$_18[h1#_4_$_0[this,Node.prev],Node.prev := m1#_5_$_18[h1#_4_$_0[this,Node.prev],Node.prev][perm$R := m1#_5_$_18[h1#_4_$_0[this,Node.prev],Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_19);
	assume IsGoodState(heapFragment(h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.prev]));
	assume wf(h1#_4_$_0,m1#_5_$_19,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_19,ZeroMask);
	assume !(h1#_4_$_0[this,Node.prev] == null);
	assume wf(h1#_4_$_0,m1#_5_$_19,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume m1#_5_$_20 == m1#_5_$_19[h1#_4_$_0[this,Node.prev],mu := m1#_5_$_19[h1#_4_$_0[this,Node.prev],mu][perm$R := m1#_5_$_19[h1#_4_$_0[this,Node.prev],mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(m1#_5_$_20);
	assume IsGoodState(heapFragment(h1#_4_$_0[h1#_4_$_0[this,Node.prev],mu]));
	assume wf(h1#_4_$_0,m1#_5_$_20,ZeroMask);
	assume wf(h1#_4_$_0,m1#_5_$_20,ZeroMask);
	assume m1#_5_$_21 == m1#_5_$_20;
	if ($_$_condition_$6) { goto anon53_Then; } else { goto anon53_Else; }
anon52_Else:
	assume h1#_4_$_0[this,Node.prev] == null;
	assume m1#_5_$_21 == m1#_5_$_17;
	if ($_$_condition_$7) { goto anon53_Then; } else { goto anon53_Else; }
anon53_Then:
	assume !(h1#_4_$_0[this,Node.next] == null);
	assume !(h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.prev] == null);
	assume h1#_4_$_0[h1#_4_$_0[this,Node.next],Node.prev] == this;
	if ($_$_condition_$8) { goto anon54_Then; } else { goto anon54_Else; }
anon53_Else:
	assume h1#_4_$_0[this,Node.next] == null;
	if ($_$_condition_$9) { goto anon54_Then; } else { goto anon54_Else; }
anon54_Then:
	assume !(h1#_4_$_0[this,Node.prev] == null);
	assume !(h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.next] == null);
	assume h1#_4_$_0[h1#_4_$_0[this,Node.prev],Node.next] == this;
	if ($_$_condition_$10) { goto anon55_Then; } else { goto anon55_Else; }
anon54_Else:
	assume h1#_4_$_0[this,Node.prev] == null;
	if ($_$_condition_$11) { goto anon55_Then; } else { goto anon55_Else; }
anon55_Then:
	assume !(h1#_4_$_0[this,Node.next] == null);
	assume MuBelow(h1#_4_$_0[this,mu],h1#_4_$_0[h1#_4_$_0[this,Node.next],mu]);
	if ($_$_condition_$12) { goto anon56_Then; } else { goto anon56_Else; }
anon55_Else:
	assume h1#_4_$_0[this,Node.next] == null;
	if ($_$_condition_$13) { goto anon56_Then; } else { goto anon56_Else; }
anon56_Then:
	assume !(h1#_4_$_0[this,Node.prev] == null);
	assume MuBelow(h1#_4_$_0[h1#_4_$_0[this,Node.prev],mu],h1#_4_$_0[this,mu]);
	goto anon16;
anon56_Else:
	assume h1#_4_$_0[this,Node.prev] == null;
	goto anon16;
anon16:
	assume IsGoodMask(m1#_5_$_21);
	assume wf(h1#_4_$_0,m1#_5_$_21,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_0,ZeroMask,ZeroMask);
	assume (Heap_$_0[this,Node.prev] == null) || (dtype(Heap_$_0[this,Node.prev]) == Node#t);
	assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assume Mask_$_0 == ZeroMask[this,Node.prev := ZeroMask[this,Node.prev][perm$R := ZeroMask[this,Node.prev][perm$R] + (Fractions(50) - 0)]];
	assume Mask_$_1 == Mask_$_0[this,Node.prev := Mask_$_0[this,Node.prev][perm$N := Mask_$_0[this,Node.prev][perm$N] + (0 - 1)]];
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	assume IsGoodMask(Mask_$_1);
	assume IsGoodState(heapFragment(Heap_$_0[this,Node.prev]));
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_1,ZeroMask);
	assume (Heap_$_0[this,Node.next] == null) || (dtype(Heap_$_0[this,Node.next]) == Node#t);
	assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assume Mask_$_2 == Mask_$_1[this,Node.next := Mask_$_1[this,Node.next][perm$R := Mask_$_1[this,Node.next][perm$R] + (Fractions(50) - 0)]];
	assume Mask_$_3 == Mask_$_2[this,Node.next := Mask_$_2[this,Node.next][perm$N := Mask_$_2[this,Node.next][perm$N] + (0 - 1)]];
	assume wf(Heap_$_0,Mask_$_3,ZeroMask);
	assume IsGoodMask(Mask_$_3);
	assume IsGoodState(heapFragment(Heap_$_0[this,Node.next]));
	assume wf(Heap_$_0,Mask_$_3,ZeroMask);
	assume wf(Heap_$_0,Mask_$_3,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_3,ZeroMask);
	assume true;
	assume ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assume Mask_$_4 == Mask_$_3[this,mu := Mask_$_3[this,mu][perm$R := Mask_$_3[this,mu][perm$R] + (Fractions(50) - 0)]];
	assume Mask_$_5 == Mask_$_4[this,mu := Mask_$_4[this,mu][perm$N := Mask_$_4[this,mu][perm$N] + (0 - 1)]];
	assume wf(Heap_$_0,Mask_$_5,ZeroMask);
	assume IsGoodMask(Mask_$_5);
	assume IsGoodState(heapFragment(Heap_$_0[this,mu]));
	assume wf(Heap_$_0,Mask_$_5,ZeroMask);
	assume wf(Heap_$_0,Mask_$_5,ZeroMask);
	assert { :msg "  7.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  7.15: Location might not be readable." } true ==> CanRead(Mask_$_5,ZeroMask,this,Node.next);
	if ($_$_condition_$14) { goto anon57_Then; } else { goto anon57_Else; }
anon57_Then:
	assume Heap_$_0[this,Node.next] == null;
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_5,ZeroMask);
	assume (Heap_$_0[this,Node.prev] == null) || (dtype(Heap_$_0[this,Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_6 == Mask_$_5[this,Node.prev := Mask_$_5[this,Node.prev][perm$R := Mask_$_5[this,Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_6);
	assume IsGoodState(heapFragment(Heap_$_0[this,Node.prev]));
	assume wf(Heap_$_0,Mask_$_6,ZeroMask);
	assume wf(Heap_$_0,Mask_$_6,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_6,ZeroMask);
	assume (Heap_$_0[this,Node.next] == null) || (dtype(Heap_$_0[this,Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_7 == Mask_$_6[this,Node.next := Mask_$_6[this,Node.next][perm$R := Mask_$_6[this,Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_7);
	assume IsGoodState(heapFragment(Heap_$_0[this,Node.next]));
	assume wf(Heap_$_0,Mask_$_7,ZeroMask);
	assume wf(Heap_$_0,Mask_$_7,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_7,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume Mask_$_8 == Mask_$_7[this,mu := Mask_$_7[this,mu][perm$R := Mask_$_7[this,mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_8);
	assume IsGoodState(heapFragment(Heap_$_0[this,mu]));
	assume wf(Heap_$_0,Mask_$_8,ZeroMask);
	assume wf(Heap_$_0,Mask_$_8,ZeroMask);
	assume Mask_$_9 == Mask_$_8;
	goto anon18;
anon57_Else:
	assume !(Heap_$_0[this,Node.next] == null);
	assume Mask_$_9 == Mask_$_5;
	goto anon18;
anon18:
	assert { :msg "  8.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  8.15: Location might not be readable." } true ==> CanRead(Mask_$_9,ZeroMask,this,Node.next);
	if ($_$_condition_$15) { goto anon58_Then; } else { goto anon58_Else; }
anon58_Then:
	assume !(Heap_$_0[this,Node.next] == null);
	assert { :msg "  8.35: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  8.35: Location might not be readable." } true ==> CanRead(Mask_$_9,ZeroMask,this,Node.next);
	assume !(Heap_$_0[this,Node.next] == null);
	assume wf(Heap_$_0,Mask_$_9,ZeroMask);
	assume (Heap_$_0[Heap_$_0[this,Node.next],Node.next] == null) || (dtype(Heap_$_0[Heap_$_0[this,Node.next],Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_10 == Mask_$_9[Heap_$_0[this,Node.next],Node.next := Mask_$_9[Heap_$_0[this,Node.next],Node.next][perm$R := Mask_$_9[Heap_$_0[this,Node.next],Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_10);
	assume IsGoodState(heapFragment(Heap_$_0[Heap_$_0[this,Node.next],Node.next]));
	assume wf(Heap_$_0,Mask_$_10,ZeroMask);
	assume wf(Heap_$_0,Mask_$_10,ZeroMask);
	assert { :msg "  8.57: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  8.57: Location might not be readable." } true ==> CanRead(Mask_$_10,ZeroMask,this,Node.next);
	assume !(Heap_$_0[this,Node.next] == null);
	assume wf(Heap_$_0,Mask_$_10,ZeroMask);
	assume (Heap_$_0[Heap_$_0[this,Node.next],Node.prev] == null) || (dtype(Heap_$_0[Heap_$_0[this,Node.next],Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_11 == Mask_$_10[Heap_$_0[this,Node.next],Node.prev := Mask_$_10[Heap_$_0[this,Node.next],Node.prev][perm$R := Mask_$_10[Heap_$_0[this,Node.next],Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_11);
	assume IsGoodState(heapFragment(Heap_$_0[Heap_$_0[this,Node.next],Node.prev]));
	assume wf(Heap_$_0,Mask_$_11,ZeroMask);
	assume wf(Heap_$_0,Mask_$_11,ZeroMask);
	assert { :msg "  8.79: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  8.79: Location might not be readable." } true ==> CanRead(Mask_$_11,ZeroMask,this,Node.next);
	assume !(Heap_$_0[this,Node.next] == null);
	assume wf(Heap_$_0,Mask_$_11,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume Mask_$_12 == Mask_$_11[Heap_$_0[this,Node.next],mu := Mask_$_11[Heap_$_0[this,Node.next],mu][perm$R := Mask_$_11[Heap_$_0[this,Node.next],mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_12);
	assume IsGoodState(heapFragment(Heap_$_0[Heap_$_0[this,Node.next],mu]));
	assume wf(Heap_$_0,Mask_$_12,ZeroMask);
	assume wf(Heap_$_0,Mask_$_12,ZeroMask);
	assume Mask_$_13 == Mask_$_12;
	goto anon20;
anon58_Else:
	assume Heap_$_0[this,Node.next] == null;
	assume Mask_$_13 == Mask_$_9;
	goto anon20;
anon20:
	assert { :msg "  9.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  9.15: Location might not be readable." } true ==> CanRead(Mask_$_13,ZeroMask,this,Node.prev);
	if ($_$_condition_$16) { goto anon59_Then; } else { goto anon59_Else; }
anon59_Then:
	assume Heap_$_0[this,Node.prev] == null;
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_13,ZeroMask);
	assume (Heap_$_0[this,Node.prev] == null) || (dtype(Heap_$_0[this,Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_14 == Mask_$_13[this,Node.prev := Mask_$_13[this,Node.prev][perm$R := Mask_$_13[this,Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_14);
	assume IsGoodState(heapFragment(Heap_$_0[this,Node.prev]));
	assume wf(Heap_$_0,Mask_$_14,ZeroMask);
	assume wf(Heap_$_0,Mask_$_14,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_14,ZeroMask);
	assume (Heap_$_0[this,Node.next] == null) || (dtype(Heap_$_0[this,Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_15 == Mask_$_14[this,Node.next := Mask_$_14[this,Node.next][perm$R := Mask_$_14[this,Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_15);
	assume IsGoodState(heapFragment(Heap_$_0[this,Node.next]));
	assume wf(Heap_$_0,Mask_$_15,ZeroMask);
	assume wf(Heap_$_0,Mask_$_15,ZeroMask);
	assume !(this == null);
	assume wf(Heap_$_0,Mask_$_15,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume Mask_$_16 == Mask_$_15[this,mu := Mask_$_15[this,mu][perm$R := Mask_$_15[this,mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_16);
	assume IsGoodState(heapFragment(Heap_$_0[this,mu]));
	assume wf(Heap_$_0,Mask_$_16,ZeroMask);
	assume wf(Heap_$_0,Mask_$_16,ZeroMask);
	assume Mask_$_17 == Mask_$_16;
	goto anon22;
anon59_Else:
	assume !(Heap_$_0[this,Node.prev] == null);
	assume Mask_$_17 == Mask_$_13;
	goto anon22;
anon22:
	assert { :msg "  10.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  10.15: Location might not be readable." } true ==> CanRead(Mask_$_17,ZeroMask,this,Node.prev);
	if ($_$_condition_$17) { goto anon60_Then; } else { goto anon60_Else; }
anon60_Then:
	assume !(Heap_$_0[this,Node.prev] == null);
	assert { :msg "  10.35: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  10.35: Location might not be readable." } true ==> CanRead(Mask_$_17,ZeroMask,this,Node.prev);
	assume !(Heap_$_0[this,Node.prev] == null);
	assume wf(Heap_$_0,Mask_$_17,ZeroMask);
	assume (Heap_$_0[Heap_$_0[this,Node.prev],Node.next] == null) || (dtype(Heap_$_0[Heap_$_0[this,Node.prev],Node.next]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_18 == Mask_$_17[Heap_$_0[this,Node.prev],Node.next := Mask_$_17[Heap_$_0[this,Node.prev],Node.next][perm$R := Mask_$_17[Heap_$_0[this,Node.prev],Node.next][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_18);
	assume IsGoodState(heapFragment(Heap_$_0[Heap_$_0[this,Node.prev],Node.next]));
	assume wf(Heap_$_0,Mask_$_18,ZeroMask);
	assume wf(Heap_$_0,Mask_$_18,ZeroMask);
	assert { :msg "  10.57: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  10.57: Location might not be readable." } true ==> CanRead(Mask_$_18,ZeroMask,this,Node.prev);
	assume !(Heap_$_0[this,Node.prev] == null);
	assume wf(Heap_$_0,Mask_$_18,ZeroMask);
	assume (Heap_$_0[Heap_$_0[this,Node.prev],Node.prev] == null) || (dtype(Heap_$_0[Heap_$_0[this,Node.prev],Node.prev]) == Node#t);
	assume Fractions(25) > 0;
	assume Mask_$_19 == Mask_$_18[Heap_$_0[this,Node.prev],Node.prev := Mask_$_18[Heap_$_0[this,Node.prev],Node.prev][perm$R := Mask_$_18[Heap_$_0[this,Node.prev],Node.prev][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_19);
	assume IsGoodState(heapFragment(Heap_$_0[Heap_$_0[this,Node.prev],Node.prev]));
	assume wf(Heap_$_0,Mask_$_19,ZeroMask);
	assume wf(Heap_$_0,Mask_$_19,ZeroMask);
	assert { :msg "  10.79: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  10.79: Location might not be readable." } true ==> CanRead(Mask_$_19,ZeroMask,this,Node.prev);
	assume !(Heap_$_0[this,Node.prev] == null);
	assume wf(Heap_$_0,Mask_$_19,ZeroMask);
	assume true;
	assume Fractions(25) > 0;
	assume Mask_$_20 == Mask_$_19[Heap_$_0[this,Node.prev],mu := Mask_$_19[Heap_$_0[this,Node.prev],mu][perm$R := Mask_$_19[Heap_$_0[this,Node.prev],mu][perm$R] + Fractions(25)]];
	assume IsGoodMask(Mask_$_20);
	assume IsGoodState(heapFragment(Heap_$_0[Heap_$_0[this,Node.prev],mu]));
	assume wf(Heap_$_0,Mask_$_20,ZeroMask);
	assume wf(Heap_$_0,Mask_$_20,ZeroMask);
	assume Mask_$_21 == Mask_$_20;
	goto anon24;
anon60_Else:
	assume Heap_$_0[this,Node.prev] == null;
	assume Mask_$_21 == Mask_$_17;
	goto anon24;
anon24:
	assert { :msg "  11.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  11.15: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.next);
	if ($_$_condition_$18) { goto anon61_Then; } else { goto anon61_Else; }
anon61_Then:
	assume !(Heap_$_0[this,Node.next] == null);
	assert { :msg "  11.31: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  11.31: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.next);
	assert { :msg "  11.31: Receiver might be null." } true ==> (!(Heap_$_0[this,Node.next] == null));
	assert { :msg "  11.31: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,Node.next],Node.prev);
	assume !(Heap_$_0[Heap_$_0[this,Node.next],Node.prev] == null);
	assert { :msg "  11.52: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  11.52: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.next);
	assert { :msg "  11.52: Receiver might be null." } true ==> (!(Heap_$_0[this,Node.next] == null));
	assert { :msg "  11.52: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,Node.next],Node.prev);
	assume Heap_$_0[Heap_$_0[this,Node.next],Node.prev] == this;
	goto anon26;
anon61_Else:
	assume Heap_$_0[this,Node.next] == null;
	goto anon26;
anon26:
	assert { :msg "  12.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  12.15: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.prev);
	if ($_$_condition_$19) { goto anon62_Then; } else { goto anon62_Else; }
anon62_Then:
	assume !(Heap_$_0[this,Node.prev] == null);
	assert { :msg "  12.31: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  12.31: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.prev);
	assert { :msg "  12.31: Receiver might be null." } true ==> (!(Heap_$_0[this,Node.prev] == null));
	assert { :msg "  12.31: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,Node.prev],Node.next);
	assume !(Heap_$_0[Heap_$_0[this,Node.prev],Node.next] == null);
	assert { :msg "  12.52: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  12.52: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.prev);
	assert { :msg "  12.52: Receiver might be null." } true ==> (!(Heap_$_0[this,Node.prev] == null));
	assert { :msg "  12.52: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,Node.prev],Node.next);
	assume Heap_$_0[Heap_$_0[this,Node.prev],Node.next] == this;
	goto anon28;
anon62_Else:
	assume Heap_$_0[this,Node.prev] == null;
	goto anon28;
anon28:
	assert { :msg "  13.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  13.15: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.next);
	if ($_$_condition_$20) { goto anon63_Then; } else { goto anon63_Else; }
anon63_Then:
	assume !(Heap_$_0[this,Node.next] == null);
	assert { :msg "  13.30: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  13.30: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,mu);
	assert { :msg "  13.41: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  13.41: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.next);
	assert { :msg "  13.41: Receiver might be null." } true ==> (!(Heap_$_0[this,Node.next] == null));
	assert { :msg "  13.41: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,Node.next],mu);
	assume MuBelow(Heap_$_0[this,mu],Heap_$_0[Heap_$_0[this,Node.next],mu]);
	goto anon30;
anon63_Else:
	assume Heap_$_0[this,Node.next] == null;
	goto anon30;
anon30:
	assert { :msg "  14.15: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  14.15: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.prev);
	if ($_$_condition_$21) { goto anon64_Then; } else { goto anon64_Else; }
anon64_Then:
	assume !(Heap_$_0[this,Node.prev] == null);
	assert { :msg "  14.30: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  14.30: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,Node.prev);
	assert { :msg "  14.30: Receiver might be null." } true ==> (!(Heap_$_0[this,Node.prev] == null));
	assert { :msg "  14.30: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,Heap_$_0[this,Node.prev],mu);
	assert { :msg "  14.41: Receiver might be null." } true ==> (!(this == null));
	assert { :msg "  14.41: Location might not be readable." } true ==> CanRead(Mask_$_21,ZeroMask,this,mu);
	assume MuBelow(Heap_$_0[Heap_$_0[this,Node.prev],mu],Heap_$_0[this,mu]);
	goto anon32;
anon64_Else:
	assume Heap_$_0[this,Node.prev] == null;
	goto anon32;
anon32:
	assume IsGoodMask(Mask_$_21);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  1.1: SMOKE-TEST-50. (Monitor invariant is equivalent to false.)" } !(1 == 1);
	if ($_$_condition_$22) { goto anon65_Then; } else { goto anon65_Else; }
anon65_Then:
	assume !(Heap_$_0[this,Node.next] == null);
	assert { :msg "  11.5: Monitor invariant might not be reflexive. The expression at 11.31 might not evaluate to true." } !(Heap_$_0[Heap_$_0[this,Node.next],Node.prev] == null);
	assert { :msg "  11.5: Monitor invariant might not be reflexive. The expression at 11.52 might not evaluate to true." } Heap_$_0[Heap_$_0[this,Node.next],Node.prev] == this;
	if ($_$_condition_$23) { goto anon66_Then; } else { goto anon66_Else; }
anon65_Else:
	assume Heap_$_0[this,Node.next] == null;
	if ($_$_condition_$24) { goto anon66_Then; } else { goto anon66_Else; }
anon66_Then:
	assume !(Heap_$_0[this,Node.prev] == null);
	assert { :msg "  12.5: Monitor invariant might not be reflexive. The expression at 12.31 might not evaluate to true." } !(Heap_$_0[Heap_$_0[this,Node.prev],Node.next] == null);
	assert { :msg "  12.5: Monitor invariant might not be reflexive. The expression at 12.52 might not evaluate to true." } Heap_$_0[Heap_$_0[this,Node.prev],Node.next] == this;
	if ($_$_condition_$25) { goto anon67_Then; } else { goto anon67_Else; }
anon66_Else:
	assume Heap_$_0[this,Node.prev] == null;
	if ($_$_condition_$26) { goto anon67_Then; } else { goto anon67_Else; }
anon67_Then:
	assume !(Heap_$_0[this,Node.next] == null);
	assert { :msg "  13.5: Monitor invariant might not be reflexive. The expression at 13.30 might not evaluate to true." } MuBelow(Heap_$_0[this,mu],Heap_$_0[Heap_$_0[this,Node.next],mu]);
	if ($_$_condition_$27) { goto anon68_Then; } else { goto anon68_Else; }
anon67_Else:
	assume Heap_$_0[this,Node.next] == null;
	if ($_$_condition_$28) { goto anon68_Then; } else { goto anon68_Else; }
anon68_Then:
	assume !(Heap_$_0[this,Node.prev] == null);
	assert { :msg "  14.5: Monitor invariant might not be reflexive. The expression at 14.30 might not evaluate to true." } MuBelow(Heap_$_0[Heap_$_0[this,Node.prev],mu],Heap_$_0[this,mu]);
	goto anon40;
anon68_Else:
	assume Heap_$_0[this,Node.prev] == null;
	goto anon40;
anon40:
	assert { :msg "  6.5: Monitor invariant might not be reflexive. The permission at 6.15 might not be positive." } ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assert { :msg "  6.5: Monitor invariant might not be reflexive. Insufficient permission at 6.15 for Node.prev." } ((Fractions(50) - 0) <= Mask_$_21[this,Node.prev][perm$R]) && (((Fractions(50) - 0) == Mask_$_21[this,Node.prev][perm$R]) ==> ((0 - 1) <= Mask_$_21[this,Node.prev][perm$N]));
	assume exhaleMask#_11_$_0 == Mask_$_21[this,Node.prev := Mask_$_21[this,Node.prev][perm$N := Mask_$_21[this,Node.prev][perm$N] - (0 - 1)]];
	assume exhaleMask#_11_$_1 == exhaleMask#_11_$_0[this,Node.prev := exhaleMask#_11_$_0[this,Node.prev][perm$R := exhaleMask#_11_$_0[this,Node.prev][perm$R] - (Fractions(50) - 0)]];
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_11_$_1);
	assume wf(Heap_$_0,exhaleMask#_11_$_1,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  6.5: Monitor invariant might not be reflexive. The permission at 6.38 might not be positive." } ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assert { :msg "  6.5: Monitor invariant might not be reflexive. Insufficient permission at 6.38 for Node.next." } ((Fractions(50) - 0) <= exhaleMask#_11_$_1[this,Node.next][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_11_$_1[this,Node.next][perm$R]) ==> ((0 - 1) <= exhaleMask#_11_$_1[this,Node.next][perm$N]));
	assume exhaleMask#_11_$_2 == exhaleMask#_11_$_1[this,Node.next := exhaleMask#_11_$_1[this,Node.next][perm$N := exhaleMask#_11_$_1[this,Node.next][perm$N] - (0 - 1)]];
	assume exhaleMask#_11_$_3 == exhaleMask#_11_$_2[this,Node.next := exhaleMask#_11_$_2[this,Node.next][perm$R := exhaleMask#_11_$_2[this,Node.next][perm$R] - (Fractions(50) - 0)]];
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_11_$_3);
	assume wf(Heap_$_0,exhaleMask#_11_$_3,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  6.5: Monitor invariant might not be reflexive. The permission at 6.61 might not be positive." } ((Fractions(50) - 0) > 0) || (false && ((0 - 1) > 0));
	assert { :msg "  6.5: Monitor invariant might not be reflexive. Insufficient permission at 6.61 for mu." } ((Fractions(50) - 0) <= exhaleMask#_11_$_3[this,mu][perm$R]) && (((Fractions(50) - 0) == exhaleMask#_11_$_3[this,mu][perm$R]) ==> ((0 - 1) <= exhaleMask#_11_$_3[this,mu][perm$N]));
	assume exhaleMask#_11_$_4 == exhaleMask#_11_$_3[this,mu := exhaleMask#_11_$_3[this,mu][perm$N := exhaleMask#_11_$_3[this,mu][perm$N] - (0 - 1)]];
	assume exhaleMask#_11_$_5 == exhaleMask#_11_$_4[this,mu := exhaleMask#_11_$_4[this,mu][perm$R := exhaleMask#_11_$_4[this,mu][perm$R] - (Fractions(50) - 0)]];
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_11_$_5);
	assume wf(Heap_$_0,exhaleMask#_11_$_5,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	if ($_$_condition_$29) { goto anon69_Then; } else { goto anon69_Else; }
anon69_Then:
	assume Heap_$_0[this,Node.next] == null;
	assert { :msg "  7.5: Monitor invariant might not be reflexive. The permission at 7.31 might not be positive." } Fractions(25) > 0;
	assert { :msg "  7.5: Monitor invariant might not be reflexive. Insufficient fraction at 7.31 for Node.prev." } (Fractions(25) <= exhaleMask#_11_$_5[this,Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_5[this,Node.prev][perm$R]) ==> (0 <= exhaleMask#_11_$_5[this,Node.prev][perm$N]));
	assume exhaleMask#_11_$_6 == exhaleMask#_11_$_5[this,Node.prev := exhaleMask#_11_$_5[this,Node.prev][perm$R := exhaleMask#_11_$_5[this,Node.prev][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_6);
	assume wf(Heap_$_0,exhaleMask#_11_$_6,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  7.5: Monitor invariant might not be reflexive. The permission at 7.48 might not be positive." } Fractions(25) > 0;
	assert { :msg "  7.5: Monitor invariant might not be reflexive. Insufficient fraction at 7.48 for Node.next." } (Fractions(25) <= exhaleMask#_11_$_6[this,Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_6[this,Node.next][perm$R]) ==> (0 <= exhaleMask#_11_$_6[this,Node.next][perm$N]));
	assume exhaleMask#_11_$_7 == exhaleMask#_11_$_6[this,Node.next := exhaleMask#_11_$_6[this,Node.next][perm$R := exhaleMask#_11_$_6[this,Node.next][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_7);
	assume wf(Heap_$_0,exhaleMask#_11_$_7,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  7.5: Monitor invariant might not be reflexive. The permission at 7.65 might not be positive." } Fractions(25) > 0;
	assert { :msg "  7.5: Monitor invariant might not be reflexive. Insufficient fraction at 7.65 for mu." } (Fractions(25) <= exhaleMask#_11_$_7[this,mu][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_7[this,mu][perm$R]) ==> (0 <= exhaleMask#_11_$_7[this,mu][perm$N]));
	assume exhaleMask#_11_$_8 == exhaleMask#_11_$_7[this,mu := exhaleMask#_11_$_7[this,mu][perm$R := exhaleMask#_11_$_7[this,mu][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_8);
	assume wf(Heap_$_0,exhaleMask#_11_$_8,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assume exhaleMask#_11_$_9 == exhaleMask#_11_$_8;
	if ($_$_condition_$30) { goto anon70_Then; } else { goto anon70_Else; }
anon69_Else:
	assume !(Heap_$_0[this,Node.next] == null);
	assume exhaleMask#_11_$_9 == exhaleMask#_11_$_5;
	if ($_$_condition_$31) { goto anon70_Then; } else { goto anon70_Else; }
anon70_Then:
	assume !(Heap_$_0[this,Node.next] == null);
	assert { :msg "  8.5: Monitor invariant might not be reflexive. The permission at 8.31 might not be positive." } Fractions(25) > 0;
	assert { :msg "  8.5: Monitor invariant might not be reflexive. Insufficient fraction at 8.31 for Node.next." } (Fractions(25) <= exhaleMask#_11_$_9[Heap_$_0[this,Node.next],Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_9[Heap_$_0[this,Node.next],Node.next][perm$R]) ==> (0 <= exhaleMask#_11_$_9[Heap_$_0[this,Node.next],Node.next][perm$N]));
	assume exhaleMask#_11_$_10 == exhaleMask#_11_$_9[Heap_$_0[this,Node.next],Node.next := exhaleMask#_11_$_9[Heap_$_0[this,Node.next],Node.next][perm$R := exhaleMask#_11_$_9[Heap_$_0[this,Node.next],Node.next][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_10);
	assume wf(Heap_$_0,exhaleMask#_11_$_10,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  8.5: Monitor invariant might not be reflexive. The permission at 8.53 might not be positive." } Fractions(25) > 0;
	assert { :msg "  8.5: Monitor invariant might not be reflexive. Insufficient fraction at 8.53 for Node.prev." } (Fractions(25) <= exhaleMask#_11_$_10[Heap_$_0[this,Node.next],Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_10[Heap_$_0[this,Node.next],Node.prev][perm$R]) ==> (0 <= exhaleMask#_11_$_10[Heap_$_0[this,Node.next],Node.prev][perm$N]));
	assume exhaleMask#_11_$_11 == exhaleMask#_11_$_10[Heap_$_0[this,Node.next],Node.prev := exhaleMask#_11_$_10[Heap_$_0[this,Node.next],Node.prev][perm$R := exhaleMask#_11_$_10[Heap_$_0[this,Node.next],Node.prev][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_11);
	assume wf(Heap_$_0,exhaleMask#_11_$_11,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  8.5: Monitor invariant might not be reflexive. The permission at 8.75 might not be positive." } Fractions(25) > 0;
	assert { :msg "  8.5: Monitor invariant might not be reflexive. Insufficient fraction at 8.75 for mu." } (Fractions(25) <= exhaleMask#_11_$_11[Heap_$_0[this,Node.next],mu][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_11[Heap_$_0[this,Node.next],mu][perm$R]) ==> (0 <= exhaleMask#_11_$_11[Heap_$_0[this,Node.next],mu][perm$N]));
	assume exhaleMask#_11_$_12 == exhaleMask#_11_$_11[Heap_$_0[this,Node.next],mu := exhaleMask#_11_$_11[Heap_$_0[this,Node.next],mu][perm$R := exhaleMask#_11_$_11[Heap_$_0[this,Node.next],mu][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_12);
	assume wf(Heap_$_0,exhaleMask#_11_$_12,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assume exhaleMask#_11_$_13 == exhaleMask#_11_$_12;
	if ($_$_condition_$32) { goto anon71_Then; } else { goto anon71_Else; }
anon70_Else:
	assume Heap_$_0[this,Node.next] == null;
	assume exhaleMask#_11_$_13 == exhaleMask#_11_$_9;
	if ($_$_condition_$33) { goto anon71_Then; } else { goto anon71_Else; }
anon71_Then:
	assume Heap_$_0[this,Node.prev] == null;
	assert { :msg "  9.5: Monitor invariant might not be reflexive. The permission at 9.31 might not be positive." } Fractions(25) > 0;
	assert { :msg "  9.5: Monitor invariant might not be reflexive. Insufficient fraction at 9.31 for Node.prev." } (Fractions(25) <= exhaleMask#_11_$_13[this,Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_13[this,Node.prev][perm$R]) ==> (0 <= exhaleMask#_11_$_13[this,Node.prev][perm$N]));
	assume exhaleMask#_11_$_14 == exhaleMask#_11_$_13[this,Node.prev := exhaleMask#_11_$_13[this,Node.prev][perm$R := exhaleMask#_11_$_13[this,Node.prev][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_14);
	assume wf(Heap_$_0,exhaleMask#_11_$_14,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  9.5: Monitor invariant might not be reflexive. The permission at 9.48 might not be positive." } Fractions(25) > 0;
	assert { :msg "  9.5: Monitor invariant might not be reflexive. Insufficient fraction at 9.48 for Node.next." } (Fractions(25) <= exhaleMask#_11_$_14[this,Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_14[this,Node.next][perm$R]) ==> (0 <= exhaleMask#_11_$_14[this,Node.next][perm$N]));
	assume exhaleMask#_11_$_15 == exhaleMask#_11_$_14[this,Node.next := exhaleMask#_11_$_14[this,Node.next][perm$R := exhaleMask#_11_$_14[this,Node.next][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_15);
	assume wf(Heap_$_0,exhaleMask#_11_$_15,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  9.5: Monitor invariant might not be reflexive. The permission at 9.65 might not be positive." } Fractions(25) > 0;
	assert { :msg "  9.5: Monitor invariant might not be reflexive. Insufficient fraction at 9.65 for mu." } (Fractions(25) <= exhaleMask#_11_$_15[this,mu][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_15[this,mu][perm$R]) ==> (0 <= exhaleMask#_11_$_15[this,mu][perm$N]));
	assume exhaleMask#_11_$_16 == exhaleMask#_11_$_15[this,mu := exhaleMask#_11_$_15[this,mu][perm$R := exhaleMask#_11_$_15[this,mu][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_16);
	assume wf(Heap_$_0,exhaleMask#_11_$_16,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assume exhaleMask#_11_$_17 == exhaleMask#_11_$_16;
	if ($_$_condition_$34) { goto anon72_Then; } else { goto anon72_Else; }
anon71_Else:
	assume !(Heap_$_0[this,Node.prev] == null);
	assume exhaleMask#_11_$_17 == exhaleMask#_11_$_13;
	if ($_$_condition_$35) { goto anon72_Then; } else { goto anon72_Else; }
anon72_Then:
	assume !(Heap_$_0[this,Node.prev] == null);
	assert { :msg "  10.5: Monitor invariant might not be reflexive. The permission at 10.31 might not be positive." } Fractions(25) > 0;
	assert { :msg "  10.5: Monitor invariant might not be reflexive. Insufficient fraction at 10.31 for Node.next." } (Fractions(25) <= exhaleMask#_11_$_17[Heap_$_0[this,Node.prev],Node.next][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_17[Heap_$_0[this,Node.prev],Node.next][perm$R]) ==> (0 <= exhaleMask#_11_$_17[Heap_$_0[this,Node.prev],Node.next][perm$N]));
	assume exhaleMask#_11_$_18 == exhaleMask#_11_$_17[Heap_$_0[this,Node.prev],Node.next := exhaleMask#_11_$_17[Heap_$_0[this,Node.prev],Node.next][perm$R := exhaleMask#_11_$_17[Heap_$_0[this,Node.prev],Node.next][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_18);
	assume wf(Heap_$_0,exhaleMask#_11_$_18,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  10.5: Monitor invariant might not be reflexive. The permission at 10.53 might not be positive." } Fractions(25) > 0;
	assert { :msg "  10.5: Monitor invariant might not be reflexive. Insufficient fraction at 10.53 for Node.prev." } (Fractions(25) <= exhaleMask#_11_$_18[Heap_$_0[this,Node.prev],Node.prev][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_18[Heap_$_0[this,Node.prev],Node.prev][perm$R]) ==> (0 <= exhaleMask#_11_$_18[Heap_$_0[this,Node.prev],Node.prev][perm$N]));
	assume exhaleMask#_11_$_19 == exhaleMask#_11_$_18[Heap_$_0[this,Node.prev],Node.prev := exhaleMask#_11_$_18[Heap_$_0[this,Node.prev],Node.prev][perm$R := exhaleMask#_11_$_18[Heap_$_0[this,Node.prev],Node.prev][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_19);
	assume wf(Heap_$_0,exhaleMask#_11_$_19,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assert { :msg "  10.5: Monitor invariant might not be reflexive. The permission at 10.75 might not be positive." } Fractions(25) > 0;
	assert { :msg "  10.5: Monitor invariant might not be reflexive. Insufficient fraction at 10.75 for mu." } (Fractions(25) <= exhaleMask#_11_$_19[Heap_$_0[this,Node.prev],mu][perm$R]) && ((Fractions(25) == exhaleMask#_11_$_19[Heap_$_0[this,Node.prev],mu][perm$R]) ==> (0 <= exhaleMask#_11_$_19[Heap_$_0[this,Node.prev],mu][perm$N]));
	assume exhaleMask#_11_$_20 == exhaleMask#_11_$_19[Heap_$_0[this,Node.prev],mu := exhaleMask#_11_$_19[Heap_$_0[this,Node.prev],mu][perm$R := exhaleMask#_11_$_19[Heap_$_0[this,Node.prev],mu][perm$R] - Fractions(25)]];
	assume IsGoodMask(exhaleMask#_11_$_20);
	assume wf(Heap_$_0,exhaleMask#_11_$_20,ZeroMask);
	assume wf(Heap_$_0,Mask_$_21,ZeroMask);
	assume exhaleMask#_11_$_21 == exhaleMask#_11_$_20;
	goto anon48;
anon72_Else:
	assume Heap_$_0[this,Node.prev] == null;
	assume exhaleMask#_11_$_21 == exhaleMask#_11_$_17;
	goto anon48;
anon48:
	assume IsGoodExhaleState(exhaleHeap#_10_$_0,Heap_$_0,exhaleMask#_11_$_21,ZeroMask);
	assume IsGoodMask(exhaleMask#_11_$_21);
	assume wf(exhaleHeap#_10_$_0,exhaleMask#_11_$_21,ZeroMask);
	assert { :msg "  1.1: Monitor invariant is not allowed to contain debt." } (forall  ch : ref :: ( (ch == null) || (0 <= ZeroCredits[ch]) ));
	goto $exit;
}
