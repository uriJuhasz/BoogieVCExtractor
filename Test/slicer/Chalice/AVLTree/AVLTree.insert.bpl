procedure AVLTree.insert(this: ref where (this == null) || (dtype(this) == AVLTree#t), k#0: int where true) returns ()
  modifies Heap, Mask, SecMask, Credits;
  requires this!=null;
  free requires wf(Heap, Mask, SecMask);
{
  var methodK#_37: int;
  var unfoldK#_38: int;
  var oldVers#_50: int;
  var newVers#_51: int;
  var cond#_52: bool;
  var n#2: ref where (n#2 == null) || (dtype(n#2) == AVLTreeNode#t);
  var nw#_53: ref;
  var methodCallK#_58: int;
  var this#118: ref where (this#118 == null) || (dtype(this#118) == AVLTreeNode#t);
  var k#119: int where true;
  var callHeap#_54: HeapType;
  var callMask#_55: MaskType;
  var callSecMask#_56: MaskType;
  var callCredits#_57: CreditsType;
  var exhaleMask#_60: MaskType;
  var exhaleHeap#_59: HeapType;
  var isHeld#_67: int;
  var isRdHeld#_68: bool;
  var methodCallK#_73: int;
  var this#120: ref where (this#120 == null) || (dtype(this#120) == AVLTreeNode#t);
  var k#121: int where true;
  var r#122: ref where (r#122 == null) || (dtype(r#122) == AVLTreeNode#t);
  var callHeap#_69: HeapType;
  var callMask#_70: MaskType;
  var callSecMask#_71: MaskType;
  var callCredits#_72: CreditsType;
  var exhaleMask#_75: MaskType;
  var exhaleHeap#_74: HeapType;
  var isHeld#_80: int;
  var isRdHeld#_81: bool;
  var r#75: ref where (r#75 == null) || (dtype(r#75) == AVLTreeNode#t);
  var foldK#_85: int;
  var exhaleMask#_87: MaskType;
  var exhaleHeap#_86: HeapType;
  var predRec#_82: ref;
  var predVer#_83: int;
  var predFlag#_84: bool;
  var exhaleMask#_95: MaskType;
  var exhaleHeap#_94: HeapType;
  assume (0 < methodK#_37) && ((1000 * methodK#_37) < Fractions(1));
  assume CurrentModule == module#default;
  assume CanAssumeFunctionDefs;
  // define pre-initial state
  Mask := ZeroMask;
  SecMask := ZeroMask;
  Credits := ZeroCredits;
  // inhale (precondition)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTree.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, AVLTree.keys] := Mask[this, AVLTree.keys][perm$R := Mask[this, AVLTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTree.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // define initial state
  assume Heap == old(Heap);
  assume Mask == old(Mask);
  assume SecMask == old(SecMask);
  assume Credits == old(Credits);
  // unfold
  assume #AVLTree.valid#trigger(this);
  assume (0 < unfoldK#_38) && (unfoldK#_38 < Fractions(1)) && ((1000 * unfoldK#_38) < methodK#_37);
  assert {:msg "  46.3: The target of the fold statement might be null."} this != null;
  // begin exhale (unfold)
  assert {:msg "  46.3: unfold might fail because the predicate AVLTree.valid does not hold. The permission at <undefined position> might not be positive."} Fractions(100) > 0;
  assert {:msg "  46.3: unfold might fail because the predicate AVLTree.valid does not hold. Insufficient fraction at <undefined position> for AVLTree.valid."} (Fractions(100) <= Mask[this, AVLTree.valid][perm$R]) && ((Fractions(100) == Mask[this, AVLTree.valid][perm$R]) ==> (0 <= Mask[this, AVLTree.valid][perm$N]));
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] - Fractions(100)];
  if (false) {
    // begin exhale (update SecMask)
    if (!(Heap[this, AVLTree.root] == null)) {
      //  assert <undefined position>:  The expression at 16.22 might not evaluate to true.
      assume Seq#Equal(Heap[this, AVLTree.keys], Heap[Heap[this, AVLTree.root], AVLTreeNode.keys]);
    }
    if (Heap[this, AVLTree.root] == null) {
      //  assert <undefined position>:  The expression at 17.22 might not evaluate to true.
      assume Seq#Equal(Heap[this, AVLTree.keys], Seq#Empty());
    }
    SecMask[this, AVLTree.root] := SecMask[this, AVLTree.root][perm$R := SecMask[this, AVLTree.root][perm$R] - Fractions(100)];
    if (SecMask[this, AVLTree.root][perm$R] < 0) {
      SecMask[this, AVLTree.root] := SecMask[this, AVLTree.root][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, AVLTree.keys] := SecMask[this, AVLTree.keys][perm$R := SecMask[this, AVLTree.keys][perm$R] - Fractions(50)];
    if (SecMask[this, AVLTree.keys][perm$R] < 0) {
      SecMask[this, AVLTree.keys] := SecMask[this, AVLTree.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.height] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.height] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(Mask, SecMask, this, AVLTree.valid)) {
    oldVers#_50 := Heap[this, AVLTree.valid];
    havoc newVers#_51;
    Heap[this, AVLTree.valid] := newVers#_51;
    assume oldVers#_50 < Heap[this, AVLTree.valid];
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (unfold)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume (Heap[this, AVLTree.root] == null) || (dtype(Heap[this, AVLTree.root]) == AVLTreeNode#t);
  assume Fractions(100) > 0;
  Mask[this, AVLTree.root] := Mask[this, AVLTree.root][perm$R := Mask[this, AVLTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTree.root]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume true;
  assume Fractions(50) > 0;
  Mask[this, AVLTree.keys] := Mask[this, AVLTree.keys][perm$R := Mask[this, AVLTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTree.keys]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[this, AVLTree.root] != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[Heap[this, AVLTree.root], AVLTreeNode.valid] := Mask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTree.root], AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[this, AVLTree.root] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTree.root], AVLTreeNode.height] := Mask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTree.root], AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[this, AVLTree.root] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTree.root], AVLTreeNode.keys] := Mask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTree.root], AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Heap[this, AVLTree.root] != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor] := Mask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R := Mask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assume Seq#Equal(Heap[this, AVLTree.keys], Heap[Heap[this, AVLTree.root], AVLTreeNode.keys]);
  }
  if (Heap[this, AVLTree.root] == null) {
    assume Seq#Equal(Heap[this, AVLTree.keys], Seq#Empty());
  }
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  // if
  cond#_52 := Heap[this, AVLTree.root] == null;
  assert {:msg "  47.7: Receiver might be null."} true ==> (this != null);
  assert {:msg "  47.7: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTree.root);
  if (cond#_52) {
    // local var n
    // assigment to n
    // new
    havoc nw#_53;
    assume (nw#_53 != null) && (dtype(nw#_53) == AVLTreeNode#t);
    assume (forall<T#_0> f: Field (T#_0) :: (Mask[nw#_53, f][perm$R] == 0) && (Mask[nw#_53, f][perm$N] == 0));
    assume Heap[nw#_53, mu] == $LockBottom;
    assume Heap[nw#_53, held] <= 0;
    assume Heap[nw#_53, rdheld] == false;
    Mask[nw#_53, AVLTreeNode.key] := Mask[nw#_53, AVLTreeNode.key][perm$R := Mask[nw#_53, AVLTreeNode.key][perm$R] + Fractions(100)];
    Mask[nw#_53, AVLTreeNode.height] := Mask[nw#_53, AVLTreeNode.height][perm$R := Mask[nw#_53, AVLTreeNode.height][perm$R] + Fractions(100)];
    Mask[nw#_53, AVLTreeNode.left] := Mask[nw#_53, AVLTreeNode.left][perm$R := Mask[nw#_53, AVLTreeNode.left][perm$R] + Fractions(100)];
    Mask[nw#_53, AVLTreeNode.right] := Mask[nw#_53, AVLTreeNode.right][perm$R := Mask[nw#_53, AVLTreeNode.right][perm$R] + Fractions(100)];
    Mask[nw#_53, AVLTreeNode.keys] := Mask[nw#_53, AVLTreeNode.keys][perm$R := Mask[nw#_53, AVLTreeNode.keys][perm$R] + Fractions(100)];
    Mask[nw#_53, AVLTreeNode.balanceFactor] := Mask[nw#_53, AVLTreeNode.balanceFactor][perm$R := Mask[nw#_53, AVLTreeNode.balanceFactor][perm$R] + Fractions(100)];
    Mask[nw#_53, mu] := Mask[nw#_53, mu][perm$R := Mask[nw#_53, mu][perm$R] + Fractions(100)];
    n#2 := nw#_53;
    assume (0 < methodCallK#_58) && ((1000 * methodCallK#_58) < Fractions(1)) && ((1000 * methodCallK#_58) < methodK#_37);
    // call init
    callHeap#_54 := Heap;
    callMask#_55 := Mask;
    callSecMask#_56 := SecMask;
    callCredits#_57 := Credits;
    assume wf(callHeap#_54, callMask#_55, callSecMask#_56);
    assert {:msg "  49.4: The target of the method call might be null."} n#2 != null;
    this#118 := n#2;
    k#119 := k#0;
    // begin exhale (precondition)
    exhaleMask#_60 := Mask;
    havoc exhaleHeap#_59;
    assert {:msg "  49.4: The precondition at 155.12 might not hold. The permission at 155.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: The precondition at 155.12 might not hold. Insufficient fraction at 155.12 for AVLTreeNode.key."} (Fractions(100) <= exhaleMask#_60[this#118, AVLTreeNode.key][perm$R]) && ((Fractions(100) == exhaleMask#_60[this#118, AVLTreeNode.key][perm$R]) ==> (0 <= exhaleMask#_60[this#118, AVLTreeNode.key][perm$N]));
    exhaleMask#_60[this#118, AVLTreeNode.key] := exhaleMask#_60[this#118, AVLTreeNode.key][perm$R := exhaleMask#_60[this#118, AVLTreeNode.key][perm$R] - Fractions(100)];
    assume IsGoodMask(exhaleMask#_60);
    assume wf(Heap, exhaleMask#_60, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  49.4: The precondition at 156.12 might not hold. The permission at 156.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: The precondition at 156.12 might not hold. Insufficient fraction at 156.12 for AVLTreeNode.height."} (Fractions(100) <= exhaleMask#_60[this#118, AVLTreeNode.height][perm$R]) && ((Fractions(100) == exhaleMask#_60[this#118, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_60[this#118, AVLTreeNode.height][perm$N]));
    exhaleMask#_60[this#118, AVLTreeNode.height] := exhaleMask#_60[this#118, AVLTreeNode.height][perm$R := exhaleMask#_60[this#118, AVLTreeNode.height][perm$R] - Fractions(100)];
    assume IsGoodMask(exhaleMask#_60);
    assume wf(Heap, exhaleMask#_60, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  49.4: The precondition at 157.12 might not hold. The permission at 157.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: The precondition at 157.12 might not hold. Insufficient fraction at 157.12 for AVLTreeNode.left."} (Fractions(100) <= exhaleMask#_60[this#118, AVLTreeNode.left][perm$R]) && ((Fractions(100) == exhaleMask#_60[this#118, AVLTreeNode.left][perm$R]) ==> (0 <= exhaleMask#_60[this#118, AVLTreeNode.left][perm$N]));
    exhaleMask#_60[this#118, AVLTreeNode.left] := exhaleMask#_60[this#118, AVLTreeNode.left][perm$R := exhaleMask#_60[this#118, AVLTreeNode.left][perm$R] - Fractions(100)];
    assume IsGoodMask(exhaleMask#_60);
    assume wf(Heap, exhaleMask#_60, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  49.4: The precondition at 158.12 might not hold. The permission at 158.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: The precondition at 158.12 might not hold. Insufficient fraction at 158.12 for AVLTreeNode.right."} (Fractions(100) <= exhaleMask#_60[this#118, AVLTreeNode.right][perm$R]) && ((Fractions(100) == exhaleMask#_60[this#118, AVLTreeNode.right][perm$R]) ==> (0 <= exhaleMask#_60[this#118, AVLTreeNode.right][perm$N]));
    exhaleMask#_60[this#118, AVLTreeNode.right] := exhaleMask#_60[this#118, AVLTreeNode.right][perm$R := exhaleMask#_60[this#118, AVLTreeNode.right][perm$R] - Fractions(100)];
    assume IsGoodMask(exhaleMask#_60);
    assume wf(Heap, exhaleMask#_60, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  49.4: The precondition at 160.12 might not hold. The permission at 160.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: The precondition at 160.12 might not hold. Insufficient fraction at 160.12 for AVLTreeNode.keys."} (Fractions(100) <= exhaleMask#_60[this#118, AVLTreeNode.keys][perm$R]) && ((Fractions(100) == exhaleMask#_60[this#118, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_60[this#118, AVLTreeNode.keys][perm$N]));
    exhaleMask#_60[this#118, AVLTreeNode.keys] := exhaleMask#_60[this#118, AVLTreeNode.keys][perm$R := exhaleMask#_60[this#118, AVLTreeNode.keys][perm$R] - Fractions(100)];
    assume IsGoodMask(exhaleMask#_60);
    assume wf(Heap, exhaleMask#_60, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  49.4: The precondition at 161.12 might not hold. The permission at 161.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  49.4: The precondition at 161.12 might not hold. Insufficient fraction at 161.12 for AVLTreeNode.balanceFactor."} (Fractions(100) <= exhaleMask#_60[this#118, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(100) == exhaleMask#_60[this#118, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_60[this#118, AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_60[this#118, AVLTreeNode.balanceFactor] := exhaleMask#_60[this#118, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_60[this#118, AVLTreeNode.balanceFactor][perm$R] - Fractions(100)];
    assume IsGoodMask(exhaleMask#_60);
    assume wf(Heap, exhaleMask#_60, SecMask);
    assume wf(Heap, Mask, SecMask);
    Mask := exhaleMask#_60;
    assume IsGoodExhaleState(exhaleHeap#_59, Heap, Mask, SecMask);
    Heap := exhaleHeap#_59;
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end exhale
    // inhale (postcondition)
    assume this#118 != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[this#118, AVLTreeNode.valid] := Mask[this#118, AVLTreeNode.valid][perm$R := Mask[this#118, AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this#118, AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume this#118 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[this#118, AVLTreeNode.keys] := Mask[this#118, AVLTreeNode.keys][perm$R := Mask[this#118, AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this#118, AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume this#118 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[this#118, AVLTreeNode.height] := Mask[this#118, AVLTreeNode.height][perm$R := Mask[this#118, AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this#118, AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume this#118 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[this#118, AVLTreeNode.balanceFactor] := Mask[this#118, AVLTreeNode.balanceFactor][perm$R := Mask[this#118, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[this#118, AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Heap[this#118, AVLTreeNode.height] == 1;
    assume Seq#Equal(Heap[this#118, AVLTreeNode.keys], Seq#Singleton(k#119));
    assume Heap[this#118, AVLTreeNode.balanceFactor] == 0;
    assume Seq#Contains(Heap[this#118, AVLTreeNode.keys], k#119);
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end inhale
    // update field root
    assert {:msg "  50.4: Location might not be writable"} CanWrite(Mask, this, AVLTree.root);
    Heap[this, AVLTree.root] := n#2;
    assume wf(Heap, Mask, SecMask);
  } else {
    assume (0 < methodCallK#_73) && ((1000 * methodCallK#_73) < Fractions(1)) && ((1000 * methodCallK#_73) < methodK#_37);
    // call insert
    callHeap#_69 := Heap;
    callMask#_70 := Mask;
    callSecMask#_71 := SecMask;
    callCredits#_72 := Credits;
    assume wf(callHeap#_69, callMask#_70, callSecMask#_71);
    assert {:msg "  52.14: Receiver might be null."} true ==> (this != null);
    assert {:msg "  52.14: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTree.root);
    assert {:msg "  52.4: The target of the method call might be null."} Heap[this, AVLTree.root] != null;
    this#120 := Heap[this, AVLTree.root];
    k#121 := k#0;
    // begin exhale (precondition)
    exhaleMask#_75 := Mask;
    havoc exhaleHeap#_74;
    assert {:msg "  52.4: The precondition at 185.12 might not hold. The permission at 185.12 might not be positive."} Fractions(100) > 0;
    assert {:msg "  52.4: The precondition at 185.12 might not hold. Insufficient fraction at 185.12 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_75[this#120, AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_75[this#120, AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_75[this#120, AVLTreeNode.valid][perm$N]));
    exhaleMask#_75[this#120, AVLTreeNode.valid] := exhaleMask#_75[this#120, AVLTreeNode.valid][perm$R := exhaleMask#_75[this#120, AVLTreeNode.valid][perm$R] - Fractions(100)];
    if (!CanRead(exhaleMask#_75, SecMask, this#120, AVLTreeNode.valid)) {
      assume Heap[this#120, AVLTreeNode.valid] < exhaleHeap#_74[this#120, AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_75);
    assume wf(Heap, exhaleMask#_75, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  52.4: The precondition at 186.12 might not hold. The permission at 186.12 might not be positive."} Fractions(50) > 0;
    assert {:msg "  52.4: The precondition at 186.12 might not hold. Insufficient fraction at 186.12 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_75[this#120, AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_75[this#120, AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_75[this#120, AVLTreeNode.keys][perm$N]));
    exhaleMask#_75[this#120, AVLTreeNode.keys] := exhaleMask#_75[this#120, AVLTreeNode.keys][perm$R := exhaleMask#_75[this#120, AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_75);
    assume wf(Heap, exhaleMask#_75, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  52.4: The precondition at 187.12 might not hold. The permission at 187.12 might not be positive."} Fractions(50) > 0;
    assert {:msg "  52.4: The precondition at 187.12 might not hold. Insufficient fraction at 187.12 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_75[this#120, AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_75[this#120, AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_75[this#120, AVLTreeNode.height][perm$N]));
    exhaleMask#_75[this#120, AVLTreeNode.height] := exhaleMask#_75[this#120, AVLTreeNode.height][perm$R := exhaleMask#_75[this#120, AVLTreeNode.height][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_75);
    assume wf(Heap, exhaleMask#_75, SecMask);
    assume wf(Heap, Mask, SecMask);
    assert {:msg "  52.4: The precondition at 188.12 might not hold. The permission at 188.12 might not be positive."} Fractions(50) > 0;
    assert {:msg "  52.4: The precondition at 188.12 might not hold. Insufficient fraction at 188.12 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_75[this#120, AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_75[this#120, AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_75[this#120, AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_75[this#120, AVLTreeNode.balanceFactor] := exhaleMask#_75[this#120, AVLTreeNode.balanceFactor][perm$R := exhaleMask#_75[this#120, AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume IsGoodMask(exhaleMask#_75);
    assume wf(Heap, exhaleMask#_75, SecMask);
    assume wf(Heap, Mask, SecMask);
    Mask := exhaleMask#_75;
    assume IsGoodExhaleState(exhaleHeap#_74, Heap, Mask, SecMask);
    Heap := exhaleHeap#_74;
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end exhale
    havoc r#122;
    // inhale (postcondition)
    assume !(r#122 == null);
    assume r#122 != null;
    assume wf(Heap, Mask, SecMask);
    assume Fractions(100) > 0;
    Mask[r#122, AVLTreeNode.valid] := Mask[r#122, AVLTreeNode.valid][perm$R := Mask[r#122, AVLTreeNode.valid][perm$R] + Fractions(100)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[r#122, AVLTreeNode.valid]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume r#122 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[r#122, AVLTreeNode.keys] := Mask[r#122, AVLTreeNode.keys][perm$R := Mask[r#122, AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[r#122, AVLTreeNode.keys]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume r#122 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[r#122, AVLTreeNode.height] := Mask[r#122, AVLTreeNode.height][perm$R := Mask[r#122, AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[r#122, AVLTreeNode.height]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume r#122 != null;
    assume wf(Heap, Mask, SecMask);
    assume true;
    assume Fractions(50) > 0;
    Mask[r#122, AVLTreeNode.balanceFactor] := Mask[r#122, AVLTreeNode.balanceFactor][perm$R := Mask[r#122, AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(Mask);
    assume IsGoodState(heapFragment(Heap[r#122, AVLTreeNode.balanceFactor]));
    assume wf(Heap, Mask, SecMask);
    assume wf(Heap, Mask, SecMask);
    assume Seq#Contains(Heap[r#122, AVLTreeNode.keys], k#121);
    assume (forall i#82#123: int :: (0 <= i#82#123) && (i#82#123 < Seq#Length(callHeap#_69[this#120, AVLTreeNode.keys])) ==> Seq#Contains(Heap[r#122, AVLTreeNode.keys], Seq#Index(callHeap#_69[this#120, AVLTreeNode.keys], i#82#123)));
    assume (forall i#83#124: int :: (0 <= i#83#124) && (i#83#124 < Seq#Length(Heap[r#122, AVLTreeNode.keys])) ==> (Seq#Contains(callHeap#_69[this#120, AVLTreeNode.keys], Seq#Index(Heap[r#122, AVLTreeNode.keys], i#83#124)) || (Seq#Index(Heap[r#122, AVLTreeNode.keys], i#83#124) == k#121)));
    if (Seq#Contains(callHeap#_69[this#120, AVLTreeNode.keys], k#121)) {
      assume Seq#Equal(Heap[r#122, AVLTreeNode.keys], callHeap#_69[this#120, AVLTreeNode.keys]);
    }
    if (!Seq#Contains(callHeap#_69[this#120, AVLTreeNode.keys], k#121)) {
      assume Seq#Length(Heap[r#122, AVLTreeNode.keys]) == (Seq#Length(callHeap#_69[this#120, AVLTreeNode.keys]) + 1);
    }
    assume (Heap[r#122, AVLTreeNode.height] == callHeap#_69[this#120, AVLTreeNode.height]) || (Heap[r#122, AVLTreeNode.height] == (callHeap#_69[this#120, AVLTreeNode.height] + 1));
    if (Seq#Contains(callHeap#_69[this#120, AVLTreeNode.keys], k#121)) {
      assume Heap[r#122, AVLTreeNode.height] == callHeap#_69[this#120, AVLTreeNode.height];
    }
    assume IsGoodMask(Mask);
    assume wf(Heap, Mask, SecMask);
    // end inhale
    r#75 := r#122;
    // update field root
    assert {:msg "  53.4: Location might not be writable"} CanWrite(Mask, this, AVLTree.root);
    Heap[this, AVLTree.root] := r#75;
    assume wf(Heap, Mask, SecMask);
  }
  // update field keys
  assert {:msg "  55.3: Location might not be writable"} CanWrite(Mask, this, AVLTree.keys);
  assert {:msg "  55.11: Receiver might be null."} true ==> (this != null);
  assert {:msg "  55.11: Location might not be readable."} true ==> CanRead(Mask, SecMask, this, AVLTree.root);
  assert {:msg "  55.11: Receiver might be null."} true ==> (Heap[this, AVLTree.root] != null);
  assert {:msg "  55.11: Location might not be readable."} true ==> CanRead(Mask, SecMask, Heap[this, AVLTree.root], AVLTreeNode.keys);
  Heap[this, AVLTree.keys] := Heap[Heap[this, AVLTree.root], AVLTreeNode.keys];
  assume wf(Heap, Mask, SecMask);
  // fold
  assume #AVLTree.valid#trigger(this);
  assume (0 < foldK#_85) && ((1000 * foldK#_85) < Fractions(1)) && ((1000 * foldK#_85) < methodK#_37);
  assert {:msg "  56.3: The target of the fold statement might be null."} this != null;
  // begin exhale (fold)
  exhaleMask#_87 := Mask;
  havoc exhaleHeap#_86;
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 16.22 might not evaluate to true."} Seq#Equal(Heap[this, AVLTree.keys], Heap[Heap[this, AVLTree.root], AVLTreeNode.keys]);
  }
  if (Heap[this, AVLTree.root] == null) {
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The expression at 17.22 might not evaluate to true."} Seq#Equal(Heap[this, AVLTree.keys], Seq#Empty());
  }
  assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 10.6 might not be positive."} Fractions(100) > 0;
  assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 10.6 for AVLTree.root."} (Fractions(100) <= exhaleMask#_87[this, AVLTree.root][perm$R]) && ((Fractions(100) == exhaleMask#_87[this, AVLTree.root][perm$R]) ==> (0 <= exhaleMask#_87[this, AVLTree.root][perm$N]));
  exhaleMask#_87[this, AVLTree.root] := exhaleMask#_87[this, AVLTree.root][perm$R := exhaleMask#_87[this, AVLTree.root][perm$R] - Fractions(100)];
  assume Fractions(100) > 0;
  SecMask[this, AVLTree.root] := SecMask[this, AVLTree.root][perm$R := SecMask[this, AVLTree.root][perm$R] + Fractions(100)];
  assume IsGoodMask(exhaleMask#_87);
  assume wf(Heap, exhaleMask#_87, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 11.6 might not be positive."} Fractions(50) > 0;
  assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 11.6 for AVLTree.keys."} (Fractions(50) <= exhaleMask#_87[this, AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_87[this, AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_87[this, AVLTree.keys][perm$N]));
  exhaleMask#_87[this, AVLTree.keys] := exhaleMask#_87[this, AVLTree.keys][perm$R := exhaleMask#_87[this, AVLTree.keys][perm$R] - Fractions(50)];
  assume Fractions(50) > 0;
  SecMask[this, AVLTree.keys] := SecMask[this, AVLTree.keys][perm$R := SecMask[this, AVLTree.keys][perm$R] + Fractions(50)];
  assume IsGoodMask(exhaleMask#_87);
  assume wf(Heap, exhaleMask#_87, SecMask);
  assume wf(Heap, Mask, SecMask);
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 12.22 might not be positive."} Fractions(100) > 0;
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 12.22 for AVLTreeNode.valid."} (Fractions(100) <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) && ((Fractions(100) == exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R]) ==> (0 <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$N]));
    exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.valid] := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] - Fractions(100)];
    assume Fractions(100) > 0;
    SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] + Fractions(100)];
    if (!CanRead(exhaleMask#_87, SecMask, Heap[this, AVLTree.root], AVLTreeNode.valid)) {
      assume Heap[Heap[this, AVLTree.root], AVLTreeNode.valid] < exhaleHeap#_86[Heap[this, AVLTree.root], AVLTreeNode.valid];
    }
    assume IsGoodMask(exhaleMask#_87);
    assume wf(Heap, exhaleMask#_87, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 13.22 might not be positive."} Fractions(50) > 0;
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 13.22 for AVLTreeNode.height."} (Fractions(50) <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R]) && ((Fractions(50) == exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R]) ==> (0 <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.height][perm$N]));
    exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.height] := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R] - Fractions(50)];
    assume Fractions(50) > 0;
    SecMask[Heap[this, AVLTree.root], AVLTreeNode.height] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R] + Fractions(50)];
    assume IsGoodMask(exhaleMask#_87);
    assume wf(Heap, exhaleMask#_87, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 14.22 might not be positive."} Fractions(50) > 0;
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 14.22 for AVLTreeNode.keys."} (Fractions(50) <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R]) && ((Fractions(50) == exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R]) ==> (0 <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$N]));
    exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.keys] := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R] - Fractions(50)];
    assume Fractions(50) > 0;
    SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R] + Fractions(50)];
    assume IsGoodMask(exhaleMask#_87);
    assume wf(Heap, exhaleMask#_87, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  if (!(Heap[this, AVLTree.root] == null)) {
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. The permission at 15.22 might not be positive."} Fractions(50) > 0;
    assert {:msg "  56.3: Fold might fail because the definition of AVLTree.valid does not hold. Insufficient fraction at 15.22 for AVLTreeNode.balanceFactor."} (Fractions(50) <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R]) && ((Fractions(50) == exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R]) ==> (0 <= exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$N]));
    exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor] := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R := exhaleMask#_87[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
    assume Fractions(50) > 0;
    SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R] + Fractions(50)];
    assume IsGoodMask(exhaleMask#_87);
    assume wf(Heap, exhaleMask#_87, SecMask);
    assume wf(Heap, Mask, SecMask);
  }
  Mask := exhaleMask#_87;
  assume IsGoodExhaleState(exhaleHeap#_86, Heap, Mask, SecMask);
  Heap := exhaleHeap#_86;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  // inhale (fold)
  assume this != null;
  assume wf(Heap, Mask, SecMask);
  assume Fractions(100) > 0;
  Mask[this, AVLTree.valid] := Mask[this, AVLTree.valid][perm$R := Mask[this, AVLTree.valid][perm$R] + Fractions(100)];
  assume IsGoodMask(Mask);
  assume IsGoodState(heapFragment(Heap[this, AVLTree.valid]));
  assume wf(Heap, Mask, SecMask);
  assume wf(Heap, Mask, SecMask);
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end inhale
  predRec#_82 := this;
  predVer#_83 := Heap[this, AVLTree.valid];
  predFlag#_84 := true;
  assume wf(Heap, Mask, SecMask);
  // begin exhale (postcondition)
  exhaleMask#_95 := Mask;
  havoc exhaleHeap#_94;
  assert {:msg "  35.2: The postcondition at 42.11 might not hold. The expression at 42.11 might not evaluate to true."} Seq#Contains(Heap[this, AVLTree.keys], k#0);
  assert {:msg "  35.2: The postcondition at 43.11 might not hold. The expression at 43.11 might not evaluate to true."} (forall j#73#125: int :: (0 <= j#73#125) && (j#73#125 < Seq#Length(old(Heap)[this, AVLTree.keys])) ==> Seq#Contains(Heap[this, AVLTree.keys], Seq#Index(old(Heap)[this, AVLTree.keys], j#73#125)));
  assert {:msg "  35.2: The postcondition at 44.11 might not hold. The expression at 44.11 might not evaluate to true."} (forall j#74#126: int :: (0 <= j#74#126) && (j#74#126 < Seq#Length(Heap[this, AVLTree.keys])) ==> (Seq#Contains(old(Heap)[this, AVLTree.keys], Seq#Index(Heap[this, AVLTree.keys], j#74#126)) || (Seq#Index(Heap[this, AVLTree.keys], j#74#126) == k#0)));
  assert {:msg "  35.2: The postcondition at 39.11 might not hold. The permission at 39.11 might not be positive."} Fractions(100) > 0;
  assert {:msg "  35.2: The postcondition at 39.11 might not hold. Insufficient fraction at 39.11 for AVLTree.valid."} (Fractions(100) <= exhaleMask#_95[this, AVLTree.valid][perm$R]) && ((Fractions(100) == exhaleMask#_95[this, AVLTree.valid][perm$R]) ==> (0 <= exhaleMask#_95[this, AVLTree.valid][perm$N]));
  exhaleMask#_95[this, AVLTree.valid] := exhaleMask#_95[this, AVLTree.valid][perm$R := exhaleMask#_95[this, AVLTree.valid][perm$R] - Fractions(100)];
  if (false || ((predVer#_83 == Heap[this, AVLTree.valid]) && (predRec#_82 == this) && true && (!cond#_52) && predFlag#_84)) {
    // begin exhale (update SecMask)
    if (!(Heap[this, AVLTree.root] == null)) {
      //  assert <undefined position>:  The expression at 16.22 might not evaluate to true.
      assume Seq#Equal(Heap[this, AVLTree.keys], Heap[Heap[this, AVLTree.root], AVLTreeNode.keys]);
    }
    if (Heap[this, AVLTree.root] == null) {
      //  assert <undefined position>:  The expression at 17.22 might not evaluate to true.
      assume Seq#Equal(Heap[this, AVLTree.keys], Seq#Empty());
    }
    SecMask[this, AVLTree.root] := SecMask[this, AVLTree.root][perm$R := SecMask[this, AVLTree.root][perm$R] - Fractions(100)];
    if (SecMask[this, AVLTree.root][perm$R] < 0) {
      SecMask[this, AVLTree.root] := SecMask[this, AVLTree.root][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    SecMask[this, AVLTree.keys] := SecMask[this, AVLTree.keys][perm$R := SecMask[this, AVLTree.keys][perm$R] - Fractions(50)];
    if (SecMask[this, AVLTree.keys][perm$R] < 0) {
      SecMask[this, AVLTree.keys] := SecMask[this, AVLTree.keys][perm$R := 0];
    }
    assume wf(Heap, SecMask, SecMask);
    assume wf(Heap, Mask, SecMask);
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] - Fractions(100)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.valid][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.height] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.height] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.height][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.keys][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    if (!(Heap[this, AVLTree.root] == null)) {
      SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R] - Fractions(50)];
      if (SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R] < 0) {
        SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor] := SecMask[Heap[this, AVLTree.root], AVLTreeNode.balanceFactor][perm$R := 0];
      }
      assume wf(Heap, SecMask, SecMask);
      assume wf(Heap, Mask, SecMask);
    }
    assume wf(Heap, SecMask, SecMask);
    // end exhale
  }
  if (!CanRead(exhaleMask#_95, SecMask, this, AVLTree.valid)) {
    assume Heap[this, AVLTree.valid] < exhaleHeap#_94[this, AVLTree.valid];
  }
  assume IsGoodMask(exhaleMask#_95);
  assume wf(Heap, exhaleMask#_95, SecMask);
  assume wf(Heap, Mask, SecMask);
  assert {:msg "  35.2: The postcondition at 40.11 might not hold. The permission at 40.11 might not be positive."} Fractions(50) > 0;
  assert {:msg "  35.2: The postcondition at 40.11 might not hold. Insufficient fraction at 40.11 for AVLTree.keys."} (Fractions(50) <= exhaleMask#_95[this, AVLTree.keys][perm$R]) && ((Fractions(50) == exhaleMask#_95[this, AVLTree.keys][perm$R]) ==> (0 <= exhaleMask#_95[this, AVLTree.keys][perm$N]));
  exhaleMask#_95[this, AVLTree.keys] := exhaleMask#_95[this, AVLTree.keys][perm$R := exhaleMask#_95[this, AVLTree.keys][perm$R] - Fractions(50)];
  assume IsGoodMask(exhaleMask#_95);
  assume wf(Heap, exhaleMask#_95, SecMask);
  assume wf(Heap, Mask, SecMask);
  Mask := exhaleMask#_95;
  assume IsGoodExhaleState(exhaleHeap#_94, Heap, Mask, SecMask);
  Heap := exhaleHeap#_94;
  assume IsGoodMask(Mask);
  assume wf(Heap, Mask, SecMask);
  // end exhale
  assert {:msg "  35.2: Method might lock/unlock more than allowed."} (forall lk#_106: ref :: {Heap[lk#_106, held]} {Heap[lk#_106, rdheld]} (((0 < Heap[lk#_106, held]) == (0 < old(Heap)[lk#_106, held])) && (Heap[lk#_106, rdheld] == old(Heap)[lk#_106, rdheld])) || false);
  assert {:msg "  35.2: Method body is not allowed to leave any debt."} (forall ch: ref :: (ch == null) || (0 <= Credits[ch]));
}
