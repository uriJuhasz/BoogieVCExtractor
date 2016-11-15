//States definitions
function InvStFEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvStFEx(h, Ex1) <==>
        (forall o: ref :: 
          (o != null && !Ex1[o]) ==> 
            (h[o, NSt] == StF <==> (h[o, Nbb] == null && h[o, Np] == h[o, Nbb]))
));

function InvStLEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvStLEx(h, Ex1) <==>
        (forall o: ref ::
          (o != null && !Ex1[o]) ==> 
            (h[o, NSt] == StL <==> (h[o, Nbb] != null && h[o, Np] == h[o, Nbb]))
));

function InvStDEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvStDEx(h, Ex1) <==>
        (forall o: ref :: 
          (o != null && !Ex1[o]) ==> 
            (h[o, NSt] == StD <==> (h[o, Nbb] != null && CLn(h,o) == h[o, Nbb]))
));


//Stereotype creation invariant
function InvStNDLEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvStNDLEx(h, Ex1) <==>
        (forall o: ref :: 
          (o != null && !Ex1[o]) ==> 
            (h[o, NSt] != StD ==> IsEmptyList(h, o))
));

//Invariants that describes states of relevant objects
function InvStDCCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvStDCCEx(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: 
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            ((h[o,NSt] == StD && h[o, LL][o']) ==> h[o',NSt] == StD)
));


function InvStADEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvStADEx(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: 
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, ND][o'] ==> h[o',NSt] == StL)
));

function InvStF(h: THeap) returns (bool);
axiom (forall h: THeap :: InvStF(h) <==> InvStFEx(h, Empty));

function InvStL(h: THeap) returns (bool);
axiom (forall h: THeap :: InvStL(h) <==> InvStLEx(h, Empty));

function InvStD(h: THeap) returns (bool);
axiom (forall h: THeap :: InvStD(h) <==> InvStDEx(h, Empty));

function InvStNDL(h: THeap) returns (bool);
axiom (forall h: THeap :: InvStNDL(h) <==> InvStNDLEx(h, Empty));

function InvStDCC(h: THeap) returns (bool);
axiom (forall h: THeap :: InvStDCC(h) <==> InvStDCCEx(h, Empty, Empty));

function InvStAD(h: THeap) returns (bool);
axiom (forall h: THeap :: InvStAD(h) <==> InvStADEx(h, Empty, Empty));

function InvStructEx(h: THeap, Ex: TRegion) returns (bool);
axiom (forall h: THeap, Ex: TRegion ::
  InvStructEx(h, Ex) <==> (
     InvTreeEx(h, Ex)
  && InvListEx(h, Ex)

  && InvStFEx(h, Ex)
  && InvStLEx(h, Ex)
  && InvStDEx(h, Ex)
  && InvStNDLEx(h, Ex)
  && InvStDCCEx(h, Ex, Ex)
  && InvStADEx(h, Ex, Ex)
));

function InvStruct(h: THeap) returns (bool);
axiom (forall h: THeap ::
  InvStruct(h) <==> InvStructEx(h, Empty)
);


function InvPr(h: THeap, o: ref) returns (bool);
axiom (forall h: THeap, o:ref ::
  InvPr(h,o) <==> 
        h[o, Ncpr] == Max(h[o, Ndpr],MaxMSet(h[o, Npr]))
    && h[o, Ncpr] >= 0
    && h[o, Ndpr] >= 0
    && (forall i:int :: i>0 ==> h[o, Npr][i] == Card(FBP(h,BBSet(h, o),i)))
  );


function InvPrSt(h: THeap, o: ref, from: int, to: int) returns (bool);
axiom (forall h: THeap, o:ref, from: int, to: int ::
  InvPrSt(h, o, from, to) <==> 
       (forall i:int :: (i>0 && i!=from && i!=to) ==> h[o, Npr][i] == Card(FBP(h,BBSet(h, o),i)))
    && ((from > 0) ==> h[o, Npr][from] == Card(FBP(h,BBSet(h, o),from)) + 1)
    && ((to > 0)   ==> h[o, Npr][to]   == Card(FBP(h,BBSet(h, o),to)) - 1)
    && h[o, Ncpr] >= 0
    && h[o, Ndpr] >= 0
  );