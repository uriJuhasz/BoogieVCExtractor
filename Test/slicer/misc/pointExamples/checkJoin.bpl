const a : int;
const b : int;
const c : int;
const d : int;
function f(x:int) : int;

procedure p() returns ()
{
	assume d+d==2*d;
	if (d>0)
	{
		assume a==b;
	}else{
		assume f(a)==f(b);
	}
//	assume (f(a)==f(b))==>d+d+d==3*d;
	
	assert f(a)==f(b);
	
}
