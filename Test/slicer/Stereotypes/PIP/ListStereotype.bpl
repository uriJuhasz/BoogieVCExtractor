const unique Ln: field ref;
const unique Le: field ref;

const unique Lp: field ref;
const unique Lb: field ref;

const unique LL: field TRegion;


function CLn(h: THeap, o: ref) returns (ref);
axiom (forall h: THeap, o: ref :: h[o, Ln] == null ==> CLn(h, o) == h[o, Lb]);
axiom (forall h: THeap, o: ref :: h[o, Ln] != null ==> CLn(h, o) == h[o, Ln]);

function CLp(h: THeap, o: ref) returns (ref);
axiom (forall h: THeap, o: ref :: h[o, Lp] == null ==> CLp(h, o) == h[o, Le]);
axiom (forall h: THeap, o: ref :: h[o, Lp] != null ==> CLp(h, o) == h[o, Lp]);