type Integer = int;
type Boolean = bool;
type Set T = [T]bool;
type MultiSet T = [T]int;
type HeapType = <alpha>[ref,Field (alpha)]alpha;
type ref;
type Seq m0;
type BoxType;
type ClassName;
type DatatypeType;
type DtCtorId;
type Field m0;
type TickType;
const $$Language$Dafny : bool;
const null : ref;
const $ModuleContextHeight : int;
const $FunctionContextHeight : int;
const $InMethodContext : bool;
const unique alloc : Field (bool);
const unique class.AVLTree : ClassName;
const unique AVLTree.root : Field (ref);
const unique AVLTree.Contents : Field (Set (BoxType) );
const unique AVLTree.Repr : Field (Set (BoxType) );
const unique class.Node : ClassName;
const unique Node.value : Field (int);
const unique Node.balance : Field (int);
const unique Node.left : Field (ref);
const unique Node.right : Field (ref);
const unique Node.Contents : Field (Set (BoxType) );
const unique Node.Repr : Field (Set (BoxType) );
const unique Node.height : Field (int);
function Set#Empty <T> () : Set (T) ;
function Set#Singleton <T> (T) : Set (T) ;
function Set#UnionOne <T> (Set (T) ,T) : Set (T) ;
function Set#Union <T> (Set (T) ,Set (T) ) : Set (T) ;
function Set#Intersection <T> (Set (T) ,Set (T) ) : Set (T) ;
function Set#Difference <T> (Set (T) ,Set (T) ) : Set (T) ;
function Set#Subset <T> (Set (T) ,Set (T) ) : bool;
function Set#Equal <T> (Set (T) ,Set (T) ) : bool;
function Set#Disjoint <T> (Set (T) ,Set (T) ) : bool;
function Set#Choose <T> (Set (T) ,TickType) : T;
function Math#min(int,int) : int;
function Math#clip(int) : int;
function MultiSet#Singleton <T> (T) : MultiSet (T) ;
function MultiSet#UnionOne <T> (MultiSet (T) ,T) : MultiSet (T) ;
function MultiSet#Union <T> (MultiSet (T) ,MultiSet (T) ) : MultiSet (T) ;
function MultiSet#Intersection <T> (MultiSet (T) ,MultiSet (T) ) : MultiSet (T) ;
function MultiSet#Difference <T> (MultiSet (T) ,MultiSet (T) ) : MultiSet (T) ;
function MultiSet#Equal <T> (MultiSet (T) ,MultiSet (T) ) : bool;
function MultiSet#FromSet <T> (Set (T) ) : MultiSet (T) ;
function Seq#Length <T> (Seq (T)) : int;
function Seq#Empty <T> () : Seq (T);
function Seq#Singleton <T> (T) : Seq (T);
function Seq#Build <T> (Seq (T),int,T,int) : Seq (T);
function Seq#Append <T> (Seq (T),Seq (T)) : Seq (T);
function Seq#Index <T> (Seq (T),int) : T;
function Seq#Update <T> (Seq (T),int,T) : Seq (T);
function Seq#Contains <T> (Seq (T),T) : bool;
function Seq#Equal <T> (Seq (T),Seq (T)) : bool;
function Seq#Take <T> (Seq (T),int) : Seq (T);
function Seq#Drop <T> (Seq (T),int) : Seq (T);
function Seq#FromArray(HeapType,ref) : Seq (BoxType);
function $Box <T> (T) : BoxType;
function $Unbox <T> (BoxType) : T;
function $IsCanonicalBoolBox(BoxType) : bool;
function dtype(ref) : ClassName;
function TypeTuple(ClassName,ClassName) : ClassName;
function TypeTupleCar(ClassName) : ClassName;
function TypeTupleCdr(ClassName) : ClassName;
function DtType(DatatypeType) : ClassName;
function FDim <T> (Field (T)) : int;
function IndexField(int) : Field (BoxType);
function MultiIndexField(Field (BoxType),int) : Field (BoxType);
function MultiIndexField_Inverse0 <T> (Field (T)) : Field (T);
function MultiIndexField_Inverse1 <T> (Field (T)) : int;
function DeclType <T> (Field (T)) : ClassName;
function DtAlloc(DatatypeType,HeapType) : bool;
function GenericAlloc(BoxType,HeapType) : bool;
function array.Length(ref) : int;
function {:inline  true} read <alpha> (H:HeapType,r:ref,f:Field (alpha)) : alpha {H[r,f]}
function $IsGoodHeap(HeapType) : bool;
function $HeapSucc(HeapType,HeapType) : bool;
function AVLTree.Valid(HeapType,ref) : bool;
function AVLTree.Valid#canCall(HeapType,ref) : bool;
function Node.Balanced(HeapType,ref) : bool;
function Node.Balanced#limited(HeapType,ref) : bool;
function Node.Balanced#2(HeapType,ref) : bool;
function Node.Balanced#canCall(HeapType,ref) : bool;
function Node.BalanceValid(HeapType,ref) : bool;
function Node.BalanceValid#limited(HeapType,ref) : bool;
function Node.BalanceValid#2(HeapType,ref) : bool;
function Node.BalanceValid#canCall(HeapType,ref) : bool;
function Node.Height(HeapType,ref) : int;
function Node.Height#canCall(HeapType,ref) : bool;
function Node.Valid(HeapType,ref) : bool;
function Node.Valid#limited(HeapType,ref) : bool;
function Node.Valid#2(HeapType,ref) : bool;
function Node.Valid#canCall(HeapType,ref) : bool;
function Math.max(HeapType,int,int) : int;
function Math.max#limited(HeapType,int,int) : int;
function Math.max#2(HeapType,int,int) : int;
function Math.max#canCall(HeapType,int,int) : bool;
function lambda#6(Field (Set (BoxType) ),ref,HeapType,Field (bool),ref) : <alpha>[ref,Field (alpha)]bool;
var $Heap : HeapType;
procedure AVLTree.Insert (this : ref,key#4 : int)
{
	var $rhs#0 : ref;
	var $_Frame_$_0 : <beta>[ref,Field (beta)]bool;
	var t#51_$_0 : ref;
	var $Heap_$_0 : HeapType;
	var call5formal_$_r#8_$_0 : ref;
	var call6formal_$_deltaH#9_$_0 : int;
	var $Heap_$_1 : HeapType;
	var $rhs#2_$_0 : Set (BoxType) ;
	var $Heap_$_2 : HeapType;
	var $rhs#3_$_0 : Set (BoxType) ;
	var $Heap_$_3 : HeapType;
$start:
	assume (forall  a_$15_$0 : Set (BoxType) , b_$12_$0 : Set (BoxType)  :: {Set#Equal(a_$15_$0,b_$12_$0)} ( Set#Equal(a_$15_$0,b_$12_$0) ==> (a_$15_$0 == b_$12_$0) ));
	assume ((forall  s_$3_$0 : Seq (ref) , i_$0_$0 : Integer, v_$1_$0 : ref, len_$0_$0 : Integer, n_$0_$0 : Integer :: {Seq#Index(Seq#Build(s_$3_$0,i_$0_$0,v_$1_$0,len_$0_$0),n_$0_$0)} ( ((0 <= n_$0_$0) && (n_$0_$0 < len_$0_$0)) ==> (((i_$0_$0 == n_$0_$0) ==> (Seq#Index(Seq#Build(s_$3_$0,i_$0_$0,v_$1_$0,len_$0_$0),n_$0_$0) == v_$1_$0)) && ((!(i_$0_$0 == n_$0_$0)) ==> (Seq#Index(Seq#Build(s_$3_$0,i_$0_$0,v_$1_$0,len_$0_$0),n_$0_$0) == Seq#Index(s_$3_$0,n_$0_$0)))) ))) && ((forall  s_$3_$1 : Seq (BoxType) , i_$0_$1 : Integer, v_$1_$1 : BoxType, len_$0_$1 : Integer, n_$0_$1 : Integer :: {Seq#Index(Seq#Build(s_$3_$1,i_$0_$1,v_$1_$1,len_$0_$1),n_$0_$1)} ( ((0 <= n_$0_$1) && (n_$0_$1 < len_$0_$1)) ==> (((i_$0_$1 == n_$0_$1) ==> (Seq#Index(Seq#Build(s_$3_$1,i_$0_$1,v_$1_$1,len_$0_$1),n_$0_$1) == v_$1_$1)) && ((!(i_$0_$1 == n_$0_$1)) ==> (Seq#Index(Seq#Build(s_$3_$1,i_$0_$1,v_$1_$1,len_$0_$1),n_$0_$1) == Seq#Index(s_$3_$1,n_$0_$1)))) )));
	assume ((forall  s_$4_$0 : Seq (ref) , i_$1_$0 : Integer, v_$2_$0 : ref :: {Seq#Length(Seq#Update(s_$4_$0,i_$1_$0,v_$2_$0))} ( ((0 <= i_$1_$0) && (i_$1_$0 < Seq#Length(s_$4_$0))) ==> (Seq#Length(Seq#Update(s_$4_$0,i_$1_$0,v_$2_$0)) == Seq#Length(s_$4_$0)) ))) && ((forall  s_$4_$1 : Seq (BoxType) , i_$1_$1 : Integer, v_$2_$1 : BoxType :: {Seq#Length(Seq#Update(s_$4_$1,i_$1_$1,v_$2_$1))} ( ((0 <= i_$1_$1) && (i_$1_$1 < Seq#Length(s_$4_$1))) ==> (Seq#Length(Seq#Update(s_$4_$1,i_$1_$1,v_$2_$1)) == Seq#Length(s_$4_$1)) )));
	assume ((forall  s_$5_$0 : Seq (ref) , i_$2_$0 : Integer, v_$3_$0 : ref, n_$1_$0 : Integer :: {Seq#Index(Seq#Update(s_$5_$0,i_$2_$0,v_$3_$0),n_$1_$0)} ( ((0 <= n_$1_$0) && (n_$1_$0 < Seq#Length(s_$5_$0))) ==> (((i_$2_$0 == n_$1_$0) ==> (Seq#Index(Seq#Update(s_$5_$0,i_$2_$0,v_$3_$0),n_$1_$0) == v_$3_$0)) && ((!(i_$2_$0 == n_$1_$0)) ==> (Seq#Index(Seq#Update(s_$5_$0,i_$2_$0,v_$3_$0),n_$1_$0) == Seq#Index(s_$5_$0,n_$1_$0)))) ))) && ((forall  s_$5_$1 : Seq (BoxType) , i_$2_$1 : Integer, v_$3_$1 : BoxType, n_$1_$1 : Integer :: {Seq#Index(Seq#Update(s_$5_$1,i_$2_$1,v_$3_$1),n_$1_$1)} ( ((0 <= n_$1_$1) && (n_$1_$1 < Seq#Length(s_$5_$1))) ==> (((i_$2_$1 == n_$1_$1) ==> (Seq#Index(Seq#Update(s_$5_$1,i_$2_$1,v_$3_$1),n_$1_$1) == v_$3_$1)) && ((!(i_$2_$1 == n_$1_$1)) ==> (Seq#Index(Seq#Update(s_$5_$1,i_$2_$1,v_$3_$1),n_$1_$1) == Seq#Index(s_$5_$1,n_$1_$1)))) )));
	assume ((forall  s_$6_$0 : Seq (ref) , x_$6_$0 : ref :: {Seq#Contains(s_$6_$0,x_$6_$0)} ( Seq#Contains(s_$6_$0,x_$6_$0) <==> ((exists  i_$3_$1 : Integer :: {Seq#Index(s_$6_$0,i_$3_$1)} ( ((0 <= i_$3_$1) && (i_$3_$1 < Seq#Length(s_$6_$0))) && (Seq#Index(s_$6_$0,i_$3_$1) == x_$6_$0) ))) ))) && ((forall  s_$6_$1 : Seq (BoxType) , x_$6_$1 : BoxType :: {Seq#Contains(s_$6_$1,x_$6_$1)} ( Seq#Contains(s_$6_$1,x_$6_$1) <==> ((exists  i_$3_$3 : Integer :: {Seq#Index(s_$6_$1,i_$3_$3)} ( ((0 <= i_$3_$3) && (i_$3_$3 < Seq#Length(s_$6_$1))) && (Seq#Index(s_$6_$1,i_$3_$3) == x_$6_$1) ))) )));
	assume (forall  $o_$21_$0 : ref, $f_$15_$0 : Field (Boolean) , AVLTree.Repr_$2_$0 : Field (Set (BoxType) ) , null_$6_$0 : ref, $Heap_$24_$0 : HeapType, alloc_$6_$0 : Field (Boolean) , this_$6_$0 : ref :: 
						{lambda#6(AVLTree.Repr_$2_$0,null_$6_$0,$Heap_$24_$0,alloc_$6_$0,this_$6_$0)[$o_$21_$0,$f_$15_$0]} 
						( 
							lambda#6(AVLTree.Repr_$2_$0,null_$6_$0,$Heap_$24_$0,alloc_$6_$0,this_$6_$0)[$o_$21_$0,$f_$15_$0] 
							<==> 
							(((!($o_$21_$0 == null_$6_$0)) && $Heap_$24_$0[$o_$21_$0,alloc_$6_$0]) ==> (($o_$21_$0 == this_$6_$0) || $Heap_$24_$0[this_$6_$0,AVLTree.Repr_$2_$0][$Box($o_$21_$0)]))
						)
					);

	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	assume (((((((AVLTree.Valid#canCall($Heap,this) && AVLTree.Valid($Heap,this)) && (!($Heap[this,AVLTree.root] == null))) && $Heap[this,AVLTree.Repr][$Box($Heap[this,AVLTree.root])]) && Set#Equal($Heap[this,AVLTree.Repr],$Heap[read($Heap,this,AVLTree.root),Node.Repr])) && Set#Equal($Heap[this,AVLTree.Contents],$Heap[read($Heap,this,AVLTree.root),Node.Contents])) && Node.Valid($Heap,$Heap[this,AVLTree.root])) && Node.BalanceValid($Heap,$Heap[this,AVLTree.root])) && Node.Balanced($Heap,$Heap[this,AVLTree.root]);
	
	goto anon0;
anon0:
	assume $_Frame_$_0 == lambda#6(AVLTree.Repr,null,$Heap,alloc,this);
	assume true;
//	assert  $_Frame_$_0[this,AVLTree.root];
	assume true;
	assume true;
	assume t#51_$_0 == $Heap[this,AVLTree.root];
	assume true;
	assert (forall  $o_$41_$0 : ref, $f_$35_$0 : Field (Boolean)  :: 
			( 
				(
					!($o_$41_$0 == null)
					&& $Heap[$o_$41_$0,alloc]
					&& (!(t#51_$_0 == null))
					&& $Heap[t#51_$_0,Node.Repr][$Box($o_$41_$0)]
				) ==> $_Frame_$_0[$o_$41_$0,$f_$35_$0] ));
	assume false;
	goto $exit;
}
