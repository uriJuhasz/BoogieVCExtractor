type Ref;

type FieldRef;
type FieldInt;
type HeapRef = [Ref,FieldRef]Ref;
type HeapInt = [Ref,FieldInt]int;
const unique left : FieldRef;
const unique right : FieldRef;
const unique val : FieldInt;
var heapRef : HeapRef;
var heapInt : HeapInt;
/*
procedure m(this:Ref) returns (x:int)
	modifies heapRef;
	modifies heapInt;
	ensures x>0;
{
	var n : Ref;
	n := heapRef[this,next];
	x := heapInt[n,val];
}
*/
procedure m2(this:Ref) returns (x:int)
	modifies heapRef;
	modifies heapInt;
	ensures x>0;
{
	var n : Ref;
	var p : Ref;
	var newNode : Ref;
	var r :Ref;
	assume heapInt[heapRef[heapRef[this,right],left],val] == 5;
	assume this != heapRef[this,right];
	assume heapRef[this,left] != heapRef[this,right];
	assume heapRef[heapRef[this,right],left] != this;
	assume newNode != heapRef[this,right];
	assume newNode != heapRef[this,left];
	assume newNode != this;
	n := heapRef[this,left];
	x := heapInt[n,val];
	if (x>0)
	{
		heapRef[this,left] := newNode;
	}else{
		heapRef[this,left] := this;
	}
	heapRef[newNode,left] := this;
	if (x+x <10)
	{
		heapRef[this,left] := newNode;
	}else{
		heapRef[this,left] := this;
	}
	heapRef[newNode,left] := newNode;
	if (x*x <10)
	{
		heapRef[this,left] := newNode;
	}else{
		heapRef[this,left] := this;
	}
//	assert heapRef[this,left]!=heapRef[this,right];
//	heapRef[heapRef[this,left],left] := this;
	r := heapRef[this,right];
	r := heapRef[r,left];
	x := heapInt[r,val];
}

/*procedure m() returns ()
///  modifies Heap;
{
	var x : int;
	var y : int;
	var z : int;
	assume x+y==z;
	if (*)
	{
		x:=x+1;
	}else{
		y:=y+1;
	}
	assert(!(x+y==z+2));	
}

*/