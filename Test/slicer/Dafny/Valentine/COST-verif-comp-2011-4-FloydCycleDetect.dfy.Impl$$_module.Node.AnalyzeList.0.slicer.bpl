type Integer = int;
type Boolean = bool;
type Set T = [T]bool;
type MultiSet T = [T]int;
type HeapType = <alpha>[ref,Field (alpha)]alpha;
type ref;
type Seq m0;
type Map m0 m1;
type BoxType;
type ClassName;
type DatatypeType;
type DtCtorId;
type LayerType;
type Field m0;
type NameFamily;
type TickType;
const $$Language$Dafny : bool;
const null : ref;
const unique class._System.int : ClassName;
const unique class._System.bool : ClassName;
const unique class._System.set : ClassName;
const unique class._System.seq : ClassName;
const unique class._System.multiset : ClassName;
const unique class._System.array : ClassName;
const $ModuleContextHeight : int;
const $FunctionContextHeight : int;
const $LZ : LayerType;
const unique alloc : Field (bool);
const unique class._System.object : ClassName;
const unique class._module.Node : ClassName;
const _module.Node.next : Field (ref);
const unique class._module.__default : ClassName;
const unique field$next : NameFamily;
const $old_$Heap : HeapType;
const $old_$Tick : TickType;
function {:identity } Lit <T> (T) : T;
function Set#Card <T> (Set (T) ) : int;
function Set#Empty <T> () : Set (T) ;
function Set#Singleton <T> (T) : Set (T) ;
function Set#UnionOne <T> (Set (T) ,T) : Set (T) ;
function Set#Union <T> (Set (T) ,Set (T) ) : Set (T) ;
function Set#Intersection <T> (Set (T) ,Set (T) ) : Set (T) ;
function Set#Difference <T> (Set (T) ,Set (T) ) : Set (T) ;
function Set#Subset <T> (Set (T) ,Set (T) ) : bool;
function Set#Equal <T> (Set (T) ,Set (T) ) : bool;
function Set#Disjoint <T> (Set (T) ,Set (T) ) : bool;
function Math#min(int,int) : int;
function Math#clip(int) : int;
function $IsGoodMultiSet <T> (MultiSet (T) ) : bool;
function MultiSet#Card <T> (MultiSet (T) ) : int;
function MultiSet#Empty <T> () : MultiSet (T) ;
function MultiSet#Singleton <T> (T) : MultiSet (T) ;
function MultiSet#UnionOne <T> (MultiSet (T) ,T) : MultiSet (T) ;
function MultiSet#Union <T> (MultiSet (T) ,MultiSet (T) ) : MultiSet (T) ;
function MultiSet#Intersection <T> (MultiSet (T) ,MultiSet (T) ) : MultiSet (T) ;
function MultiSet#Difference <T> (MultiSet (T) ,MultiSet (T) ) : MultiSet (T) ;
function MultiSet#Subset <T> (MultiSet (T) ,MultiSet (T) ) : bool;
function MultiSet#Equal <T> (MultiSet (T) ,MultiSet (T) ) : bool;
function MultiSet#Disjoint <T> (MultiSet (T) ,MultiSet (T) ) : bool;
function MultiSet#FromSet <T> (Set (T) ) : MultiSet (T) ;
function MultiSet#FromSeq <T> (Seq (T)) : MultiSet (T) ;
function Seq#Length <T> (Seq (T)) : int;
function Seq#Empty <T> () : Seq (T);
function Seq#Singleton <T> (T) : Seq (T);
function Seq#Build <T> (Seq (T),T) : Seq (T);
function Seq#Append <T> (Seq (T),Seq (T)) : Seq (T);
function Seq#Index <T> (Seq (T),int) : T;
function Seq#Update <T> (Seq (T),int,T) : Seq (T);
function Seq#Contains <T> (Seq (T),T) : bool;
function Seq#Equal <T> (Seq (T),Seq (T)) : bool;
function Seq#SameUntil <T> (Seq (T),Seq (T),int) : bool;
function Seq#Take <T> (Seq (T),int) : Seq (T);
function Seq#Drop <T> (Seq (T),int) : Seq (T);
function Seq#FromArray(HeapType,ref) : Seq (BoxType);
function Seq#Rank <T> (Seq (T)) : int;
function Map#Domain <U,V> (Map (U) (V)) : [U]bool;
function Map#Elements <U,V> (Map (U) (V)) : [U]V;
function Map#Card <U,V> (Map (U) (V)) : int;
function Map#Empty <U,V> () : Map (U) (V);
function Map#Glue <U,V> ([U]bool,[U]V) : Map (U) (V);
function Map#Build <U,V> (Map (U) (V),U,V) : Map (U) (V);
function Map#Equal <U,V> (Map (U) (V),Map (U) (V)) : bool;
function Map#Disjoint <U,V> (Map (U) (V),Map (U) (V)) : bool;
function $Box <T> (T) : BoxType;
function $Unbox <T> (BoxType) : T;
function $IsCanonicalBoolBox(BoxType) : bool;
function $IsGoodSet_Extended <T> (Set (BoxType) ,T) : bool;
function $IsGoodMultiSet_Extended <T> (MultiSet (BoxType) ,T) : bool;
function dtype(ref) : ClassName;
function TypeParams(ref,int) : ClassName;
function TypeTuple(ClassName,ClassName) : ClassName;
function TypeTupleCar(ClassName) : ClassName;
function TypeTupleCdr(ClassName) : ClassName;
function DtType(DatatypeType) : ClassName;
function DtTypeParams(DatatypeType,int) : ClassName;
function DatatypeCtorId(DatatypeType) : DtCtorId;
function DtRank(DatatypeType) : int;
function $LS(LayerType) : LayerType;
function FDim <T> (Field (T)) : int;
function IndexField(int) : Field (BoxType);
function IndexField_Inverse <T> (Field (T)) : int;
function MultiIndexField(Field (BoxType),int) : Field (BoxType);
function MultiIndexField_Inverse0 <T> (Field (T)) : Field (T);
function MultiIndexField_Inverse1 <T> (Field (T)) : int;
function DeclType <T> (Field (T)) : ClassName;
function DeclName <T> (Field (T)) : NameFamily;
function FieldOfDecl <alpha> (ClassName,NameFamily) : Field (alpha);
function $IsGhostField <T> (Field (T)) : bool;
function DtAlloc(DatatypeType,HeapType) : bool;
function GenericAlloc(BoxType,HeapType) : bool;
function _System.array.Length(ref) : int;
function {:inline  true} read <alpha> (H:HeapType,r:ref,f:Field (alpha)) : alpha {H[r,f]}
function {:inline  true} update <alpha> (H_$0:HeapType,r_$0:ref,f_$0:Field (alpha),v:alpha) : HeapType {H_$0[r_$0,f_$0 := v]}
function $IsGoodHeap(HeapType) : bool;
function $HeapSucc(HeapType,HeapType) : bool;
function $HeapSuccGhost(HeapType,HeapType) : bool;
function _module.Node.IsClosed(HeapType,ref,Set (BoxType) ) : bool;
function _module.Node.IsClosed#canCall(HeapType,ref,Set (BoxType) ) : bool;
function _module.Node.Nexxxt(LayerType,HeapType,ref,int,Set (BoxType) ) : ref;
function _module.Node.Nexxxt#canCall(HeapType,ref,int,Set (BoxType) ) : bool;
function _module.Node.Reaches(LayerType,HeapType,ref,ref,Set (BoxType) ) : bool;
function _module.Node.Reaches#canCall(HeapType,ref,ref,Set (BoxType) ) : bool;
function lambda#0(Set (BoxType) ,ref,HeapType,Field (bool)) : <alpha>[ref,Field (alpha)]bool;
function lambda#1(Set (BoxType) ,ref,HeapType,Field (bool)) : <alpha>[ref,Field (alpha)]bool;
function lambda#2(Set (BoxType) ,ref,HeapType,Field (bool)) : <alpha>[ref,Field (alpha)]bool;
function lambda#3(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#4(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#5(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#6(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#7(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#8(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#9(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#10(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#11(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#12(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#13(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#14(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#15(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#16(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#17(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#18(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#19(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#20(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#21(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
function lambda#22(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
var $Heap : HeapType;
var $Tick : TickType;
procedure Impl$$_module.Node.AnalyzeList (this : ref,S#0 : Set (BoxType) ) returns (A#1 : int,B#2 : int,$_reverifyPost : bool)
{
	var $_Frame : <beta>[ref,Field (beta)]bool;
	var p#30 : ref;
	var steps#31 : int;
	var Visited#32 : Set (BoxType) ;
	var $rhs#10 : ref;
	var $rhs#11 : int;
	var $rhs#12 : Set (BoxType) ;
	var $PreLoopHeap0 : HeapType;
	var $decr0$init$0 : Set (BoxType) ;
	var $w0 : bool;
	var k#33 : int;
	var S#34 : Set (BoxType) ;
	var t#35 : int;
	var k#36 : int;
	var S#37 : Set (BoxType) ;
	var q#40 : ref;
	var t#41 : int;
	var k#42 : int;
	var S#43 : Set (BoxType) ;
	var k#46 : int;
	var l#47 : int;
	var k#48 : int;
	var S#49 : Set (BoxType) ;
	var k#50 : int;
	var S#51 : Set (BoxType) ;
	var $decr0$0 : Set (BoxType) ;
	var $rhs#16 : ref;
	var $rhs#17 : int;
	var $rhs#18 : Set (BoxType) ;
	var $rhs#19 : int;
	var $rhs#20 : int;
	var k#56 : int;
	var k#57 : int;
	var S#58 : Set (BoxType) ;
	var $PreLoopHeap1 : HeapType;
	var $decr1$init$0 : int;
	var $w1 : bool;
	var k#60 : int;
	var k#61 : int;
	var S#62 : Set (BoxType) ;
	var k#65 : int;
	var S#66 : Set (BoxType) ;
	var $decr1$0 : int;
	var k#67 : int;
	var S#68 : Set (BoxType) ;
	var x##69 : int;
	var y##70 : int;
	var S##71 : Set (BoxType) ;
	var $_Frame_$_0 : <beta>[ref,Field (beta)]bool;
	var $rhs#11_$_0 : int;
	var $rhs#12_$_0 : Set (BoxType) ;
	var $decr0$init$0_$_0 : Set (BoxType) ;
	var $w0_$_0 : bool;
	var $decr0$0_$_0 : Set (BoxType) ;
	var $rhs#16_$_0 : ref;
	var $rhs#17_$_0 : int;
	var $rhs#18_$_0 : Set (BoxType) ;
	var p#30_$_0 : ref;
	var steps#31_$_0 : int;
	var Visited#32_$_0 : Set (BoxType) ;
	var $decr0$0_$_1 : Set (BoxType) ;
	var $rhs#16_$_1 : ref;
	var $rhs#17_$_1 : int;
	var $rhs#18_$_1 : Set (BoxType) ;
	var $rhs#20_$_0 : int;
	var k#56_$_0 : int;
	var A#1_$_0 : int;
	var $decr1$init$0_$_0 : int;
	var $w1_$_0 : bool;
	var $decr1$0_$_0 : int;
	var A#1_$_1 : int;
	var k#65_$_0 : int;
	var S#66_$_0 : Set (BoxType) ;
	var $decr1$0_$_1 : int;
	var A#1_$_2 : int;
	var B#2_$_0 : int;
	var $Heap_$_0 : HeapType;
	var $Tick_$_0 : TickType;
	var k#60_$_0 : int;
	var t#35_$_0 : int;
	var q#40_$_0 : ref;
	var t#41_$_0 : int;
	var k#46_$_0 : int;
	var l#47_$_0 : int;
	var A#1_$_3 : int;
	var B#2_$_1 : int;
	var $Heap_$_1 : HeapType;
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
$start:
	assume $$Language$Dafny;
	assume (forall<T> x : T :: {Lit(x)} {:identity }( Lit(x) == x ));
	assume (forall<T> x_$0 : T :: {$Box(Lit(x_$0))} ( $Box(Lit(x_$0)) == Lit($Box(x_$0)) ));
	assume (forall<T> s : Set (T)  :: {Set#Card(s)} ( 0 <= Set#Card(s) ));
	assume (forall<T> o : T :: {(Set#Empty() : Set (T) )[o]} ( !(Set#Empty() : Set (T) )[o] ));
	assume (forall<T> s_$0 : Set (T)  :: {Set#Card(s_$0)} ( ((Set#Card(s_$0) == 0) <==> (s_$0 == (Set#Empty() : Set (T) ))) && ((!(Set#Card(s_$0) == 0)) ==> ((exists  x_$1 : T :: ( s_$0[x_$1] )))) ));
	assume (forall<T> r_$1 : T :: {Set#Singleton(r_$1)} ( Set#Singleton(r_$1)[r_$1] ));
	assume (forall<T> r_$2 : T, o_$0 : T :: {Set#Singleton(r_$2)[o_$0]} ( Set#Singleton(r_$2)[o_$0] <==> (r_$2 == o_$0) ));
	assume (forall<T> r_$3 : T :: {Set#Card(Set#Singleton(r_$3))} ( Set#Card(Set#Singleton(r_$3)) == 1 ));
	assume (forall<T> a : Set (T) , x_$2 : T, o_$1 : T :: {Set#UnionOne(a,x_$2)[o_$1]} ( Set#UnionOne(a,x_$2)[o_$1] <==> ((o_$1 == x_$2) || a[o_$1]) ));
	assume (forall<T> a_$0 : Set (T) , x_$3 : T :: {Set#UnionOne(a_$0,x_$3)} ( Set#UnionOne(a_$0,x_$3)[x_$3] ));
	assume (forall<T> a_$1 : Set (T) , x_$4 : T, y : T :: {Set#UnionOne(a_$1,x_$4),a_$1[y]} ( a_$1[y] ==> Set#UnionOne(a_$1,x_$4)[y] ));
	assume (forall<T> a_$2 : Set (T) , x_$5 : T :: {Set#Card(Set#UnionOne(a_$2,x_$5))} ( a_$2[x_$5] ==> (Set#Card(Set#UnionOne(a_$2,x_$5)) == Set#Card(a_$2)) ));
	assume (forall<T> a_$3 : Set (T) , x_$6 : T :: {Set#Card(Set#UnionOne(a_$3,x_$6))} ( (!a_$3[x_$6]) ==> (Set#Card(Set#UnionOne(a_$3,x_$6)) == (Set#Card(a_$3) + 1)) ));
	assume (forall<T> a_$4 : Set (T) , b : Set (T) , o_$2 : T :: {Set#Union(a_$4,b)[o_$2]} ( Set#Union(a_$4,b)[o_$2] <==> (a_$4[o_$2] || b[o_$2]) ));
	assume (forall<T> a_$5 : Set (T) , b_$0 : Set (T) , y_$0 : T :: {Set#Union(a_$5,b_$0),a_$5[y_$0]} ( a_$5[y_$0] ==> Set#Union(a_$5,b_$0)[y_$0] ));
	assume (forall<T> a_$6 : Set (T) , b_$1 : Set (T) , y_$1 : T :: {Set#Union(a_$6,b_$1),b_$1[y_$1]} ( b_$1[y_$1] ==> Set#Union(a_$6,b_$1)[y_$1] ));
	assume (forall<T> a_$7 : Set (T) , b_$2 : Set (T)  :: {Set#Union(a_$7,b_$2)} ( Set#Disjoint(a_$7,b_$2) ==> ((Set#Difference(Set#Union(a_$7,b_$2),a_$7) == b_$2) && (Set#Difference(Set#Union(a_$7,b_$2),b_$2) == a_$7)) ));
	assume (forall<T> a_$8 : Set (T) , b_$3 : Set (T) , o_$3 : T :: {Set#Intersection(a_$8,b_$3)[o_$3]} ( Set#Intersection(a_$8,b_$3)[o_$3] <==> (a_$8[o_$3] && b_$3[o_$3]) ));
	assume (forall<T> a_$9 : Set (T) , b_$4 : Set (T)  :: {Set#Union(Set#Union(a_$9,b_$4),b_$4)} ( Set#Union(Set#Union(a_$9,b_$4),b_$4) == Set#Union(a_$9,b_$4) ));
	assume (forall<T> a_$10 : Set (T) , b_$5 : Set (T)  :: {Set#Union(a_$10,Set#Union(a_$10,b_$5))} ( Set#Union(a_$10,Set#Union(a_$10,b_$5)) == Set#Union(a_$10,b_$5) ));
	assume (forall<T> a_$11 : Set (T) , b_$6 : Set (T)  :: {Set#Intersection(Set#Intersection(a_$11,b_$6),b_$6)} ( Set#Intersection(Set#Intersection(a_$11,b_$6),b_$6) == Set#Intersection(a_$11,b_$6) ));
	assume (forall<T> a_$12 : Set (T) , b_$7 : Set (T)  :: {Set#Intersection(a_$12,Set#Intersection(a_$12,b_$7))} ( Set#Intersection(a_$12,Set#Intersection(a_$12,b_$7)) == Set#Intersection(a_$12,b_$7) ));
	assume (forall<T> a_$13 : Set (T) , b_$8 : Set (T)  :: {Set#Card(Set#Union(a_$13,b_$8))} {Set#Card(Set#Intersection(a_$13,b_$8))} ( (Set#Card(Set#Union(a_$13,b_$8)) + Set#Card(Set#Intersection(a_$13,b_$8))) == (Set#Card(a_$13) + Set#Card(b_$8)) ));
	assume (forall<T> a_$14 : Set (T) , b_$9 : Set (T) , o_$4 : T :: {Set#Difference(a_$14,b_$9)[o_$4]} ( Set#Difference(a_$14,b_$9)[o_$4] <==> (a_$14[o_$4] && (!b_$9[o_$4])) ));
	assume (forall<T> a_$15 : Set (T) , b_$10 : Set (T) , y_$2 : T :: {Set#Difference(a_$15,b_$10),b_$10[y_$2]} ( b_$10[y_$2] ==> (!Set#Difference(a_$15,b_$10)[y_$2]) ));
	assume (forall<T> a_$16 : Set (T) , b_$11 : Set (T)  :: {Set#Card(Set#Difference(a_$16,b_$11))} ( (((Set#Card(Set#Difference(a_$16,b_$11)) + Set#Card(Set#Difference(b_$11,a_$16))) + Set#Card(Set#Intersection(a_$16,b_$11))) == Set#Card(Set#Union(a_$16,b_$11))) && (Set#Card(Set#Difference(a_$16,b_$11)) == (Set#Card(a_$16) - Set#Card(Set#Intersection(a_$16,b_$11)))) ));
	assume (forall<T> a_$17 : Set (T) , b_$12 : Set (T)  :: {Set#Subset(a_$17,b_$12)} ( Set#Subset(a_$17,b_$12) <==> ((forall  o_$5 : T :: {a_$17[o_$5]} {b_$12[o_$5]} ( a_$17[o_$5] ==> b_$12[o_$5] ))) ));
	assume (forall<T> a_$18 : Set (T) , b_$13 : Set (T)  :: {Set#Equal(a_$18,b_$13)} ( Set#Equal(a_$18,b_$13) <==> ((forall  o_$6 : T :: {a_$18[o_$6]} {b_$13[o_$6]} ( a_$18[o_$6] <==> b_$13[o_$6] ))) ));
	assume (forall<T> a_$19 : Set (T) , b_$14 : Set (T)  :: {Set#Equal(a_$19,b_$14)} ( Set#Equal(a_$19,b_$14) ==> (a_$19 == b_$14) ));
	assume (forall<T> a_$20 : Set (T) , b_$15 : Set (T)  :: {Set#Disjoint(a_$20,b_$15)} ( Set#Disjoint(a_$20,b_$15) <==> ((forall  o_$7 : T :: {a_$20[o_$7]} {b_$15[o_$7]} ( (!a_$20[o_$7]) || (!b_$15[o_$7]) ))) ));
	assume (forall  a_$21 : Integer, b_$16 : Integer :: {Math#min(a_$21,b_$16)} ( (a_$21 <= b_$16) <==> (Math#min(a_$21,b_$16) == a_$21) ));
	assume (forall  a_$22 : Integer, b_$17 : Integer :: {Math#min(a_$22,b_$17)} ( (b_$17 <= a_$22) <==> (Math#min(a_$22,b_$17) == b_$17) ));
	assume (forall  a_$23 : Integer, b_$18 : Integer :: {Math#min(a_$23,b_$18)} ( (Math#min(a_$23,b_$18) == a_$23) || (Math#min(a_$23,b_$18) == b_$18) ));
	assume (forall  a_$24 : Integer :: {Math#clip(a_$24)} ( (0 <= a_$24) ==> (Math#clip(a_$24) == a_$24) ));
	assume (forall  a_$25 : Integer :: {Math#clip(a_$25)} ( (a_$25 < 0) ==> (Math#clip(a_$25) == 0) ));
	assume (forall<T> ms : MultiSet (T)  :: {$IsGoodMultiSet(ms)} ( $IsGoodMultiSet(ms) <==> ((forall  bx : T :: {ms[bx]} ( 0 <= ms[bx] ))) ));
	assume (forall<T> s_$1 : MultiSet (T)  :: {MultiSet#Card(s_$1)} ( 0 <= MultiSet#Card(s_$1) ));
	assume (forall<T> s_$2 : MultiSet (T) , x_$7 : T, n : Integer :: {MultiSet#Card(s_$2[x_$7 := n])} ( (0 <= n) ==> (MultiSet#Card(s_$2[x_$7 := n]) == ((MultiSet#Card(s_$2) - s_$2[x_$7]) + n)) ));
	assume (forall<T> o_$8 : T :: {(MultiSet#Empty() : MultiSet (T) )[o_$8]} ( (MultiSet#Empty() : MultiSet (T) )[o_$8] == 0 ));
	assume (forall<T> s_$3 : MultiSet (T)  :: {MultiSet#Card(s_$3)} ( ((MultiSet#Card(s_$3) == 0) <==> (s_$3 == (MultiSet#Empty() : MultiSet (T) ))) && ((!(MultiSet#Card(s_$3) == 0)) ==> ((exists  x_$8 : T :: ( 0 < s_$3[x_$8] )))) ));
	assume (forall<T> r_$4 : T, o_$9 : T :: {MultiSet#Singleton(r_$4)[o_$9]} ( ((MultiSet#Singleton(r_$4)[o_$9] == 1) <==> (r_$4 == o_$9)) && ((MultiSet#Singleton(r_$4)[o_$9] == 0) <==> (!(r_$4 == o_$9))) ));
	assume (forall<T> r_$5 : T :: {MultiSet#Singleton(r_$5)} ( MultiSet#Singleton(r_$5) == MultiSet#UnionOne((MultiSet#Empty() : MultiSet (T) ),r_$5) ));
	assume (forall<T> a_$26 : MultiSet (T) , x_$9 : T, o_$10 : T :: {MultiSet#UnionOne(a_$26,x_$9)[o_$10]} ( (0 < MultiSet#UnionOne(a_$26,x_$9)[o_$10]) <==> ((o_$10 == x_$9) || (0 < a_$26[o_$10])) ));
	assume (forall<T> a_$27 : MultiSet (T) , x_$10 : T :: {MultiSet#UnionOne(a_$27,x_$10)} ( MultiSet#UnionOne(a_$27,x_$10)[x_$10] == (a_$27[x_$10] + 1) ));
	assume (forall<T> a_$28 : MultiSet (T) , x_$11 : T, y_$3 : T :: {MultiSet#UnionOne(a_$28,x_$11),a_$28[y_$3]} ( (0 < a_$28[y_$3]) ==> (0 < MultiSet#UnionOne(a_$28,x_$11)[y_$3]) ));
	assume (forall<T> a_$29 : MultiSet (T) , x_$12 : T, y_$4 : T :: {MultiSet#UnionOne(a_$29,x_$12),a_$29[y_$4]} ( (!(x_$12 == y_$4)) ==> (a_$29[y_$4] == MultiSet#UnionOne(a_$29,x_$12)[y_$4]) ));
	assume (forall<T> a_$30 : MultiSet (T) , x_$13 : T :: {MultiSet#Card(MultiSet#UnionOne(a_$30,x_$13))} ( MultiSet#Card(MultiSet#UnionOne(a_$30,x_$13)) == (MultiSet#Card(a_$30) + 1) ));
	assume (forall<T> a_$31 : MultiSet (T) , b_$19 : MultiSet (T) , o_$11 : T :: {MultiSet#Union(a_$31,b_$19)[o_$11]} ( MultiSet#Union(a_$31,b_$19)[o_$11] == (a_$31[o_$11] + b_$19[o_$11]) ));
	assume (forall<T> a_$32 : MultiSet (T) , b_$20 : MultiSet (T)  :: {MultiSet#Card(MultiSet#Union(a_$32,b_$20))} ( MultiSet#Card(MultiSet#Union(a_$32,b_$20)) == (MultiSet#Card(a_$32) + MultiSet#Card(b_$20)) ));
	assume (forall<T> a_$33 : MultiSet (T) , b_$21 : MultiSet (T) , o_$12 : T :: {MultiSet#Intersection(a_$33,b_$21)[o_$12]} ( MultiSet#Intersection(a_$33,b_$21)[o_$12] == Math#min(a_$33[o_$12],b_$21[o_$12]) ));
	assume (forall<T> a_$34 : MultiSet (T) , b_$22 : MultiSet (T)  :: {MultiSet#Intersection(MultiSet#Intersection(a_$34,b_$22),b_$22)} ( MultiSet#Intersection(MultiSet#Intersection(a_$34,b_$22),b_$22) == MultiSet#Intersection(a_$34,b_$22) ));
	assume (forall<T> a_$35 : MultiSet (T) , b_$23 : MultiSet (T)  :: {MultiSet#Intersection(a_$35,MultiSet#Intersection(a_$35,b_$23))} ( MultiSet#Intersection(a_$35,MultiSet#Intersection(a_$35,b_$23)) == MultiSet#Intersection(a_$35,b_$23) ));
	assume (forall<T> a_$36 : MultiSet (T) , b_$24 : MultiSet (T) , o_$13 : T :: {MultiSet#Difference(a_$36,b_$24)[o_$13]} ( MultiSet#Difference(a_$36,b_$24)[o_$13] == Math#clip(a_$36[o_$13] - b_$24[o_$13]) ));
	assume (forall<T> a_$37 : MultiSet (T) , b_$25 : MultiSet (T) , y_$5 : T :: {MultiSet#Difference(a_$37,b_$25),b_$25[y_$5],a_$37[y_$5]} ( (a_$37[y_$5] <= b_$25[y_$5]) ==> (MultiSet#Difference(a_$37,b_$25)[y_$5] == 0) ));
	assume (forall<T> a_$38 : MultiSet (T) , b_$26 : MultiSet (T)  :: {MultiSet#Card(MultiSet#Difference(a_$38,b_$26))} ( (((MultiSet#Card(MultiSet#Difference(a_$38,b_$26)) + MultiSet#Card(MultiSet#Difference(b_$26,a_$38))) + (2 * MultiSet#Card(MultiSet#Intersection(a_$38,b_$26)))) == MultiSet#Card(MultiSet#Union(a_$38,b_$26))) && (MultiSet#Card(MultiSet#Difference(a_$38,b_$26)) == (MultiSet#Card(a_$38) - MultiSet#Card(MultiSet#Intersection(a_$38,b_$26)))) ));
	assume (forall<T> a_$39 : MultiSet (T) , b_$27 : MultiSet (T)  :: {MultiSet#Subset(a_$39,b_$27)} ( MultiSet#Subset(a_$39,b_$27) <==> ((forall  o_$14 : T :: {a_$39[o_$14]} {b_$27[o_$14]} ( a_$39[o_$14] <= b_$27[o_$14] ))) ));
	assume (forall<T> a_$40 : MultiSet (T) , b_$28 : MultiSet (T)  :: {MultiSet#Equal(a_$40,b_$28)} ( MultiSet#Equal(a_$40,b_$28) <==> ((forall  o_$15 : T :: {a_$40[o_$15]} {b_$28[o_$15]} ( a_$40[o_$15] == b_$28[o_$15] ))) ));
	assume (forall<T> a_$41 : MultiSet (T) , b_$29 : MultiSet (T)  :: {MultiSet#Equal(a_$41,b_$29)} ( MultiSet#Equal(a_$41,b_$29) ==> (a_$41 == b_$29) ));
	assume (forall<T> a_$42 : MultiSet (T) , b_$30 : MultiSet (T)  :: {MultiSet#Disjoint(a_$42,b_$30)} ( MultiSet#Disjoint(a_$42,b_$30) <==> ((forall  o_$16 : T :: {a_$42[o_$16]} {b_$30[o_$16]} ( (a_$42[o_$16] == 0) || (b_$30[o_$16] == 0) ))) ));
	assume (forall<T> s_$4 : Set (T) , a_$43 : T :: {MultiSet#FromSet(s_$4)[a_$43]} ( ((MultiSet#FromSet(s_$4)[a_$43] == 0) <==> (!s_$4[a_$43])) && ((MultiSet#FromSet(s_$4)[a_$43] == 1) <==> s_$4[a_$43]) ));
	assume (forall<T> s_$5 : Set (T)  :: {MultiSet#Card(MultiSet#FromSet(s_$5))} ( MultiSet#Card(MultiSet#FromSet(s_$5)) == Set#Card(s_$5) ));
	assume (forall<T> s_$6 : Seq (T)  :: {MultiSet#FromSeq(s_$6)} ( $IsGoodMultiSet(MultiSet#FromSeq(s_$6)) ));
	assume (forall<T> s_$7 : Seq (T) , v_$0 : T :: {MultiSet#FromSeq(Seq#Build(s_$7,v_$0))} ( MultiSet#FromSeq(Seq#Build(s_$7,v_$0)) == MultiSet#UnionOne(MultiSet#FromSeq(s_$7),v_$0) ));
	assume (forall<T> :: MultiSet#FromSeq((Seq#Empty() : Seq (T) )) == (MultiSet#Empty() : MultiSet (T) ));
	assume (forall<T> a_$44 : Seq (T) , b_$31 : Seq (T)  :: {MultiSet#FromSeq(Seq#Append(a_$44,b_$31))} ( MultiSet#FromSeq(Seq#Append(a_$44,b_$31)) == MultiSet#Union(MultiSet#FromSeq(a_$44),MultiSet#FromSeq(b_$31)) ));
	assume (forall<T> s_$8 : Seq (T) , i : Integer, v_$1 : T, x_$14 : T :: {MultiSet#FromSeq(Seq#Update(s_$8,i,v_$1))[x_$14]} ( ((0 <= i) && (i < Seq#Length(s_$8))) ==> (MultiSet#FromSeq(Seq#Update(s_$8,i,v_$1))[x_$14] == MultiSet#Union(MultiSet#Difference(MultiSet#FromSeq(s_$8),MultiSet#Singleton(Seq#Index(s_$8,i))),MultiSet#Singleton(v_$1))[x_$14]) ));
	assume (forall<T> s_$9 : Seq (T) , x_$15 : T :: {MultiSet#FromSeq(s_$9)[x_$15]} ( ((exists  i_$0 : Integer :: {Seq#Index(s_$9,i_$0)} ( ((0 <= i_$0) && (i_$0 < Seq#Length(s_$9))) && (x_$15 == Seq#Index(s_$9,i_$0)) ))) <==> (0 < MultiSet#FromSeq(s_$9)[x_$15]) ));
	assume (forall<T> s_$10 : Seq (T)  :: {Seq#Length(s_$10)} ( 0 <= Seq#Length(s_$10) ));
	assume (forall<T> :: Seq#Length((Seq#Empty() : Seq (T) )) == 0);
	assume (forall<T> s_$11 : Seq (T)  :: {Seq#Length(s_$11)} ( (Seq#Length(s_$11) == 0) ==> (s_$11 == (Seq#Empty() : Seq (T) )) ));
	assume (forall<T> t : T :: {Seq#Length(Seq#Singleton(t))} ( Seq#Length(Seq#Singleton(t)) == 1 ));
	assume (forall<T> s_$12 : Seq (T) , v_$2 : T :: {Seq#Length(Seq#Build(s_$12,v_$2))} ( Seq#Length(Seq#Build(s_$12,v_$2)) == (1 + Seq#Length(s_$12)) ));
	assume (forall<T> s_$13 : Seq (T) , i_$1 : Integer, v_$3 : T :: {Seq#Index(Seq#Build(s_$13,v_$3),i_$1)} ( ((i_$1 == Seq#Length(s_$13)) ==> (Seq#Index(Seq#Build(s_$13,v_$3),i_$1) == v_$3)) && ((!(i_$1 == Seq#Length(s_$13))) ==> (Seq#Index(Seq#Build(s_$13,v_$3),i_$1) == Seq#Index(s_$13,i_$1))) ));
	assume (forall<T> s0 : Seq (T) , s1 : Seq (T)  :: {Seq#Length(Seq#Append(s0,s1))} ( Seq#Length(Seq#Append(s0,s1)) == (Seq#Length(s0) + Seq#Length(s1)) ));
	assume (forall<T> t_$0 : T :: {Seq#Index(Seq#Singleton(t_$0),0)} ( Seq#Index(Seq#Singleton(t_$0),0) == t_$0 ));
	assume (forall<T> s0_$0 : Seq (T) , s1_$0 : Seq (T) , n_$0 : Integer :: {Seq#Index(Seq#Append(s0_$0,s1_$0),n_$0)} ( ((n_$0 < Seq#Length(s0_$0)) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$0) == Seq#Index(s0_$0,n_$0))) && ((Seq#Length(s0_$0) <= n_$0) ==> (Seq#Index(Seq#Append(s0_$0,s1_$0),n_$0) == Seq#Index(s1_$0,n_$0 - Seq#Length(s0_$0)))) ));
	assume (forall<T> s_$14 : Seq (T) , i_$2 : Integer, v_$4 : T :: {Seq#Length(Seq#Update(s_$14,i_$2,v_$4))} ( ((0 <= i_$2) && (i_$2 < Seq#Length(s_$14))) ==> (Seq#Length(Seq#Update(s_$14,i_$2,v_$4)) == Seq#Length(s_$14)) ));
	assume (forall<T> s_$15 : Seq (T) , i_$3 : Integer, v_$5 : T, n_$1 : Integer :: {Seq#Index(Seq#Update(s_$15,i_$3,v_$5),n_$1)} ( ((0 <= n_$1) && (n_$1 < Seq#Length(s_$15))) ==> (((i_$3 == n_$1) ==> (Seq#Index(Seq#Update(s_$15,i_$3,v_$5),n_$1) == v_$5)) && ((!(i_$3 == n_$1)) ==> (Seq#Index(Seq#Update(s_$15,i_$3,v_$5),n_$1) == Seq#Index(s_$15,n_$1)))) ));
	assume (forall<T> s_$16 : Seq (T) , x_$16 : T :: {Seq#Contains(s_$16,x_$16)} ( Seq#Contains(s_$16,x_$16) <==> ((exists  i_$4 : Integer :: {Seq#Index(s_$16,i_$4)} ( ((0 <= i_$4) && (i_$4 < Seq#Length(s_$16))) && (Seq#Index(s_$16,i_$4) == x_$16) ))) ));
	assume (forall  x_$17 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$17)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$17) ));
	assume (forall<T> s0_$1 : Seq (T) , s1_$1 : Seq (T) , x_$18 : T :: {Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$18)} ( Seq#Contains(Seq#Append(s0_$1,s1_$1),x_$18) <==> (Seq#Contains(s0_$1,x_$18) || Seq#Contains(s1_$1,x_$18)) ));
	assume (forall<T> s_$17 : Seq (T) , v_$6 : T, x_$19 : T :: {Seq#Contains(Seq#Build(s_$17,v_$6),x_$19)} ( Seq#Contains(Seq#Build(s_$17,v_$6),x_$19) <==> ((v_$6 == x_$19) || Seq#Contains(s_$17,x_$19)) ));
	assume (forall<T> s_$18 : Seq (T) , n_$2 : Integer, x_$20 : T :: {Seq#Contains(Seq#Take(s_$18,n_$2),x_$20)} ( Seq#Contains(Seq#Take(s_$18,n_$2),x_$20) <==> ((exists  i_$5 : Integer :: {Seq#Index(s_$18,i_$5)} ( (((0 <= i_$5) && (i_$5 < n_$2)) && (i_$5 < Seq#Length(s_$18))) && (Seq#Index(s_$18,i_$5) == x_$20) ))) ));
	assume (forall<T> s_$19 : Seq (T) , n_$3 : Integer, x_$21 : T :: {Seq#Contains(Seq#Drop(s_$19,n_$3),x_$21)} ( Seq#Contains(Seq#Drop(s_$19,n_$3),x_$21) <==> ((exists  i_$6 : Integer :: {Seq#Index(s_$19,i_$6)} ( (((0 <= n_$3) && (n_$3 <= i_$6)) && (i_$6 < Seq#Length(s_$19))) && (Seq#Index(s_$19,i_$6) == x_$21) ))) ));
	assume (forall<T> s0_$2 : Seq (T) , s1_$2 : Seq (T)  :: {Seq#Equal(s0_$2,s1_$2)} ( Seq#Equal(s0_$2,s1_$2) <==> ((Seq#Length(s0_$2) == Seq#Length(s1_$2)) && ((forall  j : Integer :: {Seq#Index(s0_$2,j)} {Seq#Index(s1_$2,j)} ( ((0 <= j) && (j < Seq#Length(s0_$2))) ==> (Seq#Index(s0_$2,j) == Seq#Index(s1_$2,j)) )))) ));
	assume (forall<T> a_$45 : Seq (T) , b_$32 : Seq (T)  :: {Seq#Equal(a_$45,b_$32)} ( Seq#Equal(a_$45,b_$32) ==> (a_$45 == b_$32) ));
	assume (forall<T> s0_$3 : Seq (T) , s1_$3 : Seq (T) , n_$4 : Integer :: {Seq#SameUntil(s0_$3,s1_$3,n_$4)} ( Seq#SameUntil(s0_$3,s1_$3,n_$4) <==> ((forall  j_$0 : Integer :: {Seq#Index(s0_$3,j_$0)} {Seq#Index(s1_$3,j_$0)} ( ((0 <= j_$0) && (j_$0 < n_$4)) ==> (Seq#Index(s0_$3,j_$0) == Seq#Index(s1_$3,j_$0)) ))) ));
	assume (forall<T> s_$20 : Seq (T) , n_$5 : Integer :: {Seq#Length(Seq#Take(s_$20,n_$5))} ( (0 <= n_$5) ==> (((n_$5 <= Seq#Length(s_$20)) ==> (Seq#Length(Seq#Take(s_$20,n_$5)) == n_$5)) && ((Seq#Length(s_$20) < n_$5) ==> (Seq#Length(Seq#Take(s_$20,n_$5)) == Seq#Length(s_$20)))) ));
	assume (forall<T> s_$21 : Seq (T) , n_$6 : Integer, j_$1 : Integer :: {Seq#Index(Seq#Take(s_$21,n_$6),j_$1)} {:weight  25}( (((0 <= j_$1) && (j_$1 < n_$6)) && (j_$1 < Seq#Length(s_$21))) ==> (Seq#Index(Seq#Take(s_$21,n_$6),j_$1) == Seq#Index(s_$21,j_$1)) ));
	assume (forall<T> s_$22 : Seq (T) , n_$7 : Integer :: {Seq#Length(Seq#Drop(s_$22,n_$7))} ( (0 <= n_$7) ==> (((n_$7 <= Seq#Length(s_$22)) ==> (Seq#Length(Seq#Drop(s_$22,n_$7)) == (Seq#Length(s_$22) - n_$7))) && ((Seq#Length(s_$22) < n_$7) ==> (Seq#Length(Seq#Drop(s_$22,n_$7)) == 0))) ));
	assume (forall<T> s_$23 : Seq (T) , n_$8 : Integer, j_$2 : Integer :: {Seq#Index(Seq#Drop(s_$23,n_$8),j_$2)} {:weight  25}( (((0 <= n_$8) && (0 <= j_$2)) && (j_$2 < (Seq#Length(s_$23) - n_$8))) ==> (Seq#Index(Seq#Drop(s_$23,n_$8),j_$2) == Seq#Index(s_$23,j_$2 + n_$8)) ));
	assume (forall<T> s_$24 : Seq (T) , t_$1 : Seq (T)  :: {Seq#Append(s_$24,t_$1)} ( (Seq#Take(Seq#Append(s_$24,t_$1),Seq#Length(s_$24)) == s_$24) && (Seq#Drop(Seq#Append(s_$24,t_$1),Seq#Length(s_$24)) == t_$1) ));
	assume (forall  h : HeapType, a_$46 : ref :: {Seq#Length(Seq#FromArray(h,a_$46))} ( Seq#Length(Seq#FromArray(h,a_$46)) == _System.array.Length(a_$46) ));
	assume (forall  h_$0 : HeapType, a_$47 : ref, i_$7 : Integer :: ( ((0 <= i_$7) && (i_$7 < Seq#Length(Seq#FromArray(h_$0,a_$47)))) ==> (Seq#Index(Seq#FromArray(h_$0,a_$47),i_$7) == read(h_$0,a_$47,IndexField(i_$7))) ));
	assume (forall<alpha> h_$1 : HeapType, o_$17 : ref, f_$1 : Field (alpha) , v_$7 : alpha, a_$48 : ref :: {Seq#FromArray(update(h_$1,o_$17,f_$1,v_$7),a_$48)} ( (!(o_$17 == a_$48)) ==> (Seq#FromArray(update(h_$1,o_$17,f_$1,v_$7),a_$48) == Seq#FromArray(h_$1,a_$48)) ));
	assume (forall  h_$2 : HeapType, i_$8 : Integer, v_$8 : BoxType, a_$49 : ref :: {Seq#FromArray(update(h_$2,a_$49,IndexField(i_$8),v_$8),a_$49)} ( ((0 <= i_$8) && (i_$8 < _System.array.Length(a_$49))) ==> (Seq#FromArray(update(h_$2,a_$49,IndexField(i_$8),v_$8),a_$49) == Seq#Update(Seq#FromArray(h_$2,a_$49),i_$8,v_$8)) ));
	assume (forall<T> s_$25 : Seq (T) , i_$9 : Integer, v_$9 : T, n_$9 : Integer :: {Seq#Take(Seq#Update(s_$25,i_$9,v_$9),n_$9)} ( (((0 <= i_$9) && (i_$9 < n_$9)) && (n_$9 <= Seq#Length(s_$25))) ==> (Seq#Take(Seq#Update(s_$25,i_$9,v_$9),n_$9) == Seq#Update(Seq#Take(s_$25,n_$9),i_$9,v_$9)) ));
	assume (forall<T> s_$26 : Seq (T) , i_$10 : Integer, v_$10 : T, n_$10 : Integer :: {Seq#Take(Seq#Update(s_$26,i_$10,v_$10),n_$10)} ( ((n_$10 <= i_$10) && (i_$10 < Seq#Length(s_$26))) ==> (Seq#Take(Seq#Update(s_$26,i_$10,v_$10),n_$10) == Seq#Take(s_$26,n_$10)) ));
	assume (forall<T> s_$27 : Seq (T) , i_$11 : Integer, v_$11 : T, n_$11 : Integer :: {Seq#Drop(Seq#Update(s_$27,i_$11,v_$11),n_$11)} ( (((0 <= n_$11) && (n_$11 <= i_$11)) && (i_$11 < Seq#Length(s_$27))) ==> (Seq#Drop(Seq#Update(s_$27,i_$11,v_$11),n_$11) == Seq#Update(Seq#Drop(s_$27,n_$11),i_$11 - n_$11,v_$11)) ));
	assume (forall<T> s_$28 : Seq (T) , i_$12 : Integer, v_$12 : T, n_$12 : Integer :: {Seq#Drop(Seq#Update(s_$28,i_$12,v_$12),n_$12)} ( (((0 <= i_$12) && (i_$12 < n_$12)) && (n_$12 < Seq#Length(s_$28))) ==> (Seq#Drop(Seq#Update(s_$28,i_$12,v_$12),n_$12) == Seq#Drop(s_$28,n_$12)) ));
	assume (forall  h_$3 : HeapType, a_$50 : ref, n0 : Integer, n1 : Integer :: {Seq#Take(Seq#FromArray(h_$3,a_$50),n0),Seq#Take(Seq#FromArray(h_$3,a_$50),n1)} ( ((((n0 + 1) == n1) && (0 <= n0)) && (n1 <= _System.array.Length(a_$50))) ==> (Seq#Take(Seq#FromArray(h_$3,a_$50),n1) == Seq#Build(Seq#Take(Seq#FromArray(h_$3,a_$50),n0),read(h_$3,a_$50,IndexField(n0)))) ));
	assume (forall<T> s_$29 : Seq (T) , v_$13 : T, n_$13 : Integer :: {Seq#Drop(Seq#Build(s_$29,v_$13),n_$13)} ( ((0 <= n_$13) && (n_$13 <= Seq#Length(s_$29))) ==> (Seq#Drop(Seq#Build(s_$29,v_$13),n_$13) == Seq#Build(Seq#Drop(s_$29,n_$13),v_$13)) ));
	assume (forall  s_$30 : Seq (BoxType) , i_$13 : Integer :: {DtRank(($Unbox(Seq#Index(s_$30,i_$13)) : DatatypeType))} ( ((0 <= i_$13) && (i_$13 < Seq#Length(s_$30))) ==> (DtRank(($Unbox(Seq#Index(s_$30,i_$13)) : DatatypeType)) < Seq#Rank(s_$30)) ));
	assume (forall<T> s_$31 : Seq (T) , i_$14 : Integer :: {Seq#Rank(Seq#Drop(s_$31,i_$14))} ( ((0 < i_$14) && (i_$14 <= Seq#Length(s_$31))) ==> (Seq#Rank(Seq#Drop(s_$31,i_$14)) < Seq#Rank(s_$31)) ));
	assume (forall<T> s_$32 : Seq (T) , i_$15 : Integer :: {Seq#Rank(Seq#Take(s_$32,i_$15))} ( ((0 <= i_$15) && (i_$15 < Seq#Length(s_$32))) ==> (Seq#Rank(Seq#Take(s_$32,i_$15)) < Seq#Rank(s_$32)) ));
	assume (forall<T> s_$33 : Seq (T) , i_$16 : Integer, j_$3 : Integer :: {Seq#Rank(Seq#Append(Seq#Take(s_$33,i_$16),Seq#Drop(s_$33,j_$3)))} ( (((0 <= i_$16) && (i_$16 < j_$3)) && (j_$3 <= Seq#Length(s_$33))) ==> (Seq#Rank(Seq#Append(Seq#Take(s_$33,i_$16),Seq#Drop(s_$33,j_$3))) < Seq#Rank(s_$33)) ));
	assume Seq#Take((Seq#Empty() : Seq (BoxType) ),0) == (Seq#Empty() : Seq (BoxType) );
	assume Seq#Drop((Seq#Empty() : Seq (BoxType) ),0) == (Seq#Empty() : Seq (BoxType) );
	assume (forall<U,V> m : Map (U) (V)  :: {Map#Card(m)} ( 0 <= Map#Card(m) ));
	assume (forall<U,V> u : U :: {Map#Domain((Map#Empty() : Map (U) (V) ))[u]} ( !Map#Domain((Map#Empty() : Map (U) (V) ))[u] ));
	assume (forall<U,V> m_$0 : Map (U) (V)  :: {Map#Card(m_$0)} ( (Map#Card(m_$0) == 0) <==> (m_$0 == (Map#Empty() : Map (U) (V) )) ));
	assume (forall<U,V> a_$51 : [U]Boolean, b_$33 : [U]V :: {Map#Domain(Map#Glue(a_$51,b_$33))} ( Map#Domain(Map#Glue(a_$51,b_$33)) == a_$51 ));
	assume (forall<U,V> a_$52 : [U]Boolean, b_$34 : [U]V :: {Map#Elements(Map#Glue(a_$52,b_$34))} ( Map#Elements(Map#Glue(a_$52,b_$34)) == b_$34 ));
	assume (forall<U,V> m_$1 : Map (U) (V) , u_$0 : U, u' : U, v_$14 : V :: {Map#Domain(Map#Build(m_$1,u_$0,v_$14))[u']} {Map#Elements(Map#Build(m_$1,u_$0,v_$14))[u']} ( ((u' == u_$0) ==> (Map#Domain(Map#Build(m_$1,u_$0,v_$14))[u'] && (Map#Elements(Map#Build(m_$1,u_$0,v_$14))[u'] == v_$14))) && ((!(u' == u_$0)) ==> ((Map#Domain(Map#Build(m_$1,u_$0,v_$14))[u'] <==> Map#Domain(m_$1)[u']) && (Map#Elements(Map#Build(m_$1,u_$0,v_$14))[u'] == Map#Elements(m_$1)[u']))) ));
	assume (forall<U,V> m_$2 : Map (U) (V) , u_$1 : U, v_$15 : V :: {Map#Card(Map#Build(m_$2,u_$1,v_$15))} ( Map#Domain(m_$2)[u_$1] ==> (Map#Card(Map#Build(m_$2,u_$1,v_$15)) == Map#Card(m_$2)) ));
	assume (forall<U,V> m_$3 : Map (U) (V) , u_$2 : U, v_$16 : V :: {Map#Card(Map#Build(m_$3,u_$2,v_$16))} ( (!Map#Domain(m_$3)[u_$2]) ==> (Map#Card(Map#Build(m_$3,u_$2,v_$16)) == (Map#Card(m_$3) + 1)) ));
	assume (forall<U,V> m_$4 : Map (U) (V) , m' : Map (U) (V)  :: {Map#Equal(m_$4,m')} ( Map#Equal(m_$4,m') <==> (((forall  u_$3 : U :: ( Map#Domain(m_$4)[u_$3] <==> Map#Domain(m')[u_$3] ))) && ((forall  u_$4 : U :: ( Map#Domain(m_$4)[u_$4] ==> (Map#Elements(m_$4)[u_$4] == Map#Elements(m')[u_$4]) )))) ));
	assume (forall<U,V> m_$5 : Map (U) (V) , m'_$0 : Map (U) (V)  :: {Map#Equal(m_$5,m'_$0)} ( Map#Equal(m_$5,m'_$0) ==> (m_$5 == m'_$0) ));
	assume (forall<U,V> m_$6 : Map (U) (V) , m'_$1 : Map (U) (V)  :: {Map#Disjoint(m_$6,m'_$1)} ( Map#Disjoint(m_$6,m'_$1) <==> ((forall  o_$18 : U :: {Map#Domain(m_$6)[o_$18]} {Map#Domain(m'_$1)[o_$18]} ( (!Map#Domain(m_$6)[o_$18]) || (!Map#Domain(m'_$1)[o_$18]) ))) ));
	assume (forall<T> x_$22 : T :: {$Box(x_$22)} ( ($Unbox($Box(x_$22)) : T) == x_$22 ));
	assume (forall  b_$35 : BoxType :: {($Unbox(b_$35) : Integer)} ( $Box(($Unbox(b_$35) : Integer)) == b_$35 ));
	assume (forall  b_$36 : BoxType :: {($Unbox(b_$36) : ref)} ( $Box(($Unbox(b_$36) : ref)) == b_$36 ));
	assume (forall  b_$37 : BoxType :: {($Unbox(b_$37) : [BoxType]Boolean)} ( $Box(($Unbox(b_$37) : [BoxType]Boolean)) == b_$37 ));
	assume (forall  b_$38 : BoxType :: {($Unbox(b_$38) : Seq (BoxType) )} ( $Box(($Unbox(b_$38) : Seq (BoxType) )) == b_$38 ));
	assume (forall  b_$39 : BoxType :: {($Unbox(b_$39) : Map (BoxType) (BoxType) )} ( $Box(($Unbox(b_$39) : Map (BoxType) (BoxType) )) == b_$39 ));
	assume (forall  b_$40 : BoxType :: {($Unbox(b_$40) : DatatypeType)} ( $Box(($Unbox(b_$40) : DatatypeType)) == b_$40 ));
	assume $IsCanonicalBoolBox($Box(false)) && $IsCanonicalBoolBox($Box(true));
	assume (forall  b_$41 : BoxType :: {($Unbox(b_$41) : Boolean)} ( $IsCanonicalBoolBox(b_$41) ==> ($Box(($Unbox(b_$41) : Boolean)) == b_$41) ));
	assume (forall<T> ss : Set (BoxType) , dummy : T, bx_$0 : BoxType :: {$IsGoodSet_Extended(ss,dummy),ss[bx_$0]} ( $IsGoodSet_Extended(ss,dummy) ==> (ss[bx_$0] ==> (bx_$0 == $Box(($Unbox(bx_$0) : T)))) ));
	assume (forall<T> ms_$0 : MultiSet (BoxType) , dummy_$0 : T, bx_$1 : BoxType :: {$IsGoodMultiSet_Extended(ms_$0,dummy_$0),ms_$0[bx_$1]} ( $IsGoodMultiSet_Extended(ms_$0,dummy_$0) ==> ((0 < ms_$0[bx_$1]) ==> (bx_$1 == $Box(($Unbox(bx_$1) : T)))) ));
	assume (forall  a_$53 : ClassName, b_$42 : ClassName :: {TypeTuple(a_$53,b_$42)} ( (TypeTupleCar(TypeTuple(a_$53,b_$42)) == a_$53) && (TypeTupleCdr(TypeTuple(a_$53,b_$42)) == b_$42) ));
	assume (forall  i_$17 : Integer :: {IndexField(i_$17)} ( FDim(IndexField(i_$17)) == 1 ));
	assume (forall  i_$18 : Integer :: {IndexField(i_$18)} ( IndexField_Inverse(IndexField(i_$18)) == i_$18 ));
	assume (forall  f_$2 : Field (BoxType) , i_$19 : Integer :: {MultiIndexField(f_$2,i_$19)} ( FDim(MultiIndexField(f_$2,i_$19)) == (FDim(f_$2) + 1) ));
	assume (forall  f_$3 : Field (BoxType) , i_$20 : Integer :: {MultiIndexField(f_$3,i_$20)} ( (MultiIndexField_Inverse0(MultiIndexField(f_$3,i_$20)) == f_$3) && (MultiIndexField_Inverse1(MultiIndexField(f_$3,i_$20)) == i_$20) ));
	assume (forall<T> cl : ClassName, nm : NameFamily :: {(FieldOfDecl(cl,nm) : Field (T) )} ( (DeclType((FieldOfDecl(cl,nm) : Field (T) )) == cl) && (DeclName((FieldOfDecl(cl,nm) : Field (T) )) == nm) ));
	assume (FDim(alloc) == 0) && (!$IsGhostField(alloc));
	assume (forall  h_$4 : HeapType, k : HeapType, d : DatatypeType :: {$HeapSucc(h_$4,k),DtAlloc(d,h_$4)} {$HeapSucc(h_$4,k),DtAlloc(d,k)} ( $HeapSucc(h_$4,k) ==> (DtAlloc(d,h_$4) ==> DtAlloc(d,k)) ));
	assume (forall  h_$5 : HeapType, k_$0 : HeapType, d_$0 : BoxType :: {$HeapSucc(h_$5,k_$0),GenericAlloc(d_$0,h_$5)} {$HeapSucc(h_$5,k_$0),GenericAlloc(d_$0,k_$0)} ( $HeapSucc(h_$5,k_$0) ==> (GenericAlloc(d_$0,h_$5) ==> GenericAlloc(d_$0,k_$0)) ));
	assume (forall  b_$43 : BoxType, h_$6 : HeapType :: {GenericAlloc(b_$43,h_$6),h_$6[($Unbox(b_$43) : ref),alloc]} ( GenericAlloc(b_$43,h_$6) ==> ((($Unbox(b_$43) : ref) == null) || h_$6[($Unbox(b_$43) : ref),alloc]) ));
	assume (forall  b_$44 : BoxType, h_$7 : HeapType, i_$21 : Integer :: {GenericAlloc(b_$44,h_$7),Seq#Index(($Unbox(b_$44) : Seq (BoxType) ),i_$21)} ( ((GenericAlloc(b_$44,h_$7) && (0 <= i_$21)) && (i_$21 < Seq#Length(($Unbox(b_$44) : Seq (BoxType) )))) ==> GenericAlloc(Seq#Index(($Unbox(b_$44) : Seq (BoxType) ),i_$21),h_$7) ));
	assume (forall  b_$45 : BoxType, h_$8 : HeapType, i_$22 : BoxType :: {GenericAlloc(b_$45,h_$8),Map#Domain(($Unbox(b_$45) : Map (BoxType) (BoxType) ))[i_$22]} ( (GenericAlloc(b_$45,h_$8) && Map#Domain(($Unbox(b_$45) : Map (BoxType) (BoxType) ))[i_$22]) ==> GenericAlloc(Map#Elements(($Unbox(b_$45) : Map (BoxType) (BoxType) ))[i_$22],h_$8) ));
	assume (forall  b_$46 : BoxType, h_$9 : HeapType, t_$2 : BoxType :: {GenericAlloc(b_$46,h_$9),Map#Domain(($Unbox(b_$46) : Map (BoxType) (BoxType) ))[t_$2]} ( (GenericAlloc(b_$46,h_$9) && Map#Domain(($Unbox(b_$46) : Map (BoxType) (BoxType) ))[t_$2]) ==> GenericAlloc(t_$2,h_$9) ));
	assume (forall  b_$47 : BoxType, h_$10 : HeapType, t_$3 : BoxType :: {GenericAlloc(b_$47,h_$10),($Unbox(b_$47) : [BoxType]Boolean)[t_$3]} ( (GenericAlloc(b_$47,h_$10) && ($Unbox(b_$47) : [BoxType]Boolean)[t_$3]) ==> GenericAlloc(t_$3,h_$10) ));
	assume (forall  b_$48 : BoxType, h_$11 : HeapType :: {GenericAlloc(b_$48,h_$11),DtType(($Unbox(b_$48) : DatatypeType))} ( GenericAlloc(b_$48,h_$11) ==> DtAlloc(($Unbox(b_$48) : DatatypeType),h_$11) ));
	assume (forall  b_$49 : Boolean, h_$12 : HeapType :: ( $IsGoodHeap(h_$12) ==> GenericAlloc($Box(b_$49),h_$12) ));
	assume (forall  x_$23 : Integer, h_$13 : HeapType :: ( $IsGoodHeap(h_$13) ==> GenericAlloc($Box(x_$23),h_$13) ));
	assume (forall  r_$6 : ref, h_$14 : HeapType :: {GenericAlloc($Box(r_$6),h_$14)} ( ($IsGoodHeap(h_$14) && ((r_$6 == null) || h_$14[r_$6,alloc])) ==> GenericAlloc($Box(r_$6),h_$14) ));
	assume (forall  r_$7 : ref, f_$4 : Field (BoxType) , h_$15 : HeapType :: {GenericAlloc(read(h_$15,r_$7,f_$4),h_$15)} ( (($IsGoodHeap(h_$15) && (!(r_$7 == null))) && read(h_$15,r_$7,alloc)) ==> GenericAlloc(read(h_$15,r_$7,f_$4),h_$15) ));
	assume (forall  o_$19 : ref :: ( 0 <= _System.array.Length(o_$19) ));
	assume (forall<alpha> f : Field (alpha) , r : ref, H : HeapType :: ( read(H,r,f) == H[r,f] ));
	assume (forall<alpha> v : alpha, f_$0 : Field (alpha) , r_$0 : ref, H_$0 : HeapType :: ( update(H_$0,r_$0,f_$0,v) == H_$0[r_$0,f_$0 := v] ));
	assume (forall<alpha> h_$16 : HeapType, r_$8 : ref, f_$5 : Field (alpha) , x_$24 : alpha :: {update(h_$16,r_$8,f_$5,x_$24)} ( $IsGoodHeap(update(h_$16,r_$8,f_$5,x_$24)) ==> $HeapSucc(h_$16,update(h_$16,r_$8,f_$5,x_$24)) ));
	assume (forall  a_$54 : HeapType, b_$50 : HeapType, c : HeapType :: {$HeapSucc(a_$54,b_$50),$HeapSucc(b_$50,c)} ( ($HeapSucc(a_$54,b_$50) && $HeapSucc(b_$50,c)) ==> $HeapSucc(a_$54,c) ));
	assume (forall  h_$17 : HeapType, k_$1 : HeapType :: {$HeapSucc(h_$17,k_$1)} ( $HeapSucc(h_$17,k_$1) ==> ((forall  o_$20 : ref :: {read(k_$1,o_$20,alloc)} ( read(h_$17,o_$20,alloc) ==> read(k_$1,o_$20,alloc) ))) ));
	assume (forall  h_$18 : HeapType, k_$2 : HeapType :: {$HeapSuccGhost(h_$18,k_$2)} ( $HeapSuccGhost(h_$18,k_$2) ==> ($HeapSucc(h_$18,k_$2) && ((forall<alpha> o_$21 : ref, f_$6 : Field (alpha)  :: {read(k_$2,o_$21,f_$6)} ( (!$IsGhostField(f_$6)) ==> (read(h_$18,o_$21,f_$6) == read(k_$2,o_$21,f_$6)) )))) ));
	assume ((FDim(_module.Node.next) == 0) && ((FieldOfDecl(class._module.Node,field$next) : Field (ref) ) == _module.Node.next)) && (!$IsGhostField(_module.Node.next));
	assume (forall  $h : HeapType, $o : ref :: {read($h,$o,_module.Node.next)} ( (($IsGoodHeap($h) && (!($o == null))) && read($h,$o,alloc)) ==> ((read($h,$o,_module.Node.next) == null) || (read($h,read($h,$o,_module.Node.next),alloc) && (dtype(read($h,$o,_module.Node.next)) == class._module.Node))) ));
	assume (forall  $h0 : HeapType, $h1 : HeapType, this_$0 : ref, S#0_$0 : Set (BoxType)  :: {$HeapSucc($h0,$h1),_module.Node.IsClosed($h1,this_$0,S#0_$0)} ( ((((((((($IsGoodHeap($h0) && $IsGoodHeap($h1)) && (!(this_$0 == null))) && read($h0,this_$0,alloc)) && (dtype(this_$0) == class._module.Node)) && read($h1,this_$0,alloc)) && (dtype(this_$0) == class._module.Node)) && (_module.Node.IsClosed#canCall($h0,this_$0,S#0_$0) || ((forall  $t#0 : BoxType :: {S#0_$0[$t#0]} ( S#0_$0[$t#0] ==> ((($Unbox($t#0) : ref) == null) || (read($h0,($Unbox($t#0) : ref),alloc) && (dtype(($Unbox($t#0) : ref)) == class._module.Node))) ))))) && (_module.Node.IsClosed#canCall($h1,this_$0,S#0_$0) || ((forall  $t#1 : BoxType :: {S#0_$0[$t#1]} ( S#0_$0[$t#1] ==> ((($Unbox($t#1) : ref) == null) || (read($h1,($Unbox($t#1) : ref),alloc) && (dtype(($Unbox($t#1) : ref)) == class._module.Node))) ))))) && $HeapSucc($h0,$h1)) ==> (((forall<alpha> $o_$0 : ref, $f : Field (alpha)  :: ( ((((!($o_$0 == null)) && read($h0,$o_$0,alloc)) && read($h1,$o_$0,alloc)) && S#0_$0[$Box($o_$0)]) ==> (read($h0,$o_$0,$f) == read($h1,$o_$0,$f)) ))) ==> (_module.Node.IsClosed($h0,this_$0,S#0_$0) <==> _module.Node.IsClosed($h1,this_$0,S#0_$0))) ));
	assume ((0 < $ModuleContextHeight) || ((0 == $ModuleContextHeight) && (0 <= $FunctionContextHeight))) ==> ((forall  $Heap_$0 : HeapType, this_$1 : ref, S#0_$1 : Set (BoxType)  :: {_module.Node.IsClosed($Heap_$0,this_$1,S#0_$1)} ( (_module.Node.IsClosed#canCall($Heap_$0,this_$1,S#0_$1) || (((((((!(0 == $ModuleContextHeight)) || (!(0 == $FunctionContextHeight))) && $IsGoodHeap($Heap_$0)) && (!(this_$1 == null))) && read($Heap_$0,this_$1,alloc)) && (dtype(this_$1) == class._module.Node)) && ((forall  $t#2 : BoxType :: {S#0_$1[$t#2]} ( S#0_$1[$t#2] ==> ((($Unbox($t#2) : ref) == null) || (read($Heap_$0,($Unbox($t#2) : ref),alloc) && (dtype(($Unbox($t#2) : ref)) == class._module.Node))) ))))) ==> true )));
	assume ((0 == $ModuleContextHeight) && (0 <= $FunctionContextHeight)) ==> ((forall  $Heap_$1 : HeapType, this_$2 : ref, S#0_$2 : Set (BoxType)  :: {_module.Node.IsClosed($Heap_$1,this_$2,S#0_$2)} ( (_module.Node.IsClosed#canCall($Heap_$1,this_$2,S#0_$2) || ((((((!(0 == $FunctionContextHeight)) && $IsGoodHeap($Heap_$1)) && (!(this_$2 == null))) && read($Heap_$1,this_$2,alloc)) && (dtype(this_$2) == class._module.Node)) && ((forall  $t#3 : BoxType :: {S#0_$2[$t#3]} ( S#0_$2[$t#3] ==> ((($Unbox($t#3) : ref) == null) || (read($Heap_$1,($Unbox($t#3) : ref),alloc) && (dtype(($Unbox($t#3) : ref)) == class._module.Node))) ))))) ==> (((S#0_$2[$Box(this_$2)] ==> true) && ((S#0_$2[$Box(this_$2)] && S#0_$2[$Box(null)]) ==> ((forall  n#1 : ref :: ( ((n#1 == null) || (read($Heap_$1,n#1,alloc) && (dtype(n#1) == class._module.Node))) ==> (((S#0_$2[$Box(n#1)] ==> true) && ((S#0_$2[$Box(n#1)] && (!(n#1 == null))) ==> true)) && (((S#0_$2[$Box(n#1)] && (!(n#1 == null))) && (!(read($Heap_$1,n#1,_module.Node.next) == null))) ==> true)) ))))) && (_module.Node.IsClosed($Heap_$1,this_$2,S#0_$2) <==> ((S#0_$2[$Box(this_$2)] && S#0_$2[$Box(null)]) && ((forall  n#1_$0 : ref :: ( ((n#1_$0 == null) || (read($Heap_$1,n#1_$0,alloc) && (dtype(n#1_$0) == class._module.Node))) ==> (((S#0_$2[$Box(n#1_$0)] && (!(n#1_$0 == null))) && (!(read($Heap_$1,n#1_$0,_module.Node.next) == null))) ==> S#0_$2[$Box(read($Heap_$1,n#1_$0,_module.Node.next))]) )))))) )));
	assume (0 < $ModuleContextHeight) ==> ((forall  $Heap_$2 : HeapType, this_$3 : ref, S#0_$3 : Set (BoxType)  :: {_module.Node.IsClosed($Heap_$2,this_$3,S#0_$3)} ( (_module.Node.IsClosed#canCall($Heap_$2,this_$3,S#0_$3) || (((($IsGoodHeap($Heap_$2) && (!(this_$3 == null))) && read($Heap_$2,this_$3,alloc)) && (dtype(this_$3) == class._module.Node)) && ((forall  $t#4 : BoxType :: {S#0_$3[$t#4]} ( S#0_$3[$t#4] ==> ((($Unbox($t#4) : ref) == null) || (read($Heap_$2,($Unbox($t#4) : ref),alloc) && (dtype(($Unbox($t#4) : ref)) == class._module.Node))) ))))) ==> true )));
	assume (forall  $ly : LayerType, $Heap_$3 : HeapType, this_$4 : ref, k#0 : Integer, S#1 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly),$Heap_$3,this_$4,k#0,S#1)} ( _module.Node.Nexxxt($LS($ly),$Heap_$3,this_$4,k#0,S#1) == _module.Node.Nexxxt($ly,$Heap_$3,this_$4,k#0,S#1) ));
	assume (forall  $ly_$0 : LayerType, $h0_$0 : HeapType, $h1_$0 : HeapType, this_$5 : ref, k#0_$0 : Integer, S#1_$0 : Set (BoxType)  :: {$HeapSucc($h0_$0,$h1_$0),_module.Node.Nexxxt($ly_$0,$h1_$0,this_$5,k#0_$0,S#1_$0)} ( ((((((((($IsGoodHeap($h0_$0) && $IsGoodHeap($h1_$0)) && (!(this_$5 == null))) && read($h0_$0,this_$5,alloc)) && (dtype(this_$5) == class._module.Node)) && read($h1_$0,this_$5,alloc)) && (dtype(this_$5) == class._module.Node)) && (_module.Node.Nexxxt#canCall($h0_$0,this_$5,k#0_$0,S#1_$0) || ((forall  $t#6 : BoxType :: {S#1_$0[$t#6]} ( S#1_$0[$t#6] ==> ((($Unbox($t#6) : ref) == null) || (read($h0_$0,($Unbox($t#6) : ref),alloc) && (dtype(($Unbox($t#6) : ref)) == class._module.Node))) ))))) && (_module.Node.Nexxxt#canCall($h1_$0,this_$5,k#0_$0,S#1_$0) || ((forall  $t#7 : BoxType :: {S#1_$0[$t#7]} ( S#1_$0[$t#7] ==> ((($Unbox($t#7) : ref) == null) || (read($h1_$0,($Unbox($t#7) : ref),alloc) && (dtype(($Unbox($t#7) : ref)) == class._module.Node))) ))))) && $HeapSucc($h0_$0,$h1_$0)) ==> (((forall<alpha> $o_$1 : ref, $f_$0 : Field (alpha)  :: ( ((((!($o_$1 == null)) && read($h0_$0,$o_$1,alloc)) && read($h1_$0,$o_$1,alloc)) && S#1_$0[$Box($o_$1)]) ==> (read($h0_$0,$o_$1,$f_$0) == read($h1_$0,$o_$1,$f_$0)) ))) ==> (_module.Node.Nexxxt($ly_$0,$h0_$0,this_$5,k#0_$0,S#1_$0) == _module.Node.Nexxxt($ly_$0,$h1_$0,this_$5,k#0_$0,S#1_$0))) ));
	assume ((0 < $ModuleContextHeight) || ((0 == $ModuleContextHeight) && (1 <= $FunctionContextHeight))) ==> ((forall  $ly_$1 : LayerType, $Heap_$4 : HeapType, this_$6 : ref, k#0_$1 : Integer, S#1_$1 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1)} ( (_module.Node.Nexxxt#canCall($Heap_$4,this_$6,k#0_$1,S#1_$1) || (((((((((!(0 == $ModuleContextHeight)) || (!(1 == $FunctionContextHeight))) && $IsGoodHeap($Heap_$4)) && (!(this_$6 == null))) && read($Heap_$4,this_$6,alloc)) && (dtype(this_$6) == class._module.Node)) && ((forall  $t#8 : BoxType :: {S#1_$1[$t#8]} ( S#1_$1[$t#8] ==> ((($Unbox($t#8) : ref) == null) || (read($Heap_$4,($Unbox($t#8) : ref),alloc) && (dtype(($Unbox($t#8) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$4,this_$6,S#1_$1)) && (0 <= k#0_$1))) ==> (S#1_$1[$Box(_module.Node.Nexxxt($LS($LZ),$Heap_$4,this_$6,k#0_$1,S#1_$1))] && ((_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1) == null) || (read($Heap_$4,_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1),alloc) && (dtype(_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1)) == class._module.Node)))) )));
	assume ((0 == $ModuleContextHeight) && (1 <= $FunctionContextHeight)) ==> ((forall  $ly_$2 : LayerType, $Heap_$5 : HeapType, this_$7 : ref, k#0_$2 : Integer, S#1_$2 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly_$2),$Heap_$5,this_$7,k#0_$2,S#1_$2)} ( (_module.Node.Nexxxt#canCall($Heap_$5,this_$7,k#0_$2,S#1_$2) || ((((((((!(1 == $FunctionContextHeight)) && $IsGoodHeap($Heap_$5)) && (!(this_$7 == null))) && read($Heap_$5,this_$7,alloc)) && (dtype(this_$7) == class._module.Node)) && ((forall  $t#9 : BoxType :: {S#1_$2[$t#9]} ( S#1_$2[$t#9] ==> ((($Unbox($t#9) : ref) == null) || (read($Heap_$5,($Unbox($t#9) : ref),alloc) && (dtype(($Unbox($t#9) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$5,this_$7,S#1_$2)) && (0 <= k#0_$2))) ==> ((((k#0_$2 == 0) ==> true) && ((!(k#0_$2 == 0)) ==> ((_module.Node.Nexxxt#canCall($Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) && ((_module.Node.Nexxxt($LS($LZ),$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) == null) ==> true)) && ((!(_module.Node.Nexxxt($LS($LZ),$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) == null)) ==> _module.Node.Nexxxt#canCall($Heap_$5,this_$7,k#0_$2 - 1,S#1_$2))))) && (_module.Node.Nexxxt($LS($ly_$2),$Heap_$5,this_$7,k#0_$2,S#1_$2) == (if (k#0_$2 == 0) then this_$7 else (if (_module.Node.Nexxxt($ly_$2,$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) == null) then null else read($Heap_$5,_module.Node.Nexxxt($ly_$2,$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2),_module.Node.next))))) )));
	assume (0 < $ModuleContextHeight) ==> ((forall  $ly_$3 : LayerType, $Heap_$6 : HeapType, this_$8 : ref, k#0_$3 : Integer, S#1_$3 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly_$3),$Heap_$6,this_$8,k#0_$3,S#1_$3)} ( (_module.Node.Nexxxt#canCall($Heap_$6,this_$8,k#0_$3,S#1_$3) || (((((($IsGoodHeap($Heap_$6) && (!(this_$8 == null))) && read($Heap_$6,this_$8,alloc)) && (dtype(this_$8) == class._module.Node)) && ((forall  $t#10 : BoxType :: {S#1_$3[$t#10]} ( S#1_$3[$t#10] ==> ((($Unbox($t#10) : ref) == null) || (read($Heap_$6,($Unbox($t#10) : ref),alloc) && (dtype(($Unbox($t#10) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$6,this_$8,S#1_$3)) && (0 <= k#0_$3))) ==> true )));
	assume (forall  $ly_$4 : LayerType, $Heap_$7 : HeapType, this_$9 : ref, sink#0 : ref, S#1_$4 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$4),$Heap_$7,this_$9,sink#0,S#1_$4)} ( _module.Node.Reaches($LS($ly_$4),$Heap_$7,this_$9,sink#0,S#1_$4) <==> _module.Node.Reaches($ly_$4,$Heap_$7,this_$9,sink#0,S#1_$4) ));
	assume (forall  $ly_$5 : LayerType, $h0_$1 : HeapType, $h1_$1 : HeapType, this_$10 : ref, sink#0_$0 : ref, S#1_$5 : Set (BoxType)  :: {$HeapSucc($h0_$1,$h1_$1),_module.Node.Reaches($ly_$5,$h1_$1,this_$10,sink#0_$0,S#1_$5)} ( ((((((((($IsGoodHeap($h0_$1) && $IsGoodHeap($h1_$1)) && (!(this_$10 == null))) && read($h0_$1,this_$10,alloc)) && (dtype(this_$10) == class._module.Node)) && read($h1_$1,this_$10,alloc)) && (dtype(this_$10) == class._module.Node)) && (_module.Node.Reaches#canCall($h0_$1,this_$10,sink#0_$0,S#1_$5) || (((sink#0_$0 == null) || (read($h0_$1,sink#0_$0,alloc) && (dtype(sink#0_$0) == class._module.Node))) && ((forall  $t#12 : BoxType :: {S#1_$5[$t#12]} ( S#1_$5[$t#12] ==> ((($Unbox($t#12) : ref) == null) || (read($h0_$1,($Unbox($t#12) : ref),alloc) && (dtype(($Unbox($t#12) : ref)) == class._module.Node))) )))))) && (_module.Node.Reaches#canCall($h1_$1,this_$10,sink#0_$0,S#1_$5) || (((sink#0_$0 == null) || (read($h1_$1,sink#0_$0,alloc) && (dtype(sink#0_$0) == class._module.Node))) && ((forall  $t#13 : BoxType :: {S#1_$5[$t#13]} ( S#1_$5[$t#13] ==> ((($Unbox($t#13) : ref) == null) || (read($h1_$1,($Unbox($t#13) : ref),alloc) && (dtype(($Unbox($t#13) : ref)) == class._module.Node))) )))))) && $HeapSucc($h0_$1,$h1_$1)) ==> (((forall<alpha> $o_$2 : ref, $f_$1 : Field (alpha)  :: ( ((((!($o_$2 == null)) && read($h0_$1,$o_$2,alloc)) && read($h1_$1,$o_$2,alloc)) && S#1_$5[$Box($o_$2)]) ==> (read($h0_$1,$o_$2,$f_$1) == read($h1_$1,$o_$2,$f_$1)) ))) ==> (_module.Node.Reaches($ly_$5,$h0_$1,this_$10,sink#0_$0,S#1_$5) <==> _module.Node.Reaches($ly_$5,$h1_$1,this_$10,sink#0_$0,S#1_$5))) ));
	assume ((0 < $ModuleContextHeight) || ((0 == $ModuleContextHeight) && (2 <= $FunctionContextHeight))) ==> ((forall  $ly_$6 : LayerType, $Heap_$8 : HeapType, this_$11 : ref, sink#0_$1 : ref, S#1_$6 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$6),$Heap_$8,this_$11,sink#0_$1,S#1_$6)} ( (_module.Node.Reaches#canCall($Heap_$8,this_$11,sink#0_$1,S#1_$6) || (((((((((!(0 == $ModuleContextHeight)) || (!(2 == $FunctionContextHeight))) && $IsGoodHeap($Heap_$8)) && (!(this_$11 == null))) && read($Heap_$8,this_$11,alloc)) && (dtype(this_$11) == class._module.Node)) && ((sink#0_$1 == null) || (read($Heap_$8,sink#0_$1,alloc) && (dtype(sink#0_$1) == class._module.Node)))) && ((forall  $t#14 : BoxType :: {S#1_$6[$t#14]} ( S#1_$6[$t#14] ==> ((($Unbox($t#14) : ref) == null) || (read($Heap_$8,($Unbox($t#14) : ref),alloc) && (dtype(($Unbox($t#14) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$8,this_$11,S#1_$6))) ==> (_module.Node.Reaches($LS($LZ),$Heap_$8,this_$11,sink#0_$1,S#1_$6) ==> S#1_$6[$Box(sink#0_$1)]) )));
	assume ((0 == $ModuleContextHeight) && (2 <= $FunctionContextHeight)) ==> ((forall  $ly_$7 : LayerType, $Heap_$9 : HeapType, this_$12 : ref, sink#0_$2 : ref, S#1_$7 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$7),$Heap_$9,this_$12,sink#0_$2,S#1_$7)} ( (_module.Node.Reaches#canCall($Heap_$9,this_$12,sink#0_$2,S#1_$7) || ((((((((!(2 == $FunctionContextHeight)) && $IsGoodHeap($Heap_$9)) && (!(this_$12 == null))) && read($Heap_$9,this_$12,alloc)) && (dtype(this_$12) == class._module.Node)) && ((sink#0_$2 == null) || (read($Heap_$9,sink#0_$2,alloc) && (dtype(sink#0_$2) == class._module.Node)))) && ((forall  $t#15 : BoxType :: {S#1_$7[$t#15]} ( S#1_$7[$t#15] ==> ((($Unbox($t#15) : ref) == null) || (read($Heap_$9,($Unbox($t#15) : ref),alloc) && (dtype(($Unbox($t#15) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$9,this_$12,S#1_$7))) ==> (((forall  k#2 : Integer :: ( true ==> ((0 <= k#2) ==> _module.Node.Nexxxt#canCall($Heap_$9,this_$12,k#2,S#1_$7)) ))) && (_module.Node.Reaches($LS($ly_$7),$Heap_$9,this_$12,sink#0_$2,S#1_$7) <==> ((exists  k#2_$0 : Integer :: ( (0 <= k#2_$0) && (_module.Node.Nexxxt($LS($LZ),$Heap_$9,this_$12,k#2_$0,S#1_$7) == sink#0_$2) ))))) )));
	assume (0 < $ModuleContextHeight) ==> ((forall  $ly_$8 : LayerType, $Heap_$10 : HeapType, this_$13 : ref, sink#0_$3 : ref, S#1_$8 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$8),$Heap_$10,this_$13,sink#0_$3,S#1_$8)} ( (_module.Node.Reaches#canCall($Heap_$10,this_$13,sink#0_$3,S#1_$8) || (((((($IsGoodHeap($Heap_$10) && (!(this_$13 == null))) && read($Heap_$10,this_$13,alloc)) && (dtype(this_$13) == class._module.Node)) && ((sink#0_$3 == null) || (read($Heap_$10,sink#0_$3,alloc) && (dtype(sink#0_$3) == class._module.Node)))) && ((forall  $t#16 : BoxType :: {S#1_$8[$t#16]} ( S#1_$8[$t#16] ==> ((($Unbox($t#16) : ref) == null) || (read($Heap_$10,($Unbox($t#16) : ref),alloc) && (dtype(($Unbox($t#16) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$10,this_$13,S#1_$8))) ==> true )));
	assume (forall<alpha> $o_$3 : ref, $f_$2 : Field (alpha) , S#0_$4 : Set (BoxType) , null_$0 : ref, $Heap_$11 : HeapType, alloc_$0 : Field (Boolean)  :: {lambda#0(S#0_$4,null_$0,$Heap_$11,alloc_$0)[$o_$3,$f_$2]} ( lambda#0(S#0_$4,null_$0,$Heap_$11,alloc_$0)[$o_$3,$f_$2] <==> (((!($o_$3 == null_$0)) && read($Heap_$11,$o_$3,alloc_$0)) ==> S#0_$4[$Box($o_$3)]) ));
	assume (forall<alpha> $o_$4 : ref, $f_$3 : Field (alpha) , S#1_$9 : Set (BoxType) , null_$1 : ref, $Heap_$12 : HeapType, alloc_$1 : Field (Boolean)  :: {lambda#1(S#1_$9,null_$1,$Heap_$12,alloc_$1)[$o_$4,$f_$3]} ( lambda#1(S#1_$9,null_$1,$Heap_$12,alloc_$1)[$o_$4,$f_$3] <==> (((!($o_$4 == null_$1)) && read($Heap_$12,$o_$4,alloc_$1)) ==> S#1_$9[$Box($o_$4)]) ));
	assume (forall<alpha> $o_$5 : ref, $f_$4 : Field (alpha) , S#1_$10 : Set (BoxType) , null_$2 : ref, $Heap_$13 : HeapType, alloc_$2 : Field (Boolean)  :: {lambda#2(S#1_$10,null_$2,$Heap_$13,alloc_$2)[$o_$5,$f_$4]} ( lambda#2(S#1_$10,null_$2,$Heap_$13,alloc_$2)[$o_$5,$f_$4] <==> (((!($o_$5 == null_$2)) && read($Heap_$13,$o_$5,alloc_$2)) ==> S#1_$10[$Box($o_$5)]) ));
	assume (forall<alpha> $o_$6 : ref, $f_$5 : Field (alpha) , alloc_$3 : Field (Boolean) , null_$3 : ref, $Heap_$14 : HeapType :: {lambda#3(alloc_$3,null_$3,$Heap_$14)[$o_$6,$f_$5]} ( lambda#3(alloc_$3,null_$3,$Heap_$14)[$o_$6,$f_$5] <==> (((!($o_$6 == null_$3)) && read($Heap_$14,$o_$6,alloc_$3)) ==> false) ));
	assume (forall<alpha> $o_$7 : ref, $f_$6 : Field (alpha) , alloc_$4 : Field (Boolean) , null_$4 : ref, $Heap_$15 : HeapType :: {lambda#4(alloc_$4,null_$4,$Heap_$15)[$o_$7,$f_$6]} ( lambda#4(alloc_$4,null_$4,$Heap_$15)[$o_$7,$f_$6] <==> (((!($o_$7 == null_$4)) && read($Heap_$15,$o_$7,alloc_$4)) ==> false) ));
	assume (forall<alpha> $o_$8 : ref, $f_$7 : Field (alpha) , alloc_$5 : Field (Boolean) , null_$5 : ref, $Heap_$16 : HeapType :: {lambda#5(alloc_$5,null_$5,$Heap_$16)[$o_$8,$f_$7]} ( lambda#5(alloc_$5,null_$5,$Heap_$16)[$o_$8,$f_$7] <==> (((!($o_$8 == null_$5)) && read($Heap_$16,$o_$8,alloc_$5)) ==> false) ));
	assume (forall<alpha> $o_$9 : ref, $f_$8 : Field (alpha) , alloc_$6 : Field (Boolean) , null_$6 : ref, $Heap_$17 : HeapType :: {lambda#6(alloc_$6,null_$6,$Heap_$17)[$o_$9,$f_$8]} ( lambda#6(alloc_$6,null_$6,$Heap_$17)[$o_$9,$f_$8] <==> (((!($o_$9 == null_$6)) && read($Heap_$17,$o_$9,alloc_$6)) ==> false) ));
	assume (forall<alpha> $o_$10 : ref, $f_$9 : Field (alpha) , alloc_$7 : Field (Boolean) , null_$7 : ref, $Heap_$18 : HeapType :: {lambda#7(alloc_$7,null_$7,$Heap_$18)[$o_$10,$f_$9]} ( lambda#7(alloc_$7,null_$7,$Heap_$18)[$o_$10,$f_$9] <==> (((!($o_$10 == null_$7)) && read($Heap_$18,$o_$10,alloc_$7)) ==> false) ));
	assume (forall<alpha> $o_$11 : ref, $f_$10 : Field (alpha) , alloc_$8 : Field (Boolean) , null_$8 : ref, $Heap_$19 : HeapType :: {lambda#8(alloc_$8,null_$8,$Heap_$19)[$o_$11,$f_$10]} ( lambda#8(alloc_$8,null_$8,$Heap_$19)[$o_$11,$f_$10] <==> (((!($o_$11 == null_$8)) && read($Heap_$19,$o_$11,alloc_$8)) ==> false) ));
	assume (forall<alpha> $o_$12 : ref, $f_$11 : Field (alpha) , alloc_$9 : Field (Boolean) , null_$9 : ref, $Heap_$20 : HeapType :: {lambda#9(alloc_$9,null_$9,$Heap_$20)[$o_$12,$f_$11]} ( lambda#9(alloc_$9,null_$9,$Heap_$20)[$o_$12,$f_$11] <==> (((!($o_$12 == null_$9)) && read($Heap_$20,$o_$12,alloc_$9)) ==> false) ));
	assume (forall<alpha> $o_$13 : ref, $f_$12 : Field (alpha) , alloc_$10 : Field (Boolean) , null_$10 : ref, $Heap_$21 : HeapType :: {lambda#10(alloc_$10,null_$10,$Heap_$21)[$o_$13,$f_$12]} ( lambda#10(alloc_$10,null_$10,$Heap_$21)[$o_$13,$f_$12] <==> (((!($o_$13 == null_$10)) && read($Heap_$21,$o_$13,alloc_$10)) ==> false) ));
	assume (forall<alpha> $o_$14 : ref, $f_$13 : Field (alpha) , alloc_$11 : Field (Boolean) , null_$11 : ref, $Heap_$22 : HeapType :: {lambda#11(alloc_$11,null_$11,$Heap_$22)[$o_$14,$f_$13]} ( lambda#11(alloc_$11,null_$11,$Heap_$22)[$o_$14,$f_$13] <==> (((!($o_$14 == null_$11)) && read($Heap_$22,$o_$14,alloc_$11)) ==> false) ));
	assume (forall<alpha> $o_$15 : ref, $f_$14 : Field (alpha) , alloc_$12 : Field (Boolean) , null_$12 : ref, $Heap_$23 : HeapType :: {lambda#12(alloc_$12,null_$12,$Heap_$23)[$o_$15,$f_$14]} ( lambda#12(alloc_$12,null_$12,$Heap_$23)[$o_$15,$f_$14] <==> (((!($o_$15 == null_$12)) && read($Heap_$23,$o_$15,alloc_$12)) ==> false) ));
	assume (forall<alpha> $o_$16 : ref, $f_$15 : Field (alpha) , alloc_$13 : Field (Boolean) , null_$13 : ref, $Heap_$24 : HeapType :: {lambda#13(alloc_$13,null_$13,$Heap_$24)[$o_$16,$f_$15]} ( lambda#13(alloc_$13,null_$13,$Heap_$24)[$o_$16,$f_$15] <==> (((!($o_$16 == null_$13)) && read($Heap_$24,$o_$16,alloc_$13)) ==> false) ));
	assume (forall<alpha> $o_$17 : ref, $f_$16 : Field (alpha) , alloc_$14 : Field (Boolean) , null_$14 : ref, $Heap_$25 : HeapType :: {lambda#14(alloc_$14,null_$14,$Heap_$25)[$o_$17,$f_$16]} ( lambda#14(alloc_$14,null_$14,$Heap_$25)[$o_$17,$f_$16] <==> (((!($o_$17 == null_$14)) && read($Heap_$25,$o_$17,alloc_$14)) ==> false) ));
	assume (forall<alpha> $o_$18 : ref, $f_$17 : Field (alpha) , alloc_$15 : Field (Boolean) , null_$15 : ref, $Heap_$26 : HeapType :: {lambda#15(alloc_$15,null_$15,$Heap_$26)[$o_$18,$f_$17]} ( lambda#15(alloc_$15,null_$15,$Heap_$26)[$o_$18,$f_$17] <==> (((!($o_$18 == null_$15)) && read($Heap_$26,$o_$18,alloc_$15)) ==> false) ));
	assume (forall<alpha> $o_$19 : ref, $f_$18 : Field (alpha) , alloc_$16 : Field (Boolean) , null_$16 : ref, $Heap_$27 : HeapType :: {lambda#16(alloc_$16,null_$16,$Heap_$27)[$o_$19,$f_$18]} ( lambda#16(alloc_$16,null_$16,$Heap_$27)[$o_$19,$f_$18] <==> (((!($o_$19 == null_$16)) && read($Heap_$27,$o_$19,alloc_$16)) ==> false) ));
	assume (forall<alpha> $o_$20 : ref, $f_$19 : Field (alpha) , alloc_$17 : Field (Boolean) , null_$17 : ref, $Heap_$28 : HeapType :: {lambda#17(alloc_$17,null_$17,$Heap_$28)[$o_$20,$f_$19]} ( lambda#17(alloc_$17,null_$17,$Heap_$28)[$o_$20,$f_$19] <==> (((!($o_$20 == null_$17)) && read($Heap_$28,$o_$20,alloc_$17)) ==> false) ));
	assume (forall<alpha> $o_$21 : ref, $f_$20 : Field (alpha) , alloc_$18 : Field (Boolean) , null_$18 : ref, $Heap_$29 : HeapType :: {lambda#18(alloc_$18,null_$18,$Heap_$29)[$o_$21,$f_$20]} ( lambda#18(alloc_$18,null_$18,$Heap_$29)[$o_$21,$f_$20] <==> (((!($o_$21 == null_$18)) && read($Heap_$29,$o_$21,alloc_$18)) ==> false) ));
	assume (forall<alpha> $o_$22 : ref, $f_$21 : Field (alpha) , alloc_$19 : Field (Boolean) , null_$19 : ref, $Heap_$30 : HeapType :: {lambda#19(alloc_$19,null_$19,$Heap_$30)[$o_$22,$f_$21]} ( lambda#19(alloc_$19,null_$19,$Heap_$30)[$o_$22,$f_$21] <==> (((!($o_$22 == null_$19)) && read($Heap_$30,$o_$22,alloc_$19)) ==> false) ));
	assume (forall<alpha> $o_$23 : ref, $f_$22 : Field (alpha) , alloc_$20 : Field (Boolean) , null_$20 : ref, $Heap_$31 : HeapType :: {lambda#20(alloc_$20,null_$20,$Heap_$31)[$o_$23,$f_$22]} ( lambda#20(alloc_$20,null_$20,$Heap_$31)[$o_$23,$f_$22] <==> (((!($o_$23 == null_$20)) && read($Heap_$31,$o_$23,alloc_$20)) ==> false) ));
	assume (forall<alpha> $o_$24 : ref, $f_$23 : Field (alpha) , alloc_$21 : Field (Boolean) , null_$21 : ref, $Heap_$32 : HeapType :: {lambda#21(alloc_$21,null_$21,$Heap_$32)[$o_$24,$f_$23]} ( lambda#21(alloc_$21,null_$21,$Heap_$32)[$o_$24,$f_$23] <==> (((!($o_$24 == null_$21)) && read($Heap_$32,$o_$24,alloc_$21)) ==> false) ));
	assume (forall<alpha> $o_$25 : ref, $f_$24 : Field (alpha) , alloc_$22 : Field (Boolean) , null_$22 : ref, $Heap_$33 : HeapType :: {lambda#22(alloc_$22,null_$22,$Heap_$33)[$o_$25,$f_$24]} ( lambda#22(alloc_$22,null_$22,$Heap_$33)[$o_$25,$f_$24] <==> (((!($o_$25 == null_$22)) && read($Heap_$33,$o_$25,alloc_$22)) ==> false) ));
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume $IsGoodHeap($Heap);
	assume ((!(this == null)) && read($Heap,this,alloc)) && (dtype(this) == class._module.Node);
	assume ((forall  $t#6_$0 : BoxType :: {S#0[$t#6_$0]} ( S#0[$t#6_$0] ==> ((($Unbox($t#6_$0) : ref) == null) || (read($Heap,($Unbox($t#6_$0) : ref),alloc) && (dtype(($Unbox($t#6_$0) : ref)) == class._module.Node))) ))) && $IsGoodSet_Extended(S#0,null);
	assume (p#30 == null) || (read($Heap,p#30,alloc) && (dtype(p#30) == class._module.Node));
	assume (forall  $t#9_$0 : BoxType :: {Visited#32[$t#9_$0]} ( Visited#32[$t#9_$0] ==> ((($Unbox($t#9_$0) : ref) == null) || (read($Heap,($Unbox($t#9_$0) : ref),alloc) && (dtype(($Unbox($t#9_$0) : ref)) == class._module.Node))) ));
	assume (0 == $ModuleContextHeight) && (4 == $FunctionContextHeight);
	assume _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(this)]);
	assume _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(null)]);
	assume _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || ((forall  n#26 : ref :: ( ((n#26 == null) || (read($Heap,n#26,alloc) && (dtype(n#26) == class._module.Node))) ==> (((S#0[$Box(n#26)] && (!(n#26 == null))) && (!(read($Heap,n#26,_module.Node.next) == null))) ==> S#0[$Box(read($Heap,n#26,_module.Node.next))]) ))));
	assume (((_module.Node.IsClosed#canCall($Heap,this,S#0) && _module.Node.IsClosed($Heap,this,S#0)) && S#0[$Box(this)]) && S#0[$Box(null)]) && ((forall  n#27 : ref :: ( ((n#27 == null) || (read($Heap,n#27,alloc) && (dtype(n#27) == class._module.Node))) ==> (((S#0[$Box(n#27)] && (!(n#27 == null))) && (!(read($Heap,n#27,_module.Node.next) == null))) ==> S#0[$Box(read($Heap,n#27,_module.Node.next))]) )));
	goto anon0;
anon0:
	assume $_Frame_$_0 == lambda#6(alloc,null,$Heap);
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume $rhs#11_$_0 == Lit(0);
	assume true;
	assume $rhs#12_$_0 == Set#UnionOne((Set#Empty() : Set (BoxType) ),$Box(null));
	assume true;
	assume $decr0$init$0_$_0 == Set#Difference(S#0,$rhs#12_$_0);
	assert  $w0_$_0 ==> (0 <= $rhs#11_$_0);
	assert  $w0_$_0 ==> (this == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,$rhs#11_$_0,S#0));
	assert  $w0_$_0 ==> S#0[$Box(this)];
	assert  $w0_$_0 ==> $rhs#12_$_0[$Box(null)];
	assert  $w0_$_0 ==> Set#Subset($rhs#12_$_0,S#0);
	assert  $w0_$_0 ==> ((forall  t#38 : Integer :: ( (((forall  t$ih#13#39 : Integer :: ( true ==> (((0 <= t$ih#13#39) && (t$ih#13#39 < t#38)) ==> (((0 <= t$ih#13#39) && (t$ih#13#39 < $rhs#11_$_0)) ==> $rhs#12_$_0[$Box(_module.Node.Nexxxt($LS($LZ),$Heap,this,t$ih#13#39,S#0))])) ))) && true) ==> (((0 <= t#38) && (t#38 < $rhs#11_$_0)) ==> $rhs#12_$_0[$Box(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#38,S#0))]) )));
	assert  $w0_$_0 ==> ((forall  q#45 : ref :: ( ((q#45 == null) || (read($Heap,q#45,alloc) && (dtype(q#45) == class._module.Node))) ==> ($rhs#12_$_0[$Box(q#45)] ==> ((q#45 == null) || ((exists  t#44 : Integer :: ( ((0 <= t#44) && (t#44 < $rhs#11_$_0)) && (_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#44,S#0) == q#45) ))))) )));
	assert  $w0_$_0 ==> ((forall  k#52 : Integer, l#53 : Integer :: ( (((forall  k$ih#14#54 : Integer, l$ih#15#55 : Integer :: ( true ==> ((((0 <= k$ih#14#54) && (k$ih#14#54 < k#52)) || (((k$ih#14#54 == k#52) && (0 <= l$ih#15#55)) && (l$ih#15#55 < l#53))) ==> ((((0 <= k$ih#14#54) && (k$ih#14#54 < l$ih#15#55)) && (l$ih#15#55 < $rhs#11_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#14#54,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l$ih#15#55,S#0))))) ))) && true) ==> ((((0 <= k#52) && (k#52 < l#53)) && (l#53 < $rhs#11_$_0)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#52,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,l#53,S#0)))) )));
	goto anon47_LoopHead;
anon47_LoopHead:
	assume (p#30_$_0 == null) || (read($Heap,p#30_$_0,alloc) && (dtype(p#30_$_0) == class._module.Node));
	assume (forall  $t#9_$1 : BoxType :: {Visited#32_$_0[$t#9_$1]} ( Visited#32_$_0[$t#9_$1] ==> ((($Unbox($t#9_$1) : ref) == null) || (read($Heap,($Unbox($t#9_$1) : ref),alloc) && (dtype(($Unbox($t#9_$1) : ref)) == class._module.Node))) ));
	assume ((!false) && (0 <= steps#31_$_0)) && ($rhs#11_$_0 == 0);
	assume $w0_$_0 ==> ((((0 <= steps#31_$_0) ==> _module.Node.Nexxxt#canCall($Heap,this,steps#31_$_0,S#0)) && (((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) ==> true)) && ((((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)]) ==> true));
	assume $w0_$_0 ==> (0 <= steps#31_$_0);
	assume $w0_$_0 ==> (p#30_$_0 == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,steps#31_$_0,S#0));
	assume $w0_$_0 ==> S#0[$Box(p#30_$_0)];
	assume $w0_$_0 ==> Visited#32_$_0[$Box(null)];
	assume $w0_$_0 ==> true;
	assume $w0_$_0 ==> Set#Subset(Visited#32_$_0,S#0);
	assume $w0_$_0 ==> ((forall  t#38_$0 : Integer :: ( true ==> (((0 <= t#38_$0) ==> true) && (((0 <= t#38_$0) && (t#38_$0 < steps#31_$_0)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#38_$0,S#0))) )));
	assume $w0_$_0 ==> ((forall  t#38_$1 : Integer :: ( (((forall  t$ih#13#39_$0 : Integer :: ( true ==> (((0 <= t$ih#13#39_$0) && (t$ih#13#39_$0 < t#38_$1)) ==> (((0 <= t$ih#13#39_$0) && (t$ih#13#39_$0 < steps#31_$_0)) ==> Visited#32_$_0[$Box(_module.Node.Nexxxt($LS($LZ),$Heap,this,t$ih#13#39_$0,S#0))])) ))) && true) ==> (((0 <= t#38_$1) && (t#38_$1 < steps#31_$_0)) ==> Visited#32_$_0[$Box(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#38_$1,S#0))]) )));
	assume $w0_$_0 ==> ((forall  t#38_$2 : Integer :: ( true ==> (((0 <= t#38_$2) && (t#38_$2 < steps#31_$_0)) ==> Visited#32_$_0[$Box(_module.Node.Nexxxt($LS($LZ),$Heap,this,t#38_$2,S#0))]) )));
	assume $w0_$_0 ==> ((forall  q#45_$0 : ref :: ( ((q#45_$0 == null) || (read($Heap,q#45_$0,alloc) && (dtype(q#45_$0) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$0)] ==> ((!(q#45_$0 == null)) ==> ((forall  t#44_$0 : Integer :: ( true ==> (((0 <= t#44_$0) ==> true) && (((0 <= t#44_$0) && (t#44_$0 < steps#31_$_0)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#44_$0,S#0))) ))))) )));
	assume $w0_$_0 ==> ((forall  q#45_$1 : ref :: ( ((q#45_$1 == null) || (read($Heap,q#45_$1,alloc) && (dtype(q#45_$1) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$1)] ==> ((q#45_$1 == null) || ((exists  t#44_$1 : Integer :: ( ((0 <= t#44_$1) && (t#44_$1 < steps#31_$_0)) && (_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#44_$1,S#0) == q#45_$1) ))))) )));
	assume $w0_$_0 ==> ((forall  q#45_$2 : ref :: ( ((q#45_$2 == null) || (read($Heap,q#45_$2,alloc) && (dtype(q#45_$2) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$2)] ==> ((q#45_$2 == null) || ((exists  t#44_$2 : Integer :: ( ((0 <= t#44_$2) && (t#44_$2 < steps#31_$_0)) && (_module.Node.Nexxxt($LS($LZ),$Heap,this,t#44_$2,S#0) == q#45_$2) ))))) )));
	assume $w0_$_0 ==> ((forall  k#52_$0 : Integer, l#53_$0 : Integer :: ( true ==> ((((0 <= k#52_$0) ==> true) && (((0 <= k#52_$0) && (k#52_$0 < l#53_$0)) ==> true)) && ((((0 <= k#52_$0) && (k#52_$0 < l#53_$0)) && (l#53_$0 < steps#31_$_0)) ==> (_module.Node.Nexxxt#canCall($Heap,this,k#52_$0,S#0) && _module.Node.Nexxxt#canCall($Heap,this,l#53_$0,S#0)))) )));
	assume $w0_$_0 ==> ((forall  k#52_$1 : Integer, l#53_$1 : Integer :: ( (((forall  k$ih#14#54_$0 : Integer, l$ih#15#55_$0 : Integer :: ( true ==> ((((0 <= k$ih#14#54_$0) && (k$ih#14#54_$0 < k#52_$1)) || (((k$ih#14#54_$0 == k#52_$1) && (0 <= l$ih#15#55_$0)) && (l$ih#15#55_$0 < l#53_$1))) ==> ((((0 <= k$ih#14#54_$0) && (k$ih#14#54_$0 < l$ih#15#55_$0)) && (l$ih#15#55_$0 < steps#31_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#14#54_$0,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l$ih#15#55_$0,S#0))))) ))) && true) ==> ((((0 <= k#52_$1) && (k#52_$1 < l#53_$1)) && (l#53_$1 < steps#31_$_0)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#52_$1,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,l#53_$1,S#0)))) )));
	assume $w0_$_0 ==> ((forall  k#52_$2 : Integer, l#53_$2 : Integer :: ( true ==> ((((0 <= k#52_$2) && (k#52_$2 < l#53_$2)) && (l#53_$2 < steps#31_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k#52_$2,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l#53_$2,S#0)))) )));
	assume $Heap == $Heap;
	assume (forall<alpha> $o_$26 : ref, $f_$25 : Field (alpha)  :: {read($Heap,$o_$26,$f_$25)} ( ((!($o_$26 == null)) && read($Heap,$o_$26,alloc)) ==> ((read($Heap,$o_$26,$f_$25) == read($Heap,$o_$26,$f_$25)) || $_Frame_$_0[$o_$26,$f_$25]) ));
	assume Set#Subset(Set#Difference(S#0,Visited#32_$_0),$decr0$init$0_$_0) && (Set#Equal(Set#Difference(S#0,Visited#32_$_0),$decr0$init$0_$_0) ==> true);
	if ($_$_condition) { goto anon47_LoopDone; } else { goto anon47_LoopBody; }
anon47_LoopDone:
	assume !true;
	goto anon28;
anon47_LoopBody:
	assume true;
	assume true;
	if ($_$_condition_$0) { goto anon48_Then; } else { goto anon48_Else; }
anon28:
	assume true;
	if ($_$_condition_$7) { goto anon62_Then; } else { goto anon62_Else; }
anon48_Then:
	assume !$w0_$_0;
	if ($_$_condition_$1) { goto anon49_Then; } else { goto anon49_Else; }
anon48_Else:
	assume $w0_$_0;
	assume true;
	if ($_$_condition_$2) { goto anon61_Then; } else { goto anon61_Else; }
anon49_Then:
	assume 0 <= steps#31_$_0;
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= steps#31_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,steps#31_$_0,S#0);
	if ($_$_condition_$3) { goto anon50_Then; } else { goto anon50_Else; }
anon49_Else:
	assume steps#31_$_0 < 0;
	if ($_$_condition_$4) { goto anon50_Then; } else { goto anon50_Else; }
anon61_Then:
	assume Visited#32_$_0[$Box(p#30_$_0)];
	goto anon28;
anon61_Else:
	assume !Visited#32_$_0[$Box(p#30_$_0)];
	assume $decr0$0_$_1 == Set#Difference(S#0,Visited#32_$_0);
	assume true;
	assume true;
	assume true;
	assert  !(p#30_$_0 == null);
	assume true;
	assume $rhs#16_$_1 == read($Heap,p#30_$_0,_module.Node.next);
	assume true;
	assume $rhs#17_$_1 == (steps#31_$_0 + 1);
	assume true;
	assume $rhs#18_$_1 == Set#Union(Visited#32_$_0,Set#UnionOne((Set#Empty() : Set (BoxType) ),$Box(p#30_$_0)));
	assume true;
	assert  Set#Subset(Set#Difference(S#0,$rhs#18_$_1),$decr0$0_$_1) && (!Set#Subset($decr0$0_$_1,Set#Difference(S#0,$rhs#18_$_1)));
	assume (((0 <= $rhs#17_$_1) ==> _module.Node.Nexxxt#canCall($Heap,this,$rhs#17_$_1,S#0)) && (((0 <= $rhs#17_$_1) && ($rhs#16_$_1 == _module.Node.Nexxxt($LS($LZ),$Heap,this,$rhs#17_$_1,S#0))) ==> true)) && ((((0 <= $rhs#17_$_1) && ($rhs#16_$_1 == _module.Node.Nexxxt($LS($LZ),$Heap,this,$rhs#17_$_1,S#0))) && S#0[$Box($rhs#16_$_1)]) ==> true);
	assume true;
	assume (forall  t#38_$3 : Integer :: ( true ==> (((0 <= t#38_$3) ==> true) && (((0 <= t#38_$3) && (t#38_$3 < $rhs#17_$_1)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#38_$3,S#0))) ));
	assume (forall  q#45_$3 : ref :: ( ((q#45_$3 == null) || (read($Heap,q#45_$3,alloc) && (dtype(q#45_$3) == class._module.Node))) ==> ($rhs#18_$_1[$Box(q#45_$3)] ==> ((!(q#45_$3 == null)) ==> ((forall  t#44_$3 : Integer :: ( true ==> (((0 <= t#44_$3) ==> true) && (((0 <= t#44_$3) && (t#44_$3 < $rhs#17_$_1)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#44_$3,S#0))) ))))) ));
	assume (forall  k#52_$3 : Integer, l#53_$3 : Integer :: ( true ==> ((((0 <= k#52_$3) ==> true) && (((0 <= k#52_$3) && (k#52_$3 < l#53_$3)) ==> true)) && ((((0 <= k#52_$3) && (k#52_$3 < l#53_$3)) && (l#53_$3 < $rhs#17_$_1)) ==> (_module.Node.Nexxxt#canCall($Heap,this,k#52_$3,S#0) && _module.Node.Nexxxt#canCall($Heap,this,l#53_$3,S#0)))) ));
	assert  $w0_$_0 ==> (0 <= $rhs#17_$_1);
	assert  $w0_$_0 ==> ($rhs#16_$_1 == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,$rhs#17_$_1,S#0));
	assert  $w0_$_0 ==> S#0[$Box($rhs#16_$_1)];
	assert  $w0_$_0 ==> $rhs#18_$_1[$Box(null)];
	assert  $w0_$_0 ==> Set#Subset($rhs#18_$_1,S#0);
	assert  $w0_$_0 ==> ((forall  t#38_$4 : Integer :: ( (((forall  t$ih#13#39_$1 : Integer :: ( true ==> (((0 <= t$ih#13#39_$1) && (t$ih#13#39_$1 < t#38_$4)) ==> (((0 <= t$ih#13#39_$1) && (t$ih#13#39_$1 < $rhs#17_$_1)) ==> $rhs#18_$_1[$Box(_module.Node.Nexxxt($LS($LZ),$Heap,this,t$ih#13#39_$1,S#0))])) ))) && true) ==> (((0 <= t#38_$4) && (t#38_$4 < $rhs#17_$_1)) ==> $rhs#18_$_1[$Box(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#38_$4,S#0))]) )));
	assert  $w0_$_0 ==> ((forall  q#45_$4 : ref :: ( ((q#45_$4 == null) || (read($Heap,q#45_$4,alloc) && (dtype(q#45_$4) == class._module.Node))) ==> ($rhs#18_$_1[$Box(q#45_$4)] ==> ((q#45_$4 == null) || ((exists  t#44_$4 : Integer :: ( ((0 <= t#44_$4) && (t#44_$4 < $rhs#17_$_1)) && (_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#44_$4,S#0) == q#45_$4) ))))) )));
	assert  $w0_$_0 ==> ((forall  k#52_$4 : Integer, l#53_$4 : Integer :: ( (((forall  k$ih#14#54_$1 : Integer, l$ih#15#55_$1 : Integer :: ( true ==> ((((0 <= k$ih#14#54_$1) && (k$ih#14#54_$1 < k#52_$4)) || (((k$ih#14#54_$1 == k#52_$4) && (0 <= l$ih#15#55_$1)) && (l$ih#15#55_$1 < l#53_$4))) ==> ((((0 <= k$ih#14#54_$1) && (k$ih#14#54_$1 < l$ih#15#55_$1)) && (l$ih#15#55_$1 < $rhs#17_$_1)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#14#54_$1,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l$ih#15#55_$1,S#0))))) ))) && true) ==> ((((0 <= k#52_$4) && (k#52_$4 < l#53_$4)) && (l#53_$4 < $rhs#17_$_1)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#52_$4,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,l#53_$4,S#0)))) )));
	assume false;
	assume A#1_$_3 == A#1;
	assume B#2_$_1 == B#2;
	assume $Heap_$_1 == $Heap;
	goto $exit;
anon50_Then:
	assume (0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0));
	if ($_$_condition_$5) { goto anon51_Then; } else { goto anon51_Else; }
anon50_Else:
	assume !((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0)));
	if ($_$_condition_$6) { goto anon51_Then; } else { goto anon51_Else; }
anon51_Then:
	assume ((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)];
	goto anon8;
anon51_Else:
	assume !(((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)]);
	goto anon8;
anon62_Then:
	assume p#30_$_0 == null;
	assume true;
	assume true;
	assume true;
	assume true;
	assume $rhs#20_$_0 == Lit(1);
	assume true;
	assume A#1_$_3 == steps#31_$_0;
	assume B#2_$_1 == $rhs#20_$_0;
	assume $Heap_$_1 == $Heap;
	goto GeneratedUnifiedExit;
anon62_Else:
	assume !(p#30_$_0 == null);
	if ($_$_condition_$8) { goto anon63_Then; } else { goto anon63_Else; }
anon8:
	assume (((0 <= steps#31_$_0) ==> _module.Node.Nexxxt#canCall($Heap,this,steps#31_$_0,S#0)) && (((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) ==> true)) && ((((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)]) ==> true);
	assume (((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)]) && Visited#32_$_0[$Box(null)];
	assume true;
	assume Set#Subset(Visited#32_$_0,S#0);
	if ($_$_condition_$9) { goto anon52_Then; } else { goto anon52_Else; }
GeneratedUnifiedExit:
	assert  0 <= A#1_$_3;
	assert  1 <= B#2_$_1;
	assert  (forall  k#10 : Integer, l#11 : Integer :: ( (((forall  k$ih#7#28 : Integer, l$ih#8#29 : Integer :: ( true ==> ((((0 <= k$ih#7#28) && (k$ih#7#28 < k#10)) || (((k$ih#7#28 == k#10) && (0 <= l$ih#8#29)) && (l$ih#8#29 < l#11))) ==> ((((0 <= k$ih#7#28) && (k$ih#7#28 < l$ih#8#29)) && (l$ih#8#29 < A#1_$_3)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap_$_1,this,k$ih#7#28,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap_$_1,this,l$ih#8#29,S#0))))) ))) && true) ==> ((((0 <= k#10) && (k#10 < l#11)) && (l#11 < A#1_$_3)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_1,this,k#10,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_1,this,l#11,S#0)))) ));
	assert  (_module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_1,this,A#1_$_3,S#0) == null) || (_module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_1,_module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_1,this,A#1_$_3,S#0),B#2_$_1,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_1,this,A#1_$_3,S#0));
	goto $exit;
anon63_Then:
	assume 0 <= k#56_$_0;
	if ($_$_condition_$10) { goto anon64_Then; } else { goto anon64_Else; }
anon63_Else:
	assume k#56_$_0 < 0;
	if ($_$_condition_$11) { goto anon64_Then; } else { goto anon64_Else; }
anon52_Then:
	assume 0 <= t#35_$_0;
	if ($_$_condition_$12) { goto anon53_Then; } else { goto anon53_Else; }
anon52_Else:
	assume t#35_$_0 < 0;
	if ($_$_condition_$13) { goto anon53_Then; } else { goto anon53_Else; }
anon64_Then:
	assume (0 <= k#56_$_0) && (k#56_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= k#56_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,k#56_$_0,S#0);
	goto anon34;
anon64_Else:
	assume !((0 <= k#56_$_0) && (k#56_$_0 < steps#31_$_0));
	goto anon34;
anon53_Then:
	assume (0 <= t#35_$_0) && (t#35_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= t#35_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,t#35_$_0,S#0);
	goto anon12;
anon53_Else:
	assume !((0 <= t#35_$_0) && (t#35_$_0 < steps#31_$_0));
	goto anon12;
anon34:
	assume (forall  k#59 : Integer :: ( true ==> (((0 <= k#59) ==> true) && (((0 <= k#59) && (k#59 < steps#31_$_0)) ==> _module.Node.Nexxxt#canCall($Heap,this,k#59,S#0))) ));
	assert  (exists  k#59_$0 : Integer :: ( ((0 <= k#59_$0) && (k#59_$0 < steps#31_$_0)) && (_module.Node.Nexxxt($LS($LZ),$Heap,this,k#59_$0,S#0) == p#30_$_0) ));
	assume true;
	assume true;
	assume A#1_$_0 == Lit(0);
	assume true;
	assume $decr1$init$0_$_0 == (steps#31_$_0 - A#1_$_0);
	assert  $w1_$_0 ==> (0 <= A#1_$_0);
	assert  $w1_$_0 ==> (A#1_$_0 < steps#31_$_0);
	assert  $w1_$_0 ==> ((forall  k#63 : Integer :: ( (((forall  k$ih#21#64 : Integer :: ( true ==> (((0 <= k$ih#21#64) && (k$ih#21#64 < k#63)) ==> (((0 <= k$ih#21#64) && (k$ih#21#64 < A#1_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#21#64,S#0) == p#30_$_0)))) ))) && true) ==> (((0 <= k#63) && (k#63 < A#1_$_0)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#63,S#0) == p#30_$_0))) )));
	goto anon65_LoopHead;
anon12:
	assume (forall  t#38_$5 : Integer :: ( true ==> (((0 <= t#38_$5) ==> true) && (((0 <= t#38_$5) && (t#38_$5 < steps#31_$_0)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#38_$5,S#0))) ));
	assume (forall  t#38_$6 : Integer :: ( true ==> (((0 <= t#38_$6) && (t#38_$6 < steps#31_$_0)) ==> Visited#32_$_0[$Box(_module.Node.Nexxxt($LS($LZ),$Heap,this,t#38_$6,S#0))]) ));
	assume (q#40_$_0 == null) || (read($Heap,q#40_$_0,alloc) && (dtype(q#40_$_0) == class._module.Node));
	if ($_$_condition_$14) { goto anon54_Then; } else { goto anon54_Else; }
anon65_LoopHead:
	assume ((((0 <= A#1_$_1) && (!false)) && (0 <= steps#31_$_0)) && ($rhs#11_$_0 == 0)) && (0 <= $decr1$init$0_$_0);
	assume $w1_$_0 ==> ((0 <= A#1_$_1) ==> true);
	assume $w1_$_0 ==> (0 <= A#1_$_1);
	assume $w1_$_0 ==> (A#1_$_1 < steps#31_$_0);
	assume $w1_$_0 ==> ((forall  k#63_$0 : Integer :: ( true ==> (((0 <= k#63_$0) ==> true) && (((0 <= k#63_$0) && (k#63_$0 < A#1_$_1)) ==> _module.Node.Nexxxt#canCall($Heap,this,k#63_$0,S#0))) )));
	assume $w1_$_0 ==> ((forall  k#63_$1 : Integer :: ( (((forall  k$ih#21#64_$0 : Integer :: ( true ==> (((0 <= k$ih#21#64_$0) && (k$ih#21#64_$0 < k#63_$1)) ==> (((0 <= k$ih#21#64_$0) && (k$ih#21#64_$0 < A#1_$_1)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#21#64_$0,S#0) == p#30_$_0)))) ))) && true) ==> (((0 <= k#63_$1) && (k#63_$1 < A#1_$_1)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#63_$1,S#0) == p#30_$_0))) )));
	assume $w1_$_0 ==> ((forall  k#63_$2 : Integer :: ( true ==> (((0 <= k#63_$2) && (k#63_$2 < A#1_$_1)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k#63_$2,S#0) == p#30_$_0))) )));
	assume $Heap == $Heap;
	assume (forall<alpha> $o_$27 : ref, $f_$26 : Field (alpha)  :: {read($Heap,$o_$27,$f_$26)} ( ((!($o_$27 == null)) && read($Heap,$o_$27,alloc)) ==> ((read($Heap,$o_$27,$f_$26) == read($Heap,$o_$27,$f_$26)) || $_Frame_$_0[$o_$27,$f_$26]) ));
	assume ((steps#31_$_0 - A#1_$_1) <= $decr1$init$0_$_0) && (((steps#31_$_0 - A#1_$_1) == $decr1$init$0_$_0) ==> true);
	if ($_$_condition_$15) { goto anon65_LoopDone; } else { goto anon65_LoopBody; }
anon54_Then:
	assume Visited#32_$_0[$Box(q#40_$_0)];
	if ($_$_condition_$16) { goto anon55_Then; } else { goto anon55_Else; }
anon54_Else:
	assume !Visited#32_$_0[$Box(q#40_$_0)];
	goto anon18;
anon65_LoopDone:
	assume !true;
	goto anon46;
anon65_LoopBody:
	assume true;
	assume true;
	if ($_$_condition_$17) { goto anon66_Then; } else { goto anon66_Else; }
anon55_Then:
	assume !(q#40_$_0 == null);
	if ($_$_condition_$18) { goto anon56_Then; } else { goto anon56_Else; }
anon55_Else:
	assume q#40_$_0 == null;
	goto anon18;
anon18:
	assume (forall  q#45_$5 : ref :: ( ((q#45_$5 == null) || (read($Heap,q#45_$5,alloc) && (dtype(q#45_$5) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$5)] ==> ((!(q#45_$5 == null)) ==> ((forall  t#44_$5 : Integer :: ( true ==> (((0 <= t#44_$5) ==> true) && (((0 <= t#44_$5) && (t#44_$5 < steps#31_$_0)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#44_$5,S#0))) ))))) ));
	assume (forall  q#45_$6 : ref :: ( ((q#45_$6 == null) || (read($Heap,q#45_$6,alloc) && (dtype(q#45_$6) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$6)] ==> ((q#45_$6 == null) || ((exists  t#44_$6 : Integer :: ( ((0 <= t#44_$6) && (t#44_$6 < steps#31_$_0)) && (_module.Node.Nexxxt($LS($LZ),$Heap,this,t#44_$6,S#0) == q#45_$6) ))))) ));
	if ($_$_condition_$24) { goto anon58_Then; } else { goto anon58_Else; }
anon46:
	assume true;
	assume true;
	assume B#2_$_0 == (steps#31_$_0 - A#1_$_1);
	assume true;
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= A#1_$_1);
	assume _module.Node.Nexxxt#canCall($Heap,this,A#1_$_1,S#0);
	assume _module.Node.Nexxxt#canCall($Heap,this,A#1_$_1,S#0);
	assert  !(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,A#1_$_1,S#0) == null);
	assume !(_module.Node.Nexxxt($LS($LZ),$Heap,this,A#1_$_1,S#0) == null);
	assume true;
	assume true;
	assume true;
	assert  (forall<alpha> $o_$28 : ref, $f_$27 : Field (alpha)  :: ( false ==> $_Frame_$_0[$o_$28,$f_$27] ));
	assert  _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(this)]);
	assert  _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(null)]);
	assert  _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || ((forall  n#12 : ref :: ( ((n#12 == null) || (read($Heap,n#12,alloc) && (dtype(n#12) == class._module.Node))) ==> (((S#0[$Box(n#12)] && (!(n#12 == null))) && (!(read($Heap,n#12,_module.Node.next) == null))) ==> S#0[$Box(read($Heap,n#12,_module.Node.next))]) ))));
	assert  0 <= A#1_$_1;
	assert  0 <= B#2_$_0;
	assume $IsGoodHeap($Heap_$_0);
	assume (!(_module.Node.Nexxxt($LS($LZ),$Heap_$_0,this,A#1_$_1,S#0) == null)) ==> (_module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_0,_module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_0,this,A#1_$_1,S#0),B#2_$_0,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap_$_0,this,A#1_$_1 + B#2_$_0,S#0));
	assume $Heap == $Heap_$_0;
	assume true;
	assume A#1_$_3 == A#1_$_1;
	assume B#2_$_1 == B#2_$_0;
	assume $Heap_$_1 == $Heap_$_0;
	goto GeneratedUnifiedExit;
anon66_Then:
	assume !$w1_$_0;
	if ($_$_condition_$19) { goto anon67_Then; } else { goto anon67_Else; }
anon66_Else:
	assume $w1_$_0;
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= A#1_$_1);
	assume _module.Node.Nexxxt#canCall($Heap,this,A#1_$_1,S#0);
	assume _module.Node.Nexxxt#canCall($Heap,this,A#1_$_1,S#0);
	if ($_$_condition_$20) { goto anon70_Then; } else { goto anon70_Else; }
anon56_Then:
	assume 0 <= t#41_$_0;
	if ($_$_condition_$21) { goto anon57_Then; } else { goto anon57_Else; }
anon56_Else:
	assume t#41_$_0 < 0;
	if ($_$_condition_$22) { goto anon57_Then; } else { goto anon57_Else; }
anon67_Then:
	assume 0 <= A#1_$_1;
	goto anon38;
anon67_Else:
	assume A#1_$_1 < 0;
	goto anon38;
anon70_Then:
	assume _module.Node.Nexxxt($LS($LZ),$Heap,this,A#1_$_1,S#0) == p#30_$_0;
	goto anon46;
anon70_Else:
	assume !(_module.Node.Nexxxt($LS($LZ),$Heap,this,A#1_$_1,S#0) == p#30_$_0);
	assume $decr1$0_$_1 == (steps#31_$_0 - A#1_$_1);
	assume true;
	assume true;
	assume A#1_$_2 == (A#1_$_1 + 1);
	assume true;
	assert  (0 <= $decr1$0_$_1) || ((steps#31_$_0 - A#1_$_2) == $decr1$0_$_1);
	assert  (steps#31_$_0 - A#1_$_2) < $decr1$0_$_1;
	assume (0 <= A#1_$_2) ==> true;
	assume (forall  k#63_$3 : Integer :: ( true ==> (((0 <= k#63_$3) ==> true) && (((0 <= k#63_$3) && (k#63_$3 < A#1_$_2)) ==> _module.Node.Nexxxt#canCall($Heap,this,k#63_$3,S#0))) ));
	assert  $w1_$_0 ==> (0 <= A#1_$_2);
	assert  $w1_$_0 ==> (A#1_$_2 < steps#31_$_0);
	assert  $w1_$_0 ==> ((forall  k#63_$4 : Integer :: ( (((forall  k$ih#21#64_$1 : Integer :: ( true ==> (((0 <= k$ih#21#64_$1) && (k$ih#21#64_$1 < k#63_$4)) ==> (((0 <= k$ih#21#64_$1) && (k$ih#21#64_$1 < A#1_$_2)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#21#64_$1,S#0) == p#30_$_0)))) ))) && true) ==> (((0 <= k#63_$4) && (k#63_$4 < A#1_$_2)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#63_$4,S#0) == p#30_$_0))) )));
	assume false;
	assume A#1_$_3 == A#1_$_2;
	assume B#2_$_1 == B#2;
	assume $Heap_$_1 == $Heap;
	goto $exit;
anon57_Then:
	assume (0 <= t#41_$_0) && (t#41_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= t#41_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,t#41_$_0,S#0);
	goto anon18;
anon57_Else:
	assume !((0 <= t#41_$_0) && (t#41_$_0 < steps#31_$_0));
	goto anon18;
anon38:
	assume (0 <= A#1_$_1) ==> true;
	assume (0 <= A#1_$_1) && (A#1_$_1 < steps#31_$_0);
	if ($_$_condition_$23) { goto anon68_Then; } else { goto anon68_Else; }
anon68_Then:
	assume 0 <= k#60_$_0;
	if ($_$_condition_$25) { goto anon69_Then; } else { goto anon69_Else; }
anon68_Else:
	assume k#60_$_0 < 0;
	if ($_$_condition_$26) { goto anon69_Then; } else { goto anon69_Else; }
anon58_Then:
	assume 0 <= k#46_$_0;
	if ($_$_condition_$27) { goto anon59_Then; } else { goto anon59_Else; }
anon58_Else:
	assume k#46_$_0 < 0;
	if ($_$_condition_$28) { goto anon59_Then; } else { goto anon59_Else; }
anon69_Then:
	assume (0 <= k#60_$_0) && (k#60_$_0 < A#1_$_1);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= k#60_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,k#60_$_0,S#0);
	goto anon42;
anon69_Else:
	assume !((0 <= k#60_$_0) && (k#60_$_0 < A#1_$_1));
	goto anon42;
anon59_Then:
	assume (0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0);
	if ($_$_condition_$29) { goto anon60_Then; } else { goto anon60_Else; }
anon59_Else:
	assume !((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0));
	if ($_$_condition_$30) { goto anon60_Then; } else { goto anon60_Else; }
anon42:
	assume (forall  k#63_$5 : Integer :: ( true ==> (((0 <= k#63_$5) ==> true) && (((0 <= k#63_$5) && (k#63_$5 < A#1_$_1)) ==> _module.Node.Nexxxt#canCall($Heap,this,k#63_$5,S#0))) ));
	assume (forall  k#63_$6 : Integer :: ( true ==> (((0 <= k#63_$6) && (k#63_$6 < A#1_$_1)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k#63_$6,S#0) == p#30_$_0))) ));
	assume true;
	assume false;
	assume A#1_$_3 == A#1_$_1;
	assume B#2_$_1 == B#2;
	assume $Heap_$_1 == $Heap;
	goto $exit;
anon60_Then:
	assume ((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0)) && (l#47_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= k#46_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,k#46_$_0,S#0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= l#47_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,l#47_$_0,S#0);
	goto anon24;
anon60_Else:
	assume !(((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0)) && (l#47_$_0 < steps#31_$_0));
	goto anon24;
anon24:
	assume (forall  k#52_$5 : Integer, l#53_$5 : Integer :: ( true ==> ((((0 <= k#52_$5) ==> true) && (((0 <= k#52_$5) && (k#52_$5 < l#53_$5)) ==> true)) && ((((0 <= k#52_$5) && (k#52_$5 < l#53_$5)) && (l#53_$5 < steps#31_$_0)) ==> (_module.Node.Nexxxt#canCall($Heap,this,k#52_$5,S#0) && _module.Node.Nexxxt#canCall($Heap,this,l#53_$5,S#0)))) ));
	assume (forall  k#52_$6 : Integer, l#53_$6 : Integer :: ( true ==> ((((0 <= k#52_$6) && (k#52_$6 < l#53_$6)) && (l#53_$6 < steps#31_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k#52_$6,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l#53_$6,S#0)))) ));
	assume true;
	assume false;
	assume A#1_$_3 == A#1;
	assume B#2_$_1 == B#2;
	assume $Heap_$_1 == $Heap;
	goto $exit;
}
