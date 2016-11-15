procedure RemoveSubTree(tree: ref, subTree: ref)

modifies $Heap;

requires tree!=null;
requires subTree!=null;
requires $Heap[tree, NC][subTree];
requires InvTree($Heap);

ensures InvTree($Heap);
//Frame property
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == subTree && f == Np)
	  || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == Nt)
          || (o == tree && f == NC)
          || (AddEl(old($Heap)[tree, NA], tree)[o] && f == ND)	  
          || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == NA)
);

ensures $Heap[subTree, Np] == null;
ensures (forall o: ref :: AddEl($Heap[subTree, ND], subTree)[o] ==>
           $Heap[o,Nt] == subTree
);
ensures $Heap[tree, NC] == RemEl(old($Heap)[tree, NC], subTree);
ensures (forall o: ref :: AddEl($Heap[subTree, ND], subTree)[o] ==>
           $Heap[o,NA] == Minus(old($Heap)[o,NA], AddEl($Heap[tree, NA], tree))
);
ensures (forall o: ref :: AddEl($Heap[tree, NA], tree)[o] ==>
           $Heap[o,ND] == Minus(old($Heap)[o,ND], AddEl($Heap[subTree, ND], subTree))
);

{
  $Heap[subTree, Np] := null;
  $Heap[tree, NC] := RemEl($Heap[tree, NC], subTree);
  call removeFromAllIn(AddEl($Heap[subTree, ND], subTree), NA,  AddEl($Heap[tree, NA], tree));
  call removeFromAllIn(AddEl($Heap[tree, NA], tree), ND, AddEl($Heap[subTree, ND], subTree));
  call assignToAllIn(AddEl($Heap[subTree, ND], subTree), Nt, subTree);
}

procedure AddSubTree(tree: ref, subTree: ref)

modifies $Heap;

requires tree!=null;
requires subTree!=null;
requires tree != subTree;
requires !$Heap[subTree,ND][tree];
requires $Heap[subTree, Np] == null;
requires InvTree($Heap);

ensures InvTree($Heap);
//Frame property
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == subTree && f == Np)
	  || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == Nt)
          || (o == tree && f == NC)
          || (AddEl(old($Heap)[tree,NA],tree)[o] && f == ND)	  
          || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == NA)
);

ensures $Heap[subTree, Np] == tree;
ensures (forall o: ref :: AddEl($Heap[subTree, ND], subTree)[o] ==>
           $Heap[o,Nt] == old($Heap)[tree, Nt]
);
ensures $Heap[tree, NC] == AddEl(old($Heap)[tree, NC], subTree);
ensures (forall o: ref :: AddEl($Heap[tree,NA],tree)[o] ==>
           $Heap[o,ND] == Union(old($Heap)[o,ND],AddEl($Heap[subTree,ND],subTree))
 );
ensures (forall o: ref :: AddEl(old($Heap)[subTree, ND], subTree)[o] ==>
           $Heap[o,NA] == Union(old($Heap)[o,NA], AddEl($Heap[tree,NA], tree))
 );


{
  $Heap[subTree,Np] := tree;
  $Heap[tree,NC] := AddEl($Heap[tree,NC], subTree);
  call addToAllIn(AddEl($Heap[tree,NA],tree), ND, AddEl($Heap[subTree,ND],subTree));
  call addToAllIn(AddEl($Heap[subTree,ND],subTree), NA, AddEl($Heap[tree,NA], tree));
  call assignToAllIn(AddEl($Heap[subTree, ND], subTree), Nt, $Heap[tree, Nt]);
}


function IsEmptyTree(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o: ref :: IsEmptyTree(h, o) <==> (
     h[o, Np] == null
  && h[o, Nt] == o
  && h[o, NA] == Empty
  && h[o, NC] == Empty
  && h[o, ND] == Empty
));

procedure CreatEmptyTree(o: ref, NotAllocated: TRegion)

modifies $Heap;

requires o!=null;
requires NotAllocated[o];
requires InvTreeEx($Heap, NotAllocated);
requires IsNotAllocatedTree($Heap, o);

ensures InvTreeEx($Heap, RemEl(NotAllocated, o));
ensures IsEmptyTree($Heap, o);
//Frame
ensures (forall <a> o':ref, f:field a :: $Heap[o',f] == old($Heap[o',f]) 
          || (o' == o && f == Np)
          || (o' == o && f == Nt)
          || (o' == o && f == NA)
          || (o' == o && f == NC)
          || (o' == o && f == ND)
);

{
  $Heap[o, Np] := null;
  $Heap[o, Nt] := o;
  $Heap[o, NA] := Empty;
  $Heap[o, NC] := Empty;
  $Heap[o, ND] := Empty;
}