type HeapType = <a>[ref,Field (a)]a;
type Field m0;
type ref;

const null : ref;
const unique left : Field ref;
const unique f1 : Field int;
const unique f2 : Field int;

var heap : HeapType;

procedure m(this : ref)
	modifies heap;
{
	assume this!=null;
	assume heap[this,left] != this;

	assume heap@0 == heap[this,f1 := 0];
	
	assume c1 == heap[this,left]!=null;
	if (c1) goto a0 else goto a1 //branch diamonds are merged as conditions are merged and no code in between

a0:
		heap@2 = heap@0[heap[this,left],f1 := 1];
		goto join1
a1:		
		heap@2 = heap@0[heap[this,left],f2 := 2];
		goto join1
join1:
	assert 0 == 0;  //transformed from heap@2[this,f2]==0 - discharged

	assume(c1); //from heap[this,left]==null) from heap@2[this,left]==null); 
	assert(2==2); //transformed from heap@2[heap[this,left],f2] == 2 by using path condition c) - discharged
}
