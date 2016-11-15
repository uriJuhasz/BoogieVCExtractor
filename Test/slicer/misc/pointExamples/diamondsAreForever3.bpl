type HeapType = <a>[ref,Field (a)]a;
type Field m0;
type ref;

const null : ref;
const unique f1 : Field int;
const unique f2 : Field int;

function f(int) returns (int);

var heap : HeapType;
/*
procedure m(this : ref, x:int)
	modifies heap;
{
	assume this!=null;
	heap[this,f1] := 1;
	
	if (x>0)
	{
		heap[this,f2] := 2;
	}else
	{
	}
	assert heap[this,f1] == 1;
}
*/
function P(x:int) : bool;
function Q(x:int) : bool;
function R(x:int) : bool;

axiom { :qid "axiom1" } (forall x:int :: !P(x) || !Q(x) || R(x));

procedure m1(x : int)
	modifies heap;
{
	var y : int;
	if (x>0)
	{
		assume P(y);
	}else
	{
		assume Q(y);
	}
	assert R(y);
}
