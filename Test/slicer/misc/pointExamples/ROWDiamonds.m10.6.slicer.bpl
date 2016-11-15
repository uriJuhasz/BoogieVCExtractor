type Integer = int;
type Boolean = bool;
type Heap = [ref]int;
type ref;
const unique r0 : ref;
const unique r1 : ref;
const unique r2 : ref;
var heap : Heap;
procedure m10 ()
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
	var heap_$_22 : Heap;
	var heap_$_23 : Heap;
	var heap_$_24 : Heap;
	var heap_$_25 : Heap;
	var heap_$_26 : Heap;
	var heap_$_27 : Heap;
	var heap_$_28 : Heap;
	var heap_$_29 : Heap;
	var heap_$_30 : Heap;
	var heap_$_31 : Heap;
	var heap_$_32 : Heap;
	var heap_$_33 : Heap;
	var heap_$_34 : Heap;
	var heap_$_35 : Heap;
	var heap_$_36 : Heap;
	var heap_$_37 : Heap;
	var heap_$_38 : Heap;
	var heap_$_39 : Heap;
	var heap_$_40 : Heap;
	var $_$_condition : bool;
	var $_$_condition_$0 : bool;
	var $_$_condition_$1 : bool;
	var $_$_condition_$2 : bool;
	var $_$_condition_$4 : bool;
	var $_$_condition_$5 : bool;
	var $_$_condition_$6 : bool;
	var $_$_condition_$7 : bool;
	var $_$_condition_$8 : bool;
	var $_$_condition_$10 : bool;
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
	if ($_$_condition) { goto anon31_Then; } else { goto anon31_Else; }
anon31_Then:
	assume $_$_condition;
	assume heap_$_4 == heap_$_3[r1 := 1];
	assume heap_$_6 == heap_$_4;
	goto anon3;
anon31_Else:
	assume !$_$_condition;
	assume heap_$_5 == heap_$_3[r2 := 1];
	assume heap_$_6 == heap_$_5;
	goto anon3;
anon3:
	assume heap_$_7 == heap_$_6[r2 := 1];
	if ($_$_condition_$0) { goto anon32_Then; } else { goto anon32_Else; }
anon32_Then:
	assume $_$_condition_$0;
	assume heap_$_8 == heap_$_7[r1 := 2];
	assume heap_$_10 == heap_$_8;
	goto anon6;
anon32_Else:
	assume !$_$_condition_$0;
	assume heap_$_9 == heap_$_7[r2 := 2];
	assume heap_$_10 == heap_$_9;
	goto anon6;
anon6:
	assume heap_$_11 == heap_$_10[r2 := 1];
	if ($_$_condition_$1) { goto anon33_Then; } else { goto anon33_Else; }
anon33_Then:
	assume $_$_condition_$1;
	assume heap_$_12 == heap_$_11[r1 := 3];
	assume heap_$_14 == heap_$_12;
	goto $branchMerge_0;
anon33_Else:
	assume !$_$_condition_$1;
	assume heap_$_13 == heap_$_11[r2 := 3];
	assume heap_$_14 == heap_$_13;
	goto $branchMerge_0;
anon34_Then:
	assume $_$_condition_$2;
	assume heap_$_15 == heap_$_14[r1 := 4];
	assume heap_$_17 == heap_$_15;
	goto anon12;
anon34_Else:
	assume !$_$_condition_$2;
	assume heap_$_16 == heap_$_14[r2 := 4];
	assume heap_$_17 == heap_$_16;
	goto anon12;
anon12:
	assume heap_$_18 == heap_$_17[r2 := 1];
	if ($_$_condition_$4) { goto anon35_Then; } else { goto anon35_Else; }
anon35_Then:
	assume $_$_condition_$4;
	assume heap_$_19 == heap_$_18[r1 := 5];
	assume heap_$_21 == heap_$_19;
	goto anon15;
anon35_Else:
	assume !$_$_condition_$4;
	assume heap_$_20 == heap_$_18[r2 := 5];
	assume heap_$_21 == heap_$_20;
	goto anon15;
anon15:
	assume heap_$_22 == heap_$_21[r1 := 1];
	if ($_$_condition_$5) { goto anon36_Then; } else { goto anon36_Else; }
anon36_Then:
	assume $_$_condition_$5;
	assume heap_$_23 == heap_$_22[r1 := 6];
	assume heap_$_25 == heap_$_23;
	goto anon18;
anon36_Else:
	assume !$_$_condition_$5;
	assume heap_$_24 == heap_$_22[r2 := 6];
	assume heap_$_25 == heap_$_24;
	goto anon18;
anon18:
	assume heap_$_26 == heap_$_25[r2 := 1];
	if ($_$_condition_$6) { goto anon37_Then; } else { goto anon37_Else; }
anon37_Then:
	assume $_$_condition_$6;
	assume heap_$_27 == heap_$_26[r1 := 7];
	assume heap_$_29 == heap_$_27;
	goto anon21;
anon37_Else:
	assume !$_$_condition_$6;
	assume heap_$_28 == heap_$_26[r2 := 7];
	assume heap_$_29 == heap_$_28;
	goto anon21;
anon21:
	assume heap_$_30 == heap_$_29[r2 := 1];
	if ($_$_condition_$7) { goto anon38_Then; } else { goto anon38_Else; }
anon38_Then:
	assume $_$_condition_$7;
	assume heap_$_31 == heap_$_30[r1 := 8];
	assume heap_$_33 == heap_$_31;
	goto $branchMerge_1;
anon38_Else:
	assume !$_$_condition_$7;
	assume heap_$_32 == heap_$_30[r2 := 8];
	assume heap_$_33 == heap_$_32;
	goto $branchMerge_1;
anon39_Then:
	assume $_$_condition_$8;
	assume heap_$_34 == heap_$_33[r1 := 9];
	assume heap_$_36 == heap_$_34;
	goto anon27;
anon39_Else:
	assume !$_$_condition_$8;
	assume heap_$_35 == heap_$_33[r2 := 9];
	assume heap_$_36 == heap_$_35;
	goto anon27;
anon27:
	assume heap_$_37 == heap_$_36[r2 := 1];
	if ($_$_condition_$10) { goto anon40_Then; } else { goto anon40_Else; }
anon40_Then:
	assume $_$_condition_$10;
	assume heap_$_38 == heap_$_37[r1 := 10];
	assume heap_$_40 == heap_$_38;
	goto anon30;
anon40_Else:
	assume !$_$_condition_$10;
	assume heap_$_39 == heap_$_37[r2 := 10];
	assume heap_$_40 == heap_$_39;
	goto anon30;
anon30:
	assert  heap_$_40[r0] == 0;
	goto $exit;
$branchMerge_0:
	if ($_$_condition_$2) { goto anon34_Then; } else { goto anon34_Else; }
$branchMerge_1:
	if ($_$_condition_$8) { goto anon39_Then; } else { goto anon39_Else; }
}
