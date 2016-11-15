//InvPr Frame
axiom (forall h: THeap, hOld: THeap, this: ref ::
  (  InvPr(hOld, this)
  && Equal(BBSet(h, this), BBSet(hOld, this))
  && h[this, Npr] == hOld[this, Npr]
  && h[this, Ndpr] == hOld[this, Ndpr]
  && h[this, Ncpr] == hOld[this, Ncpr]
  && (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
  ) ==>  InvPr(h, this)
);

//InvPr Frame 2
axiom (forall h: THeap, hOld: THeap, this: ref ::
  (  InvPr(hOld, this)
  && h[this, NC] == hOld[this, NC]
  && h[this, Lp] == hOld[this, Lp]
  && h[this, Le] == hOld[this, Le]
  && h[this, NSt] == hOld[this, NSt]
  && h[this, Npr] == hOld[this, Npr]
  && h[this, Ndpr] == hOld[this, Ndpr]
  && h[this, Ncpr] == hOld[this, Ncpr]
  && (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
  ) ==>  InvPr(h, this)
);

  

// InvPr to InvPrSt
axiom (forall h: THeap, hOld: THeap, this: ref, child: ref, newNcpr: int ::
  ( InvPr(hOld, this)
  &&  BBSet(hOld, this)[child]
  && newNcpr >= 0
  && child != null
  && hOld[child, Ncpr] != newNcpr
  && h[child, Ncpr] == newNcpr
  && (forall <a> o:ref, f:field a :: h[o,f] == hOld[o,f] || (o == child && f==Ncpr))
  ) ==>  InvPrSt(h, this, hOld[child, Ncpr], newNcpr)
);

//InvPr remove child
axiom (forall h: THeap, hOld: THeap, this: ref, child: ref ::
  (  InvPr(hOld, this)
  &&  BBSet(hOld, this)[child]
  && child != null
  && Equal(BBSet(h, this), RemEl(BBSet(hOld, this), child))
  && h[this, Npr] == hOld[this, Npr]
  && h[this, Ndpr] == hOld[this, Ndpr]
  && h[this, Ncpr] == hOld[this, Ncpr]
  && (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
  ) ==> ( InvPrSt(h, this, hOld[child,Ncpr],0)
       && (hOld[child, Ncpr] == 0 ==> InvPr(h, this)))
);

//InvPr add child
axiom (forall h: THeap, hOld: THeap, this: ref, child: ref ::
  (  InvPr(hOld, this)
  && !BBSet(hOld, this)[child]
  && child != null
  && Equal(BBSet(h, this), AddEl(BBSet(hOld, this), child))
  && h[this, Npr] == hOld[this, Npr]
  && h[this, Ndpr] == hOld[this, Ndpr]
  && h[this, Ncpr] == hOld[this, Ncpr]
  && (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
  ) ==> (InvPrSt(h, this, 0, hOld[child,Ncpr])
       && (hOld[child, Ncpr] == 0 ==> InvPr(h, this)))
);

//InvPrSt Frame
axiom (forall h: THeap, hOld: THeap, from: int, to: int, this: ref ::
  (  InvPrSt(hOld, this, from, to)
  && Equal(BBSet(h, this), BBSet(hOld, this))
  && h[this, Npr] == hOld[this, Npr]
  && h[this, Ndpr] == hOld[this, Ndpr]
  && h[this, Ncpr] == hOld[this, Ncpr]
  && (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
  ) ==> InvPrSt(h, this, from, to)
);

//InvPrSt update from
axiom (forall h: THeap, hOld: THeap, from: int, to: int, this: ref ::
  (  InvPrSt(hOld, this, from, to)
  && Equal(BBSet(h, this), BBSet(hOld, this))
  && (from <= 0 ==> h[this, Npr] == hOld[this, Npr])
  && (from > 0 ==> h[this, Npr] == RemoveMSet(hOld[this, Npr],from))
  && h[this, Ndpr] == hOld[this, Ndpr]
  && h[this, Ncpr] == hOld[this, Ncpr]
  && (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
  ) ==> InvPrSt(h, this, 0, to)
);

//InvPrSt update to
axiom (forall h: THeap, hOld: THeap, from: int, to: int, this: ref ::
  (  InvPrSt(hOld, this, from, to)
  && Equal(BBSet(h, this), BBSet(hOld, this))
  && (to <= 0 ==> h[this, Npr] == hOld[this, Npr])
  && (to > 0 ==> h[this, Npr] == AddMSet(hOld[this, Npr], to))
  && h[this, Ndpr] == hOld[this, Ndpr]
  && h[this, Ncpr] == hOld[this, Ncpr]
  && (forall o: ref ::  BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
  ) ==> InvPrSt(h, this, from, 0)
);

//InvPrSt to InvPr
axiom (forall h: THeap, hOld: THeap, this: ref ::
  (  InvPrSt(hOld, this, 0, 0)
  && !BBSet(hOld, this)[this]
  && h[this, Ncpr] == Max(hOld[this, Ndpr],MaxMSet(hOld[this, Npr]))
  && (forall <a> o:ref, f:field a :: h[o,f] == hOld[o,f] || (o == this && f==Ncpr))
  ) ==> InvPr(h, this)
);