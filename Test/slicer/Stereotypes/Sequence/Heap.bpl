type ref;
type field a;
type THeap = <a> [ref, field a] a;

const unique null: ref;
const unique alloc: field bool;

function IsNotAllocatedList(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o: ref :: {IsNotAllocatedList(h, o)}
  IsNotAllocatedList(h, o) <==> (forall o':ref ::
      !h[o', LL][o]
   && !h[o', LNC][o]
   && !h[o', LPC][o]
   &&  h[o', Ln] != o
   &&  h[o', Le] != o
   &&  h[o', Lp] != o
   &&  h[o', Lb] != o
));

var $Heap: THeap;