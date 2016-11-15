const a1 : int;
const a2 : int;
const a3 : int;
const a4 : int;
const a5 : int;
const a6 : int;
const a7 : int;
const a8 : int;
const a9 : int;
function P(x:int,y:int,z:int) : bool;

const p1,p2 : bool;

procedure p() returns ()
{
	if (p1)
	{
		assume a1==a2;
		assume a2==a3;
		assume a4==a5;
		assume a5==a6;
		assume a7==a8;
		assume a8==a9;
		assume P(a1,a1,a1)==true;
		assume P(a1,a1,a3)==true;
		assume P(a1,a1,a5)==true;
		assume P(a1,a3,a1)==true;
		assume P(a1,a3,a3)==true;
		assume P(a1,a3,a5)==true;
		assume P(a1,a5,a1)==true;
		assume P(a1,a5,a3)==true;
		assume P(a1,a5,a5)==true;
		assume P(a3,a1,a1)==true;
		assume P(a3,a1,a3)==true;
		assume P(a3,a1,a5)==true;
		assume P(a3,a3,a1)==true;
		assume P(a3,a3,a3)==true;
		assume P(a3,a3,a5)==true;
		assume P(a3,a5,a1)==true;
		assume P(a3,a5,a3)==true;
		assume P(a3,a5,a5)==true;
		assume P(a5,a1,a1)==true;
		assume P(a5,a1,a3)==true;
		assume P(a5,a1,a5)==true;
		assume P(a5,a3,a1)==true;
		assume P(a5,a3,a3)==true;
		assume P(a5,a3,a5)==true;
		assume P(a5,a5,a1)==true;
		assume P(a5,a5,a3)==true;
		assume P(a5,a5,a5)==true;
	}else{
		assume a1==a4;
		assume a4==a7;
		assume a2==a5;
		assume a5==a8;
		assume a3==a6;
		assume a6==a9;
		assume P(a1,a1,a1)==true;
		assume P(a1,a1,a2)==true;
		assume P(a1,a1,a3)==true;
		assume P(a1,a2,a1)==true;
		assume P(a1,a2,a2)==true;
		assume P(a1,a2,a3)==true;
		assume P(a1,a3,a1)==true;
		assume P(a1,a3,a2)==true;
		assume P(a1,a3,a3)==true;
		assume P(a2,a1,a1)==true;
		assume P(a2,a1,a2)==true;
		assume P(a2,a1,a3)==true;
		assume P(a2,a2,a1)==true;
		assume P(a2,a2,a2)==true;
		assume P(a2,a2,a3)==true;
		assume P(a2,a3,a1)==true;
		assume P(a2,a3,a2)==true;
		assume P(a2,a3,a3)==true;
		assume P(a3,a1,a1)==true;
		assume P(a3,a1,a2)==true;
		assume P(a3,a1,a3)==true;
		assume P(a3,a2,a1)==true;
		assume P(a3,a2,a2)==true;
		assume P(a3,a2,a3)==true;
		assume P(a3,a3,a1)==true;
		assume P(a3,a3,a2)==true;
		assume P(a3,a3,a3)==true;
	}
	if (p2)
	{
		assume a1==a2;
		assume a2==a3;
		assume a3==a4;
		assume a4==a5;
		assume a5==a6;
		assume a6==a7;
		assume a7==a8;
		assume a8==a9;
		assert P(a1,a2,a3)==true;
	}else{
		assert P(a1,a2,a3)==true;
	}
		assert P(a1,a2,a3)==true;
}
