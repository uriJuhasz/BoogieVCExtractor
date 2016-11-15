const unique r1: ref;
const unique r2: ref;
const unique p1: ref;
const unique p2: ref;




procedure main()

modifies $Heap;

requires r1 != null;
requires IsNotAllocated($Heap, r1);
requires r2 != null;
requires IsNotAllocated($Heap, r2);
requires p1 != null;
requires IsNotAllocated($Heap, p1);
requires p2 != null;
requires IsNotAllocated($Heap, p2);

requires InvStructEx($Heap, AddEl(AddEl(AddEl(Singleton(r1),r2),p1),p2));

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

procedure main_create()

modifies $Heap;

requires r1 != null;
requires IsNotAllocated($Heap, r1);
requires r2 != null;
requires IsNotAllocated($Heap, r2);
requires p1 != null;
requires IsNotAllocated($Heap, p1);
requires p2 != null;
requires IsNotAllocated($Heap, p2);

requires InvStructEx($Heap, AddEl(AddEl(AddEl(Singleton(r1),r2),p1),p2));


ensures InvStruct($Heap);
ensures InvPr($Heap, r1);
ensures InvPr($Heap, r2);
ensures InvPr($Heap, p1);
ensures InvPr($Heap, p2);

ensures $Heap[r1, NSt] == StF;
ensures $Heap[r2, NSt] == StF;
ensures $Heap[p1, NSt] == StF;
ensures $Heap[p2, NSt] == StF;

{

  var Reg1, Reg2, Reg3, Reg4 : TRegion;

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