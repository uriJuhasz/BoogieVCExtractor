function InvIsGoodRegionsListEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvIsGoodRegionsListEx(h, Ex1) <==>
        (forall o: ref ::
            IsGoodRegion(h[o, LNC])
         && IsGoodRegion(h[o, LPC])
         && IsGoodRegion(h[o, LL])
));

//L
function InvLEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvLEx(h, Ex1) <==> 
        (forall o: ref :: {h[o, LL]}
          (o != null && !Ex1[o]) ==> 
            Equal(h[o, LL], Union(h[o, LPC], AddEl(h[o, LNC], o)))
));

function InvNCPCEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvNCPCEx(h, Ex1) <==> 
        (forall o: ref :: //{h[o, LNC], h[o, LPC]}
          (o != null && !Ex1[o]) ==> 
            Disjoint(h[o, LNC], h[o, LPC])
));

//next
function InvNCn1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvNCn1Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Ln]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Ln] == null ==> Equal(h[o, LNC], Empty))
));

function InvNCn2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvNCn2Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Ln], h[h[o, Ln], LNC], h[o, Ln]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Ln] != null ==> Equal(h[o, LNC], AddEl(h[h[o, Ln], LNC], h[o, Ln])))
));

function InvNCoEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvNCoEx(h, Ex1) <==> 
        (forall o: ref :: {h[o, LNC]}
          (o != null && !Ex1[o]) ==> 
            !h[o, LNC][o]
));

function Inve1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Inve1Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Le]}
          (o != null && !Ex1[o]) ==> 
            (o != h[o, Le] ==> h[o, LNC][h[o, Le]])
));

function Inve2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Inve2Ex(h, Ex1) <==> 
        (forall o: ref :: //{h[o, Le], h[o, Ln]}
          (o != null && !Ex1[o]) ==> 
            (o == h[o, Le] <==> h[o, Ln] == null)
));

function Inve3Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Inve3Ex(h, Ex1) <==> 
        (forall o: ref :: 
          (o != null && !Ex1[o]) ==> 
            h[o, LL][h[o, Le]]
));

//previous
function InvPCp1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvPCp1Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Lp]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Lp] == null ==> Equal(h[o, LPC], Empty))
));

function InvPCp2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvPCp2Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Lp], h[h[o, Lp], LPC], h[o, Lp]}
          (o != null && !Ex1[o]) ==> 
            (h[o, Lp] != null ==> Equal(h[o, LPC], AddEl(h[h[o, Lp], LPC], h[o, Lp])))
));

function InvPCoEx(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: InvPCoEx(h, Ex1) <==> 
        (forall o: ref :: {h[o, LPC]}
          (o != null && !Ex1[o]) ==> 
            !h[o, LPC][o]
));

function Invb1Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Invb1Ex(h, Ex1) <==> 
        (forall o: ref :: {h[o, Lb]}
          (o != null && !Ex1[o]) ==> 
            (o != h[o, Lb] ==> h[o, LPC][h[o, Lb]])
));

function Invb2Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Invb2Ex(h, Ex1) <==> 
        (forall o: ref :: //{h[o, Lb], h[o, Lp]}
          (o != null && !Ex1[o]) ==> 
            (o == h[o, Lb] <==> h[o, Lp] == null)
));


function Invb3Ex(h: THeap, Ex1: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion :: Invb3Ex(h, Ex1) <==> 
        (forall o: ref ::
          (o != null && !Ex1[o]) ==> 
            h[o, LL][h[o, Lb]]
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

function InvNCNCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvNCNCEx(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref ::
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, LNC][o'] ==> Sub(h[o', LNC], h[o, LNC]))
));

function InvPCPCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvPCPCEx(h, Ex1, Ex2) <==>
        (forall o: ref, o': ref :: {h[o, LPC][o']}
          (o != null && o' != null && !Ex1[o] && !Ex2[o']) ==> 
            (h[o, LPC][o'] ==> Sub(h[o', LPC], h[o, LPC]))
));


function InvpEx(h: THeap, Ex1: TRegion, Ex2: TRegion) returns (bool);
axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: InvpEx(h, Ex1, Ex2) <==>
        (forall o: ref :: //{h[o, Lp]}
	  (forall o': ref :: //{h[o', Ln]}
            (o != null && !Ex1[o] && o' != null && !Ex2[o']) ==> 
            (h[o, Lp] == o' <==> h[o', Ln] == o)
)));


function InvIsGoodRegionsList(h: THeap) returns (bool);
axiom (forall h: THeap :: InvIsGoodRegionsList(h) <==> InvIsGoodRegionsListEx(h, Empty));

function InvL(h: THeap) returns (bool);
axiom (forall h: THeap :: InvL(h) <==> InvLEx(h, Empty));

function InvNCPC(h: THeap) returns (bool);
axiom (forall h: THeap :: InvNCPC(h) <==> InvNCPCEx(h, Empty));

function InvNCn1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvNCn1(h) <==> InvNCn1Ex(h, Empty));

function InvNCn2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvNCn2(h) <==> InvNCn2Ex(h, Empty));

function InvNCo(h: THeap) returns (bool);
axiom (forall h: THeap :: InvNCo(h) <==> InvNCoEx(h, Empty));

function Inve1(h: THeap) returns (bool);
axiom (forall h: THeap :: Inve1(h) <==> Inve1Ex(h, Empty));

function Inve2(h: THeap) returns (bool);
axiom (forall h: THeap :: Inve2(h) <==> Inve2Ex(h, Empty));

function Inve3(h: THeap) returns (bool);
axiom (forall h: THeap :: Inve3(h) <==> Inve3Ex(h, Empty));

function InvPCp1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvPCp1(h) <==> InvPCp1Ex(h, Empty));

function InvPCp2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvPCp2(h) <==> InvPCp2Ex(h, Empty));

function InvPCo(h: THeap) returns (bool);
axiom (forall h: THeap :: InvPCo(h) <==> InvPCoEx(h, Empty));

function Invb1(h: THeap) returns (bool);
axiom (forall h: THeap :: Invb1(h) <==> Invb1Ex(h, Empty));

function Invb2(h: THeap) returns (bool);
axiom (forall h: THeap :: Invb2(h) <==> Invb2Ex(h, Empty));

function Invb3(h: THeap) returns (bool);
axiom (forall h: THeap :: Invb3(h) <==> Invb3Ex(h, Empty));

function InvLb(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLb(h) <==> InvLbEx(h, Empty, Empty));

function InvLe(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLe(h) <==> InvLeEx(h, Empty, Empty));

function InvLL1(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLL1(h) <==> InvLL1Ex(h, Empty, Empty));

function InvLL2(h: THeap) returns (bool);
axiom (forall h: THeap :: InvLL2(h) <==> InvLL2Ex(h, Empty, Empty));

function InvNCNC(h: THeap) returns (bool);
axiom (forall h: THeap :: InvNCNC(h) <==> InvNCNCEx(h, Empty, Empty));

function InvPCPC(h: THeap) returns (bool);
axiom (forall h: THeap :: InvPCPC(h) <==> InvPCPCEx(h, Empty, Empty));

function Invp(h: THeap) returns (bool);
axiom (forall h: THeap :: Invp(h) <==> InvpEx(h, Empty, Empty));


function InvListEx(h: THeap, Ex: TRegion) returns (bool);
axiom (forall h: THeap, Ex: TRegion :: {InvListEx(h, Ex)}
  InvListEx(h, Ex) <==> (
     InvIsGoodRegionsListEx(h, Ex)
  && InvLEx(h, Ex)
  && InvNCPCEx(h, Ex)
  && InvNCn1Ex(h, Ex)
  && InvNCn2Ex(h, Ex)
  && InvNCoEx(h, Ex)
  && Inve1Ex(h, Ex)
  && Inve2Ex(h, Ex)
  && Inve3Ex(h, Ex)
  && InvPCp1Ex(h, Ex)
  && InvPCp2Ex(h, Ex)
  && InvPCoEx(h, Ex)
  && Invb1Ex(h, Ex)
  && Invb2Ex(h, Ex)
  && Invb3Ex(h, Ex)
  && InvLbEx(h, Ex, Ex)
  && InvLeEx(h, Ex, Ex)
  && InvLL1Ex(h, Ex, Ex)
  && InvLL2Ex(h, Ex, Ex)
  && InvNCNCEx(h, Ex, Ex)
  && InvPCPCEx(h, Ex, Ex)
  && InvpEx(h, Ex, Ex)
));

function InvList(h: THeap) returns (bool);
axiom (forall h: THeap :: {InvList(h)}
  InvList(h) <==> InvListEx(h, Empty)
);
