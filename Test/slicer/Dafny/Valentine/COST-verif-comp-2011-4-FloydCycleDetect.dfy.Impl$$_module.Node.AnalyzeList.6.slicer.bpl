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
const $ModuleContextHeight : int;
const $FunctionContextHeight : int;
const $LZ : LayerType;
const unique alloc : Field (bool);
const unique class._module.Node : ClassName;
const _module.Node.next : Field (ref);
const unique field$next : NameFamily;
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
function MultiSet#Equal <T> (MultiSet (T) ,MultiSet (T) ) : bool;
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
function $Box <T> (T) : BoxType;
function $Unbox <T> (BoxType) : T;
function $IsCanonicalBoolBox(BoxType) : bool;
function $IsGoodSet_Extended <T> (Set (BoxType) ,T) : bool;
function dtype(ref) : ClassName;
function TypeTuple(ClassName,ClassName) : ClassName;
function TypeTupleCar(ClassName) : ClassName;
function TypeTupleCdr(ClassName) : ClassName;
function DtType(DatatypeType) : ClassName;
function DtRank(DatatypeType) : int;
function $LS(LayerType) : LayerType;
function FDim <T> (Field (T)) : int;
function IndexField(int) : Field (BoxType);
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
function $IsGoodHeap(HeapType) : bool;
function $HeapSucc(HeapType,HeapType) : bool;
function _module.Node.IsClosed(HeapType,ref,Set (BoxType) ) : bool;
function _module.Node.IsClosed#canCall(HeapType,ref,Set (BoxType) ) : bool;
function _module.Node.Nexxxt(LayerType,HeapType,ref,int,Set (BoxType) ) : ref;
function _module.Node.Nexxxt#canCall(HeapType,ref,int,Set (BoxType) ) : bool;
function _module.Node.Reaches(LayerType,HeapType,ref,ref,Set (BoxType) ) : bool;
function _module.Node.Reaches#canCall(HeapType,ref,ref,Set (BoxType) ) : bool;
function lambda#6(Field (bool),ref,HeapType) : <alpha>[ref,Field (alpha)]bool;
var $Heap : HeapType;
procedure Impl$$_module.Node.AnalyzeList (this : ref,S#0 : Set (BoxType) ) returns (A#1 : int,B#2 : int,$_reverifyPost : bool)
{
	var p#30 : ref;
	var Visited#32 : Set (BoxType) ;
	var $_Frame_$_0 : <beta>[ref,Field (beta)]bool;
	var $rhs#11_$_0 : int;
	var $rhs#12_$_0 : Set (BoxType) ;
	var $decr0$init$0_$_0 : Set (BoxType) ;
	var $w0_$_0 : bool;
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
	var A#1_$_1 : int;
	var $decr1$0_$_1 : int;
	var A#1_$_2 : int;
	var B#2_$_0 : int;
	var $Heap_$_0 : HeapType;
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
	var $_$_condition_$5 : bool;
	var $_$_condition_$7 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$9 : bool;
	var $_$_condition_$10 : bool;
	var $_$_condition_$12 : bool;
	var $_$_condition_$14 : bool;
	var $_$_condition_$15 : bool;
	var $_$_condition_$16 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$18 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$20 : bool;
	var $_$_condition_$21 : bool;
	var $_$_condition_$23 : bool;
	var $_$_condition_$24 : bool;
	var $_$_condition_$25 : bool;
	var $_$_condition_$27 : bool;
	var $_$_condition_$29 : bool;
$start:
	assume $$Language$Dafny;
	assume ((((((((((((((((((forall  x_$25 : Boolean :: {Lit(x_$25)} {:identity }( Lit(x_$25) == x_$25 ))) && ((forall  x_$26 : BoxType :: {Lit(x_$26)} {:identity }( Lit(x_$26) == x_$26 )))) && ((forall  x_$27 : Integer :: {Lit(x_$27)} {:identity }( Lit(x_$27) == x_$27 )))) && ((forall  x_$28 : Seq (ref)  :: {Lit(x_$28)} {:identity }( Lit(x_$28) == x_$28 )))) && ((forall  x_$29 : ref :: {Lit(x_$29)} {:identity }( Lit(x_$29) == x_$29 )))) && ((forall  x_$30 : Seq (BoxType)  :: {Lit(x_$30)} {:identity }( Lit(x_$30) == x_$30 )))) && ((forall  x_$31 : HeapType :: {Lit(x_$31)} {:identity }( Lit(x_$31) == x_$31 )))) && ((forall  x_$32 : Field (BoxType)  :: {Lit(x_$32)} {:identity }( Lit(x_$32) == x_$32 )))) && ((forall  x_$33 : DatatypeType :: {Lit(x_$33)} {:identity }( Lit(x_$33) == x_$33 )))) && ((forall  x_$34 : Set (BoxType)  :: {Lit(x_$34)} {:identity }( Lit(x_$34) == x_$34 )))) && ((forall  x_$35 : Map (BoxType) (BoxType)  :: {Lit(x_$35)} {:identity }( Lit(x_$35) == x_$35 )))) && ((forall  x_$36 : ClassName :: {Lit(x_$36)} {:identity }( Lit(x_$36) == x_$36 )))) && ((forall  x_$37 : NameFamily :: {Lit(x_$37)} {:identity }( Lit(x_$37) == x_$37 )))) && ((forall  x_$38 : Field (Boolean)  :: {Lit(x_$38)} {:identity }( Lit(x_$38) == x_$38 )))) && ((forall  x_$39 : [BoxType]BoxType :: {Lit(x_$39)} {:identity }( Lit(x_$39) == x_$39 )))) && ((forall  x_$40 : Field (ref)  :: {Lit(x_$40)} {:identity }( Lit(x_$40) == x_$40 )))) && ((forall  x_$41 : LayerType :: {Lit(x_$41)} {:identity }( Lit(x_$41) == x_$41 )))) && ((forall  x_$42 : <v0>[ref,Field (v0) ]Boolean :: {Lit(x_$42)} {:identity }( Lit(x_$42) == x_$42 )));
	assume ((((((((((((((((((forall  x_$0_$0 : Boolean :: {$Box(Lit(x_$0_$0))} ( $Box(Lit(x_$0_$0)) == Lit($Box(x_$0_$0)) ))) && ((forall  x_$0_$1 : BoxType :: {$Box(Lit(x_$0_$1))} ( $Box(Lit(x_$0_$1)) == Lit($Box(x_$0_$1)) )))) && ((forall  x_$0_$2 : Integer :: {$Box(Lit(x_$0_$2))} ( $Box(Lit(x_$0_$2)) == Lit($Box(x_$0_$2)) )))) && ((forall  x_$0_$3 : Seq (ref)  :: {$Box(Lit(x_$0_$3))} ( $Box(Lit(x_$0_$3)) == Lit($Box(x_$0_$3)) )))) && ((forall  x_$0_$4 : ref :: {$Box(Lit(x_$0_$4))} ( $Box(Lit(x_$0_$4)) == Lit($Box(x_$0_$4)) )))) && ((forall  x_$0_$5 : Seq (BoxType)  :: {$Box(Lit(x_$0_$5))} ( $Box(Lit(x_$0_$5)) == Lit($Box(x_$0_$5)) )))) && ((forall  x_$0_$6 : HeapType :: {$Box(Lit(x_$0_$6))} ( $Box(Lit(x_$0_$6)) == Lit($Box(x_$0_$6)) )))) && ((forall  x_$0_$7 : Field (BoxType)  :: {$Box(Lit(x_$0_$7))} ( $Box(Lit(x_$0_$7)) == Lit($Box(x_$0_$7)) )))) && ((forall  x_$0_$8 : DatatypeType :: {$Box(Lit(x_$0_$8))} ( $Box(Lit(x_$0_$8)) == Lit($Box(x_$0_$8)) )))) && ((forall  x_$0_$9 : Set (BoxType)  :: {$Box(Lit(x_$0_$9))} ( $Box(Lit(x_$0_$9)) == Lit($Box(x_$0_$9)) )))) && ((forall  x_$0_$10 : Map (BoxType) (BoxType)  :: {$Box(Lit(x_$0_$10))} ( $Box(Lit(x_$0_$10)) == Lit($Box(x_$0_$10)) )))) && ((forall  x_$0_$11 : ClassName :: {$Box(Lit(x_$0_$11))} ( $Box(Lit(x_$0_$11)) == Lit($Box(x_$0_$11)) )))) && ((forall  x_$0_$12 : NameFamily :: {$Box(Lit(x_$0_$12))} ( $Box(Lit(x_$0_$12)) == Lit($Box(x_$0_$12)) )))) && ((forall  x_$0_$13 : Field (Boolean)  :: {$Box(Lit(x_$0_$13))} ( $Box(Lit(x_$0_$13)) == Lit($Box(x_$0_$13)) )))) && ((forall  x_$0_$14 : [BoxType]BoxType :: {$Box(Lit(x_$0_$14))} ( $Box(Lit(x_$0_$14)) == Lit($Box(x_$0_$14)) )))) && ((forall  x_$0_$15 : Field (ref)  :: {$Box(Lit(x_$0_$15))} ( $Box(Lit(x_$0_$15)) == Lit($Box(x_$0_$15)) )))) && ((forall  x_$0_$16 : LayerType :: {$Box(Lit(x_$0_$16))} ( $Box(Lit(x_$0_$16)) == Lit($Box(x_$0_$16)) )))) && ((forall  x_$0_$17 : <v0>[ref,Field (v0) ]Boolean :: {$Box(Lit(x_$0_$17))} ( $Box(Lit(x_$0_$17)) == Lit($Box(x_$0_$17)) )));
	assume (forall  s_$34 : Set (BoxType)  :: {Set#Card(s_$34)} ( 0 <= Set#Card(s_$34) ));
	assume (forall  o_$22 : BoxType :: {(Set#Empty() : Set (BoxType) )[o_$22]} ( !(Set#Empty() : Set (BoxType) )[o_$22] ));
	assume (forall  s_$0_$0 : Set (BoxType)  :: {Set#Card(s_$0_$0)} ( ((Set#Card(s_$0_$0) == 0) <==> (s_$0_$0 == (Set#Empty() : Set (BoxType) ))) && ((!(Set#Card(s_$0_$0) == 0)) ==> ((exists  x_$1_$1 : BoxType :: ( s_$0_$0[x_$1_$1] )))) ));
	assume (forall  r_$1_$0 : BoxType :: {Set#Singleton(r_$1_$0)} ( Set#Singleton(r_$1_$0)[r_$1_$0] ));
	assume (forall  r_$2_$0 : BoxType, o_$0_$0 : BoxType :: {Set#Singleton(r_$2_$0)[o_$0_$0]} ( Set#Singleton(r_$2_$0)[o_$0_$0] <==> (r_$2_$0 == o_$0_$0) ));
	assume (forall  r_$3_$0 : BoxType :: {Set#Card(Set#Singleton(r_$3_$0))} ( Set#Card(Set#Singleton(r_$3_$0)) == 1 ));
	assume (forall  a_$55 : Set (BoxType) , x_$2_$0 : BoxType, o_$1_$0 : BoxType :: {Set#UnionOne(a_$55,x_$2_$0)[o_$1_$0]} ( Set#UnionOne(a_$55,x_$2_$0)[o_$1_$0] <==> ((o_$1_$0 == x_$2_$0) || a_$55[o_$1_$0]) ));
	assume (forall  a_$0_$0 : Set (BoxType) , x_$3_$0 : BoxType :: {Set#UnionOne(a_$0_$0,x_$3_$0)} ( Set#UnionOne(a_$0_$0,x_$3_$0)[x_$3_$0] ));
	assume (forall  a_$1_$0 : Set (BoxType) , x_$4_$0 : BoxType, y_$6 : BoxType :: {Set#UnionOne(a_$1_$0,x_$4_$0),a_$1_$0[y_$6]} ( a_$1_$0[y_$6] ==> Set#UnionOne(a_$1_$0,x_$4_$0)[y_$6] ));
	assume (forall  a_$2_$0 : Set (BoxType) , x_$5_$0 : BoxType :: {Set#Card(Set#UnionOne(a_$2_$0,x_$5_$0))} ( a_$2_$0[x_$5_$0] ==> (Set#Card(Set#UnionOne(a_$2_$0,x_$5_$0)) == Set#Card(a_$2_$0)) ));
	assume (forall  a_$3_$0 : Set (BoxType) , x_$6_$0 : BoxType :: {Set#Card(Set#UnionOne(a_$3_$0,x_$6_$0))} ( (!a_$3_$0[x_$6_$0]) ==> (Set#Card(Set#UnionOne(a_$3_$0,x_$6_$0)) == (Set#Card(a_$3_$0) + 1)) ));
	assume (forall  a_$4_$0 : Set (BoxType) , b_$51 : Set (BoxType) , o_$2_$0 : BoxType :: {Set#Union(a_$4_$0,b_$51)[o_$2_$0]} ( Set#Union(a_$4_$0,b_$51)[o_$2_$0] <==> (a_$4_$0[o_$2_$0] || b_$51[o_$2_$0]) ));
	assume (forall  a_$5_$0 : Set (BoxType) , b_$0_$0 : Set (BoxType) , y_$0_$0 : BoxType :: {Set#Union(a_$5_$0,b_$0_$0),a_$5_$0[y_$0_$0]} ( a_$5_$0[y_$0_$0] ==> Set#Union(a_$5_$0,b_$0_$0)[y_$0_$0] ));
	assume (forall  a_$6_$0 : Set (BoxType) , b_$1_$0 : Set (BoxType) , y_$1_$0 : BoxType :: {Set#Union(a_$6_$0,b_$1_$0),b_$1_$0[y_$1_$0]} ( b_$1_$0[y_$1_$0] ==> Set#Union(a_$6_$0,b_$1_$0)[y_$1_$0] ));
	assume (forall  a_$7_$0 : Set (BoxType) , b_$2_$0 : Set (BoxType)  :: {Set#Union(a_$7_$0,b_$2_$0)} ( Set#Disjoint(a_$7_$0,b_$2_$0) ==> ((Set#Difference(Set#Union(a_$7_$0,b_$2_$0),a_$7_$0) == b_$2_$0) && (Set#Difference(Set#Union(a_$7_$0,b_$2_$0),b_$2_$0) == a_$7_$0)) ));
	assume (forall  a_$8_$0 : Set (BoxType) , b_$3_$0 : Set (BoxType) , o_$3_$0 : BoxType :: {Set#Intersection(a_$8_$0,b_$3_$0)[o_$3_$0]} ( Set#Intersection(a_$8_$0,b_$3_$0)[o_$3_$0] <==> (a_$8_$0[o_$3_$0] && b_$3_$0[o_$3_$0]) ));
	assume (forall  a_$9_$0 : Set (BoxType) , b_$4_$0 : Set (BoxType)  :: {Set#Union(Set#Union(a_$9_$0,b_$4_$0),b_$4_$0)} ( Set#Union(Set#Union(a_$9_$0,b_$4_$0),b_$4_$0) == Set#Union(a_$9_$0,b_$4_$0) ));
	assume (forall  a_$10_$0 : Set (BoxType) , b_$5_$0 : Set (BoxType)  :: {Set#Union(a_$10_$0,Set#Union(a_$10_$0,b_$5_$0))} ( Set#Union(a_$10_$0,Set#Union(a_$10_$0,b_$5_$0)) == Set#Union(a_$10_$0,b_$5_$0) ));
	assume (forall  a_$11_$0 : Set (BoxType) , b_$6_$0 : Set (BoxType)  :: {Set#Intersection(Set#Intersection(a_$11_$0,b_$6_$0),b_$6_$0)} ( Set#Intersection(Set#Intersection(a_$11_$0,b_$6_$0),b_$6_$0) == Set#Intersection(a_$11_$0,b_$6_$0) ));
	assume (forall  a_$12_$0 : Set (BoxType) , b_$7_$0 : Set (BoxType)  :: {Set#Intersection(a_$12_$0,Set#Intersection(a_$12_$0,b_$7_$0))} ( Set#Intersection(a_$12_$0,Set#Intersection(a_$12_$0,b_$7_$0)) == Set#Intersection(a_$12_$0,b_$7_$0) ));
	assume (forall  a_$13_$0 : Set (BoxType) , b_$8_$0 : Set (BoxType)  :: {Set#Card(Set#Union(a_$13_$0,b_$8_$0))} {Set#Card(Set#Intersection(a_$13_$0,b_$8_$0))} ( (Set#Card(Set#Union(a_$13_$0,b_$8_$0)) + Set#Card(Set#Intersection(a_$13_$0,b_$8_$0))) == (Set#Card(a_$13_$0) + Set#Card(b_$8_$0)) ));
	assume (forall  a_$14_$0 : Set (BoxType) , b_$9_$0 : Set (BoxType) , o_$4_$0 : BoxType :: {Set#Difference(a_$14_$0,b_$9_$0)[o_$4_$0]} ( Set#Difference(a_$14_$0,b_$9_$0)[o_$4_$0] <==> (a_$14_$0[o_$4_$0] && (!b_$9_$0[o_$4_$0])) ));
	assume (forall  a_$15_$0 : Set (BoxType) , b_$10_$0 : Set (BoxType) , y_$2_$0 : BoxType :: {Set#Difference(a_$15_$0,b_$10_$0),b_$10_$0[y_$2_$0]} ( b_$10_$0[y_$2_$0] ==> (!Set#Difference(a_$15_$0,b_$10_$0)[y_$2_$0]) ));
	assume (forall  a_$16_$0 : Set (BoxType) , b_$11_$0 : Set (BoxType)  :: {Set#Card(Set#Difference(a_$16_$0,b_$11_$0))} ( (((Set#Card(Set#Difference(a_$16_$0,b_$11_$0)) + Set#Card(Set#Difference(b_$11_$0,a_$16_$0))) + Set#Card(Set#Intersection(a_$16_$0,b_$11_$0))) == Set#Card(Set#Union(a_$16_$0,b_$11_$0))) && (Set#Card(Set#Difference(a_$16_$0,b_$11_$0)) == (Set#Card(a_$16_$0) - Set#Card(Set#Intersection(a_$16_$0,b_$11_$0)))) ));
	assume (forall  a_$17_$0 : Set (BoxType) , b_$12_$0 : Set (BoxType)  :: {Set#Subset(a_$17_$0,b_$12_$0)} ( Set#Subset(a_$17_$0,b_$12_$0) <==> ((forall  o_$5_$1 : BoxType :: {a_$17_$0[o_$5_$1]} {b_$12_$0[o_$5_$1]} ( a_$17_$0[o_$5_$1] ==> b_$12_$0[o_$5_$1] ))) ));
	assume (forall  a_$18_$0 : Set (BoxType) , b_$13_$0 : Set (BoxType)  :: {Set#Equal(a_$18_$0,b_$13_$0)} ( Set#Equal(a_$18_$0,b_$13_$0) <==> ((forall  o_$6_$1 : BoxType :: {a_$18_$0[o_$6_$1]} {b_$13_$0[o_$6_$1]} ( a_$18_$0[o_$6_$1] <==> b_$13_$0[o_$6_$1] ))) ));
	assume (forall  a_$19_$0 : Set (BoxType) , b_$14_$0 : Set (BoxType)  :: {Set#Equal(a_$19_$0,b_$14_$0)} ( Set#Equal(a_$19_$0,b_$14_$0) ==> (a_$19_$0 == b_$14_$0) ));
	assume (forall  a_$20_$0 : Set (BoxType) , b_$15_$0 : Set (BoxType)  :: {Set#Disjoint(a_$20_$0,b_$15_$0)} ( Set#Disjoint(a_$20_$0,b_$15_$0) <==> ((forall  o_$7_$1 : BoxType :: {a_$20_$0[o_$7_$1]} {b_$15_$0[o_$7_$1]} ( (!a_$20_$0[o_$7_$1]) || (!b_$15_$0[o_$7_$1]) ))) ));
	assume (forall  a_$21 : Integer, b_$16 : Integer :: {Math#min(a_$21,b_$16)} ( (a_$21 <= b_$16) <==> (Math#min(a_$21,b_$16) == a_$21) ));
	assume (forall  a_$22 : Integer, b_$17 : Integer :: {Math#min(a_$22,b_$17)} ( (b_$17 <= a_$22) <==> (Math#min(a_$22,b_$17) == b_$17) ));
	assume (forall  a_$23 : Integer, b_$18 : Integer :: {Math#min(a_$23,b_$18)} ( (Math#min(a_$23,b_$18) == a_$23) || (Math#min(a_$23,b_$18) == b_$18) ));
	assume (forall  a_$24 : Integer :: {Math#clip(a_$24)} ( (0 <= a_$24) ==> (Math#clip(a_$24) == a_$24) ));
	assume (forall  a_$25 : Integer :: {Math#clip(a_$25)} ( (a_$25 < 0) ==> (Math#clip(a_$25) == 0) ));
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume true;
	assume ((forall  s_$10_$0 : Seq (BoxType)  :: {Seq#Length(s_$10_$0)} ( 0 <= Seq#Length(s_$10_$0) ))) && ((forall  s_$10_$1 : Seq (ref)  :: {Seq#Length(s_$10_$1)} ( 0 <= Seq#Length(s_$10_$1) )));
	assume (Seq#Length((Seq#Empty() : Seq (BoxType) )) == 0) && (Seq#Length((Seq#Empty() : Seq (ref) )) == 0);
	assume ((forall  s_$11_$0 : Seq (BoxType)  :: {Seq#Length(s_$11_$0)} ( (Seq#Length(s_$11_$0) == 0) ==> (s_$11_$0 == (Seq#Empty() : Seq (BoxType) )) ))) && ((forall  s_$11_$1 : Seq (ref)  :: {Seq#Length(s_$11_$1)} ( (Seq#Length(s_$11_$1) == 0) ==> (s_$11_$1 == (Seq#Empty() : Seq (ref) )) )));
	assume ((forall  t_$4 : BoxType :: {Seq#Length(Seq#Singleton(t_$4))} ( Seq#Length(Seq#Singleton(t_$4)) == 1 ))) && ((forall  t_$5 : ref :: {Seq#Length(Seq#Singleton(t_$5))} ( Seq#Length(Seq#Singleton(t_$5)) == 1 )));
	assume ((forall  s_$12_$0 : Seq (BoxType) , v_$2_$0 : BoxType :: {Seq#Length(Seq#Build(s_$12_$0,v_$2_$0))} ( Seq#Length(Seq#Build(s_$12_$0,v_$2_$0)) == (1 + Seq#Length(s_$12_$0)) ))) && ((forall  s_$12_$1 : Seq (ref) , v_$2_$1 : ref :: {Seq#Length(Seq#Build(s_$12_$1,v_$2_$1))} ( Seq#Length(Seq#Build(s_$12_$1,v_$2_$1)) == (1 + Seq#Length(s_$12_$1)) )));
	assume ((forall  s_$13_$0 : Seq (BoxType) , i_$1_$0 : Integer, v_$3_$0 : BoxType :: {Seq#Index(Seq#Build(s_$13_$0,v_$3_$0),i_$1_$0)} ( ((i_$1_$0 == Seq#Length(s_$13_$0)) ==> (Seq#Index(Seq#Build(s_$13_$0,v_$3_$0),i_$1_$0) == v_$3_$0)) && ((!(i_$1_$0 == Seq#Length(s_$13_$0))) ==> (Seq#Index(Seq#Build(s_$13_$0,v_$3_$0),i_$1_$0) == Seq#Index(s_$13_$0,i_$1_$0))) ))) && ((forall  s_$13_$1 : Seq (ref) , i_$1_$1 : Integer, v_$3_$1 : ref :: {Seq#Index(Seq#Build(s_$13_$1,v_$3_$1),i_$1_$1)} ( ((i_$1_$1 == Seq#Length(s_$13_$1)) ==> (Seq#Index(Seq#Build(s_$13_$1,v_$3_$1),i_$1_$1) == v_$3_$1)) && ((!(i_$1_$1 == Seq#Length(s_$13_$1))) ==> (Seq#Index(Seq#Build(s_$13_$1,v_$3_$1),i_$1_$1) == Seq#Index(s_$13_$1,i_$1_$1))) )));
	assume ((forall  s0_$4 : Seq (BoxType) , s1_$4 : Seq (BoxType)  :: {Seq#Length(Seq#Append(s0_$4,s1_$4))} ( Seq#Length(Seq#Append(s0_$4,s1_$4)) == (Seq#Length(s0_$4) + Seq#Length(s1_$4)) ))) && ((forall  s0_$5 : Seq (ref) , s1_$5 : Seq (ref)  :: {Seq#Length(Seq#Append(s0_$5,s1_$5))} ( Seq#Length(Seq#Append(s0_$5,s1_$5)) == (Seq#Length(s0_$5) + Seq#Length(s1_$5)) )));
	assume ((forall  t_$0_$0 : BoxType :: {Seq#Index(Seq#Singleton(t_$0_$0),0)} ( Seq#Index(Seq#Singleton(t_$0_$0),0) == t_$0_$0 ))) && ((forall  t_$0_$1 : ref :: {Seq#Index(Seq#Singleton(t_$0_$1),0)} ( Seq#Index(Seq#Singleton(t_$0_$1),0) == t_$0_$1 )));
	assume ((forall  s0_$0_$0 : Seq (BoxType) , s1_$0_$0 : Seq (BoxType) , n_$0_$0 : Integer :: {Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$0_$0)} ( ((n_$0_$0 < Seq#Length(s0_$0_$0)) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$0_$0) == Seq#Index(s0_$0_$0,n_$0_$0))) && ((Seq#Length(s0_$0_$0) <= n_$0_$0) ==> (Seq#Index(Seq#Append(s0_$0_$0,s1_$0_$0),n_$0_$0) == Seq#Index(s1_$0_$0,n_$0_$0 - Seq#Length(s0_$0_$0)))) ))) && ((forall  s0_$0_$1 : Seq (ref) , s1_$0_$1 : Seq (ref) , n_$0_$1 : Integer :: {Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$0_$1)} ( ((n_$0_$1 < Seq#Length(s0_$0_$1)) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$0_$1) == Seq#Index(s0_$0_$1,n_$0_$1))) && ((Seq#Length(s0_$0_$1) <= n_$0_$1) ==> (Seq#Index(Seq#Append(s0_$0_$1,s1_$0_$1),n_$0_$1) == Seq#Index(s1_$0_$1,n_$0_$1 - Seq#Length(s0_$0_$1)))) )));
	assume ((forall  s_$14_$0 : Seq (BoxType) , i_$2_$0 : Integer, v_$4_$0 : BoxType :: {Seq#Length(Seq#Update(s_$14_$0,i_$2_$0,v_$4_$0))} ( ((0 <= i_$2_$0) && (i_$2_$0 < Seq#Length(s_$14_$0))) ==> (Seq#Length(Seq#Update(s_$14_$0,i_$2_$0,v_$4_$0)) == Seq#Length(s_$14_$0)) ))) && ((forall  s_$14_$1 : Seq (ref) , i_$2_$1 : Integer, v_$4_$1 : ref :: {Seq#Length(Seq#Update(s_$14_$1,i_$2_$1,v_$4_$1))} ( ((0 <= i_$2_$1) && (i_$2_$1 < Seq#Length(s_$14_$1))) ==> (Seq#Length(Seq#Update(s_$14_$1,i_$2_$1,v_$4_$1)) == Seq#Length(s_$14_$1)) )));
	assume ((forall  s_$15_$0 : Seq (BoxType) , i_$3_$0 : Integer, v_$5_$0 : BoxType, n_$1_$0 : Integer :: {Seq#Index(Seq#Update(s_$15_$0,i_$3_$0,v_$5_$0),n_$1_$0)} ( ((0 <= n_$1_$0) && (n_$1_$0 < Seq#Length(s_$15_$0))) ==> (((i_$3_$0 == n_$1_$0) ==> (Seq#Index(Seq#Update(s_$15_$0,i_$3_$0,v_$5_$0),n_$1_$0) == v_$5_$0)) && ((!(i_$3_$0 == n_$1_$0)) ==> (Seq#Index(Seq#Update(s_$15_$0,i_$3_$0,v_$5_$0),n_$1_$0) == Seq#Index(s_$15_$0,n_$1_$0)))) ))) && ((forall  s_$15_$1 : Seq (ref) , i_$3_$1 : Integer, v_$5_$1 : ref, n_$1_$1 : Integer :: {Seq#Index(Seq#Update(s_$15_$1,i_$3_$1,v_$5_$1),n_$1_$1)} ( ((0 <= n_$1_$1) && (n_$1_$1 < Seq#Length(s_$15_$1))) ==> (((i_$3_$1 == n_$1_$1) ==> (Seq#Index(Seq#Update(s_$15_$1,i_$3_$1,v_$5_$1),n_$1_$1) == v_$5_$1)) && ((!(i_$3_$1 == n_$1_$1)) ==> (Seq#Index(Seq#Update(s_$15_$1,i_$3_$1,v_$5_$1),n_$1_$1) == Seq#Index(s_$15_$1,n_$1_$1)))) )));
	assume ((forall  s_$16_$0 : Seq (BoxType) , x_$16_$0 : BoxType :: {Seq#Contains(s_$16_$0,x_$16_$0)} ( Seq#Contains(s_$16_$0,x_$16_$0) <==> ((exists  i_$4_$1 : Integer :: {Seq#Index(s_$16_$0,i_$4_$1)} ( ((0 <= i_$4_$1) && (i_$4_$1 < Seq#Length(s_$16_$0))) && (Seq#Index(s_$16_$0,i_$4_$1) == x_$16_$0) ))) ))) && ((forall  s_$16_$1 : Seq (ref) , x_$16_$1 : ref :: {Seq#Contains(s_$16_$1,x_$16_$1)} ( Seq#Contains(s_$16_$1,x_$16_$1) <==> ((exists  i_$4_$3 : Integer :: {Seq#Index(s_$16_$1,i_$4_$3)} ( ((0 <= i_$4_$3) && (i_$4_$3 < Seq#Length(s_$16_$1))) && (Seq#Index(s_$16_$1,i_$4_$3) == x_$16_$1) ))) )));
	assume (forall  x_$17 : ref :: {Seq#Contains((Seq#Empty() : Seq (ref) ),x_$17)} ( !Seq#Contains((Seq#Empty() : Seq (ref) ),x_$17) ));
	assume ((forall  s0_$1_$0 : Seq (BoxType) , s1_$1_$0 : Seq (BoxType) , x_$18_$0 : BoxType :: {Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$18_$0)} ( Seq#Contains(Seq#Append(s0_$1_$0,s1_$1_$0),x_$18_$0) <==> (Seq#Contains(s0_$1_$0,x_$18_$0) || Seq#Contains(s1_$1_$0,x_$18_$0)) ))) && ((forall  s0_$1_$1 : Seq (ref) , s1_$1_$1 : Seq (ref) , x_$18_$1 : ref :: {Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$18_$1)} ( Seq#Contains(Seq#Append(s0_$1_$1,s1_$1_$1),x_$18_$1) <==> (Seq#Contains(s0_$1_$1,x_$18_$1) || Seq#Contains(s1_$1_$1,x_$18_$1)) )));
	assume ((forall  s_$17_$0 : Seq (BoxType) , v_$6_$0 : BoxType, x_$19_$0 : BoxType :: {Seq#Contains(Seq#Build(s_$17_$0,v_$6_$0),x_$19_$0)} ( Seq#Contains(Seq#Build(s_$17_$0,v_$6_$0),x_$19_$0) <==> ((v_$6_$0 == x_$19_$0) || Seq#Contains(s_$17_$0,x_$19_$0)) ))) && ((forall  s_$17_$1 : Seq (ref) , v_$6_$1 : ref, x_$19_$1 : ref :: {Seq#Contains(Seq#Build(s_$17_$1,v_$6_$1),x_$19_$1)} ( Seq#Contains(Seq#Build(s_$17_$1,v_$6_$1),x_$19_$1) <==> ((v_$6_$1 == x_$19_$1) || Seq#Contains(s_$17_$1,x_$19_$1)) )));
	assume ((forall  s_$18_$0 : Seq (BoxType) , n_$2_$0 : Integer, x_$20_$0 : BoxType :: {Seq#Contains(Seq#Take(s_$18_$0,n_$2_$0),x_$20_$0)} ( Seq#Contains(Seq#Take(s_$18_$0,n_$2_$0),x_$20_$0) <==> ((exists  i_$5_$1 : Integer :: {Seq#Index(s_$18_$0,i_$5_$1)} ( (((0 <= i_$5_$1) && (i_$5_$1 < n_$2_$0)) && (i_$5_$1 < Seq#Length(s_$18_$0))) && (Seq#Index(s_$18_$0,i_$5_$1) == x_$20_$0) ))) ))) && ((forall  s_$18_$1 : Seq (ref) , n_$2_$1 : Integer, x_$20_$1 : ref :: {Seq#Contains(Seq#Take(s_$18_$1,n_$2_$1),x_$20_$1)} ( Seq#Contains(Seq#Take(s_$18_$1,n_$2_$1),x_$20_$1) <==> ((exists  i_$5_$3 : Integer :: {Seq#Index(s_$18_$1,i_$5_$3)} ( (((0 <= i_$5_$3) && (i_$5_$3 < n_$2_$1)) && (i_$5_$3 < Seq#Length(s_$18_$1))) && (Seq#Index(s_$18_$1,i_$5_$3) == x_$20_$1) ))) )));
	assume ((forall  s_$19_$0 : Seq (BoxType) , n_$3_$0 : Integer, x_$21_$0 : BoxType :: {Seq#Contains(Seq#Drop(s_$19_$0,n_$3_$0),x_$21_$0)} ( Seq#Contains(Seq#Drop(s_$19_$0,n_$3_$0),x_$21_$0) <==> ((exists  i_$6_$1 : Integer :: {Seq#Index(s_$19_$0,i_$6_$1)} ( (((0 <= n_$3_$0) && (n_$3_$0 <= i_$6_$1)) && (i_$6_$1 < Seq#Length(s_$19_$0))) && (Seq#Index(s_$19_$0,i_$6_$1) == x_$21_$0) ))) ))) && ((forall  s_$19_$1 : Seq (ref) , n_$3_$1 : Integer, x_$21_$1 : ref :: {Seq#Contains(Seq#Drop(s_$19_$1,n_$3_$1),x_$21_$1)} ( Seq#Contains(Seq#Drop(s_$19_$1,n_$3_$1),x_$21_$1) <==> ((exists  i_$6_$3 : Integer :: {Seq#Index(s_$19_$1,i_$6_$3)} ( (((0 <= n_$3_$1) && (n_$3_$1 <= i_$6_$3)) && (i_$6_$3 < Seq#Length(s_$19_$1))) && (Seq#Index(s_$19_$1,i_$6_$3) == x_$21_$1) ))) )));
	assume ((forall  s0_$2_$0 : Seq (BoxType) , s1_$2_$0 : Seq (BoxType)  :: {Seq#Equal(s0_$2_$0,s1_$2_$0)} ( Seq#Equal(s0_$2_$0,s1_$2_$0) <==> ((Seq#Length(s0_$2_$0) == Seq#Length(s1_$2_$0)) && ((forall  j_$5 : Integer :: {Seq#Index(s0_$2_$0,j_$5)} {Seq#Index(s1_$2_$0,j_$5)} ( ((0 <= j_$5) && (j_$5 < Seq#Length(s0_$2_$0))) ==> (Seq#Index(s0_$2_$0,j_$5) == Seq#Index(s1_$2_$0,j_$5)) )))) ))) && ((forall  s0_$2_$1 : Seq (ref) , s1_$2_$1 : Seq (ref)  :: {Seq#Equal(s0_$2_$1,s1_$2_$1)} ( Seq#Equal(s0_$2_$1,s1_$2_$1) <==> ((Seq#Length(s0_$2_$1) == Seq#Length(s1_$2_$1)) && ((forall  j_$7 : Integer :: {Seq#Index(s0_$2_$1,j_$7)} {Seq#Index(s1_$2_$1,j_$7)} ( ((0 <= j_$7) && (j_$7 < Seq#Length(s0_$2_$1))) ==> (Seq#Index(s0_$2_$1,j_$7) == Seq#Index(s1_$2_$1,j_$7)) )))) )));
	assume ((forall  a_$45_$0 : Seq (BoxType) , b_$32_$0 : Seq (BoxType)  :: {Seq#Equal(a_$45_$0,b_$32_$0)} ( Seq#Equal(a_$45_$0,b_$32_$0) ==> (a_$45_$0 == b_$32_$0) ))) && ((forall  a_$45_$1 : Seq (ref) , b_$32_$1 : Seq (ref)  :: {Seq#Equal(a_$45_$1,b_$32_$1)} ( Seq#Equal(a_$45_$1,b_$32_$1) ==> (a_$45_$1 == b_$32_$1) )));
	assume ((forall  s_$20_$0 : Seq (BoxType) , n_$5_$0 : Integer :: {Seq#Length(Seq#Take(s_$20_$0,n_$5_$0))} ( (0 <= n_$5_$0) ==> (((n_$5_$0 <= Seq#Length(s_$20_$0)) ==> (Seq#Length(Seq#Take(s_$20_$0,n_$5_$0)) == n_$5_$0)) && ((Seq#Length(s_$20_$0) < n_$5_$0) ==> (Seq#Length(Seq#Take(s_$20_$0,n_$5_$0)) == Seq#Length(s_$20_$0)))) ))) && ((forall  s_$20_$1 : Seq (ref) , n_$5_$1 : Integer :: {Seq#Length(Seq#Take(s_$20_$1,n_$5_$1))} ( (0 <= n_$5_$1) ==> (((n_$5_$1 <= Seq#Length(s_$20_$1)) ==> (Seq#Length(Seq#Take(s_$20_$1,n_$5_$1)) == n_$5_$1)) && ((Seq#Length(s_$20_$1) < n_$5_$1) ==> (Seq#Length(Seq#Take(s_$20_$1,n_$5_$1)) == Seq#Length(s_$20_$1)))) )));
	assume ((forall  s_$21_$0 : Seq (BoxType) , n_$6_$0 : Integer, j_$1_$0 : Integer :: {Seq#Index(Seq#Take(s_$21_$0,n_$6_$0),j_$1_$0)} {:weight  25}( (((0 <= j_$1_$0) && (j_$1_$0 < n_$6_$0)) && (j_$1_$0 < Seq#Length(s_$21_$0))) ==> (Seq#Index(Seq#Take(s_$21_$0,n_$6_$0),j_$1_$0) == Seq#Index(s_$21_$0,j_$1_$0)) ))) && ((forall  s_$21_$1 : Seq (ref) , n_$6_$1 : Integer, j_$1_$1 : Integer :: {Seq#Index(Seq#Take(s_$21_$1,n_$6_$1),j_$1_$1)} {:weight  25}( (((0 <= j_$1_$1) && (j_$1_$1 < n_$6_$1)) && (j_$1_$1 < Seq#Length(s_$21_$1))) ==> (Seq#Index(Seq#Take(s_$21_$1,n_$6_$1),j_$1_$1) == Seq#Index(s_$21_$1,j_$1_$1)) )));
	assume ((forall  s_$22_$0 : Seq (BoxType) , n_$7_$0 : Integer :: {Seq#Length(Seq#Drop(s_$22_$0,n_$7_$0))} ( (0 <= n_$7_$0) ==> (((n_$7_$0 <= Seq#Length(s_$22_$0)) ==> (Seq#Length(Seq#Drop(s_$22_$0,n_$7_$0)) == (Seq#Length(s_$22_$0) - n_$7_$0))) && ((Seq#Length(s_$22_$0) < n_$7_$0) ==> (Seq#Length(Seq#Drop(s_$22_$0,n_$7_$0)) == 0))) ))) && ((forall  s_$22_$1 : Seq (ref) , n_$7_$1 : Integer :: {Seq#Length(Seq#Drop(s_$22_$1,n_$7_$1))} ( (0 <= n_$7_$1) ==> (((n_$7_$1 <= Seq#Length(s_$22_$1)) ==> (Seq#Length(Seq#Drop(s_$22_$1,n_$7_$1)) == (Seq#Length(s_$22_$1) - n_$7_$1))) && ((Seq#Length(s_$22_$1) < n_$7_$1) ==> (Seq#Length(Seq#Drop(s_$22_$1,n_$7_$1)) == 0))) )));
	assume ((forall  s_$23_$0 : Seq (BoxType) , n_$8_$0 : Integer, j_$2_$0 : Integer :: {Seq#Index(Seq#Drop(s_$23_$0,n_$8_$0),j_$2_$0)} {:weight  25}( (((0 <= n_$8_$0) && (0 <= j_$2_$0)) && (j_$2_$0 < (Seq#Length(s_$23_$0) - n_$8_$0))) ==> (Seq#Index(Seq#Drop(s_$23_$0,n_$8_$0),j_$2_$0) == Seq#Index(s_$23_$0,j_$2_$0 + n_$8_$0)) ))) && ((forall  s_$23_$1 : Seq (ref) , n_$8_$1 : Integer, j_$2_$1 : Integer :: {Seq#Index(Seq#Drop(s_$23_$1,n_$8_$1),j_$2_$1)} {:weight  25}( (((0 <= n_$8_$1) && (0 <= j_$2_$1)) && (j_$2_$1 < (Seq#Length(s_$23_$1) - n_$8_$1))) ==> (Seq#Index(Seq#Drop(s_$23_$1,n_$8_$1),j_$2_$1) == Seq#Index(s_$23_$1,j_$2_$1 + n_$8_$1)) )));
	assume ((forall  s_$24_$0 : Seq (BoxType) , t_$1_$0 : Seq (BoxType)  :: {Seq#Append(s_$24_$0,t_$1_$0)} ( (Seq#Take(Seq#Append(s_$24_$0,t_$1_$0),Seq#Length(s_$24_$0)) == s_$24_$0) && (Seq#Drop(Seq#Append(s_$24_$0,t_$1_$0),Seq#Length(s_$24_$0)) == t_$1_$0) ))) && ((forall  s_$24_$1 : Seq (ref) , t_$1_$1 : Seq (ref)  :: {Seq#Append(s_$24_$1,t_$1_$1)} ( (Seq#Take(Seq#Append(s_$24_$1,t_$1_$1),Seq#Length(s_$24_$1)) == s_$24_$1) && (Seq#Drop(Seq#Append(s_$24_$1,t_$1_$1),Seq#Length(s_$24_$1)) == t_$1_$1) )));
	assume (forall  h : HeapType, a_$46 : ref :: {Seq#Length(Seq#FromArray(h,a_$46))} ( Seq#Length(Seq#FromArray(h,a_$46)) == _System.array.Length(a_$46) ));
	assume (forall  h_$0 : HeapType, a_$47 : ref, i_$7 : Integer :: ( ((0 <= i_$7) && (i_$7 < Seq#Length(Seq#FromArray(h_$0,a_$47)))) ==> (Seq#Index(Seq#FromArray(h_$0,a_$47),i_$7) == h_$0[a_$47,IndexField(i_$7)]) ));
	assume (((forall  h_$1_$0 : HeapType, o_$17_$0 : ref, f_$1_$0 : Field (Boolean) , v_$7_$0 : Boolean, a_$48_$0 : ref :: {Seq#FromArray(h_$1_$0[o_$17_$0,f_$1_$0 := v_$7_$0],a_$48_$0)} ( (!(o_$17_$0 == a_$48_$0)) ==> (Seq#FromArray(h_$1_$0[o_$17_$0,f_$1_$0 := v_$7_$0],a_$48_$0) == Seq#FromArray(h_$1_$0,a_$48_$0)) ))) && ((forall  h_$1_$1 : HeapType, o_$17_$1 : ref, f_$1_$1 : Field (BoxType) , v_$7_$1 : BoxType, a_$48_$1 : ref :: {Seq#FromArray(h_$1_$1[o_$17_$1,f_$1_$1 := v_$7_$1],a_$48_$1)} ( (!(o_$17_$1 == a_$48_$1)) ==> (Seq#FromArray(h_$1_$1[o_$17_$1,f_$1_$1 := v_$7_$1],a_$48_$1) == Seq#FromArray(h_$1_$1,a_$48_$1)) )))) && ((forall  h_$1_$2 : HeapType, o_$17_$2 : ref, f_$1_$2 : Field (ref) , v_$7_$2 : ref, a_$48_$2 : ref :: {Seq#FromArray(h_$1_$2[o_$17_$2,f_$1_$2 := v_$7_$2],a_$48_$2)} ( (!(o_$17_$2 == a_$48_$2)) ==> (Seq#FromArray(h_$1_$2[o_$17_$2,f_$1_$2 := v_$7_$2],a_$48_$2) == Seq#FromArray(h_$1_$2,a_$48_$2)) )));
	assume (forall  h_$2 : HeapType, i_$8 : Integer, v_$8 : BoxType, a_$49 : ref :: {Seq#FromArray(h_$2[a_$49,IndexField(i_$8) := v_$8],a_$49)} ( ((0 <= i_$8) && (i_$8 < _System.array.Length(a_$49))) ==> (Seq#FromArray(h_$2[a_$49,IndexField(i_$8) := v_$8],a_$49) == Seq#Update(Seq#FromArray(h_$2,a_$49),i_$8,v_$8)) ));
	assume ((forall  s_$25_$0 : Seq (BoxType) , i_$9_$0 : Integer, v_$9_$0 : BoxType, n_$9_$0 : Integer :: {Seq#Take(Seq#Update(s_$25_$0,i_$9_$0,v_$9_$0),n_$9_$0)} ( (((0 <= i_$9_$0) && (i_$9_$0 < n_$9_$0)) && (n_$9_$0 <= Seq#Length(s_$25_$0))) ==> (Seq#Take(Seq#Update(s_$25_$0,i_$9_$0,v_$9_$0),n_$9_$0) == Seq#Update(Seq#Take(s_$25_$0,n_$9_$0),i_$9_$0,v_$9_$0)) ))) && ((forall  s_$25_$1 : Seq (ref) , i_$9_$1 : Integer, v_$9_$1 : ref, n_$9_$1 : Integer :: {Seq#Take(Seq#Update(s_$25_$1,i_$9_$1,v_$9_$1),n_$9_$1)} ( (((0 <= i_$9_$1) && (i_$9_$1 < n_$9_$1)) && (n_$9_$1 <= Seq#Length(s_$25_$1))) ==> (Seq#Take(Seq#Update(s_$25_$1,i_$9_$1,v_$9_$1),n_$9_$1) == Seq#Update(Seq#Take(s_$25_$1,n_$9_$1),i_$9_$1,v_$9_$1)) )));
	assume ((forall  s_$26_$0 : Seq (BoxType) , i_$10_$0 : Integer, v_$10_$0 : BoxType, n_$10_$0 : Integer :: {Seq#Take(Seq#Update(s_$26_$0,i_$10_$0,v_$10_$0),n_$10_$0)} ( ((n_$10_$0 <= i_$10_$0) && (i_$10_$0 < Seq#Length(s_$26_$0))) ==> (Seq#Take(Seq#Update(s_$26_$0,i_$10_$0,v_$10_$0),n_$10_$0) == Seq#Take(s_$26_$0,n_$10_$0)) ))) && ((forall  s_$26_$1 : Seq (ref) , i_$10_$1 : Integer, v_$10_$1 : ref, n_$10_$1 : Integer :: {Seq#Take(Seq#Update(s_$26_$1,i_$10_$1,v_$10_$1),n_$10_$1)} ( ((n_$10_$1 <= i_$10_$1) && (i_$10_$1 < Seq#Length(s_$26_$1))) ==> (Seq#Take(Seq#Update(s_$26_$1,i_$10_$1,v_$10_$1),n_$10_$1) == Seq#Take(s_$26_$1,n_$10_$1)) )));
	assume ((forall  s_$27_$0 : Seq (BoxType) , i_$11_$0 : Integer, v_$11_$0 : BoxType, n_$11_$0 : Integer :: {Seq#Drop(Seq#Update(s_$27_$0,i_$11_$0,v_$11_$0),n_$11_$0)} ( (((0 <= n_$11_$0) && (n_$11_$0 <= i_$11_$0)) && (i_$11_$0 < Seq#Length(s_$27_$0))) ==> (Seq#Drop(Seq#Update(s_$27_$0,i_$11_$0,v_$11_$0),n_$11_$0) == Seq#Update(Seq#Drop(s_$27_$0,n_$11_$0),i_$11_$0 - n_$11_$0,v_$11_$0)) ))) && ((forall  s_$27_$1 : Seq (ref) , i_$11_$1 : Integer, v_$11_$1 : ref, n_$11_$1 : Integer :: {Seq#Drop(Seq#Update(s_$27_$1,i_$11_$1,v_$11_$1),n_$11_$1)} ( (((0 <= n_$11_$1) && (n_$11_$1 <= i_$11_$1)) && (i_$11_$1 < Seq#Length(s_$27_$1))) ==> (Seq#Drop(Seq#Update(s_$27_$1,i_$11_$1,v_$11_$1),n_$11_$1) == Seq#Update(Seq#Drop(s_$27_$1,n_$11_$1),i_$11_$1 - n_$11_$1,v_$11_$1)) )));
	assume ((forall  s_$28_$0 : Seq (BoxType) , i_$12_$0 : Integer, v_$12_$0 : BoxType, n_$12_$0 : Integer :: {Seq#Drop(Seq#Update(s_$28_$0,i_$12_$0,v_$12_$0),n_$12_$0)} ( (((0 <= i_$12_$0) && (i_$12_$0 < n_$12_$0)) && (n_$12_$0 < Seq#Length(s_$28_$0))) ==> (Seq#Drop(Seq#Update(s_$28_$0,i_$12_$0,v_$12_$0),n_$12_$0) == Seq#Drop(s_$28_$0,n_$12_$0)) ))) && ((forall  s_$28_$1 : Seq (ref) , i_$12_$1 : Integer, v_$12_$1 : ref, n_$12_$1 : Integer :: {Seq#Drop(Seq#Update(s_$28_$1,i_$12_$1,v_$12_$1),n_$12_$1)} ( (((0 <= i_$12_$1) && (i_$12_$1 < n_$12_$1)) && (n_$12_$1 < Seq#Length(s_$28_$1))) ==> (Seq#Drop(Seq#Update(s_$28_$1,i_$12_$1,v_$12_$1),n_$12_$1) == Seq#Drop(s_$28_$1,n_$12_$1)) )));
	assume (forall  h_$3 : HeapType, a_$50 : ref, n0 : Integer, n1 : Integer :: {Seq#Take(Seq#FromArray(h_$3,a_$50),n0),Seq#Take(Seq#FromArray(h_$3,a_$50),n1)} ( ((((n0 + 1) == n1) && (0 <= n0)) && (n1 <= _System.array.Length(a_$50))) ==> (Seq#Take(Seq#FromArray(h_$3,a_$50),n1) == Seq#Build(Seq#Take(Seq#FromArray(h_$3,a_$50),n0),h_$3[a_$50,IndexField(n0)])) ));
	assume ((forall  s_$29_$0 : Seq (BoxType) , v_$13_$0 : BoxType, n_$13_$0 : Integer :: {Seq#Drop(Seq#Build(s_$29_$0,v_$13_$0),n_$13_$0)} ( ((0 <= n_$13_$0) && (n_$13_$0 <= Seq#Length(s_$29_$0))) ==> (Seq#Drop(Seq#Build(s_$29_$0,v_$13_$0),n_$13_$0) == Seq#Build(Seq#Drop(s_$29_$0,n_$13_$0),v_$13_$0)) ))) && ((forall  s_$29_$1 : Seq (ref) , v_$13_$1 : ref, n_$13_$1 : Integer :: {Seq#Drop(Seq#Build(s_$29_$1,v_$13_$1),n_$13_$1)} ( ((0 <= n_$13_$1) && (n_$13_$1 <= Seq#Length(s_$29_$1))) ==> (Seq#Drop(Seq#Build(s_$29_$1,v_$13_$1),n_$13_$1) == Seq#Build(Seq#Drop(s_$29_$1,n_$13_$1),v_$13_$1)) )));
	assume (forall  s_$30 : Seq (BoxType) , i_$13 : Integer :: {DtRank(($Unbox(Seq#Index(s_$30,i_$13)) : DatatypeType))} ( ((0 <= i_$13) && (i_$13 < Seq#Length(s_$30))) ==> (DtRank(($Unbox(Seq#Index(s_$30,i_$13)) : DatatypeType)) < Seq#Rank(s_$30)) ));
	assume ((forall  s_$31_$0 : Seq (BoxType) , i_$14_$0 : Integer :: {Seq#Rank(Seq#Drop(s_$31_$0,i_$14_$0))} ( ((0 < i_$14_$0) && (i_$14_$0 <= Seq#Length(s_$31_$0))) ==> (Seq#Rank(Seq#Drop(s_$31_$0,i_$14_$0)) < Seq#Rank(s_$31_$0)) ))) && ((forall  s_$31_$1 : Seq (ref) , i_$14_$1 : Integer :: {Seq#Rank(Seq#Drop(s_$31_$1,i_$14_$1))} ( ((0 < i_$14_$1) && (i_$14_$1 <= Seq#Length(s_$31_$1))) ==> (Seq#Rank(Seq#Drop(s_$31_$1,i_$14_$1)) < Seq#Rank(s_$31_$1)) )));
	assume ((forall  s_$32_$0 : Seq (BoxType) , i_$15_$0 : Integer :: {Seq#Rank(Seq#Take(s_$32_$0,i_$15_$0))} ( ((0 <= i_$15_$0) && (i_$15_$0 < Seq#Length(s_$32_$0))) ==> (Seq#Rank(Seq#Take(s_$32_$0,i_$15_$0)) < Seq#Rank(s_$32_$0)) ))) && ((forall  s_$32_$1 : Seq (ref) , i_$15_$1 : Integer :: {Seq#Rank(Seq#Take(s_$32_$1,i_$15_$1))} ( ((0 <= i_$15_$1) && (i_$15_$1 < Seq#Length(s_$32_$1))) ==> (Seq#Rank(Seq#Take(s_$32_$1,i_$15_$1)) < Seq#Rank(s_$32_$1)) )));
	assume ((forall  s_$33_$0 : Seq (BoxType) , i_$16_$0 : Integer, j_$3_$0 : Integer :: {Seq#Rank(Seq#Append(Seq#Take(s_$33_$0,i_$16_$0),Seq#Drop(s_$33_$0,j_$3_$0)))} ( (((0 <= i_$16_$0) && (i_$16_$0 < j_$3_$0)) && (j_$3_$0 <= Seq#Length(s_$33_$0))) ==> (Seq#Rank(Seq#Append(Seq#Take(s_$33_$0,i_$16_$0),Seq#Drop(s_$33_$0,j_$3_$0))) < Seq#Rank(s_$33_$0)) ))) && ((forall  s_$33_$1 : Seq (ref) , i_$16_$1 : Integer, j_$3_$1 : Integer :: {Seq#Rank(Seq#Append(Seq#Take(s_$33_$1,i_$16_$1),Seq#Drop(s_$33_$1,j_$3_$1)))} ( (((0 <= i_$16_$1) && (i_$16_$1 < j_$3_$1)) && (j_$3_$1 <= Seq#Length(s_$33_$1))) ==> (Seq#Rank(Seq#Append(Seq#Take(s_$33_$1,i_$16_$1),Seq#Drop(s_$33_$1,j_$3_$1))) < Seq#Rank(s_$33_$1)) )));
	assume Seq#Take((Seq#Empty() : Seq (BoxType) ),0) == (Seq#Empty() : Seq (BoxType) );
	assume Seq#Drop((Seq#Empty() : Seq (BoxType) ),0) == (Seq#Empty() : Seq (BoxType) );
	assume (forall  m_$7 : Map (BoxType) (BoxType)  :: {Map#Card(m_$7)} ( 0 <= Map#Card(m_$7) ));
	assume (forall  u_$5 : BoxType :: {Map#Domain((Map#Empty() : Map (BoxType) (BoxType) ))[u_$5]} ( !Map#Domain((Map#Empty() : Map (BoxType) (BoxType) ))[u_$5] ));
	assume (forall  m_$0_$0 : Map (BoxType) (BoxType)  :: {Map#Card(m_$0_$0)} ( (Map#Card(m_$0_$0) == 0) <==> (m_$0_$0 == (Map#Empty() : Map (BoxType) (BoxType) )) ));
	assume (forall  a_$51_$0 : [BoxType]Boolean, b_$33_$0 : [BoxType]BoxType :: {Map#Domain(Map#Glue(a_$51_$0,b_$33_$0))} ( Map#Domain(Map#Glue(a_$51_$0,b_$33_$0)) == a_$51_$0 ));
	assume (forall  a_$52_$0 : [BoxType]Boolean, b_$34_$0 : [BoxType]BoxType :: {Map#Elements(Map#Glue(a_$52_$0,b_$34_$0))} ( Map#Elements(Map#Glue(a_$52_$0,b_$34_$0)) == b_$34_$0 ));
	assume (forall  m_$1_$0 : Map (BoxType) (BoxType) , u_$0_$0 : BoxType, u'_$0 : BoxType, v_$14_$0 : BoxType :: {Map#Domain(Map#Build(m_$1_$0,u_$0_$0,v_$14_$0))[u'_$0]} {Map#Elements(Map#Build(m_$1_$0,u_$0_$0,v_$14_$0))[u'_$0]} ( ((u'_$0 == u_$0_$0) ==> (Map#Domain(Map#Build(m_$1_$0,u_$0_$0,v_$14_$0))[u'_$0] && (Map#Elements(Map#Build(m_$1_$0,u_$0_$0,v_$14_$0))[u'_$0] == v_$14_$0))) && ((!(u'_$0 == u_$0_$0)) ==> ((Map#Domain(Map#Build(m_$1_$0,u_$0_$0,v_$14_$0))[u'_$0] <==> Map#Domain(m_$1_$0)[u'_$0]) && (Map#Elements(Map#Build(m_$1_$0,u_$0_$0,v_$14_$0))[u'_$0] == Map#Elements(m_$1_$0)[u'_$0]))) ));
	assume (forall  m_$2_$0 : Map (BoxType) (BoxType) , u_$1_$0 : BoxType, v_$15_$0 : BoxType :: {Map#Card(Map#Build(m_$2_$0,u_$1_$0,v_$15_$0))} ( Map#Domain(m_$2_$0)[u_$1_$0] ==> (Map#Card(Map#Build(m_$2_$0,u_$1_$0,v_$15_$0)) == Map#Card(m_$2_$0)) ));
	assume (forall  m_$3_$0 : Map (BoxType) (BoxType) , u_$2_$0 : BoxType, v_$16_$0 : BoxType :: {Map#Card(Map#Build(m_$3_$0,u_$2_$0,v_$16_$0))} ( (!Map#Domain(m_$3_$0)[u_$2_$0]) ==> (Map#Card(Map#Build(m_$3_$0,u_$2_$0,v_$16_$0)) == (Map#Card(m_$3_$0) + 1)) ));
	assume (forall  m_$4_$0 : Map (BoxType) (BoxType) , m'_$2 : Map (BoxType) (BoxType)  :: {Map#Equal(m_$4_$0,m'_$2)} ( Map#Equal(m_$4_$0,m'_$2) <==> (((forall  u_$3_$1 : BoxType :: ( Map#Domain(m_$4_$0)[u_$3_$1] <==> Map#Domain(m'_$2)[u_$3_$1] ))) && ((forall  u_$4_$1 : BoxType :: ( Map#Domain(m_$4_$0)[u_$4_$1] ==> (Map#Elements(m_$4_$0)[u_$4_$1] == Map#Elements(m'_$2)[u_$4_$1]) )))) ));
	assume (forall  m_$5_$0 : Map (BoxType) (BoxType) , m'_$0_$0 : Map (BoxType) (BoxType)  :: {Map#Equal(m_$5_$0,m'_$0_$0)} ( Map#Equal(m_$5_$0,m'_$0_$0) ==> (m_$5_$0 == m'_$0_$0) ));
	assume ((((((((((((((((((forall  x_$22_$0 : Boolean :: {$Box(x_$22_$0)} ( ($Unbox($Box(x_$22_$0)) : Boolean) == x_$22_$0 ))) && ((forall  x_$22_$1 : BoxType :: {$Box(x_$22_$1)} ( ($Unbox($Box(x_$22_$1)) : BoxType) == x_$22_$1 )))) && ((forall  x_$22_$2 : Integer :: {$Box(x_$22_$2)} ( ($Unbox($Box(x_$22_$2)) : Integer) == x_$22_$2 )))) && ((forall  x_$22_$3 : Seq (ref)  :: {$Box(x_$22_$3)} ( ($Unbox($Box(x_$22_$3)) : Seq (ref) ) == x_$22_$3 )))) && ((forall  x_$22_$4 : ref :: {$Box(x_$22_$4)} ( ($Unbox($Box(x_$22_$4)) : ref) == x_$22_$4 )))) && ((forall  x_$22_$5 : Seq (BoxType)  :: {$Box(x_$22_$5)} ( ($Unbox($Box(x_$22_$5)) : Seq (BoxType) ) == x_$22_$5 )))) && ((forall  x_$22_$6 : HeapType :: {$Box(x_$22_$6)} ( ($Unbox($Box(x_$22_$6)) : HeapType) == x_$22_$6 )))) && ((forall  x_$22_$7 : Field (BoxType)  :: {$Box(x_$22_$7)} ( ($Unbox($Box(x_$22_$7)) : Field (BoxType) ) == x_$22_$7 )))) && ((forall  x_$22_$8 : DatatypeType :: {$Box(x_$22_$8)} ( ($Unbox($Box(x_$22_$8)) : DatatypeType) == x_$22_$8 )))) && ((forall  x_$22_$9 : Set (BoxType)  :: {$Box(x_$22_$9)} ( ($Unbox($Box(x_$22_$9)) : Set (BoxType) ) == x_$22_$9 )))) && ((forall  x_$22_$10 : Map (BoxType) (BoxType)  :: {$Box(x_$22_$10)} ( ($Unbox($Box(x_$22_$10)) : Map (BoxType) (BoxType) ) == x_$22_$10 )))) && ((forall  x_$22_$11 : ClassName :: {$Box(x_$22_$11)} ( ($Unbox($Box(x_$22_$11)) : ClassName) == x_$22_$11 )))) && ((forall  x_$22_$12 : NameFamily :: {$Box(x_$22_$12)} ( ($Unbox($Box(x_$22_$12)) : NameFamily) == x_$22_$12 )))) && ((forall  x_$22_$13 : Field (Boolean)  :: {$Box(x_$22_$13)} ( ($Unbox($Box(x_$22_$13)) : Field (Boolean) ) == x_$22_$13 )))) && ((forall  x_$22_$14 : [BoxType]BoxType :: {$Box(x_$22_$14)} ( ($Unbox($Box(x_$22_$14)) : [BoxType]BoxType) == x_$22_$14 )))) && ((forall  x_$22_$15 : Field (ref)  :: {$Box(x_$22_$15)} ( ($Unbox($Box(x_$22_$15)) : Field (ref) ) == x_$22_$15 )))) && ((forall  x_$22_$16 : LayerType :: {$Box(x_$22_$16)} ( ($Unbox($Box(x_$22_$16)) : LayerType) == x_$22_$16 )))) && ((forall  x_$22_$17 : <v0>[ref,Field (v0) ]Boolean :: {$Box(x_$22_$17)} ( ($Unbox($Box(x_$22_$17)) : <v0>[ref,Field (v0) ]Boolean) == x_$22_$17 )));
	assume (forall  b_$35 : BoxType :: {($Unbox(b_$35) : Integer)} ( $Box(($Unbox(b_$35) : Integer)) == b_$35 ));
	assume (forall  b_$36 : BoxType :: {($Unbox(b_$36) : ref)} ( $Box(($Unbox(b_$36) : ref)) == b_$36 ));
	assume (forall  b_$37 : BoxType :: {($Unbox(b_$37) : [BoxType]Boolean)} ( $Box(($Unbox(b_$37) : [BoxType]Boolean)) == b_$37 ));
	assume (forall  b_$38 : BoxType :: {($Unbox(b_$38) : Seq (BoxType) )} ( $Box(($Unbox(b_$38) : Seq (BoxType) )) == b_$38 ));
	assume (forall  b_$39 : BoxType :: {($Unbox(b_$39) : Map (BoxType) (BoxType) )} ( $Box(($Unbox(b_$39) : Map (BoxType) (BoxType) )) == b_$39 ));
	assume (forall  b_$40 : BoxType :: {($Unbox(b_$40) : DatatypeType)} ( $Box(($Unbox(b_$40) : DatatypeType)) == b_$40 ));
	assume $IsCanonicalBoolBox($Box(false)) && $IsCanonicalBoolBox($Box(true));
	assume (forall  b_$41 : BoxType :: {($Unbox(b_$41) : Boolean)} ( $IsCanonicalBoolBox(b_$41) ==> ($Box(($Unbox(b_$41) : Boolean)) == b_$41) ));
	assume ((((((((((((((((((forall  ss_$0 : Set (BoxType) , dummy_$1 : Boolean, bx_$0_$0 : BoxType :: {$IsGoodSet_Extended(ss_$0,dummy_$1),ss_$0[bx_$0_$0]} ( $IsGoodSet_Extended(ss_$0,dummy_$1) ==> (ss_$0[bx_$0_$0] ==> (bx_$0_$0 == $Box(($Unbox(bx_$0_$0) : Boolean)))) ))) && ((forall  ss_$1 : Set (BoxType) , dummy_$2 : BoxType, bx_$0_$1 : BoxType :: {$IsGoodSet_Extended(ss_$1,dummy_$2),ss_$1[bx_$0_$1]} ( $IsGoodSet_Extended(ss_$1,dummy_$2) ==> (ss_$1[bx_$0_$1] ==> (bx_$0_$1 == $Box(($Unbox(bx_$0_$1) : BoxType)))) )))) && ((forall  ss_$2 : Set (BoxType) , dummy_$3 : Integer, bx_$0_$2 : BoxType :: {$IsGoodSet_Extended(ss_$2,dummy_$3),ss_$2[bx_$0_$2]} ( $IsGoodSet_Extended(ss_$2,dummy_$3) ==> (ss_$2[bx_$0_$2] ==> (bx_$0_$2 == $Box(($Unbox(bx_$0_$2) : Integer)))) )))) && ((forall  ss_$3 : Set (BoxType) , dummy_$4 : Seq (ref) , bx_$0_$3 : BoxType :: {$IsGoodSet_Extended(ss_$3,dummy_$4),ss_$3[bx_$0_$3]} ( $IsGoodSet_Extended(ss_$3,dummy_$4) ==> (ss_$3[bx_$0_$3] ==> (bx_$0_$3 == $Box(($Unbox(bx_$0_$3) : Seq (ref) )))) )))) && ((forall  ss_$4 : Set (BoxType) , dummy_$5 : ref, bx_$0_$4 : BoxType :: {$IsGoodSet_Extended(ss_$4,dummy_$5),ss_$4[bx_$0_$4]} ( $IsGoodSet_Extended(ss_$4,dummy_$5) ==> (ss_$4[bx_$0_$4] ==> (bx_$0_$4 == $Box(($Unbox(bx_$0_$4) : ref)))) )))) && ((forall  ss_$5 : Set (BoxType) , dummy_$6 : Seq (BoxType) , bx_$0_$5 : BoxType :: {$IsGoodSet_Extended(ss_$5,dummy_$6),ss_$5[bx_$0_$5]} ( $IsGoodSet_Extended(ss_$5,dummy_$6) ==> (ss_$5[bx_$0_$5] ==> (bx_$0_$5 == $Box(($Unbox(bx_$0_$5) : Seq (BoxType) )))) )))) && ((forall  ss_$6 : Set (BoxType) , dummy_$7 : HeapType, bx_$0_$6 : BoxType :: {$IsGoodSet_Extended(ss_$6,dummy_$7),ss_$6[bx_$0_$6]} ( $IsGoodSet_Extended(ss_$6,dummy_$7) ==> (ss_$6[bx_$0_$6] ==> (bx_$0_$6 == $Box(($Unbox(bx_$0_$6) : HeapType)))) )))) && ((forall  ss_$7 : Set (BoxType) , dummy_$8 : Field (BoxType) , bx_$0_$7 : BoxType :: {$IsGoodSet_Extended(ss_$7,dummy_$8),ss_$7[bx_$0_$7]} ( $IsGoodSet_Extended(ss_$7,dummy_$8) ==> (ss_$7[bx_$0_$7] ==> (bx_$0_$7 == $Box(($Unbox(bx_$0_$7) : Field (BoxType) )))) )))) && ((forall  ss_$8 : Set (BoxType) , dummy_$9 : DatatypeType, bx_$0_$8 : BoxType :: {$IsGoodSet_Extended(ss_$8,dummy_$9),ss_$8[bx_$0_$8]} ( $IsGoodSet_Extended(ss_$8,dummy_$9) ==> (ss_$8[bx_$0_$8] ==> (bx_$0_$8 == $Box(($Unbox(bx_$0_$8) : DatatypeType)))) )))) && ((forall  ss_$9 : Set (BoxType) , dummy_$10 : Set (BoxType) , bx_$0_$9 : BoxType :: {$IsGoodSet_Extended(ss_$9,dummy_$10),ss_$9[bx_$0_$9]} ( $IsGoodSet_Extended(ss_$9,dummy_$10) ==> (ss_$9[bx_$0_$9] ==> (bx_$0_$9 == $Box(($Unbox(bx_$0_$9) : Set (BoxType) )))) )))) && ((forall  ss_$10 : Set (BoxType) , dummy_$11 : Map (BoxType) (BoxType) , bx_$0_$10 : BoxType :: {$IsGoodSet_Extended(ss_$10,dummy_$11),ss_$10[bx_$0_$10]} ( $IsGoodSet_Extended(ss_$10,dummy_$11) ==> (ss_$10[bx_$0_$10] ==> (bx_$0_$10 == $Box(($Unbox(bx_$0_$10) : Map (BoxType) (BoxType) )))) )))) && ((forall  ss_$11 : Set (BoxType) , dummy_$12 : ClassName, bx_$0_$11 : BoxType :: {$IsGoodSet_Extended(ss_$11,dummy_$12),ss_$11[bx_$0_$11]} ( $IsGoodSet_Extended(ss_$11,dummy_$12) ==> (ss_$11[bx_$0_$11] ==> (bx_$0_$11 == $Box(($Unbox(bx_$0_$11) : ClassName)))) )))) && ((forall  ss_$12 : Set (BoxType) , dummy_$13 : NameFamily, bx_$0_$12 : BoxType :: {$IsGoodSet_Extended(ss_$12,dummy_$13),ss_$12[bx_$0_$12]} ( $IsGoodSet_Extended(ss_$12,dummy_$13) ==> (ss_$12[bx_$0_$12] ==> (bx_$0_$12 == $Box(($Unbox(bx_$0_$12) : NameFamily)))) )))) && ((forall  ss_$13 : Set (BoxType) , dummy_$14 : Field (Boolean) , bx_$0_$13 : BoxType :: {$IsGoodSet_Extended(ss_$13,dummy_$14),ss_$13[bx_$0_$13]} ( $IsGoodSet_Extended(ss_$13,dummy_$14) ==> (ss_$13[bx_$0_$13] ==> (bx_$0_$13 == $Box(($Unbox(bx_$0_$13) : Field (Boolean) )))) )))) && ((forall  ss_$14 : Set (BoxType) , dummy_$15 : [BoxType]BoxType, bx_$0_$14 : BoxType :: {$IsGoodSet_Extended(ss_$14,dummy_$15),ss_$14[bx_$0_$14]} ( $IsGoodSet_Extended(ss_$14,dummy_$15) ==> (ss_$14[bx_$0_$14] ==> (bx_$0_$14 == $Box(($Unbox(bx_$0_$14) : [BoxType]BoxType)))) )))) && ((forall  ss_$15 : Set (BoxType) , dummy_$16 : Field (ref) , bx_$0_$15 : BoxType :: {$IsGoodSet_Extended(ss_$15,dummy_$16),ss_$15[bx_$0_$15]} ( $IsGoodSet_Extended(ss_$15,dummy_$16) ==> (ss_$15[bx_$0_$15] ==> (bx_$0_$15 == $Box(($Unbox(bx_$0_$15) : Field (ref) )))) )))) && ((forall  ss_$16 : Set (BoxType) , dummy_$17 : LayerType, bx_$0_$16 : BoxType :: {$IsGoodSet_Extended(ss_$16,dummy_$17),ss_$16[bx_$0_$16]} ( $IsGoodSet_Extended(ss_$16,dummy_$17) ==> (ss_$16[bx_$0_$16] ==> (bx_$0_$16 == $Box(($Unbox(bx_$0_$16) : LayerType)))) )))) && ((forall  ss_$17 : Set (BoxType) , dummy_$18 : <v0>[ref,Field (v0) ]Boolean, bx_$0_$17 : BoxType :: {$IsGoodSet_Extended(ss_$17,dummy_$18),ss_$17[bx_$0_$17]} ( $IsGoodSet_Extended(ss_$17,dummy_$18) ==> (ss_$17[bx_$0_$17] ==> (bx_$0_$17 == $Box(($Unbox(bx_$0_$17) : <v0>[ref,Field (v0) ]Boolean)))) )));
	assume (forall  a_$53 : ClassName, b_$42 : ClassName :: {TypeTuple(a_$53,b_$42)} ( (TypeTupleCar(TypeTuple(a_$53,b_$42)) == a_$53) && (TypeTupleCdr(TypeTuple(a_$53,b_$42)) == b_$42) ));
	assume (forall  i_$17 : Integer :: {IndexField(i_$17)} ( FDim(IndexField(i_$17)) == 1 ));
	assume (forall  f_$2 : Field (BoxType) , i_$19 : Integer :: {MultiIndexField(f_$2,i_$19)} ( FDim(MultiIndexField(f_$2,i_$19)) == (FDim(f_$2) + 1) ));
	assume (forall  f_$3 : Field (BoxType) , i_$20 : Integer :: {MultiIndexField(f_$3,i_$20)} ( (MultiIndexField_Inverse0(MultiIndexField(f_$3,i_$20)) == f_$3) && (MultiIndexField_Inverse1(MultiIndexField(f_$3,i_$20)) == i_$20) ));
	assume (((forall  cl_$0 : ClassName, nm_$0 : NameFamily :: {(FieldOfDecl(cl_$0,nm_$0) : Field (Boolean) )} ( (DeclType((FieldOfDecl(cl_$0,nm_$0) : Field (Boolean) )) == cl_$0) && (DeclName((FieldOfDecl(cl_$0,nm_$0) : Field (Boolean) )) == nm_$0) ))) && ((forall  cl_$1 : ClassName, nm_$1 : NameFamily :: {(FieldOfDecl(cl_$1,nm_$1) : Field (BoxType) )} ( (DeclType((FieldOfDecl(cl_$1,nm_$1) : Field (BoxType) )) == cl_$1) && (DeclName((FieldOfDecl(cl_$1,nm_$1) : Field (BoxType) )) == nm_$1) )))) && ((forall  cl_$2 : ClassName, nm_$2 : NameFamily :: {(FieldOfDecl(cl_$2,nm_$2) : Field (ref) )} ( (DeclType((FieldOfDecl(cl_$2,nm_$2) : Field (ref) )) == cl_$2) && (DeclName((FieldOfDecl(cl_$2,nm_$2) : Field (ref) )) == nm_$2) )));
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
	assume (forall  r_$7 : ref, f_$4 : Field (BoxType) , h_$15 : HeapType :: {GenericAlloc(h_$15[r_$7,f_$4],h_$15)} ( (($IsGoodHeap(h_$15) && (!(r_$7 == null))) && h_$15[r_$7,alloc]) ==> GenericAlloc(h_$15[r_$7,f_$4],h_$15) ));
	assume (forall  o_$19 : ref :: ( 0 <= _System.array.Length(o_$19) ));
	assume (((forall  f_$7 : Field (Boolean) , r_$9 : ref, H_$1 : HeapType :: ( H_$1[r_$9,f_$7] == H_$1[r_$9,f_$7] ))) && ((forall  f_$8 : Field (BoxType) , r_$10 : ref, H_$2 : HeapType :: ( H_$2[r_$10,f_$8] == H_$2[r_$10,f_$8] )))) && ((forall  f_$9 : Field (ref) , r_$11 : ref, H_$3 : HeapType :: ( H_$3[r_$11,f_$9] == H_$3[r_$11,f_$9] )));
	assume (((forall  v_$17 : Boolean, f_$0_$0 : Field (Boolean) , r_$0_$0 : ref, H_$0_$0 : HeapType :: ( H_$0_$0[r_$0_$0,f_$0_$0 := v_$17] == H_$0_$0[r_$0_$0,f_$0_$0 := v_$17] ))) && ((forall  v_$18 : BoxType, f_$0_$1 : Field (BoxType) , r_$0_$1 : ref, H_$0_$1 : HeapType :: ( H_$0_$1[r_$0_$1,f_$0_$1 := v_$18] == H_$0_$1[r_$0_$1,f_$0_$1 := v_$18] )))) && ((forall  v_$19 : ref, f_$0_$2 : Field (ref) , r_$0_$2 : ref, H_$0_$2 : HeapType :: ( H_$0_$2[r_$0_$2,f_$0_$2 := v_$19] == H_$0_$2[r_$0_$2,f_$0_$2 := v_$19] )));
	assume (((forall  h_$16_$0 : HeapType, r_$8_$0 : ref, f_$5_$0 : Field (Boolean) , x_$24_$0 : Boolean :: {h_$16_$0[r_$8_$0,f_$5_$0 := x_$24_$0]} ( $IsGoodHeap(h_$16_$0[r_$8_$0,f_$5_$0 := x_$24_$0]) ==> $HeapSucc(h_$16_$0,h_$16_$0[r_$8_$0,f_$5_$0 := x_$24_$0]) ))) && ((forall  h_$16_$1 : HeapType, r_$8_$1 : ref, f_$5_$1 : Field (BoxType) , x_$24_$1 : BoxType :: {h_$16_$1[r_$8_$1,f_$5_$1 := x_$24_$1]} ( $IsGoodHeap(h_$16_$1[r_$8_$1,f_$5_$1 := x_$24_$1]) ==> $HeapSucc(h_$16_$1,h_$16_$1[r_$8_$1,f_$5_$1 := x_$24_$1]) )))) && ((forall  h_$16_$2 : HeapType, r_$8_$2 : ref, f_$5_$2 : Field (ref) , x_$24_$2 : ref :: {h_$16_$2[r_$8_$2,f_$5_$2 := x_$24_$2]} ( $IsGoodHeap(h_$16_$2[r_$8_$2,f_$5_$2 := x_$24_$2]) ==> $HeapSucc(h_$16_$2,h_$16_$2[r_$8_$2,f_$5_$2 := x_$24_$2]) )));
	assume (forall  a_$54 : HeapType, b_$50 : HeapType, c : HeapType :: {$HeapSucc(a_$54,b_$50),$HeapSucc(b_$50,c)} ( ($HeapSucc(a_$54,b_$50) && $HeapSucc(b_$50,c)) ==> $HeapSucc(a_$54,c) ));
	assume (forall  h_$17 : HeapType, k_$1 : HeapType :: {$HeapSucc(h_$17,k_$1)} ( $HeapSucc(h_$17,k_$1) ==> ((forall  o_$20 : ref :: {k_$1[o_$20,alloc]} ( h_$17[o_$20,alloc] ==> k_$1[o_$20,alloc] ))) ));
	assume ((FDim(_module.Node.next) == 0) && ((FieldOfDecl(class._module.Node,field$next) : Field (ref) ) == _module.Node.next)) && (!$IsGhostField(_module.Node.next));
	assume (forall  $h : HeapType, $o : ref :: {$h[$o,_module.Node.next]} ( (($IsGoodHeap($h) && (!($o == null))) && $h[$o,alloc]) ==> (($h[$o,_module.Node.next] == null) || ($h[$h[$o,_module.Node.next],alloc] && (dtype($h[$o,_module.Node.next]) == class._module.Node))) ));
	assume (forall  $h0 : HeapType, $h1 : HeapType, this_$0 : ref, S#0_$0 : Set (BoxType)  :: {$HeapSucc($h0,$h1),_module.Node.IsClosed($h1,this_$0,S#0_$0)} ( ((((((((($IsGoodHeap($h0) && $IsGoodHeap($h1)) && (!(this_$0 == null))) && $h0[this_$0,alloc]) && (dtype(this_$0) == class._module.Node)) && $h1[this_$0,alloc]) && (dtype(this_$0) == class._module.Node)) && (_module.Node.IsClosed#canCall($h0,this_$0,S#0_$0) || ((forall  $t#0 : BoxType :: {S#0_$0[$t#0]} ( S#0_$0[$t#0] ==> ((($Unbox($t#0) : ref) == null) || ($h0[($Unbox($t#0) : ref),alloc] && (dtype(($Unbox($t#0) : ref)) == class._module.Node))) ))))) && (_module.Node.IsClosed#canCall($h1,this_$0,S#0_$0) || ((forall  $t#1 : BoxType :: {S#0_$0[$t#1]} ( S#0_$0[$t#1] ==> ((($Unbox($t#1) : ref) == null) || ($h1[($Unbox($t#1) : ref),alloc] && (dtype(($Unbox($t#1) : ref)) == class._module.Node))) ))))) && $HeapSucc($h0,$h1)) ==> (((((forall  $o_$0_$0 : ref, $f_$28 : Field (Boolean)  :: ( ((((!($o_$0_$0 == null)) && $h0[$o_$0_$0,alloc]) && $h1[$o_$0_$0,alloc]) && S#0_$0[$Box($o_$0_$0)]) ==> ($h0[$o_$0_$0,$f_$28] == $h1[$o_$0_$0,$f_$28]) ))) && ((forall  $o_$0_$1 : ref, $f_$29 : Field (BoxType)  :: ( ((((!($o_$0_$1 == null)) && $h0[$o_$0_$1,alloc]) && $h1[$o_$0_$1,alloc]) && S#0_$0[$Box($o_$0_$1)]) ==> ($h0[$o_$0_$1,$f_$29] == $h1[$o_$0_$1,$f_$29]) )))) && ((forall  $o_$0_$2 : ref, $f_$30 : Field (ref)  :: ( ((((!($o_$0_$2 == null)) && $h0[$o_$0_$2,alloc]) && $h1[$o_$0_$2,alloc]) && S#0_$0[$Box($o_$0_$2)]) ==> ($h0[$o_$0_$2,$f_$30] == $h1[$o_$0_$2,$f_$30]) )))) ==> (_module.Node.IsClosed($h0,this_$0,S#0_$0) <==> _module.Node.IsClosed($h1,this_$0,S#0_$0))) ));
	assume ((0 < $ModuleContextHeight) || ((0 == $ModuleContextHeight) && (0 <= $FunctionContextHeight))) ==> ((forall  $Heap_$0 : HeapType, this_$1 : ref, S#0_$1 : Set (BoxType)  :: {_module.Node.IsClosed($Heap_$0,this_$1,S#0_$1)} ( (_module.Node.IsClosed#canCall($Heap_$0,this_$1,S#0_$1) || (((((((!(0 == $ModuleContextHeight)) || (!(0 == $FunctionContextHeight))) && $IsGoodHeap($Heap_$0)) && (!(this_$1 == null))) && $Heap_$0[this_$1,alloc]) && (dtype(this_$1) == class._module.Node)) && ((forall  $t#2 : BoxType :: {S#0_$1[$t#2]} ( S#0_$1[$t#2] ==> ((($Unbox($t#2) : ref) == null) || ($Heap_$0[($Unbox($t#2) : ref),alloc] && (dtype(($Unbox($t#2) : ref)) == class._module.Node))) ))))) ==> true )));
	assume ((0 == $ModuleContextHeight) && (0 <= $FunctionContextHeight)) ==> ((forall  $Heap_$1 : HeapType, this_$2 : ref, S#0_$2 : Set (BoxType)  :: {_module.Node.IsClosed($Heap_$1,this_$2,S#0_$2)} ( (_module.Node.IsClosed#canCall($Heap_$1,this_$2,S#0_$2) || ((((((!(0 == $FunctionContextHeight)) && $IsGoodHeap($Heap_$1)) && (!(this_$2 == null))) && $Heap_$1[this_$2,alloc]) && (dtype(this_$2) == class._module.Node)) && ((forall  $t#3 : BoxType :: {S#0_$2[$t#3]} ( S#0_$2[$t#3] ==> ((($Unbox($t#3) : ref) == null) || ($Heap_$1[($Unbox($t#3) : ref),alloc] && (dtype(($Unbox($t#3) : ref)) == class._module.Node))) ))))) ==> (((S#0_$2[$Box(this_$2)] ==> true) && ((S#0_$2[$Box(this_$2)] && S#0_$2[$Box(null)]) ==> ((forall  n#1 : ref :: ( ((n#1 == null) || ($Heap_$1[n#1,alloc] && (dtype(n#1) == class._module.Node))) ==> (((S#0_$2[$Box(n#1)] ==> true) && ((S#0_$2[$Box(n#1)] && (!(n#1 == null))) ==> true)) && (((S#0_$2[$Box(n#1)] && (!(n#1 == null))) && (!($Heap_$1[n#1,_module.Node.next] == null))) ==> true)) ))))) && (_module.Node.IsClosed($Heap_$1,this_$2,S#0_$2) <==> ((S#0_$2[$Box(this_$2)] && S#0_$2[$Box(null)]) && ((forall  n#1_$0 : ref :: ( ((n#1_$0 == null) || ($Heap_$1[n#1_$0,alloc] && (dtype(n#1_$0) == class._module.Node))) ==> (((S#0_$2[$Box(n#1_$0)] && (!(n#1_$0 == null))) && (!($Heap_$1[n#1_$0,_module.Node.next] == null))) ==> S#0_$2[$Box($Heap_$1[n#1_$0,_module.Node.next])]) )))))) )));
	assume (0 < $ModuleContextHeight) ==> ((forall  $Heap_$2 : HeapType, this_$3 : ref, S#0_$3 : Set (BoxType)  :: {_module.Node.IsClosed($Heap_$2,this_$3,S#0_$3)} ( (_module.Node.IsClosed#canCall($Heap_$2,this_$3,S#0_$3) || (((($IsGoodHeap($Heap_$2) && (!(this_$3 == null))) && $Heap_$2[this_$3,alloc]) && (dtype(this_$3) == class._module.Node)) && ((forall  $t#4 : BoxType :: {S#0_$3[$t#4]} ( S#0_$3[$t#4] ==> ((($Unbox($t#4) : ref) == null) || ($Heap_$2[($Unbox($t#4) : ref),alloc] && (dtype(($Unbox($t#4) : ref)) == class._module.Node))) ))))) ==> true )));
	assume (forall  $ly : LayerType, $Heap_$3 : HeapType, this_$4 : ref, k#0 : Integer, S#1 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly),$Heap_$3,this_$4,k#0,S#1)} ( _module.Node.Nexxxt($LS($ly),$Heap_$3,this_$4,k#0,S#1) == _module.Node.Nexxxt($ly,$Heap_$3,this_$4,k#0,S#1) ));
	assume (forall  $ly_$0 : LayerType, $h0_$0 : HeapType, $h1_$0 : HeapType, this_$5 : ref, k#0_$0 : Integer, S#1_$0 : Set (BoxType)  :: {$HeapSucc($h0_$0,$h1_$0),_module.Node.Nexxxt($ly_$0,$h1_$0,this_$5,k#0_$0,S#1_$0)} ( ((((((((($IsGoodHeap($h0_$0) && $IsGoodHeap($h1_$0)) && (!(this_$5 == null))) && $h0_$0[this_$5,alloc]) && (dtype(this_$5) == class._module.Node)) && $h1_$0[this_$5,alloc]) && (dtype(this_$5) == class._module.Node)) && (_module.Node.Nexxxt#canCall($h0_$0,this_$5,k#0_$0,S#1_$0) || ((forall  $t#6 : BoxType :: {S#1_$0[$t#6]} ( S#1_$0[$t#6] ==> ((($Unbox($t#6) : ref) == null) || ($h0_$0[($Unbox($t#6) : ref),alloc] && (dtype(($Unbox($t#6) : ref)) == class._module.Node))) ))))) && (_module.Node.Nexxxt#canCall($h1_$0,this_$5,k#0_$0,S#1_$0) || ((forall  $t#7 : BoxType :: {S#1_$0[$t#7]} ( S#1_$0[$t#7] ==> ((($Unbox($t#7) : ref) == null) || ($h1_$0[($Unbox($t#7) : ref),alloc] && (dtype(($Unbox($t#7) : ref)) == class._module.Node))) ))))) && $HeapSucc($h0_$0,$h1_$0)) ==> (((((forall  $o_$1_$0 : ref, $f_$0_$0 : Field (Boolean)  :: ( ((((!($o_$1_$0 == null)) && $h0_$0[$o_$1_$0,alloc]) && $h1_$0[$o_$1_$0,alloc]) && S#1_$0[$Box($o_$1_$0)]) ==> ($h0_$0[$o_$1_$0,$f_$0_$0] == $h1_$0[$o_$1_$0,$f_$0_$0]) ))) && ((forall  $o_$1_$1 : ref, $f_$0_$1 : Field (BoxType)  :: ( ((((!($o_$1_$1 == null)) && $h0_$0[$o_$1_$1,alloc]) && $h1_$0[$o_$1_$1,alloc]) && S#1_$0[$Box($o_$1_$1)]) ==> ($h0_$0[$o_$1_$1,$f_$0_$1] == $h1_$0[$o_$1_$1,$f_$0_$1]) )))) && ((forall  $o_$1_$2 : ref, $f_$0_$2 : Field (ref)  :: ( ((((!($o_$1_$2 == null)) && $h0_$0[$o_$1_$2,alloc]) && $h1_$0[$o_$1_$2,alloc]) && S#1_$0[$Box($o_$1_$2)]) ==> ($h0_$0[$o_$1_$2,$f_$0_$2] == $h1_$0[$o_$1_$2,$f_$0_$2]) )))) ==> (_module.Node.Nexxxt($ly_$0,$h0_$0,this_$5,k#0_$0,S#1_$0) == _module.Node.Nexxxt($ly_$0,$h1_$0,this_$5,k#0_$0,S#1_$0))) ));
	assume ((0 < $ModuleContextHeight) || ((0 == $ModuleContextHeight) && (1 <= $FunctionContextHeight))) ==> ((forall  $ly_$1 : LayerType, $Heap_$4 : HeapType, this_$6 : ref, k#0_$1 : Integer, S#1_$1 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1)} ( (_module.Node.Nexxxt#canCall($Heap_$4,this_$6,k#0_$1,S#1_$1) || (((((((((!(0 == $ModuleContextHeight)) || (!(1 == $FunctionContextHeight))) && $IsGoodHeap($Heap_$4)) && (!(this_$6 == null))) && $Heap_$4[this_$6,alloc]) && (dtype(this_$6) == class._module.Node)) && ((forall  $t#8 : BoxType :: {S#1_$1[$t#8]} ( S#1_$1[$t#8] ==> ((($Unbox($t#8) : ref) == null) || ($Heap_$4[($Unbox($t#8) : ref),alloc] && (dtype(($Unbox($t#8) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$4,this_$6,S#1_$1)) && (0 <= k#0_$1))) ==> (S#1_$1[$Box(_module.Node.Nexxxt($LS($LZ),$Heap_$4,this_$6,k#0_$1,S#1_$1))] && ((_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1) == null) || ($Heap_$4[_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1),alloc] && (dtype(_module.Node.Nexxxt($LS($ly_$1),$Heap_$4,this_$6,k#0_$1,S#1_$1)) == class._module.Node)))) )));
	assume ((0 == $ModuleContextHeight) && (1 <= $FunctionContextHeight)) ==> ((forall  $ly_$2 : LayerType, $Heap_$5 : HeapType, this_$7 : ref, k#0_$2 : Integer, S#1_$2 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly_$2),$Heap_$5,this_$7,k#0_$2,S#1_$2)} ( (_module.Node.Nexxxt#canCall($Heap_$5,this_$7,k#0_$2,S#1_$2) || ((((((((!(1 == $FunctionContextHeight)) && $IsGoodHeap($Heap_$5)) && (!(this_$7 == null))) && $Heap_$5[this_$7,alloc]) && (dtype(this_$7) == class._module.Node)) && ((forall  $t#9 : BoxType :: {S#1_$2[$t#9]} ( S#1_$2[$t#9] ==> ((($Unbox($t#9) : ref) == null) || ($Heap_$5[($Unbox($t#9) : ref),alloc] && (dtype(($Unbox($t#9) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$5,this_$7,S#1_$2)) && (0 <= k#0_$2))) ==> ((((k#0_$2 == 0) ==> true) && ((!(k#0_$2 == 0)) ==> ((_module.Node.Nexxxt#canCall($Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) && ((_module.Node.Nexxxt($LS($LZ),$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) == null) ==> true)) && ((!(_module.Node.Nexxxt($LS($LZ),$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) == null)) ==> _module.Node.Nexxxt#canCall($Heap_$5,this_$7,k#0_$2 - 1,S#1_$2))))) && (_module.Node.Nexxxt($LS($ly_$2),$Heap_$5,this_$7,k#0_$2,S#1_$2) == (if (k#0_$2 == 0) then this_$7 else (if (_module.Node.Nexxxt($ly_$2,$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2) == null) then null else $Heap_$5[_module.Node.Nexxxt($ly_$2,$Heap_$5,this_$7,k#0_$2 - 1,S#1_$2),_module.Node.next])))) )));
	assume (0 < $ModuleContextHeight) ==> ((forall  $ly_$3 : LayerType, $Heap_$6 : HeapType, this_$8 : ref, k#0_$3 : Integer, S#1_$3 : Set (BoxType)  :: {_module.Node.Nexxxt($LS($ly_$3),$Heap_$6,this_$8,k#0_$3,S#1_$3)} ( (_module.Node.Nexxxt#canCall($Heap_$6,this_$8,k#0_$3,S#1_$3) || (((((($IsGoodHeap($Heap_$6) && (!(this_$8 == null))) && $Heap_$6[this_$8,alloc]) && (dtype(this_$8) == class._module.Node)) && ((forall  $t#10 : BoxType :: {S#1_$3[$t#10]} ( S#1_$3[$t#10] ==> ((($Unbox($t#10) : ref) == null) || ($Heap_$6[($Unbox($t#10) : ref),alloc] && (dtype(($Unbox($t#10) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$6,this_$8,S#1_$3)) && (0 <= k#0_$3))) ==> true )));
	assume (forall  $ly_$4 : LayerType, $Heap_$7 : HeapType, this_$9 : ref, sink#0 : ref, S#1_$4 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$4),$Heap_$7,this_$9,sink#0,S#1_$4)} ( _module.Node.Reaches($LS($ly_$4),$Heap_$7,this_$9,sink#0,S#1_$4) <==> _module.Node.Reaches($ly_$4,$Heap_$7,this_$9,sink#0,S#1_$4) ));
	assume (forall  $ly_$5 : LayerType, $h0_$1 : HeapType, $h1_$1 : HeapType, this_$10 : ref, sink#0_$0 : ref, S#1_$5 : Set (BoxType)  :: {$HeapSucc($h0_$1,$h1_$1),_module.Node.Reaches($ly_$5,$h1_$1,this_$10,sink#0_$0,S#1_$5)} ( ((((((((($IsGoodHeap($h0_$1) && $IsGoodHeap($h1_$1)) && (!(this_$10 == null))) && $h0_$1[this_$10,alloc]) && (dtype(this_$10) == class._module.Node)) && $h1_$1[this_$10,alloc]) && (dtype(this_$10) == class._module.Node)) && (_module.Node.Reaches#canCall($h0_$1,this_$10,sink#0_$0,S#1_$5) || (((sink#0_$0 == null) || ($h0_$1[sink#0_$0,alloc] && (dtype(sink#0_$0) == class._module.Node))) && ((forall  $t#12 : BoxType :: {S#1_$5[$t#12]} ( S#1_$5[$t#12] ==> ((($Unbox($t#12) : ref) == null) || ($h0_$1[($Unbox($t#12) : ref),alloc] && (dtype(($Unbox($t#12) : ref)) == class._module.Node))) )))))) && (_module.Node.Reaches#canCall($h1_$1,this_$10,sink#0_$0,S#1_$5) || (((sink#0_$0 == null) || ($h1_$1[sink#0_$0,alloc] && (dtype(sink#0_$0) == class._module.Node))) && ((forall  $t#13 : BoxType :: {S#1_$5[$t#13]} ( S#1_$5[$t#13] ==> ((($Unbox($t#13) : ref) == null) || ($h1_$1[($Unbox($t#13) : ref),alloc] && (dtype(($Unbox($t#13) : ref)) == class._module.Node))) )))))) && $HeapSucc($h0_$1,$h1_$1)) ==> (((((forall  $o_$2_$0 : ref, $f_$1_$0 : Field (Boolean)  :: ( ((((!($o_$2_$0 == null)) && $h0_$1[$o_$2_$0,alloc]) && $h1_$1[$o_$2_$0,alloc]) && S#1_$5[$Box($o_$2_$0)]) ==> ($h0_$1[$o_$2_$0,$f_$1_$0] == $h1_$1[$o_$2_$0,$f_$1_$0]) ))) && ((forall  $o_$2_$1 : ref, $f_$1_$1 : Field (BoxType)  :: ( ((((!($o_$2_$1 == null)) && $h0_$1[$o_$2_$1,alloc]) && $h1_$1[$o_$2_$1,alloc]) && S#1_$5[$Box($o_$2_$1)]) ==> ($h0_$1[$o_$2_$1,$f_$1_$1] == $h1_$1[$o_$2_$1,$f_$1_$1]) )))) && ((forall  $o_$2_$2 : ref, $f_$1_$2 : Field (ref)  :: ( ((((!($o_$2_$2 == null)) && $h0_$1[$o_$2_$2,alloc]) && $h1_$1[$o_$2_$2,alloc]) && S#1_$5[$Box($o_$2_$2)]) ==> ($h0_$1[$o_$2_$2,$f_$1_$2] == $h1_$1[$o_$2_$2,$f_$1_$2]) )))) ==> (_module.Node.Reaches($ly_$5,$h0_$1,this_$10,sink#0_$0,S#1_$5) <==> _module.Node.Reaches($ly_$5,$h1_$1,this_$10,sink#0_$0,S#1_$5))) ));
	assume ((0 < $ModuleContextHeight) || ((0 == $ModuleContextHeight) && (2 <= $FunctionContextHeight))) ==> ((forall  $ly_$6 : LayerType, $Heap_$8 : HeapType, this_$11 : ref, sink#0_$1 : ref, S#1_$6 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$6),$Heap_$8,this_$11,sink#0_$1,S#1_$6)} ( (_module.Node.Reaches#canCall($Heap_$8,this_$11,sink#0_$1,S#1_$6) || (((((((((!(0 == $ModuleContextHeight)) || (!(2 == $FunctionContextHeight))) && $IsGoodHeap($Heap_$8)) && (!(this_$11 == null))) && $Heap_$8[this_$11,alloc]) && (dtype(this_$11) == class._module.Node)) && ((sink#0_$1 == null) || ($Heap_$8[sink#0_$1,alloc] && (dtype(sink#0_$1) == class._module.Node)))) && ((forall  $t#14 : BoxType :: {S#1_$6[$t#14]} ( S#1_$6[$t#14] ==> ((($Unbox($t#14) : ref) == null) || ($Heap_$8[($Unbox($t#14) : ref),alloc] && (dtype(($Unbox($t#14) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$8,this_$11,S#1_$6))) ==> (_module.Node.Reaches($LS($LZ),$Heap_$8,this_$11,sink#0_$1,S#1_$6) ==> S#1_$6[$Box(sink#0_$1)]) )));
	assume ((0 == $ModuleContextHeight) && (2 <= $FunctionContextHeight)) ==> ((forall  $ly_$7 : LayerType, $Heap_$9 : HeapType, this_$12 : ref, sink#0_$2 : ref, S#1_$7 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$7),$Heap_$9,this_$12,sink#0_$2,S#1_$7)} ( (_module.Node.Reaches#canCall($Heap_$9,this_$12,sink#0_$2,S#1_$7) || ((((((((!(2 == $FunctionContextHeight)) && $IsGoodHeap($Heap_$9)) && (!(this_$12 == null))) && $Heap_$9[this_$12,alloc]) && (dtype(this_$12) == class._module.Node)) && ((sink#0_$2 == null) || ($Heap_$9[sink#0_$2,alloc] && (dtype(sink#0_$2) == class._module.Node)))) && ((forall  $t#15 : BoxType :: {S#1_$7[$t#15]} ( S#1_$7[$t#15] ==> ((($Unbox($t#15) : ref) == null) || ($Heap_$9[($Unbox($t#15) : ref),alloc] && (dtype(($Unbox($t#15) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$9,this_$12,S#1_$7))) ==> (((forall  k#2 : Integer :: ( true ==> ((0 <= k#2) ==> _module.Node.Nexxxt#canCall($Heap_$9,this_$12,k#2,S#1_$7)) ))) && (_module.Node.Reaches($LS($ly_$7),$Heap_$9,this_$12,sink#0_$2,S#1_$7) <==> ((exists  k#2_$0 : Integer :: ( (0 <= k#2_$0) && (_module.Node.Nexxxt($LS($LZ),$Heap_$9,this_$12,k#2_$0,S#1_$7) == sink#0_$2) ))))) )));
	assume (0 < $ModuleContextHeight) ==> ((forall  $ly_$8 : LayerType, $Heap_$10 : HeapType, this_$13 : ref, sink#0_$3 : ref, S#1_$8 : Set (BoxType)  :: {_module.Node.Reaches($LS($ly_$8),$Heap_$10,this_$13,sink#0_$3,S#1_$8)} ( (_module.Node.Reaches#canCall($Heap_$10,this_$13,sink#0_$3,S#1_$8) || (((((($IsGoodHeap($Heap_$10) && (!(this_$13 == null))) && $Heap_$10[this_$13,alloc]) && (dtype(this_$13) == class._module.Node)) && ((sink#0_$3 == null) || ($Heap_$10[sink#0_$3,alloc] && (dtype(sink#0_$3) == class._module.Node)))) && ((forall  $t#16 : BoxType :: {S#1_$8[$t#16]} ( S#1_$8[$t#16] ==> ((($Unbox($t#16) : ref) == null) || ($Heap_$10[($Unbox($t#16) : ref),alloc] && (dtype(($Unbox($t#16) : ref)) == class._module.Node))) )))) && _module.Node.IsClosed($Heap_$10,this_$13,S#1_$8))) ==> true )));
	assume (((forall  $o_$9_$0 : ref, $f_$8_$0 : Field (Boolean) , alloc_$6_$0 : Field (Boolean) , null_$6_$0 : ref, $Heap_$17_$0 : HeapType :: {lambda#6(alloc_$6_$0,null_$6_$0,$Heap_$17_$0)[$o_$9_$0,$f_$8_$0]} ( lambda#6(alloc_$6_$0,null_$6_$0,$Heap_$17_$0)[$o_$9_$0,$f_$8_$0] <==> (((!($o_$9_$0 == null_$6_$0)) && $Heap_$17_$0[$o_$9_$0,alloc_$6_$0]) ==> false) ))) && ((forall  $o_$9_$1 : ref, $f_$8_$1 : Field (BoxType) , alloc_$6_$1 : Field (Boolean) , null_$6_$1 : ref, $Heap_$17_$1 : HeapType :: {lambda#6(alloc_$6_$1,null_$6_$1,$Heap_$17_$1)[$o_$9_$1,$f_$8_$1]} ( lambda#6(alloc_$6_$1,null_$6_$1,$Heap_$17_$1)[$o_$9_$1,$f_$8_$1] <==> (((!($o_$9_$1 == null_$6_$1)) && $Heap_$17_$1[$o_$9_$1,alloc_$6_$1]) ==> false) )))) && ((forall  $o_$9_$2 : ref, $f_$8_$2 : Field (ref) , alloc_$6_$2 : Field (Boolean) , null_$6_$2 : ref, $Heap_$17_$2 : HeapType :: {lambda#6(alloc_$6_$2,null_$6_$2,$Heap_$17_$2)[$o_$9_$2,$f_$8_$2]} ( lambda#6(alloc_$6_$2,null_$6_$2,$Heap_$17_$2)[$o_$9_$2,$f_$8_$2] <==> (((!($o_$9_$2 == null_$6_$2)) && $Heap_$17_$2[$o_$9_$2,alloc_$6_$2]) ==> false) )));
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume $IsGoodHeap($Heap);
	assume ((!(this == null)) && $Heap[this,alloc]) && (dtype(this) == class._module.Node);
	assume ((forall  $t#6_$0 : BoxType :: {S#0[$t#6_$0]} ( S#0[$t#6_$0] ==> ((($Unbox($t#6_$0) : ref) == null) || ($Heap[($Unbox($t#6_$0) : ref),alloc] && (dtype(($Unbox($t#6_$0) : ref)) == class._module.Node))) ))) && $IsGoodSet_Extended(S#0,null);
	assume (p#30 == null) || ($Heap[p#30,alloc] && (dtype(p#30) == class._module.Node));
	assume (forall  $t#9_$0 : BoxType :: {Visited#32[$t#9_$0]} ( Visited#32[$t#9_$0] ==> ((($Unbox($t#9_$0) : ref) == null) || ($Heap[($Unbox($t#9_$0) : ref),alloc] && (dtype(($Unbox($t#9_$0) : ref)) == class._module.Node))) ));
	assume (0 == $ModuleContextHeight) && (4 == $FunctionContextHeight);
	assume _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(this)]);
	assume _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(null)]);
	assume _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || ((forall  n#26 : ref :: ( ((n#26 == null) || ($Heap[n#26,alloc] && (dtype(n#26) == class._module.Node))) ==> (((S#0[$Box(n#26)] && (!(n#26 == null))) && (!($Heap[n#26,_module.Node.next] == null))) ==> S#0[$Box($Heap[n#26,_module.Node.next])]) ))));
	assume (((_module.Node.IsClosed#canCall($Heap,this,S#0) && _module.Node.IsClosed($Heap,this,S#0)) && S#0[$Box(this)]) && S#0[$Box(null)]) && ((forall  n#27 : ref :: ( ((n#27 == null) || ($Heap[n#27,alloc] && (dtype(n#27) == class._module.Node))) ==> (((S#0[$Box(n#27)] && (!(n#27 == null))) && (!($Heap[n#27,_module.Node.next] == null))) ==> S#0[$Box($Heap[n#27,_module.Node.next])]) )));
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
	assert  $w0_$_0 ==> ((forall  q#45 : ref :: ( ((q#45 == null) || ($Heap[q#45,alloc] && (dtype(q#45) == class._module.Node))) ==> ($rhs#12_$_0[$Box(q#45)] ==> ((q#45 == null) || ((exists  t#44 : Integer :: ( ((0 <= t#44) && (t#44 < $rhs#11_$_0)) && (_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#44,S#0) == q#45) ))))) )));
	assert  $w0_$_0 ==> ((forall  k#52 : Integer, l#53 : Integer :: ( (((forall  k$ih#14#54 : Integer, l$ih#15#55 : Integer :: ( true ==> ((((0 <= k$ih#14#54) && (k$ih#14#54 < k#52)) || (((k$ih#14#54 == k#52) && (0 <= l$ih#15#55)) && (l$ih#15#55 < l#53))) ==> ((((0 <= k$ih#14#54) && (k$ih#14#54 < l$ih#15#55)) && (l$ih#15#55 < $rhs#11_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#14#54,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l$ih#15#55,S#0))))) ))) && true) ==> ((((0 <= k#52) && (k#52 < l#53)) && (l#53 < $rhs#11_$_0)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#52,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,l#53,S#0)))) )));
	goto anon47_LoopHead;
anon47_LoopHead:
	assume (p#30_$_0 == null) || ($Heap[p#30_$_0,alloc] && (dtype(p#30_$_0) == class._module.Node));
	assume (forall  $t#9_$1 : BoxType :: {Visited#32_$_0[$t#9_$1]} ( Visited#32_$_0[$t#9_$1] ==> ((($Unbox($t#9_$1) : ref) == null) || ($Heap[($Unbox($t#9_$1) : ref),alloc] && (dtype(($Unbox($t#9_$1) : ref)) == class._module.Node))) ));
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
	assume $w0_$_0 ==> ((forall  q#45_$0 : ref :: ( ((q#45_$0 == null) || ($Heap[q#45_$0,alloc] && (dtype(q#45_$0) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$0)] ==> ((!(q#45_$0 == null)) ==> ((forall  t#44_$0 : Integer :: ( true ==> (((0 <= t#44_$0) ==> true) && (((0 <= t#44_$0) && (t#44_$0 < steps#31_$_0)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#44_$0,S#0))) ))))) )));
	assume $w0_$_0 ==> ((forall  q#45_$1 : ref :: ( ((q#45_$1 == null) || ($Heap[q#45_$1,alloc] && (dtype(q#45_$1) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$1)] ==> ((q#45_$1 == null) || ((exists  t#44_$1 : Integer :: ( ((0 <= t#44_$1) && (t#44_$1 < steps#31_$_0)) && (_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#44_$1,S#0) == q#45_$1) ))))) )));
	assume $w0_$_0 ==> ((forall  q#45_$2 : ref :: ( ((q#45_$2 == null) || ($Heap[q#45_$2,alloc] && (dtype(q#45_$2) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$2)] ==> ((q#45_$2 == null) || ((exists  t#44_$2 : Integer :: ( ((0 <= t#44_$2) && (t#44_$2 < steps#31_$_0)) && (_module.Node.Nexxxt($LS($LZ),$Heap,this,t#44_$2,S#0) == q#45_$2) ))))) )));
	assume $w0_$_0 ==> ((forall  k#52_$0 : Integer, l#53_$0 : Integer :: ( true ==> ((((0 <= k#52_$0) ==> true) && (((0 <= k#52_$0) && (k#52_$0 < l#53_$0)) ==> true)) && ((((0 <= k#52_$0) && (k#52_$0 < l#53_$0)) && (l#53_$0 < steps#31_$_0)) ==> (_module.Node.Nexxxt#canCall($Heap,this,k#52_$0,S#0) && _module.Node.Nexxxt#canCall($Heap,this,l#53_$0,S#0)))) )));
	assume $w0_$_0 ==> ((forall  k#52_$1 : Integer, l#53_$1 : Integer :: ( (((forall  k$ih#14#54_$0 : Integer, l$ih#15#55_$0 : Integer :: ( true ==> ((((0 <= k$ih#14#54_$0) && (k$ih#14#54_$0 < k#52_$1)) || (((k$ih#14#54_$0 == k#52_$1) && (0 <= l$ih#15#55_$0)) && (l$ih#15#55_$0 < l#53_$1))) ==> ((((0 <= k$ih#14#54_$0) && (k$ih#14#54_$0 < l$ih#15#55_$0)) && (l$ih#15#55_$0 < steps#31_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#14#54_$0,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l$ih#15#55_$0,S#0))))) ))) && true) ==> ((((0 <= k#52_$1) && (k#52_$1 < l#53_$1)) && (l#53_$1 < steps#31_$_0)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#52_$1,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,l#53_$1,S#0)))) )));
	assume $w0_$_0 ==> ((forall  k#52_$2 : Integer, l#53_$2 : Integer :: ( true ==> ((((0 <= k#52_$2) && (k#52_$2 < l#53_$2)) && (l#53_$2 < steps#31_$_0)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k#52_$2,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l#53_$2,S#0)))) )));
	assume $Heap == $Heap;
	assume (((forall  $o_$26_$0 : ref, $f_$25_$0 : Field (Boolean)  :: {$Heap[$o_$26_$0,$f_$25_$0]} ( ((!($o_$26_$0 == null)) && $Heap[$o_$26_$0,alloc]) ==> (($Heap[$o_$26_$0,$f_$25_$0] == $Heap[$o_$26_$0,$f_$25_$0]) || $_Frame_$_0[$o_$26_$0,$f_$25_$0]) ))) && ((forall  $o_$26_$1 : ref, $f_$25_$1 : Field (BoxType)  :: {$Heap[$o_$26_$1,$f_$25_$1]} ( ((!($o_$26_$1 == null)) && $Heap[$o_$26_$1,alloc]) ==> (($Heap[$o_$26_$1,$f_$25_$1] == $Heap[$o_$26_$1,$f_$25_$1]) || $_Frame_$_0[$o_$26_$1,$f_$25_$1]) )))) && ((forall  $o_$26_$2 : ref, $f_$25_$2 : Field (ref)  :: {$Heap[$o_$26_$2,$f_$25_$2]} ( ((!($o_$26_$2 == null)) && $Heap[$o_$26_$2,alloc]) ==> (($Heap[$o_$26_$2,$f_$25_$2] == $Heap[$o_$26_$2,$f_$25_$2]) || $_Frame_$_0[$o_$26_$2,$f_$25_$2]) )));
	assume Set#Subset(Set#Difference(S#0,Visited#32_$_0),$decr0$init$0_$_0) && (Set#Equal(Set#Difference(S#0,Visited#32_$_0),$decr0$init$0_$_0) ==> true);
	if ($_$_condition) { goto anon47_LoopDone; } else { goto anon47_LoopBody; }
anon47_LoopDone:
	assume $_$_condition;
	assume $_$_condition <==> (!true);
	assume !true;
	goto anon28;
anon47_LoopBody:
	assume !$_$_condition;
	assume $_$_condition <==> (!true);
	assume true;
	assume true;
	if ($_$_condition_$0) { goto anon48_Then; } else { goto anon48_Else; }
anon28:
	assume true;
	if ($_$_condition_$7) { goto anon62_Then; } else { goto anon62_Else; }
anon48_Then:
	assume $_$_condition_$0;
	assume $_$_condition_$0 <==> (!$w0_$_0);
	assume !$w0_$_0;
	if ($_$_condition_$1) { goto anon49_Then; } else { goto anon49_Else; }
anon48_Else:
	assume !$_$_condition_$0;
	assume $_$_condition_$0 <==> (!$w0_$_0);
	assume $w0_$_0;
	assume true;
	if ($_$_condition_$2) { goto anon61_Then; } else { goto anon61_Else; }
anon49_Then:
	assume $_$_condition_$1;
	assume 0 <= steps#31_$_0;
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= steps#31_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,steps#31_$_0,S#0);
	goto $branchMerge_0;
anon49_Else:
	assume !$_$_condition_$1;
	assume steps#31_$_0 < 0;
	goto $branchMerge_0;
anon61_Then:
	assume $_$_condition_$2;
	assume $_$_condition_$2 <==> Visited#32_$_0[$Box(p#30_$_0)];
	assume Visited#32_$_0[$Box(p#30_$_0)];
	goto anon28;
anon61_Else:
	assume !$_$_condition_$2;
	assume $_$_condition_$2 <==> Visited#32_$_0[$Box(p#30_$_0)];
	assume !Visited#32_$_0[$Box(p#30_$_0)];
	assume $decr0$0_$_1 == Set#Difference(S#0,Visited#32_$_0);
	assume true;
	assume true;
	assume true;
	assert  !(p#30_$_0 == null);
	assume true;
	assume $rhs#16_$_1 == $Heap[p#30_$_0,_module.Node.next];
	assume true;
	assume $rhs#17_$_1 == (steps#31_$_0 + 1);
	assume true;
	assume $rhs#18_$_1 == Set#Union(Visited#32_$_0,Set#UnionOne((Set#Empty() : Set (BoxType) ),$Box(p#30_$_0)));
	assume true;
	assert  Set#Subset(Set#Difference(S#0,$rhs#18_$_1),$decr0$0_$_1) && (!Set#Subset($decr0$0_$_1,Set#Difference(S#0,$rhs#18_$_1)));
	assume (((0 <= $rhs#17_$_1) ==> _module.Node.Nexxxt#canCall($Heap,this,$rhs#17_$_1,S#0)) && (((0 <= $rhs#17_$_1) && ($rhs#16_$_1 == _module.Node.Nexxxt($LS($LZ),$Heap,this,$rhs#17_$_1,S#0))) ==> true)) && ((((0 <= $rhs#17_$_1) && ($rhs#16_$_1 == _module.Node.Nexxxt($LS($LZ),$Heap,this,$rhs#17_$_1,S#0))) && S#0[$Box($rhs#16_$_1)]) ==> true);
	assume true;
	assume (forall  t#38_$3 : Integer :: ( true ==> (((0 <= t#38_$3) ==> true) && (((0 <= t#38_$3) && (t#38_$3 < $rhs#17_$_1)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#38_$3,S#0))) ));
	assume (forall  q#45_$3 : ref :: ( ((q#45_$3 == null) || ($Heap[q#45_$3,alloc] && (dtype(q#45_$3) == class._module.Node))) ==> ($rhs#18_$_1[$Box(q#45_$3)] ==> ((!(q#45_$3 == null)) ==> ((forall  t#44_$3 : Integer :: ( true ==> (((0 <= t#44_$3) ==> true) && (((0 <= t#44_$3) && (t#44_$3 < $rhs#17_$_1)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#44_$3,S#0))) ))))) ));
	assume (forall  k#52_$3 : Integer, l#53_$3 : Integer :: ( true ==> ((((0 <= k#52_$3) ==> true) && (((0 <= k#52_$3) && (k#52_$3 < l#53_$3)) ==> true)) && ((((0 <= k#52_$3) && (k#52_$3 < l#53_$3)) && (l#53_$3 < $rhs#17_$_1)) ==> (_module.Node.Nexxxt#canCall($Heap,this,k#52_$3,S#0) && _module.Node.Nexxxt#canCall($Heap,this,l#53_$3,S#0)))) ));
	assert  $w0_$_0 ==> (0 <= $rhs#17_$_1);
	assert  $w0_$_0 ==> ($rhs#16_$_1 == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,$rhs#17_$_1,S#0));
	assert  $w0_$_0 ==> S#0[$Box($rhs#16_$_1)];
	assert  $w0_$_0 ==> $rhs#18_$_1[$Box(null)];
	assert  $w0_$_0 ==> Set#Subset($rhs#18_$_1,S#0);
	assert  $w0_$_0 ==> ((forall  t#38_$4 : Integer :: ( (((forall  t$ih#13#39_$1 : Integer :: ( true ==> (((0 <= t$ih#13#39_$1) && (t$ih#13#39_$1 < t#38_$4)) ==> (((0 <= t$ih#13#39_$1) && (t$ih#13#39_$1 < $rhs#17_$_1)) ==> $rhs#18_$_1[$Box(_module.Node.Nexxxt($LS($LZ),$Heap,this,t$ih#13#39_$1,S#0))])) ))) && true) ==> (((0 <= t#38_$4) && (t#38_$4 < $rhs#17_$_1)) ==> $rhs#18_$_1[$Box(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#38_$4,S#0))]) )));
	assert  $w0_$_0 ==> ((forall  q#45_$4 : ref :: ( ((q#45_$4 == null) || ($Heap[q#45_$4,alloc] && (dtype(q#45_$4) == class._module.Node))) ==> ($rhs#18_$_1[$Box(q#45_$4)] ==> ((q#45_$4 == null) || ((exists  t#44_$4 : Integer :: ( ((0 <= t#44_$4) && (t#44_$4 < $rhs#17_$_1)) && (_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,t#44_$4,S#0) == q#45_$4) ))))) )));
	assert  $w0_$_0 ==> ((forall  k#52_$4 : Integer, l#53_$4 : Integer :: ( (((forall  k$ih#14#54_$1 : Integer, l$ih#15#55_$1 : Integer :: ( true ==> ((((0 <= k$ih#14#54_$1) && (k$ih#14#54_$1 < k#52_$4)) || (((k$ih#14#54_$1 == k#52_$4) && (0 <= l$ih#15#55_$1)) && (l$ih#15#55_$1 < l#53_$4))) ==> ((((0 <= k$ih#14#54_$1) && (k$ih#14#54_$1 < l$ih#15#55_$1)) && (l$ih#15#55_$1 < $rhs#17_$_1)) ==> (!(_module.Node.Nexxxt($LS($LZ),$Heap,this,k$ih#14#54_$1,S#0) == _module.Node.Nexxxt($LS($LZ),$Heap,this,l$ih#15#55_$1,S#0))))) ))) && true) ==> ((((0 <= k#52_$4) && (k#52_$4 < l#53_$4)) && (l#53_$4 < $rhs#17_$_1)) ==> (!(_module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,k#52_$4,S#0) == _module.Node.Nexxxt($LS($LS($LZ)),$Heap,this,l#53_$4,S#0)))) )));
	assume false;
	assume A#1_$_3 == A#1;
	assume B#2_$_1 == B#2;
	assume $Heap_$_1 == $Heap;
	goto $exit;
anon50_Then:
	assume $_$_condition_$3;
	assume $_$_condition_$3 <==> ((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0)));
	assume (0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0));
	goto $branchMerge_1;
anon50_Else:
	assume !$_$_condition_$3;
	assume $_$_condition_$3 <==> ((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0)));
	assume !((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0)));
	goto $branchMerge_1;
anon51_Then:
	assume $_$_condition_$5;
	assume $_$_condition_$5 <==> (((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)]);
	assume ((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)];
	goto anon8;
anon51_Else:
	assume !$_$_condition_$5;
	assume $_$_condition_$5 <==> (((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)]);
	assume !(((0 <= steps#31_$_0) && (p#30_$_0 == _module.Node.Nexxxt($LS($LZ),$Heap,this,steps#31_$_0,S#0))) && S#0[$Box(p#30_$_0)]);
	goto anon8;
anon62_Then:
	assume $_$_condition_$7;
	assume $_$_condition_$7 <==> (p#30_$_0 == null);
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
	assume !$_$_condition_$7;
	assume $_$_condition_$7 <==> (p#30_$_0 == null);
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
	assume $_$_condition_$8;
	assume 0 <= k#56_$_0;
	goto $branchMerge_2;
anon63_Else:
	assume !$_$_condition_$8;
	assume k#56_$_0 < 0;
	goto $branchMerge_2;
anon52_Then:
	assume $_$_condition_$9;
	assume 0 <= t#35_$_0;
	goto $branchMerge_3;
anon52_Else:
	assume !$_$_condition_$9;
	assume t#35_$_0 < 0;
	goto $branchMerge_3;
anon64_Then:
	assume $_$_condition_$10;
	assume $_$_condition_$10 <==> ((0 <= k#56_$_0) && (k#56_$_0 < steps#31_$_0));
	assume (0 <= k#56_$_0) && (k#56_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= k#56_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,k#56_$_0,S#0);
	goto anon34;
anon64_Else:
	assume !$_$_condition_$10;
	assume $_$_condition_$10 <==> ((0 <= k#56_$_0) && (k#56_$_0 < steps#31_$_0));
	assume !((0 <= k#56_$_0) && (k#56_$_0 < steps#31_$_0));
	goto anon34;
anon53_Then:
	assume $_$_condition_$12;
	assume $_$_condition_$12 <==> ((0 <= t#35_$_0) && (t#35_$_0 < steps#31_$_0));
	assume (0 <= t#35_$_0) && (t#35_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= t#35_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,t#35_$_0,S#0);
	goto anon12;
anon53_Else:
	assume !$_$_condition_$12;
	assume $_$_condition_$12 <==> ((0 <= t#35_$_0) && (t#35_$_0 < steps#31_$_0));
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
	assume (q#40_$_0 == null) || ($Heap[q#40_$_0,alloc] && (dtype(q#40_$_0) == class._module.Node));
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
	assume (((forall  $o_$27_$0 : ref, $f_$26_$0 : Field (Boolean)  :: {$Heap[$o_$27_$0,$f_$26_$0]} ( ((!($o_$27_$0 == null)) && $Heap[$o_$27_$0,alloc]) ==> (($Heap[$o_$27_$0,$f_$26_$0] == $Heap[$o_$27_$0,$f_$26_$0]) || $_Frame_$_0[$o_$27_$0,$f_$26_$0]) ))) && ((forall  $o_$27_$1 : ref, $f_$26_$1 : Field (BoxType)  :: {$Heap[$o_$27_$1,$f_$26_$1]} ( ((!($o_$27_$1 == null)) && $Heap[$o_$27_$1,alloc]) ==> (($Heap[$o_$27_$1,$f_$26_$1] == $Heap[$o_$27_$1,$f_$26_$1]) || $_Frame_$_0[$o_$27_$1,$f_$26_$1]) )))) && ((forall  $o_$27_$2 : ref, $f_$26_$2 : Field (ref)  :: {$Heap[$o_$27_$2,$f_$26_$2]} ( ((!($o_$27_$2 == null)) && $Heap[$o_$27_$2,alloc]) ==> (($Heap[$o_$27_$2,$f_$26_$2] == $Heap[$o_$27_$2,$f_$26_$2]) || $_Frame_$_0[$o_$27_$2,$f_$26_$2]) )));
	assume ((steps#31_$_0 - A#1_$_1) <= $decr1$init$0_$_0) && (((steps#31_$_0 - A#1_$_1) == $decr1$init$0_$_0) ==> true);
	if ($_$_condition_$15) { goto anon65_LoopDone; } else { goto anon65_LoopBody; }
anon54_Then:
	assume $_$_condition_$14;
	assume $_$_condition_$14 <==> Visited#32_$_0[$Box(q#40_$_0)];
	assume Visited#32_$_0[$Box(q#40_$_0)];
	if ($_$_condition_$16) { goto anon55_Then; } else { goto anon55_Else; }
anon54_Else:
	assume !$_$_condition_$14;
	assume $_$_condition_$14 <==> Visited#32_$_0[$Box(q#40_$_0)];
	assume !Visited#32_$_0[$Box(q#40_$_0)];
	goto anon18;
anon65_LoopDone:
	assume $_$_condition_$15;
	assume $_$_condition_$15 <==> (!true);
	assume !true;
	goto anon46;
anon65_LoopBody:
	assume !$_$_condition_$15;
	assume $_$_condition_$15 <==> (!true);
	assume true;
	assume true;
	if ($_$_condition_$17) { goto anon66_Then; } else { goto anon66_Else; }
anon55_Then:
	assume $_$_condition_$16;
	assume $_$_condition_$16 <==> (!(q#40_$_0 == null));
	assume !(q#40_$_0 == null);
	if ($_$_condition_$18) { goto anon56_Then; } else { goto anon56_Else; }
anon55_Else:
	assume !$_$_condition_$16;
	assume $_$_condition_$16 <==> (!(q#40_$_0 == null));
	assume q#40_$_0 == null;
	goto anon18;
anon18:
	assume (forall  q#45_$5 : ref :: ( ((q#45_$5 == null) || ($Heap[q#45_$5,alloc] && (dtype(q#45_$5) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$5)] ==> ((!(q#45_$5 == null)) ==> ((forall  t#44_$5 : Integer :: ( true ==> (((0 <= t#44_$5) ==> true) && (((0 <= t#44_$5) && (t#44_$5 < steps#31_$_0)) ==> _module.Node.Nexxxt#canCall($Heap,this,t#44_$5,S#0))) ))))) ));
	assume (forall  q#45_$6 : ref :: ( ((q#45_$6 == null) || ($Heap[q#45_$6,alloc] && (dtype(q#45_$6) == class._module.Node))) ==> (Visited#32_$_0[$Box(q#45_$6)] ==> ((q#45_$6 == null) || ((exists  t#44_$6 : Integer :: ( ((0 <= t#44_$6) && (t#44_$6 < steps#31_$_0)) && (_module.Node.Nexxxt($LS($LZ),$Heap,this,t#44_$6,S#0) == q#45_$6) ))))) ));
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
	assert  (((forall  $o_$28_$0 : ref, $f_$27_$0 : Field (Boolean)  :: ( false ==> $_Frame_$_0[$o_$28_$0,$f_$27_$0] ))) && ((forall  $o_$28_$1 : ref, $f_$27_$1 : Field (BoxType)  :: ( false ==> $_Frame_$_0[$o_$28_$1,$f_$27_$1] )))) && ((forall  $o_$28_$2 : ref, $f_$27_$2 : Field (ref)  :: ( false ==> $_Frame_$_0[$o_$28_$2,$f_$27_$2] )));
	assert  _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(this)]);
	assert  _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || S#0[$Box(null)]);
	assert  _module.Node.IsClosed#canCall($Heap,this,S#0) ==> (_module.Node.IsClosed($Heap,this,S#0) || ((forall  n#12 : ref :: ( ((n#12 == null) || ($Heap[n#12,alloc] && (dtype(n#12) == class._module.Node))) ==> (((S#0[$Box(n#12)] && (!(n#12 == null))) && (!($Heap[n#12,_module.Node.next] == null))) ==> S#0[$Box($Heap[n#12,_module.Node.next])]) ))));
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
	assume $_$_condition_$17;
	assume $_$_condition_$17 <==> (!$w1_$_0);
	assume !$w1_$_0;
	if ($_$_condition_$19) { goto anon67_Then; } else { goto anon67_Else; }
anon66_Else:
	assume !$_$_condition_$17;
	assume $_$_condition_$17 <==> (!$w1_$_0);
	assume $w1_$_0;
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= A#1_$_1);
	assume _module.Node.Nexxxt#canCall($Heap,this,A#1_$_1,S#0);
	assume _module.Node.Nexxxt#canCall($Heap,this,A#1_$_1,S#0);
	if ($_$_condition_$20) { goto anon70_Then; } else { goto anon70_Else; }
anon56_Then:
	assume $_$_condition_$18;
	assume 0 <= t#41_$_0;
	goto $branchMerge_4;
anon56_Else:
	assume !$_$_condition_$18;
	assume t#41_$_0 < 0;
	goto $branchMerge_4;
anon67_Then:
	assume $_$_condition_$19;
	assume 0 <= A#1_$_1;
	goto anon38;
anon67_Else:
	assume !$_$_condition_$19;
	assume A#1_$_1 < 0;
	goto anon38;
anon70_Then:
	assume $_$_condition_$20;
	assume $_$_condition_$20 <==> (_module.Node.Nexxxt($LS($LZ),$Heap,this,A#1_$_1,S#0) == p#30_$_0);
	assume _module.Node.Nexxxt($LS($LZ),$Heap,this,A#1_$_1,S#0) == p#30_$_0;
	goto anon46;
anon70_Else:
	assume !$_$_condition_$20;
	assume $_$_condition_$20 <==> (_module.Node.Nexxxt($LS($LZ),$Heap,this,A#1_$_1,S#0) == p#30_$_0);
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
	assume $_$_condition_$21;
	assume $_$_condition_$21 <==> ((0 <= t#41_$_0) && (t#41_$_0 < steps#31_$_0));
	assume (0 <= t#41_$_0) && (t#41_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= t#41_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,t#41_$_0,S#0);
	goto anon18;
anon57_Else:
	assume !$_$_condition_$21;
	assume $_$_condition_$21 <==> ((0 <= t#41_$_0) && (t#41_$_0 < steps#31_$_0));
	assume !((0 <= t#41_$_0) && (t#41_$_0 < steps#31_$_0));
	goto anon18;
anon38:
	assume (0 <= A#1_$_1) ==> true;
	assume (0 <= A#1_$_1) && (A#1_$_1 < steps#31_$_0);
	if ($_$_condition_$23) { goto anon68_Then; } else { goto anon68_Else; }
anon68_Then:
	assume $_$_condition_$23;
	assume 0 <= k#60_$_0;
	goto $branchMerge_5;
anon68_Else:
	assume !$_$_condition_$23;
	assume k#60_$_0 < 0;
	goto $branchMerge_5;
anon58_Then:
	assume $_$_condition_$24;
	assume 0 <= k#46_$_0;
	goto $branchMerge_6;
anon58_Else:
	assume !$_$_condition_$24;
	assume k#46_$_0 < 0;
	goto $branchMerge_6;
anon69_Then:
	assume $_$_condition_$25;
	assume $_$_condition_$25 <==> ((0 <= k#60_$_0) && (k#60_$_0 < A#1_$_1));
	assume (0 <= k#60_$_0) && (k#60_$_0 < A#1_$_1);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= k#60_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,k#60_$_0,S#0);
	goto anon42;
anon69_Else:
	assume !$_$_condition_$25;
	assume $_$_condition_$25 <==> ((0 <= k#60_$_0) && (k#60_$_0 < A#1_$_1));
	assume !((0 <= k#60_$_0) && (k#60_$_0 < A#1_$_1));
	goto anon42;
anon59_Then:
	assume $_$_condition_$27;
	assume $_$_condition_$27 <==> ((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0));
	assume (0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0);
	goto $branchMerge_7;
anon59_Else:
	assume !$_$_condition_$27;
	assume $_$_condition_$27 <==> ((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0));
	assume !((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0));
	goto $branchMerge_7;
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
	assume $_$_condition_$29;
	assume $_$_condition_$29 <==> (((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0)) && (l#47_$_0 < steps#31_$_0));
	assume ((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0)) && (l#47_$_0 < steps#31_$_0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= k#46_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,k#46_$_0,S#0);
	assert  _module.Node.IsClosed($Heap,this,S#0) && (0 <= l#47_$_0);
	assume _module.Node.Nexxxt#canCall($Heap,this,l#47_$_0,S#0);
	goto anon24;
anon60_Else:
	assume !$_$_condition_$29;
	assume $_$_condition_$29 <==> (((0 <= k#46_$_0) && (k#46_$_0 < l#47_$_0)) && (l#47_$_0 < steps#31_$_0));
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
$branchMerge_0:
	if ($_$_condition_$3) { goto anon50_Then; } else { goto anon50_Else; }
$branchMerge_1:
	if ($_$_condition_$5) { goto anon51_Then; } else { goto anon51_Else; }
$branchMerge_2:
	if ($_$_condition_$10) { goto anon64_Then; } else { goto anon64_Else; }
$branchMerge_3:
	if ($_$_condition_$12) { goto anon53_Then; } else { goto anon53_Else; }
$branchMerge_4:
	if ($_$_condition_$21) { goto anon57_Then; } else { goto anon57_Else; }
$branchMerge_5:
	if ($_$_condition_$25) { goto anon69_Then; } else { goto anon69_Else; }
$branchMerge_6:
	if ($_$_condition_$27) { goto anon59_Then; } else { goto anon59_Else; }
$branchMerge_7:
	if ($_$_condition_$29) { goto anon60_Then; } else { goto anon60_Else; }
}
