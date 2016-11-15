// Boogie program verifier version 2.3.0.61016, Copyright (c) 2003-2014, Microsoft.
// Command Line Options: /trace /traceTimes /print:out.bpl /enhancedErrorMessages:1 Heap.bpl MSet.bpl Region.bpl Auxiliary.bpl TreeStereotype.bpl ListStereotype.bpl TreeOperations.bpl ListOperations.bpl TreeToList.bpl NodeType.bpl TreeInvariant.bpl ListInvariant.bpl NodeInvariant.bpl InvPrAxioms.bpl Node.bpl Client.bpl

type ref;

type field _;

type THeap = <a>[ref,field a]a;

const unique null: ref;

const unique alloc: field bool;

var $Heap: THeap;

function IsNotAllocatedTree(h: THeap, o: ref) : bool;

axiom (forall h: THeap, o: ref :: 
  { IsNotAllocatedTree(h, o) } 
  IsNotAllocatedTree(h, o)
     <==> (forall o': ref :: 
      h[o', Np] != o
         && h[o', Nt] != o
         && !h[o', NA][o]
         && !h[o', NC][o]
         && !h[o', ND][o]));

function IsNotAllocatedList(h: THeap, o: ref) : bool;

axiom (forall h: THeap, o: ref :: 
  { IsNotAllocatedList(h, o) } 
  IsNotAllocatedList(h, o)
     <==> (forall o': ref :: 
      !h[o', LL][o]
         && h[o', Ln] != o
         && h[o', Le] != o
         && h[o', Lp] != o
         && h[o', Lb] != o));

function IsNotAllocated(h: THeap, o: ref) : bool;

axiom (forall h: THeap, o: ref :: 
  { IsNotAllocated(h, o) } 
  IsNotAllocated(h, o)
     <==> (forall o': ref :: h[o', Nbb] != o)
       && IsNotAllocatedTree(h, o)
       && IsNotAllocatedList(h, o));

type TMSet = [int]int;

function InMSet(TMSet, int) : bool;

axiom (forall m: TMSet, i: int :: { InMSet(m, i) } InMSet(m, i) <==> m[i] != 0);

const EmptyMSet: TMSet;

axiom (forall i: int :: { EmptyMSet[i] } !InMSet(EmptyMSet, i));

function EqualMSet(TMSet, TMSet) : bool;

axiom (forall a: TMSet, b: TMSet :: 
  { EqualMSet(a, b) } 
  EqualMSet(a, b) <==> (forall i: int :: { a[i] } { b[i] } i > 0 ==> a[i] == b[i]));

function AddMSet(TMSet, int) : TMSet;

axiom (forall a: TMSet, i: int :: { AddMSet(a, i)[i] } AddMSet(a, i)[i] == a[i] + 1);

axiom (forall a: TMSet, i: int, j: int :: 
  { AddMSet(a, i)[j] } 
  i != j ==> AddMSet(a, i)[j] == a[j]);

function RemoveMSet(TMSet, int) : TMSet;

axiom (forall a: TMSet, i: int :: 
  { RemoveMSet(a, i)[i] } 
  RemoveMSet(a, i)[i] == a[i] - 1);

axiom (forall a: TMSet, i: int, j: int :: 
  { RemoveMSet(a, i)[j] } 
  i != j ==> RemoveMSet(a, i)[j] == a[j]);

function MaxMSet(TMSet) : int;

axiom MaxMSet(EmptyMSet) == 0;

procedure MSet.increment(this: ref, mset: field TMSet, i: int);
  modifies $Heap;
  ensures $Heap[this, mset] == AddMSet(old($Heap[this, mset]), i);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (o == this && f == mset));



implementation MSet.increment(this: ref, mset: field TMSet, i: int)
{
    $Heap[this, mset] := AddMSet($Heap[this, mset], i);
}



procedure MSet.decrement(this: ref, mset: field TMSet, i: int);
  modifies $Heap;
  ensures $Heap[this, mset] == RemoveMSet(old($Heap[this, mset]), i);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (o == this && f == mset));



implementation MSet.decrement(this: ref, mset: field TMSet, i: int)
{
    $Heap[this, mset] := RemoveMSet($Heap[this, mset], i);
}



axiom (forall s: TMSet, t: TMSet :: 
  { EqualMSet(s, t) } 
  EqualMSet(s, t) ==> MaxMSet(s) == MaxMSet(t));

type TRegion = [ref]bool;

const Empty: TRegion;

axiom (forall o: ref :: { Empty[o] } !Empty[o]);

function Singleton(ref) : TRegion;

axiom (forall r: ref, o: ref :: { Singleton(r)[o] } Singleton(r)[o] <==> r == o);

function Union(TRegion, TRegion) : TRegion;

axiom (forall a: TRegion, b: TRegion, o: ref :: 
  { Union(a, b)[o] } 
  Union(a, b)[o] <==> a[o] || b[o]);

function Sub(TRegion, TRegion) : bool;

axiom (forall a: TRegion, b: TRegion :: 
  { Sub(a, b) } 
  Sub(a, b) <==> (forall o: ref :: { a[o] } { b[o] } a[o] ==> b[o]));

function Equal(TRegion, TRegion) : bool;

axiom (forall a: TRegion, b: TRegion :: 
  { Equal(a, b) } 
  Equal(a, b) <==> (forall o: ref :: { a[o] } { b[o] } a[o] <==> b[o]));

function Disjoint(TRegion, TRegion) : bool;

axiom (forall a: TRegion, b: TRegion :: 
  { Disjoint(a, b) } 
  Disjoint(a, b) <==> (forall o: ref :: { a[o] } { b[o] } !a[o] || !b[o]));

function AddEl(r: TRegion, o: ref) : TRegion;

axiom (forall r: TRegion, o: ref, o': ref :: 
  { AddEl(r, o)[o'] } 
  AddEl(r, o)[o'] <==> o == o' || r[o']);

function RemEl(r: TRegion, o: ref) : TRegion;

axiom (forall r: TRegion, o: ref, o': ref :: 
  { RemEl(r, o)[o'] } 
  RemEl(r, o)[o'] <==> o != o' && r[o']);

function Minus(s: TRegion, r: TRegion) : TRegion;

axiom (forall s: TRegion, r: TRegion, o: ref :: 
  { Minus(s, r)[o] } 
  Minus(s, r)[o] <==> s[o] && !r[o]);

function Card(s: TRegion) : int;

axiom Card(Empty) == 0;

axiom (forall s: TRegion, o: ref :: !s[o] ==> Card(AddEl(s, o)) == Card(s) + 1);

axiom (forall s: TRegion, o: ref :: s[o] ==> Card(RemEl(s, o)) == Card(s) - 1);

axiom (forall s: TRegion, t: TRegion :: Equal(s, t) ==> Card(s) == Card(t));

axiom (forall s: TRegion, t: TRegion :: Equal(s, t) ==> s == t);

function IsGoodRegion(r: TRegion) : bool;

axiom (forall r: TRegion :: { IsGoodRegion(r) } IsGoodRegion(r) <==> !r[null]);

function RegionImageRefInc(r1: TRegion, f: field ref, r2: TRegion, h: THeap) : bool;

axiom (forall r1: TRegion, f: field ref, r2: TRegion, h: THeap :: 
  { RegionImageRefInc(r1, f, r2, h) } 
  RegionImageRefInc(r1, f, r2, h)
     <==> (forall o: ref :: r1[o] ==> h[o, f] == null || r2[h[o, f]]));

function RegionImageRegionInc(r1: TRegion, f: field TRegion, r2: TRegion, h: THeap) : bool;

axiom (forall r1: TRegion, f: field TRegion, r2: TRegion, h: THeap :: 
  { RegionImageRegionInc(r1, f, r2, h) } 
  RegionImageRegionInc(r1, f, r2, h)
     <==> (forall o: ref :: { r1[o] } r1[o] ==> Sub(h[o, f], r2)));

procedure addToAllIn(r1: TRegion, f1: field TRegion, r2: TRegion);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == old(Union($Heap[o, f1], r2)));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



procedure removeFromAllIn(r1: TRegion, f1: field TRegion, r2: TRegion);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == old(Minus($Heap[o, f1], r2)));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



procedure assignToAllIn(r1: TRegion, f1: field ref, val: ref);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == val);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



procedure assignToAllInReg(r1: TRegion, f1: field TRegion, val: TRegion);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == val);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



procedure assignToAllInSt(r1: TRegion, f1: field TNodeState, val: TNodeState);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == val);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



procedure assignToAllInField(r1: TRegion, f1: field ref, f2: field ref);
  modifies $Heap;
  ensures (forall o: ref :: r1[o] ==> $Heap[o, f1] == $Heap[o, f2]);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f]) || (r1[o] && f == f1));



function Max(i: int, j: int) : int;

axiom (forall i: int, j: int :: 
  { Max(i, j) } 
  Max(i, j) >= i && Max(i, j) >= j && (Max(i, j) == i || Max(i, j) == j));

function FBP(h: THeap, r: TRegion, i: int) : TRegion;

axiom (forall h: THeap, r: TRegion, i: int, o: ref :: 
  FBP(h, r, i)[o] <==> r[o] && h[o, Ncpr] == i && o != null);

const unique NC: field TRegion;

const unique ND: field TRegion;

const unique NA: field TRegion;

const unique Np: field ref;

const unique Nt: field ref;

const unique Ln: field ref;

const unique Le: field ref;

const unique Lp: field ref;

const unique Lb: field ref;

const unique LL: field TRegion;

function CLn(h: THeap, o: ref) : ref;

axiom (forall h: THeap, o: ref :: h[o, Ln] == null ==> CLn(h, o) == h[o, Lb]);

axiom (forall h: THeap, o: ref :: h[o, Ln] != null ==> CLn(h, o) == h[o, Ln]);

function CLp(h: THeap, o: ref) : ref;

axiom (forall h: THeap, o: ref :: h[o, Lp] == null ==> CLp(h, o) == h[o, Le]);

axiom (forall h: THeap, o: ref :: h[o, Lp] != null ==> CLp(h, o) == h[o, Lp]);

procedure RemoveSubTree(tree: ref, subTree: ref);
  requires tree != null;
  requires subTree != null;
  requires $Heap[tree, NC][subTree];
  requires InvTree($Heap);
  requires InvList($Heap);
  modifies $Heap;
  ensures InvTree($Heap);
  ensures InvList($Heap);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == subTree && f == Np)
     || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == Nt)
     || (o == tree && f == NC)
     || (AddEl(old($Heap)[tree, NA], tree)[o] && f == ND)
     || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == NA));
  ensures $Heap[subTree, Np] == null;
  ensures (forall o: ref :: 
  AddEl($Heap[subTree, ND], subTree)[o] ==> $Heap[o, Nt] == subTree);
  ensures $Heap[tree, NC] == RemEl(old($Heap)[tree, NC], subTree);
  ensures (forall o: ref :: 
  AddEl($Heap[subTree, ND], subTree)[o]
     ==> $Heap[o, NA] == Minus(old($Heap)[o, NA], AddEl($Heap[tree, NA], tree)));
  ensures (forall o: ref :: 
  AddEl($Heap[tree, NA], tree)[o]
     ==> $Heap[o, ND] == Minus(old($Heap)[o, ND], AddEl($Heap[subTree, ND], subTree)));



implementation RemoveSubTree(tree: ref, subTree: ref)
{
    $Heap[subTree, Np] := null;
    $Heap[tree, NC] := RemEl($Heap[tree, NC], subTree);
    call removeFromAllIn(AddEl($Heap[subTree, ND], subTree), NA, AddEl($Heap[tree, NA], tree));
    call removeFromAllIn(AddEl($Heap[tree, NA], tree), ND, AddEl($Heap[subTree, ND], subTree));
    call assignToAllIn(AddEl($Heap[subTree, ND], subTree), Nt, subTree);
}



procedure AddSubTree(tree: ref, subTree: ref);
  requires tree != null;
  requires subTree != null;
  requires tree != subTree;
  requires !$Heap[subTree, ND][tree];
  requires $Heap[subTree, Np] == null;
  requires InvTree($Heap);
  requires InvList($Heap);
  modifies $Heap;
  ensures InvTree($Heap);
  ensures InvList($Heap);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == subTree && f == Np)
     || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == Nt)
     || (o == tree && f == NC)
     || (AddEl(old($Heap)[tree, NA], tree)[o] && f == ND)
     || (AddEl(old($Heap)[subTree, ND], subTree)[o] && f == NA));
  ensures $Heap[subTree, Np] == tree;
  ensures (forall o: ref :: 
  AddEl($Heap[subTree, ND], subTree)[o] ==> $Heap[o, Nt] == old($Heap)[tree, Nt]);
  ensures $Heap[tree, NC] == AddEl(old($Heap)[tree, NC], subTree);
  ensures (forall o: ref :: 
  AddEl($Heap[tree, NA], tree)[o]
     ==> $Heap[o, ND] == Union(old($Heap)[o, ND], AddEl($Heap[subTree, ND], subTree)));
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, ND], subTree)[o]
     ==> $Heap[o, NA] == Union(old($Heap)[o, NA], AddEl($Heap[tree, NA], tree)));



implementation AddSubTree(tree: ref, subTree: ref)
{
    $Heap[subTree, Np] := tree;
    $Heap[tree, NC] := AddEl($Heap[tree, NC], subTree);
    call addToAllIn(AddEl($Heap[tree, NA], tree), ND, AddEl($Heap[subTree, ND], subTree));
    call addToAllIn(AddEl($Heap[subTree, ND], subTree), NA, AddEl($Heap[tree, NA], tree));
    call assignToAllIn(AddEl($Heap[subTree, ND], subTree), Nt, $Heap[tree, Nt]);
}



function IsEmptyTree(h: THeap, o: ref) : bool;

axiom (forall h: THeap, o: ref :: 
  IsEmptyTree(h, o)
     <==> h[o, Np] == null
       && h[o, Nt] == o
       && h[o, NA] == Empty
       && h[o, NC] == Empty
       && h[o, ND] == Empty);

procedure CreatEmptyTree(o: ref, NotAllocated: TRegion);
  requires o != null;
  requires NotAllocated[o];
  requires InvTreeEx($Heap, NotAllocated);
  requires IsNotAllocatedTree($Heap, o);
  modifies $Heap;
  ensures InvTreeEx($Heap, RemEl(NotAllocated, o));
  ensures IsEmptyTree($Heap, o);
  ensures (forall<a> o': ref, f: field a :: 
  $Heap[o', f] == old($Heap[o', f])
     || (o' == o && f == Np)
     || (o' == o && f == Nt)
     || (o' == o && f == NA)
     || (o' == o && f == NC)
     || (o' == o && f == ND));



implementation CreatEmptyTree(o: ref, NotAllocated: TRegion)
{
    $Heap[o, Np] := null;
    $Heap[o, Nt] := o;
    $Heap[o, NA] := Empty;
    $Heap[o, NC] := Empty;
    $Heap[o, ND] := Empty;
}



function IsEmptyList($Heap: THeap, o: ref) : bool;

axiom (forall $Heap: THeap, o: ref :: 
  IsEmptyList($Heap, o)
     <==> $Heap[o, LL] == Singleton(o)
       && $Heap[o, Ln] == null
       && $Heap[o, Le] == o
       && $Heap[o, Lp] == null
       && $Heap[o, Lb] == o);

procedure CreatEmptyList(o: ref, NotAllocated: TRegion);
  requires o != null;
  requires NotAllocated[o];
  requires InvListEx($Heap, NotAllocated);
  requires IsNotAllocatedList($Heap, o);
  modifies $Heap;
  ensures InvListEx($Heap, RemEl(NotAllocated, o));
  ensures IsEmptyList($Heap, o);
  ensures (forall<a> o': ref, f: field a :: 
  $Heap[o', f] == old($Heap[o', f])
     || (o' == o && f == LL)
     || (o' == o && f == Ln)
     || (o' == o && f == Le)
     || (o' == o && f == Lp)
     || (o' == o && f == Lb));



implementation CreatEmptyList(o: ref, NotAllocated: TRegion)
{
    $Heap[o, LL] := Singleton(o);
    $Heap[o, Ln] := null;
    $Heap[o, Le] := o;
    $Heap[o, Lp] := null;
    $Heap[o, Lb] := o;
}



procedure AddToEnd(list: ref, el: ref);
  requires list != null;
  requires el != null;
  requires IsEmptyList($Heap, el);
  requires !$Heap[list, LL][el];
  requires InvList($Heap);
  requires InvTree($Heap);
  modifies $Heap;
  ensures InvList($Heap);
  ensures InvTree($Heap);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (o == old($Heap)[list, Le] && f == Ln)
     || (o == el && f == Lp)
     || (o == el && f == Lb)
     || (o == el && f == LL)
     || (old($Heap)[list, LL][o] && f == LL)
     || (old($Heap)[list, LL][o] && f == Le));
  ensures $Heap[old($Heap)[list, Le], Ln] == el;
  ensures $Heap[el, Lp] == old($Heap)[list, Le];
  ensures $Heap[el, Lb] == $Heap[list, Lb];
  ensures $Heap[el, LL] == AddEl(old($Heap)[list, LL], el);
  ensures (forall o: ref :: 
  old($Heap)[list, LL][o]
     ==> $Heap[o, LL] == Union(old($Heap)[o, LL], Singleton(el)));
  ensures (forall o: ref :: old($Heap)[list, LL][o] ==> $Heap[o, Le] == el);



implementation AddToEnd(list: ref, el: ref)
{
  var oldEnd: ref;
  var oldList: TRegion;

    oldEnd := $Heap[list, Le];
    oldList := $Heap[list, LL];
    $Heap[oldEnd, Ln] := el;
    $Heap[el, Lp] := oldEnd;
    $Heap[el, Lb] := $Heap[list, Lb];
    $Heap[el, LL] := AddEl(oldList, el);
    call addToAllIn(oldList, LL, Singleton(el));
    call assignToAllIn(oldList, Le, el);
}



procedure TreeToList(tree: ref, subTree: ref);
  requires tree != null;
  requires subTree != null;
  requires $Heap[tree, Np] == null;
  requires $Heap[tree, ND][subTree];
  requires InvTree($Heap);
  requires InvList($Heap);
  requires (forall o: ref :: 
  { AddEl($Heap[subTree, NA], subTree)[o], IsEmptyList($Heap, o) } 
  AddEl($Heap[subTree, NA], subTree)[o] ==> IsEmptyList($Heap, o));
  modifies $Heap;
  ensures InvList($Heap);
  ensures $Heap[tree, Ln] == null;
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, NA], subTree)[o]
     ==> Equal($Heap[o, LL], AddEl(old($Heap)[subTree, NA], subTree)));
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Lb] == subTree);
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Le] == tree);
  ensures InvTree($Heap);
  ensures (forall o: ref :: 
  RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o]
     ==> old($Heap[o, Np]) == $Heap[o, Ln]);
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Np] == null);
  ensures (forall o: ref :: 
  RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o]
     ==> $Heap[o, NC] == RemEl(old($Heap)[o, NC], $Heap[o, Lp]));
  ensures (forall o: ref :: 
  RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o]
     ==> $Heap[o, ND]
       == Minus(old($Heap)[o, ND], AddEl(old($Heap)[$Heap[o, Lp], ND], $Heap[o, Lp])));
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, NA], subTree)[o] ==> Equal($Heap[o, NA], Empty));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == LL)
     || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Lb)
     || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Le)
     || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Lp)
     || (AddEl(old($Heap)[subTree, NA], subTree)[o] && f == Ln)
     || (RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o] && f == Np)
     || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == Nt)
     || (RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] && f == NC)
     || (RemEl(old($Heap)[subTree, NA], subTree)[o] && f == ND)
     || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == NA));



implementation TreeToList(tree: ref, subTree: ref)
{
    call TreeToListGetList(tree, subTree);
    call TreeToListRemTree(tree, subTree);
}



procedure TreeToListGetList(tree: ref, subTree: ref);
  requires tree != null;
  requires subTree != null;
  requires $Heap[tree, Np] == null;
  requires $Heap[tree, ND][subTree];
  requires InvTree($Heap);
  requires InvList($Heap);
  requires (forall o: ref :: 
  { AddEl($Heap[subTree, NA], subTree)[o], IsEmptyList($Heap, o) } 
  AddEl($Heap[subTree, NA], subTree)[o] ==> IsEmptyList($Heap, o));
  modifies $Heap;
  ensures InvTree($Heap);
  ensures InvList($Heap);
  ensures (forall o: ref :: 
  RemEl(AddEl($Heap[subTree, NA], subTree), tree)[o]
     ==> $Heap[o, Np] == $Heap[o, Ln]);
  ensures $Heap[tree, Ln] == null;
  ensures (forall o: ref :: 
  AddEl($Heap[subTree, NA], subTree)[o]
     ==> Equal($Heap[o, LL], AddEl($Heap[subTree, NA], subTree)));
  ensures (forall o: ref :: 
  AddEl($Heap[subTree, NA], subTree)[o] ==> $Heap[o, Lb] == subTree);
  ensures (forall o: ref :: 
  AddEl($Heap[subTree, NA], subTree)[o] ==> $Heap[o, Le] == tree);
  ensures (forall o: ref :: 
  $Heap[subTree, NA][o] ==> AddEl($Heap[subTree, NA], subTree)[$Heap[o, Lp]]);
  ensures (forall o: ref :: $Heap[subTree, NA][o] ==> $Heap[o, NC][$Heap[o, Lp]]);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (AddEl($Heap[subTree, NA], subTree)[o] && f == LL)
     || (AddEl($Heap[subTree, NA], subTree)[o] && f == Lb)
     || (AddEl($Heap[subTree, NA], subTree)[o] && f == Le)
     || (AddEl($Heap[subTree, NA], subTree)[o] && f == Lp)
     || (AddEl($Heap[subTree, NA], subTree)[o] && f == Ln));



implementation TreeToListGetList(tree: ref, subTree: ref)
{
  var Done: TRegion;
  var All: TRegion;
  var Rest: TRegion;
  var current: ref;
  var newCurrent: ref;

    All := AddEl($Heap[subTree, NA], subTree);
    Done := Empty;
    Rest := $Heap[subTree, NA];
    current := subTree;
    while (current != null)
      invariant InvTree($Heap);
      invariant InvList($Heap);
      invariant current != null ==> All[current];
      invariant current != null ==> Sub($Heap[current, NA], All);
      invariant current != null ==> Equal(Done, Minus(All, AddEl(Rest, current)));
      invariant current != null ==> Equal(Rest, $Heap[current, NA]);
      invariant current == subTree ==> Equal(Done, Empty);
      invariant current == null ==> Equal(Done, All);
      invariant current != null
   ==> (forall o: ref :: 
    AddEl($Heap[current, NA], current)[o] ==> IsEmptyList($Heap, o));
      invariant current != subTree ==> Equal($Heap[subTree, LL], Done);
      invariant $Heap[subTree, Lb] == subTree;
      invariant $Heap[tree, Np] == null;
      invariant (forall o: ref :: 
  RemEl(Done, $Heap[subTree, Le])[o] ==> $Heap[o, Np] == $Heap[o, Ln]);
      invariant current != subTree && current != null
   ==> $Heap[$Heap[subTree, Le], Np] == current;
      invariant (forall o: ref :: RemEl(Done, subTree)[o] ==> $Heap[o, NC][$Heap[o, Lp]]);
      invariant current != null
   ==> (forall<a> o: ref, f: field a :: 
    $Heap[o, f] == old($Heap[o, f])
       || (AddEl(Done, current)[o] && f == LL)
       || (AddEl(Done, current)[o] && f == Lb)
       || (AddEl(Done, current)[o] && f == Le)
       || (AddEl(Done, current)[o] && f == Lp)
       || (AddEl(Done, current)[o] && f == Ln));
      invariant current == null
   ==> (forall<a> o: ref, f: field a :: 
    $Heap[o, f] == old($Heap[o, f])
       || (Done[o] && f == LL)
       || (Done[o] && f == Lb)
       || (Done[o] && f == Le)
       || (Done[o] && f == Lp)
       || (Done[o] && f == Ln));
    {
        newCurrent := $Heap[current, Np];
        if (current != subTree)
        {
            call AddToEnd(subTree, current);
        }

        Done := AddEl(Done, current);
        Rest := RemEl(Rest, newCurrent);
        current := newCurrent;
    }
}



procedure TreeToListRemTree(tree: ref, subTree: ref);
  requires tree != null;
  requires subTree != null;
  requires $Heap[tree, Np] == null;
  requires $Heap[tree, ND][subTree];
  requires InvTree($Heap);
  requires InvList($Heap);
  requires (forall o: ref :: 
  RemEl(AddEl($Heap[subTree, NA], subTree), tree)[o]
     ==> $Heap[o, Np] == $Heap[o, Ln]);
  requires (forall o: ref :: 
  $Heap[subTree, NA][o] ==> AddEl($Heap[subTree, NA], subTree)[$Heap[o, Lp]]);
  requires (forall o: ref :: $Heap[subTree, NA][o] ==> $Heap[o, NC][$Heap[o, Lp]]);
  modifies $Heap;
  ensures InvList($Heap);
  ensures InvTree($Heap);
  ensures (forall o: ref :: 
  RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o]
     ==> old($Heap[o, Np]) == $Heap[o, Ln]);
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, NA], subTree)[o] ==> $Heap[o, Np] == null);
  ensures (forall o: ref :: 
  RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o]
     ==> $Heap[o, NC] == RemEl(old($Heap)[o, NC], $Heap[o, Lp]));
  ensures (forall o: ref :: 
  RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o]
     ==> $Heap[o, ND]
       == Minus(old($Heap)[o, ND], AddEl(old($Heap)[$Heap[o, Lp], ND], $Heap[o, Lp])));
  ensures (forall o: ref :: 
  AddEl(old($Heap)[subTree, NA], subTree)[o] ==> Equal($Heap[o, NA], Empty));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (RemEl(AddEl(old($Heap)[subTree, NA], subTree), tree)[o] && f == Np)
     || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == Nt)
     || (RemEl(AddEl(old($Heap)[subTree, NA], tree), subTree)[o] && f == NC)
     || (RemEl(old($Heap)[subTree, NA], subTree)[o] && f == ND)
     || (AddEl(old($Heap)[$Heap[tree, Lp], ND], $Heap[tree, Lp])[o] && f == NA));



implementation TreeToListRemTree(tree: ref, subTree: ref)
{
  var nextTree: ref;

    nextTree := $Heap[tree, Lp];
    call RemoveSubTree(tree, nextTree);
    if (nextTree != subTree)
    {
        call TreeToListRemTree(nextTree, subTree);
    }
}



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

function NACCoSet(h: THeap, o: ref) : TRegion;

axiom (forall h: THeap, o: ref :: 
  Equal(NACCoSet(h, o), AddEl(Union(h[o, NA], h[h[o, Nt], LL]), o)));

function NACCSet(h: THeap, o: ref) : TRegion;

axiom (forall h: THeap, o: ref :: 
  Equal(NACCSet(h, o), RemEl(Union(h[o, NA], h[h[o, Nt], LL]), o)));

function BBSet(h: THeap, o: ref) : TRegion;

axiom (forall h: THeap, o: ref :: 
  (h[o, NSt] != StD ==> Equal(BBSet(h, o), h[o, NC]))
     && (h[o, NSt] == StD ==> Equal(BBSet(h, o), AddEl(h[o, NC], CLp(h, o)))));

function InvIsGoodRegionsTreeEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvIsGoodRegionsTreeEx(h, Ex1)
     <==> (forall o: ref :: 
      IsGoodRegion(h[o, NC]) && IsGoodRegion(h[o, ND]) && IsGoodRegion(h[o, NA])));

function InvCpEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvCpEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, NC][o'], h[o', Np] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> (h[o, NC][o'] <==> h[o', Np] == o)));

function InvCCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvCCEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        o != o'
         ==> Disjoint(h[o, NC], h[o', NC])));

function InvDEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvDEx(h, Ex1) <==> (forall o: ref :: o != null && !Ex1[o] ==> !h[o, ND][o]));

function InvAEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvAEx(h, Ex1) <==> (forall o: ref :: o != null && !Ex1[o] ==> !h[o, NA][o]));

function InvCD1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvCD1Ex(h, Ex1)
     <==> (forall o: ref :: o != null && !Ex1[o] ==> Sub(h[o, NC], h[o, ND])));

function InvCD2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvCD2Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, ND][o']
         ==> Disjoint(h[o, NC], h[o', ND])));

function InvAD1Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvAD1Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, ND][o'] } { h[o', NA][o] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> (h[o, ND][o'] <==> h[o', NA][o])));

function InvAD2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvAD2Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, ND][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        !h[o, ND][o']
         ==> Disjoint(h[o', NA], AddEl(h[o, ND], o))));

function InvAD3Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvAD3Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, ND][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, ND][o']
         ==> Equal(Minus(h[o', NA], h[o, ND]), AddEl(h[o, NA], o))));

function InvDD1Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvDD1Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, ND][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, ND][o']
         ==> Sub(h[o', ND], h[o, ND])));

function InvDD2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvDD2Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, ND][o'], h[o', ND][o] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        o != o' && !h[o, ND][o'] && !h[o', ND][o]
         ==> Disjoint(h[o, ND], h[o', ND])));

function InvAAEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvAAEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, NA][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, NA][o']
         ==> Sub(h[o', NA], h[o, NA])));

function InvAp1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvAp1Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Np] } 
      o != null && !Ex1[o] ==> h[o, Np] == null ==> Equal(h[o, NA], Empty)));

function InvAp2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvAp2Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Np] } 
      o != null && !Ex1[o]
         ==> 
        h[o, Np] != null
         ==> Equal(h[o, NA], AddEl(h[h[o, Np], NA], h[o, Np]))));

function InvAt1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvAt1Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Nt] } 
      o != null && !Ex1[o] ==> h[o, Np] != null ==> h[o, NA][h[o, Nt]]));

function InvAt2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvAt2Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Nt] } 
      o != null && !Ex1[o] ==> h[o, Np] == null ==> h[o, Nt] == o));

function InvAt3Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvAt3Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, NA][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, NA][o']
         ==> h[o, Nt] == h[o', Nt]));

function InvIsGoodRegionsTree(h: THeap) : bool;

axiom (forall h: THeap :: 
  InvIsGoodRegionsTree(h) <==> InvIsGoodRegionsTreeEx(h, Empty));

function InvCp(h: THeap) : bool;

axiom (forall h: THeap :: InvCp(h) <==> InvCpEx(h, Empty, Empty));

function InvCC(h: THeap) : bool;

axiom (forall h: THeap :: InvCC(h) <==> InvCCEx(h, Empty, Empty));

function InvD(h: THeap) : bool;

axiom (forall h: THeap :: InvD(h) <==> InvDEx(h, Empty));

function InvA(h: THeap) : bool;

axiom (forall h: THeap :: InvA(h) <==> InvAEx(h, Empty));

function InvCD1(h: THeap) : bool;

axiom (forall h: THeap :: InvCD1(h) <==> InvCD1Ex(h, Empty));

function InvCD2(h: THeap) : bool;

axiom (forall h: THeap :: InvCD2(h) <==> InvCD2Ex(h, Empty, Empty));

function InvAD1(h: THeap) : bool;

axiom (forall h: THeap :: InvAD1(h) <==> InvAD1Ex(h, Empty, Empty));

function InvAD2(h: THeap) : bool;

axiom (forall h: THeap :: InvAD2(h) <==> InvAD2Ex(h, Empty, Empty));

function InvAD3(h: THeap) : bool;

axiom (forall h: THeap :: InvAD3(h) <==> InvAD3Ex(h, Empty, Empty));

function InvDD1(h: THeap) : bool;

axiom (forall h: THeap :: InvDD1(h) <==> InvDD1Ex(h, Empty, Empty));

function InvDD2(h: THeap) : bool;

axiom (forall h: THeap :: InvDD2(h) <==> InvDD2Ex(h, Empty, Empty));

function InvAA(h: THeap) : bool;

axiom (forall h: THeap :: InvAA(h) <==> InvAAEx(h, Empty, Empty));

function InvAp1(h: THeap) : bool;

axiom (forall h: THeap :: InvAp1(h) <==> InvAp1Ex(h, Empty));

function InvAp2(h: THeap) : bool;

axiom (forall h: THeap :: InvAp2(h) <==> InvAp2Ex(h, Empty));

function InvAt1(h: THeap) : bool;

axiom (forall h: THeap :: InvAt1(h) <==> InvAt1Ex(h, Empty));

function InvAt2(h: THeap) : bool;

axiom (forall h: THeap :: InvAt2(h) <==> InvAt2Ex(h, Empty));

function InvAt3(h: THeap) : bool;

axiom (forall h: THeap :: InvAt3(h) <==> InvAt3Ex(h, Empty, Empty));

function InvTreeEx(h: THeap, Ex: TRegion) : bool;

axiom (forall h: THeap, Ex: TRegion :: 
  { InvTreeEx(h, Ex) } 
  InvTreeEx(h, Ex)
     <==> InvIsGoodRegionsTreeEx(h, Ex)
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
       && InvAt3Ex(h, Ex, Ex));

function InvTree(h: THeap) : bool;

axiom (forall h: THeap :: { InvTree(h) } InvTree(h) <==> InvTreeEx(h, Empty));

function InvIsGoodRegionsListEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvIsGoodRegionsListEx(h, Ex1) <==> (forall o: ref :: IsGoodRegion(h[o, LL])));

function InvLEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvLEx(h, Ex1)
     <==> (forall o: ref :: { h[o, LL] } o != null && !Ex1[o] ==> h[o, LL][o]));

function Inve1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Inve1Ex(h, Ex1)
     <==> (forall o: ref :: { h[o, Le] } o != null && !Ex1[o] ==> h[o, LL][h[o, Le]]));

function Inve2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Inve2Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Le], h[o, Ln] } 
      o != null && !Ex1[o] ==> (o == h[o, Le] <==> h[o, Ln] == null)));

function Invb1Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Invb1Ex(h, Ex1)
     <==> (forall o: ref :: { h[o, Lb] } o != null && !Ex1[o] ==> h[o, LL][h[o, Lb]]));

function Invb2Ex(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  Invb2Ex(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Lb], h[o, Lp] } 
      o != null && !Ex1[o] ==> (o == h[o, Lb] <==> h[o, Lp] == null)));

function InvnEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvnEx(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Ln] } 
      o != null && !Ex1[o] ==> h[o, Ln] != null ==> h[o, LL][h[o, Ln]]));

function InvpEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvpEx(h, Ex1)
     <==> (forall o: ref :: 
      { h[o, Lp] } 
      o != null && !Ex1[o] ==> h[o, Lp] != null ==> h[o, LL][h[o, Lp]]));

function InvnpEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvnpEx(h, Ex1)
     <==> (forall o: ref :: 
      { h[h[o, Ln], Lp] } 
      o != null && !Ex1[o] ==> h[o, Ln] != null ==> h[h[o, Ln], Lp] == o));

function InvpnEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvpnEx(h, Ex1)
     <==> (forall o: ref :: 
      { h[h[o, Lp], Ln] } 
      o != null && !Ex1[o] ==> h[o, Lp] != null ==> h[h[o, Lp], Ln] == o));

function InvLbEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLbEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LL][o']
         ==> h[o, Lb] == h[o', Lb]));

function InvLeEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLeEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LL][o']
         ==> h[o, Le] == h[o', Le]));

function InvLL1Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLL1Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, LL][o']
         ==> Equal(h[o, LL], h[o', LL])));

function InvLL2Ex(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvLL2Ex(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      { h[o, LL][o'] } 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        !h[o, LL][o']
         ==> Disjoint(h[o, LL], h[o', LL])));

function InvIsGoodRegionsList(h: THeap) : bool;

axiom (forall h: THeap :: 
  InvIsGoodRegionsList(h) <==> InvIsGoodRegionsListEx(h, Empty));

function InvL(h: THeap) : bool;

axiom (forall h: THeap :: InvL(h) <==> InvLEx(h, Empty));

function Inve1(h: THeap) : bool;

axiom (forall h: THeap :: Inve1(h) <==> Inve1Ex(h, Empty));

function Inve2(h: THeap) : bool;

axiom (forall h: THeap :: Inve2(h) <==> Inve2Ex(h, Empty));

function Invb1(h: THeap) : bool;

axiom (forall h: THeap :: Invb1(h) <==> Invb1Ex(h, Empty));

function Invb2(h: THeap) : bool;

axiom (forall h: THeap :: Invb2(h) <==> Invb2Ex(h, Empty));

function Invn(h: THeap) : bool;

axiom (forall h: THeap :: Invn(h) <==> InvnEx(h, Empty));

function Invp(h: THeap) : bool;

axiom (forall h: THeap :: Invp(h) <==> InvpEx(h, Empty));

function Invpn(h: THeap) : bool;

axiom (forall h: THeap :: Invpn(h) <==> InvpnEx(h, Empty));

function Invnp(h: THeap) : bool;

axiom (forall h: THeap :: Invnp(h) <==> InvnpEx(h, Empty));

function InvLb(h: THeap) : bool;

axiom (forall h: THeap :: InvLb(h) <==> InvLbEx(h, Empty, Empty));

function InvLe(h: THeap) : bool;

axiom (forall h: THeap :: InvLe(h) <==> InvLeEx(h, Empty, Empty));

function InvLL1(h: THeap) : bool;

axiom (forall h: THeap :: InvLL1(h) <==> InvLL1Ex(h, Empty, Empty));

function InvLL2(h: THeap) : bool;

axiom (forall h: THeap :: InvLL2(h) <==> InvLL2Ex(h, Empty, Empty));

function InvListEx(h: THeap, Ex: TRegion) : bool;

axiom (forall h: THeap, Ex: TRegion :: 
  { InvListEx(h, Ex) } 
  InvListEx(h, Ex)
     <==> InvIsGoodRegionsListEx(h, Ex)
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
       && InvLL2Ex(h, Ex, Ex));

function InvList(h: THeap) : bool;

axiom (forall h: THeap :: { InvList(h) } InvList(h) <==> InvListEx(h, Empty));

function InvStFEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvStFEx(h, Ex1)
     <==> (forall o: ref :: 
      o != null && !Ex1[o]
         ==> (h[o, NSt] == StF <==> h[o, Nbb] == null && h[o, Np] == h[o, Nbb])));

function InvStLEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvStLEx(h, Ex1)
     <==> (forall o: ref :: 
      o != null && !Ex1[o]
         ==> (h[o, NSt] == StL <==> h[o, Nbb] != null && h[o, Np] == h[o, Nbb])));

function InvStDEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvStDEx(h, Ex1)
     <==> (forall o: ref :: 
      o != null && !Ex1[o]
         ==> (h[o, NSt] == StD <==> h[o, Nbb] != null && CLn(h, o) == h[o, Nbb])));

function InvStNDLEx(h: THeap, Ex1: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion :: 
  InvStNDLEx(h, Ex1)
     <==> (forall o: ref :: 
      o != null && !Ex1[o] ==> h[o, NSt] != StD ==> IsEmptyList(h, o)));

function InvStDCCEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvStDCCEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, NSt] == StD && h[o, LL][o']
         ==> h[o', NSt] == StD));

function InvStADEx(h: THeap, Ex1: TRegion, Ex2: TRegion) : bool;

axiom (forall h: THeap, Ex1: TRegion, Ex2: TRegion :: 
  InvStADEx(h, Ex1, Ex2)
     <==> (forall o: ref, o': ref :: 
      o != null && o' != null && !Ex1[o] && !Ex2[o']
         ==> 
        h[o, ND][o']
         ==> h[o', NSt] == StL));

function InvStF(h: THeap) : bool;

axiom (forall h: THeap :: InvStF(h) <==> InvStFEx(h, Empty));

function InvStL(h: THeap) : bool;

axiom (forall h: THeap :: InvStL(h) <==> InvStLEx(h, Empty));

function InvStD(h: THeap) : bool;

axiom (forall h: THeap :: InvStD(h) <==> InvStDEx(h, Empty));

function InvStNDL(h: THeap) : bool;

axiom (forall h: THeap :: InvStNDL(h) <==> InvStNDLEx(h, Empty));

function InvStDCC(h: THeap) : bool;

axiom (forall h: THeap :: InvStDCC(h) <==> InvStDCCEx(h, Empty, Empty));

function InvStAD(h: THeap) : bool;

axiom (forall h: THeap :: InvStAD(h) <==> InvStADEx(h, Empty, Empty));

function InvStructEx(h: THeap, Ex: TRegion) : bool;

axiom (forall h: THeap, Ex: TRegion :: 
  InvStructEx(h, Ex)
     <==> InvTreeEx(h, Ex)
       && InvListEx(h, Ex)
       && InvStFEx(h, Ex)
       && InvStLEx(h, Ex)
       && InvStDEx(h, Ex)
       && InvStNDLEx(h, Ex)
       && InvStDCCEx(h, Ex, Ex)
       && InvStADEx(h, Ex, Ex));

function InvStruct(h: THeap) : bool;

axiom (forall h: THeap :: InvStruct(h) <==> InvStructEx(h, Empty));

function InvPr(h: THeap, o: ref) : bool;

axiom (forall h: THeap, o: ref :: 
  InvPr(h, o)
     <==> h[o, Ncpr] == Max(h[o, Ndpr], MaxMSet(h[o, Npr]))
       && h[o, Ncpr] >= 0
       && h[o, Ndpr] >= 0
       && (forall i: int :: i > 0 ==> h[o, Npr][i] == Card(FBP(h, BBSet(h, o), i))));

function InvPrSt(h: THeap, o: ref, from: int, to: int) : bool;

axiom (forall h: THeap, o: ref, from: int, to: int :: 
  InvPrSt(h, o, from, to)
     <==> (forall i: int :: 
        i > 0 && i != from && i != to ==> h[o, Npr][i] == Card(FBP(h, BBSet(h, o), i)))
       && (from > 0 ==> h[o, Npr][from] == Card(FBP(h, BBSet(h, o), from)) + 1)
       && (to > 0 ==> h[o, Npr][to] == Card(FBP(h, BBSet(h, o), to)) - 1)
       && h[o, Ncpr] >= 0
       && h[o, Ndpr] >= 0);

axiom (forall h: THeap, hOld: THeap, this: ref :: 
  InvPr(hOld, this)
       && Equal(BBSet(h, this), BBSet(hOld, this))
       && h[this, Npr] == hOld[this, Npr]
       && h[this, Ndpr] == hOld[this, Ndpr]
       && h[this, Ncpr] == hOld[this, Ncpr]
       && (forall o: ref :: BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
     ==> InvPr(h, this));

axiom (forall h: THeap, hOld: THeap, this: ref :: 
  InvPr(hOld, this)
       && h[this, NC] == hOld[this, NC]
       && h[this, Lp] == hOld[this, Lp]
       && h[this, Le] == hOld[this, Le]
       && h[this, NSt] == hOld[this, NSt]
       && h[this, Npr] == hOld[this, Npr]
       && h[this, Ndpr] == hOld[this, Ndpr]
       && h[this, Ncpr] == hOld[this, Ncpr]
       && (forall o: ref :: BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
     ==> InvPr(h, this));

axiom (forall h: THeap, hOld: THeap, this: ref, child: ref, newNcpr: int :: 
  InvPr(hOld, this)
       && BBSet(hOld, this)[child]
       && newNcpr >= 0
       && child != null
       && hOld[child, Ncpr] != newNcpr
       && h[child, Ncpr] == newNcpr
       && (forall<a> o: ref, f: field a :: 
        h[o, f] == hOld[o, f] || (o == child && f == Ncpr))
     ==> InvPrSt(h, this, hOld[child, Ncpr], newNcpr));

axiom (forall h: THeap, hOld: THeap, this: ref, child: ref :: 
  InvPr(hOld, this)
       && BBSet(hOld, this)[child]
       && child != null
       && Equal(BBSet(h, this), RemEl(BBSet(hOld, this), child))
       && h[this, Npr] == hOld[this, Npr]
       && h[this, Ndpr] == hOld[this, Ndpr]
       && h[this, Ncpr] == hOld[this, Ncpr]
       && (forall o: ref :: BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
     ==> InvPrSt(h, this, hOld[child, Ncpr], 0)
       && (hOld[child, Ncpr] == 0 ==> InvPr(h, this)));

axiom (forall h: THeap, hOld: THeap, this: ref, child: ref :: 
  InvPr(hOld, this)
       && !BBSet(hOld, this)[child]
       && child != null
       && Equal(BBSet(h, this), AddEl(BBSet(hOld, this), child))
       && h[this, Npr] == hOld[this, Npr]
       && h[this, Ndpr] == hOld[this, Ndpr]
       && h[this, Ncpr] == hOld[this, Ncpr]
       && (forall o: ref :: BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
     ==> InvPrSt(h, this, 0, hOld[child, Ncpr])
       && (hOld[child, Ncpr] == 0 ==> InvPr(h, this)));

axiom (forall h: THeap, hOld: THeap, from: int, to: int, this: ref :: 
  InvPrSt(hOld, this, from, to)
       && Equal(BBSet(h, this), BBSet(hOld, this))
       && h[this, Npr] == hOld[this, Npr]
       && h[this, Ndpr] == hOld[this, Ndpr]
       && h[this, Ncpr] == hOld[this, Ncpr]
       && (forall o: ref :: BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
     ==> InvPrSt(h, this, from, to));

axiom (forall h: THeap, hOld: THeap, from: int, to: int, this: ref :: 
  InvPrSt(hOld, this, from, to)
       && Equal(BBSet(h, this), BBSet(hOld, this))
       && (from <= 0 ==> h[this, Npr] == hOld[this, Npr])
       && (from > 0 ==> h[this, Npr] == RemoveMSet(hOld[this, Npr], from))
       && h[this, Ndpr] == hOld[this, Ndpr]
       && h[this, Ncpr] == hOld[this, Ncpr]
       && (forall o: ref :: BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
     ==> InvPrSt(h, this, 0, to));

axiom (forall h: THeap, hOld: THeap, from: int, to: int, this: ref :: 
  InvPrSt(hOld, this, from, to)
       && Equal(BBSet(h, this), BBSet(hOld, this))
       && (to <= 0 ==> h[this, Npr] == hOld[this, Npr])
       && (to > 0 ==> h[this, Npr] == AddMSet(hOld[this, Npr], to))
       && h[this, Ndpr] == hOld[this, Ndpr]
       && h[this, Ncpr] == hOld[this, Ncpr]
       && (forall o: ref :: BBSet(h, this)[o] ==> h[o, Ncpr] == hOld[o, Ncpr])
     ==> InvPrSt(h, this, from, 0));

axiom (forall h: THeap, hOld: THeap, this: ref :: 
  InvPrSt(hOld, this, 0, 0)
       && !BBSet(hOld, this)[this]
       && h[this, Ncpr] == Max(hOld[this, Ndpr], MaxMSet(hOld[this, Npr]))
       && (forall<a> o: ref, f: field a :: 
        h[o, f] == hOld[o, f] || (o == this && f == Ncpr))
     ==> InvPr(h, this));

procedure Node..ctor(this: ref, priority: int, NotAllocated: TRegion);
  requires priority >= 0;
  requires this != null;
  requires NotAllocated[this];
  requires InvStructEx($Heap, NotAllocated);
  requires IsNotAllocated($Heap, this);
  modifies $Heap;
  ensures InvStructEx($Heap, Minus(NotAllocated, Singleton(this)));
  ensures IsEmptyTree($Heap, this);
  ensures $Heap[this, NSt] == StF;
  ensures InvPr($Heap, this);
  ensures (forall<a> o: ref, f: field a :: $Heap[o, f] == old($Heap[o, f]) || o == this);



implementation Node..ctor(this: ref, priority: int, NotAllocated: TRegion)
{
    call CreatEmptyTree(this, NotAllocated);
    call CreatEmptyList(this, NotAllocated);
    $Heap[this, Ndpr] := priority;
    $Heap[this, Ncpr] := priority;
    $Heap[this, Npr] := EmptyMSet;
    $Heap[this, Nbb] := null;
    $Heap[this, NSt] := StF;
    assert (forall i: int :: i > 0 ==> Equal(FBP($Heap, BBSet($Heap, this), i), Empty));
}



procedure Node..updatePriorities(this: ref, from: int, to: int);
  requires from >= 0;
  requires to >= 0;
  requires from != to;
  requires this != null;
  free requires this != $Heap[this, Nbb];
  requires InvStruct($Heap);
  requires InvPrSt($Heap, this, from, to);
  requires (forall o: ref :: NACCSet($Heap, this)[o] ==> InvPr($Heap, o));
  modifies $Heap;
  ensures InvStruct($Heap);
  ensures (forall o: ref :: NACCoSet($Heap, this)[o] ==> InvPr($Heap, o));
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (NACCoSet(old($Heap), this)[o] && (f == Npr || f == Ncpr)));



implementation Node..updatePriorities(this: ref, from: int, to: int)
{
  var oldPriority: int;

    oldPriority := $Heap[this, Ncpr];
    if (from > 0)
    {
        $Heap[this, Npr] := RemoveMSet($Heap[this, Npr], from);
    }

    assert InvPrSt($Heap, this, 0, to);
    if (to > 0)
    {
        $Heap[this, Npr] := AddMSet($Heap[this, Npr], to);
    }

    assert InvPrSt($Heap, this, 0, 0);
    $Heap[this, Ncpr] := Max($Heap[this, Ndpr], MaxMSet($Heap[this, Npr]));
    if ($Heap[this, Nbb] != null && $Heap[this, Ncpr] != oldPriority)
    {
        call Node..updatePriorities($Heap[this, Nbb], oldPriority, $Heap[this, Ncpr]);
    }
}



procedure Node..release(this: ref, r: ref);
  requires this != r;
  requires this != null;
  requires r != null;
  requires $Heap[this, NC][r];
  requires $Heap[this, NSt] == StF;
  requires InvStruct($Heap);
  requires InvPr($Heap, r);
  requires (forall o: ref :: NACCoSet($Heap, this)[o] ==> InvPr($Heap, o));
  modifies $Heap;
  ensures $Heap[r, Np] == null;
  ensures InvStruct($Heap);
  ensures $Heap[this, NSt] == StF;
  ensures $Heap[r, NSt] == StF;
  ensures (forall o: ref :: NACCoSet(old($Heap), this)[o] ==> InvPr($Heap, o));
  ensures InvPr($Heap, r);
  ensures (forall<a> o: ref, f: field a :: 
  $Heap[o, f] == old($Heap[o, f])
     || (NACCoSet(old($Heap), this)[o] && (f == Npr || f == Ncpr))
     || (o == r && f == Np)
     || (AddEl(old($Heap)[r, ND], r)[o] && f == Nt)
     || (o == this && f == NC)
     || (AddEl(old($Heap)[this, NA], this)[o] && f == ND)
     || (AddEl(old($Heap)[r, ND], r)[o] && f == NA)
     || (o == r && f == Nbb)
     || (o == r && f == NSt));
  ensures (forall o: ref :: o != this ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));



implementation Node..release(this: ref, r: ref)
{
    call RemoveSubTree(this, r);
    $Heap[r, Nbb] := null;
    $Heap[r, NSt] := StF;
    if ($Heap[r, Ncpr] != 0)
    {
        call Node..updatePriorities(this, $Heap[r, Ncpr], 0);
    }
}



procedure Node..acquire(this: ref, r: ref);
  requires this != r;
  requires this != null;
  requires r != null;
  requires $Heap[this, NSt] == StF;
  requires InvStruct($Heap);
  requires InvPr($Heap, this);
  requires (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));
  modifies $Heap;
  ensures InvStruct($Heap);
  ensures InvPr($Heap, this);
  ensures (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));
  ensures old($Heap)[r, NSt] == StF ==> $Heap[this, NSt] == StF;
  ensures old($Heap)[r, NSt] == StF ==> $Heap[r, NSt] == StL;
  ensures old($Heap)[r, NSt] == StF
   ==> (forall<a> o: ref, f: field a :: 
    $Heap[o, f] == old($Heap[o, f])
       || (NACCoSet(old($Heap), this)[o] && (f == Npr || f == Ncpr))
       || (o == r && f == Np)
       || (AddEl(old($Heap)[r, ND], r)[o] && f == Nt)
       || (o == this && f == NC)
       || (AddEl(old($Heap)[this, NA], this)[o] && f == ND)
       || (AddEl(old($Heap)[r, ND], r)[o] && f == NA)
       || (o == r && f == Nbb)
       || (o == r && f == NSt));
  ensures old($Heap)[r, NSt] == StF
   ==> (forall o: ref :: o != this ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));
  ensures old($Heap)[r, NSt] == StF ==> $Heap[r, Np] == this;
  ensures old($Heap)[r, NSt] == StF
   ==> (forall o: ref :: 
    AddEl($Heap[r, ND], r)[o] ==> $Heap[o, Nt] == old($Heap)[this, Nt]);
  ensures old($Heap)[r, NSt] == StF ==> $Heap[this, NC] == AddEl(old($Heap)[this, NC], r);
  ensures old($Heap)[r, NSt] == StF
   ==> (forall o: ref :: 
    AddEl($Heap[this, NA], this)[o]
       ==> $Heap[o, ND] == Union(old($Heap)[o, ND], AddEl($Heap[r, ND], r)));
  ensures old($Heap)[r, NSt] == StF
   ==> (forall o: ref :: 
    AddEl(old($Heap)[r, ND], r)[o]
       ==> $Heap[o, NA] == Union(old($Heap)[o, NA], AddEl($Heap[this, NA], this)));
  ensures old($Heap)[r, NSt] != StF && !old($Heap)[this, ND][r]
   ==> $Heap[this, NSt] == StL;
  ensures old($Heap)[r, NSt] != StF && !old($Heap)[this, ND][r]
   ==> $Heap[r, NSt] == old($Heap)[r, NSt];
  ensures old($Heap)[r, NSt] != StF && !old($Heap)[this, ND][r]
   ==> (forall<a> o: ref, f: field a :: 
    $Heap[o, f] == old($Heap[o, f])
       || (NACCoSet(old($Heap), r)[o] && (f == Npr || f == Ncpr))
       || (o == this && f == Np)
       || (AddEl(old($Heap)[this, ND], this)[o] && f == Nt)
       || (o == r && f == NC)
       || (AddEl(old($Heap)[r, NA], r)[o] && f == ND)
       || (AddEl(old($Heap)[this, ND], this)[o] && f == NA)
       || (o == this && f == Nbb)
       || (o == this && f == NSt));
  ensures old($Heap)[r, NSt] != StF && !old($Heap)[this, ND][r]
   ==> (forall o: ref :: o != r ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r] ==> InvStruct($Heap);
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: 
    { AddEl($Heap[r, NA], r)[o] } 
    AddEl($Heap[r, NA], r)[o] ==> $Heap[o, NSt] == StD);
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall<a> o: ref, f: field a :: 
    $Heap[o, f] == old($Heap)[o, f]
       || (NACCoSet(old($Heap), r)[o] && (f == Npr || f == Ncpr))
       || (AddEl(old($Heap)[r, NA], r)[o] && f == LL)
       || (AddEl(old($Heap)[r, NA], r)[o] && f == Lb)
       || (AddEl(old($Heap)[r, NA], r)[o] && f == Le)
       || (AddEl(old($Heap)[r, NA], r)[o] && f == Lp)
       || (AddEl(old($Heap)[r, NA], r)[o] && f == Ln)
       || (RemEl(AddEl(old($Heap)[r, NA], r), this)[o] && f == Np)
       || (AddEl(old($Heap)[$Heap[this, Lp], ND], $Heap[this, Lp])[o] && f == Nt)
       || (RemEl(AddEl(old($Heap)[r, NA], this), r)[o] && f == NC)
       || (RemEl(old($Heap)[r, NA], r)[o] && f == ND)
       || (AddEl(old($Heap)[$Heap[this, Lp], ND], $Heap[this, Lp])[o] && f == NA)
       || (o == this && f == Nbb)
       || ($Heap[this, LL][o] && f == NSt));
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: o != r ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r] ==> $Heap[this, Ln] == null;
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: 
    AddEl(old($Heap)[r, NA], r)[o]
       ==> Equal($Heap[o, LL], AddEl(old($Heap)[r, NA], r)));
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> $Heap[o, Lb] == r);
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> $Heap[o, Le] == this);
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: 
    RemEl(AddEl(old($Heap)[r, NA], r), this)[o]
       ==> old($Heap[o, Np]) == $Heap[o, Ln]);
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> $Heap[o, Np] == null);
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: 
    RemEl(AddEl(old($Heap)[r, NA], this), r)[o]
       ==> $Heap[o, NC] == RemEl(old($Heap)[o, NC], $Heap[o, Lp]));
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: 
    RemEl(AddEl(old($Heap)[r, NA], this), r)[o]
       ==> $Heap[o, ND]
         == Minus(old($Heap)[o, ND], AddEl(old($Heap)[$Heap[o, Lp], ND], $Heap[o, Lp])));
  ensures old($Heap)[r, NSt] != StF && old($Heap)[this, ND][r]
   ==> (forall o: ref :: AddEl(old($Heap)[r, NA], r)[o] ==> Equal($Heap[o, NA], Empty));



implementation Node..acquire(this: ref, r: ref)
{
    if ($Heap[r, NSt] == StF)
    {
        call AddSubTree(this, r);
        $Heap[r, Nbb] := this;
        $Heap[r, NSt] := StL;
        if ($Heap[r, Ncpr] != 0)
        {
            call Node..updatePriorities(this, 0, $Heap[r, Ncpr]);
        }
    }
    else
    {
        $Heap[this, Nbb] := r;
        if (!$Heap[this, ND][r])
        {
            call AddSubTree(r, this);
            $Heap[this, NSt] := StL;
        }
        else
        {
            call TreeToList(this, r);
            call assignToAllInSt($Heap[this, LL], NSt, StD);
        }

        assert (forall o: ref :: o != r ==> Equal(BBSet($Heap, o), BBSet(old($Heap), o)));
        assert InvStruct($Heap);
        if ($Heap[this, Ncpr] != 0)
        {
            call Node..updatePriorities(r, 0, $Heap[this, Ncpr]);
            assert InvPr($Heap, this);
            assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));
        }
        else
        {
            assert Equal(NACCSet($Heap, r), RemEl(Union($Heap[r, NA], $Heap[$Heap[r, Nt], LL]), r));
            assert Equal(NACCSet($Heap, r), NACCSet(old($Heap), r));
            assert (forall o: ref :: NACCoSet(old($Heap), r)[o] ==> InvPr(old($Heap), o));
            assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr(old($Heap), o));
            assert (forall o: ref :: 
  NACCoSet($Heap, r)[o]
     ==> (forall i: int :: 
      i > 0
         ==> old($Heap)[o, Npr][i] == Card(FBP(old($Heap), BBSet(old($Heap), o), i))));
            assert (forall o: ref :: 
  NACCoSet($Heap, r)[o]
     ==> (forall i: int :: 
      i > 0 ==> $Heap[o, Npr][i] == Card(FBP($Heap, BBSet($Heap, o), i))));
            assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));
        }

        assert (forall o: ref :: NACCoSet($Heap, r)[o] ==> InvPr($Heap, o));
    }
}



const unique r1: ref;

const unique r2: ref;

const unique p1: ref;

const unique p2: ref;

procedure main();
  requires r1 != null;
  requires IsNotAllocated($Heap, r1);
  requires r2 != null;
  requires IsNotAllocated($Heap, r2);
  requires p1 != null;
  requires IsNotAllocated($Heap, p1);
  requires p2 != null;
  requires IsNotAllocated($Heap, p2);
  requires InvStructEx($Heap, AddEl(AddEl(AddEl(Singleton(r1), r2), p1), p2));
  modifies $Heap;



implementation main()
{
    call main_create();
    call Node..acquire(p1, r2);
    assert $Heap[p1, NC][r2];
    call Node..acquire(p1, r1);
    assert InvStruct($Heap);
    assert InvPr($Heap, r1);
    assert InvPr($Heap, r2);
    assert InvPr($Heap, p1);
    assert InvPr($Heap, p2);
    assert $Heap[r1, NSt] == StL;
    assert $Heap[r2, NSt] == StL;
    assert $Heap[p1, NSt] == StF;
    assert $Heap[p2, NSt] == StF;
    assert $Heap[p1, NC][r1];
    assert $Heap[p1, NC][r2];
    call Node..release(p1, r2);
    assert InvStruct($Heap);
    assert InvPr($Heap, r1);
    assert InvPr($Heap, r2);
    assert InvPr($Heap, p1);
    assert InvPr($Heap, p2);
    assert $Heap[r1, NSt] == StL;
    assert $Heap[r2, NSt] == StF;
    assert $Heap[p1, NSt] == StF;
    assert $Heap[p2, NSt] == StF;
    assert $Heap[p1, NC][r1];
    assert !$Heap[p1, NC][r2];
    call Node..acquire(p2, r2);
    assert InvStruct($Heap);
    assert InvPr($Heap, r1);
    assert InvPr($Heap, r2);
    assert InvPr($Heap, p1);
    assert InvPr($Heap, p2);
    assert $Heap[r1, NSt] == StL;
    assert $Heap[r2, NSt] == StL;
    assert $Heap[p1, NSt] == StF;
    assert $Heap[p2, NSt] == StF;
    assert $Heap[p1, NC][r1];
    assert $Heap[p2, NC][r2];
    call Node..acquire(p1, r2);
    assert InvStruct($Heap);
    assert InvPr($Heap, r1);
    assert InvPr($Heap, r2);
    assert InvPr($Heap, p1);
    assert InvPr($Heap, p2);
    assert $Heap[r1, NSt] == StL;
    assert $Heap[r2, NSt] == StL;
    assert $Heap[p1, NSt] == StL;
    assert $Heap[p2, NSt] == StF;
    assert $Heap[r2, NC][p1];
    assert $Heap[p1, NC][r1];
    assert $Heap[p2, NC][r2];
    call Node..acquire(p2, r1);
    assert InvStruct($Heap);
    assert InvPr($Heap, r1);
    assert InvPr($Heap, r2);
    assert InvPr($Heap, p1);
    assert InvPr($Heap, p2);
    assert $Heap[r1, NSt] == StD;
    assert $Heap[r2, NSt] == StD;
    assert $Heap[p1, NSt] == StD;
    assert $Heap[p2, NSt] == StD;
    assert CLp($Heap, r2) == p1;
    assert CLp($Heap, p1) == r1;
    assert CLp($Heap, r1) == p2;
    assert CLp($Heap, p2) == r2;
}



procedure main_create();
  requires r1 != null;
  requires IsNotAllocated($Heap, r1);
  requires r2 != null;
  requires IsNotAllocated($Heap, r2);
  requires p1 != null;
  requires IsNotAllocated($Heap, p1);
  requires p2 != null;
  requires IsNotAllocated($Heap, p2);
  requires InvStructEx($Heap, AddEl(AddEl(AddEl(Singleton(r1), r2), p1), p2));
  modifies $Heap;
  ensures InvStruct($Heap);
  ensures InvPr($Heap, r1);
  ensures InvPr($Heap, r2);
  ensures InvPr($Heap, p1);
  ensures InvPr($Heap, p2);
  ensures $Heap[r1, NSt] == StF;
  ensures $Heap[r2, NSt] == StF;
  ensures $Heap[p1, NSt] == StF;
  ensures $Heap[p2, NSt] == StF;



implementation main_create()
{
  var Reg1: TRegion;
  var Reg2: TRegion;
  var Reg3: TRegion;
  var Reg4: TRegion;

    Reg4 := Singleton(p2);
    Reg3 := AddEl(Reg4, p1);
    Reg2 := AddEl(Reg3, r2);
    Reg1 := AddEl(Reg2, r1);
    assert InvStructEx($Heap, Reg1);
    call Node..ctor(r1, 0, Reg1);
    assert InvStructEx($Heap, Reg2);
    assert InvPr($Heap, r1);
    call Node..ctor(r2, 0, Reg2);
    assert InvStructEx($Heap, Reg3);
    assert InvPr($Heap, r2);
    call Node..ctor(p1, 2, Reg3);
    assert InvStructEx($Heap, Reg4);
    assert InvPr($Heap, p1);
    call Node..ctor(p2, 1, Reg4);
}


