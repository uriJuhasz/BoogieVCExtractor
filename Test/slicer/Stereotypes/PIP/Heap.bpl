type ref;
type field a;
type THeap = <a> [ref, field a] a;

const unique null: ref;
const unique alloc: field bool;

var $Heap: THeap;

function IsNotAllocatedTree(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o: ref :: {IsNotAllocatedTree(h, o)}
  IsNotAllocatedTree(h, o) <==> (forall o':ref ::
      h[o', Np] != o
   && h[o', Nt] != o
   && !h[o',NA][o]
   && !h[o',NC][o]
   && !h[o',ND][o]

));

function IsNotAllocatedList(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o: ref :: {IsNotAllocatedList(h, o)}
  IsNotAllocatedList(h, o) <==> (forall o':ref ::
      !h[o', LL][o]
   &&  h[o', Ln] != o
   &&  h[o', Le] != o
   &&  h[o', Lp] != o
   &&  h[o', Lb] != o
));

function IsNotAllocated(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o: ref :: {IsNotAllocated(h, o)}
  IsNotAllocated(h, o) <==> (
  //Node
      (forall o':ref :: h[o', Nbb] != o)
//Stereotypes
   && IsNotAllocatedTree(h, o)
   && IsNotAllocatedList(h, o)
));
