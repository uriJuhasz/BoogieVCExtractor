procedure Composite..ctor(this: ref, NotAllocated: TRegion)
modifies $Heap;

requires this != null;
requires NotAllocated[this];
requires InvStructEx($Heap, NotAllocated);
requires IsNotAllocated($Heap, this);

ensures InvStructEx($Heap, Minus(NotAllocated, Singleton(this)));
ensures IsEmptyTree($Heap, this);
ensures InvComposite($Heap, this);

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || o==this);

ensures $Heap[this, childrenNumber] == 0;
{

  call CreatEmptyTree(this, NotAllocated);

  $Heap[this, childrenNumber] := 0;
  $Heap[this, parent] := null;
}


procedure Composite..update(this: ref, delta: int)
modifies $Heap;
requires this != null;

requires InvStruct($Heap);
requires InvCompositeSt($Heap, this, delta);
requires (forall o: ref :: $Heap[this, NA][o] ==> InvComposite($Heap, o));

ensures InvStruct($Heap);

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || (AddEl($Heap[this, NA], this)[o] && f == childrenNumber));

ensures (forall o:ref :: AddEl($Heap[this, NA], this)[o] ==> $Heap[o, childrenNumber] == old($Heap)[o, childrenNumber] - delta);

ensures (forall o: ref :: AddEl($Heap[this, NA], this)[o] ==> InvComposite($Heap, o));

{

  var next: ref;
  var h: THeap;
   
  next := $Heap[this, parent];
  $Heap[this, childrenNumber] := $Heap[this, childrenNumber] - delta;

  if ($Heap[this, parent] != null){

   //begin::proof
    assert Equal($Heap[next, NA], old($Heap)[next, NA]);
    assert (forall o: ref :: $Heap[next, NA][o] ==> Equal($Heap[o, NC], old($Heap)[o, NC]));  
    assert (forall o: ref :: $Heap[next, NA][o] ==> InvComposite($Heap, o));
    //end::proof


    //begin::proof
    assert  old($Heap)[next, NC][this];
    assert InvCompositeSt($Heap, next, delta);
    //end::proof


    //begin::proof
    h := $Heap;
    //goto::L1

    call Composite..update($Heap[this, parent], delta);
    
    //begin::L1
    assert Equal($Heap[this, NC], h[this, NC]);
    assert InvComposite($Heap, this);
    //end::proof
  }

}


procedure Composite..add(this: ref, child: ref)
modifies $Heap;

requires this!=null;
requires child!=null;
requires this != child;
requires !$Heap[child,ND][this];
requires $Heap[child, Np] == null;
requires InvStruct($Heap);
requires (forall o: ref :: AddEl($Heap[this, NA], this)[o] ==> InvComposite($Heap, o));

ensures InvStruct($Heap);

//Frame property
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == child && f == Np)
	  || (AddEl(old($Heap)[child, ND], child)[o] && f == Nt)
          || (o == this && f == NC)
          || (AddEl(old($Heap)[this, NA], this)[o] && f == ND)	  
          || (AddEl(old($Heap)[child, ND], child)[o] && f == NA)
          || (AddEl($Heap[this, NA], this)[o] && f == childrenNumber)
          || (o == child && f == parent)
);

ensures $Heap[child, Np] == this;
ensures (forall o: ref :: AddEl($Heap[child, ND], child)[o] ==> $Heap[o,Nt] == old($Heap)[this, Nt]);
ensures $Heap[this, NC] == AddEl(old($Heap)[this, NC], child);
ensures (forall o: ref :: AddEl($Heap[this,NA],this)[o] ==> $Heap[o,ND] == Union(old($Heap)[o,ND],AddEl($Heap[child,ND],child)));
ensures (forall o: ref :: AddEl(old($Heap)[child, ND], child)[o] ==> $Heap[o,NA] == Union(old($Heap)[o,NA], AddEl($Heap[this,NA], this)));

ensures (forall o:ref :: AddEl($Heap[this, NA], this)[o] ==> $Heap[o, childrenNumber] == old($Heap)[o, childrenNumber] + $Heap[child, childrenNumber] +1);

ensures (forall o: ref :: AddEl($Heap[this, NA], this)[o] ==> InvComposite($Heap, o));

{

  call AddSubTree(this, child);
  $Heap[child, parent] := this;

  //begin::proof
  assert Equal($Heap[this, NA], old($Heap)[this, NA]);
  assert (forall o: ref :: $Heap[this, NA][o] ==> Equal($Heap[o, NC], old($Heap)[o, NC]));  
  assert (forall o: ref :: $Heap[this, NA][o] ==> InvComposite($Heap, o));
  //end::proof

  //begin::proof
  assert Equal($Heap[this, NC], AddEl(old($Heap)[this, NC], child));
  assert InvCompositeSt($Heap, this, - $Heap[child, childrenNumber] - 1);
  //end::proof


  call Composite..update(this, - $Heap[child, childrenNumber] - 1);

}

procedure Composite..remove(this: ref, child: ref)
modifies $Heap;

requires this!=null;
requires child!=null;
requires $Heap[this,NC][child];

requires InvStruct($Heap);
requires (forall o: ref :: AddEl($Heap[this, NA], this)[o] ==> InvComposite($Heap, o));

ensures InvStruct($Heap);

//Begin::RemoveSubTree(this, child);
//Frame property
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) 
          || (o == child && f == Np)
	  || (AddEl(old($Heap)[child, ND], child)[o] && f == Nt)
          || (o == this && f == NC)
          || (AddEl(old($Heap)[this, NA], this)[o] && f == ND)	  
          || (AddEl(old($Heap)[child, ND], child)[o] && f == NA)
          || (AddEl($Heap[this, NA], this)[o] && f == childrenNumber)
          || (o == child && f == parent)
);

ensures  $Heap[child, Np] == null;ensures $Heap[child, Np] == null;
ensures (forall o: ref :: AddEl($Heap[child, ND], child)[o] ==> $Heap[o,Nt] == child);
ensures $Heap[this, NC] == RemEl(old($Heap)[this, NC], child);
ensures (forall o: ref :: AddEl($Heap[child, ND], child)[o] ==> $Heap[o,NA] == Minus(old($Heap)[o,NA], AddEl($Heap[this, NA], this)));
ensures (forall o: ref :: AddEl($Heap[this, NA], this)[o] ==> $Heap[o,ND] == Minus(old($Heap)[o,ND], AddEl($Heap[child, ND], child)));
//End::RemoveSubTree(this, child);

ensures (forall o:ref :: AddEl($Heap[this, NA], this)[o] ==> $Heap[o, childrenNumber] == old($Heap)[o, childrenNumber] - $Heap[child, childrenNumber] - 1);

ensures (forall o: ref :: AddEl($Heap[this, NA], this)[o] ==> InvComposite($Heap, o));

{

  call RemoveSubTree(this, child);
  $Heap[child, parent] := null;

  //begin::proof
  assert Equal($Heap[this, NA], old($Heap)[this, NA]);
  assert (forall o: ref :: $Heap[this, NA][o] ==> Equal($Heap[o, NC], old($Heap)[o, NC]));  
  assert (forall o: ref :: $Heap[this, NA][o] ==> InvComposite($Heap, o));
  //end::proof

  //begin::proof
  assert Equal($Heap[this, NC], RemEl(old($Heap)[this, NC], child));
  assert InvCompositeSt($Heap, this, $Heap[child, childrenNumber] + 1);
  //end::proof


  call Composite..update(this, $Heap[child, childrenNumber] + 1);

}