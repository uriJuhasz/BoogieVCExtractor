procedure Node..ctor(this: ref, priority: int, NotAllocated: TRegion)
modifies $Heap;

requires priority >= 0;
requires this != null;
requires NotAllocated[this];
requires InvStructEx($Heap, NotAllocated);
requires IsNotAllocated($Heap, this);

ensures InvStructEx($Heap, Minus(NotAllocated, Singleton(this)));
ensures IsEmptyTree($Heap, this);
ensures $Heap[this, NSt] == StF;
ensures InvPr($Heap, this);

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || o==this);

{

  call CreatEmptyTree(this, NotAllocated);
  call CreatEmptyList(this, NotAllocated);

  $Heap[this, Ndpr] := priority;
  $Heap[this, Ncpr] := priority;
  $Heap[this, Npr] := EmptyMSet;
  $Heap[this, Nbb] := null;

  $Heap[this, NSt] := StF;


  //Begin: proof
  assert (forall i:int :: i>0 ==> Equal(FBP($Heap,BBSet($Heap, this),i), Empty));
  //End: proof
}

procedure Node..updatePriorities(this: ref, from: int, to: int)
modifies $Heap;
requires from >= 0;
requires to >= 0;
requires from != to;
requires this != null;

free requires this != $Heap[this, Nbb]; //type system

requires InvStruct($Heap);
requires InvPrSt($Heap, this, from, to);
requires (forall o: ref :: NACCSet($Heap, this)[o] ==> InvPr($Heap, o));

ensures InvStruct($Heap);
ensures (forall o: ref :: NACCoSet($Heap, this)[o] ==> InvPr($Heap, o));

//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || 
  (NACCoSet(old($Heap), this)[o] && (f==Npr || f==Ncpr)));
{
  var oldPriority : int;
  
  oldPriority := $Heap[this, Ncpr];

  if(from > 0) {
    $Heap[this, Npr] := RemoveMSet($Heap[this, Npr],from);
  }

  //Begin::proof
  assert InvPrSt($Heap, this, 0, to);
  //End::proof

  if(to > 0){
    $Heap[this, Npr] := AddMSet($Heap[this, Npr],to);
  }
  
  //Begin::proof
  assert InvPrSt($Heap, this, 0, 0);
  //End::proof

  $Heap[this, Ncpr] := Max($Heap[this, Ndpr],MaxMSet($Heap[this, Npr]));

  if(($Heap[this, Nbb] != null) && ($Heap[this, Ncpr] != oldPriority)) {
    call Node..updatePriorities($Heap[this, Nbb],oldPriority,$Heap[this, Ncpr]);
  } 

}

procedure Node..release(this:ref, r:ref)
modifies $Heap;
requires this != r; // types
requires this!=null;
requires r!=null;
//requires $Heap[r, Nbb] == this;
//requires $Heap[r,NSt]==StL;
requires $Heap[this, NC][r];
requires $Heap[this, NSt]==StF;
requires InvStruct($Heap);

requires InvPr($Heap, r);
requires (forall o: ref :: NACCoSet($Heap, this)[o] ==> InvPr($Heap, o));

ensures $Heap[r,Np]==null;
ensures InvStruct($Heap);
ensures $Heap[this,NSt]==StF;
ensures $Heap[r,NSt]==StF;


ensures (forall o: ref :: NACCoSet(old($Heap), this)[o] ==> InvPr($Heap, o));
ensures InvPr($Heap, r);


//Frame
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f])
          || (NACCoSet(old($Heap), this)[o] && (f==Npr || f==Ncpr))

          || (o == r && f == Np)
	  || (AddEl(old($Heap)[r, ND], r)[o] && f == Nt)
          || (o == this && f == NC)
          || (AddEl(old($Heap)[this, NA], this)[o] && f == ND)	  
          || (AddEl(old($Heap)[r, ND], r)[o] && f == NA)

	  || (o == r && f == Nbb)
	  || (o == r && f == NSt)
);

ensures (forall o: ref ::
  o != this ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));
{
  call RemoveSubTree(this, r);
  
  $Heap[r, Nbb] := null;  
  $Heap[r,NSt] := StF;
  
  
  if($Heap[r,Ncpr] != 0) { 
    call Node..updatePriorities(this,$Heap[r,Ncpr],0);
  }

}


procedure Node..acquire(this: ref, r: ref)
modifies $Heap;

requires this != r; // types
requires this!=null;
requires r!=null;
requires $Heap[this,NSt] == StF;
requires InvStruct($Heap);

requires InvPr($Heap, this);
requires (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));


ensures InvStruct($Heap);

ensures InvPr($Heap, this);
ensures (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));


//old($Heap)[r,NSt] == StF
//1) ___________________________________________

ensures old($Heap)[r,NSt] == StF ==> $Heap[this,NSt]==StF;
ensures old($Heap)[r,NSt] == StF ==> $Heap[r,NSt]==StL;

//Frame
ensures old($Heap)[r,NSt] == StF ==> (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f])
          || (NACCoSet(old($Heap), this)[o] && (f==Npr || f==Ncpr))

          || (o == r && f == Np)
	  || (AddEl(old($Heap)[r, ND], r)[o] && f == Nt)
          || (o == this && f == NC)
          || (AddEl(old($Heap)[this,NA],this)[o] && f == ND)	  
          || (AddEl(old($Heap)[r, ND], r)[o] && f == NA)

	  || (o == r && f == Nbb)
	  || (o == r && f == NSt)
);

ensures old($Heap)[r,NSt] == StF ==> (forall o: ref ::
  o != this ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));

ensures old($Heap)[r,NSt] == StF ==> $Heap[r, Np] == this;
ensures old($Heap)[r,NSt] == StF ==> (forall o: ref :: AddEl($Heap[r, ND], r)[o] ==>
           $Heap[o,Nt] == old($Heap)[this, Nt]
);
ensures old($Heap)[r,NSt] == StF ==> $Heap[this, NC] == AddEl(old($Heap)[this, NC], r);
ensures old($Heap)[r,NSt] == StF ==> (forall o: ref :: AddEl($Heap[this,NA],this)[o] ==>
           $Heap[o,ND] == Union(old($Heap)[o,ND],AddEl($Heap[r,ND],r))
 );
ensures old($Heap)[r,NSt] == StF ==> (forall o: ref :: AddEl(old($Heap)[r, ND], r)[o] ==>
           $Heap[o,NA] == Union(old($Heap)[o,NA], AddEl($Heap[this,NA], this))
 );


//(old($Heap)[r,NSt] != StF && !old($Heap)[this, ND][r])
//2) ___________________________________________
ensures (old($Heap)[r,NSt] != StF && !old($Heap)[this, ND][r]) ==> $Heap[this,NSt]==StL;
ensures (old($Heap)[r,NSt] != StF && !old($Heap)[this, ND][r]) ==> $Heap[r,NSt]==old($Heap)[r,NSt];



//Frame
ensures (old($Heap)[r,NSt] != StF && !old($Heap)[this, ND][r]) ==> (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f])
          || (NACCoSet(old($Heap), r)[o] && (f==Npr || f==Ncpr))

          || (o == this && f == Np)
	  || (AddEl(old($Heap)[this, ND], this)[o] && f == Nt)
          || (o == r && f == NC)
          || (AddEl(old($Heap)[r,NA],r)[o] && f == ND)	  
          || (AddEl(old($Heap)[this, ND], this)[o] && f == NA)

	  || (o == this && f == Nbb)
	  || (o == this && f == NSt)
);

ensures (old($Heap)[r,NSt] != StF && !old($Heap)[this, ND][r]) ==> (forall o: ref ::
  o != r ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));

//(old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r])
//3) ___________________________________________

ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> InvStruct($Heap);
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
          (forall o: ref :: {AddEl($Heap[r, NA], r)[o]} AddEl($Heap[r, NA], r)[o] ==> $Heap[o, NSt] == StD);


//Frame
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
        (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap)[o,f]
          || (NACCoSet(old($Heap), r)[o] && (f==Npr || f==Ncpr))

          || (AddEl(old($Heap)[r, NA], r)[o] && f == LL)
          || (AddEl(old($Heap)[r, NA], r)[o] && f == Lb)
          || (AddEl(old($Heap)[r, NA], r)[o] && f == Le)
          || (AddEl(old($Heap)[r, NA], r)[o] && f == Lp)
          || (AddEl(old($Heap)[r, NA], r)[o] && f == Ln)
          || (RemEl(AddEl(old($Heap)[r, NA], r), this)[o] && f == Np)
          || (AddEl(old($Heap)[$Heap[this, Lp], ND], $Heap[this, Lp])[o] && f == Nt)
          || (RemEl(AddEl(old($Heap)[r, NA], this), r)[o] && f == NC)
          || (RemEl(old($Heap)[r, NA], r)[o] && f == ND)
          || (AddEl(old($Heap)[$Heap[this, Lp], ND], $Heap[this, Lp])[o] && f == NA)
          || (o == this && f == Nbb)
          || ($Heap[this, LL][o] && f == NSt)
);

ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> (forall o: ref ::
    o != r ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));

ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
             $Heap[this, Ln] == null;
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> Equal($Heap[o, LL], AddEl(old($Heap)[r, NA], r)));
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> $Heap[o, Lb] == r);
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> $Heap[o, Le] == this);

ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o: ref :: RemEl(AddEl(old($Heap)[r, NA], r), this)[o] ==> old($Heap[o, Np]) == $Heap[o, Ln]);
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> $Heap[o, Np] == null);
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o: ref :: RemEl(AddEl(old($Heap)[r, NA], this), r)[o] ==> $Heap[o, NC] == RemEl(old($Heap)[o, NC], $Heap[o, Lp]));
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o:ref:: RemEl(AddEl(old($Heap)[r, NA], this), r)[o] ==> $Heap[o,ND] ==  Minus(old($Heap)[o,ND], AddEl(old($Heap)[$Heap[o, Lp], ND], $Heap[o, Lp])));
ensures (old($Heap)[r,NSt] != StF && old($Heap)[this, ND][r]) ==> 
            (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> Equal($Heap[o, NA], Empty));

{
	if($Heap[r,NSt] == StF) {
		call AddSubTree(this, r);
		$Heap[r,Nbb] := this;
		$Heap[r,NSt] := StL;
		if($Heap[r,Ncpr]!=0) {
			call Node..updatePriorities(this,0,$Heap[r,Ncpr]);
		}
	}else{
		$Heap[this,Nbb] := r;
		
		if(!$Heap[this, ND][r]){
			call AddSubTree(r, this);
			$Heap[this,NSt] := StL;
		} else {  
			call TreeToList(this, r);
			call assignToAllInSt($Heap[this, LL], NSt, StD);
		}
		
		//Begin: proof
		assert (forall o: ref :: o != r ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));
		assert InvStruct($Heap);
		//End: proof
		
		if($Heap[this,Ncpr]!=0) {
			call Node..updatePriorities(r,0,$Heap[this,Ncpr]);
			
			//Begin: proof
			assert InvPr($Heap, this);
			assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));
			//End: proof
			
		//Begin: proof
		}else{
			assert Equal(NACCSet($Heap, r), RemEl(Union($Heap[r, NA], $Heap[$Heap[r, Nt], LL]), r));
			assert Equal(NACCSet($Heap, r), NACCSet(old($Heap), r));
			assert (forall o: ref :: NACCoSet(old($Heap), r)[o] ==> InvPr(old($Heap), o));
			assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr(old($Heap), o));	
			assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> 
				(forall i:int ::  i>0 ==> old($Heap)[o, Npr][i] == Card(FBP(old($Heap),BBSet(old($Heap), o),i)))
			);  
			assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> 
				(forall i:int ::  i>0 ==> $Heap[o, Npr][i] == Card(FBP($Heap,BBSet($Heap, o),i)))
			);
			assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));	
		}
		assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));
		//End: proof
	}
}