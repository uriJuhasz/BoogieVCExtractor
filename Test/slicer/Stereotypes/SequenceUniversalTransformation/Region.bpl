type TReg = Set TRef;

const Empty: TReg;
axiom (forall o: TRef :: !Empty[o]);

const Universe : TReg;
axiom (forall o: TRef :: o !=null ==> Universe[o]);

type TRefRef = [TRef]TRef;
type TRefReg = [TRef]TReg;
type TRefInt = [TRef]int;



function forallAddReg(domain: TReg, map: TRefReg, r: TReg) returns (TRefReg);
axiom (forall o : TRef, domain: TReg, map: TRefReg, r: TReg ::  domain[o] ==> forallAddReg(domain, map, r)[o] == Union(map[o], r));
axiom (forall o : TRef, domain: TReg, map: TRefReg, r: TReg :: !domain[o] ==> forallAddReg(domain, map, r)[o] == map[o]);

function forallRemReg(domain: TReg, map: TRefReg, r: TReg) returns (TRefReg);
axiom (forall o : TRef, domain: TReg, map: TRefReg, r: TReg ::  domain[o] ==> forallRemReg(domain, map, r)[o] == Minus(map[o], r));
axiom (forall o : TRef, domain: TReg, map: TRefReg, r: TReg :: !domain[o] ==> forallRemReg(domain, map, r)[o] == map[o]);

function forallAssign<T>(domain: TReg, map: [TRef] T, newVal: T) returns ([TRef] T);
axiom (forall <T> o : TRef, domain: TReg, map: [TRef] T, newVal: T ::  domain[o] ==> forallAssign(domain, map, newVal)[o] == newVal);
axiom (forall <T> o : TRef, domain: TReg, map: [TRef] T, newVal: T :: !domain[o] ==> forallAssign(domain, map, newVal)[o] == map[o]);

function forallAddInt(domain: TReg, map: TRefInt, i: int) returns (TRefInt);
axiom (forall o : TRef, domain: TReg, map: TRefInt, i: int ::  domain[o] ==> forallAddInt(domain, map, i)[o] == map[o] + i);
axiom (forall o : TRef, domain: TReg, map: TRefInt, i: int :: !domain[o] ==> forallAddInt(domain, map, i)[o] == map[o]);

function forallRemInt(domain: TReg, map: TRefInt, i: int) returns (TRefInt);
axiom (forall o : TRef, domain: TReg, map: TRefInt, i: int ::  domain[o] ==> forallRemInt(domain, map, i)[o] == map[o] - i);
axiom (forall o : TRef, domain: TReg, map: TRefInt, i: int :: !domain[o] ==> forallRemInt(domain, map, i)[o] == map[o]);

function forallEqualMap<T>(map: [TRef] T, mapOld: [TRef] T) returns (bool)
  {(forall o: TRef:: map[o] == mapOld[o])}
//axiom (forall <T> map: [TRef] T, mapOld: [TRef] T :: (forallEqualMap(map, mapOld) <==> (forall o: TRef :: map[o] == mapOld[o])));


function forallReplaceMap<T>(domain: TReg, map: [TRef] T, newMap: [TRef] T) returns ([TRef] T);
axiom (forall <T> o : TRef, domain: TReg, map: [TRef] T, newMap: [TRef] T ::  domain[o] ==> forallReplaceMap(domain, map, newMap)[o] == newMap[o]);
axiom (forall <T> o : TRef, domain: TReg, map: [TRef] T, newMap: [TRef] T :: !domain[o] ==> forallReplaceMap(domain, map, newMap)[o] == map[o]);

