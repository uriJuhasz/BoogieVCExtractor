type Integer = int;
type Boolean = bool;
type Heap = [ref]int;
type ref;
const unique r0 : ref;
const unique r1 : ref;
const unique r2 : ref;
var heap : Heap;
procedure m4 ()
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
	var heap_$_11 : Heap;
	var heap_$_12 : Heap;
	var heap_$_13 : Heap;
	var heap_$_14 : Heap;
	var heap_$_15 : Heap;
	var heap_$_16 : Heap;
	var heap_$_17 : Heap;
	var heap_$_18 : Heap;
	var heap_$_19 : Heap;
	var heap_$_20 : Heap;
	var heap_$_21 : Heap;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$1 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$4 : bool;
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
	if ($_$_condition) { goto anon16_Then; } else { goto anon16_Else; }
anon16_Then:
	assume $_$_condition;
	assume heap_$_4 == heap_$_3[r1 := 1];
	assume heap_$_6 == heap_$_4;
	goto anon3;
anon16_Else:
	assume !$_$_condition;
	assume heap_$_5 == heap_$_3[r2 := 1];
	assume heap_$_6 == heap_$_5;
	goto anon3;
anon3:
	assume heap_$_7 == heap_$_6[r2 := 1];
	if ($_$_condition_$0) { goto anon17_Then; } else { goto anon17_Else; }
anon17_Then:
	assume $_$_condition_$0;
	assume heap_$_8 == heap_$_7[r1 := 2];
	assume heap_$_10 == heap_$_8;
	goto anon6;
anon17_Else:
	assume !$_$_condition_$0;
	assume heap_$_9 == heap_$_7[r2 := 2];
	assume heap_$_10 == heap_$_9;
	goto anon6;
anon6:
	assume heap_$_11 == heap_$_10[r2 := 1];
	if ($_$_condition_$1) { goto anon18_Then; } else { goto anon18_Else; }
anon18_Then:
	assume $_$_condition_$1;
	assume heap_$_12 == heap_$_11[r1 := 3];
	assume heap_$_14 == heap_$_12;
	goto $branchMerge_0;
anon18_Else:
	assume !$_$_condition_$1;
	assume heap_$_13 == heap_$_11[r2 := 3];
	assume heap_$_14 == heap_$_13;
	goto $branchMerge_0;
anon19_Then:
	assume $_$_condition_$2;
	assume heap_$_15 == heap_$_14[r1 := 4];
	assume heap_$_17 == heap_$_15;
	goto anon12;
anon19_Else:
	assume !$_$_condition_$2;
	assume heap_$_16 == heap_$_14[r2 := 4];
	assume heap_$_17 == heap_$_16;
	goto anon12;
anon12:
	assume heap_$_18 == heap_$_17[r2 := 1];
	if ($_$_condition_$4) { goto anon20_Then; } else { goto anon20_Else; }
anon20_Then:
	assume $_$_condition_$4;
	assume heap_$_19 == heap_$_18[r1 := 5];
	assume heap_$_21 == heap_$_19;
	goto anon15;
anon20_Else:
	assume !$_$_condition_$4;
	assume heap_$_20 == heap_$_18[r2 := 5];
	assume heap_$_21 == heap_$_20;
	goto anon15;
anon15:
	assert  heap_$_21[r0] == 0;
	goto $exit;
$branchMerge_0:
	if ($_$_condition_$2) { goto anon19_Then; } else { goto anon19_Else; }
}
