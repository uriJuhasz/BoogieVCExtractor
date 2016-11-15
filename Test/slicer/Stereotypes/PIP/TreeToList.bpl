procedure TreeToList(tree: ref, subTree: ref)

modifies $Heap;

requires tree!=null;
requires subTree!=null;

requires $Heap[tree, Np] == null;
requires $Heap[tree, ND][subTree];
requires InvTree($Heap);

requires InvList($Heap);
requires (forall o: ref :: {AddEl($Heap[subTree, NA], subTree)[o], IsEmptyList($Heap, o)} AddEl($Heap[subTree, NA], subTree)[o] ==> IsEmptyList($Heap, o)); 

ensures InvList($Heap);
ensures $Heap[tree, Ln] == null;
ensures (forall o: ref :: AddEl(old($Heap)[subTree, NA], subTree)[o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[subTree, NA], subTree)));
ensures (forall o: ref :: AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Lb] == subTree);
ensures (forall o: ref :: AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Le] == tree);

ensures InvTree($Heap);
ensures (forall o: ref :: RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o] ==> old($Heap[o, Np]) == $Heap[o, Ln]);
ensures (forall o: ref :: AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Np] == null);
ensures (forall o: ref :: RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] ==> $Heap[o, NC] == RemEl(old($Heap)[o, NC], $Heap[o, Lp]));
ensures (forall o:ref:: RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] ==> $Heap[o,ND] ==  Minus(old($Heap)[o,ND], AddEl(old($Heap)[$Heap[o, Lp], ND], $Heap[o, Lp])));
ensures (forall o: ref :: AddEl(old($Heap)[subTree, NA], subTree)[o] ==> Equal($Heap[o, NA], Empty));

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == LL)
          || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Lb)
          || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Le)
          || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Lp)
          || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Ln)
          || (RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o] && f == Np)
          || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == Nt)
          || (RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] && f == NC)
          || (RemEl(old($Heap)[subTree, NA], subTree)[o] && f == ND)
          || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == NA)

);

{
  call TreeToListGetList(tree, subTree);
  call TreeToListRemTree(tree, subTree);
}

procedure TreeToListGetList(tree: ref, subTree: ref)

modifies $Heap;

requires tree!=null;
requires subTree!=null;

requires $Heap[tree, Np] == null;
requires $Heap[tree, ND][subTree];
requires InvTree($Heap);

requires InvList($Heap);
requires (forall o: ref :: {AddEl($Heap[subTree, NA], subTree)[o], IsEmptyList($Heap, o)} AddEl($Heap[subTree, NA], subTree)[o] ==> IsEmptyList($Heap, o)); 

ensures InvTree($Heap);

ensures InvList($Heap);
ensures (forall o: ref :: RemEl(AddEl($Heap[subTree, NA], subTree), tree)[o] ==> $Heap[o, Np] == $Heap[o, Ln]);
ensures $Heap[tree, Ln] == null;
ensures (forall o: ref :: AddEl($Heap[subTree, NA], subTree)[o] ==> Equal($Heap[o, LL], AddEl($Heap[subTree, NA], subTree)));
ensures (forall o: ref :: AddEl($Heap[subTree, NA], subTree)[o] ==> $Heap[o, Lb] == subTree);
ensures (forall o: ref :: AddEl($Heap[subTree, NA], subTree)[o] ==> $Heap[o, Le] == tree);

ensures (forall o: ref :: $Heap[subTree, NA][o]  ==> AddEl($Heap[subTree, NA], subTree)[$Heap[o, Lp]]);
ensures (forall o: ref :: $Heap[subTree, NA][o]  ==> $Heap[o, NC][$Heap[o, Lp]]);

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (AddEl($Heap[subTree, NA], subTree)[o] && f == LL)
          || (AddEl($Heap[subTree, NA], subTree)[o] && f == Lb)
          || (AddEl($Heap[subTree, NA], subTree)[o] && f == Le)
          || (AddEl($Heap[subTree, NA], subTree)[o] && f == Lp)
          || (AddEl($Heap[subTree, NA], subTree)[o] && f == Ln)
);
{

  var Done, All, Rest: TRegion;
  var current, newCurrent: ref;

  All := AddEl($Heap[subTree, NA], subTree);
  Done := Empty;
  Rest := $Heap[subTree, NA];
  current := subTree;

  while(current != null)

  invariant InvTree($Heap);  
  invariant InvList($Heap); 

  invariant current != null ==> All[current];
  invariant current != null ==> Sub($Heap[current, NA], All);
  invariant current != null ==> Equal(Done, Minus(All, AddEl(Rest, current)));
  invariant current != null ==> Equal(Rest, $Heap[current, NA]);
  invariant current == subTree ==> Equal(Done, Empty);
  invariant current == null ==> Equal(Done, All);

  invariant current != null ==> (forall o: ref ::  
    AddEl($Heap[current, NA], current)[o] ==> IsEmptyList($Heap, o)); 

  invariant current != subTree ==> Equal($Heap[subTree, LL], Done);
  invariant $Heap[subTree, Lb] == subTree;


  invariant $Heap[tree, Np] == null;
  invariant (forall o: ref :: RemEl(Done, $Heap[subTree, Le])[o] ==> $Heap[o, Np] == $Heap[o, Ln]);
  invariant (current != subTree && current != null) ==> $Heap[$Heap[subTree, Le], Np] == current;
  
  invariant (forall o: ref :: RemEl(Done, subTree)[o] ==> $Heap[o, NC][$Heap[o, Lp]]);

  invariant current != null ==> (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (AddEl(Done, current)[o] && f == LL)
          || (AddEl(Done, current)[o] && f == Lb)
          || (AddEl(Done, current)[o] && f == Le)
          || (AddEl(Done, current)[o] && f == Lp)
          || (AddEl(Done, current)[o] && f == Ln)
  );

  invariant current == null ==> (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (Done[o] && f == LL)
          || (Done[o] && f == Lb)
          || (Done[o] && f == Le)
          || (Done[o] && f == Lp)
          || (Done[o] && f == Ln)
  );

  {  
    newCurrent := $Heap[current, Np];

    if(current != subTree){
       call AddToEnd(subTree, current);
    }

    Done := AddEl(Done, current);
    Rest := RemEl(Rest, newCurrent);

    current := newCurrent;
  }
}


procedure TreeToListRemTree(tree: ref, subTree: ref)

modifies $Heap;

requires tree!=null;
requires subTree!=null;

requires $Heap[tree, Np] == null;
requires $Heap[tree, ND][subTree];
requires InvTree($Heap);


requires InvList($Heap);
requires (forall o: ref :: 
	RemEl(AddEl($Heap[subTree, NA], subTree), tree)[o] ==> $Heap[o, Np] == $Heap[o, Ln]);

requires (forall o: ref :: $Heap[subTree, NA][o]  ==> AddEl($Heap[subTree, NA], subTree)[$Heap[o, Lp]]);
requires (forall o: ref :: $Heap[subTree, NA][o]  ==> $Heap[o, NC][$Heap[o, Lp]]);

ensures InvList($Heap);

ensures InvTree($Heap);
ensures (forall o: ref :: RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o] ==> old($Heap[o, Np]) == $Heap[o, Ln]);
ensures (forall o: ref :: AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Np] == null);
ensures (forall o: ref :: RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] ==> $Heap[o, NC] == RemEl(old($Heap)[o, NC], $Heap[o, Lp]));
ensures (forall o:ref:: RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] ==> $Heap[o,ND] ==  Minus(old($Heap)[o,ND], AddEl(old($Heap)[$Heap[o, Lp], ND], $Heap[o, Lp])));
ensures (forall o: ref :: AddEl(old($Heap)[subTree, NA], subTree)[o] ==> Equal($Heap[o, NA], Empty));


//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
        || (RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o] && f == Np)
        || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == Nt)
        || (RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] && f == NC)
        || (RemEl(old($Heap)[subTree, NA], subTree)[o] && f == ND)
        || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == NA)
);
{

  var nextTree: ref;

  nextTree := $Heap[tree, Lp];

  call RemoveSubTree(tree, nextTree);

  if (nextTree != subTree){
	call  TreeToListRemTree(nextTree, subTree);
  }

}

