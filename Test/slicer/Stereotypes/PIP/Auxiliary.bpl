function Max(i :int, j:int) returns (int);
axiom (forall i: int, j:int :: {Max(i,j)}
  //(i<=j ==> Max(i,j) == j) && (j<=i ==> Max(i,j) == i));
  (Max(i,j) >= i && Max(i,j) >= j && (Max(i,j)==i || Max(i,j)==j)));

//FilterByPriority function
function FBP(h: THeap, r: TRegion, i:int) returns (TRegion);
axiom (forall h:THeap, r: TRegion, i:int, o:ref :: 
  FBP(h,r,i)[o] <==> (r[o] && h[o, Ncpr]==i) && o != null);
