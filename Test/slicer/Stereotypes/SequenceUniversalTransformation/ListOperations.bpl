function IsEmptyList(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o: ref :: IsEmptyList(h, o) <==> (
     Equal(h[o, LL], Singleton(o))
  && h[o, Ln] == null
  && Equal(h[o, LNC], Empty)
  && h[o, Le] == o
  && h[o, Lp] == null
  && Equal(h[o, LPC], Empty)
  && h[o, Lb] == o
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
          || (o' == o && f == LNC)
          || (o' == o && f == Le)
          || (o' == o && f == Lp)
          || (o' == o && f == LPC)
          || (o' == o && f == Lb)
);

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

procedure AddToEnd(list: ref, el: ref)

modifies $Heap;

requires list != null;
requires el != null;
requires InvList($Heap);
requires IsEmptyList($Heap, el);
requires !$Heap[list, LL][el];

ensures InvList($Heap);

ensures  $Heap[old($Heap)[list, Le], Ln] == el;
ensures  $Heap[el, Lp] == old($Heap)[list, Le];
ensures  $Heap[el, Ln] == null;
ensures  $Heap[el, Lb] == $Heap[list, Lb];
ensures  $Heap[el, Le] == el;
ensures  $Heap[el, LPC] == old($Heap)[list, LL];
ensures  $Heap[el, LNC] == Empty;
ensures  $Heap[el, LL] == AddEl(old($Heap)[list, LL], el);

ensures (forall o: ref :: old($Heap)[list, LL][o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
ensures (forall o: ref :: old($Heap)[list, LL][o] ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
ensures (forall o: ref :: old($Heap)[list, LL][o] ==> $Heap[o, Le] == el);

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
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
          || (old($Heap)[list, LL][o] && f == Le)

);


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


  //Begin:proof
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
  //End:proof
}

procedure InsertAtTheMiddleAfter(listEl: ref, el: ref)

modifies $Heap;

requires listEl != null;
requires el != null;
requires InvList($Heap);
requires IsEmptyList($Heap, el);
requires !$Heap[listEl, LL][el];

requires $Heap[listEl, Le] != listEl;

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

ensures (forall o: ref :: old($Heap)[listEl, LL][o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
ensures (forall o: ref :: old($Heap)[old($Heap)[listEl, Ln], LPC][o] ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
ensures (forall o: ref :: old($Heap)[listEl, LNC][o] ==> Equal($Heap[o, LPC], AddEl(old($Heap)[o, LPC], el)));

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
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
          || ( old($Heap)[listEl, LNC][o] && f == LPC)
);


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

  //Begin:proof
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
          (o != null && o' != null ) ==> 
            ($Heap[o, LNC][o'] ==> Sub($Heap[o', LNC], $Heap[o, LNC])));
  
  assert InvNCNC($Heap);
  //End:proof
}

procedure InsertAfter(listEl: ref, el: ref)

modifies $Heap;

requires listEl != null;
requires el != null;
requires InvList($Heap);
requires IsEmptyList($Heap, el);
requires !$Heap[listEl, LL][el];

ensures InvList($Heap);

ensures $Heap[listEl, Ln] == el;
ensures old($Heap)[listEl, Le] != listEl ==> $Heap[old($Heap)[listEl, Ln], Lp] == el;
ensures $Heap[el, Lp] == listEl;
ensures $Heap[el, Ln] == old($Heap)[listEl, Ln];
ensures  $Heap[el, Lb] == $Heap[listEl, Lb];
ensures $Heap[el, Le] == $Heap[listEl, Le];
ensures old($Heap)[listEl, Le] != listEl ==> $Heap[el, LPC] == old($Heap)[old($Heap)[listEl, Ln], LPC];
ensures old($Heap)[listEl, Le] == listEl ==> $Heap[el, LPC] == old($Heap)[listEl, LL];
ensures Equal($Heap[el, LNC], old($Heap)[listEl, LNC]);
ensures  $Heap[el, LL] == AddEl(old($Heap)[listEl, LL], el);

ensures (forall o: ref :: old($Heap)[listEl, LL][o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[o, LL], el)));
ensures old($Heap)[listEl, Le] == listEl ==> (forall o: ref :: old($Heap)[listEl, LL][o] ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
ensures old($Heap)[listEl, Le] != listEl ==> (forall o: ref :: old($Heap)[old($Heap)[listEl, Ln], LPC][o] ==> Equal($Heap[o, LNC], AddEl(old($Heap)[o, LNC], el)));
ensures old($Heap)[listEl, Le] != listEl ==> (forall o: ref :: old($Heap)[listEl, LNC][o] ==> Equal($Heap[o, LPC], AddEl(old($Heap)[o, LPC], el)));
ensures old($Heap)[listEl, Le] == listEl ==> (forall o: ref :: old($Heap)[listEl, LL][o] ==> $Heap[o, Le] == el);

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
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
          || (old($Heap)[listEl, Le] != listEl && old($Heap)[old($Heap)[listEl, Ln], LPC][o] && f == LNC)
          || (old($Heap)[listEl, Le] == listEl && old($Heap)[listEl, LL][o] && f == LNC)
          || ( old($Heap)[listEl, LNC][o] && f == LPC)
          || (old($Heap)[listEl, LL][o] && f == Le)
);
{
  if ($Heap[listEl, Le] == listEl) {
    call AddToEnd(listEl, el);
  } else {
    call InsertAtTheMiddleAfter(listEl, el);
  }

}


procedure RemoveEnd(list: ref)

modifies $Heap;

requires list != null;
requires !IsEmptyList($Heap, list);
requires InvList($Heap);

ensures InvList($Heap);

//ensures list != old($Heap)[list, Le] ==> !$Heap[list, LL][old($Heap)[list, Le]];

ensures IsEmptyList($Heap, old($Heap)[list, Le]);

ensures $Heap[old($Heap)[old($Heap)[list, Le], Lp], Ln] == null;

ensures (forall o: ref :: RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o] ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], old($Heap)[list, Le])));
ensures (forall o: ref :: RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o] ==> Equal($Heap[o, LNC], RemEl(old($Heap)[o, LNC], old($Heap)[list, Le])));
ensures (forall o: ref :: RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o] ==> $Heap[o, Le] == old($Heap)[old($Heap)[list, Le], Lp]);



//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
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
          || (RemEl(old($Heap)[list, LL], old($Heap)[list, Le])[o] && f == Le)

);


{

  var oldEnd, newEnd: ref;
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

  //Begin:proof
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
//  assert Invpn($Heap);
//  assert Invnp($Heap);
  //End:proof
}


procedure RemoveBegin(list: ref)

modifies $Heap;

requires list != null;
requires !IsEmptyList($Heap, list);
requires InvList($Heap);

ensures InvList($Heap);

//ensures list != old($Heap)[list, Lb] ==> !$Heap[list, LL][old($Heap)[list, Lb]];

ensures IsEmptyList($Heap, old($Heap)[list, Lb]);

ensures $Heap[old($Heap)[old($Heap)[list, Lb], Ln], Lp] == null;

ensures (forall o: ref :: RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o] ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], old($Heap)[list, Lb])));
ensures (forall o: ref :: RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o] ==> Equal($Heap[o, LPC], RemEl(old($Heap)[o, LPC], old($Heap)[list, Lb])));
ensures (forall o: ref :: RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o] ==> $Heap[o, Lb] == old($Heap)[old($Heap)[list, Lb], Ln]);



//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
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
          || (RemEl(old($Heap)[list, LL], old($Heap)[list, Lb])[o] && f == Lb)

);


{

  var oldBegin, newBegin: ref;
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

  //Begin:proof
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
//  assert Invpn($Heap);
//  assert Invnp($Heap);
  //End:proof
}

procedure RemoveFromTheMiddle(el: ref)

modifies $Heap;

requires el != null;
requires !IsEmptyList($Heap, el);
requires $Heap[el, Le] != el;
requires $Heap[el, Lb] != el;
requires InvList($Heap);

ensures InvList($Heap);

ensures IsEmptyList($Heap, el);

ensures $Heap[old($Heap)[el, Lp], Ln] == old($Heap)[el, Ln];
ensures $Heap[old($Heap)[el, Ln], Lp] == old($Heap)[el, Lp];

ensures (forall o: ref :: RemEl(old($Heap)[el, LL], el)[o] ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], el)));
ensures (forall o: ref :: old($Heap)[el, LPC][o] ==> Equal($Heap[o, LNC], RemEl(old($Heap)[o, LNC], el)));
ensures (forall o: ref :: old($Heap)[el, LNC][o] ==> Equal($Heap[o, LPC], RemEl(old($Heap)[o, LPC], el)));

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
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
          || (old($Heap)[el, LNC][o] && f == LPC)

);


{

  var before, after: ref;
  var newel, elLPC, elLNC: TRegion;

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

  //Begin:proof
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
//  assert Invpn($Heap);
//  assert Invnp($Heap);
  //End:proof
}

procedure RemoveEl(el: ref)

modifies $Heap;

requires el != null;
requires !IsEmptyList($Heap, el);
requires InvList($Heap);

ensures InvList($Heap);

//ensures el != el ==> !$Heap[el, LL][el];
ensures IsEmptyList($Heap, el);

ensures old($Heap)[el, Le] == el ==> $Heap[old($Heap)[el, Lp], Ln] == null;
ensures old($Heap)[el, Lb] == el ==> $Heap[old($Heap)[el, Ln], Lp] == null;
ensures (old($Heap)[el, Lb] != el && old($Heap)[el, Le] != el) ==> $Heap[old($Heap)[el, Lp], Ln] == old($Heap)[el, Ln];
ensures (old($Heap)[el, Lb] != el && old($Heap)[el, Le] != el) ==> $Heap[old($Heap)[el, Ln], Lp] == old($Heap)[el, Lp];

ensures (forall o: ref :: RemEl(old($Heap)[el, LL], el)[o] ==> Equal($Heap[o, LL], RemEl(old($Heap)[o, LL], el)));
ensures (forall o: ref :: old($Heap)[el, LPC][o] ==> Equal($Heap[o, LNC], RemEl(old($Heap)[o, LNC], el)));
ensures (forall o: ref :: old($Heap)[el, LNC][o] ==> Equal($Heap[o, LPC], RemEl(old($Heap)[o, LPC], el)));

ensures old($Heap)[el, Le] == el ==> (forall o: ref :: RemEl(old($Heap)[el, LL], el)[o] ==> $Heap[o, Le] == old($Heap)[el, Lp]);
ensures old($Heap)[el, Lb] == el ==> (forall o: ref :: RemEl(old($Heap)[el, LL], el)[o] ==> $Heap[o, Lb] == old($Heap)[el, Ln]);

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (old($Heap)[el, Le] == el && o == old($Heap)[el, Lp] && f == Ln)
          || (old($Heap)[el, Lb] == el && o == old($Heap)[el, Ln] && f == Lp)
          || (old($Heap)[el, Lb] != el && old($Heap)[el, Le] != el && o == old($Heap)[el, Lp] && f == Ln)
          || (old($Heap)[el, Lb] != el && old($Heap)[el, Le] != el && o == old($Heap)[el, Ln] && f == Lp)
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
          || (old($Heap)[el, Lb] == el && RemEl(old($Heap)[el, LL], el)[o] && f == Lb)
);

{

  if ($Heap[el, Le] == el) {
    call RemoveEnd(el);
  } else if ($Heap[el, Lb] == el){
    call RemoveBegin(el);
  } else {
    call RemoveFromTheMiddle(el);
  }

}
