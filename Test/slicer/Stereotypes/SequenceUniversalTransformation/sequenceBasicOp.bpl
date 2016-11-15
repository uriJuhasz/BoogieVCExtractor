function IsSingletonSeq(s: TSeqSlice, o: TRef) returns (bool){
     Equal(s[El][o], Singleton(o))
  && s[Sn][o] == null
  && Equal(s[SNC][o], Empty)
  && s[Sb][o] == o
  && s[Sp][o] == null
  && Equal(s[SPC][o], Empty)
  && s[Se][o] == o
}

procedure CreatSingletonSeq(sOld: TSeqSlice, o: TRef) returns (s: TSeqSlice) 

requires o!=null;

free ensures (forall o': TRef :: o' != null ==> StSeqInv(s, s[El][o']));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);

ensures IsSingletonSeq(s, o);
//Frame
ensures (forall <a> o':TRef, i:TStItem [TRef]a :: s[i][o'] == sOld[i][o']
          || (o' == o && i == El)
          || (o' == o && i == Sn)
          || (o' == o && i == SNC)
          || (o' == o && i == Se)
          || (o' == o && i == Sp)
          || (o' == o && i == SPC)
          || (o' == o && i == Sb)
);

{
  s := sOld;
  s[El][o] := Singleton(o);
  s[Sn][o] := null;
  s[SNC][o] :=  Empty;
  s[Sb][o] := o;
  s[Sp][o] := null;
  s[SPC][o] := Empty;
  s[Se][o] := o;

  assert StSeqInv(s, Singleton(o));

}


procedure AddSequenceRelation(sOld: TSeqSlice,o1: TRef, o2: TRef) returns (s: TSeqSlice)


requires o1 != null;
requires o2 != null;
requires Disjoint(sOld[El][o1], sOld[El][o2]);

free requires StSeqInv(sOld, sOld[El][o1]);
free requires StSeqInv(sOld, sOld[El][o2]);
free requires StSliceAx(sOld);
free requires StSliceSeqAx(sOld);

free ensures (forall o: TRef :: o != null ==> StSeqInv(s, s[El][o]));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);

ensures  s[Sn][sOld[Se][o1]] == sOld[Sb][o2];
ensures (forall o: TRef :: o != sOld[Se][o1] ==> s[Sn][o] == sOld[Sn][o]);

ensures  s[Sp][sOld[Sb][o2]] == sOld[Se][o1];
ensures (forall o: TRef :: o != sOld[Sb][o2] ==> s[Sp][o] == sOld[Sp][o]);

ensures (forall o: TRef ::  Union(sOld[El][o1], sOld[El][o2])[o] ==> s[El][o] == Union(sOld[El][o1], sOld[El][o2]));
ensures (forall o: TRef :: !Union(sOld[El][o1], sOld[El][o2])[o] ==> s[El][o] == sOld[El][o]);

ensures (forall o: TRef ::  Union(sOld[El][o1], sOld[El][o2])[o] ==> s[Se][o] == sOld[Se][o2]);
ensures (forall o: TRef :: !Union(sOld[El][o1], sOld[El][o2])[o] ==> s[Se][o] == sOld[Se][o]);

ensures (forall o: TRef ::  Union(sOld[El][o1], sOld[El][o2])[o] ==> s[Sb][o] == sOld[Sb][o1]);
ensures (forall o: TRef :: !Union(sOld[El][o1], sOld[El][o2])[o] ==> s[Sb][o] == sOld[Sb][o]);

ensures (forall o: TRef ::  sOld[El][o1][o] ==> s[SNC][o] == Union(sOld[SNC][o], sOld[El][o2]));
ensures (forall o: TRef :: !sOld[El][o1][o] ==> s[SNC][o] == sOld[SNC][o]);

ensures (forall o: TRef ::  sOld[El][o2][o] ==> s[SPC][o] == Union(sOld[SPC][o], sOld[El][o1]));
ensures (forall o: TRef :: !sOld[El][o2][o] ==> s[SPC][o] == sOld[SPC][o]);

{

  var b1, e1, b2, e2: TRef;
  var In1, In2, Out, Elements: TReg;

  b1 := sOld[Sb][o1];
  e1 := sOld[Se][o1];
  b2 := sOld[Sb][o2];
  e2 := sOld[Se][o2];
  In1 := sOld[El][o1];
  In2 := sOld[El][o2];
  Out := Union(In1, In2);
  Elements := Union(In1, In2);

  s := sOld;

  assert Equal(Out, Union(In1, In2));
  s[El] := forallAssign(Out, sOld[El], Out);

  assert e1 != null;
  assert Elements[e1];
  assert b2 != null;
  assert Elements[b2];
  s[Sn][e1] := b2;

  assert b2 != null;
  assert Elements[b2];
  assert e1 != null;
  assert Elements[e1];
  s[Sp][b2] := e1;

  assert !Out[null];
  assert Subset(Out, Elements);
  assert e2 != null;
  assert Elements[e2];
  s[Se] := forallAssign(Out, sOld[Se], e2);

  assert !Out[null];
  assert Subset(Out, Elements);
  assert b1 != null;
  assert Elements[b1];
  s[Sb] := forallAssign(Out, sOld[Sb], b1);

  assert !In1[null];
  assert Subset(In1, Elements);
  assert !In2[null];
  assert Subset(In2, Elements);
  s[SNC] := forallAddReg(In1, sOld[SNC], In2);

  assert !In2[null];
  assert Subset(In2, Elements);
  assert !In1[null];
  assert Subset(In1, Elements);
  s[SPC] := forallAddReg(In2, sOld[SPC], In1);


  //Begin:proof
  assert (forall o: TRef:: Out[o] ==> (o != s[Sb][o] ==> Equal(s[SPC][o], AddEl(s[SPC][s[Sp][o]], s[Sp][o]))));
  assert StSeqInvPC2(s, Out);
  assert StSeqInvNC2(s, Out);  
  assert StSeqInvPCPC(s, Out, Out);

  assert StSeqInv(s, Out);
  //End:proof

}


procedure RemSequenceRelation(sOld: TSeqSlice,o1: TRef) returns (s: TSeqSlice)


requires o1 != null;
requires sOld[Sn][o1] != null;

free requires StSeqInv(sOld, sOld[El][o1]);
free requires StSliceAx(sOld);
free requires StSliceSeqAx(sOld);

//ensures StSeqInv(s, AddEl(sOld[SPC][o1], o1));
//ensures StSeqInv(s, sOld[SNC][o1]);

free ensures (forall o: TRef :: o != null ==> StSeqInv(s, s[El][o]));
free ensures StSliceAx(sOld);
free ensures StSliceSeqAx(sOld);

ensures s[Sn][o1] == null;
ensures (forall o: TRef :: o != o1 ==> s[Sn][o] == sOld[Sn][o]);

ensures s[Sp][sOld[Sn][o1]] == null;
ensures (forall o: TRef :: o != sOld[Sn][o1] ==> s[Sp][o] == sOld[Sp][o]);

//ensures (forall o: TRef :: AddEl(sOld[SPC][o1], o1)[o] ==> s[El][o] == AddEl(sOld[SPC][o1], o1));
ensures (forall o: TRef :: Minus(sOld[El][o1], sOld[SNC][o1])[o] ==> s[El][o] == Minus(sOld[El][o1], sOld[SNC][o1]));
ensures (forall o: TRef :: sOld[SNC][o1][o] ==> s[El][o] == sOld[SNC][o1]);
ensures (forall o: TRef :: !sOld[El][o1][o] ==> s[El][o] == sOld[El][o]);

ensures (forall o: TRef ::  AddEl(sOld[SPC][o1], o1)[o] ==> s[Se][o] == o1);
ensures (forall o: TRef :: ! AddEl(sOld[SPC][o1], o1)[o] ==> s[Se][o] == sOld[Se][o]);

ensures (forall o: TRef :: sOld[SNC][o1][o] ==> s[Sb][o] == sOld[Sn][o1]);
ensures (forall o: TRef :: !sOld[SNC][o1][o] ==> s[Sb][o] == sOld[Sb][o]);

//ensures (forall o: TRef ::  AddEl(sOld[SPC][o1], o1)[o] ==> s[SNC][o] == Minus(sOld[SNC][o], sOld[SNC][o1]));
ensures (forall o: TRef ::  Minus(sOld[El][o1], sOld[SNC][o1])[o] ==> s[SNC][o] == Minus(sOld[SNC][o], sOld[SNC][o1]));
ensures (forall o: TRef :: !AddEl(sOld[SPC][o1], o1)[o] ==> s[SNC][o] == sOld[SNC][o]);

ensures (forall o: TRef ::  sOld[SNC][o1][o] ==> s[SPC][o] == Minus(sOld[SPC][o], AddEl(sOld[SPC][o1], o1)));
//ensures (forall o: TRef ::  sOld[SNC][o1][o] ==> s[SPC][o] == Minus(sOld[SPC][o], Minus(sOld[El][o1], sOld[SNC][o1])));
ensures (forall o: TRef :: !sOld[SNC][o1][o] ==> s[SPC][o] == sOld[SPC][o]);

{

  var o2: TRef;
  var In, Out1, Out2, Elements: TReg;


  o2 := sOld[Sn][o1];
  In := sOld[El][o1];
  Out2 := sOld[SNC][o1];
  Out1 := Minus(In, Out2);
  assert Equal(Out1, AddEl(sOld[SPC][o1], o1));
  Elements := In;


  s := sOld;

  assert Equal(In, Union(Out1, Out2));
  assert Disjoint(Out1, Out2);
  s[El] := forallAssign(Out2, forallAssign(Out1, sOld[El], Out1), Out2);

  assert o1 != null;
  assert Elements[o1];
  s[Sn][o1] := null;

  assert o2!= null;
  assert Elements[o2];
  s[Sp][o2] := null;

  assert !Out1[null];
  assert Subset(Out1, Elements);
  assert o1 != null;
  assert Elements[o1];
  s[Se] := forallAssign(Out1, sOld[Se], o1);

  assert !Out2[null];
  assert Subset(Out2, Elements);
  assert o2 != null;
  assert Elements[o2];
  s[Sb] := forallAssign(Out2, sOld[Sb], o2);

  assert !Out1[null];
  assert Subset(Out1, Elements);
  assert !Out2[null];
  assert Subset(Out2, Elements);
  s[SNC] := forallRemReg(Out1, sOld[SNC], Out2);

  assert !Out2[null];
  assert Subset(Out2, Elements);
  assert !Out1[null];
  assert Subset(Out1, Elements);
  s[SPC] := forallRemReg(Out2, sOld[SPC], Out1);

  assert StSeqInv(s, Out1);
  assert StSeqInv(s, Out2);
}
