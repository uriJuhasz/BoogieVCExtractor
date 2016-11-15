const unique c: ref;
const unique c1: ref;
const unique c11: ref;
const unique c2: ref;
const unique c21: ref;



procedure main()

modifies $Heap;

requires c != null;
requires IsNotAllocated($Heap, c);
requires c1 != null;
requires IsNotAllocated($Heap, c1);
requires c11 != null;
requires IsNotAllocated($Heap, c11);
requires c2 != null;
requires IsNotAllocated($Heap, c2);
requires c21 != null;
requires IsNotAllocated($Heap, c21);

requires InvStructEx($Heap, AddEl(AddEl(AddEl(AddEl(Singleton(c),c1),c11),c2),c21));

ensures InvStruct($Heap);
{

  call create_main();

  call Composite..add(c, c1);
  call Composite..add(c1, c11);
  call Composite..add(c, c2);
  call Composite..add(c2, c21);
  call Composite..remove(c1, c11);
  call Composite..remove(c2, c21);
  call Composite..add(c1, c11);
  call Composite..add(c2, c21);

  assert $Heap[c, childrenNumber] == 4;
  assert $Heap[c1, childrenNumber] == 1;
  assert $Heap[c2, childrenNumber] == 1;
  assert $Heap[c11, childrenNumber] == 0;
  assert $Heap[c21, childrenNumber] == 0;

}

procedure create_main()

modifies $Heap;

requires c != null;
requires IsNotAllocated($Heap, c);
requires c1 != null;
requires IsNotAllocated($Heap, c1);
requires c11 != null;
requires IsNotAllocated($Heap, c11);
requires c2 != null;
requires IsNotAllocated($Heap, c2);
requires c21 != null;
requires IsNotAllocated($Heap, c21);

requires InvStructEx($Heap, AddEl(AddEl(AddEl(AddEl(Singleton(c),c1),c11),c2),c21));


ensures InvStruct($Heap);
ensures InvComposite($Heap, c);
ensures InvComposite($Heap, c1);
ensures InvComposite($Heap, c11);
ensures InvComposite($Heap, c2);
ensures InvComposite($Heap, c21);

ensures $Heap[c, childrenNumber] == 0;
ensures $Heap[c1, childrenNumber] == 0;
ensures $Heap[c11, childrenNumber] == 0;
ensures $Heap[c2, childrenNumber] == 0;
ensures $Heap[c21, childrenNumber] == 0;

ensures IsEmptyTree($Heap, c);
ensures IsEmptyTree($Heap, c1);
ensures IsEmptyTree($Heap, c11);
ensures IsEmptyTree($Heap, c2);
ensures IsEmptyTree($Heap, c21);

{

  var Reg1, Reg2, Reg3, Reg4, Reg5 : TRegion;

  Reg5 := Singleton(c21);
  Reg4 := AddEl(Reg5, c2);
  Reg3 := AddEl(Reg4, c11);
  Reg2 := AddEl(Reg3, c1);
  Reg1 := AddEl(Reg2, c);

  call Composite..ctor(c,  Reg1);
  call Composite..ctor(c1,  Reg2);
  call Composite..ctor(c11,  Reg3);
  call Composite..ctor(c2,  Reg4);
  call Composite..ctor(c21,  Reg5);


}