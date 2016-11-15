function InvIsGoodRegionsListEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvIsGoodRegionsListEx(h, Ex1) <==>
        (forall o: ref ::
            IsGoodRegion(h[o, LL])
));

//List
function InvLEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvLEx(h, Ex1) <==> 
        (forall o: ref :: {h[o, LL]}
          (o != null && !Ex1[o]) ==> 
            h[o, LL][o]
));

//end
function Inve1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Inve1Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Le]}
          (o != null && !Ex1[o]) ==> 
            h[o, LL][h[o, Le]]
));

function Inve2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Inve2Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Le], h[o, Ln]}
          (o != null && !Ex1[o]) ==> 
            (o == h[o, Le] <==> h[o, Ln] == null)
));

//begin

function Invb1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Invb1Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Lb]}
          (o != null && !Ex1[o]) ==> 
            h[o, LL][h[o, Lb]]
));

function Invb2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Invb2Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Lb], h[o, Lp]}
          (o != null && !Ex1[o]) ==> 
            (o == h[o, Lb] <==> h[o, Lp] == null)
));


//next && previous


function InvnEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvnEx(h, Ex1) <==> 
        (forall o: ref :: {h[o, Ln]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Ln] != null ==> h[o, LL][h[o, Ln]])
));

function InvpEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvpEx(h, Ex1) <==> 
        (forall o: ref :: {h[o, Lp]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Lp] != null ==> h[o, LL][h[o, Lp]])
));


function InvnpEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvnpEx(h, Ex1) <==>
        (forall o: ref :: {h[h[o, Ln], Lp]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Ln] != null ==> h[h[o, Ln], Lp] == o)
));

function InvpnEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvpnEx(h, Ex1) <==>
        (forall o: ref :: {h[h[o, Lp], Ln]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Lp] != null ==> h[h[o, Lp], Ln] == o)
));

//L other

function InvLbEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvLbEx(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, LL][o']}
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, LL][o'] ==> h[o, Lb] == h[o', Lb])
));

function InvLeEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvLeEx(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, LL][o']}
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, LL][o'] ==> h[o, Le] == h[o', Le])
));

function InvLL1Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvLL1Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, LL][o']}
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, LL][o'] ==> Equal(h[o, LL], h[o', LL]))
));

function InvLL2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvLL2Ex(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, LL][o']}
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (!h[o, LL][o'] ==> Disjoint(h[o, LL], h[o', LL]))
));

function InvIsGoodRegionsList(h: THeap) returns (bool);
axiom (forall h: THeap :: InvIsGoodRegionsList(h) <==> InvIsGoodRegionsListEx(h, Empty));

function InvL(h: THeap) returns (bool);
axiom (forall h: THeap :: InvL(h) <==> InvLEx(h, Empty));

function Inve1(h: THeap) returns (bool);
axiom (forall h: THeap :: Inve1(h) <==> Inve1Ex(h, Empty));

function Inve2(h: THeap) returns (bool);
axiom (forall h: THeap :: Inve2(h) <==> Inve2Ex(h, Empty));

function Invb1(h: THeap) returns (bool);
axiom (forall h: THeap :: Invb1(h) <==> Invb1Ex(h, Empty));

function Invb2(h: THeap) returns (bool);
axiom (forall h: THeap :: Invb2(h) <==> Invb2Ex(h, Empty));

function Invn(h: THeap) returns (bool);
axiom (forall h: THeap :: Invn(h) <==> InvnEx(h, Empty));

function Invp(h: THeap) returns (bool);
axiom (forall h: THeap :: Invp(h) <==> InvpEx(h, Empty));

function Invpn(h: THeap) returns (bool);
axiom (forall h: THeap :: Invpn(h) <==> InvpnEx(h, Empty));

function Invnp(h: THeap) returns (bool);
axiom (forall h: THeap :: Invnp(h) <==> InvnpEx(h, Empty));

function InvLb(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLb(h) <==> InvLbEx(h, Empty, Empty));

function InvLe(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLe(h) <==> InvLeEx(h, Empty, Empty));

function InvLL1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLL1(h) <==> InvLL1Ex(h, Empty, Empty));

function InvLL2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLL2(h) <==> InvLL2Ex(h, Empty, Empty));


function InvListEx(h: THeap, Ex: TRegion) returns (bool);
axiom (forall h: THeap, Ex: TRegion :: {InvListEx(h, Ex)}
  InvListEx(h, Ex) <==> (
     InvIsGoodRegionsListEx(h, Ex)
  && InvLEx(h, Ex)
  && Inve1Ex(h, Ex)
  && Inve2Ex(h, Ex)
  && Invb1Ex(h, Ex)
  && Invb2Ex(h, Ex)
  && InvnEx(h, Ex)
  && InvpEx(h, Ex)
  && InvpnEx(h, Ex)
  && InvnpEx(h, Ex)  
  && InvLbEx(h, Ex, Ex)
  && InvLeEx(h, Ex, Ex)
  && InvLL1Ex(h, Ex, Ex)
  && InvLL2Ex(h, Ex, Ex)
));

function InvList(h: THeap) returns (bool);
axiom (forall h: THeap :: {InvList(h)}
  InvList(h) <==> InvListEx(h, Empty)
);
