type TMSet = [int]int;

function InMSet(TMSet, int) returns (bool);
axiom (forall m: TMSet, i: int :: { InMSet(m,i) }
  InMSet(m,i) <==> m[i] != 0);

const EmptyMSet: TMSet;
axiom (forall i: int :: { EmptyMSet[i] } !InMSet(EmptyMSet,i) );

function EqualMSet(TMSet, TMSet) returns (bool);
axiom(forall a: TMSet, b: TMSet :: { EqualMSet(a,b) }
  EqualMSet(a,b) <==> (forall i: int :: {a[i]} {b[i]} i>0 ==>a[i] == b[i]));


function AddMSet(TMSet, int) returns (TMSet);

axiom (forall a: TMSet, i :int :: {AddMSet(a,i)[i]}
  AddMSet(a,i)[i] == a[i] + 1);

axiom (forall a: TMSet, i :int, j: int :: {AddMSet(a,i)[j]}
  i != j ==> AddMSet(a,i)[j] == a[j]);

function RemoveMSet(TMSet, int) returns (TMSet);

axiom (forall a: TMSet, i :int :: {RemoveMSet(a,i)[i]}
  RemoveMSet(a,i)[i] == a[i] - 1);

axiom (forall a: TMSet, i :int, j: int :: {RemoveMSet(a,i)[j]}
  i != j ==> RemoveMSet(a,i)[j] == a[j]);

function MaxMSet(TMSet) returns (int);

axiom MaxMSet(EmptyMSet) == 0;


procedure MSet.increment(this :ref, mset : field TMSet, i : int)
modifies $Heap;
ensures $Heap[this, mset] == AddMSet(old($Heap[this, mset]),i);
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || (o==this && f==mset));
{
  $Heap[this, mset] := AddMSet($Heap[this, mset],i);
}

procedure MSet.decrement(this :ref, mset : field TMSet, i : int)
modifies $Heap;
ensures $Heap[this, mset] == RemoveMSet(old($Heap[this, mset]),i);
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || (o==this && f==mset));
{
  $Heap[this, mset] := RemoveMSet($Heap[this, mset],i);
}

axiom (forall s:TMSet, t:TMSet :: {EqualMSet(s,t)} EqualMSet(s,t) ==> (MaxMSet(s)==MaxMSet(t)));
