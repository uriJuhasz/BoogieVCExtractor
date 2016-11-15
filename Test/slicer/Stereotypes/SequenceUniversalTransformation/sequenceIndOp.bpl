procedure AddSetSequenceRelation(sOld: TSeqSlice,Ib: TRef, Ie: TRef, Inst: TReg, nextInst: TRefRef, ElUnion: TRefReg) returns (s: TSeqSlice)

requires Inst[Ib];
requires Inst[Ie];
requires !Inst[null];
requires (forall o : TRef :: RemEl(Inst, Ie)[o] ==> nextInst[o] != null);
requires(forall o: TRef :: (Inst[o] && o != Ie) ==> Inst[nextInst[o]]);

requires Equal(ElUnion[Ie], sOld[El][Ie]);
requires(forall o: TRef :: (Inst[o] && o != Ie) ==> Equal(ElUnion[o], Union(ElUnion[nextInst[o]], sOld[El][o])));
requires(forall o: TRef :: (Inst[o] && o != Ie) ==> Disjoint(sOld[El][o], ElUnion[nextInst[o]]));

requires Subset(Inst, ElUnion[Ib]);

requires(forall o, o': TRef :: (Inst[o] && Inst[o'] && ElUnion[o][o']) ==> Subset(ElUnion[o'], ElUnion[o]));

requires (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(Intersection(ElUnion[o], Inst), AddEl(Intersection(ElUnion[nextInst[o]], Inst), o)));
requires Equal(Intersection(sOld[El][Ie], Inst), Singleton(Ie));
requires(forall o, o': TRef:: (Inst[o] && Inst[o'] && o != Ie  && o' != Ie && ElUnion[o][o']) ==> ElUnion[nextInst[o]][nextInst[o']]);


free requires (forall o: TRef :: o != null ==> StSeqInv(sOld, sOld[El][o]));
free requires StSliceAx(sOld);
free requires StSliceSeqAx(sOld);

free ensures (forall o: TRef :: o != null ==> StSeqInv(s, s[El][o]));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);


ensures (forall o: TRef ::  ElUnion[Ib][o] ==> Equal(s[El][o], ElUnion[Ib]));
ensures (forall o: TRef :: !ElUnion[Ib][o] ==> s[El][o] == sOld[El][o]);

ensures (forall o: TRef :: ElUnion[Ib][o]==> s[Sb][o] == sOld[Sb][Ib]);
ensures (forall o: TRef :: !ElUnion[Ib][o]==> s[Sb][o] == sOld[Sb][o]);

ensures (forall o: TRef :: ElUnion[Ib][o]==> s[Se][o] == sOld[Se][Ie]);
ensures (forall o: TRef :: !ElUnion[Ib][o]==> s[Se][o] == sOld[Se][o]);

ensures (forall o: TRef :: RemEl(Inst, Ie)[o] ==> s[Sn][sOld[Se][o]] == sOld[Sb][nextInst[o]]);
ensures (forall o: TRef :: o != sOld[Se][o] ==> s[Sn][o] == sOld[Sn][o]);
ensures (forall o: TRef :: !ElUnion[Ib][o]==> s[Sn][o] == sOld[Sn][o]);
ensures (s[Sn][sOld[Se][Ie]] == sOld[Sn][sOld[Se][Ie]]);

ensures (forall o, o': TRef :: (RemEl(Inst, Ib)[o] && o == nextInst[o']&& RemEl(Inst, Ie)[o']) ==> s[Sp][sOld[Sb][o]] == sOld[Se][o']);
ensures (forall o: TRef :: o != sOld[Sb][o] ==> s[Sp][o] == sOld[Sp][o]);
ensures (forall o: TRef :: !ElUnion[Ib][o]==> s[Sp][o] == sOld[Sp][o]);
ensures (s[Sp][sOld[Sb][Ib]] == sOld[Sp][sOld[Sb][Ib]]);

ensures (forall o, o': TRef :: (RemEl(Inst, Ie)[o] && sOld[El][o][o']) ==> Equal(s[SNC][o'], Union(sOld[SNC][o'], ElUnion[nextInst[o]])));
ensures (forall o: TRef :: !ElUnion[Ib][o] ==> s[SNC][o] == sOld[SNC][o]);
ensures (forall o: TRef :: sOld[El][Ie][o] ==> s[SNC][o] == sOld[SNC][o]);

ensures (forall o, o': TRef :: (RemEl(Inst, Ib)[o] && sOld[El][o][o']) ==> Equal(s[SPC][o'], Union(sOld[SPC][o'], Minus(ElUnion[Ib], ElUnion[o]))));
ensures (forall o: TRef :: !ElUnion[Ib][o] ==> s[SPC][o] == sOld[SPC][o]);
ensures (forall o: TRef :: sOld[El][Ib][o] ==> s[SPC][o] == sOld[SPC][o]);



{

  var newIb: TRef;
  var newInst: TReg;
  var s': TSeqSlice;

  s := sOld;
  if (Ib != Ie){
    
    newIb := nextInst[Ib];
    newInst := RemEl(Inst, Ib);

    //Begin:proof
    assert Equal(Intersection(ElUnion[Ib], Inst), Inst);
    assert (forall o: TRef :: Inst[o] && o != Ib ==> !ElUnion[o][Ib]); 
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Equal(Intersection(ElUnion[o], newInst), Intersection(ElUnion[o], Inst)));
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Equal(Intersection(ElUnion[nextInst[o]], newInst), Intersection(ElUnion[nextInst[o]], Inst)));
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Equal(Intersection(ElUnion[o], newInst), AddEl(Intersection(ElUnion[nextInst[o]], newInst), o)));
    //End:proof

    call s := AddSetSequenceRelation(s,newIb, Ie, newInst, nextInst, ElUnion);

    s' := s;

    call s := AddSequenceRelation(s, Ib, newIb);
  
    //Begin:proof
    assert Equal(s'[El][newIb], ElUnion[newIb]);
    assert s'[El][Ib] == sOld[El][Ib];    
    assert (forall o: TRef ::  Union(s'[El][Ib], s'[El][newIb])[o] ==> s[El][o] == Union(s'[El][Ib], s'[El][newIb]));
    //End:proof


    //Begin:proof
    assert (forall o, o': TRef :: (RemEl(newInst, newIb)[o] && sOld[El][o][o']) ==> Equal(s'[SPC][o'], Union(sOld[SPC][o'], Minus(ElUnion[newIb], ElUnion[o]))));
    assert (forall o, o': TRef :: (RemEl(newInst, newIb)[o] && sOld[El][o][o']) ==> s'[SPC][o'] == Union(sOld[SPC][o'], Minus(ElUnion[newIb], ElUnion[o])));
    assert (forall o, o': TRef :: (RemEl(newInst, newIb)[o] && sOld[El][o][o']) ==> s[SPC][o'] == Union( Union(sOld[SPC][o'], Minus(ElUnion[newIb], ElUnion[o])), s'[El][Ib]));
    assert Equal(s'[El][Ib], sOld[El][Ib]);
    assert (forall o, o': TRef :: (RemEl(newInst, newIb)[o] && sOld[El][o][o']) ==> Equal(s[SPC][o'], Union(sOld[SPC][o'], Minus(ElUnion[Ib], ElUnion[o]))));
    assert (forall o: TRef :: sOld[El][newIb][o] ==> Equal(s[SPC][o], Union(sOld[SPC][o], Minus(ElUnion[Ib], ElUnion[newIb]))));
    assert (forall o, o': TRef :: (RemEl(Inst, Ib)[o] && sOld[El][o][o']) ==> Equal(s[SPC][o'], Union(sOld[SPC][o'], Minus(ElUnion[Ib], ElUnion[o]))));
    //End:proof
  }

}


procedure RemSetSequenceRelation(sOld: TSeqSlice,Ib: TRef, Ie: TRef, Inst: TReg, nextInst: TRefRef) returns (s: TSeqSlice)

requires sOld[Sn][Ie] != null;
requires Inst[Ib];
requires Inst[Ie];
requires !Inst[null];
requires (forall o : TRef :: RemEl(Inst, Ie)[o] ==> nextInst[o] != null);

requires Equal(Inst, AddEl(Intersection(sOld[SNC][Ib], Inst), Ib));
requires (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(Intersection(sOld[SNC][o], Inst), AddEl(Intersection(sOld[SNC][nextInst[o]], Inst), nextInst[o])));
requires Equal(Intersection(sOld[SNC][Ie], Inst), Empty);

requires Subset(Inst, sOld[El][Ib]);
requires (forall o: TRef :: RemEl(Inst, Ie)[o] ==> sOld[SNC][o][nextInst[o]]);

free requires (forall o: TRef :: o != null ==> StSeqInv(sOld, sOld[El][o]));
free requires StSliceAx(sOld);
free requires StSliceSeqAx(sOld);

free ensures (forall o: TRef :: o != null ==> StSeqInv(s, s[El][o]));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);

ensures (forall o: TRef ::  Minus(sOld[El][Ib], sOld[SNC][Ib])[o] ==> Equal(s[El][o], Minus(sOld[El][Ib], sOld[SNC][Ib])));
ensures (forall o,o': TRef :: (Inst[o]  && o != Ie && Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])[o'])
                ==> Equal(s[El][o'], Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])));
ensures (forall o: TRef :: sOld[SNC][Ie][o] ==> s[El][o] == sOld[SNC][Ie]);
ensures (forall o: TRef :: !sOld[El][Ib][o] ==> s[El][o] == sOld[El][o]);

ensures (forall o: TRef ::  Minus(sOld[El][Ib], sOld[SNC][Ib])[o] ==> Equal(s[SNC][o], Minus(sOld[SNC][o], sOld[SNC][Ib])));
ensures (forall o,o': TRef :: (Inst[o]  && o != Ie && Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])[o'])
                ==> Equal(s[SNC][o'], Minus(sOld[SNC][o'], sOld[SNC][nextInst[o]])));
ensures (forall o: TRef :: sOld[SNC][Ie][o] ==> s[SNC][o] == sOld[SNC][o]);
ensures (forall o: TRef :: !sOld[El][Ib][o] ==> s[SNC][o] == sOld[SNC][o]);

ensures (forall o: TRef ::  Minus(sOld[El][Ib], sOld[SNC][Ib])[o] ==> s[SPC][o] == sOld[SPC][o]);
ensures (forall o,o': TRef :: (Inst[o]  && o != Ie && Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])[o'])
                ==> Equal(s[SPC][o'], Minus(sOld[SPC][o'], AddEl(sOld[SPC][o], o))));
ensures (forall o: TRef :: sOld[SNC][Ie][o] ==> Equal(s[SPC][o], Minus(sOld[SPC][o], AddEl(sOld[SPC][Ie], Ie))));
ensures (forall o: TRef :: !sOld[El][Ib][o] ==> s[SPC][o] == sOld[SPC][o]);

ensures (forall o: TRef ::  Minus(sOld[El][Ib], sOld[SNC][Ib])[o] ==> s[Se][o] == Ib);
ensures (forall o,o': TRef :: (Inst[o]  && o != Ie && Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])[o'])
                ==> s[Se][o'] == nextInst[o]);
ensures (forall o: TRef :: !Minus(sOld[El][Ib], sOld[SNC][Ie])[o] ==> s[Se][o] == sOld[Se][o]);


ensures (forall o: TRef ::  Minus(sOld[El][Ib], sOld[SNC][Ib])[o] ==> s[Sb][o] == sOld[Sb][o]);
ensures (forall o,o': TRef :: (Inst[o]  && o != Ie && Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])[o'])
                ==> s[Sb][o'] == sOld[Sn][o]);
ensures (forall o: TRef :: sOld[SNC][Ie][o] ==> s[Sb][o] == sOld[Sn][Ie]);
ensures (forall o: TRef :: !sOld[El][Ib][o] ==> s[Sb][o] == sOld[Sb][o]);


ensures (forall o: TRef ::  Inst[o] ==> s[Sn][o] == null);
ensures (forall o: TRef :: !Inst[o] ==> s[Sn][o] == sOld[Sn][o]);

ensures (forall o: TRef :: (o != null &&  Inst[sOld[Sp][o]]) ==> s[Sp][o] == null);
ensures (forall o: TRef :: (o == null || !Inst[sOld[Sp][o]]) ==> s[Sp][o] == sOld[Sp][o]);

{

  var newIb: TRef;
  var newInst: TReg;
  var s': TSeqSlice;
  var ElIb, ElIb': TReg;

  s := sOld;
  if (Ib != Ie){

    newIb := nextInst[Ib];
    newInst := RemEl(Inst, Ib);


    //Begin:proof
    assert (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(Intersection(sOld[SNC][o], Inst), AddEl(Intersection(sOld[SNC][nextInst[o]], Inst), nextInst[o])));
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Equal(Intersection(sOld[SNC][o], Inst), AddEl(Intersection(sOld[SNC][nextInst[o]], Inst), nextInst[o])));
    assert !sOld[SNC][Ib][Ib];
    assert Subset(newInst, sOld[SNC][Ib]);
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> !sOld[SNC][o][Ib]);
	
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], Inst)[o'] ==> Intersection(sOld[SNC][o], newInst)[o']));
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], Inst)[o'] <== Intersection(sOld[SNC][o], newInst)[o']));
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], Inst)[o'] <==> Intersection(sOld[SNC][o], newInst)[o']));
	//assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Subset(Intersection(sOld[SNC][o], Inst), Intersection(sOld[SNC][o], newInst)));
	//assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Subset(Intersection(sOld[SNC][o], newInst), Intersection(sOld[SNC][o], Inst)));
	
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], Inst)[o'] ==> Intersection(sOld[SNC][o], newInst)[o']));
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], Inst)[o'] <== Intersection(sOld[SNC][o], newInst)[o']));
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], Inst)[o'] <==> Intersection(sOld[SNC][o], newInst)[o']));
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Equal(Intersection(sOld[SNC][o], Inst), Intersection(sOld[SNC][o], newInst)));
		
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> !sOld[SNC][nextInst[o]][Ib]);
	
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], newInst)[o'] ==> AddEl(Intersection(sOld[SNC][nextInst[o]], newInst), nextInst[o])[o']));
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], newInst)[o'] <== AddEl(Intersection(sOld[SNC][nextInst[o]], newInst), nextInst[o])[o']));
	assert (forall o : TRef :: (newInst[o] && o != Ie) ==> (forall o' : TRef :: Intersection(sOld[SNC][o], newInst)[o'] <==> AddEl(Intersection(sOld[SNC][nextInst[o]], newInst), nextInst[o])[o']));
    assert (forall o : TRef :: (newInst[o] && o != Ie) ==> Equal(Intersection(sOld[SNC][o], newInst), AddEl(Intersection(sOld[SNC][nextInst[o]], newInst), nextInst[o])));
    //End:proof

    call s := RemSetSequenceRelation(s,newIb, Ie, newInst, nextInst);

    s' := s;

    call s := RemSequenceRelation(s, Ib);

    //Begin:Proof
    ElIb :=  Minus(sOld[El][Ib], sOld[SNC][Ib]);
    ElIb':= Minus(s'[El][Ib], s'[SNC][Ib]);
    assert Equal(Minus(sOld[El][Ib], sOld[SNC][nextInst[Ib]]), s'[El][Ib]);
    assert Equal(Minus(sOld[SNC][Ib], sOld[SNC][nextInst[Ib]]), s'[SNC][Ib]);
    assert Subset(sOld[SNC][nextInst[Ib]], sOld[El][Ib]);
    assert Subset(sOld[SNC][nextInst[Ib]], sOld[SNC][Ib]);
    assert Equal(ElIb', ElIb);
    assert ElIb' == ElIb;
    assert (forall o: TRef ::  ElIb'[o] ==> Equal(s[El][o], ElIb'));
    assert (forall o: TRef ::  ElIb[o] ==> Equal(s[El][o], ElIb));
    //End:Proof


    
    //Begin:Proof
    assert (forall o: TRef :: (o != null &&  newInst[sOld[Sp][o]]) ==> s[Sp][o] == null);
    assert (forall o: TRef :: (o != null &&  Inst[sOld[Sp][o]]) ==> s[Sp][o] == null);
    //End:Proof


  } else{
    call s := RemSequenceRelation(s, Ib);
  }
}

