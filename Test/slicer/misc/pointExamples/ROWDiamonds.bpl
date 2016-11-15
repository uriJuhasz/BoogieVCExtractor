type ref;
type Heap = [ref]int;

const unique r0 : ref;
const unique r1 : ref;
const unique r2 : ref;

var heap : Heap;

procedure m0()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	assert heap[r0] == 0;
}

procedure m1()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	assert heap[r0] == 0;
}

procedure m2()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	assert heap[r0] == 0;
}

procedure m4()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	assert heap[r0] == 0;
}



procedure m10()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}

	assert heap[r0] == 0;
}

procedure m10h()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}
	assert heap[r0] == 0;

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}
	assert heap[r0] == 0;

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	assert heap[r0] == 0;
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	assert heap[r0] == 0;
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}
	assert heap[r0] == 0;

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}
	assert heap[r0] == 0;

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}
	assert heap[r0] == 0;

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	assert heap[r0] == 0;
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	assert heap[r0] == 0;
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}

	assert heap[r0] == 0;
}




procedure m40()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}

		heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}

		heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}

	
	
	assert heap[r0] == 0;
}




procedure m20()
	modifies heap;
{
	heap[r0] := 0;
	heap[r1] := 1;
	heap[r2] := 2;
	
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}
	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 1;
	}else
	{
		heap[r2] := 1;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 2;
	}else
	{
		heap[r2] := 2;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 3;
	}else
	{
		heap[r2] := 3;
	}
	if (*)
	{
		heap[r1] := 4;
	}else
	{
		heap[r2] := 4;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 5;
	}else
	{
		heap[r2] := 5;
	}

	heap[r1] := 1;
	if (*)
	{
		heap[r1] := 6;
	}else
	{
		heap[r2] := 6;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 7;
	}else
	{
		heap[r2] := 7;
	}

	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 8;
	}else
	{
		heap[r2] := 8;
	}
	if (*)
	{
		heap[r1] := 9;
	}else
	{
		heap[r2] := 9;
	}
	heap[r2] := 1;
	if (*)
	{
		heap[r1] := 10;
	}else
	{
		heap[r2] := 10;
	}
	
	assert heap[r0] == 0;
}
