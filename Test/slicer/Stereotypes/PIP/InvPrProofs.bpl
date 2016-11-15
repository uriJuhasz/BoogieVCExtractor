procedure ProveInvPrFrame1(h: THeap, hOld: THeap, this: ref)
  requires InvPr(hOld, this);
  requires Equal(BBSet(h, this), BBSet(hOld, this));
  requires h[this, Npr] == hOld[this, Npr];
  requires h[this, Ndpr] == hOld[this, Ndpr];
  requires h[this, Ncpr] == hOld[this, Ncpr];
  requires (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr]);

  ensures InvPr(h, this);
{

  assert (forall i: int ::
   i > 0 ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );

}

procedure ProveInvPrFrame2(h: THeap, hOld: THeap, this: ref)
  requires InvPr(hOld, this);
  requires h[this, NC] == hOld[this, NC];
  requires h[this, Lp] == hOld[this, Lp];
  requires h[this, Le] == hOld[this, Le]; 
  requires h[this, NSt] == hOld[this, NSt];
  requires h[this, Npr] == hOld[this, Npr];
  requires h[this, Ndpr] == hOld[this, Ndpr];
  requires h[this, Ncpr] == hOld[this, Ncpr];
  requires (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr]);

  ensures InvPr(h, this);
{

  assert (forall i: int ::
   i > 0 ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );

}


procedure ProveInvPrInvPrSt(h: THeap, hOld: THeap, this: ref, child: ref, newNcpr: int)
  requires InvPr(hOld, this);
  requires  BBSet(hOld, this)[child];
  requires newNcpr >= 0;
  requires child != null;
  requires hOld[child, Ncpr] != newNcpr;
  requires h[child, Ncpr] == newNcpr;
  requires (forall <a> o:ref, f:field a :: h[o,f] == hOld[o,f] || (o == child && f==Ncpr));

  ensures InvPrSt(h, this, hOld[child, Ncpr], newNcpr);
{

  assert (forall i: int ::
   (i>0 && i!=hOld[child, Ncpr] && i!=newNcpr)  ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );
  assert Equal(FBP(h, BBSet(h, this), hOld[child, Ncpr]), RemEl(FBP(hOld, BBSet(hOld, this), hOld[child, Ncpr]), child));
  assert Equal(FBP(h, BBSet(h, this), newNcpr), AddEl(FBP(hOld, BBSet(hOld, this), newNcpr), child));
}

procedure ProveInvPrRemoveChild(h: THeap, hOld: THeap, this: ref, child: ref)
  requires InvPr(hOld, this);
  requires  BBSet(hOld, this)[child];
  requires child != null;

  requires Equal(BBSet(h, this), RemEl(BBSet(hOld, this), child));
  requires h[this, Npr] == hOld[this, Npr];
  requires h[this, Ndpr] == hOld[this, Ndpr];
  requires h[this, Ncpr] == hOld[this, Ncpr];
  requires (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr]);

  ensures InvPrSt(h, this, hOld[child,Ncpr],0);
  ensures hOld[child, Ncpr] == 0 ==> InvPr(h, this);
{

  assert (forall i: int ::
   (i>0 && i!= hOld[child,Ncpr])  ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );
  assert Equal(FBP(h, BBSet(h, this), hOld[child,Ncpr]), RemEl(FBP(hOld, BBSet(hOld, this), hOld[child, Ncpr]), child));
}

procedure ProveInvPrAddChild(h: THeap, hOld: THeap, this: ref, child: ref)
  requires InvPr(hOld, this);
  requires !BBSet(hOld, this)[child];
  requires child != null;

  requires Equal(BBSet(h, this), AddEl(BBSet(hOld, this), child));
  requires h[this, Npr] == hOld[this, Npr];
  requires h[this, Ndpr] == hOld[this, Ndpr];
  requires h[this, Ncpr] == hOld[this, Ncpr];
  requires (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr]);

  ensures InvPrSt(h, this, 0, hOld[child,Ncpr]);
  ensures hOld[child, Ncpr] == 0 ==> InvPr(h, this);
{

  assert (forall i: int ::
   (i>0 && i!= hOld[child,Ncpr])  ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );
  assert Equal(FBP(h, BBSet(h, this), hOld[child,Ncpr]), AddEl(FBP(hOld, BBSet(hOld, this), hOld[child, Ncpr]), child));
}

procedure ProveInvPrStFrame(h: THeap, hOld: THeap, from: int, to: int, this: ref)
  requires InvPrSt(hOld, this, from, to);
  requires Equal(BBSet(h, this), BBSet(hOld, this));
  requires h[this, Npr] == hOld[this, Npr];
  requires h[this, Ndpr] == hOld[this, Ndpr];
  requires h[this, Ncpr] == hOld[this, Ncpr];
  requires (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr]);

  ensures InvPrSt(h, this, from, to);
{

  assert (forall i: int ::
   i>0  ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );

}

procedure ProveInvPrStFromUpdate(h: THeap, hOld: THeap, from: int, to: int, this: ref)
  requires InvPrSt(hOld, this, from, to);
  requires Equal(BBSet(h, this), BBSet(hOld, this));
  requires from <= 0 ==> h[this, Npr] == hOld[this, Npr];
  requires from > 0 ==> h[this, Npr] == RemoveMSet(hOld[this, Npr],from);
  requires h[this, Ndpr] == hOld[this, Ndpr];
  requires h[this, Ncpr] == hOld[this, Ncpr];
  requires (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr]);

  ensures InvPrSt(h, this, 0, to);
{

  assert (forall i: int ::
   i>0  ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );

}

procedure ProveInvPrStToUpdate(h: THeap, hOld: THeap, from: int, to: int, this: ref)
  requires InvPrSt(hOld, this, from, to);
  requires Equal(BBSet(h, this), BBSet(hOld, this));
  requires to <= 0 ==> h[this, Npr] == hOld[this, Npr];
  requires to > 0 ==> h[this, Npr] == AddMSet(hOld[this, Npr], to);
  requires h[this, Ndpr] == hOld[this, Ndpr];
  requires h[this, Ncpr] == hOld[this, Ncpr];
  requires (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr]);

  ensures InvPrSt(h, this, from, 0);
{

  assert (forall i: int ::
   i>0  ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );

}

procedure ProveInvPrStInvPr(h: THeap, hOld: THeap, this: ref)
  requires InvPrSt(hOld, this, 0, 0);
  requires !BBSet(hOld, this)[this];
  requires h[this, Ncpr] == Max(hOld[this, Ndpr],MaxMSet(hOld[this, Npr]));
  requires (forall <a> o:ref, f:field a :: h[o,f] == hOld[o,f] || (o == this && f==Ncpr));

  ensures InvPr(h, this);
{

  assert (forall i: int ::
   i>0  ==> Equal(FBP(h, BBSet(h, this), i), FBP(hOld, BBSet(hOld, this), i))
  );

}