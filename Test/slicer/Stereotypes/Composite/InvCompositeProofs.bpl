procedure ProveInvCompositeFrame(h: THeap, hOld: THeap, this: ref)
  requires InvComposite(hOld, this);
  requires Equal(h[this, NC], hOld[this, NC]);
  requires h[this, childrenNumber] == hOld[this, childrenNumber];
  requires (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber]);

  ensures InvComposite(h, this);
{
}

procedure ProveInvCompositeStFrame(h: THeap, hOld: THeap, this: ref, delta: int)
  requires InvCompositeSt(hOld, this, delta);
  requires Equal(h[this, NC], hOld[this, NC]);
  requires h[this, childrenNumber] == hOld[this, childrenNumber];
  requires (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber]);

  ensures InvCompositeSt(h, this, delta);
{
}

procedure ProveInvCompositeRemoveChild(h: THeap, hOld: THeap, this: ref, child: ref)
  requires InvComposite(hOld, this);
  //requires InvComposite(hOld, child);
  requires hOld[this, NC][child];
  requires child != null;

  requires Equal(h[this, NC],  RemEl(hOld[this, NC], child));
  requires h[this, childrenNumber] == hOld[this, childrenNumber];
  requires (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber]);

  ensures InvCompositeSt(h, this, hOld[child, childrenNumber] + 1);
{
  assert Sum(hOld, RemEl(hOld[this, NC], child)) == Sum(hOld, hOld[this, NC]) - hOld[child, childrenNumber] - 1;
}

procedure ProveInvCompositeAddChild(h: THeap, hOld: THeap, this: ref, child: ref)
  requires InvComposite(hOld, this);
  //requires InvComposite(hOld, child);
  requires !hOld[this, NC][child];
  requires child != null;

  requires Equal(h[this, NC],  AddEl(hOld[this, NC], child));
  requires h[this, childrenNumber] == hOld[this, childrenNumber];
  requires (forall o: ref ::  h[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber]);

  ensures InvCompositeSt(h, this, -hOld[child, childrenNumber] - 1);
{
  assert Sum(hOld, AddEl(hOld[this, NC], child)) == Sum(hOld, hOld[this, NC]) + hOld[child, childrenNumber] + 1;
}

procedure ProveInvCompositeUpdateChild(h: THeap, hOld: THeap, this: ref, child: ref, delta: int)
  requires InvStruct(hOld);
  requires InvComposite(hOld, this);
  requires hOld[this, NC][child];
  requires child != null;

  requires h[this, NC] == hOld[this, NC];
  requires h[this, childrenNumber] == hOld[this, childrenNumber];
  requires h[child, childrenNumber] == hOld[child, childrenNumber] - delta;
  requires (forall o: ref ::  RemEl(h[this, NC], child)[o] ==> h[o, childrenNumber] == hOld[o, childrenNumber]);

  ensures InvCompositeSt(h, this, delta);
{
   assert  Sum(h, hOld[this, NC]) == Sum(hOld, hOld[this, NC]) - hOld[child, childrenNumber] + h[child, childrenNumber];
}

procedure ProveInvCompositeSt2Composite(h: THeap, hOld: THeap, this: ref, delta: int)
  requires InvStruct(hOld);
  requires InvCompositeSt(hOld, this, delta);

  requires h[this, childrenNumber] == hOld[this, childrenNumber] - delta;
  requires (forall <a> o:ref, f:field a :: h[o,f] == hOld[o,f] || (o == this && f==childrenNumber));

  ensures InvComposite(h, this);
{
    assert !hOld[this, NC][this];

    assert hOld[this, childrenNumber] == Sum(hOld, hOld[this, NC]) + delta;
    assert Equal(hOld[this, NC], h[this, NC]);
    assert ((forall o: ref ::  hOld[this, NC][o] ==> h[o, childrenNumber] == hOld[o, childrenNumber]));
    assert Sum(hOld, hOld[this, NC]) == Sum(h, h[this, NC]);

}
