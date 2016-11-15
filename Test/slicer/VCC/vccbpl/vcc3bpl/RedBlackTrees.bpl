axiom $arch_ptr_size == 8;

axiom $arch_spec_ptr_start == $max.u8;

const unique ^$#thread_id: $ctype;

axiom $def_math_type(^$#thread_id);

type $#thread_id;

const unique ^Node: $ctype;

axiom $is_span_sequential(^Node);

axiom $def_struct_type(^Node, 40, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Node) } $inv2(#s1, #s2, #p, ^Node) == $set_eq($owns(#s2, #p), $set_empty()));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Node)) } $in(q, $composite_extent(s, p, ^Node)) == (q == p));

const unique Node.red: $field;

axiom $def_phys_field(^Node, Node.red, ^^bool, false, 0);

const unique Node.key: $field;

axiom $def_phys_field(^Node, Node.key, ^^i4, false, 4);

const unique Node.value: $field;

axiom $def_phys_field(^Node, Node.value, ^^i4, false, 8);

const unique Node.left: $field;

axiom $def_phys_field(^Node, Node.left, $ptr_to(^Node), false, 16);

const unique Node.right: $field;

axiom $def_phys_field(^Node, Node.right, $ptr_to(^Node), false, 24);

const unique Node.parent: $field;

axiom $def_phys_field(^Node, Node.parent, $ptr_to(^Node), false, 32);

const unique ^Tree: $ctype;

axiom $is_span_sequential(^Tree);

axiom $def_struct_type(^Tree, 8, false, false);

axiom (forall #s1: $state, #s2: $state, #p: $ptr :: { $inv2(#s1, #s2, #p, ^Tree) } $inv2(#s1, #s2, #p, ^Tree) == (!$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast($null, ^Node)) && ($non_null($rd_phys_ptr(#s2, Tree.root, #p, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node))) && ($non_null($rd_phys_ptr(#s2, Tree.root, #p, ^Node)) ==> $is_null($rd_phys_ptr(#s2, Node.parent, $rd_phys_ptr(#s2, Tree.root, #p, ^Node), ^Node))) && (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))) && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))) && (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns(#s2, #p))) && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) && (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))) && (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node))) && (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr(#s2, Node.parent, $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node))) && (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr(#s2, Node.parent, $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node))) && (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr(#s2, Node.left, $rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr(#s2, Node.right, $rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node))) && (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv(#s2, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) && (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv(#s2, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(#s2, Tree.abs, #p)), Q#k$1^83.29#tc2) == 0) && (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr(#s2, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr(#s2, Tree.root, #p, ^Node)) && (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Tree.root, #p, ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(#s2, Tree.R, #p)), $rd_phys_ptr(#s2, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))))));

axiom (forall p: $ptr, q: $ptr, s: $state :: { $in(q, $composite_extent(s, p, ^Tree)) } $in(q, $composite_extent(s, p, ^Tree)) == (q == p));

const unique Tree.root: $field;

axiom $def_phys_field(^Tree, Tree.root, $ptr_to(^Node), false, 0);

const unique Tree.abs: $field;

axiom $def_ghost_field(^Tree, Tree.abs, $map_t(^^i4, ^^i4), false);

const unique Tree.R: $field;

axiom $def_ghost_field(^Tree, Tree.R, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)), false);

procedure Tree#adm(P#_this_: $ptr);
  modifies $s, $cev_pc;
  ensures $is_admissibility_check() ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_admissibility_check() ==> $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node), ^Node));
  ensures $is_admissibility_check() ==> (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#_this_, ^Tree))));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_admissibility_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> true;
  ensures $is_admissibility_check() ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
  ensures $is_admissibility_check() ==> (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), Q#k$1^83.29#tc2) == 0);
  ensures $is_admissibility_check() ==> (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_admissibility_check() ==> (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));
  ensures $is_unwrap_check() ==> !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_unwrap_check() ==> $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node), ^Node));
  ensures $is_unwrap_check() ==> (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#_this_, ^Tree))));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
  ensures $is_unwrap_check() ==> (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> true;
  ensures $is_unwrap_check() ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
  ensures $is_unwrap_check() ==> (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#_this_, ^Tree))), Q#k$1^83.29#tc2) == 0);
  ensures $is_unwrap_check() ==> (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node));
  ensures $is_unwrap_check() ==> (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#_this_, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#_this_, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation Tree#adm(P#_this_: $ptr)
{
  var #wrTime$1^77.31: int;
  var #stackframe: int;

  anon6:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^77.31, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^77.31, #loc._this_, $ptr_to_int(P#_this_), $ptr_to(^Tree));
    assume #wrTime$1^77.31 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^77.31, (lambda #p: $ptr :: false));
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assume @_vcc_admissibility_start(_this_); 
    assume $admissibility_start($phys_ptr_cast(P#_this_, ^Tree), ^Tree);
    assume true;
    // if (@_vcc_is_unwrap_check) ...
    if ($is_unwrap_check())
    {
      anon1:
        // assume !(@_vcc_is_stuttering_check); 
        assume !$is_stuttering_check();
        // assume @_vcc_unwrap_check_pre(@state, _this_); 
        assume $unwrap_check_pre($s, $phys_ptr_cast(P#_this_, ^Tree));
        // @_vcc_unwrap_check(_this_)
        call $unwrap_check($phys_ptr_cast(P#_this_, ^Tree));
        assume $good_state_ext(#tok$1^77.31, $s);
        // assert true; 
        assert true;
    }
    else
    {
      anon4:
        assume true;
        // if (@_vcc_is_admissibility_check) ...
        if ($is_admissibility_check())
        {
          anon2:
            // assume @_vcc_admissibility_pre(@state, _this_); 
            assume $admissibility_pre($s, $phys_ptr_cast(P#_this_, ^Tree));
        }
        else
        {
          anon3:
            // assume @_vcc_stuttering_pre(@state, _this_); 
            assume $stuttering_pre($s, $phys_ptr_cast(P#_this_, ^Tree));
        }

      anon5:
        // @_vcc_havoc_others(_this_, @_vcc_typeof((struct Tree*)@null))
        call $havoc_others($phys_ptr_cast(P#_this_, ^Tree), ^Tree);
        assume $good_state_ext(#tok$1^77.31, $s);
        // assert true; 
        assert true;
        // assume ==>(@_vcc_is_stuttering_check, @_vcc_inv2(old(@prestate, @state), @state, _this_)); 
        assume $is_stuttering_check() ==> $inv2(old($s), $s, $phys_ptr_cast(P#_this_, ^Tree), ^Tree);
    }

  #exit:
}



function F#mark(SP#p: $ptr) : $ptr;

const unique cf#mark: $pure_function;

axiom (forall SP#p: $ptr :: { F#mark(SP#p) } $phys_ptr_cast(F#mark(SP#p), ^Node) == $phys_ptr_cast(SP#p, ^Node));

axiom $function_arg_type(cf#mark, 0, $ptr_to(^Node));

axiom $function_arg_type(cf#mark, 1, $ptr_to(^Node));

procedure mark(SP#p: $ptr) returns ($result: $ptr);
  free ensures true;
  ensures $phys_ptr_cast($result, ^Node) == $phys_ptr_cast(SP#p, ^Node);
  free ensures $result == F#mark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#doMark(SP#p: $ptr) : bool;

const unique cf#doMark: $pure_function;

axiom (forall SP#p: $ptr :: { F#doMark(SP#p) } F#doMark(SP#p) == ($phys_ptr_cast(F#mark($phys_ptr_cast(SP#p, ^Node)), ^Node) == $phys_ptr_cast(SP#p, ^Node)));

axiom $function_arg_type(cf#doMark, 0, ^^bool);

axiom $function_arg_type(cf#doMark, 1, $ptr_to(^Node));

procedure doMark(SP#p: $ptr) returns ($result: bool);
  ensures $result == ($phys_ptr_cast(F#mark($phys_ptr_cast(SP#p, ^Node)), ^Node) == $phys_ptr_cast(SP#p, ^Node));
  free ensures $result == F#doMark(SP#p);
  free ensures $call_transition(old($s), $s);



function F#mark2(SP#p: $ptr) : bool;

const unique cf#mark2: $pure_function;

axiom $function_arg_type(cf#mark2, 0, ^^bool);

axiom $function_arg_type(cf#mark2, 1, $ptr_to(^Node));

procedure mark2(SP#p: $ptr) returns ($result: bool);
  free ensures $result == F#mark2(SP#p);
  free ensures $call_transition(old($s), $s);



procedure tree_init(P#t: $ptr);
  modifies $s, $cev_pc;
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#t, ^Tree)))));
  free ensures $call_transition(old($s), $s);



implementation tree_init(P#t: $ptr)
{
  var prestate#23: $state;
  var res_lambda#3#16: $map_t..^^i4.^^i4;
  var res_lambda#1#15: $map_t..$ptr_to..^Node.^^bool;
  var res_lambda#2#14: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;
  var #wrTime$1^87.1: int;
  var #stackframe: int;

  anon7:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^87.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^87.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume #wrTime$1^87.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^87.1, (lambda #p: $ptr :: $set_in(#p, $span($phys_ptr_cast(P#t, ^Tree)))));
    assume $mutable($s, $phys_ptr_cast(P#t, ^Tree));
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @prim_writes_check((t->root)); 
    assert $writable_prim($s, #wrTime$1^87.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
    // *(t->root) := (struct Node*)@null; 
    call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast($null, ^Node)));
    assume $full_stop_ext(#tok$1^91.3, $s);
    // (struct Node* -> (struct Node* -> _Bool)) res_lambda#2#14; 
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#2#14, $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // (struct Node* -> _Bool) res_lambda#1#15; 
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#1#15, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#1#15), $map_t($ptr_to(^Node), ^^bool));
    // res_lambda#1#15 := lambda#1(); 
    call res_lambda#1#15 := lambda#1();
    assume $full_stop_ext(#tok$1^93.12, $s);
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#1#15, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#1#15), $map_t($ptr_to(^Node), ^^bool));
    // res_lambda#2#14 := lambda#2(res_lambda#1#15); 
    call res_lambda#2#14 := lambda#2(res_lambda#1#15);
    assume $full_stop_ext(#tok$1^93.12, $s);
    assume $local_value_is($s, #tok$1^93.12, #loc.res_lambda#2#14, $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14), $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));
    // assert @prim_writes_check((t->R)); 
    assert $writable_prim($s, #wrTime$1^87.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    // *(t->R) := res_lambda#2#14; 
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(res_lambda#2#14));
    assume $full_stop_ext(#tok$1^93.5, $s);
    // (int32_t -> int32_t) res_lambda#3#16; 
    assume $local_value_is($s, #tok$1^94.14, #loc.res_lambda#3#16, $map_t..^^i4.^^i4_to_int(res_lambda#3#16), $map_t(^^i4, ^^i4));
    // res_lambda#3#16 := lambda#3(); 
    call res_lambda#3#16 := lambda#3();
    assume $full_stop_ext(#tok$1^94.14, $s);
    assume $local_value_is($s, #tok$1^94.14, #loc.res_lambda#3#16, $map_t..^^i4.^^i4_to_int(res_lambda#3#16), $map_t(^^i4, ^^i4));
    // assert @prim_writes_check((t->abs)); 
    assert $writable_prim($s, #wrTime$1^87.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.abs));
    // *(t->abs) := res_lambda#3#16; 
    call $write_int(Tree.abs, $phys_ptr_cast(P#t, ^Tree), $map_t..^^i4.^^i4_to_int(res_lambda#3#16));
    assume $full_stop_ext(#tok$1^94.5, $s);
    // assert @writes_check(@_vcc_span(t)); 
    assert (forall #writes$1^95.5: $ptr :: { $dont_instantiate(#writes$1^95.5) } $set_in(#writes$1^95.5, $span($phys_ptr_cast(P#t, ^Tree))) ==> $top_writable($s, #wrTime$1^87.1, #writes$1^95.5));
    // stmt _vcc_set_owns(t, @_vcc_set_empty); 
    call $set_owns($phys_ptr_cast(P#t, ^Tree), $set_empty());
    assume $full_stop_ext(#tok$1^95.5, $s);
    // _math state_t prestate#23; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // prestate#23 := @_vcc_current_state(@state); 
    prestate#23 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#23, $state_to_int(prestate#23), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^87.1, $phys_ptr_cast(P#t, ^Tree));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^97.19: $ptr :: { $dont_instantiate(#writes$1^97.19) } $set_in(#writes$1^97.19, $owns($s, $phys_ptr_cast(P#t, ^Tree))) ==> $top_writable($s, #wrTime$1^87.1, #writes$1^97.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $good_state_ext(#tok$1^97.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @_vcc_ptr_eq_null(*((*((t->root))->parent))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), ^Node));
    // assert @inv_check(forall(struct Node* m; true; unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } true; ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @_vcc_ptr_eq_pure(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @_vcc_ptr_eq_pure(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(*((*((n->parent))->left)), n), @_vcc_ptr_eq_pure(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } true; ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(m, (struct Node*)@null)), @_vcc_ptr_eq_pure(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure tree_find(P#t: $ptr, P#key: int) returns ($result: $ptr);
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  free ensures true;
  ensures $non_null($phys_ptr_cast($result, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast($result, ^Node)) && $rd_inv($s, Node.key, $phys_ptr_cast($result, ^Node)) == P#key;
  ensures $is_null($phys_ptr_cast($result, ^Node)) ==> (forall Q#n$1^104.53#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^104.53#dt1, ^Node)) != P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_find(P#t: $ptr, P#key: int) returns ($result: $ptr)
{
  var loopState#0: $state;
  var L#p: $ptr;
  var #wrTime$1^101.1: int;
  var #stackframe: int;

  anon15:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^101.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^101.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^101.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^101.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^101.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_i4(key); 
    assume $in_range_i4(P#key);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    // struct Node* p; 
    assume $local_value_is($s, #tok$1^106.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    // var struct Node* p
    // assert @reads_check_normal((t->root)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // p := *((t->root)); 
    L#p := $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node);
    assume $local_value_is($s, #tok$1^107.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    loopState#0 := $s;
    while (true)
      invariant $is_null($phys_ptr_cast(L#p, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(F#mark($phys_ptr_cast(L#p, ^Node)), ^Node));
      invariant (forall Q#n$1^110.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#p, ^Node)), $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)) } $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)) == P#key && $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#p, ^Node)), $phys_ptr_cast(Q#n$1^110.31#dt1, ^Node)));
    {
      anon14:
        assume $writes_nothing(old($s), $s);
        assume $timestamp_post(loopState#0, $s);
        assume $full_stop_ext(#tok$1^108.3, $s);
        assume $local_value_is($s, #tok$1^108.3, #loc.key, P#key, ^^i4);
        // assume @_vcc_meta_eq(old(@prestate, @state), @state); 
        assume $meta_eq(loopState#0, $s);
        assume true;
        // if (@_vcc_ptr_neq_null(p)) ...
        if ($non_null($phys_ptr_cast(L#p, ^Node)))
        {
          anon12:
            // assert @reads_check_normal((p->key)); 
            assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
            assume true;
            // if (<(key, *((p->key)))) ...
            if (P#key < $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
            {
              anon8:
                // assert @reads_check_normal((p->left)); 
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                // p := *((p->left)); 
                L#p := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#p, ^Node), ^Node);
                assume $local_value_is($s, #tok$1^113.7, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
            }
            else
            {
              anon11:
                // assert @reads_check_normal((p->key)); 
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                assume true;
                // if (>(key, *((p->key)))) ...
                if (P#key > $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
                {
                  anon9:
                    // assert @reads_check_normal((p->right)); 
                    assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                    // p := *((p->right)); 
                    L#p := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#p, ^Node), ^Node);
                    assume $local_value_is($s, #tok$1^115.7, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
                }
                else
                {
                  anon10:
                    // return p; 
                    $result := $phys_ptr_cast(L#p, ^Node);
                    assert $position_marker();
                    goto #exit;
                }
            }
        }
        else
        {
          anon13:
            // goto #break_10; 
            goto #break_10;
        }

      #continue_10:
        assume true;
    }

  anon16:
    assume $full_stop_ext(#tok$1^108.3, $s);

  #break_10:
    // return (struct Node*)@null; 
    $result := $phys_ptr_cast($null, ^Node);
    assert $position_marker();
    goto #exit;

  anon17:
    // empty

  #exit:
}



procedure tree_lookup(P#t: $ptr, P#key: int) returns ($result: int);
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  free ensures $in_range_i4($result);
  ensures $result == $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), P#key);
  free ensures $writes_nothing(old($s), $s);
  free ensures $call_transition(old($s), $s);



implementation tree_lookup(P#t: $ptr, P#key: int) returns ($result: int)
{
  var L#r: $ptr;
  var #wrTime$1^122.1: int;
  var #stackframe: int;

  anon20:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^122.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^122.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^122.1, #loc.key, P#key, ^^i4);
    assume #wrTime$1^122.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^122.1, (lambda #p: $ptr :: false));
    // assume true; 
    assume true;
    // assume @in_range_i4(key); 
    assume $in_range_i4(P#key);
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    // struct Node* r; 
    assume $local_value_is($s, #tok$1^126.3, #loc.r, $ptr_to_int(L#r), $ptr_to(^Node));
    // non-pure function
    // r := tree_find(t, key); 
    call L#r := tree_find($phys_ptr_cast(P#t, ^Tree), P#key);
    assume $full_stop_ext(#tok$1^126.13, $s);
    assume $local_value_is($s, #tok$1^126.13, #loc.r, $ptr_to_int(L#r), $ptr_to(^Node));
    assume true;
    // if (@_vcc_ptr_eq_null(r)) ...
    if ($is_null($phys_ptr_cast(L#r, ^Node)))
    {
      anon18:
        // assert @_vcc_inv(@state, t); 
        assert $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
        // assume @_vcc_inv(@state, t); 
        assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
        // return 0; 
        $result := 0;
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon19:
        // assert @reads_check_normal((r->value)); 
        assert $thread_local($s, $phys_ptr_cast(L#r, ^Node));
        // return *((r->value)); 
        $result := $rd_inv($s, Node.value, $phys_ptr_cast(L#r, ^Node));
        assert $position_marker();
        goto #exit;
    }

  anon21:
    // empty

  #exit:
}



procedure tree_insert(P#t: $ptr, P#x: $ptr);
  requires !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(P#x, ^Node));
  requires (forall Q#n$1^138.28#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^138.28#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^138.28#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^138.28#dt1, ^Node)) != $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  ensures (forall Q#n$1^139.27#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node)) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node)) == ($phys_ptr_cast(Q#n$1^139.27#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^139.27#dt1, ^Node))));
  ensures $rd_inv(old($s), Node.key, $phys_ptr_cast(P#x, ^Node)) == $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)) && $rd_inv(old($s), Node.value, $phys_ptr_cast(P#x, ^Node)) == $rd_inv($s, Node.value, $phys_ptr_cast(P#x, ^Node));
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree) || $set_in(#p, $span($phys_ptr_cast(P#x, ^Node)))));
  free ensures $call_transition(old($s), $s);



implementation tree_insert(P#t: $ptr, P#x: $ptr)
{
  var prestate#44: $state;
  var owns#42: $ptrset;
  var staticWrapState#41: $state;
  var prestate#43: $state;
  var res_lambda#7#20: $map_t..$ptr_to..^Node.^^bool;
  var owns#39: $ptrset;
  var staticWrapState#38: $state;
  var prestate#40: $state;
  var prestate#37: $state;
  var prestate#35: $state;
  var owns#36: $ptrset;
  var owns#33: $ptrset;
  var staticWrapState#32: $state;
  var prestate#34: $state;
  var prestate#31: $state;
  var prestate#29: $state;
  var owns#30: $ptrset;
  var #wrTime$1^168.28: int;
  var loopState#1: $state;
  var res_lambda#6#19: $map_t..$ptr_to..^Node.^^bool;
  var prestate#28: $state;
  var owns#26: $ptrset;
  var staticWrapState#25: $state;
  var prestate#27: $state;
  var res_lambda#5#18: $map_t..$ptr_to..^Node.^^bool;
  var res_lambda#4#17: $map_t..^^i4.^^i4;
  var assign#13: $ptr;
  var assign#12: $ptr;
  var prestate#24: $state;
  var L#p: $ptr;
  var L#n: $ptr;
  var #wrTime$1^134.1: int;
  var #stackframe: int;

  anon36:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^134.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^134.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^134.1, #loc.x, $ptr_to_int(P#x), $ptr_to(^Node));
    assume #wrTime$1^134.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^134.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree) || $set_in(#p, $span($phys_ptr_cast(P#x, ^Node)))));
    assume $thread_owned($s, $phys_ptr_cast(P#t, ^Tree));
    assume $mutable($s, $phys_ptr_cast(P#x, ^Node));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    // struct Node* n; 
    assume $local_value_is($s, #tok$1^142.3, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
    // struct Node* p; 
    assume $local_value_is($s, #tok$1^142.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    // var struct Node* p
    // var struct Node* n
    // _math state_t prestate#24; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // prestate#24 := @_vcc_current_state(@state); 
    prestate#24 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#t, ^Tree));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $good_state_ext(#tok$1^144.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // struct Node* assign#12; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int(assign#12), $ptr_to(^Node));
    // struct Node* assign#13; 
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int(assign#13), $ptr_to(^Node));
    // assign#13 := (struct Node*)@null; 
    assign#13 := $phys_ptr_cast($null, ^Node);
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#13, $ptr_to_int(assign#13), $ptr_to(^Node));
    // assert @prim_writes_check((x->parent)); 
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.parent));
    // *(x->parent) := assign#13; 
    call $write_int(Node.parent, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(assign#13, ^Node)));
    assume $full_stop_ext(#tok$1^146.24, $s);
    // assign#12 := assign#13; 
    assign#12 := $phys_ptr_cast(assign#13, ^Node);
    assume $local_value_is($s, #tok$2^0.0, #loc.assign#12, $ptr_to_int(assign#12), $ptr_to(^Node));
    // assert @prim_writes_check((x->right)); 
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.right));
    // *(x->right) := assign#12; 
    call $write_int(Node.right, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(assign#12, ^Node)));
    assume $full_stop_ext(#tok$1^146.13, $s);
    // assert @prim_writes_check((x->left)); 
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.left));
    // *(x->left) := assign#12; 
    call $write_int(Node.left, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(assign#12, ^Node)));
    assume $full_stop_ext(#tok$1^146.3, $s);
    // assert @reads_check_normal((t->root)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // p := *((t->root)); 
    L#p := $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node);
    assume $local_value_is($s, #tok$1^148.3, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
    // (int32_t -> int32_t) res_lambda#4#17; 
    assume $local_value_is($s, #tok$1^151.14, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
    // assert @reads_check_normal((t->abs)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((x->value)); 
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    // assert @reads_check_normal((x->key)); 
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    // res_lambda#4#17 := lambda#4(*((t->abs)), *((x->value)), *((x->key))); 
    call res_lambda#4#17 := lambda#4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.value, $phys_ptr_cast(P#x, ^Node)), $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    assume $full_stop_ext(#tok$1^151.14, $s);
    assume $local_value_is($s, #tok$1^151.14, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
    // assert @prim_writes_check((t->abs)); 
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.abs));
    // *(t->abs) := res_lambda#4#17; 
    call $write_int(Tree.abs, $phys_ptr_cast(P#t, ^Tree), $map_t..^^i4.^^i4_to_int(res_lambda#4#17));
    assume $full_stop_ext(#tok$1^151.5, $s);
    // assert @writes_check(@_vcc_span(t)); 
    assert (forall #writes$1^152.5: $ptr :: { $dont_instantiate(#writes$1^152.5) } $set_in(#writes$1^152.5, $span($phys_ptr_cast(P#t, ^Tree))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^152.5));
    // stmt _vcc_set_owns(t, @_vcc_set_union(@_vcc_owns(@state, t), @_vcc_set_singleton(x))); 
    call $set_owns($phys_ptr_cast(P#t, ^Tree), $set_union($owns($s, $phys_ptr_cast(P#t, ^Tree)), $set_singleton($phys_ptr_cast(P#x, ^Node))));
    assume $full_stop_ext(#tok$1^152.5, $s);
    // (struct Node* -> _Bool) res_lambda#5#18; 
    assume $local_value_is($s, #tok$1^153.15, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
    // res_lambda#5#18 := lambda#5(x); 
    call res_lambda#5#18 := lambda#5($phys_ptr_cast(P#x, ^Node));
    assume $full_stop_ext(#tok$1^153.15, $s);
    assume $local_value_is($s, #tok$1^153.15, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
    // assert @prim_writes_check((t->R)); 
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // *(t->R) := @map_updated(*((t->R)), x, res_lambda#5#18); 
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(P#x, ^Node), res_lambda#5#18)));
    assume $full_stop_ext(#tok$1^153.5, $s);
    assume true;
    // if (@_vcc_ptr_eq_null(p)) ...
    if ($is_null($phys_ptr_cast(L#p, ^Node)))
    {
      anon22:
        // assert @prim_writes_check((t->root)); 
        assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
        // *(t->root) := x; 
        call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
        assume $full_stop_ext(#tok$1^157.5, $s);
        // _math state_t prestate#27; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // prestate#27 := @_vcc_current_state(@state); 
        prestate#27 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        // _math state_t staticWrapState#25; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        // staticWrapState#25 := @_vcc_current_state(@state); 
        staticWrapState#25 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        // _math ptrset owns#26; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // owns#26 := @_vcc_set_empty; 
        owns#26 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        // assert @writes_check(x); 
        assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#x, ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(x), staticWrapState#25, owns#26)
        call $static_wrap($phys_ptr_cast(P#x, ^Node), staticWrapState#25, owns#26);
        assume $good_state_ext(#tok$1^158.21, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $phys_ptr_cast(P#x, ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // _math state_t prestate#28; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // prestate#28 := @_vcc_current_state(@state); 
        prestate#28 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        // assume @_vcc_pre_wrap(@state); 
        assume $pre_wrap($s);
        // assert @writes_check(t); 
        assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#t, ^Tree));
        // assert @writes_check(@_vcc_owns(@state, t)); 
        assert (forall #writes$1^159.21: $ptr :: { $dont_instantiate(#writes$1^159.21) } $set_in(#writes$1^159.21, $owns($s, $phys_ptr_cast(P#t, ^Tree))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^159.21));
        // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
        call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
        assume $good_state_ext(#tok$1^159.21, $s);
        // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
        assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
        // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
        assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
        // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @_vcc_ptr_eq_null(*((*((t->root))->parent))))); 
        assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), ^Node));
        // assert @inv_check(forall(struct Node* m; true; unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
        assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } true; ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
        assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
        assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
        assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @_vcc_ptr_eq_pure(*((*((n->left))->parent)), n)))); 
        assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
        // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
        assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @_vcc_ptr_eq_pure(*((*((n->right))->parent)), n)))); 
        assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
        // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
        assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
        // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(*((*((n->parent))->left)), n), @_vcc_ptr_eq_pure(*((*((n->parent))->right)), n))))); 
        assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
        // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
        assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
        // assert @inv_check(true); 
        assert true;
        // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
        assert (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
        // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
        assert (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) == 0);
        // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(n, *((t->root))))))); 
        assert (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
        // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } true; ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(m, (struct Node*)@null)), @_vcc_ptr_eq_pure(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
        assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // return; 
        assert $position_marker();
        goto #exit;
    }
    else
    {
      anon23:
        // empty
    }

  anon37:
    // (struct Node* -> _Bool) res_lambda#6#19; 
    assume $local_value_is($s, #tok$1^163.41, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((t->root)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // res_lambda#6#19 := lambda#6(old(@prestate, @map_get(*((t->R)), *((t->root)))), x); 
    call res_lambda#6#19 := lambda#6($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(P#x, ^Node));
    assume $full_stop_ext(#tok$1^163.41, $s);
    assume $local_value_is($s, #tok$1^163.41, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
    // assert @prim_writes_check((t->R)); 
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((t->root)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // *(t->R) := @map_updated(*((t->R)), *((t->root)), res_lambda#6#19); 
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), res_lambda#6#19)));
    assume $full_stop_ext(#tok$1^163.25, $s);
    // assert doMark(*((t->root))); 
    assert F#doMark($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assume doMark(*((t->root))); 
    assume F#doMark($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @map_get(@map_get(*((t->R)), *((t->root))), x); 
    assert $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(P#x, ^Node));
    // assume @map_get(@map_get(*((t->R)), *((t->root))), x); 
    assume $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(P#x, ^Node));
    call $bump_timestamp();
    assume $full_stop_ext(#tok$1^168.28, $s);
    loopState#1 := $s;
    assume #wrTime$1^168.28 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^168.28, (lambda #p: $ptr :: $set_in(#p, $set_difference($owns($s, $phys_ptr_cast(P#t, ^Tree)), $set_singleton($phys_ptr_cast(P#x, ^Node)))) || #p == $dot($phys_ptr_cast(P#t, ^Tree), Tree.R)));
    assert (forall #loopWrites^$1^168.28: $ptr :: { $dont_instantiate(#loopWrites^$1^168.28) } $listed_in_writes($s, #wrTime$1^168.28, #loopWrites^$1^168.28) ==> $top_writable($s, #wrTime$1^134.1, #loopWrites^$1^168.28));
    while (true)
      invariant (forall Q#p$1^169.32#tc3: $ptr :: {:weight 10} { $set_in(Q#p$1^169.32#tc3, $owns($s, $phys_ptr_cast(P#t, ^Tree))) } { sk_hack($set_in(Q#p$1^169.32#tc3, $owns($s, $phys_ptr_cast(P#t, ^Tree)))) } $set_in(Q#p$1^169.32#tc3, $owns($s, $phys_ptr_cast(P#t, ^Tree))) ==> Q#p$1^169.32#tc3 == $phys_ptr_cast(P#x, ^Node) || $wrapped($s, Q#p$1^169.32#tc3, $typ(Q#p$1^169.32#tc3)));
      invariant $mutable($s, $phys_ptr_cast(P#x, ^Node));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(loopState#1, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr(loopState#1, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(loopState#1, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)));
      invariant $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(loopState#1, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(P#x, ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(P#x, ^Node)));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
      invariant $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
      invariant $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), ^Node));
      invariant (forall Q#m$1^171.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant (forall Q#m$1^171.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^171.31#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^171.31#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr, Q#m$1^171.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), $phys_ptr_cast(Q#m$1^171.31#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node)));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node));
      invariant (forall Q#n$1^171.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)), $phys_ptr_cast(Q#n$1^171.31#dt1, ^Node)));
      invariant true;
      invariant (forall Q#m$1^172.31#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)));
      invariant (forall Q#k$1^172.31#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^172.31#tc2) } $in_range_i4(Q#k$1^172.31#tc2) ==> (forall Q#m$1^172.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^172.31#dt1, ^Node)) != Q#k$1^172.31#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^172.31#tc2) == 0);
      invariant (forall Q#n$1^173.31#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node) || $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
      invariant (forall Q#n$1^173.31#dt1: $ptr, Q#m$1^173.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^173.31#dt1, ^Node) == $phys_ptr_cast(L#p, ^Node) && $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node)) || $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node) == $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^173.31#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^173.31#dt1, ^Node)))));
      invariant $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(L#p, ^Node));
      invariant $phys_ptr_cast(L#p, ^Node) != $phys_ptr_cast(P#x, ^Node);
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#p, ^Node), ^Node)), $phys_ptr_cast(P#x, ^Node));
      invariant !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#p, ^Node), ^Node)), $phys_ptr_cast(P#x, ^Node));
      invariant (forall Q#n$1^176.31#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node)) ==> $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node) == $phys_ptr_cast(P#x, ^Node) || $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^176.31#dt1, ^Node)) != $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    {
      anon35:
        assume $modifies(loopState#1, $s, (lambda #p: $ptr :: $set_in(#p, $set_difference($owns(loopState#1, $phys_ptr_cast(P#t, ^Tree)), $set_singleton($phys_ptr_cast(P#x, ^Node)))) || #p == $dot($phys_ptr_cast(P#t, ^Tree), Tree.R)));
        assume $timestamp_post(loopState#1, $s);
        assume $full_stop_ext(#tok$1^167.3, $s);
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#6#19, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#6#19), $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#28, $state_to_int(prestate#28), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.owns#26, $ptrset_to_int(owns#26), ^$#ptrset);
        assume $local_value_is($s, #tok$1^167.3, #loc.staticWrapState#25, $state_to_int(staticWrapState#25), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#27, $state_to_int(prestate#27), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#5#18, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#5#18), $map_t($ptr_to(^Node), ^^bool));
        assume $local_value_is($s, #tok$1^167.3, #loc.res_lambda#4#17, $map_t..^^i4.^^i4_to_int(res_lambda#4#17), $map_t(^^i4, ^^i4));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#13, $ptr_to_int(assign#13), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.assign#12, $ptr_to_int(assign#12), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.prestate#24, $state_to_int(prestate#24), ^$#state_t);
        assume $local_value_is($s, #tok$1^167.3, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
        assume $local_value_is($s, #tok$1^167.3, #loc.x, $ptr_to_int(P#x), $ptr_to(^Node));
        assume true;
        // if (true) ...
        if (true)
        {
          anon32:
            // assert @reads_check_normal((x->key)); 
            assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
            // assert @reads_check_normal((p->key)); 
            assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
            assume true;
            // if (<(*((x->key)), *((p->key)))) ...
            if ($rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
            {
              anon26:
                // assert @reads_check_normal((p->left)); 
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                // n := *((p->left)); 
                L#n := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#p, ^Node), ^Node);
                assume $local_value_is($s, #tok$1^179.7, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
                assume true;
                // if (@_vcc_ptr_eq_null(n)) ...
                if ($is_null($phys_ptr_cast(L#n, ^Node)))
                {
                  anon24:
                    // _math ptrset owns#30; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    // owns#30 := @_vcc_set_empty; 
                    owns#30 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#30, $ptrset_to_int(owns#30), ^$#ptrset);
                    // _math state_t prestate#29; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    // prestate#29 := @_vcc_current_state(@state); 
                    prestate#29 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#29, $state_to_int(prestate#29), ^$#state_t);
                    // _math state_t prestate#31; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    // prestate#31 := @_vcc_current_state(@state); 
                    prestate#31 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#31, $state_to_int(prestate#31), ^$#state_t);
                    // assert @_vcc_wrapped(@state, p); 
                    assert $wrapped($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                    // assert @writes_check(p); 
                    assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                    // assume @_vcc_inv(@state, p); 
                    assume $inv($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                    // assume ==(owns#30, @_vcc_owns(@state, p)); 
                    assume owns#30 == $owns($s, $phys_ptr_cast(L#p, ^Node));
                    // assume @_vcc_pre_static_unwrap(@state); 
                    assume $pre_static_unwrap($s);
                    // @_vcc_static_unwrap(pure(p), prestate#31)
                    call $static_unwrap($phys_ptr_cast(L#p, ^Node), prestate#31);
                    assume $good_state_ext(#tok$1^181.36, $s);
                    // assume @_vcc_full_stop(@state); 
                    assume $full_stop($s);
                    // assert @prim_writes_check((p->left)); 
                    assert $writable_prim($s, #wrTime$1^168.28, $dot($phys_ptr_cast(L#p, ^Node), Node.left));
                    // *(p->left) := x; 
                    call $write_int(Node.left, $phys_ptr_cast(L#p, ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
                    assume $full_stop_ext(#tok$1^181.41, $s);
                    // _math state_t prestate#34; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    // prestate#34 := @_vcc_current_state(@state); 
                    prestate#34 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#34, $state_to_int(prestate#34), ^$#state_t);
                    // _math state_t staticWrapState#32; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
                    // staticWrapState#32 := @_vcc_current_state(@state); 
                    staticWrapState#32 := $current_state($s);
                    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#32, $state_to_int(staticWrapState#32), ^$#state_t);
                    // _math ptrset owns#33; 
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    // owns#33 := @_vcc_set_empty; 
                    owns#33 := $set_empty();
                    assume $local_value_is($s, #tok$2^0.0, #loc.owns#33, $ptrset_to_int(owns#33), ^$#ptrset);
                    // assert @writes_check(p); 
                    assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                    // assume @_vcc_pre_static_wrap(@state); 
                    assume $pre_static_wrap($s);
                    // @_vcc_static_wrap(pure(p), staticWrapState#32, owns#33)
                    call $static_wrap($phys_ptr_cast(L#p, ^Node), staticWrapState#32, owns#33);
                    assume $good_state_ext(#tok$1^181.36, $s);
                    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, p), @_vcc_set_empty)); 
                    assert $set_eq($owns($s, $phys_ptr_cast(L#p, ^Node)), $set_empty());
                    // assume @_vcc_full_stop(@state); 
                    assume $full_stop($s);
                    // goto #break_11; 
                    goto #break_11;
                }
                else
                {
                  anon25:
                    // empty
                }
            }
            else
            {
              anon31:
                // assert @reads_check_normal((x->key)); 
                assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
                // assert @reads_check_normal((p->key)); 
                assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                assume true;
                // if (>(*((x->key)), *((p->key)))) ...
                if ($rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(L#p, ^Node)))
                {
                  anon29:
                    // assert @reads_check_normal((p->right)); 
                    assert $thread_local($s, $phys_ptr_cast(L#p, ^Node));
                    // n := *((p->right)); 
                    L#n := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#p, ^Node), ^Node);
                    assume $local_value_is($s, #tok$1^185.7, #loc.n, $ptr_to_int(L#n), $ptr_to(^Node));
                    assume true;
                    // if (@_vcc_ptr_eq_null(n)) ...
                    if ($is_null($phys_ptr_cast(L#n, ^Node)))
                    {
                      anon27:
                        // _math ptrset owns#36; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        // owns#36 := @_vcc_set_empty; 
                        owns#36 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#36, $ptrset_to_int(owns#36), ^$#ptrset);
                        // _math state_t prestate#35; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        // prestate#35 := @_vcc_current_state(@state); 
                        prestate#35 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#35, $state_to_int(prestate#35), ^$#state_t);
                        // _math state_t prestate#37; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        // prestate#37 := @_vcc_current_state(@state); 
                        prestate#37 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#37, $state_to_int(prestate#37), ^$#state_t);
                        // assert @_vcc_wrapped(@state, p); 
                        assert $wrapped($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                        // assert @writes_check(p); 
                        assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                        // assume @_vcc_inv(@state, p); 
                        assume $inv($s, $phys_ptr_cast(L#p, ^Node), ^Node);
                        // assume ==(owns#36, @_vcc_owns(@state, p)); 
                        assume owns#36 == $owns($s, $phys_ptr_cast(L#p, ^Node));
                        // assume @_vcc_pre_static_unwrap(@state); 
                        assume $pre_static_unwrap($s);
                        // @_vcc_static_unwrap(pure(p), prestate#37)
                        call $static_unwrap($phys_ptr_cast(L#p, ^Node), prestate#37);
                        assume $good_state_ext(#tok$1^187.36, $s);
                        // assume @_vcc_full_stop(@state); 
                        assume $full_stop($s);
                        // assert @prim_writes_check((p->right)); 
                        assert $writable_prim($s, #wrTime$1^168.28, $dot($phys_ptr_cast(L#p, ^Node), Node.right));
                        // *(p->right) := x; 
                        call $write_int(Node.right, $phys_ptr_cast(L#p, ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
                        assume $full_stop_ext(#tok$1^187.41, $s);
                        // _math state_t prestate#40; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        // prestate#40 := @_vcc_current_state(@state); 
                        prestate#40 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#40, $state_to_int(prestate#40), ^$#state_t);
                        // _math state_t staticWrapState#38; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#38, $state_to_int(staticWrapState#38), ^$#state_t);
                        // staticWrapState#38 := @_vcc_current_state(@state); 
                        staticWrapState#38 := $current_state($s);
                        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#38, $state_to_int(staticWrapState#38), ^$#state_t);
                        // _math ptrset owns#39; 
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        // owns#39 := @_vcc_set_empty; 
                        owns#39 := $set_empty();
                        assume $local_value_is($s, #tok$2^0.0, #loc.owns#39, $ptrset_to_int(owns#39), ^$#ptrset);
                        // assert @writes_check(p); 
                        assert $top_writable($s, #wrTime$1^168.28, $phys_ptr_cast(L#p, ^Node));
                        // assume @_vcc_pre_static_wrap(@state); 
                        assume $pre_static_wrap($s);
                        // @_vcc_static_wrap(pure(p), staticWrapState#38, owns#39)
                        call $static_wrap($phys_ptr_cast(L#p, ^Node), staticWrapState#38, owns#39);
                        assume $good_state_ext(#tok$1^187.36, $s);
                        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, p), @_vcc_set_empty)); 
                        assert $set_eq($owns($s, $phys_ptr_cast(L#p, ^Node)), $set_empty());
                        // assume @_vcc_full_stop(@state); 
                        assume $full_stop($s);
                        // goto #break_11; 
                        goto #break_11;
                    }
                    else
                    {
                      anon28:
                        // empty
                    }
                }
                else
                {
                  anon30:
                    // assert false; 
                    assert false;
                    // assume false; 
                    assume false;
                }
            }

          anon33:
            // assert doMark(p); 
            assert F#doMark($phys_ptr_cast(L#p, ^Node));
            // assert doMark(n); 
            assert F#doMark($phys_ptr_cast(L#n, ^Node));
            // assume &&(doMark(p), doMark(n)); 
            assume F#doMark($phys_ptr_cast(L#p, ^Node)) && F#doMark($phys_ptr_cast(L#n, ^Node));
            // (struct Node* -> _Bool) res_lambda#7#20; 
            assume $local_value_is($s, #tok$1^194.37, #loc.res_lambda#7#20, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), $map_t($ptr_to(^Node), ^^bool));
            // assert @reads_check_normal((t->R)); 
            assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
            // res_lambda#7#20 := lambda#7(@map_get(*((t->R)), n), x); 
            call res_lambda#7#20 := lambda#7($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#n, ^Node)), $phys_ptr_cast(P#x, ^Node));
            assume $full_stop_ext(#tok$1^194.37, $s);
            assume $local_value_is($s, #tok$1^194.37, #loc.res_lambda#7#20, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#7#20), $map_t($ptr_to(^Node), ^^bool));
            // assert @prim_writes_check((t->R)); 
            assert $writable_prim($s, #wrTime$1^168.28, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
            // assert @reads_check_normal((t->R)); 
            assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
            // *(t->R) := @map_updated(*((t->R)), n, res_lambda#7#20); 
            call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#n, ^Node), res_lambda#7#20)));
            assume $full_stop_ext(#tok$1^194.27, $s);
            // p := n; 
            L#p := $phys_ptr_cast(L#n, ^Node);
            assume $local_value_is($s, #tok$1^195.5, #loc.p, $ptr_to_int(L#p), $ptr_to(^Node));
        }
        else
        {
          anon34:
            // goto #break_11; 
            goto #break_11;
        }

      #continue_11:
        assume true;
    }

  anon38:
    assume $full_stop_ext(#tok$1^167.3, $s);

  #break_11:
    // assert @prim_writes_check((x->parent)); 
    assert $writable_prim($s, #wrTime$1^134.1, $dot($phys_ptr_cast(P#x, ^Node), Node.parent));
    // *(x->parent) := p; 
    call $write_int(Node.parent, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(L#p, ^Node)));
    assume $full_stop_ext(#tok$1^198.3, $s);
    // _math state_t prestate#43; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // prestate#43 := @_vcc_current_state(@state); 
    prestate#43 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#43, $state_to_int(prestate#43), ^$#state_t);
    // _math state_t staticWrapState#41; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#41, $state_to_int(staticWrapState#41), ^$#state_t);
    // staticWrapState#41 := @_vcc_current_state(@state); 
    staticWrapState#41 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#41, $state_to_int(staticWrapState#41), ^$#state_t);
    // _math ptrset owns#42; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    // owns#42 := @_vcc_set_empty; 
    owns#42 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#42, $ptrset_to_int(owns#42), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#x, ^Node));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#41, owns#42)
    call $static_wrap($phys_ptr_cast(P#x, ^Node), staticWrapState#41, owns#42);
    assume $good_state_ext(#tok$1^199.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#x, ^Node)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#44; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // prestate#44 := @_vcc_current_state(@state); 
    prestate#44 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#44, $state_to_int(prestate#44), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^134.1, $phys_ptr_cast(P#t, ^Tree));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^200.19: $ptr :: { $dont_instantiate(#writes$1^200.19) } $set_in(#writes$1^200.19, $owns($s, $phys_ptr_cast(P#t, ^Tree))) ==> $top_writable($s, #wrTime$1^134.1, #writes$1^200.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $good_state_ext(#tok$1^200.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @_vcc_ptr_eq_null(*((*((t->root))->parent))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), ^Node));
    // assert @inv_check(forall(struct Node* m; true; unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } true; ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @_vcc_ptr_eq_pure(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @_vcc_ptr_eq_pure(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(*((*((n->parent))->left)), n), @_vcc_ptr_eq_pure(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } true; ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(m, (struct Node*)@null)), @_vcc_ptr_eq_pure(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure left_rotate(P#t: $ptr, P#x: $ptr);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(P#x, ^Node));
  requires $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node));
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))) && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(old($s), Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))));
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
  free ensures $call_transition(old($s), $s);



implementation left_rotate(P#t: $ptr, P#x: $ptr)
{
  var prestate#70: $state;
  var res_lambda#8#21: $map_t..$ptr_to..^Node.^^bool;
  var owns#68: $ptrset;
  var staticWrapState#67: $state;
  var prestate#69: $state;
  var owns#65: $ptrset;
  var staticWrapState#64: $state;
  var prestate#66: $state;
  var owns#62: $ptrset;
  var staticWrapState#61: $state;
  var prestate#63: $state;
  var prestate#60: $state;
  var prestate#58: $state;
  var owns#59: $ptrset;
  var owns#56: $ptrset;
  var staticWrapState#55: $state;
  var prestate#57: $state;
  var prestate#54: $state;
  var prestate#52: $state;
  var owns#53: $ptrset;
  var prestate#51: $state;
  var prestate#49: $state;
  var owns#50: $ptrset;
  var prestate#48: $state;
  var prestate#46: $state;
  var owns#47: $ptrset;
  var prestate#45: $state;
  var L#y: $ptr;
  var #wrTime$1^203.1: int;
  var #stackframe: int;

  anon46:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^203.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^203.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^203.1, #loc.x, $ptr_to_int(P#x), $ptr_to(^Node));
    assume #wrTime$1^203.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^203.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
    assume $thread_owned($s, $phys_ptr_cast(P#t, ^Tree));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    // struct Node* y; 
    assume $local_value_is($s, #tok$1^209.3, #loc.y, $ptr_to_int(L#y), $ptr_to(^Node));
    // var struct Node* y
    // _math state_t prestate#45; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // prestate#45 := @_vcc_current_state(@state); 
    prestate#45 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#45, $state_to_int(prestate#45), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#t, ^Tree));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $good_state_ext(#tok$1^211.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(x); 
    assert F#doMark($phys_ptr_cast(P#x, ^Node));
    // assume doMark(x); 
    assume F#doMark($phys_ptr_cast(P#x, ^Node));
    // _math ptrset owns#47; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    // owns#47 := @_vcc_set_empty; 
    owns#47 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#47, $ptrset_to_int(owns#47), ^$#ptrset);
    // _math state_t prestate#46; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // prestate#46 := @_vcc_current_state(@state); 
    prestate#46 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#46, $state_to_int(prestate#46), ^$#state_t);
    // _math state_t prestate#48; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // prestate#48 := @_vcc_current_state(@state); 
    prestate#48 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#48, $state_to_int(prestate#48), ^$#state_t);
    // assert @_vcc_wrapped(@state, x); 
    assert $wrapped($s, $phys_ptr_cast(P#x, ^Node), ^Node);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#x, ^Node));
    // assume @_vcc_inv(@state, x); 
    assume $inv($s, $phys_ptr_cast(P#x, ^Node), ^Node);
    // assume ==(owns#47, @_vcc_owns(@state, x)); 
    assume owns#47 == $owns($s, $phys_ptr_cast(P#x, ^Node));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(x), prestate#48)
    call $static_unwrap($phys_ptr_cast(P#x, ^Node), prestate#48);
    assume $good_state_ext(#tok$1^212.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((x->right)); 
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    // y := *((x->right)); 
    L#y := $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node);
    assume $local_value_is($s, #tok$1^213.3, #loc.y, $ptr_to_int(L#y), $ptr_to(^Node));
    // assert doMark(y); 
    assert F#doMark($phys_ptr_cast(L#y, ^Node));
    // assume doMark(y); 
    assume F#doMark($phys_ptr_cast(L#y, ^Node));
    // _math ptrset owns#50; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    // owns#50 := @_vcc_set_empty; 
    owns#50 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#50, $ptrset_to_int(owns#50), ^$#ptrset);
    // _math state_t prestate#49; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // prestate#49 := @_vcc_current_state(@state); 
    prestate#49 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#49, $state_to_int(prestate#49), ^$#state_t);
    // _math state_t prestate#51; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    // prestate#51 := @_vcc_current_state(@state); 
    prestate#51 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#51, $state_to_int(prestate#51), ^$#state_t);
    // assert @_vcc_wrapped(@state, y); 
    assert $wrapped($s, $phys_ptr_cast(L#y, ^Node), ^Node);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(L#y, ^Node));
    // assume @_vcc_inv(@state, y); 
    assume $inv($s, $phys_ptr_cast(L#y, ^Node), ^Node);
    // assume ==(owns#50, @_vcc_owns(@state, y)); 
    assume owns#50 == $owns($s, $phys_ptr_cast(L#y, ^Node));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(y), prestate#51)
    call $static_unwrap($phys_ptr_cast(L#y, ^Node), prestate#51);
    assume $good_state_ext(#tok$1^214.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((x->right)); 
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#x, ^Node), Node.right));
    // assert @reads_check_normal((y->left)); 
    assert $thread_local($s, $phys_ptr_cast(L#y, ^Node));
    // *(x->right) := *((y->left)); 
    call $write_int(Node.right, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node)));
    assume $full_stop_ext(#tok$1^216.3, $s);
    // assert @reads_check_normal((y->left)); 
    assert $thread_local($s, $phys_ptr_cast(L#y, ^Node));
    assume true;
    // if (@_vcc_ptr_neq_null(*((y->left)))) ...
    if ($non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node)))
    {
      anon39:
        // _math ptrset owns#53; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        // owns#53 := @_vcc_set_empty; 
        owns#53 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#53, $ptrset_to_int(owns#53), ^$#ptrset);
        // _math state_t prestate#52; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        // prestate#52 := @_vcc_current_state(@state); 
        prestate#52 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#52, $state_to_int(prestate#52), ^$#state_t);
        // _math state_t prestate#54; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        // prestate#54 := @_vcc_current_state(@state); 
        prestate#54 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#54, $state_to_int(prestate#54), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((y->left))); 
        assert $wrapped($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), ^Node);
        // assert @writes_check(*((y->left))); 
        assert $top_writable($s, #wrTime$1^203.1, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node));
        // assume @_vcc_inv(@state, *((y->left))); 
        assume $inv($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), ^Node);
        // assume ==(owns#53, @_vcc_owns(@state, *((y->left)))); 
        assume owns#53 == $owns($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((y->left))), prestate#54)
        call $static_unwrap($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), prestate#54);
        assume $good_state_ext(#tok$1^218.34, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @prim_writes_check((*((y->left))->parent)); 
        assert $writable_prim($s, #wrTime$1^203.1, $dot($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), Node.parent));
        // assert @reads_check_normal((y->left)); 
        assert $thread_local($s, $phys_ptr_cast(L#y, ^Node));
        // *(*((y->left))->parent) := x; 
        call $write_int(Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
        assume $full_stop_ext(#tok$1^218.43, $s);
        // _math state_t prestate#57; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        // prestate#57 := @_vcc_current_state(@state); 
        prestate#57 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#57, $state_to_int(prestate#57), ^$#state_t);
        // _math state_t staticWrapState#55; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#55, $state_to_int(staticWrapState#55), ^$#state_t);
        // staticWrapState#55 := @_vcc_current_state(@state); 
        staticWrapState#55 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#55, $state_to_int(staticWrapState#55), ^$#state_t);
        // _math ptrset owns#56; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        // owns#56 := @_vcc_set_empty; 
        owns#56 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#56, $ptrset_to_int(owns#56), ^$#ptrset);
        // assert @writes_check(*((y->left))); 
        assert $top_writable($s, #wrTime$1^203.1, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((y->left))), staticWrapState#55, owns#56)
        call $static_wrap($rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node), staticWrapState#55, owns#56);
        assume $good_state_ext(#tok$1^218.34, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((y->left))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(L#y, ^Node), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon40:
        // empty
    }

  anon47:
    // assert @prim_writes_check((y->parent)); 
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(L#y, ^Node), Node.parent));
    // assert @reads_check_normal((x->parent)); 
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    // *(y->parent) := *((x->parent)); 
    call $write_int(Node.parent, $phys_ptr_cast(L#y, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node)));
    assume $full_stop_ext(#tok$1^219.3, $s);
    // assert @reads_check_normal((x->parent)); 
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    assume true;
    // if (@_vcc_ptr_eq_null(*((x->parent)))) ...
    if ($is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node)))
    {
      anon41:
        // assert @prim_writes_check((t->root)); 
        assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
        // *(t->root) := y; 
        call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
        assume $full_stop_ext(#tok$1^221.5, $s);
    }
    else
    {
      anon44:
        // assert doMark(*((x->parent))); 
        assert F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        // assume doMark(*((x->parent))); 
        assume F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        // _math ptrset owns#59; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        // owns#59 := @_vcc_set_empty; 
        owns#59 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#59, $ptrset_to_int(owns#59), ^$#ptrset);
        // _math state_t prestate#58; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        // prestate#58 := @_vcc_current_state(@state); 
        prestate#58 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#58, $state_to_int(prestate#58), ^$#state_t);
        // _math state_t prestate#60; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        // prestate#60 := @_vcc_current_state(@state); 
        prestate#60 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#60, $state_to_int(prestate#60), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((x->parent))); 
        assert $wrapped($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), ^Node);
        // assert @writes_check(*((x->parent))); 
        assert $top_writable($s, #wrTime$1^203.1, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        // assume @_vcc_inv(@state, *((x->parent))); 
        assume $inv($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), ^Node);
        // assume ==(owns#59, @_vcc_owns(@state, *((x->parent)))); 
        assume owns#59 == $owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((x->parent))), prestate#60)
        call $static_unwrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), prestate#60);
        assume $good_state_ext(#tok$1^224.32, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @reads_check_normal((*((x->parent))->left)); 
        assert $thread_local($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        // assert @reads_check_normal((x->parent)); 
        assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
        assume true;
        // if (@_vcc_ptr_eq(*((*((x->parent))->left)), x)) ...
        if ($ptr_eq($rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), ^Node), $phys_ptr_cast(P#x, ^Node)))
        {
          anon42:
            // assert @prim_writes_check((*((x->parent))->left)); 
            assert $writable_prim($s, #wrTime$1^203.1, $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), Node.left));
            // assert @reads_check_normal((x->parent)); 
            assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
            // *(*((x->parent))->left) := y; 
            call $write_int(Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
            assume $full_stop_ext(#tok$1^226.9, $s);
        }
        else
        {
          anon43:
            // assert @prim_writes_check((*((x->parent))->right)); 
            assert $writable_prim($s, #wrTime$1^203.1, $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), Node.right));
            // assert @reads_check_normal((x->parent)); 
            assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
            // *(*((x->parent))->right) := y; 
            call $write_int(Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
            assume $full_stop_ext(#tok$1^228.9, $s);
        }

      anon45:
        // _math state_t prestate#63; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        // prestate#63 := @_vcc_current_state(@state); 
        prestate#63 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#63, $state_to_int(prestate#63), ^$#state_t);
        // _math state_t staticWrapState#61; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#61, $state_to_int(staticWrapState#61), ^$#state_t);
        // staticWrapState#61 := @_vcc_current_state(@state); 
        staticWrapState#61 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#61, $state_to_int(staticWrapState#61), ^$#state_t);
        // _math ptrset owns#62; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        // owns#62 := @_vcc_set_empty; 
        owns#62 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#62, $ptrset_to_int(owns#62), ^$#ptrset);
        // assert @writes_check(*((x->parent))); 
        assert $top_writable($s, #wrTime$1^203.1, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((x->parent))), staticWrapState#61, owns#62)
        call $static_wrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node), staticWrapState#61, owns#62);
        assume $good_state_ext(#tok$1^224.32, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((x->parent))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#x, ^Node), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }

  anon48:
    // assert @prim_writes_check((y->left)); 
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(L#y, ^Node), Node.left));
    // *(y->left) := x; 
    call $write_int(Node.left, $phys_ptr_cast(L#y, ^Node), $ptr_to_int($phys_ptr_cast(P#x, ^Node)));
    assume $full_stop_ext(#tok$1^231.3, $s);
    // assert @prim_writes_check((x->parent)); 
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#x, ^Node), Node.parent));
    // *(x->parent) := y; 
    call $write_int(Node.parent, $phys_ptr_cast(P#x, ^Node), $ptr_to_int($phys_ptr_cast(L#y, ^Node)));
    assume $full_stop_ext(#tok$1^232.3, $s);
    // _math state_t prestate#66; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // prestate#66 := @_vcc_current_state(@state); 
    prestate#66 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#66, $state_to_int(prestate#66), ^$#state_t);
    // _math state_t staticWrapState#64; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // staticWrapState#64 := @_vcc_current_state(@state); 
    staticWrapState#64 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#64, $state_to_int(staticWrapState#64), ^$#state_t);
    // _math ptrset owns#65; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // owns#65 := @_vcc_set_empty; 
    owns#65 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#65, $ptrset_to_int(owns#65), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#x, ^Node));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#64, owns#65)
    call $static_wrap($phys_ptr_cast(P#x, ^Node), staticWrapState#64, owns#65);
    assume $good_state_ext(#tok$1^233.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#x, ^Node)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#69; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // prestate#69 := @_vcc_current_state(@state); 
    prestate#69 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#69, $state_to_int(prestate#69), ^$#state_t);
    // _math state_t staticWrapState#67; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#67, $state_to_int(staticWrapState#67), ^$#state_t);
    // staticWrapState#67 := @_vcc_current_state(@state); 
    staticWrapState#67 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#67, $state_to_int(staticWrapState#67), ^$#state_t);
    // _math ptrset owns#68; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // owns#68 := @_vcc_set_empty; 
    owns#68 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#68, $ptrset_to_int(owns#68), ^$#ptrset);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(L#y, ^Node));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(y), staticWrapState#67, owns#68)
    call $static_wrap($phys_ptr_cast(L#y, ^Node), staticWrapState#67, owns#68);
    assume $good_state_ext(#tok$1^233.43, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, y), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(L#y, ^Node)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(*((x->right))); 
    assert F#doMark($rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node));
    // assume doMark(*((x->right))); 
    assume F#doMark($rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node));
    // assert forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), y), m)) } { @map_get(@map_get(*((t->R)), *((x->right))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((x->right))), m), >(*((m->key)), *((x->key))))); 
    assert (forall Q#m$1^236.26#dt1: $ptr :: {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#y, ^Node)), $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    // assume forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), y), m)) } { @map_get(@map_get(*((t->R)), *((x->right))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((x->right))), m), >(*((m->key)), *((x->key))))); 
    assume (forall Q#m$1^236.26#dt1: $ptr :: {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#y, ^Node)), $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^236.26#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(P#x, ^Node)));
    // assert @prim_writes_check((t->R)); 
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // *(t->R) := @map_updated(*((t->R)), y, @map_get(*((t->R)), x)); 
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#y, ^Node), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(P#x, ^Node)))));
    assume $full_stop_ext(#tok$1^239.5, $s);
    // (struct Node* -> _Bool) res_lambda#8#21; 
    assume $local_value_is($s, #tok$1^240.15, #loc.res_lambda#8#21, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((x->right)); 
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((x->left)); 
    assert $thread_local($s, $phys_ptr_cast(P#x, ^Node));
    // res_lambda#8#21 := lambda#8(@map_get(*((t->R)), *((x->right))), @map_get(*((t->R)), *((x->left))), x); 
    call res_lambda#8#21 := lambda#8($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#x, ^Node), ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#x, ^Node), ^Node)), $phys_ptr_cast(P#x, ^Node));
    assume $full_stop_ext(#tok$1^240.15, $s);
    assume $local_value_is($s, #tok$1^240.15, #loc.res_lambda#8#21, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#8#21), $map_t($ptr_to(^Node), ^^bool));
    // assert @prim_writes_check((t->R)); 
    assert $writable_prim($s, #wrTime$1^203.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // *(t->R) := @map_updated(*((t->R)), x, res_lambda#8#21); 
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(P#x, ^Node), res_lambda#8#21)));
    assume $full_stop_ext(#tok$1^240.5, $s);
    // _math state_t prestate#70; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    // prestate#70 := @_vcc_current_state(@state); 
    prestate#70 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#70, $state_to_int(prestate#70), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^203.1, $phys_ptr_cast(P#t, ^Tree));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^243.19: $ptr :: { $dont_instantiate(#writes$1^243.19) } $set_in(#writes$1^243.19, $owns($s, $phys_ptr_cast(P#t, ^Tree))) ==> $top_writable($s, #wrTime$1^203.1, #writes$1^243.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $good_state_ext(#tok$1^243.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @_vcc_ptr_eq_null(*((*((t->root))->parent))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), ^Node));
    // assert @inv_check(forall(struct Node* m; true; unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } true; ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @_vcc_ptr_eq_pure(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @_vcc_ptr_eq_pure(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(*((*((n->parent))->left)), n), @_vcc_ptr_eq_pure(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } true; ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(m, (struct Node*)@null)), @_vcc_ptr_eq_pure(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



procedure right_rotate(P#t: $ptr, P#y: $ptr);
  requires $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(P#y, ^Node));
  requires $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node));
  requires $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  modifies $s, $cev_pc;
  ensures $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv(old($s), Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr(old($s), Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node))) && $eq.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv(old($s), Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))));
  ensures $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
  free ensures $modifies(old($s), $s, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
  free ensures $call_transition(old($s), $s);



implementation right_rotate(P#t: $ptr, P#y: $ptr)
{
  var prestate#96: $state;
  var res_lambda#9#22: $map_t..$ptr_to..^Node.^^bool;
  var owns#94: $ptrset;
  var staticWrapState#93: $state;
  var prestate#95: $state;
  var owns#91: $ptrset;
  var staticWrapState#90: $state;
  var prestate#92: $state;
  var owns#88: $ptrset;
  var staticWrapState#87: $state;
  var prestate#89: $state;
  var prestate#86: $state;
  var prestate#84: $state;
  var owns#85: $ptrset;
  var owns#82: $ptrset;
  var staticWrapState#81: $state;
  var prestate#83: $state;
  var prestate#80: $state;
  var prestate#78: $state;
  var owns#79: $ptrset;
  var prestate#77: $state;
  var prestate#75: $state;
  var owns#76: $ptrset;
  var prestate#74: $state;
  var prestate#72: $state;
  var owns#73: $ptrset;
  var prestate#71: $state;
  var L#x: $ptr;
  var #wrTime$1^246.1: int;
  var #stackframe: int;

  anon56:
    assume $function_entry($s);
    assume $full_stop_ext(#tok$1^246.1, $s);
    assume $can_use_all_frame_axioms($s);
    assume $local_value_is($s, #tok$1^246.1, #loc.t, $ptr_to_int(P#t), $ptr_to(^Tree));
    assume $local_value_is($s, #tok$1^246.1, #loc.y, $ptr_to_int(P#y), $ptr_to(^Node));
    assume #wrTime$1^246.1 == $current_timestamp($s);
    assume $def_writes($s, #wrTime$1^246.1, (lambda #p: $ptr :: #p == $phys_ptr_cast(P#t, ^Tree)));
    assume $thread_owned($s, $phys_ptr_cast(P#t, ^Tree));
    // assume true; 
    assume true;
    // assume true; 
    assume true;
    // assume @decreases_level_is(2147483647); 
    assume 2147483647 == $decreases_level;
    // assert @_vcc_in_domain(@state, t, t); 
    assert $in_domain_lab($s, $phys_ptr_cast(P#t, ^Tree), $phys_ptr_cast(P#t, ^Tree), l#public);
    // struct Node* x; 
    assume $local_value_is($s, #tok$1^252.3, #loc.x, $ptr_to_int(L#x), $ptr_to(^Node));
    // var struct Node* x
    // _math state_t prestate#71; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // prestate#71 := @_vcc_current_state(@state); 
    prestate#71 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#71, $state_to_int(prestate#71), ^$#state_t);
    // assert @_vcc_wrapped(@state, t); 
    assert $wrapped($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    // assume @_vcc_inv(@state, t); 
    assume $inv($s, $phys_ptr_cast(P#t, ^Tree), ^Tree);
    // assume @_vcc_pre_unwrap(@state); 
    assume $pre_unwrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#t, ^Tree));
    // stmt @_vcc_unwrap(t, @_vcc_typeof(t)); 
    call $unwrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $good_state_ext(#tok$1^254.19, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(y); 
    assert F#doMark($phys_ptr_cast(P#y, ^Node));
    // assume doMark(y); 
    assume F#doMark($phys_ptr_cast(P#y, ^Node));
    // _math ptrset owns#73; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    // owns#73 := @_vcc_set_empty; 
    owns#73 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#73, $ptrset_to_int(owns#73), ^$#ptrset);
    // _math state_t prestate#72; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // prestate#72 := @_vcc_current_state(@state); 
    prestate#72 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#72, $state_to_int(prestate#72), ^$#state_t);
    // _math state_t prestate#74; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    // prestate#74 := @_vcc_current_state(@state); 
    prestate#74 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#74, $state_to_int(prestate#74), ^$#state_t);
    // assert @_vcc_wrapped(@state, y); 
    assert $wrapped($s, $phys_ptr_cast(P#y, ^Node), ^Node);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#y, ^Node));
    // assume @_vcc_inv(@state, y); 
    assume $inv($s, $phys_ptr_cast(P#y, ^Node), ^Node);
    // assume ==(owns#73, @_vcc_owns(@state, y)); 
    assume owns#73 == $owns($s, $phys_ptr_cast(P#y, ^Node));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(y), prestate#74)
    call $static_unwrap($phys_ptr_cast(P#y, ^Node), prestate#74);
    assume $good_state_ext(#tok$1^255.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @reads_check_normal((y->left)); 
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    // x := *((y->left)); 
    L#x := $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node);
    assume $local_value_is($s, #tok$1^256.3, #loc.x, $ptr_to_int(L#x), $ptr_to(^Node));
    // assert doMark(x); 
    assert F#doMark($phys_ptr_cast(L#x, ^Node));
    // assume doMark(x); 
    assume F#doMark($phys_ptr_cast(L#x, ^Node));
    // _math ptrset owns#76; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    // owns#76 := @_vcc_set_empty; 
    owns#76 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#76, $ptrset_to_int(owns#76), ^$#ptrset);
    // _math state_t prestate#75; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    // prestate#75 := @_vcc_current_state(@state); 
    prestate#75 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#75, $state_to_int(prestate#75), ^$#state_t);
    // _math state_t prestate#77; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // prestate#77 := @_vcc_current_state(@state); 
    prestate#77 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#77, $state_to_int(prestate#77), ^$#state_t);
    // assert @_vcc_wrapped(@state, x); 
    assert $wrapped($s, $phys_ptr_cast(L#x, ^Node), ^Node);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(L#x, ^Node));
    // assume @_vcc_inv(@state, x); 
    assume $inv($s, $phys_ptr_cast(L#x, ^Node), ^Node);
    // assume ==(owns#76, @_vcc_owns(@state, x)); 
    assume owns#76 == $owns($s, $phys_ptr_cast(L#x, ^Node));
    // assume @_vcc_pre_static_unwrap(@state); 
    assume $pre_static_unwrap($s);
    // @_vcc_static_unwrap(pure(x), prestate#77)
    call $static_unwrap($phys_ptr_cast(L#x, ^Node), prestate#77);
    assume $good_state_ext(#tok$1^257.53, $s);
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert @prim_writes_check((y->left)); 
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#y, ^Node), Node.left));
    // assert @reads_check_normal((x->right)); 
    assert $thread_local($s, $phys_ptr_cast(L#x, ^Node));
    // *(y->left) := *((x->right)); 
    call $write_int(Node.left, $phys_ptr_cast(P#y, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node)));
    assume $full_stop_ext(#tok$1^259.3, $s);
    // assert @reads_check_normal((x->right)); 
    assert $thread_local($s, $phys_ptr_cast(L#x, ^Node));
    assume true;
    // if (@_vcc_ptr_neq_null(*((x->right)))) ...
    if ($non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node)))
    {
      anon49:
        // _math ptrset owns#79; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        // owns#79 := @_vcc_set_empty; 
        owns#79 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#79, $ptrset_to_int(owns#79), ^$#ptrset);
        // _math state_t prestate#78; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        // prestate#78 := @_vcc_current_state(@state); 
        prestate#78 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#78, $state_to_int(prestate#78), ^$#state_t);
        // _math state_t prestate#80; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        // prestate#80 := @_vcc_current_state(@state); 
        prestate#80 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#80, $state_to_int(prestate#80), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((x->right))); 
        assert $wrapped($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), ^Node);
        // assert @writes_check(*((x->right))); 
        assert $top_writable($s, #wrTime$1^246.1, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node));
        // assume @_vcc_inv(@state, *((x->right))); 
        assume $inv($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), ^Node);
        // assume ==(owns#79, @_vcc_owns(@state, *((x->right)))); 
        assume owns#79 == $owns($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((x->right))), prestate#80)
        call $static_unwrap($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), prestate#80);
        assume $good_state_ext(#tok$1^261.34, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @prim_writes_check((*((x->right))->parent)); 
        assert $writable_prim($s, #wrTime$1^246.1, $dot($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), Node.parent));
        // assert @reads_check_normal((x->right)); 
        assert $thread_local($s, $phys_ptr_cast(L#x, ^Node));
        // *(*((x->right))->parent) := y; 
        call $write_int(Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(P#y, ^Node)));
        assume $full_stop_ext(#tok$1^261.44, $s);
        // _math state_t prestate#83; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        // prestate#83 := @_vcc_current_state(@state); 
        prestate#83 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#83, $state_to_int(prestate#83), ^$#state_t);
        // _math state_t staticWrapState#81; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
        // staticWrapState#81 := @_vcc_current_state(@state); 
        staticWrapState#81 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#81, $state_to_int(staticWrapState#81), ^$#state_t);
        // _math ptrset owns#82; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        // owns#82 := @_vcc_set_empty; 
        owns#82 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#82, $ptrset_to_int(owns#82), ^$#ptrset);
        // assert @writes_check(*((x->right))); 
        assert $top_writable($s, #wrTime$1^246.1, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((x->right))), staticWrapState#81, owns#82)
        call $static_wrap($rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node), staticWrapState#81, owns#82);
        assume $good_state_ext(#tok$1^261.34, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((x->right))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(L#x, ^Node), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }
    else
    {
      anon50:
        // empty
    }

  anon57:
    // assert @prim_writes_check((x->parent)); 
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(L#x, ^Node), Node.parent));
    // assert @reads_check_normal((y->parent)); 
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    // *(x->parent) := *((y->parent)); 
    call $write_int(Node.parent, $phys_ptr_cast(L#x, ^Node), $ptr_to_int($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node)));
    assume $full_stop_ext(#tok$1^262.3, $s);
    // assert @reads_check_normal((y->parent)); 
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    assume true;
    // if (@_vcc_ptr_eq_null(*((y->parent)))) ...
    if ($is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node)))
    {
      anon51:
        // assert @prim_writes_check((t->root)); 
        assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.root));
        // *(t->root) := x; 
        call $write_int(Tree.root, $phys_ptr_cast(P#t, ^Tree), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
        assume $full_stop_ext(#tok$1^263.32, $s);
    }
    else
    {
      anon54:
        // assert doMark(*((y->parent))); 
        assert F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        // assume doMark(*((y->parent))); 
        assume F#doMark($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        // _math ptrset owns#85; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        // owns#85 := @_vcc_set_empty; 
        owns#85 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#85, $ptrset_to_int(owns#85), ^$#ptrset);
        // _math state_t prestate#84; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        // prestate#84 := @_vcc_current_state(@state); 
        prestate#84 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#84, $state_to_int(prestate#84), ^$#state_t);
        // _math state_t prestate#86; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        // prestate#86 := @_vcc_current_state(@state); 
        prestate#86 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#86, $state_to_int(prestate#86), ^$#state_t);
        // assert @_vcc_wrapped(@state, *((y->parent))); 
        assert $wrapped($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), ^Node);
        // assert @writes_check(*((y->parent))); 
        assert $top_writable($s, #wrTime$1^246.1, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        // assume @_vcc_inv(@state, *((y->parent))); 
        assume $inv($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), ^Node);
        // assume ==(owns#85, @_vcc_owns(@state, *((y->parent)))); 
        assume owns#85 == $owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        // assume @_vcc_pre_static_unwrap(@state); 
        assume $pre_static_unwrap($s);
        // @_vcc_static_unwrap(pure(*((y->parent))), prestate#86)
        call $static_unwrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), prestate#86);
        assume $good_state_ext(#tok$1^266.32, $s);
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
        // assert @reads_check_normal((*((y->parent))->left)); 
        assert $thread_local($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        // assert @reads_check_normal((y->parent)); 
        assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
        assume true;
        // if (@_vcc_ptr_eq(*((*((y->parent))->left)), y)) ...
        if ($ptr_eq($rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), ^Node), $phys_ptr_cast(P#y, ^Node)))
        {
          anon52:
            // assert @prim_writes_check((*((y->parent))->left)); 
            assert $writable_prim($s, #wrTime$1^246.1, $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), Node.left));
            // assert @reads_check_normal((y->parent)); 
            assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
            // *(*((y->parent))->left) := x; 
            call $write_int(Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
            assume $full_stop_ext(#tok$1^268.9, $s);
        }
        else
        {
          anon53:
            // assert @prim_writes_check((*((y->parent))->right)); 
            assert $writable_prim($s, #wrTime$1^246.1, $dot($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), Node.right));
            // assert @reads_check_normal((y->parent)); 
            assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
            // *(*((y->parent))->right) := x; 
            call $write_int(Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
            assume $full_stop_ext(#tok$1^270.9, $s);
        }

      anon55:
        // _math state_t prestate#89; 
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        // prestate#89 := @_vcc_current_state(@state); 
        prestate#89 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.prestate#89, $state_to_int(prestate#89), ^$#state_t);
        // _math state_t staticWrapState#87; 
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
        // staticWrapState#87 := @_vcc_current_state(@state); 
        staticWrapState#87 := $current_state($s);
        assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#87, $state_to_int(staticWrapState#87), ^$#state_t);
        // _math ptrset owns#88; 
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        // owns#88 := @_vcc_set_empty; 
        owns#88 := $set_empty();
        assume $local_value_is($s, #tok$2^0.0, #loc.owns#88, $ptrset_to_int(owns#88), ^$#ptrset);
        // assert @writes_check(*((y->parent))); 
        assert $top_writable($s, #wrTime$1^246.1, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node));
        // assume @_vcc_pre_static_wrap(@state); 
        assume $pre_static_wrap($s);
        // @_vcc_static_wrap(pure(*((y->parent))), staticWrapState#87, owns#88)
        call $static_wrap($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node), staticWrapState#87, owns#88);
        assume $good_state_ext(#tok$1^266.32, $s);
        // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, *((y->parent))), @_vcc_set_empty)); 
        assert $set_eq($owns($s, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(P#y, ^Node), ^Node)), $set_empty());
        // assume @_vcc_full_stop(@state); 
        assume $full_stop($s);
    }

  anon58:
    // assert @prim_writes_check((x->right)); 
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(L#x, ^Node), Node.right));
    // *(x->right) := y; 
    call $write_int(Node.right, $phys_ptr_cast(L#x, ^Node), $ptr_to_int($phys_ptr_cast(P#y, ^Node)));
    assume $full_stop_ext(#tok$1^273.3, $s);
    // assert @prim_writes_check((y->parent)); 
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#y, ^Node), Node.parent));
    // *(y->parent) := x; 
    call $write_int(Node.parent, $phys_ptr_cast(P#y, ^Node), $ptr_to_int($phys_ptr_cast(L#x, ^Node)));
    assume $full_stop_ext(#tok$1^274.3, $s);
    // _math state_t prestate#92; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    // prestate#92 := @_vcc_current_state(@state); 
    prestate#92 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#92, $state_to_int(prestate#92), ^$#state_t);
    // _math state_t staticWrapState#90; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#90, $state_to_int(staticWrapState#90), ^$#state_t);
    // staticWrapState#90 := @_vcc_current_state(@state); 
    staticWrapState#90 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#90, $state_to_int(staticWrapState#90), ^$#state_t);
    // _math ptrset owns#91; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    // owns#91 := @_vcc_set_empty; 
    owns#91 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#91, $ptrset_to_int(owns#91), ^$#ptrset);
    // assert @writes_check(x); 
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(L#x, ^Node));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(x), staticWrapState#90, owns#91)
    call $static_wrap($phys_ptr_cast(L#x, ^Node), staticWrapState#90, owns#91);
    assume $good_state_ext(#tok$1^276.19, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, x), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(L#x, ^Node)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // _math state_t prestate#95; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    // prestate#95 := @_vcc_current_state(@state); 
    prestate#95 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#95, $state_to_int(prestate#95), ^$#state_t);
    // _math state_t staticWrapState#93; 
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#93, $state_to_int(staticWrapState#93), ^$#state_t);
    // staticWrapState#93 := @_vcc_current_state(@state); 
    staticWrapState#93 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.staticWrapState#93, $state_to_int(staticWrapState#93), ^$#state_t);
    // _math ptrset owns#94; 
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    // owns#94 := @_vcc_set_empty; 
    owns#94 := $set_empty();
    assume $local_value_is($s, #tok$2^0.0, #loc.owns#94, $ptrset_to_int(owns#94), ^$#ptrset);
    // assert @writes_check(y); 
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#y, ^Node));
    // assume @_vcc_pre_static_wrap(@state); 
    assume $pre_static_wrap($s);
    // @_vcc_static_wrap(pure(y), staticWrapState#93, owns#94)
    call $static_wrap($phys_ptr_cast(P#y, ^Node), staticWrapState#93, owns#94);
    assume $good_state_ext(#tok$1^276.43, $s);
    // assert @inv_check(@_vcc_set_eq(@_vcc_owns(@state, y), @_vcc_set_empty)); 
    assert $set_eq($owns($s, $phys_ptr_cast(P#y, ^Node)), $set_empty());
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // assert doMark(*((y->left))); 
    assert F#doMark($rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node));
    // assume doMark(*((y->left))); 
    assume F#doMark($rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node));
    // assert forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), x), m)) } { @map_get(@map_get(*((t->R)), *((y->left))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((y->left))), m), <(*((m->key)), *((y->key))))); 
    assert (forall Q#m$1^279.26#dt1: $ptr :: {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#x, ^Node)), $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(P#y, ^Node)));
    // assume forall(struct Node* m; { @trigger_hint(@map_get(@map_get(*((t->R)), x), m)) } { @map_get(@map_get(*((t->R)), *((y->left))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((y->left))), m), <(*((m->key)), *((y->key))))); 
    assume (forall Q#m$1^279.26#dt1: $ptr :: {:weight 10} { sk_hack($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#x, ^Node)), $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node))) } { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^279.26#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(P#y, ^Node)));
    // assert @prim_writes_check((t->R)); 
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // *(t->R) := @map_updated(*((t->R)), x, @map_get(*((t->R)), y)); 
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(L#x, ^Node), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(P#y, ^Node)))));
    assume $full_stop_ext(#tok$1^282.5, $s);
    // (struct Node* -> _Bool) res_lambda#9#22; 
    assume $local_value_is($s, #tok$1^283.15, #loc.res_lambda#9#22, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), $map_t($ptr_to(^Node), ^^bool));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((y->right)); 
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // assert @reads_check_normal((y->left)); 
    assert $thread_local($s, $phys_ptr_cast(P#y, ^Node));
    // res_lambda#9#22 := lambda#9(@map_get(*((t->R)), *((y->right))), @map_get(*((t->R)), *((y->left))), y); 
    call res_lambda#9#22 := lambda#9($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(P#y, ^Node), ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(P#y, ^Node), ^Node)), $phys_ptr_cast(P#y, ^Node));
    assume $full_stop_ext(#tok$1^283.15, $s);
    assume $local_value_is($s, #tok$1^283.15, #loc.res_lambda#9#22, $map_t..ptr_to..^Node.^^bool_to_int(res_lambda#9#22), $map_t($ptr_to(^Node), ^^bool));
    // assert @prim_writes_check((t->R)); 
    assert $writable_prim($s, #wrTime$1^246.1, $dot($phys_ptr_cast(P#t, ^Tree), Tree.R));
    // assert @reads_check_normal((t->R)); 
    assert $thread_local($s, $phys_ptr_cast(P#t, ^Tree));
    // *(t->R) := @map_updated(*((t->R)), y, res_lambda#9#22); 
    call $write_int(Tree.R, $phys_ptr_cast(P#t, ^Tree), $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(P#y, ^Node), res_lambda#9#22)));
    assume $full_stop_ext(#tok$1^283.5, $s);
    // _math state_t prestate#96; 
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    // prestate#96 := @_vcc_current_state(@state); 
    prestate#96 := $current_state($s);
    assume $local_value_is($s, #tok$2^0.0, #loc.prestate#96, $state_to_int(prestate#96), ^$#state_t);
    // assume @_vcc_pre_wrap(@state); 
    assume $pre_wrap($s);
    // assert @writes_check(t); 
    assert $top_writable($s, #wrTime$1^246.1, $phys_ptr_cast(P#t, ^Tree));
    // assert @writes_check(@_vcc_owns(@state, t)); 
    assert (forall #writes$1^286.19: $ptr :: { $dont_instantiate(#writes$1^286.19) } $set_in(#writes$1^286.19, $owns($s, $phys_ptr_cast(P#t, ^Tree))) ==> $top_writable($s, #wrTime$1^246.1, #writes$1^286.19));
    // stmt @_vcc_wrap(t, @_vcc_typeof(t)); 
    call $wrap($phys_ptr_cast(P#t, ^Tree), ^Tree);
    assume $good_state_ext(#tok$1^286.19, $s);
    // assert @inv_check(unchecked!(@map_get(@map_get(*((t->R)), *((t->root))), (struct Node*)@null))); 
    assert !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast($null, ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @map_get(@map_get(*((t->R)), *((t->root))), *((t->root))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(==>(@_vcc_ptr_neq_null(*((t->root))), @_vcc_ptr_eq_null(*((*((t->root))->parent))))); 
    assert $non_null($rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)) ==> $is_null($rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node), ^Node));
    // assert @inv_check(forall(struct Node* m; true; unchecked!(@map_get(@map_get(*((t->R)), (struct Node*)@null), m)))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } !$select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast($null, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->left))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->left))), m), <(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) < $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), *((mark(n)->right))), m) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), ==>(@map_get(@map_get(*((t->R)), *((mark(n)->right))), m), >(*((m->key)), *((n->key))))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) > $rd_inv($s, Node.key, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* m; { @map_get(@map_get(*((t->R)), *((t->root))), m) } { mark2(m) } { @trigger_hint(mark2(m)) } true; ==(@map_get(@map_get(*((t->R)), *((t->root))), m), @_vcc_set_in(m, @_vcc_owns(@state, t))))); 
    assert (forall Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } { sk_hack(F#mark2($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) == $set_in($phys_ptr_cast(Q#m$1^82.29#dt1, ^Node), $owns($s, $phys_ptr_cast(P#t, ^Tree))));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), m)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), n), m) } true; ==>(@map_get(@map_get(*((t->R)), n), m), @map_get(@map_get(*((t->R)), *((t->root))), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr, Q#m$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#m$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @map_get(@map_get(*((t->R)), n), *((n->left)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->left)))), @_vcc_ptr_eq_pure(*((*((n->left))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.left, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @map_get(@map_get(*((t->R)), n), *((n->right)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->right)))), @_vcc_ptr_eq_pure(*((*((n->right))->parent)), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.right, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.parent, $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), @map_get(@map_get(*((t->R)), *((t->root))), *((n->parent)))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node)));
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_neq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(*((*((n->parent))->left)), n), @_vcc_ptr_eq_pure(*((*((n->parent))->right)), n))))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) && $non_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), ^Node), ^Node)) ==> $rd_phys_ptr($s, Node.left, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node) || $rd_phys_ptr($s, Node.right, $rd_phys_ptr($s, Node.parent, $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node), ^Node), ^Node) == $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node));
    // assert @inv_check(forall(struct Node* n; { @map_get(@map_get(*((t->R)), *((t->root))), n) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), n), @map_get(@map_get(*((t->R)), n), n)))); 
    assert (forall Q#n$1^82.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)) ==> $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)), $phys_ptr_cast(Q#n$1^82.29#dt1, ^Node)));
    // assert @inv_check(true); 
    assert true;
    // assert @inv_check(forall(struct Node* m; { @map_get(*((t->abs)), *((m->key))) } true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), ==(@map_get(*((t->abs)), *((m->key))), *((m->value)))))); 
    assert (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node))) == $rd_inv($s, Node.value, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)));
    // assert @inv_check(forall(int32_t k; { @map_get(*((t->abs)), k) } @in_range_i4(k); ==>(forall(struct Node* m; true; ==>(@map_get(@map_get(*((t->R)), *((t->root))), m), !=(*((m->key)), k))), ==(@map_get(*((t->abs)), k), 0)))); 
    assert (forall Q#k$1^83.29#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) } $in_range_i4(Q#k$1^83.29#tc2) ==> (forall Q#m$1^83.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) ==> $rd_inv($s, Node.key, $phys_ptr_cast(Q#m$1^83.29#dt1, ^Node)) != Q#k$1^83.29#tc2) ==> $select.$map_t..^^i4.^^i4($int_to_map_t..^^i4.^^i4($rd_inv($s, Tree.abs, $phys_ptr_cast(P#t, ^Tree))), Q#k$1^83.29#tc2) == 0);
    // assert @inv_check(forall(struct Node* n; { mark(n) } true; ==>(&&(@map_get(@map_get(*((t->R)), *((t->root))), n), @_vcc_ptr_eq_null(*((mark(n)->parent)))), ||(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(n, *((t->root))))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr :: {:weight 10} { $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && $is_null($rd_phys_ptr($s, Node.parent, $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node), ^Node)) ==> $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) || $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node));
    // assert @inv_check(forall(struct Node* n; struct Node* m; { @map_get(@map_get(*((t->R)), mark(n)), m) } true; ==(@map_get(@map_get(*((t->R)), mark(n)), m), &&(@map_get(@map_get(*((t->R)), *((t->root))), n), ||(||(||(&&(@_vcc_ptr_eq_pure(n, (struct Node*)@null), @_vcc_ptr_eq_pure(m, (struct Node*)@null)), @_vcc_ptr_eq_pure(m, n)), @map_get(@map_get(*((t->R)), *((n->left))), m)), @map_get(@map_get(*((t->R)), *((n->right))), m)))))); 
    assert (forall Q#n$1^84.29#dt1: $ptr, Q#m$1^84.29#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $phys_ptr_cast(F#mark($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) == ($select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Tree.root, $phys_ptr_cast(P#t, ^Tree), ^Node)), $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node)) && (($phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node) && $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast($null, ^Node)) || $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node) == $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.left, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($rd_inv($s, Tree.R, $phys_ptr_cast(P#t, ^Tree))), $rd_phys_ptr($s, Node.right, $phys_ptr_cast(Q#n$1^84.29#dt1, ^Node), ^Node)), $phys_ptr_cast(Q#m$1^84.29#dt1, ^Node)))));
    // assume @_vcc_full_stop(@state); 
    assume $full_stop($s);
    // return; 
    assert $position_marker();
    goto #exit;

  #exit:
}



function F#lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#9: $pure_function;

axiom $function_arg_type(cf#lambda#9, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#9, 3, $ptr_to(^Node));

procedure lambda#9(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#9(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^283.15#dt1: $ptr, #l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#9(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node)) == ($phys_ptr_cast(Q#m$1^283.15#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $phys_ptr_cast(Q#m$1^283.15#dt1, ^Node))));

function F#lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#8: $pure_function;

axiom $function_arg_type(cf#lambda#8, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 2, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#8, 3, $ptr_to(^Node));

procedure lambda#8(#l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#8(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^240.15#dt1: $ptr, #l2: $map_t..$ptr_to..^Node.^^bool, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#8(#l2, #l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node)) == ($phys_ptr_cast(Q#m$1^240.15#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node)) || $select.$map_t..$ptr_to..^Node.^^bool(#l2, $phys_ptr_cast(Q#m$1^240.15#dt1, ^Node))));

function F#lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#7: $pure_function;

axiom $function_arg_type(cf#lambda#7, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#7, 2, $ptr_to(^Node));

procedure lambda#7(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#7(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^194.37#dt1: $ptr, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#k$1^194.37#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#7(#l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#k$1^194.37#dt1, ^Node)) == ($phys_ptr_cast(Q#k$1^194.37#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#k$1^194.37#dt1, ^Node))));

function F#lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#6: $pure_function;

axiom $function_arg_type(cf#lambda#6, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 1, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#6, 2, $ptr_to(^Node));

procedure lambda#6(#l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#6(#l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^163.41#dt1: $ptr, #l1: $map_t..$ptr_to..^Node.^^bool, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#n$1^163.41#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#6(#l1, $phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#n$1^163.41#dt1, ^Node)) == ($phys_ptr_cast(Q#n$1^163.41#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node) || $select.$map_t..$ptr_to..^Node.^^bool(#l1, $phys_ptr_cast(Q#n$1^163.41#dt1, ^Node))));

function F#lambda#5(#l0: $ptr) : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#5: $pure_function;

axiom $function_arg_type(cf#lambda#5, 0, $map_t($ptr_to(^Node), ^^bool));

axiom $function_arg_type(cf#lambda#5, 1, $ptr_to(^Node));

procedure lambda#5(#l0: $ptr) returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#5(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^153.15#dt1: $ptr, #l0: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#n$1^153.15#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#5($phys_ptr_cast(#l0, ^Node)), $phys_ptr_cast(Q#n$1^153.15#dt1, ^Node)) == ($phys_ptr_cast(Q#n$1^153.15#dt1, ^Node) == $phys_ptr_cast(#l0, ^Node)));

function F#lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) : $map_t..^^i4.^^i4;

const unique cf#lambda#4: $pure_function;

axiom $function_arg_type(cf#lambda#4, 0, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 1, $map_t(^^i4, ^^i4));

axiom $function_arg_type(cf#lambda#4, 2, ^^i4);

axiom $function_arg_type(cf#lambda#4, 3, ^^i4);

procedure lambda#4(#l2: $map_t..^^i4.^^i4, #l1: int, #l0: int) returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#4(#l2, #l1, #l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^151.14#tc2: int, #l2: $map_t..^^i4.^^i4, #l1: int, #l0: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2) } $in_range_i4(Q#k$1^151.14#tc2) && $in_range_i4(#l1) && $in_range_i4(#l0) ==> $select.$map_t..^^i4.^^i4(F#lambda#4(#l2, #l1, #l0), Q#k$1^151.14#tc2) == (if Q#k$1^151.14#tc2 == #l0 then #l1 else $select.$map_t..^^i4.^^i4(#l2, Q#k$1^151.14#tc2)));

function F#lambda#3() : $map_t..^^i4.^^i4;

const unique cf#lambda#3: $pure_function;

axiom $function_arg_type(cf#lambda#3, 0, $map_t(^^i4, ^^i4));

procedure lambda#3() returns ($result: $map_t..^^i4.^^i4);
  free ensures $result == F#lambda#3();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#k$1^94.14#tc2: int :: {:weight 10} { $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) } $in_range_i4(Q#k$1^94.14#tc2) ==> $select.$map_t..^^i4.^^i4(F#lambda#3(), Q#k$1^94.14#tc2) == 0);

function F#lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#2: $pure_function;

axiom $function_arg_type(cf#lambda#2, 0, $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool)));

axiom $function_arg_type(cf#lambda#2, 1, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#2(#l0: $map_t..$ptr_to..^Node.^^bool) returns ($result: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#2(#l0);
  free ensures $call_transition(old($s), $s);



axiom (forall Q#m$1^93.12#dt1: $ptr, #l0: $map_t..$ptr_to..^Node.^^bool :: {:weight 10} { $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $phys_ptr_cast(Q#m$1^93.12#dt1, ^Node)) } $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(F#lambda#2(#l0), $phys_ptr_cast(Q#m$1^93.12#dt1, ^Node)), #l0));

function F#lambda#1() : $map_t..$ptr_to..^Node.^^bool;

const unique cf#lambda#1: $pure_function;

axiom $function_arg_type(cf#lambda#1, 0, $map_t($ptr_to(^Node), ^^bool));

procedure lambda#1() returns ($result: $map_t..$ptr_to..^Node.^^bool);
  free ensures $result == F#lambda#1();
  free ensures $call_transition(old($s), $s);



axiom (forall Q#n$1^93.12#dt1: $ptr :: {:weight 10} { $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $phys_ptr_cast(Q#n$1^93.12#dt1, ^Node)) } $select.$map_t..$ptr_to..^Node.^^bool(F#lambda#1(), $phys_ptr_cast(Q#n$1^93.12#dt1, ^Node)) == false);

const unique l#public: $label;

type $map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: $ptr) : bool;

function $store.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.^^bool, p: $ptr, v: bool) : $map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: $ptr, v: bool :: true);

axiom (forall M: $map_t..$ptr_to..^Node.^^bool, p: $ptr, v: bool, q: $ptr :: $select.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.^^bool(M, q, v), p) == (if $phys_ptr_cast(p, ^Node) == $phys_ptr_cast(q, ^Node) then v else $select.$map_t..$ptr_to..^Node.^^bool(M, p)));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } (forall p: $ptr :: $select.$map_t..$ptr_to..^Node.^^bool(M1, $phys_ptr_cast(p, ^Node)) == $select.$map_t..$ptr_to..^Node.^^bool(M2, $phys_ptr_cast(p, ^Node))) ==> $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.^^bool(0) == $zero.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.^^bool, p) == false);

axiom true;

type $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: $ptr) : $map_t..$ptr_to..^Node.^^bool;

function $store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: $ptr, v: $map_t..$ptr_to..^Node.^^bool) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

function $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool) : bool;

const $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: $ptr, v: $map_t..$ptr_to..^Node.^^bool :: true);

axiom (forall M: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p: $ptr, v: $map_t..$ptr_to..^Node.^^bool, q: $ptr :: $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($store.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, q, v), p) == (if $phys_ptr_cast(p, ^Node) == $phys_ptr_cast(q, ^Node) then v else $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M, p)));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } (forall p: $ptr :: $eq.$map_t..$ptr_to..^Node.^^bool($select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, $phys_ptr_cast(p, ^Node)), $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M2, $phys_ptr_cast(p, ^Node)))) ==> $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2));

axiom (forall M1: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, M2: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: { $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) } $eq.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(0) == $zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall p: $ptr :: $select.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool($zero.$map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool, p) == $zero.$map_t..$ptr_to..^Node.^^bool);

axiom true;

type $map_t..^^i4.^^i4;

function $select.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int) : int;

function $store.$map_t..^^i4.^^i4(M: $map_t..^^i4.^^i4, p: int, v: int) : $map_t..^^i4.^^i4;

function $eq.$map_t..^^i4.^^i4(M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4) : bool;

const $zero.$map_t..^^i4.^^i4: $map_t..^^i4.^^i4;

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int :: true);

axiom (forall M: $map_t..^^i4.^^i4, p: int, v: int, q: int :: $select.$map_t..^^i4.^^i4($store.$map_t..^^i4.^^i4(M, q, v), p) == (if $unchecked(^^i4, p) == $unchecked(^^i4, q) then $unchecked(^^i4, v) else $select.$map_t..^^i4.^^i4(M, p)));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } (forall p: int :: $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M1, $unchecked(^^i4, p))) == $unchecked(^^i4, $select.$map_t..^^i4.^^i4(M2, $unchecked(^^i4, p)))) ==> $eq.$map_t..^^i4.^^i4(M1, M2));

axiom (forall M1: $map_t..^^i4.^^i4, M2: $map_t..^^i4.^^i4 :: { $eq.$map_t..^^i4.^^i4(M1, M2) } $eq.$map_t..^^i4.^^i4(M1, M2) ==> M1 == M2);

axiom $int_to_map_t..^^i4.^^i4(0) == $zero.$map_t..^^i4.^^i4;

axiom (forall p: int :: $select.$map_t..^^i4.^^i4($zero.$map_t..^^i4.^^i4, p) == 0);

axiom true;

axiom (forall M: $map_t..^^i4.^^i4, p: int :: $in_range_t(^^i4, $select.$map_t..^^i4.^^i4(M, p)));

const unique #loc.#l0: $token;

const unique #loc.#l1: $token;

const unique #loc.#l2: $token;

const unique #tok$1^286.19: $token;

const unique #loc.prestate#96: $token;

const unique #tok$1^283.5: $token;

const unique #loc.res_lambda#9#22: $token;

const unique #tok$1^283.15: $token;

const unique #tok$1^282.5: $token;

const unique #tok$1^276.43: $token;

const unique #loc.owns#94: $token;

const unique #loc.staticWrapState#93: $token;

const unique #loc.prestate#95: $token;

const unique #tok$1^276.19: $token;

const unique #loc.owns#91: $token;

const unique #loc.staticWrapState#90: $token;

const unique #loc.prestate#92: $token;

const unique #tok$1^274.3: $token;

const unique #tok$1^273.3: $token;

const unique #loc.owns#88: $token;

const unique #loc.staticWrapState#87: $token;

const unique #loc.prestate#89: $token;

const unique #tok$1^270.9: $token;

const unique #tok$1^268.9: $token;

const unique #tok$1^266.32: $token;

const unique #loc.prestate#86: $token;

const unique #loc.prestate#84: $token;

const unique #loc.owns#85: $token;

const unique #tok$1^263.32: $token;

const unique #tok$1^262.3: $token;

const unique #loc.owns#82: $token;

const unique #loc.staticWrapState#81: $token;

const unique #loc.prestate#83: $token;

const unique #tok$1^261.44: $token;

const unique #tok$1^261.34: $token;

const unique #loc.prestate#80: $token;

const unique #loc.prestate#78: $token;

const unique #loc.owns#79: $token;

const unique #tok$1^259.3: $token;

const unique #tok$1^257.53: $token;

const unique #loc.prestate#77: $token;

const unique #loc.prestate#75: $token;

const unique #loc.owns#76: $token;

const unique #tok$1^256.3: $token;

const unique #tok$1^255.53: $token;

const unique #loc.prestate#74: $token;

const unique #loc.prestate#72: $token;

const unique #loc.owns#73: $token;

const unique #tok$1^254.19: $token;

const unique #loc.prestate#71: $token;

const unique #tok$1^252.3: $token;

const unique #tok$1^246.1: $token;

const unique #tok$1^243.19: $token;

const unique #loc.prestate#70: $token;

const unique #tok$1^240.5: $token;

const unique #loc.res_lambda#8#21: $token;

const unique #tok$1^240.15: $token;

const unique #tok$1^239.5: $token;

const unique #tok$1^233.43: $token;

const unique #loc.owns#68: $token;

const unique #loc.staticWrapState#67: $token;

const unique #loc.prestate#69: $token;

const unique #tok$1^233.19: $token;

const unique #loc.owns#65: $token;

const unique #loc.staticWrapState#64: $token;

const unique #loc.prestate#66: $token;

const unique #tok$1^232.3: $token;

const unique #tok$1^231.3: $token;

const unique #loc.owns#62: $token;

const unique #loc.staticWrapState#61: $token;

const unique #loc.prestate#63: $token;

const unique #tok$1^228.9: $token;

const unique #tok$1^226.9: $token;

const unique #tok$1^224.32: $token;

const unique #loc.prestate#60: $token;

const unique #loc.prestate#58: $token;

const unique #loc.owns#59: $token;

const unique #tok$1^221.5: $token;

const unique #tok$1^219.3: $token;

const unique #loc.owns#56: $token;

const unique #loc.staticWrapState#55: $token;

const unique #loc.prestate#57: $token;

const unique #tok$1^218.43: $token;

const unique #tok$1^218.34: $token;

const unique #loc.prestate#54: $token;

const unique #loc.prestate#52: $token;

const unique #loc.owns#53: $token;

const unique #tok$1^216.3: $token;

const unique #tok$1^214.53: $token;

const unique #loc.prestate#51: $token;

const unique #loc.prestate#49: $token;

const unique #loc.owns#50: $token;

const unique #tok$1^213.3: $token;

const unique #tok$1^212.53: $token;

const unique #loc.prestate#48: $token;

const unique #loc.prestate#46: $token;

const unique #loc.owns#47: $token;

const unique #tok$1^211.19: $token;

const unique #loc.prestate#45: $token;

const unique #loc.y: $token;

const unique #tok$1^209.3: $token;

const unique #tok$1^203.1: $token;

const unique #tok$1^200.19: $token;

const unique #loc.prestate#44: $token;

const unique #tok$1^199.19: $token;

const unique #loc.owns#42: $token;

const unique #loc.staticWrapState#41: $token;

const unique #loc.prestate#43: $token;

const unique #tok$1^198.3: $token;

const unique #tok$1^195.5: $token;

const unique #tok$1^194.27: $token;

const unique #loc.res_lambda#7#20: $token;

const unique #tok$1^194.37: $token;

const unique #loc.owns#39: $token;

const unique #loc.staticWrapState#38: $token;

const unique #loc.prestate#40: $token;

const unique #tok$1^187.41: $token;

const unique #tok$1^187.36: $token;

const unique #loc.prestate#37: $token;

const unique #loc.prestate#35: $token;

const unique #loc.owns#36: $token;

const unique #tok$1^185.7: $token;

const unique #loc.owns#33: $token;

const unique #loc.staticWrapState#32: $token;

const unique #loc.prestate#34: $token;

const unique #tok$1^181.41: $token;

const unique #tok$1^181.36: $token;

const unique #loc.prestate#31: $token;

const unique #loc.prestate#29: $token;

const unique #loc.owns#30: $token;

const unique #tok$1^179.7: $token;

const unique #tok$1^167.3: $token;

axiom $type_code_is(3, ^^object);

const unique #tok$1^168.28: $token;

const unique #tok$1^163.25: $token;

const unique #loc.res_lambda#6#19: $token;

const unique #tok$1^163.41: $token;

const unique #tok$1^159.21: $token;

const unique #loc.prestate#28: $token;

const unique #tok$1^158.21: $token;

const unique #loc.owns#26: $token;

const unique #loc.staticWrapState#25: $token;

const unique #loc.prestate#27: $token;

const unique #tok$1^157.5: $token;

const unique #tok$1^153.5: $token;

const unique #loc.res_lambda#5#18: $token;

const unique #tok$1^153.15: $token;

const unique #tok$1^152.5: $token;

const unique #tok$1^151.5: $token;

const unique #loc.res_lambda#4#17: $token;

const unique #tok$1^151.14: $token;

const unique #tok$1^148.3: $token;

const unique #tok$1^146.3: $token;

const unique #tok$1^146.13: $token;

const unique #tok$1^146.24: $token;

const unique #loc.assign#13: $token;

const unique #loc.assign#12: $token;

const unique #tok$1^144.19: $token;

const unique #loc.prestate#24: $token;

const unique #loc.n: $token;

const unique #tok$1^142.3: $token;

const unique #loc.x: $token;

const unique #tok$1^134.1: $token;

const unique #tok$1^126.13: $token;

const unique #loc.r: $token;

const unique #tok$1^126.3: $token;

const unique #tok$1^122.1: $token;

const unique #tok$1^115.7: $token;

const unique #tok$1^113.7: $token;

const unique #tok$1^108.3: $token;

const unique #tok$1^107.3: $token;

const unique #tok$1^106.3: $token;

const unique #loc.key: $token;

const unique #tok$1^101.1: $token;

const unique #tok$1^97.19: $token;

function $state_to_int(x: $state) : int;

function $int_to_state(x: int) : $state;

axiom (forall #x: $state :: #x == $int_to_state($state_to_int(#x)));

const unique #loc.prestate#23: $token;

const unique #tok$2^0.0: $token;

const unique #file^?3Cno?20file?3E: $token;

axiom $file_name_is(2, #file^?3Cno?20file?3E);

const unique #tok$1^95.5: $token;

const unique #tok$1^94.5: $token;

const unique #loc.res_lambda#3#16: $token;

const unique #tok$1^94.14: $token;

const unique #tok$1^93.5: $token;

function $map_t..ptr_to..^Node.^^bool_to_int(x: $map_t..$ptr_to..^Node.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.^^bool(x: int) : $map_t..$ptr_to..^Node.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.^^bool :: #x == $int_to_map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.^^bool_to_int(#x)));

const unique #loc.res_lambda#1#15: $token;

const unique #loc.res_lambda#2#14: $token;

const unique #tok$1^93.12: $token;

const unique #tok$1^91.3: $token;

const unique #loc.t: $token;

const unique #tok$1^87.1: $token;

const unique #tok$1^49.39: $token;

const unique #tok$1^47.39: $token;

const unique #loc.p: $token;

const unique #tok$1^46.39: $token;

const unique #distTp5: $ctype;

axiom #distTp5 == $ptr_to(^Tree);

const unique #loc._this_: $token;

const unique #tok$1^77.31: $token;

axiom $type_code_is(2, ^^i4);

function $map_t..^^i4.^^i4_to_int(x: $map_t..^^i4.^^i4) : int;

function $int_to_map_t..^^i4.^^i4(x: int) : $map_t..^^i4.^^i4;

axiom (forall #x: $map_t..^^i4.^^i4 :: #x == $int_to_map_t..^^i4.^^i4($map_t..^^i4.^^i4_to_int(#x)));

const unique #distTp4: $ctype;

axiom #distTp4 == $map_t(^^i4, ^^i4);

const unique #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c: $token;

axiom $file_name_is(1, #file^C?3A?5Cdev?5Cfelt?5Cvcc?5CTest?5Ctestsuite?5Cvacid?2D0?5CRedBlackTrees.c);

function $map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool) : int;

function $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool(x: int) : $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool;

axiom (forall #x: $map_t..$ptr_to..^Node.$map_t..$ptr_to..^Node.^^bool :: #x == $int_to_map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool($map_t..ptr_to..^Node.map_t..ptr_to..^Node.^^bool_to_int(#x)));

const unique #distTp3: $ctype;

axiom #distTp3 == $map_t($ptr_to(^Node), $map_t($ptr_to(^Node), ^^bool));

const unique #distTp2: $ctype;

axiom #distTp2 == $map_t($ptr_to(^Node), ^^bool);

const unique #distTp1: $ctype;

axiom #distTp1 == $ptr_to(^Node);
