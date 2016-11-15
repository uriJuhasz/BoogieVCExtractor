function InvIsGoodRegionsTreeEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvIsGoodRegionsTreeEx(h, Ex1) <==>
        (forall o: ref ::
            IsGoodRegion(h[o, NC])
         && IsGoodRegion(h[o, ND])
         && IsGoodRegion(h[o, NA])
));

function InvCpEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvCpEx(h, Ex1, Ex2) <==> 
        (forall o: ref, o': ref :: {h[o, NC][o'], h[o', Np]}
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, NC][o'] <==> h[o', Np] == o)
));

function InvCCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvCCEx(h, Ex1, Ex2) <==> 
        (forall o: ref, o': ref ::
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (o != o' ==> Disjoint(h[o, NC], h[o', NC]))
));

function InvDEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvDEx(h, Ex1) <==> 
        (forall o: ref ::
          (o != null && !Ex1[o]) ==> 
            !h[o, ND][o]
));

function InvAEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvAEx(h, Ex1) <==>
        (forall o: ref ::
          (o != null && !Ex1[o]) ==> 
            !h[o, NA][o]
));

function InvCD1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvCD1Ex(h, Ex1) <==>
        (forall o: ref ::
          (o != null && !Ex1[o]) ==> 
            Sub(h[o, NC], h[o, ND])
));

function InvCD2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvCD2Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref ::
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, ND][o'] ==> Disjoint(h[o, NC], h[o', ND]))
));

function InvAD1Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvAD1Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, ND][o']} {h[o', NA][o]}
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, ND][o'] <==> h[o', NA][o])
));

function InvAD2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvAD2Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, ND][o']}  
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (!h[o, ND][o'] ==> Disjoint(h[o', NA], AddEl(h[o, ND], o)))
));

function InvAD3Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvAD3Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, ND][o']}  
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, ND][o'] ==> Equal(Minus(h[o', NA], h[o, ND]), AddEl(h[o, NA], o)))
));

function InvDD1Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvDD1Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, ND][o']}  
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, ND][o'] ==> Sub(h[o', ND], h[o, ND]))
));

function InvDD2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvDD2Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, ND][o'], h[o', ND][o]}  
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            ((o != o' && !h[o, ND][o'] && !h[o', ND][o]) ==> 
              Disjoint(h[o, ND], h[o', ND]))
));

function InvAAEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvAAEx(h, Ex1, Ex2) <==> 
        (forall o: ref, o': ref :: {h[o, NA][o']}  
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, NA][o'] ==> Sub(h[o', NA], h[o, NA]))
));

function InvAp1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion:: InvAp1Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Np]}  
          (o != null && !Ex1[o]) ==> 
            (h[o, Np] == null ==> Equal(h[o, NA], Empty))
));


function InvAp2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvAp2Ex(h, Ex1) <==>
        (forall o: ref :: {h[o, Np]}  
          (o != null && !Ex1[o]) ==> 
            (h[o, Np] != null ==> 
              Equal(h[o, NA], AddEl(h[h[o, Np], NA], h[o, Np])))
));


function InvAt1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvAt1Ex(h, Ex1) <==>
        (forall o: ref :: {h[o, Nt]}  
          (o != null && !Ex1[o]) ==> 
            (h[o, Np] != null ==> 
              h[o, NA][h[o, Nt]])
));

function InvAt2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvAt2Ex(h, Ex1) <==>
        (forall o: ref :: {h[o, Nt]}  
          (o != null && !Ex1[o]) ==> 
            (h[o, Np] == null ==> 
              h[o, Nt] == o)
));

function InvAt3Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvAt3Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, NA][o']}  
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, NA][o'] ==> 
              h[o, Nt] == h[o', Nt])
));

function InvIsGoodRegionsTree(h: THeap) returns (bool);
axiom (forall h: THeap :: InvIsGoodRegionsTree(h) <==> InvIsGoodRegionsTreeEx(h, Empty));

function InvCp(h: THeap) returns (bool);
axiom (forall h: THeap :: InvCp(h) <==> InvCpEx(h, Empty, Empty));

function InvCC(h: THeap) returns (bool);
axiom (forall h: THeap :: InvCC(h) <==> InvCCEx(h, Empty, Empty));

function InvD(h: THeap) returns (bool);
axiom (forall h: THeap :: InvD(h) <==> InvDEx(h, Empty));

function InvA(h: THeap) returns (bool);
axiom (forall h: THeap :: InvA(h) <==> InvAEx(h, Empty));

function InvCD1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvCD1(h) <==> InvCD1Ex(h, Empty));

function InvCD2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvCD2(h) <==> InvCD2Ex(h, Empty, Empty));

function InvAD1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAD1(h) <==> InvAD1Ex(h, Empty, Empty));

function InvAD2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAD2(h) <==> InvAD2Ex(h, Empty, Empty));

function InvAD3(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAD3(h) <==> InvAD3Ex(h, Empty, Empty));

function InvDD1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvDD1(h) <==> InvDD1Ex(h, Empty, Empty));

function InvDD2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvDD2(h) <==> InvDD2Ex(h, Empty, Empty));

function InvAA(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAA(h) <==> InvAAEx(h, Empty, Empty));

function InvAp1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAp1(h) <==> InvAp1Ex(h, Empty));

function InvAp2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAp2(h) <==> InvAp2Ex(h, Empty));

function InvAt1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAt1(h) <==> InvAt1Ex(h, Empty));

function InvAt2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAt2(h) <==> InvAt2Ex(h, Empty));

function InvAt3(h: THeap) returns (bool);
axiom (forall h: THeap :: InvAt3(h) <==> InvAt3Ex(h, Empty, Empty));

function InvTreeEx(h: THeap, Ex: TRegion) returns (bool);
axiom (forall h: THeap, Ex: TRegion :: {InvTreeEx(h, Ex)}
  InvTreeEx(h, Ex) <==> (
     InvIsGoodRegionsTreeEx(h, Ex)
  && InvCpEx(h, Ex, Ex)
  && InvCCEx(h, Ex, Ex)
  && InvDEx(h, Ex)
  && InvAEx(h, Ex)
  && InvCD1Ex(h, Ex)
  && InvCD2Ex(h, Ex, Ex)
  && InvAD1Ex(h, Ex, Ex)
  && InvAD2Ex(h, Ex, Ex)
  && InvAD3Ex(h, Ex, Ex)
  && InvDD1Ex(h, Ex, Ex)
  && InvDD2Ex(h, Ex, Ex)
  && InvAAEx(h, Ex, Ex)
  && InvAp1Ex(h, Ex)
  && InvAp2Ex(h, Ex)
  && InvAt1Ex(h, Ex)
  && InvAt2Ex(h, Ex)
  && InvAt3Ex(h, Ex, Ex)
));

function InvTree(h: THeap) returns (bool);
axiom (forall h: THeap :: {InvTree(h)}
  InvTree(h) <==> InvTreeEx(h, Empty)
);