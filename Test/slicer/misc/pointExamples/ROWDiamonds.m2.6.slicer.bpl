type Integer = int;
type Boolean = bool;
type Heap = [ref]int;
type ref;
const unique r0 : ref;
const unique r1 : ref;
const unique r2 : ref;
var heap : Heap;
procedure m2 ()
{
	var heap_$_0 : Heap;
	var heap_$_1 : Heap;
	var heap_$_2 : Heap;
	var heap_$_3 : Heap;
	var heap_$_4 : Heap;
	var heap_$_5 : Heap;
	var heap_$_6 : Heap;
	var heap_$_7 : Heap;
	var heap_$_8 : Heap;
	var heap_$_9 : Heap;
	var heap_$_10 : Heap;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
$start:
	goto PreconditionGeneratedEntry;
$exit:
	assume false;
PreconditionGeneratedEntry:
	goto anon0;
anon0:
	assume heap_$_0 == heap[r0 := 0];
	assume heap_$_1 == heap_$_0[r1 := 1];
	assume heap_$_2 == heap_$_1[r2 := 2];
	assume heap_$_3 == heap_$_2[r1 := 1];
	if ($_$_condition) { goto anon7_Then; } else { goto anon7_Else; }
anon7_Then:
	assume $_$_condition;
	assume heap_$_4 == heap_$_3[r1 := 1];
	assume heap_$_6 == heap_$_4;
	goto anon3;
anon7_Else:
	assume !$_$_condition;
	assume heap_$_5 == heap_$_3[r2 := 1];
	assume heap_$_6 == heap_$_5;
	goto anon3;
anon3:
	assume heap_$_7 == heap_$_6[r2 := 1];
	if ($_$_condition_$0) { goto anon8_Then; } else { goto anon8_Else; }
anon8_Then:
	assume $_$_condition_$0;
	assume heap_$_8 == heap_$_7[r1 := 2];
	assume heap_$_10 == heap_$_8;
	goto anon6;
anon8_Else:
	assume !$_$_condition_$0;
	assume heap_$_9 == heap_$_7[r2 := 2];
	assume heap_$_10 == heap_$_9;
	goto anon6;
anon6:
	assert  heap_$_10[r0] == 0;
	goto $exit;
}
