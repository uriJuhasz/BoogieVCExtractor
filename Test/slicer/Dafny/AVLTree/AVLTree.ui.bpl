// Boogie program verifier version 2.3.0.61016, Copyright (c) 2003-2014, Microsoft.
// Command Line Options: /trace /traceTimes /print:AVLTree.ui.bpl /printWithUniqueIds /noVerify AVLTree.bpl

const h1707556^^$$Language$Dafny: bool;

axiom NoDecl^^$$Language$Dafny;

type ref;

const h15368010^^null: ref;

type Set T = [T]bool;

function h4094363^^Set#Empty<T>() : Set T;

axiom (forall<T> h63208015^^o: T :: 
  { NoDecl^^Set#Empty()[NoDecl^^o] } 
  !NoDecl^^Set#Empty()[NoDecl^^o]);

function h32001227^^Set#Singleton<T>(T) : Set T;

axiom (forall<T> h19575591^^r: T :: 
  { NoDecl^^Set#Singleton(NoDecl^^r) } 
  NoDecl^^Set#Singleton(NoDecl^^r)[NoDecl^^r]);

axiom (forall<T> h41962596^^r: T, h42119052^^o: T :: 
  { NoDecl^^Set#Singleton(NoDecl^^r)[NoDecl^^o] } 
  NoDecl^^Set#Singleton(NoDecl^^r)[NoDecl^^o] <==> NoDecl^^r == NoDecl^^o);

function h43527150^^Set#UnionOne<T>(Set T, T) : Set T;

axiom (forall<T> h56200037^^a: Set T, h36038289^^x: T, h55909147^^o: T :: 
  { NoDecl^^Set#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^o] } 
  NoDecl^^Set#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^o]
     <==> NoDecl^^o == NoDecl^^x || NoDecl^^a[NoDecl^^o]);

axiom (forall<T> h33420276^^a: Set T, h32347029^^x: T :: 
  { NoDecl^^Set#UnionOne(NoDecl^^a, NoDecl^^x) } 
  NoDecl^^Set#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^x]);

axiom (forall<T> h22687807^^a: Set T, h2863675^^x: T, h25773083^^y: T :: 
  { NoDecl^^Set#UnionOne(NoDecl^^a, NoDecl^^x), NoDecl^^a[NoDecl^^y] } 
  NoDecl^^a[NoDecl^^y] ==> NoDecl^^Set#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^y]);

function h30631159^^Set#Union<T>(Set T, Set T) : Set T;

axiom (forall<T> h7244975^^a: Set T, h65204782^^b: Set T, h49972132^^o: T :: 
  { NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^o] } 
  NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^o]
     <==> NoDecl^^a[NoDecl^^o] || NoDecl^^b[NoDecl^^o]);

axiom (forall<T> h47096010^^a: Set T, h21210914^^b: Set T, h56680499^^y: T :: 
  { NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b), NoDecl^^a[NoDecl^^y] } 
  NoDecl^^a[NoDecl^^y] ==> NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^y]);

axiom (forall<T> h40362448^^a: Set T, h27717712^^b: Set T, h48132822^^y: T :: 
  { NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b), NoDecl^^b[NoDecl^^y] } 
  NoDecl^^b[NoDecl^^y] ==> NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^y]);

axiom (forall<T> h30542218^^a: Set T, h6444509^^b: Set T :: 
  { NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^Set#Disjoint(NoDecl^^a, NoDecl^^b)
     ==> NoDecl^^Set#Difference(NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b), NoDecl^^a)
         == NoDecl^^b
       && NoDecl^^Set#Difference(NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b), NoDecl^^b)
         == NoDecl^^a);

function h58000584^^Set#Intersection<T>(Set T, Set T) : Set T;

axiom (forall<T> h52243212^^a: Set T, h426867^^b: Set T, h3841804^^o: T :: 
  { NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b)[NoDecl^^o] } 
  NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b)[NoDecl^^o]
     <==> NoDecl^^a[NoDecl^^o] && NoDecl^^b[NoDecl^^o]);

axiom (forall<T> h34576242^^a: Set T, h42750725^^b: Set T :: 
  { NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b), NoDecl^^b) } 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b), NoDecl^^b)
     == NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b));

axiom (forall<T> h49212206^^a: Set T, h40256670^^b: Set T :: 
  { NoDecl^^Set#Union(NoDecl^^a, NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b)) } 
  NoDecl^^Set#Union(NoDecl^^a, NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b))
     == NoDecl^^Set#Union(NoDecl^^a, NoDecl^^b));

axiom (forall<T> h26765710^^a: Set T, h39564799^^b: Set T :: 
  { NoDecl^^Set#Intersection(NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b), NoDecl^^b) } 
  NoDecl^^Set#Intersection(NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b), NoDecl^^b)
     == NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b));

axiom (forall<T> h20538874^^a: Set T, h50632145^^b: Set T :: 
  { NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b)) } 
  NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b))
     == NoDecl^^Set#Intersection(NoDecl^^a, NoDecl^^b));

function h53036123^^Set#Difference<T>(Set T, Set T) : Set T;

axiom (forall<T> h7563067^^a: Set T, h958745^^b: Set T, h8628710^^o: T :: 
  { NoDecl^^Set#Difference(NoDecl^^a, NoDecl^^b)[NoDecl^^o] } 
  NoDecl^^Set#Difference(NoDecl^^a, NoDecl^^b)[NoDecl^^o]
     <==> NoDecl^^a[NoDecl^^o] && !NoDecl^^b[NoDecl^^o]);

axiom (forall<T> h10549531^^a: Set T, h27836922^^b: Set T, h49205706^^y: T :: 
  { NoDecl^^Set#Difference(NoDecl^^a, NoDecl^^b), NoDecl^^b[NoDecl^^y] } 
  NoDecl^^b[NoDecl^^y]
     ==> !NoDecl^^Set#Difference(NoDecl^^a, NoDecl^^b)[NoDecl^^y]);

function h40198173^^Set#Subset<T>(Set T, Set T) : bool;

axiom (forall<T> h26239245^^a: Set T, h34826618^^b: Set T :: 
  { NoDecl^^Set#Subset(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^Set#Subset(NoDecl^^a, NoDecl^^b)
     <==> (forall h45004109^^o: T :: 
      { NoDecl^^a[NoDecl^^o] } { NoDecl^^b[NoDecl^^o] } 
      NoDecl^^a[NoDecl^^o] ==> NoDecl^^b[NoDecl^^o]));

function h2383799^^Set#Equal<T>(Set T, Set T) : bool;

axiom (forall<T> h21454193^^a: Set T, h58870012^^b: Set T :: 
  { NoDecl^^Set#Equal(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^Set#Equal(NoDecl^^a, NoDecl^^b)
     <==> (forall h60068066^^o: T :: 
      { NoDecl^^a[NoDecl^^o] } { NoDecl^^b[NoDecl^^o] } 
      NoDecl^^a[NoDecl^^o] <==> NoDecl^^b[NoDecl^^o]));

axiom (forall<T> h3741682^^a: Set T, h33675143^^b: Set T :: 
  { NoDecl^^Set#Equal(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^Set#Equal(NoDecl^^a, NoDecl^^b) ==> NoDecl^^a == NoDecl^^b);

function h34640832^^Set#Disjoint<T>(Set T, Set T) : bool;

axiom (forall<T> h43332040^^a: Set T, h54444047^^b: Set T :: 
  { NoDecl^^Set#Disjoint(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^Set#Disjoint(NoDecl^^a, NoDecl^^b)
     <==> (forall h20234383^^o: T :: 
      { NoDecl^^a[NoDecl^^o] } { NoDecl^^b[NoDecl^^o] } 
      !NoDecl^^a[NoDecl^^o] || !NoDecl^^b[NoDecl^^o]));

function h47891719^^Set#Choose<T>(Set T, TickType) : T;

axiom (forall<T> h28372289^^a: Set T, h54024015^^tick: TickType :: 
  { NoDecl^^Set#Choose(NoDecl^^a, NoDecl^^tick) } 
  NoDecl^^a != NoDecl^^Set#Empty()
     ==> NoDecl^^a[NoDecl^^Set#Choose(NoDecl^^a, NoDecl^^tick)]);

function h16454088^^Math#min(h13869071^^a: int, h57712780^^b: int) : int;

axiom (forall h49652976^^a: int, h44223604^^b: int :: 
  { NoDecl^^Math#min(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^a <= NoDecl^^b <==> NoDecl^^Math#min(NoDecl^^a, NoDecl^^b) == NoDecl^^a);

axiom (forall h62468121^^a: int, h25342185^^b: int :: 
  { NoDecl^^Math#min(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^b <= NoDecl^^a <==> NoDecl^^Math#min(NoDecl^^a, NoDecl^^b) == NoDecl^^b);

axiom (forall h26753075^^a: int, h39451090^^b: int :: 
  { NoDecl^^Math#min(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^Math#min(NoDecl^^a, NoDecl^^b) == NoDecl^^a
     || NoDecl^^Math#min(NoDecl^^a, NoDecl^^b) == NoDecl^^b);

function h19515494^^Math#clip(h41421720^^a: int) : int;

axiom (forall h37251161^^a: int :: 
  { NoDecl^^Math#clip(NoDecl^^a) } 
  0 <= NoDecl^^a ==> NoDecl^^Math#clip(NoDecl^^a) == NoDecl^^a);

axiom (forall h66824994^^a: int :: 
  { NoDecl^^Math#clip(NoDecl^^a) } 
  NoDecl^^a < 0 ==> NoDecl^^Math#clip(NoDecl^^a) == 0);

type MultiSet T = [T]int;

function h64554036^^$IsGoodMultiSet<T>(h44115416^^ms: MultiSet T) : bool;

axiom (forall<T> h61494432^^ms: MultiSet T :: 
  { NoDecl^^$IsGoodMultiSet(NoDecl^^ms) } 
  NoDecl^^$IsGoodMultiSet(NoDecl^^ms)
     <==> (forall h16578980^^o: T :: { NoDecl^^ms[NoDecl^^o] } 0 <= NoDecl^^ms[NoDecl^^o]));

function h14993092^^MultiSet#Empty<T>() : MultiSet T;

axiom (forall<T> h720107^^o: T :: 
  { NoDecl^^MultiSet#Empty()[NoDecl^^o] } 
  NoDecl^^MultiSet#Empty()[NoDecl^^o] == 0);

function h6480969^^MultiSet#Singleton<T>(T) : MultiSet T;

axiom (forall<T> h58328727^^r: T :: 
  { NoDecl^^MultiSet#Singleton(NoDecl^^r) } 
  NoDecl^^MultiSet#Singleton(NoDecl^^r)[NoDecl^^r] == 1);

axiom (forall<T> h55196503^^r: T, h27006480^^o: T :: 
  { NoDecl^^MultiSet#Singleton(NoDecl^^r)[NoDecl^^o] } 
  (NoDecl^^MultiSet#Singleton(NoDecl^^r)[NoDecl^^o] == 1
       <==> NoDecl^^r == NoDecl^^o)
     && (NoDecl^^MultiSet#Singleton(NoDecl^^r)[NoDecl^^o] == 0
       <==> NoDecl^^r != NoDecl^^o));

function h41731733^^MultiSet#UnionOne<T>(MultiSet T, T) : MultiSet T;

axiom (forall<T> h40041277^^a: MultiSet T, h24827179^^x: T, h22118023^^o: T :: 
  { NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^o] } 
  0 < NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^o]
     <==> NoDecl^^o == NoDecl^^x || 0 < NoDecl^^a[NoDecl^^o]);

axiom (forall<T> h64844482^^a: MultiSet T, h46729429^^x: T :: 
  { NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x) } 
  NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^x]
     == NoDecl^^a[NoDecl^^x] + 1);

axiom (forall<T> h17911681^^a: MultiSet T, h26987408^^x: T, h41560081^^y: T :: 
  { NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x), NoDecl^^a[NoDecl^^y] } 
  0 < NoDecl^^a[NoDecl^^y]
     ==> 0 < NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^y]);

axiom (forall<T> h38496415^^a: MultiSet T, h10923418^^x: T, h31201899^^y: T :: 
  { NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x), NoDecl^^a[NoDecl^^y] } 
  NoDecl^^x != NoDecl^^y
     ==> NoDecl^^a[NoDecl^^y]
       == NoDecl^^MultiSet#UnionOne(NoDecl^^a, NoDecl^^x)[NoDecl^^y]);

function h12381635^^MultiSet#Union<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> h44325851^^a: MultiSet T, h63388340^^b: MultiSet T, h33624151^^o: T :: 
  { NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^o] } 
  NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^o]
     == NoDecl^^a[NoDecl^^o] + NoDecl^^b[NoDecl^^o]);

axiom (forall<T> h34181910^^a: MultiSet T, h39201736^^b: MultiSet T, h17271312^^y: T :: 
  { NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b), NoDecl^^a[NoDecl^^y] } 
  0 < NoDecl^^a[NoDecl^^y]
     ==> 0 < NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^y]);

axiom (forall<T> h21224086^^a: MultiSet T, h56799051^^b: MultiSet T, h41429416^^y: T :: 
  { NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b), NoDecl^^b[NoDecl^^y] } 
  0 < NoDecl^^b[NoDecl^^y]
     ==> 0 < NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b)[NoDecl^^y]);

axiom (forall<T> h37320431^^a: MultiSet T, h339559^^b: MultiSet T :: 
  { NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^MultiSet#Difference(NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b), NoDecl^^a)
       == NoDecl^^b
     && NoDecl^^MultiSet#Difference(NoDecl^^MultiSet#Union(NoDecl^^a, NoDecl^^b), NoDecl^^b)
       == NoDecl^^a);

function h3056034^^MultiSet#Intersection<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> h27504314^^a: MultiSet T, h46212239^^b: MultiSet T, h13256970^^o: T :: 
  { NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b)[NoDecl^^o] } 
  NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b)[NoDecl^^o]
     == NoDecl^^Math#min(NoDecl^^a[NoDecl^^o], NoDecl^^b[NoDecl^^o]));

axiom (forall<T> h52203868^^a: MultiSet T, h72766^^b: MultiSet T :: 
  { NoDecl^^MultiSet#Intersection(NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b), NoDecl^^b) } 
  NoDecl^^MultiSet#Intersection(NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b), NoDecl^^b)
     == NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b));

axiom (forall<T> h654897^^a: MultiSet T, h5894079^^b: MultiSet T :: 
  { NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b)) } 
  NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b))
     == NoDecl^^MultiSet#Intersection(NoDecl^^a, NoDecl^^b));

function h53046711^^MultiSet#Difference<T>(MultiSet T, MultiSet T) : MultiSet T;

axiom (forall<T> h7658356^^a: MultiSet T, h1816341^^b: MultiSet T, h16347077^^o: T :: 
  { NoDecl^^MultiSet#Difference(NoDecl^^a, NoDecl^^b)[NoDecl^^o] } 
  NoDecl^^MultiSet#Difference(NoDecl^^a, NoDecl^^b)[NoDecl^^o]
     == NoDecl^^Math#clip(NoDecl^^a[NoDecl^^o] - NoDecl^^b[NoDecl^^o]));

axiom (forall<T> h12905972^^a: MultiSet T, h49044892^^b: MultiSet T, h38750844^^y: T :: 
  { NoDecl^^MultiSet#Difference(NoDecl^^a, NoDecl^^b), NoDecl^^b[NoDecl^^y], NoDecl^^a[NoDecl^^y] } 
  NoDecl^^a[NoDecl^^y] <= NoDecl^^b[NoDecl^^y]
     ==> NoDecl^^MultiSet#Difference(NoDecl^^a, NoDecl^^b)[NoDecl^^y] == 0);

function h13213278^^MultiSet#Subset<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> h51810644^^a: MultiSet T, h63642613^^b: MultiSet T :: 
  { NoDecl^^MultiSet#Subset(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^MultiSet#Subset(NoDecl^^a, NoDecl^^b)
     <==> (forall h35912612^^o: T :: 
      { NoDecl^^a[NoDecl^^o] } { NoDecl^^b[NoDecl^^o] } 
      NoDecl^^a[NoDecl^^o] <= NoDecl^^b[NoDecl^^o]));

function h54778057^^MultiSet#Equal<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> h23240469^^a: MultiSet T, h7837633^^b: MultiSet T :: 
  { NoDecl^^MultiSet#Equal(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^MultiSet#Equal(NoDecl^^a, NoDecl^^b)
     <==> (forall h3429838^^o: T :: 
      { NoDecl^^a[NoDecl^^o] } { NoDecl^^b[NoDecl^^o] } 
      NoDecl^^a[NoDecl^^o] == NoDecl^^b[NoDecl^^o]));

axiom (forall<T> h30868550^^a: MultiSet T, h9381496^^b: MultiSet T :: 
  { NoDecl^^MultiSet#Equal(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^MultiSet#Equal(NoDecl^^a, NoDecl^^b) ==> NoDecl^^a == NoDecl^^b);

function h17324607^^MultiSet#Disjoint<T>(MultiSet T, MultiSet T) : bool;

axiom (forall<T> h21703739^^a: MultiSet T, h61115925^^b: MultiSet T :: 
  { NoDecl^^MultiSet#Disjoint(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^MultiSet#Disjoint(NoDecl^^a, NoDecl^^b)
     <==> (forall h13172414^^o: T :: 
      { NoDecl^^a[NoDecl^^o] } { NoDecl^^b[NoDecl^^o] } 
      NoDecl^^a[NoDecl^^o] == 0 || NoDecl^^b[NoDecl^^o] == 0));

function h51442863^^MultiSet#FromSet<T>(Set T) : MultiSet T;

axiom (forall<T> h60332585^^s: Set T, h6122357^^a: T :: 
  { NoDecl^^MultiSet#FromSet(NoDecl^^s)[NoDecl^^a] } 
  (NoDecl^^MultiSet#FromSet(NoDecl^^s)[NoDecl^^a] == 0 <==> !NoDecl^^s[NoDecl^^a])
     && (NoDecl^^MultiSet#FromSet(NoDecl^^s)[NoDecl^^a] == 1 <==> NoDecl^^s[NoDecl^^a]));

function h55101221^^MultiSet#FromSeq<T>(Seq T) : MultiSet T;

type Seq _;

function h26148945^^Seq#Length<T>(Seq T) : int;

axiom (forall<T> h34013913^^s: Seq T :: 
  { NoDecl^^Seq#Length(NoDecl^^s) } 
  0 <= NoDecl^^Seq#Length(NoDecl^^s));

function h37689768^^Seq#Empty<T>() : Seq T;

axiom (forall<T>  :: NoDecl^^Seq#Length(NoDecl^^Seq#Empty(): Seq T) == 0);

axiom (forall<T> h3663598^^s: Seq T :: 
  { NoDecl^^Seq#Length(NoDecl^^s) } 
  NoDecl^^Seq#Length(NoDecl^^s) == 0 ==> NoDecl^^s == NoDecl^^Seq#Empty());

function h32972388^^Seq#Singleton<T>(T) : Seq T;

axiom (forall<T> h28316044^^t: T :: 
  { NoDecl^^Seq#Length(NoDecl^^Seq#Singleton(NoDecl^^t)) } 
  NoDecl^^Seq#Length(NoDecl^^Seq#Singleton(NoDecl^^t)) == 1);

function h53517805^^Seq#Build<T>(h11898202^^s: Seq T, 
    h39974954^^index: int, 
    h24230272^^val: T, 
    h16745860^^newLength: int)
   : Seq T;

axiom (forall<T> h16495015^^s: Seq T, h14237410^^i: int, h61027830^^v: T, h12379565^^len: int :: 
  { NoDecl^^Seq#Length(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i, NoDecl^^v, NoDecl^^len)) } 
  0 <= NoDecl^^len
     ==> NoDecl^^Seq#Length(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i, NoDecl^^v, NoDecl^^len))
       == NoDecl^^len);

function h44307222^^Seq#Append<T>(Seq T, Seq T) : Seq T;

axiom (forall<T> h63220684^^s0: Seq T, h32115247^^s1: Seq T :: 
  { NoDecl^^Seq#Length(NoDecl^^Seq#Append(NoDecl^^s0, NoDecl^^s1)) } 
  NoDecl^^Seq#Length(NoDecl^^Seq#Append(NoDecl^^s0, NoDecl^^s1))
     == NoDecl^^Seq#Length(NoDecl^^s0) + NoDecl^^Seq#Length(NoDecl^^s1));

function h20601768^^Seq#Index<T>(Seq T, int) : T;

axiom (forall<T> h51198184^^t: T :: 
  { NoDecl^^Seq#Index(NoDecl^^Seq#Singleton(NoDecl^^t), 0) } 
  NoDecl^^Seq#Index(NoDecl^^Seq#Singleton(NoDecl^^t), 0) == NoDecl^^t);

axiom (forall<T> h58130472^^s0: Seq T, h53412201^^s1: Seq T, h10947764^^n: int :: 
  { NoDecl^^Seq#Index(NoDecl^^Seq#Append(NoDecl^^s0, NoDecl^^s1), NoDecl^^n) } 
  (NoDecl^^n < NoDecl^^Seq#Length(NoDecl^^s0)
       ==> NoDecl^^Seq#Index(NoDecl^^Seq#Append(NoDecl^^s0, NoDecl^^s1), NoDecl^^n)
         == NoDecl^^Seq#Index(NoDecl^^s0, NoDecl^^n))
     && (NoDecl^^Seq#Length(NoDecl^^s0) <= NoDecl^^n
       ==> NoDecl^^Seq#Index(NoDecl^^Seq#Append(NoDecl^^s0, NoDecl^^s1), NoDecl^^n)
         == NoDecl^^Seq#Index(NoDecl^^s1, NoDecl^^n - NoDecl^^Seq#Length(NoDecl^^s0))));

axiom (forall<T> h31421019^^s: Seq T, 
    h14353717^^i: int, 
    h62074597^^v: T, 
    h21800467^^len: int, 
    h61986480^^n: int :: 
  { NoDecl^^Seq#Index(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i, NoDecl^^v, NoDecl^^len), NoDecl^^n) } 
  0 <= NoDecl^^n && NoDecl^^n < NoDecl^^len
     ==> (NoDecl^^i == NoDecl^^n
         ==> NoDecl^^Seq#Index(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i, NoDecl^^v, NoDecl^^len), NoDecl^^n)
           == NoDecl^^v)
       && (NoDecl^^i != NoDecl^^n
         ==> NoDecl^^Seq#Index(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i, NoDecl^^v, NoDecl^^len), NoDecl^^n)
           == NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^n)));

function h21007413^^Seq#Update<T>(Seq T, int, T) : Seq T;

axiom (forall<T> h54848996^^s: Seq T, h23878916^^i: int, h13583655^^v: T :: 
  { NoDecl^^Seq#Length(NoDecl^^Seq#Update(NoDecl^^s, NoDecl^^i, NoDecl^^v)) } 
  0 <= NoDecl^^i && NoDecl^^i < NoDecl^^Seq#Length(NoDecl^^s)
     ==> NoDecl^^Seq#Length(NoDecl^^Seq#Update(NoDecl^^s, NoDecl^^i, NoDecl^^v))
       == NoDecl^^Seq#Length(NoDecl^^s));

axiom (forall<T> h55144039^^s: Seq T, h26534308^^i: int, h37482183^^v: T, h1795329^^n: int :: 
  { NoDecl^^Seq#Index(NoDecl^^Seq#Update(NoDecl^^s, NoDecl^^i, NoDecl^^v), NoDecl^^n) } 
  0 <= NoDecl^^n && NoDecl^^n < NoDecl^^Seq#Length(NoDecl^^s)
     ==> (NoDecl^^i == NoDecl^^n
         ==> NoDecl^^Seq#Index(NoDecl^^Seq#Update(NoDecl^^s, NoDecl^^i, NoDecl^^v), NoDecl^^n)
           == NoDecl^^v)
       && (NoDecl^^i != NoDecl^^n
         ==> NoDecl^^Seq#Index(NoDecl^^Seq#Update(NoDecl^^s, NoDecl^^i, NoDecl^^v), NoDecl^^n)
           == NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^n)));

function h16157963^^Seq#Contains<T>(Seq T, T) : bool;

axiom (forall<T> h11203942^^s: Seq T, h33726620^^x: T :: 
  { NoDecl^^Seq#Contains(NoDecl^^s, NoDecl^^x) } 
  NoDecl^^Seq#Contains(NoDecl^^s, NoDecl^^x)
     <==> (exists h35104124^^i: int :: 
      { NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^i) } 
      0 <= NoDecl^^i
         && NoDecl^^i < NoDecl^^Seq#Length(NoDecl^^s)
         && NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^i) == NoDecl^^x));

axiom (forall h47501665^^x: ref :: 
  { NoDecl^^Seq#Contains(NoDecl^^Seq#Empty(), NoDecl^^x) } 
  !NoDecl^^Seq#Contains(NoDecl^^Seq#Empty(), NoDecl^^x));

axiom (forall<T> h24861802^^s0: Seq T, h22429634^^s1: Seq T, h540121^^x: T :: 
  { NoDecl^^Seq#Contains(NoDecl^^Seq#Append(NoDecl^^s0, NoDecl^^s1), NoDecl^^x) } 
  NoDecl^^Seq#Contains(NoDecl^^Seq#Append(NoDecl^^s0, NoDecl^^s1), NoDecl^^x)
     <==> NoDecl^^Seq#Contains(NoDecl^^s0, NoDecl^^x)
       || NoDecl^^Seq#Contains(NoDecl^^s1, NoDecl^^x));

axiom (forall<T> h4861097^^i: int, h43749873^^v: T, h58204539^^len: int, h54078809^^x: T :: 
  { NoDecl^^Seq#Contains(NoDecl^^Seq#Build(NoDecl^^Seq#Empty(), NoDecl^^i, NoDecl^^v, NoDecl^^len), 
      NoDecl^^x) } 
  0 <= NoDecl^^i && NoDecl^^i < NoDecl^^len
     ==> (NoDecl^^Seq#Contains(NoDecl^^Seq#Build(NoDecl^^Seq#Empty(), NoDecl^^i, NoDecl^^v, NoDecl^^len), 
        NoDecl^^x)
       <==> NoDecl^^x == NoDecl^^v));

axiom (forall<T> h16947234^^s: Seq T, 
    h18307385^^i0: int, 
    h30548742^^v0: T, 
    h6503226^^len0: int, 
    h58529038^^i1: int, 
    h56999299^^v1: T, 
    h43231651^^len1: int, 
    h53540541^^x: T :: 
  { NoDecl^^Seq#Contains(NoDecl^^Seq#Build(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i0, NoDecl^^v0, NoDecl^^len0), 
        NoDecl^^i1, 
        NoDecl^^v1, 
        NoDecl^^len1), 
      NoDecl^^x) } 
  0 <= NoDecl^^i0
       && NoDecl^^i0 < NoDecl^^len0
       && NoDecl^^len0 <= NoDecl^^i1
       && NoDecl^^i1 < NoDecl^^len1
     ==> (NoDecl^^Seq#Contains(NoDecl^^Seq#Build(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i0, NoDecl^^v0, NoDecl^^len0), 
          NoDecl^^i1, 
          NoDecl^^v1, 
          NoDecl^^len1), 
        NoDecl^^x)
       <==> NoDecl^^v1 == NoDecl^^x
         || NoDecl^^Seq#Contains(NoDecl^^Seq#Build(NoDecl^^s, NoDecl^^i0, NoDecl^^v0, NoDecl^^len0), NoDecl^^x)));

axiom (forall<T> h12102828^^s: Seq T, h41816592^^n: int, h40805010^^x: T :: 
  { NoDecl^^Seq#Contains(NoDecl^^Seq#Take(NoDecl^^s, NoDecl^^n), NoDecl^^x) } 
  NoDecl^^Seq#Contains(NoDecl^^Seq#Take(NoDecl^^s, NoDecl^^n), NoDecl^^x)
     <==> (exists h31700771^^i: int :: 
      { NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^i) } 
      0 <= NoDecl^^i
         && NoDecl^^i < NoDecl^^n
         && NoDecl^^i < NoDecl^^Seq#Length(NoDecl^^s)
         && NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^i) == NoDecl^^x));

axiom (forall<T> h16871484^^s: Seq T, h17625630^^n: int, h24412946^^x: T :: 
  { NoDecl^^Seq#Contains(NoDecl^^Seq#Drop(NoDecl^^s, NoDecl^^n), NoDecl^^x) } 
  NoDecl^^Seq#Contains(NoDecl^^Seq#Drop(NoDecl^^s, NoDecl^^n), NoDecl^^x)
     <==> (exists h18389930^^i: int :: 
      { NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^i) } 
      0 <= NoDecl^^n
         && NoDecl^^n <= NoDecl^^i
         && NoDecl^^i < NoDecl^^Seq#Length(NoDecl^^s)
         && NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^i) == NoDecl^^x));

function h31291646^^Seq#Equal<T>(Seq T, Seq T) : bool;

axiom (forall<T> h13189358^^s0: Seq T, h51595365^^s1: Seq T :: 
  { NoDecl^^Seq#Equal(NoDecl^^s0, NoDecl^^s1) } 
  NoDecl^^Seq#Equal(NoDecl^^s0, NoDecl^^s1)
     <==> NoDecl^^Seq#Length(NoDecl^^s0) == NoDecl^^Seq#Length(NoDecl^^s1)
       && (forall h61705107^^j: int :: 
        { NoDecl^^Seq#Index(NoDecl^^s0, NoDecl^^j) } 
          { NoDecl^^Seq#Index(NoDecl^^s1, NoDecl^^j) } 
        0 <= NoDecl^^j && NoDecl^^j < NoDecl^^Seq#Length(NoDecl^^s0)
           ==> NoDecl^^Seq#Index(NoDecl^^s0, NoDecl^^j)
             == NoDecl^^Seq#Index(NoDecl^^s1, NoDecl^^j)));

axiom (forall<T> h18475057^^a: Seq T, h32057793^^b: Seq T :: 
  { NoDecl^^Seq#Equal(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^Seq#Equal(NoDecl^^a, NoDecl^^b) ==> NoDecl^^a == NoDecl^^b);

function h20084682^^Seq#SameUntil<T>(Seq T, Seq T, int) : bool;

axiom (forall<T> h46544415^^s0: Seq T, h16246551^^s1: Seq T, h12001237^^n: int :: 
  { NoDecl^^Seq#SameUntil(NoDecl^^s0, NoDecl^^s1, NoDecl^^n) } 
  NoDecl^^Seq#SameUntil(NoDecl^^s0, NoDecl^^s1, NoDecl^^n)
     <==> (forall h40902273^^j: int :: 
      { NoDecl^^Seq#Index(NoDecl^^s0, NoDecl^^j) } 
        { NoDecl^^Seq#Index(NoDecl^^s1, NoDecl^^j) } 
      0 <= NoDecl^^j && NoDecl^^j < NoDecl^^n
         ==> NoDecl^^Seq#Index(NoDecl^^s0, NoDecl^^j)
           == NoDecl^^Seq#Index(NoDecl^^s1, NoDecl^^j)));

function h32576140^^Seq#Take<T>(h24749807^^s: Seq T, h21421675^^howMany: int) : Seq T;

axiom (forall<T> h58577354^^s: Seq T, h57434139^^n: int :: 
  { NoDecl^^Seq#Length(NoDecl^^Seq#Take(NoDecl^^s, NoDecl^^n)) } 
  0 <= NoDecl^^n
     ==> (NoDecl^^n <= NoDecl^^Seq#Length(NoDecl^^s)
         ==> NoDecl^^Seq#Length(NoDecl^^Seq#Take(NoDecl^^s, NoDecl^^n)) == NoDecl^^n)
       && (NoDecl^^Seq#Length(NoDecl^^s) < NoDecl^^n
         ==> NoDecl^^Seq#Length(NoDecl^^Seq#Take(NoDecl^^s, NoDecl^^n))
           == NoDecl^^Seq#Length(NoDecl^^s)));

axiom (forall<T> h47145209^^s: Seq T, h21653700^^n: int, h60665573^^j: int :: 
  {:weight 25} { NoDecl^^Seq#Index(NoDecl^^Seq#Take(NoDecl^^s, NoDecl^^n), NoDecl^^j) } 
  0 <= NoDecl^^j
       && NoDecl^^j < NoDecl^^n
       && NoDecl^^j < NoDecl^^Seq#Length(NoDecl^^s)
     ==> NoDecl^^Seq#Index(NoDecl^^Seq#Take(NoDecl^^s, NoDecl^^n), NoDecl^^j)
       == NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^j));

function h9119245^^Seq#Drop<T>(h14964341^^s: Seq T, h461342^^howMany: int) : Seq T;

axiom (forall<T> h4152081^^s: Seq T, h37368736^^n: int :: 
  { NoDecl^^Seq#Length(NoDecl^^Seq#Drop(NoDecl^^s, NoDecl^^n)) } 
  0 <= NoDecl^^n
     ==> (NoDecl^^n <= NoDecl^^Seq#Length(NoDecl^^s)
         ==> NoDecl^^Seq#Length(NoDecl^^Seq#Drop(NoDecl^^s, NoDecl^^n))
           == NoDecl^^Seq#Length(NoDecl^^s) - NoDecl^^n)
       && (NoDecl^^Seq#Length(NoDecl^^s) < NoDecl^^n
         ==> NoDecl^^Seq#Length(NoDecl^^Seq#Drop(NoDecl^^s, NoDecl^^n)) == 0));

axiom (forall<T> h774306^^s: Seq T, h6968762^^n: int, h62718864^^j: int :: 
  {:weight 25} { NoDecl^^Seq#Index(NoDecl^^Seq#Drop(NoDecl^^s, NoDecl^^n), NoDecl^^j) } 
  0 <= NoDecl^^n
       && 0 <= NoDecl^^j
       && NoDecl^^j < NoDecl^^Seq#Length(NoDecl^^s) - NoDecl^^n
     ==> NoDecl^^Seq#Index(NoDecl^^Seq#Drop(NoDecl^^s, NoDecl^^n), NoDecl^^j)
       == NoDecl^^Seq#Index(NoDecl^^s, NoDecl^^j + NoDecl^^n));

axiom (forall<T> h27598869^^s: Seq T, h47063234^^t: Seq T :: 
  { NoDecl^^Seq#Append(NoDecl^^s, NoDecl^^t) } 
  NoDecl^^Seq#Take(NoDecl^^Seq#Append(NoDecl^^s, NoDecl^^t), NoDecl^^Seq#Length(NoDecl^^s))
       == NoDecl^^s
     && NoDecl^^Seq#Drop(NoDecl^^Seq#Append(NoDecl^^s, NoDecl^^t), NoDecl^^Seq#Length(NoDecl^^s))
       == NoDecl^^t);

function h20915929^^Seq#FromArray(h54025633^^h: HeapType, h16468652^^a: ref) : Seq BoxType;

axiom (forall h14000148^^h: HeapType, h58892473^^a: ref :: 
  { NoDecl^^Seq#Length(NoDecl^^Seq#FromArray(NoDecl^^h, NoDecl^^a)) } 
  NoDecl^^Seq#Length(NoDecl^^Seq#FromArray(NoDecl^^h, NoDecl^^a))
     == NoDecl^^array.Length(NoDecl^^a));

axiom (forall h60270212^^h: HeapType, h5560998^^a: ref :: 
  { NoDecl^^Seq#FromArray(NoDecl^^h, NoDecl^^a): Seq BoxType } 
  (forall h50048984^^i: int :: 
    0 <= NoDecl^^i
         && NoDecl^^i < NoDecl^^Seq#Length(NoDecl^^Seq#FromArray(NoDecl^^h, NoDecl^^a))
       ==> NoDecl^^Seq#Index(NoDecl^^Seq#FromArray(NoDecl^^h, NoDecl^^a), NoDecl^^i)
         == NoDecl^^read(NoDecl^^h, NoDecl^^a, NoDecl^^IndexField(NoDecl^^i))));

type BoxType;

function h47787675^^$Box<T>(T) : BoxType;

function h27435897^^$Unbox<T>(BoxType) : T;

axiom (forall<T> h45596481^^x: T :: 
  { NoDecl^^$Box(NoDecl^^x) } 
  NoDecl^^$Unbox(NoDecl^^$Box(NoDecl^^x)) == NoDecl^^x);

axiom (forall h7715150^^b: BoxType :: 
  { NoDecl^^$Unbox(NoDecl^^b): int } 
  NoDecl^^$Box(NoDecl^^$Unbox(NoDecl^^b): int) == NoDecl^^b);

axiom (forall h2327487^^b: BoxType :: 
  { NoDecl^^$Unbox(NoDecl^^b): ref } 
  NoDecl^^$Box(NoDecl^^$Unbox(NoDecl^^b): ref) == NoDecl^^b);

axiom (forall h20947391^^b: BoxType :: 
  { NoDecl^^$Unbox(NoDecl^^b): Set BoxType } 
  NoDecl^^$Box(NoDecl^^$Unbox(NoDecl^^b): Set BoxType) == NoDecl^^b);

axiom (forall h54308798^^b: BoxType :: 
  { NoDecl^^$Unbox(NoDecl^^b): Seq BoxType } 
  NoDecl^^$Box(NoDecl^^$Unbox(NoDecl^^b): Seq BoxType) == NoDecl^^b);

axiom (forall h19017142^^b: BoxType :: 
  { NoDecl^^$Unbox(NoDecl^^b): DatatypeType } 
  NoDecl^^$Box(NoDecl^^$Unbox(NoDecl^^b): DatatypeType) == NoDecl^^b);

function h36936550^^$IsCanonicalBoolBox(BoxType) : bool;

axiom NoDecl^^$IsCanonicalBoolBox(NoDecl^^$Box(false))
   && NoDecl^^$IsCanonicalBoolBox(NoDecl^^$Box(true));

axiom (forall h63993496^^b: BoxType :: 
  { NoDecl^^$Unbox(NoDecl^^b): bool } 
  NoDecl^^$IsCanonicalBoolBox(NoDecl^^b)
     ==> NoDecl^^$Box(NoDecl^^$Unbox(NoDecl^^b): bool) == NoDecl^^b);

type ClassName;

const unique h39070558^^class.int: ClassName;

const unique h16090703^^class.bool: ClassName;

const unique h10598606^^class.set: ClassName;

const unique h28278595^^class.seq: ClassName;

const unique h53180767^^class.multiset: ClassName;

function h8864859^^dtype(ref) : ClassName;

function h12674872^^TypeParams(ref, int) : ClassName;

function h46964992^^TypeTuple(h20031746^^a: ClassName, h46067993^^b: ClassName) : ClassName;

function h11958757^^TypeTupleCar(ClassName) : ClassName;

function h40519951^^TypeTupleCdr(ClassName) : ClassName;

axiom (forall h29135240^^a: ClassName, h60890569^^b: ClassName :: 
  { NoDecl^^TypeTuple(NoDecl^^a, NoDecl^^b) } 
  NoDecl^^TypeTupleCar(NoDecl^^TypeTuple(NoDecl^^a, NoDecl^^b)) == NoDecl^^a
     && NoDecl^^TypeTupleCdr(NoDecl^^TypeTuple(NoDecl^^a, NoDecl^^b)) == NoDecl^^b);

type DatatypeType;

function h11144211^^DtType(DatatypeType) : ClassName;

function h33189039^^DtTypeParams(DatatypeType, int) : ClassName;

type DtCtorId;

function h30265903^^DatatypeCtorId(DatatypeType) : DtCtorId;

function h3957675^^DtRank(DatatypeType) : int;

const h35619075^^$ModuleContextHeight: int;

const h52136226^^$FunctionContextHeight: int;

const h66572856^^$InMethodContext: bool;

type Field _;

function h62284798^^FDim<T>(Field T) : int;

function h23692278^^IndexField(int) : Field BoxType;

axiom (forall h11903911^^i: int :: 
  { NoDecl^^IndexField(NoDecl^^i) } 
  NoDecl^^FDim(NoDecl^^IndexField(NoDecl^^i)) == 1);

function h40026340^^IndexField_Inverse<T>(Field T) : int;

axiom (forall h24692740^^i: int :: 
  { NoDecl^^IndexField(NoDecl^^i) } 
  NoDecl^^IndexField_Inverse(NoDecl^^IndexField(NoDecl^^i)) == NoDecl^^i);

function h20908074^^MultiIndexField(Field BoxType, int) : Field BoxType;

axiom (forall h53954942^^f: Field BoxType, h15832433^^i: int :: 
  { NoDecl^^MultiIndexField(NoDecl^^f, NoDecl^^i) } 
  NoDecl^^FDim(NoDecl^^MultiIndexField(NoDecl^^f, NoDecl^^i))
     == NoDecl^^FDim(NoDecl^^f) + 1);

function h8274172^^MultiIndexField_Inverse0<T>(Field T) : Field T;

function h7358688^^MultiIndexField_Inverse1<T>(Field T) : int;

axiom (forall h66228199^^f: Field BoxType, h59182880^^i: int :: 
  { NoDecl^^MultiIndexField(NoDecl^^f, NoDecl^^i) } 
  NoDecl^^MultiIndexField_Inverse0(NoDecl^^MultiIndexField(NoDecl^^f, NoDecl^^i))
       == NoDecl^^f
     && NoDecl^^MultiIndexField_Inverse1(NoDecl^^MultiIndexField(NoDecl^^f, NoDecl^^i))
       == NoDecl^^i);

function h62883878^^DeclType<T>(Field T) : ClassName;

const unique h29083993^^alloc: Field bool;

axiom NoDecl^^FDim(NoDecl^^alloc) == 0;

function h60429346^^DtAlloc(DatatypeType, HeapType) : bool;

axiom (forall h6993202^^h: HeapType, h62938818^^k: HeapType, h29578451^^d: DatatypeType :: 
  { NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k), NoDecl^^DtAlloc(NoDecl^^d, NoDecl^^h) } 
    { NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k), NoDecl^^DtAlloc(NoDecl^^d, NoDecl^^k) } 
  NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k)
     ==> 
    NoDecl^^DtAlloc(NoDecl^^d, NoDecl^^h)
     ==> NoDecl^^DtAlloc(NoDecl^^d, NoDecl^^k));

function h64879470^^GenericAlloc(BoxType, HeapType) : bool;

axiom (forall h47044325^^h: HeapType, h20745743^^k: HeapType, h52493967^^d: BoxType :: 
  { NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k), NoDecl^^GenericAlloc(NoDecl^^d, NoDecl^^h) } 
    { NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k), NoDecl^^GenericAlloc(NoDecl^^d, NoDecl^^k) } 
  NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k)
     ==> 
    NoDecl^^GenericAlloc(NoDecl^^d, NoDecl^^h)
     ==> NoDecl^^GenericAlloc(NoDecl^^d, NoDecl^^k));

axiom (forall h2683661^^b: BoxType, h24152954^^h: HeapType :: 
  { NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h), NoDecl^^h[NoDecl^^$Unbox(NoDecl^^b): ref, NoDecl^^alloc] } 
  NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h)
     ==> NoDecl^^$Unbox(NoDecl^^b): ref == NoDecl^^null
       || NoDecl^^h[NoDecl^^$Unbox(NoDecl^^b): ref, NoDecl^^alloc]);

axiom (forall h16049999^^b: BoxType, h10232270^^h: HeapType, h24981566^^i: int :: 
  { NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h), NoDecl^^Seq#Index(NoDecl^^$Unbox(NoDecl^^b): Seq BoxType, NoDecl^^i) } 
  NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h)
       && 0 <= NoDecl^^i
       && NoDecl^^i < NoDecl^^Seq#Length(NoDecl^^$Unbox(NoDecl^^b): Seq BoxType)
     ==> NoDecl^^GenericAlloc(NoDecl^^Seq#Index(NoDecl^^$Unbox(NoDecl^^b): Seq BoxType, NoDecl^^i), NoDecl^^h));

axiom (forall h23507505^^b: BoxType, h10240961^^h: HeapType, h25059790^^t: BoxType :: 
  { NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h), (NoDecl^^$Unbox(NoDecl^^b): Set BoxType)[NoDecl^^t] } 
  NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h)
       && (NoDecl^^$Unbox(NoDecl^^b): Set BoxType)[NoDecl^^t]
     ==> NoDecl^^GenericAlloc(NoDecl^^t, NoDecl^^h));

axiom (forall h24211521^^b: BoxType, h16577099^^h: HeapType :: 
  { NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h), NoDecl^^DtType(NoDecl^^$Unbox(NoDecl^^b): DatatypeType) } 
  NoDecl^^GenericAlloc(NoDecl^^b, NoDecl^^h)
     ==> NoDecl^^DtAlloc(NoDecl^^$Unbox(NoDecl^^b): DatatypeType, NoDecl^^h));

axiom (forall h14976165^^b: bool, h567760^^h: HeapType :: 
  NoDecl^^$IsGoodHeap(NoDecl^^h)
     ==> NoDecl^^GenericAlloc(NoDecl^^$Box(NoDecl^^b), NoDecl^^h));

axiom (forall h5109846^^x: int, h45988614^^h: HeapType :: 
  NoDecl^^$IsGoodHeap(NoDecl^^h)
     ==> NoDecl^^GenericAlloc(NoDecl^^$Box(NoDecl^^x), NoDecl^^h));

axiom (forall h11244347^^r: ref, h34090260^^h: HeapType :: 
  { NoDecl^^GenericAlloc(NoDecl^^$Box(NoDecl^^r), NoDecl^^h) } 
  NoDecl^^$IsGoodHeap(NoDecl^^h)
       && (NoDecl^^r == NoDecl^^null || NoDecl^^h[NoDecl^^r, NoDecl^^alloc])
     ==> NoDecl^^GenericAlloc(NoDecl^^$Box(NoDecl^^r), NoDecl^^h));

function h38376892^^array.Length(h9847715^^a: ref) : int;

axiom (forall h21520579^^o: ref :: 0 <= NoDecl^^array.Length(NoDecl^^o));

procedure UpdateArrayRange(h59467483^^arr: ref, 
    h65445301^^low: int, 
    h52136803^^high: int, 
    h66578044^^rhs: BoxType);
  modifies NoDecl^^$Heap;
  ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
  ensures (forall h62331491^^i: int :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^arr, NoDecl^^IndexField(NoDecl^^i)) } 
  NoDecl^^low <= NoDecl^^i && NoDecl^^i < NoDecl^^high
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^arr, NoDecl^^IndexField(NoDecl^^i))
       == NoDecl^^rhs);
  ensures (forall<alpha> h24112512^^o: ref, h15686020^^f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^o, NoDecl^^f) } 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^o, NoDecl^^f)
       == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^o, NoDecl^^f)
     || (
      NoDecl^^o == NoDecl^^arr
       && NoDecl^^FDim(NoDecl^^f) == 1
       && NoDecl^^low <= NoDecl^^IndexField_Inverse(NoDecl^^f)
       && NoDecl^^IndexField_Inverse(NoDecl^^f) < NoDecl^^high));



type HeapType = <alpha>[ref,Field alpha]alpha;

function {:inline true} h6956456^^read<alpha>(h62608109^^H: HeapType, h26602077^^r: ref, h38092103^^f: Field alpha) : alpha
{
  NoDecl^^H[NoDecl^^r, NoDecl^^f]
}

function {:inline true} h7284614^^update<alpha>(h65561530^^H: HeapType, 
    h53182860^^r: ref, 
    h8883693^^f: Field alpha, 
    h12844374^^v: alpha)
   : HeapType
{
  NoDecl^^H[NoDecl^^r, NoDecl^^f := NoDecl^^v]
}

function h48490504^^$IsGoodHeap(HeapType) : bool;

var h33761356^^$Heap: HeapType where NoDecl^^$IsGoodHeap(NoDecl^^$Heap);

function h35416756^^$HeapSucc(HeapType, HeapType) : bool;

axiom (forall<alpha> h50315352^^h: HeapType, 
    h50184984^^r: ref, 
    h49011679^^f: Field alpha, 
    h38451933^^x: alpha :: 
  { NoDecl^^update(NoDecl^^h, NoDecl^^r, NoDecl^^f, NoDecl^^x) } 
  NoDecl^^$IsGoodHeap(NoDecl^^update(NoDecl^^h, NoDecl^^r, NoDecl^^f, NoDecl^^x))
     ==> NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^update(NoDecl^^h, NoDecl^^r, NoDecl^^f, NoDecl^^x)));

axiom (forall h10523083^^a: HeapType, h27598891^^b: HeapType, h47063428^^c: HeapType :: 
  { NoDecl^^$HeapSucc(NoDecl^^a, NoDecl^^b), NoDecl^^$HeapSucc(NoDecl^^b, NoDecl^^c) } 
  NoDecl^^$HeapSucc(NoDecl^^a, NoDecl^^b)
       && NoDecl^^$HeapSucc(NoDecl^^b, NoDecl^^c)
     ==> NoDecl^^$HeapSucc(NoDecl^^a, NoDecl^^c));

axiom (forall h20917673^^h: HeapType, h54041329^^k: HeapType :: 
  { NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k) } 
  NoDecl^^$HeapSucc(NoDecl^^h, NoDecl^^k)
     ==> (forall h16609919^^o: ref :: 
      { NoDecl^^read(NoDecl^^k, NoDecl^^o, NoDecl^^alloc) } 
      NoDecl^^read(NoDecl^^h, NoDecl^^o, NoDecl^^alloc)
         ==> NoDecl^^read(NoDecl^^k, NoDecl^^o, NoDecl^^alloc)));

type TickType;

var h15271547^^$Tick: TickType;

const unique h3226198^^class.object: ClassName;

const unique h29035785^^class.array: ClassName;

const unique h59995477^^class.AVLTree: ClassName;

axiom NoDecl^^FDim(NoDecl^^AVLTree.root) == 0
   && NoDecl^^DeclType(NoDecl^^AVLTree.root) == NoDecl^^class.AVLTree;

const unique h3088388^^AVLTree.root: Field ref;

axiom (forall h27795493^^$h: HeapType, h48832851^^$o: ref :: 
  { NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^AVLTree.root) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h)
       && NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^AVLTree.root) == NoDecl^^null
       || (NoDecl^^read(NoDecl^^$h, 
          NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^AVLTree.root), 
          NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^AVLTree.root))
           == NoDecl^^class.Node));

axiom NoDecl^^FDim(NoDecl^^AVLTree.Contents) == 0
   && NoDecl^^DeclType(NoDecl^^AVLTree.Contents) == NoDecl^^class.AVLTree;

const unique h36842478^^AVLTree.Contents: Field (Set BoxType);

axiom NoDecl^^FDim(NoDecl^^AVLTree.Repr) == 0
   && NoDecl^^DeclType(NoDecl^^AVLTree.Repr) == NoDecl^^class.AVLTree;

const unique h63146847^^AVLTree.Repr: Field (Set BoxType);

axiom (forall h31450711^^$h: HeapType, h14620943^^$o: ref :: 
  { NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^AVLTree.Repr) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h)
       && NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^alloc)
     ==> (forall h64479624^^$t#1: BoxType :: 
      { NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^AVLTree.Repr)[NoDecl^^$t#1] } 
      NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^AVLTree.Repr)[NoDecl^^$t#1]
         ==> NoDecl^^$Unbox(NoDecl^^$t#1): ref == NoDecl^^null
           || (NoDecl^^read(NoDecl^^$h, NoDecl^^$Unbox(NoDecl^^$t#1): ref, NoDecl^^alloc)
             && NoDecl^^dtype(NoDecl^^$Unbox(NoDecl^^$t#1): ref) == NoDecl^^class.Node)));

procedure CheckWellformed$$AVLTree.Init(h43445707^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h55467050^^v#0: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$AVLTree.Init(h29441404^^this: ref, h63646052^^v#0: int)
{
  var h35943562^^$_Frame: <beta>[ref,Field beta]bool;

    NoDecl^^$_Frame := (lambda<alpha> h55056607^^$o: ref, h25747420^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^this);
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h30400195^^$o: ref, h5166299^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^this);
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    assume NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this);
    assume NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this);
}



axiom NoDecl^^FDim(NoDecl^^Node.Repr) == 0
   && NoDecl^^DeclType(NoDecl^^Node.Repr) == NoDecl^^class.Node;

axiom NoDecl^^FDim(NoDecl^^Node.Contents) == 0
   && NoDecl^^DeclType(NoDecl^^Node.Contents) == NoDecl^^class.Node;

procedure AVLTree.Init(h46496694^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h15817070^^v#0: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  free ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))];
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Repr));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Contents));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  free ensures (forall<alpha> h8135907^^$o: ref, h6114302^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^this);
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation AVLTree.Init(h55028720^^this: ref, h25496434^^v#0: int)
{
  var h28141317^^$_Frame: <beta>[ref,Field beta]bool;
  var h51945267^^$rhs#0: ref;
  var h64854219^^$nw: ref;
  var h46817064^^v#46: int;
  var h18700393^^$rhs#1: Set BoxType;
  var h34085817^^$rhs#2: Set BoxType;

    NoDecl^^$_Frame := (lambda<alpha> h38336904^^$o: ref, h9487824^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^this);
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
    havoc NoDecl^^$nw;
    assume NoDecl^^$nw != NoDecl^^null
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^$nw, NoDecl^^alloc)
   && NoDecl^^dtype(NoDecl^^$nw) == NoDecl^^class.Node;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^$nw, NoDecl^^alloc, true);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    NoDecl^^$rhs#0 := NoDecl^^$nw;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root, NoDecl^^$rhs#0);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(11,12)"} true;
    assume true;
    NoDecl^^v#46 := NoDecl^^v#0;
    assert (forall<alpha> h18281552^^$o: ref, h30316242^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.Init(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), NoDecl^^v#46);
    assume {:captureState "AVLTree.dfy(12,12)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.Contents];
    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#1 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
  NoDecl^^Node.Contents);
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents, NoDecl^^$rhs#1);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(13,21)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.Repr];
    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#2 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
  NoDecl^^Node.Repr);
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr, NoDecl^^$rhs#2);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(14,17)"} true;
}



function h4410728^^AVLTree.Valid(h39696553^^$heap: HeapType, h21724664^^this: ref) : bool;

function h61304253^^AVLTree.Valid#canCall(h14867369^^$heap: HeapType, h66697461^^this: ref) : bool;

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (7 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h63406242^^$Heap: HeapType, h33785274^^this: ref :: 
    { NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this) } 
    NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 7 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && NoDecl^^this != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree)
       ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Repr))
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Repr))
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Contents))
           ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Repr))
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Contents))
             && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
           ==> NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Repr))
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Contents))
             && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
             && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
           ==> NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)))
         && NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
           == (
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Repr))
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
                NoDecl^^Node.Contents))
             && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
             && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
             && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))));

axiom (forall h35632012^^$h0: HeapType, h52252659^^$h1: HeapType, h511887^^this: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^AVLTree.Valid(NoDecl^^$h1, NoDecl^^this) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && NoDecl^^this != NoDecl^^null
       && NoDecl^^read(NoDecl^^$h0, NoDecl^^this, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree
       && NoDecl^^read(NoDecl^^$h1, NoDecl^^this, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h4606985^^$o: ref, h41462866^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && (NoDecl^^$o == NoDecl^^this
             || NoDecl^^read(NoDecl^^$h0, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^$o)])
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^AVLTree.Valid(NoDecl^^$h0, NoDecl^^this)
       == NoDecl^^AVLTree.Valid(NoDecl^^$h1, NoDecl^^this));

procedure CheckWellformed$$AVLTree.Valid(h37621475^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree);
  free requires 0 == NoDecl^^$ModuleContextHeight && 7 == NoDecl^^$FunctionContextHeight;



implementation CheckWellformed$$AVLTree.Valid(h3048957^^this: ref)
{
  var h27440617^^$_Frame: <beta>[ref,Field beta]bool;
  var h45638969^^n#47: ref;
  var h8097541^^n#48: ref;
  var h5769005^^n#49: ref;

    if (*)
    {
    }
    else
    {
        NoDecl^^$_Frame := (lambda<alpha> h51921052^^$o: ref, h64636290^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^this
       || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
        assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null)
        {
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.Repr];
        }

        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))])
        {
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.Repr];
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
            assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), NoDecl^^Node.Repr];
        }

        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr)))
        {
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.Contents];
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
            assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), NoDecl^^Node.Contents];
        }

        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents)))
        {
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
            NoDecl^^n#47 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root);
            assert (forall<alpha> h44855704^^$o: ref, h1048160^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#47
         || (NoDecl^^n#47 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#47, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
        }

        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)))
        {
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
            NoDecl^^n#48 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root);
            assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#48);
            assert (forall<alpha> h9433441^^$o: ref, h17792110^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#48
         || (NoDecl^^n#48 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#48, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
        }

        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)))
        {
            assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.root];
            NoDecl^^n#49 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root);
            assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#49)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#49);
            assert (forall<alpha> h25911262^^$o: ref, h31874772^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#49
         || (NoDecl^^n#49 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#49, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
        }

        assume NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
   == (
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
     && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
     && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Repr))
     && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Contents))
     && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
     && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
     && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)));
        assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
          NoDecl^^Node.Repr))
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
          NoDecl^^Node.Repr))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
          NoDecl^^Node.Contents))
     ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
          NoDecl^^Node.Repr))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
          NoDecl^^Node.Contents))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
     ==> NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
          NoDecl^^Node.Repr))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
          NoDecl^^Node.Contents))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
       && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
     ==> NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root)));
    }
}



procedure CheckWellformed$$AVLTree.Find(h18437496^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h31719739^^key#1: int)
   returns (h17042198^^b#2: bool);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$AVLTree.Find(h19162058^^this: ref, h38240801^^key#1: int) returns (h8622890^^b#2: bool)
{
  var h10497152^^$_Frame: <beta>[ref,Field beta]bool;

    NoDecl^^$_Frame := (lambda<alpha> h27365507^^$o: ref, h44962972^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> false);
    assume NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this);
    assume NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this);
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h2013564^^$o: ref, h18122076^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
       == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f));
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    havoc NoDecl^^b#2;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents)[NoDecl^^$Box(NoDecl^^key#1)]
   <==> NoDecl^^b#2;
}



procedure AVLTree.Find(h28880957^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h58602024^^key#1: int)
   returns (h57656175^^b#2: bool);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  free requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))];
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Repr));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Contents));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents)[NoDecl^^$Box(NoDecl^^key#1)]
   <==> NoDecl^^b#2;
  free ensures (forall<alpha> h49143529^^$o: ref, h39638585^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
       == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f));
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



axiom NoDecl^^FDim(NoDecl^^Node.left) == 0
   && NoDecl^^DeclType(NoDecl^^Node.left) == NoDecl^^class.Node;

axiom NoDecl^^FDim(NoDecl^^Node.right) == 0
   && NoDecl^^DeclType(NoDecl^^Node.right) == NoDecl^^class.Node;

axiom NoDecl^^FDim(NoDecl^^Node.value) == 0
   && NoDecl^^DeclType(NoDecl^^Node.value) == NoDecl^^class.Node;

implementation AVLTree.Find(h21202951^^this: ref, h56608836^^key#1: int) returns (h39717481^^b#2: bool)
{
  var h21913016^^$_Frame: <beta>[ref,Field beta]bool;
  var h62999416^^t#3: ref
   where NoDecl^^t#3 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^t#3) == NoDecl^^class.Node);
  var h30123835^^$PreLoopHeap0: HeapType;
  var h2679067^^$decr0$init$0: Set BoxType;
  var h24111608^^$w0: bool;
  var h15677883^^n#50: ref;
  var h6883221^^$decr0$0: Set BoxType;

    NoDecl^^$_Frame := (lambda<alpha> h61948991^^$o: ref, h20670010^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> false);
    assume true;
    assume true;
    NoDecl^^t#3 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root);
    assume {:captureState "AVLTree.dfy(29,13)"} true;
    NoDecl^^$PreLoopHeap0 := NoDecl^^$Heap;
    NoDecl^^$decr0$init$0 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr);
    havoc NoDecl^^$w0;
    while (true)
      free invariant NoDecl^^$w0
   ==> 
  NoDecl^^t#3 != NoDecl^^null
   ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3);
      invariant NoDecl^^$w0 ==> NoDecl^^t#3 != NoDecl^^null;
      free invariant NoDecl^^$w0
   ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
     && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     && (NoDecl^^t#3 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#3)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#3)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#3)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)))
         && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr), 
          NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#3)), 
              (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
                 then NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
                  NoDecl^^Node.Repr)
                 else NoDecl^^Set#Empty(): Set BoxType)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)))
         && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Contents), 
          NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
                NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value))), 
              (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
                 then NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
                  NoDecl^^Node.Contents)
                 else NoDecl^^Set#Empty(): Set BoxType)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
           ==> (forall h51812368^^i#16: int :: 
            true
               ==> 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
               ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
           ==> (forall h63658128^^i#17: int :: 
            true
               ==> 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
                NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
               ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value) < NoDecl^^i#17)));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#3)]);
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left))]);
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#3)]);
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right))]);
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#3)]);
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr)));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left)));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right)));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#3)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h36052245^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value)));
      invariant NoDecl^^$w0
   ==> 
  NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3)
     || (NoDecl^^t#3 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h56034750^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value) < NoDecl^^i#17));
      free invariant NoDecl^^$w0 ==> true;
      invariant NoDecl^^$w0
   ==> !(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents)[NoDecl^^$Box(NoDecl^^key#1)]
     && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^key#1)]);
      free invariant NoDecl^^$w0 ==> true;
      invariant NoDecl^^$w0
   ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents));
      free invariant (forall<alpha> h34550710^^$o: ref, h42520941^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
       == NoDecl^^read(NoDecl^^$PreLoopHeap0, NoDecl^^$o, NoDecl^^$f));
      free invariant NoDecl^^$HeapSucc(NoDecl^^$PreLoopHeap0, NoDecl^^$Heap);
      free invariant (forall<alpha> h47144157^^$o: ref, h21644229^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$PreLoopHeap0, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(NoDecl^^$PreLoopHeap0, NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
      free invariant NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr), 
    NoDecl^^$decr0$init$0)
   && (NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr), 
      NoDecl^^$decr0$init$0)
     ==> true);
    {
        if (!NoDecl^^$w0)
        {
            if (NoDecl^^t#3 != NoDecl^^null)
            {
                NoDecl^^n#50 := NoDecl^^t#3;
                assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3);
            }

            assume NoDecl^^t#3 != NoDecl^^null
   ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3);
            assume NoDecl^^t#3 != NoDecl^^null && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#3);
            assert {:subsumption 0} NoDecl^^t#3 != NoDecl^^null;
            assume true;
            assume !(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents)[NoDecl^^$Box(NoDecl^^key#1)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^key#1)]);
            assert {:subsumption 0} NoDecl^^t#3 != NoDecl^^null;
            assert {:subsumption 0} NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
            assume true;
            assume NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Contents), 
  NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
    NoDecl^^Node.Contents));
            assert NoDecl^^t#3 != NoDecl^^null;
            assume true;
            assume false;
        }

        assume true;
        if (!true)
        {
            break;
        }

        assume {:captureState "AVLTree.dfy(30,7): loop entered"} true;
        NoDecl^^$decr0$0 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr);
        assert NoDecl^^t#3 != NoDecl^^null;
        assume true;
        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value) == NoDecl^^key#1)
        {
            assert {:subsumption 0} NoDecl^^t#3 != NoDecl^^null;
            assert {:subsumption 0} NoDecl^^t#3 != NoDecl^^null;
            assume true;
            assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value))];
            assume true;
            assume true;
            NoDecl^^b#2 := true;
            assume {:captureState "AVLTree.dfy(39,15)"} true;
            return;
        }
        else
        {
            assert NoDecl^^t#3 != NoDecl^^null;
            assume true;
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.value) < NoDecl^^key#1)
            {
                assume true;
                assert NoDecl^^t#3 != NoDecl^^null;
                assume true;
                NoDecl^^t#3 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.right);
                assume {:captureState "AVLTree.dfy(44,15)"} true;
            }
            else
            {
                assume true;
                assert NoDecl^^t#3 != NoDecl^^null;
                assume true;
                NoDecl^^t#3 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.left);
                assume {:captureState "AVLTree.dfy(48,15)"} true;
            }
        }

        assume true;
        if (NoDecl^^t#3 == NoDecl^^null)
        {
            assume true;
            assume true;
            NoDecl^^b#2 := false;
            assume {:captureState "AVLTree.dfy(52,15)"} true;
            return;
        }
        else
        {
        }

        assert NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr), NoDecl^^$decr0$0)
   && !NoDecl^^Set#Subset(NoDecl^^$decr0$0, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#3, NoDecl^^Node.Repr));
        assume NoDecl^^t#3 != NoDecl^^null
   ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#3);
        assume true;
        assume true;
    }

    assume {:captureState "AVLTree.dfy(30,7): loop exit"} true;
}



procedure CheckWellformed$$AVLTree.Insert(h60580335^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h8352109^^key#4: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$AVLTree.Insert(h8060118^^this: ref, h5432205^^key#4: int)
{
  var h48889850^^$_Frame: <beta>[ref,Field beta]bool;

    NoDecl^^$_Frame := (lambda<alpha> h37355470^^$o: ref, h654914^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^this
       || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
    assume NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this);
    assume NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this);
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h5894231^^$o: ref, h53048087^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^this
       || NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    assume NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
  NoDecl^^Set#Union(old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents)), 
    NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#4))));
    assume NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this);
    assume NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this);
}



procedure AVLTree.Insert(h7670737^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h1927776^^key#4: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  free requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))];
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Repr));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Contents));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  requires NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
  NoDecl^^Set#Union(old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents)), 
    NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#4))));
  free ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))]
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Repr))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
      NoDecl^^Node.Contents))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root))];
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Repr));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
        NoDecl^^Node.Contents));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  ensures NoDecl^^AVLTree.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^AVLTree.Valid(NoDecl^^$Heap, NoDecl^^this)
     || NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root));
  free ensures (forall<alpha> h17349988^^$o: ref, h21932166^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^this
       || NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation AVLTree.Insert(h63171767^^this: ref, h31674992^^key#4: int)
{
  var h16639474^^$_Frame: <beta>[ref,Field beta]bool;
  var h15537542^^dummy#5: int;
  var h5620158^^$obj0: ref;
  var h50581426^^$rhs#0: ref
   where NoDecl^^$rhs#0 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^$rhs#0, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^$rhs#0) == NoDecl^^class.Node);
  var h52579650^^$rhs#1: int;
  var h3454809^^t#51: ref;
  var h31093287^^key#52: int;
  var h11404133^^$rhs#2: Set BoxType;
  var h35528341^^$rhs#3: Set BoxType;

    NoDecl^^$_Frame := (lambda<alpha> h51319614^^$o: ref, h59223347^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^this
       || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
    assume true;
    NoDecl^^$obj0 := NoDecl^^this;
    assert NoDecl^^$_Frame[NoDecl^^$obj0, NoDecl^^AVLTree.root];
    assume true;
    assume true;
    NoDecl^^t#51 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root);
    assume true;
    NoDecl^^key#52 := NoDecl^^key#4;
    assert (forall<alpha> h63248075^^$o: ref, h32361769^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^t#51 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#51, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call NoDecl^^$rhs#0, NoDecl^^$rhs#1 := AVLTree.InsertRecursion(NoDecl^^this, NoDecl^^t#51, NoDecl^^key#52);
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^$obj0, NoDecl^^AVLTree.root, NoDecl^^$rhs#0);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    NoDecl^^dummy#5 := NoDecl^^$rhs#1;
    assume {:captureState "AVLTree.dfy(64,22)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.Contents];
    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#2 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
  NoDecl^^Node.Contents);
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Contents, NoDecl^^$rhs#2);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(65,16)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^AVLTree.Repr];
    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root) != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#3 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.root), 
  NoDecl^^Node.Repr);
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^AVLTree.Repr, NoDecl^^$rhs#3);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(66,12)"} true;
}



procedure CheckWellformed$$AVLTree.InsertRecursion(h22820469^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h4057632^^t#6: ref
       where NoDecl^^t#6 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^t#6) == NoDecl^^class.Node), 
    h36518691^^key#7: int)
   returns (h60232767^^r#8: ref
       where NoDecl^^r#8 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#8) == NoDecl^^class.Node), 
    h5223998^^deltaH#9: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



axiom NoDecl^^FDim(NoDecl^^Node.balance) == 0
   && NoDecl^^DeclType(NoDecl^^Node.balance) == NoDecl^^class.Node;

implementation CheckWellformed$$AVLTree.InsertRecursion(h47015983^^this: ref, h20490669^^t#6: ref, h50198296^^key#7: int)
   returns (h49131481^^r#8: ref, h39530145^^deltaH#9: int)
{
  var h20226985^^$_Frame: <beta>[ref,Field beta]bool;
  var h47825138^^n#53: ref;
  var h27773061^^n#54: ref;
  var h48630964^^n#55: ref;
  var h35025494^^n#56: ref;
  var h46793998^^n#57: ref;
  var h18492804^^n#58: ref;
  var h32217513^^n#59: ref;
  var h21522166^^n#60: ref;

    NoDecl^^$_Frame := (lambda<alpha> h59481773^^$o: ref, h65573909^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^t#6 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
    NoDecl^^n#53 := NoDecl^^t#6;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6))
    {
        NoDecl^^n#54 := NoDecl^^t#6;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#54);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
    }

    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6))
    {
        NoDecl^^n#55 := NoDecl^^t#6;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#55)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#55);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6);
    if (NoDecl^^t#6 != NoDecl^^null)
    {
        assert NoDecl^^t#6 != NoDecl^^null;
    }
    else
    {
    }

    havoc NoDecl^^$Heap;
    assume (forall<alpha> h53294272^^$o: ref, h9886408^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || (NoDecl^^t#6 != NoDecl^^null
         && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]));
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    havoc NoDecl^^r#8, NoDecl^^deltaH#9;
    if (NoDecl^^r#8 != NoDecl^^null)
    {
        if (NoDecl^^t#6 != NoDecl^^null)
        {
            assert NoDecl^^t#6 != NoDecl^^null;
        }

        if (!(NoDecl^^t#6 != NoDecl^^null
   && old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr))[NoDecl^^$Box(NoDecl^^r#8)]))
        {
        }
    }

    assume NoDecl^^r#8 != NoDecl^^null
   && (
    (NoDecl^^t#6 != NoDecl^^null
       && old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr))[NoDecl^^$Box(NoDecl^^r#8)])
     || NoDecl^^r#8 == NoDecl^^null
     || !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^r#8, NoDecl^^alloc));
    if (NoDecl^^t#6 != NoDecl^^null)
    {
        assert NoDecl^^r#8 != NoDecl^^null;
        assert NoDecl^^t#6 != NoDecl^^null;
        if ((forall h21868813^^$o: ref :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
       && !old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr))[NoDecl^^$Box(NoDecl^^$o)]
     ==> !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)))
        {
            assert NoDecl^^r#8 != NoDecl^^null;
            assert NoDecl^^t#6 != NoDecl^^null;
        }
    }

    assume NoDecl^^t#6 != NoDecl^^null
   ==> (forall h62601592^^$o: ref :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
           && !old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr))[NoDecl^^$Box(NoDecl^^$o)]
         ==> !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc))
     && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Contents), 
      NoDecl^^Set#Union(old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents)), 
        NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#7))));
    if (NoDecl^^t#6 == NoDecl^^null)
    {
        assert NoDecl^^r#8 != NoDecl^^null;
        if ((forall h26543418^^$o: ref :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)))
        {
            assert NoDecl^^r#8 != NoDecl^^null;
        }
    }

    assume NoDecl^^t#6 == NoDecl^^null
   ==> (forall h37564172^^$o: ref :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
         ==> !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc))
     && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Contents), 
      NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#7)));
    NoDecl^^n#56 := NoDecl^^r#8;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8))
    {
        NoDecl^^n#57 := NoDecl^^r#8;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#57);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#8);
    }

    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#8))
    {
        NoDecl^^n#58 := NoDecl^^r#8;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#58)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#58);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#8);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#8)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#8);
    NoDecl^^n#59 := NoDecl^^r#8;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#59);
    assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^r#8);
    NoDecl^^n#60 := NoDecl^^t#6;
    assert NoDecl^^t#6 == NoDecl^^null
   || (NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^alloc)
     && NoDecl^^dtype(NoDecl^^t#6) == NoDecl^^class.Node);
    assert NoDecl^^Node.Valid(old(NoDecl^^$Heap), NoDecl^^n#60);
    assume NoDecl^^Node.Height#canCall(old(NoDecl^^$Heap), NoDecl^^t#6);
    if (NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^r#8)
     - old(NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^t#6))
   == NoDecl^^deltaH#9)
    {
        if (NoDecl^^deltaH#9 != 0)
        {
        }
    }

    assume NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^r#8)
       - old(NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^t#6))
     == NoDecl^^deltaH#9
   && (NoDecl^^deltaH#9 == 0 || NoDecl^^deltaH#9 == 1);
    if (NoDecl^^t#6 != NoDecl^^null)
    {
    }

    if (NoDecl^^t#6 != NoDecl^^null && NoDecl^^deltaH#9 == 1)
    {
        assert NoDecl^^r#8 != NoDecl^^null;
    }

    assume NoDecl^^t#6 != NoDecl^^null && NoDecl^^deltaH#9 == 1
   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) != 0;
}



procedure AVLTree.InsertRecursion(h2533231^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.AVLTree, 
    h22799085^^t#6: ref
       where NoDecl^^t#6 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^t#6) == NoDecl^^class.Node), 
    h3865173^^key#7: int)
   returns (h34786562^^r#8: ref
       where NoDecl^^r#8 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#8) == NoDecl^^class.Node), 
    h44643603^^deltaH#9: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  free requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
   && (NoDecl^^t#6 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#6)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h66248115^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h59362130^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value) < NoDecl^^i#17)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#6)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h64497130^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h43603258^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value) < NoDecl^^i#17));
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
   && (NoDecl^^t#6 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
   && (NoDecl^^t#6 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  ensures NoDecl^^r#8 != NoDecl^^null;
  ensures (NoDecl^^t#6 != NoDecl^^null
     && old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr))[NoDecl^^$Box(NoDecl^^r#8)])
   || NoDecl^^r#8 == NoDecl^^null
   || !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^r#8, NoDecl^^alloc);
  ensures NoDecl^^t#6 != NoDecl^^null
   ==> (forall h56885004^^$o: ref :: 
    NoDecl^^$o != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
         && !old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr))[NoDecl^^$Box(NoDecl^^$o)]
       ==> !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc));
  ensures NoDecl^^t#6 != NoDecl^^null
   ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Contents), 
    NoDecl^^Set#Union(old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents)), 
      NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#7))));
  ensures NoDecl^^t#6 == NoDecl^^null
   ==> (forall h42202994^^$o: ref :: 
    NoDecl^^$o != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
       ==> !NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc));
  ensures NoDecl^^t#6 == NoDecl^^null
   ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Contents), 
    NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#7)));
  free ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
   && (NoDecl^^r#8 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#8)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#8)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#8)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#8)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h44282627^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h62999330^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.value) < NoDecl^^i#17)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#8)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#8)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#8)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#8)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h30123063^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.value)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h2672115^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.value) < NoDecl^^i#17));
  free ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#8)
   && (NoDecl^^r#8 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right))));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#8)
   && (NoDecl^^r#8 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#8)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#8)
     || (NoDecl^^r#8 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^r#8)
     - old(NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^t#6))
   == NoDecl^^deltaH#9;
  ensures NoDecl^^deltaH#9 == 0 || NoDecl^^deltaH#9 == 1;
  ensures NoDecl^^t#6 != NoDecl^^null && NoDecl^^deltaH#9 == 1
   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#8, NoDecl^^Node.balance) != 0;
  free ensures (forall<alpha> h24049039^^$o: ref, h15114764^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || (NoDecl^^t#6 != NoDecl^^null
         && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]));
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation AVLTree.InsertRecursion(h1815156^^this: ref, h16336406^^t#6: ref, h12809933^^key#7: int)
   returns (h48180537^^r#8: ref, h30971651^^deltaH#9: int)
{
  var h10309404^^$_Frame: <beta>[ref,Field beta]bool;
  var h25675773^^$nw: ref;
  var h29755367^^v#61: int;
  var h66471715^^d#10: int;
  var h61374531^^n#62: ref;
  var h15499871^^$obj0: ref;
  var h5281111^^$rhs#0: ref
   where NoDecl^^$rhs#0 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^$rhs#0, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^$rhs#0) == NoDecl^^class.Node);
  var h47530006^^$rhs#1: int;
  var h25116876^^t#63: ref;
  var h24725298^^key#64: int;
  var h21201098^^$rhs#2: Set BoxType;
  var h56592155^^$rhs#3: Set BoxType;
  var h39567352^^n#65: ref;
  var h20561848^^n#66: ref;
  var h50838910^^n#67: ref;
  var h54897010^^$rhs#4: ref;
  var h24311045^^$rhs#5: int;
  var h17472816^^$rhs#6: int;
  var h23037620^^n#68: ref;
  var h6011995^^n#69: ref;
  var h54107956^^$rhs#7: ref
   where NoDecl^^$rhs#7 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^$rhs#7, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^$rhs#7) == NoDecl^^class.Node);
  var h17209562^^n#70: ref;
  var h20668333^^$rhs#8: ref
   where NoDecl^^$rhs#8 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^$rhs#8, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^$rhs#8) == NoDecl^^class.Node);
  var h51797270^^n#71: ref;
  var h63522246^^n#72: ref;
  var h34829302^^n#73: ref;
  var h45028263^^$rhs#9: ref
   where NoDecl^^$rhs#9 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^$rhs#9, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^$rhs#9) == NoDecl^^class.Node);
  var h2601186^^$rhs#10: int;
  var h23410681^^t#74: ref;
  var h9369539^^key#75: int;
  var h17216995^^$rhs#11: Set BoxType;
  var h20735233^^$rhs#12: Set BoxType;
  var h52399374^^n#76: ref;
  var h1832323^^$rhs#13: int;
  var h16490914^^n#77: ref;
  var h14200498^^n#78: ref;
  var h60695621^^$rhs#14: ref
   where NoDecl^^$rhs#14 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^$rhs#14, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^$rhs#14) == NoDecl^^class.Node);
  var h9389685^^n#79: ref;
  var h17398306^^$rhs#15: ref
   where NoDecl^^$rhs#15 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^$rhs#15, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^$rhs#15) == NoDecl^^class.Node);
  var h22367029^^n#80: ref;
  var h67085535^^n#81: ref;

    NoDecl^^$_Frame := (lambda<alpha> h66898905^^$o: ref, h65219236^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^t#6 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
    assume true;
    if (NoDecl^^t#6 == NoDecl^^null)
    {
        assume true;
        havoc NoDecl^^$nw;
        assume NoDecl^^$nw != NoDecl^^null
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^$nw, NoDecl^^alloc)
   && NoDecl^^dtype(NoDecl^^$nw) == NoDecl^^class.Node;
        NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^$nw, NoDecl^^alloc, true);
        assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
        assume true;
        NoDecl^^v#61 := NoDecl^^key#7;
        assert (forall<alpha> h50102218^^$o: ref, h48266778^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^$nw
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
        call Node.Init(NoDecl^^$nw, NoDecl^^v#61);
        assume {:captureState "AVLTree.dfy(83,24)"} true;
        NoDecl^^r#8 := NoDecl^^$nw;
        assume {:captureState "AVLTree.dfy(83,12)"} true;
        assume true;
        assume true;
        NoDecl^^deltaH#9 := 1;
        assume {:captureState "AVLTree.dfy(84,17)"} true;
        return;
    }
    else
    {
        assume true;
        assume true;
        NoDecl^^r#8 := NoDecl^^t#6;
        assume {:captureState "AVLTree.dfy(89,12)"} true;
        assert NoDecl^^t#6 != NoDecl^^null;
        assume true;
        if (NoDecl^^key#7 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value))
        {
            assert {:subsumption 0} NoDecl^^t#6 != NoDecl^^null;
            NoDecl^^n#62 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left);
            assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left));
            assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left))]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right))]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.right)
           != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.left)
           != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))), 
            (if NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                  NoDecl^^Node.left)
                 != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                  NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.right)
               != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                  NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                  NoDecl^^Node.left)
                 != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                  NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.right)
               != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> (forall h31747823^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
              NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16
             < NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
              NoDecl^^Node.value)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> (forall h17294952^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
              NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
              NoDecl^^Node.value)
             < NoDecl^^i#17));
            assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left));
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            NoDecl^^$obj0 := NoDecl^^t#6;
            assert NoDecl^^$_Frame[NoDecl^^$obj0, NoDecl^^Node.left];
            assume true;
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            NoDecl^^t#63 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left);
            assume true;
            NoDecl^^key#64 := NoDecl^^key#7;
            assert (forall<alpha> h21436848^^$o: ref, h58713911^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^t#63 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#63, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assert NoDecl^^Set#Subset((if NoDecl^^t#63 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#63, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^t#6 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^t#6 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^t#63 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#63, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
            call NoDecl^^$rhs#0, NoDecl^^$rhs#1 := AVLTree.InsertRecursion(NoDecl^^this, NoDecl^^t#63, NoDecl^^key#64);
            NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^$obj0, NoDecl^^Node.left, NoDecl^^$rhs#0);
            assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
            NoDecl^^d#10 := NoDecl^^$rhs#1;
            assume {:captureState "AVLTree.dfy(94,26)"} true;
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            assert NoDecl^^$_Frame[NoDecl^^t#6, NoDecl^^Node.Repr];
            assert NoDecl^^t#6 != NoDecl^^null;
            assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null;
            assert NoDecl^^t#6 != NoDecl^^null;
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null)
            {
                assert NoDecl^^t#6 != NoDecl^^null;
                assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null;
            }
            else
            {
            }

            assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) == NoDecl^^null
     ==> true);
            NoDecl^^$rhs#2 := NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#6)), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
      NoDecl^^Node.Repr)), 
  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
     then NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
      NoDecl^^Node.Repr)
     else NoDecl^^Set#Empty(): Set BoxType));
            NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr, NoDecl^^$rhs#2);
            assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
            assume {:captureState "AVLTree.dfy(95,20)"} true;
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            assert NoDecl^^$_Frame[NoDecl^^t#6, NoDecl^^Node.Contents];
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            NoDecl^^$rhs#3 := NoDecl^^Set#Union(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents), 
  NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#7)));
            NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents, NoDecl^^$rhs#3);
            assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
            assume {:captureState "AVLTree.dfy(96,24)"} true;
            NoDecl^^n#65 := NoDecl^^t#6;
            assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
            assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#6)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h58663159^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value)));
            assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h58206383^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value) < NoDecl^^i#17));
            assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6);
            assume true;
            if (NoDecl^^d#10 == 0)
            {
                assert {:subsumption 0} NoDecl^^t#6 != NoDecl^^null;
                NoDecl^^n#66 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left);
                assert {:subsumption 0} NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#66);
                assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left));
                assert {:subsumption 0} NoDecl^^t#6 != NoDecl^^null;
                NoDecl^^n#67 := NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^Node.left);
                assert NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^Node.left) == NoDecl^^null
   || (NoDecl^^read(old(NoDecl^^$Heap), 
      NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^Node.left), 
      NoDecl^^alloc)
     && NoDecl^^dtype(NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^Node.left))
       == NoDecl^^class.Node);
                assert {:subsumption 0} NoDecl^^Node.Valid(old(NoDecl^^$Heap), NoDecl^^n#67);
                assume NoDecl^^Node.Height#canCall(old(NoDecl^^$Heap), 
  NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^t#6, NoDecl^^Node.left));
                assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   && old(NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assert {:subsumption 0} NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   == old(NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assume NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   == old(NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assume true;
                assume true;
                assume true;
                NoDecl^^$rhs#4 := NoDecl^^r#8;
                assume true;
                NoDecl^^$rhs#5 := 0;
                NoDecl^^r#8 := NoDecl^^$rhs#4;
                NoDecl^^deltaH#9 := NoDecl^^$rhs#5;
                assume {:captureState "AVLTree.dfy(101,7)"} true;
                return;
            }
            else
            {
            }

            assume true;
            assert NoDecl^^t#6 != NoDecl^^null;
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0)
            {
            }
            else
            {
            }

            assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0 ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) != 0 ==> true);
            NoDecl^^deltaH#9 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0
   then 1
   else 0);
            assume {:captureState "AVLTree.dfy(104,20)"} true;
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            assert NoDecl^^$_Frame[NoDecl^^t#6, NoDecl^^Node.balance];
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            NoDecl^^$rhs#6 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) - 1;
            NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance, NoDecl^^$rhs#6);
            assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
            assume {:captureState "AVLTree.dfy(105,23)"} true;
            NoDecl^^n#68 := NoDecl^^t#6;
            assert {:subsumption 0} NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#68);
            assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
            assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
            assert {:subsumption 0} NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
            assert {:subsumption 0} NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
            assert {:subsumption 0} NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
            assume NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6);
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0 - 2)
            {
                assert {:subsumption 0} NoDecl^^t#6 != NoDecl^^null;
                NoDecl^^n#69 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left);
                assert {:subsumption 0} NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#69)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#69);
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left));
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left));
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1);
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.right)));
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
                assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left));
                assert NoDecl^^t#6 != NoDecl^^null;
                assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null;
                assume true;
                if (NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
    NoDecl^^Node.balance)
   == 1)
                {
                    assert NoDecl^^t#6 != NoDecl^^null;
                    assume true;
                    NoDecl^^$obj0 := NoDecl^^t#6;
                    assert NoDecl^^$_Frame[NoDecl^^$obj0, NoDecl^^Node.left];
                    assert NoDecl^^t#6 != NoDecl^^null;
                    assume true;
                    NoDecl^^n#70 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left);
                    assert (forall<alpha> h54095401^^$o: ref, h17096567^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#70
         || (NoDecl^^n#70 != NoDecl^^null
           && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#70, NoDecl^^Node.right)))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                    call NoDecl^^$rhs#7 := Node.WeakLeftRotation(NoDecl^^n#70);
                    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^$obj0, NoDecl^^Node.left, NoDecl^^$rhs#7);
                    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
                    assume {:captureState "AVLTree.dfy(112,34)"} true;
                }
                else
                {
                }

                assume true;
                assume true;
                NoDecl^^n#71 := NoDecl^^t#6;
                assert (forall<alpha> h19651376^^$o: ref, h42644663^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#71
         || (NoDecl^^n#71 != NoDecl^^null
           && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#71, NoDecl^^Node.left)))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                call NoDecl^^$rhs#8 := Node.StrongRightRotation(NoDecl^^n#71);
                NoDecl^^r#8 := NoDecl^^$rhs#8;
                assume {:captureState "AVLTree.dfy(114,26)"} true;
                return;
            }
            else
            {
                NoDecl^^n#72 := NoDecl^^t#6;
                assert {:subsumption 0} NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#72)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#72);
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 1);
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6);
                return;
            }
        }
        else
        {
            assert NoDecl^^t#6 != NoDecl^^null;
            assume true;
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value) < NoDecl^^key#7)
            {
                assert {:subsumption 0} NoDecl^^t#6 != NoDecl^^null;
                NoDecl^^n#73 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right);
                assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right));
                assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left))]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right))]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.right)
           != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.left)
           != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))), 
            (if NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                  NoDecl^^Node.left)
                 != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                  NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                NoDecl^^Node.right)
               != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                  NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                  NoDecl^^Node.left)
                 != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                  NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                NoDecl^^Node.right)
               != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
                NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> (forall h48257652^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16
             < NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.value)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> (forall h31665688^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.value)
             < NoDecl^^i#17));
                assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right));
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                NoDecl^^$obj0 := NoDecl^^t#6;
                assert NoDecl^^$_Frame[NoDecl^^$obj0, NoDecl^^Node.right];
                assume true;
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                NoDecl^^t#74 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right);
                assume true;
                NoDecl^^key#75 := NoDecl^^key#7;
                assert (forall<alpha> h16555740^^$o: ref, h14783937^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^t#74 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#74, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                assert NoDecl^^Set#Subset((if NoDecl^^t#74 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#74, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^t#6 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^t#6 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^t#74 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#74, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
                call NoDecl^^$rhs#9, NoDecl^^$rhs#10 := AVLTree.InsertRecursion(NoDecl^^this, NoDecl^^t#74, NoDecl^^key#75);
                NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^$obj0, NoDecl^^Node.right, NoDecl^^$rhs#9);
                assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
                NoDecl^^d#10 := NoDecl^^$rhs#10;
                assume {:captureState "AVLTree.dfy(126,27)"} true;
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                assert NoDecl^^$_Frame[NoDecl^^t#6, NoDecl^^Node.Repr];
                assert NoDecl^^t#6 != NoDecl^^null;
                assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null;
                assert NoDecl^^t#6 != NoDecl^^null;
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null)
                {
                    assert NoDecl^^t#6 != NoDecl^^null;
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null;
                }
                else
                {
                }

                assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) == NoDecl^^null
     ==> true);
                NoDecl^^$rhs#11 := NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#6)), 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
      NoDecl^^Node.Repr)), 
  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
     then NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
      NoDecl^^Node.Repr)
     else NoDecl^^Set#Empty(): Set BoxType));
                NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr, NoDecl^^$rhs#11);
                assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
                assume {:captureState "AVLTree.dfy(127,20)"} true;
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                assert NoDecl^^$_Frame[NoDecl^^t#6, NoDecl^^Node.Contents];
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                NoDecl^^$rhs#12 := NoDecl^^Set#Union(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents), 
  NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^key#7)));
                NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents, NoDecl^^$rhs#12);
                assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
                assume {:captureState "AVLTree.dfy(128,24)"} true;
                NoDecl^^n#76 := NoDecl^^t#6;
                assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left))]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^t#6)]);
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^t#6)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h65946577^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value)));
                assert {:subsumption 0} NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h56648283^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value) < NoDecl^^i#17));
                assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^t#6);
                assume true;
                if (NoDecl^^d#10 == 0)
                {
                    assume true;
                    assume true;
                    NoDecl^^deltaH#9 := 0;
                    assume {:captureState "AVLTree.dfy(132,23)"} true;
                    return;
                }
                else
                {
                }

                assume true;
                assert NoDecl^^t#6 != NoDecl^^null;
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0)
                {
                }
                else
                {
                }

                assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0 ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) != 0 ==> true);
                NoDecl^^deltaH#9 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0
   then 1
   else 0);
                assume {:captureState "AVLTree.dfy(136,20)"} true;
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                assert NoDecl^^$_Frame[NoDecl^^t#6, NoDecl^^Node.balance];
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                NoDecl^^$rhs#13 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) + NoDecl^^d#10;
                NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance, NoDecl^^$rhs#13);
                assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
                assume {:captureState "AVLTree.dfy(137,23)"} true;
                NoDecl^^n#77 := NoDecl^^t#6;
                assert {:subsumption 0} NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#77);
                assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assert {:subsumption 0} NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assert {:subsumption 0} NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assert {:subsumption 0} NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
                assume NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^t#6);
                assert NoDecl^^t#6 != NoDecl^^null;
                assume true;
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 2)
                {
                    assert {:subsumption 0} NoDecl^^t#6 != NoDecl^^null;
                    NoDecl^^n#78 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right);
                    assert {:subsumption 0} NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#78)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#78);
                    assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right));
                    assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right));
                    assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1);
                    assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.right)));
                    assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
                    assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right));
                    assert NoDecl^^t#6 != NoDecl^^null;
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right) != NoDecl^^null;
                    assume true;
                    if (NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right), 
    NoDecl^^Node.balance)
   == 0 - 1)
                    {
                        assert NoDecl^^t#6 != NoDecl^^null;
                        assume true;
                        NoDecl^^$obj0 := NoDecl^^t#6;
                        assert NoDecl^^$_Frame[NoDecl^^$obj0, NoDecl^^Node.right];
                        assert NoDecl^^t#6 != NoDecl^^null;
                        assume true;
                        NoDecl^^n#79 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right);
                        assert (forall<alpha> h40072506^^$o: ref, h25108238^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#79
         || (NoDecl^^n#79 != NoDecl^^null
           && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#79, NoDecl^^Node.left)))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                        call NoDecl^^$rhs#14 := Node.WeakRightRotation(NoDecl^^n#79);
                        NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^$obj0, NoDecl^^Node.right, NoDecl^^$rhs#14);
                        assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
                        assume {:captureState "AVLTree.dfy(145,35)"} true;
                    }
                    else
                    {
                    }

                    assume true;
                    assume true;
                    NoDecl^^n#80 := NoDecl^^t#6;
                    assert (forall<alpha> h24647552^^$o: ref, h20501377^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#80
         || (NoDecl^^n#80 != NoDecl^^null
           && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#80, NoDecl^^Node.right)))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                    call NoDecl^^$rhs#15 := Node.StrongLeftRotation(NoDecl^^n#80);
                    NoDecl^^r#8 := NoDecl^^$rhs#15;
                    assume {:captureState "AVLTree.dfy(147,26)"} true;
                    return;
                }
                else
                {
                }

                NoDecl^^n#81 := NoDecl^^t#6;
                assert {:subsumption 0} NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#81)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#81);
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6);
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.balance) == 1);
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.right)));
                assert {:subsumption 0} NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^t#6)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6)
     || (NoDecl^^t#6 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.left)));
                assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^t#6);
                return;
            }
            else
            {
                assert {:subsumption 0} NoDecl^^t#6 != NoDecl^^null;
                assume true;
                assert NoDecl^^key#7 == NoDecl^^read(NoDecl^^$Heap, NoDecl^^t#6, NoDecl^^Node.value);
                assume true;
                assume true;
                NoDecl^^deltaH#9 := 0;
                assume {:captureState "AVLTree.dfy(156,20)"} true;
                return;
            }
        }
    }
}



const unique h50294666^^class.Node: ClassName;

const unique h49998812^^Node.value: Field int;

const unique h47336128^^Node.balance: Field int;

const unique h23371976^^Node.left: Field ref;

axiom (forall h9021196^^$h: HeapType, h14081900^^$o: ref :: 
  { NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.left) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h)
       && NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.left) == NoDecl^^null
       || (NoDecl^^read(NoDecl^^$h, 
          NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.left), 
          NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.left))
           == NoDecl^^class.Node));

const unique h59628243^^Node.right: Field ref;

axiom (forall h66892145^^$h: HeapType, h65158399^^$o: ref :: 
  { NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.right) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h)
       && NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.right) == NoDecl^^null
       || (NoDecl^^read(NoDecl^^$h, 
          NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.right), 
          NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.right))
           == NoDecl^^class.Node));

const unique h49554687^^Node.Contents: Field (Set BoxType);

const unique h43339000^^Node.Repr: Field (Set BoxType);

axiom (forall h54506685^^$h: HeapType, h20798117^^$o: ref :: 
  { NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.Repr) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h)
       && NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^alloc)
     ==> (forall h52965331^^$t#1: BoxType :: 
      { NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.Repr)[NoDecl^^$t#1] } 
      NoDecl^^read(NoDecl^^$h, NoDecl^^$o, NoDecl^^Node.Repr)[NoDecl^^$t#1]
         ==> NoDecl^^$Unbox(NoDecl^^$t#1): ref == NoDecl^^null
           || (NoDecl^^read(NoDecl^^$h, NoDecl^^$Unbox(NoDecl^^$t#1): ref, NoDecl^^alloc)
             && NoDecl^^dtype(NoDecl^^$Unbox(NoDecl^^$t#1): ref) == NoDecl^^class.Node)));

procedure CheckWellformed$$Node.Init(h6925935^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.Node, 
    h62333418^^v#11: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$Node.Init(h24129853^^this: ref, h15842089^^v#11: int)
{
  var h8361080^^$_Frame: <beta>[ref,Field beta]bool;
  var h8140857^^n#82: ref;
  var h6158855^^n#83: ref;
  var h55429698^^n#84: ref;

    NoDecl^^$_Frame := (lambda<alpha> h29105235^^$o: ref, h60620523^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^this);
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h8713795^^$o: ref, h11315292^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^this);
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    NoDecl^^n#82 := NoDecl^^this;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this))
    {
        NoDecl^^n#83 := NoDecl^^this;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#83);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^this);
    }

    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^this))
    {
        NoDecl^^n#84 := NoDecl^^this;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#84)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#84);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^this);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^this);
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) == NoDecl^^null)
    {
    }

    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) == NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) == NoDecl^^null;
    assume NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Contents), 
  NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^v#11)));
}



procedure Node.Init(h34728767^^this: ref
       where NoDecl^^this != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^alloc)
         && NoDecl^^dtype(NoDecl^^this) == NoDecl^^class.Node, 
    h44123454^^v#11: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  free ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
   && (NoDecl^^this != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^this)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^this)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^this)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^this)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h61566768^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h17230008^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.value) < NoDecl^^i#17)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^this)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^this)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^this)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^this)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h20852350^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.value)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h53453427^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.value) < NoDecl^^i#17));
  free ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^this)
   && (NoDecl^^this != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right))));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^this)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^this)
   && (NoDecl^^this != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance) == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^this)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^this)
     || (NoDecl^^this != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left)));
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left) == NoDecl^^null;
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right) == NoDecl^^null;
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Contents), 
  NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^v#11)));
  free ensures (forall<alpha> h11318800^^$o: ref, h34760343^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^this);
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation Node.Init(h44407631^^this: ref, h64124362^^v#11: int)
{
  var h40248354^^$_Frame: <beta>[ref,Field beta]bool;
  var h26690871^^$rhs#0: Set BoxType;
  var h38891250^^$rhs#1: Set BoxType;
  var h14476932^^$rhs#2: ref;
  var h63183526^^$rhs#3: ref;
  var h31780825^^$rhs#4: int;
  var h17591975^^$rhs#5: int;

    NoDecl^^$_Frame := (lambda<alpha> h24110047^^$o: ref, h15663836^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^this);
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^Node.Repr];
    assume true;
    NoDecl^^$rhs#0 := NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^this));
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Repr, NoDecl^^$rhs#0);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(178,12)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^Node.Contents];
    assume true;
    NoDecl^^$rhs#1 := NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^v#11));
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.Contents, NoDecl^^$rhs#1);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(179,16)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^Node.left];
    assume true;
    NoDecl^^$rhs#2 := NoDecl^^null;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.left, NoDecl^^$rhs#2);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(180,12)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^Node.right];
    assume true;
    NoDecl^^$rhs#3 := NoDecl^^null;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.right, NoDecl^^$rhs#3);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(181,13)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^Node.value];
    assume true;
    NoDecl^^$rhs#4 := NoDecl^^v#11;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.value, NoDecl^^$rhs#4);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(182,13)"} true;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^this, NoDecl^^Node.balance];
    assume true;
    NoDecl^^$rhs#5 := 0;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^this, NoDecl^^Node.balance, NoDecl^^$rhs#5);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(183,15)"} true;
}



function h6756797^^Node.Balanced(h60811181^^$heap: HeapType, h10429724^^n#12: ref) : bool;

function h26758660^^Node.Balanced#limited(h39501348^^$heap: HeapType, h19967814^^n#12: ref) : bool;

function h45492604^^Node.Balanced#2(h6780253^^$heap: HeapType, h61022284^^n#12: ref) : bool;

function h12329649^^Node.Balanced#canCall(h43857981^^$heap: HeapType, h59177513^^n#12: ref) : bool;

axiom (forall h62835574^^$Heap: HeapType, h28649262^^n#12: ref :: 
  { NoDecl^^Node.Balanced#2(NoDecl^^$Heap, NoDecl^^n#12) } 
  NoDecl^^Node.Balanced#2(NoDecl^^$Heap, NoDecl^^n#12)
     == NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#12));

axiom (forall h56516768^^$Heap: HeapType, h38888871^^n#12: ref :: 
  { NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#12) } 
  NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#12)
     == NoDecl^^Node.Balanced#limited(NoDecl^^$Heap, NoDecl^^n#12));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (6 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h14455523^^$Heap: HeapType, h62990845^^n#12: ref :: 
    { NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#12) } 
    NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#12)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 6 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#12 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#12) == NoDecl^^class.Node))
           && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#12)
           && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#12))
       ==> (NoDecl^^n#12 != NoDecl^^null
           ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
                 || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
                 || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1
               ==> NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right)))
             && ((
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
                   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
                   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1)
                 && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right))
               ==> NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.left))))
         && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#12)
           == (NoDecl^^n#12 != NoDecl^^null
             ==> (
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
                 || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
                 || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1)
               && NoDecl^^Node.Balanced#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right))
               && NoDecl^^Node.Balanced#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.left))));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (6 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h30046694^^$Heap: HeapType, h1984791^^n#12: ref :: 
    { NoDecl^^Node.Balanced#2(NoDecl^^$Heap, NoDecl^^n#12) } 
    NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#12)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 6 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#12 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#12) == NoDecl^^class.Node))
           && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#12)
           && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#12))
       ==> NoDecl^^Node.Balanced#2(NoDecl^^$Heap, NoDecl^^n#12)
         == (NoDecl^^n#12 != NoDecl^^null
           ==> (
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
               || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
               || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1)
             && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right))
             && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.left))));

axiom (forall h17863121^^$h0: HeapType, h26550365^^$h1: HeapType, h37626701^^n#12: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.Balanced(NoDecl^^$h1, NoDecl^^n#12) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#12 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#12, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#12) == NoDecl^^class.Node))
       && (NoDecl^^n#12 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#12, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#12) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h3095993^^$o: ref, h27863937^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && (NoDecl^^$o == NoDecl^^n#12
             || (NoDecl^^n#12 != NoDecl^^null
               && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#12, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.Balanced(NoDecl^^$h0, NoDecl^^n#12)
       == NoDecl^^Node.Balanced(NoDecl^^$h1, NoDecl^^n#12));

axiom (forall h49448848^^$h0: HeapType, h42386454^^$h1: HeapType, h45933772^^n#12: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.Balanced#limited(NoDecl^^$h1, NoDecl^^n#12) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#12 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#12, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#12) == NoDecl^^class.Node))
       && (NoDecl^^n#12 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#12, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#12) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h10750772^^$o: ref, h29648085^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && (NoDecl^^$o == NoDecl^^n#12
             || (NoDecl^^n#12 != NoDecl^^null
               && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#12, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.Balanced#limited(NoDecl^^$h0, NoDecl^^n#12)
       == NoDecl^^Node.Balanced#limited(NoDecl^^$h1, NoDecl^^n#12));

procedure CheckWellformed$$Node.Balanced(h65506178^^n#12: ref
       where NoDecl^^n#12 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#12) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && 6 == NoDecl^^$FunctionContextHeight;



implementation CheckWellformed$$Node.Balanced(h52684690^^n#12: ref)
{
  var h4400168^^n#85: ref;
  var h39601516^^n#86: ref;
  var h20869327^^$_Frame: <beta>[ref,Field beta]bool;
  var h53606218^^n#87: ref;
  var h12693918^^n#88: ref;

    NoDecl^^n#85 := NoDecl^^n#12;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#12);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#12))
    {
        NoDecl^^n#86 := NoDecl^^n#12;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#86);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#12);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#12)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#12);
    if (NoDecl^^n#12 != NoDecl^^null)
    {
        assert NoDecl^^n#12 != NoDecl^^null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        NoDecl^^$_Frame := (lambda<alpha> h47136405^^$o: ref, h21574462^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#12
       || (NoDecl^^n#12 != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]));
        if (NoDecl^^n#12 != NoDecl^^null)
        {
            assert NoDecl^^n#12 != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^n#12, NoDecl^^Node.balance];
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1)
            {
                assert NoDecl^^n#12 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#12, NoDecl^^Node.right];
                NoDecl^^n#87 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right);
                assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#87)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#87);
                assert (forall<alpha> h59952436^^$o: ref, h2701015^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#87
         || (NoDecl^^n#87 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#87, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                assert NoDecl^^Set#Subset((if NoDecl^^n#87 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#87, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#12 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#12 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#87 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#87, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right));
            }

            if ((
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
     || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right)))
            {
                assert NoDecl^^n#12 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#12, NoDecl^^Node.left];
                NoDecl^^n#88 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.left);
                assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#88)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#88);
                assert (forall<alpha> h24309136^^$o: ref, h17455632^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#88
         || (NoDecl^^n#88 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#88, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                assert NoDecl^^Set#Subset((if NoDecl^^n#88 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#88, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#12 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#12 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#88 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#88, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
                assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.left));
            }
        }

        assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#12)
   == (NoDecl^^n#12 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.left)));
        assume NoDecl^^n#12 != NoDecl^^null
   ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1
       ==> NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right)))
     && ((
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0 - 1
           || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 0
           || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.balance) == 1)
         && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.right))
       ==> NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#12, NoDecl^^Node.left)));
    }
}



function h22882960^^Node.BalanceValid(h4620049^^$heap: HeapType, h41580444^^n#13: ref) : bool;

function h38679683^^Node.BalanceValid#limited(h12572829^^$heap: HeapType, h46046605^^n#13: ref) : bool;

function h11766267^^Node.BalanceValid#2(h38787544^^$heap: HeapType, h13543581^^n#13: ref) : bool;

function h54783372^^Node.BalanceValid#canCall(h23288300^^$heap: HeapType, h8268111^^n#13: ref) : bool;

axiom (forall h7304143^^$Heap: HeapType, h65737292^^n#13: ref :: 
  { NoDecl^^Node.BalanceValid#2(NoDecl^^$Heap, NoDecl^^n#13) } 
  NoDecl^^Node.BalanceValid#2(NoDecl^^$Heap, NoDecl^^n#13)
     == NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#13));

axiom (forall h54764719^^$Heap: HeapType, h23120425^^n#13: ref :: 
  { NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#13) } 
  NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#13)
     == NoDecl^^Node.BalanceValid#limited(NoDecl^^$Heap, NoDecl^^n#13));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (5 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h6757235^^$Heap: HeapType, h60815118^^n#13: ref :: 
    { NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#13) } 
    NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#13)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 5 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#13 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#13) == NoDecl^^class.Node))
           && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#13))
       ==> (NoDecl^^n#13 != NoDecl^^null
           ==> NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
             && NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
                 == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
                   - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
               ==> 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
               ==> NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
                   == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
                     - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
               ==> 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right) != NoDecl^^null
               ==> NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))))
         && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#13)
           == (NoDecl^^n#13 != NoDecl^^null
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
                 == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
                   - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
               && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
                 ==> NoDecl^^Node.BalanceValid#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
               && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right) != NoDecl^^null
                 ==> NoDecl^^Node.BalanceValid#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right)))));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (5 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h10465156^^$Heap: HeapType, h27077540^^n#13: ref :: 
    { NoDecl^^Node.BalanceValid#2(NoDecl^^$Heap, NoDecl^^n#13) } 
    NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#13)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 5 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#13 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#13) == NoDecl^^class.Node))
           && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#13))
       ==> NoDecl^^Node.BalanceValid#2(NoDecl^^$Heap, NoDecl^^n#13)
         == (NoDecl^^n#13 != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
               == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
                 - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
               ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right) != NoDecl^^null
               ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right)))));

axiom (forall h42371273^^$h0: HeapType, h45797138^^$h1: HeapType, h9521066^^n#13: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.BalanceValid(NoDecl^^$h1, NoDecl^^n#13) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#13 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#13, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#13) == NoDecl^^class.Node))
       && (NoDecl^^n#13 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#13, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#13) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h18580737^^$o: ref, h33008913^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && (NoDecl^^$o == NoDecl^^n#13
             || (NoDecl^^n#13 != NoDecl^^null
               && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#13, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.BalanceValid(NoDecl^^$h0, NoDecl^^n#13)
       == NoDecl^^Node.BalanceValid(NoDecl^^$h1, NoDecl^^n#13));

axiom (forall h28644761^^$h0: HeapType, h56476259^^$h1: HeapType, h38524289^^n#13: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.BalanceValid#limited(NoDecl^^$h1, NoDecl^^n#13) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#13 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#13, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#13) == NoDecl^^class.Node))
       && (NoDecl^^n#13 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#13, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#13) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h11174282^^$o: ref, h33459681^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && (NoDecl^^$o == NoDecl^^n#13
             || (NoDecl^^n#13 != NoDecl^^null
               && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#13, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.BalanceValid#limited(NoDecl^^$h0, NoDecl^^n#13)
       == NoDecl^^Node.BalanceValid#limited(NoDecl^^$h1, NoDecl^^n#13));

procedure CheckWellformed$$Node.BalanceValid(h32701678^^n#13: ref
       where NoDecl^^n#13 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#13) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && 5 == NoDecl^^$FunctionContextHeight;



implementation CheckWellformed$$Node.BalanceValid(h25879650^^n#13: ref)
{
  var h31590262^^n#89: ref;
  var h15876907^^$_Frame: <beta>[ref,Field beta]bool;
  var h8674443^^n#90: ref;
  var h10961125^^n#91: ref;
  var h31541268^^n#92: ref;
  var h15435960^^n#93: ref;

    NoDecl^^n#89 := NoDecl^^n#13;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#13);
    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#13);
    if (NoDecl^^n#13 != NoDecl^^null)
    {
        assert NoDecl^^n#13 != NoDecl^^null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        NoDecl^^$_Frame := (lambda<alpha> h4705914^^$o: ref, h42353227^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#13
       || (NoDecl^^n#13 != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]));
        if (NoDecl^^n#13 != NoDecl^^null)
        {
            assert NoDecl^^n#13 != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^n#13, NoDecl^^Node.balance];
            assert NoDecl^^n#13 != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^n#13, NoDecl^^Node.right];
            NoDecl^^n#90 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right);
            assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#90);
            assert (forall<alpha> h45634724^^$o: ref, h8059334^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^n#90 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#90, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right));
            assert NoDecl^^n#13 != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^n#13, NoDecl^^Node.left];
            NoDecl^^n#91 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left);
            assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#91);
            assert (forall<alpha> h5425146^^$o: ref, h48826322^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^n#91 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#91, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left));
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
   == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
     - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
            {
                assert NoDecl^^n#13 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#13, NoDecl^^Node.left];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null)
                {
                    assert NoDecl^^n#13 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#13, NoDecl^^Node.left];
                    NoDecl^^n#92 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left);
                    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#92);
                    assert (forall<alpha> h36783718^^$o: ref, h62618006^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#92
         || (NoDecl^^n#92 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#92, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                    assert NoDecl^^Set#Subset((if NoDecl^^n#92 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#92, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#13 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#13 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#92 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#92, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
                    assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left));
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
     == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
       - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))))
            {
                assert NoDecl^^n#13 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#13, NoDecl^^Node.right];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right) != NoDecl^^null)
                {
                    assert NoDecl^^n#13 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#13, NoDecl^^Node.right];
                    NoDecl^^n#93 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right);
                    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#93);
                    assert (forall<alpha> h26691149^^$o: ref, h38893755^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#93
         || (NoDecl^^n#93 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#93, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                    assert NoDecl^^Set#Subset((if NoDecl^^n#93 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#93, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#13 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#13 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#93 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#93, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
                    assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right));
                }
            }
        }

        assume NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#13)
   == (NoDecl^^n#13 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))));
        assume NoDecl^^n#13 != NoDecl^^null
   ==> NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
     && NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.balance)
           == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right))
             - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.left)))
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#13, NoDecl^^Node.right)));
    }
}



function h14499481^^Node.Height(h63386473^^$heap: HeapType, h33607346^^n#14: ref) : int;

function h34030663^^Node.Height#limited(h37840511^^$heap: HeapType, h5020285^^n#14: ref) : int;

function h45182569^^Node.Height#2(h3989940^^$heap: HeapType, h35909463^^n#14: ref) : int;

function h54749715^^Node.Height#canCall(h22985394^^$heap: HeapType, h5541955^^n#14: ref) : bool;

axiom (forall h49877601^^$Heap: HeapType, h46245228^^n#14: ref :: 
  { NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#14) } 
  NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#14)
     == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#14));

axiom (forall h13553869^^$Heap: HeapType, h54875957^^n#14: ref :: 
  { NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#14) } 
  NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#14)
     == NoDecl^^Node.Height#limited(NoDecl^^$Heap, NoDecl^^n#14));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (4 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h24121565^^$Heap: HeapType, h15767494^^n#14: ref :: 
    { NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#14) } 
    NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^n#14)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 4 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#14 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#14) == NoDecl^^class.Node))
           && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#14))
       ==> (NoDecl^^n#14 == NoDecl^^null ==> true)
         && (NoDecl^^n#14 != NoDecl^^null
           ==> NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left))
             && NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right))
             && NoDecl^^Math.max#canCall(NoDecl^^$Heap, 
              NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left)), 
              NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right))))
         && NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#14)
           == (if NoDecl^^n#14 == NoDecl^^null
             then 0
             else NoDecl^^Math.max(NoDecl^^$Heap, 
                NoDecl^^Node.Height#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left)), 
                NoDecl^^Node.Height#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right)))
               + 1)
         && 0 <= NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#14));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (4 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h7689721^^$Heap: HeapType, h2098632^^n#14: ref :: 
    { NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#14) } 
    NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^n#14)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 4 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#14 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#14) == NoDecl^^class.Node))
           && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#14))
       ==> NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#14)
         == (if NoDecl^^n#14 == NoDecl^^null
           then 0
           else NoDecl^^Math.max(NoDecl^^$Heap, 
              NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left)), 
              NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right)))
             + 1));

axiom (forall h18887690^^$h0: HeapType, h35771490^^$h1: HeapType, h53507960^^n#14: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.Height(NoDecl^^$h1, NoDecl^^n#14) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#14 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#14, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#14) == NoDecl^^class.Node))
       && (NoDecl^^n#14 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#14, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#14) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h11809597^^$o: ref, h39177514^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^n#14 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#14, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.Height(NoDecl^^$h0, NoDecl^^n#14)
       == NoDecl^^Node.Height(NoDecl^^$h1, NoDecl^^n#14));

axiom (forall h17053313^^$h0: HeapType, h19262089^^$h1: HeapType, h39141076^^n#14: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.Height#limited(NoDecl^^$h1, NoDecl^^n#14) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#14 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#14, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#14) == NoDecl^^class.Node))
       && (NoDecl^^n#14 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#14, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#14) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h16725372^^$o: ref, h16310625^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^n#14 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#14, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.Height#limited(NoDecl^^$h0, NoDecl^^n#14)
       == NoDecl^^Node.Height#limited(NoDecl^^$h1, NoDecl^^n#14));

procedure CheckWellformed$$Node.Height(h12577900^^n#14: ref
       where NoDecl^^n#14 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#14) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && 4 == NoDecl^^$FunctionContextHeight;



implementation CheckWellformed$$Node.Height(h46092238^^n#14: ref)
{
  var h12176960^^n#94: ref;
  var h42483779^^$_Frame: <beta>[ref,Field beta]bool;
  var h46809697^^n#95: ref;
  var h18634089^^n#96: ref;
  var h33489078^^a#97: int;
  var h32966247^^b#98: int;

    NoDecl^^n#94 := NoDecl^^n#14;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#14);
    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#14);
    if (NoDecl^^n#14 != NoDecl^^null)
    {
        assert NoDecl^^n#14 != NoDecl^^null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        NoDecl^^$_Frame := (lambda<alpha> h28260775^^$o: ref, h53020390^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^n#14 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]);
        if (NoDecl^^n#14 == NoDecl^^null)
        {
        }
        else
        {
            assert NoDecl^^n#14 != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^n#14, NoDecl^^Node.left];
            NoDecl^^n#95 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left);
            assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#95);
            assert (forall<alpha> h7421470^^$o: ref, h66793230^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^n#95 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#95, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assert NoDecl^^Set#Subset((if NoDecl^^n#95 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#95, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#14 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#14 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#95 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#95, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
            assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left));
            assert NoDecl^^n#14 != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^n#14, NoDecl^^Node.right];
            NoDecl^^n#96 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right);
            assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#96);
            assert (forall<alpha> h64268160^^$o: ref, h41542534^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^n#96 != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#96, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assert NoDecl^^Set#Subset((if NoDecl^^n#96 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#96, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#14 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#14 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#96 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#96, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
            assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right));
            assert 0
   <= NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left));
            NoDecl^^a#97 := NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left));
            assert 0
   <= NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right));
            NoDecl^^b#98 := NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right));
            assert (forall<alpha> h38338487^^$o: ref, h9502070^^$f: Field alpha :: 
  false ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
            assume NoDecl^^Math.max#canCall(NoDecl^^$Heap, 
  NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left)), 
  NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right)));
        }

        assert 0
   <= (if NoDecl^^n#14 == NoDecl^^null
     then 0
     else NoDecl^^Math.max(NoDecl^^$Heap, 
        NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left)), 
        NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right)))
       + 1);
        assume NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#14)
   == (if NoDecl^^n#14 == NoDecl^^null
     then 0
     else NoDecl^^Math.max(NoDecl^^$Heap, 
        NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left)), 
        NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right)))
       + 1);
        assume (NoDecl^^n#14 == NoDecl^^null ==> true)
   && (NoDecl^^n#14 != NoDecl^^null
     ==> NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left))
       && NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right))
       && NoDecl^^Math.max#canCall(NoDecl^^$Heap, 
        NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.left)), 
        NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#14, NoDecl^^Node.right))));
    }
}



function h18409771^^Node.Valid(h31470215^^$heap: HeapType, h14796483^^n#15: ref) : bool;

function h66059488^^Node.Valid#limited(h57664488^^$heap: HeapType, h49218346^^n#15: ref) : bool;

function h40311937^^Node.Valid#2(h27263117^^$heap: HeapType, h44041463^^n#15: ref) : bool;

function h60828848^^Node.Valid#canCall(h10588721^^$heap: HeapType, h28189627^^n#15: ref) : bool;

axiom (forall h52380055^^$Heap: HeapType, h1658455^^n#15: ref :: 
  { NoDecl^^Node.Valid#2(NoDecl^^$Heap, NoDecl^^n#15) } 
  NoDecl^^Node.Valid#2(NoDecl^^$Heap, NoDecl^^n#15)
     == NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#15));

axiom (forall h14926099^^$Heap: HeapType, h117163^^n#15: ref :: 
  { NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#15) } 
  NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#15)
     == NoDecl^^Node.Valid#limited(NoDecl^^$Heap, NoDecl^^n#15));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (2 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h1054474^^$Heap: HeapType, h9490272^^n#15: ref :: 
    { NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#15) } 
    NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#15)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 2 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#15 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#15) == NoDecl^^class.Node)))
       ==> (NoDecl^^n#15 != NoDecl^^null
           ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
               ==> true)
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
               ==> 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
               ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                   ==> true))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
               ==> 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                   ==> true))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
               ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
                 && (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
                   ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
               ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                     && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> true))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                     && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr), 
                    NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)))
               ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) == NoDecl^^null
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) == NoDecl^^null
                   ==> true))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                     && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr), 
                    NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)))
                 && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
                  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
                      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                         then NoDecl^^read(NoDecl^^$Heap, 
                          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                          NoDecl^^Node.Repr)
                         else NoDecl^^Set#Empty(): Set BoxType)), 
                    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                       then NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr)
                       else NoDecl^^Set#Empty(): Set BoxType)))
               ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) == NoDecl^^null
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> true)
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) == NoDecl^^null
                   ==> true))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                     && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr), 
                    NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)))
                 && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
                  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
                      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                         then NoDecl^^read(NoDecl^^$Heap, 
                          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                          NoDecl^^Node.Repr)
                         else NoDecl^^Set#Empty(): Set BoxType)), 
                    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                       then NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr)
                       else NoDecl^^Set#Empty(): Set BoxType)))
                 && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
                  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
                        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
                      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                         then NoDecl^^read(NoDecl^^$Heap, 
                          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                          NoDecl^^Node.Contents)
                         else NoDecl^^Set#Empty(): Set BoxType)), 
                    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                       then NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Contents)
                       else NoDecl^^Set#Empty(): Set BoxType)))
               ==> 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
               ==> (forall h18303590^^i#16: int :: 
                true
                   ==> 
                  NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                    NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
                   ==> true))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                     && !NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                     && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr), 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
                 && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                     && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr), 
                    NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)))
                 && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
                  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
                      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                         then NoDecl^^read(NoDecl^^$Heap, 
                          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                          NoDecl^^Node.Repr)
                         else NoDecl^^Set#Empty(): Set BoxType)), 
                    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                       then NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Repr)
                       else NoDecl^^Set#Empty(): Set BoxType)))
                 && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
                  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
                        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
                      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                         then NoDecl^^read(NoDecl^^$Heap, 
                          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                          NoDecl^^Node.Contents)
                         else NoDecl^^Set#Empty(): Set BoxType)), 
                    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                       then NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                        NoDecl^^Node.Contents)
                       else NoDecl^^Set#Empty(): Set BoxType)))
                 && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                   ==> (forall h30514590^^i#16: int :: 
                    true
                       ==> 
                      NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
                       ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value)))
               ==> 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               ==> (forall h6195855^^i#17: int :: 
                true
                   ==> 
                  NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                    NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
                   ==> true)))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#15)
           == (NoDecl^^n#15 != NoDecl^^null
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
               && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
               && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                   && !NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                    NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                   && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr), 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
               && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                 ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                   && !NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                    NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                   && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr), 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
               && NoDecl^^Node.Valid#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
               && NoDecl^^Node.Valid#limited(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
               && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                    NoDecl^^Node.Repr), 
                  NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                    NoDecl^^Node.Repr)))
               && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
                NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
                    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                       then NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Repr)
                       else NoDecl^^Set#Empty(): Set BoxType)), 
                  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                     then NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Repr)
                     else NoDecl^^Set#Empty(): Set BoxType)))
               && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
                NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
                      NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
                    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                       then NoDecl^^read(NoDecl^^$Heap, 
                        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                        NoDecl^^Node.Contents)
                       else NoDecl^^Set#Empty(): Set BoxType)), 
                  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                     then NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Contents)
                     else NoDecl^^Set#Empty(): Set BoxType)))
               && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 ==> (forall h55762700^^i#16: int :: 
                  true
                     ==> 
                    NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
                     ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value)))
               && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                 ==> (forall h32102252^^i#17: int :: 
                  true
                     ==> 
                    NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                      NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
                     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value) < NoDecl^^i#17))));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (2 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h20484818^^$Heap: HeapType, h50145638^^n#15: ref :: 
    { NoDecl^^Node.Valid#2(NoDecl^^$Heap, NoDecl^^n#15) } 
    NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#15)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 2 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && (NoDecl^^n#15 == NoDecl^^null
             || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^alloc)
               && NoDecl^^dtype(NoDecl^^n#15) == NoDecl^^class.Node)))
       ==> NoDecl^^Node.Valid#2(NoDecl^^$Heap, NoDecl^^n#15)
         == (NoDecl^^n#15 != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
               ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
                 && !NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                  NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                    NoDecl^^Node.Repr), 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
                 && !NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                  NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
                 && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                    NoDecl^^Node.Repr), 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
             && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
             && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                 && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
               ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                  NoDecl^^Node.Repr), 
                NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                  NoDecl^^Node.Repr)))
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
              NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
                  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                     then NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Repr)
                     else NoDecl^^Set#Empty(): Set BoxType)), 
                (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   then NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                    NoDecl^^Node.Repr)
                   else NoDecl^^Set#Empty(): Set BoxType)))
             && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
              NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
                    NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
                  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                     then NoDecl^^read(NoDecl^^$Heap, 
                      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                      NoDecl^^Node.Contents)
                     else NoDecl^^Set#Empty(): Set BoxType)), 
                (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
                   then NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                    NoDecl^^Node.Contents)
                   else NoDecl^^Set#Empty(): Set BoxType)))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
               ==> (forall h48657561^^i#16: int :: 
                true
                   ==> 
                  NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                    NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
                   ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value)))
             && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               ==> (forall h35264868^^i#17: int :: 
                true
                   ==> 
                  NoDecl^^read(NoDecl^^$Heap, 
                    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                    NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
                   ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value) < NoDecl^^i#17))));

axiom (forall h48948360^^$h0: HeapType, h37882063^^$h1: HeapType, h5394248^^n#15: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.Valid(NoDecl^^$h1, NoDecl^^n#15) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#15 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#15, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#15) == NoDecl^^class.Node))
       && (NoDecl^^n#15 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#15, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#15) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h48548238^^$o: ref, h34280961^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && (NoDecl^^$o == NoDecl^^n#15
             || (NoDecl^^n#15 != NoDecl^^null
               && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.Valid(NoDecl^^$h0, NoDecl^^n#15)
       == NoDecl^^Node.Valid(NoDecl^^$h1, NoDecl^^n#15));

axiom (forall h40093194^^$h0: HeapType, h25294426^^$h1: HeapType, h26323242^^n#15: ref :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Node.Valid#limited(NoDecl^^$h1, NoDecl^^n#15) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && (NoDecl^^n#15 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h0, NoDecl^^n#15, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#15) == NoDecl^^class.Node))
       && (NoDecl^^n#15 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$h1, NoDecl^^n#15, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#15) == NoDecl^^class.Node))
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h35582587^^$o: ref, h51807830^^$f: Field alpha :: 
      NoDecl^^$o != NoDecl^^null
           && NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^alloc)
           && NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^alloc)
           && (NoDecl^^$o == NoDecl^^n#15
             || (NoDecl^^n#15 != NoDecl^^null
               && NoDecl^^read(NoDecl^^$h0, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Node.Valid#limited(NoDecl^^$h0, NoDecl^^n#15)
       == NoDecl^^Node.Valid#limited(NoDecl^^$h1, NoDecl^^n#15));

procedure CheckWellformed$$Node.Valid(h63617293^^n#15: ref
       where NoDecl^^n#15 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#15) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && 2 == NoDecl^^$FunctionContextHeight;



implementation CheckWellformed$$Node.Valid(h35684727^^n#15: ref)
{
  var h52727095^^$_Frame: <beta>[ref,Field beta]bool;
  var h4781813^^n#99: ref;
  var h43036322^^n#100: ref;
  var h51782583^^i#101: int;
  var h63390070^^i#102: int;

    if (NoDecl^^n#15 != NoDecl^^null)
    {
        assert NoDecl^^n#15 != NoDecl^^null;
    }
    else
    {
    }

    if (*)
    {
    }
    else
    {
        NoDecl^^$_Frame := (lambda<alpha> h33639718^^$o: ref, h34322009^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#15
       || (NoDecl^^n#15 != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]));
        if (NoDecl^^n#15 != NoDecl^^null)
        {
            assert NoDecl^^n#15 != NoDecl^^null;
            assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Repr];
            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)])
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Repr];
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)])
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Repr];
                    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))])
                    {
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), NoDecl^^Node.Repr];
                    }

                    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
   && !NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
    NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)])
                    {
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), NoDecl^^Node.Repr];
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Repr];
                    }
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr))))
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Repr];
                    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))])
                    {
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), NoDecl^^Node.Repr];
                    }

                    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
   && !NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
    NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)])
                    {
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), NoDecl^^Node.Repr];
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Repr];
                    }
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr))))
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                NoDecl^^n#99 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left);
                assert (forall<alpha> h40462633^^$o: ref, h28619382^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#99
         || (NoDecl^^n#99 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#99, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                assert NoDecl^^Set#Subset((if NoDecl^^n#99 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#99, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#15 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#15 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#99 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#99, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
                assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left));
                if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left)))
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                    NoDecl^^n#100 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right);
                    assert (forall<alpha> h56247849^^$o: ref, h36468595^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && (NoDecl^^$o == NoDecl^^n#100
         || (NoDecl^^n#100 != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#100, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^$o)]))
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
                    assert NoDecl^^Set#Subset((if NoDecl^^n#100 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#100, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#15 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType))
   && !NoDecl^^Set#Subset((if NoDecl^^n#15 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType), 
    (if NoDecl^^n#100 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#100, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType));
                    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right));
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right)))
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                }

                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), NoDecl^^Node.Repr];
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), NoDecl^^Node.Repr];
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr))))
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Repr];
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), NoDecl^^Node.Repr];
                }
                else
                {
                }

                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), NoDecl^^Node.Repr];
                }
                else
                {
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
    NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
        (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           then NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)
           else NoDecl^^Set#Empty(): Set BoxType)), 
      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)
         else NoDecl^^Set#Empty(): Set BoxType))))
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.Contents];
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.value];
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), NoDecl^^Node.Contents];
                }
                else
                {
                }

                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), NoDecl^^Node.Contents];
                }
                else
                {
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
    NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
        (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           then NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)
           else NoDecl^^Set#Empty(): Set BoxType)), 
      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)
         else NoDecl^^Set#Empty(): Set BoxType)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
    NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
          NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
        (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           then NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)
           else NoDecl^^Set#Empty(): Set BoxType)), 
      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Contents)
         else NoDecl^^Set#Empty(): Set BoxType))))
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.left];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), NoDecl^^Node.Contents];
                    if (NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
  NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#101)])
                    {
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.value];
                    }
                }
            }

            if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
   && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
       && !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
        NoDecl^^Node.Repr), 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
    NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
        (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           then NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)
           else NoDecl^^Set#Empty(): Set BoxType)), 
      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)
         else NoDecl^^Set#Empty(): Set BoxType)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
    NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
          NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
        (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           then NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)
           else NoDecl^^Set#Empty(): Set BoxType)), 
      (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
          NoDecl^^Node.Contents)
         else NoDecl^^Set#Empty(): Set BoxType)))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
     ==> (forall h59781901^^i#16: int :: 
      true
         ==> 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
          NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
         ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))))
            {
                assert NoDecl^^n#15 != NoDecl^^null;
                assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null)
                {
                    assert NoDecl^^n#15 != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.right];
                    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null;
                    assert NoDecl^^$_Frame[NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), NoDecl^^Node.Contents];
                    if (NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
  NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#102)])
                    {
                        assert NoDecl^^n#15 != NoDecl^^null;
                        assert NoDecl^^$_Frame[NoDecl^^n#15, NoDecl^^Node.value];
                    }
                }
            }
        }

        assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#15)
   == (NoDecl^^n#15 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h1166200^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h10495806^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value) < NoDecl^^i#17)));
        assume NoDecl^^n#15 != NoDecl^^null
   ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
       ==> true)
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
       ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
           ==> true))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
       ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
           ==> true))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
       ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
         && (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
           ==> NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
       ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> true))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)))
       ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) == NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) == NoDecl^^null
           ==> true))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)))
         && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
          NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
              (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 then NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                  NoDecl^^Node.Repr)
                 else NoDecl^^Set#Empty(): Set BoxType)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)))
       ==> (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) == NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> true)
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) == NoDecl^^null
           ==> true))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)))
         && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
          NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
              (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 then NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                  NoDecl^^Node.Repr)
                 else NoDecl^^Set#Empty(): Set BoxType)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)))
         && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
          NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
                NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
              (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 then NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                  NoDecl^^Node.Contents)
                 else NoDecl^^Set#Empty(): Set BoxType)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)))
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h27353390^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> true))
     && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
         && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))]
             && !NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#15)]
             && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr), 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr)))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left))
         && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
             && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)))
         && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Repr), 
          NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#15)), 
              (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 then NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                  NoDecl^^Node.Repr)
                 else NoDecl^^Set#Empty(): Set BoxType)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)))
         && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.Contents), 
          NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
                NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value))), 
              (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
                 then NoDecl^^read(NoDecl^^$Heap, 
                  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                  NoDecl^^Node.Contents)
                 else NoDecl^^Set#Empty(): Set BoxType)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)))
         && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left) != NoDecl^^null
           ==> (forall h44853923^^i#16: int :: 
            true
               ==> 
              NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
               ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.value)))
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h1032124^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#15, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> true));
    }
}



procedure CheckWellformed$$Node.WeakRightRotation(h9289124^^n#18: ref
       where NoDecl^^n#18 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#18) == NoDecl^^class.Node))
   returns (h16493259^^r#19: ref
       where NoDecl^^r#19 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#19) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$Node.WeakRightRotation(h14221611^^n#18: ref) returns (h60885635^^r#19: ref)
{
  var h11099805^^$_Frame: <beta>[ref,Field beta]bool;
  var h32789387^^n#103: ref;
  var h26669028^^n#104: ref;
  var h38694667^^n#105: ref;
  var h12707688^^n#106: ref;
  var h47260332^^n#107: ref;
  var h22689808^^n#108: ref;
  var h2881685^^n#109: ref;
  var h25935173^^n#110: ref;
  var h32089967^^n#111: ref;

    NoDecl^^$_Frame := (lambda<alpha> h20374254^^$o: ref, h49150562^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#18
       || (NoDecl^^n#18 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)));
    if (NoDecl^^n#18 != NoDecl^^null)
    {
        assert NoDecl^^n#18 != NoDecl^^null;
    }

    assume NoDecl^^n#18 != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null;
    NoDecl^^n#103 := NoDecl^^n#18;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18))
    {
        NoDecl^^n#104 := NoDecl^^n#18;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#104);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#18);
    }

    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#18))
    {
        NoDecl^^n#105 := NoDecl^^n#18;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#105)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#105);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#18);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#18)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#18);
    assert NoDecl^^n#18 != NoDecl^^null;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 0 - 1;
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h39701876^^$o: ref, h21772565^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#18
       || (NoDecl^^n#18 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#18, NoDecl^^Node.left)));
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    havoc NoDecl^^r#19;
    assert NoDecl^^n#18 != NoDecl^^null;
    if (NoDecl^^r#19
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)))
    {
        assert NoDecl^^r#19 != NoDecl^^null;
        assert NoDecl^^n#18 != NoDecl^^null;
    }

    if (NoDecl^^r#19
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Contents))))
    {
        assert NoDecl^^r#19 != NoDecl^^null;
        assert NoDecl^^n#18 != NoDecl^^null;
    }

    assume NoDecl^^r#19
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Contents)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)));
    NoDecl^^n#106 := NoDecl^^r#19;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19))
    {
        NoDecl^^n#107 := NoDecl^^r#19;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#107);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#19);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#19);
    assert NoDecl^^r#19 != NoDecl^^null;
    NoDecl^^n#108 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left);
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#108)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#108);
    assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left));
    if (NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left)))
    {
        assert NoDecl^^r#19 != NoDecl^^null;
        NoDecl^^n#109 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#109)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#109);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right));
    }

    assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right));
    NoDecl^^n#110 := NoDecl^^r#19;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#110);
    assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^r#19);
    NoDecl^^n#111 := NoDecl^^n#18;
    assert NoDecl^^n#18 == NoDecl^^null
   || (NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#18, NoDecl^^alloc)
     && NoDecl^^dtype(NoDecl^^n#18) == NoDecl^^class.Node);
    assert NoDecl^^Node.Valid(old(NoDecl^^$Heap), NoDecl^^n#111);
    assume NoDecl^^Node.Height#canCall(old(NoDecl^^$Heap), NoDecl^^n#18);
    assume NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^r#19)
   == old(NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#18));
    assert NoDecl^^r#19 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) != 1)
    {
        assert NoDecl^^r#19 != NoDecl^^null;
    }

    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 1
   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 2;
}



procedure Node.WeakRightRotation(h61735358^^n#18: ref
       where NoDecl^^n#18 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#18) == NoDecl^^class.Node))
   returns (h18747312^^r#19: ref
       where NoDecl^^r#19 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#19) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  requires NoDecl^^n#18 != NoDecl^^null;
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null;
  free requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
   && (NoDecl^^n#18 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#18)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#18)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#18)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#18)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h34508084^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h42137308^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.value) < NoDecl^^i#17)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#18)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#18)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#18)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#18)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h43691456^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.value)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h57678784^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.value) < NoDecl^^i#17));
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#18)
   && (NoDecl^^n#18 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#18)
   && (NoDecl^^n#18 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#18)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#18)
     || (NoDecl^^n#18 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)));
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.balance) == 0 - 1;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  ensures NoDecl^^r#19
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Contents), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Contents)));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Repr)));
  free ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
   && (NoDecl^^r#19 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#19)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#19)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#19)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#19)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h49347015^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h41469957^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.value) < NoDecl^^i#17)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#19)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#19)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#19)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#19)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h37685299^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.value)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h3623379^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.value) < NoDecl^^i#17));
  free ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#19)
   && (NoDecl^^r#19 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#19)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#19)
     || (NoDecl^^r#19 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
          NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
          NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  ensures NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^r#19)
   == old(NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#18));
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 1
   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 2;
  free ensures (forall<alpha> h32610412^^$o: ref, h25058257^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#18
       || (NoDecl^^n#18 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#18, NoDecl^^Node.left)));
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation Node.WeakRightRotation(h24197721^^n#18: ref) returns (h16452903^^r#19: ref)
{
  var h13858403^^$_Frame: <beta>[ref,Field beta]bool;
  var h57616766^^a#20: ref
   where NoDecl^^a#20 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#20, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^a#20) == NoDecl^^class.Node);
  var h48788849^^b#21: ref
   where NoDecl^^b#21 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#21, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^b#21) == NoDecl^^class.Node);
  var h36446461^^c#22: ref
   where NoDecl^^c#22 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^c#22, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^c#22) == NoDecl^^class.Node);
  var h59582700^^$rhs#0: ref;
  var h66482253^^$rhs#1: ref;
  var h61469371^^$rhs#2: ref;
  var h16353430^^a#112: ref;
  var h12963143^^b#113: ref;
  var h49559423^^x#114: ref;
  var h43381623^^d#115: int;
  var h54890288^^a#116: ref;
  var h24250547^^b#117: ref;
  var h16928338^^x#118: ref;
  var h18137316^^d#119: int;

    NoDecl^^$_Frame := (lambda<alpha> h29018124^^$o: ref, h59836530^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#18
       || (NoDecl^^n#18 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left)));
    assume true;
    assert NoDecl^^n#18 != NoDecl^^null;
    assume true;
    NoDecl^^r#19 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.left);
    assume {:captureState "AVLTree.dfy(247,9)"} true;
    assert {:subsumption 0} NoDecl^^n#18 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^r#19 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#18 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#18 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null)
    {
        assert {:subsumption 0} NoDecl^^n#18 != NoDecl^^null;
        assert {:subsumption 0} NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null;
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) == NoDecl^^null
     ==> true);
    assert NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.Contents), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.Contents), 
      NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.value)))), 
    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right) != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right), 
        NoDecl^^Node.Contents)
       else NoDecl^^Set#Empty(): Set BoxType)));
    assume true;
    assume true;
    assume true;
    assert NoDecl^^r#19 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#0 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.left);
    assert NoDecl^^r#19 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#1 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.right);
    assert NoDecl^^n#18 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#2 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#18, NoDecl^^Node.right);
    NoDecl^^a#20 := NoDecl^^$rhs#0;
    NoDecl^^b#21 := NoDecl^^$rhs#1;
    NoDecl^^c#22 := NoDecl^^$rhs#2;
    assume {:captureState "AVLTree.dfy(249,19)"} true;
    assume true;
    NoDecl^^a#112 := NoDecl^^b#21;
    assume true;
    NoDecl^^b#113 := NoDecl^^c#22;
    assume true;
    NoDecl^^x#114 := NoDecl^^n#18;
    assert NoDecl^^r#19 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 0 - 1)
    {
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 0 - 1
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) != 0 - 1
     ==> true);
    NoDecl^^d#115 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 0 - 1
   then 1
   else 0);
    assert (forall<alpha> h1657863^^$o: ref, h14920772^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#114
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#112, NoDecl^^b#113, NoDecl^^x#114, NoDecl^^d#115);
    assume {:captureState "AVLTree.dfy(250,7)"} true;
    assume true;
    NoDecl^^a#116 := NoDecl^^a#20;
    assume true;
    NoDecl^^b#117 := NoDecl^^n#18;
    assume true;
    NoDecl^^x#118 := NoDecl^^r#19;
    assert NoDecl^^r#19 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 1)
    {
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 1 ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) != 1 ==> true);
    NoDecl^^d#119 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#19, NoDecl^^Node.balance) == 1
   then 2
   else 1);
    assert (forall<alpha> h69227^^$o: ref, h623043^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#118
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#116, NoDecl^^b#117, NoDecl^^x#118, NoDecl^^d#119);
    assume {:captureState "AVLTree.dfy(251,7)"} true;
}



procedure CheckWellformed$$Node.WeakLeftRotation(h5607390^^n#23: ref
       where NoDecl^^n#23 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#23) == NoDecl^^class.Node))
   returns (h50466518^^r#24: ref
       where NoDecl^^r#24 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#24) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$Node.WeakLeftRotation(h51545483^^n#23: ref) returns (h61256166^^r#24: ref)
{
  var h14434584^^$_Frame: <beta>[ref,Field beta]bool;
  var h62802394^^n#120: ref;
  var h28350637^^n#121: ref;
  var h53829147^^n#122: ref;
  var h14700275^^n#123: ref;
  var h65193616^^n#124: ref;
  var h49871633^^n#125: ref;
  var h46191521^^n#126: ref;
  var h13070512^^n#127: ref;
  var h50525752^^n#128: ref;

    NoDecl^^$_Frame := (lambda<alpha> h52078584^^$o: ref, h66054074^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#23
       || (NoDecl^^n#23 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right)));
    if (NoDecl^^n#23 != NoDecl^^null)
    {
        assert NoDecl^^n#23 != NoDecl^^null;
    }

    assume NoDecl^^n#23 != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null;
    NoDecl^^n#120 := NoDecl^^n#23;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23))
    {
        NoDecl^^n#121 := NoDecl^^n#23;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#121);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#23);
    }

    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#23))
    {
        NoDecl^^n#122 := NoDecl^^n#23;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#122)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#122);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#23);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#23)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#23);
    assert NoDecl^^n#23 != NoDecl^^null;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 1;
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h57615760^^$o: ref, h48779793^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#23
       || (NoDecl^^n#23 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#23, NoDecl^^Node.right)));
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    havoc NoDecl^^r#24;
    assert NoDecl^^n#23 != NoDecl^^null;
    if (NoDecl^^r#24
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right)))
    {
        assert NoDecl^^r#24 != NoDecl^^null;
        assert NoDecl^^n#23 != NoDecl^^null;
    }

    if (NoDecl^^r#24
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Contents))))
    {
        assert NoDecl^^r#24 != NoDecl^^null;
        assert NoDecl^^n#23 != NoDecl^^null;
    }

    assume NoDecl^^r#24
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Contents)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)));
    NoDecl^^n#123 := NoDecl^^r#24;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24))
    {
        NoDecl^^n#124 := NoDecl^^r#24;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#124);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#24);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#24);
    assert NoDecl^^r#24 != NoDecl^^null;
    NoDecl^^n#125 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left);
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#125)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#125);
    assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left));
    if (NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left)))
    {
        assert NoDecl^^r#24 != NoDecl^^null;
        NoDecl^^n#126 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#126)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#126);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right));
    }

    assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right));
    NoDecl^^n#127 := NoDecl^^r#24;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#127);
    assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^r#24);
    NoDecl^^n#128 := NoDecl^^n#23;
    assert NoDecl^^n#23 == NoDecl^^null
   || (NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#23, NoDecl^^alloc)
     && NoDecl^^dtype(NoDecl^^n#23) == NoDecl^^class.Node);
    assert NoDecl^^Node.Valid(old(NoDecl^^$Heap), NoDecl^^n#128);
    assume NoDecl^^Node.Height#canCall(old(NoDecl^^$Heap), NoDecl^^n#23);
    assume NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^r#24)
   == old(NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#23));
    assert NoDecl^^r#24 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) != 0 - 1)
    {
        assert NoDecl^^r#24 != NoDecl^^null;
    }

    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 0 - 1
   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 0 - 2;
}



procedure Node.WeakLeftRotation(h36364960^^n#23: ref
       where NoDecl^^n#23 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#23) == NoDecl^^class.Node))
   returns (h58849189^^r#24: ref
       where NoDecl^^r#24 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#24) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  requires NoDecl^^n#23 != NoDecl^^null;
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null;
  free requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
   && (NoDecl^^n#23 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#23)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#23)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#23)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#23)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h59880657^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h2055005^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.value) < NoDecl^^i#17)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#23)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#23)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#23)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#23)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h18495050^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.value)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h32237730^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.value) < NoDecl^^i#17));
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#23)
   && (NoDecl^^n#23 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#23)
   && (NoDecl^^n#23 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^n#23)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^n#23)
     || (NoDecl^^n#23 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left)));
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.balance) == 1;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  ensures NoDecl^^r#24
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Contents), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Contents)));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Repr)));
  free ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
   && (NoDecl^^r#24 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#24)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#24)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#24)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#24)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h21704116^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h61119323^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.value) < NoDecl^^i#17)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#24)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#24)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#24)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#24)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h13202999^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.value)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h51718129^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.value) < NoDecl^^i#17));
  free ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#24)
   && (NoDecl^^r#24 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#24)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#24)
     || (NoDecl^^r#24 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
          NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
          NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  ensures NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^r#24)
   == old(NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#23));
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 0 - 1
   || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 0 - 2;
  free ensures (forall<alpha> h62809978^^$o: ref, h28418891^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#23
       || (NoDecl^^n#23 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#23, NoDecl^^Node.right)));
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation Node.WeakLeftRotation(h54443429^^n#23: ref) returns (h20228817^^r#24: ref)
{
  var h47841633^^$_Frame: <beta>[ref,Field beta]bool;
  var h27921517^^a#25: ref
   where NoDecl^^a#25 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#25, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^a#25) == NoDecl^^class.Node);
  var h49967061^^b#26: ref
   where NoDecl^^b#26 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#26, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^b#26) == NoDecl^^class.Node);
  var h47050372^^c#27: ref
   where NoDecl^^c#27 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^c#27, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^c#27) == NoDecl^^class.Node);
  var h20800170^^$rhs#0: ref;
  var h52983808^^$rhs#1: ref;
  var h7092232^^$rhs#2: ref;
  var h63830089^^a#129: ref;
  var h37599894^^b#130: ref;
  var h2854726^^x#131: ref;
  var h25692540^^d#132: int;
  var h29906272^^a#133: ref;
  var h720995^^b#134: ref;
  var h6488958^^x#135: ref;
  var h58400626^^d#136: int;

    NoDecl^^$_Frame := (lambda<alpha> h55843593^^$o: ref, h32830290^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#23
       || (NoDecl^^n#23 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right)));
    assume true;
    assert NoDecl^^n#23 != NoDecl^^null;
    assume true;
    NoDecl^^r#24 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.right);
    assume {:captureState "AVLTree.dfy(269,9)"} true;
    assert {:subsumption 0} NoDecl^^n#23 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^r#24 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#23 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#23 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null)
    {
        assert {:subsumption 0} NoDecl^^n#23 != NoDecl^^null;
        assert {:subsumption 0} NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null;
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) == NoDecl^^null
     ==> true);
    assert NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.Contents), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.Contents), 
      NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.value)))), 
    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left) != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left), 
        NoDecl^^Node.Contents)
       else NoDecl^^Set#Empty(): Set BoxType)));
    assume true;
    assume true;
    assume true;
    assert NoDecl^^n#23 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#0 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#23, NoDecl^^Node.left);
    assert NoDecl^^r#24 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#1 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.left);
    assert NoDecl^^r#24 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#2 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.right);
    NoDecl^^a#25 := NoDecl^^$rhs#0;
    NoDecl^^b#26 := NoDecl^^$rhs#1;
    NoDecl^^c#27 := NoDecl^^$rhs#2;
    assume {:captureState "AVLTree.dfy(271,19)"} true;
    assume true;
    NoDecl^^a#129 := NoDecl^^a#25;
    assume true;
    NoDecl^^b#130 := NoDecl^^b#26;
    assume true;
    NoDecl^^x#131 := NoDecl^^n#23;
    assert NoDecl^^r#24 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 1)
    {
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 1 ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) != 1 ==> true);
    NoDecl^^d#132 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 1
   then 0 - 1
   else 0);
    assert (forall<alpha> h27037160^^$o: ref, h42007851^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#131
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#129, NoDecl^^b#130, NoDecl^^x#131, NoDecl^^d#132);
    assume {:captureState "AVLTree.dfy(272,7)"} true;
    assume true;
    NoDecl^^a#133 := NoDecl^^n#23;
    assume true;
    NoDecl^^b#134 := NoDecl^^c#27;
    assume true;
    NoDecl^^x#135 := NoDecl^^r#24;
    assert NoDecl^^r#24 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 0 - 1)
    {
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 0 - 1
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) != 0 - 1
     ==> true);
    NoDecl^^d#136 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#24, NoDecl^^Node.balance) == 0 - 1
   then 0 - 2
   else 0 - 1);
    assert (forall<alpha> h42526340^^$o: ref, h47192740^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#135
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#133, NoDecl^^b#134, NoDecl^^x#135, NoDecl^^d#136);
    assume {:captureState "AVLTree.dfy(273,7)"} true;
}



procedure CheckWellformed$$Node.StrongRightRotation(h22081476^^n#28: ref
       where NoDecl^^n#28 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#28) == NoDecl^^class.Node))
   returns (h64515557^^r#29: ref
       where NoDecl^^r#29 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#29) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$Node.StrongRightRotation(h43769104^^n#28: ref) returns (h58377623^^r#29: ref)
{
  var h55636561^^$_Frame: <beta>[ref,Field beta]bool;
  var h30967009^^n#137: ref;
  var h10267631^^n#138: ref;
  var h25299820^^n#139: ref;
  var h26371793^^n#140: ref;
  var h36019552^^n#141: ref;
  var h55740512^^n#142: ref;
  var h31902563^^n#143: ref;
  var h18687619^^n#144: ref;
  var h33970848^^n#145: ref;
  var h37302179^^n#146: ref;
  var h175293^^n#147: ref;

    NoDecl^^$_Frame := (lambda<alpha> h1577639^^$o: ref, h14198754^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#28
       || (NoDecl^^n#28 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)));
    if (NoDecl^^n#28 != NoDecl^^null)
    {
        assert NoDecl^^n#28 != NoDecl^^null;
    }

    assume NoDecl^^n#28 != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null;
    NoDecl^^n#137 := NoDecl^^n#28;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28))
    {
        NoDecl^^n#138 := NoDecl^^n#28;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#138);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#28);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#28);
    assert NoDecl^^n#28 != NoDecl^^null;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.balance) == 0 - 2;
    assert NoDecl^^n#28 != NoDecl^^null;
    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
    NoDecl^^Node.balance)
   != 0 - 1)
    {
        assert NoDecl^^n#28 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null;
    }

    assume NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.balance)
     == 0 - 1
   || NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.balance)
     == 0 - 2;
    assert NoDecl^^n#28 != NoDecl^^null;
    NoDecl^^n#139 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left);
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#139);
    assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left));
    if (NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)))
    {
        assert NoDecl^^n#28 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null;
        NoDecl^^n#140 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
  NoDecl^^Node.right);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#140)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#140);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
    NoDecl^^Node.right));
    }

    if (NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right)))
    {
        assert NoDecl^^n#28 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null;
        NoDecl^^n#141 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
  NoDecl^^Node.left);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#141)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#141);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
    NoDecl^^Node.left));
    }

    if (NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.left)))
    {
        assert NoDecl^^n#28 != NoDecl^^null;
        NoDecl^^n#142 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#142)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#142);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right));
    }

    assume NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right));
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h60679928^^$o: ref, h9248440^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#28
       || (NoDecl^^n#28 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#28, NoDecl^^Node.left)));
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    havoc NoDecl^^r#29;
    assert NoDecl^^n#28 != NoDecl^^null;
    if (NoDecl^^r#29
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)))
    {
        assert NoDecl^^r#29 != NoDecl^^null;
        assert NoDecl^^n#28 != NoDecl^^null;
    }

    if (NoDecl^^r#29
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Contents))))
    {
        assert NoDecl^^r#29 != NoDecl^^null;
        assert NoDecl^^n#28 != NoDecl^^null;
    }

    assume NoDecl^^r#29
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Contents)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)));
    NoDecl^^n#143 := NoDecl^^r#29;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29))
    {
        NoDecl^^n#144 := NoDecl^^r#29;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#144);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#29);
    }

    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#29))
    {
        NoDecl^^n#145 := NoDecl^^r#29;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#145)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#145);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#29);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#29)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#29);
    NoDecl^^n#146 := NoDecl^^r#29;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#146);
    assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^r#29);
    NoDecl^^n#147 := NoDecl^^n#28;
    assert NoDecl^^n#28 == NoDecl^^null
   || (NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#28, NoDecl^^alloc)
     && NoDecl^^dtype(NoDecl^^n#28) == NoDecl^^class.Node);
    assert NoDecl^^Node.Valid(old(NoDecl^^$Heap), NoDecl^^n#147);
    assume NoDecl^^Node.Height#canCall(old(NoDecl^^$Heap), NoDecl^^n#28);
    assume NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^r#29) + 1
   == old(NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#28));
    assert NoDecl^^r#29 != NoDecl^^null;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0;
}



procedure Node.StrongRightRotation(h16127101^^n#28: ref
       where NoDecl^^n#28 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#28) == NoDecl^^class.Node))
   returns (h10926182^^r#29: ref
       where NoDecl^^r#29 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#29) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  requires NoDecl^^n#28 != NoDecl^^null;
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null;
  free requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
   && (NoDecl^^n#28 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#28)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#28)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#28)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#28)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h31226782^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h12605589^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.value) < NoDecl^^i#17)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#28)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#28)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#28)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#28)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h46341445^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.value)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h14419821^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.value) < NoDecl^^i#17));
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#28)
   && (NoDecl^^n#28 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#28)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#28)
     || (NoDecl^^n#28 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right)));
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.balance) == 0 - 2;
  requires NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.balance)
     == 0 - 1
   || NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.balance)
     == 0 - 2;
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.left)
           != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.right)
           != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.right)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.right)
       != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.right), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.right), 
          NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.left))
   && (NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.left)
       != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.left), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.left), 
          NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
      NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
        NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left), 
            NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
          NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  ensures NoDecl^^r#29
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Contents), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Contents)));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Repr)));
  free ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
   && (NoDecl^^r#29 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#29)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#29)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#29)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#29)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h62669527^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h27154837^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.value) < NoDecl^^i#17)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#29)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#29)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#29)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#29)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h43066942^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.value)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h52058165^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.value) < NoDecl^^i#17));
  free ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#29)
   && (NoDecl^^r#29 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right))));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#29)
   && (NoDecl^^r#29 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#29)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#29)
     || (NoDecl^^r#29 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^r#29) + 1
   == old(NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#28));
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0;
  free ensures (forall<alpha> h65870306^^$o: ref, h55961846^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#28
       || (NoDecl^^n#28 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#28, NoDecl^^Node.left)));
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation Node.StrongRightRotation(h33894570^^n#28: ref) returns (h36615679^^r#29: ref)
{
  var h61105663^^$_Frame: <beta>[ref,Field beta]bool;
  var h13080057^^a#30: ref
   where NoDecl^^a#30 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#30, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^a#30) == NoDecl^^class.Node);
  var h50611656^^b#31: ref
   where NoDecl^^b#31 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#31, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^b#31) == NoDecl^^class.Node);
  var h52851724^^c#32: ref
   where NoDecl^^c#32 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^c#32, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^c#32) == NoDecl^^class.Node);
  var h5903470^^$rhs#0: ref;
  var h53131231^^$rhs#1: ref;
  var h8419032^^$rhs#2: ref;
  var h8662426^^a#148: ref;
  var h10852974^^b#149: ref;
  var h30567910^^x#150: ref;
  var h6675738^^d#151: int;
  var h60081642^^a#152: ref;
  var h3863873^^b#153: ref;
  var h34774863^^x#154: ref;
  var h44538317^^d#155: int;

    NoDecl^^$_Frame := (lambda<alpha> h65300541^^$o: ref, h50833958^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#28
       || (NoDecl^^n#28 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left)));
    assume true;
    assert NoDecl^^n#28 != NoDecl^^null;
    assume true;
    NoDecl^^r#29 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.left);
    assume {:captureState "AVLTree.dfy(290,9)"} true;
    assert {:subsumption 0} NoDecl^^n#28 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^r#29 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#28 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#28 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null)
    {
        assert {:subsumption 0} NoDecl^^n#28 != NoDecl^^null;
        assert {:subsumption 0} NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null;
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) == NoDecl^^null
     ==> true);
    assert NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.Contents), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.Contents), 
      NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.value)))), 
    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right) != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right), 
        NoDecl^^Node.Contents)
       else NoDecl^^Set#Empty(): Set BoxType)));
    assume true;
    assume true;
    assume true;
    assert NoDecl^^r#29 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#0 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.left);
    assert NoDecl^^r#29 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#1 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.right);
    assert NoDecl^^n#28 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#2 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#28, NoDecl^^Node.right);
    NoDecl^^a#30 := NoDecl^^$rhs#0;
    NoDecl^^b#31 := NoDecl^^$rhs#1;
    NoDecl^^c#32 := NoDecl^^$rhs#2;
    assume {:captureState "AVLTree.dfy(292,19)"} true;
    assume true;
    NoDecl^^a#148 := NoDecl^^b#31;
    assume true;
    NoDecl^^b#149 := NoDecl^^c#32;
    assume true;
    NoDecl^^x#150 := NoDecl^^n#28;
    assert NoDecl^^r#29 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0 - 2)
    {
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0 - 2
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) != 0 - 2
     ==> true);
    NoDecl^^d#151 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#29, NoDecl^^Node.balance) == 0 - 2
   then 1
   else 0);
    assert (forall<alpha> h54852443^^$o: ref, h23909939^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#150
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#148, NoDecl^^b#149, NoDecl^^x#150, NoDecl^^d#151);
    assume {:captureState "AVLTree.dfy(293,7)"} true;
    assume true;
    NoDecl^^a#152 := NoDecl^^a#30;
    assume true;
    NoDecl^^b#153 := NoDecl^^n#28;
    assume true;
    NoDecl^^x#154 := NoDecl^^r#29;
    assume true;
    NoDecl^^d#155 := 0;
    assert (forall<alpha> h13862865^^$o: ref, h57656925^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#154
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#152, NoDecl^^b#153, NoDecl^^x#154, NoDecl^^d#155);
    assume {:captureState "AVLTree.dfy(294,7)"} true;
}



procedure CheckWellformed$$Node.StrongLeftRotation(h49150280^^n#33: ref
       where NoDecl^^n#33 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#33) == NoDecl^^class.Node))
   returns (h39699339^^r#34: ref
       where NoDecl^^r#34 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#34) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$Node.StrongLeftRotation(h21749735^^n#33: ref) returns (h61529894^^r#34: ref)
{
  var h16898135^^$_Frame: <beta>[ref,Field beta]bool;
  var h17865493^^n#156: ref;
  var h26571712^^n#157: ref;
  var h37818817^^n#158: ref;
  var h4825033^^n#159: ref;
  var h43425297^^n#160: ref;
  var h55283354^^n#161: ref;
  var h27788141^^n#162: ref;
  var h48766684^^n#163: ref;
  var h36246974^^n#164: ref;
  var h57787318^^n#165: ref;
  var h50323820^^n#166: ref;

    NoDecl^^$_Frame := (lambda<alpha> h50261201^^$o: ref, h49697630^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#33
       || (NoDecl^^n#33 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right)));
    if (NoDecl^^n#33 != NoDecl^^null)
    {
        assert NoDecl^^n#33 != NoDecl^^null;
    }

    assume NoDecl^^n#33 != NoDecl^^null
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null;
    NoDecl^^n#156 := NoDecl^^n#33;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33))
    {
        NoDecl^^n#157 := NoDecl^^n#33;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#157);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#33);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#33);
    assert NoDecl^^n#33 != NoDecl^^null;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.balance) == 2;
    assert NoDecl^^n#33 != NoDecl^^null;
    assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
    NoDecl^^Node.balance)
   != 1)
    {
        assert NoDecl^^n#33 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null;
    }

    assume NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.balance)
     == 1
   || NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.balance)
     == 2;
    assert NoDecl^^n#33 != NoDecl^^null;
    NoDecl^^n#158 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right);
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#158);
    assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right));
    if (NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right)))
    {
        assert NoDecl^^n#33 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null;
        NoDecl^^n#159 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
  NoDecl^^Node.right);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#159)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#159);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
    NoDecl^^Node.right));
    }

    if (NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right)))
    {
        assert NoDecl^^n#33 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null;
        NoDecl^^n#160 := NoDecl^^read(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
  NoDecl^^Node.left);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#160)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#160);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
  NoDecl^^read(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
    NoDecl^^Node.left));
    }

    if (NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.left)))
    {
        assert NoDecl^^n#33 != NoDecl^^null;
        NoDecl^^n#161 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left);
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#161)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#161);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left));
    }

    assume NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left));
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h44625493^^$o: ref, h66085117^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#33
       || (NoDecl^^n#33 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#33, NoDecl^^Node.right)));
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    havoc NoDecl^^r#34;
    assert NoDecl^^n#33 != NoDecl^^null;
    if (NoDecl^^r#34
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right)))
    {
        assert NoDecl^^r#34 != NoDecl^^null;
        assert NoDecl^^n#33 != NoDecl^^null;
    }

    if (NoDecl^^r#34
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Contents))))
    {
        assert NoDecl^^r#34 != NoDecl^^null;
        assert NoDecl^^n#33 != NoDecl^^null;
    }

    assume NoDecl^^r#34
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Contents), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Contents)))
   && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr), 
    old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)));
    NoDecl^^n#162 := NoDecl^^r#34;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34))
    {
        NoDecl^^n#163 := NoDecl^^r#34;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#163);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#34);
    }

    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#34))
    {
        NoDecl^^n#164 := NoDecl^^r#34;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#164)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#164);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#34);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#34)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#34);
    NoDecl^^n#165 := NoDecl^^r#34;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#165);
    assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^r#34);
    NoDecl^^n#166 := NoDecl^^n#33;
    assert NoDecl^^n#33 == NoDecl^^null
   || (NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#33, NoDecl^^alloc)
     && NoDecl^^dtype(NoDecl^^n#33) == NoDecl^^class.Node);
    assert NoDecl^^Node.Valid(old(NoDecl^^$Heap), NoDecl^^n#166);
    assume NoDecl^^Node.Height#canCall(old(NoDecl^^$Heap), NoDecl^^n#33);
    assume NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^r#34) + 1
   == old(NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^n#33));
    assert NoDecl^^r#34 != NoDecl^^null;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 0;
}



procedure Node.StrongLeftRotation(h57895144^^n#33: ref
       where NoDecl^^n#33 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^n#33) == NoDecl^^class.Node))
   returns (h51294256^^r#34: ref
       where NoDecl^^r#34 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^r#34) == NoDecl^^class.Node));
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  requires NoDecl^^n#33 != NoDecl^^null;
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null;
  free requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
   && (NoDecl^^n#33 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#33)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#33)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#33)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#33)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h58995125^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h61194080^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.value) < NoDecl^^i#17)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#33)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#33)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^n#33)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^n#33)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h13875810^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.value)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h57773428^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.value) < NoDecl^^i#17));
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#33)
   && (NoDecl^^n#33 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^n#33)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#33)
     || (NoDecl^^n#33 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right)));
  requires NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.balance) == 2;
  requires NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.balance)
     == 1
   || NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.balance)
     == 2;
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.left)
           != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.right)
           != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right) != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.right)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right))
   && (NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.right)
       != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.right), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.right), 
            NoDecl^^Node.balance)
           == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.right), 
          NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.right))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.right))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.right)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.right), 
          NoDecl^^Node.left)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.left))
   && (NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.left)
       != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.left), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
              NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.left), 
          NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, 
    NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
      NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
        NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
          NoDecl^^Node.left)
         != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right), 
            NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
          NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 0
         || NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
            NoDecl^^Node.balance)
           == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
          NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left))
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
          NoDecl^^Node.left)));
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  ensures NoDecl^^r#34
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Contents), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Contents)));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr), 
  old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Repr)));
  free ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
   && (NoDecl^^r#34 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#34)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#34)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#34)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#34)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h50198807^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h49136085^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.value) < NoDecl^^i#17)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#34)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#34)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^r#34)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^r#34)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h39571581^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.value)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h20599914^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.value) < NoDecl^^i#17));
  free ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#34)
   && (NoDecl^^r#34 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right))));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right)));
  free ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#34)
   && (NoDecl^^r#34 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 1);
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^r#34)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^r#34)
     || (NoDecl^^r#34 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^r#34) + 1
   == old(NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^n#33));
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 0;
  free ensures (forall<alpha> h51181499^^$o: ref, h57980315^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^n#33
       || (NoDecl^^n#33 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^n#33, NoDecl^^Node.right)));
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation Node.StrongLeftRotation(h52060794^^n#33: ref) returns (h65893970^^r#34: ref)
{
  var h56174818^^$_Frame: <beta>[ref,Field beta]bool;
  var h35811316^^a#35: ref
   where NoDecl^^a#35 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#35, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^a#35) == NoDecl^^class.Node);
  var h53866394^^b#36: ref
   where NoDecl^^b#36 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#36, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^b#36) == NoDecl^^class.Node);
  var h15035499^^c#37: ref
   where NoDecl^^c#37 == NoDecl^^null
     || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^c#37, NoDecl^^alloc)
       && NoDecl^^dtype(NoDecl^^c#37) == NoDecl^^class.Node);
  var h1101770^^$rhs#0: ref;
  var h9915935^^$rhs#1: ref;
  var h22134555^^$rhs#2: ref;
  var h64993271^^a#167: ref;
  var h48068532^^b#168: ref;
  var h29963612^^x#169: ref;
  var h1237054^^d#170: int;
  var h11133493^^a#171: ref;
  var h33092577^^b#172: ref;
  var h29397739^^x#173: ref;
  var h63253060^^d#174: int;

    NoDecl^^$_Frame := (lambda<alpha> h32406629^^$o: ref, h23224207^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^n#33
       || (NoDecl^^n#33 != NoDecl^^null
         && NoDecl^^$o == NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right)));
    assume true;
    assert NoDecl^^n#33 != NoDecl^^null;
    assume true;
    NoDecl^^r#34 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.right);
    assume {:captureState "AVLTree.dfy(311,9)"} true;
    assert {:subsumption 0} NoDecl^^n#33 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^r#34 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#33 != NoDecl^^null;
    assert {:subsumption 0} NoDecl^^n#33 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null)
    {
        assert {:subsumption 0} NoDecl^^n#33 != NoDecl^^null;
        assert {:subsumption 0} NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null;
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) == NoDecl^^null
     ==> true);
    assert NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.Contents), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.Contents), 
      NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.value)))), 
    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left) != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left), 
        NoDecl^^Node.Contents)
       else NoDecl^^Set#Empty(): Set BoxType)));
    assume true;
    assume true;
    assume true;
    assert NoDecl^^n#33 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#0 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^n#33, NoDecl^^Node.left);
    assert NoDecl^^r#34 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#1 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.left);
    assert NoDecl^^r#34 != NoDecl^^null;
    assume true;
    NoDecl^^$rhs#2 := NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.right);
    NoDecl^^a#35 := NoDecl^^$rhs#0;
    NoDecl^^b#36 := NoDecl^^$rhs#1;
    NoDecl^^c#37 := NoDecl^^$rhs#2;
    assume {:captureState "AVLTree.dfy(313,19)"} true;
    assume true;
    NoDecl^^a#167 := NoDecl^^a#35;
    assume true;
    NoDecl^^b#168 := NoDecl^^b#36;
    assume true;
    NoDecl^^x#169 := NoDecl^^n#33;
    assert NoDecl^^r#34 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 2)
    {
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 2 ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) != 2 ==> true);
    NoDecl^^d#170 := (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^r#34, NoDecl^^Node.balance) == 2
   then 0 - 1
   else 0);
    assert (forall<alpha> h7691275^^$o: ref, h2112619^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#169
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#167, NoDecl^^b#168, NoDecl^^x#169, NoDecl^^d#170);
    assume {:captureState "AVLTree.dfy(314,7)"} true;
    assume true;
    NoDecl^^a#171 := NoDecl^^n#33;
    assume true;
    NoDecl^^b#172 := NoDecl^^c#37;
    assume true;
    NoDecl^^x#173 := NoDecl^^r#34;
    assume true;
    NoDecl^^d#174 := 0;
    assert (forall<alpha> h19013575^^$o: ref, h36904447^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
       && NoDecl^^$o == NoDecl^^x#173
     ==> NoDecl^^$_Frame[NoDecl^^$o, NoDecl^^$f]);
    call Node.AssembleSingle(NoDecl^^a#171, NoDecl^^b#172, NoDecl^^x#173, NoDecl^^d#174);
    assume {:captureState "AVLTree.dfy(315,7)"} true;
}



procedure CheckWellformed$$Node.AssembleSingle(h63704574^^a#38: ref
       where NoDecl^^a#38 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^a#38) == NoDecl^^class.Node), 
    h36470260^^b#39: ref
       where NoDecl^^b#39 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^b#39) == NoDecl^^class.Node), 
    h59796890^^x#40: ref
       where NoDecl^^x#40 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^x#40) == NoDecl^^class.Node), 
    h1301106^^d#41: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  modifies NoDecl^^$Heap, NoDecl^^$Tick;



implementation CheckWellformed$$Node.AssembleSingle(h11709955^^a#38: ref, 
    h38280736^^b#39: ref, 
    h8982304^^x#40: ref, 
    h13731878^^d#41: int)
{
  var h56478042^^$_Frame: <beta>[ref,Field beta]bool;
  var h38540333^^n#175: ref;
  var h11318680^^n#176: ref;
  var h34759260^^n#177: ref;
  var h44397891^^n#178: ref;
  var h64036700^^n#179: ref;
  var h39459394^^n#180: ref;
  var h19590229^^i#181: int;
  var h42094334^^i#182: int;
  var h43304686^^n#183: ref;
  var h54197854^^n#184: ref;
  var h18018639^^n#185: ref;
  var h27950026^^n#186: ref;

    NoDecl^^$_Frame := (lambda<alpha> h50223649^^$o: ref, h49359659^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^x#40);
    assume NoDecl^^x#40 != NoDecl^^null;
    NoDecl^^n#175 := NoDecl^^a#38;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38))
    {
        NoDecl^^n#176 := NoDecl^^b#39;
        assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39);
    NoDecl^^n#177 := NoDecl^^a#38;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#177);
    assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^a#38);
    if (NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^a#38))
    {
        NoDecl^^n#178 := NoDecl^^b#39;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#178);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^b#39);
    }

    assume NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^a#38)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^b#39);
    NoDecl^^n#179 := NoDecl^^a#38;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#179)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#179);
    assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^a#38);
    if (NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^a#38))
    {
        NoDecl^^n#180 := NoDecl^^b#39;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#180)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^n#180);
        assume NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^b#39);
    }

    assume NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^a#38)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^b#39);
    if (NoDecl^^a#38 != NoDecl^^null)
    {
    }

    if (NoDecl^^a#38 != NoDecl^^null && NoDecl^^b#39 != NoDecl^^null)
    {
        assert NoDecl^^a#38 != NoDecl^^null;
        assert NoDecl^^b#39 != NoDecl^^null;
    }

    assume NoDecl^^a#38 != NoDecl^^null && NoDecl^^b#39 != NoDecl^^null
   ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr), 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr));
    if (NoDecl^^a#38 != NoDecl^^null)
    {
        assert NoDecl^^a#38 != NoDecl^^null;
        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#181)])
        {
            assert NoDecl^^x#40 != NoDecl^^null;
        }
    }

    assume NoDecl^^a#38 != NoDecl^^null
   ==> (forall h41583755^^i#42: int :: 
    true
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#42)]
       ==> NoDecl^^i#42 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value));
    if (NoDecl^^b#39 != NoDecl^^null)
    {
        assert NoDecl^^b#39 != NoDecl^^null;
        if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#182)])
        {
            assert NoDecl^^x#40 != NoDecl^^null;
        }
    }

    assume NoDecl^^b#39 != NoDecl^^null
   ==> (forall h38709481^^i#43: int :: 
    true
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#43)]
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value) < NoDecl^^i#43);
    if (NoDecl^^a#38 != NoDecl^^null)
    {
        assert NoDecl^^a#38 != NoDecl^^null;
    }

    assume NoDecl^^a#38 != NoDecl^^null
   ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)];
    if (NoDecl^^b#39 != NoDecl^^null)
    {
        assert NoDecl^^b#39 != NoDecl^^null;
    }

    assume NoDecl^^b#39 != NoDecl^^null
   ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)];
    NoDecl^^n#183 := NoDecl^^b#39;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#183);
    assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^b#39);
    NoDecl^^n#184 := NoDecl^^a#38;
    assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#184);
    assume NoDecl^^Node.Height#canCall(NoDecl^^$Heap, NoDecl^^a#38);
    assume NoDecl^^d#41
   == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^b#39)
     - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^a#38);
    havoc NoDecl^^$Heap;
    assume (forall<alpha> h12841014^^$o: ref, h48460267^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^x#40);
    assume NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);
    NoDecl^^n#185 := NoDecl^^x#40;
    assume NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40);
    if (NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40))
    {
        NoDecl^^n#186 := NoDecl^^x#40;
        assert NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^n#186);
        assume NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^x#40);
    }

    assume NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^x#40);
    assert NoDecl^^x#40 != NoDecl^^null;
    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.balance) == NoDecl^^d#41;
    assert NoDecl^^x#40 != NoDecl^^null;
    assert NoDecl^^x#40 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value)
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value)))
    {
        assert NoDecl^^x#40 != NoDecl^^null;
    }

    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value)
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value))
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) == NoDecl^^a#38)
    {
        assert NoDecl^^x#40 != NoDecl^^null;
    }

    assume NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value)
     == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value))
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) == NoDecl^^a#38
   && NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) == NoDecl^^b#39;
    assert NoDecl^^x#40 != NoDecl^^null;
    if (NoDecl^^a#38 != NoDecl^^null)
    {
        assert NoDecl^^a#38 != NoDecl^^null;
    }
    else
    {
    }

    if (NoDecl^^b#39 != NoDecl^^null)
    {
        assert NoDecl^^b#39 != NoDecl^^null;
    }
    else
    {
    }

    assume NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^x#40)), 
      (if NoDecl^^a#38 != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)
         else NoDecl^^Set#Empty(): Set BoxType)), 
    (if NoDecl^^b#39 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType)));
    assert NoDecl^^x#40 != NoDecl^^null;
    assert NoDecl^^x#40 != NoDecl^^null;
    if (NoDecl^^a#38 != NoDecl^^null)
    {
        assert NoDecl^^a#38 != NoDecl^^null;
    }
    else
    {
    }

    if (NoDecl^^b#39 != NoDecl^^null)
    {
        assert NoDecl^^b#39 != NoDecl^^null;
    }
    else
    {
    }

    assume NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Contents), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value))), 
      (if NoDecl^^a#38 != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Contents)
         else NoDecl^^Set#Empty(): Set BoxType)), 
    (if NoDecl^^b#39 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Contents)
       else NoDecl^^Set#Empty(): Set BoxType)));
}



procedure Node.AssembleSingle(h33489226^^a#38: ref
       where NoDecl^^a#38 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^a#38) == NoDecl^^class.Node), 
    h32967578^^b#39: ref
       where NoDecl^^b#39 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^b#39) == NoDecl^^class.Node), 
    h28272749^^x#40: ref
       where NoDecl^^x#40 == NoDecl^^null
         || (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^alloc)
           && NoDecl^^dtype(NoDecl^^x#40) == NoDecl^^class.Node), 
    h53128157^^d#41: int);
  free requires 0 == NoDecl^^$ModuleContextHeight && NoDecl^^$InMethodContext;
  requires NoDecl^^x#40 != NoDecl^^null;
  free requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
   && (NoDecl^^a#38 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^a#38)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^a#38)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^a#38)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^a#38)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h8391370^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h8413469^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.value) < NoDecl^^i#17)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^a#38)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^a#38)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^a#38)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^a#38)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h8612359^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.value)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h10402369^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.value) < NoDecl^^i#17));
  free requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
   && (NoDecl^^b#39 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^b#39)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^b#39)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^b#39)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^b#39)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h26512460^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h37285554^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.value) < NoDecl^^i#17)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^b#39)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^b#39)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right))]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^b#39)]);
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^b#39)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h25666^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.value)));
  requires NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h230999^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.value) < NoDecl^^i#17));
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^a#38)
   && (NoDecl^^a#38 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right)));
  free requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^b#39)
   && (NoDecl^^b#39 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right))));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left)));
  requires NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^a#38)
   && (NoDecl^^a#38 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.balance) == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^a#38)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^a#38)
     || (NoDecl^^a#38 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.left)));
  free requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^b#39)
   && (NoDecl^^b#39 != NoDecl^^null
     ==> (
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance) == 1)
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right))
       && NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance) == 0 - 1
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance) == 0
         || NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.balance) == 1);
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.right)));
  requires NoDecl^^Node.Balanced#canCall(NoDecl^^$Heap, NoDecl^^b#39)
   ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^b#39)
     || (NoDecl^^b#39 != NoDecl^^null
       ==> NoDecl^^Node.Balanced(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.left)));
  requires NoDecl^^a#38 != NoDecl^^null && NoDecl^^b#39 != NoDecl^^null
   ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr), 
    NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr));
  requires NoDecl^^a#38 != NoDecl^^null
   ==> (forall h2078992^^i#42: int :: 
    true
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#42)]
       ==> NoDecl^^i#42 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value));
  requires NoDecl^^b#39 != NoDecl^^null
   ==> (forall h18710936^^i#43: int :: 
    true
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#43)]
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value) < NoDecl^^i#43);
  requires NoDecl^^a#38 != NoDecl^^null
   ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)];
  requires NoDecl^^b#39 != NoDecl^^null
   ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)];
  requires NoDecl^^d#41
   == NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^b#39)
     - NoDecl^^Node.Height#2(NoDecl^^$Heap, NoDecl^^a#38);
  modifies NoDecl^^$Heap, NoDecl^^$Tick;
  free ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
   && (NoDecl^^x#40 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)]
       && !NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right))]
           && !NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)]
           && NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
              NoDecl^^Node.Repr), 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left))
       && NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
           && NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
            NoDecl^^Node.Repr), 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
            NoDecl^^Node.Repr)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^x#40)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
         ==> (forall h34180703^^i#16: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
             ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
         ==> (forall h39190879^^i#17: int :: 
          true
             ==> 
            NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
             ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value) < NoDecl^^i#17)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^null)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right))]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
       ==> !NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
        NoDecl^^Node.Repr)[NoDecl^^$Box(NoDecl^^x#40)]);
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Set#Subset(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
         && NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Set#Disjoint(NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
          NoDecl^^Node.Repr), 
        NoDecl^^read(NoDecl^^$Heap, 
          NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
          NoDecl^^Node.Repr)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^x#40)), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
                NoDecl^^Node.Repr)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
              NoDecl^^Node.Repr)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Contents), 
        NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
              NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value))), 
            (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
               then NoDecl^^read(NoDecl^^$Heap, 
                NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
                NoDecl^^Node.Contents)
               else NoDecl^^Set#Empty(): Set BoxType)), 
          (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
             then NoDecl^^read(NoDecl^^$Heap, 
              NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
              NoDecl^^Node.Contents)
             else NoDecl^^Set#Empty(): Set BoxType))));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       ==> (forall h17173591^^i#16: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#16)]
           ==> NoDecl^^i#16 < NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value)));
  ensures NoDecl^^Node.Valid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.Valid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
       ==> (forall h20344593^^i#17: int :: 
        true
           ==> 
          NoDecl^^read(NoDecl^^$Heap, 
            NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
            NoDecl^^Node.Contents)[NoDecl^^$Box(NoDecl^^i#17)]
           ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value) < NoDecl^^i#17));
  free ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   && NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^x#40)
   && (NoDecl^^x#40 != NoDecl^^null
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left)))
       && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
         ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right))));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.balance)
         == NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right))
           - NoDecl^^Node.Height(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left)));
  ensures NoDecl^^Node.BalanceValid#canCall(NoDecl^^$Heap, NoDecl^^x#40)
   ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^x#40)
     || (NoDecl^^x#40 != NoDecl^^null
       ==> 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
       ==> NoDecl^^Node.BalanceValid(NoDecl^^$Heap, NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right)));
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.balance) == NoDecl^^d#41;
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value)
   == old(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value));
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) == NoDecl^^a#38;
  ensures NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) == NoDecl^^b#39;
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^x#40)), 
      (if NoDecl^^a#38 != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Repr)
         else NoDecl^^Set#Empty(): Set BoxType)), 
    (if NoDecl^^b#39 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType)));
  ensures NoDecl^^Set#Equal(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Contents), 
  NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
        NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value))), 
      (if NoDecl^^a#38 != NoDecl^^null
         then NoDecl^^read(NoDecl^^$Heap, NoDecl^^a#38, NoDecl^^Node.Contents)
         else NoDecl^^Set#Empty(): Set BoxType)), 
    (if NoDecl^^b#39 != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, NoDecl^^b#39, NoDecl^^Node.Contents)
       else NoDecl^^Set#Empty(): Set BoxType)));
  free ensures (forall<alpha> h48883615^^$o: ref, h37299352^^$f: Field alpha :: 
  { NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f) } 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^$f)
         == NoDecl^^read(old(NoDecl^^$Heap), NoDecl^^$o, NoDecl^^$f)
       || NoDecl^^$o == NoDecl^^x#40);
  free ensures NoDecl^^$HeapSucc(old(NoDecl^^$Heap), NoDecl^^$Heap);



implementation Node.AssembleSingle(h149855^^a#38: ref, 
    h1348700^^b#39: ref, 
    h12138304^^x#40: ref, 
    h42135876^^d#41: int)
{
  var h43678569^^$_Frame: <beta>[ref,Field beta]bool;
  var h57562809^^$rhs#0: ref;
  var h48303235^^$rhs#1: ref;
  var h32075938^^$rhs#2: Set BoxType;
  var h20247990^^$rhs#3: Set BoxType;
  var h48014184^^$rhs#4: int;

    NoDecl^^$_Frame := (lambda<alpha> h29474473^^$o: ref, h63943666^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> NoDecl^^$o == NoDecl^^x#40);
    assert NoDecl^^x#40 != NoDecl^^null;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^x#40, NoDecl^^Node.left];
    assume true;
    NoDecl^^$rhs#0 := NoDecl^^a#38;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left, NoDecl^^$rhs#0);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(342,14)"} true;
    assert NoDecl^^x#40 != NoDecl^^null;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^x#40, NoDecl^^Node.right];
    assume true;
    NoDecl^^$rhs#1 := NoDecl^^b#39;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right, NoDecl^^$rhs#1);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(343,15)"} true;
    assert NoDecl^^x#40 != NoDecl^^null;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^x#40, NoDecl^^Node.Contents];
    assert NoDecl^^x#40 != NoDecl^^null;
    assert NoDecl^^x#40 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null)
    {
        assert NoDecl^^x#40 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null;
    }
    else
    {
    }

    assert NoDecl^^x#40 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null)
    {
        assert NoDecl^^x#40 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null;
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) == NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) == NoDecl^^null
     ==> true);
    NoDecl^^$rhs#2 := NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, 
      NoDecl^^$Box(NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.value))), 
    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
        NoDecl^^Node.Contents)
       else NoDecl^^Set#Empty(): Set BoxType)), 
  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
     then NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
      NoDecl^^Node.Contents)
     else NoDecl^^Set#Empty(): Set BoxType));
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Contents, NoDecl^^$rhs#2);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(344,18)"} true;
    assert NoDecl^^x#40 != NoDecl^^null;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^x#40, NoDecl^^Node.Repr];
    assert NoDecl^^x#40 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null)
    {
        assert NoDecl^^x#40 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null;
    }
    else
    {
    }

    assert NoDecl^^x#40 != NoDecl^^null;
    if (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null)
    {
        assert NoDecl^^x#40 != NoDecl^^null;
        assert NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null;
    }
    else
    {
    }

    assume (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) == NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
     ==> true)
   && (NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) == NoDecl^^null
     ==> true);
    NoDecl^^$rhs#3 := NoDecl^^Set#Union(NoDecl^^Set#Union(NoDecl^^Set#UnionOne(NoDecl^^Set#Empty(): Set BoxType, NoDecl^^$Box(NoDecl^^x#40)), 
    (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left) != NoDecl^^null
       then NoDecl^^read(NoDecl^^$Heap, 
        NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.left), 
        NoDecl^^Node.Repr)
       else NoDecl^^Set#Empty(): Set BoxType)), 
  (if NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right) != NoDecl^^null
     then NoDecl^^read(NoDecl^^$Heap, 
      NoDecl^^read(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.right), 
      NoDecl^^Node.Repr)
     else NoDecl^^Set#Empty(): Set BoxType));
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.Repr, NoDecl^^$rhs#3);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(346,14)"} true;
    assert NoDecl^^x#40 != NoDecl^^null;
    assume true;
    assert NoDecl^^$_Frame[NoDecl^^x#40, NoDecl^^Node.balance];
    assume true;
    NoDecl^^$rhs#4 := NoDecl^^d#41;
    NoDecl^^$Heap := NoDecl^^update(NoDecl^^$Heap, NoDecl^^x#40, NoDecl^^Node.balance, NoDecl^^$rhs#4);
    assume NoDecl^^$IsGoodHeap(NoDecl^^$Heap);
    assume {:captureState "AVLTree.dfy(348,17)"} true;
}



const unique h38622084^^class.Math: ClassName;

function h12054440^^Math.max(h41381104^^$heap: HeapType, h36885620^^a#44: int, h63535124^^b#45: int) : int;

function h34945211^^Math.max#limited(h46071449^^$heap: HeapType, h11989863^^a#44: int, h40799911^^b#45: int) : int;

function h31654880^^Math.max#2(h16458469^^$heap: HeapType, h13908493^^a#44: int, h58067579^^b#45: int) : int;

function h52846167^^Math.max#canCall(h5853458^^$heap: HeapType, h52681125^^a#44: int, h4368081^^b#45: int) : bool;

axiom (forall h39312736^^$Heap: HeapType, h18270305^^a#44: int, h30215023^^b#45: int :: 
  { NoDecl^^Math.max#2(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45) } 
  NoDecl^^Math.max#2(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
     == NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45));

axiom (forall h3499754^^$Heap: HeapType, h31497787^^a#44: int, h15044627^^b#45: int :: 
  { NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45) } 
  NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
     == NoDecl^^Math.max#limited(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (3 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h1183915^^$Heap: HeapType, h10655236^^a#44: int, h28788263^^b#45: int :: 
    { NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45) } 
    NoDecl^^Math.max#canCall(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 3 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && 0 <= NoDecl^^a#44
           && 0 <= NoDecl^^b#45)
       ==> (NoDecl^^a#44 < NoDecl^^b#45 ==> true)
         && (NoDecl^^a#44 >= NoDecl^^b#45 ==> true)
         && NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
           == (if NoDecl^^a#44 < NoDecl^^b#45 then NoDecl^^b#45 else NoDecl^^a#44)
         && (NoDecl^^a#44 == NoDecl^^b#45
           ==> NoDecl^^Math.max#limited(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
               == NoDecl^^a#44
             && NoDecl^^a#44 == NoDecl^^b#45)
         && NoDecl^^a#44
           <= NoDecl^^Math.max#limited(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
         && NoDecl^^b#45
           <= NoDecl^^Math.max#limited(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
         && 0 <= NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45));

axiom 0 < NoDecl^^$ModuleContextHeight
     || (0 == NoDecl^^$ModuleContextHeight
       && (3 <= NoDecl^^$FunctionContextHeight || NoDecl^^$InMethodContext))
   ==> (forall h57767782^^$Heap: HeapType, h50147992^^a#44: int, h48678752^^b#45: int :: 
    { NoDecl^^Math.max#2(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45) } 
    NoDecl^^Math.max#canCall(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
         || (
          (
            0 != NoDecl^^$ModuleContextHeight
             || 3 != NoDecl^^$FunctionContextHeight
             || NoDecl^^$InMethodContext)
           && NoDecl^^$IsGoodHeap(NoDecl^^$Heap)
           && 0 <= NoDecl^^a#44
           && 0 <= NoDecl^^b#45)
       ==> NoDecl^^Math.max#2(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
         == (if NoDecl^^a#44 < NoDecl^^b#45 then NoDecl^^b#45 else NoDecl^^a#44));

axiom (forall h35455590^^$h0: HeapType, 
    h50664859^^$h1: HeapType, 
    h53330552^^a#44: int, 
    h10212927^^b#45: int :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Math.max(NoDecl^^$h1, NoDecl^^a#44, NoDecl^^b#45) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && 0 <= NoDecl^^a#44
       && 0 <= NoDecl^^a#44
       && 0 <= NoDecl^^b#45
       && 0 <= NoDecl^^b#45
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h24807479^^$o: ref, h21940722^^$f: Field alpha :: 
      false
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Math.max(NoDecl^^$h0, NoDecl^^a#44, NoDecl^^b#45)
       == NoDecl^^Math.max(NoDecl^^$h1, NoDecl^^a#44, NoDecl^^b#45));

axiom (forall h63248778^^$h0: HeapType, 
    h32368095^^$h1: HeapType, 
    h22877402^^a#44: int, 
    h4570028^^b#45: int :: 
  { NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1), NoDecl^^Math.max#limited(NoDecl^^$h1, NoDecl^^a#44, NoDecl^^b#45) } 
  NoDecl^^$IsGoodHeap(NoDecl^^$h0)
       && NoDecl^^$IsGoodHeap(NoDecl^^$h1)
       && 0 <= NoDecl^^a#44
       && 0 <= NoDecl^^a#44
       && 0 <= NoDecl^^b#45
       && 0 <= NoDecl^^b#45
       && NoDecl^^$HeapSucc(NoDecl^^$h0, NoDecl^^$h1)
     ==> 
    (forall<alpha> h41130254^^$o: ref, h34627969^^$f: Field alpha :: 
      false
         ==> NoDecl^^read(NoDecl^^$h0, NoDecl^^$o, NoDecl^^$f)
           == NoDecl^^read(NoDecl^^$h1, NoDecl^^$o, NoDecl^^$f))
     ==> NoDecl^^Math.max#limited(NoDecl^^$h0, NoDecl^^a#44, NoDecl^^b#45)
       == NoDecl^^Math.max#limited(NoDecl^^$h1, NoDecl^^a#44, NoDecl^^b#45));

procedure CheckWellformed$$Math.max(h43216271^^a#44: int where 0 <= NoDecl^^a#44, 
    h53402119^^b#45: int where 0 <= NoDecl^^b#45);
  free requires 0 == NoDecl^^$ModuleContextHeight && 3 == NoDecl^^$FunctionContextHeight;



implementation CheckWellformed$$Math.max(h10857028^^a#44: int, h30604389^^b#45: int)
{
  var h7004053^^a#187: int;
  var h63036484^^b#188: int;
  var h30457452^^a#189: int;
  var h5681612^^b#190: int;
  var h51134510^^a#191: int;
  var h57557412^^b#192: int;
  var h48254661^^$_Frame: <beta>[ref,Field beta]bool;

    if (*)
    {
        if (NoDecl^^a#44 == NoDecl^^b#45)
        {
            assert 0 <= NoDecl^^a#44;
            NoDecl^^a#187 := NoDecl^^a#44;
            assert 0 <= NoDecl^^b#45;
            NoDecl^^b#188 := NoDecl^^b#45;
            assert 0 <= NoDecl^^a#44 || NoDecl^^a#187 == NoDecl^^a#44;
            assert 0 <= NoDecl^^b#45
   || NoDecl^^a#187 < NoDecl^^a#44
   || NoDecl^^b#188 == NoDecl^^b#45;
            assert (NoDecl^^a#44 == NoDecl^^a#44 && NoDecl^^b#45 == NoDecl^^b#45)
   || NoDecl^^a#187 < NoDecl^^a#44
   || (NoDecl^^a#187 == NoDecl^^a#44 && NoDecl^^b#188 < NoDecl^^b#45);
            assume (NoDecl^^a#44 == NoDecl^^a#44 && NoDecl^^b#45 == NoDecl^^b#45)
   || NoDecl^^Math.max#canCall(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45);
            if (NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45) == NoDecl^^a#44)
            {
            }
        }

        assume NoDecl^^a#44 == NoDecl^^b#45
   ==> NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45) == NoDecl^^a#44
     && NoDecl^^a#44 == NoDecl^^b#45;
        assert 0 <= NoDecl^^a#44;
        NoDecl^^a#189 := NoDecl^^a#44;
        assert 0 <= NoDecl^^b#45;
        NoDecl^^b#190 := NoDecl^^b#45;
        assert 0 <= NoDecl^^a#44 || NoDecl^^a#189 == NoDecl^^a#44;
        assert 0 <= NoDecl^^b#45
   || NoDecl^^a#189 < NoDecl^^a#44
   || NoDecl^^b#190 == NoDecl^^b#45;
        assert (NoDecl^^a#44 == NoDecl^^a#44 && NoDecl^^b#45 == NoDecl^^b#45)
   || NoDecl^^a#189 < NoDecl^^a#44
   || (NoDecl^^a#189 == NoDecl^^a#44 && NoDecl^^b#190 < NoDecl^^b#45);
        assume (NoDecl^^a#44 == NoDecl^^a#44 && NoDecl^^b#45 == NoDecl^^b#45)
   || NoDecl^^Math.max#canCall(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45);
        if (NoDecl^^a#44 <= NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45))
        {
            assert 0 <= NoDecl^^a#44;
            NoDecl^^a#191 := NoDecl^^a#44;
            assert 0 <= NoDecl^^b#45;
            NoDecl^^b#192 := NoDecl^^b#45;
            assert 0 <= NoDecl^^a#44 || NoDecl^^a#191 == NoDecl^^a#44;
            assert 0 <= NoDecl^^b#45
   || NoDecl^^a#191 < NoDecl^^a#44
   || NoDecl^^b#192 == NoDecl^^b#45;
            assert (NoDecl^^a#44 == NoDecl^^a#44 && NoDecl^^b#45 == NoDecl^^b#45)
   || NoDecl^^a#191 < NoDecl^^a#44
   || (NoDecl^^a#191 == NoDecl^^a#44 && NoDecl^^b#192 < NoDecl^^b#45);
            assume (NoDecl^^a#44 == NoDecl^^a#44 && NoDecl^^b#45 == NoDecl^^b#45)
   || NoDecl^^Math.max#canCall(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45);
        }

        assume NoDecl^^a#44 <= NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
   && NoDecl^^b#45 <= NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45);
    }
    else
    {
        NoDecl^^$_Frame := (lambda<alpha> h31638772^^$o: ref, h16313497^^$f: Field alpha :: 
  NoDecl^^$o != NoDecl^^null
       && NoDecl^^read(NoDecl^^$Heap, NoDecl^^$o, NoDecl^^alloc)
     ==> false);
        if (NoDecl^^a#44 < NoDecl^^b#45)
        {
        }
        else
        {
        }

        assert 0 <= (if NoDecl^^a#44 < NoDecl^^b#45 then NoDecl^^b#45 else NoDecl^^a#44);
        assume NoDecl^^Math.max(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45)
   == (if NoDecl^^a#44 < NoDecl^^b#45 then NoDecl^^b#45 else NoDecl^^a#44);
        assume (NoDecl^^a#44 < NoDecl^^b#45 ==> true)
   && (NoDecl^^a#44 >= NoDecl^^b#45 ==> true);
        assert NoDecl^^a#44 == NoDecl^^b#45
   ==> NoDecl^^Math.max#2(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45) == NoDecl^^a#44;
        assert NoDecl^^a#44 == NoDecl^^b#45 ==> NoDecl^^a#44 == NoDecl^^b#45;
        assert NoDecl^^a#44 <= NoDecl^^Math.max#2(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45);
        assert NoDecl^^b#45 <= NoDecl^^Math.max#2(NoDecl^^$Heap, NoDecl^^a#44, NoDecl^^b#45);
    }
}



const unique h12603749^^class._default: ClassName;
