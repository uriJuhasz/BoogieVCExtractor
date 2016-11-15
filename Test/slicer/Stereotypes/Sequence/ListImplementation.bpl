//Begin: class Node

const unique Node_next: field ref;

//End: class Node

//Begin: class List

const unique List_head: field ref;

function ListClassInv(h: THeap, list: ref) returns (bool);
axiom (forall h: THeap, list: ref :: ListClassInv(h, list) <==>(
  h[list, List_head] != null ==> (
       (forall o : ref :: h[h[list, List_head], LL][o] ==> h[o, Node_next] == h[o, Ln])
    && h[list, List_head] == h[h[list, List_head], Lb]
)));

function InList(h: THeap, list: ref, el: ref)returns (bool);
axiom (forall h: THeap, list: ref, el: ref :: InList(h, list, el) <==>(
  h[list, List_head] != null && h[h[list, List_head], LL][el]
));


function ListEmpty(h: THeap, list: ref) returns (bool);
axiom (forall h: THeap, list: ref :: ListEmpty(h, list) <==> h[list, List_head] == null);


procedure GetItBegin(list: ref, it: ref)

modifies $Heap;

requires InvList($Heap);

requires list != null;
requires it != null;
requires ListClassInv($Heap, list);

ensures InvList($Heap);

ensures ListClassInv($Heap, list);
ensures ItClassInv($Heap, it);

ensures $Heap[it, It_el] == old($Heap)[list, List_head];
ensures $Heap[it, It_List] == list;

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == it && f == It_el)
          || (o == it && f == It_List)  
);

{
  $Heap[it, It_el] := $Heap[list, List_head];
  $Heap[it, It_List] := list;

}

//End: class List



//Begin: claas Iterator

const unique It_el: field ref;
const unique It_List: field ref;

function ItClassInv(h: THeap, it: ref) returns (bool);
axiom (forall h: THeap, it: ref :: ItClassInv(h, it) <==>(
     h[it, It_List] != null
  && (h[it, It_el] != null ==> InList(h, h[it, It_List], h[it, It_el]))
  && ListClassInv(h, h[it, It_List])
));

procedure ItRemoveNext(it: ref)

modifies $Heap;

requires it != null;
requires InvList($Heap);
requires ItClassInv($Heap, it);
requires $Heap[it, It_el] != null;
requires $Heap[it, It_el] != $Heap[$Heap[it, It_el], Le];

ensures ItClassInv($Heap, it);

ensures  $Heap[old($Heap)[it, It_el], Node_next] == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Node_next];

ensures (forall itp: ref ::
  (   itp != null 
  && (old($Heap)[itp, It_el] != old($Heap)[old($Heap)[it, It_el], Node_next] || old($Heap)[itp, It_List] != old($Heap)[it, It_List])
  && ItClassInv(old($Heap), itp))
  ==> ItClassInv($Heap, it)
);


//These specifications represent RemoveEl(next)

ensures InvList($Heap);

ensures IsEmptyList($Heap, old($Heap)[old($Heap)[it, It_el], Node_next]);

ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] == old($Heap)[old($Heap)[it, It_el], Node_next] ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp], Ln] == null;
ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] == old($Heap)[old($Heap)[it, It_el], Node_next] ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln], Lp] == null;
ensures (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] != old($Heap)[old($Heap)[it, It_el], Node_next] && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] != old($Heap)[old($Heap)[it, It_el], Node_next]) ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp], Ln] == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln];
ensures (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] != old($Heap)[old($Heap)[it, It_el], Node_next] && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] != old($Heap)[old($Heap)[it, It_el], Node_next]) ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln], Lp] == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp];

ensures (forall o: ref :: RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], old($Heap)[old($Heap)[it, It_el], Node_next])[o] ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], old($Heap)[old($Heap)[it, It_el], Node_next])));
ensures (forall o: ref :: old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LPC][o] ==> Equal($Heap[o, LNC], RemEl(old($Heap)[o, LNC], old($Heap)[old($Heap)[it, It_el], Node_next])));
ensures (forall o: ref :: old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LNC][o] ==> Equal($Heap[o, LPC], RemEl(old($Heap)[o, LPC], old($Heap)[old($Heap)[it, It_el], Node_next])));

ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] == old($Heap)[old($Heap)[it, It_el], Node_next] ==> (forall o: ref :: RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], old($Heap)[old($Heap)[it, It_el], Node_next])[o] ==> $Heap[o, Le] == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp]);
ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] == old($Heap)[old($Heap)[it, It_el], Node_next] ==> (forall o: ref :: RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], old($Heap)[old($Heap)[it, It_el], Node_next])[o] ==> $Heap[o, Lb] == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln]);


//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == old($Heap)[it, It_el] && f == Node_next)
          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] == old($Heap)[old($Heap)[it, It_el], Node_next] && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp] && f == Ln)
          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] == old($Heap)[old($Heap)[it, It_el], Node_next] && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln] && f == Lp)
          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] != old($Heap)[old($Heap)[it, It_el], Node_next] && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] != old($Heap)[old($Heap)[it, It_el], Node_next] && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp] && f == Ln)
          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] != old($Heap)[old($Heap)[it, It_el], Node_next] && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] != old($Heap)[old($Heap)[it, It_el], Node_next] && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln] && f == Lp)
          || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Lp)
          || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Ln)
          || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Lb)
          || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Le)
          || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == LPC)
          || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == LNC)
          || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == LL)

          || (RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], old($Heap)[old($Heap)[it, It_el], Node_next])[o] && f == LL)
          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LPC][o] && f == LNC)
          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LNC][o] && f == LPC)

          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le] == old($Heap)[old($Heap)[it, It_el], Node_next] && RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], old($Heap)[old($Heap)[it, It_el], Node_next])[o] && f == Le)
          || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb] == old($Heap)[old($Heap)[it, It_el], Node_next] && RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], old($Heap)[old($Heap)[it, It_el], Node_next])[o] && f == Lb)
);

//End of the RemoveEl(next) specifications

{
  call RemoveEl($Heap[$Heap[it, It_el], Node_next]);
  $Heap[$Heap[it, It_el], Node_next] := $Heap[$Heap[$Heap[it, It_el], Node_next], Node_next];
}

procedure ItInsertAfter(it: ref, el: ref)

modifies $Heap;

requires it != null;
requires el != null;
requires InvList($Heap);
requires ItClassInv($Heap, it);
requires IsEmptyList($Heap, el);
requires !InList($Heap, $Heap[it, It_List], el);
requires $Heap[it, It_el] != null;

ensures ItClassInv($Heap, it);

ensures $Heap[old($Heap)[it, It_el], Node_next] == el;
ensures $Heap[el, Node_next] == old($Heap)[$Heap[it, It_el], Node_next];

ensures (forall itp: ref :: (itp != null && ItClassInv(old($Heap), itp)) ==> ItClassInv($Heap, it));

//These specifications represent InsertAfter($Heap[it, It_el], el)

ensures InvList($Heap);

ensures $Heap[$Heap[it, It_el], Ln] == el;
ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el] ==> $Heap[old($Heap)[$Heap[it, It_el], Ln], Lp] == el;
ensures $Heap[el, Lp] == $Heap[it, It_el];
ensures $Heap[el, Ln] == old($Heap)[$Heap[it, It_el], Ln];
ensures  $Heap[el, Lb] == $Heap[$Heap[it, It_el], Lb];
ensures $Heap[el, Le] == $Heap[$Heap[it, It_el], Le];
ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el] ==> $Heap[el, LPC] == old($Heap)[old($Heap)[$Heap[it, It_el], Ln], LPC];
ensures old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el] ==> $Heap[el, LPC] == old($Heap)[$Heap[it, It_el], LL];
ensures Equal($Heap[el, LNC], old($Heap)[$Heap[it, It_el], LNC]);
ensures  $Heap[el, LL] == AddEl(old($Heap)[$Heap[it, It_el], LL], el);

ensures (forall o: ref :: old($Heap)[$Heap[it, It_el], LL][o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
ensures old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el] ==> (forall o: ref :: old($Heap)[$Heap[it, It_el], LL][o] ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el] ==> (forall o: ref :: old($Heap)[old($Heap)[$Heap[it, It_el], Ln], LPC][o] ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el] ==> (forall o: ref :: old($Heap)[$Heap[it, It_el], LNC][o] ==> Equal($Heap[o, LPC], AddEl(old($Heap)[o, LPC], el)));
ensures old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el] ==> (forall o: ref :: old($Heap)[$Heap[it, It_el], LL][o] ==> $Heap[o, Le] == el);


//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == old($Heap)[it, It_el] && f == Node_next)
          || (o == el && f == Node_next)

          || (old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el] && o == $Heap[it, It_el] && f == Ln)
          || (old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el] && o == old($Heap)[$Heap[it, It_el], Ln] && f == Lp)

          || (o == old($Heap)[$Heap[it, It_el], Le] && f == Ln)
          || (o == el && f == Lp)
          || (o == el && f == Ln)
          || (o == el && f == Lb)
          || (o == el && f == Le)
          || (o == el && f == LPC)
          || (o == el && f == LNC)
          || (o == el && f == LL)

          || (old($Heap)[$Heap[it, It_el], LL][o] && f == LL)
          || (old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el] && old($Heap)[old($Heap)[$Heap[it, It_el], Ln], LPC][o] && f == LNC)
          || (old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el] && old($Heap)[$Heap[it, It_el], LL][o] && f == LNC)
          || ( old($Heap)[$Heap[it, It_el], LNC][o] && f == LPC)
          || (old($Heap)[$Heap[it, It_el], LL][o] && f == Le)
);

//End of the InsertAfter($Heap[it, It_el], el) specifications

{

  var temp: ref;

  call InsertAfter($Heap[it, It_el], el);

  temp := $Heap[$Heap[it, It_el], Node_next];
  $Heap[$Heap[it, It_el], Node_next] := el;
  $Heap[el, Node_next] := temp;

}

//End: claas Iterator



//Begin: client code

const unique list1: ref;
const unique list2: ref;
const unique it11: ref;
const unique it12: ref;
const unique it2: ref;
const unique node: ref;

procedure main()

modifies $Heap;

requires InvList($Heap);

requires list1 != null;
requires ListClassInv($Heap, list1);
requires !ListEmpty($Heap, list1);
requires list2 != null;
requires ListClassInv($Heap, list2);
requires !ListEmpty($Heap, list2);
requires $Heap[list1, List_head] != $Heap[list2, List_head];
requires it11 != null;
requires it12 != null;
requires it2 != null;
requires node != null;
requires IsEmptyList($Heap, node);
requires !InList($Heap, list1, node);
requires !InList($Heap, list2, node);

{

  call GetItBegin(list1, it11);
  call GetItBegin(list1, it12);
  call GetItBegin(list2, it2);

  call ItInsertAfter(it11, node);

  assert InList($Heap, list1, node);
  assert !InList($Heap, list2, node);

  call ItRemoveNext(it12);

  assert !InList($Heap, list1, node);
  assert !InList($Heap, list2, node);

  call ItInsertAfter(it2, node);

  assert !InList($Heap, list1, node);
  assert InList($Heap, list2, node);

}

//End: client code