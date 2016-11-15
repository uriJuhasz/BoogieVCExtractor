type Integer = int;
type Boolean = bool;
type Heap = [ref]int;
type ref;
const unique r0 : ref;
const unique r1 : ref;
const unique r2 : ref;
const $old_heap : Heap;
var heap : Heap;
procedure m0 ()
{
	var heap_$_0 : Heap;
	var heap_$_1 : Heap;
	var heap_$_2 : Heap;
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
	assert  heap_$_2[r0] == 0;
	goto $exit;
}
