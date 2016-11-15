// Boogie program verifier version 2.3.0.61016, Copyright (c) 2003-2014, Microsoft.
// Command Line Options: /trace /traceTimes /print:out.bpl ListOperations.bpl Heap.bpl Region.bpl ListStereotype.bpl ListInvariant.bpl ListImplementation.bpl

function IsEmptyList(h: THeap, o: ref) : bool;

axiom (forall h: THeap, o: ref :: 
  IsEmptyList(h, o)
     <==> Equal(h[o, LL], Singleton(o))
       && h[o, Ln] == null
       && Equal(h[o, LNC], Empty)
       && h[o, Le] == o
       && h[o, Lp] == null
       && Equal(h[o, LPC], Empty)
       && h[o, Lb] == o);

procedure CreatEmptyList(o: ref, NotAllocated: TRegion);
  requires o != null;
  requires NotAllocated[o];
  requires InvListEx($Heap, NotAllocated);
  requires IsNotAllocatedList($Heap, o);
  modifies $Heap;
  ensures InvListEx($Heap, RemEl(NotAllocated, o));
  ensures IsEmptyList($Heap, o);
  ensures (forall<a> o': ref, f: field a :: 
  $Heap[o', f] == old($Heap[o', f])
     || (o' == o && f == LL)
     || (o' == o && f == Ln)
     || (o' == o && f == LNC)
     || (o' == o && f == Le)
     || (o' == o && f == Lp)
     || (o' == o && f == LPC)
     || (o' == o && f == Lb));



implementation CreatEmptyList(o: ref, NotAllocated: TRegion)
{
    assert InvLL2Ex($Heap, NotAllocated, NotAllocated);
    $Heap[o, LL] := Singleton(o);
    assert InvLL2Ex($Heap, RemEl(NotAllocated, o), RemEl(NotAllocated, o));
    $Heap[o, Ln] := null;
    $Heap[o, LNC] := Empty;
    $Heap[o, Le] := o;
    $Heap[o, Lp] := null;
    $Heap[o, LPC] := Empty;
    $Heap[o, Lb] := o;
}



procedure AddToEnd(list: ref, el: ref);
  requires list != null;
  requires el != null;
  requires InvList($Heap);
  requires IsEmptyList($Heap, el);
  requires !$Heap[list, LL][el];
  modifies $Heap;
  ensures InvList($Heap);
  ensures $Heap[old($Heap)[list, Le], Ln] == el;
  ensures $Heap[el, Lp] == old($Heap)[list, Le];
  ensures $Heap[el, Ln] == null;
  ensures $Heap[el, Lb] == $Heap[list, Lb];
  ensures $Heap[el, Le] == el;
  ensures $Heap[el, LPC] == old($Heap)[list, LL];
  ensures $Heap[el, LNC] == Empty;
  ensures $Heap[el, LL] == AddEl(old($Heap)[list, LL], el);
  ensures (forall o: ref :: 
  old($Heap)[list, LL][o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
  ensures (forall o: ref :: 
  old($Heap)[list, LL][o] ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
  ensures (forall o: ref :: old($Heap)[list, LL][o] ==> $Heap[o, Le] == el);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == old($Heap)[list, Le] && f == Ln)
     || (o == el && f == Lp)
     || (o == el && f == Ln)
     || (o == el && f == Lb)
     || (o == el && f == Le)
     || (o == el && f == LPC)
     || (o == el && f == LNC)
     || (o == el && f == LL)
     || (old($Heap)[list, LL][o] && f == LL)
     || (old($Heap)[list, LL][o] && f == LNC)
     || (old($Heap)[list, LL][o] && f == Le));



implementation AddToEnd(list: ref, el: ref)
{
  var oldEnd: ref;
  var oldList: TRegion;

    oldEnd := $Heap[list, Le];
    oldList := $Heap[list, LL];
    $Heap[oldEnd, Ln] := el;
    $Heap[el, Lp] := oldEnd;
    $Heap[el, Ln] := null;
    $Heap[el, Lb] := $Heap[list, Lb];
    $Heap[el, Le] := el;
    $Heap[el, LPC] := oldList;
    $Heap[el, LNC] := Empty;
    $Heap[el, LL] := AddEl(oldList, el);
    call addToAllIn(oldList, LL, Singleton(el));
    call addToAllIn(oldList, LNC, Singleton(el));
    call assignToAllIn(oldList, Le, el);
    assert InvIsGoodRegionsList($Heap);
    assert InvL($Heap);
    assert InvNCPC($Heap);
    assert InvNCn1($Heap);
    assert InvNCn2($Heap);
    assert InvNCo($Heap);
    assert Inve1($Heap);
    assert Inve2($Heap);
    assert InvPCp1($Heap);
    assert InvPCp2($Heap);
    assert InvPCo($Heap);
    assert Invb1($Heap);
    assert Invb2($Heap);
    assert InvLb($Heap);
    assert InvLe($Heap);
    assert InvLL1($Heap);
    assert InvLL2($Heap);
    assert InvNCNC($Heap);
    assert InvPCPC($Heap);
    assert Invp($Heap);
}



procedure InsertAtTheMiddleAfter(listEl: ref, el: ref);
  requires listEl != null;
  requires el != null;
  requires InvList($Heap);
  requires IsEmptyList($Heap, el);
  requires !$Heap[listEl, LL][el];
  requires $Heap[listEl, Le] != listEl;
  modifies $Heap;
  ensures InvList($Heap);
  ensures $Heap[listEl, Ln] == el;
  ensures $Heap[old($Heap)[listEl, Ln], Lp] == el;
  ensures $Heap[el, Lp] == listEl;
  ensures $Heap[el, Ln] == old($Heap)[listEl, Ln];
  ensures $Heap[el, Lb] == $Heap[listEl, Lb];
  ensures $Heap[el, Le] == $Heap[listEl, Le];
  ensures $Heap[el, LPC] == old($Heap)[old($Heap)[listEl, Ln], LPC];
  ensures $Heap[el, LNC] == old($Heap)[listEl, LNC];
  ensures $Heap[el, LL] == AddEl(old($Heap)[listEl, LL], el);
  ensures (forall o: ref :: 
  old($Heap)[listEl, LL][o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
  ensures (forall o: ref :: 
  old($Heap)[old($Heap)[listEl, Ln], LPC][o]
     ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
  ensures (forall o: ref :: 
  old($Heap)[listEl, LNC][o]
     ==> Equal($Heap[o, LPC], AddEl(old($Heap)[o, LPC], el)));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == listEl && f == Ln)
     || (o == old($Heap)[listEl, Ln] && f == Lp)
     || (o == old($Heap)[listEl, Le] && f == Ln)
     || (o == el && f == Lp)
     || (o == el && f == Ln)
     || (o == el && f == Lb)
     || (o == el && f == Le)
     || (o == el && f == LPC)
     || (o == el && f == LNC)
     || (o == el && f == LL)
     || (old($Heap)[listEl, LL][o] && f == LL)
     || (old($Heap)[old($Heap)[listEl, Ln], LPC][o] && f == LNC)
     || (old($Heap)[listEl, LNC][o] && f == LPC));



implementation InsertAtTheMiddleAfter(listEl: ref, el: ref)
{
  var after: ref;
  var oldList: TRegion;

    after := $Heap[listEl, Ln];
    oldList := $Heap[listEl, LL];
    $Heap[listEl, Ln] := el;
    $Heap[after, Lp] := el;
    $Heap[el, Lp] := listEl;
    $Heap[el, Ln] := after;
    $Heap[el, Lb] := $Heap[listEl, Lb];
    $Heap[el, Le] := $Heap[listEl, Le];
    $Heap[el, LPC] := $Heap[after, LPC];
    $Heap[el, LNC] := $Heap[listEl, LNC];
    $Heap[el, LL] := AddEl(oldList, el);
    call addToAllIn(oldList, LL, Singleton(el));
    call addToAllIn($Heap[el, LPC], LNC, Singleton(el));
    call addToAllIn($Heap[el, LNC], LPC, Singleton(el));
    assert InvIsGoodRegionsList($Heap);
    assert InvL($Heap);
    assert InvNCPC($Heap);
    assert InvNCn1($Heap);
    assert InvNCn2($Heap);
    assert InvNCo($Heap);
    assert Inve1($Heap);
    assert Inve2($Heap);
    assert InvPCp1($Heap);
    assert InvPCo($Heap);
    assert Invb1($Heap);
    assert Invb2($Heap);
    assert InvLb($Heap);
    assert InvLe($Heap);
    assert InvLL1($Heap);
    assert InvLL2($Heap);
    assert InvPCPC($Heap);
    assert Invp($Heap);
    assert InvPCp2($Heap);
    assert (forall o: ref, o': ref :: 
  o != null && o' != null
     ==> 
    $Heap[o, LNC][o']
     ==> Sub($Heap[o', LNC], $Heap[o, LNC]));
    assert InvNCNC($Heap);
}



procedure InsertAfter(listEl: ref, el: ref);
  requires listEl != null;
  requires el != null;
  requires InvList($Heap);
  requires IsEmptyList($Heap, el);
  requires !$Heap[listEl, LL][el];
  modifies $Heap;
  ensures InvList($Heap);
  ensures $Heap[listEl, Ln] == el;
  ensures old($Heap)[listEl, Le] != listEl ==> $Heap[old($Heap)[listEl, Ln], Lp] == el;
  ensures $Heap[el, Lp] == listEl;
  ensures $Heap[el, Ln] == old($Heap)[listEl, Ln];
  ensures $Heap[el, Lb] == $Heap[listEl, Lb];
  ensures $Heap[el, Le] == $Heap[listEl, Le];
  ensures old($Heap)[listEl, Le] != listEl
   ==> $Heap[el, LPC] == old($Heap)[old($Heap)[listEl, Ln], LPC];
  ensures old($Heap)[listEl, Le] == listEl ==> $Heap[el, LPC] == old($Heap)[listEl, LL];
  ensures Equal($Heap[el, LNC], old($Heap)[listEl, LNC]);
  ensures $Heap[el, LL] == AddEl(old($Heap)[listEl, LL], el);
  ensures (forall o: ref :: 
  old($Heap)[listEl, LL][o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
  ensures old($Heap)[listEl, Le] == listEl
   ==> (forall o: ref :: 
    old($Heap)[listEl, LL][o]
       ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
  ensures old($Heap)[listEl, Le] != listEl
   ==> (forall o: ref :: 
    old($Heap)[old($Heap)[listEl, Ln], LPC][o]
       ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
  ensures old($Heap)[listEl, Le] != listEl
   ==> (forall o: ref :: 
    old($Heap)[listEl, LNC][o]
       ==> Equal($Heap[o, LPC], AddEl(old($Heap)[o, LPC], el)));
  ensures old($Heap)[listEl, Le] == listEl
   ==> (forall o: ref :: old($Heap)[listEl, LL][o] ==> $Heap[o, Le] == el);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (old($Heap)[listEl, Le] != listEl && o == listEl && f == Ln)
     || (old($Heap)[listEl, Le] != listEl && o == old($Heap)[listEl, Ln] && f == Lp)
     || (o == old($Heap)[listEl, Le] && f == Ln)
     || (o == el && f == Lp)
     || (o == el && f == Ln)
     || (o == el && f == Lb)
     || (o == el && f == Le)
     || (o == el && f == LPC)
     || (o == el && f == LNC)
     || (o == el && f == LL)
     || (old($Heap)[listEl, LL][o] && f == LL)
     || (
      old($Heap)[listEl, Le] != listEl
       && old($Heap)[old($Heap)[listEl, Ln], LPC][o]
       && f == LNC)
     || (old($Heap)[listEl, Le] == listEl && old($Heap)[listEl, LL][o] && f == LNC)
     || (old($Heap)[listEl, LNC][o] && f == LPC)
     || (old($Heap)[listEl, LL][o] && f == Le));



implementation InsertAfter(listEl: ref, el: ref)
{
    if ($Heap[listEl, Le] == listEl)
    {
        call AddToEnd(listEl, el);
    }
    else
    {
        call InsertAtTheMiddleAfter(listEl, el);
    }
}



procedure RemoveEnd(list: ref);
  requires list != null;
  requires !IsEmptyList($Heap, list);
  requires InvList($Heap);
  modifies $Heap;
  ensures InvList($Heap);
  ensures IsEmptyList($Heap, old($Heap)[list, Le]);
  ensures $Heap[old($Heap)[old($Heap)[list, Le], Lp], Ln] == null;
  ensures (forall o: ref :: 
  RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o]
     ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], old($Heap)[list, Le])));
  ensures (forall o: ref :: 
  RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o]
     ==> Equal($Heap[o, LNC], RemEl(old($Heap)[o, LNC], old($Heap)[list, Le])));
  ensures (forall o: ref :: 
  RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o]
     ==> $Heap[o, Le] == old($Heap)[old($Heap)[list, Le], Lp]);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == old($Heap)[old($Heap)[list, Le], Lp] && f == Ln)
     || (o == old($Heap)[list, Le] && f == Lp)
     || (o == old($Heap)[list, Le] && f == Ln)
     || (o == old($Heap)[list, Le] && f == Lb)
     || (o == old($Heap)[list, Le] && f == Le)
     || (o == old($Heap)[list, Le] && f == LPC)
     || (o == old($Heap)[list, Le] && f == LNC)
     || (o == old($Heap)[list, Le] && f == LL)
     || (RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o] && f == LL)
     || (RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o] && f == LNC)
     || (RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o] && f == Le));



implementation RemoveEnd(list: ref)
{
  var oldEnd: ref;
  var newEnd: ref;
  var newList: TRegion;

    oldEnd := $Heap[list, Le];
    newEnd := $Heap[oldEnd, Lp];
    newList := RemEl($Heap[list, LL], oldEnd);
    $Heap[newEnd, Ln] := null;
    $Heap[oldEnd, Lp] := null;
    $Heap[oldEnd, Ln] := null;
    $Heap[oldEnd, Lb] := oldEnd;
    $Heap[oldEnd, Le] := oldEnd;
    $Heap[oldEnd, LPC] := Empty;
    $Heap[oldEnd, LNC] := Empty;
    $Heap[oldEnd, LL] := Singleton(oldEnd);
    call removeFromAllIn(newList, LL, Singleton(oldEnd));
    call removeFromAllIn(newList, LNC, Singleton(oldEnd));
    call assignToAllIn(newList, Le, newEnd);
    assert InvIsGoodRegionsList($Heap);
    assert InvL($Heap);
    assert InvNCPC($Heap);
    assert InvNCn1($Heap);
    assert InvNCn2($Heap);
    assert InvNCo($Heap);
    assert Inve1($Heap);
    assert Inve2($Heap);
    assert InvPCp1($Heap);
    assert InvPCp2($Heap);
    assert InvPCo($Heap);
    assert Invb1($Heap);
    assert Invb2($Heap);
    assert InvLb($Heap);
    assert InvLe($Heap);
    assert InvLL1($Heap);
    assert InvLL2($Heap);
    assert InvNCNC($Heap);
    assert InvPCPC($Heap);
    assert Invp($Heap);
}



procedure RemoveBegin(list: ref);
  requires list != null;
  requires !IsEmptyList($Heap, list);
  requires InvList($Heap);
  modifies $Heap;
  ensures InvList($Heap);
  ensures IsEmptyList($Heap, old($Heap)[list, Lb]);
  ensures $Heap[old($Heap)[old($Heap)[list, Lb], Ln], Lp] == null;
  ensures (forall o: ref :: 
  RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o]
     ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], old($Heap)[list, Lb])));
  ensures (forall o: ref :: 
  RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o]
     ==> Equal($Heap[o, LPC], RemEl(old($Heap)[o, LPC], old($Heap)[list, Lb])));
  ensures (forall o: ref :: 
  RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o]
     ==> $Heap[o, Lb] == old($Heap)[old($Heap)[list, Lb], Ln]);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == old($Heap)[old($Heap)[list, Lb], Ln] && f == Lp)
     || (o == old($Heap)[list, Lb] && f == Lp)
     || (o == old($Heap)[list, Lb] && f == Ln)
     || (o == old($Heap)[list, Lb] && f == Lb)
     || (o == old($Heap)[list, Lb] && f == Le)
     || (o == old($Heap)[list, Lb] && f == LPC)
     || (o == old($Heap)[list, Lb] && f == LNC)
     || (o == old($Heap)[list, Lb] && f == LL)
     || (RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o] && f == LL)
     || (RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o] && f == LPC)
     || (RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o] && f == Lb));



implementation RemoveBegin(list: ref)
{
  var oldBegin: ref;
  var newBegin: ref;
  var newList: TRegion;

    oldBegin := $Heap[list, Lb];
    newBegin := $Heap[oldBegin, Ln];
    newList := RemEl($Heap[list, LL], oldBegin);
    $Heap[newBegin, Lp] := null;
    $Heap[oldBegin, Lp] := null;
    $Heap[oldBegin, Ln] := null;
    $Heap[oldBegin, Lb] := oldBegin;
    $Heap[oldBegin, Le] := oldBegin;
    $Heap[oldBegin, LPC] := Empty;
    $Heap[oldBegin, LNC] := Empty;
    $Heap[oldBegin, LL] := Singleton(oldBegin);
    call removeFromAllIn(newList, LL, Singleton(oldBegin));
    call removeFromAllIn(newList, LPC, Singleton(oldBegin));
    call assignToAllIn(newList, Lb, newBegin);
    assert InvIsGoodRegionsList($Heap);
    assert InvL($Heap);
    assert InvNCPC($Heap);
    assert InvNCn1($Heap);
    assert InvNCn2($Heap);
    assert InvNCo($Heap);
    assert Inve1($Heap);
    assert Inve2($Heap);
    assert InvPCp1($Heap);
    assert InvPCp2($Heap);
    assert InvPCo($Heap);
    assert Invb1($Heap);
    assert Invb2($Heap);
    assert InvLb($Heap);
    assert InvLe($Heap);
    assert InvLL1($Heap);
    assert InvLL2($Heap);
    assert InvNCNC($Heap);
    assert InvPCPC($Heap);
    assert Invp($Heap);
}



procedure RemoveFromTheMiddle(el: ref);
  requires el != null;
  requires !IsEmptyList($Heap, el);
  requires $Heap[el, Le] != el;
  requires $Heap[el, Lb] != el;
  requires InvList($Heap);
  modifies $Heap;
  ensures InvList($Heap);
  ensures IsEmptyList($Heap, el);
  ensures $Heap[old($Heap)[el, Lp], Ln] == old($Heap)[el, Ln];
  ensures $Heap[old($Heap)[el, Ln], Lp] == old($Heap)[el, Lp];
  ensures (forall o: ref :: 
  RemEl(old($Heap)[el, LL], el)[o]
     ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], el)));
  ensures (forall o: ref :: 
  old($Heap)[el, LPC][o] ==> Equal($Heap[o, LNC], RemEl(old($Heap)[o, LNC], el)));
  ensures (forall o: ref :: 
  old($Heap)[el, LNC][o] ==> Equal($Heap[o, LPC], RemEl(old($Heap)[o, LPC], el)));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == old($Heap)[el, Lp] && f == Ln)
     || (o == old($Heap)[el, Ln] && f == Lp)
     || (o == el && f == Lp)
     || (o == el && f == Ln)
     || (o == el && f == Lb)
     || (o == el && f == Le)
     || (o == el && f == LPC)
     || (o == el && f == LNC)
     || (o == el && f == LL)
     || (RemEl(old($Heap)[el, LL], el)[o] && f == LL)
     || (old($Heap)[el, LPC][o] && f == LNC)
     || (old($Heap)[el, LNC][o] && f == LPC));



implementation RemoveFromTheMiddle(el: ref)
{
  var before: ref;
  var after: ref;
  var newel: TRegion;
  var elLPC: TRegion;
  var elLNC: TRegion;

    before := $Heap[el, Lp];
    after := $Heap[el, Ln];
    elLPC := $Heap[el, LPC];
    elLNC := $Heap[el, LNC];
    newel := RemEl($Heap[el, LL], el);
    $Heap[before, Ln] := after;
    $Heap[after, Lp] := before;
    $Heap[el, Lp] := null;
    $Heap[el, Ln] := null;
    $Heap[el, Lb] := el;
    $Heap[el, Le] := el;
    $Heap[el, LPC] := Empty;
    $Heap[el, LNC] := Empty;
    $Heap[el, LL] := Singleton(el);
    call removeFromAllIn(newel, LL, Singleton(el));
    call removeFromAllIn(elLPC, LNC, Singleton(el));
    call removeFromAllIn(elLNC, LPC, Singleton(el));
    assert InvIsGoodRegionsList($Heap);
    assert InvL($Heap);
    assert InvNCPC($Heap);
    assert InvNCn1($Heap);
    assert InvNCn2($Heap);
    assert InvNCo($Heap);
    assert Inve1($Heap);
    assert Inve2($Heap);
    assert InvPCp1($Heap);
    assert InvPCo($Heap);
    assert Invb1($Heap);
    assert Invb2($Heap);
    assert InvLb($Heap);
    assert InvLe($Heap);
    assert InvLL1($Heap);
    assert InvLL2($Heap);
    assert InvNCNC($Heap);
    assert InvPCPC($Heap);
    assert Invp($Heap);
    assert InvPCp2($Heap);
}



procedure RemoveEl(el: ref);
  requires el != null;
  requires !IsEmptyList($Heap, el);
  requires InvList($Heap);
  modifies $Heap;
  ensures InvList($Heap);
  ensures IsEmptyList($Heap, el);
  ensures old($Heap)[el, Le] == el ==> $Heap[old($Heap)[el, Lp], Ln] == null;
  ensures old($Heap)[el, Lb] == el ==> $Heap[old($Heap)[el, Ln], Lp] == null;
  ensures old($Heap)[el, Lb] != el && old($Heap)[el, Le] != el
   ==> $Heap[old($Heap)[el, Lp], Ln] == old($Heap)[el, Ln];
  ensures old($Heap)[el, Lb] != el && old($Heap)[el, Le] != el
   ==> $Heap[old($Heap)[el, Ln], Lp] == old($Heap)[el, Lp];
  ensures (forall o: ref :: 
  RemEl(old($Heap)[el, LL], el)[o]
     ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], el)));
  ensures (forall o: ref :: 
  old($Heap)[el, LPC][o] ==> Equal($Heap[o, LNC], RemEl(old($Heap)[o, LNC], el)));
  ensures (forall o: ref :: 
  old($Heap)[el, LNC][o] ==> Equal($Heap[o, LPC], RemEl(old($Heap)[o, LPC], el)));
  ensures old($Heap)[el, Le] == el
   ==> (forall o: ref :: 
    RemEl(old($Heap)[el, LL], el)[o] ==> $Heap[o, Le] == old($Heap)[el, Lp]);
  ensures old($Heap)[el, Lb] == el
   ==> (forall o: ref :: 
    RemEl(old($Heap)[el, LL], el)[o] ==> $Heap[o, Lb] == old($Heap)[el, Ln]);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (old($Heap)[el, Le] == el && o == old($Heap)[el, Lp] && f == Ln)
     || (old($Heap)[el, Lb] == el && o == old($Heap)[el, Ln] && f == Lp)
     || (
      old($Heap)[el, Lb] != el
       && old($Heap)[el, Le] != el
       && o == old($Heap)[el, Lp]
       && f == Ln)
     || (
      old($Heap)[el, Lb] != el
       && old($Heap)[el, Le] != el
       && o == old($Heap)[el, Ln]
       && f == Lp)
     || (o == el && f == Lp)
     || (o == el && f == Ln)
     || (o == el && f == Lb)
     || (o == el && f == Le)
     || (o == el && f == LPC)
     || (o == el && f == LNC)
     || (o == el && f == LL)
     || (RemEl(old($Heap)[el, LL], el)[o] && f == LL)
     || (old($Heap)[el, LPC][o] && f == LNC)
     || (old($Heap)[el, LNC][o] && f == LPC)
     || (old($Heap)[el, Le] == el && RemEl(old($Heap)[el, LL], el)[o] && f == Le)
     || (old($Heap)[el, Lb] == el && RemEl(old($Heap)[el, LL], el)[o] && f == Lb));



implementation RemoveEl(el: ref)
{
    if ($Heap[el, Le] == el)
    {
        call RemoveEnd(el);
    }
    else if ($Heap[el, Lb] == el)
    {
        call RemoveBegin(el);
    }
    else
    {
        call RemoveFromTheMiddle(el);
    }
}



type ref;

type field _;

type THeap = <a>[ref,field a]a;

const unique null: ref;

const unique alloc: field bool;

function IsNotAllocatedList(h: THeap, o: ref) : bool;

axiom (forall h: THeap, o: ref :: 
  { IsNotAllocatedList(h, o) } 
  IsNotAllocatedList(h, o)
     <==> (forall o': ref :: 
      !h[o', LL][o]
         && !h[o', LNC][o]
         && !h[o', LPC][o]
         && h[o', Ln] != o
         && h[o', Le] != o
         && h[o', Lp] != o
         && h[o', Lb] != o));

var $Heap: THeap;

type TRegion = [ref]bool;

const Empty: TRegion;

axiom (forall o: ref :: !Empty[o]);

function Singleton(ref) : TRegion;

axiom (forall r: ref, o: ref :: Singleton(r)[o] <==> r == o);

function Union(TRegion, TRegion) : TRegion;

axiom (forall a: TRegion, b: TRegion, o: ref :: Union(a, b)[o] <==> a[o] || b[o]);

function Sub(TRegion, TRegion) : bool;

axiom (forall a: TRegion, b: TRegion :: 
  Sub(a, b) <==> (forall o: ref :: { a[o] } { b[o] } a[o] ==> b[o]));

function Equal(TRegion, TRegion) : bool;

axiom (forall a: TRegion, b: TRegion :: 
  Equal(a, b) <==> (forall o: ref :: { a[o] } { b[o] } a[o] <==> b[o]));

function Disjoint(TRegion, TRegion) : bool;

axiom (forall a: TRegion, b: TRegion :: 
  Disjoint(a, b) <==> (forall o: ref :: { a[o] } { b[o] } !a[o] || !b[o]));

function AddEl(r: TRegion, o: ref) : TRegion;

axiom (forall r: TRegion, o: ref, o': ref :: AddEl(r, o)[o'] <==> o == o' || r[o']);

function RemEl(r: TRegion, o: ref) : TRegion;

axiom (forall r: TRegion, o: ref, o': ref :: RemEl(r, o)[o'] <==> o != o' && r[o']);

function Minus(s: TRegion, r: TRegion) : TRegion;

axiom (forall s: TRegion, r: TRegion, o: ref :: Minus(s, r)[o] <==> s[o] && !r[o]);

axiom (forall s: TRegion, t: TRegion :: Equal(s, t) ==> s == t);

function IsGoodRegion(r: TRegion) : bool;

axiom (forall r: TRegion :: IsGoodRegion(r) <==> !r[null]);

procedure addToAllIn(r1: TRegion, f1: field TRegion, r2: TRegion);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == old(Union($Heap[o, f1], r2)));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



procedure removeFromAllIn(r1: TRegion, f1: field TRegion, r2: TRegion);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == old(Minus($Heap[o, f1], r2)));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



procedure assignToAllIn(r1: TRegion, f1: field ref, val: ref);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == val);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



const unique Ln: field ref;

const unique LNC: field TRegion;

const unique Le: field ref;

const unique Lp: field ref;

const unique LPC: field TRegion;

const unique Lb: field ref;

const unique LL: field TRegion;

function InvIsGoodRegionsListEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvIsGoodRegionsListEx(h, Ex1)
     <==> (forall o: ref :: 
      IsGoodRegion(h[o, LNC]) && IsGoodRegion(h[o, LPC]) && IsGoodRegion(h[o, LL])));

function InvLEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvLEx(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, LL] } 
      o != null && !Ex1[o] ==> Equal(h[o, LL], Union(h[o, LPC], AddEl(h[o, LNC], o)))));

function InvNCPCEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvNCPCEx(h, Ex1)
     <==> (forall o: ref :: o != null && !Ex1[o] ==> Disjoint(h[o, LNC], h[o, LPC])));

function InvNCn1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvNCn1Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Ln] } 
      o != null && !Ex1[o] ==> h[o, Ln] == null ==> Equal(h[o, LNC], Empty)));

function InvNCn2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvNCn2Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Ln], h[h[o, Ln], LNC], h[o, Ln] } 
      o != null && !Ex1[o]
         ==> 
        h[o, Ln] != null
         ==> Equal(h[o, LNC], AddEl(h[h[o, Ln], LNC], h[o, Ln]))));

function InvNCoEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvNCoEx(h, Ex1)
     <==> (forall o: ref :: { h[o, LNC] } o != null && !Ex1[o] ==> !h[o, LNC][o]));

function Inve1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Inve1Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Le] } 
      o != null && !Ex1[o] ==> o != h[o, Le] ==> h[o, LNC][h[o, Le]]));

function Inve2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Inve2Ex(h, Ex1)
     <==> (forall o: ref :: 
      o != null && !Ex1[o] ==> (o == h[o, Le] <==> h[o, Ln] == null)));

function Inve3Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Inve3Ex(h, Ex1)
     <==> (forall o: ref :: o != null && !Ex1[o] ==> h[o, LL][h[o, Le]]));

function InvPCp1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvPCp1Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Lp] } 
      o != null && !Ex1[o] ==> h[o, Lp] == null ==> Equal(h[o, LPC], Empty)));

function InvPCp2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvPCp2Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Lp], h[h[o, Lp], LPC], h[o, Lp] } 
      o != null && !Ex1[o]
         ==> 
        h[o, Lp] != null
         ==> Equal(h[o, LPC], AddEl(h[h[o, Lp], LPC], h[o, Lp]))));

function InvPCoEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvPCoEx(h, Ex1)
     <==> (forall o: ref :: { h[o, LPC] } o != null && !Ex1[o] ==> !h[o, LPC][o]));

function Invb1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Invb1Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Lb] } 
      o != null && !Ex1[o] ==> o != h[o, Lb] ==> h[o, LPC][h[o, Lb]]));

function Invb2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Invb2Ex(h, Ex1)
     <==> (forall o: ref :: 
      o != null && !Ex1[o] ==> (o == h[o, Lb] <==> h[o, Lp] == null)));

function Invb3Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Invb3Ex(h, Ex1)
     <==> (forall o: ref :: o != null && !Ex1[o] ==> h[o, LL][h[o, Lb]]));

function InvLbEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLbEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LL][o']
         ==> h[o, Lb] == h[o', Lb]));

function InvLeEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLeEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LL][o']
         ==> h[o, Le] == h[o', Le]));

function InvLL1Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLL1Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LL][o']
         ==> Equal(h[o, LL], h[o', LL])));

function InvLL2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLL2Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        !h[o, LL][o']
         ==> Disjoint(h[o, LL], h[o', LL])));

function InvNCNCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvNCNCEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LNC][o']
         ==> Sub(h[o', LNC], h[o, LNC])));

function InvPCPCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvPCPCEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LPC][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LPC][o']
         ==> Sub(h[o', LPC], h[o, LPC])));

function InvpEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvpEx(h, Ex1, Ex2)
     <==> (forall o: ref :: 
      (forall o': ref :: 
        o != null && !Ex1[o] && o' != null && !Ex2[o']
           ==> (h[o, Lp] == o' <==> h[o', Ln] == o))));

function InvIsGoodRegionsList(h: THeap) : bool;

axiom (forall h: THeap :: 
  InvIsGoodRegionsList(h) <==> InvIsGoodRegionsListEx(h, Empty));

function InvL(h: THeap) : bool;

axiom (forall h: THeap :: InvL(h) <==> InvLEx(h, Empty));

function InvNCPC(h: THeap) : bool;

axiom (forall h: THeap :: InvNCPC(h) <==> InvNCPCEx(h, Empty));

function InvNCn1(h: THeap) : bool;

axiom (forall h: THeap :: InvNCn1(h) <==> InvNCn1Ex(h, Empty));

function InvNCn2(h: THeap) : bool;

axiom (forall h: THeap :: InvNCn2(h) <==> InvNCn2Ex(h, Empty));

function InvNCo(h: THeap) : bool;

axiom (forall h: THeap :: InvNCo(h) <==> InvNCoEx(h, Empty));

function Inve1(h: THeap) : bool;

axiom (forall h: THeap :: Inve1(h) <==> Inve1Ex(h, Empty));

function Inve2(h: THeap) : bool;

axiom (forall h: THeap :: Inve2(h) <==> Inve2Ex(h, Empty));

function Inve3(h: THeap) : bool;

axiom (forall h: THeap :: Inve3(h) <==> Inve3Ex(h, Empty));

function InvPCp1(h: THeap) : bool;

axiom (forall h: THeap :: InvPCp1(h) <==> InvPCp1Ex(h, Empty));

function InvPCp2(h: THeap) : bool;

axiom (forall h: THeap :: InvPCp2(h) <==> InvPCp2Ex(h, Empty));

function InvPCo(h: THeap) : bool;

axiom (forall h: THeap :: InvPCo(h) <==> InvPCoEx(h, Empty));

function Invb1(h: THeap) : bool;

axiom (forall h: THeap :: Invb1(h) <==> Invb1Ex(h, Empty));

function Invb2(h: THeap) : bool;

axiom (forall h: THeap :: Invb2(h) <==> Invb2Ex(h, Empty));

function Invb3(h: THeap) : bool;

axiom (forall h: THeap :: Invb3(h) <==> Invb3Ex(h, Empty));

function InvLb(h: THeap) : bool;

axiom (forall h: THeap :: InvLb(h) <==> InvLbEx(h, Empty, Empty));

function InvLe(h: THeap) : bool;

axiom (forall h: THeap :: InvLe(h) <==> InvLeEx(h, Empty, Empty));

function InvLL1(h: THeap) : bool;

axiom (forall h: THeap :: InvLL1(h) <==> InvLL1Ex(h, Empty, Empty));

function InvLL2(h: THeap) : bool;

axiom (forall h: THeap :: InvLL2(h) <==> InvLL2Ex(h, Empty, Empty));

function InvNCNC(h: THeap) : bool;

axiom (forall h: THeap :: InvNCNC(h) <==> InvNCNCEx(h, Empty, Empty));

function InvPCPC(h: THeap) : bool;

axiom (forall h: THeap :: InvPCPC(h) <==> InvPCPCEx(h, Empty, Empty));

function Invp(h: THeap) : bool;

axiom (forall h: THeap :: Invp(h) <==> InvpEx(h, Empty, Empty));

function InvListEx(h: THeap, Ex: TRegion) : bool;

axiom (forall h: THeap, Ex: TRegion :: 
  { InvListEx(h, Ex) } 
  InvListEx(h, Ex)
     <==> InvIsGoodRegionsListEx(h, Ex)
       && InvLEx(h, Ex)
       && InvNCPCEx(h, Ex)
       && InvNCn1Ex(h, Ex)
       && InvNCn2Ex(h, Ex)
       && InvNCoEx(h, Ex)
       && Inve1Ex(h, Ex)
       && Inve2Ex(h, Ex)
       && Inve3Ex(h, Ex)
       && InvPCp1Ex(h, Ex)
       && InvPCp2Ex(h, Ex)
       && InvPCoEx(h, Ex)
       && Invb1Ex(h, Ex)
       && Invb2Ex(h, Ex)
       && Invb3Ex(h, Ex)
       && InvLbEx(h, Ex, Ex)
       && InvLeEx(h, Ex, Ex)
       && InvLL1Ex(h, Ex, Ex)
       && InvLL2Ex(h, Ex, Ex)
       && InvNCNCEx(h, Ex, Ex)
       && InvPCPCEx(h, Ex, Ex)
       && InvpEx(h, Ex, Ex));

function InvList(h: THeap) : bool;

axiom (forall h: THeap :: { InvList(h) } InvList(h) <==> InvListEx(h, Empty));

const unique Node_next: field ref;

const unique List_head: field ref;

function ListClassInv(h: THeap, list: ref) : bool;

axiom (forall h: THeap, list: ref :: 
  ListClassInv(h, list)
     <==> h[list, List_head] != null
       ==> (forall o: ref :: h[h[list, List_head], LL][o] ==> h[o, Node_next] == h[o, Ln])
         && h[list, List_head] == h[h[list, List_head], Lb]);

function InList(h: THeap, list: ref, el: ref) : bool;

axiom (forall h: THeap, list: ref, el: ref :: 
  InList(h, list, el)
     <==> h[list, List_head] != null && h[h[list, List_head], LL][el]);

function ListEmpty(h: THeap, list: ref) : bool;

axiom (forall h: THeap, list: ref :: 
  ListEmpty(h, list) <==> h[list, List_head] == null);

procedure GetItBegin(list: ref, it: ref);
  requires InvList($Heap);
  requires list != null;
  requires it != null;
  requires ListClassInv($Heap, list);
  modifies $Heap;
  ensures InvList($Heap);
  ensures ListClassInv($Heap, list);
  ensures ItClassInv($Heap, it);
  ensures $Heap[it, It_el] == old($Heap)[list, List_head];
  ensures $Heap[it, It_List] == list;
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == it && f == It_el)
     || (o == it && f == It_List));



implementation GetItBegin(list: ref, it: ref)
{
    $Heap[it, It_el] := $Heap[list, List_head];
    $Heap[it, It_List] := list;
}



const unique It_el: field ref;

const unique It_List: field ref;

function ItClassInv(h: THeap, it: ref) : bool;

axiom (forall h: THeap, it: ref :: 
  ItClassInv(h, it)
     <==> h[it, It_List] != null
       && (h[it, It_el] != null ==> InList(h, h[it, It_List], h[it, It_el]))
       && ListClassInv(h, h[it, It_List]));

procedure ItRemoveNext(it: ref);
  requires it != null;
  requires InvList($Heap);
  requires ItClassInv($Heap, it);
  requires $Heap[it, It_el] != null;
  requires $Heap[it, It_el] != $Heap[$Heap[it, It_el], Le];
  modifies $Heap;
  ensures ItClassInv($Heap, it);
  ensures $Heap[old($Heap)[it, It_el], Node_next]
   == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Node_next];
  ensures (forall itp: ref :: 
  itp != null
       && (old($Heap)[itp, It_el] != old($Heap)[old($Heap)[it, It_el], Node_next]
         || old($Heap)[itp, It_List] != old($Heap)[it, It_List])
       && ItClassInv(old($Heap), itp)
     ==> ItClassInv($Heap, it));
  ensures InvList($Heap);
  ensures IsEmptyList($Heap, old($Heap)[old($Heap)[it, It_el], Node_next]);
  ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
     == old($Heap)[old($Heap)[it, It_el], Node_next]
   ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp], Ln] == null;
  ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
     == old($Heap)[old($Heap)[it, It_el], Node_next]
   ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln], Lp] == null;
  ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
       != old($Heap)[old($Heap)[it, It_el], Node_next]
     && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
       != old($Heap)[old($Heap)[it, It_el], Node_next]
   ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp], Ln]
     == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln];
  ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
       != old($Heap)[old($Heap)[it, It_el], Node_next]
     && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
       != old($Heap)[old($Heap)[it, It_el], Node_next]
   ==> $Heap[old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln], Lp]
     == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp];
  ensures (forall o: ref :: 
  RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], 
      old($Heap)[old($Heap)[it, It_el], Node_next])[o]
     ==> Equal($Heap[o, LL], 
      RemEl(old($Heap)[o, LL], old($Heap)[old($Heap)[it, It_el], Node_next])));
  ensures (forall o: ref :: 
  old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LPC][o]
     ==> Equal($Heap[o, LNC], 
      RemEl(old($Heap)[o, LNC], old($Heap)[old($Heap)[it, It_el], Node_next])));
  ensures (forall o: ref :: 
  old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LNC][o]
     ==> Equal($Heap[o, LPC], 
      RemEl(old($Heap)[o, LPC], old($Heap)[old($Heap)[it, It_el], Node_next])));
  ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
     == old($Heap)[old($Heap)[it, It_el], Node_next]
   ==> (forall o: ref :: 
    RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], 
        old($Heap)[old($Heap)[it, It_el], Node_next])[o]
       ==> $Heap[o, Le] == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp]);
  ensures old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
     == old($Heap)[old($Heap)[it, It_el], Node_next]
   ==> (forall o: ref :: 
    RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], 
        old($Heap)[old($Heap)[it, It_el], Node_next])[o]
       ==> $Heap[o, Lb] == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln]);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == old($Heap)[it, It_el] && f == Node_next)
     || (
      old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
         == old($Heap)[old($Heap)[it, It_el], Node_next]
       && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp]
       && f == Ln)
     || (
      old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
         == old($Heap)[old($Heap)[it, It_el], Node_next]
       && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln]
       && f == Lp)
     || (
      old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
         != old($Heap)[old($Heap)[it, It_el], Node_next]
       && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
         != old($Heap)[old($Heap)[it, It_el], Node_next]
       && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lp]
       && f == Ln)
     || (
      old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
         != old($Heap)[old($Heap)[it, It_el], Node_next]
       && old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
         != old($Heap)[old($Heap)[it, It_el], Node_next]
       && o == old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Ln]
       && f == Lp)
     || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Lp)
     || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Ln)
     || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Lb)
     || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == Le)
     || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == LPC)
     || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == LNC)
     || (o == old($Heap)[old($Heap)[it, It_el], Node_next] && f == LL)
     || (RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], 
        old($Heap)[old($Heap)[it, It_el], Node_next])[o]
       && f == LL)
     || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LPC][o] && f == LNC)
     || (old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LNC][o] && f == LPC)
     || (
      old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Le]
         == old($Heap)[old($Heap)[it, It_el], Node_next]
       && RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], 
        old($Heap)[old($Heap)[it, It_el], Node_next])[o]
       && f == Le)
     || (
      old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], Lb]
         == old($Heap)[old($Heap)[it, It_el], Node_next]
       && RemEl(old($Heap)[old($Heap)[old($Heap)[it, It_el], Node_next], LL], 
        old($Heap)[old($Heap)[it, It_el], Node_next])[o]
       && f == Lb));



implementation ItRemoveNext(it: ref)
{
    call RemoveEl($Heap[$Heap[it, It_el], Node_next]);
    $Heap[$Heap[it, It_el], Node_next] := $Heap[$Heap[$Heap[it, It_el], Node_next], Node_next];
}



procedure ItInsertAfter(it: ref, el: ref);
  requires it != null;
  requires el != null;
  requires InvList($Heap);
  requires ItClassInv($Heap, it);
  requires IsEmptyList($Heap, el);
  requires !InList($Heap, $Heap[it, It_List], el);
  requires $Heap[it, It_el] != null;
  modifies $Heap;
  ensures ItClassInv($Heap, it);
  ensures $Heap[old($Heap)[it, It_el], Node_next] == el;
  ensures $Heap[el, Node_next] == old($Heap)[$Heap[it, It_el], Node_next];
  ensures (forall itp: ref :: 
  itp != null && ItClassInv(old($Heap), itp) ==> ItClassInv($Heap, it));
  ensures InvList($Heap);
  ensures $Heap[$Heap[it, It_el], Ln] == el;
  ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el]
   ==> $Heap[old($Heap)[$Heap[it, It_el], Ln], Lp] == el;
  ensures $Heap[el, Lp] == $Heap[it, It_el];
  ensures $Heap[el, Ln] == old($Heap)[$Heap[it, It_el], Ln];
  ensures $Heap[el, Lb] == $Heap[$Heap[it, It_el], Lb];
  ensures $Heap[el, Le] == $Heap[$Heap[it, It_el], Le];
  ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el]
   ==> $Heap[el, LPC] == old($Heap)[old($Heap)[$Heap[it, It_el], Ln], LPC];
  ensures old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el]
   ==> $Heap[el, LPC] == old($Heap)[$Heap[it, It_el], LL];
  ensures Equal($Heap[el, LNC], old($Heap)[$Heap[it, It_el], LNC]);
  ensures $Heap[el, LL] == AddEl(old($Heap)[$Heap[it, It_el], LL], el);
  ensures (forall o: ref :: 
  old($Heap)[$Heap[it, It_el], LL][o]
     ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
  ensures old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el]
   ==> (forall o: ref :: 
    old($Heap)[$Heap[it, It_el], LL][o]
       ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
  ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el]
   ==> (forall o: ref :: 
    old($Heap)[old($Heap)[$Heap[it, It_el], Ln], LPC][o]
       ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
  ensures old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el]
   ==> (forall o: ref :: 
    old($Heap)[$Heap[it, It_el], LNC][o]
       ==> Equal($Heap[o, LPC], AddEl(old($Heap)[o, LPC], el)));
  ensures old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el]
   ==> (forall o: ref :: old($Heap)[$Heap[it, It_el], LL][o] ==> $Heap[o, Le] == el);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == old($Heap)[it, It_el] && f == Node_next)
     || (o == el && f == Node_next)
     || (
      old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el]
       && o == $Heap[it, It_el]
       && f == Ln)
     || (
      old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el]
       && o == old($Heap)[$Heap[it, It_el], Ln]
       && f == Lp)
     || (o == old($Heap)[$Heap[it, It_el], Le] && f == Ln)
     || (o == el && f == Lp)
     || (o == el && f == Ln)
     || (o == el && f == Lb)
     || (o == el && f == Le)
     || (o == el && f == LPC)
     || (o == el && f == LNC)
     || (o == el && f == LL)
     || (old($Heap)[$Heap[it, It_el], LL][o] && f == LL)
     || (
      old($Heap)[$Heap[it, It_el], Le] != $Heap[it, It_el]
       && old($Heap)[old($Heap)[$Heap[it, It_el], Ln], LPC][o]
       && f == LNC)
     || (
      old($Heap)[$Heap[it, It_el], Le] == $Heap[it, It_el]
       && old($Heap)[$Heap[it, It_el], LL][o]
       && f == LNC)
     || (old($Heap)[$Heap[it, It_el], LNC][o] && f == LPC)
     || (old($Heap)[$Heap[it, It_el], LL][o] && f == Le));



implementation ItInsertAfter(it: ref, el: ref)
{
  var temp: ref;

    call InsertAfter($Heap[it, It_el], el);
    temp := $Heap[$Heap[it, It_el], Node_next];
    $Heap[$Heap[it, It_el], Node_next] := el;
    $Heap[el, Node_next] := temp;
}



const unique list1: ref;

const unique list2: ref;

const unique it11: ref;

const unique it12: ref;

const unique it2: ref;

const unique node: ref;

procedure main();
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
  modifies $Heap;



implementation main()
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


