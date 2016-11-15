type Integer = int;
type Boolean = bool;
type Heap = [ref]int;
type ref;
const unique r0 : ref;
const unique r1 : ref;
const unique r2 : ref;
const $old_heap : Heap;
var heap : Heap;
procedure m1 ()
{
	var heap_$_0 : Heap;
	var heap_$_1 : Heap;
	var heap_$_2 : Heap;
	var heap_$_3 : Heap;
	var heap_$_4 : Heap;
	var heap_$_5 : Heap;
	var heap_$_6 : Heap;
	var $_$_condition : bool;
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
	if ($_$_condition) { goto anon4_Then; } else { goto anon4_Else; }
anon4_Then:
	assume heap_$_4 == heap_$_3[r1 := 1];
	assume heap_$_6 == heap_$_4;
	goto anon3;
anon4_Else:
	assume heap_$_5 == heap_$_3[r2 := 1];
	assume heap_$_6 == heap_$_5;
	goto anon3;
anon3:
	assert  heap_$_6[r0] == 0;
	goto $exit;
}
