type Integer = int;
type Boolean = bool;
type THeap = <a>[ref,field (a)]a;
type TRegion = [ref]bool;
type ref;
type field m0;
const unique null : ref;
const Empty : TRegion;
const unique Ln : field (ref);
const unique LNC : field (TRegion);
const unique Le : field (ref);
const unique Lp : field (ref);
const unique LPC : field (TRegion);
const unique Lb : field (ref);
const unique LL : field (TRegion);
const unique Node_next : field (ref);
const unique List_head : field (ref);
const unique It_el : field (ref);
const unique It_List : field (ref);
function IsEmptyList(THeap,ref) : bool;
function Singleton(ref) : TRegion;
function Union(TRegion,TRegion) : TRegion;
function Sub(TRegion,TRegion) : bool;
function Equal(TRegion,TRegion) : bool;
function Disjoint(TRegion,TRegion) : bool;
function AddEl(TRegion,ref) : TRegion;
function IsGoodRegion(TRegion) : bool;
function InvIsGoodRegionsListEx(THeap,TRegion) : bool;
function InvLEx(THeap,TRegion) : bool;
function InvNCPCEx(THeap,TRegion) : bool;
function InvNCn1Ex(THeap,TRegion) : bool;
function InvNCn2Ex(THeap,TRegion) : bool;
function InvNCoEx(THeap,TRegion) : bool;
function Inve1Ex(THeap,TRegion) : bool;
function Inve2Ex(THeap,TRegion) : bool;
function Inve3Ex(THeap,TRegion) : bool;
function InvPCp1Ex(THeap,TRegion) : bool;
function InvPCp2Ex(THeap,TRegion) : bool;
function InvPCoEx(THeap,TRegion) : bool;
function Invb1Ex(THeap,TRegion) : bool;
function Invb2Ex(THeap,TRegion) : bool;
function Invb3Ex(THeap,TRegion) : bool;
function InvLbEx(THeap,TRegion,TRegion) : bool;
function InvLeEx(THeap,TRegion,TRegion) : bool;
function InvLL1Ex(THeap,TRegion,TRegion) : bool;
function InvLL2Ex(THeap,TRegion,TRegion) : bool;
function InvNCNCEx(THeap,TRegion,TRegion) : bool;
function InvPCPCEx(THeap,TRegion,TRegion) : bool;
function InvpEx(THeap,TRegion,TRegion) : bool;
function InvListEx(THeap,TRegion) : bool;
function InvList(THeap) : bool;
function ListClassInv(THeap,ref) : bool;
function InList(THeap,ref,ref) : bool;
var $Heap : THeap;
procedure InsertAfter (listEl : ref,el : ref)
{
	var $Heap_$_0 : THeap;
	var $Heap_$_1 : THeap;
	var $Heap_$_2 : THeap;
	var $_$_condition : bool;
$start:
	assume (forall  h : THeap, o : ref :: ( IsEmptyList(h,o) <==> ((((((Equal(h[o,LL],Singleton(o)) && (h[o,Ln] == null)) && Equal(h[o,LNC],Empty)) && (h[o,Le] == o)) && (h[o,Lp] == null)) && Equal(h[o,LPC],Empty)) && (h[o,Lb] == o)) ));
	assume (forall  o_$1 : ref :: ( !Empty[o_$1] ));
	assume (forall  r : ref, o_$2 : ref :: ( Singleton(r)[o_$2] <==> (r == o_$2) ));
	assume (forall  a : TRegion, b : TRegion, o_$3 : ref :: ( Union(a,b)[o_$3] <==> (a[o_$3] || b[o_$3]) ));
	assume (forall  a_$0 : TRegion, b_$0 : TRegion :: ( Sub(a_$0,b_$0) <==> ((forall  o_$4 : ref :: {a_$0[o_$4]} {b_$0[o_$4]} ( a_$0[o_$4] ==> b_$0[o_$4] ))) ));
	assume (forall  a_$1 : TRegion, b_$1 : TRegion :: ( Equal(a_$1,b_$1) <==> ((forall  o_$5 : ref :: {a_$1[o_$5]} {b_$1[o_$5]} ( a_$1[o_$5] <==> b_$1[o_$5] ))) ));
	assume (forall  a_$2 : TRegion, b_$2 : TRegion :: ( Disjoint(a_$2,b_$2) <==> ((forall  o_$6 : ref :: {a_$2[o_$6]} {b_$2[o_$6]} ( (!a_$2[o_$6]) || (!b_$2[o_$6]) ))) ));
	assume (forall  r_$0 : TRegion, o_$7 : ref, o'_$0 : ref :: ( AddEl(r_$0,o_$7)[o'_$0] <==> ((o_$7 == o'_$0) || r_$0[o'_$0]) ));
	assume (forall  s_$0 : TRegion, t : TRegion :: ( Equal(s_$0,t) ==> (s_$0 == t) ));
	assume (forall  r_$3 : TRegion :: ( IsGoodRegion(r_$3) <==> (!r_$3[null]) ));
	assume (forall  h_$1 : THeap, Ex1 : TRegion :: ( InvIsGoodRegionsListEx(h_$1,Ex1) <==> ((forall  o_$10 : ref :: ( (IsGoodRegion(h_$1[o_$10,LNC]) && IsGoodRegion(h_$1[o_$10,LPC])) && IsGoodRegion(h_$1[o_$10,LL]) ))) ));
	assume (forall  h_$2 : THeap, Ex1_$0 : TRegion :: ( InvLEx(h_$2,Ex1_$0) <==> ((forall  o_$11 : ref :: {h_$2[o_$11,LL]} ( ((!(o_$11 == null)) && (!Ex1_$0[o_$11])) ==> Equal(h_$2[o_$11,LL],Union(h_$2[o_$11,LPC],AddEl(h_$2[o_$11,LNC],o_$11))) ))) ));
	assume (forall  h_$3 : THeap, Ex1_$1 : TRegion :: ( InvNCPCEx(h_$3,Ex1_$1) <==> ((forall  o_$12 : ref :: ( ((!(o_$12 == null)) && (!Ex1_$1[o_$12])) ==> Disjoint(h_$3[o_$12,LNC],h_$3[o_$12,LPC]) ))) ));
	assume (forall  h_$4 : THeap, Ex1_$2 : TRegion :: ( InvNCn1Ex(h_$4,Ex1_$2) <==> ((forall  o_$13 : ref :: {h_$4[o_$13,Ln]} ( ((!(o_$13 == null)) && (!Ex1_$2[o_$13])) ==> ((h_$4[o_$13,Ln] == null) ==> Equal(h_$4[o_$13,LNC],Empty)) ))) ));
	assume (forall  h_$5 : THeap, Ex1_$3 : TRegion :: ( InvNCn2Ex(h_$5,Ex1_$3) <==> ((forall  o_$14 : ref :: {h_$5[o_$14,Ln],h_$5[h_$5[o_$14,Ln],LNC],h_$5[o_$14,Ln]} ( ((!(o_$14 == null)) && (!Ex1_$3[o_$14])) ==> ((!(h_$5[o_$14,Ln] == null)) ==> Equal(h_$5[o_$14,LNC],AddEl(h_$5[h_$5[o_$14,Ln],LNC],h_$5[o_$14,Ln]))) ))) ));
	assume (forall  h_$6 : THeap, Ex1_$4 : TRegion :: ( InvNCoEx(h_$6,Ex1_$4) <==> ((forall  o_$15 : ref :: {h_$6[o_$15,LNC]} ( ((!(o_$15 == null)) && (!Ex1_$4[o_$15])) ==> (!h_$6[o_$15,LNC][o_$15]) ))) ));
	assume (forall  h_$7 : THeap, Ex1_$5 : TRegion :: ( Inve1Ex(h_$7,Ex1_$5) <==> ((forall  o_$16 : ref :: {h_$7[o_$16,Le]} ( ((!(o_$16 == null)) && (!Ex1_$5[o_$16])) ==> ((!(o_$16 == h_$7[o_$16,Le])) ==> h_$7[o_$16,LNC][h_$7[o_$16,Le]]) ))) ));
	assume (forall  h_$8 : THeap, Ex1_$6 : TRegion :: ( Inve2Ex(h_$8,Ex1_$6) <==> ((forall  o_$17 : ref :: ( ((!(o_$17 == null)) && (!Ex1_$6[o_$17])) ==> ((o_$17 == h_$8[o_$17,Le]) <==> (h_$8[o_$17,Ln] == null)) ))) ));
	assume (forall  h_$9 : THeap, Ex1_$7 : TRegion :: ( Inve3Ex(h_$9,Ex1_$7) <==> ((forall  o_$18 : ref :: ( ((!(o_$18 == null)) && (!Ex1_$7[o_$18])) ==> h_$9[o_$18,LL][h_$9[o_$18,Le]] ))) ));
	assume (forall  h_$10 : THeap, Ex1_$8 : TRegion :: ( InvPCp1Ex(h_$10,Ex1_$8) <==> ((forall  o_$19 : ref :: {h_$10[o_$19,Lp]} ( ((!(o_$19 == null)) && (!Ex1_$8[o_$19])) ==> ((h_$10[o_$19,Lp] == null) ==> Equal(h_$10[o_$19,LPC],Empty)) ))) ));
	assume (forall  h_$11 : THeap, Ex1_$9 : TRegion :: ( InvPCp2Ex(h_$11,Ex1_$9) <==> ((forall  o_$20 : ref :: {h_$11[o_$20,Lp],h_$11[h_$11[o_$20,Lp],LPC],h_$11[o_$20,Lp]} ( ((!(o_$20 == null)) && (!Ex1_$9[o_$20])) ==> ((!(h_$11[o_$20,Lp] == null)) ==> Equal(h_$11[o_$20,LPC],AddEl(h_$11[h_$11[o_$20,Lp],LPC],h_$11[o_$20,Lp]))) ))) ));
	assume (forall  h_$12 : THeap, Ex1_$10 : TRegion :: ( InvPCoEx(h_$12,Ex1_$10) <==> ((forall  o_$21 : ref :: {h_$12[o_$21,LPC]} ( ((!(o_$21 == null)) && (!Ex1_$10[o_$21])) ==> (!h_$12[o_$21,LPC][o_$21]) ))) ));
	assume (forall  h_$13 : THeap, Ex1_$11 : TRegion :: ( Invb1Ex(h_$13,Ex1_$11) <==> ((forall  o_$22 : ref :: {h_$13[o_$22,Lb]} ( ((!(o_$22 == null)) && (!Ex1_$11[o_$22])) ==> ((!(o_$22 == h_$13[o_$22,Lb])) ==> h_$13[o_$22,LPC][h_$13[o_$22,Lb]]) ))) ));
	assume (forall  h_$14 : THeap, Ex1_$12 : TRegion :: ( Invb2Ex(h_$14,Ex1_$12) <==> ((forall  o_$23 : ref :: ( ((!(o_$23 == null)) && (!Ex1_$12[o_$23])) ==> ((o_$23 == h_$14[o_$23,Lb]) <==> (h_$14[o_$23,Lp] == null)) ))) ));
	assume (forall  h_$15 : THeap, Ex1_$13 : TRegion :: ( Invb3Ex(h_$15,Ex1_$13) <==> ((forall  o_$24 : ref :: ( ((!(o_$24 == null)) && (!Ex1_$13[o_$24])) ==> h_$15[o_$24,LL][h_$15[o_$24,Lb]] ))) ));
	assume (forall  h_$16 : THeap, Ex1_$14 : TRegion, Ex2 : TRegion :: ( InvLbEx(h_$16,Ex1_$14,Ex2) <==> ((forall  o_$25 : ref, o'_$2 : ref :: {h_$16[o_$25,LL][o'_$2]} ( ((((!(o_$25 == null)) && (!(o'_$2 == null))) && (!Ex1_$14[o_$25])) && (!Ex2[o'_$2])) ==> (h_$16[o_$25,LL][o'_$2] ==> (h_$16[o_$25,Lb] == h_$16[o'_$2,Lb])) ))) ));
	assume (forall  h_$17 : THeap, Ex1_$15 : TRegion, Ex2_$0 : TRegion :: ( InvLeEx(h_$17,Ex1_$15,Ex2_$0) <==> ((forall  o_$26 : ref, o'_$3 : ref :: {h_$17[o_$26,LL][o'_$3]} ( ((((!(o_$26 == null)) && (!(o'_$3 == null))) && (!Ex1_$15[o_$26])) && (!Ex2_$0[o'_$3])) ==> (h_$17[o_$26,LL][o'_$3] ==> (h_$17[o_$26,Le] == h_$17[o'_$3,Le])) ))) ));
	assume (forall  h_$18 : THeap, Ex1_$16 : TRegion, Ex2_$1 : TRegion :: ( InvLL1Ex(h_$18,Ex1_$16,Ex2_$1) <==> ((forall  o_$27 : ref, o'_$4 : ref :: {h_$18[o_$27,LL][o'_$4]} ( ((((!(o_$27 == null)) && (!(o'_$4 == null))) && (!Ex1_$16[o_$27])) && (!Ex2_$1[o'_$4])) ==> (h_$18[o_$27,LL][o'_$4] ==> Equal(h_$18[o_$27,LL],h_$18[o'_$4,LL])) ))) ));
	assume (forall  h_$19 : THeap, Ex1_$17 : TRegion, Ex2_$2 : TRegion :: ( InvLL2Ex(h_$19,Ex1_$17,Ex2_$2) <==> ((forall  o_$28 : ref, o'_$5 : ref :: {h_$19[o_$28,LL][o'_$5]} ( ((((!(o_$28 == null)) && (!(o'_$5 == null))) && (!Ex1_$17[o_$28])) && (!Ex2_$2[o'_$5])) ==> ((!h_$19[o_$28,LL][o'_$5]) ==> Disjoint(h_$19[o_$28,LL],h_$19[o'_$5,LL])) ))) ));
	assume (forall  h_$20 : THeap, Ex1_$18 : TRegion, Ex2_$3 : TRegion :: ( InvNCNCEx(h_$20,Ex1_$18,Ex2_$3) <==> ((forall  o_$29 : ref, o'_$6 : ref :: ( ((((!(o_$29 == null)) && (!(o'_$6 == null))) && (!Ex1_$18[o_$29])) && (!Ex2_$3[o'_$6])) ==> (h_$20[o_$29,LNC][o'_$6] ==> Sub(h_$20[o'_$6,LNC],h_$20[o_$29,LNC])) ))) ));
	assume (forall  h_$21 : THeap, Ex1_$19 : TRegion, Ex2_$4 : TRegion :: ( InvPCPCEx(h_$21,Ex1_$19,Ex2_$4) <==> ((forall  o_$30 : ref, o'_$7 : ref :: {h_$21[o_$30,LPC][o'_$7]} ( ((((!(o_$30 == null)) && (!(o'_$7 == null))) && (!Ex1_$19[o_$30])) && (!Ex2_$4[o'_$7])) ==> (h_$21[o_$30,LPC][o'_$7] ==> Sub(h_$21[o'_$7,LPC],h_$21[o_$30,LPC])) ))) ));
	assume (forall  h_$22 : THeap, Ex1_$20 : TRegion, Ex2_$5 : TRegion :: ( InvpEx(h_$22,Ex1_$20,Ex2_$5) <==> ((forall  o_$31 : ref, o'_$8 : ref :: ( ((((!(o_$31 == null)) && (!Ex1_$20[o_$31])) && (!(o'_$8 == null))) && (!Ex2_$5[o'_$8])) ==> ((h_$22[o_$31,Lp] == o'_$8) <==> (h_$22[o'_$8,Ln] == o_$31)) ))) ));
	assume (forall  h_$45 : THeap, Ex : TRegion :: {InvListEx(h_$45,Ex)} ( InvListEx(h_$45,Ex) <==> (((((((((((((((((((((InvIsGoodRegionsListEx(h_$45,Ex) && InvLEx(h_$45,Ex)) && InvNCPCEx(h_$45,Ex)) && InvNCn1Ex(h_$45,Ex)) && InvNCn2Ex(h_$45,Ex)) && InvNCoEx(h_$45,Ex)) && Inve1Ex(h_$45,Ex)) && Inve2Ex(h_$45,Ex)) && Inve3Ex(h_$45,Ex)) && InvPCp1Ex(h_$45,Ex)) && InvPCp2Ex(h_$45,Ex)) && InvPCoEx(h_$45,Ex)) && Invb1Ex(h_$45,Ex)) && Invb2Ex(h_$45,Ex)) && Invb3Ex(h_$45,Ex)) && InvLbEx(h_$45,Ex,Ex)) && InvLeEx(h_$45,Ex,Ex)) && InvLL1Ex(h_$45,Ex,Ex)) && InvLL2Ex(h_$45,Ex,Ex)) && InvNCNCEx(h_$45,Ex,Ex)) && InvPCPCEx(h_$45,Ex,Ex)) && InvpEx(h_$45,Ex,Ex)) ));
	assume (forall  h_$46 : THeap :: {InvList(h_$46)} ( InvList(h_$46) <==> InvListEx(h_$46,Empty) ));
	assume (forall  h_$47 : THeap, list : ref :: ( ListClassInv(h_$47,list) <==> ((!(h_$47[list,List_head] == null)) ==> (((forall  o_$32 : ref :: ( h_$47[h_$47[list,List_head],LL][o_$32] ==> (h_$47[o_$32,Node_next] == h_$47[o_$32,Ln]) ))) && (h_$47[list,List_head] == h_$47[h_$47[list,List_head],Lb]))) ));
	assume (forall  h_$48 : THeap, list_$0 : ref, el_$0 : ref :: ( InList(h_$48,list_$0,el_$0) <==> ((!(h_$48[list_$0,List_head] == null)) && h_$48[h_$48[list_$0,List_head],LL][el_$0]) ));
	goto anon0;
$exit:
	assume false;
anon0:
	assume !(listEl == null);
	assume !(el == null);
	assume InvList($Heap);
	assume IsEmptyList($Heap,el);
	assume !$Heap[listEl,LL][el];
	if ($_$_condition) { goto anon3_Then; } else { goto anon3_Else; }
anon3_Then:
	assume $_$_condition;
	assume $_$_condition <==> ($Heap[listEl,Le] == listEl);
	assume $Heap[listEl,Le] == listEl;
	assert  !(listEl == null);
	assert  !(el == null);
	assert  InvList($Heap);
	assert  IsEmptyList($Heap,el);
	assert  !$Heap[listEl,LL][el];
	assume InvList($Heap_$_0);
	assume $Heap_$_0[$Heap[listEl,Le],Ln] == el;
	assume $Heap_$_0[el,Lp] == $Heap[listEl,Le];
	assume $Heap_$_0[el,Ln] == null;
	assume $Heap_$_0[el,Lb] == $Heap_$_0[listEl,Lb];
	assume $Heap_$_0[el,Le] == el;
	assume $Heap_$_0[el,LPC] == $Heap[listEl,LL];
	assume $Heap_$_0[el,LNC] == Empty;
	assume $Heap_$_0[el,LL] == AddEl($Heap[listEl,LL],el);
	assume (forall  o_$33 : ref :: ( $Heap[listEl,LL][o_$33] ==> Equal($Heap_$_0[o_$33,LL],AddEl($Heap[o_$33,LL],el)) ));
	assume (forall  o_$34 : ref :: ( $Heap[listEl,LL][o_$34] ==> Equal($Heap_$_0[o_$34,LNC],AddEl($Heap[o_$34,LNC],el)) ));
	assume (forall  o_$35 : ref :: ( $Heap[listEl,LL][o_$35] ==> ($Heap_$_0[o_$35,Le] == el) ));
	assume ((forall  o_$36_$0 : ref, f_$2 : field (ref)  :: ( ((((((((((($Heap_$_0[o_$36_$0,f_$2] == $Heap[o_$36_$0,f_$2]) || ((o_$36_$0 == $Heap[listEl,Le]) && (f_$2 == Ln))) || ((o_$36_$0 == el) && (f_$2 == Lp))) || ((o_$36_$0 == el) && (f_$2 == Ln))) || ((o_$36_$0 == el) && (f_$2 == Lb))) || ((o_$36_$0 == el) && (f_$2 == Le))) || ((o_$36_$0 == el) && false)) || ((o_$36_$0 == el) && false)) || ((o_$36_$0 == el) && false)) || ($Heap[listEl,LL][o_$36_$0] && false)) || ($Heap[listEl,LL][o_$36_$0] && false)) || ($Heap[listEl,LL][o_$36_$0] && (f_$2 == Le)) ))) && ((forall  o_$36_$1 : ref, f_$3 : field ([ref]Boolean)  :: ( ((((((((((($Heap_$_0[o_$36_$1,f_$3] == $Heap[o_$36_$1,f_$3]) || ((o_$36_$1 == $Heap[listEl,Le]) && false)) || ((o_$36_$1 == el) && false)) || ((o_$36_$1 == el) && false)) || ((o_$36_$1 == el) && false)) || ((o_$36_$1 == el) && false)) || ((o_$36_$1 == el) && (f_$3 == LPC))) || ((o_$36_$1 == el) && (f_$3 == LNC))) || ((o_$36_$1 == el) && (f_$3 == LL))) || ($Heap[listEl,LL][o_$36_$1] && (f_$3 == LL))) || ($Heap[listEl,LL][o_$36_$1] && (f_$3 == LNC))) || ($Heap[listEl,LL][o_$36_$1] && false) )));
	assume $Heap_$_2 == $Heap_$_0;
	goto GeneratedUnifiedExit;
anon3_Else:
	assume !$_$_condition;
	assume $_$_condition <==> ($Heap[listEl,Le] == listEl);
	assume !($Heap[listEl,Le] == listEl);
	assert  !(listEl == null);
	assert  !(el == null);
	assert  InvList($Heap);
	assert  IsEmptyList($Heap,el);
	assert  !$Heap[listEl,LL][el];
	assert  !($Heap[listEl,Le] == listEl);
	assume InvList($Heap_$_1);
	assume $Heap_$_1[listEl,Ln] == el;
	assume $Heap_$_1[$Heap[listEl,Ln],Lp] == el;
	assume $Heap_$_1[el,Lp] == listEl;
	assume $Heap_$_1[el,Ln] == $Heap[listEl,Ln];
	assume $Heap_$_1[el,Lb] == $Heap_$_1[listEl,Lb];
	assume $Heap_$_1[el,Le] == $Heap_$_1[listEl,Le];
	assume $Heap_$_1[el,LPC] == $Heap[$Heap[listEl,Ln],LPC];
	assume $Heap_$_1[el,LNC] == $Heap[listEl,LNC];
	assume $Heap_$_1[el,LL] == AddEl($Heap[listEl,LL],el);
	assume (forall  o_$37 : ref :: ( $Heap[listEl,LL][o_$37] ==> Equal($Heap_$_1[o_$37,LL],AddEl($Heap[o_$37,LL],el)) ));
	assume (forall  o_$38 : ref :: ( $Heap[$Heap[listEl,Ln],LPC][o_$38] ==> Equal($Heap_$_1[o_$38,LNC],AddEl($Heap[o_$38,LNC],el)) ));
	assume (forall  o_$39 : ref :: ( $Heap[listEl,LNC][o_$39] ==> Equal($Heap_$_1[o_$39,LPC],AddEl($Heap[o_$39,LPC],el)) ));
	assume ((forall  o_$40_$0 : ref, f_$0_$0 : field (ref)  :: ( ((((((((((((($Heap_$_1[o_$40_$0,f_$0_$0] == $Heap[o_$40_$0,f_$0_$0]) || ((o_$40_$0 == listEl) && (f_$0_$0 == Ln))) || ((o_$40_$0 == $Heap[listEl,Ln]) && (f_$0_$0 == Lp))) || ((o_$40_$0 == $Heap[listEl,Le]) && (f_$0_$0 == Ln))) || ((o_$40_$0 == el) && (f_$0_$0 == Lp))) || ((o_$40_$0 == el) && (f_$0_$0 == Ln))) || ((o_$40_$0 == el) && (f_$0_$0 == Lb))) || ((o_$40_$0 == el) && (f_$0_$0 == Le))) || ((o_$40_$0 == el) && false)) || ((o_$40_$0 == el) && false)) || ((o_$40_$0 == el) && false)) || ($Heap[listEl,LL][o_$40_$0] && false)) || ($Heap[$Heap[listEl,Ln],LPC][o_$40_$0] && false)) || ($Heap[listEl,LNC][o_$40_$0] && false) ))) && ((forall  o_$40_$1 : ref, f_$0_$1 : field ([ref]Boolean)  :: ( ((((((((((((($Heap_$_1[o_$40_$1,f_$0_$1] == $Heap[o_$40_$1,f_$0_$1]) || ((o_$40_$1 == listEl) && false)) || ((o_$40_$1 == $Heap[listEl,Ln]) && false)) || ((o_$40_$1 == $Heap[listEl,Le]) && false)) || ((o_$40_$1 == el) && false)) || ((o_$40_$1 == el) && false)) || ((o_$40_$1 == el) && false)) || ((o_$40_$1 == el) && false)) || ((o_$40_$1 == el) && (f_$0_$1 == LPC))) || ((o_$40_$1 == el) && (f_$0_$1 == LNC))) || ((o_$40_$1 == el) && (f_$0_$1 == LL))) || ($Heap[listEl,LL][o_$40_$1] && (f_$0_$1 == LL))) || ($Heap[$Heap[listEl,Ln],LPC][o_$40_$1] && (f_$0_$1 == LNC))) || ($Heap[listEl,LNC][o_$40_$1] && (f_$0_$1 == LPC)) )));
	assume $Heap_$_2 == $Heap_$_1;
	goto GeneratedUnifiedExit;
GeneratedUnifiedExit:
	assert  InvList($Heap_$_2);
	assert  $Heap_$_2[listEl,Ln] == el;
	assert  (!($Heap[listEl,Le] == listEl)) ==> ($Heap_$_2[$Heap[listEl,Ln],Lp] == el);
	assert  $Heap_$_2[el,Lp] == listEl;
	assert  $Heap_$_2[el,Ln] == $Heap[listEl,Ln];
	assert  $Heap_$_2[el,Lb] == $Heap_$_2[listEl,Lb];
	assert  $Heap_$_2[el,Le] == $Heap_$_2[listEl,Le];
	assert  (!($Heap[listEl,Le] == listEl)) ==> ($Heap_$_2[el,LPC] == $Heap[$Heap[listEl,Ln],LPC]);
	assert  ($Heap[listEl,Le] == listEl) ==> ($Heap_$_2[el,LPC] == $Heap[listEl,LL]);
	assert  Equal($Heap_$_2[el,LNC],$Heap[listEl,LNC]);
	assert  $Heap_$_2[el,LL] == AddEl($Heap[listEl,LL],el);
	assert  (forall  o_$41 : ref :: ( $Heap[listEl,LL][o_$41] ==> Equal($Heap_$_2[o_$41,LL],AddEl($Heap[o_$41,LL],el)) ));
	assert  ($Heap[listEl,Le] == listEl) ==> ((forall  o_$42 : ref :: ( $Heap[listEl,LL][o_$42] ==> Equal($Heap_$_2[o_$42,LNC],AddEl($Heap[o_$42,LNC],el)) )));
	assert  (!($Heap[listEl,Le] == listEl)) ==> ((forall  o_$43 : ref :: ( $Heap[$Heap[listEl,Ln],LPC][o_$43] ==> Equal($Heap_$_2[o_$43,LNC],AddEl($Heap[o_$43,LNC],el)) )));
	assert  (!($Heap[listEl,Le] == listEl)) ==> ((forall  o_$44 : ref :: ( $Heap[listEl,LNC][o_$44] ==> Equal($Heap_$_2[o_$44,LPC],AddEl($Heap[o_$44,LPC],el)) )));
	assert  ($Heap[listEl,Le] == listEl) ==> ((forall  o_$45 : ref :: ( $Heap[listEl,LL][o_$45] ==> ($Heap_$_2[o_$45,Le] == el) )));
	assert  ((forall  o_$46_$0 : ref, f_$1_$0 : field (ref)  :: ( ((((((((((((((($Heap_$_2[o_$46_$0,f_$1_$0] == $Heap[o_$46_$0,f_$1_$0]) || (((!($Heap[listEl,Le] == listEl)) && (o_$46_$0 == listEl)) && (f_$1_$0 == Ln))) || (((!($Heap[listEl,Le] == listEl)) && (o_$46_$0 == $Heap[listEl,Ln])) && (f_$1_$0 == Lp))) || ((o_$46_$0 == $Heap[listEl,Le]) && (f_$1_$0 == Ln))) || ((o_$46_$0 == el) && (f_$1_$0 == Lp))) || ((o_$46_$0 == el) && (f_$1_$0 == Ln))) || ((o_$46_$0 == el) && (f_$1_$0 == Lb))) || ((o_$46_$0 == el) && (f_$1_$0 == Le))) || ((o_$46_$0 == el) && false)) || ((o_$46_$0 == el) && false)) || ((o_$46_$0 == el) && false)) || ($Heap[listEl,LL][o_$46_$0] && false)) || (((!($Heap[listEl,Le] == listEl)) && $Heap[$Heap[listEl,Ln],LPC][o_$46_$0]) && false)) || ((($Heap[listEl,Le] == listEl) && $Heap[listEl,LL][o_$46_$0]) && false)) || ($Heap[listEl,LNC][o_$46_$0] && false)) || ($Heap[listEl,LL][o_$46_$0] && (f_$1_$0 == Le)) ))) && ((forall  o_$46_$1 : ref, f_$1_$1 : field ([ref]Boolean)  :: ( ((((((((((((((($Heap_$_2[o_$46_$1,f_$1_$1] == $Heap[o_$46_$1,f_$1_$1]) || (((!($Heap[listEl,Le] == listEl)) && (o_$46_$1 == listEl)) && false)) || (((!($Heap[listEl,Le] == listEl)) && (o_$46_$1 == $Heap[listEl,Ln])) && false)) || ((o_$46_$1 == $Heap[listEl,Le]) && false)) || ((o_$46_$1 == el) && false)) || ((o_$46_$1 == el) && false)) || ((o_$46_$1 == el) && false)) || ((o_$46_$1 == el) && false)) || ((o_$46_$1 == el) && (f_$1_$1 == LPC))) || ((o_$46_$1 == el) && (f_$1_$1 == LNC))) || ((o_$46_$1 == el) && (f_$1_$1 == LL))) || ($Heap[listEl,LL][o_$46_$1] && (f_$1_$1 == LL))) || (((!($Heap[listEl,Le] == listEl)) && $Heap[$Heap[listEl,Ln],LPC][o_$46_$1]) && (f_$1_$1 == LNC))) || ((($Heap[listEl,Le] == listEl) && $Heap[listEl,LL][o_$46_$1]) && (f_$1_$1 == LNC))) || ($Heap[listEl,LNC][o_$46_$1] && (f_$1_$1 == LPC))) || ($Heap[listEl,LL][o_$46_$1] && false) )));
	goto $exit;
}
