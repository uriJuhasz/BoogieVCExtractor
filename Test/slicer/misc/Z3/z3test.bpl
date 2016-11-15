// Copyright (c) 2008, Microsoft
type Field a;
type HeapType = <a>[Field a]a;

const f1 : Field int;

function read<T>(h:HeapType, f: Field T) returns (T)
{
  h[f]
}

var heap : HeapType;

procedure p() returns ( r : int )
	requires heap[f1]>0;
	ensures  r > 0; 
{
	var i : int;
	
	i := heap[f1];
	r := i;
}
