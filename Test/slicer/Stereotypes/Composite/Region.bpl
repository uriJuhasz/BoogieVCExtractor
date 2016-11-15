type TRegion = [ref]bool;

const Empty: TRegion;
axiom (forall o: ref :: { Empty[o] } !Empty[o]);

function Singleton(ref) returns (TRegion);
axiom (forall r: ref, o: ref :: { Singleton(r)[o] } Singleton(r)[o] <==> r == o);

function Union(TRegion, TRegion) returns (TRegion);
axiom (forall a: TRegion, b: TRegion, o: ref :: { Union(a,b)[o] }
  Union(a,b)[o] <==> a[o] || b[o]);

function Sub(TRegion, TRegion) returns (bool);
axiom(forall a: TRegion, b: TRegion :: { Sub(a,b) }
  Sub(a,b) <==> (forall o: ref :: {a[o]} {b[o]} a[o] ==> b[o]));

function Equal(TRegion, TRegion) returns (bool);
axiom(forall a: TRegion, b: TRegion :: { Equal(a,b) }
  Equal(a,b) <==> (forall o: ref :: {a[o]} {b[o]} a[o] <==> b[o]));

function Disjoint(TRegion, TRegion) returns (bool);
axiom (forall a: TRegion, b: TRegion :: { Disjoint(a,b) }
  Disjoint(a,b) <==> (forall o: ref :: {a[o]} {b[o]} !a[o] || !b[o]));

//ADDED
function AddEl(r:TRegion, o: ref) returns (TRegion);
axiom (forall r:TRegion, o:ref, o':ref :: {AddEl(r,o)[o']}
  AddEl(r,o)[o'] <==> (o == o' || r[o']));

function RemEl(r:TRegion, o: ref) returns (TRegion);
axiom (forall r:TRegion, o:ref, o':ref :: {RemEl(r,o)[o']}
  RemEl(r,o)[o'] <==> (o != o' && r[o']));

function Minus(s:TRegion, r:TRegion) returns (TRegion);
axiom (forall s:TRegion, r:TRegion, o:ref :: {Minus(s,r)[o]}
  Minus(s,r)[o] <==> s[o] && !r[o]);

function Card(s:TRegion) returns (int);
axiom (Card(Empty) == 0);
axiom (forall s:TRegion, o:ref :: {Card(AddEl(s,o))} !s[o] ==> Card(AddEl(s,o)) == Card(s) + 1);
axiom (forall s:TRegion, o:ref :: {Card(RemEl(s,o))} s[o] ==> Card(RemEl(s,o)) == Card(s) - 1);

axiom (forall s:TRegion, t:TRegion :: {Equal(s,t), Card(s)} Equal(s,t) ==> (Card(s)==Card(t)));


function IsGoodRegion(r: TRegion) returns (bool);

axiom (forall r: TRegion ::
      { IsGoodRegion(r) } IsGoodRegion(r) <==> !r[null]);

function RegionImageRefInc(r1: TRegion, f: field ref, r2: TRegion, h: THeap) 
         returns (bool);
axiom (forall r1: TRegion, f: field ref, r2: TRegion, h: THeap:: 
      { RegionImageRefInc(r1, f, r2, h) }
           RegionImageRefInc(r1, f, r2, h)
           <==>
           (forall o: ref :: 
              r1[o] ==> (h[o,f] == null || r2[h[o,f]]))
      );

function RegionImageRegionInc(r1: TRegion, f: field TRegion, r2: TRegion, h: THeap) 
         returns (bool);
axiom (forall r1: TRegion, f: field TRegion, r2: TRegion, h: THeap:: 
      { RegionImageRegionInc(r1, f, r2, h) }
           RegionImageRegionInc(r1, f, r2, h)
           <==>           
           (forall o: ref :: {r1[o]} r1[o] ==> Sub(h[o,f], r2))
           );

procedure addToAllIn(r1: TRegion, f1 : field TRegion, r2: TRegion);
modifies $Heap;
ensures (forall o : ref :: r1[o] ==> $Heap[o,f1] == old(Union($Heap[o,f1],r2)));
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || ((r1[o]) && (f==f1)));

  
procedure removeFromAllIn(r1: TRegion, f1 : field TRegion, r2: TRegion);
modifies $Heap;
ensures (forall o : ref :: r1[o] ==> $Heap[o,f1] == old(Minus($Heap[o,f1],r2)));
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || ((r1[o]) && (f==f1)));

procedure assignToAllIn(r1: TRegion, f1 : field ref, val: ref);
modifies $Heap;
ensures (forall o : ref :: r1[o] ==> $Heap[o,f1] == val );
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || ((r1[o]) && (f==f1)));

procedure assignToAllInReg(r1: TRegion, f1 : field TRegion, val: TRegion);
modifies $Heap;
ensures (forall o : ref :: r1[o] ==> $Heap[o,f1] == val );
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || ((r1[o]) && (f==f1)));

procedure assignToAllInField(r1: TRegion, f1 : field ref, f2 : field ref);
modifies $Heap;
ensures (forall o : ref :: r1[o] ==> $Heap[o,f1] == $Heap[o,f2] );
ensures (forall <a> o:ref, f:field a :: $Heap[o,f] == old($Heap[o,f]) || ((r1[o]) && (f==f1)));