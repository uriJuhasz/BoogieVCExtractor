function Max(i :int, j:int) returns (int);
axiom (forall i: int, j:int :: {Max(i,j)}
  //(i<=j ==> Max(i,j) == j) && (j<=i ==> Max(i,j) == i));
  (Max(i,j) >= i && Max(i,j) >= j && (Max(i,j)==i || Max(i,j)==j)));

//sum function
function Sum(h: THeap, r: TRegion) returns (int);

axiom (forall h:THeap ::
  Sum(h, Empty) == 0);

axiom (forall h:THeap, r: TRegion, o:ref :: 
  !r[o]  ==> Sum(h, AddEl(r, o)) == Sum(h, r) + h[o, childrenNumber] + 1);

axiom (forall h:THeap, r: TRegion, o:ref :: 
  r[o]  ==> Sum(h, RemEl(r, o)) == Sum(h, r) - h[o, childrenNumber] - 1);

axiom (forall h:THeap, hOld: THeap, r: TRegion, o:ref :: 
  (r[o] && (forall o': ref ::  RemEl(r, o)[o'] ==> h[o', childrenNumber] == hOld[o', childrenNumber]))  ==>
  Sum(h, r) == Sum(hOld, r) - hOld[o, childrenNumber] + h[o, childrenNumber]);

axiom (forall h:THeap, hOld: THeap, r: TRegion, rOld: TRegion :: 
  (Equal(r, rOld) && ((forall o': ref ::  r[o'] ==> h[o', childrenNumber] == hOld[o', childrenNumber])))  ==>
  Sum(h, r) == Sum(hOld, rOld));
