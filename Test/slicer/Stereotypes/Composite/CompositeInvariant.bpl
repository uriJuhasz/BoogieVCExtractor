//States definitions
function InvParentEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvParentEx(h, Ex1) <==>
        (forall o: ref ::
          (o != null && !Ex1[o]) ==> 
            (h[o, parent] == h[o, Np])
));

function InvParent(h: THeap) returns (bool);
axiom (forall h: THeap :: InvParent(h) <==> InvParentEx(h, Empty));

function InvStructEx(h: THeap, Ex: TRegion) returns (bool);
axiom (forall h: THeap, Ex: TRegion :: {InvStructEx(h, Ex)}
  InvStructEx(h, Ex) <==> (
     InvTreeEx(h, Ex)

  && InvParentEx(h, Ex)
));

function InvStruct(h: THeap) returns (bool);
axiom (forall h: THeap :: {InvStruct(h)}
  InvStruct(h) <==> InvStructEx(h, Empty)
);

function InvComposite(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o:ref :: {InvComposite(h,o)}
  InvComposite(h,o) <==> 
       h[o, childrenNumber] == Sum(h, h[o, NC])
//    && h[o, childrenNumber] >= 0
  );


function InvCompositeSt(h: THeap, o: ref, delta: int) returns (bool);
axiom (forall h: THeap, o:ref, delta: int :: {InvCompositeSt(h, o, delta)}
  InvCompositeSt(h, o, delta) <==> 
       h[o, childrenNumber] == Sum(h, h[o, NC]) + delta
//    && h[o, childrenNumber] >= delta
  );