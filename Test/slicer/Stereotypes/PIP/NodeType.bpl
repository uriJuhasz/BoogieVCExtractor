type TNodeState;
const unique StF: TNodeState;
const unique StL: TNodeState;
const unique StD: TNodeState;
axiom (forall St: TNodeState :: St == StF || St == StL || St == StD);

const unique Ndpr: field int;
const unique Ncpr: field int;
const unique Nbb: field ref;
const unique Npr: field TMSet;

const unique NSt: field TNodeState;

function NACCoSet(h: THeap, o: ref) returns (TRegion);
axiom (forall h: THeap, o: ref ::
     Equal(NACCoSet(h, o), AddEl(Union(h[o, NA], h[h[o, Nt], LL]), o))
);

function NACCSet(h: THeap, o: ref) returns (TRegion);
axiom (forall h: THeap, o: ref ::
     Equal(NACCSet(h, o), RemEl(Union(h[o, NA], h[h[o, Nt], LL]), o))
);

function BBSet(h: THeap, o: ref) returns (TRegion);
axiom (forall h: THeap, o: ref :: 
     (h[o, NSt] != StD ==> Equal(BBSet(h, o), h[o, NC]))
  && (h[o, NSt] == StD ==> Equal(BBSet(h, o), AddEl(h[o, NC], CLp(h, o))))
);
