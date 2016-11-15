type Integer = int;
type Boolean = bool;
type Heap = [ref]int;
type ref;
const unique r0 : ref;
const unique r1 : ref;
const unique r2 : ref;
var heap : Heap;
procedure m20 ()
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
	var heap_$_41 : Heap;
	var heap_$_42 : Heap;
	var heap_$_43 : Heap;
	var heap_$_44 : Heap;
	var heap_$_45 : Heap;
	var heap_$_46 : Heap;
	var heap_$_47 : Heap;
	var heap_$_48 : Heap;
	var heap_$_49 : Heap;
	var heap_$_50 : Heap;
	var heap_$_51 : Heap;
	var heap_$_52 : Heap;
	var heap_$_53 : Heap;
	var heap_$_54 : Heap;
	var heap_$_55 : Heap;
	var heap_$_56 : Heap;
	var heap_$_57 : Heap;
	var heap_$_58 : Heap;
	var heap_$_59 : Heap;
	var heap_$_60 : Heap;
	var heap_$_61 : Heap;
	var heap_$_62 : Heap;
	var heap_$_63 : Heap;
	var heap_$_64 : Heap;
	var heap_$_65 : Heap;
	var heap_$_66 : Heap;
	var heap_$_67 : Heap;
	var heap_$_68 : Heap;
	var heap_$_69 : Heap;
	var heap_$_70 : Heap;
	var heap_$_71 : Heap;
	var heap_$_72 : Heap;
	var heap_$_73 : Heap;
	var heap_$_74 : Heap;
	var heap_$_75 : Heap;
	var heap_$_76 : Heap;
	var heap_$_77 : Heap;
	var heap_$_78 : Heap;
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
	var $_$_condition_$11 : bool;
	var $_$_condition_$12 : bool;
	var $_$_condition_$13 : bool;
	var $_$_condition_$14 : bool;
	var $_$_condition_$16 : bool;
	var $_$_condition_$17 : bool;
	var $_$_condition_$18 : bool;
	var $_$_condition_$19 : bool;
	var $_$_condition_$20 : bool;
	var $_$_condition_$22 : bool;
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
	if ($_$_condition) { goto anon61_Then; } else { goto anon61_Else; }
anon61_Then:
	assume $_$_condition;
	assume heap_$_4 == heap_$_3[r1 := 1];
	assume heap_$_6 == heap_$_4;
	goto anon3;
anon61_Else:
	assume !$_$_condition;
	assume heap_$_5 == heap_$_3[r2 := 1];
	assume heap_$_6 == heap_$_5;
	goto anon3;
anon3:
	assume heap_$_7 == heap_$_6[r2 := 1];
	if ($_$_condition_$0) { goto anon62_Then; } else { goto anon62_Else; }
anon62_Then:
	assume $_$_condition_$0;
	assume heap_$_8 == heap_$_7[r1 := 2];
	assume heap_$_10 == heap_$_8;
	goto anon6;
anon62_Else:
	assume !$_$_condition_$0;
	assume heap_$_9 == heap_$_7[r2 := 2];
	assume heap_$_10 == heap_$_9;
	goto anon6;
anon6:
	assume heap_$_11 == heap_$_10[r2 := 1];
	if ($_$_condition_$1) { goto anon63_Then; } else { goto anon63_Else; }
anon63_Then:
	assume $_$_condition_$1;
	assume heap_$_12 == heap_$_11[r1 := 3];
	assume heap_$_14 == heap_$_12;
	goto $branchMerge_0;
anon63_Else:
	assume !$_$_condition_$1;
	assume heap_$_13 == heap_$_11[r2 := 3];
	assume heap_$_14 == heap_$_13;
	goto $branchMerge_0;
anon64_Then:
	assume $_$_condition_$2;
	assume heap_$_15 == heap_$_14[r1 := 4];
	assume heap_$_17 == heap_$_15;
	goto anon12;
anon64_Else:
	assume !$_$_condition_$2;
	assume heap_$_16 == heap_$_14[r2 := 4];
	assume heap_$_17 == heap_$_16;
	goto anon12;
anon12:
	assume heap_$_18 == heap_$_17[r2 := 1];
	if ($_$_condition_$4) { goto anon65_Then; } else { goto anon65_Else; }
anon65_Then:
	assume $_$_condition_$4;
	assume heap_$_19 == heap_$_18[r1 := 5];
	assume heap_$_21 == heap_$_19;
	goto anon15;
anon65_Else:
	assume !$_$_condition_$4;
	assume heap_$_20 == heap_$_18[r2 := 5];
	assume heap_$_21 == heap_$_20;
	goto anon15;
anon15:
	assume heap_$_22 == heap_$_21[r1 := 1];
	if ($_$_condition_$5) { goto anon66_Then; } else { goto anon66_Else; }
anon66_Then:
	assume $_$_condition_$5;
	assume heap_$_23 == heap_$_22[r1 := 6];
	assume heap_$_25 == heap_$_23;
	goto anon18;
anon66_Else:
	assume !$_$_condition_$5;
	assume heap_$_24 == heap_$_22[r2 := 6];
	assume heap_$_25 == heap_$_24;
	goto anon18;
anon18:
	assume heap_$_26 == heap_$_25[r2 := 1];
	if ($_$_condition_$6) { goto anon67_Then; } else { goto anon67_Else; }
anon67_Then:
	assume $_$_condition_$6;
	assume heap_$_27 == heap_$_26[r1 := 7];
	assume heap_$_29 == heap_$_27;
	goto anon21;
anon67_Else:
	assume !$_$_condition_$6;
	assume heap_$_28 == heap_$_26[r2 := 7];
	assume heap_$_29 == heap_$_28;
	goto anon21;
anon21:
	assume heap_$_30 == heap_$_29[r2 := 1];
	if ($_$_condition_$7) { goto anon68_Then; } else { goto anon68_Else; }
anon68_Then:
	assume $_$_condition_$7;
	assume heap_$_31 == heap_$_30[r1 := 8];
	assume heap_$_33 == heap_$_31;
	goto $branchMerge_1;
anon68_Else:
	assume !$_$_condition_$7;
	assume heap_$_32 == heap_$_30[r2 := 8];
	assume heap_$_33 == heap_$_32;
	goto $branchMerge_1;
anon69_Then:
	assume $_$_condition_$8;
	assume heap_$_34 == heap_$_33[r1 := 9];
	assume heap_$_36 == heap_$_34;
	goto anon27;
anon69_Else:
	assume !$_$_condition_$8;
	assume heap_$_35 == heap_$_33[r2 := 9];
	assume heap_$_36 == heap_$_35;
	goto anon27;
anon27:
	assume heap_$_37 == heap_$_36[r2 := 1];
	if ($_$_condition_$10) { goto anon70_Then; } else { goto anon70_Else; }
anon70_Then:
	assume $_$_condition_$10;
	assume heap_$_38 == heap_$_37[r1 := 10];
	assume heap_$_40 == heap_$_38;
	goto anon30;
anon70_Else:
	assume !$_$_condition_$10;
	assume heap_$_39 == heap_$_37[r2 := 10];
	assume heap_$_40 == heap_$_39;
	goto anon30;
anon30:
	assume heap_$_41 == heap_$_40[r1 := 1];
	if ($_$_condition_$11) { goto anon71_Then; } else { goto anon71_Else; }
anon71_Then:
	assume $_$_condition_$11;
	assume heap_$_42 == heap_$_41[r1 := 1];
	assume heap_$_44 == heap_$_42;
	goto anon33;
anon71_Else:
	assume !$_$_condition_$11;
	assume heap_$_43 == heap_$_41[r2 := 1];
	assume heap_$_44 == heap_$_43;
	goto anon33;
anon33:
	assume heap_$_45 == heap_$_44[r2 := 1];
	if ($_$_condition_$12) { goto anon72_Then; } else { goto anon72_Else; }
anon72_Then:
	assume $_$_condition_$12;
	assume heap_$_46 == heap_$_45[r1 := 2];
	assume heap_$_48 == heap_$_46;
	goto anon36;
anon72_Else:
	assume !$_$_condition_$12;
	assume heap_$_47 == heap_$_45[r2 := 2];
	assume heap_$_48 == heap_$_47;
	goto anon36;
anon36:
	assume heap_$_49 == heap_$_48[r2 := 1];
	if ($_$_condition_$13) { goto anon73_Then; } else { goto anon73_Else; }
anon73_Then:
	assume $_$_condition_$13;
	assume heap_$_50 == heap_$_49[r1 := 3];
	assume heap_$_52 == heap_$_50;
	goto $branchMerge_2;
anon73_Else:
	assume !$_$_condition_$13;
	assume heap_$_51 == heap_$_49[r2 := 3];
	assume heap_$_52 == heap_$_51;
	goto $branchMerge_2;
anon74_Then:
	assume $_$_condition_$14;
	assume heap_$_53 == heap_$_52[r1 := 4];
	assume heap_$_55 == heap_$_53;
	goto anon42;
anon74_Else:
	assume !$_$_condition_$14;
	assume heap_$_54 == heap_$_52[r2 := 4];
	assume heap_$_55 == heap_$_54;
	goto anon42;
anon42:
	assume heap_$_56 == heap_$_55[r2 := 1];
	if ($_$_condition_$16) { goto anon75_Then; } else { goto anon75_Else; }
anon75_Then:
	assume $_$_condition_$16;
	assume heap_$_57 == heap_$_56[r1 := 5];
	assume heap_$_59 == heap_$_57;
	goto anon45;
anon75_Else:
	assume !$_$_condition_$16;
	assume heap_$_58 == heap_$_56[r2 := 5];
	assume heap_$_59 == heap_$_58;
	goto anon45;
anon45:
	assume heap_$_60 == heap_$_59[r1 := 1];
	if ($_$_condition_$17) { goto anon76_Then; } else { goto anon76_Else; }
anon76_Then:
	assume $_$_condition_$17;
	assume heap_$_61 == heap_$_60[r1 := 6];
	assume heap_$_63 == heap_$_61;
	goto anon48;
anon76_Else:
	assume !$_$_condition_$17;
	assume heap_$_62 == heap_$_60[r2 := 6];
	assume heap_$_63 == heap_$_62;
	goto anon48;
anon48:
	assume heap_$_64 == heap_$_63[r2 := 1];
	if ($_$_condition_$18) { goto anon77_Then; } else { goto anon77_Else; }
anon77_Then:
	assume $_$_condition_$18;
	assume heap_$_65 == heap_$_64[r1 := 7];
	assume heap_$_67 == heap_$_65;
	goto anon51;
anon77_Else:
	assume !$_$_condition_$18;
	assume heap_$_66 == heap_$_64[r2 := 7];
	assume heap_$_67 == heap_$_66;
	goto anon51;
anon51:
	assume heap_$_68 == heap_$_67[r2 := 1];
	if ($_$_condition_$19) { goto anon78_Then; } else { goto anon78_Else; }
anon78_Then:
	assume $_$_condition_$19;
	assume heap_$_69 == heap_$_68[r1 := 8];
	assume heap_$_71 == heap_$_69;
	goto $branchMerge_3;
anon78_Else:
	assume !$_$_condition_$19;
	assume heap_$_70 == heap_$_68[r2 := 8];
	assume heap_$_71 == heap_$_70;
	goto $branchMerge_3;
anon79_Then:
	assume $_$_condition_$20;
	assume heap_$_72 == heap_$_71[r1 := 9];
	assume heap_$_74 == heap_$_72;
	goto anon57;
anon79_Else:
	assume !$_$_condition_$20;
	assume heap_$_73 == heap_$_71[r2 := 9];
	assume heap_$_74 == heap_$_73;
	goto anon57;
anon57:
	assume heap_$_75 == heap_$_74[r2 := 1];
	if ($_$_condition_$22) { goto anon80_Then; } else { goto anon80_Else; }
anon80_Then:
	assume $_$_condition_$22;
	assume heap_$_76 == heap_$_75[r1 := 10];
	assume heap_$_78 == heap_$_76;
	goto anon60;
anon80_Else:
	assume !$_$_condition_$22;
	assume heap_$_77 == heap_$_75[r2 := 10];
	assume heap_$_78 == heap_$_77;
	goto anon60;
anon60:
	assert  heap_$_78[r0] == 0;
	goto $exit;
$branchMerge_0:
	if ($_$_condition_$2) { goto anon64_Then; } else { goto anon64_Else; }
$branchMerge_1:
	if ($_$_condition_$8) { goto anon69_Then; } else { goto anon69_Else; }
$branchMerge_2:
	if ($_$_condition_$14) { goto anon74_Then; } else { goto anon74_Else; }
$branchMerge_3:
	if ($_$_condition_$20) { goto anon79_Then; } else { goto anon79_Else; }
}
