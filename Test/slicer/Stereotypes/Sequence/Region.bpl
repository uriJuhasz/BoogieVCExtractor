type TRegion = [ref]bool;

const Empty: TRegion;
axiom (forall o: ref :: !Empty[o]);

function Singleton(ref) returns (TRegion);
axiom (forall r: ref, o: ref ::  Singleton(r)[o] <==> r == o);

function Union(TRegion, TRegion) returns (TRegion);
axiom (forall a: TRegion, b: TRegion, o: ref :: 
  Union(a,b)[o] <==> a[o] || b[o]);

function Sub(TRegion, TRegion) returns (bool);
axiom(forall a: TRegion, b: TRegion :: 
  Sub(a,b) <==> (forall o: ref :: {a[o]} {b[o]} a[o] ==> b[o]));

function Equal(TRegion, TRegion) returns (bool);
axiom(forall a: TRegion, b: TRegion :: 
  Equal(a,b) <==> (forall o: ref :: {a[o]} {b[o]} a[o] <==> b[o]));

function Disjoint(TRegion, TRegion) returns (bool);
axiom (forall a: TRegion, b: TRegion ::
  Disjoint(a,b) <==> (forall o: ref :: {a[o]} {b[o]} !a[o] || !b[o]));

//ADDED
function AddEl(r:TRegion, o: ref) returns (TRegion);
axiom (forall r:TRegion, o:ref, o':ref :: 
  AddEl(r,o)[o'] <==> (o == o' || r[o']));

function RemEl(r:TRegion, o: ref) returns (TRegion);
axiom (forall r:TRegion, o:ref, o':ref :: 
  RemEl(r,o)[o'] <==> (o != o' && r[o']));

function Minus(s:TRegion, r:TRegion) returns (TRegion);
axiom (forall s:TRegion, r:TRegion, o:ref :: 
  Minus(s,r)[o] <==> s[o] && !r[o]);

axiom (forall s:TRegion, t:TRegion :: Equal(s,t) ==> s == t);


function IsGoodRegion(r: TRegion) returns (bool);

axiom (forall r: TRegion ::
      IsGoodRegion(r) <==> !r[null]);

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