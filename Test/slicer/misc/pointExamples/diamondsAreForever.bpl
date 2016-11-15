type HeapType = <a>[ref,Field (a)]a;
type Field m0;
type ref;

const null : ref;
const unique left : Field ref;
const unique right : Field ref;
const unique f1 : Field int;
const unique f2 : Field int;

var heap : HeapType;

procedure m(this : ref)
	modifies heap;
{
	assume this!=null;
	assume heap[this,left] != this;

	heap[this,f1] := 0;
	
	if (heap[this,left]!=null)
	{
		heap[heap[this,left],f1] := 1;
	}else
	{
	}

	if (heap[this,left]==null)
	{
		heap[heap[this,left],f2] := 2;
	}else
	{
	}
	
	assert heap[this,f1] == 0;
	
	assume(heap[this,left]==null);
	assert(heap[heap[this,left],f2] == 2);
}
