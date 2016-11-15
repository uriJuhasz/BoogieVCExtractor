const a : int;
const b : int;
const c : int;
const d : int;
function P(x:int,y:int) : bool;

const p1,p2 : bool;

procedure p() returns ()
{
	if (p1)
	{
		assume a==b;
		assume c==d;
		assume P(a,a)==true;
		assume P(a,d)==true;
		assume P(d,a)==true;
		assume P(d,d)==true;
	}else{
		assume a==c;
		assume b==d;
		assume P(c,c)==true;
		assume P(c,b)==true;
		assume P(b,c)==true;
		assume P(b,b)==true;
	}
	if (p2)
	{
		assert P(a,b)==true;
	}else{
		assert P(b,a)==true;
	}
	assert P(a,c)==true;
}
