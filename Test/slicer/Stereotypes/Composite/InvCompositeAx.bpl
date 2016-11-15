//InvComposite Frame
axiom (forall h: THeap, hOld: THeap, this: ref ::
  (   InvComposite(hOld, this)
  &&  Equal(h[this, NC], hOld[this, NC])
  &&  h[this, childrenNumber] == hOld[this, childrenNumber]
  &&  (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber])
  ) ==> InvComposite(h, this)
);

//InvCompositeSt Frame
axiom (forall h: THeap, hOld: THeap, this: ref, delta: int ::
  (   InvCompositeSt(hOld, this, delta)
  &&  Equal(h[this, NC], hOld[this, NC])
  &&  h[this, childrenNumber] == hOld[this, childrenNumber]
  &&  (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber])
  ) ==> InvCompositeSt(h, this, delta)
);

//InvComposite remove a child
axiom (forall h: THeap, hOld: THeap, this: ref, child: ref ::
  (   InvComposite(hOld, this)
  &&  hOld[this, NC][child]
  &&  child != null

  &&  Equal(h[this, NC],  RemEl(hOld[this, NC], child))
  &&  h[this, childrenNumber] == hOld[this, childrenNumber]
  &&  (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber])
  ) ==> InvCompositeSt(h, this, hOld[child, childrenNumber] + 1)
);
  
//InvComposite add a child
axiom (forall h: THeap, hOld: THeap, this: ref, child: ref ::
  (   InvComposite(hOld, this)
  &&  !hOld[this, NC][child]
  &&  child != null

  &&  Equal(h[this, NC],  AddEl(hOld[this, NC], child))
  &&  h[this, childrenNumber] == hOld[this, childrenNumber]
  &&  (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber])
  ) ==> InvCompositeSt(h, this, -hOld[child, childrenNumber] - 1)
);

//InvComposite update a child
axiom (forall h: THeap, hOld: THeap, this: ref, child: ref, delta: int ::
  (   InvStruct(hOld)
  &&  InvComposite(hOld, this)
  &&  hOld[this, NC][child]
  &&  child != null

  &&  h[this, NC] == hOld[this, NC]
  &&  h[this, childrenNumber] == hOld[this, childrenNumber]
  &&  h[child, childrenNumber] == hOld[child, childrenNumber] - delta
  &&  (forall o: ref ::  RemEl(h[this, NC], child)[o] ==> h[o, childrenNumber] == hOld[o, childrenNumber])
  ) ==> InvCompositeSt(h, this, delta)
);

//Inv CompositeSt 2 Composite
axiom (forall h: THeap, hOld: THeap, this: ref, delta: int ::
  (   InvStruct(hOld)
  &&  InvCompositeSt(hOld, this, delta)

  &&  h[this, childrenNumber] == hOld[this, childrenNumber] - delta
  &&  (forall <a> o:ref, f:field a :: h[o,f] == hOld[o,f] || (o == this && f==childrenNumber))
  ) ==> InvComposite(h, this)
);