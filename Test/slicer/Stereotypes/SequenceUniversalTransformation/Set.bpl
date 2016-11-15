type Set T = [T]bool;

function EmptySet<T>() returns (Set T);
axiom (forall <T> o: T :: !EmptySet()[o]);

function Singleton<T>(T) returns (Set T);
axiom (forall <T> o: T, o': T :: Singleton(o)[o'] <==> o == o');

function Union<T>(Set T, Set T) returns (Set T);
axiom (forall <T> a: Set T, b: Set T, o: T ::  Union(a,b)[o] <==> a[o] || b[o]);
//axiom (forall<T> a: Set T, b: Set T, o: T :: { Union(a, b), a[o] } a[o] ==> Union(a, b)[o]);
//axiom (forall<T> a: Set T, b: Set T, o: T :: { Union(a, b), b[o] } b[o] ==> Union(a, b)[o]);


function Intersection<T>(Set T, Set T) returns (Set T);
axiom (forall <T> a: Set T, b: Set T, o: T :: Intersection(a,b)[o] <==> (a[o] && b[o]));
//axiom (forall <T> a: Set T, b: Set T, o: T :: {Intersection(a,b)[o]} Intersection(a,b)[o] ==> a[o]);
//axiom (forall <T> a: Set T, b: Set T, o: T :: {Intersection(a,b)[o]} Intersection(a,b)[o] ==> b[o]);

function Subset<T>(Set T, Set T) returns (bool);
axiom(forall <T> a: Set T, b: Set T :: Subset(a,b) <==> (forall o: T :: a[o] ==> b[o]));

function Equal<T>(Set T, Set T) returns (bool);
axiom(forall <T> a: Set T, b: Set T ::  Equal(a,b) <==> (forall o: T :: a[o] <==> b[o]));
axiom (forall <T> a,b: Set T:: Equal(a,b) <==> a == b);
//axiom (forall <T> a,b: Set T:: (Subset(a,b) && Subset(b,a)) ==> a == b);

function Disjoint<T>(Set T, Set T) returns (bool);
axiom (forall <T> a: Set T, b: Set T :: Disjoint(a,b) <==> (forall o: T :: !a[o] || !b[o]));
//axiom (forall <T> a: Set T, b: Set T, o: T :: {Disjoint(a,b), b[o]} (Disjoint(a,b) && b[o]) ==> !a[o]);
//axiom (forall <T> a: Set T, b: Set T, c: Set T:: {Disjoint(a,b), Subset(c,b)} (Disjoint(a,b) && Subset(c,b)) ==> Disjoint(a,c));

function AddEl<T>(Set T, T) returns (Set T);
axiom (forall <T> a:Set T, o:T, o':T :: AddEl(a,o)[o'] <==> (o == o' || a[o']));
//axiom (forall<T> a: Set T, o: T :: { AddEl(a, o) } AddEl(a, o)[o]);
//axiom (forall<T> a: Set T, o: T, o': T :: { AddEl(a, o), a[o'] } a[o'] ==> AddEl(a, o)[o']);

function RemEl<T>(Set T, T) returns (Set T);
axiom (forall <T> a:Set T, o:T, o':T :: RemEl(a,o)[o'] <==> (o != o' && a[o']));
//axiom (forall<T> a: Set T, o: T :: { RemEl(a, o) } !RemEl(a, o)[o]);

function Minus<T>(Set T, Set T) returns (Set T);
axiom (forall <T> a:Set T, b:Set T, o:T :: Minus(a,b)[o] <==> a[o] && !b[o]);
//axiom (forall<T> a: Set T, b: Set T, o: T :: { Minus(a, b), b[o] } b[o] ==> !Minus(a, b)[o]);

//function Card<T>(a: Set T) returns (int);
//axiom (Card(EmptySet()) == 0);
//axiom (forall <T> a:Set T, o:T :: !a[o] ==> Card(AddEl(a, o)) == Card(a) + 1);
//axiom (forall <T> a:Set T, o:T ::  a[o] ==> Card(RemEl(a, o)) == Card(a) - 1);
//axiom (forall <T> a:Set T, b:Set T :: Equal(a,b) ==> (Card(a)==Card(b)));