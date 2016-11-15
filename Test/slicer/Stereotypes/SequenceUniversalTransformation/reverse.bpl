procedure SplitSeqOnSingletons(sOld: TSeqSlice, seq: TRef)  returns (s: TSeqSlice)

requires seq != null;

free requires (forall o: TRef :: o != null ==> StSeqInv(sOld, sOld[El][o]));
free requires StSliceAx(sOld);
free requires StSliceSeqAx(sOld);

free ensures (forall o: TRef :: o != null ==> StSeqInv(s, s[El][o]));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);

ensures (forall o: TRef :: sOld[El][seq][o] ==> IsSingletonSeq(s, o));

ensures (forall o : TRef :: !sOld[El][seq][o] ==> s[El][o] == sOld[El][o]);
ensures (forall o : TRef :: !sOld[El][seq][o] ==> s[Sb][o] == sOld[Sb][o]);
ensures (forall o : TRef :: !sOld[El][seq][o] ==> s[Se][o] == sOld[Se][o]);
ensures (forall o : TRef :: !sOld[El][seq][o] ==> s[Sp][o] == sOld[Sp][o]);
ensures (forall o : TRef :: !sOld[El][seq][o] ==> s[Sn][o] == sOld[Sn][o]);
ensures (forall o : TRef :: !sOld[El][seq][o] ==> s[SNC][o] == sOld[SNC][o]);
ensures (forall o : TRef :: !sOld[El][seq][o] ==> s[SPC][o] == sOld[SPC][o]);

{
  var Ib, Ie: TRef;
  var Inst: TReg;
  var nextInst: TRefRef;


  if (sOld[Sb][seq] != sOld[Se][seq]){

    Ib := sOld[Sb][seq];
    Ie := sOld[Sp][sOld[Se][seq]];
    Inst := RemEl(sOld[El][seq], sOld[Se][seq]);
    nextInst := sOld[Sn];


    //Begin:proof
    assert (forall o : TRef :: Inst[o] ==> Equal(Intersection(sOld[SNC][o], Inst), Intersection(sOld[SNC][o], RemEl(sOld[El][seq], sOld[Se][seq]))));
    assert (forall o : TRef :: Inst[o] ==> Equal(Intersection(sOld[SNC][o], sOld[El][seq]), sOld[SNC][o]));
    assert (forall o : TRef :: Inst[o] ==> Equal(Intersection(sOld[SNC][o], Inst), RemEl(Intersection(sOld[SNC][o], sOld[El][seq]), sOld[Se][seq])));
    assert (forall o : TRef :: Inst[o] ==> Equal(Intersection(sOld[SNC][o], Inst), RemEl(sOld[SNC][o], sOld[Se][seq])));
    assert (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(Intersection(sOld[SNC][nextInst[o]], Inst), RemEl(sOld[SNC][nextInst[o]], sOld[Se][seq])));
    assert (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(AddEl(Intersection(sOld[SNC][nextInst[o]], Inst), nextInst[o]), AddEl(RemEl(sOld[SNC][nextInst[o]], sOld[Se][seq]), nextInst[o])));
    assert (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(AddEl(Intersection(sOld[SNC][nextInst[o]], Inst), nextInst[o]), RemEl(AddEl(sOld[SNC][nextInst[o]], nextInst[o]), sOld[Se][seq])));
    assert (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(AddEl(Intersection(sOld[SNC][nextInst[o]], Inst), nextInst[o]), RemEl(sOld[SNC][o], sOld[Se][seq])));
    assert (forall o : TRef :: (Inst[o] && o != Ie) ==> Equal(Intersection(sOld[SNC][o], Inst), AddEl(Intersection(sOld[SNC][nextInst[o]], Inst), nextInst[o])));
    //End:proof

    //Begin:proof
    assert Equal(Inst, AddEl(Intersection(sOld[SNC][Ib], Inst), Ib));
    //End:proof

    call s := RemSetSequenceRelation(sOld, Ib, Ie, Inst, nextInst);

    //Begin:proof
    assert (forall o,o': TRef :: (Inst[o]  && o != Ie && Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])[o'])
                ==> Equal(s[El][o'], Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])));
    assert (forall o: TRef :: Inst[o] ==> Equal(s[El][nextInst[o]], Minus(sOld[SNC][o], sOld[SNC][nextInst[o]])));
    assert (forall o: TRef :: Inst[o] ==> Equal(s[El][nextInst[o]], Singleton(nextInst[o])));
    assert (forall o: TRef :: RemEl(sOld[El][seq], Ib)[o] ==> Equal(s[El][o], Singleton(o)));
    assert Equal(s[El][Ib], Singleton(Ib));
    assert (forall o: TRef :: sOld[El][seq][o] ==> Equal(s[El][o], Singleton(o)));
    //End:proof

  } else {
    s := sOld;
  }

}


  var ElUnion: TRefReg;
  var Ib, Ie: TRef;
  var Inst: TReg;
  var nextInst: TRefRef;

procedure MergeSeqOfSingletons(sOld: TSeqSlice, Ib: TRef, Ie: TRef, nextInst: TRefRef, ElUnion: TRefReg)  returns (s: TSeqSlice)

requires ElUnion[Ib][Ib];
requires ElUnion[Ib][Ie];
requires !ElUnion[Ib][null];
requires (forall o : TRef :: RemEl(ElUnion[Ib], Ie)[o] ==> nextInst[o] != null);
requires(forall o: TRef :: (ElUnion[Ib][o] && o != Ie) ==> ElUnion[Ib][nextInst[o]]);
requires nextInst[Ie] == null;

requires Equal(ElUnion[Ie], Singleton(Ie));
requires(forall o: TRef :: (ElUnion[Ib][o] && o != Ie) ==> Equal(ElUnion[o], AddEl(ElUnion[nextInst[o]], o)));
requires(forall o: TRef :: (ElUnion[Ib][o] && o != Ie) ==> !ElUnion[nextInst[o]][o]);

requires(forall o, o': TRef :: (ElUnion[Ib][o] && ElUnion[Ib][o'] && ElUnion[o][o']) ==> Subset(ElUnion[o'], ElUnion[o]));

requires (forall o: TRef :: ElUnion[Ib][o] ==> IsSingletonSeq(sOld, o));


free requires (forall o: TRef :: o != null ==> StSeqInv(sOld, sOld[El][o]));
free requires StSliceAx(sOld);
free requires StSliceSeqAx(sOld);

free ensures (forall o: TRef :: o != null ==> StSeqInv(s, s[El][o]));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);

ensures (forall o : TRef ::  ElUnion[Ib][o] ==> s[El][o] == ElUnion[Ib]);
ensures (forall o : TRef :: !ElUnion[Ib][o] ==> s[El][o] == sOld[El][o]);

ensures (forall o : TRef ::  ElUnion[Ib][o] ==> s[Sb][o] == sOld[Sb][Ib]);
ensures (forall o : TRef :: !ElUnion[Ib][o] ==> s[Sb][o] == sOld[Sb][o]);

ensures (forall o : TRef ::  ElUnion[Ib][o] ==> s[Se][o] == sOld[Se][Ie]);
ensures (forall o : TRef :: !ElUnion[Ib][o] ==> s[Se][o] == sOld[Se][o]);

ensures (forall o : TRef ::  ElUnion[Ib][o] ==> s[Sn][o] == nextInst[o]);
ensures (forall o : TRef :: !ElUnion[Ib][o] ==> s[Sn][o] == sOld[Sn][o]);

ensures (forall o, o': TRef :: (RemEl(ElUnion[Ib], Ib)[o] && o == nextInst[o']&& RemEl(ElUnion[Ib], Ie)[o']) ==> s[Sp][o] == o');
ensures (forall o : TRef :: !ElUnion[Ib][o] ==> s[Sp][o] == sOld[Sp][o]);

ensures (forall o : TRef ::  ElUnion[Ib][o] ==> s[SNC][o] == RemEl(ElUnion[o], o));
ensures (forall o : TRef :: !ElUnion[Ib][o] ==> s[SNC][o] == sOld[SNC][o]);

ensures (forall o : TRef ::  ElUnion[Ib][o] ==> s[SPC][o] == Minus(ElUnion[Ib], ElUnion[o]));
ensures (forall o : TRef :: !ElUnion[Ib][o] ==> s[SPC][o] == sOld[SPC][o]);


{

  if (Ib != Ie){

    call s :=  AddSetSequenceRelation(sOld, Ib, Ie, ElUnion[Ib], nextInst, ElUnion);

    //Begin:proof
    assert (forall o, o': TRef :: (RemEl(ElUnion[Ib], Ie)[o] && sOld[El][o][o']) ==> Equal(s[SNC][o'], Union(sOld[SNC][o'], ElUnion[nextInst[o]])));
    assert (forall o: TRef :: RemEl(ElUnion[Ib], Ie)[o] ==> Equal(s[SNC][o], Union(sOld[SNC][o], ElUnion[nextInst[o]])));
    assert (forall o: TRef :: RemEl(ElUnion[Ib], Ie)[o] ==> Equal(s[SNC][o], ElUnion[nextInst[o]]));
    assert (forall o: TRef :: RemEl(ElUnion[Ib], Ie)[o] ==> Equal(s[SNC][o], RemEl(ElUnion[o], o)));
    assert (forall o: TRef :: RemEl(ElUnion[Ib], Ie)[o] ==> s[SNC][o] == RemEl(ElUnion[o], o));
    assert Equal(s[SNC][Ie], RemEl(ElUnion[Ie], Ie));
    assert s[SNC][Ie] == RemEl(ElUnion[Ie], Ie);
    assert (forall o : TRef ::  ElUnion[Ib][o] ==> s[SNC][o] == RemEl(ElUnion[o], o));
    //End:proof

  } else {
    s := sOld;

    //Begin:proof
    assert Equal(s[SNC][Ie], RemEl(ElUnion[Ie], Ie));
    assert s[SNC][Ie] == RemEl(ElUnion[Ie], Ie);
    assert (forall o : TRef ::  ElUnion[Ib][o] ==> s[SNC][o] == RemEl(ElUnion[o], o));
    //End:proof

  }

  //Begin:proof
  assert (forall o : TRef ::  ElUnion[Ib][o] ==> Equal(s[SPC][o],  Minus(ElUnion[Ib], ElUnion[o])));
  assert (forall o : TRef ::  ElUnion[Ib][o] ==> s[SPC][o] == Minus(ElUnion[Ib], ElUnion[o]));
  //End:proof

}

procedure reverse(sOld: TSeqSlice, seq: TRef)  returns (s: TSeqSlice)

requires seq != null;

free requires (forall o: TRef :: o != null ==> StSeqInv(sOld, sOld[El][o]));
free requires StSliceAx(sOld);
free requires StSliceSeqAx(sOld);

free ensures (forall o: TRef :: o != null ==> StSeqInv(s, s[El][o]));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);

ensures forallEqualMap(s[El], sOld[El]);
ensures forallEqualMap(s[Se], forallReplaceMap(sOld[El][seq], sOld[Se], sOld[Sb]));
ensures forallEqualMap(s[Sb], forallReplaceMap(sOld[El][seq], sOld[Sb], sOld[Se]));
ensures forallEqualMap(s[Sn], forallReplaceMap(sOld[El][seq], sOld[Sn], sOld[Sp]));
ensures forallEqualMap(s[Sp], forallReplaceMap(sOld[El][seq], sOld[Sp], sOld[Sn]));
ensures forallEqualMap(s[SNC], forallReplaceMap(sOld[El][seq], sOld[SNC], sOld[SPC]));
ensures forallEqualMap(s[SPC], forallReplaceMap(sOld[El][seq], sOld[SPC], sOld[SNC]));
{

  var ElUnion: TRefReg;
  var Ib, Ie: TRef;
  var nextInst: TRefRef;

  if (sOld[Sb][seq] != sOld[Se][seq]){

    call s := SplitSeqOnSingletons(sOld, seq);


    Ib := sOld[Se][seq];
    Ie := sOld[Sb][seq];
    nextInst := sOld[Sp];

    assume (forall o: TRef :: ElUnion[o] == AddEl(sOld[SPC][o], o));    


    call s :=  MergeSeqOfSingletons(s, Ib, Ie, nextInst, ElUnion);

  //Begin:proof
    assert (forall o: TRef :: sOld[El][seq][o] ==> Equal(s[El][o], sOld[El][o]));
    assert (forall o: TRef :: sOld[El][seq][o] ==> s[El][o] == sOld[El][o]);
    assert (forall o: TRef ::!sOld[El][seq][o] ==> s[El][o] == sOld[El][o]);
    assert forallEqualMap(s[El], sOld[El]);
  //End:proof

  //Begin:proof
    assert (forall o : TRef ::  ElUnion[Ib][o] ==> s[SNC][o] == RemEl(ElUnion[o], o));
    assert (forall o : TRef ::  sOld[El][seq][o] ==> s[SNC][o] == RemEl(ElUnion[o], o));
    assert (forall o : TRef ::  sOld[El][seq][o] ==> Equal(RemEl(ElUnion[o], o), sOld[SPC][o]));
    assert (forall o: TRef :: sOld[El][seq][o] ==> Equal(s[SNC][o], sOld[SPC][o]));
    assert (forall o: TRef :: sOld[El][seq][o] ==> s[SNC][o] == sOld[SPC][o]);
    assert (forall o: TRef ::!sOld[El][seq][o] ==> s[SNC][o] == sOld[SNC][o]);
    assert forallEqualMap(s[SNC], forallReplaceMap(sOld[El][seq], sOld[SNC], sOld[SPC]));
  //End:proof

  //Begin:proof
    assert (forall o: TRef :: sOld[El][seq][o] ==> Equal(s[SPC][o], sOld[SNC][o]));
    assert (forall o: TRef :: sOld[El][seq][o] ==> s[SPC][o] == sOld[SNC][o]);
    assert (forall o: TRef ::!sOld[El][seq][o] ==> s[SPC][o] == sOld[SPC][o]);
    assert forallEqualMap(s[SPC], forallReplaceMap(sOld[El][seq], sOld[SPC], sOld[SNC]));
  //End:proof

  } else {
	assert Equal(sOld[El][seq], Singleton(sOld[Sb][seq]));
    
	s := sOld;
	
  }

}
