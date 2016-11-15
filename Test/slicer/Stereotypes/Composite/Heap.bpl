type ref;
type field a;
type THeap = <a> [ref, field a] a;

const unique null: ref;

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

function IsNotAllocated(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o: ref :: {IsNotAllocated(h, o)}
  IsNotAllocated(h, o) <==> (
	//Tree
       (forall o':ref :: h[o', parent] != o)
	//Stereotypes
    && IsNotAllocatedTree(h, o)
));