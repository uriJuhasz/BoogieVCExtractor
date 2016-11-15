function IsEmptyList($Heap: THeap, o: ref) returns (bool);
axiom (forall $Heap: THeap, o: ref :: IsEmptyList($Heap, o) <==> (
     $Heap[o, LL] == Singleton(o)
  && $Heap[o, Ln] == null
  && $Heap[o, Le] == o
  && $Heap[o, Lp] == null
  && $Heap[o, Lb] == o
));

procedure CreatEmptyList(o: ref, NotAllocated: TRegion)

modifies $Heap;

requires o!=null;
requires NotAllocated[o];
requires InvListEx($Heap, NotAllocated);
requires IsNotAllocatedList($Heap, o);

ensures InvListEx($Heap, RemEl(NotAllocated, o));
ensures IsEmptyList($Heap, o);
//Frame
ensures (forall <a> o':ref, f:field a :: $Heap[o',f] == old($Heap[o',f]) 
          || (o' == o && f == LL)
          || (o' == o && f == Ln)
          || (o' == o && f == Le)
          || (o' == o && f == Lp)
          || (o' == o && f == Lb)
);

{
  $Heap[o, LL] := Singleton(o);
  $Heap[o, Ln] := null;
  $Heap[o, Le] := o;
  $Heap[o, Lp] := null;
  $Heap[o, Lb] := o;
}

procedure AddToEnd(list: ref, el: ref)

modifies $Heap;

requires list != null;
requires el != null;
requires IsEmptyList($Heap, el);
requires !$Heap[list, LL][el];
requires InvList($Heap);
requires InvTree($Heap); //redundant

ensures InvList($Heap);
ensures InvTree($Heap); //redundant

//Frame property
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == old($Heap)[list, Le] && f == Ln)
          || (o == el && f == Lp)
          || (o == el && f == Lb)
          || (o == el && f == LL)
          || (old($Heap)[list, LL][o] && f == LL)
          || (old($Heap)[list, LL][o] && f == Le)
);

ensures  $Heap[old($Heap)[list, Le], Ln] == el;
ensures  $Heap[el, Lp] == old($Heap)[list, Le];
ensures  $Heap[el, Lb] == $Heap[list, Lb];
ensures  $Heap[el, LL] == AddEl(old($Heap)[list, LL], el);
ensures (forall o: ref :: old($Heap)[list, LL][o] ==>
           $Heap[o,LL] == Union(old($Heap)[o,LL], Singleton(el))
);
ensures (forall o: ref :: old($Heap)[list, LL][o] ==>
           $Heap[o,Le] == el
);
{

  var oldEnd: ref;
  var oldList: TRegion;

  oldEnd := $Heap[list, Le];
  oldList := $Heap[list, LL];

  $Heap[oldEnd, Ln] := el;
  $Heap[el, Lp] := oldEnd;
  $Heap[el, Lb] := $Heap[list, Lb];
  $Heap[el, LL] := AddEl(oldList, el);

  call addToAllIn(oldList, LL, Singleton(el));
  call assignToAllIn(oldList, Le, el);

}