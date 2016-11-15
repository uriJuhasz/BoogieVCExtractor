const a1 : int;
const a2 : int;
const a3 : int;
const a4 : int;
function P(x:int,y:int) : bool;

const p1,p2 p3,p4: bool;

procedure p() returns ()
{
	if (p1)
	{
		assume P(a1,a1);
		assume a1==a3;
	}else{
		assume P(a3,a3);
	}
	if (p2)
	{
		assume P(a1,a2);
		assume a1==a3;
	}else{
		assume P(a3,a4);
	}
	if (p3)
	{
		assume P(a2,a1);
		assume a1==a3;
	}else{
		assume P(a4,a3);
	}
	if (p4)
	{
		assume P(a2,a2);
		assume a1==a3;
	}else{
		assume P(a4,a4);
	}
	
	assume (a1==a2 || a1==a3);
}
