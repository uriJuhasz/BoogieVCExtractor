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
	assume (forall  a_$15_$0 : Set (BoxType) , b_$12_$0 : Set (BoxType)  :: 
		{Set#Equal(a_$15_$0,b_$12_$0)} 
		( Set#Equal(a_$15_$0,b_$12_$0) ==> (a_$15_$0 == b_$12_$0) ));
	assume (forall  
			$o : ref, 
			$f : Field (Boolean), 
			$r : Field (Set (BoxType) ), 
			$null : ref, 
			$H : HeapType, 
			$alloc : Field (Boolean) , 
			$this : ref :: 
		{lambda#6($r,$null,$H,$alloc,$this)[$o,$f]} 
		( 
			lambda#6($r,$null,$H,$alloc,$this)[$o,$f] 
			<==> 
			(
				(
					(!($o == $null)) 
					&& $H[$o,$alloc]
				) 
					==> 
				(
					($o == $this) 
					|| $H[$this,$r][$Box($o)]
				)
			)
		)
	);

	assume Set#Equal($Heap[this,AVLTree.Repr],$Heap[read($Heap,this,AVLTree.root),Node.Repr]);
	assume $_Frame_$_0 == lambda#6(AVLTree.Repr,null,$Heap,alloc,this);
	assume t#51_$_0 == $Heap[this,AVLTree.root];
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
$exit:
	assume false;
}
