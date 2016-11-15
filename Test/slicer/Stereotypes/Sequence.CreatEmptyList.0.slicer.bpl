type Integer = int;
type Boolean = bool;
type THeap = <a>[ref,field (a)]a;
type TRegion = [ref]bool;
type ref;
type field m0;
const unique null : ref;
const unique alloc : field (bool);
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
const unique list1 : ref;
const unique list2 : ref;
const unique it11 : ref;
const unique it12 : ref;
const unique it2 : ref;
const unique node : ref;
const $old_$Heap : THeap;
function IsEmptyList(THeap,ref) : bool;
function IsNotAllocatedList(THeap,ref) : bool;
function Singleton(ref) : TRegion;
function Union(TRegion,TRegion) : TRegion;
function Sub(TRegion,TRegion) : bool;
function Equal(TRegion,TRegion) : bool;
function Disjoint(TRegion,TRegion) : bool;
function AddEl(TRegion,ref) : TRegion;
function RemEl(TRegion,ref) : TRegion;
function Minus(TRegion,TRegion) : TRegion;
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
function InvIsGoodRegionsList(THeap) : bool;
function InvL(THeap) : bool;
function InvNCPC(THeap) : bool;
function InvNCn1(THeap) : bool;
function InvNCn2(THeap) : bool;
function InvNCo(THeap) : bool;
function Inve1(THeap) : bool;
function Inve2(THeap) : bool;
function Inve3(THeap) : bool;
function InvPCp1(THeap) : bool;
function InvPCp2(THeap) : bool;
function InvPCo(THeap) : bool;
function Invb1(THeap) : bool;
function Invb2(THeap) : bool;
function Invb3(THeap) : bool;
function InvLb(THeap) : bool;
function InvLe(THeap) : bool;
function InvLL1(THeap) : bool;
function InvLL2(THeap) : bool;
function InvNCNC(THeap) : bool;
function InvPCPC(THeap) : bool;
function Invp(THeap) : bool;
function InvListEx(THeap,TRegion) : bool;
function InvList(THeap) : bool;
function ListClassInv(THeap,ref) : bool;
function InList(THeap,ref,ref) : bool;
function ListEmpty(THeap,ref) : bool;
function ItClassInv(THeap,ref) : bool;
var $Heap : THeap;
procedure CreatEmptyList (o : ref,NotAllocated : TRegion)
{
	var $Heap_$_0 : THeap;
	var $Heap_$_1 : THeap;
	var $Heap_$_2 : THeap;
	var $Heap_$_3 : THeap;
	var $Heap_$_4 : THeap;
	var $Heap_$_5 : THeap;
	var $Heap_$_6 : THeap;
$start:
	assume (forall  h : THeap, o_$0 : ref :: ( IsEmptyList(h,o_$0) <==> ((((((Equal(h[o_$0,LL],Singleton(o_$0)) && (h[o_$0,Ln] == null)) && Equal(h[o_$0,LNC],Empty)) && (h[o_$0,Le] == o_$0)) && (h[o_$0,Lp] == null)) && Equal(h[o_$0,LPC],Empty)) && (h[o_$0,Lb] == o_$0)) ));
	assume (forall  h_$0 : THeap, o_$1 : ref :: {IsNotAllocatedList(h_$0,o_$1)} ( IsNotAllocatedList(h_$0,o_$1) <==> ((forall  o' : ref :: ( ((((((!h_$0[o',LL][o_$1]) && (!h_$0[o',LNC][o_$1])) && (!h_$0[o',LPC][o_$1])) && (!(h_$0[o',Ln] == o_$1))) && (!(h_$0[o',Le] == o_$1))) && (!(h_$0[o',Lp] == o_$1))) && (!(h_$0[o',Lb] == o_$1)) ))) ));
	assume (forall  o_$2 : ref :: ( !Empty[o_$2] ));
	assume (forall  r : ref, o_$3 : ref :: ( Singleton(r)[o_$3] <==> (r == o_$3) ));
	assume (forall  a : TRegion, b : TRegion, o_$4 : ref :: ( Union(a,b)[o_$4] <==> (a[o_$4] || b[o_$4]) ));
	assume (forall  a_$0 : TRegion, b_$0 : TRegion :: ( Sub(a_$0,b_$0) <==> ((forall  o_$5 : ref :: {a_$0[o_$5]} {b_$0[o_$5]} ( a_$0[o_$5] ==> b_$0[o_$5] ))) ));
	assume (forall  a_$1 : TRegion, b_$1 : TRegion :: ( Equal(a_$1,b_$1) <==> ((forall  o_$6 : ref :: {a_$1[o_$6]} {b_$1[o_$6]} ( a_$1[o_$6] <==> b_$1[o_$6] ))) ));
	assume (forall  a_$2 : TRegion, b_$2 : TRegion :: ( Disjoint(a_$2,b_$2) <==> ((forall  o_$7 : ref :: {a_$2[o_$7]} {b_$2[o_$7]} ( (!a_$2[o_$7]) || (!b_$2[o_$7]) ))) ));
	assume (forall  r_$0 : TRegion, o_$8 : ref, o'_$0 : ref :: ( AddEl(r_$0,o_$8)[o'_$0] <==> ((o_$8 == o'_$0) || r_$0[o'_$0]) ));
	assume (forall  r_$1 : TRegion, o_$9 : ref, o'_$1 : ref :: ( RemEl(r_$1,o_$9)[o'_$1] <==> ((!(o_$9 == o'_$1)) && r_$1[o'_$1]) ));
	assume (forall  s : TRegion, r_$2 : TRegion, o_$10 : ref :: ( Minus(s,r_$2)[o_$10] <==> (s[o_$10] && (!r_$2[o_$10])) ));
	assume (forall  s_$0 : TRegion, t : TRegion :: ( Equal(s_$0,t) ==> (s_$0 == t) ));
	assume (forall  r_$3 : TRegion :: ( IsGoodRegion(r_$3) <==> (!r_$3[null]) ));
	assume (forall  h_$1 : THeap, Ex1 : TRegion :: ( InvIsGoodRegionsListEx(h_$1,Ex1) <==> ((forall  o_$11 : ref :: ( (IsGoodRegion(h_$1[o_$11,LNC]) && IsGoodRegion(h_$1[o_$11,LPC])) && IsGoodRegion(h_$1[o_$11,LL]) ))) ));
	assume (forall  h_$2 : THeap, Ex1_$0 : TRegion :: ( InvLEx(h_$2,Ex1_$0) <==> ((forall  o_$12 : ref :: {h_$2[o_$12,LL]} ( ((!(o_$12 == null)) && (!Ex1_$0[o_$12])) ==> Equal(h_$2[o_$12,LL],Union(h_$2[o_$12,LPC],AddEl(h_$2[o_$12,LNC],o_$12))) ))) ));
	assume (forall  h_$3 : THeap, Ex1_$1 : TRegion :: ( InvNCPCEx(h_$3,Ex1_$1) <==> ((forall  o_$13 : ref :: ( ((!(o_$13 == null)) && (!Ex1_$1[o_$13])) ==> Disjoint(h_$3[o_$13,LNC],h_$3[o_$13,LPC]) ))) ));
	assume (forall  h_$4 : THeap, Ex1_$2 : TRegion :: ( InvNCn1Ex(h_$4,Ex1_$2) <==> ((forall  o_$14 : ref :: {h_$4[o_$14,Ln]} ( ((!(o_$14 == null)) && (!Ex1_$2[o_$14])) ==> ((h_$4[o_$14,Ln] == null) ==> Equal(h_$4[o_$14,LNC],Empty)) ))) ));
	assume (forall  h_$5 : THeap, Ex1_$3 : TRegion :: ( InvNCn2Ex(h_$5,Ex1_$3) <==> ((forall  o_$15 : ref :: {h_$5[o_$15,Ln],h_$5[h_$5[o_$15,Ln],LNC],h_$5[o_$15,Ln]} ( ((!(o_$15 == null)) && (!Ex1_$3[o_$15])) ==> ((!(h_$5[o_$15,Ln] == null)) ==> Equal(h_$5[o_$15,LNC],AddEl(h_$5[h_$5[o_$15,Ln],LNC],h_$5[o_$15,Ln]))) ))) ));
	assume (forall  h_$6 : THeap, Ex1_$4 : TRegion :: ( InvNCoEx(h_$6,Ex1_$4) <==> ((forall  o_$16 : ref :: {h_$6[o_$16,LNC]} ( ((!(o_$16 == null)) && (!Ex1_$4[o_$16])) ==> (!h_$6[o_$16,LNC][o_$16]) ))) ));
	assume (forall  h_$7 : THeap, Ex1_$5 : TRegion :: ( Inve1Ex(h_$7,Ex1_$5) <==> ((forall  o_$17 : ref :: {h_$7[o_$17,Le]} ( ((!(o_$17 == null)) && (!Ex1_$5[o_$17])) ==> ((!(o_$17 == h_$7[o_$17,Le])) ==> h_$7[o_$17,LNC][h_$7[o_$17,Le]]) ))) ));
	assume (forall  h_$8 : THeap, Ex1_$6 : TRegion :: ( Inve2Ex(h_$8,Ex1_$6) <==> ((forall  o_$18 : ref :: ( ((!(o_$18 == null)) && (!Ex1_$6[o_$18])) ==> ((o_$18 == h_$8[o_$18,Le]) <==> (h_$8[o_$18,Ln] == null)) ))) ));
	assume (forall  h_$9 : THeap, Ex1_$7 : TRegion :: ( Inve3Ex(h_$9,Ex1_$7) <==> ((forall  o_$19 : ref :: ( ((!(o_$19 == null)) && (!Ex1_$7[o_$19])) ==> h_$9[o_$19,LL][h_$9[o_$19,Le]] ))) ));
	assume (forall  h_$10 : THeap, Ex1_$8 : TRegion :: ( InvPCp1Ex(h_$10,Ex1_$8) <==> ((forall  o_$20 : ref :: {h_$10[o_$20,Lp]} ( ((!(o_$20 == null)) && (!Ex1_$8[o_$20])) ==> ((h_$10[o_$20,Lp] == null) ==> Equal(h_$10[o_$20,LPC],Empty)) ))) ));
	assume (forall  h_$11 : THeap, Ex1_$9 : TRegion :: ( InvPCp2Ex(h_$11,Ex1_$9) <==> ((forall  o_$21 : ref :: {h_$11[o_$21,Lp],h_$11[h_$11[o_$21,Lp],LPC],h_$11[o_$21,Lp]} ( ((!(o_$21 == null)) && (!Ex1_$9[o_$21])) ==> ((!(h_$11[o_$21,Lp] == null)) ==> Equal(h_$11[o_$21,LPC],AddEl(h_$11[h_$11[o_$21,Lp],LPC],h_$11[o_$21,Lp]))) ))) ));
	assume (forall  h_$12 : THeap, Ex1_$10 : TRegion :: ( InvPCoEx(h_$12,Ex1_$10) <==> ((forall  o_$22 : ref :: {h_$12[o_$22,LPC]} ( ((!(o_$22 == null)) && (!Ex1_$10[o_$22])) ==> (!h_$12[o_$22,LPC][o_$22]) ))) ));
	assume (forall  h_$13 : THeap, Ex1_$11 : TRegion :: ( Invb1Ex(h_$13,Ex1_$11) <==> ((forall  o_$23 : ref :: {h_$13[o_$23,Lb]} ( ((!(o_$23 == null)) && (!Ex1_$11[o_$23])) ==> ((!(o_$23 == h_$13[o_$23,Lb])) ==> h_$13[o_$23,LPC][h_$13[o_$23,Lb]]) ))) ));
	assume (forall  h_$14 : THeap, Ex1_$12 : TRegion :: ( Invb2Ex(h_$14,Ex1_$12) <==> ((forall  o_$24 : ref :: ( ((!(o_$24 == null)) && (!Ex1_$12[o_$24])) ==> ((o_$24 == h_$14[o_$24,Lb]) <==> (h_$14[o_$24,Lp] == null)) ))) ));
	assume (forall  h_$15 : THeap, Ex1_$13 : TRegion :: ( Invb3Ex(h_$15,Ex1_$13) <==> ((forall  o_$25 : ref :: ( ((!(o_$25 == null)) && (!Ex1_$13[o_$25])) ==> h_$15[o_$25,LL][h_$15[o_$25,Lb]] ))) ));
	assume (forall  h_$16 : THeap, Ex1_$14 : TRegion, Ex2 : TRegion :: ( InvLbEx(h_$16,Ex1_$14,Ex2) <==> ((forall  o_$26 : ref, o'_$2 : ref :: {h_$16[o_$26,LL][o'_$2]} ( ((((!(o_$26 == null)) && (!(o'_$2 == null))) && (!Ex1_$14[o_$26])) && (!Ex2[o'_$2])) ==> (h_$16[o_$26,LL][o'_$2] ==> (h_$16[o_$26,Lb] == h_$16[o'_$2,Lb])) ))) ));
	assume (forall  h_$17 : THeap, Ex1_$15 : TRegion, Ex2_$0 : TRegion :: ( InvLeEx(h_$17,Ex1_$15,Ex2_$0) <==> ((forall  o_$27 : ref, o'_$3 : ref :: {h_$17[o_$27,LL][o'_$3]} ( ((((!(o_$27 == null)) && (!(o'_$3 == null))) && (!Ex1_$15[o_$27])) && (!Ex2_$0[o'_$3])) ==> (h_$17[o_$27,LL][o'_$3] ==> (h_$17[o_$27,Le] == h_$17[o'_$3,Le])) ))) ));
	assume (forall  h_$18 : THeap, Ex1_$16 : TRegion, Ex2_$1 : TRegion :: ( InvLL1Ex(h_$18,Ex1_$16,Ex2_$1) <==> ((forall  o_$28 : ref, o'_$4 : ref :: {h_$18[o_$28,LL][o'_$4]} ( ((((!(o_$28 == null)) && (!(o'_$4 == null))) && (!Ex1_$16[o_$28])) && (!Ex2_$1[o'_$4])) ==> (h_$18[o_$28,LL][o'_$4] ==> Equal(h_$18[o_$28,LL],h_$18[o'_$4,LL])) ))) ));
	assume (forall  h_$19 : THeap, Ex1_$17 : TRegion, Ex2_$2 : TRegion :: ( InvLL2Ex(h_$19,Ex1_$17,Ex2_$2) <==> ((forall  o_$29 : ref, o'_$5 : ref :: {h_$19[o_$29,LL][o'_$5]} ( ((((!(o_$29 == null)) && (!(o'_$5 == null))) && (!Ex1_$17[o_$29])) && (!Ex2_$2[o'_$5])) ==> ((!h_$19[o_$29,LL][o'_$5]) ==> Disjoint(h_$19[o_$29,LL],h_$19[o'_$5,LL])) ))) ));
	assume (forall  h_$20 : THeap, Ex1_$18 : TRegion, Ex2_$3 : TRegion :: ( InvNCNCEx(h_$20,Ex1_$18,Ex2_$3) <==> ((forall  o_$30 : ref, o'_$6 : ref :: ( ((((!(o_$30 == null)) && (!(o'_$6 == null))) && (!Ex1_$18[o_$30])) && (!Ex2_$3[o'_$6])) ==> (h_$20[o_$30,LNC][o'_$6] ==> Sub(h_$20[o'_$6,LNC],h_$20[o_$30,LNC])) ))) ));
	assume (forall  h_$21 : THeap, Ex1_$19 : TRegion, Ex2_$4 : TRegion :: ( InvPCPCEx(h_$21,Ex1_$19,Ex2_$4) <==> ((forall  o_$31 : ref, o'_$7 : ref :: {h_$21[o_$31,LPC][o'_$7]} ( ((((!(o_$31 == null)) && (!(o'_$7 == null))) && (!Ex1_$19[o_$31])) && (!Ex2_$4[o'_$7])) ==> (h_$21[o_$31,LPC][o'_$7] ==> Sub(h_$21[o'_$7,LPC],h_$21[o_$31,LPC])) ))) ));
	assume (forall  h_$22 : THeap, Ex1_$20 : TRegion, Ex2_$5 : TRegion :: ( InvpEx(h_$22,Ex1_$20,Ex2_$5) <==> ((forall  o_$32 : ref, o'_$8 : ref :: ( ((((!(o_$32 == null)) && (!Ex1_$20[o_$32])) && (!(o'_$8 == null))) && (!Ex2_$5[o'_$8])) ==> ((h_$22[o_$32,Lp] == o'_$8) <==> (h_$22[o'_$8,Ln] == o_$32)) ))) ));
	assume (forall  h_$23 : THeap :: ( InvIsGoodRegionsList(h_$23) <==> InvIsGoodRegionsListEx(h_$23,Empty) ));
	assume (forall  h_$24 : THeap :: ( InvL(h_$24) <==> InvLEx(h_$24,Empty) ));
	assume (forall  h_$25 : THeap :: ( InvNCPC(h_$25) <==> InvNCPCEx(h_$25,Empty) ));
	assume (forall  h_$26 : THeap :: ( InvNCn1(h_$26) <==> InvNCn1Ex(h_$26,Empty) ));
	assume (forall  h_$27 : THeap :: ( InvNCn2(h_$27) <==> InvNCn2Ex(h_$27,Empty) ));
	assume (forall  h_$28 : THeap :: ( InvNCo(h_$28) <==> InvNCoEx(h_$28,Empty) ));
	assume (forall  h_$29 : THeap :: ( Inve1(h_$29) <==> Inve1Ex(h_$29,Empty) ));
	assume (forall  h_$30 : THeap :: ( Inve2(h_$30) <==> Inve2Ex(h_$30,Empty) ));
	assume (forall  h_$31 : THeap :: ( Inve3(h_$31) <==> Inve3Ex(h_$31,Empty) ));
	assume (forall  h_$32 : THeap :: ( InvPCp1(h_$32) <==> InvPCp1Ex(h_$32,Empty) ));
	assume (forall  h_$33 : THeap :: ( InvPCp2(h_$33) <==> InvPCp2Ex(h_$33,Empty) ));
	assume (forall  h_$34 : THeap :: ( InvPCo(h_$34) <==> InvPCoEx(h_$34,Empty) ));
	assume (forall  h_$35 : THeap :: ( Invb1(h_$35) <==> Invb1Ex(h_$35,Empty) ));
	assume (forall  h_$36 : THeap :: ( Invb2(h_$36) <==> Invb2Ex(h_$36,Empty) ));
	assume (forall  h_$37 : THeap :: ( Invb3(h_$37) <==> Invb3Ex(h_$37,Empty) ));
	assume (forall  h_$38 : THeap :: ( InvLb(h_$38) <==> InvLbEx(h_$38,Empty,Empty) ));
	assume (forall  h_$39 : THeap :: ( InvLe(h_$39) <==> InvLeEx(h_$39,Empty,Empty) ));
	assume (forall  h_$40 : THeap :: ( InvLL1(h_$40) <==> InvLL1Ex(h_$40,Empty,Empty) ));
	assume (forall  h_$41 : THeap :: ( InvLL2(h_$41) <==> InvLL2Ex(h_$41,Empty,Empty) ));
	assume (forall  h_$42 : THeap :: ( InvNCNC(h_$42) <==> InvNCNCEx(h_$42,Empty,Empty) ));
	assume (forall  h_$43 : THeap :: ( InvPCPC(h_$43) <==> InvPCPCEx(h_$43,Empty,Empty) ));
	assume (forall  h_$44 : THeap :: ( Invp(h_$44) <==> InvpEx(h_$44,Empty,Empty) ));
	assume (forall  h_$45 : THeap, Ex : TRegion :: {InvListEx(h_$45,Ex)} ( InvListEx(h_$45,Ex) <==> (((((((((((((((((((((InvIsGoodRegionsListEx(h_$45,Ex) && InvLEx(h_$45,Ex)) && InvNCPCEx(h_$45,Ex)) && InvNCn1Ex(h_$45,Ex)) && InvNCn2Ex(h_$45,Ex)) && InvNCoEx(h_$45,Ex)) && Inve1Ex(h_$45,Ex)) && Inve2Ex(h_$45,Ex)) && Inve3Ex(h_$45,Ex)) && InvPCp1Ex(h_$45,Ex)) && InvPCp2Ex(h_$45,Ex)) && InvPCoEx(h_$45,Ex)) && Invb1Ex(h_$45,Ex)) && Invb2Ex(h_$45,Ex)) && Invb3Ex(h_$45,Ex)) && InvLbEx(h_$45,Ex,Ex)) && InvLeEx(h_$45,Ex,Ex)) && InvLL1Ex(h_$45,Ex,Ex)) && InvLL2Ex(h_$45,Ex,Ex)) && InvNCNCEx(h_$45,Ex,Ex)) && InvPCPCEx(h_$45,Ex,Ex)) && InvpEx(h_$45,Ex,Ex)) ));
	assume (forall  h_$46 : THeap :: {InvList(h_$46)} ( InvList(h_$46) <==> InvListEx(h_$46,Empty) ));
	assume (forall  h_$47 : THeap, list : ref :: ( ListClassInv(h_$47,list) <==> ((!(h_$47[list,List_head] == null)) ==> (((forall  o_$33 : ref :: ( h_$47[h_$47[list,List_head],LL][o_$33] ==> (h_$47[o_$33,Node_next] == h_$47[o_$33,Ln]) ))) && (h_$47[list,List_head] == h_$47[h_$47[list,List_head],Lb]))) ));
	assume (forall  h_$48 : THeap, list_$0 : ref, el : ref :: ( InList(h_$48,list_$0,el) <==> ((!(h_$48[list_$0,List_head] == null)) && h_$48[h_$48[list_$0,List_head],LL][el]) ));
	assume (forall  h_$49 : THeap, list_$1 : ref :: ( ListEmpty(h_$49,list_$1) <==> (h_$49[list_$1,List_head] == null) ));
	assume (forall  h_$50 : THeap, it : ref :: ( ItClassInv(h_$50,it) <==> (((!(h_$50[it,It_List] == null)) && ((!(h_$50[it,It_el] == null)) ==> InList(h_$50,h_$50[it,It_List],h_$50[it,It_el]))) && ListClassInv(h_$50,h_$50[it,It_List])) ));
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume !(o == null);
	assume NotAllocated[o];
	assume InvListEx($Heap,NotAllocated);
	assume IsNotAllocatedList($Heap,o);
	goto anon0;
anon0:
	assert  InvLL2Ex($Heap,NotAllocated,NotAllocated);
	assume $Heap_$_0 == $Heap[o,LL := Singleton(o)];
	assert  InvLL2Ex($Heap_$_0,RemEl(NotAllocated,o),RemEl(NotAllocated,o));
	assume $Heap_$_1 == $Heap_$_0[o,Ln := null];
	assume $Heap_$_2 == $Heap_$_1[o,LNC := Empty];
	assume $Heap_$_3 == $Heap_$_2[o,Le := o];
	assume $Heap_$_4 == $Heap_$_3[o,Lp := null];
	assume $Heap_$_5 == $Heap_$_4[o,LPC := Empty];
	assume $Heap_$_6 == $Heap_$_5[o,Lb := o];
	assert  InvListEx($Heap_$_6,RemEl(NotAllocated,o));
	assert  IsEmptyList($Heap_$_6,o);
	assert  (forall<a> o'_$9 : ref, f : field (a)  :: ( ((((((($Heap_$_6[o'_$9,f] == $Heap[o'_$9,f]) || ((o'_$9 == o) && (f == LL))) || ((o'_$9 == o) && (f == Ln))) || ((o'_$9 == o) && (f == LNC))) || ((o'_$9 == o) && (f == Le))) || ((o'_$9 == o) && (f == Lp))) || ((o'_$9 == o) && (f == LPC))) || ((o'_$9 == o) && (f == Lb)) ));
	goto $exit;
}