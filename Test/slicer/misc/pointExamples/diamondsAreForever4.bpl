type HeapType = <a>[ref,Field (a)]a;
type Field _;
type ref;

const null : ref;
const unique left : Field ref;
const unique right : Field ref;
const unique f1 : Field int;
const unique f2 : Field int;

function f(int) returns (int);
function g(int) returns (int);
function hh(int) returns (int);

var heap : HeapType;

procedure m(this : ref, r:ref)
	modifies heap;
{
	assume r!=this;
	assume r!=heap[this,left];
	heap[r,f1] := 1;
	heap[r,f2] := 2;
	assert(heap[r,f1]==1);
	
	
	assume this!=null;
	heap[this,f1] := 0;
	assume heap[this,left] != this;
	if (heap[this,left]!=null)
	{
		heap[heap[this,left],f1] := 1;
	}else
	{
	}

	if (heap[this,left]!=null)
	{
		heap[heap[this,left],f2] := 2;
	}else
	{
	}
	assert heap[this,f1] == 0;
	
}
