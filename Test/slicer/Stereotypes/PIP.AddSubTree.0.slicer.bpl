type Integer = int;
type Boolean = bool;
type THeap = <a>[ref,field (a)]a;
type TMSet = [int]int;
type TRegion = [ref]bool;
type ref;
type field m0;
type TNodeState;
const unique null : ref;
const unique alloc : field (bool);
const EmptyMSet : TMSet;
const Empty : TRegion;
const unique NC : field (TRegion);
const unique ND : field (TRegion);
const unique NA : field (TRegion);
const unique Np : field (ref);
const unique Nt : field (ref);
const unique Ln : field (ref);
const unique Le : field (ref);
const unique Lp : field (ref);
const unique Lb : field (ref);
const unique LL : field (TRegion);
const unique StF : TNodeState;
const unique StL : TNodeState;
const unique StD : TNodeState;
const unique Ndpr : field (int);
const unique Ncpr : field (int);
const unique Nbb : field (ref);
const unique Npr : field (TMSet);
const unique NSt : field (TNodeState);
const unique r1 : ref;
const unique r2 : ref;
const unique p1 : ref;
const unique p2 : ref;
const $old_$Heap : THeap;
function IsNotAllocatedTree(THeap,ref) : bool;
function IsNotAllocatedList(THeap,ref) : bool;
function IsNotAllocated(THeap,ref) : bool;
function InMSet(TMSet,int) : bool;
function EqualMSet(TMSet,TMSet) : bool;
function AddMSet(TMSet,int) : TMSet;
function RemoveMSet(TMSet,int) : TMSet;
function MaxMSet(TMSet) : int;
function Singleton(ref) : TRegion;
function Union(TRegion,TRegion) : TRegion;
function Sub(TRegion,TRegion) : bool;
function Equal(TRegion,TRegion) : bool;
function Disjoint(TRegion,TRegion) : bool;
function AddEl(TRegion,ref) : TRegion;
function RemEl(TRegion,ref) : TRegion;
function Minus(TRegion,TRegion) : TRegion;
function Card(TRegion) : int;
function IsGoodRegion(TRegion) : bool;
function RegionImageRefInc(TRegion,field (ref),TRegion,THeap) : bool;
function RegionImageRegionInc(TRegion,field (TRegion),TRegion,THeap) : bool;
function Max(int,int) : int;
function FBP(THeap,TRegion,int) : TRegion;
function CLn(THeap,ref) : ref;
function CLp(THeap,ref) : ref;
function IsEmptyTree(THeap,ref) : bool;
function IsEmptyList(THeap,ref) : bool;
function NACCoSet(THeap,ref) : TRegion;
function NACCSet(THeap,ref) : TRegion;
function BBSet(THeap,ref) : TRegion;
function InvIsGoodRegionsTreeEx(THeap,TRegion) : bool;
function InvCpEx(THeap,TRegion,TRegion) : bool;
function InvCCEx(THeap,TRegion,TRegion) : bool;
function InvDEx(THeap,TRegion) : bool;
function InvAEx(THeap,TRegion) : bool;
function InvCD1Ex(THeap,TRegion) : bool;
function InvCD2Ex(THeap,TRegion,TRegion) : bool;
function InvAD1Ex(THeap,TRegion,TRegion) : bool;
function InvAD2Ex(THeap,TRegion,TRegion) : bool;
function InvAD3Ex(THeap,TRegion,TRegion) : bool;
function InvDD1Ex(THeap,TRegion,TRegion) : bool;
function InvDD2Ex(THeap,TRegion,TRegion) : bool;
function InvAAEx(THeap,TRegion,TRegion) : bool;
function InvAp1Ex(THeap,TRegion) : bool;
function InvAp2Ex(THeap,TRegion) : bool;
function InvAt1Ex(THeap,TRegion) : bool;
function InvAt2Ex(THeap,TRegion) : bool;
function InvAt3Ex(THeap,TRegion,TRegion) : bool;
function InvIsGoodRegionsTree(THeap) : bool;
function InvCp(THeap) : bool;
function InvCC(THeap) : bool;
function InvD(THeap) : bool;
function InvA(THeap) : bool;
function InvCD1(THeap) : bool;
function InvCD2(THeap) : bool;
function InvAD1(THeap) : bool;
function InvAD2(THeap) : bool;
function InvAD3(THeap) : bool;
function InvDD1(THeap) : bool;
function InvDD2(THeap) : bool;
function InvAA(THeap) : bool;
function InvAp1(THeap) : bool;
function InvAp2(THeap) : bool;
function InvAt1(THeap) : bool;
function InvAt2(THeap) : bool;
function InvAt3(THeap) : bool;
function InvTreeEx(THeap,TRegion) : bool;
function InvTree(THeap) : bool;
function InvIsGoodRegionsListEx(THeap,TRegion) : bool;
function InvLEx(THeap,TRegion) : bool;
function Inve1Ex(THeap,TRegion) : bool;
function Inve2Ex(THeap,TRegion) : bool;
function Invb1Ex(THeap,TRegion) : bool;
function Invb2Ex(THeap,TRegion) : bool;
function InvnEx(THeap,TRegion) : bool;
function InvpEx(THeap,TRegion) : bool;
function InvnpEx(THeap,TRegion) : bool;
function InvpnEx(THeap,TRegion) : bool;
function InvLbEx(THeap,TRegion,TRegion) : bool;
function InvLeEx(THeap,TRegion,TRegion) : bool;
function InvLL1Ex(THeap,TRegion,TRegion) : bool;
function InvLL2Ex(THeap,TRegion,TRegion) : bool;
function InvIsGoodRegionsList(THeap) : bool;
function InvL(THeap) : bool;
function Inve1(THeap) : bool;
function Inve2(THeap) : bool;
function Invb1(THeap) : bool;
function Invb2(THeap) : bool;
function Invn(THeap) : bool;
function Invp(THeap) : bool;
function Invpn(THeap) : bool;
function Invnp(THeap) : bool;
function InvLb(THeap) : bool;
function InvLe(THeap) : bool;
function InvLL1(THeap) : bool;
function InvLL2(THeap) : bool;
function InvListEx(THeap,TRegion) : bool;
function InvList(THeap) : bool;
function InvStFEx(THeap,TRegion) : bool;
function InvStLEx(THeap,TRegion) : bool;
function InvStDEx(THeap,TRegion) : bool;
function InvStNDLEx(THeap,TRegion) : bool;
function InvStDCCEx(THeap,TRegion,TRegion) : bool;
function InvStADEx(THeap,TRegion,TRegion) : bool;
function InvStF(THeap) : bool;
function InvStL(THeap) : bool;
function InvStD(THeap) : bool;
function InvStNDL(THeap) : bool;
function InvStDCC(THeap) : bool;
function InvStAD(THeap) : bool;
function InvStructEx(THeap,TRegion) : bool;
function InvStruct(THeap) : bool;
function InvPr(THeap,ref) : bool;
function InvPrSt(THeap,ref,int,int) : bool;
var $Heap : THeap;
procedure AddSubTree (tree : ref,subTree : ref)
{
	var $Heap_$_0 : THeap;
	var $Heap_$_1 : THeap;
	var call0formal_$_r1_$_0 : TRegion;
	var call2formal_$_r2_$_0 : TRegion;
	var $Heap_$_2 : THeap;
	var call0formal_$_r1_$_0_$1 : TRegion;
	var call2formal_$_r2_$_0_$1 : TRegion;
	var $Heap_$_3 : THeap;
	var call0formal_$_r1_$_0_$2 : TRegion;
	var call2formal_$_val_$_0 : ref;
	var $Heap_$_4 : THeap;
$start:
	assume (forall  h : THeap, o : ref :: {IsNotAllocatedTree(h,o)} ( IsNotAllocatedTree(h,o) <==> ((forall  o' : ref :: ( ((((!(h[o',Np] == o)) && (!(h[o',Nt] == o))) && (!h[o',NA][o])) && (!h[o',NC][o])) && (!h[o',ND][o]) ))) ));
	assume (forall  h_$0 : THeap, o_$0 : ref :: {IsNotAllocatedList(h_$0,o_$0)} ( IsNotAllocatedList(h_$0,o_$0) <==> ((forall  o'_$0 : ref :: ( ((((!h_$0[o'_$0,LL][o_$0]) && (!(h_$0[o'_$0,Ln] == o_$0))) && (!(h_$0[o'_$0,Le] == o_$0))) && (!(h_$0[o'_$0,Lp] == o_$0))) && (!(h_$0[o'_$0,Lb] == o_$0)) ))) ));
	assume (forall  h_$1 : THeap, o_$1 : ref :: {IsNotAllocated(h_$1,o_$1)} ( IsNotAllocated(h_$1,o_$1) <==> ((((forall  o'_$1 : ref :: ( !(h_$1[o'_$1,Nbb] == o_$1) ))) && IsNotAllocatedTree(h_$1,o_$1)) && IsNotAllocatedList(h_$1,o_$1)) ));
	assume (forall  m : TMSet, i : Integer :: {InMSet(m,i)} ( InMSet(m,i) <==> (!(m[i] == 0)) ));
	assume (forall  i_$0 : Integer :: {EmptyMSet[i_$0]} ( !InMSet(EmptyMSet,i_$0) ));
	assume (forall  a : TMSet, b : TMSet :: {EqualMSet(a,b)} ( EqualMSet(a,b) <==> ((forall  i_$1 : Integer :: {a[i_$1]} {b[i_$1]} ( (i_$1 > 0) ==> (a[i_$1] == b[i_$1]) ))) ));
	assume (forall  a_$0 : TMSet, i_$2 : Integer :: {AddMSet(a_$0,i_$2)[i_$2]} ( AddMSet(a_$0,i_$2)[i_$2] == (a_$0[i_$2] + 1) ));
	assume (forall  a_$1 : TMSet, i_$3 : Integer, j : Integer :: {AddMSet(a_$1,i_$3)[j]} ( (!(i_$3 == j)) ==> (AddMSet(a_$1,i_$3)[j] == a_$1[j]) ));
	assume (forall  a_$2 : TMSet, i_$4 : Integer :: {RemoveMSet(a_$2,i_$4)[i_$4]} ( RemoveMSet(a_$2,i_$4)[i_$4] == (a_$2[i_$4] - 1) ));
	assume (forall  a_$3 : TMSet, i_$5 : Integer, j_$0 : Integer :: {RemoveMSet(a_$3,i_$5)[j_$0]} ( (!(i_$5 == j_$0)) ==> (RemoveMSet(a_$3,i_$5)[j_$0] == a_$3[j_$0]) ));
	assume MaxMSet(EmptyMSet) == 0;
	assume (forall  s : TMSet, t : TMSet :: {EqualMSet(s,t)} ( EqualMSet(s,t) ==> (MaxMSet(s) == MaxMSet(t)) ));
	assume (forall  o_$2 : ref :: {Empty[o_$2]} ( !Empty[o_$2] ));
	assume (forall  r : ref, o_$3 : ref :: {Singleton(r)[o_$3]} ( Singleton(r)[o_$3] <==> (r == o_$3) ));
	assume (forall  a_$4 : TRegion, b_$0 : TRegion, o_$4 : ref :: {Union(a_$4,b_$0)[o_$4]} ( Union(a_$4,b_$0)[o_$4] <==> (a_$4[o_$4] || b_$0[o_$4]) ));
	assume (forall  a_$5 : TRegion, b_$1 : TRegion :: {Sub(a_$5,b_$1)} ( Sub(a_$5,b_$1) <==> ((forall  o_$5 : ref :: {a_$5[o_$5]} {b_$1[o_$5]} ( a_$5[o_$5] ==> b_$1[o_$5] ))) ));
	assume (forall  a_$6 : TRegion, b_$2 : TRegion :: {Equal(a_$6,b_$2)} ( Equal(a_$6,b_$2) <==> ((forall  o_$6 : ref :: {a_$6[o_$6]} {b_$2[o_$6]} ( a_$6[o_$6] <==> b_$2[o_$6] ))) ));
	assume (forall  a_$7 : TRegion, b_$3 : TRegion :: {Disjoint(a_$7,b_$3)} ( Disjoint(a_$7,b_$3) <==> ((forall  o_$7 : ref :: {a_$7[o_$7]} {b_$3[o_$7]} ( (!a_$7[o_$7]) || (!b_$3[o_$7]) ))) ));
	assume (forall  r_$0 : TRegion, o_$8 : ref, o'_$2 : ref :: {AddEl(r_$0,o_$8)[o'_$2]} ( AddEl(r_$0,o_$8)[o'_$2] <==> ((o_$8 == o'_$2) || r_$0[o'_$2]) ));
	assume (forall  r_$1 : TRegion, o_$9 : ref, o'_$3 : ref :: {RemEl(r_$1,o_$9)[o'_$3]} ( RemEl(r_$1,o_$9)[o'_$3] <==> ((!(o_$9 == o'_$3)) && r_$1[o'_$3]) ));
	assume (forall  s_$0 : TRegion, r_$2 : TRegion, o_$10 : ref :: {Minus(s_$0,r_$2)[o_$10]} ( Minus(s_$0,r_$2)[o_$10] <==> (s_$0[o_$10] && (!r_$2[o_$10])) ));
	assume Card(Empty) == 0;
	assume (forall  s_$1 : TRegion, o_$11 : ref :: ( (!s_$1[o_$11]) ==> (Card(AddEl(s_$1,o_$11)) == (Card(s_$1) + 1)) ));
	assume (forall  s_$2 : TRegion, o_$12 : ref :: ( s_$2[o_$12] ==> (Card(RemEl(s_$2,o_$12)) == (Card(s_$2) - 1)) ));
	assume (forall  s_$3 : TRegion, t_$0 : TRegion :: ( Equal(s_$3,t_$0) ==> (Card(s_$3) == Card(t_$0)) ));
	assume (forall  s_$4 : TRegion, t_$1 : TRegion :: ( Equal(s_$4,t_$1) ==> (s_$4 == t_$1) ));
	assume (forall  r_$3 : TRegion :: {IsGoodRegion(r_$3)} ( IsGoodRegion(r_$3) <==> (!r_$3[null]) ));
	assume (forall  r1_$0 : TRegion, f : field (ref) , r2_$0 : TRegion, h_$2 : THeap :: {RegionImageRefInc(r1_$0,f,r2_$0,h_$2)} ( RegionImageRefInc(r1_$0,f,r2_$0,h_$2) <==> ((forall  o_$13 : ref :: ( r1_$0[o_$13] ==> ((h_$2[o_$13,f] == null) || r2_$0[h_$2[o_$13,f]]) ))) ));
	assume (forall  r1_$1 : TRegion, f_$0 : field (TRegion) , r2_$1 : TRegion, h_$3 : THeap :: {RegionImageRegionInc(r1_$1,f_$0,r2_$1,h_$3)} ( RegionImageRegionInc(r1_$1,f_$0,r2_$1,h_$3) <==> ((forall  o_$14 : ref :: {r1_$1[o_$14]} ( r1_$1[o_$14] ==> Sub(h_$3[o_$14,f_$0],r2_$1) ))) ));
	assume (forall  i_$6 : Integer, j_$1 : Integer :: {Max(i_$6,j_$1)} ( ((Max(i_$6,j_$1) >= i_$6) && (Max(i_$6,j_$1) >= j_$1)) && ((Max(i_$6,j_$1) == i_$6) || (Max(i_$6,j_$1) == j_$1)) ));
	assume (forall  h_$4 : THeap, r_$4 : TRegion, i_$7 : Integer, o_$15 : ref :: ( FBP(h_$4,r_$4,i_$7)[o_$15] <==> ((r_$4[o_$15] && (h_$4[o_$15,Ncpr] == i_$7)) && (!(o_$15 == null))) ));
	assume (forall  h_$5 : THeap, o_$16 : ref :: ( (h_$5[o_$16,Ln] == null) ==> (CLn(h_$5,o_$16) == h_$5[o_$16,Lb]) ));
	assume (forall  h_$6 : THeap, o_$17 : ref :: ( (!(h_$6[o_$17,Ln] == null)) ==> (CLn(h_$6,o_$17) == h_$6[o_$17,Ln]) ));
	assume (forall  h_$7 : THeap, o_$18 : ref :: ( (h_$7[o_$18,Lp] == null) ==> (CLp(h_$7,o_$18) == h_$7[o_$18,Le]) ));
	assume (forall  h_$8 : THeap, o_$19 : ref :: ( (!(h_$8[o_$19,Lp] == null)) ==> (CLp(h_$8,o_$19) == h_$8[o_$19,Lp]) ));
	assume (forall  h_$9 : THeap, o_$20 : ref :: ( IsEmptyTree(h_$9,o_$20) <==> (((((h_$9[o_$20,Np] == null) && (h_$9[o_$20,Nt] == o_$20)) && (h_$9[o_$20,NA] == Empty)) && (h_$9[o_$20,NC] == Empty)) && (h_$9[o_$20,ND] == Empty)) ));
	assume (forall  $Heap_$0 : THeap, o_$21 : ref :: ( IsEmptyList($Heap_$0,o_$21) <==> ((((($Heap_$0[o_$21,LL] == Singleton(o_$21)) && ($Heap_$0[o_$21,Ln] == null)) && ($Heap_$0[o_$21,Le] == o_$21)) && ($Heap_$0[o_$21,Lp] == null)) && ($Heap_$0[o_$21,Lb] == o_$21)) ));
	assume (forall  St : TNodeState :: ( ((St == StF) || (St == StL)) || (St == StD) ));
	assume (forall  h_$10 : THeap, o_$22 : ref :: ( Equal(NACCoSet(h_$10,o_$22),AddEl(Union(h_$10[o_$22,NA],h_$10[h_$10[o_$22,Nt],LL]),o_$22)) ));
	assume (forall  h_$11 : THeap, o_$23 : ref :: ( Equal(NACCSet(h_$11,o_$23),RemEl(Union(h_$11[o_$23,NA],h_$11[h_$11[o_$23,Nt],LL]),o_$23)) ));
	assume (forall  h_$12 : THeap, o_$24 : ref :: ( ((!(h_$12[o_$24,NSt] == StD)) ==> Equal(BBSet(h_$12,o_$24),h_$12[o_$24,NC])) && ((h_$12[o_$24,NSt] == StD) ==> Equal(BBSet(h_$12,o_$24),AddEl(h_$12[o_$24,NC],CLp(h_$12,o_$24)))) ));
	assume (forall  h_$13 : THeap, Ex1 : TRegion :: ( InvIsGoodRegionsTreeEx(h_$13,Ex1) <==> ((forall  o_$25 : ref :: ( (IsGoodRegion(h_$13[o_$25,NC]) && IsGoodRegion(h_$13[o_$25,ND])) && IsGoodRegion(h_$13[o_$25,NA]) ))) ));
	assume (forall  h_$14 : THeap, Ex1_$0 : TRegion, Ex2 : TRegion :: ( InvCpEx(h_$14,Ex1_$0,Ex2) <==> ((forall  o_$26 : ref, o'_$4 : ref :: {h_$14[o_$26,NC][o'_$4],h_$14[o'_$4,Np]} ( ((((!(o_$26 == null)) && (!(o'_$4 == null))) && (!Ex1_$0[o_$26])) && (!Ex2[o'_$4])) ==> (h_$14[o_$26,NC][o'_$4] <==> (h_$14[o'_$4,Np] == o_$26)) ))) ));
	assume (forall  h_$15 : THeap, Ex1_$1 : TRegion, Ex2_$0 : TRegion :: ( InvCCEx(h_$15,Ex1_$1,Ex2_$0) <==> ((forall  o_$27 : ref, o'_$5 : ref :: ( ((((!(o_$27 == null)) && (!(o'_$5 == null))) && (!Ex1_$1[o_$27])) && (!Ex2_$0[o'_$5])) ==> ((!(o_$27 == o'_$5)) ==> Disjoint(h_$15[o_$27,NC],h_$15[o'_$5,NC])) ))) ));
	assume (forall  h_$16 : THeap, Ex1_$2 : TRegion :: ( InvDEx(h_$16,Ex1_$2) <==> ((forall  o_$28 : ref :: ( ((!(o_$28 == null)) && (!Ex1_$2[o_$28])) ==> (!h_$16[o_$28,ND][o_$28]) ))) ));
	assume (forall  h_$17 : THeap, Ex1_$3 : TRegion :: ( InvAEx(h_$17,Ex1_$3) <==> ((forall  o_$29 : ref :: ( ((!(o_$29 == null)) && (!Ex1_$3[o_$29])) ==> (!h_$17[o_$29,NA][o_$29]) ))) ));
	assume (forall  h_$18 : THeap, Ex1_$4 : TRegion :: ( InvCD1Ex(h_$18,Ex1_$4) <==> ((forall  o_$30 : ref :: ( ((!(o_$30 == null)) && (!Ex1_$4[o_$30])) ==> Sub(h_$18[o_$30,NC],h_$18[o_$30,ND]) ))) ));
	assume (forall  h_$19 : THeap, Ex1_$5 : TRegion, Ex2_$1 : TRegion :: ( InvCD2Ex(h_$19,Ex1_$5,Ex2_$1) <==> ((forall  o_$31 : ref, o'_$6 : ref :: ( ((((!(o_$31 == null)) && (!(o'_$6 == null))) && (!Ex1_$5[o_$31])) && (!Ex2_$1[o'_$6])) ==> (h_$19[o_$31,ND][o'_$6] ==> Disjoint(h_$19[o_$31,NC],h_$19[o'_$6,ND])) ))) ));
	assume (forall  h_$20 : THeap, Ex1_$6 : TRegion, Ex2_$2 : TRegion :: ( InvAD1Ex(h_$20,Ex1_$6,Ex2_$2) <==> ((forall  o_$32 : ref, o'_$7 : ref :: {h_$20[o_$32,ND][o'_$7]} {h_$20[o'_$7,NA][o_$32]} ( ((((!(o_$32 == null)) && (!(o'_$7 == null))) && (!Ex1_$6[o_$32])) && (!Ex2_$2[o'_$7])) ==> (h_$20[o_$32,ND][o'_$7] <==> h_$20[o'_$7,NA][o_$32]) ))) ));
	assume (forall  h_$21 : THeap, Ex1_$7 : TRegion, Ex2_$3 : TRegion :: ( InvAD2Ex(h_$21,Ex1_$7,Ex2_$3) <==> ((forall  o_$33 : ref, o'_$8 : ref :: {h_$21[o_$33,ND][o'_$8]} ( ((((!(o_$33 == null)) && (!(o'_$8 == null))) && (!Ex1_$7[o_$33])) && (!Ex2_$3[o'_$8])) ==> ((!h_$21[o_$33,ND][o'_$8]) ==> Disjoint(h_$21[o'_$8,NA],AddEl(h_$21[o_$33,ND],o_$33))) ))) ));
	assume (forall  h_$22 : THeap, Ex1_$8 : TRegion, Ex2_$4 : TRegion :: ( InvAD3Ex(h_$22,Ex1_$8,Ex2_$4) <==> ((forall  o_$34 : ref, o'_$9 : ref :: {h_$22[o_$34,ND][o'_$9]} ( ((((!(o_$34 == null)) && (!(o'_$9 == null))) && (!Ex1_$8[o_$34])) && (!Ex2_$4[o'_$9])) ==> (h_$22[o_$34,ND][o'_$9] ==> Equal(Minus(h_$22[o'_$9,NA],h_$22[o_$34,ND]),AddEl(h_$22[o_$34,NA],o_$34))) ))) ));
	assume (forall  h_$23 : THeap, Ex1_$9 : TRegion, Ex2_$5 : TRegion :: ( InvDD1Ex(h_$23,Ex1_$9,Ex2_$5) <==> ((forall  o_$35 : ref, o'_$10 : ref :: {h_$23[o_$35,ND][o'_$10]} ( ((((!(o_$35 == null)) && (!(o'_$10 == null))) && (!Ex1_$9[o_$35])) && (!Ex2_$5[o'_$10])) ==> (h_$23[o_$35,ND][o'_$10] ==> Sub(h_$23[o'_$10,ND],h_$23[o_$35,ND])) ))) ));
	assume (forall  h_$24 : THeap, Ex1_$10 : TRegion, Ex2_$6 : TRegion :: ( InvDD2Ex(h_$24,Ex1_$10,Ex2_$6) <==> ((forall  o_$36 : ref, o'_$11 : ref :: {h_$24[o_$36,ND][o'_$11],h_$24[o'_$11,ND][o_$36]} ( ((((!(o_$36 == null)) && (!(o'_$11 == null))) && (!Ex1_$10[o_$36])) && (!Ex2_$6[o'_$11])) ==> ((((!(o_$36 == o'_$11)) && (!h_$24[o_$36,ND][o'_$11])) && (!h_$24[o'_$11,ND][o_$36])) ==> Disjoint(h_$24[o_$36,ND],h_$24[o'_$11,ND])) ))) ));
	assume (forall  h_$25 : THeap, Ex1_$11 : TRegion, Ex2_$7 : TRegion :: ( InvAAEx(h_$25,Ex1_$11,Ex2_$7) <==> ((forall  o_$37 : ref, o'_$12 : ref :: {h_$25[o_$37,NA][o'_$12]} ( ((((!(o_$37 == null)) && (!(o'_$12 == null))) && (!Ex1_$11[o_$37])) && (!Ex2_$7[o'_$12])) ==> (h_$25[o_$37,NA][o'_$12] ==> Sub(h_$25[o'_$12,NA],h_$25[o_$37,NA])) ))) ));
	assume (forall  h_$26 : THeap, Ex1_$12 : TRegion :: ( InvAp1Ex(h_$26,Ex1_$12) <==> ((forall  o_$38 : ref :: {h_$26[o_$38,Np]} ( ((!(o_$38 == null)) && (!Ex1_$12[o_$38])) ==> ((h_$26[o_$38,Np] == null) ==> Equal(h_$26[o_$38,NA],Empty)) ))) ));
	assume (forall  h_$27 : THeap, Ex1_$13 : TRegion :: ( InvAp2Ex(h_$27,Ex1_$13) <==> ((forall  o_$39 : ref :: {h_$27[o_$39,Np]} ( ((!(o_$39 == null)) && (!Ex1_$13[o_$39])) ==> ((!(h_$27[o_$39,Np] == null)) ==> Equal(h_$27[o_$39,NA],AddEl(h_$27[h_$27[o_$39,Np],NA],h_$27[o_$39,Np]))) ))) ));
	assume (forall  h_$28 : THeap, Ex1_$14 : TRegion :: ( InvAt1Ex(h_$28,Ex1_$14) <==> ((forall  o_$40 : ref :: {h_$28[o_$40,Nt]} ( ((!(o_$40 == null)) && (!Ex1_$14[o_$40])) ==> ((!(h_$28[o_$40,Np] == null)) ==> h_$28[o_$40,NA][h_$28[o_$40,Nt]]) ))) ));
	assume (forall  h_$29 : THeap, Ex1_$15 : TRegion :: ( InvAt2Ex(h_$29,Ex1_$15) <==> ((forall  o_$41 : ref :: {h_$29[o_$41,Nt]} ( ((!(o_$41 == null)) && (!Ex1_$15[o_$41])) ==> ((h_$29[o_$41,Np] == null) ==> (h_$29[o_$41,Nt] == o_$41)) ))) ));
	assume (forall  h_$30 : THeap, Ex1_$16 : TRegion, Ex2_$8 : TRegion :: ( InvAt3Ex(h_$30,Ex1_$16,Ex2_$8) <==> ((forall  o_$42 : ref, o'_$13 : ref :: {h_$30[o_$42,NA][o'_$13]} ( ((((!(o_$42 == null)) && (!(o'_$13 == null))) && (!Ex1_$16[o_$42])) && (!Ex2_$8[o'_$13])) ==> (h_$30[o_$42,NA][o'_$13] ==> (h_$30[o_$42,Nt] == h_$30[o'_$13,Nt])) ))) ));
	assume (forall  h_$31 : THeap :: ( InvIsGoodRegionsTree(h_$31) <==> InvIsGoodRegionsTreeEx(h_$31,Empty) ));
	assume (forall  h_$32 : THeap :: ( InvCp(h_$32) <==> InvCpEx(h_$32,Empty,Empty) ));
	assume (forall  h_$33 : THeap :: ( InvCC(h_$33) <==> InvCCEx(h_$33,Empty,Empty) ));
	assume (forall  h_$34 : THeap :: ( InvD(h_$34) <==> InvDEx(h_$34,Empty) ));
	assume (forall  h_$35 : THeap :: ( InvA(h_$35) <==> InvAEx(h_$35,Empty) ));
	assume (forall  h_$36 : THeap :: ( InvCD1(h_$36) <==> InvCD1Ex(h_$36,Empty) ));
	assume (forall  h_$37 : THeap :: ( InvCD2(h_$37) <==> InvCD2Ex(h_$37,Empty,Empty) ));
	assume (forall  h_$38 : THeap :: ( InvAD1(h_$38) <==> InvAD1Ex(h_$38,Empty,Empty) ));
	assume (forall  h_$39 : THeap :: ( InvAD2(h_$39) <==> InvAD2Ex(h_$39,Empty,Empty) ));
	assume (forall  h_$40 : THeap :: ( InvAD3(h_$40) <==> InvAD3Ex(h_$40,Empty,Empty) ));
	assume (forall  h_$41 : THeap :: ( InvDD1(h_$41) <==> InvDD1Ex(h_$41,Empty,Empty) ));
	assume (forall  h_$42 : THeap :: ( InvDD2(h_$42) <==> InvDD2Ex(h_$42,Empty,Empty) ));
	assume (forall  h_$43 : THeap :: ( InvAA(h_$43) <==> InvAAEx(h_$43,Empty,Empty) ));
	assume (forall  h_$44 : THeap :: ( InvAp1(h_$44) <==> InvAp1Ex(h_$44,Empty) ));
	assume (forall  h_$45 : THeap :: ( InvAp2(h_$45) <==> InvAp2Ex(h_$45,Empty) ));
	assume (forall  h_$46 : THeap :: ( InvAt1(h_$46) <==> InvAt1Ex(h_$46,Empty) ));
	assume (forall  h_$47 : THeap :: ( InvAt2(h_$47) <==> InvAt2Ex(h_$47,Empty) ));
	assume (forall  h_$48 : THeap :: ( InvAt3(h_$48) <==> InvAt3Ex(h_$48,Empty,Empty) ));
	assume (forall  h_$49 : THeap, Ex : TRegion :: {InvTreeEx(h_$49,Ex)} ( InvTreeEx(h_$49,Ex) <==> (((((((((((((((((InvIsGoodRegionsTreeEx(h_$49,Ex) && InvCpEx(h_$49,Ex,Ex)) && InvCCEx(h_$49,Ex,Ex)) && InvDEx(h_$49,Ex)) && InvAEx(h_$49,Ex)) && InvCD1Ex(h_$49,Ex)) && InvCD2Ex(h_$49,Ex,Ex)) && InvAD1Ex(h_$49,Ex,Ex)) && InvAD2Ex(h_$49,Ex,Ex)) && InvAD3Ex(h_$49,Ex,Ex)) && InvDD1Ex(h_$49,Ex,Ex)) && InvDD2Ex(h_$49,Ex,Ex)) && InvAAEx(h_$49,Ex,Ex)) && InvAp1Ex(h_$49,Ex)) && InvAp2Ex(h_$49,Ex)) && InvAt1Ex(h_$49,Ex)) && InvAt2Ex(h_$49,Ex)) && InvAt3Ex(h_$49,Ex,Ex)) ));
	assume (forall  h_$50 : THeap :: {InvTree(h_$50)} ( InvTree(h_$50) <==> InvTreeEx(h_$50,Empty) ));
	assume (forall  h_$51 : THeap, Ex1_$17 : TRegion :: ( InvIsGoodRegionsListEx(h_$51,Ex1_$17) <==> ((forall  o_$43 : ref :: ( IsGoodRegion(h_$51[o_$43,LL]) ))) ));
	assume (forall  h_$52 : THeap, Ex1_$18 : TRegion :: ( InvLEx(h_$52,Ex1_$18) <==> ((forall  o_$44 : ref :: {h_$52[o_$44,LL]} ( ((!(o_$44 == null)) && (!Ex1_$18[o_$44])) ==> h_$52[o_$44,LL][o_$44] ))) ));
	assume (forall  h_$53 : THeap, Ex1_$19 : TRegion :: ( Inve1Ex(h_$53,Ex1_$19) <==> ((forall  o_$45 : ref :: {h_$53[o_$45,Le]} ( ((!(o_$45 == null)) && (!Ex1_$19[o_$45])) ==> h_$53[o_$45,LL][h_$53[o_$45,Le]] ))) ));
	assume (forall  h_$54 : THeap, Ex1_$20 : TRegion :: ( Inve2Ex(h_$54,Ex1_$20) <==> ((forall  o_$46 : ref :: {h_$54[o_$46,Le],h_$54[o_$46,Ln]} ( ((!(o_$46 == null)) && (!Ex1_$20[o_$46])) ==> ((o_$46 == h_$54[o_$46,Le]) <==> (h_$54[o_$46,Ln] == null)) ))) ));
	assume (forall  h_$55 : THeap, Ex1_$21 : TRegion :: ( Invb1Ex(h_$55,Ex1_$21) <==> ((forall  o_$47 : ref :: {h_$55[o_$47,Lb]} ( ((!(o_$47 == null)) && (!Ex1_$21[o_$47])) ==> h_$55[o_$47,LL][h_$55[o_$47,Lb]] ))) ));
	assume (forall  h_$56 : THeap, Ex1_$22 : TRegion :: ( Invb2Ex(h_$56,Ex1_$22) <==> ((forall  o_$48 : ref :: {h_$56[o_$48,Lb],h_$56[o_$48,Lp]} ( ((!(o_$48 == null)) && (!Ex1_$22[o_$48])) ==> ((o_$48 == h_$56[o_$48,Lb]) <==> (h_$56[o_$48,Lp] == null)) ))) ));
	assume (forall  h_$57 : THeap, Ex1_$23 : TRegion :: ( InvnEx(h_$57,Ex1_$23) <==> ((forall  o_$49 : ref :: {h_$57[o_$49,Ln]} ( ((!(o_$49 == null)) && (!Ex1_$23[o_$49])) ==> ((!(h_$57[o_$49,Ln] == null)) ==> h_$57[o_$49,LL][h_$57[o_$49,Ln]]) ))) ));
	assume (forall  h_$58 : THeap, Ex1_$24 : TRegion :: ( InvpEx(h_$58,Ex1_$24) <==> ((forall  o_$50 : ref :: {h_$58[o_$50,Lp]} ( ((!(o_$50 == null)) && (!Ex1_$24[o_$50])) ==> ((!(h_$58[o_$50,Lp] == null)) ==> h_$58[o_$50,LL][h_$58[o_$50,Lp]]) ))) ));
	assume (forall  h_$59 : THeap, Ex1_$25 : TRegion :: ( InvnpEx(h_$59,Ex1_$25) <==> ((forall  o_$51 : ref :: {h_$59[h_$59[o_$51,Ln],Lp]} ( ((!(o_$51 == null)) && (!Ex1_$25[o_$51])) ==> ((!(h_$59[o_$51,Ln] == null)) ==> (h_$59[h_$59[o_$51,Ln],Lp] == o_$51)) ))) ));
	assume (forall  h_$60 : THeap, Ex1_$26 : TRegion :: ( InvpnEx(h_$60,Ex1_$26) <==> ((forall  o_$52 : ref :: {h_$60[h_$60[o_$52,Lp],Ln]} ( ((!(o_$52 == null)) && (!Ex1_$26[o_$52])) ==> ((!(h_$60[o_$52,Lp] == null)) ==> (h_$60[h_$60[o_$52,Lp],Ln] == o_$52)) ))) ));
	assume (forall  h_$61 : THeap, Ex1_$27 : TRegion, Ex2_$9 : TRegion :: ( InvLbEx(h_$61,Ex1_$27,Ex2_$9) <==> ((forall  o_$53 : ref, o'_$14 : ref :: {h_$61[o_$53,LL][o'_$14]} ( ((((!(o_$53 == null)) && (!(o'_$14 == null))) && (!Ex1_$27[o_$53])) && (!Ex2_$9[o'_$14])) ==> (h_$61[o_$53,LL][o'_$14] ==> (h_$61[o_$53,Lb] == h_$61[o'_$14,Lb])) ))) ));
	assume (forall  h_$62 : THeap, Ex1_$28 : TRegion, Ex2_$10 : TRegion :: ( InvLeEx(h_$62,Ex1_$28,Ex2_$10) <==> ((forall  o_$54 : ref, o'_$15 : ref :: {h_$62[o_$54,LL][o'_$15]} ( ((((!(o_$54 == null)) && (!(o'_$15 == null))) && (!Ex1_$28[o_$54])) && (!Ex2_$10[o'_$15])) ==> (h_$62[o_$54,LL][o'_$15] ==> (h_$62[o_$54,Le] == h_$62[o'_$15,Le])) ))) ));
	assume (forall  h_$63 : THeap, Ex1_$29 : TRegion, Ex2_$11 : TRegion :: ( InvLL1Ex(h_$63,Ex1_$29,Ex2_$11) <==> ((forall  o_$55 : ref, o'_$16 : ref :: {h_$63[o_$55,LL][o'_$16]} ( ((((!(o_$55 == null)) && (!(o'_$16 == null))) && (!Ex1_$29[o_$55])) && (!Ex2_$11[o'_$16])) ==> (h_$63[o_$55,LL][o'_$16] ==> Equal(h_$63[o_$55,LL],h_$63[o'_$16,LL])) ))) ));
	assume (forall  h_$64 : THeap, Ex1_$30 : TRegion, Ex2_$12 : TRegion :: ( InvLL2Ex(h_$64,Ex1_$30,Ex2_$12) <==> ((forall  o_$56 : ref, o'_$17 : ref :: {h_$64[o_$56,LL][o'_$17]} ( ((((!(o_$56 == null)) && (!(o'_$17 == null))) && (!Ex1_$30[o_$56])) && (!Ex2_$12[o'_$17])) ==> ((!h_$64[o_$56,LL][o'_$17]) ==> Disjoint(h_$64[o_$56,LL],h_$64[o'_$17,LL])) ))) ));
	assume (forall  h_$65 : THeap :: ( InvIsGoodRegionsList(h_$65) <==> InvIsGoodRegionsListEx(h_$65,Empty) ));
	assume (forall  h_$66 : THeap :: ( InvL(h_$66) <==> InvLEx(h_$66,Empty) ));
	assume (forall  h_$67 : THeap :: ( Inve1(h_$67) <==> Inve1Ex(h_$67,Empty) ));
	assume (forall  h_$68 : THeap :: ( Inve2(h_$68) <==> Inve2Ex(h_$68,Empty) ));
	assume (forall  h_$69 : THeap :: ( Invb1(h_$69) <==> Invb1Ex(h_$69,Empty) ));
	assume (forall  h_$70 : THeap :: ( Invb2(h_$70) <==> Invb2Ex(h_$70,Empty) ));
	assume (forall  h_$71 : THeap :: ( Invn(h_$71) <==> InvnEx(h_$71,Empty) ));
	assume (forall  h_$72 : THeap :: ( Invp(h_$72) <==> InvpEx(h_$72,Empty) ));
	assume (forall  h_$73 : THeap :: ( Invpn(h_$73) <==> InvpnEx(h_$73,Empty) ));
	assume (forall  h_$74 : THeap :: ( Invnp(h_$74) <==> InvnpEx(h_$74,Empty) ));
	assume (forall  h_$75 : THeap :: ( InvLb(h_$75) <==> InvLbEx(h_$75,Empty,Empty) ));
	assume (forall  h_$76 : THeap :: ( InvLe(h_$76) <==> InvLeEx(h_$76,Empty,Empty) ));
	assume (forall  h_$77 : THeap :: ( InvLL1(h_$77) <==> InvLL1Ex(h_$77,Empty,Empty) ));
	assume (forall  h_$78 : THeap :: ( InvLL2(h_$78) <==> InvLL2Ex(h_$78,Empty,Empty) ));
	assume (forall  h_$79 : THeap, Ex_$0 : TRegion :: {InvListEx(h_$79,Ex_$0)} ( InvListEx(h_$79,Ex_$0) <==> (((((((((((((InvIsGoodRegionsListEx(h_$79,Ex_$0) && InvLEx(h_$79,Ex_$0)) && Inve1Ex(h_$79,Ex_$0)) && Inve2Ex(h_$79,Ex_$0)) && Invb1Ex(h_$79,Ex_$0)) && Invb2Ex(h_$79,Ex_$0)) && InvnEx(h_$79,Ex_$0)) && InvpEx(h_$79,Ex_$0)) && InvpnEx(h_$79,Ex_$0)) && InvnpEx(h_$79,Ex_$0)) && InvLbEx(h_$79,Ex_$0,Ex_$0)) && InvLeEx(h_$79,Ex_$0,Ex_$0)) && InvLL1Ex(h_$79,Ex_$0,Ex_$0)) && InvLL2Ex(h_$79,Ex_$0,Ex_$0)) ));
	assume (forall  h_$80 : THeap :: {InvList(h_$80)} ( InvList(h_$80) <==> InvListEx(h_$80,Empty) ));
	assume (forall  h_$81 : THeap, Ex1_$31 : TRegion :: ( InvStFEx(h_$81,Ex1_$31) <==> ((forall  o_$57 : ref :: ( ((!(o_$57 == null)) && (!Ex1_$31[o_$57])) ==> ((h_$81[o_$57,NSt] == StF) <==> ((h_$81[o_$57,Nbb] == null) && (h_$81[o_$57,Np] == h_$81[o_$57,Nbb]))) ))) ));
	assume (forall  h_$82 : THeap, Ex1_$32 : TRegion :: ( InvStLEx(h_$82,Ex1_$32) <==> ((forall  o_$58 : ref :: ( ((!(o_$58 == null)) && (!Ex1_$32[o_$58])) ==> ((h_$82[o_$58,NSt] == StL) <==> ((!(h_$82[o_$58,Nbb] == null)) && (h_$82[o_$58,Np] == h_$82[o_$58,Nbb]))) ))) ));
	assume (forall  h_$83 : THeap, Ex1_$33 : TRegion :: ( InvStDEx(h_$83,Ex1_$33) <==> ((forall  o_$59 : ref :: ( ((!(o_$59 == null)) && (!Ex1_$33[o_$59])) ==> ((h_$83[o_$59,NSt] == StD) <==> ((!(h_$83[o_$59,Nbb] == null)) && (CLn(h_$83,o_$59) == h_$83[o_$59,Nbb]))) ))) ));
	assume (forall  h_$84 : THeap, Ex1_$34 : TRegion :: ( InvStNDLEx(h_$84,Ex1_$34) <==> ((forall  o_$60 : ref :: ( ((!(o_$60 == null)) && (!Ex1_$34[o_$60])) ==> ((!(h_$84[o_$60,NSt] == StD)) ==> IsEmptyList(h_$84,o_$60)) ))) ));
	assume (forall  h_$85 : THeap, Ex1_$35 : TRegion, Ex2_$13 : TRegion :: ( InvStDCCEx(h_$85,Ex1_$35,Ex2_$13) <==> ((forall  o_$61 : ref, o'_$18 : ref :: ( ((((!(o_$61 == null)) && (!(o'_$18 == null))) && (!Ex1_$35[o_$61])) && (!Ex2_$13[o'_$18])) ==> (((h_$85[o_$61,NSt] == StD) && h_$85[o_$61,LL][o'_$18]) ==> (h_$85[o'_$18,NSt] == StD)) ))) ));
	assume (forall  h_$86 : THeap, Ex1_$36 : TRegion, Ex2_$14 : TRegion :: ( InvStADEx(h_$86,Ex1_$36,Ex2_$14) <==> ((forall  o_$62 : ref, o'_$19 : ref :: ( ((((!(o_$62 == null)) && (!(o'_$19 == null))) && (!Ex1_$36[o_$62])) && (!Ex2_$14[o'_$19])) ==> (h_$86[o_$62,ND][o'_$19] ==> (h_$86[o'_$19,NSt] == StL)) ))) ));
	assume (forall  h_$87 : THeap :: ( InvStF(h_$87) <==> InvStFEx(h_$87,Empty) ));
	assume (forall  h_$88 : THeap :: ( InvStL(h_$88) <==> InvStLEx(h_$88,Empty) ));
	assume (forall  h_$89 : THeap :: ( InvStD(h_$89) <==> InvStDEx(h_$89,Empty) ));
	assume (forall  h_$90 : THeap :: ( InvStNDL(h_$90) <==> InvStNDLEx(h_$90,Empty) ));
	assume (forall  h_$91 : THeap :: ( InvStDCC(h_$91) <==> InvStDCCEx(h_$91,Empty,Empty) ));
	assume (forall  h_$92 : THeap :: ( InvStAD(h_$92) <==> InvStADEx(h_$92,Empty,Empty) ));
	assume (forall  h_$93 : THeap, Ex_$1 : TRegion :: ( InvStructEx(h_$93,Ex_$1) <==> (((((((InvTreeEx(h_$93,Ex_$1) && InvListEx(h_$93,Ex_$1)) && InvStFEx(h_$93,Ex_$1)) && InvStLEx(h_$93,Ex_$1)) && InvStDEx(h_$93,Ex_$1)) && InvStNDLEx(h_$93,Ex_$1)) && InvStDCCEx(h_$93,Ex_$1,Ex_$1)) && InvStADEx(h_$93,Ex_$1,Ex_$1)) ));
	assume (forall  h_$94 : THeap :: ( InvStruct(h_$94) <==> InvStructEx(h_$94,Empty) ));
	assume (forall  h_$95 : THeap, o_$63 : ref :: ( InvPr(h_$95,o_$63) <==> ((((h_$95[o_$63,Ncpr] == Max(h_$95[o_$63,Ndpr],MaxMSet(h_$95[o_$63,Npr]))) && (h_$95[o_$63,Ncpr] >= 0)) && (h_$95[o_$63,Ndpr] >= 0)) && ((forall  i_$8 : Integer :: ( (i_$8 > 0) ==> (h_$95[o_$63,Npr][i_$8] == Card(FBP(h_$95,BBSet(h_$95,o_$63),i_$8))) )))) ));
	assume (forall  h_$96 : THeap, o_$64 : ref, from : Integer, to : Integer :: ( InvPrSt(h_$96,o_$64,from,to) <==> ((((((forall  i_$9 : Integer :: ( (((i_$9 > 0) && (!(i_$9 == from))) && (!(i_$9 == to))) ==> (h_$96[o_$64,Npr][i_$9] == Card(FBP(h_$96,BBSet(h_$96,o_$64),i_$9))) ))) && ((from > 0) ==> (h_$96[o_$64,Npr][from] == (Card(FBP(h_$96,BBSet(h_$96,o_$64),from)) + 1)))) && ((to > 0) ==> (h_$96[o_$64,Npr][to] == (Card(FBP(h_$96,BBSet(h_$96,o_$64),to)) - 1)))) && (h_$96[o_$64,Ncpr] >= 0)) && (h_$96[o_$64,Ndpr] >= 0)) ));
	assume (forall  h_$97 : THeap, hOld : THeap, this : ref :: ( (((((InvPr(hOld,this) && Equal(BBSet(h_$97,this),BBSet(hOld,this))) && (h_$97[this,Npr] == hOld[this,Npr])) && (h_$97[this,Ndpr] == hOld[this,Ndpr])) && (h_$97[this,Ncpr] == hOld[this,Ncpr])) && ((forall  o_$65 : ref :: ( BBSet(h_$97,this)[o_$65] ==> (h_$97[o_$65,Ncpr] == hOld[o_$65,Ncpr]) )))) ==> InvPr(h_$97,this) ));
	assume (forall  h_$98 : THeap, hOld_$0 : THeap, this_$0 : ref :: ( ((((((((InvPr(hOld_$0,this_$0) && (h_$98[this_$0,NC] == hOld_$0[this_$0,NC])) && (h_$98[this_$0,Lp] == hOld_$0[this_$0,Lp])) && (h_$98[this_$0,Le] == hOld_$0[this_$0,Le])) && (h_$98[this_$0,NSt] == hOld_$0[this_$0,NSt])) && (h_$98[this_$0,Npr] == hOld_$0[this_$0,Npr])) && (h_$98[this_$0,Ndpr] == hOld_$0[this_$0,Ndpr])) && (h_$98[this_$0,Ncpr] == hOld_$0[this_$0,Ncpr])) && ((forall  o_$66 : ref :: ( BBSet(h_$98,this_$0)[o_$66] ==> (h_$98[o_$66,Ncpr] == hOld_$0[o_$66,Ncpr]) )))) ==> InvPr(h_$98,this_$0) ));
	assume (forall  h_$99 : THeap, hOld_$1 : THeap, this_$1 : ref, child : ref, newNcpr : Integer :: ( ((((((InvPr(hOld_$1,this_$1) && BBSet(hOld_$1,this_$1)[child]) && (newNcpr >= 0)) && (!(child == null))) && (!(hOld_$1[child,Ncpr] == newNcpr))) && (h_$99[child,Ncpr] == newNcpr)) && ((forall<a> o_$67 : ref, f_$1 : field (a)  :: ( (h_$99[o_$67,f_$1] == hOld_$1[o_$67,f_$1]) || ((o_$67 == child) && (f_$1 == Ncpr)) )))) ==> InvPrSt(h_$99,this_$1,hOld_$1[child,Ncpr],newNcpr) ));
	assume (forall  h_$100 : THeap, hOld_$2 : THeap, this_$2 : ref, child_$0 : ref :: ( (((((((InvPr(hOld_$2,this_$2) && BBSet(hOld_$2,this_$2)[child_$0]) && (!(child_$0 == null))) && Equal(BBSet(h_$100,this_$2),RemEl(BBSet(hOld_$2,this_$2),child_$0))) && (h_$100[this_$2,Npr] == hOld_$2[this_$2,Npr])) && (h_$100[this_$2,Ndpr] == hOld_$2[this_$2,Ndpr])) && (h_$100[this_$2,Ncpr] == hOld_$2[this_$2,Ncpr])) && ((forall  o_$68 : ref :: ( BBSet(h_$100,this_$2)[o_$68] ==> (h_$100[o_$68,Ncpr] == hOld_$2[o_$68,Ncpr]) )))) ==> (InvPrSt(h_$100,this_$2,hOld_$2[child_$0,Ncpr],0) && ((hOld_$2[child_$0,Ncpr] == 0) ==> InvPr(h_$100,this_$2))) ));
	assume (forall  h_$101 : THeap, hOld_$3 : THeap, this_$3 : ref, child_$1 : ref :: ( (((((((InvPr(hOld_$3,this_$3) && (!BBSet(hOld_$3,this_$3)[child_$1])) && (!(child_$1 == null))) && Equal(BBSet(h_$101,this_$3),AddEl(BBSet(hOld_$3,this_$3),child_$1))) && (h_$101[this_$3,Npr] == hOld_$3[this_$3,Npr])) && (h_$101[this_$3,Ndpr] == hOld_$3[this_$3,Ndpr])) && (h_$101[this_$3,Ncpr] == hOld_$3[this_$3,Ncpr])) && ((forall  o_$69 : ref :: ( BBSet(h_$101,this_$3)[o_$69] ==> (h_$101[o_$69,Ncpr] == hOld_$3[o_$69,Ncpr]) )))) ==> (InvPrSt(h_$101,this_$3,0,hOld_$3[child_$1,Ncpr]) && ((hOld_$3[child_$1,Ncpr] == 0) ==> InvPr(h_$101,this_$3))) ));
	assume (forall  h_$102 : THeap, hOld_$4 : THeap, from_$0 : Integer, to_$0 : Integer, this_$4 : ref :: ( (((((InvPrSt(hOld_$4,this_$4,from_$0,to_$0) && Equal(BBSet(h_$102,this_$4),BBSet(hOld_$4,this_$4))) && (h_$102[this_$4,Npr] == hOld_$4[this_$4,Npr])) && (h_$102[this_$4,Ndpr] == hOld_$4[this_$4,Ndpr])) && (h_$102[this_$4,Ncpr] == hOld_$4[this_$4,Ncpr])) && ((forall  o_$70 : ref :: ( BBSet(h_$102,this_$4)[o_$70] ==> (h_$102[o_$70,Ncpr] == hOld_$4[o_$70,Ncpr]) )))) ==> InvPrSt(h_$102,this_$4,from_$0,to_$0) ));
	assume (forall  h_$103 : THeap, hOld_$5 : THeap, from_$1 : Integer, to_$1 : Integer, this_$5 : ref :: ( ((((((InvPrSt(hOld_$5,this_$5,from_$1,to_$1) && Equal(BBSet(h_$103,this_$5),BBSet(hOld_$5,this_$5))) && ((from_$1 <= 0) ==> (h_$103[this_$5,Npr] == hOld_$5[this_$5,Npr]))) && ((from_$1 > 0) ==> (h_$103[this_$5,Npr] == RemoveMSet(hOld_$5[this_$5,Npr],from_$1)))) && (h_$103[this_$5,Ndpr] == hOld_$5[this_$5,Ndpr])) && (h_$103[this_$5,Ncpr] == hOld_$5[this_$5,Ncpr])) && ((forall  o_$71 : ref :: ( BBSet(h_$103,this_$5)[o_$71] ==> (h_$103[o_$71,Ncpr] == hOld_$5[o_$71,Ncpr]) )))) ==> InvPrSt(h_$103,this_$5,0,to_$1) ));
	assume (forall  h_$104 : THeap, hOld_$6 : THeap, from_$2 : Integer, to_$2 : Integer, this_$6 : ref :: ( ((((((InvPrSt(hOld_$6,this_$6,from_$2,to_$2) && Equal(BBSet(h_$104,this_$6),BBSet(hOld_$6,this_$6))) && ((to_$2 <= 0) ==> (h_$104[this_$6,Npr] == hOld_$6[this_$6,Npr]))) && ((to_$2 > 0) ==> (h_$104[this_$6,Npr] == AddMSet(hOld_$6[this_$6,Npr],to_$2)))) && (h_$104[this_$6,Ndpr] == hOld_$6[this_$6,Ndpr])) && (h_$104[this_$6,Ncpr] == hOld_$6[this_$6,Ncpr])) && ((forall  o_$72 : ref :: ( BBSet(h_$104,this_$6)[o_$72] ==> (h_$104[o_$72,Ncpr] == hOld_$6[o_$72,Ncpr]) )))) ==> InvPrSt(h_$104,this_$6,from_$2,0) ));
	assume (forall  h_$105 : THeap, hOld_$7 : THeap, this_$7 : ref :: ( (((InvPrSt(hOld_$7,this_$7,0,0) && (!BBSet(hOld_$7,this_$7)[this_$7])) && (h_$105[this_$7,Ncpr] == Max(hOld_$7[this_$7,Ndpr],MaxMSet(hOld_$7[this_$7,Npr])))) && ((forall<a> o_$73 : ref, f_$2 : field (a)  :: ( (h_$105[o_$73,f_$2] == hOld_$7[o_$73,f_$2]) || ((o_$73 == this_$7) && (f_$2 == Ncpr)) )))) ==> InvPr(h_$105,this_$7) ));
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume !(tree == null);
	assume !(subTree == null);
	assume !(tree == subTree);
	assume !$Heap[subTree,ND][tree];
	assume $Heap[subTree,Np] == null;
	assume InvTree($Heap);
	assume InvList($Heap);
	goto anon0;
anon0:
	assume $Heap_$_0 == $Heap[subTree,Np := tree];
	assume $Heap_$_1 == $Heap_$_0[tree,NC := AddEl($Heap_$_0[tree,NC],subTree)];
	assume call0formal_$_r1_$_0 == AddEl($Heap_$_1[tree,NA],tree);
	assume call2formal_$_r2_$_0 == AddEl($Heap_$_1[subTree,ND],subTree);
	assume (forall  o_$74 : ref :: ( call0formal_$_r1_$_0[o_$74] ==> ($Heap_$_2[o_$74,ND] == Union($Heap_$_1[o_$74,ND],call2formal_$_r2_$_0)) ));
	assume (forall<a> o_$75 : ref, f_$3 : field (a)  :: ( ($Heap_$_2[o_$75,f_$3] == $Heap_$_1[o_$75,f_$3]) || (call0formal_$_r1_$_0[o_$75] && (f_$3 == ND)) ));
	assume call0formal_$_r1_$_0 == AddEl($Heap_$_2[subTree,ND],subTree);
	assume call2formal_$_r2_$_0 == AddEl($Heap_$_2[tree,NA],tree);
	assume (forall  o_$76 : ref :: ( call0formal_$_r1_$_0[o_$76] ==> ($Heap_$_3[o_$76,NA] == Union($Heap_$_2[o_$76,NA],call2formal_$_r2_$_0)) ));
	assume (forall<a> o_$77 : ref, f_$4 : field (a)  :: ( ($Heap_$_3[o_$77,f_$4] == $Heap_$_2[o_$77,f_$4]) || (call0formal_$_r1_$_0[o_$77] && (f_$4 == NA)) ));
	assume call0formal_$_r1_$_0 == AddEl($Heap_$_3[subTree,ND],subTree);
	assume call2formal_$_val_$_0 == $Heap_$_3[tree,Nt];
	assume (forall  o_$78 : ref :: ( call0formal_$_r1_$_0[o_$78] ==> ($Heap_$_4[o_$78,Nt] == call2formal_$_val_$_0) ));
	assume (forall<a> o_$79 : ref, f_$5 : field (a)  :: ( ($Heap_$_4[o_$79,f_$5] == $Heap_$_3[o_$79,f_$5]) || (call0formal_$_r1_$_0[o_$79] && (f_$5 == Nt)) ));
	assert  InvTree($Heap_$_4);
	assert  InvList($Heap_$_4);
	assert  (forall<a> o_$80 : ref, f_$6 : field (a)  :: ( ((((($Heap_$_4[o_$80,f_$6] == $Heap[o_$80,f_$6]) || ((o_$80 == subTree) && (f_$6 == Np))) || (AddEl($Heap[subTree,ND],subTree)[o_$80] && (f_$6 == Nt))) || ((o_$80 == tree) && (f_$6 == NC))) || (AddEl($Heap[tree,NA],tree)[o_$80] && (f_$6 == ND))) || (AddEl($Heap[subTree,ND],subTree)[o_$80] && (f_$6 == NA)) ));
	assert  $Heap_$_4[subTree,Np] == tree;
	assert  (forall  o_$81 : ref :: ( AddEl($Heap_$_4[subTree,ND],subTree)[o_$81] ==> ($Heap_$_4[o_$81,Nt] == $Heap[tree,Nt]) ));
	assert  $Heap_$_4[tree,NC] == AddEl($Heap[tree,NC],subTree);
	assert  (forall  o_$82 : ref :: ( AddEl($Heap_$_4[tree,NA],tree)[o_$82] ==> ($Heap_$_4[o_$82,ND] == Union($Heap[o_$82,ND],AddEl($Heap_$_4[subTree,ND],subTree))) ));
	assert  (forall  o_$83 : ref :: ( AddEl($Heap[subTree,ND],subTree)[o_$83] ==> ($Heap_$_4[o_$83,NA] == Union($Heap[o_$83,NA],AddEl($Heap_$_4[tree,NA],tree))) ));
	goto $exit;
}
